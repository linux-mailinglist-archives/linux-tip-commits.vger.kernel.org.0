Return-Path: <linux-tip-commits+bounces-1846-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1B19410E5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1B4D1C20AB4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A4E1A2542;
	Tue, 30 Jul 2024 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RcI+ejic";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FK8lT/p0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2685199223;
	Tue, 30 Jul 2024 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339610; cv=none; b=SCxvqPsYd9Hy2TByObBBDum70RAluZoq1+zCrCOT6hbz/6OpvoOrywclqxGZDg7L6dilN0Jaxjt3Jj7nvga28OWFs93QYLVwIJgI0iErwz1h4aMg8roSbUN42n5kfEaQv35muhYmrC+stxI0WxfuRxYY5JOhsseuxNCLUb30k3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339610; c=relaxed/simple;
	bh=dPMOS4F6bqPLpMhJBh+RrFFIAJlJqIo0FM9TdBy6sXQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pY4Cor6rl2PN/Bl8FBNkN6d0LFUdLhhJ/xTYNFgM5fBFyCZ1jXSgL6BOYtjwo3NXUdQmCSZ+rL8Fd4O/K3ggjsspcwM8F/kbBuI53QKihz+e0GOUEROXx8jANzs79eyZ74ipd6eRxAMnFU7tnIxo1j2oyGtCvIC9tH35fJBqZ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RcI+ejic; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FK8lT/p0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:40:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=phXSc8VdYMKquAsD+fwIvJTGQzxT1S8eYfLRkWsbwoU=;
	b=RcI+ejicwi4chJh4gEYmYZt42wCKw5gJxM/Ici0lXoKK7SS22xpmOmZ3ktURhmhsjnY95n
	RVQKqAOVvHGx2cv0U7OM+8Ej83qK5gzFbX05oxHKzqI0gv/iQzd8hG2Gmn0/Ca4V0axwBS
	Q0736qS+AynGFsjA4SeQ7U7bpMGvrw0mNsUr4dR1avL2/wZjtrxu/vGQsPAxDDHzXrn1T4
	8oWjx5PdLAxBkjZmZ3JrsiDVd1KEvLbGlquNyEGB5LUL+xR6hk7dAtn+1rsjWBVk0WIYeY
	yqNP7nVrWL6rr2p7bQ7Ntv9+7B//EymekwZe99lj5sBEtvije3bwmIIrmVIekQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339605;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=phXSc8VdYMKquAsD+fwIvJTGQzxT1S8eYfLRkWsbwoU=;
	b=FK8lT/p0iLi4lw2YBFkIn55EKjUP+zf0mJF5UO5drfMF9iXYqgQN3UBB8PKEQGCdhoXCzR
	yp84tXOxBSM7R3Dg==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Drop _OFFS suffix from some
 register constants
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 ilpo.jarvinen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20240708151801.11592-2-kabel@kernel.org>
References: <20240708151801.11592-2-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172233960487.2215.1630452113782676420.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5e389e9868878c8aeb3ed60789eb62242506c9f8
Gitweb:        https://git.kernel.org/tip/5e389e9868878c8aeb3ed60789eb6224250=
6c9f8
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Mon, 08 Jul 2024 17:17:52 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:45 +02:00

irqchip/armada-370-xp: Drop _OFFS suffix from some register constants

Some register constants have the _OFFS suffix and some do not. Drop it
to be more consistent.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/all/20240708151801.11592-2-kabel@kernel.org


---
 drivers/irqchip/irq-armada-370-xp.c | 105 ++++++++++++---------------
 1 file changed, 48 insertions(+), 57 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index dce2b80..66d6a2e 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -66,15 +66,14 @@
  *                   device
  *
  * The "global interrupt mask/unmask" is modified using the
- * ARMADA_370_XP_INT_SET_ENABLE_OFFS and
- * ARMADA_370_XP_INT_CLEAR_ENABLE_OFFS registers, which are relative
- * to "main_int_base".
+ * ARMADA_370_XP_INT_SET_ENABLE and ARMADA_370_XP_INT_CLEAR_ENABLE
+ * registers, which are relative to "main_int_base".
  *
  * The "per-CPU mask/unmask" is modified using the
