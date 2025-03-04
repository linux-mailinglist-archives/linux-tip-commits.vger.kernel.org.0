Return-Path: <linux-tip-commits+bounces-3933-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C5AA4E273
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 16:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A084319C2FB5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 15:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E164C27F4C9;
	Tue,  4 Mar 2025 14:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RWMkklXB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IC2GtJeS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAF627F4C0;
	Tue,  4 Mar 2025 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100296; cv=none; b=dVHn0PBWGzBRdOpNZfshzMQCW2aJbPKkK9Q1CBxi8zk/WyJywfrd+5DfuV8O2Xo5SfxnAFXvtWOlPGGNDZbJs5wU7bThwES7hdXuITLMXdhEVekc0Q465FAO514K+oaXlNdBUFv0JdP5v+HDjcGC/N1saPHp0vYyCW7OUiPCXXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100296; c=relaxed/simple;
	bh=WlwWHQo93Avh0OM5ijW/gcihTSuSzefKRniU7uzkVB8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VuFR79UTtd7UgoF6hZmaYOm9O2iVkmNGImzJuEwBsK+tQNP8mhKdVBguUQiNwxKdA4n/5+l3Q+bVUUEnvgx2Nu6mUBw6SNOxj8y1VoOXSIj4p4A0e+BTlQnAdM01iXQu23B/i+YTLPbgNoXWTpK2IDwYRRIOe6HES9rfcIm7QEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RWMkklXB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IC2GtJeS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 14:58:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741100292;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ASUcyuidWbDClu3x8HSX2PVgWwneiw/9KsPMZPtiGF0=;
	b=RWMkklXB6X3mFMmW3SVtR1hIqA8Lo5wiSCT/u91gQTSikVTecMpzae/Yv0X2uZF6mC2ZeI
	0tSztRHjYiMnY4b9gpVIMxQnjqH6o3Bw0f1X3OlYMVu3Wr8RKxZZBbXGX/vYPwrsl6gov+
	ycZxVX9L2SaIgbwuIprpQm3hor+9qT92dLKbZFqVCNhtUwlR6ErmGZmhlhQdtiajww0Mjh
	u0FMSZ7KdBo6Hcbr9PrePm/gl2cT1DVN56z0deVqSM8s36FIRMg4oXDGtX9YCrucPk/rV1
	anjgpTJg2Q4tXCj4FW+PJorH1fyaLDVhWKopv9HLO+qTI9qNyV1Mxyf7TW3yug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741100292;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ASUcyuidWbDClu3x8HSX2PVgWwneiw/9KsPMZPtiGF0=;
	b=IC2GtJeSOq8EbPkETa1Buh2naSvuGFMy712XaynGzjVtSAy9RbawFMaP12NCQSn9B3p4pl
	itKug4KHozbK86Ag==
From: "tip-bot2 for Bartosz Golaszewski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/davinci-cp-intc: Remove public header
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250304131815.86549-1-brgl@bgdev.pl>
References: <20250304131815.86549-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174110028955.14745.12031563162378541025.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     71cbbb7149e3de8c39dfe8a97eaa7f1cbcbff52f
Gitweb:        https://git.kernel.org/tip/71cbbb7149e3de8c39dfe8a97eaa7f1cbcbff52f
Author:        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
AuthorDate:    Tue, 04 Mar 2025 14:18:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 04 Mar 2025 15:46:59 +01:00

irqchip/davinci-cp-intc: Remove public header

There are no more users of irq-davinci-cp-intc.h (da830.c doesn't use
any of its symbols). Remove the header and make the driver stop using the
config structure.

[ tglx: Mop up coding style ]

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250304131815.86549-1-brgl@bgdev.pl
---
 arch/arm/mach-davinci/da830.c               |  1 +-
 drivers/irqchip/irq-davinci-cp-intc.c       | 57 +++++++-------------
 include/linux/irqchip/irq-davinci-cp-intc.h | 25 +---------
 3 files changed, 21 insertions(+), 62 deletions(-)
 delete mode 100644 include/linux/irqchip/irq-davinci-cp-intc.h

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 2e49774..a044ea5 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -11,7 +11,6 @@
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/irqchip/irq-davinci-cp-intc.h>
 
 #include <clocksource/timer-davinci.h>
 
