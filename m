Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D433FF4A9
	for <lists+linux-tip-commits@lfdr.de>; Thu,  2 Sep 2021 22:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240674AbhIBUPa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 2 Sep 2021 16:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbhIBUPa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 2 Sep 2021 16:15:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E5AC061757;
        Thu,  2 Sep 2021 13:14:31 -0700 (PDT)
Date:   Thu, 02 Sep 2021 20:14:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630613670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=clmeRy+WGNSmZIk4albb4elQ8vg9ijnCuNeYfqlr9rU=;
        b=OGobmbqmEh98QEc8DLjB8J5gddn1cuMoHPkMdrBdrTsL53b6fgV91/dhPSa/cMRLUD8hXc
        LH0UcSFXJl/U3VgzduwjnwdJ77Iob6shR9x+YGxEfaFJqWSrPCiLeQ5IAzbvXzSv7lov5D
        sh8Pa/qLFNcxlj2MB087y8ar2tUrn9HoMjrF6I5lCQOUe5DUm/Gjf6iRGPbnWbJG3mljCb
        ylmauA47Jnw4B5L0dLB2j0YYghyRfdzGaHpX0voGs04QWp4+Tr8FaBvsjpoe8e9FwU4hX3
        tK/GzIwFapz8YWLMwaP8Z3kVa3OKM2yakZMBmyf6FYj7yaqYiNIxVz0jtWOQeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630613670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=clmeRy+WGNSmZIk4albb4elQ8vg9ijnCuNeYfqlr9rU=;
        b=JOKGlapN92Gz7e9qYVoaNykgYu187Q6MMgQrdKFFBcQjWhco+w78qmjqV597bdCRGgB2iy
        YogxpQvIFUTZclBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Clarify comment for requeue_pi_wake_futex()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210902094414.618613025@linutronix.de>
References: <20210902094414.618613025@linutronix.de>
MIME-Version: 1.0
Message-ID: <163061366946.25758.6327425648371251767.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     249955e51c8136189b3c66f54e212981a1350a0f
Gitweb:        https://git.kernel.org/tip/249955e51c8136189b3c66f54e212981a1350a0f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 02 Sep 2021 11:48:50 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 02 Sep 2021 22:07:18 +02:00

futex: Clarify comment for requeue_pi_wake_futex()

It's slightly confusing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210902094414.618613025@linutronix.de


---
 kernel/futex.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 04164d4..82cd270 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1954,12 +1954,26 @@ static inline int futex_requeue_pi_wakeup_sync(struct futex_q *q)
  * @hb:		the hash_bucket of the requeue target futex
  *
  * During futex_requeue, with requeue_pi=1, it is possible to acquire the
- * target futex if it is uncontended or via a lock steal.  Set the futex_q key
- * to the requeue target futex so the waiter can detect the wakeup on the right
- * futex, but remove it from the hb and NULL the rt_waiter so it can detect
- * atomic lock acquisition.  Set the q->lock_ptr to the requeue target hb->lock
- * to protect access to the pi_state to fixup the owner later.  Must be called
- * with both q->lock_ptr and hb->lock held.
+ * target futex if it is uncontended or via a lock steal.
+ *
+ * 1) Set @q::key to the requeue target futex key so the waiter can detect
+ *    the wakeup on the right futex.
+ *
+ * 2) Dequeue @q from the hash bucket.
+ *
+ * 3) Set @q::rt_waiter to NULL so the woken up task can detect atomic lock
+ *    acquisition.
+ *
+ * 4) Set the q->lock_ptr to the requeue target hb->lock for the case that
+ *    the waiter has to fixup the pi state.
+ *
+ * 5) Complete the requeue state so the waiter can make progress. After
+ *    this point the waiter task can return from the syscall immediately in
+ *    case that the pi state does not have to be fixed up.
+ *
+ * 6) Wake the waiter task.
+ *
+ * Must be called with both q->lock_ptr and hb->lock held.
  */
 static inline
 void requeue_pi_wake_futex(struct futex_q *q, union futex_key *key,
