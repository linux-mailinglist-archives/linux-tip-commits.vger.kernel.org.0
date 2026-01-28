Return-Path: <linux-tip-commits+bounces-8135-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6E2sBO9oemmB5gEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8135-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 20:52:15 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3BFA84AB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 20:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 490CF303F45A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 19:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42351369223;
	Wed, 28 Jan 2026 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AIu7zv1m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xj07sEbV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1FA37646A;
	Wed, 28 Jan 2026 19:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769629879; cv=none; b=asFzA4egQncpj67zsV9ufAqjhQEP/Z93CiwFnhwnP6PMD9B8AGXzhc3Wl02nrF9qalnYDIAMj/YaUPehvpEIRv/1rtR0h/8ptj4yAORoyNOG0YPuWykXOMx3hfDMvRLGFOpvd86ojh5mFquBj1nB9tEu+LsILXmznyAHRCfOC1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769629879; c=relaxed/simple;
	bh=3xZBs/jFtT+ruhsjg9fwdOKckTiBwdx98Np2qvXE6mM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EtSi0YF7N2+3JQs9rO73Su6aau+omSH5myuMiZ9vUoTbStgKqGhnpZjjSK42Y4Dmdnj3zNFqgio7X6ScjeTh7YO0Hbh/QJjN7R8bRn862O5GdlphGGsG7lOJJxBdto3rmLp50LmuKzCgvHDv7kdjku1IRUSfQNumi8HVOaaFAqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AIu7zv1m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xj07sEbV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Jan 2026 19:51:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769629875;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7X2muc51ZnbZgaZXDZnsGS0EqLNStnfQgfu59NVc88=;
	b=AIu7zv1m4vP9vkTU2pETPK8eYeOeVHoogfCoc+52r/cHdjA1kbK9/RkZo5WOF2NuNftJgP
	fbiGy5HEObG+GB6f46IEqnqpQu8LBQYapzu8Sf+GJqe7juCGc7uzvA0drVBEOB9h4tkdGD
	8csKHOMg+IHbud5ldcaglJ17Apmlv+C422IGX8njqjuPUlYA0G2g4IJeWR3ThytHRSKppj
	XPBVz5cgen6+5TKQzYSFwysP4gVcj/s8NQVErykC22mvVz37Ix12/Nyy6vGTvw0RJdLs/2
	lCtBL6YYZ8Lft7hsp1wuY+2bHPGnrsHKiXCcvC+H+pVmrN3QjmIVxaipVmgGmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769629875;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7X2muc51ZnbZgaZXDZnsGS0EqLNStnfQgfu59NVc88=;
	b=xj07sEbVvSaB/Hu8dqL1XZ0uKPjyCDEQhuFnQvrHiLcxrc68CvvsyJapPK7GINCHVwI4RV
	41PKWGGVvKmcpnBg==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] compiler-context-analysis: Introduce scoped init guards
Cc: Peter Zijlstra <peterz@infradead.org>, Marco Elver <elver@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260119094029.1344361-3-elver@google.com>
References: <20260119094029.1344361-3-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176962987462.2495410.5418423107519622031.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8135-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linutronix.de:dkim,msgid.link:url,vger.kernel.org:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 9F3BFA84AB
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d084a73714f818ce509022e1aa9483cabf797c16
Gitweb:        https://git.kernel.org/tip/d084a73714f818ce509022e1aa9483cabf7=
97c16
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 19 Jan 2026 10:05:52 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 28 Jan 2026 20:45:24 +01:00

compiler-context-analysis: Introduce scoped init guards

Add scoped init guard definitions for common synchronization primitives
supported by context analysis.

The scoped init guards treat the context as active within initialization
scope of the underlying context lock, given initialization implies
exclusive access to the underlying object. This allows initialization of
guarded members without disabling context analysis, while documenting
initialization from subsequent usage.

The documentation is updated with the new recommendation. Where scoped
init guards are not provided or cannot be implemented (ww_mutex omitted
for lack of multi-arg guard initializers), the alternative is to just
disable context analysis where guarded members are initialized.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20251212095943.GM3911114@noisy.programming.=
kicks-ass.net/
Link: https://patch.msgid.link/20260119094029.1344361-3-elver@google.com
---
 Documentation/dev-tools/context-analysis.rst | 30 +++++++++++++++++--
 include/linux/compiler-context-analysis.h    |  9 +-----
 include/linux/local_lock.h                   |  8 +++++-
 include/linux/local_lock_internal.h          |  1 +-
 include/linux/mutex.h                        |  3 ++-
 include/linux/rwsem.h                        |  4 +++-
 include/linux/seqlock.h                      |  5 +++-
 include/linux/spinlock.h                     | 12 ++++++++-
 lib/test_context-analysis.c                  | 16 +++++-----
 9 files changed, 70 insertions(+), 18 deletions(-)

