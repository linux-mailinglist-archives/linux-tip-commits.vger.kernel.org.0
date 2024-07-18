Return-Path: <linux-tip-commits+bounces-1712-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB4C9351B0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 20:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8D5328399D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 18:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEF1145FF8;
	Thu, 18 Jul 2024 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cwCT7v4X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p+pfqR40"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD41145A16;
	Thu, 18 Jul 2024 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327944; cv=none; b=eJ2cBoFRV5UUaporh8GuwHL0O14a1AZi/Ob7ioo7D1zVQG1vrSaZaU0zzaJYbtH3OiBVunGqtV1oh3toZLUc0vsceA9xrpHtnPCm6GeZzdp4+pQgF815WpYuivLnk6737kyAoidBDG6HrHpGdSxwCq/aOrY8SycDDA6IL57bumA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327944; c=relaxed/simple;
	bh=vO4pTeU403Q+E0zrfa7TR+CdWZs1n0/gJ4iTvzOLsLo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c1Ka+KUPXj0/bPnfdS8LZ+Z0gQXcfLGX5fFlMvOIVIFxHZS7Ve9xKiv5M25ZilBApd12b3N6I4jC5W5086cds/orTVvP6pGTVrBLMtQ9g4Ee38216cbopMBgNU7z9ACmVsZo+P/520EpWs5paAtrrZhuV9gmiDSA6350x5J4f5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cwCT7v4X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p+pfqR40; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jul 2024 18:38:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721327939;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUrbwt5upc0cSBWCZmhs2zMgiQ76VCaIAymZSvT5dj4=;
	b=cwCT7v4Xbwx9AD0SwcdIDN5z3hPBMbJFgk2m/ueyeUdTHb0y1L6rVf3sV+2dDu1nih5Ygg
	M21dJQfPCuRm/wOy19xUM+ThNqGB6S1Px0OzY48bx+jRiExvKPzA/ED4HnCSdR3Pwfa9Q2
	LvIU1OcviyXf7THiQCQuX+Rhms1Vrxq22gKsP/xOWgffOAllnP0tqSj4ksvYEL5v0/sczW
	hhkB+mSeEU7s4PkWzmttwvCPueBhThcD5zxD1XPRw8c4rn3Ai61YWAKYoSJqB5fb2hV6UZ
	YVldw0KjZd+3uHdz4Ka++29iUxSJ4C8e84da6HF8H/lglQ3+LUEUXQxXmE/iRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721327939;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUrbwt5upc0cSBWCZmhs2zMgiQ76VCaIAymZSvT5dj4=;
	b=p+pfqR40aSX4Lwn9XcoyhYxJT+IBaE8h7041/WL4UpYj2Iu81LbGGQQ7CJSETzsYhN+DCc
	F3agiyf3xZ9HTDCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/mvebu-gicp: Switch to MSI parent
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240623142235.699780279@linutronix.de>
References: <20240623142235.699780279@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172132793897.2215.7969180050732894243.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     cdb238723018eb766040d7be5d879b4c81ad3d50
Gitweb:        https://git.kernel.org/tip/cdb238723018eb766040d7be5d879b4c81ad3d50
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:18:58 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jul 2024 20:31:20 +02:00

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
index e7a57b3..a0fa599 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -371,6 +371,7 @@ config MSCC_OCELOT_IRQ
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
 

