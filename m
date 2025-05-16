Return-Path: <linux-tip-commits+bounces-5632-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81294ABA449
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4543A669C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC30280031;
	Fri, 16 May 2025 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="viY4DeOU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AVPO6IPw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F1027FB23;
	Fri, 16 May 2025 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424832; cv=none; b=UxyEZQojKHebl/Wc/WOnQhv6QCYsQx20mBji2jmQE/8q/3OnIw+WBT3AbBCOPUWP7EjTjlucBrfG8dN5wR8FxF1VNgCnri/8QD9YJfo1vnBZAJPVFNM6Uhn09rFj1SaTf8TTtlrj4wW4rms9mxLd02IZc1LnY7OWG0zxGS9MyTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424832; c=relaxed/simple;
	bh=eue7/WbGOGnKgqHwnga3j0sBMIQcZMNfORSudKQNc88=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EYnlNLtAXGh4AaOVfrvr0q/MKklNtgTEVZrWYQejVerbQk+bj1gcRZp5nIwvoC9v4hkUTqLh9EwaglLHcVAjb8RsPypysDHSwD+FhjIjpeNFiaXX3+S+3Q1Lh1jU+G/jvSLy4AUvtW1z7sjnhLuJ75ok42/CmmVJBs4KHh/XYds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=viY4DeOU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AVPO6IPw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:47:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424828;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5f+HJTv2UsAnK25BjemKCD4arwHGDr25qSG5gcTuBY=;
	b=viY4DeOUJsXiHR0T1sDvTeOPykAlf2lO5hYkjeH6DzMsiqelJdgcyqLjhb4z+gi1AZNdKa
	bflb4BANKHBjZ1pi1+kM3fbUuEkoIi8fwYewI7Z5quiYifVnpo2WgdbfxpZnYFPjxzLfxJ
	KmnUGYd/A91iwnDmIGn9PHCuHmykFZlY3k9uWd5giMRDgO22pKvnhTpM9risvicCsY6xnc
	iFLWa1WGzpG8JylrnXKd6ZYLlqJPGzcue3o3bMfI9KMa2oy48uCVJZDpL1lwMab8kmL+0P
	AuwurtKNKtRMS51wsuW3oTHXqqaSbjgFtXkbo3Xte/3baWcIvp9iiSYLX5aFkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424828;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5f+HJTv2UsAnK25BjemKCD4arwHGDr25qSG5gcTuBY=;
	b=AVPO6IPwau1NpmECKkhF4AkaLhDIxzf5Lis2E8oLLDPVoOK8DsAU5+EcuVaNgaSgJR7K9C
	CMve9PXDbkUVuXDQ==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/mvebu: Convert to
 msi_create_parent_irq_domain() helper
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250513172819.2216709-5-maz@kernel.org>
References: <20250513172819.2216709-5-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742482773.406.8568105586600920316.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     b35961ce0a979fa9c2b0d30a346d3a74ef670aa6
Gitweb:        https://git.kernel.org/tip/b35961ce0a979fa9c2b0d30a346d3a74ef670aa6
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 13 May 2025 18:28:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:32:20 +02:00

irqchip/mvebu: Convert to msi_create_parent_irq_domain() helper

Switch the MVEBU family of interrupt chip drivers over to the common helper
function to create the interrupt domains.

[ tglx: Moved the struct out of the function call argument and fix up
  	the of_node_to_fwnode() instances ]

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250513172819.2216709-5-maz@kernel.org
---
 drivers/irqchip/irq-mvebu-gicp.c | 24 ++++++++++--------------
 drivers/irqchip/irq-mvebu-odmi.c | 25 +++++++++----------------
 drivers/irqchip/irq-mvebu-sei.c  | 22 +++++++++++-----------
 3 files changed, 30 insertions(+), 41 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gicp.c