- * ARMADA_370_XP_INT_SET_MASK_OFFS and
- * ARMADA_370_XP_INT_CLEAR_MASK_OFFS registers, which are relative to
- * "per_cpu_int_base". This base address points to a special address,
- * which automatically accesses the registers of the current CPU.
+ * ARMADA_370_XP_INT_SET_MASK and ARMADA_370_XP_INT_CLEAR_MASK
+ * registers, which are relative to "per_cpu_int_base". This base
+ * address points to a special address, which automatically accesses
+ * the registers of the current CPU.
  *
  * The per-CPU mask/unmask can also be adjusted using the global
  * per-interrupt ARMADA_370_XP_INT_SOURCE_CTL register, which we use
@@ -118,21 +117,21 @@
=20
 /* Registers relative to main_int_base */
 #define ARMADA_370_XP_INT_CONTROL		(0x00)
-#define ARMADA_370_XP_SW_TRIG_INT_OFFS		(0x04)
-#define ARMADA_370_XP_INT_SET_ENABLE_OFFS	(0x30)
-#define ARMADA_370_XP_INT_CLEAR_ENABLE_OFFS	(0x34)
+#define ARMADA_370_XP_SW_TRIG_INT		(0x04)
+#define ARMADA_370_XP_INT_SET_ENABLE		(0x30)
+#define ARMADA_370_XP_INT_CLEAR_ENABLE		(0x34)
 #define ARMADA_370_XP_INT_SOURCE_CTL(irq)	(0x100 + irq*4)
 #define ARMADA_370_XP_INT_SOURCE_CPU_MASK	0xF
 #define ARMADA_370_XP_INT_IRQ_FIQ_MASK(cpuid)	((BIT(0) | BIT(8)) << cpuid)
=20
 /* Registers relative to per_cpu_int_base */
-#define ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS	(0x08)
-#define ARMADA_370_XP_IN_DRBEL_MSK_OFFS		(0x0c)
+#define ARMADA_370_XP_IN_DRBEL_CAUSE		(0x08)
+#define ARMADA_370_XP_IN_DRBEL_MSK		(0x0c)
 #define ARMADA_375_PPI_CAUSE			(0x10)
-#define ARMADA_370_XP_CPU_INTACK_OFFS		(0x44)
-#define ARMADA_370_XP_INT_SET_MASK_OFFS		(0x48)
-#define ARMADA_370_XP_INT_CLEAR_MASK_OFFS	(0x4C)
-#define ARMADA_370_XP_INT_FABRIC_MASK_OFFS	(0x54)
+#define ARMADA_370_XP_CPU_INTACK		(0x44)
+#define ARMADA_370_XP_INT_SET_MASK		(0x48)
+#define ARMADA_370_XP_INT_CLEAR_MASK		(0x4C)
+#define ARMADA_370_XP_INT_FABRIC_MASK		(0x54)
 #define ARMADA_370_XP_INT_CAUSE_PERF(cpu)	(1 << cpu)
=20
 #define ARMADA_370_XP_MAX_PER_CPU_IRQS		(28)
@@ -220,11 +219,9 @@ static void armada_370_xp_irq_mask(struct irq_data *d)
 	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
=20
 	if (!is_percpu_irq(hwirq))
-		writel(hwirq, main_int_base +
-				ARMADA_370_XP_INT_CLEAR_ENABLE_OFFS);
+		writel(hwirq, main_int_base + ARMADA_370_XP_INT_CLEAR_ENABLE);
 	else
-		writel(hwirq, per_cpu_int_base +
-				ARMADA_370_XP_INT_SET_MASK_OFFS);
+		writel(hwirq, per_cpu_int_base + ARMADA_370_XP_INT_SET_MASK);
 }
=20
 static void armada_370_xp_irq_unmask(struct irq_data *d)
@@ -232,11 +229,9 @@ static void armada_370_xp_irq_unmask(struct irq_data *d)
 	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
=20
 	if (!is_percpu_irq(hwirq))
