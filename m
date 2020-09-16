Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572FA26CDF4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 23:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgIPVH2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 17:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgIPQOc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 12:14:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92229C02C284;
        Wed, 16 Sep 2020 08:17:14 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269137;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+mxXrbRmLlMeFZaiJwNbEQl2WnrqcG55+nDnbSbhGnA=;
        b=NVV5a/qnUkWGAtvaNNNqx01V8T81OvMop3+82blhLzOJtZyFHbZgIvoIh6U8LI+6Oi/Np6
        jxyj8LkNyFZ5gISdXVyqKEmzhwfV9/LFoqjYCrNSReXQD4kbgv3S6KFGTzgAGXpI+0sx1p
        ttF39UI960nPxUyJUd1bxNRBwypwXM/Sc6Q6LgFYYHyLN3OI48EtMO61HLZUD+xJXeaABV
        Nho6AcijtQUSXTP6/+MGx8GMkIn102EzZbcD3IZnt3qLHEdBLJUbn8yzWPltrNC/Rsiv0Z
        beTxv4P12qMivcxFIGZ6t4/CNwzU3iKlZqqPpzh8T2Oku2SaQrVoM/OIIx21Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269137;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+mxXrbRmLlMeFZaiJwNbEQl2WnrqcG55+nDnbSbhGnA=;
        b=LbOyuXkgUQihK1SeNJVxKfzIPBC93Tc933LZd2zPyKUT4JuVQeLg+bpADmHo6cY9NzEfhY
        4+GPawsWIDKGxZCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/msi: Use generic MSI domain ops
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112332.564274859@linutronix.de>
References: <20200826112332.564274859@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026913665.15536.15666831846621125410.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     9006c133a422f474d7d8e10a8baae179f70c22f5
Gitweb:        https://git.kernel.org/tip/9006c133a422f474d7d8e10a8baae179f70c22f5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:47 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:35 +02:00

x86/msi: Use generic MSI domain ops

pci_msi_get_hwirq() and pci_msi_set_desc are not longer special. Enable the
generic MSI domain ops in the core and PCI MSI code unconditionally and get
rid of the x86 specific implementations in the X86 MSI code and in the
hyperv PCI driver.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200826112332.564274859@linutronix.de

---
 arch/x86/include/asm/msi.h          |  2 +--
 arch/x86/kernel/apic/msi.c          | 30 +----------------------------
 drivers/pci/controller/pci-hyperv.c |  8 +-------
 drivers/pci/msi.c                   |  6 +-----
 include/linux/msi.h                 |  1 +-
 kernel/irq/msi.c                    |  6 +------
 6 files changed, 2 insertions(+), 51 deletions(-)

diff --git a/arch/x86/include/asm/msi.h b/arch/x86/include/asm/msi.h
index 25ddd09..cd30013 100644
--- a/arch/x86/include/asm/msi.h
+++ b/arch/x86/include/asm/msi.h
@@ -9,6 +9,4 @@ typedef struct irq_alloc_info msi_alloc_info_t;
 int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 		    msi_alloc_info_t *arg);
 
-void pci_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc);
-
 #endif /* _ASM_X86_MSI_H */
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 6b490d9..378c692 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -203,12 +203,6 @@ void native_teardown_msi_irq(unsigned int irq)
 	irq_domain_free_irqs(irq, 1);
 }
 
-static irq_hw_number_t pci_msi_get_hwirq(struct msi_domain_info *info,
-					 msi_alloc_info_t *arg)
-{
-	return arg->hwirq;
-}
-
 int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 		    msi_alloc_info_t *arg)
 {
@@ -227,17 +221,8 @@ int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 }
 EXPORT_SYMBOL_GPL(pci_msi_prepare);
 
