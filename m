Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2B2286388
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 18:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgJGQUP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 12:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgJGQUP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 12:20:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E8AC061755;
        Wed,  7 Oct 2020 09:20:15 -0700 (PDT)
Date:   Wed, 07 Oct 2020 16:20:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602087613;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=B09JwK9mTJ9X8tQMjVlk2RVJ1/ntdU5NA0vxthAPYW0=;
        b=nPEwxJiQEVBO0CEHYrFNkdSxcp5gcoZKLXF+z4rwgQRAmk0ExbW52TPUC/j98lDR88Mlj2
        O74YWqPcqKcRhTwmzpc1f6m0EH/Ajx2bgiFoqq/Meu6fZeTuWuRmfs2tL+nkUgdDCgVQR8
        5UlpoplmB9MRm7/6yYQItjVcnf/fH527AVonFU047CbsNy9CfHFYw5HfD9zX8M9EqXMhu5
        oHz3Y96BtzrZzNc7UYVDBs2vOpmrE6lNF9oLH6cPtt5JkbggqQVQMp9qmuAVdac5jUiQKn
        /dsNv0DCM65IGABGJeHGBu58LE2HK5JrNjyOPG7G07svu1EHT2abNKXU+Wk53w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602087613;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=B09JwK9mTJ9X8tQMjVlk2RVJ1/ntdU5NA0vxthAPYW0=;
        b=W7Jl1KcJuqRwymOZDWBUnXvkxZsDLkhMFyOS6hofiFjJMhiIQDHJiWS409OW3Ch2YUJhta
        Mg38RK3hXXHoKDAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Fix lockdep recursion
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160208761283.7002.5570800497768691029.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a046a86082cc3db21e98188a3ddda4e36288f5bf
Gitweb:        https://git.kernel.org/tip/a046a86082cc3db21e98188a3ddda4e36288f5bf
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 02 Oct 2020 11:04:21 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Oct 2020 18:14:17 +02:00

lockdep: Fix lockdep recursion

Steve reported that lockdep_assert*irq*(), when nested inside lockdep
itself, will trigger a false-positive.

One example is the stack-trace code, as called from inside lockdep,
triggering tracing, which in turn calls RCU, which then uses
lockdep_assert_irqs_disabled().

