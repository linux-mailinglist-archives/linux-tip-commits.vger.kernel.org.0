Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10464278BE
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244477AbhJIKJS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:09:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49360 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244612AbhJIKJL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:11 -0400
Date:   Sat, 09 Oct 2021 10:07:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774034;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qmJzqleer6PfgMWuGJUKMyt5bM4ktw50Bjl14lCMhX4=;
        b=npVZjeffyjJqHCYVqWWO91i1rrdfjV2FqqZEU2UTjAiL3kkHEAYjWWjFKuCyriX1wTxslM
        Pe/JaCt9ez3rjSdAcdIQFaag8hvot2/+RVAlSjsuuzqHa6aowcWfpHJfH5MPKmTPTNLsqu
        LwmSMoCWFEd+JAk4jV/IseB4Ptkvzmjm6cZX95JXNFspayCrPwRpjX9b8ijSQW2BYtqD5b
        j/NRRqVM3ohxaQm4PR5MkMeQ4HxWkKqnVg8Fl/zfU5e23MIddgZftiBNO3jhHjnO8se3iA
        vMvSqVwJ2QElSx4IVA9A0rxsM8FRSfvoPBprvxhLvFDe4bVN8XPGJU3uzs3bJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774034;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qmJzqleer6PfgMWuGJUKMyt5bM4ktw50Bjl14lCMhX4=;
        b=2eIer+3VBM5bTbCb3uq//1wn5QoKHIKl01NdlScPTNjjjsXxuLPwI9JC8UJubXAme09evH
        Lvx2kBwTXZ9iwkBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Rename __unqueue_futex()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        andrealmeid@collabora.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923171111.300673-7-andrealmeid@collabora.com>
References: <20210923171111.300673-7-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <163377403382.25758.2947549578305009632.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     af92dcea186ed7bcd5cc013163ec47a8a135ee97
Gitweb:        https://git.kernel.org/tip/af92dcea186ed7bcd5cc013163ec47a8a13=
5ee97
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 Sep 2021 14:10:55 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:08 +02:00

futex: Rename __unqueue_futex()

In order to prepare introducing these symbols into the global
namespace; rename:

  s/__unqueue_futex/__futex_unqueue/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Link: https://lore.kernel.org/r/20210923171111.300673-7-andrealmeid@collabora=
.com
---
 kernel/futex/core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 63cf0da..88541fb 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1470,12 +1470,12 @@ static int futex_lock_pi_atomic(u32 __user *uaddr, st=
ruct futex_hash_bucket *hb,
 }
=20
 /**
- * __unqueue_futex() - Remove the futex_q from its futex_hash_bucket
+ * __futex_unqueue() - Remove the futex_q from its futex_hash_bucket
  * @q:	The futex_q to unqueue
  *
  * The q->lock_ptr must not be NULL and must be held by the caller.
  */
-static void __unqueue_futex(struct futex_q *q)
+static void __futex_unqueue(struct futex_q *q)
 {
 	struct futex_hash_bucket *hb;
=20
@@ -1502,13 +1502,13 @@ static void mark_wake_futex(struct wake_q_head *wake_=
q, struct futex_q *q)
 		return;
=20
 	get_task_struct(p);
-	__unqueue_futex(q);
+	__futex_unqueue(q);
 	/*
 	 * The waiting task can free the futex_q as soon as q->lock_ptr =3D NULL
 	 * is written, without taking any locks. This is possible in the event
 	 * of a spurious wakeup, for example. A memory barrier is required here
 	 * to prevent the following store to lock_ptr from getting ahead of the
-	 * plist_del in __unqueue_futex().
+	 * plist_del in __futex_unqueue().
 	 */
 	smp_store_release(&q->lock_ptr, NULL);
=20
@@ -1958,7 +1958,7 @@ void requeue_pi_wake_futex(struct futex_q *q, union fut=
ex_key *key,
 {
 	q->key =3D *key;
=20
-	__unqueue_futex(q);
+	__futex_unqueue(q);
=20
 	WARN_ON(!q->rt_waiter);
 	q->rt_waiter =3D NULL;
@@ -2522,7 +2522,7 @@ retry:
 			spin_unlock(lock_ptr);
 			goto retry;
 		}
-		__unqueue_futex(q);
+		__futex_unqueue(q);
=20
 		BUG_ON(q->pi_state);
=20
@@ -2539,7 +2539,7 @@ retry:
  */
 static void futex_unqueue_pi(struct futex_q *q)
 {
-	__unqueue_futex(q);
+	__futex_unqueue(q);
=20
 	BUG_ON(!q->pi_state);
 	put_pi_state(q->pi_state);
