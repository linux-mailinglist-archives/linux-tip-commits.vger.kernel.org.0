Return-Path: <linux-tip-commits+bounces-1847-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3D49410E6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4173285BD7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA241A254E;
	Tue, 30 Jul 2024 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1dVBp+C1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8bxAL7GB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9681A01D7;
	Tue, 30 Jul 2024 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339610; cv=none; b=Sqz9opqlbxUP7azvK0369hcsJoj5DgR8jC2uXmhUT6uBO6JuoQG0le4PLfkEHsXb0UOU4A7lgywazbXTq/aPvPi3/F73mLQqD4+OWIjPGMHE6S+/55KMGbarFbfZchghIyqxhLeytTqJM+PUcpc1qMISKAQd94Fx9DNO2jBcDcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339610; c=relaxed/simple;
	bh=UBZg80qnmeiWCJsrVmOBhqo8v/mxctUMar/aCM0oXg8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Io/yLY080XNzWtxETqRjj4jJtSH8OegpgQdSjWey1A+HPtuxoSxM4HkVwYsCGF9mMe7pqS812oFAGTsiDs1mtT24qogvlQGt5nvZeGkBo2QLqD6orV/fMtqCIdWvPFjUlrFXlpJwQP8uvm8cKwSwi9PjIeI8+XPLj2kk75rxHao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1dVBp+C1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8bxAL7GB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:40:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339603;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGJN5IcVw978KIGSPxG3q4MN1ZZUiXPuCTHEx56Vw20=;
	b=1dVBp+C15ZaKFNqSEXHV1hc4cjJpZ+MtoyMDdMdnX2yyU1THdD/N4zEL9F062x37cxkgI5
	r4dxIhA+ZMmi8AuP4s9Jja/jhz6eRc/KktEcWVOTDidJk/VrPHKV3tjaBfgLjjMAGeca8V
	idUvCanZpnlDdVluMK3Z5NFSap2F4Tl+fBBFk8qdbheL9aSbnY3Age2uI4nKtCx+v44kUR
	mpNYCvQAPQFKFyugFRZ3RrNSDOwj6RWloCI9fN37ZkyYrew/DQf0uHJMbbbxCHwbbksMKE
	C70FkMyH5VmrcFmhbBlZqsLTYfjIl2rfn+J/zfW2unpbkbZ7X9cyyTi/rCSkoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339603;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PGJN5IcVw978KIGSPxG3q4MN1ZZUiXPuCTHEx56Vw20=;
	b=8bxAL7GBun0PjOBKNry611PyRpLVMJq+erS0xaCu2zruWOgxw4OZjveBbdiV8gK1ddCU3f
	Z2Pp21iwh6KdI5CA==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Change register constants
 prefix to MPIC_
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20240708151801.11592-7-kabel@kernel.org>
References: <20240708151801.11592-7-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172233960343.2215.5190324062412698186.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e812dd60b6cca3211e7d83528c8bf077a51730b4
Gitweb:        https://git.kernel.org/tip/e812dd60b6cca3211e7d83528c8bf077a51=
730b4
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Mon, 08 Jul 2024 17:17:57 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:46 +02:00

irqchip/armada-370-xp: Change register constants prefix to MPIC_

Change the long ARMADA_370_XP_ prefix in register constants (ARMADA_375_
in one case) to MPIC_. The rationale is that it is shorter and more
generic (this controller is called MPIC and is also used on Armada 38x
and 39x).

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/all/20240708151801.11592-7-kabel@kernel.org


---
 drivers/irqchip/irq-armada-370-xp.c | 148 ++++++++++++---------------
 1 file changed, 69 insertions(+), 79 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 14d213e..8f52de6 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -66,18 +66,17 @@
  *                   device
  *
  * The "global interrupt mask/unmask" is modified using the
- * ARMADA_370_XP_INT_SET_ENABLE and ARMADA_370_XP_INT_CLEAR_ENABLE
+ * MPIC_INT_SET_ENABLE and MPIC_INT_CLEAR_ENABLE
  * registers, which are relative to "main_int_base".
  *
- * The "per-CPU mask/unmask" is modified using the
- * ARMADA_370_XP_INT_SET_MASK and ARMADA_370_XP_INT_CLEAR_MASK
- * registers, which are relative to "per_cpu_int_base". This base
- * address points to a special address, which automatically accesses
- * the registers of the current CPU.
+ * The "per-CPU mask/unmask" is modified using the MPIC_INT_SET_MASK
+ * and MPIC_INT_CLEAR_MASK registers, which are relative to
+ * "per_cpu_int_base". This base address points to a special address,
+ * which automatically accesses the registers of the current CPU.
  *
  * The per-CPU mask/unmask can also be adjusted using the global
