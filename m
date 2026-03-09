Return-Path: <linux-tip-commits+bounces-8386-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KG3mJNgkr2mzOgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8386-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:51:52 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E81202405DB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D7BA30F97D1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7469410D1B;
	Mon,  9 Mar 2026 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZD6st7cB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="byJspxhA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BADB410D3E;
	Mon,  9 Mar 2026 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085706; cv=none; b=YF466GxFM7Q6yUtnfRPG0ttXCpAkocyzh6hzaFQVLokWa8jsMN3ki9JclKDFGUbVji1PZTIlutt5U2kZaFm3pbwQsi9LHqFmL78EdzEnHZ84sIHI7k0vfzIvziAJMizMIpimD62feL1CwV9def7EQZbVMk3RB/XILDETGwgztbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085706; c=relaxed/simple;
	bh=otSVAuHD1PoABZf8TTC2JXK9taHOw1UdsLaia0vn6v8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=npYuneRwGQJzGQZmS8CxFNlJtIvdV0ssRZhepmnvXAJvaY8xE5ikhyux/3bTYdLfF59C1gxVd3DKP81PbbEMKqV/R2iLw+ltQWI1sLyAjKhmHFvl36QnZQkd9OgG2Bi/TFuIwFHxK8S70En9iUYqbfPHT6arjC2ArqDeQ4Z/XWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZD6st7cB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=byJspxhA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:48:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773085700;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJCOxec8w5HsJDdx43KZ0QnbDzTosGK/H9ZNFn6iy8c=;
	b=ZD6st7cBkp+zO0omq3aqqlzYTqM/nBFo7w8yGdXvW8oOnBH1zbIbDR7Vg3obCo9Q/gHABg
	2uzHohIe2iGb8JOjGEZ/iPcZtQ2kVYwEQZWYPJ1foUVlgq/4ya2MR8M+pe0IeyWEirfc7K
	bLqFLFz59cDyW8kDelIghMYn0EZe4E1p9FAQoZvxfTgGgEX4hfuTvekqOCCPVbEVpnLZxF
	2bKyfquUMB6sRU5n6MOdOQeMqvWtoEoon8b33ZjyCRZGWnrqSqfYgvK4i/7Sm6MJBBIfwY
	5gkv7Nc6LegypbwUPPiGdaSU/1Jo0wJBLhrhw+GXyGBxpG2yeeV3SHG3eLTqeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773085700;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJCOxec8w5HsJDdx43KZ0QnbDzTosGK/H9ZNFn6iy8c=;
	b=byJspxhAcVDtR2SdgJBr9mw8xTXD3p77ECQHwy6U9LofzP5KeZacQ4M078XlmDv4ZfvGKp
	5zkwpAQzFyOsR2Ag==
From: "tip-bot2 for Matthew Wilcox (Oracle)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Remove the list_head from struct
 rw_semaphore
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260305195545.3707590-2-willy@infradead.org>
References: <20260305195545.3707590-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308569917.1647592.11202314620620940188.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E81202405DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8386-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,infradead.org:email,msgid.link:url,linutronix.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     1ea4b473504b6dc6a0d21c298519aff2d52433c9
Gitweb:        https://git.kernel.org/tip/1ea4b473504b6dc6a0d21c298519aff2d52=
433c9
Author:        Matthew Wilcox (Oracle) <willy@infradead.org>
AuthorDate:    Thu, 05 Mar 2026 19:55:41=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 08 Mar 2026 11:06:51 +01:00

locking/rwsem: Remove the list_head from struct rw_semaphore

Instead of embedding a list_head in struct rw_semaphore, store a pointer
to the first waiter.  The list of waiters remains a doubly linked list
so we can efficiently add to the tail of the list, remove from the front
(or middle) of the list.

