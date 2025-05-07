Return-Path: <linux-tip-commits+bounces-5358-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E42AAD97E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 10:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C5261C06EB4
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 08:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576F9233D9E;
	Wed,  7 May 2025 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QnIfmAdv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UAF795q8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED25F231A2D;
	Wed,  7 May 2025 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604696; cv=none; b=msU8mWhiNRidBU5ZfbTne2B6Y3rKexpKW3LljZNpZMu2xkRrcDDs+snrmPCyvBU+6USCX4UlGy7MPeUwsEDzvnQfKy7EdUU+gq9v2ftEZOn2n2EF77sc1J+hRNvgaa2oGaub5kMdVKKiLFOPlrHi7sMJUY4FWJWE5c6ruRByono=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604696; c=relaxed/simple;
	bh=DYPLgLjIIRYmBKvsJ0icTRohsxETmf/cdYbQnf2bfl4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KFmEp4aIvxzsbLRF2s/4FFChpC1+xuCjx1FuvIN0vEHDMbqagCRkrdwV4OMHDuHpxhjyQeL+QI6clda8bzEY/N7ybSZPSWxyeOorzS3ywQK/zlsOK9Oz7CUELtV5EO15b3ywQjljaU5DHPrI9+bqKthAfpb5W8+k0bKxozZbV1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QnIfmAdv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UAF795q8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:58:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604692;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aR49F/D75jeeLMZ8xXPBMGI0JliLcyOcVeXtF8M6xYU=;
	b=QnIfmAdvxQjyPn8aywDm1h76ZpvLGtsASxDukXW8JvDYQS791tVWfosgMLpJkeIXTmsu2E
	yCgJVVOVf8eOVcm3zv1hRYCobUzLeeWFKa8CwBUr8nJE2927sx/TxfOP6CpT0tOiydeLa4
	YVwD4/nh+WrT2kZvnfPriZNLLXA8yBonyXsPzrf0uTKuOrZEUCYL9qXxKwDZTPU1SlWYNw
	LMUuZYtTsbxwK4RF5+8UWJ2iRcBJQ/7SCD5dUK9FXC5zunW3N5jL4paD8Wt6oYNsx5ZnSs
	PZnbN6WgV4y4dAAeFegVsBiB3DcdY5ZZvIyMtmDJTklwC5xwK0YFhqEtMFSDpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604692;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aR49F/D75jeeLMZ8xXPBMGI0JliLcyOcVeXtF8M6xYU=;
	b=UAF795q8U1NPHHDU1oshVH92gZVVitHamhZZhf4HPjA5sl0UGNbNsx/I3nI52ln5nt4Ko+
	f9SmZnbE4DC81sDQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] gpio: Switch to irq_domain_create_*()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-18-jirislaby@kernel.org>
References: <20250319092951.37667-18-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660469154.406.151900842282637832.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     02226c57602d9a0d0ea37c4c58a6d5975e525961
Gitweb:        https://git.kernel.org/tip/02226c57602d9a0d0ea37c4c58a6d5975e525961
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:10 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:22 +02:00

gpio: Switch to irq_domain_create_*()

irq_domain_add_*() interfaces are going away as being obsolete now.
Switch to the preferred irq_domain_create_*() ones. Those differ in the
node parameter: They take more generic struct fwnode_handle instead of
struct device_node. Therefore, of_fwnode_handle() is added around the
original parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-18-jirislaby@kernel.org

