Return-Path: <linux-tip-commits+bounces-1765-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC4F93F1A9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815632812DE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B96C14534B;
	Mon, 29 Jul 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jUEsCqxt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m2KSHQw3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABB1143C54;
	Mon, 29 Jul 2024 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246589; cv=none; b=t30OdvL/NO/MHd9EQAFcc/foI2gtT83wZmKhTehI0MUwoTW22dMf3dHJkjnJ9zXiLkfyHNnig3023PaYpoGH2mF9nczvY6p5SxSrSXUujyTuXrOqsspeR0x5miWAyUNgpDqMENrpYddvOlWZY+neo1iNqmwTBh+kcZvM2ZPwTZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246589; c=relaxed/simple;
	bh=nV6I146Dv7INp5beKYgkXQ3xcRut3kugu9Qud8YbY14=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=heRI9NR6FRudXlSyG0nUBEqCnSYYhKFNoNxsZH4Up72jth+UfoHvaDz1PAVT/duCzw7CBNDD8RGmumpQPwvbC5+I8f1kIxn+6cajTf9E62cokFOp6yA79r2le4SS65Qx4p4i3uSSLuWtSLz6dd3R2K00Do+uij50d5KAl6pZE1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jUEsCqxt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m2KSHQw3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 09:49:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722246584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P95kXoxKRC/DZyTiPgII6kIvFTHFVPejapB92jZ/crY=;
	b=jUEsCqxtm38ug1WubwtkQM9j/uExTRu4J2PgXibl4IrF8MEpI8EzXVWIREwlt0qWIE0C4Z
	6AXDiHpYZ7y3w5uM02bSrXGP7+hyjK3bMBwnwfMprOcqBBbL+S1mamycA+EnQEuV99lHZW
	0dI0WO6H/TIHVtDP9pTtj6T6TD00hoQ7bWOXknyXZM80DqshUQutjMDJeE9nqeeYYsaT0d
	X+UjYldTPOblHqjgmxhKzeVeYacSsz0xmrNNIHiwJBhGhqo2o7fljTW96R69Mk0Yq7Yfwe
	c4a1p9dFORU59CQ9cvKzBLxL5/OnlnsNL174GGG9BJWZQ8qklXCNvqczPrRKwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P95kXoxKRC/DZyTiPgII6kIvFTHFVPejapB92jZ/crY=;
	b=m2KSHQw34Jbc9OENr8Wg9uca8LtY5nT26DmBS2DsISHySL9fllqa6RTf2RCUyXQkha4Zqc
	kAOABvU5JqFSsXAw==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Change symbol prefixes to mpic
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, ilpo.jarvinen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711115748.30268-7-kabel@kernel.org>
References: <20240711115748.30268-7-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224658404.2215.1380801249029241672.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0a03c46c75e968aef953c99d4a49a1aac91d50f9
Gitweb:        https://git.kernel.org/tip/0a03c46c75e968aef953c99d4a49a1aac91=
d50f9
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 13:57:44 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:57:23 +02:00

irqchip/armada-370-xp: Change symbol prefixes to mpic

Change symbol prefixes from armada_370_xp_ or others to mpic_.

The rationale is that it is shorter and more generic (this controller
is called MPIC and is also used on Armada 38x and 39x).

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/all/20240711115748.30268-7-kabel@kernel.org

---
 drivers/irqchip/irq-armada-370-xp.c | 305 ++++++++++++---------------
 1 file changed, 142 insertions(+), 163 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index a66d345..2758834 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -150,18 +150,18 @@
=20
 static void __iomem *per_cpu_int_base;
 static void __iomem *main_int_base;
-static struct irq_domain *armada_370_xp_mpic_domain;
+static struct irq_domain *mpic_domain;
 static u32 doorbell_mask_reg;
 static int parent_irq;
 #ifdef CONFIG_PCI_MSI
-static struct irq_domain *armada_370_xp_msi_domain;
-static struct irq_domain *armada_370_xp_msi_inner_domain;
+static struct irq_domain *mpic_msi_domain;
+static struct irq_domain *mpic_msi_inner_domain;
 static DECLARE_BITMAP(msi_used, PCI_MSI_FULL_DOORBELL_NR);
 static DEFINE_MUTEX(msi_used_lock);
 static phys_addr_t msi_doorbell_addr;
 #endif
=20
-static inline bool is_ipi_available(void)
+static inline bool mpic_is_ipi_available(void)
 {
 	/*
 	 * We distinguish IPI availability in the IC by the IC not having a
@@ -174,29 +174,25 @@ static inline bool is_ipi_available(void)
=20
 static inline u32 msi_doorbell_mask(void)
 {
-	return is_ipi_available() ? PCI_MSI_DOORBELL_MASK :
-				    PCI_MSI_FULL_DOORBELL_MASK;
+	return mpic_is_ipi_available() ? PCI_MSI_DOORBELL_MASK : PCI_MSI_FULL_DOORB=
ELL_MASK;
 }
=20
 static inline unsigned int msi_doorbell_start(void)
 {
-	return is_ipi_available() ? PCI_MSI_DOORBELL_START :
-				    PCI_MSI_FULL_DOORBELL_START;
+	return mpic_is_ipi_available() ? PCI_MSI_DOORBELL_START : PCI_MSI_FULL_DOOR=
BELL_START;
 }
=20
 static inline unsigned int msi_doorbell_size(void)
 {
-	return is_ipi_available() ? PCI_MSI_DOORBELL_NR :
-				    PCI_MSI_FULL_DOORBELL_NR;
+	return mpic_is_ipi_available() ? PCI_MSI_DOORBELL_NR : PCI_MSI_FULL_DOORBEL=
L_NR;
 }
=20
 static inline unsigned int msi_doorbell_end(void)
 {
-	return is_ipi_available() ? PCI_MSI_DOORBELL_END :
-				    PCI_MSI_FULL_DOORBELL_END;
+	return mpic_is_ipi_available() ? PCI_MSI_DOORBELL_END : PCI_MSI_FULL_DOORBE=
LL_END;
 }
=20
-static inline bool is_percpu_irq(irq_hw_number_t irq)
+static inline bool mpic_is_percpu_irq(irq_hw_number_t irq)
 {
 	return irq <=3D MPIC_MAX_PER_CPU_IRQS;
 }
@@ -206,21 +202,21 @@ static inline bool is_percpu_irq(irq_hw_number_t irq)
  * For shared global interrupts, mask/unmask global enable bit
  * For CPU interrupts, mask/unmask the calling CPU's bit
  */
-static void armada_370_xp_irq_mask(struct irq_data *d)
+static void mpic_irq_mask(struct irq_data *d)
 {
 	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
=20
-	if (!is_percpu_irq(hwirq))
+	if (!mpic_is_percpu_irq(hwirq))
 		writel(hwirq, main_int_base + MPIC_INT_CLEAR_ENABLE);
 	else
 		writel(hwirq, per_cpu_int_base + MPIC_INT_SET_MASK);
 }
=20
-static void armada_370_xp_irq_unmask(struct irq_data *d)
+static void mpic_irq_unmask(struct irq_data *d)
 {
 	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
=20
-	if (!is_percpu_irq(hwirq))
+	if (!mpic_is_percpu_irq(hwirq))
 		writel(hwirq, main_int_base + MPIC_INT_SET_ENABLE);
 	else
 		writel(hwirq, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
@@ -228,19 +224,19 @@ static void armada_370_xp_irq_unmask(struct irq_data *d)
=20
 #ifdef CONFIG_PCI_MSI
=20
-static struct irq_chip armada_370_xp_msi_irq_chip =3D {
+static struct irq_chip mpic_msi_irq_chip =3D {
 	.name		=3D "MPIC MSI",
 	.irq_mask	=3D pci_msi_mask_irq,
 	.irq_unmask	=3D pci_msi_unmask_irq,
 };
=20
-static struct msi_domain_info armada_370_xp_msi_domain_info =3D {
+static struct msi_domain_info mpic_msi_domain_info =3D {
 	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
 		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
-	.chip	=3D &armada_370_xp_msi_irq_chip,
+	.chip	=3D &mpic_msi_irq_chip,
 };
=20
-static void armada_370_xp_compose_msi_msg(struct irq_data *data, struct msi_=
msg *msg)
+static void mpic_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	unsigned int cpu =3D cpumask_first(irq_data_get_effective_affinity_mask(dat=
a));
=20
@@ -249,8 +245,7 @@ static void armada_370_xp_compose_msi_msg(struct irq_data=
 *data, struct msi_msg=20
 	msg->data =3D BIT(cpu + 8) | (data->hwirq + msi_doorbell_start());
 }
=20
-static int armada_370_xp_msi_set_affinity(struct irq_data *irq_data,
-					  const struct cpumask *mask, bool force)
+static int mpic_msi_set_affinity(struct irq_data *irq_data, const struct cpu=
mask *mask, bool force)
 {
 	unsigned int cpu;
=20
@@ -267,14 +262,14 @@ static int armada_370_xp_msi_set_affinity(struct irq_da=
ta *irq_data,
 	return IRQ_SET_MASK_OK;
 }
=20
-static struct irq_chip armada_370_xp_msi_bottom_irq_chip =3D {
+static struct irq_chip mpic_msi_bottom_irq_chip =3D {
 	.name			=3D "MPIC MSI",
-	.irq_compose_msi_msg	=3D armada_370_xp_compose_msi_msg,
-	.irq_set_affinity	=3D armada_370_xp_msi_set_affinity,
+	.irq_compose_msi_msg	=3D mpic_compose_msi_msg,
+	.irq_set_affinity	=3D mpic_msi_set_affinity,
 };
=20
-static int armada_370_xp_msi_alloc(struct irq_domain *domain, unsigned int v=
irq,
-				   unsigned int nr_irqs, void *args)
+static int mpic_msi_alloc(struct irq_domain *domain, unsigned int virq, unsi=
gned int nr_irqs,
+			  void *args)
 {
 	int hwirq;
=20
@@ -288,7 +283,7 @@ static int armada_370_xp_msi_alloc(struct irq_domain *dom=
ain, unsigned int virq,
=20
 	for (int i =3D 0; i < nr_irqs; i++) {
 		irq_domain_set_info(domain, virq + i, hwirq + i,
-				    &armada_370_xp_msi_bottom_irq_chip,
+				    &mpic_msi_bottom_irq_chip,
 				    domain->host_data, handle_simple_irq,
 				    NULL, NULL);
 	}
@@ -296,8 +291,7 @@ static int armada_370_xp_msi_alloc(struct irq_domain *dom=
ain, unsigned int virq,
 	return 0;
 }
=20
-static void armada_370_xp_msi_free(struct irq_domain *domain,
-				   unsigned int virq, unsigned int nr_irqs)
+static void mpic_msi_free(struct irq_domain *domain, unsigned int virq, unsi=
gned int nr_irqs)
 {
 	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
=20
@@ -306,12 +300,12 @@ static void armada_370_xp_msi_free(struct irq_domain *d=
omain,
 	mutex_unlock(&msi_used_lock);
 }
=20
-static const struct irq_domain_ops armada_370_xp_msi_domain_ops =3D {
-	.alloc	=3D armada_370_xp_msi_alloc,
-	.free	=3D armada_370_xp_msi_free,
+static const struct irq_domain_ops mpic_msi_domain_ops =3D {
+	.alloc	=3D mpic_msi_alloc,
+	.free	=3D mpic_msi_free,
 };
=20
-static void armada_370_xp_msi_reenable_percpu(void)
+static void mpic_msi_reenable_percpu(void)
 {
 	u32 reg;
=20
@@ -324,45 +318,41 @@ static void armada_370_xp_msi_reenable_percpu(void)
 	writel(1, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
 }
=20
-static int armada_370_xp_msi_init(struct device_node *node,
-				  phys_addr_t main_int_phys_base)
+static int mpic_msi_init(struct device_node *node, phys_addr_t main_int_phys=
_base)
 {
 	msi_doorbell_addr =3D main_int_phys_base + MPIC_SW_TRIG_INT;
=20
-	armada_370_xp_msi_inner_domain =3D
-		irq_domain_add_linear(NULL, msi_doorbell_size(),
-				      &armada_370_xp_msi_domain_ops, NULL);
-	if (!armada_370_xp_msi_inner_domain)
+	mpic_msi_inner_domain =3D irq_domain_add_linear(NULL, msi_doorbell_size(),
+						      &mpic_msi_domain_ops, NULL);
+	if (!mpic_msi_inner_domain)
 		return -ENOMEM;
=20
-	armada_370_xp_msi_domain =3D
-		pci_msi_create_irq_domain(of_node_to_fwnode(node),
-					  &armada_370_xp_msi_domain_info,
-					  armada_370_xp_msi_inner_domain);
-	if (!armada_370_xp_msi_domain) {
-		irq_domain_remove(armada_370_xp_msi_inner_domain);
+	mpic_msi_domain =3D pci_msi_create_irq_domain(of_node_to_fwnode(node), &mpi=
c_msi_domain_info,
+						    mpic_msi_inner_domain);
+	if (!mpic_msi_domain) {
+		irq_domain_remove(mpic_msi_inner_domain);
 		return -ENOMEM;
 	}
=20
-	armada_370_xp_msi_reenable_percpu();
+	mpic_msi_reenable_percpu();
=20
 	/* Unmask low 16 MSI irqs on non-IPI platforms */
-	if (!is_ipi_available())
+	if (!mpic_is_ipi_available())
 		writel(0, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
=20
 	return 0;
 }
 #else
-static __maybe_unused void armada_370_xp_msi_reenable_percpu(void) {}
+static __maybe_unused void mpic_msi_reenable_percpu(void) {}
=20
-static inline int armada_370_xp_msi_init(struct device_node *node,
-					 phys_addr_t main_int_phys_base)
+static inline int mpic_msi_init(struct device_node *node,
+				phys_addr_t main_int_phys_base)
 {
 	return 0;
 }
 #endif
=20
-static void armada_xp_mpic_perf_init(void)
+static void mpic_perf_init(void)
 {
 	unsigned long cpuid;
=20
@@ -381,9 +371,9 @@ static void armada_xp_mpic_perf_init(void)
 }
=20
 #ifdef CONFIG_SMP
-static struct irq_domain *ipi_domain;
+static struct irq_domain *mpic_ipi_domain;
=20
-static void armada_370_xp_ipi_mask(struct irq_data *d)
+static void mpic_ipi_mask(struct irq_data *d)
 {
 	u32 reg;
=20
@@ -392,7 +382,7 @@ static void armada_370_xp_ipi_mask(struct irq_data *d)
 	writel(reg, per_cpu_int_base + MPIC_IN_DRBEL_MASK);
 }
=20
-static void armada_370_xp_ipi_unmask(struct irq_data *d)
+static void mpic_ipi_unmask(struct irq_data *d)
 {
 	u32 reg;
=20
@@ -401,8 +391,7 @@ static void armada_370_xp_ipi_unmask(struct irq_data *d)
 	writel(reg, per_cpu_int_base + MPIC_IN_DRBEL_MASK);
 }
=20
-static void armada_370_xp_ipi_send_mask(struct irq_data *d,
-					const struct cpumask *mask)
+static void mpic_ipi_send_mask(struct irq_data *d, const struct cpumask *mas=
k)
 {
 	unsigned long map =3D 0;
 	unsigned int cpu;
@@ -421,75 +410,73 @@ static void armada_370_xp_ipi_send_mask(struct irq_data=
 *d,
 	writel((map << 8) | d->hwirq, main_int_base + MPIC_SW_TRIG_INT);
 }
=20
-static void armada_370_xp_ipi_ack(struct irq_data *d)
+static void mpic_ipi_ack(struct irq_data *d)
 {
 	writel(~BIT(d->hwirq), per_cpu_int_base + MPIC_IN_DRBEL_CAUSE);
 }
=20
-static struct irq_chip ipi_irqchip =3D {
+static struct irq_chip mpic_ipi_irqchip =3D {
 	.name		=3D "IPI",
-	.irq_ack	=3D armada_370_xp_ipi_ack,
-	.irq_mask	=3D armada_370_xp_ipi_mask,
-	.irq_unmask	=3D armada_370_xp_ipi_unmask,
-	.ipi_send_mask	=3D armada_370_xp_ipi_send_mask,
+	.irq_ack	=3D mpic_ipi_ack,
+	.irq_mask	=3D mpic_ipi_mask,
+	.irq_unmask	=3D mpic_ipi_unmask,
+	.ipi_send_mask	=3D mpic_ipi_send_mask,
 };
=20
-static int armada_370_xp_ipi_alloc(struct irq_domain *d, unsigned int virq,
-				   unsigned int nr_irqs, void *args)
+static int mpic_ipi_alloc(struct irq_domain *d, unsigned int virq,
+			  unsigned int nr_irqs, void *args)
 {
 	for (int i =3D 0; i < nr_irqs; i++) {
 		irq_set_percpu_devid(virq + i);
-		irq_domain_set_info(d, virq + i, i, &ipi_irqchip, d->host_data,
+		irq_domain_set_info(d, virq + i, i, &mpic_ipi_irqchip, d->host_data,
 				    handle_percpu_devid_irq, NULL, NULL);
 	}
=20
 	return 0;
 }
=20
-static void armada_370_xp_ipi_free(struct irq_domain *d, unsigned int virq,
-				   unsigned int nr_irqs)
+static void mpic_ipi_free(struct irq_domain *d, unsigned int virq,
+			  unsigned int nr_irqs)
 {
 	/* Not freeing IPIs */
 }
=20
-static const struct irq_domain_ops ipi_domain_ops =3D {
-	.alloc	=3D armada_370_xp_ipi_alloc,
-	.free	=3D armada_370_xp_ipi_free,
+static const struct irq_domain_ops mpic_ipi_domain_ops =3D {
+	.alloc	=3D mpic_ipi_alloc,
+	.free	=3D mpic_ipi_free,
 };
=20
-static void ipi_resume(void)
+static void mpic_ipi_resume(void)
 {
 	for (int i =3D 0; i < IPI_DOORBELL_END; i++) {
-		unsigned int virq =3D irq_find_mapping(ipi_domain, i);
+		unsigned int virq =3D irq_find_mapping(mpic_ipi_domain, i);
 		struct irq_data *d;
=20
 		if (!virq || !irq_percpu_is_enabled(virq))
 			continue;
=20
-		d =3D irq_domain_get_irq_data(ipi_domain, virq);
-		armada_370_xp_ipi_unmask(d);
+		d =3D irq_domain_get_irq_data(mpic_ipi_domain, virq);
+		mpic_ipi_unmask(d);
 	}
 }
=20
-static __init void armada_xp_ipi_init(struct device_node *node)
+static __init void mpic_ipi_init(struct device_node *node)
 {
 	int base_ipi;
=20
-	ipi_domain =3D irq_domain_create_linear(of_node_to_fwnode(node), IPI_DOORBE=
LL_END,
-					      &ipi_domain_ops, NULL);
-	if (WARN_ON(!ipi_domain))
+	mpic_ipi_domain =3D irq_domain_create_linear(of_node_to_fwnode(node), IPI_D=
OORBELL_END,
+						   &mpic_ipi_domain_ops, NULL);
+	if (WARN_ON(!mpic_ipi_domain))
 		return;
=20
-	irq_domain_update_bus_token(ipi_domain, DOMAIN_BUS_IPI);
-	base_ipi =3D irq_domain_alloc_irqs(ipi_domain, IPI_DOORBELL_END, NUMA_NO_NO=
DE, NULL);
+	irq_domain_update_bus_token(mpic_ipi_domain, DOMAIN_BUS_IPI);
+	base_ipi =3D irq_domain_alloc_irqs(mpic_ipi_domain, IPI_DOORBELL_END, NUMA_=
NO_NODE, NULL);
 	if (WARN_ON(!base_ipi))
 		return;
-
 	set_smp_ipi_range(base_ipi, IPI_DOORBELL_END);
 }
=20
-static int armada_xp_set_affinity(struct irq_data *d,
-				  const struct cpumask *mask_val, bool force)
+static int mpic_set_affinity(struct irq_data *d, const struct cpumask *mask_=
val, bool force)
 {
 	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
 	unsigned int cpu;
@@ -505,7 +492,7 @@ static int armada_xp_set_affinity(struct irq_data *d,
 	return IRQ_SET_MASK_OK;
 }
=20
-static void armada_xp_mpic_smp_cpu_init(void)
+static void mpic_smp_cpu_init(void)
 {
 	u32 control;
 	int nr_irqs;
@@ -516,7 +503,7 @@ static void armada_xp_mpic_smp_cpu_init(void)
 	for (int i =3D 0; i < nr_irqs; i++)
 		writel(i, per_cpu_int_base + MPIC_INT_SET_MASK);
=20
-	if (!is_ipi_available())
+	if (!mpic_is_ipi_available())
 		return;
=20
 	/* Disable all IPIs */
@@ -529,14 +516,14 @@ static void armada_xp_mpic_smp_cpu_init(void)
 	writel(0, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
 }
=20
-static void armada_xp_mpic_reenable_percpu(void)
+static void mpic_reenable_percpu(void)
 {
 	/* Re-enable per-CPU interrupts that were enabled before suspend */
 	for (unsigned int irq =3D 0; irq < MPIC_MAX_PER_CPU_IRQS; irq++) {
 		struct irq_data *data;
 		unsigned int virq;
=20
-		virq =3D irq_linear_revmap(armada_370_xp_mpic_domain, irq);
+		virq =3D irq_linear_revmap(mpic_domain, irq);
 		if (!virq)
 			continue;
=20
@@ -545,82 +532,80 @@ static void armada_xp_mpic_reenable_percpu(void)
 		if (!irq_percpu_is_enabled(virq))
 			continue;
=20
-		armada_370_xp_irq_unmask(data);
+		mpic_irq_unmask(data);
 	}
=20
-	if (is_ipi_available())
-		ipi_resume();
+	if (mpic_is_ipi_available())
+		mpic_ipi_resume();
=20
-	armada_370_xp_msi_reenable_percpu();
+	mpic_msi_reenable_percpu();
 }
=20
-static int armada_xp_mpic_starting_cpu(unsigned int cpu)
+static int mpic_starting_cpu(unsigned int cpu)
 {
-	armada_xp_mpic_perf_init();
-	armada_xp_mpic_smp_cpu_init();
-	armada_xp_mpic_reenable_percpu();
+	mpic_perf_init();
+	mpic_smp_cpu_init();
+	mpic_reenable_percpu();
=20
 	return 0;
 }
=20
 static int mpic_cascaded_starting_cpu(unsigned int cpu)
 {
-	armada_xp_mpic_perf_init();
-	armada_xp_mpic_reenable_percpu();
+	mpic_perf_init();
+	mpic_reenable_percpu();
 	enable_percpu_irq(parent_irq, IRQ_TYPE_NONE);
=20
 	return 0;
 }
 #else
-static void armada_xp_mpic_smp_cpu_init(void) {}
-static void ipi_resume(void) {}
+static void mpic_smp_cpu_init(void) {}
+static void mpic_ipi_resume(void) {}
 #endif
=20
-static struct irq_chip armada_370_xp_irq_chip =3D {
+static struct irq_chip mpic_irq_chip =3D {
 	.name		=3D "MPIC",
-	.irq_mask	=3D armada_370_xp_irq_mask,
-	.irq_mask_ack	=3D armada_370_xp_irq_mask,
-	.irq_unmask	=3D armada_370_xp_irq_unmask,
+	.irq_mask	=3D mpic_irq_mask,
+	.irq_mask_ack	=3D mpic_irq_mask,
+	.irq_unmask	=3D mpic_irq_unmask,
 #ifdef CONFIG_SMP
-	.irq_set_affinity =3D armada_xp_set_affinity,
+	.irq_set_affinity =3D mpic_set_affinity,
 #endif
 	.flags		=3D IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
 };
=20
-static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
-				      unsigned int virq, irq_hw_number_t hw)
+static int mpic_irq_map(struct irq_domain *h, unsigned int virq,
+			irq_hw_number_t hw)
 {
 	/* IRQs 0 and 1 cannot be mapped, they are handled internally */
 	if (hw <=3D 1)
 		return -EINVAL;
=20
-	armada_370_xp_irq_mask(irq_get_irq_data(virq));
-	if (!is_percpu_irq(hw))
+	mpic_irq_mask(irq_get_irq_data(virq));
+	if (!mpic_is_percpu_irq(hw))
 		writel(hw, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
 	else
 		writel(hw, main_int_base + MPIC_INT_SET_ENABLE);
 	irq_set_status_flags(virq, IRQ_LEVEL);
=20
-	if (is_percpu_irq(hw)) {
+	if (mpic_is_percpu_irq(hw)) {
 		irq_set_percpu_devid(virq);
-		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
-					 handle_percpu_devid_irq);
+		irq_set_chip_and_handler(virq, &mpic_irq_chip, handle_percpu_devid_irq);
 	} else {
-		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip, handle_level_irq);
+		irq_set_chip_and_handler(virq, &mpic_irq_chip, handle_level_irq);
 		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(virq)));
 	}
 	irq_set_probe(virq);
-
 	return 0;
 }
=20
-static const struct irq_domain_ops armada_370_xp_mpic_irq_ops =3D {
-	.map	=3D armada_370_xp_mpic_irq_map,
+static const struct irq_domain_ops mpic_irq_ops =3D {
+	.map	=3D mpic_irq_map,
 	.xlate	=3D irq_domain_xlate_onecell,
 };
=20
 #ifdef CONFIG_PCI_MSI
-static void armada_370_xp_handle_msi_irq(struct pt_regs *regs, bool is_chain=
ed)
+static void mpic_handle_msi_irq(struct pt_regs *regs, bool is_chained)
 {
 	u32 msimask, msinr;
=20
@@ -638,14 +623,14 @@ static void armada_370_xp_handle_msi_irq(struct pt_regs=
 *regs, bool is_chained)
=20
 		irq =3D msinr - msi_doorbell_start();
=20
-		generic_handle_domain_irq(armada_370_xp_msi_inner_domain, irq);
+		generic_handle_domain_irq(mpic_msi_inner_domain, irq);
 	}
 }
 #else
-static void armada_370_xp_handle_msi_irq(struct pt_regs *r, bool b) {}
+static void mpic_handle_msi_irq(struct pt_regs *r, bool b) {}
 #endif
=20
-static void armada_370_xp_mpic_handle_cascade_irq(struct irq_desc *desc)
+static void mpic_handle_cascade_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
 	unsigned long irqmap, irqn, irqsrc, cpuid;
@@ -665,18 +650,17 @@ static void armada_370_xp_mpic_handle_cascade_irq(struc=
t irq_desc *desc)
 			continue;
=20
 		if (irqn =3D=3D 0 || irqn =3D=3D 1) {
-			armada_370_xp_handle_msi_irq(NULL, true);
+			mpic_handle_msi_irq(NULL, true);
 			continue;
 		}
=20
-		generic_handle_domain_irq(armada_370_xp_mpic_domain, irqn);
+		generic_handle_domain_irq(mpic_domain, irqn);
 	}
=20
 	chained_irq_exit(chip, desc);
 }
=20
-static void __exception_irq_entry
-armada_370_xp_handle_irq(struct pt_regs *regs)
+static void __exception_irq_entry mpic_handle_irq(struct pt_regs *regs)
 {
 	u32 irqstat, irqnr;
=20
@@ -688,14 +672,13 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
 			break;
=20
 		if (irqnr > 1) {
-			generic_handle_domain_irq(armada_370_xp_mpic_domain,
-						  irqnr);
+			generic_handle_domain_irq(mpic_domain, irqnr);
 			continue;
 		}
=20
 		/* MSI handling */
 		if (irqnr =3D=3D 1)
-			armada_370_xp_handle_msi_irq(regs, false);
+			mpic_handle_msi_irq(regs, false);
=20
 #ifdef CONFIG_SMP
 		/* IPI Handling */
@@ -704,62 +687,60 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
 			int ipi;
=20
 			ipimask =3D readl_relaxed(per_cpu_int_base + MPIC_IN_DRBEL_CAUSE) &
-						IPI_DOORBELL_MASK;
+				  IPI_DOORBELL_MASK;
=20
 			for_each_set_bit(ipi, &ipimask, IPI_DOORBELL_END)
-				generic_handle_domain_irq(ipi_domain, ipi);
+				generic_handle_domain_irq(mpic_ipi_domain, ipi);
 		}
 #endif
 	} while (1);
 }
=20
-static int armada_370_xp_mpic_suspend(void)
+static int mpic_suspend(void)
 {
 	doorbell_mask_reg =3D readl(per_cpu_int_base + MPIC_IN_DRBEL_MASK);
=20
 	return 0;
 }
=20
-static void armada_370_xp_mpic_resume(void)
+static void mpic_resume(void)
 {
 	bool src0, src1;
 	int nirqs;
-
 	/* Re-enable interrupts */
 	nirqs =3D (readl(main_int_base + MPIC_INT_CONTROL) >> 2) & 0x3ff;
 	for (irq_hw_number_t irq =3D 0; irq < nirqs; irq++) {
 		struct irq_data *data;
 		unsigned int virq;
=20
-		virq =3D irq_linear_revmap(armada_370_xp_mpic_domain, irq);
+		virq =3D irq_linear_revmap(mpic_domain, irq);
 		if (!virq)
 			continue;
=20
 		data =3D irq_get_irq_data(virq);
=20
-		if (!is_percpu_irq(irq)) {
+		if (!mpic_is_percpu_irq(irq)) {
 			/* Non per-CPU interrupts */
 			writel(irq, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
 			if (!irqd_irq_disabled(data))
-				armada_370_xp_irq_unmask(data);
+				mpic_irq_unmask(data);
 		} else {
 			/* Per-CPU interrupts */
 			writel(irq, main_int_base + MPIC_INT_SET_ENABLE);
=20
 			/*
-			 * Re-enable on the current CPU,
-			 * armada_xp_mpic_reenable_percpu() will take
-			 * care of secondary CPUs when they come up.
+			 * Re-enable on the current CPU, mpic_reenable_percpu()
+			 * will take care of secondary CPUs when they come up.
 			 */
 			if (irq_percpu_is_enabled(virq))
-				armada_370_xp_irq_unmask(data);
+				mpic_irq_unmask(data);
 		}
 	}
=20
 	/* Reconfigure doorbells for IPIs and MSIs */
 	writel(doorbell_mask_reg, per_cpu_int_base + MPIC_IN_DRBEL_MASK);
=20
-	if (is_ipi_available()) {
+	if (mpic_is_ipi_available()) {
 		src0 =3D doorbell_mask_reg & IPI_DOORBELL_MASK;
 		src1 =3D doorbell_mask_reg & PCI_MSI_DOORBELL_MASK;
 	} else {
@@ -772,17 +753,17 @@ static void armada_370_xp_mpic_resume(void)
 	if (src1)
 		writel(1, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
=20
-	if (is_ipi_available())
-		ipi_resume();
+	if (mpic_is_ipi_available())
+		mpic_ipi_resume();
 }
=20
-static struct syscore_ops armada_370_xp_mpic_syscore_ops =3D {
-	.suspend	=3D armada_370_xp_mpic_suspend,
-	.resume		=3D armada_370_xp_mpic_resume,
+static struct syscore_ops mpic_syscore_ops =3D {
+	.suspend	=3D mpic_suspend,
+	.resume		=3D mpic_resume,
 };
=20
-static int __init armada_370_xp_mpic_of_init(struct device_node *node,
-					     struct device_node *parent)
+static int __init mpic_of_init(struct device_node *node,
+			       struct device_node *parent)
 {
 	struct resource main_int_res, per_cpu_int_res;
 	int nr_irqs;
@@ -812,10 +793,9 @@ static int __init armada_370_xp_mpic_of_init(struct devi=
ce_node *node,
 	for (int i =3D 0; i < nr_irqs; i++)
 		writel(i, main_int_base + MPIC_INT_CLEAR_ENABLE);
=20
-	armada_370_xp_mpic_domain =3D irq_domain_add_linear(node, nr_irqs,
-							  &armada_370_xp_mpic_irq_ops, NULL);
-	BUG_ON(!armada_370_xp_mpic_domain);
-	irq_domain_update_bus_token(armada_370_xp_mpic_domain, DOMAIN_BUS_WIRED);
+	mpic_domain =3D irq_domain_add_linear(node, nr_irqs, &mpic_irq_ops, NULL);
+	BUG_ON(!mpic_domain);
+	irq_domain_update_bus_token(mpic_domain, DOMAIN_BUS_WIRED);
=20
 	/*
 	 * Initialize parent_irq before calling any other functions, since it is
@@ -824,19 +804,19 @@ static int __init armada_370_xp_mpic_of_init(struct dev=
ice_node *node,
 	parent_irq =3D irq_of_parse_and_map(node, 0);
=20
 	/* Setup for the boot CPU */
-	armada_xp_mpic_perf_init();
-	armada_xp_mpic_smp_cpu_init();
+	mpic_perf_init();
+	mpic_smp_cpu_init();
=20
-	armada_370_xp_msi_init(node, main_int_res.start);
+	mpic_msi_init(node, main_int_res.start);
=20
 	if (parent_irq <=3D 0) {
-		irq_set_default_host(armada_370_xp_mpic_domain);
-		set_handle_irq(armada_370_xp_handle_irq);
+		irq_set_default_host(mpic_domain);
+		set_handle_irq(mpic_handle_irq);
 #ifdef CONFIG_SMP
-		armada_xp_ipi_init(node);
+		mpic_ipi_init(node);
 		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_ARMADA_XP_STARTING,
 					  "irqchip/armada/ipi:starting",
-					  armada_xp_mpic_starting_cpu, NULL);
+					  mpic_starting_cpu, NULL);
 #endif
 	} else {
 #ifdef CONFIG_SMP
@@ -844,13 +824,12 @@ static int __init armada_370_xp_mpic_of_init(struct dev=
ice_node *node,
 					  "irqchip/armada/cascade:starting",
 					  mpic_cascaded_starting_cpu, NULL);
 #endif
-		irq_set_chained_handler(parent_irq,
-					armada_370_xp_mpic_handle_cascade_irq);
+		irq_set_chained_handler(parent_irq, mpic_handle_cascade_irq);
 	}
=20
-	register_syscore_ops(&armada_370_xp_mpic_syscore_ops);
+	register_syscore_ops(&mpic_syscore_ops);
=20
 	return 0;
 }
=20
-IRQCHIP_DECLARE(armada_370_xp_mpic, "marvell,mpic", armada_370_xp_mpic_of_in=
it);
+IRQCHIP_DECLARE(marvell_mpic, "marvell,mpic", mpic_of_init);

