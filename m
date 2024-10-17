Return-Path: <linux-tip-commits+bounces-2496-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574769A218C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 13:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4641C21020
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 11:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FC31DC1B2;
	Thu, 17 Oct 2024 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T+OpeJlV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OxMvhLmg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0557E1DBB0C;
	Thu, 17 Oct 2024 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166193; cv=none; b=fheWwudwOU/aOkCFrLe7ImAhrqInjSMV+2O0ijLfL5gIa1nKphQleqi5zV168m8+I3azT1jVBq32BM9bFg1TMXlNLd1t/s4fE2+tPLOFwZ02/AZRtWWMvpTFXvgF8n5sAX4RSkwta26Raqvld78v7xFsJzSoRK/6Brno5rD84Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166193; c=relaxed/simple;
	bh=dG+US6b2B8ocGPJtsOn4zfkxxqzfqNh0JlrWQltji0o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MysR02lZSqJu3W7vmgo5tFK1l33a/EiwvLrHKKnbq2uhX64QqqMWGF31uU9ykD22DXKBxAq4iIta2A9S3h8EeUMJ0OMAX6E5eQABH3qzhsU3vXsz9zd88+TPaUMev7MPy9bqBIItqWZnSiPEZO5iTKEqmq5p8w3O0rRoZCnqGu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T+OpeJlV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OxMvhLmg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Oct 2024 11:56:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729166189;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xPek6PBVuwSBDJCpykQBvX10926kpcUvkzjUDIP0SKg=;
	b=T+OpeJlVwdDlTnHRXuyd57qfP6Pno346Fa7o2aB4EG7O7E/mSX0YLXZzQNfSv2wFnlUhL5
	/dmIZcFBnsFvb9kPHDvbQYY0wihRQz/6+I4FSuEPbo+AzC/tWDwElfmGwb2U6rHgT3hrck
	rJ97HQlwc1WmKyCAQ294dGLo1Ou7GSE/7hvBz9j+OoTx6hu5go3NuzICKiPljDtRKO1UbX
	RLA7sicXyT/pw3g29j2oDOtT5YuttZ475iWtS2jm/4ljFH0zEjlUh657GkskQqYlt07u0z
	t1VD/wZp2ZWkvpI/n9A/TZuWkgzpqiolkANvCfZTWg+0YztbA5bcHTwRrSnydQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729166189;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xPek6PBVuwSBDJCpykQBvX10926kpcUvkzjUDIP0SKg=;
	b=OxMvhLmgxfW+i1j9OWB922pf/Qars7KfuCZZuj1pZ+V1bKMD5n8gIfrgGkfBB/8+nTsE0s
	dB4TiqnWAFfHYICw==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Cache the secrets page address
Cc: Nikunj A Dadhania <nikunj@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241009092850.197575-4-nikunj@amd.com>
References: <20241009092850.197575-4-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172916618880.1442.12413148301355675953.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     6068754a4fff67654e87b37cdecd5275a372110f
Gitweb:        https://git.kernel.org/tip/6068754a4fff67654e87b37cdecd5275a372110f
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Wed, 09 Oct 2024 14:58:34 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 16 Oct 2024 18:24:51 +02:00

x86/sev: Cache the secrets page address

Instead of calling get_secrets_page(), which parses the CC blob every time
to get the secrets page physical address (secrets_pa), save the secrets
page physical address during snp_init() from the CC blob. Since
get_secrets_page() is no longer used, remove the function.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20241009092850.197575-4-nikunj@amd.com
---
 arch/x86/coco/sev/core.c | 51 ++++++++-------------------------------
 1 file changed, 11 insertions(+), 40 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index ff19e80..af50a38 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -92,6 +92,9 @@ static struct ghcb *boot_ghcb __section(".data");
 /* Bitmap of SEV features supported by the hypervisor */
 static u64 sev_hv_features __ro_after_init;
 
+/* Secrets page physical address from the CC blob */
+static u64 secrets_pa __ro_after_init;
+
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
 	struct ghcb ghcb_page;
@@ -695,45 +698,13 @@ void noinstr __sev_es_nmi_complete(void)
 	__sev_put_ghcb(&state);
 }
 
-static u64 __init get_secrets_page(void)
-{
-	u64 pa_data = boot_params.cc_blob_address;
-	struct cc_blob_sev_info info;
-	void *map;
-
-	/*
-	 * The CC blob contains the address of the secrets page, check if the
-	 * blob is present.
-	 */
-	if (!pa_data)
-		return 0;
-
-	map = early_memremap(pa_data, sizeof(info));
-	if (!map) {
-		pr_err("Unable to locate SNP secrets page: failed to map the Confidential Computing blob.\n");
-		return 0;
-	}
-	memcpy(&info, map, sizeof(info));
-	early_memunmap(map, sizeof(info));
-
-	/* smoke-test the secrets page passed */
-	if (!info.secrets_phys || info.secrets_len != PAGE_SIZE)
-		return 0;
-
-	return info.secrets_phys;
-}
-
 static u64 __init get_snp_jump_table_addr(void)
 {
 	struct snp_secrets_page *secrets;
 	void __iomem *mem;
-	u64 pa, addr;
-
-	pa = get_secrets_page();
-	if (!pa)
-		return 0;
+	u64 addr;
 
-	mem = ioremap_encrypted(pa, PAGE_SIZE);
+	mem = ioremap_encrypted(secrets_pa, PAGE_SIZE);
 	if (!mem) {
 		pr_err("Unable to locate AP jump table address: failed to map the SNP secrets page.\n");
 		return 0;
@@ -2273,6 +2244,11 @@ bool __head snp_init(struct boot_params *bp)
 	if (!cc_info)
 		return false;
 
+	if (cc_info->secrets_phys && cc_info->secrets_len == PAGE_SIZE)
+		secrets_pa = cc_info->secrets_phys;
+	else
+		return false;
+
 	setup_cpuid_table(cc_info);
 
 	svsm_setup(cc_info);
@@ -2469,16 +2445,11 @@ static struct platform_device sev_guest_device = {
 static int __init snp_init_platform_device(void)
 {
 	struct sev_guest_platform_data data;
-	u64 gpa;
 
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return -ENODEV;
 
-	gpa = get_secrets_page();
-	if (!gpa)
-		return -ENODEV;
-
-	data.secrets_gpa = gpa;
+	data.secrets_gpa = secrets_pa;
 	if (platform_device_add_data(&sev_guest_device, &data, sizeof(data)))
 		return -ENODEV;
 

