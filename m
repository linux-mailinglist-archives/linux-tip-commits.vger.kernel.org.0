Return-Path: <linux-tip-commits+bounces-5956-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D7EAEE32B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 17:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B143A25C3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 15:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29791BD9CE;
	Mon, 30 Jun 2025 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OBWBd2ed";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QtPeqOr0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F8925C6E7;
	Mon, 30 Jun 2025 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299105; cv=none; b=JN/fGcK51Qcv7cQQUwKDWT2pTFL3dOAvPh9YcFx+/8t3B5KFEWExxwGnrMB9AK7tnC+m/UEm92uuQyl2+HhkToSPLzbRisFR0SRynDnZJLjilX7NHFsF2nrlUK4Ci7+K2DpPekQ7OoVHUeslOM/W/wSz8UHZYirmiWpTs3YQVhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299105; c=relaxed/simple;
	bh=A/X8mgmC0q3KiGKn2DV1OLmsHK3yxfWZiHWawY6AIaI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V0BfhcMngKPcO0AlUioK2vGybtd5gnZ1z5CKZDb3XB/FT7pUc4c3+Awk4LmX38OzyFLLxZYiKHj1aryhaCnX1Q7bpmCaDkQgwJo1f2BHsDWj8MPHr2tnI0wwSV8RYr8Pj2urkgTUCq1c+oKUM8JLo0Gx1/7w0MYrxLIqCrFrvNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OBWBd2ed; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QtPeqOr0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Jun 2025 15:58:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751299102;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6pDrpkvSnS1nV+iX13YXNmJZPp40ZNgPTXSFU1Pvyg=;
	b=OBWBd2edg11Mfzj2S8jKDaFBJFBJ2tf72j3LPDqWqrSOwswuBOHWbbF7f3JUvpfFYCPLh3
	ZimGPrMy4czxNzllvrV/qcbQix2HMn6iNx52Q5RvjT6B89CK7zeyITYsIGCXLG2eyeXyd7
	CkyzSadKfnrHTIqFMuy+V1JMVlcGtOi3ODjbuTuNbu5T8609zAskPQjtiT9kfTpvcLSiB+
	TxM85eq75CQNavtn8VgtBu6stM9tfcrPWVmt80td1ubdctCrp6sL0v0oD5my8pxBBzUxCR
	0XtAhA9q9KhrTTRrdT07WPtdFKpjzw55Kav7a/JytkhgM41kMEVGrR9SXONLiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751299102;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6pDrpkvSnS1nV+iX13YXNmJZPp40ZNgPTXSFU1Pvyg=;
	b=QtPeqOr02axc/AcUuWxqv35uoJYq5cWmZugva10dBWmodtlK4zsenX4ntaUCR2j9BaTyyw
	CQMLED7LkelXnlBQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] local_lock: Move this_cpu_ptr() notation from
 internal to main header
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250630075138.3448715-2-bigeasy@linutronix.de>
References: <20250630075138.3448715-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175129910125.406.16097506235858412052.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7ff495e26a39f3e7a3d4058df59b5b6d6f943cab
Gitweb:        https://git.kernel.org/tip/7ff495e26a39f3e7a3d4058df59b5b6d6f943cab
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 30 Jun 2025 09:51:38 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 30 Jun 2025 17:45:35 +02:00

local_lock: Move this_cpu_ptr() notation from internal to main header

local_lock.h is the main header for the local_lock_t type and provides
wrappers around internal functions prefixed with __ in
local_lock_internal.h.

Move the this_cpu_ptr() dereference of the variable from the internal to
the main header. Since it is all macro implemented, this_cpu_ptr() will
still happen within the preempt/ IRQ disabled section.

This frees the internal implementation (__) to be used on local_lock_t
types which are local variables and must not be accessed via
this_cpu_ptr().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Waiman Long <longman@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250630075138.3448715-2-bigeasy@linutronix.de

