Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860B74278BB
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244614AbhJIKJM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:09:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49368 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244599AbhJIKJL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:11 -0400
Date:   Sat, 09 Oct 2021 10:07:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774033;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a3KOA5bYm7mB3mAcz23zObPFJtQLrQkP0R9pXeSeEu0=;
        b=aPeq6Fk2KbZ2qR9aJX2htVMnun3g2wuX7bHO1CoRw41K4s2i4tg0flA8WjOzTbNjXZpxK+
        +81ol1Si23NPiwxRERT+2Vx3MUtklSTXf3G7pR3QQ+NzVFvEoHbuSRf1ccMmwGK/lsZC9K
        TlizJscWWApSxQLSw26/qK+9Ww1pqcVNoxDIhmCxEBtQzadfba0KxwPWVNzKpcBmgqMD89
        W87uLnn4VP6XYibUzMsE4eqlTnyenzlKmdyoJxsJtb+FhQqK+DvkeoxgD8Rxz1N4z9oQbO
        P9DtbIs7kYtX2pvF+zaUTGBrFoqzEnkl6YRfoc7uYuFOaV3sLujQDXDRarlWgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774033;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a3KOA5bYm7mB3mAcz23zObPFJtQLrQkP0R9pXeSeEu0=;
        b=Dk7Bmf0sueRXkz8OsNR6qki+Nm2d0xlvHAaymoFfOI6Hu3xdDpkUAVJ//4+qlmg0cUknZ7
        rr5FohUrIG1v3dBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Rename hash_futex()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        andrealmeid@collabora.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923171111.300673-8-andrealmeid@collabora.com>
References: <20210923171111.300673-8-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <163377403294.25758.5913482114868148751.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     eee5a7bc96becd7cdb8e4fabd327ca5e49136704
Gitweb:        https://git.kernel.org/tip/eee5a7bc96becd7cdb8e4fabd327ca5e491=
36704
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 Sep 2021 14:10:56 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:09 +02:00

futex: Rename hash_futex()

In order to prepare introducing these symbols into the global
namespace; rename:

  s/hash_futex/futex_hash/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Link: https://lore.kernel.org/r/20210923171111.300673-8-andrealmeid@collabora=
.com
---
 kernel/futex/core.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 88541fb..032189f 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -279,7 +279,7 @@ struct futex_hash_bucket {
=20
 /*
  * The base of the bucket array and its size are always used together
- * (after initialization only in hash_futex()), so ensure that they
+ * (after initialization only in futex_hash()), so ensure that they
  * reside in the same cacheline.
  */
 static struct {
@@ -380,13 +380,13 @@ static inline int hb_waiters_pending(struct futex_hash_=
bucket *hb)
 }
=20
 /**
- * hash_futex - Return the hash bucket in the global hash
+ * futex_hash - Return the hash bucket in the global hash
  * @key:	Pointer to the futex key for which the hash is calculated
  *
  * We hash on the keys returned from get_futex_key (see below) and return the
  * corresponding hash bucket in the global hash.
  */
-static struct futex_hash_bucket *hash_futex(union futex_key *key)
+static struct futex_hash_bucket *futex_hash(union futex_key *key)
 {
 	u32 hash =3D jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
 			  key->both.offset);
@@ -885,7 +885,7 @@ static void exit_pi_state_list(struct task_struct *curr)
 		next =3D head->next;
 		pi_state =3D list_entry(next, struct futex_pi_state, list);
 		key =3D pi_state->key;
-		hb =3D hash_futex(&key);
+		hb =3D futex_hash(&key);
=20
 		/*
 		 * We can race against put_pi_state() removing itself from the
@@ -1634,7 +1634,7 @@ int futex_wake(u32 __user *uaddr, unsigned int flags, i=
nt nr_wake, u32 bitset)
 	if (unlikely(ret !=3D 0))
 		return ret;
=20
-	hb =3D hash_futex(&key);
+	hb =3D futex_hash(&key);
=20
 	/* Make sure we really have tasks to wakeup */
 	if (!hb_waiters_pending(hb))
@@ -1731,8 +1731,8 @@ retry:
 	if (unlikely(ret !=3D 0))
 		return ret;
=20
-	hb1 =3D hash_futex(&key1);
-	hb2 =3D hash_futex(&key2);
+	hb1 =3D futex_hash(&key1);
+	hb2 =3D futex_hash(&key2);
=20
 retry_private:
 	double_lock_hb(hb1, hb2);
@@ -2172,8 +2172,8 @@ retry:
 	if (requeue_pi && match_futex(&key1, &key2))
 		return -EINVAL;
=20
-	hb1 =3D hash_futex(&key1);
-	hb2 =3D hash_futex(&key2);
+	hb1 =3D futex_hash(&key1);
+	hb2 =3D futex_hash(&key2);
=20
 retry_private:
 	hb_waiters_inc(hb2);
@@ -2415,7 +2415,7 @@ static inline struct futex_hash_bucket *futex_q_lock(st=
ruct futex_q *q)
 {
 	struct futex_hash_bucket *hb;
=20
-	hb =3D hash_futex(&q->key);
+	hb =3D futex_hash(&q->key);
=20
 	/*
 	 * Increment the counter before taking the lock so that
@@ -3177,7 +3177,7 @@ retry:
 	if (ret)
 		return ret;
=20
-	hb =3D hash_futex(&key);
+	hb =3D futex_hash(&key);
 	spin_lock(&hb->lock);
=20
 	/*
