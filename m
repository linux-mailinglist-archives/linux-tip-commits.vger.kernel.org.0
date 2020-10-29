Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6A929E996
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgJ2KwN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:52:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60882 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgJ2Kvx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:53 -0400
Date:   Thu, 29 Oct 2020 10:51:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603968710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WzksZVrMK2zPTuyPLMMf1+tEGIwWOTpopvEIMOtozA8=;
        b=gRM8gDdN7wcD6eiTNs5ry/ViYe+9sCRWLDSnXo0KNPFFdLONbCkNo1e5mzqCM+/dVNLuWi
        qPMleeCtkMpPkybwrmjSGol6NnFmLlZmNJQh1fkiuXAoefmATfL0r1VM11ptZTWI5KMFBT
        KwDu2/SQucK8PdX/zRkkuGd6OZ6ji7rjQ45vY7IkdiyA7OZCDk0nu4Py7isb8cqzDmFDJZ
        PgR6NJ5HKgjTQaZfeVFtG3ifHxUzLeCVG3aw6jCZOqI5t57nvyBFEy16z3MRQMmPH3RDt2
        o4r/dkkYmW+cJyycm4uTKf+qebR5JgtMFjj0/MAnfBlbggOY1SQUj8ulHwjltA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603968710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WzksZVrMK2zPTuyPLMMf1+tEGIwWOTpopvEIMOtozA8=;
        b=nLLrolaKpbKJ70ie+YRK2xBXe5vF3ADHj5r/gI6zWyfpWQCO9M+yqTW0Xl68KrT1XLESHU
        hIka821alynBPCBA==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/cpupri: Remove pri_to_cpu[1]
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200922083934.19275-3-dietmar.eggemann@arm.com>
References: <20200922083934.19275-3-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <160396870990.397.13763662113721048647.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1b08782ce31f612d98e11ccccf3e3df9a147a67d
Gitweb:        https://git.kernel.org/tip/1b08782ce31f612d98e11ccccf3e3df9a147a67d
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Tue, 22 Sep 2020 10:39:34 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Oct 2020 11:00:29 +01:00

sched/cpupri: Remove pri_to_cpu[1]

pri_to_cpu[1] isn't used since cpupri_set(..., newpri) is
never called with newpri = 99.

The valid RT priorities RT1..RT99 (p->rt_priority = [1..99]) map into
cpupri (idx of pri_to_cpu[]) = [2..100]

Current mapping:

p->rt_priority   p->prio   newpri   cpupri

                               -1       -1 (CPUPRI_INVALID)

                              100        0 (CPUPRI_NORMAL)

             1        98       98        2
           ...
            49        50       50       50
            50        49       49       51
           ...
            99         0        0      100

So cpupri = 1 isn't used.

Reduce the size of pri_to_cpu[] by 1 and adapt the cpupri
implementation accordingly. This will save a useless for loop with an
atomic_read in cpupri_find_fitness() calling __cpupri_find().

New mapping:

p->rt_priority   p->prio   newpri   cpupri

                               -1       -1 (CPUPRI_INVALID)

                              100        0 (CPUPRI_NORMAL)

             1        98       98        1
           ...
            49        50       50       49
            50        49       49       50
           ...
            99         0        0       99

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200922083934.19275-3-dietmar.eggemann@arm.com
---
 kernel/sched/cpupri.c | 6 +++---
 kernel/sched/cpupri.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index a5d14ed..8d9952a 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -19,12 +19,12 @@
  *  in that class).  Therefore a typical application without affinity
  *  restrictions can find a suitable CPU with O(1) complexity (e.g. two bit
  *  searches).  For tasks with affinity restrictions, the algorithm has a
- *  worst case complexity of O(min(101, nr_domcpus)), though the scenario that
+ *  worst case complexity of O(min(100, nr_domcpus)), though the scenario that
  *  yields the worst case search is fairly contrived.
  */
 #include "sched.h"
 
-/* Convert between a 140 based task->prio, and our 101 based cpupri */
+/* Convert between a 140 based task->prio, and our 100 based cpupri */
 static int convert_prio(int prio)
 {
 	int cpupri;
@@ -34,7 +34,7 @@ static int convert_prio(int prio)
 	else if (prio >= MAX_RT_PRIO)
 		cpupri = CPUPRI_NORMAL;
 	else
-		cpupri = MAX_RT_PRIO - prio;
+		cpupri = MAX_RT_PRIO - prio - 1;
 
 	return cpupri;
 }
diff --git a/kernel/sched/cpupri.h b/kernel/sched/cpupri.h
index 1a16236..e28e1ed 100644
--- a/kernel/sched/cpupri.h
+++ b/kernel/sched/cpupri.h
@@ -1,10 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-#define CPUPRI_NR_PRIORITIES	(MAX_RT_PRIO + 1)
+#define CPUPRI_NR_PRIORITIES	MAX_RT_PRIO
 
 #define CPUPRI_INVALID		-1
 #define CPUPRI_NORMAL		 0
-/* values 2-100 are RT priorities 0-99 */
+/* values 1-99 are for RT1-RT99 priorities */
 
 struct cpupri_vec {
 	atomic_t		count;
