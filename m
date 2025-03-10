Return-Path: <linux-tip-commits+bounces-4116-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8C0A5A413
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 20:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E46174C37
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 19:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F9F1DE2A4;
	Mon, 10 Mar 2025 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MZGKRjZX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5TNYKqJ3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4261DB14C;
	Mon, 10 Mar 2025 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636259; cv=none; b=lPO7RbQ1xICMVkf2YWMo0hs+Uedfn31GucUut43Lkk+o7ebnZIpL6kX0si1M6q84bvy0mmTdCgnz7iQYZdtt321Nq8vmzhH8tkMfiV1v7vClgfiNqQmSHZVNdPdBXCXHreVPtldI82SDTxMj/BspZ1UBzvKv9ZqXMTRX6WA0GQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636259; c=relaxed/simple;
	bh=y8iMlwWUDWn5/kRljPHUvopfQZgT8td4zKcmzhRMZVQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=szHIrpYucvAwcjL7SwSJyEj3u8o3isxaF72nviBB0WRmSyQirLqbPw22nFlfUPRWTxM+sQS5rvCjEVT+ZMEOfV3uxwI831+dfKgC6q+oQwdXff0rcsq5XL0TzHTt2spso4THNH5hCf/SLXDTyv0jtE3xMc0M3/oJigRah8u/PQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MZGKRjZX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5TNYKqJ3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Mar 2025 19:50:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741636256;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QdBDkcerP3Cc7AZ/m/nDh2e/pAvikEkEMJY4xPU0at0=;
	b=MZGKRjZXaxc8MNE4If11TIfVwd5f2KZ9x2XT2qzzRf/71UidbAroscrwcBj1S5mGHL3wTm
	JsXYjcphRM4f6q7nuUbWqdeDY7XGLP4giME+q8Y29mUVQ289FSF6+lVbUx4rS4H03A1ywt
	vbzhcfu8Sfrlu2j2AJx3+OnkPhbBQKVriGXSgpDthF4DNRk8etye7IX9dzcXYktS2anrR5
	x8/7Jo4XftB2PdLi+pIRKKz33cb/hvgGPt8vwtDx8rNBtOiC2iL0nd83V1n64uxVo/v441
	MPbN+7G8mUDSm/Yd06r7USSOSSH1/QteiQ2OYGRe9Zv0XE7GY2zBhYkdHWSDpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741636256;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QdBDkcerP3Cc7AZ/m/nDh2e/pAvikEkEMJY4xPU0at0=;
	b=5TNYKqJ3YeemOMYGOLOLuLXDEhkAVoqGylLcgzqJPUV8PYH1eGDm48y7N/y5XCPnEVMQ8Y
	fufZZFrzsTHxxyAA==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/acpi: Replace manual page table initialization with
 kernel_ident_mapping_init()
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Kai Huang <kai.huang@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Andy Lutomirski <luto@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241016111458.846228-3-kirill.shutemov@linux.intel.com>
References: <20241016111458.846228-3-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174163625401.14745.16176946707588696336.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     376daf20eda4898a49a4746f225153efb4c094e7
Gitweb:        https://git.kernel.org/tip/376daf20eda4898a49a4746f225153efb4c094e7
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 16 Oct 2024 14:14:56 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 10 Mar 2025 20:31:28 +01:00

x86/acpi: Replace manual page table initialization with kernel_ident_mapping_init()

The init_transition_pgtable() functions maps the page with
asm_acpi_mp_play_dead() into an identity mapping.

Replace open-coded manual page table initialization with
kernel_ident_mapping_init() to avoid code duplication.

Use x86_mapping_info::offset to get the page mapped at the
correct location.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20241016111458.846228-3-kirill.shutemov@linux.intel.com
---
 arch/x86/kernel/acpi/madt_wakeup.c | 73 +++++------------------------
 1 file changed, 15 insertions(+), 58 deletions(-)

diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index d5ef621..f36f284 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -70,58 +70,6 @@ static void __init free_pgt_page(void *pgt, void *dummy)
 	return memblock_free(pgt, PAGE_SIZE);
 }
 
