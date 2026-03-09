Return-Path: <linux-tip-commits+bounces-8387-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLrvOCYkr2n6OQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8387-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:48:54 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADC92404F1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50D4C3028F66
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA2A413257;
	Mon,  9 Mar 2026 19:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QIXSaalH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JZ5VzGTH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25107410D21;
	Mon,  9 Mar 2026 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085707; cv=none; b=g/Yraw2BgmDxMm9AYcoi9FB2ydaglZCXPjZppMcXi9XnoNyuheea4VaEIdml77YtreZdtJA7n2Y49wH3FtKcKAZsL669va+lIayioK1UO+cbdBzYhSk/aDMUXLNGd4d5Bxpli9KxXPxJcshgx34TRCekhdKBGfEJiaxmwG+JhH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085707; c=relaxed/simple;
	bh=wwGVICHZnO2wdL4lr+av0ZG7sYpKip7FQUT5cN+U9WI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jnb1oVRV/TDbNwcBgajqGnD6+hzOd+VgReJJLIjYkS5UIHmEM+g3syWZq1rl5nm8/LbdNh0VEjack3Ta3dZ9kTn2N0HGD3ASAQ6qsEp4N/EjtVbAlNkTz/7dVyWIC3+YKCQPDlzNZFurh2qYGro/bepVUYHLGMYPYfPQgvi5vis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QIXSaalH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JZ5VzGTH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:48:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773085698;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ru3sPMReTgk81wtT1E3xeWmLvTAhIKDyA7/fPsGy+8=;
	b=QIXSaalH0Q5WHhzR0wCB4OTU507u5yMNywAVvw+JqZGpYuSgrRU+z1ALQ2AJoVziiav9/V
	s6dNLjlyc1vfT0bj8T0NAfUbRi3HNmZ5+76It8YpH2+vmSWPjIiDa4BzVqKL3A+fmBI69s
	/BbLt0MRB1ZkpB6/H9iptuqhwS/OdM40GXN4pYkdYc8tB99M09Ax6oYbX+b1rNZgC++kjj
	OYIYuKkXlvsnAI8CcEKo1KQ8YvUvKSgfgslh5bm142dy+sjOc6x4Mj6XEStFxQmhPmfPon
	Qd+yxpysJ+Caf2TeT+l0JgZ2vdnj0R03kSi+tRImjVpCVAPF1Uh5JAI5fQzWdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773085698;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ru3sPMReTgk81wtT1E3xeWmLvTAhIKDyA7/fPsGy+8=;
	b=JZ5VzGTHexnYUtJNVzWfLkPf/Zf0jIsWFhAxO7cgoPlxp3VQbBM0nRYE9nI3CaVzeF2NfZ
	JNqJJY0oYNSwGtDQ==
