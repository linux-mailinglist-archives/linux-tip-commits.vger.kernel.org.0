Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF96329CBE8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Oct 2020 23:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832288AbgJ0WTZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 27 Oct 2020 18:19:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49638 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1832258AbgJ0WTN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 27 Oct 2020 18:19:13 -0400
Date:   Tue, 27 Oct 2020 22:19:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603837150;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vZ0OLvclMcvOEQbqjGZ6fphpjVgWDNxajVwLhiJ2hHE=;
        b=P3kPCBr0DlZ6EhdhHZiWcrvtdTnBXuDa5UccgEKx0TF7tRGjnMSr/tSCVlUKbsXN5cRlkD
        ORJfKMx5zC5IvHNk7EeAjrU+SWRjB7KGqo0kexlljmVbcnMHYM+zAdlCwVM+3gW/VJy1H5
        06KhCs4mZrlJ4LNofEzyFY7XRPJelKvV6nRQmU31KwcwytHqNVPOddP6VVVB4gS/AX+M1h
        UsZvxSl1CX/BbQ2f9Pd+bpHH7oxjjYWV/80YO40aY1OqLFbpmD6wwwliFlhBzUgjHCOrLU
        iT6wiRvCGKgEbEncD7WUNC1bF0RzI4Q1cF5QFzvrqwVSPUfmOdB/GX3IKr/DCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603837150;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vZ0OLvclMcvOEQbqjGZ6fphpjVgWDNxajVwLhiJ2hHE=;
        b=VBHUeBAx18ZLSUggKCZb26ZV6f5Cv1S7I48UNdHilvSfL1GOAGPF43yPN5Lx5iJdjBNDgb
        ai1bA4KLuHXcedDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/debug: Fix DR_STEP vs ptrace_get_debugreg(6)
Cc:     Kyle Huey <me@kylehuey.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201027183330.GM2628@hirez.programming.kicks-ass.net>
References: <20201027183330.GM2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <160383714941.397.12811023630821434314.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     cb05143bdf428f280a5d519c82abf196d7871c11
Gitweb:        https://git.kernel.org/tip/cb05143bdf428f280a5d519c82abf196d7871c11
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 27 Oct 2020 19:33:30 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 27 Oct 2020 23:15:24 +01:00

x86/debug: Fix DR_STEP vs ptrace_get_debugreg(6)

Commit d53d9bc0cf78 ("x86/debug: Change thread.debugreg6 to
thread.virtual_dr6") changed the semantics of the variable from random
collection of bits, to exactly only those bits that ptrace() needs.

Unfortunately this lost DR_STEP for PTRACE_{BLOCK,SINGLE}STEP.

Furthermore, it turns out that userspace expects DR_STEP to be
unconditionally available, even for manual TF usage outside of
PTRACE_{BLOCK,SINGLE}_STEP.

Fixes: d53d9bc0cf78 ("x86/debug: Change thread.debugreg6 to thread.virtual_dr6")
Reported-by: Kyle Huey <me@kylehuey.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kyle Huey <me@kylehuey.com> 
Link: https://lore.kernel.org/r/20201027183330.GM2628@hirez.programming.kicks-ass.net

---
 arch/x86/kernel/traps.c |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 32b2d39..e19df6c 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -937,10 +937,13 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 	instrumentation_begin();
 
 	/*
-	 * Clear the virtual DR6 value, ptrace() routines will set bits here
-	 * for things it wants signals for.
+	 * Start the virtual/ptrace DR6 value with just the DR_STEP mask
+	 * of the real DR6. ptrace_triggered() will set the DR_TRAPn bits.
+	 *
+	 * Userspace expects DR_STEP to be visible in ptrace_get_debugreg(6)
+	 * even if it is not the result of PTRACE_SINGLESTEP.
 	 */
-	current->thread.virtual_dr6 = 0;
+	current->thread.virtual_dr6 = (dr6 & DR_STEP);
 
 	/*
 	 * The SDM says "The processor clears the BTF flag when it
