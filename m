Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153B13EF35F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbhHQUPY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:15:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34586 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbhHQUOz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:55 -0400
Date:   Tue, 17 Aug 2021 20:14:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231261;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EwdtG2Fmp0DrqLELRZD6Pv/gUzGWDcMPkUtK6ZVvHUU=;
        b=ug3RBli96iTmAXGFZbp6pKLs9vGaDifYhVIxzT4iVDK+slg5b8iDGxG3M4/u22gm55uASd
        2xkFnxx8jox0vxvll9euT18BWJJS3bn5YHvsETUsy4I/6TxpR8hamPj/muodafEi3vYah9
        /tmaAIYylGBCab/kkk6YC3JmXKnfwOkW+Ia7miC1VucWsmk6roRCK2bPxl5yi/UZjt3RMJ
        nJmpiPE5rhtY1GfCAPZlP4u/igFkFw34iaf9EcpkscW/A3YRUnQeYfh3A3T6zJpFnCs2vl
        4slmY9odN6NQ5wS4ZcqFpZglu/5iiyE3l3MRVdgOBSOM+icJQMI7RcpIGEqhhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231261;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EwdtG2Fmp0DrqLELRZD6Pv/gUzGWDcMPkUtK6ZVvHUU=;
        b=n5C6nwZppk2U6IFo8/TiwQa+cypRUAcSKEkEW92bJY2JGp+KtgYEx9h0ZLg9Yv2gzZahHF
        Ui3xS+wcLLztTpDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Provide the spin/rwlock core
 lock function
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211303.770228446@linutronix.de>
References: <20210815211303.770228446@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923126024.25758.14251862058471582653.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     1c143c4b65da09081d644110e619decc49c9dee4
Gitweb:        https://git.kernel.org/tip/1c143c4b65da09081d644110e619decc49c9dee4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:28:25 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 17:45:37 +02:00

locking/rtmutex: Provide the spin/rwlock core lock function

A simplified version of the rtmutex slowlock function, which neither handles
signals nor timeouts, and is careful about preserving the state of the
blocked task across the lock operation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211303.770228446@linutronix.de
---
 kernel/locking/rtmutex.c        | 60 ++++++++++++++++++++++++++++++++-
 kernel/locking/rtmutex_common.h |  2 +-
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 949781a..951bef0 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1416,3 +1416,63 @@ static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 	return rt_mutex_slowlock(lock, state);
 }
 #endif /* RT_MUTEX_BUILD_MUTEX */
+
+#ifdef RT_MUTEX_BUILD_SPINLOCKS
+/*
+ * Functions required for spin/rw_lock substitution on RT kernels
+ */
+
+/**
+ * rtlock_slowlock_locked - Slow path lock acquisition for RT locks
+ * @lock:	The underlying RT mutex
+ */
+static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
+{
+	struct rt_mutex_waiter waiter;
+
+	lockdep_assert_held(&lock->wait_lock);
+
+	if (try_to_take_rt_mutex(lock, current, NULL))
+		return;
+
+	rt_mutex_init_rtlock_waiter(&waiter);
+
+	/* Save current state and set state to TASK_RTLOCK_WAIT */
+	current_save_and_set_rtlock_wait_state();
+
+	task_blocks_on_rt_mutex(lock, &waiter, current, RT_MUTEX_MIN_CHAINWALK);
+
+	for (;;) {
+		/* Try to acquire the lock again */
+		if (try_to_take_rt_mutex(lock, current, &waiter))
+			break;
+
+		raw_spin_unlock_irq(&lock->wait_lock);
+
+		schedule_rtlock();
+
+		raw_spin_lock_irq(&lock->wait_lock);
+		set_current_state(TASK_RTLOCK_WAIT);
+	}
+
+	/* Restore the task state */
+	current_restore_rtlock_saved_state();
+
+	/*
+	 * try_to_take_rt_mutex() sets the waiter bit unconditionally.
+	 * We might have to fix that up:
+	 */
+	fixup_rt_mutex_waiters(lock);
+	debug_rt_mutex_free_waiter(&waiter);
+}
+
+static __always_inline void __sched rtlock_slowlock(struct rt_mutex_base *lock)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+	rtlock_slowlock_locked(lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+}
+
+#endif /* RT_MUTEX_BUILD_SPINLOCKS */
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 424ee0f..ccf0e36 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -181,7 +181,7 @@ static inline void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
 	waiter->task = NULL;
 }
 
-static inline void rtlock_init_rtmutex_waiter(struct rt_mutex_waiter *waiter)
+static inline void rt_mutex_init_rtlock_waiter(struct rt_mutex_waiter *waiter)
 {
 	rt_mutex_init_waiter(waiter);
 	waiter->wake_state = TASK_RTLOCK_WAIT;
