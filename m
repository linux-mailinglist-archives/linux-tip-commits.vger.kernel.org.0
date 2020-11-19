Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8132B8F9A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Nov 2020 11:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgKSJz3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Nov 2020 04:55:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60910 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgKSJzJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Nov 2020 04:55:09 -0500
Date:   Thu, 19 Nov 2020 09:55:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605779706;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FZqFtrbW1CxOM1QLOPCw6rLwkvmTpmJbSlmIK4cFhw0=;
        b=NpGiQtM0ApUMshYDhAnFdOtV4oqyceXIdDf8002sCS9l9IlcyK96Oluh5jve/+/ADPX8wN
        sf8Czw1nJiB+m/mc8FV0Vs7CyVgZ43FgcdO81gBAlipBIAwGhTmGPlDGBadP4EtT/UycUu
        oEdfS3S7tNoob/tNe+qbn6mqHN0dCjRNY7S6jmoOEkpWJfbKmrMNV63m21cYUMqCbEK37W
        EZkWVg6RnKwFykhdhVN67M6iv62rpnQXwh6le2jX/DKvvA2D4SyiTDxUdPPHm991jrOC8W
        Tur0kbeFQ2oY3Dklvsq+v9U8peCZbhuPfq4HN1DH0wdSEI+KT83NH9h4UYpXMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605779706;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FZqFtrbW1CxOM1QLOPCw6rLwkvmTpmJbSlmIK4cFhw0=;
        b=A/R2K0lZJXsPwR/oe06s9LVIj3Wz24wLSv1O74HXTcJqBB9tXGBZjmJ9QhlG/hUa8OHgkc
        UIJUY0SEtLDQ8bBg==
From:   "tip-bot2 for Quentin Perret" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix overutilized update in
 enqueue_task_fair()
Cc:     Rick Yiu <rickyiu@google.com>, Quentin Perret <qperret@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201112111201.2081902-1-qperret@google.com>
References: <20201112111201.2081902-1-qperret@google.com>
MIME-Version: 1.0
Message-ID: <160577970580.11244.5953208218538500896.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     8e1ac4299a6e8726de42310d9c1379f188140c71
Gitweb:        https://git.kernel.org/tip/8e1ac4299a6e8726de42310d9c1379f188140c71
Author:        Quentin Perret <qperret@google.com>
AuthorDate:    Thu, 12 Nov 2020 11:12:01 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 17 Nov 2020 13:15:27 +01:00

sched/fair: Fix overutilized update in enqueue_task_fair()

enqueue_task_fair() attempts to skip the overutilized update for new
tasks as their util_avg is not accurate yet. However, the flag we check
to do so is overwritten earlier on in the function, which makes the
condition pretty much a nop.

Fix this by saving the flag early on.

Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point indicator")
Reported-by: Rick Yiu <rickyiu@google.com>
Signed-off-by: Quentin Perret <qperret@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20201112111201.2081902-1-qperret@google.com
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8e563cf..56a8ca9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5477,6 +5477,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 	int idle_h_nr_running = task_has_idle_policy(p);
+	int task_new = !(flags & ENQUEUE_WAKEUP);
 
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
@@ -5549,7 +5550,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 * into account, but that is not straightforward to implement,
 	 * and the following generally works well enough in practice.
 	 */
-	if (flags & ENQUEUE_WAKEUP)
+	if (!task_new)
 		update_overutilized_status(rq);
 
 enqueue_throttle:
