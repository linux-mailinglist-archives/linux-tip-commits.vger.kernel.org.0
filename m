Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05B928A8E0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgJKR70 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388476AbgJKR5l (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA119C0613DE;
        Sun, 11 Oct 2020 10:57:39 -0700 (PDT)
Date:   Sun, 11 Oct 2020 17:57:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439058;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=L8PH3Sn2ZGWICqslpD2e3s06Nj3+Uk40MKB7i6hDfk0=;
        b=fj+Yt3RWpgWXtP4HfBKGh+sHQzXZVEg7B9jrVfLmKGHsMaYtCMG/kJ0gPMaqVghVj/Rssq
        5FyA3+063knbciFiXEYs6S85/N8nwBwLYbkMQ+/f7ymaA9c6wkai719V+XFtKd8deg6uxG
        DtyK7GWB2Xz7+8FV+DErg3fq8jdqOrjW1ELSv7GtGQBsaZsHWEdNuLToOWoF4FSxJijH5a
        Qsw0Q0DjzSZ5A9XPH+TpBr+ihDNNl20B31hmVauDd5yrtiryRCivI/JPD52lwupf2ekd7s
        aFJWO7UXnpCcAxkz8FTJsottBSnOMZGZgjiErOaWgOojxRS7AuLvYdd8DpdF5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439058;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=L8PH3Sn2ZGWICqslpD2e3s06Nj3+Uk40MKB7i6hDfk0=;
        b=jODx5Wwi4WAUdP7C8RyvdcNrVb4ykWvBFKUfELVWpqbCUmkOgMhIoRGGlt+vQiFCUYpkHJ
        JlO3bzPfrfQIdgAA==
From:   "tip-bot2 for Suman Anna" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/irq-pruss-intc: Add logic for handling
 reserved interrupts
Cc:     Suman Anna <s-anna@ti.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243905763.7002.4705116681378116939.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     6016f32d1de2798cc88c1a4b703d0ea096c19793
Gitweb:        https://git.kernel.org/tip/6016f32d1de2798cc88c1a4b703d0ea096c19793
Author:        Suman Anna <s-anna@ti.com>
AuthorDate:    Wed, 16 Sep 2020 18:36:36 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 17 Sep 2020 12:20:31 +01:00

irqchip/irq-pruss-intc: Add logic for handling reserved interrupts

The PRUSS INTC has a fixed number of output interrupt lines that are
connected to a number of processors or other PRUSS instances or other
devices (like DMA) on the SoC. The output interrupt lines 2 through 9
are usually connected to the main Arm host processor and are referred
to as host interrupts 0 through 7 from ARM/MPU perspective.

All of these 8 host interrupts are not always exclusively connected
to the Arm interrupt controller. Some SoCs have some interrupt lines
not connected to the Arm interrupt controller at all, while a few others
have the interrupt lines connected to multiple processors in which they
need to be partitioned as per SoC integration needs. For example, AM437x
and 66AK2G SoCs have 2 PRUSS instances each and have the host interrupt 5
connected to the other PRUSS, while AM335x has host interrupt 0 shared
between MPU and TSC_ADC and host interrupts 6 & 7 shared between MPU and
a DMA controller.

Add logic to the PRUSS INTC driver to ignore both these shared and
invalid interrupts.

Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-pruss-intc.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
index c8bdef4..e7ba358 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -484,7 +484,7 @@ static int pruss_intc_probe(struct platform_device *pdev)
 	struct pruss_intc *intc;
 	struct pruss_host_irq_data *host_data;
 	int i, irq, ret;
-	u8 max_system_events;
+	u8 max_system_events, irqs_reserved = 0;
 
 	data = of_device_get_match_data(dev);
 	if (!data)
@@ -504,6 +504,16 @@ static int pruss_intc_probe(struct platform_device *pdev)
 	if (IS_ERR(intc->base))
 		return PTR_ERR(intc->base);
 
+	ret = of_property_read_u8(dev->of_node, "ti,irqs-reserved",
+				  &irqs_reserved);
+
+	/*
+	 * The irqs-reserved is used only for some SoC's therefore not having
+	 * this property is still valid
+	 */
+	if (ret < 0 && ret != -EINVAL)
+		return ret;
+
 	pruss_intc_init(intc);
 
 	mutex_init(&intc->lock);
@@ -514,6 +524,9 @@ static int pruss_intc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for (i = 0; i < MAX_NUM_HOST_IRQS; i++) {
+		if (irqs_reserved & BIT(i))
+			continue;
+
 		irq = platform_get_irq_byname(pdev, irq_names[i]);
 		if (irq <= 0) {
 			ret = (irq == 0) ? -EINVAL : irq;
@@ -538,8 +551,11 @@ static int pruss_intc_probe(struct platform_device *pdev)
 	return 0;
 
 fail_irq:
-	while (--i >= 0)
-		irq_set_chained_handler_and_data(intc->irqs[i], NULL, NULL);
+	while (--i >= 0) {
+		if (intc->irqs[i])
+			irq_set_chained_handler_and_data(intc->irqs[i], NULL,
+							 NULL);
+	}
 
 	irq_domain_remove(intc->domain);
 
@@ -553,8 +569,11 @@ static int pruss_intc_remove(struct platform_device *pdev)
 	unsigned int hwirq;
 	int i;
 
-	for (i = 0; i < MAX_NUM_HOST_IRQS; i++)
-		irq_set_chained_handler_and_data(intc->irqs[i], NULL, NULL);
+	for (i = 0; i < MAX_NUM_HOST_IRQS; i++) {
+		if (intc->irqs[i])
+			irq_set_chained_handler_and_data(intc->irqs[i], NULL,
+							 NULL);
+	}
 
 	for (hwirq = 0; hwirq < max_system_events; hwirq++)
 		irq_dispose_mapping(irq_find_mapping(intc->domain, hwirq));
