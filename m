Return-Path: <linux-tip-commits+bounces-2011-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7A094C100
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 17:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F169B28E97
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 15:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE71191F9E;
	Thu,  8 Aug 2024 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sVDWW9Ct";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DNbPT2/p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B407F191479;
	Thu,  8 Aug 2024 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130509; cv=none; b=T40oY5oifs4qWUps8FEXP6sfImKbmPISxqUF4oSo0wEb11o93HJ5fwBKFAGkeQu6RW8MFshGg5lb6hNmhSkLrRf0nmgrPxkQIkkc+0G15y6h7hYq7s5/UmbocirmQBms4nmDhuu/k4Pm9RSyd7aItdxrufo2WkNQTsQp/9veDTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130509; c=relaxed/simple;
	bh=JtzfR8CUcHvHI6Hxr0RhyCsJhD8V0URmngPryq6nFh0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=NIVzIJjhC9hY6IneFb9q4hr47y8lAN3UPI4SwHMq6GkhIo359c2d79vjGHikQGwlarX1fRLHJ/HpFXY4bXgXdRZ+ti3yD7tNzsEnJthn+m+tXOzH0Z8o8gxYNxOtEHSfl8oNOdQ6gPEVyPjLJ5cIcR8o7eKcQ3s7rgXd6CiheDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sVDWW9Ct; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DNbPT2/p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 15:21:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723130505;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=EbdfsnHDDZuiPU0xEWuMFfTfJQGgzaz/4242bhJK3R8=;
	b=sVDWW9Ctay0RMT8KUJwLAtu2XhLFNh5A/fiRQdBoyxAg/5i8qiwn0WUXTBcf0T0V1S+qzr
	/vIifYxkhxoDj8sckg6+Wzsj97ju0OrnVB8vdd7BCSgA6vcr6pNw9QZKfcPLWV80czUU4n
	N5echv0RrCSv4ErmF0C2FqZ6QnzV1vEEPk59ngq8S7QqqjEta821EkWkxdwMLPq8ZPR9Qa
	/EVw2Em4Zhy+edmTVhbtGJvmqNKdk1eRQMt3RV43aOI0c4XXh6vbnGs2CrgggRsjO36hDI
	VIduPeOHrDukG3Yrrs1wzIXyuslD6+QEuufEUMF5H15fmZgST0c6HQnTjdpJ4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723130505;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=EbdfsnHDDZuiPU0xEWuMFfTfJQGgzaz/4242bhJK3R8=;
	b=DNbPT2/pwrp3tOYJ+s2FOjI0imk/XB8qGvfFsvs42ZfO6RD/aSDJ1z2QD7mcSxzoxm0Nlu
	JXh/POdrMXepCrBg==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Pass around the driver private
 structure
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172313050468.2215.12301131988313025096.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     77eef29b642f07f56af28a7126b5666f705ca8d0
Gitweb:        https://git.kernel.org/tip/77eef29b642f07f56af28a7126b5666f705=
ca8d0
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Wed, 07 Aug 2024 18:40:59 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Aug 2024 17:15:00 +02:00

irqchip/armada-370-xp: Pass around the driver private structure

In continuation of converting the driver to modern style, drop the
global pointer to the driver private structure and instead pass it
around the functions and callbacks, wherever possible. (There are 3
cases where it is not possible: mpic_cascaded_starting_cpu() and the
syscore operations mpic_suspend() and mpic_resume()).

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/irqchip/irq-armada-370-xp.c | 115 ++++++++++++++++-----------
 1 file changed, 70 insertions(+), 45 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 1c95a61..5710ce2 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -188,9 +188,8 @@ struct mpic {
 };
=20
 static struct mpic mpic_data;
