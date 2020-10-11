Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645CC28A915
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 20:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgJKSBN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 14:01:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39912 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388328AbgJKR5W (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:22 -0400
Date:   Sun, 11 Oct 2020 17:57:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439039;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=97EtB3LMKSbG8Ucr6lkMXBRod7QiQM0CWrH6N/5TLKc=;
        b=aLkSFCICEpoG4H0D7pwHkS3Il/VxnyK/aiTtam+8h5nCOJH+0xllWFYOsddUWhU05i/cCn
        Y/sDvBiig7Wb4TWfPGRm+cOmNs13kfWvHYx5cZoR/ISUKQOlSmu1WkrS2D9mTWlL0BlG1n
        DcUMb9++xxE5hKfQ28YD7TiLoACYxR42XLF+hgfeWgIN+BxCQYvxJAiiMyl+NWlMLTrTiP
        2N1EsceHw+2+rYHlWJgrxQFX9ThHolG9Q++7OTwcq3S3ekWJ8CjTtRyExc5qh95s07fr7b
        EY6XxVJBHhObsic4E1MomFu5P5P9LVzKwZeEjVTf4K2/VT0FSgxcmY1TgMS0jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439039;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=97EtB3LMKSbG8Ucr6lkMXBRod7QiQM0CWrH6N/5TLKc=;
        b=u1TDRm1L3t+6wGFmo/fycD4U/GnHDiUyqv6ZnzUoMwnzNgyQX/iaa+UVUia/y+9rNUY+FL
        9jtfP2W/OXUOZtAA==
From:   "tip-bot2 for Mark-PK Tsai" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/irq-mst: Add MStar interrupt controller support
Cc:     "Mark-PK Tsai" <mark-pk.tsai@mediatek.com>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Palmer <daniel@thingy.jp>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200902063344.1852-2-mark-pk.tsai@mediatek.com>
References: <20200902063344.1852-2-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Message-ID: <160243903852.7002.4002895696772806411.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ad4c938c92af91302e363b1842c82f1cc4a6c4fd
Gitweb:        https://git.kernel.org/tip/ad4c938c92af91302e363b1842c82f1cc4a6c4fd
Author:        Mark-PK Tsai <mark-pk.tsai@mediatek.com>
AuthorDate:    Wed, 02 Sep 2020 14:33:43 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 10 Oct 2020 12:39:27 +01:00

irqchip/irq-mst: Add MStar interrupt controller support

Add MStar interrupt controller support using hierarchy irq
domain.

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Tested-by: Daniel Palmer <daniel@thingy.jp>
Link: https://lore.kernel.org/r/20200902063344.1852-2-mark-pk.tsai@mediatek.com
---
 MAINTAINERS                    |   7 +-
 drivers/irqchip/Kconfig        |   8 +-
 drivers/irqchip/Makefile       |   1 +-
 drivers/irqchip/irq-mst-intc.c | 199 ++++++++++++++++++++++++++++++++-
 4 files changed, 215 insertions(+)
 create mode 100644 drivers/irqchip/irq-mst-intc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b5cfab0..c1e90fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11771,6 +11771,13 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/usb/msi2500/
 
+MSTAR INTERRUPT CONTROLLER DRIVER
+M:	Mark-PK Tsai <mark-pk.tsai@mediatek.com>
+M:	Daniel Palmer <daniel@thingy.jp>
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/mstar,mst-intc.yaml
+F:	drivers/irqchip/irq-mst-intc.c
+
 MSYSTEMS DISKONCHIP G3 MTD DRIVER
 M:	Robert Jarzmik <robert.jarzmik@free.fr>
 L:	linux-mtd@lists.infradead.org
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index bfc9719..c6321a6 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -571,4 +571,12 @@ config LOONGSON_PCH_MSI
 	help
 	  Support for the Loongson PCH MSI Controller.
 
+config MST_IRQ
+	bool "MStar Interrupt Controller"
+	default ARCH_MEDIATEK
+	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Support MStar Interrupt Controller.
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 133f9c4..e2688a6 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -111,3 +111,4 @@ obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
 obj-$(CONFIG_LOONGSON_HTVEC)		+= irq-loongson-htvec.o
 obj-$(CONFIG_LOONGSON_PCH_PIC)		+= irq-loongson-pch-pic.o
 obj-$(CONFIG_LOONGSON_PCH_MSI)		+= irq-loongson-pch-msi.o
+obj-$(CONFIG_MST_IRQ)			+= irq-mst-intc.o
diff --git a/drivers/irqchip/irq-mst-intc.c b/drivers/irqchip/irq-mst-intc.c
new file mode 100644
index 0000000..4be0775
--- /dev/null
+++ b/drivers/irqchip/irq-mst-intc.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright (c) 2020 MediaTek Inc.
+ * Author Mark-PK Tsai <mark-pk.tsai@mediatek.com>
+ */
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#define INTC_MASK	0x0
+#define INTC_EOI	0x20
+
+struct mst_intc_chip_data {
+	raw_spinlock_t	lock;
+	unsigned int	irq_start, nr_irqs;
+	void __iomem	*base;
+	bool		no_eoi;
+};
+
+static void mst_set_irq(struct irq_data *d, u32 offset)
+{
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	struct mst_intc_chip_data *cd = irq_data_get_irq_chip_data(d);
+	u16 val, mask;
+	unsigned long flags;
+
+	mask = 1 << (hwirq % 16);
+	offset += (hwirq / 16) * 4;
+
+	raw_spin_lock_irqsave(&cd->lock, flags);
+	val = readw_relaxed(cd->base + offset) | mask;
+	writew_relaxed(val, cd->base + offset);
+	raw_spin_unlock_irqrestore(&cd->lock, flags);
+}
+
+static void mst_clear_irq(struct irq_data *d, u32 offset)
+{
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	struct mst_intc_chip_data *cd = irq_data_get_irq_chip_data(d);
+	u16 val, mask;
+	unsigned long flags;
+
+	mask = 1 << (hwirq % 16);
+	offset += (hwirq / 16) * 4;
+
+	raw_spin_lock_irqsave(&cd->lock, flags);
+	val = readw_relaxed(cd->base + offset) & ~mask;
+	writew_relaxed(val, cd->base + offset);
+	raw_spin_unlock_irqrestore(&cd->lock, flags);
+}
+
+static void mst_intc_mask_irq(struct irq_data *d)
+{
+	mst_set_irq(d, INTC_MASK);
+	irq_chip_mask_parent(d);
+}
+
+static void mst_intc_unmask_irq(struct irq_data *d)
+{
+	mst_clear_irq(d, INTC_MASK);
+	irq_chip_unmask_parent(d);
+}
+
+static void mst_intc_eoi_irq(struct irq_data *d)
+{
+	struct mst_intc_chip_data *cd = irq_data_get_irq_chip_data(d);
+
+	if (!cd->no_eoi)
+		mst_set_irq(d, INTC_EOI);
+
+	irq_chip_eoi_parent(d);
+}
+
+static struct irq_chip mst_intc_chip = {
+	.name			= "mst-intc",
+	.irq_mask		= mst_intc_mask_irq,
+	.irq_unmask		= mst_intc_unmask_irq,
+	.irq_eoi		= mst_intc_eoi_irq,
+	.irq_get_irqchip_state	= irq_chip_get_parent_state,
+	.irq_set_irqchip_state	= irq_chip_set_parent_state,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
+	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.flags			= IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static int mst_intc_domain_translate(struct irq_domain *d,
+				     struct irq_fwspec *fwspec,
+				     unsigned long *hwirq,
+				     unsigned int *type)
+{
+	struct mst_intc_chip_data *cd = d->host_data;
+
+	if (is_of_node(fwspec->fwnode)) {
+		if (fwspec->param_count != 3)
+			return -EINVAL;
+
+		/* No PPI should point to this domain */
+		if (fwspec->param[0] != 0)
+			return -EINVAL;
+
+		if (fwspec->param[1] >= cd->nr_irqs)
+			return -EINVAL;
+
+		*hwirq = fwspec->param[1];
+		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int mst_intc_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				 unsigned int nr_irqs, void *data)
+{
+	int i;
+	irq_hw_number_t hwirq;
+	struct irq_fwspec parent_fwspec, *fwspec = data;
+	struct mst_intc_chip_data *cd = domain->host_data;
+
+	/* Not GIC compliant */
+	if (fwspec->param_count != 3)
+		return -EINVAL;
+
+	/* No PPI should point to this domain */
+	if (fwspec->param[0])
+		return -EINVAL;
+
+	hwirq = fwspec->param[1];
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+					      &mst_intc_chip,
+					      domain->host_data);
+
+	parent_fwspec = *fwspec;
+	parent_fwspec.fwnode = domain->parent->fwnode;
+	parent_fwspec.param[1] = cd->irq_start + hwirq;
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_fwspec);
+}
+
+static const struct irq_domain_ops mst_intc_domain_ops = {
+	.translate	= mst_intc_domain_translate,
+	.alloc		= mst_intc_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
+};
+
+int __init
+mst_intc_of_init(struct device_node *dn, struct device_node *parent)
+{
+	struct irq_domain *domain, *domain_parent;
+	struct mst_intc_chip_data *cd;
+	u32 irq_start, irq_end;
+
+	domain_parent = irq_find_host(parent);
+	if (!domain_parent) {
+		pr_err("mst-intc: interrupt-parent not found\n");
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32_index(dn, "mstar,irqs-map-range", 0, &irq_start) ||
+	    of_property_read_u32_index(dn, "mstar,irqs-map-range", 1, &irq_end))
+		return -EINVAL;
+
+	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
+	if (!cd)
+		return -ENOMEM;
+
+	cd->base = of_iomap(dn, 0);
+	if (!cd->base) {
+		kfree(cd);
+		return -ENOMEM;
+	}
+
+	cd->no_eoi = of_property_read_bool(dn, "mstar,intc-no-eoi");
+	raw_spin_lock_init(&cd->lock);
+	cd->irq_start = irq_start;
+	cd->nr_irqs = irq_end - irq_start + 1;
+	domain = irq_domain_add_hierarchy(domain_parent, 0, cd->nr_irqs, dn,
+					  &mst_intc_domain_ops, cd);
+	if (!domain) {
+		iounmap(cd->base);
+		kfree(cd);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(mst_intc, "mstar,mst-intc", mst_intc_of_init);
