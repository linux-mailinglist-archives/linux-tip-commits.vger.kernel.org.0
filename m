Return-Path: <linux-tip-commits+bounces-7805-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE68CF4914
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E3913043D54
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 16:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1B1346FA8;
	Mon,  5 Jan 2026 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gfq1DwUT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hLYAQUGQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0CB346AF0;
	Mon,  5 Jan 2026 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628475; cv=none; b=Qe1l+h4KrrzHdfy2fJ+J5nnSLtrlIPtbNAnRamAInl4d2vmKkRdnhdDXOSFQ8TXvyXBtSjTmXsLRfCI5J08g61EXoQ+JqpX6x/7jf9Ra/hVcinFloTL9KGMECaJSf3bcUNPNTuoIQFxfuwAVUQlNzRFd6+tvkgf9J6WWg/QdCBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628475; c=relaxed/simple;
	bh=vqp4gnTCGN6/qpqeQKhn8fCvw5YXU6jvSvSlKEfbCJQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lrYueH1pGj5KRAZgpFesEo6qw8mZbOllOZIBT2XUBb/1UEyoFEKwiIRZ/NS5R16QI6pQN4qm4Lc/XaEux0n0NDbXQCgbDiVIMuHBm9KUIaGU2Yicmx/hpIY4HVa8sgM6OHMZvuCaAM03A1yf8LV9MUz7EItDEI6o5X7tRFFa51c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gfq1DwUT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hLYAQUGQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628471;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tI+FVHA4Nm+3bbbIyfpjIxy56YDVjxJScSzK15m5nxo=;
	b=Gfq1DwUT+rOqPuE/VkVcT5BvXTYl1MmwdG7s6O455PEMtSKd3bDdbXgnUHszqjmDKSLycE
	+7abkeb21lWetRbfxheOJJw5rx6p35RQMAiMDLkcAwPXCq0vub2R0HR+BPskeoJUoELQIX
	0a/g4xUhB9rBYY6hcgw2LCAtH9Wx4Wg7wOcKaU+1akwnNAbx3kpH90hw0tyBb+FFwNPTkM
	+iP2F8D110eH3DfXUsp3oiy8YjQ6hUXH7tgttzSLGCKyM83qlu3pvWwNySoT3xKa/z/7Mn
	LG58Qf6qhnTGoU7FYVnmrgRdtIJTg5bbbX/jdoND/NeaKtAVmE6dyQ+DzqP7pQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628471;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tI+FVHA4Nm+3bbbIyfpjIxy56YDVjxJScSzK15m5nxo=;
	b=hLYAQUGQmcL/Js041CEMbBbDBeEdJiij5SPx9lKMG8nRsyo/o9AUn2SObclnWH/ADjmJq7
	XeWze7qb5x9IM2Bg==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Support Clang's context analysis
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-18-elver@google.com>
References: <20251219154418.3592607-18-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762847032.510.7143968701789076175.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e4fd3be884cf33a42c5bcde087b0722a5b8f25ca
Gitweb:        https://git.kernel.org/tip/e4fd3be884cf33a42c5bcde087b0722a5b8=
f25ca
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:40:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:31 +01:00

locking/rwsem: Support Clang's context analysis

Add support for Clang's context analysis for rw_semaphore.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251219154418.3592607-18-elver@google.com
---
 Documentation/dev-tools/context-analysis.rst |  2 +-
 include/linux/rwsem.h                        | 76 ++++++++++++-------
 lib/test_context-analysis.c                  | 64 ++++++++++++++++-
 3 files changed, 114 insertions(+), 28 deletions(-)

diff --git a/Documentation/dev-tools/context-analysis.rst b/Documentation/dev=
-tools/context-analysis.rst
index f7736f1..7b660c3 100644
--- a/Documentation/dev-tools/context-analysis.rst
+++ b/Documentation/dev-tools/context-analysis.rst
@@ -80,7 +80,7 @@ Supported Kernel Primitives
=20
 Currently the following synchronization primitives are supported:
 `raw_spinlock_t`, `spinlock_t`, `rwlock_t`, `mutex`, `seqlock_t`,
-`bit_spinlock`, RCU, SRCU (`srcu_struct`).
+`bit_spinlock`, RCU, SRCU (`srcu_struct`), `rw_semaphore`.
=20
 For context locks with an initialization function (e.g., `spin_lock_init()`),
 calling this function before initializing any guarded members or globals
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index f1aaf67..8da14a0 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -45,7 +45,7 @@
  * reduce the chance that they will share the same cacheline causing
  * cacheline bouncing problem.
  */
