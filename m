Return-Path: <linux-tip-commits+bounces-7714-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 281AACBFF3E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 22:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5E1830341FF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 21:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF9D33120A;
	Mon, 15 Dec 2025 21:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lLgcBF4D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zUK/aw2z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A8A337105;
	Mon, 15 Dec 2025 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834489; cv=none; b=NRiwRv2vvQ0HhG9fdg/lPrywuAsAndXrNUveMPHZVZX2Xu2uK75M6FHFawhFrO3B/hKDli+C9T+pjacxTsrP5A8d2R5T0GTwA0mftvLnsjhFM41roYjvgeEvIWJAbr0slOP5/aVUHDtZXBLFllHLENXXSnUJp+v5ZraqyMm5HJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834489; c=relaxed/simple;
	bh=2NG0dFByZk1cQwgG1IeKkpRhIY5EGgvh0lsOL4zPpsM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BvxWCQtJLhS6mgNALz1vglu376xLmJBUZ6ivAglve3HRGLwtOWVinNt75UiTxf4KBzSIb+MfBZWRSLBGuZSwfDsT7800fgtOTITihvWm4X4wjLJTgqq9IadxQDkDPBpVY8a8dSuOwv9qEGF4L007iuhLiOCzPRQAWKvZV/OdYtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lLgcBF4D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zUK/aw2z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 21:34:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765834486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TG9CiMCkhx9pK6XBymfZoeF7IoYEyeogxykbbBBSLoA=;
	b=lLgcBF4Dqb5mt5Qyvg5KA5Y+qaZwoXABO+M7Hha5eNwx3B7rk3l9FAIkxWPdJEC5CpVqTK
	i4C+R/D5suOJLH3HMQamKSoOKWxi4eHQxY0V0NZdNRBX2d0TzJNE/IAcc7xnBS2VR2c6L5
	U6KBMSUhdy3X1JNU3BfxaVbGF6eWmMzEeT+HuOsEO2U9OxUHQHZELgGVX8BALIxlepvbT2
	0uDU3qJHFQZX1zmzUucgryf817zppFZTvp2mNAyer+RaSboxA6QzrCnmqC/xUHU0qqVn+G
	ipsOFs7tsB8ie2shJ84o0ELsfWBremZBB4brEHR+UEUeJzPai5f3pBWEdnCwLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765834486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TG9CiMCkhx9pK6XBymfZoeF7IoYEyeogxykbbBBSLoA=;
	b=zUK/aw2ziUNjkok2Ej4QzqfjWjFOvinwcw9UdjE0SbzmjNuIrs/PbsS5ERIFr96x7nKIUn
	RL1rOANI2CbrjFCg==
From: "tip-bot2 for Radu Rendec" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI: dwc: Code cleanup
Cc: Thomas Gleixner <tglx@linutronix.de>, Radu Rendec <rrendec@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251128212055.1409093-3-rrendec@redhat.com>
References: <20251128212055.1409093-3-rrendec@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176583448512.510.18311082295755039007.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     f1875091a01dd634ff5f8b6fc57ab874f755c415
Gitweb:        https://git.kernel.org/tip/f1875091a01dd634ff5f8b6fc57ab874f75=
5c415
Author:        Radu Rendec <rrendec@redhat.com>
AuthorDate:    Fri, 28 Nov 2025 16:20:54 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Dec 2025 22:30:48 +01:00

PCI: dwc: Code cleanup

Code cleanup with no functional changes. These changes were originally
made by Thomas Gleixner (see Link tag below) in a patch that was never
submitted as is. Other parts of that patch were eventually submitted as
commit 8e717112caf3 ("PCI: dwc: Switch to msi_create_parent_irq_domain()")
and the remaining parts are the code cleanup changes:

    - Use guard()/scoped_guard() instead of open-coded lock/unlock.
    - Return void in a few functions whose return value is never used.
    - Simplify dw_handle_msi_irq() by using for_each_set_bit().

One notable deviation from the original patch is that it reverts back to a
simple 1 by 1 iteration over the controllers inside dw_handle_msi_irq.  The
reason is that with the original changes, the IRQ offset was calculated
incorrectly.

This prepares the ground for enabling MSI affinity support, which was
originally part of that same series that Thomas Gleixner prepared.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Radu Rendec <rrendec@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/linux-pci/878qpg4o4t.ffs@tglx/
Link: https://patch.msgid.link/20251128212055.1409093-3-rrendec@redhat.com
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 98 ++++----------
 drivers/pci/controller/dwc/pcie-designware.h      |  7 +-
 2 files changed, 34 insertions(+), 71 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/=
