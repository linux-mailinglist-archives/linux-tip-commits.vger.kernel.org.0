Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A76288279
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbgJIGhW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:37:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55574 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732009AbgJIGfh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:37 -0400
Date:   Fri, 09 Oct 2020 06:35:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LCD+6c8+3ymcK/bz3vz/lgr2ihg2SBgpoiurV0rquZM=;
        b=AATTtilaHnkmJ5zMgRcCeLgMotuNHu03T543jlpgHAsv6qqv6IYTGSoKG5/bkYvG7q0fiY
        EORaNrUEg4EL3shVSgiMocK+/EF9wBR+Szq8DCGianSgu9pqzVB+4kicvRN0PTU1hBGZ7g
        vpXh2dO+NEnEr7jdZIHE8H+QDq+G9A5LjDktCNRNDw7lk28cEyk5WDxA64lp6zXnKVzjuC
        F0Ph8N0uODx7j21x98FXvP8MPZrFGVG4tFke8YT40kX5ZTFY9djYSTTwDhOKH+o/Y2B+FD
        1T+xiop0rFcGyMgjEMkc94aFwBALjiLJhrDh3twC3LXMJ0KVMe41Zvq7lO8K2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LCD+6c8+3ymcK/bz3vz/lgr2ihg2SBgpoiurV0rquZM=;
        b=XvpgBeHKXh8e3hy57DB6J4JMi7sPC2fRQUYaxa2UnMXfgLJCMM0IOhlwgqkQFyyTa34DND
        X5TlHrIWu9sMs2Cw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] scftorture: Add smp_call_function() torture test
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222533364.7002.18002004535411920160.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e9d338a0b1799c988b678e8ccb66a442272e6aa3
Gitweb:        https://git.kernel.org/tip/e9d338a0b1799c988b678e8ccb66a442272e6aa3
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 24 Jun 2020 15:59:59 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:38:31 -07:00

scftorture: Add smp_call_function() torture test

This commit adds an smp_call_function() torture test that repeatedly
invokes this function and complains if things go badly awry.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  92 ++++-
 kernel/Makefile                                 |   2 +-
 kernel/scftorture.c                             | 350 +++++++++++++++-
 lib/Kconfig.debug                               |  10 +-
 4 files changed, 454 insertions(+)
 create mode 100644 kernel/scftorture.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bdc1f33..91a5638 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4637,6 +4637,98 @@
 			Format: integer between 0 and 10
 			Default is 0.
 
