Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702B426CDF2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 23:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgIPVH1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 17:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgIPQOc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 12:14:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2852C02C280;
        Wed, 16 Sep 2020 08:17:11 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269132;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R1lwqRvewv6LCbirIr+fJtFrrYQE8EbwB/K+2ZEcYYI=;
        b=tJ0FqUE0EMohJ1m3GlQctful4vB6tGDUDvftdYY17aDzsgVuibEaM+oi90EInuxi3DJBTP
        HgX9kM7lQs4fntnJPJ12A0DPO/p+FB6wRIpg1X2kOnhXKi/mmZ24dNZLm0kYoWQ3tggEiY
        rpEQHF0AUS6JMfqKOqC/o2GCPX5yemohz3akVvJc2f6jimyN2KEeIyfA8rvBGboR+TE+UB
        DnbVaR3bnl+6jnhY9Od4qDC9AsFToPr7qwV1WBsuiygsAHVCaC9B8rEpbVOUFXpyrvUFby
        7omGVhGtwAmvowKJ7g3Waznlqa6SntwiCiSiGHRmQfdS00O0eqLjrfSZyBjz6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269132;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R1lwqRvewv6LCbirIr+fJtFrrYQE8EbwB/K+2ZEcYYI=;
        b=6N3Vlcc0/WMzY0rWocBAPJJxThCkf9zkIF0M6QLVpNE5pbi6UjW42LYUaMMV1g7HmWsizg
        2ylEcDJd4DZXivBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] PCI/MSI: Provide pci_dev_has_special_msi_domain() helper
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112333.139387358@linutronix.de>
References: <20200826112333.139387358@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026913201.15536.5464638795760154682.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     2fd602669ee6d749a7dc47b84b87cef1a5075999
Gitweb:        https://git.kernel.org/tip/2fd602669ee6d749a7dc47b84b87cef1a5075999
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:53 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:36 +02:00

PCI/MSI: Provide pci_dev_has_special_msi_domain() helper

Provide a helper function to check whether a PCI device is handled by a
non-standard PCI/MSI domain. This will be used to exclude such devices
which hang of a special bus, e.g. VMD, to be excluded from the irq domain
override in irq remapping.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20200826112333.139387358@linutronix.de

---
 drivers/pci/msi.c   | 22 ++++++++++++++++++++++
 include/linux/msi.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 744a1a4..a2f00d1 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1553,4 +1553,26 @@ struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 					     DOMAIN_BUS_PCI_MSI);
 	return dom;
 }
+
+/**
+ * pci_dev_has_special_msi_domain - Check whether the device is handled by
+ *				    a non-standard PCI-MSI domain
+ * @pdev:	The PCI device to check.
+ *
+ * Returns: True if the device irqdomain or the bus irqdomain is
+ * non-standard PCI/MSI.
+ */
+bool pci_dev_has_special_msi_domain(struct pci_dev *pdev)
+{
+	struct irq_domain *dom = dev_get_msi_domain(&pdev->dev);
+
+	if (!dom)
+		dom = dev_get_msi_domain(&pdev->bus->dev);
+
+	if (!dom)
+		return true;
+
+	return dom->bus_token != DOMAIN_BUS_PCI_MSI;
+}
+
 #endif /* CONFIG_PCI_MSI_IRQ_DOMAIN */
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 5aa126b..a65cc47 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -373,6 +373,7 @@ int pci_msi_domain_check_cap(struct irq_domain *domain,
 			     struct msi_domain_info *info, struct device *dev);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
+bool pci_dev_has_special_msi_domain(struct pci_dev *pdev);
 #else
 static inline struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)
 {
