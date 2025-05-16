Return-Path: <linux-tip-commits+bounces-5628-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AB4ABA43F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9F21B68296
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C4223504E;
	Fri, 16 May 2025 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Aabesied";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1biq8CT6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD9619006B;
	Fri, 16 May 2025 19:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424828; cv=none; b=aycrcvZ6Elmdc+m1vSqLNRVjDL+dLq2yarYWIJy/kpPp1HZ/KJ99EBe7bSFDaBfUwDXsV7mBaodR2nm0dpap2pSA+cD+8DBYMmNR3+P3iQKrl0D6+ppJ0w9Uke3LVH1Q/TfK9gAPXz86OIC3SK3my8Za0LCVnPDfXt2M/M3//uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424828; c=relaxed/simple;
	bh=rJ+Zt7plysAkFBmD/M0WYGDoHI3OsXJHei1dOgX/DUQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MITS0eAC9LC1Gm1tpqost2dycFgrlsgEHmN5YV7aenFCNd6MbkiYBI5XnfuoNkwsGEotx/7sbYNu6FH+1YZaG/Y7mJhHMEqNh5w1adCMXiBP0lY1I5xh4smHLjHFQ+Zic7YHZ5O5dqwC1jdFW9QBEu/CDqP56tsnRd9gFjAKWHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Aabesied; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1biq8CT6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:47:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424825;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AC6sSGWB4Z9P+Ga5Tyvu6VAUypCZQJcICRiEApIu4LI=;
	b=Aabesied2Vb+y8KKwvSIN9Sw86y6stw/zLlNRDOZfMxH+pUyNstH4sIZ0MzvhpCXpnlDdS
	VfEVdsgvOHfViCrUyZeuAl68Xc7yaHALCO1+IQi/iPqJ1ghkuMR5dmG1KIukjrgf438RGQ
	Y4rTuvygSEWIV2+CrUp9k0ynVO6KKxIPepEcbqBv+yW9/Qn1lauLltiOZNeSVu0evh27y2
	WZpkuBBj7Tk8RE1rCjMQjc29vlF/Z7lw/Wzxo/Uwpkyyes1VYoKXb9XOkmDLrNoRWGVN89
	Tt1GIQsspDCQEQEOph6xeVX/brHmxdTf36hpOcu9hSlw6cCz2U4p/pqB01YfFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424825;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AC6sSGWB4Z9P+Ga5Tyvu6VAUypCZQJcICRiEApIu4LI=;
	b=1biq8CT6mfoiIMWgwTpFSLUSmrQEvP0vAtDHYkr6WFj2Z0zm+c9WgfY8c7W3MQZX9Pk8aG
	+TaoHPyg0eq/bpAA==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI: tegra: Convert to MSI parent infrastructure
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250513172819.2216709-10-maz@kernel.org>
References: <20250513172819.2216709-10-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742482434.406.11557246839616511940.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     944242787695ec86ff00d925391d5b54902c546a
Gitweb:        https://git.kernel.org/tip/944242787695ec86ff00d925391d5b54902c546a
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 13 May 2025 18:28:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:32:20 +02:00

PCI: tegra: Convert to MSI parent infrastructure

In an effort to move ARM64 away from the legacy MSI setup, convert the
Tegra PCIe driver to the MSI-parent infrastructure and let each device have
its own MSI domain.

[ tglx: Moved the struct out of the function call argument ]

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250513172819.2216709-10-maz@kernel.org

---
 drivers/pci/controller/Kconfig     |  1 +-
 drivers/pci/controller/pci-tegra.c | 63 ++++++++---------------------
 2 files changed, 20 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 205e0e3..eb3cc28 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -228,6 +228,7 @@ config PCI_TEGRA
 	bool "NVIDIA Tegra PCIe controller"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on PCI_MSI
+	select IRQ_MSI_LIB
 	help
 	  Say Y here if you want support for the PCIe host controller found
 	  on NVIDIA Tegra SoCs.
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index d2f8899..467ddc7 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -22,6 +22,7 @@
 #include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -1547,7 +1548,7 @@ static void tegra_pcie_msi_irq(struct irq_desc *desc)
 			unsigned int index = i * 32 + offset;
 			int ret;
 
-			ret = generic_handle_domain_irq(msi->domain->parent, index);
+			ret = generic_handle_domain_irq(msi->domain, index);
 			if (ret) {
 				/*
 				 * that's weird who triggered this?
@@ -1565,30 +1566,6 @@ static void tegra_pcie_msi_irq(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static void tegra_msi_top_irq_ack(struct irq_data *d)
-{
-	irq_chip_ack_parent(d);
-}
-
-static void tegra_msi_top_irq_mask(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void tegra_msi_top_irq_unmask(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
-
-static struct irq_chip tegra_msi_top_chip = {
-	.name		= "Tegra PCIe MSI",
-	.irq_ack	= tegra_msi_top_irq_ack,
-	.irq_mask	= tegra_msi_top_irq_mask,
-	.irq_unmask	= tegra_msi_top_irq_unmask,
-};
-
 static void tegra_msi_irq_ack(struct irq_data *d)
 {
 	struct tegra_msi *msi = irq_data_get_irq_chip_data(d);
@@ -1690,42 +1667,40 @@ static const struct irq_domain_ops tegra_msi_domain_ops = {
 	.free = tegra_msi_domain_free,
 };
 
-static struct msi_domain_info tegra_msi_info = {
-	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_NO_AFFINITY | MSI_FLAG_PCI_MSIX,
-	.chip	= &tegra_msi_top_chip,
+static const struct msi_parent_ops tegra_msi_parent_ops = {
+	.supported_flags	= (MSI_GENERIC_FLAGS_MASK	|
+				   MSI_FLAG_PCI_MSIX),
+	.required_flags		= (MSI_FLAG_USE_DEF_DOM_OPS	|
+				   MSI_FLAG_USE_DEF_CHIP_OPS	|
+				   MSI_FLAG_PCI_MSI_MASK_PARENT	|
+				   MSI_FLAG_NO_AFFINITY),
+	.chip_flags		= MSI_CHIP_FLAG_SET_ACK,
+	.bus_select_token	= DOMAIN_BUS_PCI_MSI,
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
 };
 
 static int tegra_allocate_domains(struct tegra_msi *msi)
 {
 	struct tegra_pcie *pcie = msi_to_pcie(msi);
 	struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);
-	struct irq_domain *parent;
-
-	parent = irq_domain_create_linear(fwnode, INT_PCI_MSI_NR,
-					  &tegra_msi_domain_ops, msi);
-	if (!parent) {
-		dev_err(pcie->dev, "failed to create IRQ domain\n");
-		return -ENOMEM;
-	}
-	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
+	struct irq_domain_info info = {
+		.fwnode		= fwnode,
+		.ops		= &tegra_msi_domain_ops,
+		.size		= INT_PCI_MSI_NR,
+		.host_data	= msi,
+	};
 
-	msi->domain = pci_msi_create_irq_domain(fwnode, &tegra_msi_info, parent);
+	msi->domain = msi_create_parent_irq_domain(&info, &tegra_msi_parent_ops);
 	if (!msi->domain) {
 		dev_err(pcie->dev, "failed to create MSI domain\n");
-		irq_domain_remove(parent);
 		return -ENOMEM;
 	}
-
 	return 0;
 }
 
 static void tegra_free_domains(struct tegra_msi *msi)
 {
-	struct irq_domain *parent = msi->domain->parent;
-
 	irq_domain_remove(msi->domain);
-	irq_domain_remove(parent);
 }
 
 static int tegra_pcie_msi_setup(struct tegra_pcie *pcie)

