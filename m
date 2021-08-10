Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB323E5641
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 11:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238635AbhHJJIK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 05:08:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41866 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238593AbhHJJIH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 05:08:07 -0400
Date:   Tue, 10 Aug 2021 09:07:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628586460;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vDaqfRRpR+0S47HuskjhfHlL7PcvK8EfMSk+0Vjb29Y=;
        b=QIrxir31qX2dr2u/uDtoZZ9bPdMnJfxzRjPirIzBf7EwJLmgJWWu52s5HYBX/W7qDpqeTL
        /j2IFWMPSoYoZemLa05UdAbr8zBSP0c4f5KTC+a0JT6yIyE1c6E+DgmgAZjKkscrgBj74r
        FgJgwo/cbOLShLnF3MthzU2NFLNPFkLeJ3o7GR/dq6N7aEXUitu72c9XjHcCPlcqFjqVOn
        qYL0f5zNQRyZNNSf1RBYrcwEZ0lG3XXdgT+6S2gURNkK1gwGluLGa5xlr3ARVJkxAaPjrv
        Y442UrVgjur54um0pmJr+8sYQRZotPrTZw2JpjO/6VUMRqidUCNw5Otq8y3row==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628586460;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vDaqfRRpR+0S47HuskjhfHlL7PcvK8EfMSk+0Vjb29Y=;
        b=rAFbnJSeZ6MyHr+hAPXvWR3LMxpaKhaw5780pGZQnpBlWPNH76bq8haqmYX1Clm2Jb6MvI
        a+2iu/Bha2u+OBCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Consolidate error handling in msi_capability_init()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210729222543.098828720@linutronix.de>
References: <20210729222543.098828720@linutronix.de>
MIME-Version: 1.0
Message-ID: <162858645993.395.16701531835157713256.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     8eb5ce3f78a5e5d3f1a12248f6b7dc64ebf71da6
Gitweb:        https://git.kernel.org/tip/8eb5ce3f78a5e5d3f1a12248f6b7dc64ebf71da6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 29 Jul 2021 23:51:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 11:03:29 +02:00

PCI/MSI: Consolidate error handling in msi_capability_init()

Three error exits doing exactly the same ask for a common error exit point.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210729222543.098828720@linutronix.de

---
 drivers/pci/msi.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 175f4d6..d2821bb 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -659,25 +659,16 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 
 	/* Configure MSI capability structure */
 	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
-	if (ret) {
-		msi_mask_irq(entry, mask, 0);
-		free_msi_irqs(dev);
-		return ret;
-	}
+	if (ret)
+		goto err;
 
 	ret = msi_verify_entries(dev);
-	if (ret) {
-		msi_mask_irq(entry, mask, 0);
-		free_msi_irqs(dev);
-		return ret;
-	}
+	if (ret)
+		goto err;
 
 	ret = populate_msi_sysfs(dev);
-	if (ret) {
-		msi_mask_irq(entry, mask, 0);
-		free_msi_irqs(dev);
-		return ret;
-	}
+	if (ret)
+		goto err;
 
 	/* Set MSI enabled bits	*/
 	pci_intx_for_msi(dev, 0);
@@ -687,6 +678,11 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	pcibios_free_irq(dev);
 	dev->irq = entry->irq;
 	return 0;
+
+err:
+	msi_mask_irq(entry, mask, 0);
+	free_msi_irqs(dev);
+	return ret;
 }
 
 static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
