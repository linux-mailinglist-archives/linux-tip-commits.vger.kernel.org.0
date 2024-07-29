Return-Path: <linux-tip-commits+bounces-1753-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99A193F192
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8451C219DB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AA813F42F;
	Mon, 29 Jul 2024 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QmuTSuw8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yCvzg5bY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FC913C69A;
	Mon, 29 Jul 2024 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246584; cv=none; b=nXkGbhgWcRNhxia+naSpF1l87hfco7K0uBLPpWON8pQDxm8QIEm/KRTps8moR0vntu/P77leZ7+t0KSXa8tEzHba14KBxs5egscQShia9sTxCcT9kWgHo1bj/UTCzw6ank4YqIL8q0LMnps7edxWzkBvDJrY6y8lGlC8KGYCCBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246584; c=relaxed/simple;
	bh=UHG5w7846kMYvNgsLGmQIIrhGjUJermF7Cte4FETHyw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AhsBK7Gj6xrzq2jLIHNkpYGY5iKBzpLsH61LV6VjQYmXUo4afrSU/NULvqvkfUNhn7lt8p7F4qducsE2Jdouy142hjGoR4gfwk51yWIony7+NaagCFd+NT002cHbWfXxKpvRoupViHOIV7Rwm8KQ4OwXSj4T0CYGBsatnk/hBHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QmuTSuw8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yCvzg5bY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 09:49:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722246581;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJ2A5FgQF7as1GJjiJ/TeTPi67IE0F1vEgNeG/MYOc8=;
	b=QmuTSuw8OIpW/XamR+RwwJ9JpN13dugLtMSGOi9BL1hfyyzeUnqzSUYfdInIvoK1rRdsOQ
	de1gHkj1hH0Oy1TxKJtQxnGweA2iz8GKRn6AjmsPVuGkwDUT+CZKEwzFAvV4ETQSCkgvDq
	b3qXk1SqlrOGuulTnatJAiC2mH+Ajp1PN6LjFVsi+su3pPn+ex9DRoQK0iLxYGhLQH8/Wr
	4RYIpi2qsAkKxR1+0M3mvWcJBNjsfIJwISx6kWr9psFR2vwFr2fJUZJTnX+W2zpwbUhDq4
	bybZWTfRaUggQ/6fiagaquRxRG0kJSS5pfGj3jWXG06NUW6OFaNZclX8sgiJZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246581;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJ2A5FgQF7as1GJjiJ/TeTPi67IE0F1vEgNeG/MYOc8=;
	b=yCvzg5bYm+kyaVC1RaJNZ3YwrZLk6YCoJWMi+kAuoAKuiRCbD/G727pgqMPXAcbO8PJ7OC
	ySxlTN7x0CzCfIBg==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Print error and return error
 code on initialization failure
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240711160907.31012-11-kabel@kernel.org>
References: <20240711160907.31012-11-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224658086.2215.7690944661281108407.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b50a11ce64e7c2de0b1a5ba50bba38cccc770125
Gitweb:        https://git.kernel.org/tip/b50a11ce64e7c2de0b1a5ba50bba38cccc7=
70125
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Thu, 11 Jul 2024 18:09:07 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:57:25 +02:00

irqchip/armada-370-xp: Print error and return error code on initialization fa=
ilure

Print error and return error code on main / IPI / MSI domain
initialization failure. Use WARN_ON() instead of BUG_ON().

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240711160907.31012-11-kabel@kernel.org

---
 drivers/irqchip/irq-armada-370-xp.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 244454e..0f21310 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -464,20 +464,23 @@ static void mpic_ipi_resume(void)
 	}
 }
=20
-static __init void mpic_ipi_init(struct device_node *node)
+static __init int mpic_ipi_init(struct device_node *node)
 {
 	int base_ipi;
=20
 	mpic_ipi_domain =3D irq_domain_create_linear(of_node_to_fwnode(node), IPI_D=
OORBELL_END,
 						   &mpic_ipi_domain_ops, NULL);
 	if (WARN_ON(!mpic_ipi_domain))
-		return;
+		return -ENOMEM;
=20
 	irq_domain_update_bus_token(mpic_ipi_domain, DOMAIN_BUS_IPI);
 	base_ipi =3D irq_domain_alloc_irqs(mpic_ipi_domain, IPI_DOORBELL_END, NUMA_=
NO_NODE, NULL);
 	if (WARN_ON(!base_ipi))
-		return;
+		return -ENOMEM;
+
 	set_smp_ipi_range(base_ipi, IPI_DOORBELL_END);
+
+	return 0;
 }
=20
 static int mpic_set_affinity(struct irq_data *d, const struct cpumask *mask_=
val, bool force)
@@ -803,7 +806,11 @@ static int __init mpic_of_init(struct device_node *node,=
 struct device_node *par
 		writel(i, main_int_base + MPIC_INT_CLEAR_ENABLE);
=20
 	mpic_domain =3D irq_domain_add_linear(node, nr_irqs, &mpic_irq_ops, NULL);
-	BUG_ON(!mpic_domain);
+	if (!mpic_domain) {
+		pr_err("%pOF: Unable to add IRQ domain\n", node);
+		return -ENOMEM;
+	}
+
 	irq_domain_update_bus_token(mpic_domain, DOMAIN_BUS_WIRED);
=20
 	/*
@@ -816,13 +823,22 @@ static int __init mpic_of_init(struct device_node *node=
, struct device_node *par
 	mpic_perf_init();
 	mpic_smp_cpu_init();
=20
-	mpic_msi_init(node, phys_base);
+	err =3D mpic_msi_init(node, phys_base);
+	if (err) {
+		pr_err("%pOF: Unable to initialize MSI domain\n", node);
+		return err;
+	}
=20
 	if (parent_irq <=3D 0) {
 		irq_set_default_host(mpic_domain);
 		set_handle_irq(mpic_handle_irq);
 #ifdef CONFIG_SMP
-		mpic_ipi_init(node);
+		err =3D mpic_ipi_init(node);
+		if (err) {
+			pr_err("%pOF: Unable to initialize IPI domain\n", node);
+			return err;
+		}
+
 		cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_ARMADA_XP_STARTING,
 					  "irqchip/armada/ipi:starting",
 					  mpic_starting_cpu, NULL);

