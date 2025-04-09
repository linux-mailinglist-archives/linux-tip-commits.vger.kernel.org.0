Return-Path: <linux-tip-commits+bounces-4809-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD31A82FC3
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 20:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96EA466F00
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 18:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3976C27F4E6;
	Wed,  9 Apr 2025 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tAixYEYw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ur5Qt1CU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B6E27EC62;
	Wed,  9 Apr 2025 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224879; cv=none; b=eChorRBZ/2udhOBdSDoO5AUIEufpXh/23cN3Q/YUCuriVR/sPfFAbUT2eR4UlVK7cGgFPPfiBfLV/pCbst14sEDnynksDgTJfb6E9/5SAf/jzI+90aYsDNCErxrpYZK1726Oca2FwPxmj5v5L04pS7vrG7a/41F+GaaSa46l2bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224879; c=relaxed/simple;
	bh=eAKPFokw74tkd2XehzPjCy5BFL/HhIzbTg85Rtl1A4A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NDQrlCBYFxMYZ3N5PXwwqtm0Uak7D1OVfMY8+5He+mL/8Q+df7vpE6k/zjpz8GHKN+6slaFCDfbMWQAB2/cCm9D/OaE+CVOXaZVc3dJnTxv2/eoI7ifAC1ImY1SbUD/vkutFrDbWgAqglr/4Dvl3YK70ubutytDvKeQu4SIumUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tAixYEYw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ur5Qt1CU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 18:54:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744224875;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=diekNr5mvax6qVZbaHpWqBwckDu/4fk1ntMcN2G8LvU=;
	b=tAixYEYw64yoC/d0fjQgEVJzyR7HJQ1ByHwJfG5DpAbyp1QczzhIMjNnUQziXn9vzAfx2e
	lfRBki/MRNrCuwMFMmMgjl3sS0qSYCWWH0e7KOy09IQvNN8JFyKCawoNsy6od0AngK5f0Q
	XPSoHj0azYrESkkrYOR53k3xefS/xrvmKhvYsyK93jPW+ptSf6E98QYpffghz+8WY8r7wG
	izl35mi2f5cZwEHYioQ0DDV2uPd9WN5KiKU1jC1YOyTFcVyKklIEt5Rdp2F1LY+WGSZeWx
	Pg2rDgM7iE/GIZnkaaUPpQxOsosT6Y1APaRL5XGdEBGCEfKaTMHPxxsM5U1kGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744224875;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=diekNr5mvax6qVZbaHpWqBwckDu/4fk1ntMcN2G8LvU=;
	b=Ur5Qt1CUgk7KnqnkeSx40o7NHmhEWbw39+z6vk07gp9LTvdabCcWRkfVDRWO8wClNCg1Np
	kH/pz4f3OuZrAECA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Use lock guards for MSI descriptor locking
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319105506.144672678@linutronix.de>
References: <20250319105506.144672678@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174422487480.31282.1454328912019908708.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     0dac2b09303c89ffb21d25d40bf6aefd39f214b0
Gitweb:        https://git.kernel.org/tip/0dac2b09303c89ffb21d25d40bf6aefd39f214b0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:56:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Apr 2025 20:47:29 +02:00

genirq/msi: Use lock guards for MSI descriptor locking

Provide a lock guard for MSI descriptor locking and update the core code
accordingly.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://lore.kernel.org/all/20250319105506.144672678@linutronix.de



---
 include/linux/irqdomain.h |   2 +-
 include/linux/msi.h       |   3 +-
 kernel/irq/msi.c          | 109 +++++++++++++------------------------
 3 files changed, 45 insertions(+), 69 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index bb71111..2f95571 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -281,6 +281,8 @@ static inline struct fwnode_handle *irq_domain_alloc_fwnode(phys_addr_t *pa)
 
 void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
 
+DEFINE_FREE(irq_domain_free_fwnode, struct fwnode_handle *, if (_T) irq_domain_free_fwnode(_T))
+
 struct irq_domain_chip_generic_info;
 
 /**
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 86e4274..4e43991 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -232,6 +232,9 @@ int msi_setup_device_data(struct device *dev);
 void msi_lock_descs(struct device *dev);
 void msi_unlock_descs(struct device *dev);
 
+DEFINE_LOCK_GUARD_1(msi_descs_lock, struct device, msi_lock_descs(_T->lock),
+		    msi_unlock_descs(_T->lock));
+
 struct msi_desc *msi_domain_first_desc(struct device *dev, unsigned int domid,
 				       enum msi_desc_filter filter);
 
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 5c8d43c..5747d20 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -448,7 +448,6 @@ EXPORT_SYMBOL_GPL(msi_next_desc);
 unsigned int msi_domain_get_virq(struct device *dev, unsigned int domid, unsigned int index)
 {
 	struct msi_desc *desc;
-	unsigned int ret = 0;
 	bool pcimsi = false;
 	struct xarray *xa;
 
@@ -462,7 +461,7 @@ unsigned int msi_domain_get_virq(struct device *dev, unsigned int domid, unsigne
 	if (dev_is_pci(dev) && domid == MSI_DEFAULT_DOMAIN)
 		pcimsi = to_pci_dev(dev)->msi_enabled;
 
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	xa = &dev->msi.data->__domains[domid].store;
 	desc = xa_load(xa, pcimsi ? 0 : index);
 	if (desc && desc->irq) {
@@ -471,16 +470,12 @@ unsigned int msi_domain_get_virq(struct device *dev, unsigned int domid, unsigne
 		 * PCI-MSIX and platform MSI use a descriptor per
 		 * interrupt.
 		 */
