Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40241FB085
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Jun 2020 14:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgFPMXp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 16 Jun 2020 08:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728875AbgFPMWC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 16 Jun 2020 08:22:02 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C02FC08C5C2;
        Tue, 16 Jun 2020 05:22:01 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAbD-0004ez-OP; Tue, 16 Jun 2020 14:21:55 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 616581C07B4;
        Tue, 16 Jun 2020 14:21:51 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:51 -0000
From:   "tip-bot2 for Luca Abeni" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Implement fallback mechanism for !fit case
Cc:     Luca Abeni <luca.abeni@santannapisa.it>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200520134243.19352-6-dietmar.eggemann@arm.com>
References: <20200520134243.19352-6-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <159231011120.16989.2193698782650296357.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     23e71d8ba42933bff12e453858fd68c073bc5258
Gitweb:        https://git.kernel.org/tip/23e71d8ba42933bff12e453858fd68c073bc5258
Author:        Luca Abeni <luca.abeni@santannapisa.it>
AuthorDate:    Wed, 20 May 2020 15:42:43 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:05 +02:00

sched/deadline: Implement fallback mechanism for !fit case

When a task has a runtime that cannot be served within the scheduling
deadline by any of the idle CPU (later_mask) the task is doomed to miss
its deadline.

This can happen since the SCHED_DEADLINE admission control guarantees
only bounded tardiness and not the hard respect of all deadlines.
In this case try to select the idle CPU with the largest CPU capacity
to minimize tardiness.

Favor task_cpu(p) if it has max capacity of !fitting CPUs so that
find_later_rq() can potentially still return it (most likely cache-hot)
early.

Signed-off-by: Luca Abeni <luca.abeni@santannapisa.it>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20200520134243.19352-6-dietmar.eggemann@arm.com
---
 kernel/sched/cpudeadline.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 8630f2a..8cb06c8 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -121,19 +121,31 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 
 	if (later_mask &&
 	    cpumask_and(later_mask, cp->free_cpus, p->cpus_ptr)) {
-		int cpu;
+		unsigned long cap, max_cap = 0;
+		int cpu, max_cpu = -1;
 
 		if (!static_branch_unlikely(&sched_asym_cpucapacity))
 			return 1;
 
 		/* Ensure the capacity of the CPUs fits the task. */
 		for_each_cpu(cpu, later_mask) {
-			if (!dl_task_fits_capacity(p, cpu))
+			if (!dl_task_fits_capacity(p, cpu)) {
 				cpumask_clear_cpu(cpu, later_mask);
+
+				cap = capacity_orig_of(cpu);
+
+				if (cap > max_cap ||
+				    (cpu == task_cpu(p) && cap == max_cap)) {
+					max_cap = cap;
+					max_cpu = cpu;
+				}
+			}
 		}
 
-		if (!cpumask_empty(later_mask))
-			return 1;
+		if (cpumask_empty(later_mask))
+			cpumask_set_cpu(max_cpu, later_mask);
+
+		return 1;
 	} else {
 		int best_cpu = cpudl_maximum(cp);
 
