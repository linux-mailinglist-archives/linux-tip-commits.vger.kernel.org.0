Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243EA28827D
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731554AbgJIGha (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:37:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55510 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731925AbgJIGff (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:35 -0400
Date:   Fri, 09 Oct 2020 06:35:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tZggMC8TbeUnSSe3bBol7QqXsvdnuU3vc5YxqGMbB/s=;
        b=uS+2VI3YC0x9I+ud6Ip3gnLgu099i9z5XfQzD+Yiy2SjTFlx8PeV6/rHyOgDSiWqg783sC
        FicXxZozkJ+ks3r+A8bUkvSrCIBNcIKf2lAGFzTwXDgnEDeq9nYFnd5e4cA3YpM07UsM1J
        JXBx+EC9CpcZSb7Ssqnzgny/0a9l9bxYROur105Hg5f2WuPcSZHDFgReldaH+0w6yet3WY
        52Xx5MrxHSARU+O2x64xfXtNNqdbfuKFvEKBEWay2h5RkS645GOIlJeJW0SvqsIX8Janwq
        fqo2IZkBW31h2TPoqaDVTssMsVz9LS8gaWYV6uY2dPOxp5QSpiK1TD6M9jBC9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tZggMC8TbeUnSSe3bBol7QqXsvdnuU3vc5YxqGMbB/s=;
        b=Nsu1phaOJJ0DTKcbmhQ8pVpV/FkhSIt+bpzdESFfZPmZrcUQUcnnTTpdEyCkF4ySSKBbw9
        XuALfamejmTFkYCQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcuperf: Change rcuperf to rcuscale
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222532444.7002.15195298655851161428.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     4e88ec4a9eb17527e640b063f79e5b875733eb53
Gitweb:        https://git.kernel.org/tip/4e88ec4a9eb17527e640b063f79e5b875733eb53
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 11 Aug 2020 21:18:12 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:39:24 -07:00

rcuperf: Change rcuperf to rcuscale

This commit further avoids conflation of rcuperf with the kernel's perf
feature by renaming kernel/rcu/rcuperf.c to kernel/rcu/rcuscale.c, and
also by similarly renaming the functions and variables inside this file.
This has the side effect of changing the names of the kernel boot
parameters, so kernel-parameters.txt and ver_functions.sh are also
updated.  The rcutorture --torture type was also updated from rcuperf
to rcuscale.

[ paulmck: Fix bugs located by Stephen Rothwell. ]
Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt                       |  36 +--
 MAINTAINERS                                                           |   3 +-
 kernel/rcu/Kconfig.debug                                              |   2 +-
 kernel/rcu/Makefile                                                   |   2 +-
 kernel/rcu/rcuperf.c                                                  | 853 +----------------------------------------------------------------------
 kernel/rcu/rcuscale.c                                                 | 853 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf-ftrace.sh  | 109 +---------
 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf.sh         |  83 +-------
 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale-ftrace.sh | 109 +++++++++-
 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh        |  83 +++++++-
 tools/testing/selftests/rcutorture/bin/kvm.sh                         |   8 +-
 tools/testing/selftests/rcutorture/bin/parse-console.sh               |   4 +-
 tools/testing/selftests/rcutorture/configs/rcuperf/CFLIST             |   1 +-
 tools/testing/selftests/rcutorture/configs/rcuperf/CFcommon           |   2 +-
 tools/testing/selftests/rcutorture/configs/rcuperf/TINY               |  16 +-
 tools/testing/selftests/rcutorture/configs/rcuperf/TREE               |  19 +--
 tools/testing/selftests/rcutorture/configs/rcuperf/TREE54             |  22 +--
 tools/testing/selftests/rcutorture/configs/rcuperf/ver_functions.sh   |  16 +-
 tools/testing/selftests/rcutorture/configs/rcuscale/CFLIST            |   1 +-
 tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon          |   2 +-
 tools/testing/selftests/rcutorture/configs/rcuscale/TINY              |  16 +-
 tools/testing/selftests/rcutorture/configs/rcuscale/TREE              |  19 ++-
 tools/testing/selftests/rcutorture/configs/rcuscale/TREE54            |  22 ++-
 tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh  |  16 +-
 24 files changed, 1149 insertions(+), 1148 deletions(-)
 delete mode 100644 kernel/rcu/rcuperf.c
 create mode 100644 kernel/rcu/rcuscale.c
 delete mode 100755 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf-ftrace.sh
 delete mode 100755 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale-ftrace.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcuperf/CFLIST
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcuperf/CFcommon
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcuperf/TINY
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcuperf/TREE
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcuperf/TREE54
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcuperf/ver_functions.sh
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/CFLIST
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/TINY
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/TREE
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/TREE54
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 91a5638..c27bbe9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4157,41 +4157,41 @@
 			rcu_node tree with an eye towards determining
 			why a new grace period has not yet started.
 
-	rcuperf.gp_async= [KNL]
+	rcuscale.gp_async= [KNL]
 			Measure performance of asynchronous
 			grace-period primitives such as call_rcu().
 
-	rcuperf.gp_async_max= [KNL]
+	rcuscale.gp_async_max= [KNL]
 			Specify the maximum number of outstanding
 			callbacks per writer thread.  When a writer
 			thread exceeds this limit, it invokes the
 			corresponding flavor of rcu_barrier() to allow
 			previously posted callbacks to drain.
 
-	rcuperf.gp_exp= [KNL]
+	rcuscale.gp_exp= [KNL]
 			Measure performance of expedited synchronous
 			grace-period primitives.
 
-	rcuperf.holdoff= [KNL]
+	rcuscale.holdoff= [KNL]
 			Set test-start holdoff period.  The purpose of
 			this parameter is to delay the start of the
 			test until boot completes in order to avoid
 			interference.
 
-	rcuperf.kfree_rcu_test= [KNL]
+	rcuscale.kfree_rcu_test= [KNL]
 			Set to measure performance of kfree_rcu() flooding.
 
-	rcuperf.kfree_nthreads= [KNL]
+	rcuscale.kfree_nthreads= [KNL]
 			The number of threads running loops of kfree_rcu().
 
-	rcuperf.kfree_alloc_num= [KNL]
+	rcuscale.kfree_alloc_num= [KNL]
 			Number of allocations and frees done in an iteration.
 
-	rcuperf.kfree_loops= [KNL]
-			Number of loops doing rcuperf.kfree_alloc_num number
+	rcuscale.kfree_loops= [KNL]
+			Number of loops doing rcuscale.kfree_alloc_num number
 			of allocations and frees.
 
-	rcuperf.nreaders= [KNL]
+	rcuscale.nreaders= [KNL]
 			Set number of RCU readers.  The value -1 selects
 			N, where N is the number of CPUs.  A value
 			"n" less than -1 selects N-n+1, where N is again
@@ -4200,23 +4200,23 @@
 			A value of "n" less than or equal to -N selects
 			a single reader.
 
-	rcuperf.nwriters= [KNL]
+	rcuscale.nwriters= [KNL]
 			Set number of RCU writers.  The values operate
-			the same as for rcuperf.nreaders.
+			the same as for rcuscale.nreaders.
 			N, where N is the number of CPUs
 
-	rcuperf.perf_type= [KNL]
+	rcuscale.perf_type= [KNL]
 			Specify the RCU implementation to test.
 
-	rcuperf.shutdown= [KNL]
+	rcuscale.shutdown= [KNL]
 			Shut the system down after performance tests
 			complete.  This is useful for hands-off automated
 			testing.
 
-	rcuperf.verbose= [KNL]
+	rcuscale.verbose= [KNL]
 			Enable additional printk() statements.
 
-	rcuperf.writer_holdoff= [KNL]
+	rcuscale.writer_holdoff= [KNL]
 			Write-side holdoff between grace periods,
 			in microseconds.  The default of zero says
 			no holdoff.
@@ -4490,8 +4490,8 @@
 	refscale.shutdown= [KNL]
 			Shut down the system at the end of the performance
 			test.  This defaults to 1 (shut it down) when
-			rcuperf is built into the kernel and to 0 (leave
-			it running) when rcuperf is built as a module.
+			refscale is built into the kernel and to 0 (leave
+			it running) when refscale is built as a module.
 
 	refscale.verbose= [KNL]
 			Enable additional printk() statements.
diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb6..d299e3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17510,8 +17510,9 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
 F:	Documentation/RCU/torture.rst
 F:	kernel/locking/locktorture.c
-F:	kernel/rcu/rcuperf.c
+F:	kernel/rcu/rcuscale.c
 F:	kernel/rcu/rcutorture.c
+F:	kernel/rcu/refscale.c
 F:	kernel/torture.c
 
 TOSHIBA ACPI EXTRAS DRIVER
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 3cf6132..5cb175d 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -23,7 +23,7 @@ config TORTURE_TEST
 	tristate
 	default n
 
-config RCU_PERF_TEST
+config RCU_SCALE_TEST
 	tristate "performance tests for RCU"
 	depends on DEBUG_KERNEL
 	select TORTURE_TEST
diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
index 95f5117..0cfb009 100644
--- a/kernel/rcu/Makefile
+++ b/kernel/rcu/Makefile
@@ -11,7 +11,7 @@ obj-y += update.o sync.o
 obj-$(CONFIG_TREE_SRCU) += srcutree.o
 obj-$(CONFIG_TINY_SRCU) += srcutiny.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
-obj-$(CONFIG_RCU_PERF_TEST) += rcuperf.o
+obj-$(CONFIG_RCU_SCALE_TEST) += rcuscale.o
 obj-$(CONFIG_RCU_REF_SCALE_TEST) += refscale.o
 obj-$(CONFIG_TREE_RCU) += tree.o
 obj-$(CONFIG_TINY_RCU) += tiny.o
diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
deleted file mode 100644
index 21448d3..0000000
--- a/kernel/rcu/rcuperf.c
+++ /dev/null
@@ -1,853 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Read-Copy Update module-based performance-test facility
- *
- * Copyright (C) IBM Corporation, 2015
- *
- * Authors: Paul E. McKenney <paulmck@linux.ibm.com>
- */
-
-#define pr_fmt(fmt) fmt
-
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/kthread.h>
-#include <linux/err.h>
-#include <linux/spinlock.h>
-#include <linux/smp.h>
-#include <linux/rcupdate.h>
-#include <linux/interrupt.h>
-#include <linux/sched.h>
-#include <uapi/linux/sched/types.h>
-#include <linux/atomic.h>
-#include <linux/bitops.h>
-#include <linux/completion.h>
-#include <linux/moduleparam.h>
-#include <linux/percpu.h>
-#include <linux/notifier.h>
-#include <linux/reboot.h>
-#include <linux/freezer.h>
-#include <linux/cpu.h>
-#include <linux/delay.h>
-#include <linux/stat.h>
-#include <linux/srcu.h>
-#include <linux/slab.h>
-#include <asm/byteorder.h>
-#include <linux/torture.h>
-#include <linux/vmalloc.h>
-
-#include "rcu.h"
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
-
-#define PERF_FLAG "-perf:"
-#define PERFOUT_STRING(s) \
-	pr_alert("%s" PERF_FLAG " %s\n", perf_type, s)
-#define VERBOSE_PERFOUT_STRING(s) \
-	do { if (verbose) pr_alert("%s" PERF_FLAG " %s\n", perf_type, s); } while (0)
-#define VERBOSE_PERFOUT_ERRSTRING(s) \
-	do { if (verbose) pr_alert("%s" PERF_FLAG "!!! %s\n", perf_type, s); } while (0)
-
-/*
- * The intended use cases for the nreaders and nwriters module parameters
- * are as follows:
- *
- * 1.	Specify only the nr_cpus kernel boot parameter.  This will
- *	set both nreaders and nwriters to the value specified by
- *	nr_cpus for a mixed reader/writer test.
- *
- * 2.	Specify the nr_cpus kernel boot parameter, but set
- *	rcuperf.nreaders to zero.  This will set nwriters to the
- *	value specified by nr_cpus for an update-only test.
- *
- * 3.	Specify the nr_cpus kernel boot parameter, but set
- *	rcuperf.nwriters to zero.  This will set nreaders to the
- *	value specified by nr_cpus for a read-only test.
- *
- * Various other use cases may of course be specified.
- *
- * Note that this test's readers are intended only as a test load for
- * the writers.  The reader performance statistics will be overly
- * pessimistic due to the per-critical-section interrupt disabling,
- * test-end checks, and the pair of calls through pointers.
- */
-
-#ifdef MODULE
-# define RCUPERF_SHUTDOWN 0
-#else
-# define RCUPERF_SHUTDOWN 1
-#endif
-
-torture_param(bool, gp_async, false, "Use asynchronous GP wait primitives");
-torture_param(int, gp_async_max, 1000, "Max # outstanding waits per reader");
-torture_param(bool, gp_exp, false, "Use expedited GP wait primitives");
-torture_param(int, holdoff, 10, "Holdoff time before test start (s)");
-torture_param(int, nreaders, -1, "Number of RCU reader threads");
-torture_param(int, nwriters, -1, "Number of RCU updater threads");
-torture_param(bool, shutdown, RCUPERF_SHUTDOWN,
-	      "Shutdown at end of performance tests.");
-torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
-torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
-torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() perf test?");
-torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
-
-static char *perf_type = "rcu";
-module_param(perf_type, charp, 0444);
-MODULE_PARM_DESC(perf_type, "Type of RCU to performance-test (rcu, srcu, ...)");
-
-static int nrealreaders;
-static int nrealwriters;
-static struct task_struct **writer_tasks;
-static struct task_struct **reader_tasks;
-static struct task_struct *shutdown_task;
-
-static u64 **writer_durations;
-static int *writer_n_durations;
-static atomic_t n_rcu_perf_reader_started;
-static atomic_t n_rcu_perf_writer_started;
-static atomic_t n_rcu_perf_writer_finished;
-static wait_queue_head_t shutdown_wq;
-static u64 t_rcu_perf_writer_started;
-static u64 t_rcu_perf_writer_finished;
-static unsigned long b_rcu_gp_test_started;
-static unsigned long b_rcu_gp_test_finished;
-static DEFINE_PER_CPU(atomic_t, n_async_inflight);
-
-#define MAX_MEAS 10000
-#define MIN_MEAS 100
-
-/*
- * Operations vector for selecting different types of tests.
- */
-
-struct rcu_perf_ops {
-	int ptype;
-	void (*init)(void);
-	void (*cleanup)(void);
-	int (*readlock)(void);
-	void (*readunlock)(int idx);
-	unsigned long (*get_gp_seq)(void);
-	unsigned long (*gp_diff)(unsigned long new, unsigned long old);
-	unsigned long (*exp_completed)(void);
-	void (*async)(struct rcu_head *head, rcu_callback_t func);
-	void (*gp_barrier)(void);
-	void (*sync)(void);
-	void (*exp_sync)(void);
-	const char *name;
-};
-
-static struct rcu_perf_ops *cur_ops;
-
-/*
- * Definitions for rcu perf testing.
- */
-
-static int rcu_perf_read_lock(void) __acquires(RCU)
-{
-	rcu_read_lock();
-	return 0;
-}
-
-static void rcu_perf_read_unlock(int idx) __releases(RCU)
-{
-	rcu_read_unlock();
-}
-
-static unsigned long __maybe_unused rcu_no_completed(void)
-{
-	return 0;
-}
-
-static void rcu_sync_perf_init(void)
-{
-}
-
-static struct rcu_perf_ops rcu_ops = {
-	.ptype		= RCU_FLAVOR,
-	.init		= rcu_sync_perf_init,
-	.readlock	= rcu_perf_read_lock,
-	.readunlock	= rcu_perf_read_unlock,
-	.get_gp_seq	= rcu_get_gp_seq,
-	.gp_diff	= rcu_seq_diff,
-	.exp_completed	= rcu_exp_batches_completed,
-	.async		= call_rcu,
-	.gp_barrier	= rcu_barrier,
-	.sync		= synchronize_rcu,
-	.exp_sync	= synchronize_rcu_expedited,
-	.name		= "rcu"
-};
-
-/*
- * Definitions for srcu perf testing.
- */
-
-DEFINE_STATIC_SRCU(srcu_ctl_perf);
-static struct srcu_struct *srcu_ctlp = &srcu_ctl_perf;
-
-static int srcu_perf_read_lock(void) __acquires(srcu_ctlp)
-{
-	return srcu_read_lock(srcu_ctlp);
-}
-
-static void srcu_perf_read_unlock(int idx) __releases(srcu_ctlp)
-{
-	srcu_read_unlock(srcu_ctlp, idx);
-}
-
-static unsigned long srcu_perf_completed(void)
-{
-	return srcu_batches_completed(srcu_ctlp);
-}
-
-static void srcu_call_rcu(struct rcu_head *head, rcu_callback_t func)
-{
-	call_srcu(srcu_ctlp, head, func);
-}
-
-static void srcu_rcu_barrier(void)
-{
-	srcu_barrier(srcu_ctlp);
-}
-
-static void srcu_perf_synchronize(void)
-{
-	synchronize_srcu(srcu_ctlp);
-}
-
-static void srcu_perf_synchronize_expedited(void)
-{
-	synchronize_srcu_expedited(srcu_ctlp);
-}
-
-static struct rcu_perf_ops srcu_ops = {
-	.ptype		= SRCU_FLAVOR,
-	.init		= rcu_sync_perf_init,
-	.readlock	= srcu_perf_read_lock,
-	.readunlock	= srcu_perf_read_unlock,
-	.get_gp_seq	= srcu_perf_completed,
-	.gp_diff	= rcu_seq_diff,
-	.exp_completed	= srcu_perf_completed,
-	.async		= srcu_call_rcu,
-	.gp_barrier	= srcu_rcu_barrier,
-	.sync		= srcu_perf_synchronize,
-	.exp_sync	= srcu_perf_synchronize_expedited,
-	.name		= "srcu"
-};
-
-static struct srcu_struct srcud;
-
-static void srcu_sync_perf_init(void)
-{
-	srcu_ctlp = &srcud;
-	init_srcu_struct(srcu_ctlp);
-}
-
-static void srcu_sync_perf_cleanup(void)
-{
-	cleanup_srcu_struct(srcu_ctlp);
-}
-
-static struct rcu_perf_ops srcud_ops = {
-	.ptype		= SRCU_FLAVOR,
-	.init		= srcu_sync_perf_init,
-	.cleanup	= srcu_sync_perf_cleanup,
-	.readlock	= srcu_perf_read_lock,
-	.readunlock	= srcu_perf_read_unlock,
-	.get_gp_seq	= srcu_perf_completed,
-	.gp_diff	= rcu_seq_diff,
-	.exp_completed	= srcu_perf_completed,
-	.async		= srcu_call_rcu,
-	.gp_barrier	= srcu_rcu_barrier,
-	.sync		= srcu_perf_synchronize,
-	.exp_sync	= srcu_perf_synchronize_expedited,
-	.name		= "srcud"
-};
-
-/*
- * Definitions for RCU-tasks perf testing.
- */
-
-static int tasks_perf_read_lock(void)
-{
-	return 0;
-}
-
-static void tasks_perf_read_unlock(int idx)
-{
-}
-
-static struct rcu_perf_ops tasks_ops = {
-	.ptype		= RCU_TASKS_FLAVOR,
-	.init		= rcu_sync_perf_init,
-	.readlock	= tasks_perf_read_lock,
-	.readunlock	= tasks_perf_read_unlock,
-	.get_gp_seq	= rcu_no_completed,
-	.gp_diff	= rcu_seq_diff,
-	.async		= call_rcu_tasks,
-	.gp_barrier	= rcu_barrier_tasks,
-	.sync		= synchronize_rcu_tasks,
-	.exp_sync	= synchronize_rcu_tasks,
-	.name		= "tasks"
-};
-
-static unsigned long rcuperf_seq_diff(unsigned long new, unsigned long old)
-{
-	if (!cur_ops->gp_diff)
-		return new - old;
-	return cur_ops->gp_diff(new, old);
-}
-
-/*
- * If performance tests complete, wait for shutdown to commence.
- */
-static void rcu_perf_wait_shutdown(void)
-{
-	cond_resched_tasks_rcu_qs();
-	if (atomic_read(&n_rcu_perf_writer_finished) < nrealwriters)
-		return;
-	while (!torture_must_stop())
-		schedule_timeout_uninterruptible(1);
-}
-
-/*
- * RCU perf reader kthread.  Repeatedly does empty RCU read-side critical
- * section, minimizing update-side interference.  However, the point of
- * this test is not to evaluate reader performance, but instead to serve
- * as a test load for update-side performance testing.
- */
-static int
-rcu_perf_reader(void *arg)
-{
-	unsigned long flags;
-	int idx;
-	long me = (long)arg;
-
-	VERBOSE_PERFOUT_STRING("rcu_perf_reader task started");
-	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
-	set_user_nice(current, MAX_NICE);
-	atomic_inc(&n_rcu_perf_reader_started);
-
-	do {
-		local_irq_save(flags);
-		idx = cur_ops->readlock();
-		cur_ops->readunlock(idx);
-		local_irq_restore(flags);
-		rcu_perf_wait_shutdown();
-	} while (!torture_must_stop());
-	torture_kthread_stopping("rcu_perf_reader");
-	return 0;
-}
-
-/*
- * Callback function for asynchronous grace periods from rcu_perf_writer().
- */
-static void rcu_perf_async_cb(struct rcu_head *rhp)
-{
-	atomic_dec(this_cpu_ptr(&n_async_inflight));
-	kfree(rhp);
-}
-
-/*
- * RCU perf writer kthread.  Repeatedly does a grace period.
- */
-static int
-rcu_perf_writer(void *arg)
-{
-	int i = 0;
-	int i_max;
-	long me = (long)arg;
-	struct rcu_head *rhp = NULL;
-	bool started = false, done = false, alldone = false;
-	u64 t;
-	u64 *wdp;
-	u64 *wdpp = writer_durations[me];
-
-	VERBOSE_PERFOUT_STRING("rcu_perf_writer task started");
-	WARN_ON(!wdpp);
-	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
-	sched_set_fifo_low(current);
-
-	if (holdoff)
-		schedule_timeout_uninterruptible(holdoff * HZ);
-
-	/*
-	 * Wait until rcu_end_inkernel_boot() is called for normal GP tests
-	 * so that RCU is not always expedited for normal GP tests.
-	 * The system_state test is approximate, but works well in practice.
-	 */
-	while (!gp_exp && system_state != SYSTEM_RUNNING)
-		schedule_timeout_uninterruptible(1);
-
-	t = ktime_get_mono_fast_ns();
-	if (atomic_inc_return(&n_rcu_perf_writer_started) >= nrealwriters) {
-		t_rcu_perf_writer_started = t;
-		if (gp_exp) {
-			b_rcu_gp_test_started =
-				cur_ops->exp_completed() / 2;
-		} else {
-			b_rcu_gp_test_started = cur_ops->get_gp_seq();
-		}
-	}
-
-	do {
-		if (writer_holdoff)
-			udelay(writer_holdoff);
-		wdp = &wdpp[i];
-		*wdp = ktime_get_mono_fast_ns();
-		if (gp_async) {
-retry:
-			if (!rhp)
-				rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
-			if (rhp && atomic_read(this_cpu_ptr(&n_async_inflight)) < gp_async_max) {
-				atomic_inc(this_cpu_ptr(&n_async_inflight));
-				cur_ops->async(rhp, rcu_perf_async_cb);
-				rhp = NULL;
-			} else if (!kthread_should_stop()) {
-				cur_ops->gp_barrier();
-				goto retry;
-			} else {
-				kfree(rhp); /* Because we are stopping. */
-			}
-		} else if (gp_exp) {
-			cur_ops->exp_sync();
-		} else {
-			cur_ops->sync();
-		}
-		t = ktime_get_mono_fast_ns();
-		*wdp = t - *wdp;
-		i_max = i;
-		if (!started &&
-		    atomic_read(&n_rcu_perf_writer_started) >= nrealwriters)
-			started = true;
-		if (!done && i >= MIN_MEAS) {
-			done = true;
-			sched_set_normal(current, 0);
-			pr_alert("%s%s rcu_perf_writer %ld has %d measurements\n",
-				 perf_type, PERF_FLAG, me, MIN_MEAS);
-			if (atomic_inc_return(&n_rcu_perf_writer_finished) >=
-			    nrealwriters) {
-				schedule_timeout_interruptible(10);
-				rcu_ftrace_dump(DUMP_ALL);
-				PERFOUT_STRING("Test complete");
-				t_rcu_perf_writer_finished = t;
-				if (gp_exp) {
-					b_rcu_gp_test_finished =
-						cur_ops->exp_completed() / 2;
-				} else {
-					b_rcu_gp_test_finished =
-						cur_ops->get_gp_seq();
-				}
-				if (shutdown) {
-					smp_mb(); /* Assign before wake. */
-					wake_up(&shutdown_wq);
-				}
-			}
-		}
-		if (done && !alldone &&
-		    atomic_read(&n_rcu_perf_writer_finished) >= nrealwriters)
-			alldone = true;
-		if (started && !alldone && i < MAX_MEAS - 1)
-			i++;
-		rcu_perf_wait_shutdown();
-	} while (!torture_must_stop());
-	if (gp_async) {
-		cur_ops->gp_barrier();
-	}
-	writer_n_durations[me] = i_max;
-	torture_kthread_stopping("rcu_perf_writer");
-	return 0;
-}
-
-static void
-rcu_perf_print_module_parms(struct rcu_perf_ops *cur_ops, const char *tag)
-{
-	pr_alert("%s" PERF_FLAG
-		 "--- %s: nreaders=%d nwriters=%d verbose=%d shutdown=%d\n",
-		 perf_type, tag, nrealreaders, nrealwriters, verbose, shutdown);
-}
-
-static void
-rcu_perf_cleanup(void)
-{
-	int i;
-	int j;
-	int ngps = 0;
-	u64 *wdp;
-	u64 *wdpp;
-
-	/*
-	 * Would like warning at start, but everything is expedited
-	 * during the mid-boot phase, so have to wait till the end.
-	 */
-	if (rcu_gp_is_expedited() && !rcu_gp_is_normal() && !gp_exp)
-		VERBOSE_PERFOUT_ERRSTRING("All grace periods expedited, no normal ones to measure!");
-	if (rcu_gp_is_normal() && gp_exp)
-		VERBOSE_PERFOUT_ERRSTRING("All grace periods normal, no expedited ones to measure!");
-	if (gp_exp && gp_async)
-		VERBOSE_PERFOUT_ERRSTRING("No expedited async GPs, so went with async!");
-
-	if (torture_cleanup_begin())
-		return;
-	if (!cur_ops) {
-		torture_cleanup_end();
-		return;
-	}
-
-	if (reader_tasks) {
-		for (i = 0; i < nrealreaders; i++)
-			torture_stop_kthread(rcu_perf_reader,
-					     reader_tasks[i]);
-		kfree(reader_tasks);
-	}
-
-	if (writer_tasks) {
-		for (i = 0; i < nrealwriters; i++) {
-			torture_stop_kthread(rcu_perf_writer,
-					     writer_tasks[i]);
-			if (!writer_n_durations)
-				continue;
-			j = writer_n_durations[i];
-			pr_alert("%s%s writer %d gps: %d\n",
-				 perf_type, PERF_FLAG, i, j);
-			ngps += j;
-		}
-		pr_alert("%s%s start: %llu end: %llu duration: %llu gps: %d batches: %ld\n",
-			 perf_type, PERF_FLAG,
-			 t_rcu_perf_writer_started, t_rcu_perf_writer_finished,
-			 t_rcu_perf_writer_finished -
-			 t_rcu_perf_writer_started,
-			 ngps,
-			 rcuperf_seq_diff(b_rcu_gp_test_finished,
-					  b_rcu_gp_test_started));
-		for (i = 0; i < nrealwriters; i++) {
-			if (!writer_durations)
-				break;
-			if (!writer_n_durations)
-				continue;
-			wdpp = writer_durations[i];
-			if (!wdpp)
-				continue;
-			for (j = 0; j <= writer_n_durations[i]; j++) {
-				wdp = &wdpp[j];
-				pr_alert("%s%s %4d writer-duration: %5d %llu\n",
-					perf_type, PERF_FLAG,
-					i, j, *wdp);
-				if (j % 100 == 0)
-					schedule_timeout_uninterruptible(1);
-			}
-			kfree(writer_durations[i]);
-		}
-		kfree(writer_tasks);
-		kfree(writer_durations);
-		kfree(writer_n_durations);
-	}
-
-	/* Do torture-type-specific cleanup operations.  */
-	if (cur_ops->cleanup != NULL)
-		cur_ops->cleanup();
-
-	torture_cleanup_end();
-}
-
-/*
- * Return the number if non-negative.  If -1, the number of CPUs.
- * If less than -1, that much less than the number of CPUs, but
- * at least one.
- */
-static int compute_real(int n)
-{
-	int nr;
-
-	if (n >= 0) {
-		nr = n;
-	} else {
-		nr = num_online_cpus() + 1 + n;
-		if (nr <= 0)
-			nr = 1;
-	}
-	return nr;
-}
-
-/*
- * RCU perf shutdown kthread.  Just waits to be awakened, then shuts
- * down system.
- */
-static int
-rcu_perf_shutdown(void *arg)
-{
-	wait_event(shutdown_wq,
-		   atomic_read(&n_rcu_perf_writer_finished) >= nrealwriters);
-	smp_mb(); /* Wake before output. */
-	rcu_perf_cleanup();
-	kernel_power_off();
-	return -EINVAL;
-}
-
-/*
- * kfree_rcu() performance tests: Start a kfree_rcu() loop on all CPUs for number
- * of iterations and measure total time and number of GP for all iterations to complete.
- */
-
-torture_param(int, kfree_nthreads, -1, "Number of threads running loops of kfree_rcu().");
-torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done in an iteration.");
-torture_param(int, kfree_loops, 10, "Number of loops doing kfree_alloc_num allocations and frees.");
-
-static struct task_struct **kfree_reader_tasks;
-static int kfree_nrealthreads;
-static atomic_t n_kfree_perf_thread_started;
-static atomic_t n_kfree_perf_thread_ended;
-
-struct kfree_obj {
-	char kfree_obj[8];
-	struct rcu_head rh;
-};
-
-static int
-kfree_perf_thread(void *arg)
-{
-	int i, loop = 0;
-	long me = (long)arg;
-	struct kfree_obj *alloc_ptr;
-	u64 start_time, end_time;
-	long long mem_begin, mem_during = 0;
-
-	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
-	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
-	set_user_nice(current, MAX_NICE);
-
-	start_time = ktime_get_mono_fast_ns();
-
-	if (atomic_inc_return(&n_kfree_perf_thread_started) >= kfree_nrealthreads) {
-		if (gp_exp)
-			b_rcu_gp_test_started = cur_ops->exp_completed() / 2;
-		else
-			b_rcu_gp_test_started = cur_ops->get_gp_seq();
-	}
-
-	do {
-		if (!mem_during) {
-			mem_during = mem_begin = si_mem_available();
-		} else if (loop % (kfree_loops / 4) == 0) {
-			mem_during = (mem_during + si_mem_available()) / 2;
-		}
-
-		for (i = 0; i < kfree_alloc_num; i++) {
-			alloc_ptr = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
-			if (!alloc_ptr)
-				return -ENOMEM;
-
-			kfree_rcu(alloc_ptr, rh);
-		}
-
-		cond_resched();
-	} while (!torture_must_stop() && ++loop < kfree_loops);
-
-	if (atomic_inc_return(&n_kfree_perf_thread_ended) >= kfree_nrealthreads) {
-		end_time = ktime_get_mono_fast_ns();
-
-		if (gp_exp)
-			b_rcu_gp_test_finished = cur_ops->exp_completed() / 2;
-		else
-			b_rcu_gp_test_finished = cur_ops->get_gp_seq();
-
-		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld, memory footprint: %lldMB\n",
-		       (unsigned long long)(end_time - start_time), kfree_loops,
-		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started),
-		       (mem_begin - mem_during) >> (20 - PAGE_SHIFT));
-
-		if (shutdown) {
-			smp_mb(); /* Assign before wake. */
-			wake_up(&shutdown_wq);
-		}
-	}
-
-	torture_kthread_stopping("kfree_perf_thread");
-	return 0;
-}
-
-static void
-kfree_perf_cleanup(void)
-{
-	int i;
-
-	if (torture_cleanup_begin())
-		return;
-
-	if (kfree_reader_tasks) {
-		for (i = 0; i < kfree_nrealthreads; i++)
-			torture_stop_kthread(kfree_perf_thread,
-					     kfree_reader_tasks[i]);
-		kfree(kfree_reader_tasks);
-	}
-
-	torture_cleanup_end();
-}
-
-/*
- * shutdown kthread.  Just waits to be awakened, then shuts down system.
- */
-static int
-kfree_perf_shutdown(void *arg)
-{
-	wait_event(shutdown_wq,
-		   atomic_read(&n_kfree_perf_thread_ended) >= kfree_nrealthreads);
-
-	smp_mb(); /* Wake before output. */
-
-	kfree_perf_cleanup();
-	kernel_power_off();
-	return -EINVAL;
-}
-
-static int __init
-kfree_perf_init(void)
-{
-	long i;
-	int firsterr = 0;
-
-	kfree_nrealthreads = compute_real(kfree_nthreads);
-	/* Start up the kthreads. */
-	if (shutdown) {
-		init_waitqueue_head(&shutdown_wq);
-		firsterr = torture_create_kthread(kfree_perf_shutdown, NULL,
-						  shutdown_task);
-		if (firsterr)
-			goto unwind;
-		schedule_timeout_uninterruptible(1);
-	}
-
-	pr_alert("kfree object size=%zu\n", kfree_mult * sizeof(struct kfree_obj));
-
-	kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
-			       GFP_KERNEL);
-	if (kfree_reader_tasks == NULL) {
-		firsterr = -ENOMEM;
-		goto unwind;
-	}
-
-	for (i = 0; i < kfree_nrealthreads; i++) {
-		firsterr = torture_create_kthread(kfree_perf_thread, (void *)i,
-						  kfree_reader_tasks[i]);
-		if (firsterr)
-			goto unwind;
-	}
-
-	while (atomic_read(&n_kfree_perf_thread_started) < kfree_nrealthreads)
-		schedule_timeout_uninterruptible(1);
-
-	torture_init_end();
-	return 0;
-
-unwind:
-	torture_init_end();
-	kfree_perf_cleanup();
-	return firsterr;
-}
-
-static int __init
-rcu_perf_init(void)
-{
-	long i;
-	int firsterr = 0;
-	static struct rcu_perf_ops *perf_ops[] = {
-		&rcu_ops, &srcu_ops, &srcud_ops, &tasks_ops,
-	};
-
-	if (!torture_init_begin(perf_type, verbose))
-		return -EBUSY;
-
-	/* Process args and tell the world that the perf'er is on the job. */
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
-		WARN_ON(!IS_MODULE(CONFIG_RCU_PERF_TEST));
-		firsterr = -EINVAL;
-		cur_ops = NULL;
-		goto unwind;
-	}
-	if (cur_ops->init)
-		cur_ops->init();
-
-	if (kfree_rcu_test)
-		return kfree_perf_init();
-
-	nrealwriters = compute_real(nwriters);
-	nrealreaders = compute_real(nreaders);
-	atomic_set(&n_rcu_perf_reader_started, 0);
-	atomic_set(&n_rcu_perf_writer_started, 0);
-	atomic_set(&n_rcu_perf_writer_finished, 0);
-	rcu_perf_print_module_parms(cur_ops, "Start of test");
-
-	/* Start up the kthreads. */
-
-	if (shutdown) {
-		init_waitqueue_head(&shutdown_wq);
-		firsterr = torture_create_kthread(rcu_perf_shutdown, NULL,
-						  shutdown_task);
-		if (firsterr)
-			goto unwind;
-		schedule_timeout_uninterruptible(1);
-	}
-	reader_tasks = kcalloc(nrealreaders, sizeof(reader_tasks[0]),
-			       GFP_KERNEL);
-	if (reader_tasks == NULL) {
-		VERBOSE_PERFOUT_ERRSTRING("out of memory");
-		firsterr = -ENOMEM;
-		goto unwind;
-	}
-	for (i = 0; i < nrealreaders; i++) {
-		firsterr = torture_create_kthread(rcu_perf_reader, (void *)i,
-						  reader_tasks[i]);
-		if (firsterr)
-			goto unwind;
-	}
-	while (atomic_read(&n_rcu_perf_reader_started) < nrealreaders)
-		schedule_timeout_uninterruptible(1);
-	writer_tasks = kcalloc(nrealwriters, sizeof(reader_tasks[0]),
-			       GFP_KERNEL);
-	writer_durations = kcalloc(nrealwriters, sizeof(*writer_durations),
-				   GFP_KERNEL);
-	writer_n_durations =
-		kcalloc(nrealwriters, sizeof(*writer_n_durations),
-			GFP_KERNEL);
-	if (!writer_tasks || !writer_durations || !writer_n_durations) {
-		VERBOSE_PERFOUT_ERRSTRING("out of memory");
-		firsterr = -ENOMEM;
-		goto unwind;
-	}
-	for (i = 0; i < nrealwriters; i++) {
-		writer_durations[i] =
-			kcalloc(MAX_MEAS, sizeof(*writer_durations[i]),
-				GFP_KERNEL);
-		if (!writer_durations[i]) {
-			firsterr = -ENOMEM;
-			goto unwind;
-		}
-		firsterr = torture_create_kthread(rcu_perf_writer, (void *)i,
-						  writer_tasks[i]);
-		if (firsterr)
-			goto unwind;
-	}
-	torture_init_end();
-	return 0;
-
-unwind:
-	torture_init_end();
-	rcu_perf_cleanup();
-	return firsterr;
-}
-
-module_init(rcu_perf_init);
-module_exit(rcu_perf_cleanup);
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
new file mode 100644
index 0000000..2819b95
--- /dev/null
+++ b/kernel/rcu/rcuscale.c
@@ -0,0 +1,853 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Read-Copy Update module-based scalability-test facility
+ *
+ * Copyright (C) IBM Corporation, 2015
+ *
+ * Authors: Paul E. McKenney <paulmck@linux.ibm.com>
+ */
+
+#define pr_fmt(fmt) fmt
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/kthread.h>
+#include <linux/err.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <linux/rcupdate.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include <uapi/linux/sched/types.h>
+#include <linux/atomic.h>
+#include <linux/bitops.h>
+#include <linux/completion.h>
+#include <linux/moduleparam.h>
+#include <linux/percpu.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/freezer.h>
+#include <linux/cpu.h>
+#include <linux/delay.h>
+#include <linux/stat.h>
+#include <linux/srcu.h>
+#include <linux/slab.h>
+#include <asm/byteorder.h>
+#include <linux/torture.h>
+#include <linux/vmalloc.h>
+
+#include "rcu.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
+
+#define SCALE_FLAG "-scale:"
+#define SCALEOUT_STRING(s) \
+	pr_alert("%s" SCALE_FLAG " %s\n", scale_type, s)
+#define VERBOSE_SCALEOUT_STRING(s) \
+	do { if (verbose) pr_alert("%s" SCALE_FLAG " %s\n", scale_type, s); } while (0)
+#define VERBOSE_SCALEOUT_ERRSTRING(s) \
+	do { if (verbose) pr_alert("%s" SCALE_FLAG "!!! %s\n", scale_type, s); } while (0)
+
+/*
+ * The intended use cases for the nreaders and nwriters module parameters
+ * are as follows:
+ *
+ * 1.	Specify only the nr_cpus kernel boot parameter.  This will
+ *	set both nreaders and nwriters to the value specified by
+ *	nr_cpus for a mixed reader/writer test.
+ *
+ * 2.	Specify the nr_cpus kernel boot parameter, but set
+ *	rcuscale.nreaders to zero.  This will set nwriters to the
+ *	value specified by nr_cpus for an update-only test.
+ *
+ * 3.	Specify the nr_cpus kernel boot parameter, but set
+ *	rcuscale.nwriters to zero.  This will set nreaders to the
+ *	value specified by nr_cpus for a read-only test.
+ *
+ * Various other use cases may of course be specified.
+ *
+ * Note that this test's readers are intended only as a test load for
+ * the writers.  The reader scalability statistics will be overly
+ * pessimistic due to the per-critical-section interrupt disabling,
+ * test-end checks, and the pair of calls through pointers.
+ */
+
+#ifdef MODULE
+# define RCUSCALE_SHUTDOWN 0
+#else
+# define RCUSCALE_SHUTDOWN 1
+#endif
+
+torture_param(bool, gp_async, false, "Use asynchronous GP wait primitives");
+torture_param(int, gp_async_max, 1000, "Max # outstanding waits per reader");
+torture_param(bool, gp_exp, false, "Use expedited GP wait primitives");
+torture_param(int, holdoff, 10, "Holdoff time before test start (s)");
+torture_param(int, nreaders, -1, "Number of RCU reader threads");
+torture_param(int, nwriters, -1, "Number of RCU updater threads");
+torture_param(bool, shutdown, RCUSCALE_SHUTDOWN,
+	      "Shutdown at end of scalability tests.");
+torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
+torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
+torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() scale test?");
+torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
+
+static char *scale_type = "rcu";
+module_param(scale_type, charp, 0444);
+MODULE_PARM_DESC(scale_type, "Type of RCU to scalability-test (rcu, srcu, ...)");
+
+static int nrealreaders;
+static int nrealwriters;
+static struct task_struct **writer_tasks;
+static struct task_struct **reader_tasks;
+static struct task_struct *shutdown_task;
+
+static u64 **writer_durations;
+static int *writer_n_durations;
+static atomic_t n_rcu_scale_reader_started;
+static atomic_t n_rcu_scale_writer_started;
+static atomic_t n_rcu_scale_writer_finished;
+static wait_queue_head_t shutdown_wq;
+static u64 t_rcu_scale_writer_started;
+static u64 t_rcu_scale_writer_finished;
+static unsigned long b_rcu_gp_test_started;
+static unsigned long b_rcu_gp_test_finished;
+static DEFINE_PER_CPU(atomic_t, n_async_inflight);
+
+#define MAX_MEAS 10000
+#define MIN_MEAS 100
+
+/*
+ * Operations vector for selecting different types of tests.
+ */
+
+struct rcu_scale_ops {
+	int ptype;
+	void (*init)(void);
+	void (*cleanup)(void);
+	int (*readlock)(void);
+	void (*readunlock)(int idx);
+	unsigned long (*get_gp_seq)(void);
+	unsigned long (*gp_diff)(unsigned long new, unsigned long old);
+	unsigned long (*exp_completed)(void);
+	void (*async)(struct rcu_head *head, rcu_callback_t func);
+	void (*gp_barrier)(void);
+	void (*sync)(void);
+	void (*exp_sync)(void);
+	const char *name;
+};
+
+static struct rcu_scale_ops *cur_ops;
+
+/*
+ * Definitions for rcu scalability testing.
+ */
+
+static int rcu_scale_read_lock(void) __acquires(RCU)
+{
+	rcu_read_lock();
+	return 0;
+}
+
+static void rcu_scale_read_unlock(int idx) __releases(RCU)
+{
+	rcu_read_unlock();
+}
+
+static unsigned long __maybe_unused rcu_no_completed(void)
+{
+	return 0;
+}
+
+static void rcu_sync_scale_init(void)
+{
+}
+
+static struct rcu_scale_ops rcu_ops = {
+	.ptype		= RCU_FLAVOR,
+	.init		= rcu_sync_scale_init,
+	.readlock	= rcu_scale_read_lock,
+	.readunlock	= rcu_scale_read_unlock,
+	.get_gp_seq	= rcu_get_gp_seq,
+	.gp_diff	= rcu_seq_diff,
+	.exp_completed	= rcu_exp_batches_completed,
+	.async		= call_rcu,
+	.gp_barrier	= rcu_barrier,
+	.sync		= synchronize_rcu,
+	.exp_sync	= synchronize_rcu_expedited,
+	.name		= "rcu"
+};
+
+/*
+ * Definitions for srcu scalability testing.
+ */
+
+DEFINE_STATIC_SRCU(srcu_ctl_scale);
+static struct srcu_struct *srcu_ctlp = &srcu_ctl_scale;
+
+static int srcu_scale_read_lock(void) __acquires(srcu_ctlp)
+{
+	return srcu_read_lock(srcu_ctlp);
+}
+
+static void srcu_scale_read_unlock(int idx) __releases(srcu_ctlp)
+{
+	srcu_read_unlock(srcu_ctlp, idx);
+}
+
+static unsigned long srcu_scale_completed(void)
+{
+	return srcu_batches_completed(srcu_ctlp);
+}
+
+static void srcu_call_rcu(struct rcu_head *head, rcu_callback_t func)
+{
+	call_srcu(srcu_ctlp, head, func);
+}
+
+static void srcu_rcu_barrier(void)
+{
+	srcu_barrier(srcu_ctlp);
+}
+
+static void srcu_scale_synchronize(void)
+{
+	synchronize_srcu(srcu_ctlp);
+}
+
+static void srcu_scale_synchronize_expedited(void)
+{
+	synchronize_srcu_expedited(srcu_ctlp);
+}
+
+static struct rcu_scale_ops srcu_ops = {
+	.ptype		= SRCU_FLAVOR,
+	.init		= rcu_sync_scale_init,
+	.readlock	= srcu_scale_read_lock,
+	.readunlock	= srcu_scale_read_unlock,
+	.get_gp_seq	= srcu_scale_completed,
+	.gp_diff	= rcu_seq_diff,
+	.exp_completed	= srcu_scale_completed,
+	.async		= srcu_call_rcu,
+	.gp_barrier	= srcu_rcu_barrier,
+	.sync		= srcu_scale_synchronize,
+	.exp_sync	= srcu_scale_synchronize_expedited,
+	.name		= "srcu"
+};
+
+static struct srcu_struct srcud;
+
+static void srcu_sync_scale_init(void)
+{
+	srcu_ctlp = &srcud;
+	init_srcu_struct(srcu_ctlp);
+}
+
+static void srcu_sync_scale_cleanup(void)
+{
+	cleanup_srcu_struct(srcu_ctlp);
+}
+
+static struct rcu_scale_ops srcud_ops = {
+	.ptype		= SRCU_FLAVOR,
+	.init		= srcu_sync_scale_init,
+	.cleanup	= srcu_sync_scale_cleanup,
+	.readlock	= srcu_scale_read_lock,
+	.readunlock	= srcu_scale_read_unlock,
+	.get_gp_seq	= srcu_scale_completed,
+	.gp_diff	= rcu_seq_diff,
+	.exp_completed	= srcu_scale_completed,
+	.async		= srcu_call_rcu,
+	.gp_barrier	= srcu_rcu_barrier,
+	.sync		= srcu_scale_synchronize,
+	.exp_sync	= srcu_scale_synchronize_expedited,
+	.name		= "srcud"
+};
+
+/*
+ * Definitions for RCU-tasks scalability testing.
+ */
+
+static int tasks_scale_read_lock(void)
+{
+	return 0;
+}
+
+static void tasks_scale_read_unlock(int idx)
+{
+}
+
+static struct rcu_scale_ops tasks_ops = {
+	.ptype		= RCU_TASKS_FLAVOR,
+	.init		= rcu_sync_scale_init,
+	.readlock	= tasks_scale_read_lock,
+	.readunlock	= tasks_scale_read_unlock,
+	.get_gp_seq	= rcu_no_completed,
+	.gp_diff	= rcu_seq_diff,
+	.async		= call_rcu_tasks,
+	.gp_barrier	= rcu_barrier_tasks,
+	.sync		= synchronize_rcu_tasks,
+	.exp_sync	= synchronize_rcu_tasks,
+	.name		= "tasks"
+};
+
+static unsigned long rcuscale_seq_diff(unsigned long new, unsigned long old)
+{
+	if (!cur_ops->gp_diff)
+		return new - old;
+	return cur_ops->gp_diff(new, old);
+}
+
+/*
+ * If scalability tests complete, wait for shutdown to commence.
+ */
+static void rcu_scale_wait_shutdown(void)
+{
+	cond_resched_tasks_rcu_qs();
+	if (atomic_read(&n_rcu_scale_writer_finished) < nrealwriters)
+		return;
+	while (!torture_must_stop())
+		schedule_timeout_uninterruptible(1);
+}
+
+/*
+ * RCU scalability reader kthread.  Repeatedly does empty RCU read-side
+ * critical section, minimizing update-side interference.  However, the
+ * point of this test is not to evaluate reader scalability, but instead
+ * to serve as a test load for update-side scalability testing.
+ */
+static int
+rcu_scale_reader(void *arg)
+{
+	unsigned long flags;
+	int idx;
+	long me = (long)arg;
+
+	VERBOSE_SCALEOUT_STRING("rcu_scale_reader task started");
+	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
+	set_user_nice(current, MAX_NICE);
+	atomic_inc(&n_rcu_scale_reader_started);
+
+	do {
+		local_irq_save(flags);
+		idx = cur_ops->readlock();
+		cur_ops->readunlock(idx);
+		local_irq_restore(flags);
+		rcu_scale_wait_shutdown();
+	} while (!torture_must_stop());
+	torture_kthread_stopping("rcu_scale_reader");
+	return 0;
+}
+
+/*
+ * Callback function for asynchronous grace periods from rcu_scale_writer().
+ */
+static void rcu_scale_async_cb(struct rcu_head *rhp)
+{
+	atomic_dec(this_cpu_ptr(&n_async_inflight));
+	kfree(rhp);
+}
+
+/*
+ * RCU scale writer kthread.  Repeatedly does a grace period.
+ */
+static int
+rcu_scale_writer(void *arg)
+{
+	int i = 0;
+	int i_max;
+	long me = (long)arg;
+	struct rcu_head *rhp = NULL;
+	bool started = false, done = false, alldone = false;
+	u64 t;
+	u64 *wdp;
+	u64 *wdpp = writer_durations[me];
+
+	VERBOSE_SCALEOUT_STRING("rcu_scale_writer task started");
+	WARN_ON(!wdpp);
+	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
+	sched_set_fifo_low(current);
+
+	if (holdoff)
+		schedule_timeout_uninterruptible(holdoff * HZ);
+
+	/*
+	 * Wait until rcu_end_inkernel_boot() is called for normal GP tests
+	 * so that RCU is not always expedited for normal GP tests.
+	 * The system_state test is approximate, but works well in practice.
+	 */
+	while (!gp_exp && system_state != SYSTEM_RUNNING)
+		schedule_timeout_uninterruptible(1);
+
+	t = ktime_get_mono_fast_ns();
+	if (atomic_inc_return(&n_rcu_scale_writer_started) >= nrealwriters) {
+		t_rcu_scale_writer_started = t;
+		if (gp_exp) {
+			b_rcu_gp_test_started =
+				cur_ops->exp_completed() / 2;
+		} else {
+			b_rcu_gp_test_started = cur_ops->get_gp_seq();
+		}
+	}
+
+	do {
+		if (writer_holdoff)
+			udelay(writer_holdoff);
+		wdp = &wdpp[i];
+		*wdp = ktime_get_mono_fast_ns();
+		if (gp_async) {
+retry:
+			if (!rhp)
+				rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
+			if (rhp && atomic_read(this_cpu_ptr(&n_async_inflight)) < gp_async_max) {
+				atomic_inc(this_cpu_ptr(&n_async_inflight));
+				cur_ops->async(rhp, rcu_scale_async_cb);
+				rhp = NULL;
+			} else if (!kthread_should_stop()) {
+				cur_ops->gp_barrier();
+				goto retry;
+			} else {
+				kfree(rhp); /* Because we are stopping. */
+			}
+		} else if (gp_exp) {
+			cur_ops->exp_sync();
+		} else {
+			cur_ops->sync();
+		}
+		t = ktime_get_mono_fast_ns();
+		*wdp = t - *wdp;
+		i_max = i;
+		if (!started &&
+		    atomic_read(&n_rcu_scale_writer_started) >= nrealwriters)
+			started = true;
+		if (!done && i >= MIN_MEAS) {
+			done = true;
+			sched_set_normal(current, 0);
+			pr_alert("%s%s rcu_scale_writer %ld has %d measurements\n",
+				 scale_type, SCALE_FLAG, me, MIN_MEAS);
+			if (atomic_inc_return(&n_rcu_scale_writer_finished) >=
+			    nrealwriters) {
+				schedule_timeout_interruptible(10);
+				rcu_ftrace_dump(DUMP_ALL);
+				SCALEOUT_STRING("Test complete");
+				t_rcu_scale_writer_finished = t;
+				if (gp_exp) {
+					b_rcu_gp_test_finished =
+						cur_ops->exp_completed() / 2;
+				} else {
+					b_rcu_gp_test_finished =
+						cur_ops->get_gp_seq();
+				}
+				if (shutdown) {
+					smp_mb(); /* Assign before wake. */
+					wake_up(&shutdown_wq);
+				}
+			}
+		}
+		if (done && !alldone &&
+		    atomic_read(&n_rcu_scale_writer_finished) >= nrealwriters)
+			alldone = true;
+		if (started && !alldone && i < MAX_MEAS - 1)
+			i++;
+		rcu_scale_wait_shutdown();
+	} while (!torture_must_stop());
+	if (gp_async) {
+		cur_ops->gp_barrier();
+	}
+	writer_n_durations[me] = i_max;
+	torture_kthread_stopping("rcu_scale_writer");
+	return 0;
+}
+
+static void
+rcu_scale_print_module_parms(struct rcu_scale_ops *cur_ops, const char *tag)
+{
+	pr_alert("%s" SCALE_FLAG
+		 "--- %s: nreaders=%d nwriters=%d verbose=%d shutdown=%d\n",
+		 scale_type, tag, nrealreaders, nrealwriters, verbose, shutdown);
+}
+
+static void
+rcu_scale_cleanup(void)
+{
+	int i;
+	int j;
+	int ngps = 0;
+	u64 *wdp;
+	u64 *wdpp;
+
+	/*
+	 * Would like warning at start, but everything is expedited
+	 * during the mid-boot phase, so have to wait till the end.
+	 */
+	if (rcu_gp_is_expedited() && !rcu_gp_is_normal() && !gp_exp)
+		VERBOSE_SCALEOUT_ERRSTRING("All grace periods expedited, no normal ones to measure!");
+	if (rcu_gp_is_normal() && gp_exp)
+		VERBOSE_SCALEOUT_ERRSTRING("All grace periods normal, no expedited ones to measure!");
+	if (gp_exp && gp_async)
+		VERBOSE_SCALEOUT_ERRSTRING("No expedited async GPs, so went with async!");
+
+	if (torture_cleanup_begin())
+		return;
+	if (!cur_ops) {
+		torture_cleanup_end();
+		return;
+	}
+
+	if (reader_tasks) {
+		for (i = 0; i < nrealreaders; i++)
+			torture_stop_kthread(rcu_scale_reader,
+					     reader_tasks[i]);
+		kfree(reader_tasks);
+	}
+
+	if (writer_tasks) {
+		for (i = 0; i < nrealwriters; i++) {
+			torture_stop_kthread(rcu_scale_writer,
+					     writer_tasks[i]);
+			if (!writer_n_durations)
+				continue;
+			j = writer_n_durations[i];
+			pr_alert("%s%s writer %d gps: %d\n",
+				 scale_type, SCALE_FLAG, i, j);
+			ngps += j;
+		}
+		pr_alert("%s%s start: %llu end: %llu duration: %llu gps: %d batches: %ld\n",
+			 scale_type, SCALE_FLAG,
+			 t_rcu_scale_writer_started, t_rcu_scale_writer_finished,
+			 t_rcu_scale_writer_finished -
+			 t_rcu_scale_writer_started,
+			 ngps,
+			 rcuscale_seq_diff(b_rcu_gp_test_finished,
+					   b_rcu_gp_test_started));
+		for (i = 0; i < nrealwriters; i++) {
+			if (!writer_durations)
+				break;
+			if (!writer_n_durations)
+				continue;
+			wdpp = writer_durations[i];
+			if (!wdpp)
+				continue;
+			for (j = 0; j <= writer_n_durations[i]; j++) {
+				wdp = &wdpp[j];
+				pr_alert("%s%s %4d writer-duration: %5d %llu\n",
+					scale_type, SCALE_FLAG,
+					i, j, *wdp);
+				if (j % 100 == 0)
+					schedule_timeout_uninterruptible(1);
+			}
+			kfree(writer_durations[i]);
+		}
+		kfree(writer_tasks);
+		kfree(writer_durations);
+		kfree(writer_n_durations);
+	}
+
+	/* Do torture-type-specific cleanup operations.  */
+	if (cur_ops->cleanup != NULL)
+		cur_ops->cleanup();
+
+	torture_cleanup_end();
+}
+
+/*
+ * Return the number if non-negative.  If -1, the number of CPUs.
+ * If less than -1, that much less than the number of CPUs, but
+ * at least one.
+ */
+static int compute_real(int n)
+{
+	int nr;
+
+	if (n >= 0) {
+		nr = n;
+	} else {
+		nr = num_online_cpus() + 1 + n;
+		if (nr <= 0)
+			nr = 1;
+	}
+	return nr;
+}
+
+/*
+ * RCU scalability shutdown kthread.  Just waits to be awakened, then shuts
+ * down system.
+ */
+static int
+rcu_scale_shutdown(void *arg)
+{
+	wait_event(shutdown_wq,
+		   atomic_read(&n_rcu_scale_writer_finished) >= nrealwriters);
+	smp_mb(); /* Wake before output. */
+	rcu_scale_cleanup();
+	kernel_power_off();
+	return -EINVAL;
+}
+
+/*
+ * kfree_rcu() scalability tests: Start a kfree_rcu() loop on all CPUs for number
+ * of iterations and measure total time and number of GP for all iterations to complete.
+ */
+
+torture_param(int, kfree_nthreads, -1, "Number of threads running loops of kfree_rcu().");
+torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done in an iteration.");
+torture_param(int, kfree_loops, 10, "Number of loops doing kfree_alloc_num allocations and frees.");
+
+static struct task_struct **kfree_reader_tasks;
+static int kfree_nrealthreads;
+static atomic_t n_kfree_scale_thread_started;
+static atomic_t n_kfree_scale_thread_ended;
+
+struct kfree_obj {
+	char kfree_obj[8];
+	struct rcu_head rh;
+};
+
+static int
+kfree_scale_thread(void *arg)
+{
+	int i, loop = 0;
+	long me = (long)arg;
+	struct kfree_obj *alloc_ptr;
+	u64 start_time, end_time;
+	long long mem_begin, mem_during = 0;
+
+	VERBOSE_SCALEOUT_STRING("kfree_scale_thread task started");
+	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
+	set_user_nice(current, MAX_NICE);
+
+	start_time = ktime_get_mono_fast_ns();
+
+	if (atomic_inc_return(&n_kfree_scale_thread_started) >= kfree_nrealthreads) {
+		if (gp_exp)
+			b_rcu_gp_test_started = cur_ops->exp_completed() / 2;
+		else
+			b_rcu_gp_test_started = cur_ops->get_gp_seq();
+	}
+
+	do {
+		if (!mem_during) {
+			mem_during = mem_begin = si_mem_available();
+		} else if (loop % (kfree_loops / 4) == 0) {
+			mem_during = (mem_during + si_mem_available()) / 2;
+		}
+
+		for (i = 0; i < kfree_alloc_num; i++) {
+			alloc_ptr = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
+			if (!alloc_ptr)
+				return -ENOMEM;
+
+			kfree_rcu(alloc_ptr, rh);
+		}
+
+		cond_resched();
+	} while (!torture_must_stop() && ++loop < kfree_loops);
+
+	if (atomic_inc_return(&n_kfree_scale_thread_ended) >= kfree_nrealthreads) {
+		end_time = ktime_get_mono_fast_ns();
+
+		if (gp_exp)
+			b_rcu_gp_test_finished = cur_ops->exp_completed() / 2;
+		else
+			b_rcu_gp_test_finished = cur_ops->get_gp_seq();
+
+		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld, memory footprint: %lldMB\n",
+		       (unsigned long long)(end_time - start_time), kfree_loops,
+		       rcuscale_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started),
+		       (mem_begin - mem_during) >> (20 - PAGE_SHIFT));
+
+		if (shutdown) {
+			smp_mb(); /* Assign before wake. */
+			wake_up(&shutdown_wq);
+		}
+	}
+
+	torture_kthread_stopping("kfree_scale_thread");
+	return 0;
+}
+
+static void
+kfree_scale_cleanup(void)
+{
+	int i;
+
+	if (torture_cleanup_begin())
+		return;
+
+	if (kfree_reader_tasks) {
+		for (i = 0; i < kfree_nrealthreads; i++)
+			torture_stop_kthread(kfree_scale_thread,
+					     kfree_reader_tasks[i]);
+		kfree(kfree_reader_tasks);
+	}
+
+	torture_cleanup_end();
+}
+
+/*
+ * shutdown kthread.  Just waits to be awakened, then shuts down system.
+ */
+static int
+kfree_scale_shutdown(void *arg)
+{
+	wait_event(shutdown_wq,
+		   atomic_read(&n_kfree_scale_thread_ended) >= kfree_nrealthreads);
+
+	smp_mb(); /* Wake before output. */
+
+	kfree_scale_cleanup();
+	kernel_power_off();
+	return -EINVAL;
+}
+
+static int __init
+kfree_scale_init(void)
+{
+	long i;
+	int firsterr = 0;
+
+	kfree_nrealthreads = compute_real(kfree_nthreads);
+	/* Start up the kthreads. */
+	if (shutdown) {
+		init_waitqueue_head(&shutdown_wq);
+		firsterr = torture_create_kthread(kfree_scale_shutdown, NULL,
+						  shutdown_task);
+		if (firsterr)
+			goto unwind;
+		schedule_timeout_uninterruptible(1);
+	}
+
+	pr_alert("kfree object size=%zu\n", kfree_mult * sizeof(struct kfree_obj));
+
+	kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
+			       GFP_KERNEL);
+	if (kfree_reader_tasks == NULL) {
+		firsterr = -ENOMEM;
+		goto unwind;
+	}
+
+	for (i = 0; i < kfree_nrealthreads; i++) {
+		firsterr = torture_create_kthread(kfree_scale_thread, (void *)i,
+						  kfree_reader_tasks[i]);
+		if (firsterr)
+			goto unwind;
+	}
+
+	while (atomic_read(&n_kfree_scale_thread_started) < kfree_nrealthreads)
+		schedule_timeout_uninterruptible(1);
+
+	torture_init_end();
+	return 0;
+
+unwind:
+	torture_init_end();
+	kfree_scale_cleanup();
+	return firsterr;
+}
+
+static int __init
+rcu_scale_init(void)
+{
+	long i;
+	int firsterr = 0;
+	static struct rcu_scale_ops *scale_ops[] = {
+		&rcu_ops, &srcu_ops, &srcud_ops, &tasks_ops,
+	};
+
+	if (!torture_init_begin(scale_type, verbose))
+		return -EBUSY;
+
+	/* Process args and announce that the scalability'er is on the job. */
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
+		WARN_ON(!IS_MODULE(CONFIG_RCU_SCALE_TEST));
+		firsterr = -EINVAL;
+		cur_ops = NULL;
+		goto unwind;
+	}
+	if (cur_ops->init)
+		cur_ops->init();
+
+	if (kfree_rcu_test)
+		return kfree_scale_init();
+
+	nrealwriters = compute_real(nwriters);
+	nrealreaders = compute_real(nreaders);
+	atomic_set(&n_rcu_scale_reader_started, 0);
+	atomic_set(&n_rcu_scale_writer_started, 0);
+	atomic_set(&n_rcu_scale_writer_finished, 0);
+	rcu_scale_print_module_parms(cur_ops, "Start of test");
+
+	/* Start up the kthreads. */
+
+	if (shutdown) {
+		init_waitqueue_head(&shutdown_wq);
+		firsterr = torture_create_kthread(rcu_scale_shutdown, NULL,
+						  shutdown_task);
+		if (firsterr)
+			goto unwind;
+		schedule_timeout_uninterruptible(1);
+	}
+	reader_tasks = kcalloc(nrealreaders, sizeof(reader_tasks[0]),
+			       GFP_KERNEL);
+	if (reader_tasks == NULL) {
+		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
+		firsterr = -ENOMEM;
+		goto unwind;
+	}
+	for (i = 0; i < nrealreaders; i++) {
+		firsterr = torture_create_kthread(rcu_scale_reader, (void *)i,
+						  reader_tasks[i]);
+		if (firsterr)
+			goto unwind;
+	}
+	while (atomic_read(&n_rcu_scale_reader_started) < nrealreaders)
+		schedule_timeout_uninterruptible(1);
+	writer_tasks = kcalloc(nrealwriters, sizeof(reader_tasks[0]),
+			       GFP_KERNEL);
+	writer_durations = kcalloc(nrealwriters, sizeof(*writer_durations),
+				   GFP_KERNEL);
+	writer_n_durations =
+		kcalloc(nrealwriters, sizeof(*writer_n_durations),
+			GFP_KERNEL);
+	if (!writer_tasks || !writer_durations || !writer_n_durations) {
+		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
+		firsterr = -ENOMEM;
+		goto unwind;
+	}
+	for (i = 0; i < nrealwriters; i++) {
+		writer_durations[i] =
+			kcalloc(MAX_MEAS, sizeof(*writer_durations[i]),
+				GFP_KERNEL);
+		if (!writer_durations[i]) {
+			firsterr = -ENOMEM;
+			goto unwind;
+		}
+		firsterr = torture_create_kthread(rcu_scale_writer, (void *)i,
+						  writer_tasks[i]);
+		if (firsterr)
+			goto unwind;
+	}
+	torture_init_end();
+	return 0;
+
+unwind:
+	torture_init_end();
+	rcu_scale_cleanup();
+	return firsterr;
+}
+
+module_init(rcu_scale_init);
+module_exit(rcu_scale_cleanup);
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf-ftrace.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf-ftrace.sh
deleted file mode 100755
index 7d3c2be..0000000
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf-ftrace.sh
+++ /dev/null
@@ -1,109 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Analyze a given results directory for rcuperf performance measurements,
-# looking for ftrace data.  Exits with 0 if data was found, analyzed, and
-# printed.  Intended to be invoked from kvm-recheck-rcuperf.sh after
-# argument checking.
-#
-# Usage: kvm-recheck-rcuperf-ftrace.sh resdir
-#
-# Copyright (C) IBM Corporation, 2016
-#
-# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
-
-i="$1"
-. functions.sh
-
-if test "`grep -c 'rcu_exp_grace_period.*start' < $i/console.log`" -lt 100
-then
-	exit 10
-fi
-
-sed -e 's/^\[[^]]*]//' < $i/console.log |
-grep 'us : rcu_exp_grace_period' |
-sed -e 's/us : / : /' |
-tr -d '\015' |
-awk '
-$8 == "start" {
-	if (startseq != "")
-		nlost++;
-	starttask = $1;
-	starttime = $3;
-	startseq = $7;
-	seqtask[startseq] = starttask;
-}
-
-$8 == "end" {
-	if (startseq == $7) {
-		curgpdur = $3 - starttime;
-		gptimes[++n] = curgpdur;
-		gptaskcnt[starttask]++;
-		sum += curgpdur;
-		if (curgpdur > 1000)
-			print "Long GP " starttime "us to " $3 "us (" curgpdur "us)";
-		startseq = "";
-	} else {
-		# Lost a message or some such, reset.
-		startseq = "";
-		nlost++;
-	}
-}
-
-$8 == "done" && seqtask[$7] != $1 {
-	piggybackcnt[$1]++;
-}
-
-END {
-	newNR = asort(gptimes);
-	if (newNR <= 0) {
-		print "No ftrace records found???"
-		exit 10;
-	}
-	pct50 = int(newNR * 50 / 100);
-	if (pct50 < 1)
-		pct50 = 1;
-	pct90 = int(newNR * 90 / 100);
-	if (pct90 < 1)
-		pct90 = 1;
-	pct99 = int(newNR * 99 / 100);
-	if (pct99 < 1)
-		pct99 = 1;
-	div = 10 ** int(log(gptimes[pct90]) / log(10) + .5) / 100;
-	print "Histogram bucket size: " div;
-	last = gptimes[1] - 10;
-	count = 0;
-	for (i = 1; i <= newNR; i++) {
-		current = div * int(gptimes[i] / div);
-		if (last == current) {
-			count++;
-		} else {
-			if (count > 0)
-				print last, count;
-			count = 1;
-			last = current;
-		}
-	}
-	if (count > 0)
-		print last, count;
-	print "Distribution of grace periods across tasks:";
-	for (i in gptaskcnt) {
-		print "\t" i, gptaskcnt[i];
-		nbatches += gptaskcnt[i];
-	}
-	ngps = nbatches;
-	print "Distribution of piggybacking across tasks:";
-	for (i in piggybackcnt) {
-		print "\t" i, piggybackcnt[i];
-		ngps += piggybackcnt[i];
-	}
-	print "Average grace-period duration: " sum / newNR " microseconds";
-	print "Minimum grace-period duration: " gptimes[1];
-	print "50th percentile grace-period duration: " gptimes[pct50];
-	print "90th percentile grace-period duration: " gptimes[pct90];
-	print "99th percentile grace-period duration: " gptimes[pct99];
-	print "Maximum grace-period duration: " gptimes[newNR];
-	print "Grace periods: " ngps + 0 " Batches: " nbatches + 0 " Ratio: " ngps / nbatches " Lost: " nlost + 0;
-	print "Computed from ftrace data.";
-}'
-exit 0
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf.sh
deleted file mode 100755
index db0375a..0000000
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf.sh
+++ /dev/null
@@ -1,83 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Analyze a given results directory for rcuperf performance measurements.
-#
-# Usage: kvm-recheck-rcuperf.sh resdir
-#
-# Copyright (C) IBM Corporation, 2016
-#
-# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
-
-i="$1"
-if test -d "$i" -a -r "$i"
-then
-	:
-else
-	echo Unreadable results directory: $i
-	exit 1
-fi
-PATH=`pwd`/tools/testing/selftests/rcutorture/bin:$PATH; export PATH
-. functions.sh
-
-if kvm-recheck-rcuperf-ftrace.sh $i
-then
-	# ftrace data was successfully analyzed, call it good!
-	exit 0
-fi
-
-configfile=`echo $i | sed -e 's/^.*\///'`
-
-sed -e 's/^\[[^]]*]//' < $i/console.log |
-awk '
-/-perf: .* gps: .* batches:/ {
-	ngps = $9;
-	nbatches = $11;
-}
-
-/-perf: .*writer-duration/ {
-	gptimes[++n] = $5 / 1000.;
-	sum += $5 / 1000.;
-}
-
-END {
-	newNR = asort(gptimes);
-	if (newNR <= 0) {
-		print "No rcuperf records found???"
-		exit;
-	}
-	pct50 = int(newNR * 50 / 100);
-	if (pct50 < 1)
-		pct50 = 1;
-	pct90 = int(newNR * 90 / 100);
-	if (pct90 < 1)
-		pct90 = 1;
-	pct99 = int(newNR * 99 / 100);
-	if (pct99 < 1)
-		pct99 = 1;
-	div = 10 ** int(log(gptimes[pct90]) / log(10) + .5) / 100;
-	print "Histogram bucket size: " div;
-	last = gptimes[1] - 10;
-	count = 0;
-	for (i = 1; i <= newNR; i++) {
-		current = div * int(gptimes[i] / div);
-		if (last == current) {
-			count++;
-		} else {
-			if (count > 0)
-				print last, count;
-			count = 1;
-			last = current;
-		}
-	}
-	if (count > 0)
-		print last, count;
-	print "Average grace-period duration: " sum / newNR " microseconds";
-	print "Minimum grace-period duration: " gptimes[1];
-	print "50th percentile grace-period duration: " gptimes[pct50];
-	print "90th percentile grace-period duration: " gptimes[pct90];
-	print "99th percentile grace-period duration: " gptimes[pct99];
-	print "Maximum grace-period duration: " gptimes[newNR];
-	print "Grace periods: " ngps + 0 " Batches: " nbatches + 0 " Ratio: " ngps / nbatches;
-	print "Computed from rcuperf printk output.";
-}'
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale-ftrace.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale-ftrace.sh
new file mode 100755
index 0000000..d4bec53
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale-ftrace.sh
@@ -0,0 +1,109 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Analyze a given results directory for rcuscale performance measurements,
+# looking for ftrace data.  Exits with 0 if data was found, analyzed, and
+# printed.  Intended to be invoked from kvm-recheck-rcuscale.sh after
+# argument checking.
+#
+# Usage: kvm-recheck-rcuscale-ftrace.sh resdir
+#
+# Copyright (C) IBM Corporation, 2016
+#
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
+
+i="$1"
+. functions.sh
+
+if test "`grep -c 'rcu_exp_grace_period.*start' < $i/console.log`" -lt 100
+then
+	exit 10
+fi
+
+sed -e 's/^\[[^]]*]//' < $i/console.log |
+grep 'us : rcu_exp_grace_period' |
+sed -e 's/us : / : /' |
+tr -d '\015' |
+awk '
+$8 == "start" {
+	if (startseq != "")
+		nlost++;
+	starttask = $1;
+	starttime = $3;
+	startseq = $7;
+	seqtask[startseq] = starttask;
+}
+
+$8 == "end" {
+	if (startseq == $7) {
+		curgpdur = $3 - starttime;
+		gptimes[++n] = curgpdur;
+		gptaskcnt[starttask]++;
+		sum += curgpdur;
+		if (curgpdur > 1000)
+			print "Long GP " starttime "us to " $3 "us (" curgpdur "us)";
+		startseq = "";
+	} else {
+		# Lost a message or some such, reset.
+		startseq = "";
+		nlost++;
+	}
+}
+
+$8 == "done" && seqtask[$7] != $1 {
+	piggybackcnt[$1]++;
+}
+
+END {
+	newNR = asort(gptimes);
+	if (newNR <= 0) {
+		print "No ftrace records found???"
+		exit 10;
+	}
+	pct50 = int(newNR * 50 / 100);
+	if (pct50 < 1)
+		pct50 = 1;
+	pct90 = int(newNR * 90 / 100);
+	if (pct90 < 1)
+		pct90 = 1;
+	pct99 = int(newNR * 99 / 100);
+	if (pct99 < 1)
+		pct99 = 1;
+	div = 10 ** int(log(gptimes[pct90]) / log(10) + .5) / 100;
+	print "Histogram bucket size: " div;
+	last = gptimes[1] - 10;
+	count = 0;
+	for (i = 1; i <= newNR; i++) {
+		current = div * int(gptimes[i] / div);
+		if (last == current) {
+			count++;
+		} else {
+			if (count > 0)
+				print last, count;
+			count = 1;
+			last = current;
+		}
+	}
+	if (count > 0)
+		print last, count;
+	print "Distribution of grace periods across tasks:";
+	for (i in gptaskcnt) {
+		print "\t" i, gptaskcnt[i];
+		nbatches += gptaskcnt[i];
+	}
+	ngps = nbatches;
+	print "Distribution of piggybacking across tasks:";
+	for (i in piggybackcnt) {
+		print "\t" i, piggybackcnt[i];
+		ngps += piggybackcnt[i];
+	}
+	print "Average grace-period duration: " sum / newNR " microseconds";
+	print "Minimum grace-period duration: " gptimes[1];
+	print "50th percentile grace-period duration: " gptimes[pct50];
+	print "90th percentile grace-period duration: " gptimes[pct90];
+	print "99th percentile grace-period duration: " gptimes[pct99];
+	print "Maximum grace-period duration: " gptimes[newNR];
+	print "Grace periods: " ngps + 0 " Batches: " nbatches + 0 " Ratio: " ngps / nbatches " Lost: " nlost + 0;
+	print "Computed from ftrace data.";
+}'
+exit 0
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh
new file mode 100755
index 0000000..aa74515
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh
@@ -0,0 +1,83 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Analyze a given results directory for rcuscale scalability measurements.
+#
+# Usage: kvm-recheck-rcuscale.sh resdir
+#
+# Copyright (C) IBM Corporation, 2016
+#
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
+
+i="$1"
+if test -d "$i" -a -r "$i"
+then
+	:
+else
+	echo Unreadable results directory: $i
+	exit 1
+fi
+PATH=`pwd`/tools/testing/selftests/rcutorture/bin:$PATH; export PATH
+. functions.sh
+
+if kvm-recheck-rcuscale-ftrace.sh $i
+then
+	# ftrace data was successfully analyzed, call it good!
+	exit 0
+fi
+
+configfile=`echo $i | sed -e 's/^.*\///'`
+
+sed -e 's/^\[[^]]*]//' < $i/console.log |
+awk '
+/-scale: .* gps: .* batches:/ {
+	ngps = $9;
+	nbatches = $11;
+}
+
+/-scale: .*writer-duration/ {
+	gptimes[++n] = $5 / 1000.;
+	sum += $5 / 1000.;
+}
+
+END {
+	newNR = asort(gptimes);
+	if (newNR <= 0) {
+		print "No rcuscale records found???"
+		exit;
+	}
+	pct50 = int(newNR * 50 / 100);
+	if (pct50 < 1)
+		pct50 = 1;
+	pct90 = int(newNR * 90 / 100);
+	if (pct90 < 1)
+		pct90 = 1;
+	pct99 = int(newNR * 99 / 100);
+	if (pct99 < 1)
+		pct99 = 1;
+	div = 10 ** int(log(gptimes[pct90]) / log(10) + .5) / 100;
+	print "Histogram bucket size: " div;
+	last = gptimes[1] - 10;
+	count = 0;
+	for (i = 1; i <= newNR; i++) {
+		current = div * int(gptimes[i] / div);
+		if (last == current) {
+			count++;
+		} else {
+			if (count > 0)
+				print last, count;
+			count = 1;
+			last = current;
+		}
+	}
+	if (count > 0)
+		print last, count;
+	print "Average grace-period duration: " sum / newNR " microseconds";
+	print "Minimum grace-period duration: " gptimes[1];
+	print "50th percentile grace-period duration: " gptimes[pct50];
+	print "90th percentile grace-period duration: " gptimes[pct90];
+	print "99th percentile grace-period duration: " gptimes[pct99];
+	print "Maximum grace-period duration: " gptimes[newNR];
+	print "Grace periods: " ngps + 0 " Batches: " nbatches + 0 " Ratio: " ngps / nbatches;
+	print "Computed from rcuscale printk output.";
+}'
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 44dfdd9..0489c19 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -65,7 +65,7 @@ usage () {
 	echo "       --qemu-args qemu-arguments"
 	echo "       --qemu-cmd qemu-system-..."
 	echo "       --results absolute-pathname"
-	echo "       --torture rcu"
+	echo "       --torture lock|rcu|rcuscale|refscale|scf"
 	echo "       --trust-make"
 	exit 1
 }
