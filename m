Return-Path: <linux-tip-commits+bounces-2014-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6044B94C107
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 17:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C38CCB28EC3
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 15:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99441192B63;
	Thu,  8 Aug 2024 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YWedezRt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VyWAdhGy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64501917D7;
	Thu,  8 Aug 2024 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130510; cv=none; b=jH7+M0ocGelMmaQSN30PxvRrtD+S902UOoKwzo0u8Os4+ElZJcjTteNLuoVcep/3eCUr5jEXzj1QFyD9kJTt/y1hZcRi9jlrzMy0D8XCl5Ait1E7J6ia1o/Eao2nH54x400ks9K0T3ZpnQB5tObLtOYG/OSCySwkD5jlh0fwIag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130510; c=relaxed/simple;
	bh=OKGkklFDTWY7YGRbl5KT1Y+nI+JBLeJNQDn+Syk6mAc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=tcyCzV/tbE40TcXKpzFwGv+sfhM/OCYCGoUMTctb+uZzWB1TZqvCKw9+Fb2R+aLoWm1GW/I0hV8+XLfGlQR03kWX0KFoZSCF58hTToypRTJjv8hyw33lMkFfoR65KwzNQMIpmJZtQtUo0JEXTTLnHxgrXEY4XdvC3L8xjH1IWU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YWedezRt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VyWAdhGy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 15:21:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723130506;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=wO4rv8RNEnph7jj+1klQ80yqW1+75AWUH/xjYx/Y4Kc=;
	b=YWedezRtZ7tMNIKU70r2WE+taNycAscgVnC1BuzqKvCPCRwgUYFIknYj6ilJxjjLC3gzB1
	14ybW+dRX3S7VMXt06qYy3hB6mmDaZWA79m0OXgU+H6NqSUROj/zdP40kXOhzRvfgEQbQg
	An4UalKoXb3p/mxk7ahOI6qSIri7K+5qBHqCR17ZObDBpSO6bSRdAyzDu8w2Efjh2p4uTk
	mVZqdeej67nusO+oSn9DJWoQ7WwVZDAG/HSW1atZ86C2+P5s/7ku75Sfg88PwLEx6Ep3Y9
	U5PE2wkm0aTbdoJbxV3YmBvp3siBe8dzxuqZ6ZVmRt3hp2Tg7o3X0cGwLggoYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723130506;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=wO4rv8RNEnph7jj+1klQ80yqW1+75AWUH/xjYx/Y4Kc=;
	b=VyWAdhGypM5/FjT+JIMDKg/zOil3m2IezcuS0qg6npUhcdGosmd12RQAnRY3/Ld+lqcakU
	lxI7W7m7Iv8q2DDg==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Put static variables into
 driver private structure
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172313050568.2215.6760427063389656604.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     68fe2c59853611e2551370f0ab4b80b04a0748ee
Gitweb:        https://git.kernel.org/tip/68fe2c59853611e2551370f0ab4b80b04a0=
748ee
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Wed, 07 Aug 2024 18:40:57 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Aug 2024 17:15:00 +02:00

irqchip/armada-370-xp: Put static variables into driver private structure

In preparation for converting the driver to modern style put all the
interrupt controller private static variables into driver private
structure.

Access to these variables changes as:
  main_int_base		mpic->base
  per_cpu_int_base	mpic->per_cpu
  mpic_domain		mpic->domain
  parent_irq		mpic->parent_irq
  ...

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/irqchip/irq-armada-370-xp.c | 223 ++++++++++++++-------------
 1 file changed, 122 insertions(+), 101 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 07004ec..00f3842 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -66,11 +66,11 @@
  *
  * The "global interrupt mask/unmask" is modified using the
  * MPIC_INT_SET_ENABLE and MPIC_INT_CLEAR_ENABLE
- * registers, which are relative to "main_int_base".
+ * registers, which are relative to "mpic->base".
  *
  * The "per-CPU mask/unmask" is modified using the MPIC_INT_SET_MASK
  * and MPIC_INT_CLEAR_MASK registers, which are relative to
