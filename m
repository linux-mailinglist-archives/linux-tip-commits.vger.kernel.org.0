Return-Path: <linux-tip-commits+bounces-5633-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4217AABA448
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54951BC524A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1338728031C;
	Fri, 16 May 2025 19:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C532oESe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CflZgEqT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422BE26F46C;
	Fri, 16 May 2025 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424833; cv=none; b=QsbotfMFevBoDjWBzIefQOXJU5rW3D/FbZ7dk8idqz52CB6N8zJn28+3xv1q7FZnnYPFfjvY1bK84//xf12SJj9hufwSzb1llVLSsXPheAc/z/Ii1I864bfbSugAx+6u+yanbUSpNEJZkwj2hOLRyHxRzSPME33pRy5VYuVIZK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424833; c=relaxed/simple;
	bh=gCm0oToWrn4M7cRz6crivKOpdh8hzqyCOnDoaXXJ1io=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cO4kb00PgsXhSS9CocYI2JOQeRbQsDpacesEbFjuB56MzchdKQOmUM2wKAFsTpTaOU563YJES19qQMAfzraCsmcfC3O3pMKjZTkZS1pGB4u0v7qYmgcG3jFITqOVMK1W+z4PyqQl0QhaEHN8Muw2kePLFeuFG6V/90LeJJ2e2Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C532oESe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CflZgEqT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:47:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424829;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxhT1Egtdz7kknHwcReJ5mCj6lyNc4oeWhoH2o4nSPs=;
	b=C532oESeoHKKw355JVyaQ5iJiI6t49Mj7Wovyalks9nj3RMmQURZ90kKfmmHFq0ipeyMPa
	VV0WyyfSLtvqgpndzU3qjryTaGEoMMv5Pjbp/eF9gDFneJxJ8PXOPzNy5RMQa7dxMuhSdD
	FFxUQUBmZdypPqPPwS00m+7u7c4w0KgSPY2KqFVt/+HP6CK9GKvq6dV5HxDfuaRniVAGE7
	GgPtcBasjAOGD/tmKf6NDZAlv80CnYH8867/RmwPlgfTXuWeziggThEGV23PsADX561T9k
	jsxWffUPReCdpWvzi6GFl01vb1/UL5EXXkztB1HEZZrhIoyDn3DRfdnKHs9JJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424829;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxhT1Egtdz7kknHwcReJ5mCj6lyNc4oeWhoH2o4nSPs=;
	b=CflZgEqT1Yjwgs3ZkP8d+98riEthqCSHZn8n+BJxkEo2Z9WOvN5arrHQ9PTM3mnBhMDJ8E
	HJuVktafEFuWdEBg==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/msi] irqchip/gic: Convert to msi_create_parent_irq_domain() helper
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250513172819.2216709-4-maz@kernel.org>
References: <20250513172819.2216709-4-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742482858.406.13074364312909397450.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     c6b77822347afc17623120dbc4d10c6658304622
Gitweb:        https://git.kernel.org/tip/c6b77822347afc17623120dbc4d10c6658304622
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 13 May 2025 18:28:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:32:20 +02:00

irqchip/gic: Convert to msi_create_parent_irq_domain() helper

Switch the GIC family of interrupt chip drivers over to the common helper
function to create the interrupt domains.

[ tglx: Moved the struct out of the function call argument ]

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250513172819.2216709-4-maz@kernel.org

