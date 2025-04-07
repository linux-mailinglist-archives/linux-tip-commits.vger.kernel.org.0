Return-Path: <linux-tip-commits+bounces-4716-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE35A7D69E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 09:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850E118862EC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 07:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0F122B8CF;
	Mon,  7 Apr 2025 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CFm9w9Ew";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yKWOM8bO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD6022ACDF;
	Mon,  7 Apr 2025 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744011789; cv=none; b=qeZoYi0H1GCf7OSQWauO2LB+OiVd3ErpXFFkMbOHMu3k6n72z2p9l27hngWHGcue2gP7VyBwWfQIXSywfVfQvI8o9taUzXVqHCdASOXsYX0Z5Z4OFqqkG/xwHFCMkq0+Ja0AU5K9aGoBvvXQqNPyd40sk9j9aXzYP0Kkxo8xgo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744011789; c=relaxed/simple;
	bh=impmw6XhEHSK2ZIiESJDD5YiZnq9TuyKeYBkg9+8Xag=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dZJzMyLm9ni+oL5mxlTZy1Bp2LRYYQxQVLHyF7qlohJwLHd+zlDjLPh9oqvAZ8wq3HvAWvZYmzLRu3MIUv1XBM/DXl6u6W6o8wCm2t1U0PZZU1lVjtXMGNPTeegKm8IRnZtCpUI5ho5DJydxvNOKhPqRYpo2dxQuxQHwMhl6wns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CFm9w9Ew; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yKWOM8bO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 07:43:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744011785;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWE0gN9QF3X2J/XpjGDimxjvoftRmDNGW0YXzWoY/vg=;
	b=CFm9w9Ew19Zg3E+xDgkmd3GlGk3UTJ2ckWDJdqUkHfzzi9v/T+olMjM72e1lDwSDp+9+l/
	b3xytTc1js0pXS9SoEW4q70ccKDpstrg818Drbw73v5btVczW8JW7GAqDqRaeHliiy77vY
	Q78art+nhJ+NpqO6kxwoBoXHF0pYvA0EZi5LMMTQFKKzNtR6D6ea9BGkK8KFjfamZf7YVE
	wDVPlFZukiZiGEYgaFP6oB3RxCCgnurXvvMI3Is9VVM155GJcByJE6mb8/ab9WEofptLIG
	YgqS5fZnjviwubP0x2I5AaEigCSzKBcopAK+T2PTFAjPa1/7dCMzy4Nz4MgfFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744011785;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWE0gN9QF3X2J/XpjGDimxjvoftRmDNGW0YXzWoY/vg=;
	b=yKWOM8bOtPrZOd4M3Sa/mvD1EE0I0dl8tfnhUKsVTwf/4C5qYO+iiilKlN7uq1MlR8n0ki
	AbZZbZ04e/ZnNNCQ==
From: "tip-bot2 for Caleb James DeLisle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip: Add EcoNet EN751221 INTC
Cc: Caleb James DeLisle <cjd@cjdns.fr>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250330170306.2584136-4-cjd@cjdns.fr>
References: <20250330170306.2584136-4-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174401178408.31282.7860647273143030971.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     1902a59cf5f9d8b99ecf0cb8f122cb00ef7a3f13
Gitweb:        https://git.kernel.org/tip/1902a59cf5f9d8b99ecf0cb8f122cb00ef7a3f13
Author:        Caleb James DeLisle <cjd@cjdns.fr>
AuthorDate:    Sun, 30 Mar 2025 17:02:59 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 09:39:39 +02:00

irqchip: Add EcoNet EN751221 INTC

Add a driver for the interrupt controller in the EcoNet EN751221 MIPS SoC.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250330170306.2584136-4-cjd@cjdns.fr

---
 drivers/irqchip/Kconfig               |   5 +-
 drivers/irqchip/Makefile              |   1 +-
 drivers/irqchip/irq-econet-en751221.c | 309 +++++++++++++++++++++++++-
 3 files changed, 315 insertions(+)
 create mode 100644 drivers/irqchip/irq-econet-en751221.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index cec05e4..4b43870 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -166,6 +166,11 @@ config DW_APB_ICTL
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN_HIERARCHY
 
