Return-Path: <linux-tip-commits+bounces-7813-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23649CF4A75
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F48632A3475
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 16:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D70349AEB;
	Mon,  5 Jan 2026 15:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C2plt4BB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2sq2tgRc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CD834845F;
	Mon,  5 Jan 2026 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628484; cv=none; b=RjlkCyfJDqQNuELSJJJkqJwiCjxyGp/05NxXHzlXCtCovYXHSU+PG2+ibp5SF8IRqqEivNBt9xpK8bqxVLQJ5fE5w6I4XZf7WM0NWE/H4fkF5pxL7R5sWUhxHf+5pUkQ2Mv6KFyh0YGgJReEIx99U7DTKBmHxHqMz0KPyZ97dzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628484; c=relaxed/simple;
	bh=Ir+lt5emFCaq6SG1xcgMrznLmDwIfvtTMkBdkL7/zwo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cSCRFILVMbdD3y7MTQVeyOBzz/FkG/KgLK1krzID+W+YjKKlcQ0xdlyXdSnpWR28tNa7IGGtregHCSq+jfrBX/UpCRiU7RwU7bCJ3dXptGT8IY79Fezdj0A5APpoukbkwTGnvg2Avy6ajpbnf3GaRGphce8nFhMQR5+HU9LYXXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C2plt4BB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2sq2tgRc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628480;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nsmiG8TjShabCQncm6iaBlg5Zrsesx6csN42CABTWOA=;
	b=C2plt4BBV0L0uMbFTMLx8q4dcPgArvpGrzqU9Q5rcSupSbZ3XOgRCSLjobLceeBhuMy1Rf
	sCuOGwvRF2zAQqfE4T/o/JQzAOoYxbCv4Q4lHOgOxEE7k8H9xcg+06Gsv2RoyZ63sTfLxF
	WRdkCgFqm9ieGlD0u4uhUG52+97SeqH4dxgV/A6KpOcOyIUKtz3dzZZrsu/6Ol3bqi5sXX
	5B7H2s+26tXfHszWn8Bj1FOEElBI3/dlQiyt1JcuPEiYalJ05SFaS0P6KJzfpyxLQssvdx
	aMtzIduDP9GRXdYRODRWplzYKMFAvyCkQcOUyCO5eTbW/lXkyxaNuL8Sphrf3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628480;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nsmiG8TjShabCQncm6iaBlg5Zrsesx6csN42CABTWOA=;
	b=2sq2tgRcO5re5O/3Edo1jyOtdTT9tTu3NuEdg093RBUDxkTCwW0yfIxRiNbxFn20scHGsL
	OPBrlQs+johG3ODQ==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] compiler-context-analysis: Change __cond_acquires
 to take return value
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-10-elver@google.com>
References: <20251219154418.3592607-10-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762847890.510.15461696041820796617.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     38f1311a2219220a3962fae464ca6300ef60b4c1
Gitweb:        https://git.kernel.org/tip/38f1311a2219220a3962fae464ca6300ef6=
0b4c1
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:39:58 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:29 +01:00

compiler-context-analysis: Change __cond_acquires to take return value

While Sparse is oblivious to the return value of conditional acquire
functions, Clang's context analysis needs to know the return value
which indicates successful acquisition.

Add the additional argument, and convert existing uses.

Notably, Clang's interpretation of the value merely relates to the use
in a later conditional branch, i.e. 1 =3D=3D> context lock acquired in
branch taken if condition non-zero, and 0 =3D=3D> context lock acquired in
branch taken if condition is zero. Given the precise value does not
matter, introduce symbolic variants to use instead of either 0 or 1,
which should be more intuitive.

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251219154418.3592607-10-elver@google.com
---
 fs/dlm/lock.c                             |  2 +-
 include/linux/compiler-context-analysis.h | 31 ++++++++++++++++++----
 include/linux/refcount.h                  |  6 ++--
 include/linux/spinlock.h                  |  6 ++--
 include/linux/spinlock_api_smp.h          |  8 +++---
 net/ipv4/tcp_sigpool.c                    |  2 +-
 6 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index be938fd..0ce04be 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -343,7 +343,7 @@ void dlm_hold_rsb(struct dlm_rsb *r)
 /* TODO move this to lib/refcount.c */
 static __must_check bool
 dlm_refcount_dec_and_write_lock_bh(refcount_t *r, rwlock_t *lock)