---
 drivers/irqchip/irq-gic-v2m.c    | 16 ++++++++--------
 drivers/irqchip/irq-gic-v3-its.c | 22 +++++++++-------------
 drivers/irqchip/irq-gic-v3-mbi.c | 16 ++++++----------
 3 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 6267699..102f171 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -261,23 +261,23 @@ static struct msi_parent_ops gicv2m_msi_parent_ops = {
 
 static __init int gicv2m_allocate_domains(struct irq_domain *parent)
 {
-	struct irq_domain *inner_domain;
+	struct irq_domain_info info = {
+		.ops		= &gicv2m_domain_ops,
+		.parent		= parent,
+	};
 	struct v2m_data *v2m;
 
 	v2m = list_first_entry_or_null(&v2m_nodes, struct v2m_data, entry);
 	if (!v2m)
 		return 0;
 
-	inner_domain = irq_domain_create_hierarchy(parent, 0, 0, v2m->fwnode,
-						   &gicv2m_domain_ops, v2m);
-	if (!inner_domain) {
+	info.host_data = v2m;
+	info.fwnode = v2m->fwnode;
+
+	if (!msi_create_parent_irq_domain(&info, &gicv2m_msi_parent_ops)) {
 		pr_err("Failed to create GICv2m domain\n");
 		return -ENOMEM;
 	}
-
-	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
-	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	inner_domain->msi_parent_ops = &gicv2m_msi_parent_ops;
 	return 0;
 }
 
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index d651cd4..57ecf5b 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5122,7 +5122,12 @@ out_unmap:
 
 static int its_init_domain(struct its_node *its)
 {
-	struct irq_domain *inner_domain;
+	struct irq_domain_info dom_info = {
+		.fwnode		= its->fwnode_handle,
+		.ops		= &its_domain_ops,
+		.domain_flags	= its->msi_domain_flags,
+		.parent		= its_parent,
+	};
 	struct msi_domain_info *info;
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
@@ -5131,21 +5136,12 @@ static int its_init_domain(struct its_node *its)
 
 	info->ops = &its_msi_domain_ops;
 	info->data = its;
+	dom_info.host_data = info;
 
-	inner_domain = irq_domain_create_hierarchy(its_parent,
-						   its->msi_domain_flags, 0,
-						   its->fwnode_handle, &its_domain_ops,
-						   info);
-	if (!inner_domain) {
+	if (!msi_create_parent_irq_domain(&dom_info, &gic_v3_its_msi_parent_ops)) {
 		kfree(info);
 		return -ENOMEM;
 	}
-
-	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
-
-	inner_domain->msi_parent_ops = &gic_v3_its_msi_parent_ops;
-	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT | IRQ_DOMAIN_FLAG_MSI_IMMUTABLE;
-
 	return 0;
 }
 
@@ -5522,7 +5518,7 @@ static struct its_node __init *its_node_init(struct resource *res,
 	its->base = its_base;
 	its->phys_base = res->start;
 	its->get_msi_base = its_irq_get_msi_base;
-	its->msi_domain_flags = IRQ_DOMAIN_FLAG_ISOLATED_MSI;
+	its->msi_domain_flags = IRQ_DOMAIN_FLAG_ISOLATED_MSI | IRQ_DOMAIN_FLAG_MSI_IMMUTABLE;
 
 	its->numa_node = numa_node;
 	its->fwnode_handle = handle;
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index e562b57..6a4afd1 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -206,17 +206,13 @@ static const struct msi_parent_ops gic_v3_mbi_msi_parent_ops = {
 
 static int mbi_allocate_domain(struct irq_domain *parent)
 {
-	struct irq_domain *nexus_domain;
+	struct irq_domain_info info = {
+		.fwnode		= parent->fwnode,
+		.ops		= &mbi_domain_ops,
+		.parent		= parent,
+	};
 
-	nexus_domain = irq_domain_create_hierarchy(parent, 0, 0, parent->fwnode,
-						   &mbi_domain_ops, NULL);
-	if (!nexus_domain)
-		return -ENOMEM;
-
-	irq_domain_update_bus_token(nexus_domain, DOMAIN_BUS_NEXUS);
-	nexus_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	nexus_domain->msi_parent_ops = &gic_v3_mbi_msi_parent_ops;
-	return 0;
+	return msi_create_parent_irq_domain(&info, &gic_v3_mbi_msi_parent_ops) ? 0 : -ENOMEM;
 }
 
 int __init mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent)

