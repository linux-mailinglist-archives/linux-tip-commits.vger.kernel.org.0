Return-Path: <linux-tip-commits+bounces-4734-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD98A7E2E0
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 17:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444133A951F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 14:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB651FAC5E;
	Mon,  7 Apr 2025 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HtqtVGBb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rCS36bET"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1C11F9F47;
	Mon,  7 Apr 2025 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036311; cv=none; b=b2al7da8OUk6iSzI5GpJcycqJJTpVqeeeNLnBO7ms0DJtgs1+p8nBQNpU6HRH4uYgGWLSTTQkPf33TYp+reSDEXKa/X2qiWEi2NMg2KOmY4zIvmnimfBOfdQqPaQD7pV2xjz7z/PnEhz9RD4OfrDLUZwaJ3rNPqS3vTEzNGRye0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036311; c=relaxed/simple;
	bh=/3nv6VBvNA41LDn80WbxYqlNImJp+OKoRpGyIcffgWI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M+xwFbJkv9EFdvTO0GTb0h5e28f1gB7vgkyRXE5Be0zTz6+2a7L86S/pjwR/E6AoAf8rY+zDS0vnZkZkmzyzXj8ietS3DfmmAx5B/zz2DqkQPVGekvdoBD399SZXCCgIoK3Da3ttOlnKIlAJDKQAYd6QD4DMaoZbr5Eoyz+oVuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HtqtVGBb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rCS36bET; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 14:31:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744036308;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F0TFuWhqUN0snwGJ9CcOaLKIJUlUSdkNz56VCvoxoR4=;
	b=HtqtVGBbH/pAvQCxf//jmn1qkKRfddkAyZys4jj21dN+aYGw5a9NA0zLB0RsrOsRFuVqh8
	c40eRWg5Uq21tcd/Em2j9Q4yqPC5Ufv1xcEZ1SFKpCUMF1KUI38vx8CAWRtnAb5tPoWd4p
	08O6uBHw58u5eiSybz3YmwSa95btTwynMa0WVa5bWcA2MV6bRPyJ7ErxRbufZnkFwU7RyO
	KR3FwjCK7KKUvvH78RBP5QVLElAx/scuSeR7JW71m8lT4aApjw1HKYxsQ5pX/3vnTk61oO
	9yS9o3o+9Zo3ELbz8ZvVXU2lFDkgIhYZM0c53cGXnNgQIfn5JqZKEkX7cJD9RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744036308;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F0TFuWhqUN0snwGJ9CcOaLKIJUlUSdkNz56VCvoxoR4=;
	b=rCS36bETu6gasg9oriKSBXwoUFSlewtaCnFC2U21ZNh5d/Pe4h1NoZKpYAQ7gDU9kKoVbS
	dwhCjKD0aKH8i6BQ==
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
Message-ID: <174403630721.31282.2039687358301284878.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     1808ba1d4603d3509b8444d1d44b9a0d91edc018
Gitweb:        https://git.kernel.org/tip/1808ba1d4603d3509b8444d1d44b9a0d91edc018
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:56:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 16:24:55 +02:00

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