- * "per_cpu_int_base". This base address points to a special address,
+ * "mpic->per_cpu". This base address points to a special address,
  * which automatically accesses the registers of the current CPU.
  *
  * The per-CPU mask/unmask can also be adjusted using the global
@@ -112,7 +112,7 @@
  *    at the per-CPU level.
  */
=20
-/* Registers relative to main_int_base */
+/* Registers relative to mpic->base */
 #define MPIC_INT_CONTROL			0x00
 #define MPIC_INT_CONTROL_NUMINT_MASK		GENMASK(12, 2)
 #define MPIC_SW_TRIG_INT			0x04
@@ -122,7 +122,7 @@
 #define MPIC_INT_SOURCE_CPU_MASK		GENMASK(3, 0)
 #define MPIC_INT_IRQ_FIQ_MASK(cpuid)		((BIT(0) | BIT(8)) << (cpuid))
=20
-/* Registers relative to per_cpu_int_base */
+/* Registers relative to mpic->per_cpu */
 #define MPIC_IN_DRBEL_CAUSE			0x08
 #define MPIC_IN_DRBEL_MASK			0x0c
 #define MPIC_PPI_CAUSE				0x10
@@ -149,18 +149,40 @@
 #define PCI_MSI_FULL_DOORBELL_SRC0_MASK		GENMASK(15, 0)
 #define PCI_MSI_FULL_DOORBELL_SRC1_MASK		GENMASK(31, 16)
=20
-static void __iomem *per_cpu_int_base;
-static void __iomem *main_int_base;
-static struct irq_domain *mpic_domain;
-static u32 doorbell_mask_reg;
-static int parent_irq;
+/**
+ * struct mpic - MPIC private data structure
+ * @base:		MPIC registers base address
+ * @per_cpu:		per-CPU registers base address
+ * @parent_irq:		parent IRQ if MPIC is not top-level interrupt controller
+ * @domain:		MPIC main interrupt domain
+ * @ipi_domain:		IPI domain
+ * @msi_domain:		MSI domain
+ * @msi_inner_domain:	MSI inner domain
+ * @msi_used:		bitmap of used MSI numbers
+ * @msi_lock:		mutex serializing access to @msi_used
+ * @msi_doorbell_addr:	physical address of MSI doorbell register
+ * @doorbell_mask:	doorbell mask of MSIs and IPIs, stored on suspend, restor=
ed on resume
+ */
+struct mpic {
+	void __iomem *base;
+	void __iomem *per_cpu;
+	int parent_irq;
+	struct irq_domain *domain;
+#ifdef CONFIG_SMP
+	struct irq_domain *ipi_domain;
+#endif
 #ifdef CONFIG_PCI_MSI
-static struct irq_domain *mpic_msi_domain;
-static struct irq_domain *mpic_msi_inner_domain;
-static DECLARE_BITMAP(msi_used, PCI_MSI_FULL_DOORBELL_NR);
-static DEFINE_MUTEX(msi_used_lock);
-static phys_addr_t msi_doorbell_addr;
+	struct irq_domain *msi_domain;
+	struct irq_domain *msi_inner_domain;
+	DECLARE_BITMAP(msi_used, PCI_MSI_FULL_DOORBELL_NR);
+	struct mutex msi_lock;
+	phys_addr_t msi_doorbell_addr;
 #endif
+	u32 doorbell_mask;
+};
+
+static struct mpic mpic_data;
+static struct mpic * const mpic =3D &mpic_data;
=20
 static inline bool mpic_is_ipi_available(void)
 {
@@ -170,7 +192,7 @@ static inline bool mpic_is_ipi_available(void)
 	 * interrupt controller (e.g. GIC) that takes care of inter-processor
 	 * interrupts.
 	 */
-	return parent_irq <=3D 0;
+	return mpic->parent_irq <=3D 0;
 }
=20
 static inline u32 msi_doorbell_mask(void)
@@ -203,9 +225,9 @@ static void mpic_irq_mask(struct irq_data *d)
 	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
=20
 	if (!mpic_is_percpu_irq(hwirq))
