Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB6C4278C0
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244595AbhJIKJS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:09:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49368 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244605AbhJIKJM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:12 -0400
Date:   Sat, 09 Oct 2021 10:07:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774035;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gALDwjQ0wkyA/rxuUeM6MjE/AC8ThEe8PO2DfQ3DwWU=;
        b=yuFun0cyViBsGZdL+kzRt3yey0TafXxSanNd5ntncSkm7+v9uOxNRyu1NpVdeBFKsVRG7R
        cr+7L7dGf88AQ15/8vBBAjMnEZxtatsO9isS0I9bTRsdifOQ8sUgkzLMt7di4ic7p+eMvg
        wkKQCuqXJ1qmG+QnhjwDiSSMFXNIXkq+i2aEQbPdjk/2MZVUXC8GU1HxFbyE/VzVPXL4mw
        7IcB3C5N7vRsQb5dUPEus4Mx7BXpsAP8Ipep39i2F3SZXQ/v+T8xJnVkAGptdw10vfY8x1
        ae960wEWiRRYetcU/3nPaEGidS0bYKimq7tPIb0wDMrx8Rm3KOQGxtPqa2B/rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774035;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gALDwjQ0wkyA/rxuUeM6MjE/AC8ThEe8PO2DfQ3DwWU=;
        b=ZgovAJHgos4O8qGjfc67D3fbvhEKm73UURyMzycagaP4Hdb0bm2hQFVSdqInnFpkUuyzya
        daFnK9t4Tpvhs1Bg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Rename: queue_{,un}lock()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        andrealmeid@collabora.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923171111.300673-6-andrealmeid@collabora.com>
References: <20210923171111.300673-6-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <163377403471.25758.12884774975891932719.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e7ba9c8fed298fef5aa614685df61db6e6551fa0
Gitweb:        https://git.kernel.org/tip/e7ba9c8fed298fef5aa614685df61db6e65=
51fa0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 Sep 2021 14:10:54 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:08 +02:00

futex: Rename: queue_{,un}lock()

In order to prepare introducing these symbols into the global
namespace; rename them:

  s/queue_\(un\)*lock/futex_q_\1lock/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Link: https://lore.kernel.org/r/20210923171111.300673-6-andrealmeid@collabora=
.com
---
 kernel/futex/core.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index e70e81c..63cf0da 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -132,7 +132,7 @@
  *
  * Note that a new waiter is accounted for in (a) even when it is possible t=
hat
  * the wait call can return error, in which case we backtrack from it in (b).
- * Refer to the comment in queue_lock().
+ * Refer to the comment in futex_q_lock().
  *
  * Similarly, in order to account for waiters being requeued on another
  * address we always increment the waiters for the destination bucket before
@@ -2410,7 +2410,7 @@ out_unlock:
 }
=20
 /* The key must be already stored in q->key. */
-static inline struct futex_hash_bucket *queue_lock(struct futex_q *q)
+static inline struct futex_hash_bucket *futex_q_lock(struct futex_q *q)
 	__acquires(&hb->lock)
 {
 	struct futex_hash_bucket *hb;
@@ -2420,9 +2420,9 @@ static inline struct futex_hash_bucket *queue_lock(stru=
ct futex_q *q)
 	/*
 	 * Increment the counter before taking the lock so that
 	 * a potential waker won't miss a to-be-slept task that is
-	 * waiting for the spinlock. This is safe as all queue_lock()
+	 * waiting for the spinlock. This is safe as all futex_q_lock()
 	 * users end up calling futex_queue(). Similarly, for housekeeping,
-	 * decrement the counter at queue_unlock() when some error has
+	 * decrement the counter at futex_q_unlock() when some error has
 	 * occurred and we don't end up adding the task to the list.
 	 */
 	hb_waiters_inc(hb); /* implies smp_mb(); (A) */
@@ -2434,7 +2434,7 @@ static inline struct futex_hash_bucket *queue_lock(stru=
ct futex_q *q)
 }
=20
 static inline void
-queue_unlock(struct futex_hash_bucket *hb)
+futex_q_unlock(struct futex_hash_bucket *hb)
 	__releases(&hb->lock)
 {
 	spin_unlock(&hb->lock);
@@ -2870,12 +2870,12 @@ retry:
 		return ret;
=20
 retry_private:
-	*hb =3D queue_lock(q);
+	*hb =3D futex_q_lock(q);
=20
 	ret =3D get_futex_value_locked(&uval, uaddr);
=20
 	if (ret) {
-		queue_unlock(*hb);
+		futex_q_unlock(*hb);
=20
 		ret =3D get_user(uval, uaddr);
 		if (ret)
@@ -2888,7 +2888,7 @@ retry_private:
 	}
=20
 	if (uval !=3D val) {
-		queue_unlock(*hb);
+		futex_q_unlock(*hb);
 		ret =3D -EWOULDBLOCK;
 	}
=20
@@ -3006,7 +3006,7 @@ retry:
 		goto out;
=20
 retry_private:
-	hb =3D queue_lock(&q);
+	hb =3D futex_q_lock(&q);
=20
 	ret =3D futex_lock_pi_atomic(uaddr, hb, &q.key, &q.pi_state, current,
 				   &exiting, 0);
@@ -3030,7 +3030,7 @@ retry_private:
 			 *   exit to complete.
 			 * - EAGAIN: The user space value changed.
 			 */
-			queue_unlock(hb);
+			futex_q_unlock(hb);
 			/*
 			 * Handle the case where the owner is in the middle of
 			 * exiting. Wait for the exit to complete otherwise
@@ -3126,7 +3126,7 @@ no_block:
 	goto out;
=20
 out_unlock_put_key:
-	queue_unlock(hb);
+	futex_q_unlock(hb);
=20
 out:
 	if (to) {
@@ -3136,7 +3136,7 @@ out:
 	return ret !=3D -EINTR ? ret : -ERESTARTNOINTR;
=20
 uaddr_faulted:
-	queue_unlock(hb);
+	futex_q_unlock(hb);
=20
 	ret =3D fault_in_user_writeable(uaddr);
 	if (ret)
@@ -3421,7 +3421,7 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned i=
nt flags,
 	 * shared futexes. We need to compare the keys:
 	 */
 	if (match_futex(&q.key, &key2)) {
-		queue_unlock(hb);
+		futex_q_unlock(hb);
 		ret =3D -EINVAL;
 		goto out;
 	}
