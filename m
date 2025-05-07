Return-Path: <linux-tip-commits+bounces-5442-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93002AAE12F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 15:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673A517A5DF
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 13:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFC228C00C;
	Wed,  7 May 2025 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zpSCK5wI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jx/jdV6N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE8528B7EF;
	Wed,  7 May 2025 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625464; cv=none; b=JviVAGLZ0RgzrudSJq+WB8HZt5sf3izV/7h2N9IqOsU31WQ+NZwFfrb0Q9mJ1XwLX8VC+wDXeQQmO1mAET1TyePLFOjSx5PwV9MpU3JiQJohsVlB+gywVvE4ky+dWkfZNPaS5TBLEV8JFpIiRJko/i+ra9xQWzjE3kTODgl0z/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625464; c=relaxed/simple;
	bh=hSYEfFFXt9m/h/oHlyaAcf17l+MCpwcMUo4F1g7BL54=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UNASE76Cb87Jcssj95sobJuy2P4kzK6GlAoKvdrCiSDeV4UCE6rSZ2gIeDfxdSrgahXPl/QzKb19kgwcsS2u1iDeN6jrz4DVmYgkdp/kyGQtkl+c9qF+2bAJGLmMWq5i7lWqR7N5IEwYfLbjrRi1PY3nNe7irVGVZuzlpnQSBWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zpSCK5wI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jx/jdV6N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 13:44:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746625460;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IDh8CnHRwQobg9tYwmKQ8tdfTUbPJ4FtgE1PR85kI3Y=;
	b=zpSCK5wIyHerhJQJrOeSbdsJjNhUI5PFHjYrit+NOwcvi7Fpo61fYxWopPJL+JFrELafdH
	MbAWkuCgktiesPd45x+eWlkVvGyxcmOmDmDEuWYLm7rmDq/5VPovxjfeUKjtmAIHrvrRHj
	D8ak7O4bK5n16Sm3X+4VDJ67vEAg/KFuJlGBRnEjfsMVxkmJrs4Ukj6GChU6L2mhkMmwBQ
	ef2x4lIc4Z4Rt/REMBkAdbHOyeYAKEuRVlmdXDkL+cshH3DhGF7Y0pXLNdxXXwrTV7FZ/Q
	54aKMODiX4ahmvhwNZg7Na/4xEf97NopYUiJKS9SfK5HSrpg0EMS8CX5ZOzDhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746625460;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IDh8CnHRwQobg9tYwmKQ8tdfTUbPJ4FtgE1PR85kI3Y=;
	b=jx/jdV6NkUkQznWhD9viwD1SXjXpaFlUMOFQXgJn0RkPQG9qMzGqMQvHSe/smajV16D9d5
	x0SEx1GgcIflfPDQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] net: Switch to irq_domain_create_*()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-28-jirislaby@kernel.org>
References: <20250319092951.37667-28-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174662545993.406.12651929610072140469.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     7803d23934b57bb24ef11f952be62348b70b4b88
Gitweb:        https://git.kernel.org/tip/7803d23934b57bb24ef11f952be62348b70b4b88
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 15:39:39 +02:00

net: Switch to irq_domain_create_*()

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
Link: https://lore.kernel.org/all/20250319092951.37667-28-jirislaby@kernel.org


---
 drivers/net/dsa/microchip/ksz_common.c         |  5 +++--
 drivers/net/dsa/microchip/ksz_ptp.c            |  4 ++--
 drivers/net/dsa/mv88e6xxx/chip.c               |  2 +-
 drivers/net/dsa/mv88e6xxx/global2.c            |  6 ++++--
 drivers/net/dsa/qca/ar9331.c                   |  4 ++--
 drivers/net/dsa/realtek/rtl8365mb.c            |  4 ++--
 drivers/net/dsa/realtek/rtl8366rb.c            |  6 ++----
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c |  4 ++--
 drivers/net/usb/lan78xx.c                      |  9 ++++-----
 9 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 89f0796..579ee50 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2697,8 +2697,9 @@ static int ksz_irq_common_setup(struct ksz_device *dev, struct ksz_irq *kirq)
 	kirq->dev = dev;
 	kirq->masked = ~0;
 
-	kirq->domain = irq_domain_add_simple(dev->dev->of_node, kirq->nirqs, 0,
-					     &ksz_irq_domain_ops, kirq);
+	kirq->domain = irq_domain_create_simple(of_fwnode_handle(dev->dev->of_node),
+						kirq->nirqs, 0,
+						&ksz_irq_domain_ops, kirq);
 	if (!kirq->domain)
 		return -ENOMEM;
 
diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 22fb9ef..992101e 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1136,8 +1136,8 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
 
 	init_completion(&port->tstamp_msg_comp);
 
-	ptpirq->domain = irq_domain_add_linear(dev->dev->of_node, ptpirq->nirqs,
-					       &ksz_ptp_irq_domain_ops, ptpirq);
+	ptpirq->domain = irq_domain_create_linear(of_fwnode_handle(dev->dev->of_node),
+						  ptpirq->nirqs, &ksz_ptp_irq_domain_ops, ptpirq);
 	if (!ptpirq->domain)
 		return -ENOMEM;
 
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 29a89ab..dd616eb 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -297,7 +297,7 @@ static int mv88e6xxx_g1_irq_setup_common(struct mv88e6xxx_chip *chip)
 	u16 reg, mask;
 
 	chip->g1_irq.nirqs = chip->info->g1_irqs;
