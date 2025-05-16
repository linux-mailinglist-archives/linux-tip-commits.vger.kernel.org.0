Return-Path: <linux-tip-commits+bounces-5621-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E548ABA421
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D16417AFBEC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B3428001B;
	Fri, 16 May 2025 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sZCiXhc9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RuwFrYgG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721C7289815;
	Fri, 16 May 2025 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424269; cv=none; b=qVg5Gh+oGXDc1M3f+wO1AsdyjKcs24bur/7EagXj1jZtvY7D/ePqg3Vhkr7nKISGCyg1xl5ntGj7ZdGlupp0tB4lCvbZrMG4hEN16k/5B/Fbsi56EzdWSBpJH5cW22WwnfHFwUAbljl5xp0zE7XMJxjo0dVV3x2Z+BW5QIzOyWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424269; c=relaxed/simple;
	bh=+Fm3dxXUMjxyyypEUq48Mb7vX7dywh92+pLfLTT5kFg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HJMDVHq67oS4eoOizjNMRY84J2xbCAyqzoKaJzgUeq2lqsIwtoYhVzPaDQm5zfhjJUSNBCsrlJK5KvD5NP3v2pmOp1H3pMC5zuVLHLe0LlL5icKWR9alfCtaY15Yb1LBw0noGUuZuaM0iCwmcKxznte8MrRH8kgTJyTJcZQqYyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sZCiXhc9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RuwFrYgG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424265;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BtR3bWaaQ/SyjrPRug0jZsOt3tM2mR41ScbC/lzIZjc=;
	b=sZCiXhc9SwTVy2eIZfPrw1cXcLkBs2jZOjBsLtaLsXLc6urBJCNAGX4XKAGgSEQlAqKrPY
	+U3I2Iv+mEqScspARXXS33zvlZa5xHoPUwdnJzOlgi0IaYnZAaQD0MgjWmsS7jssFm84oR
	tm0F6vkfwixlSUCmZX1mpnJ85JCfB8+QJJuIoma6pwwcJwozC78CVcAvHVhz14y/9j/KnU
	FLl80/0hzDkhqYp+Ph/BcX7Dk68xx/d2zVMlEWQb90pddEfTwDnWu9Z4bNNplNxi7VUi8d
	DUhEzS5v19c6yGvcDusSw1up1Wgw2fLD8xto877I48l/FKOlWRlYS9k3a+HVpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424265;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BtR3bWaaQ/SyjrPRug0jZsOt3tM2mR41ScbC/lzIZjc=;
	b=RuwFrYgGZXULxvgquhNJpNGgczW5mIfdTG9fMrNcQJaM8NaTsw3jnXaFF6/u08abu5amOh
	BzEjwcJGW60lIRAA==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] ARM: Switch to irq_domain_create_*()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-15-jirislaby@kernel.org>
References: <20250319092951.37667-15-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742426500.406.14340902841905287299.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     4dcb0045a363b9d32472f527bd06a6816e6a4275
Gitweb:        https://git.kernel.org/tip/4dcb0045a363b9d32472f527bd06a6816e6a4275
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:07 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:08 +02:00

ARM: Switch to irq_domain_create_*()

irq_domain_add_*() interfaces are going away as being obsolete now.
Switch to the preferred irq_domain_create_*() ones. Those differ in the
node parameter: They take more generic struct fwnode_handle instead of
struct device_node. Therefore, of_fwnode_handle() is added around the
original parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-15-jirislaby@kernel.org


---
 arch/arm/common/sa1111.c             |  6 +++---
 arch/arm/mach-exynos/suspend.c       |  5 ++---
 arch/arm/mach-imx/avic.c             |  4 ++--
 arch/arm/mach-imx/gpc.c              |  5 ++---
 arch/arm/mach-imx/tzic.c             |  4 ++--
 arch/arm/mach-omap1/irq.c            |  3 +--
 arch/arm/mach-omap2/omap-wakeupgen.c |  5 ++---
 arch/arm/mach-pxa/irq.c              |  5 ++---
 arch/arm/plat-orion/gpio.c           | 12 ++++++------
 9 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 9846f30..02eda44 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -416,9 +416,9 @@ static int sa1111_setup_irq(struct sa1111 *sachip, unsigned irq_base)
 	writel_relaxed(~0, irqbase + SA1111_INTSTATCLR0);
 	writel_relaxed(~0, irqbase + SA1111_INTSTATCLR1);
 
