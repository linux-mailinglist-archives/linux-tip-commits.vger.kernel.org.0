Return-Path: <linux-tip-commits+bounces-4982-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE75A889FB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 19:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615EC3A62D4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 17:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940AA28A1D8;
	Mon, 14 Apr 2025 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1qj5CFZX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8lsxOzP8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5F02DFA4D;
	Mon, 14 Apr 2025 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652385; cv=none; b=degCP/qFTI9PwRroEEHoR7eznDbgrjOHGvC5We0nuKh8WkYC/GwlbBVn6Y4iqRVNYVSAPjIguzRZmAABh/3R6bBOYFVL7gAN3yCVlKadCp0eUl6SC/H4vF6lWkj2a7xNNEVj1CiiD0dTXmSYzgD4GpfUmw42qcbb1MCXB/jPuc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652385; c=relaxed/simple;
	bh=Hpxn0usGLgxCJAHFk8fbYXyhshWq7naXJoGjb8HN2Gs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y996dOWJZySnGuoyvAWONzjzMga+jC16y6+/jnOgXa655Ud+jWHr+R5mtE4x1vyZCq5h3SHpciUR7Wh0daIfxibQHnqhbb1NQDmdnvRGcKvReKAQxOkCv6m6t3BL7CNBZyBzrSBNQNSvJKfcFfENjUXf4Yb+ZoUSLI2/tcWAmls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1qj5CFZX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8lsxOzP8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 17:39:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744652381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZmBBAQpm8CYO8AUUEzvKLXPM0mdfUVNXTo2K93zdM8=;
	b=1qj5CFZX1BmBbZyl9+UduKEu8mUgSTs9N5kJTxQiMU+Q2PexTdCQDNbdw18BA+sHJFs1Th
	KtV+5BxzHkM/JZTZ2CzApIANAbgBO7FujMyzG9SuQ017H1zz6qzs2cmheB/qlnGtdoXza9
	ElCIclBzP0zSV89MYp15GuTRn25l7sqvvzGv1y3goGjHrTPXnADJj8g5B+spFqDPHVww3R
	ciG+w4jz7/vkK/4vduNg0jDoeluexZgzcVbkaLhjIeSZIfcJj8D2oisBK2IiUAjwOEHyld
	GqBOrXhrdHwRB+V8qsRA/E9JccSjCSW7jnsZs3jjCYf0cSicc7VbuxFi7hIzHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744652381;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZmBBAQpm8CYO8AUUEzvKLXPM0mdfUVNXTo2K93zdM8=;
	b=8lsxOzP8uCn6+1yvrsbhvQwQSWkUPrp6rTcpfICDOSVyoRUE3ZiR8scVaf3dpQaiXzo/hq
	6aQ+uOqkblaAhrAw==
From: "tip-bot2 for Inochi Amaoto" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/sg2042-msi: Introduce configurable
 chipinfo for SG2042
Cc: Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Chen Wang <wangchen20@iscas.ac.cn>, Chen Wang <unicorn_wang@outlook.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250413224922.69719-4-inochiama@gmail.com>
References: <20250413224922.69719-4-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174465238082.31282.11477353949213209476.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     bad2094e3b1c37c683f183a2a885ea0232ba31e9
Gitweb:        https://git.kernel.org/tip/bad2094e3b1c37c683f183a2a885ea0232ba31e9
Author:        Inochi Amaoto <inochiama@gmail.com>
AuthorDate:    Mon, 14 Apr 2025 06:49:14 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 14 Apr 2025 19:35:36 +02:00

irqchip/sg2042-msi: Introduce configurable chipinfo for SG2042

As the controller on SG2044 uses different msi_parent_ops and a difffernt
irq_chip, it is necessary to provide that information to the probe function.

Add a new chipinfo structure to hold that information, implement the
necessary logic and make SG2042 use it.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Chen Wang <wangchen20@iscas.ac.cn> # SG2042
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Link: https://lore.kernel.org/all/20250413224922.69719-4-inochiama@gmail.com

---
 drivers/irqchip/irq-sg2042-msi.c | 53 ++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
