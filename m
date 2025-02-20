Return-Path: <linux-tip-commits+bounces-3528-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C339DA3DCCD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Feb 2025 15:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381D23A4F4B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Feb 2025 14:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D06E1FBE8D;
	Thu, 20 Feb 2025 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wU1w6Yym";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OM51dTc4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A84A1FAC5F;
	Thu, 20 Feb 2025 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740061601; cv=none; b=fwL4u3tCNaBZMyCqTNz8hI3c9NBKaX7jE14tSqxqcISXw/CABeBrHtMCErJ4YNzERxOaSBoGQeNCoKZ5iDompIwP3z8SMVhhdCEnlXHX6YSQtdnspScSbGycm6BkRf63aIMqnTyEerH2fX52p3DlzZPmdyPOVlK8gGfC1ELztFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740061601; c=relaxed/simple;
	bh=Fd6Q3RX9W1tGQEEQt2wMQ6/+mmOXDbXmTTLUp1oa0J4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lLA5hhhGhfEZJNCuma2a2psPUU4ceM8gLonWUe1+sPu7wg9Iz3OuLmIFYlPyXT6yUYHSsB7EA5cTu9wj6oJte6FmGZK/sROheCss22uudWuDNeuShfSzaCAyKDcHq6DD48g0uxzc0ps+hAXiKVFbUx2uVyGwJcW2I86qpaj3/Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wU1w6Yym; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OM51dTc4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Feb 2025 14:26:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740061597;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Eo9a8KsaWqDFY+w9chW4fYLsjz90+fjbhcIhd+MNu4=;
	b=wU1w6YymOwGFqxaKSZVNAyeyhQZDswTHN+n6mQCEDjPmHPfRKruFXvCEBASuMzkcMNw1EM
	FNWM9EnTe+iu2bvHQHpl3D0j4Fqmszmr8CnTt9AhLPPyXOmVWzzA2uTLfQHiC/62wy+OYt
	XpDCqzrnzpmkr6ReHoqg/wPrWT7wBZSz9MxellUpnL/yOfFW6DLhJNQtQvbly7M/dFmtXh
	Zg6nZX89sOnbrQ9C9Unxf90pg1swdBKTx6KX4qGfJQ/Ay8X0QijsyQtQ42EE4BuFJ4QCy3
	MwzyN9c34vyUNCWBCdJdaUUw1mR1xwxU8SWrkrYSUzMSk/htko/qeYbX1FfNXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740061597;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Eo9a8KsaWqDFY+w9chW4fYLsjz90+fjbhcIhd+MNu4=;
	b=OM51dTc40dzXilMM6ChrIFwk455wLI653AyYQjTb/gWFjF5XnwzLilyK7ERvryaoVvppwe
	iusv28CO8xNOl0AQ==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/riscv-imsic: Special handling for
 non-atomic device MSI update
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250217085657.789309-11-apatel@ventanamicro.com>
References: <20250217085657.789309-11-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174006159337.10177.16850272820515463762.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     896f8e436f9951fa9ef68dab0a3d399ec3a6e1d7
Gitweb:        https://git.kernel.org/tip/896f8e436f9951fa9ef68dab0a3d399ec3a6e1d7
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Mon, 17 Feb 2025 14:26:56 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 Feb 2025 15:19:27 +01:00

irqchip/riscv-imsic: Special handling for non-atomic device MSI update

Devices, which have a non-atomic MSI update, might see an intermediate
state when changing the target IMSIC vector from one CPU to another.

To avoid losing interrupts due to this intermediate state, do the following
just like x86 APIC:

 1) First write a temporary IMSIC vector to the device which has the same
    MSI address as the old IMSIC vector and MSI data pointing to the new
    IMSIC vector.

 2) Next write the new IMSIC vector to the device.

Based on the above, the __imsic_local_sync() must check pending status of
both old MSI data and new MSI data on the old CPU. In addition, the
movement of IMSIC vector for non-atomic device MSI update must be done in
interrupt context using IRQCHIP_MOVE_DEFERRED.

Implememnt the logic and enforce the chip flag for PCI/MSI[X].

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250217085657.789309-11-apatel@ventanamicro.com

