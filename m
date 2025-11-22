Return-Path: <linux-tip-commits+bounces-7473-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ADAC7D3AE
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 17:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600AC3AA5E2
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 16:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C432459E5;
	Sat, 22 Nov 2025 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bUrwu0+s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="onOjNFRO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207D7218AAD;
	Sat, 22 Nov 2025 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763827911; cv=none; b=RDNMQ5KOe7lj3Lufci0jhDnST++DRkmmd10YD8HVSbJ2rw5ep86w6i//428hhn4bzK7ZF9N1xMGDpJsEMOR5vYodTMuspvfd30a+hfv9wOZIOuwfzy6D/I8lsouCYj7S/xj5ZgL7xqQDM6jZrIK5nuIKi5vTs3TEVIcjds7+p3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763827911; c=relaxed/simple;
	bh=tWAFodyrFmwpIv1TOXP88FwJSbqDDS9EnRV4kLZs2eI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iE/1tqJq8T7lhViEZjMgWBbePsO0a+4r/0iXWPxKnxGAks8qAjvJm/ikw7ni9OR54x4ixJkDKe27ufcPBDfIuHJIS9l15Cwft2y1oJI1y9MOXRbwfXARL7/4fg2NrVH5FaUQ/lBElBjN7TwbghYu6b2IfRo+K/tqdqU60giGf0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bUrwu0+s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=onOjNFRO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Nov 2025 16:11:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763827907;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kn//SlsIewDsWzRxNHMP5tE8QvmoH0AQyBTfrMi6KM=;
	b=bUrwu0+sTUjeYrB8btPOriTXQu9Gq8G8PfxfO3M7LbearTcQmJ3KSVKaQhf7H7XeGwuwN0
	2+k6T5blTeVt6DhmlMYKs2tviYk9BBBhuXno6A3NVMFFQUEFCvoyBD5WZoVGcxHqVfUhhb
	AFx/8uGoLmT6ygTR/5DC2/NFhuRWtcI8WfVc0S4wJXDD6C2u+NJPMVJ7ppD4qgl2Hx8tQZ
	ZJIOMEvRAqxB3enRv9YS+n12CLQmaVNtwGH4GKtMBksISTXHt/Kxdy25vRI6176mH3fdfe
	ZtIA6p8NBFZsaKjUXAilQhdCWtxCm0l2Ira7nYRlPB1g5Gy3vmzXhYszaIu3ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763827907;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kn//SlsIewDsWzRxNHMP5tE8QvmoH0AQyBTfrMi6KM=;
	b=onOjNFROJVv2sD5kPUNgY/WQwnLyVo2ba1Ra9hlFwj4LfBohCxW+P+taeAO9yiy5M8CInI
	SyuqqkggOYTdDZCQ==
From: "tip-bot2 for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/msi] irqchip/gic-its: Rework platform MSI deviceID detection
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251021124103.198419-6-lpieralisi@kernel.org>
References: <20251021124103.198419-6-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176382790629.498.7829820540991055186.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     9c1fbc56ca0a98113e75dcc5030103a02eff8897
Gitweb:        https://git.kernel.org/tip/9c1fbc56ca0a98113e75dcc5030103a02ef=
f8897
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Tue, 21 Oct 2025 14:41:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 22 Nov 2025 17:09:03 +01:00

irqchip/gic-its: Rework platform MSI deviceID detection

Current code retrieving platform devices MSI devID in the GIC ITS MSI
parent helpers suffers from some minor issues:

- It leaks a struct device_node reference
- It is duplicated between GICv3 and GICv5 for no good reason
- It does not use the OF phandle iterator code that simplifies
  the msi-parent property parsing

Consolidate GIC v3 and v5 deviceID retrieval in a function that addresses
the full set of issues in one go by merging GIC v3 and v5 code and
converting the msi-parent parsing loop to the more modern OF phandle
iterator API, fixing the struct device_node reference leak in the process.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://patch.msgid.link/20251021124103.198419-6-lpieralisi@kernel.org
---
 drivers/irqchip/irq-gic-its-msi-parent.c | 91 +++++------------------
 1 file changed, 23 insertions(+), 68 deletions(-)

