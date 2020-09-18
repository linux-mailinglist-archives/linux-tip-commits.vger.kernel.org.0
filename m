Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96E026F844
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 10:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgIRIbQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 04:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgIRIbB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 04:31:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D012AC06174A;
        Fri, 18 Sep 2020 01:31:00 -0700 (PDT)
Date:   Fri, 18 Sep 2020 08:30:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600417859;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N96g2chz4ZXnA6vkwun8SIIeAB1fn7rUh7IfSKsEZrI=;
        b=Kx2lxZzulOqrr7T9Ojij4TAyNfknPQJ15NWE4YTAW8FLwcqKhEt7vjcY9gbARLMRTPLJeR
        ux/pc3Fu3nxpMRJJzu7mawXgy7wtw2eYEqIsAkfnwDqfQIZjP2IECfgVOom+HWkmDaacUE
        M4R04+o1BFvXfc05sQoaOCsD/h+60AMsdj65V7in81vNLTLUXH3OWObVbinXUG3fYn9gvQ
        hpir7yXd2INoDd0aqRBNAsL3LDlT7kFYTOGyiCRbfppfsn7AOHLjBppPUjV3yL9gsvzkw7
        fRVclXRTTw1yceYZwqFxDZGWnhHmIh8clFVhn17oPEBOn0iK/Ylk/UwhhcGCbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600417859;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N96g2chz4ZXnA6vkwun8SIIeAB1fn7rUh7IfSKsEZrI=;
        b=l6i/VPLQiGpCr0u+lGLLjPEL8WtjDdF5yPWx5HJ5yA0VA7JaU9qnzme76VH3lTTjKW3GI2
        kmVx4spZKW1/PnAA==
From:   "tip-bot2 for Atish Patra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: Rename arm-init to efi-init common for all arch
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200819222425.30721-8-atish.patra@wdc.com>
References: <20200819222425.30721-8-atish.patra@wdc.com>
MIME-Version: 1.0
Message-ID: <160041785862.15536.1603313127636930368.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     f30f242fb1319e616fbcf94a43195a1c57db99b8
Gitweb:        https://git.kernel.org/tip/f30f242fb1319e616fbcf94a43195a1c57db99b8
Author:        Atish Patra <atish.patra@wdc.com>
AuthorDate:    Wed, 19 Aug 2020 15:24:23 -07:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Fri, 11 Sep 2020 09:31:07 +03:00

efi: Rename arm-init to efi-init common for all arch

arm-init is responsible for setting up efi runtime and doesn't actually
do any ARM specific stuff. RISC-V can use the same source code as it is.

Rename it to efi-init so that RISC-V can use it.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Link: https://lore.kernel.org/r/20200819222425.30721-8-atish.patra@wdc.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/Makefile   |   2 +-
 drivers/firmware/efi/arm-init.c | 386 +-------------------------------
 drivers/firmware/efi/efi-init.c | 386 +++++++++++++++++++++++++++++++-
 3 files changed, 387 insertions(+), 387 deletions(-)
 delete mode 100644 drivers/firmware/efi/arm-init.c
 create mode 100644 drivers/firmware/efi/efi-init.c

diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 7a21698..61fd1e8 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -32,7 +32,7 @@ obj-$(CONFIG_EFI_EMBEDDED_FIRMWARE)	+= embedded-firmware.o
 fake_map-y				+= fake_mem.o
 fake_map-$(CONFIG_X86)			+= x86_fake_mem.o
 
-arm-obj-$(CONFIG_EFI)			:= arm-init.o arm-runtime.o
+arm-obj-$(CONFIG_EFI)			:= efi-init.o arm-runtime.o
 obj-$(CONFIG_ARM)			+= $(arm-obj-y)
 obj-$(CONFIG_ARM64)			+= $(arm-obj-y)
 obj-$(CONFIG_EFI_CAPSULE_LOADER)	+= capsule-loader.o
diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
deleted file mode 100644
index 71c445d..0000000
--- a/drivers/firmware/efi/arm-init.c
+++ /dev/null
@@ -1,386 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Extensible Firmware Interface
- *
- * Based on Extensible Firmware Interface Specification version 2.4
- *
- * Copyright (C) 2013 - 2015 Linaro Ltd.
- */
-
-#define pr_fmt(fmt)	"efi: " fmt
-
-#include <linux/efi.h>
-#include <linux/fwnode.h>
-#include <linux/init.h>
-#include <linux/memblock.h>
-#include <linux/mm_types.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_fdt.h>
-#include <linux/platform_device.h>
-#include <linux/screen_info.h>
-
-#include <asm/efi.h>
-
-static int __init is_memory(efi_memory_desc_t *md)
-{
-	if (md->attribute & (EFI_MEMORY_WB|EFI_MEMORY_WT|EFI_MEMORY_WC))
-		return 1;
-	return 0;
-}
-
-/*
- * Translate a EFI virtual address into a physical address: this is necessary,
- * as some data members of the EFI system table are virtually remapped after
- * SetVirtualAddressMap() has been called.
- */
-static phys_addr_t __init efi_to_phys(unsigned long addr)
-{
-	efi_memory_desc_t *md;
-
-	for_each_efi_memory_desc(md) {
-		if (!(md->attribute & EFI_MEMORY_RUNTIME))
-			continue;
-		if (md->virt_addr == 0)
-			/* no virtual mapping has been installed by the stub */
-			break;
-		if (md->virt_addr <= addr &&
-		    (addr - md->virt_addr) < (md->num_pages << EFI_PAGE_SHIFT))
-			return md->phys_addr + addr - md->virt_addr;
-	}
-	return addr;
-}
-
-static __initdata unsigned long screen_info_table = EFI_INVALID_TABLE_ADDR;
-static __initdata unsigned long cpu_state_table = EFI_INVALID_TABLE_ADDR;
-
-static const efi_config_table_type_t arch_tables[] __initconst = {
-	{LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID, &screen_info_table},
-	{LINUX_EFI_ARM_CPU_STATE_TABLE_GUID, &cpu_state_table},
-	{}
-};
-
-static void __init init_screen_info(void)
-{
-	struct screen_info *si;
-
-	if (IS_ENABLED(CONFIG_ARM) &&
-	    screen_info_table != EFI_INVALID_TABLE_ADDR) {
-		si = early_memremap_ro(screen_info_table, sizeof(*si));
-		if (!si) {
-			pr_err("Could not map screen_info config table\n");
-			return;
-		}
-		screen_info = *si;
-		early_memunmap(si, sizeof(*si));
-
-		/* dummycon on ARM needs non-zero values for columns/lines */
-		screen_info.orig_video_cols = 80;
-		screen_info.orig_video_lines = 25;
-	}
-
-	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
-	    memblock_is_map_memory(screen_info.lfb_base))
-		memblock_mark_nomap(screen_info.lfb_base, screen_info.lfb_size);
-}
-
-static int __init uefi_init(u64 efi_system_table)
-{
-	efi_config_table_t *config_tables;
-	efi_system_table_t *systab;
-	size_t table_size;
-	int retval;
-
-	systab = early_memremap_ro(efi_system_table, sizeof(efi_system_table_t));
-	if (systab == NULL) {
-		pr_warn("Unable to map EFI system table.\n");
-		return -ENOMEM;
-	}
-
-	set_bit(EFI_BOOT, &efi.flags);
-	if (IS_ENABLED(CONFIG_64BIT))
-		set_bit(EFI_64BIT, &efi.flags);
-
-	retval = efi_systab_check_header(&systab->hdr, 2);
-	if (retval)
-		goto out;
-
-	efi.runtime = systab->runtime;
-	efi.runtime_version = systab->hdr.revision;
-
-	efi_systab_report_header(&systab->hdr, efi_to_phys(systab->fw_vendor));
-
-	table_size = sizeof(efi_config_table_t) * systab->nr_tables;
-	config_tables = early_memremap_ro(efi_to_phys(systab->tables),
-					  table_size);
-	if (config_tables == NULL) {
-		pr_warn("Unable to map EFI config table array.\n");
-		retval = -ENOMEM;
-		goto out;
-	}
-	retval = efi_config_parse_tables(config_tables, systab->nr_tables,
-					 IS_ENABLED(CONFIG_ARM) ? arch_tables
-								: NULL);
-
-	early_memunmap(config_tables, table_size);
-out:
-	early_memunmap(systab, sizeof(efi_system_table_t));
-	return retval;
-}
-
-/*
- * Return true for regions that can be used as System RAM.
- */
-static __init int is_usable_memory(efi_memory_desc_t *md)
-{
-	switch (md->type) {
-	case EFI_LOADER_CODE:
-	case EFI_LOADER_DATA:
-	case EFI_ACPI_RECLAIM_MEMORY:
-	case EFI_BOOT_SERVICES_CODE:
-	case EFI_BOOT_SERVICES_DATA:
-	case EFI_CONVENTIONAL_MEMORY:
-	case EFI_PERSISTENT_MEMORY:
-		/*
-		 * Special purpose memory is 'soft reserved', which means it
-		 * is set aside initially, but can be hotplugged back in or
-		 * be assigned to the dax driver after boot.
-		 */
-		if (efi_soft_reserve_enabled() &&
-		    (md->attribute & EFI_MEMORY_SP))
-			return false;
-
-		/*
-		 * According to the spec, these regions are no longer reserved
-		 * after calling ExitBootServices(). However, we can only use
-		 * them as System RAM if they can be mapped writeback cacheable.
-		 */
-		return (md->attribute & EFI_MEMORY_WB);
-	default:
-		break;
-	}
-	return false;
-}
-
-static __init void reserve_regions(void)
-{
-	efi_memory_desc_t *md;
-	u64 paddr, npages, size;
-
-	if (efi_enabled(EFI_DBG))
-		pr_info("Processing EFI memory map:\n");
-
-	/*
-	 * Discard memblocks discovered so far: if there are any at this
-	 * point, they originate from memory nodes in the DT, and UEFI
-	 * uses its own memory map instead.
-	 */
-	memblock_dump_all();
-	memblock_remove(0, PHYS_ADDR_MAX);
-
-	for_each_efi_memory_desc(md) {
-		paddr = md->phys_addr;
-		npages = md->num_pages;
-
-		if (efi_enabled(EFI_DBG)) {
-			char buf[64];
-
-			pr_info("  0x%012llx-0x%012llx %s\n",
-				paddr, paddr + (npages << EFI_PAGE_SHIFT) - 1,
-				efi_md_typeattr_format(buf, sizeof(buf), md));
-		}
-
-		memrange_efi_to_native(&paddr, &npages);
-		size = npages << PAGE_SHIFT;
-
-		if (is_memory(md)) {
-			early_init_dt_add_memory_arch(paddr, size);
-
-			if (!is_usable_memory(md))
-				memblock_mark_nomap(paddr, size);
-
-			/* keep ACPI reclaim memory intact for kexec etc. */
-			if (md->type == EFI_ACPI_RECLAIM_MEMORY)
-				memblock_reserve(paddr, size);
-		}
-	}
-}
-
-void __init efi_init(void)
-{
-	struct efi_memory_map_data data;
-	u64 efi_system_table;
-
-	/* Grab UEFI information placed in FDT by stub */
-	efi_system_table = efi_get_fdt_params(&data);
-	if (!efi_system_table)
-		return;
-
-	if (efi_memmap_init_early(&data) < 0) {
-		/*
-		* If we are booting via UEFI, the UEFI memory map is the only
-		* description of memory we have, so there is little point in
-		* proceeding if we cannot access it.
-		*/
-		panic("Unable to map EFI memory map.\n");
-	}
-
-	WARN(efi.memmap.desc_version != 1,
-	     "Unexpected EFI_MEMORY_DESCRIPTOR version %ld",
-	      efi.memmap.desc_version);
-
-	if (uefi_init(efi_system_table) < 0) {
-		efi_memmap_unmap();
-		return;
-	}
-
-	reserve_regions();
-	efi_esrt_init();
-
-	memblock_reserve(data.phys_map & PAGE_MASK,
-			 PAGE_ALIGN(data.size + (data.phys_map & ~PAGE_MASK)));
-
-	init_screen_info();
-
-#ifdef CONFIG_ARM
-	/* ARM does not permit early mappings to persist across paging_init() */
-	efi_memmap_unmap();
-
-	if (cpu_state_table != EFI_INVALID_TABLE_ADDR) {
-		struct efi_arm_entry_state *state;
-		bool dump_state = true;
-
-		state = early_memremap_ro(cpu_state_table,
-					  sizeof(struct efi_arm_entry_state));
-		if (state == NULL) {
-			pr_warn("Unable to map CPU entry state table.\n");
-			return;
-		}
-
-		if ((state->sctlr_before_ebs & 1) == 0)
-			pr_warn(FW_BUG "EFI stub was entered with MMU and Dcache disabled, please fix your firmware!\n");
-		else if ((state->sctlr_after_ebs & 1) == 0)
-			pr_warn(FW_BUG "ExitBootServices() returned with MMU and Dcache disabled, please fix your firmware!\n");
-		else
-			dump_state = false;
-
-		if (dump_state || efi_enabled(EFI_DBG)) {
-			pr_info("CPSR at EFI stub entry        : 0x%08x\n", state->cpsr_before_ebs);
-			pr_info("SCTLR at EFI stub entry       : 0x%08x\n", state->sctlr_before_ebs);
-			pr_info("CPSR after ExitBootServices() : 0x%08x\n", state->cpsr_after_ebs);
-			pr_info("SCTLR after ExitBootServices(): 0x%08x\n", state->sctlr_after_ebs);
-		}
-		early_memunmap(state, sizeof(struct efi_arm_entry_state));
-	}
-#endif
-}
-
-static bool efifb_overlaps_pci_range(const struct of_pci_range *range)
-{
-	u64 fb_base = screen_info.lfb_base;
-
-	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
-		fb_base |= (u64)(unsigned long)screen_info.ext_lfb_base << 32;
-
-	return fb_base >= range->cpu_addr &&
-	       fb_base < (range->cpu_addr + range->size);
-}
-
-static struct device_node *find_pci_overlap_node(void)
-{
-	struct device_node *np;
-
-	for_each_node_by_type(np, "pci") {
-		struct of_pci_range_parser parser;
-		struct of_pci_range range;
-		int err;
-
-		err = of_pci_range_parser_init(&parser, np);
-		if (err) {
-			pr_warn("of_pci_range_parser_init() failed: %d\n", err);
-			continue;
-		}
-
-		for_each_of_pci_range(&parser, &range)
-			if (efifb_overlaps_pci_range(&range))
-				return np;
-	}
-	return NULL;
-}
-
-/*
- * If the efifb framebuffer is backed by a PCI graphics controller, we have
- * to ensure that this relation is expressed using a device link when
- * running in DT mode, or the probe order may be reversed, resulting in a
- * resource reservation conflict on the memory window that the efifb
- * framebuffer steals from the PCIe host bridge.
- */
-static int efifb_add_links(const struct fwnode_handle *fwnode,
-			   struct device *dev)
-{
-	struct device_node *sup_np;
-	struct device *sup_dev;
-
-	sup_np = find_pci_overlap_node();
-
-	/*
-	 * If there's no PCI graphics controller backing the efifb, we are
-	 * done here.
-	 */
-	if (!sup_np)
-		return 0;
-
-	sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
-	of_node_put(sup_np);
-
-	/*
-	 * Return -ENODEV if the PCI graphics controller device hasn't been
-	 * registered yet.  This ensures that efifb isn't allowed to probe
-	 * and this function is retried again when new devices are
-	 * registered.
-	 */
-	if (!sup_dev)
-		return -ENODEV;
-
-	/*
-	 * If this fails, retrying this function at a later point won't
-	 * change anything. So, don't return an error after this.
-	 */
-	if (!device_link_add(dev, sup_dev, fw_devlink_get_flags()))
-		dev_warn(dev, "device_link_add() failed\n");
-
-	put_device(sup_dev);
-
-	return 0;
-}
-
-static const struct fwnode_operations efifb_fwnode_ops = {
-	.add_links = efifb_add_links,
-};
-
-static struct fwnode_handle efifb_fwnode = {
-	.ops = &efifb_fwnode_ops,
-};
-
-static int __init register_gop_device(void)
-{
-	struct platform_device *pd;
-	int err;
-
-	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
-		return 0;
-
-	pd = platform_device_alloc("efi-framebuffer", 0);
-	if (!pd)
-		return -ENOMEM;
-
-	if (IS_ENABLED(CONFIG_PCI))
-		pd->dev.fwnode = &efifb_fwnode;
-
-	err = platform_device_add_data(pd, &screen_info, sizeof(screen_info));
-	if (err)
-		return err;
-
-	return platform_device_add(pd);
-}
-subsys_initcall(register_gop_device);
diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
new file mode 100644
index 0000000..71c445d
--- /dev/null
+++ b/drivers/firmware/efi/efi-init.c
@@ -0,0 +1,386 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Extensible Firmware Interface
+ *
+ * Based on Extensible Firmware Interface Specification version 2.4
+ *
+ * Copyright (C) 2013 - 2015 Linaro Ltd.
+ */
+
+#define pr_fmt(fmt)	"efi: " fmt
+
+#include <linux/efi.h>
+#include <linux/fwnode.h>
+#include <linux/init.h>
+#include <linux/memblock.h>
+#include <linux/mm_types.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_fdt.h>
+#include <linux/platform_device.h>
+#include <linux/screen_info.h>
+
+#include <asm/efi.h>
+
+static int __init is_memory(efi_memory_desc_t *md)
+{
+	if (md->attribute & (EFI_MEMORY_WB|EFI_MEMORY_WT|EFI_MEMORY_WC))
+		return 1;
+	return 0;
+}
+
+/*
+ * Translate a EFI virtual address into a physical address: this is necessary,
+ * as some data members of the EFI system table are virtually remapped after
+ * SetVirtualAddressMap() has been called.
+ */
+static phys_addr_t __init efi_to_phys(unsigned long addr)
+{
+	efi_memory_desc_t *md;
+
+	for_each_efi_memory_desc(md) {
+		if (!(md->attribute & EFI_MEMORY_RUNTIME))
+			continue;
+		if (md->virt_addr == 0)
+			/* no virtual mapping has been installed by the stub */
+			break;
+		if (md->virt_addr <= addr &&
+		    (addr - md->virt_addr) < (md->num_pages << EFI_PAGE_SHIFT))
+			return md->phys_addr + addr - md->virt_addr;
+	}
+	return addr;
+}
+
+static __initdata unsigned long screen_info_table = EFI_INVALID_TABLE_ADDR;
+static __initdata unsigned long cpu_state_table = EFI_INVALID_TABLE_ADDR;
+
+static const efi_config_table_type_t arch_tables[] __initconst = {
+	{LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID, &screen_info_table},
+	{LINUX_EFI_ARM_CPU_STATE_TABLE_GUID, &cpu_state_table},
+	{}
+};
+
+static void __init init_screen_info(void)
+{
+	struct screen_info *si;
+
+	if (IS_ENABLED(CONFIG_ARM) &&
+	    screen_info_table != EFI_INVALID_TABLE_ADDR) {
+		si = early_memremap_ro(screen_info_table, sizeof(*si));
+		if (!si) {
+			pr_err("Could not map screen_info config table\n");
+			return;
+		}
+		screen_info = *si;
+		early_memunmap(si, sizeof(*si));
+
+		/* dummycon on ARM needs non-zero values for columns/lines */
+		screen_info.orig_video_cols = 80;
+		screen_info.orig_video_lines = 25;
+	}
+
+	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
+	    memblock_is_map_memory(screen_info.lfb_base))
+		memblock_mark_nomap(screen_info.lfb_base, screen_info.lfb_size);
+}
+
+static int __init uefi_init(u64 efi_system_table)
+{
+	efi_config_table_t *config_tables;
+	efi_system_table_t *systab;
+	size_t table_size;
+	int retval;
+
+	systab = early_memremap_ro(efi_system_table, sizeof(efi_system_table_t));
+	if (systab == NULL) {
+		pr_warn("Unable to map EFI system table.\n");
+		return -ENOMEM;
+	}
+
+	set_bit(EFI_BOOT, &efi.flags);
+	if (IS_ENABLED(CONFIG_64BIT))
+		set_bit(EFI_64BIT, &efi.flags);
+
+	retval = efi_systab_check_header(&systab->hdr, 2);
+	if (retval)
+		goto out;
+
+	efi.runtime = systab->runtime;
+	efi.runtime_version = systab->hdr.revision;
+
+	efi_systab_report_header(&systab->hdr, efi_to_phys(systab->fw_vendor));
+
+	table_size = sizeof(efi_config_table_t) * systab->nr_tables;
+	config_tables = early_memremap_ro(efi_to_phys(systab->tables),
+					  table_size);
+	if (config_tables == NULL) {
+		pr_warn("Unable to map EFI config table array.\n");
+		retval = -ENOMEM;
+		goto out;
+	}
+	retval = efi_config_parse_tables(config_tables, systab->nr_tables,
+					 IS_ENABLED(CONFIG_ARM) ? arch_tables
+								: NULL);
+
+	early_memunmap(config_tables, table_size);
+out:
+	early_memunmap(systab, sizeof(efi_system_table_t));
+	return retval;
+}
+
+/*
+ * Return true for regions that can be used as System RAM.
+ */
+static __init int is_usable_memory(efi_memory_desc_t *md)
+{
+	switch (md->type) {
+	case EFI_LOADER_CODE:
+	case EFI_LOADER_DATA:
+	case EFI_ACPI_RECLAIM_MEMORY:
+	case EFI_BOOT_SERVICES_CODE:
+	case EFI_BOOT_SERVICES_DATA:
+	case EFI_CONVENTIONAL_MEMORY:
+	case EFI_PERSISTENT_MEMORY:
+		/*
+		 * Special purpose memory is 'soft reserved', which means it
+		 * is set aside initially, but can be hotplugged back in or
+		 * be assigned to the dax driver after boot.
+		 */
+		if (efi_soft_reserve_enabled() &&
+		    (md->attribute & EFI_MEMORY_SP))
+			return false;
+
+		/*
+		 * According to the spec, these regions are no longer reserved
+		 * after calling ExitBootServices(). However, we can only use
+		 * them as System RAM if they can be mapped writeback cacheable.
+		 */
+		return (md->attribute & EFI_MEMORY_WB);
+	default:
+		break;
+	}
+	return false;
+}
+
+static __init void reserve_regions(void)
+{
+	efi_memory_desc_t *md;
+	u64 paddr, npages, size;
+
+	if (efi_enabled(EFI_DBG))
+		pr_info("Processing EFI memory map:\n");
+
+	/*
+	 * Discard memblocks discovered so far: if there are any at this
+	 * point, they originate from memory nodes in the DT, and UEFI
+	 * uses its own memory map instead.
+	 */
+	memblock_dump_all();
+	memblock_remove(0, PHYS_ADDR_MAX);
+
+	for_each_efi_memory_desc(md) {
+		paddr = md->phys_addr;
+		npages = md->num_pages;
+
+		if (efi_enabled(EFI_DBG)) {
+			char buf[64];
+
+			pr_info("  0x%012llx-0x%012llx %s\n",
+				paddr, paddr + (npages << EFI_PAGE_SHIFT) - 1,
+				efi_md_typeattr_format(buf, sizeof(buf), md));
+		}
+
+		memrange_efi_to_native(&paddr, &npages);
+		size = npages << PAGE_SHIFT;
+
+		if (is_memory(md)) {
+			early_init_dt_add_memory_arch(paddr, size);
+
+			if (!is_usable_memory(md))
+				memblock_mark_nomap(paddr, size);
+
+			/* keep ACPI reclaim memory intact for kexec etc. */
+			if (md->type == EFI_ACPI_RECLAIM_MEMORY)
+				memblock_reserve(paddr, size);
+		}
+	}
+}
+
+void __init efi_init(void)
+{
+	struct efi_memory_map_data data;
+	u64 efi_system_table;
+
+	/* Grab UEFI information placed in FDT by stub */
+	efi_system_table = efi_get_fdt_params(&data);
+	if (!efi_system_table)
+		return;
+
+	if (efi_memmap_init_early(&data) < 0) {
+		/*
+		* If we are booting via UEFI, the UEFI memory map is the only
+		* description of memory we have, so there is little point in
+		* proceeding if we cannot access it.
+		*/
+		panic("Unable to map EFI memory map.\n");
+	}
+
+	WARN(efi.memmap.desc_version != 1,
+	     "Unexpected EFI_MEMORY_DESCRIPTOR version %ld",
+	      efi.memmap.desc_version);
+
+	if (uefi_init(efi_system_table) < 0) {
+		efi_memmap_unmap();
+		return;
+	}
+
+	reserve_regions();
+	efi_esrt_init();
+
+	memblock_reserve(data.phys_map & PAGE_MASK,
+			 PAGE_ALIGN(data.size + (data.phys_map & ~PAGE_MASK)));
+
+	init_screen_info();
+
+#ifdef CONFIG_ARM
+	/* ARM does not permit early mappings to persist across paging_init() */
+	efi_memmap_unmap();
+
+	if (cpu_state_table != EFI_INVALID_TABLE_ADDR) {
+		struct efi_arm_entry_state *state;
+		bool dump_state = true;
+
+		state = early_memremap_ro(cpu_state_table,
+					  sizeof(struct efi_arm_entry_state));
+		if (state == NULL) {
+			pr_warn("Unable to map CPU entry state table.\n");
+			return;
+		}
+
+		if ((state->sctlr_before_ebs & 1) == 0)
+			pr_warn(FW_BUG "EFI stub was entered with MMU and Dcache disabled, please fix your firmware!\n");
+		else if ((state->sctlr_after_ebs & 1) == 0)
+			pr_warn(FW_BUG "ExitBootServices() returned with MMU and Dcache disabled, please fix your firmware!\n");
+		else
+			dump_state = false;
+
+		if (dump_state || efi_enabled(EFI_DBG)) {
+			pr_info("CPSR at EFI stub entry        : 0x%08x\n", state->cpsr_before_ebs);
+			pr_info("SCTLR at EFI stub entry       : 0x%08x\n", state->sctlr_before_ebs);
+			pr_info("CPSR after ExitBootServices() : 0x%08x\n", state->cpsr_after_ebs);
+			pr_info("SCTLR after ExitBootServices(): 0x%08x\n", state->sctlr_after_ebs);
+		}
+		early_memunmap(state, sizeof(struct efi_arm_entry_state));
+	}
+#endif
+}
+
+static bool efifb_overlaps_pci_range(const struct of_pci_range *range)
+{
+	u64 fb_base = screen_info.lfb_base;
+
+	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
+		fb_base |= (u64)(unsigned long)screen_info.ext_lfb_base << 32;
+
+	return fb_base >= range->cpu_addr &&
+	       fb_base < (range->cpu_addr + range->size);
+}
+
+static struct device_node *find_pci_overlap_node(void)
+{
+	struct device_node *np;
+
+	for_each_node_by_type(np, "pci") {
+		struct of_pci_range_parser parser;
+		struct of_pci_range range;
+		int err;
+
+		err = of_pci_range_parser_init(&parser, np);
+		if (err) {
+			pr_warn("of_pci_range_parser_init() failed: %d\n", err);
+			continue;
+		}
+
+		for_each_of_pci_range(&parser, &range)
+			if (efifb_overlaps_pci_range(&range))
+				return np;
+	}
+	return NULL;
+}
+
+/*
+ * If the efifb framebuffer is backed by a PCI graphics controller, we have
+ * to ensure that this relation is expressed using a device link when
+ * running in DT mode, or the probe order may be reversed, resulting in a
+ * resource reservation conflict on the memory window that the efifb
+ * framebuffer steals from the PCIe host bridge.
+ */
+static int efifb_add_links(const struct fwnode_handle *fwnode,
+			   struct device *dev)
+{
+	struct device_node *sup_np;
+	struct device *sup_dev;
+
+	sup_np = find_pci_overlap_node();
+
+	/*
+	 * If there's no PCI graphics controller backing the efifb, we are
+	 * done here.
+	 */
+	if (!sup_np)
+		return 0;
+
+	sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
+	of_node_put(sup_np);
+
+	/*
+	 * Return -ENODEV if the PCI graphics controller device hasn't been
+	 * registered yet.  This ensures that efifb isn't allowed to probe
+	 * and this function is retried again when new devices are
+	 * registered.
+	 */
+	if (!sup_dev)
+		return -ENODEV;
+
+	/*
+	 * If this fails, retrying this function at a later point won't
+	 * change anything. So, don't return an error after this.
+	 */
+	if (!device_link_add(dev, sup_dev, fw_devlink_get_flags()))
+		dev_warn(dev, "device_link_add() failed\n");
+
+	put_device(sup_dev);
+
+	return 0;
+}
+
+static const struct fwnode_operations efifb_fwnode_ops = {
+	.add_links = efifb_add_links,
+};
+
+static struct fwnode_handle efifb_fwnode = {
+	.ops = &efifb_fwnode_ops,
+};
+
+static int __init register_gop_device(void)
+{
+	struct platform_device *pd;
+	int err;
+
+	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
+		return 0;
+
+	pd = platform_device_alloc("efi-framebuffer", 0);
+	if (!pd)
+		return -ENOMEM;
+
+	if (IS_ENABLED(CONFIG_PCI))
+		pd->dev.fwnode = &efifb_fwnode;
+
+	err = platform_device_add_data(pd, &screen_info, sizeof(screen_info));
+	if (err)
+		return err;
+
+	return platform_device_add(pd);
+}
+subsys_initcall(register_gop_device);