-static struct mpic * const mpic =3D &mpic_data;
=20
-static inline bool mpic_is_ipi_available(void)
+static inline bool mpic_is_ipi_available(struct mpic *mpic)
 {
 	/*
 	 * We distinguish IPI availability in the IC by the IC not having a
@@ -213,6 +212,7 @@ static inline bool mpic_is_percpu_irq(irq_hw_number_t hwi=
rq)
  */
 static void mpic_irq_mask(struct irq_data *d)
 {
+	struct mpic *mpic =3D irq_data_get_irq_chip_data(d);
 	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
=20
 	if (!mpic_is_percpu_irq(hwirq))
@@ -223,6 +223,7 @@ static void mpic_irq_mask(struct irq_data *d)
=20
 static void mpic_irq_unmask(struct irq_data *d)
 {
+	struct mpic *mpic =3D irq_data_get_irq_chip_data(d);
 	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
=20
 	if (!mpic_is_percpu_irq(hwirq))
@@ -248,6 +249,7 @@ static struct msi_domain_info mpic_msi_domain_info =3D {
 static void mpic_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
 {
 	unsigned int cpu =3D cpumask_first(irq_data_get_effective_affinity_mask(d));
+	struct mpic *mpic =3D irq_data_get_irq_chip_data(d);
=20
 	msg->address_lo =3D lower_32_bits(mpic->msi_doorbell_addr);
 	msg->address_hi =3D upper_32_bits(mpic->msi_doorbell_addr);
@@ -280,6 +282,7 @@ static struct irq_chip mpic_msi_bottom_irq_chip =3D {
 static int mpic_msi_alloc(struct irq_domain *domain, unsigned int virq, unsi=
gned int nr_irqs,
 			  void *args)
 {
+	struct mpic *mpic =3D domain->host_data;
 	int hwirq;
=20
 	mutex_lock(&mpic->msi_lock);
@@ -303,6 +306,7 @@ static int mpic_msi_alloc(struct irq_domain *domain, unsi=
gned int virq, unsigned
 static void mpic_msi_free(struct irq_domain *domain, unsigned int virq, unsi=
gned int nr_irqs)
 {
 	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
+	struct mpic *mpic =3D domain->host_data;
=20
 	mutex_lock(&mpic->msi_lock);
 	bitmap_release_region(mpic->msi_used, d->hwirq, order_base_2(nr_irqs));
@@ -314,7 +318,7 @@ static const struct irq_domain_ops mpic_msi_domain_ops =
=3D {
 	.free	=3D mpic_msi_free,
 };
=20
-static void mpic_msi_reenable_percpu(void)
+static void mpic_msi_reenable_percpu(struct mpic *mpic)
 {
 	u32 reg;
=20
@@ -327,13 +331,14 @@ static void mpic_msi_reenable_percpu(void)
 	writel(1, mpic->per_cpu + MPIC_INT_CLEAR_MASK);
 }
=20
-static int __init mpic_msi_init(struct device_node *node, phys_addr_t main_i=
nt_phys_base)
+static int __init mpic_msi_init(struct mpic *mpic, struct device_node *node,
+				phys_addr_t main_int_phys_base)
 {
 	mpic->msi_doorbell_addr =3D main_int_phys_base + MPIC_SW_TRIG_INT;
=20
 	mutex_init(&mpic->msi_lock);
=20
-	if (mpic_is_ipi_available()) {
+	if (mpic_is_ipi_available(mpic)) {
 		mpic->msi_doorbell_start =3D PCI_MSI_DOORBELL_START;
 		mpic->msi_doorbell_size =3D PCI_MSI_DOORBELL_NR;
 		mpic->msi_doorbell_mask =3D PCI_MSI_DOORBELL_MASK;
@@ -344,7 +349,7 @@ static int __init mpic_msi_init(struct device_node *node,=
 phys_addr_t main_int_p
 	}
=20
 	mpic->msi_inner_domain =3D irq_domain_add_linear(NULL, mpic->msi_doorbell_s=
ize,
-						       &mpic_msi_domain_ops, NULL);
+						       &mpic_msi_domain_ops, mpic);
 	if (!mpic->msi_inner_domain)
 		return -ENOMEM;
=20
@@ -355,25 +360,25 @@ static int __init mpic_msi_init(struct device_node *nod=
e, phys_addr_t main_int_p
 		return -ENOMEM;
 	}
=20
-	mpic_msi_reenable_percpu();
+	mpic_msi_reenable_percpu(mpic);
=20
 	/* Unmask low 16 MSI irqs on non-IPI platforms */
-	if (!mpic_is_ipi_available())
+	if (!mpic_is_ipi_available(mpic))
 		writel(0, mpic->per_cpu + MPIC_INT_CLEAR_MASK);
=20
 	return 0;
 }
 #else
-static __maybe_unused void mpic_msi_reenable_percpu(void) {}
+static __maybe_unused void mpic_msi_reenable_percpu(struct mpic *mpic) {}
=20
-static inline int mpic_msi_init(struct device_node *node,
+static inline int mpic_msi_init(struct mpic *mpic, struct device_node *node,
 				phys_addr_t main_int_phys_base)
 {
 	return 0;
 }
 #endif
=20
-static void mpic_perf_init(void)
+static void mpic_perf_init(struct mpic *mpic)
 {
 	u32 cpuid;
=20
@@ -393,6 +398,7 @@ static void mpic_perf_init(void)
 #ifdef CONFIG_SMP
 static void mpic_ipi_mask(struct irq_data *d)
 {
+	struct mpic *mpic =3D irq_data_get_irq_chip_data(d);
 	u32 reg;
=20
 	reg =3D readl(mpic->per_cpu + MPIC_IN_DRBEL_MASK);
@@ -402,6 +408,7 @@ static void mpic_ipi_mask(struct irq_data *d)
=20
 static void mpic_ipi_unmask(struct irq_data *d)
 {
+	struct mpic *mpic =3D irq_data_get_irq_chip_data(d);
 	u32 reg;
=20
 	reg =3D readl(mpic->per_cpu + MPIC_IN_DRBEL_MASK);
@@ -411,6 +418,7 @@ static void mpic_ipi_unmask(struct irq_data *d)
=20
 static void mpic_ipi_send_mask(struct irq_data *d, const struct cpumask *mas=
k)
 {
+	struct mpic *mpic =3D irq_data_get_irq_chip_data(d);
 	unsigned int cpu;
 	u32 map =3D 0;
=20
@@ -430,6 +438,8 @@ static void mpic_ipi_send_mask(struct irq_data *d, const =
struct cpumask *mask)
=20
 static void mpic_ipi_ack(struct irq_data *d)
 {
+	struct mpic *mpic =3D irq_data_get_irq_chip_data(d);
+
 	writel(~BIT(d->hwirq), mpic->per_cpu + MPIC_IN_DRBEL_CAUSE);
 }
=20
@@ -464,7 +474,7 @@ static const struct irq_domain_ops mpic_ipi_domain_ops =
=3D {
 	.free	=3D mpic_ipi_free,
 };
=20
-static void mpic_ipi_resume(void)
+static void mpic_ipi_resume(struct mpic *mpic)
 {
 	for (irq_hw_number_t i =3D 0; i < IPI_DOORBELL_NR; i++) {
 		unsigned int virq =3D irq_find_mapping(mpic->ipi_domain, i);
@@ -478,12 +488,12 @@ static void mpic_ipi_resume(void)
 	}
 }
=20
-static int __init mpic_ipi_init(struct device_node *node)
+static int __init mpic_ipi_init(struct mpic *mpic, struct device_node *node)
 {
 	int base_ipi;
=20
 	mpic->ipi_domain =3D irq_domain_create_linear(of_node_to_fwnode(node), IPI_=
DOORBELL_NR,
-						    &mpic_ipi_domain_ops, NULL);
+						    &mpic_ipi_domain_ops, mpic);
 	if (WARN_ON(!mpic->ipi_domain))
 		return -ENOMEM;
=20
@@ -499,6 +509,7 @@ static int __init mpic_ipi_init(struct device_node *node)
=20
 static int mpic_set_affinity(struct irq_data *d, const struct cpumask *mask_=
val, bool force)
 {
+	struct mpic *mpic =3D irq_data_get_irq_chip_data(d);
 	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
 	unsigned int cpu;
=20
@@ -513,12 +524,12 @@ static int mpic_set_affinity(struct irq_data *d, const =
struct cpumask *mask_val,
 	return IRQ_SET_MASK_OK;
 }
=20
-static void mpic_smp_cpu_init(void)
+static void mpic_smp_cpu_init(struct mpic *mpic)
 {
 	for (irq_hw_number_t i =3D 0; i < mpic->domain->hwirq_max; i++)
 		writel(i, mpic->per_cpu + MPIC_INT_SET_MASK);
=20
-	if (!mpic_is_ipi_available())
+	if (!mpic_is_ipi_available(mpic))
 		return;
=20
 	/* Disable all IPIs */
@@ -531,7 +542,7 @@ static void mpic_smp_cpu_init(void)
 	writel(0, mpic->per_cpu + MPIC_INT_CLEAR_MASK);
 }
=20
-static void mpic_reenable_percpu(void)
+static void mpic_reenable_percpu(struct mpic *mpic)
 {
 	/* Re-enable per-CPU interrupts that were enabled before suspend */
 	for (irq_hw_number_t i =3D 0; i < MPIC_MAX_PER_CPU_IRQS; i++) {
@@ -545,32 +556,36 @@ static void mpic_reenable_percpu(void)
 		mpic_irq_unmask(d);
 	}
=20
-	if (mpic_is_ipi_available())
-		mpic_ipi_resume();
+	if (mpic_is_ipi_available(mpic))
+		mpic_ipi_resume(mpic);
=20
-	mpic_msi_reenable_percpu();
+	mpic_msi_reenable_percpu(mpic);
 }
=20
 static int mpic_starting_cpu(unsigned int cpu)
 {
-	mpic_perf_init();
-	mpic_smp_cpu_init();
-	mpic_reenable_percpu();
+	struct mpic *mpic =3D irq_get_default_host()->host_data;
+
+	mpic_perf_init(mpic);
+	mpic_smp_cpu_init(mpic);
+	mpic_reenable_percpu(mpic);
=20
 	return 0;
 }
=20
 static int mpic_cascaded_starting_cpu(unsigned int cpu)
 {
-	mpic_perf_init();
-	mpic_reenable_percpu();
+	struct mpic *mpic =3D &mpic_data;
+
+	mpic_perf_init(mpic);
+	mpic_reenable_percpu(mpic);
 	enable_percpu_irq(mpic->parent_irq, IRQ_TYPE_NONE);
=20
 	return 0;
 }
 #else
-static void mpic_smp_cpu_init(void) {}
-static void mpic_ipi_resume(void) {}
+static void mpic_smp_cpu_init(struct mpic *mpic) {}
+static void mpic_ipi_resume(struct mpic *mpic) {}
 #endif
=20
 static struct irq_chip mpic_irq_chip =3D {
@@ -584,13 +599,16 @@ static struct irq_chip mpic_irq_chip =3D {
 	.flags		=3D IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND,
 };
=20
-static int mpic_irq_map(struct irq_domain *h, unsigned int virq,
-			irq_hw_number_t hwirq)
+static int mpic_irq_map(struct irq_domain *domain, unsigned int virq, irq_hw=
_number_t hwirq)
 {
+	struct mpic *mpic =3D domain->host_data;
+
 	/* IRQs 0 and 1 cannot be mapped, they are handled internally */
 	if (hwirq <=3D 1)
 		return -EINVAL;
=20
+	irq_set_chip_data(virq, mpic);
+
 	mpic_irq_mask(irq_get_irq_data(virq));
 	if (!mpic_is_percpu_irq(hwirq))
 		writel(hwirq, mpic->per_cpu + MPIC_INT_CLEAR_MASK);
@@ -615,7 +633,7 @@ static const struct irq_domain_ops mpic_irq_ops =3D {
 };
=20
 #ifdef CONFIG_PCI_MSI
-static void mpic_handle_msi_irq(void)
+static void mpic_handle_msi_irq(struct mpic *mpic)
 {
 	unsigned long cause;
 	unsigned int i;
@@ -628,11 +646,11 @@ static void mpic_handle_msi_irq(void)
 		generic_handle_domain_irq(mpic->msi_inner_domain, i - mpic->msi_doorbell_s=
tart);
 }
 #else
-static void mpic_handle_msi_irq(void) {}
+static void mpic_handle_msi_irq(struct mpic *mpic) {}
 #endif
=20
 #ifdef CONFIG_SMP
-static void mpic_handle_ipi_irq(void)
+static void mpic_handle_ipi_irq(struct mpic *mpic)
 {
 	unsigned long cause;
 	irq_hw_number_t i;
@@ -644,11 +662,12 @@ static void mpic_handle_ipi_irq(void)
 		generic_handle_domain_irq(mpic->ipi_domain, i);
 }
 #else
-static inline void mpic_handle_ipi_irq(void) {}
+static inline void mpic_handle_ipi_irq(struct mpic *mpic) {}
 #endif
=20
 static void mpic_handle_cascade_irq(struct irq_desc *desc)
 {
+	struct mpic *mpic =3D irq_desc_get_handler_data(desc);
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
 	unsigned long cause;
 	u32 irqsrc, cpuid;
@@ -669,7 +688,7 @@ static void mpic_handle_cascade_irq(struct irq_desc *desc)
 			continue;
=20
 		if (i =3D=3D 0 || i =3D=3D 1) {
-			mpic_handle_msi_irq();
+			mpic_handle_msi_irq(mpic);
 			continue;
 		}
=20
@@ -681,6 +700,7 @@ static void mpic_handle_cascade_irq(struct irq_desc *desc)
=20
 static void __exception_irq_entry mpic_handle_irq(struct pt_regs *regs)
 {
+	struct mpic *mpic =3D irq_get_default_host()->host_data;
 	irq_hw_number_t i;
 	u32 irqstat;
=20
@@ -696,16 +716,18 @@ static void __exception_irq_entry mpic_handle_irq(struc=
t pt_regs *regs)
=20
 		/* MSI handling */
 		if (i =3D=3D 1)
-			mpic_handle_msi_irq();
+			mpic_handle_msi_irq(mpic);
=20
 		/* IPI Handling */
 		if (i =3D=3D 0)
-			mpic_handle_ipi_irq();
+			mpic_handle_ipi_irq(mpic);
 	} while (1);
 }
=20
 static int mpic_suspend(void)
 {
+	struct mpic *mpic =3D &mpic_data;
+
 	mpic->doorbell_mask =3D readl(mpic->per_cpu + MPIC_IN_DRBEL_MASK);
=20
 	return 0;
@@ -713,6 +735,7 @@ static int mpic_suspend(void)
=20
 static void mpic_resume(void)
 {
+	struct mpic *mpic =3D &mpic_data;
 	bool src0, src1;
=20
 	/* Re-enable interrupts */
@@ -746,7 +769,7 @@ static void mpic_resume(void)
 	/* Reconfigure doorbells for IPIs and MSIs */
 	writel(mpic->doorbell_mask, mpic->per_cpu + MPIC_IN_DRBEL_MASK);
=20
-	if (mpic_is_ipi_available()) {
+	if (mpic_is_ipi_available(mpic)) {
 		src0 =3D mpic->doorbell_mask & IPI_DOORBELL_MASK;
 		src1 =3D mpic->doorbell_mask & PCI_MSI_DOORBELL_MASK;
 	} else {
@@ -759,8 +782,8 @@ static void mpic_resume(void)
 	if (src1)
 		writel(1, mpic->per_cpu + MPIC_INT_CLEAR_MASK);
=20
-	if (mpic_is_ipi_available())
-		mpic_ipi_resume();
+	if (mpic_is_ipi_available(mpic))
+		mpic_ipi_resume(mpic);
 }
=20
 static struct syscore_ops mpic_syscore_ops =3D {
@@ -801,6 +824,7 @@ fail:
=20
 static int __init mpic_of_init(struct device_node *node, struct device_node =
*parent)
 {
+	struct mpic *mpic =3D &mpic_data;
 	phys_addr_t phys_base;
 	unsigned int nr_irqs;
 	int err;
@@ -818,7 +842,7 @@ static int __init mpic_of_init(struct device_node *node, =
struct device_node *par
 	for (irq_hw_number_t i =3D 0; i < nr_irqs; i++)
 		writel(i, mpic->base + MPIC_INT_CLEAR_ENABLE);
=20
-	mpic->domain =3D irq_domain_add_linear(node, nr_irqs, &mpic_irq_ops, NULL);
+	mpic->domain =3D irq_domain_add_linear(node, nr_irqs, &mpic_irq_ops, mpic);
 	if (!mpic->domain) {
 		pr_err("%pOF: Unable to add IRQ domain\n", node);
 		return -ENOMEM;
@@ -833,10 +857,10 @@ static int __init mpic_of_init(struct device_node *node=
, struct device_node *par
 	mpic->parent_irq =3D irq_of_parse_and_map(node, 0);
=20
 	/* Setup for the boot CPU */
-	mpic_perf_init();
-	mpic_smp_cpu_init();
+	mpic_perf_init(mpic);
+	mpic_smp_cpu_init(mpic);
=20
-	err =3D mpic_msi_init(node, phys_base);
+	err =3D mpic_msi_init(mpic, node, phys_base);
 	if (err) {
 		pr_err("%pOF: Unable to initialize MSI domain\n", node);
 		return err;
@@ -846,7 +870,7 @@ static int __init mpic_of_init(struct device_node *node, =
struct device_node *par
 		irq_set_default_host(mpic->domain);
 		set_handle_irq(mpic_handle_irq);
 #ifdef CONFIG_SMP
-		err =3D mpic_ipi_init(node);
+		err =3D mpic_ipi_init(mpic, node);
 		if (err) {
 			pr_err("%pOF: Unable to initialize IPI domain\n", node);
 			return err;
@@ -862,7 +886,8 @@ static int __init mpic_of_init(struct device_node *node, =
struct device_node *par
 					  "irqchip/armada/cascade:starting",
 					  mpic_cascaded_starting_cpu, NULL);
 #endif
-		irq_set_chained_handler(mpic->parent_irq, mpic_handle_cascade_irq);
+		irq_set_chained_handler_and_data(mpic->parent_irq,
+						 mpic_handle_cascade_irq, mpic);
 	}
=20
 	register_syscore_ops(&mpic_syscore_ops);

