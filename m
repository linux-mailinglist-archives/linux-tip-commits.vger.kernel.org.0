Return-Path: <linux-tip-commits+bounces-1414-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EDF90B2C3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 16:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243B21F2972C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 14:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A6D200125;
	Mon, 17 Jun 2024 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fi8RUXRD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IEpWQiAh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549711D2A2C;
	Mon, 17 Jun 2024 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632278; cv=none; b=DFxpDmTWScjmkxrBH1nexI7xQnMPk+s16fkJMzDdor+ARnFXY3mCXAyd4KYn7Ire8KgM4dFLXihaOpnutwyQRHJpVy1Y+7NrXlwiyddMIR1EnipAV+X54JERnjVZxX9DDbG7itxWlWHWxv6i9Xum51WONZVNaXllQDWVjT5jSi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632278; c=relaxed/simple;
	bh=+uuk3vMCYxF3Q8l4AHiJOepR9hKWS3z/s9T1avm3wlI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CL5PvXmiagucsH8QgGHQBQQYHBqSwTfEzjXSg9mEfXTMte9q60QxuhIzKlnhNHsbytaZhyVRuG2hEP7nw2MbhrOaB4PqS1+ppcF6aEROh0a6Kl1WJrQqpLYkZEV7y2zhMNLwqnnlsAThqpqb8i2Nx3rTiRgHZ4UJSgb1d908pCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fi8RUXRD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IEpWQiAh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 13:51:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718632271;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SUtlrTxv8VGKnra57J0H5miJp+nw4zCjNbDz8H8iltA=;
	b=fi8RUXRD7wugXBVVUjK33S+esvhFT3cVkheZUcRGn859W2ShpRQVZF4eGqL/8oBIiJQfzk
	+uo0+nWLk4pETxjg6+/3C1s8F/5TeFWQrDxTO9lFE6UW2xg2trJdo3iWtLWcjRHu5SahFs
	G9HLPctDXNPqgCVz6Ow3ubXWl2rdDkOjauu+JUWrSvVPnqV6CDMsXBuEkrB1e7rPcO+AJg
	hpyqi1PSKFgyQgzV262mzw7CTgatWgSKzC244gHOK9Bw5yjm4QAqVF2Kj7mA5FavHJQBnO
	4CBy0yRq6bXmfvRUNa3dAnwpGXvyOqC/00Y01uSuDJqDQBvefw95I+64Vr8JGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632271;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SUtlrTxv8VGKnra57J0H5miJp+nw4zCjNbDz8H8iltA=;
	b=IEpWQiAhhNXp/RTo9HUpfjvHiJdLnpNCL6d4HeOSf6agRm/XtuhdaApQmpVtagLp9ZQAz9
	OzmpQyxXOZtmRWDg==
From: "tip-bot2 for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqdomain: Handle domain bus token in irq_domain_create()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Herve Codina <herve.codina@bootlin.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240614173232.1184015-12-herve.codina@bootlin.com>
References: <20240614173232.1184015-12-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863227113.10875.12036970870423262662.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0b21add71bd9cfa2bd6677a0300e15fd4c4b84ed
Gitweb:        https://git.kernel.org/tip/0b21add71bd9cfa2bd6677a0300e15fd4c4b84ed
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Fri, 14 Jun 2024 19:32:12 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:48:14 +02:00

irqdomain: Handle domain bus token in irq_domain_create()

irq_domain_update_bus_token() is the only way to set the domain bus
token. This is sub-optimal as irq_domain_update_bus_token() can be called
only once the domain is created and needs to revert some operations, change
the domain name and redo the operations.

In order to avoid this revert/change/redo sequence, take the domain bus
into account token during the domain creation.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240614173232.1184015-12-herve.codina@bootlin.com

---
 include/linux/irqdomain.h |  2 ++
 kernel/irq/irqdomain.c    | 30 ++++++++++++++++++++++++------
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index e52fd5e..52bed23 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -265,6 +265,7 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
  * @hwirq_max:		Maximum number of interrupts supported by controller
  * @direct_max:		Maximum value of direct maps;
  *			Use ~0 for no limit; 0 for no direct mapping
