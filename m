Return-Path: <linux-tip-commits+bounces-3076-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883339F2075
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Dec 2024 19:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3CF18817D2
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Dec 2024 18:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C0F1B6CEB;
	Sat, 14 Dec 2024 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qNoSqXGO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/BQCogF2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC631B0F0F;
	Sat, 14 Dec 2024 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734202078; cv=none; b=cXfhue7LlVfYd2b70oCp6aZGf0jgcoEjq2YRRcAPzjiuLb55Kl6yIp+sHxoIUgVMqvU2PTu5DmEX3coGM0SQ7Pl11skTZUB4I7sHCq5cl4JEvq5f3uPkkx/8fDIdvaW6UtHOABHXCzKDh72Ygrc/hOOdxVKjBrGTJL11sQ35u8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734202078; c=relaxed/simple;
	bh=biTFHJ4VSieUvww3Z1neA4Eqp/YFVe2DlmAHMdfZdDY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dA5zYsA8eNX+PNgi5WJ1z2RMP1OzzZ7nwBJnbghjrQKbvNZC98Cp/733TchoeffrQPEpwxkxMOmctM7Cja03FGnl6u3JOCJNWKahkL5E2bPowl7pXLwzj7FT1aDSZYoDUG9iH+iF1I+ig1Z+RhpqO8vUWxwnuBeQrXjuGIPnneA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qNoSqXGO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/BQCogF2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 14 Dec 2024 18:47:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734202074;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aBYblNTyaJRVI6p5iKBLVhedjPUFd7nPQL89TFYR2ZE=;
	b=qNoSqXGO6NIKKfNAG2LjoYr3/A8KtNkE4pI3AIG8sDAApT6ksLQK1Hpy5F3t0uba2MlD72
	6Um8Z3V+uVjUwmxRZ7L04I5o2UF9OPZXdDgw4M8anfVRwXPvt95xO1cKbTa5ONz2R05SXK
	dhTz+9NzKP5n6da2yOqY1U7ntSsSX62wMEd4NYd64tXwvWPkuUXeso0qCoWTKjUv3RvFK+
	IHFXZS+z5In2A29TJOxt9sGHzcFet6/hlNKBOCQZTELyDQA2iiHLvgzZ25jsVblT6uMTs3
	ppXw/nEz26KvPvWHjhnYA2wmW/jY8ypQnS8EShyQTNi35ts75mKZ8ubrtEcpKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734202074;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aBYblNTyaJRVI6p5iKBLVhedjPUFd7nPQL89TFYR2ZE=;
	b=/BQCogF2508NNXh/sV5LVhpwAyav6Z2G+N2PuiB+nFfwDxTBzCUtQYOk6a1FqLFXaiv/UZ
	1BQRWxafH9CgBuCA==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Add support for the RMPREAD instruction
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Nikunj A Dadhania <nikunj@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C72c734ac8b324bbc0c839b2c093a11af4a8881fa=2E17331?=
 =?utf-8?q?72653=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C72c734ac8b324bbc0c839b2c093a11af4a8881fa=2E173317?=
 =?utf-8?q?2653=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173420207314.412.7061107224776583821.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     0cbc0258415814c86eb6db50237ae3d90fbf3b3d
Gitweb:        https://git.kernel.org/tip/0cbc0258415814c86eb6db50237ae3d90fbf3b3d
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 02 Dec 2024 14:50:47 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 14 Dec 2024 01:02:30 +01:00

x86/sev: Add support for the RMPREAD instruction

The RMPREAD instruction returns an architecture defined format of an
RMP table entry. This is the preferred method for examining RMP entries.

The instruction is advertised in CPUID 0x8000001f_EAX[21]. Use this
instruction when available.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Reviewed-by: Ashish Kalra <ashish.kalra@amd.com>
Link: https://lore.kernel.org/r/72c734ac8b324bbc0c839b2c093a11af4a8881fa.1733172653.git.thomas.lendacky@amd.com
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/virt/svm/sev.c            | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 17b6590..5535edc 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -451,6 +451,7 @@
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* AMD hardware-enforced cache coherency */
 #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" AMD SEV-ES full debug state swap support */
+#define X86_FEATURE_RMPREAD		(19*32+21) /* RMPREAD instruction */
 #define X86_FEATURE_SVSM		(19*32+28) /* "svsm" SVSM present */
 
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index cf64e93..18191cb 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -306,6 +306,18 @@ static int get_rmpentry(u64 pfn, struct rmpentry *e)
 {
 	struct rmpentry_raw *e_raw;
 
+	if (cpu_feature_enabled(X86_FEATURE_RMPREAD)) {
+		int ret;
+
+		/* Binutils version 2.44 supports the RMPREAD mnemonic. */
+		asm volatile(".byte 0xf2, 0x0f, 0x01, 0xfd"
+			     : "=a" (ret)
+			     : "a" (pfn << PAGE_SHIFT), "c" (e)
+			     : "memory", "cc");
+
+		return ret;
+	}
+
 	e_raw = get_raw_rmpentry(pfn);
 	if (IS_ERR(e_raw))
 		return PTR_ERR(e_raw);