---
 drivers/irqchip/irq-riscv-imsic-platform.c | 87 ++++++++++++++++++---
 drivers/irqchip/irq-riscv-imsic-state.c    | 30 ++++++-
 2 files changed, 102 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 6bf5d63..b8ae67c 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -64,6 +64,11 @@ static int imsic_irq_retrigger(struct irq_data *d)
 	return 0;
 }
 
+static void imsic_irq_ack(struct irq_data *d)
+{
+	irq_move_irq(d);
+}
+
 static void imsic_irq_compose_vector_msg(struct imsic_vector *vec, struct msi_msg *msg)
 {
 	phys_addr_t msi_addr;
@@ -97,6 +102,21 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 				  bool force)
 {
 	struct imsic_vector *old_vec, *new_vec;
+	struct imsic_vector tmp_vec;
+
+	/*
+	 * Requirements for the downstream irqdomains (or devices):
+	 *
+	 * 1) Downstream irqdomains (or devices) with atomic MSI update can
+	 *    happily do imsic_irq_set_affinity() in the process-context on
+	 *    any CPU so the irqchip of such irqdomains must not set the
+	 *    IRQCHIP_MOVE_DEFERRED flag.
+	 *
+	 * 2) Downstream irqdomains (or devices) with non-atomic MSI update
+	 *    must use imsic_irq_set_affinity() in nterrupt-context upon
+	 *    the next device interrupt so the irqchip of such irqdomains
+	 *    must set the IRQCHIP_MOVE_DEFERRED flag.
+	 */
 
 	old_vec = irq_data_get_irq_chip_data(d);
 	if (WARN_ON(!old_vec))
@@ -115,6 +135,32 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 	if (!new_vec)
 		return -ENOSPC;
 
+	/*
+	 * Device having non-atomic MSI update might see an intermediate
+	 * state when changing target IMSIC vector from one CPU to another.
+	 *
+	 * To avoid losing interrupt to such intermediate state, do the
+	 * following (just like x86 APIC):
+	 *
+	 * 1) First write a temporary IMSIC vector to the device which
+	 * has MSI address same as the old IMSIC vector but MSI data
+	 * matches the new IMSIC vector.
+	 *
+	 * 2) Next write the new IMSIC vector to the device.
+	 *
+	 * Based on the above, __imsic_local_sync() must check pending
+	 * status of both old MSI data and new MSI data on the old CPU.
+	 */
+	if (!irq_can_move_in_process_context(d) &&
+	    new_vec->local_id != old_vec->local_id) {
+		/* Setup temporary vector */
+		tmp_vec.cpu = old_vec->cpu;
+		tmp_vec.local_id = new_vec->local_id;
+
+		/* Point device to the temporary vector */
+		imsic_msi_update_msg(irq_get_irq_data(d->irq), &tmp_vec);
+	}
+
 	/* Point device to the new vector */
 	imsic_msi_update_msg(irq_get_irq_data(d->irq), new_vec);
 
@@ -163,17 +209,17 @@ static void imsic_irq_force_complete_move(struct irq_data *d)
 #endif
 
 static struct irq_chip imsic_irq_base_chip = {
-	.name			= "IMSIC",
-	.irq_mask		= imsic_irq_mask,
-	.irq_unmask		= imsic_irq_unmask,
+	.name				= "IMSIC",
+	.irq_mask			= imsic_irq_mask,
+	.irq_unmask			= imsic_irq_unmask,
 #ifdef CONFIG_SMP
-	.irq_set_affinity	= imsic_irq_set_affinity,
-	.irq_force_complete_move = imsic_irq_force_complete_move,
+	.irq_set_affinity		= imsic_irq_set_affinity,
+	.irq_force_complete_move	= imsic_irq_force_complete_move,
 #endif
-	.irq_retrigger		= imsic_irq_retrigger,
-	.irq_compose_msi_msg	= imsic_irq_compose_msg,
-	.flags			= IRQCHIP_SKIP_SET_WAKE |
-				  IRQCHIP_MASK_ON_SUSPEND,
+	.irq_retrigger			= imsic_irq_retrigger,
+	.irq_ack			= imsic_irq_ack,
+	.irq_compose_msi_msg		= imsic_irq_compose_msg,
+	.flags				= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
 };
 
 static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
@@ -190,7 +236,7 @@ static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 		return -ENOSPC;
 
 	irq_domain_set_info(domain, virq, virq, &imsic_irq_base_chip, vec,
-			    handle_simple_irq, NULL, NULL);
+			    handle_edge_irq, NULL, NULL);
 	irq_set_noprobe(virq);
 	irq_set_affinity(virq, cpu_online_mask);
 	irq_data_update_effective_affinity(irq_get_irq_data(virq), cpumask_of(vec->cpu));
