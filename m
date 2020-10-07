Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9AA286396
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 18:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgJGQUQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 12:20:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44608 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgJGQUP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 12:20:15 -0400
Date:   Wed, 07 Oct 2020 16:20:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602087613;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/RHVmnusjfPTucOkLKDJTNDjSqJqoVCacxyHnDFNa2U=;
        b=oDHPTwnaKI1QDa1vTQj+OHXvrHJ0o70oZN+RjnGbhGT3zIuTmCRH4r+WlOOQqaLjjApXxz
        mwLLoJMt8sIfIMO3nt/KFM0JIawC4mVofc2E2e6U6R1JyUGbPwbTn2KXZKCHLDYwnA7S1E
        7cHkTmb/JE0rYkwCHOpicP5PjZJlqlwARFbwVv4QWFUxDnWwVzSBPWvcxMmSgCQKoO/uNR
        ggiJuN0M89A41LpjtJKW+DuMuC+Xyyudib8/N8BHg7BKa/Xfz0eDc9eqDQwc+/h3chzUaW
        1QT79CT0NCc4t+wRrKTZdBwvm9Y4/tv1+I3h3EoWngjShH+6PSN/oBx0+sCSRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602087613;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/RHVmnusjfPTucOkLKDJTNDjSqJqoVCacxyHnDFNa2U=;
        b=H/m0CehF5LrxUUpWeFVL/tuOBpJxL3n381b4KwBJKKVlnXY/63LOTK7+K+n3MEY9PohjRW
        jB50k9cu8jQyiOAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Revert "lockdep: Use raw_cpu_*() for
 per-cpu variables"
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201005095958.GJ2651@hirez.programming.kicks-ass.net>
References: <20201005095958.GJ2651@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <160208761223.7002.12830126769485268107.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     820d8a6c966343059ba58b9a82f570f27bf147d6
Gitweb:        https://git.kernel.org/tip/820d8a6c966343059ba58b9a82f570f27bf147d6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 05 Oct 2020 09:56:57 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Oct 2020 18:14:17 +02:00

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
Link: https://lkml.kernel.org/r/20201005095958.GJ2651@hirez.programming.kicks-ass.net
---
 include/linux/lockdep.h | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 1cc9825..f559487 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -537,19 +537,19 @@ do {									\
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
@@ -561,29 +561,21 @@ DECLARE_PER_CPU(int, hardirqs_enabled);
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
@@ -591,7 +583,7 @@ do {									\
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
 		     __lockdep_enabled			&&		\
 		     (preempt_count() != 0		||		\
-		      !raw_cpu_read(hardirqs_enabled)));		\
+		      !this_cpu_read(hardirqs_enabled)));		\
 } while (0)
 
 #define lockdep_assert_preemption_disabled()				\
@@ -599,7 +591,7 @@ do {									\
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
 		     __lockdep_enabled			&&		\
 		     (preempt_count() == 0		&&		\
-		      raw_cpu_read(hardirqs_enabled)));			\
+		      this_cpu_read(hardirqs_enabled)));		\
 } while (0)
 
 #else
