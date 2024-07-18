Return-Path: <linux-tip-commits+bounces-1729-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B9F9351C9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 20:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6314EB2154E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 18:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EA21487C0;
	Thu, 18 Jul 2024 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jNvRuGWt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DY0BkesX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67C61465A0;
	Thu, 18 Jul 2024 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327949; cv=none; b=KxZSRCW3Ei/amlDc/T8uVinYA5SPgw3QbMfSkanaAXaPY6uDpJlo60NckOVwiRww4HeMAb7PHLyv9W5KOxUA+ZxwPXdEnuPzb5cByKK55CKLD66YpQbV8h2QUcyBd51GJZDiGxNWgXIqjUohwR+PB8hVxkXj9QRz5O2v81QpA5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327949; c=relaxed/simple;
	bh=Fg0Wo+73guJ1Xts+9YArvjH5q6VqDssw0ea9aPAYbvA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nedAt3q6pYOjc4kWYS7DRzFsyuZ3iQ7LjyCDj7um+n269PsbMwq8b1/KYG/h1jEsCL/ROJHqr3kOFw5+7iUtXJvb4qLzja3jGx+nZhLeenfYf/bN2sC6NeP4/mWUlYkoRH/nR4zDIIGWFgd0Da+G/9sJ8fx9JqYMS6ubPRq4Vo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jNvRuGWt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DY0BkesX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jul 2024 18:39:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721327941;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zq7byvcY1wpRmwdyP3SAJGou+hH4x1dwg+pANQgV560=;
	b=jNvRuGWtlZtrqyi6VHsoVVX5zGdFB+rlft0SutVL1B0zfYDrfAIhknTzBaZG2qPJt4lyT0
	fVbjY2lxAarvM3D5wRxjz5TVJIBlBJCwMEOXXSKSP0OLOb79sGE4YQH+6BJl1VOTjC/rid
	lyS3q+T3ZZ2gUD/nx3nTFAZBWNd9/W9euhAP+YKhpLBy7LIdhmjq/lvmcZjV5LUBb5LxsV
	tbiCCU5eTw5j/S8IW1Has/BnehdM4PFRfm43kgVg8Ydqj+ymin4kxr+iL2fbpt16fx5GK3
	XUVtnUmGgSCPoBdvRB+eyXPXyImRp0Hre6wMxd58UtI5baDshfzYRnkUPtdSaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721327941;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zq7byvcY1wpRmwdyP3SAJGou+hH4x1dwg+pANQgV560=;
	b=DY0BkesXbtV8m7IqcI8K/IzSqbBuUUAaqoGizHZZ3TwvbJb1LO7nZBrG2lxPjCW/I0/PvW
	qBpUmidbzQoMTGBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240623142235.024567623@linutronix.de>
References: <20240623142235.024567623@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172132794147.2215.5360744427829017993.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     b5712bf89b4bbc5bcc9ebde8753ad222f1f68296
Gitweb:        https://git.kernel.org/tip/b5712bf89b4bbc5bcc9ebde8753ad222f1f68296
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:18:39 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jul 2024 20:31:20 +02:00

irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]

The its_pci_msi_prepare() function from the ITS-PCI/MSI code provides the
'global' PCI/MSI domains. Move this function to the ITS-MSI parent code and
amend the function to use the domain hardware size, which is the MSI[X]
vector count, for allocating the ITS slots for the PCI device.

Enable PCI matching in msi_parent_ops and provide the necessary update to
the ITS specific child domain initialization function so that the prepare
callback gets invoked on allocations.

The latter might be optimized to do the allocation right at the point where
the child domain is initialized, but keep it simple for now.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240623142235.024567623@linutronix.de



---
 drivers/irqchip/Makefile                    |   1 +-
 drivers/irqchip/irq-gic-v3-its-msi-parent.c | 114 ++++++++++-
 drivers/irqchip/irq-gic-v3-its-pci-msi.c    | 202 +-------------------
 3 files changed, 111 insertions(+), 206 deletions(-)
 delete mode 100644 drivers/irqchip/irq-gic-v3-its-pci-msi.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 6e4f771..c531663 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -33,7 +33,6 @@ obj-$(CONFIG_IRQ_MSI_LIB)		+= irq-msi-lib.o
 obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-v3-mbi.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-platform-msi.o irq-gic-v4.o irq-gic-v3-its-msi-parent.o
