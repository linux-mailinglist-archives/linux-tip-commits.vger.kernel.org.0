Return-Path: <linux-tip-commits+bounces-1828-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5779410CA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66CE0285CED
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433AE19FA96;
	Tue, 30 Jul 2024 11:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gD4yxOML";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KwZCW6pQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12FE19EEAA;
	Tue, 30 Jul 2024 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339605; cv=none; b=TB2IdE2ybHPDr3graE/vrDSat2nZlI+XzL0NH1dEW0HHtJscgn5k5oHhOiCnnOzu3k7KDE+nQr5BpQPhzcrNG2UDDQYA2xOVWgSUx+gC6Sq5gXEjs2Dvq8Gt6Jq1OhXKddSwdDUZnScEaFsOXky1q4tIgRNw6/qf3+z764k5Ej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339605; c=relaxed/simple;
	bh=ZQbZTksjf8BT9dAV7gg0d8RnVTtI8x5OUW1HR7uIPOY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oWAcjY9htSiEAxIn0Xx1doLs8n6i6fR9YnTd7l/s+lJIfLMBmjIbVtN1EIvxNaPLW/qzy5K1+0+q/3RizPDr0zbqCw0eVtViCu64OBbZMDCU0RXVPbvLmthRSJmsRsKoBoqAElXGXaQwAQSvHiUJkg0c6OAFkJXGuxLGjGGBKDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gD4yxOML; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KwZCW6pQ; arc=none smtp.client-ip=193.142.43.55
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
	bh=0wPPT0jI2eX+cE1ewsqzhySuR0wk6H5ZwKyYd1MH9yU=;
	b=gD4yxOMLPMSgSbCbbJ/cJCLLdt+tvvjn1ZZnIFKMBBKHe2kpmPcNmAvqa9BT2sDtMJxYwv
	i+tGEJpLNVpVVNC2k4W5Ii8rhvE71+IKsygz0+Fh9p4lpfcxEGd9rArc07qJFVVSUYcsGO
	AbldIXvFPpHn/cYTUifmquMRY+ienqHnUTCSNCIteuxNdz/1FlmyUb61ZEuXg7q6f5EEZA
	ZeSbTtXHS92a9SyHVTCyjxDmWY3oHc3l8YPjAKgkKbXOaRHIWKUFllk+xPQlDwaieyzzXp
	ur8yvfR9ujCsgk+XNkptBwgygnp7EsN9nMdLGCTRncfAT8hKVJg0jGCm5BLt6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339599;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0wPPT0jI2eX+cE1ewsqzhySuR0wk6H5ZwKyYd1MH9yU=;
	b=KwZCW6pQG+E0sJtmfaQDXNbHySDgeLUWIJoOBYNnl0YkvOuHD6lgQqCT7l8LbbmwglE0Aw
	4KXw2OZk5GGWtFDw==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Use consistent types when
 iterating interrupts
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711160907.31012-3-kabel@kernel.org>
References: <20240711160907.31012-3-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172233959929.2215.3490245775954697858.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a5d32b7475fffe2506fa374b1d6b4a74fa13020c
Gitweb:        https://git.kernel.org/tip/a5d32b7475fffe2506fa374b1d6b4a74fa1=
3020c
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 18:08:59 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:48 +02:00

irqchip/armada-370-xp: Use consistent types when iterating interrupts

When iterating, use either the irq_hw_number_t type or the unsigned int
type for the iterator variable, depending on whether the variable
represents HW IRQ number or whether it is added to a IRQ number.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240711160907.31012-3-kabel@kernel.org


---
 drivers/irqchip/irq-armada-370-xp.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 8f95da0..db9594b 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -284,7 +284,7 @@ static int mpic_msi_alloc(struct irq_domain *domain, unsi=
gned int virq, unsigned
 	if (hwirq < 0)
 		return -ENOSPC;
=20
-	for (int i =3D 0; i < nr_irqs; i++) {
+	for (unsigned int i =3D 0; i < nr_irqs; i++) {
 		irq_domain_set_info(domain, virq + i, hwirq + i,
 				    &mpic_msi_bottom_irq_chip,
 				    domain->host_data, handle_simple_irq,
@@ -429,7 +429,7 @@ static struct irq_chip mpic_ipi_irqchip =3D {
 static int mpic_ipi_alloc(struct irq_domain *d, unsigned int virq,
 			  unsigned int nr_irqs, void *args)
 {
-	for (int i =3D 0; i < nr_irqs; i++) {
+	for (unsigned int i =3D 0; i < nr_irqs; i++) {
 		irq_set_percpu_devid(virq + i);
 		irq_domain_set_info(d, virq + i, i, &mpic_ipi_irqchip, d->host_data,
 				    handle_percpu_devid_irq, NULL, NULL);
@@ -451,7 +451,7 @@ static const struct irq_domain_ops mpic_ipi_domain_ops =
=3D {
=20
 static void mpic_ipi_resume(void)
 {
-	for (int i =3D 0; i < IPI_DOORBELL_END; i++) {
+	for (irq_hw_number_t i =3D 0; i < IPI_DOORBELL_END; i++) {
 		unsigned int virq =3D irq_find_mapping(mpic_ipi_domain, i);
 		struct irq_data *d;
=20
@@ -497,7 +497,7 @@ static int mpic_set_affinity(struct irq_data *d, const st=
ruct cpumask *mask_val,
=20
 static void mpic_smp_cpu_init(void)
 {
-	for (int i =3D 0; i < mpic_domain->hwirq_max; i++)
+	for (irq_hw_number_t i =3D 0; i < mpic_domain->hwirq_max; i++)
 		writel(i, per_cpu_int_base + MPIC_INT_SET_MASK);
=20
 	if (!mpic_is_ipi_available())
@@ -516,7 +516,7 @@ static void mpic_smp_cpu_init(void)
 static void mpic_reenable_percpu(void)
 {
 	/* Re-enable per-CPU interrupts that were enabled before suspend */
-	for (unsigned int i =3D 0; i < MPIC_MAX_PER_CPU_IRQS; i++) {
+	for (irq_hw_number_t i =3D 0; i < MPIC_MAX_PER_CPU_IRQS; i++) {
 		struct irq_data *data;
 		unsigned int virq;
=20
@@ -638,7 +638,8 @@ static inline void mpic_handle_ipi_irq(void) {}
 static void mpic_handle_cascade_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
-	unsigned long irqmap, i, irqsrc, cpuid;
+	unsigned long irqmap, irqsrc, cpuid;
+	irq_hw_number_t i;
=20
 	chained_irq_enter(chip, desc);
=20
@@ -667,7 +668,8 @@ static void mpic_handle_cascade_irq(struct irq_desc *desc)
=20
 static void __exception_irq_entry mpic_handle_irq(struct pt_regs *regs)
 {
-	u32 irqstat, i;
+	irq_hw_number_t i;
+	u32 irqstat;
=20
 	do {
 		irqstat =3D readl_relaxed(per_cpu_int_base + MPIC_CPU_INTACK);
@@ -782,7 +784,7 @@ static int __init mpic_of_init(struct device_node *node,
=20
 	nr_irqs =3D FIELD_GET(MPIC_INT_CONTROL_NUMINT_MASK, readl(main_int_base + M=
PIC_INT_CONTROL));
=20
-	for (int i =3D 0; i < nr_irqs; i++)
+	for (irq_hw_number_t i =3D 0; i < nr_irqs; i++)
 		writel(i, main_int_base + MPIC_INT_CLEAR_ENABLE);
=20
 	mpic_domain =3D irq_domain_add_linear(node, nr_irqs, &mpic_irq_ops, NULL);

