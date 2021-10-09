Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011B74278C9
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244765AbhJIKJb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244668AbhJIKJS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:09:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5576C061767;
        Sat,  9 Oct 2021 03:07:17 -0700 (PDT)
Date:   Sat, 09 Oct 2021 10:07:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774036;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vfhARHvj8cZDyFhit9wfona02BaEzInx4n5eutCUhyw=;
        b=SHyvzqBzAaY9Dq5XmzkkQZqEieGdBzWAogqhwsCq+NbJo1G85x++zlX7nVjggt4ZZc5N5m
        KVQGNakDco40uH1h0qE+RQ8pUrikB8iJMeNv6jBJdj8Vl/WZ++Hffy6OYazM/q8AbasKuT
        bYFZCbmN/7XhLrp8VwxdKtmzGwgMAI9PZWDMTC3KylEjbVF7yzSMgeAstfEv4Ulaq2yvPd
        b0Ps3Prj5XajcyPt9+Y2M/E1K7rFdKcKzwbHdU5bMlCxB8LFA6GjsYg0tYcfHNG96hPsSC
        DFHJU9Xt3SoF61gWYSF34XpAJZb5rwSvMDopRH0TGgZIp0ii9PAquWgEUQ5O8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774036;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vfhARHvj8cZDyFhit9wfona02BaEzInx4n5eutCUhyw=;
        b=jrnLATfcVbqWo0v585c9S9MBlJNB/3oQNO8+JgOv9au2Qx3UE2/Z9CgpxVGX8gid04uprI
        cpv3oxxVH4x4CFDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Rename futex_wait_queue_me()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        andrealmeid@collabora.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923171111.300673-5-andrealmeid@collabora.com>
References: <20210923171111.300673-5-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <163377403557.25758.2318226085244102144.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5622eb20520d284a52668e9f911a7f37e7b3f12c
Gitweb:        https://git.kernel.org/tip/5622eb20520d284a52668e9f911a7f37e7b=
3f12c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 Sep 2021 14:10:53 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:08 +02:00

futex: Rename futex_wait_queue_me()

In order to prepare introducing these symbols into the global
namespace; rename them:

  s/futex_wait_queue_me/futex_wait_queue/g

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Link: https://lore.kernel.org/r/20210923171111.300673-5-andrealmeid@collabora=
.com
---
 kernel/futex/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 91f94b4..e70e81c 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -2787,12 +2787,12 @@ static int fixup_owner(u32 __user *uaddr, struct fute=
x_q *q, int locked)
 }
=20
 /**
- * futex_wait_queue_me() - futex_queue() and wait for wakeup, timeout, or si=
gnal
+ * futex_wait_queue() - futex_queue() and wait for wakeup, timeout, or signal
  * @hb:		the futex hash bucket, must be locked by the caller
  * @q:		the futex_q to queue up on
  * @timeout:	the prepared hrtimer_sleeper, or null for no timeout
  */
-static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q=
 *q,
+static void futex_wait_queue(struct futex_hash_bucket *hb, struct futex_q *q,
 				struct hrtimer_sleeper *timeout)
 {
 	/*
@@ -2919,7 +2919,7 @@ retry:
 		goto out;
=20
 	/* futex_queue and wait for wakeup, timeout, or a signal. */
-	futex_wait_queue_me(hb, &q, to);
+	futex_wait_queue(hb, &q, to);
=20
 	/* If we were woken (and unqueued), we succeeded, whatever. */
 	ret =3D 0;
@@ -3347,7 +3347,7 @@ int handle_early_requeue_pi_wakeup(struct futex_hash_bu=
cket *hb,
  * without one, the pi logic would not know which task to boost/deboost, if
  * there was a need to.
  *
- * We call schedule in futex_wait_queue_me() when we enqueue and return there
+ * We call schedule in futex_wait_queue() when we enqueue and return there
  * via the following--
  * 1) wakeup on uaddr2 after an atomic lock acquisition by futex_requeue()
  * 2) wakeup on uaddr2 after a requeue
@@ -3427,7 +3427,7 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned i=
nt flags,
 	}
=20
 	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
-	futex_wait_queue_me(hb, &q, to);
+	futex_wait_queue(hb, &q, to);
=20
 	switch (futex_requeue_pi_wakeup_sync(&q)) {
 	case Q_REQUEUE_PI_IGNORE:
