Return-Path: <linux-tip-commits+bounces-5607-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2B1ABA40F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0A650498B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FC528641B;
	Fri, 16 May 2025 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rl3AZ6m1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZHlipjwE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5E6284B56;
	Fri, 16 May 2025 19:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424259; cv=none; b=gY38a/CnShwSS8fa3n0OlEzeF4xd+bGBca/vEh/6oOdyDC+Yz9+HzBUC0DsJn8yjZqPG1WKTfzs3ENTQKbGlm0wwNHVR4IFA2+M7AX9rQleuHmcD7LBag6VoRDKwA9NVoZh0+R2/xEwcPTPtu29tZ16u8PzUrjD/PBDc50xXelE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424259; c=relaxed/simple;
	bh=9PqExx6PucC/pwUkcybYbEvuZu/bqwiPSn/cfLS4PG8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eN6tc6s9eg7983H8wpu8QzfEKdS2pFKRoKKnJNpsLdy8zbMwG9ghvjPtEF/XmHSdO+SBCwdoW/E0cYlgZst53YliBJ5Y0BdcZQno50BlpaEA+XdremBxOOwm16ZKJKXCYEmem21E8dvGteps6YwMZq+FadXCu+jhZ8wGeb+gFy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rl3AZ6m1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZHlipjwE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424254;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqtpS9m0zJk6xaLSxhAXQEXSBBtguUybb1AdMdIzdTY=;
	b=rl3AZ6m1q2ZDYLWOej1NHpDhnhsRCv7vyTC+Ny4/ybkhIDLmh/KIqa7WCq8WKkqfhemmCk
	lDnlHcTjWOaUcP0kiXE2Wk5a+k57owYZLQ+ZsMCZErrvc0rXW5zfHrAZzeTix6VKUZPtrL
	oenJtPgBZ7salUbhLhtC0D061SWK68TlHoNG9EozLzcrWGzLKZQl0EaHLX+Y7JTNzDlZGu
	zgTvvFEqeZmVBmSary5+QGUhD1jLXZ4NwPuLiKhis5GH9EAeiVG8C3FvRb+u5rRGeiIONC
	In5W7Lg8LR67FK/7RJsNNc2nB3d1/nZMEb26LcsoTxmlxtDv+Yardavdo+LVug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424254;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqtpS9m0zJk6xaLSxhAXQEXSBBtguUybb1AdMdIzdTY=;
	b=ZHlipjwENTVzMJm7SibccHhO7dKATUb47UBRt/KL3WMK1Nnyya/Fg5ugUCEXiTPymdpG5p
	hLXV589yJZb/TMDQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] PCI: Switch to irq_domain_create_linear()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-30-jirislaby@kernel.org>
References: <20250319092951.37667-30-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742425353.406.15051699612290869169.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     4b5e1d97154df4e0e2dabfc3e6bef68b87265a55
Gitweb:        https://git.kernel.org/tip/4b5e1d97154df4e0e2dabfc3e6bef68b87265a55
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:22 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:10 +02:00

PCI: Switch to irq_domain_create_linear()