-obj-$(CONFIG_ARM_GIC_V3_ITS_PCI)	+= irq-gic-v3-its-pci-msi.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+= irq-gic-v3-its-fsl-mc-msi.o
 obj-$(CONFIG_PARTITION_PERCPU)		+= irq-partition-percpu.o
 obj-$(CONFIG_HISILICON_IRQ_MBIGEN)	+= irq-mbigen.o
diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index cdc0844..33b04c3 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -1,17 +1,100 @@
 // SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2013-2015 ARM Limited, All Rights Reserved.
+// Author: Marc Zyngier <marc.zyngier@arm.com>
 // Copyright (C) 2022 Linutronix GmbH
 // Copyright (C) 2022 Intel
 
+#include <linux/pci.h>
+
 #include "irq-gic-common.h"
 #include "irq-msi-lib.h"
 
 #define ITS_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
-				 MSI_FLAG_USE_DEF_CHIP_OPS)
+				 MSI_FLAG_USE_DEF_CHIP_OPS |	\
+				 MSI_FLAG_PCI_MSI_MASK_PARENT)
 
 #define ITS_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
 				 MSI_FLAG_PCI_MSIX      |	\
-				 MSI_FLAG_MULTI_PCI_MSI |	\
-				 MSI_FLAG_PCI_MSI_MASK_PARENT)
+				 MSI_FLAG_MULTI_PCI_MSI)
+
+#ifdef CONFIG_PCI_MSI
+static int its_pci_msi_vec_count(struct pci_dev *pdev, void *data)
+{
+	int msi, msix, *count = data;
+
+	msi = max(pci_msi_vec_count(pdev), 0);
+	msix = max(pci_msix_vec_count(pdev), 0);
+	*count += max(msi, msix);
+
+	return 0;
+}
+
+static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
+{
+	struct pci_dev **alias_dev = data;
+
+	*alias_dev = pdev;
+
+	return 0;
+}
+
+static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
+			       int nvec, msi_alloc_info_t *info)
+{
+	struct pci_dev *pdev, *alias_dev;
+	struct msi_domain_info *msi_info;
+	int alias_count = 0, minnvec = 1;
+
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	pdev = to_pci_dev(dev);
+	/*
+	 * If pdev is downstream of any aliasing bridges, take an upper
+	 * bound of how many other vectors could map to the same DevID.
+	 * Also tell the ITS that the signalling will come from a proxy
+	 * device, and that special allocation rules apply.
+	 */
+	pci_for_each_dma_alias(pdev, its_get_pci_alias, &alias_dev);
+	if (alias_dev != pdev) {
+		if (alias_dev->subordinate)
+			pci_walk_bus(alias_dev->subordinate,
+				     its_pci_msi_vec_count, &alias_count);
+		info->flags |= MSI_ALLOC_FLAGS_PROXY_DEVICE;
+	}
+
+	/* ITS specific DeviceID, as the core ITS ignores dev. */
+	info->scratchpad[0].ul = pci_msi_domain_get_msi_rid(domain, pdev);
+
+	/*
+	 * @domain->msi_domain_info->hwsize contains the size of the
+	 * MSI[-X] domain, but vector allocation happens one by one. This
+	 * needs some thought when MSI comes into play as the size of MSI
+	 * might be unknown at domain creation time and therefore set to
+	 * MSI_MAX_INDEX.
+	 */
+	msi_info = msi_get_domain_info(domain);
+	if (msi_info->hwsize > nvec)
+		nvec = msi_info->hwsize;
+
+	/*
+	 * Always allocate a power of 2, and special case device 0 for
+	 * broken systems where the DevID is not wired (and all devices
+	 * appear as DevID 0). For that reason, we generously allocate a
+	 * minimum of 32 MSIs for DevID 0. If you want more because all
+	 * your devices are aliasing to DevID 0, consider fixing your HW.
+	 */
+	nvec = max(nvec, alias_count);
+	if (!info->scratchpad[0].ul)
+		minnvec = 32;
+	nvec = max_t(int, minnvec, roundup_pow_of_two(nvec));
+
+	msi_info = msi_get_domain_info(domain->parent);
+	return msi_info->ops->msi_prepare(domain->parent, dev, nvec, info);
+}
+#else /* CONFIG_PCI_MSI */
+#define its_pci_msi_prepare	NULL
+#endif /* !CONFIG_PCI_MSI */
 
 static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 				  struct irq_domain *real_parent, struct msi_domain_info *info)
