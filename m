Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E8B2A1FC7
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Nov 2020 18:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgKARAL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 1 Nov 2020 12:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgKARAL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 1 Nov 2020 12:00:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4447C0617A6;
        Sun,  1 Nov 2020 09:00:10 -0800 (PST)
Date:   Sun, 01 Nov 2020 17:00:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604250008;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E8jfzPWdxTRyujAc/doJcKSRBBcG5+8RN8kATuzL5us=;
        b=aD4TpEgyrHIsep/Q2SHjH9xMmGCtrQ5QcQsMYiZT1okBVBbWAJ6Jp0ZceUc37q7Cl3+BM8
        5wxoYrpNxyZYqcSTqWqeBAeWa8ZCeXpNHBCDsrzZTyGz0MZh0fnR4BzmPLeHMBuS2vOdTA
        xsDU+ZsJ5cWfwzFnCAOx73AmXQ0cj9fU1jIA3fl//a7w2TH94HU850dmZ7MSMv6a9ri9Xu
        PD74ocD4QEVUmV6Fbo7BvQyz/7hPOyZd9V28rN6/WVNQiSOwHzJ/oEcStSVsCg+3d3Dwxf
        yQrdCL5aIEc0ACnPTSQZeKgxbm9r06+8dPNQ2n7R77/9n1hU76PoT/noR/wNTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604250008;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E8jfzPWdxTRyujAc/doJcKSRBBcG5+8RN8kATuzL5us=;
        b=u5DAO4pAOsLZUE4wc976ZMmTDIW5TCp6dBKEoNgrEKcyHWWuJC7jT1MR1oOA5evod0D93F
        VFqCb1RgvZz/+ECA==
From:   "tip-bot2 for Peter Ujfalusi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/ti-sci-inta: Add support for unmapped event
 handling
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201020073243.19255-3-peter.ujfalusi@ti.com>
References: <20201020073243.19255-3-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Message-ID: <160425000726.397.10310072721034610132.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     d95bdca75b3fb41bf185efe164e05aed820081a5
Gitweb:        https://git.kernel.org/tip/d95bdca75b3fb41bf185efe164e05aed820081a5
Author:        Peter Ujfalusi <peter.ujfalusi@ti.com>
AuthorDate:    Tue, 20 Oct 2020 10:32:43 +03:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 01 Nov 2020 12:00:50 

irqchip/ti-sci-inta: Add support for unmapped event handling

The DMA (BCDMA/PKTDMA and their rings/flows) events are under the INTA's
supervision as unmapped events in AM64.

In order to keep the current SW stack working, the INTA driver must replace
the dev_id with it's own when a request comes for BCDMA or PKTDMA
resources.