irq_domain_add_linear() is going away as being obsolete now. Switch to
the preferred irq_domain_create_linear(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

[ tglx: Fix up subject prefix and convert the new instance in
  	dwc/pcie-amd-mdb.c ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-30-jirislaby@kernel.org



---
 drivers/pci/controller/dwc/pci-dra7xx.c              |  4 +--
 drivers/pci/controller/dwc/pci-keystone.c            |  2 +-
 drivers/pci/controller/dwc/pcie-amd-mdb.c            |  8 +++---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c        |  4 +--
 drivers/pci/controller/dwc/pcie-uniphier.c           |  2 +-
 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c |  9 +++----
 drivers/pci/controller/pci-aardvark.c                | 14 +++--------
 drivers/pci/controller/pci-ftpci100.c                |  4 +--
 drivers/pci/controller/pci-mvebu.c                   |  6 ++---
 drivers/pci/controller/pcie-altera-msi.c             |  2 +-
 drivers/pci/controller/pcie-altera.c                 |  2 +-
 drivers/pci/controller/pcie-brcmstb.c                |  2 +-
 drivers/pci/controller/pcie-iproc-msi.c              |  4 +--
 drivers/pci/controller/pcie-mediatek-gen3.c          |  9 +++----
 drivers/pci/controller/pcie-mediatek.c               |  4 +--
 drivers/pci/controller/pcie-rockchip-host.c          |  4 +--
 drivers/pci/controller/pcie-xilinx-cpm.c             | 10 +++-----
 drivers/pci/controller/pcie-xilinx-dma-pl.c          | 12 ++++-----
 drivers/pci/controller/pcie-xilinx-nwl.c             |  9 ++-----
 drivers/pci/controller/pcie-xilinx.c                 |  5 +---
 drivers/pci/controller/plda/pcie-plda-host.c         | 14 ++++-------
 21 files changed, 59 insertions(+), 71 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 33d6bf4..3219704 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -359,8 +359,8 @@ static int dra7xx_pcie_init_irq_domain(struct dw_pcie_rp *pp)
 
 	irq_set_chained_handler_and_data(pp->irq, dra7xx_pcie_msi_irq_handler,
 					 pp);
-	dra7xx->irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-						   &intx_domain_ops, pp);
+	dra7xx->irq_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node),
+						      PCI_NUM_INTX, &intx_domain_ops, pp);
 	of_node_put(pcie_intc_node);
 	if (!dra7xx->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 76a3736..1385d9d 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -761,7 +761,7 @@ static int ks_pcie_config_intx_irq(struct keystone_pcie *ks_pcie)
 						 ks_pcie);
 	}
 
-	intx_irq_domain = irq_domain_add_linear(intc_np, PCI_NUM_INTX,
+	intx_irq_domain = irq_domain_create_linear(of_fwnode_handle(intc_np), PCI_NUM_INTX,
 					&ks_pcie_intx_irq_domain_ops, NULL);
 	if (!intx_irq_domain) {
 		dev_err(dev, "Failed to add irq domain for INTX irqs\n");
diff --git a/drivers/pci/controller/dwc/pcie-amd-mdb.c b/drivers/pci/controller/dwc/pcie-amd-mdb.c
index 4eb2a4e..9f7251a 100644
--- a/drivers/pci/controller/dwc/pcie-amd-mdb.c
+++ b/drivers/pci/controller/dwc/pcie-amd-mdb.c
@@ -290,8 +290,8 @@ static int amd_mdb_pcie_init_irq_domains(struct amd_mdb_pcie *pcie,
 		return -ENODEV;
 	}
 
-	pcie->mdb_domain = irq_domain_add_linear(pcie_intc_node, 32,
-						 &event_domain_ops, pcie);
+	pcie->mdb_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node), 32,
+						    &event_domain_ops, pcie);
 	if (!pcie->mdb_domain) {
 		err = -ENOMEM;
 		dev_err(dev, "Failed to add MDB domain\n");
@@ -300,8 +300,8 @@ static int amd_mdb_pcie_init_irq_domains(struct amd_mdb_pcie *pcie,
 
 	irq_domain_update_bus_token(pcie->mdb_domain, DOMAIN_BUS_NEXUS);
 
-	pcie->intx_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-						  &amd_intx_domain_ops, pcie);
+	pcie->intx_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node),
+						     PCI_NUM_INTX, &amd_intx_domain_ops, pcie);
 	if (!pcie->intx_domain) {
 		err = -ENOMEM;
 		dev_err(dev, "Failed to add INTx domain\n");
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index c624b7e..678d510 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -144,8 +144,8 @@ static int rockchip_pcie_init_irq_domain(struct rockchip_pcie *rockchip)
 		return -EINVAL;
 	}
 
