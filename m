Return-Path: <linux-tip-commits+bounces-7720-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CA298CC0050
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 22:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 682A9301FF88
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 21:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD62B32F75C;
	Mon, 15 Dec 2025 21:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EN3WNmbK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fCix0tp/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B61532E724;
	Mon, 15 Dec 2025 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765835227; cv=none; b=dPdJToaMKjyXsw0SoI5B+9uNIbaOp89j4btwdpQtJfjT21Xg9jGQCIa6Y7vPOzgRT/EwqU7ILlzoICMDrTUwKiR8WQezPKAYb0TZIW5sv2hxVgRK3kdq+TD2KS82d71qB1kW3FdpDUOwUb5bLj03FqF/M4WGsYfBOCOXT5rj4QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765835227; c=relaxed/simple;
	bh=24STEaxnZdKGzl8D+enCKH9hloBOLF/SuZE70O9/Yn8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=o4aSXuQf/fKoQ2GyHKGiOrJNkeysowi23nW4DLcyqiPoH3+HSbhJEn5F6yUlF5vZCiPNMM5Lwrd3KTlsypFleVDRe2BobnataAQsaijhCYl1p8Vhr3c4KTLKAAsqR78hiQgUhaoMGEJ5bB4LpAq5IsNR05k1MYtZD4LBJ4j6xzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EN3WNmbK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fCix0tp/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 21:47:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765835222;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ml8EXigNANRrjS9Y9dpqJzhdqgH7O+92FVoUaVEzEk=;
	b=EN3WNmbKKB0I2+k5UiygDh0SxY1tiUqFV0M1MC/uG6EyeR2wucst7bKTjyXEkaPInfEGx6
	ZeyUbGlgc7Yd6ZpPvk1xw3Nu7/oyn99KgAF8YybapDSLIyjTozjLfXOrVMOEubHDi/5vvz
	77teu1xXyianHuCu5fkCWuePTE5gvCHGZCkGpmQZKpLHc7Fo3MyYERf6faGI8EMNOfHn6w
	2KhRwbt8rD70T7ammIdPz+CyT0lNElkYOPKUSUlUfDFCSjNv5MIBg48ZG6Q/N1pJnafJIS
	TbXBYEt1eJY0A2al5wljK5rt6OfUczn2LPWjC80BNEoBFIuJ+eaKIt6fhQKQWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765835222;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Ml8EXigNANRrjS9Y9dpqJzhdqgH7O+92FVoUaVEzEk=;
	b=fCix0tp/xNO1+iESqR+3ARBDELS168XIy5iLSNvHv7NN72YkiAP+ed8SUwfBomXShk+7XV
	fDQvK/SX3+Zf9dDg==
From: "tip-bot2 for Cosmin Tanislav" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip: Add RZ/{T2H,N2H} Interrupt Controller
 (ICU) driver
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251201112933.488801-3-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251201112933.488801-3-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176583522157.510.10403190851343818717.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     13e7b3305b647cf58c47c979fe8a04e08caa6098
Gitweb:        https://git.kernel.org/tip/13e7b3305b647cf58c47c979fe8a04e08ca=
a6098
Author:        Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
AuthorDate:    Mon, 01 Dec 2025 13:29:31 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Dec 2025 22:44:32 +01:00

irqchip: Add RZ/{T2H,N2H} Interrupt Controller (ICU) driver

The Renesas RZ/T2H (R9A09G077) and Renesas RZ/N2H (R9A09G087) SoCs have an
Interrupt Controller (ICU) that supports interrupts from external pins IRQ0
to IRQ15, and SEI, and software-triggered interrupts INTCPU0 to INTCPU15.

