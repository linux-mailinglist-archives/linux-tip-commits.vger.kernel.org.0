Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9BA43B6C5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Oct 2021 18:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbhJZQTF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Oct 2021 12:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237328AbhJZQTD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BFCC061745;
        Tue, 26 Oct 2021 09:16:39 -0700 (PDT)
Date:   Tue, 26 Oct 2021 16:16:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635264998;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ql270qTxrzyG3AZEzepMbfMO5ffbMneVdAnwa/MQLc4=;
        b=Y3jg6yNfvAt29/fQWppCzG2Dw5YR34FqU+so9ZzMhdAe8S8b1RCbZjDnotIIiT66AUg5OI
        qRV+anqipAnJqBIfuq9MjOtOq/6C8pOsGeKGAtRPcLO2z30JpIlqz1hJs5Dlm+vLcRLQoY
        moS7+Uz8/sfgi+GqTD3PO+t4AUabhFRaz+TKiN1lAB5jeYta4X61U/wAP0RyffU/PgeUZa
        EZO/gR3q44iTkRru77czEuF+rrJnb3hiliUbjNKF58AbUntx35GNzAQcLO3uEMpjdbw3NN
        PEt9f/AMXNRajLLbjawEK3hVpoBQKWEUEK/pE0zvZlT4pes0L3Nz9E65vhnk8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635264998;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ql270qTxrzyG3AZEzepMbfMO5ffbMneVdAnwa/MQLc4=;
        b=PSE3jAjvu+lsldzV8p4dx0mFm7tYSR/teJ6j3d525E9KwoMHsfe0KwbBoNmIn6aJrn3VJY
        tdImkUWzSmQ8e+CQ==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Add fpstate_realloc()/free()
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021225527.10184-19-chang.seok.bae@intel.com>
References: <20211021225527.10184-19-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <163526499714.626.7471812823908594787.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     500afbf645a040a39e1af0dba2fdf6ebf224bd47
Gitweb:        https://git.kernel.org/tip/500afbf645a040a39e1af0dba2fdf6ebf224bd47
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 21 Oct 2021 15:55:22 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 Oct 2021 10:53:02 +02:00

x86/fpu/xstate: Add fpstate_realloc()/free()

The fpstate embedded in struct fpu is the default state for storing the FPU
registers. It's sized so that the default supported features can be stored.
For dynamically enabled features the register buffer is too small.

The #NM handler detects first use of a feature which is disabled in the
XFD MSR. After handling permission checks it recalculates the size for
kernel space and user space state and invokes fpstate_realloc() which
tries to reallocate fpstate and install it.

Provide the allocator function which checks whether the current buffer size
is sufficient and if not allocates one. If allocation is successful the new
fpstate is initialized with the new features and sizes and the now enabled
features is removed from the task's XFD mask.

realloc_fpstate() uses vzalloc(). If use of this mechanism grows to
re-allocate buffers larger than 64KB, a more sophisticated allocation
scheme that includes purpose-built reclaim capability might be justified.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211021225527.10184-19-chang.seok.bae@intel.com
---
 arch/x86/include/asm/fpu/api.h |  7 ++-
 arch/x86/kernel/fpu/xstate.c   | 97 ++++++++++++++++++++++++++++++---
 arch/x86/kernel/process.c      | 10 +++-
 3 files changed, 106 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 798ae92..b7267b9 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -130,6 +130,13 @@ static inline void fpstate_init_soft(struct swregs_state *soft) {}
 /* State tracking */
 DECLARE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
 
+/* Process cleanup */
+#ifdef CONFIG_X86_64
+extern void fpstate_free(struct fpu *fpu);
+#else
+static inline void fpstate_free(struct fpu *fpu) { }
+#endif
+
 /* fpstate-related functions which are exported to KVM */
 extern void fpstate_clear_xstate_component(struct fpstate *fps, unsigned int xfeature);
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 3d38558..db0bfc2 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -12,6 +12,7 @@
 #include <linux/pkeys.h>
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
+#include <linux/vmalloc.h>
 
 #include <asm/fpu/api.h>
 #include <asm/fpu/regset.h>
@@ -22,6 +23,7 @@
 #include <asm/prctl.h>
 #include <asm/elf.h>
 
+#include "context.h"
 #include "internal.h"
 #include "legacy.h"
 #include "xstate.h"
@@ -1371,6 +1373,91 @@ void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor)
 }
 #endif /* CONFIG_X86_DEBUG_FPU */
 
