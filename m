Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909212882C8
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732204AbgJIGjs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:39:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55356 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJIGfN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:13 -0400
Date:   Fri, 09 Oct 2020 06:35:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225309;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NTke0Q8yuCLc4wmebjD08WwJuadwjzkPAG/qBkLPnhA=;
        b=g4dAHsidLQkgcSaCGC9sE0PuK8H8qaGA/PkSQ+nIluG5LmpdgWx6x/1J25Shl507+VvjMo
        qxtVZ8JPan8baUBDFcj8Rob96iniOVQEQqyqIEwAUl+U8io8EINWr5KTJyiMpBBW248C0U
        dDMTb4kn+DkDZ7xRwTN/cKZOvExfQiGYy0Hs5eIGatuShIEbS4kLzqCmo/49xw80kCzJsF
        lbSMEgFbNbDrSwd139y8fGLELiZCs3wGCgoDZBB0+SgQov7xFq0kGPTcKr8fRVmhYIn4py
        nW979whbHfj815xj7425IlaHjL+HczArO93+MRHv2hOzGmVqXBxG/cGuQZLJEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225309;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NTke0Q8yuCLc4wmebjD08WwJuadwjzkPAG/qBkLPnhA=;
        b=isoPhNDlcPimWidh1N4g/4If7kTmhyRfhxpr3W5MG7UVo2GqMNnNRMRQ1UP2P9a1l/DfHS
        sG/FtvHilPqoc1Cw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] kernel/smp: Provide CSD lock timeout diagnostics
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <00000000000042f21905a991ecea@google.com>
References: <00000000000042f21905a991ecea@google.com>
MIME-Version: 1.0
Message-ID: <160222530828.7002.4059205992462088700.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     35feb60474bf4f7fa7840e14fc7fd344996b919d
Gitweb:        https://git.kernel.org/tip/35feb60474bf4f7fa7840e14fc7fd344996b919d
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 30 Jun 2020 13:22:54 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 04 Sep 2020 11:52:50 -07:00

kernel/smp: Provide CSD lock timeout diagnostics

This commit causes csd_lock_wait() to emit diagnostics when a CPU
fails to respond quickly enough to one of the smp_call_function()
family of function calls.  These diagnostics are enabled by a new
CSD_LOCK_WAIT_DEBUG Kconfig option that depends on DEBUG_KERNEL.

This commit was inspired by an earlier patch by Josef Bacik.

[ paulmck: Fix for syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com ]
[ paulmck: Fix KASAN use-after-free issue reported by Qian Cai. ]
[ paulmck: Fix botched nr_cpu_ids comparison per Dan Carpenter. ]
[ paulmck: Apply Peter Zijlstra feedback. ]
Link: https://lore.kernel.org/lkml/00000000000042f21905a991ecea@google.com
Link: https://lore.kernel.org/lkml/0000000000002ef21705a9933cf3@google.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/smp.c      | 132 ++++++++++++++++++++++++++++++++++++++++++++-
 lib/Kconfig.debug |  11 ++++-
 2 files changed, 141 insertions(+), 2 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 865a876..c5d3188 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -20,6 +20,9 @@
 #include <linux/sched.h>
 #include <linux/sched/idle.h>
 #include <linux/hypervisor.h>
+#include <linux/sched/clock.h>
+#include <linux/nmi.h>
+#include <linux/sched/debug.h>
 
 #include "smpboot.h"
 #include "sched/smp.h"
@@ -96,6 +99,103 @@ void __init call_function_init(void)
 	smpcfd_prepare_cpu(smp_processor_id());
 }
 