index 0b2a857..9cd3c6c 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -170,9 +170,12 @@ static const struct msi_parent_ops gicp_msi_parent_ops = {
 
 static int mvebu_gicp_probe(struct platform_device *pdev)
 {
-	struct irq_domain *inner_domain, *parent_domain;
 	struct device_node *node = pdev->dev.of_node;
 	struct device_node *irq_parent_dn;
+	struct irq_domain_info info = {
+		.fwnode	= of_fwnode_handle(node),
+		.ops	= &gicp_domain_ops,
+	};
 	struct mvebu_gicp *gicp;
 	int ret, i;
 
@@ -217,30 +220,23 @@ static int mvebu_gicp_probe(struct platform_device *pdev)
 	if (!gicp->spi_bitmap)
 		return -ENOMEM;
 
+	info.size = gicp->spi_cnt;
+	info.host_data = gicp;
+
 	irq_parent_dn = of_irq_find_parent(node);
 	if (!irq_parent_dn) {
 		dev_err(&pdev->dev, "failed to find parent IRQ node\n");
 		return -ENODEV;
 	}
 
-	parent_domain = irq_find_host(irq_parent_dn);
+	info.parent = irq_find_host(irq_parent_dn);
 	of_node_put(irq_parent_dn);
-	if (!parent_domain) {
+	if (!info.parent) {
 		dev_err(&pdev->dev, "failed to find parent IRQ domain\n");
 		return -ENODEV;
 	}
 
-	inner_domain = irq_domain_create_hierarchy(parent_domain, 0,
-						   gicp->spi_cnt,
-						   of_node_to_fwnode(node),
-						   &gicp_domain_ops, gicp);
-	if (!inner_domain)
-		return -ENOMEM;
-
-	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_GENERIC_MSI);
-	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	inner_domain->msi_parent_ops = &gicp_msi_parent_ops;
-	return 0;
+	return msi_create_parent_irq_domain(&info, &gicp_msi_parent_ops) ? 0 : -ENOMEM;
 }
 
 static const struct of_device_id mvebu_gicp_of_match[] = {
diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu-odmi.c
index 306a775..46256b9 100644
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -167,7 +167,12 @@ static const struct msi_parent_ops odmi_msi_parent_ops = {
 static int __init mvebu_odmi_init(struct device_node *node,
 				  struct device_node *parent)
 {
-	struct irq_domain *parent_domain, *inner_domain;
+	struct irq_domain_info info = {
+		.fwnode	= of_fwnode_handle(node),
+		.ops	= &odmi_domain_ops,
+		.size	= odmis_count * NODMIS_PER_FRAME,
+		.parent	= irq_find_host(parent),
+	};
 	int ret, i;
 
 	if (of_property_read_u32(node, "marvell,odmi-frames", &odmis_count))
@@ -203,22 +208,10 @@ static int __init mvebu_odmi_init(struct device_node *node,
 		}
 	}
 
-	parent_domain = irq_find_host(parent);
+	if (msi_create_parent_irq_domain(&info, &odmi_msi_parent_ops))
+		return 0;
 
-	inner_domain = irq_domain_create_hierarchy(parent_domain, 0,
-						   odmis_count * NODMIS_PER_FRAME,
-						   of_node_to_fwnode(node),
-						   &odmi_domain_ops, NULL);
-	if (!inner_domain) {
-		ret = -ENOMEM;
-		goto err_unmap;
-	}
-
-	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_GENERIC_MSI);
-	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	inner_domain->msi_parent_ops = &odmi_msi_parent_ops;
-
-	return 0;
+	ret = -ENOMEM;
 
 err_unmap:
 	for (i = 0; i < odmis_count; i++) {
diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index a962ef4..5822ea8 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -366,6 +366,10 @@ static const struct msi_parent_ops sei_msi_parent_ops = {
 static int mvebu_sei_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
+	struct irq_domain_info info = {
+		.fwnode	= of_fwnode_handle(node),
+		.ops	= &mvebu_sei_cp_domain_ops,
+	};
 	struct mvebu_sei *sei;
 	u32 parent_irq;
 	int ret;
@@ -402,7 +406,7 @@ static int mvebu_sei_probe(struct platform_device *pdev)
 	}
 
 	/* Create the root SEI domain */
-	sei->sei_domain = irq_domain_create_linear(of_node_to_fwnode(node),
+	sei->sei_domain = irq_domain_create_linear(of_fwnode_handle(node),
 						   (sei->caps->ap_range.size +
 						    sei->caps->cp_range.size),
 						   &mvebu_sei_domain_ops,
@@ -418,7 +422,7 @@ static int mvebu_sei_probe(struct platform_device *pdev)
 	/* Create the 'wired' domain */
 	sei->ap_domain = irq_domain_create_hierarchy(sei->sei_domain, 0,
 						     sei->caps->ap_range.size,
-						     of_node_to_fwnode(node),
+						     of_fwnode_handle(node),
 						     &mvebu_sei_ap_domain_ops,
 						     sei);
 	if (!sei->ap_domain) {
@@ -430,21 +434,17 @@ static int mvebu_sei_probe(struct platform_device *pdev)
 	irq_domain_update_bus_token(sei->ap_domain, DOMAIN_BUS_WIRED);
 
 	/* Create the 'MSI' domain */
-	sei->cp_domain = irq_domain_create_hierarchy(sei->sei_domain, 0,
-						     sei->caps->cp_range.size,
-						     of_node_to_fwnode(node),
-						     &mvebu_sei_cp_domain_ops,
-						     sei);
+	info.size = sei->caps->cp_range.size;
+	info.host_data = sei;
+	info.parent = sei->sei_domain;
+
+	sei->cp_domain = msi_create_parent_irq_domain(&info, &sei_msi_parent_ops);
 	if (!sei->cp_domain) {
 		pr_err("Failed to create CPs IRQ domain\n");
 		ret = -ENOMEM;
 		goto remove_ap_domain;
 	}
 
-	irq_domain_update_bus_token(sei->cp_domain, DOMAIN_BUS_GENERIC_MSI);
-	sei->cp_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	sei->cp_domain->msi_parent_ops = &sei_msi_parent_ops;
-
 	mvebu_sei_reset(sei);
 
 	irq_set_chained_handler_and_data(parent_irq, mvebu_sei_handle_cascade_irq, sei);

