Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA013B159F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jun 2021 10:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhFWIVa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 04:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhFWIV2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 04:21:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AF6C06175F;
        Wed, 23 Jun 2021 01:19:10 -0700 (PDT)
Date:   Wed, 23 Jun 2021 08:19:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624436347;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iBsX0g1O+8ntTsGmI1I48vpaIoUv+HgBH/I//rPwWFc=;
        b=iZtVQH6kauXBJQfIe2NMac6oEAezgzueLtakkzpxfq52L2ITUhCby4NzLqrW+yhhEmonBj
        91tOhkChNqqJ3tfvecrK4W4noNBl/J2CKJQC3BfEY3E1QucOxcoLXbhTYjnCsdgHS1nAU6
        HH2qv6QPDtqzrOm0AarWtr2l0xEqJGFdywoIZRXZ7/bKp0dm6lWqda/9iJAKxMNcnKKc5i
        O2vHSYqTrglZeBwciTArXmeyRe2f8lmJP0Fu1qT6On/jzMDwCjID7B/SABtSpvLzaxueHh
        8VT5SWZhCNMELYJybXaCp1ctpbuJpzfSL3KyZKR22doF9uhZC3P0i3Z8jNWsjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624436347;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iBsX0g1O+8ntTsGmI1I48vpaIoUv+HgBH/I//rPwWFc=;
        b=Lw6KfZ5vIbyeLRF3cwtHahkKpoRNzNuJ43FesL1oOfUnSdB7eYpWsvhuQgCSdRWj6036Ma
        Rz0C+62pWiSs12Ag==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Prepare futex_lock_pi() for runtime clock
 selection
Cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422194705.338657741@linutronix.de>
References: <20210422194705.338657741@linutronix.de>
MIME-Version: 1.0
Message-ID: <162443634714.395.9875787823678048976.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e112c41341c03d9224a9fc522bdb3539bc849b56
Gitweb:        https://git.kernel.org/tip/e112c41341c03d9224a9fc522bdb3539bc849b56
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 22 Apr 2021 21:44:22 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 22 Jun 2021 16:42:08 +02:00

futex: Prepare futex_lock_pi() for runtime clock selection

futex_lock_pi() is the only futex operation which cannot select the clock
for timeouts (CLOCK_MONOTONIC/CLOCK_REALTIME). That's inconsistent and
there is no particular reason why this cannot be supported.

This was overlooked when CLOCK_REALTIME_FLAG was introduced and
unfortunately not reported when the inconsistency was discovered in glibc.

Prepare the function and enforce the CLOCK_REALTIME_FLAG on FUTEX_LOCK_PI
so that a new FUTEX_LOCK_PI2 can implement it correctly.

Reported-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210422194705.338657741@linutronix.de
---
 kernel/futex.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 08008c2..f820439 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2783,7 +2783,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	if (refill_pi_state_cache())
 		return -ENOMEM;
 
-	to = futex_setup_timer(time, &timeout, FLAGS_CLOCKRT, 0);
+	to = futex_setup_timer(time, &timeout, flags, 0);
 
 retry:
 	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &q.key, FUTEX_WRITE);
@@ -3739,6 +3739,7 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	case FUTEX_WAKE_OP:
 		return futex_wake_op(uaddr, flags, uaddr2, val, val2, val3);
 	case FUTEX_LOCK_PI:
+		flags |= FLAGS_CLOCKRT;
 		return futex_lock_pi(uaddr, flags, timeout, 0);
 	case FUTEX_UNLOCK_PI:
 		return futex_unlock_pi(uaddr, flags);
