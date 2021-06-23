Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742643B231F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhFWWMS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhFWWLh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA077C0613A4;
        Wed, 23 Jun 2021 15:09:06 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:09:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486145;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q5NVI8DrylL7DEMOJkVXZfUznAZva5FMVyNLcyjqOxc=;
        b=xonHyMyXuCP38ZV0K/+DBYjE2GpImfOhmorXK37Wv90EJJeJINyqml0QMALV52oKn02bNE
        hivxOItUW5er4UX43Ny9aZd/Ia8KiwRAxF6inBqoonOq9/RFNH2KxXLovP3zxd7/zfIgAm
        MSFn9jVmjs8rY33SKDNL+0+B6wLIzw4NGfWawRBaA4p3qzq19cWtgXZ6YYe7d1tL2Z8DcM
        xzwRA+WYIzzeG4clnStqaiaHl5K9yiBfkrihbJxwvR2qifCMSQ0aUWupyL3iBTczspazNL
        kfVdQeJxB66yv00CUOyxtQGjaaJZumF5rQ8bAgRpunJmDIGdZYBGY/z9yHTayA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486145;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q5NVI8DrylL7DEMOJkVXZfUznAZva5FMVyNLcyjqOxc=;
        b=yImyYBurOxbnj+VRpDzAxBC+uBTwugjqNmGULOd/jx1zXQ6KLtvTbsq0jloRIECiQvfX/+
        vnlDdeagsGgSVNAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Move FXSAVE_LEAK quirk info __copy_kernel_to_fpregs()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121456.114271278@linutronix.de>
References: <20210623121456.114271278@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448614396.395.10829619164003680141.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     1d9bffab116fadfe1594f5fea2b50ab280d81d30
Gitweb:        https://git.kernel.org/tip/1d9bffab116fadfe1594f5fea2b50ab280d81d30
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:15 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 19:26:37 +02:00

x86/fpu: Move FXSAVE_LEAK quirk info __copy_kernel_to_fpregs()

copy_kernel_to_fpregs() restores all xfeatures but it is also the place
where the AMD FXSAVE_LEAK bug is handled.

That prevents fpregs_restore_userregs() to limit the restored features,
which is required to untangle PKRU and XSTATE handling and also for the
upcoming supervisor state management.

Move the FXSAVE_LEAK quirk into __copy_kernel_to_fpregs() and deinline that
function which has become rather fat.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121456.114271278@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 25 +------------------------
 arch/x86/kernel/fpu/core.c          | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index f7688f6..63d9796 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -379,33 +379,10 @@ static inline int os_xrstor_safe(struct xregs_state *xstate, u64 mask)
 	return err;
 }
 
-static inline void __restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask)
-{
-	if (use_xsave()) {
-		os_xrstor(&fpstate->xsave, mask);
-	} else {
-		if (use_fxsr())
-			fxrstor(&fpstate->fxsave);
-		else
-			frstor(&fpstate->fsave);
-	}
-}
+extern void __restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask);
 
 static inline void restore_fpregs_from_fpstate(union fpregs_state *fpstate)
 {
-	/*
-	 * AMD K7/K8 CPUs don't save/restore FDP/FIP/FOP unless an exception is
-	 * pending. Clear the x87 state here by setting it to fixed values.
-	 * "m" is a random variable that should be in L1.
-	 */
-	if (unlikely(static_cpu_has_bug(X86_BUG_FXSAVE_LEAK))) {
-		asm volatile(
-			"fnclex\n\t"
-			"emms\n\t"
-			"fildl %P[addr]"	/* set F?P to defined value */
-			: : [addr] "m" (fpstate));
-	}
-
 	__restore_fpregs_from_fpstate(fpstate, -1);
 }
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 6babf18..afd0dee 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -124,6 +124,33 @@ void save_fpregs_to_fpstate(struct fpu *fpu)
 }
 EXPORT_SYMBOL(save_fpregs_to_fpstate);
 
+void __restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask)
+{
+	/*
+	 * AMD K7/K8 and later CPUs up to Zen don't save/restore
+	 * FDP/FIP/FOP unless an exception is pending. Clear the x87 state
+	 * here by setting it to fixed values.  "m" is a random variable
+	 * that should be in L1.
+	 */
+	if (unlikely(static_cpu_has_bug(X86_BUG_FXSAVE_LEAK))) {
+		asm volatile(
+			"fnclex\n\t"
+			"emms\n\t"
+			"fildl %P[addr]"	/* set F?P to defined value */
+			: : [addr] "m" (fpstate));
+	}
+
+	if (use_xsave()) {
+		os_xrstor(&fpstate->xsave, mask);
+	} else {
+		if (use_fxsr())
+			fxrstor(&fpstate->fxsave);
+		else
+			frstor(&fpstate->fsave);
+	}
+}
+EXPORT_SYMBOL_GPL(__restore_fpregs_from_fpstate);
+
 void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 {
 	preempt_disable();