diff --git a/Documentation/dev-tools/context-analysis.rst b/Documentation/dev=
-tools/context-analysis.rst
index e69896e..54d9ee2 100644
--- a/Documentation/dev-tools/context-analysis.rst
+++ b/Documentation/dev-tools/context-analysis.rst
@@ -83,9 +83,33 @@ Currently the following synchronization primitives are sup=
ported:
 `bit_spinlock`, RCU, SRCU (`srcu_struct`), `rw_semaphore`, `local_lock_t`,
 `ww_mutex`.
=20
-For context locks with an initialization function (e.g., `spin_lock_init()`),
-calling this function before initializing any guarded members or globals
-prevents the compiler from issuing warnings about unguarded initialization.
+To initialize variables guarded by a context lock with an initialization
+function (``type_init(&lock)``), prefer using ``guard(type_init)(&lock)`` or
+``scoped_guard(type_init, &lock) { ... }`` to initialize such guarded members
+or globals in the enclosing scope. This initializes the context lock and tre=
ats
+the context as active within the initialization scope (initialization implies
+exclusive access to the underlying object).
+
+For example::
+
+    struct my_data {
+            spinlock_t lock;
+            int counter __guarded_by(&lock);
+    };
+
+    void init_my_data(struct my_data *d)
+    {
+            ...
+            guard(spinlock_init)(&d->lock);
+            d->counter =3D 0;
+            ...
+    }
+
+Alternatively, initializing guarded variables can be done with context analy=
sis
+disabled, preferably in the smallest possible scope (due to lack of any other
+checking): either with a ``context_unsafe(var =3D init)`` expression, or by
+marking small initialization functions with the ``__context_unsafe(init)``
+attribute.
=20
 Lockdep assertions, such as `lockdep_assert_held()`, inform the compiler's
 context analysis that the associated synchronization primitive is held after
diff --git a/include/linux/compiler-context-analysis.h b/include/linux/compil=
er-context-analysis.h
index e86b8a3..00c074a 100644
--- a/include/linux/compiler-context-analysis.h
+++ b/include/linux/compiler-context-analysis.h
@@ -32,13 +32,8 @@
 /*
  * The "assert_capability" attribute is a bit confusingly named. It does not
  * generate a check. Instead, it tells the analysis to *assume* the capabili=
ty
- * is held. This is used for:
- *
- * 1. Augmenting runtime assertions, that can then help with patterns beyond=
 the
- *    compiler's static reasoning abilities.
- *
- * 2. Initialization of context locks, so we can access guarded variables ri=
ght
- *    after initialization (nothing else should access the same object yet).
+ * is held. This is used for augmenting runtime assertions, that can then he=
lp
+ * with patterns beyond the compiler's static reasoning abilities.
  */
 # define __assumes_ctx_lock(...)		__attribute__((assert_capability(__VA_ARGS=
__)))
 # define __assumes_shared_ctx_lock(...)	__attribute__((assert_shared_capabil=
ity(__VA_ARGS__)))
diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 99c06e4..b883014 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -104,6 +104,8 @@ DEFINE_LOCK_GUARD_1(local_lock_nested_bh, local_lock_t __=
percpu,
 		    local_lock_nested_bh(_T->lock),
 		    local_unlock_nested_bh(_T->lock))
=20
+DEFINE_LOCK_GUARD_1(local_lock_init, local_lock_t, local_lock_init(_T->lock)=
, /* */)
+
 DECLARE_LOCK_GUARD_1_ATTRS(local_lock, __acquires(_T), __releases(*(local_lo=
ck_t __percpu **)_T))
 #define class_local_lock_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(local_lock,=
 _T)
 DECLARE_LOCK_GUARD_1_ATTRS(local_lock_irq, __acquires(_T), __releases(*(loca=
l_lock_t __percpu **)_T))
@@ -112,5 +114,11 @@ DECLARE_LOCK_GUARD_1_ATTRS(local_lock_irqsave, __acquire=
s(_T), __releases(*(loca
 #define class_local_lock_irqsave_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(loc=
al_lock_irqsave, _T)
 DECLARE_LOCK_GUARD_1_ATTRS(local_lock_nested_bh, __acquires(_T), __releases(=
*(local_lock_t __percpu **)_T))
 #define class_local_lock_nested_bh_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(l=
ocal_lock_nested_bh, _T)
+DECLARE_LOCK_GUARD_1_ATTRS(local_lock_init, __acquires(_T), __releases(*(loc=
al_lock_t **)_T))
+#define class_local_lock_init_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(local_=
lock_init, _T)
+
+DEFINE_LOCK_GUARD_1(local_trylock_init, local_trylock_t, local_trylock_init(=
_T->lock), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(local_trylock_init, __acquires(_T), __releases(*(=
local_trylock_t **)_T))
+#define class_local_trylock_init_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(loc=
al_trylock_init, _T)
=20
 #endif
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_i=
nternal.h
index 7843ab9..ed2f3fb 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -6,6 +6,7 @@
 #include <linux/percpu-defs.h>
 #include <linux/irqflags.h>
 #include <linux/lockdep.h>
