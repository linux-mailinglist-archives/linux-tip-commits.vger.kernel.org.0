Return-Path: <linux-tip-commits+bounces-4728-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A62A7E287
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 16:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AB7A3B3B98
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 14:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163121F754E;
	Mon,  7 Apr 2025 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mdUZLW87";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hIgjX6KD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B0A1F63C1;
	Mon,  7 Apr 2025 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036305; cv=none; b=s53tb/Sj2d/HeEbF2HwT8zAzxtvrmIEaWsLl7T2jAKEMjLkMz4oOKwW4jPjJYmPGj76HMz1MqBEoHMLUey2gFRf55W35sMTIhgAcW9trK9y7j1bfmACXTyQWVRMmnGEX97jv9C2QO/8TYSg8cqvPCznhfh3U5aWMInYjQWSEd8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036305; c=relaxed/simple;
	bh=nDKrZBBu7EYmOMBlUltFFrHaoU8gLPzf89D735HJ24g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fqAY4tsOCFaShI9+hDZv+kw7tqrMfXFVUcb/FqIQRKV7dbznEG8sQ8qmuNlIt0hrs26ipMm18yxQumzJ5s3I30gODdYkwjkutPhdPddSp5z0WwveeWOVc9CaSbeEOQcRHsXrzYVBFYnjSniGgnsjSDKu4MJ8pHjsCWv1plz3xqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mdUZLW87; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hIgjX6KD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 14:31:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744036301;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EKSu0hF/eManmqfJq5sXvqFY1YwIIUtx7MYw/0/hpbc=;
	b=mdUZLW87o8lv2UYWlUAGQh8p2bbIEGweBPjCq0RAa04jGGlz9mkedIQ3pPenVISeTuFqSS
	nV2vMQPKwE9ak4JVvIcQ8NW7PqzTBpXrb9ib5FNLUyIJOZNXj3zicWyBHNCWEaGLNAe813
	P95aR3Gb+Rm7IVt2oQkLJI5rBP78TuLLaLQUWdew70cIL1+uZz8kr6bMUHNHBsLFem2207
	2CBbAC1g78e0LWvmaV061p/Fw7cREFsk7Qh8xVrvioCwB4C7bt/U20FW6+ZernkPSF1n4R
	SGyYPiWIqQVhsxwOu3bq8mI97Ap6iayPSFRLEvcrBwWiAlk7vrEUXxPx51WcpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744036301;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EKSu0hF/eManmqfJq5sXvqFY1YwIIUtx7MYw/0/hpbc=;
	b=hIgjX6KDC+Dk0nru2OUidGuZkoZU69GCBjyshn0F1arpNzgRxCnwL6BWiPXkjEVdTmgb8n
	asUL/1XkuhrZ9BCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/TPH: Replace the broken MSI-X control word update
Cc: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250319105506.744271447@linutronix.de>
References: <20250319105506.744271447@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174403630104.31282.14145727341805273040.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     a822d6e2d5228e45b6d03680b1a92b295864b285
Gitweb:        https://git.kernel.org/tip/a822d6e2d5228e45b6d03680b1a92b295864b285
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:56:58 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 16:24:56 +02:00

PCI/TPH: Replace the broken MSI-X control word update

The driver walks the MSI descriptors to test whether a descriptor exists
for a given index. That's just abuse of the MSI internals.

The same test can be done with a single function call by looking up whether
there is a Linux interrupt number assigned at the index.

What's worse is that the function is completely unserialized against
modifications of the MSI-X control by operations issued from the interrupt
core. It also brings the PCI/MSI-X internal cached control word out of
sync.

Remove the trainwreck and invoke the function provided by the PCI/MSI core
to update it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/all/20250319105506.744271447@linutronix.de




---
 drivers/pci/tph.c | 44 +-------------------------------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 07de59c..77fce5e 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -204,48 +204,6 @@ static u8 get_rp_completer_type(struct pci_dev *pdev)
 	return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
 }
 
-/* Write ST to MSI-X vector control reg - Return 0 if OK, otherwise -errno */
-static int write_tag_to_msix(struct pci_dev *pdev, int msix_idx, u16 tag)
-{
-#ifdef CONFIG_PCI_MSI
-	struct msi_desc *msi_desc = NULL;
-	void __iomem *vec_ctrl;
-	u32 val;
-	int err = 0;
-
-	msi_lock_descs(&pdev->dev);
-
-	/* Find the msi_desc entry with matching msix_idx */
-	msi_for_each_desc(msi_desc, &pdev->dev, MSI_DESC_ASSOCIATED) {
-		if (msi_desc->msi_index == msix_idx)
-			break;
-	}
-
-	if (!msi_desc) {
-		err = -ENXIO;
-		goto err_out;
-	}
-
-	/* Get the vector control register (offset 0xc) pointed by msix_idx */
-	vec_ctrl = pdev->msix_base + msix_idx * PCI_MSIX_ENTRY_SIZE;
-	vec_ctrl += PCI_MSIX_ENTRY_VECTOR_CTRL;
-
-	val = readl(vec_ctrl);
-	val &= ~PCI_MSIX_ENTRY_CTRL_ST;
-	val |= FIELD_PREP(PCI_MSIX_ENTRY_CTRL_ST, tag);
-	writel(val, vec_ctrl);
-
-	/* Read back to flush the update */
-	val = readl(vec_ctrl);
-
-err_out:
-	msi_unlock_descs(&pdev->dev);
-	return err;
-#else
-	return -ENODEV;
-#endif
-}
-
 /* Write tag to ST table - Return 0 if OK, otherwise -errno */
 static int write_tag_to_st_table(struct pci_dev *pdev, int index, u16 tag)
 {
@@ -346,7 +304,7 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
 
 	switch (loc) {
 	case PCI_TPH_LOC_MSIX:
-		err = write_tag_to_msix(pdev, index, tag);
+		err = pci_msix_write_tph_tag(pdev, index, tag);
 		break;
 	case PCI_TPH_LOC_CAP:
 		err = write_tag_to_st_table(pdev, index, tag);

