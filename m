Return-Path: <linux-tip-commits+bounces-4806-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046D0A82FD2
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 21:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438268A513A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 18:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3F327EC76;
	Wed,  9 Apr 2025 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sQDt4gfZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sWbh7i2A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C48D27E1A4;
	Wed,  9 Apr 2025 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224877; cv=none; b=gJlzCuYN7e7xHcdic2ovxFEGn+b2NoFoziMiXLpTSHOsYjQEJ0yhIOgldT61tfewo1ERXdgvvUY45QAK+v7ODYvoBGXSYHqKF640HeMJuVXAs1bi7lA2BtY9zIsqL0BGhvxyCgffC9D4vmxVNtIwF/nOF2RpLkfI71aNoFTYKy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224877; c=relaxed/simple;
	bh=cmip/6Ks5zJF6E1JuLzfLHPSdqK7FKNrG93Hvrag4YU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GpXX8V2EbWiKowrjfHHgiG2kUzHrR6UddW5mD2GBMYxFTyuqpW2U2pDqrcdJga2KF6vJkkCsLCHOsAAFazmARa0a0iYqNAjmYbeFFaf5864hm3pZlLjtnwloomBH/2ZMe/VUfS7XhHWLfo3o1xK3wXP4HBRMpNkKmBXLw5guhxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sQDt4gfZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sWbh7i2A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 18:54:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744224873;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qET2xgSwjaSfMy2/avvHCIPbStP+DitJ7yEQYAwVeFQ=;
	b=sQDt4gfZUbmVBNcsQvdQBjMTvSMUEmwZT57R1XzcOZ8sNkKNDLjKkk+pWRucd6UUjH7c05
	PPT8+vgGUgNrB8Zbn2snCtx8cuxT/rmroPmoSkCjEsZihPkjDaSA1dCMHaPSDyNs3CRTka
	IYpjDtKah/BwTsELeHO9UEY8pu0+Lkfqs77FxH0YLYSbJFRDDv9XL65Os+R4KWK+IZgsBp
	zcP6sktJTmLCYZ3gCKy81F/xNZl5ImuvO9X+/T9ES7nBbsS6Fv6tzG7sng+bOjKtZf7Pt/
	ZvfMW6ftwNbFdpUdBtz15N7Oa4rAi+Sy/bVujImq3P7gxie4p5tVR1b5X3/X1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744224873;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qET2xgSwjaSfMy2/avvHCIPbStP+DitJ7yEQYAwVeFQ=;
	b=sWbh7i2AzO7cV2WaqGWkRlvUOp+dsKaCRToQ63vd1W9FVYhZDA3wAmEwy5/hOO4/EqZiRI
	CDihYcY+aXXEtBBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Use guard(msi_desc_lock) where applicable
Cc: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250319105506.322536126@linutronix.de>
References: <20250319105506.322536126@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174422487259.31282.18230412778651568636.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     497f68cff6219713a66a70a45e1fa4caf237a76b
Gitweb:        https://git.kernel.org/tip/497f68cff6219713a66a70a45e1fa4caf237a76b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:56:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Apr 2025 20:47:29 +02:00

PCI/MSI: Use guard(msi_desc_lock) where applicable

Convert the trivial cases of msi_desc_lock/unlock() pairs.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/all/20250319105506.322536126@linutronix.de

---
 drivers/pci/msi/api.c |  6 ++----
 drivers/pci/msi/msi.c | 12 ++++++------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 17ec633..e686400 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -53,10 +53,9 @@ void pci_disable_msi(struct pci_dev *dev)
 	if (!pci_msi_enabled() || !dev || !dev->msi_enabled)
 		return;
 
-	msi_lock_descs(&dev->dev);
+	guard(msi_descs_lock)(&dev->dev);
 	pci_msi_shutdown(dev);
 	pci_free_msi_irqs(dev);
-	msi_unlock_descs(&dev->dev);
 }
 EXPORT_SYMBOL(pci_disable_msi);
 
@@ -196,10 +195,9 @@ void pci_disable_msix(struct pci_dev *dev)
 	if (!pci_msi_enabled() || !dev || !dev->msix_enabled)
 		return;
 
-	msi_lock_descs(&dev->dev);
+	guard(msi_descs_lock)(&dev->dev);
 	pci_msix_shutdown(dev);
 	pci_free_msi_irqs(dev);
-	msi_unlock_descs(&dev->dev);
 }
 EXPORT_SYMBOL(pci_disable_msix);
 
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 6569ba3..3283baa 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -870,13 +870,13 @@ void __pci_restore_msix_state(struct pci_dev *dev)
 
 	write_msg = arch_restore_msi_irqs(dev);
 
-	msi_lock_descs(&dev->dev);
-	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
-		if (write_msg)
-			__pci_write_msi_msg(entry, &entry->msg);
-		pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);
+	scoped_guard (msi_descs_lock, &dev->dev) {
+		msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
+			if (write_msg)
+				__pci_write_msi_msg(entry, &entry->msg);
+			pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);
+		}
 	}
-	msi_unlock_descs(&dev->dev);
 
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }

