Return-Path: <linux-tip-commits+bounces-6527-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFE4B4AA85
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 12:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831D01C22F67
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 10:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7C931B83E;
	Tue,  9 Sep 2025 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MAoSEieK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Fp8Hfj9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110FC3191B4;
	Tue,  9 Sep 2025 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413508; cv=none; b=Oqu7786a0bDzhrIqThFJveQGGO7JqNkRUUfSF711Afcfh5BwbaPFPFbUS8BmwwIIZKLyptX3CRbUPw/0hl+rkGB0ydcsKJdu5yq3TYCU2+WBLbIhLmkUagdujGUQ+FV0W+ZU1dED8QLFdwkISQT0/I4u6HwmFQ8ON/z0y0KjeD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413508; c=relaxed/simple;
	bh=NyK0HE/RP+DSdAzW2Nfai7ol5pVeuU5q/ZG3PJS1eco=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aKzkB5zx2FtMOBx8pGTdqua8wF7z4LOV6YfyhBJKLNckXP7nSiAW2eRxsijnQHHn1fTePZxe4Cepd13eYvBEVxy9ASkIgki6zISNDSCaIkTpyDqO4DBOG45xsFwxbs9STb2PG7TxGvUPW+dvYgQZKNXxz0j2Kke8Bu/ePH6OamI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MAoSEieK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4Fp8Hfj9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 10:25:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757413505;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bXLJTbIfsiZvFvyXT9cJhql0CSNaFfdwqP3FgNxIwt4=;
	b=MAoSEieKNVC+9ZHNZP2+i0EbPmxPxJVXzmjH9KksP3XMgwQONML6b12dNawzafRi5ymp/B
	iDYk7bsCLqyHuIMRnl7Hli3INMmlegjXXwIUpAb9fZ3OEAf87/9UNlLLo+ZPYj4g0tXD/3
	lsh19g/qo8w1nR4XtGd/AFnjZXkxFcf3tDspNsrUDLLcSvUAXhCIEJHNRTuothc5hMjYwf
	IF7Mw7czt47idDs3/kn2PtLhAaoAy2B1fDFPiW6rdcwBs8/KT2UFfjwoyaL4DSg+kYOzNl
	fssPn2Piks1Hw2B/rjUkd8RBJDfpqMl/dvM8yFOJW8P1RsjL3tJpGfJ/mk5yOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757413505;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bXLJTbIfsiZvFvyXT9cJhql0CSNaFfdwqP3FgNxIwt4=;
	b=4Fp8Hfj9ADqsBTXJMQJw5hrKx8n8+pp1d/Dw0MthTEr7QEio9+vh/9qut780ZZ3Gp60gfU
	vbC1AXBmHpek4qBA==
From: "tip-bot2 for Ryan Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/aspeed-scu-ic: Refactor driver to support
 variant-based initialization
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250908011812.1033858-2-ryan_chen@aspeedtech.com>
References: <20250908011812.1033858-2-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175741350382.1920.4559311494080467118.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     86cd4301c285b5e48f6bb0c1b9eb3bfcaf7315a6
Gitweb:        https://git.kernel.org/tip/86cd4301c285b5e48f6bb0c1b9eb3bfcaf7=
315a6
Author:        Ryan Chen <ryan_chen@aspeedtech.com>
AuthorDate:    Mon, 08 Sep 2025 09:18:09 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 12:23:28 +02:00

irqchip/aspeed-scu-ic: Refactor driver to support variant-based initialization

The SCU IC driver handles each AST2600 instance with separate
initialization functions and hardcoded register definitions, which is
inflexible and creates duplicated code.

Consolidate the implementation by introducing a variant-based structure,
selected via compatible string, and use a unified init path and MMIO access
via of_iomap().  This simplifies the code and prepares for upcoming SoCs
like AST2700, which require split register handling.

[ tglx: Cleaned up coding style and massaged change log ]

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250908011812.1033858-2-ryan_chen@aspeedte=
ch.com

---
 drivers/irqchip/irq-aspeed-scu-ic.c | 157 ++++++++++-----------------
 1 file changed, 63 insertions(+), 94 deletions(-)

diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed=
-scu-ic.c
index 1c70454..9c1fbdd 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -7,55 +7,56 @@
  */
=20
 #include <linux/bitops.h>
