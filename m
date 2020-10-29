Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E341A29E99C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgJ2Kw0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgJ2Kvw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEEAC0613CF;
        Thu, 29 Oct 2020 03:51:51 -0700 (PDT)
Date:   Thu, 29 Oct 2020 10:51:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603968710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=N07ynMYor+HVatQGnEApC3+wDCUMaU57/h55OSj6oDA=;
        b=XV2HsGCoMDBz4YNxrV0puKHlJkfKAlDr1WDkUwZxksiz6ViBU3OsihpfMEPwAk3DQtpoHh
        GnLtMSOhlJ1TNJCPnXkdEDdGtKMrpZw3Wo9UUhl/KGFsZRzYKdg1j2PIAA6aU9j6gIQBUx
        HilB7yCNV4TyRiJ6AiOOUoFssAeWUblYd+B2Cc676udqWMeS2x0LeebfL6W9gj2CQO/LK6
        9mXUfi5WVN+hzoy2L5KHrmbc1jQzYKqvVLZPF2G4it2Pe9YPzd4KHSpC/P6/iUSvgxFlAl
        hukAIjlxnwLdPQ01fnHl3bptISn9mhB2GoVMloi9BqW28W6aADeGFltJyybumw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603968710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=N07ynMYor+HVatQGnEApC3+wDCUMaU57/h55OSj6oDA=;
        b=IZrqsNegpLxDLKfY8YIesuqrU6bZT/o59C51LOGTcIOYC5IJX6qwMwSBO1Org++9biWkfW
        kgeDRwolRNwwz/AA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/cpupri: Remap CPUPRI_NORMAL to MAX_RT_PRIO-1
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160396870929.397.16424384279683865143.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     934fc3314b39e16a89fc4d5d0d5cbfe71dcbe7b1
Gitweb:        https://git.kernel.org/tip/934fc3314b39e16a89fc4d5d0d5cbfe71dcbe7b1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 14 Oct 2020 21:06:49 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Oct 2020 11:00:30 +01:00

sched/cpupri: Remap CPUPRI_NORMAL to MAX_RT_PRIO-1

This makes the mapping continuous and frees up 100 for other usage.

Prev mapping:

p->rt_priority   p->prio   newpri   cpupri

                               -1       -1 (CPUPRI_INVALID)

                              100        0 (CPUPRI_NORMAL)

             1        98       98        1
           ...
            49        50       50       49
            50        49       49       50
           ...
            99         0        0       99

New mapping:

p->rt_priority   p->prio   newpri   cpupri

                               -1       -1 (CPUPRI_INVALID)

                               99        0 (CPUPRI_NORMAL)

             1        98       98        1
           ...
            49        50       50       49
            50        49       49       50
           ...
            99         0        0       99

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/cpupri.c | 34 +++++++++++++++++++++++++++-------
 kernel/sched/rt.c     | 16 +++++++++-------
 2 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index 8d9952a..e434910 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -24,17 +24,37 @@
  */
 #include "sched.h"
 
-/* Convert between a 140 based task->prio, and our 100 based cpupri */
+/*
+ * p->rt_priority   p->prio   newpri   cpupri
+ *
+ *				  -1       -1 (CPUPRI_INVALID)
+ *
+ *				  99        0 (CPUPRI_NORMAL)
+ *
+ *		1        98       98        1
+ *	      ...
+ *	       49        50       50       49
+ *	       50        49       49       50
+ *	      ...
+ *	       99         0        0       99
+ */
 static int convert_prio(int prio)
 {
 	int cpupri;
 
-	if (prio == CPUPRI_INVALID)
-		cpupri = CPUPRI_INVALID;
-	else if (prio >= MAX_RT_PRIO)
-		cpupri = CPUPRI_NORMAL;
-	else
-		cpupri = MAX_RT_PRIO - prio - 1;
+	switch (prio) {
+	case CPUPRI_INVALID:
+		cpupri = CPUPRI_INVALID;	/* -1 */
+		break;
+
+	case 0 ... 98:
+		cpupri = MAX_RT_PRIO-1 - prio;	/* 1 ... 99 */
+		break;
+
+	case MAX_RT_PRIO-1:
+		cpupri = CPUPRI_NORMAL;		/*  0 */
+		break;
+	}
 
 	return cpupri;
 }
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 49ec096..8a3b1ba 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -89,8 +89,8 @@ void init_rt_rq(struct rt_rq *rt_rq)
 	__set_bit(MAX_RT_PRIO, array->bitmap);
 
 #if defined CONFIG_SMP
-	rt_rq->highest_prio.curr = MAX_RT_PRIO;
-	rt_rq->highest_prio.next = MAX_RT_PRIO;
+	rt_rq->highest_prio.curr = MAX_RT_PRIO-1;
+	rt_rq->highest_prio.next = MAX_RT_PRIO-1;
 	rt_rq->rt_nr_migratory = 0;
 	rt_rq->overloaded = 0;
 	plist_head_init(&rt_rq->pushable_tasks);
@@ -161,7 +161,7 @@ void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
 {
 	struct rq *rq = cpu_rq(cpu);
 
-	rt_rq->highest_prio.curr = MAX_RT_PRIO;
+	rt_rq->highest_prio.curr = MAX_RT_PRIO-1;
 	rt_rq->rt_nr_boosted = 0;
 	rt_rq->rq = rq;
 	rt_rq->tg = tg;
@@ -393,8 +393,9 @@ static void dequeue_pushable_task(struct rq *rq, struct task_struct *p)
 		p = plist_first_entry(&rq->rt.pushable_tasks,
 				      struct task_struct, pushable_tasks);
 		rq->rt.highest_prio.next = p->prio;
-	} else
-		rq->rt.highest_prio.next = MAX_RT_PRIO;
+	} else {
+		rq->rt.highest_prio.next = MAX_RT_PRIO-1;
+	}
 }
 
 #else
@@ -1147,8 +1148,9 @@ dec_rt_prio(struct rt_rq *rt_rq, int prio)
 				sched_find_first_bit(array->bitmap);
 		}
 
-	} else
-		rt_rq->highest_prio.curr = MAX_RT_PRIO;
+	} else {
+		rt_rq->highest_prio.curr = MAX_RT_PRIO-1;
+	}
 
 	dec_rt_prio_smp(rt_rq, prio, prev_prio);
 }
