Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7400D3B2352
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFWWNo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:13:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39932 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhFWWMW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:12:22 -0400
Date:   Wed, 23 Jun 2021 22:09:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486188;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kJm0PJSfGBcuZwnpsc0bboCVKwUQJ5IFngvF+ca2QfU=;
        b=g/WSSqMMC2Okd16NgGk6q/w81ccsT/OmEi9J2QeKUSI+ZWO7QePWdc+QZqh7olMbTCe5uC
        qT7uyA+u9kqqG0g0LlYz+BhTNqfjnmqtae/McYFQSt5ileRDftZsD7Hw2do4VlOlugBoh5
        foU0xNmXdKaUM+k8t9K8CmLt+ffpF+u58y8KNcKIJbSe2o8NmWh1xvkPz4Iq7n+kAFtyT8
        QT1vPqIOfhSm3bAlZSYHy50EAjojT50ldwR1KMoZaHcwc/zLZdnbkNnFD/kDcTnlfBqK+2
        gb7pUPQZlSjxMJ5vm+TrQ/dsd9zqq8QDJo5imE+YGg98mpjtJ6oC0m6h9FMyUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486188;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kJm0PJSfGBcuZwnpsc0bboCVKwUQJ5IFngvF+ca2QfU=;
        b=/DMoPz/K0hcQlew53g66tdyE1fZWmGzGqfp1kvAy8g+A8rFkJPvGwIZ0uYKYTVw/JCFnBD
        AH8Q6gv73a+927Bg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Fix copy_xstate_to_kernel() gap handling
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121451.294282032@linutronix.de>
References: <20210623121451.294282032@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448618679.395.10808785448604690958.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     9625895011d130033d1bc7aac0d77a9bf68ff8a6
Gitweb:        https://git.kernel.org/tip/9625895011d130033d1bc7aac0d77a9bf68ff8a6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:28 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 17:49:45 +02:00

x86/fpu: Fix copy_xstate_to_kernel() gap handling

The gap handling in copy_xstate_to_kernel() is wrong when XSAVES is in
use.

Using init_fpstate for copying the init state of features which are
not set in the xstate header is only correct for the legacy area, but
not for the extended features area because when XSAVES is in use then
init_fpstate is in compacted form which means the xstate offsets which
are used to copy from init_fpstate are not valid.

Fortunately, this is not a real problem today because all extended
features in use have an all-zeros init state, but it is wrong
nevertheless and with a potentially dynamically sized init_fpstate this
would result in an access outside of the init_fpstate.

Fix this by keeping track of the last copied state in the target buffer and
explicitly zero it when there is a feature or alignment gap.

Use the compacted offset when accessing the extended feature space in
init_fpstate.

As this is not a functional issue on older kernels this is intentionally
not tagged for stable.

Fixes: b8be15d58806 ("x86/fpu/xstate: Re-enable XSAVES")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121451.294282032@linutronix.de
---
 arch/x86/kernel/fpu/xstate.c | 105 +++++++++++++++++++---------------
 1 file changed, 61 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index f0f64d4..d822ce7 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1084,20 +1084,10 @@ static inline bool xfeatures_mxcsr_quirk(u64 xfeatures)
 	return true;
 }
 
