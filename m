Return-Path: <linux-tip-commits+bounces-1659-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210BD92D663
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 18:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC6A1C20B60
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 16:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110AA1990C1;
	Wed, 10 Jul 2024 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0UO2TS7P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xQt2ItKA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EF1198A2A;
	Wed, 10 Jul 2024 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628755; cv=none; b=WfUVGWQOuwCK8+75he20DOfXGCtAFsf4GbQQWZz4l3VvcXhZv5NcmUJx8bgKbT28UBD4zUieKrspkXk00Fds0m8OmvsEfE3UgswodZY2slaVMu1hgXdbthy5mDw/WRgOgz4QSobJsHqpFZhkfuroFoz098JharNEYvGDlK+hYAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628755; c=relaxed/simple;
	bh=Mgu4Cy87R486oY6rjgDi/y8ZHBcZTb8A5ZX+tb4o6eM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Fx41dVOUL5H0oOVU0UThDB4MwhW7Jdlvq39n3HXqo7hmSYxJ2JP/tKcCCKlgZ1AyRxETn4T330dOQHqEfIe/BIgxKJVnI/CSaSPQy88Tzp4c/VB7vhDwb7EASWAmtkp5qUK6Uo8m1GnZkxEkBBIHuCROWaN3a2rmzYkXd9LWAe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0UO2TS7P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xQt2ItKA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jul 2024 16:25:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720628751;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IAKqFl6xp/20hMacoaSJca3hrbTwkQ170U9o/jpjSoI=;
	b=0UO2TS7PeysXgq2RqD9h+eaHawMNkrDGRd2ZqzkXnry9PuUFEPSJ4IoKUTZF6Q+vvDlHIs
	2CjlOIm0UmkbYVefjsxNK8hnrpd82nkb/V3H0NDecM5YB47En/KrrirhXKRxTGAhGyCflc
	Q/jPt9t7kBJd8huFD4+TWoF6+J/Jt4jf0XfXp7Q2KnRc/HKsaaV6dN01L5R3tgTW2n+U8p
	ga4G+0Kzbu3binPtwidHDZdluSgv6Q75TyxIMyOwh2egeeQJf6ktx5596R7M+bGe5/9qxX
	Yef42ELSqbsc/S2zRPdbaWbrpIVOKy4vvwEO1ucrVbA2PCdXolDwUwEa9g71HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720628751;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IAKqFl6xp/20hMacoaSJca3hrbTwkQ170U9o/jpjSoI=;
	b=xQt2ItKAD7y18ezhGXMYYIHugILXrQ5q+h4gEdAINlNp2xQNug+kg8rmITpLXZJ3mcrvAc
	GMnNtvxI0xnYptAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v2m: Switch to device MSI
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240623142235.514419280@linutronix.de>
References: <20240623142235.514419280@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172062875065.2215.14658200940928088353.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7b89a879cce4f81fb08e7aeb7b2639fe755803bb
Gitweb:        https://git.kernel.org/tip/7b89a879cce4f81fb08e7aeb7b2639fe755803bb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:18:53 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Jul 2024 18:19:24 +02:00

irqchip/gic-v2m: Switch to device MSI

All platform MSI users and the PCI/MSI code handle per device MSI domains
when the irqdomain associated to the device provides MSI parent
functionality.

Remove the "global" PCI/MSI and platform domain related code and provide
the MSI parent functionality by filling in msi_parent_ops.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240623142235.514419280@linutronix.de



---
 drivers/irqchip/Kconfig       |  1 +-
 drivers/irqchip/irq-gic-v2m.c | 81 ++++++++++------------------------
 2 files changed, 26 insertions(+), 56 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index ee78716..d3fbe56 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -26,6 +26,7 @@ config ARM_GIC_V2M
 	bool
 	depends on PCI
 	select ARM_GIC
+	select IRQ_MSI_LIB
 	select PCI_MSI
 
 config GIC_NON_BANKED
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index f2ff438..51af63c 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -26,6 +26,8 @@
 #include <linux/irqchip/arm-gic.h>
 #include <linux/irqchip/arm-gic-common.h>
 
+#include "irq-msi-lib.h"
+
 /*
 * MSI_TYPER:
 *     [31:26] Reserved
@@ -72,31 +74,6 @@ struct v2m_data {
 	u32 flags;		/* v2m flags for specific implementation */
 };
 
