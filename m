Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19692F5FF3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Jan 2021 12:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbhANL3p (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Jan 2021 06:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbhANL3n (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Jan 2021 06:29:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EC5C0613C1;
        Thu, 14 Jan 2021 03:29:03 -0800 (PST)
Date:   Thu, 14 Jan 2021 11:28:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610623740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X9wt5ZEywZGEDhvbx1hFFMiK8NCzvGgn0/s+CwTmbIc=;
        b=i2LVKyRuw980IpIzLH6e682uLScRaJ3xzvrF/527c+lWShdUdAuwCHGBet/88cL1j61rlz
        VTj6fYijYQtXjGxKzdLByhTOZCscjdedAkGFzBqb8mNe2qNZTRLxc+CFF9dqukfkw//80T
        HpiT5kw3K+eQY//pAKPj9v7bZr6ofmaRhd16cX0xvEaz1ra73CSx/dqZhHuUW3YVGzcY0m
        a+60D3e/ZpxSA3sHasq0v6Ipq98esChsV7Jjtkgj4txulZ89VNzWk+mFqtXyAh1YYCYHBr
        SzwDdGSVfrQEW2coO2gP+Typ9j8O8fWNZcwcRXeR6BqTXuPEiJyK1RsUKlYUaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610623740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X9wt5ZEywZGEDhvbx1hFFMiK8NCzvGgn0/s+CwTmbIc=;
        b=CJJLFRxQCl8x9q+DffamoNGrokTz/p7SsWdvq1CvAEDrh6ukvhjm2okVYlcpnXjEjlKJo3
        8N4LXlLexVMBGDAA==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep/selftest: Add wait context selftests
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201208103112.2838119-5-boqun.feng@gmail.com>
References: <20201208103112.2838119-5-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <161062373984.414.1157852990371402368.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9271a40d2a1429113160ccc4c16150921600bcc1
Gitweb:        https://git.kernel.org/tip/9271a40d2a1429113160ccc4c16150921600bcc1
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Tue, 08 Dec 2020 18:31:12 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Jan 2021 11:20:16 +01:00

lockdep/selftest: Add wait context selftests

These tests are added for two purposes:

*	Test the implementation of wait context checks and related
	annotations.

*	Semi-document the rules for wait context nesting when
	PROVE_RAW_LOCK_NESTING=y.

The test cases are only avaible for PROVE_RAW_LOCK_NESTING=y, as wait
context checking makes more sense for that configuration.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201208103112.2838119-5-boqun.feng@gmail.com
---
 lib/locking-selftest.c | 232 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 232 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 9959ea2..23376ee 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -64,6 +64,9 @@ static DEFINE_SPINLOCK(lock_B);
 static DEFINE_SPINLOCK(lock_C);
 static DEFINE_SPINLOCK(lock_D);
 
+static DEFINE_RAW_SPINLOCK(raw_lock_A);
+static DEFINE_RAW_SPINLOCK(raw_lock_B);
+
 static DEFINE_RWLOCK(rwlock_A);
 static DEFINE_RWLOCK(rwlock_B);
 static DEFINE_RWLOCK(rwlock_C);
@@ -1306,6 +1309,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_soft_wlock)
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define I_SPINLOCK(x)	lockdep_reset_lock(&lock_##x.dep_map)
+# define I_RAW_SPINLOCK(x)	lockdep_reset_lock(&raw_lock_##x.dep_map)
 # define I_RWLOCK(x)	lockdep_reset_lock(&rwlock_##x.dep_map)
 # define I_MUTEX(x)	lockdep_reset_lock(&mutex_##x.dep_map)
 # define I_RWSEM(x)	lockdep_reset_lock(&rwsem_##x.dep_map)
@@ -1315,6 +1319,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_soft_wlock)
 #endif
 #else
 # define I_SPINLOCK(x)
+# define I_RAW_SPINLOCK(x)
 # define I_RWLOCK(x)
 # define I_MUTEX(x)
 # define I_RWSEM(x)
@@ -1358,9 +1363,12 @@ static void reset_locks(void)
 	I1(A); I1(B); I1(C); I1(D);
 	I1(X1); I1(X2); I1(Y1); I1(Y2); I1(Z1); I1(Z2);
 	I_WW(t); I_WW(t2); I_WW(o.base); I_WW(o2.base); I_WW(o3.base);
+	I_RAW_SPINLOCK(A); I_RAW_SPINLOCK(B);
 	lockdep_reset();
 	I2(A); I2(B); I2(C); I2(D);
 	init_shared_classes();
+	raw_spin_lock_init(&raw_lock_A);
+	raw_spin_lock_init(&raw_lock_B);
 
 	ww_mutex_init(&o, &ww_lockdep); ww_mutex_init(&o2, &ww_lockdep); ww_mutex_init(&o3, &ww_lockdep);
 	memset(&t, 0, sizeof(t)); memset(&t2, 0, sizeof(t2));
@@ -2419,6 +2427,226 @@ static void fs_reclaim_tests(void)
 	pr_cont("\n");
 }
 