+#include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
-#include <linux/mfd/syscon.h>
+#include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/regmap.h>
=20
-#define ASPEED_SCU_IC_REG		0x018
-#define ASPEED_SCU_IC_SHIFT		0
-#define ASPEED_SCU_IC_ENABLE		GENMASK(15, ASPEED_SCU_IC_SHIFT)
-#define ASPEED_SCU_IC_NUM_IRQS		7
 #define ASPEED_SCU_IC_STATUS		GENMASK(28, 16)
 #define ASPEED_SCU_IC_STATUS_SHIFT	16
=20
-#define ASPEED_AST2600_SCU_IC0_REG	0x560
-#define ASPEED_AST2600_SCU_IC0_SHIFT	0
-#define ASPEED_AST2600_SCU_IC0_ENABLE	\
-	GENMASK(5, ASPEED_AST2600_SCU_IC0_SHIFT)
-#define ASPEED_AST2600_SCU_IC0_NUM_IRQS	6
+struct aspeed_scu_ic_variant {
+	const char	*compatible;
+	unsigned long	irq_enable;
+	unsigned long	irq_shift;
+	unsigned int	num_irqs;
+};
+
+#define SCU_VARIANT(_compat, _shift, _enable, _num) {	\
+	.compatible		=3D	_compat,	\
+	.irq_shift		=3D	_shift,		\
+	.irq_enable		=3D	_enable,	\
+	.num_irqs		=3D	_num,		\
+}
=20
-#define ASPEED_AST2600_SCU_IC1_REG	0x570
-#define ASPEED_AST2600_SCU_IC1_SHIFT	4
-#define ASPEED_AST2600_SCU_IC1_ENABLE	\
-	GENMASK(5, ASPEED_AST2600_SCU_IC1_SHIFT)
-#define ASPEED_AST2600_SCU_IC1_NUM_IRQS	2
+static const struct aspeed_scu_ic_variant scu_ic_variants[]	__initconst =3D {
+	SCU_VARIANT("aspeed,ast2400-scu-ic",	0, GENMASK(15, 0),	7),
+	SCU_VARIANT("aspeed,ast2500-scu-ic",	0, GENMASK(15, 0),	7),
+	SCU_VARIANT("aspeed,ast2600-scu-ic0",	0, GENMASK(5, 0),	6),
+	SCU_VARIANT("aspeed,ast2600-scu-ic1",	4, GENMASK(5, 4),	2),
+};
=20
 struct aspeed_scu_ic {
-	unsigned long irq_enable;
-	unsigned long irq_shift;
-	unsigned int num_irqs;
-	unsigned int reg;
-	struct regmap *scu;
-	struct irq_domain *irq_domain;
+	unsigned long		irq_enable;
+	unsigned long		irq_shift;
+	unsigned int		num_irqs;
+	void __iomem		*base;
+	struct irq_domain	*irq_domain;
 };
=20
 static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
 {
-	unsigned int sts;
-	unsigned long bit;
-	unsigned long enabled;
-	unsigned long max;
-	unsigned long status;
 	struct aspeed_scu_ic *scu_ic =3D irq_desc_get_handler_data(desc);
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	unsigned int mask =3D scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT;
+	unsigned long bit, enabled, max, status;
+	unsigned int sts, mask;
=20
 	chained_irq_enter(chip, desc);
=20
+	mask =3D scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT;
 	/*
 	 * The SCU IC has just one register to control its operation and read
 	 * status. The interrupt enable bits occupy the lower 16 bits of the
@@ -66,7 +67,7 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *desc)
 	 * shifting the status down to get the mapping and then back up to
 	 * clear the bit.
 	 */
-	regmap_read(scu_ic->scu, scu_ic->reg, &sts);
+	sts =3D readl(scu_ic->base);
 	enabled =3D sts & scu_ic->irq_enable;
 	status =3D (sts >> ASPEED_SCU_IC_STATUS_SHIFT) & enabled;
=20
@@ -74,11 +75,9 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *des=
c)
 	max =3D scu_ic->num_irqs + bit;
=20
 	for_each_set_bit_from(bit, &status, max) {
-		generic_handle_domain_irq(scu_ic->irq_domain,
-					  bit - scu_ic->irq_shift);
-
-		regmap_write_bits(scu_ic->scu, scu_ic->reg, mask,
-				  BIT(bit + ASPEED_SCU_IC_STATUS_SHIFT));
+		generic_handle_domain_irq(scu_ic->irq_domain, bit - scu_ic->irq_shift);
+		writel((readl(scu_ic->base) & ~mask) | BIT(bit + ASPEED_SCU_IC_STATUS_SHIF=
T),
+		       scu_ic->base);
 	}
