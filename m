Return-Path: <linux-tip-commits+bounces-4994-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B8AA8A948
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Apr 2025 22:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37FB01900CC1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Apr 2025 20:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDF52550AD;
	Tue, 15 Apr 2025 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zxqJDxuC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GgbF0KK7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A082528EE;
	Tue, 15 Apr 2025 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744748805; cv=none; b=LK2gdSC9yt4L5+gPvvgJvLQ+9aS0GVc0Ml3cNzbsDQYqNTX2kHZNvScSWpe4iAfzRTNBYCXAz4FWj3DeTNhYiV9i//pidCcPdtNwKFsTS5w8oWSVlRrUrmL5pde6QyFPkcKRc/XUISFG2u0/vmxF+fQMC8NUPmXLY6wiAlf8SpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744748805; c=relaxed/simple;
	bh=8hhnhmUT3VkW1ZuweC+yMPUQlXjb/fX0u2z4h3KAHD8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sfpYqNGtJxH0valTjS61iMfmOYVAaoQsfMLH9d/FpgTAR3PqaqbhnTiL9fhHaX5vRdIcnKIr67yzR5U1JSnkGz5gdyCOh0p78ou9/qZEXmC+3jTOh3cFWHmfOzhwy83YD4I5pyhmq1kj0tZ6arQZFRVlCq1Yr/ebUzNoxJfyHLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zxqJDxuC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GgbF0KK7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Apr 2025 20:26:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744748795;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rDJyT+VYsu4Djwx5OQ8zNfMOfolJI2hQhRcGZZxlaic=;
	b=zxqJDxuCXk3CVCk9uXoSkfzvNDqMiBfFgNrUjl17/qcIu31y2N8px4M4Dvax4gohLHqXp7
	yzoWflxyBc7eWotI66/1ilE1QQ3o2I60WUI/Jcy+nCnHi/GReIyN1uhH1I8+QE6OWegHEM
	Da/pBJSqREOGqqz5v9mOO7iYLzbnlnxwu9x6LckXVXfnhHY49KCJw0Z14Gv76CErWj8Igr
	fwTxN9OilrvcaFmTy+Xxc2HQhTSspNvar7Az2NIxMMF3MuFr6zJWFGjR6pj0ftu7Ov1prV
	eQKIRuceeeN2Dv+IK4cECe3nRyoYgEKoUXcmQRBEOGPRBDl9N1rswnJSZEhHEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744748795;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rDJyT+VYsu4Djwx5OQ8zNfMOfolJI2hQhRcGZZxlaic=;
	b=GgbF0KK7H3QWx5bTG0sNu/yJpXjkIdV3Vjb3fWlH8+khq+Rl7xsKcqMo9GfAleOZ6AWBIg
	FoQEt3wUdJys2HAw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpufeatures: Clean up formatting
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, "Xin Li (Intel)" <xin@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250415175410.2944032-2-xin@zytor.com>
References: <20250415175410.2944032-2-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174474879492.31282.7345473435238058953.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     282cc5b6762310a73255c6dd1d79de1609042eeb
Gitweb:        https://git.kernel.org/tip/282cc5b6762310a73255c6dd1d79de1609042eeb
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 15 Apr 2025 10:54:08 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 15 Apr 2025 21:44:27 +02:00

x86/cpufeatures: Clean up formatting

It is a special file with special formatting so remove one whitespace
damage and format newer defines like the rest.

No functional changes.

 [ Xin: Do the same to tools/arch/x86/include/asm/cpufeatures.h. ]

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250415175410.2944032-2-xin@zytor.com
---
 arch/x86/include/asm/cpufeatures.h       | 20 ++++++++++----------
 tools/arch/x86/include/asm/cpufeatures.h | 18 ++++++++++--------
 2 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index e8f8d43..60b4a4c 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -477,10 +477,10 @@
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
-#define X86_FEATURE_AMD_FAST_CPPC	(21*32 + 5) /* Fast CPPC */
-#define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32 + 6) /* Heterogeneous Core Topology */
-#define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32 + 7) /* Workload Classification */
-#define X86_FEATURE_PREFER_YMM		(21*32 + 8) /* Avoid ZMM registers due to downclocking */
+#define X86_FEATURE_AMD_FAST_CPPC	(21*32+ 5) /* Fast CPPC */
+#define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32+ 6) /* Heterogeneous Core Topology */
+#define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32+ 7) /* Workload Classification */
+#define X86_FEATURE_PREFER_YMM		(21*32+ 8) /* Avoid ZMM registers due to downclocking */
 
 /*
  * BUG word(s)
@@ -527,10 +527,10 @@
 #define X86_BUG_TDX_PW_MCE		X86_BUG(31) /* "tdx_pw_mce" CPU may incur #MC if non-TD software does partial write to TDX private memory */
 
 /* BUG word 2 */
