Return-Path: <linux-tip-commits+bounces-5896-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6C3AE7336
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 01:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18AE41BC2B85
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Jun 2025 23:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8597B26B956;
	Tue, 24 Jun 2025 23:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0x4YasJL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JcOh2441"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49CA26B751;
	Tue, 24 Jun 2025 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807863; cv=none; b=L1NK/5xSnfhOxJEaISulV/uyqlH8U+lgD0CNRnMTLehuiNIM1Q3YeGjKvwnvQYOIPcCF7ZwSEy8qgchejXiA3qGlbZ4dXf+B58lbV+U66dUMqCtADv2hfdcdClauW9ME025mm7p4j+h01SR6lCHRogw3vPQKKWGjodwwJ7C3gng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807863; c=relaxed/simple;
	bh=YbCLBhJbUdelYgjzLt2DRQl3g12Bx1eD4ZsmUclcup4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=K1nzNTL5cCkINj6d4Gx7bDDznZNVWm/Yxv9wZmB5z/7mHgEbPkDnSo2eCwab8Vt5t/ORA0UXRAHxgRHMtpWg/3Q13RWdcNhidMs2u8tdpGMAX19C6NoMS0ywCLvNVAjHhS5KedUuh8ygWq5itpCJzsWbxIK3Vb8VtTSzwVvaVNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0x4YasJL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JcOh2441; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Jun 2025 23:30:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750807859;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=PFi57pI7SXW7krG0eFr4/5IQ5Y0pzBy9MzPi5Gy+ygM=;
	b=0x4YasJLozOjioftIKf2ugWIyqJ5axIgD7/G4SaqhQt2j9SZFDk1OcT0scsYbQVfbgKkwH
	YSos3Hb5PxheEHWMFghlaeEnJBqC37SlHHSzVlIlDxM01hMLOQY0MhX2t50fbOh94ttEHR
	JLZ+BYTOfPeYKDfYhNPgEouhismJmvUcgitYx4q+qoG7rY5GctrCZiQdzS4sEEta2Ip66f
	CJKNNBZOvbUKV/SzAJD13J+Z1fExPXBDoAOjsqJLDjUgWj4//I1Hj2DyhNuy+OdYA2/9oO
	E+zkRuhreSilWWTpqgW1vuYAV1eyRPHuiSksNyiM3MXdcgugcS7thfIyoxfG1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750807859;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=PFi57pI7SXW7krG0eFr4/5IQ5Y0pzBy9MzPi5Gy+ygM=;
	b=JcOh2441pgeYemkN5qqpPg4db5+qwRQHYLigAjiTMcL/dyX0uMu4z0uhLVfls4N3jV0Snw
	MXDOnPKT+phSIHDA==
From: "tip-bot2 for Chao Gao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Initialize guest fpstate and FPU pseudo
 container from guest defaults
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Chao Gao <chao.gao@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, John Allen <john.allen@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175080785887.406.10961378813772629174.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     509e880b779592aafb41b3b23de3df7e4e2e2fcf
Gitweb:        https://git.kernel.org/tip/509e880b779592aafb41b3b23de3df7e4e2e2fcf
Author:        Chao Gao <chao.gao@intel.com>
AuthorDate:    Thu, 22 May 2025 08:10:06 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 24 Jun 2025 13:46:32 -07:00

x86/fpu: Initialize guest fpstate and FPU pseudo container from guest defaults

fpu_alloc_guest_fpstate() currently uses host defaults to initialize guest
fpstate and pseudo containers. Guest defaults were introduced to
differentiate the features and sizes of host and guest FPUs. Switch to
using guest defaults instead.

Adjust __fpstate_reset() to handle different defaults for host and guest
FPUs. And to distinguish between the types of FPUs, move the initialization
of indicators (is_guest and is_valloc) before the reset.

Suggested-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: John Allen <john.allen@amd.com>
Link: https://lore.kernel.org/all/20250522151031.426788-4-chao.gao%40intel.com
---
 arch/x86/kernel/fpu/core.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 94706a5..e027051 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -243,19 +243,22 @@ bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
 	struct fpstate *fpstate;
 	unsigned int size;
 
-	size = fpu_kernel_cfg.default_size + ALIGN(offsetof(struct fpstate, regs), 64);
+	size = guest_default_cfg.size + ALIGN(offsetof(struct fpstate, regs), 64);
+
 	fpstate = vzalloc(size);
 	if (!fpstate)
 		return false;
 
+	/* Initialize indicators to reflect properties of the fpstate */
+	fpstate->is_valloc	= true;
+	fpstate->is_guest	= true;
+
 	/* Leave xfd to 0 (the reset value defined by spec) */
 	__fpstate_reset(fpstate, 0);
 	fpstate_init_user(fpstate);
-	fpstate->is_valloc	= true;
-	fpstate->is_guest	= true;
 
 	gfpu->fpstate		= fpstate;
-	gfpu->xfeatures		= fpu_kernel_cfg.default_features;
+	gfpu->xfeatures		= guest_default_cfg.features;
 
 	/*
 	 * KVM sets the FP+SSE bits in the XSAVE header when copying FPU state
@@ -544,10 +547,22 @@ void fpstate_init_user(struct fpstate *fpstate)
 
 static void __fpstate_reset(struct fpstate *fpstate, u64 xfd)
 {
-	/* Initialize sizes and feature masks */
-	fpstate->size		= fpu_kernel_cfg.default_size;
+	/*
+	 * Supervisor features (and thus sizes) may diverge between guest
+	 * FPUs and host FPUs, as some supervisor features are supported
+	 * for guests despite not being utilized by the host. User
+	 * features and sizes are always identical, which allows for
+	 * common guest and userspace ABI.
+	 */
+	if (fpstate->is_guest) {
+		fpstate->size		= guest_default_cfg.size;
+		fpstate->xfeatures	= guest_default_cfg.features;
+	} else {
+		fpstate->size		= fpu_kernel_cfg.default_size;
+		fpstate->xfeatures	= fpu_kernel_cfg.default_features;
+	}
+
 	fpstate->user_size	= fpu_user_cfg.default_size;
-	fpstate->xfeatures	= fpu_kernel_cfg.default_features;
 	fpstate->user_xfeatures	= fpu_user_cfg.default_features;
 	fpstate->xfd		= xfd;
 }