-	rockchip->irq_domain = irq_domain_add_linear(intc, PCI_NUM_INTX,
-						    &intx_domain_ops, rockchip);
+	rockchip->irq_domain = irq_domain_create_linear(of_fwnode_handle(intc), PCI_NUM_INTX,
+							&intx_domain_ops, rockchip);
 	of_node_put(intc);
 	if (!rockchip->irq_domain) {
 		dev_err(dev, "failed to get a INTx IRQ domain\n");
diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index 5757ca3..43b28f8 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -279,7 +279,7 @@ static int uniphier_pcie_config_intx_irq(struct dw_pcie_rp *pp)
 		goto out_put_node;
 	}
 
-	pcie->intx_irq_domain = irq_domain_add_linear(np_intc, PCI_NUM_INTX,
+	pcie->intx_irq_domain = irq_domain_create_linear(of_fwnode_handle(np_intc), PCI_NUM_INTX,
 						&uniphier_intx_domain_ops, pp);
 	if (!pcie->intx_irq_domain) {
 		dev_err(pci->dev, "Failed to get INTx domain\n");
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index 6628eed..a600f46 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -439,8 +439,8 @@ static int mobiveil_allocate_msi_domains(struct mobiveil_pcie *pcie)
 	struct mobiveil_msi *msi = &pcie->rp.msi;
 
 	mutex_init(&msi->lock);
-	msi->dev_domain = irq_domain_add_linear(NULL, msi->num_of_vectors,
-						&msi_domain_ops, pcie);
+	msi->dev_domain = irq_domain_create_linear(NULL, msi->num_of_vectors,
+						   &msi_domain_ops, pcie);
 	if (!msi->dev_domain) {
 		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
@@ -461,12 +461,11 @@ static int mobiveil_allocate_msi_domains(struct mobiveil_pcie *pcie)
 static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
-	struct device_node *node = dev->of_node;
 	struct mobiveil_root_port *rp = &pcie->rp;
 
 	/* setup INTx */
-	rp->intx_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
-						&intx_domain_ops, pcie);
+	rp->intx_domain = irq_domain_create_linear(of_fwnode_handle(dev->of_node), PCI_NUM_INTX,
+						   &intx_domain_ops, pcie);
 
 	if (!rp->intx_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index a29796c..7bac645 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1456,9 +1456,8 @@ static int advk_pcie_init_msi_irq_domain(struct advk_pcie *pcie)
 	raw_spin_lock_init(&pcie->msi_irq_lock);
 	mutex_init(&pcie->msi_used_lock);
 
-	pcie->msi_inner_domain =
-		irq_domain_add_linear(NULL, MSI_IRQ_NUM,
-				      &advk_msi_domain_ops, pcie);
+	pcie->msi_inner_domain = irq_domain_create_linear(NULL, MSI_IRQ_NUM,
+							  &advk_msi_domain_ops, pcie);
 	if (!pcie->msi_inner_domain)
 		return -ENOMEM;
 
@@ -1508,9 +1507,8 @@ static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
 	irq_chip->irq_mask = advk_pcie_irq_mask;
 	irq_chip->irq_unmask = advk_pcie_irq_unmask;
 
-	pcie->irq_domain =
-		irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-				      &advk_pcie_irq_domain_ops, pcie);
+	pcie->irq_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node), PCI_NUM_INTX,
+						    &advk_pcie_irq_domain_ops, pcie);
 	if (!pcie->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		ret = -ENOMEM;
@@ -1549,9 +1547,7 @@ static const struct irq_domain_ops advk_pcie_rp_irq_domain_ops = {
 
 static int advk_pcie_init_rp_irq_domain(struct advk_pcie *pcie)
 {
-	pcie->rp_irq_domain = irq_domain_add_linear(NULL, 1,
-						    &advk_pcie_rp_irq_domain_ops,
-						    pcie);
+	pcie->rp_irq_domain = irq_domain_create_linear(NULL, 1, &advk_pcie_rp_irq_domain_ops, pcie);
 	if (!pcie->rp_irq_domain) {
 		dev_err(&pcie->pdev->dev, "Failed to add Root Port IRQ domain\n");
 		return -ENOMEM;
diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index ffdeed2..28e4383 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -345,8 +345,8 @@ static int faraday_pci_setup_cascaded_irq(struct faraday_pci *p)
 		return irq ?: -EINVAL;
 	}
 
-	p->irqdomain = irq_domain_add_linear(intc, PCI_NUM_INTX,
-					     &faraday_pci_irqdomain_ops, p);
+	p->irqdomain = irq_domain_create_linear(of_fwnode_handle(intc), PCI_NUM_INTX,
+						&faraday_pci_irqdomain_ops, p);
 	of_node_put(intc);
 	if (!p->irqdomain) {
 		dev_err(p->dev, "failed to create Gemini PCI IRQ domain\n");
diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index b0e3bce..60da24b 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1078,9 +1078,9 @@ static int mvebu_pcie_init_irq_domain(struct mvebu_pcie_port *port)
 		return -ENODEV;
 	}
 
-	port->intx_irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-						      &mvebu_pcie_intx_irq_domain_ops,
-						      port);
+	port->intx_irq_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node),
+							 PCI_NUM_INTX,
+							 &mvebu_pcie_intx_irq_domain_ops, port);
 	of_node_put(pcie_intc_node);
 	if (!port->intx_irq_domain) {
 		dev_err(dev, "Failed to get INTx IRQ domain for %s\n", port->name);
diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
index 5fb3a2e..a43f21e 100644
--- a/drivers/pci/controller/pcie-altera-msi.c
+++ b/drivers/pci/controller/pcie-altera-msi.c
@@ -166,7 +166,7 @@ static int altera_allocate_domains(struct altera_msi *msi)
 {
 	struct fwnode_handle *fwnode = of_fwnode_handle(msi->pdev->dev.of_node);
 
-	msi->inner_domain = irq_domain_add_linear(NULL, msi->num_of_vectors,
+	msi->inner_domain = irq_domain_create_linear(NULL, msi->num_of_vectors,
 					     &msi_domain_ops, msi);
 	if (!msi->inner_domain) {
 		dev_err(&msi->pdev->dev, "failed to create IRQ domain\n");
diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 70409e7..0fc7717 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -855,7 +855,7 @@ static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
 	struct device_node *node = dev->of_node;
 
 	/* Setup INTx */
-	pcie->irq_domain = irq_domain_add_linear(node, PCI_NUM_INTX,
+	pcie->irq_domain = irq_domain_create_linear(of_fwnode_handle(node), PCI_NUM_INTX,
 					&intx_domain_ops, pcie);
 	if (!pcie->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 924a81e..92887b3 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -584,7 +584,7 @@ static int brcm_allocate_domains(struct brcm_msi *msi)
 	struct fwnode_handle *fwnode = of_fwnode_handle(msi->np);
 	struct device *dev = msi->dev;
 
-	msi->inner_domain = irq_domain_add_linear(NULL, msi->nr, &msi_domain_ops, msi);
+	msi->inner_domain = irq_domain_create_linear(NULL, msi->nr, &msi_domain_ops, msi);
 	if (!msi->inner_domain) {
 		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
index 804b3a5..d2cb4c4 100644
--- a/drivers/pci/controller/pcie-iproc-msi.c
+++ b/drivers/pci/controller/pcie-iproc-msi.c
@@ -446,8 +446,8 @@ static void iproc_msi_disable(struct iproc_msi *msi)
 static int iproc_msi_alloc_domains(struct device_node *node,
 				   struct iproc_msi *msi)
 {
-	msi->inner_domain = irq_domain_add_linear(NULL, msi->nr_msi_vecs,
-						  &msi_domain_ops, msi);
+	msi->inner_domain = irq_domain_create_linear(NULL, msi->nr_msi_vecs,
+						     &msi_domain_ops, msi);
 	if (!msi->inner_domain)
 		return -ENOMEM;
 
diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 9d52504..b55f597 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -745,8 +745,8 @@ static int mtk_pcie_init_irq_domains(struct mtk_gen3_pcie *pcie)
 		return -ENODEV;
 	}
 
-	pcie->intx_domain = irq_domain_add_linear(intc_node, PCI_NUM_INTX,
-						  &intx_domain_ops, pcie);
+	pcie->intx_domain = irq_domain_create_linear(of_fwnode_handle(intc_node), PCI_NUM_INTX,
+						     &intx_domain_ops, pcie);
 	if (!pcie->intx_domain) {
 		dev_err(dev, "failed to create INTx IRQ domain\n");
 		ret = -ENODEV;
@@ -756,8 +756,9 @@ static int mtk_pcie_init_irq_domains(struct mtk_gen3_pcie *pcie)
 	/* Setup MSI */
 	mutex_init(&pcie->lock);
 
-	pcie->msi_bottom_domain = irq_domain_add_linear(node, PCIE_MSI_IRQS_NUM,
-				  &mtk_msi_bottom_domain_ops, pcie);
+	pcie->msi_bottom_domain = irq_domain_create_linear(of_fwnode_handle(node),
+							   PCIE_MSI_IRQS_NUM,
+							   &mtk_msi_bottom_domain_ops, pcie);
 	if (!pcie->msi_bottom_domain) {
 		dev_err(dev, "failed to create MSI bottom domain\n");
 		ret = -ENODEV;
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index efcc4a7..e1934aa 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -569,8 +569,8 @@ static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
 		return -ENODEV;
 	}
 
-	port->irq_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-						 &intx_domain_ops, port);
+	port->irq_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node), PCI_NUM_INTX,
+						    &intx_domain_ops, port);
 	of_node_put(pcie_intc_node);
 	if (!port->irq_domain) {
 		dev_err(dev, "failed to get INTx IRQ domain\n");
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 6a46be1..b9e7a87 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -693,8 +693,8 @@ static int rockchip_pcie_init_irq_domain(struct rockchip_pcie *rockchip)
 		return -EINVAL;
 	}
 
-	rockchip->irq_domain = irq_domain_add_linear(intc, PCI_NUM_INTX,
-						    &intx_domain_ops, rockchip);
+	rockchip->irq_domain = irq_domain_create_linear(of_fwnode_handle(intc), PCI_NUM_INTX,
+							&intx_domain_ops, rockchip);
 	of_node_put(intc);
 	if (!rockchip->irq_domain) {
 		dev_err(dev, "failed to get a INTx IRQ domain\n");
diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index 13ca493..d38f27e 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -395,17 +395,15 @@ static int xilinx_cpm_pcie_init_irq_domain(struct xilinx_cpm_pcie *port)
 		return -EINVAL;
 	}
 
-	port->cpm_domain = irq_domain_add_linear(pcie_intc_node, 32,
-						 &event_domain_ops,
-						 port);
+	port->cpm_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node), 32,
+						    &event_domain_ops, port);
 	if (!port->cpm_domain)
 		goto out;
 
 	irq_domain_update_bus_token(port->cpm_domain, DOMAIN_BUS_NEXUS);
 
-	port->intx_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-						  &intx_domain_ops,
-						  port);
+	port->intx_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node), PCI_NUM_INTX,
+						     &intx_domain_ops, port);
 	if (!port->intx_domain)
 		goto out;
 
diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
index 71cf13a..dc9690a 100644
--- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
+++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
@@ -472,8 +472,8 @@ static int xilinx_pl_dma_pcie_init_msi_irq_domain(struct pl_dma_pcie *port)
 	int size = BITS_TO_LONGS(XILINX_NUM_MSI_IRQS) * sizeof(long);
 	struct fwnode_handle *fwnode = of_fwnode_handle(port->dev->of_node);
 
-	msi->dev_domain = irq_domain_add_linear(NULL, XILINX_NUM_MSI_IRQS,
-						&dev_msi_domain_ops, port);
+	msi->dev_domain = irq_domain_create_linear(NULL, XILINX_NUM_MSI_IRQS,
+						   &dev_msi_domain_ops, port);
 	if (!msi->dev_domain)
 		goto out;
 
@@ -585,15 +585,15 @@ static int xilinx_pl_dma_pcie_init_irq_domain(struct pl_dma_pcie *port)
 		return -EINVAL;
 	}
 
-	port->pldma_domain = irq_domain_add_linear(pcie_intc_node, 32,
-						   &event_domain_ops, port);
+	port->pldma_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node), 32,
+						      &event_domain_ops, port);
 	if (!port->pldma_domain)
 		return -ENOMEM;
 
 	irq_domain_update_bus_token(port->pldma_domain, DOMAIN_BUS_NEXUS);
 