-	chip->g1_irq.domain = irq_domain_add_simple(
+	chip->g1_irq.domain = irq_domain_create_simple(
 		NULL, chip->g1_irq.nirqs, 0,
 		&mv88e6xxx_g1_irq_domain_ops, chip);
 	if (!chip->g1_irq.domain)
diff --git a/drivers/net/dsa/mv88e6xxx/global2.c b/drivers/net/dsa/mv88e6xxx/global2.c
index b2b5f6b..aaf97c1 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.c
+++ b/drivers/net/dsa/mv88e6xxx/global2.c
@@ -1154,8 +1154,10 @@ int mv88e6xxx_g2_irq_setup(struct mv88e6xxx_chip *chip)
 	if (err)
 		return err;
 
-	chip->g2_irq.domain = irq_domain_add_simple(
-		chip->dev->of_node, 16, 0, &mv88e6xxx_g2_irq_domain_ops, chip);
+	chip->g2_irq.domain = irq_domain_create_simple(of_fwnode_handle(chip->dev->of_node),
+						       16, 0,
+						       &mv88e6xxx_g2_irq_domain_ops,
+						       chip);
 	if (!chip->g2_irq.domain)
 		return -ENOMEM;
 
diff --git a/drivers/net/dsa/qca/ar9331.c b/drivers/net/dsa/qca/ar9331.c
index e9f2c67..79a2967 100644
--- a/drivers/net/dsa/qca/ar9331.c
+++ b/drivers/net/dsa/qca/ar9331.c
@@ -821,8 +821,8 @@ static int ar9331_sw_irq_init(struct ar9331_sw_priv *priv)
 		return ret;
 	}
 
-	priv->irqdomain = irq_domain_add_linear(np, 1, &ar9331_sw_irqdomain_ops,
-						priv);
+	priv->irqdomain = irq_domain_create_linear(of_fwnode_handle(np), 1,
+						   &ar9331_sw_irqdomain_ops, priv);
 	if (!priv->irqdomain) {
 		dev_err(dev, "failed to create IRQ domain\n");
 		return -EINVAL;
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 7e96355..964a56e 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -1719,8 +1719,8 @@ static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 		goto out_put_node;
 	}
 
-	priv->irqdomain = irq_domain_add_linear(intc, priv->num_ports,
-						&rtl8365mb_irqdomain_ops, priv);
+	priv->irqdomain = irq_domain_create_linear(of_fwnode_handle(intc), priv->num_ports,
+						   &rtl8365mb_irqdomain_ops, priv);
 	if (!priv->irqdomain) {
 		dev_err(priv->dev, "failed to add irq domain\n");
 		ret = -ENOMEM;
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index f54771c..8bdb52b 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -550,10 +550,8 @@ static int rtl8366rb_setup_cascaded_irq(struct realtek_priv *priv)
 		dev_err(priv->dev, "unable to request irq: %d\n", ret);
 		goto out_put_node;
 	}
-	priv->irqdomain = irq_domain_add_linear(intc,
-						RTL8366RB_NUM_INTERRUPT,
-						&rtl8366rb_irqdomain_ops,
-						priv);
+	priv->irqdomain = irq_domain_create_linear(of_fwnode_handle(intc), RTL8366RB_NUM_INTERRUPT,
+						   &rtl8366rb_irqdomain_ops, priv);
 	if (!priv->irqdomain) {
 		dev_err(priv->dev, "failed to create IRQ domain\n");
 		ret = -EINVAL;
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index 8658a51..f2c2bd2 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -184,8 +184,8 @@ int txgbe_setup_misc_irq(struct txgbe *txgbe)
 		goto skip_sp_irq;
 
 	txgbe->misc.nirqs = 1;
-	txgbe->misc.domain = irq_domain_add_simple(NULL, txgbe->misc.nirqs, 0,
-						   &txgbe_misc_irq_domain_ops, txgbe);
+	txgbe->misc.domain = irq_domain_create_simple(NULL, txgbe->misc.nirqs, 0,
+						      &txgbe_misc_irq_domain_ops, txgbe);
 	if (!txgbe->misc.domain)
 		return -ENOMEM;
 
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index e4f1663..3e8025a 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2456,14 +2456,11 @@ static struct irq_chip lan78xx_irqchip = {
 
 static int lan78xx_setup_irq_domain(struct lan78xx_net *dev)
 {
-	struct device_node *of_node;
 	struct irq_domain *irqdomain;
 	unsigned int irqmap = 0;
 	u32 buf;
 	int ret = 0;
 
-	of_node = dev->udev->dev.parent->of_node;
-
 	mutex_init(&dev->domain_data.irq_lock);
 
 	ret = lan78xx_read_reg(dev, INT_EP_CTL, &buf);
@@ -2475,8 +2472,10 @@ static int lan78xx_setup_irq_domain(struct lan78xx_net *dev)
 	dev->domain_data.irqchip = &lan78xx_irqchip;
 	dev->domain_data.irq_handler = handle_simple_irq;
 
-	irqdomain = irq_domain_add_simple(of_node, MAX_INT_EP, 0,
-					  &chip_domain_ops, &dev->domain_data);
+	irqdomain = irq_domain_create_simple(of_fwnode_handle(dev->udev->dev.parent->of_node),
+					     MAX_INT_EP, 0,
+					     &chip_domain_ops,
+					     &dev->domain_data);
 	if (irqdomain) {
 		/* create mapping for PHY interrupt */
 		irqmap = irq_create_mapping(irqdomain, INT_EP_PHY);

