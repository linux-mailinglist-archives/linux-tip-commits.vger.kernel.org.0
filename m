Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFB643B6C7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Oct 2021 18:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237350AbhJZQTH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Oct 2021 12:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237317AbhJZQTE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA666C061745;
        Tue, 26 Oct 2021 09:16:40 -0700 (PDT)
Date:   Tue, 26 Oct 2021 16:16:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635264999;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hjMVMaSd1cRm5tRiZs3sfaU7kf8/hkVYfG0LzbFjdHM=;
        b=KfzPW6ofATwq7MkLf3JkXvhy291Rp0+nk+d00u5w0P5xWCnV0l7GYoyERBndbbBVwxty+y
        jS5Bq3JSoYkMWXvaDCexfKdMKClMVf7YDaPTFtLYz1YkomgIkhrjFXzgs6UZkF6nt6VOnv
        eKO1mHmz4zvBSY8aNo5G4EjMMb2qq/tYsnf7BH7Ik0Y9BPQNY5/KOknbyFzU8i9U08PqXP
        JT65N16MAZSjvwLyVMGmQGXZGTrMk24YppMub8KonezZ8KthK6VkDhD710ckdCocQdnfm6
        xSXqjvy0MYnxFIwbM/O5mGRBWfDpCvDeri/9qD0vzZOCMu0W4NAJbFeTtdi2Sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635264999;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hjMVMaSd1cRm5tRiZs3sfaU7kf8/hkVYfG0LzbFjdHM=;
        b=ovkSN3zpK3zSNd8kAs6eNOddskMYJE/Hf6ayHpD4+LwoI325FS/YquNoQZAABW/enhxWbh
        u6Z/s83dxERFPJCQ==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Update XFD state where required
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021225527.10184-17-chang.seok.bae@intel.com>
References: <20211021225527.10184-17-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <163526499843.626.4047176410968465505.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     672365477ae8afca5a1cca98c1deb733235e4525
Gitweb:        https://git.kernel.org/tip/672365477ae8afca5a1cca98c1deb733235e4525
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 21 Oct 2021 15:55:20 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 Oct 2021 10:53:02 +02:00

x86/fpu: Update XFD state where required

The IA32_XFD_MSR allows to arm #NM traps for XSTATE components which are
enabled in XCR0. The register has to be restored before the tasks XSTATE is
restored. The life time rules are the same as for FPU state.

XFD is updated on return to userspace only when the FPU state of the task
is not up to date in the registers. It's updated before the XRSTORS so
that eventually enabled dynamic features are restored as well and not
brought into init state.

Also in signal handling for restoring FPU state from user space the
correctness of the XFD state has to be ensured.

Add it to CPU initialization and resume as well.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211021225527.10184-17-chang.seok.bae@intel.com
---
 arch/x86/kernel/fpu/context.h |  2 ++
 arch/x86/kernel/fpu/core.c    | 28 +++++++++++++++++++++++++++-
 arch/x86/kernel/fpu/signal.c  |  2 ++
 arch/x86/kernel/fpu/xstate.c  | 12 ++++++++++++
 arch/x86/kernel/fpu/xstate.h  | 19 ++++++++++++++++++-
 5 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/kernel/fpu/context.h
index a06ebf3..958accf 100644
--- a/arch/x86/kernel/fpu/context.h
+++ b/arch/x86/kernel/fpu/context.h
@@ -69,6 +69,8 @@ static inline void fpregs_restore_userregs(void)
 		 * correct because it was either set in switch_to() or in
 		 * flush_thread(). So it is excluded because it might be
 		 * not up to date in current->thread.fpu.xsave state.