INTCPU0 to INTCPU13, IRQ0 to IRQ13 are non-safety interrupts, while
INTCPU14, INTCPU15, IRQ14, IRQ15 and SEI are safety interrupts, and are
exposed via a separate register space.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251201112933.488801-3-cosmin-gabriel.tanisla=
v.xa@renesas.com
---
 drivers/irqchip/Kconfig                   |   8 +-
 drivers/irqchip/Makefile                  |   1 +-
 drivers/irqchip/irq-renesas-rzt2h.c       | 280 +++++++++++++++++++++-
 drivers/soc/renesas/Kconfig               |   1 +-
 include/linux/irqchip/irq-renesas-rzt2h.h |  23 ++-
 5 files changed, 313 insertions(+)
 create mode 100644 drivers/irqchip/irq-renesas-rzt2h.c
 create mode 100644 include/linux/irqchip/irq-renesas-rzt2h.h

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index f334f49..118d0c1 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -297,6 +297,14 @@ config RENESAS_RZG2L_IRQC
 	  Enable support for the Renesas RZ/G2L (and alike SoC) Interrupt Controller
 	  for external devices.
=20
+config RENESAS_RZT2H_ICU
+	bool "Renesas RZ/{T2H,N2H} ICU support" if COMPILE_TEST
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Enable support for the Renesas RZ/{T2H,N2H} Interrupt Controller
+	  (ICU).
+
 config RENESAS_RZV2H_ICU
 	bool "Renesas RZ/V2H(P) ICU support" if COMPILE_TEST
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 6a22944..26aa3b6 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+=3D irq-renesas-intc-irq=
pin.o
 obj-$(CONFIG_RENESAS_IRQC)		+=3D irq-renesas-irqc.o
 obj-$(CONFIG_RENESAS_RZA1_IRQC)		+=3D irq-renesas-rza1.o
 obj-$(CONFIG_RENESAS_RZG2L_IRQC)	+=3D irq-renesas-rzg2l.o
+obj-$(CONFIG_RENESAS_RZT2H_ICU)		+=3D irq-renesas-rzt2h.o
 obj-$(CONFIG_RENESAS_RZV2H_ICU)		+=3D irq-renesas-rzv2h.o
 obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+=3D irq-versatile-fpga.o
 obj-$(CONFIG_ARCH_NSPIRE)		+=3D irq-zevio.o
diff --git a/drivers/irqchip/irq-renesas-rzt2h.c b/drivers/irqchip/irq-renesa=
s-rzt2h.c
new file mode 100644
index 0000000..53cf80e
--- /dev/null
+++ b/drivers/irqchip/irq-renesas-rzt2h.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bitfield.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/irq-renesas-rzt2h.h>
+#include <linux/irqdomain.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/spinlock.h>
+
+#define RZT2H_ICU_INTCPU_NS_START		0
+#define RZT2H_ICU_INTCPU_NS_COUNT		14
+
+#define RZT2H_ICU_INTCPU_S_START		(RZT2H_ICU_INTCPU_NS_START +	\
+						 RZT2H_ICU_INTCPU_NS_COUNT)
+#define RZT2H_ICU_INTCPU_S_COUNT		2
+
+#define RZT2H_ICU_IRQ_NS_START			(RZT2H_ICU_INTCPU_S_START +	\
+						 RZT2H_ICU_INTCPU_S_COUNT)
+#define RZT2H_ICU_IRQ_NS_COUNT			14
+
+#define RZT2H_ICU_IRQ_S_START			(RZT2H_ICU_IRQ_NS_START +	\
+						 RZT2H_ICU_IRQ_NS_COUNT)
+#define RZT2H_ICU_IRQ_S_COUNT			2
+
+#define RZT2H_ICU_SEI_START			(RZT2H_ICU_IRQ_S_START +	\
+						 RZT2H_ICU_IRQ_S_COUNT)
+#define RZT2H_ICU_SEI_COUNT			1
+
+#define RZT2H_ICU_NUM_IRQ			(RZT2H_ICU_INTCPU_NS_COUNT +	\
+						 RZT2H_ICU_INTCPU_S_COUNT +	\
+						 RZT2H_ICU_IRQ_NS_COUNT +	\
+						 RZT2H_ICU_IRQ_S_COUNT +	\
+						 RZT2H_ICU_SEI_COUNT)
+
+#define RZT2H_ICU_IRQ_IN_RANGE(n, type)						\
+	((n) >=3D RZT2H_ICU_##type##_START &&					\
+	 (n) <  RZT2H_ICU_##type##_START + RZT2H_ICU_##type##_COUNT)
+
+#define RZT2H_ICU_PORTNF_MD			0xc
+#define RZT2H_ICU_PORTNF_MDi_MASK(i)		(GENMASK(1, 0) << ((i) * 2))
+#define RZT2H_ICU_PORTNF_MDi_PREP(i, val)	(FIELD_PREP(GENMASK(1, 0), val) <<=
 ((i) * 2))
