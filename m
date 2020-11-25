Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D6A2C419E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Nov 2020 15:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbgKYOCz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 25 Nov 2020 09:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729665AbgKYOCz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 25 Nov 2020 09:02:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CC5C0613D4;
        Wed, 25 Nov 2020 06:02:54 -0800 (PST)
Date:   Wed, 25 Nov 2020 14:02:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606312973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=W63WdDWuet1wWh5yDAYkQE4IRl7sNhvxEBKJ5sQyYIA=;
        b=ekO8uKgepw99D1QGxavnGJaWPvhPEU+ePDNr0DRCDKSngqX1ejH4IDYyZ6VZdIpu/RmAdE
        0qIcb4Hgre8/BsLCOgSy+7L0A4ckKffPuVXRu4cSg5Q+lM6sbEljlzLEYNJUcVRR+OnEA4
        v2xuKefXB+wcbDyiNap7R3VMVT3sTNiwRTtp1fbldmyauDlBrRFqH2ANtGAQ57th8oYvVN
        LOzdgVyGljZNRDm3LKeTs2Xoecyx8lXZqWbkBGQz/R3MLhda3phEZOYd1gqJHmI7M4cH7U
        agwGk3uzOX3ZO8YxRW4e0dAxAtc7kslJntRCcAS2piNBaYfwqbf2CW36148dig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606312973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=W63WdDWuet1wWh5yDAYkQE4IRl7sNhvxEBKJ5sQyYIA=;
        b=DpTgO9AhPiRd3mmibBBK3mRy2fmxGvdBpkX8sxbR1lj6RvyOejCCtHMFo50duSLHwaIs/Z
        8XTJay4iG+zroDCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] smp: Cleanup smp_call_function*()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160631297264.3364.6584770382881954658.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     545b8c8df41f9ecbaf806332d4095bc4bc7c14e8
Gitweb:        https://git.kernel.org/tip/545b8c8df41f9ecbaf806332d4095bc4bc7c14e8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 15 Jun 2020 11:29:31 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 24 Nov 2020 16:47:49 +01:00

smp: Cleanup smp_call_function*()

Get rid of the __call_single_node union and cleanup the API a little
to avoid external code relying on the structure layout as much.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/mips/kernel/process.c                      |  5 +-
 arch/mips/kernel/smp.c                          | 25 +-------
 arch/s390/pci/pci_irq.c                         |  4 +-
 arch/x86/kernel/cpuid.c                         |  7 +--
 arch/x86/lib/msr-smp.c                          |  7 +--
 block/blk-mq.c                                  |  4 +-
 drivers/cpuidle/coupled.c                       |  3 +-
 drivers/net/ethernet/cavium/liquidio/lio_core.c |  9 +---
 include/linux/smp.h                             | 19 ++----
 kernel/debug/debug_core.c                       |  6 +-
 kernel/sched/core.c                             | 12 +----
 kernel/smp.c                                    | 50 ++++++++--------
 net/core/dev.c                                  |  3 +-
 13 files changed, 60 insertions(+), 94 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 75ebd8d..d7e288f 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -702,7 +702,6 @@ unsigned long arch_align_stack(unsigned long sp)
 	return sp & ALMASK;
 }
 
-static DEFINE_PER_CPU(call_single_data_t, backtrace_csd);
 static struct cpumask backtrace_csd_busy;
 
 static void handle_backtrace(void *info)
@@ -711,6 +710,9 @@ static void handle_backtrace(void *info)
 	cpumask_clear_cpu(smp_processor_id(), &backtrace_csd_busy);
 }
 
+static DEFINE_PER_CPU(call_single_data_t, backtrace_csd) =
+	CSD_INIT(handle_backtrace, NULL);
+
 static void raise_backtrace(cpumask_t *mask)
 {
 	call_single_data_t *csd;
@@ -730,7 +732,6 @@ static void raise_backtrace(cpumask_t *mask)
 		}
 
 		csd = &per_cpu(backtrace_csd, cpu);
