Return-Path: <linux-tip-commits+bounces-5312-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7F9AAC5FA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED26F7B9D2F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC08D28983D;
	Tue,  6 May 2025 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ENydY2ve";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LkBEtvTK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD168289348;
	Tue,  6 May 2025 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537648; cv=none; b=KedrRkEY2ocYvUItDj4a6gpAx6I6w2v5HFMIfwQ9TE8+C/u7fXHpfOAU0z+g9npW0OHIkiulRpM9Zgnj74FEou9zqCgxOsKwzc0jxjjTayzDzxUCYd33nnmR1/pJmWvPN7i67BDsc1c/S6Wps7Ljf4otWY3SDUX76sX/hUJ8SKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537648; c=relaxed/simple;
	bh=ll1zFpDcHFdRPhnCL3lmZL+WSS2YyrxUGb80Zk1Po5g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DAvyntwBAHRfuNkWD2tDnWnjFUUoH7r5O+wAyxXFRq+I/hGlJU/6/l35pziFSMm736eeYfV+k5BuwCiBkuuenDwpOg42skURf240jI2g3SHK+s+4j2i6AufIxuBQCwoap6WIeXmyZvCr7kbUvErTMTjBWSqhay/BkzNBvQOiRAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ENydY2ve; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LkBEtvTK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537643;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8a1picuh9P3s86WqRXZ3ttl8F1UItJYIA/F52c/gcds=;
	b=ENydY2vec7A99qHZySxVXgwH4tikTVz4CUppguAMWf2fUAFUqN532kWRNrPiLm7aIAqLdJ
	HFfqg3Uu77zGSKqgThpGxUIokghFPHsheuxVr2/2fmPfHgPytFWDg7o88KAZSBc6M6wVks
	zRr8MuyWomwPHK+PTPWCUf5oSNjbkQMD7qhtcZpEh3qkKWj0xAIJeNBXB+/2HUmHG/ebcF
	k8/DHxGqJBpAEqcJtOrAIH6rtQ7KzK72vLyitVJTHxIQ1ba8OsxLx7Dsfq04afW6a3rm/j
	EHm7l6iwMycZM4rVQQTAMFdwvE0dijl7/RT508SD48i8dAdEsekk530QwApHtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537643;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8a1picuh9P3s86WqRXZ3ttl8F1UItJYIA/F52c/gcds=;
	b=LkBEtvTKB86G9UNPZySUb4TT3tO0Kks9chXXTk57U8MtQgyLpEkoz6GxteFzkayftG0cs1
	f2KiKTB3B5PVXkBA==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] irqchip: Switch to of_fwnode_handle()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Antonio Borneo <antonio.borneo@foss.st.com>,
 Herve Codina <herve.codina@bootlin.com>, Anup Patel <anup@brainfault.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-7-jirislaby@kernel.org>
References: <20250319092951.37667-7-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174653764302.406.2791768447454724239.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     0d646609ddee42b5be164ee39992f764edd3de40
Gitweb:        https://git.kernel.org/tip/0d646609ddee42b5be164ee39992f764edd3de40
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:28:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:03 +02:00

irqchip: Switch to of_fwnode_handle()

of_node_to_fwnode() is irqdomain's reimplementation of the "officially"
defined of_fwnode_handle(). The former is in the process of being
removed, so use the latter instead.

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Antonio Borneo <antonio.borneo@foss.st.com>
Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Herve Codina <herve.codina@bootlin.com> # irq-lan966x-oic
Link: https://lore.kernel.org/all/20250319092951.37667-7-jirislaby@kernel.org

