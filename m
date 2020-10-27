Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE6E29CBE7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Oct 2020 23:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832242AbgJ0WTP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 27 Oct 2020 18:19:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49652 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1832259AbgJ0WTO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 27 Oct 2020 18:19:14 -0400
Date:   Tue, 27 Oct 2020 22:19:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603837151;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvySRBYXlT12Vi5G4QeTsoF9zVbsAwIORCuMUT2/f0E=;
        b=FR+g/fbFN7DuhMrezQIUXwmqnqADggcDwRq2Mgj1yIIRuq6eBoag2O580NdDfcdbX1hfEV
        9vIVyfMbM13hO925FJUKEHIMRSOUhXksWvlJSeMUIRZsdIQEn6vDS9Clo7xpsmi7kvtuYN
        vBZxnlonGUGZuf7Xii4dNTp4w5ncfPmsKT09eBWhgSKQTfTnGL5bz14pbtesWj4e1JMsNp
        dXfsavHShib3qSvIY0VSgCE4RJTRvk762n/8zKseypj3N7fS88/jy/iyKYYYbJWUu8qBF3
        PpUSNw5//cOw20gY7dazPESWeQxVGGGUp3xi6ylNW6WphmyglRUcKOuKKMglVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603837151;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvySRBYXlT12Vi5G4QeTsoF9zVbsAwIORCuMUT2/f0E=;
        b=jJz9jSTwsTU70ytqXiVoMPsgibLJe4F13nN04E9YTgcNBwVzDZJaIRtrikMT43ymjmoQ6r
        RXiRVdmGCIWwEiAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/debug: Fix BTF handling
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kyle Huey <me@kylehuey.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201027093607.956147736@infradead.org>
References: <20201027093607.956147736@infradead.org>
MIME-Version: 1.0
Message-ID: <160383715065.397.13798611442467299455.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     2a9baf5ad4884108b3c6d56a50e8105ccf8a4ee7
Gitweb:        https://git.kernel.org/tip/2a9baf5ad4884108b3c6d56a50e8105ccf8a4ee7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 27 Oct 2020 10:15:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 27 Oct 2020 23:15:23 +01:00

x86/debug: Fix BTF handling

The SDM states that #DB clears DEBUGCTLMSR_BTF, this means that when the
bit is set for userspace (TIF_BLOCKSTEP) and a kernel #DB happens first,
the BTF bit meant for userspace execution is lost.

Have the kernel #DB handler restore the BTF bit when it was requested
for userspace.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kyle Huey <me@kylehuey.com> 
Link: https://lore.kernel.org/r/20201027093607.956147736@infradead.org

---
 arch/x86/kernel/traps.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 3c70fb3..b5208aa 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -799,13 +799,6 @@ static __always_inline unsigned long debug_read_clear_dr6(void)
 	 */
 	current->thread.virtual_dr6 = 0;
 
-	/*
-	 * The SDM says "The processor clears the BTF flag when it
-	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
-	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
-	 */
-	clear_thread_flag(TIF_BLOCKSTEP);
-
 	return dr6;
 }
 
@@ -873,6 +866,20 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	 */
 	WARN_ON_ONCE(user_mode(regs));
 
+	if (test_thread_flag(TIF_BLOCKSTEP)) {
+		/*
+		 * The SDM says "The processor clears the BTF flag when it
+		 * generates a debug exception." but PTRACE_BLOCKSTEP requested
+		 * it for userspace, but we just took a kernel #DB, so re-set
+		 * BTF.
+		 */
+		unsigned long debugctl;
+
+		rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
+		debugctl |= DEBUGCTLMSR_BTF;
+		wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
+	}
+
 	/*
 	 * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
 	 * watchpoint at the same time then that will still be handled.
@@ -936,6 +943,13 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 	instrumentation_begin();
 
 	/*
+	 * The SDM says "The processor clears the BTF flag when it
+	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
+	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
+	 */
+	clear_thread_flag(TIF_BLOCKSTEP);
+
+	/*
 	 * If dr6 has no reason to give us about the origin of this trap,
 	 * then it's very likely the result of an icebp/int01 trap.
 	 * User wants a sigtrap for that.
