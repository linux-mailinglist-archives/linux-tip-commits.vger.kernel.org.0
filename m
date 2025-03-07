Return-Path: <linux-tip-commits+bounces-4041-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E69A56227
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 09:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA1E18969EC
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 08:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B4F1A83F5;
	Fri,  7 Mar 2025 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aS/l8of6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9EeTCHHS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCEB157A48;
	Fri,  7 Mar 2025 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741334557; cv=none; b=s3rFK1y1fN/VWRUz+TTGq4lQrQF5VyngcSXUUrqANyLuzJF6yE8hMLJegoU/KzmA4BSHPRyvR0x4+Oi3m16V03VJsPUPLyahOiCrRv80/lwcY3lEajK8AvZpO3GHVX27yxokD8auDrgjOCQHlur4+RueAiE7QTKWU825enfZUF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741334557; c=relaxed/simple;
	bh=WSBnNsN62tVBmykCsASSx55WWbKVE14cT7N79EfL/Go=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Sg+XuSGyc9pUqQ5bypiLNYb8NXXNqe+moVGFyKAyk8Oq1+j09dR9dRiyH1A0K86S9Np2e+uZ2Fpkd/CA3g2SBpKg4yK6De00QHO/B+Ts/ZRoe64NOwtO1dqitcv2w4folZjZiaFtn/ZJ8IKB1n6tHISQhcM6/WmlbSAA/plvWj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aS/l8of6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9EeTCHHS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 07 Mar 2025 08:02:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741334554;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pMY46EuTIkzzojfwD7frFWYrlhvpbsKJkxR2OyT3sI=;
	b=aS/l8of6xZzW6xeHPYa7g2kPG1X/SX045b02rJuGc4+ZlYn8z6QQiq0t1dywVYd/SdPzjS
	pgt5lM0TDZ8VEXibiEqy8qAHiL8CFrg/Moy+JuiwWaXec21GJBuBRzYsuHbtgii3UCk1Je
	FI8WwDqqEv/X+D6G8dl3OIMONI6qB7z4p6sGC1bHVRC9jiN2R8c7PdUhP865dizxca5OQP
	AfhdA21h1rd5dLYqyv+z2pXo0V4hql4W3YV14ynx/dBHhj9T1M5NYyavYfjyikaeoFDgqP
	u1JZU5USIbWUBkZzn8DwJK4ZxvqEd9w5xAbOrQT6AaM73f45lwVo0x5Q4xMUNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741334554;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4pMY46EuTIkzzojfwD7frFWYrlhvpbsKJkxR2OyT3sI=;
	b=9EeTCHHSOzVBqs5pPvzezUBajXT2YIgY1r83reHX0TzjsPvE3+1H4AAcH9WeuHn77lPfwD
	rbyQjGEA4YlqpsAA==
From: "tip-bot2 for Andre Przywara" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] irqchip/sunxi-nmi: Support Allwinner A523 NMI controller
Cc: Andre Przywara <andre.przywara@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250307005712.16828-7-andre.przywara@arm.com>
References: <20250307005712.16828-7-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174133454592.14745.4937015305906176856.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     922ac17c7b47fd0345690046a396f7e324dc733e
Gitweb:        https://git.kernel.org/tip/922ac17c7b47fd0345690046a396f7e324dc733e
Author:        Andre Przywara <andre.przywara@arm.com>
AuthorDate:    Fri, 07 Mar 2025 00:57:03 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 07 Mar 2025 08:39:03 +01:00

irqchip/sunxi-nmi: Support Allwinner A523 NMI controller

The NMI controller in the Allwinner A523 is almost compatible to the
previous versions of this IP, but requires the extra bit 31 to be set in
the enable register to actually report the NMI.

Add a mask to allow such an enable bit to be specified, and add this to
the per-SoC data structure. As this struct was just for different register
offsets so far, it was consequently named "reg_offs", which is now no
longer applicable, so rename this to the more generic "data" on the way,
and move the existing offsets into a struct of its own.

Also add the respective Allwinner A523 compatible string, and set bit 31
in its enable mask, to add support for this SoC.

[ tglx: Mop up some coding style along with it ]

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250307005712.16828-7-andre.przywara@arm.com

