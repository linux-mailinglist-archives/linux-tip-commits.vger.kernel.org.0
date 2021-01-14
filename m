Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FC32F5FF6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Jan 2021 12:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbhANL3t (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Jan 2021 06:29:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58938 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbhANL3t (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Jan 2021 06:29:49 -0500
Date:   Thu, 14 Jan 2021 11:29:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610623746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gAQ0zglX2I4iddRx+vXmR26foDU/1xu0MN7Lo3Ndoq0=;
        b=XpzZhafvEEhrgRpSU1+V/5CsGMAk3JNdfTsFqmzML9hTSZTW4R6JMrG2O4R5sMTEsbWZFW
        y7QpMhoTGvyqNigsir27Xzb5UXt/H6hWHhmw+ZlJk/P4iraMrpG0y2ZuppcEkv5xPgD3rB
        RavyKFjjcdcYxQegYJAIPoBdudftIxrv1wrgptx5egml+3fUPQFxhJRVabTUdyuOZn0M9p
        YavwRwd5Vx1xw/s0QJAkyKpbPUM/vup9SEsuDtCZk91sPbXxGCUqcUsdvnajbXhbkInzsm
        xrevRVVgXDk+Lb4en/PEuVQ4/RO/rKqgMbDO2mWhIn8wHcVltku6KhYbYzsJtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610623746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gAQ0zglX2I4iddRx+vXmR26foDU/1xu0MN7Lo3Ndoq0=;
        b=0+Mtg1HW2/QWlKh8rV4yuC7XPfobiYDHdov19X1Nn6PYSzbWi2hCLKoGOj2WHNo3Nh0z5N
        +I6cMdfMi1NOYjCw==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Don't set LBF_ALL_PINNED unnecessarily
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210107103325.30851-3-vincent.guittot@linaro.org>
References: <20210107103325.30851-3-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <161062374587.414.798453801576383250.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8a41dfcda7a32ed4435c00d98a9dc7156b08b671
Gitweb:        https://git.kernel.org/tip/8a41dfcda7a32ed4435c00d98a9dc7156b08b671
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Thu, 07 Jan 2021 11:33:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Jan 2021 11:20:11 +01:00

sched/fair: Don't set LBF_ALL_PINNED unnecessarily

Setting LBF_ALL_PINNED during active load balance is only valid when there
is only 1 running task on the rq otherwise this ends up increasing the
balance interval whereas other tasks could migrate after the next interval
once they become cache-cold as an example.

LBF_ALL_PINNED flag is now always set it by default. It is then cleared
when we find one task that can be pulled when calling detach_tasks() or
during active migration.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lkml.kernel.org/r/20210107103325.30851-3-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 13de7ae..48f99c8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9639,6 +9639,8 @@ redo:
 	env.src_rq = busiest;
 
 	ld_moved = 0;
+	/* Clear this flag as soon as we find a pullable task */
+	env.flags |= LBF_ALL_PINNED;
 	if (busiest->nr_running > 1) {
 		/*
 		 * Attempt to move tasks. If find_busiest_group has found
@@ -9646,7 +9648,6 @@ redo:
 		 * still unbalanced. ld_moved simply stays zero, so it is
 		 * correctly treated as an imbalance.
 		 */
-		env.flags |= LBF_ALL_PINNED;
 		env.loop_max  = min(sysctl_sched_nr_migrate, busiest->nr_running);
 
 more_balance:
@@ -9772,10 +9773,12 @@ more_balance:
 			if (!cpumask_test_cpu(this_cpu, busiest->curr->cpus_ptr)) {
 				raw_spin_unlock_irqrestore(&busiest->lock,
 							    flags);
-				env.flags |= LBF_ALL_PINNED;
 				goto out_one_pinned;
 			}
 
+			/* Record that we found at least one task that could run on this_cpu */
+			env.flags &= ~LBF_ALL_PINNED;
+
 			/*
 			 * ->active_balance synchronizes accesses to
 			 * ->active_balance_work.  Once set, it's cleared