-/*
- * Make sure asm_acpi_mp_play_dead() is present in the identity mapping at
- * the same place as in the kernel page tables. asm_acpi_mp_play_dead() switches
- * to the identity mapping and the function has be present at the same spot in
- * the virtual address space before and after switching page tables.
- */
-static int __init init_transition_pgtable(pgd_t *pgd)
-{
-	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
-	unsigned long vaddr, paddr;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-
-	vaddr = (unsigned long)asm_acpi_mp_play_dead;
-	pgd += pgd_index(vaddr);
-	if (!pgd_present(*pgd)) {
-		p4d = (p4d_t *)alloc_pgt_page(NULL);
-		if (!p4d)
-			return -ENOMEM;
-		set_pgd(pgd, __pgd(__pa(p4d) | _KERNPG_TABLE));
-	}
-	p4d = p4d_offset(pgd, vaddr);
-	if (!p4d_present(*p4d)) {
-		pud = (pud_t *)alloc_pgt_page(NULL);
-		if (!pud)
-			return -ENOMEM;
-		set_p4d(p4d, __p4d(__pa(pud) | _KERNPG_TABLE));
-	}
-	pud = pud_offset(p4d, vaddr);
-	if (!pud_present(*pud)) {
-		pmd = (pmd_t *)alloc_pgt_page(NULL);
-		if (!pmd)
-			return -ENOMEM;
-		set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
-	}
-	pmd = pmd_offset(pud, vaddr);
-	if (!pmd_present(*pmd)) {
-		pte = (pte_t *)alloc_pgt_page(NULL);
-		if (!pte)
-			return -ENOMEM;
-		set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
-	}
-	pte = pte_offset_kernel(pmd, vaddr);
-
-	paddr = __pa(vaddr);
-	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
-
-	return 0;
-}
-
 static int __init acpi_mp_setup_reset(u64 reset_vector)
 {
 	struct x86_mapping_info info = {
@@ -130,6 +78,7 @@ static int __init acpi_mp_setup_reset(u64 reset_vector)
 		.page_flag      = __PAGE_KERNEL_LARGE_EXEC,
 		.kernpg_flag    = _KERNPG_TABLE_NOENC,
 	};
+	unsigned long mstart, mend;
 	pgd_t *pgd;
 
 	pgd = alloc_pgt_page(NULL);
@@ -137,8 +86,6 @@ static int __init acpi_mp_setup_reset(u64 reset_vector)
 		return -ENOMEM;
 
 	for (int i = 0; i < nr_pfn_mapped; i++) {
-		unsigned long mstart, mend;
-
 		mstart = pfn_mapped[i].start << PAGE_SHIFT;
 		mend   = pfn_mapped[i].end << PAGE_SHIFT;
 		if (kernel_ident_mapping_init(&info, pgd, mstart, mend)) {
@@ -147,14 +94,24 @@ static int __init acpi_mp_setup_reset(u64 reset_vector)
 		}
 	}
 
-	if (kernel_ident_mapping_init(&info, pgd,
-				      PAGE_ALIGN_DOWN(reset_vector),
-				      PAGE_ALIGN(reset_vector + 1))) {
+	mstart = PAGE_ALIGN_DOWN(reset_vector);
+	mend = mstart + PAGE_SIZE;
+	if (kernel_ident_mapping_init(&info, pgd, mstart, mend)) {
 		kernel_ident_mapping_free(&info, pgd);
 		return -ENOMEM;
 	}
 
-	if (init_transition_pgtable(pgd)) {
+	/*
+	 * Make sure asm_acpi_mp_play_dead() is present in the identity mapping
+	 * at the same place as in the kernel page tables.
+	 * asm_acpi_mp_play_dead() switches to the identity mapping and the
+	 * function must be present at the same spot in the virtual address space
+	 * before and after switching page tables.
+	 */
+	info.offset = __START_KERNEL_map - phys_base;
+	mstart = PAGE_ALIGN_DOWN(__pa(asm_acpi_mp_play_dead));
+	mend = mstart + PAGE_SIZE;
+	if (kernel_ident_mapping_init(&info, pgd, mstart, mend)) {
 		kernel_ident_mapping_free(&info, pgd);
 		return -ENOMEM;
 	}

