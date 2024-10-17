Return-Path: <linux-tip-commits+bounces-2504-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484BA9A2E00
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 21:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4D71C26679
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 19:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B861A227B9E;
	Thu, 17 Oct 2024 19:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kKBpRe0O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UqcKgH3o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C114219CB3;
	Thu, 17 Oct 2024 19:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729194229; cv=none; b=as7YR0bvCVbKIOqa6hidhLnAWWPkESEyqWwaMN56oFFooh4+UOi8EUWbBughp6muhTr6uJTnfy67ssi1YyKYzFY9tnosL+l/8/772QEHiud7/nd/cVyBANGb/Ad40qE9cS1Y5tsQTsCrx/1Ib9PJjTmo6f9ry52cxe0Wv2zikp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729194229; c=relaxed/simple;
	bh=PCmK15lda7GdhisRV7LP+S10jd/yCumUbPO2CqqS/AU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z2K9/L0kU5v1hDvJSAAogi32g4bAKbfd1sqmRZsSY57rqmYC1MkTLfrSDBG6YlslYFyWzqxr0OyUAQm8e4LPHOf3G0W7Mb5DbN7okxvoowGo9e6+iH0K50Quk9SuPrtel+MXlNpXDCHJ/mv1T5CA75Ma1WKbFtVvqEBgT9p9tdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kKBpRe0O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UqcKgH3o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Oct 2024 19:43:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729194221;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MSyH2uQb3NlDtSTTXiLYqYMoOwaSOqi37wGzSl+8lrs=;
	b=kKBpRe0OKZPn2hjIbkDhLcgzJ+TuAr8FuCjn06iiYLT6JIDsPJ4qauPtuatf/OvIQ5T9RU
	8KSBOqLFTHZ092CZjgccYb9HJrx0M+Tf991/5DK+58F8iORLg9pV0xV/QxARawLqE0ckZX
	o7qA6yOkgZ5VJOPtUV978OPv1JNLrGxa157cOIjgKkK5YJdA6iru/PIGS0W35e4tBHaAtX
	DEW1utUM5N5+E20omCgZyRiLq1IuojioJVZV6OeGxgX1CzVLtiYZc4qC4haaTwT9Oew6zp
	J1QEBZKWvSHIjBuZ1H1pqvRTEgikhGBZLlOihBYOqwd+KBc/WXBVt1P/Hgqeyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729194221;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MSyH2uQb3NlDtSTTXiLYqYMoOwaSOqi37wGzSl+8lrs=;
	b=UqcKgH3oEA/DDICWQG7Fbv25uxd6AkgL8kwFLLJ5kBPyNTWfgRhcIEEBjAowPGA+8xnSSH
	cJZnWCgZ361N/JDQ==
From: "tip-bot2 for Kevin Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/aspeed-intc: Add AST27XX INTC support
Cc: Kevin Chen <kevin_chen@aspeedtech.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241016022410.1154574-3-kevin_chen@aspeedtech.com>
References: <20241016022410.1154574-3-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172919422014.1442.3447666167963996973.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     010863f40fc3c3650eded3d5ebd7af7521b3c3fa
Gitweb:        https://git.kernel.org/tip/010863f40fc3c3650eded3d5ebd7af7521b3c3fa
Author:        Kevin Chen <kevin_chen@aspeedtech.com>
AuthorDate:    Wed, 16 Oct 2024 10:24:10 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Oct 2024 21:35:28 +02:00

irqchip/aspeed-intc: Add AST27XX INTC support

Support Aspeed Interrupt Controller on Aspeed Silicon SoCs.

ASPEED interrupt controller(INTC) maps the internal interrupt
sources to a parent interrupt controller, which can be GIC or INTC.

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241016022410.1154574-3-kevin_chen@aspeedtech.com

---
 drivers/irqchip/Makefile          |   1 +-
 drivers/irqchip/irq-aspeed-intc.c | 139 +++++++++++++++++++++++++++++-
 2 files changed, 140 insertions(+)
 create mode 100644 drivers/irqchip/irq-aspeed-intc.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 94ecaeb..15ed6e9 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
 obj-$(CONFIG_LS_EXTIRQ)			+= irq-ls-extirq.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o irq-aspeed-scu-ic.o
+obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-intc.o
 obj-$(CONFIG_STM32MP_EXTI)		+= irq-stm32mp-exti.o
 obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
 obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
