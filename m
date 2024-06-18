Return-Path: <linux-tip-commits+bounces-1456-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8257390D4A8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 16:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651531C23EF5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 14:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC3D1A3BB1;
	Tue, 18 Jun 2024 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1fY/Xoud";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XYmEwKka"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030561A2FB5;
	Tue, 18 Jun 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719315; cv=none; b=Hfv9Fy0NhHJ3NNfj9vsoxgqpCbREaNYfgWc4NjfSYfKG7aSdDvXfCbt7l4lo13v5MnRFkHwInN170TvpqCV+YPQ2KePaRsPL19jjbZpXdaiI8xC5Ow3GIO+0jwfIQH3Fv6Uko/svj85d107YWYHaOKL9FjBob59ODFxgj0bDoOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719315; c=relaxed/simple;
	bh=CF6Xj4LkKBvKhfcI2dCKWsn1m7mwtnyEH8k7bWnrN78=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=B5LF5MDp5Q43jfyEGZ34zZACvs7O94AaEBeO2/ndsucmJqqRzwPuY7zlpWU1DUuyHfYLXmLTBZheCFaeEu9jV/X++maSXNw22RiAMoYKTcGVzq+RN1fnvFYWWvqtvMP8mwas8+eOqvmNgNlxLTLWzQ2gDb4pgDCQZcGsNGF5dxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1fY/Xoud; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XYmEwKka; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 14:01:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718719302;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+c1TTlm0S4IU963hYSalQtxkave6zxlQsd8ZUIsONnM=;
	b=1fY/XoudhXASpi+8UsPynt+wjHk+9iUPwmLhATsP5D+C7AnZVIID2pjd5VnJd4TVOl04Yl
	NcEtAilHzQKfoisCrrh4b7IYtp3o9XvApfB1VS5W41+LV5q/snXtVM3WPssxg24OzM7vZe
	rmZvL8u5MGZZ95aGsRTPfkcZohPSRZDZIx3TQb+3/hEweBK6DB5MgtaoP2dDFahfMUvZ/G
	Gz5KOv6wEfC5GctWGKjUcguT7VP24t5i+QfIQp1k+GnN0a71IHJ6JzhMzqSZ+VVm32he9G
	khyo+Lux5zHVlZ2wJq9OodG7WzQEvp90O1LiIvnCCf2UucXbhcoSl8P++otTZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718719302;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+c1TTlm0S4IU963hYSalQtxkave6zxlQsd8ZUIsONnM=;
	b=XYmEwKkarQJ0JQsQovI5fploH8Sf3oUeKc8qW/oepvHoHFWdw1EMLNE+aUPMZDmjSGgIrB
	SqlvQP5yoSZ5doCw==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/mm: Return correct level from lookup_address() if
 pte is none
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, Baoquan He <bhe@redhat.com>,
 Dave Hansen <dave.hansen@intel.com>, Tao Liu <ltao@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240614095904.1345461-9-kirill.shutemov@linux.intel.com>
References: <20240614095904.1345461-9-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171871930159.10875.16081839197437299007.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     9d1dcdfa909178b6f465625bbfd8311e6107b48e
Gitweb:        https://git.kernel.org/tip/9d1dcdfa909178b6f465625bbfd8311e6107b48e
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 14 Jun 2024 12:58:53 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Jun 2024 17:45:57 +02:00

x86/mm: Return correct level from lookup_address() if pte is none

Currently, lookup_address() returns two things:

  1. A "pte_t" (which might be a p[g4um]d_t)
  2. The 'level' of the page tables where the "pte_t" was found
     (returned via a pointer)

If no pte_t is found, 'level' is essentially garbage.

Always fill out the level.  For NULL "pte_t"s, fill in the level where
the p*d_none() entry was found mirroring the "found" behavior.

Always filling out the level allows using lookup_address() to precisely skip
over holes when walking kernel page tables.

Add one more entry into enum pg_level to indicate the size of the VA
covered by one PGD entry in 5-level paging mode.

Update comments for lookup_address() and lookup_address_in_pgd() to
reflect changes in the interface.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Tested-by: Tao Liu <ltao@redhat.com>
Link: https://lore.kernel.org/r/20240614095904.1345461-9-kirill.shutemov@linux.intel.com
---
 arch/x86/include/asm/pgtable_types.h |  1 +
 arch/x86/mm/pat/set_memory.c         | 21 ++++++++++-----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index b786449..2f32113 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -549,6 +549,7 @@ enum pg_level {
 	PG_LEVEL_2M,
 	PG_LEVEL_1G,
 	PG_LEVEL_512G,
+	PG_LEVEL_256T,
 	PG_LEVEL_NUM
 };
 
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 498812f..a7a7a6c 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -662,8 +662,9 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
 
 /*
  * Lookup the page table entry for a virtual address in a specific pgd.
- * Return a pointer to the entry, the level of the mapping, and the effective
- * NX and RW bits of all page table levels.
+ * Return a pointer to the entry (or NULL if the entry does not exist),
+ * the level of the entry, and the effective NX and RW bits of all
+ * page table levels.
  */
 pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
 				  unsigned int *level, bool *nx, bool *rw)
@@ -672,13 +673,14 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
 	pud_t *pud;
 	pmd_t *pmd;
 
-	*level = PG_LEVEL_NONE;
+	*level = PG_LEVEL_256T;
 	*nx = false;
 	*rw = true;
 
 	if (pgd_none(*pgd))
 		return NULL;
 
+	*level = PG_LEVEL_512G;
 	*nx |= pgd_flags(*pgd) & _PAGE_NX;
 	*rw &= pgd_flags(*pgd) & _PAGE_RW;
 
@@ -686,10 +688,10 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
 	if (p4d_none(*p4d))
 		return NULL;
 
-	*level = PG_LEVEL_512G;
 	if (p4d_leaf(*p4d) || !p4d_present(*p4d))
 		return (pte_t *)p4d;
 
+	*level = PG_LEVEL_1G;
 	*nx |= p4d_flags(*p4d) & _PAGE_NX;
 	*rw &= p4d_flags(*p4d) & _PAGE_RW;
 
@@ -697,10 +699,10 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
 	if (pud_none(*pud))
 		return NULL;
 
-	*level = PG_LEVEL_1G;
 	if (pud_leaf(*pud) || !pud_present(*pud))
 		return (pte_t *)pud;
 
+	*level = PG_LEVEL_2M;
 	*nx |= pud_flags(*pud) & _PAGE_NX;
 	*rw &= pud_flags(*pud) & _PAGE_RW;
 
@@ -708,15 +710,13 @@ pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
 	if (pmd_none(*pmd))
 		return NULL;
 
-	*level = PG_LEVEL_2M;
 	if (pmd_leaf(*pmd) || !pmd_present(*pmd))
 		return (pte_t *)pmd;
 
+	*level = PG_LEVEL_4K;
 	*nx |= pmd_flags(*pmd) & _PAGE_NX;
 	*rw &= pmd_flags(*pmd) & _PAGE_RW;
 
-	*level = PG_LEVEL_4K;
-
 	return pte_offset_kernel(pmd, address);
 }
 
@@ -736,9 +736,8 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
  * Lookup the page table entry for a virtual address. Return a pointer
  * to the entry and the level of the mapping.
  *
- * Note: We return pud and pmd either when the entry is marked large
- * or when the present bit is not set. Otherwise we would return a
- * pointer to a nonexisting mapping.
+ * Note: the function returns p4d, pud or pmd either when the entry is marked
+ * large or when the present bit is not set. Otherwise it returns NULL.
  */
 pte_t *lookup_address(unsigned long address, unsigned int *level)
 {