---
 drivers/gpio/gpio-brcmstb.c   | 2 +-
 drivers/gpio/gpio-davinci.c   | 5 ++---
 drivers/gpio/gpio-em.c        | 5 +++--
 drivers/gpio/gpio-grgpio.c    | 2 +-
 drivers/gpio/gpio-lpc18xx.c   | 8 +++-----
 drivers/gpio/gpio-mvebu.c     | 2 +-
 drivers/gpio/gpio-mxc.c       | 2 +-
 drivers/gpio/gpio-mxs.c       | 4 ++--
 drivers/gpio/gpio-pxa.c       | 6 +++---
 drivers/gpio/gpio-rockchip.c  | 2 +-
 drivers/gpio/gpio-sa1100.c    | 2 +-
 drivers/gpio/gpio-sodaville.c | 2 +-
 drivers/gpio/gpio-tb10x.c     | 2 +-
 drivers/gpio/gpio-twl4030.c   | 5 ++---
 include/linux/gpio/driver.h   | 5 +++--
 15 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index ca34729..e7671bc 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -437,7 +437,7 @@ static int brcmstb_gpio_irq_setup(struct platform_device *pdev,
 	int err;
 
 	priv->irq_domain =
-		irq_domain_add_linear(np, priv->num_gpios,
+		irq_domain_create_linear(of_fwnode_handle(np), priv->num_gpios,
 				      &brcmstb_gpio_irq_domain_ops,
 				      priv);
 	if (!priv->irq_domain) {
diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 63fc788..3c3b3ed 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -479,9 +479,8 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 			return irq;
 		}
 
-		irq_domain = irq_domain_add_legacy(dev->of_node, ngpio, irq, 0,
-							&davinci_gpio_irq_ops,
-							chips);
+		irq_domain = irq_domain_create_legacy(of_fwnode_handle(dev->of_node), ngpio, irq, 0,
+						      &davinci_gpio_irq_ops, chips);
 		if (!irq_domain) {
 			dev_err(dev, "Couldn't register an IRQ domain\n");
 			return -ENODEV;
diff --git a/drivers/gpio/gpio-em.c b/drivers/gpio/gpio-em.c
index 6c862c5..8d86f20 100644
--- a/drivers/gpio/gpio-em.c
+++ b/drivers/gpio/gpio-em.c
@@ -323,8 +323,9 @@ static int em_gio_probe(struct platform_device *pdev)
 	irq_chip->irq_release_resources = em_gio_irq_relres;
 	irq_chip->flags	= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND;
 
-	p->irq_domain = irq_domain_add_simple(dev->of_node, ngpios, 0,
-					      &em_gio_irq_domain_ops, p);
+	p->irq_domain = irq_domain_create_simple(of_fwnode_handle(dev->of_node),
+						 ngpios, 0,
+						 &em_gio_irq_domain_ops, p);
 	if (!p->irq_domain) {
 		dev_err(dev, "cannot initialize irq domain\n");
 		return -ENXIO;
diff --git a/drivers/gpio/gpio-grgpio.c b/drivers/gpio/gpio-grgpio.c
index 30a0522..641df8f 100644
--- a/drivers/gpio/gpio-grgpio.c
+++ b/drivers/gpio/gpio-grgpio.c
@@ -397,7 +397,7 @@ static int grgpio_probe(struct platform_device *ofdev)
 			return -EINVAL;
 		}
 
-		priv->domain = irq_domain_add_linear(np, gc->ngpio,
+		priv->domain = irq_domain_create_linear(of_fwnode_handle(np), gc->ngpio,
 						     &grgpio_irq_domain_ops,
 						     priv);
 		if (!priv->domain) {
diff --git a/drivers/gpio/gpio-lpc18xx.c b/drivers/gpio/gpio-lpc18xx.c
index 2cf9fb4..ae6182c 100644
--- a/drivers/gpio/gpio-lpc18xx.c
+++ b/drivers/gpio/gpio-lpc18xx.c
@@ -240,11 +240,9 @@ static int lpc18xx_gpio_pin_ic_probe(struct lpc18xx_gpio_chip *gc)
 
 	raw_spin_lock_init(&ic->lock);
 
-	ic->domain = irq_domain_add_hierarchy(parent_domain, 0,
-					      NR_LPC18XX_GPIO_PIN_IC_IRQS,
-					      dev->of_node,
-					      &lpc18xx_gpio_pin_ic_domain_ops,
-					      ic);
+	ic->domain = irq_domain_create_hierarchy(parent_domain, 0, NR_LPC18XX_GPIO_PIN_IC_IRQS,
+						 of_fwnode_handle(dev->of_node),
+						 &lpc18xx_gpio_pin_ic_domain_ops, ic);
 	if (!ic->domain) {
 		pr_err("unable to add irq domain\n");
 		ret = -ENODEV;
diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 3604abc..4055596 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -1242,7 +1242,7 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 		return 0;
 
 	mvchip->domain =
-	    irq_domain_add_linear(np, ngpios, &irq_generic_chip_ops, NULL);
+	    irq_domain_create_linear(of_fwnode_handle(np), ngpios, &irq_generic_chip_ops, NULL);
 	if (!mvchip->domain) {
 		dev_err(&pdev->dev, "couldn't allocate irq domain %s (DT).\n",
 			mvchip->chip.label);
diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 619b6fb..74bc8f0 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -502,7 +502,7 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 		goto out_bgio;
 	}
 
-	port->domain = irq_domain_add_legacy(np, 32, irq_base, 0,
+	port->domain = irq_domain_create_legacy(of_fwnode_handle(np), 32, irq_base, 0,
 					     &irq_domain_simple_ops, NULL);
 	if (!port->domain) {
 		err = -ENODEV;
diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index 024ad07..b418fbc 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -303,8 +303,8 @@ static int mxs_gpio_probe(struct platform_device *pdev)
 		goto out_iounmap;
 	}
 
-	port->domain = irq_domain_add_legacy(np, 32, irq_base, 0,
-					     &irq_domain_simple_ops, NULL);
+	port->domain = irq_domain_create_legacy(of_fwnode_handle(np), 32, irq_base, 0,
+						&irq_domain_simple_ops, NULL);
 	if (!port->domain) {
 		err = -ENODEV;
 		goto out_iounmap;
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 91cea97..c3dfaed 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -636,9 +636,9 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 	if (!pxa_last_gpio)
 		return -EINVAL;
 
-	pchip->irqdomain = irq_domain_add_legacy(pdev->dev.of_node,
-						 pxa_last_gpio + 1, irq_base,
-						 0, &pxa_irq_domain_ops, pchip);
+	pchip->irqdomain = irq_domain_create_legacy(of_fwnode_handle(pdev->dev.of_node),
+						    pxa_last_gpio + 1, irq_base, 0,
+						    &pxa_irq_domain_ops, pchip);
 	if (!pchip->irqdomain)
 		return -ENOMEM;
 
diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index 01a3b3d..c63352f 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -521,7 +521,7 @@ static int rockchip_interrupts_register(struct rockchip_pin_bank *bank)
 	struct irq_chip_generic *gc;
 	int ret;
 
-	bank->domain = irq_domain_add_linear(bank->of_node, 32,
+	bank->domain = irq_domain_create_linear(of_fwnode_handle(bank->of_node), 32,
 					&irq_generic_chip_ops, NULL);
 	if (!bank->domain) {
 		dev_warn(bank->dev, "could not init irq domain for bank %s\n",
diff --git a/drivers/gpio/gpio-sa1100.c b/drivers/gpio/gpio-sa1100.c
index 242dad7..3f3ee36 100644
--- a/drivers/gpio/gpio-sa1100.c
+++ b/drivers/gpio/gpio-sa1100.c
@@ -319,7 +319,7 @@ void __init sa1100_init_gpio(void)
 
 	gpiochip_add_data(&sa1100_gpio_chip.chip, NULL);
 
-	sa1100_gpio_irqdomain = irq_domain_add_simple(NULL,
+	sa1100_gpio_irqdomain = irq_domain_create_simple(NULL,
 			28, IRQ_GPIO0,
 			&sa1100_gpio_irqdomain_ops, sgc);
 
diff --git a/drivers/gpio/gpio-sodaville.c b/drivers/gpio/gpio-sodaville.c
index c2a2c76..6a3c4c6 100644
--- a/drivers/gpio/gpio-sodaville.c
+++ b/drivers/gpio/gpio-sodaville.c
@@ -169,7 +169,7 @@ static int sdv_register_irqsupport(struct sdv_gpio_chip_data *sd,
 			IRQ_GC_INIT_MASK_CACHE, IRQ_NOREQUEST,
 			IRQ_LEVEL | IRQ_NOPROBE);
 
-	sd->id = irq_domain_add_legacy(pdev->dev.of_node, SDV_NUM_PUB_GPIOS,
+	sd->id = irq_domain_create_legacy(of_fwnode_handle(pdev->dev.of_node), SDV_NUM_PUB_GPIOS,
 				sd->irq_base, 0, &irq_domain_sdv_ops, sd);
 	if (!sd->id)
 		return -ENODEV;
diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index b6335cd..8cf676f 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -183,7 +183,7 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 		if (ret != 0)
 			return ret;
 
-		tb10x_gpio->domain = irq_domain_add_linear(np,
+		tb10x_gpio->domain = irq_domain_create_linear(of_fwnode_handle(np),
 						tb10x_gpio->gc.ngpio,
 						&irq_generic_chip_ops, NULL);
 		if (!tb10x_gpio->domain) {
diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index bcd6922..0d17985 100644
--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@ -502,7 +502,6 @@ static void gpio_twl4030_power_off_action(void *data)
 static int gpio_twl4030_probe(struct platform_device *pdev)
 {
 	struct twl4030_gpio_platform_data *pdata;
-	struct device_node *node = pdev->dev.of_node;
 	struct gpio_twl4030_priv *priv;
 	int ret, irq_base;
 
@@ -524,8 +523,8 @@ static int gpio_twl4030_probe(struct platform_device *pdev)
 		return irq_base;
 	}
 
-	irq_domain_add_legacy(node, TWL4030_GPIO_MAX, irq_base, 0,
-			      &irq_domain_simple_ops, NULL);
+	irq_domain_create_legacy(of_fwnode_handle(pdev->dev.of_node), TWL4030_GPIO_MAX, irq_base, 0,
+				 &irq_domain_simple_ops, NULL);
 
 	ret = twl4030_sih_setup(&pdev->dev, TWL4030_MODULE_GPIO, irq_base);
 	if (ret < 0)
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 4c0294a..b532330 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -287,8 +287,9 @@ struct gpio_irq_chip {
 	/**
 	 * @first:
 	 *
-	 * Required for static IRQ allocation. If set, irq_domain_add_simple()
-	 * will allocate and map all IRQs during initialization.
+	 * Required for static IRQ allocation. If set,
+	 * irq_domain_create_simple() will allocate and map all IRQs
+	 * during initialization.
 	 */
 	unsigned int first;
 

