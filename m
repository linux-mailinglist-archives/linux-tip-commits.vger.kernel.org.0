Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFA93FF4A8
	for <lists+linux-tip-commits@lfdr.de>; Thu,  2 Sep 2021 22:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbhIBUPa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 2 Sep 2021 16:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhIBUP3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 2 Sep 2021 16:15:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7F6C061575;
        Thu,  2 Sep 2021 13:14:31 -0700 (PDT)
Date:   Thu, 02 Sep 2021 20:14:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630613669;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8M5OQNfh6zIuqhmTJRFXBuA6eSxSmLe7bUbOqe0KhGk=;
        b=Mv8WomProfj1Ikx1VhD6kwujiI0KhKA+wmR98+vDWx1QuzF/JA8iYrBV58BfHRKXudsjKP
        U6UVzY0mMwwvGo++oWgAdiiZjyez9kX6LZzXJpQwp7CQAcIzpdRN8jQzv6WHIwXZD2DfTx
        y9qTam3b0FLf4SzSUqHIarbtlpeS22okYkDUhfbITeggo6HdtRR2eSNxa10N11+bBHOUfg
        SBbdvRLOgcnl3HtnMjMtXTGEeODPfyG4aN7+tVO4OGZsqqakFIp8Mzw10iz9+6TxV1qOkl
        46Dl9T3XSkE7ym2QZe8AjK4F3G0dD36GhkwWbrs6nRpGVURf1jwQMfBODNiR5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630613669;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8M5OQNfh6zIuqhmTJRFXBuA6eSxSmLe7bUbOqe0KhGk=;
        b=6oBeH9jxbZ9oUWgb7+r+ure11B+aKwhLeL1NHspGDT3/XMhBFI1R8SBlwR1YaDbb9Ctv9R
        3kUiDfGNhjrQhIBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Avoid redundant task lookup
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210902094414.676104881@linutronix.de>
References: <20210902094414.676104881@linutronix.de>
MIME-Version: 1.0
Message-ID: <163061366865.25758.11390998302035041038.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     340576590dac4bb58d532a8ad5bfa806d8ab473c
Gitweb:        https://git.kernel.org/tip/340576590dac4bb58d532a8ad5bfa806d8ab473c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 02 Sep 2021 11:48:51 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 02 Sep 2021 22:07:18 +02:00

futex: Avoid redundant task lookup

No need to do the full VPID based task lookup and validation of the top
waiter when the user space futex was acquired on it's behalf during the
requeue_pi operation. The task is known already and it cannot go away
before requeue_pi_wake_futex() has been invoked.

Split out the actual attach code from attach_pi_state_owner() and use that
instead of the full blown variant.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210902094414.676104881@linutronix.de


---
 kernel/futex.c | 67 +++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 82cd270..a316dce 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1263,6 +1263,36 @@ static int handle_exit_race(u32 __user *uaddr, u32 uval,
 	return -ESRCH;
 }
 
+static void __attach_to_pi_owner(struct task_struct *p, union futex_key *key,
+				 struct futex_pi_state **ps)
+{
+	/*
+	 * No existing pi state. First waiter. [2]
+	 *
+	 * This creates pi_state, we have hb->lock held, this means nothing can
+	 * observe this state, wait_lock is irrelevant.
+	 */
+	struct futex_pi_state *pi_state = alloc_pi_state();
+
+	/*
+	 * Initialize the pi_mutex in locked state and make @p
+	 * the owner of it:
+	 */
+	rt_mutex_init_proxy_locked(&pi_state->pi_mutex, p);
+
+	/* Store the key for possible exit cleanups: */
+	pi_state->key = *key;
+
+	WARN_ON(!list_empty(&pi_state->list));
+	list_add(&pi_state->list, &p->pi_state_list);
+	/*
+	 * Assignment without holding pi_state->pi_mutex.wait_lock is safe
+	 * because there is no concurrency as the object is not published yet.
+	 */
+	pi_state->owner = p;
+
+	*ps = pi_state;
+}
 /*
  * Lookup the task for the TID provided from user space and attach to
  * it after doing proper sanity checks.
@@ -1272,7 +1302,6 @@ static int attach_to_pi_owner(u32 __user *uaddr, u32 uval, union futex_key *key,
 			      struct task_struct **exiting)
 {
 	pid_t pid = uval & FUTEX_TID_MASK;
-	struct futex_pi_state *pi_state;
 	struct task_struct *p;
 
 	/*
@@ -1324,36 +1353,11 @@ static int attach_to_pi_owner(u32 __user *uaddr, u32 uval, union futex_key *key,
 		return ret;
 	}
 
-	/*
-	 * No existing pi state. First waiter. [2]
-	 *
-	 * This creates pi_state, we have hb->lock held, this means nothing can
-	 * observe this state, wait_lock is irrelevant.
-	 */
-	pi_state = alloc_pi_state();
-
-	/*
-	 * Initialize the pi_mutex in locked state and make @p
-	 * the owner of it:
-	 */
-	rt_mutex_init_proxy_locked(&pi_state->pi_mutex, p);
-
-	/* Store the key for possible exit cleanups: */
-	pi_state->key = *key;
-
-	WARN_ON(!list_empty(&pi_state->list));
-	list_add(&pi_state->list, &p->pi_state_list);
-	/*
-	 * Assignment without holding pi_state->pi_mutex.wait_lock is safe
-	 * because there is no concurrency as the object is not published yet.
-	 */
-	pi_state->owner = p;
+	__attach_to_pi_owner(p, key, ps);
 	raw_spin_unlock_irq(&p->pi_lock);
 
 	put_task_struct(p);
 
-	*ps = pi_state;
-
 	return 0;
 }
 
@@ -1464,11 +1468,14 @@ static int futex_lock_pi_atomic(u32 __user *uaddr, struct futex_hash_bucket *hb,
 		 * @task is guaranteed to be alive and it cannot be exiting
 		 * because it is either sleeping or waiting in
 		 * futex_requeue_pi_wakeup_sync().
+		 *
+		 * No need to do the full attach_to_pi_owner() exercise
+		 * because @task is known and valid.
 		 */
 		if (set_waiters) {
-			 ret = attach_to_pi_owner(uaddr, newval, key, ps,
-						  exiting);
-			 WARN_ON(ret);
+			raw_spin_lock_irq(&task->pi_lock);
+			__attach_to_pi_owner(task, key, ps);
+			raw_spin_unlock_irq(&task->pi_lock);
 		}
 		return 1;
 	}