+#include <linux/debug_locks.h>
 #include <asm/current.h>
=20
 #ifndef CONFIG_PREEMPT_RT
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 89977c2..6b12009 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -254,6 +254,7 @@ extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struc=
t mutex *lock) __cond_a
 DEFINE_LOCK_GUARD_1(mutex, struct mutex, mutex_lock(_T->lock), mutex_unlock(=
_T->lock))
 DEFINE_LOCK_GUARD_1_COND(mutex, _try, mutex_trylock(_T->lock))
 DEFINE_LOCK_GUARD_1_COND(mutex, _intr, mutex_lock_interruptible(_T->lock), _=
RET =3D=3D 0)
+DEFINE_LOCK_GUARD_1(mutex_init, struct mutex, mutex_init(_T->lock), /* */)
=20
 DECLARE_LOCK_GUARD_1_ATTRS(mutex,	__acquires(_T), __releases(*(struct mutex =
**)_T))
 #define class_mutex_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(mutex, _T)
@@ -261,6 +262,8 @@ DECLARE_LOCK_GUARD_1_ATTRS(mutex_try,	__acquires(_T), __r=
eleases(*(struct mutex=20
 #define class_mutex_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(mutex_try, _=
T)
 DECLARE_LOCK_GUARD_1_ATTRS(mutex_intr,	__acquires(_T), __releases(*(struct m=
utex **)_T))
 #define class_mutex_intr_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(mutex_intr,=
 _T)
+DECLARE_LOCK_GUARD_1_ATTRS(mutex_init,	__acquires(_T), __releases(*(struct m=
utex **)_T))
+#define class_mutex_init_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(mutex_init,=
 _T)
=20
 extern unsigned long mutex_get_owner(struct mutex *lock);
=20
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 8da14a0..ea1bbdb 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -280,6 +280,10 @@ DECLARE_LOCK_GUARD_1_ATTRS(rwsem_write_try, __acquires(_=
T), __releases(*(struct=20
 DECLARE_LOCK_GUARD_1_ATTRS(rwsem_write_kill, __acquires(_T), __releases(*(st=
ruct rw_semaphore **)_T))
 #define class_rwsem_write_kill_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rwsem=
_write_kill, _T)
=20
+DEFINE_LOCK_GUARD_1(rwsem_init, struct rw_semaphore, init_rwsem(_T->lock), /=
* */)
+DECLARE_LOCK_GUARD_1_ATTRS(rwsem_init, __acquires(_T), __releases(*(struct r=
w_semaphore **)_T))
+#define class_rwsem_init_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rwsem_init,=
 _T)
+
 /*
  * downgrade write lock to read lock
  */
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index c00063d..077c8d5 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -14,6 +14,7 @@
  */
=20
 #include <linux/compiler.h>
+#include <linux/cleanup.h>
 #include <linux/kcsan-checks.h>
 #include <linux/lockdep.h>
 #include <linux/mutex.h>
@@ -1358,4 +1359,8 @@ static __always_inline void __scoped_seqlock_cleanup_ct=
x(struct ss_tmp **s)
 #define scoped_seqlock_read(_seqlock, _target)				\
 	__scoped_seqlock_read(_seqlock, _target, __UNIQUE_ID(seqlock))
=20
+DEFINE_LOCK_GUARD_1(seqlock_init, seqlock_t, seqlock_init(_T->lock), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(seqlock_init, __acquires(_T), __releases(*(seqloc=
k_t **)_T))
+#define class_seqlock_init_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(seqlock_i=
nit, _T)
+
 #endif /* __LINUX_SEQLOCK_H */
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 396b8c5..7b11991 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -582,6 +582,10 @@ DEFINE_LOCK_GUARD_1_COND(raw_spinlock_irqsave, _try,
 DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_irqsave_try, __acquires(_T), __relea=
ses(*(raw_spinlock_t **)_T))
 #define class_raw_spinlock_irqsave_try_constructor(_T) WITH_LOCK_GUARD_1_ATT=
RS(raw_spinlock_irqsave_try, _T)
=20
+DEFINE_LOCK_GUARD_1(raw_spinlock_init, raw_spinlock_t, raw_spin_lock_init(_T=
->lock), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_init, __acquires(_T), __releases(*(r=
aw_spinlock_t **)_T))
+#define class_raw_spinlock_init_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(raw_=
spinlock_init, _T)
+
 DEFINE_LOCK_GUARD_1(spinlock, spinlock_t,
 		    spin_lock(_T->lock),
 		    spin_unlock(_T->lock))
