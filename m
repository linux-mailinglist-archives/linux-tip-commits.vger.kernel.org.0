Return-Path: <linux-tip-commits+bounces-1713-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A2F9351B1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 20:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAB0C1F21AF3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 18:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5769145FF9;
	Thu, 18 Jul 2024 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nOo9w8D8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HwgYuA9H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F261145A1D;
	Thu, 18 Jul 2024 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327944; cv=none; b=BKLDhpyTvn/SiHx+wSI+JnU+fF0+TPdJarRhtykhLAAZ4ldeTMcCKhOC8NN5Hl3G/unNd5SgJfYFGNj0oZcqPLL1sw8KGCtqaD8cBRGPYLVu3wuRhaDLS+mycHmXFJlcjYkDwK+LeMtblACzxKugWfq497AmCdNcu80SiaGqkaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327944; c=relaxed/simple;
	bh=QAUKpVjORLRRRP+kTdj6yY4rd6Yseazq4EHThyOy8ww=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J+btfy/Jz4xgRC/8Hy7VyjMHIoeoobGjAQly2x1jUzKLe3kkfOpMziLBBiLWJSAmNwQvsK1qvFpvGnZXKGIyJ0a/8Xu+RvxCkFCi7Xl96jhxxM2b4Fk5vUo75FVEM+EsFtcFZ0TOv1Z6zwncF78UoPIhh3kcWBe2zIIuqPXPyA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nOo9w8D8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HwgYuA9H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jul 2024 18:38:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721327939;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fwE76GWIMu0Ja7s6eUjwB1twl/VsLWBzTy9Cgm4ovNs=;
	b=nOo9w8D8etXGb4keiYIKVyN/0v0tAV9Z0va/VKwFHimGKJlNQDiMqNNh4P5NKmsH5uLooY
	Yf0d5m+V3TSHPmpXE9ARdo97/AwsrZtvNaYhfBBFo0SkZyxdxzCCWSs5yJx0haMX0/NuF+
	xoEeCKLq5VIgNvG4XAgfThmxB7QzAF4SxPW0RCT3gPpNgdTTqRMRdE5Kzh/2C/aE5Es0Np
	tRa2ZCl/gBUrF66J36Y5dU3gvL8qILrG4Do4kva5c2/HuiuXP6IRGFCbgkJI+GXzkzAkAt
	N2aB9CgDdFdw7xXzk0B1/op/O5JcIJW+eNYUg4Wbzq4dmla2o6DF4b/COFwciA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721327939;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fwE76GWIMu0Ja7s6eUjwB1twl/VsLWBzTy9Cgm4ovNs=;
	b=HwgYuA9HVU5Qt3aRHdhbLDxYMeR2fkQKA4mKCZyeaWQrt1RlEhCzE3+f6J8fTBcWTNfbQ7
	R1r3WCkCQpD8JVAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/imx-mu-msi: Switch to MSI parent
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240623142235.574932935@linutronix.de>
References: <20240623142235.574932935@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172132793940.2215.18276732071692896083.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     7b2f8aa005bc141ac9144f2fcf2cfb63abd7a0b1
Gitweb:        https://git.kernel.org/tip/7b2f8aa005bc141ac9144f2fcf2cfb63abd7a0b1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:18:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jul 2024 20:31:20 +02:00

irqchip/imx-mu-msi: Switch to MSI parent

All platform MSI users and the PCI/MSI code handle per device MSI domains
when the irqdomain associated to the device provides MSI parent
functionality.

Remove the "global" platform domain related code and provide the MSI parent
functionality by filling in msi_parent_ops.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240623142235.574932935@linutronix.de



---
 drivers/irqchip/Kconfig          |  1 +-
 drivers/irqchip/irq-imx-mu-msi.c | 48 +++++++++++++------------------
 drivers/irqchip/irq-msi-lib.c    |  2 +-
 3 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 2104b87..e7a57b3 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -492,6 +492,7 @@ config IMX_MU_MSI
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_MSI_IRQ
+	select IRQ_MSI_LIB
 	help
 	  Provide a driver for the i.MX Messaging Unit block used as a
 	  CPU-to-CPU MSI controller. This requires a specially crafted DT
diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-msi.c
index 1dceda0..4342a21 100644
--- a/drivers/irqchip/irq-imx-mu-msi.c
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -24,6 +24,8 @@
 #include <linux/pm_domain.h>
 #include <linux/spinlock.h>
 
+#include "irq-msi-lib.h"
+
 #define IMX_MU_CHANS            4
 
 enum imx_mu_xcr {
@@ -114,20 +116,6 @@ static void imx_mu_msi_parent_ack_irq(struct irq_data *data)
 	imx_mu_read(msi_data, msi_data->cfg->xRR + data->hwirq * 4);
 }
 
-static struct irq_chip imx_mu_msi_irq_chip = {
-	.name = "MU-MSI",
-	.irq_ack = irq_chip_ack_parent,
-};
-
-static struct msi_domain_ops imx_mu_msi_irq_ops = {
-};
-
-static struct msi_domain_info imx_mu_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
-	.ops	= &imx_mu_msi_irq_ops,
-	.chip	= &imx_mu_msi_irq_chip,
-};
-
 static void imx_mu_msi_parent_compose_msg(struct irq_data *data,
 					  struct msi_msg *msg)
 {
@@ -195,6 +183,7 @@ static void imx_mu_msi_domain_irq_free(struct irq_domain *domain,
 }
 
 static const struct irq_domain_ops imx_mu_msi_domain_ops = {
+	.select	= msi_lib_irq_domain_select,
 	.alloc	= imx_mu_msi_domain_irq_alloc,
 	.free	= imx_mu_msi_domain_irq_free,
 };
@@ -216,6 +205,21 @@ static void imx_mu_msi_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+#define IMX_MU_MSI_FLAGS_REQUIRED	(MSI_FLAG_USE_DEF_DOM_OPS |	\
+					 MSI_FLAG_USE_DEF_CHIP_OPS |	\
+					 MSI_FLAG_PARENT_PM_DEV)
+
+#define IMX_MU_MSI_FLAGS_SUPPORTED	(MSI_GENERIC_FLAGS_MASK)
+
+static const struct msi_parent_ops imx_mu_msi_parent_ops = {
+	.supported_flags	= IMX_MU_MSI_FLAGS_SUPPORTED,
+	.required_flags		= IMX_MU_MSI_FLAGS_REQUIRED,
+	.bus_select_token       = DOMAIN_BUS_NEXUS,
+	.bus_select_mask	= MATCH_PLATFORM_MSI,
+	.prefix			= "MU-MSI-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+};
+
 static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data, struct device *dev)
 {
 	struct fwnode_handle *fwnodes = dev_fwnode(dev);
@@ -230,19 +234,9 @@ static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data, struct device *d
 	}
 
 	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
-
-	msi_data->msi_domain = platform_msi_create_irq_domain(fwnodes,
-					&imx_mu_msi_domain_info,
-					parent);
-
-	if (!msi_data->msi_domain) {
-		dev_err(dev, "failed to create MSI domain\n");
-		irq_domain_remove(parent);
-		return -ENOMEM;
-	}
-
-	irq_domain_set_pm_device(msi_data->msi_domain, dev);
-
+	parent->dev = parent->pm_dev = dev;
+	parent->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	parent->msi_parent_ops = &imx_mu_msi_parent_ops;
 	return 0;
 }
 
diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index d20a0e6..b5b9000 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -94,6 +94,8 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 	/* Chip updates for all child bus types */
 	if (!info->chip->irq_eoi)
 		info->chip->irq_eoi	= irq_chip_eoi_parent;
+	if (!info->chip->irq_ack)
+		info->chip->irq_ack	= irq_chip_ack_parent;
 
 	/*
 	 * The device MSI domain can never have a set affinity callback. It

