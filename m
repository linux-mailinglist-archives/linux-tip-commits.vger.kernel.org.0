Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D053B231B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhFWWMQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39990 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbhFWWLe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:34 -0400
Date:   Wed, 23 Jun 2021 22:09:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E9DzTRS7RgxWD7f8V5ieJoUOwwIPYlW2tjlwEiSrZrs=;
        b=PeBsnbaXvAj+/ZrEeQgfS2hKfLRr2eS+Fe5aTGVCtOwQrSun8aqZQuqcmMiD/0NlC36Cb6
        mxqkVShbODREYnsOa9RNPGPW8jwA+HqYoIbq/eC3KoQnJAngMYiEbFOQuXuNawvDHX+EIt
        1GZuo6gdVnZ2r79IUzfxOkP4tIUC0zJX/ywWiwPks6KPbz0SCqUAXhCN9xU7tdknSIDsEp
        I3FP+Uzj2oXt5aA+DeinQqQ6J1p09AWozrId0mlOqrVwbj/N07O0Eb+yo8uNseie5c41yc
        c7ogDJpb8CTCUHRxMwpC9+01DN6tgFOYyoRnot8X9fcUFfjGL3TH0jUjS8OThA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E9DzTRS7RgxWD7f8V5ieJoUOwwIPYlW2tjlwEiSrZrs=;
        b=EVZW2ledaiLwtIE6gt5am4jr62TLVglbA6Sj7RCJ3XZjgiaKCQV0d2H2mcNHTA+g6Dj0oW
        GgoZYsfll9dhJ2Dg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Sanitize handling of independent features
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210623121455.004880675@linutronix.de>
References: <20210623121455.004880675@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448615412.395.16375318389729563847.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     a75c52896b6d42d6600db4d4dd9f7e4bde9218db
Gitweb:        https://git.kernel.org/tip/a75c52896b6d42d6600db4d4dd9f7e4bde9218db
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:04 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 18:46:20 +02:00

x86/fpu/xstate: Sanitize handling of independent features

The copy functions for the independent features are horribly named and the
supervisor and independent part is just overengineered.

The point is that the supplied mask has either to be a subset of the
independent features or a subset of the task->fpu.xstate managed features.

Rewrite it so it checks for invalid overlaps of these areas in the caller
supplied feature mask. Rename it so it follows the new naming convention
for these operations. Mop up the function documentation.

This allows to use that function for other purposes as well.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lkml.kernel.org/r/20210623121455.004880675@linutronix.de
---
 arch/x86/events/intel/lbr.c       |  6 +-
 arch/x86/include/asm/fpu/xstate.h |  5 +-
 arch/x86/kernel/fpu/xstate.c      | 98 ++++++++++++++----------------
 3 files changed, 54 insertions(+), 55 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 2fa2df3..f338645 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -491,7 +491,7 @@ static void intel_pmu_arch_lbr_xrstors(void *ctx)
 {
 	struct x86_perf_task_context_arch_lbr_xsave *task_ctx = ctx;
 
-	copy_kernel_to_independent_supervisor(&task_ctx->xsave, XFEATURE_MASK_LBR);
+	xrstors(&task_ctx->xsave, XFEATURE_MASK_LBR);
 }
 
 static __always_inline bool lbr_is_reset_in_cstate(void *ctx)
@@ -576,7 +576,7 @@ static void intel_pmu_arch_lbr_xsaves(void *ctx)
 {
 	struct x86_perf_task_context_arch_lbr_xsave *task_ctx = ctx;
 
-	copy_independent_supervisor_to_kernel(&task_ctx->xsave, XFEATURE_MASK_LBR);
+	xsaves(&task_ctx->xsave, XFEATURE_MASK_LBR);
 }
 
 static void __intel_pmu_lbr_save(void *ctx)
@@ -992,7 +992,7 @@ static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
 		intel_pmu_store_lbr(cpuc, NULL);
 		return;
 	}
-	copy_independent_supervisor_to_kernel(&xsave->xsave, XFEATURE_MASK_LBR);
+	xsaves(&xsave->xsave, XFEATURE_MASK_LBR);
 
 	intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
 }
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index a55bd5c..7de2384 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -104,8 +104,9 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
 int xfeature_size(int xfeature_nr);
 int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
 int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
-void copy_independent_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
-void copy_kernel_to_independent_supervisor(struct xregs_state *xstate, u64 mask);
+
+void xsaves(struct xregs_state *xsave, u64 mask);
+void xrstors(struct xregs_state *xsave, u64 mask);
 
 enum xstate_copy_mode {
 	XSTATE_COPY_FP,
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 27246a8..735d44c 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1162,76 +1162,74 @@ int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave,
 	return copy_uabi_to_xstate(xsave, NULL, ubuf);
 }
 
