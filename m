Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66B83B2330
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhFWWMo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40194 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhFWWLv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:51 -0400
Date:   Wed, 23 Jun 2021 22:09:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486172;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JNikhxWw6Fg3X/RpsxNHHeXoYTuuCzWPctYu/VzsnQ8=;
        b=hysc0UGaad8KzXYuYK5MDcIlYPV6w0I8OBIKA+XQwL6cu0VQpE1/XHeGhx3m6z28q6m3cU
        k2FsH0IDBUHCBMechiF1ffpsJmiR0L4W4YVUR2touncdw1b1rt+fzBmakhkoS2yeP3yj+i
        nPc/YHLekn7h5Yu3yU16rnosnLya3UDQBwydCYvFIkcVFTLIFLrHBx54uetDOd1WizEWEj
        ZH1T6pho8zRmIe8WFXitT+0hxHazMEeQ/9eV6n/F3gzA+GeqsGDl/cL8+IhablxF0/RR4O
        sD4UCIMBtqrSfo+tS42OMNLVut4yLAwjddLWvWrFyx1HnEqxjiYugpwMEpSq/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486172;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JNikhxWw6Fg3X/RpsxNHHeXoYTuuCzWPctYu/VzsnQ8=;
        b=rxN4wivkcMSjRUB/9WGQv0Mv3/VNKX3PigfLgKGfT+jkXtVP3o2fmq5tsvvTGj5zHGudfs
        Kl0dHHkyoUGa4XDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Remove fpstate_sanitize_xstate()
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121453.124819167@linutronix.de>
References: <20210623121453.124819167@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448617176.395.14863657542588394797.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     afac9e894364418731d1d7e66c1118b31fd130e8
Gitweb:        https://git.kernel.org/tip/afac9e894364418731d1d7e66c1118b31fd130e8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:45 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 17:49:47 +02:00

x86/fpu: Remove fpstate_sanitize_xstate()

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121453.124819167@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h |  2 +-
 arch/x86/kernel/fpu/xstate.c        | 79 +----------------------------
 2 files changed, 81 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 9ed9846..0148791 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -86,8 +86,6 @@ extern void fpstate_init_soft(struct swregs_state *soft);
 static inline void fpstate_init_soft(struct swregs_state *soft) {}
 #endif
 
-extern void fpstate_sanitize_xstate(struct fpu *fpu);
-
 #define user_insn(insn, output, input...)				\
 ({									\
 	int err;							\
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 8d023a2..e17fde9 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -129,85 +129,6 @@ static bool xfeature_is_supervisor(int xfeature_nr)
 }
 
 /*
- * When executing XSAVEOPT (or other optimized XSAVE instructions), if
- * a processor implementation detects that an FPU state component is still
- * (or is again) in its initialized state, it may clear the corresponding
- * bit in the header.xfeatures field, and can skip the writeout of registers
- * to the corresponding memory layout.
- *
- * This means that when the bit is zero, the state component might still contain
- * some previous - non-initialized register state.
- *
- * Before writing xstate information to user-space we sanitize those components,
- * to always ensure that the memory layout of a feature will be in the init state
- * if the corresponding header bit is zero. This is to ensure that user-space doesn't
- * see some stale state in the memory layout during signal handling, debugging etc.
- */
-void fpstate_sanitize_xstate(struct fpu *fpu)
-{
-	struct fxregs_state *fx = &fpu->state.fxsave;
-	int feature_bit;
-	u64 xfeatures;
-
-	if (!use_xsaveopt())
-		return;
-
-	xfeatures = fpu->state.xsave.header.xfeatures;
-
-	/*
-	 * None of the feature bits are in init state. So nothing else
-	 * to do for us, as the memory layout is up to date.
-	 */
-	if ((xfeatures & xfeatures_mask_all) == xfeatures_mask_all)
-		return;
-
-	/*
-	 * FP is in init state
-	 */
-	if (!(xfeatures & XFEATURE_MASK_FP)) {
-		fx->cwd = 0x37f;
-		fx->swd = 0;
-		fx->twd = 0;
-		fx->fop = 0;
-		fx->rip = 0;
-		fx->rdp = 0;
-		memset(fx->st_space, 0, sizeof(fx->st_space));
-	}
-
-	/*
-	 * SSE is in init state
-	 */
-	if (!(xfeatures & XFEATURE_MASK_SSE))
-		memset(fx->xmm_space, 0, sizeof(fx->xmm_space));
-
-	/*
-	 * First two features are FPU and SSE, which above we handled
-	 * in a special way already:
-	 */
-	feature_bit = 0x2;
-	xfeatures = (xfeatures_mask_user() & ~xfeatures) >> 2;
-
-	/*
-	 * Update all the remaining memory layouts according to their
-	 * standard xstate layout, if their header bit is in the init
-	 * state:
-	 */
-	while (xfeatures) {
-		if (xfeatures & 0x1) {
-			int offset = xstate_comp_offsets[feature_bit];
-			int size = xstate_sizes[feature_bit];
-
-			memcpy((void *)fx + offset,
-			       (void *)&init_fpstate.xsave + offset,
-			       size);
-		}
-
-		xfeatures >>= 1;
-		feature_bit++;
-	}
-}
-
-/*
  * Enable the extended processor state save/restore feature.
  * Called once per CPU onlining.
  */
