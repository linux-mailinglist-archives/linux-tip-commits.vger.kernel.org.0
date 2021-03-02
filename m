Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CD132B0A6
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Mar 2021 04:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352300AbhCCDjO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Mar 2021 22:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577834AbhCBJ4R (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Mar 2021 04:56:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0AEC061788;
        Tue,  2 Mar 2021 01:55:36 -0800 (PST)
Date:   Tue, 02 Mar 2021 09:54:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614678889;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j/Obz6ulKbIf0Rp9YKKrYZDQBg3GwoYMgd9CnbPRX9A=;
        b=pvJqTnfrydYg2Fj0wa4n4dMPFFpRPWVcM9X4zF5hFqSez4tMO+Rj1tlCCJV5ZJkRz3Cogx
        UfrPzee09a5zgIwz3q8/wBqVXJ7v8te8fDqbIcuDqEu1TSpFCvNFYFtcvZO/A4xJJU2Czv
        GfTzy0Io9mT2iGTRWn26QPXzXShei73I2rIKqq7L0JiO4oDpx0SIQ5fcMaacToM2DGfsZp
        ihwMr6BoZTytYghxQtX+lq/whnmFfZ8wrAQkmWlluKSzSTWMYKKyrxsuRcwumGMBIP9bDg
        blkwTfYcrnJVpgGpgHkriD3qXMlxARNr8Cc2rXN2a1kPBhIowCxkqP+t3qfdRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614678889;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j/Obz6ulKbIf0Rp9YKKrYZDQBg3GwoYMgd9CnbPRX9A=;
        b=YeYNn5l78HwBREvowU9e0SnoQPJCe8aJ7d0ammoCZ/Ep7TxHwDVHnQViN18NAAbfZCJQkO
        psdIYOQP+NpAjYDw==
From:   "tip-bot2 for Nadav Amit" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] smp: Run functions concurrently in
 smp_call_function_many_cond()
Cc:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210220231712.2475218-2-namit@vmware.com>
References: <20210220231712.2475218-2-namit@vmware.com>
MIME-Version: 1.0
Message-ID: <161467888888.20312.6351292554503436192.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     b54d50640ca698383fc5b711487f303c17f4b47f
Gitweb:        https://git.kernel.org/tip/b54d50640ca698383fc5b711487f303c17f4b47f
Author:        Nadav Amit <namit@vmware.com>
AuthorDate:    Sat, 20 Feb 2021 15:17:04 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 02 Mar 2021 08:01:37 +01:00

smp: Run functions concurrently in smp_call_function_many_cond()

Currently, on_each_cpu() and similar functions do not exploit the
potential of concurrency: the function is first executed remotely and
only then it is executed locally. Functions such as TLB flush can take
considerable time, so this provides an opportunity for performance
optimization.

To do so, modify smp_call_function_many_cond(), to allows the callers to
provide a function that should be executed (remotely/locally), and run
them concurrently. Keep other smp_call_function_many() semantic as it is
today for backward compatibility: the called function is not executed in
this case locally.

smp_call_function_many_cond() does not use the optimized version for a
single remote target that smp_call_function_single() implements. For
synchronous function call, smp_call_function_single() keeps a
call_single_data (which is used for synchronization) on the stack.
Interestingly, it seems that not using this optimization provides
greater performance improvements (greater speedup with a single remote
target than with multiple ones). Presumably, holding data structures
that are intended for synchronization on the stack can introduce
overheads due to TLB misses and false-sharing when the stack is used for
other purposes.

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20210220231712.2475218-2-namit@vmware.com
---
 kernel/smp.c | 156 ++++++++++++++++++++++++++++----------------------
 1 file changed, 88 insertions(+), 68 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index aeb0adf..c8a5a1f 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -608,12 +608,28 @@ call:
 }
 EXPORT_SYMBOL_GPL(smp_call_function_any);
 
