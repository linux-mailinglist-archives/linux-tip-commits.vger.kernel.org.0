Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6C1420A34
	for <lists+linux-tip-commits@lfdr.de>; Mon,  4 Oct 2021 13:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhJDLnR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 4 Oct 2021 07:43:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43626 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhJDLnQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 4 Oct 2021 07:43:16 -0400
Date:   Mon, 04 Oct 2021 11:41:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633347686;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rmuxU4u0efRq9uyiTV3hX7xbu16EyhRLod1WJAS03BQ=;
        b=BPs6R1RlL+shWe+o8/ZWqM3tjFdNKy8MKV/GSlNR6kXFfjf46liHC6KkTdUYUBt0pduSlK
        FlKFjThYaLE0uWVWuI8ti1WhwlUZ49PGjOGjJvTc2H0CwbR+PzI2NnD7+Ke7XGuAbSW9sC
        A7Os08LeY+Fn1th7xG8DOd35esQLC6pINctWva7rhC5OpjrApKkU9WUgdP6m9whL7+SAkz
        GVP3KBDvu8YMdJUUkEr7adqb87XW766O24HQS4mCY9JoyJEK2vWZna2g5aJU5YbwloBEii
        U4XIuTR3ZhpDCthaeC8fR0DVl/24zRdn1zWKFpv1/o2T8AjlF1adMf0Htqk8Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633347686;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rmuxU4u0efRq9uyiTV3hX7xbu16EyhRLod1WJAS03BQ=;
        b=OH0AzWVciUxE24v1sh+12ExXdCNqFLirAfIfJy/LyY0/dICqm9K6bJSm/OdYGB9aXhPpeB
        PXhN/XrqoS+31WBA==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] treewide: Replace the use of mem_encrypt_active() with
 cc_platform_has()
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210928191009.32551-9-bp@alien8.de>
References: <20210928191009.32551-9-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163334768551.25758.4978107241227491428.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     e9d1d2bb75b2d5d4b426769c5aae0ce8cef3558f
Gitweb:        https://git.kernel.org/tip/e9d1d2bb75b2d5d4b426769c5aae0ce8cef3558f
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 08 Sep 2021 17:58:39 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Oct 2021 11:47:24 +02:00

treewide: Replace the use of mem_encrypt_active() with cc_platform_has()

Replace uses of mem_encrypt_active() with calls to cc_platform_has() with
the CC_ATTR_MEM_ENCRYPT attribute.

Remove the implementation of mem_encrypt_active() across all arches.

For s390, since the default implementation of the cc_platform_has()
matches the s390 implementation of mem_encrypt_active(), cc_platform_has()
does not need to be implemented in s390 (the config option
ARCH_HAS_CC_PLATFORM is not set).

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210928191009.32551-9-bp@alien8.de
---
 arch/powerpc/include/asm/mem_encrypt.h  |  5 -----
 arch/powerpc/platforms/pseries/svm.c    |  5 +++--
 arch/s390/include/asm/mem_encrypt.h     |  2 --
 arch/x86/include/asm/mem_encrypt.h      |  5 -----
 arch/x86/kernel/head64.c                |  9 +++++++--
 arch/x86/mm/ioremap.c                   |  4 ++--
 arch/x86/mm/mem_encrypt.c               |  2 +-
 arch/x86/mm/pat/set_memory.c            |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  4 +++-
 drivers/gpu/drm/drm_cache.c             |  4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     |  4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c     |  6 +++---
 drivers/iommu/amd/iommu.c               |  3 ++-
 drivers/iommu/amd/iommu_v2.c            |  3 ++-
 drivers/iommu/iommu.c                   |  3 ++-
 fs/proc/vmcore.c                        |  6 +++---
 include/linux/mem_encrypt.h             |  4 ----
 kernel/dma/swiotlb.c                    |  4 ++--
 18 files changed, 36 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/include/asm/mem_encrypt.h b/arch/powerpc/include/asm/mem_encrypt.h
index ba9dab0..2f26b8f 100644
--- a/arch/powerpc/include/asm/mem_encrypt.h
+++ b/arch/powerpc/include/asm/mem_encrypt.h
@@ -10,11 +10,6 @@
 
 #include <asm/svm.h>
 