+	scftorture.holdoff= [KNL]
+			Number of seconds to hold off before starting
+			test.  Defaults to zero for module insertion and
+			to 10 seconds for built-in smp_call_function()
+			tests.
+
+	scftorture.longwait= [KNL]
+			Request ridiculously long waits randomly selected
+			up to the chosen limit in seconds.  Zero (the
+			default) disables this feature.  Please note
+			that requesting even small non-zero numbers of
+			seconds can result in RCU CPU stall warnings,
+			softlockup complaints, and so on.
+
+	scftorture.nthreads= [KNL]
+			Number of kthreads to spawn to invoke the
+			smp_call_function() family of functions.
+			The default of -1 specifies a number of kthreads
+			equal to the number of CPUs.
+
+	scftorture.onoff_holdoff= [KNL]
+			Number seconds to wait after the start of the
+			test before initiating CPU-hotplug operations.
+
+	scftorture.onoff_interval= [KNL]
+			Number seconds to wait between successive
+			CPU-hotplug operations.  Specifying zero (which
+			is the default) disables CPU-hotplug operations.
+
+	scftorture.shutdown_secs= [KNL]
+			The number of seconds following the start of the
+			test after which to shut down the system.  The
+			default of zero avoids shutting down the system.
+			Non-zero values are useful for automated tests.
+
+	scftorture.stat_interval= [KNL]
+			The number of seconds between outputting the
+			current test statistics to the console.  A value
+			of zero disables statistics output.
+
+	scftorture.stutter_cpus= [KNL]
+			The number of jiffies to wait between each change
+			to the set of CPUs under test.
+
+	scftorture.use_cpus_read_lock= [KNL]
+			Use use_cpus_read_lock() instead of the default
+			preempt_disable() to disable CPU hotplug
+			while invoking one of the smp_call_function*()
+			functions.
+
+	scftorture.verbose= [KNL]
+			Enable additional printk() statements.
+
+	scftorture.weight_single= [KNL]
+			The probability weighting to use for the
+			smp_call_function_single() function with a zero
+			"wait" parameter.  A value of -1 selects the
+			default if all other weights are -1.  However,
+			if at least one weight has some other value, a
+			value of -1 will instead select a weight of zero.
+
+	scftorture.weight_single_wait= [KNL]
+			The probability weighting to use for the
+			smp_call_function_single() function with a
+			non-zero "wait" parameter.  See weight_single.
+
+	scftorture.weight_many= [KNL]
+			The probability weighting to use for the
+			smp_call_function_many() function with a zero
+			"wait" parameter.  See weight_single.
+			Note well that setting a high probability for
+			this weighting can place serious IPI load
+			on the system.
+
+	scftorture.weight_many_wait= [KNL]
+			The probability weighting to use for the
+			smp_call_function_many() function with a
+			non-zero "wait" parameter.  See weight_single
+			and weight_many.
+
+	scftorture.weight_all= [KNL]
+			The probability weighting to use for the
+			smp_call_function_all() function with a zero
+			"wait" parameter.  See weight_single and
+			weight_many.
+
+	scftorture.weight_all_wait= [KNL]
+			The probability weighting to use for the
+			smp_call_function_all() function with a
+			non-zero "wait" parameter.  See weight_single
+			and weight_many.
+
 	skew_tick=	[KNL] Offset the periodic timer tick per cpu to mitigate
 			xtime_lock contention on larger systems, and/or RCU lock
 			contention on all systems with CONFIG_MAXSMP set.
diff --git a/kernel/Makefile b/kernel/Makefile
index 9a20016..c45f551 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -133,6 +133,8 @@ KASAN_SANITIZE_stackleak.o := n
 KCSAN_SANITIZE_stackleak.o := n
 KCOV_INSTRUMENT_stackleak.o := n
 
+obj-$(CONFIG_SCF_TORTURE_TEST) += scftorture.o
+
 $(obj)/configs.o: $(obj)/config_data.gz
 
 targets += config_data.gz
