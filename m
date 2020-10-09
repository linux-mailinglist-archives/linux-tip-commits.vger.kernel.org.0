Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438EC28841C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 09:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732467AbgJIH6p (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 03:58:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56102 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732455AbgJIH6o (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 03:58:44 -0400
Date:   Fri, 09 Oct 2020 07:58:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602230322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DoIKUCrUpDO+jYlgCdZV9sbw9sBoXnRKi3ttTUE223E=;
        b=iKawG7B2EsK+eyP46QQylWgmlArmz9ObIO3cFXP4JtGsET3z6vtzxxJ3flQekJmhrI7SGM
        IgPsF0HQk1eO5hnJjjwNovnKa8reEMlTL4UHanRAYnUMXd15HC1x9g6Eyh33N+oLyTAG3K
        ePorbFDk4si5N1SRlhOTsPfJMGRN4wCfWF5/dnNa4BrTBk28K5VjfLiTC/dsbx7bIAi6Wr
        zQz4xN7QxXoWg3QgwHLMDTdyROBKjCXzxCE6BiHNT7wDghEKDjfQc06ryiiifVNRGt9Iyk
        MqvPJfNr/i/nmRyX40NASl7prps7puO1Gnt2/CaKQ7v9yuqjIflAFgapBKa2Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602230322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=DoIKUCrUpDO+jYlgCdZV9sbw9sBoXnRKi3ttTUE223E=;
        b=80w2vA2Pg9jFymsiH5n7/kSxiLiLDzMP8OiW4IU9I0nOEKkVfYH5Fp2nweN3/X7yTIpRNl
        e27NI3ceKjD3wICg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Fix lockdep recursion
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160223032121.7002.1269740091547117869.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     4d004099a668c41522242aa146a38cc4eb59cb1e
Gitweb:        https://git.kernel.org/tip/4d004099a668c41522242aa146a38cc4eb59cb1e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 02 Oct 2020 11:04:21 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 09 Oct 2020 08:53:30 +02:00

lockdep: Fix lockdep recursion

Steve reported that lockdep_assert*irq*(), when nested inside lockdep
itself, will trigger a false-positive.

One example is the stack-trace code, as called from inside lockdep,
triggering tracing, which in turn calls RCU, which then uses
lockdep_assert_irqs_disabled().

Fixes: a21ee6055c30 ("lockdep: Change hardirq{s_enabled,_context} to per-cpu variables")
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/lockdep.h  |  13 +++--
 kernel/locking/lockdep.c |  99 ++++++++++++++++++++++----------------
 2 files changed, 67 insertions(+), 45 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 6a584b3..b1227be 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -534,6 +534,7 @@ do {									\
 
 DECLARE_PER_CPU(int, hardirqs_enabled);
 DECLARE_PER_CPU(int, hardirq_context);
+DECLARE_PER_CPU(unsigned int, lockdep_recursion);
 
 /*
  * The below lockdep_assert_*() macros use raw_cpu_read() to access the above
@@ -543,25 +544,27 @@ DECLARE_PER_CPU(int, hardirq_context);
  * read the value from our previous CPU.
  */
 
+#define __lockdep_enabled	(debug_locks && !raw_cpu_read(lockdep_recursion))
+
 #define lockdep_assert_irqs_enabled()					\
 do {									\
-	WARN_ON_ONCE(debug_locks && !raw_cpu_read(hardirqs_enabled));	\
+	WARN_ON_ONCE(__lockdep_enabled && !raw_cpu_read(hardirqs_enabled)); \
 } while (0)
 
 #define lockdep_assert_irqs_disabled()					\
 do {									\
-	WARN_ON_ONCE(debug_locks && raw_cpu_read(hardirqs_enabled));	\
+	WARN_ON_ONCE(__lockdep_enabled && raw_cpu_read(hardirqs_enabled)); \
 } while (0)
 
 #define lockdep_assert_in_irq()						\
 do {									\
-	WARN_ON_ONCE(debug_locks && !raw_cpu_read(hardirq_context));	\
+	WARN_ON_ONCE(__lockdep_enabled && !raw_cpu_read(hardirq_context)); \
 } while (0)
 
 #define lockdep_assert_preemption_enabled()				\
 do {									\
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
-		     debug_locks			&&		\
+		     __lockdep_enabled			&&		\
 		     (preempt_count() != 0		||		\
 		      !raw_cpu_read(hardirqs_enabled)));		\
 } while (0)
@@ -569,7 +572,7 @@ do {									\
 #define lockdep_assert_preemption_disabled()				\
 do {									\
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
-		     debug_locks			&&		\
+		     __lockdep_enabled			&&		\
 		     (preempt_count() == 0		&&		\
 		      raw_cpu_read(hardirqs_enabled)));			\
 } while (0)
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index a430fbb..85d15f0 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -76,6 +76,23 @@ module_param(lock_stat, int, 0644);
 #define lock_stat 0
 #endif
 
+DEFINE_PER_CPU(unsigned int, lockdep_recursion);
+EXPORT_PER_CPU_SYMBOL_GPL(lockdep_recursion);
+
+static inline bool lockdep_enabled(void)
+{
+	if (!debug_locks)
+		return false;
+
+	if (raw_cpu_read(lockdep_recursion))
+		return false;
+
+	if (current->lockdep_recursion)
+		return false;
+
+	return true;
+}
+
 /*
  * lockdep_lock: protects the lockdep graph, the hashes and the
  *               class/list/hash allocators.
@@ -93,7 +110,7 @@ static inline void lockdep_lock(void)
 
 	arch_spin_lock(&__lock);
 	__owner = current;
-	current->lockdep_recursion++;
+	__this_cpu_inc(lockdep_recursion);
 }
 
 static inline void lockdep_unlock(void)
@@ -101,7 +118,7 @@ static inline void lockdep_unlock(void)
 	if (debug_locks && DEBUG_LOCKS_WARN_ON(__owner != current))
 		return;
 
-	current->lockdep_recursion--;
+	__this_cpu_dec(lockdep_recursion);
 	__owner = NULL;
 	arch_spin_unlock(&__lock);
 }
@@ -393,10 +410,15 @@ void lockdep_init_task(struct task_struct *task)
 	task->lockdep_recursion = 0;
 }
 
+static __always_inline void lockdep_recursion_inc(void)
+{
+	__this_cpu_inc(lockdep_recursion);
+}
+
 static __always_inline void lockdep_recursion_finish(void)
 {
-	if (WARN_ON_ONCE((--current->lockdep_recursion) & LOCKDEP_RECURSION_MASK))
-		current->lockdep_recursion = 0;
+	if (WARN_ON_ONCE(__this_cpu_dec_return(lockdep_recursion)))
+		__this_cpu_write(lockdep_recursion, 0);
 }
 
 void lockdep_set_selftest_task(struct task_struct *task)
@@ -3659,7 +3681,7 @@ void lockdep_hardirqs_on_prepare(unsigned long ip)
 	if (unlikely(in_nmi()))
 		return;
 
-	if (unlikely(current->lockdep_recursion & LOCKDEP_RECURSION_MASK))
+	if (unlikely(__this_cpu_read(lockdep_recursion)))
 		return;
 
 	if (unlikely(lockdep_hardirqs_enabled())) {
@@ -3695,7 +3717,7 @@ void lockdep_hardirqs_on_prepare(unsigned long ip)
 
 	current->hardirq_chain_key = current->curr_chain_key;
 
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	__trace_hardirqs_on_caller();
 	lockdep_recursion_finish();
 }
@@ -3728,7 +3750,7 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
 		goto skip_checks;
 	}
 
-	if (unlikely(current->lockdep_recursion & LOCKDEP_RECURSION_MASK))
+	if (unlikely(__this_cpu_read(lockdep_recursion)))
 		return;
 
 	if (lockdep_hardirqs_enabled()) {
@@ -3781,7 +3803,7 @@ void noinstr lockdep_hardirqs_off(unsigned long ip)
 	if (in_nmi()) {
 		if (!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_NMI))
 			return;
-	} else if (current->lockdep_recursion & LOCKDEP_RECURSION_MASK)
+	} else if (__this_cpu_read(lockdep_recursion))
 		return;
 
 	/*
@@ -3814,7 +3836,7 @@ void lockdep_softirqs_on(unsigned long ip)
 {
 	struct irqtrace_events *trace = &current->irqtrace;
 
-	if (unlikely(!debug_locks || current->lockdep_recursion))
+	if (unlikely(!lockdep_enabled()))
 		return;
 
 	/*
@@ -3829,7 +3851,7 @@ void lockdep_softirqs_on(unsigned long ip)
 		return;
 	}
 
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	/*
 	 * We'll do an OFF -> ON transition:
 	 */
@@ -3852,7 +3874,7 @@ void lockdep_softirqs_on(unsigned long ip)
  */
 void lockdep_softirqs_off(unsigned long ip)
 {
-	if (unlikely(!debug_locks || current->lockdep_recursion))
+	if (unlikely(!lockdep_enabled()))
 		return;
 
 	/*
@@ -4233,11 +4255,11 @@ void lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
 	if (subclass) {
 		unsigned long flags;
 
-		if (DEBUG_LOCKS_WARN_ON(current->lockdep_recursion))
+		if (DEBUG_LOCKS_WARN_ON(!lockdep_enabled()))
 			return;
 
 		raw_local_irq_save(flags);
-		current->lockdep_recursion++;
+		lockdep_recursion_inc();
 		register_lock_class(lock, subclass, 1);
 		lockdep_recursion_finish();
 		raw_local_irq_restore(flags);
@@ -4920,11 +4942,11 @@ void lock_set_class(struct lockdep_map *lock, const char *name,
 {
 	unsigned long flags;
 
-	if (unlikely(current->lockdep_recursion))
+	if (unlikely(!lockdep_enabled()))
 		return;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	check_flags(flags);
 	if (__lock_set_class(lock, name, key, subclass, ip))
 		check_chain_key(current);
@@ -4937,11 +4959,11 @@ void lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 {
 	unsigned long flags;
 
-	if (unlikely(current->lockdep_recursion))
+	if (unlikely(!lockdep_enabled()))
 		return;
 
 	raw_local_irq_save(flags);
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	check_flags(flags);
 	if (__lock_downgrade(lock, ip))
 		check_chain_key(current);
@@ -4979,7 +5001,7 @@ static void verify_lock_unused(struct lockdep_map *lock, struct held_lock *hlock
 
 static bool lockdep_nmi(void)
 {
-	if (current->lockdep_recursion & LOCKDEP_RECURSION_MASK)
+	if (raw_cpu_read(lockdep_recursion))
 		return false;
 
 	if (!in_nmi())
@@ -5000,7 +5022,10 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 
 	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
 
-	if (unlikely(current->lockdep_recursion)) {
+	if (!debug_locks)
+		return;
+
+	if (unlikely(!lockdep_enabled())) {
 		/* XXX allow trylock from NMI ?!? */
 		if (lockdep_nmi() && !trylock) {
 			struct held_lock hlock;
@@ -5023,7 +5048,7 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	__lock_acquire(lock, subclass, trylock, read, check,
 		       irqs_disabled_flags(flags), nest_lock, ip, 0, 0);
 	lockdep_recursion_finish();
@@ -5037,13 +5062,13 @@ void lock_release(struct lockdep_map *lock, unsigned long ip)
 
 	trace_lock_release(lock, ip);
 
-	if (unlikely(current->lockdep_recursion))
+	if (unlikely(!lockdep_enabled()))
 		return;
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	if (__lock_release(lock, ip))
 		check_chain_key(current);
 	lockdep_recursion_finish();
@@ -5056,13 +5081,13 @@ noinstr int lock_is_held_type(const struct lockdep_map *lock, int read)
 	unsigned long flags;
 	int ret = 0;
 
-	if (unlikely(current->lockdep_recursion))
+	if (unlikely(!lockdep_enabled()))
 		return 1; /* avoid false negative lockdep_assert_held() */
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	ret = __lock_is_held(lock, read);
 	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
@@ -5077,13 +5102,13 @@ struct pin_cookie lock_pin_lock(struct lockdep_map *lock)
 	struct pin_cookie cookie = NIL_COOKIE;
 	unsigned long flags;
 
-	if (unlikely(current->lockdep_recursion))
+	if (unlikely(!lockdep_enabled()))
 		return cookie;
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	cookie = __lock_pin_lock(lock);
 	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
@@ -5096,13 +5121,13 @@ void lock_repin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
 {
 	unsigned long flags;
 
-	if (unlikely(current->lockdep_recursion))
+	if (unlikely(!lockdep_enabled()))
 		return;
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	__lock_repin_lock(lock, cookie);
 	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
@@ -5113,13 +5138,13 @@ void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
 {
 	unsigned long flags;
 
-	if (unlikely(current->lockdep_recursion))
+	if (unlikely(!lockdep_enabled()))
 		return;
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	__lock_unpin_lock(lock, cookie);
 	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
@@ -5249,15 +5274,12 @@ void lock_contended(struct lockdep_map *lock, unsigned long ip)
 
 	trace_lock_acquired(lock, ip);
 
-	if (unlikely(!lock_stat || !debug_locks))
-		return;
-
-	if (unlikely(current->lockdep_recursion))
+	if (unlikely(!lock_stat || !lockdep_enabled()))
 		return;
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	__lock_contended(lock, ip);
 	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
@@ -5270,15 +5292,12 @@ void lock_acquired(struct lockdep_map *lock, unsigned long ip)
 
 	trace_lock_contended(lock, ip);
 
-	if (unlikely(!lock_stat || !debug_locks))
-		return;
-
-	if (unlikely(current->lockdep_recursion))
+	if (unlikely(!lock_stat || !lockdep_enabled()))
 		return;
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	__lock_acquired(lock, ip);
 	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
