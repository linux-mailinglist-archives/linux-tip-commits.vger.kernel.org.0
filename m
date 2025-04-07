Return-Path: <linux-tip-commits+bounces-4735-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 586E7A7E263
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 16:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176951889B35
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 14:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E312F1FBCA9;
	Mon,  7 Apr 2025 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wHAsubBL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F5FwCJf2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346001FA267;
	Mon,  7 Apr 2025 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036311; cv=none; b=sV8+WTicC6DGPLfwmXYyYfxCLTQaBpGgQF6H5d5L6AYMsEuz20kDtFr8Pb9IU0qYJGn6CuAvtcs6E1kqrAxbfjduLFNETd+9nBF79uJEw7SWNTUFNfSRzi/183J14mqC6DoCGaZtndFl/yoapT5iZJAenpt17Vzo+gGFkOfmc1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036311; c=relaxed/simple;
	bh=mFPM/iOUfgxrDM5AVdDuUuGk+KClM6fXclEJtneaaUw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=o/N0IzzHxSTiWDAkpwH0T82GQ1fzNOvFtEuwxoCZCYeCPXYHzwibAYPsfSORR8XmHSmbK+Y//sX9pEDz00U1gd6m4TrLaUa/flyQtCf8HNNm9u69j534iP0tcPvtoP0yKTnkHMX3I5encEFwp8Bo+IffQ7XpTrS9Ab0lXYbjkhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wHAsubBL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F5FwCJf2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 14:31:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744036308;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CSinlBAxDoQ4Ly2iBlIiuJJ/3Q4l9vgqiVyxVmQfjPA=;
	b=wHAsubBLiCz9lPz0Q0MeVy2/F21HaAuF6j5pfFmv6h6FI7XJHr5kCNV9VOLI3wjHzV4cma
	Xl9exxLUIydjFJqnNAMhWNmrigOgQ4z3dV0VfULIt9+dO/OCV1jCB8flA1IxrUjgUHcA0X
	3KqWe6BDDZ+rVSQbeiqlz7OrbGpkAiK3pBIXZDv3GXUUm0iq7/SFVVkm1JW+EzYQbDsWz6
	P7LWH7jbf/RgewJIPQpPrDQultlQunnB253EWt/2IzGGw2SAOogqsu5ZpmpmCfTJ/J1UKS
	1mK0Z41/RAfKqrfgdmKNtLdx9Q8mS2HWnmFHxLgaApdP+Yb0+TXX3p0Y1Qn21A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744036308;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CSinlBAxDoQ4Ly2iBlIiuJJ/3Q4l9vgqiVyxVmQfjPA=;
	b=F5FwCJf2dw5WjkHkcDS1KM/ZX36QpPpnxJlKOxV6O721Y4Pr+K8XimC6RAexImUqidQvpn
	+KeCPu758MYR52DQ==
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
Message-ID: <174403630810.31282.11800259603919665734.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     f40f51012a48b821b10cd71590807b2bfe40fb45
Gitweb:        https://git.kernel.org/tip/f40f51012a48b821b10cd71590807b2bfe40fb45
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:56:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 16:24:55 +02:00

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