+
+#define RZT2H_ICU_MD_LOW_LEVEL			0b00
+#define RZT2H_ICU_MD_FALLING_EDGE		0b01
+#define RZT2H_ICU_MD_RISING_EDGE		0b10
+#define RZT2H_ICU_MD_BOTH_EDGES			0b11
+
+#define RZT2H_ICU_DMACn_RSSELi(n, i)		(0x7d0 + 0x18 * (n) + 0x4 * (i))
+#define RZT2H_ICU_DMAC_REQ_SELx_MASK(x)		(GENMASK(9, 0) << ((x) * 10))
+#define RZT2H_ICU_DMAC_REQ_SELx_PREP(x, val)	(FIELD_PREP(GENMASK(9, 0), val)=
 << ((x) * 10))
+
+struct rzt2h_icu_priv {
+	void __iomem		*base_ns;
+	void __iomem		*base_s;
+	struct irq_fwspec	fwspec[RZT2H_ICU_NUM_IRQ];
+	raw_spinlock_t		lock;
+};
+
+void rzt2h_icu_register_dma_req(struct platform_device *icu_dev, u8 dmac_ind=
ex, u8 dmac_channel,
+				u16 req_no)
+{
+	struct rzt2h_icu_priv *priv =3D platform_get_drvdata(icu_dev);
+	u8 y, upper;
+	u32 val;
+
+	y =3D dmac_channel / 3;
+	upper =3D dmac_channel % 3;
+
+	guard(raw_spinlock_irqsave)(&priv->lock);
+	val =3D readl(priv->base_ns + RZT2H_ICU_DMACn_RSSELi(dmac_index, y));
+	val &=3D ~RZT2H_ICU_DMAC_REQ_SELx_MASK(upper);
+	val |=3D RZT2H_ICU_DMAC_REQ_SELx_PREP(upper, req_no);
+	writel(val, priv->base_ns + RZT2H_ICU_DMACn_RSSELi(dmac_index, y));
+}
+EXPORT_SYMBOL_GPL(rzt2h_icu_register_dma_req);
+
+static inline struct rzt2h_icu_priv *irq_data_to_priv(struct irq_data *data)
+{
+	return data->domain->host_data;
+}
+
+static inline int rzt2h_icu_irq_to_offset(struct irq_data *d, void __iomem *=
*base,
+					  unsigned int *offset)
+{
+	struct rzt2h_icu_priv *priv =3D irq_data_to_priv(d);
+	unsigned int hwirq =3D irqd_to_hwirq(d);
+
+	/*
+	 * Safety IRQs and SEI use a separate register space from the non-safety IR=
Qs.
+	 * SEI interrupt number follows immediately after the safety IRQs.
+	 */
+	if (RZT2H_ICU_IRQ_IN_RANGE(hwirq, IRQ_NS)) {
+		*offset =3D hwirq - RZT2H_ICU_IRQ_NS_START;
+		*base =3D priv->base_ns;
+	} else if (RZT2H_ICU_IRQ_IN_RANGE(hwirq, IRQ_S) || RZT2H_ICU_IRQ_IN_RANGE(h=
wirq, SEI)) {
+		*offset =3D hwirq - RZT2H_ICU_IRQ_S_START;
+		*base =3D priv->base_s;
+	} else {
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int rzt2h_icu_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct rzt2h_icu_priv *priv =3D irq_data_to_priv(d);
+	unsigned int offset, parent_type;
+	void __iomem *base;
+	u32 val, md;
+	int ret;
+
+	ret =3D rzt2h_icu_irq_to_offset(d, &base, &offset);
+	if (ret)
+		return ret;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_LEVEL_LOW:
+		md =3D RZT2H_ICU_MD_LOW_LEVEL;
+		parent_type =3D IRQ_TYPE_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		md =3D RZT2H_ICU_MD_FALLING_EDGE;
+		parent_type =3D IRQ_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		md =3D RZT2H_ICU_MD_RISING_EDGE;
+		parent_type =3D IRQ_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		md =3D RZT2H_ICU_MD_BOTH_EDGES;
+		parent_type =3D IRQ_TYPE_EDGE_RISING;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	scoped_guard(raw_spinlock, &priv->lock) {
+		val =3D readl_relaxed(base + RZT2H_ICU_PORTNF_MD);
+		val &=3D ~RZT2H_ICU_PORTNF_MDi_MASK(offset);
+		val |=3D RZT2H_ICU_PORTNF_MDi_PREP(offset, md);
+		writel_relaxed(val, base + RZT2H_ICU_PORTNF_MD);
+	}
+
+	return irq_chip_set_type_parent(d, parent_type);
+}
+
+static int rzt2h_icu_set_type(struct irq_data *d, unsigned int type)
+{
+	unsigned int hw_irq =3D irqd_to_hwirq(d);
+
+	/* IRQn and SEI are selectable, others are edge-only. */
+	if (RZT2H_ICU_IRQ_IN_RANGE(hw_irq, IRQ_NS) ||
+	    RZT2H_ICU_IRQ_IN_RANGE(hw_irq, IRQ_S) ||
+	    RZT2H_ICU_IRQ_IN_RANGE(hw_irq, SEI))
+		return rzt2h_icu_irq_set_type(d, type);
+
+	if ((type & IRQ_TYPE_SENSE_MASK) !=3D IRQ_TYPE_EDGE_RISING)
+		return -EINVAL;
+
+	return irq_chip_set_type_parent(d, IRQ_TYPE_EDGE_RISING);
+}
+
+static const struct irq_chip rzt2h_icu_chip =3D {
+	.name			=3D "rzt2h-icu",
+	.irq_mask		=3D irq_chip_mask_parent,
+	.irq_unmask		=3D irq_chip_unmask_parent,
+	.irq_eoi		=3D irq_chip_eoi_parent,
+	.irq_set_type		=3D rzt2h_icu_set_type,
+	.irq_set_wake		=3D irq_chip_set_wake_parent,
+	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
+	.irq_retrigger		=3D irq_chip_retrigger_hierarchy,
+	.irq_get_irqchip_state	=3D irq_chip_get_parent_state,
+	.irq_set_irqchip_state	=3D irq_chip_set_parent_state,
+	.flags			=3D IRQCHIP_MASK_ON_SUSPEND |
+				  IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE,
+};
+
+static int rzt2h_icu_alloc(struct irq_domain *domain, unsigned int virq, uns=
igned int nr_irqs,
+			   void *arg)
+{
+	struct rzt2h_icu_priv *priv =3D domain->host_data;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int ret;
+
+	ret =3D irq_domain_translate_twocell(domain, arg, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	ret =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &rzt2h_icu_chip,=
 NULL);
+	if (ret)
+		return ret;
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &priv->fwspec[hw=
irq]);
+}
+
+static const struct irq_domain_ops rzt2h_icu_domain_ops =3D {
+	.alloc		=3D rzt2h_icu_alloc,
+	.free		=3D irq_domain_free_irqs_common,
+	.translate	=3D irq_domain_translate_twocell,
+};
+
+static int rzt2h_icu_parse_interrupts(struct rzt2h_icu_priv *priv, struct de=
vice_node *np)
+{
+	struct of_phandle_args map;
+	unsigned int i;
+	int ret;
+
+	for (i =3D 0; i < RZT2H_ICU_NUM_IRQ; i++) {
+		ret =3D of_irq_parse_one(np, i, &map);
+		if (ret)
+			return ret;
+
+		of_phandle_args_to_fwspec(np, map.args, map.args_count, &priv->fwspec[i]);
+	}
+
+	return 0;
+}
+
+static int rzt2h_icu_init(struct platform_device *pdev, struct device_node *=
parent)
+{
+	struct irq_domain *irq_domain, *parent_domain;
+	struct device_node *node =3D pdev->dev.of_node;
+	struct device *dev =3D &pdev->dev;
+	struct rzt2h_icu_priv *priv;
+	int ret;
+
+	parent_domain =3D irq_find_host(parent);
+	if (!parent_domain)
+		return dev_err_probe(dev, -ENODEV, "cannot find parent domain\n");
+
+	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	raw_spin_lock_init(&priv->lock);
+
+	platform_set_drvdata(pdev, priv);
+
+	priv->base_ns =3D devm_of_iomap(dev, dev->of_node, 0, NULL);
+	if (IS_ERR(priv->base_ns))
+		return PTR_ERR(priv->base_ns);
+
+	priv->base_s =3D devm_of_iomap(dev, dev->of_node, 1, NULL);
+	if (IS_ERR(priv->base_s))
+		return PTR_ERR(priv->base_s);
+
+	ret =3D rzt2h_icu_parse_interrupts(priv, node);
+	if (ret)
+		return dev_err_probe(dev, ret, "cannot parse interrupts: %d\n", ret);
+
+	ret =3D devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "devm_pm_runtime_enable failed: %d\n", ret);
+
+	ret =3D pm_runtime_resume_and_get(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "pm_runtime_resume_and_get failed: %d\n", r=
et);
+
+	irq_domain =3D irq_domain_create_hierarchy(parent_domain, 0, RZT2H_ICU_NUM_=
IRQ,
+						 dev_fwnode(dev), &rzt2h_icu_domain_ops, priv);
+	if (!irq_domain) {
+		pm_runtime_put(dev);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(rzt2h_icu)
+IRQCHIP_MATCH("renesas,r9a09g077-icu", rzt2h_icu_init)
+IRQCHIP_PLATFORM_DRIVER_END(rzt2h_icu)
+MODULE_AUTHOR("Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/T2H ICU Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 340a1ff..198baf8 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -423,6 +423,7 @@ config ARCH_R9A09G057
 config ARCH_R9A09G077
 	bool "ARM64 Platform support for R9A09G077 (RZ/T2H)"
 	default y if ARCH_RENESAS
+	select RENESAS_RZT2H_ICU
 	help
 	  This enables support for the Renesas RZ/T2H SoC variants.
=20
diff --git a/include/linux/irqchip/irq-renesas-rzt2h.h b/include/linux/irqchi=
p/irq-renesas-rzt2h.h
new file mode 100644
index 0000000..853fd5e
--- /dev/null
+++ b/include/linux/irqchip/irq-renesas-rzt2h.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Renesas RZ/T2H Interrupt Control Unit (ICU)
+ *
+ * Copyright (C) 2025 Renesas Electronics Corporation.
+ */
+
+#ifndef __LINUX_IRQ_RENESAS_RZT2H
+#define __LINUX_IRQ_RENESAS_RZT2H
+
+#include <linux/platform_device.h>
+
+#define RZT2H_ICU_DMAC_REQ_NO_DEFAULT		0x3ff
+
+#ifdef CONFIG_RENESAS_RZT2H_ICU
+void rzt2h_icu_register_dma_req(struct platform_device *icu_dev, u8 dmac_ind=
ex, u8 dmac_channel,
+				u16 req_no);
+#else
+static inline void rzt2h_icu_register_dma_req(struct platform_device *icu_de=
v, u8 dmac_index,
+					      u8 dmac_channel, u16 req_no) { }
+#endif
+
+#endif /* __LINUX_IRQ_RENESAS_RZT2H */

