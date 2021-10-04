Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1DB420A36
	for <lists+linux-tip-commits@lfdr.de>; Mon,  4 Oct 2021 13:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbhJDLnT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 4 Oct 2021 07:43:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43652 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbhJDLnS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 4 Oct 2021 07:43:18 -0400
Date:   Mon, 04 Oct 2021 11:41:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633347688;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z5OT2XITwIPV65TZQ5p4MQfbwl2F0VrYI7/c2gjY58w=;
        b=yFKUbNYv1BWVcL1VGvWMyAoCSE4TZdLmDmw+SHKAtsZxK+3New9lmESPUIeDFjFqmnjgm3
        q8TEYUlEVV/LQOyk5U91Pb2JXpcs9iNVq5AbkiHwvHIu3neZluopg54lXKBSSSrTngoBBy
        6p927l0omGl4hY0ro2xT971fgvxk8tQ3aA4KDRY/lXovPu8kirGaXomtfVwDE/S7tMq9NL
        npbp5hqLte+011HZqBT/rA8f47Ee6IVY0lYoijaWUVkUrJe4aCPdIs/NYCnpR9FuULaeg0
        KxkK4oE21Fyc3KQHJJEmWf20OvTA1agkv0cyT5GC+UrsT/a1LLlIB25Iq9IAJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633347688;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z5OT2XITwIPV65TZQ5p4MQfbwl2F0VrYI7/c2gjY58w=;
        b=CKFagAT2bTPc3SeKF6VJcyiNgx+OMGswxGAaScNXvMwGEw3I8Dsl7wolPhtOoWHR01QNSt
        23izXMSuBvUeMJBw==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/sme: Replace occurrences of sme_active() with
 cc_platform_has()
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210928191009.32551-6-bp@alien8.de>
References: <20210928191009.32551-6-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163334768801.25758.1480760844945576892.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     32cb4d02fb02cae2e0696c1ce92d8195574faf59
Gitweb:        https://git.kernel.org/tip/32cb4d02fb02cae2e0696c1ce92d8195574faf59
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 08 Sep 2021 17:58:36 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Oct 2021 11:46:46 +02:00

x86/sme: Replace occurrences of sme_active() with cc_platform_has()

Replace uses of sme_active() with the more generic cc_platform_has()
using CC_ATTR_HOST_MEM_ENCRYPT. If future support is added for other
memory encryption technologies, the use of CC_ATTR_HOST_MEM_ENCRYPT
can be updated, as required.

This also replaces two usages of sev_active() that are really geared
towards detecting if SME is active.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210928191009.32551-6-bp@alien8.de
---
 arch/x86/include/asm/kexec.h         |  2 +-
 arch/x86/include/asm/mem_encrypt.h   |  2 --
 arch/x86/kernel/machine_kexec_64.c   | 15 ++++++++-------
 arch/x86/kernel/pci-swiotlb.c        |  9 ++++-----
 arch/x86/kernel/relocate_kernel_64.S |  2 +-
 arch/x86/mm/ioremap.c                |  6 +++---
 arch/x86/mm/mem_encrypt.c            | 13 ++++---------
 arch/x86/mm/mem_encrypt_identity.c   |  9 ++++++++-
 arch/x86/realmode/init.c             |  5 +++--
 drivers/iommu/amd/init.c             |  7 ++++---
 10 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 0a6e34b..11b7c06 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -129,7 +129,7 @@ relocate_kernel(unsigned long indirection_page,
 		unsigned long page_list,
 		unsigned long start_address,
 		unsigned int preserve_context,
-		unsigned int sme_active);
+		unsigned int host_mem_enc_active);
 #endif
 
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 3fb9f5e..63c5b99 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -51,7 +51,6 @@ void __init mem_encrypt_free_decrypted_mem(void);
 void __init mem_encrypt_init(void);
 
 void __init sev_es_init_vc_handling(void);
-bool sme_active(void);
 bool sev_active(void);
 bool sev_es_active(void);
 
