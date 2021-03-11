Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A0A337C90
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Mar 2021 19:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhCKSZR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 11 Mar 2021 13:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbhCKSY6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 11 Mar 2021 13:24:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B960C061760;
        Thu, 11 Mar 2021 10:24:58 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:24:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615487095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MFFI5niyZ0UdsuRODCyNQNgbt1OUAgQ5UrgUr6IKoTQ=;
        b=m9WeIucQ0fRHWr53i8u+o6PNwisxBCmL4oA+WledZ0opqqlnMB1u1Oa1sLfJdrELct05ku
        jPtstZhFB1Uj8Pd83zBbIw9tj4h6WtLB43VNe0Xxe2Y6ebyFWn9DG2krwy8pPt6AmCpXnL
        hASj5RtehhH7VAZDRVdHbJLuO8EgFH/zU9rp1rgyJ5RyqaHoo+CWR8DNX3fbOBnazhD+lG
        RDCymjJJdQn9Sv/6GlcNtrG967AUZntwhEgxm3NJzCxlrkN50u+gHn6+V68oyCcdjkMMlt
        vnKzkd3g1kHu8UddZbIY4mnoCCQlhngQx62jLvUFL5A0Kb+QMVKyl0ZNFwEKng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615487095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MFFI5niyZ0UdsuRODCyNQNgbt1OUAgQ5UrgUr6IKoTQ=;
        b=yXoYqiYIqNeN0+MCHMH5mlywvzw3YiCP9X92BIPe0LfUdJxvc8M3PXbAMF4mYYbKLpPGpd
        /6bzOG+PE33zROAw==
From:   "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kernel/futex: Make futex_wait_requeue_pi() only
 call fixup_owner()
Cc:     Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210226175029.50335-2-dave@stgolabs.net>
References: <20210226175029.50335-2-dave@stgolabs.net>
MIME-Version: 1.0
Message-ID: <161548709514.398.3019777443206037709.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a1565aa4699847febfdfd6af3bf06ca17a9e16af
Gitweb:        https://git.kernel.org/tip/a1565aa4699847febfdfd6af3bf06ca17a9e16af
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Fri, 26 Feb 2021 09:50:27 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 11 Mar 2021 19:19:17 +01:00

kernel/futex: Make futex_wait_requeue_pi() only call fixup_owner()

A small cleanup that allows for fixup_pi_state_owner() only to be called
from fixup_owner(), and make requeue_pi uniformly call fixup_owner()
regardless of the state in which the fixup is actually needed. Of course
this makes the caller's first pi_state->owner != current check redundant,
but that should't really matter.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210226175029.50335-2-dave@stgolabs.net

---
 kernel/futex.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index db8002d..ee09995 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3241,15 +3241,14 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	 * reference count.
 	 */
 
-	/* Check if the requeue code acquired the second futex for us. */
+	/*
+	 * Check if the requeue code acquired the second futex for us and do
+	 * any pertinent fixup.
+	 */
 	if (!q.rt_waiter) {
-		/*
-		 * Got the lock. We might not be the anticipated owner if we
-		 * did a lock-steal - fix up the PI-state in that case.
-		 */
 		if (q.pi_state && (q.pi_state->owner != current)) {
 			spin_lock(q.lock_ptr);
-			ret = fixup_pi_state_owner(uaddr2, &q, current);
+			ret = fixup_owner(uaddr2, &q, true);
 			/*
 			 * Drop the reference to the pi state which
 			 * the requeue_pi() code acquired for us.