---
 drivers/irqchip/irq-alpine-msi.c            | 2 +-
 drivers/irqchip/irq-apple-aic.c             | 4 ++--
 drivers/irqchip/irq-armada-370-xp.c         | 4 ++--
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 2 +-
 drivers/irqchip/irq-gic-v3.c                | 4 ++--
 drivers/irqchip/irq-ixp4xx.c                | 2 +-
 drivers/irqchip/irq-lan966x-oic.c           | 2 +-
 drivers/irqchip/irq-loongarch-cpu.c         | 2 +-
 drivers/irqchip/irq-loongson-eiointc.c      | 2 +-
 drivers/irqchip/irq-loongson-htvec.c        | 2 +-
 drivers/irqchip/irq-loongson-liointc.c      | 2 +-
 drivers/irqchip/irq-loongson-pch-msi.c      | 2 +-
 drivers/irqchip/irq-loongson-pch-pic.c      | 2 +-
 drivers/irqchip/irq-ls-scfg-msi.c           | 2 +-
 drivers/irqchip/irq-meson-gpio.c            | 2 +-
 drivers/irqchip/irq-mvebu-gicp.c            | 2 +-
 drivers/irqchip/irq-mvebu-odmi.c            | 2 +-
 drivers/irqchip/irq-mvebu-sei.c             | 6 +++---
 drivers/irqchip/irq-qcom-mpm.c              | 2 +-
 drivers/irqchip/irq-riscv-intc.c            | 2 +-
 drivers/irqchip/irq-sni-exiu.c              | 2 +-
 drivers/irqchip/irq-stm32mp-exti.c          | 2 +-
 drivers/irqchip/irq-ti-sci-inta.c           | 4 ++--
 drivers/irqchip/irq-ti-sci-intr.c           | 2 +-
 drivers/irqchip/irq-uniphier-aidet.c        | 2 +-
 25 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
index a1430ab..0207d35 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -213,7 +213,7 @@ static int alpine_msix_init_domains(struct alpine_msix_data *priv,
 		return -ENOMEM;
 	}
 
