Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1032B82D2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Nov 2020 18:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgKRRSQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Nov 2020 12:18:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56146 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgKRRSQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Nov 2020 12:18:16 -0500
Date:   Wed, 18 Nov 2020 17:18:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605719894;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kx8P4d0sWUgrdE6GVK91YXQbwnCDVUb+GAe3FVoMMvQ=;
        b=xs8i6DU1pfWfvKI0rwvo4h8Q/wdixiLsiUEPi6GMNC4q8EkQuzvOVlEvKPNMKHNW/jOTOH
        hiiGiyCK5WLuRLDhZnZHHj7n6oSxKLys23cb952Y/qCaO0MT0RScYXRV5UWcsLGxt1FH1d
        E2PbxHlkqw7+ypf4W/Q9i6p74thOQlNx+ecVOLKNb8hwWl66iWRdX4I0nVCzMw3BkXqHk6
        zc2+yxi3xriKjuLP7buZWpaJPnTm+3I3OHh2MX5Vh784qrjFGhFnjC8KHDuiJoBIOEJLpW
        wKrvIdgT3TAf5q+f2UpdC+ll4A/7hEUIyyuWqIcxNX+7VC2FuqygGZOtdfPJ2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605719894;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kx8P4d0sWUgrdE6GVK91YXQbwnCDVUb+GAe3FVoMMvQ=;
        b=juMRW7xgWLDeR6xSn1Z14kFMsKJIYBS/xdws/QeHca6w0lWNtKjV8AEsSlGduCz+rEzEEO
        6b7LsRlylV1eUUCA==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/head/64: Remove unused GET_CR2_INTO() macro
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201005151208.2212886-3-nivedita@alum.mit.edu>
References: <20201005151208.2212886-3-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <160571989294.11244.6098902926178128841.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     31d8546033053b98de00846ede8088bdbe38651d
Gitweb:        https://git.kernel.org/tip/31d8546033053b98de00846ede8088bdbe38651d
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Mon, 05 Oct 2020 11:12:08 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 18 Nov 2020 18:09:38 +01:00

x86/head/64: Remove unused GET_CR2_INTO() macro

Commit

  4b47cdbda6f1 ("x86/head/64: Move early exception dispatch to C code")

removed the usage of GET_CR2_INTO().

Drop the definition as well, and related definitions in paravirt.h and
asm-offsets.h

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201005151208.2212886-3-nivedita@alum.mit.edu
---
 arch/x86/include/asm/paravirt.h | 11 -----------
 arch/x86/kernel/asm-offsets.c   |  1 -
 arch/x86/kernel/head_64.S       |  9 ---------
 3 files changed, 21 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index d25cc68..f8dce11 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -812,17 +812,6 @@ extern void default_banner(void);
 #endif /* CONFIG_PARAVIRT_XXL */
 #endif	/* CONFIG_X86_64 */
 
-#ifdef CONFIG_PARAVIRT_XXL
-
-#define GET_CR2_INTO_AX							\
-	PARA_SITE(PARA_PATCH(PV_MMU_read_cr2),				\
-		  ANNOTATE_RETPOLINE_SAFE;				\
-		  call PARA_INDIRECT(pv_ops+PV_MMU_read_cr2);		\
-		 )
-
-#endif /* CONFIG_PARAVIRT_XXL */
-
-
 #endif /* __ASSEMBLY__ */
 #else  /* CONFIG_PARAVIRT */
 # define default_banner x86_init_noop
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 70b7154..60b9f42 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -66,7 +66,6 @@ static void __used common(void)
 	OFFSET(PV_IRQ_irq_disable, paravirt_patch_template, irq.irq_disable);
 	OFFSET(PV_IRQ_irq_enable, paravirt_patch_template, irq.irq_enable);
 	OFFSET(PV_CPU_iret, paravirt_patch_template, cpu.iret);
-	OFFSET(PV_MMU_read_cr2, paravirt_patch_template, mmu.read_cr2);
 #endif
 
 #ifdef CONFIG_XEN
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 7eb2a1c..2215d4c 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -26,15 +26,6 @@
 #include <asm/nospec-branch.h>
 #include <asm/fixmap.h>
 
-#ifdef CONFIG_PARAVIRT_XXL
-#include <asm/asm-offsets.h>
-#include <asm/paravirt.h>
-#define GET_CR2_INTO(reg) GET_CR2_INTO_AX ; _ASM_MOV %_ASM_AX, reg
-#else
-#define INTERRUPT_RETURN iretq
-#define GET_CR2_INTO(reg) _ASM_MOV %cr2, reg
-#endif
-
 /*
  * We are not able to switch in one step to the final KERNEL ADDRESS SPACE
  * because we need identity-mapped pages.
