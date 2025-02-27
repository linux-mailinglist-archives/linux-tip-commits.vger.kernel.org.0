Return-Path: <linux-tip-commits+bounces-3700-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4D4A47A7F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 11:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E610616C350
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 10:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA32229B10;
	Thu, 27 Feb 2025 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FA6zwZub";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lAcaaMno"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF2421D3E7;
	Thu, 27 Feb 2025 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652934; cv=none; b=G+bUM1x6mInkNMyEDU1dc/oNApVZGIAlWf5m1jSHEQuLOyAaL3APgqX1o9WUWfmYVR12gZGPeC3r+Y5R3bZ1WTXtagON4i5z9Ag7M3PecD+3f6QbU+6KUv9FUCSplKJxey9jtFr+CI1jZ39wyGMznCLa7WsicKlsX13y2XaTrrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652934; c=relaxed/simple;
	bh=25Og7r04Ge0uyqYrBRcF4S+mbgeVbjUlSN5e+NkOp2k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eoBsJJgbduzBnyarxVhZX89Tptk9ln0n1gGvLRcZPOF37twWfwP1WEm8Dsfpet/+x9JT1luFtlEZ2UF66ZGWOji1zdqK/r6V1Ylaf+uSc2oD9Sq7V04xh++6df0vZS3/Dt7ARbqcoP+sj5BBOItDTO4QwvXMM6iKlHSVkicHxmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FA6zwZub; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lAcaaMno; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 10:42:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740652930;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOyeV1clICeVHSdG/g7rlwWTGpFp/69zyy083WvJrtY=;
	b=FA6zwZubgkVwdMz6iyJC+32gd1SCo/P2gxvfN/sDAh+xxRVOZyv8601RaAoAqNpJmPO3hT
	+MUUNWXXNNB1cuM2PBPH8aUCNMFzJs+mbUOGZvd36vMIhgSmJJPPgKQvz+vOFf6Us5km2q
	Tp/YCW/x3JcaDqz5++Y2nHk830oLe8DanCwGzod0WUqOu3h4lLl+MDI0NeXQRvtlKGIHY8
	0csSDUzeC1nXXQOnEbL/17lG+gHoifoESaYasAjMCQUtj4HKk8JEAH8S18s8XjFBwLy8l/
	rypyAK2xRNlFpO2SbWA/8qAAePVrNyVEkIUA+EZ13OnO3TrEcO3VpENjZErDqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740652930;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOyeV1clICeVHSdG/g7rlwWTGpFp/69zyy083WvJrtY=;
	b=lAcaaMnoOSj0RsbYS05UeMFMocfl2mO49L6QQhJUjEblSn9/nlS162yi3VlAdoHWMPfMV+
	CkJJ4D+auieGA2CQ==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/pci: Remove old STA2x11 support
Cc: Davide Ciminaghi <ciminaghi@gnudd.com>, Arnd Bergmann <arnd@arndb.de>,
 Ingo Molnar <mingo@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226213714.4040853-10-arnd@kernel.org>
References: <20250226213714.4040853-10-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174065292945.10177.791815558069315411.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     dcbb01fbb7aeed0fae4dc1389a36842c77f4f381
Gitweb:        https://git.kernel.org/tip/dcbb01fbb7aeed0fae4dc1389a36842c77f4f381
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 26 Feb 2025 22:37:13 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 11:22:14 +01:00

x86/pci: Remove old STA2x11 support

ST ConneXt STA2x11 was an interface chip for Atom E6xx processors,
using a number of components usually found on Arm SoCs. Most of this
was merged upstream, but it was never complete enough to actually work
and has been abandoned for many years.

We already had an agreement on removing it in 2022, but nobody ever
submitted the patch to do it.

Without STA2x11, CONFIG_X86_32_NON_STANDARD no longer has any
use - remove it.

Suggested-by: Davide Ciminaghi <ciminaghi@gnudd.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250226213714.4040853-10-arnd@kernel.org
---
 arch/x86/Kconfig               |  32 +----
 arch/x86/include/asm/sta2x11.h |  13 +--
 arch/x86/pci/Makefile          |   2 +-
 arch/x86/pci/sta2x11-fixup.c   | 233 +--------------------------------
 4 files changed, 3 insertions(+), 277 deletions(-)
 delete mode 100644 arch/x86/include/asm/sta2x11.h
 delete mode 100644 arch/x86/pci/sta2x11-fixup.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index acd4d73..383b145 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -548,7 +548,6 @@ config X86_EXTENDED_PLATFORM
 		AMD Elan
 		RDC R-321x SoC
 		SGI 320/540 (Visual Workstation)
