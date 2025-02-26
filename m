Return-Path: <linux-tip-commits+bounces-3634-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0957CA4574F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 08:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C420C178357
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 07:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0807C258CC2;
	Wed, 26 Feb 2025 07:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wfA1AzJ4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kcgGLxmJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04640271296;
	Wed, 26 Feb 2025 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556300; cv=none; b=I1GQbKfavugNKCbee1XqDmjpVYttj7jC5ihP1rd6kR3GFjR9/E0IbAh7wpMHNNrGUWKWxGrUFKBtuLDiCL1rxuaz/Qswi+H/n+mTxMw7j0UOKXJ71P2IgCf3Nw748pgtkY+UkEHQfXH+1Dvmpe9fsag9GfE3vte4ycO8rHQanX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556300; c=relaxed/simple;
	bh=tBmVKvphfVzgFjI8RvwS9Vx9HvpwtsF6mVIrEYmI3ow=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mXptzTDt1syFaxrUB2vuzDlGJUYWg/yQ72gnT0XofOMX/Oj73Fhz18HsyG45io3V1VgcXASyrpUFEslZSp9rhVYBNCfWvSx88kuNZUYwH24fQkeW2R6jkDxSjWdAPxn0d6Wav/e6XJrdvaukYIKcCqpdFnI5h33tgzRERk8VCI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wfA1AzJ4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kcgGLxmJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 07:51:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740556296;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1B2eF8xuJGEDth2UMmpOGKTwK/9OkeHMwXN1JAWdCI=;
	b=wfA1AzJ45Mv5XH3N0nmrsbaVYSA0jZ+YmhcHW2eLfqCMh26I0hCMlPfZclMcKxTznesZ+M
	GI4W++LKbEg+1boeC1knafSAtfXJWPtCZA7cjSGjVXzRQ101GoOUwxhH0ihtnLqlS5wt6e
	TiddlQ411JUxEz9aMB7oBdzS/Q8S+6ndzrP396T6THQHeeI6212gqXGi+meJbqiUuUZXiJ
	ObcP8118P8rnCvQH/0JYm+j/e7RgvlbMAPk95FD+HtYSY8uK6zGyvvd1D0E3W5+sV7HWO+
	Y+0AlC76XQXIwMY860Tkot/hivCkUt73r+v6H7PMit5tXFMajmeLT7wwlwj/Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740556296;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1B2eF8xuJGEDth2UMmpOGKTwK/9OkeHMwXN1JAWdCI=;
	b=kcgGLxmJCmLXRqR6gUlHHUc3VVpGJbCv4fcRTg08ZbRGdUA5hb8XMV5DHJJ7NBSOquRfT/
	ePlm47An4pzuXeBw==
From: "tip-bot2 for Chen Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] irqchip: Add the Sophgo SG2042 MSI interrupt controller
Cc: Chen Wang <unicorn_wang@outlook.com>, Thomas Gleixner <tglx@linutronix.de>,
 Inochi Amaoto <inochiama@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C3104216ca90a5f532bafb676c1c5b1efb19e94d1=2E17405?=
 =?utf-8?q?35748=2Egit=2Eunicorn=5Fwang=40outlook=2Ecom=3E?=
References: =?utf-8?q?=3C3104216ca90a5f532bafb676c1c5b1efb19e94d1=2E174053?=
 =?utf-8?q?5748=2Egit=2Eunicorn=5Fwang=40outlook=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174055629597.10177.7222023913255243062.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     c66741549424ca67453885f8b3a5aa81d9abfb34
Gitweb:        https://git.kernel.org/tip/c66741549424ca67453885f8b3a5aa81d9abfb34
Author:        Chen Wang <unicorn_wang@outlook.com>
AuthorDate:    Wed, 26 Feb 2025 10:15:19 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 26 Feb 2025 08:41:28 +01:00

irqchip: Add the Sophgo SG2042 MSI interrupt controller

Add driver for Sophgo SG2042 MSI interrupt controller.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Inochi Amaoto <inochiama@gmail.com>
Link: https://lore.kernel.org/all/3104216ca90a5f532bafb676c1c5b1efb19e94d1.1740535748.git.unicorn_wang@outlook.com

---
 drivers/irqchip/Kconfig          |  12 +-
 drivers/irqchip/Makefile         |   1 +-
 drivers/irqchip/irq-sg2042-msi.c | 249 ++++++++++++++++++++++++++++++-
 3 files changed, 262 insertions(+)
 create mode 100644 drivers/irqchip/irq-sg2042-msi.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index bc3f12a..441f107 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -745,6 +745,18 @@ config MCHP_EIC
 	help
 	  Support for Microchip External Interrupt Controller.
 
