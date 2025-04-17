Return-Path: <linux-tip-commits+bounces-5052-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A62EBA92597
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 20:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD2A464302
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 18:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A9625C71D;
	Thu, 17 Apr 2025 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JSWEtSS+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rEv1T3Gw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A48F2580C0;
	Thu, 17 Apr 2025 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913012; cv=none; b=rs7PUyJHraXeCNNYbdvEEHnM7nRYVn8g+/+nVxraR4OjDy3fTivQArMI9p+iwI70Rwivk9eaTbK7vqDCFn/AG6fn05ZFi93o9nmFBBHEumUW61NczGqNLg/JdEBhSJlHlElHwGYSe54SEUK1pc/jGurkj/6UCJJwy8f9qpjoS7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913012; c=relaxed/simple;
	bh=pSbd5sxEGcTVrfJAguQNM9ehc7LTYsuqIwRIRC5hYsM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=kS2yFq4WLXrtaYGlSUbY0D0Tn3Sy9BOduoptYAyB6cCpeLxZqgek/oXrxfB8x+A/rd1tQLuIYt2/Ct1mL783IGT50a2E1gmtgqVFHhlpCu1gqlGbDgN0OqBxGeHm0jNYrcKboXrq0PKFCFC1mso1LrfPDhImMCCbTLt1/7LmlBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JSWEtSS+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rEv1T3Gw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 18:03:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744913008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Wdnph35UQW/Un217RELR7gmJT8W97yeFpRd85Tss0Io=;
	b=JSWEtSS+A1Z5341XADIp698x5j2yec37wyKJ2EezRMba9OM6lA71M+h/tXctVGTRKJaK1v
	VAuZJScaERxNnFDMer8Az7UIc4AWfK/7m4Yh1iikR8ZwhJCwoDdsqPA1USL/5Ubdh8ttV4
	MEdl11MxjY4Ii/kMJUdgbVi4IjVsD5nTlNkBx6/0VEWNycVccdqikIQPjZn15eTcDrjLOb
	StzQczT4MA8RS991amvr98IGpx9CfgUnvJ1dbZ7fJz101w3UWG3CMGbCEdFHaZk6qHI13G
	QcMbPopdeVr2cGx45W1JnFUKJNyhbP3ywbaLdyLmJHigrzOVER+O4zzySQ6J2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744913008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Wdnph35UQW/Un217RELR7gmJT8W97yeFpRd85Tss0Io=;
	b=rEv1T3Gw35YjXQeAjDEiw1bheWejAuQWyHvdBUhrEPisR60Ig3/oWtsXwMp8L19+BsCge/
	3PEJj0xpoxR3hKCw==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Always "broadcast" PMD setting operations
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174491300802.31282.1389796894467957175.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     b0cc4d19f198cdfd1b58c8f5536670d1dc68cbbd
Gitweb:        https://git.kernel.org/tip/b0cc4d19f198cdfd1b58c8f5536670d1dc68cbbd
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Mon, 14 Apr 2025 10:32:35 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 17 Apr 2025 10:39:25 -07:00

x86/mm: Always "broadcast" PMD setting operations

Kernel PMDs can either be shared across processes or private to a
process.  On 64-bit, they are always shared.  32-bit non-PAE hardware
does not have PMDs, but the kernel logically squishes them into the
PGD and treats them as private. Here are the four cases:

	64-bit:                Shared
	32-bit: non-PAE:       Private
	32-bit:     PAE+  PTI: Private
	32-bit:     PAE+noPTI: Shared

Note that 32-bit is all "Private" except for PAE+noPTI being an
oddball.  The 32-bit+PAE+noPTI case will be made like the rest of
32-bit shortly.

But until that can be done, temporarily treat the 32-bit+PAE+noPTI
case as Private. This will do unnecessary walks across pgd_list and
unnecessary PTE setting but should be otherwise harmless.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20250414173235.F63F50D1%40davehans-spike.ostc.intel.com
---
 arch/x86/mm/pat/set_memory.c |  4 ++--
 arch/x86/mm/pgtable.c        | 11 +++--------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index def3d92..30ab4ac 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -889,7 +889,7 @@ static void __set_pmd_pte(pte_t *kpte, unsigned long address, pte_t pte)
 	/* change init_mm */
 	set_pte_atomic(kpte, pte);
 #ifdef CONFIG_X86_32
-	if (!SHARED_KERNEL_PMD) {
+	{
 		struct page *page;
 
 		list_for_each_entry(page, &pgd_list, lru) {
@@ -1293,7 +1293,7 @@ static int collapse_pmd_page(pmd_t *pmd, unsigned long addr,
 	/* Queue the page table to be freed after TLB flush */
 	list_add(&page_ptdesc(pmd_page(old_pmd))->pt_list, pgtables);
 
-	if (IS_ENABLED(CONFIG_X86_32) && !SHARED_KERNEL_PMD) {
+	if (IS_ENABLED(CONFIG_X86_32)) {
 		struct page *page;
 
 		/* Update all PGD tables to use the same large page */
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index ea01b55..f1c5886 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -97,18 +97,13 @@ static void pgd_ctor(struct mm_struct *mm, pgd_t *pgd)
 				KERNEL_PGD_PTRS);
 	}
 
-	/* list required to sync kernel mapping updates */
-	if (!SHARED_KERNEL_PMD) {
-		pgd_set_mm(pgd, mm);
-		pgd_list_add(pgd);
-	}
+	/* List used to sync kernel mapping updates */
+	pgd_set_mm(pgd, mm);
+	pgd_list_add(pgd);
 }
 
 static void pgd_dtor(pgd_t *pgd)
 {
-	if (SHARED_KERNEL_PMD)
-		return;
-
 	spin_lock(&pgd_lock);
 	pgd_list_del(pgd);
 	spin_unlock(&pgd_lock);

