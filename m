Return-Path: <linux-tip-commits+bounces-8131-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MzKHbVoemmB5gEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8131-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 20:51:17 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C43A846F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 20:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96C013005ABE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 19:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42BD31A07C;
	Wed, 28 Jan 2026 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MtSSuvNI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mANWrHaq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529782D0600;
	Wed, 28 Jan 2026 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769629874; cv=none; b=pIffOkqGBILzoRSX8Gln/I6VUfkPE3aaaBira3DqjZK9ngDVYx4fZ7KtTcQ/LPqGQ9ObLhz71xMpcdCaoY5YDfGia047GdspMt1jx9DiEki1ey+37hNUe7XEaBZkVwbMD/RcHDtzNwO408UwACv7pnHWPHAWORaUPf/F1GuRQ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769629874; c=relaxed/simple;
	bh=zefbrObOEUlCEQ+urrRKF6ZdQVDqbSDlPiZjZhdgqJQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QrOll1TRWKJIqj5ZmZCzsG2B8zkrFZnaYFO7V9saiOgfa3sqTKHvlO/BtCJdA57bpEVm5KJrU4F/8eiAOD+03BRwr6Nvd5t9gRsBn6QL1Thqoz9fMKOosPcaK83I0s0zfvJE+ZhYfK520YdFIr399c68aZ/FhEPYpW2SVAvoNhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MtSSuvNI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mANWrHaq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Jan 2026 19:51:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769629871;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=omVUsr1DVfB6jHfgihsRQ4rnFhxbclT9Sr+Ka4jSB1I=;
	b=MtSSuvNIo2SW+tQwyOwpb7JFrGF5ZAP6jzeGUxWJw2McKbOTC6e2Es3ZskpUXyOxYFG+I7
	weUBeca4bUc2wfPdDosCEZHouzCRHYXEL5jV6Tiu43rW3F4YOK24rlvMHYrhpI7ph8WCIk
	Fxn0wHSgBiTJ3+MgBagzW7jPyHrK8xKxEauRhVYnLuUCnN2Q7O2Cgx3Ak1pXamgpAGKm3U
	AEQcAIq7u4ddKRz5q7iqqSzhERuk3LajJta+V14h36iLbaGLe86rS+/3b8abGPQbf79gSj
	nhNsm3LHsnJvmh6Tg+tD/ojNXDdP+/zOoBAdZyPwutGl65Qm3jCNfGFheZghRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769629871;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=omVUsr1DVfB6jHfgihsRQ4rnFhxbclT9Sr+Ka4jSB1I=;
	b=mANWrHaqDTAA6PC30FX380A++fLnC3/i3qeyjg72Blx4tKGcNYcqZLEnkhgVW8PY6/uhGW
	WA8u6QkCr4YnciCQ==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] compiler-context-analysis: Remove
 __assume_ctx_lock from initializers
Cc: Bart Van Assche <bvanassche@acm.org>, Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260119094029.1344361-7-elver@google.com>
References: <20260119094029.1344361-7-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176962986966.2495410.10080798648915884756.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8131-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 24C43A846F
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b682b70d016f6aee20d91dcbaa319a932008a83a
Gitweb:        https://git.kernel.org/tip/b682b70d016f6aee20d91dcbaa319a93200=
8a83a
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 19 Jan 2026 10:05:56 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 28 Jan 2026 20:45:25 +01:00

compiler-context-analysis: Remove __assume_ctx_lock from initializers

Remove __assume_ctx_lock() from lock initializers.

Implicitly asserting an active context during initialization caused
false-positive double-lock errors when acquiring a lock immediately after its
initialization. Moving forward, guarded member initialization must either:

	1. Use guard(type_init)(&lock) or scoped_guard(type_init, ...).
	2. Use context_unsafe() for simple initialization.

Reported-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/57062131-e79e-42c2-aa0b-8f931cb8cac2@acm.or=
g/
Link: https://patch.msgid.link/20260119094029.1344361-7-elver@google.com
---
 include/linux/local_lock_internal.h | 3 ---
 include/linux/mutex.h               | 1 -
 include/linux/rwlock.h              | 3 +--
 include/linux/rwlock_rt.h           | 1 -
 include/linux/rwsem.h               | 2 --
 include/linux/seqlock.h             | 1 -
 include/linux/spinlock.h            | 5 +----
 include/linux/spinlock_rt.h         | 1 -
 include/linux/ww_mutex.h            | 1 -
 lib/test_context-analysis.c         | 6 ------
 10 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_i=
nternal.h
index ed2f3fb..eff711b 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -87,13 +87,11 @@ do {								\
 			      0, LD_WAIT_CONFIG, LD_WAIT_INV,	\
 			      LD_LOCK_PERCPU);			\
 	local_lock_debug_init(lock);				\
-	__assume_ctx_lock(lock);				\
 } while (0)
=20
 #define __local_trylock_init(lock)				\
 do {								\
 	__local_lock_init((local_lock_t *)lock);		\
-	__assume_ctx_lock(lock);				\
 } while (0)
=20
 #define __spinlock_nested_bh_init(lock)				\
@@ -105,7 +103,6 @@ do {								\
 			      0, LD_WAIT_CONFIG, LD_WAIT_INV,	\
 			      LD_LOCK_NORMAL);			\
 	local_lock_debug_init(lock);				\
-	__assume_ctx_lock(lock);				\
 } while (0)