+#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
+
+static DEFINE_PER_CPU(call_single_data_t *, cur_csd);
+static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);
+static DEFINE_PER_CPU(void *, cur_csd_info);
+
+#define CSD_LOCK_TIMEOUT (5ULL * NSEC_PER_SEC)
+atomic_t csd_bug_count = ATOMIC_INIT(0);
+
+/* Record current CSD work for current CPU, NULL to erase. */
+static void csd_lock_record(call_single_data_t *csd)
+{
+	if (!csd) {
+		smp_mb(); /* NULL cur_csd after unlock. */
+		__this_cpu_write(cur_csd, NULL);
+		return;
+	}
+	__this_cpu_write(cur_csd_func, csd->func);
+	__this_cpu_write(cur_csd_info, csd->info);
+	smp_wmb(); /* func and info before csd. */
+	__this_cpu_write(cur_csd, csd);
+	smp_mb(); /* Update cur_csd before function call. */
+		  /* Or before unlock, as the case may be. */
+}
+
+static __always_inline int csd_lock_wait_getcpu(call_single_data_t *csd)
+{
+	unsigned int csd_type;
+
+	csd_type = CSD_TYPE(csd);
+	if (csd_type == CSD_TYPE_ASYNC || csd_type == CSD_TYPE_SYNC)
+		return csd->dst; /* Other CSD_TYPE_ values might not have ->dst. */
+	return -1;
+}
+
+/*
+ * Complain if too much time spent waiting.  Note that only
+ * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
+ * so waiting on other types gets much less information.
+ */
+static __always_inline bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id)
+{
+	int cpu = -1;
+	int cpux;
+	bool firsttime;
+	u64 ts2, ts_delta;
+	call_single_data_t *cpu_cur_csd;
+	unsigned int flags = READ_ONCE(csd->flags);
+
+	if (!(flags & CSD_FLAG_LOCK)) {
+		if (!unlikely(*bug_id))
+			return true;
+		cpu = csd_lock_wait_getcpu(csd);
+		pr_alert("csd: CSD lock (#%d) got unstuck on CPU#%02d, CPU#%02d released the lock.\n",
+			 *bug_id, raw_smp_processor_id(), cpu);
+		return true;
+	}
+
+	ts2 = sched_clock();
+	ts_delta = ts2 - *ts1;
+	if (likely(ts_delta <= CSD_LOCK_TIMEOUT))
+		return false;
+
+	firsttime = !*bug_id;
+	if (firsttime)
+		*bug_id = atomic_inc_return(&csd_bug_count);
+	cpu = csd_lock_wait_getcpu(csd);
+	if (WARN_ONCE(cpu < 0 || cpu >= nr_cpu_ids, "%s: cpu = %d\n", __func__, cpu))
+		cpux = 0;
+	else
+		cpux = cpu;
+	cpu_cur_csd = smp_load_acquire(&per_cpu(cur_csd, cpux)); /* Before func and info. */
+	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %llu ns for CPU#%02d %pS(%ps).\n",
+		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts2 - ts0,
+		 cpu, csd->func, csd->info);
+	if (cpu_cur_csd && csd != cpu_cur_csd) {
+		pr_alert("\tcsd: CSD lock (#%d) handling prior %pS(%ps) request.\n",
+			 *bug_id, READ_ONCE(per_cpu(cur_csd_func, cpux)),
+			 READ_ONCE(per_cpu(cur_csd_info, cpux)));
+	} else {
+		pr_alert("\tcsd: CSD lock (#%d) %s.\n",
+			 *bug_id, !cpu_cur_csd ? "unresponsive" : "handling this request");
+	}
+	if (cpu >= 0) {
+		if (!trigger_single_cpu_backtrace(cpu))
+			dump_cpu_task(cpu);
+		if (!cpu_cur_csd) {
+			pr_alert("csd: Re-sending CSD lock (#%d) IPI from CPU#%02d to CPU#%02d\n", *bug_id, raw_smp_processor_id(), cpu);
+			arch_send_call_function_single_ipi(cpu);
+		}
+	}
+	dump_stack();
+	*ts1 = ts2;
+
+	return false;
+}
+
 /*
  * csd_lock/csd_unlock used to serialize access to per-cpu csd resources
  *
@@ -105,8 +205,28 @@ void __init call_function_init(void)
  */
 static __always_inline void csd_lock_wait(call_single_data_t *csd)
 {
+	int bug_id = 0;
+	u64 ts0, ts1;
+
+	ts1 = ts0 = sched_clock();
+	for (;;) {
+		if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id))
+			break;
+		cpu_relax();
+	}
+	smp_acquire__after_ctrl_dep();
+}
+
+#else
+static void csd_lock_record(call_single_data_t *csd)
+{
+}
+
+static __always_inline void csd_lock_wait(call_single_data_t *csd)
+{
 	smp_cond_load_acquire(&csd->flags, !(VAL & CSD_FLAG_LOCK));
 }
+#endif
 
 static __always_inline void csd_lock(call_single_data_t *csd)
 {
@@ -166,9 +286,11 @@ static int generic_exec_single(int cpu, call_single_data_t *csd)
 		 * We can unlock early even for the synchronous on-stack case,
 		 * since we're doing this from the same CPU..
 		 */
+		csd_lock_record(csd);
 		csd_unlock(csd);
 		local_irq_save(flags);
 		func(info);
+		csd_lock_record(NULL);
 		local_irq_restore(flags);
 		return 0;
 	}
@@ -268,8 +390,10 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 				entry = &csd_next->llist;
 			}
 
+			csd_lock_record(csd);
 			func(info);
 			csd_unlock(csd);
+			csd_lock_record(NULL);
 		} else {
 			prev = &csd->llist;
 		}
@@ -296,8 +420,10 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 				smp_call_func_t func = csd->func;
 				void *info = csd->info;
 
+				csd_lock_record(csd);
 				csd_unlock(csd);
 				func(info);
+				csd_lock_record(NULL);
 			} else if (type == CSD_TYPE_IRQ_WORK) {
 				irq_work_single(csd);
 			}
@@ -375,7 +501,8 @@ int smp_call_function_single(int cpu, smp_call_func_t func, void *info,
 
 	csd->func = func;
 	csd->info = info;
-#ifdef CONFIG_64BIT
+#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
+	csd->src = smp_processor_id();
 	csd->dst = cpu;
 #endif
 
@@ -543,7 +670,8 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 			csd->flags |= CSD_TYPE_SYNC;
 		csd->func = func;
 		csd->info = info;
-#ifdef CONFIG_64BIT
+#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
+		csd->src = smp_processor_id();
 		csd->dst = cpu;
 #endif
 		if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e068c3c..86a35fd 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1367,6 +1367,17 @@ config WW_MUTEX_SELFTEST
 	  Say M if you want these self tests to build as a module.
 	  Say N if you are unsure.
 
+config CSD_LOCK_WAIT_DEBUG
+	bool "Debugging for csd_lock_wait(), called from smp_call_function*()"
+	depends on DEBUG_KERNEL
+	depends on 64BIT
+	default n
+	help
+	  This option enables debug prints when CPUs are slow to respond
+	  to the smp_call_function*() IPI wrappers.  These debug prints
+	  include the IPI handler function currently executing (if any)
+	  and relevant stack traces.
+
 endmenu # lock debugging
 
 config TRACE_IRQFLAGS