+config SOPHGO_SG2042_MSI
+	bool "Sophgo SG2042 MSI Controller"
+	depends on ARCH_SOPHGO || COMPILE_TEST
+	depends on PCI
+	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_MSI_LIB
+	select PCI_MSI
+	help
+	  Support for the Sophgo SG2042 MSI Controller.
+	  This on-chip interrupt controller enables MSI sources to be
+	  routed to the primary PLIC controller on SoC.
+
 config SUNPLUS_SP7021_INTC
 	bool "Sunplus SP7021 interrupt controller" if COMPILE_TEST
 	default SOC_SP7021
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 25e9ad2..dd60e59 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -128,4 +128,5 @@ obj-$(CONFIG_WPCM450_AIC)		+= irq-wpcm450-aic.o
 obj-$(CONFIG_IRQ_IDT3243X)		+= irq-idt3243x.o
 obj-$(CONFIG_APPLE_AIC)			+= irq-apple-aic.o
 obj-$(CONFIG_MCHP_EIC)			+= irq-mchp-eic.o
+obj-$(CONFIG_SOPHGO_SG2042_MSI)		+= irq-sg2042-msi.o
 obj-$(CONFIG_SUNPLUS_SP7021_INTC)	+= irq-sp7021-intc.o
diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
new file mode 100644
index 0000000..ee682e8
--- /dev/null
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SG2042 MSI Controller
+ *
+ * Copyright (C) 2024 Sophgo Technology Inc.
+ * Copyright (C) 2024 Chen Wang <unicorn_wang@outlook.com>
+ */
+
+#include <linux/cleanup.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+#include "irq-msi-lib.h"
+
+#define SG2042_MAX_MSI_VECTOR	32
+
+struct sg2042_msi_chipdata {
+	void __iomem	*reg_clr;	// clear reg, see TRM, 10.1.33, GP_INTR0_CLR
+
+	phys_addr_t	doorbell_addr;	// see TRM, 10.1.32, GP_INTR0_SET
+
+	u32		irq_first;	// The vector number that MSIs starts
+	u32		num_irqs;	// The number of vectors for MSIs
+
+	DECLARE_BITMAP(msi_map, SG2042_MAX_MSI_VECTOR);
+	struct mutex	msi_map_lock;	// lock for msi_map
+};
+
+static int sg2042_msi_allocate_hwirq(struct sg2042_msi_chipdata *data, int num_req)
+{
+	int first;
+
+	guard(mutex)(&data->msi_map_lock);
+	first = bitmap_find_free_region(data->msi_map, data->num_irqs,
+					get_count_order(num_req));
+	return first >= 0 ? first : -ENOSPC;
+}
+
+static void sg2042_msi_free_hwirq(struct sg2042_msi_chipdata *data, int hwirq, int num_req)
+{
+	guard(mutex)(&data->msi_map_lock);
+	bitmap_release_region(data->msi_map, hwirq, get_count_order(num_req));
+}
+
+static void sg2042_msi_irq_ack(struct irq_data *d)
+{
+	struct sg2042_msi_chipdata *data  = irq_data_get_irq_chip_data(d);
+	int bit_off = d->hwirq;
+
+	writel(1 << bit_off, data->reg_clr);
+
+	irq_chip_ack_parent(d);
+}
+
+static void sg2042_msi_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	struct sg2042_msi_chipdata *data = irq_data_get_irq_chip_data(d);
+
+	msg->address_hi = upper_32_bits(data->doorbell_addr);
+	msg->address_lo = lower_32_bits(data->doorbell_addr);
+	msg->data = 1 << d->hwirq;
+}
+
+static const struct irq_chip sg2042_msi_middle_irq_chip = {
+	.name			= "SG2042 MSI",
+	.irq_ack		= sg2042_msi_irq_ack,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+#endif
+	.irq_compose_msi_msg	= sg2042_msi_irq_compose_msi_msg,
+};
+
+static int sg2042_msi_parent_domain_alloc(struct irq_domain *domain, unsigned int virq, int hwirq)
+{
+	struct sg2042_msi_chipdata *data = domain->host_data;
+	struct irq_fwspec fwspec;
+	struct irq_data *d;
+	int ret;
+
+	fwspec.fwnode = domain->parent->fwnode;
+	fwspec.param_count = 2;
+	fwspec.param[0] = data->irq_first + hwirq;
+	fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
+	if (ret)
+		return ret;
+
+	d = irq_domain_get_irq_data(domain->parent, virq);
+	return d->chip->irq_set_type(d, IRQ_TYPE_EDGE_RISING);
+}
+
+static int sg2042_msi_middle_domain_alloc(struct irq_domain *domain, unsigned int virq,
+					  unsigned int nr_irqs, void *args)
+{
+	struct sg2042_msi_chipdata *data = domain->host_data;
+	int hwirq, err, i;
+
+	hwirq = sg2042_msi_allocate_hwirq(data, nr_irqs);
+	if (hwirq < 0)
+		return hwirq;
+
+	for (i = 0; i < nr_irqs; i++) {
+		err = sg2042_msi_parent_domain_alloc(domain, virq + i, hwirq + i);
+		if (err)
+			goto err_hwirq;
+
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+					      &sg2042_msi_middle_irq_chip, data);
+	}
+
+	return 0;
+
+err_hwirq:
+	sg2042_msi_free_hwirq(data, hwirq, nr_irqs);
+	irq_domain_free_irqs_parent(domain, virq, i);
+
+	return err;
+}
+
+static void sg2042_msi_middle_domain_free(struct irq_domain *domain, unsigned int virq,
+					  unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct sg2042_msi_chipdata *data = irq_data_get_irq_chip_data(d);
+
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+	sg2042_msi_free_hwirq(data, d->hwirq, nr_irqs);
+}
+
+static const struct irq_domain_ops sg2042_msi_middle_domain_ops = {
+	.alloc	= sg2042_msi_middle_domain_alloc,
+	.free	= sg2042_msi_middle_domain_free,
+	.select	= msi_lib_irq_domain_select,
+};
+
+#define SG2042_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				   MSI_FLAG_USE_DEF_CHIP_OPS)
+
+#define SG2042_MSI_FLAGS_SUPPORTED MSI_GENERIC_FLAGS_MASK
+
+static const struct msi_parent_ops sg2042_msi_parent_ops = {
+	.required_flags		= SG2042_MSI_FLAGS_REQUIRED,
+	.supported_flags	= SG2042_MSI_FLAGS_SUPPORTED,
+	.bus_select_mask	= MATCH_PCI_MSI,
+	.bus_select_token	= DOMAIN_BUS_NEXUS,
+	.prefix			= "SG2042-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+};
+
+static int sg2042_msi_init_domains(struct sg2042_msi_chipdata *data,
+				   struct irq_domain *plic_domain, struct device *dev)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	struct irq_domain *middle_domain;
+
+	middle_domain = irq_domain_create_hierarchy(plic_domain, 0, data->num_irqs, fwnode,
+						    &sg2042_msi_middle_domain_ops, data);
+	if (!middle_domain) {
+		pr_err("Failed to create the MSI middle domain\n");
+		return -ENOMEM;
+	}
+
+	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
+
+	middle_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	middle_domain->msi_parent_ops = &sg2042_msi_parent_ops;
+
+	return 0;
+}
+
+static int sg2042_msi_probe(struct platform_device *pdev)
+{
+	struct fwnode_reference_args args = { };
+	struct sg2042_msi_chipdata *data;
+	struct device *dev = &pdev->dev;
+	struct irq_domain *plic_domain;
+	struct resource *res;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(struct sg2042_msi_chipdata), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->reg_clr = devm_platform_ioremap_resource_byname(pdev, "clr");
+	if (IS_ERR(data->reg_clr)) {
+		dev_err(dev, "Failed to map clear register\n");
+		return PTR_ERR(data->reg_clr);
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "doorbell");
+	if (!res) {
+		dev_err(dev, "Failed get resource from set\n");
+		return -EINVAL;
+	}
+	data->doorbell_addr = res->start;
+
+	ret = fwnode_property_get_reference_args(dev_fwnode(dev), "msi-ranges",
+						 "#interrupt-cells", 0, 0, &args);
+	if (ret) {
+		dev_err(dev, "Unable to parse MSI vec base\n");
+		return ret;
+	}
+	fwnode_handle_put(args.fwnode);
+
+	ret = fwnode_property_get_reference_args(dev_fwnode(dev), "msi-ranges", NULL,
+						 args.nargs + 1, 0, &args);
+	if (ret) {
+		dev_err(dev, "Unable to parse MSI vec number\n");
+		return ret;
+	}
+
+	plic_domain = irq_find_matching_fwnode(args.fwnode, DOMAIN_BUS_ANY);
+	fwnode_handle_put(args.fwnode);
+	if (!plic_domain) {
+		pr_err("Failed to find the PLIC domain\n");
+		return -ENXIO;
+	}
+
+	data->irq_first = (u32)args.args[0];
+	data->num_irqs = (u32)args.args[args.nargs - 1];
+
+	mutex_init(&data->msi_map_lock);
+
+	return sg2042_msi_init_domains(data, plic_domain, dev);
+}
+
+static const struct of_device_id sg2042_msi_of_match[] = {
+	{ .compatible	= "sophgo,sg2042-msi" },
+	{ }
+};
+
+static struct platform_driver sg2042_msi_driver = {
+	.driver = {
+		.name		= "sg2042-msi",
+		.of_match_table	= sg2042_msi_of_match,
+	},
+	.probe = sg2042_msi_probe,
+};
+builtin_platform_driver(sg2042_msi_driver);