-		STA2X11-based (e.g. Northville)
 
 	  64-bit platforms (CONFIG_64BIT=y):
 		Numascale NumaChip
@@ -732,18 +731,6 @@ config X86_RDC321X
 	  as R-8610-(G).
 	  If you don't have one of these chips, you should say N here.
 
-config X86_32_NON_STANDARD
-	bool "Support non-standard 32-bit SMP architectures"
-	depends on X86_32 && SMP
-	depends on X86_EXTENDED_PLATFORM
-	help
-	  This option compiles in the STA2X11 default
-	  subarchitecture.  It is intended for a generic binary
-	  kernel. If you select them all, kernel will probe it one by
-	  one and will fallback to default.
-
-# Alphabetically sorted list of Non standard 32 bit platforms
-
 config X86_SUPPORTS_MEMORY_FAILURE
 	def_bool y
 	# MCE code calls memory_failure():
@@ -753,19 +740,6 @@ config X86_SUPPORTS_MEMORY_FAILURE
 	depends on X86_64 || !SPARSEMEM
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 
-config STA2X11
-	bool "STA2X11 Companion Chip Support"
-	depends on X86_32_NON_STANDARD && PCI
-	select SWIOTLB
-	select MFD_STA2X11
-	select GPIOLIB
-	help
-	  This adds support for boards based on the STA2X11 IO-Hub,
-	  a.k.a. "ConneXt". The chip is used in place of the standard
-	  PC chipset, so all "standard" peripherals are missing. If this
-	  option is selected the kernel will still be able to boot on
-	  standard PC machines.
-
 config X86_32_IRIS
 	tristate "Eurobraille/Iris poweroff module"
 	depends on X86_32
@@ -1103,7 +1077,7 @@ config UP_LATE_INIT
 config X86_UP_APIC
 	bool "Local APIC support on uniprocessors" if !PCI_MSI
 	default PCI_MSI
-	depends on X86_32 && !SMP && !X86_32_NON_STANDARD
+	depends on X86_32 && !SMP
 	help
 	  A local APIC (Advanced Programmable Interrupt Controller) is an
 	  integrated interrupt controller in the CPU. If you have a single-CPU
@@ -1128,7 +1102,7 @@ config X86_UP_IOAPIC
 
 config X86_LOCAL_APIC
 	def_bool y
-	depends on X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_APIC || PCI_MSI
+	depends on X86_64 || SMP || X86_UP_APIC || PCI_MSI
 	select IRQ_DOMAIN_HIERARCHY
 
 config ACPI_MADT_WAKEUP
@@ -1590,7 +1564,7 @@ config ARCH_FLATMEM_ENABLE
 
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
-	depends on X86_64 || NUMA || X86_32 || X86_32_NON_STANDARD
+	depends on X86_64 || NUMA || X86_32
 	select SPARSEMEM_STATIC if X86_32
 	select SPARSEMEM_VMEMMAP_ENABLE if X86_64
 
diff --git a/arch/x86/include/asm/sta2x11.h b/arch/x86/include/asm/sta2x11.h
deleted file mode 100644
index e0975e9..0000000
--- a/arch/x86/include/asm/sta2x11.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Header file for STMicroelectronics ConneXt (STA2X11) IOHub
- */
-#ifndef __ASM_STA2X11_H
-#define __ASM_STA2X11_H
-
-#include <linux/pci.h>
-
-/* This needs to be called from the MFD to configure its sub-devices */
-struct sta2x11_instance *sta2x11_get_instance(struct pci_dev *pdev);
-
-#endif /* __ASM_STA2X11_H */
diff --git a/arch/x86/pci/Makefile b/arch/x86/pci/Makefile
index 48bcada..4933fb3 100644
--- a/arch/x86/pci/Makefile
+++ b/arch/x86/pci/Makefile
@@ -12,8 +12,6 @@ obj-$(CONFIG_X86_INTEL_CE)      += ce4100.o
 obj-$(CONFIG_ACPI)		+= acpi.o
 obj-y				+= legacy.o irq.o
 
-obj-$(CONFIG_STA2X11)           += sta2x11-fixup.o
-
 obj-$(CONFIG_X86_NUMACHIP)	+= numachip.o
 
 obj-$(CONFIG_X86_INTEL_MID)	+= intel_mid_pci.o