+#define __guard(cleanup) __maybe_unused __attribute__((__cleanup__(cleanup)))
+
+static void hardirq_exit(int *_)
+{
+	HARDIRQ_EXIT();
+}
+
+#define HARDIRQ_CONTEXT(name, ...)					\
+	int hardirq_guard_##name __guard(hardirq_exit);			\
+	HARDIRQ_ENTER();
+
+#define NOTTHREADED_HARDIRQ_CONTEXT(name, ...)				\
+	int notthreaded_hardirq_guard_##name __guard(hardirq_exit);	\
+	local_irq_disable();						\
+	__irq_enter();							\
+	WARN_ON(!in_irq());
+
+static void softirq_exit(int *_)
+{
+	SOFTIRQ_EXIT();
+}
+
+#define SOFTIRQ_CONTEXT(name, ...)				\
+	int softirq_guard_##name __guard(softirq_exit);		\
+	SOFTIRQ_ENTER();
+
+static void rcu_exit(int *_)
+{
+	rcu_read_unlock();
+}
+
+#define RCU_CONTEXT(name, ...)					\
+	int rcu_guard_##name __guard(rcu_exit);			\
+	rcu_read_lock();
+
+static void rcu_bh_exit(int *_)
+{
+	rcu_read_unlock_bh();
+}
+
+#define RCU_BH_CONTEXT(name, ...)				\
+	int rcu_bh_guard_##name __guard(rcu_bh_exit);		\
+	rcu_read_lock_bh();
+
+static void rcu_sched_exit(int *_)
+{
+	rcu_read_unlock_sched();
+}
+
+#define RCU_SCHED_CONTEXT(name, ...)				\
+	int rcu_sched_guard_##name __guard(rcu_sched_exit);	\
+	rcu_read_lock_sched();
+
+static void rcu_callback_exit(int *_)
+{
+	rcu_lock_release(&rcu_callback_map);
+}
+
+#define RCU_CALLBACK_CONTEXT(name, ...)					\
+	int rcu_callback_guard_##name __guard(rcu_callback_exit);	\
+	rcu_lock_acquire(&rcu_callback_map);
+
+
+static void raw_spinlock_exit(raw_spinlock_t **lock)
+{
+	raw_spin_unlock(*lock);
+}
+
+#define RAW_SPINLOCK_CONTEXT(name, lock)						\
+	raw_spinlock_t *raw_spinlock_guard_##name __guard(raw_spinlock_exit) = &(lock);	\
+	raw_spin_lock(&(lock));
+
+static void spinlock_exit(spinlock_t **lock)
+{
+	spin_unlock(*lock);
+}
+
+#define SPINLOCK_CONTEXT(name, lock)						\
+	spinlock_t *spinlock_guard_##name __guard(spinlock_exit) = &(lock);	\
+	spin_lock(&(lock));
+
+static void mutex_exit(struct mutex **lock)
+{
+	mutex_unlock(*lock);
+}
+
+#define MUTEX_CONTEXT(name, lock)					\
+	struct mutex *mutex_guard_##name __guard(mutex_exit) = &(lock);	\
+	mutex_lock(&(lock));
+
+#define GENERATE_2_CONTEXT_TESTCASE(outer, outer_lock, inner, inner_lock)	\
+										\
+static void __maybe_unused inner##_in_##outer(void)				\
+{										\
+	outer##_CONTEXT(_, outer_lock);						\
+	{									\
+		inner##_CONTEXT(_, inner_lock);					\
+	}									\
+}
+
+/*
+ * wait contexts (considering PREEMPT_RT)
+ *
+ * o: inner is allowed in outer
+ * x: inner is disallowed in outer
+ *
+ *       \  inner |  RCU  | RAW_SPIN | SPIN | MUTEX
+ * outer  \       |       |          |      |
+ * ---------------+-------+----------+------+-------
+ * HARDIRQ        |   o   |    o     |  o   |  x
+ * ---------------+-------+----------+------+-------
+ * NOTTHREADED_IRQ|   o   |    o     |  x   |  x
+ * ---------------+-------+----------+------+-------
+ * SOFTIRQ        |   o   |    o     |  o   |  x
+ * ---------------+-------+----------+------+-------
+ * RCU            |   o   |    o     |  o   |  x
+ * ---------------+-------+----------+------+-------
+ * RCU_BH         |   o   |    o     |  o   |  x
+ * ---------------+-------+----------+------+-------
+ * RCU_CALLBACK   |   o   |    o     |  o   |  x
+ * ---------------+-------+----------+------+-------
+ * RCU_SCHED      |   o   |    o     |  x   |  x
+ * ---------------+-------+----------+------+-------
+ * RAW_SPIN       |   o   |    o     |  x   |  x
+ * ---------------+-------+----------+------+-------
+ * SPIN           |   o   |    o     |  o   |  x
+ * ---------------+-------+----------+------+-------
+ * MUTEX          |   o   |    o     |  o   |  o
+ * ---------------+-------+----------+------+-------
+ */
+
+#define GENERATE_2_CONTEXT_TESTCASE_FOR_ALL_OUTER(inner, inner_lock)		\
+GENERATE_2_CONTEXT_TESTCASE(HARDIRQ, , inner, inner_lock)			\
+GENERATE_2_CONTEXT_TESTCASE(NOTTHREADED_HARDIRQ, , inner, inner_lock)		\
+GENERATE_2_CONTEXT_TESTCASE(SOFTIRQ, , inner, inner_lock)			\
+GENERATE_2_CONTEXT_TESTCASE(RCU, , inner, inner_lock)				\
+GENERATE_2_CONTEXT_TESTCASE(RCU_BH, , inner, inner_lock)			\
+GENERATE_2_CONTEXT_TESTCASE(RCU_CALLBACK, , inner, inner_lock)			\
+GENERATE_2_CONTEXT_TESTCASE(RCU_SCHED, , inner, inner_lock)			\
+GENERATE_2_CONTEXT_TESTCASE(RAW_SPINLOCK, raw_lock_A, inner, inner_lock)	\
+GENERATE_2_CONTEXT_TESTCASE(SPINLOCK, lock_A, inner, inner_lock)		\
+GENERATE_2_CONTEXT_TESTCASE(MUTEX, mutex_A, inner, inner_lock)
+
+GENERATE_2_CONTEXT_TESTCASE_FOR_ALL_OUTER(RCU, )
+GENERATE_2_CONTEXT_TESTCASE_FOR_ALL_OUTER(RAW_SPINLOCK, raw_lock_B)
+GENERATE_2_CONTEXT_TESTCASE_FOR_ALL_OUTER(SPINLOCK, lock_B)
+GENERATE_2_CONTEXT_TESTCASE_FOR_ALL_OUTER(MUTEX, mutex_B)
+
+/* the outer context allows all kinds of preemption */
+#define DO_CONTEXT_TESTCASE_OUTER_PREEMPTIBLE(outer)			\
+	dotest(RCU_in_##outer, SUCCESS, LOCKTYPE_RWLOCK);		\
+	dotest(RAW_SPINLOCK_in_##outer, SUCCESS, LOCKTYPE_SPIN);	\
+	dotest(SPINLOCK_in_##outer, SUCCESS, LOCKTYPE_SPIN);		\
+	dotest(MUTEX_in_##outer, SUCCESS, LOCKTYPE_MUTEX);		\
+
+/*
+ * the outer context only allows the preemption introduced by spinlock_t (which
+ * is a sleepable lock for PREEMPT_RT)
+ */
+#define DO_CONTEXT_TESTCASE_OUTER_LIMITED_PREEMPTIBLE(outer)		\
+	dotest(RCU_in_##outer, SUCCESS, LOCKTYPE_RWLOCK);		\
+	dotest(RAW_SPINLOCK_in_##outer, SUCCESS, LOCKTYPE_SPIN);	\
+	dotest(SPINLOCK_in_##outer, SUCCESS, LOCKTYPE_SPIN);		\
+	dotest(MUTEX_in_##outer, FAILURE, LOCKTYPE_MUTEX);		\
+
+/* the outer doesn't allows any kind of preemption */
+#define DO_CONTEXT_TESTCASE_OUTER_NOT_PREEMPTIBLE(outer)			\
+	dotest(RCU_in_##outer, SUCCESS, LOCKTYPE_RWLOCK);		\
+	dotest(RAW_SPINLOCK_in_##outer, SUCCESS, LOCKTYPE_SPIN);	\
+	dotest(SPINLOCK_in_##outer, FAILURE, LOCKTYPE_SPIN);		\
+	dotest(MUTEX_in_##outer, FAILURE, LOCKTYPE_MUTEX);		\
+
+static void wait_context_tests(void)
+{
+	printk("  --------------------------------------------------------------------------\n");
+	printk("  | wait context tests |\n");
+	printk("  --------------------------------------------------------------------------\n");
+	printk("                                 | rcu  | raw  | spin |mutex |\n");
+	printk("  --------------------------------------------------------------------------\n");
+	print_testname("in hardirq context");
+	DO_CONTEXT_TESTCASE_OUTER_LIMITED_PREEMPTIBLE(HARDIRQ);
+	pr_cont("\n");
+
+	print_testname("in hardirq context (not threaded)");
+	DO_CONTEXT_TESTCASE_OUTER_NOT_PREEMPTIBLE(NOTTHREADED_HARDIRQ);
+	pr_cont("\n");
+
+	print_testname("in softirq context");
+	DO_CONTEXT_TESTCASE_OUTER_LIMITED_PREEMPTIBLE(SOFTIRQ);
+	pr_cont("\n");
+
+	print_testname("in RCU context");
+	DO_CONTEXT_TESTCASE_OUTER_LIMITED_PREEMPTIBLE(RCU);
+	pr_cont("\n");
+
+	print_testname("in RCU-bh context");
+	DO_CONTEXT_TESTCASE_OUTER_LIMITED_PREEMPTIBLE(RCU_BH);
+	pr_cont("\n");
+
+	print_testname("in RCU callback context");
+	DO_CONTEXT_TESTCASE_OUTER_LIMITED_PREEMPTIBLE(RCU_CALLBACK);
+	pr_cont("\n");
+
+	print_testname("in RCU-sched context");
+	DO_CONTEXT_TESTCASE_OUTER_NOT_PREEMPTIBLE(RCU_SCHED);
+	pr_cont("\n");
+
+	print_testname("in RAW_SPINLOCK context");
+	DO_CONTEXT_TESTCASE_OUTER_NOT_PREEMPTIBLE(RAW_SPINLOCK);
+	pr_cont("\n");
+
+	print_testname("in SPINLOCK context");
+	DO_CONTEXT_TESTCASE_OUTER_LIMITED_PREEMPTIBLE(SPINLOCK);
+	pr_cont("\n");
+
+	print_testname("in MUTEX context");
+	DO_CONTEXT_TESTCASE_OUTER_PREEMPTIBLE(MUTEX);
+	pr_cont("\n");
+}
+
 void locking_selftest(void)
 {
 	/*
@@ -2542,6 +2770,10 @@ void locking_selftest(void)
 
 	fs_reclaim_tests();
 
+	/* Wait context test cases that are specific for RAW_LOCK_NESTING */
+	if (IS_ENABLED(CONFIG_PROVE_RAW_LOCK_NESTING))
+		wait_context_tests();
+
 	if (unexpected_testcase_failures) {
 		printk("-----------------------------------------------------------------\n");
 		debug_locks = 0;
