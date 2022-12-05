Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFD464300D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Dec 2022 19:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbiLESZu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Dec 2022 13:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbiLESZU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441AD20F47;
        Mon,  5 Dec 2022 10:25:18 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264715;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZzramSJ3Nl2Npj1RQEnkCMLLkv9ysdzGJ0X/6cI+kaU=;
        b=DvkT7LCorgYM4a9tULM58ZfX9+Kmwid8o47YCDoQB8SsQ2vqaQkDPxw0vYX/+JUVpfpBOW
        9FshQDpD4YT6Hl9H1btDJMuHRW6MCCYiO5LMxMUhQo4hBNYOOh1A3P29duOKZ9Rg1EyNvi
        pFDMoldJI8qQmlgtI8ZFD7xqMfSJlxwsZCDu9oK8w5nWsP7Pcu4XF3s+2zRCh4bOek8nRb
        k9YoU/946pE7bCiD5wiSpM3D3yPp2shRjj0Uw2XVhZkqTBUOMPAuLum2PxXvajc2N+6BuM
        cqTobdkNDcZQ6pfdjSC7pfLivFZFZ3OR0QOCIZZZMnHTY02Ctqo18sdKLtO8uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264715;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZzramSJ3Nl2Npj1RQEnkCMLLkv9ysdzGJ0X/6cI+kaU=;
        b=Hm/lJpnQ+o6AA3wU2TW7o5VzhTC600Pm7gAK4LpY20W1bhdG7LyI4Q7F48Pb++S7V6C+XD
        wPYMgPg+tIfu6ECQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Add range checking to msi_insert_desc()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232325.798556374@linutronix.de>
References: <20221124232325.798556374@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471528.4906.10651447512750210855.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     02de943b0519c5940094ed8cd10d348a63ab0646
Gitweb:        https://git.kernel.org/tip/02de943b0519c5940094ed8cd10d348a63ab0646
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:25:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:02 +01:00

genirq/msi: Add range checking to msi_insert_desc()

Per device domains provide the real domain size to the core code. This
allows range checking on insertion of MSI descriptors and also paves the
way for dynamic index allocations which are required e.g. for IMS. This
avoids external mechanisms like bitmaps on the device side and just
utilizes the core internal MSI descriptor storxe for it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232325.798556374@linutronix.de

---
 kernel/irq/msi.c | 58 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 7449998..21a7452 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -40,6 +40,7 @@ struct msi_ctrl {
 #define MSI_XA_DOMAIN_SIZE	(MSI_MAX_INDEX + 1)
 
 static void msi_domain_free_locked(struct device *dev, struct msi_ctrl *ctrl);
+static unsigned int msi_domain_get_hwsize(struct device *dev, unsigned int domid);
 static inline int msi_sysfs_create_group(struct device *dev);
 
 
@@ -80,16 +81,28 @@ static void msi_free_desc(struct msi_desc *desc)
 	kfree(desc);
 }
 
