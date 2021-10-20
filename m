Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD312434C68
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhJTNrF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:47:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52930 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhJTNqu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:46:50 -0400
Date:   Wed, 20 Oct 2021 13:44:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737475;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dXxOUUyJak/udDSMGqDXuJy8SpeSxsWXH2Kijy2qzDc=;
        b=zjqexvUnrHDcd8qULX9lv02q5C3kRdE/G8Fflm0xprDlYww2GbLGmMCLrFUREVTL9iDOme
        uG2zxxM4m3SlR8wDmiF6OO2aMdjzBxoi/eloOQkX7n1BQKCNZ4M+2Za+SgXu2LatmOojrf
        4x8yCJ3YFmQkLVTBbw6R0BAoESRe8ZsfVAoI1tOXs2I3cKqKtLy4e3tMrBkayVI6xkubW/
        reK5LAIhqcnT+F6TAEhIZ4H14md9ndvQINAvTWA/6PR9J+Nb+vRLXnnI10UhVsfmZX2rjd
        YPsJOY1Kqjcj4iQ676jeM85T5nJHCE+ernyLGEvXn0nOFz3Z9RBJV1ASJzBVGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737475;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dXxOUUyJak/udDSMGqDXuJy8SpeSxsWXH2Kijy2qzDc=;
        b=M0YOJkh4D8oKavjcr4NPjK03NhdlyC8f3dO8QP+NUvonyqXn/P80wLeNEXLBomeUFQOLqh
        7+7/O69cLDyfdABA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Make os_xrstor_booting() private
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011539.455836597@linutronix.de>
References: <20211015011539.455836597@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473747480.25758.121624462382717506.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     b579d0c3750eedc0dee433edaba88206a8e4348a
Gitweb:        https://git.kernel.org/tip/b579d0c3750eedc0dee433edaba88206a8e4348a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:16:23 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:28 +02:00

x86/fpu: Make os_xrstor_booting() private

It's only required in the xstate init code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011539.455836597@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 25 -------------------------
 arch/x86/kernel/fpu/xstate.c        | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 5da7528..3ad2ae7 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -226,31 +226,6 @@ static inline void fxsave(struct fxregs_state *fx)
 		     : "memory")
 
 /*
- * This function is called only during boot time when x86 caps are not set
- * up and alternative can not be used yet.
- */
-static inline void os_xrstor_booting(struct xregs_state *xstate)
-{
-	u64 mask = xfeatures_mask_fpstate();
-	u32 lmask = mask;
-	u32 hmask = mask >> 32;
-	int err;
-
-	WARN_ON(system_state != SYSTEM_BOOTING);
-
-	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
-	else
-		XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
-
-	/*
-	 * We should never fault when copying from a kernel buffer, and the FPU
-	 * state we set at boot time should be valid.
-	 */
-	WARN_ON_FPU(err);
-}
-
-/*
  * Save processor xstate to xsave area.
  *
  * Uses either XSAVE or XSAVEOPT or XSAVES depending on the CPU features
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 1f5a66a..b712c06 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -351,6 +351,29 @@ static void __init print_xstate_offset_size(void)
 }
 
 /*
+ * This function is called only during boot time when x86 caps are not set
+ * up and alternative can not be used yet.
+ */
+static __init void os_xrstor_booting(struct xregs_state *xstate)
+{
+	u64 mask = xfeatures_mask_fpstate();
+	u32 lmask = mask;
+	u32 hmask = mask >> 32;
+	int err;
+
+	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
+		XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
+	else
+		XSTATE_OP(XRSTOR, xstate, lmask, hmask, err);
+
+	/*
+	 * We should never fault when copying from a kernel buffer, and the FPU
+	 * state we set at boot time should be valid.
+	 */
+	WARN_ON_FPU(err);
+}
+
+/*
  * All supported features have either init state all zeros or are
  * handled in setup_init_fpu() individually. This is an explicit
  * feature list and does not use XFEATURE_MASK*SUPPORTED to catch
