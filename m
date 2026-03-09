Return-Path: <linux-tip-commits+bounces-8383-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHBFObckr2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8383-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:51:19 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3252405AE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B06730E7C5E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1349A410D24;
	Mon,  9 Mar 2026 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NoFzPjTP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wEQRfjja"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B39410D0C;
	Mon,  9 Mar 2026 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085705; cv=none; b=cM5tWi2csEWN1nZe+M9luSzSUhpUPkciwtjkmWofQufj5qYqQ5bFuH5iw0u1BABm4Xg0hUybgqvzjpLqWdTCYLx4ctntUESeQAMiA2PylWvjzELkfWamhx5n6cq/Qq8p3TJmW6wgj0gaB+ugx1kqeRrXEN0cCNad1/r3xW9xonw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085705; c=relaxed/simple;
	bh=d0Ifv91RBsDsmmXs4pamooCNm43XByMBWyThifaiIHE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sObExrkBL3L9SkbFjsy/1gaOZaYr2n8D0atQMWUhOUUYsxpSL++hPHoJEdToM3RLfeFo0wgUuRmcALCl5KJ9FE+f9JovkmsqSBpBWk2OwDrByyxsRMwWmspxifzfWNze+qb8m6qDDUP/7Y8hrZVplq25zhXaB+QY0hKcs+L70aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NoFzPjTP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wEQRfjja; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:48:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773085696;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kfj2X6MBv8Gsiu9H9yQFY7xzxnAuHc2eAu4Ra1RQ970=;
	b=NoFzPjTPpjb72LTrD9THsDOjS45syG1uGi1bPbwsWRFyCG2z9uc5L03uTxJKHsHb55ZHbk
	MzJnMs/5ij9UXXcuw7L6hP2ovPtraZASdywVbW2M4O9arFDeYNpxsKuMSHWoXWCXDb+Sr8
	DXyddQVHcJT19rggvV5n19jSMO4rmC27KjmV0UKFJ+S0KUBSq7LK7t0t5OJ4z2nW/uESnO
	jQzVlVtYDiTZU9KqXPQqnETHEf+ElsiWxfxt+EY3Wwc1JCkiyn4XfJz20fVW9scsx7/R3P
	3/lMLqXArEknVKRtKVVcWgC4tgEninFJ9EHalkeDa+uFEjOHM/xJLjyrgtfd2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773085696;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kfj2X6MBv8Gsiu9H9yQFY7xzxnAuHc2eAu4Ra1RQ970=;
	b=wEQRfjjaVV0fuEaBWK3PIyojZifY1T1SMuBfWBWDBp2O1m9JT9Aa43WNMTh/1i+Fii31EJ
	nc1V29TUETwCO/Dw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/mutex: Add context analysis
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260121111213.745353747@infradead.org>
References: <20260121111213.745353747@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308569503.1647592.2609765035789352544.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7E3252405AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8383-lists,linux-tip-commits=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,infradead.org:email,msgid.link:url,linutronix.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5c4326231cde36fd5e90c41e403df9fac6238f4b
Gitweb:        https://git.kernel.org/tip/5c4326231cde36fd5e90c41e403df9fac62=
38f4b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 20 Jan 2026 10:06:08 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 08 Mar 2026 11:06:53 +01:00

locking/mutex: Add context analysis