diff --git a/arch/x86/pci/sta2x11-fixup.c b/arch/x86/pci/sta2x11-fixup.c
deleted file mode 100644
index 8c8ddc4..0000000
--- a/arch/x86/pci/sta2x11-fixup.c
+++ /dev/null
@@ -1,233 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * DMA translation between STA2x11 AMBA memory mapping and the x86 memory mapping
- *
- * ST Microelectronics ConneXt (STA2X11/STA2X10)
- *
- * Copyright (c) 2010-2011 Wind River Systems, Inc.
- */
-
-#include <linux/pci.h>
-#include <linux/pci_ids.h>
-#include <linux/export.h>
-#include <linux/list.h>
-#include <linux/dma-map-ops.h>
-#include <linux/swiotlb.h>
-#include <asm/iommu.h>
-#include <asm/sta2x11.h>
-
-#define STA2X11_SWIOTLB_SIZE (4*1024*1024)
-
-/*
- * We build a list of bus numbers that are under the ConneXt. The
- * main bridge hosts 4 busses, which are the 4 endpoints, in order.
- */
-#define STA2X11_NR_EP		4	/* 0..3 included */
-#define STA2X11_NR_FUNCS	8	/* 0..7 included */
-#define STA2X11_AMBA_SIZE	(512 << 20)
-
-struct sta2x11_ahb_regs { /* saved during suspend */
-	u32 base, pexlbase, pexhbase, crw;
-};
-
-struct sta2x11_mapping {
-	int is_suspended;
-	struct sta2x11_ahb_regs regs[STA2X11_NR_FUNCS];
-};
-
-struct sta2x11_instance {
-	struct list_head list;
-	int bus0;
-	struct sta2x11_mapping map[STA2X11_NR_EP];
-};
-
-static LIST_HEAD(sta2x11_instance_list);
-
-/* At probe time, record new instances of this bridge (likely one only) */
-static void sta2x11_new_instance(struct pci_dev *pdev)
-{
-	struct sta2x11_instance *instance;
-
-	instance = kzalloc(sizeof(*instance), GFP_ATOMIC);
-	if (!instance)
-		return;
-	/* This has a subordinate bridge, with 4 more-subordinate ones */
-	instance->bus0 = pdev->subordinate->number + 1;
-
-	if (list_empty(&sta2x11_instance_list)) {
-		int size = STA2X11_SWIOTLB_SIZE;
-		/* First instance: register your own swiotlb area */
-		dev_info(&pdev->dev, "Using SWIOTLB (size %i)\n", size);
-		if (swiotlb_init_late(size, GFP_DMA, NULL))
-			dev_emerg(&pdev->dev, "init swiotlb failed\n");
-	}
-	list_add(&instance->list, &sta2x11_instance_list);
-}
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_STMICRO, 0xcc17, sta2x11_new_instance);
-
-/*
- * Utility functions used in this file from below
- */
-static struct sta2x11_instance *sta2x11_pdev_to_instance(struct pci_dev *pdev)
-{
-	struct sta2x11_instance *instance;
-	int ep;
-
-	list_for_each_entry(instance, &sta2x11_instance_list, list) {
-		ep = pdev->bus->number - instance->bus0;
-		if (ep >= 0 && ep < STA2X11_NR_EP)
-			return instance;
-	}
-	return NULL;
-}
-
-static int sta2x11_pdev_to_ep(struct pci_dev *pdev)
-{
-	struct sta2x11_instance *instance;
-
-	instance = sta2x11_pdev_to_instance(pdev);
-	if (!instance)
-		return -1;
-
-	return pdev->bus->number - instance->bus0;
-}
-
-/* This is exported, as some devices need to access the MFD registers */
-struct sta2x11_instance *sta2x11_get_instance(struct pci_dev *pdev)
-{
-	return sta2x11_pdev_to_instance(pdev);
-}
-EXPORT_SYMBOL(sta2x11_get_instance);
-
-/* At setup time, we use our own ops if the device is a ConneXt one */
-static void sta2x11_setup_pdev(struct pci_dev *pdev)
-{
-	struct sta2x11_instance *instance = sta2x11_pdev_to_instance(pdev);
-
-	if (!instance) /* either a sta2x11 bridge or another ST device */
-		return;
-
-	/* We must enable all devices as master, for audio DMA to work */
-	pci_set_master(pdev);
-}
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_STMICRO, PCI_ANY_ID, sta2x11_setup_pdev);
-
-/*
- * At boot we must set up the mappings for the pcie-to-amba bridge.
- * It involves device access, and the same happens at suspend/resume time
- */
-
-#define AHB_MAPB		0xCA4
-#define AHB_CRW(i)		(AHB_MAPB + 0  + (i) * 0x10)
-#define AHB_CRW_SZMASK			0xfffffc00UL
-#define AHB_CRW_ENABLE			(1 << 0)
-#define AHB_CRW_WTYPE_MEM		(2 << 1)
-#define AHB_CRW_ROE			(1UL << 3)	/* Relax Order Ena */
-#define AHB_CRW_NSE			(1UL << 4)	/* No Snoop Enable */
-#define AHB_BASE(i)		(AHB_MAPB + 4  + (i) * 0x10)
-#define AHB_PEXLBASE(i)		(AHB_MAPB + 8  + (i) * 0x10)
-#define AHB_PEXHBASE(i)		(AHB_MAPB + 12 + (i) * 0x10)
-
-/* At probe time, enable mapping for each endpoint, using the pdev */
-static void sta2x11_map_ep(struct pci_dev *pdev)
-{
-	struct sta2x11_instance *instance = sta2x11_pdev_to_instance(pdev);
-	struct device *dev = &pdev->dev;
-	u32 amba_base, max_amba_addr;
-	int i, ret;
-
-	if (!instance)
-		return;
-
-	pci_read_config_dword(pdev, AHB_BASE(0), &amba_base);
-	max_amba_addr = amba_base + STA2X11_AMBA_SIZE - 1;
-
-	ret = dma_direct_set_offset(dev, 0, amba_base, STA2X11_AMBA_SIZE);
-	if (ret)
-		dev_err(dev, "sta2x11: could not set DMA offset\n");
-
-	dev->bus_dma_limit = max_amba_addr;
-	dma_set_mask_and_coherent(&pdev->dev, max_amba_addr);
-
-	/* Configure AHB mapping */
-	pci_write_config_dword(pdev, AHB_PEXLBASE(0), 0);
-	pci_write_config_dword(pdev, AHB_PEXHBASE(0), 0);
-	pci_write_config_dword(pdev, AHB_CRW(0), STA2X11_AMBA_SIZE |
-			       AHB_CRW_WTYPE_MEM | AHB_CRW_ENABLE);
-
-	/* Disable all the other windows */
-	for (i = 1; i < STA2X11_NR_FUNCS; i++)
-		pci_write_config_dword(pdev, AHB_CRW(i), 0);
-
-	dev_info(&pdev->dev,
-		 "sta2x11: Map EP %i: AMBA address %#8x-%#8x\n",
-		 sta2x11_pdev_to_ep(pdev), amba_base, max_amba_addr);
-}
-DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_STMICRO, PCI_ANY_ID, sta2x11_map_ep);
-
-#ifdef CONFIG_PM /* Some register values must be saved and restored */
-
-static struct sta2x11_mapping *sta2x11_pdev_to_mapping(struct pci_dev *pdev)
-{
-	struct sta2x11_instance *instance;
-	int ep;
-
-	instance = sta2x11_pdev_to_instance(pdev);
-	if (!instance)
-		return NULL;
-	ep = sta2x11_pdev_to_ep(pdev);
-	return instance->map + ep;
-}
-
-static void suspend_mapping(struct pci_dev *pdev)
-{
-	struct sta2x11_mapping *map = sta2x11_pdev_to_mapping(pdev);
-	int i;
-
-	if (!map)
-		return;
-
-	if (map->is_suspended)
-		return;
-	map->is_suspended = 1;
-
-	/* Save all window configs */
-	for (i = 0; i < STA2X11_NR_FUNCS; i++) {
-		struct sta2x11_ahb_regs *regs = map->regs + i;
-
-		pci_read_config_dword(pdev, AHB_BASE(i), &regs->base);
-		pci_read_config_dword(pdev, AHB_PEXLBASE(i), &regs->pexlbase);
-		pci_read_config_dword(pdev, AHB_PEXHBASE(i), &regs->pexhbase);
-		pci_read_config_dword(pdev, AHB_CRW(i), &regs->crw);
-	}
-}
-DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_STMICRO, PCI_ANY_ID, suspend_mapping);
-
-static void resume_mapping(struct pci_dev *pdev)
-{
-	struct sta2x11_mapping *map = sta2x11_pdev_to_mapping(pdev);
-	int i;
-
-	if (!map)
-		return;
-
-
-	if (!map->is_suspended)
-		goto out;
-	map->is_suspended = 0;
-
-	/* Restore all window configs */
-	for (i = 0; i < STA2X11_NR_FUNCS; i++) {
-		struct sta2x11_ahb_regs *regs = map->regs + i;
-
-		pci_write_config_dword(pdev, AHB_BASE(i), regs->base);
-		pci_write_config_dword(pdev, AHB_PEXLBASE(i), regs->pexlbase);
-		pci_write_config_dword(pdev, AHB_PEXHBASE(i), regs->pexhbase);
-		pci_write_config_dword(pdev, AHB_CRW(i), regs->crw);
-	}
-out:
-	pci_set_master(pdev); /* Like at boot, enable master on all devices */
-}
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_STMICRO, PCI_ANY_ID, resume_mapping);
-
-#endif /* CONFIG_PM */

