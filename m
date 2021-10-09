Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944A14278CB
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244770AbhJIKJb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244678AbhJIKJS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56B9C061768;
        Sat,  9 Oct 2021 03:07:18 -0700 (PDT)
Date:   Sat, 09 Oct 2021 10:07:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774037;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aYgKOR4/+H87coxIDntpAjbVDfUaNHJHYyD1vYklbUs=;
        b=Waf526v/qG7hL1UkQoi6vLtSvXAe0nO2kIxTHp/dzFbpi26riP2JHeS0LOcQ77qm+j6o2F
        Xjdjvun1wv6x9hU4N2bzz0VWpnWMO61KUYciBLpNmc/FiUUxSasoc5dUb6chMYeOP9jdTM
        5Axnp7TWpcXhis1lfNw4/dDcUbAOmDPP8CVmLZ3FFzJaDZf0Hp4w7cXAm+drmjcFQeTcuF
        XNtdbRbM88TnuKJbfLHrAvw0E8OBOOEmpyRc85ZCa1fQhHgfmTAgXfxIIBl6mjdeCrFolp
        9EpaNut5kG+SZzylPsBgPSATMtGr1GXyWBNLhTS9PLEnGb6mNr2r1jRNiuX4ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774037;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aYgKOR4/+H87coxIDntpAjbVDfUaNHJHYyD1vYklbUs=;
        b=+4eHxmKBXm0QvFVycmAYly/Pf924VvhJIQtALzHgBMOvZoQMA6C5OCOBu0PUS712BJ6dax
        EfHUnxDAnybQsWCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Rename {,__}{,un}queue_me()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        andrealmeid@collabora.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923171111.300673-4-andrealmeid@collabora.com>
References: <20210923171111.300673-4-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <163377403644.25758.6861294518686818049.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     bce760d34bc2adcfd97e859a91407df51913f7b0
Gitweb:        https://git.kernel.org/tip/bce760d34bc2adcfd97e859a91407df5191=
3f7b0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 Sep 2021 14:10:52 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:08 +02:00

futex: Rename {,__}{,un}queue_me()

In order to prepare introducing these symbols into the global
namespace; rename them:

  s/\<\(__\)*\(un\)*queue_me/\1futex_\2queue/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Link: https://lore.kernel.org/r/20210923171111.300673-4-andrealmeid@collabora=
