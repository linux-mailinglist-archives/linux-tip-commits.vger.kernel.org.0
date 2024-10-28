Return-Path: <linux-tip-commits+bounces-2616-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 719D39B313A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Oct 2024 14:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41D51F21DC6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Oct 2024 13:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304E21E519;
	Mon, 28 Oct 2024 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DT5jDkNo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I8qbRfXc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32CF1CCECE;
	Mon, 28 Oct 2024 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730120475; cv=none; b=eGEfme8TfHiwLtELVdLV/ywa82oyQ7JEla2XLgq2VMeGUjj8NBISkwBLsGUBaETXR/PVEsOZONm2BSAUsMQ/vZ1Epy1Fv15u9zmqBLV3LbJITe4LStsguLumx91ZOH2VKiamRL0XiS0pNtBbM9SJIyTbi/VtFJ0zOoTM222CCRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730120475; c=relaxed/simple;
	bh=3hHHwP2n7PCvFaIxNa7UQkkvkGOEnOK62fpL8yZ5+G4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=umnBds1T1+X3Un74hQ6SHE++hV06HUdMHMn8NiHy2sTh7DRa8FKFhShh++Ri76bSE3NE/s801fgPykKvGle+cl7bpJo9O54+RpFmchqB4qdseX6Nb9IuY0rQcGdDlFxqTIL/UBEwQE6cnmrE4CvAkfMsDz0IvWnMJTIsS/A7xMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DT5jDkNo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I8qbRfXc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 28 Oct 2024 13:01:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730120471;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=3fUlt5XcT83BeQWbDAkXrniPfir179H8/qNvazSBwAY=;
	b=DT5jDkNoGmKVcnigDI8bSgyicWxgUg3Lc9j50eis8XosXHVKwmRptx29g2eJJYxgij3r+j
	fffTq52TbymFSkg0udmFBznthH0Nb16P2LYbtMX2tobzU1X8fBUTHfnoRAnitQyRQ3dGWS
	12/TY9eOyAX3xjUUMhSDxkfRCl56bxHw4wjYfifLj2W/WMrR71pEn1SnjmdcLplVwoU++H
	7x+9Uwbpe0P/B9iEMixkUT1hhjmY9gwKsnlNf14KUksiTlKRQYS7JHMyM9MIIhVD3cJevW
	hCmGC9GWUfbdeVMbm4Hsfe3W8ZnvsHjOzRZace8RVOrVCbVv3o7L9i50XnhNKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730120471;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=3fUlt5XcT83BeQWbDAkXrniPfir179H8/qNvazSBwAY=;
	b=I8qbRfXcwkNKGFSu8Zj+8HglEUNvmobPJMP+s4YT6kKoCrRvDn1CEjHPb/1sO+9yAHlusf
	XiyTyLRV2SWHcQBA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Fix formatting of cpuid_bits[] in scattered.c
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173012046924.1442.11993258877519479480.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     e6e6a303f83d1dcd32dcd1ab0d04ef5b7b7be646
Gitweb:        https://git.kernel.org/tip/e6e6a303f83d1dcd32dcd1ab0d04ef5b7b7be646
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 28 Oct 2024 13:51:05 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 28 Oct 2024 13:51:05 +01:00

x86/cpu: Fix formatting of cpuid_bits[] in scattered.c

