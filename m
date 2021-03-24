Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D32E347266
	for <lists+linux-tip-commits@lfdr.de>; Wed, 24 Mar 2021 08:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhCXHWv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 24 Mar 2021 03:22:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38668 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbhCXHWc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 24 Mar 2021 03:22:32 -0400
Date:   Wed, 24 Mar 2021 07:22:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616570551;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FYoP+yIEd2EzATmw5tEvpCtNtEdbcj20/4tOjojdMy8=;
        b=lgYxErPCxWNnH4WiL4Fidb3Wzmuorvt9nigNGhEWsrYFzRpiq/1tlgvICo2B0rCdu8pACy
        WpztfP3qUVI45hTFsFlv/PVshEu6A4K7qEzw/5bnfMcLiVcJog6chX/Li7WH8VDuyOCzcV
        ffIXMC9ebJ9iNeHLCOi9HbzVcuRd43EiP7USUvHqvZ+Ch7TQnonQlLE7gSfxlj78xJ8rsa
        yMa+cZ5TdTddYrKUFd9ADMPxEi4fnJw8j68zEM9qtIvgZyvFgnB3DJlWAOYtHz0PmtWpHK
        8ba8j1lgoeBdj8PTKO6e3cXfo7gs082LkalfG8um9Px7tXG/DwLAfv3TflQryQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616570551;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FYoP+yIEd2EzATmw5tEvpCtNtEdbcj20/4tOjojdMy8=;
        b=ytcfDcNrh9IEjxCiLNCmGJ4SZMHD0j6zJSemIKucpBACyvQsrlxIWC6f+GkbAHaAeBl8AZ
        HMxNxGCfdKbdsECA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Remove rt_mutex_timed_lock()
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210323213707.465154098@linutronix.de>
References: <20210323213707.465154098@linutronix.de>
MIME-Version: 1.0
Message-ID: <161657055130.398.14925466479432705109.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ba8c437e7cf3c8cc92f4b68b32b6b2217d2036d9
Gitweb:        https://git.kernel.org/tip/ba8c437e7cf3c8cc92f4b68b32b6b2217d2036d9
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 23 Mar 2021 22:30:20 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 24 Mar 2021 08:06:06 +01:00

locking/rtmutex: Remove rt_mutex_timed_lock()

rt_mutex_timed_lock() has no callers since commit:

  c051b21f71d1f ("rtmutex: Confine deadlock logic to futex")

Remove it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210323213707.465154098@linutronix.de
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