@@ -19,6 +102,30 @@ static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
 		return false;
 
+	switch(info->bus_token) {
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		/*
+		 * FIXME: This probably should be done after a (not yet
+		 * existing) post domain creation callback once to make
+		 * support for dynamic post-enable MSI-X allocations
+		 * work without having to reevaluate the domain size
+		 * over and over. It is known already at allocation
+		 * time via info->hwsize.
+		 *
+		 * That should work perfectly fine for MSI/MSI-X but needs
+		 * some thoughts for purely software managed MSI domains
+		 * where the index space is only limited artificially via
+		 * %MSI_MAX_INDEX.
+		 */
+		info->ops->msi_prepare = its_pci_msi_prepare;
+		break;
+	default:
+		/* Confused. How did the lib return true? */
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
 	return true;
 }
 
@@ -26,6 +133,7 @@ const struct msi_parent_ops gic_v3_its_msi_parent_ops = {
 	.supported_flags	= ITS_MSI_FLAGS_SUPPORTED,
 	.required_flags		= ITS_MSI_FLAGS_REQUIRED,
 	.bus_select_token	= DOMAIN_BUS_NEXUS,
+	.bus_select_mask	= MATCH_PCI_MSI,
 	.prefix			= "ITS-",
 	.init_dev_msi_info	= its_init_dev_msi_info,
 };
diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
deleted file mode 100644
index 93f77a8..0000000
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ /dev/null
@@ -1,202 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2013-2015 ARM Limited, All Rights Reserved.
- * Author: Marc Zyngier <marc.zyngier@arm.com>
- */
-
-#include <linux/acpi_iort.h>
-#include <linux/pci.h>
-#include <linux/msi.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
-#include <linux/of_pci.h>
-
-static void its_mask_msi_irq(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void its_unmask_msi_irq(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
-
-static struct irq_chip its_msi_irq_chip = {
-	.name			= "ITS-MSI",
-	.irq_unmask		= its_unmask_msi_irq,
-	.irq_mask		= its_mask_msi_irq,
-	.irq_eoi		= irq_chip_eoi_parent,
-};
-
-static int its_pci_msi_vec_count(struct pci_dev *pdev, void *data)
-{
-	int msi, msix, *count = data;
-
-	msi = max(pci_msi_vec_count(pdev), 0);
-	msix = max(pci_msix_vec_count(pdev), 0);
-	*count += max(msi, msix);
-
-	return 0;
-}
-
-static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
-{
-	struct pci_dev **alias_dev = data;
-
-	*alias_dev = pdev;
-
-	return 0;
-}
-
-static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
-			       int nvec, msi_alloc_info_t *info)
-{
-	struct pci_dev *pdev, *alias_dev;
-	struct msi_domain_info *msi_info;
-	int alias_count = 0, minnvec = 1;
-
-	if (!dev_is_pci(dev))
-		return -EINVAL;
-
-	msi_info = msi_get_domain_info(domain->parent);
-
-	pdev = to_pci_dev(dev);
-	/*
-	 * If pdev is downstream of any aliasing bridges, take an upper
-	 * bound of how many other vectors could map to the same DevID.
-	 * Also tell the ITS that the signalling will come from a proxy
-	 * device, and that special allocation rules apply.
-	 */
-	pci_for_each_dma_alias(pdev, its_get_pci_alias, &alias_dev);
-	if (alias_dev != pdev) {
-		if (alias_dev->subordinate)
-			pci_walk_bus(alias_dev->subordinate,
-				     its_pci_msi_vec_count, &alias_count);
-		info->flags |= MSI_ALLOC_FLAGS_PROXY_DEVICE;
-	}
-
-	/* ITS specific DeviceID, as the core ITS ignores dev. */
-	info->scratchpad[0].ul = pci_msi_domain_get_msi_rid(domain, pdev);
-
-	/*
-	 * Always allocate a power of 2, and special case device 0 for
-	 * broken systems where the DevID is not wired (and all devices
-	 * appear as DevID 0). For that reason, we generously allocate a
-	 * minimum of 32 MSIs for DevID 0. If you want more because all
-	 * your devices are aliasing to DevID 0, consider fixing your HW.
-	 */
-	nvec = max(nvec, alias_count);
-	if (!info->scratchpad[0].ul)
-		minnvec = 32;
-	nvec = max_t(int, minnvec, roundup_pow_of_two(nvec));
-	return msi_info->ops->msi_prepare(domain->parent, dev, nvec, info);
-}
-
-static struct msi_domain_ops its_pci_msi_ops = {
-	.msi_prepare	= its_pci_msi_prepare,
-};
-
-static struct msi_domain_info its_pci_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
-	.ops	= &its_pci_msi_ops,
-	.chip	= &its_msi_irq_chip,
-};
-
-static struct of_device_id its_device_id[] = {
-	{	.compatible	= "arm,gic-v3-its",	},
-	{},
-};
-
-static int __init its_pci_msi_init_one(struct fwnode_handle *handle,
-				       const char *name)
-{
-	struct irq_domain *parent;
-
-	parent = irq_find_matching_fwnode(handle, DOMAIN_BUS_NEXUS);
-	if (!parent || !msi_get_domain_info(parent)) {
-		pr_err("%s: Unable to locate ITS domain\n", name);
-		return -ENXIO;
-	}
-
-	if (!pci_msi_create_irq_domain(handle, &its_pci_msi_domain_info,
-				       parent)) {
-		pr_err("%s: Unable to create PCI domain\n", name);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static int __init its_pci_of_msi_init(void)
-{
-	struct device_node *np;
-
-	for (np = of_find_matching_node(NULL, its_device_id); np;
-	     np = of_find_matching_node(np, its_device_id)) {
-		if (!of_device_is_available(np))
-			continue;
-		if (!of_property_read_bool(np, "msi-controller"))
-			continue;
-
-		if (its_pci_msi_init_one(of_node_to_fwnode(np), np->full_name))
-			continue;
-
-		pr_info("PCI/MSI: %pOF domain created\n", np);
-	}
-
-	return 0;
-}
-
-#ifdef CONFIG_ACPI
-
-static int __init
-its_pci_msi_parse_madt(union acpi_subtable_headers *header,
-		       const unsigned long end)
-{
-	struct acpi_madt_generic_translator *its_entry;
-	struct fwnode_handle *dom_handle;
-	const char *node_name;
-	int err = -ENXIO;
-
-	its_entry = (struct acpi_madt_generic_translator *)header;
-	node_name = kasprintf(GFP_KERNEL, "ITS@0x%lx",
-			      (long)its_entry->base_address);
-	dom_handle = iort_find_domain_token(its_entry->translation_id);
-	if (!dom_handle) {
-		pr_err("%s: Unable to locate ITS domain handle\n", node_name);
-		goto out;
-	}
-
-	err = its_pci_msi_init_one(dom_handle, node_name);
-	if (!err)
-		pr_info("PCI/MSI: %s domain created\n", node_name);
-
-out:
-	kfree(node_name);
-	return err;
-}
-
-static int __init its_pci_acpi_msi_init(void)
-{
-	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
-			      its_pci_msi_parse_madt, 0);
-	return 0;
-}
-#else
-static int __init its_pci_acpi_msi_init(void)
-{
-	return 0;
-}
-#endif
-
-static int __init its_pci_msi_init(void)
-{
-	its_pci_of_msi_init();
-	its_pci_acpi_msi_init();
-
-	return 0;
-}
-early_initcall(its_pci_msi_init);

