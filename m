Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3934278BC
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244620AbhJIKJN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:09:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49368 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244545AbhJIKJI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:08 -0400
Date:   Sat, 09 Oct 2021 10:07:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774031;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=osy18yqCLWOmKWiKks6dQ/O1Tj+IDx0OaYcVaNEo5Sk=;
        b=jw6P+3bYbMsKYwWVYj6QEWqt+iMnGX/gfl6QLea7qYvZSogrhUsYtYTcQnQc1dvMDu3MVB
        M9JIQXQ01QBzie1+0h1xnFd5GzQQ+mp4Qk1Z+F7al1+1HGg9Mf1MDbSfwyLSrdgAvYsNZO
        mQxLnxxg7EhD4sXrl4D84pMVfV87OENcuM67zuFmG4pnS/Jm7owTp8AHpj34vb0WkAiIF3
        hO47hl4+Ri/+uXUNnctBGimYVLG9e7yr/Ao5/6dcJ33v0XQaa90Za9O+HXMHNF/0/J42fC
        iiufrQPAYAui+V9XwxURiNcqr1zDWikI3Tq4xsEu+kAXmNwrqO1YsAXIwCjl8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774031;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=osy18yqCLWOmKWiKks6dQ/O1Tj+IDx0OaYcVaNEo5Sk=;
        b=MJ/JVl5Pzw9fJxKGfldJUMzW+SoNtEVRSeYXNwWDEewC3UZTX7GYXHYBMkDQl6nSIs/DFU
        +Wbg53Na0so9JMCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Rename: hb_waiter_{inc,dec,pending}()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        andrealmeid@collabora.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923171111.300673-11-andrealmeid@collabora.com>
References: <20210923171111.300673-11-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <163377403019.25758.11473171142618165722.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     832c0542c0f71f7d2ba10e987a1ab520813e6bd7
Gitweb:        https://git.kernel.org/tip/832c0542c0f71f7d2ba10e987a1ab520813=
e6bd7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 Sep 2021 14:10:59 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:09 +02:00

futex: Rename: hb_waiter_{inc,dec,pending}()

In order to prepare introducing these symbols into the global
namespace; rename them:

  s/hb_waiters_/futex_&/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Link: https://lore.kernel.org/r/20210923171111.300673-11-andrealmeid@collabor=
a.com
---
 kernel/futex/core.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index a8ca5b5..a26045e 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -115,8 +115,8 @@
  *     waiters--; (b)                        unlock(hash_bucket(futex));
  *
  * Where (A) orders the waiters increment and the futex value read through
- * atomic operations (see hb_waiters_inc) and where (B) orders the write
- * to futex and the waiters read (see hb_waiters_pending()).
+ * atomic operations (see futex_hb_waiters_inc) and where (B) orders the wri=
te
+ * to futex and the waiters read (see futex_hb_waiters_pending()).
  *
  * This yields the following case (where X:=3Dwaiters, Y:=3Dfutex):
  *
@@ -272,7 +272,7 @@ late_initcall(fail_futex_debugfs);
 /*
  * Reflects a new waiter being added to the waitqueue.
  */