-		csd->func = handle_backtrace;
 		smp_call_function_single_async(cpu, csd);
 	}
 }
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 48d84d5..74b9102 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -687,36 +687,23 @@ EXPORT_SYMBOL(flush_tlb_one);
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 
-static DEFINE_PER_CPU(call_single_data_t, tick_broadcast_csd);
-
-void tick_broadcast(const struct cpumask *mask)
-{
-	call_single_data_t *csd;
-	int cpu;
-
-	for_each_cpu(cpu, mask) {
-		csd = &per_cpu(tick_broadcast_csd, cpu);
-		smp_call_function_single_async(cpu, csd);
-	}
-}
-
 static void tick_broadcast_callee(void *info)
 {
 	tick_receive_broadcast();
 }
 
-static int __init tick_broadcast_init(void)
+static DEFINE_PER_CPU(call_single_data_t, tick_broadcast_csd) =
+	CSD_INIT(tick_broadcast_callee, NULL);
+
+void tick_broadcast(const struct cpumask *mask)
 {
 	call_single_data_t *csd;
 	int cpu;
 
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+	for_each_cpu(cpu, mask) {
 		csd = &per_cpu(tick_broadcast_csd, cpu);
-		csd->func = tick_broadcast_callee;
+		smp_call_function_single_async(cpu, csd);
 	}
-
-	return 0;
 }
-early_initcall(tick_broadcast_init);
 
 #endif /* CONFIG_GENERIC_CLOCKEVENTS_BROADCAST */
diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 743f257..1311b6f 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -178,9 +178,7 @@ static void zpci_handle_fallback_irq(void)
 		if (atomic_inc_return(&cpu_data->scheduled) > 1)
 			continue;
 
-		cpu_data->csd.func = zpci_handle_remote_irq;
-		cpu_data->csd.info = &cpu_data->scheduled;
-		cpu_data->csd.flags = 0;
+		INIT_CSD(&cpu_data->csd, zpci_handle_remote_irq, &cpu_data->scheduled);
 		smp_call_function_single_async(cpu, &cpu_data->csd);
 	}
 }
