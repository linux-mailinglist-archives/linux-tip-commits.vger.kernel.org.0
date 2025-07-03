Return-Path: <linux-tip-commits+bounces-5992-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C99AF7687
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 16:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F217D1C873DB
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 14:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223532EAB98;
	Thu,  3 Jul 2025 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1g8qLKmK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7EcYgb0w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6599B2EA755;
	Thu,  3 Jul 2025 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551240; cv=none; b=NefpyiAqMjRLb6d9bSFWDrfMqpt7jM457YTD3ZmZG8Om/tdyprXu38gpYpiYG+o89ljedaoVIYBQKl3RTL3+tWoDFZvEDcpTLMxpwZDwRDPQ76u/xFcUmYtMHAfmXYPOXNBYeH4jeAaz86vZj7A+x4fzo1dAejZyw8VvaAqJR9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551240; c=relaxed/simple;
	bh=PbJClQ7iTrGfjugkOk9kDObC9VBSv2C6LY/J2atmRcI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=euh39jvjx6LufOZRl+YFPwD+/nznijTCHlcIMXJyGisZjymAsXBJd7oZI6c3ZUkRzoWMJOiRxQzTshTNhQjiSqrmG3Pf8zK/+Zrj1hm3dk3ojNE7WuxVQny9Br0kxE1R+X3EsMT30iSSKB5gdn2pUpHja65BItUV2SXbFJKrbbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1g8qLKmK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7EcYgb0w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Jul 2025 14:00:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751551235;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvs0pb3PIdwR5fFN9EQzKFiJiXWyfrWoKsm/10HO4LI=;
	b=1g8qLKmKQmwiZvnIYaKkKubJCRwf3AARJdP5+hdQ9DpDKAMiibgATIwkaLEpi2Ni/zG565
	09zYDIn/YNg2OVBwpdJKuuRx3QYMrnTTICd24sebjG2CVdhMecsJQEEIElqjSyfF7yRSmQ
	p74TcxTw3LNhRLIEaWbuRqFpcat6B/Q2ftWqzxdLw/1Y96mAPaEWwYGl6xs9orYJ7bHvUA
	SkUyWXcFACtQlfbeU8R5iGtguHUSIhMOpfeojXYVAxY1+MoYyIS8NqI+94G+35Ur5ym1g+
	a4T/2y9UQLl0WmG9nWKUrvgbaCMEKvZEpXndsDYxbCpWbXCZn0fHefU0UJnBfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751551235;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jvs0pb3PIdwR5fFN9EQzKFiJiXWyfrWoKsm/10HO4LI=;
	b=7EcYgb0wUv5VGJGyMgY89Y3ximV7T/ZEPrFDYd6EmZz1zJwywXbyun5T08a0pjiritDobq
	UAsfn82tIc/ikxAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/loongson-pch-msi.c: Switch to
 msi_create_parent_irq_domain()
Cc: Thomas Gleixner <tglx@linutronix.de>, Nam Cao <namcao@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C7ae78d7b7e33ad8ca1ec2ba28957546c81ba86f7=2E17508?=
 =?utf-8?q?60131=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C7ae78d7b7e33ad8ca1ec2ba28957546c81ba86f7=2E175086?=
 =?utf-8?q?0131=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175155123463.406.10335790228131090981.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     7f91d608cc43ea7f417caf097a87d2619a0e2747
Gitweb:        https://git.kernel.org/tip/7f91d608cc43ea7f417caf097a87d2619a0e2747
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 26 Jun 2025 16:49:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 03 Jul 2025 15:49:24 +02:00

irqchip/loongson-pch-msi.c: Switch to msi_create_parent_irq_domain()

Switch to use the concise helper to create an MSI parent domain.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/7ae78d7b7e33ad8ca1ec2ba28957546c81ba86f7.1750860131.git.namcao@linutronix.de

---
 drivers/irqchip/irq-loongson-pch-msi.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index a0257c7..4aedc9b 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -153,26 +153,21 @@ static struct msi_parent_ops pch_msi_parent_ops = {
 	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
 };
 
-static int pch_msi_init_domains(struct pch_msi_data *priv,
-				struct irq_domain *parent,
+static int pch_msi_init_domains(struct pch_msi_data *priv, struct irq_domain *parent,
 				struct fwnode_handle *domain_handle)
 {
-	struct irq_domain *middle_domain;
-
-	middle_domain = irq_domain_create_hierarchy(parent, 0, priv->num_irqs,
-						    domain_handle,
-						    &pch_msi_middle_domain_ops,
-						    priv);
-	if (!middle_domain) {
+	struct irq_domain_info info = {
+		.ops		= &pch_msi_middle_domain_ops,
+		.size		= priv->num_irqs,
+		.parent		= parent,
+		.host_data	= priv,
+		.fwnode		= domain_handle,
+	};
+
+	if (!msi_create_parent_irq_domain(&info, &pch_msi_parent_ops)) {
 		pr_err("Failed to create the MSI middle domain\n");
 		return -ENOMEM;
 	}
-
-	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
-
-	middle_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	middle_domain->msi_parent_ops = &pch_msi_parent_ops;
-
 	return 0;
 }
 