@@ -229,15 +275,34 @@ static const struct irq_domain_ops imsic_base_domain_ops = {
 #endif
 };
 
+static bool imsic_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+				    struct irq_domain *real_parent, struct msi_domain_info *info)
+{
+	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
+		return false;
+
+	switch (info->bus_token) {
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		info->chip->flags |= IRQCHIP_MOVE_DEFERRED;
+		break;
+	default:
+		break;
+	}
+
+	return true;
+}
+
 static const struct msi_parent_ops imsic_msi_parent_ops = {
 	.supported_flags	= MSI_GENERIC_FLAGS_MASK |
 				  MSI_FLAG_PCI_MSIX,
 	.required_flags		= MSI_FLAG_USE_DEF_DOM_OPS |
 				  MSI_FLAG_USE_DEF_CHIP_OPS |
 				  MSI_FLAG_PCI_MSI_MASK_PARENT,
+	.chip_flags		= MSI_CHIP_FLAG_SET_ACK,
 	.bus_select_token	= DOMAIN_BUS_NEXUS,
 	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
-	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+	.init_dev_msi_info	= imsic_init_dev_msi_info,
 };
 
 int imsic_irqdomain_init(void)
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index b0849af..bdf5cd2 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -126,8 +126,8 @@ void __imsic_eix_update(unsigned long base_id, unsigned long num_id, bool pend, 
 
 static bool __imsic_local_sync(struct imsic_local_priv *lpriv)
 {
-	struct imsic_local_config *mlocal;
-	struct imsic_vector *vec, *mvec;
+	struct imsic_local_config *tlocal, *mlocal;
+	struct imsic_vector *vec, *tvec, *mvec;
 	bool ret = true;
 	int i;
 
@@ -169,13 +169,35 @@ static bool __imsic_local_sync(struct imsic_local_priv *lpriv)
 		 */
 		mvec = READ_ONCE(vec->move_next);
 		if (mvec) {
-			if (__imsic_id_read_clear_pending(i)) {
+			/*
+			 * Devices having non-atomic MSI update might see
+			 * an intermediate state so check both old ID and
+			 * new ID for pending interrupts.
+			 *
+			 * For details, see imsic_irq_set_affinity().
+			 */
+			tvec = vec->local_id == mvec->local_id ?
+				NULL : &lpriv->vectors[mvec->local_id];
+
+			if (tvec && !irq_can_move_in_process_context(irq_get_irq_data(vec->irq)) &&
+			    __imsic_id_read_clear_pending(tvec->local_id)) {
+				/* Retrigger temporary vector if it was already in-use */
+				if (READ_ONCE(tvec->enable)) {
+					tlocal = per_cpu_ptr(imsic->global.local, tvec->cpu);
+					writel_relaxed(tvec->local_id, tlocal->msi_va);
+				}
+
+				mlocal = per_cpu_ptr(imsic->global.local, mvec->cpu);
+				writel_relaxed(mvec->local_id, mlocal->msi_va);
+			}
+
+			if (__imsic_id_read_clear_pending(vec->local_id)) {
 				mlocal = per_cpu_ptr(imsic->global.local, mvec->cpu);
 				writel_relaxed(mvec->local_id, mlocal->msi_va);
 			}
 
 			WRITE_ONCE(vec->move_next, NULL);
-			imsic_vector_free(&lpriv->vectors[i]);
+			imsic_vector_free(vec);
 		}
 
 skip:

