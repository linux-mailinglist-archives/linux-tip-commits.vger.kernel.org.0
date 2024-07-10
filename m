Return-Path: <linux-tip-commits+bounces-1656-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF1292D65E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 18:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DDD8B28E68
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 16:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18BD198E77;
	Wed, 10 Jul 2024 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KV8eJsAy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FukElmri"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F28198A01;
	Wed, 10 Jul 2024 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628754; cv=none; b=eb+o2OudjISUwU2f8o4/yAYjIH4iLvBwdtkCwQd8vuROHn17IW66qJ0Q7cT5i2XEoc3ynSNiDHSw/1h/F+ovkuH7WYYKpgyq8k9l2VPtSTROQNBCwRxhU9udUnJSu2LeUcOx/NR4h2wDHx36tYH+awCVVuyHrZHX63BiBc1cyfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628754; c=relaxed/simple;
	bh=NgeF6gs1ZnN+50RD+8h4yDw/rsEsqYaVLFM1lLWyM7I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NJcDf1AkNX2ue1+kwS81ucLbAY36EDd2QJC3Ihkuq03lpXVjVDitt2Rip6rdiFV0J6Z96TH0qhS0CY0F8BjDDi//AqUBryIooWGH9VbG/8e1svGJio3MiHp9qBfOzQCp5T24ID7iYoUQVdCW+VV8oBzkgxcI4TVm++90o6n4E6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KV8eJsAy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FukElmri; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jul 2024 16:25:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720628750;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXfPwB+6ld2NEcWMdlpfmCs/Zs0fkz/FpbIHC3APoyE=;
	b=KV8eJsAyaf1eUT/KJouv8yXCZJd2mC/9Mx6HwiYJko0E22XVVeDaOAZ4ht8G2NaArT/UaD
	mG1WZQDpPSd7uOZQgeaNGHBbiaqf9840EnOvipMzxFAne7csB0aWVVCCtB8QHbSqFYK6Pr
	bYaSlOretz7aujzm3SMWvRVsHmPn9GxWw/uCE/n6Pd+sHBAhel4XQWM+6bOlWlqEbzN+mW
	HSG4qq3Wg6wUx/oc3JA41Qj2b0v18SUooe+1Gnyt83l9GjCusicwGJDwn7wHrw1L8LMAlT
	IzN0oEVWNxeV3ufcwXEy2rof7BHlLtnhmDxcMOb/U6Q6J9/bsK/c4R6XcckbrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720628750;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXfPwB+6ld2NEcWMdlpfmCs/Zs0fkz/FpbIHC3APoyE=;
	b=FukElmriQZ06Dp3Sn5ASiG6M1doj5MiAA+33jDKNTIglTDaDGLstY9ZAjyv9ZjI0PB0DtC
	ShqaGC9+hoZPMLAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/irq-mvebu-icu: Prepare for real per device MSI
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240623142235.635015886@linutronix.de>
References: <20240623142235.635015886@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172062874981.2215.4373263946519323935.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     315145d9ede827295d5a6911b36dbf3af7a25dff
Gitweb:        https://git.kernel.org/tip/315145d9ede827295d5a6911b36dbf3af7a25dff
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:18:56 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Jul 2024 18:19:24 +02:00

irqchip/irq-mvebu-icu: Prepare for real per device MSI

The core infrastructure has everything in place to switch ICU to per
device MSI domains and avoid the convoluted construct of the existing
platform-MSI layering violation.

The new infrastructure provides a wired interrupt specific interface in the
MSI core which converts the 'hardware interrupt number + trigger type'
allocation which is required for wired interrupts in the regular irqdomain
code to a normal MSI allocation.

The hardware interrupt number and the trigger type are stored in the MSI
descriptor device cookie by the core code so the ICU specific code can
retrieve them.

The new per device domain is only instantiated when the irqdomain which is
associated to the ICU device provides MSI parent functionality. Up to
that point it invokes the existing code. Once the parent is converted the
code for the current platform-MSI mechanism is removed.

The new domain shares the interrupt chip callbacks and the translation
function. The only new functionality aside of filling out the
msi_domain_templates is a domain specific set_desc() callback, which will go
away once all platform-MSI code has been converted.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240623142235.635015886@linutronix.de



---
 drivers/irqchip/irq-mvebu-icu.c | 181 +++++++++++++++++++++++++++++--
 1 file changed, 170 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 3c77acc..2a210cd 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -20,6 +20,8 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
+#include "irq-msi-lib.h"
+
 #include <dt-bindings/interrupt-controller/mvebu-icu.h>
 
 /* ICU registers */
@@ -60,14 +62,52 @@ struct mvebu_icu_msi_data {
 	const struct mvebu_icu_subset_data *subset_data;
 };
 
