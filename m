Return-Path: <linux-tip-commits+bounces-2085-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C42958B07
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Aug 2024 17:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC6E1F21F4C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Aug 2024 15:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FD2192B79;
	Tue, 20 Aug 2024 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AECDuD2p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KFdAD2p5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3214B1917F6;
	Tue, 20 Aug 2024 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167270; cv=none; b=AkCpxsU1RKN64dRijRrQaIPNuEtdIFn8q6jke9snVjkrah22mTfA0MxuaKSaGGvpJP20NyXSuCi0ZoQ1s9vGrF7ThI0iXNbpW7S2YWYtaA/2iw8g4NYaxiJygXvArWgxd7YBla4oQR+ndMSalE+71QF+CDhNB3a/LbBdOBLtPPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167270; c=relaxed/simple;
	bh=ZC8LglUF22d0t+gg0h4J3muyK5mpqlHaOLgiOilaktU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Omdnnd7KfLdPFbATAn+ufbF61Atf74JU734D01xzPDKnyPfDdAtj7M1JyJ9wRSozj31are5TIFNRJM2FdQa8KHpz28CMKCuxQ83cho3zxzZ3J+NFucWeFFSj2V07Ffx0FWXFI0NzXIMjxFmvnOKVvT16I//Y++6jmcSt+Ml1Jyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AECDuD2p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KFdAD2p5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Aug 2024 15:21:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724167267;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2JNA+T89mr8WpHmuBTiS76SmFocuHw/obUPtZWCtBqI=;
	b=AECDuD2p2Y8fc6CzM+5aip7wYdYm0+BD+V55DFQhmFJLX6CtM9GlXbcSSd9kEd+v+2+06w
	tplfKZQ/+zxmjeRo/9yzf/rmnkik9S4YcIWS48EM1gcl77WwgYWcgYThiv3FXlyMg9GQQ3
	F9dLHuQHH0XFZ2IQUziQSS9t70mxDr3paATyUcycn7f5jQY/nxrYYgp51nXdi4zESau6yN
	ZjWPKcBh0CrsCS8Kp15iKNTiFS3WWmcTex6469zqioc7Y2rS1D2MjGfilXwZ2A+fja3d6p
	1TUur5TD8UGCfNhWo7GM4PzthyG7teMxqhprXKSvTaWFYUuSyctYOslDOScM4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724167267;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2JNA+T89mr8WpHmuBTiS76SmFocuHw/obUPtZWCtBqI=;
	b=KFdAD2p59f7FIGJdDfiBvCQF10xiPT/BfhntDfrNajmvi03E6Jn1h5dcILOy2N3F1O3GSg
	NRejtUpGT2eHZMBg==
From: "tip-bot2 for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/loongson-pch-msi: Switch to MSI parent domains
Cc: Huacai Chen <chenhuacai@loongson.cn>,
 Tianyang Zhang <zhangtianyang@loongson.cn>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240815112608.26925-2-zhangtianyang@loongson.cn>
References: <20240815112608.26925-2-zhangtianyang@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172416726694.2215.4928016513951991531.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0b3af7591dbfd16ca45740cd90eb34be8b9a7175
Gitweb:        https://git.kernel.org/tip/0b3af7591dbfd16ca45740cd90eb34be8b9a7175
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Thu, 15 Aug 2024 19:26:07 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Aug 2024 17:13:40 +02:00

irqchip/loongson-pch-msi: Switch to MSI parent domains

Remove the global PCI/MSI irqdomain implementation and provide the
required MSI parent functionality by filling in msi_parent_ops, so the
PCI/MSI code can detect the new parent and setup per-device MSI domains.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240815112608.26925-2-zhangtianyang@loongson.cn

