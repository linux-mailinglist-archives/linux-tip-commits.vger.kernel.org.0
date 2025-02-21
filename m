Return-Path: <linux-tip-commits+bounces-3580-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBD5A3F8F2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 16:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5662119C6D67
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 15:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB801FFC7D;
	Fri, 21 Feb 2025 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mZsTHuXd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FgJbBkTc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76AC217F34;
	Fri, 21 Feb 2025 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151811; cv=none; b=KgpwcOKlvgi1TN88emNOPOYyYXcoL2sQgh4mEopNDmezHESk6KrzNGRqHPUAkKd8kFkywud3Q3vOIr8/4FudtIANhXHZ/R+c5QMrNWYI37eG1kOb2x1m+Tuf7Yas7pqdpAsGuvc3f299T8a5r8d8w+OnawYL7NX9nwLpozg8xNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151811; c=relaxed/simple;
	bh=jNNknyzA5xsv+JSzg7C5RJg8Lmlk/GZH8UWzcVJxZCw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qGN2vDfiQJGsyqMkL9eaBdvae/YHd/xFVirnDU0anrQkGjhXcoysmj2JgQZfiUBGzsxoaBlVNe6H8LyEz+gNTG3kWqyEpp8NqzHjcPTetpwVY2/t2P4rkYvs8cHgt4SDyPcqFjRyV++BgNQ4R9j4C05uzvKM8d1y/myGMfVNiDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mZsTHuXd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FgJbBkTc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 15:30:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740151806;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+AvzJlrTrcFoimByYwFN673GL4l/iR4XV75z8z5fQiA=;
	b=mZsTHuXdVrn6iot88sv7FxKl1T3mDHUlBy3V9gJe4rTLNtR4jB8b/FGxQGv7TEczMQad4J
	zhWJB3H0AavimjwW9I+NHRYbuiB1aZ4hpxM0L3Ks4nbL5G8EMCmAOtEADdccPUE9Al5d9E
	Fgx3bJNcqAnp0Ku0JObjbAQO0W4B8e5xHU3d3x/tOAEO8dsVDhIjZrBBzes5GTbekYQFHI
	6AMDr5w8G4oLEh0LgbaKpOwd3P7rkkA2Eyjde5DPeZIaL4OTzmnFQCgptrTeAXVLQcT7gh
	RLmYmyLlK24Zbh39R9w+mbZQBn1dLdxa7OgqmREMrAvTj++PLbVP7xL4ArU5HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740151806;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+AvzJlrTrcFoimByYwFN673GL4l/iR4XV75z8z5fQiA=;
	b=FgJbBkTc3dWwOas/X4rJ3zSEHnoXsinfobwO3DM4Rggv2gG+r2lZGr+Ov62Lb9/VTJgVR1
	nSmncOhVL79vOVDg==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Remove pv_ops.mmu.tlb_remove_table call
Cc: Qi Zheng <zhengqi.arch@bytedance.com>, Rik van Riel <riel@surriel.com>,
 Ingo Molnar <mingo@kernel.org>, Manali Shukla <Manali.Shukla@amd.com>,
 Brendan Jackman <jackmanb@google.com>, Michael Kelley <mhklinux@outlook.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250213161423.449435-3-riel@surriel.com>
References: <20250213161423.449435-3-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174015180524.10177.3442633584092469326.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     f2c5c21058270167ce23172022da083b62e5ad4c
Gitweb:        https://git.kernel.org/tip/f2c5c21058270167ce23172022da083b62e5ad4c
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Thu, 13 Feb 2025 11:13:53 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 16:20:12 +01:00

x86/mm: Remove pv_ops.mmu.tlb_remove_table call

Every pv_ops.mmu.tlb_remove_table call ends up calling tlb_remove_table.

Get rid of the indirection by simply calling tlb_remove_table directly,
and not going through the paravirt function pointers.

Suggested-by: Qi Zheng <zhengqi.arch@bytedance.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Manali Shukla <Manali.Shukla@amd.com>
Tested-by: Brendan Jackman <jackmanb@google.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Link: https://lore.kernel.org/r/20250213161423.449435-3-riel@surriel.com
---
 arch/x86/hyperv/mmu.c                 | 1 -
 arch/x86/include/asm/paravirt.h       | 5 -----
 arch/x86/include/asm/paravirt_types.h | 2 --
 arch/x86/kernel/kvm.c                 | 1 -
 arch/x86/kernel/paravirt.c            | 1 -
 arch/x86/xen/mmu_pv.c                 | 1 -
 6 files changed, 11 deletions(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index cc8c3bd..1f7c308 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -239,5 +239,4 @@ void hyperv_setup_mmu_ops(void)
 
 	pr_info("Using hypercall for remote TLB flush\n");
 	pv_ops.mmu.flush_tlb_multi = hyperv_flush_tlb_multi;
-	pv_ops.mmu.tlb_remove_table = tlb_remove_table;
 }
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 041aff5..38a632a 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -91,11 +91,6 @@ static inline void __flush_tlb_multi(const struct cpumask *cpumask,
 	PVOP_VCALL2(mmu.flush_tlb_multi, cpumask, info);
 }
 
-static inline void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
-{
-	PVOP_VCALL2(mmu.tlb_remove_table, tlb, table);
-}
-
 static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
 {
 	PVOP_VCALL1(mmu.exit_mmap, mm);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index fea56b0..e26633c 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -134,8 +134,6 @@ struct pv_mmu_ops {
 	void (*flush_tlb_multi)(const struct cpumask *cpus,
 				const struct flush_tlb_info *info);
 
-	void (*tlb_remove_table)(struct mmu_gather *tlb, void *table);
-
 	/* Hook for intercepting the destruction of an mm_struct. */
 	void (*exit_mmap)(struct mm_struct *mm);
 	void (*notify_page_enc_status_changed)(unsigned long pfn, int npages, bool enc);
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 7a422a6..3be9b33 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -838,7 +838,6 @@ static void __init kvm_guest_init(void)
 #ifdef CONFIG_SMP
 	if (pv_tlb_flush_supported()) {
 		pv_ops.mmu.flush_tlb_multi = kvm_flush_tlb_multi;
-		pv_ops.mmu.tlb_remove_table = tlb_remove_table;
 		pr_info("KVM setup pv remote TLB flush\n");
 	}
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 527f560..2aa251d 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -180,7 +180,6 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.flush_tlb_kernel	= native_flush_tlb_global,
 	.mmu.flush_tlb_one_user	= native_flush_tlb_one_user,
 	.mmu.flush_tlb_multi	= native_flush_tlb_multi,
-	.mmu.tlb_remove_table	= tlb_remove_table,
 
 	.mmu.exit_mmap		= paravirt_nop,
 	.mmu.notify_page_enc_status_changed	= paravirt_nop,
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index d078de2..38971c6 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2189,7 +2189,6 @@ static const typeof(pv_ops) xen_mmu_ops __initconst = {
 		.flush_tlb_kernel = xen_flush_tlb,
 		.flush_tlb_one_user = xen_flush_tlb_one_user,
 		.flush_tlb_multi = xen_flush_tlb_multi,
-		.tlb_remove_table = tlb_remove_table,
 
 		.pgd_alloc = xen_pgd_alloc,
 		.pgd_free = xen_pgd_free,

