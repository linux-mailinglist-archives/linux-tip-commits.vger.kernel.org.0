Return-Path: <linux-tip-commits+bounces-1408-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF7A90B51E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 17:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B41B8B3BE09
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 14:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C3A1D2122;
	Mon, 17 Jun 2024 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DasRAdGh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O4l6Kfz2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506CA1D18E0;
	Mon, 17 Jun 2024 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632274; cv=none; b=ht/K5MPHPfGehngNNxWyQYRfMfek06KftvrpYCn948DuP0PZh9jIRmMaW+CV9FhhY81Tf+su9a7nzysK90BBvhvY/mOG+f3sa0dAGrlg42JSUJn8rTF7lmezXcIkvW3O6OqenbBxVU3hIF0WkF4I4NEC2+5atqQJ2MGFJJ5MBQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632274; c=relaxed/simple;
	bh=KWhLUbg2NObl4tKvt42RnKQIS5e4wbA1LE8EYlnl9cs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AsqsCIyfnpVn/N1r7epkh76AtOFvxTcTshd4xR6IyuRCVMvIVF7jFm2rSJLhAXJM6aIpOSW4HUSbtw0shDjx83SEY0e6b3ySNVJNVRBlesn/tx1vMeja6OdIcLV2bqCQjYArGvswS8G7I7PWO8H0w+Gkc3MxmOAdoOZgYpd/zUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DasRAdGh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O4l6Kfz2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 13:51:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718632268;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o8mXQsAfysFqBQZtSJVdc7YLqaz/SeezqV6frDdm0rE=;
	b=DasRAdGhUF5Y/Blqunr+CYYhnwHW1k66tRWYs+XNXH+V3Ij1huvcop7cHdN/iqlMlzXAaI
	L48kwGxpwLa+CX95XDRNeK2OAJMjdKsN6uxC0xMQKEehrqqxggX0KC9JDCwm9jVlXuKSPv
	bZaMYQK/TTsSPgu+5DWco2qKuQEyvW6jxVzFU6UOwOyroI+dhOQz0Gyr/8fGHFFXSUaLjd
	vkKeWeXJ2OuemicsvxSvV4F1DPy1XZFCgC7hyBgNAJq2t1ct3Kw3iHGjLgrPWTW7dDK6A+
	Zarn9jcIvNUpx2ZHUaD9nDm1aBc64gJfT/zYenSMqNBhjKlO7aK5dcjm4z0MVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632268;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o8mXQsAfysFqBQZtSJVdc7YLqaz/SeezqV6frDdm0rE=;
	b=O4l6Kfz25WOoeJvifTVsOLnALRc9jM0hlgCLsfCwruiqOHWFHhWJIm+HoMyxY2amgshFi4
	cjYB6ptTfu1XT2Cg==
From: "tip-bot2 for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: Add support for LAN966x OIC
Cc: Herve Codina <herve.codina@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240614173232.1184015-23-herve.codina@bootlin.com>
References: <20240614173232.1184015-23-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863226792.10875.14898578344708914955.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3e3a7b35332924c8ade696c4b24735561ee6aea3
Gitweb:        https://git.kernel.org/tip/3e3a7b35332924c8ade696c4b24735561ee=
6aea3
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Fri, 14 Jun 2024 19:32:23 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:48:15 +02:00

irqchip: Add support for LAN966x OIC

The Microchip LAN966x outband interrupt controller (OIC) maps the
internal interrupt sources of the LAN966x device to an external
interrupt.
When the LAN966x device is used as a PCI device, the external interrupt
is routed to the PCI interrupt.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240614173232.1184015-23-herve.codina@bootli=
n.com

---
 drivers/irqchip/Kconfig           |  12 +-
 drivers/irqchip/Makefile          |   1 +-
 drivers/irqchip/irq-lan966x-oic.c | 278 +++++++++++++++++++++++++++++-
 3 files changed, 291 insertions(+)
 create mode 100644 drivers/irqchip/irq-lan966x-oic.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 1446471..348f345 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -169,6 +169,18 @@ config IXP4XX_IRQ
 	select IRQ_DOMAIN
 	select SPARSE_IRQ
=20
+config LAN966X_OIC
+	tristate "Microchip LAN966x OIC Support"
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+	help
+	  Enable support for the LAN966x Outbound Interrupt Controller.
+	  This controller is present on the Microchip LAN966x PCI device and
+	  maps the internal interrupts sources to PCIe interrupt.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called irq-lan966x-oic.
+
 config MADERA_IRQ
 	tristate
