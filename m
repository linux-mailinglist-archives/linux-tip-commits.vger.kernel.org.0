Return-Path: <linux-tip-commits+bounces-4738-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E89A7E26A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 16:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF221443387
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 14:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682A71FDA8D;
	Mon,  7 Apr 2025 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RrFAU5EP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mgGWg26r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F1E1FCFD8;
	Mon,  7 Apr 2025 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036316; cv=none; b=GWtyWf9xtTPhZDeiuKMS5oapWeT1qOTT/H154AGekQzuE1DeoFVTRf1JzcFVx4eJfX/tKFjyABrPyztxl327v/3zfEjEZcakNVGZo2L0HMGVTl6HXb7wqvicyRoir8FjbEQcqYwQCjmeUjxcQbLlu+guaNYU6a+LUtlvqx2s5O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036316; c=relaxed/simple;
	bh=/ouzYE66Hutwaw2bm+ld6/qAG30ZkzqYfF3SDaUBPi0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZeCVFy/H2bkkMEILzAMisHk36ap+qPbSqaDprUcizYnzNgZJeeXYYxxhjUUrx/0CvuyTQcQWnHFzkarKDC5focb3AKJSmJ67S14UnRtp9BpTGDYlcn0mbx6iKUncrHyOm+MAVrS+udz54082C49AFKnT0aVcqhd9c0u6FIxxGFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RrFAU5EP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mgGWg26r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 14:31:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744036312;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MFrL1+Y/AiR+rASjr+5UFhRBSh8VfnXt6VKauKYcWhs=;
	b=RrFAU5EP+VwjodGiYjy5RxgzmBc6oRQC8VwZ66/oBsYka5r1cI629lGiKlMo7AskRZ95IY
	xfzs3iCBJmjJvQEv8pDgyDm4drdwZYYnhcCWpRncN/1N+2DLyTVIyTSqwbJCAXn/rH+uHS
	gHuWo0mtXz1HN6TQAxCEQVvlCB7kNJ1SJ+Y0qE13LsdrLZuf9mNUmqW/9jpKb2WYsRMmKR
	r9F0egzk1bIGAlO7oGQrfbSNFy9Hwe+17CZh5VGdxQdTfLIparLUZ7fP8+qOxLgJR7g1Lz
	kDH9OJaaCZje7IslaQ4a/um4Mf2vVwgBkyWJIUMP2jTV8d1TrtUzjy6bjjQe6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744036312;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MFrL1+Y/AiR+rASjr+5UFhRBSh8VfnXt6VKauKYcWhs=;
	b=mgGWg26rndrG8JHKUlBO665BZY5Eb2sJBIueZSO3NiiOD0zswUfXgoyWTfwyY9IhDtzqY1
	tcuZIAa2Qr8WOIBw==
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
Message-ID: <174403631132.31282.4429977734262276173.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     94362bb538aa446d760ee263ab4305738d78d18a
Gitweb:        https://git.kernel.org/tip/94362bb538aa446d760ee263ab4305738d78d18a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:56:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 16:24:55 +02:00

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
index 5c8d43c..1d30e47 100644
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
+	retain_ptr(bundle);
+	retain_ptr(fwnode_alloced);
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

