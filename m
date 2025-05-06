Return-Path: <linux-tip-commits+bounces-5313-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCECAAC616
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3B917C466
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32A028A1C9;
	Tue,  6 May 2025 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YDNSuEY5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OWkQVOI0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4548528937D;
	Tue,  6 May 2025 13:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537650; cv=none; b=dhTNW+sPOh7GvP+xGI/ZU8qRj28SWINmBCZbZI2ENkuxeD5Et6ik8AjPvXeluCMb26G8snJ7ug/XRK854H9B1aY4Y0bXSKDLpYYR4BeNpVBnQhbiajeVkGKpf2BbIzWrIO6rOUXyPgTZPo99fNHdQWla+AsoRd2CnnlMLfXyxR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537650; c=relaxed/simple;
	bh=Lkdxg1y5h+6jjui5zrhVwCBOKdwBq/aG65CwDFs7BEI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m9wu/80xnVjUxcBFpNPC7MkXJ2ugI5KGZ3KVsQ+eHi8ZYousQw4biDGyimReF2CLbifvL/HzfohVTHWnIdhwWmfoG7kTwZmN+rYj3Kw8QpOY010rfFQHb9O6nGH3oz46pfCxm8ti14fvk0KFMMq9iv04l9Eyf3a5WIP2mmEKc7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YDNSuEY5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OWkQVOI0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537645;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKTyq+4ufZNj3A6HNtR3IqVepQWJ71uZO9tjdXjgtF8=;
	b=YDNSuEY5I1a0+yS+VIhk4/hCCo80l5J19w8uByDtjRhpa0aEAvRvpHaXKPHVYNhTFkGdEy
	zkBkHrCnG5GI9c1USFiEE1d5XczE2UzIJzigeRThcrNylLuAFxv+CgVmqRr4GHMYlWNZ/G
	8B7dCvcm/nxeofVWAUayqN9Ir6RWCSd6yeTRhB0H3QanErmZGSefWaflRDfLhThdCQfli6
	7gqhMGUjmFTTTcUnceMwIyWb+gtKgqXjrCNps+p0BekzoxWzX7Tejhc0lzK8QIiRtS5a8P
	vMesqgBvYquMojGsJtyZxYDW27ChDcoGn2vKHgn2fGF/YtcE7JMxVxAjUBEF1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537645;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKTyq+4ufZNj3A6HNtR3IqVepQWJ71uZO9tjdXjgtF8=;
	b=OWkQVOI07ovN+d83l08X9Tt5RF2Ha28Qcd8FwaRQ+9jhOjQaURm0bx0w9bE5ibKp35ZRkB
	V5I725Tpu5vfhqCg==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] irqdomain: pci: Switch to of_fwnode_handle()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-8-jirislaby@kernel.org>
References: <20250319092951.37667-8-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174653764464.406.14081569908110848829.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     fdc348121f2465897792f946715a5da7887e5f97
Gitweb:        https://git.kernel.org/tip/fdc348121f2465897792f946715a5da7887e5f97
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:00 +01:00
Committer:     Bjorn Helgaas <bhelgaas@google.com>
CommitterDate: Mon, 07 Apr 2025 12:15:14 -05:00

irqdomain: pci: Switch to of_fwnode_handle()

