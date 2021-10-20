Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF12434C63
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhJTNrD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:47:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52976 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhJTNqw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:46:52 -0400
Date:   Wed, 20 Oct 2021 13:44:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737477;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YlEoFrVmxUYh0MQJi1kPF4ibGm9PcO2XOrqXRLSUtrQ=;
        b=CFVf7lLDH3oxD5svs7HZttm8tt1U2CASgCqh3eBcMYx4aqRIzbb/OMsDJd2OGlTDhiX7Ql
        7TFh1IMcKpsT5Kvc4DomJfEn6+xD3z6NVsuaAW8CWRmn5y8QeumbGSDYFk4UmBsZoqkSMw
        iM1y1GktBqWI15/Hg8oPKD3i4IG8UgALhtEFCCzxdcY2RRCi2hkXnlxsUVyX37qDAIA9H3
        /hEjQuHa5zS3eSZUSR95x88Gq0LGxvXo9xnenAQCyDIe4rbkZ5aHFVWSOs17OsDrOiIiBc
        B6lF2vWfOKoAp099CuCrZErdnIsc5gqZS24EI2KGPe7qd1zIpE0w/Y+68Qu6uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737477;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YlEoFrVmxUYh0MQJi1kPF4ibGm9PcO2XOrqXRLSUtrQ=;
        b=iiyQJHM8AmB9m0FkP3KCcvwJlRt7bVspmKQG0IZwseylP/ANWAbrSBRb0rdKGdJwDrErrK
        hZ/fHreKixJqW9Bg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Move context switch and exit to user inlines
 into sched.h
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211015011539.349132461@linutronix.de>
References: <20211015011539.349132461@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473747620.25758.14538975131497174451.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     63e81807c1f94e91b9d71c536112a40cd74bab85
Gitweb:        https://git.kernel.org/tip/63e81807c1f94e91b9d71c536112a40cd74bab85
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:16:20 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:27 +02:00

x86/fpu: Move context switch and exit to user inlines into sched.h

internal.h is a kitchen sink which needs to get out of the way to prepare
for the upcoming changes.

Move the context switch and exit to user inlines into a separate header,
which is all that code needs.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011539.349132461@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 60 +-------------------------
 arch/x86/include/asm/fpu/sched.h    | 68 ++++++++++++++++++++++++++++-
 arch/x86/kernel/fpu/core.c          |  1 +-
 arch/x86/kernel/process.c           |  2 +-
 arch/x86/kernel/process_32.c        |  2 +-
 arch/x86/kernel/process_64.c        |  2 +-
 6 files changed, 72 insertions(+), 63 deletions(-)
 create mode 100644 arch/x86/include/asm/fpu/sched.h

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 3ac55ba..398c87c 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -27,16 +27,11 @@
  * High level FPU state handling functions:
  */
 extern bool fpu__restore_sig(void __user *buf, int ia32_frame);
-extern void fpu__drop(struct fpu *fpu);
 extern void fpu__clear_user_states(struct fpu *fpu);
 extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
 
 extern void fpu_sync_fpstate(struct fpu *fpu);
 
-/* Clone and exit operations */
-extern int  fpu_clone(struct task_struct *dst);
-extern void fpu_flush_thread(void);
-
 /*
  * Boot time FPU initialization functions:
  */
@@ -82,7 +77,6 @@ extern void fpstate_init_soft(struct swregs_state *soft);
 #else
 static inline void fpstate_init_soft(struct swregs_state *soft) {}
 #endif
-extern void save_fpregs_to_fpstate(struct fpu *fpu);
 
 /*
  * Returns 0 on success or the trap number when the operation raises an
@@ -464,58 +458,4 @@ static inline void fpregs_restore_userregs(void)
 	clear_thread_flag(TIF_NEED_FPU_LOAD);
 }
 
-/*
- * FPU state switching for scheduling.
- *
- * This is a two-stage process:
- *
- *  - switch_fpu_prepare() saves the old state.
- *    This is done within the context of the old process.
- *
- *  - switch_fpu_finish() sets TIF_NEED_FPU_LOAD; the floating point state
- *    will get loaded on return to userspace, or when the kernel needs it.
- *
- * If TIF_NEED_FPU_LOAD is cleared then the CPU's FPU registers
- * are saved in the current thread's FPU register state.
- *
- * If TIF_NEED_FPU_LOAD is set then CPU's FPU registers may not
- * hold current()'s FPU registers. It is required to load the
- * registers before returning to userland or using the content
- * otherwise.
- *
- * The FPU context is only stored/restored for a user task and
- * PF_KTHREAD is used to distinguish between kernel and user threads.
- */
-static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
-{
-	if (static_cpu_has(X86_FEATURE_FPU) && !(current->flags & PF_KTHREAD)) {
-		save_fpregs_to_fpstate(old_fpu);
-		/*
-		 * The save operation preserved register state, so the
-		 * fpu_fpregs_owner_ctx is still @old_fpu. Store the
-		 * current CPU number in @old_fpu, so the next return
-		 * to user space can avoid the FPU register restore
-		 * when is returns on the same CPU and still owns the
-		 * context.
-		 */
-		old_fpu->last_cpu = cpu;
-
-		trace_x86_fpu_regs_deactivated(old_fpu);
-	}
-}
-
-/*
- * Misc helper functions:
- */
-
-/*
- * Delay loading of the complete FPU state until the return to userland.
- * PKRU is handled separately.
- */
-static inline void switch_fpu_finish(void)
-{
-	if (cpu_feature_enabled(X86_FEATURE_FPU))
-		set_thread_flag(TIF_NEED_FPU_LOAD);
-}
-
 #endif /* _ASM_X86_FPU_INTERNAL_H */
diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
new file mode 100644
index 0000000..cdb78d5
--- /dev/null
+++ b/arch/x86/include/asm/fpu/sched.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_FPU_SCHED_H
+#define _ASM_X86_FPU_SCHED_H
+
+#include <linux/sched.h>
+
+#include <asm/cpufeature.h>
+#include <asm/fpu/types.h>
+
+#include <asm/trace/fpu.h>
+
+extern void save_fpregs_to_fpstate(struct fpu *fpu);
+extern void fpu__drop(struct fpu *fpu);
+extern int  fpu_clone(struct task_struct *dst);
+extern void fpu_flush_thread(void);
+
+/*
+ * FPU state switching for scheduling.
+ *
+ * This is a two-stage process:
+ *
+ *  - switch_fpu_prepare() saves the old state.
+ *    This is done within the context of the old process.
+ *
+ *  - switch_fpu_finish() sets TIF_NEED_FPU_LOAD; the floating point state
+ *    will get loaded on return to userspace, or when the kernel needs it.
+ *
+ * If TIF_NEED_FPU_LOAD is cleared then the CPU's FPU registers
+ * are saved in the current thread's FPU register state.
+ *
+ * If TIF_NEED_FPU_LOAD is set then CPU's FPU registers may not
+ * hold current()'s FPU registers. It is required to load the
+ * registers before returning to userland or using the content
+ * otherwise.
+ *
+ * The FPU context is only stored/restored for a user task and
+ * PF_KTHREAD is used to distinguish between kernel and user threads.
+ */
+static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
+{
+	if (cpu_feature_enabled(X86_FEATURE_FPU) &&
+	    !(current->flags & PF_KTHREAD)) {
+		save_fpregs_to_fpstate(old_fpu);
+		/*
+		 * The save operation preserved register state, so the
+		 * fpu_fpregs_owner_ctx is still @old_fpu. Store the
+		 * current CPU number in @old_fpu, so the next return
+		 * to user space can avoid the FPU register restore
+		 * when is returns on the same CPU and still owns the
+		 * context.
+		 */
+		old_fpu->last_cpu = cpu;
+
+		trace_x86_fpu_regs_deactivated(old_fpu);
+	}
+}
+
+/*
+ * Delay loading of the complete FPU state until the return to userland.
+ * PKRU is handled separately.
+ */
+static inline void switch_fpu_finish(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_FPU))
+		set_thread_flag(TIF_NEED_FPU_LOAD);
+}
+
+#endif /* _ASM_X86_FPU_SCHED_H */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 65fc877..e6087a6 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -8,6 +8,7 @@
  */
 #include <asm/fpu/internal.h>
 #include <asm/fpu/regset.h>
+#include <asm/fpu/sched.h>
 #include <asm/fpu/signal.h>
 #include <asm/fpu/types.h>
 #include <asm/traps.h>
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index d2227c5..5cd8208 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -30,7 +30,7 @@
 #include <asm/apic.h>
 #include <linux/uaccess.h>
 #include <asm/mwait.h>
-#include <asm/fpu/internal.h>
+#include <asm/fpu/sched.h>
 #include <asm/debugreg.h>
 #include <asm/nmi.h>
 #include <asm/tlbflush.h>
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index d008e22..26edb1c 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -41,7 +41,7 @@
 
 #include <asm/ldt.h>
 #include <asm/processor.h>
-#include <asm/fpu/internal.h>
+#include <asm/fpu/sched.h>
 #include <asm/desc.h>
 
 #include <linux/err.h>
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 39f12ef..3402ede 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -42,7 +42,7 @@
 
 #include <asm/processor.h>
 #include <asm/pkru.h>
-#include <asm/fpu/internal.h>
+#include <asm/fpu/sched.h>
 #include <asm/mmu_context.h>
 #include <asm/prctl.h>
 #include <asm/desc.h>