-struct mvebu_icu_irq_data {
-	struct mvebu_icu *icu;
-	unsigned int icu_group;
-	unsigned int type;
-};
-
 static DEFINE_STATIC_KEY_FALSE(legacy_bindings);
 
+static int mvebu_icu_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
+			       unsigned long *hwirq, unsigned int *type)
+{
+	unsigned int param_count = static_branch_unlikely(&legacy_bindings) ? 3 : 2;
+	struct mvebu_icu_msi_data *msi_data = d->host_data;
+	struct mvebu_icu *icu = msi_data->icu;
+
+	/* Check the count of the parameters in dt */
+	if (WARN_ON(fwspec->param_count != param_count)) {
+		dev_err(icu->dev, "wrong ICU parameter count %d\n",
+			fwspec->param_count);
+		return -EINVAL;
+	}
+
+	if (static_branch_unlikely(&legacy_bindings)) {
+		*hwirq = fwspec->param[1];
+		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+		if (fwspec->param[0] != ICU_GRP_NSR) {
+			dev_err(icu->dev, "wrong ICU group type %x\n",
+				fwspec->param[0]);
+			return -EINVAL;
+		}
+	} else {
+		*hwirq = fwspec->param[0];
+		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+
+		/*
+		 * The ICU receives level interrupts. While the NSR are also
+		 * level interrupts, SEI are edge interrupts. Force the type
+		 * here in this case. Please note that this makes the interrupt
+		 * handling unreliable.
+		 */
+		if (msi_data->subset_data->icu_group == ICU_GRP_SEI)
+			*type = IRQ_TYPE_EDGE_RISING;
+	}
+
+	if (*hwirq >= ICU_MAX_IRQS) {
+		dev_err(icu->dev, "invalid interrupt number %ld\n", *hwirq);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void mvebu_icu_init(struct mvebu_icu *icu,
 			   struct mvebu_icu_msi_data *msi_data,
 			   struct msi_msg *msg)
@@ -89,6 +129,14 @@ static void mvebu_icu_init(struct mvebu_icu *icu,
 	writel_relaxed(msg[1].address_lo, icu->base + subset->offset_clr_al);
 }
 
+/* Start of area to be removed once all parent chips provide MSI parent */
+
+struct mvebu_icu_irq_data {
+	struct mvebu_icu *icu;
+	unsigned int icu_group;
+	unsigned int type;
+};
+
 static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 {
 	struct irq_data *d = irq_get_irq_data(desc->irq);
@@ -269,6 +317,109 @@ static const struct irq_domain_ops mvebu_icu_domain_ops = {
 	.free      = mvebu_icu_irq_domain_free,
 };
 
+/* End of removal area */
+
+static int mvebu_icu_msi_init(struct irq_domain *domain, struct msi_domain_info *info,
+			      unsigned int virq, irq_hw_number_t hwirq, msi_alloc_info_t *arg)
+{
+	irq_domain_set_hwirq_and_chip(domain, virq, hwirq, info->chip, info->chip_data);
+	return irq_set_irqchip_state(virq, IRQCHIP_STATE_PENDING, false);
+}
+
+static void mvebu_icu_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+{
+	arg->desc = desc;
+	arg->hwirq = (u32)desc->data.icookie.value;
+}
+
+static void mvebu_icu_write_msi_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	struct mvebu_icu_msi_data *msi_data = d->chip_data;
+	unsigned int icu_group = msi_data->subset_data->icu_group;
+	struct msi_desc *desc = irq_data_get_msi_desc(d);
+	struct mvebu_icu *icu = msi_data->icu;
+	unsigned int type;
+	u32 icu_int;
+
+	if (msg->address_lo || msg->address_hi) {
+		/* One off initialization per domain */
+		mvebu_icu_init(icu, msi_data, msg);
+		/* Configure the ICU with irq number & type */
+		icu_int = msg->data | ICU_INT_ENABLE;
+		type = (unsigned int)(desc->data.icookie.value >> 32);
+		if (type & IRQ_TYPE_EDGE_RISING)
+			icu_int |= ICU_IS_EDGE;
+		icu_int |= icu_group << ICU_GROUP_SHIFT;
+	} else {
+		/* De-configure the ICU */
+		icu_int = 0;
+	}
+
+	writel_relaxed(icu_int, icu->base + ICU_INT_CFG(d->hwirq));
+
+	/*
+	 * The SATA unit has 2 ports, and a dedicated ICU entry per
+	 * port. The ahci sata driver supports only one irq interrupt
+	 * per SATA unit. To solve this conflict, we configure the 2
+	 * SATA wired interrupts in the south bridge into 1 GIC
+	 * interrupt in the north bridge. Even if only a single port
+	 * is enabled, if sata node is enabled, both interrupts are
+	 * configured (regardless of which port is actually in use).
+	 */
+	if (d->hwirq == ICU_SATA0_ICU_ID || d->hwirq == ICU_SATA1_ICU_ID) {
+		writel_relaxed(icu_int, icu->base + ICU_INT_CFG(ICU_SATA0_ICU_ID));
+		writel_relaxed(icu_int, icu->base + ICU_INT_CFG(ICU_SATA1_ICU_ID));
+	}
+}
+
+static const struct msi_domain_template mvebu_icu_nsr_msi_template = {
+	.chip = {
+		.name			= "ICU-NSR",
+		.irq_mask		= irq_chip_mask_parent,
+		.irq_unmask		= irq_chip_unmask_parent,
+		.irq_eoi		= irq_chip_eoi_parent,
+		.irq_set_type		= irq_chip_set_type_parent,
+		.irq_write_msi_msg	= mvebu_icu_write_msi_msg,
+		.flags			= IRQCHIP_SUPPORTS_LEVEL_MSI,
+	},
+
+	.ops = {
+		.msi_translate		= mvebu_icu_translate,
+		.msi_init		= mvebu_icu_msi_init,
+		.set_desc		= mvebu_icu_set_desc,
+	},
+
+	.info = {
+		.bus_token		= DOMAIN_BUS_WIRED_TO_MSI,
+		.flags			= MSI_FLAG_LEVEL_CAPABLE |
+					  MSI_FLAG_USE_DEV_FWNODE,
+	},
+};
+
+static const struct msi_domain_template mvebu_icu_sei_msi_template = {
+	.chip = {
+		.name			= "ICU-SEI",
+		.irq_mask		= irq_chip_mask_parent,
+		.irq_unmask		= irq_chip_unmask_parent,
+		.irq_ack		= irq_chip_ack_parent,
+		.irq_set_type		= irq_chip_set_type_parent,
+		.irq_write_msi_msg	= mvebu_icu_write_msi_msg,
+		.flags			= IRQCHIP_SUPPORTS_LEVEL_MSI,
+	},
+
+	.ops = {
+		.msi_translate		= mvebu_icu_translate,
+		.msi_init		= mvebu_icu_msi_init,
+		.set_desc		= mvebu_icu_set_desc,
+	},
+
+	.info = {
+		.bus_token		= DOMAIN_BUS_WIRED_TO_MSI,
+		.flags			= MSI_FLAG_LEVEL_CAPABLE |
+					  MSI_FLAG_USE_DEV_FWNODE,
+	},
+};
+
 static const struct mvebu_icu_subset_data mvebu_icu_nsr_subset_data = {
 	.icu_group = ICU_GRP_NSR,
 	.offset_set_ah = ICU_SETSPI_NSR_AH,
@@ -298,7 +449,6 @@ static const struct of_device_id mvebu_icu_subset_of_match[] = {
 static int mvebu_icu_subset_probe(struct platform_device *pdev)
 {
 	struct mvebu_icu_msi_data *msi_data;
-	struct device_node *msi_parent_dn;
 	struct device *dev = &pdev->dev;
 	struct irq_domain *irq_domain;
 
@@ -314,15 +464,24 @@ static int mvebu_icu_subset_probe(struct platform_device *pdev)
 		msi_data->subset_data = of_device_get_match_data(dev);
 	}
 
-	dev->msi.domain = of_msi_get_domain(dev, dev->of_node,
-					    DOMAIN_BUS_PLATFORM_MSI);
+	dev->msi.domain = of_msi_get_domain(dev, dev->of_node, DOMAIN_BUS_PLATFORM_MSI);
 	if (!dev->msi.domain)
 		return -EPROBE_DEFER;
 
-	msi_parent_dn = irq_domain_get_of_node(dev->msi.domain);
-	if (!msi_parent_dn)
+	if (!irq_domain_get_of_node(dev->msi.domain))
 		return -ENODEV;
 
+	if (irq_domain_is_msi_parent(dev->msi.domain)) {
+		bool sei = msi_data->subset_data->icu_group == ICU_GRP_SEI;
+		const struct msi_domain_template *tmpl;
+
+		tmpl = sei ? &mvebu_icu_sei_msi_template : &mvebu_icu_nsr_msi_template;
+
+		if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN, tmpl,
+						  ICU_MAX_IRQS, NULL, msi_data))
+			return -ENOMEM;
+	}
+
 	irq_domain = platform_msi_create_device_tree_domain(dev, ICU_MAX_IRQS,
 							    mvebu_icu_write_msg,
 							    &mvebu_icu_domain_ops,

