Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FD828A905
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 20:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbgJKSAY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 14:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388402AbgJKR52 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7206C0613CE;
        Sun, 11 Oct 2020 10:57:27 -0700 (PDT)
Date:   Sun, 11 Oct 2020 17:57:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439046;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aF7henNcFpzWLPhXNewtilOwQXPXskljaR3EMm36TGE=;
        b=u18KiwryouqRpn7maz+e5pFSrblzuARiynvs+IgSq6zGep23KDzgE+bhdtNuyhFjTslkdF
        9uAzTZ7tylpj/SZklew5U9DxGVdofsw4aCMm5TTpoWimhYMwhGxAYfVSuAmp21yT7Tdjmm
        vWPp/VvoJjvI1nLEC7ceg1AG9H/EDMuimbdR8pSNAh2vUbgFxThbaB6kS9KNuoU1k//OnM
        z3OAYE7a92eagWY2j9AgiR9+thWKz+w2NvnM49aUQKK3vqnbH6eLsoH/rBvGTxiuK3NjZ7
        lTVJvteWa59YVfsgVkI8zX/x5j6xZGIP2nb806P9uACYgy06HxDpvOdLX3akFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439046;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aF7henNcFpzWLPhXNewtilOwQXPXskljaR3EMm36TGE=;
        b=j4ntjn6h9hQ623Egjhu5PxzIPmuLRyVv/qDl0QQJP31k89wvkWNXRGy/tsG9uPsn4F5tAD
        UqCltEd1/9DSxaBg==
From:   "tip-bot2 for Cristian Ciocaltea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: Add Actions Semi Owl SIRQ controller
Cc:     Parthiban Nallathambi <pn@denx.de>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3C1a010ef0eb78831b5657d74a0fcdef7a8efb2ec4=2E16001?=
 =?utf-8?q?14378=2Egit=2Ecristian=2Eciocaltea=40gmail=2Ecom=3E?=
References: =?utf-8?q?=3C1a010ef0eb78831b5657d74a0fcdef7a8efb2ec4=2E160011?=
 =?utf-8?q?4378=2Egit=2Ecristian=2Eciocaltea=40gmail=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <160243904532.7002.15523630859842279380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     27e9e554b01fea686929598556cb7f73a70fb964
Gitweb:        https://git.kernel.org/tip/27e9e554b01fea686929598556cb7f73a70fb964
Author:        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
AuthorDate:    Mon, 14 Sep 2020 23:27:18 +03:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 25 Sep 2020 16:57:33 +01:00

irqchip: Add Actions Semi Owl SIRQ controller

This interrupt controller is found in the Actions Semi Owl SoCs (S500,
S700 and S900) and provides support for handling up to 3 external
interrupt lines.

Each line can be independently configured as interrupt and triggers on
either of the edges or either of the levels. Additionally, each line
can also be masked individually.

Co-developed-by: Parthiban Nallathambi <pn@denx.de>
Co-developed-by: Saravanan Sekar <sravanhome@gmail.com>
Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1a010ef0eb78831b5657d74a0fcdef7a8efb2ec4.1600114378.git.cristian.ciocaltea@gmail.com
---
 drivers/irqchip/Makefile       |   1 +-
 drivers/irqchip/irq-owl-sirq.c | 359 ++++++++++++++++++++++++++++++++-
 2 files changed, 360 insertions(+)
 create mode 100644 drivers/irqchip/irq-owl-sirq.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 133f9c4..b8eb5b8 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_ATH79)			+= irq-ath79-cpu.o
 obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
+obj-$(CONFIG_ARCH_ACTIONS)		+= irq-owl-sirq.o
 obj-$(CONFIG_DAVINCI_AINTC)		+= irq-davinci-aintc.o
 obj-$(CONFIG_DAVINCI_CP_INTC)		+= irq-davinci-cp-intc.o
 obj-$(CONFIG_EXYNOS_IRQ_COMBINER)	+= exynos-combiner.o
