Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6683B2313
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhFWWMD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40026 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhFWWL2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:28 -0400
Date:   Wed, 23 Jun 2021 22:09:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486149;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rHT1xy2y6HmWEAcL2Bua6yAiuEzC27z+9jqCwE3Qpcc=;
        b=qR3iyY0M6JMdnwOriIGShvuNswOrJ0306ZEWlf56xMeDxJKC43+TtlX/m7vY2XlagnJUnq
        1mCESLuwwbPvC3k1wq8ebPlEopEDhj2dL2XwYDJKNBu8INqug0R+/0ed/KgDwAwK9oYTFO
        szY8LS0nbXk55lzokHEpdHBo0UQaYk/40szvnkxYbDjogiWc0APu6OV8nU7OSBH6FlNJqb
        XttRS7eDfYSNxl0iL5asfLm7T9Kpc0iKhfVYM/brnnjFBOKa/te4AOgfgQzvsLSKRrcPoG
        CDhWGKOB53I2kTXIEPPMZhBdL8JB+Mx3uOHiChPCFvbFtqJnZjNk7/bzTzGBvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486149;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rHT1xy2y6HmWEAcL2Bua6yAiuEzC27z+9jqCwE3Qpcc=;
        b=uDG23VoqH9emNpSx5HMqC/Ub6lTfJopy+/yk8QxquYbpPyShIZrRYCs1RmOZ1oqMk2xkHT
        CpIohJxFkVH0TyBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Use pkru_write_default() in
 copy_init_fpstate_to_fpregs()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121455.732508792@linutronix.de>
References: <20210623121455.732508792@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448614794.395.13993829314591430410.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     371071131cd1032c1e9172c51234a2a324841cab
Gitweb:        https://git.kernel.org/tip/371071131cd1032c1e9172c51234a2a324841cab
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:11 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 19:15:16 +02:00

x86/fpu: Use pkru_write_default() in copy_init_fpstate_to_fpregs()

There is no point in using copy_init_pkru_to_fpregs() which in turn calls
write_pkru(). write_pkru() tries to fiddle with the task's xstate buffer
for nothing because the XRSTOR[S](init_fpstate) just cleared the xfeature
flag in the xstate header which makes get_xsave_addr() fail.

It's a useless exercise anyway because the reinitialization activates the
FPU so before the task's xstate buffer can be used again a XRSTOR[S] must
happen which in turn dumps the PKRU value.

Get rid of the now unused copy_init_pkru_to_fpregs().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121455.732508792@linutronix.de
---
 arch/x86/include/asm/pkeys.h |  1 -
 arch/x86/kernel/fpu/core.c   |  3 +--
 arch/x86/mm/pkeys.c          | 17 -----------------
 include/linux/pkeys.h        |  4 ----
 4 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 4128f64..5c7bcaa 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -124,7 +124,6 @@ extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val);
 extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val);
-extern void copy_init_pkru_to_fpregs(void);
 
 static inline int vma_pkey(struct vm_area_struct *vma)
 {
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 3866954..fedadcb 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -311,8 +311,7 @@ static inline void restore_fpregs_from_init_fpstate(u64 features_mask)
 	else
 		frstor(&init_fpstate.fsave);
 
-	if (cpu_feature_enabled(X86_FEATURE_OSPKE))
-		copy_init_pkru_to_fpregs();
+	pkru_write_default();
 }
 
 /*
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index a02cfcf..fb171a5 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -10,7 +10,6 @@
 
 #include <asm/cpufeature.h>             /* boot_cpu_has, ...            */
 #include <asm/mmu_context.h>            /* vma_pkey()                   */
-#include <asm/pkru.h>			/* read/write_pkru()		*/
 
 int __execute_only_pkey(struct mm_struct *mm)
 {
@@ -125,22 +124,6 @@ u32 init_pkru_value = PKRU_AD_KEY( 1) | PKRU_AD_KEY( 2) | PKRU_AD_KEY( 3) |
 		      PKRU_AD_KEY(10) | PKRU_AD_KEY(11) | PKRU_AD_KEY(12) |
 		      PKRU_AD_KEY(13) | PKRU_AD_KEY(14) | PKRU_AD_KEY(15);
 
-/*
- * Called from the FPU code when creating a fresh set of FPU
- * registers.  This is called from a very specific context where
- * we know the FPU registers are safe for use and we can use PKRU
- * directly.
- */
-void copy_init_pkru_to_fpregs(void)
-{
-	u32 init_pkru_value_snapshot = READ_ONCE(init_pkru_value);
-	/*
-	 * Override the PKRU state that came from 'init_fpstate'
-	 * with the baseline from the process.
-	 */
-	write_pkru(init_pkru_value_snapshot);
-}
-
 static ssize_t init_pkru_read_file(struct file *file, char __user *user_buf,
 			     size_t count, loff_t *ppos)
 {
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 2955ba9..6beb26b 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -44,10 +44,6 @@ static inline bool arch_pkeys_enabled(void)
 	return false;
 }
 
-static inline void copy_init_pkru_to_fpregs(void)
-{
-}
-
 #endif /* ! CONFIG_ARCH_HAS_PKEYS */
 
 #endif /* _LINUX_PKEYS_H */