-struct rw_semaphore {
+context_lock_struct(rw_semaphore) {
 	atomic_long_t count;
 	/*
 	 * Write owner or one of the read owners as well flags regarding
@@ -76,11 +76,13 @@ static inline int rwsem_is_locked(struct rw_semaphore *se=
m)
 }
=20
 static inline void rwsem_assert_held_nolockdep(const struct rw_semaphore *se=
m)
+	__assumes_ctx_lock(sem)
 {
 	WARN_ON(atomic_long_read(&sem->count) =3D=3D RWSEM_UNLOCKED_VALUE);
 }
=20
 static inline void rwsem_assert_held_write_nolockdep(const struct rw_semapho=
re *sem)
+	__assumes_ctx_lock(sem)
 {
 	WARN_ON(!(atomic_long_read(&sem->count) & RWSEM_WRITER_LOCKED));
 }
@@ -119,6 +121,7 @@ do {								\
 	static struct lock_class_key __key;			\
 								\
 	__init_rwsem((sem), #sem, &__key);			\
+	__assume_ctx_lock(sem);					\
 } while (0)
=20
 /*
@@ -148,7 +151,7 @@ extern bool is_rwsem_reader_owned(struct rw_semaphore *se=
m);
=20
 #include <linux/rwbase_rt.h>
=20
-struct rw_semaphore {
+context_lock_struct(rw_semaphore) {
 	struct rwbase_rt	rwbase;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
@@ -172,6 +175,7 @@ do {								\
 	static struct lock_class_key __key;			\
 								\
 	__init_rwsem((sem), #sem, &__key);			\
+	__assume_ctx_lock(sem);					\
 } while (0)
=20
 static __always_inline int rwsem_is_locked(const struct rw_semaphore *sem)
@@ -180,11 +184,13 @@ static __always_inline int rwsem_is_locked(const struct=
 rw_semaphore *sem)
 }
=20
 static __always_inline void rwsem_assert_held_nolockdep(const struct rw_sema=
phore *sem)
+	__assumes_ctx_lock(sem)
 {
 	WARN_ON(!rwsem_is_locked(sem));
 }
=20
 static __always_inline void rwsem_assert_held_write_nolockdep(const struct r=
w_semaphore *sem)
+	__assumes_ctx_lock(sem)
 {
 	WARN_ON(!rw_base_is_write_locked(&sem->rwbase));
 }
@@ -202,6 +208,7 @@ static __always_inline int rwsem_is_contended(struct rw_s=
emaphore *sem)
  */
=20
 static inline void rwsem_assert_held(const struct rw_semaphore *sem)
+	__assumes_ctx_lock(sem)
 {
 	if (IS_ENABLED(CONFIG_LOCKDEP))
 		lockdep_assert_held(sem);
@@ -210,6 +217,7 @@ static inline void rwsem_assert_held(const struct rw_sema=
phore *sem)
 }
=20
 static inline void rwsem_assert_held_write(const struct rw_semaphore *sem)
+	__assumes_ctx_lock(sem)
 {
 	if (IS_ENABLED(CONFIG_LOCKDEP))
 		lockdep_assert_held_write(sem);
@@ -220,48 +228,62 @@ static inline void rwsem_assert_held_write(const struct=
 rw_semaphore *sem)
 /*
  * lock for reading
  */
-extern void down_read(struct rw_semaphore *sem);
-extern int __must_check down_read_interruptible(struct rw_semaphore *sem);
-extern int __must_check down_read_killable(struct rw_semaphore *sem);
+extern void down_read(struct rw_semaphore *sem) __acquires_shared(sem);
+extern int __must_check down_read_interruptible(struct rw_semaphore *sem) __=
cond_acquires_shared(0, sem);
+extern int __must_check down_read_killable(struct rw_semaphore *sem) __cond_=
acquires_shared(0, sem);
=20
 /*
  * trylock for reading -- returns 1 if successful, 0 if contention
  */
-extern int down_read_trylock(struct rw_semaphore *sem);
+extern int down_read_trylock(struct rw_semaphore *sem) __cond_acquires_share=
d(true, sem);
=20
 /*
  * lock for writing
  */
-extern void down_write(struct rw_semaphore *sem);
-extern int __must_check down_write_killable(struct rw_semaphore *sem);
+extern void down_write(struct rw_semaphore *sem) __acquires(sem);
+extern int __must_check down_write_killable(struct rw_semaphore *sem) __cond=
_acquires(0, sem);
=20
 /*
  * trylock for writing -- returns 1 if successful, 0 if contention
  */
-extern int down_write_trylock(struct rw_semaphore *sem);
+extern int down_write_trylock(struct rw_semaphore *sem) __cond_acquires(true=
, sem);
=20
 /*
  * release a read lock
  */
-extern void up_read(struct rw_semaphore *sem);
+extern void up_read(struct rw_semaphore *sem) __releases_shared(sem);
=20
 /*
  * release a write lock
  */
-extern void up_write(struct rw_semaphore *sem);
-
-DEFINE_GUARD(rwsem_read, struct rw_semaphore *, down_read(_T), up_read(_T))
-DEFINE_GUARD_COND(rwsem_read, _try, down_read_trylock(_T))
-DEFINE_GUARD_COND(rwsem_read, _intr, down_read_interruptible(_T), _RET =3D=
=3D 0)
-
-DEFINE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up_write(_T=
))
-DEFINE_GUARD_COND(rwsem_write, _try, down_write_trylock(_T))
-DEFINE_GUARD_COND(rwsem_write, _kill, down_write_killable(_T), _RET =3D=3D 0)
+extern void up_write(struct rw_semaphore *sem) __releases(sem);
+
+DEFINE_LOCK_GUARD_1(rwsem_read, struct rw_semaphore, down_read(_T->lock), up=
_read(_T->lock))
+DEFINE_LOCK_GUARD_1_COND(rwsem_read, _try, down_read_trylock(_T->lock))
+DEFINE_LOCK_GUARD_1_COND(rwsem_read, _intr, down_read_interruptible(_T->lock=
), _RET =3D=3D 0)
+
+DECLARE_LOCK_GUARD_1_ATTRS(rwsem_read, __acquires_shared(_T), __releases_sha=
red(*(struct rw_semaphore **)_T))
+#define class_rwsem_read_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rwsem_read,=
 _T)
+DECLARE_LOCK_GUARD_1_ATTRS(rwsem_read_try, __acquires_shared(_T), __releases=
_shared(*(struct rw_semaphore **)_T))
+#define class_rwsem_read_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rwsem_r=
ead_try, _T)
+DECLARE_LOCK_GUARD_1_ATTRS(rwsem_read_intr, __acquires_shared(_T), __release=
s_shared(*(struct rw_semaphore **)_T))
+#define class_rwsem_read_intr_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rwsem_=
read_intr, _T)
+
+DEFINE_LOCK_GUARD_1(rwsem_write, struct rw_semaphore, down_write(_T->lock), =
up_write(_T->lock))
+DEFINE_LOCK_GUARD_1_COND(rwsem_write, _try, down_write_trylock(_T->lock))
+DEFINE_LOCK_GUARD_1_COND(rwsem_write, _kill, down_write_killable(_T->lock), =
_RET =3D=3D 0)
+
+DECLARE_LOCK_GUARD_1_ATTRS(rwsem_write, __acquires(_T), __releases(*(struct =
rw_semaphore **)_T))
+#define class_rwsem_write_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rwsem_writ=
e, _T)
+DECLARE_LOCK_GUARD_1_ATTRS(rwsem_write_try, __acquires(_T), __releases(*(str=
uct rw_semaphore **)_T))
+#define class_rwsem_write_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rwsem_=
write_try, _T)
+DECLARE_LOCK_GUARD_1_ATTRS(rwsem_write_kill, __acquires(_T), __releases(*(st=
ruct rw_semaphore **)_T))
+#define class_rwsem_write_kill_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rwsem=
_write_kill, _T)
=20
 /*
  * downgrade write lock to read lock
  */
