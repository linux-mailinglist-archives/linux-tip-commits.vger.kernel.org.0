Return-Path: <linux-tip-commits+bounces-6524-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEADB4AA7E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 12:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363671898104
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 10:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8489C2C0F60;
	Tue,  9 Sep 2025 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jlHl9lKO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E+1XGl2m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E50323ABB3;
	Tue,  9 Sep 2025 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413505; cv=none; b=IRkHH95BhWo+DaANIE+i9mlivbigJhuooCCpPHBdvnE1D1SqUWOwSkWZw7cDvNmMnfc5hkLHok9eptx5e7LDNq+SqwGp3NZJdd+9IowuMKXsdnO3Mz8Sv92rZqoKpi3tAAnlIh3uUT9rgfigyu3wYlVQs7vuDI6ZT/rhBHkyo0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413505; c=relaxed/simple;
	bh=rWIXf/mByDS+S1k9uVyDbHglf4hRBH0qVGzyBM5dS2U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QuqolNzFyPuIYOSnGbIzx6xktl3y+LF/200NzrXnu8oopzRuB9X46YxvJEssCsYFXQOE1vV0z+EVxxz/QzLXd84sa0zdKXUs1bHwGJoc2XaAbmGpkmwXbG4P1nN2s8gww+97iBSS0xF4WEjhc8gOYVChj0FPbS09rd0qcNi+VF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jlHl9lKO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E+1XGl2m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 10:25:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757413501;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AvzCCb786skApJXIZwhNtJEfnReSWoRYp9/fECqcY50=;
	b=jlHl9lKOAaJB6a4PAlLZyyP/3oqi1MoP97hwAAFHaBjhRkCQkBJB6nWb/uy5R0E6CwOuLx
	OZW5Zk0+ETGYY5pROE4Wc8c/1R6mkp6mYtnTZn9hvsYDKHFSoHEMN2M59gxt9L2GZCLLwg
	FZ9tbelmRUxG2cH9aYyTorBcAyb9SrgFD0fTUOyV4UkKvkeTbomlNsB3la3J6uDx7zagXA
	cHQGjWx56vRQCJPc2D476vTgohOZJatSgA9y8RRe3cfarxTqtn2uv/FOTIKVZ1RisrKicP
	RP/R/tCJqIj1ek6K4kquEDjSfG4LkqlWj9Mr10cyOADx3+nG+pigidOUWL0Jow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757413501;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AvzCCb786skApJXIZwhNtJEfnReSWoRYp9/fECqcY50=;
	b=E+1XGl2mohjq2GmIfqjtMGzL41e/L+cGDUFzGMItjYCB4mtS8Zi2oMjDtmriGRxk5PAAh5
	b2uH7ARrCNui7BCA==
From: "tip-bot2 for Ryan Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/aspeed-scu-ic: Add support for AST2700 SCU
 interrupt controllers
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250908011812.1033858-5-ryan_chen@aspeedtech.com>
References: <20250908011812.1033858-5-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175741350010.1920.10610091199224307074.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     b2a0c13f8b4fc3f6c8b279fdc4395a5fa57dda5d
Gitweb:        https://git.kernel.org/tip/b2a0c13f8b4fc3f6c8b279fdc4395a5fa57=
dda5d
Author:        Ryan Chen <ryan_chen@aspeedtech.com>
AuthorDate:    Mon, 08 Sep 2025 09:18:12 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 12:23:29 +02:00

irqchip/aspeed-scu-ic: Add support for AST2700 SCU interrupt controllers

AST2700 continues the multi-instance SCU interrupt controller model
introduced in the AST2600, with four independent interrupt domains (scu-ic0
to 3).

Unlike earlier generations which combine interrupt enable and status bits
into a single register, AST2700 separates these into distinct IER and ISR
registers. Support for this layout is implemented by using register offsets
and separate chained IRQ handlers.

The variant table is extended to cover AST2700 IC instances, enabling
shared initialization logic while preserving support for previous SoCs.

[ tglx: Simplified the logic and cleaned up coding style ]

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250908011812.1033858-5-ryan_chen@aspeedte=
ch.com