-		writel(hwirq, main_int_base +
-				ARMADA_370_XP_INT_SET_ENABLE_OFFS);
+		writel(hwirq, main_int_base + ARMADA_370_XP_INT_SET_ENABLE);
 	else
-		writel(hwirq, per_cpu_int_base +
-				ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+		writel(hwirq, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK);
 }
=20
 #ifdef CONFIG_PCI_MSI
@@ -329,19 +324,18 @@ static void armada_370_xp_msi_reenable_percpu(void)
 	u32 reg;
=20
 	/* Enable MSI doorbell mask and combined cpu local interrupt */
-	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
 	reg |=3D msi_doorbell_mask();
-	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
=20
 	/* Unmask local doorbell interrupt */
-	writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+	writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK);
 }
=20
 static int armada_370_xp_msi_init(struct device_node *node,
 				  phys_addr_t main_int_phys_base)
 {
-	msi_doorbell_addr =3D main_int_phys_base +
-		ARMADA_370_XP_SW_TRIG_INT_OFFS;
+	msi_doorbell_addr =3D main_int_phys_base + ARMADA_370_XP_SW_TRIG_INT;
=20
 	armada_370_xp_msi_inner_domain =3D
 		irq_domain_add_linear(NULL, msi_doorbell_size(),
@@ -362,7 +356,7 @@ static int armada_370_xp_msi_init(struct device_node *nod=
e,
=20
 	/* Unmask low 16 MSI irqs on non-IPI platforms */
 	if (!is_ipi_available())
-		writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+		writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK);
=20
 	return 0;
 }
@@ -391,7 +385,7 @@ static void armada_xp_mpic_perf_init(void)
=20
 	/* Enable Performance Counter Overflow interrupts */
 	writel(ARMADA_370_XP_INT_CAUSE_PERF(cpuid),
-	       per_cpu_int_base + ARMADA_370_XP_INT_FABRIC_MASK_OFFS);
+	       per_cpu_int_base + ARMADA_370_XP_INT_FABRIC_MASK);
 }
=20
 #ifdef CONFIG_SMP
@@ -400,17 +394,17 @@ static struct irq_domain *ipi_domain;
 static void armada_370_xp_ipi_mask(struct irq_data *d)
 {
 	u32 reg;
-	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
 	reg &=3D ~BIT(d->hwirq);
-	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
 }
=20
 static void armada_370_xp_ipi_unmask(struct irq_data *d)
 {
 	u32 reg;
-	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
 	reg |=3D BIT(d->hwirq);
-	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
 }
=20
 static void armada_370_xp_ipi_send_mask(struct irq_data *d,
@@ -431,12 +425,12 @@ static void armada_370_xp_ipi_send_mask(struct irq_data=
 *d,
=20
 	/* submit softirq */
 	writel((map << 8) | d->hwirq, main_int_base +
-		ARMADA_370_XP_SW_TRIG_INT_OFFS);
+		ARMADA_370_XP_SW_TRIG_INT);
 }
=20
 static void armada_370_xp_ipi_ack(struct irq_data *d)
 {
-	writel(~BIT(d->hwirq), per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS=
);
+	writel(~BIT(d->hwirq), per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE);
 }
=20
 static struct irq_chip ipi_irqchip =3D {
@@ -539,19 +533,19 @@ static void armada_xp_mpic_smp_cpu_init(void)
 	nr_irqs =3D (control >> 2) & 0x3ff;
=20
 	for (i =3D 0; i < nr_irqs; i++)
-		writel(i, per_cpu_int_base + ARMADA_370_XP_INT_SET_MASK_OFFS);
+		writel(i, per_cpu_int_base + ARMADA_370_XP_INT_SET_MASK);
=20
 	if (!is_ipi_available())
 		return;
=20
 	/* Disable all IPIs */
-	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
=20
 	/* Clear pending IPIs */
-	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
+	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE);
=20
 	/* Unmask IPI interrupt */
-	writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+	writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK);
 }
=20
 static void armada_xp_mpic_reenable_percpu(void)
