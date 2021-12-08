Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905CE46D895
	for <lists+linux-tip-commits@lfdr.de>; Wed,  8 Dec 2021 17:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbhLHQjG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 8 Dec 2021 11:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbhLHQjG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 8 Dec 2021 11:39:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D6EC061746;
        Wed,  8 Dec 2021 08:35:33 -0800 (PST)
Date:   Wed, 08 Dec 2021 16:35:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638981330;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q6+kc22oobsbfpdB4mup4TLq0TwBtlIskRA2rG4CV/c=;
        b=TwU9mzhU4o06CmwCmZ5BcTjas2eNIVDK1oBIWhzB2LUKa5jcyWh3nZa4Pu2Dwp2InRjFsR
        /rQzJJ4ALmUSWTX7G5Vn4rKKZGkHmWQivnxx0RkLco89psnj9VbwUvrc+TA6sVT4UDc4Xj
        Wn1JfRZcOQ9NbxdGeLeHPuRo0rXzfZl7qJY4Vwrt0vDxScDJlyOtwgZQDsW9zfAriAu31r
        4+par3HKi6wH6Xa67xSBhuLmxmeidKAfCYBrLDRmdbRA5oSLP7RuFmYpLmYdmypNOogArV
        I4sWqSHG5GAliL5pIAOaD3mxd0hOaW3ermRPoFuWoBFZohJz413pe2X5f9oBCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638981330;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q6+kc22oobsbfpdB4mup4TLq0TwBtlIskRA2rG4CV/c=;
        b=0u2YffloHChBMtOnOO9mCcSybFHCi2B9rm0rHd1D+SVL+WRQ8LASaBrcH/mO6UubTf1YEz
        Do6CHsAvhP6YqwCw==
From:   "tip-bot2 for Kuppuswamy Sathyanarayanan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Rename mem_encrypt.c to mem_encrypt_amd.c
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206135505.75045-3-kirill.shutemov@linux.intel.com>
References: <20211206135505.75045-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <163898132937.11128.7433694086138331927.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     dbca5e1a04f8b30aea4e2c91e5045ee6e7c3ef43
Gitweb:        https://git.kernel.org/tip/dbca5e1a04f8b30aea4e2c91e5045ee6e7c3ef43
Author:        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
AuthorDate:    Mon, 06 Dec 2021 16:55:04 +03:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 08 Dec 2021 16:49:47 +01:00

x86/sev: Rename mem_encrypt.c to mem_encrypt_amd.c

Both Intel TDX and AMD SEV implement memory encryption features. But the
bulk of the code in mem_encrypt.c is AMD-specific. Rename the file to
mem_encrypt_amd.c. A subsequent patch will extract the parts that can be
shared by both TDX and AMD SEV/SME into a generic file.

No functional changes.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20211206135505.75045-3-kirill.shutemov@linux.intel.com
---
 arch/x86/mm/Makefile          |   8 +-
 arch/x86/mm/mem_encrypt.c     | 507 +---------------------------------
 arch/x86/mm/mem_encrypt_amd.c | 507 +++++++++++++++++++++++++++++++++-
 3 files changed, 511 insertions(+), 511 deletions(-)
 delete mode 100644 arch/x86/mm/mem_encrypt.c
 create mode 100644 arch/x86/mm/mem_encrypt_amd.c

diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 5864219..c9c4806 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 # Kernel does not boot with instrumentation of tlb.c and mem_encrypt*.c
 KCOV_INSTRUMENT_tlb.o			:= n
-KCOV_INSTRUMENT_mem_encrypt.o		:= n
+KCOV_INSTRUMENT_mem_encrypt_amd.o	:= n
 KCOV_INSTRUMENT_mem_encrypt_identity.o	:= n
 
-KASAN_SANITIZE_mem_encrypt.o		:= n
+KASAN_SANITIZE_mem_encrypt_amd.o	:= n
 KASAN_SANITIZE_mem_encrypt_identity.o	:= n
 
 # Disable KCSAN entirely, because otherwise we get warnings that some functions
@@ -12,7 +12,7 @@ KASAN_SANITIZE_mem_encrypt_identity.o	:= n
 KCSAN_SANITIZE := n
 
 ifdef CONFIG_FUNCTION_TRACER
-CFLAGS_REMOVE_mem_encrypt.o		= -pg
+CFLAGS_REMOVE_mem_encrypt_amd.o		= -pg
 CFLAGS_REMOVE_mem_encrypt_identity.o	= -pg
 endif
 
