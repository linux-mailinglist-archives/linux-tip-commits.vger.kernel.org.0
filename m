Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BB6437EDD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Oct 2021 21:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhJVT6r (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Oct 2021 15:58:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41396 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbhJVT6q (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Oct 2021 15:58:46 -0400
Date:   Fri, 22 Oct 2021 19:56:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634932587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oHvML4YG32ff5UPt7rIxaW0GUnPyvFDyNJkIzT3iRVI=;
        b=kV7jTY5hM/Vbgy9mADZjqJu0blLthD+pQ0CFxr0/Aw+BS85z1gGIY2v2tYYlUW7xKeMq+0
        Hcylv3Hj3KiEb2r4LNsLr/WlwrEnCK4PDlIAcEIK/ujr7iEId4hmqhidY9XXySW7epHNHZ
        71xDPmU65AOkEzEsx+giKvx92PJ+SqkFmBTU2paB2xsbaWgBDz2dQ4yf3zdWXEvo6ODVmC
        HTUMAd2A443E2noMAq1wG4H6VGcMt6sdfoeOfQtzD2aS181SCbAfyTAMbPlPFskkckZ7mn
        msTaCRCZM8CBg5bIZ/7wK//tHqIewmSDTSiLuDyaKyCfVqjh368omHfDU5UZxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634932587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oHvML4YG32ff5UPt7rIxaW0GUnPyvFDyNJkIzT3iRVI=;
        b=YDh1nARAHoNlAZ/8/8OErg6PKYor8RhcqERBM7tmIsFyVW9L5bk8XJpADmhzwTrRJrc5JJ
        0gGwIsycnIrvMXCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Move remaining xfeature helpers to core
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211014230739.514095101@linutronix.de>
References: <20211014230739.514095101@linutronix.de>
MIME-Version: 1.0
Message-ID: <163493258645.626.5771527202524713007.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     d72c87018d00782c3ac0a844c372158087debc0a
Gitweb:        https://git.kernel.org/tip/d72c87018d00782c3ac0a844c372158087debc0a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 01:09:40 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 22 Oct 2021 11:10:48 +02:00

x86/fpu/xstate: Move remaining xfeature helpers to core

Now that everything is mopped up, move all the helpers and prototypes into
the core header. They are not required by the outside.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211014230739.514095101@linutronix.de
---
 arch/x86/include/asm/fpu/xstate.h | 13 -------------
 arch/x86/kernel/fpu/xstate.h      | 13 +++++++++++++
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 61ae396..43ae89d 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -86,19 +86,6 @@
 #define XFEATURE_MASK_FPSTATE	(XFEATURE_MASK_USER_RESTORE | \
 				 XFEATURE_MASK_SUPERVISOR_SUPPORTED)
 
-static inline u64 xfeatures_mask_supervisor(void)
-{
-	return fpu_kernel_cfg.max_features & XFEATURE_MASK_SUPERVISOR_SUPPORTED;
-}
-
-static inline u64 xfeatures_mask_independent(void)
-{
-	if (!boot_cpu_has(X86_FEATURE_ARCH_LBR))
-		return XFEATURE_MASK_INDEPENDENT & ~XFEATURE_MASK_LBR;
-
-	return XFEATURE_MASK_INDEPENDENT;
-}
-
 extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
 
 extern void __init update_regset_xstate_info(unsigned int size,
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 3d45eb0..a1aa0ba 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -35,6 +35,19 @@ extern void fpu__init_system_xstate(unsigned int legacy_size);
 
 extern void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
 
+static inline u64 xfeatures_mask_supervisor(void)
+{
+	return fpu_kernel_cfg.max_features & XFEATURE_MASK_SUPERVISOR_SUPPORTED;
+}
+
+static inline u64 xfeatures_mask_independent(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR))
+		return XFEATURE_MASK_INDEPENDENT & ~XFEATURE_MASK_LBR;
+
+	return XFEATURE_MASK_INDEPENDENT;
+}
+
 /* XSAVE/XRSTOR wrapper functions */
 
 #ifdef CONFIG_X86_64