---
 drivers/irqchip/irq-sunxi-nmi.c | 85 ++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 35 deletions(-)

diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index 0b43121..01b0d83 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -48,32 +48,41 @@ enum {
 	SUNXI_SRC_TYPE_EDGE_RISING,
 };
 
-struct sunxi_sc_nmi_reg_offs {
-	u32 ctrl;
-	u32 pend;
-	u32 enable;
+struct sunxi_sc_nmi_data {
+	struct {
+		u32	ctrl;
+		u32	pend;
+		u32	enable;
+	} reg_offs;
+	u32		enable_val;
 };
 
-static const struct sunxi_sc_nmi_reg_offs sun6i_reg_offs __initconst = {
-	.ctrl	= SUN6I_NMI_CTRL,
-	.pend	= SUN6I_NMI_PENDING,
-	.enable	= SUN6I_NMI_ENABLE,
+static const struct sunxi_sc_nmi_data sun6i_data __initconst = {
+	.reg_offs.ctrl		= SUN6I_NMI_CTRL,
+	.reg_offs.pend		= SUN6I_NMI_PENDING,
+	.reg_offs.enable	= SUN6I_NMI_ENABLE,
 };
 
-static const struct sunxi_sc_nmi_reg_offs sun7i_reg_offs __initconst = {
-	.ctrl	= SUN7I_NMI_CTRL,
-	.pend	= SUN7I_NMI_PENDING,
-	.enable	= SUN7I_NMI_ENABLE,
+static const struct sunxi_sc_nmi_data sun7i_data __initconst = {
+	.reg_offs.ctrl		= SUN7I_NMI_CTRL,
+	.reg_offs.pend		= SUN7I_NMI_PENDING,
+	.reg_offs.enable	= SUN7I_NMI_ENABLE,
 };
 
-static const struct sunxi_sc_nmi_reg_offs sun9i_reg_offs __initconst = {
-	.ctrl	= SUN9I_NMI_CTRL,
-	.pend	= SUN9I_NMI_PENDING,
-	.enable	= SUN9I_NMI_ENABLE,
+static const struct sunxi_sc_nmi_data sun9i_data __initconst = {
+	.reg_offs.ctrl		= SUN9I_NMI_CTRL,
+	.reg_offs.pend		= SUN9I_NMI_PENDING,
+	.reg_offs.enable	= SUN9I_NMI_ENABLE,
 };
 
-static inline void sunxi_sc_nmi_write(struct irq_chip_generic *gc, u32 off,
-				      u32 val)
+static const struct sunxi_sc_nmi_data sun55i_a523_data __initconst = {
+	.reg_offs.ctrl		= SUN9I_NMI_CTRL,
+	.reg_offs.pend		= SUN9I_NMI_PENDING,
+	.reg_offs.enable	= SUN9I_NMI_ENABLE,
+	.enable_val		= BIT(31),
+};
+
+static inline void sunxi_sc_nmi_write(struct irq_chip_generic *gc, u32 off, u32 val)
 {
 	irq_reg_writel(gc, val, off);
 }
@@ -143,15 +152,13 @@ static int sunxi_sc_nmi_set_type(struct irq_data *data, unsigned int flow_type)
 }
 
 static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
-					const struct sunxi_sc_nmi_reg_offs *reg_offs)
+					const struct sunxi_sc_nmi_data *data)
 {
-	struct irq_domain *domain;
+	unsigned int irq, clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	struct irq_chip_generic *gc;
-	unsigned int irq;
-	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
+	struct irq_domain *domain;
 	int ret;
 
-
 	domain = irq_domain_add_linear(node, 1, &irq_generic_chip_ops, NULL);
 	if (!domain) {
 		pr_err("Could not register interrupt domain.\n");
@@ -186,27 +193,28 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
 	gc->chip_types[0].chip.irq_unmask	= irq_gc_mask_set_bit;
 	gc->chip_types[0].chip.irq_eoi		= irq_gc_ack_set_bit;
 	gc->chip_types[0].chip.irq_set_type	= sunxi_sc_nmi_set_type;
-	gc->chip_types[0].chip.flags		= IRQCHIP_EOI_THREADED | IRQCHIP_EOI_IF_HANDLED |
+	gc->chip_types[0].chip.flags		= IRQCHIP_EOI_THREADED |
+						  IRQCHIP_EOI_IF_HANDLED |
 						  IRQCHIP_SKIP_SET_WAKE;
-	gc->chip_types[0].regs.ack		= reg_offs->pend;
-	gc->chip_types[0].regs.mask		= reg_offs->enable;
-	gc->chip_types[0].regs.type		= reg_offs->ctrl;
+	gc->chip_types[0].regs.ack		= data->reg_offs.pend;
+	gc->chip_types[0].regs.mask		= data->reg_offs.enable;
+	gc->chip_types[0].regs.type		= data->reg_offs.ctrl;
 
 	gc->chip_types[1].type			= IRQ_TYPE_EDGE_BOTH;
 	gc->chip_types[1].chip.irq_ack		= irq_gc_ack_set_bit;
 	gc->chip_types[1].chip.irq_mask		= irq_gc_mask_clr_bit;
 	gc->chip_types[1].chip.irq_unmask	= irq_gc_mask_set_bit;
 	gc->chip_types[1].chip.irq_set_type	= sunxi_sc_nmi_set_type;
-	gc->chip_types[1].regs.ack		= reg_offs->pend;
-	gc->chip_types[1].regs.mask		= reg_offs->enable;
-	gc->chip_types[1].regs.type		= reg_offs->ctrl;
+	gc->chip_types[1].regs.ack		= data->reg_offs.pend;
+	gc->chip_types[1].regs.mask		= data->reg_offs.enable;
+	gc->chip_types[1].regs.type		= data->reg_offs.ctrl;
 	gc->chip_types[1].handler		= handle_edge_irq;
 
 	/* Disable any active interrupts */
-	sunxi_sc_nmi_write(gc, reg_offs->enable, 0);
+	sunxi_sc_nmi_write(gc, data->reg_offs.enable, data->enable_val);
 
 	/* Clear any pending NMI interrupts */
-	sunxi_sc_nmi_write(gc, reg_offs->pend, SUNXI_NMI_IRQ_BIT);
+	sunxi_sc_nmi_write(gc, data->reg_offs.pend, SUNXI_NMI_IRQ_BIT);
 
 	irq_set_chained_handler_and_data(irq, sunxi_sc_nmi_handle_irq, domain);
 
@@ -221,20 +229,27 @@ fail_irqd_remove:
 static int __init sun6i_sc_nmi_irq_init(struct device_node *node,
 					struct device_node *parent)
 {
-	return sunxi_sc_nmi_irq_init(node, &sun6i_reg_offs);
+	return sunxi_sc_nmi_irq_init(node, &sun6i_data);
 }
 IRQCHIP_DECLARE(sun6i_sc_nmi, "allwinner,sun6i-a31-sc-nmi", sun6i_sc_nmi_irq_init);
 
 static int __init sun7i_sc_nmi_irq_init(struct device_node *node,
 					struct device_node *parent)
 {
-	return sunxi_sc_nmi_irq_init(node, &sun7i_reg_offs);
+	return sunxi_sc_nmi_irq_init(node, &sun7i_data);
 }
 IRQCHIP_DECLARE(sun7i_sc_nmi, "allwinner,sun7i-a20-sc-nmi", sun7i_sc_nmi_irq_init);
 
 static int __init sun9i_nmi_irq_init(struct device_node *node,
 				     struct device_node *parent)
 {
-	return sunxi_sc_nmi_irq_init(node, &sun9i_reg_offs);
+	return sunxi_sc_nmi_irq_init(node, &sun9i_data);
 }
 IRQCHIP_DECLARE(sun9i_nmi, "allwinner,sun9i-a80-nmi", sun9i_nmi_irq_init);
+
+static int __init sun55i_nmi_irq_init(struct device_node *node,
+				      struct device_node *parent)
+{
+	return sunxi_sc_nmi_irq_init(node, &sun55i_a523_data);
+}
+IRQCHIP_DECLARE(sun55i_nmi, "allwinner,sun55i-a523-nmi", sun55i_nmi_irq_init);

