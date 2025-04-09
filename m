Return-Path: <linux-tip-commits+bounces-4805-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F223A82FD6
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 21:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33A767B10D9
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 18:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2581227E1B7;
	Wed,  9 Apr 2025 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d4pFI1q6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fx3ZJETB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596D727D764;
	Wed,  9 Apr 2025 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224876; cv=none; b=hX3RFjVm7UcioguGKX0IfIEpCVK+4RLwIbb6D492ETTZfM0aFBMKXSB9jK4WzVPpFXgvVMkBLCQH6HSNyFUwqfS0qm3RFo8biwk7Nyzy8vaeFiO84PKwvDrPIYmWiQxEgv/4ueJKsAeAB0u9GtDoS7vL/MZqi4XKL3C5iIFcSYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224876; c=relaxed/simple;
	bh=EXtZvDVUPhB1GAIzG0Zu3meOsCQO+2N6XNuXi0FbQVE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GzRM6gy9TxI031xG+DU+6DklChLlI5t6yL0RGDteuHFOTlYBA53Kld4IiKxKfUZSHDrRtF3Vlsz+mhWPRYqUvC5TxoacMAHo/G6tyG4bYV7NbH8QezKFfRnfKd+IxtNjAw9lLPXZfZenIu3YkYh0ejbAJK1uireOEWXZsrfLcYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d4pFI1q6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fx3ZJETB; arc=none smtp.client-ip=193.142.43.55
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
	bh=Vpmsh6YbIpy36Mj9CjDnp89ZHfjh7PIICajqy1jiBTM=;
	b=d4pFI1q6RCiPP2RTLzcmUwXrXsR+/ZIj13Hk29kNvXk9iB3sZRC9oCL/EWN8KzFFRYFrOq
	1O5WFaHtm5I9nTYD2x09RPReqYwgchnqn/DYNpi5ys4hkKMSPwa7snz4255M6PL0q4Nl54
	tTqQ+/a2E1y27wbCu4YR58/vIc9e5fJZB8iITJyz1v9OL5ChQ6UBsVfrq4V6DdEF0ypoqr
	9nDrcQyoCIbESZM+v0jD3v0VbxBaI5s3zISS+ARk/bwLR+N6QjfqnCsypO58JEdk1BCeAM
	qiuUbAcz11ecMxLn1a0nmDXh8vAKXi76VNkUX3DaEHnrKcuVwUmOfqObNlnsxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744224872;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vpmsh6YbIpy36Mj9CjDnp89ZHfjh7PIICajqy1jiBTM=;
	b=fx3ZJETBcR65tFPwEz7oFNnF9TsxYwBl5BwTOU8iexBKE8AeJTbU+rlhTSADyW5cL+pxed
	HpHk22vAazOeEKAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Set pci_dev:: Msi_enabled late
Cc: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250319105506.383222333@linutronix.de>
References: <20250319105506.383222333@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174422487199.31282.4119273968175959176.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     b0c44a5ec3552f89c47dac9903d99c22d796d87f
Gitweb:        https://git.kernel.org/tip/b0c44a5ec3552f89c47dac9903d99c22d796d87f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:56:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Apr 2025 20:47:29 +02:00

PCI/MSI: Set pci_dev:: Msi_enabled late

The comment claiming that pci_dev::msi_enabled has to be set across setup
is a leftover from ancient code versions. Nothing in the setup code
requires the flag to be set anymore.

Set it in the success path and remove the extra goto label.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/all/20250319105506.383222333@linutronix.de

---
 drivers/pci/msi/msi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 3283baa..c26e516 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -358,12 +358,8 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	if (nvec > 1 && !pci_msi_domain_supports(dev, MSI_FLAG_MULTI_PCI_MSI, ALLOW_LEGACY))
 		return 1;
 
-	/*
-	 * Disable MSI during setup in the hardware, but mark it enabled
-	 * so that setup code can evaluate it.
-	 */
+	/* Disable MSI during setup in the hardware to erase stale state */
 	pci_msi_set_enable(dev, 0);
-	dev->msi_enabled = 1;
 
 	if (affd)
 		masks = irq_create_affinity_masks(nvec, affd);
@@ -371,7 +367,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	msi_lock_descs(&dev->dev);
 	ret = msi_setup_msi_desc(dev, nvec, masks);
 	if (ret)
-		goto fail;
+		goto unlock;
 
 	/* All MSIs are unmasked by default; mask them all */
 	entry = msi_first_desc(&dev->dev, MSI_DESC_ALL);
@@ -393,6 +389,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 		goto err;
 
 	/* Set MSI enabled bits	*/
+	dev->msi_enabled = 1;
 	pci_intx_for_msi(dev, 0);
 	pci_msi_set_enable(dev, 1);
 
@@ -403,8 +400,6 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 err:
 	pci_msi_unmask(&desc, msi_multi_mask(&desc));
 	pci_free_msi_irqs(dev);
-fail:
-	dev->msi_enabled = 0;
 unlock:
 	msi_unlock_descs(&dev->dev);
 	kfree(masks);

