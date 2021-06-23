Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D993B231C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFWWMQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40076 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhFWWLf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:35 -0400
Date:   Wed, 23 Jun 2021 22:09:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pzUAjNR5t1tOTaDCZBZSw48Tgfyy9BVDzaoga8XpWOU=;
        b=mZLo+WWyNOl6c93AybZKK5S5vcMV6Z4XgzmegM80DaUmuyUvGqvgLrDHJ2fGbGuQhpfjvx
        R9URSarEl19O+pgh0QqFqJOHW0o0uQnSwEPQH59nBrTG46HHlj9OvHhH58tI3c6JCEmUmh
        /InqTLkkmeDFjMKFpDoQAcJBEFxKUhPao/BmjzzYTh4Bhr4cES/39t57VtSOssdzvdrTTL
        hcalcBMOp9j07VWiWxpbfdrMDkaKAP38SPG1l2GEKxshpxJKH7So8/8IMH0LwOEewJNI2+
        qsbA7z3nzAIZBfQfi0pkGlCTjVOC1keWSn8Xa19dI3o5pI0fRSF5q90qDgw2Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pzUAjNR5t1tOTaDCZBZSw48Tgfyy9BVDzaoga8XpWOU=;
        b=74jYoISVeGUdLKTO3ct8CUHMyAbF8xmRkDeyCrJlhsfWyHylBlRS5N3EnitMV2CSRqSu/7
        vtk8BCSJKQoYJRBQ==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Rename "dynamic" XSTATEs to "independent"
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1eecb0e4f3e07828ebe5d737ec77dc3b708fad2d.1623388344.git.luto@kernel.org>
References: <1eecb0e4f3e07828ebe5d737ec77dc3b708fad2d.1623388344.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <162448615502.395.6667205606335413464.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     01707b66535872f7a0d87f66078fd018d1814be0
Gitweb:        https://git.kernel.org/tip/01707b66535872f7a0d87f66078fd018d1814be0
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Wed, 23 Jun 2021 14:02:03 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 18:42:11 +02:00

x86/fpu: Rename "dynamic" XSTATEs to "independent"

The salient feature of "dynamic" XSTATEs is that they are not part of the
main task XSTATE buffer.  The fact that they are dynamically allocated is
irrelevant and will become quite confusing when user math XSTATEs start
being dynamically allocated.  Rename them to "independent" because they
are independent of the main XSTATE code.

This is just a search-and-replace with some whitespace updates to keep
things aligned.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/1eecb0e4f3e07828ebe5d737ec77dc3b708fad2d.1623388344.git.luto@kernel.org
Link: https://lkml.kernel.org/r/20210623121454.911450390@linutronix.de
---
 arch/x86/events/intel/lbr.c       |  6 +--
 arch/x86/include/asm/fpu/xstate.h | 22 +++++------
 arch/x86/kernel/fpu/xstate.c      | 62 +++++++++++++++---------------
 3 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 4409d2c..2fa2df3 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -491,7 +491,7 @@ static void intel_pmu_arch_lbr_xrstors(void *ctx)
 {
 	struct x86_perf_task_context_arch_lbr_xsave *task_ctx = ctx;
 
-	copy_kernel_to_dynamic_supervisor(&task_ctx->xsave, XFEATURE_MASK_LBR);
+	copy_kernel_to_independent_supervisor(&task_ctx->xsave, XFEATURE_MASK_LBR);
 }
 
 static __always_inline bool lbr_is_reset_in_cstate(void *ctx)
@@ -576,7 +576,7 @@ static void intel_pmu_arch_lbr_xsaves(void *ctx)
 {
 	struct x86_perf_task_context_arch_lbr_xsave *task_ctx = ctx;
 
-	copy_dynamic_supervisor_to_kernel(&task_ctx->xsave, XFEATURE_MASK_LBR);
+	copy_independent_supervisor_to_kernel(&task_ctx->xsave, XFEATURE_MASK_LBR);
 }
 
 static void __intel_pmu_lbr_save(void *ctx)
@@ -992,7 +992,7 @@ static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
 		intel_pmu_store_lbr(cpuc, NULL);
 		return;
 	}
-	copy_dynamic_supervisor_to_kernel(&xsave->xsave, XFEATURE_MASK_LBR);
+	copy_independent_supervisor_to_kernel(&xsave->xsave, XFEATURE_MASK_LBR);
 
 	intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
 }
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 00e1a2a..a55bd5c 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -42,21 +42,21 @@
  * and its size may be huge. Saving/restoring such supervisor state components
  * at each context switch can cause high CPU and space overhead, which should
  * be avoided. Such supervisor state components should only be saved/restored
