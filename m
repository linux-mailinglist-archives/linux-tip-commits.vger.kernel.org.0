Return-Path: <linux-tip-commits+bounces-5550-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3BDAB8A55
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 17:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C77188505A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 15:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DBD13B7A3;
	Thu, 15 May 2025 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O4hv2rgI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mt0eiv5x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F794B1E55;
	Thu, 15 May 2025 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747321875; cv=none; b=VBpVZbz1h08ub0kfXVrMi+wukQQjoFLvfUWeoFjeyiuIk2bRATKwh+SpEtahHGyn0UnEbV2t2iTew3OZGgG8LynY7ibR/Nvazp2gFDVDrWQg+JAcFMyPgEKRb6j3cVh/rEaD6LxWuuCoCOB2lH/dr4QXDM3q01oN9pOOxleRDfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747321875; c=relaxed/simple;
	bh=dNwNnQPh6bksZBqSL0axNCXhS6GnGNdb2tOH890+j38=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GZkaMZEYII95PsHQjUqCebzkIolw2RlVyIugYYPl6PCC/EKm0J/NTtx/J9Cr02CqyKbPsvaH2WlXq7V2pXP+ToUZWLT0W/RNqdvMGE5diS6gIp4zNN2B0iZTZLejSyTOvAu2MkvPh3yw8jLDVB0S32C5B8nZoyOG7rfLbRY50Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O4hv2rgI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mt0eiv5x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 May 2025 15:11:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747321870;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dW2ndhB+TxkJM4Zz5nTySCiW+h+/X4vFyxUVjLLxRJk=;
	b=O4hv2rgI1NbO19VAAyMCJDfgcAG3JsDCt6L0XdSczwWclZJHQsAFJULRCNf7Eu5bqjB81F
	l0NTp8EZZridEKwUfObbPCiC0wnJatQ+D/MNA5deMLbqoVZp07cxxV7QRG/MbvjKx+u3Z0
	dUAZdp0YvIlwMenxvVobAm0YWZHwbNfaG3rOvub6PhqKcnZ4Sv0cuFnGf6G+2zGiQ8+3y+
	cPG/J+abkMePEG8fCx+QSBGzWjYEoNDnp4EXMcYocnyfXc+ms7f/B6Fp41TybfcCZOMqzE
	k3GJKZ1+TdWrPlT227zZBByMApy2scs5A044CtZMxvOIr82YepaUtv8mt2Kyxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747321870;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dW2ndhB+TxkJM4Zz5nTySCiW+h+/X4vFyxUVjLLxRJk=;
	b=mt0eiv5xD2BeOsf3MGdNySzPdSZlp2dcVrryBpJLzaxxs1kKEbpWu3vOm4cWIGu1cIM4EH
	ydEsCVwa8DXPEmAQ==
From: "tip-bot2 for Shivank Garg" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/mm: Fix kernel-doc descriptions of various
 pgtable methods
Cc: Shivank Garg <shivankg@amd.com>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Andy Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Juergen Gross <jgross@suse.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Rik van Riel <riel@surriel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250514062637.3287779-1-shivankg@amd.com>
References: <20250514062637.3287779-1-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174732186932.406.9535070697023965595.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     1adf711919de7c9e1b281a4d9cd9e3a81f3a70f7
Gitweb:        https://git.kernel.org/tip/1adf711919de7c9e1b281a4d9cd9e3a81f3a70f7
Author:        Shivank Garg <shivankg@amd.com>
AuthorDate:    Wed, 30 Apr 2025 11:29:59 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 15 May 2025 17:04:36 +02:00

x86/mm: Fix kernel-doc descriptions of various pgtable methods

So 'make W=1' complains about a couple of kernel-doc descriptions
in our MM primitives in pgtable.c:

  arch/x86/mm/pgtable.c:623: warning: Function parameter or struct member 'reserve' not described in 'reserve_top_address'
  arch/x86/mm/pgtable.c:672: warning: Function parameter or struct member 'p4d' not described in 'p4d_set_huge'
  arch/x86/mm/pgtable.c:672: warning: Function parameter or struct member 'addr' not described in 'p4d_set_huge'
  ... so on

Fix them all up, add missing parameter documentation, and fix various spelling
inconsistencies while at it.

[ mingo: Harmonize kernel-doc annotations some more. ]