-	sachip->irqdomain = irq_domain_add_linear(NULL, SA1111_IRQ_NR,
-						  &sa1111_irqdomain_ops,
-						  sachip);
+	sachip->irqdomain = irq_domain_create_linear(NULL, SA1111_IRQ_NR,
+						     &sa1111_irqdomain_ops,
+						     sachip);
 	if (!sachip->irqdomain) {
 		irq_free_descs(sachip->irq_base, SA1111_IRQ_NR);
 		return -ENOMEM;
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index cac4e82..150a1e5 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -209,9 +209,8 @@ static int __init exynos_pmu_irq_init(struct device_node *node,
 		return -ENOMEM;
 	}
 
-	domain = irq_domain_add_hierarchy(parent_domain, 0, 0,
-					  node, &exynos_pmu_domain_ops,
-					  NULL);
+	domain = irq_domain_create_hierarchy(parent_domain, 0, 0, of_fwnode_handle(node),
+					     &exynos_pmu_domain_ops, NULL);
 	if (!domain) {
 		iounmap(pmu_base_addr);
 		pmu_base_addr = NULL;
diff --git a/arch/arm/mach-imx/avic.c b/arch/arm/mach-imx/avic.c
index cf6546d..3067c06 100644
--- a/arch/arm/mach-imx/avic.c
+++ b/arch/arm/mach-imx/avic.c
@@ -201,8 +201,8 @@ static void __init mxc_init_irq(void __iomem *irqbase)
 	WARN_ON(irq_base < 0);
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,avic");
-	domain = irq_domain_add_legacy(np, AVIC_NUM_IRQS, irq_base, 0,
-				       &irq_domain_simple_ops, NULL);
+	domain = irq_domain_create_legacy(of_fwnode_handle(np), AVIC_NUM_IRQS, irq_base, 0,
+					  &irq_domain_simple_ops, NULL);
 	WARN_ON(!domain);
 
 	for (i = 0; i < AVIC_NUM_IRQS / 32; i++, irq_base += 32)
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 5909088..2e63356 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -245,9 +245,8 @@ static int __init imx_gpc_init(struct device_node *node,
 	if (WARN_ON(!gpc_base))
 	        return -ENOMEM;
 
-	domain = irq_domain_add_hierarchy(parent_domain, 0, GPC_MAX_IRQS,
-					  node, &imx_gpc_domain_ops,
-					  NULL);
+	domain = irq_domain_create_hierarchy(parent_domain, 0, GPC_MAX_IRQS, of_fwnode_handle(node),
+					     &imx_gpc_domain_ops, NULL);
 	if (!domain) {
 		iounmap(gpc_base);
 		return -ENOMEM;
diff --git a/arch/arm/mach-imx/tzic.c b/arch/arm/mach-imx/tzic.c
index 8b3d98d..50a5668 100644
--- a/arch/arm/mach-imx/tzic.c
+++ b/arch/arm/mach-imx/tzic.c
@@ -175,8 +175,8 @@ static int __init tzic_init_dt(struct device_node *np, struct device_node *p)
 	irq_base = irq_alloc_descs(-1, 0, TZIC_NUM_IRQS, numa_node_id());
 	WARN_ON(irq_base < 0);
 
-	domain = irq_domain_add_legacy(np, TZIC_NUM_IRQS, irq_base, 0,
-				       &irq_domain_simple_ops, NULL);
+	domain = irq_domain_create_legacy(of_fwnode_handle(np), TZIC_NUM_IRQS, irq_base, 0,
+					  &irq_domain_simple_ops, NULL);
 	WARN_ON(!domain);
 
 	for (i = 0; i < 4; i++, irq_base += 32)
diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
index 9b587ec..bb1bc06 100644
--- a/arch/arm/mach-omap1/irq.c
+++ b/arch/arm/mach-omap1/irq.c
@@ -220,8 +220,7 @@ void __init omap1_init_irq(void)
 	omap_l2_irq = irq_base;
 	omap_l2_irq -= NR_IRQS_LEGACY;
 
-	domain = irq_domain_add_legacy(NULL, nr_irqs, irq_base, 0,
-				       &irq_domain_simple_ops, NULL);
+	domain = irq_domain_create_legacy(NULL, nr_irqs, irq_base, 0, &irq_domain_simple_ops, NULL);
 
 	pr_info("Total of %lu interrupts in %i interrupt banks\n",
 		nr_irqs, irq_bank_count);
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 6f0d612..a66b1dc 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -585,9 +585,8 @@ static int __init wakeupgen_init(struct device_node *node,
 		wakeupgen_ops = &am43xx_wakeupgen_ops;
 	}
 
-	domain = irq_domain_add_hierarchy(parent_domain, 0, max_irqs,
-					  node, &wakeupgen_domain_ops,
-					  NULL);
+	domain = irq_domain_create_hierarchy(parent_domain, 0, max_irqs, of_fwnode_handle(node),
+					     &wakeupgen_domain_ops, NULL);
 	if (!domain) {
 		iounmap(wakeupgen_base);
 		return -ENOMEM;
diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index d9cadd9..5bfce8a 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -147,9 +147,8 @@ pxa_init_irq_common(struct device_node *node, int irq_nr,
 	int n;
 
 	pxa_internal_irq_nr = irq_nr;
-	pxa_irq_domain = irq_domain_add_legacy(node, irq_nr,
-					       PXA_IRQ(0), 0,
-					       &pxa_irq_ops, NULL);
+	pxa_irq_domain = irq_domain_create_legacy(of_fwnode_handle(node), irq_nr, PXA_IRQ(0), 0,
+						  &pxa_irq_ops, NULL);
 	if (!pxa_irq_domain)
 		panic("Unable to add PXA IRQ domain\n");
 	irq_set_default_domain(pxa_irq_domain);
diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
index 595e9cb..a15f474 100644
--- a/arch/arm/plat-orion/gpio.c
+++ b/arch/arm/plat-orion/gpio.c
@@ -602,12 +602,12 @@ void __init orion_gpio_init(int gpio_base, int ngpio,
 			       IRQ_NOREQUEST, IRQ_LEVEL | IRQ_NOPROBE);
 
 	/* Setup irq domain on top of the generic chip. */
-	ochip->domain = irq_domain_add_legacy(NULL,
-					      ochip->chip.ngpio,
-					      ochip->secondary_irq_base,
-					      ochip->secondary_irq_base,
-					      &irq_domain_simple_ops,
-					      ochip);
+	ochip->domain = irq_domain_create_legacy(NULL,
+						 ochip->chip.ngpio,
+						 ochip->secondary_irq_base,
+						 ochip->secondary_irq_base,
+						 &irq_domain_simple_ops,
+						 ochip);
 	if (!ochip->domain)
 		panic("%s: couldn't allocate irq domain (DT).\n",
 		      ochip->chip.label);