-		if (pcimsi) {
-			if (index < desc->nvec_used)
-				ret = desc->irq + index;
-		} else {
-			ret = desc->irq;
-		}
+		if (!pcimsi)
+			return desc->irq;
+		if (index < desc->nvec_used)
+			return desc->irq + index;
 	}
-
-	msi_unlock_descs(dev);
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(msi_domain_get_virq);
 
@@ -998,9 +993,8 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 				  void *chip_data)
 {
 	struct irq_domain *domain, *parent = dev->msi.domain;
-	struct fwnode_handle *fwnode, *fwnalloced = NULL;
-	struct msi_domain_template *bundle;
 	const struct msi_parent_ops *pops;
+	struct fwnode_handle *fwnode;
 
 	if (!irq_domain_is_msi_parent(parent))
 		return false;
@@ -1008,7 +1002,8 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 	if (domid >= MSI_MAX_DEVICE_IRQDOMAINS)
 		return false;
 
-	bundle = kmemdup(template, sizeof(*bundle), GFP_KERNEL);
+	struct msi_domain_template *bundle __free(kfree) =
+		kmemdup(template, sizeof(*bundle), GFP_KERNEL);
 	if (!bundle)
 		return false;
 
@@ -1031,41 +1026,36 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 	 * node as they are not guaranteed to have a fwnode. They are never
 	 * looked up and always handled in the context of the device.
 	 */
-	if (bundle->info.flags & MSI_FLAG_USE_DEV_FWNODE)
-		fwnode = dev->fwnode;
+	struct fwnode_handle *fwnode_alloced __free(irq_domain_free_fwnode) = NULL;
+
+	if (!(bundle->info.flags & MSI_FLAG_USE_DEV_FWNODE))
+		fwnode = fwnode_alloced = irq_domain_alloc_named_fwnode(bundle->name);
 	else
-		fwnode = fwnalloced = irq_domain_alloc_named_fwnode(bundle->name);
+		fwnode = dev->fwnode;
 
 	if (!fwnode)
-		goto free_bundle;
+		return false;
 
 	if (msi_setup_device_data(dev))
-		goto free_fwnode;
-
-	msi_lock_descs(dev);
+		return false;
 
+	guard(msi_descs_lock)(dev);
 	if (WARN_ON_ONCE(msi_get_device_domain(dev, domid)))
-		goto fail;
+		return false;
 
 	if (!pops->init_dev_msi_info(dev, parent, parent, &bundle->info))
-		goto fail;
+		return false;
 
 	domain = __msi_create_irq_domain(fwnode, &bundle->info, IRQ_DOMAIN_FLAG_MSI_DEVICE, parent);
 	if (!domain)
-		goto fail;
+		return false;
 
+	/* @bundle and @fwnode_alloced are now in use. Prevent cleanup */
+	retain_and_null_ptr(bundle);
+	retain_and_null_ptr(fwnode_alloced);
 	domain->dev = dev;
 	dev->msi.data->__domains[domid].domain = domain;
-	msi_unlock_descs(dev);
 	return true;
-
-fail:
-	msi_unlock_descs(dev);
-free_fwnode:
-	irq_domain_free_fwnode(fwnalloced);
-free_bundle:
-	kfree(bundle);
-	return false;
 }
 
 /**
@@ -1079,12 +1069,10 @@ void msi_remove_device_irq_domain(struct device *dev, unsigned int domid)
 	struct msi_domain_info *info;
 	struct irq_domain *domain;
 
-	msi_lock_descs(dev);
-
+	guard(msi_descs_lock)(dev);
 	domain = msi_get_device_domain(dev, domid);
-
 	if (!domain || !irq_domain_is_msi_device(domain))
-		goto unlock;
+		return;
 
 	dev->msi.data->__domains[domid].domain = NULL;
 	info = domain->host_data;
@@ -1093,9 +1081,6 @@ void msi_remove_device_irq_domain(struct device *dev, unsigned int domid)
 	irq_domain_remove(domain);
 	irq_domain_free_fwnode(fwnode);
 	kfree(container_of(info, struct msi_domain_template, info));
-
-unlock:
-	msi_unlock_descs(dev);
 }
 
 /**
@@ -1111,16 +1096,14 @@ bool msi_match_device_irq_domain(struct device *dev, unsigned int domid,
 {
 	struct msi_domain_info *info;
 	struct irq_domain *domain;
-	bool ret = false;
 
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	domain = msi_get_device_domain(dev, domid);
 	if (domain && irq_domain_is_msi_device(domain)) {
 		info = domain->host_data;
-		ret = info->bus_token == bus_token;
+		return info->bus_token == bus_token;
 	}
-	msi_unlock_descs(dev);
-	return ret;
+	return false;
 }
 
 static int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
@@ -1391,12 +1374,9 @@ int msi_domain_alloc_irqs_range_locked(struct device *dev, unsigned int domid,
 int msi_domain_alloc_irqs_range(struct device *dev, unsigned int domid,
 				unsigned int first, unsigned int last)
 {
-	int ret;
 
-	msi_lock_descs(dev);
-	ret = msi_domain_alloc_irqs_range_locked(dev, domid, first, last);
-	msi_unlock_descs(dev);
-	return ret;
+	guard(msi_descs_lock)(dev);
+	return msi_domain_alloc_irqs_range_locked(dev, domid, first, last);
 }
 EXPORT_SYMBOL_GPL(msi_domain_alloc_irqs_range);
 
@@ -1500,12 +1480,8 @@ struct msi_map msi_domain_alloc_irq_at(struct device *dev, unsigned int domid, u
 				       const struct irq_affinity_desc *affdesc,
 				       union msi_instance_cookie *icookie)
 {
-	struct msi_map map;
-
-	msi_lock_descs(dev);
-	map = __msi_domain_alloc_irq_at(dev, domid, index, affdesc, icookie);
-	msi_unlock_descs(dev);
-	return map;
+	guard(msi_descs_lock)(dev);
+	return __msi_domain_alloc_irq_at(dev, domid, index, affdesc, icookie);
 }
 
 /**
@@ -1542,13 +1518,11 @@ int msi_device_domain_alloc_wired(struct irq_domain *domain, unsigned int hwirq,
 
 	icookie.value = ((u64)type << 32) | hwirq;
 
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	if (WARN_ON_ONCE(msi_get_device_domain(dev, domid) != domain))
 		map.index = -EINVAL;
 	else
 		map = __msi_domain_alloc_irq_at(dev, domid, MSI_ANY_INDEX, NULL, &icookie);
-	msi_unlock_descs(dev);
-
 	return map.index >= 0 ? map.virq : map.index;
 }
 
@@ -1641,9 +1615,8 @@ void msi_domain_free_irqs_range_locked(struct device *dev, unsigned int domid,
 void msi_domain_free_irqs_range(struct device *dev, unsigned int domid,
 				unsigned int first, unsigned int last)
 {
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	msi_domain_free_irqs_range_locked(dev, domid, first, last);
-	msi_unlock_descs(dev);
 }
 EXPORT_SYMBOL_GPL(msi_domain_free_irqs_all);
 
@@ -1673,9 +1646,8 @@ void msi_domain_free_irqs_all_locked(struct device *dev, unsigned int domid)
  */
 void msi_domain_free_irqs_all(struct device *dev, unsigned int domid)
 {
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	msi_domain_free_irqs_all_locked(dev, domid);
-	msi_unlock_descs(dev);
 }
 
 /**
@@ -1694,12 +1666,11 @@ void msi_device_domain_free_wired(struct irq_domain *domain, unsigned int virq)
 	if (WARN_ON_ONCE(!dev || !desc || domain->bus_token != DOMAIN_BUS_WIRED_TO_MSI))
 		return;
 
-	msi_lock_descs(dev);
-	if (!WARN_ON_ONCE(msi_get_device_domain(dev, MSI_DEFAULT_DOMAIN) != domain)) {
-		msi_domain_free_irqs_range_locked(dev, MSI_DEFAULT_DOMAIN, desc->msi_index,
-						  desc->msi_index);
-	}
-	msi_unlock_descs(dev);
+	guard(msi_descs_lock)(dev);
+	if (WARN_ON_ONCE(msi_get_device_domain(dev, MSI_DEFAULT_DOMAIN) != domain))
+		return;
+	msi_domain_free_irqs_range_locked(dev, MSI_DEFAULT_DOMAIN, desc->msi_index,
+					  desc->msi_index);
 }
 
 /**