Signed-off-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Link: https://lore.kernel.org/r/20250514062637.3287779-1-shivankg@amd.com
---
 arch/x86/mm/pgtable.c | 50 ++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 7c253de..59c42de 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -543,11 +543,11 @@ pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
 #endif
 
 /**
- * reserve_top_address - reserves a hole in the top of kernel address space
- * @reserve - size of hole to reserve
+ * reserve_top_address - Reserve a hole in the top of the kernel address space
+ * @reserve: Size of hole to reserve
  *
  * Can be used to relocate the fixmap area and poke a hole in the top
- * of kernel address space to make room for a hypervisor.
+ * of the kernel address space to make room for a hypervisor.
  */
 void __init reserve_top_address(unsigned long reserve)
 {
@@ -594,7 +594,10 @@ void native_set_fixmap(unsigned /* enum fixed_addresses */ idx,
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
 #ifdef CONFIG_X86_5LEVEL
 /**
- * p4d_set_huge - setup kernel P4D mapping
+ * p4d_set_huge - Set up kernel P4D mapping
+ * @p4d: Pointer to the P4D entry
+ * @addr: Virtual address associated with the P4D entry
+ * @prot: Protection bits to use
  *
  * No 512GB pages yet -- always return 0
  */
@@ -604,9 +607,10 @@ int p4d_set_huge(p4d_t *p4d, phys_addr_t addr, pgprot_t prot)
 }
 
 /**
- * p4d_clear_huge - clear kernel P4D mapping when it is set
+ * p4d_clear_huge - Clear kernel P4D mapping when it is set
+ * @p4d: Pointer to the P4D entry to clear
  *
- * No 512GB pages yet -- always return 0
+ * No 512GB pages yet -- do nothing
  */
 void p4d_clear_huge(p4d_t *p4d)
 {
@@ -614,7 +618,10 @@ void p4d_clear_huge(p4d_t *p4d)
 #endif
 
 /**
- * pud_set_huge - setup kernel PUD mapping
+ * pud_set_huge - Set up kernel PUD mapping
+ * @pud: Pointer to the PUD entry
+ * @addr: Virtual address associated with the PUD entry
+ * @prot: Protection bits to use
  *
  * MTRRs can override PAT memory types with 4KiB granularity. Therefore, this
  * function sets up a huge page only if the complete range has the same MTRR
@@ -645,7 +652,10 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 }
 
 /**
- * pmd_set_huge - setup kernel PMD mapping
+ * pmd_set_huge - Set up kernel PMD mapping
+ * @pmd: Pointer to the PMD entry
+ * @addr: Virtual address associated with the PMD entry
+ * @prot: Protection bits to use
  *
  * See text over pud_set_huge() above.
  *
@@ -674,7 +684,8 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
 }
 
 /**
- * pud_clear_huge - clear kernel PUD mapping when it is set
+ * pud_clear_huge - Clear kernel PUD mapping when it is set
+ * @pud: Pointer to the PUD entry to clear.
  *
  * Returns 1 on success and 0 on failure (no PUD map is found).
  */
@@ -689,7 +700,8 @@ int pud_clear_huge(pud_t *pud)
 }
 
 /**
- * pmd_clear_huge - clear kernel PMD mapping when it is set
+ * pmd_clear_huge - Clear kernel PMD mapping when it is set
+ * @pmd: Pointer to the PMD entry to clear.
  *
  * Returns 1 on success and 0 on failure (no PMD map is found).
  */
@@ -705,11 +717,11 @@ int pmd_clear_huge(pmd_t *pmd)
 
 #ifdef CONFIG_X86_64
 /**
- * pud_free_pmd_page - Clear pud entry and free pmd page.
- * @pud: Pointer to a PUD.
- * @addr: Virtual address associated with pud.
+ * pud_free_pmd_page - Clear PUD entry and free PMD page
+ * @pud: Pointer to a PUD
+ * @addr: Virtual address associated with PUD
  *
- * Context: The pud range has been unmapped and TLB purged.
+ * Context: The PUD range has been unmapped and TLB purged.
  * Return: 1 if clearing the entry succeeded. 0 otherwise.
  *
  * NOTE: Callers must allow a single page allocation.
@@ -752,11 +764,11 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 }
 
 /**
- * pmd_free_pte_page - Clear pmd entry and free pte page.
- * @pmd: Pointer to a PMD.
- * @addr: Virtual address associated with pmd.
+ * pmd_free_pte_page - Clear PMD entry and free PTE page.
+ * @pmd: Pointer to the PMD
+ * @addr: Virtual address associated with PMD
  *
- * Context: The pmd range has been unmapped and TLB purged.
+ * Context: The PMD range has been unmapped and TLB purged.
  * Return: 1 if clearing the entry succeeded. 0 otherwise.
  */
 int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
@@ -778,7 +790,7 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 
 /*
  * Disable free page handling on x86-PAE. This assures that ioremap()
- * does not update sync'd pmd entries. See vmalloc_sync_one().
+ * does not update sync'd PMD entries. See vmalloc_sync_one().
  */
 int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 {