+config ECONET_EN751221_INTC
+	bool
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+
 config FARADAY_FTINTC010
 	bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 365bcea..23ca495 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
 obj-$(CONFIG_ARCH_ACTIONS)		+= irq-owl-sirq.o
 obj-$(CONFIG_DAVINCI_CP_INTC)		+= irq-davinci-cp-intc.o
 obj-$(CONFIG_EXYNOS_IRQ_COMBINER)	+= exynos-combiner.o
+obj-$(CONFIG_ECONET_EN751221_INTC)	+= irq-econet-en751221.o
 obj-$(CONFIG_FARADAY_FTINTC010)		+= irq-ftintc010.o
 obj-$(CONFIG_ARCH_HIP04)		+= irq-hip04.o
 obj-$(CONFIG_ARCH_LPC32XX)		+= irq-lpc32xx.o
diff --git a/drivers/irqchip/irq-econet-en751221.c b/drivers/irqchip/irq-econet-en751221.c
new file mode 100644
index 0000000..886d60c
--- /dev/null
+++ b/drivers/irqchip/irq-econet-en751221.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * EN751221 Interrupt Controller Driver.
+ *
+ * The EcoNet EN751221 Interrupt Controller is a simple interrupt controller
+ * designed for the MIPS 34Kc MT SMP processor with 2 VPEs. Each interrupt can
+ * be routed to either VPE but not both, so to support per-CPU interrupts, a
+ * secondary IRQ number is allocated to control masking/unmasking on VPE#1. In
+ * this driver, these are called "shadow interrupts". The assignment of shadow
+ * interrupts is defined by the SoC integrator when wiring the interrupt lines,
+ * so they are configurable in the device tree.
+ *
+ * If an interrupt (say 30) needs per-CPU capability, the SoC integrator
+ * allocates another IRQ number (say 29) to be its shadow. The device tree
+ * reflects this by adding the pair <30 29> to the "econet,shadow-interrupts"
+ * property.
+ *
+ * When VPE#1 requests IRQ 30, the driver manipulates the mask bit for IRQ 29,
+ * telling the hardware to mask VPE#1's view of IRQ 30.
+ *
+ * Copyright (C) 2025 Caleb James DeLisle <cjd@cjdns.fr>
+ */
+
+#include <linux/cleanup.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+
+#define IRQ_COUNT		40
+
+#define NOT_PERCPU		0xff
+#define IS_SHADOW		0xfe
+
+#define REG_MASK0		0x04
+#define REG_MASK1		0x50
+#define REG_PENDING0		0x08
+#define REG_PENDING1		0x54
+
+/**
+ * @membase: Base address of the interrupt controller registers
+ * @interrupt_shadows: Array of all interrupts, for each value,
+ *	- NOT_PERCPU: This interrupt is not per-cpu, so it has no shadow
+ *	- IS_SHADOW: This interrupt is a shadow of another per-cpu interrupt
+ *	- else: This is a per-cpu interrupt whose shadow is the value
+ */
+static struct {
+	void __iomem	*membase;
+	u8		interrupt_shadows[IRQ_COUNT];
+} econet_intc __ro_after_init;
+
+static DEFINE_RAW_SPINLOCK(irq_lock);
+
+/* IRQs must be disabled */
+static void econet_wreg(u32 reg, u32 val, u32 mask)
+{
+	u32 v;
+
+	guard(raw_spinlock)(&irq_lock);
+
+	v = ioread32(econet_intc.membase + reg);
+	v &= ~mask;
+	v |= val & mask;
+	iowrite32(v, econet_intc.membase + reg);
+}
+
+/* IRQs must be disabled */
+static void econet_chmask(u32 hwirq, bool unmask)
+{
+	u32 reg, mask;
+	u8 shadow;
+
+	/*
+	 * If the IRQ is a shadow, it should never be manipulated directly.
+	 * It should only be masked/unmasked as a result of the "real" per-cpu
+	 * irq being manipulated by a thread running on VPE#1.
+	 * If it is per-cpu (has a shadow), and we're on VPE#1, the shadow is what we mask.
+	 * This is single processor only, so smp_processor_id() never exceeds 1.
+	 */
+	shadow = econet_intc.interrupt_shadows[hwirq];
+	if (WARN_ON_ONCE(shadow == IS_SHADOW))
+		return;
+	else if (shadow != NOT_PERCPU && smp_processor_id() == 1)
+		hwirq = shadow;
+
+	if (hwirq >= 32) {
+		reg = REG_MASK1;
+		mask = BIT(hwirq - 32);
+	} else {
+		reg = REG_MASK0;
+		mask = BIT(hwirq);
+	}
+
+	econet_wreg(reg, unmask ? mask : 0, mask);
+}
+
+/* IRQs must be disabled */
+static void econet_intc_mask(struct irq_data *d)
+{
+	econet_chmask(d->hwirq, false);
+}
+
+/* IRQs must be disabled */
+static void econet_intc_unmask(struct irq_data *d)
+{
+	econet_chmask(d->hwirq, true);
+}
+
+static void econet_mask_all(void)
+{
+	/* IRQs are generally disabled during init, but guarding here makes it non-obligatory. */
+	guard(irqsave)();
+	econet_wreg(REG_MASK0, 0, ~0);
+	econet_wreg(REG_MASK1, 0, ~0);
+}
+
+static void econet_intc_handle_pending(struct irq_domain *d, u32 pending, u32 offset)
+{
+	int hwirq;
+
+	while (pending) {
+		hwirq = fls(pending) - 1;
+		generic_handle_domain_irq(d, hwirq + offset);
+		pending &= ~BIT(hwirq);
+	}
+}
+
+static void econet_intc_from_parent(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irq_domain *domain;
+	u32 pending0, pending1;
+
+	chained_irq_enter(chip, desc);
+
+	pending0 = ioread32(econet_intc.membase + REG_PENDING0);
+	pending1 = ioread32(econet_intc.membase + REG_PENDING1);
+
+	if (unlikely(!(pending0 | pending1))) {
+		spurious_interrupt();
+	} else {
+		domain = irq_desc_get_handler_data(desc);
+		econet_intc_handle_pending(domain, pending0, 0);
+		econet_intc_handle_pending(domain, pending1, 32);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static const struct irq_chip econet_irq_chip;
+
+static int econet_intc_map(struct irq_domain *d, u32 irq, irq_hw_number_t hwirq)
+{
+	int ret;
+
+	if (hwirq >= IRQ_COUNT) {
+		pr_err("%s: hwirq %lu out of range\n", __func__, hwirq);
+		return -EINVAL;
+	} else if (econet_intc.interrupt_shadows[hwirq] == IS_SHADOW) {
+		pr_err("%s: can't map hwirq %lu, it is a shadow interrupt\n", __func__, hwirq);
+		return -EINVAL;
+	}
+
+	if (econet_intc.interrupt_shadows[hwirq] == NOT_PERCPU) {
+		irq_set_chip_and_handler(irq, &econet_irq_chip, handle_level_irq);
+	} else {
+		irq_set_chip_and_handler(irq, &econet_irq_chip, handle_percpu_devid_irq);
+		ret = irq_set_percpu_devid(irq);
+		if (ret)
+			pr_warn("%s: Failed irq_set_percpu_devid for %u: %d\n", d->name, irq, ret);
+	}
+
+	irq_set_chip_data(irq, NULL);
+	return 0;
+}
+
+static const struct irq_chip econet_irq_chip = {
+	.name		= "en751221-intc",
+	.irq_unmask	= econet_intc_unmask,
+	.irq_mask	= econet_intc_mask,
+	.irq_mask_ack	= econet_intc_mask,
+};
+
+static const struct irq_domain_ops econet_domain_ops = {
+	.xlate	= irq_domain_xlate_onecell,
+	.map	= econet_intc_map
+};
+
+static int __init get_shadow_interrupts(struct device_node *node)
+{
+	const char *field = "econet,shadow-interrupts";
+	int num_shadows;
+
+	num_shadows = of_property_count_u32_elems(node, field);
+
+	memset(econet_intc.interrupt_shadows, NOT_PERCPU,
+	       sizeof(econet_intc.interrupt_shadows));
+
+	if (num_shadows <= 0) {
+		return 0;
+	} else if (num_shadows % 2) {
+		pr_err("%pOF: %s count is odd, ignoring\n", node, field);
+		return 0;
+	}
+
+	u32 *shadows __free(kfree) = kmalloc_array(num_shadows, sizeof(u32), GFP_KERNEL);
+	if (!shadows)
+		return -ENOMEM;
+
+	if (of_property_read_u32_array(node, field, shadows, num_shadows)) {
+		pr_err("%pOF: Failed to read %s\n", node, field);
+		return -EINVAL;
+	}
+
+	for (int i = 0; i < num_shadows; i += 2) {
+		u32 shadow = shadows[i + 1];
+		u32 target = shadows[i];
+
+		if (shadow > IRQ_COUNT) {
+			pr_err("%pOF: %s[%d] shadow(%d) out of range\n",
+			       node, field, i + 1, shadow);
+			continue;
+		}
+
+		if (target >= IRQ_COUNT) {
+			pr_err("%pOF: %s[%d] target(%d) out of range\n", node, field, i, target);
+			continue;
+		}
+
+		if (econet_intc.interrupt_shadows[target] != NOT_PERCPU) {
+			pr_err("%pOF: %s[%d] target(%d) already has a shadow\n",
+			       node, field, i, target);
+			continue;
+		}
+
+		if (econet_intc.interrupt_shadows[shadow] != NOT_PERCPU) {
+			pr_err("%pOF: %s[%d] shadow(%d) already has a target\n",
+			       node, field, i + 1, shadow);
+			continue;
+		}
+
+		econet_intc.interrupt_shadows[target] = shadow;
+		econet_intc.interrupt_shadows[shadow] = IS_SHADOW;
+	}
+
+	return 0;
+}
+
+static int __init econet_intc_of_init(struct device_node *node, struct device_node *parent)
+{
+	struct irq_domain *domain;
+	struct resource res;
+	int ret, irq;
+
+	ret = get_shadow_interrupts(node);
+	if (ret)
+		return ret;
+
+	irq = irq_of_parse_and_map(node, 0);
+	if (!irq) {
+		pr_err("%pOF: DT: Failed to get IRQ from 'interrupts'\n", node);
+		return -EINVAL;
+	}
+
+	if (of_address_to_resource(node, 0, &res)) {
+		pr_err("%pOF: DT: Failed to get 'reg'\n", node);
+		ret = -EINVAL;
+		goto err_dispose_mapping;
+	}
+
+	if (!request_mem_region(res.start, resource_size(&res), res.name)) {
+		pr_err("%pOF: Failed to request memory\n", node);
+		ret = -EBUSY;
+		goto err_dispose_mapping;
+	}
+
+	econet_intc.membase = ioremap(res.start, resource_size(&res));
+	if (!econet_intc.membase) {
+		pr_err("%pOF: Failed to remap membase\n", node);
+		ret = -ENOMEM;
+		goto err_release;
+	}
+
+	econet_mask_all();
+
+	domain = irq_domain_add_linear(node, IRQ_COUNT, &econet_domain_ops, NULL);
+	if (!domain) {
+		pr_err("%pOF: Failed to add irqdomain\n", node);
+		ret = -ENOMEM;
+		goto err_unmap;
+	}
+
+	irq_set_chained_handler_and_data(irq, econet_intc_from_parent, domain);
+
+	return 0;
+
+err_unmap:
+	iounmap(econet_intc.membase);
+err_release:
+	release_mem_region(res.start, resource_size(&res));
+err_dispose_mapping:
+	irq_dispose_mapping(irq);
+	return ret;
+}
+
+IRQCHIP_DECLARE(econet_en751221_intc, "econet,en751221-intc", econet_intc_of_init);

