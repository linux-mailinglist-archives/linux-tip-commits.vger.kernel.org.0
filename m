Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7631A43B6D0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Oct 2021 18:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbhJZQTN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Oct 2021 12:19:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34626 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237363AbhJZQTJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:09 -0400
Date:   Tue, 26 Oct 2021 16:16:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635265004;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Aq9yiPirZvfdhWacE5kgXJs/cIHcFn69W3i03rDDtek=;
        b=ipDy+Ra9KGDjrHjaOZAAOZvBIhiOqrmwp56sTLuvnNu3527egEtxL+PGORCBUyspl4wanP
        JXNzhN/FjngBf3+aYY7fqbyy1uKQg08jtX6Tkmq6PyMr5ABE2aHVZYJoSG2vUA3K+uW2xZ
        RYT1TXMbhbIOo/WME6weGKsZ9PEfZ7sk7big/V35oR30Wjgr54HO1ycuLmOuwBamde5TDv
        YA9FoY946oJaa9WRlNLJVmauFEzaZ8SKzZAQVOUpVBJBM1XR6GkLS8xFIGQiLCOMBFiBqZ
        C8zmMBt3CGtYa4+aWsyzQKV/FnTWdK6APaw+QyYB4yblxaipedhBtNJt8zFaVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635265004;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Aq9yiPirZvfdhWacE5kgXJs/cIHcFn69W3i03rDDtek=;
        b=/NSGAyBG8Orq9qRebMQ8dyq8OK49i/5ULAEaJH0bQBdaf40JLxo9k2K+5DfVHXR0vhdeEY
        gLw98NDTM7gXiyBg==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/signal: Prepare for variable sigframe length
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021225527.10184-10-chang.seok.bae@intel.com>
References: <20211021225527.10184-10-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <163526500343.626.4192763440474465684.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     53599b4d54b9b8dda1d537a558946869d2acbddc
Gitweb:        https://git.kernel.org/tip/53599b4d54b9b8dda1d537a558946869d2acbddc
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 21 Oct 2021 15:55:13 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 Oct 2021 10:18:09 +02:00

x86/fpu/signal: Prepare for variable sigframe length

The software reserved portion of the fxsave frame in the signal frame
is copied from structures which have been set up at boot time. With
dynamically enabled features the content of these structures is no
longer correct because the xfeatures and size can be different per task.

Calculate the software reserved portion at runtime and fill in the
xfeatures and size values from the tasks active fpstate.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211021225527.10184-10-chang.seok.bae@intel.com
---
 arch/x86/kernel/fpu/internal.h |  3 +--
 arch/x86/kernel/fpu/signal.c   | 62 +++++++++++++--------------------
 arch/x86/kernel/fpu/xstate.c   |  1 +-
 3 files changed, 26 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kernel/fpu/internal.h b/arch/x86/kernel/fpu/internal.h
index e1d8a35..dbdb31f 100644
--- a/arch/x86/kernel/fpu/internal.h
+++ b/arch/x86/kernel/fpu/internal.h
@@ -21,9 +21,6 @@ static __always_inline __pure bool use_fxsr(void)
 # define WARN_ON_FPU(x) ({ (void)(x); 0; })
 #endif
 
-/* Init functions */
-extern void fpu__init_prepare_fx_sw_frame(void);
-
 /* Used in init.c */
 extern void fpstate_init_user(struct fpstate *fpstate);
 extern void fpstate_reset(struct fpu *fpu);
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 3e42e6e..3b7f7d0 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -20,9 +20,6 @@
 #include "legacy.h"
 #include "xstate.h"
 
-static struct _fpx_sw_bytes fx_sw_reserved __ro_after_init;
-static struct _fpx_sw_bytes fx_sw_reserved_ia32 __ro_after_init;
-
 /*
  * Check for the presence of extended state information in the
  * user fpstate pointer in the sigcontext.
@@ -98,23 +95,42 @@ static inline bool save_fsave_header(struct task_struct *tsk, void __user *buf)
 	return true;
 }
 
+/*
+ * Prepare the SW reserved portion of the fxsave memory layout, indicating
+ * the presence of the extended state information in the memory layout
+ * pointed to by the fpstate pointer in the sigcontext.
+ * This is saved when ever the FP and extended state context is
+ * saved on the user stack during the signal handler delivery to the user.
+ */
+static inline void save_sw_bytes(struct _fpx_sw_bytes *sw_bytes, bool ia32_frame,
+				 struct fpstate *fpstate)
+{
+	sw_bytes->magic1 = FP_XSTATE_MAGIC1;
+	sw_bytes->extended_size = fpstate->user_size + FP_XSTATE_MAGIC2_SIZE;
+	sw_bytes->xfeatures = fpstate->user_xfeatures;
+	sw_bytes->xstate_size = fpstate->user_size;
+
+	if (ia32_frame)
+		sw_bytes->extended_size += sizeof(struct fregs_state);
+}
+
 static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
