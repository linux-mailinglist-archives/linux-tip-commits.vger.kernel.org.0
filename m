Return-Path: <linux-tip-commits+bounces-1670-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC6C92D679
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 18:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EF9EB29BE3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 16:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56B6199EAC;
	Wed, 10 Jul 2024 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0bnDpGIu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MIDpl++q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BD8194C76;
	Wed, 10 Jul 2024 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628759; cv=none; b=B69jJSeqb29NjYDMVN3AhcVshOedE28ZLbk2XwcKNzdTfaotp0AgJ68lWv0TwHp/fq2PX504LgTixq3U01AuPk9kvXkvgh8jkmFeZLEO6pVg+7RhNr10A9FgdnEyXEyDQh1PUT0QBUyrAep1SGAgSFolHP/J0IlxL4leYqUq/lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628759; c=relaxed/simple;
	bh=mtd75yFZxtytaUaBHke0UfoZiAtqt2nehHx/5pBxF6Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hBHpvDW1h0KXw6rNZvszj5QA09mZyX5BhJWLaOD3H9quKcdPrjkmb1sUIZxdvLVo0nQ1uhqQ/TKOZRQykucZ3/vB2iPEu56jQ4chXUPuwkeDlP8he7tA7/dVbk8i/b7WVVxihNqY6npSSwfj5WA6H98GF57tpLNCJsVHIYy5+cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0bnDpGIu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MIDpl++q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jul 2024 16:25:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720628755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IigpQ9uWNZ2SHk72Idjeq6bdQ/CTWQ7zgTSWQi4UtCM=;
	b=0bnDpGIumWrf9hRshCpwhvJ0213TO3isV2TWW9Q+jgbt3Nu4KYvCbg6LtfrSkkUz43lrbF
	bdTcrXETLvuNWk7ldX8uEOwHYcWExmiBk9bb0gQ1l+Ihimz00tykWBT/9jFbGgUhumUcX7
	3QdOekDKsEiK9D7S0FofE4mGAtsCisi0FnCLsxZvB2zg/tLK6WCDpsIVeeu40zq0a4iZyn
	NbFG/iQJZL8ZPWGhUc1cyZb86Tt5xzs2Ou0s3pO0QMNsvNDJSpnJ3dDIZd0gw/gVxTAlQN
	LibTroapa8b0Z1NDVY6dPbaVlJoB475jn881mNj7w6lBXxEzyazvDHN4H7AziA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720628755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IigpQ9uWNZ2SHk72Idjeq6bdQ/CTWQ7zgTSWQi4UtCM=;
	b=MIDpl++qHQb7fkeOhSUF8I3xCIMgfgJU2/zEm4DKJN5jUWL8KejZPucSd/lpffA9QhAN+4
	/VlHbjERcbEWehCA==
From: "tip-bot2 for Shivamurthy Shastri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Provide MSI_FLAG_PCI_MSI_MASK_PARENT
Cc: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <87ed8j34pj.ffs@tglx>
References: <87ed8j34pj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172062875551.2215.8934562341098722721.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     698c86faa99ae60a19aacbb74ec1df243bc5eba6
Gitweb:        https://git.kernel.org/tip/698c86faa99ae60a19aacbb74ec1df243bc5eba6
Author:        Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
AuthorDate:    Wed, 26 Jun 2024 21:05:12 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Jul 2024 18:19:23 +02:00

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