-#define X86_BUG_SRSO			X86_BUG(1*32 + 0) /* "srso" AMD SRSO bug */
-#define X86_BUG_DIV0			X86_BUG(1*32 + 1) /* "div0" AMD DIV0 speculation bug */
-#define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* "rfds" CPU is vulnerable to Register File Data Sampling */
-#define X86_BUG_BHI			X86_BUG(1*32 + 3) /* "bhi" CPU is affected by Branch History Injection */
-#define X86_BUG_IBPB_NO_RET	   	X86_BUG(1*32 + 4) /* "ibpb_no_ret" IBPB omits return target predictions */
-#define X86_BUG_SPECTRE_V2_USER		X86_BUG(1*32 + 5) /* "spectre_v2_user" CPU is affected by Spectre variant 2 attack between user processes */
+#define X86_BUG_SRSO			X86_BUG( 1*32+ 0) /* "srso" AMD SRSO bug */
+#define X86_BUG_DIV0			X86_BUG( 1*32+ 1) /* "div0" AMD DIV0 speculation bug */
+#define X86_BUG_RFDS			X86_BUG( 1*32+ 2) /* "rfds" CPU is vulnerable to Register File Data Sampling */
+#define X86_BUG_BHI			X86_BUG( 1*32+ 3) /* "bhi" CPU is affected by Branch History Injection */
+#define X86_BUG_IBPB_NO_RET		X86_BUG( 1*32+ 4) /* "ibpb_no_ret" IBPB omits return target predictions */
+#define X86_BUG_SPECTRE_V2_USER		X86_BUG( 1*32+ 5) /* "spectre_v2_user" CPU is affected by Spectre variant 2 attack between user processes */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index e88500d..2e219be 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -467,9 +467,10 @@
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
-#define X86_FEATURE_AMD_FAST_CPPC	(21*32 + 5) /* Fast CPPC */
-#define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32 + 6) /* Heterogeneous Core Topology */
-#define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32 + 7) /* Workload Classification */
+#define X86_FEATURE_AMD_FAST_CPPC	(21*32+ 5) /* Fast CPPC */
+#define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32+ 6) /* Heterogeneous Core Topology */
+#define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32+ 7) /* Workload Classification */
+#define X86_FEATURE_PREFER_YMM		(21*32+ 8) /* Avoid ZMM registers due to downclocking */
 
 /*
  * BUG word(s)
@@ -516,9 +517,10 @@
 #define X86_BUG_TDX_PW_MCE		X86_BUG(31) /* "tdx_pw_mce" CPU may incur #MC if non-TD software does partial write to TDX private memory */
 
 /* BUG word 2 */
-#define X86_BUG_SRSO			X86_BUG(1*32 + 0) /* "srso" AMD SRSO bug */
-#define X86_BUG_DIV0			X86_BUG(1*32 + 1) /* "div0" AMD DIV0 speculation bug */
-#define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* "rfds" CPU is vulnerable to Register File Data Sampling */
-#define X86_BUG_BHI			X86_BUG(1*32 + 3) /* "bhi" CPU is affected by Branch History Injection */
-#define X86_BUG_IBPB_NO_RET	   	X86_BUG(1*32 + 4) /* "ibpb_no_ret" IBPB omits return target predictions */
+#define X86_BUG_SRSO			X86_BUG( 1*32+ 0) /* "srso" AMD SRSO bug */
+#define X86_BUG_DIV0			X86_BUG( 1*32+ 1) /* "div0" AMD DIV0 speculation bug */
+#define X86_BUG_RFDS			X86_BUG( 1*32+ 2) /* "rfds" CPU is vulnerable to Register File Data Sampling */
+#define X86_BUG_BHI			X86_BUG( 1*32+ 3) /* "bhi" CPU is affected by Branch History Injection */
+#define X86_BUG_IBPB_NO_RET		X86_BUG( 1*32+ 4) /* "ibpb_no_ret" IBPB omits return target predictions */
+#define X86_BUG_SPECTRE_V2_USER		X86_BUG( 1*32+ 5) /* "spectre_v2_user" CPU is affected by Spectre variant 2 attack between user processes */
 #endif /* _ASM_X86_CPUFEATURES_H */