---
 include/linux/local_lock.h          | 20 +++++++++----------
 include/linux/local_lock_internal.h | 30 ++++++++++++++--------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 16a2ee4..2ba8464 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -13,13 +13,13 @@
  * local_lock - Acquire a per CPU local lock
  * @lock:	The lock variable
  */
-#define local_lock(lock)		__local_lock(lock)
+#define local_lock(lock)		__local_lock(this_cpu_ptr(lock))
 
 /**
  * local_lock_irq - Acquire a per CPU local lock and disable interrupts
  * @lock:	The lock variable
  */
-#define local_lock_irq(lock)		__local_lock_irq(lock)
+#define local_lock_irq(lock)		__local_lock_irq(this_cpu_ptr(lock))
 
 /**
  * local_lock_irqsave - Acquire a per CPU local lock, save and disable
@@ -28,19 +28,19 @@
  * @flags:	Storage for interrupt flags
  */
 #define local_lock_irqsave(lock, flags)				\
-	__local_lock_irqsave(lock, flags)
+	__local_lock_irqsave(this_cpu_ptr(lock), flags)
 
 /**
  * local_unlock - Release a per CPU local lock
  * @lock:	The lock variable
  */
-#define local_unlock(lock)		__local_unlock(lock)
+#define local_unlock(lock)		__local_unlock(this_cpu_ptr(lock))
 
 /**
  * local_unlock_irq - Release a per CPU local lock and enable interrupts
  * @lock:	The lock variable
  */
-#define local_unlock_irq(lock)		__local_unlock_irq(lock)
+#define local_unlock_irq(lock)		__local_unlock_irq(this_cpu_ptr(lock))
 
 /**
  * local_unlock_irqrestore - Release a per CPU local lock and restore
@@ -49,7 +49,7 @@
  * @flags:      Interrupt flags to restore
  */
 #define local_unlock_irqrestore(lock, flags)			\
-	__local_unlock_irqrestore(lock, flags)
+	__local_unlock_irqrestore(this_cpu_ptr(lock), flags)
 
 /**
  * local_lock_init - Runtime initialize a lock instance
@@ -64,7 +64,7 @@
  * locking constrains it will _always_ fail to acquire the lock in NMI or
  * HARDIRQ context on PREEMPT_RT.
  */
-#define local_trylock(lock)		__local_trylock(lock)
+#define local_trylock(lock)		__local_trylock(this_cpu_ptr(lock))
 
 /**
  * local_trylock_irqsave - Try to acquire a per CPU local lock, save and disable
@@ -77,7 +77,7 @@
  * HARDIRQ context on PREEMPT_RT.
  */
 #define local_trylock_irqsave(lock, flags)			\
-	__local_trylock_irqsave(lock, flags)
+	__local_trylock_irqsave(this_cpu_ptr(lock), flags)
 
 DEFINE_GUARD(local_lock, local_lock_t __percpu*,
 	     local_lock(_T),
@@ -91,10 +91,10 @@ DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_lock_t __percpu,
 		    unsigned long flags)
 
 #define local_lock_nested_bh(_lock)				\
-	__local_lock_nested_bh(_lock)
+	__local_lock_nested_bh(this_cpu_ptr(_lock))
 
 #define local_unlock_nested_bh(_lock)				\
