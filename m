Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34339337C92
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Mar 2021 19:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhCKSZP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 11 Mar 2021 13:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhCKSY6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 11 Mar 2021 13:24:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3B0C061574;
        Thu, 11 Mar 2021 10:24:58 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:24:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615487095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ABChRW+x/yhcywuUx55ch6m26BcYyvgzNzeymI/EGr0=;
        b=xgVvyE2SFHuJKQYWj5C3t8HI5a7LjKMPnj9egu/AajNE7UjxehG4ubiw59qJXhEkwL1/gU
        tmH2lx4lhD4LyYGyo6cpuBBM6RNwk2yOs+z5wuPKuuKpFqhK1uxVJGOOSlSg3P2S0r4RB3
        mGwZ0oKQ2HZQPpJuflDJxVaNi1hBc+6LavdlQQzgsQtCsQbwRAAe1IkCmV+ZJRdj783mQC
        w5DR3rqRnxB1gVyVtQp8F23S9UeQ/hhS32SeKZqk7Q+joUDT7jTjPeTxxtk210HuzhkGev
        7u5QrMrR5uC6dSZyWgYCMosxEXiVFkfeTX3MOTxC6cB0XNypLuU1Zq+rNXB6IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615487095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ABChRW+x/yhcywuUx55ch6m26BcYyvgzNzeymI/EGr0=;
        b=742mh8KR9Re1VK3jIpViWTrMtQYi2QlMqQSubO6AserSnj575LMOwtvgxAWPPuQbUm/HHG
        dniPVfPQIcT/BmDA==
From:   "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kernel/futex: Move hb unlock out of unqueue_me_pi()
Cc:     Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210226175029.50335-3-dave@stgolabs.net>
References: <20210226175029.50335-3-dave@stgolabs.net>
MIME-Version: 1.0
Message-ID: <161548709481.398.710134685663375184.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a3f2428d2b9c9ca70f52818774a2f6e0e30a0f0b
Gitweb:        https://git.kernel.org/tip/a3f2428d2b9c9ca70f52818774a2f6e0e30a0f0b
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Fri, 26 Feb 2021 09:50:28 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 11 Mar 2021 19:19:17 +01:00

kernel/futex: Move hb unlock out of unqueue_me_pi()

This improves the code readability, and the locking more obvious
as it becomes symmetric for the caller.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210226175029.50335-3-dave@stgolabs.net

---
 kernel/futex.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index ee09995..dcd6132 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2318,19 +2318,15 @@ retry:
 
 /*
  * PI futexes can not be requeued and must remove themself from the
- * hash bucket. The hash bucket lock (i.e. lock_ptr) is held on entry
- * and dropped here.
+ * hash bucket. The hash bucket lock (i.e. lock_ptr) is held.
  */
 static void unqueue_me_pi(struct futex_q *q)
-	__releases(q->lock_ptr)
 {
 	__unqueue_futex(q);
 
 	BUG_ON(!q->pi_state);
 	put_pi_state(q->pi_state);
 	q->pi_state = NULL;
-
-	spin_unlock(q->lock_ptr);
 }
 
 static int __fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
@@ -2913,8 +2909,8 @@ no_block:
 	if (res)
 		ret = (res < 0) ? res : 0;
 
-	/* Unqueue and drop the lock */
 	unqueue_me_pi(&q);
+	spin_unlock(q.lock_ptr);
 	goto out;
 
 out_unlock_put_key:
@@ -3290,8 +3286,8 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		if (res)
 			ret = (res < 0) ? res : 0;
 
-		/* Unqueue and drop the lock. */
 		unqueue_me_pi(&q);
+		spin_unlock(q.lock_ptr);
 	}
 
 	if (ret == -EINTR) {