+ * @bus_token:		Domain bus token
  * @ops:		Domain operation callbacks
  * @host_data:		Controller private data pointer
  */
@@ -274,6 +275,7 @@ struct irq_domain_info {
 	unsigned int				size;
 	irq_hw_number_t				hwirq_max;
 	int					direct_max;
+	enum irq_domain_bus_token		bus_token;
 	const struct irq_domain_ops		*ops;
 	void					*host_data;
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index fe7bba6..a21648c 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -129,7 +129,8 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode)
 EXPORT_SYMBOL_GPL(irq_domain_free_fwnode);
 
 static int irq_domain_set_name(struct irq_domain *domain,
-			       const struct fwnode_handle *fwnode)
+			       const struct fwnode_handle *fwnode,
+			       enum irq_domain_bus_token bus_token)
 {
 	static atomic_t unknown_domains;
 	struct irqchip_fwid *fwid;
@@ -140,13 +141,23 @@ static int irq_domain_set_name(struct irq_domain *domain,
 		switch (fwid->type) {
 		case IRQCHIP_FWNODE_NAMED:
 		case IRQCHIP_FWNODE_NAMED_ID:
-			domain->name = kstrdup(fwid->name, GFP_KERNEL);
+			domain->name = bus_token ?
+					kasprintf(GFP_KERNEL, "%s-%d",
+						  fwid->name, bus_token) :
+					kstrdup(fwid->name, GFP_KERNEL);
 			if (!domain->name)
 				return -ENOMEM;
 			domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 			break;
 		default:
 			domain->name = fwid->name;
+			if (bus_token) {
+				domain->name = kasprintf(GFP_KERNEL, "%s-%d",
+							 fwid->name, bus_token);
+				if (!domain->name)
+					return -ENOMEM;
+				domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
+			}
 			break;
 		}
 	} else if (is_of_node(fwnode) || is_acpi_device_node(fwnode) ||
@@ -158,7 +169,9 @@ static int irq_domain_set_name(struct irq_domain *domain,
 		 * unhappy about. Replace them with ':', which does
 		 * the trick and is not as offensive as '\'...
 		 */
-		name = kasprintf(GFP_KERNEL, "%pfw", fwnode);
+		name = bus_token ?
+			kasprintf(GFP_KERNEL, "%pfw-%d", fwnode, bus_token) :
+			kasprintf(GFP_KERNEL, "%pfw", fwnode);
 		if (!name)
 			return -ENOMEM;
 
@@ -169,8 +182,12 @@ static int irq_domain_set_name(struct irq_domain *domain,
 	if (!domain->name) {
 		if (fwnode)
 			pr_err("Invalid fwnode type for irqdomain\n");
-		domain->name = kasprintf(GFP_KERNEL, "unknown-%d",
-					 atomic_inc_return(&unknown_domains));
+		domain->name = bus_token ?
+				kasprintf(GFP_KERNEL, "unknown-%d-%d",
+					  atomic_inc_return(&unknown_domains),
+					  bus_token) :
+				kasprintf(GFP_KERNEL, "unknown-%d",
+					  atomic_inc_return(&unknown_domains));
 		if (!domain->name)
 			return -ENOMEM;
 		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
@@ -194,7 +211,7 @@ static struct irq_domain *__irq_domain_create(const struct irq_domain_info *info
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
-	err = irq_domain_set_name(domain, info->fwnode);
+	err = irq_domain_set_name(domain, info->fwnode, info->bus_token);
 	if (err) {
 		kfree(domain);
 		return ERR_PTR(err);
@@ -207,6 +224,7 @@ static struct irq_domain *__irq_domain_create(const struct irq_domain_info *info
 	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
 	domain->ops = info->ops;
 	domain->host_data = info->host_data;
+	domain->bus_token = info->bus_token;
 	domain->hwirq_max = info->hwirq_max;
 
 	if (info->direct_max)

