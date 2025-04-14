Return-Path: <linux-tip-commits+bounces-4983-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F71A88A01
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 19:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B6417C4B7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 17:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8764F28A1ED;
	Mon, 14 Apr 2025 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UqmDQNHP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NC+60p1M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C591289360;
	Mon, 14 Apr 2025 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652386; cv=none; b=HZIYHQ73IuSMP4n5a712FPSCv+N/OKrurNVxyK+aQMkdhU5JW0VDpEKPEeZhqAm1HV/21mvXXPDWSmMWOTd3RGBBkVhL5z4igq2BjSFxf+ZBhOix3rw20R7ccQ7RNZ9SPCEfgf17+ps/TCZYX1dAXxD6R9CLet/UQhnL+qaV0tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652386; c=relaxed/simple;
	bh=XQnvhkEn/kYpx7dYsb9MPze4GQcOstnth10EVQLzyoo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d31sJy8UwN2y2kmau4AFaPVWbPysjgP+9TWxvZ/k7GK3iNgjSCEPUmJatdyNEQcMxd/XyE07ENmYORqh99tFlGGCNWkh3aBkgjNr2kAwbpHiGQQ/V8TDtJivhLMXRWbgHgO9cMUN2wp8Hj7nu3/qfj3q6LTuiQFb3l+hjHmx1Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UqmDQNHP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NC+60p1M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 17:39:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744652382;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZ7FUDt/4SK5DrAGIIdfYME8FRgEZ5LF7LDaZ0qbyL0=;
	b=UqmDQNHPJxH2n6eHA10tj20ME+EMX7W+4JP1PpKnXPUFj8v9S6JpRAqH7DBylJ3TilNu29
	oFMrxSnWTz5xKZ+HgT2yVZMEPUtaQ+F2d6oHSr3DdrRQCz3z92ODMuSdfBtUjOw6rC6PoP
	kY47CdofvjJznUVA465JiMrmIkhSqSOkMicSKN960epf6W9N89dRpy3o4mxo/VS7CcGXBE
	blWmdWbYaLYO9bXxpZVtgYrhOZ7qiXj7K0aWhaRCHBnlCARmQSltab2qKD5dtVwx2EjVbo
	cc0iHgCRWgiMGFq5WFBI1XPwviax0eiU+nbLkC5U3G4KffX6rNihiWzZntjj2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744652382;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZ7FUDt/4SK5DrAGIIdfYME8FRgEZ5LF7LDaZ0qbyL0=;
	b=NC+60p1MiAl9gfYwup8v/pDOXd3iU2bNJMXa2X+4r28zlOjuU/7tVciTamHowdTzDhfblz
	hgaFmCwD3iChmLCw==
From: "tip-bot2 for Inochi Amaoto" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/sg2042-msi: Rename functions and data
 structures to be SG2042 agnostic
Cc: Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Chen Wang <wangchen20@iscas.ac.cn>, Chen Wang <unicorn_wang@outlook.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250413224922.69719-3-inochiama@gmail.com>
References: <20250413224922.69719-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174465238188.31282.12193312183261384735.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     bced55494c23dca674c3c18b4a07ffe7c15000e2
Gitweb:        https://git.kernel.org/tip/bced55494c23dca674c3c18b4a07ffe7c15000e2
Author:        Inochi Amaoto <inochiama@gmail.com>
AuthorDate:    Mon, 14 Apr 2025 06:49:13 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 14 Apr 2025 19:35:36 +02:00

irqchip/sg2042-msi: Rename functions and data structures to be SG2042 agnostic

As the driver logic can be used in both SG2042 and SG2044 SoCs, rename
functions and data structures, which are not SG2042 specific, to SG204x*.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Chen Wang <wangchen20@iscas.ac.cn> # SG2042
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Link: https://lore.kernel.org/all/20250413224922.69719-3-inochiama@gmail.com

---
 drivers/irqchip/irq-sg2042-msi.c | 46 +++++++++++++++----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