From: "tip-bot2 for Matthew Wilcox (Oracle)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] locking/mutex: Remove the list_head from struct mutex
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260305195545.3707590-4-willy@infradead.org>
References: <20260305195545.3707590-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308569716.1647592.1287546139273772330.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6ADC92404F1
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
	TAGGED_FROM(0.00)[bounces-8387-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,vger.kernel.org:replyto,linutronix.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
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
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     25500ba7e77ce9d3d9b5a1929d41a2ee2e23f6fe
Gitweb:        https://git.kernel.org/tip/25500ba7e77ce9d3d9b5a1929d41a2ee2e2=
3f6fe
Author:        Matthew Wilcox (Oracle) <willy@infradead.org>
AuthorDate:    Thu, 05 Mar 2026 19:55:43=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 08 Mar 2026 11:06:52 +01:00

locking/mutex: Remove the list_head from struct mutex

Instead of embedding a list_head in struct mutex, store a pointer to
the first waiter.  The list of waiters remains a doubly linked list so
we can efficiently add to the tail of the list, remove from the front
(or middle) of the list.

Some of the list manipulation becomes more complicated, but it's a
reasonable tradeoff on the slow paths to shrink data structures which
embed a mutex like struct file.

Some of the debug checks have to be deleted because there's no equivalent
to checking them in the new scheme (eg an empty waiter->list now means
that it is the only waiter, not that the waiter is no longer on the list).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260305195545.3707590-4-willy@infradead.org
---
 include/linux/mutex.h        |  2 +-
 include/linux/mutex_types.h  |  2 +-
 kernel/locking/mutex-debug.c |  5 +----
 kernel/locking/mutex.c       | 49 +++++++++++++++++++----------------
 kernel/locking/ww_mutex.h    | 25 +++++-------------
 5 files changed, 37 insertions(+), 46 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 2f648ee..c471b12 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -79,7 +79,7 @@ do {									\
 #define __MUTEX_INITIALIZER(lockname) \
 		{ .owner =3D ATOMIC_LONG_INIT(0) \
 		, .wait_lock =3D __RAW_SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
-		, .wait_list =3D LIST_HEAD_INIT(lockname.wait_list) \
+		, .first_waiter =3D NULL \
 		__DEBUG_MUTEX_INITIALIZER(lockname) \
 		__DEP_MAP_MUTEX_INITIALIZER(lockname) }
=20
diff --git a/include/linux/mutex_types.h b/include/linux/mutex_types.h
index 8097593..a8f119f 100644
--- a/include/linux/mutex_types.h
+++ b/include/linux/mutex_types.h
@@ -44,7 +44,7 @@ context_lock_struct(mutex) {
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
 	struct optimistic_spin_queue osq; /* Spinner MCS lock */
 #endif
-	struct list_head	wait_list;
+	struct mutex_waiter	*first_waiter;
 #ifdef CONFIG_DEBUG_MUTEXES
 	void			*magic;
 #endif
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index 2c6b02d..94930d5 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -37,9 +37,8 @@ void debug_mutex_lock_common(struct mutex *lock, struct mut=
ex_waiter *waiter)
 void debug_mutex_wake_waiter(struct mutex *lock, struct mutex_waiter *waiter)
 {
 	lockdep_assert_held(&lock->wait_lock);
-	DEBUG_LOCKS_WARN_ON(list_empty(&lock->wait_list));
+	DEBUG_LOCKS_WARN_ON(!lock->first_waiter);
 	DEBUG_LOCKS_WARN_ON(waiter->magic !=3D waiter);
-	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
 }
=20
 void debug_mutex_free_waiter(struct mutex_waiter *waiter)
@@ -62,7 +61,6 @@ void debug_mutex_remove_waiter(struct mutex *lock, struct m=
utex_waiter *waiter,
 {
 	struct mutex *blocked_on =3D __get_task_blocked_on(task);
=20
-	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
 	DEBUG_LOCKS_WARN_ON(waiter->task !=3D task);
 	DEBUG_LOCKS_WARN_ON(blocked_on && blocked_on !=3D lock);
=20
@@ -74,7 +72,6 @@ void debug_mutex_unlock(struct mutex *lock)
 {
 	if (likely(debug_locks)) {
 		DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock);
-		DEBUG_LOCKS_WARN_ON(!lock->wait_list.prev && !lock->wait_list.next);
 	}
 }
=20
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index c867f6c..95f1822 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -47,7 +47,7 @@ static void __mutex_init_generic(struct mutex *lock)
 {
 	atomic_long_set(&lock->owner, 0);
 	raw_spin_lock_init(&lock->wait_lock);
-	INIT_LIST_HEAD(&lock->wait_list);
+	lock->first_waiter =3D NULL;
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
 	osq_lock_init(&lock->osq);
 #endif
@@ -194,33 +194,42 @@ static inline void __mutex_clear_flag(struct mutex *loc=
k, unsigned long flag)
 	atomic_long_andnot(flag, &lock->owner);
 }
=20
-static inline bool __mutex_waiter_is_first(struct mutex *lock, struct mutex_=
waiter *waiter)
-{
-	return list_first_entry(&lock->wait_list, struct mutex_waiter, list) =3D=3D=
 waiter;
-}
-
 /*
  * Add @waiter to a given location in the lock wait_list and set the
  * FLAG_WAITERS flag if it's the first waiter.
  */
 static void
 __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
-		   struct list_head *list)
+		   struct mutex_waiter *first)
 {
 	hung_task_set_blocker(lock, BLOCKER_TYPE_MUTEX);
 	debug_mutex_add_waiter(lock, waiter, current);
=20
-	list_add_tail(&waiter->list, list);
-	if (__mutex_waiter_is_first(lock, waiter))
+	if (!first)
+		first =3D lock->first_waiter;
+
+	if (first) {
+		list_add_tail(&waiter->list, &first->list);
+	} else {
+		INIT_LIST_HEAD(&waiter->list);
+		lock->first_waiter =3D waiter;
 		__mutex_set_flag(lock, MUTEX_FLAG_WAITERS);
+	}
 }
=20
 static void
 __mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter)
 {
-	list_del(&waiter->list);
-	if (likely(list_empty(&lock->wait_list)))
+	if (list_empty(&waiter->list)) {
 		__mutex_clear_flag(lock, MUTEX_FLAGS);
+		lock->first_waiter =3D NULL;
+	} else {
+		if (lock->first_waiter =3D=3D waiter) {
+			lock->first_waiter =3D list_first_entry(&waiter->list,
+							      struct mutex_waiter, list);
+		}
+		list_del(&waiter->list);
+	}
=20
 	debug_mutex_remove_waiter(lock, waiter, current);
 	hung_task_clear_blocker();
@@ -340,7 +349,7 @@ bool ww_mutex_spin_on_owner(struct mutex *lock, struct ww=
_acquire_ctx *ww_ctx,
 	 * Similarly, stop spinning if we are no longer the
 	 * first waiter.
 	 */
-	if (waiter && !__mutex_waiter_is_first(lock, waiter))
+	if (waiter && lock->first_waiter !=3D waiter)
 		return false;
=20
 	return true;
@@ -645,7 +654,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int stat=
e, unsigned int subclas
=20
 	if (!use_ww_ctx) {
 		/* add waiting tasks to the end of the waitqueue (FIFO): */
-		__mutex_add_waiter(lock, &waiter, &lock->wait_list);
+		__mutex_add_waiter(lock, &waiter, NULL);
 	} else {
 		/*
 		 * Add in stamp order, waking up waiters that must kill
@@ -691,7 +700,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int stat=
e, unsigned int subclas
=20
 		schedule_preempt_disabled();
=20
-		first =3D __mutex_waiter_is_first(lock, &waiter);
+		first =3D lock->first_waiter =3D=3D &waiter;
=20
 		/*
 		 * As we likely have been woken up by task
@@ -734,8 +743,7 @@ acquired:
 		 * Wound-Wait; we stole the lock (!first_waiter), check the
 		 * waiters as anyone might want to wound us.
 		 */
-		if (!ww_ctx->is_wait_die &&
-		    !__mutex_waiter_is_first(lock, &waiter))
+		if (!ww_ctx->is_wait_die && lock->first_waiter !=3D &waiter)
 			__ww_mutex_check_waiters(lock, ww_ctx, &wake_q);
 	}
=20
@@ -931,6 +939,7 @@ EXPORT_SYMBOL_GPL(ww_mutex_lock_interruptible);
 static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, uns=
igned long ip)
 {
 	struct task_struct *next =3D NULL;
+	struct mutex_waiter *waiter;
 	DEFINE_WAKE_Q(wake_q);
 	unsigned long owner;
 	unsigned long flags;
@@ -962,12 +971,8 @@ static noinline void __sched __mutex_unlock_slowpath(str=
uct mutex *lock, unsigne
=20
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	debug_mutex_unlock(lock);
-	if (!list_empty(&lock->wait_list)) {
-		/* get the first entry from the wait-list: */
-		struct mutex_waiter *waiter =3D
-			list_first_entry(&lock->wait_list,
-					 struct mutex_waiter, list);
-
+	waiter =3D lock->first_waiter;
+	if (waiter) {
 		next =3D waiter->task;
=20
 		debug_mutex_wake_waiter(lock, waiter);
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 31a785a..a0847e9 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -8,20 +8,14 @@
 static inline struct mutex_waiter *
 __ww_waiter_first(struct mutex *lock)
 {
-	struct mutex_waiter *w;
-
-	w =3D list_first_entry(&lock->wait_list, struct mutex_waiter, list);
-	if (list_entry_is_head(w, &lock->wait_list, list))
-		return NULL;
-
-	return w;
+	return lock->first_waiter;
 }
=20
 static inline struct mutex_waiter *
 __ww_waiter_next(struct mutex *lock, struct mutex_waiter *w)
 {
 	w =3D list_next_entry(w, list);
-	if (list_entry_is_head(w, &lock->wait_list, list))
+	if (lock->first_waiter =3D=3D w)
 		return NULL;
=20
 	return w;
@@ -31,7 +25,7 @@ static inline struct mutex_waiter *
 __ww_waiter_prev(struct mutex *lock, struct mutex_waiter *w)
 {
 	w =3D list_prev_entry(w, list);
-	if (list_entry_is_head(w, &lock->wait_list, list))
+	if (lock->first_waiter =3D=3D w)
 		return NULL;
=20
 	return w;
@@ -40,22 +34,17 @@ __ww_waiter_prev(struct mutex *lock, struct mutex_waiter =
*w)
 static inline struct mutex_waiter *
 __ww_waiter_last(struct mutex *lock)
 {
-	struct mutex_waiter *w;
-
-	w =3D list_last_entry(&lock->wait_list, struct mutex_waiter, list);
-	if (list_entry_is_head(w, &lock->wait_list, list))
-		return NULL;
+	struct mutex_waiter *w =3D lock->first_waiter;
=20
+	if (w)
+		w =3D list_prev_entry(w, list);
 	return w;
 }
=20
 static inline void
 __ww_waiter_add(struct mutex *lock, struct mutex_waiter *waiter, struct mute=
x_waiter *pos)
 {
-	struct list_head *p =3D &lock->wait_list;
-	if (pos)
-		p =3D &pos->list;
-	__mutex_add_waiter(lock, waiter, p);
+	__mutex_add_waiter(lock, waiter, pos);
 }
=20
 static inline struct task_struct *