Implement parsing of the optional "ti,unmapped-event-sources" phandle array
to get the sci-dev-ids of the devices where the unmapped events originate.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201020073243.19255-3-peter.ujfalusi@ti.com
---
 drivers/irqchip/irq-ti-sci-inta.c | 83 ++++++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index e0cceb8..b2ab8db 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -85,6 +85,17 @@ struct ti_sci_inta_vint_desc {
  * @base:		Base address of the memory mapped IO registers
  * @pdev:		Pointer to platform device.
  * @ti_sci_id:		TI-SCI device identifier
+ * @unmapped_cnt:	Number of @unmapped_dev_ids entries
+ * @unmapped_dev_ids:	Pointer to an array of TI-SCI device identifiers of
+ *			unmapped event sources.
+ *			Unmapped Events are not part of the Global Event Map and
+ *			they are converted to Global event within INTA to be
+ *			received by the same INTA to generate an interrupt.
+ *			In case an interrupt request comes for a device which is
+ *			generating Unmapped Event, we must use the INTA's TI-SCI
+ *			device identifier in place of the source device
+ *			identifier to let sysfw know where it has to program the
+ *			Global Event number.
  */
 struct ti_sci_inta_irq_domain {
 	const struct ti_sci_handle *sci;
@@ -96,11 +107,37 @@ struct ti_sci_inta_irq_domain {
 	void __iomem *base;
 	struct platform_device *pdev;
 	u32 ti_sci_id;
+
+	int unmapped_cnt;
+	u16 *unmapped_dev_ids;
 };
 
 #define to_vint_desc(e, i) container_of(e, struct ti_sci_inta_vint_desc, \
 					events[i])
 
+static u16 ti_sci_inta_get_dev_id(struct ti_sci_inta_irq_domain *inta, u32 hwirq)
+{
+	u16 dev_id = HWIRQ_TO_DEVID(hwirq);
+	int i;
+
+	if (inta->unmapped_cnt == 0)
+		return dev_id;
+
+	/*
+	 * For devices sending Unmapped Events we must use the INTA's TI-SCI
+	 * device identifier number to be able to convert it to a Global Event
+	 * and map it to an interrupt.
+	 */
+	for (i = 0; i < inta->unmapped_cnt; i++) {
+		if (dev_id == inta->unmapped_dev_ids[i]) {
+			dev_id = inta->ti_sci_id;
+			break;
+		}
+	}
+
+	return dev_id;
+}
+
 /**
  * ti_sci_inta_irq_handler() - Chained IRQ handler for the vint irqs
  * @desc:	Pointer to irq_desc corresponding to the irq
@@ -251,7 +288,7 @@ static struct ti_sci_inta_event_desc *ti_sci_inta_alloc_event(struct ti_sci_inta
 	u16 dev_id, dev_index;
 	int err;
 
-	dev_id = HWIRQ_TO_DEVID(hwirq);
+	dev_id = ti_sci_inta_get_dev_id(inta, hwirq);
 	dev_index = HWIRQ_TO_IRQID(hwirq);
 
 	event_desc = &vint_desc->events[free_bit];
@@ -352,14 +389,15 @@ static void ti_sci_inta_free_irq(struct ti_sci_inta_event_desc *event_desc,
 {
 	struct ti_sci_inta_vint_desc *vint_desc;
 	struct ti_sci_inta_irq_domain *inta;
+	u16 dev_id;
 
 	vint_desc = to_vint_desc(event_desc, event_desc->vint_bit);
 	inta = vint_desc->domain->host_data;
+	dev_id = ti_sci_inta_get_dev_id(inta, hwirq);
 	/* free event irq */
 	mutex_lock(&inta->vint_mutex);
 	inta->sci->ops.rm_irq_ops.free_event_map(inta->sci,
-						 HWIRQ_TO_DEVID(hwirq),
-						 HWIRQ_TO_IRQID(hwirq),
+						 dev_id, HWIRQ_TO_IRQID(hwirq),
 						 inta->ti_sci_id,
 						 vint_desc->vint_id,
 						 event_desc->global_event,
@@ -574,6 +612,41 @@ static struct msi_domain_info ti_sci_inta_msi_domain_info = {
 	.chip	= &ti_sci_inta_msi_irq_chip,
 };
 
+static int ti_sci_inta_get_unmapped_sources(struct ti_sci_inta_irq_domain *inta)
+{
+	struct device *dev = &inta->pdev->dev;
+	struct device_node *node = dev_of_node(dev);
+	struct of_phandle_iterator it;
+	int count, err, ret, i;
+
+	count = of_count_phandle_with_args(node, "ti,unmapped-event-sources", NULL);
+	if (count <= 0)
+		return 0;
+
+	inta->unmapped_dev_ids = devm_kcalloc(dev, count,
+					      sizeof(*inta->unmapped_dev_ids),
+					      GFP_KERNEL);
+	if (!inta->unmapped_dev_ids)
+		return -ENOMEM;
+
+	i = 0;
+	of_for_each_phandle(&it, err, node, "ti,unmapped-event-sources", NULL, 0) {
+		u32 dev_id;
+
+		ret = of_property_read_u32(it.node, "ti,sci-dev-id", &dev_id);
+		if (ret) {
+			dev_err(dev, "ti,sci-dev-id read failure for %pOFf\n", it.node);
+			of_node_put(it.node);
+			return ret;
+		}
+		inta->unmapped_dev_ids[i++] = dev_id;
+	}
+
+	inta->unmapped_cnt = count;
+
+	return 0;
+}
+
 static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 {
 	struct irq_domain *parent_domain, *domain, *msi_domain;
@@ -629,6 +702,10 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 	if (IS_ERR(inta->base))
 		return PTR_ERR(inta->base);
 
+	ret = ti_sci_inta_get_unmapped_sources(inta);
+	if (ret)
+		return ret;
+
 	domain = irq_domain_add_linear(dev_of_node(dev),
 				       ti_sci_get_num_resources(inta->vint),
 				       &ti_sci_inta_irq_domain_ops, inta);
