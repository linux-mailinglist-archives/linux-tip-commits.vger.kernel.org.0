Return-Path: <linux-tip-commits+bounces-5611-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 141B2ABA416
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590B8502D25
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC932882D5;
	Fri, 16 May 2025 19:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oTUw3Sd7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A6PX2ghF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D53286422;
	Fri, 16 May 2025 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424262; cv=none; b=GoOC5+0TAzfaOW5RgrvAOTO/FZhdU+rX9JmzEB9Vo7I7xxB+A31xWp2F9jVneGFt64Sbu4TBKm0saESqsDeGzBHxRFRF6ks+PC0Ahg/+iNkA9z/E/04tbSB5B3Vwu4kNdeWsIZaLxD6wgPhYbcFCPbMtjyt3g2WwcYMK5f0+Rhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424262; c=relaxed/simple;
	bh=YBeS+kKa5t8MeE4Ee7QYjnX0i0Rws2reXR3PzdDe4i0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CP6Wd9L05km6oHIkun3yOye4YUPcbI5AYL334t1JAP3LIO0BORoI4x9125MaFIMpK6Z5hU45JfF2fpImLa9TRkWeYJzQ7oBEiMNZ2f1wNZXlHbfoSbHG51yxEchnNjSRUbEJgF496PqFHwJJd+xP2OkltEMWmYELi1x1uP3DqAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oTUw3Sd7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A6PX2ghF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424258;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7LDkt05fhjVnXEkmOLMTrXtc89dtWTXigDP9XP5/psM=;
	b=oTUw3Sd7WUvbljklTOpVfCewA3QsX1Jn6n1nzaNxORJv7VG7d98N+LR7pqOE4oqLSrWWR7
	4nU91+cCQs/FchEnRvVgpT3ZkzGTPEgt/EpHgbTtod53QAXdOjHdfLgJy0p8IBhJFw/5T2
	zmytpnn0aSlWSZTBhEfar/qCAKdZSPkh8VZyPvjAZpt9HTbfaEg7C7IPBMDU1AoIetXuw8
	ppRoqJuL4XyjQeGATCPla7z4EB5PI3z/ai/8IceGPK6njMQKrDjumUufNokUALJ8zHr00F
	88/UHYzqcgXkauzgE/DPdM3S3KRg7N8Azn125VJhZDTr6Y7F0AQ4Zj5W9ZESlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424258;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7LDkt05fhjVnXEkmOLMTrXtc89dtWTXigDP9XP5/psM=;
	b=A6PX2ghF1E41GXIWCGh7lmeKXWBzeNuE7zASC3w69smQPTZvG1TL5umQolJ4SOzSzUX7h4
	ihIAZxRv2RFvOACQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] mfd: Switch to irq_domain_create_*()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-25-jirislaby@kernel.org>
References: <20250319092951.37667-25-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742425723.406.4753985083682516912.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     a36aa0f7226a25c8789c63347d97620dd47ab6e1
Gitweb:        https://git.kernel.org/tip/a36aa0f7226a25c8789c63347d97620dd47ab6e1
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:10 +02:00

mfd: Switch to irq_domain_create_*()

irq_domain_add_*() interfaces are going away as being obsolete now.
Switch to the preferred irq_domain_create_*() ones. Those differ in the
node parameter: They take more generic struct fwnode_handle instead of
struct device_node. Therefore, of_fwnode_handle() is added around the
original parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-25-jirislaby@kernel.org



---
 drivers/mfd/88pm860x-core.c   |  4 ++--
 drivers/mfd/ab8500-core.c     |  6 +++---
 drivers/mfd/arizona-irq.c     |  3 +--
 drivers/mfd/db8500-prcmu.c    |  6 +++---
 drivers/mfd/fsl-imx25-tsadc.c |  5 ++---
 drivers/mfd/lp8788-irq.c      |  2 +-
 drivers/mfd/max8925-core.c    |  4 ++--
 drivers/mfd/max8997-irq.c     |  4 ++--
 drivers/mfd/max8998-irq.c     |  2 +-
 drivers/mfd/mt6358-irq.c      |  6 +++---
 drivers/mfd/mt6397-irq.c      |  6 ++----
 drivers/mfd/qcom-pm8xxx.c     |  6 ++----
 drivers/mfd/stmfx.c           |  2 +-
 drivers/mfd/stmpe.c           |  4 ++--
 drivers/mfd/tc3589x.c         |  6 +++---
 drivers/mfd/tps65217.c        |  2 +-
 drivers/mfd/tps6586x.c        |  2 +-
 drivers/mfd/twl4030-irq.c     |  4 ++--
 drivers/mfd/twl6030-irq.c     |  5 ++---
 drivers/mfd/wm831x-irq.c      | 15 ++++++---------
 drivers/mfd/wm8994-irq.c      |  4 +---
 21 files changed, 43 insertions(+), 55 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 8e68b64..488e346 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -624,8 +624,8 @@ static int device_irq_init(struct pm860x_chip *chip,
 		ret = -EBUSY;
 		goto out;
 	}
