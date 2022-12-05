Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B55643711
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Dec 2022 22:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbiLEVmL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Dec 2022 16:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbiLEVlz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Dec 2022 16:41:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9F82CCA5;
        Mon,  5 Dec 2022 13:41:54 -0800 (PST)
Date:   Mon, 05 Dec 2022 21:41:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670276509;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5rS8+vlUKDBD9RrE6HLz8pluTkjobXEvrl2TRKFFiYY=;
        b=QE3jTonCTFmiW/xf0JShBbepCN0AhYZAlh/u3qKwJyMqMAUOn+xMYnKmfxcy3OAXH2FcYX
        Wp3YWU1Te9LVgYlB3bRCQx1Domd8twOhACV5EtCM/ovF+0UQWd8cjB30fmZN9pnKfO0XPq
        JYoE8e6wUA6Aj8YguBsmcrBoBhO2jlpMvIVv3kth8SAxYHDF9UvTWO3k1sgFlYdi8vVUTs
        fgmnWNF8I1IHT+yhHz96hLUs7J4Bua/3Zl+t7EU2Lo9jBPxDddZ1kytOT2Y6W93ZeAM5mA
        S8M33WoB03zd7px/458Ah3PBIS/YLSGxd6Z2e3gkul6aznc5Y7kCT0pBXeG44A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670276509;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5rS8+vlUKDBD9RrE6HLz8pluTkjobXEvrl2TRKFFiYY=;
        b=V9DW0wCHH0WpI7w2QFo68xSj+5lMdrQtziWhMH/dTpXQlF/nJYtdAWm5Zh83Ulp1Q/4vWt
        qbGCTq9BwfqWuABQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] iommu/vt-d: Switch to MSI parent domains
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232326.151226317@linutronix.de>
References: <20221124232326.151226317@linutronix.de>
MIME-Version: 1.0
Message-ID: <167027650901.4906.12930732522569831480.tip-bot2@tip-bot2>
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

Commit-ID:     9a945234abea27d45f8d89e1a1b35ab5bf41dd01
Gitweb:        https://git.kernel.org/tip/9a945234abea27d45f8d89e1a1b35ab5bf41dd01
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:08 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 22:22:33 +01:00

iommu/vt-d: Switch to MSI parent domains

Remove the global PCI/MSI irqdomain implementation and provide the required
MSI parent ops so the PCI/MSI code can detect the new parent and setup per
device domains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232326.151226317@linutronix.de

---
 arch/x86/kernel/apic/msi.c          |  2 ++
 drivers/iommu/intel/iommu.h         |  1 -
 drivers/iommu/intel/irq_remapping.c | 27 ++++++++++++---------------
 include/linux/irqdomain_defs.h      |  1 +
 4 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index db96bfc..a8dccb0 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -217,6 +217,8 @@ static bool x86_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 		/* See msi_set_affinity() for the gory details */
 		info->flags |= MSI_FLAG_NOMASK_QUIRK;
 		break;
+	case DOMAIN_BUS_DMAR:
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return false;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 92023df..6eadb86 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -600,7 +600,6 @@ struct intel_iommu {
 #ifdef CONFIG_IRQ_REMAP
 	struct ir_table *ir_table;	/* Interrupt remapping info */
 	struct irq_domain *ir_domain;
-	struct irq_domain *ir_msi_domain;
 #endif
 	struct iommu_device iommu;  /* IOMMU core code handle */
 	int		node;
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 08bbf08..6fab407 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -82,6 +82,7 @@ static const struct irq_domain_ops intel_ir_domain_ops;
 
 static void iommu_disable_irq_remapping(struct intel_iommu *iommu);
 static int __init parse_ioapics_under_ir(void);
+static const struct msi_parent_ops dmar_msi_parent_ops;
 
 static bool ir_pre_enabled(struct intel_iommu *iommu)
 {
@@ -230,7 +231,7 @@ static struct irq_domain *map_dev_to_ir(struct pci_dev *dev)
 {
 	struct dmar_drhd_unit *drhd = dmar_find_matched_drhd_unit(dev);
 
-	return drhd ? drhd->iommu->ir_msi_domain : NULL;
+	return drhd ? drhd->iommu->ir_domain : NULL;
 }
 
 static int clear_entries(struct irq_2_iommu *irq_iommu)
@@ -573,10 +574,10 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 		pr_err("IR%d: failed to allocate irqdomain\n", iommu->seq_id);
 		goto out_free_fwnode;
 	}
-	iommu->ir_msi_domain =
-		arch_create_remap_msi_irq_domain(iommu->ir_domain,
-						 "INTEL-IR-MSI",
-						 iommu->seq_id);
+
+	irq_domain_update_bus_token(iommu->ir_domain,  DOMAIN_BUS_DMAR);
+	iommu->ir_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	iommu->ir_domain->msi_parent_ops = &dmar_msi_parent_ops;
 
 	ir_table->base = page_address(pages);
 	ir_table->bitmap = bitmap;
@@ -620,9 +621,6 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 	return 0;
 
 out_free_ir_domain:
-	if (iommu->ir_msi_domain)
-		irq_domain_remove(iommu->ir_msi_domain);
-	iommu->ir_msi_domain = NULL;
 	irq_domain_remove(iommu->ir_domain);
 	iommu->ir_domain = NULL;
 out_free_fwnode:
@@ -644,13 +642,6 @@ static void intel_teardown_irq_remapping(struct intel_iommu *iommu)
 	struct fwnode_handle *fn;
 
 	if (iommu && iommu->ir_table) {
-		if (iommu->ir_msi_domain) {
-			fn = iommu->ir_msi_domain->fwnode;
-
-			irq_domain_remove(iommu->ir_msi_domain);
-			irq_domain_free_fwnode(fn);
-			iommu->ir_msi_domain = NULL;
-		}
 		if (iommu->ir_domain) {
 			fn = iommu->ir_domain->fwnode;
 
@@ -1437,6 +1428,12 @@ static const struct irq_domain_ops intel_ir_domain_ops = {
 	.deactivate = intel_irq_remapping_deactivate,
 };
 
+static const struct msi_parent_ops dmar_msi_parent_ops = {
+	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED | MSI_FLAG_MULTI_PCI_MSI,
+	.prefix			= "IR-",
+	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
+};
+
 /*
  * Support of Interrupt Remapping Unit Hotplug
  */
diff --git a/include/linux/irqdomain_defs.h b/include/linux/irqdomain_defs.h
index b3f4b7e..3a09396 100644
--- a/include/linux/irqdomain_defs.h
+++ b/include/linux/irqdomain_defs.h
@@ -23,6 +23,7 @@ enum irq_domain_bus_token {
 	DOMAIN_BUS_VMD_MSI,
 	DOMAIN_BUS_PCI_DEVICE_MSI,
 	DOMAIN_BUS_PCI_DEVICE_MSIX,
+	DOMAIN_BUS_DMAR,
 };
 
 #endif /* _LINUX_IRQDOMAIN_DEFS_H */
