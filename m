Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CCA2B443A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Nov 2020 14:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgKPNAd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 16 Nov 2020 08:00:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41132 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbgKPNAb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 16 Nov 2020 08:00:31 -0500
Date:   Mon, 16 Nov 2020 13:00:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605531629;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZQB4z5SJCFwv0sltJnh6bHxyGxDGFsleI6cb+qIZBOw=;
        b=fG4HWmZFtfuIT8R5Z/CrDCGPCuurlYklhRzlfN504WjDZPAP/w4MxEQkDs47MqK4YICVaF
        IeVK2qA/t+pKISKL8MASjN62awqdcGMi4gTbbkrq5WvUMSPbXlZ5SzYjfqxqG9CKlzudre
        2KaY71cV54tWJghsdARn0V0qkTlc5sClBSRDvAkycGK7NtbX2qsbEplY/h+2x2ImQa7wE2
        qRwUhpRvuMSnwwGBTx4mcjAj6IcHllUzdMXjJjFiJGB/+O6IgT/HF+T0m3kX45UI4F7qak
        SgdAsJXJj795qRPpPBvvk8MqCGto4wDbpH9aFvWVIGzWM3ImIzl4VeNIEZIxnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605531629;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZQB4z5SJCFwv0sltJnh6bHxyGxDGFsleI6cb+qIZBOw=;
        b=BT+hqxYByovNK3aZW9A4wRMdyRsH9DfAKQsc3mhmFXTpHiP17BRIIE4VXyrtnU7jCNZi/w
        crKYsSbISm8mBbBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] iommu/vt-d: Take CONFIG_PCI_ATS into account
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160553162825.11244.6542099673312045530.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     8986f223bd777a73119f5d593c15b4d630ff49bb
Gitweb:        https://git.kernel.org/tip/8986f223bd777a73119f5d593c15b4d630ff49bb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 16 Nov 2020 13:52:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 16 Nov 2020 13:57:46 +01:00

iommu/vt-d: Take CONFIG_PCI_ATS into account

pci_dev::physfn is only available when CONFIG_PCI_ATS is set. The recent
fix for the irqdomain rework missed that dependency which makes the build
fail when CONFIG_PCI_ATS=n.

Add the necessary #ifdeffery.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: ff828729be44 ("iommu/vt-d: Cure VF irqdomain hickup")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Joerg Roedel <joro@8bytes.org>
---
 drivers/iommu/intel/dmar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index b2e8044..bc9f4cf 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -335,7 +335,9 @@ static void  dmar_pci_bus_del_dev(struct dmar_pci_notify_info *info)
 
 static inline void vf_inherit_msi_domain(struct pci_dev *pdev)
 {
+#ifdef CONFIG_PCI_ATS
 	dev_set_msi_domain(&pdev->dev, dev_get_msi_domain(&pdev->physfn->dev));
+#endif
 }
 
 static int dmar_pci_bus_notifier(struct notifier_block *nb,
