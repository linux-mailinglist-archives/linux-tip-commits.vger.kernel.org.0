Return-Path: <linux-tip-commits+bounces-8382-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M46LrQkr2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8382-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:51:16 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB6A24059F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7D5030E5751
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9151A41160B;
	Mon,  9 Mar 2026 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aIJpcFsG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eTFery5T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57A13ED5B1;
	Mon,  9 Mar 2026 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085704; cv=none; b=s3JFoWLgLOQVomOpB7854aeWusTEVIo8ThWyPO8x88TuTpjioJ9m1QXhBV9orfsxQtNjLchP0b5KzCcDUNJfk1cgkPuVDz17yx07He/r7yCHr5F7/hg+EK7mkkx4zStx8/yVwXqgA/6iVtVI1Yz5g4h633i8T1f0oqVLXVWWtKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085704; c=relaxed/simple;
	bh=9i/0fHWKN1DZJyFIAJSZWq1U+XymF5uMs1jIhp1w/4Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rgN+niP3OdGELAfUflwi3tl4oDgXm9LNJ8kmnQCq1gER5q42PGe/DFQFggHdMJUiAVd/Af2ePbwgaZDQkMLO1HrBR5E6KnV9+E0SDd4kvx7+5cfa17xDLD/m0dW/7l7Sr/NsBz6I1qHj2J590BIegm6rgPgoyrmKzo1RKL/tgzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aIJpcFsG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eTFery5T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:48:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773085695;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lUwsD38s7b1qOESPZbnlyvbQlqi1IpDsc6ZIZSDWgBE=;
	b=aIJpcFsGL86AuvFKIHqFcYCytcBWABMwHE9DBhN41/ZWs6S3nph0SwOuXXqmz1QG3sHtAr
	Q6KK/Wuf1Qf4J0/thiennbC1hOYgEM1ZyMlniBuxjekobHzRj8UOKnSB0jbVNk5z8twpSW
	mnRRriq4YVCgSoxEFd/LE+tdVsm822bRASAghoIXPbQpqThZh2rI78HxVLmGyopaaAGN5N
	TaQL+KLbfXC33uunUkOYkqPLAcJgimeQOBoOb+QQTLLpTr3zlgQ1sPF5VdRG1zFJH1JfSh
	IWa8PnaEPvXo4VoymQhTl2RnCoVlNVRpcJW23pgtCu5wskz038tecg4uW7g68A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773085695;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lUwsD38s7b1qOESPZbnlyvbQlqi1IpDsc6ZIZSDWgBE=;
	b=eTFery5TY+zV5+VzkHXU7fiOoQjhICeqICo0dMJrqnq0T23nn9ZPvoOJyg2sPxg56veKdk
	gLbcHEs+Hr/Hc/Cg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Add context analysis
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260121111213.851599178@infradead.org>
References: <20260121111213.851599178@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308569394.1647592.2052093609083111395.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5FB6A24059F
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
	TAGGED_FROM(0.00)[bounces-8382-lists,linux-tip-commits=lfdr.de];
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

Commit-ID:     90bb681dcdf7e69c90b56a18f06c0389a0810b92
Gitweb:        https://git.kernel.org/tip/90bb681dcdf7e69c90b56a18f06c0389a08=
10b92
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 20 Jan 2026 18:17:50 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 08 Mar 2026 11:06:53 +01:00

locking/rtmutex: Add context analysis