- * on demand. The on-demand dynamic supervisor features are set in this mask.
+ * on demand. The on-demand supervisor features are set in this mask.
  *
- * Unlike the existing supported supervisor features, a dynamic supervisor
+ * Unlike the existing supported supervisor features, an independent supervisor
  * feature does not allocate a buffer in task->fpu, and the corresponding
  * supervisor state component cannot be saved/restored at each context switch.
  *
- * To support a dynamic supervisor feature, a developer should follow the
+ * To support an independent supervisor feature, a developer should follow the
  * dos and don'ts as below:
  * - Do dynamically allocate a buffer for the supervisor state component.
  * - Do manually invoke the XSAVES/XRSTORS instruction to save/restore the
  *   state component to/from the buffer.
- * - Don't set the bit corresponding to the dynamic supervisor feature in
+ * - Don't set the bit corresponding to the independent supervisor feature in
  *   IA32_XSS at run time, since it has been set at boot time.
  */
-#define XFEATURE_MASK_DYNAMIC (XFEATURE_MASK_LBR)
+#define XFEATURE_MASK_INDEPENDENT (XFEATURE_MASK_LBR)
 
 /*
  * Unsupported supervisor features. When a supervisor feature in this mask is
@@ -66,7 +66,7 @@
 
 /* All supervisor states including supported and unsupported states. */
 #define XFEATURE_MASK_SUPERVISOR_ALL (XFEATURE_MASK_SUPERVISOR_SUPPORTED | \
-				      XFEATURE_MASK_DYNAMIC | \
+				      XFEATURE_MASK_INDEPENDENT | \
 				      XFEATURE_MASK_SUPERVISOR_UNSUPPORTED)
 
 #ifdef CONFIG_X86_64
@@ -87,12 +87,12 @@ static inline u64 xfeatures_mask_user(void)
 	return xfeatures_mask_all & XFEATURE_MASK_USER_SUPPORTED;
 }
 
-static inline u64 xfeatures_mask_dynamic(void)
+static inline u64 xfeatures_mask_independent(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_ARCH_LBR))
-		return XFEATURE_MASK_DYNAMIC & ~XFEATURE_MASK_LBR;
+		return XFEATURE_MASK_INDEPENDENT & ~XFEATURE_MASK_LBR;
 
-	return XFEATURE_MASK_DYNAMIC;
+	return XFEATURE_MASK_INDEPENDENT;
 }
 
 extern u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
@@ -104,8 +104,8 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
 int xfeature_size(int xfeature_nr);
 int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
 int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
-void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
-void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask);
+void copy_independent_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
+void copy_kernel_to_independent_supervisor(struct xregs_state *xstate, u64 mask);
 
 enum xstate_copy_mode {
 	XSTATE_COPY_FP,
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 0eb42a1..27246a8 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -151,7 +151,7 @@ void fpu__init_cpu_xstate(void)
 	 */
 	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor() |
-				     xfeatures_mask_dynamic());
+				     xfeatures_mask_independent());
 	}
 }
 
@@ -551,7 +551,7 @@ static void check_xstate_against_struct(int nr)
  * how large the XSAVE buffer needs to be.  We are recalculating
  * it to be safe.
  *
- * Dynamic XSAVE features allocate their own buffers and are not
+ * Independent XSAVE features allocate their own buffers and are not
  * covered by these checks. Only the size of the buffer for task->fpu
  * is checked here.
  */
@@ -617,18 +617,18 @@ static unsigned int __init get_xsaves_size(void)
 }
 
 /*
- * Get the total size of the enabled xstates without the dynamic supervisor
+ * Get the total size of the enabled xstates without the independent supervisor
  * features.
  */
-static unsigned int __init get_xsaves_size_no_dynamic(void)
+static unsigned int __init get_xsaves_size_no_independent(void)
 {
-	u64 mask = xfeatures_mask_dynamic();
+	u64 mask = xfeatures_mask_independent();
 	unsigned int size;
 
 	if (!mask)
 		return get_xsaves_size();
 
-	/* Disable dynamic features. */
+	/* Disable independent features. */
 	wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor());
 
 	/*
@@ -637,7 +637,7 @@ static unsigned int __init get_xsaves_size_no_dynamic(void)
 	 */
 	size = get_xsaves_size();
 
-	/* Re-enable dynamic features so XSAVES will work on them again. */
+	/* Re-enable independent features so XSAVES will work on them again. */
 	wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor() | mask);
 
 	return size;
