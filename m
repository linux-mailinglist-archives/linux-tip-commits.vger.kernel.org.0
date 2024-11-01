Return-Path: <linux-tip-commits+bounces-2685-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C715F9B9068
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Nov 2024 12:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34742282A54
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Nov 2024 11:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4926219CC02;
	Fri,  1 Nov 2024 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KJbU8TD1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BzQYZvmw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44B819C54A;
	Fri,  1 Nov 2024 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461270; cv=none; b=CU5GUPBCzmFEbs6M9tp3gWOrt4YTv0/lSH1rx3Di0a32XzcbAJBMx9pqW6XCeS2DF3l5Ht46Yv3B5MR5KsX8g/ZSQigq+EIwCM0Q2VvV7xXhcmYH1tm+M0gxT65VjdFrDpsQuodG0+bHaxJtvlg/joND98PTF7TsS1jb1RrFzfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461270; c=relaxed/simple;
	bh=vkxm2fBl1GHog62Wlvuz3+R/hWIIq9jksqRXHGli5VQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=vEEUXZgDfWOWyIHyE/+Dj4q0TAbAnuN/rYNIfJQohyFbJ1oUBjZu8bY41O+cY+k5YmCnLTXcRu7zfTEZ1Fpl3BXj+X8RtEesik2rznP43FHIcOGiUROmJNfw7hC8aEoPhViChIvrFLhQplMPclfEu8srH0a6d6he1+3rItUlfAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KJbU8TD1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BzQYZvmw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 01 Nov 2024 11:41:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730461266;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uAOKirwBqoz9E2HkaBDpMJLL6m6g1bc26MqyXE+S4VU=;
	b=KJbU8TD1pvc/DiisZ0wYgCVrgKfCi/Ew/CgQ8iKO8z2eQzqCQwxetC4Hocz4//H75TdXnY
	H6Gp7r696AUX7hZ+tLiwJ+HJa1XeJ/V6QTWUVKNvlIcxMP7I6qZUHSUdRkvBOET923qRzC
	g+5qUdZuyMqawkzUozjohygzbohgdZjT7e4U82bBi3UBK/SwrKwmqepoUrRRWRfPGCVYw3
	pyksgmuC7YvMrTRoTQifd2mwXVcmlGJjGt1JYIjtQhgdNn5sq8o5EKFVX0XASbHEa3rVW5
	rqZO7BFMam1w/l2hyibUvXZlxzD795AtKlOsUXNoNY4icKk1LWzvY4RyUytRmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730461266;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uAOKirwBqoz9E2HkaBDpMJLL6m6g1bc26MqyXE+S4VU=;
	b=BzQYZvmwYwX7JC2iqDKMEhNDbsTi0are61UNU3kuOqOZDAOQ7HS2rBXI6zhqWDOb6zlIxc
	8LRhTQ/TXB40YvAA==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/apei: Handle variable SMCA BERT record size
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241022194158.110073-5-avadhut.naik@amd.com>
References: <20241022194158.110073-5-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173046126431.3137.970292408629374702.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     e9876dafa28ebbeead11b6376b1402832d895c85
Gitweb:        https://git.kernel.org/tip/e9876dafa28ebbeead11b6376b1402832d895c85
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 22 Oct 2024 19:36:30 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 31 Oct 2024 10:45:59 +01:00

x86/mce/apei: Handle variable SMCA BERT record size

The ACPI Boot Error Record Table (BERT) is being used by the kernel to report
errors that occurred in a previous boot. On some modern AMD systems, these
very errors within the BERT are reported through the x86 Common Platform Error
Record (CPER) format which consists of one or more Processor Context
Information Structures.

These context structures provide a starting address and represent an x86 MSR
range in which the data constitutes a contiguous set of MSRs starting from,
and including the starting address.

It's common, for AMD systems that implement this behavior, that the MSR range
represents the MCAX register space used for the Scalable MCA feature. The
apei_smca_report_x86_error() function decodes and passes this information
through the MCE notifier chain. However, this function assumes a fixed
register size based on the original HW/FW implementation.

