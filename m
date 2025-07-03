Return-Path: <linux-tip-commits+bounces-5985-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3347AF7677
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 16:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80AD9543EE9
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 14:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A9E194A67;
	Thu,  3 Jul 2025 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oGHIljja";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DKpMLGIw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849F9136658;
	Thu,  3 Jul 2025 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551232; cv=none; b=XCbJ4lyccol82e6/JWpX3IpSnNZf87CalWGpqfT/sJ6PHRaZ228kjiK8mr5bpnbnY+7OxrHxE5g2lgIf1zB7lkf8YT8hg4FNG5C1XECCTIzYcGFANGvjyLLoi5diXUb8gC0NR6K618hAsif8XbXH/0zfA0eVh7Ipta+gJkJ1z3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551232; c=relaxed/simple;
	bh=NT0DMFhaJ3GrT7e9U4cAeTOod1Em/DdVrOI5BzQMxPU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ua+7UGRYTwtbI5zBEGZYWNOUGG8VckK3PHqX6aShgjeAMgy8hhTbB1cpNtRV3fWYFMi3DocdyCdG6q0UXBt9qtEVE39DP5Hl99vjX795oTqepgDBjO0/vxzC4qEzEVAEya9+MwBqinrGkTA9F2BWGUO5FuRXAudrwVe9x1Ypk20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oGHIljja; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DKpMLGIw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Jul 2025 14:00:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751551228;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Li7+CsEvQOPU1ntuZbXvs+aCpl91tw25/D5DAAzzPw=;
	b=oGHIljjaCvg0WGzuP6DrjbShPl2dycrlMKPF3g1X3sHchbKFGeU0cQzqeOlyvr6q3l0ss1
	3Rede7UpWdVBS+MKIuCIwAkjzf1te1gherqHqoUl9c3fjzlrB2gpUvnUgB847S9r1iepeI
	/GtJXC2it9RMU99h1Ue4T8Fxn0kzEn9q/WsckBK7g5akmRYFi9Gdp7L2TdV9MYEK6fCTKe
	j3CToWA6Z7h1DU5AmiG8Bk8mduJvUq3rEYo6ZkHgUCUwM4UDiMd87aAGNAsjb0XnKYJeg8
	yVIagdzYWp5i3d050Rti72+biUE+gkpwTfeWckKfxqfrbuRkgkGUOf3yHwGmAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751551228;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Li7+CsEvQOPU1ntuZbXvs+aCpl91tw25/D5DAAzzPw=;
	b=DKpMLGIwl4UHFJ2IH5gicKLko90lxT5lwiRQb/nHxWIy03Oho6xnVtVPxYD9OQY73PZVQt
	0IJqkJs/nctYUEAA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/ls-scfg-msi: Switch to use
 msi_create_parent_irq_domain()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C6d23d93fa1f1e65526698f97c9888fa5d12abc7b=2E17508?=
 =?utf-8?q?60131=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C6d23d93fa1f1e65526698f97c9888fa5d12abc7b=2E175086?=
 =?utf-8?q?0131=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175155122708.406.14898136244707392442.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     94b59d5f567a148a3eb25265a4e60f8605ff8423
Gitweb:        https://git.kernel.org/tip/94b59d5f567a148a3eb25265a4e60f8605ff8423
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Thu, 26 Jun 2025 16:49:09 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 03 Jul 2025 15:49:25 +02:00

irqchip/ls-scfg-msi: Switch to use msi_create_parent_irq_domain()

Move away from the legacy MSI domain setup, switch to use
msi_create_parent_irq_domain().

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/6d23d93fa1f1e65526698f97c9888fa5d12abc7b.1750860131.git.namcao@linutronix.de

---
 drivers/irqchip/Kconfig           |  1 +-
 drivers/irqchip/irq-ls-scfg-msi.c | 49 +++++++++++++-----------------
 2 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 0f195ad..ce7f731 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -436,6 +436,7 @@ config LS_SCFG_MSI
 	def_bool y if SOC_LS1021A || ARCH_LAYERSCAPE
 	select IRQ_MSI_IOMMU
 	depends on PCI_MSI
