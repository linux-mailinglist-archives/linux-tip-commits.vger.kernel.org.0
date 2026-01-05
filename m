Return-Path: <linux-tip-commits+bounces-7803-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2446BCF4932
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8817F300A3C8
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 16:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E26346E51;
	Mon,  5 Jan 2026 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fV855pT4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sBxY6vsf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85187346ADA;
	Mon,  5 Jan 2026 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628474; cv=none; b=I4g7Oqbx+Ak+10WrHHixN5MdfmCaJ6m2A9P1vTJSYxlXCeR8/XaSEiHHED8BU5BEeIrwsMiIafMmcG4+D/kIYL2aHIAs05R/DgslhBTWPmuGeByR+yMs1m/YQ/KIM8cuaG9bVtX21/DzxwzOchwPQ8H7K4ogJIMOmIXG1fK37so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628474; c=relaxed/simple;
	bh=dO2H50H5dm67kZLB0Z7LtvWferzj77+QGtny1q9MJZI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J+mVLkgVmAozCC3ofJlmMzsKz6KShzZxjZKtxTNUdqGUxgOqXk0cNokRY/wUzkjC/lXrCfg/LGdEMQYhqR2YnkYmhs1JGCWZXn1PbzWc08GknknFqVb3Xti7dvRn/g+dKuRLnruyCs+fuqceMeDGnZPVmAYgaMegkTVmMTYke1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fV855pT4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sBxY6vsf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628469;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDwxCo8UMYl8d3DVgSuaTa8XP3UdiAYFpiJXw8PXjVw=;
	b=fV855pT4EozzLl6xG8+UPKyK3Cajq0TNl3+3n+5OTSaL/aC4F02vMLepkCRJ5kLQU6e0s9
	kyAqeP9KyQkzkkfGXvHjiFRbAT7KJqpMTYUfnIl/0+EdFLnoOdO/JPPZ8JWxSyKhIUVG36
	dQTLVaEOczmIkS3uf+REEQ0yYoy4a/5a2vham798gFkozoOlgdSxatCGAU8CzjqAi5oh89
	kWAuWS8JX8DuI9vlFj79MFDqlglBVlyUppbe8yU65ghBW92kozDIRuXY1uqdjxK36+9t0j
	zjreiP1HBFDclnUE/mw3PKS0KTclj7VWx1IUDj9AdxKMR1KYLCVgPvH5c/SgKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628469;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDwxCo8UMYl8d3DVgSuaTa8XP3UdiAYFpiJXw8PXjVw=;
	b=sBxY6vsfyz1RyGXxUH1y9IW+N4ej89QHLqQ4igXNAAQj5YuPvvtQDyQ4zxukZfW0Z/WWo8
	Eme0nh/YKd9r6LDQ==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] locking/local_lock: Support Clang's context analysis
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-20-elver@google.com>
References: <20251219154418.3592607-20-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762846826.510.12178742068712805125.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d3febf16dee28a74b01ba43195ee4965edb6208f
Gitweb:        https://git.kernel.org/tip/d3febf16dee28a74b01ba43195ee4965edb=
6208f
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:40:08 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:31 +01:00

locking/local_lock: Support Clang's context analysis

Add support for Clang's context analysis for local_lock_t and
local_trylock_t.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251219154418.3592607-20-elver@google.com
---
 Documentation/dev-tools/context-analysis.rst |  2 +-
 include/linux/local_lock.h                   | 51 +++++++------
 include/linux/local_lock_internal.h          | 71 ++++++++++++++----
 lib/test_context-analysis.c                  | 73 +++++++++++++++++++-
 4 files changed, 161 insertions(+), 36 deletions(-)

diff --git a/Documentation/dev-tools/context-analysis.rst b/Documentation/dev=
-tools/context-analysis.rst
index 7b660c3..a48b75f 100644
--- a/Documentation/dev-tools/context-analysis.rst
+++ b/Documentation/dev-tools/context-analysis.rst
@@ -80,7 +80,7 @@ Supported Kernel Primitives
=20
 Currently the following synchronization primitives are supported:
 `raw_spinlock_t`, `spinlock_t`, `rwlock_t`, `mutex`, `seqlock_t`,
