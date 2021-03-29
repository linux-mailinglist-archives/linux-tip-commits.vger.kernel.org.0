Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444F034D4F3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Mar 2021 18:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhC2QYj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 29 Mar 2021 12:24:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37680 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhC2QYO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 29 Mar 2021 12:24:14 -0400
Date:   Mon, 29 Mar 2021 16:24:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617035053;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dcZQ+5Ot4W7UPWffXYKybV8kr0ZvNfQ/8RgvI4Gk4e8=;
        b=IzquOC7wjoUX4cRfG4pr9ILgftJj5JhoN2F+YTW07lMaAP6IbnR+f9w6fUNH2qSSHGIeOv
        yJdHw2IIE70YtHxfvueg3UoHuPS/Ndz5sq2u1DmqLMBQnxVrzo4DGxFWKA+hi0klCJqhJX
        3x+pWhQbUwB3/6lHeuB/sjw6U4FuUFI6avDtl439E0XAtQwxG9IGCpEu6b0lvLelz6ejCD
        KEafUfL1AHgHjaUgRICrUKGnyr1QksJVcbxBJdqFnnqF9BUQevwX3DpVdo+eLhnN6dOoaq
        X91Aiu+aIxEPLQAAElJcOHjv8Q/cH6MOU+CNK2yRUDzzBcgHk16ecLaPyf7fPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617035053;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dcZQ+5Ot4W7UPWffXYKybV8kr0ZvNfQ/8RgvI4Gk4e8=;
        b=L/ttjsis22ZnBDbBbX6dV8cUt0ewNanoxl2vA/A870tFXQGPDaWDp12uQz3H8eMAv0Rbe5
        MErSYo8nE5sAR7BQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Remove rt_mutex_timed_lock()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326153943.061103415@linutronix.de>
References: <20210326153943.061103415@linutronix.de>
MIME-Version: 1.0
Message-ID: <161703505243.29796.17304307401328757785.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c15380b72d7ae821ee090ba5a56fc6310828dbda
Gitweb:        https://git.kernel.org/tip/c15380b72d7ae821ee090ba5a56fc6310828dbda
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 26 Mar 2021 16:29:30 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 29 Mar 2021 15:57:02 +02:00

locking/rtmutex: Remove rt_mutex_timed_lock()

rt_mutex_timed_lock() has no callers since:

  c051b21f71d1f ("rtmutex: Confine deadlock logic to futex")

Remove it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210326153943.061103415@linutronix.de
---
 include/linux/rtmutex.h  |  3 +---
 kernel/locking/rtmutex.c | 46 +---------------------------------------
 2 files changed, 49 deletions(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 6fd615a..32f4a35 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -115,9 +115,6 @@ extern void rt_mutex_lock(struct rt_mutex *lock);
 #endif
 
 extern int rt_mutex_lock_interruptible(struct rt_mutex *lock);
-extern int rt_mutex_timed_lock(struct rt_mutex *lock,
-			       struct hrtimer_sleeper *timeout);
-
 extern int rt_mutex_trylock(struct rt_mutex *lock);
 
 extern void rt_mutex_unlock(struct rt_mutex *lock);
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index db31bce..ca93e5d 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1395,21 +1395,6 @@ rt_mutex_fastlock(struct rt_mutex *lock, int state,
 }
 
 static inline int
-rt_mutex_timed_fastlock(struct rt_mutex *lock, int state,
-			struct hrtimer_sleeper *timeout,
-			enum rtmutex_chainwalk chwalk,
-			int (*slowfn)(struct rt_mutex *lock, int state,
-				      struct hrtimer_sleeper *timeout,
-				      enum rtmutex_chainwalk chwalk))
-{
-	if (chwalk == RT_MUTEX_MIN_CHAINWALK &&
-	    likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
-		return 0;
-
-	return slowfn(lock, state, timeout, chwalk);
-}
-
-static inline int
 rt_mutex_fasttrylock(struct rt_mutex *lock,
 		     int (*slowfn)(struct rt_mutex *lock))
 {
@@ -1517,37 +1502,6 @@ int __sched __rt_mutex_futex_trylock(struct rt_mutex *lock)
 }
 
 /**
- * rt_mutex_timed_lock - lock a rt_mutex interruptible
- *			the timeout structure is provided
- *			by the caller
- *
- * @lock:		the rt_mutex to be locked
- * @timeout:		timeout structure or NULL (no timeout)
- *
- * Returns:
- *  0		on success
- * -EINTR	when interrupted by a signal
- * -ETIMEDOUT	when the timeout expired
- */
-int
-rt_mutex_timed_lock(struct rt_mutex *lock, struct hrtimer_sleeper *timeout)
-{
-	int ret;
-
-	might_sleep();
-
-	mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
-	ret = rt_mutex_timed_fastlock(lock, TASK_INTERRUPTIBLE, timeout,
-				       RT_MUTEX_MIN_CHAINWALK,
-				       rt_mutex_slowlock);
-	if (ret)
-		mutex_release(&lock->dep_map, _RET_IP_);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(rt_mutex_timed_lock);
-
-/**
  * rt_mutex_trylock - try to lock a rt_mutex
  *
  * @lock:	the rt_mutex to be locked
