Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4B13EF33B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhHQUOl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34586 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbhHQUOj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:39 -0400
Date:   Tue, 17 Aug 2021 20:14:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231245;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4cZCfZDm8Is9Jhpii4ExmW0FU+lto7zpDaa15B2/CPk=;
        b=mcx20yOs0+A1Pcu2gdFxnZmrNFI5vDtypVINbfLfk25R4foFJZxugO+fjDW33ZQOheZtLh
        0mmya+M+/j1cN5ieOvaLksP7KbMn5JGRWlDc99F5QJErFxIF53JQnj+++wbBKtHdRcN2uY
        F2cY26yFI5KPouz2lI5clLAJ86f2IUyj3sZQsXg1XIx00IJsZf88dL4N7yBy+1ih693gDm
        ZKEXlCq5V61l6o9UG3xaINQIsCyGCpIZA4Dfu8T1Qbh3ifA3hK+8oT/G0qzLuffrOUwO8w
        1/CceaU+W0Um9aNwVLAvWI1wFuhfEgP/XQE2Qzul1ETWvN9aTj1gdNHYv2A7aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231245;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4cZCfZDm8Is9Jhpii4ExmW0FU+lto7zpDaa15B2/CPk=;
        b=2LP1xZCTBxBRykKoFOvdReUsCb/4k5XoBB+jtzwL9qx0RCRvWLWWXuJ8ZkHTa+EDcERP5v
        SBxz8rwVYTIZ/fBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Clean up stale comments
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211305.249178312@linutronix.de>
References: <20210815211305.249178312@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923124464.25758.10857186183431942989.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c363b7ed79253d5b53494197f6ae625cff64694f
Gitweb:        https://git.kernel.org/tip/c363b7ed79253d5b53494197f6ae625cff64694f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:29:06 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:05:39 +02:00

futex: Clean up stale comments

The futex key reference mechanism is long gone. Clean up the stale comments
which still mention it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211305.249178312@linutronix.de
---
 kernel/futex.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index a1f27fd..bc5395e 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1354,7 +1354,7 @@ static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
  *  -  1 - acquired the lock;
  *  - <0 - error
  *
- * The hb->lock and futex_key refs shall be held by the caller.
+ * The hb->lock must be held by the caller.
  *
  * @exiting is only set when the return value is -EBUSY. If so, this holds
  * a refcount on the exiting task on return and the caller needs to drop it
@@ -2621,8 +2621,7 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
  *
  * Setup the futex_q and locate the hash_bucket.  Get the futex value and
  * compare it with the expected value.  Handle atomic faults internally.
- * Return with the hb lock held and a q.key reference on success, and unlocked
- * with no q.key reference on failure.
+ * Return with the hb lock held on success, and unlocked on failure.
  *
  * Return:
  *  -  0 - uaddr contains val and hb has been locked;
@@ -2700,8 +2699,8 @@ static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 			       current->timer_slack_ns);
 retry:
 	/*
-	 * Prepare to wait on uaddr. On success, holds hb lock and increments
-	 * q.key refs.
+	 * Prepare to wait on uaddr. On success, it holds hb->lock and q
+	 * is initialized.
 	 */
 	ret = futex_wait_setup(uaddr, val, flags, &q, &hb);
 	if (ret)
@@ -2712,7 +2711,6 @@ retry:
 
 	/* If we were woken (and unqueued), we succeeded, whatever. */
 	ret = 0;
-	/* unqueue_me() drops q.key ref */
 	if (!unqueue_me(&q))
 		goto out;
 	ret = -ETIMEDOUT;
@@ -3205,8 +3203,8 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	q.requeue_pi_key = &key2;
 
 	/*
-	 * Prepare to wait on uaddr. On success, increments q.key (key1) ref
-	 * count.
+	 * Prepare to wait on uaddr. On success, it holds hb->lock and q
+	 * is initialized.
 	 */
 	ret = futex_wait_setup(uaddr, val, flags, &q, &hb);
 	if (ret)
@@ -3235,9 +3233,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	 * In order for us to be here, we know our q.key == key2, and since
 	 * we took the hb->lock above, we also know that futex_requeue() has
 	 * completed and we no longer have to concern ourselves with a wakeup
-	 * race with the atomic proxy lock acquisition by the requeue code. The
-	 * futex_requeue dropped our key1 reference and incremented our key2
-	 * reference count.
+	 * race with the atomic proxy lock acquisition by the requeue code.
 	 */
 
 	/*
