Return-Path: <linux-tip-commits+bounces-2361-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E09EE9941EC
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 10:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7B11C2133E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 08:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C318C20C49C;
	Tue,  8 Oct 2024 07:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AQJIvSOA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FMKBuLik"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5841E5034;
	Tue,  8 Oct 2024 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374186; cv=none; b=BcKDCSfAR0JG4A5TbXofs1ts0dl6L8kHY4ME+wFf2FFV3IedtUO0VExMNxRiAbWaTDB0VMTmOiqnqIBJbvzXtU5wZdu1wDMP45j3doKALPk81dD5QMG1qfBPMNiXTnHgjc0/X/BZ5+mNXqbuPRmG42teel/wwS29S6cBQd9tO8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374186; c=relaxed/simple;
	bh=IKrEY4A+FT8yzFRweN1ui97m5I1bc/J7Xj+ILXpIu6E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d3YJqnQAhJGG+oMAAxQbLJ26T6Coc8jVBu9XXL2MGMAxcaf/l+fnhGBjYMCdgaSEZvXBkT1dFwIlXnBNXIiDsKTSoCAQdYe8BbPATFEP80Q1VIleoJZTkRknjd6NJlW0cxgl0VgRl1WgwJpFZmXIsVevhwlCx+MK62fOJZ8U3VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AQJIvSOA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FMKBuLik; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 07:56:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728374183;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WRYCvCTRRKmIXyhGpXmFhh9zDkqASV3gOkhyO+Brhps=;
	b=AQJIvSOAFKUMHEj2Nt/1QWz0a4NT2Uw+JUHQ1wscU0ANxsM8s166d4xw5RcjCbTWtE+aTH
	ejXTv20Gu1wzuwsyjcojd9GFHrr3tjcjKgtenQj5qvnz3mhLb+HRMEe+d5vJ6Nsmdm+Px9
	6g+j3CWAZNA9+8e9dXOpbZihe1+tuABcjyN+4dGPUlEpBoUHlbTV4uIXHViVLF2KiuyObt
	JBa64cMz4QOvv3qndZFYr9+ft4aiXoicVJwRDxygB4QcgmWZFqjsThB/KWA1r4LZ2Mi5Ve
	THioG1/FcwqriQM5CaUpYF9H5JOcK0D6is7tj5q4YgRODc2Aw4Vf6hk/wBhA8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728374183;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WRYCvCTRRKmIXyhGpXmFhh9zDkqASV3gOkhyO+Brhps=;
	b=FMKBuLikiE9PACsYJ8Sz8zknhLhkfJvCIK5BYkE3mE1TDhuytLvCU8ORLS+uweQBpBQCA6
	hJO4PnbYrpEqcDDQ==
From: "tip-bot2 for NeilBrown" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add wait/wake interface for variable updated
 under a lock.
Cc: NeilBrown <neilb@suse.de>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240925053405.3960701-6-neilb@suse.de>
References: <20240925053405.3960701-6-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172837418230.1442.3499879992875947999.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     cc2e1c82d7e474753681a38b07b63034e107e369
Gitweb:        https://git.kernel.org/tip/cc2e1c82d7e474753681a38b07b63034e107e369
Author:        NeilBrown <neilb@suse.de>
AuthorDate:    Wed, 25 Sep 2024 15:31:42 +10:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:38 +02:00

sched: Add wait/wake interface for variable updated under a lock.

Sometimes we need to wait for a condition to be true which must be
testing while holding a lock.  Correspondingly the condition is made
true while holding the lock and the wake up is sent under the lock.