@@ -622,9 +616,9 @@ static int armada_370_xp_mpic_irq_map(struct irq_domain *=
h,
 	armada_370_xp_irq_mask(irq_get_irq_data(virq));
 	if (!is_percpu_irq(hw))
 		writel(hw, per_cpu_int_base +
-			ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+			ARMADA_370_XP_INT_CLEAR_MASK);
 	else
-		writel(hw, main_int_base + ARMADA_370_XP_INT_SET_ENABLE_OFFS);
+		writel(hw, main_int_base + ARMADA_370_XP_INT_SET_ENABLE);
 	irq_set_status_flags(virq, IRQ_LEVEL);
=20
 	if (is_percpu_irq(hw)) {
@@ -651,12 +645,10 @@ static void armada_370_xp_handle_msi_irq(struct pt_regs=
 *regs, bool is_chained)
 {
 	u32 msimask, msinr;
=20
-	msimask =3D readl_relaxed(per_cpu_int_base +
-				ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
+	msimask =3D readl_relaxed(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE);
 	msimask &=3D msi_doorbell_mask();
=20
-	writel(~msimask, per_cpu_int_base +
-	       ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS);
+	writel(~msimask, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE);
=20
 	for (msinr =3D msi_doorbell_start();
 	     msinr < msi_doorbell_end(); msinr++) {
@@ -712,7 +704,7 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
=20
 	do {
 		irqstat =3D readl_relaxed(per_cpu_int_base +
-					ARMADA_370_XP_CPU_INTACK_OFFS);
+					ARMADA_370_XP_CPU_INTACK);
 		irqnr =3D irqstat & 0x3FF;
=20
 		if (irqnr > 1022)
@@ -735,7 +727,7 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
 			int ipi;
=20
 			ipimask =3D readl_relaxed(per_cpu_int_base +
-						ARMADA_370_XP_IN_DRBEL_CAUSE_OFFS)
+						ARMADA_370_XP_IN_DRBEL_CAUSE)
 				& IPI_DOORBELL_MASK;
=20
 			for_each_set_bit(ipi, &ipimask, IPI_DOORBELL_END)
@@ -748,8 +740,7 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
=20
 static int armada_370_xp_mpic_suspend(void)
 {
-	doorbell_mask_reg =3D readl(per_cpu_int_base +
-				  ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	doorbell_mask_reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
 	return 0;
 }
=20
@@ -774,13 +765,13 @@ static void armada_370_xp_mpic_resume(void)
 		if (!is_percpu_irq(irq)) {
 			/* Non per-CPU interrupts */
 			writel(irq, per_cpu_int_base +
-			       ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+			       ARMADA_370_XP_INT_CLEAR_MASK);
 			if (!irqd_irq_disabled(data))
 				armada_370_xp_irq_unmask(data);
 		} else {
 			/* Per-CPU interrupts */
 			writel(irq, main_int_base +
-			       ARMADA_370_XP_INT_SET_ENABLE_OFFS);
+			       ARMADA_370_XP_INT_SET_ENABLE);
=20
 			/*
 			 * Re-enable on the current CPU,
@@ -794,7 +785,7 @@ static void armada_370_xp_mpic_resume(void)
=20
 	/* Reconfigure doorbells for IPIs and MSIs */
 	writel(doorbell_mask_reg,
-	       per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	       per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
=20
 	if (is_ipi_available()) {
 		src0 =3D doorbell_mask_reg & IPI_DOORBELL_MASK;
@@ -805,9 +796,9 @@ static void armada_370_xp_mpic_resume(void)
 	}
=20
 	if (src0)
-		writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+		writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK);
 	if (src1)
-		writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+		writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK);
=20
 	if (is_ipi_available())
 		ipi_resume();
@@ -847,7 +838,7 @@ static int __init armada_370_xp_mpic_of_init(struct devic=
e_node *node,
 	nr_irqs =3D (control >> 2) & 0x3ff;
=20
 	for (i =3D 0; i < nr_irqs; i++)
-		writel(i, main_int_base + ARMADA_370_XP_INT_CLEAR_ENABLE_OFFS);
+		writel(i, main_int_base + ARMADA_370_XP_INT_CLEAR_ENABLE);
=20
 	armada_370_xp_mpic_domain =3D
 		irq_domain_add_linear(node, nr_irqs,

