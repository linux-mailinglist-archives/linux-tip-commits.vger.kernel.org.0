Return-Path: <linux-tip-commits+bounces-6955-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E841ABE5295
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 21:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C2DE8503221
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 19:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289C2258EED;
	Thu, 16 Oct 2025 19:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a06yVHnD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N1fgK554"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EEE254B1B;
	Thu, 16 Oct 2025 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641296; cv=none; b=vGm1jjoktB2cOZKa0P60ES5+ZF472B9kWkwxsqqJp4e5YBM5IfkrxbH3U6eGuf2E+v1+Mk5l6BSfaQHr8eZTjzhM26WV2kvMuMAgZ5MUyvunBko1/q6sp7uI51MypKqkkJhpfk0bZ9MCgBxurVvm2kaMyZrNildOyRfeMeehLqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641296; c=relaxed/simple;
	bh=GYM/A5+yoFyWZ+Ke+saycfEBsf+bYcTZqtANRL/civw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PLreqhO3J8rXNioSOfA2TRXwo87DnIMANq/rT74wYxpeff9+C7/YNRkAdAWWxyrw2wTBFqlCvPtbAO5FSYXkN4hDe0tngbp4tqLJ0t3bJtM63uXUQf7VJXh+ByclPi9c3f9oi6eLpQEfEdaDa+6hBcc/5NErIKsLkZ9O+FmrukY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a06yVHnD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N1fgK554; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 19:01:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760641292;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nfYyGBxfo1uRj0759DXuyCJ49JvPdGwLmKllpbrCBxA=;
	b=a06yVHnDWvN9t4r1XWKKckGf77I9CT+7eF5eHIhWIDWo+L8xp6SJdRPeTTzLCl85auZlri
	uRuQaXhQ+qOtq7rSZiIBXua01ZPWCVwjsLGrNZVLBHOLFCTRc9nlh2G6jnt8fbemtXAKZO
	Ap4CHtF2lAF9VCWk3uVh+YA5c2mnWidwAKaadwO9j2Q/hKxWrervCbp/+E4+F6iWCOTuuQ
	uTdDrqQ0v2/gG+7CGHeSMrbvjqu086J2xS50LmHZ0I7WmkrTABt/geMfKOXdzRAPzm1ZkN
	z3P43etJ9pSiplSnHeT7VpJlbtDsUpSF6Ry2UUSqQJlqAo8SficTjIf3b1xceA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760641292;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nfYyGBxfo1uRj0759DXuyCJ49JvPdGwLmKllpbrCBxA=;
	b=N1fgK55493q38sPnMgM0pCrwDu3g+LprqStpBzEHVkdaTkpzVf1EW2YeOh7pn6bWZbr29G
	MR273V1IXNqMSvAA==
From: "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip: Pass platform device to platform drivers
Cc: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Changhuang Liang <changhuang.liang@starfivetech.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251013094611.11745-12-johan@kernel.org>
References: <20251013094611.11745-12-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176064129069.709179.11516216268127298741.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     1e3e330c07076a0582385bbea029c9cc918fa30d
Gitweb:        https://git.kernel.org/tip/1e3e330c07076a0582385bbea029c9cc918=
fa30d
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Mon, 13 Oct 2025 11:46:11 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 18:17:27 +02:00

irqchip: Pass platform device to platform drivers

The IRQCHIP_PLATFORM_DRIVER macros can be used to convert OF irqchip
drivers to platform drivers but currently reuse the OF init callback
prototype that only takes OF nodes as arguments. This forces drivers to
do reverse lookups of their struct devices during probe if they need
them for things like dev_printk() and device managed resources.

Half of the drivers doing reverse lookups also currently fail to release
the additional reference taken during the lookup, while other drivers
have had the reference leak plugged in various ways (e.g. using
non-intuitive cleanup constructs which still confuse static checkers).

Switch to using a probe callback that takes a platform device as its
first argument to simplify drivers and plug the remaining (mostly
benign) reference leaks.

