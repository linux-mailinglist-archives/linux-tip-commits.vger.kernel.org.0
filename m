Return-Path: <linux-tip-commits+bounces-4667-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0251BA7C065
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 17:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CCB3BD3C8
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 15:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7578A1F55EB;
	Fri,  4 Apr 2025 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hvjmb1VH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IapsmQjt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC031F4CBB;
	Fri,  4 Apr 2025 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743779667; cv=none; b=nooqIub8zN0PQkfCnxCOPiWMB46Rwb80L9pBM8mkX3pFARIMwv8x41j6LMBf4bNKMx2VjcX8K6bapINMo41fdeqqSTxLdI5VU7blCmuDw1C6PFXwdi9sgwRUum1RndZlJaWdpat55unmydQi5zt+8KLXzm63CzobrdCn/Mt0wqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743779667; c=relaxed/simple;
	bh=jvb09HgJQgvSh5LPqFXI/G2yZV0bLIfz8ZkFf14gAwc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SZXZsmONm9YHBsjjbNBoh8Zj/Sik+mLXwLkvrGL/b3f/ltoRo8WvuYoMFQ5Kp0bVMp1SWBqDF0iWbgyUcSiS2BpV+Q7VD2PzfNl5W0GDSBHlGa7wLvg165DbgrBVKoNjC8JGMnMCHh3V/So9nfJzSlPeRLCkq9hwaAtmV/ce6DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hvjmb1VH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IapsmQjt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 15:14:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743779663;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rx9fNMSZilOPgsJtpY6c7P9D5bcmLQTGYzNsKz7CAvY=;
	b=hvjmb1VHCD8ghfQiKCA+xchCQ65cHhtFElStebNeaCQJeZUdaLYXUd3XMqr5JVYwuPqSc0
	nLltNRG5bFDjOj9v7KoUlhO+Bmu8WKAGJhfvlhqvchrJb9FHNrtwmwK1EWtPkKKuBfmaq0
	oYFabZdv8UQ0LJC+sJHgIpCKQ2UZEqif11gPlzeO7a8/JAlhKZFRikTHWMHKqC1h20GwIO
	U+zn3BS/MaTZYIoayUqTcaHC8jjQUT2Wq85Z4l8pfBiJb+ywXyIdYS2An+SmepI/pla9az
	IxX8/5dIyUVKLLjS6Hz6P0E9PlFnjc11AzEIGfobGp6BTlOcwAxN7pvSLJk4Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743779663;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rx9fNMSZilOPgsJtpY6c7P9D5bcmLQTGYzNsKz7CAvY=;
	b=IapsmQjtSoO1THB6WDHigqqajGnMZMLbuQI49zQGwEw1dzEGrQ6WOpc1LYs6pgnNnj5xvO
	5s0XSa9HACWBWFDQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqdomain: Rename irq_set_default_host() to
 irq_set_default_domain()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250319092951.37667-3-jirislaby@kernel.org>
References: <20250319092951.37667-3-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174377966263.31282.3238252636262941402.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     825dfab23bca520629a9e5a21ba5b03aaccc75f2
Gitweb:        https://git.kernel.org/tip/825dfab23bca520629a9e5a21ba5b03aaccc75f2
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:28:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 16:39:10 +02:00

irqdomain: Rename irq_set_default_host() to irq_set_default_domain()

Naming interrupt domains host is confusing at best and the irqdomain code
uses both domain and host inconsistently.

Therefore rename irq_set_default_host() to irq_set_default_domain().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-3-jirislaby@kernel.org

