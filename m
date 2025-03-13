Return-Path: <linux-tip-commits+bounces-4186-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7296A5F270
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 12:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6775119C12F1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 11:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFE72676E3;
	Thu, 13 Mar 2025 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wufPDROj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gj5WnBWG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED40266F1F;
	Thu, 13 Mar 2025 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865492; cv=none; b=JsK21c2IONvURW6iGaam9k3S8jgf/SkLluxHz2owYOLRGCiIdpFnVuGU2F6WInsLTpqps7Q85adNt2+Ljt3Ph7qsIxWFHznOJo40ND9h79gzs9JeBcfmLB3dE5cScY0Gb2ZeXeSAk6VUy8qKVhlD4kOO8i9HUWFNkPTBR1P4/l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865492; c=relaxed/simple;
	bh=PrGuERAlH8UHNZFrtRaqY6lN+XLvsTE9oD1x8SVsKWs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hUkbUyOZ2Xr4GxRPFFos03b148hsRfOe4y5XRBdO51M8aPjEPx5WJw7Vw2zIj8vP/p1B7WtGPcxRsy1LReHtLx5mWyns0IE2UOIUgNY4qe5SfT7k4k6lkxMIQGF/EoW/4Jd50Kq/htZaCZrPn25wBYQtfhQzPrl1an6ex+BrXKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wufPDROj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gj5WnBWG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 11:31:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741865488;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vDqqyRABThchE09zdcKgwPrv1SPksWgjEOAqrNzh+UI=;
	b=wufPDROjzp3GU+YWMk5/8jcilJ2Z5duhFCWMe1xYA6KYRCeHv/iqbJfuNYgJtPKQCgeo03
	B0nXcffJyyQua5H9w+HcXXrNXvaWoINQ+WPg0tScUFrUKXJLBtQ2mg0CVpgw63R2x99TYE
	q4o0+2jOQcNkkvgTS95XEfCGVnopuTdTbOf8XRBJ3nfRen6OuFGvwnSx2GuaLIlq/ixF87
	3stI4Ykbh2gJ7CX4HC1bmPyVypbeb06Pe8YQ6MdhJvkg2vFBNGYE+OfmXdJQRouMS4GUs7
	CkFUiaE6H/2dUx5ecbf6ly5Jr14hUY6DZoWBX6VcS9BnhpU4+IER/IueZgXKFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741865488;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vDqqyRABThchE09zdcKgwPrv1SPksWgjEOAqrNzh+UI=;
	b=gj5WnBWG6ppV61r/ZTGDpxHAFhXif71G5GLRhSJpAEgm38k8iNQTWfGnVDlyNz9yrLogCO
	r5ZcOSQ8EIwgRrBw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Make lock_timer() use guard()
Cc: Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250308155624.087465658@linutronix.de>
References: <20250308155624.087465658@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174186548785.14745.9377232352685583213.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     538d710ec74233f99dc0fd604d45a2b6143c8e2c
Gitweb:        https://git.kernel.org/tip/538d710ec74233f99dc0fd604d45a2b6143c8e2c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 08 Mar 2025 17:48:34 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Mar 2025 12:07:17 +01:00

posix-timers: Make lock_timer() use guard()

The lookup and locking of posix timers requires the same repeating pattern
at all usage sites:

   tmr = lock_timer(tiner_id);
   if (!tmr)
   	return -EINVAL;
   ....
   unlock_timer(tmr);

Solve this with a guard implementation, which works in most places out of
the box except for those, which need to unlock the timer inside the guard
scope.

Though the only places where this matters are timer_delete() and
timer_settime(). In both cases the timer pointer needs to be preserved
across the end of the scope, which is solved by storing the pointer in a
variable outside of the scope.

timer_settime() also has to protect the timer with RCU before unlocking,
which obviously can't use guard(rcu) before leaving the guard scope as that
guard is cleaned up before the unlock. Solve this by providing the RCU
protection open coded.

[ tglx: Made it work and added change log ]

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20250224162103.GD11590@noisy.programming.kicks-ass.net
Link: https://lore.kernel.org/all/20250308155624.087465658@linutronix.de

---
 include/linux/cleanup.h    | 22 +++++----
 kernel/time/posix-timers.c | 92 ++++++++++++++-----------------------
 2 files changed, 50 insertions(+), 64 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index ec00e3f..a176abf 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -291,11 +291,21 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
 #define __DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
 static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
 
-#define DEFINE_GUARD(_name, _type, _lock, _unlock) \
+#define __DEFINE_GUARD_LOCK_PTR(_name, _exp) \
+	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
+	{ return (void *)(__force unsigned long)*(_exp); }
+
+#define DEFINE_CLASS_IS_GUARD(_name) \
 	__DEFINE_CLASS_IS_CONDITIONAL(_name, false); \
+	__DEFINE_GUARD_LOCK_PTR(_name, _T)
+
+#define DEFINE_CLASS_IS_COND_GUARD(_name) \
+	__DEFINE_CLASS_IS_CONDITIONAL(_name, true); \
+	__DEFINE_GUARD_LOCK_PTR(_name, _T)
+
+#define DEFINE_GUARD(_name, _type, _lock, _unlock) \
 	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
-	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
-	{ return (void *)(__force unsigned long)*_T; }
+	DEFINE_CLASS_IS_GUARD(_name)
 
 #define DEFINE_GUARD_COND(_name, _ext, _condlock) \
 	__DEFINE_CLASS_IS_CONDITIONAL(_name##_ext, true); \
@@ -375,11 +385,7 @@ static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
 	if (_T->lock) { _unlock; }					\
 }									\
 									\