diff --git a/drivers/irqchip/irq-owl-sirq.c b/drivers/irqchip/irq-owl-sirq.c
new file mode 100644
index 0000000..6e41274
--- /dev/null
+++ b/drivers/irqchip/irq-owl-sirq.c
@@ -0,0 +1,359 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Actions Semi Owl SoCs SIRQ interrupt controller driver
+ *
+ * Copyright (C) 2014 Actions Semi Inc.
+ * David Liu <liuwei@actions-semi.com>
+ *
+ * Author: Parthiban Nallathambi <pn@denx.de>
+ * Author: Saravanan Sekar <sravanhome@gmail.com>
+ * Author: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/interrupt.h>
+#include <linux/irqchip.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#define NUM_SIRQ			3
+
+#define INTC_EXTCTL_PENDING		BIT(0)
+#define INTC_EXTCTL_CLK_SEL		BIT(4)
+#define INTC_EXTCTL_EN			BIT(5)
+#define INTC_EXTCTL_TYPE_MASK		GENMASK(7, 6)
+#define INTC_EXTCTL_TYPE_HIGH		0
+#define INTC_EXTCTL_TYPE_LOW		BIT(6)
+#define INTC_EXTCTL_TYPE_RISING		BIT(7)
+#define INTC_EXTCTL_TYPE_FALLING	(BIT(6) | BIT(7))
+
+/* S500 & S700 SIRQ control register masks */
+#define INTC_EXTCTL_SIRQ0_MASK		GENMASK(23, 16)
+#define INTC_EXTCTL_SIRQ1_MASK		GENMASK(15, 8)
+#define INTC_EXTCTL_SIRQ2_MASK		GENMASK(7, 0)
+
+/* S900 SIRQ control register offsets, relative to controller base address */
+#define INTC_EXTCTL0			0x0000
+#define INTC_EXTCTL1			0x0328
+#define INTC_EXTCTL2			0x032c
+
+struct owl_sirq_params {
+	/* INTC_EXTCTL reg shared for all three SIRQ lines */
+	bool reg_shared;
+	/* INTC_EXTCTL reg offsets relative to controller base address */
+	u16 reg_offset[NUM_SIRQ];
+};
+
+struct owl_sirq_chip_data {
+	const struct owl_sirq_params	*params;
+	void __iomem			*base;
+	raw_spinlock_t			lock;
+	u32				ext_irqs[NUM_SIRQ];
+};
+
+/* S500 & S700 SoCs */
+static const struct owl_sirq_params owl_sirq_s500_params = {
+	.reg_shared = true,
+	.reg_offset = { 0, 0, 0 },
+};
+
+/* S900 SoC */
+static const struct owl_sirq_params owl_sirq_s900_params = {
+	.reg_shared = false,
+	.reg_offset = { INTC_EXTCTL0, INTC_EXTCTL1, INTC_EXTCTL2 },
+};
+
+static u32 owl_field_get(u32 val, u32 index)
+{
+	switch (index) {
+	case 0:
+		return FIELD_GET(INTC_EXTCTL_SIRQ0_MASK, val);
+	case 1:
+		return FIELD_GET(INTC_EXTCTL_SIRQ1_MASK, val);
+	case 2:
+	default:
+		return FIELD_GET(INTC_EXTCTL_SIRQ2_MASK, val);
+	}
+}
+
+static u32 owl_field_prep(u32 val, u32 index)
+{
+	switch (index) {
+	case 0:
+		return FIELD_PREP(INTC_EXTCTL_SIRQ0_MASK, val);
+	case 1:
+		return FIELD_PREP(INTC_EXTCTL_SIRQ1_MASK, val);
+	case 2:
+	default:
+		return FIELD_PREP(INTC_EXTCTL_SIRQ2_MASK, val);
+	}
+}
+
+static u32 owl_sirq_read_extctl(struct owl_sirq_chip_data *data, u32 index)
+{
+	u32 val;
+
+	val = readl_relaxed(data->base + data->params->reg_offset[index]);
+	if (data->params->reg_shared)
+		val = owl_field_get(val, index);
+
+	return val;
+}
+
+static void owl_sirq_write_extctl(struct owl_sirq_chip_data *data,
+				  u32 extctl, u32 index)
+{
+	u32 val;
+
+	if (data->params->reg_shared) {
+		val = readl_relaxed(data->base + data->params->reg_offset[index]);
+		val &= ~owl_field_prep(0xff, index);
+		extctl = owl_field_prep(extctl, index) | val;
+	}
+
+	writel_relaxed(extctl, data->base + data->params->reg_offset[index]);
+}
+
+static void owl_sirq_clear_set_extctl(struct owl_sirq_chip_data *d,
+				      u32 clear, u32 set, u32 index)
+{
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&d->lock, flags);
+	val = owl_sirq_read_extctl(d, index);
+	val &= ~clear;
+	val |= set;
+	owl_sirq_write_extctl(d, val, index);
+	raw_spin_unlock_irqrestore(&d->lock, flags);
+}
+
+static void owl_sirq_eoi(struct irq_data *data)
+{
+	struct owl_sirq_chip_data *chip_data = irq_data_get_irq_chip_data(data);
+
+	/*
+	 * Software must clear external interrupt pending, when interrupt type
+	 * is edge triggered, so we need per SIRQ based clearing.
+	 */
+	if (!irqd_is_level_type(data))
+		owl_sirq_clear_set_extctl(chip_data, 0, INTC_EXTCTL_PENDING,
+					  data->hwirq);
+
+	irq_chip_eoi_parent(data);
+}
+
+static void owl_sirq_mask(struct irq_data *data)
+{
+	struct owl_sirq_chip_data *chip_data = irq_data_get_irq_chip_data(data);
+
+	owl_sirq_clear_set_extctl(chip_data, INTC_EXTCTL_EN, 0, data->hwirq);
+	irq_chip_mask_parent(data);
+}
+
+static void owl_sirq_unmask(struct irq_data *data)
+{
+	struct owl_sirq_chip_data *chip_data = irq_data_get_irq_chip_data(data);
+
+	owl_sirq_clear_set_extctl(chip_data, 0, INTC_EXTCTL_EN, data->hwirq);
+	irq_chip_unmask_parent(data);
+}
+
+/*
+ * GIC does not handle falling edge or active low, hence SIRQ shall be
+ * programmed to convert falling edge to rising edge signal and active
+ * low to active high signal.
+ */
+static int owl_sirq_set_type(struct irq_data *data, unsigned int type)
+{
+	struct owl_sirq_chip_data *chip_data = irq_data_get_irq_chip_data(data);
+	u32 sirq_type;
+
+	switch (type) {
+	case IRQ_TYPE_LEVEL_LOW:
+		sirq_type = INTC_EXTCTL_TYPE_LOW;
+		type = IRQ_TYPE_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		sirq_type = INTC_EXTCTL_TYPE_HIGH;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		sirq_type = INTC_EXTCTL_TYPE_FALLING;
+		type = IRQ_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		sirq_type = INTC_EXTCTL_TYPE_RISING;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	owl_sirq_clear_set_extctl(chip_data, INTC_EXTCTL_TYPE_MASK, sirq_type,
+				  data->hwirq);
+
+	return irq_chip_set_type_parent(data, type);
+}
+
+static struct irq_chip owl_sirq_chip = {
+	.name		= "owl-sirq",
+	.irq_mask	= owl_sirq_mask,
+	.irq_unmask	= owl_sirq_unmask,
+	.irq_eoi	= owl_sirq_eoi,
+	.irq_set_type	= owl_sirq_set_type,
+	.irq_retrigger	= irq_chip_retrigger_hierarchy,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = irq_chip_set_affinity_parent,
+#endif
+};
+
+static int owl_sirq_domain_translate(struct irq_domain *d,
+				     struct irq_fwspec *fwspec,
+				     unsigned long *hwirq,
+				     unsigned int *type)
+{
+	if (!is_of_node(fwspec->fwnode))
+		return -EINVAL;
+
+	if (fwspec->param_count != 2 || fwspec->param[0] >= NUM_SIRQ)
+		return -EINVAL;
+
+	*hwirq = fwspec->param[0];
+	*type = fwspec->param[1];
+
+	return 0;
+}
+
+static int owl_sirq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				 unsigned int nr_irqs, void *data)
+{
+	struct owl_sirq_chip_data *chip_data = domain->host_data;
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec parent_fwspec;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int ret;
+
+	if (WARN_ON(nr_irqs != 1))
+		return -EINVAL;
+
+	ret = owl_sirq_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_LEVEL_HIGH:
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		type = IRQ_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		type = IRQ_TYPE_LEVEL_HIGH;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &owl_sirq_chip,
+				      chip_data);
+
+	parent_fwspec.fwnode = domain->parent->fwnode;
+	parent_fwspec.param_count = 3;
+	parent_fwspec.param[0] = GIC_SPI;
+	parent_fwspec.param[1] = chip_data->ext_irqs[hwirq];
+	parent_fwspec.param[2] = type;
+
+	return irq_domain_alloc_irqs_parent(domain, virq, 1, &parent_fwspec);
+}
+
+static const struct irq_domain_ops owl_sirq_domain_ops = {
+	.translate	= owl_sirq_domain_translate,
+	.alloc		= owl_sirq_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
+};
+
+static int __init owl_sirq_init(const struct owl_sirq_params *params,
+				struct device_node *node,
+				struct device_node *parent)
+{
+	struct irq_domain *domain, *parent_domain;
+	struct owl_sirq_chip_data *chip_data;
+	int ret, i;
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("%pOF: failed to find sirq parent domain\n", node);
+		return -ENXIO;
+	}
+
+	chip_data = kzalloc(sizeof(*chip_data), GFP_KERNEL);
+	if (!chip_data)
+		return -ENOMEM;
+
+	raw_spin_lock_init(&chip_data->lock);
+
+	chip_data->params = params;
+
+	chip_data->base = of_iomap(node, 0);
+	if (!chip_data->base) {
+		pr_err("%pOF: failed to map sirq registers\n", node);
+		ret = -ENXIO;
+		goto out_free;
+	}
+
+	for (i = 0; i < NUM_SIRQ; i++) {
+		struct of_phandle_args irq;
+
+		ret = of_irq_parse_one(node, i, &irq);
+		if (ret) {
+			pr_err("%pOF: failed to parse interrupt %d\n", node, i);
+			goto out_unmap;
+		}
+
+		if (WARN_ON(irq.args_count != 3)) {
+			ret = -EINVAL;
+			goto out_unmap;
+		}
+
+		chip_data->ext_irqs[i] = irq.args[1];
+
+		/* Set 24MHz external interrupt clock freq */
+		owl_sirq_clear_set_extctl(chip_data, 0, INTC_EXTCTL_CLK_SEL, i);
+	}
+
+	domain = irq_domain_add_hierarchy(parent_domain, 0, NUM_SIRQ, node,
+					  &owl_sirq_domain_ops, chip_data);
+	if (!domain) {
+		pr_err("%pOF: failed to add domain\n", node);
+		ret = -ENOMEM;
+		goto out_unmap;
+	}
+
+	return 0;
+
+out_unmap:
+	iounmap(chip_data->base);
+out_free:
+	kfree(chip_data);
+
+	return ret;
+}
+
+static int __init owl_sirq_s500_of_init(struct device_node *node,
+					struct device_node *parent)
+{
+	return owl_sirq_init(&owl_sirq_s500_params, node, parent);
+}
+
+IRQCHIP_DECLARE(owl_sirq_s500, "actions,s500-sirq", owl_sirq_s500_of_init);
+IRQCHIP_DECLARE(owl_sirq_s700, "actions,s700-sirq", owl_sirq_s500_of_init);
+
+static int __init owl_sirq_s900_of_init(struct device_node *node,
+					struct device_node *parent)
+{
+	return owl_sirq_init(&owl_sirq_s900_params, node, parent);
+}
+
+IRQCHIP_DECLARE(owl_sirq_s900, "actions,s900-sirq", owl_sirq_s900_of_init);