-void pci_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
-{
-	arg->desc = desc;
-	arg->hwirq = pci_msi_domain_calc_hwirq(desc);
-}
-EXPORT_SYMBOL_GPL(pci_msi_set_desc);
-
 static struct msi_domain_ops pci_msi_domain_ops = {
-	.get_hwirq	= pci_msi_get_hwirq,
 	.msi_prepare	= pci_msi_prepare,
-	.set_desc	= pci_msi_set_desc,
 };
 
 static struct msi_domain_info pci_msi_domain_info = {
@@ -322,12 +307,6 @@ static struct irq_chip dmar_msi_controller = {
 	.flags			= IRQCHIP_SKIP_SET_WAKE,
 };
 
-static irq_hw_number_t dmar_msi_get_hwirq(struct msi_domain_info *info,
-					  msi_alloc_info_t *arg)
-{
-	return arg->hwirq;
-}
-
 static int dmar_msi_init(struct irq_domain *domain,
 			 struct msi_domain_info *info, unsigned int virq,
 			 irq_hw_number_t hwirq, msi_alloc_info_t *arg)
@@ -339,7 +318,6 @@ static int dmar_msi_init(struct irq_domain *domain,
 }
 
 static struct msi_domain_ops dmar_msi_domain_ops = {
-	.get_hwirq	= dmar_msi_get_hwirq,
 	.msi_init	= dmar_msi_init,
 };
 
@@ -381,6 +359,7 @@ int dmar_alloc_hwirq(int id, int node, void *arg)
 	init_irq_alloc_info(&info, NULL);
 	info.type = X86_IRQ_ALLOC_TYPE_DMAR;
 	info.devid = id;
+	info.hwirq = id;
 	info.data = arg;
 
 	return irq_domain_alloc_irqs(domain, 1, node, &info);
@@ -419,12 +398,6 @@ static struct irq_chip hpet_msi_controller __ro_after_init = {
 	.flags = IRQCHIP_SKIP_SET_WAKE,
 };
 
-static irq_hw_number_t hpet_msi_get_hwirq(struct msi_domain_info *info,
-					  msi_alloc_info_t *arg)
-{
-	return arg->hwirq;
-}
-
 static int hpet_msi_init(struct irq_domain *domain,
 			 struct msi_domain_info *info, unsigned int virq,
 			 irq_hw_number_t hwirq, msi_alloc_info_t *arg)
@@ -443,7 +416,6 @@ static void hpet_msi_free(struct irq_domain *domain,
 }
 
 static struct msi_domain_ops hpet_msi_domain_ops = {
-	.get_hwirq	= hpet_msi_get_hwirq,
 	.msi_init	= hpet_msi_init,
 	.msi_free	= hpet_msi_free,
 };
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index f6cc49b..25b4c90 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1531,16 +1531,8 @@ static struct irq_chip hv_msi_irq_chip = {
 	.irq_unmask		= hv_irq_unmask,
 };
 
-static irq_hw_number_t hv_msi_domain_ops_get_hwirq(struct msi_domain_info *info,
-						   msi_alloc_info_t *arg)
-{
-	return arg->hwirq;
-}
-
 static struct msi_domain_ops hv_msi_ops = {
-	.get_hwirq	= hv_msi_domain_ops_get_hwirq,
 	.msi_prepare	= pci_msi_prepare,
-	.set_desc	= pci_msi_set_desc,
 	.msi_free	= hv_msi_free,
 };
 
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 9af58a2..744a1a4 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1350,7 +1350,7 @@ void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg)
  *
  * The ID number is only used within the irqdomain.
  */
-irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
+static irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
 {
 	struct pci_dev *dev = msi_desc_to_pci_dev(desc);
 
@@ -1401,16 +1401,12 @@ static int pci_msi_domain_handle_error(struct irq_domain *domain,
 	return error;
 }
 
-#ifdef GENERIC_MSI_DOMAIN_OPS
 static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,
 				    struct msi_desc *desc)
 {
 	arg->desc = desc;
 	arg->hwirq = pci_msi_domain_calc_hwirq(desc);
 }
-#else
-#define pci_msi_domain_set_desc		NULL
-#endif
 
 static struct msi_domain_ops pci_msi_domain_ops_default = {
 	.set_desc	= pci_msi_domain_set_desc,
diff --git a/include/linux/msi.h b/include/linux/msi.h
index d360cc7..5aa126b 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -369,7 +369,6 @@ void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg);
 struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 					     struct msi_domain_info *info,
 					     struct irq_domain *parent);
-irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc);
 int pci_msi_domain_check_cap(struct irq_domain *domain,
 			     struct msi_domain_info *info, struct device *dev);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index eb95f61..640668e 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -187,7 +187,6 @@ static const struct irq_domain_ops msi_domain_ops = {
 	.deactivate	= msi_domain_deactivate,
 };
 
-#ifdef GENERIC_MSI_DOMAIN_OPS
 static irq_hw_number_t msi_domain_ops_get_hwirq(struct msi_domain_info *info,
 						msi_alloc_info_t *arg)
 {
@@ -206,11 +205,6 @@ static void msi_domain_ops_set_desc(msi_alloc_info_t *arg,
 {
 	arg->desc = desc;
 }
-#else
-#define msi_domain_ops_get_hwirq	NULL
-#define msi_domain_ops_prepare		NULL
-#define msi_domain_ops_set_desc		NULL
-#endif /* !GENERIC_MSI_DOMAIN_OPS */
 
 static int msi_domain_ops_init(struct irq_domain *domain,
 			       struct msi_domain_info *info,