controller/dwc/pcie-designware-host.c
index 372207c..25ad1ae 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -46,35 +46,25 @@ static const struct msi_parent_ops dw_pcie_msi_parent_ops=
 =3D {
 };
=20
 /* MSI int handler */
-irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
+void dw_handle_msi_irq(struct dw_pcie_rp *pp)
 {
-	int i, pos;
-	unsigned long val;
-	u32 status, num_ctrls;
-	irqreturn_t ret =3D IRQ_NONE;
 	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
+	unsigned int i, num_ctrls;
=20
 	num_ctrls =3D pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
=20
 	for (i =3D 0; i < num_ctrls; i++) {
-		status =3D dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
-					   (i * MSI_REG_CTRL_BLOCK_SIZE));
+		unsigned int reg_off =3D i * MSI_REG_CTRL_BLOCK_SIZE;
+		unsigned int irq_off =3D i * MAX_MSI_IRQS_PER_CTRL;
+		unsigned long status, pos;
+
+		status =3D dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS + reg_off);
 		if (!status)
 			continue;
=20
-		ret =3D IRQ_HANDLED;
-		val =3D status;
-		pos =3D 0;
-		while ((pos =3D find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
-					    pos)) !=3D MAX_MSI_IRQS_PER_CTRL) {
-			generic_handle_domain_irq(pp->irq_domain,
-						  (i * MAX_MSI_IRQS_PER_CTRL) +
-						  pos);
-			pos++;
-		}
+		for_each_set_bit(pos, &status, MAX_MSI_IRQS_PER_CTRL)
+			generic_handle_domain_irq(pp->irq_domain, irq_off + pos);
 	}
-
-	return ret;
 }
=20
 /* Chained MSI interrupt service routine */
@@ -95,13 +85,10 @@ static void dw_pci_setup_msi_msg(struct irq_data *d, stru=
ct msi_msg *msg)
 {
 	struct dw_pcie_rp *pp =3D irq_data_get_irq_chip_data(d);
 	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
-	u64 msi_target;
-
-	msi_target =3D (u64)pp->msi_data;
+	u64 msi_target =3D (u64)pp->msi_data;
=20
 	msg->address_lo =3D lower_32_bits(msi_target);
 	msg->address_hi =3D upper_32_bits(msi_target);
-
 	msg->data =3D d->hwirq;
=20
 	dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
@@ -113,18 +100,14 @@ static void dw_pci_bottom_mask(struct irq_data *d)
 	struct dw_pcie_rp *pp =3D irq_data_get_irq_chip_data(d);
 	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
 	unsigned int res, bit, ctrl;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&pp->lock, flags);
=20
+	guard(raw_spinlock)(&pp->lock);
 	ctrl =3D d->hwirq / MAX_MSI_IRQS_PER_CTRL;
 	res =3D ctrl * MSI_REG_CTRL_BLOCK_SIZE;
 	bit =3D d->hwirq % MAX_MSI_IRQS_PER_CTRL;
=20
 	pp->irq_mask[ctrl] |=3D BIT(bit);
 	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res, pp->irq_mask[ctrl]);
-
-	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
=20
 static void dw_pci_bottom_unmask(struct irq_data *d)
@@ -132,18 +115,14 @@ static void dw_pci_bottom_unmask(struct irq_data *d)
 	struct dw_pcie_rp *pp =3D irq_data_get_irq_chip_data(d);
 	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
 	unsigned int res, bit, ctrl;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&pp->lock, flags);
=20
+	guard(raw_spinlock)(&pp->lock);
 	ctrl =3D d->hwirq / MAX_MSI_IRQS_PER_CTRL;
 	res =3D ctrl * MSI_REG_CTRL_BLOCK_SIZE;
 	bit =3D d->hwirq % MAX_MSI_IRQS_PER_CTRL;
=20
 	pp->irq_mask[ctrl] &=3D ~BIT(bit);
 	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res, pp->irq_mask[ctrl]);
-
-	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
=20
 static void dw_pci_bottom_ack(struct irq_data *d)
@@ -160,54 +139,42 @@ static void dw_pci_bottom_ack(struct irq_data *d)
 }
