Return-Path: <linux-tip-commits+bounces-5991-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E17C4AF767B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 16:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66C3F7BA5C7
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 14:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA6C2EA750;
	Thu,  3 Jul 2025 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LdAM32Km";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5qUyNdYh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8172EA16B;
	Thu,  3 Jul 2025 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551238; cv=none; b=K5HkGcVcAuovxi7y6ICclVrpG771R6zfZz3/InhODDrA69IhyPS9ufhpCeNJ/F7d6lhkwd3CEyDlNpLgKTdnNfrvq/07+uhgHlf/COqSCiGBYqlJlMDTQQuUtIS0+Y73esOUW0SmSAZMl5DLmmYf7Y81dxHY9Z0m+kfbI+cVcsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551238; c=relaxed/simple;
	bh=gFGnlXjcj1Z497UyiyAetSf3e6I37neeeO9rCvuKfrM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XtACD2ofqv1WGMrHWGJ7lqmgAsKmQ3D5nBl8yREwQVGtUb9/lrABTbd29LkR6Llsyb72DL84ibJBvUMNeW9c0xEJnDgZZY5XWQHdznKEwve587uyPqMcnSK0Pz+QJL/JCRqGW2XIIscteEJq+NuLyMQta7oxeMvDW8Bln8Op48I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LdAM32Km; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5qUyNdYh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Jul 2025 14:00:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751551234;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RoDIPBAQb3WT9AKhQhg/ingV56c6NtL6Xe116Ev8row=;
	b=LdAM32KmqKSPNaXZTjCPiktZqDlpxLIuaw+C7/mi+UM5vayZm8Mhc44UCQer+Ty4OG2Vlf
	E0WmQF8DGS0+fATgNsnAXpvU39VwOM6GMLPNSq5DRp5x2gDTfky2waqaG8Kf/jGoeAS36w
	5YapoX1iiLPO6CxiNw+Ptq4/tsgQliX+sVtXsRyRKvg8ZGfgSy6WsKX4Vai+rE2LVU6MNG
	T/aVrxBmnWhbUfmQk2VjwvpOUVWgzBzur96rg1NqUFyKsX0DXcrWYJhsAmtninsRFTwelj
	L3NFWLy36e3uiUi7daaAu5WkGhujTWo6pyqNdB7CGxc7YEwwSST9IUkMCc+IRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751551234;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RoDIPBAQb3WT9AKhQhg/ingV56c6NtL6Xe116Ev8row=;
	b=5qUyNdYhoQ6aPshNksZE8vtorHqM5yn5hciFV4CV3A+EUPSr+GFgbJdQjGbEHXGkFXOLwS
	II1e2f781jhHCSDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/sg2042-msi: Switch to
 msi_create_parent_irq_domain()
Cc: Thomas Gleixner <tglx@linutronix.de>, Nam Cao <namcao@linutronix.de>,
 Chen Wang <unicorn_wang@outlook.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C3e901db1a4c87678af053019774d95b73bfb9ef9=2E17508?=
 =?utf-8?q?60131=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C3e901db1a4c87678af053019774d95b73bfb9ef9=2E175086?=
 =?utf-8?q?0131=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175155123349.406.7272008728940956912.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     7c0dbd80de036d400525b8df862be665d321d0fc
Gitweb:        https://git.kernel.org/tip/7c0dbd80de036d400525b8df862be665d321d0fc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 26 Jun 2025 16:49:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 03 Jul 2025 15:49:24 +02:00

irqchip/sg2042-msi: Switch to msi_create_parent_irq_domain()

Switch to use the concise helper to create an MSI parent domain.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Link: https://lore.kernel.org/all/3e901db1a4c87678af053019774d95b73bfb9ef9.1750860131.git.namcao@linutronix.de

---
 drivers/irqchip/irq-sg2042-msi.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
index af16bc5..bcfddc5 100644
--- a/drivers/irqchip/irq-sg2042-msi.c
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -219,20 +219,18 @@ static const struct msi_parent_ops sg2044_msi_parent_ops = {
 static int sg204x_msi_init_domains(struct sg204x_msi_chipdata *data,
 				   struct irq_domain *plic_domain, struct device *dev)
 {
-	struct fwnode_handle *fwnode = dev_fwnode(dev);
-	struct irq_domain *middle_domain;
-
-	middle_domain = irq_domain_create_hierarchy(plic_domain, 0, data->num_irqs, fwnode,
-						    &sg204x_msi_middle_domain_ops, data);
-	if (!middle_domain) {
+	struct irq_domain_info info = {
+		.ops		= &sg204x_msi_middle_domain_ops,
+		.parent		= plic_domain,
+		.size		= data->num_irqs,
+		.fwnode		= dev_fwnode(dev),
+		.host_data	= data,
+	};
+
+	if (!msi_create_parent_irq_domain(&info, data->chip_info->parent_ops)) {
 		pr_err("Failed to create the MSI middle domain\n");
 		return -ENOMEM;
 	}
-
-	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
-
-	middle_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	middle_domain->msi_parent_ops = data->chip_info->parent_ops;
 	return 0;
 }
 

