Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D1F3F58D5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Aug 2021 09:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhHXHVP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Aug 2021 03:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbhHXHVP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Aug 2021 03:21:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F05C061757;
        Tue, 24 Aug 2021 00:20:31 -0700 (PDT)
Date:   Tue, 24 Aug 2021 07:20:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629789629;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nhKAR6SZ4H+nRzWl7kHYqwLY56GiV8DAx3tiOvS7RaI=;
        b=lP0lXoU233YQ67oCYrKcFvp+Q4bO3dJUYh8O6+PR02ZsvkeMEoHMnjOWtwLKIbaGaOkLlz
        b/mH8TQr5zZhGiIOHc0jbLjavT5W4oCkblZbHGMS2BWPJboIXrj01UnzCMLj6c6z71BJJc
        CJDBUG0SRu54eCP1V7RXPTkUo68aNNwDetOx3nrsVi5QaU18j9BgGVoqcLLSYymdUvTC3G
        xFjuyIkHmIZ6UiDUxAlFgv09YBWJv190qLyvAM/WhL4bqWzAMxyHJcRQUflOgTKqhNKA2w
        CLLACytXyKOmwBNy/HmiPpIh7+A6sfwaXEEXYSlBV+HhYinPXPQPhyutAECEfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629789629;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nhKAR6SZ4H+nRzWl7kHYqwLY56GiV8DAx3tiOvS7RaI=;
        b=EFtrasRAmKPdBBJTf5c7qFBKeJb8NS6PnwOQleWzxsDWhvxGAHptyOit3eiVVZSJnb76GB
        gt7h8ZVT/qyiDCCA==
From:   "tip-bot2 for Barry Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Move MSI sysfs handling from PCI to MSI core
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210813035628.6844-2-21cnbao@gmail.com>
References: <20210813035628.6844-2-21cnbao@gmail.com>
MIME-Version: 1.0
Message-ID: <162978962869.25758.3054083010161545639.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2f170814bdd26289e9daaa4ae359290f854e5dcf
Gitweb:        https://git.kernel.org/tip/2f170814bdd26289e9daaa4ae359290f854e5dcf
Author:        Barry Song <song.bao.hua@hisilicon.com>
AuthorDate:    Fri, 13 Aug 2021 15:56:27 +12:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 24 Aug 2021 09:16:20 +02:00

genirq/msi: Move MSI sysfs handling from PCI to MSI core

Move PCI's MSI sysfs code to the irq core so that other busses such as
platform can reuse it.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210813035628.6844-2-21cnbao@gmail.com

---
 drivers/pci/msi.c   | 125 +++-------------------------------------
 include/linux/msi.h |   4 +-
 kernel/irq/msi.c    | 134 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 148 insertions(+), 115 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index ce841f3..6eb0ae3 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -363,9 +363,7 @@ static void free_msi_irqs(struct pci_dev *dev)
 {
 	struct list_head *msi_list = dev_to_msi_list(&dev->dev);
 	struct msi_desc *entry, *tmp;
-	struct attribute **msi_attrs;
-	struct device_attribute *dev_attr;
-	int i, count = 0;
+	int i;
 
 	for_each_pci_msi_entry(entry, dev)
 		if (entry->irq)
@@ -385,18 +383,7 @@ static void free_msi_irqs(struct pci_dev *dev)
 	}
 
 	if (dev->msi_irq_groups) {
-		sysfs_remove_groups(&dev->dev.kobj, dev->msi_irq_groups);
-		msi_attrs = dev->msi_irq_groups[0]->attrs;
-		while (msi_attrs[count]) {
-			dev_attr = container_of(msi_attrs[count],
-						struct device_attribute, attr);
-			kfree(dev_attr->attr.name);
-			kfree(dev_attr);
-			++count;
-		}
-		kfree(msi_attrs);
-		kfree(dev->msi_irq_groups[0]);
-		kfree(dev->msi_irq_groups);
+		msi_destroy_sysfs(&dev->dev, dev->msi_irq_groups);
 		dev->msi_irq_groups = NULL;
 	}
 }
@@ -476,102 +463,6 @@ void pci_restore_msi_state(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_restore_msi_state);
 