+/*
+ * Flags to be used as scf_flags argument of smp_call_function_many_cond().
+ *
+ * %SCF_WAIT:		Wait until function execution is completed
+ * %SCF_RUN_LOCAL:	Run also locally if local cpu is set in cpumask
+ */
+#define SCF_WAIT	(1U << 0)
+#define SCF_RUN_LOCAL	(1U << 1)
+
 static void smp_call_function_many_cond(const struct cpumask *mask,
 					smp_call_func_t func, void *info,
-					bool wait, smp_cond_func_t cond_func)
+					unsigned int scf_flags,
+					smp_cond_func_t cond_func)
 {
+	int cpu, last_cpu, this_cpu = smp_processor_id();
 	struct call_function_data *cfd;
-	int cpu, next_cpu, this_cpu = smp_processor_id();
+	bool wait = scf_flags & SCF_WAIT;
+	bool run_remote = false;
+	bool run_local = false;
+	int nr_cpus = 0;
+
+	lockdep_assert_preemption_disabled();
 
 	/*
 	 * Can deadlock when called with interrupts disabled.
@@ -621,8 +637,9 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 	 * send smp call function interrupt to this cpu and as such deadlocks
 	 * can't happen.
 	 */
-	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
-		     && !oops_in_progress && !early_boot_irqs_disabled);
+	if (cpu_online(this_cpu) && !oops_in_progress &&
+	    !early_boot_irqs_disabled)
+		lockdep_assert_irqs_enabled();
 
 	/*
 	 * When @wait we can deadlock when we interrupt between llist_add() and
@@ -632,60 +649,65 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 	 */
 	WARN_ON_ONCE(!in_task());
 
-	/* Try to fastpath.  So, what's a CPU they want? Ignoring this one. */
+	/* Check if we need local execution. */
+	if ((scf_flags & SCF_RUN_LOCAL) && cpumask_test_cpu(this_cpu, mask))
+		run_local = true;
+
+	/* Check if we need remote execution, i.e., any CPU excluding this one. */
 	cpu = cpumask_first_and(mask, cpu_online_mask);
 	if (cpu == this_cpu)
 		cpu = cpumask_next_and(cpu, mask, cpu_online_mask);
+	if (cpu < nr_cpu_ids)
+		run_remote = true;
 
-	/* No online cpus?  We're done. */
-	if (cpu >= nr_cpu_ids)
-		return;
-
-	/* Do we have another CPU which isn't us? */
-	next_cpu = cpumask_next_and(cpu, mask, cpu_online_mask);
-	if (next_cpu == this_cpu)
-		next_cpu = cpumask_next_and(next_cpu, mask, cpu_online_mask);
-
-	/* Fastpath: do that cpu by itself. */
-	if (next_cpu >= nr_cpu_ids) {
-		if (!cond_func || cond_func(cpu, info))
-			smp_call_function_single(cpu, func, info, wait);
-		return;
-	}
-
-	cfd = this_cpu_ptr(&cfd_data);
+	if (run_remote) {
+		cfd = this_cpu_ptr(&cfd_data);
+		cpumask_and(cfd->cpumask, mask, cpu_online_mask);
+		__cpumask_clear_cpu(this_cpu, cfd->cpumask);
 
-	cpumask_and(cfd->cpumask, mask, cpu_online_mask);
-	__cpumask_clear_cpu(this_cpu, cfd->cpumask);
-
-	/* Some callers race with other cpus changing the passed mask */
-	if (unlikely(!cpumask_weight(cfd->cpumask)))
-		return;
+		cpumask_clear(cfd->cpumask_ipi);
+		for_each_cpu(cpu, cfd->cpumask) {
+			call_single_data_t *csd = per_cpu_ptr(cfd->csd, cpu);
 
-	cpumask_clear(cfd->cpumask_ipi);
-	for_each_cpu(cpu, cfd->cpumask) {
-		call_single_data_t *csd = per_cpu_ptr(cfd->csd, cpu);
+			if (cond_func && !cond_func(cpu, info))
+				continue;
 
-		if (cond_func && !cond_func(cpu, info))
-			continue;
-
-		csd_lock(csd);
-		if (wait)
-			csd->node.u_flags |= CSD_TYPE_SYNC;
-		csd->func = func;
-		csd->info = info;
+			csd_lock(csd);
+			if (wait)
+				csd->node.u_flags |= CSD_TYPE_SYNC;
+			csd->func = func;
+			csd->info = info;
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
-		csd->node.src = smp_processor_id();
-		csd->node.dst = cpu;
+			csd->node.src = smp_processor_id();
+			csd->node.dst = cpu;
 #endif
-		if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu)))
-			__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
+			if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu))) {
+				__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
+				nr_cpus++;
+				last_cpu = cpu;
+			}
+		}
+
+		/*
+		 * Choose the most efficient way to send an IPI. Note that the
+		 * number of CPUs might be zero due to concurrent changes to the
+		 * provided mask.
+		 */
+		if (nr_cpus == 1)
+			arch_send_call_function_single_ipi(last_cpu);
+		else if (likely(nr_cpus > 1))
+			arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
 	}
 
