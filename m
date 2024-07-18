Return-Path: <linux-tip-commits+bounces-1714-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B279351B2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 20:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B57D3283AA7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 18:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D48146000;
	Thu, 18 Jul 2024 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p6iXspcQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s5dLTTYP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB62145A15;
	Thu, 18 Jul 2024 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327944; cv=none; b=BKgq1DHl9eIfZru6fZKN2h0OVtVDs/2wZ2PEE0oAsYujTPfYTt8btlikbp0GqM3kGuVjiLJpV0UfF/De+EKwt6SNSZeQNsEYD2brCLo+2IN6F5iSGEMdSxrOR+9DgCWevXP9j2uypFqq2n6fgsuiSpBnlbdmQGYFpASi+SrmPHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327944; c=relaxed/simple;
	bh=kK25U/JINuFbDpN6K5PY1jQ7TCkp2m3i9hmd7B7cE6Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BMzWw7YCfR2jC0NeDsWi/YIvPdoYD7Uaf5qh5kGHub22EiR3ToB1Fjn5gHtwIc/Hzzl7Kg2Id8JpOEGQi4K+2e74XcSFHlk2c2ouzsE25w7laQmuraS2TMn+2uuhCeXkXnvKyFU5KjVMyhlqDm0JRql8jPuEPK6xVBnCgueE2Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p6iXspcQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s5dLTTYP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jul 2024 18:38:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721327939;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zy4Zl1iG9qyJHx7ZzlRbcZBqKyEPeUYEhTonBQBPLGk=;
	b=p6iXspcQQAvdelwfYNm1SummHvl+Y0lNXVqcH9HGjjSI0RGFW3N17McAghKYtqUQMPBreR
	0aaQUA9E0bURlMdiJ36J1vh6lAn87VIdXtOQp9l4PiqhTR5uvYFYCbJ7calpRmL8Jx+n8u
	Gzs5JU8DwVsxWv3WrxxPpUACNSBsCdUXwGvNj/ws6MV3Znxr7VQ+WxH9xmRBr9YNq71179
	dyqxT5o0k7mBnwOlqP4G9tnIOEDyWAA0EnGNPqi4fJdB0dqynLE2Rnlbt+YPCmowCbTlyb
	hEIdhWwLD7hRNpF33nVJeRWcK0JoH6QbUlt6ra7YfxrawyxjFP58tWeo7SySTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721327939;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zy4Zl1iG9qyJHx7ZzlRbcZBqKyEPeUYEhTonBQBPLGk=;
	b=s5dLTTYPCKjA36JX2kQkAJW9o9UFHv6S9U6p/9/v+5jFO2jclCO0Z+2ol7H9VqCWo9+X4X
	6NUPTX2cqd0tnpBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/mvebu-odmi: Switch to parent MSI
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240623142235.759892514@linutronix.de>
References: <20240623142235.759892514@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172132793874.2215.16101673141022532238.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     e0b99c4c5917759c257a5c41d2c3e4d7c014578b
Gitweb:        https://git.kernel.org/tip/e0b99c4c5917759c257a5c41d2c3e4d7c014578b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:19:00 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jul 2024 20:31:21 +02:00

irqchip/mvebu-odmi: Switch to parent MSI

All platform MSI users and the PCI/MSI code handle per device MSI domains
when the irqdomain associated to the device provides MSI parent
functionality.

Remove the "global" platform domain related code and provide the MSI parent
functionality by filling in msi_parent_ops.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240623142235.759892514@linutronix.de



---
 drivers/irqchip/Kconfig          |  1 +-
 drivers/irqchip/irq-mvebu-odmi.c | 37 +++++++++++++++----------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index a0fa599..4def6dc 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -379,6 +379,7 @@ config MVEBU_ICU
 
 config MVEBU_ODMI
 	bool
+	select IRQ_MSI_LIB
 	select GENERIC_MSI_IRQ
 
 config MVEBU_PIC
diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu-odmi.c
index 1080915..ff19bfd 100644
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -17,6 +17,9 @@
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
+
+#include "irq-msi-lib.h"
+
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #define GICP_ODMIN_SET			0x40
@@ -141,27 +144,29 @@ static void odmi_irq_domain_free(struct irq_domain *domain,
 }
 
 static const struct irq_domain_ops odmi_domain_ops = {
+	.select	= msi_lib_irq_domain_select,
 	.alloc	= odmi_irq_domain_alloc,
 	.free	= odmi_irq_domain_free,
 };
 
-static struct irq_chip odmi_msi_irq_chip = {
-	.name	= "ODMI",
-};
+#define ODMI_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				  MSI_FLAG_USE_DEF_CHIP_OPS)
 
-static struct msi_domain_ops odmi_msi_ops = {
-};
+#define ODMI_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK)
 
-static struct msi_domain_info odmi_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
-	.ops	= &odmi_msi_ops,
-	.chip	= &odmi_msi_irq_chip,
+static const struct msi_parent_ops odmi_msi_parent_ops = {
+	.supported_flags	= ODMI_MSI_FLAGS_SUPPORTED,
+	.required_flags		= ODMI_MSI_FLAGS_REQUIRED,
+	.bus_select_token	= DOMAIN_BUS_GENERIC_MSI,
+	.bus_select_mask	= MATCH_PLATFORM_MSI,
+	.prefix			= "ODMI-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
 };
 
 static int __init mvebu_odmi_init(struct device_node *node,
 				  struct device_node *parent)
 {
-	struct irq_domain *parent_domain, *inner_domain, *plat_domain;
+	struct irq_domain *parent_domain, *inner_domain;
 	int ret, i;
 
 	if (of_property_read_u32(node, "marvell,odmi-frames", &odmis_count))
@@ -208,18 +213,12 @@ static int __init mvebu_odmi_init(struct device_node *node,
 		goto err_unmap;
 	}
 
-	plat_domain = platform_msi_create_irq_domain(of_node_to_fwnode(node),
-						     &odmi_msi_domain_info,
-						     inner_domain);
-	if (!plat_domain) {
-		ret = -ENOMEM;
-		goto err_remove_inner;
-	}
+	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_GENERIC_MSI);
+	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	inner_domain->msi_parent_ops = &odmi_msi_parent_ops;
 
 	return 0;
 
-err_remove_inner:
-	irq_domain_remove(inner_domain);
 err_unmap:
 	for (i = 0; i < odmis_count; i++) {
 		struct odmi_data *odmi = &odmis[i];