index 5f7fae4..325a83c 100644
--- a/drivers/irqchip/irq-sg2042-msi.c
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -19,18 +19,33 @@
 
 #include "irq-msi-lib.h"
 
-#define SG2042_MAX_MSI_VECTOR	32
+struct sg204x_msi_chip_info {
+	const struct irq_chip		*irqchip;
+	const struct msi_parent_ops	*parent_ops;
+};
 
+/**
+ * struct sg204x_msi_chipdata - chip data for the SG204x MSI IRQ controller
+ * @reg_clr:		clear reg, see TRM, 10.1.33, GP_INTR0_CLR
+ * @doorbell_addr:	see TRM, 10.1.32, GP_INTR0_SET
+ * @irq_first:		First vectors number that MSIs starts
+ * @num_irqs:		Number of vectors for MSIs
+ * @msi_map:		mapping for allocated MSI vectors.
+ * @msi_map_lock:	Lock for msi_map
+ * @chip_info:		chip specific infomations
+ */
 struct sg204x_msi_chipdata {
-	void __iomem	*reg_clr;	// clear reg, see TRM, 10.1.33, GP_INTR0_CLR
+	void __iomem				*reg_clr;
+
+	phys_addr_t				doorbell_addr;
 
-	phys_addr_t	doorbell_addr;	// see TRM, 10.1.32, GP_INTR0_SET
+	u32					irq_first;
+	u32					num_irqs;
 
-	u32		irq_first;	// The vector number that MSIs starts
-	u32		num_irqs;	// The number of vectors for MSIs
+	unsigned long				*msi_map;
+	struct mutex				msi_map_lock;
 
-	DECLARE_BITMAP(msi_map, SG2042_MAX_MSI_VECTOR);
-	struct mutex	msi_map_lock;	// lock for msi_map
+	const struct sg204x_msi_chip_info	*chip_info;
 };
 
 static int sg204x_msi_allocate_hwirq(struct sg204x_msi_chipdata *data, int num_req)
@@ -115,7 +130,7 @@ static int sg204x_msi_middle_domain_alloc(struct irq_domain *domain, unsigned in
 			goto err_hwirq;
 
 		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
-					      &sg2042_msi_middle_irq_chip, data);
+					      data->chip_info->irqchip, data);
 	}
 
 	return 0;
@@ -173,8 +188,7 @@ static int sg204x_msi_init_domains(struct sg204x_msi_chipdata *data,
 	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
 
 	middle_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	middle_domain->msi_parent_ops = &sg2042_msi_parent_ops;
-
+	middle_domain->msi_parent_ops = data->chip_info->parent_ops;
 	return 0;
 }
 
@@ -191,6 +205,12 @@ static int sg2042_msi_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	data->chip_info = device_get_match_data(&pdev->dev);
+	if (!data->chip_info) {
+		dev_err(&pdev->dev, "Failed to get irqchip\n");
+		return -EINVAL;
+	}
+
 	data->reg_clr = devm_platform_ioremap_resource_byname(pdev, "clr");
 	if (IS_ERR(data->reg_clr)) {
 		dev_err(dev, "Failed to map clear register\n");
@@ -231,11 +251,22 @@ static int sg2042_msi_probe(struct platform_device *pdev)
 
 	mutex_init(&data->msi_map_lock);
 
+	data->msi_map = devm_bitmap_zalloc(&pdev->dev, data->num_irqs, GFP_KERNEL);
+	if (!data->msi_map) {
+		dev_err(&pdev->dev, "Unable to allocate msi mapping\n");
+		return -ENOMEM;
+	}
+
 	return sg204x_msi_init_domains(data, plic_domain, dev);
 }
 
+static const struct sg204x_msi_chip_info sg2042_chip_info = {
+	.irqchip	= &sg2042_msi_middle_irq_chip,
+	.parent_ops	= &sg2042_msi_parent_ops,
+};
+
 static const struct of_device_id sg2042_msi_of_match[] = {
-	{ .compatible	= "sophgo,sg2042-msi" },
+	{ .compatible	= "sophgo,sg2042-msi", .data	= &sg2042_chip_info },
 	{ }
 };
 

