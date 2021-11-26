Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628BC45F5E4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 26 Nov 2021 21:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244087AbhKZU3Z (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 26 Nov 2021 15:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhKZU1Z (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 26 Nov 2021 15:27:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DD3C06175E;
        Fri, 26 Nov 2021 12:22:58 -0800 (PST)
Date:   Fri, 26 Nov 2021 20:22:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637958176;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4wLFOGKUG6ipKnW3SPtORvpluPHKCjS0/7nHQVYNS/0=;
        b=u1otSyCx1u8/p77mRlODHawZ9yPUoCEiztynGQkkRc8gcJNFpwzga/fZevlsAFrvv6qEH4
        jKiUCGdReQsErAjl6SBzVlhdUcytL6kc0UhPDHXIwmrSgzJnb4+xr3GUTQ35p8MQWijp2p
        yzsnLXzgpjVfCdxVArJ/9gNhAfdEABcwST1s5oVDOnWw0XKOW04EJnjtRVTOL/QPTlBi8H
        Hkkqlu4kpjy8s9z5GRwTQrqwqKg/Kl/bwx7Lbc+kWkZTpevgdE1AQaS+R3teSLt1pA4PLz
        AKE8UDnepFZL6kMVxjPrTZDHEbNlES+DVZqJDcTr5B9QLpdYyoNgsfxtN9WXtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637958176;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4wLFOGKUG6ipKnW3SPtORvpluPHKCjS0/7nHQVYNS/0=;
        b=xnzYZlR8DY98L5iyehnBDVLuzawCQZDvtO+5BXh13+kZwUWEXRrINJVUHfBvCrvlIW4QBR
        Rcyg66P3TGoJDkCg==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] microblaze: Snapshot thread flags
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Simek <michal.simek@xilinx.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211117163050.53986-8-mark.rutland@arm.com>
References: <20211117163050.53986-8-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <163795817599.11128.5350822384889066062.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     a9455e33ce5f0516046ca0da3aedd80f147ecb38
Gitweb:        https://git.kernel.org/tip/a9455e33ce5f0516046ca0da3aedd80f147ecb38
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 17 Nov 2021 16:30:45 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 26 Nov 2021 21:20:13 +01:00

microblaze: Snapshot thread flags

Some thread flags can be set remotely, and so even when IRQs are
disabled, the flags can change under our feet. Generally this is
unlikely to cause a problem in practice, but it is somewhat unsound, and
KCSAN will legitimately warn that there is a data race.

To avoid such issues, a snapshot of the flags has to be taken prior to
using them. Some places already use READ_ONCE() for that, others do not.

Convert them all to the new flag accessor helpers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/20211117163050.53986-8-mark.rutland@arm.com
---
 arch/microblaze/kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
index fc61eb0..23e8a93 100644
--- a/arch/microblaze/kernel/signal.c
+++ b/arch/microblaze/kernel/signal.c
@@ -283,7 +283,7 @@ static void do_signal(struct pt_regs *regs, int in_syscall)
 #ifdef DEBUG_SIG
 	pr_info("do signal: %p %d\n", regs, in_syscall);
 	pr_info("do signal2: %lx %lx %ld [%lx]\n", regs->pc, regs->r1,
-			regs->r12, current_thread_info()->flags);
+			regs->r12, read_thread_flags());
 #endif
 
 	if (get_signal(&ksig)) {
