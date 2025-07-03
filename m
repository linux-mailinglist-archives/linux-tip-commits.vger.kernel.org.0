Return-Path: <linux-tip-commits+bounces-5996-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A65AF768C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 16:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C971C87676
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 14:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B09F2EBBBC;
	Thu,  3 Jul 2025 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bxdWnwtp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y5kW1Nxd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CC82EACFC;
	Thu,  3 Jul 2025 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551242; cv=none; b=mBzs2IW0d43jscQoayZ4LFTaMRYpwPxR04+AQ9MvvxXLuIHmqZqQVL/X1TYbhLiuLN94hpEOag4NjZOCLxbuN2/1cYJzLJmeYvhHOIVKneI2pUCFY2IzCQkdeVj9NVbjc0XhDOM5l58VRwZQpX3Pkm9pAQTbe5omhqIOeJLJldo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551242; c=relaxed/simple;
	bh=OplZu4ZwnCE4z0lehsp/N+A721CFb2fCEP9h6B9Fu1g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VFycEAqiivpzHepgfqTvi3m71sx0Us3GkNs+GdTh/OmXLG9xYvDXL6tIPtg2Ht/CV+DY+SB76vwFvbmk7TDp5V5tfnI4HD8ZZE2PYVyqqao3gk0HbF3yXpQI6mKT45ean/y5nHaZwt+BxBIZSJtJlEqkPzVBmpjjle0Z8E7iNHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bxdWnwtp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y5kW1Nxd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Jul 2025 14:00:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751551239;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VY/jNc1HaGyf4AMGumUFydlOdhdzpJ6mXIQOc/JW0Rg=;
	b=bxdWnwtp9YD31COWCvELSDKQaCRa0U4riZrE3o0IdGB7L/gKzMtWSNgUYuDu+eJztkUemT
	TzbWU0t3gJcXvX5tKzQM5hBGCRxtn/EhBjrlK2pnokt2oexmnc6u7S9ZzczYp5LZdaYPA3
	4CynVMjVOgd0k1vIb8c+vkWjoviHX2W5FVkDV2/2lkujQ28kBiScMXCWgb5kjPL58RGYYx
	Rpk6gxeI0AMH2avWRrJS+ffuhmYShubVWvqGnSnWkgMR0dwB9tCIZcmEUpdAccwSHJr3N2
	WjN/PPPmFLIOBr53D5Lr1FoW2NNKRXcjaZ9zEki80KpUuUKSd3tkay/oyMQy5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751551239;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VY/jNc1HaGyf4AMGumUFydlOdhdzpJ6mXIQOc/JW0Rg=;
	b=y5kW1Nxdz5/+Y0AP1teDkU87Ot+cCjdYt5I7M7iAHnXZUeq6M0sbj9qYGEEGtQChb8WRUi
	OV7dJdo4Ybv6OuBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqdomain: Add device pointer to irq_domain_info
 and msi_domain_info
Cc: Thomas Gleixner <tglx@linutronix.de>, Nam Cao <namcao@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C943e52403b20cf13c320d55bd4446b4562466aab=2E17508?=
 =?utf-8?q?60131=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C943e52403b20cf13c320d55bd4446b4562466aab=2E175086?=
 =?utf-8?q?0131=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175155123817.406.15181012972055274091.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     858e65af91351f8842bbe2c5ae6f100778783f42
Gitweb:        https://git.kernel.org/tip/858e65af91351f8842bbe2c5ae6f100778783f42
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 26 Jun 2025 16:48:58 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 03 Jul 2025 15:49:24 +02:00

irqdomain: Add device pointer to irq_domain_info and msi_domain_info

Add device pointer to irq_domain_info and msi_domain_info, so that the device
can be specified at domain creation time.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/943e52403b20cf13c320d55bd4446b4562466aab.1750860131.git.namcao@linutronix.de

---
 include/linux/irqdomain.h | 2 ++
 include/linux/msi.h       | 2 ++
 kernel/irq/irqdomain.c    | 1 +
 kernel/irq/msi.c          | 3 ++-
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 7387d18..266b5e5 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -279,6 +279,7 @@ struct irq_domain_chip_generic_info;
  *			domains are added using same fwnode
  * @ops:		Domain operation callbacks
  * @host_data:		Controller private data pointer
+ * @dev:		Device which creates the domain
  * @dgc_info:		Geneneric chip information structure pointer used to
  *			create generic chips for the domain if not NULL.
  * @init:		Function called when the domain is created.
@@ -298,6 +299,7 @@ struct irq_domain_info {
 	const char				*name_suffix;
 	const struct irq_domain_ops		*ops;
 	void					*host_data;
+	struct device				*dev;
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 	/**
 	 * @parent: Pointer to the parent irq domain used in a hierarchy domain
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 6863540..77227d2 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -488,6 +488,7 @@ struct msi_domain_ops {
  *			gets initialized to the maximum software index limit
  *			by the domain creation code.
  * @ops:		The callback data structure
+ * @dev:		Device which creates the domain
  * @chip:		Optional: associated interrupt chip
  * @chip_data:		Optional: associated interrupt chip data
  * @handler:		Optional: associated interrupt flow handler
@@ -501,6 +502,7 @@ struct msi_domain_info {
 	enum irq_domain_bus_token	bus_token;
 	unsigned int			hwsize;
 	struct msi_domain_ops		*ops;
+	struct device			*dev;
 	struct irq_chip			*chip;
 	void				*chip_data;
 	irq_flow_handler_t		handler;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index c8b6de0..4afbd3a 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -317,6 +317,7 @@ static struct irq_domain *__irq_domain_instantiate(const struct irq_domain_info 
 
 	domain->flags |= info->domain_flags;
 	domain->exit = info->exit;
+	domain->dev = info->dev;
 
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 	if (info->parent) {
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 9febe79..9b09ad3 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -889,6 +889,7 @@ static struct irq_domain *__msi_create_irq_domain(struct fwnode_handle *fwnode,
 
 	if (domain) {
 		irq_domain_update_bus_token(domain, info->bus_token);
+		domain->dev = info->dev;
 		if (info->flags & MSI_FLAG_PARENT_PM_DEV)
 			domain->pm_dev = parent->pm_dev;
 	}
@@ -1051,6 +1052,7 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 	bundle->info.data = domain_data;
 	bundle->info.chip_data = chip_data;
 	bundle->info.alloc_data = &bundle->alloc_info;
+	bundle->info.dev = dev;
 
 	pops = parent->msi_parent_ops;
 	snprintf(bundle->name, sizeof(bundle->name), "%s%s-%s",
@@ -1089,7 +1091,6 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 	if (!domain)
 		return false;
 
-	domain->dev = dev;
 	dev->msi.data->__domains[domid].domain = domain;
 
 	if (msi_domain_prepare_irqs(domain, dev, hwsize, &bundle->alloc_info)) {