This patch provides wake and wait interfaces which can be used for this
situation when the lock is a mutex or a spinlock, or any other lock for
which there are foo_lock() and foo_unlock() functions.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240925053405.3960701-6-neilb@suse.de
---
 include/linux/wait_bit.h | 106 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 0272629..6aea10e 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -402,6 +402,112 @@ do {									\
 })
 
 /**
+ * wait_var_event_any_lock - wait for a variable to be updated under a lock
+ * @var: the address of the variable being waited on
+ * @condition: condition to wait for
+ * @lock: the object that is locked to protect updates to the variable
+ * @type: prefix on lock and unlock operations
+ * @state: waiting state, %TASK_UNINTERRUPTIBLE etc.
+ *
+ * Wait for a condition which can only be reliably tested while holding
+ * a lock.  The variables assessed in the condition will normal be updated
+ * under the same lock, and the wake up should be signalled with
+ * wake_up_var_locked() under the same lock.
+ *
+ * This is similar to wait_var_event(), but assumes a lock is held
+ * while calling this function and while updating the variable.
+ *
+ * This must be called while the given lock is held and the lock will be
+ * dropped when schedule() is called to wait for a wake up, and will be
+ * reclaimed before testing the condition again.  The functions used to
+ * unlock and lock the object are constructed by appending _unlock and _lock
+ * to @type.
+ *
+ * Return %-ERESTARTSYS if a signal arrives which is allowed to interrupt
+ * the wait according to @state.
+ */
+#define wait_var_event_any_lock(var, condition, lock, type, state)	\
+({									\
+	int __ret = 0;							\
+	if (!(condition))						\
+		__ret = ___wait_var_event(var, condition, state, 0, 0,	\
+					  type ## _unlock(lock);	\
+					  schedule();			\
+					  type ## _lock(lock));		\
+	__ret;								\
+})
+
+/**
+ * wait_var_event_spinlock - wait for a variable to be updated under a spinlock
+ * @var: the address of the variable being waited on
+ * @condition: condition to wait for
+ * @lock: the spinlock which protects updates to the variable
+ *
+ * Wait for a condition which can only be reliably tested while holding
+ * a spinlock.  The variables assessed in the condition will normal be updated
+ * under the same spinlock, and the wake up should be signalled with
+ * wake_up_var_locked() under the same spinlock.
+ *
+ * This is similar to wait_var_event(), but assumes a spinlock is held
+ * while calling this function and while updating the variable.
+ *
+ * This must be called while the given lock is held and the lock will be
+ * dropped when schedule() is called to wait for a wake up, and will be
+ * reclaimed before testing the condition again.
+ */
+#define wait_var_event_spinlock(var, condition, lock)			\
+	wait_var_event_any_lock(var, condition, lock, spin, TASK_UNINTERRUPTIBLE)
+
+/**
+ * wait_var_event_mutex - wait for a variable to be updated under a mutex
+ * @var: the address of the variable being waited on
+ * @condition: condition to wait for
+ * @mutex: the mutex which protects updates to the variable
+ *
+ * Wait for a condition which can only be reliably tested while holding
+ * a mutex.  The variables assessed in the condition will normal be
+ * updated under the same mutex, and the wake up should be signalled
+ * with wake_up_var_locked() under the same mutex.
+ *
+ * This is similar to wait_var_event(), but assumes a mutex is held
+ * while calling this function and while updating the variable.
+ *
+ * This must be called while the given mutex is held and the mutex will be
+ * dropped when schedule() is called to wait for a wake up, and will be
+ * reclaimed before testing the condition again.
+ */
+#define wait_var_event_mutex(var, condition, lock)			\
+	wait_var_event_any_lock(var, condition, lock, mutex, TASK_UNINTERRUPTIBLE)
+
+/**
+ * wake_up_var_protected - wake up waiters for a variable asserting that it is safe
+ * @var: the address of the variable being waited on
+ * @cond: the condition which afirms this is safe
+ *
+ * When waking waiters which use wait_var_event_any_lock() the waker must be
+ * holding the reelvant lock to avoid races.  This version of wake_up_var()
+ * asserts that the relevant lock is held and so no barrier is needed.
+ * The @cond is only tested when CONFIG_LOCKDEP is enabled.
+ */
+#define wake_up_var_protected(var, cond)				\
+do {									\
+	lockdep_assert(cond);						\
+	wake_up_var(var);						\
+} while (0)
+
+/**
+ * wake_up_var_locked - wake up waiters for a variable while holding a spinlock or mutex
+ * @var: the address of the variable being waited on
+ * @lock: The spinlock or mutex what protects the variable
+ *
+ * Send a wake up for the given variable which should be waited for with
+ * wait_var_event_spinlock() or wait_var_event_mutex().  Unlike wake_up_var(),
+ * no extra barriers are needed as the locking provides sufficient sequencing.
+ */
+#define wake_up_var_locked(var, lock)					\
+	wake_up_var_protected(var, lockdep_is_held(lock))
+
+/**
  * clear_and_wake_up_bit - clear a bit and wake up anyone waiting on that bit
  * @bit: the bit of the word being waited on
  * @word: the address containing the bit being waited on

