Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9985E29CBE3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Oct 2020 23:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832260AbgJ0WTN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 27 Oct 2020 18:19:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49630 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1832242AbgJ0WTN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 27 Oct 2020 18:19:13 -0400
Date:   Tue, 27 Oct 2020 22:19:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603837150;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QV72nsyiNi0RQVNKjT187iZMxP5cFj3WeywmE2OqgAs=;
        b=LkeuqJm0KrpyhCTIs3DuzSlcbUeCz61xMSXC5YWifcl3dF+hT1INq6jEieljEIDqtAchBw
        kmU3ebKpfgqW1azcLsW+uOsowRcWmVQC9iYI8+4AY2snHKhqt6uGeCCmV+7L1VRTwvxIL1
        gDtmK23wYLhsSTL3csD4tdQ/9VTyTQx+Lm/3eTIiZN8mNieKjA9/4P/Gfwz5MNiOGwpK48
        K6AGf//QfNiwHPqMpAUXQN4y08DiVEHC/bX4kQ0Fe0rn3bhMQiLjz0H4p4TVwru9VKyHpJ
        D1uIlGjhNzXPeFLpcyQSZQM12Pz7/U/ONBCRECvJzDSJc2XVMv/JdEtnjebX8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603837150;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QV72nsyiNi0RQVNKjT187iZMxP5cFj3WeywmE2OqgAs=;
        b=bTWhHCUov9+Rf4iVXuCmoeCDpJWvYs/gCNYJwOX6Dwk1gnxWhKJYFnXUVDgtD3KGw4YcyM
        aHCAqGLyPqPeSACw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/debug: Only clear/set ->virtual_dr6 for userspace #DB
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kyle Huey <me@kylehuey.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201027093608.028952500@infradead.org>
References: <20201027093608.028952500@infradead.org>
MIME-Version: 1.0
Message-ID: <160383715005.397.4679134647227236896.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a195f3d4528a2f88d6f986f6b1101775ad4891cf
Gitweb:        https://git.kernel.org/tip/a195f3d4528a2f88d6f986f6b1101775ad4891cf
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 27 Oct 2020 10:15:06 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 27 Oct 2020 23:15:23 +01:00

x86/debug: Only clear/set ->virtual_dr6 for userspace #DB

The ->virtual_dr6 is the value used by ptrace_{get,set}_debugreg(6). A
kernel #DB clearing it could mean spurious malfunction of ptrace()
expectations.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kyle Huey <me@kylehuey.com> 
Link: https://lore.kernel.org/r/20201027093608.028952500@infradead.org

---
 arch/x86/kernel/traps.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index b5208aa..32b2d39 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -793,12 +793,6 @@ static __always_inline unsigned long debug_read_clear_dr6(void)
 	set_debugreg(DR6_RESERVED, 6);
 	dr6 ^= DR6_RESERVED; /* Flip to positive polarity */
 
-	/*
-	 * Clear the virtual DR6 value, ptrace routines will set bits here for
-	 * things we want signals for.
-	 */
-	current->thread.virtual_dr6 = 0;
-
 	return dr6;
 }
 
@@ -943,6 +937,12 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 	instrumentation_begin();
 
 	/*
+	 * Clear the virtual DR6 value, ptrace() routines will set bits here
+	 * for things it wants signals for.
+	 */
+	current->thread.virtual_dr6 = 0;
+
+	/*
 	 * The SDM says "The processor clears the BTF flag when it
 	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
 	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
