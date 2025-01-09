Return-Path: <linux-tip-commits+bounces-3191-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1254EA071D6
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 10:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B6C162DDA
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 09:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15145215769;
	Thu,  9 Jan 2025 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jWwdX1Q7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kuarpcqK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E2B2163A8;
	Thu,  9 Jan 2025 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736415832; cv=none; b=leDP2yxYV0s1TWUgYDMKFHjYaAHtDcD2IpZqNya/+98DKUr1DDnye1LaJ3D0C5C5L6fd8TT/eOnfcc57ft2M2EQAeNgODDmDOYeDVN3/giLr+wrlmYycuhQJBUBM10C/PYU+wkunHhISXb5Tyaefd5pJeJBEUJFEmKSTd3sZznM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736415832; c=relaxed/simple;
	bh=d5vgFUNlc9SjsSgbEH3pbgB/M+TltTL9x5lBqJEvr0c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sdexebfoKMhATdT9f+1CUH+GnBke2puVrjcQzknTvqAIRPHQ0TPnQUxbt9ETIxob5N0CL6on/fn0oyU6W7SS+P9jSpBK/4YaZrMBJqVE+HxnoeGUkPc/nha661ulzpHFg60fd9rFyGM0RWzSCyZCA8ULiqhWviYw3NU14H0FJ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jWwdX1Q7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kuarpcqK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 09 Jan 2025 09:43:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736415827;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6PORUf4CEm5lCENhPhPjC1Oxncw7Yn9AODhq4EaIT8=;
	b=jWwdX1Q7zhjQ99ln1hgShUoJp9AK720K9Yl39NL0TcdvYOqUHhxfkcDc2fS0VDIcki95RU
	7laonjrOWfhB8jhDWRgR73k73LnBw9IwE3dUuuqmF27wyoNkKadC55PIYrcJb/pp5U3Ztd
	GrwhpGnCtzf7cKCWF+7N/Ct1ra/WgO6qis5ioj53BQ5CFdDc/wLTywapuzcscSO1nvUQyy
	TvrrzeoKNYmRnhsDhEhpMlNK962qIwxj0xvS2Od0LE+R90aGueMsPP5eqjaFmJyonli02C
	2uCTrzjlgdJ6bZ2W/YDAVoOfXzvXf9XpiFUF+h6uOPC5AFqSZwBbDH5D/j/JRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736415827;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6PORUf4CEm5lCENhPhPjC1Oxncw7Yn9AODhq4EaIT8=;
	b=kuarpcqK54aYm7gqnlqh/+Ac40iZ+SGQoVsenBlLhlyJEgWt9crUIb3ZRhmYDS3WkGJwft
	Gz9PLlBetgHNNHAA==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] x86/sev: Change TSC MSR behavior for Secure TSC enabled guests
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Nikunj A Dadhania <nikunj@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250106124633.1418972-7-nikunj@amd.com>
References: <20250106124633.1418972-7-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173641582702.399.10966740204572923301.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     0f0502b8865c0a4c402e73aeb0fb406acc19d0d2
Gitweb:        https://git.kernel.org/tip/0f0502b8865c0a4c402e73aeb0fb406acc19d0d2
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Mon, 06 Jan 2025 18:16:26 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 07 Jan 2025 21:26:06 +01:00

x86/sev: Change TSC MSR behavior for Secure TSC enabled guests

Secure TSC enabled guests should not write to the MSR_IA32_TSC (0x10) register
as the subsequent TSC value reads are undefined. On AMD, MSR_IA32_TSC is
intercepted by the hypervisor by default. MSR_IA32_TSC read/write accesses
should not exit to the hypervisor for such guests.

Accesses to MSR_IA32_TSC need special handling in the #VC handler for the
guests with Secure TSC enabled. Writes to MSR_IA32_TSC should be ignored and
flagged once with a warning, and reads of MSR_IA32_TSC should return the
result of the RDTSC instruction.

  [ bp: Massage commit message. ]

Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20250106124633.1418972-7-nikunj@amd.com
---
 arch/x86/coco/sev/core.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 7458805..cd5b9b7 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1433,6 +1433,34 @@ static enum es_result __vc_handle_msr_caa(struct pt_regs *regs, bool write)
 	return ES_OK;
 }
 
+/*
+ * TSC related accesses should not exit to the hypervisor when a guest is
+ * executing with Secure TSC enabled, so special handling is required for
+ * accesses of MSR_IA32_TSC.
+ */
+static enum es_result __vc_handle_secure_tsc_msrs(struct pt_regs *regs, bool write)
+{
+	u64 tsc;
+
+	/*
+	 * Writes: Writing to MSR_IA32_TSC can cause subsequent reads of the TSC
+	 *         to return undefined values, so ignore all writes.
+	 *
+	 * Reads: Reads of MSR_IA32_TSC should return the current TSC value, use
+	 *        the value returned by rdtsc_ordered().
+	 */
+	if (write) {
+		WARN_ONCE(1, "TSC MSR writes are verboten!\n");
+		return ES_OK;
+	}
+
+	tsc = rdtsc_ordered();
+	regs->ax = lower_32_bits(tsc);
+	regs->dx = upper_32_bits(tsc);
+
+	return ES_OK;
+}
+
 static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 {
 	struct pt_regs *regs = ctxt->regs;
@@ -1442,8 +1470,17 @@ static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
 	/* Is it a WRMSR? */
 	write = ctxt->insn.opcode.bytes[1] == 0x30;
 
-	if (regs->cx == MSR_SVSM_CAA)
+	switch (regs->cx) {
+	case MSR_SVSM_CAA:
 		return __vc_handle_msr_caa(regs, write);
+	case MSR_IA32_TSC:
+		if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
+			return __vc_handle_secure_tsc_msrs(regs, write);
+		else
+			break;
+	default:
+		break;
+	}
 
 	ghcb_set_rcx(ghcb, regs->cx);
 	if (write) {