.com
---
 kernel/futex/core.c | 46 ++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 69d9892..91f94b4 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -190,7 +190,7 @@ struct futex_pi_state {
  * the second.
  *
  * PI futexes are typically woken before they are removed from the hash list=
 via
- * the rt_mutex code. See unqueue_me_pi().
+ * the rt_mutex code. See futex_unqueue_pi().
  */
 struct futex_q {
 	struct plist_node list;
@@ -260,7 +260,7 @@ enum {
 };
=20
 static const struct futex_q futex_q_init =3D {
-	/* list gets initialized in queue_me()*/
+	/* list gets initialized in futex_queue()*/
 	.key		=3D FUTEX_KEY_INIT,
 	.bitset		=3D FUTEX_BITSET_MATCH_ANY,
 	.requeue_state	=3D ATOMIC_INIT(Q_REQUEUE_PI_NONE),
@@ -1047,7 +1047,7 @@ static int attach_to_pi_state(u32 __user *uaddr, u32 uv=
al,
 	/*
 	 * We get here with hb->lock held, and having found a
 	 * futex_top_waiter(). This means that futex_lock_pi() of said futex_q
-	 * has dropped the hb->lock in between queue_me() and unqueue_me_pi(),
+	 * has dropped the hb->lock in between futex_queue() and futex_unqueue_pi(),
 	 * which in turn means that futex_lock_pi() still has a reference on
 	 * our pi_state.
 	 *
@@ -2421,7 +2421,7 @@ static inline struct futex_hash_bucket *queue_lock(stru=
ct futex_q *q)
 	 * Increment the counter before taking the lock so that
 	 * a potential waker won't miss a to-be-slept task that is
 	 * waiting for the spinlock. This is safe as all queue_lock()
-	 * users end up calling queue_me(). Similarly, for housekeeping,
+	 * users end up calling futex_queue(). Similarly, for housekeeping,
 	 * decrement the counter at queue_unlock() when some error has
 	 * occurred and we don't end up adding the task to the list.
 	 */
@@ -2441,7 +2441,7 @@ queue_unlock(struct futex_hash_bucket *hb)
 	hb_waiters_dec(hb);
 }
=20
-static inline void __queue_me(struct futex_q *q, struct futex_hash_bucket *h=
b)
+static inline void __futex_queue(struct futex_q *q, struct futex_hash_bucket=
 *hb)
 {
 	int prio;
=20
@@ -2461,36 +2461,36 @@ static inline void __queue_me(struct futex_q *q, stru=
ct futex_hash_bucket *hb)
 }
=20
 /**
- * queue_me() - Enqueue the futex_q on the futex_hash_bucket
+ * futex_queue() - Enqueue the futex_q on the futex_hash_bucket
  * @q:	The futex_q to enqueue
  * @hb:	The destination hash bucket
  *
  * The hb->lock must be held by the caller, and is released here. A call to
- * queue_me() is typically paired with exactly one call to unqueue_me().  The
- * exceptions involve the PI related operations, which may use unqueue_me_pi=
()
+ * futex_queue() is typically paired with exactly one call to futex_unqueue(=
).  The
+ * exceptions involve the PI related operations, which may use futex_unqueue=
_pi()
  * or nothing if the unqueue is done as part of the wake process and the unq=
ueue
  * state is implicit in the state of woken task (see futex_wait_requeue_pi()=
 for
  * an example).
  */
-static inline void queue_me(struct futex_q *q, struct futex_hash_bucket *hb)
+static inline void futex_queue(struct futex_q *q, struct futex_hash_bucket *=
hb)
 	__releases(&hb->lock)
 {
-	__queue_me(q, hb);
+	__futex_queue(q, hb);
 	spin_unlock(&hb->lock);
 }
=20
 /**
- * unqueue_me() - Remove the futex_q from its futex_hash_bucket
+ * futex_unqueue() - Remove the futex_q from its futex_hash_bucket
  * @q:	The futex_q to unqueue
  *
- * The q->lock_ptr must not be held by the caller. A call to unqueue_me() mu=
st
- * be paired with exactly one earlier call to queue_me().
+ * The q->lock_ptr must not be held by the caller. A call to futex_unqueue()=
 must
+ * be paired with exactly one earlier call to futex_queue().
  *
  * Return:
  *  - 1 - if the futex_q was still queued (and we removed unqueued it);
  *  - 0 - if the futex_q was already removed by the waking thread
  */
-static int unqueue_me(struct futex_q *q)
+static int futex_unqueue(struct futex_q *q)
 {
 	spinlock_t *lock_ptr;
 	int ret =3D 0;
@@ -2537,7 +2537,7 @@ retry:
  * PI futexes can not be requeued and must remove themselves from the
  * hash bucket. The hash bucket lock (i.e. lock_ptr) is held.
  */
-static void unqueue_me_pi(struct futex_q *q)
+static void futex_unqueue_pi(struct futex_q *q)
 {
 	__unqueue_futex(q);
=20
@@ -2787,7 +2787,7 @@ static int fixup_owner(u32 __user *uaddr, struct futex_=
q *q, int locked)
 }
=20
 /**
- * futex_wait_queue_me() - queue_me() and wait for wakeup, timeout, or signal
+ * futex_wait_queue_me() - futex_queue() and wait for wakeup, timeout, or si=
gnal
  * @hb:		the futex hash bucket, must be locked by the caller
  * @q:		the futex_q to queue up on
  * @timeout:	the prepared hrtimer_sleeper, or null for no timeout
@@ -2798,11 +2798,11 @@ static void futex_wait_queue_me(struct futex_hash_buc=
ket *hb, struct futex_q *q,
 	/*
 	 * The task state is guaranteed to be set before another task can
 	 * wake it. set_current_state() is implemented using smp_store_mb() and
-	 * queue_me() calls spin_unlock() upon completion, both serializing
+	 * futex_queue() calls spin_unlock() upon completion, both serializing
 	 * access to the hash list and forcing another memory barrier.
 	 */
 	set_current_state(TASK_INTERRUPTIBLE);
-	queue_me(q, hb);
+	futex_queue(q, hb);
=20
 	/* Arm the timer */
 	if (timeout)
@@ -2918,12 +2918,12 @@ retry:
 	if (ret)
 		goto out;
=20
-	/* queue_me and wait for wakeup, timeout, or a signal. */
+	/* futex_queue and wait for wakeup, timeout, or a signal. */
 	futex_wait_queue_me(hb, &q, to);
=20
 	/* If we were woken (and unqueued), we succeeded, whatever. */
 	ret =3D 0;
-	if (!unqueue_me(&q))
+	if (!futex_unqueue(&q))
 		goto out;
 	ret =3D -ETIMEDOUT;
 	if (to && !to->task)
@@ -3049,7 +3049,7 @@ retry_private:
 	/*
 	 * Only actually queue now that the atomic ops are done:
 	 */
-	__queue_me(&q, hb);
+	__futex_queue(&q, hb);
=20
 	if (trylock) {
 		ret =3D rt_mutex_futex_trylock(&q.pi_state->pi_mutex);
@@ -3121,7 +3121,7 @@ no_block:
 	if (res)
 		ret =3D (res < 0) ? res : 0;
=20
-	unqueue_me_pi(&q);
+	futex_unqueue_pi(&q);
 	spin_unlock(q.lock_ptr);
 	goto out;
=20
@@ -3479,7 +3479,7 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned i=
nt flags,
 		if (res)
 			ret =3D (res < 0) ? res : 0;
=20
-		unqueue_me_pi(&q);
+		futex_unqueue_pi(&q);
 		spin_unlock(q.lock_ptr);
=20
 		if (ret =3D=3D -EINTR) {