+void fpstate_free(struct fpu *fpu)
+{
+	if (fpu->fpstate || fpu->fpstate != &fpu->__fpstate)
+		vfree(fpu->fpstate);
+}
+
+/**
+ * fpu_install_fpstate - Update the active fpstate in the FPU
+ *
+ * @fpu:	A struct fpu * pointer
+ * @newfps:	A struct fpstate * pointer
+ *
+ * Returns:	A null pointer if the last active fpstate is the embedded
+ *		one or the new fpstate is already installed;
+ *		otherwise, a pointer to the old fpstate which has to
+ *		be freed by the caller.
+ */
+static struct fpstate *fpu_install_fpstate(struct fpu *fpu,
+					   struct fpstate *newfps)
+{
+	struct fpstate *oldfps = fpu->fpstate;
+
+	if (fpu->fpstate == newfps)
+		return NULL;
+
+	fpu->fpstate = newfps;
+	return oldfps != &fpu->__fpstate ? oldfps : NULL;
+}
+
+/**
+ * fpstate_realloc - Reallocate struct fpstate for the requested new features
+ *
+ * @xfeatures:	A bitmap of xstate features which extend the enabled features
+ *		of that task
+ * @ksize:	The required size for the kernel buffer
+ * @usize:	The required size for user space buffers
+ *
+ * Note vs. vmalloc(): If the task with a vzalloc()-allocated buffer
+ * terminates quickly, vfree()-induced IPIs may be a concern, but tasks
+ * with large states are likely to live longer.
+ *
+ * Returns: 0 on success, -ENOMEM on allocation error.
+ */
+static int fpstate_realloc(u64 xfeatures, unsigned int ksize,
+			   unsigned int usize)
+{
+	struct fpu *fpu = &current->thread.fpu;
+	struct fpstate *curfps, *newfps = NULL;
+	unsigned int fpsize;
+
+	curfps = fpu->fpstate;
+	fpsize = ksize + ALIGN(offsetof(struct fpstate, regs), 64);
+
+	newfps = vzalloc(fpsize);
+	if (!newfps)
+		return -ENOMEM;
+	newfps->size = ksize;
+	newfps->user_size = usize;
+	newfps->is_valloc = true;
+
+	fpregs_lock();
+	/*
+	 * Ensure that the current state is in the registers before
+	 * swapping fpstate as that might invalidate it due to layout
+	 * changes.
+	 */
+	if (test_thread_flag(TIF_NEED_FPU_LOAD))
+		fpregs_restore_userregs();
+
+	newfps->xfeatures = curfps->xfeatures | xfeatures;
+	newfps->user_xfeatures = curfps->user_xfeatures | xfeatures;
+	newfps->xfd = curfps->xfd & ~xfeatures;
+
+	curfps = fpu_install_fpstate(fpu, newfps);
+
+	/* Do the final updates within the locked region */
+	xstate_init_xcomp_bv(&newfps->regs.xsave, newfps->xfeatures);
+	xfd_update_state(newfps);
+
+	fpregs_unlock();
+
+	vfree(curfps);
+	return 0;
+}
+
 static int validate_sigaltstack(unsigned int usize)
 {
 	struct task_struct *thread, *leader = current->group_leader;
@@ -1393,7 +1480,8 @@ static int __xstate_request_perm(u64 permitted, u64 requested)
 	/*
 	 * This deliberately does not exclude !XSAVES as we still might
 	 * decide to optionally context switch XCR0 or talk the silicon
-	 * vendors into extending XFD for the pre AMX states.
+	 * vendors into extending XFD for the pre AMX states, especially
+	 * AVX512.
 	 */
 	bool compacted = cpu_feature_enabled(X86_FEATURE_XSAVES);
 	struct fpu *fpu = &current->group_leader->thread.fpu;
@@ -1465,13 +1553,6 @@ static int xstate_request_perm(unsigned long idx)
 	return ret;
 }
 
-/* Place holder for now */
-static int fpstate_realloc(u64 xfeatures, unsigned int ksize,
-			   unsigned int usize)
-{
-	return -ENOMEM;
-}
-
 int xfd_enable_feature(u64 xfd_err)
 {
 	u64 xfd_event = xfd_err & XFEATURE_MASK_USER_DYNAMIC;
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 99025e3..f3f2517 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -32,6 +32,7 @@
 #include <asm/mwait.h>
 #include <asm/fpu/api.h>
 #include <asm/fpu/sched.h>
+#include <asm/fpu/xstate.h>
 #include <asm/debugreg.h>
 #include <asm/nmi.h>
 #include <asm/tlbflush.h>
@@ -90,9 +91,18 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 #endif
 	/* Drop the copied pointer to current's fpstate */
 	dst->thread.fpu.fpstate = NULL;
+
 	return 0;
 }
 
+#ifdef CONFIG_X86_64
+void arch_release_task_struct(struct task_struct *tsk)
+{
+	if (fpu_state_size_dynamic())
+		fpstate_free(&tsk->thread.fpu);
+}
+#endif
+
 /*
  * Free thread data structures etc..
  */
