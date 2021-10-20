Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55374434C5B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhJTNqu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:46:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52930 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhJTNqr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:46:47 -0400
Date:   Wed, 20 Oct 2021 13:44:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737473;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T3zZiY8ds3SjclPpf4ZF1jd3fP8FDAOhENCw1fcLOvI=;
        b=PiAXRy96L1NCVMfgkk7XzAAsBgzQgXTIH3LnVIS0NYeH+7c00/RT4vFRBOWJ0Z/QUaiRxP
        eZS8fysMG/NzbGef3J8XOkFNP/o5cxuJZTeQxYQtEdth1K0Qmb0HfUHlmWueHxbi9xdCwa
        Z+7PGSKp3iViiSqkbJRtCvTeT966tgO/Ul+snzgJvRgidOK+eyhs2Xy3ScxmwEUrQdNiIl
        TtZsXRxjzpPOWrA29ztGBcnqrVsotjr21PBU+Lss6JMVN0OSaV9an8GxqF2zkr0SQh7cmb
        ekR54FtX6yTQHhr6YjaRlQdzv+nT+QUeHu1ppawUPDtvMGe2Odp1u6QzRA1jsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737473;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T3zZiY8ds3SjclPpf4ZF1jd3fP8FDAOhENCw1fcLOvI=;
        b=jScVl0zSe9un3B5BeiVMSaK+BgF8/qqks/JKHzLwqW37ULIREIWwEfhz1nJHyw1Wpz8jNr
        UDfWhTErcHNCNLAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Move fpregs_restore_userregs() to core
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011539.686806639@linutronix.de>
References: <20211015011539.686806639@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473747212.25758.16427292081904612917.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     9848fb96839bfd6ad4c00748842ccfd5bd3b0346
Gitweb:        https://git.kernel.org/tip/9848fb96839bfd6ad4c00748842ccfd5bd3b0346
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:16:30 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:28 +02:00

x86/fpu: Move fpregs_restore_userregs() to core

Only used internally in the FPU core code.

While at it, convert to the percpu accessors which verify preemption is
disabled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011539.686806639@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 83 +---------------------------
 arch/x86/kernel/fpu/context.h       | 85 ++++++++++++++++++++++++++++-
 arch/x86/kernel/fpu/core.c          |  1 +-
 arch/x86/kernel/fpu/regset.c        |  1 +-
 arch/x86/kernel/fpu/signal.c        |  1 +-
 5 files changed, 88 insertions(+), 83 deletions(-)
 create mode 100644 arch/x86/kernel/fpu/context.h

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index f8413a5..74b7cc3 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -55,89 +55,6 @@ extern void restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask);
 
 extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
 
-/*
- * FPU context switch related helper methods:
- */
-
 DECLARE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
 