=20
 	chained_irq_exit(chip, desc);
@@ -87,30 +86,29 @@ static void aspeed_scu_ic_irq_handler(struct irq_desc *de=
sc)
 static void aspeed_scu_ic_irq_mask(struct irq_data *data)
 {
 	struct aspeed_scu_ic *scu_ic =3D irq_data_get_irq_chip_data(data);
-	unsigned int mask =3D BIT(data->hwirq + scu_ic->irq_shift) |
-		(scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
+	unsigned int bit =3D BIT(data->hwirq + scu_ic->irq_shift);
+	unsigned int mask =3D bit | (scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHI=
FT);
=20
 	/*
 	 * Status bits are cleared by writing 1. In order to prevent the mask
 	 * operation from clearing the status bits, they should be under the
 	 * mask and written with 0.
 	 */
-	regmap_update_bits(scu_ic->scu, scu_ic->reg, mask, 0);
+	writel(readl(scu_ic->base) & ~mask, scu_ic->base);
 }
=20
 static void aspeed_scu_ic_irq_unmask(struct irq_data *data)
 {
 	struct aspeed_scu_ic *scu_ic =3D irq_data_get_irq_chip_data(data);
 	unsigned int bit =3D BIT(data->hwirq + scu_ic->irq_shift);
-	unsigned int mask =3D bit |
-		(scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT);
+	unsigned int mask =3D bit | (scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHI=
FT);
=20
 	/*
 	 * Status bits are cleared by writing 1. In order to prevent the unmask
 	 * operation from clearing the status bits, they should be under the
 	 * mask and written with 0.
 	 */
-	regmap_update_bits(scu_ic->scu, scu_ic->reg, mask, bit);
+	writel((readl(scu_ic->base) & ~mask) | bit, scu_ic->base);
 }
=20
 static int aspeed_scu_ic_irq_set_affinity(struct irq_data *data,
@@ -143,21 +141,15 @@ static const struct irq_domain_ops aspeed_scu_ic_domain=
_ops =3D {
 static int aspeed_scu_ic_of_init_common(struct aspeed_scu_ic *scu_ic,
 					struct device_node *node)
 {
-	int irq;
-	int rc =3D 0;
+	int irq, rc =3D 0;
=20
-	if (!node->parent) {
-		rc =3D -ENODEV;
+	scu_ic->base =3D of_iomap(node, 0);
+	if (IS_ERR(scu_ic->base)) {
+		rc =3D PTR_ERR(scu_ic->base);
 		goto err;
 	}
-
-	scu_ic->scu =3D syscon_node_to_regmap(node->parent);
-	if (IS_ERR(scu_ic->scu)) {
-		rc =3D PTR_ERR(scu_ic->scu);
-		goto err;
-	}
-	regmap_write_bits(scu_ic->scu, scu_ic->reg, ASPEED_SCU_IC_STATUS, ASPEED_SC=
U_IC_STATUS);
-	regmap_write_bits(scu_ic->scu, scu_ic->reg, ASPEED_SCU_IC_ENABLE, 0);
+	writel(ASPEED_SCU_IC_STATUS, scu_ic->base);
+	writel(0, scu_ic->base);
=20
 	irq =3D irq_of_parse_and_map(node, 0);
 	if (!irq) {
@@ -166,8 +158,7 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_scu=
_ic *scu_ic,
 	}
=20
 	scu_ic->irq_domain =3D irq_domain_create_linear(of_fwnode_handle(node), scu=
_ic->num_irqs,
-						   &aspeed_scu_ic_domain_ops,
-						   scu_ic);
+						      &aspeed_scu_ic_domain_ops, scu_ic);
 	if (!scu_ic->irq_domain) {
 		rc =3D -ENOMEM;
 		goto err;
@@ -180,61 +171,39 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_s=
cu_ic *scu_ic,
=20
 err:
 	kfree(scu_ic);
-
 	return rc;
 }
=20
-static int __init aspeed_scu_ic_of_init(struct device_node *node,
-					struct device_node *parent)
+static const struct aspeed_scu_ic_variant *aspeed_scu_ic_find_variant(struct=
 device_node *np)
 {
-	struct aspeed_scu_ic *scu_ic =3D kzalloc(sizeof(*scu_ic), GFP_KERNEL);
-
-	if (!scu_ic)
-		return -ENOMEM;
-
-	scu_ic->irq_enable =3D ASPEED_SCU_IC_ENABLE;
-	scu_ic->irq_shift =3D ASPEED_SCU_IC_SHIFT;
-	scu_ic->num_irqs =3D ASPEED_SCU_IC_NUM_IRQS;
-	scu_ic->reg =3D ASPEED_SCU_IC_REG;
-
-	return aspeed_scu_ic_of_init_common(scu_ic, node);
+	for (int i =3D 0; i < ARRAY_SIZE(scu_ic_variants); i++) {
+		if (of_device_is_compatible(np, scu_ic_variants[i].compatible))
+			return &scu_ic_variants[i];
+	}
+	return NULL;
 }
=20
-static int __init aspeed_ast2600_scu_ic0_of_init(struct device_node *node,
-						 struct device_node *parent)
+static int __init aspeed_scu_ic_of_init(struct device_node *node, struct dev=
ice_node *parent)
 {
-	struct aspeed_scu_ic *scu_ic =3D kzalloc(sizeof(*scu_ic), GFP_KERNEL);
-
-	if (!scu_ic)
-		return -ENOMEM;
-
-	scu_ic->irq_enable =3D ASPEED_AST2600_SCU_IC0_ENABLE;
-	scu_ic->irq_shift =3D ASPEED_AST2600_SCU_IC0_SHIFT;
-	scu_ic->num_irqs =3D ASPEED_AST2600_SCU_IC0_NUM_IRQS;
-	scu_ic->reg =3D ASPEED_AST2600_SCU_IC0_REG;
-
-	return aspeed_scu_ic_of_init_common(scu_ic, node);
-}
+	const struct aspeed_scu_ic_variant *variant;
+	struct aspeed_scu_ic *scu_ic;
=20
-static int __init aspeed_ast2600_scu_ic1_of_init(struct device_node *node,
-						 struct device_node *parent)
-{
-	struct aspeed_scu_ic *scu_ic =3D kzalloc(sizeof(*scu_ic), GFP_KERNEL);
+	variant =3D aspeed_scu_ic_find_variant(node);
+	if (!variant)
+		return -ENODEV;
=20
+	scu_ic =3D kzalloc(sizeof(*scu_ic), GFP_KERNEL);
 	if (!scu_ic)
 		return -ENOMEM;
=20
-	scu_ic->irq_enable =3D ASPEED_AST2600_SCU_IC1_ENABLE;
-	scu_ic->irq_shift =3D ASPEED_AST2600_SCU_IC1_SHIFT;
-	scu_ic->num_irqs =3D ASPEED_AST2600_SCU_IC1_NUM_IRQS;
-	scu_ic->reg =3D ASPEED_AST2600_SCU_IC1_REG;
+	scu_ic->irq_enable	=3D variant->irq_enable;
+	scu_ic->irq_shift	=3D variant->irq_shift;
+	scu_ic->num_irqs	=3D variant->num_irqs;
=20
 	return aspeed_scu_ic_of_init_common(scu_ic, node);
 }
=20
 IRQCHIP_DECLARE(ast2400_scu_ic, "aspeed,ast2400-scu-ic", aspeed_scu_ic_of_in=
it);
 IRQCHIP_DECLARE(ast2500_scu_ic, "aspeed,ast2500-scu-ic", aspeed_scu_ic_of_in=
it);
-IRQCHIP_DECLARE(ast2600_scu_ic0, "aspeed,ast2600-scu-ic0",
-		aspeed_ast2600_scu_ic0_of_init);
-IRQCHIP_DECLARE(ast2600_scu_ic1, "aspeed,ast2600-scu-ic1",
-		aspeed_ast2600_scu_ic1_of_init);
+IRQCHIP_DECLARE(ast2600_scu_ic0, "aspeed,ast2600-scu-ic0", aspeed_scu_ic_of_=
init);
+IRQCHIP_DECLARE(ast2600_scu_ic1, "aspeed,ast2600-scu-ic1", aspeed_scu_ic_of_=
init);