+	select IRQ_MSI_LIB
 
 config PARTITION_PERCPU
 	bool
diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index 84bc5e4..7eca751 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -14,6 +14,7 @@
 #include <linux/iommu.h>
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqdomain.h>
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
@@ -47,7 +48,6 @@ struct ls_scfg_msi {
 	spinlock_t		lock;
 	struct platform_device	*pdev;
 	struct irq_domain	*parent;
-	struct irq_domain	*msi_domain;
 	void __iomem		*regs;
 	phys_addr_t		msiir_addr;
 	struct ls_scfg_msi_cfg	*cfg;
@@ -57,17 +57,18 @@ struct ls_scfg_msi {
 	unsigned long		*used;
 };
 
-static struct irq_chip ls_scfg_msi_irq_chip = {
-	.name = "MSI",
-	.irq_mask	= pci_msi_mask_irq,
-	.irq_unmask	= pci_msi_unmask_irq,
-};
-
-static struct msi_domain_info ls_scfg_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS |
-		   MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_PCI_MSIX),
-	.chip	= &ls_scfg_msi_irq_chip,
+#define MPIC_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS | \
+				 MSI_FLAG_USE_DEF_CHIP_OPS)
+#define MPIC_MSI_FLAGS_SUPPORTED (MSI_FLAG_PCI_MSIX       | \
+				  MSI_GENERIC_FLAGS_MASK)
+
+static const struct msi_parent_ops ls_scfg_msi_parent_ops = {
+	.required_flags		= MPIC_MSI_FLAGS_REQUIRED,
+	.supported_flags	= MPIC_MSI_FLAGS_SUPPORTED,
+	.bus_select_token	= DOMAIN_BUS_NEXUS,
+	.bus_select_mask	= MATCH_PCI_MSI,
+	.prefix			= "MSI-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
 };
 
 static int msi_affinity_flag = 1;
@@ -185,6 +186,7 @@ static void ls_scfg_msi_domain_irq_free(struct irq_domain *domain,
 }
 
 static const struct irq_domain_ops ls_scfg_msi_domain_ops = {
+	.select	= msi_lib_irq_domain_select,
 	.alloc	= ls_scfg_msi_domain_irq_alloc,
 	.free	= ls_scfg_msi_domain_irq_free,
 };
@@ -214,21 +216,15 @@ static void ls_scfg_msi_irq_handler(struct irq_desc *desc)
 
 static int ls_scfg_msi_domains_init(struct ls_scfg_msi *msi_data)
 {
-	/* Initialize MSI domain parent */
-	msi_data->parent = irq_domain_create_linear(NULL,
-						    msi_data->irqs_num,
-						    &ls_scfg_msi_domain_ops,
-						    msi_data);
+	struct irq_domain_info info = {
+		.fwnode		= of_fwnode_handle(msi_data->pdev->dev.of_node),
+		.ops		= &ls_scfg_msi_domain_ops,
+		.host_data	= msi_data,
+		.size		= msi_data->irqs_num,
+	};
+
+	msi_data->parent = msi_create_parent_irq_domain(&info, &ls_scfg_msi_parent_ops);
 	if (!msi_data->parent) {
-		dev_err(&msi_data->pdev->dev, "failed to create IRQ domain\n");
-		return -ENOMEM;
-	}
-
-	msi_data->msi_domain = pci_msi_create_irq_domain(
-				of_fwnode_handle(msi_data->pdev->dev.of_node),
-				&ls_scfg_msi_domain_info,
-				msi_data->parent);
-	if (!msi_data->msi_domain) {
 		dev_err(&msi_data->pdev->dev, "failed to create MSI domain\n");
 		irq_domain_remove(msi_data->parent);
 		return -ENOMEM;
@@ -405,7 +401,6 @@ static void ls_scfg_msi_remove(struct platform_device *pdev)
 	for (i = 0; i < msi_data->msir_num; i++)
 		ls_scfg_msi_teardown_hwirq(&msi_data->msir[i]);
 
-	irq_domain_remove(msi_data->msi_domain);
 	irq_domain_remove(msi_data->parent);
 
 	platform_set_drvdata(pdev, NULL);