---
 drivers/irqchip/Kconfig                |  1 +-
 drivers/irqchip/irq-loongson-pch-msi.c | 58 +++++++++----------------
 2 files changed, 24 insertions(+), 35 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index d078bdc..341cd9c 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -685,6 +685,7 @@ config LOONGSON_PCH_MSI
 	depends on PCI
 	default MACH_LOONGSON64
 	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_MSI_LIB
 	select PCI_MSI
 	help
 	  Support for the Loongson PCH MSI Controller.
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index dd4d699..2242f63 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -15,6 +15,8 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 
+#include "irq-msi-lib.h"
+
 static int nr_pics;
 
 struct pch_msi_data {
@@ -27,26 +29,6 @@ struct pch_msi_data {
 
 static struct fwnode_handle *pch_msi_handle[MAX_IO_PICS];
 
-static void pch_msi_mask_msi_irq(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void pch_msi_unmask_msi_irq(struct irq_data *d)
-{
-	irq_chip_unmask_parent(d);
-	pci_msi_unmask_irq(d);
-}
-
-static struct irq_chip pch_msi_irq_chip = {
-	.name			= "PCH PCI MSI",
-	.irq_mask		= pch_msi_mask_msi_irq,
-	.irq_unmask		= pch_msi_unmask_msi_irq,
-	.irq_ack		= irq_chip_ack_parent,
-	.irq_set_affinity	= irq_chip_set_affinity_parent,
-};
-
 static int pch_msi_allocate_hwirq(struct pch_msi_data *priv, int num_req)
 {
 	int first;
@@ -85,12 +67,6 @@ static void pch_msi_compose_msi_msg(struct irq_data *data,
 	msg->data = data->hwirq;
 }
 
-static struct msi_domain_info pch_msi_domain_info = {
-	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
-	.chip	= &pch_msi_irq_chip,
-};
-
 static struct irq_chip middle_irq_chip = {
 	.name			= "PCH MSI",
 	.irq_mask		= irq_chip_mask_parent,
@@ -155,13 +131,31 @@ static void pch_msi_middle_domain_free(struct irq_domain *domain,
 static const struct irq_domain_ops pch_msi_middle_domain_ops = {
 	.alloc	= pch_msi_middle_domain_alloc,
 	.free	= pch_msi_middle_domain_free,
+	.select	= msi_lib_irq_domain_select,
+};
+
+#define PCH_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				 MSI_FLAG_USE_DEF_CHIP_OPS |	\
+				 MSI_FLAG_PCI_MSI_MASK_PARENT)
+
+#define PCH_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				 MSI_FLAG_PCI_MSIX      |	\
+				 MSI_FLAG_MULTI_PCI_MSI)
+
+static struct msi_parent_ops pch_msi_parent_ops = {
+	.required_flags		= PCH_MSI_FLAGS_REQUIRED,
+	.supported_flags	= PCH_MSI_FLAGS_SUPPORTED,
+	.bus_select_mask	= MATCH_PCI_MSI,
+	.bus_select_token	= DOMAIN_BUS_NEXUS,
+	.prefix			= "PCH-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
 };
 
 static int pch_msi_init_domains(struct pch_msi_data *priv,
 				struct irq_domain *parent,
 				struct fwnode_handle *domain_handle)
 {
-	struct irq_domain *middle_domain, *msi_domain;
+	struct irq_domain *middle_domain;
 
 	middle_domain = irq_domain_create_hierarchy(parent, 0, priv->num_irqs,
 						    domain_handle,
@@ -174,14 +168,8 @@ static int pch_msi_init_domains(struct pch_msi_data *priv,
 
 	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
 
-	msi_domain = pci_msi_create_irq_domain(domain_handle,
-					       &pch_msi_domain_info,
-					       middle_domain);
-	if (!msi_domain) {
-		pr_err("Failed to create PCI MSI domain\n");
-		irq_domain_remove(middle_domain);
-		return -ENOMEM;
-	}
+	middle_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	middle_domain->msi_parent_ops = &pch_msi_parent_ops;
 
 	return 0;
 }

