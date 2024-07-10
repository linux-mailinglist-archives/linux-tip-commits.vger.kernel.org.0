Return-Path: <linux-tip-commits+bounces-1652-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8A992D655
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 18:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E2C28719D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 16:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE9B198857;
	Wed, 10 Jul 2024 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lpp2zAiV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UqbLe2V7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3BC198827;
	Wed, 10 Jul 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628752; cv=none; b=FeXmqZvnW1BympXmBcrtNcGa80noRt5eKsA4J7VE/Vs1jtcQMUJ6qQAhvjBhLIsAPJ0qRUGNxyHtjOziR67uTM3HpyKbuX8ggVHBOUaUCTuG7SOxvFMLmPNqEqVg3mJl93sH5jBXn5OhdSYJL+6Zw/ywV9l5CYjwslqgcM+cuGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628752; c=relaxed/simple;
	bh=iUl1cWYDGVw3wNPztR3wub1qphSHEqsNV8q90WIVUxM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jSmsJacvHtDVSbpbflEjgo2Hr47n7sv+R9z8A3oDNxh7MbloN5xgTHHL6du9szkXMwmq2QRr8snmIBEgzmc72JY83gCuvm7OdzALIFiB3bcyxq4A/FSBhi9frLVzK67RyJ7B0iu/LuRRG1w6j5pFhDH8frCSDSNkyaQER0ljkPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lpp2zAiV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UqbLe2V7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jul 2024 16:25:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720628748;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VqS0qyxWTl8fqXhc3ApaHX5Pn9vN5otlv3pt+XjwK/8=;
	b=lpp2zAiV42cXSEJyhjWZDBjp4FRn9uURRcsJF4kjG8291fduLVjFacvlR+9Qfc84TJApup
	5stgmCsCnQ+YE5gxx5YTfk+8KJy/rqcvTXQDfnLPcMpBPWDG4D2u/MDHR7fwD5R/MroTDF
	Y73dxV/65VZ+nGLPVndCL+aNhwLdnLOrrKUxt0T3BO52OBiPtLPuqA8G/lfugMJ1b7iMcU
	LnPGlbxkV1zpJ4HFy8ryjGEA/DNl6fZUMbSVL+++6eGUNO9LLOI1Z9mDrlp6OcKch6g+3J
	0Er539vn3qz4qS1w4M17CYF8J5fh1M3ywvgbAgzOiJe+a4yCHesXAFoE6pn3xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720628748;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VqS0qyxWTl8fqXhc3ApaHX5Pn9vN5otlv3pt+XjwK/8=;
	b=UqbLe2V7KXG2YQN9LQDAHwZuVhX2BrDrJM2FclEHStnB/sLC9m+MS8t6C59xhM0W+XI6qF
	xDjCY8knVS/TzYDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/irq-mvebu-icu: Remove platform MSI leftovers
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240623142235.881677325@linutronix.de>
References: <20240623142235.881677325@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172062874814.2215.12813933004253270867.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5aef068dd2adc5192eda5a471a502301bf876b62
Gitweb:        https://git.kernel.org/tip/5aef068dd2adc5192eda5a471a502301bf876b62
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:19:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Jul 2024 18:19:25 +02:00

irqchip/irq-mvebu-icu: Remove platform MSI leftovers

All related domains provide MSI parent functionality, so the fallback code
to the original platform MSI implementation is not longer required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240623142235.881677325@linutronix.de



---
 drivers/irqchip/irq-mvebu-icu.c | 212 +-------------------------------
 1 file changed, 6 insertions(+), 206 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 2a210cd..b337f6c 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -129,196 +129,6 @@ static void mvebu_icu_init(struct mvebu_icu *icu,
 	writel_relaxed(msg[1].address_lo, icu->base + subset->offset_clr_al);
 }
 