-extern void downgrade_write(struct rw_semaphore *sem);
+extern void downgrade_write(struct rw_semaphore *sem) __releases(sem) __acqu=
ires_shared(sem);
=20
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /*
@@ -277,11 +299,11 @@ extern void downgrade_write(struct rw_semaphore *sem);
  * lockdep_set_class() at lock initialization time.
  * See Documentation/locking/lockdep-design.rst for more details.)
  */
-extern void down_read_nested(struct rw_semaphore *sem, int subclass);
-extern int __must_check down_read_killable_nested(struct rw_semaphore *sem, =
int subclass);
-extern void down_write_nested(struct rw_semaphore *sem, int subclass);
-extern int down_write_killable_nested(struct rw_semaphore *sem, int subclass=
);
-extern void _down_write_nest_lock(struct rw_semaphore *sem, struct lockdep_m=
ap *nest_lock);
+extern void down_read_nested(struct rw_semaphore *sem, int subclass) __acqui=
res_shared(sem);
+extern int __must_check down_read_killable_nested(struct rw_semaphore *sem, =
int subclass) __cond_acquires_shared(0, sem);
+extern void down_write_nested(struct rw_semaphore *sem, int subclass) __acqu=
ires(sem);
+extern int down_write_killable_nested(struct rw_semaphore *sem, int subclass=
) __cond_acquires(0, sem);
+extern void _down_write_nest_lock(struct rw_semaphore *sem, struct lockdep_m=
ap *nest_lock) __acquires(sem);
=20
 # define down_write_nest_lock(sem, nest_lock)			\
 do {								\
@@ -295,8 +317,8 @@ do {								\
  * [ This API should be avoided as much as possible - the
  *   proper abstraction for this case is completions. ]
  */
-extern void down_read_non_owner(struct rw_semaphore *sem);
-extern void up_read_non_owner(struct rw_semaphore *sem);
+extern void down_read_non_owner(struct rw_semaphore *sem) __acquires_shared(=
sem);
+extern void up_read_non_owner(struct rw_semaphore *sem) __releases_shared(se=
m);
 #else
 # define down_read_nested(sem, subclass)		down_read(sem)
 # define down_read_killable_nested(sem, subclass)	down_read_killable(sem)
diff --git a/lib/test_context-analysis.c b/lib/test_context-analysis.c
index 39e0379..1c96c56 100644
--- a/lib/test_context-analysis.c
+++ b/lib/test_context-analysis.c
@@ -8,6 +8,7 @@
 #include <linux/build_bug.h>
 #include <linux/mutex.h>
 #include <linux/rcupdate.h>
+#include <linux/rwsem.h>
 #include <linux/seqlock.h>
 #include <linux/spinlock.h>
 #include <linux/srcu.h>
@@ -262,6 +263,69 @@ static void __used test_seqlock_scoped(struct test_seqlo=
ck_data *d)
 	}
 }
