Return-Path: <linux-tip-commits+bounces-2448-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3423C99FB05
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 00:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B73201F2295C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 22:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBFC1B0F3C;
	Tue, 15 Oct 2024 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xqYR2kaL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gM+JPtAX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BACB1B0F2A;
	Tue, 15 Oct 2024 22:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030364; cv=none; b=cKvYJtMs/ADODeeSUzQxocv/6vYnGzE1u22/6znVtLBFqn88b/i06kkFO96VAzkhK6YkM3Eo5fHUzCOyyapQb2RT4RkkFafYqvY86o9JRzaPyXiJAOrFH6dknl6Zo4LbUmHM+PcPUJoY5TkZK7sYE3GfOa57A2em1td+/bXeL58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030364; c=relaxed/simple;
	bh=7T/rWDud7F/ZKldlweCAlQ163L6cK/kR+2oHSbqXbO4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f7b+sz0BKhWmRB7lcHA67a2v6xUYZVfqMQGShHe8Q/j8OBOBnhSOokHmsXMCXAmMe465dhXVvgc7ZIHSCoaj/HqkrmAjGCHsTUR30B7lhYoXxm0sWIhEh+eBVwhqCfRBd5969xPJWGmrZqNObz73QHsWzHIpLnb3pPGsOiuIGQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xqYR2kaL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gM+JPtAX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 22:12:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729030355;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Dmavrii5jm+bx7t3dEWt09vA+KAKIzR6dSJ1IHXmfk=;
	b=xqYR2kaL5u8TLkIdhVXmlwxTQmNrhDRq+xUhsbJH5m6dTal+oPFxtmdLmq2nQr4kh92WwF
	D1KI6hxeotUqUhjY508tQXVC2RIi05KpRDn4tcMert7GaSJDaybYOJeZWCdNJg+vqfTQli
	Xs+7MPoN/YFe8c1M94zKggKePM62tf8Cq5H6dAZnkGOXP3lNtD+dO1IOCvofnZVw5nlMHl
	J9iq/xEYXIXqrzbcHIww6DEcTTkN6paG1J26jqF3Z9ytzyOvedtgFNUh4pgpNyf0oYjHho
	g/4B4xtC9CdsPBQkZ0v+il7FNk1CFtOrbCg/Erq/nuRvJRBufdTWwmNbUId8Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729030355;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Dmavrii5jm+bx7t3dEWt09vA+KAKIzR6dSJ1IHXmfk=;
	b=gM+JPtAXZ5zW4DHYCD1A/S9Ig9OCEESzE2tpbt2IparKYKh8BVxH8PGEcbNyvWFKf8iYjA
	KFY2fTQagYCbhGBg==
From: "tip-bot2 for Fabrizio Castro" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) driver
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241009230817.798582-3-fabrizio.castro.jz@renesas.com>
References: <20241009230817.798582-3-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172903035441.1442.10037974139291084686.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0d7605e75ac2d8620929148f932cde54746c485f
Gitweb:        https://git.kernel.org/tip/0d7605e75ac2d8620929148f932cde54746c485f
Author:        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
AuthorDate:    Thu, 10 Oct 2024 00:08:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 00:01:06 +02:00

irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) driver

Add driver for the Renesas RZ/V2H(P) Interrupt Control Unit (ICU).

This driver supports the external interrupts NMI, IRQn, and TINTn.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241009230817.798582-3-fabrizio.castro.jz@renesas.com

---
 drivers/irqchip/Kconfig             |   7 +-
 drivers/irqchip/Makefile            |   1 +-
 drivers/irqchip/irq-renesas-rzv2h.c | 513 +++++++++++++++++++++++++++-
 drivers/soc/renesas/Kconfig         |   1 +-
 4 files changed, 522 insertions(+)
 create mode 100644 drivers/irqchip/irq-renesas-rzv2h.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 341cd9c..006a47a 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -265,6 +265,13 @@ config RENESAS_RZG2L_IRQC
 	  Enable support for the Renesas RZ/G2L (and alike SoC) Interrupt Controller
 	  for external devices.
 
