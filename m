Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A97643655A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 17:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhJUPOo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 11:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbhJUPOo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 11:14:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AAFC0613B9;
        Thu, 21 Oct 2021 08:12:28 -0700 (PDT)
Date:   Thu, 21 Oct 2021 15:12:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634829146;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FOJq8z5uvzXtH5zdARNrhQX757WWihsbu5muzKXLSUw=;
        b=tqRYu2Fn7ChVg8XbJ2HpJ9qwbE/D4okkutmtOLKkEwhSMQYlBdoqS5IqlDWgkTEJRsxFoY
        eoC2nzAUXogF99nRtobzscTJMbuOoeughydnBPt+y5C9FE8Qzy2TnYBDh4gFcVbvFgxky1
        xG7jlEJNQ3ZncnmVuv05oadHhI8/mI4k8nvGtuwZegAyy0BfXdhLDjCxF/xWQWMO3iFIlr
        Uj7ZnYjIOWfB9+JaXrDqy6U5C6UtE+K2LhappJ/J9/XkkW0B1dvVrhJVWJQTXeD85wPh9r
        dyjPZoH0L5sNTQGCzeZmSi3tKY5iBPS/zTkQ8I5ItoUvp8BjQdycMsdR+UHSpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634829146;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FOJq8z5uvzXtH5zdARNrhQX757WWihsbu5muzKXLSUw=;
        b=Uoxh4gtUt8R7F4uMCtKHjW0k3yJoDMneq1x+GOk8i4pDdlJSgVRvFxoQNjpOewRVR2SO/O
        rkYDs7lQuRDwjoCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Use fpstate in fpu_copy_kvm_uabi_to_fpstate()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211013145323.129699950@linutronix.de>
References: <20211013145323.129699950@linutronix.de>
MIME-Version: 1.0
Message-ID: <163482914584.25758.2052519471225914902.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     ad6ede407aae01d9617e172b27e179ce1046cbfc
Gitweb:        https://git.kernel.org/tip/ad6ede407aae01d9617e172b27e179ce1046cbfc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Oct 2021 16:55:52 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Oct 2021 14:17:47 +02:00

x86/fpu: Use fpstate in fpu_copy_kvm_uabi_to_fpstate()

Straight forward conversion. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211013145323.129699950@linutronix.de
---
 arch/x86/kernel/fpu/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index f4db70b..052e5ef 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -205,7 +205,7 @@ EXPORT_SYMBOL_GPL(fpu_copy_fpstate_to_kvm_uabi);
 int fpu_copy_kvm_uabi_to_fpstate(struct fpu *fpu, const void *buf, u64 xcr0,
 				 u32 *vpkru)
 {
-	union fpregs_state *kstate = &fpu->fpstate->regs;
+	struct fpstate *kstate = fpu->fpstate;
 	const union fpregs_state *ustate = buf;
 	struct pkru_state *xpkru;
 	int ret;
@@ -215,25 +215,25 @@ int fpu_copy_kvm_uabi_to_fpstate(struct fpu *fpu, const void *buf, u64 xcr0,
 			return -EINVAL;
 		if (ustate->fxsave.mxcsr & ~mxcsr_feature_mask)
 			return -EINVAL;
-		memcpy(&kstate->fxsave, &ustate->fxsave, sizeof(ustate->fxsave));
+		memcpy(&kstate->regs.fxsave, &ustate->fxsave, sizeof(ustate->fxsave));
 		return 0;
 	}
 
 	if (ustate->xsave.header.xfeatures & ~xcr0)
 		return -EINVAL;
 
-	ret = copy_uabi_from_kernel_to_xstate(&kstate->xsave, ustate);
+	ret = copy_uabi_from_kernel_to_xstate(&kstate->regs.xsave, ustate);
 	if (ret)
 		return ret;
 
 	/* Retrieve PKRU if not in init state */
-	if (kstate->xsave.header.xfeatures & XFEATURE_MASK_PKRU) {
-		xpkru = get_xsave_addr(&kstate->xsave, XFEATURE_PKRU);
+	if (kstate->regs.xsave.header.xfeatures & XFEATURE_MASK_PKRU) {
+		xpkru = get_xsave_addr(&kstate->regs.xsave, XFEATURE_PKRU);
 		*vpkru = xpkru->pkru;
 	}
 
 	/* Ensure that XCOMP_BV is set up for XSAVES */
-	xstate_init_xcomp_bv(&kstate->xsave, xfeatures_mask_uabi());
+	xstate_init_xcomp_bv(&kstate->regs.xsave, xfeatures_mask_uabi());
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fpu_copy_kvm_uabi_to_fpstate);
