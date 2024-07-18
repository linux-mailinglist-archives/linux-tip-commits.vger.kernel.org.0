Return-Path: <linux-tip-commits+bounces-1727-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6C89351C6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 20:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6ED1F21CB4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 18:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C71146D6D;
	Thu, 18 Jul 2024 18:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zn/M5d0y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p3Ik5InE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC87414659A;
	Thu, 18 Jul 2024 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327949; cv=none; b=N5E3TMkAf1HJwZA3sXe8dFeDu6okvYPznQ5LY4F5tSyb52qgPFQ5WhstkFMm9x0K+UAYPFFFXwZOL3tmXdP5aHFK8932A+ue3SNPIc7MJtWHk5XybeFIQ+ZCGYnckbmiADePBL62yJ0B5pne9vk8aBJPSDcRSqwL1CMMWuAfS70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327949; c=relaxed/simple;
	bh=NHU8FhNOfODkLtOVGXjN216l82Op/qYZbtQYq3RiNqM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=B48vR0LS48m9L+vV3gHVQ4wIzv0Jy/uyzrp3gXGfPgMf5NQ9adWZn6j82PGEnyrTIuVbLVnNvGO95eOfdpQmoMTVLKAPhM2b9V2Np7ZxLIJThLFivulbECGmW+q2JM5GSacpsMphzifFAAXYsMA5yu+kPs5RAahegiOiz+5/KVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zn/M5d0y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p3Ik5InE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jul 2024 18:39:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721327941;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdsHRj2zcsI/UuT7k9xo4kfgkyg0tKYzn4jT5a+Y5MY=;
	b=zn/M5d0ydzaqL6ep13D1g8UcBr8jIQdMPv6w4cve+tKQDjLXmgvbG6dUxWN2CJ2rkrOGG/
	OXwQOSnzxol8Ih7Ls9xWSQ/NQKm7GnX3HFHECfiZo57tVgTwmyEB4pWZwYjZFPkJ5cyT7c
	bXU3eSudO8ltdGl1UaPnzK5441CRZAhdUBZRFPPMQX8TTv/JKtZjw5/lMuq/1nSs83zeWg
	8WpdYQvatrdE0cK0dkHb5VWY6F4pJwCY3CtCAcTAKQXidPWvAe0FX25fHu/8AVC143U+k4
	8R6ZkaQ7uR8P34kGf4sm7QdwmGgnF2+p2kblZqMTf9e48FruTHb8BfhYnzIjaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721327941;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdsHRj2zcsI/UuT7k9xo4kfgkyg0tKYzn4jT5a+Y5MY=;
	b=p3Ik5InEP7j0wTZeLCfUDVdMA2RmXFqCd5Utj9z6Lmelw1Zohe8byIT6jQTZnsWAnv2Vy7
	sDA996UQaqAj52AQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/mbigen: Prepare for real per device MSI
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240623142235.146579575@linutronix.de>
References: <20240623142235.146579575@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172132794105.2215.5381801249816838454.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     fbfe7e13641efe811a273e1fd237929245376fe0
Gitweb:        https://git.kernel.org/tip/fbfe7e13641efe811a273e1fd237929245376fe0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:18:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jul 2024 20:31:20 +02:00

irqchip/mbigen: Prepare for real per device MSI

The core infrastructure has everything in place to switch MBIGEN to per
device MSI domains and avoid the convoluted construct of the existing
platform-MSI layering violation.

The new infrastructure provides a wired interrupt specific interface in the
MSI core which converts the 'hardware interrupt number + trigger type'
allocation which is required for wired interrupts in the regular irqdomain
code to a normal MSI allocation.

The hardware interrupt number and the trigger type are stored in the MSI
descriptor device cookie by the core code so the MBIGEN specific code can
retrieve them.

The new per device domain is only instantiated when the irqdomain which is
associated to the MBIGEN device provides MSI parent functionality. Up to
that point it invokes the existing code. Once the parent is converted the
code for the current platform-MSI mechanism is removed.

The new domain shares the interrupt chip callbacks and the translation
function. The only new functionality aside of filling out the
msi_domain_template is a domain specific set_desc() callback, which will go
away once all platform-MSI code has been converted.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240623142235.146579575@linutronix.de



---
 drivers/irqchip/irq-mbigen.c | 98 +++++++++++++++++++++++++----------
 1 file changed, 70 insertions(+), 28 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 58881d3..db0fa80 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -135,24 +135,14 @@ static int mbigen_set_type(struct irq_data *data, unsigned int type)
 	return 0;
 }
 
-static struct irq_chip mbigen_irq_chip = {
-	.name =			"mbigen-v2",
-	.irq_mask =		irq_chip_mask_parent,
-	.irq_unmask =		irq_chip_unmask_parent,
-	.irq_eoi =		mbigen_eoi_irq,
-	.irq_set_type =		mbigen_set_type,
-	.irq_set_affinity =	irq_chip_set_affinity_parent,
-};
-
-static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
+static void mbigen_write_msi_msg(struct irq_data *d, struct msi_msg *msg)
 {
-	struct irq_data *d = irq_get_irq_data(desc->irq);
 	void __iomem *base = d->chip_data;
 	u32 val;
 
 	if (!msg->address_lo && !msg->address_hi)
 		return;
- 
+
 	base += get_mbigen_vec_reg(d->hwirq);
 	val = readl_relaxed(base);
 
@@ -165,10 +155,8 @@ static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 	writel_relaxed(val, base);
 }
 
