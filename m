Return-Path: <linux-tip-commits+bounces-1833-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BC19410CF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1180E1F247B1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2461A01C0;
	Tue, 30 Jul 2024 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AdJoDldp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UbpySzBx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFD019EEBB;
	Tue, 30 Jul 2024 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339606; cv=none; b=cmBjZYEL4RNG9inyx+qkY93qTik9UDSwBvGzP992aNqFV7kjpI08RI4SGELDLpM2Q4TjJqHa+eJz0IR1+XUOpRLLXupPkGVK9ugbNgZCyMrmu6BJXYmdJZvpRP8Wlqs8EO1q64dO2JDaTJdPwbqUIABdufnXnsalxC7PeShXsc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339606; c=relaxed/simple;
	bh=Jm1MbV9GqjFYYbQiLdbIWnHPhVXElrabiJ83TB0GrBE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q3KQzFOPTB1cDtsbptGiTWOvFPr/izsfVfFYB/7k5NFg/OweGSXffi5TznG9+xmtCuagLkTy5fRHSKYQBnbjnRQVXNtxRKR7tl25CZl9Axop949jhUK63uvqsyn1qIwa8rdPCoSVgDXcfcYZXQKC8efj/3n1tTJJlQ5k3p0vQ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AdJoDldp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UbpySzBx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:39:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RYGg78cf5Z1qhLhKpn8nx2GQb1cxyzJmK4oivOmezws=;
	b=AdJoDldpZJQiky7e8if1DYNCoFVLKzhmf33aLp8jKDWITFpMWGuEGZgUkzQzVeDO8KPViP
	TgoZX358Wc25LsjyNfwP3HNC5YsWnzpHtxbalm2Hploqzq3di02RY39g00TBCCYWC9bv+Z
	D6CV+Db4iCAwziNwzu3m+X+0wenOOqFws8PdtTbYJ+/8FFQhDzkNoTlfoO9SU0BsDOnK+z
	x6LgUyzFvCgW9oqS2lafXgo120Pw3CHfH/rhVbHUPR+GtstpiqAqoeI0miIf/F7ka57BrG
	8L0/2Tl0YG0734ttajlH4jeIxLO7MferE1atlhAWYvyQJ50H+WILiq49v0Vr4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RYGg78cf5Z1qhLhKpn8nx2GQb1cxyzJmK4oivOmezws=;
	b=UbpySzBxIbOeTuDKkz3tLCU6IFSsJcLLx6EKbU2VVDsHT8pOgeKTovtt8xUh6r0L1I3nt1
	psQdgI7vEap9pqBQ==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Use consistent variable names
 for hwirqs
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711160907.31012-2-kabel@kernel.org>
References: <20240711160907.31012-2-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172233959956.2215.7158076689105636590.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     66fc31034f96cbdef7687b1c55d600367e70287e
Gitweb:        https://git.kernel.org/tip/66fc31034f96cbdef7687b1c55d600367e7=
0287e
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 18:08:58 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:48 +02:00

irqchip/armada-370-xp: Use consistent variable names for hwirqs

Use consistent variable names for hwirqs: when iterating, use "i",
otherwise use "hwirq".

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240711160907.31012-2-kabel@kernel.org


---
 drivers/irqchip/irq-armada-370-xp.c | 56 ++++++++++++++--------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index d42c7a1..8f95da0 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -117,7 +117,7 @@
 #define MPIC_SW_TRIG_INT			0x04
 #define MPIC_INT_SET_ENABLE			0x30
 #define MPIC_INT_CLEAR_ENABLE			0x34
-#define MPIC_INT_SOURCE_CTL(irq)		(0x100 + (irq) * 4)
+#define MPIC_INT_SOURCE_CTL(hwirq)		(0x100 + (hwirq) * 4)
 #define MPIC_INT_SOURCE_CPU_MASK		GENMASK(3, 0)
 #define MPIC_INT_IRQ_FIQ_MASK(cpuid)		((BIT(0) | BIT(8)) << (cpuid))
=20
@@ -195,9 +195,9 @@ static inline unsigned int msi_doorbell_end(void)
 	return mpic_is_ipi_available() ? PCI_MSI_DOORBELL_END : PCI_MSI_FULL_DOORBE=
LL_END;
 }
=20
-static inline bool mpic_is_percpu_irq(irq_hw_number_t irq)
+static inline bool mpic_is_percpu_irq(irq_hw_number_t hwirq)
 {
-	return irq <=3D MPIC_MAX_PER_CPU_IRQS;
+	return hwirq <=3D MPIC_MAX_PER_CPU_IRQS;
 }
=20
 /*
@@ -516,11 +516,11 @@ static void mpic_smp_cpu_init(void)
 static void mpic_reenable_percpu(void)
 {
 	/* Re-enable per-CPU interrupts that were enabled before suspend */
