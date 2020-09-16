Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A7326C584
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 19:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgIPRBX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 13:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgIPRAw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 13:00:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403BBC02C293;
        Wed, 16 Sep 2020 08:20:16 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pf0+ufXR0xc+j9jc48XVsAZnZZKWGa6q0O/P9Yz/b7k=;
        b=POtzbeV93GLe1QBN3WKeUgTo1oemCYCEZeJIBMwyM4STuL9V93XjoXrf620WhxnYcdLGV/
        zPwuWzlZ5Yfg+Dkl5Ew7RFyFM2nvqXq5NyO8xlxT2JfRtDPamI+kqk7jRuqwE5cp/1K507
        3BJOXtdSrGqzES4XLkyl8BRBrMAHmtYeF8cXhBgHAbSh8+YS2mbSt6Z1FDgwMcqi11YBT4
        nx8545YSNmuNIae+PDNLGDMC9x8AFpg14T5BAfzWr35hyXZTKbEU/6dPNC0PEw4hFydhn5
        GicYJ9OgFrUydRjAVl9ZNxboyRHw4TDW8Y7ptmJZ1p5t5ZGb1zbvzUvH00R07Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pf0+ufXR0xc+j9jc48XVsAZnZZKWGa6q0O/P9Yz/b7k=;
        b=3lZd1Jng/PQyfeT2UbvVV7l6WZsrKQfSIV6Z3kV/Zp0Xcy22Iurtp3FQFAH39i5ow5ECpS
        uHZA3tw0ArNXUBAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] iommm/amd: Store irq domain in struct device
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <jroedel@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112333.806328762@linutronix.de>
References: <20200826112333.806328762@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026912693.15536.9009617814481746173.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     2b2c6aa63824c69c112bbe4f937f034c5e606a6c
Gitweb:        https://git.kernel.org/tip/2b2c6aa63824c69c112bbe4f937f034c5e606a6c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:17:00 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:37 +02:00

iommm/amd: Store irq domain in struct device

As the next step to make X86 utilize the direct MSI irq domain operations
store the irq domain pointer in the device struct when a device is probed.

It only overrides the irqdomain of devices which are handled by a regular
PCI/MSI irq domain which protects PCI devices behind special busses like
VMD which have their own irq domain.

No functional change.

It just avoids the redirection through arch_*_msi_irqs() and allows the
PCI/MSI core to directly invoke the irq domain alloc/free functions instead
of having to look up the irq domain for every single MSI interupt.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Joerg Roedel <jroedel@suse.de>
Link: https://lore.kernel.org/r/20200826112333.806328762@linutronix.de


---
 drivers/iommu/amd/iommu.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index bc7bb4c..a9d8b32 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -729,7 +729,21 @@ static void iommu_poll_ga_log(struct amd_iommu *iommu)
 		}
 	}
 }
-#endif /* CONFIG_IRQ_REMAP */
+
+static void
+amd_iommu_set_pci_msi_domain(struct device *dev, struct amd_iommu *iommu)
+{
+	if (!irq_remapping_enabled || !dev_is_pci(dev) ||
+	    pci_dev_has_special_msi_domain(to_pci_dev(dev)))
+		return;
+
+	dev_set_msi_domain(dev, iommu->msi_domain);
+}
+
+#else /* CONFIG_IRQ_REMAP */
+static inline void
+amd_iommu_set_pci_msi_domain(struct device *dev, struct amd_iommu *iommu) { }
+#endif /* !CONFIG_IRQ_REMAP */
 
 #define AMD_IOMMU_INT_MASK	\
 	(MMIO_STATUS_EVT_INT_MASK | \
@@ -2157,6 +2171,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		iommu_dev = ERR_PTR(ret);
 		iommu_ignore_device(dev);
 	} else {
+		amd_iommu_set_pci_msi_domain(dev, iommu);
 		iommu_dev = &iommu->iommu;
 	}
 
