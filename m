Return-Path: <linux-tip-commits+bounces-4804-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 070DDA82FCE
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 20:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADDC57B0BFA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 18:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D1A27D79B;
	Wed,  9 Apr 2025 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="thg8VFzx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ujsP77uo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AF827BF9F;
	Wed,  9 Apr 2025 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224875; cv=none; b=GefLD2g6NDYyISMluSZ9nEKej0Ae5S6V2xut43r5bBj0yFO7KHeP/2Zs6gsDWVGp9SS9Sb37GSkUkHzbvVAdHep0vjAuY8jgp+kcIpfRJ4nTn6hXKTM4VuE2s8mpGQQOj9hgbaJa2OMRaAfNvE0Mr7uYtibZ+hVPZumkq3KZr7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224875; c=relaxed/simple;
	bh=QVHgjUuaEpJ7zm3OpDZGkAZ4eicGc53JeyBBixTbt9g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MI6QKJ3MNQ7skBK0h2tQDw2Sb2Fhpyw84ExMiRjWLRlMUaYbM6qyFEBxdGC9zdW1SzrHM8/qmkDgSsa4z1VOff4l7yWFZHIrZ99+6cTEe7fsYJ6PUcH+TrZiy6MYZbLamqSrxkkh2RZGfhGgbaQp8KijeF3pMHh9pNqhb0GIGmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=thg8VFzx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ujsP77uo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 18:54:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744224872;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/1v9DAkvxGeXKVhx9hJ5uphAJMMY8SrYG8jIp6JhlIk=;
	b=thg8VFzxc1zG7VGOoJieqzkmyx4kDLqcJ+jhqRuDIVkvoAuYtmOUseF5TVgzB7fTc+MA9I
	dNbAQ4xvfgASLUPzINEqpde45I88VcQhnkEI6GhwkiC9eiffBeyEhXjy0o9oIxbEzwBrl9
	wClPWgAk8kjVboV/01xuVo1pI+35NoOf9s2T9m52e9Nq+ThBSGJmH9t9mBFbqNfBtDCVCD
	Z7ZL/GlQWpueahGNwqQBbyiGY/7pe8mSmmPLCypHc2Yz7fyBP/y+E99K+PO12of0Z+isiM
	o6virIhWow+HuQen77XK0lkkga8lExeC5NzmqsxbYBNVcdhAFGrTMvVYkeI12A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744224872;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/1v9DAkvxGeXKVhx9hJ5uphAJMMY8SrYG8jIp6JhlIk=;
	b=ujsP77uoMLyTwjRgZU3XsCIAq7NA+KAGOdq3Qk7scDNCjh4O1Ndl2G8yoIPxB9jeRqXCDG
	QQMYtD0gRhnnm3CA==
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
Message-ID: <174422487141.31282.14327737875444978155.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     5c0ba4f9d25eb35a8ef882115c9f9c2084acc4e7
Gitweb:        https://git.kernel.org/tip/5c0ba4f9d25eb35a8ef882115c9f9c2084acc4e7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:56:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Apr 2025 20:47:30 +02:00

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
 