-static int msi_insert_desc(struct msi_device_data *md, struct msi_desc *desc,
+static int msi_insert_desc(struct device *dev, struct msi_desc *desc,
 			   unsigned int domid, unsigned int index)
 {
+	struct msi_device_data *md = dev->msi.data;
 	struct xarray *xa = &md->__domains[domid].store;
+	unsigned int hwsize;
 	int ret;
 
+	hwsize = msi_domain_get_hwsize(dev, domid);
+	if (index >= hwsize) {
+		ret = -ERANGE;
+		goto fail;
+	}
+
 	desc->msi_index = index;
 	ret = xa_insert(xa, index, desc, GFP_KERNEL);
 	if (ret)
-		msi_free_desc(desc);
+		goto fail;
+	return 0;
+
+fail:
+	msi_free_desc(desc);
 	return ret;
 }
 
@@ -117,7 +130,7 @@ int msi_domain_insert_msi_desc(struct device *dev, unsigned int domid,
 	/* Copy type specific data to the new descriptor. */
 	desc->pci = init_desc->pci;
 
-	return msi_insert_desc(dev->msi.data, desc, domid, init_desc->msi_index);
+	return msi_insert_desc(dev, desc, domid, init_desc->msi_index);
 }
 
 static bool msi_desc_match(struct msi_desc *desc, enum msi_desc_filter filter)
@@ -136,11 +149,16 @@ static bool msi_desc_match(struct msi_desc *desc, enum msi_desc_filter filter)
 
 static bool msi_ctrl_valid(struct device *dev, struct msi_ctrl *ctrl)
 {
+	unsigned int hwsize;
+
 	if (WARN_ON_ONCE(ctrl->domid >= MSI_MAX_DEVICE_IRQDOMAINS ||
-			 !dev->msi.data->__domains[ctrl->domid].domain ||
-			 ctrl->first > ctrl->last ||
-			 ctrl->first > MSI_MAX_INDEX ||
-			 ctrl->last > MSI_MAX_INDEX))
+			 !dev->msi.data->__domains[ctrl->domid].domain))
+		return false;
+
+	hwsize = msi_domain_get_hwsize(dev, ctrl->domid);
+	if (WARN_ON_ONCE(ctrl->first > ctrl->last ||
+			 ctrl->first >= hwsize ||
+			 ctrl->last >= hwsize))
 		return false;
 	return true;
 }
@@ -208,7 +226,7 @@ static int msi_domain_add_simple_msi_descs(struct device *dev, struct msi_ctrl *
 		desc = msi_alloc_desc(dev, 1, NULL);
 		if (!desc)
 			goto fail_mem;
-		ret = msi_insert_desc(dev->msi.data, desc, ctrl->domid, idx);
+		ret = msi_insert_desc(dev, desc, ctrl->domid, idx);
 		if (ret)
 			goto fail;
 	}
@@ -406,7 +424,10 @@ unsigned int msi_domain_get_virq(struct device *dev, unsigned int domid, unsigne
 	if (!dev->msi.data)
 		return 0;
 
-	if (WARN_ON_ONCE(index > MSI_MAX_INDEX || domid >= MSI_MAX_DEVICE_IRQDOMAINS))
+	if (WARN_ON_ONCE(domid >= MSI_MAX_DEVICE_IRQDOMAINS))
+		return 0;
+
+	if (WARN_ON_ONCE(index >= msi_domain_get_hwsize(dev, domid)))
 		return 0;
 
 	/* This check is only valid for the PCI default MSI domain */
@@ -568,6 +589,20 @@ static struct irq_domain *msi_get_device_domain(struct device *dev, unsigned int
 	return domain;
 }
 
+static unsigned int msi_domain_get_hwsize(struct device *dev, unsigned int domid)
+{
+	struct msi_domain_info *info;
+	struct irq_domain *domain;
+
+	domain = msi_get_device_domain(dev, domid);
+	if (domain) {
+		info = domain->host_data;
+		return info->hwsize;
+	}
+	/* No domain, no size... */
+	return 0;
+}
+
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
 					  struct msi_msg *msg)
 {
@@ -1356,7 +1391,7 @@ int msi_domain_alloc_irqs_all_locked(struct device *dev, unsigned int domid, int
 	struct msi_ctrl ctrl = {
 		.domid	= domid,
 		.first	= 0,
-		.last	= MSI_MAX_INDEX,
+		.last	= msi_domain_get_hwsize(dev, domid) - 1,
 		.nirqs	= nirqs,
 	};
 
@@ -1470,7 +1505,8 @@ void msi_domain_free_irqs_range(struct device *dev, unsigned int domid,
  */
 void msi_domain_free_irqs_all_locked(struct device *dev, unsigned int domid)
 {
-	msi_domain_free_irqs_range_locked(dev, domid, 0, MSI_MAX_INDEX);
+	msi_domain_free_irqs_range_locked(dev, domid, 0,
+					  msi_domain_get_hwsize(dev, domid) - 1);
 }
 
 /**
