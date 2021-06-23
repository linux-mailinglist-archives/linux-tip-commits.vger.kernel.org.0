Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC743B2326
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhFWWM2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40012 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhFWWLo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:44 -0400
Date:   Wed, 23 Jun 2021 22:09:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486165;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ql1N8kdDMj6tGcwR/k1XCf/apgCfYiLppW7kqN9L9IQ=;
        b=hG3/1Tqq3pdN6FCipbygtFnEooVd0pvDuqVYLZuamZZwjtkI+7JqWchlNrENct1U+MZA01
        HJEo96Ks6KSfrJ5xCBJE2ODTlg/2GgANoH4wzuplLX7cbeT+5PVJSuVCbiCuCYC2mLoHkE
        2Xbm6hT9MF08H1/ajlnoqTLQ7MkPAs8tqs9JjLcEet12ggxn67FDPyXRkABoL8IZB+DXfF
        CqHeWF1YvbP0y9ZUugMxpbwZjt9KWL1/+9rbDXDFxqTbEwwAfiGDE7LyRfF7a8uPCz6g78
        EaOMpjxc20ithpWnL1OpPBnpTVFQPyttqNHyb7xCexvx4JwcH9S+wOc/oRitPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486165;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ql1N8kdDMj6tGcwR/k1XCf/apgCfYiLppW7kqN9L9IQ=;
        b=BOC651AJ1z6quWDC2eGy0wFxogXeMXCwvqSQFcsmy1UW9dz5eVkFqd4bMiVAWnHKRxz+qZ
        LDHaQ5ikf3QnCGCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Rename copy_user_to_xregs() and copy_xregs_to_user()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121453.924266705@linutronix.de>
References: <20210623121453.924266705@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448616483.395.12879945104947059756.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     6b862ba1821441e6083cf061404694d33a841526
Gitweb:        https://git.kernel.org/tip/6b862ba1821441e6083cf061404694d33a841526
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:53 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 18:01:56 +02:00

x86/fpu: Rename copy_user_to_xregs() and copy_xregs_to_user()

The function names for xsave[s]/xrstor[s] operations are horribly named and
a permanent source of confusion.

Rename:
	copy_xregs_to_user() to xsave_to_user_sigframe()
	copy_user_to_xregs() to xrstor_from_user_sigframe()

so it's entirely clear what this is about. This is also a clear indicator
of the potentially different storage format because this is user ABI and
cannot use compacted format.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121453.924266705@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 4 ++--
 arch/x86/kernel/fpu/signal.c        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index dae1545..a2ab744 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -326,7 +326,7 @@ static inline void os_xrstor(struct xregs_state *xstate, u64 mask)
  * backward compatibility for old applications which don't understand
  * compacted format of xsave area.
  */
-static inline int copy_xregs_to_user(struct xregs_state __user *buf)
+static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
 {
 	u64 mask = xfeatures_mask_user();
 	u32 lmask = mask;
@@ -351,7 +351,7 @@ static inline int copy_xregs_to_user(struct xregs_state __user *buf)
 /*
  * Restore xstate from user space xsave area.
  */
-static inline int copy_user_to_xregs(struct xregs_state __user *buf, u64 mask)
+static inline int xrstor_from_user_sigframe(struct xregs_state __user *buf, u64 mask)
 {
 	struct xregs_state *xstate = ((__force struct xregs_state *)buf);
 	u32 lmask = mask;
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 33675b3..4fe632f 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -129,7 +129,7 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
 	int err;
 
 	if (use_xsave())
-		err = copy_xregs_to_user(buf);
+		err = xsave_to_user_sigframe(buf);
 	else if (use_fxsr())
 		err = copy_fxregs_to_user((struct fxregs_state __user *) buf);
 	else
@@ -266,7 +266,7 @@ static int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
 		} else {
 			init_bv = xfeatures_mask_user() & ~xbv;
 
-			r = copy_user_to_xregs(buf, xbv);
+			r = xrstor_from_user_sigframe(buf, xbv);
 			if (!r && unlikely(init_bv))
 				os_xrstor(&init_fpstate.xsave, init_bv);
 			return r;