-`bit_spinlock`, RCU, SRCU (`srcu_struct`), `rw_semaphore`.
+`bit_spinlock`, RCU, SRCU (`srcu_struct`), `rw_semaphore`, `local_lock_t`.
=20
 For context locks with an initialization function (e.g., `spin_lock_init()`),
 calling this function before initializing any guarded members or globals
diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index b0e6ab3..99c06e4 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -14,13 +14,13 @@
  * local_lock - Acquire a per CPU local lock
  * @lock:	The lock variable
  */
-#define local_lock(lock)		__local_lock(this_cpu_ptr(lock))
+#define local_lock(lock)		__local_lock(__this_cpu_local_lock(lock))
=20
 /**
  * local_lock_irq - Acquire a per CPU local lock and disable interrupts
  * @lock:	The lock variable
  */
-#define local_lock_irq(lock)		__local_lock_irq(this_cpu_ptr(lock))
+#define local_lock_irq(lock)		__local_lock_irq(__this_cpu_local_lock(lock))
=20
 /**
  * local_lock_irqsave - Acquire a per CPU local lock, save and disable
@@ -29,19 +29,19 @@
  * @flags:	Storage for interrupt flags
  */
 #define local_lock_irqsave(lock, flags)				\
-	__local_lock_irqsave(this_cpu_ptr(lock), flags)
+	__local_lock_irqsave(__this_cpu_local_lock(lock), flags)
=20
 /**
  * local_unlock - Release a per CPU local lock
  * @lock:	The lock variable
  */
-#define local_unlock(lock)		__local_unlock(this_cpu_ptr(lock))
+#define local_unlock(lock)		__local_unlock(__this_cpu_local_lock(lock))
=20
 /**
  * local_unlock_irq - Release a per CPU local lock and enable interrupts
  * @lock:	The lock variable
  */
-#define local_unlock_irq(lock)		__local_unlock_irq(this_cpu_ptr(lock))
+#define local_unlock_irq(lock)		__local_unlock_irq(__this_cpu_local_lock(loc=
k))
=20
 /**
  * local_unlock_irqrestore - Release a per CPU local lock and restore
@@ -50,7 +50,7 @@
  * @flags:      Interrupt flags to restore
  */
 #define local_unlock_irqrestore(lock, flags)			\
-	__local_unlock_irqrestore(this_cpu_ptr(lock), flags)
+	__local_unlock_irqrestore(__this_cpu_local_lock(lock), flags)
=20
 /**
  * local_trylock_init - Runtime initialize a lock instance
@@ -66,7 +66,7 @@
  * locking constrains it will _always_ fail to acquire the lock in NMI or
  * HARDIRQ context on PREEMPT_RT.
  */
-#define local_trylock(lock)		__local_trylock(this_cpu_ptr(lock))
+#define local_trylock(lock)		__local_trylock(__this_cpu_local_lock(lock))
=20
 #define local_lock_is_locked(lock)	__local_lock_is_locked(lock)
=20
@@ -81,27 +81,36 @@
  * HARDIRQ context on PREEMPT_RT.
  */
 #define local_trylock_irqsave(lock, flags)			\
-	__local_trylock_irqsave(this_cpu_ptr(lock), flags)
-
-DEFINE_GUARD(local_lock, local_lock_t __percpu*,
-	     local_lock(_T),
-	     local_unlock(_T))
-DEFINE_GUARD(local_lock_irq, local_lock_t __percpu*,
-	     local_lock_irq(_T),
-	     local_unlock_irq(_T))
+	__local_trylock_irqsave(__this_cpu_local_lock(lock), flags)
+
+DEFINE_LOCK_GUARD_1(local_lock, local_lock_t __percpu,
+		    local_lock(_T->lock),
+		    local_unlock(_T->lock))
+DEFINE_LOCK_GUARD_1(local_lock_irq, local_lock_t __percpu,
+		    local_lock_irq(_T->lock),
+		    local_unlock_irq(_T->lock))
 DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_lock_t __percpu,
 		    local_lock_irqsave(_T->lock, _T->flags),
 		    local_unlock_irqrestore(_T->lock, _T->flags),
 		    unsigned long flags)