-static int mbigen_domain_translate(struct irq_domain *d,
-				    struct irq_fwspec *fwspec,
-				    unsigned long *hwirq,
-				    unsigned int *type)
+static int mbigen_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
+				   unsigned long *hwirq, unsigned int *type)
 {
 	if (is_of_node(fwspec->fwnode) || is_acpi_device_node(fwspec->fwnode)) {
 		if (fwspec->param_count != 2)
@@ -192,6 +180,17 @@ static int mbigen_domain_translate(struct irq_domain *d,
 	return -EINVAL;
 }
 
+/* The following section will go away once ITS provides a MSI parent */
+
+static struct irq_chip mbigen_irq_chip = {
+	.name =			"mbigen-v2",
+	.irq_mask =		irq_chip_mask_parent,
+	.irq_unmask =		irq_chip_unmask_parent,
+	.irq_eoi =		mbigen_eoi_irq,
+	.irq_set_type =		mbigen_set_type,
+	.irq_set_affinity =	irq_chip_set_affinity_parent,
+};
+
 static int mbigen_irq_domain_alloc(struct irq_domain *domain,
 					unsigned int virq,
 					unsigned int nr_irqs,
@@ -232,11 +231,63 @@ static const struct irq_domain_ops mbigen_domain_ops = {
 	.free		= mbigen_irq_domain_free,
 };
 
+static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	mbigen_write_msi_msg(irq_get_irq_data(desc->irq), msg);
+}
+
+/* End of to be removed section */
+
+static void mbigen_domain_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+{
+	arg->desc = desc;
+	arg->hwirq = (u32)desc->data.icookie.value;
+}
+
+static const struct msi_domain_template mbigen_msi_template = {
+	.chip = {
+		.name			= "mbigen-v2",
+		.irq_mask		= irq_chip_mask_parent,
+		.irq_unmask		= irq_chip_unmask_parent,
+		.irq_eoi		= mbigen_eoi_irq,
+		.irq_set_type		= mbigen_set_type,
+		.irq_write_msi_msg	= mbigen_write_msi_msg,
+	},
+
+	.ops = {
+		.set_desc		= mbigen_domain_set_desc,
+		.msi_translate		= mbigen_domain_translate,
+	},
+
+	.info = {
+		.bus_token		= DOMAIN_BUS_WIRED_TO_MSI,
+		.flags			= MSI_FLAG_USE_DEV_FWNODE,
+	},
+};
+
+static bool mbigen_create_device_domain(struct device *dev, unsigned int size,
+					struct mbigen_device *mgn_chip)
+{
+	struct irq_domain *domain = dev->msi.domain;
+
+	if (WARN_ON_ONCE(!domain))
+		return false;
+
+	if (irq_domain_is_msi_parent(domain)) {
+		return msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN,
+						    &mbigen_msi_template, size,
+						    NULL, mgn_chip->base);
+	}
+
+	/* Remove once ITS provides MSI parent */
+	return !!platform_msi_create_device_domain(dev, size, mbigen_write_msg,
+						   &mbigen_domain_ops, mgn_chip);
+}
+
 static int mbigen_of_create_domain(struct platform_device *pdev,
 				   struct mbigen_device *mgn_chip)
 {
 	struct platform_device *child;
-	struct irq_domain *domain;
 	struct device_node *np;
 	u32 num_pins;
 	int ret = 0;
@@ -258,11 +309,7 @@ static int mbigen_of_create_domain(struct platform_device *pdev,
 			break;
 		}
 
-		domain = platform_msi_create_device_domain(&child->dev, num_pins,
-							   mbigen_write_msg,
-							   &mbigen_domain_ops,
-							   mgn_chip);
-		if (!domain) {
+		if (!mbigen_create_device_domain(&child->dev, num_pins, mgn_chip)) {
 			ret = -ENOMEM;
 			break;
 		}
@@ -284,7 +331,6 @@ MODULE_DEVICE_TABLE(acpi, mbigen_acpi_match);
 static int mbigen_acpi_create_domain(struct platform_device *pdev,
 				     struct mbigen_device *mgn_chip)
 {
-	struct irq_domain *domain;
 	u32 num_pins = 0;
 	int ret;
 
@@ -315,11 +361,7 @@ static int mbigen_acpi_create_domain(struct platform_device *pdev,
 	if (ret || num_pins == 0)
 		return -EINVAL;
 
-	domain = platform_msi_create_device_domain(&pdev->dev, num_pins,
-						   mbigen_write_msg,
-						   &mbigen_domain_ops,
-						   mgn_chip);
-	if (!domain)
+	if (!mbigen_create_device_domain(&pdev->dev, num_pins, mgn_chip))
 		return -ENOMEM;
 
 	return 0;

