Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AD527BE93
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Sep 2020 09:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbgI2H5T (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 29 Sep 2020 03:57:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44428 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbgI2H4y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 29 Sep 2020 03:56:54 -0400
Date:   Tue, 29 Sep 2020 07:56:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601366211;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nkfvfq27Lho2C6RthcC2BpqPB6KAiKHK59lFZbzqO/Q=;
        b=OgjqTJPO9A01vWXuTLsqZQtt1s4yZi2Fn2+P7ZxKCPpEb47Qtw3AmuQS52j7KtgWkkcDyn
        3IpSCzEiPyYzZZ6WPkbOq/vI6o1mh7Onjd5bPs5T0gHWlq3YnFFKYQtsQ2jaIl8qc3JWvM
        RlLkK+WFZPTTvbdtM91ZBIhxNJ54k812EdIxlGv6qVuh31oBk4l8KEPOVup8G/ku7acmnV
        f8ZwstBEFlsTGM9BVuFofJC2CX0+K9OE9zPNW7YChyfvVW/iQIhomeC/XgtWRaQDgbj6LB
        4nR9Pc+cgrnMmoQUFxTzcSiY0zwtYIlScEPW49XLyYArq034fF+sxa3RqTc3wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601366211;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nkfvfq27Lho2C6RthcC2BpqPB6KAiKHK59lFZbzqO/Q=;
        b=z+1OmVVAqROQBA0+y3tRxf8hiy29/gCVlOOHeeNUterLuyTEG7XcdHRwdu6eOgDHpsMWf/
        A1u4b6huzknnczDQ==
From:   "tip-bot2 for Xianting Tian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove the force parameter of
 update_tg_load_avg()
Cc:     Xianting Tian <tian.xianting@h3c.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200924014755.36253-1-tian.xianting@h3c.com>
References: <20200924014755.36253-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Message-ID: <160136621044.7002.9573311648356113441.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fe7491580d7c56152ea8d9d3124201191617435d
Gitweb:        https://git.kernel.org/tip/fe7491580d7c56152ea8d9d3124201191617435d
Author:        Xianting Tian <tian.xianting@h3c.com>
AuthorDate:    Thu, 24 Sep 2020 09:47:55 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Sep 2020 14:23:25 +02:00

sched/fair: Remove the force parameter of update_tg_load_avg()

In the file fair.c, sometims update_tg_load_avg(cfs_rq, 0) is used,
sometimes update_tg_load_avg(cfs_rq, false) is used.
update_tg_load_avg() has the parameter force, but in current code,
it never set 1 or true to it, so remove the force parameter.

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200924014755.36253-1-tian.xianting@h3c.com
---
 kernel/sched/fair.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9613e5d..b56276a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -831,7 +831,7 @@ void init_entity_runnable_average(struct sched_entity *se)
 void post_init_entity_util_avg(struct task_struct *p)
 {
 }
-static void update_tg_load_avg(struct cfs_rq *cfs_rq, int force)
+static void update_tg_load_avg(struct cfs_rq *cfs_rq)
 {
 }
 #endif /* CONFIG_SMP */
@@ -3293,7 +3293,6 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
 /**
  * update_tg_load_avg - update the tg's load avg
  * @cfs_rq: the cfs_rq whose avg changed
- * @force: update regardless of how small the difference
  *
  * This function 'ensures': tg->load_avg := \Sum tg->cfs_rq[]->avg.load.
  * However, because tg->load_avg is a global value there are performance
@@ -3305,7 +3304,7 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
  *
  * Updating tg's load_avg is necessary before update_cfs_share().
  */
-static inline void update_tg_load_avg(struct cfs_rq *cfs_rq, int force)
+static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 {
 	long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
 
@@ -3315,7 +3314,7 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq, int force)
 	if (cfs_rq->tg == &root_task_group)
 		return;
 
-	if (force || abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
+	if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
 		atomic_long_add(delta, &cfs_rq->tg->load_avg);
 		cfs_rq->tg_load_avg_contrib = cfs_rq->avg.load_avg;
 	}
@@ -3617,7 +3616,7 @@ static inline bool skip_blocked_update(struct sched_entity *se)
 
 #else /* CONFIG_FAIR_GROUP_SCHED */
 
-static inline void update_tg_load_avg(struct cfs_rq *cfs_rq, int force) {}
+static inline void update_tg_load_avg(struct cfs_rq *cfs_rq) {}
 
 static inline int propagate_entity_load_avg(struct sched_entity *se)
 {
@@ -3805,13 +3804,13 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		 * IOW we're enqueueing a task on a new CPU.
 		 */
 		attach_entity_load_avg(cfs_rq, se);
-		update_tg_load_avg(cfs_rq, 0);
+		update_tg_load_avg(cfs_rq);
 
 	} else if (decayed) {
 		cfs_rq_util_change(cfs_rq, 0);
 
 		if (flags & UPDATE_TG)
-			update_tg_load_avg(cfs_rq, 0);
+			update_tg_load_avg(cfs_rq);
 	}
 }
 
@@ -7898,7 +7897,7 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
 		struct sched_entity *se;
 
 		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
-			update_tg_load_avg(cfs_rq, 0);
+			update_tg_load_avg(cfs_rq);
 
 			if (cfs_rq == &rq->cfs)
 				decayed = true;
@@ -10797,7 +10796,7 @@ static void detach_entity_cfs_rq(struct sched_entity *se)
 	/* Catch up with the cfs_rq and remove our load when we leave */
 	update_load_avg(cfs_rq, se, 0);
 	detach_entity_load_avg(cfs_rq, se);
-	update_tg_load_avg(cfs_rq, false);
+	update_tg_load_avg(cfs_rq);
 	propagate_entity_cfs_rq(se);
 }
 
@@ -10816,7 +10815,7 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
 	/* Synchronize entity with its cfs_rq */
 	update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
 	attach_entity_load_avg(cfs_rq, se);
-	update_tg_load_avg(cfs_rq, false);
+	update_tg_load_avg(cfs_rq);
 	propagate_entity_cfs_rq(se);
 }
 