Fixes: a21ee6055c30 ("lockdep: Change hardirq{s_enabled,_context} to per-cpu variables")
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/lockdep.h  |  13 +++--
 kernel/locking/lockdep.c |  99 ++++++++++++++++++++++----------------
 2 files changed, 67 insertions(+), 45 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 57d642d..1cc9825 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -559,6 +559,7 @@ do {									\
 
 DECLARE_PER_CPU(int, hardirqs_enabled);
 DECLARE_PER_CPU(int, hardirq_context);
+DECLARE_PER_CPU(unsigned int, lockdep_recursion);
 
 /*
  * The below lockdep_assert_*() macros use raw_cpu_read() to access the above
@@ -568,25 +569,27 @@ DECLARE_PER_CPU(int, hardirq_context);
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
@@ -594,7 +597,7 @@ do {									\
 #define lockdep_assert_preemption_disabled()				\
 do {									\
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
-		     debug_locks			&&		\
+		     __lockdep_enabled			&&		\
 		     (preempt_count() == 0		&&		\
 		      raw_cpu_read(hardirqs_enabled)));			\
 } while (0)
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index b3b3161..3e99dfe 100644
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
@@ -408,10 +425,15 @@ void lockdep_init_task(struct task_struct *task)
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
@@ -4035,7 +4057,7 @@ void lockdep_hardirqs_on_prepare(unsigned long ip)
 	if (unlikely(in_nmi()))
 		return;
 
-	if (unlikely(current->lockdep_recursion & LOCKDEP_RECURSION_MASK))
+	if (unlikely(__this_cpu_read(lockdep_recursion)))
 		return;
 
 	if (unlikely(lockdep_hardirqs_enabled())) {
@@ -4071,7 +4093,7 @@ void lockdep_hardirqs_on_prepare(unsigned long ip)
 
 	current->hardirq_chain_key = current->curr_chain_key;
 
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	__trace_hardirqs_on_caller();
 	lockdep_recursion_finish();
 }
@@ -4104,7 +4126,7 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
 		goto skip_checks;
 	}
 
-	if (unlikely(current->lockdep_recursion & LOCKDEP_RECURSION_MASK))
+	if (unlikely(__this_cpu_read(lockdep_recursion)))
 		return;
 
 	if (lockdep_hardirqs_enabled()) {
@@ -4157,7 +4179,7 @@ void noinstr lockdep_hardirqs_off(unsigned long ip)
 	if (in_nmi()) {
 		if (!IS_ENABLED(CONFIG_TRACE_IRQFLAGS_NMI))
 			return;
-	} else if (current->lockdep_recursion & LOCKDEP_RECURSION_MASK)
+	} else if (__this_cpu_read(lockdep_recursion))
 		return;
 
 	/*
@@ -4190,7 +4212,7 @@ void lockdep_softirqs_on(unsigned long ip)
 {
 	struct irqtrace_events *trace = &current->irqtrace;
 
-	if (unlikely(!debug_locks || current->lockdep_recursion))
+	if (unlikely(!lockdep_enabled()))
 		return;
 
 	/*
@@ -4205,7 +4227,7 @@ void lockdep_softirqs_on(unsigned long ip)
 		return;
 	}
 
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	/*
 	 * We'll do an OFF -> ON transition:
 	 */
@@ -4228,7 +4250,7 @@ void lockdep_softirqs_on(unsigned long ip)
  */
 void lockdep_softirqs_off(unsigned long ip)
 {
-	if (unlikely(!debug_locks || current->lockdep_recursion))
+	if (unlikely(!lockdep_enabled()))
 		return;
 
 	/*
@@ -4609,11 +4631,11 @@ void lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
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
@@ -5296,11 +5318,11 @@ void lock_set_class(struct lockdep_map *lock, const char *name,
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
@@ -5313,11 +5335,11 @@ void lock_downgrade(struct lockdep_map *lock, unsigned long ip)
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
@@ -5355,7 +5377,7 @@ static void verify_lock_unused(struct lockdep_map *lock, struct held_lock *hlock
 
 static bool lockdep_nmi(void)
 {
-	if (current->lockdep_recursion & LOCKDEP_RECURSION_MASK)
+	if (raw_cpu_read(lockdep_recursion))
 		return false;
 
 	if (!in_nmi())
@@ -5390,7 +5412,10 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 
 	trace_lock_acquire(lock, subclass, trylock, read, check, nest_lock, ip);
 
-	if (unlikely(current->lockdep_recursion)) {
+	if (!debug_locks)
+		return;
+
+	if (unlikely(!lockdep_enabled())) {
 		/* XXX allow trylock from NMI ?!? */
 		if (lockdep_nmi() && !trylock) {
 			struct held_lock hlock;
@@ -5413,7 +5438,7 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	raw_local_irq_save(flags);
 	check_flags(flags);
 
-	current->lockdep_recursion++;
+	lockdep_recursion_inc();
 	__lock_acquire(lock, subclass, trylock, read, check,
 		       irqs_disabled_flags(flags), nest_lock, ip, 0, 0);
 	lockdep_recursion_finish();
@@ -5427,13 +5452,13 @@ void lock_release(struct lockdep_map *lock, unsigned long ip)
 
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
@@ -5446,13 +5471,13 @@ noinstr int lock_is_held_type(const struct lockdep_map *lock, int read)
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
@@ -5467,13 +5492,13 @@ struct pin_cookie lock_pin_lock(struct lockdep_map *lock)
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
@@ -5486,13 +5511,13 @@ void lock_repin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
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
@@ -5503,13 +5528,13 @@ void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
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
@@ -5639,15 +5664,12 @@ void lock_contended(struct lockdep_map *lock, unsigned long ip)
 
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
@@ -5660,15 +5682,12 @@ void lock_acquired(struct lockdep_map *lock, unsigned long ip)
 
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