@@ -76,7 +75,6 @@ static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
 static inline void __init sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
-static inline bool sme_active(void) { return false; }
 static inline bool sev_active(void) { return false; }
 static inline bool sev_es_active(void) { return false; }
 
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 131f30f..7040c0f 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -17,6 +17,7 @@
 #include <linux/suspend.h>
 #include <linux/vmalloc.h>
 #include <linux/efi.h>
+#include <linux/cc_platform.h>
 
 #include <asm/init.h>
 #include <asm/tlbflush.h>
@@ -358,7 +359,7 @@ void machine_kexec(struct kimage *image)
 				       (unsigned long)page_list,
 				       image->start,
 				       image->preserve_context,
-				       sme_active());
+				       cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT));
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)
@@ -569,12 +570,12 @@ void arch_kexec_unprotect_crashkres(void)
  */
 int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
 {
-	if (sev_active())
+	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		return 0;
 
 	/*
-	 * If SME is active we need to be sure that kexec pages are
-	 * not encrypted because when we boot to the new kernel the
+	 * If host memory encryption is active we need to be sure that kexec
+	 * pages are not encrypted because when we boot to the new kernel the
 	 * pages won't be accessed encrypted (initially).
 	 */
 	return set_memory_decrypted((unsigned long)vaddr, pages);
@@ -582,12 +583,12 @@ int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
 
 void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages)
 {
-	if (sev_active())
+	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		return;
 
 	/*
-	 * If SME is active we need to reset the pages back to being
-	 * an encrypted mapping before freeing them.
+	 * If host memory encryption is active we need to reset the pages back
+	 * to being an encrypted mapping before freeing them.
 	 */
 	set_memory_encrypted((unsigned long)vaddr, pages);
 }
diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
index c2cfa5e..814ab46 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -6,7 +6,7 @@
 #include <linux/swiotlb.h>
 #include <linux/memblock.h>
 #include <linux/dma-direct.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 
 #include <asm/iommu.h>
 #include <asm/swiotlb.h>
@@ -45,11 +45,10 @@ int __init pci_swiotlb_detect_4gb(void)
 		swiotlb = 1;
 
 	/*
-	 * If SME is active then swiotlb will be set to 1 so that bounce
-	 * buffers are allocated and used for devices that do not support
-	 * the addressing range required for the encryption mask.
+	 * Set swiotlb to 1 so that bounce buffers are allocated and used for
+	 * devices that can't support DMA to encrypted memory.
 	 */
-	if (sme_active())
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		swiotlb = 1;
 
 	return swiotlb;
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index c53271a..c8fe74a 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -47,7 +47,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	 * %rsi page_list
 	 * %rdx start address
 	 * %rcx preserve_context
-	 * %r8  sme_active
+	 * %r8  host_mem_enc_active
 	 */
 
 	/* Save the CPU context, used for jumping back */
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index ccff76c..a7250fa 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -14,7 +14,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/mmiotrace.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 #include <linux/efi.h>
 #include <linux/pgtable.h>
 