-static void gicv2m_mask_msi_irq(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void gicv2m_unmask_msi_irq(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
-
-static struct irq_chip gicv2m_msi_irq_chip = {
-	.name			= "MSI",
-	.irq_mask		= gicv2m_mask_msi_irq,
-	.irq_unmask		= gicv2m_unmask_msi_irq,
-	.irq_eoi		= irq_chip_eoi_parent,
-};
-
-static struct msi_domain_info gicv2m_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
-	.chip	= &gicv2m_msi_irq_chip,
-};
-
 static phys_addr_t gicv2m_get_msi_addr(struct v2m_data *v2m, int hwirq)
 {
 	if (v2m->flags & GICV2M_GRAVITON_ADDRESS_ONLY)
@@ -230,6 +207,7 @@ static void gicv2m_irq_domain_free(struct irq_domain *domain,
 }
 
 static const struct irq_domain_ops gicv2m_domain_ops = {
+	.select			= msi_lib_irq_domain_select,
 	.alloc			= gicv2m_irq_domain_alloc,
 	.free			= gicv2m_irq_domain_free,
 };
@@ -250,19 +228,6 @@ static bool is_msi_spi_valid(u32 base, u32 num)
 	return true;
 }
 
-static struct irq_chip gicv2m_pmsi_irq_chip = {
-	.name			= "pMSI",
-};
-
-static struct msi_domain_ops gicv2m_pmsi_ops = {
-};
-
-static struct msi_domain_info gicv2m_pmsi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
-	.ops	= &gicv2m_pmsi_ops,
-	.chip	= &gicv2m_pmsi_irq_chip,
-};
-
 static void __init gicv2m_teardown(void)
 {
 	struct v2m_data *v2m, *tmp;
@@ -278,9 +243,27 @@ static void __init gicv2m_teardown(void)
 	}
 }
 
+
+#define GICV2M_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |		\
+				    MSI_FLAG_USE_DEF_CHIP_OPS |		\
+				    MSI_FLAG_PCI_MSI_MASK_PARENT)
+
+#define GICV2M_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				    MSI_FLAG_PCI_MSIX      |	\
+				    MSI_FLAG_MULTI_PCI_MSI)
+
+static struct msi_parent_ops gicv2m_msi_parent_ops = {
+	.supported_flags	= GICV2M_MSI_FLAGS_SUPPORTED,
+	.required_flags		= GICV2M_MSI_FLAGS_REQUIRED,
+	.bus_select_token	= DOMAIN_BUS_NEXUS,
+	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
+	.prefix			= "GICv2m-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+};
+
 static __init int gicv2m_allocate_domains(struct irq_domain *parent)
 {
-	struct irq_domain *inner_domain, *pci_domain, *plat_domain;
+	struct irq_domain *inner_domain;
 	struct v2m_data *v2m;
 
 	v2m = list_first_entry_or_null(&v2m_nodes, struct v2m_data, entry);
@@ -295,22 +278,8 @@ static __init int gicv2m_allocate_domains(struct irq_domain *parent)
 	}
 
 	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
-	pci_domain = pci_msi_create_irq_domain(v2m->fwnode,
-					       &gicv2m_msi_domain_info,
-					       inner_domain);
-	plat_domain = platform_msi_create_irq_domain(v2m->fwnode,
-						     &gicv2m_pmsi_domain_info,
-						     inner_domain);
-	if (!pci_domain || !plat_domain) {
-		pr_err("Failed to create MSI domains\n");
-		if (plat_domain)
-			irq_domain_remove(plat_domain);
-		if (pci_domain)
-			irq_domain_remove(pci_domain);
-		irq_domain_remove(inner_domain);
-		return -ENOMEM;
-	}
-
+	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	inner_domain->msi_parent_ops = &gicv2m_msi_parent_ops;
 	return 0;
 }
 
@@ -511,7 +480,7 @@ acpi_parse_madt_msi(union acpi_subtable_headers *header,
 		pr_info("applying Amazon Graviton quirk\n");
 		res.end = res.start + SZ_8K - 1;
 		flags |= GICV2M_GRAVITON_ADDRESS_ONLY;
-		gicv2m_msi_domain_info.flags &= ~MSI_FLAG_MULTI_PCI_MSI;
+		gicv2m_msi_parent_ops.supported_flags &= ~MSI_FLAG_MULTI_PCI_MSI;
 	}
 
 	if (m->flags & ACPI_MADT_OVERRIDE_SPI_VALUES) {

