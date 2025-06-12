Return-Path: <linux-tip-commits+bounces-5777-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3160AD7183
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Jun 2025 15:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5387A188E166
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Jun 2025 13:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689EA23D295;
	Thu, 12 Jun 2025 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iFE+w3cY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Zqmk/K4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C4823C8A1;
	Thu, 12 Jun 2025 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734009; cv=none; b=n3D2b7l7gaE2/MgXujX6is4INRG9IYPabFkYhrdINZuiH7vU3llzIH1QLYWpBj7zYOEiYiO872qkyfFuBbOt+RWiW3YikKDZm1PZ0wYpAMG8ga0v4XSY9ERX1JbrMznA4pWhFMjoaI6FayaCOsnZ/7euSDfYPmMk8mKqNx93lwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734009; c=relaxed/simple;
	bh=XafmKj4P+VcSpKv9cSterEeNyAZwTIOKbYV4Fj9ARfg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Qikv7JC2+TJcUEbSFXyT8aC06FNxDqSj71h/EiGrf72YydHTeZOd/m3Xy8GUfzA6GS5okmIjuoSp9V5C9v9vJAa8Or+450T7Zqqlbv/eaitAiq96R+gR4v8Vj9LORFSvQ52AirlVnPEwHPLVJmaltcXpn5uSwBd1s3ddzxPm3xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iFE+w3cY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Zqmk/K4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 12 Jun 2025 13:13:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749734005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ti/p1hE4ZdfJfuF05vJr9LJk0sp0PsHRWOG/G/TObDk=;
	b=iFE+w3cYk0oD9cgfgqaxL9Ncy316Gd3WmOlBrYTD6235cLrU29lCOLhx8xPqWBzyjdBjvw
	An5JFJEKZ2QQBDGTYIZLuUPKHdjz/CgjHyIOebXl+Sj98R/sH7QteqAH3uwe6pJSjcotmz
	rzkYaMQQWMdQutVF2gccyybzBepsPbh0IrVJXQMS0TIBW7el6Jv1F5JZRfFAhUacjhJPHb
	ciJKw02ewX+ZrigCS0AgxyDzS1yEOcdr2QdS3/Y86N//avXG2YXPZ4Z8WliP00kb1pALhX
	fh4+g31NZjP3lZXbJSKyPSL/UDiAWU9N6PRgPZum03u/fP2N66zXp1qeGaDiRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749734005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ti/p1hE4ZdfJfuF05vJr9LJk0sp0PsHRWOG/G/TObDk=;
	b=0Zqmk/K4C+Cg04J+Cc0JiHTDAdvo1S3sdpflWSL+zvff9bxpShDsqGNNRxnn+TTVY304et
	2zwNiEABzLNSaLBA==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip: Use dev_fwnode()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250611104348.192092-10-jirislaby@kernel.org>
References: <20250611104348.192092-10-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174973400435.406.9598053691888029048.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     93174c05dd2e9b02eb6b5c93dd9109087ae4ffcf
Gitweb:        https://git.kernel.org/tip/93174c05dd2e9b02eb6b5c93dd9109087ae4ffcf
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 11 Jun 2025 12:43:38 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 12 Jun 2025 15:08:12 +02:00

irqchip: Use dev_fwnode()

irq_domain_create_simple() takes a fwnode as the first argument. It can be
extracted from struct device using the dev_fwnode() helper instead of using
of_node with of_fwnode_handle().

So use the dev_fwnode() helper.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250611104348.192092-10-jirislaby@kernel.org

---
 drivers/irqchip/irq-imgpdc.c              | 4 ++--
 drivers/irqchip/irq-imx-irqsteer.c        | 4 ++--
 drivers/irqchip/irq-keystone.c            | 4 ++--
 drivers/irqchip/irq-mvebu-pic.c           | 2 +-
 drivers/irqchip/irq-pruss-intc.c          | 2 +-
 drivers/irqchip/irq-renesas-intc-irqpin.c | 6 ++----
 drivers/irqchip/irq-renesas-irqc.c        | 2 +-
 drivers/irqchip/irq-renesas-rza1.c        | 5 ++---
 drivers/irqchip/irq-renesas-rzg2l.c       | 5 ++---
 drivers/irqchip/irq-renesas-rzv2h.c       | 2 +-
 drivers/irqchip/irq-stm32mp-exti.c        | 4 +---
 drivers/irqchip/irq-ti-sci-inta.c         | 3 +--
 drivers/irqchip/irq-ti-sci-intr.c         | 3 +--
 drivers/irqchip/irq-ts4800.c              | 2 +-
 14 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/irqchip/irq-imgpdc.c b/drivers/irqchip/irq-imgpdc.c
