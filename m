Return-Path: <linux-tip-commits+bounces-1413-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E467D90B2C2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 16:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98E8D1F29705
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 14:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25291D18ED;
	Mon, 17 Jun 2024 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tHc8hcSP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QWqjSKvC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5974F1D2A31;
	Mon, 17 Jun 2024 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632278; cv=none; b=Bpr/Fqh1dVpclTIebNsarOHXFet6ZZR3lP4YFZQrFrEMnApjaMHKzwMO76CvWnAicwecZMRIJNAGOp5gvEG10K0Yns5qao0+HA2YK3xqHwCa3No+UKx0zmKWDyHtgAUaCfzLWD9K/r04zk61BcyR3rSPUTjE2af4sy+/AO2AAE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632278; c=relaxed/simple;
	bh=3O6rwvZdLB7r1Qea7OQaO/I0nwG2pq6alwICyZHMeKo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ilhfiEmSRfNNbiyKY2DyiVJ4apRj7xZfKFni+FLe3EqYDFrqFiir+wAUVTh+cVD+TeEVTyyA/FsNROMU96rqmP1AzTFQb99rRTxUWtvC28hr6+PjWF4ZbWwFK1nxr+lCUUD05mWZyxd2thNBLrOhGYNza3XVmp95WVujRJJ2nQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tHc8hcSP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QWqjSKvC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 13:51:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718632271;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Brq/79czdtu1s+DbhWuU3MR0Y3g8R7j5F1Uxd7U0ZlM=;
	b=tHc8hcSP9vvEhcWmUXKtTrwibjyFDpT90sPvLvYGkDkdGsWbm923N4ve2uHtjVtUFucGzv
	QAxuBIlJAX3QekaRW2c6rWZW5cXtQiAiLfqc3dL3dPB06eFrDeKUGI4ujslVCIQSypA/Yb
	SigitpQQvSiWt4Q2mbEOOtAP3AroVKwEoj7WrU4tjotyv1dpVBHU9aII/L3x0vUeIEXVIJ
	4kd8vnXS/TwDcbTW9slAnhPUqEjTKfCojOM/VRtnmLwd2pUAiuo4NQoEhRZaMiNfB6q66i
	76jMgahTKVD8w8WeZ5OTMVhy9vXaIaNp47Xtwp94nqtn9fT/aPDdwmxfF0OM6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632271;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Brq/79czdtu1s+DbhWuU3MR0Y3g8R7j5F1Uxd7U0ZlM=;
	b=QWqjSKvCmpsx/IniH4Us0E36QyVsFN/TAd9yYkxr67Cz7RwwErBvDtk82k2gb4dMVDHUa6
	EN+CjCSaywrqFeBA==
From: "tip-bot2 for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Introduce init() and exit() hooks
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Herve Codina <herve.codina@bootlin.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240614173232.1184015-13-herve.codina@bootlin.com>
References: <20240614173232.1184015-13-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863227082.10875.9095587689008848645.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     44b68de9b8e3dfde12308e8567548799d7ded0de
Gitweb:        https://git.kernel.org/tip/44b68de9b8e3dfde12308e8567548799d7ded0de
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Fri, 14 Jun 2024 19:32:13 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:48:14 +02:00

irqdomain: Introduce init() and exit() hooks

The current API does not allow additional initialization before the
domain is published. This can lead to a race condition between consumers
and supplier as a domain can be available for consumers before being
fully ready.

Introduce the init() hook to allow additional initialization before
plublishing the domain. Also introduce the exit() hook to revert
operations done in init() on domain removal.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240614173232.1184015-13-herve.codina@bootlin.com

---
 include/linux/irqdomain.h |  8 ++++++++
 kernel/irq/irqdomain.c    | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 52bed23..2c927ed 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -141,6 +141,7 @@ struct irq_domain_chip_generic;
  *		purposes related to the irq domain.
  * @parent:	Pointer to parent irq_domain to support hierarchy irq_domains
  * @msi_parent_ops: Pointer to MSI parent domain methods for per device domain init
+ * @exit:	Function called when the domain is destroyed
  *
  * Revmap data, used internally by the irq domain code:
  * @revmap_size:	Size of the linear map table @revmap[]
@@ -169,6 +170,7 @@ struct irq_domain {
 #ifdef CONFIG_GENERIC_MSI_IRQ
 	const struct msi_parent_ops	*msi_parent_ops;
 #endif
+	void				(*exit)(struct irq_domain *d);
 
 	/* reverse map data. The linear map gets appended to the irq_domain */
 	irq_hw_number_t			hwirq_max;
@@ -268,6 +270,10 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
  * @bus_token:		Domain bus token
  * @ops:		Domain operation callbacks
  * @host_data:		Controller private data pointer
+ * @init:		Function called when the domain is created.
+ *			Allow to do some additional domain initialisation.
+ * @exit:		Function called when the domain is destroyed.
+ *			Allow to do some additional cleanup operation.
  */
 struct irq_domain_info {
 	struct fwnode_handle			*fwnode;
@@ -284,6 +290,8 @@ struct irq_domain_info {
 	 */
 	struct irq_domain			*parent;
 #endif
+	int					(*init)(struct irq_domain *d);
+	void					(*exit)(struct irq_domain *d);
 };
 
 struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index a21648c..a0324d8 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -276,12 +276,14 @@ static void irq_domain_free(struct irq_domain *domain)
 struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 {
 	struct irq_domain *domain;
+	int err;
 
 	domain = __irq_domain_create(info);
 	if (IS_ERR(domain))
 		return domain;
 
 	domain->flags |= info->domain_flags;
+	domain->exit = info->exit;
 
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 	if (info->parent) {
@@ -290,9 +292,19 @@ struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 	}
 #endif
 
+	if (info->init) {
+		err = info->init(domain);
+		if (err)
+			goto err_domain_free;
+	}
+
 	__irq_domain_publish(domain);
 
 	return domain;
+
+err_domain_free:
+	irq_domain_free(domain);
+	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(irq_domain_instantiate);
 
@@ -339,6 +351,9 @@ EXPORT_SYMBOL_GPL(__irq_domain_add);
  */
 void irq_domain_remove(struct irq_domain *domain)
 {
+	if (domain->exit)
+		domain->exit(domain);
+
 	mutex_lock(&irq_domain_mutex);
 	debugfs_remove_domain_dir(domain);
 