-		writel(hwirq, main_int_base + MPIC_INT_CLEAR_ENABLE);
+		writel(hwirq, mpic->base + MPIC_INT_CLEAR_ENABLE);
 	else
-		writel(hwirq, per_cpu_int_base + MPIC_INT_SET_MASK);
+		writel(hwirq, mpic->per_cpu + MPIC_INT_SET_MASK);
 }
=20
 static void mpic_irq_unmask(struct irq_data *d)
@@ -213,9 +235,9 @@ static void mpic_irq_unmask(struct irq_data *d)
 	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
=20
 	if (!mpic_is_percpu_irq(hwirq))
-		writel(hwirq, main_int_base + MPIC_INT_SET_ENABLE);
+		writel(hwirq, mpic->base + MPIC_INT_SET_ENABLE);
 	else
-		writel(hwirq, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
+		writel(hwirq, mpic->per_cpu + MPIC_INT_CLEAR_MASK);
 }
=20
 #ifdef CONFIG_PCI_MSI
@@ -236,8 +258,8 @@ static void mpic_compose_msi_msg(struct irq_data *d, stru=
ct msi_msg *msg)
 {
 	unsigned int cpu =3D cpumask_first(irq_data_get_effective_affinity_mask(d));
=20
-	msg->address_lo =3D lower_32_bits(msi_doorbell_addr);
-	msg->address_hi =3D upper_32_bits(msi_doorbell_addr);
+	msg->address_lo =3D lower_32_bits(mpic->msi_doorbell_addr);
+	msg->address_hi =3D upper_32_bits(mpic->msi_doorbell_addr);
 	msg->data =3D BIT(cpu + 8) | (d->hwirq + msi_doorbell_start());
 }
