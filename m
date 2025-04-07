Return-Path: <linux-tip-commits+bounces-4731-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE668A7E272
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 16:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F423BF8C8
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 14:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804861F8EFF;
	Mon,  7 Apr 2025 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TxxUpXvA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="89uc/M0K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89891F8738;
	Mon,  7 Apr 2025 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036308; cv=none; b=DUARkFakiRG0ZEi6OC1vqoUhTONa/ahzpkDtACqCpV9ZBCitPfWFBJ4KZZ6GEIWnwytEE/Bf8IPj9Mh/NjAEimDRYJ4uPGj6+qbCaVaE+rdlr/kfLCCumIo8YJHK5LUPNgJ7liTIycMOpwqwo4PKvIMoxPBCzBobh6A+Y68Pvvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036308; c=relaxed/simple;
	bh=/54KgHj0kTFmDs7gVrxQL4qnlo/gHqmXab90hyn4pQM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FZPlDz7TsZrImj1v22CPlKKS+A4JL2ocKbbHSOl3rXagx033HBYfUn56As7TsZbs3qH6fzMOgXAz3c0yO8jHKmUZ1RhgOKiIsRjnX+19YCfdcivEvA7hycI+m06Ct1EQ92+DbkMFtx1wgnNBlldEqcOG774Jf3e0XeDCZNiI2hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TxxUpXvA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=89uc/M0K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 14:31:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744036305;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TPLr5H1/7+9V/s3P9xHkh1IeA2aL1DBYXumQDiyYuQw=;
	b=TxxUpXvAyzUwCLGNnDsh4o34Y2PnwMb+jAL9wMx5UQ+pfiDkvea6bVsQNkuPUkZWMb2EWJ
	VdZzw5R/H2qE632hctsgyQcC40T+TNYmN5bYkfysCPiN9Bst2V62pOpZyIpXxV+yVTUzT9
	lVuCU4R1pj/is7OBvCQQvyAi5416/Fb0rUBF+Y34/3wJwUedbQoySqY6STTKNcpRUlu3En
	kDCuE7ZB0ks5yAwBXHj4+M/puvSvSnqT34y6wVgww8Eci/zpzT37fEF9xYvFyKR2zMApa5
	3EfrhyKZSprEOnwdpudTyurImtigEMKPNzrmBPmB/hjJNsRvTCm90GiX7Ii2tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744036305;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TPLr5H1/7+9V/s3P9xHkh1IeA2aL1DBYXumQDiyYuQw=;
	b=89uc/M0KzMu3OxEEoZ60cLlDZ18TZNnkG5UIjtuOk81WDXcvKhpvW12NR39SVvvShKbuuj
	nqZwMjCSe4Uf7wCQ==
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
Message-ID: <174403630389.31282.9495750108252282590.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     7b025f3f85ed4283d5a414371bb2ffd38d19033f
Gitweb:        https://git.kernel.org/tip/7b025f3f85ed4283d5a414371bb2ffd38d19033f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:56:54 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 16:24:56 +02:00

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
index 9987483..50f3daf 100644
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
 
+	retain_ptr(dev);
 	msix_update_entries(dev, entries);
-	goto out_unlock;
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

