Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1A643B6C9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Oct 2021 18:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbhJZQTI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Oct 2021 12:19:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34588 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237335AbhJZQTF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:05 -0400
Date:   Tue, 26 Oct 2021 16:16:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635265000;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rI3L6NWRbAk/UxwHxAMhlHIaFcQAAhRBainOt9/pvis=;
        b=4lxkMfSPtLCtDOmVFZJ5rF+gEsw9mKVTW27voDOEQ9Ydrgau2gd1OQku9rBAJ9ObmY9sQj
        YD50ql2jnst9J0k2v+1f80o3ECBtnhU7QwysCwyoScVH30cKqrcpxuKfoyzANWXRZ4dOup
        1XKQRZaYygZyj1sGnJCu2dDSLMYHTOHj+4AC0PMKqglyuIi4xK1+0LBwTYTLKO99WfE5vo
        qlFiNRcOuGi11SrWa5V6meWTVQyZhOdTgum8WnMGnVwCYmcpq21ztu9xd3FKMtjtliFrLK
        1JtJpAxo3RqkcPfNQwrEkYePSRBsPvpKPAL2kE5dsWpQS/2xqHZo7Hh2DgHJnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635265000;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rI3L6NWRbAk/UxwHxAMhlHIaFcQAAhRBainOt9/pvis=;
        b=ngeHkUtrODCyQj4B79RceNuG+paJTL+U5795raPDgbFLYRhCxQb5sV1+s0kcML7aqJJYr2
        UV16ub8fbDY04fAA==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Add XFD state to fpstate
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021225527.10184-15-chang.seok.bae@intel.com>
References: <20211021225527.10184-15-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <163526499987.626.11601427955477389497.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     8bf26758ca9659866b844dd51037314b4c0fa6bd
Gitweb:        https://git.kernel.org/tip/8bf26758ca9659866b844dd51037314b4c0fa6bd
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 21 Oct 2021 15:55:18 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 Oct 2021 10:18:09 +02:00

x86/fpu: Add XFD state to fpstate

Add storage for XFD register state to struct fpstate. This will be used to
store the XFD MSR state. This will be used for switching the XFD MSR when
FPU content is restored.

Add a per-CPU variable to cache the current MSR value so the MSR has only
to be written when the values are different.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211021225527.10184-15-chang.seok.bae@intel.com
---
 arch/x86/include/asm/fpu/types.h | 3 +++
 arch/x86/kernel/fpu/core.c       | 2 ++
 arch/x86/kernel/fpu/xstate.h     | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index 595122f..b189763 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -322,6 +322,9 @@ struct fpstate {
 	/* @user_xfeatures:	xfeatures valid in UABI buffers */
 	u64			user_xfeatures;
 
+	/* @xfd:		xfeatures disabled to trap userspace use. */
+	u64			xfd;
+
 	/* @is_valloc:		Indicator for dynamically allocated state */
 	unsigned int		is_valloc	: 1;
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 3349068..3b72cdd 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -27,6 +27,7 @@
 
 #ifdef CONFIG_X86_64
 DEFINE_STATIC_KEY_FALSE(__fpu_state_size_dynamic);
+DEFINE_PER_CPU(u64, xfd_state);
 #endif
 
 /* The FPU state configuration data for kernel and user space */
@@ -409,6 +410,7 @@ static void __fpstate_reset(struct fpstate *fpstate)
 	fpstate->user_size	= fpu_user_cfg.default_size;
 	fpstate->xfeatures	= fpu_kernel_cfg.default_features;
 	fpstate->user_xfeatures	= fpu_user_cfg.default_features;
+	fpstate->xfd		= init_fpstate.xfd;
 }
 
 void fpstate_reset(struct fpu *fpu)
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 4ce1dc0..32a4dee 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -5,6 +5,10 @@
 #include <asm/cpufeature.h>
 #include <asm/fpu/xstate.h>
 
+#ifdef CONFIG_X86_64
+DECLARE_PER_CPU(u64, xfd_state);
+#endif
+
 static inline void xstate_init_xcomp_bv(struct xregs_state *xsave, u64 mask)
 {
 	/*