diff --git a/drivers/irqchip/irq-gic-its-msi-parent.c b/drivers/irqchip/irq-g=
ic-its-msi-parent.c
index eb1473f..12f4522 100644
--- a/drivers/irqchip/irq-gic-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-its-msi-parent.c
@@ -142,83 +142,38 @@ static int its_v5_pci_msi_prepare(struct irq_domain *do=
main, struct device *dev,
 #define its_v5_pci_msi_prepare	NULL
 #endif /* !CONFIG_PCI_MSI */
=20
-static int of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev,
-				  u32 *dev_id)
+static int of_pmsi_get_msi_info(struct irq_domain *domain, struct device *de=
v, u32 *dev_id,
+				phys_addr_t *pa)
 {
-	int ret, index =3D 0;
+	struct of_phandle_iterator it;
+	int ret;
=20
 	/* Suck the DeviceID out of the msi-parent property */
-	do {
-		struct of_phandle_args args;
-
-		ret =3D of_parse_phandle_with_args(dev->of_node,
-						 "msi-parent", "#msi-cells",
-						 index, &args);
-		if (args.np =3D=3D irq_domain_get_of_node(domain)) {
-			if (WARN_ON(args.args_count !=3D 1))
-				return -EINVAL;
-			*dev_id =3D args.args[0];
-			break;
-		}
-		index++;
-	} while (!ret);
-
-	if (ret) {
-		struct device_node *np =3D NULL;
+	of_for_each_phandle(&it, ret, dev->of_node, "msi-parent", "#msi-cells", -1)=
 {
+		/* GICv5 ITS domain matches the MSI controller node parent */
+		struct device_node *np __free(device_node) =3D pa ? of_get_parent(it.node)
+								: of_node_get(it.node);
=20
-		ret =3D of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &np, d=
ev_id);
-		if (np)
-			of_node_put(np);
-	}
+		if (np =3D=3D irq_domain_get_of_node(domain)) {
+			u32 args;
=20
-	return ret;
-}
+			if (WARN_ON(of_phandle_iterator_args(&it, &args, 1) !=3D 1))
+				ret =3D -EINVAL;
=20
-static int of_v5_pmsi_get_msi_info(struct irq_domain *domain, struct device =
*dev,
-				   u32 *dev_id, phys_addr_t *pa)
-{
-	int ret, index =3D 0;
-	/*
-	 * Retrieve the DeviceID and the ITS translate frame node pointer
-	 * out of the msi-parent property.
-	 */
-	do {
-		struct of_phandle_args args;
-
-		ret =3D of_parse_phandle_with_args(dev->of_node,
-						 "msi-parent", "#msi-cells",
-						 index, &args);
-		if (ret)
-			break;
-		/*
-		 * The IRQ domain fwnode is the msi controller parent
-		 * in GICv5 (where the msi controller nodes are the
-		 * ITS translate frames).
-		 */
-		if (args.np->parent =3D=3D irq_domain_get_of_node(domain)) {
-			if (WARN_ON(args.args_count !=3D 1))
-				return -EINVAL;
-			*dev_id =3D args.args[0];
-
-			ret =3D its_translate_frame_address(args.np, pa);
-			if (ret)
-				return -ENODEV;
-			break;
-		}
-		index++;
-	} while (!ret);
+			if (!ret && pa)
+				ret =3D its_translate_frame_address(it.node, pa);
=20
-	if (ret) {
-		struct device_node *np =3D NULL;
+			if (!ret)
+				*dev_id =3D args;
=20
-		ret =3D of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &np, d=
ev_id);
-		if (np) {
-			ret =3D its_translate_frame_address(np, pa);
-			of_node_put(np);
+			of_node_put(it.node);
+			return ret;
 		}
 	}
=20
-	return ret;
+	struct device_node *msi_ctrl __free(device_node) =3D NULL;
+
+	return of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &msi_ctr=
l, dev_id);
 }
=20
 int __weak iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
@@ -234,7 +189,7 @@ static int its_pmsi_prepare(struct irq_domain *domain, st=
ruct device *dev,
 	int ret;
=20
 	if (dev->of_node)
-		ret =3D of_pmsi_get_dev_id(domain->parent, dev, &dev_id);
+		ret =3D of_pmsi_get_msi_info(domain->parent, dev, &dev_id, NULL);
 	else
 		ret =3D iort_pmsi_get_dev_id(dev, &dev_id);
 	if (ret)
@@ -262,7 +217,7 @@ static int its_v5_pmsi_prepare(struct irq_domain *domain,=
 struct device *dev,
 	if (!dev->of_node)
 		return -ENODEV;
=20
-	ret =3D of_v5_pmsi_get_msi_info(domain->parent, dev, &dev_id, &pa);
+	ret =3D of_pmsi_get_msi_info(domain->parent, dev, &dev_id, &pa);
 	if (ret)
 		return ret;
=20