-	/* Send a message to all CPUs in the map */
-	arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
+	if (run_local && (!cond_func || cond_func(this_cpu, info))) {
+		unsigned long flags;
 
-	if (wait) {
+		local_irq_save(flags);
+		func(info);
+		local_irq_restore(flags);
+	}
+
+	if (run_remote && wait) {
 		for_each_cpu(cpu, cfd->cpumask) {
 			call_single_data_t *csd;
 
@@ -696,12 +718,14 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 }
 
 /**
- * smp_call_function_many(): Run a function on a set of other CPUs.
+ * smp_call_function_many(): Run a function on a set of CPUs.
  * @mask: The set of cpus to run on (only runs on online subset).
  * @func: The function to run. This must be fast and non-blocking.
  * @info: An arbitrary pointer to pass to the function.
- * @wait: If true, wait (atomically) until function has completed
- *        on other CPUs.
+ * @flags: Bitmask that controls the operation. If %SCF_WAIT is set, wait
+ *        (atomically) until function has completed on other CPUs. If
+ *        %SCF_RUN_LOCAL is set, the function will also be run locally
+ *        if the local CPU is set in the @cpumask.
  *
  * If @wait is true, then returns once @func has returned.
  *
@@ -712,7 +736,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 void smp_call_function_many(const struct cpumask *mask,
 			    smp_call_func_t func, void *info, bool wait)
 {
-	smp_call_function_many_cond(mask, func, info, wait, NULL);
+	smp_call_function_many_cond(mask, func, info, wait * SCF_WAIT, NULL);
 }
 EXPORT_SYMBOL(smp_call_function_many);
 
@@ -860,16 +884,15 @@ EXPORT_SYMBOL(on_each_cpu);
 void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
 			void *info, bool wait)
 {
-	int cpu = get_cpu();
+	unsigned int scf_flags;
 
-	smp_call_function_many(mask, func, info, wait);
-	if (cpumask_test_cpu(cpu, mask)) {
-		unsigned long flags;
-		local_irq_save(flags);
-		func(info);
-		local_irq_restore(flags);
-	}
-	put_cpu();
+	scf_flags = SCF_RUN_LOCAL;
+	if (wait)
+		scf_flags |= SCF_WAIT;
+
+	preempt_disable();
+	smp_call_function_many_cond(mask, func, info, scf_flags, NULL);
+	preempt_enable();
 }
 EXPORT_SYMBOL(on_each_cpu_mask);
 
@@ -898,17 +921,14 @@ EXPORT_SYMBOL(on_each_cpu_mask);
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 			   void *info, bool wait, const struct cpumask *mask)
 {
-	int cpu = get_cpu();
+	unsigned int scf_flags = SCF_RUN_LOCAL;
 
-	smp_call_function_many_cond(mask, func, info, wait, cond_func);
-	if (cpumask_test_cpu(cpu, mask) && cond_func(cpu, info)) {
-		unsigned long flags;
+	if (wait)
+		scf_flags |= SCF_WAIT;
 
-		local_irq_save(flags);
-		func(info);
-		local_irq_restore(flags);
-	}
-	put_cpu();
+	preempt_disable();
+	smp_call_function_many_cond(mask, func, info, scf_flags, cond_func);
+	preempt_enable();
 }
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
 
