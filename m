Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DEE3B230A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhFWWLr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhFWWL2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41D3C0617A6;
        Wed, 23 Jun 2021 15:09:01 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:08:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486140;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yKMuYHGaL2afitCou4tURohPzp2Gs68YPmYELFQ1zVk=;
        b=w2CtrkDr84k9dz3zuISkDkUB80D/1+NczPYRxCfIE0GlY5LOsaxvvWKK7uxZkIloe2JqlI
        VW4tsCQRovyybgJOKtWuI8Knb2x0T/KQmFIz9X0pTp90kqO0OKY8wZ4M2BhzobZWGADfhy
        DKeT1Yrba4ObnqHvAkFCc4tfUCMSO7fTkQwuwMiNeq4hmtfUB5ouQi6aJhjwWmMXJJWDWV
        spxg+G6jJM2gvMuv+U7Wb1+1tFbG4/KWY89P40VCQ8wQKrfYGp6s5cu7c8ceL+/FgCZk4F
        hPGMJW1bfpYNPedIZ3qvJ6/4QL55NPJ+uYJru1G4+pqKCgK8KxAx+Kb14sThNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486140;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yKMuYHGaL2afitCou4tURohPzp2Gs68YPmYELFQ1zVk=;
        b=Bmpj6LT4ChohCxyOLgiS8t7RYQCNgKRrV/IREoETKNkj+R5QYS9yXK4mGgcJuAWykH5PtT
        c3mse2UZM7cFmWAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Mask PKRU from kernel XRSTOR[S] operations
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121456.606745195@linutronix.de>
References: <20210623121456.606745195@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448613907.395.9928699181826957389.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     30a304a138738d71a09c730ca8044e9662de0dbf
Gitweb:        https://git.kernel.org/tip/30a304a138738d71a09c730ca8044e9662de0dbf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:20 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 19:47:35 +02:00

x86/fpu: Mask PKRU from kernel XRSTOR[S] operations

As the PKRU state is managed separately restoring it from the xstate
buffer would be counterproductive as it might either restore a stale
value or reinit the PKRU state to 0.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121456.606745195@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h |  4 ++--
 arch/x86/include/asm/fpu/xstate.h   | 10 ++++++++++
 arch/x86/kernel/fpu/xstate.c        |  1 +
 arch/x86/mm/extable.c               |  2 +-
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 5217743..2a484f5 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -259,7 +259,7 @@ static inline void fxsave(struct fxregs_state *fx)
  */
 static inline void os_xrstor_booting(struct xregs_state *xstate)
 {
-	u64 mask = -1;
+	u64 mask = xfeatures_mask_fpstate();
 	u32 lmask = mask;
 	u32 hmask = mask >> 32;
 	int err;
@@ -388,7 +388,7 @@ extern void __restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask)
 
 static inline void restore_fpregs_from_fpstate(union fpregs_state *fpstate)
 {
-	__restore_fpregs_from_fpstate(fpstate, -1);
+	__restore_fpregs_from_fpstate(fpstate, xfeatures_mask_fpstate());
 }
 
 extern int copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 4ff4a00..109dfcc 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -111,6 +111,16 @@ static inline u64 xfeatures_mask_restore_user(void)
 	return xfeatures_mask_all & XFEATURE_MASK_USER_RESTORE;
 }
 
+/*
+ * Like xfeatures_mask_restore_user() but additionally restors the
+ * supported supervisor states.
+ */
+static inline u64 xfeatures_mask_fpstate(void)
+{
+	return xfeatures_mask_all & \
+		(XFEATURE_MASK_USER_RESTORE | XFEATURE_MASK_SUPERVISOR_SUPPORTED);
+}
+
 static inline u64 xfeatures_mask_independent(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_ARCH_LBR))
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 9fd124a..21a10a6 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -60,6 +60,7 @@ static short xsave_cpuid_features[] __initdata = {
  * XSAVE buffer, both supervisor and user xstates.
  */
 u64 xfeatures_mask_all __ro_after_init;
+EXPORT_SYMBOL_GPL(xfeatures_mask_all);
 
 static unsigned int xstate_offsets[XFEATURE_MAX] __ro_after_init =
 	{ [ 0 ... XFEATURE_MAX - 1] = -1};
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 2c5cccd..e1664e9 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -65,7 +65,7 @@ __visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
 	WARN_ONCE(1, "Bad FPU state detected at %pB, reinitializing FPU registers.",
 		  (void *)instruction_pointer(regs));
 
-	__restore_fpregs_from_fpstate(&init_fpstate, -1);
+	__restore_fpregs_from_fpstate(&init_fpstate, xfeatures_mask_fpstate());
 	return true;
 }
 EXPORT_SYMBOL_GPL(ex_handler_fprestore);
