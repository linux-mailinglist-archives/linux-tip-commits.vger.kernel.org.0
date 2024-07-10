Return-Path: <linux-tip-commits+bounces-1658-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECB592D664
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 18:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81CA0B290CC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 16:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFF51990B5;
	Wed, 10 Jul 2024 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mpRPjpa/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F5gfCvjz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4957198A2B;
	Wed, 10 Jul 2024 16:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628755; cv=none; b=MPwJdl5db/UK/LnAF+6Is+c+VarM69Hs8VX21x8Rch2B2gjunvloSa9UNjM7CzaHgiuU7Ab14AGaJbuQiJIWxEe9nx9lZdbWmTXsruwkLcHJVtC49+vc3XsQxEUoUYmeTriv+xEbO+li5aPpfgfeKBaWJU3FIXkOV70vHyqXVXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628755; c=relaxed/simple;
	bh=c3LrdaO4+mRr6xEYjNZv1Et4tqVRt+ZL/NzSBIObZ2c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MIsbpziJXhrXVSeISTvUma1Pn/lR3hSJYwxgfs9E+I+MkupHbLZNBs5avFQ10u2FBosSXuo+ipKtp7eF5hMXCUibZcRiV+KQhzs2hJkjUkLP8q9h2Qx2nmZpewYMpw3mNNnmJ3hnXYLpxImdMBbiuhWsNLgUx9tV73rtliiRJ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mpRPjpa/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F5gfCvjz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jul 2024 16:25:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720628750;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEJiXpomFBYyoeqVrPnxwsSPhwJu47b+dovhTw92xPo=;
	b=mpRPjpa/bEZbgRtlLaXYW6lKRnNJevg6F7/39lKPlXwsOZjIFM/wpVERtbDKh4wImgi8Ig
	+FX/i3bvBEfM3bAlJgQwgLHh2hG1UmJuhEaAAMC5tOGDLt11+dOSxDKHG1NgEcjahfmn5k
	2LSNTIUMGz9jNMP5T6alTuHBQvYA6OYw/I63eH+2t4sipEqQ5p7iV3vD+Fs3RhNwlVElIb
	a4BcIeemKFJmI41WXGdvGy/ewf91T278v6GOfXlK5dD/L58QLX1RSLKwsr/4YYxcwibCnv
	6SVkckGLao292zWCZLSiytsxvDEF5qCHz3igvr0G0OhqI5ufJa95JucMwZQArw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720628750;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEJiXpomFBYyoeqVrPnxwsSPhwJu47b+dovhTw92xPo=;
	b=F5gfCvjzQ3ZsWBPJRIQ9VegRr7sMRnTGRdYyjF7RRX5yp6QvaVSaDl58b/zTNAQteyTgV6
	E/YwGrrnxHyrIcBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/imx-mu-msi: Switch to MSI parent
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240623142235.574932935@linutronix.de>
References: <20240623142235.574932935@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172062875023.2215.11071879140840076756.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0ce1d34b8040577c1ddd23eea63977c7be832419
Gitweb:        https://git.kernel.org/tip/0ce1d34b8040577c1ddd23eea63977c7be832419
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:18:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Jul 2024 18:19:24 +02:00

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
index d3fbe56..5b93a56 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -513,6 +513,7 @@ config IMX_MU_MSI
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_MSI_IRQ
+	select IRQ_MSI_LIB
 	help
 	  Provide a driver for the i.MX Messaging Unit block used as a
 	  CPU-to-CPU MSI controller. This requires a specially crafted DT
diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-msi.c
index 90d41c1..e4a5e47 100644
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
@@ -232,19 +236,9 @@ static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data, struct device *d
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