This assumption breaks with the addition of two new MCAX registers viz.
MCA_SYND1 and MCA_SYND2. These registers are added at the end of the MCAX
register space, so they won't be included when decoding the CPER data.

Rework apei_smca_report_x86_error() to support a variable register array size.
This covers any case where the MSR context information starts at the MCAX
address for MCA_STATUS and ends at any other register within the MCAX register
space.

  [ Yazen: Add Avadhut as co-developer for wrapper changes.]
  [ bp: Massage. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Co-developed-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Link: https://lore.kernel.org/r/20241022194158.110073-5-avadhut.naik@amd.com
---
 arch/x86/kernel/cpu/mce/apei.c | 72 ++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 7f582b4..0a89947 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -68,9 +68,9 @@ EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 {
 	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
+	unsigned int cpu, num_regs;
 	bool apicid_found = false;
 	struct mce_hw_err err;
-	unsigned int cpu;
 	struct mce *m;
 
 	if (!boot_cpu_has(X86_FEATURE_SMCA))
@@ -89,16 +89,12 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 		return -EINVAL;
 
 	/*
-	 * The register array size must be large enough to include all the
-	 * SMCA registers which need to be extracted.
-	 *
 	 * The number of registers in the register array is determined by
 	 * Register Array Size/8 as defined in UEFI spec v2.8, sec N.2.4.2.2.
-	 * The register layout is fixed and currently the raw data in the
-	 * register array includes 6 SMCA registers which the kernel can
-	 * extract.
+	 * Sanity-check registers array size.
 	 */
-	if (ctx_info->reg_arr_size < 48)
+	num_regs = ctx_info->reg_arr_size >> 3;
+	if (!num_regs)
 		return -EINVAL;
 
 	for_each_possible_cpu(cpu) {
@@ -117,12 +113,60 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	mce_prep_record_per_cpu(cpu, m);
 
 	m->bank = (ctx_info->msr_addr >> 4) & 0xFF;
-	m->status = *i_mce;
-	m->addr = *(i_mce + 1);
-	m->misc = *(i_mce + 2);
-	/* Skipping MCA_CONFIG */
-	m->ipid = *(i_mce + 4);
-	m->synd = *(i_mce + 5);
+
+	/*
+	 * The SMCA register layout is fixed and includes 16 registers.
+	 * The end of the array may be variable, but the beginning is known.
+	 * Cap the number of registers to expected max (15).
+	 */
+	if (num_regs > 15)
+		num_regs = 15;
+
+	switch (num_regs) {
+	/* MCA_SYND2 */
+	case 15:
+		err.vendor.amd.synd2 = *(i_mce + 14);
+		fallthrough;
+	/* MCA_SYND1 */
+	case 14:
+		err.vendor.amd.synd1 = *(i_mce + 13);
+		fallthrough;
+	/* MCA_MISC4 */
+	case 13:
+	/* MCA_MISC3 */
+	case 12:
+	/* MCA_MISC2 */
+	case 11:
+	/* MCA_MISC1 */
+	case 10:
+	/* MCA_DEADDR */
+	case 9:
+	/* MCA_DESTAT */
+	case 8:
+	/* reserved */
+	case 7:
+	/* MCA_SYND */
+	case 6:
+		m->synd = *(i_mce + 5);
+		fallthrough;
+	/* MCA_IPID */
+	case 5:
+		m->ipid = *(i_mce + 4);
+		fallthrough;
+	/* MCA_CONFIG */
+	case 4:
+	/* MCA_MISC0 */
+	case 3:
+		m->misc = *(i_mce + 2);
+		fallthrough;
+	/* MCA_ADDR */
+	case 2:
+		m->addr = *(i_mce + 1);
+		fallthrough;
+	/* MCA_STATUS */
+	case 1:
+		m->status = *i_mce;
+	}
 
 	mce_log(&err);
 

