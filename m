Return-Path: <linux-tip-commits+bounces-5990-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89335AF7680
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 16:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB423AB082
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 14:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410C02EA486;
	Thu,  3 Jul 2025 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SoXOeUDq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X+MVg80F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618C92E9EB0;
	Thu,  3 Jul 2025 14:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551237; cv=none; b=NA28VRWoxZeR+9qVMveWmt+fDT2c3kO3BvsW55Hc3vTYKBZQ5CUSozPU8IvGQ7O+Gy1b8KloGwu+nq/R3qKdXZlzmmC+/DpGx7z3UFKaKsc0DA9XsWlj6e2TzSOux/hCB5YnLrTCRxy/ILYq+0PJOIc+K9Mkgx32Ih6iN+0DOPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551237; c=relaxed/simple;
	bh=3VUSJeY3iD/e2bE766CckFvuSGi+hQ8YO2OnD70RoKo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hO8j1ECwwmkGw4I5fzfocFnOaJAUXKgpAB87uAwmgriZhzkSzQ4lj5SFvRGvo/KTejIodTtGI8QEy8Y65u2nXy5/C/pwGTdnjrGLdURcoRWc2njclKsSL1Rm7aMQal0jSE6ZcBZnwcjwn84xLLTfK7Ua4XiQBdzGRk11hB6XBRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SoXOeUDq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X+MVg80F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Jul 2025 14:00:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751551233;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZHCR71HQ5Z7vYoWrpMrKxRMqEio891vrhsnH06UW4Q=;
	b=SoXOeUDq0ULGqp7aryxuj4v3PdSuKrMRlP7EHSgtYk27gnsnah2N8ijyD3EsEB6QDCYAGP
	62tGv7Woaxbe4gBInnhguqFFBAH9IKNLt7Ow01JosAYudN4Uu6RnorO99+58UeB7/cBFQ2
	bb8NPy/+IRRzwO7uXGCDjgDrE8LSgxOce+FPKFTewkP61eLBh5cJOagVPX364L19XgOvDo
	E8VdSyHPYxcvT7hKclQP8miP+Fp5uOW6gobfERify94UTb/hWOGdvVpDIpGl91U91k2hTD
	5c8nikKQ87tyuEhQdBPB7qT2y1Av8MEl49e6a3c580egwjXTz9EY5lGxozsmAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751551233;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZHCR71HQ5Z7vYoWrpMrKxRMqEio891vrhsnH06UW4Q=;
	b=X+MVg80FyscRVnpwxEPhnDukSwxs+EqNtg947hUInyPOMU1/XaX5F7LRKMyUMhXxOToTT7
	pLhT3rKS81kh5cAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/alpine-msi: Clean up whitespace style
Cc: Thomas Gleixner <tglx@linutronix.de>, Nam Cao <namcao@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C3bbf719fcd974b0f52a832552b986116bdc70203=2E17508?=
 =?utf-8?q?60131=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C3bbf719fcd974b0f52a832552b986116bdc70203=2E175086?=
 =?utf-8?q?0131=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175155123234.406.11632826811497606072.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     6e44ac411255e0a48674862b53f2b1b47148c209
Gitweb:        https://git.kernel.org/tip/6e44ac411255e0a48674862b53f2b1b47148c209
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 26 Jun 2025 16:49:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 03 Jul 2025 15:49:25 +02:00

irqchip/alpine-msi: Clean up whitespace style

Tidy up the coding style. Only formatting changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/3bbf719fcd974b0f52a832552b986116bdc70203.1750860131.git.namcao@linutronix.de

---
 drivers/irqchip/irq-alpine-msi.c | 37 ++++++++++---------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
index a5289dc..7e379a6 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -29,11 +29,11 @@
 #define ALPINE_MSIX_SPI_TARGET_CLUSTER0		BIT(16)
 
 struct alpine_msix_data {
-	spinlock_t msi_map_lock;
-	phys_addr_t addr;
-	u32 spi_first;		/* The SGI number that MSIs start */
-	u32 num_spis;		/* The number of SGIs for MSIs */
-	unsigned long *msi_map;
+	spinlock_t	msi_map_lock;
+	phys_addr_t	addr;
+	u32		spi_first;	/* The SGI number that MSIs start */
+	u32		num_spis;	/* The number of SGIs for MSIs */
+	unsigned long	*msi_map;
 };
 
 static void alpine_msix_mask_msi_irq(struct irq_data *d)