diff --git a/arch/x86/kernel/cpuid.c b/arch/x86/kernel/cpuid.c
index 3492aa3..6f7b8cc 100644
--- a/arch/x86/kernel/cpuid.c
+++ b/arch/x86/kernel/cpuid.c
@@ -74,10 +74,9 @@ static ssize_t cpuid_read(struct file *file, char __user *buf,
 
 	init_completion(&cmd.done);
 	for (; count; count -= 16) {
-		call_single_data_t csd = {
-			.func = cpuid_smp_cpuid,
-			.info = &cmd,
-		};
+		call_single_data_t csd;
+
+		INIT_CSD(&csd, cpuid_smp_cpuid, &cmd);
 
 		cmd.regs.eax = pos;
 		cmd.regs.ecx = pos >> 32;
diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index fee8b9c..75a0915 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -169,12 +169,11 @@ static void __wrmsr_safe_on_cpu(void *info)
 int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
 {
 	struct msr_info_completion rv;
-	call_single_data_t csd = {
-		.func	= __rdmsr_safe_on_cpu,
-		.info	= &rv,
-	};
+	call_single_data_t csd;
 	int err;
 
+	INIT_CSD(&csd, __rdmsr_safe_on_cpu, &rv);
+
 	memset(&rv, 0, sizeof(rv));
 	init_completion(&rv.done);
 	rv.msr.msr_no = msr_no;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 55bcee5..d35b3c0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -671,9 +671,7 @@ bool blk_mq_complete_request_remote(struct request *rq)
 		return false;
 
 	if (blk_mq_complete_need_ipi(rq)) {
-		rq->csd.func = __blk_mq_complete_request_remote;
-		rq->csd.info = rq;
-		rq->csd.flags = 0;
+		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
 		smp_call_function_single_async(rq->mq_ctx->cpu, &rq->csd);
 	} else {
 		if (rq->q->nr_hw_queues > 1)
diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index 04003b9..7406874 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -674,8 +674,7 @@ have_coupled:
 	coupled->refcnt++;
 
 	csd = &per_cpu(cpuidle_coupled_poke_cb, dev->cpu);
-	csd->func = cpuidle_coupled_handle_poke;
-	csd->info = (void *)(unsigned long)dev->cpu;
+	INIT_CSD(csd, cpuidle_coupled_handle_poke, (void *)(unsigned long)dev->cpu);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_core.c b/drivers/net/ethernet/cavium/liquidio/lio_core.c
index 9ef1729..37d0641 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_core.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_core.c
@@ -729,13 +729,8 @@ static void liquidio_napi_drv_callback(void *arg)
 	    droq->cpu_id == this_cpu) {
 		napi_schedule_irqoff(&droq->napi);
 	} else {
-		call_single_data_t *csd = &droq->csd;
-
-		csd->func = napi_schedule_wrapper;
-		csd->info = &droq->napi;
-		csd->flags = 0;
-
-		smp_call_function_single_async(droq->cpu_id, csd);
+		INIT_CSD(&droq->csd, napi_schedule_wrapper, &droq->napi);
+		smp_call_function_single_async(droq->cpu_id, &droq->csd);
 	}
 }
 
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 9f13966..70c6f62 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -21,24 +21,23 @@ typedef bool (*smp_cond_func_t)(int cpu, void *info);
  * structure shares (partial) layout with struct irq_work
  */
 struct __call_single_data {
-	union {
-		struct __call_single_node node;
-		struct {
-			struct llist_node llist;
-			unsigned int flags;
-#ifdef CONFIG_64BIT
-			u16 src, dst;
-#endif
-		};
-	};
+	struct __call_single_node node;
 	smp_call_func_t func;
 	void *info;
 };
 
+#define CSD_INIT(_func, _info) \
+	(struct __call_single_data){ .func = (_func), .info = (_info), }
+
 /* Use __aligned() to avoid to use 2 cache lines for 1 csd */
 typedef struct __call_single_data call_single_data_t
 	__aligned(sizeof(struct __call_single_data));
 
+#define INIT_CSD(_csd, _func, _info)		\
+do {						\
+	*(_csd) = CSD_INIT((_func), (_info));	\
+} while (0)
+
 /*
  * Enqueue a llist_node on the call_single_queue; be very careful, read
  * flush_smp_call_function_queue() in detail.
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 1e75a89..af6e8b4 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -225,8 +225,6 @@ NOKPROBE_SYMBOL(kgdb_skipexception);
  * Default (weak) implementation for kgdb_roundup_cpus
  */
 
-static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd);
-
 void __weak kgdb_call_nmi_hook(void *ignored)
 {
 	/*
@@ -241,6 +239,9 @@ void __weak kgdb_call_nmi_hook(void *ignored)
 }
 NOKPROBE_SYMBOL(kgdb_call_nmi_hook);
 
+static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd) =
+	CSD_INIT(kgdb_call_nmi_hook, NULL);
+
 void __weak kgdb_roundup_cpus(void)
 {
 	call_single_data_t *csd;
@@ -267,7 +268,6 @@ void __weak kgdb_roundup_cpus(void)
 			continue;
 		kgdb_info[cpu].rounding_up = true;
 
-		csd->func = kgdb_call_nmi_hook;
 		ret = smp_call_function_single_async(cpu, csd);
 		if (ret)
 			kgdb_info[cpu].rounding_up = false;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c962922..b943b45 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -320,14 +320,6 @@ void update_rq_clock(struct rq *rq)
 	update_rq_clock_task(rq, delta);
 }
 
-static inline void
-rq_csd_init(struct rq *rq, call_single_data_t *csd, smp_call_func_t func)
-{
-	csd->flags = 0;
-	csd->func = func;
-	csd->info = rq;
-}
-
 #ifdef CONFIG_SCHED_HRTICK
 /*
  * Use HR-timers to deliver accurate preemption points.
@@ -428,7 +420,7 @@ void hrtick_start(struct rq *rq, u64 delay)
 static void hrtick_rq_init(struct rq *rq)
 {
 #ifdef CONFIG_SMP
-	rq_csd_init(rq, &rq->hrtick_csd, __hrtick_start);
+	INIT_CSD(&rq->hrtick_csd, __hrtick_start, rq);
 #endif
 	hrtimer_init(&rq->hrtick_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	rq->hrtick_timer.function = hrtick;
@@ -7774,7 +7766,7 @@ void __init sched_init(void)
 		rq->last_blocked_load_update_tick = jiffies;
 		atomic_set(&rq->nohz_flags, 0);
 
-		rq_csd_init(rq, &rq->nohz_csd, nohz_csd_func);
+		INIT_CSD(&rq->nohz_csd, nohz_csd_func, rq);
 #endif
 #ifdef CONFIG_HOTPLUG_CPU
 		rcuwait_init(&rq->hotplug_wait);
diff --git a/kernel/smp.c b/kernel/smp.c
index 4d17501..faf1a3a 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -27,7 +27,7 @@
 #include "smpboot.h"
 #include "sched/smp.h"
 
-#define CSD_TYPE(_csd)	((_csd)->flags & CSD_FLAG_TYPE_MASK)
+#define CSD_TYPE(_csd)	((_csd)->node.u_flags & CSD_FLAG_TYPE_MASK)
 
 struct call_function_data {
 	call_single_data_t	__percpu *csd;
@@ -146,7 +146,7 @@ static __always_inline bool csd_lock_wait_toolong(call_single_data_t *csd, u64 t
 	bool firsttime;
 	u64 ts2, ts_delta;
 	call_single_data_t *cpu_cur_csd;
-	unsigned int flags = READ_ONCE(csd->flags);
+	unsigned int flags = READ_ONCE(csd->node.u_flags);
 
 	if (!(flags & CSD_FLAG_LOCK)) {
 		if (!unlikely(*bug_id))
@@ -224,14 +224,14 @@ static void csd_lock_record(call_single_data_t *csd)
 
 static __always_inline void csd_lock_wait(call_single_data_t *csd)
 {
-	smp_cond_load_acquire(&csd->flags, !(VAL & CSD_FLAG_LOCK));
+	smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK));
 }
 #endif
 
 static __always_inline void csd_lock(call_single_data_t *csd)
 {
 	csd_lock_wait(csd);
-	csd->flags |= CSD_FLAG_LOCK;
+	csd->node.u_flags |= CSD_FLAG_LOCK;
 
 	/*
 	 * prevent CPU from reordering the above assignment
@@ -243,12 +243,12 @@ static __always_inline void csd_lock(call_single_data_t *csd)
 
 static __always_inline void csd_unlock(call_single_data_t *csd)
 {
-	WARN_ON(!(csd->flags & CSD_FLAG_LOCK));
+	WARN_ON(!(csd->node.u_flags & CSD_FLAG_LOCK));
 
 	/*
 	 * ensure we're all done before releasing data:
 	 */
-	smp_store_release(&csd->flags, 0);
+	smp_store_release(&csd->node.u_flags, 0);
 }
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
@@ -300,7 +300,7 @@ static int generic_exec_single(int cpu, call_single_data_t *csd)
 		return -ENXIO;
 	}
 
