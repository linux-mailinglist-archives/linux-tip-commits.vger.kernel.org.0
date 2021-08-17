Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6123EF336
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbhHQUOj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbhHQUOg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C00C06179A;
        Tue, 17 Aug 2021 13:14:02 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hagTnhJ7LtkuSI4ry32/Uu0nhg6d1jQvOPfr+Cm+4fo=;
        b=JYqnS6jtzIZYXlQQaHDMXefoV9ImCn+3N3DTABgO4fFugFjQevGJbU+bJ7wIELnteI2a6I
        u9kk4c34H+j+7tjmRttZeMNcebk1e+ex9ggYuWHApaLthu8eCgKoGneCRRNAj+x+gtX5o9
        UrQm3T6kZjcHSzMSG6GxXfhxovWMvA0qC7edLWVbqZBIGWBWTm2WGxQCtNWOPdF4kM9xlQ
        XimSZlS0iFvIZSbJn8NyxTGG8A/lXJVfOlGzpwU+ccDcTkEy3aDNpUuY2nolp4d/fyc9Dm
        s55sNEBY16OqCIlbplS5kWVZhTCJE6oa6C/ozGxCz0JLGqgpsCRlwQRMLQQ39w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hagTnhJ7LtkuSI4ry32/Uu0nhg6d1jQvOPfr+Cm+4fo=;
        b=VvRhOjbJjh75/JGL1nmHpq8tWjQ2kMRk0ojT61IhxRRv8INbbLcoIzJumE9mauK2exYGBz
        l1676UEnMRMId/CA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Simplify handle_early_requeue_pi_wakeup()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211305.638938670@linutronix.de>
References: <20210815211305.638938670@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923124056.25758.2868990913914434391.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     6231acbd0802e76580c71ceb52c09646d42170fb
Gitweb:        https://git.kernel.org/tip/6231acbd0802e76580c71ceb52c09646d42170fb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:29:17 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:05:57 +02:00

futex: Simplify handle_early_requeue_pi_wakeup()

Move the futex key match out of handle_early_requeue_pi_wakeup() which
allows to simplify that function. The upcoming state machine for
requeue_pi() will make that go away.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211305.638938670@linutronix.de
---
 kernel/futex.c | 48 ++++++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index a5232f6..82660b9 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3070,27 +3070,22 @@ pi_faulted:
 }
 
 /**
- * handle_early_requeue_pi_wakeup() - Detect early wakeup on the initial futex
+ * handle_early_requeue_pi_wakeup() - Handle early wakeup on the initial futex
  * @hb:		the hash_bucket futex_q was original enqueued on
  * @q:		the futex_q woken while waiting to be requeued
- * @key2:	the futex_key of the requeue target futex
  * @timeout:	the timeout associated with the wait (NULL if none)
  *
- * Detect if the task was woken on the initial futex as opposed to the requeue
- * target futex.  If so, determine if it was a timeout or a signal that caused
- * the wakeup and return the appropriate error code to the caller.  Must be
- * called with the hb lock held.
+ * Determine the cause for the early wakeup.
  *
  * Return:
- *  -  0 = no early wakeup detected;
- *  - <0 = -ETIMEDOUT or -ERESTARTNOINTR
+ *  -EWOULDBLOCK or -ETIMEDOUT or -ERESTARTNOINTR
  */
 static inline
 int handle_early_requeue_pi_wakeup(struct futex_hash_bucket *hb,
-				   struct futex_q *q, union futex_key *key2,
+				   struct futex_q *q,
 				   struct hrtimer_sleeper *timeout)
 {
-	int ret = 0;
+	int ret;
 
 	/*
 	 * With the hb lock held, we avoid races while we process the wakeup.
@@ -3099,22 +3094,21 @@ int handle_early_requeue_pi_wakeup(struct futex_hash_bucket *hb,
 	 * It can't be requeued from uaddr2 to something else since we don't
 	 * support a PI aware source futex for requeue.
 	 */
-	if (!match_futex(&q->key, key2)) {
-		WARN_ON(q->lock_ptr && (&hb->lock != q->lock_ptr));
-		/*
-		 * We were woken prior to requeue by a timeout or a signal.
-		 * Unqueue the futex_q and determine which it was.
-		 */
-		plist_del(&q->list, &hb->chain);
-		hb_waiters_dec(hb);
+	WARN_ON_ONCE(&hb->lock != q->lock_ptr);
 
-		/* Handle spurious wakeups gracefully */
-		ret = -EWOULDBLOCK;
-		if (timeout && !timeout->task)
-			ret = -ETIMEDOUT;
-		else if (signal_pending(current))
-			ret = -ERESTARTNOINTR;
-	}
+	/*
+	 * We were woken prior to requeue by a timeout or a signal.
+	 * Unqueue the futex_q and determine which it was.
+	 */
+	plist_del(&q->list, &hb->chain);
+	hb_waiters_dec(hb);
+
+	/* Handle spurious wakeups gracefully */
+	ret = -EWOULDBLOCK;
+	if (timeout && !timeout->task)
+		ret = -ETIMEDOUT;
+	else if (signal_pending(current))
+		ret = -ERESTARTNOINTR;
 	return ret;
 }
 
@@ -3217,7 +3211,9 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	futex_wait_queue_me(hb, &q, to);
 
 	spin_lock(&hb->lock);
-	ret = handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
+	/* Is @q still queued on uaddr1? */
+	if (!match_futex(&q->key, key2))
+		ret = handle_early_requeue_pi_wakeup(hb, &q, to);
 	spin_unlock(&hb->lock);
 	if (ret)
 		goto out;
