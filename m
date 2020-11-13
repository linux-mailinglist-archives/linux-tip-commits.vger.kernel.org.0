Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A092B199C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Nov 2020 12:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgKMLHi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 13 Nov 2020 06:07:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51146 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgKMLFv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 13 Nov 2020 06:05:51 -0500
Date:   Fri, 13 Nov 2020 11:05:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605265519;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OHvVnWfC04H6CLgb0PcgeRfpxqIseC1sFZpzGiGgfSs=;
        b=lvD6TwiQwMKLJ/SSJGTf/6+DeL7VgLaXyoVpx4SH/R0m+wYoAftbpThguQvCQD/9MBP2es
        Jr0yogZkEcVkkGY3npvTPbtBgzLlr8jC6H8aiMsHNQj5NKWAQCmJ19WBOvbIl1AXqRaVSg
        M001wNrqDvNsVcLv/qnAYyyshWLgI2C+oWNzVMVFQs+lOwlpgTfsDcP/VU+XTCmvU4LDv/
        t4tHbd2tZGLU+GoJ8tiUMpTc54K7LMz01iyv2axL3lK7BQDm8AqUNFn4ZW2dCAAJvISCQ8
        xMVGEjF2NkqadVQ/YJG+kXdxW8FU0MgfBeCmUYzj8yfG0vsFzDNVquuscoYXuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605265519;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OHvVnWfC04H6CLgb0PcgeRfpxqIseC1sFZpzGiGgfSs=;
        b=QQdN5VKz7Wu/YrIgQnTmRrGh8bd26ZDDi1mOgWDSKsr5q3frXdgXt+Qri3DZlVKE21mmgW
        G4yHaawi7FDFT/BQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] iommu/vt-d: Cure VF irqdomain hickup
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <draft-87eekymlpz.fsf@nanos.tec.linutronix.de>
References: <draft-87eekymlpz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <160526551813.11244.15704259493221193953.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ff828729be446b86957f7c294068758231cd2183
Gitweb:        https://git.kernel.org/tip/ff828729be446b86957f7c294068758231cd2183
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 12 Nov 2020 20:14:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 13 Nov 2020 12:00:40 +01:00

iommu/vt-d: Cure VF irqdomain hickup

The recent changes to store the MSI irqdomain pointer in struct device
missed that Intel DMAR does not register virtual function devices.  Due to
that a VF device gets the plain PCI-MSI domain assigned and then issues
compat MSI messages which get caught by the interrupt remapping unit.

Cure that by inheriting the irq domain from the physical function
device.

Ideally the irqdomain would be associated to the bus, but DMAR can have
multiple units and therefore irqdomains on a single bus. The VF 'bus' could
of course inherit the domain from the PF, but that'd be yet another x86
oddity.

Fixes: 85a8dfc57a0b ("iommm/vt-d: Store irq domain in struct device")
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Link: https://lore.kernel.org/r/draft-87eekymlpz.fsf@nanos.tec.linutronix.de

---
 drivers/iommu/intel/dmar.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 404b40a..b2e8044 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -333,6 +333,11 @@ static void  dmar_pci_bus_del_dev(struct dmar_pci_notify_info *info)
 	dmar_iommu_notify_scope_dev(info);
 }
 
+static inline void vf_inherit_msi_domain(struct pci_dev *pdev)
+{
+	dev_set_msi_domain(&pdev->dev, dev_get_msi_domain(&pdev->physfn->dev));
+}
+
 static int dmar_pci_bus_notifier(struct notifier_block *nb,
 				 unsigned long action, void *data)
 {
@@ -342,8 +347,20 @@ static int dmar_pci_bus_notifier(struct notifier_block *nb,
 	/* Only care about add/remove events for physical functions.
 	 * For VFs we actually do the lookup based on the corresponding
 	 * PF in device_to_iommu() anyway. */
-	if (pdev->is_virtfn)
+	if (pdev->is_virtfn) {
+		/*
+		 * Ensure that the VF device inherits the irq domain of the
+		 * PF device. Ideally the device would inherit the domain
+		 * from the bus, but DMAR can have multiple units per bus
+		 * which makes this impossible. The VF 'bus' could inherit
+		 * from the PF device, but that's yet another x86'sism to
+		 * inflict on everybody else.
+		 */
+		if (action == BUS_NOTIFY_ADD_DEVICE)
+			vf_inherit_msi_domain(pdev);
 		return NOTIFY_DONE;
+	}
+
 	if (action != BUS_NOTIFY_ADD_DEVICE &&
 	    action != BUS_NOTIFY_REMOVED_DEVICE)
 		return NOTIFY_DONE;
