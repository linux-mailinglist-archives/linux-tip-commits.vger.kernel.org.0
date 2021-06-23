Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225F13B2333
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhFWWMq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40212 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhFWWLy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:54 -0400
Date:   Wed, 23 Jun 2021 22:09:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486175;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LAyKcqHBP6LEme9POT35axWDPaL840y1cRNfKu6+ucs=;
        b=vSHM7YirOcJD8DUAz2jjFTiZjgAB3IcRNn+Dx97x6gWKRXjBvS3Yxw01L5BUEUOx7c6XFx
        65y5JEQ0OC/2TOayB/KkoDZpK7Ex5zArTJa0fmjqOAzmY8VscD4F97QhzGIN23MiBijvKL
        KyHgu0qF3zIl1z7Pb4XAZbQqgqkCvu7BvoJVZ9psBlg8q10Kx5Itt3U18mJPXuUzzoFnyY
        7eIslbGykPAr6WtTYDm5B++TNO2jouA1QEY5fTYe6EIrxvPhrJOasGPiauJkHRrHM8fW44
        uLBDO7CYe0vOMgS8IZ1uS308vQ3JgA6AEj7/SsdNh61IKWhIh24AjgT3QdM1yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486175;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LAyKcqHBP6LEme9POT35axWDPaL840y1cRNfKu6+ucs=;
        b=1mn85trBMegew5HOovQTBVR1+gClJ2XOBxLE52MbzjLDR+WahxJYMbX6+IpsH/mqf0XS6O
        NTMA/pgK4YxGMwAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Make copy_xstate_to_kernel() usable for
 [x]fpregs_get()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121452.805327286@linutronix.de>
References: <20210623121452.805327286@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448617450.395.13871402469663573956.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     eb6f51723f03c9a1c098ed196a31a03e626b9fb6
Gitweb:        https://git.kernel.org/tip/eb6f51723f03c9a1c098ed196a31a03e626b9fb6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:42 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 17:49:47 +02:00

x86/fpu: Make copy_xstate_to_kernel() usable for [x]fpregs_get()

When xsave with init state optimization is used then a component's state
in the task's xsave buffer can be stale when the corresponding feature bit
is not set.

fpregs_get() and xfpregs_get() invoke fpstate_sanitize_xstate() to update
the task's xsave buffer before retrieving the FX or FP state. That's just
duplicated code as copy_xstate_to_kernel() already handles this correctly.

Add a copy mode argument to the function which allows to restrict the state
copy to the FP and SSE features.

Also rename the function to copy_xstate_to_uabi_buf() so the name reflects
what it is doing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121452.805327286@linutronix.de
---
 arch/x86/include/asm/fpu/xstate.h | 12 +++++++--
 arch/x86/kernel/fpu/regset.c      |  2 +-
 arch/x86/kernel/fpu/xstate.c      | 42 ++++++++++++++++++++++--------
 3 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 1bb2d16..732ae79 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -103,12 +103,20 @@ extern void __init update_regset_xstate_info(unsigned int size,
 void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
 int using_compacted_format(void);
 int xfeature_size(int xfeature_nr);
-struct membuf;
-void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave);
 int copy_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf);
 int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf);
 void copy_supervisor_to_kernel(struct xregs_state *xsave);
 void copy_dynamic_supervisor_to_kernel(struct xregs_state *xstate, u64 mask);
 void copy_kernel_to_dynamic_supervisor(struct xregs_state *xstate, u64 mask);
 
+enum xstate_copy_mode {
+	XSTATE_COPY_FP,
+	XSTATE_COPY_FX,
+	XSTATE_COPY_XSAVE,
+};
+
+struct membuf;
+void copy_xstate_to_uabi_buf(struct membuf to, struct xregs_state *xsave,
+			     enum xstate_copy_mode mode);
+
 #endif
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 7041b14..783f84d 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -93,7 +93,7 @@ int xstateregs_get(struct task_struct *target, const struct user_regset *regset,
 
 	fpu__prepare_read(fpu);
 
-	copy_xstate_to_kernel(to, &fpu->state.xsave);
+	copy_xstate_to_uabi_buf(to, &fpu->state.xsave, XSTATE_COPY_XSAVE);
 	return 0;
 }
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 4203247..8d023a2 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1068,14 +1068,20 @@ static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
 	membuf_write(to, from_xstate ? xstate : init_xstate, size);
 }
 
-/*
- * Convert from kernel XSAVE or XSAVES compacted format to UABI
- * non-compacted format and copy to a kernel-space ptrace buffer.
+/**
+ * copy_xstate_to_uabi_buf - Copy kernel saved xstate to a UABI buffer
+ * @to:		membuf descriptor
+ * @xsave:	The kernel xstate buffer to copy from
+ * @copy_mode:	The requested copy mode
+ *
+ * Converts from kernel XSAVE or XSAVES compacted format to UABI conforming
+ * format, i.e. from the kernel internal hardware dependent storage format
+ * to the requested @mode. UABI XSTATE is always uncompacted!
  *
- * It supports partial copy but pos always starts from zero. This is called
- * from xstateregs_get() and there we check the CPU has XSAVE.
+ * It supports partial copy but @to.pos always starts from zero.
  */
-void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave)
+void copy_xstate_to_uabi_buf(struct membuf to, struct xregs_state *xsave,
+			     enum xstate_copy_mode copy_mode)
 {
 	const unsigned int off_mxcsr = offsetof(struct fxregs_state, mxcsr);
 	struct xregs_state *xinit = &init_fpstate.xsave;
@@ -1083,12 +1089,22 @@ void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave)
 	unsigned int zerofrom;
 	int i;
 
-	/*
-	 * The destination is a ptrace buffer; we put in only user xstates:
-	 */
-	memset(&header, 0, sizeof(header));
 	header.xfeatures = xsave->header.xfeatures;
-	header.xfeatures &= xfeatures_mask_user();
+
+	/* Mask out the feature bits depending on copy mode */
+	switch (copy_mode) {
+	case XSTATE_COPY_FP:
+		header.xfeatures &= XFEATURE_MASK_FP;
+		break;
+
+	case XSTATE_COPY_FX:
+		header.xfeatures &= XFEATURE_MASK_FP | XFEATURE_MASK_SSE;
+		break;
+
+	case XSTATE_COPY_XSAVE:
+		header.xfeatures &= xfeatures_mask_user();
+		break;
+	}
 
 	/* Copy FP state up to MXCSR */
 	copy_feature(header.xfeatures & XFEATURE_MASK_FP, &to, &xsave->i387,
@@ -1109,6 +1125,9 @@ void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave)
 		     &to, &xsave->i387.xmm_space, &xinit->i387.xmm_space,
 		     sizeof(xsave->i387.xmm_space));
 
+	if (copy_mode != XSTATE_COPY_XSAVE)
+		goto out;
+
 	/* Zero the padding area */
 	membuf_zero(&to, sizeof(xsave->i387.padding));
 
@@ -1150,6 +1169,7 @@ void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave)
 		zerofrom = xstate_offsets[i] + xstate_sizes[i];
 	}
 
+out:
 	if (to.left)
 		membuf_zero(&to, to.left);
 }
