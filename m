Return-Path: <linux-tip-commits+bounces-5987-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F1CAF767A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 16:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4781C86F6D
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 14:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9082E7F2E;
	Thu,  3 Jul 2025 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r3fYM+DD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lrr60MU8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475B91A83F5;
	Thu,  3 Jul 2025 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551234; cv=none; b=uEPQE3NGFN20j1p/WGr647NLAEgTL5TnzRqjYbn371ySoF2keHG3No/2R8XH6v3llxQA0cAk0FYF7YI202KvmwLXA1nRhqKlxhMbRc8gqUJy/Rz69G/cQhYcMdcLCdZmgo5MEh6LB56J7KPZm7PimiEVy55cg/+5f36+PkMhPzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551234; c=relaxed/simple;
	bh=iZVwzuQO3C+wZvRnVw0h5nSdYG6woj7dQtsUgZ3jVrw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Gd4dI6vgNTMle4niP5s7OfdNBoqhnywp2An1edegLh6N8xAEXjMmRFmD3hkkljNEsWD/+Kda6X8Lt+UCxdCIf6TDIOfGL51Xm+5SK81oDVst7BWIWL56Lnu4ghrfleZjObWEKwvh6Pbd4myeJtwJGLXCs0kJK7MMZgDUsrGqkTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r3fYM+DD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lrr60MU8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Jul 2025 14:00:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751551230;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GIrxSPem+pE27Sj3RqXguiU9Jx1J6cJnacR5GL/JHdo=;
	b=r3fYM+DDkR5ZD92uvMoLpiJsXg84S6XD+4orKfmT25O6PHLaM7JqdRdhOiHJoGeirRbI+t
	g7d3kKvwh/x21TM28rMvWCcURj+NK9VFXuE8wBj5KmRLqUFnL0b5Vg5BiifQ5XXM9U7LD8
	f/YTdvGS2EV4BRFJYOPOpbltgtHyiy1IV4/5C8Z6y91obot75xQORW4znkGNrMNV6jUbF0
	hZx/goCb3KaOaRQHP997Shkr7NrENUTaXS3hoydYJxhbeDm9Y7N81TljV2ZfDAN4ypsb0/
	WtCxtht7InxIZmiRJw3VOTPhM1bC9tHyLfBeeWW3eEEvyc0VRqBcqkE8YwAzUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751551230;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GIrxSPem+pE27Sj3RqXguiU9Jx1J6cJnacR5GL/JHdo=;
	b=lrr60MU8sFqFLFd4nrJniiUAMqRwkR426roqiWRhE5TV3UWKaJSnXWhYhKX+8TNLilp4+h
	8RH3qhXRBs6m1mBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/alpine-msi: Switch to
 msi_create_parent_irq_domain()
Cc: Thomas Gleixner <tglx@linutronix.de>, Nam Cao <namcao@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cec08fea004e7c3aa18c3f5657a8cafeb1adfcc1d=2E17508?=
 =?utf-8?q?60131=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cec08fea004e7c3aa18c3f5657a8cafeb1adfcc1d=2E175086?=
 =?utf-8?q?0131=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175155122930.406.11031483678792894687.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     7a91ad7ebd618d89c0966f19fe453701b1e17494
Gitweb:        https://git.kernel.org/tip/7a91ad7ebd618d89c0966f19fe453701b1e17494
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 26 Jun 2025 16:49:07 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 03 Jul 2025 15:49:25 +02:00

irqchip/alpine-msi: Switch to msi_create_parent_irq_domain()

Move away from the legacy MSI domain setup, switch to use
msi_create_parent_irq_domain().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/ec08fea004e7c3aa18c3f5657a8cafeb1adfcc1d.1750860131.git.namcao@linutronix.de

---
 drivers/irqchip/Kconfig          |  1 +-
 drivers/irqchip/irq-alpine-msi.c | 69 ++++++++++++-------------------
 2 files changed, 28 insertions(+), 42 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 39f6f42..d596155 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -85,6 +85,7 @@ config ALPINE_MSI
 	bool
 	depends on PCI
 	select PCI_MSI
+	select IRQ_MSI_LIB
 	select GENERIC_IRQ_CHIP
 
 config AL_FIC
diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
index 43d6db2..159d9ec 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -14,6 +14,7 @@
 
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -36,26 +37,6 @@ struct alpine_msix_data {
 	unsigned long	*msi_map;
 };
 
-static void alpine_msix_mask_msi_irq(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void alpine_msix_unmask_msi_irq(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
-
-static struct irq_chip alpine_msix_irq_chip = {
-	.name			= "MSIx",
-	.irq_mask		= alpine_msix_mask_msi_irq,
-	.irq_unmask		= alpine_msix_unmask_msi_irq,
-	.irq_eoi		= irq_chip_eoi_parent,
-	.irq_set_affinity	= irq_chip_set_affinity_parent,
-};
-
 static int alpine_msix_allocate_sgi(struct alpine_msix_data *priv, int num_req)
 {
 	int first;
@@ -88,12 +69,6 @@ static void alpine_msix_compose_msi_msg(struct irq_data *data, struct msi_msg *m
 	msg->data = 0;
 }
 
-static struct msi_domain_info alpine_msix_domain_info = {
-	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_PCI_MSIX,
-	.chip	= &alpine_msix_irq_chip,
-};
-
 static struct irq_chip middle_irq_chip = {
 	.name			= "alpine_msix_middle",
 	.irq_mask		= irq_chip_mask_parent,
@@ -164,13 +139,35 @@ static void alpine_msix_middle_domain_free(struct irq_domain *domain, unsigned i
 }
 
 static const struct irq_domain_ops alpine_msix_middle_domain_ops = {
+	.select	= msi_lib_irq_domain_select,
 	.alloc	= alpine_msix_middle_domain_alloc,
 	.free	= alpine_msix_middle_domain_free,
 };
 
+#define ALPINE_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |		\
+				    MSI_FLAG_USE_DEF_CHIP_OPS |		\
+				    MSI_FLAG_PCI_MSI_MASK_PARENT)
+
+#define ALPINE_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |		\
+				    MSI_FLAG_PCI_MSIX)
+
+static struct msi_parent_ops alpine_msi_parent_ops = {
+	.supported_flags	= ALPINE_MSI_FLAGS_SUPPORTED,
+	.required_flags		= ALPINE_MSI_FLAGS_REQUIRED,
+	.chip_flags		= MSI_CHIP_FLAG_SET_EOI,
+	.bus_select_token	= DOMAIN_BUS_NEXUS,
+	.bus_select_mask	= MATCH_PCI_MSI,
+	.prefix			= "ALPINE-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+};
+
 static int alpine_msix_init_domains(struct alpine_msix_data *priv, struct device_node *node)
 {
-	struct irq_domain *middle_domain, *msi_domain, *gic_domain;
+	struct irq_domain_info info = {
+		.fwnode		= of_fwnode_handle(node),
+		.ops		= &alpine_msix_middle_domain_ops,
+		.host_data	= priv,
+	};
 	struct device_node *gic_node;
 
 	gic_node = of_irq_find_parent(node);
@@ -179,29 +176,17 @@ static int alpine_msix_init_domains(struct alpine_msix_data *priv, struct device
 		return -ENODEV;
 	}
 
-	gic_domain = irq_find_host(gic_node);
+	info.parent = irq_find_host(gic_node);
 	of_node_put(gic_node);
-	if (!gic_domain) {
+	if (!info.parent) {
 		pr_err("Failed to find the GIC domain\n");
 		return -ENXIO;
 	}
 
-	middle_domain = irq_domain_create_hierarchy(gic_domain, 0, 0, NULL,
-						    &alpine_msix_middle_domain_ops, priv);
-	if (!middle_domain) {
-		pr_err("Failed to create the MSIX middle domain\n");
-		return -ENOMEM;
-	}
-
-	msi_domain = pci_msi_create_irq_domain(of_fwnode_handle(node),
-					       &alpine_msix_domain_info,
-					       middle_domain);
-	if (!msi_domain) {
+	if (!msi_create_parent_irq_domain(&info, &alpine_msi_parent_ops)) {
 		pr_err("Failed to create MSI domain\n");
-		irq_domain_remove(middle_domain);
 		return -ENOMEM;
 	}
-
 	return 0;
 }
 