=20
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d9dc3d9..9f6f882 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -104,6 +104,7 @@ obj-$(CONFIG_IMX_IRQSTEER)		+=3D irq-imx-irqsteer.o
 obj-$(CONFIG_IMX_INTMUX)		+=3D irq-imx-intmux.o
 obj-$(CONFIG_IMX_MU_MSI)		+=3D irq-imx-mu-msi.o
 obj-$(CONFIG_MADERA_IRQ)		+=3D irq-madera.o
+obj-$(CONFIG_LAN966X_OIC)		+=3D irq-lan966x-oic.o
 obj-$(CONFIG_LS1X_IRQ)			+=3D irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+=3D irq-ti-sci-intr.o
 obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+=3D irq-ti-sci-inta.o
diff --git a/drivers/irqchip/irq-lan966x-oic.c b/drivers/irqchip/irq-lan966x-=
oic.c
new file mode 100644
index 0000000..41ac880
--- /dev/null
+++ b/drivers/irqchip/irq-lan966x-oic.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the Microchip LAN966x outbound interrupt controller
+ *
+ * Copyright (c) 2024 Technology Inc. and its subsidiaries.
+ *
+ * Authors:
+ *	Horatiu Vultur <horatiu.vultur@microchip.com>
+ *	Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
+ *	Herve Codina <herve.codina@bootlin.com>
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip.h>
+#include <linux/irq.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+struct lan966x_oic_chip_regs {
+	int reg_off_ena_set;
+	int reg_off_ena_clr;
+	int reg_off_sticky;
+	int reg_off_ident;
+	int reg_off_map;
+};
+
+struct lan966x_oic_data {
+	void __iomem	*regs;
+	int		irq;
+};
+
+#define LAN966X_OIC_NR_IRQ 86
+
+/* Interrupt sticky status */
+#define LAN966X_OIC_INTR_STICKY		0x30
+#define LAN966X_OIC_INTR_STICKY1	0x34
+#define LAN966X_OIC_INTR_STICKY2	0x38
+
+/* Interrupt enable */
+#define LAN966X_OIC_INTR_ENA		0x48
+#define LAN966X_OIC_INTR_ENA1		0x4c
+#define LAN966X_OIC_INTR_ENA2		0x50
+
+/* Atomic clear of interrupt enable */
+#define LAN966X_OIC_INTR_ENA_CLR	0x54
+#define LAN966X_OIC_INTR_ENA_CLR1	0x58
+#define LAN966X_OIC_INTR_ENA_CLR2	0x5c
+
+/* Atomic set of interrupt */
+#define LAN966X_OIC_INTR_ENA_SET	0x60
+#define LAN966X_OIC_INTR_ENA_SET1	0x64
+#define LAN966X_OIC_INTR_ENA_SET2	0x68
+
+/* Mapping of source to destination interrupts (_n =3D 0..8) */
+#define LAN966X_OIC_DST_INTR_MAP(_n)	(0x78 + (_n) * 4)
+#define LAN966X_OIC_DST_INTR_MAP1(_n)	(0x9c + (_n) * 4)
+#define LAN966X_OIC_DST_INTR_MAP2(_n)	(0xc0 + (_n) * 4)
+
+/* Currently active interrupt sources per destination (_n =3D 0..8) */
+#define LAN966X_OIC_DST_INTR_IDENT(_n)	(0xe4 + (_n) * 4)
+#define LAN966X_OIC_DST_INTR_IDENT1(_n)	(0x108 + (_n) * 4)
+#define LAN966X_OIC_DST_INTR_IDENT2(_n)	(0x12c + (_n) * 4)
+
+static unsigned int lan966x_oic_irq_startup(struct irq_data *data)
+{
+	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(data);
+	struct irq_chip_type *ct =3D irq_data_get_chip_type(data);
+	struct lan966x_oic_chip_regs *chip_regs =3D gc->private;
+	u32 map;
+
+	irq_gc_lock(gc);
+
+	/* Map the source interrupt to the destination */
+	map =3D irq_reg_readl(gc, chip_regs->reg_off_map);
+	map |=3D data->mask;
+	irq_reg_writel(gc, map, chip_regs->reg_off_map);
+
+	irq_gc_unlock(gc);
+
+	ct->chip.irq_ack(data);
+	ct->chip.irq_unmask(data);
+
+	return 0;
+}
+
+static void lan966x_oic_irq_shutdown(struct irq_data *data)
+{
+	struct irq_chip_generic *gc =3D irq_data_get_irq_chip_data(data);
+	struct irq_chip_type *ct =3D irq_data_get_chip_type(data);
+	struct lan966x_oic_chip_regs *chip_regs =3D gc->private;
+	u32 map;
+
+	ct->chip.irq_mask(data);
+
+	irq_gc_lock(gc);
+
+	/* Unmap the interrupt */
+	map =3D irq_reg_readl(gc, chip_regs->reg_off_map);
+	map &=3D ~data->mask;
+	irq_reg_writel(gc, map, chip_regs->reg_off_map);
+
+	irq_gc_unlock(gc);
+}
+
+static int lan966x_oic_irq_set_type(struct irq_data *data,
+				    unsigned int flow_type)
+{
+	if (flow_type !=3D IRQ_TYPE_LEVEL_HIGH) {
+		pr_err("lan966x oic doesn't support flow type %d\n", flow_type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void lan966x_oic_irq_handler_domain(struct irq_domain *d, u32 first_i=
rq)
+{
+	struct irq_chip_generic *gc =3D irq_get_domain_generic_chip(d, first_irq);
+	struct lan966x_oic_chip_regs *chip_regs =3D gc->private;
+	unsigned long ident;
+	unsigned int hwirq;
+
+	ident =3D irq_reg_readl(gc, chip_regs->reg_off_ident);
+	if (!ident)
+		return;
+
+	for_each_set_bit(hwirq, &ident, 32)
+		generic_handle_domain_irq(d, hwirq + first_irq);
+}
+
+static void lan966x_oic_irq_handler(struct irq_desc *desc)
+{
+	struct irq_domain *d =3D irq_desc_get_handler_data(desc);
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
+
+	chained_irq_enter(chip, desc);
+	lan966x_oic_irq_handler_domain(d, 0);
+	lan966x_oic_irq_handler_domain(d, 32);
+	lan966x_oic_irq_handler_domain(d, 64);
+	chained_irq_exit(chip, desc);
+}
+
+static struct lan966x_oic_chip_regs lan966x_oic_chip_regs[3] =3D {
+	{
+		.reg_off_ena_set =3D LAN966X_OIC_INTR_ENA_SET,
+		.reg_off_ena_clr =3D LAN966X_OIC_INTR_ENA_CLR,
+		.reg_off_sticky  =3D LAN966X_OIC_INTR_STICKY,
+		.reg_off_ident   =3D LAN966X_OIC_DST_INTR_IDENT(0),
+		.reg_off_map     =3D LAN966X_OIC_DST_INTR_MAP(0),
+	}, {
+		.reg_off_ena_set =3D LAN966X_OIC_INTR_ENA_SET1,
+		.reg_off_ena_clr =3D LAN966X_OIC_INTR_ENA_CLR1,
+		.reg_off_sticky  =3D LAN966X_OIC_INTR_STICKY1,
+		.reg_off_ident   =3D LAN966X_OIC_DST_INTR_IDENT1(0),
+		.reg_off_map     =3D LAN966X_OIC_DST_INTR_MAP1(0),
+	}, {
+		.reg_off_ena_set =3D LAN966X_OIC_INTR_ENA_SET2,
+		.reg_off_ena_clr =3D LAN966X_OIC_INTR_ENA_CLR2,
+		.reg_off_sticky  =3D LAN966X_OIC_INTR_STICKY2,
+		.reg_off_ident   =3D LAN966X_OIC_DST_INTR_IDENT2(0),
+		.reg_off_map     =3D LAN966X_OIC_DST_INTR_MAP2(0),
+	}
+};
+
+static int lan966x_oic_chip_init(struct irq_chip_generic *gc)
+{
+	struct lan966x_oic_data *lan966x_oic =3D gc->domain->host_data;
+	struct lan966x_oic_chip_regs *chip_regs;
+
+	chip_regs =3D &lan966x_oic_chip_regs[gc->irq_base / 32];
+
+	gc->reg_base =3D lan966x_oic->regs;
+	gc->chip_types[0].regs.enable =3D chip_regs->reg_off_ena_set;
+	gc->chip_types[0].regs.disable =3D chip_regs->reg_off_ena_clr;
+	gc->chip_types[0].regs.ack =3D chip_regs->reg_off_sticky;
+	gc->chip_types[0].chip.irq_startup =3D lan966x_oic_irq_startup;
+	gc->chip_types[0].chip.irq_shutdown =3D lan966x_oic_irq_shutdown;
+	gc->chip_types[0].chip.irq_set_type =3D lan966x_oic_irq_set_type;
+	gc->chip_types[0].chip.irq_mask =3D irq_gc_mask_disable_reg;
+	gc->chip_types[0].chip.irq_unmask =3D irq_gc_unmask_enable_reg;
+	gc->chip_types[0].chip.irq_ack =3D irq_gc_ack_set_bit;
+	gc->private =3D chip_regs;
+
+	/* Disable all interrupts handled by this chip */
+	irq_reg_writel(gc, ~0U, chip_regs->reg_off_ena_clr);
+
+	return 0;
+}
+
+static void lan966x_oic_chip_exit(struct irq_chip_generic *gc)
+{
+	/* Disable and ack all interrupts handled by this chip */
+	irq_reg_writel(gc, ~0U, gc->chip_types[0].regs.disable);
+	irq_reg_writel(gc, ~0U, gc->chip_types[0].regs.ack);
+}
+
+static int lan966x_oic_domain_init(struct irq_domain *d)
+{
+	struct lan966x_oic_data *lan966x_oic =3D d->host_data;
+
+	irq_set_chained_handler_and_data(lan966x_oic->irq, lan966x_oic_irq_handler,=
 d);
+
+	return 0;
+}
+
+static void lan966x_oic_domain_exit(struct irq_domain *d)
+{
+	struct lan966x_oic_data *lan966x_oic =3D d->host_data;
+
+	irq_set_chained_handler_and_data(lan966x_oic->irq, NULL, NULL);
+}
+
+static int lan966x_oic_probe(struct platform_device *pdev)
+{
+	struct irq_domain_chip_generic_info dgc_info =3D {
+		.name		=3D "lan966x-oic",
+		.handler	=3D handle_level_irq,
+		.irqs_per_chip	=3D 32,
+		.num_ct		=3D 1,
+		.init		=3D lan966x_oic_chip_init,
+		.exit		=3D lan966x_oic_chip_exit,
+	};
+	struct irq_domain_info d_info =3D {
+		.fwnode		=3D of_node_to_fwnode(pdev->dev.of_node),
+		.domain_flags	=3D IRQ_DOMAIN_FLAG_DESTROY_GC,
+		.size		=3D LAN966X_OIC_NR_IRQ,
+		.hwirq_max	=3D LAN966X_OIC_NR_IRQ,
+		.ops		=3D &irq_generic_chip_ops,
+		.dgc_info	=3D &dgc_info,
+		.init		=3D lan966x_oic_domain_init,
+		.exit		=3D lan966x_oic_domain_exit,
+	};
+	struct lan966x_oic_data *lan966x_oic;
+	struct device *dev =3D &pdev->dev;
+	struct irq_domain *domain;
+
+	lan966x_oic =3D devm_kmalloc(dev, sizeof(*lan966x_oic), GFP_KERNEL);
+	if (!lan966x_oic)
+		return -ENOMEM;
+
+	lan966x_oic->regs =3D devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(lan966x_oic->regs))
+		return dev_err_probe(dev, PTR_ERR(lan966x_oic->regs),
+				     "failed to map resource\n");
+
+	lan966x_oic->irq =3D platform_get_irq(pdev, 0);
+	if (lan966x_oic->irq < 0)
+		return dev_err_probe(dev, lan966x_oic->irq, "failed to get the IRQ\n");
+
+	d_info.host_data =3D lan966x_oic;
+	domain =3D devm_irq_domain_instantiate(dev, &d_info);
+	if (IS_ERR(domain))
+		return dev_err_probe(dev, PTR_ERR(domain),
+				     "failed to instantiate the IRQ domain\n");
+	return 0;
+}
+
+static const struct of_device_id lan966x_oic_of_match[] =3D {
+	{ .compatible =3D "microchip,lan966x-oic" },
+	{} /* sentinel */
+};
+MODULE_DEVICE_TABLE(of, lan966x_oic_of_match);
+
+static struct platform_driver lan966x_oic_driver =3D {
+	.probe =3D lan966x_oic_probe,
+	.driver =3D {
+		.name =3D "lan966x-oic",
+		.of_match_table =3D lan966x_oic_of_match,
+	},
+};
+module_platform_driver(lan966x_oic_driver);
+
+MODULE_AUTHOR("Herve Codina <herve.codina@bootlin.com>");
+MODULE_DESCRIPTION("Microchip LAN966x OIC driver");
+MODULE_LICENSE("GPL");