=20
@@ -269,10 +291,10 @@ static int mpic_msi_alloc(struct irq_domain *domain, un=
signed int virq, unsigned
 {
 	int hwirq;
=20
-	mutex_lock(&msi_used_lock);
-	hwirq =3D bitmap_find_free_region(msi_used, msi_doorbell_size(),
+	mutex_lock(&mpic->msi_lock);
+	hwirq =3D bitmap_find_free_region(mpic->msi_used, msi_doorbell_size(),
 					order_base_2(nr_irqs));
-	mutex_unlock(&msi_used_lock);
+	mutex_unlock(&mpic->msi_lock);
=20
 	if (hwirq < 0)
 		return -ENOSPC;
@@ -291,9 +313,9 @@ static void mpic_msi_free(struct irq_domain *domain, unsi=
gned int virq, unsigned
 {
 	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
=20
-	mutex_lock(&msi_used_lock);
-	bitmap_release_region(msi_used, d->hwirq, order_base_2(nr_irqs));
-	mutex_unlock(&msi_used_lock);
+	mutex_lock(&mpic->msi_lock);
+	bitmap_release_region(mpic->msi_used, d->hwirq, order_base_2(nr_irqs));
+	mutex_unlock(&mpic->msi_lock);
 }
=20
 static const struct irq_domain_ops mpic_msi_domain_ops =3D {
@@ -306,27 +328,29 @@ static void mpic_msi_reenable_percpu(void)
 	u32 reg;
=20
 	/* Enable MSI doorbell mask and combined cpu local interrupt */
-	reg =3D readl(per_cpu_int_base + MPIC_IN_DRBEL_MASK);
+	reg =3D readl(mpic->per_cpu + MPIC_IN_DRBEL_MASK);
 	reg |=3D msi_doorbell_mask();
-	writel(reg, per_cpu_int_base + MPIC_IN_DRBEL_MASK);
+	writel(reg, mpic->per_cpu + MPIC_IN_DRBEL_MASK);
=20
 	/* Unmask local doorbell interrupt */
-	writel(1, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
+	writel(1, mpic->per_cpu + MPIC_INT_CLEAR_MASK);
 }
=20
 static int __init mpic_msi_init(struct device_node *node, phys_addr_t main_i=
nt_phys_base)
 {
-	msi_doorbell_addr =3D main_int_phys_base + MPIC_SW_TRIG_INT;
+	mpic->msi_doorbell_addr =3D main_int_phys_base + MPIC_SW_TRIG_INT;
+
+	mutex_init(&mpic->msi_lock);
=20
-	mpic_msi_inner_domain =3D irq_domain_add_linear(NULL, msi_doorbell_size(),
-						      &mpic_msi_domain_ops, NULL);
-	if (!mpic_msi_inner_domain)
+	mpic->msi_inner_domain =3D irq_domain_add_linear(NULL, msi_doorbell_size(),
+						       &mpic_msi_domain_ops, NULL);
+	if (!mpic->msi_inner_domain)
 		return -ENOMEM;
=20
-	mpic_msi_domain =3D pci_msi_create_irq_domain(of_node_to_fwnode(node), &mpi=
c_msi_domain_info,
-						    mpic_msi_inner_domain);
-	if (!mpic_msi_domain) {
-		irq_domain_remove(mpic_msi_inner_domain);
+	mpic->msi_domain =3D pci_msi_create_irq_domain(of_node_to_fwnode(node), &mp=
ic_msi_domain_info,
+						     mpic->msi_inner_domain);
+	if (!mpic->msi_domain) {
+		irq_domain_remove(mpic->msi_inner_domain);
 		return -ENOMEM;
 	}
=20
@@ -334,7 +358,7 @@ static int __init mpic_msi_init(struct device_node *node,=
 phys_addr_t main_int_p
=20
 	/* Unmask low 16 MSI irqs on non-IPI platforms */
 	if (!mpic_is_ipi_available())
-		writel(0, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
+		writel(0, mpic->per_cpu + MPIC_INT_CLEAR_MASK);
=20
 	return 0;
 }
@@ -362,29 +386,26 @@ static void mpic_perf_init(void)
 	cpuid =3D cpu_logical_map(smp_processor_id());
=20
 	/* Enable Performance Counter Overflow interrupts */
-	writel(MPIC_INT_CAUSE_PERF(cpuid),
-	       per_cpu_int_base + MPIC_INT_FABRIC_MASK);
+	writel(MPIC_INT_CAUSE_PERF(cpuid), mpic->per_cpu + MPIC_INT_FABRIC_MASK);
 }
=20
 #ifdef CONFIG_SMP
-static struct irq_domain *mpic_ipi_domain;
-
 static void mpic_ipi_mask(struct irq_data *d)
 {
 	u32 reg;
=20
-	reg =3D readl(per_cpu_int_base + MPIC_IN_DRBEL_MASK);
+	reg =3D readl(mpic->per_cpu + MPIC_IN_DRBEL_MASK);
 	reg &=3D ~BIT(d->hwirq);
-	writel(reg, per_cpu_int_base + MPIC_IN_DRBEL_MASK);
+	writel(reg, mpic->per_cpu + MPIC_IN_DRBEL_MASK);
 }
=20
 static void mpic_ipi_unmask(struct irq_data *d)
 {
 	u32 reg;
=20
-	reg =3D readl(per_cpu_int_base + MPIC_IN_DRBEL_MASK);
+	reg =3D readl(mpic->per_cpu + MPIC_IN_DRBEL_MASK);
 	reg |=3D BIT(d->hwirq);
-	writel(reg, per_cpu_int_base + MPIC_IN_DRBEL_MASK);
+	writel(reg, mpic->per_cpu + MPIC_IN_DRBEL_MASK);
 }
=20
 static void mpic_ipi_send_mask(struct irq_data *d, const struct cpumask *mas=
k)
@@ -403,12 +424,12 @@ static void mpic_ipi_send_mask(struct irq_data *d, cons=
t struct cpumask *mask)
 	dsb();
=20
 	/* submit softirq */
-	writel((map << 8) | d->hwirq, main_int_base + MPIC_SW_TRIG_INT);
+	writel((map << 8) | d->hwirq, mpic->base + MPIC_SW_TRIG_INT);
 }
=20
 static void mpic_ipi_ack(struct irq_data *d)
 {
-	writel(~BIT(d->hwirq), per_cpu_int_base + MPIC_IN_DRBEL_CAUSE);
+	writel(~BIT(d->hwirq), mpic->per_cpu + MPIC_IN_DRBEL_CAUSE);
 }
=20
 static struct irq_chip mpic_ipi_irqchip =3D {
@@ -445,13 +466,13 @@ static const struct irq_domain_ops mpic_ipi_domain_ops =
=3D {
 static void mpic_ipi_resume(void)
 {
 	for (irq_hw_number_t i =3D 0; i < IPI_DOORBELL_NR; i++) {
-		unsigned int virq =3D irq_find_mapping(mpic_ipi_domain, i);
+		unsigned int virq =3D irq_find_mapping(mpic->ipi_domain, i);
 		struct irq_data *d;
=20
 		if (!virq || !irq_percpu_is_enabled(virq))
 			continue;
=20
-		d =3D irq_domain_get_irq_data(mpic_ipi_domain, virq);
+		d =3D irq_domain_get_irq_data(mpic->ipi_domain, virq);
 		mpic_ipi_unmask(d);
 	}
 }
@@ -460,13 +481,13 @@ static int __init mpic_ipi_init(struct device_node *nod=
e)
 {
 	int base_ipi;
=20
-	mpic_ipi_domain =3D irq_domain_create_linear(of_node_to_fwnode(node), IPI_D=
OORBELL_NR,
-						   &mpic_ipi_domain_ops, NULL);
-	if (WARN_ON(!mpic_ipi_domain))
+	mpic->ipi_domain =3D irq_domain_create_linear(of_node_to_fwnode(node), IPI_=
DOORBELL_NR,
+						    &mpic_ipi_domain_ops, NULL);
+	if (WARN_ON(!mpic->ipi_domain))
 		return -ENOMEM;
=20
-	irq_domain_update_bus_token(mpic_ipi_domain, DOMAIN_BUS_IPI);
-	base_ipi =3D irq_domain_alloc_irqs(mpic_ipi_domain, IPI_DOORBELL_NR, NUMA_N=
O_NODE, NULL);
+	irq_domain_update_bus_token(mpic->ipi_domain, DOMAIN_BUS_IPI);
+	base_ipi =3D irq_domain_alloc_irqs(mpic->ipi_domain, IPI_DOORBELL_NR, NUMA_=
NO_NODE, NULL);
 	if (WARN_ON(!base_ipi))
 		return -ENOMEM;
=20
@@ -483,7 +504,7 @@ static int mpic_set_affinity(struct irq_data *d, const st=
ruct cpumask *mask_val,
 	/* Select a single core from the affinity mask which is online */
 	cpu =3D cpumask_any_and(mask_val, cpu_online_mask);
=20
-	atomic_io_modify(main_int_base + MPIC_INT_SOURCE_CTL(hwirq),
+	atomic_io_modify(mpic->base + MPIC_INT_SOURCE_CTL(hwirq),
 			 MPIC_INT_SOURCE_CPU_MASK, BIT(cpu_logical_map(cpu)));
=20
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
@@ -493,27 +514,27 @@ static int mpic_set_affinity(struct irq_data *d, const =
struct cpumask *mask_val,
=20
 static void mpic_smp_cpu_init(void)
 {
-	for (irq_hw_number_t i =3D 0; i < mpic_domain->hwirq_max; i++)
-		writel(i, per_cpu_int_base + MPIC_INT_SET_MASK);
+	for (irq_hw_number_t i =3D 0; i < mpic->domain->hwirq_max; i++)
+		writel(i, mpic->per_cpu + MPIC_INT_SET_MASK);
=20
 	if (!mpic_is_ipi_available())
 		return;
=20
 	/* Disable all IPIs */
-	writel(0, per_cpu_int_base + MPIC_IN_DRBEL_MASK);
+	writel(0, mpic->per_cpu + MPIC_IN_DRBEL_MASK);
=20
 	/* Clear pending IPIs */
-	writel(0, per_cpu_int_base + MPIC_IN_DRBEL_CAUSE);
+	writel(0, mpic->per_cpu + MPIC_IN_DRBEL_CAUSE);
=20
 	/* Unmask IPI interrupt */
-	writel(0, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
+	writel(0, mpic->per_cpu + MPIC_INT_CLEAR_MASK);
 }
=20
 static void mpic_reenable_percpu(void)
 {
 	/* Re-enable per-CPU interrupts that were enabled before suspend */
 	for (irq_hw_number_t i =3D 0; i < MPIC_MAX_PER_CPU_IRQS; i++) {
-		unsigned int virq =3D irq_linear_revmap(mpic_domain, i);
+		unsigned int virq =3D irq_linear_revmap(mpic->domain, i);
 		struct irq_data *d;
=20
 		if (!virq || !irq_percpu_is_enabled(virq))
@@ -542,7 +563,7 @@ static int mpic_cascaded_starting_cpu(unsigned int cpu)
 {
 	mpic_perf_init();
 	mpic_reenable_percpu();
-	enable_percpu_irq(parent_irq, IRQ_TYPE_NONE);
+	enable_percpu_irq(mpic->parent_irq, IRQ_TYPE_NONE);
=20
 	return 0;
 }
@@ -571,9 +592,9 @@ static int mpic_irq_map(struct irq_domain *h, unsigned in=
t virq,
=20
 	mpic_irq_mask(irq_get_irq_data(virq));
 	if (!mpic_is_percpu_irq(hwirq))
-		writel(hwirq, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
+		writel(hwirq, mpic->per_cpu + MPIC_INT_CLEAR_MASK);
 	else
-		writel(hwirq, main_int_base + MPIC_INT_SET_ENABLE);
+		writel(hwirq, mpic->base + MPIC_INT_SET_ENABLE);
 	irq_set_status_flags(virq, IRQ_LEVEL);
=20
 	if (mpic_is_percpu_irq(hwirq)) {
@@ -598,12 +619,12 @@ static void mpic_handle_msi_irq(void)
 	unsigned long cause;
 	unsigned int i;
=20
-	cause =3D readl_relaxed(per_cpu_int_base + MPIC_IN_DRBEL_CAUSE);
+	cause =3D readl_relaxed(mpic->per_cpu + MPIC_IN_DRBEL_CAUSE);
 	cause &=3D msi_doorbell_mask();
-	writel(~cause, per_cpu_int_base + MPIC_IN_DRBEL_CAUSE);
+	writel(~cause, mpic->per_cpu + MPIC_IN_DRBEL_CAUSE);
=20
 	for_each_set_bit(i, &cause, BITS_PER_LONG)
-		generic_handle_domain_irq(mpic_msi_inner_domain,
+		generic_handle_domain_irq(mpic->msi_inner_domain,
 					  i - msi_doorbell_start());
 }
 #else
@@ -616,11 +637,11 @@ static void mpic_handle_ipi_irq(void)
 	unsigned long cause;
 	irq_hw_number_t i;
=20
-	cause =3D readl_relaxed(per_cpu_int_base + MPIC_IN_DRBEL_CAUSE);
+	cause =3D readl_relaxed(mpic->per_cpu + MPIC_IN_DRBEL_CAUSE);
 	cause &=3D IPI_DOORBELL_MASK;
=20
 	for_each_set_bit(i, &cause, IPI_DOORBELL_NR)
-		generic_handle_domain_irq(mpic_ipi_domain, i);
+		generic_handle_domain_irq(mpic->ipi_domain, i);
 }
 #else
 static inline void mpic_handle_ipi_irq(void) {}
@@ -635,11 +656,11 @@ static void mpic_handle_cascade_irq(struct irq_desc *de=
sc)
=20
 	chained_irq_enter(chip, desc);
=20
-	cause =3D readl_relaxed(per_cpu_int_base + MPIC_PPI_CAUSE);
+	cause =3D readl_relaxed(mpic->per_cpu + MPIC_PPI_CAUSE);
 	cpuid =3D cpu_logical_map(smp_processor_id());
=20
 	for_each_set_bit(i, &cause, BITS_PER_LONG) {
-		irqsrc =3D readl_relaxed(main_int_base + MPIC_INT_SOURCE_CTL(i));
+		irqsrc =3D readl_relaxed(mpic->base + MPIC_INT_SOURCE_CTL(i));
=20
 		/* Check if the interrupt is not masked on current CPU.
 		 * Test IRQ (0-1) and FIQ (8-9) mask bits.
@@ -652,7 +673,7 @@ static void mpic_handle_cascade_irq(struct irq_desc *desc)
 			continue;
 		}
=20
-		generic_handle_domain_irq(mpic_domain, i);
+		generic_handle_domain_irq(mpic->domain, i);
 	}
=20
 	chained_irq_exit(chip, desc);
@@ -664,14 +685,14 @@ static void __exception_irq_entry mpic_handle_irq(struc=
t pt_regs *regs)
 	u32 irqstat;
=20
 	do {
-		irqstat =3D readl_relaxed(per_cpu_int_base + MPIC_CPU_INTACK);
+		irqstat =3D readl_relaxed(mpic->per_cpu + MPIC_CPU_INTACK);
 		i =3D FIELD_GET(MPIC_CPU_INTACK_IID_MASK, irqstat);
=20
 		if (i > 1022)
 			break;
=20
 		if (i > 1)
-			generic_handle_domain_irq(mpic_domain, i);
+			generic_handle_domain_irq(mpic->domain, i);
=20
 		/* MSI handling */
 		if (i =3D=3D 1)
@@ -685,7 +706,7 @@ static void __exception_irq_entry mpic_handle_irq(struct =
pt_regs *regs)
=20
 static int mpic_suspend(void)
 {
-	doorbell_mask_reg =3D readl(per_cpu_int_base + MPIC_IN_DRBEL_MASK);
+	mpic->doorbell_mask =3D readl(mpic->per_cpu + MPIC_IN_DRBEL_MASK);
=20
 	return 0;
 }
@@ -695,8 +716,8 @@ static void mpic_resume(void)
 	bool src0, src1;
=20
 	/* Re-enable interrupts */
-	for (irq_hw_number_t i =3D 0; i < mpic_domain->hwirq_max; i++) {
-		unsigned int virq =3D irq_linear_revmap(mpic_domain, i);
+	for (irq_hw_number_t i =3D 0; i < mpic->domain->hwirq_max; i++) {
+		unsigned int virq =3D irq_linear_revmap(mpic->domain, i);
 		struct irq_data *d;
=20
 		if (!virq)
@@ -706,12 +727,12 @@ static void mpic_resume(void)
=20
 		if (!mpic_is_percpu_irq(i)) {
 			/* Non per-CPU interrupts */
-			writel(i, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
+			writel(i, mpic->per_cpu + MPIC_INT_CLEAR_MASK);
 			if (!irqd_irq_disabled(d))
 				mpic_irq_unmask(d);
 		} else {
 			/* Per-CPU interrupts */
-			writel(i, main_int_base + MPIC_INT_SET_ENABLE);
+			writel(i, mpic->base + MPIC_INT_SET_ENABLE);
=20
 			/*
 			 * Re-enable on the current CPU, mpic_reenable_percpu()
@@ -723,20 +744,20 @@ static void mpic_resume(void)
 	}
=20
 	/* Reconfigure doorbells for IPIs and MSIs */
-	writel(doorbell_mask_reg, per_cpu_int_base + MPIC_IN_DRBEL_MASK);
+	writel(mpic->doorbell_mask, mpic->per_cpu + MPIC_IN_DRBEL_MASK);
=20
 	if (mpic_is_ipi_available()) {
-		src0 =3D doorbell_mask_reg & IPI_DOORBELL_MASK;
-		src1 =3D doorbell_mask_reg & PCI_MSI_DOORBELL_MASK;
+		src0 =3D mpic->doorbell_mask & IPI_DOORBELL_MASK;
+		src1 =3D mpic->doorbell_mask & PCI_MSI_DOORBELL_MASK;
 	} else {
-		src0 =3D doorbell_mask_reg & PCI_MSI_FULL_DOORBELL_SRC0_MASK;
-		src1 =3D doorbell_mask_reg & PCI_MSI_FULL_DOORBELL_SRC1_MASK;
+		src0 =3D mpic->doorbell_mask & PCI_MSI_FULL_DOORBELL_SRC0_MASK;
+		src1 =3D mpic->doorbell_mask & PCI_MSI_FULL_DOORBELL_SRC1_MASK;
 	}
=20
 	if (src0)
-		writel(0, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
+		writel(0, mpic->per_cpu + MPIC_INT_CLEAR_MASK);
 	if (src1)
-		writel(1, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
+		writel(1, mpic->per_cpu + MPIC_INT_CLEAR_MASK);
=20
 	if (mpic_is_ipi_available())
 		mpic_ipi_resume();
@@ -784,32 +805,32 @@ static int __init mpic_of_init(struct device_node *node=
, struct device_node *par
 	unsigned int nr_irqs;
 	int err;
=20
-	err =3D mpic_map_region(node, 0, &main_int_base, &phys_base);
+	err =3D mpic_map_region(node, 0, &mpic->base, &phys_base);
 	if (err)
 		return err;
=20
-	err =3D mpic_map_region(node, 1, &per_cpu_int_base, NULL);
+	err =3D mpic_map_region(node, 1, &mpic->per_cpu, NULL);
 	if (err)
 		return err;
=20
-	nr_irqs =3D FIELD_GET(MPIC_INT_CONTROL_NUMINT_MASK, readl(main_int_base + M=
PIC_INT_CONTROL));
+	nr_irqs =3D FIELD_GET(MPIC_INT_CONTROL_NUMINT_MASK, readl(mpic->base + MPIC=
_INT_CONTROL));
=20
 	for (irq_hw_number_t i =3D 0; i < nr_irqs; i++)
-		writel(i, main_int_base + MPIC_INT_CLEAR_ENABLE);
+		writel(i, mpic->base + MPIC_INT_CLEAR_ENABLE);
=20
-	mpic_domain =3D irq_domain_add_linear(node, nr_irqs, &mpic_irq_ops, NULL);
-	if (!mpic_domain) {
+	mpic->domain =3D irq_domain_add_linear(node, nr_irqs, &mpic_irq_ops, NULL);
+	if (!mpic->domain) {
 		pr_err("%pOF: Unable to add IRQ domain\n", node);
 		return -ENOMEM;
 	}
=20
-	irq_domain_update_bus_token(mpic_domain, DOMAIN_BUS_WIRED);
+	irq_domain_update_bus_token(mpic->domain, DOMAIN_BUS_WIRED);
=20
 	/*
-	 * Initialize parent_irq before calling any other functions, since it is
-	 * used to distinguish between IPI and non-IPI platforms.
+	 * Initialize mpic->parent_irq before calling any other functions, since
+	 * it is used to distinguish between IPI and non-IPI platforms.
 	 */
-	parent_irq =3D irq_of_parse_and_map(node, 0);
+	mpic->parent_irq =3D irq_of_parse_and_map(node, 0);
=20
 	/* Setup for the boot CPU */
 	mpic_perf_init();
@@ -821,8 +842,8 @@ static int __init mpic_of_init(struct device_node *node, =
struct device_node *par
 		return err;
 	}
=20
-	if (parent_irq <=3D 0) {
-		irq_set_default_host(mpic_domain);
+	if (mpic->parent_irq <=3D 0) {
+		irq_set_default_host(mpic->domain);
 		set_handle_irq(mpic_handle_irq);
 #ifdef CONFIG_SMP
 		err =3D mpic_ipi_init(node);
@@ -841,7 +862,7 @@ static int __init mpic_of_init(struct device_node *node, =
struct device_node *par
 					  "irqchip/armada/cascade:starting",
 					  mpic_cascaded_starting_cpu, NULL);
 #endif
-		irq_set_chained_handler(parent_irq, mpic_handle_cascade_irq);
+		irq_set_chained_handler(mpic->parent_irq, mpic_handle_cascade_irq);
 	}
=20
 	register_syscore_ops(&mpic_syscore_ops);

