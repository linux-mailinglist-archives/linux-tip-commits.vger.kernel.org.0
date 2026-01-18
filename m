Return-Path: <linux-tip-commits+bounces-8059-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E59D393DC
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 11:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDE16303BE2D
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 10:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653ED2DCF46;
	Sun, 18 Jan 2026 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TQfeveUE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iphIdLAV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF55E191F98;
	Sun, 18 Jan 2026 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768730970; cv=none; b=extgHLBf7KTbHLHgirIBMmQQFTQBlRrAAvWhBVbCRB7p4cWY+4CcLCROHE2JnylcamMPUE5JHHnBNq84WpJge5YPjJZoaK69VVD2hBjBgUzqPHFTo0uMOl9mB0XD4OKYTgS0J568UupsgbFb+kl4MGVolU9vW+eb/eu23OxdGeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768730970; c=relaxed/simple;
	bh=6dPFAvy7tYtUo+lARw8Z4TjZBSkLtOjchdnSGqOBwX8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=py7piLirzvnfS81/tjm/FUUhILRA2viTL64qRxKo+whhq0GFrnNbmov3meRomPqC6U1QRoMwGWqvzRGrF/zSy0mHRzUC+6877FQ/aU2zZ7iSpRLLRuYPc2uWXzznN0lwaNowbfk5MDevZ5YY7ibXHJBnXrMhNXcNl+KLfs/H+r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TQfeveUE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iphIdLAV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Jan 2026 10:09:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768730965;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TV1u2F0AuTX5pm+/Iv/Z4LjLzHoHtTrlZ86xP7z7mGA=;
	b=TQfeveUEm2N7V3jMi8NW+oqdlDfGdAa/kkru13Tkgd3cwT4LuIrLlUza2jogInjhHJXiKm
	N17zX1xci8XHmXj6TniViVVbX+PtmmnA4oaSCbR5b7hhnm02hmyHfop4CKo8CvVOZNqguG
	3OdXZEn4H8yqpz6iYyr70ijyeXhKGOTRNBH3SmaVq7Wg4pwF13NEFsHUtBhdPbuWAV+QuM
	Mz0fOQwFsWNvOihkhf92vsGWRn58ewTBvJFs6w051OtLCJKVR5TQ+CLBttcgUqJYcSN5Ld
	07xPTv/j18yYGnAduRO4U9LH2dBLT2MJoM0QVT5Ss+QIGmkErRiS25kJ64LdwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768730965;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TV1u2F0AuTX5pm+/Iv/Z4LjLzHoHtTrlZ86xP7z7mGA=;
	b=iphIdLAV2DPdZpA1HjnafLG7gAYJ9yJlOe97vGSJwssGoNtQAvWb++VL9tkFJJe2JCyX1Z
	WAueZrWiacAIZ8Aw==
From: "tip-bot2 for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Make the pci_msi_map_rid_ctlr_node()
 interface firmware agnostic
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260115-gicv5-host-acpi-v3-2-c13a9a150388@kernel.org>
References: <20260115-gicv5-host-acpi-v3-2-c13a9a150388@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176873096087.510.7580845794598387422.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     93eb217ac06d13c1fda75553d220eac0b5ad9225
Gitweb:        https://git.kernel.org/tip/93eb217ac06d13c1fda75553d220eac0b5a=
d9225
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 15 Jan 2026 10:50:48 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 18 Jan 2026 11:07:57 +01:00

PCI/MSI: Make the pci_msi_map_rid_ctlr_node() interface firmware agnostic

To support booting with OF and ACPI seamlessly, GIC ITS parent code
requires the PCI/MSI irqdomain layer to implement a function to retrieve
an MSI controller fwnode and map an RID in a firmware agnostic way
(ie pci_msi_map_rid_ctlr_node()).