index f0410d5..e9ef2f5 100644
--- a/drivers/irqchip/irq-imgpdc.c
+++ b/drivers/irqchip/irq-imgpdc.c
@@ -372,8 +372,8 @@ static int pdc_intc_probe(struct platform_device *pdev)
 	priv->syswake_irq = irq;
 
 	/* Set up an IRQ domain */
-	priv->domain = irq_domain_create_linear(of_fwnode_handle(node), 16, &irq_generic_chip_ops,
-					     priv);
+	priv->domain = irq_domain_create_linear(dev_fwnode(&pdev->dev), 16, &irq_generic_chip_ops,
+						priv);
 	if (unlikely(!priv->domain)) {
 		dev_err(&pdev->dev, "cannot add IRQ domain\n");
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index 6dc9ac4..4682ce5 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -212,8 +212,8 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 	/* steer all IRQs into configured channel */
 	writel_relaxed(BIT(data->channel), data->regs + CHANCTRL);
 
-	data->domain = irq_domain_create_linear(of_fwnode_handle(np), data->reg_num * 32,
-					     &imx_irqsteer_domain_ops, data);
+	data->domain = irq_domain_create_linear(dev_fwnode(&pdev->dev), data->reg_num * 32,
+						&imx_irqsteer_domain_ops, data);
 	if (!data->domain) {
 		dev_err(&pdev->dev, "failed to create IRQ domain\n");
 		ret = -ENOMEM;
diff --git a/drivers/irqchip/irq-keystone.c b/drivers/irqchip/irq-keystone.c
index c9e902b..922fff0 100644
--- a/drivers/irqchip/irq-keystone.c
+++ b/drivers/irqchip/irq-keystone.c
@@ -157,8 +157,8 @@ static int keystone_irq_probe(struct platform_device *pdev)
 	kirq->chip.irq_mask	= keystone_irq_setmask;
 	kirq->chip.irq_unmask	= keystone_irq_unmask;
 
-	kirq->irqd = irq_domain_create_linear(of_fwnode_handle(np), KEYSTONE_N_IRQ,
-					      &keystone_irq_ops, kirq);
+	kirq->irqd = irq_domain_create_linear(dev_fwnode(dev), KEYSTONE_N_IRQ, &keystone_irq_ops,
+					      kirq);
 	if (!kirq->irqd) {
 		dev_err(dev, "IRQ domain registration failed\n");
 		return -ENODEV;
diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index 8db638a..cd8b734 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -150,7 +150,7 @@ static int mvebu_pic_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	pic->domain = irq_domain_create_linear(of_fwnode_handle(node), PIC_MAX_IRQS,
+	pic->domain = irq_domain_create_linear(dev_fwnode(&pdev->dev), PIC_MAX_IRQS,
 					       &mvebu_pic_domain_ops, pic);
 	if (!pic->domain) {
 		dev_err(&pdev->dev, "Failed to allocate irq domain\n");
diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
index 87a5813..81078d5 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -555,7 +555,7 @@ static int pruss_intc_probe(struct platform_device *pdev)
 
 	mutex_init(&intc->lock);
 
-	intc->domain = irq_domain_create_linear(of_fwnode_handle(dev->of_node), max_system_events,
+	intc->domain = irq_domain_create_linear(dev_fwnode(dev), max_system_events,
 						&pruss_intc_irq_domain_ops, intc);
 	if (!intc->domain)
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 0959ed4..117b74b 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -513,10 +513,8 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	irq_chip->irq_set_wake = intc_irqpin_irq_set_wake;
 	irq_chip->flags	= IRQCHIP_MASK_ON_SUSPEND;
 
-	p->irq_domain = irq_domain_create_simple(of_fwnode_handle(dev->of_node),
-						 nirqs, 0,
-						 &intc_irqpin_irq_domain_ops,
-						 p);
+	p->irq_domain = irq_domain_create_simple(dev_fwnode(dev), nirqs, 0,
+						 &intc_irqpin_irq_domain_ops, p);
 	if (!p->irq_domain) {
 		ret = -ENXIO;
 		dev_err(dev, "cannot initialize irq domain\n");
diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 5c3196e..b46bbb6 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -168,7 +168,7 @@ static int irqc_probe(struct platform_device *pdev)
 
 	p->cpu_int_base = p->iomem + IRQC_INT_CPU_BASE(0); /* SYS-SPI */
 
-	p->irq_domain = irq_domain_create_linear(of_fwnode_handle(dev->of_node), p->number_of_irqs,
+	p->irq_domain = irq_domain_create_linear(dev_fwnode(dev), p->number_of_irqs,
 						 &irq_generic_chip_ops, p);
 	if (!p->irq_domain) {
 		ret = -ENXIO;
diff --git a/drivers/irqchip/irq-renesas-rza1.c b/drivers/irqchip/irq-renesas-rza1.c
index 0a9640b..a697eb5 100644
--- a/drivers/irqchip/irq-renesas-rza1.c
+++ b/drivers/irqchip/irq-renesas-rza1.c
@@ -231,9 +231,8 @@ static int rza1_irqc_probe(struct platform_device *pdev)
 	priv->chip.irq_set_type = rza1_irqc_set_type;
 	priv->chip.flags = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_SKIP_SET_WAKE;
 
-	priv->irq_domain = irq_domain_create_hierarchy(parent, 0, IRQC_NUM_IRQ,
-						       of_fwnode_handle(np), &rza1_irqc_domain_ops,
-						       priv);
+	priv->irq_domain = irq_domain_create_hierarchy(parent, 0, IRQC_NUM_IRQ, dev_fwnode(dev),
+						       &rza1_irqc_domain_ops, priv);
 	if (!priv->irq_domain) {
 		dev_err(dev, "cannot initialize irq domain\n");
 		ret = -ENOMEM;
diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 1e861bd..360d886 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -574,9 +574,8 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 
 	raw_spin_lock_init(&rzg2l_irqc_data->lock);
 
-	irq_domain = irq_domain_create_hierarchy(parent_domain, 0, IRQC_NUM_IRQ,
-						 of_fwnode_handle(node), &rzg2l_irqc_domain_ops,
-						 rzg2l_irqc_data);
+	irq_domain = irq_domain_create_hierarchy(parent_domain, 0, IRQC_NUM_IRQ, dev_fwnode(dev),
+						 &rzg2l_irqc_domain_ops, rzg2l_irqc_data);
 	if (!irq_domain) {
 		pm_runtime_put(dev);
 		return dev_err_probe(dev, -ENOMEM, "failed to add irq domain\n");
diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 69b32c1..57c5a3c 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -558,7 +558,7 @@ static int rzv2h_icu_init_common(struct device_node *node, struct device_node *p
 	raw_spin_lock_init(&rzv2h_icu_data->lock);
 
 	irq_domain = irq_domain_create_hierarchy(parent_domain, 0, ICU_NUM_IRQ,
-						 of_fwnode_handle(node), &rzv2h_icu_domain_ops,
+						 dev_fwnode(&pdev->dev), &rzv2h_icu_domain_ops,
 						 rzv2h_icu_data);
 	if (!irq_domain) {
 		dev_err(&pdev->dev, "failed to add irq domain\n");
diff --git a/drivers/irqchip/irq-stm32mp-exti.c b/drivers/irqchip/irq-stm32mp-exti.c
index c6b4407..a24f4f1 100644
--- a/drivers/irqchip/irq-stm32mp-exti.c
+++ b/drivers/irqchip/irq-stm32mp-exti.c
@@ -683,9 +683,7 @@ static int stm32mp_exti_probe(struct platform_device *pdev)
 	}
 
 	domain = irq_domain_create_hierarchy(parent_domain, 0, drv_data->bank_nr * IRQS_PER_BANK,
-					     of_fwnode_handle(np), &stm32mp_exti_domain_ops,
-					     host_data);
-
+					     dev_fwnode(dev), &stm32mp_exti_domain_ops, host_data);
 	if (!domain) {
 		dev_err(dev, "Could not register exti domain\n");
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index 7de5923..01963d3 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -701,8 +701,7 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	domain = irq_domain_create_linear(of_fwnode_handle(dev_of_node(dev)),
-					  ti_sci_get_num_resources(inta->vint),
+	domain = irq_domain_create_linear(dev_fwnode(dev), ti_sci_get_num_resources(inta->vint),
 					  &ti_sci_inta_irq_domain_ops, inta);
 	if (!domain) {
 		dev_err(dev, "Failed to allocate IRQ domain\n");
diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
index 07fff5a..354613e 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -274,8 +274,7 @@ static int ti_sci_intr_irq_domain_probe(struct platform_device *pdev)
 		return PTR_ERR(intr->out_irqs);
 	}
 
-	domain = irq_domain_create_hierarchy(parent_domain, 0, 0,
-					     of_fwnode_handle(dev_of_node(dev)),
+	domain = irq_domain_create_hierarchy(parent_domain, 0, 0, dev_fwnode(dev),
 					     &ti_sci_intr_irq_domain_ops, intr);
 	if (!domain) {
 		dev_err(dev, "Failed to allocate IRQ domain\n");
diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index e625f4f..1e236d5 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -125,7 +125,7 @@ static int ts4800_ic_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	data->domain = irq_domain_create_linear(of_fwnode_handle(node), 8, &ts4800_ic_ops, data);
+	data->domain = irq_domain_create_linear(dev_fwnode(&pdev->dev), 8, &ts4800_ic_ops, data);
 	if (!data->domain) {
 		dev_err(&pdev->dev, "cannot add IRQ domain\n");
 		return -ENOMEM;