+		 *
+		 * XFD state is handled in restore_fpregs_from_fpstate().
 		 */
 		restore_fpregs_from_fpstate(fpu->fpstate, XFEATURE_MASK_FPSTATE);
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index b5f5b08..12ca174 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -156,6 +156,23 @@ void restore_fpregs_from_fpstate(struct fpstate *fpstate, u64 mask)
 
 	if (use_xsave()) {
 		/*
+		 * Dynamically enabled features are enabled in XCR0, but
+		 * usage requires also that the corresponding bits in XFD
+		 * are cleared.  If the bits are set then using a related
+		 * instruction will raise #NM. This allows to do the
+		 * allocation of the larger FPU buffer lazy from #NM or if
+		 * the task has no permission to kill it which would happen
+		 * via #UD if the feature is disabled in XCR0.
+		 *
+		 * XFD state is following the same life time rules as
+		 * XSTATE and to restore state correctly XFD has to be
+		 * updated before XRSTORS otherwise the component would
+		 * stay in or go into init state even if the bits are set
+		 * in fpstate::regs::xsave::xfeatures.
+		 */
+		xfd_update_state(fpstate);
+
+		/*
 		 * Restoring state always needs to modify all features
 		 * which are in @mask even if the current task cannot use
 		 * extended features.
@@ -241,8 +258,17 @@ int fpu_swap_kvm_fpstate(struct fpu_guest *guest_fpu, bool enter_guest)
 
 	cur_fps = fpu->fpstate;
 
-	if (!cur_fps->is_confidential)
+	if (!cur_fps->is_confidential) {
+		/* Includes XFD update */
 		restore_fpregs_from_fpstate(cur_fps, XFEATURE_MASK_FPSTATE);
+	} else {
+		/*
+		 * XSTATE is restored by firmware from encrypted
+		 * memory. Make sure XFD state is correct while
+		 * running with guest fpstate
+		 */
+		xfd_update_state(cur_fps);
+	}
 
 	fpregs_mark_activate();
 	fpregs_unlock();
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 16fdecd..cc977da 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -282,6 +282,8 @@ static bool restore_fpregs_from_user(void __user *buf, u64 xrestore,
 
 retry:
 	fpregs_lock();
+	/* Ensure that XFD is up to date */
+	xfd_update_state(fpu->fpstate);
 	pagefault_disable();
 	ret = __restore_fpregs_from_user(buf, fpu->fpstate->user_xfeatures,
 					 xrestore, fx_only);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 603edeb..77739b0 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -137,6 +137,15 @@ void fpu__init_cpu_xstate(void)
 	cr4_set_bits(X86_CR4_OSXSAVE);
 
 	/*
+	 * Must happen after CR4 setup and before xsetbv() to allow KVM
+	 * lazy passthrough.  Write independent of the dynamic state static
+	 * key as that does not work on the boot CPU. This also ensures
+	 * that any stale state is wiped out from XFD.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_XFD))
+		wrmsrl(MSR_IA32_XFD, init_fpstate.xfd);
+
+	/*
 	 * XCR_XFEATURE_ENABLED_MASK (aka. XCR0) sets user features
 	 * managed by XSAVE{C, OPT, S} and XRSTOR{S}.  Only XSAVE user
 	 * states can be set here.
@@ -875,6 +884,9 @@ void fpu__resume_cpu(void)
 		wrmsrl(MSR_IA32_XSS, xfeatures_mask_supervisor()  |
 				     xfeatures_mask_independent());
 	}
+
+	if (fpu_state_size_dynamic())
+		wrmsrl(MSR_IA32_XFD, current->thread.fpu.fpstate->xfd);
 }
 
 /*
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 2902424..e18210d 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -136,6 +136,22 @@ extern void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor);
 static inline void xfd_validate_state(struct fpstate *fpstate, u64 mask, bool rstor) { }
 #endif
 
+#ifdef CONFIG_X86_64
+static inline void xfd_update_state(struct fpstate *fpstate)
+{
+	if (fpu_state_size_dynamic()) {
+		u64 xfd = fpstate->xfd;
+
+		if (__this_cpu_read(xfd_state) != xfd) {
+			wrmsrl(MSR_IA32_XFD, xfd);
+			__this_cpu_write(xfd_state, xfd);
+		}
+	}
+}
+#else
+static inline void xfd_update_state(struct fpstate *fpstate) { }
+#endif
+
 /*
  * Save processor xstate to xsave area.
  *
@@ -247,7 +263,8 @@ static inline int os_xrstor_safe(struct fpstate *fpstate, u64 mask)
 	u32 hmask = mask >> 32;
 	int err;
 
-	/* Must enforce XFD update here */
+	/* Ensure that XFD is up to date */
+	xfd_update_state(fpstate);
 
 	if (cpu_feature_enabled(X86_FEATURE_XSAVES))
 		XSTATE_OP(XRSTORS, xstate, lmask, hmask, err);