index ee682e8..5f7fae4 100644
--- a/drivers/irqchip/irq-sg2042-msi.c
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -21,7 +21,7 @@
 
 #define SG2042_MAX_MSI_VECTOR	32
 
-struct sg2042_msi_chipdata {
+struct sg204x_msi_chipdata {
 	void __iomem	*reg_clr;	// clear reg, see TRM, 10.1.33, GP_INTR0_CLR
 
 	phys_addr_t	doorbell_addr;	// see TRM, 10.1.32, GP_INTR0_SET
@@ -33,7 +33,7 @@ struct sg2042_msi_chipdata {
 	struct mutex	msi_map_lock;	// lock for msi_map
 };
 
-static int sg2042_msi_allocate_hwirq(struct sg2042_msi_chipdata *data, int num_req)
+static int sg204x_msi_allocate_hwirq(struct sg204x_msi_chipdata *data, int num_req)
 {
 	int first;
 
@@ -43,7 +43,7 @@ static int sg2042_msi_allocate_hwirq(struct sg2042_msi_chipdata *data, int num_r
 	return first >= 0 ? first : -ENOSPC;
 }
 
-static void sg2042_msi_free_hwirq(struct sg2042_msi_chipdata *data, int hwirq, int num_req)
+static void sg204x_msi_free_hwirq(struct sg204x_msi_chipdata *data, int hwirq, int num_req)
 {
 	guard(mutex)(&data->msi_map_lock);
 	bitmap_release_region(data->msi_map, hwirq, get_count_order(num_req));
@@ -51,7 +51,7 @@ static void sg2042_msi_free_hwirq(struct sg2042_msi_chipdata *data, int hwirq, i
 
 static void sg2042_msi_irq_ack(struct irq_data *d)
 {
-	struct sg2042_msi_chipdata *data  = irq_data_get_irq_chip_data(d);
+	struct sg204x_msi_chipdata *data  = irq_data_get_irq_chip_data(d);
 	int bit_off = d->hwirq;
 
 	writel(1 << bit_off, data->reg_clr);
@@ -61,7 +61,7 @@ static void sg2042_msi_irq_ack(struct irq_data *d)
 
 static void sg2042_msi_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
 {
-	struct sg2042_msi_chipdata *data = irq_data_get_irq_chip_data(d);
+	struct sg204x_msi_chipdata *data = irq_data_get_irq_chip_data(d);
 
 	msg->address_hi = upper_32_bits(data->doorbell_addr);
 	msg->address_lo = lower_32_bits(data->doorbell_addr);
@@ -79,9 +79,9 @@ static const struct irq_chip sg2042_msi_middle_irq_chip = {
 	.irq_compose_msi_msg	= sg2042_msi_irq_compose_msi_msg,
 };
 
-static int sg2042_msi_parent_domain_alloc(struct irq_domain *domain, unsigned int virq, int hwirq)
+static int sg204x_msi_parent_domain_alloc(struct irq_domain *domain, unsigned int virq, int hwirq)
 {
-	struct sg2042_msi_chipdata *data = domain->host_data;
+	struct sg204x_msi_chipdata *data = domain->host_data;
 	struct irq_fwspec fwspec;
 	struct irq_data *d;
 	int ret;
@@ -99,18 +99,18 @@ static int sg2042_msi_parent_domain_alloc(struct irq_domain *domain, unsigned in
 	return d->chip->irq_set_type(d, IRQ_TYPE_EDGE_RISING);
 }
 
-static int sg2042_msi_middle_domain_alloc(struct irq_domain *domain, unsigned int virq,
+static int sg204x_msi_middle_domain_alloc(struct irq_domain *domain, unsigned int virq,
 					  unsigned int nr_irqs, void *args)
 {
-	struct sg2042_msi_chipdata *data = domain->host_data;
+	struct sg204x_msi_chipdata *data = domain->host_data;
 	int hwirq, err, i;
 
-	hwirq = sg2042_msi_allocate_hwirq(data, nr_irqs);
+	hwirq = sg204x_msi_allocate_hwirq(data, nr_irqs);
 	if (hwirq < 0)
 		return hwirq;
 
 	for (i = 0; i < nr_irqs; i++) {
-		err = sg2042_msi_parent_domain_alloc(domain, virq + i, hwirq + i);
+		err = sg204x_msi_parent_domain_alloc(domain, virq + i, hwirq + i);
 		if (err)
 			goto err_hwirq;
 
@@ -121,25 +121,25 @@ static int sg2042_msi_middle_domain_alloc(struct irq_domain *domain, unsigned in
 	return 0;
 
 err_hwirq:
-	sg2042_msi_free_hwirq(data, hwirq, nr_irqs);
+	sg204x_msi_free_hwirq(data, hwirq, nr_irqs);
 	irq_domain_free_irqs_parent(domain, virq, i);
 
 	return err;
 }
 
-static void sg2042_msi_middle_domain_free(struct irq_domain *domain, unsigned int virq,
+static void sg204x_msi_middle_domain_free(struct irq_domain *domain, unsigned int virq,
 					  unsigned int nr_irqs)
 {
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
-	struct sg2042_msi_chipdata *data = irq_data_get_irq_chip_data(d);
+	struct sg204x_msi_chipdata *data = irq_data_get_irq_chip_data(d);
 
 	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
-	sg2042_msi_free_hwirq(data, d->hwirq, nr_irqs);
+	sg204x_msi_free_hwirq(data, d->hwirq, nr_irqs);
 }
 
-static const struct irq_domain_ops sg2042_msi_middle_domain_ops = {
-	.alloc	= sg2042_msi_middle_domain_alloc,
-	.free	= sg2042_msi_middle_domain_free,
+static const struct irq_domain_ops sg204x_msi_middle_domain_ops = {
+	.alloc	= sg204x_msi_middle_domain_alloc,
+	.free	= sg204x_msi_middle_domain_free,
 	.select	= msi_lib_irq_domain_select,
 };
 
@@ -157,14 +157,14 @@ static const struct msi_parent_ops sg2042_msi_parent_ops = {
 	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
 };
 
-static int sg2042_msi_init_domains(struct sg2042_msi_chipdata *data,
+static int sg204x_msi_init_domains(struct sg204x_msi_chipdata *data,
 				   struct irq_domain *plic_domain, struct device *dev)
 {
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct irq_domain *middle_domain;
 
 	middle_domain = irq_domain_create_hierarchy(plic_domain, 0, data->num_irqs, fwnode,
-						    &sg2042_msi_middle_domain_ops, data);
+						    &sg204x_msi_middle_domain_ops, data);
 	if (!middle_domain) {
 		pr_err("Failed to create the MSI middle domain\n");
 		return -ENOMEM;
@@ -181,13 +181,13 @@ static int sg2042_msi_init_domains(struct sg2042_msi_chipdata *data,
 static int sg2042_msi_probe(struct platform_device *pdev)
 {
 	struct fwnode_reference_args args = { };
-	struct sg2042_msi_chipdata *data;
+	struct sg204x_msi_chipdata *data;
 	struct device *dev = &pdev->dev;
 	struct irq_domain *plic_domain;
 	struct resource *res;
 	int ret;
 
-	data = devm_kzalloc(dev, sizeof(struct sg2042_msi_chipdata), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct sg204x_msi_chipdata), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -231,7 +231,7 @@ static int sg2042_msi_probe(struct platform_device *pdev)
 
 	mutex_init(&data->msi_map_lock);
 
-	return sg2042_msi_init_domains(data, plic_domain, dev);
+	return sg204x_msi_init_domains(data, plic_domain, dev);
 }
 
 static const struct of_device_id sg2042_msi_of_match[] = {