-/* Start of area to be removed once all parent chips provide MSI parent */
-
-struct mvebu_icu_irq_data {
-	struct mvebu_icu *icu;
-	unsigned int icu_group;
-	unsigned int type;
-};
-
-static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
-{
-	struct irq_data *d = irq_get_irq_data(desc->irq);
-	struct mvebu_icu_msi_data *msi_data = platform_msi_get_host_data(d->domain);
-	struct mvebu_icu_irq_data *icu_irqd = d->chip_data;
-	struct mvebu_icu *icu = icu_irqd->icu;
-	unsigned int icu_int;
-
-	if (msg->address_lo || msg->address_hi) {
-		/* One off initialization per domain */
-		mvebu_icu_init(icu, msi_data, msg);
-		/* Configure the ICU with irq number & type */
-		icu_int = msg->data | ICU_INT_ENABLE;
-		if (icu_irqd->type & IRQ_TYPE_EDGE_RISING)
-			icu_int |= ICU_IS_EDGE;
-		icu_int |= icu_irqd->icu_group << ICU_GROUP_SHIFT;
-	} else {
-		/* De-configure the ICU */
-		icu_int = 0;
-	}
-
-	writel_relaxed(icu_int, icu->base + ICU_INT_CFG(d->hwirq));
-
-	/*
-	 * The SATA unit has 2 ports, and a dedicated ICU entry per
-	 * port. The ahci sata driver supports only one irq interrupt
-	 * per SATA unit. To solve this conflict, we configure the 2
-	 * SATA wired interrupts in the south bridge into 1 GIC
-	 * interrupt in the north bridge. Even if only a single port
-	 * is enabled, if sata node is enabled, both interrupts are
-	 * configured (regardless of which port is actually in use).
-	 */
-	if (d->hwirq == ICU_SATA0_ICU_ID || d->hwirq == ICU_SATA1_ICU_ID) {
-		writel_relaxed(icu_int,
-			       icu->base + ICU_INT_CFG(ICU_SATA0_ICU_ID));
-		writel_relaxed(icu_int,
-			       icu->base + ICU_INT_CFG(ICU_SATA1_ICU_ID));
-	}
-}
-
-static struct irq_chip mvebu_icu_nsr_chip = {
-	.name			= "ICU-NSR",
-	.irq_mask		= irq_chip_mask_parent,
-	.irq_unmask		= irq_chip_unmask_parent,
-	.irq_eoi		= irq_chip_eoi_parent,
-	.irq_set_type		= irq_chip_set_type_parent,
-	.irq_set_affinity	= irq_chip_set_affinity_parent,
-};
-
-static struct irq_chip mvebu_icu_sei_chip = {
-	.name			= "ICU-SEI",
-	.irq_ack		= irq_chip_ack_parent,
-	.irq_mask		= irq_chip_mask_parent,
-	.irq_unmask		= irq_chip_unmask_parent,
-	.irq_set_type		= irq_chip_set_type_parent,
-	.irq_set_affinity	= irq_chip_set_affinity_parent,
-};
-
-static int
-mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
-			       unsigned long *hwirq, unsigned int *type)
-{
-	unsigned int param_count = static_branch_unlikely(&legacy_bindings) ? 3 : 2;
-	struct mvebu_icu_msi_data *msi_data = platform_msi_get_host_data(d);
-	struct mvebu_icu *icu = msi_data->icu;
-
-	/* Check the count of the parameters in dt */
-	if (WARN_ON(fwspec->param_count != param_count)) {
-		dev_err(icu->dev, "wrong ICU parameter count %d\n",
-			fwspec->param_count);
-		return -EINVAL;
-	}
-
-	if (static_branch_unlikely(&legacy_bindings)) {
-		*hwirq = fwspec->param[1];
-		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
-		if (fwspec->param[0] != ICU_GRP_NSR) {
-			dev_err(icu->dev, "wrong ICU group type %x\n",
-				fwspec->param[0]);
-			return -EINVAL;
-		}
-	} else {
-		*hwirq = fwspec->param[0];
-		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
-
-		/*
-		 * The ICU receives level interrupts. While the NSR are also
-		 * level interrupts, SEI are edge interrupts. Force the type
-		 * here in this case. Please note that this makes the interrupt
-		 * handling unreliable.
-		 */
-		if (msi_data->subset_data->icu_group == ICU_GRP_SEI)
-			*type = IRQ_TYPE_EDGE_RISING;
-	}
-
-	if (*hwirq >= ICU_MAX_IRQS) {
-		dev_err(icu->dev, "invalid interrupt number %ld\n", *hwirq);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static int
-mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
-			   unsigned int nr_irqs, void *args)
-{
-	int err;
-	unsigned long hwirq;
-	struct irq_fwspec *fwspec = args;
-	struct mvebu_icu_msi_data *msi_data = platform_msi_get_host_data(domain);
-	struct mvebu_icu *icu = msi_data->icu;
-	struct mvebu_icu_irq_data *icu_irqd;
-	struct irq_chip *chip = &mvebu_icu_nsr_chip;
-
-	icu_irqd = kmalloc(sizeof(*icu_irqd), GFP_KERNEL);
-	if (!icu_irqd)
-		return -ENOMEM;
-
-	err = mvebu_icu_irq_domain_translate(domain, fwspec, &hwirq,
-					     &icu_irqd->type);
-	if (err) {
-		dev_err(icu->dev, "failed to translate ICU parameters\n");
-		goto free_irqd;
-	}
-
-	if (static_branch_unlikely(&legacy_bindings))
-		icu_irqd->icu_group = fwspec->param[0];
-	else
-		icu_irqd->icu_group = msi_data->subset_data->icu_group;
-	icu_irqd->icu = icu;
-
-	err = platform_msi_device_domain_alloc(domain, virq, nr_irqs);
-	if (err) {
-		dev_err(icu->dev, "failed to allocate ICU interrupt in parent domain\n");
-		goto free_irqd;
-	}
-
-	/* Make sure there is no interrupt left pending by the firmware */
-	err = irq_set_irqchip_state(virq, IRQCHIP_STATE_PENDING, false);
-	if (err)
-		goto free_msi;
-
-	if (icu_irqd->icu_group == ICU_GRP_SEI)
-		chip = &mvebu_icu_sei_chip;
-
-	err = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
-					    chip, icu_irqd);
-	if (err) {
-		dev_err(icu->dev, "failed to set the data to IRQ domain\n");
-		goto free_msi;
-	}
-
-	return 0;
-
-free_msi:
-	platform_msi_device_domain_free(domain, virq, nr_irqs);
-free_irqd:
-	kfree(icu_irqd);
-	return err;
-}
-
-static void
-mvebu_icu_irq_domain_free(struct irq_domain *domain, unsigned int virq,
-			  unsigned int nr_irqs)
-{
-	struct irq_data *d = irq_get_irq_data(virq);
-	struct mvebu_icu_irq_data *icu_irqd = d->chip_data;
-
-	kfree(icu_irqd);
-
-	platform_msi_device_domain_free(domain, virq, nr_irqs);
-}
-
-static const struct irq_domain_ops mvebu_icu_domain_ops = {
-	.translate = mvebu_icu_irq_domain_translate,
-	.alloc     = mvebu_icu_irq_domain_alloc,
-	.free      = mvebu_icu_irq_domain_free,
-};
-
-/* End of removal area */
-
 static int mvebu_icu_msi_init(struct irq_domain *domain, struct msi_domain_info *info,
 			      unsigned int virq, irq_hw_number_t hwirq, msi_alloc_info_t *arg)
 {
@@ -448,9 +258,10 @@ static const struct of_device_id mvebu_icu_subset_of_match[] = {
 
 static int mvebu_icu_subset_probe(struct platform_device *pdev)
 {
+	const struct msi_domain_template *tmpl;
 	struct mvebu_icu_msi_data *msi_data;
 	struct device *dev = &pdev->dev;
-	struct irq_domain *irq_domain;
+	bool sei;
 
 	msi_data = devm_kzalloc(dev, sizeof(*msi_data), GFP_KERNEL);
 	if (!msi_data)
@@ -471,22 +282,11 @@ static int mvebu_icu_subset_probe(struct platform_device *pdev)
 	if (!irq_domain_get_of_node(dev->msi.domain))
 		return -ENODEV;
 
-	if (irq_domain_is_msi_parent(dev->msi.domain)) {
-		bool sei = msi_data->subset_data->icu_group == ICU_GRP_SEI;
-		const struct msi_domain_template *tmpl;
-
-		tmpl = sei ? &mvebu_icu_sei_msi_template : &mvebu_icu_nsr_msi_template;
-
-		if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN, tmpl,
-						  ICU_MAX_IRQS, NULL, msi_data))
-			return -ENOMEM;
-	}
+	sei = msi_data->subset_data->icu_group == ICU_GRP_SEI;
+	tmpl = sei ? &mvebu_icu_sei_msi_template : &mvebu_icu_nsr_msi_template;
 
-	irq_domain = platform_msi_create_device_tree_domain(dev, ICU_MAX_IRQS,
-							    mvebu_icu_write_msg,
-							    &mvebu_icu_domain_ops,
-							    msi_data);
-	if (!irq_domain) {
+	if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN, tmpl,
+					  ICU_MAX_IRQS, NULL, msi_data)) {
 		dev_err(dev, "Failed to create ICU MSI domain\n");
 		return -ENOMEM;
 	}