=20
 #define local_lock_nested_bh(_lock)				\
-	__local_lock_nested_bh(this_cpu_ptr(_lock))
+	__local_lock_nested_bh(__this_cpu_local_lock(_lock))
=20
 #define local_unlock_nested_bh(_lock)				\
-	__local_unlock_nested_bh(this_cpu_ptr(_lock))
-
-DEFINE_GUARD(local_lock_nested_bh, local_lock_t __percpu*,
-	     local_lock_nested_bh(_T),
-	     local_unlock_nested_bh(_T))
+	__local_unlock_nested_bh(__this_cpu_local_lock(_lock))
+
+DEFINE_LOCK_GUARD_1(local_lock_nested_bh, local_lock_t __percpu,
+		    local_lock_nested_bh(_T->lock),
+		    local_unlock_nested_bh(_T->lock))
+
+DECLARE_LOCK_GUARD_1_ATTRS(local_lock, __acquires(_T), __releases(*(local_lo=
ck_t __percpu **)_T))
+#define class_local_lock_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(local_lock,=
 _T)
+DECLARE_LOCK_GUARD_1_ATTRS(local_lock_irq, __acquires(_T), __releases(*(loca=
l_lock_t __percpu **)_T))
+#define class_local_lock_irq_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(local_l=
ock_irq, _T)
+DECLARE_LOCK_GUARD_1_ATTRS(local_lock_irqsave, __acquires(_T), __releases(*(=
local_lock_t __percpu **)_T))
+#define class_local_lock_irqsave_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(loc=
al_lock_irqsave, _T)
+DECLARE_LOCK_GUARD_1_ATTRS(local_lock_nested_bh, __acquires(_T), __releases(=
*(local_lock_t __percpu **)_T))
+#define class_local_lock_nested_bh_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(l=
ocal_lock_nested_bh, _T)
=20
 #endif
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_i=
nternal.h
index 1a1ea12..e8c4803 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -10,21 +10,23 @@
=20
 #ifndef CONFIG_PREEMPT_RT
=20
-typedef struct {
+context_lock_struct(local_lock) {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 	struct task_struct	*owner;
 #endif
-} local_lock_t;
+};
+typedef struct local_lock local_lock_t;
=20
 /* local_trylock() and local_trylock_irqsave() only work with local_trylock_=
t */
-typedef struct {
+context_lock_struct(local_trylock) {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 	struct task_struct	*owner;
 #endif
 	u8		acquired;
-} local_trylock_t;
+};
+typedef struct local_trylock local_trylock_t;
=20
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define LOCAL_LOCK_DEBUG_INIT(lockname)		\
@@ -84,9 +86,14 @@ do {								\
 			      0, LD_WAIT_CONFIG, LD_WAIT_INV,	\
 			      LD_LOCK_PERCPU);			\
 	local_lock_debug_init(lock);				\
+	__assume_ctx_lock(lock);				\
 } while (0)
=20
-#define __local_trylock_init(lock) __local_lock_init((local_lock_t *)lock)
+#define __local_trylock_init(lock)				\
+do {								\
+	__local_lock_init((local_lock_t *)lock);		\
+	__assume_ctx_lock(lock);				\
+} while (0)
=20
 #define __spinlock_nested_bh_init(lock)				\
 do {								\
@@ -97,6 +104,7 @@ do {								\
 			      0, LD_WAIT_CONFIG, LD_WAIT_INV,	\
 			      LD_LOCK_NORMAL);			\
 	local_lock_debug_init(lock);				\
+	__assume_ctx_lock(lock);				\
 } while (0)
=20
 #define __local_lock_acquire(lock)					\
@@ -119,22 +127,25 @@ do {								\
 	do {							\
 		preempt_disable();				\
 		__local_lock_acquire(lock);			\
+		__acquire(lock);				\
 	} while (0)
=20
 #define __local_lock_irq(lock)					\
 	do {							\
 		local_irq_disable();				\
 		__local_lock_acquire(lock);			\
+		__acquire(lock);				\
 	} while (0)
=20
 #define __local_lock_irqsave(lock, flags)			\
 	do {							\
 		local_irq_save(flags);				\
 		__local_lock_acquire(lock);			\
+		__acquire(lock);				\
 	} while (0)
=20
 #define __local_trylock(lock)					\
-	({							\
+	__try_acquire_ctx_lock(lock, ({				\
 		local_trylock_t *__tl;				\
 								\
 		preempt_disable();				\
@@ -148,10 +159,10 @@ do {								\
 				(local_lock_t *)__tl);		\
 		}						\
 		!!__tl;						\
-	})
+	}))
=20
 #define __local_trylock_irqsave(lock, flags)			\