+static bool validate_xsaves_xrstors(u64 mask)
+{
+	u64 xchk;
+
+	if (WARN_ON_FPU(!cpu_feature_enabled(X86_FEATURE_XSAVES)))
+		return false;
+	/*
+	 * Validate that this is either a task->fpstate related component
+	 * subset or an independent one.
+	 */
+	if (mask & xfeatures_mask_independent())
+		xchk = ~xfeatures_mask_independent();
+	else
+		xchk = ~xfeatures_mask_all;
+
+	if (WARN_ON_ONCE(!mask || mask & xchk))
+		return false;
+
+	return true;
+}
+
 /**
- * copy_independent_supervisor_to_kernel() - Save independent supervisor states to
- *                                           an xsave area
- * @xstate: A pointer to an xsave area
- * @mask: Represent the independent supervisor features saved into the xsave area
+ * xsaves - Save selected components to a kernel xstate buffer
+ * @xstate:	Pointer to the buffer
+ * @mask:	Feature mask to select the components to save
  *
- * Only the independent supervisor states sets in the mask are saved into the xsave
- * area (See the comment in XFEATURE_MASK_INDEPENDENT for the details of independent
- * supervisor feature). Besides the independent supervisor states, the legacy
- * region and XSAVE header are also saved into the xsave area. The supervisor
- * features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
- * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not saved.
+ * The @xstate buffer must be 64 byte aligned and correctly initialized as
+ * XSAVES does not write the full xstate header. Before first use the
+ * buffer should be zeroed otherwise a consecutive XRSTORS from that buffer
+ * can #GP.
  *
- * The xsave area must be 64-bytes aligned.
+ * The feature mask must either be a subset of the independent features or
+ * a subset of the task->fpstate related features.
  */
-void copy_independent_supervisor_to_kernel(struct xregs_state *xstate, u64 mask)
+void xsaves(struct xregs_state *xstate, u64 mask)
 {
-	u64 independent_mask = xfeatures_mask_independent() & mask;
-	u32 lmask, hmask;
 	int err;
 
-	if (WARN_ON_FPU(!boot_cpu_has(X86_FEATURE_XSAVES)))
+	if (!validate_xsaves_xrstors(mask))
 		return;
 
-	if (WARN_ON_FPU(!independent_mask))
-		return;
-
-	lmask = independent_mask;
-	hmask = independent_mask >> 32;
-
-	XSTATE_OP(XSAVES, xstate, lmask, hmask, err);
-
-	/* Should never fault when copying to a kernel buffer */
-	WARN_ON_FPU(err);
+	XSTATE_OP(XSAVES, xstate, (u32)mask, (u32)(mask >> 32), err);
+	WARN_ON_ONCE(err);
 }
 
 /**
- * copy_kernel_to_independent_supervisor() - Restore independent supervisor states from
- *                                           an xsave area
- * @xstate: A pointer to an xsave area
- * @mask: Represent the independent supervisor features restored from the xsave area
+ * xrstors - Restore selected components from a kernel xstate buffer
+ * @xstate:	Pointer to the buffer
+ * @mask:	Feature mask to select the components to restore
+ *
+ * The @xstate buffer must be 64 byte aligned and correctly initialized
+ * otherwise XRSTORS from that buffer can #GP.
  *
- * Only the independent supervisor states sets in the mask are restored from the
- * xsave area (See the comment in XFEATURE_MASK_INDEPENDENT for the details of
- * independent supervisor feature). Besides the independent supervisor states, the
- * legacy region and XSAVE header are also restored from the xsave area. The
- * supervisor features in the XFEATURE_MASK_SUPERVISOR_SUPPORTED and
- * XFEATURE_MASK_SUPERVISOR_UNSUPPORTED are not restored.
+ * Proper usage is to restore the state which was saved with
+ * xsaves() into @xstate.
  *
- * The xsave area must be 64-bytes aligned.
+ * The feature mask must either be a subset of the independent features or
+ * a subset of the task->fpstate related features.
  */
-void copy_kernel_to_independent_supervisor(struct xregs_state *xstate, u64 mask)
+void xrstors(struct xregs_state *xstate, u64 mask)
 {
-	u64 independent_mask = xfeatures_mask_independent() & mask;
-	u32 lmask, hmask;
 	int err;
 
-	if (WARN_ON_FPU(!boot_cpu_has(X86_FEATURE_XSAVES)))
+	if (!validate_xsaves_xrstors(mask))
 		return;
 
-	if (WARN_ON_FPU(!independent_mask))
-		return;
-
-	lmask = independent_mask;
-	hmask = independent_mask >> 32;
-
-	XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
-
-	/* Should never fault when copying from a kernel buffer */
-	WARN_ON_FPU(err);
+	XSTATE_OP(XRSTORS, xstate, (u32)mask, (u32)(mask >> 32), err);
+	WARN_ON_ONCE(err);
 }
 
 #ifdef CONFIG_PROC_PID_ARCH_STATUS