Fixes: 32c6c054661a ("irqchip: Add Broadcom BCM2712 MSI-X interrupt controlle=
r")
Fixes: 70afdab904d2 ("irqchip: Add IMX MU MSI controller driver")
Fixes: a6199bb514d8 ("irqchip: Add Qualcomm MPM controller driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/irqchip/irq-bcm2712-mip.c          | 10 +-----
 drivers/irqchip/irq-bcm7038-l1.c           |  5 +--
 drivers/irqchip/irq-bcm7120-l2.c           | 20 +++---------
 drivers/irqchip/irq-brcmstb-l2.c           | 21 ++++++-------
 drivers/irqchip/irq-imx-mu-msi.c           | 24 ++++++--------
 drivers/irqchip/irq-mchp-eic.c             |  5 +--
 drivers/irqchip/irq-meson-gpio.c           |  5 +--
 drivers/irqchip/irq-qcom-mpm.c             |  6 ++--
 drivers/irqchip/irq-renesas-rzg2l.c        | 35 ++++++---------------
 drivers/irqchip/irq-renesas-rzv2h.c        | 32 +++++--------------
 drivers/irqchip/irq-starfive-jh8100-intc.c |  5 +--
 drivers/irqchip/irqchip.c                  |  6 ++--
 drivers/irqchip/qcom-pdc.c                 |  5 +--
 include/linux/irqchip.h                    |  8 ++++-
 14 files changed, 78 insertions(+), 109 deletions(-)

diff --git a/drivers/irqchip/irq-bcm2712-mip.c b/drivers/irqchip/irq-bcm2712-=
mip.c
index 8466646..4761974 100644
--- a/drivers/irqchip/irq-bcm2712-mip.c
+++ b/drivers/irqchip/irq-bcm2712-mip.c
@@ -232,16 +232,12 @@ err_put:
 	return ret;
 }
=20
-static int mip_of_msi_init(struct device_node *node, struct device_node *par=
ent)
+static int mip_msi_probe(struct platform_device *pdev, struct device_node *p=
arent)
 {
-	struct platform_device *pdev;
+	struct device_node *node =3D pdev->dev.of_node;
 	struct mip_priv *mip;
 	int ret;
=20
-	pdev =3D of_find_device_by_node(node);
-	if (!pdev)
-		return -EPROBE_DEFER;
-
 	mip =3D kzalloc(sizeof(*mip), GFP_KERNEL);
 	if (!mip)
 		return -ENOMEM;
@@ -284,7 +280,7 @@ err_priv:
 }
=20
 IRQCHIP_PLATFORM_DRIVER_BEGIN(mip_msi)
-IRQCHIP_MATCH("brcm,bcm2712-mip", mip_of_msi_init)
+IRQCHIP_MATCH("brcm,bcm2712-mip", mip_msi_probe)
 IRQCHIP_PLATFORM_DRIVER_END(mip_msi)
 MODULE_DESCRIPTION("Broadcom BCM2712 MSI-X interrupt controller");
 MODULE_AUTHOR("Phil Elwell <phil@raspberrypi.com>");
diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l=
1.c
index eda33bd..821b288 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -394,8 +394,9 @@ static const struct irq_domain_ops bcm7038_l1_domain_ops =
=3D {
 	.map			=3D bcm7038_l1_map,
 };
=20
-static int bcm7038_l1_of_init(struct device_node *dn, struct device_node *pa=
rent)
+static int bcm7038_l1_probe(struct platform_device *pdev, struct device_node=
 *parent)
 {
+	struct device_node *dn =3D pdev->dev.of_node;
 	struct bcm7038_l1_chip *intc;
 	int idx, ret;
=20
@@ -453,7 +454,7 @@ out_free:
 }
=20
 IRQCHIP_PLATFORM_DRIVER_BEGIN(bcm7038_l1)
-IRQCHIP_MATCH("brcm,bcm7038-l1-intc", bcm7038_l1_of_init)
+IRQCHIP_MATCH("brcm,bcm7038-l1-intc", bcm7038_l1_probe)
 IRQCHIP_PLATFORM_DRIVER_END(bcm7038_l1)
 MODULE_DESCRIPTION("Broadcom STB 7038-style L1/L2 interrupt controller");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l=
2.c
index b6c8556..518c9d4 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -206,14 +206,14 @@ static int bcm7120_l2_intc_iomap_3380(struct device_nod=
e *dn, struct bcm7120_l2_
 	return 0;
 }
=20
-static int bcm7120_l2_intc_probe(struct device_node *dn, struct device_node =
*parent,
+static int bcm7120_l2_intc_probe(struct platform_device *pdev, struct device=
_node *parent,
 				 int (*iomap_regs_fn)(struct device_node *,
 						      struct bcm7120_l2_intc_data *),
 				 const char *intc_name)
 {
 	unsigned int clr =3D IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
+	struct device_node *dn =3D pdev->dev.of_node;
 	struct bcm7120_l2_intc_data *data;
-	struct platform_device *pdev;
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
 	int ret =3D 0;
@@ -224,14 +224,7 @@ static int bcm7120_l2_intc_probe(struct device_node *dn,=
 struct device_node *par
 	if (!data)
 		return -ENOMEM;
=20
-	pdev =3D of_find_device_by_node(dn);
-	if (!pdev) {
-		ret =3D -ENODEV;
-		goto out_free_data;
-	}
-
 	data->num_parent_irqs =3D platform_irq_count(pdev);
-	put_device(&pdev->dev);
 	if (data->num_parent_irqs <=3D 0) {
 		pr_err("invalid number of parent interrupts\n");
 		ret =3D -ENOMEM;
@@ -331,20 +324,19 @@ out_unmap:
 		if (data->map_base[idx])
 			iounmap(data->map_base[idx]);
 	}
-out_free_data:
 	kfree(data);
 	return ret;
 }
=20
-static int bcm7120_l2_intc_probe_7120(struct device_node *dn, struct device_=
node *parent)
+static int bcm7120_l2_intc_probe_7120(struct platform_device *pdev, struct d=
evice_node *parent)
 {
-	return bcm7120_l2_intc_probe(dn, parent, bcm7120_l2_intc_iomap_7120,
+	return bcm7120_l2_intc_probe(pdev, parent, bcm7120_l2_intc_iomap_7120,
 				     "BCM7120 L2");
 }
=20
-static int bcm7120_l2_intc_probe_3380(struct device_node *dn, struct device_=
node *parent)
+static int bcm7120_l2_intc_probe_3380(struct platform_device *pdev, struct d=
evice_node *parent)
 {
-	return bcm7120_l2_intc_probe(dn, parent, bcm7120_l2_intc_iomap_3380,
+	return bcm7120_l2_intc_probe(pdev, parent, bcm7120_l2_intc_iomap_3380,
 				     "BCM3380 L2");
 }
=20
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l=
2.c
index 53e67c6..bb7078d 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -138,11 +138,12 @@ static void brcmstb_l2_intc_resume(struct irq_data *d)
 	irq_reg_writel(gc, ~b->saved_mask, ct->regs.enable);
 }
=20
-static int brcmstb_l2_intc_of_init(struct device_node *np, struct device_nod=
e *parent,
-				   const struct brcmstb_intc_init_params *init_params)
+static int brcmstb_l2_intc_probe(struct platform_device *pdev, struct device=
_node *parent,
+				 const struct brcmstb_intc_init_params *init_params)
 {
 	unsigned int clr =3D IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	unsigned int set =3D 0;
+	struct device_node *np =3D pdev->dev.of_node;
 	struct brcmstb_l2_intc_data *data;
 	struct irq_chip_type *ct;
 	int ret;
@@ -255,21 +256,21 @@ out_free:
 	return ret;
 }
=20
-static int brcmstb_l2_edge_intc_of_init(struct device_node *np, struct devic=
e_node *parent)
+static int brcmstb_l2_edge_intc_probe(struct platform_device *pdev, struct d=
evice_node *parent)
 {
-	return brcmstb_l2_intc_of_init(np, parent, &l2_edge_intc_init);
+	return brcmstb_l2_intc_probe(pdev, parent, &l2_edge_intc_init);
 }
=20
-static int brcmstb_l2_lvl_intc_of_init(struct device_node *np, struct device=
_node *parent)
+static int brcmstb_l2_lvl_intc_probe(struct platform_device *pdev, struct de=
vice_node *parent)
 {
-	return brcmstb_l2_intc_of_init(np, parent, &l2_lvl_intc_init);
+	return brcmstb_l2_intc_probe(pdev, parent, &l2_lvl_intc_init);
 }
=20
 IRQCHIP_PLATFORM_DRIVER_BEGIN(brcmstb_l2)
-IRQCHIP_MATCH("brcm,l2-intc", brcmstb_l2_edge_intc_of_init)
-IRQCHIP_MATCH("brcm,hif-spi-l2-intc", brcmstb_l2_edge_intc_of_init)
-IRQCHIP_MATCH("brcm,upg-aux-aon-l2-intc", brcmstb_l2_edge_intc_of_init)
-IRQCHIP_MATCH("brcm,bcm7271-l2-intc", brcmstb_l2_lvl_intc_of_init)
+IRQCHIP_MATCH("brcm,l2-intc", brcmstb_l2_edge_intc_probe)
+IRQCHIP_MATCH("brcm,hif-spi-l2-intc", brcmstb_l2_edge_intc_probe)
+IRQCHIP_MATCH("brcm,upg-aux-aon-l2-intc", brcmstb_l2_edge_intc_probe)
+IRQCHIP_MATCH("brcm,bcm7271-l2-intc", brcmstb_l2_lvl_intc_probe)
 IRQCHIP_PLATFORM_DRIVER_END(brcmstb_l2)
 MODULE_DESCRIPTION("Broadcom STB generic L2 interrupt controller");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-ms=
i.c
index 41df168..c598f2f 100644
--- a/drivers/irqchip/irq-imx-mu-msi.c
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -296,10 +296,9 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp =3D {
 		  },
 };
=20
-static int imx_mu_of_init(struct device_node *dn, struct device_node *parent,
-			  const struct imx_mu_dcfg *cfg)
+static int imx_mu_probe(struct platform_device *pdev, struct device_node *pa=
rent,
+			const struct imx_mu_dcfg *cfg)
 {
-	struct platform_device *pdev =3D of_find_device_by_node(dn);
 	struct device_link *pd_link_a;
 	struct device_link *pd_link_b;
 	struct imx_mu_msi *msi_data;
@@ -415,28 +414,27 @@ static const struct dev_pm_ops imx_mu_pm_ops =3D {
 			   imx_mu_runtime_resume, NULL)
 };
=20
-static int imx_mu_imx7ulp_of_init(struct device_node *dn, struct device_node=
 *parent)
+static int imx_mu_imx7ulp_probe(struct platform_device *pdev, struct device_=
node *parent)
 {
-	return imx_mu_of_init(dn, parent, &imx_mu_cfg_imx7ulp);
+	return imx_mu_probe(pdev, parent, &imx_mu_cfg_imx7ulp);
 }
=20
-static int imx_mu_imx6sx_of_init(struct device_node *dn, struct device_node =
*parent)
+static int imx_mu_imx6sx_probe(struct platform_device *pdev, struct device_n=
ode *parent)
 {
-	return imx_mu_of_init(dn, parent, &imx_mu_cfg_imx6sx);
+	return imx_mu_probe(pdev, parent, &imx_mu_cfg_imx6sx);
 }
=20
-static int imx_mu_imx8ulp_of_init(struct device_node *dn, struct device_node=
 *parent)
+static int imx_mu_imx8ulp_probe(struct platform_device *pdev, struct device_=
node *parent)
 {
-	return imx_mu_of_init(dn, parent, &imx_mu_cfg_imx8ulp);
+	return imx_mu_probe(pdev, parent, &imx_mu_cfg_imx8ulp);
 }
=20
 IRQCHIP_PLATFORM_DRIVER_BEGIN(imx_mu_msi)
-IRQCHIP_MATCH("fsl,imx7ulp-mu-msi", imx_mu_imx7ulp_of_init)
-IRQCHIP_MATCH("fsl,imx6sx-mu-msi", imx_mu_imx6sx_of_init)
-IRQCHIP_MATCH("fsl,imx8ulp-mu-msi", imx_mu_imx8ulp_of_init)
+IRQCHIP_MATCH("fsl,imx7ulp-mu-msi", imx_mu_imx7ulp_probe)
+IRQCHIP_MATCH("fsl,imx6sx-mu-msi", imx_mu_imx6sx_probe)
+IRQCHIP_MATCH("fsl,imx8ulp-mu-msi", imx_mu_imx8ulp_probe)
 IRQCHIP_PLATFORM_DRIVER_END(imx_mu_msi, .pm =3D &imx_mu_pm_ops)
=20
-
 MODULE_AUTHOR("Frank Li <Frank.Li@nxp.com>");
 MODULE_DESCRIPTION("Freescale MU MSI controller driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/irqchip/irq-mchp-eic.c b/drivers/irqchip/irq-mchp-eic.c
index 516a3a0..b513a89 100644
--- a/drivers/irqchip/irq-mchp-eic.c
+++ b/drivers/irqchip/irq-mchp-eic.c
@@ -199,8 +199,9 @@ static const struct irq_domain_ops mchp_eic_domain_ops =
=3D {
 	.free		=3D irq_domain_free_irqs_common,
 };
=20
-static int mchp_eic_init(struct device_node *node, struct device_node *paren=
t)
+static int mchp_eic_probe(struct platform_device *pdev, struct device_node *=
parent)
 {
+	struct device_node *node =3D pdev->dev.of_node;
 	struct irq_domain *parent_domain =3D NULL;
 	int ret, i;
=20
@@ -273,7 +274,7 @@ free:
 }
=20
 IRQCHIP_PLATFORM_DRIVER_BEGIN(mchp_eic)
-IRQCHIP_MATCH("microchip,sama7g5-eic", mchp_eic_init)
+IRQCHIP_MATCH("microchip,sama7g5-eic", mchp_eic_probe)
 IRQCHIP_PLATFORM_DRIVER_END(mchp_eic)
=20
 MODULE_DESCRIPTION("Microchip External Interrupt Controller");
diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpi=
o.c
index 7d17762..09ebf1d 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -572,8 +572,9 @@ static int meson_gpio_irq_parse_dt(struct device_node *no=
de, struct meson_gpio_i
 	return 0;
 }
=20
-static int meson_gpio_irq_of_init(struct device_node *node, struct device_no=
de *parent)
+static int meson_gpio_irq_probe(struct platform_device *pdev, struct device_=
node *parent)
 {
+	struct device_node *node =3D pdev->dev.of_node;
 	struct irq_domain *domain, *parent_domain;
 	struct meson_gpio_irq_controller *ctl;
 	int ret;
@@ -630,7 +631,7 @@ free_ctl:
 }
=20
 IRQCHIP_PLATFORM_DRIVER_BEGIN(meson_gpio_intc)
-IRQCHIP_MATCH("amlogic,meson-gpio-intc", meson_gpio_irq_of_init)
+IRQCHIP_MATCH("amlogic,meson-gpio-intc", meson_gpio_irq_probe)
 IRQCHIP_PLATFORM_DRIVER_END(meson_gpio_intc)
=20
 MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
index 8d569f7..83f31ea 100644
--- a/drivers/irqchip/irq-qcom-mpm.c
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -320,9 +320,9 @@ static bool gic_hwirq_is_mapped(struct mpm_gic_map *maps,=
 int cnt, u32 hwirq)
 	return false;
 }
=20
-static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
+static int qcom_mpm_probe(struct platform_device *pdev, struct device_node *=
parent)
 {
-	struct platform_device *pdev =3D of_find_device_by_node(np);
+	struct device_node *np =3D pdev->dev.of_node;
 	struct device *dev =3D &pdev->dev;
 	struct irq_domain *parent_domain;
 	struct generic_pm_domain *genpd;
@@ -478,7 +478,7 @@ remove_genpd:
 }
=20
 IRQCHIP_PLATFORM_DRIVER_BEGIN(qcom_mpm)
-IRQCHIP_MATCH("qcom,mpm", qcom_mpm_init)
+IRQCHIP_MATCH("qcom,mpm", qcom_mpm_probe)
 IRQCHIP_PLATFORM_DRIVER_END(qcom_mpm)
 MODULE_DESCRIPTION("Qualcomm Technologies, Inc. MSM Power Manager");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesa=
s-rzg2l.c
index 12b6eb1..1bf19de 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -8,7 +8,6 @@
  */
=20
 #include <linux/bitfield.h>
-#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -528,18 +527,15 @@ static int rzg2l_irqc_parse_interrupts(struct rzg2l_irq=
c_priv *priv,
 	return 0;
 }
=20
-static int rzg2l_irqc_common_init(struct device_node *node, struct device_no=
de *parent,
-				  const struct irq_chip *irq_chip)
+static int rzg2l_irqc_common_probe(struct platform_device *pdev, struct devi=
ce_node *parent,
+				   const struct irq_chip *irq_chip)
 {
-	struct platform_device *pdev =3D of_find_device_by_node(node);
-	struct device *dev __free(put_device) =3D pdev ? &pdev->dev : NULL;
 	struct irq_domain *irq_domain, *parent_domain;
+	struct device_node *node =3D pdev->dev.of_node;
+	struct device *dev =3D &pdev->dev;
 	struct reset_control *resetn;
 	int ret;
=20
-	if (!pdev)
-		return -ENODEV;
-
 	parent_domain =3D irq_find_host(parent);
 	if (!parent_domain)
 		return dev_err_probe(dev, -ENODEV, "cannot find parent domain\n");
@@ -583,33 +579,22 @@ static int rzg2l_irqc_common_init(struct device_node *n=
ode, struct device_node *
=20
 	register_syscore_ops(&rzg2l_irqc_syscore_ops);
=20
-	/*
-	 * Prevent the cleanup function from invoking put_device by assigning
-	 * NULL to dev.
-	 *
-	 * make coccicheck will complain about missing put_device calls, but
-	 * those are false positives, as dev will be automatically "put" via
-	 * __free_put_device on the failing path.
-	 * On the successful path we don't actually want to "put" dev.
-	 */
-	dev =3D NULL;
-
 	return 0;
 }
=20
-static int rzg2l_irqc_init(struct device_node *node, struct device_node *par=
ent)
+static int rzg2l_irqc_probe(struct platform_device *pdev, struct device_node=
 *parent)
 {
-	return rzg2l_irqc_common_init(node, parent, &rzg2l_irqc_chip);
+	return rzg2l_irqc_common_probe(pdev, parent, &rzg2l_irqc_chip);
 }
=20
-static int rzfive_irqc_init(struct device_node *node, struct device_node *pa=
rent)
+static int rzfive_irqc_probe(struct platform_device *pdev, struct device_nod=
e *parent)
 {
-	return rzg2l_irqc_common_init(node, parent, &rzfive_irqc_chip);
+	return rzg2l_irqc_common_probe(pdev, parent, &rzfive_irqc_chip);
 }
=20
 IRQCHIP_PLATFORM_DRIVER_BEGIN(rzg2l_irqc)
-IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_init)
-IRQCHIP_MATCH("renesas,r9a07g043f-irqc", rzfive_irqc_init)
+IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_probe)
+IRQCHIP_MATCH("renesas,r9a07g043f-irqc", rzfive_irqc_probe)
 IRQCHIP_PLATFORM_DRIVER_END(rzg2l_irqc)
 MODULE_AUTHOR("Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>");
 MODULE_DESCRIPTION("Renesas RZ/G2L IRQC Driver");
diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesa=
s-rzv2h.c
index 9018d9c..899a423 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -490,29 +490,15 @@ static int rzv2h_icu_parse_interrupts(struct rzv2h_icu_=
priv *priv, struct device
 	return 0;
 }
=20
-static void rzv2h_icu_put_device(void *data)
-{
-	put_device(data);
-}
-
-static int rzv2h_icu_init_common(struct device_node *node, struct device_nod=
e *parent,
-				 const struct rzv2h_hw_info *hw_info)
+static int rzv2h_icu_probe_common(struct platform_device *pdev, struct devic=
e_node *parent,
+				  const struct rzv2h_hw_info *hw_info)
 {
 	struct irq_domain *irq_domain, *parent_domain;
+	struct device_node *node =3D pdev->dev.of_node;
 	struct rzv2h_icu_priv *rzv2h_icu_data;
-	struct platform_device *pdev;
 	struct reset_control *resetn;
 	int ret;
=20
-	pdev =3D of_find_device_by_node(node);
-	if (!pdev)
-		return -ENODEV;
-
-	ret =3D devm_add_action_or_reset(&pdev->dev, rzv2h_icu_put_device,
-				       &pdev->dev);
-	if (ret < 0)
-		return ret;
-
 	parent_domain =3D irq_find_host(parent);
 	if (!parent_domain) {
 		dev_err(&pdev->dev, "cannot find parent domain\n");
@@ -618,19 +604,19 @@ static const struct rzv2h_hw_info rzv2h_hw_params =3D {
 	.field_width	=3D 8,
 };
=20
-static int rzg3e_icu_init(struct device_node *node, struct device_node *pare=
nt)
+static int rzg3e_icu_probe(struct platform_device *pdev, struct device_node =
*parent)
 {
-	return rzv2h_icu_init_common(node, parent, &rzg3e_hw_params);
+	return rzv2h_icu_probe_common(pdev, parent, &rzg3e_hw_params);
 }
=20
-static int rzv2h_icu_init(struct device_node *node, struct device_node *pare=
nt)
+static int rzv2h_icu_probe(struct platform_device *pdev, struct device_node =
*parent)
 {
-	return rzv2h_icu_init_common(node, parent, &rzv2h_hw_params);
+	return rzv2h_icu_probe_common(pdev, parent, &rzv2h_hw_params);
 }
=20
 IRQCHIP_PLATFORM_DRIVER_BEGIN(rzv2h_icu)
-IRQCHIP_MATCH("renesas,r9a09g047-icu", rzg3e_icu_init)
-IRQCHIP_MATCH("renesas,r9a09g057-icu", rzv2h_icu_init)
+IRQCHIP_MATCH("renesas,r9a09g047-icu", rzg3e_icu_probe)
+IRQCHIP_MATCH("renesas,r9a09g057-icu", rzv2h_icu_probe)
 IRQCHIP_PLATFORM_DRIVER_END(rzv2h_icu)
 MODULE_AUTHOR("Fabrizio Castro <fabrizio.castro.jz@renesas.com>");
 MODULE_DESCRIPTION("Renesas RZ/V2H(P) ICU Driver");
diff --git a/drivers/irqchip/irq-starfive-jh8100-intc.c b/drivers/irqchip/irq=
-starfive-jh8100-intc.c
index 117f2c6..705361b 100644
--- a/drivers/irqchip/irq-starfive-jh8100-intc.c
+++ b/drivers/irqchip/irq-starfive-jh8100-intc.c
@@ -114,8 +114,9 @@ static void starfive_intc_irq_handler(struct irq_desc *de=
sc)
 	chained_irq_exit(chip, desc);
 }
=20
-static int starfive_intc_init(struct device_node *intc, struct device_node *=
parent)
+static int starfive_intc_probe(struct platform_device *pdev, struct device_n=
ode *parent)
 {
+	struct device_node *intc =3D pdev->dev.of_node;
 	struct starfive_irq_chip *irqc;
 	struct reset_control *rst;
 	struct clk *clk;
@@ -198,7 +199,7 @@ err_free:
 }
=20
 IRQCHIP_PLATFORM_DRIVER_BEGIN(starfive_intc)
-IRQCHIP_MATCH("starfive,jh8100-intc", starfive_intc_init)
+IRQCHIP_MATCH("starfive,jh8100-intc", starfive_intc_probe)
 IRQCHIP_PLATFORM_DRIVER_END(starfive_intc)
=20
 MODULE_DESCRIPTION("StarFive JH8100 External Interrupt Controller");
diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index 652d20d..689c8e4 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -36,9 +36,9 @@ int platform_irqchip_probe(struct platform_device *pdev)
 {
 	struct device_node *np =3D pdev->dev.of_node;
 	struct device_node *par_np __free(device_node) =3D of_irq_find_parent(np);
-	of_irq_init_cb_t irq_init_cb =3D of_device_get_match_data(&pdev->dev);
+	platform_irq_probe_t irq_probe =3D of_device_get_match_data(&pdev->dev);
=20
-	if (!irq_init_cb)
+	if (!irq_probe)
 		return -EINVAL;
=20
 	if (par_np =3D=3D np)
@@ -55,6 +55,6 @@ int platform_irqchip_probe(struct platform_device *pdev)
 	if (par_np && !irq_find_matching_host(par_np, DOMAIN_BUS_ANY))
 		return -EPROBE_DEFER;
=20
-	return irq_init_cb(np, par_np);
+	return irq_probe(pdev, par_np);
 }
 EXPORT_SYMBOL_GPL(platform_irqchip_probe);
diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 52d7754..518f7f0 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -350,9 +350,10 @@ static int pdc_setup_pin_mapping(struct device_node *np)
=20
 #define QCOM_PDC_SIZE 0x30000
=20
-static int qcom_pdc_init(struct device_node *node, struct device_node *paren=
t)
+static int qcom_pdc_probe(struct platform_device *pdev, struct device_node *=
parent)
 {
 	struct irq_domain *parent_domain, *pdc_domain;
+	struct device_node *node =3D pdev->dev.of_node;
 	resource_size_t res_size;
 	struct resource res;
 	int ret;
@@ -428,7 +429,7 @@ fail:
 }
=20
 IRQCHIP_PLATFORM_DRIVER_BEGIN(qcom_pdc)
-IRQCHIP_MATCH("qcom,pdc", qcom_pdc_init)
+IRQCHIP_MATCH("qcom,pdc", qcom_pdc_probe)
 IRQCHIP_PLATFORM_DRIVER_END(qcom_pdc)
 MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Power Domain Controller");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index d5e6024..bc4ddac 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -17,12 +17,18 @@
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
=20
+typedef int (*platform_irq_probe_t)(struct platform_device *, struct device_=
node *);
+
 /* Undefined on purpose */
 extern of_irq_init_cb_t typecheck_irq_init_cb;
+extern platform_irq_probe_t typecheck_irq_probe;
=20
 #define typecheck_irq_init_cb(fn)					\
 	(__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
=20
+#define typecheck_irq_probe(fn)						\
+	(__typecheck(typecheck_irq_probe, &fn) ? fn : fn)
+
 /*
  * This macro must be used by the different irqchip drivers to declare
  * the association between their DT compatible string and their
@@ -42,7 +48,7 @@ extern int platform_irqchip_probe(struct platform_device *p=
dev);
 static const struct of_device_id drv_name##_irqchip_match_table[] =3D {
=20
 #define IRQCHIP_MATCH(compat, fn) { .compatible =3D compat,		\
-				    .data =3D typecheck_irq_init_cb(fn), },
+				    .data =3D typecheck_irq_probe(fn), },
=20
=20
 #define IRQCHIP_PLATFORM_DRIVER_END(drv_name, ...)			\

