Return-Path: <linux-tip-commits+bounces-1762-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6C893F1A0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34671F23B25
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D02A144D0E;
	Mon, 29 Jul 2024 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NjbHhX7v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="luubdbZQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D36A14386B;
	Mon, 29 Jul 2024 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246588; cv=none; b=kAmFPMNf/FvpYHPPxT6CEnxAwfJ5MXvKhxjMZTn7rp6T+2bPvrZg5VkH+iMzPbktvzww3P/6ImRfPjedZuKE+JTTxelA1n+D/2WIePs+Y9epZKEk1TADiGVkUeIdPNckToHqk733gtrK7G5AExhTvo6olVL+Gb5XGGkItfm0wSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246588; c=relaxed/simple;
	bh=p3bCuVKBZAHVzOrGw8pSEdNMP2YVwYegCziq8Cr8WT0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Sz9SLcMPzu80msukXHYCxGNZZCQ0mRr75kHyTctqiwJYx3nbhPSvGGvrF0EpY/uKzhojhG7zbYLj3WiA7F1qus3ArcdEsqrcUeXgRXwlIlkXN0Jnn/NbrMSRkU2FIVj6WUXAhimQF2qvsKQ0ORiekC8QTV0e6SuahbFVlhyykHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NjbHhX7v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=luubdbZQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 09:49:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722246583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EDH84EFxydkfS2bXH/IRGSNqIy7a3xCR8AmeKV4EssQ=;
	b=NjbHhX7vGodbvwkM9JV+FcOx3BddzK76QIEFdkBvtnvk6pIBHoRDtMll/1P7T3tHj0LnYu
	Bm9FK0BaEtJnEdvRVp9FPv6Cpo4DnsVIy2b2gYHc9bTFcqaSChSMZkeV9LcD3KMZG/ufdT
	Z4HmyXf/HfCrVNwf095d4wkv4ObkkclTy1fTh3PnEv7PWKSGIQbjviAbXr5ChNDPqjNKvq
	O6ZjIr4PfvbpxApo+5KalKWujZKN7B2I5BcgyazICCZGJmVFEllzEy9xMs2OglZYq4ratY
	frz2c+3O47qNBphXvGTCTP05Uc++derqQy38VX+TTYYrIYj5HElSmGp+l6AVyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EDH84EFxydkfS2bXH/IRGSNqIy7a3xCR8AmeKV4EssQ=;
	b=luubdbZQwAk5y/GCEjrhNlxkZ0s/ABPvtmchziRWnqQO/3FE5CkGp4A5PFpjVptHY5WSFN
	T8rD+YHFYJed2LBw==
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
Message-ID: <172224658275.2215.7726763187451128885.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     da3b3ce541259951ff4e087c20ff991f9056fa64
Gitweb:        https://git.kernel.org/tip/da3b3ce541259951ff4e087c20ff991f905=
6fa64
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 18:08:58 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:57:24 +02:00

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