@@ -76,8 +76,7 @@ static int alpine_msix_allocate_sgi(struct alpine_msix_data *priv, int num_req)
 	return priv->spi_first + first;
 }
 
-static void alpine_msix_free_sgi(struct alpine_msix_data *priv, unsigned sgi,
-				 int num_req)
+static void alpine_msix_free_sgi(struct alpine_msix_data *priv, unsigned int sgi, int num_req)
 {
 	int first = sgi - priv->spi_first;
 
@@ -88,14 +87,12 @@ static void alpine_msix_free_sgi(struct alpine_msix_data *priv, unsigned sgi,
 	spin_unlock(&priv->msi_map_lock);
 }
 
-static void alpine_msix_compose_msi_msg(struct irq_data *data,
-					struct msi_msg *msg)
+static void alpine_msix_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct alpine_msix_data *priv = irq_data_get_irq_chip_data(data);
 	phys_addr_t msg_addr = priv->addr;
 
 	msg_addr |= (data->hwirq << 3);
-
 	msg->address_hi = upper_32_bits(msg_addr);
 	msg->address_lo = lower_32_bits(msg_addr);
 	msg->data = 0;
@@ -116,8 +113,7 @@ static struct irq_chip middle_irq_chip = {
 	.irq_compose_msi_msg	= alpine_msix_compose_msi_msg,
 };
 
-static int alpine_msix_gic_domain_alloc(struct irq_domain *domain,
-					unsigned int virq, int sgi)
+static int alpine_msix_gic_domain_alloc(struct irq_domain *domain, unsigned int virq, int sgi)
 {
 	struct irq_fwspec fwspec;
 	struct irq_data *d;
@@ -138,12 +134,10 @@ static int alpine_msix_gic_domain_alloc(struct irq_domain *domain,
 
 	d = irq_domain_get_irq_data(domain->parent, virq);
 	d->chip->irq_set_type(d, IRQ_TYPE_EDGE_RISING);
-
 	return 0;
 }
 
-static int alpine_msix_middle_domain_alloc(struct irq_domain *domain,
-					   unsigned int virq,
+static int alpine_msix_middle_domain_alloc(struct irq_domain *domain, unsigned int virq,
 					   unsigned int nr_irqs, void *args)
 {
 	struct alpine_msix_data *priv = domain->host_data;
@@ -161,7 +155,6 @@ static int alpine_msix_middle_domain_alloc(struct irq_domain *domain,
 		irq_domain_set_hwirq_and_chip(domain, virq + i, sgi + i,
 					      &middle_irq_chip, priv);
 	}
-
 	return 0;
 
 err_sgi:
@@ -170,8 +163,7 @@ err_sgi:
 	return err;
 }
 
-static void alpine_msix_middle_domain_free(struct irq_domain *domain,
-					   unsigned int virq,
+static void alpine_msix_middle_domain_free(struct irq_domain *domain, unsigned int virq,
 					   unsigned int nr_irqs)
 {
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
@@ -186,8 +178,7 @@ static const struct irq_domain_ops alpine_msix_middle_domain_ops = {
 	.free	= alpine_msix_middle_domain_free,
 };
 
-static int alpine_msix_init_domains(struct alpine_msix_data *priv,
-				    struct device_node *node)
+static int alpine_msix_init_domains(struct alpine_msix_data *priv, struct device_node *node)
 {
 	struct irq_domain *middle_domain, *msi_domain, *gic_domain;
 	struct device_node *gic_node;
@@ -224,8 +215,7 @@ static int alpine_msix_init_domains(struct alpine_msix_data *priv,
 	return 0;
 }
 
-static int alpine_msix_init(struct device_node *node,
-			    struct device_node *parent)
+static int alpine_msix_init(struct device_node *node, struct device_node *parent)
 {
 	struct alpine_msix_data *priv;
 	struct resource res;
@@ -271,8 +261,7 @@ static int alpine_msix_init(struct device_node *node,
 		goto err_priv;
 	}
 
-	pr_debug("Registering %d msixs, starting at %d\n",
-		 priv->num_spis, priv->spi_first);
+	pr_debug("Registering %d msixs, starting at %d\n", priv->num_spis, priv->spi_first);
 
 	ret = alpine_msix_init_domains(priv, node);
 	if (ret)

