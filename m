Return-Path: <linux-tip-commits+bounces-3702-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B100DA47A82
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 11:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A998B16E794
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 10:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDD022A4D8;
	Thu, 27 Feb 2025 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OtNxRClv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4BvVOWfO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7A221ABB4;
	Thu, 27 Feb 2025 10:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652935; cv=none; b=JmNgplc6700MFiYUJXvZmiVeiNxvqV5gIufPKQP8GFEkA96/t2YKIe9wDY9Axwuz8WM4AqFzmxhSdjX9GTZCGB30J8TLMQVDkzW75F6rCgEOrudqLZp2UDc8Ykwk0oXRSoTsiDw6NdWgQwf4+atwwf5Mqkm/C7qRZHLLo6YWEuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652935; c=relaxed/simple;
	bh=WNT+XStX07ObPZiO8/WxOt/3FXIfVyCJZsxCedwAgoc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=e53jP8UGsIWrcMBvYEBjIiZLxyopyA3HVEGQwjVbTmeS2wm4v+5tA52AWZfL3BPwsj1ImkdJgLtr0b+uS53CrEeWXoHDVklphFrKohx+d2xDvD8/969QkPCtj4ZozS3yLI04VFWmP4etr37BYIp3IK7ZQ0cBZ9XKYajvrZWnWmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OtNxRClv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4BvVOWfO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 10:42:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740652932;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=457Wur7shOQm8hQwXRkkTfzuglETjkKuJSnlQEZ5h5o=;
	b=OtNxRClvzbQHnMj30QFtIsiTNFeu6rwlYO1Wlznit/TV1rC3L+B05C+O37E0D/ODKfmkam
	+2N6BmizhXKjHF02n2ZiuzzdrsMeFphNZ0TvVA5A8KNTjIXYCNLAbV+4MffR7xI+CD61Gw
	ul7t0oIysdyHbdRkjcXrJKvdCU02PPK8AldMSS98HeR4GmnikRvT4kPboSXUgik4Aj1MpT
	mUANlwijAElcM9SFNfLZkSFr47NBDNC0niktmAIxpCntcjvR1ya6gKP+8rmS1YjZXIJPe9
	lBmWblunBcBt51w1Z9v5nxvFTFXtZFl3abJjmQdEyEoltRbl+5QWKDuPNsKhBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740652932;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=457Wur7shOQm8hQwXRkkTfzuglETjkKuJSnlQEZ5h5o=;
	b=4BvVOWfOBrV4mTO1I+pifcN01h3CK4bd5uIAVOa/M5OFAV/IfvOamNfPVW/8mKBDiZ0ep5
	lzZKLnG1lMHUc4Bw==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mm: Drop support for CONFIG_HIGHPTE
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226213714.4040853-8-arnd@kernel.org>
References: <20250226213714.4040853-8-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174065293149.10177.7265322609739583759.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     0081fdeccbf610499b79784998b1fd36783209dd
Gitweb:        https://git.kernel.org/tip/0081fdeccbf610499b79784998b1fd36783209dd
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 26 Feb 2025 22:37:11 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 11:22:06 +01:00

x86/mm: Drop support for CONFIG_HIGHPTE

With the maximum amount of RAM now 4GB, there is very little point
to still have PTE pages in highmem. Drop this for simplification.

The only other architecture supporting HIGHPTE is 32-bit arm, and
once that feature is removed as well, the highpte logic can be
dropped from common code as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250226213714.4040853-8-arnd@kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +----
 arch/x86/Kconfig                                |  9 +-----
 arch/x86/include/asm/pgalloc.h                  |  5 +---
 arch/x86/mm/pgtable.c                           | 27 +----------------
 4 files changed, 1 insertion(+), 47 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 8f92377..9317763 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7668,13 +7668,6 @@
 				16 - SIGBUS faults
 			Example: user_debug=31
 
-	userpte=
-			[X86,EARLY] Flags controlling user PTE allocations.
-
-				nohigh = do not allocate PTE pages in
-					HIGHMEM regardless of setting
-					of CONFIG_HIGHPTE.
-
 	vdso=		[X86,SH,SPARC]
 			On X86_32, this is an alias for vdso32=.  Otherwise:
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0e0ec2c..73eeaf2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1628,15 +1628,6 @@ config X86_PMEM_LEGACY
 
 	  Say Y if unsure.
 
-config HIGHPTE
-	bool "Allocate 3rd-level pagetables from highmem"
-	depends on HIGHMEM
-	help
-	  The VM uses one page table entry for each page of physical memory.
-	  For systems with a lot of RAM, this can be wasteful of precious
-	  low memory.  Setting this option will put user-space page table
-	  entries in high memory.
-
 config X86_CHECK_BIOS_CORRUPTION
 	bool "Check for low memory corruption"
 	help
diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index dd48412..a331475 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -29,11 +29,6 @@ static inline void paravirt_release_pud(unsigned long pfn) {}
 static inline void paravirt_release_p4d(unsigned long pfn) {}
 #endif
 
-/*
- * Flags to use when allocating a user page table page.
- */
-extern gfp_t __userpte_alloc_gfp;
-
 #ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 /*
  * Instead of one PGD, we acquire two PGDs.  Being order-1, it is
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index b1c1f72..cec321f 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -12,35 +12,10 @@ phys_addr_t physical_mask __ro_after_init = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
 EXPORT_SYMBOL(physical_mask);
 #endif
 
-#ifdef CONFIG_HIGHPTE
-#define PGTABLE_HIGHMEM __GFP_HIGHMEM
-#else
-#define PGTABLE_HIGHMEM 0
-#endif
-
-gfp_t __userpte_alloc_gfp = GFP_PGTABLE_USER | PGTABLE_HIGHMEM;
-
 pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	return __pte_alloc_one(mm, __userpte_alloc_gfp);
-}
-
-static int __init setup_userpte(char *arg)
-{
-	if (!arg)
-		return -EINVAL;
-
-	/*
-	 * "userpte=nohigh" disables allocation of user pagetables in
-	 * high memory.
-	 */
-	if (strcmp(arg, "nohigh") == 0)
-		__userpte_alloc_gfp &= ~__GFP_HIGHMEM;
-	else
-		return -EINVAL;
-	return 0;
+	return __pte_alloc_one(mm, GFP_PGTABLE_USER);
 }
-early_param("userpte", setup_userpte);
 
 void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
 {