-	msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(node),
+	msi_domain = pci_msi_create_irq_domain(of_fwnode_handle(node),
 					       &alpine_msix_domain_info,
 					       middle_domain);
 	if (!msi_domain) {
diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 974dc08..032d66d 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -1014,7 +1014,7 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 
 	irqc->info.die_stride = off - start_off;
 
-	irqc->hw_domain = irq_domain_create_tree(of_node_to_fwnode(node),
+	irqc->hw_domain = irq_domain_create_tree(of_fwnode_handle(node),
 						 &aic_irq_domain_ops, irqc);
 	if (WARN_ON(!irqc->hw_domain))
 		goto err_unmap;
@@ -1067,7 +1067,7 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 
 	if (is_kernel_in_hyp_mode()) {
 		struct irq_fwspec mi = {
-			.fwnode		= of_node_to_fwnode(node),
+			.fwnode		= of_fwnode_handle(node),
 			.param_count	= 3,
 			.param		= {
 				[0]	= AIC_FIQ, /* This is a lie */
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 2aa6a51..de98d16 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -353,7 +353,7 @@ static int __init mpic_msi_init(struct mpic *mpic, struct device_node *node,
 	if (!mpic->msi_inner_domain)
 		return -ENOMEM;
 
-	mpic->msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(node), &mpic_msi_domain_info,
+	mpic->msi_domain = pci_msi_create_irq_domain(of_fwnode_handle(node), &mpic_msi_domain_info,
 						     mpic->msi_inner_domain);
 	if (!mpic->msi_domain) {
 		irq_domain_remove(mpic->msi_inner_domain);
@@ -492,7 +492,7 @@ static int __init mpic_ipi_init(struct mpic *mpic, struct device_node *node)
 {
 	int base_ipi;
 
-	mpic->ipi_domain = irq_domain_create_linear(of_node_to_fwnode(node), IPI_DOORBELL_NR,
+	mpic->ipi_domain = irq_domain_create_linear(of_fwnode_handle(node), IPI_DOORBELL_NR,
 						    &mpic_ipi_domain_ops, mpic);
 	if (WARN_ON(!mpic->ipi_domain))
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
index 8e87fc3..11549d8 100644
--- a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
@@ -152,7 +152,7 @@ static void __init its_fsl_mc_of_msi_init(void)
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
 
-		its_fsl_mc_msi_init_one(of_node_to_fwnode(np),
+		its_fsl_mc_msi_init_one(of_fwnode_handle(np),
 					np->full_name);
 	}
 }
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 270d7a4..efc791c 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1826,7 +1826,7 @@ static int partition_domain_translate(struct irq_domain *d,
 
 	ppi_idx = __gic_get_ppi_index(ppi_intid);
 	ret = partition_translate_id(gic_data.ppi_descs[ppi_idx],
-				     of_node_to_fwnode(np));
+				     of_fwnode_handle(np));
 	if (ret < 0)
 		return ret;
 
@@ -2192,7 +2192,7 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 
 		part = &parts[part_idx];
 
-		part->partition_id = of_node_to_fwnode(child_part);
+		part->partition_id = of_fwnode_handle(child_part);
 
 		pr_info("GIC: PPI partition %pOFn[%d] { ",
 			child_part, part_idx);
diff --git a/drivers/irqchip/irq-ixp4xx.c b/drivers/irqchip/irq-ixp4xx.c
index f23b02f..a9a5a52 100644
--- a/drivers/irqchip/irq-ixp4xx.c
+++ b/drivers/irqchip/irq-ixp4xx.c
@@ -261,7 +261,7 @@ static int __init ixp4xx_of_init_irq(struct device_node *np,
 		pr_crit("IXP4XX: could not ioremap interrupt controller\n");
 		return -ENODEV;
 	}
-	fwnode = of_node_to_fwnode(np);
+	fwnode = of_fwnode_handle(np);
 
 	/* These chip variants have 64 interrupts */
 	is_356 = of_device_is_compatible(np, "intel,ixp43x-interrupt") ||
diff --git a/drivers/irqchip/irq-lan966x-oic.c b/drivers/irqchip/irq-lan966x-oic.c
index 41ac880..9445c3a 100644
--- a/drivers/irqchip/irq-lan966x-oic.c
+++ b/drivers/irqchip/irq-lan966x-oic.c
@@ -224,7 +224,7 @@ static int lan966x_oic_probe(struct platform_device *pdev)
 		.exit		= lan966x_oic_chip_exit,
 	};
 	struct irq_domain_info d_info = {
-		.fwnode		= of_node_to_fwnode(pdev->dev.of_node),
+		.fwnode		= of_fwnode_handle(pdev->dev.of_node),
 		.domain_flags	= IRQ_DOMAIN_FLAG_DESTROY_GC,
 		.size		= LAN966X_OIC_NR_IRQ,
 		.hwirq_max	= LAN966X_OIC_NR_IRQ,
diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index e62dab4..950bc08 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -100,7 +100,7 @@ static const struct irq_domain_ops loongarch_cpu_intc_irq_domain_ops = {
 static int __init cpuintc_of_init(struct device_node *of_node,
 				struct device_node *parent)
 {
-	cpuintc_handle = of_node_to_fwnode(of_node);
+	cpuintc_handle = of_fwnode_handle(of_node);
 
 	irq_domain = irq_domain_create_linear(cpuintc_handle, EXCCODE_INT_NUM,
 				&loongarch_cpu_intc_irq_domain_ops, NULL);
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index bb79e19..b2860eb 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -554,7 +554,7 @@ static int __init eiointc_of_init(struct device_node *of_node,
 		priv->vec_count = VEC_COUNT;
 
 	priv->node = 0;
-	priv->domain_handle = of_node_to_fwnode(of_node);
+	priv->domain_handle = of_fwnode_handle(of_node);
 
 	ret = eiointc_init(priv, parent_irq, 0);
 	if (ret < 0)
diff --git a/drivers/irqchip/irq-loongson-htvec.c b/drivers/irqchip/irq-loongson-htvec.c
index 5da02c7..d8558eb 100644
--- a/drivers/irqchip/irq-loongson-htvec.c
+++ b/drivers/irqchip/irq-loongson-htvec.c
@@ -248,7 +248,7 @@ static int htvec_of_init(struct device_node *node,
 	}
 
 	err = htvec_init(res.start, resource_size(&res),
-			num_parents, parent_irq, of_node_to_fwnode(node));
+			num_parents, parent_irq, of_fwnode_handle(node));
 	if (err < 0)
 		return err;
 
diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 2b1bd4a..95cade5 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -363,7 +363,7 @@ static int __init liointc_of_init(struct device_node *node,
 	}
 
 	err = liointc_init(res.start, resource_size(&res),
-			revision, of_node_to_fwnode(node), node);
+			revision, of_fwnode_handle(node), node);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index 9c62108..c07876a 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -243,7 +243,7 @@ static int pch_msi_of_init(struct device_node *node, struct device_node *parent)
 		return -EINVAL;
 	}
 
-	err = pch_msi_init(res.start, irq_base, irq_count, parent_domain, of_node_to_fwnode(node));
+	err = pch_msi_init(res.start, irq_base, irq_count, parent_domain, of_fwnode_handle(node));
 	if (err < 0)
 		return err;
 
diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index 69efda3..62e6bf3 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -392,7 +392,7 @@ static int pch_pic_of_init(struct device_node *node,
 	}
 
 	err = pch_pic_init(res.start, resource_size(&res), vec_base,
-				parent_domain, of_node_to_fwnode(node), 0);
+				parent_domain, of_fwnode_handle(node), 0);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index 3cb8079..cbe11a8 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -225,7 +225,7 @@ static int ls_scfg_msi_domains_init(struct ls_scfg_msi *msi_data)
 	}
 
 	msi_data->msi_domain = pci_msi_create_irq_domain(
-				of_node_to_fwnode(msi_data->pdev->dev.of_node),
+				of_fwnode_handle(msi_data->pdev->dev.of_node),
 				&ls_scfg_msi_domain_info,
 				msi_data->parent);
 	if (!msi_data->msi_domain) {
diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 0a25536..7d17762 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -607,7 +607,7 @@ static int meson_gpio_irq_of_init(struct device_node *node, struct device_node *
 
 	domain = irq_domain_create_hierarchy(parent_domain, 0,
 					     ctl->params->nr_hwirq,
-					     of_node_to_fwnode(node),
+					     of_fwnode_handle(node),
 					     &meson_gpio_irq_domain_ops,
 					     ctl);
 	if (!domain) {
diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gicp.c
index d67f93f..521cc26 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -232,7 +232,7 @@ static int mvebu_gicp_probe(struct platform_device *pdev)
 
 	inner_domain = irq_domain_create_hierarchy(parent_domain, 0,
 						   gicp->spi_cnt,
-						   of_node_to_fwnode(node),
+						   of_fwnode_handle(node),
 						   &gicp_domain_ops, gicp);
 	if (!inner_domain)
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu-odmi.c
index 28f7e81..c1fcd45 100644
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -207,7 +207,7 @@ static int __init mvebu_odmi_init(struct device_node *node,
 
 	inner_domain = irq_domain_create_hierarchy(parent_domain, 0,
 						   odmis_count * NODMIS_PER_FRAME,
-						   of_node_to_fwnode(node),
+						   of_fwnode_handle(node),
 						   &odmi_domain_ops, NULL);
 	if (!inner_domain) {
 		ret = -ENOMEM;
diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index ebd4a90..5030fce 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -402,7 +402,7 @@ static int mvebu_sei_probe(struct platform_device *pdev)
 	}
 
 	/* Create the root SEI domain */
-	sei->sei_domain = irq_domain_create_linear(of_node_to_fwnode(node),
+	sei->sei_domain = irq_domain_create_linear(of_fwnode_handle(node),
 						   (sei->caps->ap_range.size +
 						    sei->caps->cp_range.size),
 						   &mvebu_sei_domain_ops,
@@ -418,7 +418,7 @@ static int mvebu_sei_probe(struct platform_device *pdev)
 	/* Create the 'wired' domain */
 	sei->ap_domain = irq_domain_create_hierarchy(sei->sei_domain, 0,
 						     sei->caps->ap_range.size,
-						     of_node_to_fwnode(node),
+						     of_fwnode_handle(node),
 						     &mvebu_sei_ap_domain_ops,
 						     sei);
 	if (!sei->ap_domain) {
@@ -432,7 +432,7 @@ static int mvebu_sei_probe(struct platform_device *pdev)
 	/* Create the 'MSI' domain */
 	sei->cp_domain = irq_domain_create_hierarchy(sei->sei_domain, 0,
 						     sei->caps->cp_range.size,
-						     of_node_to_fwnode(node),
+						     of_fwnode_handle(node),
 						     &mvebu_sei_cp_domain_ops,
 						     sei);
 	if (!sei->cp_domain) {
diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
index 7942d8e..00c770e 100644
--- a/drivers/irqchip/irq-qcom-mpm.c
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -447,7 +447,7 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 
 	priv->domain = irq_domain_create_hierarchy(parent_domain,
 				IRQ_DOMAIN_FLAG_QCOM_MPM_WAKEUP, pin_cnt,
-				of_node_to_fwnode(np), &qcom_mpm_ops, priv);
+				of_fwnode_handle(np), &qcom_mpm_ops, priv);
 	if (!priv->domain) {
 		dev_err(dev, "failed to create MPM domain\n");
 		ret = -ENOMEM;
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index f653c13..e580588 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -242,7 +242,7 @@ static int __init riscv_intc_init(struct device_node *node,
 		chip = &andes_intc_chip;
 	}
 
-	return riscv_intc_init_common(of_node_to_fwnode(node), chip);
+	return riscv_intc_init_common(of_fwnode_handle(node), chip);
 }
 
 IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
diff --git a/drivers/irqchip/irq-sni-exiu.c b/drivers/irqchip/irq-sni-exiu.c
index c7db617..7d10bf6 100644
--- a/drivers/irqchip/irq-sni-exiu.c
+++ b/drivers/irqchip/irq-sni-exiu.c
@@ -249,7 +249,7 @@ static int __init exiu_dt_init(struct device_node *node,
 		return -ENXIO;
 	}
 
-	data = exiu_init(of_node_to_fwnode(node), &res);
+	data = exiu_init(of_fwnode_handle(node), &res);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
diff --git a/drivers/irqchip/irq-stm32mp-exti.c b/drivers/irqchip/irq-stm32mp-exti.c
index cb83d6c..649b84f 100644
--- a/drivers/irqchip/irq-stm32mp-exti.c
+++ b/drivers/irqchip/irq-stm32mp-exti.c
@@ -531,7 +531,7 @@ static int stm32mp_exti_domain_alloc(struct irq_domain *dm,
 		if (ret)
 			return ret;
 		/* we only support one parent, so far */
-		if (of_node_to_fwnode(out_irq.np) != dm->parent->fwnode)
+		if (of_fwnode_handle(out_irq.np) != dm->parent->fwnode)
 			return -EINVAL;
 
 		of_phandle_args_to_fwspec(out_irq.np, out_irq.args,
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index a887efb..38dfc1f 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -233,7 +233,7 @@ static struct ti_sci_inta_vint_desc *ti_sci_inta_alloc_parent_irq(struct irq_dom
 	INIT_LIST_HEAD(&vint_desc->list);
 
 	parent_node = of_irq_find_parent(dev_of_node(&inta->pdev->dev));
-	parent_fwspec.fwnode = of_node_to_fwnode(parent_node);
+	parent_fwspec.fwnode = of_fwnode_handle(parent_node);
 
 	if (of_device_is_compatible(parent_node, "arm,gic-v3")) {
 		/* Parent is GIC */
@@ -709,7 +709,7 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	msi_domain = ti_sci_inta_msi_create_irq_domain(of_node_to_fwnode(node),
+	msi_domain = ti_sci_inta_msi_create_irq_domain(of_fwnode_handle(node),
 						&ti_sci_inta_msi_domain_info,
 						domain);
 	if (!msi_domain) {
diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
index b49a731..686a8f6 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -149,7 +149,7 @@ static int ti_sci_intr_alloc_parent_irq(struct irq_domain *domain,
 		goto err_irqs;
 
 	parent_node = of_irq_find_parent(dev_of_node(intr->dev));
-	fwspec.fwnode = of_node_to_fwnode(parent_node);
+	fwspec.fwnode = of_fwnode_handle(parent_node);
 
 	if (of_device_is_compatible(parent_node, "arm,gic-v3")) {
 		/* Parent is GIC */
diff --git a/drivers/irqchip/irq-uniphier-aidet.c b/drivers/irqchip/irq-uniphier-aidet.c
index 601f934..6005c2d 100644
--- a/drivers/irqchip/irq-uniphier-aidet.c
+++ b/drivers/irqchip/irq-uniphier-aidet.c
@@ -188,7 +188,7 @@ static int uniphier_aidet_probe(struct platform_device *pdev)
 	priv->domain = irq_domain_create_hierarchy(
 					parent_domain, 0,
 					UNIPHIER_AIDET_NR_IRQS,
-					of_node_to_fwnode(dev->of_node),
+					of_fwnode_handle(dev->of_node),
 					&uniphier_aidet_domain_ops, priv);
 	if (!priv->domain)
 		return -ENOMEM;

