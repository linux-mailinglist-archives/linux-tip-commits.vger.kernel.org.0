Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F4225454D35
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Nov 2021 19:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhKQScg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Nov 2021 13:32:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33262 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbhKQScg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Nov 2021 13:32:36 -0500
Date:   Wed, 17 Nov 2021 18:29:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637173776;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nOVhcHgI8g7zN42nh4pVJOp1nfrcdr3b6IpdBIKlais=;
        b=wE04mu2twkM9aqGqNMRzVKtlPXqFt3ClWwGohclTHZfDA2MNNMLnRZNV2s9x4OV92LxIac
        BhrI2veE/e3x8SGBZY9Ht9ycTYhPGSr4Cre6a2MVjbjBO1G9Uawdn6x4zErhaL93iqgjDu
        SsaLHgNdsFPjb3HDwFcneyx4zLSzGS4qy/cud3tkWDNoToNH5YGC2oT0YrXb7Lfe6DNH/3
        7XXiGSNyA7xfv6H4buTK4tUoBobeeY/eeiaubiPfxBoN0uytd29mA/3+iqILEt3QG/5d/M
        txPUtWP+jr485POmM0VJVi/djWi4MV9rUTudVCkIBmsIrZBk7SbjM929d8GpLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637173776;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nOVhcHgI8g7zN42nh4pVJOp1nfrcdr3b6IpdBIKlais=;
        b=jdh+M2kvkP1kXilkcOPbajYPMrg/W94s0Rf+t3tLFMZbCDK5ChAiafjT9/ZN5J/Ll0OW0R
        +XW5G5OHWfzJaPAg==
From:   "tip-bot2 for Noah Goldstein" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Correct AVX512 state tracking
Cc:     Noah Goldstein <goldstein.w.n@gmail.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
References: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
MIME-Version: 1.0
Message-ID: <163717377532.11128.15112806017937850586.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     0fe4ff885f8a50082d9dc241b657472894caba16
Gitweb:        https://git.kernel.org/tip/0fe4ff885f8a50082d9dc241b657472894caba16
Author:        Noah Goldstein <goldstein.w.n@gmail.com>
AuthorDate:    Tue, 16 Nov 2021 17:14:21 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 16 Nov 2021 17:19:41 +01:00

x86/fpu: Correct AVX512 state tracking

Add a separate, local mask for tracking AVX512 usage which does not
include the opmask xfeature set. Opmask registers usage does not cause
frequency throttling so it is a completely unnecessary false positive.

While at it, carve it out into a separate function to keep that
abomination extracted out.

 [ bp: Rediff and cleanup ontop of 5.16-rc1. ]

Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20210920053951.4093668-1-goldstein.w.n@gmail.com
---
 arch/x86/kernel/fpu/core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 8ea306b..dd3777a 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -99,6 +99,19 @@ bool irq_fpu_usable(void)
 EXPORT_SYMBOL(irq_fpu_usable);
 
 /*
+ * Track AVX512 state use because it is known to slow the max clock
+ * speed of the core.
+ */
+static void update_avx_timestamp(struct fpu *fpu)
+{
+
+#define AVX512_TRACKING_MASK	(XFEATURE_MASK_ZMM_Hi256 | XFEATURE_MASK_Hi16_ZMM)
+
+	if (fpu->fpstate->regs.xsave.header.xfeatures & AVX512_TRACKING_MASK)
+		fpu->avx512_timestamp = jiffies;
+}
+
+/*
  * Save the FPU register state in fpu->fpstate->regs. The register state is
  * preserved.
  *
@@ -116,13 +129,7 @@ void save_fpregs_to_fpstate(struct fpu *fpu)
 {
 	if (likely(use_xsave())) {
 		os_xsave(fpu->fpstate);
-
-		/*
-		 * AVX512 state is tracked here because its use is
-		 * known to slow the max clock speed of the core.
-		 */
-		if (fpu->fpstate->regs.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
-			fpu->avx512_timestamp = jiffies;
+		update_avx_timestamp(fpu);
 		return;
 	}
 