Some of the list manipulation becomes more complicated, but it's a
reasonable tradeoff on the slow paths to shrink some core data structures
like struct inode.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260305195545.3707590-2-willy@infradead.org
---
 include/linux/rwsem.h  |  8 ++--
 kernel/locking/rwsem.c | 90 ++++++++++++++++++++++++++---------------
 2 files changed, 62 insertions(+), 36 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 9bf1d93..e782953 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -57,7 +57,7 @@ context_lock_struct(rw_semaphore) {
 	struct optimistic_spin_queue osq; /* spinner MCS lock */
 #endif
 	raw_spinlock_t wait_lock;
-	struct list_head wait_list;
+	struct rwsem_waiter *first_waiter;
 #ifdef CONFIG_DEBUG_RWSEMS
 	void *magic;
 #endif
@@ -106,7 +106,7 @@ static inline void rwsem_assert_held_write_nolockdep(cons=
t struct rw_semaphore *
 	  .owner =3D ATOMIC_LONG_INIT(0),				\
 	  __RWSEM_OPT_INIT(name)				\
 	  .wait_lock =3D __RAW_SPIN_LOCK_UNLOCKED(name.wait_lock),\
-	  .wait_list =3D LIST_HEAD_INIT((name).wait_list),	\
+	  .first_waiter =3D NULL,					\
 	  __RWSEM_DEBUG_INIT(name)				\
 	  __RWSEM_DEP_MAP_INIT(name) }
=20
@@ -129,9 +129,9 @@ do {								\
  * rwsem to see if somebody from an incompatible type is wanting access to t=
he
  * lock.
  */
-static inline int rwsem_is_contended(struct rw_semaphore *sem)
+static inline bool rwsem_is_contended(struct rw_semaphore *sem)
 {
-	return !list_empty(&sem->wait_list);
+	return sem->first_waiter !=3D NULL;
 }
=20
 #if defined(CONFIG_DEBUG_RWSEMS) || defined(CONFIG_DETECT_HUNG_TASK_BLOCKER)
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 24df4d9..e66f37e 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -72,7 +72,7 @@
 		#c, atomic_long_read(&(sem)->count),		\
 		(unsigned long) sem->magic,			\
 		atomic_long_read(&(sem)->owner), (long)current,	\
-		list_empty(&(sem)->wait_list) ? "" : "not "))	\
+		(sem)->first_waiter ? "" : "not "))		\
 			debug_locks_off();			\
 	} while (0)
 #else
