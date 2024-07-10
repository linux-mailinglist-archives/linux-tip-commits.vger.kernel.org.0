Return-Path: <linux-tip-commits+bounces-1655-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D806192D65D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 18:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7791F23A6A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 16:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F49198E6D;
	Wed, 10 Jul 2024 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4BIHzmsC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VKSz1eb6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EBA19885F;
	Wed, 10 Jul 2024 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628754; cv=none; b=jpamBc+5wXyuN+W5HF3ppuKUc9anqPJ9+tulD0mhZqdW5WR7P4lC9fY44ChaMMi5ZVUOM6GYTIu3TAJQGocK6CBF4pTlyk2BMSvsaNoJdc+LQFkjIgNXmMO6DGIu2GDOPpp4vSG5VuS6rFQbkqqME+IRDNo5oDcqjYe/rPRjxO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628754; c=relaxed/simple;
	bh=AKwHPRo5ZrNoi152PQFJh80X77mlvpPYCY1sxXRKLAA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WUOu0X1yrvtJ52+srI0Jq+1FKRAVhKdq0aCMdkZVFWj4tOHlmtq3yUMD5FFsobDizjm42Gdmusd4OgSN9kEMCMihFhrYoZTczx51XcyDzIJy7UNGcBJYrtMF5XMLfSE48al51s9/i00C2FgOfjEFPE1bxCS3m2689Zy7CKhbPA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4BIHzmsC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VKSz1eb6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jul 2024 16:25:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720628749;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=855roucfBrGAK8TYHDkLXxjZI2wdLIKg5xtitodhEQQ=;
	b=4BIHzmsCIxWEa96p7r6UCRlojA6h0PlyMXGn3Y5aN9KveMrnKOx4XqHj6L8J8+svP7L1Jc
	ToH6bR7+SeJCKNEx4D/6U12ndAIebbfhVh/rCyd4OScU2RkgOutceau3JkJyFZjVxbWwR6
	vNuWlFI002sWqVVWBRpSZpjk5ZbVny/nt7SObTAtvC9IKxFSZyJJWPdJbrBBB5wQCvl+jO
	ApFY/mCcpHHH4et1P/nmly0irUyCAE9iEpQZ1lfgGU40skWlEeY3FLwzauFUbMO/YGX+1i
	mezm9BdWoTS2gXBQI2kaDMESWoMorGWw9bDHQ8cXLUgaV+POqX4RI++N28oy4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720628749;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=855roucfBrGAK8TYHDkLXxjZI2wdLIKg5xtitodhEQQ=;
	b=VKSz1eb63EzRuhp1ybmGo0nv+eNlM0VboiD8Bdin3QIUfapJ/81VBFeRzinucOI1Y+fXwA
	4m10wUp+4OKdQIBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/mvebu-gicp: Switch to MSI parent
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240623142235.699780279@linutronix.de>
References: <20240623142235.699780279@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172062874941.2215.17003882059491435714.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     cf8793968627f2699be2fd3de2d217e7de0fabae
Gitweb:        https://git.kernel.org/tip/cf8793968627f2699be2fd3de2d217e7de0fabae
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:18:58 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Jul 2024 18:19:25 +02:00

irqchip/mvebu-gicp: Switch to MSI parent

All platform MSI users and the PCI/MSI code handle per device MSI domains
when the irqdomain associated to the device provides MSI parent
functionality.

Remove the "global" platform domain related code and provide the MSI parent
functionality by filling in msi_parent_ops.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240623142235.699780279@linutronix.de



---
 drivers/irqchip/Kconfig          |  1 +-
 drivers/irqchip/irq-mvebu-gicp.c | 44 +++++++++++++------------------
 2 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 5b93a56..85df667 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -383,6 +383,7 @@ config MSCC_OCELOT_IRQ
 	select GENERIC_IRQ_CHIP
 
 config MVEBU_GICP
+	select IRQ_MSI_LIB
 	bool
 
 config MVEBU_ICU
diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gicp.c
index c43a345..2b61839 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -17,6 +17,8 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
+#include "irq-msi-lib.h"
+
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #define GICP_SETSPI_NSR_OFFSET	0x0
@@ -145,32 +147,32 @@ static void gicp_irq_domain_free(struct irq_domain *domain,
 }
 
 static const struct irq_domain_ops gicp_domain_ops = {
+	.select	= msi_lib_irq_domain_select,
 	.alloc	= gicp_irq_domain_alloc,
 	.free	= gicp_irq_domain_free,
 };
 
-static struct irq_chip gicp_msi_irq_chip = {
-	.name		= "GICP",
-	.irq_set_type	= irq_chip_set_type_parent,
-	.flags		= IRQCHIP_SUPPORTS_LEVEL_MSI,
-};
+#define GICP_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				  MSI_FLAG_USE_DEF_CHIP_OPS)
 
-static struct msi_domain_ops gicp_msi_ops = {
-};
+#define GICP_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				  MSI_FLAG_LEVEL_CAPABLE)
 
-static struct msi_domain_info gicp_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_LEVEL_CAPABLE),
-	.ops	= &gicp_msi_ops,
-	.chip	= &gicp_msi_irq_chip,
+static const struct msi_parent_ops gicp_msi_parent_ops = {
+	.supported_flags	= GICP_MSI_FLAGS_SUPPORTED,
+	.required_flags		= GICP_MSI_FLAGS_REQUIRED,
+	.bus_select_token       = DOMAIN_BUS_GENERIC_MSI,
+	.bus_select_mask	= MATCH_PLATFORM_MSI,
+	.prefix			= "GICP-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
 };
 
 static int mvebu_gicp_probe(struct platform_device *pdev)
 {
-	struct mvebu_gicp *gicp;
-	struct irq_domain *inner_domain, *plat_domain, *parent_domain;
+	struct irq_domain *inner_domain, *parent_domain;
 	struct device_node *node = pdev->dev.of_node;
 	struct device_node *irq_parent_dn;
+	struct mvebu_gicp *gicp;
 	int ret, i;
 
 	gicp = devm_kzalloc(&pdev->dev, sizeof(*gicp), GFP_KERNEL);
@@ -234,17 +236,9 @@ static int mvebu_gicp_probe(struct platform_device *pdev)
 	if (!inner_domain)
 		return -ENOMEM;
 
-
-	plat_domain = platform_msi_create_irq_domain(of_node_to_fwnode(node),
-						     &gicp_msi_domain_info,
-						     inner_domain);
-	if (!plat_domain) {
-		irq_domain_remove(inner_domain);
-		return -ENOMEM;
-	}
-
-	platform_set_drvdata(pdev, gicp);
-
+	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_GENERIC_MSI);
+	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	inner_domain->msi_parent_ops = &gicp_msi_parent_ops;
 	return 0;
 }
 