-	irq_domain_add_legacy(node, nr_irqs, chip->irq_base, 0,
-			      &pm860x_irq_domain_ops, chip);
+	irq_domain_create_legacy(of_fwnode_handle(node), nr_irqs, chip->irq_base, 0,
+				 &pm860x_irq_domain_ops, chip);
 	chip->core_irq = i2c->irq;
 	if (!chip->core_irq)
 		goto out;
diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 15c9582..049abcb 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -580,9 +580,9 @@ static int ab8500_irq_init(struct ab8500 *ab8500, struct device_node *np)
 		num_irqs = AB8500_NR_IRQS;
 
 	/* If ->irq_base is zero this will give a linear mapping */
-	ab8500->domain = irq_domain_add_simple(ab8500->dev->of_node,
-					       num_irqs, 0,
-					       &ab8500_irq_ops, ab8500);
+	ab8500->domain = irq_domain_create_simple(of_fwnode_handle(ab8500->dev->of_node),
+						  num_irqs, 0,
+						  &ab8500_irq_ops, ab8500);
 
 	if (!ab8500->domain) {
 		dev_err(ab8500->dev, "Failed to create irqdomain\n");
diff --git a/drivers/mfd/arizona-irq.c b/drivers/mfd/arizona-irq.c
index d919ae9..ac21395 100644
--- a/drivers/mfd/arizona-irq.c
+++ b/drivers/mfd/arizona-irq.c
@@ -312,8 +312,7 @@ int arizona_irq_init(struct arizona *arizona)
 	flags |= arizona->pdata.irq_flags;
 
 	/* Allocate a virtual IRQ domain to distribute to the regmap domains */
-	arizona->virq = irq_domain_add_linear(NULL, 2, &arizona_domain_ops,
-					      arizona);
+	arizona->virq = irq_domain_create_linear(NULL, 2, &arizona_domain_ops, arizona);
 	if (!arizona->virq) {
 		dev_err(arizona->dev, "Failed to add core IRQ domain\n");
 		ret = -EINVAL;
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 5b3e355..21e68a3 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2607,9 +2607,9 @@ static int db8500_irq_init(struct device_node *np)
 {
 	int i;
 
-	db8500_irq_domain = irq_domain_add_simple(
-		np, NUM_PRCMU_WAKEUPS, 0,
-		&db8500_irq_ops, NULL);
+	db8500_irq_domain = irq_domain_create_simple(of_fwnode_handle(np),
+						     NUM_PRCMU_WAKEUPS, 0,
+						     &db8500_irq_ops, NULL);
 
 	if (!db8500_irq_domain) {
 		pr_err("Failed to create irqdomain\n");
diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-tsadc.c
index 6fe388d..d471524 100644
--- a/drivers/mfd/fsl-imx25-tsadc.c
+++ b/drivers/mfd/fsl-imx25-tsadc.c
@@ -65,15 +65,14 @@ static int mx25_tsadc_setup_irq(struct platform_device *pdev,
 				struct mx25_tsadc *tsadc)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	int irq;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
 
-	tsadc->domain = irq_domain_add_simple(np, 2, 0, &mx25_tsadc_domain_ops,
-					      tsadc);
+	tsadc->domain = irq_domain_create_simple(of_fwnode_handle(dev->of_node), 2, 0,
+						 &mx25_tsadc_domain_ops, tsadc);
 	if (!tsadc->domain) {
 		dev_err(dev, "Failed to add irq domain\n");
 		return -ENOMEM;
diff --git a/drivers/mfd/lp8788-irq.c b/drivers/mfd/lp8788-irq.c
index 3900629..ea0fdf7 100644
--- a/drivers/mfd/lp8788-irq.c
+++ b/drivers/mfd/lp8788-irq.c
@@ -161,7 +161,7 @@ int lp8788_irq_init(struct lp8788 *lp, int irq)
 		return -ENOMEM;
 
 	irqd->lp = lp;
-	irqd->domain = irq_domain_add_linear(lp->dev->of_node, LP8788_INT_MAX,
+	irqd->domain = irq_domain_create_linear(of_fwnode_handle(lp->dev->of_node), LP8788_INT_MAX,
 					&lp8788_domain_ops, irqd);
 	if (!irqd->domain) {
 		dev_err(lp->dev, "failed to add irq domain err\n");
diff --git a/drivers/mfd/max8925-core.c b/drivers/mfd/max8925-core.c
index 105d79b..78b16c6 100644
--- a/drivers/mfd/max8925-core.c
+++ b/drivers/mfd/max8925-core.c
@@ -682,8 +682,8 @@ static int max8925_irq_init(struct max8925_chip *chip, int irq,
 		return -EBUSY;
 	}
 
-	irq_domain_add_legacy(node, MAX8925_NR_IRQS, chip->irq_base, 0,
-			      &max8925_irq_domain_ops, chip);
+	irq_domain_create_legacy(of_fwnode_handle(node), MAX8925_NR_IRQS, chip->irq_base, 0,
+				 &max8925_irq_domain_ops, chip);
 
 	/* request irq handler for pmic main irq*/
 	chip->core_irq = irq;
diff --git a/drivers/mfd/max8997-irq.c b/drivers/mfd/max8997-irq.c
index 92e348d..cc87571 100644
--- a/drivers/mfd/max8997-irq.c
+++ b/drivers/mfd/max8997-irq.c
@@ -327,8 +327,8 @@ int max8997_irq_init(struct max8997_dev *max8997)
 					true : false;
 	}
 
-	domain = irq_domain_add_linear(NULL, MAX8997_IRQ_NR,
-					&max8997_irq_domain_ops, max8997);
+	domain = irq_domain_create_linear(NULL, MAX8997_IRQ_NR,
+					  &max8997_irq_domain_ops, max8997);
 	if (!domain) {
 		dev_err(max8997->dev, "could not create irq domain\n");
 		return -ENODEV;
diff --git a/drivers/mfd/max8998-irq.c b/drivers/mfd/max8998-irq.c
index 83b6f51..b0773fa 100644
--- a/drivers/mfd/max8998-irq.c
+++ b/drivers/mfd/max8998-irq.c
@@ -230,7 +230,7 @@ int max8998_irq_init(struct max8998_dev *max8998)
 	max8998_write_reg(max8998->i2c, MAX8998_REG_STATUSM1, 0xff);
 	max8998_write_reg(max8998->i2c, MAX8998_REG_STATUSM2, 0xff);
 
-	domain = irq_domain_add_simple(NULL, MAX8998_IRQ_NR,
+	domain = irq_domain_create_simple(NULL, MAX8998_IRQ_NR,
 			max8998->irq_base, &max8998_irq_domain_ops, max8998);
 	if (!domain) {
 		dev_err(max8998->dev, "could not create irq domain\n");
diff --git a/drivers/mfd/mt6358-irq.c b/drivers/mfd/mt6358-irq.c
index 49830b5..9f0bcc3 100644
--- a/drivers/mfd/mt6358-irq.c
+++ b/drivers/mfd/mt6358-irq.c
@@ -272,9 +272,9 @@ int mt6358_irq_init(struct mt6397_chip *chip)
 				     irqd->pmic_ints[i].en_reg_shift * j, 0);
 	}
 
-	chip->irq_domain = irq_domain_add_linear(chip->dev->of_node,
-						 irqd->num_pmic_irqs,
-						 &mt6358_irq_domain_ops, chip);
+	chip->irq_domain = irq_domain_create_linear(of_fwnode_handle(chip->dev->of_node),
+						    irqd->num_pmic_irqs,
+						    &mt6358_irq_domain_ops, chip);
 	if (!chip->irq_domain) {
 		dev_err(chip->dev, "Could not create IRQ domain\n");
 		return -ENODEV;
diff --git a/drivers/mfd/mt6397-irq.c b/drivers/mfd/mt6397-irq.c
index 1310665..badc614 100644
--- a/drivers/mfd/mt6397-irq.c
+++ b/drivers/mfd/mt6397-irq.c
@@ -216,10 +216,8 @@ int mt6397_irq_init(struct mt6397_chip *chip)
 		regmap_write(chip->regmap, chip->int_con[2], 0x0);
 
 	chip->pm_nb.notifier_call = mt6397_irq_pm_notifier;
-	chip->irq_domain = irq_domain_add_linear(chip->dev->of_node,
-						 MT6397_IRQ_NR,
-						 &mt6397_irq_domain_ops,
-						 chip);
+	chip->irq_domain = irq_domain_create_linear(of_fwnode_handle(chip->dev->of_node),
+						    MT6397_IRQ_NR, &mt6397_irq_domain_ops, chip);
 	if (!chip->irq_domain) {
 		dev_err(chip->dev, "could not create irq domain\n");
 		return -ENOMEM;
diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
index f9ebdf5..c96ea6f 100644
--- a/drivers/mfd/qcom-pm8xxx.c
+++ b/drivers/mfd/qcom-pm8xxx.c
@@ -559,10 +559,8 @@ static int pm8xxx_probe(struct platform_device *pdev)
 	chip->pm_irq_data = data;
 	spin_lock_init(&chip->pm_irq_lock);
 
-	chip->irqdomain = irq_domain_add_linear(pdev->dev.of_node,
-						data->num_irqs,
-						&pm8xxx_irq_domain_ops,
-						chip);
+	chip->irqdomain = irq_domain_create_linear(of_fwnode_handle(pdev->dev.of_node),
+						   data->num_irqs, &pm8xxx_irq_domain_ops, chip);
 	if (!chip->irqdomain)
 		return -ENODEV;
 
diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index f391c2c..823b1d2 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -269,7 +269,7 @@ static int stmfx_irq_init(struct i2c_client *client)
 	u32 irqoutpin = 0, irqtrigger;
 	int ret;
 
-	stmfx->irq_domain = irq_domain_add_simple(stmfx->dev->of_node,
+	stmfx->irq_domain = irq_domain_create_simple(of_fwnode_handle(stmfx->dev->of_node),
 						  STMFX_REG_IRQ_SRC_MAX, 0,
 						  &stmfx_irq_ops, stmfx);
 	if (!stmfx->irq_domain) {
diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 9c3cf58..819d19d 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -1219,8 +1219,8 @@ static int stmpe_irq_init(struct stmpe *stmpe, struct device_node *np)
 	int base = 0;
 	int num_irqs = stmpe->variant->num_irqs;
 
-	stmpe->domain = irq_domain_add_simple(np, num_irqs, base,
-					      &stmpe_irq_ops, stmpe);
+	stmpe->domain = irq_domain_create_simple(of_fwnode_handle(np), num_irqs,
+						 base, &stmpe_irq_ops, stmpe);
 	if (!stmpe->domain) {
 		dev_err(stmpe->dev, "Failed to create irqdomain\n");
 		return -ENOSYS;
diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
index ef953ee..2d4eb77 100644
--- a/drivers/mfd/tc3589x.c
+++ b/drivers/mfd/tc3589x.c
@@ -234,9 +234,9 @@ static const struct irq_domain_ops tc3589x_irq_ops = {
 
 static int tc3589x_irq_init(struct tc3589x *tc3589x, struct device_node *np)
 {
-	tc3589x->domain = irq_domain_add_simple(
-		np, TC3589x_NR_INTERNAL_IRQS, 0,
-		&tc3589x_irq_ops, tc3589x);
+	tc3589x->domain = irq_domain_create_simple(of_fwnode_handle(np),
+						   TC3589x_NR_INTERNAL_IRQS, 0,
+						   &tc3589x_irq_ops, tc3589x);
 
 	if (!tc3589x->domain) {
 		dev_err(tc3589x->dev, "Failed to create irqdomain\n");
diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index 029ecc3..4e9669d 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -158,7 +158,7 @@ static int tps65217_irq_init(struct tps65217 *tps, int irq)
 	tps65217_set_bits(tps, TPS65217_REG_INT, TPS65217_INT_MASK,
 			  TPS65217_INT_MASK, TPS65217_PROTECT_NONE);
 
-	tps->irq_domain = irq_domain_add_linear(tps->dev->of_node,
+	tps->irq_domain = irq_domain_create_linear(of_fwnode_handle(tps->dev->of_node),
 		TPS65217_NUM_IRQ, &tps65217_irq_domain_ops, tps);
 	if (!tps->irq_domain) {
 		dev_err(tps->dev, "Could not create IRQ domain\n");
diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index 8271489..853c482 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -363,7 +363,7 @@ static int tps6586x_irq_init(struct tps6586x *tps6586x, int irq,
 		new_irq_base = 0;
 	}
 
-	tps6586x->irq_domain = irq_domain_add_simple(tps6586x->dev->of_node,
+	tps6586x->irq_domain = irq_domain_create_simple(of_fwnode_handle(tps6586x->dev->of_node),
 				irq_num, new_irq_base, &tps6586x_domain_ops,
 				tps6586x);
 	if (!tps6586x->irq_domain) {
diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index 87496c1..232c2bf 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -691,8 +691,8 @@ int twl4030_init_irq(struct device *dev, int irq_num)
 		return irq_base;
 	}
 
-	irq_domain_add_legacy(node, nr_irqs, irq_base, 0,
-			      &irq_domain_simple_ops, NULL);
+	irq_domain_create_legacy(of_fwnode_handle(node), nr_irqs, irq_base, 0,
+				 &irq_domain_simple_ops, NULL);
 
 	irq_end = irq_base + TWL4030_CORE_NR_IRQS;
 
diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index 3c03681..00b14ce 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -364,7 +364,6 @@ static const struct of_device_id twl6030_of_match[] __maybe_unused = {
 
 int twl6030_init_irq(struct device *dev, int irq_num)
 {
-	struct			device_node *node = dev->of_node;
 	int			nr_irqs;
 	int			status;
 	u8			mask[3];
@@ -412,8 +411,8 @@ int twl6030_init_irq(struct device *dev, int irq_num)
 	twl6030_irq->irq_mapping_tbl = of_id->data;
 
 	twl6030_irq->irq_domain =
-		irq_domain_add_linear(node, nr_irqs,
-				      &twl6030_irq_domain_ops, twl6030_irq);
+		irq_domain_create_linear(of_fwnode_handle(dev->of_node), nr_irqs,
+					 &twl6030_irq_domain_ops, twl6030_irq);
 	if (!twl6030_irq->irq_domain) {
 		dev_err(dev, "Can't add irq_domain\n");
 		return -ENOMEM;
diff --git a/drivers/mfd/wm831x-irq.c b/drivers/mfd/wm831x-irq.c
index f1f58e3..b3883fa 100644
--- a/drivers/mfd/wm831x-irq.c
+++ b/drivers/mfd/wm831x-irq.c
@@ -587,16 +587,13 @@ int wm831x_irq_init(struct wm831x *wm831x, int irq)
 	}
 
 	if (irq_base)
-		domain = irq_domain_add_legacy(wm831x->dev->of_node,
-					       ARRAY_SIZE(wm831x_irqs),
-					       irq_base, 0,
-					       &wm831x_irq_domain_ops,
-					       wm831x);
+		domain = irq_domain_create_legacy(of_fwnode_handle(wm831x->dev->of_node),
+						  ARRAY_SIZE(wm831x_irqs), irq_base, 0,
+						  &wm831x_irq_domain_ops, wm831x);
 	else
-		domain = irq_domain_add_linear(wm831x->dev->of_node,
-					       ARRAY_SIZE(wm831x_irqs),
-					       &wm831x_irq_domain_ops,
-					       wm831x);
+		domain = irq_domain_create_linear(of_fwnode_handle(wm831x->dev->of_node),
+						  ARRAY_SIZE(wm831x_irqs), &wm831x_irq_domain_ops,
+						  wm831x);
 
 	if (!domain) {
 		dev_warn(wm831x->dev, "Failed to allocate IRQ domain\n");
diff --git a/drivers/mfd/wm8994-irq.c b/drivers/mfd/wm8994-irq.c
index 651a028..1475b1a 100644
--- a/drivers/mfd/wm8994-irq.c
+++ b/drivers/mfd/wm8994-irq.c
@@ -213,9 +213,7 @@ int wm8994_irq_init(struct wm8994 *wm8994)
 			return ret;
 		}
 
-		wm8994->edge_irq = irq_domain_add_linear(NULL, 1,
-							 &wm8994_edge_irq_ops,
-							 wm8994);
+		wm8994->edge_irq = irq_domain_create_linear(NULL, 1, &wm8994_edge_irq_ops, wm8994);
 
 		ret = regmap_add_irq_chip(wm8994->regmap,
 					  irq_create_mapping(wm8994->edge_irq,