---
 arch/arc/kernel/intc-arcv2.c                     | 2 +-
 arch/arc/kernel/intc-compact.c                   | 2 +-
 arch/arm/mach-pxa/irq.c                          | 2 +-
 arch/mips/cavium-octeon/octeon-irq.c             | 6 +++---
 arch/mips/sgi-ip27/ip27-irq.c                    | 2 +-
 arch/mips/sgi-ip30/ip30-irq.c                    | 2 +-
 arch/nios2/kernel/irq.c                          | 2 +-
 arch/powerpc/platforms/44x/uic.c                 | 2 +-
 arch/powerpc/platforms/52xx/mpc52xx_pic.c        | 2 +-
 arch/powerpc/platforms/amigaone/setup.c          | 2 +-
 arch/powerpc/platforms/chrp/setup.c              | 2 +-
 arch/powerpc/platforms/embedded6xx/flipper-pic.c | 2 +-
 arch/powerpc/platforms/pasemi/setup.c            | 2 +-
 arch/powerpc/platforms/powermac/pic.c            | 2 +-
 arch/powerpc/platforms/ps3/interrupt.c           | 2 +-
 arch/powerpc/sysdev/ehv_pic.c                    | 2 +-
 arch/powerpc/sysdev/ipic.c                       | 2 +-
 arch/powerpc/sysdev/mpic.c                       | 2 +-
 arch/powerpc/sysdev/xics/xics-common.c           | 2 +-
 arch/powerpc/sysdev/xive/common.c                | 2 +-
 arch/x86/kernel/apic/vector.c                    | 2 +-
 drivers/irqchip/irq-armada-370-xp.c              | 2 +-
 drivers/irqchip/irq-clps711x.c                   | 2 +-
 drivers/irqchip/irq-imx-gpcv2.c                  | 2 +-
 drivers/irqchip/irq-pic32-evic.c                 | 2 +-
 drivers/irqchip/irq-xilinx-intc.c                | 2 +-
 drivers/irqchip/irq-xtensa-mx.c                  | 2 +-
 drivers/irqchip/irq-xtensa-pic.c                 | 4 ++--
 include/linux/irqdomain.h                        | 2 +-
 kernel/irq/irqdomain.c                           | 8 ++++----
 30 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arc/kernel/intc-arcv2.c b/arch/arc/kernel/intc-arcv2.c
index f324f0e..fea29d9 100644
--- a/arch/arc/kernel/intc-arcv2.c
+++ b/arch/arc/kernel/intc-arcv2.c
@@ -178,7 +178,7 @@ init_onchip_IRQ(struct device_node *intc, struct device_node *parent)
 	 * Needed for primary domain lookup to succeed
 	 * This is a primary irqchip, and can never have a parent
 	 */
-	irq_set_default_host(root_domain);
+	irq_set_default_domain(root_domain);
 
 #ifdef CONFIG_SMP
 	irq_create_mapping(root_domain, IPI_IRQ);
diff --git a/arch/arc/kernel/intc-compact.c b/arch/arc/kernel/intc-compact.c
index 6885e42..1d2ff1c 100644
--- a/arch/arc/kernel/intc-compact.c
+++ b/arch/arc/kernel/intc-compact.c
@@ -121,7 +121,7 @@ init_onchip_IRQ(struct device_node *intc, struct device_node *parent)
 	 * Needed for primary domain lookup to succeed
 	 * This is a primary irqchip, and can never have a parent
 	 */
-	irq_set_default_host(root_domain);
+	irq_set_default_domain(root_domain);
 
 	return 0;
 }
diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index a9ef710..d9cadd9 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -152,7 +152,7 @@ pxa_init_irq_common(struct device_node *node, int irq_nr,
 					       &pxa_irq_ops, NULL);
 	if (!pxa_irq_domain)
 		panic("Unable to add PXA IRQ domain\n");