-__cond_acquires(lock)
+      __cond_acquires(true, lock)
 {
 	if (refcount_dec_not_one(r))
 		return false;
diff --git a/include/linux/compiler-context-analysis.h b/include/linux/compil=
er-context-analysis.h
index d0b3cf0..a6a3498 100644
--- a/include/linux/compiler-context-analysis.h
+++ b/include/linux/compiler-context-analysis.h
@@ -271,7 +271,7 @@ static inline void _context_unsafe_alias(void **p) { }
 # define __must_hold(x)		__attribute__((context(x,1,1)))
 # define __must_not_hold(x)
 # define __acquires(x)		__attribute__((context(x,0,1)))
-# define __cond_acquires(x)	__attribute__((context(x,0,-1)))
+# define __cond_acquires(ret, x) __attribute__((context(x,0,-1)))
 # define __releases(x)		__attribute__((context(x,1,0)))
 # define __acquire(x)		__context__(x,1)
 # define __release(x)		__context__(x,-1)
@@ -314,15 +314,32 @@ static inline void _context_unsafe_alias(void **p) { }
  */
 # define __acquires(x)		__acquires_ctx_lock(x)
=20
+/*
+ * Clang's analysis does not care precisely about the value, only that it is
+ * either zero or non-zero. So the __cond_acquires() interface might be
+ * misleading if we say that @ret is the value returned if acquired. Instead,
+ * provide symbolic variants which we translate.
+ */
+#define __cond_acquires_impl_true(x, ...)     __try_acquires##__VA_ARGS__##_=
ctx_lock(1, x)
+#define __cond_acquires_impl_false(x, ...)    __try_acquires##__VA_ARGS__##_=
ctx_lock(0, x)
+#define __cond_acquires_impl_nonzero(x, ...)  __try_acquires##__VA_ARGS__##_=
ctx_lock(1, x)
+#define __cond_acquires_impl_0(x, ...)        __try_acquires##__VA_ARGS__##_=
ctx_lock(0, x)
+#define __cond_acquires_impl_nonnull(x, ...)  __try_acquires##__VA_ARGS__##_=
ctx_lock(1, x)
+#define __cond_acquires_impl_NULL(x, ...)     __try_acquires##__VA_ARGS__##_=
ctx_lock(0, x)
+
 /**
  * __cond_acquires() - function attribute, function conditionally
  *                     acquires a context lock exclusively
+ * @ret: abstract value returned by function if context lock acquired
  * @x: context lock instance pointer
  *
  * Function attribute declaring that the function conditionally acquires the
- * given context lock instance @x exclusively, but does not release it.
+ * given context lock instance @x exclusively, but does not release it. The
+ * function return value @ret denotes when the context lock is acquired.
+ *
+ * @ret may be one of: true, false, nonzero, 0, nonnull, NULL.
  */
-# define __cond_acquires(x)	__try_acquires_ctx_lock(1, x)
+# define __cond_acquires(ret, x) __cond_acquires_impl_##ret(x)
=20
 /**
  * __releases() - function attribute, function releases a context lock exclu=
sively
@@ -389,12 +406,16 @@ static inline void _context_unsafe_alias(void **p) { }
 /**
  * __cond_acquires_shared() - function attribute, function conditionally
  *                            acquires a context lock shared
+ * @ret: abstract value returned by function if context lock acquired
  * @x: context lock instance pointer
  *
  * Function attribute declaring that the function conditionally acquires the
- * given context lock instance @x with shared access, but does not release i=
t.
+ * given context lock instance @x with shared access, but does not release i=
t. The
+ * function return value @ret denotes when the context lock is acquired.
+ *
+ * @ret may be one of: true, false, nonzero, 0, nonnull, NULL.
  */
-# define __cond_acquires_shared(x) __try_acquires_shared_ctx_lock(1, x)
+# define __cond_acquires_shared(ret, x) __cond_acquires_impl_##ret(x, _share=
d)
=20
 /**
  * __releases_shared() - function attribute, function releases a
diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 80dc023..3da377f 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -478,9 +478,9 @@ static inline void refcount_dec(refcount_t *r)
=20
 extern __must_check bool refcount_dec_if_one(refcount_t *r);
 extern __must_check bool refcount_dec_not_one(refcount_t *r);
-extern __must_check bool refcount_dec_and_mutex_lock(refcount_t *r, struct m=
utex *lock) __cond_acquires(lock);
-extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lo=
ck) __cond_acquires(lock);
+extern __must_check bool refcount_dec_and_mutex_lock(refcount_t *r, struct m=
utex *lock) __cond_acquires(true, lock);
+extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lo=
ck) __cond_acquires(true, lock);
 extern __must_check bool refcount_dec_and_lock_irqsave(refcount_t *r,
 						       spinlock_t *lock,
-						       unsigned long *flags) __cond_acquires(lock);
+						       unsigned long *flags) __cond_acquires(true, lock);
 #endif /* _LINUX_REFCOUNT_H */
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 72aabdd..7e560c7 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -362,7 +362,7 @@ static __always_inline void spin_lock_bh(spinlock_t *lock)
 }