-	({							\
+	__try_acquire_ctx_lock(lock, ({				\
 		local_trylock_t *__tl;				\
 								\
 		local_irq_save(flags);				\
@@ -165,7 +176,7 @@ do {								\
 				(local_lock_t *)__tl);		\
 		}						\
 		!!__tl;						\
-	})
+	}))
=20
 /* preemption or migration must be disabled before calling __local_lock_is_l=
ocked */
 #define __local_lock_is_locked(lock) READ_ONCE(this_cpu_ptr(lock)->acquired)
@@ -188,18 +199,21 @@ do {								\
=20
 #define __local_unlock(lock)					\
 	do {							\
+		__release(lock);				\
 		__local_lock_release(lock);			\
 		preempt_enable();				\
 	} while (0)
=20
 #define __local_unlock_irq(lock)				\
 	do {							\
+		__release(lock);				\
 		__local_lock_release(lock);			\
 		local_irq_enable();				\
 	} while (0)
=20
 #define __local_unlock_irqrestore(lock, flags)			\
 	do {							\
+		__release(lock);				\
 		__local_lock_release(lock);			\
 		local_irq_restore(flags);			\
 	} while (0)
@@ -208,13 +222,19 @@ do {								\
 	do {							\
 		lockdep_assert_in_softirq();			\
 		local_lock_acquire((lock));			\
+		__acquire(lock);				\
 	} while (0)
=20
 #define __local_unlock_nested_bh(lock)				\
-	local_lock_release((lock))
+	do {							\
+		__release(lock);				\
+		local_lock_release((lock));			\
+	} while (0)
=20
 #else /* !CONFIG_PREEMPT_RT */
=20
+#include <linux/spinlock.h>
+
 /*
  * On PREEMPT_RT local_lock maps to a per CPU spinlock, which protects the
  * critical section while staying preemptible.
@@ -269,7 +289,7 @@ do {								\
 } while (0)
=20
 #define __local_trylock(lock)					\
-	({							\
+	__try_acquire_ctx_lock(lock, context_unsafe(({		\
 		int __locked;					\
 								\
 		if (in_nmi() | in_hardirq()) {			\
@@ -281,17 +301,40 @@ do {								\
 				migrate_enable();		\
 		}						\
 		__locked;					\
-	})
+	})))
=20
 #define __local_trylock_irqsave(lock, flags)			\
-	({							\
+	__try_acquire_ctx_lock(lock, ({				\
 		typecheck(unsigned long, flags);		\
 		flags =3D 0;					\
 		__local_trylock(lock);				\
-	})
+	}))
=20
 /* migration must be disabled before calling __local_lock_is_locked */
 #define __local_lock_is_locked(__lock)					\
 	(rt_mutex_owner(&this_cpu_ptr(__lock)->lock) =3D=3D current)
=20
 #endif /* CONFIG_PREEMPT_RT */
+
+#if defined(WARN_CONTEXT_ANALYSIS)
+/*
+ * Because the compiler only knows about the base per-CPU variable, use this
+ * helper function to make the compiler think we lock/unlock the @base varia=
ble,
+ * and hide the fact we actually pass the per-CPU instance to lock/unlock
+ * functions.
+ */
+static __always_inline local_lock_t *__this_cpu_local_lock(local_lock_t __pe=
rcpu *base)
+	__returns_ctx_lock(base) __attribute__((overloadable))
+{
+	return this_cpu_ptr(base);
+}
+#ifndef CONFIG_PREEMPT_RT
+static __always_inline local_trylock_t *__this_cpu_local_lock(local_trylock_=
t __percpu *base)
+	__returns_ctx_lock(base) __attribute__((overloadable))
+{
+	return this_cpu_ptr(base);
+}
+#endif /* CONFIG_PREEMPT_RT */
+#else  /* WARN_CONTEXT_ANALYSIS */
+#define __this_cpu_local_lock(base) this_cpu_ptr(base)
+#endif /* WARN_CONTEXT_ANALYSIS */
diff --git a/lib/test_context-analysis.c b/lib/test_context-analysis.c
index 1c96c56..003e64c 100644
--- a/lib/test_context-analysis.c
+++ b/lib/test_context-analysis.c
@@ -6,7 +6,9 @@
=20
 #include <linux/bit_spinlock.h>
 #include <linux/build_bug.h>
+#include <linux/local_lock.h>
 #include <linux/mutex.h>
+#include <linux/percpu.h>
 #include <linux/rcupdate.h>
 #include <linux/rwsem.h>
 #include <linux/seqlock.h>
@@ -458,3 +460,74 @@ static void __used test_srcu_guard(struct test_srcu_data=
 *d)
 	{ guard(srcu_fast)(&d->srcu); (void)srcu_dereference(d->data, &d->srcu); }
 	{ guard(srcu_fast_notrace)(&d->srcu); (void)srcu_dereference(d->data, &d->s=
rcu); }
 }
+
+struct test_local_lock_data {
+	local_lock_t lock;
+	int counter __guarded_by(&lock);
+};
+
+static DEFINE_PER_CPU(struct test_local_lock_data, test_local_lock_data) =3D=
 {
+	.lock =3D INIT_LOCAL_LOCK(lock),
+};
+
+static void __used test_local_lock_init(struct test_local_lock_data *d)
+{
+	local_lock_init(&d->lock);
+	d->counter =3D 0;
+}
+
+static void __used test_local_lock(void)
+{
+	unsigned long flags;
+
+	local_lock(&test_local_lock_data.lock);
+	this_cpu_add(test_local_lock_data.counter, 1);
+	local_unlock(&test_local_lock_data.lock);
+
+	local_lock_irq(&test_local_lock_data.lock);
+	this_cpu_add(test_local_lock_data.counter, 1);
+	local_unlock_irq(&test_local_lock_data.lock);
+
+	local_lock_irqsave(&test_local_lock_data.lock, flags);
+	this_cpu_add(test_local_lock_data.counter, 1);
+	local_unlock_irqrestore(&test_local_lock_data.lock, flags);
+
+	local_lock_nested_bh(&test_local_lock_data.lock);
+	this_cpu_add(test_local_lock_data.counter, 1);
+	local_unlock_nested_bh(&test_local_lock_data.lock);
+}
+
+static void __used test_local_lock_guard(void)
+{
+	{ guard(local_lock)(&test_local_lock_data.lock); this_cpu_add(test_local_lo=
ck_data.counter, 1); }
+	{ guard(local_lock_irq)(&test_local_lock_data.lock); this_cpu_add(test_loca=
l_lock_data.counter, 1); }
+	{ guard(local_lock_irqsave)(&test_local_lock_data.lock); this_cpu_add(test_=
local_lock_data.counter, 1); }
+	{ guard(local_lock_nested_bh)(&test_local_lock_data.lock); this_cpu_add(tes=
t_local_lock_data.counter, 1); }
+}
+
+struct test_local_trylock_data {
+	local_trylock_t lock;
+	int counter __guarded_by(&lock);
+};
+
+static DEFINE_PER_CPU(struct test_local_trylock_data, test_local_trylock_dat=
a) =3D {
+	.lock =3D INIT_LOCAL_TRYLOCK(lock),
+};
+
+static void __used test_local_trylock_init(struct test_local_trylock_data *d)
+{
+	local_trylock_init(&d->lock);
+	d->counter =3D 0;
+}
+
+static void __used test_local_trylock(void)
+{
+	local_lock(&test_local_trylock_data.lock);
+	this_cpu_add(test_local_trylock_data.counter, 1);
+	local_unlock(&test_local_trylock_data.lock);
+
+	if (local_trylock(&test_local_trylock_data.lock)) {
+		this_cpu_add(test_local_trylock_data.counter, 1);
+		local_unlock(&test_local_trylock_data.lock);
+	}
+}

