Return-Path: <linux-tip-commits+bounces-4733-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67102A7E283
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 16:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3B817EE21
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 14:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704341FAC23;
	Mon,  7 Apr 2025 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U1ENAhdT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2BGYks9P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFB91DC9BA;
	Mon,  7 Apr 2025 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036310; cv=none; b=gap/7uqAz8US/1nPCJS+tavwQQjdPotmfBUmVltM0p50SElqEo0J69cQqg7Wnl7qeSr3pr/Mu56oVlUuncoaAxEtEIerlGGt14KtUst7ZWZBHt5cZvUAwSU1LbcEWZj2RsxcFqw+CMeaVtoEk6Nir7Qt+9x2mdiC4TaGMC9WQYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036310; c=relaxed/simple;
	bh=lm9xqFG2XC9aM6aFkkZ+GVTbOtzGICZDznfW9N05XIA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wzd1kv545w0LmqRDYj6c14Seq01aoFUqsVEJhIXYxvKP50snTz/KNKqy0Nls8q8Sc+u/RiZcGn7N2ufUF67FmOPNhdM2W0GdtMlEVOXLzG6ooU2uLIpopnQOLkZC//yq0iaeU67J55GEP6c9sVBAKz+tBAm9irtxBVR2x5JoBxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U1ENAhdT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2BGYks9P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 14:31:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744036307;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kf2aTqDaiAnBce8tb0dk+t04MsT/OJtA/Pp9gNNmGuY=;
	b=U1ENAhdT1NbZIOCK2WSOovQjyhPaS7IqJan1oBNM4rfxgoLxa3JB9nw8MSfepqncKuBxQy
	Kng5pIhR5Wpd/7FwrZhmVYKZZFifk/sqZxjy8K5g5PSuI6JbLLvKW+gJ8T9qqNAeiZJ6+I
	j1p54RlcWxhvGxARi3nefNsJVKYvvKpRy54gGDa5BeEvCBkEs2Nn3o7nAReIGrbAEA9ceW
	Vjmva+HurxiSPtOSvO46qfLtFK950E/wny/3aeZwQZZRu2W7GBwjIaFfo9yyPdsSP/m0Ke
	IOCqlu/MnXoXlb86B4KVt/e4oJH2qe+Tj6uSWuzyllxVkC0ckYTuCTsXv7Opvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744036307;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kf2aTqDaiAnBce8tb0dk+t04MsT/OJtA/Pp9gNNmGuY=;
	b=2BGYks9Pjmiy1zPANHbAqnKZhF+3V61cJhnmF1kkit4U1K3mGAKdjpUMZpiqMEITrp3ijs
	BxSAwJd9LJ2gnzCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Use __free() for affinity masks
Cc: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250319105506.444764312@linutronix.de>
References: <20250319105506.444764312@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174403630625.31282.8543372817587454556.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     077148b4f67fc66be876789a946f52e224492089
Gitweb:        https://git.kernel.org/tip/077148b4f67fc66be876789a946f52e224492089
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:56:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 16:24:55 +02:00

PCI/MSI: Use __free() for affinity masks

Let cleanup handle the freeing of the affinity mask. That prepares for
switching the MSI descriptor locking to a guard().

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/all/20250319105506.444764312@linutronix.de

---
 drivers/pci/msi/msi.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index c26e516..85c2aba 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -350,7 +350,6 @@ static int msi_verify_entries(struct pci_dev *dev)
 static int msi_capability_init(struct pci_dev *dev, int nvec,
 			       struct irq_affinity *affd)
 {
-	struct irq_affinity_desc *masks = NULL;
 	struct msi_desc *entry, desc;
 	int ret;
 
@@ -361,8 +360,8 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	/* Disable MSI during setup in the hardware to erase stale state */
 	pci_msi_set_enable(dev, 0);
 
-	if (affd)
-		masks = irq_create_affinity_masks(nvec, affd);
+	struct irq_affinity_desc *masks __free(kfree) =
+		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
 
 	msi_lock_descs(&dev->dev);
 	ret = msi_setup_msi_desc(dev, nvec, masks);
@@ -402,7 +401,6 @@ err:
 	pci_free_msi_irqs(dev);
 unlock:
 	msi_unlock_descs(&dev->dev);
-	kfree(masks);
 	return ret;
 }
 
@@ -661,12 +659,10 @@ static void msix_mask_all(void __iomem *base, int tsize)
 static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *entries,
 				 int nvec, struct irq_affinity *affd)
 {
-	struct irq_affinity_desc *masks = NULL;
+	struct irq_affinity_desc *masks __free(kfree) =
+		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
 	int ret;
 
-	if (affd)
-		masks = irq_create_affinity_masks(nvec, affd);
-
 	msi_lock_descs(&dev->dev);
 	ret = msix_setup_msi_descs(dev, entries, nvec, masks);
 	if (ret)
@@ -688,7 +684,6 @@ out_free:
 	pci_free_msi_irqs(dev);
 out_unlock:
 	msi_unlock_descs(&dev->dev);
-	kfree(masks);
 	return ret;
 }
 

