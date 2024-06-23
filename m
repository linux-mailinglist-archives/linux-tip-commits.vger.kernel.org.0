Return-Path: <linux-tip-commits+bounces-1496-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00094913D14
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 19:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC341C20E36
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 17:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC643C38;
	Sun, 23 Jun 2024 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SsPU5/mR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="or8miRNf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113E618306E;
	Sun, 23 Jun 2024 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719163113; cv=none; b=fa6Cpe2k3JOeMym4AdqJYu4sGgZEubywd6tKutFVSo9rbq/h/p+kBoNja53MPvT2CFLJ406TJZI4ORg+DzrYBOp0GbNvralFAIXYtJfPHU5F5ihBaGA6zm5vdk6so16wwuClBwN0JQx0NAQNV1mj7tL5XSr1Lfja1nSKGaT7DRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719163113; c=relaxed/simple;
	bh=6ZafoGuWaP9ONzJN3CWEEI4fkc3hxDEK66Lq3Dof8Oo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lW0CCUdGWT7r5asVjecA9pJFl6sXw/Zftimk2q+t+FjoXi4xGLOMxgssAYEJ4S74XBf2uCddc8IWgThDcKad+gb9PXJJLfC476q0KTRKSHgWC7jX8soZDeMZnisAMo4gVjbvf/G1pLStLfAuTFkq/fBt2rXsYJUumlHjSOmZPPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SsPU5/mR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=or8miRNf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Jun 2024 17:18:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719163110;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MuPj44ubZSXzA2N3XLgIOI91Ghg9dbloFubHMWH2TtE=;
	b=SsPU5/mR1bpGAFo1lI9v8WhbY87fb8WknfH+6BU4I4wC9u+Sg1JYLn5gOo+m5yMCWTYkQs
	bWqSMABZdMoNhobssxIzog7CAtDOI0pgoeLTPejpB3vN+zg2Z+g5gTKRzkD4VmhBbw52ae
	dxBDo2CtHgGtLzYu7jNCf47z7ehhRUc1OegIxAY6u6/du0kaaKK87sVrJBDN5pnW16ZUh2
	I6rP6PSnzwHdrhDnf7eBTlGPW4CWqdBwYZt2ksheE7ef2qi+ZlGDbjH9GQkF3Z3wDd5VR2
	GfeJ3DukMEuqnr/O86nYYzuyx49UzHDxGN/mE+cBAgu4Bix11LPpk2Lqwfk/Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719163110;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MuPj44ubZSXzA2N3XLgIOI91Ghg9dbloFubHMWH2TtE=;
	b=or8miRNfkHyFfVxjQ7P3t4Da0Jgz72aeLRDsclJ5Cfs2P8D8WBFKf4Pj558r5ZED37y+pA
	ByppIXfxTXCCaICw==
From: "tip-bot2 for Jinjie Ruan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/riscv-aplic: Simplify the initialization code
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240603125652.791601-1-ruanjinjie@huawei.com>
References: <20240603125652.791601-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171916310949.10875.5014507511390505553.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ef7080bd30bab81a1c4dd7c0afd942d2ab43081d
Gitweb:        https://git.kernel.org/tip/ef7080bd30bab81a1c4dd7c0afd942d2ab43081d
Author:        Jinjie Ruan <ruanjinjie@huawei.com>
AuthorDate:    Mon, 03 Jun 2024 12:56:52 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 23 Jun 2024 19:09:14 +02:00

irqchip/riscv-aplic: Simplify the initialization code

The initialization code has an is_of_node() check and invokes to_of_node()
for every of_property_*() invocation.

to_of_node() has a is_of_node() check already, so simplify the code by
invoking to_of_node() and checking that for NULL. If not NULL hand in the
node pointer to of_property_*().

The same applies to of_property_*() which fails when invoked with a NULL
node pointer.

[ tglx: Massaged change log ]

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240603125652.791601-1-ruanjinjie@huawei.com
---
 drivers/irqchip/irq-riscv-aplic-main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
index 774a0c9..28dd175 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.c
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -127,6 +127,7 @@ static void aplic_init_hw_irqs(struct aplic_priv *priv)
 
 int aplic_setup_priv(struct aplic_priv *priv, struct device *dev, void __iomem *regs)
 {
+	struct device_node *np = to_of_node(dev->fwnode);
 	struct of_phandle_args parent;
 	int rc;
 
@@ -134,7 +135,7 @@ int aplic_setup_priv(struct aplic_priv *priv, struct device *dev, void __iomem *
 	 * Currently, only OF fwnode is supported so extend this
 	 * function for ACPI support.
 	 */
-	if (!is_of_node(dev->fwnode))
+	if (!np)
 		return -EINVAL;
 
 	/* Save device pointer and register base */
@@ -142,8 +143,7 @@ int aplic_setup_priv(struct aplic_priv *priv, struct device *dev, void __iomem *
 	priv->regs = regs;
 
 	/* Find out number of interrupt sources */
-	rc = of_property_read_u32(to_of_node(dev->fwnode), "riscv,num-sources",
-				  &priv->nr_irqs);
+	rc = of_property_read_u32(np, "riscv,num-sources", &priv->nr_irqs);
 	if (rc) {
 		dev_err(dev, "failed to get number of interrupt sources\n");
 		return rc;
@@ -155,8 +155,8 @@ int aplic_setup_priv(struct aplic_priv *priv, struct device *dev, void __iomem *
 	 * If "msi-parent" property is present then we ignore the
 	 * APLIC IDCs which forces the APLIC driver to use MSI mode.
 	 */
-	if (!of_property_present(to_of_node(dev->fwnode), "msi-parent")) {
-		while (!of_irq_parse_one(to_of_node(dev->fwnode), priv->nr_idcs, &parent))
+	if (!of_property_present(np, "msi-parent")) {
+		while (!of_irq_parse_one(np, priv->nr_idcs, &parent))
 			priv->nr_idcs++;
 	}
 
@@ -184,8 +184,7 @@ static int aplic_probe(struct platform_device *pdev)
 	 * If msi-parent property is present then setup APLIC MSI
 	 * mode otherwise setup APLIC direct mode.
 	 */
-	if (is_of_node(dev->fwnode))
-		msi_mode = of_property_present(to_of_node(dev->fwnode), "msi-parent");
+	msi_mode = of_property_present(to_of_node(dev->fwnode), "msi-parent");
 	if (msi_mode)
 		rc = aplic_msi_setup(dev, regs);
 	else

