Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1FE29E997
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgJ2KwN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:52:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60756 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgJ2Kvw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:52 -0400
Date:   Thu, 29 Oct 2020 10:51:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603968711;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fnX4T+Yu+tpptypCpXVJawwc6puGWhEcbA1bI1Ml53s=;
        b=yh0fwPddMvhUsDxktJVf5MmiwymvuPZ51UJADcLv02urGSjQ1e4lQVMZMeYow9KCKqQwh2
        yMJJQirSicQ6iVmnB4I79gfoCzt7Ki2Da1/qiMKpnPdiw8nri48Jb6Ot+rSrB2upJNE/4t
        wtBxOmSkkq5UKiBBTvBtdUnFDR3+noQt3HJW1a0p8qL7loAa6OHeYyjXr472S0+zuwCU9n
        GujhbZU6JsZPZuyRAL6X02PNsVZcrXg9xz5UJ2vrsN7XMWHS2SeIyaDbeLMQdujt8H6vJ+
        YQA1vyYgM/vZir0q+fJJTAuOWXN7rC0Guc27TdD+4CZ/97kKSROL5CEQazQaqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603968711;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fnX4T+Yu+tpptypCpXVJawwc6puGWhEcbA1bI1Ml53s=;
        b=QNEsP7NJGZZy1qYKllPjXyhi6Md8ZaFXIKtHfKdchGxWPZyN0POC9EoO0EYMJyvYJXdZPT
        4jw9KQ8m2f/9LeDA==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/cpupri: Remove pri_to_cpu[CPUPRI_IDLE]
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200922083934.19275-2-dietmar.eggemann@arm.com>
References: <20200922083934.19275-2-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <160396871056.397.17031098897920284601.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5e054bca44fe92323de5e9b71478d1904b8bb1b7
Gitweb:        https://git.kernel.org/tip/5e054bca44fe92323de5e9b71478d1904b8bb1b7
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Tue, 22 Sep 2020 10:39:33 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Oct 2020 11:00:29 +01:00

sched/cpupri: Remove pri_to_cpu[CPUPRI_IDLE]

pri_to_cpu[CPUPRI_IDLE=0] isn't used since cpupri_set(..., newpri) is
never called with newpri = MAX_PRIO (140).

Current mapping:

p->rt_priority   p->prio   newpri   cpupri

                               -1       -1 (CPUPRI_INVALID)

                              140        0 (CPUPRI_IDLE)

                              100        1 (CPUPRI_NORMAL)

             1        98       98        3
           ...
            49        50       50       51
            50        49       49       52
           ...
            99         0        0      101

Even when cpupri was introduced with commit 6e0534f27819 ("sched: use a
2-d bitmap for searching lowest-pri CPU") in v2.6.27, only

   (1) CPUPRI_INVALID (-1),
   (2) MAX_RT_PRIO (100),
   (3) an RT prio (RT1..RT99)

were used as newprio in cpupri_set(..., newpri) -> convert_prio(newpri).

MAX_RT_PRIO is used only in dec_rt_tasks() -> dec_rt_prio() ->
dec_rt_prio_smp() -> cpupri_set() in case of !rt_rq->rt_nr_running.
I.e. it stands for a non-rt task, including the IDLE task.

Commit 57785df5ac53 ("sched: Fix task priority bug") removed code in
v2.6.33 which did set the priority of the IDLE task to MAX_PRIO.
Although this happened after the introduction of cpupri, it didn't have
an effect on the values used for cpupri_set(..., newpri).

Remove CPUPRI_IDLE and adapt the cpupri implementation accordingly.
This will save a useless for loop with an atomic_read in
cpupri_find_fitness() calling __cpupri_find().

New mapping:

p->rt_priority   p->prio   newpri   cpupri

                               -1       -1 (CPUPRI_INVALID)

                              100        0 (CPUPRI_NORMAL)

             1        98       98        2
           ...
            49        50       50       50
            50        49       49       51
           ...
            99         0        0      100

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200922083934.19275-2-dietmar.eggemann@arm.com
---
 kernel/sched/cpupri.c | 10 ++++------
 kernel/sched/cpupri.h |  7 +++----
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index 0033731..a5d14ed 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -11,7 +11,7 @@
  *  This code tracks the priority of each CPU so that global migration
  *  decisions are easy to calculate.  Each CPU can be in a state as follows:
  *
- *                 (INVALID), IDLE, NORMAL, RT1, ... RT99
+ *                 (INVALID), NORMAL, RT1, ... RT99
  *
  *  going from the lowest priority to the highest.  CPUs in the INVALID state
  *  are not eligible for routing.  The system maintains this state with
@@ -19,24 +19,22 @@
  *  in that class).  Therefore a typical application without affinity
  *  restrictions can find a suitable CPU with O(1) complexity (e.g. two bit
  *  searches).  For tasks with affinity restrictions, the algorithm has a
- *  worst case complexity of O(min(102, nr_domcpus)), though the scenario that
+ *  worst case complexity of O(min(101, nr_domcpus)), though the scenario that
  *  yields the worst case search is fairly contrived.
  */
 #include "sched.h"
 
-/* Convert between a 140 based task->prio, and our 102 based cpupri */
+/* Convert between a 140 based task->prio, and our 101 based cpupri */
 static int convert_prio(int prio)
 {
 	int cpupri;
 
 	if (prio == CPUPRI_INVALID)
 		cpupri = CPUPRI_INVALID;
-	else if (prio == MAX_PRIO)
-		cpupri = CPUPRI_IDLE;
 	else if (prio >= MAX_RT_PRIO)
 		cpupri = CPUPRI_NORMAL;
 	else
-		cpupri = MAX_RT_PRIO - prio + 1;
+		cpupri = MAX_RT_PRIO - prio;
 
 	return cpupri;
 }
diff --git a/kernel/sched/cpupri.h b/kernel/sched/cpupri.h
index efbb492..1a16236 100644
--- a/kernel/sched/cpupri.h
+++ b/kernel/sched/cpupri.h
@@ -1,11 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-#define CPUPRI_NR_PRIORITIES	(MAX_RT_PRIO + 2)
+#define CPUPRI_NR_PRIORITIES	(MAX_RT_PRIO + 1)
 
 #define CPUPRI_INVALID		-1
-#define CPUPRI_IDLE		 0
-#define CPUPRI_NORMAL		 1
-/* values 2-101 are RT priorities 0-99 */
+#define CPUPRI_NORMAL		 0
+/* values 2-100 are RT priorities 0-99 */
 
 struct cpupri_vec {
 	atomic_t		count;