=20
 static struct irq_chip dw_pci_msi_bottom_irq_chip =3D {
-	.name =3D "DWPCI-MSI",
-	.irq_ack =3D dw_pci_bottom_ack,
-	.irq_compose_msi_msg =3D dw_pci_setup_msi_msg,
-	.irq_mask =3D dw_pci_bottom_mask,
-	.irq_unmask =3D dw_pci_bottom_unmask,
+	.name			=3D "DWPCI-MSI",
+	.irq_ack		=3D dw_pci_bottom_ack,
+	.irq_compose_msi_msg	=3D dw_pci_setup_msi_msg,
+	.irq_mask		=3D dw_pci_bottom_mask,
+	.irq_unmask		=3D dw_pci_bottom_unmask,
 };
=20
-static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
-				    unsigned int virq, unsigned int nr_irqs,
-				    void *args)
+static int dw_pcie_irq_domain_alloc(struct irq_domain *domain, unsigned int =
virq,
+				    unsigned int nr_irqs, void *args)
 {
 	struct dw_pcie_rp *pp =3D domain->host_data;
-	unsigned long flags;
-	u32 i;
 	int bit;
=20
-	raw_spin_lock_irqsave(&pp->lock, flags);
-
-	bit =3D bitmap_find_free_region(pp->msi_irq_in_use, pp->num_vectors,
-				      order_base_2(nr_irqs));
-
-	raw_spin_unlock_irqrestore(&pp->lock, flags);
+	scoped_guard (raw_spinlock_irq, &pp->lock) {
+		bit =3D bitmap_find_free_region(pp->msi_irq_in_use, pp->num_vectors,
+					      order_base_2(nr_irqs));
+	}
=20
 	if (bit < 0)
 		return -ENOSPC;
=20
-	for (i =3D 0; i < nr_irqs; i++)
-		irq_domain_set_info(domain, virq + i, bit + i,
-				    pp->msi_irq_chip,
-				    pp, handle_edge_irq,
-				    NULL, NULL);
-
+	for (unsigned int i =3D 0; i < nr_irqs; i++) {
+		irq_domain_set_info(domain, virq + i, bit + i, pp->msi_irq_chip,
+				    pp, handle_edge_irq, NULL, NULL);
+	}
 	return 0;
 }
=20
-static void dw_pcie_irq_domain_free(struct irq_domain *domain,
-				    unsigned int virq, unsigned int nr_irqs)
+static void dw_pcie_irq_domain_free(struct irq_domain *domain, unsigned int =
virq,
+				    unsigned int nr_irqs)
 {
 	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
 	struct dw_pcie_rp *pp =3D domain->host_data;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&pp->lock, flags);
=20
-	bitmap_release_region(pp->msi_irq_in_use, d->hwirq,
-			      order_base_2(nr_irqs));
-
-	raw_spin_unlock_irqrestore(&pp->lock, flags);
+	guard(raw_spinlock_irq)(&pp->lock);
+	bitmap_release_region(pp->msi_irq_in_use, d->hwirq, order_base_2(nr_irqs));
 }
=20
 static const struct irq_domain_ops dw_pcie_msi_domain_ops =3D {
@@ -241,8 +208,7 @@ void dw_pcie_free_msi(struct dw_pcie_rp *pp)
=20
 	for (ctrl =3D 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
 		if (pp->msi_irq[ctrl] > 0)
-			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
-							 NULL, NULL);
+			irq_set_chained_handler_and_data(pp->msi_irq[ctrl], NULL, NULL);
 	}
=20
 	irq_domain_remove(pp->irq_domain);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/contr=
oller/dwc/pcie-designware.h
index 3168595..403f6cf 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -821,7 +821,7 @@ static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct=
 dw_pcie *pci)
 #ifdef CONFIG_PCIE_DW_HOST
 int dw_pcie_suspend_noirq(struct dw_pcie *pci);
 int dw_pcie_resume_noirq(struct dw_pcie *pci);
-irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp);
+void dw_handle_msi_irq(struct dw_pcie_rp *pp);
 void dw_pcie_msi_init(struct dw_pcie_rp *pp);
 int dw_pcie_msi_host_init(struct dw_pcie_rp *pp);
 void dw_pcie_free_msi(struct dw_pcie_rp *pp);
@@ -842,10 +842,7 @@ static inline int dw_pcie_resume_noirq(struct dw_pcie *p=
ci)
 	return 0;
 }
=20
-static inline irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
-{
-	return IRQ_NONE;
-}
+static inline void dw_handle_msi_irq(struct dw_pcie_rp *pp) { }
=20
 static inline void dw_pcie_msi_init(struct dw_pcie_rp *pp)
 { }