diff --git a/drivers/irqchip/irq-aspeed-intc.c b/drivers/irqchip/irq-aspeed-intc.c
new file mode 100644
index 0000000..bd3b759
--- /dev/null
+++ b/drivers/irqchip/irq-aspeed-intc.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Aspeed Interrupt Controller.
+ *
+ *  Copyright (C) 2023 ASPEED Technology Inc.
+ */
+
+#include <linux/bitops.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/io.h>
+#include <linux/spinlock.h>
+
+#define INTC_INT_ENABLE_REG	0x00
+#define INTC_INT_STATUS_REG	0x04
+#define INTC_IRQS_PER_WORD	32
+
+struct aspeed_intc_ic {
+	void __iomem		*base;
+	raw_spinlock_t		gic_lock;
+	raw_spinlock_t		intc_lock;
+	struct irq_domain	*irq_domain;
+};
+
+static void aspeed_intc_ic_irq_handler(struct irq_desc *desc)
+{
+	struct aspeed_intc_ic *intc_ic = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	chained_irq_enter(chip, desc);
+
+	scoped_guard(raw_spinlock, &intc_ic->gic_lock) {
+		unsigned long bit, status;
+
+		status = readl(intc_ic->base + INTC_INT_STATUS_REG);
+		for_each_set_bit(bit, &status, INTC_IRQS_PER_WORD) {
+			generic_handle_domain_irq(intc_ic->irq_domain, bit);
+			writel(BIT(bit), intc_ic->base + INTC_INT_STATUS_REG);
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void aspeed_intc_irq_mask(struct irq_data *data)
+{
+	struct aspeed_intc_ic *intc_ic = irq_data_get_irq_chip_data(data);
+	unsigned int mask = readl(intc_ic->base + INTC_INT_ENABLE_REG) & ~BIT(data->hwirq);
+
+	guard(raw_spinlock)(&intc_ic->intc_lock);
+	writel(mask, intc_ic->base + INTC_INT_ENABLE_REG);
+}
+
+static void aspeed_intc_irq_unmask(struct irq_data *data)
+{
+	struct aspeed_intc_ic *intc_ic = irq_data_get_irq_chip_data(data);
+	unsigned int unmask = readl(intc_ic->base + INTC_INT_ENABLE_REG) | BIT(data->hwirq);
+
+	guard(raw_spinlock)(&intc_ic->intc_lock);
+	writel(unmask, intc_ic->base + INTC_INT_ENABLE_REG);
+}
+
+static struct irq_chip aspeed_intc_chip = {
+	.name			= "ASPEED INTC",
+	.irq_mask		= aspeed_intc_irq_mask,
+	.irq_unmask		= aspeed_intc_irq_unmask,
+};
+
+static int aspeed_intc_ic_map_irq_domain(struct irq_domain *domain, unsigned int irq,
+					 irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &aspeed_intc_chip, handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops aspeed_intc_ic_irq_domain_ops = {
+	.map = aspeed_intc_ic_map_irq_domain,
+};
+
+static int __init aspeed_intc_ic_of_init(struct device_node *node,
+					 struct device_node *parent)
+{
+	struct aspeed_intc_ic *intc_ic;
+	int irq, i, ret = 0;
+
+	intc_ic = kzalloc(sizeof(*intc_ic), GFP_KERNEL);
+	if (!intc_ic)
+		return -ENOMEM;
+
+	intc_ic->base = of_iomap(node, 0);
+	if (!intc_ic->base) {
+		pr_err("Failed to iomap intc_ic base\n");
+		ret = -ENOMEM;
+		goto err_free_ic;
+	}
+	writel(0xffffffff, intc_ic->base + INTC_INT_STATUS_REG);
+	writel(0x0, intc_ic->base + INTC_INT_ENABLE_REG);
+
+	intc_ic->irq_domain = irq_domain_add_linear(node, INTC_IRQS_PER_WORD,
+						    &aspeed_intc_ic_irq_domain_ops, intc_ic);
+	if (!intc_ic->irq_domain) {
+		ret = -ENOMEM;
+		goto err_iounmap;
+	}
+
+	raw_spin_lock_init(&intc_ic->gic_lock);
+	raw_spin_lock_init(&intc_ic->intc_lock);
+
+	/* Check all the irq numbers valid. If not, unmaps all the base and frees the data. */
+	for (i = 0; i < of_irq_count(node); i++) {
+		irq = irq_of_parse_and_map(node, i);
+		if (!irq) {
+			pr_err("Failed to get irq number\n");
+			ret = -EINVAL;
+			goto err_iounmap;
+		}
+	}
+
+	for (i = 0; i < of_irq_count(node); i++) {
+		irq = irq_of_parse_and_map(node, i);
+		irq_set_chained_handler_and_data(irq, aspeed_intc_ic_irq_handler, intc_ic);
+	}
+
+	return 0;
+
+err_iounmap:
+	iounmap(intc_ic->base);
+err_free_ic:
+	kfree(intc_ic);
+	return ret;
+}
+
+IRQCHIP_DECLARE(ast2700_intc_ic, "aspeed,ast2700-intc-ic", aspeed_intc_ic_of_init);