diff --git a/drivers/irqchip/irq-davinci-cp-intc.c b/drivers/irqchip/irq-davinci-cp-intc.c
index f4f8e9f..d7948c5 100644
--- a/drivers/irqchip/irq-davinci-cp-intc.c
+++ b/drivers/irqchip/irq-davinci-cp-intc.c
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
-#include <linux/irqchip/irq-davinci-cp-intc.h>
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -154,24 +153,20 @@ static const struct irq_domain_ops davinci_cp_intc_irq_domain_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
-static int __init
-davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
-			struct device_node *node)
+static int __init davinci_cp_intc_do_init(struct resource *res, unsigned int num_irqs,
+					  struct device_node *node)
 {
-	unsigned int num_regs = BITS_TO_LONGS(config->num_irqs);
+	unsigned int num_regs = BITS_TO_LONGS(num_irqs);
 	int offset, irq_base;
 	void __iomem *req;
 
-	req = request_mem_region(config->reg.start,
-				 resource_size(&config->reg),
-				 "davinci-cp-intc");
+	req = request_mem_region(res->start, resource_size(res), "davinci-cp-intc");
 	if (!req) {
 		pr_err("%s: register range busy\n", __func__);
 		return -EBUSY;
 	}
 
-	davinci_cp_intc_base = ioremap(config->reg.start,
-				       resource_size(&config->reg));
+	davinci_cp_intc_base = ioremap(res->start, resource_size(res));
 	if (!davinci_cp_intc_base) {
 		pr_err("%s: unable to ioremap register range\n", __func__);
 		return -EINVAL;
@@ -184,8 +179,7 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 
 	/* Disable system interrupts */
 	for (offset = 0; offset < num_regs; offset++)
-		davinci_cp_intc_write(~0,
-			DAVINCI_CP_INTC_SYS_ENABLE_CLR(offset));
+		davinci_cp_intc_write(~0, DAVINCI_CP_INTC_SYS_ENABLE_CLR(offset));
 
 	/* Set to normal mode, no nesting, no priority hold */
 	davinci_cp_intc_write(0, DAVINCI_CP_INTC_CTRL);
@@ -193,28 +187,25 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 
 	/* Clear system interrupt status */
 	for (offset = 0; offset < num_regs; offset++)
-		davinci_cp_intc_write(~0,
-			DAVINCI_CP_INTC_SYS_STAT_CLR(offset));
+		davinci_cp_intc_write(~0, DAVINCI_CP_INTC_SYS_STAT_CLR(offset));
 
 	/* Enable nIRQ (what about nFIQ?) */
 	davinci_cp_intc_write(1, DAVINCI_CP_INTC_HOST_ENABLE_IDX_SET);
 
+	/* 4 channels per register */
+	num_regs = (num_irqs + 3) >> 2;
 	/* Default all priorities to channel 7. */
-	num_regs = (config->num_irqs + 3) >> 2;	/* 4 channels per register */
 	for (offset = 0; offset < num_regs; offset++)
-		davinci_cp_intc_write(0x07070707,
-			DAVINCI_CP_INTC_CHAN_MAP(offset));
+		davinci_cp_intc_write(0x07070707, DAVINCI_CP_INTC_CHAN_MAP(offset));
 
-	irq_base = irq_alloc_descs(-1, 0, config->num_irqs, 0);
+	irq_base = irq_alloc_descs(-1, 0, num_irqs, 0);
 	if (irq_base < 0) {
-		pr_err("%s: unable to allocate interrupt descriptors: %d\n",
-		       __func__, irq_base);
+		pr_err("%s: unable to allocate interrupt descriptors: %d\n", __func__, irq_base);
 		return irq_base;
 	}
 
-	davinci_cp_intc_irq_domain = irq_domain_add_legacy(
-					node, config->num_irqs, irq_base, 0,
-					&davinci_cp_intc_irq_domain_ops, NULL);
+	davinci_cp_intc_irq_domain = irq_domain_add_legacy(node, num_irqs, irq_base, 0,
+							   &davinci_cp_intc_irq_domain_ops, NULL);
 
 	if (!davinci_cp_intc_irq_domain) {
 		pr_err("%s: unable to create an interrupt domain\n", __func__);
@@ -229,31 +220,25 @@ davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
 	return 0;
 }
 
-int __init davinci_cp_intc_init(const struct davinci_cp_intc_config *config)
-{
-	return davinci_cp_intc_do_init(config, NULL);
-}
-
 static int __init davinci_cp_intc_of_init(struct device_node *node,
 					  struct device_node *parent)
 {
-	struct davinci_cp_intc_config config = { };
+	unsigned int num_irqs;
+	struct resource res;
 	int ret;
 
-	ret = of_address_to_resource(node, 0, &config.reg);
+	ret = of_address_to_resource(node, 0, &res);
 	if (ret) {
-		pr_err("%s: unable to get the register range from device-tree\n",
-		       __func__);
+		pr_err("%s: unable to get the register range from device-tree\n", __func__);
 		return ret;
 	}
 
-	ret = of_property_read_u32(node, "ti,intc-size", &config.num_irqs);
+	ret = of_property_read_u32(node, "ti,intc-size", &num_irqs);
 	if (ret) {
-		pr_err("%s: unable to read the 'ti,intc-size' property\n",
-		       __func__);
+		pr_err("%s: unable to read the 'ti,intc-size' property\n", __func__);
 		return ret;
 	}
 
-	return davinci_cp_intc_do_init(&config, node);
+	return davinci_cp_intc_do_init(&res, num_irqs, node);
 }
 IRQCHIP_DECLARE(cp_intc, "ti,cp-intc", davinci_cp_intc_of_init);
diff --git a/include/linux/irqchip/irq-davinci-cp-intc.h b/include/linux/irqchip/irq-davinci-cp-intc.h
deleted file mode 100644
index 8d71ed5..0000000
--- a/include/linux/irqchip/irq-davinci-cp-intc.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2019 Texas Instruments
- */
-
-#ifndef _LINUX_IRQ_DAVINCI_CP_INTC_
-#define _LINUX_IRQ_DAVINCI_CP_INTC_
-
-#include <linux/ioport.h>
-
-/**
- * struct davinci_cp_intc_config - configuration data for davinci-cp-intc
- *                                 driver.
- *
- * @reg: register range to map
- * @num_irqs: number of HW interrupts supported by the controller
- */
-struct davinci_cp_intc_config {
-	struct resource reg;
-	unsigned int num_irqs;
-};
-
-int davinci_cp_intc_init(const struct davinci_cp_intc_config *config);
-
-#endif /* _LINUX_IRQ_DAVINCI_CP_INTC_ */