@@ -680,7 +680,7 @@ static int __init init_xstate_size(void)
 	xsave_size = get_xsave_size();
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES))
-		possible_xstate_size = get_xsaves_size_no_dynamic();
+		possible_xstate_size = get_xsaves_size_no_independent();
 	else
 		possible_xstate_size = xsave_size;
 
@@ -837,7 +837,7 @@ void fpu__resume_cpu(void)
 	 */
 	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor()  |
-				     xfeatures_mask_dynamic());
+				     xfeatures_mask_independent());
 	}
 }
 
@@ -1163,34 +1163,34 @@ int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave,
 }
 
 /**
- * copy_dynamic_supervisor_to_kernel() - Save dynamic supervisor states to
- *                                       an xsave area
+ * copy_independent_supervisor_to_kernel() - Save independent supervisor states to
+ *                                           an xsave area
  * @xstate: A pointer to an xsave area
- * @mask: Represent the dynamic supervisor features saved into the xsave area
+ * @mask: Represent the independent supervisor features saved into the xsave area
  *
- * Only the dynamic supervisor states sets in the mask are saved into the xsave
- * area (See the comment in XFEATURE_MASK_DYNAMIC for the details of dynamic
- * supervisor feature). Besides the dynamic supervisor states, the legacy
+ * Only the independent supervisor states sets in the mask are saved into the xsave
+ * area (See the comment in XFEATURE_MASK_INDEPENDENT for the details of independent
+ * supervisor feature). Besides the independent supervisor states, the legacy
  * region and XSAVE header are also saved into the xsave area. The supervisor
  * features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
  * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not saved.
  *
  * The xsave area must be 64-bytes aligned.
  */
-void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask)
+void copy_independent_supervisor_to_kernel(struct xregs_state *xstate, u64 mask)
 {
-	u64 dynamic_mask = xfeatures_mask_dynamic() & mask;
+	u64 independent_mask = xfeatures_mask_independent() & mask;
 	u32 lmask, hmask;
 	int err;
 
 	if (WARN_ON_FPU(!boot_cpu_has(X86_FEATURE_XSAVES)))
 		return;
 
-	if (WARN_ON_FPU(!dynamic_mask))
+	if (WARN_ON_FPU(!independent_mask))
 		return;
 
-	lmask = dynamic_mask;
-	hmask = dynamic_mask >> 32;
+	lmask = independent_mask;
+	hmask = independent_mask >> 32;
 
 	XSTATE_OP(XSAVES, xstate, lmask, hmask, err);
 
@@ -1199,34 +1199,34 @@ void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask)
 }
 
 /**
- * copy_kernel_to_dynamic_supervisor() - Restore dynamic supervisor states from
- *                                       an xsave area
+ * copy_kernel_to_independent_supervisor() - Restore independent supervisor states from
+ *                                           an xsave area
  * @xstate: A pointer to an xsave area
- * @mask: Represent the dynamic supervisor features restored from the xsave area
+ * @mask: Represent the independent supervisor features restored from the xsave area
  *
- * Only the dynamic supervisor states sets in the mask are restored from the
- * xsave area (See the comment in XFEATURE_MASK_DYNAMIC for the details of
- * dynamic supervisor feature). Besides the dynamic supervisor states, the
+ * Only the independent supervisor states sets in the mask are restored from the
+ * xsave area (See the comment in XFEATURE_MASK_INDEPENDENT for the details of
+ * independent supervisor feature). Besides the independent supervisor states, the
  * legacy region and XSAVE header are also restored from the xsave area. The
  * supervisor features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
  * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not restored.
  *
  * The xsave area must be 64-bytes aligned.
  */
-void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask)
+void copy_kernel_to_independent_supervisor(struct xregs_state *xstate, u64 mask)
 {
-	u64 dynamic_mask = xfeatures_mask_dynamic() & mask;
+	u64 independent_mask = xfeatures_mask_independent() & mask;
 	u32 lmask, hmask;
 	int err;
 
 	if (WARN_ON_FPU(!boot_cpu_has(X86_FEATURE_XSAVES)))
 		return;
 
-	if (WARN_ON_FPU(!dynamic_mask))
+	if (WARN_ON_FPU(!independent_mask))
 		return;
 
-	lmask = dynamic_mask;
-	hmask = dynamic_mask >> 32;
+	lmask = independent_mask;
+	hmask = independent_mask >> 32;
 
 	XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
 
