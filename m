Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05893B2335
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhFWWMs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40230 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhFWWL5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:57 -0400
Date:   Wed, 23 Jun 2021 22:09:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486178;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=je5bbjZViGfGfs+4O9W+Fbt71G7+RMsgLKAxkwPKK6g=;
        b=JuiEMoo12rVKu0GTMglirUW+ZhWwmFPKLA4QGB5vFhZHzXdUr6LGPrrWfE64tXohzIj9zR
        azT7WC90th1Q3nuHpPqH8r/NHiGpaFfk59JXXE+b9P0I1z7gxoVFHXALvMgotspYsnqIzd
        37Jh0iZKKDa2uR+sE+tpA4cuPjaxRfCeybJ00fcDHrbWZ9+lftzQBSXFo63HeGrFxOh8jn
        m54J9agZLpkUqkiHM/OZ+we44MjCKbZe6NCJf8z4HJ+vQdve33DW8NCWJvRLtYU08doh2N
        jBYJBs4D3/ukLIMEKlQadtCxvYTM0o0JzDaSnGHw8lGK5ZDamrrL4mcwRD08ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486178;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=je5bbjZViGfGfs+4O9W+Fbt71G7+RMsgLKAxkwPKK6g=;
        b=BXnDz2DpoQf2ex2dd6Xoq2YeyK8x5sZBbH1N9+c6Fv+VqininVL/3Wn3SwQYXHJ/738djY
        LSmBqgAe4uPGkdBQ==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Rewrite xfpregs_set()
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210623121452.504234607@linutronix.de>
References: <20210623121452.504234607@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448617708.395.7302447964739522489.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     6164331d15f7d912fb9369245368e9564ea49813
Gitweb:        https://git.kernel.org/tip/6164331d15f7d912fb9369245368e9564ea49813
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Wed, 23 Jun 2021 14:01:39 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 17:49:46 +02:00

x86/fpu: Rewrite xfpregs_set()

xfpregs_set() was incomprehensible.  Almost all of the complexity was due
to trying to support nonsensically sized writes or -EFAULT errors that
would have partially or completely overwritten the destination before
failing.  Nonsensically sized input would only have been possible using
PTRACE_SETREGSET on REGSET_XFP.  Fortunately, it appears (based on Debian
code search results) that no one uses that API at all, let alone with the
wrong sized buffer.  Failed user access can be handled more cleanly by
first copying to kernel memory.

Just rewrite it to require sensible input.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121452.504234607@linutronix.de
---
 arch/x86/kernel/fpu/regset.c | 37 +++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index d60e77d..f24ce87 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -47,30 +47,39 @@ int xfpregs_set(struct task_struct *target, const struct user_regset *regset,
 		const void *kbuf, const void __user *ubuf)
 {
 	struct fpu *fpu = &target->thread.fpu;
+	struct user32_fxsr_struct newstate;
 	int ret;
 
-	if (!boot_cpu_has(X86_FEATURE_FXSR))
+	BUILD_BUG_ON(sizeof(newstate) != sizeof(struct fxregs_state));
+
+	if (!cpu_feature_enabled(X86_FEATURE_FXSR))
 		return -ENODEV;
 
+	/* No funny business with partial or oversized writes is permitted. */
+	if (pos != 0 || count != sizeof(newstate))
+		return -EINVAL;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &newstate, 0, -1);
+	if (ret)
+		return ret;
+
+	/* Mask invalid MXCSR bits (for historical reasons). */
+	newstate.mxcsr &= mxcsr_feature_mask;
+
 	fpu__prepare_write(fpu);
-	fpstate_sanitize_xstate(fpu);
 
-	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				 &fpu->state.fxsave, 0, -1);
+	/* Copy the state  */
+	memcpy(&fpu->state.fxsave, &newstate, sizeof(newstate));
 
-	/*
-	 * mxcsr reserved bits must be masked to zero for security reasons.
-	 */
-	fpu->state.fxsave.mxcsr &= mxcsr_feature_mask;
+	/* Clear xmm8..15 */
+	BUILD_BUG_ON(sizeof(fpu->state.fxsave.xmm_space) != 16 * 16);
+	memset(&fpu->state.fxsave.xmm_space[8], 0, 8 * 16);
 
-	/*
-	 * update the header bits in the xsave header, indicating the
-	 * presence of FP and SSE state.
-	 */
-	if (boot_cpu_has(X86_FEATURE_XSAVE))
+	/* Mark FP and SSE as in use when XSAVE is enabled */
+	if (use_xsave())
 		fpu->state.xsave.header.xfeatures |= XFEATURE_MASK_FPSSE;
 
-	return ret;
+	return 0;
 }
 
 int xstateregs_get(struct task_struct *target, const struct user_regset *regset,
