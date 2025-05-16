Return-Path: <linux-tip-commits+bounces-5629-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8812FABA441
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BACAA7A20C0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFEE27A935;
	Fri, 16 May 2025 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s8QCsdcu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2XRYW4Ao"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF5D225787;
	Fri, 16 May 2025 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424829; cv=none; b=jx0xi9ILhMuw+LZgZCwpcT+2WrGEGXsU4DQ5nudvVLhEmJu1jpV3JzkwBmtqrsTEoEUUTu6FjdUz7sTAn02J9Fcvh3scw7dbHTtNfo9dL6/S4nR8mLJiOXxHGQBelg/CBozBi8D40HSYCbYZJayca6txoKqjzfSTFbdee8ayryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424829; c=relaxed/simple;
	bh=NmcPA58Z0Wmk80BoU52BQrjV8K1ecKlvNGjSyfTX0sg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ffyCGGcTodqtM3dnMDsPhhyWBZbEJ/n/boYydfZorpxq/Q2KMlsiyDPsuZaltF/x8o26wA3c/FSxcxd0+HgwEOpY09U/YZ+o9ExqmAskAKsV8c4iFkxx8tHoBYzSa6pvZCacLQSimxlX6MYFnkaJrjpds/Ma9POaLCtmqr0MRhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s8QCsdcu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2XRYW4Ao; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:47:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424826;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FX7KenXNCGb4+rHp2sJNNx8oPtnzxKarimgf8B+xjII=;
	b=s8QCsdcu0LoIDuHaZWscv5bbvY84v1I5D75Td9wZ/+Y189Bt4uZbdxRyVAuD1OXRUheSQP
	H2s4CuFfpk+rhW84ltIwbi90G1s2mDskpgHasSWInhiqos2KrAbzETAew9E2d4s20DbvFY
	EPDkbrGTR9pEAU2kXIXndGGLEq3qdeddXJ9F5gFoMHLtdyXb4nO/UlC4fRdOBu1qcy7rf5
	ZbK42zR/mZS4vGsW/A2vNTbnr7r5tqynRyv6Co3gCzTrA/IZsMvd3iwkUe9sfDucdJsy91
	GnoK1hGufVoz0c4vTOFEJl+hBdVNIn0rTdeZRTZBuZn75ZV1YYnFpWZ9pqUdqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424826;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FX7KenXNCGb4+rHp2sJNNx8oPtnzxKarimgf8B+xjII=;
	b=2XRYW4AoN9fbCYB4AkShoZpydUPVrpHou8/vb89+oCZwq1Bvvc6zSo/P4nL3dG/M4FgtuE
	7nh6Q0GIt/Qlr6AA==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI: xgene: Convert to MSI parent infrastructure
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250513172819.2216709-9-maz@kernel.org>
References: <20250513172819.2216709-9-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742482522.406.3140173637801608960.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     ae79351ef280805e0881fd2011b74ed008a4e151
Gitweb:        https://git.kernel.org/tip/ae79351ef280805e0881fd2011b74ed008a4e151
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 13 May 2025 18:28:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:32:20 +02:00

PCI: xgene: Convert to MSI parent infrastructure

In an effort to move ARM64 away from the legacy MSI setup, convert the
XGENE PCIe driver to the MSI-parent infrastructure and let each device have
its own MSI domain.

[ tglx: Moved the struct out of the function call argument ]

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250513172819.2216709-9-maz@kernel.org

---
 drivers/pci/controller/Kconfig         |  1 +-
 drivers/pci/controller/pci-xgene-msi.c | 53 +++++++++----------------
 2 files changed, 21 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 98a62f4..205e0e3 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -304,6 +304,7 @@ config PCI_XGENE_MSI
 	bool "X-Gene v1 PCIe MSI feature"
 	depends on PCI_XGENE
 	depends on PCI_MSI
+	select IRQ_MSI_LIB
 	default y
 	help
 	  Say Y here if you want PCIe MSI support for the APM X-Gene v1 SoC.
diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index 69a9c0a..b05ec8b 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/of_pci.h>
@@ -32,7 +33,6 @@ struct xgene_msi_group {
 struct xgene_msi {
 	struct device_node	*node;
 	struct irq_domain	*inner_domain;
-	struct irq_domain	*msi_domain;
 	u64			msi_addr;
 	void __iomem		*msi_regs;
 	unsigned long		*bitmap;
@@ -44,20 +44,6 @@ struct xgene_msi {
 /* Global data */
 static struct xgene_msi xgene_msi_ctrl;
 
-static struct irq_chip xgene_msi_top_irq_chip = {
-	.name		= "X-Gene1 MSI",
-	.irq_enable	= pci_msi_unmask_irq,
-	.irq_disable	= pci_msi_mask_irq,
-	.irq_mask	= pci_msi_mask_irq,
-	.irq_unmask	= pci_msi_unmask_irq,
-};
-
-static struct  msi_domain_info xgene_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_PCI_MSIX),
-	.chip	= &xgene_msi_top_irq_chip,
-};
-
 /*
  * X-Gene v1 has 16 groups of MSI termination registers MSInIRx, where
  * n is group number (0..F), x is index of registers in each group (0..7)
@@ -235,34 +221,35 @@ static void xgene_irq_domain_free(struct irq_domain *domain,
 	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
 }
 
-static const struct irq_domain_ops msi_domain_ops = {
+static const struct irq_domain_ops xgene_msi_domain_ops = {
 	.alloc  = xgene_irq_domain_alloc,
 	.free   = xgene_irq_domain_free,
 };
 
+static const struct msi_parent_ops xgene_msi_parent_ops = {
+	.supported_flags	= (MSI_GENERIC_FLAGS_MASK	|
+				   MSI_FLAG_PCI_MSIX),
+	.required_flags		= (MSI_FLAG_USE_DEF_DOM_OPS	|
+				   MSI_FLAG_USE_DEF_CHIP_OPS),
+	.bus_select_token	= DOMAIN_BUS_PCI_MSI,
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+};
+
 static int xgene_allocate_domains(struct xgene_msi *msi)
 {
-	msi->inner_domain = irq_domain_add_linear(NULL, NR_MSI_VEC,
-						  &msi_domain_ops, msi);
-	if (!msi->inner_domain)
-		return -ENOMEM;
-
-	msi->msi_domain = pci_msi_create_irq_domain(of_fwnode_handle(msi->node),
-						    &xgene_msi_domain_info,
-						    msi->inner_domain);
-
-	if (!msi->msi_domain) {
-		irq_domain_remove(msi->inner_domain);
-		return -ENOMEM;
-	}
-
-	return 0;
+	struct irq_domain_info info = {
+		.fwnode		= of_fwnode_handle(msi->node),
+		.ops		= &xgene_msi_domain_ops,
+		.size		= NR_MSI_VEC,
+		.host_data	= msi,
+	};
+
+	msi->inner_domain = msi_create_parent_irq_domain(&info, &xgene_msi_parent_ops);
+	return msi->inner_domain ? 0 : -ENOMEM;
 }
 
 static void xgene_free_domains(struct xgene_msi *msi)
 {
-	if (msi->msi_domain)
-		irq_domain_remove(msi->msi_domain);
 	if (msi->inner_domain)
 		irq_domain_remove(msi->inner_domain);
 }