@@ -184,13 +184,13 @@ do
 		shift
 		;;
 	--torture)
-		checkarg --torture "(suite name)" "$#" "$2" '^\(lock\|rcu\|rcuperf\|refscale\|scf\)$' '^--'
+		checkarg --torture "(suite name)" "$#" "$2" '^\(lock\|rcu\|rcuscale\|refscale\|scf\)$' '^--'
 		TORTURE_SUITE=$2
 		shift
-		if test "$TORTURE_SUITE" = rcuperf || test "$TORTURE_SUITE" = refscale
+		if test "$TORTURE_SUITE" = rcuscale || test "$TORTURE_SUITE" = refscale
 		then
 			# If you really want jitter for refscale or
-			# rcuperf, specify it after specifying the rcuperf
+			# rcuscale, specify it after specifying the rcuscale
 			# or the refscale.  (But why jitter in these cases?)
 			jitter=0
 		fi
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 4e081a2..e033380 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -33,8 +33,8 @@ then
 fi
 cat /dev/null > $file.diags
 
-# Check for proper termination, except for rcuperf and refscale.
-if test "$TORTURE_SUITE" != rcuperf && test "$TORTURE_SUITE" != refscale
+# Check for proper termination, except for rcuscale and refscale.
+if test "$TORTURE_SUITE" != rcuscale && test "$TORTURE_SUITE" != refscale
 then
 	# check for abject failure
 