-static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T)	\
-{									\
-	return (void *)(__force unsigned long)_T->lock;			\
-}
-
+__DEFINE_GUARD_LOCK_PTR(_name, &_T->lock)
 
 #define __DEFINE_LOCK_GUARD_1(_name, _type, _lock)			\
 static inline class_##_name##_t class_##_name##_constructor(_type *l)	\
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index dff414b..991d12a 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -63,9 +63,18 @@ static struct k_itimer *__lock_timer(timer_t timer_id);
 
 static inline void unlock_timer(struct k_itimer *timr)
 {
-	spin_unlock_irq(&timr->it_lock);
+	if (likely((timr)))
+		spin_unlock_irq(&timr->it_lock);
 }
 
+#define scoped_timer_get_or_fail(_id)					\
+	scoped_cond_guard(lock_timer, return -EINVAL, _id)
+
+#define scoped_timer				(scope)
+
+DEFINE_CLASS(lock_timer, struct k_itimer *, unlock_timer(_T), __lock_timer(id), timer_t id);
+DEFINE_CLASS_IS_COND_GUARD(lock_timer);
+
 static int hash(struct signal_struct *sig, unsigned int nr)
 {
 	return hash_32(hash32_ptr(sig) ^ nr, HASH_BITS(posix_timers_hashtable));
@@ -682,18 +691,10 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 
 static int do_timer_gettime(timer_t timer_id,  struct itimerspec64 *setting)
 {
-	struct k_itimer *timr;
-	int ret = 0;
-
-	timr = lock_timer(timer_id);
-	if (!timr)
-		return -EINVAL;
-
 	memset(setting, 0, sizeof(*setting));
-	timr->kclock->timer_get(timr, setting);
-
-	unlock_timer(timr);
-	return ret;
+	scoped_timer_get_or_fail(timer_id)
+		scoped_timer->kclock->timer_get(scoped_timer, setting);
+	return 0;
 }
 
 /* Get the time remaining on a POSIX.1b interval timer. */
@@ -747,17 +748,8 @@ SYSCALL_DEFINE2(timer_gettime32, timer_t, timer_id,
  */
 SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
 {
-	struct k_itimer *timr;
-	int overrun;
-
-	timr = lock_timer(timer_id);
-	if (!timr)
-		return -EINVAL;
-
-	overrun = timer_overrun_to_int(timr);
-	unlock_timer(timr);
-
-	return overrun;
+	scoped_timer_get_or_fail(timer_id)
+		return timer_overrun_to_int(scoped_timer);
 }
 
 static void common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
@@ -875,12 +867,9 @@ int common_timer_set(struct k_itimer *timr, int flags,
 	return 0;
 }
 
-static int do_timer_settime(timer_t timer_id, int tmr_flags,
-			    struct itimerspec64 *new_spec64,
+static int do_timer_settime(timer_t timer_id, int tmr_flags, struct itimerspec64 *new_spec64,
 			    struct itimerspec64 *old_spec64)
 {
-	int ret;
-
 	if (!timespec64_valid(&new_spec64->it_interval) ||
 	    !timespec64_valid(&new_spec64->it_value))
 		return -EINVAL;
@@ -888,36 +877,28 @@ static int do_timer_settime(timer_t timer_id, int tmr_flags,
 	if (old_spec64)
 		memset(old_spec64, 0, sizeof(*old_spec64));
 
-	for (;;) {
-		struct k_itimer *timr = lock_timer(timer_id);
+	for (; ; old_spec64 = NULL) {
+		struct k_itimer *timr;
 
-		if (!timr)
-			return -EINVAL;
+		scoped_timer_get_or_fail(timer_id) {
+			timr = scoped_timer;
 
-		if (old_spec64)
-			old_spec64->it_interval = ktime_to_timespec64(timr->it_interval);
+			if (old_spec64)
+				old_spec64->it_interval = ktime_to_timespec64(timr->it_interval);
 
-		/* Prevent signal delivery and rearming. */
-		timr->it_signal_seq++;
+			/* Prevent signal delivery and rearming. */
+			timr->it_signal_seq++;
 
-		ret = timr->kclock->timer_set(timr, tmr_flags, new_spec64, old_spec64);
-		if (ret != TIMER_RETRY) {
-			unlock_timer(timr);
-			break;
-		}
+			int ret = timr->kclock->timer_set(timr, tmr_flags, new_spec64, old_spec64);
+			if (ret != TIMER_RETRY)
+				return ret;
 
-		/* Read the old time only once */
-		old_spec64 = NULL;
-		/* Protect the timer from being freed after the lock is dropped */
-		guard(rcu)();
-		unlock_timer(timr);
-		/*
-		 * timer_wait_running() might drop RCU read side protection
-		 * so the timer has to be looked up again!
-		 */
+			/* Protect the timer from being freed when leaving the lock scope */
+			rcu_read_lock();
+		}
 		timer_wait_running(timr);
+		rcu_read_unlock();
 	}
-	return ret;
 }
 
 /* Set a POSIX.1b interval timer */
@@ -1028,13 +1009,12 @@ static void posix_timer_delete(struct k_itimer *timer)
 /* Delete a POSIX.1b interval timer. */
 SYSCALL_DEFINE1(timer_delete, timer_t, timer_id)
 {
-	struct k_itimer *timer = lock_timer(timer_id);
-
-	if (!timer)
-		return -EINVAL;
+	struct k_itimer *timer;
 
-	posix_timer_delete(timer);
-	unlock_timer(timer);
+	scoped_timer_get_or_fail(timer_id) {
+		timer = scoped_timer;
+		posix_timer_delete(timer);
+	}
 	/* Remove it from the hash, which frees up the timer ID */
 	posix_timer_unhash_and_free(timer);
 	return 0;

