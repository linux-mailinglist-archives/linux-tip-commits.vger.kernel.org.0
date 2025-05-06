Return-Path: <linux-tip-commits+bounces-5304-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F825AAC601
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4BB3B181F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610E128853A;
	Tue,  6 May 2025 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O35bZeuM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8ynqN+Hf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05602874E1;
	Tue,  6 May 2025 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537642; cv=none; b=Ao2d9grhbrUob1PHOScdmcH1VFFIeVQSyuynlHVzqDgOE0biG78IoTY06cffdGgpgWBOD3Vw1naxmzmzrVdIv0SSCNk5oTdLIm37gK8qA4VwZ3086tWrDfk/p7u+itYem0e3ayU8Bzi+8QwADfF+xNUAVOKaeyPHf5hOsbKA664=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537642; c=relaxed/simple;
	bh=sGHE+PNwE+pPcJqEp/g6iQ611bs2xEr8f3JAXmmTNOQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EmAq+G5ZuL1Tyty/VRaP/y6MNVrN1pb2A6lf1LVMip/0ylP8VH248TzNNGHFN10/c/jqtCmXZxhCoEJ3xPpC1vA/SRfIM4U+CKQfAxlob2Bzb8wrh0xH/RpFJCm/mVD++dRoFhAA/T1M+kmaWVQgMoFIf6YAW4K9mJB80w+GXkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O35bZeuM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8ynqN+Hf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537637;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p8LfbocioAJMB02uXEUGp6c/9MGzo0KNkd2Szhjg7Q0=;
	b=O35bZeuM7to8omC9Z40O3QRxz9egt/5vnqSBpPOM/inGzr/PFEWLgCBHzhBpjk56otyMNf
	KMDvdd1pH6SkC+CY+SYp6aiff4Kl71yI/wJRZOxSsfktXZFE5sGJWQ9ZKhARNfcqlGyniD
	eWA7h8dZmF2i/ttvWPBfwacYPVaYjylrxUITM8UJB+iISarGf4uPK7B/a/z0OQEppED1SO
	jn4Z9LtlpzhMhL2bED9xmGNLGynoxo/meGdMUTrflsy0KTChQTYLrBDKyNMUKIoIVtRqW0
	GFxuGb7aGJjKpWERy0scbPsLPIXx6FQWfIDsTaGHWdZ/FepuzHWWMpW5za9+Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537637;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p8LfbocioAJMB02uXEUGp6c/9MGzo0KNkd2Szhjg7Q0=;
	b=8ynqN+Hfugm5wdiKSTtaw7xhlotxQxtK8GJEfMLgsxjyaEH2ZUATxJqDUi2oLHn2d+CDRc
	fYesUsJhYYcV9VAw==
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
Message-ID: <174653763641.406.12819995025325139997.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     322a13f2f1211a138de9fb9cf570f7edf5f093ac
Gitweb:        https://git.kernel.org/tip/322a13f2f1211a138de9fb9cf570f7edf5f093ac
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:10 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:05 +02:00

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
 

