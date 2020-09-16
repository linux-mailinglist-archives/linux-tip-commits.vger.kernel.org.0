Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F88C26CDB8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 23:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgIPVEY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 17:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgIPQPB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 12:15:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8CCC0F26FE;
        Wed, 16 Sep 2020 08:17:11 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269128;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MhnqUreHN36Ar9kAK1vtHxIMZDtCcuJYzP5tLPLQmGU=;
        b=3BE9bN5hxElpvXfv2Qs3YcB+YWneKQcLbJi1BDFCh3gBocsyQwOgMN6IbTYnHSMW0jRDjt
        YM6BOUosBX7jjHE3U8FYK0pq/R8LgvpygbQ1AQ1x85CNFCMorK8WHRAz1TLWELgNBqHToM
        Pv8viKVPLtY0bcoqgEYIM+dQPDR30+soM/QkFVMvl6ga+e95Qsl1JM/12N5igVfDQfROeS
        Y0lSfhkeZEaqfKXErS0VVBJyTCfhZTKBQabyg+d6hn/FPLSoLVfCNeYCwEwq+dKF0ZRN0A
        1BgMa5utdpuQYZlvgQi64oeMIIH8qLLspPOnyzQJ26nZANiR4wfWYUkLPZZcUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269128;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MhnqUreHN36Ar9kAK1vtHxIMZDtCcuJYzP5tLPLQmGU=;
        b=WvaGIfoLpk8sQrlC3pdEoo7XuUepcq5u7gXqQk/U9CvGTXapF1uOuX2/oEvLRxaqzsNMxD
        4Gne5lV//5pGY4Bw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] iommm/vt-d: Store irq domain in struct device
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <jroedel@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112333.714566121@linutronix.de>
References: <20200826112333.714566121@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026912767.15536.12577758034412629542.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     85a8dfc57a0b96785881735e09a61a0fde911ca4
Gitweb:        https://git.kernel.org/tip/85a8dfc57a0b96785881735e09a61a0fde911ca4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:59 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:37 +02:00

iommm/vt-d: Store irq domain in struct device

As a first step to make X86 utilize the direct MSI irq domain operations
store the irq domain pointer in the device struct when a device is probed.

This is done from dmar_pci_bus_add_dev() because it has to work even when
DMA remapping is disabled. It only overrides the irqdomain of devices which
are handled by a regular PCI/MSI irq domain which protects PCI devices
behind special busses like VMD which have their own irq domain.

No functional change. It just avoids the redirection through
arch_*_msi_irqs() and allows the PCI/MSI core to directly invoke the irq
domain alloc/free functions instead of having to look up the irq domain for
every single MSI interupt.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20200826112333.714566121@linutronix.de

---
 drivers/iommu/intel/dmar.c          |  3 +++
 drivers/iommu/intel/irq_remapping.c | 16 ++++++++++++++++
 include/linux/intel-iommu.h         |  7 +++++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 93e6345..4dc09ed 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -316,6 +316,9 @@ static int dmar_pci_bus_add_dev(struct dmar_pci_notify_info *info)
 	if (ret < 0 && dmar_dev_scope_status == 0)
 		dmar_dev_scope_status = ret;
 
+	if (ret >= 0)
+		intel_irq_remap_add_device(info);
+
 	return ret;
 }
 
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index d9db2f3..68692a4 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1092,6 +1092,22 @@ error:
 	return -1;
 }
 
+/*
+ * Store the MSI remapping domain pointer in the device if enabled.
+ *
+ * This is called from dmar_pci_bus_add_dev() so it works even when DMA
+ * remapping is disabled. Only update the pointer if the device is not
+ * already handled by a non default PCI/MSI interrupt domain. This protects
+ * e.g. VMD devices.
+ */
+void intel_irq_remap_add_device(struct dmar_pci_notify_info *info)
+{
+	if (!irq_remapping_enabled || pci_dev_has_special_msi_domain(info->dev))
+		return;
+
+	dev_set_msi_domain(&info->dev->dev, map_dev_to_ir(info->dev));
+}
+
 static void prepare_irte(struct irte *irte, int vector, unsigned int dest)
 {
 	memset(irte, 0, sizeof(*irte));
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index b1ed2f2..46f5aaa 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -425,6 +425,8 @@ struct q_inval {
 	int             free_cnt;
 };
 
+struct dmar_pci_notify_info;
+
 #ifdef CONFIG_IRQ_REMAP
 /* 1MB - maximum possible interrupt remapping table size */
 #define INTR_REMAP_PAGE_ORDER	8
@@ -439,6 +441,11 @@ struct ir_table {
 	struct irte *base;
 	unsigned long *bitmap;
 };
+
+void intel_irq_remap_add_device(struct dmar_pci_notify_info *info);
+#else
+static inline void
+intel_irq_remap_add_device(struct dmar_pci_notify_info *info) { }
 #endif
 
 struct iommu_flush {
