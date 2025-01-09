Return-Path: <linux-tip-commits+bounces-3190-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 288A9A071D4
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 10:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B4F1883422
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 09:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1522163AE;
	Thu,  9 Jan 2025 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R6pV+6se";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fxb0BeuA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A82521519C;
	Thu,  9 Jan 2025 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736415830; cv=none; b=fOjFYkWhjpXYdQdyOWq9EwZ0a10Q+AKcSTtZHDkR8FB1ZAECpy76WQFBD4LX+Oj3Jum6HFweanPIwa0x/EnGrGivEgErdEuXUvBEbU0EzQlEYnZ5IelNeroE7y4YxQpK4nVsJHyq/XQC71IWlgHE24yMkHi9f1oaThWWeeQAkTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736415830; c=relaxed/simple;
	bh=vna/YPSDJbSnqTMjD3BMvXdSpI1KfAu63r4YXgW4XlU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=R9TWW7t1ZqgPUul4Z70I6g95Pd9lj7p6deoxztjfcOwZkuxm/dGingAl2HE4AY2k95fmDMX3rygxpnM3znMGgQZJO/AvOKd1UWgJOA1MGvNl9y94bOlNORWrh/m9HuAtbz6C3IMObr3HE7TafH6dQY+Tr3TdGUkFncHFWdeFggo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R6pV+6se; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fxb0BeuA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 09 Jan 2025 09:43:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736415827;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRmAUfChdyOykAXClU+kw70Oij30B4Fqgo0HIdrONFY=;
	b=R6pV+6seB+DOj5wk6EjWrkpmwFe0c+Sf7rLpgktapCq1piJlKTsPxG35t1yayyLU5H0Erk
	wV7IH8hxIxKvT+uoPk06fhmbk/jt4g5c/tPvPcFAHjXaUTPnHopU+BxtoY3ekA4/i9h5gf
	6E0jg8lcA4IqUuyuvbaSSXkWzRTCAdccVTvQEET0GvM8H/CpP6p+wgC5oqtHN1E5dj5OCh
	h21ULBP3gyLZLkqAcG7NAjme4dyynpLM4aZdaMizDrXVhLjs1ues1pyHUbaYDR3DUEo273
	WiqV8NPAE22QBOes/wb/pZmKGVzly8C8FwSQD4vdFPdwnF6RR9Jr8sYAUxzOSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736415827;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRmAUfChdyOykAXClU+kw70Oij30B4Fqgo0HIdrONFY=;
	b=fxb0BeuAP/plpUyDl/jj1jHFVE7YW9JhhtnHNxw92e9QnrJLcY3jytz8uidDPK9rco/E/j
	R0Z6zA+qks+KsBBw==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Prevent GUEST_TSC_FREQ MSR interception for
 Secure TSC enabled guests
Cc: Nikunj A Dadhania <nikunj@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250106124633.1418972-8-nikunj@amd.com>
References: <20250106124633.1418972-8-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173641582648.399.3076847631804482712.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     38cc6495cdec18a448b9e1de45fedce4118833a2
Gitweb:        https://git.kernel.org/tip/38cc6495cdec18a448b9e1de45fedce4118833a2
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Mon, 06 Jan 2025 18:16:27 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 07 Jan 2025 21:26:19 +01:00

x86/sev: Prevent GUEST_TSC_FREQ MSR interception for Secure TSC enabled guests

The hypervisor should not be intercepting GUEST_TSC_FREQ MSR(0xcOO10134)
when Secure TSC is enabled. A #VC exception will be generated otherwise. If
this should occur and Secure TSC is enabled, terminate guest execution.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20250106124633.1418972-8-nikunj@amd.com
---
 arch/x86/coco/sev/core.c         | 10 +++++++++-
 arch/x86/include/asm/msr-index.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index cd5b9b7..106bded 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1436,13 +1436,20 @@ static enum es_result __vc_handle_msr_caa(struct pt_regs *regs, bool write)
 /*
  * TSC related accesses should not exit to the hypervisor when a guest is
  * executing with Secure TSC enabled, so special handling is required for
- * accesses of MSR_IA32_TSC.
+ * accesses of MSR_IA32_TSC and MSR_AMD64_GUEST_TSC_FREQ.
  */
 static enum es_result __vc_handle_secure_tsc_msrs(struct pt_regs *regs, bool write)
 {
 	u64 tsc;
 
 	/*
+	 * GUEST_TSC_FREQ should not be intercepted when Secure TSC is enabled.
+	 * Terminate the SNP guest when the interception is enabled.
+	 */
+	if (regs->cx == MSR_AMD64_GUEST_TSC_FREQ)
+		return ES_VMM_ERROR;
+
+	/*
 	 * Writes: Writing to MSR_IA32_TSC can cause subsequent reads of the TSC
 	 *         to return undefined values, so ignore all writes.
 	 *
@@ -1474,6 +1481,7 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	case MSR_SVSM_CAA:
 		return __vc_handle_msr_caa(regs, write);
 	case MSR_IA32_TSC:
+	case MSR_AMD64_GUEST_TSC_FREQ:
 		if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
 			return __vc_handle_secure_tsc_msrs(regs, write);
 		else
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3f3e2bc..9a71880 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -608,6 +608,7 @@
 #define MSR_AMD_PERF_CTL		0xc0010062
 #define MSR_AMD_PERF_STATUS		0xc0010063
 #define MSR_AMD_PSTATE_DEF_BASE		0xc0010064
+#define MSR_AMD64_GUEST_TSC_FREQ	0xc0010134
 #define MSR_AMD64_OSVW_ID_LENGTH	0xc0010140
 #define MSR_AMD64_OSVW_STATUS		0xc0010141
 #define MSR_AMD_PPIN_CTL		0xc00102f0