-	port->intx_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-						  &intx_domain_ops, port);
+	port->intx_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node), PCI_NUM_INTX,
+						     &intx_domain_ops, port);
 	if (!port->intx_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		return -ENOMEM;
diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 9cf8a96..c8b0547 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -498,8 +498,7 @@ static int nwl_pcie_init_msi_irq_domain(struct nwl_pcie *pcie)
 	struct fwnode_handle *fwnode = of_fwnode_handle(dev->of_node);
 	struct nwl_msi *msi = &pcie->msi;
 
-	msi->dev_domain = irq_domain_add_linear(NULL, INT_PCI_MSI_NR,
-						&dev_msi_domain_ops, pcie);
+	msi->dev_domain = irq_domain_create_linear(NULL, INT_PCI_MSI_NR, &dev_msi_domain_ops, pcie);
 	if (!msi->dev_domain) {
 		dev_err(dev, "failed to create dev IRQ domain\n");
 		return -ENOMEM;
@@ -582,10 +581,8 @@ static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
 		return -EINVAL;
 	}
 
-	pcie->intx_irq_domain = irq_domain_add_linear(intc_node,
-						      PCI_NUM_INTX,
-						      &intx_domain_ops,
-						      pcie);
+	pcie->intx_irq_domain = irq_domain_create_linear(of_fwnode_handle(intc_node), PCI_NUM_INTX,
+							 &intx_domain_ops, pcie);
 	of_node_put(intc_node);
 	if (!pcie->intx_irq_domain) {
 		dev_err(dev, "failed to create IRQ domain\n");
diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index 0b534f7..e36aa87 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -461,9 +461,8 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie *pcie)
 		return -ENODEV;
 	}
 