Convert pci_msi_map_rid_ctlr_node() to an OF agnostic interface
(fwnode_handle based) and update the GIC ITS MSI parent code to reflect
the pci_msi_map_rid_ctlr_node() change.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20260115-gicv5-host-acpi-v3-2-c13a9a150388@ker=
nel.org
---
 drivers/irqchip/irq-gic-its-msi-parent.c |  8 ++++----
 drivers/pci/msi/irqdomain.c              | 21 ++++++++++++++++-----
 include/linux/msi.h                      |  3 ++-
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-gic-its-msi-parent.c b/drivers/irqchip/irq-g=
ic-its-msi-parent.c
index 12f4522..4d1ad1e 100644
--- a/drivers/irqchip/irq-gic-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-its-msi-parent.c
@@ -104,7 +104,7 @@ static int its_pci_msi_prepare(struct irq_domain *domain,=
 struct device *dev,
 static int its_v5_pci_msi_prepare(struct irq_domain *domain, struct device *=
dev,
 				  int nvec, msi_alloc_info_t *info)
 {
-	struct device_node *msi_node =3D NULL;
+	struct fwnode_handle *msi_node =3D NULL;
 	struct msi_domain_info *msi_info;
 	struct pci_dev *pdev;
 	phys_addr_t pa;
@@ -116,15 +116,15 @@ static int its_v5_pci_msi_prepare(struct irq_domain *do=
main, struct device *dev,
=20
 	pdev =3D to_pci_dev(dev);
=20
-	rid =3D pci_msi_map_rid_ctlr_node(pdev, &msi_node);
+	rid =3D pci_msi_map_rid_ctlr_node(domain->parent, pdev, &msi_node);
 	if (!msi_node)
 		return -ENODEV;
=20
-	ret =3D its_translate_frame_address(msi_node, &pa);
+	ret =3D its_translate_frame_address(to_of_node(msi_node), &pa);
 	if (ret)
 		return -ENODEV;
=20
-	of_node_put(msi_node);
+	fwnode_handle_put(msi_node);
=20
 	/* ITS specific DeviceID */
 	info->scratchpad[0].ul =3D rid;
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index a329060..3a40386 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -376,23 +376,34 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domai=
n, struct pci_dev *pdev)
 }
=20
 /**
- * pci_msi_map_rid_ctlr_node - Get the MSI controller node and MSI requester=
 id (RID)
+ * pci_msi_map_rid_ctlr_node - Get the MSI controller fwnode_handle and MSI =
requester id (RID)
+ * @domain:	The interrupt domain
  * @pdev:	The PCI device
- * @node:	Pointer to store the MSI controller device node
+ * @node:	Pointer to store the MSI controller fwnode_handle
  *
- * Use the firmware data to find the MSI controller node for @pdev.
+ * Use the firmware data to find the MSI controller fwnode_handle for @pdev.
  * If found map the RID and initialize @node with it. @node value must
  * be set to NULL on entry.
  *
  * Returns: The RID.
  */
-u32 pci_msi_map_rid_ctlr_node(struct pci_dev *pdev, struct device_node **nod=
e)
+u32 pci_msi_map_rid_ctlr_node(struct irq_domain *domain, struct pci_dev *pde=
v,
+			      struct fwnode_handle **node)
 {
 	u32 rid =3D pci_dev_id(pdev);
=20
 	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
=20
-	return of_msi_xlate(&pdev->dev, node, rid);
+	/* Check whether the domain fwnode is an OF node */
+	if (irq_domain_get_of_node(domain)) {
+		struct device_node *msi_ctlr_node =3D NULL;
+
+		rid =3D of_msi_xlate(&pdev->dev, &msi_ctlr_node, rid);
+		if (msi_ctlr_node)
+			*node =3D of_fwnode_handle(msi_ctlr_node);
+	}
+
+	return rid;
 }
=20
 /**
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 94cfc37..fa41eed 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -703,7 +703,8 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct m=
si_msg *msg);
 void pci_msi_mask_irq(struct irq_data *data);
 void pci_msi_unmask_irq(struct irq_data *data);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pd=
ev);
-u32 pci_msi_map_rid_ctlr_node(struct pci_dev *pdev, struct device_node **nod=
e);
+u32 pci_msi_map_rid_ctlr_node(struct irq_domain *domain, struct pci_dev *pde=
v,
+			      struct fwnode_handle **node);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
 void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
 			   struct msi_desc *desc);