-/*
- * The in-register FPU state for an FPU context on a CPU is assumed to be
- * valid if the fpu->last_cpu matches the CPU, and the fpu_fpregs_owner_ctx
- * matches the FPU.
- *
- * If the FPU register state is valid, the kernel can skip restoring the
- * FPU state from memory.
- *
- * Any code that clobbers the FPU registers or updates the in-memory
- * FPU state for a task MUST let the rest of the kernel know that the
- * FPU registers are no longer valid for this task.
- *
- * Either one of these invalidation functions is enough. Invalidate
- * a resource you control: CPU if using the CPU for something else
- * (with preemption disabled), FPU for the current task, or a task that
- * is prevented from running by the current task.
- */
-static inline void __cpu_invalidate_fpregs_state(void)
-{
-	__this_cpu_write(fpu_fpregs_owner_ctx, NULL);
-}
-
-static inline void __fpu_invalidate_fpregs_state(struct fpu *fpu)
-{
-	fpu->last_cpu = -1;
-}
-
-static inline int fpregs_state_valid(struct fpu *fpu, unsigned int cpu)
-{
-	return fpu == this_cpu_read(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
-}
-
-/*
- * These generally need preemption protection to work,
- * do try to avoid using these on their own:
- */
-static inline void fpregs_deactivate(struct fpu *fpu)
-{
-	this_cpu_write(fpu_fpregs_owner_ctx, NULL);
-	trace_x86_fpu_regs_deactivated(fpu);
-}
-
-static inline void fpregs_activate(struct fpu *fpu)
-{
-	this_cpu_write(fpu_fpregs_owner_ctx, fpu);
-	trace_x86_fpu_regs_activated(fpu);
-}
-
-/* Internal helper for switch_fpu_return() and signal frame setup */
-static inline void fpregs_restore_userregs(void)
-{
-	struct fpu *fpu = &current->thread.fpu;
-	int cpu = smp_processor_id();
-
-	if (WARN_ON_ONCE(current->flags & PF_KTHREAD))
-		return;
-
-	if (!fpregs_state_valid(fpu, cpu)) {
-		u64 mask;
-
-		/*
-		 * This restores _all_ xstate which has not been
-		 * established yet.
-		 *
-		 * If PKRU is enabled, then the PKRU value is already
-		 * correct because it was either set in switch_to() or in
-		 * flush_thread(). So it is excluded because it might be
-		 * not up to date in current->thread.fpu.xsave state.
-		 */
-		mask = xfeatures_mask_restore_user() |
-			xfeatures_mask_supervisor();
-		restore_fpregs_from_fpstate(&fpu->state, mask);
-
-		fpregs_activate(fpu);
-		fpu->last_cpu = cpu;
-	}
-	clear_thread_flag(TIF_NEED_FPU_LOAD);
-}
-
 #endif /* _ASM_X86_FPU_INTERNAL_H */
diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/kernel/fpu/context.h
new file mode 100644
index 0000000..e652282
--- /dev/null
+++ b/arch/x86/kernel/fpu/context.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __X86_KERNEL_FPU_CONTEXT_H
+#define __X86_KERNEL_FPU_CONTEXT_H
+
+#include <asm/fpu/xstate.h>
+#include <asm/trace/fpu.h>
+
+/* Functions related to FPU context tracking */
+
+/*
+ * The in-register FPU state for an FPU context on a CPU is assumed to be
+ * valid if the fpu->last_cpu matches the CPU, and the fpu_fpregs_owner_ctx
+ * matches the FPU.
+ *
+ * If the FPU register state is valid, the kernel can skip restoring the
+ * FPU state from memory.
+ *
+ * Any code that clobbers the FPU registers or updates the in-memory
+ * FPU state for a task MUST let the rest of the kernel know that the
+ * FPU registers are no longer valid for this task.
+ *
+ * Either one of these invalidation functions is enough. Invalidate
+ * a resource you control: CPU if using the CPU for something else
+ * (with preemption disabled), FPU for the current task, or a task that
+ * is prevented from running by the current task.
+ */
+static inline void __cpu_invalidate_fpregs_state(void)
+{
+	__this_cpu_write(fpu_fpregs_owner_ctx, NULL);
+}
+
+static inline void __fpu_invalidate_fpregs_state(struct fpu *fpu)
+{
+	fpu->last_cpu = -1;
+}
+
+static inline int fpregs_state_valid(struct fpu *fpu, unsigned int cpu)
+{
+	return fpu == this_cpu_read(fpu_fpregs_owner_ctx) && cpu == fpu->last_cpu;
+}
+
+static inline void fpregs_deactivate(struct fpu *fpu)
+{
+	__this_cpu_write(fpu_fpregs_owner_ctx, NULL);
+	trace_x86_fpu_regs_deactivated(fpu);
+}
+
+static inline void fpregs_activate(struct fpu *fpu)
+{
+	__this_cpu_write(fpu_fpregs_owner_ctx, fpu);
+	trace_x86_fpu_regs_activated(fpu);
+}
+
+/* Internal helper for switch_fpu_return() and signal frame setup */
+static inline void fpregs_restore_userregs(void)
+{
+	struct fpu *fpu = &current->thread.fpu;
+	int cpu = smp_processor_id();
+
+	if (WARN_ON_ONCE(current->flags & PF_KTHREAD))
+		return;
+
+	if (!fpregs_state_valid(fpu, cpu)) {
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
+		restore_fpregs_from_fpstate(&fpu->state, mask);
+
+		fpregs_activate(fpu);
+		fpu->last_cpu = cpu;
+	}
+	clear_thread_flag(TIF_NEED_FPU_LOAD);
+}
+
+#endif
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index a009c82..7397288 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -17,6 +17,7 @@
 #include <linux/hardirq.h>
 #include <linux/pkeys.h>
 
+#include "context.h"
 #include "internal.h"
 #include "legacy.h"
 #include "xstate.h"
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index ccf0c59..a40150e 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -10,6 +10,7 @@
 #include <asm/fpu/regset.h>
 #include <asm/fpu/xstate.h>
 
+#include "context.h"
 #include "internal.h"
 
 /*
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index e0198b2..32dbcde 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -16,6 +16,7 @@
 #include <asm/trapnr.h>
 #include <asm/trace/fpu.h>
 
+#include "context.h"
 #include "internal.h"
 #include "legacy.h"
 #include "xstate.h"
