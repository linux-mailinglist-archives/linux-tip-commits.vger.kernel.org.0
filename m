Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA234337C8F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Mar 2021 19:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhCKSZN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 11 Mar 2021 13:25:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42036 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhCKSY5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 11 Mar 2021 13:24:57 -0500
Date:   Thu, 11 Mar 2021 18:24:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615487096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+wREjMW8mf7PNBW3Xe2n2mtf8j3Mr5HeWBBUvek8Jc=;
        b=kzQi/LU3bBwrg77N6aPk9ZMBN9XaRSdBglxfLHjL5IXtqgy1UIKS1vwV64MD+n1gb4oGTs
        wAYT7UiEW6/5tmoIhjqsKdPIKMZqk6B3aD2QCLoUKXjV4UvSe9xJ9AFM1uLTpk0Rtuwbo5
        Cl3N29e9qsjvZAVI66mmm4c3pwiTYkOHaTe0l52ueZ9OmikYxVPhVj9pJyhhJpWfebqjTP
        Os4bGMRgxEgpMGicDQ2eBnp3ACwNWRFOr/kUA7AhD/DtlfPfENFHXvuXx0bsNhCqcWoL3x
        i+p7eTJ8DRe8wVliZKTZ6yGfBVrzLI50mb1nBpiraWmISA1ri69gBSNMXW+vGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615487096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+wREjMW8mf7PNBW3Xe2n2mtf8j3Mr5HeWBBUvek8Jc=;
        b=DyMfoyt1qgEQfdbMa8xehx0RYJm3lF+f38J1tLKxPENcu5JQd+XhR2KbYJFIochAWU2aAJ
        DGBHQ5+IbtdEzsDg==
From:   "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kernel/futex: Kill rt_mutex_next_owner()
Cc:     Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210226175029.50335-1-dave@stgolabs.net>
References: <20210226175029.50335-1-dave@stgolabs.net>
MIME-Version: 1.0
Message-ID: <161548709569.398.2384544246863877762.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9a4b99fce659c03699f1cb5003ebe7c57c084d49
Gitweb:        https://git.kernel.org/tip/9a4b99fce659c03699f1cb5003ebe7c57c084d49
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Fri, 26 Feb 2021 09:50:26 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 11 Mar 2021 19:19:17 +01:00

kernel/futex: Kill rt_mutex_next_owner()

Update wake_futex_pi() and kill the call altogether. This is possible because:

(i) The case of fixup_owner() in which the pi_mutex was stolen from the
signaled enqueued top-waiter which fails to trylock and doesn't see a
current owner of the rtmutex but needs to acknowledge an non-enqueued
higher priority waiter, which is the other alternative. This used to be
handled by rt_mutex_next_owner(), which guaranteed fixup_pi_state_owner('newowner')
never to be nil. Nowadays the logic is handled by an EAGAIN loop, without
the need of rt_mutex_next_owner(). Specifically:

    c1e2f0eaf015 (futex: Avoid violating the 10th rule of futex)
    9f5d1c336a10 (futex: Handle transient "ownerless" rtmutex state correctly)

(ii) rt_mutex_next_owner() and rt_mutex_top_waiter() are semantically
equivalent, as of:

    c28d62cf52d7 (locking/rtmutex: Handle non enqueued waiters gracefully in remove_waiter())

So instead of keeping the call around, just use the good ole rt_mutex_top_waiter().
No change in semantics.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210226175029.50335-1-dave@stgolabs.net

---
 kernel/futex.c                  |  7 +++++--
 kernel/locking/rtmutex.c        | 20 --------------------
 kernel/locking/rtmutex_common.h |  1 -
 3 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index e68db77..db8002d 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1494,13 +1494,14 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
 static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_state)
 {
 	u32 curval, newval;
+	struct rt_mutex_waiter *top_waiter;
 	struct task_struct *new_owner;
 	bool postunlock = false;
 	DEFINE_WAKE_Q(wake_q);
 	int ret = 0;
 
-	new_owner = rt_mutex_next_owner(&pi_state->pi_mutex);
-	if (WARN_ON_ONCE(!new_owner)) {
+	top_waiter = rt_mutex_top_waiter(&pi_state->pi_mutex);
+	if (WARN_ON_ONCE(!top_waiter)) {
 		/*
 		 * As per the comment in futex_unlock_pi() this should not happen.
 		 *
@@ -1513,6 +1514,8 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_
 		goto out_unlock;
 	}
 
+	new_owner = top_waiter->task;
+
 	/*
 	 * We pass it to the next owner. The WAITERS bit is always kept
 	 * enabled while there is PI state around. We cleanup the owner
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 48fff64..29f09d0 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1793,26 +1793,6 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 }
 
 /**
- * rt_mutex_next_owner - return the next owner of the lock
- *
- * @lock: the rt lock query
- *
- * Returns the next owner of the lock or NULL
- *
- * Caller has to serialize against other accessors to the lock
- * itself.
- *
- * Special API call for PI-futex support
- */
-struct task_struct *rt_mutex_next_owner(struct rt_mutex *lock)
-{
-	if (!rt_mutex_has_waiters(lock))
-		return NULL;
-
-	return rt_mutex_top_waiter(lock)->task;
-}
-
-/**
  * rt_mutex_wait_proxy_lock() - Wait for lock acquisition
  * @lock:		the rt_mutex we were woken on
  * @to:			the timeout, null if none. hrtimer should already have
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index ca6fb48..a5007f0 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -130,7 +130,6 @@ enum rtmutex_chainwalk {
 /*
  * PI-futex support (proxy locking functions, etc.):
  */
-extern struct task_struct *rt_mutex_next_owner(struct rt_mutex *lock);
 extern void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
 				       struct task_struct *proxy_owner);
 extern void rt_mutex_proxy_unlock(struct rt_mutex *lock);
