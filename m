Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E56288417
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 09:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbgJIH6o (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 03:58:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56090 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732393AbgJIH6o (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 03:58:44 -0400
Date:   Fri, 09 Oct 2020 07:58:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602230321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EB7LSG9cpjiYheyNbqOWtFUDg4ADNMcAuWNonRSOIUw=;
        b=1ng54W8rDSJ9akJVeTCXQCinUaaTVIZ4JH97s5YeOs1VntoasU0yf68YyJZA4Aq2UX9d0e
        wBSwTCtTjZzw8c4R9WE4UBduT53NZOJ1idatv3tc97fjkmBFgxKa9ydt6ovGFA5qI0n5+V
        Ygv3Y/aR6hPGx6bea8jO3O0q2YlxGBNTgT6RYSl3p+wOULz8//cgNWBkmjXqPvd+fheKXi
        plPuRJTRn3uC1q8CQ8HZtt5VzTG9ClaUb5qgczvBghxCi10vN86KZFsmCK/JtgWeybh3sG
        0w54PceUurw3iWkte0G7EWo1/nlB3IYMrMTMkvyPfXpXyHjNexbA4MIrVnEVFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602230321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EB7LSG9cpjiYheyNbqOWtFUDg4ADNMcAuWNonRSOIUw=;
        b=0rk9PWoqtFOFduvDkLNkcbGiyVE7bYHQ8rVJkmrJ7sCdcrGQnLY2mIlhfeP/jvRsM4WDtV
        a6VwYa/X7hixPlDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Revert "lockdep: Use raw_cpu_*() for
 per-cpu variables"
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201005095958.GJ2651@hirez.programming.kicks-ass.net>
References: <20201005095958.GJ2651@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <160223032064.7002.17084902433756818893.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     baffd723e44dc3d7f84f0b8f1fe1ece00ddd2710
Gitweb:        https://git.kernel.org/tip/baffd723e44dc3d7f84f0b8f1fe1ece00ddd2710
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 05 Oct 2020 09:56:57 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 09 Oct 2020 08:54:00 +02:00

lockdep: Revert "lockdep: Use raw_cpu_*() for per-cpu variables"

The thinking in commit:

  fddf9055a60d ("lockdep: Use raw_cpu_*() for per-cpu variables")

is flawed. While it is true that when we're migratable both CPUs will
have a 0 value, it doesn't hold that when we do get migrated in the
middle of a raw_cpu_op(), the old CPU will still have 0 by the time we
get around to reading it on the new CPU.

Luckily, the reason for that commit (s390 using preempt_disable()
instead of preempt_disable_notrace() in their percpu code), has since
been fixed by commit:

  1196f12a2c96 ("s390: don't trace preemption in percpu macros")

An audit of arch/*/include/asm/percpu*.h shows there are no other
architectures affected by this particular issue.

Fixes: fddf9055a60d ("lockdep: Use raw_cpu_*() for per-cpu variables")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20201005095958.GJ2651@hirez.programming.kicks-ass.net
---
 include/linux/lockdep.h | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index b1227be..1130f27 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -512,19 +512,19 @@ static inline void print_irqtrace_events(struct task_struct *curr)
 #define lock_map_release(l)			lock_release(l, _THIS_IP_)
 
 #ifdef CONFIG_PROVE_LOCKING
-# define might_lock(lock) 						\
+# define might_lock(lock)						\
 do {									\
 	typecheck(struct lockdep_map *, &(lock)->dep_map);		\
 	lock_acquire(&(lock)->dep_map, 0, 0, 0, 1, NULL, _THIS_IP_);	\
 	lock_release(&(lock)->dep_map, _THIS_IP_);			\
 } while (0)
-# define might_lock_read(lock) 						\
+# define might_lock_read(lock)						\
 do {									\
 	typecheck(struct lockdep_map *, &(lock)->dep_map);		\
 	lock_acquire(&(lock)->dep_map, 0, 0, 1, 1, NULL, _THIS_IP_);	\
 	lock_release(&(lock)->dep_map, _THIS_IP_);			\
 } while (0)
-# define might_lock_nested(lock, subclass) 				\
+# define might_lock_nested(lock, subclass)				\
 do {									\
 	typecheck(struct lockdep_map *, &(lock)->dep_map);		\
 	lock_acquire(&(lock)->dep_map, subclass, 0, 1, 1, NULL,		\
@@ -536,29 +536,21 @@ DECLARE_PER_CPU(int, hardirqs_enabled);
 DECLARE_PER_CPU(int, hardirq_context);
 DECLARE_PER_CPU(unsigned int, lockdep_recursion);
 
-/*
- * The below lockdep_assert_*() macros use raw_cpu_read() to access the above
- * per-cpu variables. This is required because this_cpu_read() will potentially
- * call into preempt/irq-disable and that obviously isn't right. This is also
- * correct because when IRQs are enabled, it doesn't matter if we accidentally
- * read the value from our previous CPU.
- */
-
-#define __lockdep_enabled	(debug_locks && !raw_cpu_read(lockdep_recursion))
+#define __lockdep_enabled	(debug_locks && !this_cpu_read(lockdep_recursion))
 
 #define lockdep_assert_irqs_enabled()					\
 do {									\
-	WARN_ON_ONCE(__lockdep_enabled && !raw_cpu_read(hardirqs_enabled)); \
+	WARN_ON_ONCE(__lockdep_enabled && !this_cpu_read(hardirqs_enabled)); \
 } while (0)
 
 #define lockdep_assert_irqs_disabled()					\
 do {									\
-	WARN_ON_ONCE(__lockdep_enabled && raw_cpu_read(hardirqs_enabled)); \
+	WARN_ON_ONCE(__lockdep_enabled && this_cpu_read(hardirqs_enabled)); \
 } while (0)
 
 #define lockdep_assert_in_irq()						\
 do {									\
-	WARN_ON_ONCE(__lockdep_enabled && !raw_cpu_read(hardirq_context)); \
+	WARN_ON_ONCE(__lockdep_enabled && !this_cpu_read(hardirq_context)); \
 } while (0)
 
 #define lockdep_assert_preemption_enabled()				\
@@ -566,7 +558,7 @@ do {									\
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
 		     __lockdep_enabled			&&		\
 		     (preempt_count() != 0		||		\
-		      !raw_cpu_read(hardirqs_enabled)));		\
+		      !this_cpu_read(hardirqs_enabled)));		\
 } while (0)
 
 #define lockdep_assert_preemption_disabled()				\
@@ -574,7 +566,7 @@ do {									\
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
 		     __lockdep_enabled			&&		\
 		     (preempt_count() == 0		&&		\
-		      raw_cpu_read(hardirqs_enabled)));			\
+		      this_cpu_read(hardirqs_enabled)));		\
 } while (0)
 
 #else
