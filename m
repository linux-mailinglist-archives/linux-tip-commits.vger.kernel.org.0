Return-Path: <linux-tip-commits+bounces-1772-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F9493F1B5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1251C215B2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB550145FF1;
	Mon, 29 Jul 2024 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LtY5hYzw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vAzXhYY4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0E5145346;
	Mon, 29 Jul 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246591; cv=none; b=jaElGOOQAApseaguy5zo1pYVGV3WirTtfszV4bd3Wuqwhrsz7R6JS/fSQfqy0QJm8drO+BfsJdajB+1q9SNhVZvR/Ogl+cVeKCzxzuIvi9ucuhCSoyFHi1OuhjwVeOwSl06HoesRL+7KnmPlZO3oW4GhJ+w+bdlPjMS/eNagUHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246591; c=relaxed/simple;
	bh=iHyEMp3r2TnjzLm2YB+2rh4MDul0/wdiaRTYeQtNjOI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dOBAAP83/tEt2wMNYJAzMd2dg9w2I9iTv0zHn0CAlrSCswYggKWLwzwhk3sWTDimAn7RzQucDMMsN4UGi8lFZmPlf9w/tFieEyQ8kGZYJBM78FsoN0pk//C6S82AP+d7znFWFl8RmXlZYK3ajWxR7F4q7rpYSTkUSXCBJWK/1eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LtY5hYzw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vAzXhYY4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 09:49:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722246585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GX0aKV+tWSfQ2TyrQfoaXQVsMuazWnnefatVuUE4hsw=;
	b=LtY5hYzwp/smVB1MKZPMJwsYd82/IAN7+aYHTQb4dzHARj2mQFJLoMN+YkZYkOd+gHGkcV
	Dk1IjEmNt3sq6kr0EJhsTGkf8ZX8+N+iwEIUtyTEh/Oie7hPim3icDI4SpbNZH/iXqyx8i
	MCQ2P9+WQoRmvi2PgVSlgBrm36Tj6U+/LyldpmCFfO05v9zUaQCRqLMADFnTAnX7ir9LKX
	3nc9paw2qoZ4DSF2SU9xzUfHWwPcO9KhEPV2kV6sZMcPuqNdC5FZaCFCl8tiCsmuy9vjPm
	MlrsPxTsLdHcIDfC6bItDnFhWssnGuQFGDo69JZUWYqxZZobUJvAj0O2E8iRYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GX0aKV+tWSfQ2TyrQfoaXQVsMuazWnnefatVuUE4hsw=;
	b=vAzXhYY4wqyG5SAp/rilRp8QLolQTOslQP8FuCx6lvvzcYzUofgbQdZNnwQvbamUzegZfd
	wZpu7RyEZSclA/Aw==
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
Message-ID: <172224658557.2215.16439924703162348741.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f43a2ece6d1e0ead4d7cfd876351a3e9ba15818f
Gitweb:        https://git.kernel.org/tip/f43a2ece6d1e0ead4d7cfd876351a3e9ba1=
5818f
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Mon, 08 Jul 2024 17:18:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:57:22 +02:00

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

