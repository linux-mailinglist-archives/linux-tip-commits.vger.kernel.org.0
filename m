Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D4929E990
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgJ2Kv4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:51:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60798 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgJ2Kvy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:54 -0400
Date:   Thu, 29 Oct 2020 10:51:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603968712;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mYdkwXBLw1WFZcgR5oVXfBuFgHvVpaQWFhKvJ1diGpg=;
        b=J4DhtWxAmEjrHqzB+/ejUwTzrE0xaVpLB9x5sBMptfkDObfplgXWHoxB5fIh4P+zxLP+Ge
        PCKK2hQJrzxCKhA642XWtkfriUFqWdPNzegEeZTo629xx726AmP1SFzvDEsIvMqTBcodXA
        22293M/GwBqpLoV3ZbeTiQ8CpBM4fmxif0YukLUb/1ELh7MifqHYRtswU5SV+enMgIyflP
        0QXDew0l3yvHvl71t213+B4993/Hqfih6TNiFRrfjdm1f3Tq7jhAQyoFPMF3paKqOpCamH
        JFFOWJHvc6/WMgMoRHyotN15x4nVxEvi/BA03gqkYztFZ+RY5YTxae+4Ti7k8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603968712;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mYdkwXBLw1WFZcgR5oVXfBuFgHvVpaQWFhKvJ1diGpg=;
        b=312Wa3q27EQ1Lmh++s1mwEqy+AAqK+L/ddqqsHLIuPoqRLOkdv+fg7UBeFgPpqGlFe2Ac4
        dTFQeLTS7klQ1VDQ==
From:   "tip-bot2 for Peng Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Optimize sched_dl_global_validate()
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Peng Liu <iwtbavbm@gmail.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <78d21ee792cc48ff79e8cd62a5f26208463684d6.1602171061.git.iwtbavbm@gmail.com>
References: <78d21ee792cc48ff79e8cd62a5f26208463684d6.1602171061.git.iwtbavbm@gmail.com>
MIME-Version: 1.0
Message-ID: <160396871191.397.18191930337022595419.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     26762423a2664692de2bcccc9de684a5ac105e23
Gitweb:        https://git.kernel.org/tip/26762423a2664692de2bcccc9de684a5ac105e23
Author:        Peng Liu <iwtbavbm@gmail.com>
AuthorDate:    Thu, 08 Oct 2020 23:48:46 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Oct 2020 11:00:28 +01:00

sched/deadline: Optimize sched_dl_global_validate()

Under CONFIG_SMP, dl_bw is per root domain, but not per CPU.
When checking or updating dl_bw, currently iterating every CPU is
overdoing, just need iterate each root domain once.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/78d21ee792cc48ff79e8cd62a5f26208463684d6.1602171061.git.iwtbavbm@gmail.com
---
 kernel/sched/deadline.c | 39 ++++++++++++++++++++++++++++++++-------
 kernel/sched/sched.h    |  9 +++++++++
 kernel/sched/topology.c |  1 +
 3 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f232305..98d96d4 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -97,6 +97,17 @@ static inline unsigned long dl_bw_capacity(int i)
 		return __dl_bw_capacity(i);
 	}
 }
+
+static inline bool dl_bw_visited(int cpu, u64 gen)
+{
+	struct root_domain *rd = cpu_rq(cpu)->rd;
+
+	if (rd->visit_gen == gen)
+		return true;
+
+	rd->visit_gen = gen;
+	return false;
+}
 #else
 static inline struct dl_bw *dl_bw_of(int i)
 {
@@ -112,6 +123,11 @@ static inline unsigned long dl_bw_capacity(int i)
 {
 	return SCHED_CAPACITY_SCALE;
 }
+
+static inline bool dl_bw_visited(int cpu, u64 gen)
+{
+	return false;
+}
 #endif
 
 static inline
@@ -2535,11 +2551,15 @@ const struct sched_class dl_sched_class
 	.update_curr		= update_curr_dl,
 };
 
+/* Used for dl_bw check and update, used under sched_rt_handler()::mutex */
+static u64 dl_generation;
+
 int sched_dl_global_validate(void)
 {
 	u64 runtime = global_rt_runtime();
 	u64 period = global_rt_period();
 	u64 new_bw = to_ratio(period, runtime);
+	u64 gen = ++dl_generation;
 	struct dl_bw *dl_b;
 	int cpu, ret = 0;
 	unsigned long flags;
@@ -2548,13 +2568,13 @@ int sched_dl_global_validate(void)
 	 * Here we want to check the bandwidth not being set to some
 	 * value smaller than the currently allocated bandwidth in
 	 * any of the root_domains.
-	 *
-	 * FIXME: Cycling on all the CPUs is overdoing, but simpler than
-	 * cycling on root_domains... Discussion on different/better
-	 * solutions is welcome!
 	 */
 	for_each_possible_cpu(cpu) {
 		rcu_read_lock_sched();
+
+		if (dl_bw_visited(cpu, gen))
+			goto next;
+
 		dl_b = dl_bw_of(cpu);
 
 		raw_spin_lock_irqsave(&dl_b->lock, flags);
@@ -2562,6 +2582,7 @@ int sched_dl_global_validate(void)
 			ret = -EBUSY;
 		raw_spin_unlock_irqrestore(&dl_b->lock, flags);
 
+next:
 		rcu_read_unlock_sched();
 
 		if (ret)
@@ -2587,6 +2608,7 @@ static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq)
 void sched_dl_do_global(void)
 {
 	u64 new_bw = -1;
+	u64 gen = ++dl_generation;
 	struct dl_bw *dl_b;
 	int cpu;
 	unsigned long flags;
@@ -2597,11 +2619,14 @@ void sched_dl_do_global(void)
 	if (global_rt_runtime() != RUNTIME_INF)
 		new_bw = to_ratio(global_rt_period(), global_rt_runtime());
 
-	/*
-	 * FIXME: As above...
-	 */
 	for_each_possible_cpu(cpu) {
 		rcu_read_lock_sched();
+
+		if (dl_bw_visited(cpu, gen)) {
+			rcu_read_unlock_sched();
+			continue;
+		}
+
 		dl_b = dl_bw_of(cpu);
 
 		raw_spin_lock_irqsave(&dl_b->lock, flags);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index df80bfc..49a2dae 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -801,6 +801,15 @@ struct root_domain {
 	struct dl_bw		dl_bw;
 	struct cpudl		cpudl;
 
+	/*
+	 * Indicate whether a root_domain's dl_bw has been checked or
+	 * updated. It's monotonously increasing value.
+	 *
+	 * Also, some corner cases, like 'wrap around' is dangerous, but given
+	 * that u64 is 'big enough'. So that shouldn't be a concern.
+	 */
+	u64 visit_gen;
+
 #ifdef HAVE_RT_PUSH_IPI
 	/*
 	 * For IPI pull requests, loop across the rto_mask.
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index dd77702..90f3e55 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -516,6 +516,7 @@ static int init_rootdomain(struct root_domain *rd)
 	init_irq_work(&rd->rto_push_work, rto_push_irq_work_func);
 #endif
 
+	rd->visit_gen = 0;
 	init_dl_bw(&rd->dl_bw);
 	if (cpudl_init(&rd->cpudl) != 0)
 		goto free_rto_mask;
