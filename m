Return-Path: <linux-tip-commits+bounces-1764-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED8093F1A4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB410281250
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E80145323;
	Mon, 29 Jul 2024 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O84R89Ay";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YdhzAgx7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03F4143C6F;
	Mon, 29 Jul 2024 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246588; cv=none; b=V8Q9Wqf6Igfm8V/KRR62sk25ywofS49Mc8ZbxwE9AfDIlfbuvgeAwwgPbrtiCtAwqceQMg8edq1ECSy315dBUFDOTbWB7Rl3QqbAjgBxTDqV/PB+rvIIQtYNOqM6+xhFIXWY/FY4FVZJXIWgO38q/WXCyFn7JWxiqCnVfssOeuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246588; c=relaxed/simple;
	bh=RK8pjKHTx367YL3HTGsE6u9SoYKcVtAhPZRzbX8ncAs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ekLBi7cBKskZCEr+anmhcA1/euuzf2ZXXZZvEqJFp13NJh1M4PNB5eWXEd2+k7tG+rg70hu2aHBK3Qqi0NiaQ5FFjNv2NonKBCqMnS/cYXG40EakA7fHYqOxEAIxjwhiqXVq2plnQm73//ObcVGUGxVk68V7n2ic5h0bkggIryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O84R89Ay; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YdhzAgx7; arc=none smtp.client-ip=193.142.43.55
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
	bh=JLs0xEPghYCOZTyal/y5DQU8+ExG+yu9YJUGuuQUhpA=;
	b=O84R89AyN+pz40iRh4QHXGWTBvD9UUWuZjU8s8+1NGMsuiqMfkbkRcgb3rs+iCg/493MFM
	DjdjaWbobh24L/jgru/wmrdDVNp8lzYGW92y+Fq1nGVrjjsggKx81EnpLl17cHlunIGwcQ
	VKfVciGu9i8Z3ITAt7jX3bms3VBI7QKYLK+O9FoBQHN0MSGAIQngj65f8Du6VYEEhEzJxl
	Zqh5l+RMQvTBqYmcsvqpV8S/udBQV9iFrPLsR0GrsG4F3snhMZKXrBq+jMmSRlkj3pc5si
	xuXI2abD4Z0tsrUk7MvnxGMh2uEu3nDDZYtEfByNq10uetboCdtuM9NyJ0uG7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JLs0xEPghYCOZTyal/y5DQU8+ExG+yu9YJUGuuQUhpA=;
	b=YdhzAgx7rL9DVpf8FVccKOutUox/WP/Vt0hOpfazmMORjOJhYl4QXqwqqkGVa57FDfCbDH
	lKSpmZbwCRQkxpCA==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Improve indentation
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, ilpo.jarvinen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711115748.30268-6-kabel@kernel.org>
References: <20240711115748.30268-6-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224658430.2215.14380998526042445884.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     be6d3d5889fd39725c1fd6a44905e8bc730cd28d
Gitweb:        https://git.kernel.org/tip/be6d3d5889fd39725c1fd6a44905e8bc730=
cd28d
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 13:57:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:57:23 +02:00

irqchip/armada-370-xp: Improve indentation

Add some blank lines and other indentation improvements.

Checkpatch now stops complaining.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/all/20240711115748.30268-6-kabel@kernel.org

---
 drivers/irqchip/irq-armada-370-xp.c | 56 +++++++++++++---------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 316c27c..a66d345 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -229,9 +229,9 @@ static void armada_370_xp_irq_unmask(struct irq_data *d)
 #ifdef CONFIG_PCI_MSI
=20
 static struct irq_chip armada_370_xp_msi_irq_chip =3D {
-	.name =3D "MPIC MSI",
-	.irq_mask =3D pci_msi_mask_irq,
-	.irq_unmask =3D pci_msi_unmask_irq,
+	.name		=3D "MPIC MSI",
+	.irq_mask	=3D pci_msi_mask_irq,
+	.irq_unmask	=3D pci_msi_unmask_irq,
 };