=20
 #define __local_lock_acquire(lock)					\
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 6b12009..ecaa044 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -62,7 +62,6 @@ do {									\
 	static struct lock_class_key __key;				\
 									\
 	__mutex_init((mutex), #mutex, &__key);				\
-	__assume_ctx_lock(mutex);					\
 } while (0)
=20
 /**
diff --git a/include/linux/rwlock.h b/include/linux/rwlock.h
index 65a5b55..3390d21 100644
--- a/include/linux/rwlock.h
+++ b/include/linux/rwlock.h
@@ -22,11 +22,10 @@ do {								\
 	static struct lock_class_key __key;			\
 								\
 	__rwlock_init((lock), #lock, &__key);			\
-	__assume_ctx_lock(lock);				\
 } while (0)
 #else
 # define rwlock_init(lock)					\
-	do { *(lock) =3D __RW_LOCK_UNLOCKED(lock); __assume_ctx_lock(lock); } while=
 (0)
+	do { *(lock) =3D __RW_LOCK_UNLOCKED(lock); } while (0)
 #endif
=20
 #ifdef CONFIG_DEBUG_SPINLOCK
diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
index 37b387d..5353abb 100644
--- a/include/linux/rwlock_rt.h
+++ b/include/linux/rwlock_rt.h
@@ -22,7 +22,6 @@ do {							\
 							\
 	init_rwbase_rt(&(rwl)->rwbase);			\
 	__rt_rwlock_init(rwl, #rwl, &__key);		\
-	__assume_ctx_lock(rwl);				\
 } while (0)
=20
 extern void rt_read_lock(rwlock_t *rwlock)	__acquires_shared(rwlock);
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index ea1bbdb..9bf1d93 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -121,7 +121,6 @@ do {								\
 	static struct lock_class_key __key;			\
 								\
 	__init_rwsem((sem), #sem, &__key);			\
-	__assume_ctx_lock(sem);					\
 } while (0)
=20
 /*
@@ -175,7 +174,6 @@ do {								\
 	static struct lock_class_key __key;			\
 								\
 	__init_rwsem((sem), #sem, &__key);			\
-	__assume_ctx_lock(sem);					\
 } while (0)
=20
 static __always_inline int rwsem_is_locked(const struct rw_semaphore *sem)
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 077c8d5..5a40252 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -817,7 +817,6 @@ static __always_inline void write_seqcount_latch_end(seqc=
ount_latch_t *s)
 	do {								\
 		spin_lock_init(&(sl)->lock);				\
 		seqcount_spinlock_init(&(sl)->seqcount, &(sl)->lock);	\
-		__assume_ctx_lock(sl);					\
 	} while (0)
=20
 /**
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 7b11991..e1e2f14 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -106,12 +106,11 @@ do {									\
 	static struct lock_class_key __key;				\
 									\
 	__raw_spin_lock_init((lock), #lock, &__key, LD_WAIT_SPIN);	\
-	__assume_ctx_lock(lock);					\
 } while (0)
=20
 #else
 # define raw_spin_lock_init(lock)				\
-	do { *(lock) =3D __RAW_SPIN_LOCK_UNLOCKED(lock); __assume_ctx_lock(lock); }=
 while (0)
+	do { *(lock) =3D __RAW_SPIN_LOCK_UNLOCKED(lock); } while (0)
 #endif
=20
 #define raw_spin_is_locked(lock)	arch_spin_is_locked(&(lock)->raw_lock)
@@ -324,7 +323,6 @@ do {								\
 								\
 	__raw_spin_lock_init(spinlock_check(lock),		\
 			     #lock, &__key, LD_WAIT_CONFIG);	\
-	__assume_ctx_lock(lock);				\
 } while (0)
=20
 #else
@@ -333,7 +331,6 @@ do {								\
 do {						\
 	spinlock_check(_lock);			\
 	*(_lock) =3D __SPIN_LOCK_UNLOCKED(_lock);	\
-	__assume_ctx_lock(_lock);		\
 } while (0)
=20
 #endif
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 0a58576..373618a 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -20,7 +20,6 @@ static inline void __rt_spin_lock_init(spinlock_t *lock, co=
nst char *name,
 do {								\
 	rt_mutex_base_init(&(slock)->lock);			\
 	__rt_spin_lock_init(slock, name, key, percpu);		\
-	__assume_ctx_lock(slock);				\
 } while (0)
=20
 #define _spin_lock_init(slock, percpu)				\
diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 58e959e..c47d4b9 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -107,7 +107,6 @@ context_lock_struct(ww_acquire_ctx) {
  */
 static inline void ww_mutex_init(struct ww_mutex *lock,
 				 struct ww_class *ww_class)
-	__assumes_ctx_lock(lock)
 {
 	ww_mutex_base_init(&lock->base, ww_class->mutex_name, &ww_class->mutex_key);
 	lock->ctx =3D NULL;
diff --git a/lib/test_context-analysis.c b/lib/test_context-analysis.c
index 0f05943..140efa8 100644
--- a/lib/test_context-analysis.c
+++ b/lib/test_context-analysis.c
@@ -542,12 +542,6 @@ struct test_ww_mutex_data {
 	int counter __guarded_by(&mtx);
 };
=20
-static void __used test_ww_mutex_init(struct test_ww_mutex_data *d)
-{
-	ww_mutex_init(&d->mtx, &ww_class);
-	d->counter =3D 0;
-}
-
 static void __used test_ww_mutex_lock_noctx(struct test_ww_mutex_data *d)
 {
 	if (!ww_mutex_lock(&d->mtx, NULL)) {

