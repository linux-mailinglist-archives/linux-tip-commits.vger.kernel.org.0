Return-Path: <linux-tip-commits+bounces-4803-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18861A82FC9
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 20:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D59F8A38D8
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 18:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FD427D78A;
	Wed,  9 Apr 2025 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fVTet/fD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+rwFnv8p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4566327CCE2;
	Wed,  9 Apr 2025 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224875; cv=none; b=Ppr/+FAmHnH06ynSUXXEuvlT23hNCdYFeWOFIgkrMc4+dwH0fw7KodUqtnhqZrtgn7wWTP8FSlg/fduUnBqq6W72eH0kL97i0eZYpbEG0OiDuv9mNwN/Uwg3KHyIy4TV6eggCcL3JU1229KzOqGVt3pGmuPhH7uuE9J60XJYMQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224875; c=relaxed/simple;
	bh=SHAvWBgj2lWvatPpcUxZjtEds056dQed7/ZMREPJ2Ts=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LROfeWM2kYFEanjLf/6DUPjUnwStBlGx3Kcqoiepl5lOdb1baZEY4KVNDRxUpGu7/JgAKynIXRZM6KwFpDDyT1DSlyVLyVRsVhtTOw4/IB6n9szr5G6r51qUi0ahqxjzvM3JCPGw2zrHlbJG0x6Fz4NGc7u7IJ/S1B9agGnU6QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fVTet/fD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+rwFnv8p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 18:54:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744224871;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbMi8SYQsEdhYvFBf7xKzai5yml9clQKoLZgGgrLZT8=;
	b=fVTet/fDF0ar7wrXNiTgYH+CJLfE1BrtAYfzOzWO7bnEDYQ5IJunB+RQ8jcRE73ko9DcQH
	+EhJmEuH4Jfyxh4dx9MOzk7kvJ0lB1KmQp1Tx0bd8gtAyZejmzFbQFBvokl9YQFEzEu9up
	f2OLcV+cm1ic/wVLMm7w1FwOaeP8afsw6aSFLRBhGvu3xtksnOt0zkHXLKtNWMtx/lAtFx
	kaUqDPjwHrok736SUJcWuZZR3059O0Eneg4DzD8uWaM7qSDzy7KlKcXr7bO0cLExZk0+EL
	2KjXBpCGtanx4c6BMusu5a2BGQzJXwB6aHWWeZL0lLJRi1eAZ9i1driVieL0fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744224871;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbMi8SYQsEdhYvFBf7xKzai5yml9clQKoLZgGgrLZT8=;
	b=+rwFnv8piwuNkWS8tPJvUwYuPYL/SucJafSznP/klgBSzogcUFK7euoYZvHDQFeGv74EKR
	rkGhio/wnMddSfDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/msi] PCI/MSI: Switch msi_capability_init() to guard(msi_desc_lock)
Cc: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250319105506.504992208@linutronix.de>
References: <20250319105506.504992208@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174422487075.31282.11644520359001594062.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     f11cc2af8f4b3d5e81dd9b8fb1a9185a6ca6e7db
Gitweb:        https://git.kernel.org/tip/f11cc2af8f4b3d5e81dd9b8fb1a9185a6ca6e7db
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:56:53 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Apr 2025 20:47:30 +02:00

PCI/MSI: Switch msi_capability_init() to guard(msi_desc_lock)

Split the lock protected functionality of msi_capability_init() out into a
helper function and use guard(msi_desc_lock) to replace the lock/unlock
pair.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/all/20250319105506.504992208@linutronix.de

---
 drivers/pci/msi/msi.c | 68 ++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 85c2aba..9987483 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -335,38 +335,13 @@ static int msi_verify_entries(struct pci_dev *dev)
 	return !entry ? 0 : -EIO;
 }
 
-/**
- * msi_capability_init - configure device's MSI capability structure
- * @dev: pointer to the pci_dev data structure of MSI device function
- * @nvec: number of interrupts to allocate
- * @affd: description of automatic IRQ affinity assignments (may be %NULL)
- *
- * Setup the MSI capability structure of the device with the requested
- * number of interrupts.  A return value of zero indicates the successful
- * setup of an entry with the new MSI IRQ.  A negative return value indicates
- * an error, and a positive return value indicates the number of interrupts
- * which could have been allocated.
- */
-static int msi_capability_init(struct pci_dev *dev, int nvec,
-			       struct irq_affinity *affd)
+static int __msi_capability_init(struct pci_dev *dev, int nvec, struct irq_affinity_desc *masks)
 {
+	int ret = msi_setup_msi_desc(dev, nvec, masks);
 	struct msi_desc *entry, desc;
-	int ret;
 
-	/* Reject multi-MSI early on irq domain enabled architectures */
-	if (nvec > 1 && !pci_msi_domain_supports(dev, MSI_FLAG_MULTI_PCI_MSI, ALLOW_LEGACY))
-		return 1;
-
-	/* Disable MSI during setup in the hardware to erase stale state */
-	pci_msi_set_enable(dev, 0);
-
-	struct irq_affinity_desc *masks __free(kfree) =
-		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
-
-	msi_lock_descs(&dev->dev);
-	ret = msi_setup_msi_desc(dev, nvec, masks);
 	if (ret)
-		goto unlock;
+		return ret;
 
 	/* All MSIs are unmasked by default; mask them all */
 	entry = msi_first_desc(&dev->dev, MSI_DESC_ALL);
@@ -394,16 +369,45 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 
 	pcibios_free_irq(dev);
 	dev->irq = entry->irq;
-	goto unlock;
-
+	return 0;
 err:
 	pci_msi_unmask(&desc, msi_multi_mask(&desc));
 	pci_free_msi_irqs(dev);
-unlock:
-	msi_unlock_descs(&dev->dev);
 	return ret;
 }
 
+/**
+ * msi_capability_init - configure device's MSI capability structure
+ * @dev: pointer to the pci_dev data structure of MSI device function
+ * @nvec: number of interrupts to allocate
+ * @affd: description of automatic IRQ affinity assignments (may be %NULL)
+ *
+ * Setup the MSI capability structure of the device with the requested
+ * number of interrupts.  A return value of zero indicates the successful
+ * setup of an entry with the new MSI IRQ.  A negative return value indicates
+ * an error, and a positive return value indicates the number of interrupts
+ * which could have been allocated.
+ */
+static int msi_capability_init(struct pci_dev *dev, int nvec,
+			       struct irq_affinity *affd)
+{
+	/* Reject multi-MSI early on irq domain enabled architectures */
+	if (nvec > 1 && !pci_msi_domain_supports(dev, MSI_FLAG_MULTI_PCI_MSI, ALLOW_LEGACY))
+		return 1;
+
+	/*
+	 * Disable MSI during setup in the hardware, but mark it enabled
+	 * so that setup code can evaluate it.
+	 */
+	pci_msi_set_enable(dev, 0);
+
+	struct irq_affinity_desc *masks __free(kfree) =
+		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
+
+	guard(msi_descs_lock)(&dev->dev);
+	return __msi_capability_init(dev, nvec, masks);
+}
+
 int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 			   struct irq_affinity *affd)
 {

