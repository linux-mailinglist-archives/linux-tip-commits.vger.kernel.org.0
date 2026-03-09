Return-Path: <linux-tip-commits+bounces-8381-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMUuDQ0kr2n6OQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8381-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:48:29 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F6A2404DA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 09 Mar 2026 20:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2CCA300D905
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Mar 2026 19:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C81410D1F;
	Mon,  9 Mar 2026 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qVXib2SQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3rp02kSj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906F0325495;
	Mon,  9 Mar 2026 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085703; cv=none; b=ShiCp1QmmjMqn5qsoea8nPTszFpCy5Abph8rGaHoboSseO0+JbcwJv/3WA0Hkw04F3wq2nStIakAOn6Umuy7FpSHtMFqxBg3hwszoYCwGp3x8CtqJYc20k5IjPv5angWXIZuAAvXf/8+GNSV2H+4GaaGjEnG8/H7IKfMDt5qqJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085703; c=relaxed/simple;
	bh=xdjPI2GQ8o5sWfhKqaQni2ZkR3e3klhXGor7ylYkVag=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FpYCaBP5x9uHt/rs8iyhe/rBDpTGna6cl9ZkYhOKnKYvL3IHkofwbb2wcfhjM3BHMtGKfqYQdIT6Bawq6fPZbc4ZZSP9RFrf/JteAQZ29Z1q4dNnbJufIjO7Ulq3McwmIpdnlFh7TwpE6lzhH7COSvr3xt+iBoJsr3AlJL4PaTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qVXib2SQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3rp02kSj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Mar 2026 19:48:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773085694;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzvrE0xCyyig5ytyRoFVDDbebS9yA8pnooqtfZKGdTU=;
	b=qVXib2SQZapl9KPziVSIanSYhGEpGvkAHK18lKK32Fn41L0q4iaH8scFiOb9XZip4hgRwS
	/HA4pW79hUWsPTZNGgOKAgP5e9RhlX3eOyIQLWe0ERCwwj2O5FQPuJxxM3mbVWnZURN+GJ
	bB0xHNAKvuby+mYf4gXngIy2f6WYJf1Z9hRjqhWM0OECUwNLBxlcciwYPJXh5vFQ82JLTh
	7THZ3OrfTsrHD+IwIpW/Fu9jQowyvYCaFHUq3Qq7VLGdsVIdQbhuuVexti9QZYj+bYg6RL
	e+go8P1a6iSbeRwk2eejTY2vXxbonboY9jsX58j8d1oLEapmkCdS9JE8p+QC5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773085694;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzvrE0xCyyig5ytyRoFVDDbebS9yA8pnooqtfZKGdTU=;
	b=3rp02kSj1HvPpIcStYRcuWaWPYB9X+iNuwc1l39LbrqiDUSyHEr4yCYt7qzObiJHKhX4EF
	/bbuSw0uEvxjfnCg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Add context analysis
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260306101417.GT1282955@noisy.programming.kicks-ass.net>
References: <20260306101417.GT1282955@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177308569284.1647592.15809195949194510946.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A0F6A2404DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8381-lists,linux-tip-commits=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:replyto]
X-Rspamd-Action: no action

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     739690915ce1f017223ef4e6f3cc966ccfa3c861
Gitweb:        https://git.kernel.org/tip/739690915ce1f017223ef4e6f3cc966ccfa=
3c861
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 06 Mar 2026 10:43:56 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 08 Mar 2026 11:06:53 +01:00

locking/rwsem: Add context analysis