-static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
-			     char *buf)
-{
-	struct msi_desc *entry;
-	unsigned long irq;
-	int retval;
-
-	retval = kstrtoul(attr->attr.name, 10, &irq);
-	if (retval)
-		return retval;
-
-	entry = irq_get_msi_desc(irq);
-	if (!entry)
-		return -ENODEV;
-
-	return sysfs_emit(buf, "%s\n",
-			  entry->msi_attrib.is_msix ? "msix" : "msi");
-}
-
-static int populate_msi_sysfs(struct pci_dev *pdev)
-{
-	struct attribute **msi_attrs;
-	struct attribute *msi_attr;
-	struct device_attribute *msi_dev_attr;
-	struct attribute_group *msi_irq_group;
-	const struct attribute_group **msi_irq_groups;
-	struct msi_desc *entry;
-	int ret = -ENOMEM;
-	int num_msi = 0;
-	int count = 0;
-	int i;
-
-	/* Determine how many msi entries we have */
-	for_each_pci_msi_entry(entry, pdev)
-		num_msi += entry->nvec_used;
-	if (!num_msi)
-		return 0;
-
-	/* Dynamically create the MSI attributes for the PCI device */
-	msi_attrs = kcalloc(num_msi + 1, sizeof(void *), GFP_KERNEL);
-	if (!msi_attrs)
-		return -ENOMEM;
-	for_each_pci_msi_entry(entry, pdev) {
-		for (i = 0; i < entry->nvec_used; i++) {
-			msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
-			if (!msi_dev_attr)
-				goto error_attrs;
-			msi_attrs[count] = &msi_dev_attr->attr;
-
-			sysfs_attr_init(&msi_dev_attr->attr);
-			msi_dev_attr->attr.name = kasprintf(GFP_KERNEL, "%d",
-							    entry->irq + i);
-			if (!msi_dev_attr->attr.name)
-				goto error_attrs;
-			msi_dev_attr->attr.mode = S_IRUGO;
-			msi_dev_attr->show = msi_mode_show;
-			++count;
-		}
-	}
-
-	msi_irq_group = kzalloc(sizeof(*msi_irq_group), GFP_KERNEL);
-	if (!msi_irq_group)
-		goto error_attrs;
-	msi_irq_group->name = "msi_irqs";
-	msi_irq_group->attrs = msi_attrs;
-
-	msi_irq_groups = kcalloc(2, sizeof(void *), GFP_KERNEL);
-	if (!msi_irq_groups)
-		goto error_irq_group;
-	msi_irq_groups[0] = msi_irq_group;
-
-	ret = sysfs_create_groups(&pdev->dev.kobj, msi_irq_groups);
-	if (ret)
-		goto error_irq_groups;
-	pdev->msi_irq_groups = msi_irq_groups;
-
-	return 0;
-
-error_irq_groups:
-	kfree(msi_irq_groups);
-error_irq_group:
-	kfree(msi_irq_group);
-error_attrs:
-	count = 0;
-	msi_attr = msi_attrs[count];
-	while (msi_attr) {
-		msi_dev_attr = container_of(msi_attr, struct device_attribute, attr);
-		kfree(msi_attr->name);
-		kfree(msi_dev_attr);
-		++count;
-		msi_attr = msi_attrs[count];
-	}
-	kfree(msi_attrs);
-	return ret;
-}
-
 static struct msi_desc *
 msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
 {
@@ -667,9 +558,11 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	if (ret)
 		goto err;
 
-	ret = populate_msi_sysfs(dev);
-	if (ret)
+	dev->msi_irq_groups = msi_populate_sysfs(&dev->dev);
+	if (IS_ERR(dev->msi_irq_groups)) {
+		ret = PTR_ERR(dev->msi_irq_groups);
 		goto err;
+	}
 
 	/* Set MSI enabled bits	*/
 	pci_intx_for_msi(dev, 0);
@@ -834,9 +727,11 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 
 	msix_update_entries(dev, entries);
 
-	ret = populate_msi_sysfs(dev);
-	if (ret)
+	dev->msi_irq_groups = msi_populate_sysfs(&dev->dev);
+	if (IS_ERR(dev->msi_irq_groups)) {
+		ret = PTR_ERR(dev->msi_irq_groups);
 		goto out_free;
+	}
 
 	/* Set MSI-X enabled bits and unmask the function */
 	pci_intx_for_msi(dev, 0);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index a20dc66..49cf6eb 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -239,6 +239,10 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void pci_msi_mask_irq(struct irq_data *data);
 void pci_msi_unmask_irq(struct irq_data *data);
 
+const struct attribute_group **msi_populate_sysfs(struct device *dev);
+void msi_destroy_sysfs(struct device *dev,
+		       const struct attribute_group **msi_irq_groups);
+
 /*
  * The arch hooks to setup up msi irqs. Default functions are implemented
  * as weak symbols so that they /can/ be overriden by architecture specific
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index bb18040..48ef144 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -14,6 +14,7 @@
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
 
 #include "internals.h"
 
@@ -71,6 +72,139 @@ void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)
 }
 EXPORT_SYMBOL_GPL(get_cached_msi_msg);
 
+static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct msi_desc *entry;
+	bool is_msix = false;
+	unsigned long irq;
+	int retval;
+
+	retval = kstrtoul(attr->attr.name, 10, &irq);
+	if (retval)
+		return retval;
+
+	entry = irq_get_msi_desc(irq);
+	if (!entry)
+		return -ENODEV;
+
+	if (dev_is_pci(dev))
+		is_msix = entry->msi_attrib.is_msix;
+
+	return sysfs_emit(buf, "%s\n", is_msix ? "msix" : "msi");
+}
+
+/**
+ * msi_populate_sysfs - Populate msi_irqs sysfs entries for devices
+ * @dev:	The device(PCI, platform etc) who will get sysfs entries
+ *
+ * Return attribute_group ** so that specific bus MSI can save it to
+ * somewhere during initilizing msi irqs. If devices has no MSI irq,
+ * return NULL; if it fails to populate sysfs, return ERR_PTR
+ */
+const struct attribute_group **msi_populate_sysfs(struct device *dev)
+{
+	const struct attribute_group **msi_irq_groups;
+	struct attribute **msi_attrs, *msi_attr;
+	struct device_attribute *msi_dev_attr;
+	struct attribute_group *msi_irq_group;
+	struct msi_desc *entry;
+	int ret = -ENOMEM;
+	int num_msi = 0;
+	int count = 0;
+	int i;
+
+	/* Determine how many msi entries we have */
+	for_each_msi_entry(entry, dev)
+		num_msi += entry->nvec_used;
+	if (!num_msi)
+		return NULL;
+
+	/* Dynamically create the MSI attributes for the device */
+	msi_attrs = kcalloc(num_msi + 1, sizeof(void *), GFP_KERNEL);
+	if (!msi_attrs)
+		return ERR_PTR(-ENOMEM);
+
+	for_each_msi_entry(entry, dev) {
+		for (i = 0; i < entry->nvec_used; i++) {
+			msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
+			if (!msi_dev_attr)
+				goto error_attrs;
+			msi_attrs[count] = &msi_dev_attr->attr;
+
+			sysfs_attr_init(&msi_dev_attr->attr);
+			msi_dev_attr->attr.name = kasprintf(GFP_KERNEL, "%d",
+							    entry->irq + i);
+			if (!msi_dev_attr->attr.name)
+				goto error_attrs;
+			msi_dev_attr->attr.mode = 0444;
+			msi_dev_attr->show = msi_mode_show;
+			++count;
+		}
+	}
+
+	msi_irq_group = kzalloc(sizeof(*msi_irq_group), GFP_KERNEL);
+	if (!msi_irq_group)
+		goto error_attrs;
+	msi_irq_group->name = "msi_irqs";
+	msi_irq_group->attrs = msi_attrs;
+
+	msi_irq_groups = kcalloc(2, sizeof(void *), GFP_KERNEL);
+	if (!msi_irq_groups)
+		goto error_irq_group;
+	msi_irq_groups[0] = msi_irq_group;
+
+	ret = sysfs_create_groups(&dev->kobj, msi_irq_groups);
+	if (ret)
+		goto error_irq_groups;
+
+	return msi_irq_groups;
+
+error_irq_groups:
+	kfree(msi_irq_groups);
+error_irq_group:
+	kfree(msi_irq_group);
+error_attrs:
+	count = 0;
+	msi_attr = msi_attrs[count];
+	while (msi_attr) {
+		msi_dev_attr = container_of(msi_attr, struct device_attribute, attr);
+		kfree(msi_attr->name);
+		kfree(msi_dev_attr);
+		++count;
+		msi_attr = msi_attrs[count];
+	}
+	kfree(msi_attrs);
+	return ERR_PTR(ret);
+}
+
+/**
+ * msi_destroy_sysfs - Destroy msi_irqs sysfs entries for devices
+ * @dev:		The device(PCI, platform etc) who will remove sysfs entries
+ * @msi_irq_groups:	attribute_group for device msi_irqs entries
+ */
+void msi_destroy_sysfs(struct device *dev, const struct attribute_group **msi_irq_groups)
+{
+	struct device_attribute *dev_attr;
+	struct attribute **msi_attrs;
+	int count = 0;
+
+	if (msi_irq_groups) {
+		sysfs_remove_groups(&dev->kobj, msi_irq_groups);
+		msi_attrs = msi_irq_groups[0]->attrs;
+		while (msi_attrs[count]) {
+			dev_attr = container_of(msi_attrs[count],
+					struct device_attribute, attr);
+			kfree(dev_attr->attr.name);
+			kfree(dev_attr);
+			++count;
+		}
+		kfree(msi_attrs);
+		kfree(msi_irq_groups[0]);
+		kfree(msi_irq_groups);
+	}
+}
+
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
 					  struct msi_msg *msg)
