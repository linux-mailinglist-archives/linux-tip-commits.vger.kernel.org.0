Return-Path: <linux-tip-commits+bounces-1725-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4391F9351C3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 20:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F387A282943
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 18:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D2F1474CE;
	Thu, 18 Jul 2024 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pPQQUCKk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BoJ88evp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6616146A70;
	Thu, 18 Jul 2024 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327948; cv=none; b=aji1Xc7T0TvXQG+fdLgP6qGUuNdirlbotvZklMKXm4BpXrr5o2IjeOsj3Pl/Ubx5ajZaH8mMutA2D83uaWMivv3XwjZRn8KYjQfTTkMFnBGk4QMqRSe/RiHVpxb76vptGtG11b1WPEJ9PKx/ShebhCmIrw8s8sJ61CqcburYF7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327948; c=relaxed/simple;
	bh=hTPK6bkin3NQydRxxPkIuZne09wsfS2vuhODeG/BHGo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=t0AsuGS8vJqdU+niyXMRwJS628YruR/7zj6riR05COHKtsCkohYlNaPjaIOqhtEOwnoX6HO2SJNWCDU3+KgXj8HoEd2Kjyks74JpBByaxOb2jwiEipLI763GXHdu8lJZ5YQM8gx9f8tSDYpOEVYi1PGGNsTfz1bSFPgsylw9uJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pPQQUCKk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BoJ88evp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jul 2024 18:39:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721327942;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHvffsjI5F2MU9Bl2JtsXH64RLNsDzDKId66mAqYMXA=;
	b=pPQQUCKkVCa4SYjwfZHkFxnZMIsE89KRvjBdS+wb41D0sCiMa9hYmuIUzIrBT14/6en033
	iUSRmdxd66xk583AAd3b35ENaqkya6cQHbbn080Wwm7n+rEiQiSAo7HQnqmSa7D7aJeq28
	p80h4cx+VP1b1zYm4q+fUF15NKlhHViuh1JCmK/vKY4XJd/YWHSYeyHujHT165aA6XIo7l
	PhvCw3WzZo7VTCyyxnd5lhdOllNRVfan31HXtIsFffspJjSR3AnvrEbVHJx3miLZyVvhso
	XzqWOgjFnfyHFeeQA5+Fznr+h7B3YYY7s3P2Bk0Wy9AGN+C5iN0e084Mnm1Tfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721327942;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHvffsjI5F2MU9Bl2JtsXH64RLNsDzDKId66mAqYMXA=;
	b=BoJ88evpKwW+34sSip0Gz+Odec6ffBTELST+1eHbZn9CNK/AKu9nufrNyoXsdSoTu1C7ym
	T48ePOXOIOXSxMBA==
From: "tip-bot2 for Shivamurthy Shastri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Provide MSI_FLAG_PCI_MSI_MASK_PARENT
Cc: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87ed8j34pj.ffs@tglx>
References: <87ed8j34pj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172132794252.2215.13409254332507199526.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     7d189c77106ed6df09829f7a419e35ada67b2bd0
Gitweb:        https://git.kernel.org/tip/7d189c77106ed6df09829f7a419e35ada67b2bd0
Author:        Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
AuthorDate:    Wed, 26 Jun 2024 21:05:12 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jul 2024 20:31:19 +02:00

PCI/MSI: Provide MSI_FLAG_PCI_MSI_MASK_PARENT

Most ARM(64) PCI/MSI domains mask and unmask in the parent domain after or
before the PCI mask/unmask operation takes place. So there are more than a
dozen of the same wrapper implementation all over the place.

Don't make the same mistake with the new per device PCI/MSI domains and
provide a new MSI feature flag, which lets the domain implementation
enable this sequence in the PCI/MSI code.

Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/87ed8j34pj.ffs@tglx

---
 drivers/pci/msi/irqdomain.c | 20 ++++++++++++++++++++
 include/linux/msi.h         |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 03d2dd2..5691257 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -148,17 +148,35 @@ static void pci_device_domain_set_desc(msi_alloc_info_t *arg, struct msi_desc *d
 	arg->hwirq = desc->msi_index;
 }
 
+static __always_inline void cond_mask_parent(struct irq_data *data)
+{
+	struct msi_domain_info *info = data->domain->host_data;
+
+	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
+		irq_chip_mask_parent(data);
+}
+
+static __always_inline void cond_unmask_parent(struct irq_data *data)
+{
+	struct msi_domain_info *info = data->domain->host_data;
+
+	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
+		irq_chip_unmask_parent(data);
+}
+
 static void pci_irq_mask_msi(struct irq_data *data)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
 
 	pci_msi_mask(desc, BIT(data->irq - desc->irq));
+	cond_mask_parent(data);
 }
 
 static void pci_irq_unmask_msi(struct irq_data *data)
 {
 	struct msi_desc *desc = irq_data_get_msi_desc(data);
 
+	cond_unmask_parent(data);
 	pci_msi_unmask(desc, BIT(data->irq - desc->irq));
 }
 
@@ -195,10 +213,12 @@ static const struct msi_domain_template pci_msi_template = {
 static void pci_irq_mask_msix(struct irq_data *data)
 {
 	pci_msix_mask(irq_data_get_msi_desc(data));
+	cond_mask_parent(data);
 }
 
 static void pci_irq_unmask_msix(struct irq_data *data)
 {
+	cond_unmask_parent(data);
 	pci_msix_unmask(irq_data_get_msi_desc(data));
 }
 
diff --git a/include/linux/msi.h b/include/linux/msi.h
index dc27cf3..04f33e7 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -556,6 +556,8 @@ enum {
 	MSI_FLAG_USE_DEV_FWNODE		= (1 << 7),
 	/* Set parent->dev into domain->pm_dev on device domain creation */
 	MSI_FLAG_PARENT_PM_DEV		= (1 << 8),
+	/* Support for parent mask/unmask */
+	MSI_FLAG_PCI_MSI_MASK_PARENT	= (1 << 9),
 
 	/* Mask for the generic functionality */
 	MSI_GENERIC_FLAGS_MASK		= GENMASK(15, 0),