-static void fill_gap(struct membuf *to, unsigned *last, unsigned offset)
+static void copy_feature(bool from_xstate, struct membuf *to, void *xstate,
+			 void *init_xstate, unsigned int size)
 {
-	if (*last >= offset)
-		return;
-	membuf_write(to, (void *)&init_fpstate.xsave + *last, offset - *last);
-	*last = offset;
-}
-
-static void copy_part(struct membuf *to, unsigned *last, unsigned offset,
-		      unsigned size, void *from)
-{
-	fill_gap(to, last, offset);
-	membuf_write(to, from, size);
-	*last = offset + size;
+	membuf_write(to, from_xstate ? xstate : init_xstate, size);
 }
 
 /*
@@ -1109,10 +1099,10 @@ static void copy_part(struct membuf *to, unsigned *last, unsigned offset,
  */
 void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave)
 {
+	const unsigned int off_mxcsr = offsetof(struct fxregs_state, mxcsr);
+	struct xregs_state *xinit = &init_fpstate.xsave;
 	struct xstate_header header;
-	const unsigned off_mxcsr = offsetof(struct fxregs_state, mxcsr);
-	unsigned size = to.left;
-	unsigned last = 0;
+	unsigned int zerofrom;
 	int i;
 
 	/*
@@ -1122,41 +1112,68 @@ void copy_xstate_to_kernel(struct membuf to, struct xregs_state *xsave)
 	header.xfeatures = xsave->header.xfeatures;
 	header.xfeatures &= xfeatures_mask_user();
 
-	if (header.xfeatures & XFEATURE_MASK_FP)
-		copy_part(&to, &last, 0, off_mxcsr, &xsave->i387);
-	if (header.xfeatures & (XFEATURE_MASK_SSE | XFEATURE_MASK_YMM))
-		copy_part(&to, &last, off_mxcsr,
-			  MXCSR_AND_FLAGS_SIZE, &xsave->i387.mxcsr);
-	if (header.xfeatures & XFEATURE_MASK_FP)
-		copy_part(&to, &last, offsetof(struct fxregs_state, st_space),
-			  128, &xsave->i387.st_space);
-	if (header.xfeatures & XFEATURE_MASK_SSE)
-		copy_part(&to, &last, xstate_offsets[XFEATURE_SSE],
-			  256, &xsave->i387.xmm_space);
-	/*
-	 * Fill xsave->i387.sw_reserved value for ptrace frame:
-	 */
-	copy_part(&to, &last, offsetof(struct fxregs_state, sw_reserved),
-		  48, xstate_fx_sw_bytes);
-	/*
-	 * Copy xregs_state->header:
-	 */
-	copy_part(&to, &last, offsetof(struct xregs_state, header),
-		  sizeof(header), &header);
+	/* Copy FP state up to MXCSR */
+	copy_feature(header.xfeatures & XFEATURE_MASK_FP, &to, &xsave->i387,
+		     &xinit->i387, off_mxcsr);
+
+	/* Copy MXCSR when SSE or YMM are set in the feature mask */
+	copy_feature(header.xfeatures & (XFEATURE_MASK_SSE | XFEATURE_MASK_YMM),
+		     &to, &xsave->i387.mxcsr, &xinit->i387.mxcsr,
+		     MXCSR_AND_FLAGS_SIZE);
+
+	/* Copy the remaining FP state */
+	copy_feature(header.xfeatures & XFEATURE_MASK_FP,
+		     &to, &xsave->i387.st_space, &xinit->i387.st_space,
+		     sizeof(xsave->i387.st_space));
+
+	/* Copy the SSE state - shared with YMM, but independently managed */
+	copy_feature(header.xfeatures & XFEATURE_MASK_SSE,
+		     &to, &xsave->i387.xmm_space, &xinit->i387.xmm_space,
+		     sizeof(xsave->i387.xmm_space));
+
+	/* Zero the padding area */
+	membuf_zero(&to, sizeof(xsave->i387.padding));
+
+	/* Copy xsave->i387.sw_reserved */
+	membuf_write(&to, xstate_fx_sw_bytes, sizeof(xsave->i387.sw_reserved));
+
+	/* Copy the user space relevant state of @xsave->header */
+	membuf_write(&to, &header, sizeof(header));
+
+	zerofrom = offsetof(struct xregs_state, extended_state_area);
 
 	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
 		/*
-		 * Copy only in-use xstates:
+		 * The ptrace buffer is in non-compacted XSAVE format.
+		 * In non-compacted format disabled features still occupy
+		 * state space, but there is no state to copy from in the
+		 * compacted init_fpstate. The gap tracking will zero this
+		 * later.
 		 */
-		if ((header.xfeatures >> i) & 1) {
-			void *src = __raw_xsave_addr(xsave, i);
+		if (!(xfeatures_mask_user() & BIT_ULL(i)))
+			continue;
 
-			copy_part(&to, &last, xstate_offsets[i],
-				  xstate_sizes[i], src);
-		}
+		/*
+		 * If there was a feature or alignment gap, zero the space
+		 * in the destination buffer.
+		 */
+		if (zerofrom < xstate_offsets[i])
+			membuf_zero(&to, xstate_offsets[i] - zerofrom);
+
+		copy_feature(header.xfeatures & BIT_ULL(i), &to,
+			     __raw_xsave_addr(xsave, i),
+			     __raw_xsave_addr(xinit, i),
+			     xstate_sizes[i]);
 
+		/*
+		 * Keep track of the last copied state in the non-compacted
+		 * target buffer for gap zeroing.
+		 */
+		zerofrom = xstate_offsets[i] + xstate_sizes[i];
 	}
-	fill_gap(&to, &last, size);
+
+	if (to.left)
+		membuf_zero(&to, to.left);
 }
 
 /*