of_node_to_fwnode() is irqdomain's reimplementation of the "officially"
defined of_fwnode_handle(). The former is in the process of being removed,
so use the latter instead.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20250319092951.37667-8-jirislaby@kernel.org
---
 drivers/pci/controller/dwc/pcie-designware-host.c    | 2 +-
 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 2 +-
 drivers/pci/controller/pci-xgene-msi.c               | 2 +-
 drivers/pci/controller/pcie-altera-msi.c             | 2 +-
 drivers/pci/controller/pcie-brcmstb.c                | 2 +-
 drivers/pci/controller/pcie-iproc-msi.c              | 2 +-
 drivers/pci/controller/pcie-mediatek.c               | 2 +-
 drivers/pci/controller/pcie-xilinx-dma-pl.c          | 2 +-
 drivers/pci/controller/pcie-xilinx-nwl.c             | 2 +-
 drivers/pci/controller/plda/pcie-plda-host.c         | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ecc33f6..d1cd48e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -227,7 +227,7 @@ static const struct irq_domain_ops dw_pcie_msi_domain_ops = {
 int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
+	struct fwnode_handle *fwnode = of_fwnode_handle(pci->dev->of_node);
 
 	pp->irq_domain = irq_domain_create_linear(fwnode, pp->num_vectors,
 					       &dw_pcie_msi_domain_ops, pp);
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index 0e088e7..6628eed 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -435,7 +435,7 @@ static const struct irq_domain_ops msi_domain_ops = {
 static int mobiveil_allocate_msi_domains(struct mobiveil_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
-	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
+	struct fwnode_handle *fwnode = of_fwnode_handle(dev->of_node);
 	struct mobiveil_msi *msi = &pcie->rp.msi;
 
 	mutex_init(&msi->lock);
diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index 7bce327..69a9c0a 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -247,7 +247,7 @@ static int xgene_allocate_domains(struct xgene_msi *msi)
 	if (!msi->inner_domain)
 		return -ENOMEM;
 
-	msi->msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(msi->node),
+	msi->msi_domain = pci_msi_create_irq_domain(of_fwnode_handle(msi->node),
 						    &xgene_msi_domain_info,
 						    msi->inner_domain);
 
diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
index e1cee3c..5fb3a2e 100644
--- a/drivers/pci/controller/pcie-altera-msi.c
+++ b/drivers/pci/controller/pcie-altera-msi.c
@@ -164,7 +164,7 @@ static const struct irq_domain_ops msi_domain_ops = {
 
 static int altera_allocate_domains(struct altera_msi *msi)
 {
-	struct fwnode_handle *fwnode = of_node_to_fwnode(msi->pdev->dev.of_node);
+	struct fwnode_handle *fwnode = of_fwnode_handle(msi->pdev->dev.of_node);
 
 	msi->inner_domain = irq_domain_add_linear(NULL, msi->num_of_vectors,
 					     &msi_domain_ops, msi);
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index e19628e..924a81e 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -581,7 +581,7 @@ static const struct irq_domain_ops msi_domain_ops = {
 
 static int brcm_allocate_domains(struct brcm_msi *msi)
 {
-	struct fwnode_handle *fwnode = of_node_to_fwnode(msi->np);
+	struct fwnode_handle *fwnode = of_fwnode_handle(msi->np);
 	struct device *dev = msi->dev;
 
 	msi->inner_domain = irq_domain_add_linear(NULL, msi->nr, &msi_domain_ops, msi);
diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
index 649fcb4..804b3a5 100644
--- a/drivers/pci/controller/pcie-iproc-msi.c
+++ b/drivers/pci/controller/pcie-iproc-msi.c
@@ -451,7 +451,7 @@ static int iproc_msi_alloc_domains(struct device_node *node,
 	if (!msi->inner_domain)
 		return -ENOMEM;
 
-	msi->msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(node),
+	msi->msi_domain = pci_msi_create_irq_domain(of_fwnode_handle(node),
 						    &iproc_msi_domain_info,
 						    msi->inner_domain);
 	if (!msi->msi_domain) {
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 811a8b4..efcc4a7 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -485,7 +485,7 @@ static struct msi_domain_info mtk_msi_domain_info = {
 
 static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
 {
-	struct fwnode_handle *fwnode = of_node_to_fwnode(port->pcie->dev->of_node);
+	struct fwnode_handle *fwnode = of_fwnode_handle(port->pcie->dev->of_node);
 
 	mutex_init(&port->lock);
 
diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
index dd117f0..71cf13a 100644
--- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
+++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
@@ -470,7 +470,7 @@ static int xilinx_pl_dma_pcie_init_msi_irq_domain(struct pl_dma_pcie *port)
 	struct device *dev = port->dev;
 	struct xilinx_msi *msi = &port->msi;
 	int size = BITS_TO_LONGS(XILINX_NUM_MSI_IRQS) * sizeof(long);
-	struct fwnode_handle *fwnode = of_node_to_fwnode(port->dev->of_node);
+	struct fwnode_handle *fwnode = of_fwnode_handle(port->dev->of_node);
 
 	msi->dev_domain = irq_domain_add_linear(NULL, XILINX_NUM_MSI_IRQS,
 						&dev_msi_domain_ops, port);
diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 8d6e2a8..9cf8a96 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -495,7 +495,7 @@ static int nwl_pcie_init_msi_irq_domain(struct nwl_pcie *pcie)
 {
 #ifdef CONFIG_PCI_MSI
 	struct device *dev = pcie->dev;
-	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
+	struct fwnode_handle *fwnode = of_fwnode_handle(dev->of_node);
 	struct nwl_msi *msi = &pcie->msi;
 
 	msi->dev_domain = irq_domain_add_linear(NULL, INT_PCI_MSI_NR,
diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index 4153214..4c7a9fa 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -150,7 +150,7 @@ static struct msi_domain_info plda_msi_domain_info = {
 static int plda_allocate_msi_domains(struct plda_pcie_rp *port)
 {
 	struct device *dev = port->dev;
-	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
+	struct fwnode_handle *fwnode = of_fwnode_handle(dev->of_node);
 	struct plda_msi *msi = &port->msi;
 
 	mutex_init(&port->msi.lock);

