Return-Path: <linux-tip-commits+bounces-4802-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D47C6A82FA1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 20:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F76189788E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 18:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BE927D763;
	Wed,  9 Apr 2025 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qYXeFz9D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sP7C5Ida"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9414B27CCD0;
	Wed,  9 Apr 2025 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224874; cv=none; b=ei5/am6VBQ2P19emu06r/Etl/3Uy/+CYILj7LwoTCucJbI1Yw6q9sd3palLl1rOMHPw+2iB2fvBsDYym6hhXHvdKL9QLbLTYaPk7hCYZQ/Dx5/lAdG2Q/nl8WKrDhq+ay5lynGoXRMXeB7nL6rY6OZhi7cdrSM+OTvNaXX7rCRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224874; c=relaxed/simple;
	bh=ZB36i4BFClwetcSRL+tqtvCplDmplz8+1AwsRWt/JCg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=leR2cese14goUzrLasurWpBKYMuHDs5s9Ij0grG2eWzO9tteyGzuLmxyOOtwwCGwgdgdVAXMYinwvod/+USPOsD4dYR9IeurEmdmscADo7NbOsrW4Cv7p6Or7Oyp+ZopNJ8F5yfl2El0q7XTuzSypMEOLqIODX5ixgLUpiUwyVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qYXeFz9D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sP7C5Ida; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 18:54:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744224870;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2khK4V/+bL/n/x7ArYBZ/IatwUBblzGq4qNd1PoXV8=;
	b=qYXeFz9DgeQa0ARPYhFMxVytQy+t271Tcob7RZijORe6vXXcc6mh4R5UIPgjpNzIdEr0Qy
	cVZKyOP83YarPatgAt8KWm/Tko/DSyYlWTQ8HeIB9pAjcxOiYAU6joJEdYAfelfHYvY7iA
	DY6+hgb5vlj7L1chpJHETY0eW6LOvtvWW/HKot5gmlf/3qRXpRhelI77A/EW7qKelUlqcz
	V1HcRc6862IZ6lBzGrRY850c2tE9WzoWmFKhW4e/t5ZMOlk2iR2ykeK3DNWRhI1iy56yT2
	ebHvxWRU8mP8qPK2tZUWhpK3qxbDnEOkiI+jic+GEsTQUGpvGHcFtLPqnrLQBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744224870;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L2khK4V/+bL/n/x7ArYBZ/IatwUBblzGq4qNd1PoXV8=;
	b=sP7C5Idaw3Vfqo743+lieDgP2A0hx9Cr4m0H5L5sQUxJMSZubiJgGU4WVEB4pqCHBkdB+4
	3GbYKbIoOel2y1AA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/msi] PCI/MSI: Switch msix_capability_init() to guard(msi_desc_lock)
Cc: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250319105506.564105011@linutronix.de>
References: <20250319105506.564105011@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174422487021.31282.6683134058141552285.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     891146645e5d55166847b8e004a30fb9f8b03266
Gitweb:        https://git.kernel.org/tip/891146645e5d55166847b8e004a30fb9f8b03266
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:56:54 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Apr 2025 20:47:30 +02:00

PCI/MSI: Switch msix_capability_init() to guard(msi_desc_lock)

Split the lock protected functionality of msix_capability_init() out into a
helper function and use guard(msi_desc_lock) to replace the lock/unlock
pair.

Simplify the error path in the helper function by utilizing a custom
cleanup to get rid of the remaining gotos.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/all/20250319105506.564105011@linutronix.de

---
 drivers/pci/msi/msi.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 9987483..732166a 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -660,35 +660,39 @@ static void msix_mask_all(void __iomem *base, int tsize)
 		writel(ctrl, base + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
 
-static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *entries,
-				 int nvec, struct irq_affinity *affd)
+DEFINE_FREE(free_msi_irqs, struct pci_dev *, if (_T) pci_free_msi_irqs(_T));
+
+static int __msix_setup_interrupts(struct pci_dev *__dev, struct msix_entry *entries,
+				   int nvec, struct irq_affinity_desc *masks)
 {
-	struct irq_affinity_desc *masks __free(kfree) =
-		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
-	int ret;
+	struct pci_dev *dev __free(free_msi_irqs) = __dev;
 
-	msi_lock_descs(&dev->dev);
-	ret = msix_setup_msi_descs(dev, entries, nvec, masks);
+	int ret = msix_setup_msi_descs(dev, entries, nvec, masks);
 	if (ret)
-		goto out_free;
+		return ret;
 
 	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
 	if (ret)
-		goto out_free;
+		return ret;
 
 	/* Check if all MSI entries honor device restrictions */
 	ret = msi_verify_entries(dev);
 	if (ret)
-		goto out_free;
+		return ret;
 
 	msix_update_entries(dev, entries);
-	goto out_unlock;
+	retain_and_null_ptr(dev);
+	return 0;
+}
 
-out_free:
-	pci_free_msi_irqs(dev);
-out_unlock:
-	msi_unlock_descs(&dev->dev);
-	return ret;
+static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *entries,
+				 int nvec, struct irq_affinity *affd)
+{
+	struct irq_affinity_desc *masks __free(kfree) =
+		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
+
+	guard(msi_descs_lock)(&dev->dev);
+	return __msix_setup_interrupts(dev, entries, nvec, masks);
 }
 
 /**

