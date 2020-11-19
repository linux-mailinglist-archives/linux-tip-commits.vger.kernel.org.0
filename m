Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FF22B943E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Nov 2020 15:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgKSOL1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Nov 2020 09:11:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33924 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgKSOL1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Nov 2020 09:11:27 -0500
Date:   Thu, 19 Nov 2020 14:11:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605795085;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=89d7ZJaF7pnvcbLn3J9G5ZQr0ETffcBle9DSyQEptCI=;
        b=tz6GiTRax3AwgsO2kFOrDcqPEwwRsPAGEWZBawINaQR0LvcFHEhxRcJ+ypUAJxlTb/slTY
        WrrQnC2+JTN3ZIx2OBOaRImFyebJPy9rCv+DK5/mpCBAG/kPQXZMdoAxGxk1pnFeT8YrvC
        H4AYreG+ygtsOX8e42sOdAeLU1zk2gSmgjs1TS1uMuR+bMb5U6zGn4B+1+SoZFEsyXRDoX
        7Uu5GcyBerXhh57dnGymt+DcL4bd6szhLBEt4w54+DEEh+ETzI5sFhHwS9BI6+2FkP83wy
        XwGOA8axcaSvXjKClO4u8l+HDjEsj2JAD6kV42325duiMbtIMSBE5eaJMFytCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605795085;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=89d7ZJaF7pnvcbLn3J9G5ZQr0ETffcBle9DSyQEptCI=;
        b=Y5Vcot1faXh9ksonnLUpfECllPc8Vfbfe3+vVlEPs64UI9UdeD/1/oShkkGyk8Ow5ikRWV
        LGLOa5wxaHSXdVBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] Revert "iommu/vt-d: Take CONFIG_PCI_ATS into account"
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160579508426.11244.11703072141893252572.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     01cf158e48d2b5ce947430de5896c10f4f7c1822
Gitweb:        https://git.kernel.org/tip/01cf158e48d2b5ce947430de5896c10f4f7c1822
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 19 Nov 2020 15:07:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Nov 2020 15:07:19 +01:00

Revert "iommu/vt-d: Take CONFIG_PCI_ATS into account"

This reverts commit 8986f223bd777a73119f5d593c15b4d630ff49bb.

The proper fix is queued in Will's tree now

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/iommu/intel/dmar.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index bc9f4cf..b2e8044 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -335,9 +335,7 @@ static void  dmar_pci_bus_del_dev(struct dmar_pci_notify_info *info)
 
 static inline void vf_inherit_msi_domain(struct pci_dev *pdev)
 {
-#ifdef CONFIG_PCI_ATS
 	dev_set_msi_domain(&pdev->dev, dev_get_msi_domain(&pdev->physfn->dev));
-#endif
 }
 
 static int dmar_pci_bus_notifier(struct notifier_block *nb,
