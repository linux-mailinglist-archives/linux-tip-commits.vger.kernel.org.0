Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103F93B2321
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhFWWMU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40112 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhFWWLk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:40 -0400
Date:   Wed, 23 Jun 2021 22:09:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486160;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=id+gkzu/blgH7xhs8qzViq/kLli0f05Ljly60CG6e6Y=;
        b=OQFmCff77PU1NpQHZ6b0hG4jJligqnRWjLPWVjNTN7+JdBjxZ8pQi8s8wGKXjzrJf2CFqe
        87keHEL0Um161BQzUdb8QfjhrWrfbX2QyEDfrqY81VATUZwqXVU4UX0pdF6WxfuBPv/F5j
        URSsXA63xFmDnVwx8T2osxgph5uUyZlPVu2H6rsUh/sI/whG5Vx6xMQ8WBrMdywnVZh21b
        XLpOlXuRIWCICAjqyZT0y/V58IpJNrqCHbcS3W9pEVok7kaRmP429M91NVWZL3RqhO5v/c
        TCMpghWBlq7FyNJv528dJtZpWkPzx864R0vrBB+J4eEGq2AgtbloN/qVnnqnIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486160;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=id+gkzu/blgH7xhs8qzViq/kLli0f05Ljly60CG6e6Y=;
        b=orbLwlDIbdkZGovb6quO4JZtPFD8AesUfxuyozHu1PtPbYrbN9AoY55cOiPTkymw6j+hFM
        uOXUvrLqn1JmKCCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Deduplicate copy_uabi_from_user/kernel_to_xstate()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210623121454.414215896@linutronix.de>
References: <20210623121454.414215896@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448615989.395.15166522720298150492.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     522e92743b35351bda1b6a9136560f833a9c2490
Gitweb:        https://git.kernel.org/tip/522e92743b35351bda1b6a9136560f833a9c2490
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:58 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 18:26:00 +02:00

x86/fpu: Deduplicate copy_uabi_from_user/kernel_to_xstate()

copy_uabi_from_user_to_xstate() and copy_uabi_from_kernel_to_xstate() are
almost identical except for the copy function.

Unify them.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20210623121454.414215896@linutronix.de
---
 arch/x86/kernel/fpu/xstate.c | 137 +++++++++++-----------------------
 1 file changed, 47 insertions(+), 90 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 57674f8..0eb42a1 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -953,23 +953,6 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 }
 #endif /* ! CONFIG_ARCH_HAS_PKEYS */
 
-/*
- * Weird legacy quirk: SSE and YMM states store information in the
- * MXCSR and MXCSR_FLAGS fields of the FP area. That means if the FP
- * area is marked as unused in the xfeatures header, we need to copy
- * MXCSR and MXCSR_FLAGS if either SSE or YMM are in use.
- */
-static inline bool xfeatures_mxcsr_quirk(u64 xfeatures)
-{
-	if (!(xfeatures & (XFEATURE_MASK_SSE|XFEATURE_MASK_YMM)))
-		return false;
-
-	if (xfeatures & XFEATURE_MASK_FP)
-		return false;
-
-	return true;
-}
-
 static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
 			 void *init_xstate, unsigned int size)
 {
@@ -1082,39 +1065,53 @@ out:
 		membuf_zero(&to, to.left);
 }
 
