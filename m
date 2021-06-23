Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5C93B2303
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhFWWLe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:11:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39990 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhFWWLW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:22 -0400
Date:   Wed, 23 Jun 2021 22:09:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486143;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sva2sVoPo6zQs/URAj0c+0CBtzDMFRC/iKdl9mShEU8=;
        b=XWcEdMRJpQq2wXnpSMJwCUtosSotnRlZxIcOxbxJseL3WXIvvrDGKwqG2tHGBhn31ZeDjZ
        EUeM2muy+sulJdZr+i4oXwNwDdO8yNjeo9wEGDKmd3Xu2PtPKjuvOWas8PJPQeRmbFw7O6
        1crNxnAgteBdYIBDG7eM82riHBkZwHYlNQnYIXf8pH2iV+tdvhAV8ppqMRxTacRk1QaXXh
        Off9zoaFdRkkSSB+JWcCvMxHn1c3Nbaq32g8BXEGCJtcEmDfpACYFQg3rTXQnKNq554OFF
        IxQhVZeXDkh1n25EktG+6aA5Pl5lw8SZoffb18IwzOF3dHUH86XZw7guM53WwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486143;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sva2sVoPo6zQs/URAj0c+0CBtzDMFRC/iKdl9mShEU8=;
        b=1lv0xaZdp5RG9g/NAk4KR5vBcp+6pftxqhSRxG5CUylDH68AOXv/dtzddjLzXxJiesr4j6
        E3P5yLZJT5E1B6Cg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Dont restore PKRU in fpregs_restore_userspace()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121456.303919033@linutronix.de>
References: <20210623121456.303919033@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448614195.395.6431824469868688600.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     2ebe81c6d800576e1213f9d7cf0068017ae610c1
Gitweb:        https://git.kernel.org/tip/2ebe81c6d800576e1213f9d7cf0068017ae610c1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:17 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 19:33:32 +02:00

x86/fpu: Dont restore PKRU in fpregs_restore_userspace()

switch_to() and flush_thread() write the task's PKRU value eagerly so
the PKRU value of current is always valid in the hardware.

That means there is no point in restoring PKRU on exit to user or when
reactivating the task's FPU registers in the signal frame setup path.

This allows to remove all the xstate buffer updates with PKRU values once
the PKRU state is stored in thread struct while a task is scheduled out.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121456.303919033@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 16 +++++++++++++++-
 arch/x86/include/asm/fpu/xstate.h   | 19 +++++++++++++++++++
 arch/x86/kernel/fpu/core.c          |  2 +-
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index bcfb636..5217743 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -457,7 +457,21 @@ static inline void fpregs_restore_userregs(void)
 		return;
 
 	if (!fpregs_state_valid(fpu, cpu)) {
-		restore_fpregs_from_fpstate(&fpu->state);
+		u64 mask;
+
+		/*
+		 * This restores _all_ xstate which has not been
+		 * established yet.
+		 *
+		 * If PKRU is enabled, then the PKRU value is already
+		 * correct because it was either set in switch_to() or in
+		 * flush_thread(). So it is excluded because it might be
+		 * not up to date in current->thread.fpu.xsave state.
+		 */
+		mask = xfeatures_mask_restore_user() |
+			xfeatures_mask_supervisor();
+		__restore_fpregs_from_fpstate(&fpu->state, mask);
+
 		fpregs_activate(fpu);
 		fpu->last_cpu = cpu;
 	}
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index af9ea13..6a0aaaf 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -35,6 +35,14 @@
 				      XFEATURE_MASK_BNDREGS | \
 				      XFEATURE_MASK_BNDCSR)
 
+/*
+ * Features which are restored when returning to user space.
+ * PKRU is not restored on return to user space because PKRU
+ * is switched eagerly in switch_to() and flush_thread()
+ */
+#define XFEATURE_MASK_USER_RESTORE	\
+	(XFEATURE_MASK_USER_SUPPORTED & ~XFEATURE_MASK_PKRU)
+
 /* All currently supported supervisor features */
 #define XFEATURE_MASK_SUPERVISOR_SUPPORTED (XFEATURE_MASK_PASID)
 
@@ -92,6 +100,17 @@ static inline u64 xfeatures_mask_uabi(void)
 	return xfeatures_mask_all & XFEATURE_MASK_USER_SUPPORTED;
 }
 
+/*
+ * The xfeatures which are restored by the kernel when returning to user
+ * mode. This is not necessarily the same as xfeatures_mask_uabi() as the
+ * kernel does not manage all XCR0 enabled features via xsave/xrstor as
+ * some of them have to be switched eagerly on context switch and exec().
+ */
+static inline u64 xfeatures_mask_restore_user(void)
+{
+	return xfeatures_mask_all & XFEATURE_MASK_USER_RESTORE;
+}
+
 static inline u64 xfeatures_mask_independent(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_ARCH_LBR))
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 1243738..470576c 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -404,7 +404,7 @@ void fpu__clear_user_states(struct fpu *fpu)
 	}
 
 	/* Reset user states in registers. */
-	restore_fpregs_from_init_fpstate(xfeatures_mask_uabi());
+	restore_fpregs_from_init_fpstate(xfeatures_mask_restore_user());
 
 	/*
 	 * Now all FPU registers have their desired values.  Inform the FPU