Add compiler context analysis annotations.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260306101417.GT1282955@noisy.programming.kic=
ks-ass.net
---
 include/linux/rwsem.h      |  4 ++--
 kernel/locking/Makefile    |  1 +
 kernel/locking/rwbase_rt.c |  1 +
 kernel/locking/rwsem.c     | 27 ++++++++++++++++++++++++---
 4 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index e782953..6a1a7ba 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -57,7 +57,7 @@ context_lock_struct(rw_semaphore) {
 	struct optimistic_spin_queue osq; /* spinner MCS lock */
 #endif
 	raw_spinlock_t wait_lock;
-	struct rwsem_waiter *first_waiter;
+	struct rwsem_waiter *first_waiter __guarded_by(&wait_lock);
 #ifdef CONFIG_DEBUG_RWSEMS
 	void *magic;
 #endif
@@ -131,7 +131,7 @@ do {								\
  */
 static inline bool rwsem_is_contended(struct rw_semaphore *sem)
 {
-	return sem->first_waiter !=3D NULL;
+	return data_race(sem->first_waiter !=3D NULL);
 }
=20
 #if defined(CONFIG_DEBUG_RWSEMS) || defined(CONFIG_DETECT_HUNG_TASK_BLOCKER)
diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 0c07de7..cee1901 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -6,6 +6,7 @@ KCOV_INSTRUMENT		:=3D n
 CONTEXT_ANALYSIS_mutex.o :=3D y
 CONTEXT_ANALYSIS_rtmutex_api.o :=3D y
 CONTEXT_ANALYSIS_ww_rt_mutex.o :=3D y
+CONTEXT_ANALYSIS_rwsem.o :=3D y
=20
 obj-y +=3D mutex.o semaphore.o rwsem.o percpu-rwsem.o
=20
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 9f4322c..82e078c 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -186,6 +186,7 @@ static __always_inline void rwbase_read_unlock(struct rwb=
ase_rt *rwb,
=20
 static inline void __rwbase_write_unlock(struct rwbase_rt *rwb, int bias,
 					 unsigned long flags)
+	__releases(&rwb->rtmutex.wait_lock)
 {
 	struct rt_mutex_base *rtm =3D &rwb->rtmutex;
=20
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index e66f37e..ba4cb74 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -72,7 +72,7 @@
 		#c, atomic_long_read(&(sem)->count),		\
 		(unsigned long) sem->magic,			\
 		atomic_long_read(&(sem)->owner), (long)current,	\
-		(sem)->first_waiter ? "" : "not "))		\
+		rwsem_is_contended(sem) ? "" : "not "))		\
 			debug_locks_off();			\
 	} while (0)
 #else
