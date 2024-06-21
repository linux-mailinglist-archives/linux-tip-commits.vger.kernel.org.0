Return-Path: <linux-tip-commits+bounces-1482-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EAF912B7E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Jun 2024 18:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB5F1C21830
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Jun 2024 16:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD8E15F412;
	Fri, 21 Jun 2024 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VhBftoRS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xDcSbmIX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543FE5D477;
	Fri, 21 Jun 2024 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718987902; cv=none; b=AUxUaVDWNo8zffaKVcG5KqB5Sxvv4kfIxcqXX0sTqc6ZSnJg0mKCrY5U88ei1q89fYwL9dPKbsjMFuL6mIs4GQWEWiRWoRcVRVAF45RfbF1h9k9rs+cbZ7qGZVXj1yxxAjLwR/gODpjD8x+kzOHCdiEMTVO7riZBBixRYtVnS4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718987902; c=relaxed/simple;
	bh=F2Foq8chGaYEKnpLehBWW8K5nNv65nvqwaSSHCLVspo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fUqBFeZQ/V7qkCgY1cFYA9t/aLA3QVVm+RbpMc161pfCWwFott8F9ED6j4tWUzYQr0+PCzI8FpVqZW4X8fUtLvRpWHuenUUcoSrB0tbYuunRmnqHecMhIdKSap4qhFJVGGt+a6oXLBiUy9Yqh+jtp3jsetcDwpEJ7YuDqUoQV/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VhBftoRS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xDcSbmIX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Jun 2024 16:38:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718987898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BkxUbzuXKpxyIC2qihAos29TfQGmeBI3WYAEuLWk8Tg=;
	b=VhBftoRSH+zkNf1kT4GYaXOcXD7x4UO9AAbgTqtZHTA4fsWcOTB3PDdS1noZ8oOmwGCis+
	Q+IzsiLAJu5lFcLPvFmmtJoEOXNj8pkTwW7Db4zVZAcWbxUxGplZldJ6IbqBUHeD5pPasv
	Ha/K8Z2y9VUO6m9VPacRBjF/kI4c+gFLENtjs0tlpKUv0KDpw/zQiqcJLwW168eEkzgjlZ
	6Yhc1R47sAdYvHkWJUiy5UxnBIpLOnr6kbaJYkOdLIpw8cxwhaWdJ3E5uKnFhknB1h42Ei
	fzuJ9iry4G9fhTbc/4g21/nKHwZfI466pf5jQ4GczC/pdDLGv101pMov7VIGIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718987898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BkxUbzuXKpxyIC2qihAos29TfQGmeBI3WYAEuLWk8Tg=;
	b=xDcSbmIXa2r/rCLJQ4LFAbXGdkUIYBCs/kH8cTwbW24xarZNeznD5zxPXMazU4SYvmi4go
	4qUOipkDiYaEGYCQ==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Do RMP memory coverage check after max_pfn
 has been set
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cbec4364c7e34358cc576f01bb197a7796a109169=2E17189?=
 =?utf-8?q?84524=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cbec4364c7e34358cc576f01bb197a7796a109169=2E171898?=
 =?utf-8?q?4524=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171898789757.10875.17817122735030570876.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     6a7d32f3a205f577789f65fe0862eee9bfc12262
Gitweb:        https://git.kernel.org/tip/6a7d32f3a205f577789f65fe0862eee9bfc12262
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Fri, 21 Jun 2024 10:42:05 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 21 Jun 2024 18:20:09 +02:00

x86/sev: Do RMP memory coverage check after max_pfn has been set

The RMP table is probed early in the boot process before max_pfn has been
set, so the logic to check if the RMP covers all of system memory is not
valid.

Move the RMP memory coverage check from snp_probe_rmptable_info() into
snp_rmptable_init(), which is well after max_pfn has been set. Also, fix
the calculation to use PFN_UP instead of PHYS_PFN, in order to compute
the required RMP size properly.

Fixes: 216d106c7ff7 ("x86/sev: Add SEV-SNP host initialization support")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/bec4364c7e34358cc576f01bb197a7796a109169.1718984524.git.thomas.lendacky@amd.com
---
 arch/x86/virt/svm/sev.c | 44 ++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 0ae1053..0ce1776 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -120,7 +120,7 @@ static __init void snp_enable(void *arg)
 
 bool snp_probe_rmptable_info(void)
 {
-	u64 max_rmp_pfn, calc_rmp_sz, rmp_sz, rmp_base, rmp_end;
+	u64 rmp_sz, rmp_base, rmp_end;
 
 	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
 	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
@@ -137,28 +137,11 @@ bool snp_probe_rmptable_info(void)
 
 	rmp_sz = rmp_end - rmp_base + 1;
 
-	/*
-	 * Calculate the amount the memory that must be reserved by the BIOS to
-	 * address the whole RAM, including the bookkeeping area. The RMP itself
-	 * must also be covered.
-	 */
-	max_rmp_pfn = max_pfn;
-	if (PHYS_PFN(rmp_end) > max_pfn)
-		max_rmp_pfn = PHYS_PFN(rmp_end);
-
-	calc_rmp_sz = (max_rmp_pfn << 4) + RMPTABLE_CPU_BOOKKEEPING_SZ;
-
-	if (calc_rmp_sz > rmp_sz) {
-		pr_err("Memory reserved for the RMP table does not cover full system RAM (expected 0x%llx got 0x%llx)\n",
-		       calc_rmp_sz, rmp_sz);
-		return false;
-	}
-
 	probed_rmp_base = rmp_base;
 	probed_rmp_size = rmp_sz;
 
 	pr_info("RMP table physical range [0x%016llx - 0x%016llx]\n",
-		probed_rmp_base, probed_rmp_base + probed_rmp_size - 1);
+		rmp_base, rmp_end);
 
 	return true;
 }
@@ -206,9 +189,8 @@ void __init snp_fixup_e820_tables(void)
  */
 static int __init snp_rmptable_init(void)
 {
+	u64 max_rmp_pfn, calc_rmp_sz, rmptable_size, rmp_end, val;
 	void *rmptable_start;
-	u64 rmptable_size;
-	u64 val;
 
 	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return 0;
@@ -219,10 +201,28 @@ static int __init snp_rmptable_init(void)
 	if (!probed_rmp_size)
 		goto nosnp;
 
+	rmp_end = probed_rmp_base + probed_rmp_size - 1;
+
+	/*
+	 * Calculate the amount the memory that must be reserved by the BIOS to
+	 * address the whole RAM, including the bookkeeping area. The RMP itself
+	 * must also be covered.
+	 */
+	max_rmp_pfn = max_pfn;
+	if (PFN_UP(rmp_end) > max_pfn)
+		max_rmp_pfn = PFN_UP(rmp_end);
+
+	calc_rmp_sz = (max_rmp_pfn << 4) + RMPTABLE_CPU_BOOKKEEPING_SZ;
+	if (calc_rmp_sz > probed_rmp_size) {
+		pr_err("Memory reserved for the RMP table does not cover full system RAM (expected 0x%llx got 0x%llx)\n",
+		       calc_rmp_sz, probed_rmp_size);
+		goto nosnp;
+	}
+
 	rmptable_start = memremap(probed_rmp_base, probed_rmp_size, MEMREMAP_WB);
 	if (!rmptable_start) {
 		pr_err("Failed to map RMP table\n");
-		return 1;
+		goto nosnp;
 	}
 
 	/*

