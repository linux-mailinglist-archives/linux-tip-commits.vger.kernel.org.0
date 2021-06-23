Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D81E3B22F6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhFWWLQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhFWWLO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CCAC06175F;
        Wed, 23 Jun 2021 15:08:55 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:08:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZvlZ+knvF7KBBn84ujFP7l6LcZxesIzDgGflT7iBnmI=;
        b=U1rERMvxDHoRulHg1sRxM7JCTkNWCyqyarVHel0TWzFDrRmLFe1Dq6rIYf2rwOn9m0n/Hx
        4DTGuE4uNxPBFVze7DS31BnjTX3b4g/PNiHR4Z++XzSbjhGGHKRlvb+T4hOXZO4eNGcwYH
        XVjju/7tJQfqwI0chiea9E/BCdek5xo6g5pv5as8PKco2qO4tW+mbS6+rLo7mh40wGJExP
        M0CYlH9Kj0gw2XfXuXxIsPuqRCAcAU4CFV6KjpZ65OlcyT/zD142/nqc+26PqZ8Y1l9G1W
        /ZuevHdOxwI8RBL4dAndCBySVlHb0dqC1xSz/isO5RBie4G/9Zky0VoWOX2usQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZvlZ+knvF7KBBn84ujFP7l6LcZxesIzDgGflT7iBnmI=;
        b=6uZIBm/TI+x6DFphUA7/7v5JUbTcpfWbX8V5wamjDPX5dtpn+xFCAc0s+RxmxqfRsvxQnB
        zKScYrw5UPCuKvAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/signal: Sanitize copy_user_to_fpregs_zeroing()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121457.377341297@linutronix.de>
References: <20210623121457.377341297@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448613219.395.1878026911154328775.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     cdcec1b77001e7f2cd10dccfc6d9b6d5d3f1f3ea
Gitweb:        https://git.kernel.org/tip/cdcec1b77001e7f2cd10dccfc6d9b6d5d3f1f3ea
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:28 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 20:03:15 +02:00

x86/fpu/signal: Sanitize copy_user_to_fpregs_zeroing()

Now that user_xfeatures is correctly set when xsave is enabled, remove
the duplicated initialization of components.

Rename the function while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121457.377341297@linutronix.de
---
 arch/x86/kernel/fpu/signal.c | 36 ++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index d552410..a1a7013 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -251,33 +251,27 @@ sanitize_restored_user_xstate(union fpregs_state *state,
 }
 
 /*
- * Restore the extended state if present. Otherwise, restore the FP/SSE state.
+ * Restore the FPU state directly from the userspace signal frame.
  */
-static int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
+static int restore_fpregs_from_user(void __user *buf, u64 xrestore, bool fx_only)
 {
-	u64 init_bv;
-	int r;
-
 	if (use_xsave()) {
-		if (fx_only) {
-			init_bv = xfeatures_mask_uabi() & ~XFEATURE_MASK_FPSSE;
+		u64 init_bv = xfeatures_mask_uabi() & ~xrestore;
+		int ret;
 
-			r = fxrstor_from_user_sigframe(buf);
-			if (!r)
-				os_xrstor(&init_fpstate.xsave, init_bv);
-			return r;
-		} else {
-			init_bv = xfeatures_mask_uabi() & ~xbv;
-
-			r = xrstor_from_user_sigframe(buf, xbv);
-			if (!r && unlikely(init_bv))
-				os_xrstor(&init_fpstate.xsave, init_bv);
-			return r;
-		}
+		if (likely(!fx_only))
+			ret = xrstor_from_user_sigframe(buf, xrestore);
+		else
+			ret = fxrstor_from_user_sigframe(buf);
+
+		if (!ret && unlikely(init_bv))
+			os_xrstor(&init_fpstate.xsave, init_bv);
+		return ret;
 	} else if (use_fxsr()) {
 		return fxrstor_from_user_sigframe(buf);
-	} else
+	} else {
 		return frstor_from_user_sigframe(buf);
+	}
 }
 
 static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
@@ -314,7 +308,7 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		 */
 		fpregs_lock();
 		pagefault_disable();
-		ret = copy_user_to_fpregs_zeroing(buf_fx, user_xfeatures, fx_only);
+		ret = restore_fpregs_from_user(buf_fx, user_xfeatures, fx_only);
 		pagefault_enable();
 		if (!ret) {
 