-				      unsigned int usize)
+				      struct fpstate *fpstate)
 {
 	struct xregs_state __user *x = buf;
-	struct _fpx_sw_bytes *sw_bytes;
+	struct _fpx_sw_bytes sw_bytes;
 	u32 xfeatures;
 	int err;
 
 	/* Setup the bytes not touched by the [f]xsave and reserved for SW. */
-	sw_bytes = ia32_frame ? &fx_sw_reserved_ia32 : &fx_sw_reserved;
-	err = __copy_to_user(&x->i387.sw_reserved, sw_bytes, sizeof(*sw_bytes));
+	save_sw_bytes(&sw_bytes, ia32_frame, fpstate);
+	err = __copy_to_user(&x->i387.sw_reserved, &sw_bytes, sizeof(sw_bytes));
 
 	if (!use_xsave())
 		return !err;
 
 	err |= __put_user(FP_XSTATE_MAGIC2,
-			  (__u32 __user *)(buf + usize));
+			  (__u32 __user *)(buf + fpstate->user_size));
 
 	/*
 	 * Read the xfeatures which we copied (directly from the cpu or
@@ -173,7 +189,7 @@ bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 {
 	struct task_struct *tsk = current;
 	struct fpstate *fpstate = tsk->thread.fpu.fpstate;
-	int ia32_fxstate = (buf != buf_fx);
+	bool ia32_fxstate = (buf != buf_fx);
 	int ret;
 
 	ia32_fxstate &= (IS_ENABLED(CONFIG_X86_32) ||
@@ -226,8 +242,7 @@ retry:
 	if ((ia32_fxstate || !use_fxsr()) && !save_fsave_header(tsk, buf))
 		return false;
 
-	if (use_fxsr() &&
-	    !save_xstate_epilog(buf_fx, ia32_fxstate, fpstate->user_size))
+	if (use_fxsr() && !save_xstate_epilog(buf_fx, ia32_fxstate, fpstate))
 		return false;
 
 	return true;
@@ -523,28 +538,3 @@ unsigned long __init fpu__get_fpstate_size(void)
 	return ret;
 }
 
-/*
- * Prepare the SW reserved portion of the fxsave memory layout, indicating
- * the presence of the extended state information in the memory layout
- * pointed by the fpstate pointer in the sigcontext.
- * This will be saved when ever the FP and extended state context is
- * saved on the user stack during the signal handler delivery to the user.
- */
-void __init fpu__init_prepare_fx_sw_frame(void)
-{
-	int size = fpu_user_cfg.default_size + FP_XSTATE_MAGIC2_SIZE;
-
-	fx_sw_reserved.magic1 = FP_XSTATE_MAGIC1;
-	fx_sw_reserved.extended_size = size;
-	fx_sw_reserved.xfeatures = fpu_user_cfg.default_features;
-	fx_sw_reserved.xstate_size = fpu_user_cfg.default_size;
-
-	if (IS_ENABLED(CONFIG_IA32_EMULATION) ||
-	    IS_ENABLED(CONFIG_X86_32)) {
-		int fsave_header_size = sizeof(struct fregs_state);
-
-		fx_sw_reserved_ia32 = fx_sw_reserved;
-		fx_sw_reserved_ia32.extended_size = size + fsave_header_size;
-	}
-}
-
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c837cff..bf42ee2 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -830,7 +830,6 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 	update_regset_xstate_info(fpu_user_cfg.max_size,
 				  fpu_user_cfg.max_features);
 
-	fpu__init_prepare_fx_sw_frame();
 	setup_init_fpu_buf();
 	setup_xstate_comp_offsets();
 	setup_supervisor_only_offsets();
