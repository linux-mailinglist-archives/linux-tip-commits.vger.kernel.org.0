Return-Path: <linux-tip-commits+bounces-6686-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1060EB8CBDF
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 17:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD411B251B4
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 15:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC623223323;
	Sat, 20 Sep 2025 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G9DyUWlo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mNNFmMDK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F630179A3;
	Sat, 20 Sep 2025 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758383006; cv=none; b=A8WuKRMeBj9TY6duriiJ4dORk7PXj8KIv3SZv+/He3mcSGLNOtKQPF35iaPW7xqH5LGVgZy5Cm/ffbnr2zYTg9zCyZ+hIRAbZcMQfbGbJ1/QrRygktLEghdPTIhXz25Q+kEJmRGfyNl/9eCAt/shl4s+d5do+5YOGQsl8ODMUZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758383006; c=relaxed/simple;
	bh=0ITRtFycySrYfbRBh9/xsWD0si9WtkgxWMZly1D8Dcg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RAqoUwihyBqn16iYehXNmAtMfaArPY+MAeOJ6mbBw/mC4fij1ZDonOs/ISZxFqBI1ftK5+RG0Pxg12isEJkrie4yhTicL5rtMa/paJOt7ZSSkaFw3wB9U+YmsML0/vWh4TlojFzL1lc3L//srzSAix7DvBi8Ti/Dt+KOTD8U9g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G9DyUWlo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mNNFmMDK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 20 Sep 2025 15:43:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758383003;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTypYzAun1C7l0M0FZ5xVbNEB43yE3bn12oGAYCbkuU=;
	b=G9DyUWloUMLIaccQ6CwZxY+QXLXv34Go2XnfzmJUNB9uu8RLypqrj3AjkrgR18tNLIFtoC
	Dnr/ug0jnR29WxatHigPqOadEfVffayiIa6rHANMjXFajqzJoBvuDyG2p4w1HUMt8skf1G
	WyPk79d2+0QGIwkxvxYrECc8V2vXKSqf2gJ/fMKUN3wBeqo3AyWEFUROko/eWIppOvzqzG
	pFY94yidBMEBKsEKEjJGAF6wbRra7Ngasm6sVWS/GI9Dn5jTh22lREAUTL2TDp97fAOL6E
	f8PEdcIPezB0L5wmOcKUcsTZtBHXmeq5wIFDklpkX/bD12AENfMxAb+OTdWkrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758383003;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OTypYzAun1C7l0M0FZ5xVbNEB43yE3bn12oGAYCbkuU=;
	b=mNNFmMDK+xERR5xoyNP70t+yIWfgbbxtUnMIeq3pDWd5fca4hiPbTKuipnIQjTfNOoMp9o
	nYe14/K5Va0brjBQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Prevent use-after-free during requeue-PI
Cc: syzbot+034246a838a10d181e78@syzkaller.appspotmail.com,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250910104243.TUMt9HM0@linutronix.de>
References: <20250910104243.TUMt9HM0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175838300091.709179.9644244636542469203.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     b549113738e8c751b613118032a724b772aa83f2
Gitweb:        https://git.kernel.org/tip/b549113738e8c751b613118032a724b772a=
a83f2
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 10 Sep 2025 12:42:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 20 Sep 2025 17:40:42 +02:00

futex: Prevent use-after-free during requeue-PI

syzbot managed to trigger the following race:

   T1                               T2

 futex_wait_requeue_pi()
   futex_do_wait()
     schedule()
                               futex_requeue()
                                 futex_proxy_trylock_atomic()
                                   futex_requeue_pi_prepare()
                                   requeue_pi_wake_futex()
                                     futex_requeue_pi_complete()
                                      /* preempt */

         * timeout/ signal wakes T1 *

   futex_requeue_pi_wakeup_sync() // Q_REQUEUE_PI_LOCKED
   futex_hash_put()
  // back to userland, on stack futex_q is garbage

                                      /* back */
                                     wake_up_state(q->task, TASK_NORMAL);

In this scenario futex_wait_requeue_pi() is able to leave without using
futex_q::lock_ptr for synchronization.

This can be prevented by reading futex_q::task before updating the
futex_q::requeue_state. A reference on the task_struct is not needed
because requeue_pi_wake_futex() is invoked with a spinlock_t held which
implies a RCU read section.

Even if T1 terminates immediately after, the task_struct will remain valid
during T2's wake_up_state().  A READ_ONCE on futex_q::task before
futex_requeue_pi_complete() is enough because it ensures that the variable
is read before the state is updated.

Read futex_q::task before updating the requeue state, use it for the
following wakeup.

Fixes: 07d91ef510fb1 ("futex: Prevent requeue_pi() lock nesting issue on RT")
Reported-by: syzbot+034246a838a10d181e78@syzkaller.appspotmail.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Closes: https://lore.kernel.org/all/68b75989.050a0220.3db4df.01dd.GAE@google.=
com/
---
 kernel/futex/requeue.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index c716a66..d818b4d 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -230,8 +230,9 @@ static inline
 void requeue_pi_wake_futex(struct futex_q *q, union futex_key *key,
 			   struct futex_hash_bucket *hb)
 {
-	q->key =3D *key;
+	struct task_struct *task;
=20
+	q->key =3D *key;
 	__futex_unqueue(q);
=20
 	WARN_ON(!q->rt_waiter);
@@ -243,10 +244,11 @@ void requeue_pi_wake_futex(struct futex_q *q, union fut=
ex_key *key,
 	futex_hash_get(hb);
 	q->drop_hb_ref =3D true;
 	q->lock_ptr =3D &hb->lock;
+	task =3D READ_ONCE(q->task);
=20
 	/* Signal locked state to the waiter */
 	futex_requeue_pi_complete(q, 1);
-	wake_up_state(q->task, TASK_NORMAL);
+	wake_up_state(task, TASK_NORMAL);
 }
=20
 /**

