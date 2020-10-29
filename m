Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F9129E98B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgJ2Kvw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:51:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60798 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgJ2Kvv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:51 -0400
Date:   Thu, 29 Oct 2020 10:51:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603968709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LtGwUNAg9l8QQqymQwk36EBNM7XO/J3NSOQOlG06k8E=;
        b=cv2l35b9NhjlJ+QtQ6nFzQbjHY6yhseCvsonD9ejfaCyQihgVCZQIIInd89+TV+QX7WGVU
        v5r8+SFeAuKBH0Bw9AxsEbfT3xU5hDPv6o6W0HjjD2si6qFnylOwb0g030haDHMRt+s6bD
        50rEsAHOV/V7ZVjoyiBteDyiWk0VgoQTdz1+GNl0/mayNPwhAsVoB246Wi7lZyUbtB+bD3
        WuZFXoQT7HX9KXAOLEhpiJ4JH2/WjUR8msgFUx/Fn30x0BcmKVrH/ebpOADrPfTrgWRg6L
        LbCPdb5KpoibnOmTQu/zbj4XUIQn/dijyKQV0X19SHyMji4gHdUdISnR+jXx8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603968709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LtGwUNAg9l8QQqymQwk36EBNM7XO/J3NSOQOlG06k8E=;
        b=IXYMzEN6WtSo81z8j8X9ZqnI5ACikweNvAZQX9cr9ltaDZ8Lzf4v505ecm3m8u7UUOfq5K
        Z0OFYPkbmG/KXIBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/cpupri: Add CPUPRI_HIGHER
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160396870869.397.14063113316376338375.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b13772f8135633f273f0cf742143b19cffbf9e1d
Gitweb:        https://git.kernel.org/tip/b13772f8135633f273f0cf742143b19cffbf9e1d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 14 Oct 2020 21:39:04 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Oct 2020 11:00:30 +01:00

sched/cpupri: Add CPUPRI_HIGHER

Add CPUPRI_HIGHER above the RT99 priority to denote the CPU is in use
by higher priority tasks (specifically deadline).

XXX: we should probably drive PUSH-PULL from cpupri, that would
automagically result in an RT-PUSH when DL sets cpupri to CPUPRI_HIGHER.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/cpupri.c   | 12 +++++++++---
 kernel/sched/cpupri.h   |  3 ++-
 kernel/sched/deadline.c |  3 +++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index e434910..9ca0835 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -11,7 +11,7 @@
  *  This code tracks the priority of each CPU so that global migration
  *  decisions are easy to calculate.  Each CPU can be in a state as follows:
  *
- *                 (INVALID), NORMAL, RT1, ... RT99
+ *                 (INVALID), NORMAL, RT1, ... RT99, HIGHER
  *
  *  going from the lowest priority to the highest.  CPUs in the INVALID state
  *  are not eligible for routing.  The system maintains this state with
@@ -19,7 +19,7 @@
  *  in that class).  Therefore a typical application without affinity
  *  restrictions can find a suitable CPU with O(1) complexity (e.g. two bit
  *  searches).  For tasks with affinity restrictions, the algorithm has a
- *  worst case complexity of O(min(100, nr_domcpus)), though the scenario that
+ *  worst case complexity of O(min(101, nr_domcpus)), though the scenario that
  *  yields the worst case search is fairly contrived.
  */
 #include "sched.h"
@@ -37,6 +37,8 @@
  *	       50        49       49       50
  *	      ...
  *	       99         0        0       99
+ *
+ *				 100	  100 (CPUPRI_HIGHER)
  */
 static int convert_prio(int prio)
 {
@@ -54,6 +56,10 @@ static int convert_prio(int prio)
 	case MAX_RT_PRIO-1:
 		cpupri = CPUPRI_NORMAL;		/*  0 */
 		break;
+
+	case MAX_RT_PRIO:
+		cpupri = CPUPRI_HIGHER;		/* 100 */
+		break;
 	}
 
 	return cpupri;
@@ -195,7 +201,7 @@ int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
  * cpupri_set - update the CPU priority setting
  * @cp: The cpupri context
  * @cpu: The target CPU
- * @newpri: The priority (INVALID-RT99) to assign to this CPU
+ * @newpri: The priority (INVALID,NORMAL,RT1-RT99,HIGHER) to assign to this CPU
  *
  * Note: Assumes cpu_rq(cpu)->lock is locked
  *
diff --git a/kernel/sched/cpupri.h b/kernel/sched/cpupri.h
index e28e1ed..d6cba00 100644
--- a/kernel/sched/cpupri.h
+++ b/kernel/sched/cpupri.h
@@ -1,10 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-#define CPUPRI_NR_PRIORITIES	MAX_RT_PRIO
+#define CPUPRI_NR_PRIORITIES	(MAX_RT_PRIO+1)
 
 #define CPUPRI_INVALID		-1
 #define CPUPRI_NORMAL		 0
 /* values 1-99 are for RT1-RT99 priorities */
+#define CPUPRI_HIGHER		100
 
 struct cpupri_vec {
 	atomic_t		count;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0f75e95..0b45dd1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1394,6 +1394,8 @@ static void inc_dl_deadline(struct dl_rq *dl_rq, u64 deadline)
 
 	if (dl_rq->earliest_dl.curr == 0 ||
 	    dl_time_before(deadline, dl_rq->earliest_dl.curr)) {
+		if (dl_rq->earliest_dl.curr == 0)
+			cpupri_set(&rq->rd->cpupri, rq->cpu, CPUPRI_HIGHER);
 		dl_rq->earliest_dl.curr = deadline;
 		cpudl_set(&rq->rd->cpudl, rq->cpu, deadline);
 	}
@@ -1411,6 +1413,7 @@ static void dec_dl_deadline(struct dl_rq *dl_rq, u64 deadline)
 		dl_rq->earliest_dl.curr = 0;
 		dl_rq->earliest_dl.next = 0;
 		cpudl_clear(&rq->rd->cpudl, rq->cpu);
+		cpupri_set(&rq->rd->cpupri, rq->cpu, rq->rt.highest_prio.curr);
 	} else {
 		struct rb_node *leftmost = dl_rq->root.rb_leftmost;
 		struct sched_dl_entity *entry;
