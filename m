Return-Path: <linux-tip-commits+bounces-1849-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA0D9410E9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B3B286578
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCBA1A2572;
	Tue, 30 Jul 2024 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4BVEZZ8M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gtzn9Tz4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DE41A01A9;
	Tue, 30 Jul 2024 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339611; cv=none; b=eQ8vJfig/PLYpUJZ61TsXDmriwrAPWGsZ+xbIjsmIx4EB25nRkoYVkX9DERzVOuyLQPIp0D+eiBkukAiim6DtQ27PP3UxrQquuKxyftaHINYNfLOb5aWhkHKZLys5laOsxVAI2FOc6R30rWZ/9OnRK6RNvfX6mcoudTz9EjjGJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339611; c=relaxed/simple;
	bh=WVSLVkS08z3yoOWmnxUNsqlrNGIZht46gq2yGTdXqYg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CCWPWHQubL3/0ExOLI4SzeTiYIyeYxKMulKOEYgLycVWiv5HAPFAkfzhm8VQNZMpFIoAHytSmicjAPbgpub84J1HDOeioANOog0OowN9rlBI31I7sXRrwnJ24ECAwR0nXq+I6eA8Jfl4dw22pchfOYz8q/cGh18vag47g/vUsJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4BVEZZ8M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gtzn9Tz4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:40:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339602;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ba4wa4ozctylJgeYbfNfiLq7DerZiHstCkEtRncYFSM=;
	b=4BVEZZ8Ms2eEd5UoOibXw63wfMmJHGxd+0tY1hgjbXyD9YUuq9WrniwN6i+KsYgugXpfPx
	3pn3uR3UIbM7Uv4nKvI+bf/5NexRxfMSBkMG/aGLhNiKXi3MJ5D+mNABVKSa+o4/vxMjXM
	9G5evk/vAagAsVs+2sKgVzY1+XxpNKZk6LVHbQAynGZ8ZuAMSKB7JUO3q0JvNTcuPvvHec
	N64oBPs7uuhkwKOauteOL6hUszpZD9t8seivriTMJ0Tz2a9XZQkA3QJx+jbDFlJlobfTkp
	yxuc6TWlIBqe7rUKKyHoPNLDLeTz9fnyW+Yo/DgauvlrcrotnchuHhIhqaJ1iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339602;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ba4wa4ozctylJgeYbfNfiLq7DerZiHstCkEtRncYFSM=;
	b=gtzn9Tz4xrSgBP0H1/timOd5lo4f9HCrnZomZ9/6K66fsVlks+dIkgljCdAWjx32GyOuXE
	6ZyFj44y3TaJS7Bw==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Declare iterators in for loop
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20240708151801.11592-11-kabel@kernel.org>
References: <20240708151801.11592-11-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172233960240.2215.2650099025109026332.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     644799f920c906666b5393c33dcf3008ace1ef6b
Gitweb:        https://git.kernel.org/tip/644799f920c906666b5393c33dcf3008ace=
1ef6b
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Mon, 08 Jul 2024 17:18:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:46 +02:00

irqchip/armada-370-xp: Declare iterators in for loop

Where possible, declare iterators in for cycle. This is possible since
kernel uses -std=3Dgnu11.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/all/20240708151801.11592-11-kabel@kernel.org


---
 drivers/irqchip/irq-armada-370-xp.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 3d15d0b..22e1a49 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -276,7 +276,7 @@ static struct irq_chip armada_370_xp_msi_bottom_irq_chip =
