Return-Path: <linux-tip-commits+bounces-4981-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A1DA889FD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 19:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FDD3A6B73
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 17:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF8228937E;
	Mon, 14 Apr 2025 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FjnyyLm6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ileuK6q7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6AB288C90;
	Mon, 14 Apr 2025 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652385; cv=none; b=QZ65wlOFg6ixHnpGBcQsXt3v1HMIPEpVNLt4zBu8V6X3iPU/dB7VkAsvbQhR622W/7h81CNZ0VRTMBUdSM5OFYGNhHv3JTwKJEbM1leqpnZTUCeStxoV1NbrJTCbsnjo2pHXWwMzZ7z+mEH3cW/VHv7jVg30zq7kt1dAx/xCbW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652385; c=relaxed/simple;
	bh=1miE+Xirhhc9aJgSybbhbDvqReImIOATEScmEnFfVEw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eFSVgpT22cCsP6LKNDSRCu2Slb1nMA+wnwAhhxC0gQkx6zGNmpcbD08DuGPhjcbSSVRnPTfJEPbtS57Kv+oJ+ZvLwygDpGXg5WWhwXP/ZkVWgbZkIX4zQhf2KqGSi0cYr+mqzVCttWDAfQ7O0d2ecItGiLnev99gYzwA52SKCao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FjnyyLm6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ileuK6q7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 17:39:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744652381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9op2omhG4s+6Tzy0u9IbDVJd7A+UCx91whMljnykb80=;
	b=FjnyyLm6gSS1xJS/BhkRzeRff2o0uhqwI91L4YWgcofAco1VPvwRKudFq8aCe4yo5RpM6P
	5330xIuIiv+QlmQQhqm8Rt4KLF9Vq8xDrtGCzlVFSfAyNeMqjD8ZAvgBUgNTX+FCHUtCuF
	WT2BzK3/GQM1PlX8Ne6WWhx9mwA9zvUcgmYfLBa1fd8xsWz5p/FESSgCIkJAGyt2yZTWYE
	A5Mj8+tapaPHwMOqvayElgOHrdnFJ+E4Cpwgkn/LQIcDY83jog7pzkFqlDCdH6lS45Hamq
	NO28PifgXCY0MhLgeOEoqhtdnFFPEaory0kcEpv5QmyU8d/bC5P4SEmKpoEA/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744652381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9op2omhG4s+6Tzy0u9IbDVJd7A+UCx91whMljnykb80=;
	b=ileuK6q7zfm7mv8RJMjipaQbIJfV+DmTpmM6umziXJQATcoalbPSuYuic0CQ3YxwpROjtr
	DpFfAXk5zCAZwTDw==
From: "tip-bot2 for Inochi Amaoto" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/sg2042-msi: Add the Sophgo SG2044 MSI
 interrupt controller
Cc: Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Chen Wang <wangchen20@iscas.ac.cn>, Chen Wang <unicorn_wang@outlook.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250413224922.69719-5-inochiama@gmail.com>
References: <20250413224922.69719-5-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174465237682.31282.4222322323672893287.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     e96b93a97c90181627cef6e70a0dbc8dbdae4adc
Gitweb:        https://git.kernel.org/tip/e96b93a97c90181627cef6e70a0dbc8dbdae4adc
Author:        Inochi Amaoto <inochiama@gmail.com>
AuthorDate:    Mon, 14 Apr 2025 06:49:15 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 14 Apr 2025 19:35:36 +02:00

irqchip/sg2042-msi: Add the Sophgo SG2044 MSI interrupt controller

Add support for Sophgo SG2044 MSI interrupt controller.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Chen Wang <wangchen20@iscas.ac.cn> # SG2042
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Link: https://lore.kernel.org/all/20250413224922.69719-5-inochiama@gmail.com

---
 drivers/irqchip/irq-sg2042-msi.c | 53 +++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
index 325a83c..8a83c69 100644
--- a/drivers/irqchip/irq-sg2042-msi.c
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -94,6 +94,35 @@ static const struct irq_chip sg2042_msi_middle_irq_chip = {
 	.irq_compose_msi_msg	= sg2042_msi_irq_compose_msi_msg,
 };
 
+static void sg2044_msi_irq_ack(struct irq_data *d)
+{
+	struct sg204x_msi_chipdata *data = irq_data_get_irq_chip_data(d);
+
+	writel(0, (u32 *)data->reg_clr + d->hwirq);
+	irq_chip_ack_parent(d);
+}
+
+static void sg2044_msi_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	struct sg204x_msi_chipdata *data = irq_data_get_irq_chip_data(d);
+	phys_addr_t doorbell = data->doorbell_addr + 4 * (d->hwirq / 32);
+
+	msg->address_lo = lower_32_bits(doorbell);
+	msg->address_hi = upper_32_bits(doorbell);
+	msg->data = d->hwirq % 32;
+}
+
+static struct irq_chip sg2044_msi_middle_irq_chip = {
+	.name			= "SG2044 MSI",
+	.irq_ack		= sg2044_msi_irq_ack,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+#endif
+	.irq_compose_msi_msg	= sg2044_msi_irq_compose_msi_msg,
+};
+
 static int sg204x_msi_parent_domain_alloc(struct irq_domain *domain, unsigned int virq, int hwirq)
 {
 	struct sg204x_msi_chipdata *data = domain->host_data;
@@ -132,13 +161,11 @@ static int sg204x_msi_middle_domain_alloc(struct irq_domain *domain, unsigned in
 		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
 					      data->chip_info->irqchip, data);
 	}
-
 	return 0;
 
 err_hwirq:
 	sg204x_msi_free_hwirq(data, hwirq, nr_irqs);
 	irq_domain_free_irqs_parent(domain, virq, i);
-
 	return err;
 }
 
@@ -172,6 +199,22 @@ static const struct msi_parent_ops sg2042_msi_parent_ops = {
 	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
 };
 
+#define SG2044_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				   MSI_FLAG_USE_DEF_CHIP_OPS)
+
+#define SG2044_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				    MSI_FLAG_PCI_MSIX)
+
+static const struct msi_parent_ops sg2044_msi_parent_ops = {
+	.required_flags		= SG2044_MSI_FLAGS_REQUIRED,
+	.supported_flags	= SG2044_MSI_FLAGS_SUPPORTED,
+	.chip_flags		= MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
+	.bus_select_mask	= MATCH_PCI_MSI,
+	.bus_select_token	= DOMAIN_BUS_NEXUS,
+	.prefix			= "SG2044-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+};
+
 static int sg204x_msi_init_domains(struct sg204x_msi_chipdata *data,
 				   struct irq_domain *plic_domain, struct device *dev)
 {
@@ -265,8 +308,14 @@ static const struct sg204x_msi_chip_info sg2042_chip_info = {
 	.parent_ops	= &sg2042_msi_parent_ops,
 };
 
+static const struct sg204x_msi_chip_info sg2044_chip_info = {
+	.irqchip	= &sg2044_msi_middle_irq_chip,
+	.parent_ops	= &sg2044_msi_parent_ops,
+};
+
 static const struct of_device_id sg2042_msi_of_match[] = {
 	{ .compatible	= "sophgo,sg2042-msi", .data	= &sg2042_chip_info },
+	{ .compatible	= "sophgo,sg2044-msi", .data	= &sg2044_chip_info },
 	{ }
 };
 

