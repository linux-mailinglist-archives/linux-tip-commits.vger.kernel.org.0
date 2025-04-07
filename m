Return-Path: <linux-tip-commits+bounces-4729-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E44BA7E265
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 16:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A06517CB5C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 14:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6461F8725;
	Mon,  7 Apr 2025 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fs+Dk7x4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DqiuLFuC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727821F7074;
	Mon,  7 Apr 2025 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036306; cv=none; b=Zh1FmUcCiTr0e4Hq2vzwIH/qg9Ig9c2+C4ZW2HwYTSRQe/qx+lbIODCl75CG+Yw1k3Byn4li7pxoFrkgAP9FU8h3faQCRbdUFsYthG8dVBQH+xrhkau7Ca/EFUKYEOmShHeTxLu2f8mykSHA/M6kT37P9m1sNK+uT9dr2OLgbSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036306; c=relaxed/simple;
	bh=xtC38VNFjGnBv35rtCHxRQk571av8U4QAUU8aMxRmSU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=difSyC1hVZSHXqgfYEPQ55t5FCaFhlfAQA+k/13Hc2klBYbNWfXcBWEFF9pzN/Ag3iG+cJX1x5xLuvCpsheGyIbLLW8+0ZVaCnXaptMJGhGU9bzz5Epbz08fKKiMUiaxwPUym4p0WKT+d/nyGWx+1o3Zp0cMtXoXzKPcZMBNbHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fs+Dk7x4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DqiuLFuC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 14:31:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744036302;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U4DoqFUtEsMYGftQ5MxbLYVY3yucC5AiaraooiUzd+g=;
	b=Fs+Dk7x4YCX5VpwoIa5i/7qloAJqabIM/x4aKfJkK2BxnoqVRhW+Ovs/YKbCv7LEtkazaS
	MPQ1aSx+xVtLD98kb1Fy5EAX10ESQzSWF9QndoHakH0KgWbNJvG0Vd64N6CicaOmQkIMoy
	oAygvEJK//qBbkJH0m8Me0S9sZqzgQ8Ks1TWYmnl3yaFdPL9EOtJHc47YTfnCHlqNyQXk1
	lG6yN94bvY9WtHgoONetkb7u2czEQTDHBO7lNeApZ6DbHGFfZjgtGaUdjJcLUxXJKPxfu6
	YH9rxPxlIWgZmJ4sefnIMKzDK65VYyaVEX6/LBgOIepW07nyH/zpz58g/4nT2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744036302;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U4DoqFUtEsMYGftQ5MxbLYVY3yucC5AiaraooiUzd+g=;
	b=DqiuLFuC2OAMEAkA7kGy+kcbopyyJL3ujRDnLtCrDkU+bpcVFT0NJEvktMcIW6btgc6BoI
	h3XU4GD3/TP6rrDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Provide a sane mechanism for TPH
Cc: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250319105506.683663807@linutronix.de>
References: <20250319105506.683663807@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174403630200.31282.18344821353173189297.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     5062a44c220028d59e70e80f939f3b277d90366a
Gitweb:        https://git.kernel.org/tip/5062a44c220028d59e70e80f939f3b277d90366a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:56:57 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 16:24:56 +02:00

PCI/MSI: Provide a sane mechanism for TPH

The PCI/TPH driver fiddles with the MSI-X control word of an active
interrupt completely unserialized against concurrent operations issued
from the interrupt core. It also brings the PCI/MSI-X internal cached
control word out of sync.

Provide a function, which has the required serialization and keeps the
control word cache in sync.

Unfortunately this requires to look up and lock the interrupt descriptor,
which should be only done in the interrupt core code. But confining this
particular oddity in the PCI/MSI core is the lesser of all evil. A
interrupt core implementation would require a larger pile of infrastructure
and indirections for dubious value.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/all/20250319105506.683663807@linutronix.de




---
 drivers/pci/msi/msi.c | 47 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/pci/pci.h     |  9 ++++++++-
 2 files changed, 56 insertions(+)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 50f3daf..4027abc 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -913,6 +913,53 @@ void pci_free_msi_irqs(struct pci_dev *dev)
 	}
 }
 
+#ifdef CONFIG_PCIE_TPH
+/**
+ * pci_msix_write_tph_tag - Update the TPH tag for a given MSI-X vector
+ * @pdev:	The PCIe device to update
+ * @index:	The MSI-X index to update
+ * @tag:	The tag to write
+ *
+ * Returns: 0 on success, error code on failure
+ */
+int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int index, u16 tag)
+{
+	struct msi_desc *msi_desc;
+	struct irq_desc *irq_desc;
+	unsigned int virq;
+
+	if (!pdev->msix_enabled)
+		return -ENXIO;
+
+	guard(msi_descs_lock)(&pdev->dev);
+	virq = msi_get_virq(&pdev->dev, index);
+	if (!virq)
+		return -ENXIO;
+	/*
+	 * This is a horrible hack, but short of implementing a PCI
+	 * specific interrupt chip callback and a huge pile of
+	 * infrastructure, this is the minor nuissance. It provides the
+	 * protection against concurrent operations on this entry and keeps
+	 * the control word cache in sync.
+	 */
+	irq_desc = irq_to_desc(virq);
+	if (!irq_desc)
+		return -ENXIO;
+
+	guard(raw_spinlock_irq)(&irq_desc->lock);
+	msi_desc = irq_data_get_msi_desc(&irq_desc->irq_data);
+	if (!msi_desc || msi_desc->pci.msi_attrib.is_virtual)
+		return -ENXIO;
+
+	msi_desc->pci.msix_ctrl &= ~PCI_MSIX_ENTRY_CTRL_ST;
+	msi_desc->pci.msix_ctrl |= FIELD_PREP(PCI_MSIX_ENTRY_CTRL_ST, tag);
+	pci_msix_write_vector_ctrl(msi_desc, msi_desc->pci.msix_ctrl);
+	/* Flush the write */
+	readl(pci_msix_desc_addr(msi_desc));
+	return 0;
+}
+#endif
+
 /* Misc. infrastructure */
 
 struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index b81e99c..39f368d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1064,6 +1064,15 @@ int pcim_request_region_exclusive(struct pci_dev *pdev, int bar,
 				  const char *name);
 void pcim_release_region(struct pci_dev *pdev, int bar);
 
+#ifdef CONFIG_PCI_MSI
+int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int index, u16 tag);
+#else
+static inline int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int index, u16 tag)
+{
+	return -ENODEV;
+}
+#endif
+
 /*
  * Config Address for PCI Configuration Mechanism #1
  *

