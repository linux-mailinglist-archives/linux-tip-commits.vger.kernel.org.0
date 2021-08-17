Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED293EF332
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbhHQUOh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:14:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34586 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbhHQUOh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:37 -0400
Date:   Tue, 17 Aug 2021 20:14:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3uMqG0HDLsf7C0B4o5ErmK7vnMV6hs8REyQ738vq/ck=;
        b=0j735FVNV93CBpakwf1sRAmdsFUPvVCjurkLkRHZLM0RSNmFuNjz/V5bMQSFB+7kurFaf8
        EeugCboPQvZbDLIboCAEPcLIXJyxFm8EOIxDtKFp10KKNnASikb4i8HdW4mq7b6LDPoWJg
        zvhuQMgnIKP9sZKr7HgiizALYQc2UPCj3loqkAIKPzVNa5q3w7tWTSqUPtCnVjZzMI4NpX
        fYPuk4uv4trQqrnWtztBk0xW+wbTxVvx6exDUape2uf13AGV6tLOgI7lqMhiD0HWTUKffI
        h3SH1ZSJ2aExqHkavngPPCSn8DUznjA9ckCrqTj9Js+1EyqBsmrDIxS1MJb0LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231243;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3uMqG0HDLsf7C0B4o5ErmK7vnMV6hs8REyQ738vq/ck=;
        b=6NbAdjP7n7VEZ84pS+y+ug0CEeWC6dFV/t9TSbmXGogCgYaZAmgsJGqQGZCvhC06HA3HHZ
        AYZt8s9J0nFSxoCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Restructure futex_requeue()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211305.468835790@linutronix.de>
References: <20210815211305.468835790@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923124225.25758.7500739087491943920.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     64b7b715f7f92ae3233446b4a4cdda3524fcd4b0
Gitweb:        https://git.kernel.org/tip/64b7b715f7f92ae3233446b4a4cdda3524fcd4b0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:29:12 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 19:05:49 +02:00

futex: Restructure futex_requeue()

No point in taking two more 'requeue_pi' conditionals just to get to the
requeue. Same for the requeue_pi case just the other way round.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211305.468835790@linutronix.de
---
 kernel/futex.c | 90 ++++++++++++++++++++++---------------------------
 1 file changed, 41 insertions(+), 49 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 5439742..6cb6b5d 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2104,20 +2104,17 @@ retry_private:
 			break;
 		}
 
-		/*
-		 * Wake nr_wake waiters.  For requeue_pi, if we acquired the
-		 * lock, we already woke the top_waiter.  If not, it will be
-		 * woken by futex_unlock_pi().
-		 */
-		if (++task_count <= nr_wake && !requeue_pi) {
-			mark_wake_futex(&wake_q, this);
+		/* Plain futexes just wake or requeue and are done */
+		if (!requeue_pi) {
+			if (++task_count <= nr_wake)
+				mark_wake_futex(&wake_q, this);
+			else
+				requeue_futex(this, hb1, hb2, &key2);
 			continue;
 		}
 
 		/* Ensure we requeue to the expected futex for requeue_pi. */
-		if (requeue_pi && !match_futex(this->requeue_pi_key, &key2)) {
-			/* Don't account for it */
-			task_count--;
+		if (!match_futex(this->requeue_pi_key, &key2)) {
 			ret = -EINVAL;
 			break;
 		}
@@ -2125,50 +2122,45 @@ retry_private:
 		/*
 		 * Requeue nr_requeue waiters and possibly one more in the case
 		 * of requeue_pi if we couldn't acquire the lock atomically.
+		 *
+		 * Prepare the waiter to take the rt_mutex. Take a refcount
+		 * on the pi_state and store the pointer in the futex_q
+		 * object of the waiter.
 		 */
-		if (requeue_pi) {
+		get_pi_state(pi_state);
+		this->pi_state = pi_state;
+		ret = rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
+						this->rt_waiter, this->task);
+		if (ret == 1) {
 			/*
-			 * Prepare the waiter to take the rt_mutex. Take a
-			 * refcount on the pi_state and store the pointer in
-			 * the futex_q object of the waiter.
+			 * We got the lock. We do neither drop the refcount
+			 * on pi_state nor clear this->pi_state because the
+			 * waiter needs the pi_state for cleaning up the
+			 * user space value. It will drop the refcount
+			 * after doing so.
 			 */
-			get_pi_state(pi_state);
-			this->pi_state = pi_state;
-			ret = rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
-							this->rt_waiter,
-							this->task);
-			if (ret == 1) {
-				/*
-				 * We got the lock. We do neither drop the
-				 * refcount on pi_state nor clear
-				 * this->pi_state because the waiter needs the
-				 * pi_state for cleaning up the user space
-				 * value. It will drop the refcount after
-				 * doing so.
-				 */
-				requeue_pi_wake_futex(this, &key2, hb2);
-				continue;
-			} else if (ret) {
-				/*
-				 * rt_mutex_start_proxy_lock() detected a
-				 * potential deadlock when we tried to queue
-				 * that waiter. Drop the pi_state reference
-				 * which we took above and remove the pointer
-				 * to the state from the waiters futex_q
-				 * object.
-				 */
-				this->pi_state = NULL;
-				put_pi_state(pi_state);
-				/* Don't account for it */
-				task_count--;
-				/*
-				 * We stop queueing more waiters and let user
-				 * space deal with the mess.
-				 */
-				break;
-			}
+			requeue_pi_wake_futex(this, &key2, hb2);
+			task_count++;
+			continue;
+		} else if (ret) {
+			/*
+			 * rt_mutex_start_proxy_lock() detected a potential
+			 * deadlock when we tried to queue that waiter.
+			 * Drop the pi_state reference which we took above
+			 * and remove the pointer to the state from the
+			 * waiters futex_q object.
+			 */
+			this->pi_state = NULL;
+			put_pi_state(pi_state);
+			/*
+			 * We stop queueing more waiters and let user space
+			 * deal with the mess.
+			 */
+			break;
 		}
+		/* Waiter is queued, move it to hb2 */
 		requeue_futex(this, hb1, hb2, &key2);
+		task_count++;
 	}
 
 	/*