@@ -52,6 +52,6 @@ obj-$(CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS)	+= pkeys.o
 obj-$(CONFIG_RANDOMIZE_MEMORY)			+= kaslr.o
 obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
 
-obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt.o
+obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_amd.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
deleted file mode 100644
index b520021..0000000
--- a/arch/x86/mm/mem_encrypt.c
+++ /dev/null
@@ -1,507 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * AMD Memory Encryption Support
- *
- * Copyright (C) 2016 Advanced Micro Devices, Inc.
- *
- * Author: Tom Lendacky <thomas.lendacky@amd.com>
- */
-
-#define DISABLE_BRANCH_PROFILING
-
-#include <linux/linkage.h>
-#include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/dma-direct.h>
-#include <linux/swiotlb.h>
-#include <linux/mem_encrypt.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/bitops.h>
-#include <linux/dma-mapping.h>
-#include <linux/virtio_config.h>
-#include <linux/cc_platform.h>
-
-#include <asm/tlbflush.h>
-#include <asm/fixmap.h>
-#include <asm/setup.h>
-#include <asm/bootparam.h>
-#include <asm/set_memory.h>
-#include <asm/cacheflush.h>
-#include <asm/processor-flags.h>
-#include <asm/msr.h>
-#include <asm/cmdline.h>
-
-#include "mm_internal.h"
-
-/*
- * Since SME related variables are set early in the boot process they must
- * reside in the .data section so as not to be zeroed out when the .bss
- * section is later cleared.
- */
-u64 sme_me_mask __section(".data") = 0;
-u64 sev_status __section(".data") = 0;
-u64 sev_check_data __section(".data") = 0;
-EXPORT_SYMBOL(sme_me_mask);
-
-/* Buffer used for early in-place encryption by BSP, no locking needed */
-static char sme_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
-
-/*
- * This routine does not change the underlying encryption setting of the
- * page(s) that map this memory. It assumes that eventually the memory is
- * meant to be accessed as either encrypted or decrypted but the contents
- * are currently not in the desired state.
- *
- * This routine follows the steps outlined in the AMD64 Architecture
- * Programmer's Manual Volume 2, Section 7.10.8 Encrypt-in-Place.
- */
-static void __init __sme_early_enc_dec(resource_size_t paddr,
-				       unsigned long size, bool enc)
-{
-	void *src, *dst;
-	size_t len;
-
-	if (!sme_me_mask)
-		return;
-
-	wbinvd();
-
-	/*
-	 * There are limited number of early mapping slots, so map (at most)
-	 * one page at time.
-	 */
-	while (size) {
-		len = min_t(size_t, sizeof(sme_early_buffer), size);
-
-		/*
-		 * Create mappings for the current and desired format of
-		 * the memory. Use a write-protected mapping for the source.
-		 */
-		src = enc ? early_memremap_decrypted_wp(paddr, len) :
-			    early_memremap_encrypted_wp(paddr, len);
-
-		dst = enc ? early_memremap_encrypted(paddr, len) :
-			    early_memremap_decrypted(paddr, len);
-
-		/*
-		 * If a mapping can't be obtained to perform the operation,
-		 * then eventual access of that area in the desired mode
-		 * will cause a crash.
-		 */
-		BUG_ON(!src || !dst);
-
-		/*
-		 * Use a temporary buffer, of cache-line multiple size, to
-		 * avoid data corruption as documented in the APM.
-		 */
-		memcpy(sme_early_buffer, src, len);
-		memcpy(dst, sme_early_buffer, len);
-
-		early_memunmap(dst, len);
-		early_memunmap(src, len);
-
-		paddr += len;
-		size -= len;
-	}
-}
-
-void __init sme_early_encrypt(resource_size_t paddr, unsigned long size)
-{
-	__sme_early_enc_dec(paddr, size, true);
-}
-
-void __init sme_early_decrypt(resource_size_t paddr, unsigned long size)
-{
-	__sme_early_enc_dec(paddr, size, false);
-}
-
-static void __init __sme_early_map_unmap_mem(void *vaddr, unsigned long size,
-					     bool map)
-{
-	unsigned long paddr = (unsigned long)vaddr - __PAGE_OFFSET;
-	pmdval_t pmd_flags, pmd;
-
-	/* Use early_pmd_flags but remove the encryption mask */
-	pmd_flags = __sme_clr(early_pmd_flags);
-
-	do {
-		pmd = map ? (paddr & PMD_MASK) + pmd_flags : 0;
-		__early_make_pgtable((unsigned long)vaddr, pmd);
-
-		vaddr += PMD_SIZE;
-		paddr += PMD_SIZE;
-		size = (size <= PMD_SIZE) ? 0 : size - PMD_SIZE;
-	} while (size);
-
-	flush_tlb_local();
-}
-
-void __init sme_unmap_bootdata(char *real_mode_data)
-{
-	struct boot_params *boot_data;
-	unsigned long cmdline_paddr;
-
-	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
-		return;
-
-	/* Get the command line address before unmapping the real_mode_data */
-	boot_data = (struct boot_params *)real_mode_data;
-	cmdline_paddr = boot_data->hdr.cmd_line_ptr | ((u64)boot_data->ext_cmd_line_ptr << 32);
-
-	__sme_early_map_unmap_mem(real_mode_data, sizeof(boot_params), false);
-
-	if (!cmdline_paddr)
-		return;
-
-	__sme_early_map_unmap_mem(__va(cmdline_paddr), COMMAND_LINE_SIZE, false);
-}
-
-void __init sme_map_bootdata(char *real_mode_data)
-{
-	struct boot_params *boot_data;
-	unsigned long cmdline_paddr;
-
-	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
-		return;
-
-	__sme_early_map_unmap_mem(real_mode_data, sizeof(boot_params), true);
-
-	/* Get the command line address after mapping the real_mode_data */
-	boot_data = (struct boot_params *)real_mode_data;
-	cmdline_paddr = boot_data->hdr.cmd_line_ptr | ((u64)boot_data->ext_cmd_line_ptr << 32);
-
-	if (!cmdline_paddr)
-		return;
-
-	__sme_early_map_unmap_mem(__va(cmdline_paddr), COMMAND_LINE_SIZE, true);
-}
-
-void __init sme_early_init(void)
-{
-	unsigned int i;
-
-	if (!sme_me_mask)
-		return;
-
-	early_pmd_flags = __sme_set(early_pmd_flags);
-
-	__supported_pte_mask = __sme_set(__supported_pte_mask);
-
-	/* Update the protection map with memory encryption mask */
-	for (i = 0; i < ARRAY_SIZE(protection_map); i++)
-		protection_map[i] = pgprot_encrypted(protection_map[i]);
-
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
-		swiotlb_force = SWIOTLB_FORCE;
-}
-
-void __init sev_setup_arch(void)
-{
-	phys_addr_t total_mem = memblock_phys_mem_size();
-	unsigned long size;
-
-	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
-		return;
-
-	/*
-	 * For SEV, all DMA has to occur via shared/unencrypted pages.
-	 * SEV uses SWIOTLB to make this happen without changing device
-	 * drivers. However, depending on the workload being run, the
-	 * default 64MB of SWIOTLB may not be enough and SWIOTLB may
-	 * run out of buffers for DMA, resulting in I/O errors and/or
-	 * performance degradation especially with high I/O workloads.
-	 *
-	 * Adjust the default size of SWIOTLB for SEV guests using
-	 * a percentage of guest memory for SWIOTLB buffers.
-	 * Also, as the SWIOTLB bounce buffer memory is allocated
-	 * from low memory, ensure that the adjusted size is within
-	 * the limits of low available memory.
-	 *
-	 * The percentage of guest memory used here for SWIOTLB buffers
-	 * is more of an approximation of the static adjustment which
-	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
-	 */
-	size = total_mem * 6 / 100;
-	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
-	swiotlb_adjust_size(size);
-}
-
-static unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot)
-{
-	unsigned long pfn = 0;
-	pgprot_t prot;
-
-	switch (level) {
-	case PG_LEVEL_4K:
-		pfn = pte_pfn(*kpte);
-		prot = pte_pgprot(*kpte);
-		break;
-	case PG_LEVEL_2M:
-		pfn = pmd_pfn(*(pmd_t *)kpte);
-		prot = pmd_pgprot(*(pmd_t *)kpte);
-		break;
-	case PG_LEVEL_1G:
-		pfn = pud_pfn(*(pud_t *)kpte);
-		prot = pud_pgprot(*(pud_t *)kpte);
-		break;
-	default:
-		WARN_ONCE(1, "Invalid level for kpte\n");
-		return 0;
-	}
-
-	if (ret_prot)
-		*ret_prot = prot;
-
-	return pfn;
-}
-
-void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc)
-{
-#ifdef CONFIG_PARAVIRT
-	unsigned long sz = npages << PAGE_SHIFT;
-	unsigned long vaddr_end = vaddr + sz;
-
-	while (vaddr < vaddr_end) {
-		int psize, pmask, level;
-		unsigned long pfn;
-		pte_t *kpte;
-
-		kpte = lookup_address(vaddr, &level);
-		if (!kpte || pte_none(*kpte)) {
-			WARN_ONCE(1, "kpte lookup for vaddr\n");
-			return;
-		}
-
-		pfn = pg_level_to_pfn(level, kpte, NULL);
-		if (!pfn)
-			continue;
-
-		psize = page_level_size(level);
-		pmask = page_level_mask(level);
-
-		notify_page_enc_status_changed(pfn, psize >> PAGE_SHIFT, enc);
-
-		vaddr = (vaddr & pmask) + psize;
-	}
-#endif
-}
-
-static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
-{
-	pgprot_t old_prot, new_prot;
-	unsigned long pfn, pa, size;
-	pte_t new_pte;
-
-	pfn = pg_level_to_pfn(level, kpte, &old_prot);
-	if (!pfn)
-		return;
-
-	new_prot = old_prot;
-	if (enc)
-		pgprot_val(new_prot) |= _PAGE_ENC;
-	else
-		pgprot_val(new_prot) &= ~_PAGE_ENC;
-
-	/* If prot is same then do nothing. */
-	if (pgprot_val(old_prot) == pgprot_val(new_prot))
-		return;
-
-	pa = pfn << PAGE_SHIFT;
-	size = page_level_size(level);
-
-	/*
-	 * We are going to perform in-place en-/decryption and change the
-	 * physical page attribute from C=1 to C=0 or vice versa. Flush the
-	 * caches to ensure that data gets accessed with the correct C-bit.
-	 */
-	clflush_cache_range(__va(pa), size);
-
-	/* Encrypt/decrypt the contents in-place */
-	if (enc)
-		sme_early_encrypt(pa, size);
-	else
-		sme_early_decrypt(pa, size);
-
-	/* Change the page encryption mask. */
-	new_pte = pfn_pte(pfn, new_prot);
-	set_pte_atomic(kpte, new_pte);
-}
-
-static int __init early_set_memory_enc_dec(unsigned long vaddr,
-					   unsigned long size, bool enc)
-{
-	unsigned long vaddr_end, vaddr_next, start;
-	unsigned long psize, pmask;
-	int split_page_size_mask;
-	int level, ret;
-	pte_t *kpte;
-
-	start = vaddr;
-	vaddr_next = vaddr;
-	vaddr_end = vaddr + size;
-
-	for (; vaddr < vaddr_end; vaddr = vaddr_next) {
-		kpte = lookup_address(vaddr, &level);
-		if (!kpte || pte_none(*kpte)) {
-			ret = 1;
-			goto out;
-		}
-
-		if (level == PG_LEVEL_4K) {
-			__set_clr_pte_enc(kpte, level, enc);
-			vaddr_next = (vaddr & PAGE_MASK) + PAGE_SIZE;
-			continue;
-		}
-
-		psize = page_level_size(level);
-		pmask = page_level_mask(level);
-
-		/*
-		 * Check whether we can change the large page in one go.
-		 * We request a split when the address is not aligned and
-		 * the number of pages to set/clear encryption bit is smaller
-		 * than the number of pages in the large page.
-		 */
-		if (vaddr == (vaddr & pmask) &&
-		    ((vaddr_end - vaddr) >= psize)) {
-			__set_clr_pte_enc(kpte, level, enc);
-			vaddr_next = (vaddr & pmask) + psize;
-			continue;
-		}
-
-		/*
-		 * The virtual address is part of a larger page, create the next
-		 * level page table mapping (4K or 2M). If it is part of a 2M
-		 * page then we request a split of the large page into 4K
-		 * chunks. A 1GB large page is split into 2M pages, resp.
-		 */
-		if (level == PG_LEVEL_2M)
-			split_page_size_mask = 0;
-		else
-			split_page_size_mask = 1 << PG_LEVEL_2M;
-
-		/*
-		 * kernel_physical_mapping_change() does not flush the TLBs, so
-		 * a TLB flush is required after we exit from the for loop.
-		 */
-		kernel_physical_mapping_change(__pa(vaddr & pmask),
-					       __pa((vaddr_end & pmask) + psize),
-					       split_page_size_mask);
-	}
-
-	ret = 0;
-
-	notify_range_enc_status_changed(start, PAGE_ALIGN(size) >> PAGE_SHIFT, enc);
-out:
-	__flush_tlb_all();
-	return ret;
-}
-
-int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size)
-{
-	return early_set_memory_enc_dec(vaddr, size, false);
-}
-
-int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
-{
-	return early_set_memory_enc_dec(vaddr, size, true);
-}
-
-void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages, bool enc)
-{
-	notify_range_enc_status_changed(vaddr, npages, enc);
-}
-
-/* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
-bool force_dma_unencrypted(struct device *dev)
-{
-	/*
-	 * For SEV, all DMA must be to unencrypted addresses.
-	 */
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
-		return true;
-
-	/*
-	 * For SME, all DMA must be to unencrypted addresses if the
-	 * device does not support DMA to addresses that include the
-	 * encryption mask.
-	 */
-	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
-		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
-		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
-						dev->bus_dma_limit);
-
-		if (dma_dev_mask <= dma_enc_mask)
-			return true;
-	}
-
-	return false;
-}
-
-void __init mem_encrypt_free_decrypted_mem(void)
-{
-	unsigned long vaddr, vaddr_end, npages;
-	int r;
-
-	vaddr = (unsigned long)__start_bss_decrypted_unused;
-	vaddr_end = (unsigned long)__end_bss_decrypted;
-	npages = (vaddr_end - vaddr) >> PAGE_SHIFT;
-
-	/*
-	 * The unused memory range was mapped decrypted, change the encryption
-	 * attribute from decrypted to encrypted before freeing it.
-	 */
-	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
-		r = set_memory_encrypted(vaddr, npages);
-		if (r) {
-			pr_warn("failed to free unused decrypted pages\n");
-			return;
-		}
-	}
-
-	free_init_pages("unused decrypted", vaddr, vaddr_end);
-}
-
-static void print_mem_encrypt_feature_info(void)
-{
-	pr_info("AMD Memory Encryption Features active:");
-
-	/* Secure Memory Encryption */
-	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
-		/*
-		 * SME is mutually exclusive with any of the SEV
-		 * features below.
-		 */
-		pr_cont(" SME\n");
-		return;
-	}
-
-	/* Secure Encrypted Virtualization */
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
-		pr_cont(" SEV");
-
-	/* Encrypted Register State */
-	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
-		pr_cont(" SEV-ES");
-
-	pr_cont("\n");
-}
-
-/* Architecture __weak replacement functions */
-void __init mem_encrypt_init(void)
-{
-	if (!sme_me_mask)
-		return;
-
-	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
-	swiotlb_update_mem_attributes();
-
-	print_mem_encrypt_feature_info();
-}
-
-int arch_has_restricted_virtio_memory_access(void)
-{
-	return cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
-}
-EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
new file mode 100644
index 0000000..b520021
--- /dev/null
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -0,0 +1,507 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Memory Encryption Support
+ *
+ * Copyright (C) 2016 Advanced Micro Devices, Inc.
+ *
+ * Author: Tom Lendacky <thomas.lendacky@amd.com>
+ */
+
+#define DISABLE_BRANCH_PROFILING
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/dma-direct.h>
+#include <linux/swiotlb.h>
+#include <linux/mem_encrypt.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/dma-mapping.h>
+#include <linux/virtio_config.h>
+#include <linux/cc_platform.h>
+
+#include <asm/tlbflush.h>
+#include <asm/fixmap.h>
+#include <asm/setup.h>
+#include <asm/bootparam.h>
+#include <asm/set_memory.h>
+#include <asm/cacheflush.h>
+#include <asm/processor-flags.h>
+#include <asm/msr.h>
+#include <asm/cmdline.h>
+
+#include "mm_internal.h"
+
+/*
+ * Since SME related variables are set early in the boot process they must
+ * reside in the .data section so as not to be zeroed out when the .bss
+ * section is later cleared.
+ */
+u64 sme_me_mask __section(".data") = 0;
+u64 sev_status __section(".data") = 0;
+u64 sev_check_data __section(".data") = 0;
+EXPORT_SYMBOL(sme_me_mask);
+
+/* Buffer used for early in-place encryption by BSP, no locking needed */
+static char sme_early_buffer[PAGE_SIZE] __initdata __aligned(PAGE_SIZE);
+
+/*
+ * This routine does not change the underlying encryption setting of the
+ * page(s) that map this memory. It assumes that eventually the memory is
+ * meant to be accessed as either encrypted or decrypted but the contents
+ * are currently not in the desired state.
+ *
+ * This routine follows the steps outlined in the AMD64 Architecture
+ * Programmer's Manual Volume 2, Section 7.10.8 Encrypt-in-Place.
+ */
+static void __init __sme_early_enc_dec(resource_size_t paddr,
+				       unsigned long size, bool enc)
+{
+	void *src, *dst;
+	size_t len;
+
+	if (!sme_me_mask)
+		return;
+
+	wbinvd();
+
+	/*
+	 * There are limited number of early mapping slots, so map (at most)
+	 * one page at time.
+	 */
+	while (size) {
+		len = min_t(size_t, sizeof(sme_early_buffer), size);
+
+		/*
+		 * Create mappings for the current and desired format of
+		 * the memory. Use a write-protected mapping for the source.
+		 */
+		src = enc ? early_memremap_decrypted_wp(paddr, len) :
+			    early_memremap_encrypted_wp(paddr, len);
+
+		dst = enc ? early_memremap_encrypted(paddr, len) :
+			    early_memremap_decrypted(paddr, len);
+
+		/*
+		 * If a mapping can't be obtained to perform the operation,
+		 * then eventual access of that area in the desired mode
+		 * will cause a crash.
+		 */
+		BUG_ON(!src || !dst);
+
+		/*
+		 * Use a temporary buffer, of cache-line multiple size, to
+		 * avoid data corruption as documented in the APM.
+		 */
+		memcpy(sme_early_buffer, src, len);
+		memcpy(dst, sme_early_buffer, len);
+
+		early_memunmap(dst, len);
+		early_memunmap(src, len);
+
+		paddr += len;
+		size -= len;
+	}
+}
+
+void __init sme_early_encrypt(resource_size_t paddr, unsigned long size)
+{
+	__sme_early_enc_dec(paddr, size, true);
+}
+
+void __init sme_early_decrypt(resource_size_t paddr, unsigned long size)
+{
+	__sme_early_enc_dec(paddr, size, false);
+}
+
+static void __init __sme_early_map_unmap_mem(void *vaddr, unsigned long size,
+					     bool map)
+{
+	unsigned long paddr = (unsigned long)vaddr - __PAGE_OFFSET;
+	pmdval_t pmd_flags, pmd;
+
+	/* Use early_pmd_flags but remove the encryption mask */
+	pmd_flags = __sme_clr(early_pmd_flags);
+
+	do {
+		pmd = map ? (paddr & PMD_MASK) + pmd_flags : 0;
+		__early_make_pgtable((unsigned long)vaddr, pmd);
+
+		vaddr += PMD_SIZE;
+		paddr += PMD_SIZE;
+		size = (size <= PMD_SIZE) ? 0 : size - PMD_SIZE;
+	} while (size);
+
+	flush_tlb_local();
+}
+
+void __init sme_unmap_bootdata(char *real_mode_data)
+{
+	struct boot_params *boot_data;
+	unsigned long cmdline_paddr;
+
+	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
+		return;
+
+	/* Get the command line address before unmapping the real_mode_data */
+	boot_data = (struct boot_params *)real_mode_data;
+	cmdline_paddr = boot_data->hdr.cmd_line_ptr | ((u64)boot_data->ext_cmd_line_ptr << 32);
+
+	__sme_early_map_unmap_mem(real_mode_data, sizeof(boot_params), false);
+
+	if (!cmdline_paddr)
+		return;
+
+	__sme_early_map_unmap_mem(__va(cmdline_paddr), COMMAND_LINE_SIZE, false);
+}
+
+void __init sme_map_bootdata(char *real_mode_data)
+{
+	struct boot_params *boot_data;
+	unsigned long cmdline_paddr;
+
+	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
+		return;
+
+	__sme_early_map_unmap_mem(real_mode_data, sizeof(boot_params), true);
+
+	/* Get the command line address after mapping the real_mode_data */
+	boot_data = (struct boot_params *)real_mode_data;
+	cmdline_paddr = boot_data->hdr.cmd_line_ptr | ((u64)boot_data->ext_cmd_line_ptr << 32);
+
+	if (!cmdline_paddr)
+		return;
+
+	__sme_early_map_unmap_mem(__va(cmdline_paddr), COMMAND_LINE_SIZE, true);
+}
+
+void __init sme_early_init(void)
+{
+	unsigned int i;
+
+	if (!sme_me_mask)
+		return;
+
+	early_pmd_flags = __sme_set(early_pmd_flags);
+
+	__supported_pte_mask = __sme_set(__supported_pte_mask);
+
+	/* Update the protection map with memory encryption mask */
+	for (i = 0; i < ARRAY_SIZE(protection_map); i++)
+		protection_map[i] = pgprot_encrypted(protection_map[i]);
+
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		swiotlb_force = SWIOTLB_FORCE;
+}
+
+void __init sev_setup_arch(void)
+{
+	phys_addr_t total_mem = memblock_phys_mem_size();
+	unsigned long size;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return;
+
+	/*
+	 * For SEV, all DMA has to occur via shared/unencrypted pages.
+	 * SEV uses SWIOTLB to make this happen without changing device
+	 * drivers. However, depending on the workload being run, the
+	 * default 64MB of SWIOTLB may not be enough and SWIOTLB may
+	 * run out of buffers for DMA, resulting in I/O errors and/or
+	 * performance degradation especially with high I/O workloads.
+	 *
+	 * Adjust the default size of SWIOTLB for SEV guests using
+	 * a percentage of guest memory for SWIOTLB buffers.
+	 * Also, as the SWIOTLB bounce buffer memory is allocated
+	 * from low memory, ensure that the adjusted size is within
+	 * the limits of low available memory.
+	 *
+	 * The percentage of guest memory used here for SWIOTLB buffers
+	 * is more of an approximation of the static adjustment which
+	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
+	 */
+	size = total_mem * 6 / 100;
+	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
+	swiotlb_adjust_size(size);
+}
+
+static unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot)
+{
+	unsigned long pfn = 0;
+	pgprot_t prot;
+
+	switch (level) {
+	case PG_LEVEL_4K:
+		pfn = pte_pfn(*kpte);
+		prot = pte_pgprot(*kpte);
+		break;
+	case PG_LEVEL_2M:
+		pfn = pmd_pfn(*(pmd_t *)kpte);
+		prot = pmd_pgprot(*(pmd_t *)kpte);
+		break;
+	case PG_LEVEL_1G:
+		pfn = pud_pfn(*(pud_t *)kpte);
+		prot = pud_pgprot(*(pud_t *)kpte);
+		break;
+	default:
+		WARN_ONCE(1, "Invalid level for kpte\n");
+		return 0;
+	}
+
+	if (ret_prot)
+		*ret_prot = prot;
+
+	return pfn;
+}
+
+void notify_range_enc_status_changed(unsigned long vaddr, int npages, bool enc)
+{
+#ifdef CONFIG_PARAVIRT
+	unsigned long sz = npages << PAGE_SHIFT;
+	unsigned long vaddr_end = vaddr + sz;
+
+	while (vaddr < vaddr_end) {
+		int psize, pmask, level;
+		unsigned long pfn;
+		pte_t *kpte;
+
+		kpte = lookup_address(vaddr, &level);
+		if (!kpte || pte_none(*kpte)) {
+			WARN_ONCE(1, "kpte lookup for vaddr\n");
+			return;
+		}
+
+		pfn = pg_level_to_pfn(level, kpte, NULL);
+		if (!pfn)
+			continue;
+
+		psize = page_level_size(level);
+		pmask = page_level_mask(level);
+
+		notify_page_enc_status_changed(pfn, psize >> PAGE_SHIFT, enc);
+
+		vaddr = (vaddr & pmask) + psize;
+	}
+#endif
+}
+
+static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
+{
+	pgprot_t old_prot, new_prot;
+	unsigned long pfn, pa, size;
+	pte_t new_pte;
+
+	pfn = pg_level_to_pfn(level, kpte, &old_prot);
+	if (!pfn)
+		return;
+
+	new_prot = old_prot;
+	if (enc)
+		pgprot_val(new_prot) |= _PAGE_ENC;
+	else
+		pgprot_val(new_prot) &= ~_PAGE_ENC;
+
+	/* If prot is same then do nothing. */
+	if (pgprot_val(old_prot) == pgprot_val(new_prot))
+		return;
+
+	pa = pfn << PAGE_SHIFT;
+	size = page_level_size(level);
+
+	/*
+	 * We are going to perform in-place en-/decryption and change the
+	 * physical page attribute from C=1 to C=0 or vice versa. Flush the
+	 * caches to ensure that data gets accessed with the correct C-bit.
+	 */
+	clflush_cache_range(__va(pa), size);
+
+	/* Encrypt/decrypt the contents in-place */
+	if (enc)
+		sme_early_encrypt(pa, size);
+	else
+		sme_early_decrypt(pa, size);
+
+	/* Change the page encryption mask. */
+	new_pte = pfn_pte(pfn, new_prot);
+	set_pte_atomic(kpte, new_pte);
+}
+
+static int __init early_set_memory_enc_dec(unsigned long vaddr,
+					   unsigned long size, bool enc)
+{
+	unsigned long vaddr_end, vaddr_next, start;
+	unsigned long psize, pmask;
+	int split_page_size_mask;
+	int level, ret;
+	pte_t *kpte;
+
+	start = vaddr;
+	vaddr_next = vaddr;
+	vaddr_end = vaddr + size;
+
+	for (; vaddr < vaddr_end; vaddr = vaddr_next) {
+		kpte = lookup_address(vaddr, &level);
+		if (!kpte || pte_none(*kpte)) {
+			ret = 1;
+			goto out;
+		}
+
+		if (level == PG_LEVEL_4K) {
+			__set_clr_pte_enc(kpte, level, enc);
+			vaddr_next = (vaddr & PAGE_MASK) + PAGE_SIZE;
+			continue;
+		}
+
+		psize = page_level_size(level);
+		pmask = page_level_mask(level);
+
+		/*
+		 * Check whether we can change the large page in one go.
+		 * We request a split when the address is not aligned and
+		 * the number of pages to set/clear encryption bit is smaller
+		 * than the number of pages in the large page.
+		 */
+		if (vaddr == (vaddr & pmask) &&
+		    ((vaddr_end - vaddr) >= psize)) {
+			__set_clr_pte_enc(kpte, level, enc);
+			vaddr_next = (vaddr & pmask) + psize;
+			continue;
+		}
+
+		/*
+		 * The virtual address is part of a larger page, create the next
+		 * level page table mapping (4K or 2M). If it is part of a 2M
+		 * page then we request a split of the large page into 4K
+		 * chunks. A 1GB large page is split into 2M pages, resp.
+		 */
+		if (level == PG_LEVEL_2M)
+			split_page_size_mask = 0;
+		else
+			split_page_size_mask = 1 << PG_LEVEL_2M;
+
+		/*
+		 * kernel_physical_mapping_change() does not flush the TLBs, so
+		 * a TLB flush is required after we exit from the for loop.
+		 */
+		kernel_physical_mapping_change(__pa(vaddr & pmask),
+					       __pa((vaddr_end & pmask) + psize),
+					       split_page_size_mask);
+	}
+
+	ret = 0;
+
+	notify_range_enc_status_changed(start, PAGE_ALIGN(size) >> PAGE_SHIFT, enc);
+out:
+	__flush_tlb_all();
+	return ret;
+}
+
+int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size)
+{
+	return early_set_memory_enc_dec(vaddr, size, false);
+}
+
+int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
+{
+	return early_set_memory_enc_dec(vaddr, size, true);
+}
+
+void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages, bool enc)
+{
+	notify_range_enc_status_changed(vaddr, npages, enc);
+}
+
+/* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
+bool force_dma_unencrypted(struct device *dev)
+{
+	/*
+	 * For SEV, all DMA must be to unencrypted addresses.
+	 */
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return true;
+
+	/*
+	 * For SME, all DMA must be to unencrypted addresses if the
+	 * device does not support DMA to addresses that include the
+	 * encryption mask.
+	 */
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
+		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
+		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
+						dev->bus_dma_limit);
+
+		if (dma_dev_mask <= dma_enc_mask)
+			return true;
+	}
+
+	return false;
+}
+
+void __init mem_encrypt_free_decrypted_mem(void)
+{
+	unsigned long vaddr, vaddr_end, npages;
+	int r;
+
+	vaddr = (unsigned long)__start_bss_decrypted_unused;
+	vaddr_end = (unsigned long)__end_bss_decrypted;
+	npages = (vaddr_end - vaddr) >> PAGE_SHIFT;
+
+	/*
+	 * The unused memory range was mapped decrypted, change the encryption
+	 * attribute from decrypted to encrypted before freeing it.
+	 */
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
+		r = set_memory_encrypted(vaddr, npages);
+		if (r) {
+			pr_warn("failed to free unused decrypted pages\n");
+			return;
+		}
+	}
+
+	free_init_pages("unused decrypted", vaddr, vaddr_end);
+}
+
+static void print_mem_encrypt_feature_info(void)
+{
+	pr_info("AMD Memory Encryption Features active:");
+
+	/* Secure Memory Encryption */
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
+		/*
+		 * SME is mutually exclusive with any of the SEV
+		 * features below.
+		 */
+		pr_cont(" SME\n");
+		return;
+	}
+
+	/* Secure Encrypted Virtualization */
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		pr_cont(" SEV");
+
+	/* Encrypted Register State */
+	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+		pr_cont(" SEV-ES");
+
+	pr_cont("\n");
+}
+
+/* Architecture __weak replacement functions */
+void __init mem_encrypt_init(void)
+{
+	if (!sme_me_mask)
+		return;
+
+	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
+	swiotlb_update_mem_attributes();
+
+	print_mem_encrypt_feature_info();
+}
+
+int arch_has_restricted_virtio_memory_access(void)
+{
+	return cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
+}
+EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