- * per-interrupt ARMADA_370_XP_INT_SOURCE_CTL register, which we use
- * to configure interrupt affinity.
+ * per-interrupt MPIC_INT_SOURCE_CTL register, which we use to
+ * configure interrupt affinity.
  *
  * Due to this model, all interrupts need to be mask/unmasked at two
  * different levels: at the global level and at the per-CPU level.
@@ -91,9 +90,8 @@
  *    the current CPU, running the ->map() code. This allows to have
  *    the interrupt unmasked at this level in non-SMP
  *    configurations. In SMP configurations, the ->set_affinity()
- *    callback is called, which using the
- *    ARMADA_370_XP_INT_SOURCE_CTL() readjusts the per-CPU mask/unmask
- *    for the interrupt.
+ *    callback is called, which using the MPIC_INT_SOURCE_CTL()
+ *    readjusts the per-CPU mask/unmask for the interrupt.
  *
  *    The ->mask() and ->unmask() operations only mask/unmask the
  *    interrupt at the "global" level.
@@ -116,25 +114,25 @@
  */
=20
 /* Registers relative to main_int_base */
-#define ARMADA_370_XP_INT_CONTROL		0x00
-#define ARMADA_370_XP_SW_TRIG_INT		0x04
-#define ARMADA_370_XP_INT_SET_ENABLE		0x30
-#define ARMADA_370_XP_INT_CLEAR_ENABLE		0x34
-#define ARMADA_370_XP_INT_SOURCE_CTL(irq)	(0x100 + (irq) * 4)
-#define ARMADA_370_XP_INT_SOURCE_CPU_MASK	GENMASK(3, 0)
-#define ARMADA_370_XP_INT_IRQ_FIQ_MASK(cpuid)	((BIT(0) | BIT(8)) << (cpuid))
+#define MPIC_INT_CONTROL			0x00
+#define MPIC_SW_TRIG_INT			0x04
+#define MPIC_INT_SET_ENABLE			0x30
+#define MPIC_INT_CLEAR_ENABLE			0x34
+#define MPIC_INT_SOURCE_CTL(irq)		(0x100 + (irq) * 4)
+#define MPIC_INT_SOURCE_CPU_MASK		GENMASK(3, 0)
+#define MPIC_INT_IRQ_FIQ_MASK(cpuid)		((BIT(0) | BIT(8)) << (cpuid))
=20
 /* Registers relative to per_cpu_int_base */
-#define ARMADA_370_XP_IN_DRBEL_CAUSE		0x08
-#define ARMADA_370_XP_IN_DRBEL_MASK		0x0c
-#define ARMADA_375_PPI_CAUSE			0x10
-#define ARMADA_370_XP_CPU_INTACK		0x44
-#define ARMADA_370_XP_INT_SET_MASK		0x48
-#define ARMADA_370_XP_INT_CLEAR_MASK		0x4C
-#define ARMADA_370_XP_INT_FABRIC_MASK		0x54
-#define ARMADA_370_XP_INT_CAUSE_PERF(cpu)	BIT(cpu)
+#define MPIC_IN_DRBEL_CAUSE			0x08
+#define MPIC_IN_DRBEL_MASK			0x0c
+#define MPIC_PPI_CAUSE				0x10
+#define MPIC_CPU_INTACK				0x44
+#define MPIC_INT_SET_MASK			0x48
+#define MPIC_INT_CLEAR_MASK			0x4C
+#define MPIC_INT_FABRIC_MASK			0x54
+#define MPIC_INT_CAUSE_PERF(cpu)		BIT(cpu)
=20
-#define ARMADA_370_XP_MAX_PER_CPU_IRQS		28
+#define MPIC_MAX_PER_CPU_IRQS			28
=20
 /* IPI and MSI interrupt definitions for IPI platforms */
 #define IPI_DOORBELL_START			0
@@ -203,7 +201,7 @@ static inline unsigned int msi_doorbell_end(void)
=20
 static inline bool is_percpu_irq(irq_hw_number_t irq)
 {
-	if (irq <=3D ARMADA_370_XP_MAX_PER_CPU_IRQS)
+	if (irq <=3D MPIC_MAX_PER_CPU_IRQS)
 		return true;
=20
 	return false;
@@ -219,9 +217,9 @@ static void armada_370_xp_irq_mask(struct irq_data *d)
 	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
=20
 	if (!is_percpu_irq(hwirq))
-		writel(hwirq, main_int_base + ARMADA_370_XP_INT_CLEAR_ENABLE);
+		writel(hwirq, main_int_base + MPIC_INT_CLEAR_ENABLE);
 	else
-		writel(hwirq, per_cpu_int_base + ARMADA_370_XP_INT_SET_MASK);
+		writel(hwirq, per_cpu_int_base + MPIC_INT_SET_MASK);
 }