@@ -321,7 +321,7 @@ void __init_rwsem(struct rw_semaphore *sem, const char *n=
ame,
 #endif
 	atomic_long_set(&sem->count, RWSEM_UNLOCKED_VALUE);
 	raw_spin_lock_init(&sem->wait_lock);
-	INIT_LIST_HEAD(&sem->wait_list);
+	sem->first_waiter =3D NULL;
 	atomic_long_set(&sem->owner, 0L);
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	osq_lock_init(&sem->osq);
@@ -341,8 +341,6 @@ struct rwsem_waiter {
 	unsigned long timeout;
 	bool handoff_set;
 };
-#define rwsem_first_waiter(sem) \
-	list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
=20
 enum rwsem_wake_type {
 	RWSEM_WAKE_ANY,		/* Wake whatever's at head of wait list */
@@ -365,12 +363,21 @@ enum rwsem_wake_type {
  */
 #define MAX_READERS_WAKEUP	0x100
=20
-static inline void
-rwsem_add_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
+static inline
+bool __rwsem_del_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waite=
r)
 {
-	lockdep_assert_held(&sem->wait_lock);
-	list_add_tail(&waiter->list, &sem->wait_list);
-	/* caller will set RWSEM_FLAG_WAITERS */
+	if (list_empty(&waiter->list)) {
+		sem->first_waiter =3D NULL;
+		return true;
+	}
+
+	if (sem->first_waiter =3D=3D waiter) {
+		sem->first_waiter =3D list_first_entry(&waiter->list,
+						     struct rwsem_waiter, list);
+	}
+	list_del(&waiter->list);
+
+	return false;
 }
=20
 /*
@@ -385,14 +392,23 @@ static inline bool
 rwsem_del_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
 {
 	lockdep_assert_held(&sem->wait_lock);
-	list_del(&waiter->list);
-	if (likely(!list_empty(&sem->wait_list)))
+	if (__rwsem_del_waiter(sem, waiter))
 		return true;
-
 	atomic_long_andnot(RWSEM_FLAG_HANDOFF | RWSEM_FLAG_WAITERS, &sem->count);
 	return false;
 }
=20
+static inline
+struct rwsem_waiter *next_waiter(const struct rw_semaphore *sem,
+				 const struct rwsem_waiter *waiter)
+{
+	struct rwsem_waiter *next =3D list_first_entry(&waiter->list,
+						     struct rwsem_waiter, list);
+	if (next =3D=3D sem->first_waiter)
+		return NULL;
+	return next;
+}
+
 /*
  * handle the lock release when processes blocked on it that can now run
  * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
@@ -411,7 +427,7 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 			    enum rwsem_wake_type wake_type,
 			    struct wake_q_head *wake_q)
 {
-	struct rwsem_waiter *waiter, *tmp;
+	struct rwsem_waiter *waiter, *next;
 	long oldcount, woken =3D 0, adjustment =3D 0;
 	struct list_head wlist;
=20
@@ -421,7 +437,7 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 	 * Take a peek at the queue head waiter such that we can determine
 	 * the wakeup(s) to perform.
 	 */
-	waiter =3D rwsem_first_waiter(sem);
+	waiter =3D sem->first_waiter;
=20
 	if (waiter->type =3D=3D RWSEM_WAITING_FOR_WRITE) {
 		if (wake_type =3D=3D RWSEM_WAKE_ANY) {
@@ -506,25 +522,28 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 	 *    put them into wake_q to be woken up later.
 	 */
 	INIT_LIST_HEAD(&wlist);
-	list_for_each_entry_safe(waiter, tmp, &sem->wait_list, list) {
+	do {
+		next =3D next_waiter(sem, waiter);
 		if (waiter->type =3D=3D RWSEM_WAITING_FOR_WRITE)
 			continue;
=20
 		woken++;
 		list_move_tail(&waiter->list, &wlist);
+		if (sem->first_waiter =3D=3D waiter)
+			sem->first_waiter =3D next;
=20
 		/*
 		 * Limit # of readers that can be woken up per wakeup call.
 		 */
 		if (unlikely(woken >=3D MAX_READERS_WAKEUP))
 			break;
-	}
+	} while ((waiter =3D next) !=3D NULL);
=20
 	adjustment =3D woken * RWSEM_READER_BIAS - adjustment;
 	lockevent_cond_inc(rwsem_wake_reader, woken);
=20
 	oldcount =3D atomic_long_read(&sem->count);
-	if (list_empty(&sem->wait_list)) {
+	if (!sem->first_waiter) {
 		/*
 		 * Combined with list_move_tail() above, this implies
 		 * rwsem_del_waiter().
@@ -545,7 +564,7 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 		atomic_long_add(adjustment, &sem->count);
=20
 	/* 2nd pass */
-	list_for_each_entry_safe(waiter, tmp, &wlist, list) {
+	list_for_each_entry_safe(waiter, next, &wlist, list) {
 		struct task_struct *tsk;
=20
 		tsk =3D waiter->task;
@@ -577,7 +596,7 @@ rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rw=
sem_waiter *waiter,
 		      struct wake_q_head *wake_q)
 		      __releases(&sem->wait_lock)
 {
-	bool first =3D rwsem_first_waiter(sem) =3D=3D waiter;
+	bool first =3D sem->first_waiter =3D=3D waiter;
=20
 	wake_q_init(wake_q);
=20
@@ -603,7 +622,7 @@ rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rw=
sem_waiter *waiter,
 static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 					struct rwsem_waiter *waiter)
 {
-	struct rwsem_waiter *first =3D rwsem_first_waiter(sem);
+	struct rwsem_waiter *first =3D sem->first_waiter;
 	long count, new;
=20
 	lockdep_assert_held(&sem->wait_lock);
@@ -639,7 +658,7 @@ static inline bool rwsem_try_write_lock(struct rw_semapho=
re *sem,
 			new |=3D RWSEM_WRITER_LOCKED;
 			new &=3D ~RWSEM_FLAG_HANDOFF;
=20
-			if (list_is_singular(&sem->wait_list))
+			if (list_empty(&first->list))
 				new &=3D ~RWSEM_FLAG_WAITERS;
 		}
 	} while (!atomic_long_try_cmpxchg_acquire(&sem->count, &count, new));
@@ -659,7 +678,8 @@ static inline bool rwsem_try_write_lock(struct rw_semapho=
re *sem,
 	 * Have rwsem_try_write_lock() fully imply rwsem_del_waiter() on
 	 * success.
 	 */
-	list_del(&waiter->list);
+	__rwsem_del_waiter(sem, waiter);
+
 	rwsem_set_owner(sem);
 	return true;
 }
@@ -994,7 +1014,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long =
count, unsigned int stat
 {
 	long adjustment =3D -RWSEM_READER_BIAS;
 	long rcnt =3D (count >> RWSEM_READER_SHIFT);
-	struct rwsem_waiter waiter;
+	struct rwsem_waiter waiter, *first;
 	DEFINE_WAKE_Q(wake_q);
=20
 	/*
@@ -1019,7 +1039,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long=
 count, unsigned int stat
 		 */
 		if ((rcnt =3D=3D 1) && (count & RWSEM_FLAG_WAITERS)) {
 			raw_spin_lock_irq(&sem->wait_lock);
-			if (!list_empty(&sem->wait_list))
+			if (sem->first_waiter)
 				rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED,
 						&wake_q);
 			raw_spin_unlock_irq(&sem->wait_lock);
@@ -1035,7 +1055,8 @@ queue:
 	waiter.handoff_set =3D false;
=20
 	raw_spin_lock_irq(&sem->wait_lock);
-	if (list_empty(&sem->wait_list)) {
+	first =3D sem->first_waiter;
+	if (!first) {
 		/*
 		 * In case the wait queue is empty and the lock isn't owned
 		 * by a writer, this reader can exit the slowpath and return
@@ -1051,8 +1072,11 @@ queue:
 			return sem;
 		}
 		adjustment +=3D RWSEM_FLAG_WAITERS;
+		INIT_LIST_HEAD(&waiter.list);
+		sem->first_waiter =3D &waiter;
+	} else {
+		list_add_tail(&waiter.list, &first->list);
 	}
-	rwsem_add_waiter(sem, &waiter);
=20
 	/* we're now waiting on the lock, but no longer actively locking */
 	count =3D atomic_long_add_return(adjustment, &sem->count);
@@ -1110,7 +1134,7 @@ out_nolock:
 static struct rw_semaphore __sched *
 rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 {
-	struct rwsem_waiter waiter;
+	struct rwsem_waiter waiter, *first;
 	DEFINE_WAKE_Q(wake_q);
=20
 	/* do optimistic spinning and steal lock if possible */
@@ -1129,10 +1153,10 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, i=
nt state)
 	waiter.handoff_set =3D false;
=20
 	raw_spin_lock_irq(&sem->wait_lock);
-	rwsem_add_waiter(sem, &waiter);
=20
-	/* we're now waiting on the lock */
-	if (rwsem_first_waiter(sem) !=3D &waiter) {
+	first =3D sem->first_waiter;
+	if (first) {
+		list_add_tail(&waiter.list, &first->list);
 		rwsem_cond_wake_waiter(sem, atomic_long_read(&sem->count),
 				       &wake_q);
 		if (!wake_q_empty(&wake_q)) {
@@ -1145,6 +1169,8 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int=
 state)
 			raw_spin_lock_irq(&sem->wait_lock);
 		}
 	} else {
+		INIT_LIST_HEAD(&waiter.list);
+		sem->first_waiter =3D &waiter;
 		atomic_long_or(RWSEM_FLAG_WAITERS, &sem->count);
 	}
=20
@@ -1218,7 +1244,7 @@ static struct rw_semaphore *rwsem_wake(struct rw_semaph=
ore *sem)
=20
 	raw_spin_lock_irqsave(&sem->wait_lock, flags);
=20
-	if (!list_empty(&sem->wait_list))
+	if (sem->first_waiter)
 		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
=20
 	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);
@@ -1239,7 +1265,7 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct=
 rw_semaphore *sem)
=20
 	raw_spin_lock_irqsave(&sem->wait_lock, flags);
=20
-	if (!list_empty(&sem->wait_list))
+	if (sem->first_waiter)
 		rwsem_mark_wake(sem, RWSEM_WAKE_READ_OWNED, &wake_q);
=20
 	raw_spin_unlock_irqrestore(&sem->wait_lock, flags);

