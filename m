Return-Path: <linux-tip-commits+bounces-4564-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C06A718B7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Mar 2025 15:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65826177501
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Mar 2025 14:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95401F30C0;
	Wed, 26 Mar 2025 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X4jHQz57";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f9XfM/ht"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604F61F192E;
	Wed, 26 Mar 2025 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742999992; cv=none; b=sUWouSpWOEU66jACC0b0sr2/9JM/f2SYv0v66Diani66JmTDlUArsgW8NuAogO1zjgeqwQBSstfO/AgRTsjpUOLlETS8R/PbIDtozm+gmRSK0ZIq/WabO3g8Rq7uSnYfn2cNQsk/s/SdyOa5fHIaK7bk6qLrXrz2zAI0zoF/lJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742999992; c=relaxed/simple;
	bh=39aqIo2xz4Ol8cLnm6iE5OSq3M7FWInUydvY4kFRFG8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TfFzef5tCCq7+Awkvgen2ArwSgI4NL9sR5G9/dUnElMP0/d7HNnqfvUTI5xDhedcLoJftUf3ma53WqAPhwcLQFjKnSCO3C0ifQQf47tzLCdCLAZbbAcrV94CRart8CGK6gb1/0eC09AAHSG4AgiY8rvTRZifX2Qu4/adQEqpAlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X4jHQz57; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f9XfM/ht; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Mar 2025 14:39:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742999988;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPyMtws/0XIqxIMQcIBSUa4peOxdCuTdOTld/TGEtWo=;
	b=X4jHQz579ofAS6RGA/asRShN2MCPfOBd9Jo009fX4U2n0u5W7ECUSBLhwOPzsT0jsAx6DI
	k9dBVS1XQo5gh+R3mZfMN9ZChuAiEdJE64REfPxOvl9Kg3/lu2IYEUyvTnfUtfX3rnMqiR
	8oB8b5mUrHHR0GzaV7z1eVwUnDaIr1MIc9qOVpwQtV4mHLTJCfzi6KrW0vU4nTncllJMzP
	fCzjSVl1j2kYlJn0tddHYZEuQCKFKgmG/LrnMGLZsAvithOSH8RqzoO7dTO+Qnt6fDvyQG
	C7q4M5MtZCHTRL5CbWqkcQiuAX/Wbl6NQ6yYggEwYAiZchcKf76xJK+zKjAD6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742999988;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPyMtws/0XIqxIMQcIBSUa4peOxdCuTdOTld/TGEtWo=;
	b=f9XfM/ht888REuYdzwy7UKc6GddX3Fqxf1eNrwbkakspvAvnRkG1nls7JXvsqWDNKyN92s
	nheXn01VoE4jS6Cg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] PCI/MSI: Handle the NOMASK flag correctly for
 all PCI/MSI backends
Cc: Daniel Gomez <da.gomez@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87iknwyp2o.ffs@tglx>
References: <87iknwyp2o.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174299998368.14745.8248965655680348410.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     3ece3e8e5976c49c3f887e5923f998eabd54ff40
Gitweb:        https://git.kernel.org/tip/3ece3e8e5976c49c3f887e5923f998eabd54ff40
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Mar 2025 13:05:35 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 26 Mar 2025 15:28:43 +01:00

PCI/MSI: Handle the NOMASK flag correctly for all PCI/MSI backends

The conversion of the XEN specific global variable pci_msi_ignore_mask to a
MSI domain flag, missed the facts that:

    1) Legacy architectures do not provide a interrupt domain
    2) Parent MSI domains do not necessarily have a domain info attached
   
Both cases result in an unconditional NULL pointer dereference. This was
unfortunatly missed in review and testing revealed it late.

Cure this by using the existing pci_msi_domain_supports() helper, which
handles all possible cases correctly.

Fixes: c3164d2e0d18 ("PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag")
Reported-by: Daniel Gomez <da.gomez@kernel.org>
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Borislav Petkov <bp@alien8.de>
Tested-by: Daniel Gomez <da.gomez@kernel.org>
Link: https://lore.kernel.org/all/87iknwyp2o.ffs@tglx
Closes: https://lore.kernel.org/all/qn7fzggcj6qe6r6gdbwcz23pzdz2jx64aldccmsuheabhmjgrt@tawf5nfwuvw7
---
 drivers/pci/msi/msi.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index d741628..7058d59 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -285,8 +285,6 @@ static void pci_msi_set_enable(struct pci_dev *dev, int enable)
 static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
 			      struct irq_affinity_desc *masks)
 {
-	const struct irq_domain *d = dev_get_msi_domain(&dev->dev);
-	const struct msi_domain_info *info = d->host_data;
 	struct msi_desc desc;
 	u16 control;
 
@@ -297,7 +295,7 @@ static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
 	/* Lies, damned lies, and MSIs */
 	if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
 		control |= PCI_MSI_FLAGS_MASKBIT;
-	if (info->flags & MSI_FLAG_NO_MASK)
+	if (pci_msi_domain_supports(dev, MSI_FLAG_NO_MASK, DENY_LEGACY))
 		control &= ~PCI_MSI_FLAGS_MASKBIT;
 
 	desc.nvec_used			= nvec;
@@ -604,20 +602,18 @@ static void __iomem *msix_map_region(struct pci_dev *dev,
  */
 void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc)
 {
-	const struct irq_domain *d = dev_get_msi_domain(&dev->dev);
-	const struct msi_domain_info *info = d->host_data;
-
 	desc->nvec_used				= 1;
 	desc->pci.msi_attrib.is_msix		= 1;
 	desc->pci.msi_attrib.is_64		= 1;
 	desc->pci.msi_attrib.default_irq	= dev->irq;
 	desc->pci.mask_base			= dev->msix_base;
-	desc->pci.msi_attrib.can_mask		= !(info->flags & MSI_FLAG_NO_MASK) &&
-						  !desc->pci.msi_attrib.is_virtual;
 
-	if (desc->pci.msi_attrib.can_mask) {
+
+	if (!pci_msi_domain_supports(dev, MSI_FLAG_NO_MASK, DENY_LEGACY) &&
+	    !desc->pci.msi_attrib.is_virtual) {
 		void __iomem *addr = pci_msix_desc_addr(desc);
 
+		desc->pci.msi_attrib.can_mask = 1;
 		desc->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 	}
 }
@@ -715,8 +711,6 @@ static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *entries
 static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 				int nvec, struct irq_affinity *affd)
 {
-	const struct irq_domain *d = dev_get_msi_domain(&dev->dev);
-	const struct msi_domain_info *info = d->host_data;
 	int ret, tsize;
 	u16 control;
 
@@ -747,7 +741,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	/* Disable INTX */
 	pci_intx_for_msi(dev, 0);
 
-	if (!(info->flags & MSI_FLAG_NO_MASK)) {
+	if (!pci_msi_domain_supports(dev, MSI_FLAG_NO_MASK, DENY_LEGACY)) {
 		/*
 		 * Ensure that all table entries are masked to prevent
 		 * stale entries from firing in a crash kernel.