@@ -626,6 +630,10 @@ DEFINE_LOCK_GUARD_1_COND(spinlock_irqsave, _try,
 DECLARE_LOCK_GUARD_1_ATTRS(spinlock_irqsave_try, __acquires(_T), __releases(=
*(spinlock_t **)_T))
 #define class_spinlock_irqsave_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(s=
pinlock_irqsave_try, _T)
=20
+DEFINE_LOCK_GUARD_1(spinlock_init, spinlock_t, spin_lock_init(_T->lock), /* =
*/)
+DECLARE_LOCK_GUARD_1_ATTRS(spinlock_init, __acquires(_T), __releases(*(spinl=
ock_t **)_T))
+#define class_spinlock_init_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(spinlock=
_init, _T)
+
 DEFINE_LOCK_GUARD_1(read_lock, rwlock_t,
 		    read_lock(_T->lock),
 		    read_unlock(_T->lock))
@@ -664,5 +672,9 @@ DEFINE_LOCK_GUARD_1(write_lock_irqsave, rwlock_t,
 DECLARE_LOCK_GUARD_1_ATTRS(write_lock_irqsave, __acquires(_T), __releases(*(=
rwlock_t **)_T))
 #define class_write_lock_irqsave_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(wri=
te_lock_irqsave, _T)
=20
+DEFINE_LOCK_GUARD_1(rwlock_init, rwlock_t, rwlock_init(_T->lock), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(rwlock_init, __acquires(_T), __releases(*(rwlock_=
t **)_T))
+#define class_rwlock_init_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rwlock_ini=
t, _T)
+
 #undef __LINUX_INSIDE_SPINLOCK_H
 #endif /* __LINUX_SPINLOCK_H */
diff --git a/lib/test_context-analysis.c b/lib/test_context-analysis.c
index 1c5a381..0f05943 100644
--- a/lib/test_context-analysis.c
+++ b/lib/test_context-analysis.c
@@ -35,7 +35,7 @@ static void __used test_common_helpers(void)
 	};											\
 	static void __used test_##class##_init(struct test_##class##_data *d)			\
 	{											\
-		type_init(&d->lock);								\
+		guard(type_init)(&d->lock);							\
 		d->counter =3D 0;									\
 	}											\
 	static void __used test_##class(struct test_##class##_data *d)				\
@@ -83,7 +83,7 @@ static void __used test_common_helpers(void)
=20
 TEST_SPINLOCK_COMMON(raw_spinlock,
 		     raw_spinlock_t,
-		     raw_spin_lock_init,
+		     raw_spinlock_init,
 		     raw_spin_lock,
 		     raw_spin_unlock,
 		     raw_spin_trylock,
@@ -109,7 +109,7 @@ static void __used test_raw_spinlock_trylock_extra(struct=
 test_raw_spinlock_data
=20
 TEST_SPINLOCK_COMMON(spinlock,
 		     spinlock_t,
-		     spin_lock_init,
+		     spinlock_init,
 		     spin_lock,
 		     spin_unlock,
 		     spin_trylock,
@@ -163,7 +163,7 @@ struct test_mutex_data {
=20
 static void __used test_mutex_init(struct test_mutex_data *d)
 {
-	mutex_init(&d->mtx);
+	guard(mutex_init)(&d->mtx);
 	d->counter =3D 0;
 }
=20
@@ -226,7 +226,7 @@ struct test_seqlock_data {
=20
 static void __used test_seqlock_init(struct test_seqlock_data *d)
 {
-	seqlock_init(&d->sl);
+	guard(seqlock_init)(&d->sl);
 	d->counter =3D 0;
 }
=20
@@ -275,7 +275,7 @@ struct test_rwsem_data {
=20
 static void __used test_rwsem_init(struct test_rwsem_data *d)
 {
-	init_rwsem(&d->sem);
+	guard(rwsem_init)(&d->sem);
 	d->counter =3D 0;
 }
=20
@@ -475,7 +475,7 @@ static DEFINE_PER_CPU(struct test_local_lock_data, test_l=
ocal_lock_data) =3D {
=20
 static void __used test_local_lock_init(struct test_local_lock_data *d)
 {
-	local_lock_init(&d->lock);
+	guard(local_lock_init)(&d->lock);
 	d->counter =3D 0;
 }
=20
@@ -519,7 +519,7 @@ static DEFINE_PER_CPU(struct test_local_trylock_data, tes=
t_local_trylock_data) =3D
=20
 static void __used test_local_trylock_init(struct test_local_trylock_data *d)
 {
-	local_trylock_init(&d->lock);
+	guard(local_trylock_init)(&d->lock);
 	d->counter =3D 0;
 }
=20