diff --git a/tools/testing/selftests/rcutorture/configs/rcuperf/CFLIST b/tools/testing/selftests/rcutorture/configs/rcuperf/CFLIST
deleted file mode 100644
index c9f56cf..0000000
--- a/tools/testing/selftests/rcutorture/configs/rcuperf/CFLIST
+++ /dev/null
@@ -1 +0,0 @@
-TREE
diff --git a/tools/testing/selftests/rcutorture/configs/rcuperf/CFcommon b/tools/testing/selftests/rcutorture/configs/rcuperf/CFcommon
deleted file mode 100644
index a09816b..0000000
--- a/tools/testing/selftests/rcutorture/configs/rcuperf/CFcommon
+++ /dev/null
@@ -1,2 +0,0 @@
-CONFIG_RCU_PERF_TEST=y
-CONFIG_PRINTK_TIME=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuperf/TINY b/tools/testing/selftests/rcutorture/configs/rcuperf/TINY
deleted file mode 100644
index fb05ef5..0000000
--- a/tools/testing/selftests/rcutorture/configs/rcuperf/TINY
+++ /dev/null
@@ -1,16 +0,0 @@
-CONFIG_SMP=n
-CONFIG_PREEMPT_NONE=y
-CONFIG_PREEMPT_VOLUNTARY=n
-CONFIG_PREEMPT=n
-#CHECK#CONFIG_TINY_RCU=y
-CONFIG_HZ_PERIODIC=n
-CONFIG_NO_HZ_IDLE=y
-CONFIG_NO_HZ_FULL=n
-CONFIG_RCU_FAST_NO_HZ=n
-CONFIG_RCU_NOCB_CPU=n
-CONFIG_DEBUG_LOCK_ALLOC=n
-CONFIG_PROVE_LOCKING=n
-CONFIG_RCU_BOOST=n
-CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
-CONFIG_RCU_EXPERT=y
-CONFIG_RCU_TRACE=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuperf/TREE b/tools/testing/selftests/rcutorture/configs/rcuperf/TREE
deleted file mode 100644
index 721cfda..0000000
--- a/tools/testing/selftests/rcutorture/configs/rcuperf/TREE
+++ /dev/null
@@ -1,19 +0,0 @@
-CONFIG_SMP=y
-CONFIG_PREEMPT_NONE=n
-CONFIG_PREEMPT_VOLUNTARY=n
-CONFIG_PREEMPT=y
-#CHECK#CONFIG_PREEMPT_RCU=y
-CONFIG_HZ_PERIODIC=n
-CONFIG_NO_HZ_IDLE=y
-CONFIG_NO_HZ_FULL=n
-CONFIG_RCU_FAST_NO_HZ=n
-CONFIG_HOTPLUG_CPU=n
-CONFIG_SUSPEND=n
-CONFIG_HIBERNATION=n
-CONFIG_RCU_NOCB_CPU=n
-CONFIG_DEBUG_LOCK_ALLOC=n
-CONFIG_PROVE_LOCKING=n
-CONFIG_RCU_BOOST=n
-CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
-CONFIG_RCU_EXPERT=y
-CONFIG_RCU_TRACE=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuperf/TREE54 b/tools/testing/selftests/rcutorture/configs/rcuperf/TREE54
deleted file mode 100644
index 7629f5d..0000000
--- a/tools/testing/selftests/rcutorture/configs/rcuperf/TREE54
+++ /dev/null
@@ -1,22 +0,0 @@
-CONFIG_SMP=y
-CONFIG_NR_CPUS=54
-CONFIG_PREEMPT_NONE=n
-CONFIG_PREEMPT_VOLUNTARY=n
-CONFIG_PREEMPT=y
-#CHECK#CONFIG_PREEMPT_RCU=y
-CONFIG_HZ_PERIODIC=n
-CONFIG_NO_HZ_IDLE=y
-CONFIG_NO_HZ_FULL=n
-CONFIG_RCU_FAST_NO_HZ=n
-CONFIG_HOTPLUG_CPU=n
-CONFIG_SUSPEND=n
-CONFIG_HIBERNATION=n
-CONFIG_RCU_FANOUT=3
-CONFIG_RCU_FANOUT_LEAF=2
-CONFIG_RCU_NOCB_CPU=n
-CONFIG_DEBUG_LOCK_ALLOC=n
-CONFIG_PROVE_LOCKING=n
-CONFIG_RCU_BOOST=n
-CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
-CONFIG_RCU_EXPERT=y
-CONFIG_RCU_TRACE=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuperf/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/rcuperf/ver_functions.sh
deleted file mode 100644
index 777d5b0..0000000
--- a/tools/testing/selftests/rcutorture/configs/rcuperf/ver_functions.sh
+++ /dev/null
@@ -1,16 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Torture-suite-dependent shell functions for the rest of the scripts.
-#
-# Copyright (C) IBM Corporation, 2015
-#
-# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
-
-# per_version_boot_params bootparam-string config-file seconds
-#
-# Adds per-version torture-module parameters to kernels supporting them.
-per_version_boot_params () {
-	echo $1 rcuperf.shutdown=1 \
-		rcuperf.verbose=1
-}
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/CFLIST b/tools/testing/selftests/rcutorture/configs/rcuscale/CFLIST
new file mode 100644
index 0000000..c9f56cf
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/CFLIST
@@ -0,0 +1 @@
+TREE
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon b/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
new file mode 100644
index 0000000..87caa0e
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
@@ -0,0 +1,2 @@
+CONFIG_RCU_SCALE_TEST=y
+CONFIG_PRINTK_TIME=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TINY b/tools/testing/selftests/rcutorture/configs/rcuscale/TINY
new file mode 100644
index 0000000..fb05ef5
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TINY
@@ -0,0 +1,16 @@
+CONFIG_SMP=n
+CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=n
+#CHECK#CONFIG_TINY_RCU=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_RCU_FAST_NO_HZ=n
+CONFIG_RCU_NOCB_CPU=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_RCU_BOOST=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=y
+CONFIG_RCU_TRACE=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TREE b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE
new file mode 100644
index 0000000..721cfda
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE
@@ -0,0 +1,19 @@
+CONFIG_SMP=y
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+#CHECK#CONFIG_PREEMPT_RCU=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_RCU_FAST_NO_HZ=n
+CONFIG_HOTPLUG_CPU=n
+CONFIG_SUSPEND=n
+CONFIG_HIBERNATION=n
+CONFIG_RCU_NOCB_CPU=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_RCU_BOOST=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=y
+CONFIG_RCU_TRACE=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TREE54 b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE54
new file mode 100644
index 0000000..7629f5d
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE54
@@ -0,0 +1,22 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=54
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+#CHECK#CONFIG_PREEMPT_RCU=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_RCU_FAST_NO_HZ=n
+CONFIG_HOTPLUG_CPU=n
+CONFIG_SUSPEND=n
+CONFIG_HIBERNATION=n
+CONFIG_RCU_FANOUT=3
+CONFIG_RCU_FANOUT_LEAF=2
+CONFIG_RCU_NOCB_CPU=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_RCU_BOOST=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=y
+CONFIG_RCU_TRACE=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh
new file mode 100644
index 0000000..0333e9b
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh
@@ -0,0 +1,16 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Torture-suite-dependent shell functions for the rest of the scripts.
+#
+# Copyright (C) IBM Corporation, 2015
+#
+# Authors: Paul E. McKenney <paulmck@linux.ibm.com>
+
+# per_version_boot_params bootparam-string config-file seconds
+#
+# Adds per-version torture-module parameters to kernels supporting them.
+per_version_boot_params () {
+	echo $1 rcuscale.shutdown=1 \
+		rcuscale.verbose=1
+}