@@ -320,9 +320,10 @@ void __init_rwsem(struct rw_semaphore *sem, const char *=
name,
 	sem->magic =3D sem;
 #endif
 	atomic_long_set(&sem->count, RWSEM_UNLOCKED_VALUE);
-	raw_spin_lock_init(&sem->wait_lock);
-	sem->first_waiter =3D NULL;
 	atomic_long_set(&sem->owner, 0L);
+	scoped_guard (raw_spinlock_init, &sem->wait_lock) {
+		sem->first_waiter =3D NULL;
+	}
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	osq_lock_init(&sem->osq);
 #endif
@@ -365,6 +366,7 @@ enum rwsem_wake_type {
=20
 static inline
 bool __rwsem_del_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waite=
r)
+	__must_hold(&sem->wait_lock)
 {
 	if (list_empty(&waiter->list)) {
 		sem->first_waiter =3D NULL;
@@ -401,6 +403,7 @@ rwsem_del_waiter(struct rw_semaphore *sem, struct rwsem_w=
aiter *waiter)
 static inline
 struct rwsem_waiter *next_waiter(const struct rw_semaphore *sem,
 				 const struct rwsem_waiter *waiter)
+	__must_hold(&sem->wait_lock)
 {
 	struct rwsem_waiter *next =3D list_first_entry(&waiter->list,
 						     struct rwsem_waiter, list);
@@ -621,6 +624,7 @@ rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rw=
sem_waiter *waiter,
  */
 static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 					struct rwsem_waiter *waiter)
+	__must_hold(&sem->wait_lock)
 {
 	struct rwsem_waiter *first =3D sem->first_waiter;
 	long count, new;
@@ -1558,6 +1562,7 @@ static inline bool is_rwsem_reader_owned(struct rw_sema=
phore *sem)
  * lock for reading
  */
 void __sched down_read(struct rw_semaphore *sem)
+	__no_context_analysis
 {
 	might_sleep();
 	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
@@ -1567,6 +1572,7 @@ void __sched down_read(struct rw_semaphore *sem)
 EXPORT_SYMBOL(down_read);
=20
 int __sched down_read_interruptible(struct rw_semaphore *sem)
+	__no_context_analysis
 {
 	might_sleep();
 	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
@@ -1581,6 +1587,7 @@ int __sched down_read_interruptible(struct rw_semaphore=
 *sem)
 EXPORT_SYMBOL(down_read_interruptible);
=20
 int __sched down_read_killable(struct rw_semaphore *sem)
+	__no_context_analysis
 {
 	might_sleep();
 	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
@@ -1598,6 +1605,7 @@ EXPORT_SYMBOL(down_read_killable);
  * trylock for reading -- returns 1 if successful, 0 if contention
  */
 int down_read_trylock(struct rw_semaphore *sem)
+	__no_context_analysis
 {
 	int ret =3D __down_read_trylock(sem);
=20
@@ -1611,6 +1619,7 @@ EXPORT_SYMBOL(down_read_trylock);
  * lock for writing
  */
 void __sched down_write(struct rw_semaphore *sem)
+	__no_context_analysis
 {
 	might_sleep();
 	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
@@ -1622,6 +1631,7 @@ EXPORT_SYMBOL(down_write);
  * lock for writing
  */
 int __sched down_write_killable(struct rw_semaphore *sem)
+	__no_context_analysis
 {
 	might_sleep();
 	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
@@ -1640,6 +1650,7 @@ EXPORT_SYMBOL(down_write_killable);
  * trylock for writing -- returns 1 if successful, 0 if contention
  */
 int down_write_trylock(struct rw_semaphore *sem)
+	__no_context_analysis
 {
 	int ret =3D __down_write_trylock(sem);
=20
@@ -1654,6 +1665,7 @@ EXPORT_SYMBOL(down_write_trylock);
  * release a read lock
  */
 void up_read(struct rw_semaphore *sem)
+	__no_context_analysis
 {
 	rwsem_release(&sem->dep_map, _RET_IP_);
 	__up_read(sem);
@@ -1664,6 +1676,7 @@ EXPORT_SYMBOL(up_read);
  * release a write lock
  */
 void up_write(struct rw_semaphore *sem)
+	__no_context_analysis
 {
 	rwsem_release(&sem->dep_map, _RET_IP_);
 	__up_write(sem);
@@ -1674,6 +1687,7 @@ EXPORT_SYMBOL(up_write);
  * downgrade write lock to read lock
  */
 void downgrade_write(struct rw_semaphore *sem)
+	__no_context_analysis
 {
 	lock_downgrade(&sem->dep_map, _RET_IP_);
 	__downgrade_write(sem);
@@ -1683,6 +1697,7 @@ EXPORT_SYMBOL(downgrade_write);
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
=20
 void down_read_nested(struct rw_semaphore *sem, int subclass)
+	__no_context_analysis
 {
 	might_sleep();
 	rwsem_acquire_read(&sem->dep_map, subclass, 0, _RET_IP_);
@@ -1691,6 +1706,7 @@ void down_read_nested(struct rw_semaphore *sem, int sub=
class)
 EXPORT_SYMBOL(down_read_nested);
=20
 int down_read_killable_nested(struct rw_semaphore *sem, int subclass)
+	__no_context_analysis
 {
 	might_sleep();
 	rwsem_acquire_read(&sem->dep_map, subclass, 0, _RET_IP_);
@@ -1705,6 +1721,7 @@ int down_read_killable_nested(struct rw_semaphore *sem,=
 int subclass)
 EXPORT_SYMBOL(down_read_killable_nested);
=20
 void _down_write_nest_lock(struct rw_semaphore *sem, struct lockdep_map *nes=
t)
+	__no_context_analysis
 {
 	might_sleep();
 	rwsem_acquire_nest(&sem->dep_map, 0, 0, nest, _RET_IP_);
@@ -1713,6 +1730,7 @@ void _down_write_nest_lock(struct rw_semaphore *sem, st=
ruct lockdep_map *nest)
 EXPORT_SYMBOL(_down_write_nest_lock);
=20
 void down_read_non_owner(struct rw_semaphore *sem)
+	__no_context_analysis
 {
 	might_sleep();
 	__down_read(sem);
@@ -1727,6 +1745,7 @@ void down_read_non_owner(struct rw_semaphore *sem)
 EXPORT_SYMBOL(down_read_non_owner);
=20
 void down_write_nested(struct rw_semaphore *sem, int subclass)
+	__no_context_analysis
 {
 	might_sleep();
 	rwsem_acquire(&sem->dep_map, subclass, 0, _RET_IP_);
@@ -1735,6 +1754,7 @@ void down_write_nested(struct rw_semaphore *sem, int su=
bclass)
 EXPORT_SYMBOL(down_write_nested);
=20
 int __sched down_write_killable_nested(struct rw_semaphore *sem, int subclas=
s)
+	__no_context_analysis
 {
 	might_sleep();
 	rwsem_acquire(&sem->dep_map, subclass, 0, _RET_IP_);
@@ -1750,6 +1770,7 @@ int __sched down_write_killable_nested(struct rw_semaph=
ore *sem, int subclass)
 EXPORT_SYMBOL(down_write_killable_nested);
=20
 void up_read_non_owner(struct rw_semaphore *sem)
+	__no_context_analysis
 {
 	DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
 	__up_read(sem);