=20
 static __always_inline int spin_trylock(spinlock_t *lock)
-	__cond_acquires(lock) __no_context_analysis
+	__cond_acquires(true, lock) __no_context_analysis
 {
 	return raw_spin_trylock(&lock->rlock);
 }
@@ -422,13 +422,13 @@ static __always_inline void spin_unlock_irqrestore(spin=
lock_t *lock, unsigned lo
 }
=20
 static __always_inline int spin_trylock_bh(spinlock_t *lock)
-	__cond_acquires(lock) __no_context_analysis
+	__cond_acquires(true, lock) __no_context_analysis
 {
 	return raw_spin_trylock_bh(&lock->rlock);
 }
=20
 static __always_inline int spin_trylock_irq(spinlock_t *lock)
-	__cond_acquires(lock) __no_context_analysis
+	__cond_acquires(true, lock) __no_context_analysis
 {
 	return raw_spin_trylock_irq(&lock->rlock);
 }
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_sm=
p.h
index d19327e..7e7d7d3 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -34,8 +34,8 @@ unsigned long __lockfunc _raw_spin_lock_irqsave(raw_spinloc=
k_t *lock)
 unsigned long __lockfunc
 _raw_spin_lock_irqsave_nested(raw_spinlock_t *lock, int subclass)
 								__acquires(lock);
-int __lockfunc _raw_spin_trylock(raw_spinlock_t *lock)		__cond_acquires(lock=
);
-int __lockfunc _raw_spin_trylock_bh(raw_spinlock_t *lock)	__cond_acquires(lo=
ck);
+int __lockfunc _raw_spin_trylock(raw_spinlock_t *lock)		__cond_acquires(true=
, lock);
+int __lockfunc _raw_spin_trylock_bh(raw_spinlock_t *lock)	__cond_acquires(tr=
ue, lock);
 void __lockfunc _raw_spin_unlock(raw_spinlock_t *lock)		__releases(lock);
 void __lockfunc _raw_spin_unlock_bh(raw_spinlock_t *lock)	__releases(lock);
 void __lockfunc _raw_spin_unlock_irq(raw_spinlock_t *lock)	__releases(lock);
@@ -84,7 +84,7 @@ _raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned =
long flags)
 #endif
=20
 static inline int __raw_spin_trylock(raw_spinlock_t *lock)
-	__cond_acquires(lock)
+	__cond_acquires(true, lock)
 {
 	preempt_disable();
 	if (do_raw_spin_trylock(lock)) {
@@ -177,7 +177,7 @@ static inline void __raw_spin_unlock_bh(raw_spinlock_t *l=
ock)
 }
=20
 static inline int __raw_spin_trylock_bh(raw_spinlock_t *lock)
-	__cond_acquires(lock)
+	__cond_acquires(true, lock)
 {
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
 	if (do_raw_spin_trylock(lock)) {
diff --git a/net/ipv4/tcp_sigpool.c b/net/ipv4/tcp_sigpool.c
index d8a4f19..10b2e59 100644
--- a/net/ipv4/tcp_sigpool.c
+++ b/net/ipv4/tcp_sigpool.c
@@ -257,7 +257,7 @@ void tcp_sigpool_get(unsigned int id)
 }
 EXPORT_SYMBOL_GPL(tcp_sigpool_get);
=20
-int tcp_sigpool_start(unsigned int id, struct tcp_sigpool *c) __cond_acquire=
s(RCU_BH)
+int tcp_sigpool_start(unsigned int id, struct tcp_sigpool *c) __cond_acquire=
s(0, RCU_BH)
 {
 	struct crypto_ahash *hash;
=20