-	for (unsigned int irq =3D 0; irq < MPIC_MAX_PER_CPU_IRQS; irq++) {
+	for (unsigned int i =3D 0; i < MPIC_MAX_PER_CPU_IRQS; i++) {
 		struct irq_data *data;
 		unsigned int virq;
=20
-		virq =3D irq_linear_revmap(mpic_domain, irq);
+		virq =3D irq_linear_revmap(mpic_domain, i);
 		if (!virq)
 			continue;
=20
@@ -572,20 +572,20 @@ static struct irq_chip mpic_irq_chip =3D {
 };
=20
 static int mpic_irq_map(struct irq_domain *h, unsigned int virq,
-			irq_hw_number_t hw)
+			irq_hw_number_t hwirq)
 {
 	/* IRQs 0 and 1 cannot be mapped, they are handled internally */
-	if (hw <=3D 1)
+	if (hwirq <=3D 1)
 		return -EINVAL;
=20
 	mpic_irq_mask(irq_get_irq_data(virq));
-	if (!mpic_is_percpu_irq(hw))
-		writel(hw, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
+	if (!mpic_is_percpu_irq(hwirq))
+		writel(hwirq, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
 	else
-		writel(hw, main_int_base + MPIC_INT_SET_ENABLE);
+		writel(hwirq, main_int_base + MPIC_INT_SET_ENABLE);
 	irq_set_status_flags(virq, IRQ_LEVEL);
=20
-	if (mpic_is_percpu_irq(hw)) {
+	if (mpic_is_percpu_irq(hwirq)) {
 		irq_set_percpu_devid(virq);
 		irq_set_chip_and_handler(virq, &mpic_irq_chip, handle_percpu_devid_irq);
 	} else {
@@ -638,15 +638,15 @@ static inline void mpic_handle_ipi_irq(void) {}
 static void mpic_handle_cascade_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	unsigned long irqmap, irqn, irqsrc, cpuid;
+	unsigned long irqmap, i, irqsrc, cpuid;
=20
 	chained_irq_enter(chip, desc);
=20
 	irqmap =3D readl_relaxed(per_cpu_int_base + MPIC_PPI_CAUSE);
 	cpuid =3D cpu_logical_map(smp_processor_id());
=20
-	for_each_set_bit(irqn, &irqmap, BITS_PER_LONG) {
-		irqsrc =3D readl_relaxed(main_int_base + MPIC_INT_SOURCE_CTL(irqn));
+	for_each_set_bit(i, &irqmap, BITS_PER_LONG) {
+		irqsrc =3D readl_relaxed(main_int_base + MPIC_INT_SOURCE_CTL(i));
=20
 		/* Check if the interrupt is not masked on current CPU.
 		 * Test IRQ (0-1) and FIQ (8-9) mask bits.
@@ -654,12 +654,12 @@ static void mpic_handle_cascade_irq(struct irq_desc *de=
sc)
 		if (!(irqsrc & MPIC_INT_IRQ_FIQ_MASK(cpuid)))
 			continue;
=20
-		if (irqn =3D=3D 0 || irqn =3D=3D 1) {
+		if (i =3D=3D 0 || i =3D=3D 1) {
 			mpic_handle_msi_irq();
 			continue;
 		}
=20
-		generic_handle_domain_irq(mpic_domain, irqn);
+		generic_handle_domain_irq(mpic_domain, i);
 	}
=20
 	chained_irq_exit(chip, desc);
@@ -667,26 +667,26 @@ static void mpic_handle_cascade_irq(struct irq_desc *de=
sc)
=20
 static void __exception_irq_entry mpic_handle_irq(struct pt_regs *regs)
 {
-	u32 irqstat, irqnr;
+	u32 irqstat, i;
=20
 	do {
 		irqstat =3D readl_relaxed(per_cpu_int_base + MPIC_CPU_INTACK);
-		irqnr =3D FIELD_GET(MPIC_CPU_INTACK_IID_MASK, irqstat);
+		i =3D FIELD_GET(MPIC_CPU_INTACK_IID_MASK, irqstat);
=20
-		if (irqnr > 1022)
+		if (i > 1022)
 			break;
=20
-		if (irqnr > 1) {
-			generic_handle_domain_irq(mpic_domain, irqnr);
+		if (i > 1) {
+			generic_handle_domain_irq(mpic_domain, i);
 			continue;
 		}
=20
 		/* MSI handling */
-		if (irqnr =3D=3D 1)
+		if (i =3D=3D 1)
 			mpic_handle_msi_irq();
=20
 		/* IPI Handling */
-		if (irqnr =3D=3D 0)
+		if (i =3D=3D 0)
 			mpic_handle_ipi_irq();
 	} while (1);
 }
@@ -703,24 +703,24 @@ static void mpic_resume(void)
 	bool src0, src1;
=20
 	/* Re-enable interrupts */
-	for (irq_hw_number_t irq =3D 0; irq < mpic_domain->hwirq_max; irq++) {
+	for (irq_hw_number_t i =3D 0; i < mpic_domain->hwirq_max; i++) {
 		struct irq_data *data;
 		unsigned int virq;
=20
-		virq =3D irq_linear_revmap(mpic_domain, irq);
+		virq =3D irq_linear_revmap(mpic_domain, i);
 		if (!virq)
 			continue;
=20
 		data =3D irq_get_irq_data(virq);
=20
-		if (!mpic_is_percpu_irq(irq)) {
+		if (!mpic_is_percpu_irq(i)) {
 			/* Non per-CPU interrupts */
-			writel(irq, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
+			writel(i, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
 			if (!irqd_irq_disabled(data))
 				mpic_irq_unmask(data);
 		} else {
 			/* Per-CPU interrupts */
-			writel(irq, main_int_base + MPIC_INT_SET_ENABLE);
+			writel(i, main_int_base + MPIC_INT_SET_ENABLE);
=20
 			/*
 			 * Re-enable on the current CPU, mpic_reenable_percpu()