=20
 static struct msi_domain_info armada_370_xp_msi_domain_info =3D {
@@ -386,6 +386,7 @@ static struct irq_domain *ipi_domain;
 static void armada_370_xp_ipi_mask(struct irq_data *d)
 {
 	u32 reg;
+
 	reg =3D readl(per_cpu_int_base + MPIC_IN_DRBEL_MASK);
 	reg &=3D ~BIT(d->hwirq);
 	writel(reg, per_cpu_int_base + MPIC_IN_DRBEL_MASK);
@@ -394,6 +395,7 @@ static void armada_370_xp_ipi_mask(struct irq_data *d)
 static void armada_370_xp_ipi_unmask(struct irq_data *d)
 {
 	u32 reg;
+
 	reg =3D readl(per_cpu_int_base + MPIC_IN_DRBEL_MASK);
 	reg |=3D BIT(d->hwirq);
 	writel(reg, per_cpu_int_base + MPIC_IN_DRBEL_MASK);
@@ -432,24 +434,20 @@ static struct irq_chip ipi_irqchip =3D {
 	.ipi_send_mask	=3D armada_370_xp_ipi_send_mask,
 };
=20
-static int armada_370_xp_ipi_alloc(struct irq_domain *d,
-					 unsigned int virq,
-					 unsigned int nr_irqs, void *args)
+static int armada_370_xp_ipi_alloc(struct irq_domain *d, unsigned int virq,
+				   unsigned int nr_irqs, void *args)
 {
 	for (int i =3D 0; i < nr_irqs; i++) {
 		irq_set_percpu_devid(virq + i);
-		irq_domain_set_info(d, virq + i, i, &ipi_irqchip,
-				    d->host_data,
-				    handle_percpu_devid_irq,
-				    NULL, NULL);
+		irq_domain_set_info(d, virq + i, i, &ipi_irqchip, d->host_data,
+				    handle_percpu_devid_irq, NULL, NULL);
 	}
=20
 	return 0;
 }
=20
-static void armada_370_xp_ipi_free(struct irq_domain *d,
-					 unsigned int virq,
-					 unsigned int nr_irqs)
+static void armada_370_xp_ipi_free(struct irq_domain *d, unsigned int virq,
+				   unsigned int nr_irqs)
 {
 	/* Not freeing IPIs */
 }
@@ -477,8 +475,7 @@ static __init void armada_xp_ipi_init(struct device_node =
*node)
 {
 	int base_ipi;
=20
-	ipi_domain =3D irq_domain_create_linear(of_node_to_fwnode(node),
-					      IPI_DOORBELL_END,
+	ipi_domain =3D irq_domain_create_linear(of_node_to_fwnode(node), IPI_DOORBE=
LL_END,
 					      &ipi_domain_ops, NULL);
 	if (WARN_ON(!ipi_domain))
 		return;
@@ -562,6 +559,7 @@ static int armada_xp_mpic_starting_cpu(unsigned int cpu)
 	armada_xp_mpic_perf_init();
 	armada_xp_mpic_smp_cpu_init();
 	armada_xp_mpic_reenable_percpu();
+
 	return 0;
 }
=20
@@ -570,6 +568,7 @@ static int mpic_cascaded_starting_cpu(unsigned int cpu)
 	armada_xp_mpic_perf_init();
 	armada_xp_mpic_reenable_percpu();
 	enable_percpu_irq(parent_irq, IRQ_TYPE_NONE);
+
 	return 0;
 }
 #else
@@ -579,9 +578,9 @@ static void ipi_resume(void) {}
=20
 static struct irq_chip armada_370_xp_irq_chip =3D {
 	.name		=3D "MPIC",
-	.irq_mask       =3D armada_370_xp_irq_mask,
-	.irq_mask_ack   =3D armada_370_xp_irq_mask,
-	.irq_unmask     =3D armada_370_xp_irq_unmask,
+	.irq_mask	=3D armada_370_xp_irq_mask,
+	.irq_mask_ack	=3D armada_370_xp_irq_mask,
+	.irq_unmask	=3D armada_370_xp_irq_unmask,
 #ifdef CONFIG_SMP
 	.irq_set_affinity =3D armada_xp_set_affinity,
 #endif
@@ -605,10 +604,9 @@ static int armada_370_xp_mpic_irq_map(struct irq_domain =
*h,
 	if (is_percpu_irq(hw)) {
 		irq_set_percpu_devid(virq);
 		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
-					handle_percpu_devid_irq);
+					 handle_percpu_devid_irq);
 	} else {
-		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip,
-					handle_level_irq);
+		irq_set_chip_and_handler(virq, &armada_370_xp_irq_chip, handle_level_irq);
 		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(virq)));
 	}
 	irq_set_probe(virq);
@@ -617,8 +615,8 @@ static int armada_370_xp_mpic_irq_map(struct irq_domain *=
h,
 }
=20
 static const struct irq_domain_ops armada_370_xp_mpic_irq_ops =3D {
-	.map =3D armada_370_xp_mpic_irq_map,
-	.xlate =3D irq_domain_xlate_onecell,
+	.map	=3D armada_370_xp_mpic_irq_map,
+	.xlate	=3D irq_domain_xlate_onecell,
 };
=20
 #ifdef CONFIG_PCI_MSI
@@ -705,21 +703,20 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
 			unsigned long ipimask;
 			int ipi;
=20
-			ipimask =3D readl_relaxed(per_cpu_int_base +
-						MPIC_IN_DRBEL_CAUSE)
-				& IPI_DOORBELL_MASK;
+			ipimask =3D readl_relaxed(per_cpu_int_base + MPIC_IN_DRBEL_CAUSE) &
+						IPI_DOORBELL_MASK;
=20
 			for_each_set_bit(ipi, &ipimask, IPI_DOORBELL_END)
 				generic_handle_domain_irq(ipi_domain, ipi);
 		}
 #endif
-
 	} while (1);
 }
=20
 static int armada_370_xp_mpic_suspend(void)
 {
 	doorbell_mask_reg =3D readl(per_cpu_int_base + MPIC_IN_DRBEL_MASK);
+
 	return 0;
 }
=20
@@ -815,9 +812,8 @@ static int __init armada_370_xp_mpic_of_init(struct devic=
e_node *node,
 	for (int i =3D 0; i < nr_irqs; i++)
 		writel(i, main_int_base + MPIC_INT_CLEAR_ENABLE);
=20
-	armada_370_xp_mpic_domain =3D
-		irq_domain_add_linear(node, nr_irqs,
-				&armada_370_xp_mpic_irq_ops, NULL);
+	armada_370_xp_mpic_domain =3D irq_domain_add_linear(node, nr_irqs,
+							  &armada_370_xp_mpic_irq_ops, NULL);
 	BUG_ON(!armada_370_xp_mpic_domain);
 	irq_domain_update_bus_token(armada_370_xp_mpic_domain, DOMAIN_BUS_WIRED);
=20