-	__local_unlock_nested_bh(_lock)
+	__local_unlock_nested_bh(this_cpu_ptr(_lock))
 
 DEFINE_GUARD(local_lock_nested_bh, local_lock_t __percpu*,
 	     local_lock_nested_bh(_T),
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 8d5ac16..d80b530 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -99,14 +99,14 @@ do {								\
 		local_trylock_t *tl;					\
 		local_lock_t *l;					\
 									\
-		l = (local_lock_t *)this_cpu_ptr(lock);			\
+		l = (local_lock_t *)(lock);				\
 		tl = (local_trylock_t *)l;				\
 		_Generic((lock),					\
-			__percpu local_trylock_t *: ({			\
+			local_trylock_t *: ({				\
 				lockdep_assert(tl->acquired == 0);	\
 				WRITE_ONCE(tl->acquired, 1);		\
 			}),						\
-			__percpu local_lock_t *: (void)0);		\
+			local_lock_t *: (void)0);			\
 		local_lock_acquire(l);					\
 	} while (0)
 
@@ -133,7 +133,7 @@ do {								\
 		local_trylock_t *tl;				\
 								\
 		preempt_disable();				\
-		tl = this_cpu_ptr(lock);			\
+		tl = (lock);					\
 		if (READ_ONCE(tl->acquired)) {			\
 			preempt_enable();			\
 			tl = NULL;				\
@@ -150,7 +150,7 @@ do {								\
 		local_trylock_t *tl;				\
 								\
 		local_irq_save(flags);				\
-		tl = this_cpu_ptr(lock);			\
+		tl = (lock);					\
 		if (READ_ONCE(tl->acquired)) {			\
 			local_irq_restore(flags);		\
 			tl = NULL;				\
@@ -167,15 +167,15 @@ do {								\
 		local_trylock_t *tl;					\
 		local_lock_t *l;					\
 									\
-		l = (local_lock_t *)this_cpu_ptr(lock);			\
+		l = (local_lock_t *)(lock);				\
 		tl = (local_trylock_t *)l;				\
 		local_lock_release(l);					\
 		_Generic((lock),					\
-			__percpu local_trylock_t *: ({			\
+			local_trylock_t *: ({				\
 				lockdep_assert(tl->acquired == 1);	\
 				WRITE_ONCE(tl->acquired, 0);		\
 			}),						\
-			__percpu local_lock_t *: (void)0);		\
+			local_lock_t *: (void)0);			\
 	} while (0)
 
 #define __local_unlock(lock)					\
@@ -199,11 +199,11 @@ do {								\
 #define __local_lock_nested_bh(lock)				\
 	do {							\
 		lockdep_assert_in_softirq();			\
-		local_lock_acquire(this_cpu_ptr(lock));	\
+		local_lock_acquire((lock));			\
 	} while (0)
 
 #define __local_unlock_nested_bh(lock)				\
-	local_lock_release(this_cpu_ptr(lock))
+	local_lock_release((lock))
 
 #else /* !CONFIG_PREEMPT_RT */
 
@@ -227,7 +227,7 @@ typedef spinlock_t local_trylock_t;
 #define __local_lock(__lock)					\
 	do {							\
 		migrate_disable();				\
-		spin_lock(this_cpu_ptr((__lock)));		\
+		spin_lock((__lock));				\
 	} while (0)
 
 #define __local_lock_irq(lock)			__local_lock(lock)
@@ -241,7 +241,7 @@ typedef spinlock_t local_trylock_t;
 
 #define __local_unlock(__lock)					\
 	do {							\
-		spin_unlock(this_cpu_ptr((__lock)));		\
+		spin_unlock((__lock));				\
 		migrate_enable();				\
 	} while (0)
 
@@ -252,12 +252,12 @@ typedef spinlock_t local_trylock_t;
 #define __local_lock_nested_bh(lock)				\
 do {								\
 	lockdep_assert_in_softirq_func();			\
-	spin_lock(this_cpu_ptr(lock));				\
+	spin_lock((lock));					\
 } while (0)
 
 #define __local_unlock_nested_bh(lock)				\
 do {								\
-	spin_unlock(this_cpu_ptr((lock)));			\
+	spin_unlock((lock));					\
 } while (0)
 
 #define __local_trylock(lock)					\
@@ -268,7 +268,7 @@ do {								\
 			__locked = 0;				\
 		} else {					\
 			migrate_disable();			\
-			__locked = spin_trylock(this_cpu_ptr((lock)));	\
+			__locked = spin_trylock((lock));	\
 			if (!__locked)				\
 				migrate_enable();		\
 		}						\