-	__smp_call_single_queue(cpu, &csd->llist);
+	__smp_call_single_queue(cpu, &csd->node.llist);
 
 	return 0;
 }
@@ -353,7 +353,7 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 		 * We don't have to use the _safe() variant here
 		 * because we are not invoking the IPI handlers yet.
 		 */
-		llist_for_each_entry(csd, entry, llist) {
+		llist_for_each_entry(csd, entry, node.llist) {
 			switch (CSD_TYPE(csd)) {
 			case CSD_TYPE_ASYNC:
 			case CSD_TYPE_SYNC:
@@ -378,16 +378,16 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 	 * First; run all SYNC callbacks, people are waiting for us.
 	 */
 	prev = NULL;
-	llist_for_each_entry_safe(csd, csd_next, entry, llist) {
+	llist_for_each_entry_safe(csd, csd_next, entry, node.llist) {
 		/* Do we wait until *after* callback? */
 		if (CSD_TYPE(csd) == CSD_TYPE_SYNC) {
 			smp_call_func_t func = csd->func;
 			void *info = csd->info;
 
 			if (prev) {
-				prev->next = &csd_next->llist;
+				prev->next = &csd_next->node.llist;
 			} else {
-				entry = &csd_next->llist;
+				entry = &csd_next->node.llist;
 			}
 
 			csd_lock_record(csd);
@@ -395,7 +395,7 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 			csd_unlock(csd);
 			csd_lock_record(NULL);
 		} else {
-			prev = &csd->llist;
+			prev = &csd->node.llist;
 		}
 	}
 
@@ -406,14 +406,14 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 	 * Second; run all !SYNC callbacks.
 	 */
 	prev = NULL;
-	llist_for_each_entry_safe(csd, csd_next, entry, llist) {
+	llist_for_each_entry_safe(csd, csd_next, entry, node.llist) {
 		int type = CSD_TYPE(csd);
 
 		if (type != CSD_TYPE_TTWU) {
 			if (prev) {
-				prev->next = &csd_next->llist;
+				prev->next = &csd_next->node.llist;
 			} else {
-				entry = &csd_next->llist;
+				entry = &csd_next->node.llist;
 			}
 
 			if (type == CSD_TYPE_ASYNC) {
@@ -429,7 +429,7 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 			}
 
 		} else {
-			prev = &csd->llist;
+			prev = &csd->node.llist;
 		}
 	}
 
@@ -465,7 +465,7 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 {
 	call_single_data_t *csd;
 	call_single_data_t csd_stack = {
-		.flags = CSD_FLAG_LOCK | CSD_TYPE_SYNC,
+		.node = { .u_flags = CSD_FLAG_LOCK | CSD_TYPE_SYNC, },
 	};
 	int this_cpu;
 	int err;
@@ -502,8 +502,8 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 	csd->func = func;
 	csd->info = info;
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
-	csd->src = smp_processor_id();
-	csd->dst = cpu;
+	csd->node.src = smp_processor_id();
+	csd->node.dst = cpu;
 #endif
 
 	err = generic_exec_single(cpu, csd);
@@ -544,12 +544,12 @@ int smp_call_function_single_async(int cpu, call_single_data_t *csd)
 
 	preempt_disable();
 
-	if (csd->flags & CSD_FLAG_LOCK) {
+	if (csd->node.u_flags & CSD_FLAG_LOCK) {
 		err = -EBUSY;
 		goto out;
 	}
 
-	csd->flags = CSD_FLAG_LOCK;
+	csd->node.u_flags = CSD_FLAG_LOCK;
 	smp_wmb();
 
 	err = generic_exec_single(cpu, csd);
@@ -667,14 +667,14 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 
 		csd_lock(csd);
 		if (wait)
-			csd->flags |= CSD_TYPE_SYNC;
+			csd->node.u_flags |= CSD_TYPE_SYNC;
 		csd->func = func;
 		csd->info = info;
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
-		csd->src = smp_processor_id();
-		csd->dst = cpu;
+		csd->node.src = smp_processor_id();
+		csd->node.dst = cpu;
 #endif
-		if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
+		if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu)))
 			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
 	}
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 82dc6b4..5735260 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11165,8 +11165,7 @@ static int __init net_dev_init(void)
 		INIT_LIST_HEAD(&sd->poll_list);
 		sd->output_queue_tailp = &sd->output_queue;
 #ifdef CONFIG_RPS
-		sd->csd.func = rps_trigger_softirq;
-		sd->csd.info = sd;
+		INIT_CSD(&sd->csd, rps_trigger_softirq, sd);
 		sd->cpu = i;
 #endif
 