-static inline void hb_waiters_inc(struct futex_hash_bucket *hb)
+static inline void futex_hb_waiters_inc(struct futex_hash_bucket *hb)
 {
 #ifdef CONFIG_SMP
 	atomic_inc(&hb->waiters);
@@ -287,14 +287,14 @@ static inline void hb_waiters_inc(struct futex_hash_buc=
ket *hb)
  * Reflects a waiter being removed from the waitqueue by wakeup
  * paths.
  */
-static inline void hb_waiters_dec(struct futex_hash_bucket *hb)
+static inline void futex_hb_waiters_dec(struct futex_hash_bucket *hb)
 {
 #ifdef CONFIG_SMP
 	atomic_dec(&hb->waiters);
 #endif
 }
=20
-static inline int hb_waiters_pending(struct futex_hash_bucket *hb)
+static inline int futex_hb_waiters_pending(struct futex_hash_bucket *hb)
 {
 #ifdef CONFIG_SMP
 	/*
@@ -723,7 +723,7 @@ static void __futex_unqueue(struct futex_q *q)
=20
 	hb =3D container_of(q->lock_ptr, struct futex_hash_bucket, lock);
 	plist_del(&q->list, &hb->chain);
-	hb_waiters_dec(hb);
+	futex_hb_waiters_dec(hb);
 }
=20
 /*
@@ -802,7 +802,7 @@ int futex_wake(u32 __user *uaddr, unsigned int flags, int=
 nr_wake, u32 bitset)
 	hb =3D futex_hash(&key);
=20
 	/* Make sure we really have tasks to wakeup */
-	if (!hb_waiters_pending(hb))
+	if (!futex_hb_waiters_pending(hb))
 		return ret;
=20
 	spin_lock(&hb->lock);
@@ -979,8 +979,8 @@ void requeue_futex(struct futex_q *q, struct futex_hash_b=
ucket *hb1,
 	 */
 	if (likely(&hb1->chain !=3D &hb2->chain)) {
 		plist_del(&q->list, &hb1->chain);
-		hb_waiters_dec(hb1);
-		hb_waiters_inc(hb2);
+		futex_hb_waiters_dec(hb1);
+		futex_hb_waiters_inc(hb2);
 		plist_add(&q->list, &hb2->chain);
 		q->lock_ptr =3D &hb2->lock;
 	}
@@ -1341,7 +1341,7 @@ retry:
 	hb2 =3D futex_hash(&key2);
=20
 retry_private:
-	hb_waiters_inc(hb2);
+	futex_hb_waiters_inc(hb2);
 	double_lock_hb(hb1, hb2);
=20
 	if (likely(cmpval !=3D NULL)) {
@@ -1351,7 +1351,7 @@ retry_private:
=20
 		if (unlikely(ret)) {
 			double_unlock_hb(hb1, hb2);
-			hb_waiters_dec(hb2);
+			futex_hb_waiters_dec(hb2);
=20
 			ret =3D get_user(curval, uaddr1);
 			if (ret)
@@ -1437,7 +1437,7 @@ retry_private:
 		 */
 		case -EFAULT:
 			double_unlock_hb(hb1, hb2);
-			hb_waiters_dec(hb2);
+			futex_hb_waiters_dec(hb2);
 			ret =3D fault_in_user_writeable(uaddr2);
 			if (!ret)
 				goto retry;
@@ -1451,7 +1451,7 @@ retry_private:
 			 * - EAGAIN: The user space value changed.
 			 */
 			double_unlock_hb(hb1, hb2);
-			hb_waiters_dec(hb2);
+			futex_hb_waiters_dec(hb2);
 			/*
 			 * Handle the case where the owner is in the middle of
 			 * exiting. Wait for the exit to complete otherwise
@@ -1570,7 +1570,7 @@ retry_private:
 out_unlock:
 	double_unlock_hb(hb1, hb2);
 	wake_up_q(&wake_q);
-	hb_waiters_dec(hb2);
+	futex_hb_waiters_dec(hb2);
 	return ret ? ret : task_count;
 }
=20
@@ -1590,7 +1590,7 @@ struct futex_hash_bucket *futex_q_lock(struct futex_q *=
q)
 	 * decrement the counter at futex_q_unlock() when some error has
 	 * occurred and we don't end up adding the task to the list.
 	 */
-	hb_waiters_inc(hb); /* implies smp_mb(); (A) */
+	futex_hb_waiters_inc(hb); /* implies smp_mb(); (A) */
=20
 	q->lock_ptr =3D &hb->lock;
=20
@@ -1602,7 +1602,7 @@ void futex_q_unlock(struct futex_hash_bucket *hb)
 	__releases(&hb->lock)
 {
 	spin_unlock(&hb->lock);
-	hb_waiters_dec(hb);
+	futex_hb_waiters_dec(hb);
 }
=20
 void __futex_queue(struct futex_q *q, struct futex_hash_bucket *hb)
@@ -1932,7 +1932,7 @@ int handle_early_requeue_pi_wakeup(struct futex_hash_bu=
cket *hb,
 	 * Unqueue the futex_q and determine which it was.
 	 */
 	plist_del(&q->list, &hb->chain);
-	hb_waiters_dec(hb);
+	futex_hb_waiters_dec(hb);
=20
 	/* Handle spurious wakeups gracefully */
 	ret =3D -EWOULDBLOCK;
