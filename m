Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2C9346268
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Mar 2021 16:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhCWPJY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 23 Mar 2021 11:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbhCWPJF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 23 Mar 2021 11:09:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D297C061763;
        Tue, 23 Mar 2021 08:09:04 -0700 (PDT)
Date:   Tue, 23 Mar 2021 15:08:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616512137;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ARHa8gpU9B77j/k8U6moQMTkidbCHbkbQPl9F3msYc=;
        b=Vl/Ll0ZctqyKjIEbN/tIw/u+iSztchGDHaYaFfEXF6p1brGYk+t53DvSRk9P/EjdHpxoTM
        RkC3QpCNs5TOEc0lPN6h3Mwt1M1vn0GxQ63RhUzkj1wNtwXK+SKBUdvstdVpmugCWX5Yri
        sDn+4ukEjqti1b2l3J99uKbAiBSr8GuWLcC8hbfdqw3FFiskfyzmIjFFnYb1yrBkorgEzo
        Slk5iaBZITfqdc7whr1P6FNGXDh+IZJlA7ZvBiSIliZ63jNXlj7/v033XPfHcrP5Gs93se
        pRZAUYjbkkPJ8/CH/0r7axRc1nYGowXHP5H9K1PiC+j4c+toIUZxCx3zlIdZBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616512137;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ARHa8gpU9B77j/k8U6moQMTkidbCHbkbQPl9F3msYc=;
        b=ROT33VLVgWMON74GBjfukGytz7GtfbAmw0fZbWsN+19cJPWAygNpuKKk663fKiijY2TSRH
        i4iCcuVVvysHO9AA==
From:   "tip-bot2 for Aubrey Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Reduce long-tail newly idle balance cost
Cc:     Aubrey Li <aubrey.li@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1614154549-116078-1-git-send-email-aubrey.li@intel.com>
References: <1614154549-116078-1-git-send-email-aubrey.li@intel.com>
MIME-Version: 1.0
Message-ID: <161651213645.398.4816489988541907975.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     acb4decc1e900468d51b33c5f1ee445278e716a7
Gitweb:        https://git.kernel.org/tip/acb4decc1e900468d51b33c5f1ee445278e716a7
Author:        Aubrey Li <aubrey.li@intel.com>
AuthorDate:    Wed, 24 Feb 2021 16:15:49 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 23 Mar 2021 16:01:59 +01:00

sched/fair: Reduce long-tail newly idle balance cost

A long-tail load balance cost is observed on the newly idle path,
this is caused by a race window between the first nr_running check
of the busiest runqueue and its nr_running recheck in detach_tasks.

Before the busiest runqueue is locked, the tasks on the busiest
runqueue could be pulled by other CPUs and nr_running of the busiest
runqueu becomes 1 or even 0 if the running task becomes idle, this
causes detach_tasks breaks with LBF_ALL_PINNED flag set, and triggers
load_balance redo at the same sched_domain level.

In order to find the new busiest sched_group and CPU, load balance will
recompute and update the various load statistics, which eventually leads
to the long-tail load balance cost.

This patch clears LBF_ALL_PINNED flag for this race condition, and hence
reduces the long-tail cost of newly idle balance.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/1614154549-116078-1-git-send-email-aubrey.li@intel.com
---
 kernel/sched/fair.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aaa0dfa..6d73bdb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7687,6 +7687,15 @@ static int detach_tasks(struct lb_env *env)
 
 	lockdep_assert_held(&env->src_rq->lock);
 
+	/*
+	 * Source run queue has been emptied by another CPU, clear
+	 * LBF_ALL_PINNED flag as we will not test any task.
+	 */
+	if (env->src_rq->nr_running <= 1) {
+		env->flags &= ~LBF_ALL_PINNED;
+		return 0;
+	}
+
 	if (env->imbalance <= 0)
 		return 0;
 