-	pcie->leg_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-						 &intx_domain_ops,
-						 pcie);
+	pcie->leg_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node), PCI_NUM_INTX,
+						    &intx_domain_ops, pcie);
 	of_node_put(pcie_intc_node);
 	if (!pcie->leg_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index 4c7a9fa..3abedf7 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -155,8 +155,7 @@ static int plda_allocate_msi_domains(struct plda_pcie_rp *port)
 
 	mutex_init(&port->msi.lock);
 
-	msi->dev_domain = irq_domain_add_linear(NULL, msi->num_vectors,
-						&msi_domain_ops, port);
+	msi->dev_domain = irq_domain_create_linear(NULL, msi->num_vectors, &msi_domain_ops, port);
 	if (!msi->dev_domain) {
 		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
@@ -393,10 +392,9 @@ static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
 		return -EINVAL;
 	}
 
-	port->event_domain = irq_domain_add_linear(pcie_intc_node,
-						   port->num_events,
-						   &plda_event_domain_ops,
-						   port);
+	port->event_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node),
+						      port->num_events, &plda_event_domain_ops,
+						      port);
 	if (!port->event_domain) {
 		dev_err(dev, "failed to get event domain\n");
 		of_node_put(pcie_intc_node);
@@ -405,8 +403,8 @@ static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
 
 	irq_domain_update_bus_token(port->event_domain, DOMAIN_BUS_NEXUS);
 
-	port->intx_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-						  &intx_domain_ops, port);
+	port->intx_domain = irq_domain_create_linear(of_fwnode_handle(pcie_intc_node), PCI_NUM_INTX,
+						     &intx_domain_ops, port);
 	if (!port->intx_domain) {
 		dev_err(dev, "failed to get an INTx IRQ domain\n");
 		of_node_put(pcie_intc_node);