-static inline bool mem_encrypt_active(void)
-{
-	return is_secure_guest();
-}
-
 static inline bool force_dma_unencrypted(struct device *dev)
 {
 	return is_secure_guest();
diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index 87f001b..c083ecb 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -8,6 +8,7 @@
 
 #include <linux/mm.h>
 #include <linux/memblock.h>
+#include <linux/cc_platform.h>
 #include <asm/machdep.h>
 #include <asm/svm.h>
 #include <asm/swiotlb.h>
@@ -63,7 +64,7 @@ void __init svm_swiotlb_init(void)
 
 int set_memory_encrypted(unsigned long addr, int numpages)
 {
-	if (!mem_encrypt_active())
+	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		return 0;
 
 	if (!PAGE_ALIGNED(addr))
@@ -76,7 +77,7 @@ int set_memory_encrypted(unsigned long addr, int numpages)
 
 int set_memory_decrypted(unsigned long addr, int numpages)
 {
-	if (!mem_encrypt_active())
+	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		return 0;
 
 	if (!PAGE_ALIGNED(addr))
diff --git a/arch/s390/include/asm/mem_encrypt.h b/arch/s390/include/asm/mem_encrypt.h
index 2542cbf..08a8b96 100644
--- a/arch/s390/include/asm/mem_encrypt.h
+++ b/arch/s390/include/asm/mem_encrypt.h
@@ -4,8 +4,6 @@
 
 #ifndef __ASSEMBLY__
 
-static inline bool mem_encrypt_active(void) { return false; }
-
 int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
 
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index da14ede..2d4f5c1 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -96,11 +96,6 @@ static inline void mem_encrypt_free_decrypted_mem(void) { }
 
 extern char __start_bss_decrypted[], __end_bss_decrypted[], __start_bss_decrypted_unused[];
 
-static inline bool mem_encrypt_active(void)
-{
-	return sme_me_mask;
-}
-
 static inline u64 sme_get_me_mask(void)
 {
 	return sme_me_mask;
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index de01903..fc5371a 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -19,7 +19,7 @@
 #include <linux/start_kernel.h>
 #include <linux/io.h>
 #include <linux/memblock.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 #include <linux/pgtable.h>
 
 #include <asm/processor.h>
@@ -284,8 +284,13 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * The bss section will be memset to zero later in the initialization so
 	 * there is no need to zero it after changing the memory encryption
 	 * attribute.
+	 *
+	 * This is early code, use an open coded check for SME instead of
+	 * using cc_platform_has(). This eliminates worries about removing
+	 * instrumentation or checking boot_cpu_data in the cc_platform_has()
+	 * function.
 	 */
-	if (mem_encrypt_active()) {
+	if (sme_get_me_mask()) {
 		vaddr = (unsigned long)__start_bss_decrypted;
 		vaddr_end = (unsigned long)__end_bss_decrypted;
 		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index b59a5cb..026031b 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -694,7 +694,7 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
 bool arch_memremap_can_ram_remap(resource_size_t phys_addr, unsigned long size,
 				 unsigned long flags)
 {
-	if (!mem_encrypt_active())
+	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		return true;
 
 	if (flags & MEMREMAP_ENC)
@@ -724,7 +724,7 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
 {
 	bool encrypted_prot;
 
-	if (!mem_encrypt_active())
+	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		return prot;
 
 	encrypted_prot = true;
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 2d04c39..23d54b8 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -400,7 +400,7 @@ void __init mem_encrypt_free_decrypted_mem(void)
 	 * The unused memory range was mapped decrypted, change the encryption
 	 * attribute from decrypted to encrypted before freeing it.
 	 */
-	if (mem_encrypt_active()) {
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
 		r = set_memory_encrypted(vaddr, npages);
 		if (r) {
 			pr_warn("failed to free unused decrypted pages\n");
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index ad8a5c5..5279575 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -18,6 +18,7 @@
 #include <linux/libnvdimm.h>
 #include <linux/vmstat.h>
 #include <linux/kernel.h>
+#include <linux/cc_platform.h>
 
 #include <asm/e820/api.h>
 #include <asm/processor.h>
@@ -1986,7 +1987,7 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	int ret;
 
 	/* Nothing to do if memory encryption is not active */
-	if (!mem_encrypt_active())
+	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		return 0;
 
 	/* Should not be working on unaligned addresses */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f18240f..7741195 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -38,6 +38,7 @@
 #include <drm/drm_probe_helper.h>
 #include <linux/mmu_notifier.h>
 #include <linux/suspend.h>
+#include <linux/cc_platform.h>
 
 #include "amdgpu.h"
 #include "amdgpu_irq.h"
@@ -1269,7 +1270,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	 * however, SME requires an indirect IOMMU mapping because the encryption
 	 * bit is beyond the DMA mask of the chip.
 	 */
-	if (mem_encrypt_active() && ((flags & AMD_ASIC_MASK) == CHIP_RAVEN)) {
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
+	    ((flags & AMD_ASIC_MASK) == CHIP_RAVEN)) {
 		dev_info(&pdev->dev,
 			 "SME is not compatible with RAVEN\n");
 		return -ENOTSUPP;
diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
index 30cc59f..f19d9ac 100644
--- a/drivers/gpu/drm/drm_cache.c
+++ b/drivers/gpu/drm/drm_cache.c
@@ -31,7 +31,7 @@
 #include <linux/dma-buf-map.h>
 #include <linux/export.h>
 #include <linux/highmem.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 #include <xen/xen.h>
 
 #include <drm/drm_cache.h>
@@ -204,7 +204,7 @@ bool drm_need_swiotlb(int dma_bits)
 	 * Enforce dma_alloc_coherent when memory encryption is active as well
 	 * for the same reasons as for Xen paravirtual hosts.
 	 */
-	if (mem_encrypt_active())
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		return true;
 
 	for (tmp = iomem_resource.child; tmp; tmp = tmp->sibling)
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index ab9a175..bfd71c8 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -29,7 +29,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 
 #include <drm/drm_aperture.h>
 #include <drm/drm_drv.h>
@@ -666,7 +666,7 @@ static int vmw_dma_select_mode(struct vmw_private *dev_priv)
 		[vmw_dma_map_bind] = "Giving up DMA mappings early."};
 
 	/* TTM currently doesn't fully support SEV encryption. */
-	if (mem_encrypt_active())
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		return -EINVAL;
 
 	if (vmw_force_coherent)
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index e50fb82..2aceac7 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -28,7 +28,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 
 #include <asm/hypervisor.h>
 #include <drm/drm_ioctl.h>
@@ -160,7 +160,7 @@ static unsigned long vmw_port_hb_out(struct rpc_channel *channel,
 	unsigned long msg_len = strlen(msg);
 
 	/* HB port can't access encrypted memory. */
-	if (hb && !mem_encrypt_active()) {
+	if (hb && !cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
 		unsigned long bp = channel->cookie_high;
 		u32 channel_id = (channel->channel_id << 16);
 
@@ -216,7 +216,7 @@ static unsigned long vmw_port_hb_in(struct rpc_channel *channel, char *reply,
 	unsigned long si, di, eax, ebx, ecx, edx;
 
 	/* HB port can't access encrypted memory */
-	if (hb && !mem_encrypt_active()) {
+	if (hb && !cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
 		unsigned long bp = channel->cookie_low;
 		u32 channel_id = (channel->channel_id << 16);
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 1722bb1..9e5da03 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -31,6 +31,7 @@
 #include <linux/irqdomain.h>
 #include <linux/percpu.h>
 #include <linux/io-pgtable.h>
+#include <linux/cc_platform.h>
 #include <asm/irq_remapping.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
@@ -2238,7 +2239,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
 	 * active, because some of those devices (AMD GPUs) don't have the
 	 * encryption bit in their DMA-mask and require remapping.
 	 */
-	if (!mem_encrypt_active() && dev_data->iommu_v2)
+	if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT) && dev_data->iommu_v2)
 		return IOMMU_DOMAIN_IDENTITY;
 
 	return 0;
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index a9e5682..13cbeb9 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -17,6 +17,7 @@
 #include <linux/wait.h>
 #include <linux/pci.h>
 #include <linux/gfp.h>
+#include <linux/cc_platform.h>
 
 #include "amd_iommu.h"
 
@@ -742,7 +743,7 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 	 * When memory encryption is active the device is likely not in a
 	 * direct-mapped domain. Forbid using IOMMUv2 functionality for now.
 	 */
-	if (mem_encrypt_active())
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		return -ENODEV;
 
 	if (!amd_iommu_v2_supported())
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3303d70..e80261d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -25,6 +25,7 @@
 #include <linux/property.h>
 #include <linux/fsl/mc.h>
 #include <linux/module.h>
+#include <linux/cc_platform.h>
 #include <trace/events/iommu.h>
 
 static struct kset *iommu_group_kset;
@@ -130,7 +131,7 @@ static int __init iommu_subsys_init(void)
 		else
 			iommu_set_default_translated(false);
 
-		if (iommu_default_passthrough() && mem_encrypt_active()) {
+		if (iommu_default_passthrough() && cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
 			pr_info("Memory encryption detected - Disabling default IOMMU Passthrough\n");
 			iommu_set_default_translated(false);
 		}
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 9a15334..cdbbf81 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -26,7 +26,7 @@
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
 #include <linux/uaccess.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 #include <asm/io.h>
 #include "internal.h"
 
@@ -177,7 +177,7 @@ ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
  */
 ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0, mem_encrypt_active());
+	return read_from_oldmem(buf, count, ppos, 0, cc_platform_has(CC_ATTR_MEM_ENCRYPT));
 }
 
 /*
@@ -378,7 +378,7 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
 					    buflen);
 			start = m->paddr + *fpos - m->offset;
 			tmp = read_from_oldmem(buffer, tsz, &start,
-					       userbuf, mem_encrypt_active());
+					       userbuf, cc_platform_has(CC_ATTR_MEM_ENCRYPT));
 			if (tmp < 0)
 				return tmp;
 			buflen -= tsz;
diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
index 5c4a18a..ae45263 100644
--- a/include/linux/mem_encrypt.h
+++ b/include/linux/mem_encrypt.h
@@ -16,10 +16,6 @@
 
 #include <asm/mem_encrypt.h>
 
-#else	/* !CONFIG_ARCH_HAS_MEM_ENCRYPT */
-
-static inline bool mem_encrypt_active(void) { return false; }
-
 #endif	/* CONFIG_ARCH_HAS_MEM_ENCRYPT */
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 87c4051..c4ca040 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -34,7 +34,7 @@
 #include <linux/highmem.h>
 #include <linux/gfp.h>
 #include <linux/scatterlist.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 #include <linux/set_memory.h>
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
@@ -552,7 +552,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	if (!mem)
 		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
 
-	if (mem_encrypt_active())
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
 		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
 
 	if (mapping_size > alloc_size) {
