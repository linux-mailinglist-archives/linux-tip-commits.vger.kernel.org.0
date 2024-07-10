Return-Path: <linux-tip-commits+bounces-1660-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C2092D666
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 18:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63BA1C20CF4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 16:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40977194C7D;
	Wed, 10 Jul 2024 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p8d88jYb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FgeRXW5D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B612F198A2C;
	Wed, 10 Jul 2024 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628756; cv=none; b=FDHMaSPsR3xMkFIIrwt0y4ICdYnHgY0E5c1AuTVYQn73QATZ9Ewzmp+5G8kyEwbxtP1klmMSP3zpKtPhj8vlmd6BP/z4qb3PwR8rXACYSpDcn4ToMlfmT2/qEK+ajIy039CMhv5RJc3petIlazZ0hDEI1VXtvBwh7LUw0+pOzao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628756; c=relaxed/simple;
	bh=7jsvJRO1pa4mDiaDeMPsS9VzEWbOICd98JFyaSJDQMU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nZEUyu1lQYE1tGe4+9kl194rbRCmnENBCK8ODD8hCa3k554qjmuMFvAf9Xr/GcF3yn9PvyoU2GW/OEVNV0Q9X6gOUkW7XToaSOxpJOLpuiJfftDuXsbj57+/nyPMQFLGFE9Ufw2oIa6tVkn8UAAGXGD72eWAAv3rEvtDCn2c+rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p8d88jYb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FgeRXW5D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jul 2024 16:25:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720628751;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqmg1KCZwqY0G9pcuWh06ddTrczRqG6E2fxC3eD+mXE=;
	b=p8d88jYbA2Ya9Eboi6edmvilwTUMKBhZbrQlBt75OLCLSLJody8w0epzXXhbyVu7Sc0Oas
	kLpwL0JFKIQknu12bomvFknEnFSgBSV1kF7Poo3mvija51Q+t/P/sPIPmzhXdGFtZrk3U+
	3MOJnejv0TX3wglBf5TNO+y7lfYxPqUEBke2MIw5iwQRlnrKgOoNVb1PPA9f9uFLPFxNyi
	vEfy/BTspVGXae6lcwQ7GTMcdmD4yuJVZ13P3ZlntQOMjZVkOWerBzvcoz/bbvBy8bw6OW
	+vOPYX6v9CVMoZYcdwfcIvwR6mW5A6GuPl6nKOzBfbsXd9dX4ktmnsbNc/ij1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720628751;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqmg1KCZwqY0G9pcuWh06ddTrczRqG6E2fxC3eD+mXE=;
	b=FgeRXW5Dl6oUj9e4qS2ymdb4c6Y3Kd5CzaOnbHOuqm6CKwVzrGBnCj5t8uzMte3IplmrNQ
	rzRvFoxyaFPhRfCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic_v3_mbi: Switch over to parent domain
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240623142235.455849114@linutronix.de>
References: <20240623142235.455849114@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172062875107.2215.17061642902413501384.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2e63b1cc9cf75c6c213ae0b9b9cec97111ea64a9
Gitweb:        https://git.kernel.org/tip/2e63b1cc9cf75c6c213ae0b9b9cec97111ea64a9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:18:51 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Jul 2024 18:19:24 +02:00

irqchip/gic_v3_mbi: Switch over to parent domain

The MBI chip creates two MSI domains:
    - PCI/MSI
    - Platform device domain

Both have the MBI domain as parent and differ slightly in the interrupt
chip callbacks and the platform device domain supports level type
signaling.

Convert it over to the MSI parent domain mechanism by:

   - Providing the required templates
   
   - Implementing a custom init_dev_msi_info() callback which sets the chip
     callbacks and the level support flags depending on the domain bus token
     type of the per device domain.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240623142235.455849114@linutronix.de

---
 drivers/irqchip/irq-gic-v3-mbi.c | 130 ++++++++++--------------------
 1 file changed, 47 insertions(+), 83 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index dbb8b1e..3fe870f 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -18,6 +18,8 @@
 
 #include <linux/irqchip/arm-gic-v3.h>
 
+#include "irq-msi-lib.h"
+
 struct mbi_range {
 	u32			spi_start;
 	u32			nr_spis;
@@ -138,6 +140,7 @@ static void mbi_irq_domain_free(struct irq_domain *domain,
 }
 
 static const struct irq_domain_ops mbi_domain_ops = {
+	.select			= msi_lib_irq_domain_select,
 	.alloc			= mbi_irq_domain_alloc,
 	.free			= mbi_irq_domain_free,
 };
@@ -151,54 +154,6 @@ static void mbi_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
 }
 
