Return-Path: <linux-tip-commits+bounces-6956-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D49DBE5336
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 21:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0725D3B2176
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 19:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C985E28934F;
	Thu, 16 Oct 2025 19:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NSyQyPK0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sRCpSltN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F41D2641C6;
	Thu, 16 Oct 2025 19:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760642013; cv=none; b=Mhar0tKWZ9a5m804walBhO/OUqxlDuKlTLe2GVBXFpqIznwgzeP2+stNTdU40IUmrYZM5tyKCEsL0zzR4buoC3N/WKBG4J/NJb9bRL6vYCX6/tRTkgMRw4j4WIwvlLp151t7xnhXwUkgzKEBWU8bhYjMF6HABwsa/J5oj0xFPsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760642013; c=relaxed/simple;
	bh=kcrsU+3GdA0P7dZcwGiKSfbK6cq4K3pJOc0XFvqGoZo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nWQ16/saFaEp6IW6Q5VOz3VmovBS/aXo8NmigTbr/98eK3Uj/9M4UobaqD47QYpBPJXO11ksJ0R05qQvZMxnYDoZDnDgix3jP0RGFZW5RNN9Kmsyfh+eUZWxjNWGje3jGAqQsZO+bZV2abXIZ7EHO/QyuhXAM4aTpZYi3j3BkWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NSyQyPK0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sRCpSltN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 19:13:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760642009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CMbrYh+DLLiOlTtYtMhiWSP4nyYQSXv5WjZ5OWVQcpY=;
	b=NSyQyPK0EcKTDEeuGLZUba4YWdSrUs6edCkggfmWSAXoFV6NmznsQh08ctzCqfw3N6jsT4
	bY8k4FT38x06kvfxC1+eNCFmYrJY4az2ZOiZVSPWOgrqKpxbVlBZd1W9WbSSVEXL1deWa2
	lU9oBRRB+NcJu5Dk5ficjgUpvEGO+v1AT45z6pjNGx0fs0bUTigsabOgRRpERiA/di+eWW
	M5xWsHb6kbd/s6ku0xph4LWsKrqgcFHMG7wnSmB4ItuB06E4VZrsi0T7ruZiCiSm3FlfEz
	BuQwxgIcRqf/g4mtatqcdPNp5FHeWWY1yDF48Q10MZYyMqZsB6Obxfc4sKM0LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760642009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CMbrYh+DLLiOlTtYtMhiWSP4nyYQSXv5WjZ5OWVQcpY=;
	b=sRCpSltNMsy1pLzm9uLVF8/lSjdIi0HwxjQjISSuMZICl8bV355lO9/k3UABPmFicZ+2SJ
	3mlzBIODaEayzNDA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Delete pci_msi_create_irq_domain()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250721063626.3026756-1-namcao@linutronix.de>
References: <20250721063626.3026756-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176064200800.709179.14565929712838113549.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     dce745009349fc391271c9415d5e242781ddadd7
Gitweb:        https://git.kernel.org/tip/dce745009349fc391271c9415d5e242781d=
dadd7
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Mon, 21 Jul 2025 08:36:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 21:09:52 +02:00

PCI/MSI: Delete pci_msi_create_irq_domain()

pci_msi_create_irq_domain() is now unused. Delete it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/msi/irqdomain.c | 90 +------------------------------------
 include/linux/msi.h         |  3 +-
 2 files changed, 93 deletions(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index ce741ed..a329060 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -49,96 +49,6 @@ static void pci_msi_domain_write_msg(struct irq_data *irq_=
data, struct msi_msg *
 		__pci_write_msi_msg(desc, msg);
 }
=20
-/**
- * pci_msi_domain_calc_hwirq - Generate a unique ID for an MSI source
- * @desc:	Pointer to the MSI descriptor
- *
- * The ID number is only used within the irqdomain.
- */
-static irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
-{
-	struct pci_dev *dev =3D msi_desc_to_pci_dev(desc);
-
-	return (irq_hw_number_t)desc->msi_index |
-		pci_dev_id(dev) << 11 |
-		((irq_hw_number_t)(pci_domain_nr(dev->bus) & 0xFFFFFFFF)) << 27;
-}
-
-static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,
-				    struct msi_desc *desc)
-{
-	arg->desc =3D desc;
-	arg->hwirq =3D pci_msi_domain_calc_hwirq(desc);
-}
-
-static struct msi_domain_ops pci_msi_domain_ops_default =3D {
-	.set_desc	=3D pci_msi_domain_set_desc,
-};
-
-static void pci_msi_domain_update_dom_ops(struct msi_domain_info *info)
-{
-	struct msi_domain_ops *ops =3D info->ops;
-
-	if (ops =3D=3D NULL) {
-		info->ops =3D &pci_msi_domain_ops_default;
-	} else {
-		if (ops->set_desc =3D=3D NULL)
-			ops->set_desc =3D pci_msi_domain_set_desc;
-	}
-}
-
-static void pci_msi_domain_update_chip_ops(struct msi_domain_info *info)
-{
-	struct irq_chip *chip =3D info->chip;
-
-	BUG_ON(!chip);
-	if (!chip->irq_write_msi_msg)
-		chip->irq_write_msi_msg =3D pci_msi_domain_write_msg;
-	if (!chip->irq_mask)
-		chip->irq_mask =3D pci_msi_mask_irq;
-	if (!chip->irq_unmask)
-		chip->irq_unmask =3D pci_msi_unmask_irq;
-}
-
-/**
- * pci_msi_create_irq_domain - Create a MSI interrupt domain
- * @fwnode:	Optional fwnode of the interrupt controller
- * @info:	MSI domain info
- * @parent:	Parent irq domain
- *
- * Updates the domain and chip ops and creates a MSI interrupt domain.
- *
- * Returns:
- * A domain pointer or NULL in case of failure.
- */
-struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
-					     struct msi_domain_info *info,
-					     struct irq_domain *parent)
-{
-	if (WARN_ON(info->flags & MSI_FLAG_LEVEL_CAPABLE))
-		info->flags &=3D ~MSI_FLAG_LEVEL_CAPABLE;
-
-	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
-		pci_msi_domain_update_dom_ops(info);
-	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
-		pci_msi_domain_update_chip_ops(info);
-
-	/* Let the core code free MSI descriptors when freeing interrupts */
-	info->flags |=3D MSI_FLAG_FREE_MSI_DESCS;
-
-	info->flags |=3D MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS;
-	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
-		info->flags |=3D MSI_FLAG_MUST_REACTIVATE;
-
-	/* PCI-MSI is oneshot-safe */
-	info->chip->flags |=3D IRQCHIP_ONESHOT_SAFE;
-	/* Let the core update the bus token */
-	info->bus_token =3D DOMAIN_BUS_PCI_MSI;
-
-	return msi_create_irq_domain(fwnode, info, parent);
-}
-EXPORT_SYMBOL_GPL(pci_msi_create_irq_domain);
-
 /*
  * Per device MSI[-X] domain functionality
  */
diff --git a/include/linux/msi.h b/include/linux/msi.h
index d415dd1..8003e32 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -701,9 +701,6 @@ void __pci_read_msi_msg(struct msi_desc *entry, struct ms=
i_msg *msg);
 void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void pci_msi_mask_irq(struct irq_data *data);
 void pci_msi_unmask_irq(struct irq_data *data);
-struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
-					     struct msi_domain_info *info,
-					     struct irq_domain *parent);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pd=
ev);
 u32 pci_msi_map_rid_ctlr_node(struct pci_dev *pdev, struct device_node **nod=
e);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);

