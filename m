Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE24D37EDCA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 May 2021 00:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346045AbhELUyb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 16:54:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53194 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355079AbhELS1N (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 14:27:13 -0400
Date:   Wed, 12 May 2021 18:26:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620843962;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gMKXE1uKagYjAdNzad/SCNIV/mJntvL5NyqzVKofiW0=;
        b=xnzU0aJRWO9C8+i8GJXgfTGBNZVlxYK7sjh9TgNnGgC6HVb5OaYcr6ZWcWXfjAis0gS0nY
        pXuCeG1ZI6UtTMcQqDbxZ1DNHzF11vGhhg8xwNs/ZngAjPuVMNjqbc6s7srYmJpLyWDArE
        x3QTVCd0yaaJgYBX4y2NBFhHUZxUv/OxCdJtZ6838LhCP1br3B4gRZmI3ZkjxHM+ilYlx+
        vuy0SzxeuIrT2R7WBMM2DJaSZhqHcQqMWui5/NZvek7gcflHOnv//Xl23CJqVqNkhGeeRC
        8wzeScmitU7pN8UXpEiJyZLviPgY262CBn2WXcbepsQvmrSHmgFU5vbJdOpabw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620843962;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gMKXE1uKagYjAdNzad/SCNIV/mJntvL5NyqzVKofiW0=;
        b=KVcdKH5lRKnapONy0TJQIWAGPP0VRkxp3zO/HIydBK09MxoZrjMn7aETRykawGf6Q5iHKf
        PbBuWVbWlRQAhtCw==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking: Fix comment typos
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162084396182.29796.4910292329768296928.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     93d0955e6cf562d02aae37f5f8d98d9d9d16e0d4
Gitweb:        https://git.kernel.org/tip/93d0955e6cf562d02aae37f5f8d98d9d9d16e0d4
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 12 May 2021 20:04:28 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 20:11:17 +02:00

locking: Fix comment typos

A few snuck through.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/lockdep_types.h |  2 +-
 kernel/futex.c                | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index 2ec9ff5..3e726ac 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -52,7 +52,7 @@ enum lockdep_lock_type {
  * NR_LOCKDEP_CACHING_CLASSES ... Number of classes
  * cached in the instance of lockdep_map
  *
- * Currently main class (subclass == 0) and signle depth subclass
+ * Currently main class (subclass == 0) and single depth subclass
  * are cached in lockdep_map. This optimization is mainly targeting
  * on rq->lock. double_rq_lock() acquires this highly competitive with
  * single depth.
diff --git a/kernel/futex.c b/kernel/futex.c
index 4938a00..2f386f0 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1874,7 +1874,7 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct futex_hash_bucket *hb1,
 	 * If the caller intends to requeue more than 1 waiter to pifutex,
 	 * force futex_lock_pi_atomic() to set the FUTEX_WAITERS bit now,
 	 * as we have means to handle the possible fault.  If not, don't set
-	 * the bit unecessarily as it will force the subsequent unlock to enter
+	 * the bit unnecessarily as it will force the subsequent unlock to enter
 	 * the kernel.
 	 */
 	top_waiter = futex_top_waiter(hb1, key1);
@@ -2103,7 +2103,7 @@ retry_private:
 			continue;
 
 		/*
-		 * FUTEX_WAIT_REQEUE_PI and FUTEX_CMP_REQUEUE_PI should always
+		 * FUTEX_WAIT_REQUEUE_PI and FUTEX_CMP_REQUEUE_PI should always
 		 * be paired with each other and no other futex ops.
 		 *
 		 * We should never be requeueing a futex_q with a pi_state,
@@ -2318,7 +2318,7 @@ retry:
 }
 
 /*
- * PI futexes can not be requeued and must remove themself from the
+ * PI futexes can not be requeued and must remove themselves from the
  * hash bucket. The hash bucket lock (i.e. lock_ptr) is held.
  */
 static void unqueue_me_pi(struct futex_q *q)
@@ -2903,7 +2903,7 @@ no_block:
 	 */
 	res = fixup_owner(uaddr, &q, !ret);
 	/*
-	 * If fixup_owner() returned an error, proprogate that.  If it acquired
+	 * If fixup_owner() returned an error, propagate that.  If it acquired
 	 * the lock, clear our -ETIMEDOUT or -EINTR.
 	 */
 	if (res)
@@ -3280,7 +3280,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		 */
 		res = fixup_owner(uaddr2, &q, !ret);
 		/*
-		 * If fixup_owner() returned an error, proprogate that.  If it
+		 * If fixup_owner() returned an error, propagate that.  If it
 		 * acquired the lock, clear -ETIMEDOUT or -EINTR.
 		 */
 		if (res)
@@ -3678,7 +3678,7 @@ void futex_exec_release(struct task_struct *tsk)
 {
 	/*
 	 * The state handling is done for consistency, but in the case of
-	 * exec() there is no way to prevent futher damage as the PID stays
+	 * exec() there is no way to prevent further damage as the PID stays
 	 * the same. But for the unlikely and arguably buggy case that a
 	 * futex is held on exec(), this provides at least as much state
 	 * consistency protection which is possible.