diff --git a/kernel/scftorture.c b/kernel/scftorture.c
new file mode 100644
index 0000000..44f1e49
--- /dev/null
+++ b/kernel/scftorture.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Torture test for smp_call_function() and friends.
+//
+// Copyright (C) Facebook, 2020.
+//
+// Author: Paul E. McKenney <paulmck@kernel.org>
+
+#define pr_fmt(fmt) fmt
+
+#include <linux/atomic.h>
+#include <linux/bitops.h>
+#include <linux/completion.h>
+#include <linux/cpu.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kthread.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/notifier.h>
+#include <linux/percpu.h>
+#include <linux/rcupdate.h>
+#include <linux/rcupdate_trace.h>
+#include <linux/reboot.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <linux/stat.h>
+#include <linux/srcu.h>
+#include <linux/slab.h>
+#include <linux/torture.h>
+#include <linux/types.h>
+
+#define SCFTORT_STRING "scftorture"
+#define SCFTORT_FLAG SCFTORT_STRING ": "
+
+#define SCFTORTOUT(s, x...) \
+	pr_alert(SCFTORT_FLAG s, ## x)
+
+#define VERBOSE_SCFTORTOUT(s, x...) \
+	do { if (verbose) pr_alert(SCFTORT_FLAG s, ## x); } while (0)
+
+#define VERBOSE_SCFTORTOUT_ERRSTRING(s, x...) \
+	do { if (verbose) pr_alert(SCFTORT_FLAG "!!! " s, ## x); } while (0)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Paul E. McKenney <paulmck@kernel.org>");
+
+// Wait until there are multiple CPUs before starting test.
+torture_param(int, holdoff, IS_BUILTIN(CONFIG_SCF_TORTURE_TEST) ? 10 : 0,
+	      "Holdoff time before test start (s)");
+torture_param(int, longwait, 0, "Include ridiculously long waits? (seconds)");
+torture_param(int, nthreads, -1, "# threads, defaults to -1 for all CPUs.");
+torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
+torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (s), 0=disable");
+torture_param(int, shutdown_secs, 0, "Shutdown time (ms), <= zero to disable.");
+torture_param(int, stat_interval, 60, "Number of seconds between stats printk()s.");
+torture_param(int, stutter_cpus, 5, "Number of jiffies to change CPUs under test, 0=disable");
+torture_param(bool, use_cpus_read_lock, 0, "Use cpus_read_lock() to exclude CPU hotplug.");
+torture_param(int, verbose, 0, "Enable verbose debugging printk()s");
+torture_param(int, weight_single, -1, "Testing weight for single-CPU no-wait operations.");
+torture_param(int, weight_single_wait, -1, "Testing weight for single-CPU operations.");
+torture_param(int, weight_mult, -1, "Testing weight for multi-CPU no-wait operations.");
+torture_param(int, weight_mult_wait, -1, "Testing weight for multi-CPU operations.");
+torture_param(int, weight_all, -1, "Testing weight for all-CPU no-wait operations.");
+torture_param(int, weight_all_wait, -1, "Testing weight for all-CPU operations.");
+
+char *torture_type = "";
+
+#ifdef MODULE
+# define SCFTORT_SHUTDOWN 0
+#else
+# define SCFTORT_SHUTDOWN 1
+#endif
+
+torture_param(bool, shutdown, SCFTORT_SHUTDOWN, "Shutdown at end of torture test.");
+
+struct scf_statistics {
+	struct task_struct *task;
+	int cpu;
+	long long n_single;
+	long long n_single_wait;
+	long long n_multi;
+	long long n_multi_wait;
+	long long n_all;
+	long long n_all_wait;
+};
+
+static struct scf_statistics *scf_stats_p;
+static struct task_struct *scf_torture_stats_task;
+static DEFINE_PER_CPU(long long, scf_invoked_count);
+
+// Use to wait for all threads to start.
+static atomic_t n_started;
+static atomic_t n_errs;
+static bool scfdone;
+
+DEFINE_TORTURE_RANDOM_PERCPU(scf_torture_rand);
+
+// Print torture statistics.  Caller must ensure serialization.
+static void scf_torture_stats_print(void)
+{
+	int cpu;
+	long long invoked_count = 0;
+	bool isdone = READ_ONCE(scfdone);
+
+	for_each_possible_cpu(cpu)
+		invoked_count += data_race(per_cpu(scf_invoked_count, cpu));
+	pr_alert("%s scf_invoked_count %s: %lld ",
+		 SCFTORT_FLAG, isdone ? "VER" : "ver", invoked_count);
+	torture_onoff_stats();
+	pr_cont("\n");
+}
+
+// Periodically prints torture statistics, if periodic statistics printing
+// was specified via the stat_interval module parameter.
+static int
+scf_torture_stats(void *arg)
+{
+	VERBOSE_TOROUT_STRING("scf_torture_stats task started");
+	do {
+		schedule_timeout_interruptible(stat_interval * HZ);
+		scf_torture_stats_print();
+		torture_shutdown_absorb("scf_torture_stats");
+	} while (!torture_must_stop());
+	torture_kthread_stopping("scf_torture_stats");
+	return 0;
+}
+
+// Update statistics and occasionally burn up mass quantities of CPU time,
+// if told to do so via scftorture.longwait.  Otherwise, occasionally burn
+// a little bit.
+static void scf_handler(void *unused)
+{
+	int i;
+	int j;
+	unsigned long r = torture_random(this_cpu_ptr(&scf_torture_rand));
+
+	this_cpu_inc(scf_invoked_count);
+	if (longwait <= 0) {
+		if (!(r & 0xffc0))
+			udelay(r & 0x3f);
+		return;
+	}
+	if (r & 0xfff)
+		return;
+	r = (r >> 12);
+	if (longwait <= 0) {
+		udelay((r & 0xff) + 1);
+		return;
+	}
+	r = r % longwait + 1;
+	for (i = 0; i < r; i++) {
+		for (j = 0; j < 1000; j++) {
+			udelay(1000);
+			cpu_relax();
+		}
+	}
+}
+
+// Randomly do an smp_call_function*() invocation.
+static void scftorture_invoke_one(struct scf_statistics *scfp,struct torture_random_state *trsp)
+{
+	if (use_cpus_read_lock)
+		cpus_read_lock();
+	else
+		preempt_disable();
+	scfp->n_all++;
+	smp_call_function(scf_handler, NULL, 0);
+	if (use_cpus_read_lock)
+		cpus_read_unlock();
+	else
+		preempt_enable();
+	if (!(torture_random(trsp) & 0xfff))
+		schedule_timeout_uninterruptible(1);
+}
+
+// SCF test kthread.  Repeatedly does calls to members of the
+// smp_call_function() family of functions.
+static int scftorture_invoker(void *arg)
+{
+	DEFINE_TORTURE_RANDOM(rand);
+	struct scf_statistics *scfp = (struct scf_statistics *)arg;
+
+	VERBOSE_SCFTORTOUT("scftorture_invoker %d: task started", scfp->cpu);
+	set_cpus_allowed_ptr(current, cpumask_of(scfp->cpu % nr_cpu_ids));
+	set_user_nice(current, MAX_NICE);
+	if (holdoff)
+		schedule_timeout_interruptible(holdoff * HZ);
+
+	VERBOSE_SCFTORTOUT("scftorture_invoker %d: Waiting for all SCF torturers from cpu %d", scfp->cpu, smp_processor_id());
+
+	// Make sure that the CPU is affinitized appropriately during testing.
+	WARN_ON_ONCE(smp_processor_id() != scfp->cpu);
+
+	if (!atomic_dec_return(&n_started))
+		while (atomic_read_acquire(&n_started)) {
+			if (torture_must_stop()) {
+				VERBOSE_SCFTORTOUT("scftorture_invoker %d ended before starting", scfp->cpu);
+				goto end;
+			}
+			schedule_timeout_uninterruptible(1);
+		}
+
+	VERBOSE_SCFTORTOUT("scftorture_invoker %d started", scfp->cpu);
+
+	do {
+		scftorture_invoke_one(scfp, &rand);
+	} while (!torture_must_stop());
+
+	VERBOSE_SCFTORTOUT("scftorture_invoker %d ended", scfp->cpu);
+end:
+	torture_kthread_stopping("scftorture_invoker");
+	return 0;
+}
+
+static void
+scftorture_print_module_parms(const char *tag)
+{
+	pr_alert(SCFTORT_FLAG
+		 "--- %s:  verbose=%d holdoff=%d longwait=%d nthreads=%d onoff_holdoff=%d onoff_interval=%d shutdown_secs=%d stat_interval=%d stutter_cpus=%d use_cpus_read_lock=%d, weight_single=%d, weight_single_wait=%d, weight_mult=%d, weight_mult_wait=%d, weight_all=%d, weight_all_wait=%d\n", tag,
+		 verbose, holdoff, longwait, nthreads, onoff_holdoff, onoff_interval, shutdown, stat_interval, stutter_cpus, use_cpus_read_lock, weight_single, weight_single_wait, weight_mult, weight_mult_wait, weight_all, weight_all_wait);
+}
+
+static void scf_cleanup_handler(void *unused)
+{
+}
+
+static void scf_torture_cleanup(void)
+{
+	int i;
+
+	if (torture_cleanup_begin())
+		return;
+
+	WRITE_ONCE(scfdone, true);
+	if (nthreads)
+		for (i = 0; i < nthreads; i++)
+			torture_stop_kthread("scftorture_invoker", scf_stats_p[i].task);
+	else
+		goto end;
+	kfree(scf_stats_p);
+	scf_stats_p = NULL;
+	smp_call_function(scf_cleanup_handler, NULL, 0);
+	torture_stop_kthread(scf_torture_stats, scf_torture_stats_task);
+	scf_torture_stats_print();  // -After- the stats thread is stopped!
+
+	if (atomic_read(&n_errs))
+		scftorture_print_module_parms("End of test: FAILURE");
+	else if (torture_onoff_failures())
+		scftorture_print_module_parms("End of test: LOCK_HOTPLUG");
+	else
+		scftorture_print_module_parms("End of test: SUCCESS");
+
+end:
+	torture_cleanup_end();
+}
+
+static int __init scf_torture_init(void)
+{
+	long i;
+	int firsterr = 0;
+
+	if (!torture_init_begin(SCFTORT_STRING, verbose))
+		return -EBUSY;
+
+	scftorture_print_module_parms("Start of test");
+
+	if (weight_single == -1 && weight_single_wait == -1 &&
+	    weight_mult == -1 && weight_mult_wait == -1 &&
+	    weight_all == -1 && weight_all_wait == -1) {
+		weight_single = 1;
+		weight_single_wait = 1;
+		weight_mult = 1;
+		weight_mult_wait = 1;
+		weight_all = 1;
+		weight_all_wait = 1;
+	} else {
+		if (weight_single == -1)
+			weight_single = 0;
+		if (weight_single_wait == -1)
+			weight_single_wait = 0;
+		if (weight_mult == -1)
+			weight_mult = 0;
+		if (weight_mult_wait == -1)
+			weight_mult_wait = 0;
+		if (weight_all == -1)
+			weight_all = 0;
+		if (weight_all_wait == -1)
+			weight_all_wait = 0;
+	}
+	if (weight_single == 0 && weight_single_wait == 0 &&
+	    weight_mult == 0 && weight_mult_wait == 0 &&
+	    weight_all == 0 && weight_all_wait == 0) {
+		firsterr = -EINVAL;
+		goto unwind;
+	}
+
+	if (onoff_interval > 0) {
+		firsterr = torture_onoff_init(onoff_holdoff * HZ, onoff_interval, NULL);
+		if (firsterr)
+			goto unwind;
+	}
+	if (shutdown_secs > 0) {
+		firsterr = torture_shutdown_init(shutdown_secs, scf_torture_cleanup);
+		if (firsterr)
+			goto unwind;
+	}
+
+	// Worker tasks invoking smp_call_function().
+	if (nthreads < 0)
+		nthreads = num_online_cpus();
+	scf_stats_p = kcalloc(nthreads, sizeof(scf_stats_p[0]), GFP_KERNEL);
+	if (!scf_stats_p) {
+		VERBOSE_SCFTORTOUT_ERRSTRING("out of memory");
+		firsterr = -ENOMEM;
+		goto unwind;
+	}
+
+	VERBOSE_SCFTORTOUT("Starting %d smp_call_function() threads\n", nthreads);
+
+	atomic_set(&n_started, nthreads);
+	for (i = 0; i < nthreads; i++) {
+		scf_stats_p[i].cpu = i;
+		firsterr = torture_create_kthread(scftorture_invoker, (void *)&scf_stats_p[i],
+						  scf_stats_p[i].task);
+		if (firsterr)
+			goto unwind;
+	}
+	if (stat_interval > 0) {
+		firsterr = torture_create_kthread(scf_torture_stats, NULL, scf_torture_stats_task);
+		if (firsterr)
+			goto unwind;
+	}
+
+	torture_init_end();
+	return 0;
+
+unwind:
+	torture_init_end();
+	scf_torture_cleanup();
+	return firsterr;
+}
+
+module_init(scf_torture_init);
+module_exit(scf_torture_cleanup);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e068c3c..0c3a6c7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1367,6 +1367,16 @@ config WW_MUTEX_SELFTEST
 	  Say M if you want these self tests to build as a module.
 	  Say N if you are unsure.
 
+config SCF_TORTURE_TEST
+	tristate "torture tests for smp_call_function*()"
+	depends on DEBUG_KERNEL
+	select TORTURE_TEST
+	help
+	  This option provides a kernel module that runs torture tests
+	  on the smp_call_function() family of primitives.  The kernel
+	  module may be built after the fact on the running kernel to
+	  be tested, if desired.
+
 endmenu # lock debugging
 
 config TRACE_IRQFLAGS