-	irq_set_default_host(pxa_irq_domain);
+	irq_set_default_domain(pxa_irq_domain);
 
 	for (n = 0; n < irq_nr; n += 32) {
 		void __iomem *base = irq_base(n >> 5);
diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index 8425a6b..e6b4d9c 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -1505,7 +1505,7 @@ static int __init octeon_irq_init_ciu(
 
 	ciu_domain = irq_domain_add_tree(
 		ciu_node, &octeon_irq_domain_ciu_ops, dd);
-	irq_set_default_host(ciu_domain);
+	irq_set_default_domain(ciu_domain);
 
 	/* CIU_0 */
 	for (i = 0; i < 16; i++) {
@@ -2076,7 +2076,7 @@ static int __init octeon_irq_init_ciu2(
 
 	ciu_domain = irq_domain_add_tree(
 		ciu_node, &octeon_irq_domain_ciu2_ops, NULL);
-	irq_set_default_host(ciu_domain);
+	irq_set_default_domain(ciu_domain);
 
 	/* CUI2 */
 	for (i = 0; i < 64; i++) {
@@ -2929,7 +2929,7 @@ static int __init octeon_irq_init_ciu3(struct device_node *ciu_node,
 		/* Only do per CPU things if it is the CIU of the boot node. */
 		octeon_irq_ciu3_alloc_resources(ciu3_info);
 		if (node == 0)
-			irq_set_default_host(domain);
+			irq_set_default_domain(domain);
 
 		octeon_irq_use_ip4 = false;
 		/* Enable the CIU lines */
diff --git a/arch/mips/sgi-ip27/ip27-irq.c b/arch/mips/sgi-ip27/ip27-irq.c
index 00e63e9..288d4d1 100644
--- a/arch/mips/sgi-ip27/ip27-irq.c
+++ b/arch/mips/sgi-ip27/ip27-irq.c
@@ -297,7 +297,7 @@ void __init arch_init_irq(void)
 	if (WARN_ON(domain == NULL))
 		return;
 
-	irq_set_default_host(domain);
+	irq_set_default_domain(domain);
 
 	irq_set_percpu_devid(IP27_HUB_PEND0_IRQ);
 	irq_set_chained_handler_and_data(IP27_HUB_PEND0_IRQ, ip27_do_irq_mask0,
diff --git a/arch/mips/sgi-ip30/ip30-irq.c b/arch/mips/sgi-ip30/ip30-irq.c
index 423c32c..9fb905e 100644
--- a/arch/mips/sgi-ip30/ip30-irq.c
+++ b/arch/mips/sgi-ip30/ip30-irq.c
@@ -313,7 +313,7 @@ void __init arch_init_irq(void)
 	if (!domain)
 		return;
 
-	irq_set_default_host(domain);
+	irq_set_default_domain(domain);
 
 	irq_set_percpu_devid(IP30_HEART_L0_IRQ);
 	irq_set_chained_handler_and_data(IP30_HEART_L0_IRQ, ip30_normal_irq,
diff --git a/arch/nios2/kernel/irq.c b/arch/nios2/kernel/irq.c
index 6b7890e..8fa2806 100644
--- a/arch/nios2/kernel/irq.c
+++ b/arch/nios2/kernel/irq.c
@@ -72,7 +72,7 @@ void __init init_IRQ(void)
 	domain = irq_domain_add_linear(node, NIOS2_CPU_NR_IRQS, &irq_ops, NULL);
 	BUG_ON(!domain);
 
-	irq_set_default_host(domain);
+	irq_set_default_domain(domain);
 	of_node_put(node);
 	/* Load the initial ienable value */
 	ienable = RDCTL(CTL_IENABLE);
diff --git a/arch/powerpc/platforms/44x/uic.c b/arch/powerpc/platforms/44x/uic.c
index 8b03ae4..31f760c 100644
--- a/arch/powerpc/platforms/44x/uic.c
+++ b/arch/powerpc/platforms/44x/uic.c
@@ -291,7 +291,7 @@ void __init uic_init_tree(void)
 	if (!primary_uic)
 		panic("Unable to initialize primary UIC %pOF\n", np);
 
-	irq_set_default_host(primary_uic->irqhost);
+	irq_set_default_domain(primary_uic->irqhost);
 	of_node_put(np);
 
 	/* The scan again for cascaded UICs */
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index 1e0a5e9..43c881d 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -453,7 +453,7 @@ void __init mpc52xx_init_irq(void)
 	if (!mpc52xx_irqhost)
 		panic(__FILE__ ": Cannot allocate the IRQ host\n");
 
-	irq_set_default_host(mpc52xx_irqhost);
+	irq_set_default_domain(mpc52xx_irqhost);
 
 	pr_info("MPC52xx PIC is up and running!\n");
 }
diff --git a/arch/powerpc/platforms/amigaone/setup.c b/arch/powerpc/platforms/amigaone/setup.c
index 2c8dc08..33f852a 100644
--- a/arch/powerpc/platforms/amigaone/setup.c
+++ b/arch/powerpc/platforms/amigaone/setup.c
@@ -109,7 +109,7 @@ static void __init amigaone_init_IRQ(void)
 
 	i8259_init(pic, int_ack);
 	ppc_md.get_irq = i8259_irq;
-	irq_set_default_host(i8259_get_host());
+	irq_set_default_domain(i8259_get_host());
 }
 
 static int __init request_isa_regions(void)
diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 36ee3a5..c1bfa4c 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -486,7 +486,7 @@ static void __init chrp_find_8259(void)
 	i8259_init(pic, chrp_int_ack);
 	if (ppc_md.get_irq == NULL) {
 		ppc_md.get_irq = i8259_irq;
-		irq_set_default_host(i8259_get_host());
+		irq_set_default_domain(i8259_get_host());
 	}
 	if (chrp_mpic != NULL) {
 		cascade_irq = irq_of_parse_and_map(pic, 0);
diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index 4d9200b..013d663 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -190,7 +190,7 @@ void __init flipper_pic_probe(void)
 	flipper_irq_host = flipper_pic_init(np);
 	BUG_ON(!flipper_irq_host);
 
-	irq_set_default_host(flipper_irq_host);
+	irq_set_default_domain(flipper_irq_host);
 
 	of_node_put(np);
 }
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 0761d98..d03b413 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -228,7 +228,7 @@ static void __init nemo_init_IRQ(struct mpic *mpic)
 	irq_set_chained_handler(gpio_virq, sb600_8259_cascade);
 	mpic_unmask_irq(irq_get_irq_data(gpio_virq));
 
-	irq_set_default_host(mpic->irqhost);
+	irq_set_default_domain(mpic->irqhost);
 }
 
 #else
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 2202bf7..03a7c51 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -330,7 +330,7 @@ static void __init pmac_pic_probe_oldstyle(void)
 	pmac_pic_host = irq_domain_add_linear(master, max_irqs,
 					      &pmac_pic_host_ops, NULL);
 	BUG_ON(pmac_pic_host == NULL);
-	irq_set_default_host(pmac_pic_host);
+	irq_set_default_domain(pmac_pic_host);
 
 	/* Get addresses of first controller if we have a node for it */
 	BUG_ON(of_address_to_resource(master, 0, &r));
diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index af3fe9f..95e96bd 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -744,7 +744,7 @@ void __init ps3_init_IRQ(void)
 	struct irq_domain *host;
 
 	host = irq_domain_add_nomap(NULL, PS3_PLUG_MAX + 1, &ps3_host_ops, NULL);
-	irq_set_default_host(host);
+	irq_set_default_domain(host);
 
 	for_each_possible_cpu(cpu) {
 		struct ps3_private *pd = &per_cpu(ps3_private, cpu);
diff --git a/arch/powerpc/sysdev/ehv_pic.c b/arch/powerpc/sysdev/ehv_pic.c
index 0408276..fb502b7 100644
--- a/arch/powerpc/sysdev/ehv_pic.c
+++ b/arch/powerpc/sysdev/ehv_pic.c
@@ -291,5 +291,5 @@ void __init ehv_pic_init(void)
 	ehv_pic->coreint_flag = of_property_read_bool(np, "has-external-proxy");
 
 	global_ehv_pic = ehv_pic;
-	irq_set_default_host(global_ehv_pic->irqhost);
+	irq_set_default_domain(global_ehv_pic->irqhost);
 }
diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index 037b04b..a35be02 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -757,7 +757,7 @@ struct ipic * __init ipic_init(struct device_node *node, unsigned int flags)
 	ipic_write(ipic->regs, IPIC_SEMSR, temp);
 
 	primary_ipic = ipic;
-	irq_set_default_host(primary_ipic->irqhost);
+	irq_set_default_domain(primary_ipic->irqhost);
 
 	ipic_write(ipic->regs, IPIC_SIMSR_H, 0);
 	ipic_write(ipic->regs, IPIC_SIMSR_L, 0);
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index d94cf36..4afbab8 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1520,7 +1520,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 
 	if (!(mpic->flags & MPIC_SECONDARY)) {
 		mpic_primary = mpic;
-		irq_set_default_host(mpic->irqhost);
+		irq_set_default_domain(mpic->irqhost);
 	}
 
 	return mpic;
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index d3a4156..c3fa539 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -472,7 +472,7 @@ static int __init xics_allocate_domain(void)
 		return -ENOMEM;
 	}
 
-	irq_set_default_host(xics_host);
+	irq_set_default_domain(xics_host);
 	return 0;
 }
 
diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index a6c388b..dc2e618 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1467,7 +1467,7 @@ static void __init xive_init_host(struct device_node *np)
 	xive_irq_domain = irq_domain_add_tree(np, &xive_irq_domain_ops, NULL);
 	if (WARN_ON(xive_irq_domain == NULL))
 		return;
-	irq_set_default_host(xive_irq_domain);
+	irq_set_default_domain(xive_irq_domain);
 }
 
 static void xive_cleanup_cpu_queues(unsigned int cpu, struct xive_cpu *xc)
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 72fa4bb..fee42a7 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -799,7 +799,7 @@ int __init arch_early_irq_init(void)
 	x86_vector_domain = irq_domain_create_tree(fn, &x86_vector_domain_ops,
 						   NULL);
 	BUG_ON(x86_vector_domain == NULL);
-	irq_set_default_host(x86_vector_domain);
+	irq_set_default_domain(x86_vector_domain);
 
 	BUG_ON(!alloc_cpumask_var(&vector_searchmask, GFP_KERNEL));
 
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index d7c5ef2..6218e5d 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -880,7 +880,7 @@ static int __init mpic_of_init(struct device_node *node, struct device_node *par
 	}
 
 	if (mpic_is_ipi_available(mpic)) {
-		irq_set_default_host(mpic->domain);
+		irq_set_default_domain(mpic->domain);
 		set_handle_irq(mpic_handle_irq);
 #ifdef CONFIG_SMP
 		err = mpic_ipi_init(mpic, node);
diff --git a/drivers/irqchip/irq-clps711x.c b/drivers/irqchip/irq-clps711x.c
index 806ebb1..48c73c9 100644
--- a/drivers/irqchip/irq-clps711x.c
+++ b/drivers/irqchip/irq-clps711x.c
@@ -191,7 +191,7 @@ static int __init _clps711x_intc_init(struct device_node *np,
 		goto out_irqfree;
 	}
 
-	irq_set_default_host(clps711x_intc->domain);
+	irq_set_default_domain(clps711x_intc->domain);
 	set_handle_irq(clps711x_irqh);
 
 #ifdef CONFIG_FIQ
diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 8a0e820..095ae8e 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -247,7 +247,7 @@ static int __init imx_gpcv2_irqchip_init(struct device_node *node,
 		kfree(cd);
 		return -ENOMEM;
 	}
-	irq_set_default_host(domain);
+	irq_set_default_domain(domain);
 
 	/* Initially mask all interrupts */
 	for (i = 0; i < IMR_NUM; i++) {
diff --git a/drivers/irqchip/irq-pic32-evic.c b/drivers/irqchip/irq-pic32-evic.c
index eb6ca51..b546b10 100644
--- a/drivers/irqchip/irq-pic32-evic.c
+++ b/drivers/irqchip/irq-pic32-evic.c
@@ -291,7 +291,7 @@ static int __init pic32_of_init(struct device_node *node,
 		gc->private = &priv[i];
 	}
 
-	irq_set_default_host(evic_irq_domain);
+	irq_set_default_domain(evic_irq_domain);
 
 	/*
 	 * External interrupts have software configurable edge polarity. These
diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 7e08714..38727e9 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -233,7 +233,7 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 		}
 	} else {
 		primary_intc = irqc;
-		irq_set_default_host(primary_intc->root_domain);
+		irq_set_default_domain(primary_intc->root_domain);
 		set_handle_irq(xil_intc_handle_irq);
 	}
 
diff --git a/drivers/irqchip/irq-xtensa-mx.c b/drivers/irqchip/irq-xtensa-mx.c
index 7f314e5..9b441d1 100644
--- a/drivers/irqchip/irq-xtensa-mx.c
+++ b/drivers/irqchip/irq-xtensa-mx.c
@@ -156,7 +156,7 @@ static void __init xtensa_mx_init_common(struct irq_domain *root_domain)
 {
 	unsigned int i;
 
-	irq_set_default_host(root_domain);
+	irq_set_default_domain(root_domain);
 	secondary_init_irq();
 
 	/* Initialize default IRQ routing to CPU 0 */
diff --git a/drivers/irqchip/irq-xtensa-pic.c b/drivers/irqchip/irq-xtensa-pic.c
index f9d6fce..9be7b7c 100644
--- a/drivers/irqchip/irq-xtensa-pic.c
+++ b/drivers/irqchip/irq-xtensa-pic.c
@@ -87,7 +87,7 @@ int __init xtensa_pic_init_legacy(struct device_node *interrupt_parent)
 	struct irq_domain *root_domain =
 		irq_domain_add_legacy(NULL, NR_IRQS - 1, 1, 0,
 				&xtensa_irq_domain_ops, &xtensa_irq_chip);
-	irq_set_default_host(root_domain);
+	irq_set_default_domain(root_domain);
 	return 0;
 }
 
@@ -97,7 +97,7 @@ static int __init xtensa_pic_init(struct device_node *np,
 	struct irq_domain *root_domain =
 		irq_domain_add_linear(np, NR_IRQS, &xtensa_irq_domain_ops,
 				&xtensa_irq_chip);
-	irq_set_default_host(root_domain);
+	irq_set_default_domain(root_domain);
 	return 0;
 }
 IRQCHIP_DECLARE(xtensa_irq_chip, "cdns,xtensa-pic", xtensa_pic_init);
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 33ff41e..4b5c495 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -352,7 +352,7 @@ struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
 					    void *host_data);
 struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
 					    enum irq_domain_bus_token bus_token);
-void irq_set_default_host(struct irq_domain *host);
+void irq_set_default_domain(struct irq_domain *domain);
 struct irq_domain *irq_get_default_host(void);
 int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
 			   irq_hw_number_t hwirq, int node,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 2861f89..480fdc9 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -398,7 +398,7 @@ void irq_domain_remove(struct irq_domain *domain)
 	 * If the going away domain is the default one, reset it.
 	 */
 	if (unlikely(irq_default_domain == domain))
-		irq_set_default_host(NULL);
+		irq_set_default_domain(NULL);
 
 	mutex_unlock(&irq_domain_mutex);
 
@@ -573,7 +573,7 @@ struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
 EXPORT_SYMBOL_GPL(irq_find_matching_fwspec);
 
 /**
- * irq_set_default_host() - Set a "default" irq domain
+ * irq_set_default_domain() - Set a "default" irq domain
  * @domain: default domain pointer
  *
  * For convenience, it's possible to set a "default" domain that will be used
@@ -581,13 +581,13 @@ EXPORT_SYMBOL_GPL(irq_find_matching_fwspec);
  * platforms that want to manipulate a few hard coded interrupt numbers that
  * aren't properly represented in the device-tree.
  */
-void irq_set_default_host(struct irq_domain *domain)
+void irq_set_default_domain(struct irq_domain *domain)
 {
 	pr_debug("Default domain set to @0x%p\n", domain);
 
 	irq_default_domain = domain;
 }
-EXPORT_SYMBOL_GPL(irq_set_default_host);
+EXPORT_SYMBOL_GPL(irq_set_default_domain);
 
 /**
  * irq_get_default_host() - Retrieve the "default" irq domain