-static inline bool mxcsr_valid(struct xstate_header *hdr, const u32 *mxcsr)
+static int copy_from_buffer(void *dst, unsigned int offset, unsigned int size,
+			    const void *kbuf, const void __user *ubuf)
 {
-	u64 mask = XFEATURE_MASK_FP | XFEATURE_MASK_SSE | XFEATURE_MASK_YMM;
-
-	/* Only check if it is in use */
-	if (hdr->xfeatures & mask) {
-		/* Reserved bits in MXCSR must be zero. */
-		if (*mxcsr & ~mxcsr_feature_mask)
-			return false;
+	if (kbuf) {
+		memcpy(dst, kbuf + offset, size);
+	} else {
+		if (copy_from_user(dst, ubuf + offset, size))
+			return -EFAULT;
 	}
-	return true;
+	return 0;
 }
 
-/*
- * Convert from a ptrace standard-format kernel buffer to kernel XSAVE[S] format
- * and copy to the target thread. This is called from xstateregs_set().
- */
-int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
+
+static int copy_uabi_to_xstate(struct xregs_state *xsave, const void *kbuf,
+			       const void __user *ubuf)
 {
 	unsigned int offset, size;
-	int i;
 	struct xstate_header hdr;
+	u64 mask;
+	int i;
 
 	offset = offsetof(struct xregs_state, header);
-	size = sizeof(hdr);
-
-	memcpy(&hdr, kbuf + offset, size);
+	if (copy_from_buffer(&hdr, offset, sizeof(hdr), kbuf, ubuf))
+		return -EFAULT;
 
 	if (validate_user_xstate_header(&hdr))
 		return -EINVAL;
 
-	if (!mxcsr_valid(&hdr, kbuf + offsetof(struct fxregs_state, mxcsr)))
-		return -EINVAL;
+	/* Validate MXCSR when any of the related features is in use */
+	mask = XFEATURE_MASK_FP | XFEATURE_MASK_SSE | XFEATURE_MASK_YMM;
+	if (hdr.xfeatures & mask) {
+		u32 mxcsr[2];
+
+		offset = offsetof(struct fxregs_state, mxcsr);
+		if (copy_from_buffer(mxcsr, offset, sizeof(mxcsr), kbuf, ubuf))
+			return -EFAULT;
+
+		/* Reserved bits in MXCSR must be zero. */
+		if (mxcsr[0] & ~mxcsr_feature_mask)
+			return -EINVAL;
+
+		/* SSE and YMM require MXCSR even when FP is not in use. */
+		if (!(hdr.xfeatures & XFEATURE_MASK_FP)) {
+			xsave->i387.mxcsr = mxcsr[0];
+			xsave->i387.mxcsr_mask = mxcsr[1];
+		}
+	}
 
 	for (i = 0; i < XFEATURE_MAX; i++) {
 		u64 mask = ((u64)1 << i);
@@ -1125,16 +1122,11 @@ int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 			offset = xstate_offsets[i];
 			size = xstate_sizes[i];
 
-			memcpy(dst, kbuf + offset, size);
+			if (copy_from_buffer(dst, offset, size, kbuf, ubuf))
+				return -EFAULT;
 		}
 	}
 
-	if (xfeatures_mxcsr_quirk(hdr.xfeatures)) {
-		offset = offsetof(struct fxregs_state, mxcsr);
-		size = MXCSR_AND_FLAGS_SIZE;
-		memcpy(&xsave->i387.mxcsr, kbuf + offset, size);
-	}
-
 	/*
 	 * The state that came in from userspace was user-state only.
 	 * Mask all the user states out of 'xfeatures':
@@ -1150,6 +1142,16 @@ int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 }
 
 /*
+ * Convert from a ptrace standard-format kernel buffer to kernel XSAVE[S]
+ * format and copy to the target thread. This is called from
+ * xstateregs_set().
+ */
+int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
+{
+	return copy_uabi_to_xstate(xsave, kbuf, NULL);
+}
+
+/*
  * Convert from a sigreturn standard-format user-space buffer to kernel
  * XSAVE[S] format and copy to the target thread. This is called from the
  * sigreturn() and rt_sigreturn() system calls.
@@ -1157,52 +1159,7 @@ int copy_uabi_from_kernel_to_xstate(struct xregs_state *xsave, const void *kbuf)
 int copy_sigframe_from_user_to_xstate(struct xregs_state *xsave,
 				      const void __user *ubuf)
 {
-	unsigned int offset, size;
-	int i;
-	struct xstate_header hdr;
-
-	offset = offsetof(struct xregs_state, header);
-	size = sizeof(hdr);
-
-	if (copy_from_user(&hdr, ubuf + offset, size))
-		return -EFAULT;
-
-	if (validate_user_xstate_header(&hdr))
-		return -EINVAL;
-
-	for (i = 0; i < XFEATURE_MAX; i++) {
-		u64 mask = ((u64)1 << i);
-
-		if (hdr.xfeatures & mask) {
-			void *dst = __raw_xsave_addr(xsave, i);
-
-			offset = xstate_offsets[i];
-			size = xstate_sizes[i];
-
-			if (copy_from_user(dst, ubuf + offset, size))
-				return -EFAULT;
-		}
-	}
-
-	if (xfeatures_mxcsr_quirk(hdr.xfeatures)) {
-		offset = offsetof(struct fxregs_state, mxcsr);
-		size = MXCSR_AND_FLAGS_SIZE;
-		if (copy_from_user(&xsave->i387.mxcsr, ubuf + offset, size))
-			return -EFAULT;
-	}
-
-	/*
-	 * The state that came in from userspace was user-state only.
-	 * Mask all the user states out of 'xfeatures':
-	 */
-	xsave->header.xfeatures &= XFEATURE_MASK_SUPERVISOR_ALL;
-
-	/*
-	 * Add back in the features that came in from userspace:
-	 */
-	xsave->header.xfeatures |= hdr.xfeatures;
-
-	return 0;
+	return copy_uabi_to_xstate(xsave, NULL, ubuf);
 }
 
 /**
