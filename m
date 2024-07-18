Return-Path: <linux-tip-commits+bounces-1718-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2F29351B7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 20:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37DFEB230DA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 18:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A434C146592;
	Thu, 18 Jul 2024 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LCcxkmAf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L7L6IjgN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F57C145A17;
	Thu, 18 Jul 2024 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327945; cv=none; b=VUSd0YaEAKs60PLHql+WgmvlwWSowBr7nV7ft87PRfTHieSmSNVp4niPuOErlMlqrETMF8rmaJhSOy+vF6pVGDEu7Mbb3f9D6Y2F1mWDTPVBgSV5OBMYt55J+cjCBOljuxUMU8012qjMPnq0Iu+vdak1PLI9bdwQ/MjPlB0x770=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327945; c=relaxed/simple;
	bh=qUY8Kp7yQ1OAuurEOlSKJAm1AV5tIwTWlONtowf1Qww=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kpCfhxL60b3e+j17648JT6en+HkPWVVyQZG+jB+p5wgmrnfAHyvsIuK9R28zAsrvEwwrt28r4gmg+OIeP8V2nSveRMZHkdK3HXXdPBSfoV4/Lvg2KFxWmLl4FRUt9coimO1DtAW1Te6b0err3hk8KdtbwVfwtPvJUXCPRR9kAQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LCcxkmAf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L7L6IjgN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jul 2024 18:38:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721327938;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VBl3/wOKnLrMW7adYkg+EeD5zf27Enf5mwEn5nzlYhA=;
	b=LCcxkmAf1ON1hbMIJitlqp0qDBUyBNnO5Zr2XZFqibcp2JBzLZFbLUHBqEUoZVu4VjEfXT
	j8jjxthzN1OYR5SW7q/fQmmBmzOIc2Uc4Cjf/dPo7bu385zFLRKWodAdibZdHD7RjLEfDs
	COnRVuxWI+neKANQlupsMLbaYMkQgSnSYRsMBs4coCv4VtbRJkq36mbkrvrvfQNmDfi5WO
	6dZfNELd2V95KS9xX+iZfmXbv09wUQvlKNdNaAW4rZ+ICVgvzhVJJrZD96QmDYwyMFBVMh
	3Rml/aqrQEsz4MdpBB5TfWo0K5lJpNDLA918dP5tBLNWVbwcF4Q1SJ8IGe8uUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721327938;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VBl3/wOKnLrMW7adYkg+EeD5zf27Enf5mwEn5nzlYhA=;
	b=L7L6IjgN092pZWIAANwG5cCE9cVgFceM/XT3Wu9jSiolUlWGobV96e+2jVHwBYF9v4Z7wp
	UxXBb+h8h6mvGoCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/irq-mvebu-sei: Switch to MSI parent
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240623142235.820275215@linutronix.de>
References: <20240623142235.820275215@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172132793850.2215.17454496672350723461.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     fbdf14e90ce445fedfb387413c3d8dc9d90db2a7
Gitweb:        https://git.kernel.org/tip/fbdf14e90ce445fedfb387413c3d8dc9d90db2a7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:19:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jul 2024 20:31:21 +02:00

irqchip/irq-mvebu-sei: Switch to MSI parent

All platform MSI users and the PCI/MSI code handle per device MSI domains
when the irqdomain associated to the device provides MSI parent
functionality.

Remove the "global" platform domain related code and provide the MSI parent
functionality by filling in msi_parent_ops.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240623142235.820275215@linutronix.de



---
 drivers/irqchip/irq-mvebu-sei.c | 52 ++++++++++++--------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index a48dbe9..f8c70f2 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -14,6 +14,8 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 
+#include "irq-msi-lib.h"
+
 /* Cause register */
 #define GICP_SECR(idx)		(0x0  + ((idx) * 0x4))
 /* Mask register */
@@ -190,6 +192,7 @@ static void mvebu_sei_domain_free(struct irq_domain *domain, unsigned int virq,
 }
 
 static const struct irq_domain_ops mvebu_sei_domain_ops = {
+	.select	= msi_lib_irq_domain_select,
 	.alloc	= mvebu_sei_domain_alloc,
 	.free	= mvebu_sei_domain_free,
 };
@@ -307,21 +310,6 @@ static const struct irq_domain_ops mvebu_sei_cp_domain_ops = {
 	.free	= mvebu_sei_cp_domain_free,
 };
 
-static struct irq_chip mvebu_sei_msi_irq_chip = {
-	.name		= "SEI pMSI",
-	.irq_ack	= irq_chip_ack_parent,
-	.irq_set_type	= irq_chip_set_type_parent,
-};
-
-static struct msi_domain_ops mvebu_sei_msi_ops = {
-};
-
-static struct msi_domain_info mvebu_sei_msi_domain_info = {
-	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS,
-	.ops	= &mvebu_sei_msi_ops,
-	.chip	= &mvebu_sei_msi_irq_chip,
-};
-
 static void mvebu_sei_handle_cascade_irq(struct irq_desc *desc)
 {
 	struct mvebu_sei *sei = irq_desc_get_handler_data(desc);
@@ -360,10 +348,23 @@ static void mvebu_sei_reset(struct mvebu_sei *sei)
 	}
 }
 
+#define SEI_MSI_FLAGS_REQUIRED	(MSI_FLAG_USE_DEF_DOM_OPS |	\
+				 MSI_FLAG_USE_DEF_CHIP_OPS)
+
+#define SEI_MSI_FLAGS_SUPPORTED	(MSI_GENERIC_FLAGS_MASK)
+
+static const struct msi_parent_ops sei_msi_parent_ops = {
+	.supported_flags	= SEI_MSI_FLAGS_SUPPORTED,
+	.required_flags		= SEI_MSI_FLAGS_REQUIRED,
+	.bus_select_mask	= MATCH_PLATFORM_MSI,
+	.bus_select_token	= DOMAIN_BUS_GENERIC_MSI,
+	.prefix			= "SEI-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+};
+
 static int mvebu_sei_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct irq_domain *plat_domain;
 	struct mvebu_sei *sei;
 	u32 parent_irq;
 	int ret;
@@ -440,33 +441,20 @@ static int mvebu_sei_probe(struct platform_device *pdev)
 	}
 
 	irq_domain_update_bus_token(sei->cp_domain, DOMAIN_BUS_GENERIC_MSI);
-
-	plat_domain = platform_msi_create_irq_domain(of_node_to_fwnode(node),
-						     &mvebu_sei_msi_domain_info,
-						     sei->cp_domain);
-	if (!plat_domain) {
-		pr_err("Failed to create CPs MSI domain\n");
-		ret = -ENOMEM;
-		goto remove_cp_domain;
-	}
+	sei->cp_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	sei->cp_domain->msi_parent_ops = &sei_msi_parent_ops;
 
 	mvebu_sei_reset(sei);
 
-	irq_set_chained_handler_and_data(parent_irq,
-					 mvebu_sei_handle_cascade_irq,
-					 sei);
-
+	irq_set_chained_handler_and_data(parent_irq, mvebu_sei_handle_cascade_irq, sei);
 	return 0;
 
-remove_cp_domain:
-	irq_domain_remove(sei->cp_domain);
 remove_ap_domain:
 	irq_domain_remove(sei->ap_domain);
 remove_sei_domain:
 	irq_domain_remove(sei->sei_domain);
 dispose_irq:
 	irq_dispose_mapping(parent_irq);
-
 	return ret;
 }
 