---
 drivers/irqchip/irq-aspeed-scu-ic.c | 119 +++++++++++++++++++++++----
 1 file changed, 102 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed=
-scu-ic.c
index 9c1fbdd..5584e0f 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Aspeed AST24XX, AST25XX, and AST26XX SCU Interrupt Controller
+ * Aspeed AST24XX, AST25XX, AST26XX, and AST27XX SCU Interrupt Controller
  * Copyright 2019 IBM Corporation
  *
  * Eddie James <eajames@linux.ibm.com>
@@ -17,26 +17,35 @@
=20
 #define ASPEED_SCU_IC_STATUS		GENMASK(28, 16)
 #define ASPEED_SCU_IC_STATUS_SHIFT	16
+#define AST2700_SCU_IC_STATUS		GENMASK(15, 0)
=20
 struct aspeed_scu_ic_variant {
 	const char	*compatible;
 	unsigned long	irq_enable;
 	unsigned long	irq_shift;
 	unsigned int	num_irqs;
+	unsigned long	ier;
+	unsigned long	isr;
 };
=20
-#define SCU_VARIANT(_compat, _shift, _enable, _num) {	\
+#define SCU_VARIANT(_compat, _shift, _enable, _num, _ier, _isr) {	\
 	.compatible		=3D	_compat,	\
 	.irq_shift		=3D	_shift,		\
 	.irq_enable		=3D	_enable,	\
 	.num_irqs		=3D	_num,		\
+	.ier			=3D	_ier,		\
+	.isr			=3D	_isr,		\
 }
=20
 static const struct aspeed_scu_ic_variant scu_ic_variants[]	__initconst =3D {
-	SCU_VARIANT("aspeed,ast2400-scu-ic",	0, GENMASK(15, 0),	7),
-	SCU_VARIANT("aspeed,ast2500-scu-ic",	0, GENMASK(15, 0),	7),
-	SCU_VARIANT("aspeed,ast2600-scu-ic0",	0, GENMASK(5, 0),	6),
-	SCU_VARIANT("aspeed,ast2600-scu-ic1",	4, GENMASK(5, 4),	2),
+	SCU_VARIANT("aspeed,ast2400-scu-ic",	0, GENMASK(15, 0),	7, 0x00, 0x00),
+	SCU_VARIANT("aspeed,ast2500-scu-ic",	0, GENMASK(15, 0),	7, 0x00, 0x00),
+	SCU_VARIANT("aspeed,ast2600-scu-ic0",	0, GENMASK(5, 0),	6, 0x00, 0x00),
+	SCU_VARIANT("aspeed,ast2600-scu-ic1",	4, GENMASK(5, 4),	2, 0x00, 0x00),
+	SCU_VARIANT("aspeed,ast2700-scu-ic0",	0, GENMASK(3, 0),	4, 0x00, 0x04),
+	SCU_VARIANT("aspeed,ast2700-scu-ic1",	0, GENMASK(3, 0),	4, 0x00, 0x04),
+	SCU_VARIANT("aspeed,ast2700-scu-ic2",	0, GENMASK(3, 0),	4, 0x04, 0x00),
+	SCU_VARIANT("aspeed,ast2700-scu-ic3",	0, GENMASK(1, 0),	2, 0x04, 0x00),
 };
=20
 struct aspeed_scu_ic {
@@ -45,9 +54,16 @@ struct aspeed_scu_ic {
 	unsigned int		num_irqs;
 	void __iomem		*base;
 	struct irq_domain	*irq_domain;
+	unsigned long		ier;
+	unsigned long		isr;
 };
=20
-static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
+static inline bool scu_has_split_isr(struct aspeed_scu_ic *scu)
+{
+	return scu->ier !=3D scu->isr;
+}
+
+static void aspeed_scu_ic_irq_handler_combined(struct irq_desc *desc)
 {
 	struct aspeed_scu_ic *scu_ic =3D irq_desc_get_handler_data(desc);
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
@@ -83,7 +99,34 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *des=
c)
 	chained_irq_exit(chip, desc);
 }
