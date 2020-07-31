Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD80234325
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732076AbgGaJ2h (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732272AbgGaJWy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA9AC061574;
        Fri, 31 Jul 2020 02:22:54 -0700 (PDT)
Date:   Fri, 31 Jul 2020 09:22:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Q2lHmbJ4elQJW+PPY7AVM453C0CPysdbQSKxj5xo15M=;
        b=Diejt9WbYmaCNVumpUlY06w5G1J30aZYK3rKA63SbNpgWRFOK8Szs6Vcfq33g0CITIZuDe
        f0xXNyP+7QxXN9eyg7dp1gk0Pl0zdZnz8HsUTtrSuixORm9CZLytiDzZq8GuRzcnuptrp1
        bc61Z2xPYOf+c2NtBfdndMYp5xZJR7Jm0JY1XHG2pd8zdfGPUwGyJP6OyLA9Yct+uv8u8M
        yXg+q2q1cyP6335gCshrRR9Ps/CbA896iNF7/UKexyY4V+zBaV7GmAz+plbEUKOpC9NDQM
        6MfIhllxlJdBb2dW/cKoWboJRgtZsIiUqLAv6eMQRBWcPm2ViWRL2X1pss7CsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Q2lHmbJ4elQJW+PPY7AVM453C0CPysdbQSKxj5xo15M=;
        b=O6JWW3eH1cLCjkA9+ghjiXCCHInx2pJbUvOQjOc86i1gQuxDr2zgBw5akwIvV5lHAY7RUQ
        4e4S15e+TAZbkWDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Rename refperf.c to refscale.c and change
 internal names
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618737193.4006.18420094232516341338.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     1fbeb3a8c4de29433a8d230ee600b13d369b6c0f
Gitweb:        https://git.kernel.org/tip/1fbeb3a8c4de29433a8d230ee600b13d369b6c0f
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 17 Jun 2020 11:53:53 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:46 -07:00

refperf: Rename refperf.c to refscale.c and change internal names

This commit further avoids conflation of refperf with the kernel's perf
feature by renaming kernel/rcu/refperf.c to kernel/rcu/refscale.c,
and also by similarly renaming the functions and variables inside
this file.  This has the side effect of changing the names of the
kernel boot parameters, so kernel-parameters.txt and ver_functions.sh
are also updated.

The rcutorture --torture type remains refperf, and this will be
addressed in a separate commit.

Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt                     |  17 +-
 kernel/rcu/Makefile                                                 |   2 +-
 kernel/rcu/refperf.c                                                | 717 +----------------------------------------------------------------------
 kernel/rcu/refscale.c                                               | 717 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh |   4 +-
 5 files changed, 730 insertions(+), 727 deletions(-)
 delete mode 100644 kernel/rcu/refperf.c
 create mode 100644 kernel/rcu/refscale.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 20cd00b..a4e4e0f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4407,13 +4407,13 @@
 			      reboot_cpu is s[mp]#### with #### being the processor
 					to be used for rebooting.
 
-	refperf.holdoff= [KNL]
+	refscale.holdoff= [KNL]
 			Set test-start holdoff period.  The purpose of
 			this parameter is to delay the start of the
 			test until boot completes in order to avoid
 			interference.
 
-	refperf.loops= [KNL]
+	refscale.loops= [KNL]
 			Set the number of loops over the synchronization
 			primitive under test.  Increasing this number
 			reduces noise due to loop start/end overhead,
@@ -4421,26 +4421,29 @@
 			noise to a handful of picoseconds on ca. 2020
 			x86 laptops.
 
-	refperf.nreaders= [KNL]
+	refscale.nreaders= [KNL]
 			Set number of readers.  The default value of -1
 			selects N, where N is roughly 75% of the number
 			of CPUs.  A value of zero is an interesting choice.
 
-	refperf.nruns= [KNL]
+	refscale.nruns= [KNL]
 			Set number of runs, each of which is dumped onto
 			the console log.
 
-	refperf.readdelay= [KNL]
+	refscale.readdelay= [KNL]
 			Set the read-side critical-section duration,
 			measured in microseconds.
 
-	refperf.shutdown= [KNL]
+	refscale.scale_type= [KNL]
+			Specify the read-protection implementation to test.
+
+	refscale.shutdown= [KNL]
 			Shut down the system at the end of the performance
 			test.  This defaults to 1 (shut it down) when
 			rcuperf is built into the kernel and to 0 (leave
 			it running) when rcuperf is built as a module.
 
-	refperf.verbose= [KNL]
+	refscale.verbose= [KNL]
 			Enable additional printk() statements.
 
 	relax_domain_level=
diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
index 45d562d..95f5117 100644
--- a/kernel/rcu/Makefile
+++ b/kernel/rcu/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_TREE_SRCU) += srcutree.o
 obj-$(CONFIG_TINY_SRCU) += srcutiny.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 obj-$(CONFIG_RCU_PERF_TEST) += rcuperf.o
-obj-$(CONFIG_RCU_REF_SCALE_TEST) += refperf.o
+obj-$(CONFIG_RCU_REF_SCALE_TEST) += refscale.o
 obj-$(CONFIG_TREE_RCU) += tree.o
 obj-$(CONFIG_TINY_RCU) += tiny.o
 obj-$(CONFIG_RCU_NEED_SEGCBLIST) += rcu_segcblist.o
diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
deleted file mode 100644
index 7c98057..0000000
--- a/kernel/rcu/refperf.c
+++ /dev/null
@@ -1,717 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-//
-// Scalability test comparing RCU vs other mechanisms
-// for acquiring references on objects.
-//
-// Copyright (C) Google, 2020.
-//
-// Author: Joel Fernandes <joel@joelfernandes.org>
-
-#define pr_fmt(fmt) fmt
-
-#include <linux/atomic.h>
-#include <linux/bitops.h>
-#include <linux/completion.h>
-#include <linux/cpu.h>
-#include <linux/delay.h>
-#include <linux/err.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/kthread.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/notifier.h>
-#include <linux/percpu.h>
-#include <linux/rcupdate.h>
-#include <linux/rcupdate_trace.h>
-#include <linux/reboot.h>
-#include <linux/sched.h>
-#include <linux/spinlock.h>
-#include <linux/smp.h>
-#include <linux/stat.h>
-#include <linux/srcu.h>
-#include <linux/slab.h>
-#include <linux/torture.h>
-#include <linux/types.h>
-
-#include "rcu.h"
-
-#define PERF_FLAG "-ref-perf: "
-
-#define PERFOUT(s, x...) \
-	pr_alert("%s" PERF_FLAG s, perf_type, ## x)
-
-#define VERBOSE_PERFOUT(s, x...) \
-	do { if (verbose) pr_alert("%s" PERF_FLAG s, perf_type, ## x); } while (0)
-
-#define VERBOSE_PERFOUT_ERRSTRING(s, x...) \
-	do { if (verbose) pr_alert("%s" PERF_FLAG "!!! " s, perf_type, ## x); } while (0)
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Joel Fernandes (Google) <joel@joelfernandes.org>");
-
-static char *perf_type = "rcu";
-module_param(perf_type, charp, 0444);
-MODULE_PARM_DESC(perf_type, "Type of test (rcu, srcu, refcnt, rwsem, rwlock.");
-
-torture_param(int, verbose, 0, "Enable verbose debugging printk()s");
-
-// Wait until there are multiple CPUs before starting test.
-torture_param(int, holdoff, IS_BUILTIN(CONFIG_RCU_REF_SCALE_TEST) ? 10 : 0,
-	      "Holdoff time before test start (s)");
-// Number of loops per experiment, all readers execute operations concurrently.
-torture_param(long, loops, 10000, "Number of loops per experiment.");
-// Number of readers, with -1 defaulting to about 75% of the CPUs.
-torture_param(int, nreaders, -1, "Number of readers, -1 for 75% of CPUs.");
-// Number of runs.
-torture_param(int, nruns, 30, "Number of experiments to run.");
-// Reader delay in nanoseconds, 0 for no delay.
-torture_param(int, readdelay, 0, "Read-side delay in nanoseconds.");
-
-#ifdef MODULE
-# define REFPERF_SHUTDOWN 0
-#else
-# define REFPERF_SHUTDOWN 1
-#endif
-
-torture_param(bool, shutdown, REFPERF_SHUTDOWN,
-	      "Shutdown at end of performance tests.");
-
-struct reader_task {
-	struct task_struct *task;
-	int start_reader;
-	wait_queue_head_t wq;
-	u64 last_duration_ns;
-};
-
-static struct task_struct *shutdown_task;
-static wait_queue_head_t shutdown_wq;
-
-static struct task_struct *main_task;
-static wait_queue_head_t main_wq;
-static int shutdown_start;
-
-static struct reader_task *reader_tasks;
-
-// Number of readers that are part of the current experiment.
-static atomic_t nreaders_exp;
-
-// Use to wait for all threads to start.
-static atomic_t n_init;
-static atomic_t n_started;
-static atomic_t n_warmedup;
-static atomic_t n_cooleddown;
-
-// Track which experiment is currently running.
-static int exp_idx;
-
-// Operations vector for selecting different types of tests.
-struct ref_perf_ops {
-	void (*init)(void);
-	void (*cleanup)(void);
-	void (*readsection)(const int nloops);
-	void (*delaysection)(const int nloops, const int udl, const int ndl);
-	const char *name;
-};
-
-static struct ref_perf_ops *cur_ops;
-
-static void un_delay(const int udl, const int ndl)
-{
-	if (udl)
-		udelay(udl);
-	if (ndl)
-		ndelay(ndl);
-}
-
-static void ref_rcu_read_section(const int nloops)
-{
-	int i;
-
-	for (i = nloops; i >= 0; i--) {
-		rcu_read_lock();
-		rcu_read_unlock();
-	}
-}
-
-static void ref_rcu_delay_section(const int nloops, const int udl, const int ndl)
-{
-	int i;
-
-	for (i = nloops; i >= 0; i--) {
-		rcu_read_lock();
-		un_delay(udl, ndl);
-		rcu_read_unlock();
-	}
-}
-
-static void rcu_sync_perf_init(void)
-{
-}
-
-static struct ref_perf_ops rcu_ops = {
-	.init		= rcu_sync_perf_init,
-	.readsection	= ref_rcu_read_section,
-	.delaysection	= ref_rcu_delay_section,
-	.name		= "rcu"
-};
-
-// Definitions for SRCU ref perf testing.
-DEFINE_STATIC_SRCU(srcu_refctl_perf);
-static struct srcu_struct *srcu_ctlp = &srcu_refctl_perf;
-
-static void srcu_ref_perf_read_section(const int nloops)
-{
-	int i;
-	int idx;
-
-	for (i = nloops; i >= 0; i--) {
-		idx = srcu_read_lock(srcu_ctlp);
-		srcu_read_unlock(srcu_ctlp, idx);
-	}
-}
-
-static void srcu_ref_perf_delay_section(const int nloops, const int udl, const int ndl)
-{
-	int i;
-	int idx;
-
-	for (i = nloops; i >= 0; i--) {
-		idx = srcu_read_lock(srcu_ctlp);
-		un_delay(udl, ndl);
-		srcu_read_unlock(srcu_ctlp, idx);
-	}
-}
-
-static struct ref_perf_ops srcu_ops = {
-	.init		= rcu_sync_perf_init,
-	.readsection	= srcu_ref_perf_read_section,
-	.delaysection	= srcu_ref_perf_delay_section,
-	.name		= "srcu"
-};
-
-// Definitions for RCU Tasks ref perf testing: Empty read markers.
-// These definitions also work for RCU Rude readers.
-static void rcu_tasks_ref_perf_read_section(const int nloops)
-{
-	int i;
-
-	for (i = nloops; i >= 0; i--)
-		continue;
-}
-
-static void rcu_tasks_ref_perf_delay_section(const int nloops, const int udl, const int ndl)
-{
-	int i;
-
-	for (i = nloops; i >= 0; i--)
-		un_delay(udl, ndl);
-}
-
-static struct ref_perf_ops rcu_tasks_ops = {
-	.init		= rcu_sync_perf_init,
-	.readsection	= rcu_tasks_ref_perf_read_section,
-	.delaysection	= rcu_tasks_ref_perf_delay_section,
-	.name		= "rcu-tasks"
-};
-
-// Definitions for RCU Tasks Trace ref perf testing.
-static void rcu_trace_ref_perf_read_section(const int nloops)
-{
-	int i;
-
-	for (i = nloops; i >= 0; i--) {
-		rcu_read_lock_trace();
-		rcu_read_unlock_trace();
-	}
-}
-
-static void rcu_trace_ref_perf_delay_section(const int nloops, const int udl, const int ndl)
-{
-	int i;
-
-	for (i = nloops; i >= 0; i--) {
-		rcu_read_lock_trace();
-		un_delay(udl, ndl);
-		rcu_read_unlock_trace();
-	}
-}
-
-static struct ref_perf_ops rcu_trace_ops = {
-	.init		= rcu_sync_perf_init,
-	.readsection	= rcu_trace_ref_perf_read_section,
-	.delaysection	= rcu_trace_ref_perf_delay_section,
-	.name		= "rcu-trace"
-};
-
-// Definitions for reference count
-static atomic_t refcnt;
-
-static void ref_refcnt_section(const int nloops)
-{
-	int i;
-
-	for (i = nloops; i >= 0; i--) {
-		atomic_inc(&refcnt);
-		atomic_dec(&refcnt);
-	}
-}
-
-static void ref_refcnt_delay_section(const int nloops, const int udl, const int ndl)
-{
-	int i;
-
-	for (i = nloops; i >= 0; i--) {
-		atomic_inc(&refcnt);
-		un_delay(udl, ndl);
-		atomic_dec(&refcnt);
-	}
-}
-
-static struct ref_perf_ops refcnt_ops = {
-	.init		= rcu_sync_perf_init,
-	.readsection	= ref_refcnt_section,
-	.delaysection	= ref_refcnt_delay_section,
-	.name		= "refcnt"
-};
-
-// Definitions for rwlock
-static rwlock_t test_rwlock;
-
-static void ref_rwlock_init(void)
-{
-	rwlock_init(&test_rwlock);
-}
-
-static void ref_rwlock_section(const int nloops)
-{
-	int i;
-
-	for (i = nloops; i >= 0; i--) {
-		read_lock(&test_rwlock);
-		read_unlock(&test_rwlock);
-	}
-}
-
-static void ref_rwlock_delay_section(const int nloops, const int udl, const int ndl)
-{
-	int i;
-
-	for (i = nloops; i >= 0; i--) {
-		read_lock(&test_rwlock);
-		un_delay(udl, ndl);
-		read_unlock(&test_rwlock);
-	}
-}
-
-static struct ref_perf_ops rwlock_ops = {
-	.init		= ref_rwlock_init,
-	.readsection	= ref_rwlock_section,
-	.delaysection	= ref_rwlock_delay_section,
-	.name		= "rwlock"
-};
-
-// Definitions for rwsem
-static struct rw_semaphore test_rwsem;
-
-static void ref_rwsem_init(void)
-{
-	init_rwsem(&test_rwsem);
-}
-
-static void ref_rwsem_section(const int nloops)
-{
-	int i;
-
-	for (i = nloops; i >= 0; i--) {
-		down_read(&test_rwsem);
-		up_read(&test_rwsem);
-	}
-}
-
-static void ref_rwsem_delay_section(const int nloops, const int udl, const int ndl)
-{
-	int i;
-
-	for (i = nloops; i >= 0; i--) {
-		down_read(&test_rwsem);
-		un_delay(udl, ndl);
-		up_read(&test_rwsem);
-	}
-}
-
-static struct ref_perf_ops rwsem_ops = {
-	.init		= ref_rwsem_init,
-	.readsection	= ref_rwsem_section,
-	.delaysection	= ref_rwsem_delay_section,
-	.name		= "rwsem"
-};
-
-static void rcu_perf_one_reader(void)
-{
-	if (readdelay <= 0)
-		cur_ops->readsection(loops);
-	else
-		cur_ops->delaysection(loops, readdelay / 1000, readdelay % 1000);
-}
-
-// Reader kthread.  Repeatedly does empty RCU read-side
-// critical section, minimizing update-side interference.
-static int
-ref_perf_reader(void *arg)
-{
-	unsigned long flags;
-	long me = (long)arg;
-	struct reader_task *rt = &(reader_tasks[me]);
-	u64 start;
-	s64 duration;
-
-	VERBOSE_PERFOUT("ref_perf_reader %ld: task started", me);
-	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
-	set_user_nice(current, MAX_NICE);
-	atomic_inc(&n_init);
-	if (holdoff)
-		schedule_timeout_interruptible(holdoff * HZ);
-repeat:
-	VERBOSE_PERFOUT("ref_perf_reader %ld: waiting to start next experiment on cpu %d", me, smp_processor_id());
-
-	// Wait for signal that this reader can start.
-	wait_event(rt->wq, (atomic_read(&nreaders_exp) && smp_load_acquire(&rt->start_reader)) ||
-			   torture_must_stop());
-
-	if (torture_must_stop())
-		goto end;
-
-	// Make sure that the CPU is affinitized appropriately during testing.
-	WARN_ON_ONCE(smp_processor_id() != me);
-
-	WRITE_ONCE(rt->start_reader, 0);
-	if (!atomic_dec_return(&n_started))
-		while (atomic_read_acquire(&n_started))
-			cpu_relax();
-
-	VERBOSE_PERFOUT("ref_perf_reader %ld: experiment %d started", me, exp_idx);
-
-
-	// To reduce noise, do an initial cache-warming invocation, check
-	// in, and then keep warming until everyone has checked in.
-	rcu_perf_one_reader();
-	if (!atomic_dec_return(&n_warmedup))
-		while (atomic_read_acquire(&n_warmedup))
-			rcu_perf_one_reader();
-	// Also keep interrupts disabled.  This also has the effect
-	// of preventing entries into slow path for rcu_read_unlock().
-	local_irq_save(flags);
-	start = ktime_get_mono_fast_ns();
-
-	rcu_perf_one_reader();
-
-	duration = ktime_get_mono_fast_ns() - start;
-	local_irq_restore(flags);
-
-	rt->last_duration_ns = WARN_ON_ONCE(duration < 0) ? 0 : duration;
-	// To reduce runtime-skew noise, do maintain-load invocations until
-	// everyone is done.
-	if (!atomic_dec_return(&n_cooleddown))
-		while (atomic_read_acquire(&n_cooleddown))
-			rcu_perf_one_reader();
-
-	if (atomic_dec_and_test(&nreaders_exp))
-		wake_up(&main_wq);
-
-	VERBOSE_PERFOUT("ref_perf_reader %ld: experiment %d ended, (readers remaining=%d)",
-			me, exp_idx, atomic_read(&nreaders_exp));
-
-	if (!torture_must_stop())
-		goto repeat;
-end:
-	torture_kthread_stopping("ref_perf_reader");
-	return 0;
-}
-
-static void reset_readers(void)
-{
-	int i;
-	struct reader_task *rt;
-
-	for (i = 0; i < nreaders; i++) {
-		rt = &(reader_tasks[i]);
-
-		rt->last_duration_ns = 0;
-	}
-}
-
-// Print the results of each reader and return the sum of all their durations.
-static u64 process_durations(int n)
-{
-	int i;
-	struct reader_task *rt;
-	char buf1[64];
-	char *buf;
-	u64 sum = 0;
-
-	buf = kmalloc(128 + nreaders * 32, GFP_KERNEL);
-	if (!buf)
-		return 0;
-	buf[0] = 0;
-	sprintf(buf, "Experiment #%d (Format: <THREAD-NUM>:<Total loop time in ns>)",
-		exp_idx);
-
-	for (i = 0; i < n && !torture_must_stop(); i++) {
-		rt = &(reader_tasks[i]);
-		sprintf(buf1, "%d: %llu\t", i, rt->last_duration_ns);
-
-		if (i % 5 == 0)
-			strcat(buf, "\n");
-		strcat(buf, buf1);
-
-		sum += rt->last_duration_ns;
-	}
-	strcat(buf, "\n");
-
-	PERFOUT("%s\n", buf);
-
-	kfree(buf);
-	return sum;
-}
-
-// The main_func is the main orchestrator, it performs a bunch of
-// experiments.  For every experiment, it orders all the readers
-// involved to start and waits for them to finish the experiment. It
-// then reads their timestamps and starts the next experiment. Each
-// experiment progresses from 1 concurrent reader to N of them at which
-// point all the timestamps are printed.
-static int main_func(void *arg)
-{
-	bool errexit = false;
-	int exp, r;
-	char buf1[64];
-	char *buf;
-	u64 *result_avg;
-
-	set_cpus_allowed_ptr(current, cpumask_of(nreaders % nr_cpu_ids));
-	set_user_nice(current, MAX_NICE);
-
-	VERBOSE_PERFOUT("main_func task started");
-	result_avg = kzalloc(nruns * sizeof(*result_avg), GFP_KERNEL);
-	buf = kzalloc(64 + nruns * 32, GFP_KERNEL);
-	if (!result_avg || !buf) {
-		VERBOSE_PERFOUT_ERRSTRING("out of memory");
-		errexit = true;
-	}
-	if (holdoff)
-		schedule_timeout_interruptible(holdoff * HZ);
-
-	// Wait for all threads to start.
-	atomic_inc(&n_init);
-	while (atomic_read(&n_init) < nreaders + 1)
-		schedule_timeout_uninterruptible(1);
-
-	// Start exp readers up per experiment
-	for (exp = 0; exp < nruns && !torture_must_stop(); exp++) {
-		if (errexit)
-			break;
-		if (torture_must_stop())
-			goto end;
-
-		reset_readers();
-		atomic_set(&nreaders_exp, nreaders);
-		atomic_set(&n_started, nreaders);
-		atomic_set(&n_warmedup, nreaders);
-		atomic_set(&n_cooleddown, nreaders);
-
-		exp_idx = exp;
-
-		for (r = 0; r < nreaders; r++) {
-			smp_store_release(&reader_tasks[r].start_reader, 1);
-			wake_up(&reader_tasks[r].wq);
-		}
-
-		VERBOSE_PERFOUT("main_func: experiment started, waiting for %d readers",
-				nreaders);
-
-		wait_event(main_wq,
-			   !atomic_read(&nreaders_exp) || torture_must_stop());
-
-		VERBOSE_PERFOUT("main_func: experiment ended");
-
-		if (torture_must_stop())
-			goto end;
-
-		result_avg[exp] = div_u64(1000 * process_durations(nreaders), nreaders * loops);
-	}
-
-	// Print the average of all experiments
-	PERFOUT("END OF TEST. Calculating average duration per loop (nanoseconds)...\n");
-
-	buf[0] = 0;
-	strcat(buf, "\n");
-	strcat(buf, "Runs\tTime(ns)\n");
-
-	for (exp = 0; exp < nruns; exp++) {
-		u64 avg;
-		u32 rem;
-
-		if (errexit)
-			break;
-		avg = div_u64_rem(result_avg[exp], 1000, &rem);
-		sprintf(buf1, "%d\t%llu.%03u\n", exp + 1, avg, rem);
-		strcat(buf, buf1);
-	}
-
-	if (!errexit)
-		PERFOUT("%s", buf);
-
-	// This will shutdown everything including us.
-	if (shutdown) {
-		shutdown_start = 1;
-		wake_up(&shutdown_wq);
-	}
-
-	// Wait for torture to stop us
-	while (!torture_must_stop())
-		schedule_timeout_uninterruptible(1);
-
-end:
-	torture_kthread_stopping("main_func");
-	kfree(result_avg);
-	kfree(buf);
-	return 0;
-}
-
-static void
-ref_perf_print_module_parms(struct ref_perf_ops *cur_ops, const char *tag)
-{
-	pr_alert("%s" PERF_FLAG
-		 "--- %s:  verbose=%d shutdown=%d holdoff=%d loops=%ld nreaders=%d nruns=%d readdelay=%d\n", perf_type, tag,
-		 verbose, shutdown, holdoff, loops, nreaders, nruns, readdelay);
-}
-
-static void
-ref_perf_cleanup(void)
-{
-	int i;
-
-	if (torture_cleanup_begin())
-		return;
-
-	if (!cur_ops) {
-		torture_cleanup_end();
-		return;
-	}
-
-	if (reader_tasks) {
-		for (i = 0; i < nreaders; i++)
-			torture_stop_kthread("ref_perf_reader",
-					     reader_tasks[i].task);
-	}
-	kfree(reader_tasks);
-
-	torture_stop_kthread("main_task", main_task);
-	kfree(main_task);
-
-	// Do perf-type-specific cleanup operations.
-	if (cur_ops->cleanup != NULL)
-		cur_ops->cleanup();
-
-	torture_cleanup_end();
-}
-
-// Shutdown kthread.  Just waits to be awakened, then shuts down system.
-static int
-ref_perf_shutdown(void *arg)
-{
-	wait_event(shutdown_wq, shutdown_start);
-
-	smp_mb(); // Wake before output.
-	ref_perf_cleanup();
-	kernel_power_off();
-
-	return -EINVAL;
-}
-
-static int __init
-ref_perf_init(void)
-{
-	long i;
-	int firsterr = 0;
-	static struct ref_perf_ops *perf_ops[] = {
-		&rcu_ops, &srcu_ops, &rcu_trace_ops, &rcu_tasks_ops,
-		&refcnt_ops, &rwlock_ops, &rwsem_ops,
-	};
-
-	if (!torture_init_begin(perf_type, verbose))
-		return -EBUSY;
-
-	for (i = 0; i < ARRAY_SIZE(perf_ops); i++) {
-		cur_ops = perf_ops[i];
-		if (strcmp(perf_type, cur_ops->name) == 0)
-			break;
-	}
-	if (i == ARRAY_SIZE(perf_ops)) {
-		pr_alert("rcu-perf: invalid perf type: \"%s\"\n", perf_type);
-		pr_alert("rcu-perf types:");
-		for (i = 0; i < ARRAY_SIZE(perf_ops); i++)
-			pr_cont(" %s", perf_ops[i]->name);
-		pr_cont("\n");
-		WARN_ON(!IS_MODULE(CONFIG_RCU_REF_SCALE_TEST));
-		firsterr = -EINVAL;
-		cur_ops = NULL;
-		goto unwind;
-	}
-	if (cur_ops->init)
-		cur_ops->init();
-
-	ref_perf_print_module_parms(cur_ops, "Start of test");
-
-	// Shutdown task
-	if (shutdown) {
-		init_waitqueue_head(&shutdown_wq);
-		firsterr = torture_create_kthread(ref_perf_shutdown, NULL,
-						  shutdown_task);
-		if (firsterr)
-			goto unwind;
-		schedule_timeout_uninterruptible(1);
-	}
-
-	// Reader tasks (default to ~75% of online CPUs).
-	if (nreaders < 0)
-		nreaders = (num_online_cpus() >> 1) + (num_online_cpus() >> 2);
-	reader_tasks = kcalloc(nreaders, sizeof(reader_tasks[0]),
-			       GFP_KERNEL);
-	if (!reader_tasks) {
-		VERBOSE_PERFOUT_ERRSTRING("out of memory");
-		firsterr = -ENOMEM;
-		goto unwind;
-	}
-
-	VERBOSE_PERFOUT("Starting %d reader threads\n", nreaders);
-
-	for (i = 0; i < nreaders; i++) {
-		firsterr = torture_create_kthread(ref_perf_reader, (void *)i,
-						  reader_tasks[i].task);
-		if (firsterr)
-			goto unwind;
-
-		init_waitqueue_head(&(reader_tasks[i].wq));
-	}
-
-	// Main Task
-	init_waitqueue_head(&main_wq);
-	firsterr = torture_create_kthread(main_func, NULL, main_task);
-	if (firsterr)
-		goto unwind;
-
-	torture_init_end();
-	return 0;
-
-unwind:
-	torture_init_end();
-	ref_perf_cleanup();
-	return firsterr;
-}
-
-module_init(ref_perf_init);
-module_exit(ref_perf_cleanup);
diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
new file mode 100644
index 0000000..d9291f8
--- /dev/null
+++ b/kernel/rcu/refscale.c
@@ -0,0 +1,717 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Scalability test comparing RCU vs other mechanisms
+// for acquiring references on objects.
+//
+// Copyright (C) Google, 2020.
+//
+// Author: Joel Fernandes <joel@joelfernandes.org>
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
+#include "rcu.h"
+
+#define SCALE_FLAG "-ref-scale: "
+
+#define SCALEOUT(s, x...) \
+	pr_alert("%s" SCALE_FLAG s, scale_type, ## x)
+
+#define VERBOSE_SCALEOUT(s, x...) \
+	do { if (verbose) pr_alert("%s" SCALE_FLAG s, scale_type, ## x); } while (0)
+
+#define VERBOSE_SCALEOUT_ERRSTRING(s, x...) \
+	do { if (verbose) pr_alert("%s" SCALE_FLAG "!!! " s, scale_type, ## x); } while (0)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Joel Fernandes (Google) <joel@joelfernandes.org>");
+
+static char *scale_type = "rcu";
+module_param(scale_type, charp, 0444);
+MODULE_PARM_DESC(scale_type, "Type of test (rcu, srcu, refcnt, rwsem, rwlock.");
+
+torture_param(int, verbose, 0, "Enable verbose debugging printk()s");
+
+// Wait until there are multiple CPUs before starting test.
+torture_param(int, holdoff, IS_BUILTIN(CONFIG_RCU_REF_SCALE_TEST) ? 10 : 0,
+	      "Holdoff time before test start (s)");
+// Number of loops per experiment, all readers execute operations concurrently.
+torture_param(long, loops, 10000, "Number of loops per experiment.");
+// Number of readers, with -1 defaulting to about 75% of the CPUs.
+torture_param(int, nreaders, -1, "Number of readers, -1 for 75% of CPUs.");
+// Number of runs.
+torture_param(int, nruns, 30, "Number of experiments to run.");
+// Reader delay in nanoseconds, 0 for no delay.
+torture_param(int, readdelay, 0, "Read-side delay in nanoseconds.");
+
+#ifdef MODULE
+# define REFSCALE_SHUTDOWN 0
+#else
+# define REFSCALE_SHUTDOWN 1
+#endif
+
+torture_param(bool, shutdown, REFSCALE_SHUTDOWN,
+	      "Shutdown at end of scalability tests.");
+
+struct reader_task {
+	struct task_struct *task;
+	int start_reader;
+	wait_queue_head_t wq;
+	u64 last_duration_ns;
+};
+
+static struct task_struct *shutdown_task;
+static wait_queue_head_t shutdown_wq;
+
+static struct task_struct *main_task;
+static wait_queue_head_t main_wq;
+static int shutdown_start;
+
+static struct reader_task *reader_tasks;
+
+// Number of readers that are part of the current experiment.
+static atomic_t nreaders_exp;
+
+// Use to wait for all threads to start.
+static atomic_t n_init;
+static atomic_t n_started;
+static atomic_t n_warmedup;
+static atomic_t n_cooleddown;
+
+// Track which experiment is currently running.
+static int exp_idx;
+
+// Operations vector for selecting different types of tests.
+struct ref_scale_ops {
+	void (*init)(void);
+	void (*cleanup)(void);
+	void (*readsection)(const int nloops);
+	void (*delaysection)(const int nloops, const int udl, const int ndl);
+	const char *name;
+};
+
+static struct ref_scale_ops *cur_ops;
+
+static void un_delay(const int udl, const int ndl)
+{
+	if (udl)
+		udelay(udl);
+	if (ndl)
+		ndelay(ndl);
+}
+
+static void ref_rcu_read_section(const int nloops)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		rcu_read_lock();
+		rcu_read_unlock();
+	}
+}
+
+static void ref_rcu_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		rcu_read_lock();
+		un_delay(udl, ndl);
+		rcu_read_unlock();
+	}
+}
+
+static void rcu_sync_scale_init(void)
+{
+}
+
+static struct ref_scale_ops rcu_ops = {
+	.init		= rcu_sync_scale_init,
+	.readsection	= ref_rcu_read_section,
+	.delaysection	= ref_rcu_delay_section,
+	.name		= "rcu"
+};
+
+// Definitions for SRCU ref scale testing.
+DEFINE_STATIC_SRCU(srcu_refctl_scale);
+static struct srcu_struct *srcu_ctlp = &srcu_refctl_scale;
+
+static void srcu_ref_scale_read_section(const int nloops)
+{
+	int i;
+	int idx;
+
+	for (i = nloops; i >= 0; i--) {
+		idx = srcu_read_lock(srcu_ctlp);
+		srcu_read_unlock(srcu_ctlp, idx);
+	}
+}
+
+static void srcu_ref_scale_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+	int idx;
+
+	for (i = nloops; i >= 0; i--) {
+		idx = srcu_read_lock(srcu_ctlp);
+		un_delay(udl, ndl);
+		srcu_read_unlock(srcu_ctlp, idx);
+	}
+}
+
+static struct ref_scale_ops srcu_ops = {
+	.init		= rcu_sync_scale_init,
+	.readsection	= srcu_ref_scale_read_section,
+	.delaysection	= srcu_ref_scale_delay_section,
+	.name		= "srcu"
+};
+
+// Definitions for RCU Tasks ref scale testing: Empty read markers.
+// These definitions also work for RCU Rude readers.
+static void rcu_tasks_ref_scale_read_section(const int nloops)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--)
+		continue;
+}
+
+static void rcu_tasks_ref_scale_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--)
+		un_delay(udl, ndl);
+}
+
+static struct ref_scale_ops rcu_tasks_ops = {
+	.init		= rcu_sync_scale_init,
+	.readsection	= rcu_tasks_ref_scale_read_section,
+	.delaysection	= rcu_tasks_ref_scale_delay_section,
+	.name		= "rcu-tasks"
+};
+
+// Definitions for RCU Tasks Trace ref scale testing.
+static void rcu_trace_ref_scale_read_section(const int nloops)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		rcu_read_lock_trace();
+		rcu_read_unlock_trace();
+	}
+}
+
+static void rcu_trace_ref_scale_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		rcu_read_lock_trace();
+		un_delay(udl, ndl);
+		rcu_read_unlock_trace();
+	}
+}
+
+static struct ref_scale_ops rcu_trace_ops = {
+	.init		= rcu_sync_scale_init,
+	.readsection	= rcu_trace_ref_scale_read_section,
+	.delaysection	= rcu_trace_ref_scale_delay_section,
+	.name		= "rcu-trace"
+};
+
+// Definitions for reference count
+static atomic_t refcnt;
+
+static void ref_refcnt_section(const int nloops)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		atomic_inc(&refcnt);
+		atomic_dec(&refcnt);
+	}
+}
+
+static void ref_refcnt_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		atomic_inc(&refcnt);
+		un_delay(udl, ndl);
+		atomic_dec(&refcnt);
+	}
+}
+
+static struct ref_scale_ops refcnt_ops = {
+	.init		= rcu_sync_scale_init,
+	.readsection	= ref_refcnt_section,
+	.delaysection	= ref_refcnt_delay_section,
+	.name		= "refcnt"
+};
+
+// Definitions for rwlock
+static rwlock_t test_rwlock;
+
+static void ref_rwlock_init(void)
+{
+	rwlock_init(&test_rwlock);
+}
+
+static void ref_rwlock_section(const int nloops)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		read_lock(&test_rwlock);
+		read_unlock(&test_rwlock);
+	}
+}
+
+static void ref_rwlock_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		read_lock(&test_rwlock);
+		un_delay(udl, ndl);
+		read_unlock(&test_rwlock);
+	}
+}
+
+static struct ref_scale_ops rwlock_ops = {
+	.init		= ref_rwlock_init,
+	.readsection	= ref_rwlock_section,
+	.delaysection	= ref_rwlock_delay_section,
+	.name		= "rwlock"
+};
+
+// Definitions for rwsem
+static struct rw_semaphore test_rwsem;
+
+static void ref_rwsem_init(void)
+{
+	init_rwsem(&test_rwsem);
+}
+
+static void ref_rwsem_section(const int nloops)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		down_read(&test_rwsem);
+		up_read(&test_rwsem);
+	}
+}
+
+static void ref_rwsem_delay_section(const int nloops, const int udl, const int ndl)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		down_read(&test_rwsem);
+		un_delay(udl, ndl);
+		up_read(&test_rwsem);
+	}
+}
+
+static struct ref_scale_ops rwsem_ops = {
+	.init		= ref_rwsem_init,
+	.readsection	= ref_rwsem_section,
+	.delaysection	= ref_rwsem_delay_section,
+	.name		= "rwsem"
+};
+
+static void rcu_scale_one_reader(void)
+{
+	if (readdelay <= 0)
+		cur_ops->readsection(loops);
+	else
+		cur_ops->delaysection(loops, readdelay / 1000, readdelay % 1000);
+}
+
+// Reader kthread.  Repeatedly does empty RCU read-side
+// critical section, minimizing update-side interference.
+static int
+ref_scale_reader(void *arg)
+{
+	unsigned long flags;
+	long me = (long)arg;
+	struct reader_task *rt = &(reader_tasks[me]);
+	u64 start;
+	s64 duration;
+
+	VERBOSE_SCALEOUT("ref_scale_reader %ld: task started", me);
+	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
+	set_user_nice(current, MAX_NICE);
+	atomic_inc(&n_init);
+	if (holdoff)
+		schedule_timeout_interruptible(holdoff * HZ);
+repeat:
+	VERBOSE_SCALEOUT("ref_scale_reader %ld: waiting to start next experiment on cpu %d", me, smp_processor_id());
+
+	// Wait for signal that this reader can start.
+	wait_event(rt->wq, (atomic_read(&nreaders_exp) && smp_load_acquire(&rt->start_reader)) ||
+			   torture_must_stop());
+
+	if (torture_must_stop())
+		goto end;
+
+	// Make sure that the CPU is affinitized appropriately during testing.
+	WARN_ON_ONCE(smp_processor_id() != me);
+
+	WRITE_ONCE(rt->start_reader, 0);
+	if (!atomic_dec_return(&n_started))
+		while (atomic_read_acquire(&n_started))
+			cpu_relax();
+
+	VERBOSE_SCALEOUT("ref_scale_reader %ld: experiment %d started", me, exp_idx);
+
+
+	// To reduce noise, do an initial cache-warming invocation, check
+	// in, and then keep warming until everyone has checked in.
+	rcu_scale_one_reader();
+	if (!atomic_dec_return(&n_warmedup))
+		while (atomic_read_acquire(&n_warmedup))
+			rcu_scale_one_reader();
+	// Also keep interrupts disabled.  This also has the effect
+	// of preventing entries into slow path for rcu_read_unlock().
+	local_irq_save(flags);
+	start = ktime_get_mono_fast_ns();
+
+	rcu_scale_one_reader();
+
+	duration = ktime_get_mono_fast_ns() - start;
+	local_irq_restore(flags);
+
+	rt->last_duration_ns = WARN_ON_ONCE(duration < 0) ? 0 : duration;
+	// To reduce runtime-skew noise, do maintain-load invocations until
+	// everyone is done.
+	if (!atomic_dec_return(&n_cooleddown))
+		while (atomic_read_acquire(&n_cooleddown))
+			rcu_scale_one_reader();
+
+	if (atomic_dec_and_test(&nreaders_exp))
+		wake_up(&main_wq);
+
+	VERBOSE_SCALEOUT("ref_scale_reader %ld: experiment %d ended, (readers remaining=%d)",
+			me, exp_idx, atomic_read(&nreaders_exp));
+
+	if (!torture_must_stop())
+		goto repeat;
+end:
+	torture_kthread_stopping("ref_scale_reader");
+	return 0;
+}
+
+static void reset_readers(void)
+{
+	int i;
+	struct reader_task *rt;
+
+	for (i = 0; i < nreaders; i++) {
+		rt = &(reader_tasks[i]);
+
+		rt->last_duration_ns = 0;
+	}
+}
+
+// Print the results of each reader and return the sum of all their durations.
+static u64 process_durations(int n)
+{
+	int i;
+	struct reader_task *rt;
+	char buf1[64];
+	char *buf;
+	u64 sum = 0;
+
+	buf = kmalloc(128 + nreaders * 32, GFP_KERNEL);
+	if (!buf)
+		return 0;
+	buf[0] = 0;
+	sprintf(buf, "Experiment #%d (Format: <THREAD-NUM>:<Total loop time in ns>)",
+		exp_idx);
+
+	for (i = 0; i < n && !torture_must_stop(); i++) {
+		rt = &(reader_tasks[i]);
+		sprintf(buf1, "%d: %llu\t", i, rt->last_duration_ns);
+
+		if (i % 5 == 0)
+			strcat(buf, "\n");
+		strcat(buf, buf1);
+
+		sum += rt->last_duration_ns;
+	}
+	strcat(buf, "\n");
+
+	SCALEOUT("%s\n", buf);
+
+	kfree(buf);
+	return sum;
+}
+
+// The main_func is the main orchestrator, it performs a bunch of
+// experiments.  For every experiment, it orders all the readers
+// involved to start and waits for them to finish the experiment. It
+// then reads their timestamps and starts the next experiment. Each
+// experiment progresses from 1 concurrent reader to N of them at which
+// point all the timestamps are printed.
+static int main_func(void *arg)
+{
+	bool errexit = false;
+	int exp, r;
+	char buf1[64];
+	char *buf;
+	u64 *result_avg;
+
+	set_cpus_allowed_ptr(current, cpumask_of(nreaders % nr_cpu_ids));
+	set_user_nice(current, MAX_NICE);
+
+	VERBOSE_SCALEOUT("main_func task started");
+	result_avg = kzalloc(nruns * sizeof(*result_avg), GFP_KERNEL);
+	buf = kzalloc(64 + nruns * 32, GFP_KERNEL);
+	if (!result_avg || !buf) {
+		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
+		errexit = true;
+	}
+	if (holdoff)
+		schedule_timeout_interruptible(holdoff * HZ);
+
+	// Wait for all threads to start.
+	atomic_inc(&n_init);
+	while (atomic_read(&n_init) < nreaders + 1)
+		schedule_timeout_uninterruptible(1);
+
+	// Start exp readers up per experiment
+	for (exp = 0; exp < nruns && !torture_must_stop(); exp++) {
+		if (errexit)
+			break;
+		if (torture_must_stop())
+			goto end;
+
+		reset_readers();
+		atomic_set(&nreaders_exp, nreaders);
+		atomic_set(&n_started, nreaders);
+		atomic_set(&n_warmedup, nreaders);
+		atomic_set(&n_cooleddown, nreaders);
+
+		exp_idx = exp;
+
+		for (r = 0; r < nreaders; r++) {
+			smp_store_release(&reader_tasks[r].start_reader, 1);
+			wake_up(&reader_tasks[r].wq);
+		}
+
+		VERBOSE_SCALEOUT("main_func: experiment started, waiting for %d readers",
+				nreaders);
+
+		wait_event(main_wq,
+			   !atomic_read(&nreaders_exp) || torture_must_stop());
+
+		VERBOSE_SCALEOUT("main_func: experiment ended");
+
+		if (torture_must_stop())
+			goto end;
+
+		result_avg[exp] = div_u64(1000 * process_durations(nreaders), nreaders * loops);
+	}
+
+	// Print the average of all experiments
+	SCALEOUT("END OF TEST. Calculating average duration per loop (nanoseconds)...\n");
+
+	buf[0] = 0;
+	strcat(buf, "\n");
+	strcat(buf, "Runs\tTime(ns)\n");
+
+	for (exp = 0; exp < nruns; exp++) {
+		u64 avg;
+		u32 rem;
+
+		if (errexit)
+			break;
+		avg = div_u64_rem(result_avg[exp], 1000, &rem);
+		sprintf(buf1, "%d\t%llu.%03u\n", exp + 1, avg, rem);
+		strcat(buf, buf1);
+	}
+
+	if (!errexit)
+		SCALEOUT("%s", buf);
+
+	// This will shutdown everything including us.
+	if (shutdown) {
+		shutdown_start = 1;
+		wake_up(&shutdown_wq);
+	}
+
+	// Wait for torture to stop us
+	while (!torture_must_stop())
+		schedule_timeout_uninterruptible(1);
+
+end:
+	torture_kthread_stopping("main_func");
+	kfree(result_avg);
+	kfree(buf);
+	return 0;
+}
+
+static void
+ref_scale_print_module_parms(struct ref_scale_ops *cur_ops, const char *tag)
+{
+	pr_alert("%s" SCALE_FLAG
+		 "--- %s:  verbose=%d shutdown=%d holdoff=%d loops=%ld nreaders=%d nruns=%d readdelay=%d\n", scale_type, tag,
+		 verbose, shutdown, holdoff, loops, nreaders, nruns, readdelay);
+}
+
+static void
+ref_scale_cleanup(void)
+{
+	int i;
+
+	if (torture_cleanup_begin())
+		return;
+
+	if (!cur_ops) {
+		torture_cleanup_end();
+		return;
+	}
+
+	if (reader_tasks) {
+		for (i = 0; i < nreaders; i++)
+			torture_stop_kthread("ref_scale_reader",
+					     reader_tasks[i].task);
+	}
+	kfree(reader_tasks);
+
+	torture_stop_kthread("main_task", main_task);
+	kfree(main_task);
+
+	// Do scale-type-specific cleanup operations.
+	if (cur_ops->cleanup != NULL)
+		cur_ops->cleanup();
+
+	torture_cleanup_end();
+}
+
+// Shutdown kthread.  Just waits to be awakened, then shuts down system.
+static int
+ref_scale_shutdown(void *arg)
+{
+	wait_event(shutdown_wq, shutdown_start);
+
+	smp_mb(); // Wake before output.
+	ref_scale_cleanup();
+	kernel_power_off();
+
+	return -EINVAL;
+}
+
+static int __init
+ref_scale_init(void)
+{
+	long i;
+	int firsterr = 0;
+	static struct ref_scale_ops *scale_ops[] = {
+		&rcu_ops, &srcu_ops, &rcu_trace_ops, &rcu_tasks_ops,
+		&refcnt_ops, &rwlock_ops, &rwsem_ops,
+	};
+
+	if (!torture_init_begin(scale_type, verbose))
+		return -EBUSY;
+
+	for (i = 0; i < ARRAY_SIZE(scale_ops); i++) {
+		cur_ops = scale_ops[i];
+		if (strcmp(scale_type, cur_ops->name) == 0)
+			break;
+	}
+	if (i == ARRAY_SIZE(scale_ops)) {
+		pr_alert("rcu-scale: invalid scale type: \"%s\"\n", scale_type);
+		pr_alert("rcu-scale types:");
+		for (i = 0; i < ARRAY_SIZE(scale_ops); i++)
+			pr_cont(" %s", scale_ops[i]->name);
+		pr_cont("\n");
+		WARN_ON(!IS_MODULE(CONFIG_RCU_REF_SCALE_TEST));
+		firsterr = -EINVAL;
+		cur_ops = NULL;
+		goto unwind;
+	}
+	if (cur_ops->init)
+		cur_ops->init();
+
+	ref_scale_print_module_parms(cur_ops, "Start of test");
+
+	// Shutdown task
+	if (shutdown) {
+		init_waitqueue_head(&shutdown_wq);
+		firsterr = torture_create_kthread(ref_scale_shutdown, NULL,
+						  shutdown_task);
+		if (firsterr)
+			goto unwind;
+		schedule_timeout_uninterruptible(1);
+	}
+
+	// Reader tasks (default to ~75% of online CPUs).
+	if (nreaders < 0)
+		nreaders = (num_online_cpus() >> 1) + (num_online_cpus() >> 2);
+	reader_tasks = kcalloc(nreaders, sizeof(reader_tasks[0]),
+			       GFP_KERNEL);
+	if (!reader_tasks) {
+		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
+		firsterr = -ENOMEM;
+		goto unwind;
+	}
+
+	VERBOSE_SCALEOUT("Starting %d reader threads\n", nreaders);
+
+	for (i = 0; i < nreaders; i++) {
+		firsterr = torture_create_kthread(ref_scale_reader, (void *)i,
+						  reader_tasks[i].task);
+		if (firsterr)
+			goto unwind;
+
+		init_waitqueue_head(&(reader_tasks[i].wq));
+	}
+
+	// Main Task
+	init_waitqueue_head(&main_wq);
+	firsterr = torture_create_kthread(main_func, NULL, main_task);
+	if (firsterr)
+		goto unwind;
+
+	torture_init_end();
+	return 0;
+
+unwind:
+	torture_init_end();
+	ref_scale_cleanup();
+	return firsterr;
+}
+
+module_init(ref_scale_init);
+module_exit(ref_scale_cleanup);
diff --git a/tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh
index 489f05d..321e826 100644
--- a/tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh
+++ b/tools/testing/selftests/rcutorture/configs/refperf/ver_functions.sh
@@ -11,6 +11,6 @@
 #
 # Adds per-version torture-module parameters to kernels supporting them.
 per_version_boot_params () {
-	echo $1 refperf.shutdown=1 \
-		refperf.verbose=1
+	echo $1 refscale.shutdown=1 \
+		refscale.verbose=1
 }