=3D {
 static int armada_370_xp_msi_alloc(struct irq_domain *domain, unsigned int v=
irq,
 				   unsigned int nr_irqs, void *args)
 {
-	int hwirq, i;
+	int hwirq;
=20
 	mutex_lock(&msi_used_lock);
 	hwirq =3D bitmap_find_free_region(msi_used, msi_doorbell_size(),
@@ -286,7 +286,7 @@ static int armada_370_xp_msi_alloc(struct irq_domain *dom=
ain, unsigned int virq,
 	if (hwirq < 0)
 		return -ENOSPC;
=20
-	for (i =3D 0; i < nr_irqs; i++) {
+	for (int i =3D 0; i < nr_irqs; i++) {
 		irq_domain_set_info(domain, virq + i, hwirq + i,
 				    &armada_370_xp_msi_bottom_irq_chip,
 				    domain->host_data, handle_simple_irq,
@@ -436,9 +436,7 @@ static int armada_370_xp_ipi_alloc(struct irq_domain *d,
 					 unsigned int virq,
 					 unsigned int nr_irqs, void *args)
 {
-	int i;
-
-	for (i =3D 0; i < nr_irqs; i++) {
+	for (int i =3D 0; i < nr_irqs; i++) {
 		irq_set_percpu_devid(virq + i);
 		irq_domain_set_info(d, virq + i, i, &ipi_irqchip,
 				    d->host_data,
@@ -463,9 +461,7 @@ static const struct irq_domain_ops ipi_domain_ops =3D {
=20
 static void ipi_resume(void)
 {
-	int i;
-
-	for (i =3D 0; i < IPI_DOORBELL_END; i++) {
+	for (int i =3D 0; i < IPI_DOORBELL_END; i++) {
 		int irq;
=20
 		irq =3D irq_find_mapping(ipi_domain, i);
@@ -517,12 +513,12 @@ static int armada_xp_set_affinity(struct irq_data *d,
 static void armada_xp_mpic_smp_cpu_init(void)
 {
 	u32 control;
-	int nr_irqs, i;
+	int nr_irqs;
=20
 	control =3D readl(main_int_base + MPIC_INT_CONTROL);
 	nr_irqs =3D (control >> 2) & 0x3ff;
=20
-	for (i =3D 0; i < nr_irqs; i++)
+	for (int i =3D 0; i < nr_irqs; i++)
 		writel(i, per_cpu_int_base + MPIC_INT_SET_MASK);
=20
 	if (!is_ipi_available())
@@ -540,10 +536,8 @@ static void armada_xp_mpic_smp_cpu_init(void)
=20
 static void armada_xp_mpic_reenable_percpu(void)
 {
-	unsigned int irq;
-
 	/* Re-enable per-CPU interrupts that were enabled before suspend */
-	for (irq =3D 0; irq < MPIC_MAX_PER_CPU_IRQS; irq++) {
+	for (unsigned int irq =3D 0; irq < MPIC_MAX_PER_CPU_IRQS; irq++) {
 		struct irq_data *data;
 		int virq;
=20
@@ -735,11 +729,10 @@ static void armada_370_xp_mpic_resume(void)
 {
 	bool src0, src1;
 	int nirqs;
-	irq_hw_number_t irq;
=20
 	/* Re-enable interrupts */
 	nirqs =3D (readl(main_int_base + MPIC_INT_CONTROL) >> 2) & 0x3ff;
-	for (irq =3D 0; irq < nirqs; irq++) {
+	for (irq_hw_number_t irq =3D 0; irq < nirqs; irq++) {
 		struct irq_data *data;
 		int virq;
=20
@@ -797,7 +790,7 @@ static int __init armada_370_xp_mpic_of_init(struct devic=
e_node *node,
 					     struct device_node *parent)
 {
 	struct resource main_int_res, per_cpu_int_res;
-	int nr_irqs, i;
+	int nr_irqs;
 	u32 control;
=20
 	BUG_ON(of_address_to_resource(node, 0, &main_int_res));
@@ -821,7 +814,7 @@ static int __init armada_370_xp_mpic_of_init(struct devic=
e_node *node,
 	control =3D readl(main_int_base + MPIC_INT_CONTROL);
 	nr_irqs =3D (control >> 2) & 0x3ff;
=20
-	for (i =3D 0; i < nr_irqs; i++)
+	for (int i =3D 0; i < nr_irqs; i++)
 		writel(i, main_int_base + MPIC_INT_CLEAR_ENABLE);
=20
 	armada_370_xp_mpic_domain =3D