=20
 static void armada_370_xp_irq_unmask(struct irq_data *d)
@@ -229,9 +227,9 @@ static void armada_370_xp_irq_unmask(struct irq_data *d)
 	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
=20
 	if (!is_percpu_irq(hwirq))
-		writel(hwirq, main_int_base + ARMADA_370_XP_INT_SET_ENABLE);
+		writel(hwirq, main_int_base + MPIC_INT_SET_ENABLE);
 	else
-		writel(hwirq, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK);
+		writel(hwirq, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
 }
=20
 #ifdef CONFIG_PCI_MSI
@@ -324,18 +322,18 @@ static void armada_370_xp_msi_reenable_percpu(void)
 	u32 reg;
=20
 	/* Enable MSI doorbell mask and combined cpu local interrupt */
-	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
+	reg =3D readl(per_cpu_int_base + MPIC_IN_DRBEL_MASK);
 	reg |=3D msi_doorbell_mask();
-	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
+	writel(reg, per_cpu_int_base + MPIC_IN_DRBEL_MASK);
=20
 	/* Unmask local doorbell interrupt */
-	writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK);
+	writel(1, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
 }
=20
 static int armada_370_xp_msi_init(struct device_node *node,
 				  phys_addr_t main_int_phys_base)
 {
-	msi_doorbell_addr =3D main_int_phys_base + ARMADA_370_XP_SW_TRIG_INT;
+	msi_doorbell_addr =3D main_int_phys_base + MPIC_SW_TRIG_INT;
=20
 	armada_370_xp_msi_inner_domain =3D
 		irq_domain_add_linear(NULL, msi_doorbell_size(),
@@ -356,7 +354,7 @@ static int armada_370_xp_msi_init(struct device_node *nod=
e,
=20
 	/* Unmask low 16 MSI irqs on non-IPI platforms */
 	if (!is_ipi_available())
-		writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK);
+		writel(0, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
=20
 	return 0;
 }
@@ -384,8 +382,8 @@ static void armada_xp_mpic_perf_init(void)
 	cpuid =3D cpu_logical_map(smp_processor_id());
=20
 	/* Enable Performance Counter Overflow interrupts */
-	writel(ARMADA_370_XP_INT_CAUSE_PERF(cpuid),
-	       per_cpu_int_base + ARMADA_370_XP_INT_FABRIC_MASK);
+	writel(MPIC_INT_CAUSE_PERF(cpuid),
+	       per_cpu_int_base + MPIC_INT_FABRIC_MASK);
 }
=20
 #ifdef CONFIG_SMP
@@ -394,17 +392,17 @@ static struct irq_domain *ipi_domain;
 static void armada_370_xp_ipi_mask(struct irq_data *d)
 {
 	u32 reg;
-	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
+	reg =3D readl(per_cpu_int_base + MPIC_IN_DRBEL_MASK);
 	reg &=3D ~BIT(d->hwirq);
-	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
+	writel(reg, per_cpu_int_base + MPIC_IN_DRBEL_MASK);
 }
=20
 static void armada_370_xp_ipi_unmask(struct irq_data *d)
 {
 	u32 reg;
-	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
+	reg =3D readl(per_cpu_int_base + MPIC_IN_DRBEL_MASK);
 	reg |=3D BIT(d->hwirq);
-	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
+	writel(reg, per_cpu_int_base + MPIC_IN_DRBEL_MASK);
 }
=20
 static void armada_370_xp_ipi_send_mask(struct irq_data *d,
@@ -424,13 +422,12 @@ static void armada_370_xp_ipi_send_mask(struct irq_data=
 *d,
 	dsb();
=20
 	/* submit softirq */
-	writel((map << 8) | d->hwirq, main_int_base +
-		ARMADA_370_XP_SW_TRIG_INT);
+	writel((map << 8) | d->hwirq, main_int_base + MPIC_SW_TRIG_INT);
 }
=20
 static void armada_370_xp_ipi_ack(struct irq_data *d)
 {
-	writel(~BIT(d->hwirq), per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE);
+	writel(~BIT(d->hwirq), per_cpu_int_base + MPIC_IN_DRBEL_CAUSE);
 }
=20
 static struct irq_chip ipi_irqchip =3D {
@@ -515,9 +512,8 @@ static int armada_xp_set_affinity(struct irq_data *d,
 	/* Select a single core from the affinity mask which is online */
 	cpu =3D cpumask_any_and(mask_val, cpu_online_mask);
=20
-	atomic_io_modify(main_int_base + ARMADA_370_XP_INT_SOURCE_CTL(hwirq),
-			 ARMADA_370_XP_INT_SOURCE_CPU_MASK,
-			 BIT(cpu_logical_map(cpu)));
+	atomic_io_modify(main_int_base + MPIC_INT_SOURCE_CTL(hwirq),
+			 MPIC_INT_SOURCE_CPU_MASK, BIT(cpu_logical_map(cpu)));
=20
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
=20
@@ -529,23 +525,23 @@ static void armada_xp_mpic_smp_cpu_init(void)
 	u32 control;
 	int nr_irqs, i;
=20
-	control =3D readl(main_int_base + ARMADA_370_XP_INT_CONTROL);
+	control =3D readl(main_int_base + MPIC_INT_CONTROL);
 	nr_irqs =3D (control >> 2) & 0x3ff;
=20
 	for (i =3D 0; i < nr_irqs; i++)
-		writel(i, per_cpu_int_base + ARMADA_370_XP_INT_SET_MASK);
+		writel(i, per_cpu_int_base + MPIC_INT_SET_MASK);
=20
 	if (!is_ipi_available())
 		return;
=20
 	/* Disable all IPIs */
-	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
+	writel(0, per_cpu_int_base + MPIC_IN_DRBEL_MASK);
=20
 	/* Clear pending IPIs */
-	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE);
+	writel(0, per_cpu_int_base + MPIC_IN_DRBEL_CAUSE);
=20
 	/* Unmask IPI interrupt */
-	writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK);
+	writel(0, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
 }
=20
 static void armada_xp_mpic_reenable_percpu(void)
@@ -553,7 +549,7 @@ static void armada_xp_mpic_reenable_percpu(void)
 	unsigned int irq;
=20
 	/* Re-enable per-CPU interrupts that were enabled before suspend */
-	for (irq =3D 0; irq < ARMADA_370_XP_MAX_PER_CPU_IRQS; irq++) {
+	for (irq =3D 0; irq < MPIC_MAX_PER_CPU_IRQS; irq++) {
 		struct irq_data *data;
 		int virq;
=20
@@ -615,10 +611,9 @@ static int armada_370_xp_mpic_irq_map(struct irq_domain =
*h,
=20
 	armada_370_xp_irq_mask(irq_get_irq_data(virq));
 	if (!is_percpu_irq(hw))
-		writel(hw, per_cpu_int_base +
-			ARMADA_370_XP_INT_CLEAR_MASK);
+		writel(hw, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
 	else
-		writel(hw, main_int_base + ARMADA_370_XP_INT_SET_ENABLE);
+		writel(hw, main_int_base + MPIC_INT_SET_ENABLE);
 	irq_set_status_flags(virq, IRQ_LEVEL);
=20
 	if (is_percpu_irq(hw)) {
@@ -645,10 +640,10 @@ static void armada_370_xp_handle_msi_irq(struct pt_regs=
 *regs, bool is_chained)
 {
 	u32 msimask, msinr;
=20
-	msimask =3D readl_relaxed(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE);
+	msimask =3D readl_relaxed(per_cpu_int_base + MPIC_IN_DRBEL_CAUSE);
 	msimask &=3D msi_doorbell_mask();
=20
-	writel(~msimask, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE);
+	writel(~msimask, per_cpu_int_base + MPIC_IN_DRBEL_CAUSE);
=20
 	for (msinr =3D msi_doorbell_start();
 	     msinr < msi_doorbell_end(); msinr++) {
@@ -673,17 +668,16 @@ static void armada_370_xp_mpic_handle_cascade_irq(struc=
t irq_desc *desc)
=20
 	chained_irq_enter(chip, desc);
=20
-	irqmap =3D readl_relaxed(per_cpu_int_base + ARMADA_375_PPI_CAUSE);
+	irqmap =3D readl_relaxed(per_cpu_int_base + MPIC_PPI_CAUSE);
 	cpuid =3D cpu_logical_map(smp_processor_id());
=20
 	for_each_set_bit(irqn, &irqmap, BITS_PER_LONG) {
-		irqsrc =3D readl_relaxed(main_int_base +
-				       ARMADA_370_XP_INT_SOURCE_CTL(irqn));
+		irqsrc =3D readl_relaxed(main_int_base + MPIC_INT_SOURCE_CTL(irqn));
=20
 		/* Check if the interrupt is not masked on current CPU.
 		 * Test IRQ (0-1) and FIQ (8-9) mask bits.
 		 */
-		if (!(irqsrc & ARMADA_370_XP_INT_IRQ_FIQ_MASK(cpuid)))
+		if (!(irqsrc & MPIC_INT_IRQ_FIQ_MASK(cpuid)))
 			continue;
=20
 		if (irqn =3D=3D 0 || irqn =3D=3D 1) {
@@ -703,8 +697,7 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
 	u32 irqstat, irqnr;
=20
 	do {
-		irqstat =3D readl_relaxed(per_cpu_int_base +
-					ARMADA_370_XP_CPU_INTACK);
+		irqstat =3D readl_relaxed(per_cpu_int_base + MPIC_CPU_INTACK);
 		irqnr =3D irqstat & 0x3FF;
=20
 		if (irqnr > 1022)
@@ -727,7 +720,7 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
 			int ipi;
=20
 			ipimask =3D readl_relaxed(per_cpu_int_base +
-						ARMADA_370_XP_IN_DRBEL_CAUSE)
+						MPIC_IN_DRBEL_CAUSE)
 				& IPI_DOORBELL_MASK;
=20
 			for_each_set_bit(ipi, &ipimask, IPI_DOORBELL_END)
@@ -740,7 +733,7 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
=20
 static int armada_370_xp_mpic_suspend(void)
 {
-	doorbell_mask_reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
+	doorbell_mask_reg =3D readl(per_cpu_int_base + MPIC_IN_DRBEL_MASK);
 	return 0;
 }
=20
@@ -751,7 +744,7 @@ static void armada_370_xp_mpic_resume(void)
 	irq_hw_number_t irq;
=20
 	/* Re-enable interrupts */
-	nirqs =3D (readl(main_int_base + ARMADA_370_XP_INT_CONTROL) >> 2) & 0x3ff;
+	nirqs =3D (readl(main_int_base + MPIC_INT_CONTROL) >> 2) & 0x3ff;
 	for (irq =3D 0; irq < nirqs; irq++) {
 		struct irq_data *data;
 		int virq;
@@ -764,14 +757,12 @@ static void armada_370_xp_mpic_resume(void)
=20
 		if (!is_percpu_irq(irq)) {
 			/* Non per-CPU interrupts */
-			writel(irq, per_cpu_int_base +
-			       ARMADA_370_XP_INT_CLEAR_MASK);
+			writel(irq, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
 			if (!irqd_irq_disabled(data))
 				armada_370_xp_irq_unmask(data);
 		} else {
 			/* Per-CPU interrupts */
-			writel(irq, main_int_base +
-			       ARMADA_370_XP_INT_SET_ENABLE);
+			writel(irq, main_int_base + MPIC_INT_SET_ENABLE);
=20
 			/*
 			 * Re-enable on the current CPU,
@@ -784,8 +775,7 @@ static void armada_370_xp_mpic_resume(void)
 	}
=20
 	/* Reconfigure doorbells for IPIs and MSIs */
-	writel(doorbell_mask_reg,
-	       per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
+	writel(doorbell_mask_reg, per_cpu_int_base + MPIC_IN_DRBEL_MASK);
=20
 	if (is_ipi_available()) {
 		src0 =3D doorbell_mask_reg & IPI_DOORBELL_MASK;
@@ -796,9 +786,9 @@ static void armada_370_xp_mpic_resume(void)
 	}
=20
 	if (src0)
-		writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK);
+		writel(0, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
 	if (src1)
-		writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK);
+		writel(1, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
=20
 	if (is_ipi_available())
 		ipi_resume();
@@ -834,11 +824,11 @@ static int __init armada_370_xp_mpic_of_init(struct dev=
ice_node *node,
 				   resource_size(&per_cpu_int_res));
 	BUG_ON(!per_cpu_int_base);
=20
-	control =3D readl(main_int_base + ARMADA_370_XP_INT_CONTROL);
+	control =3D readl(main_int_base + MPIC_INT_CONTROL);
 	nr_irqs =3D (control >> 2) & 0x3ff;
=20
 	for (i =3D 0; i < nr_irqs; i++)
-		writel(i, main_int_base + ARMADA_370_XP_INT_CLEAR_ENABLE);
+		writel(i, main_int_base + MPIC_INT_CLEAR_ENABLE);
=20
 	armada_370_xp_mpic_domain =3D
 		irq_domain_add_linear(node, nr_irqs,

