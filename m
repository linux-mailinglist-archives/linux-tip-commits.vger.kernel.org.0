Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018BD43B6C6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Oct 2021 18:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbhJZQTG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Oct 2021 12:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbhJZQTE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041EAC061348;
        Tue, 26 Oct 2021 09:16:40 -0700 (PDT)
Date:   Tue, 26 Oct 2021 16:16:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635264998;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2IFospdMQwT3hk87Fl43Kc/Kz6SQXL4EM/nIFoTxDUw=;
        b=NNsGnU4a/VFmPIauypVPCu5DWiFNJH4SoYvrufpzYpGrG4E+hSYrKwDgWHyuVgx5UCd3mk
        0h87O+38j3qd0hXDnIOr+cNT/MPF2mNfDn5YfQKZg2JPbN+MeYCNUWamuahLyCDFfDjeNr
        r+LQMAwa/0CvLPLW1wuMDIm3VyhI6JLtZR+DWUC2UOtfS1aOaZ8NA4g3EeaHi+f9XKqIeP
        sCg3kqUYfUKZ41IXWrw3SzHT4aQSn/x9eVCjwTemHVuYEScnX8JAz1r3ueqndmcHW7T1DY
        ZF50YVUcbnmMsVHPtba65y1ZcG0IUZOWP2qRoXf4F1a7eI6nloT0S5lp6CQkrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635264998;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2IFospdMQwT3hk87Fl43Kc/Kz6SQXL4EM/nIFoTxDUw=;
        b=XjOE/X5sBewjJzbGPhTeoGSoKLyZZNIBMRNWQ8UtGIKvudnfiDYqFacZv60vMAzdN3RHZP
        Hg5PGLImKFhY1bCQ==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/xstate: Add XFD #NM handler
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021225527.10184-18-chang.seok.bae@intel.com>
References: <20211021225527.10184-18-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <163526499778.626.15421277580798736019.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     783e87b404956f8958657aed8a6a72aa98d5b7e1
Gitweb:        https://git.kernel.org/tip/783e87b404956f8958657aed8a6a72aa98d5b7e1
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 21 Oct 2021 15:55:21 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 Oct 2021 10:53:02 +02:00

x86/fpu/xstate: Add XFD #NM handler

If the XFD MSR has feature bits set then #NM will be raised when user space
attempts to use an instruction related to one of these features.

When the task has no permissions to use that feature, raise SIGILL, which
is the same behavior as #UD.

If the task has permissions, calculate the new buffer size for the extended
feature set and allocate a larger fpstate. In the unlikely case that
vzalloc() fails, SIGSEGV is raised.

The allocation function will be added in the next step. Provide a stub
which fails for now.

  [ tglx: Updated serialization ]

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211021225527.10184-18-chang.seok.bae@intel.com
---
 arch/x86/include/asm/fpu/xstate.h |  2 +-
 arch/x86/kernel/fpu/xstate.c      | 47 ++++++++++++++++++++++++++++++-
 arch/x86/kernel/traps.c           | 38 ++++++++++++++++++++++++-
 3 files changed, 87 insertions(+)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index cf28546..b7b145c 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -99,6 +99,8 @@ int xfeature_size(int xfeature_nr);
 void xsaves(struct xregs_state *xsave, u64 mask);
 void xrstors(struct xregs_state *xsave, u64 mask);
 
+int xfd_enable_feature(u64 xfd_err);
+
 #ifdef CONFIG_X86_64
 DECLARE_STATIC_KEY_FALSE(__fpu_state_size_dynamic);
 #endif
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 77739b0..3d38558 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1464,6 +1464,53 @@ static int xstate_request_perm(unsigned long idx)
 	spin_unlock_irq(&current->sighand->siglock);
 	return ret;
 }
+
+/* Place holder for now */
+static int fpstate_realloc(u64 xfeatures, unsigned int ksize,
+			   unsigned int usize)
+{
+	return -ENOMEM;
+}
+
+int xfd_enable_feature(u64 xfd_err)
+{
+	u64 xfd_event = xfd_err & XFEATURE_MASK_USER_DYNAMIC;
+	unsigned int ksize, usize;
+	struct fpu *fpu;
+
+	if (!xfd_event) {
+		pr_err_once("XFD: Invalid xfd error: %016llx\n", xfd_err);
+		return 0;
+	}
+
+	/* Protect against concurrent modifications */
+	spin_lock_irq(&current->sighand->siglock);
+
+	/* If not permitted let it die */
+	if ((xstate_get_host_group_perm() & xfd_event) != xfd_event) {
+		spin_unlock_irq(&current->sighand->siglock);
+		return -EPERM;
+	}
+
+	fpu = &current->group_leader->thread.fpu;
+	ksize = fpu->perm.__state_size;
+	usize = fpu->perm.__user_state_size;
+	/*
+	 * The feature is permitted. State size is sufficient.  Dropping
+	 * the lock is safe here even if more features are added from
+	 * another task, the retrieved buffer sizes are valid for the
+	 * currently requested feature(s).
+	 */
+	spin_unlock_irq(&current->sighand->siglock);
+
+	/*
+	 * Try to allocate a new fpstate. If that fails there is no way
+	 * out.
+	 */
+	if (fpstate_realloc(xfd_event, ksize, usize))
+		return -EFAULT;
+	return 0;
+}
 #else /* CONFIG_X86_64 */
 static inline int xstate_request_perm(unsigned long idx)
 {
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index bae7582..6ca1454 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1108,10 +1108,48 @@ DEFINE_IDTENTRY(exc_spurious_interrupt_bug)
 	 */
 }
 
+static bool handle_xfd_event(struct pt_regs *regs)
+{
+	u64 xfd_err;
+	int err;
+
+	if (!IS_ENABLED(CONFIG_X86_64) || !cpu_feature_enabled(X86_FEATURE_XFD))
+		return false;
+
+	rdmsrl(MSR_IA32_XFD_ERR, xfd_err);
+	if (!xfd_err)
+		return false;
+
+	wrmsrl(MSR_IA32_XFD_ERR, 0);
+
+	/* Die if that happens in kernel space */
+	if (WARN_ON(!user_mode(regs)))
+		return false;
+
+	local_irq_enable();
+
+	err = xfd_enable_feature(xfd_err);
+
+	switch (err) {
+	case -EPERM:
+		force_sig_fault(SIGILL, ILL_ILLOPC, error_get_trap_addr(regs));
+		break;
+	case -EFAULT:
+		force_sig(SIGSEGV);
+		break;
+	}
+
+	local_irq_disable();
+	return true;
+}
+
 DEFINE_IDTENTRY(exc_device_not_available)
 {
 	unsigned long cr0 = read_cr0();
 
+	if (handle_xfd_event(regs))
+		return;
+
 #ifdef CONFIG_MATH_EMULATION
 	if (!boot_cpu_has(X86_FEATURE_FPU) && (cr0 & X86_CR0_EM)) {
 		struct math_emu_info info = { };