+config RENESAS_RZV2H_ICU
+	bool "Renesas RZ/V2H(P) ICU support" if COMPILE_TEST
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Enable support for the Renesas RZ/V2H(P) Interrupt Control Unit (ICU)
+
 config SL28CPLD_INTC
 	bool "Kontron sl28cpld IRQ controller"
 	depends on MFD_SL28CPLD=y || COMPILE_TEST
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index e3679ec..94ecaeb 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+= irq-renesas-intc-irqpin.o
 obj-$(CONFIG_RENESAS_IRQC)		+= irq-renesas-irqc.o
 obj-$(CONFIG_RENESAS_RZA1_IRQC)		+= irq-renesas-rza1.o
 obj-$(CONFIG_RENESAS_RZG2L_IRQC)	+= irq-renesas-rzg2l.o
+obj-$(CONFIG_RENESAS_RZV2H_ICU)		+= irq-renesas-rzv2h.o
 obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
 obj-$(CONFIG_ARCH_NSPIRE)		+= irq-zevio.o
 obj-$(CONFIG_ARCH_VT8500)		+= irq-vt8500.o
diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
new file mode 100644
index 0000000..fe2d29e
--- /dev/null
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -0,0 +1,513 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/V2H(P) ICU Driver
+ *
+ * Based on irq-renesas-rzg2l.c
+ *
+ * Copyright (C) 2024 Renesas Electronics Corporation.
+ *
+ * Author: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/spinlock.h>
+#include <linux/syscore_ops.h>
+
+/* DT "interrupts" indexes */
+#define ICU_IRQ_START				1
+#define ICU_IRQ_COUNT				16
+#define ICU_TINT_START				(ICU_IRQ_START + ICU_IRQ_COUNT)
+#define ICU_TINT_COUNT				32
+#define ICU_NUM_IRQ				(ICU_TINT_START + ICU_TINT_COUNT)
+
+/* Registers */
+#define ICU_NSCNT				0x00
+#define ICU_NSCLR				0x04
+#define ICU_NITSR				0x08
+#define ICU_ISCTR				0x10
+#define ICU_ISCLR				0x14
+#define ICU_IITSR				0x18
+#define ICU_TSCTR				0x20
+#define ICU_TSCLR				0x24
+#define ICU_TITSR(k)				(0x28 + (k) * 4)
+#define ICU_TSSR(k)				(0x30 + (k) * 4)
+
+/* NMI */
+#define ICU_NMI_EDGE_FALLING			0
+#define ICU_NMI_EDGE_RISING			1
+
+#define ICU_NSCLR_NCLR				BIT(0)
+
+/* IRQ */
+#define ICU_IRQ_LEVEL_LOW			0
+#define ICU_IRQ_EDGE_FALLING			1
+#define ICU_IRQ_EDGE_RISING			2
+#define ICU_IRQ_EDGE_BOTH			3
+
+#define ICU_IITSR_IITSEL_PREP(iitsel, n)	((iitsel) << ((n) * 2))
+#define ICU_IITSR_IITSEL_GET(iitsr, n)		(((iitsr) >> ((n) * 2)) & 0x03)
+#define ICU_IITSR_IITSEL_MASK(n)		ICU_IITSR_IITSEL_PREP(0x03, n)
+
+/* TINT */
+#define ICU_TINT_EDGE_RISING			0
+#define ICU_TINT_EDGE_FALLING			1
+#define ICU_TINT_LEVEL_HIGH			2
+#define ICU_TINT_LEVEL_LOW			3
+
+#define ICU_TSSR_K(tint_nr)			((tint_nr) / 4)
+#define ICU_TSSR_TSSEL_N(tint_nr)		((tint_nr) % 4)
+#define ICU_TSSR_TSSEL_PREP(tssel, n)		((tssel) << ((n) * 8))
+#define ICU_TSSR_TSSEL_MASK(n)			ICU_TSSR_TSSEL_PREP(0x7F, n)
+#define ICU_TSSR_TIEN(n)			(BIT(7) << ((n) * 8))
+
+#define ICU_TITSR_K(tint_nr)			((tint_nr) / 16)
+#define ICU_TITSR_TITSEL_N(tint_nr)		((tint_nr) % 16)
+#define ICU_TITSR_TITSEL_PREP(titsel, n)	ICU_IITSR_IITSEL_PREP(titsel, n)
+#define ICU_TITSR_TITSEL_MASK(n)		ICU_IITSR_IITSEL_MASK(n)
+#define ICU_TITSR_TITSEL_GET(titsr, n)		ICU_IITSR_IITSEL_GET(titsr, n)
+
+#define ICU_TINT_EXTRACT_HWIRQ(x)		FIELD_GET(GENMASK(15, 0), (x))
+#define ICU_TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
+#define ICU_PB5_TINT				0x55
+
+/**
+ * struct rzv2h_icu_priv - Interrupt Control Unit controller private data structure.
+ * @base:	Controller's base address
+ * @irqchip:	Pointer to struct irq_chip
+ * @fwspec:	IRQ firmware specific data
+ * @lock:	Lock to serialize access to hardware registers
+ */
+struct rzv2h_icu_priv {
+	void __iomem			*base;
+	const struct irq_chip		*irqchip;
+	struct irq_fwspec		fwspec[ICU_NUM_IRQ];
+	raw_spinlock_t			lock;
+};
+
+static inline struct rzv2h_icu_priv *irq_data_to_priv(struct irq_data *data)
+{
+	return data->domain->host_data;
+}
+
+static void rzv2h_icu_eoi(struct irq_data *d)
+{
+	struct rzv2h_icu_priv *priv = irq_data_to_priv(d);
+	unsigned int hw_irq = irqd_to_hwirq(d);
+	unsigned int tintirq_nr;
+	u32 bit;
+
+	scoped_guard(raw_spinlock, &priv->lock) {
+		if (hw_irq >= ICU_TINT_START) {
+			tintirq_nr = hw_irq - ICU_TINT_START;
+			bit = BIT(tintirq_nr);
+			if (!irqd_is_level_type(d))
+				writel_relaxed(bit, priv->base + ICU_TSCLR);
+		} else if (hw_irq >= ICU_IRQ_START) {
+			tintirq_nr = hw_irq - ICU_IRQ_START;
+			bit = BIT(tintirq_nr);
+			if (!irqd_is_level_type(d))
+				writel_relaxed(bit, priv->base + ICU_ISCLR);
+		} else {
+			writel_relaxed(ICU_NSCLR_NCLR, priv->base + ICU_NSCLR);
+		}
+	}
+
+	irq_chip_eoi_parent(d);
+}
+
+static void rzv2h_tint_irq_endisable(struct irq_data *d, bool enable)
+{
+	struct rzv2h_icu_priv *priv = irq_data_to_priv(d);
+	unsigned int hw_irq = irqd_to_hwirq(d);
+	u32 tint_nr, tssel_n, k, tssr;
+
+	if (hw_irq < ICU_TINT_START)
+		return;
+
+	tint_nr = hw_irq - ICU_TINT_START;
+	k = ICU_TSSR_K(tint_nr);
+	tssel_n = ICU_TSSR_TSSEL_N(tint_nr);
+
+	guard(raw_spinlock)(&priv->lock);
+	tssr = readl_relaxed(priv->base + ICU_TSSR(k));
+	if (enable)
+		tssr |= ICU_TSSR_TIEN(tssel_n);
+	else
+		tssr &= ~ICU_TSSR_TIEN(tssel_n);
+	writel_relaxed(tssr, priv->base + ICU_TSSR(k));
+}
+
+static void rzv2h_icu_irq_disable(struct irq_data *d)
+{
+	irq_chip_disable_parent(d);
+	rzv2h_tint_irq_endisable(d, false);
+}
+
+static void rzv2h_icu_irq_enable(struct irq_data *d)
+{
+	rzv2h_tint_irq_endisable(d, true);
+	irq_chip_enable_parent(d);
+}
+
+static int rzv2h_nmi_set_type(struct irq_data *d, unsigned int type)
+{
+	struct rzv2h_icu_priv *priv = irq_data_to_priv(d);
+	u32 sense;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_EDGE_FALLING:
+		sense = ICU_NMI_EDGE_FALLING;
+		break;
+
+	case IRQ_TYPE_EDGE_RISING:
+		sense = ICU_NMI_EDGE_RISING;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	writel_relaxed(sense, priv->base + ICU_NITSR);
+
+	return 0;
+}
+
+static void rzv2h_clear_irq_int(struct rzv2h_icu_priv *priv, unsigned int hwirq)
+{
+	unsigned int irq_nr = hwirq - ICU_IRQ_START;
+	u32 isctr, iitsr, iitsel;
+	u32 bit = BIT(irq_nr);
+
+	isctr = readl_relaxed(priv->base + ICU_ISCTR);
+	iitsr = readl_relaxed(priv->base + ICU_IITSR);
+	iitsel = ICU_IITSR_IITSEL_GET(iitsr, irq_nr);
+
+	/*
+	 * When level sensing is used, the interrupt flag gets automatically cleared when the
+	 * interrupt signal is de-asserted by the source of the interrupt request, therefore clear
+	 * the interrupt only for edge triggered interrupts.
+	 */
+	if ((isctr & bit) && (iitsel != ICU_IRQ_LEVEL_LOW))
+		writel_relaxed(bit, priv->base + ICU_ISCLR);
+}
+
+static int rzv2h_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct rzv2h_icu_priv *priv = irq_data_to_priv(d);
+	unsigned int hwirq = irqd_to_hwirq(d);
+	u32 irq_nr = hwirq - ICU_IRQ_START;
+	u32 iitsr, sense;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_LEVEL_LOW:
+		sense = ICU_IRQ_LEVEL_LOW;
+		break;
+
+	case IRQ_TYPE_EDGE_FALLING:
+		sense = ICU_IRQ_EDGE_FALLING;
+		break;
+
+	case IRQ_TYPE_EDGE_RISING:
+		sense = ICU_IRQ_EDGE_RISING;
+		break;
+
+	case IRQ_TYPE_EDGE_BOTH:
+		sense = ICU_IRQ_EDGE_BOTH;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	guard(raw_spinlock)(&priv->lock);
+	iitsr = readl_relaxed(priv->base + ICU_IITSR);
+	iitsr &= ~ICU_IITSR_IITSEL_MASK(irq_nr);
+	iitsr |= ICU_IITSR_IITSEL_PREP(sense, irq_nr);
+	rzv2h_clear_irq_int(priv, hwirq);
+	writel_relaxed(iitsr, priv->base + ICU_IITSR);
+
+	return 0;
+}
+
+static void rzv2h_clear_tint_int(struct rzv2h_icu_priv *priv, unsigned int hwirq)
+{
+	unsigned int tint_nr = hwirq - ICU_TINT_START;
+	int titsel_n = ICU_TITSR_TITSEL_N(tint_nr);
+	u32 tsctr, titsr, titsel;
+	u32 bit = BIT(tint_nr);
+	int k = tint_nr / 16;
+
+	tsctr = readl_relaxed(priv->base + ICU_TSCTR);
+	titsr = readl_relaxed(priv->base + ICU_TITSR(k));
+	titsel = ICU_TITSR_TITSEL_GET(titsr, titsel_n);
+
+	/*
+	 * Writing 1 to the corresponding flag from register ICU_TSCTR only has effect if
+	 * TSTATn = 1b and if it's a rising edge or a falling edge interrupt.
+	 */
+	if ((tsctr & bit) && ((titsel == ICU_TINT_EDGE_RISING) ||
+			      (titsel == ICU_TINT_EDGE_FALLING)))
+		writel_relaxed(bit, priv->base + ICU_TSCLR);
+}
+
+static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
+{
+	u32 titsr, titsr_k, titsel_n, tien;
+	struct rzv2h_icu_priv *priv;
+	u32 tssr, tssr_k, tssel_n;
+	unsigned int hwirq;
+	u32 tint, sense;
+	int tint_nr;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_LEVEL_LOW:
+		sense = ICU_TINT_LEVEL_LOW;
+		break;
+
+	case IRQ_TYPE_LEVEL_HIGH:
+		sense = ICU_TINT_LEVEL_HIGH;
+		break;
+
+	case IRQ_TYPE_EDGE_RISING:
+		sense = ICU_TINT_EDGE_RISING;
+		break;
+
+	case IRQ_TYPE_EDGE_FALLING:
+		sense = ICU_TINT_EDGE_FALLING;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	tint = (u32)(uintptr_t)irq_data_get_irq_chip_data(d);
+	if (tint > ICU_PB5_TINT)
+		return -EINVAL;
+
+	priv = irq_data_to_priv(d);
+	hwirq = irqd_to_hwirq(d);
+
+	tint_nr = hwirq - ICU_TINT_START;
+
+	tssr_k = ICU_TSSR_K(tint_nr);
+	tssel_n = ICU_TSSR_TSSEL_N(tint_nr);
+
+	titsr_k = ICU_TITSR_K(tint_nr);
+	titsel_n = ICU_TITSR_TITSEL_N(tint_nr);
+	tien = ICU_TSSR_TIEN(titsel_n);
+
+	guard(raw_spinlock)(&priv->lock);
+
+	tssr = readl_relaxed(priv->base + ICU_TSSR(tssr_k));
+	tssr &= ~(ICU_TSSR_TSSEL_MASK(tssel_n) | tien);
+	tssr |= ICU_TSSR_TSSEL_PREP(tint, tssel_n);
+
+	writel_relaxed(tssr, priv->base + ICU_TSSR(tssr_k));
+
+	titsr = readl_relaxed(priv->base + ICU_TITSR(titsr_k));
+	titsr &= ~ICU_TITSR_TITSEL_MASK(titsel_n);
+	titsr |= ICU_TITSR_TITSEL_PREP(sense, titsel_n);
+
+	writel_relaxed(titsr, priv->base + ICU_TITSR(titsr_k));
+
+	rzv2h_clear_tint_int(priv, hwirq);
+
+	writel_relaxed(tssr | tien, priv->base + ICU_TSSR(tssr_k));
+
+	return 0;
+}
+
+static int rzv2h_icu_set_type(struct irq_data *d, unsigned int type)
+{
+	unsigned int hw_irq = irqd_to_hwirq(d);
+	int ret;
+
+	if (hw_irq >= ICU_TINT_START)
+		ret = rzv2h_tint_set_type(d, type);
+	else if (hw_irq >= ICU_IRQ_START)
+		ret = rzv2h_irq_set_type(d, type);
+	else
+		ret = rzv2h_nmi_set_type(d, type);
+
+	if (ret)
+		return ret;
+
+	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
+}
+
+static const struct irq_chip rzv2h_icu_chip = {
+	.name			= "rzv2h-icu",
+	.irq_eoi		= rzv2h_icu_eoi,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_disable		= rzv2h_icu_irq_disable,
+	.irq_enable		= rzv2h_icu_irq_enable,
+	.irq_get_irqchip_state	= irq_chip_get_parent_state,
+	.irq_set_irqchip_state	= irq_chip_set_parent_state,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_type		= rzv2h_icu_set_type,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.flags			= IRQCHIP_SET_TYPE_MASKED,
+};
+
+static int rzv2h_icu_alloc(struct irq_domain *domain, unsigned int virq, unsigned int nr_irqs,
+			   void *arg)
+{
+	struct rzv2h_icu_priv *priv = domain->host_data;
+	unsigned long tint = 0;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int ret;
+
+	ret = irq_domain_translate_twocell(domain, arg, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	/*
+	 * For TINT interrupts the hwirq and TINT are encoded in
+	 * fwspec->param[0].
+	 * hwirq is embedded in bits 0-15.
+	 * TINT is embedded in bits 16-31.
+	 */
+	if (hwirq >= ICU_TINT_START) {
+		tint = ICU_TINT_EXTRACT_GPIOINT(hwirq);
+		hwirq = ICU_TINT_EXTRACT_HWIRQ(hwirq);
+
+		if (hwirq < ICU_TINT_START)
+			return -EINVAL;
+	}
+
+	if (hwirq > (ICU_NUM_IRQ - 1))
+		return -EINVAL;
+
+	ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq, priv->irqchip,
+					    (void *)(uintptr_t)tint);
+	if (ret)
+		return ret;
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &priv->fwspec[hwirq]);
+}
+
+static const struct irq_domain_ops rzv2h_icu_domain_ops = {
+	.alloc		= rzv2h_icu_alloc,
+	.free		= irq_domain_free_irqs_common,
+	.translate	= irq_domain_translate_twocell,
+};
+
+static int rzv2h_icu_parse_interrupts(struct rzv2h_icu_priv *priv, struct device_node *np)
+{
+	struct of_phandle_args map;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < ICU_NUM_IRQ; i++) {
+		ret = of_irq_parse_one(np, i, &map);
+		if (ret)
+			return ret;
+
+		of_phandle_args_to_fwspec(np, map.args, map.args_count, &priv->fwspec[i]);
+	}
+
+	return 0;
+}
+
+static int rzv2h_icu_init(struct device_node *node, struct device_node *parent)
+{
+	struct irq_domain *irq_domain, *parent_domain;
+	struct rzv2h_icu_priv *rzv2h_icu_data;
+	struct platform_device *pdev;
+	struct reset_control *resetn;
+	int ret;
+
+	pdev = of_find_device_by_node(node);
+	if (!pdev)
+		return -ENODEV;
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		dev_err(&pdev->dev, "cannot find parent domain\n");
+		ret = -ENODEV;
+		goto put_dev;
+	}
+
+	rzv2h_icu_data = devm_kzalloc(&pdev->dev, sizeof(*rzv2h_icu_data), GFP_KERNEL);
+	if (!rzv2h_icu_data) {
+		ret = -ENOMEM;
+		goto put_dev;
+	}
+
+	rzv2h_icu_data->irqchip = &rzv2h_icu_chip;
+
+	rzv2h_icu_data->base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
+	if (IS_ERR(rzv2h_icu_data->base)) {
+		ret = PTR_ERR(rzv2h_icu_data->base);
+		goto put_dev;
+	}
+
+	ret = rzv2h_icu_parse_interrupts(rzv2h_icu_data, node);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot parse interrupts: %d\n", ret);
+		goto put_dev;
+	}
+
+	resetn = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(resetn)) {
+		ret = PTR_ERR(resetn);
+		goto put_dev;
+	}
+
+	ret = reset_control_deassert(resetn);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to deassert resetn pin, %d\n", ret);
+		goto put_dev;
+	}
+
+	pm_runtime_enable(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "pm_runtime_resume_and_get failed: %d\n", ret);
+		goto pm_disable;
+	}
+
+	raw_spin_lock_init(&rzv2h_icu_data->lock);
+
+	irq_domain = irq_domain_add_hierarchy(parent_domain, 0, ICU_NUM_IRQ, node,
+					      &rzv2h_icu_domain_ops, rzv2h_icu_data);
+	if (!irq_domain) {
+		dev_err(&pdev->dev, "failed to add irq domain\n");
+		ret = -ENOMEM;
+		goto pm_put;
+	}
+
+	/*
+	 * coccicheck complains about a missing put_device call before returning, but it's a false
+	 * positive. We still need &pdev->dev after successfully returning from this function.
+	 */
+	return 0;
+
+pm_put:
+	pm_runtime_put(&pdev->dev);
+pm_disable:
+	pm_runtime_disable(&pdev->dev);
+	reset_control_assert(resetn);
+put_dev:
+	put_device(&pdev->dev);
+
+	return ret;
+}
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(rzv2h_icu)
+IRQCHIP_MATCH("renesas,r9a09g057-icu", rzv2h_icu_init)
+IRQCHIP_PLATFORM_DRIVER_END(rzv2h_icu)
+MODULE_AUTHOR("Fabrizio Castro <fabrizio.castro.jz@renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/V2H(P) ICU Driver");
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 5d94c3f..9f7fe02 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -347,6 +347,7 @@ config ARCH_R9A09G011
 
 config ARCH_R9A09G057
 	bool "ARM64 Platform support for RZ/V2H(P)"
+	select RENESAS_RZV2H_ICU
 	help
 	  This enables support for the Renesas RZ/V2H(P) SoC variants.
 

