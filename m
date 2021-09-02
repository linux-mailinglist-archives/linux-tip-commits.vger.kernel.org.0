Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37B03FF46A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  2 Sep 2021 21:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347473AbhIBT4E (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 2 Sep 2021 15:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244551AbhIBT4D (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 2 Sep 2021 15:56:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6797C061757;
        Thu,  2 Sep 2021 12:55:04 -0700 (PDT)
Date:   Thu, 02 Sep 2021 19:55:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630612502;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/JKdc2hvR+9J1iyecwaN4mrIrCVCK1X8VKZWZhqFL04=;
        b=FAQcMf2N09oQsfSpq70z0OHHeIAbPVPyIC4zFHVzDJRnClZ6npdzfybzzzcVYVsgU4znu9
        JBhXp5Sl560y17OrdBLfef4Q9dt9l9penQOsxOdugbnmENNcj5tBrNjamOFP6ExNEap0l9
        INnSimGikaEr9KHsKgOI+viaGa7pkye86lyNJlFFhhJnwrf9/bHFa2XQsKg9RUxGqhjeqi
        psJGngwhiCZ2qVkipTAur5vE8mhy2Vwu4qz2prC7ufV5kYZ5v9UZQqG+Ri7qsdby2XN1GC
        hPFZOEfuRNDles1Fn0CRlqn51nr66h2m3XB+Iunv6ztzms/W9LPMUx3Guk8QRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630612502;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/JKdc2hvR+9J1iyecwaN4mrIrCVCK1X8VKZWZhqFL04=;
        b=tnr3Q5hHWcNFMcAiXiBRzQmyqDl/88T/bhucWjGcnhteh+gKDpYaIUtRNjSDMYBh91BzdE
        S1MdoOb6pw/ORJAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Prevent inconsistent state and exit race
Cc:     syzbot+4d1bd0725ef09168e1a0@syzkaller.appspotmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210902094414.558914045@linutronix.de>
References: <20210902094414.558914045@linutronix.de>
MIME-Version: 1.0
Message-ID: <163061250194.25758.14564058163345850842.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     340fd7c048184554c2524604cb8059794a01c686
Gitweb:        https://git.kernel.org/tip/340fd7c048184554c2524604cb8059794a01c686
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 02 Sep 2021 11:48:48 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 02 Sep 2021 21:29:48 +02:00

futex: Prevent inconsistent state and exit race

The recent rework of the requeue PI code introduced a possibility for
going back to user space in inconsistent state:

CPU 0				CPU 1

requeue_futex()
  if (lock_pifutex_user()) {
      dequeue_waiter();
      wake_waiter(task);
				sched_in(task);
     				return_from_futex_syscall();

  ---> Inconsistent state because PI state is not established

It becomes worse if the woken up task immediately exits:

				sys_exit();
				
      attach_pistate(vpid);	<--- FAIL


Attach the pi state before dequeuing and waking the waiter. If the waiter
gets a spurious wakeup before the dequeue operation it will wait in
futex_requeue_pi_wakeup_sync() and therefore cannot return and exit.

Fixes: 07d91ef510fb ("futex: Prevent requeue_pi() lock nesting issue on RT")
Reported-by: syzbot+4d1bd0725ef09168e1a0@syzkaller.appspotmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210902094414.558914045@linutronix.de

---
 kernel/futex.c | 98 +++++++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 43 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 30e7dae..04164d4 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1454,8 +1454,23 @@ static int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
 			newval |= FUTEX_WAITERS;
 
 		ret = lock_pi_update_atomic(uaddr, uval, newval);
-		/* If the take over worked, return 1 */
-		return ret < 0 ? ret : 1;
+		if (ret)
+			return ret;
+
+		/*
+		 * If the waiter bit was requested the caller also needs PI
+		 * state attached to the new owner of the user space futex.
+		 *
+		 * @task is guaranteed to be alive and it cannot be exiting
+		 * because it is either sleeping or waiting in
+		 * futex_requeue_pi_wakeup_sync().
+		 */
+		if (set_waiters) {
+			 ret = attach_to_pi_owner(uaddr, newval, key, ps,
+						  exiting);
+			 WARN_ON(ret);
+		}
+		return 1;
 	}
 
 	/*
@@ -2036,17 +2051,24 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
 		return -EAGAIN;
 
 	/*
-	 * Try to take the lock for top_waiter.  Set the FUTEX_WAITERS bit in
-	 * the contended case or if set_waiters is 1.  The pi_state is returned
-	 * in ps in contended cases.
+	 * Try to take the lock for top_waiter and set the FUTEX_WAITERS bit
+	 * in the contended case or if @set_waiters is true.
+	 *
+	 * In the contended case PI state is attached to the lock owner. If
+	 * the user space lock can be acquired then PI state is attached to
+	 * the new owner (@top_waiter->task) when @set_waiters is true.
 	 */
 	vpid = task_pid_vnr(top_waiter->task);
 	ret = futex_lock_pi_atomic(pifutex, hb2, key2, ps, top_waiter->task,
 				   exiting, set_waiters);
 	if (ret == 1) {
-		/* Dequeue, wake up and update top_waiter::requeue_state */
+		/*
+		 * Lock was acquired in user space and PI state was
+		 * attached to @top_waiter->task. That means state is fully
+		 * consistent and the waiter can return to user space
+		 * immediately after the wakeup.
+		 */
 		requeue_pi_wake_futex(top_waiter, key2, hb2);
-		return vpid;
 	} else if (ret < 0) {
 		/* Rewind top_waiter::requeue_state */
 		futex_requeue_pi_complete(top_waiter, ret);
@@ -2208,19 +2230,26 @@ retry_private:
 						 &exiting, nr_requeue);
 
 		/*
-		 * At this point the top_waiter has either taken uaddr2 or is
-		 * waiting on it.  If the former, then the pi_state will not
-		 * exist yet, look it up one more time to ensure we have a
-		 * reference to it. If the lock was taken, @ret contains the
-		 * VPID of the top waiter task.
-		 * If the lock was not taken, we have pi_state and an initial
-		 * refcount on it. In case of an error we have nothing.
+		 * At this point the top_waiter has either taken uaddr2 or
+		 * is waiting on it. In both cases pi_state has been
+		 * established and an initial refcount on it. In case of an
+		 * error there's nothing.
 		 *
 		 * The top waiter's requeue_state is up to date:
 		 *
-		 *  - If the lock was acquired atomically (ret > 0), then
+		 *  - If the lock was acquired atomically (ret == 1), then
 		 *    the state is Q_REQUEUE_PI_LOCKED.
 		 *
+		 *    The top waiter has been dequeued and woken up and can
+		 *    return to user space immediately. The kernel/user
+		 *    space state is consistent. In case that there must be
+		 *    more waiters requeued the WAITERS bit in the user
+		 *    space futex is set so the top waiter task has to go
+		 *    into the syscall slowpath to unlock the futex. This
+		 *    will block until this requeue operation has been
+		 *    completed and the hash bucket locks have been
+		 *    dropped.
+		 *
 		 *  - If the trylock failed with an error (ret < 0) then
 		 *    the state is either Q_REQUEUE_PI_NONE, i.e. "nothing
 		 *    happened", or Q_REQUEUE_PI_IGNORE when there was an
@@ -2234,36 +2263,20 @@ retry_private:
 		 *    the same sanity checks for requeue_pi as the loop
 		 *    below does.
 		 */
-		if (ret > 0) {
-			WARN_ON(pi_state);
-			task_count++;
-			/*
-			 * If futex_proxy_trylock_atomic() acquired the
-			 * user space futex, then the user space value
-			 * @uaddr2 has been set to the @hb1's top waiter
-			 * task VPID. This task is guaranteed to be alive
-			 * and cannot be exiting because it is either
-			 * sleeping or blocked on @hb2 lock.
-			 *
-			 * The @uaddr2 futex cannot have waiters either as
-			 * otherwise futex_proxy_trylock_atomic() would not
-			 * have succeeded.
-			 *
-			 * In order to requeue waiters to @hb2, pi state is
-			 * required. Hand in the VPID value (@ret) and
-			 * allocate PI state with an initial refcount on
-			 * it.
-			 */
-			ret = attach_to_pi_owner(uaddr2, ret, &key2, &pi_state,
-						 &exiting);
-			WARN_ON(ret);
-		}
-
 		switch (ret) {
 		case 0:
 			/* We hold a reference on the pi state. */
 			break;
 
+		case 1:
+			/*
+			 * futex_proxy_trylock_atomic() acquired the user space
+			 * futex. Adjust task_count.
+			 */
+			task_count++;
+			ret = 0;
+			break;
+
 		/*
 		 * If the above failed, then pi_state is NULL and
 		 * waiter::requeue_state is correct.
@@ -2395,9 +2408,8 @@ retry_private:
 	}
 
 	/*
-	 * We took an extra initial reference to the pi_state either in
-	 * futex_proxy_trylock_atomic() or in attach_to_pi_owner(). We need
-	 * to drop it here again.
+	 * We took an extra initial reference to the pi_state in
+	 * futex_proxy_trylock_atomic(). We need to drop it here again.
 	 */
 	put_pi_state(pi_state);
 