=20
+struct test_rwsem_data {
+	struct rw_semaphore sem;
+	int counter __guarded_by(&sem);
+};
+
+static void __used test_rwsem_init(struct test_rwsem_data *d)
+{
+	init_rwsem(&d->sem);
+	d->counter =3D 0;
+}
+
+static void __used test_rwsem_reader(struct test_rwsem_data *d)
+{
+	down_read(&d->sem);
+	(void)d->counter;
+	up_read(&d->sem);
+
+	if (down_read_trylock(&d->sem)) {
+		(void)d->counter;
+		up_read(&d->sem);
+	}
+}
+
+static void __used test_rwsem_writer(struct test_rwsem_data *d)
+{
+	down_write(&d->sem);
+	d->counter++;
+	up_write(&d->sem);
+
+	down_write(&d->sem);
+	d->counter++;
+	downgrade_write(&d->sem);
+	(void)d->counter;
+	up_read(&d->sem);
+
+	if (down_write_trylock(&d->sem)) {
+		d->counter++;
+		up_write(&d->sem);
+	}
+}
+
+static void __used test_rwsem_assert(struct test_rwsem_data *d)
+{
+	rwsem_assert_held_nolockdep(&d->sem);
+	d->counter++;
+}
+
+static void __used test_rwsem_guard(struct test_rwsem_data *d)
+{
+	{ guard(rwsem_read)(&d->sem); (void)d->counter; }
+	{ guard(rwsem_write)(&d->sem); d->counter++; }
+}
+
+static void __used test_rwsem_cond_guard(struct test_rwsem_data *d)
+{
+	scoped_cond_guard(rwsem_read_try, return, &d->sem) {
+		(void)d->counter;
+	}
+	scoped_cond_guard(rwsem_write_try, return, &d->sem) {
+		d->counter++;
+	}
+}
+
 struct test_bit_spinlock_data {
 	unsigned long bits;
 	int counter __guarded_by(__bitlock(3, &bits));