Realign initializers to accomodate for longer X86_FEATURE define names.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/scattered.c | 58 ++++++++++++++++----------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 1e54332..16f3ca3 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -24,36 +24,36 @@ struct cpuid_bit {
  * levels are different and there is a separate entry for each.
  */
 static const struct cpuid_bit cpuid_bits[] = {
-	{ X86_FEATURE_APERFMPERF,       CPUID_ECX,  0, 0x00000006, 0 },
-	{ X86_FEATURE_EPB,		CPUID_ECX,  3, 0x00000006, 0 },
-	{ X86_FEATURE_INTEL_PPIN,	CPUID_EBX,  0, 0x00000007, 1 },
-	{ X86_FEATURE_RRSBA_CTRL,	CPUID_EDX,  2, 0x00000007, 2 },
-	{ X86_FEATURE_BHI_CTRL,		CPUID_EDX,  4, 0x00000007, 2 },
-	{ X86_FEATURE_CQM_LLC,		CPUID_EDX,  1, 0x0000000f, 0 },
-	{ X86_FEATURE_CQM_OCCUP_LLC,	CPUID_EDX,  0, 0x0000000f, 1 },
-	{ X86_FEATURE_CQM_MBM_TOTAL,	CPUID_EDX,  1, 0x0000000f, 1 },
-	{ X86_FEATURE_CQM_MBM_LOCAL,	CPUID_EDX,  2, 0x0000000f, 1 },
-	{ X86_FEATURE_CAT_L3,		CPUID_EBX,  1, 0x00000010, 0 },
-	{ X86_FEATURE_CAT_L2,		CPUID_EBX,  2, 0x00000010, 0 },
-	{ X86_FEATURE_CDP_L3,		CPUID_ECX,  2, 0x00000010, 1 },
-	{ X86_FEATURE_CDP_L2,		CPUID_ECX,  2, 0x00000010, 2 },
-	{ X86_FEATURE_MBA,		CPUID_EBX,  3, 0x00000010, 0 },
-	{ X86_FEATURE_PER_THREAD_MBA,	CPUID_ECX,  0, 0x00000010, 3 },
-	{ X86_FEATURE_SGX1,		CPUID_EAX,  0, 0x00000012, 0 },
-	{ X86_FEATURE_SGX2,		CPUID_EAX,  1, 0x00000012, 0 },
-	{ X86_FEATURE_SGX_EDECCSSA,	CPUID_EAX, 11, 0x00000012, 0 },
-	{ X86_FEATURE_HW_PSTATE,	CPUID_EDX,  7, 0x80000007, 0 },
-	{ X86_FEATURE_CPB,		CPUID_EDX,  9, 0x80000007, 0 },
-	{ X86_FEATURE_PROC_FEEDBACK,    CPUID_EDX, 11, 0x80000007, 0 },
-	{ X86_FEATURE_AMD_FAST_CPPC,	CPUID_EDX, 15, 0x80000007, 0 },
-	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
-	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
-	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
-	{ X86_FEATURE_AMD_WORKLOAD_CLASS,	CPUID_EAX,  22, 0x80000021, 0 },
-	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
-	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
+	{ X86_FEATURE_APERFMPERF,		CPUID_ECX,  0, 0x00000006, 0 },
+	{ X86_FEATURE_EPB,			CPUID_ECX,  3, 0x00000006, 0 },
+	{ X86_FEATURE_INTEL_PPIN,		CPUID_EBX,  0, 0x00000007, 1 },
+	{ X86_FEATURE_RRSBA_CTRL,		CPUID_EDX,  2, 0x00000007, 2 },
+	{ X86_FEATURE_BHI_CTRL,			CPUID_EDX,  4, 0x00000007, 2 },
+	{ X86_FEATURE_CQM_LLC,			CPUID_EDX,  1, 0x0000000f, 0 },
+	{ X86_FEATURE_CQM_OCCUP_LLC,		CPUID_EDX,  0, 0x0000000f, 1 },
+	{ X86_FEATURE_CQM_MBM_TOTAL,		CPUID_EDX,  1, 0x0000000f, 1 },
+	{ X86_FEATURE_CQM_MBM_LOCAL,		CPUID_EDX,  2, 0x0000000f, 1 },
+	{ X86_FEATURE_CAT_L3,			CPUID_EBX,  1, 0x00000010, 0 },
+	{ X86_FEATURE_CAT_L2,			CPUID_EBX,  2, 0x00000010, 0 },
+	{ X86_FEATURE_CDP_L3,			CPUID_ECX,  2, 0x00000010, 1 },
+	{ X86_FEATURE_CDP_L2,			CPUID_ECX,  2, 0x00000010, 2 },
+	{ X86_FEATURE_MBA,			CPUID_EBX,  3, 0x00000010, 0 },
+	{ X86_FEATURE_PER_THREAD_MBA,		CPUID_ECX,  0, 0x00000010, 3 },
+	{ X86_FEATURE_SGX1,			CPUID_EAX,  0, 0x00000012, 0 },
+	{ X86_FEATURE_SGX2,			CPUID_EAX,  1, 0x00000012, 0 },
+	{ X86_FEATURE_SGX_EDECCSSA,		CPUID_EAX, 11, 0x00000012, 0 },
+	{ X86_FEATURE_HW_PSTATE,		CPUID_EDX,  7, 0x80000007, 0 },
+	{ X86_FEATURE_CPB,			CPUID_EDX,  9, 0x80000007, 0 },
+	{ X86_FEATURE_PROC_FEEDBACK,		CPUID_EDX, 11, 0x80000007, 0 },
+	{ X86_FEATURE_AMD_FAST_CPPC,		CPUID_EDX, 15, 0x80000007, 0 },
+	{ X86_FEATURE_MBA,			CPUID_EBX,  6, 0x80000008, 0 },
+	{ X86_FEATURE_SMBA,			CPUID_EBX,  2, 0x80000020, 0 },
+	{ X86_FEATURE_BMEC,			CPUID_EBX,  3, 0x80000020, 0 },
+	{ X86_FEATURE_AMD_WORKLOAD_CLASS,	CPUID_EAX, 22, 0x80000021, 0 },
+	{ X86_FEATURE_PERFMON_V2,		CPUID_EAX,  0, 0x80000022, 0 },
+	{ X86_FEATURE_AMD_LBR_V2,		CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
-	{ X86_FEATURE_AMD_HETEROGENEOUS_CORES,	CPUID_EAX,  30, 0x80000026, 0 },
+	{ X86_FEATURE_AMD_HETEROGENEOUS_CORES,	CPUID_EAX, 30, 0x80000026, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 