-#ifdef CONFIG_PCI_MSI
-/* PCI-specific irqchip */
-static void mbi_mask_msi_irq(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void mbi_unmask_msi_irq(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
-
-static struct irq_chip mbi_msi_irq_chip = {
-	.name			= "MSI",
-	.irq_mask		= mbi_mask_msi_irq,
-	.irq_unmask		= mbi_unmask_msi_irq,
-	.irq_eoi		= irq_chip_eoi_parent,
-	.irq_compose_msi_msg	= mbi_compose_msi_msg,
-};
-
-static struct msi_domain_info mbi_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
-	.chip	= &mbi_msi_irq_chip,
-};
-
-static int mbi_allocate_pci_domain(struct irq_domain *nexus_domain,
-				   struct irq_domain **pci_domain)
-{
-	*pci_domain = pci_msi_create_irq_domain(nexus_domain->parent->fwnode,
-						&mbi_msi_domain_info,
-						nexus_domain);
-	if (!*pci_domain)
-		return -ENOMEM;
-
-	return 0;
-}
-#else
-static int mbi_allocate_pci_domain(struct irq_domain *nexus_domain,
-				   struct irq_domain **pci_domain)
-{
-	*pci_domain = NULL;
-	return 0;
-}
-#endif
-
 static void mbi_compose_mbi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	mbi_compose_msi_msg(data, msg);
@@ -210,28 +165,51 @@ static void mbi_compose_mbi_msg(struct irq_data *data, struct msi_msg *msg)
 	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), &msg[1]);
 }
 
-/* Platform-MSI specific irqchip */
-static struct irq_chip mbi_pmsi_irq_chip = {
-	.name			= "pMSI",
-	.irq_set_type		= irq_chip_set_type_parent,
-	.irq_compose_msi_msg	= mbi_compose_mbi_msg,
-	.flags			= IRQCHIP_SUPPORTS_LEVEL_MSI,
-};
-
-static struct msi_domain_ops mbi_pmsi_ops = {
-};
+static bool mbi_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+				  struct irq_domain *real_parent, struct msi_domain_info *info)
+{
+	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
+		return false;
+
+	switch (info->bus_token) {
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		info->chip->irq_compose_msi_msg = mbi_compose_msi_msg;
+		return true;
+
+	case DOMAIN_BUS_DEVICE_MSI:
+		info->chip->irq_compose_msi_msg = mbi_compose_mbi_msg;
+		info->chip->irq_set_type = irq_chip_set_type_parent;
+		info->chip->flags |= IRQCHIP_SUPPORTS_LEVEL_MSI;
+		info->flags |= MSI_FLAG_LEVEL_CAPABLE;
+		return true;
+
+	default:
+		WARN_ON_ONCE(1);
+		return false;
+	}
+}
 
-static struct msi_domain_info mbi_pmsi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_LEVEL_CAPABLE),
-	.ops	= &mbi_pmsi_ops,
-	.chip	= &mbi_pmsi_irq_chip,
+#define MBI_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				 MSI_FLAG_USE_DEF_CHIP_OPS |	\
+				 MSI_FLAG_PCI_MSI_MASK_PARENT)
+
+#define MBI_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				 MSI_FLAG_PCI_MSIX      |	\
+				 MSI_FLAG_MULTI_PCI_MSI)
+
+static const struct msi_parent_ops gic_v3_mbi_msi_parent_ops = {
+	.supported_flags	= MBI_MSI_FLAGS_SUPPORTED,
+	.required_flags		= MBI_MSI_FLAGS_REQUIRED,
+	.bus_select_token	= DOMAIN_BUS_NEXUS,
+	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
+	.prefix			= "MBI-",
+	.init_dev_msi_info	= mbi_init_dev_msi_info,
 };
 
-static int mbi_allocate_domains(struct irq_domain *parent)
+static int mbi_allocate_domain(struct irq_domain *parent)
 {
-	struct irq_domain *nexus_domain, *pci_domain, *plat_domain;
-	int err;
+	struct irq_domain *nexus_domain;
 
 	nexus_domain = irq_domain_create_hierarchy(parent, 0, 0, parent->fwnode,
 						   &mbi_domain_ops, NULL);
@@ -239,22 +217,8 @@ static int mbi_allocate_domains(struct irq_domain *parent)
 		return -ENOMEM;
 
 	irq_domain_update_bus_token(nexus_domain, DOMAIN_BUS_NEXUS);
-
-	err = mbi_allocate_pci_domain(nexus_domain, &pci_domain);
-
-	plat_domain = platform_msi_create_irq_domain(parent->fwnode,
-						     &mbi_pmsi_domain_info,
-						     nexus_domain);
-
-	if (err || !plat_domain) {
-		if (plat_domain)
-			irq_domain_remove(plat_domain);
-		if (pci_domain)
-			irq_domain_remove(pci_domain);
-		irq_domain_remove(nexus_domain);
-		return -ENOMEM;
-	}
-
+	nexus_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	nexus_domain->msi_parent_ops = &gic_v3_mbi_msi_parent_ops;
 	return 0;
 }
 
@@ -317,7 +281,7 @@ int __init mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent)
 
 	pr_info("Using MBI frame %pa\n", &mbi_phys_base);
 
-	ret = mbi_allocate_domains(parent);
+	ret = mbi_allocate_domain(parent);
 	if (ret)
 		goto err_free_mbi;
 