Add compiler context analysis annotations.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260121111213.851599178@infradead.org
---
 include/linux/rtmutex.h                  |  8 +++----
 kernel/locking/Makefile                  |  2 ++-
 kernel/locking/rtmutex.c                 | 18 ++++++++++++++-
 kernel/locking/rtmutex_api.c             |  2 ++-
 kernel/locking/rtmutex_common.h          | 27 ++++++++++++++++-------
 kernel/locking/ww_mutex.h                | 20 ++++++++++++-----
 kernel/locking/ww_rt_mutex.c             |  1 +-
 scripts/context-analysis-suppression.txt |  1 +-
 8 files changed, 61 insertions(+), 18 deletions(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index ede4c6b..78e7e58 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -22,8 +22,8 @@ extern int max_lock_depth;
=20
 struct rt_mutex_base {
 	raw_spinlock_t		wait_lock;
-	struct rb_root_cached   waiters;
-	struct task_struct	*owner;
+	struct rb_root_cached   waiters __guarded_by(&wait_lock);
+	struct task_struct	*owner  __guarded_by(&wait_lock);
 };
=20
 #define __RT_MUTEX_BASE_INITIALIZER(rtbasename)				\
@@ -41,7 +41,7 @@ struct rt_mutex_base {
  */
 static inline bool rt_mutex_base_is_locked(struct rt_mutex_base *lock)
 {
-	return READ_ONCE(lock->owner) !=3D NULL;
+	return data_race(READ_ONCE(lock->owner) !=3D NULL);
 }
=20
 #ifdef CONFIG_RT_MUTEXES
@@ -49,7 +49,7 @@ static inline bool rt_mutex_base_is_locked(struct rt_mutex_=
base *lock)
=20
 static inline struct task_struct *rt_mutex_owner(struct rt_mutex_base *lock)
 {
-	unsigned long owner =3D (unsigned long) READ_ONCE(lock->owner);
+	unsigned long owner =3D (unsigned long) data_race(READ_ONCE(lock->owner));
=20
 	return (struct task_struct *) (owner & ~RT_MUTEX_HAS_WAITERS);
 }
diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 264447d..0c07de7 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -4,6 +4,8 @@
 KCOV_INSTRUMENT		:=3D n
=20
 CONTEXT_ANALYSIS_mutex.o :=3D y
+CONTEXT_ANALYSIS_rtmutex_api.o :=3D y
+CONTEXT_ANALYSIS_ww_rt_mutex.o :=3D y
=20
 obj-y +=3D mutex.o semaphore.o rwsem.o percpu-rwsem.o
=20
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index c80902e..ccaba61 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -94,6 +94,7 @@ static inline int __ww_mutex_check_kill(struct rt_mutex *lo=
ck,
=20
 static __always_inline struct task_struct *
 rt_mutex_owner_encode(struct rt_mutex_base *lock, struct task_struct *owner)
+	__must_hold(&lock->wait_lock)
 {
 	unsigned long val =3D (unsigned long)owner;
=20
@@ -105,6 +106,7 @@ rt_mutex_owner_encode(struct rt_mutex_base *lock, struct =
task_struct *owner)
=20
 static __always_inline void
 rt_mutex_set_owner(struct rt_mutex_base *lock, struct task_struct *owner)
+	__must_hold(&lock->wait_lock)
 {
 	/*
 	 * lock->wait_lock is held but explicit acquire semantics are needed
@@ -114,12 +116,14 @@ rt_mutex_set_owner(struct rt_mutex_base *lock, struct t=
ask_struct *owner)
 }
=20
 static __always_inline void rt_mutex_clear_owner(struct rt_mutex_base *lock)
+	__must_hold(&lock->wait_lock)
 {
 	/* lock->wait_lock is held so the unlock provides release semantics. */
 	WRITE_ONCE(lock->owner, rt_mutex_owner_encode(lock, NULL));
 }
=20
 static __always_inline void clear_rt_mutex_waiters(struct rt_mutex_base *loc=
k)
+	__must_hold(&lock->wait_lock)
 {
 	lock->owner =3D (struct task_struct *)
 			((unsigned long)lock->owner & ~RT_MUTEX_HAS_WAITERS);
@@ -127,6 +131,7 @@ static __always_inline void clear_rt_mutex_waiters(struct=
 rt_mutex_base *lock)
=20
 static __always_inline void
 fixup_rt_mutex_waiters(struct rt_mutex_base *lock, bool acquire_lock)
+	__must_hold(&lock->wait_lock)
 {
 	unsigned long owner, *p =3D (unsigned long *) &lock->owner;
=20
@@ -328,6 +333,7 @@ static __always_inline bool rt_mutex_cmpxchg_release(stru=
ct rt_mutex_base *lock,
 }
=20
 static __always_inline void mark_rt_mutex_waiters(struct rt_mutex_base *lock)
+	__must_hold(&lock->wait_lock)
 {
 	lock->owner =3D (struct task_struct *)
 			((unsigned long)lock->owner | RT_MUTEX_HAS_WAITERS);
@@ -1206,6 +1212,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mu=
tex_base *lock,
 					   struct ww_acquire_ctx *ww_ctx,
 					   enum rtmutex_chainwalk chwalk,
 					   struct wake_q_head *wake_q)
+	__must_hold(&lock->wait_lock)
 {
 	struct task_struct *owner =3D rt_mutex_owner(lock);
 	struct rt_mutex_waiter *top_waiter =3D waiter;
@@ -1249,6 +1256,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mu=
tex_base *lock,
=20
 		/* Check whether the waiter should back out immediately */
 		rtm =3D container_of(lock, struct rt_mutex, rtmutex);
+		__assume_ctx_lock(&rtm->rtmutex.wait_lock);
 		res =3D __ww_mutex_add_waiter(waiter, rtm, ww_ctx, wake_q);
 		if (res) {
 			raw_spin_lock(&task->pi_lock);
@@ -1356,6 +1364,7 @@ static void __sched mark_wakeup_next_waiter(struct rt_w=
ake_q_head *wqh,
 }
=20
 static int __sched __rt_mutex_slowtrylock(struct rt_mutex_base *lock)
+	__must_hold(&lock->wait_lock)
 {
 	int ret =3D try_to_take_rt_mutex(lock, current, NULL);
=20
@@ -1505,7 +1514,7 @@ static bool rtmutex_spin_on_owner(struct rt_mutex_base =
*lock,
 		 *  - the VCPU on which owner runs is preempted
 		 */
 		if (!owner_on_cpu(owner) || need_resched() ||
-		    !rt_mutex_waiter_is_top_waiter(lock, waiter)) {
+		    !data_race(rt_mutex_waiter_is_top_waiter(lock, waiter))) {
 			res =3D false;
 			break;
 		}
@@ -1538,6 +1547,7 @@ static bool rtmutex_spin_on_owner(struct rt_mutex_base =
*lock,
  */
 static void __sched remove_waiter(struct rt_mutex_base *lock,
 				  struct rt_mutex_waiter *waiter)
+	__must_hold(&lock->wait_lock)
 {
 	bool is_top_waiter =3D (waiter =3D=3D rt_mutex_top_waiter(lock));
 	struct task_struct *owner =3D rt_mutex_owner(lock);
@@ -1613,6 +1623,8 @@ static int __sched rt_mutex_slowlock_block(struct rt_mu=
tex_base *lock,
 	struct task_struct *owner;
 	int ret =3D 0;
=20
+	__assume_ctx_lock(&rtm->rtmutex.wait_lock);
+
 	lockevent_inc(rtmutex_slow_block);
 	for (;;) {
 		/* Try to acquire the lock: */
@@ -1658,6 +1670,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_mu=
tex_base *lock,
 static void __sched rt_mutex_handle_deadlock(int res, int detect_deadlock,
 					     struct rt_mutex_base *lock,
 					     struct rt_mutex_waiter *w)
+	__must_hold(&lock->wait_lock)
 {
 	/*
 	 * If the result is not -EDEADLOCK or the caller requested
@@ -1694,11 +1707,13 @@ static int __sched __rt_mutex_slowlock(struct rt_mute=
x_base *lock,
 				       enum rtmutex_chainwalk chwalk,
 				       struct rt_mutex_waiter *waiter,
 				       struct wake_q_head *wake_q)
+	__must_hold(&lock->wait_lock)
 {
 	struct rt_mutex *rtm =3D container_of(lock, struct rt_mutex, rtmutex);
 	struct ww_mutex *ww =3D ww_container_of(rtm);
 	int ret;
=20
+	__assume_ctx_lock(&rtm->rtmutex.wait_lock);
 	lockdep_assert_held(&lock->wait_lock);
 	lockevent_inc(rtmutex_slowlock);
=20
@@ -1750,6 +1765,7 @@ static inline int __rt_mutex_slowlock_locked(struct rt_=
mutex_base *lock,
 					     struct ww_acquire_ctx *ww_ctx,
 					     unsigned int state,
 					     struct wake_q_head *wake_q)
+	__must_hold(&lock->wait_lock)
 {
 	struct rt_mutex_waiter waiter;
 	int ret;
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 59dbd29..124219a 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -526,6 +526,7 @@ static __always_inline int __mutex_lock_common(struct mut=
ex *lock,
 					       unsigned int subclass,
 					       struct lockdep_map *nest_lock,
 					       unsigned long ip)
+	__acquires(lock) __no_context_analysis
 {
 	int ret;
=20
@@ -647,6 +648,7 @@ EXPORT_SYMBOL(mutex_trylock);
 #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
=20
 void __sched mutex_unlock(struct mutex *lock)
+	__releases(lock) __no_context_analysis
 {
 	mutex_release(&lock->dep_map, _RET_IP_);
 	__rt_mutex_unlock(&lock->rtmutex);
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index cf6ddd1..c38b7bd 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -79,12 +79,18 @@ struct rt_wake_q_head {
  * PI-futex support (proxy locking functions, etc.):
  */
 extern void rt_mutex_init_proxy_locked(struct rt_mutex_base *lock,
-				       struct task_struct *proxy_owner);
-extern void rt_mutex_proxy_unlock(struct rt_mutex_base *lock);
+				       struct task_struct *proxy_owner)
+	__must_hold(&lock->wait_lock);
+
+extern void rt_mutex_proxy_unlock(struct rt_mutex_base *lock)
+	__must_hold(&lock->wait_lock);
+
 extern int __rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
 				     struct rt_mutex_waiter *waiter,
 				     struct task_struct *task,
-				     struct wake_q_head *);
+				     struct wake_q_head *)
+	__must_hold(&lock->wait_lock);
+
 extern int rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
 				     struct rt_mutex_waiter *waiter,
 				     struct task_struct *task);
@@ -94,8 +100,9 @@ extern int rt_mutex_wait_proxy_lock(struct rt_mutex_base *=
lock,
 extern bool rt_mutex_cleanup_proxy_lock(struct rt_mutex_base *lock,
 				 struct rt_mutex_waiter *waiter);
=20
-extern int rt_mutex_futex_trylock(struct rt_mutex_base *l);
-extern int __rt_mutex_futex_trylock(struct rt_mutex_base *l);
+extern int rt_mutex_futex_trylock(struct rt_mutex_base *lock);
+extern int __rt_mutex_futex_trylock(struct rt_mutex_base *lock)
+	__must_hold(&lock->wait_lock);
=20
 extern void rt_mutex_futex_unlock(struct rt_mutex_base *lock);
 extern bool __rt_mutex_futex_unlock(struct rt_mutex_base *lock,
@@ -109,6 +116,7 @@ extern void rt_mutex_postunlock(struct rt_wake_q_head *wq=
h);
  */
 #ifdef CONFIG_RT_MUTEXES
 static inline int rt_mutex_has_waiters(struct rt_mutex_base *lock)
+	__must_hold(&lock->wait_lock)
 {
 	return !RB_EMPTY_ROOT(&lock->waiters.rb_root);
 }
@@ -120,6 +128,7 @@ static inline int rt_mutex_has_waiters(struct rt_mutex_ba=
se *lock)
  */
 static inline bool rt_mutex_waiter_is_top_waiter(struct rt_mutex_base *lock,
 						 struct rt_mutex_waiter *waiter)
+	__must_hold(&lock->wait_lock)
 {
 	struct rb_node *leftmost =3D rb_first_cached(&lock->waiters);
=20
@@ -127,6 +136,7 @@ static inline bool rt_mutex_waiter_is_top_waiter(struct r=
t_mutex_base *lock,
 }
=20
 static inline struct rt_mutex_waiter *rt_mutex_top_waiter(struct rt_mutex_ba=
se *lock)
+	__must_hold(&lock->wait_lock)
 {
 	struct rb_node *leftmost =3D rb_first_cached(&lock->waiters);
 	struct rt_mutex_waiter *w =3D NULL;
@@ -170,9 +180,10 @@ enum rtmutex_chainwalk {
=20
 static inline void __rt_mutex_base_init(struct rt_mutex_base *lock)
 {
-	raw_spin_lock_init(&lock->wait_lock);
-	lock->waiters =3D RB_ROOT_CACHED;
-	lock->owner =3D NULL;
+	scoped_guard (raw_spinlock_init, &lock->wait_lock) {
+		lock->waiters =3D RB_ROOT_CACHED;
+		lock->owner =3D NULL;
+	}
 }
=20
 /* Debug functions */
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index c50ea5d..b1834ab 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -4,6 +4,7 @@
=20
 #define MUTEX		mutex
 #define MUTEX_WAITER	mutex_waiter
+#define WAIT_LOCK	wait_lock
=20
 static inline struct mutex_waiter *
 __ww_waiter_first(struct mutex *lock)
@@ -86,9 +87,11 @@ static inline void lockdep_assert_wait_lock_held(struct mu=
tex *lock)
=20
 #define MUTEX		rt_mutex
 #define MUTEX_WAITER	rt_mutex_waiter
+#define WAIT_LOCK	rtmutex.wait_lock
=20
 static inline struct rt_mutex_waiter *
 __ww_waiter_first(struct rt_mutex *lock)
+	__must_hold(&lock->rtmutex.wait_lock)
 {
 	struct rb_node *n =3D rb_first(&lock->rtmutex.waiters.rb_root);
 	if (!n)
@@ -116,6 +119,7 @@ __ww_waiter_prev(struct rt_mutex *lock, struct rt_mutex_w=
aiter *w)
=20
 static inline struct rt_mutex_waiter *
 __ww_waiter_last(struct rt_mutex *lock)
+	__must_hold(&lock->rtmutex.wait_lock)
 {
 	struct rb_node *n =3D rb_last(&lock->rtmutex.waiters.rb_root);
 	if (!n)
@@ -137,21 +141,25 @@ __ww_mutex_owner(struct rt_mutex *lock)
=20
 static inline bool
 __ww_mutex_has_waiters(struct rt_mutex *lock)
+	__must_hold(&lock->rtmutex.wait_lock)
 {
 	return rt_mutex_has_waiters(&lock->rtmutex);
 }
=20
 static inline void lock_wait_lock(struct rt_mutex *lock, unsigned long *flag=
s)
+	__acquires(&lock->rtmutex.wait_lock)
 {
 	raw_spin_lock_irqsave(&lock->rtmutex.wait_lock, *flags);
 }
=20
 static inline void unlock_wait_lock(struct rt_mutex *lock, unsigned long *fl=
ags)
+	__releases(&lock->rtmutex.wait_lock)
 {
 	raw_spin_unlock_irqrestore(&lock->rtmutex.wait_lock, *flags);
 }
=20
 static inline void lockdep_assert_wait_lock_held(struct rt_mutex *lock)
+	__must_hold(&lock->rtmutex.wait_lock)
 {
 	lockdep_assert_held(&lock->rtmutex.wait_lock);
 }
@@ -304,7 +312,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 			     struct ww_acquire_ctx *ww_ctx,
 			     struct ww_acquire_ctx *hold_ctx,
 			     struct wake_q_head *wake_q)
-	__must_hold(&lock->wait_lock)
+	__must_hold(&lock->WAIT_LOCK)
 {
 	struct task_struct *owner =3D __ww_mutex_owner(lock);
=20
@@ -369,7 +377,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 static void
 __ww_mutex_check_waiters(struct MUTEX *lock, struct ww_acquire_ctx *ww_ctx,
 			 struct wake_q_head *wake_q)
-	__must_hold(&lock->wait_lock)
+	__must_hold(&lock->WAIT_LOCK)
 {
 	struct MUTEX_WAITER *cur;
=20
@@ -396,6 +404,7 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, stru=
ct ww_acquire_ctx *ctx)
 {
 	DEFINE_WAKE_Q(wake_q);
 	unsigned long flags;
+	bool has_waiters;
=20
 	ww_mutex_lock_acquired(lock, ctx);
=20
@@ -417,7 +426,8 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, stru=
ct ww_acquire_ctx *ctx)
 	 * __ww_mutex_add_waiter() and makes sure we either observe ww->ctx
 	 * and/or !empty list.
 	 */
-	if (likely(!__ww_mutex_has_waiters(&lock->base)))
+	has_waiters =3D data_race(__ww_mutex_has_waiters(&lock->base));
+	if (likely(!has_waiters))
 		return;
=20
 	/*
@@ -463,7 +473,7 @@ __ww_mutex_kill(struct MUTEX *lock, struct ww_acquire_ctx=
 *ww_ctx)
 static inline int
 __ww_mutex_check_kill(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 		      struct ww_acquire_ctx *ctx)
-	__must_hold(&lock->wait_lock)
+	__must_hold(&lock->WAIT_LOCK)
 {
 	struct ww_mutex *ww =3D container_of(lock, struct ww_mutex, base);
 	struct ww_acquire_ctx *hold_ctx =3D READ_ONCE(ww->ctx);
@@ -514,7 +524,7 @@ __ww_mutex_add_waiter(struct MUTEX_WAITER *waiter,
 		      struct MUTEX *lock,
 		      struct ww_acquire_ctx *ww_ctx,
 		      struct wake_q_head *wake_q)
-	__must_hold(&lock->wait_lock)
+	__must_hold(&lock->WAIT_LOCK)
 {
 	struct MUTEX_WAITER *cur, *pos =3D NULL;
 	bool is_wait_die;
diff --git a/kernel/locking/ww_rt_mutex.c b/kernel/locking/ww_rt_mutex.c
index c7196de..e07fb3b 100644
--- a/kernel/locking/ww_rt_mutex.c
+++ b/kernel/locking/ww_rt_mutex.c
@@ -90,6 +90,7 @@ ww_mutex_lock_interruptible(struct ww_mutex *lock, struct w=
w_acquire_ctx *ctx)
 EXPORT_SYMBOL(ww_mutex_lock_interruptible);
=20
 void __sched ww_mutex_unlock(struct ww_mutex *lock)
+	__no_context_analysis
 {
 	struct rt_mutex *rtm =3D &lock->base;
=20
diff --git a/scripts/context-analysis-suppression.txt b/scripts/context-analy=
sis-suppression.txt
index fd8951d..1c51b61 100644
--- a/scripts/context-analysis-suppression.txt
+++ b/scripts/context-analysis-suppression.txt
@@ -24,6 +24,7 @@ src:*include/linux/mutex*.h=3Demit
 src:*include/linux/rcupdate.h=3Demit
 src:*include/linux/refcount.h=3Demit
 src:*include/linux/rhashtable.h=3Demit
+src:*include/linux/rtmutex*.h=3Demit
 src:*include/linux/rwlock*.h=3Demit
 src:*include/linux/rwsem.h=3Demit
 src:*include/linux/sched*=3Demit