=20
-static void aspeed_scu_ic_irq_mask(struct irq_data *data)
+static void aspeed_scu_ic_irq_handler_split(struct irq_desc *desc)
+{
+	struct aspeed_scu_ic *scu_ic =3D irq_desc_get_handler_data(desc);
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
+	unsigned long bit, enabled, max, status;
+	unsigned int sts, mask;
+
+	chained_irq_enter(chip, desc);
+
+	mask =3D scu_ic->irq_enable;
+	sts =3D readl(scu_ic->base + scu_ic->isr);
+	enabled =3D sts & scu_ic->irq_enable;
+	sts =3D readl(scu_ic->base + scu_ic->isr);
+	status =3D sts & enabled;
+
+	bit =3D scu_ic->irq_shift;
+	max =3D scu_ic->num_irqs + bit;
+
+	for_each_set_bit_from(bit, &status, max) {
+		generic_handle_domain_irq(scu_ic->irq_domain, bit - scu_ic->irq_shift);
+		/* Clear interrupt */
+		writel(BIT(bit), scu_ic->base + scu_ic->isr);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void aspeed_scu_ic_irq_mask_combined(struct irq_data *data)
 {
 	struct aspeed_scu_ic *scu_ic =3D irq_data_get_irq_chip_data(data);
 	unsigned int bit =3D BIT(data->hwirq + scu_ic->irq_shift);
@@ -97,7 +140,7 @@ static void aspeed_scu_ic_irq_mask(struct irq_data *data)
 	writel(readl(scu_ic->base) & ~mask, scu_ic->base);
 }
=20
-static void aspeed_scu_ic_irq_unmask(struct irq_data *data)
+static void aspeed_scu_ic_irq_unmask_combined(struct irq_data *data)
 {
 	struct aspeed_scu_ic *scu_ic =3D irq_data_get_irq_chip_data(data);
 	unsigned int bit =3D BIT(data->hwirq + scu_ic->irq_shift);
@@ -111,6 +154,22 @@ static void aspeed_scu_ic_irq_unmask(struct irq_data *da=
ta)
 	writel((readl(scu_ic->base) & ~mask) | bit, scu_ic->base);
 }
=20
+static void aspeed_scu_ic_irq_mask_split(struct irq_data *data)
+{
+	struct aspeed_scu_ic *scu_ic =3D irq_data_get_irq_chip_data(data);
+	unsigned int mask =3D BIT(data->hwirq + scu_ic->irq_shift);
+
+	writel(readl(scu_ic->base) & ~mask, scu_ic->base + scu_ic->ier);
+}
+
+static void aspeed_scu_ic_irq_unmask_split(struct irq_data *data)
+{
+	struct aspeed_scu_ic *scu_ic =3D irq_data_get_irq_chip_data(data);
+	unsigned int bit =3D BIT(data->hwirq + scu_ic->irq_shift);
+
+	writel(readl(scu_ic->base) | bit, scu_ic->base + scu_ic->ier);
+}
+
 static int aspeed_scu_ic_irq_set_affinity(struct irq_data *data,
 					  const struct cpumask *dest,
 					  bool force)
@@ -118,17 +177,29 @@ static int aspeed_scu_ic_irq_set_affinity(struct irq_da=
ta *data,
 	return -EINVAL;
 }
=20
-static struct irq_chip aspeed_scu_ic_chip =3D {
+static struct irq_chip aspeed_scu_ic_chip_combined =3D {
 	.name			=3D "aspeed-scu-ic",
-	.irq_mask		=3D aspeed_scu_ic_irq_mask,
-	.irq_unmask		=3D aspeed_scu_ic_irq_unmask,
-	.irq_set_affinity	=3D aspeed_scu_ic_irq_set_affinity,
+	.irq_mask		=3D aspeed_scu_ic_irq_mask_combined,
+	.irq_unmask		=3D aspeed_scu_ic_irq_unmask_combined,
+	.irq_set_affinity       =3D aspeed_scu_ic_irq_set_affinity,
+};
+
+static struct irq_chip aspeed_scu_ic_chip_split =3D {
+	.name			=3D "ast2700-scu-ic",
+	.irq_mask		=3D aspeed_scu_ic_irq_mask_split,
+	.irq_unmask		=3D aspeed_scu_ic_irq_unmask_split,
+	.irq_set_affinity       =3D aspeed_scu_ic_irq_set_affinity,
 };
=20
 static int aspeed_scu_ic_map(struct irq_domain *domain, unsigned int irq,
 			     irq_hw_number_t hwirq)
 {
-	irq_set_chip_and_handler(irq, &aspeed_scu_ic_chip, handle_level_irq);
+	struct aspeed_scu_ic *scu_ic =3D domain->host_data;
+
+	if (scu_has_split_isr(scu_ic))
+		irq_set_chip_and_handler(irq, &aspeed_scu_ic_chip_split, handle_level_irq);
+	else
+		irq_set_chip_and_handler(irq, &aspeed_scu_ic_chip_combined, handle_level_i=
rq);
 	irq_set_chip_data(irq, domain->host_data);
=20
 	return 0;
@@ -148,8 +219,14 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_sc=
u_ic *scu_ic,
 		rc =3D PTR_ERR(scu_ic->base);
 		goto err;
 	}
-	writel(ASPEED_SCU_IC_STATUS, scu_ic->base);
-	writel(0, scu_ic->base);
+
+	if (scu_has_split_isr(scu_ic)) {
+		writel(AST2700_SCU_IC_STATUS, scu_ic->base + scu_ic->isr);
+		writel(0, scu_ic->base + scu_ic->ier);
+	} else {
+		writel(ASPEED_SCU_IC_STATUS, scu_ic->base);
+		writel(0, scu_ic->base);
+	}
=20
 	irq =3D irq_of_parse_and_map(node, 0);
 	if (!irq) {
@@ -164,7 +241,9 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_scu=
_ic *scu_ic,
 		goto err;
 	}
=20
-	irq_set_chained_handler_and_data(irq, aspeed_scu_ic_irq_handler,
+	irq_set_chained_handler_and_data(irq, scu_has_split_isr(scu_ic) ?
+					 aspeed_scu_ic_irq_handler_split :
+					 aspeed_scu_ic_irq_handler_combined,
 					 scu_ic);
=20
 	return 0;
@@ -199,6 +278,8 @@ static int __init aspeed_scu_ic_of_init(struct device_nod=
e *node, struct device_
 	scu_ic->irq_enable	=3D variant->irq_enable;
 	scu_ic->irq_shift	=3D variant->irq_shift;
 	scu_ic->num_irqs	=3D variant->num_irqs;
+	scu_ic->ier		=3D variant->ier;
+	scu_ic->isr		=3D variant->isr;
=20
 	return aspeed_scu_ic_of_init_common(scu_ic, node);
 }
@@ -207,3 +288,7 @@ IRQCHIP_DECLARE(ast2400_scu_ic, "aspeed,ast2400-scu-ic", =
aspeed_scu_ic_of_init);
 IRQCHIP_DECLARE(ast2500_scu_ic, "aspeed,ast2500-scu-ic", aspeed_scu_ic_of_in=
it);
 IRQCHIP_DECLARE(ast2600_scu_ic0, "aspeed,ast2600-scu-ic0", aspeed_scu_ic_of_=
init);
 IRQCHIP_DECLARE(ast2600_scu_ic1, "aspeed,ast2600-scu-ic1", aspeed_scu_ic_of_=
init);
+IRQCHIP_DECLARE(ast2700_scu_ic0, "aspeed,ast2700-scu-ic0", aspeed_scu_ic_of_=
init);
+IRQCHIP_DECLARE(ast2700_scu_ic1, "aspeed,ast2700-scu-ic1", aspeed_scu_ic_of_=
init);
+IRQCHIP_DECLARE(ast2700_scu_ic2, "aspeed,ast2700-scu-ic2", aspeed_scu_ic_of_=
init);
+IRQCHIP_DECLARE(ast2700_scu_ic3, "aspeed,ast2700-scu-ic3", aspeed_scu_ic_of_=
init);

