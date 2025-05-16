Return-Path: <linux-tip-commits+bounces-5630-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0459FABA442
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 478B17A90DA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8F327FD40;
	Fri, 16 May 2025 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XaTe24ah";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MiVaI5uU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E305F226CE0;
	Fri, 16 May 2025 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424830; cv=none; b=oAAgKDqIJaERQSxcSr3zo/YuQA+fyS5+wEtd4Dk3rgO7Aq20aSwc7Qs3dsiVeaKFwJzetweIzqlGPZvJhtq1t9dvJfJqBLVRLQnat/DSFZMaNiAQrmoAozffv/nzNLizEUpsmENwbOT337+a9ENfbDcDUm+bIBk26P6kl4CvYYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424830; c=relaxed/simple;
	bh=IIncdkAVDLVH7wFSv3ilSKtF0FFzb4agXNrfwSn7lpw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SB5M5bflngFSXNyN9lSlfaVSOL+FEH97xM3A7jGQFU8Fmlxodh6TQWanT7KxQQCLz+MOcslv/r1TGB8vB7NJPYZ0+tqG25uVgHEL0yX9lrAdaPOEuj1Q+z9xBgGyi0WSjZnXZSw4aqPu4Q6tohFvW2S4D16f4EcGOG3B+smBAYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XaTe24ah; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MiVaI5uU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:47:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424827;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JLE0SmYhpc++3YVT82D3Lauhn2EEMgIn87kbdFMmX+0=;
	b=XaTe24ahqrkVdYS8eFoR7IWVuA5830oPOctTpkGvUhOPlnxiuELymyVMNHvYT7xQJyp4Wh
	KdlCdZ5Lf0+R8t1fscZWm1FSxSgHOKGfhqwqCETcK3m6iu9WV0S8EOvLy16mh4TYjKKl25
	KITnIEcglZZeojfBtcekoDBVx+jde6JjqrWRyMEQiYsgVitzptz/OhaW/RdxVwNM0IPJpQ
	iAiwix3GZyHNizzZT/Sxa+6VplSwH/VT0PKrJwRv/Xc9n8saXmvD7jOjYWM/jm9rUHexFK
	/CUewOXPt6K/AkASojQbMGAkd5OE+b7l57sCSQ7Lc/EfOq8S7fG8bXAzjcQ+5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424827;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JLE0SmYhpc++3YVT82D3Lauhn2EEMgIn87kbdFMmX+0=;
	b=MiVaI5uUpn+VJMdI2/P2QmuOW2KbuzAhxDDKMwDoVYNv1ymE7kqx+CXHVxlVl5EoKE7kir
	AwT2FZc04UH7azAg==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI: apple: Convert to MSI parent infrastructure
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250513172819.2216709-8-maz@kernel.org>
References: <20250513172819.2216709-8-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742482607.406.7977961792102232153.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     5d627a9484ec447348f7c485359b1baf6d120f0f
Gitweb:        https://git.kernel.org/tip/5d627a9484ec447348f7c485359b1baf6d120f0f
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 13 May 2025 18:28:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:32:20 +02:00

PCI: apple: Convert to MSI parent infrastructure

In an effort to move ARM64 away from the legacy MSI setup, convert the
Apple PCIe driver to the MSI-parent infrastructure and let each device have
its own MSI domain.

[ tglx: Moved the struct out of the function call argument ]

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Link: https://lore.kernel.org/all/20250513172819.2216709-8-maz@kernel.org

---
 drivers/pci/controller/Kconfig      |  1 +-
 drivers/pci/controller/pcie-apple.c | 69 +++++++++-------------------
 2 files changed, 24 insertions(+), 46 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 9800b76..98a62f4 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -40,6 +40,7 @@ config PCIE_APPLE
 	depends on OF
 	depends on PCI_MSI
 	select PCI_HOST_COMMON
+	select IRQ_MSI_LIB
 	help
 	  Say Y here if you want to enable PCIe controller support on Apple
 	  system-on-chips, like the Apple M1. This is required for the USB
diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 18e11b9..3d412a9 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/iopoll.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqdomain.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -133,7 +134,6 @@ struct apple_pcie {
 	struct mutex		lock;
 	struct device		*dev;
 	void __iomem            *base;
-	struct irq_domain	*domain;
 	unsigned long		*bitmap;
 	struct list_head	ports;
 	struct completion	event;
@@ -162,27 +162,6 @@ static void rmw_clear(u32 clr, void __iomem *addr)
 	writel_relaxed(readl_relaxed(addr) & ~clr, addr);
 }
 
-static void apple_msi_top_irq_mask(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void apple_msi_top_irq_unmask(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
-
-static struct irq_chip apple_msi_top_chip = {
-	.name			= "PCIe MSI",
-	.irq_mask		= apple_msi_top_irq_mask,
-	.irq_unmask		= apple_msi_top_irq_unmask,
-	.irq_eoi		= irq_chip_eoi_parent,
-	.irq_set_affinity	= irq_chip_set_affinity_parent,
-	.irq_set_type		= irq_chip_set_type_parent,
-};
-
 static void apple_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	msg->address_hi = upper_32_bits(DOORBELL_ADDR);
@@ -226,8 +205,7 @@ static int apple_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 	for (i = 0; i < nr_irqs; i++) {
 		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
-					      &apple_msi_bottom_chip,
-					      domain->host_data);
+					      &apple_msi_bottom_chip, pcie);
 	}
 
 	return 0;
@@ -251,12 +229,6 @@ static const struct irq_domain_ops apple_msi_domain_ops = {
 	.free	= apple_msi_domain_free,
 };
 
-static struct msi_domain_info apple_msi_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
-	.chip	= &apple_msi_top_chip,
-};
-
 static void apple_port_irq_mask(struct irq_data *data)
 {
 	struct apple_pcie_port *port = irq_data_get_irq_chip_data(data);
@@ -595,11 +567,28 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	return 0;
 }
 
+static const struct msi_parent_ops apple_msi_parent_ops = {
+	.supported_flags	= (MSI_GENERIC_FLAGS_MASK	|
+				   MSI_FLAG_PCI_MSIX		|
+				   MSI_FLAG_MULTI_PCI_MSI),
+	.required_flags		= (MSI_FLAG_USE_DEF_DOM_OPS	|
+				   MSI_FLAG_USE_DEF_CHIP_OPS	|
+				   MSI_FLAG_PCI_MSI_MASK_PARENT),
+	.chip_flags		= MSI_CHIP_FLAG_SET_EOI,
+	.bus_select_token	= DOMAIN_BUS_PCI_MSI,
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+};
+
 static int apple_msi_init(struct apple_pcie *pcie)
 {
 	struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);
+	struct irq_domain_info info = {
+		.fwnode		= fwnode,
+		.ops		= &apple_msi_domain_ops,
+		.size		= pcie->nvecs,
+		.host_data	= pcie,
+	};
 	struct of_phandle_args args = {};
-	struct irq_domain *parent;
 	int ret;
 
 	ret = of_parse_phandle_with_args(to_of_node(fwnode), "msi-ranges",
@@ -619,28 +608,16 @@ static int apple_msi_init(struct apple_pcie *pcie)
 	if (!pcie->bitmap)
 		return -ENOMEM;
 
-	parent = irq_find_matching_fwspec(&pcie->fwspec, DOMAIN_BUS_WIRED);
-	if (!parent) {
+	info.parent = irq_find_matching_fwspec(&pcie->fwspec, DOMAIN_BUS_WIRED);
+	if (!info.parent) {
 		dev_err(pcie->dev, "failed to find parent domain\n");
 		return -ENXIO;
 	}
 
-	parent = irq_domain_create_hierarchy(parent, 0, pcie->nvecs, fwnode,
-					     &apple_msi_domain_ops, pcie);
-	if (!parent) {
+	if (!msi_create_parent_irq_domain(&info, &apple_msi_parent_ops)) {
 		dev_err(pcie->dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
-	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
-
-	pcie->domain = pci_msi_create_irq_domain(fwnode, &apple_msi_info,
-						 parent);
-	if (!pcie->domain) {
-		dev_err(pcie->dev, "failed to create MSI domain\n");
-		irq_domain_remove(parent);
-		return -ENOMEM;
-	}
-
 	return 0;
 }
 