Add compiler context analysis annotations.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260121111213.745353747@infradead.org
---
 include/linux/mutex.h       |  2 +-
 include/linux/mutex_types.h |  2 +-
 kernel/locking/Makefile     |  2 ++
 kernel/locking/mutex.c      | 33 ++++++++++++++++++++++++++++-----
 kernel/locking/mutex.h      |  1 +
 kernel/locking/ww_mutex.h   | 12 ++++++++++++
 6 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index c471b12..734048c 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -183,7 +183,7 @@ static inline int __must_check __devm_mutex_init(struct d=
evice *dev, struct mute
  */
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 extern void mutex_lock_nested(struct mutex *lock, unsigned int subclass) __a=
cquires(lock);
-extern void _mutex_lock_nest_lock(struct mutex *lock, struct lockdep_map *ne=
st_lock);
+extern void _mutex_lock_nest_lock(struct mutex *lock, struct lockdep_map *ne=
st_lock) __acquires(lock);
 extern int __must_check mutex_lock_interruptible_nested(struct mutex *lock,
 					unsigned int subclass) __cond_acquires(0, lock);
 extern int __must_check _mutex_lock_killable(struct mutex *lock,
diff --git a/include/linux/mutex_types.h b/include/linux/mutex_types.h
index a8f119f..24ed599 100644
--- a/include/linux/mutex_types.h
+++ b/include/linux/mutex_types.h
@@ -44,7 +44,7 @@ context_lock_struct(mutex) {
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
 	struct optimistic_spin_queue osq; /* Spinner MCS lock */
 #endif
-	struct mutex_waiter	*first_waiter;
+	struct mutex_waiter	*first_waiter __guarded_by(&wait_lock);
 #ifdef CONFIG_DEBUG_MUTEXES
 	void			*magic;
 #endif
diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index a114949..264447d 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -3,6 +3,8 @@
 # and is generally not a function of system call inputs.
 KCOV_INSTRUMENT		:=3D n
=20
+CONTEXT_ANALYSIS_mutex.o :=3D y
+
 obj-y +=3D mutex.o semaphore.o rwsem.o percpu-rwsem.o
=20
 # Avoid recursion lockdep -> sanitizer -> ... -> lockdep & improve performan=
ce.
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 95f1822..427187f 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -46,8 +46,9 @@
 static void __mutex_init_generic(struct mutex *lock)
 {
 	atomic_long_set(&lock->owner, 0);
-	raw_spin_lock_init(&lock->wait_lock);
-	lock->first_waiter =3D NULL;
+	scoped_guard (raw_spinlock_init, &lock->wait_lock) {
+		lock->first_waiter =3D NULL;
+	}
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
 	osq_lock_init(&lock->osq);
 #endif
@@ -150,6 +151,7 @@ EXPORT_SYMBOL(mutex_init_generic);
  * follow with a __mutex_trylock() before failing.
  */
 static __always_inline bool __mutex_trylock_fast(struct mutex *lock)
+	__cond_acquires(true, lock)
 {
 	unsigned long curr =3D (unsigned long)current;
 	unsigned long zero =3D 0UL;
@@ -163,6 +165,7 @@ static __always_inline bool __mutex_trylock_fast(struct m=
utex *lock)
 }
=20
 static __always_inline bool __mutex_unlock_fast(struct mutex *lock)
+	__cond_releases(true, lock)
 {
 	unsigned long curr =3D (unsigned long)current;
=20
@@ -201,6 +204,7 @@ static inline void __mutex_clear_flag(struct mutex *lock,=
 unsigned long flag)
 static void
 __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 		   struct mutex_waiter *first)
+	__must_hold(&lock->wait_lock)
 {
 	hung_task_set_blocker(lock, BLOCKER_TYPE_MUTEX);
 	debug_mutex_add_waiter(lock, waiter, current);
@@ -219,6 +223,7 @@ __mutex_add_waiter(struct mutex *lock, struct mutex_waite=
r *waiter,
=20
 static void
 __mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter)
+	__must_hold(&lock->wait_lock)
 {
 	if (list_empty(&waiter->list)) {
 		__mutex_clear_flag(lock, MUTEX_FLAGS);
@@ -268,7 +273,8 @@ static void __mutex_handoff(struct mutex *lock, struct ta=
sk_struct *task)
  * We also put the fastpath first in the kernel image, to make sure the
  * branch is predicted by the CPU as default-untaken.
  */
-static void __sched __mutex_lock_slowpath(struct mutex *lock);
+static void __sched __mutex_lock_slowpath(struct mutex *lock)
+	__acquires(lock);
=20
 /**
  * mutex_lock - acquire the mutex
@@ -349,7 +355,7 @@ bool ww_mutex_spin_on_owner(struct mutex *lock, struct ww=
_acquire_ctx *ww_ctx,
 	 * Similarly, stop spinning if we are no longer the
 	 * first waiter.
 	 */
-	if (waiter && lock->first_waiter !=3D waiter)
+	if (waiter && data_race(lock->first_waiter !=3D waiter))
 		return false;
=20
 	return true;
@@ -534,7 +540,8 @@ mutex_optimistic_spin(struct mutex *lock, struct ww_acqui=
re_ctx *ww_ctx,
 }
 #endif
=20
-static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, uns=
igned long ip);
+static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, uns=
igned long ip)
+	__releases(lock);
=20
 /**
  * mutex_unlock - release the mutex
@@ -574,6 +581,7 @@ EXPORT_SYMBOL(mutex_unlock);
  * of a unlocked mutex is not allowed.
  */
 void __sched ww_mutex_unlock(struct ww_mutex *lock)
+	__no_context_analysis
 {
 	__ww_mutex_unlock(lock);
 	mutex_unlock(&lock->base);
@@ -587,6 +595,7 @@ static __always_inline int __sched
 __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int sub=
class,
 		    struct lockdep_map *nest_lock, unsigned long ip,
 		    struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx)
+	__cond_acquires(0, lock)
 {
 	DEFINE_WAKE_Q(wake_q);
 	struct mutex_waiter waiter;
@@ -780,6 +789,7 @@ err_early_kill:
 static int __sched
 __mutex_lock(struct mutex *lock, unsigned int state, unsigned int subclass,
 	     struct lockdep_map *nest_lock, unsigned long ip)
+	__cond_acquires(0, lock)
 {
 	return __mutex_lock_common(lock, state, subclass, nest_lock, ip, NULL, fals=
e);
 }
@@ -787,6 +797,7 @@ __mutex_lock(struct mutex *lock, unsigned int state, unsi=
gned int subclass,
 static int __sched
 __ww_mutex_lock(struct mutex *lock, unsigned int state, unsigned int subclas=
s,
 		unsigned long ip, struct ww_acquire_ctx *ww_ctx)
+	__cond_acquires(0, lock)
 {
 	return __mutex_lock_common(lock, state, subclass, NULL, ip, ww_ctx, true);
 }
@@ -834,6 +845,7 @@ void __sched
 mutex_lock_nested(struct mutex *lock, unsigned int subclass)
 {
 	__mutex_lock(lock, TASK_UNINTERRUPTIBLE, subclass, NULL, _RET_IP_);
+	__acquire(lock);
 }
=20
 EXPORT_SYMBOL_GPL(mutex_lock_nested);
@@ -842,6 +854,7 @@ void __sched
 _mutex_lock_nest_lock(struct mutex *lock, struct lockdep_map *nest)
 {
 	__mutex_lock(lock, TASK_UNINTERRUPTIBLE, 0, nest, _RET_IP_);
+	__acquire(lock);
 }
 EXPORT_SYMBOL_GPL(_mutex_lock_nest_lock);
=20
@@ -870,12 +883,14 @@ mutex_lock_io_nested(struct mutex *lock, unsigned int s=
ubclass)
 	token =3D io_schedule_prepare();
 	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE,
 			    subclass, NULL, _RET_IP_, NULL, 0);
+	__acquire(lock);
 	io_schedule_finish(token);
 }
 EXPORT_SYMBOL_GPL(mutex_lock_io_nested);
=20
 static inline int
 ww_mutex_deadlock_injection(struct ww_mutex *lock, struct ww_acquire_ctx *ct=
x)
+	__cond_releases(nonzero, lock)
 {
 #ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH
 	unsigned tmp;
@@ -937,6 +952,7 @@ EXPORT_SYMBOL_GPL(ww_mutex_lock_interruptible);
  * Release the lock, slowpath:
  */
 static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, uns=
igned long ip)
+	__releases(lock)
 {
 	struct task_struct *next =3D NULL;
 	struct mutex_waiter *waiter;
@@ -945,6 +961,7 @@ static noinline void __sched __mutex_unlock_slowpath(stru=
ct mutex *lock, unsigne
 	unsigned long flags;
=20
 	mutex_release(&lock->dep_map, ip);
+	__release(lock);
=20
 	/*
 	 * Release the lock before (potentially) taking the spinlock such that
@@ -1066,24 +1083,29 @@ EXPORT_SYMBOL_GPL(mutex_lock_io);
=20
 static noinline void __sched
 __mutex_lock_slowpath(struct mutex *lock)
+	__acquires(lock)
 {
 	__mutex_lock(lock, TASK_UNINTERRUPTIBLE, 0, NULL, _RET_IP_);
+	__acquire(lock);
 }
=20
 static noinline int __sched
 __mutex_lock_killable_slowpath(struct mutex *lock)
+	__cond_acquires(0, lock)
 {
 	return __mutex_lock(lock, TASK_KILLABLE, 0, NULL, _RET_IP_);
 }
=20
 static noinline int __sched
 __mutex_lock_interruptible_slowpath(struct mutex *lock)
+	__cond_acquires(0, lock)
 {
 	return __mutex_lock(lock, TASK_INTERRUPTIBLE, 0, NULL, _RET_IP_);
 }
=20
 static noinline int __sched
 __ww_mutex_lock_slowpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
+	__cond_acquires(0, lock)
 {
 	return __ww_mutex_lock(&lock->base, TASK_UNINTERRUPTIBLE, 0,
 			       _RET_IP_, ctx);
@@ -1092,6 +1114,7 @@ __ww_mutex_lock_slowpath(struct ww_mutex *lock, struct =
ww_acquire_ctx *ctx)
 static noinline int __sched
 __ww_mutex_lock_interruptible_slowpath(struct ww_mutex *lock,
 					    struct ww_acquire_ctx *ctx)
+	__cond_acquires(0, lock)
 {
 	return __ww_mutex_lock(&lock->base, TASK_INTERRUPTIBLE, 0,
 			       _RET_IP_, ctx);
diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index 9ad4da8..b94ef40 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -7,6 +7,7 @@
  *  Copyright (C) 2004, 2005, 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.=
com>
  */
 #ifndef CONFIG_PREEMPT_RT
+#include <linux/mutex.h>
 /*
  * This is the control structure for tasks blocked on mutex, which resides
  * on the blocked task's kernel stack:
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index a0847e9..c50ea5d 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -7,12 +7,14 @@
=20
 static inline struct mutex_waiter *
 __ww_waiter_first(struct mutex *lock)
+	__must_hold(&lock->wait_lock)
 {
 	return lock->first_waiter;
 }
=20
 static inline struct mutex_waiter *
 __ww_waiter_next(struct mutex *lock, struct mutex_waiter *w)
+	__must_hold(&lock->wait_lock)
 {
 	w =3D list_next_entry(w, list);
 	if (lock->first_waiter =3D=3D w)
@@ -23,6 +25,7 @@ __ww_waiter_next(struct mutex *lock, struct mutex_waiter *w)
=20
 static inline struct mutex_waiter *
 __ww_waiter_prev(struct mutex *lock, struct mutex_waiter *w)
+	__must_hold(&lock->wait_lock)
 {
 	w =3D list_prev_entry(w, list);
 	if (lock->first_waiter =3D=3D w)
@@ -33,6 +36,7 @@ __ww_waiter_prev(struct mutex *lock, struct mutex_waiter *w)
=20
 static inline struct mutex_waiter *
 __ww_waiter_last(struct mutex *lock)
+	__must_hold(&lock->wait_lock)
 {
 	struct mutex_waiter *w =3D lock->first_waiter;
=20
@@ -43,6 +47,7 @@ __ww_waiter_last(struct mutex *lock)
=20
 static inline void
 __ww_waiter_add(struct mutex *lock, struct mutex_waiter *waiter, struct mute=
x_waiter *pos)
+	__must_hold(&lock->wait_lock)
 {
 	__mutex_add_waiter(lock, waiter, pos);
 }
@@ -60,16 +65,19 @@ __ww_mutex_has_waiters(struct mutex *lock)
 }
=20
 static inline void lock_wait_lock(struct mutex *lock, unsigned long *flags)
+	__acquires(&lock->wait_lock)
 {
 	raw_spin_lock_irqsave(&lock->wait_lock, *flags);
 }
=20
 static inline void unlock_wait_lock(struct mutex *lock, unsigned long *flags)
+	__releases(&lock->wait_lock)
 {
 	raw_spin_unlock_irqrestore(&lock->wait_lock, *flags);
 }
=20
 static inline void lockdep_assert_wait_lock_held(struct mutex *lock)
+	__must_hold(&lock->wait_lock)
 {
 	lockdep_assert_held(&lock->wait_lock);
 }
@@ -296,6 +304,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 			     struct ww_acquire_ctx *ww_ctx,
 			     struct ww_acquire_ctx *hold_ctx,
 			     struct wake_q_head *wake_q)
+	__must_hold(&lock->wait_lock)
 {
 	struct task_struct *owner =3D __ww_mutex_owner(lock);
=20
@@ -360,6 +369,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 static void
 __ww_mutex_check_waiters(struct MUTEX *lock, struct ww_acquire_ctx *ww_ctx,
 			 struct wake_q_head *wake_q)
+	__must_hold(&lock->wait_lock)
 {
 	struct MUTEX_WAITER *cur;
=20
@@ -453,6 +463,7 @@ __ww_mutex_kill(struct MUTEX *lock, struct ww_acquire_ctx=
 *ww_ctx)
 static inline int
 __ww_mutex_check_kill(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 		      struct ww_acquire_ctx *ctx)
+	__must_hold(&lock->wait_lock)
 {
 	struct ww_mutex *ww =3D container_of(lock, struct ww_mutex, base);
 	struct ww_acquire_ctx *hold_ctx =3D READ_ONCE(ww->ctx);
@@ -503,6 +514,7 @@ __ww_mutex_add_waiter(struct MUTEX_WAITER *waiter,
 		      struct MUTEX *lock,
 		      struct ww_acquire_ctx *ww_ctx,
 		      struct wake_q_head *wake_q)
+	__must_hold(&lock->wait_lock)
 {
 	struct MUTEX_WAITER *cur, *pos =3D NULL;
 	bool is_wait_die;