@@ -703,7 +703,7 @@ bool arch_memremap_can_ram_remap(resource_size_t phys_addr, unsigned long size,
 	if (flags & MEMREMAP_DEC)
 		return false;
 
-	if (sme_active()) {
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
 		if (memremap_is_setup_data(phys_addr, size) ||
 		    memremap_is_efi_data(phys_addr, size))
 			return false;
@@ -729,7 +729,7 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
 
 	encrypted_prot = true;
 
-	if (sme_active()) {
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
 		if (early_memremap_is_setup_data(phys_addr, size) ||
 		    memremap_is_efi_data(phys_addr, size))
 			encrypted_prot = false;
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index e29b141..2163485 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -144,7 +144,7 @@ void __init sme_unmap_bootdata(char *real_mode_data)
 	struct boot_params *boot_data;
 	unsigned long cmdline_paddr;
 
-	if (!sme_active())
+	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		return;
 
 	/* Get the command line address before unmapping the real_mode_data */
@@ -164,7 +164,7 @@ void __init sme_map_bootdata(char *real_mode_data)
 	struct boot_params *boot_data;
 	unsigned long cmdline_paddr;
 
-	if (!sme_active())
+	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		return;
 
 	__sme_early_map_unmap_mem(real_mode_data, sizeof(boot_params), true);
@@ -377,11 +377,6 @@ bool sev_active(void)
 {
 	return sev_status & MSR_AMD64_SEV_ENABLED;
 }
-
-bool sme_active(void)
-{
-	return sme_me_mask && !sev_active();
-}
 EXPORT_SYMBOL_GPL(sev_active);
 
 /* Needs to be called from non-instrumentable code */
@@ -404,7 +399,7 @@ bool force_dma_unencrypted(struct device *dev)
 	 * device does not support DMA to addresses that include the
 	 * encryption mask.
 	 */
-	if (sme_active()) {
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
 		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
 		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
 						dev->bus_dma_limit);
@@ -445,7 +440,7 @@ static void print_mem_encrypt_feature_info(void)
 	pr_info("AMD Memory Encryption Features active:");
 
 	/* Secure Memory Encryption */
-	if (sme_active()) {
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
 		/*
 		 * SME is mutually exclusive with any of the SEV
 		 * features below.
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 470b202..f8c6129 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -30,6 +30,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 
 #include <asm/setup.h>
 #include <asm/sections.h>
@@ -287,7 +288,13 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	unsigned long pgtable_area_len;
 	unsigned long decrypted_base;
 
-	if (!sme_active())
+	/*
+	 * This is early code, use an open coded check for SME instead of
+	 * using cc_platform_has(). This eliminates worries about removing
+	 * instrumentation or checking boot_cpu_data in the cc_platform_has()
+	 * function.
+	 */
+	if (!sme_get_me_mask() || sev_status & MSR_AMD64_SEV_ENABLED)
 		return;
 
 	/*
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 31b5856..c878c5e 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -3,6 +3,7 @@
 #include <linux/slab.h>
 #include <linux/memblock.h>
 #include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 #include <linux/pgtable.h>
 
 #include <asm/set_memory.h>
@@ -44,7 +45,7 @@ void __init reserve_real_mode(void)
 static void sme_sev_setup_real_mode(struct trampoline_header *th)
 {
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-	if (sme_active())
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		th->flags |= TH_FLAGS_SME_ACTIVE;
 
 	if (sev_es_active()) {
@@ -81,7 +82,7 @@ static void __init setup_real_mode(void)
 	 * decrypted memory in order to bring up other processors
 	 * successfully. This is not needed for SEV.
 	 */
-	if (sme_active())
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		set_memory_decrypted((unsigned long)base, size >> PAGE_SHIFT);
 
 	memcpy(base, real_mode_blob, size);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 2a822b2..c6c53e1 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -20,7 +20,7 @@
 #include <linux/amd-iommu.h>
 #include <linux/export.h>
 #include <linux/kmemleak.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 #include <asm/pci-direct.h>
 #include <asm/iommu.h>
 #include <asm/apic.h>
@@ -964,7 +964,7 @@ static bool copy_device_table(void)
 		pr_err("The address of old device table is above 4G, not trustworthy!\n");
 		return false;
 	}
-	old_devtb = (sme_active() && is_kdump_kernel())
+	old_devtb = (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) && is_kdump_kernel())
 		    ? (__force void *)ioremap_encrypted(old_devtb_phys,
 							dev_table_size)
 		    : memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
@@ -3032,7 +3032,8 @@ static int __init amd_iommu_init(void)
 
 static bool amd_iommu_sme_check(void)
 {
-	if (!sme_active() || (boot_cpu_data.x86 != 0x17))
+	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) ||
+	    (boot_cpu_data.x86 != 0x17))
 		return true;
 
 	/* For Fam17h, a specific level of support is required */
