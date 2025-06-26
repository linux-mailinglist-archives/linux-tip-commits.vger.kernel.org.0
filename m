Return-Path: <linux-tip-commits+bounces-5928-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7988AEA017
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 16:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABE9D7B6FA8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 14:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B83B2EB5DC;
	Thu, 26 Jun 2025 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TPvwvoha";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dNYHun/c"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518932E92A0;
	Thu, 26 Jun 2025 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947192; cv=none; b=ibgmKHhce3fTgMPML2fCMJZffo8zuaH+s6fiXtoV7npLxd7OwtuqCNuk+E6QtvFw6zTNRNqLEy9FiQ6gxkkoAwGK5ZpveTssHorJQkLQlh9k0Yu1zIj3NsnHTL0cTsEW9GRYk23ekpMpYS6Q5YJ6RQk6ZefDNd2Ou0MM1eGP2cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947192; c=relaxed/simple;
	bh=g1OwJY2fFLunGVHvvsPzH0zpnAmbmwM1BtqhcXQrPZg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eecr3HoDCRWV+IhTBY7M979gm0OojHneFQV257la4YroprylMtojFCHe3tDxAhIo3FwDYOe3MeqHWfmTUdg4RmLTlrvoMjKycYd6K29hMXPrexbaDe4LpumnDAHti8gi855DtvAqT+Ho0+4an8x4pVJZfzGFvIyO7Y56sSwSQtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TPvwvoha; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dNYHun/c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Jun 2025 14:13:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750947188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZLS0hLScl5o5namZpP1lObsXexoAnJ911yUHgaWwPQ=;
	b=TPvwvoha4LjQ3vduVN51+lcrFI8ojhSNDDfgKEbU75jsUKzoiBJCVQcFUPMXvk6iGaZkub
	08+xOSyHpRu7qL+IzEeeGGDKLzh/aj/DtUYhWbVJaTCyzGZp7DPqabBgpk4wjSJBvnwvNV
	M9HhkajBqZVhkE4XKROheXy6so4WkVmz8IoKduuBAZcZoMa+Cp60igMHBLgBiTm1JoDuGJ
	3z5chQ1MfzbTL13BE828/RgDsQxMVSBdr4KXyg9ZjMD45UKtNTTcUxyJmUZYKtkaLpL03i
	MdS0MycQcbVbpxteVdL+9cpqmCitHA+18XSjyn+zgPHKbeEAmBU+qoQTwSTrGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750947188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZLS0hLScl5o5namZpP1lObsXexoAnJ911yUHgaWwPQ=;
	b=dNYHun/cUtMVxB5AhE7DdSeRgrjTsjX60iXBbyQVflnxkliwPYaIAxYTyQEw10nYuOWYCk
	8qeUyxy6Yl7k8pCA==
From: "tip-bot2 for Vladimir Kondratiev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/thead-c900-aclint-sswi: Generalize
 aclint-sswi driver and add MIPS P800 support
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250612143911.3224046-5-vladimir.kondratiev@mobileye.com>
References: <20250612143911.3224046-5-vladimir.kondratiev@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175094718748.406.6115783866035716068.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     df0f030ee7e444c55341f4210124115878284125
Gitweb:        https://git.kernel.org/tip/df0f030ee7e444c55341f4210124115878284125
Author:        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
AuthorDate:    Thu, 12 Jun 2025 17:39:08 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 26 Jun 2025 16:06:40 +02:00

irqchip/thead-c900-aclint-sswi: Generalize aclint-sswi driver and add MIPS P800 support

Refactor the Thead specific implementation of the ACLINT-SSWI irqchip:

 - Rename the source file and related details to reflect the generic nature
   of the driver

 - Factor out the generic code that serves both Thead and MIPS variants.
   This generic part is compliant with the RISC-V draft spec [1]

 - Provide generic and Thead specific initialization functions

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250612143911.3224046-5-vladimir.kondratiev@mobileye.com
Link: https://github.com/riscvarchive/riscv-aclint [1]
---
 drivers/irqchip/Kconfig                      |  15 +-
 drivers/irqchip/Makefile                     |   2 +-
 drivers/irqchip/irq-aclint-sswi.c            | 208 ++++++++++++++++++-
 drivers/irqchip/irq-thead-c900-aclint-sswi.c | 176 +---------------
 include/linux/cpuhotplug.h                   |   2 +-
 5 files changed, 221 insertions(+), 182 deletions(-)
 create mode 100644 drivers/irqchip/irq-aclint-sswi.c
 delete mode 100644 drivers/irqchip/irq-thead-c900-aclint-sswi.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 0d196e4..39f6f42 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -634,18 +634,25 @@ config STARFIVE_JH8100_INTC
 
 	  If you don't know what to do here, say Y.
 
-config THEAD_C900_ACLINT_SSWI
-	bool "THEAD C9XX ACLINT S-mode IPI Interrupt Controller"
+config ACLINT_SSWI
+	bool "RISC-V ACLINT S-mode IPI Interrupt Controller"
 	depends on RISCV
 	depends on SMP
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_IPI_MUX
 	help
-	  This enables support for T-HEAD specific ACLINT SSWI device
-	  support.
+	  This enables support for variants of the RISC-V ACLINT-SSWI device.
+	  Supported variants are:
+	  - T-HEAD, with compatible "thead,c900-aclint-sswi"
+	  - MIPS P8700, with compatible "mips,p8700-aclint-sswi"
 
 	  If you don't know what to do here, say Y.
 
+# Backwards compatibility so oldconfig does not drop it.
+config THEAD_C900_ACLINT_SSWI
+	bool
+	select ACLINT_SSWI
+
 config EXYNOS_IRQ_COMBINER
 	bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
 	depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 23ca495..0458d6c 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -105,7 +105,7 @@ obj-$(CONFIG_RISCV_APLIC_MSI)		+= irq-riscv-aplic-msi.o
 obj-$(CONFIG_RISCV_IMSIC)		+= irq-riscv-imsic-state.o irq-riscv-imsic-early.o irq-riscv-imsic-platform.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_STARFIVE_JH8100_INTC)	+= irq-starfive-jh8100-intc.o
-obj-$(CONFIG_THEAD_C900_ACLINT_SSWI)	+= irq-thead-c900-aclint-sswi.o
+obj-$(CONFIG_ACLINT_SSWI)		+= irq-aclint-sswi.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
 obj-$(CONFIG_IMX_INTMUX)		+= irq-imx-intmux.o
 obj-$(CONFIG_IMX_MU_MSI)		+= irq-imx-mu-msi.o
diff --git a/drivers/irqchip/irq-aclint-sswi.c b/drivers/irqchip/irq-aclint-sswi.c
new file mode 100644
index 0000000..0131194
--- /dev/null
+++ b/drivers/irqchip/irq-aclint-sswi.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Inochi Amaoto <inochiama@gmail.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cpu.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/pci.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <linux/string_choices.h>
+#include <asm/sbi.h>
+#include <asm/vendorid_list.h>
+
+static int sswi_ipi_virq __ro_after_init;
+static DEFINE_PER_CPU(void __iomem *, sswi_cpu_regs);
+
+static void aclint_sswi_ipi_send(unsigned int cpu)
+{
+	writel(0x1, per_cpu(sswi_cpu_regs, cpu));
+}
+
+static void aclint_sswi_ipi_clear(void)
+{
+	writel_relaxed(0x0, this_cpu_read(sswi_cpu_regs));
+}
+
+static void aclint_sswi_ipi_handle(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	chained_irq_enter(chip, desc);
+
+	csr_clear(CSR_IP, IE_SIE);
+	aclint_sswi_ipi_clear();
+
+	ipi_mux_process();
+
+	chained_irq_exit(chip, desc);
+}
+
+static int aclint_sswi_starting_cpu(unsigned int cpu)
+{
+	enable_percpu_irq(sswi_ipi_virq, irq_get_trigger_type(sswi_ipi_virq));
+
+	return 0;
+}
+
+static int aclint_sswi_dying_cpu(unsigned int cpu)
+{
+	aclint_sswi_ipi_clear();
+
+	disable_percpu_irq(sswi_ipi_virq);
+
+	return 0;
+}
+
+static int __init aclint_sswi_parse_irq(struct fwnode_handle *fwnode, void __iomem *reg)
+{
+	struct of_phandle_args parent;
+	unsigned long hartid;
+	u32 contexts, i;
+	int rc, cpu;
+
+	contexts = of_irq_count(to_of_node(fwnode));
+	if (!(contexts)) {
+		pr_err("%pfwP: no ACLINT SSWI context available\n", fwnode);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < contexts; i++) {
+		rc = of_irq_parse_one(to_of_node(fwnode), i, &parent);
+		if (rc)
+			return rc;
+
+		rc = riscv_of_parent_hartid(parent.np, &hartid);
+		if (rc)
+			return rc;
+
+		if (parent.args[0] != RV_IRQ_SOFT)
+			return -ENOTSUPP;
+
+		cpu = riscv_hartid_to_cpuid(hartid);
+
+		per_cpu(sswi_cpu_regs, cpu) = reg + hart_index * 4;
+	}
+
+	pr_info("%pfwP: register %u CPU%s\n", fwnode, contexts, str_plural(contexts));
+
+	return 0;
+}
+
+static int __init aclint_sswi_probe(struct fwnode_handle *fwnode)
+{
+	struct irq_domain *domain;
+	void __iomem *reg;
+	int virq, rc;
+
+	if (!is_of_node(fwnode))
+		return -EINVAL;
+
+	reg = of_iomap(to_of_node(fwnode), 0);
+	if (!reg)
+		return -ENOMEM;
+
+	/* Parse SSWI setting */
+	rc = aclint_sswi_parse_irq(fwnode, reg);
+	if (rc < 0)
+		return rc;
+
+	/* If mulitple SSWI devices are present, do not register irq again */
+	if (sswi_ipi_virq)
+		return 0;
+
+	/* Find riscv intc domain and create IPI irq mapping */
+	domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_ANY);
+	if (!domain) {
+		pr_err("%pfwP: Failed to find INTC domain\n", fwnode);
+		return -ENOENT;
+	}
+
+	sswi_ipi_virq = irq_create_mapping(domain, RV_IRQ_SOFT);
+	if (!sswi_ipi_virq) {
+		pr_err("unable to create ACLINT SSWI IRQ mapping\n");
+		return -ENOMEM;
+	}
+
+	/* Register SSWI irq and handler */
+	virq = ipi_mux_create(BITS_PER_BYTE, aclint_sswi_ipi_send);
+	if (virq <= 0) {
+		pr_err("unable to create muxed IPIs\n");
+		irq_dispose_mapping(sswi_ipi_virq);
+		return virq < 0 ? virq : -ENOMEM;
+	}
+
+	irq_set_chained_handler(sswi_ipi_virq, aclint_sswi_ipi_handle);
+
+	cpuhp_setup_state(CPUHP_AP_IRQ_ACLINT_SSWI_STARTING,
+			  "irqchip/aclint-sswi:starting",
+			  aclint_sswi_starting_cpu,
+			  aclint_sswi_dying_cpu);
+
+	riscv_ipi_set_virq_range(virq, BITS_PER_BYTE);
+
+	return 0;
+}
+
+/* generic/MIPS variant */
+static int __init generic_aclint_sswi_probe(struct fwnode_handle *fwnode)
+{
+	int rc;
+
+	rc = aclint_sswi_probe(fwnode);
+	if (rc)
+		return rc;
+
+	/* Announce that SSWI is providing IPIs */
+	pr_info("providing IPIs using ACLINT SSWI\n");
+
+	return 0;
+}
+
+static int __init generic_aclint_sswi_early_probe(struct device_node *node,
+						  struct device_node *parent)
+{
+	return generic_aclint_sswi_probe(&node->fwnode);
+}
+IRQCHIP_DECLARE(generic_aclint_sswi, "mips,p8700-aclint-sswi", generic_aclint_sswi_early_probe);
+
+/* THEAD variant */
+#define THEAD_C9XX_CSR_SXSTATUS			0x5c0
+#define THEAD_C9XX_SXSTATUS_CLINTEE		BIT(17)
+
+static int __init thead_aclint_sswi_probe(struct fwnode_handle *fwnode)
+{
+	int rc;
+
+	/* If it is T-HEAD CPU, check whether SSWI is enabled */
+	if (riscv_cached_mvendorid(0) == THEAD_VENDOR_ID &&
+	    !(csr_read(THEAD_C9XX_CSR_SXSTATUS) & THEAD_C9XX_SXSTATUS_CLINTEE))
+		return -ENOTSUPP;
+
+	rc = aclint_sswi_probe(fwnode);
+	if (rc)
+		return rc;
+
+	/* Announce that SSWI is providing IPIs */
+	pr_info("providing IPIs using THEAD ACLINT SSWI\n");
+
+	return 0;
+}
+
+static int __init thead_aclint_sswi_early_probe(struct device_node *node,
+						struct device_node *parent)
+{
+	return thead_aclint_sswi_probe(&node->fwnode);
+}
+IRQCHIP_DECLARE(thead_aclint_sswi, "thead,c900-aclint-sswi", thead_aclint_sswi_early_probe);
diff --git a/drivers/irqchip/irq-thead-c900-aclint-sswi.c b/drivers/irqchip/irq-thead-c900-aclint-sswi.c
deleted file mode 100644
index 8ff6e7a..0000000
--- a/drivers/irqchip/irq-thead-c900-aclint-sswi.c
+++ /dev/null
@@ -1,176 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2024 Inochi Amaoto <inochiama@gmail.com>
- */
-
-#define pr_fmt(fmt) "thead-c900-aclint-sswi: " fmt
-#include <linux/cpu.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/irq.h>
-#include <linux/irqchip.h>
-#include <linux/irqchip/chained_irq.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/pci.h>
-#include <linux/spinlock.h>
-#include <linux/smp.h>
-#include <linux/string_choices.h>
-#include <asm/sbi.h>
-#include <asm/vendorid_list.h>
-
-#define THEAD_ACLINT_xSWI_REGISTER_SIZE		4
-
-#define THEAD_C9XX_CSR_SXSTATUS			0x5c0
-#define THEAD_C9XX_SXSTATUS_CLINTEE		BIT(17)
-
-static int sswi_ipi_virq __ro_after_init;
-static DEFINE_PER_CPU(void __iomem *, sswi_cpu_regs);
-
-static void thead_aclint_sswi_ipi_send(unsigned int cpu)
-{
-	writel(0x1, per_cpu(sswi_cpu_regs, cpu));
-}
-
-static void thead_aclint_sswi_ipi_clear(void)
-{
-	writel_relaxed(0x0, this_cpu_read(sswi_cpu_regs));
-}
-
-static void thead_aclint_sswi_ipi_handle(struct irq_desc *desc)
-{
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-
-	chained_irq_enter(chip, desc);
-
-	csr_clear(CSR_IP, IE_SIE);
-	thead_aclint_sswi_ipi_clear();
-
-	ipi_mux_process();
-
-	chained_irq_exit(chip, desc);
-}
-
-static int thead_aclint_sswi_starting_cpu(unsigned int cpu)
-{
-	enable_percpu_irq(sswi_ipi_virq, irq_get_trigger_type(sswi_ipi_virq));
-
-	return 0;
-}
-
-static int thead_aclint_sswi_dying_cpu(unsigned int cpu)
-{
-	thead_aclint_sswi_ipi_clear();
-
-	disable_percpu_irq(sswi_ipi_virq);
-
-	return 0;
-}
-
-static int __init thead_aclint_sswi_parse_irq(struct fwnode_handle *fwnode,
-					      void __iomem *reg)
-{
-	struct of_phandle_args parent;
-	unsigned long hartid;
-	u32 contexts, i;
-	int rc, cpu;
-
-	contexts = of_irq_count(to_of_node(fwnode));
-	if (!(contexts)) {
-		pr_err("%pfwP: no ACLINT SSWI context available\n", fwnode);
-		return -EINVAL;
-	}
-
-	for (i = 0; i < contexts; i++) {
-		rc = of_irq_parse_one(to_of_node(fwnode), i, &parent);
-		if (rc)
-			return rc;
-
-		rc = riscv_of_parent_hartid(parent.np, &hartid);
-		if (rc)
-			return rc;
-
-		if (parent.args[0] != RV_IRQ_SOFT)
-			return -ENOTSUPP;
-
-		cpu = riscv_hartid_to_cpuid(hartid);
-
-		per_cpu(sswi_cpu_regs, cpu) = reg + i * THEAD_ACLINT_xSWI_REGISTER_SIZE;
-	}
-
-	pr_info("%pfwP: register %u CPU%s\n", fwnode, contexts, str_plural(contexts));
-
-	return 0;
-}
-
-static int __init thead_aclint_sswi_probe(struct fwnode_handle *fwnode)
-{
-	struct irq_domain *domain;
-	void __iomem *reg;
-	int virq, rc;
-
-	/* If it is T-HEAD CPU, check whether SSWI is enabled */
-	if (riscv_cached_mvendorid(0) == THEAD_VENDOR_ID &&
-	    !(csr_read(THEAD_C9XX_CSR_SXSTATUS) & THEAD_C9XX_SXSTATUS_CLINTEE))
-		return -ENOTSUPP;
-
-	if (!is_of_node(fwnode))
-		return -EINVAL;
-
-	reg = of_iomap(to_of_node(fwnode), 0);
-	if (!reg)
-		return -ENOMEM;
-
-	/* Parse SSWI setting */
-	rc = thead_aclint_sswi_parse_irq(fwnode, reg);
-	if (rc < 0)
-		return rc;
-
-	/* If mulitple SSWI devices are present, do not register irq again */
-	if (sswi_ipi_virq)
-		return 0;
-
-	/* Find riscv intc domain and create IPI irq mapping */
-	domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_ANY);
-	if (!domain) {
-		pr_err("%pfwP: Failed to find INTC domain\n", fwnode);
-		return -ENOENT;
-	}
-
-	sswi_ipi_virq = irq_create_mapping(domain, RV_IRQ_SOFT);
-	if (!sswi_ipi_virq) {
-		pr_err("unable to create ACLINT SSWI IRQ mapping\n");
-		return -ENOMEM;
-	}
-
-	/* Register SSWI irq and handler */
-	virq = ipi_mux_create(BITS_PER_BYTE, thead_aclint_sswi_ipi_send);
-	if (virq <= 0) {
-		pr_err("unable to create muxed IPIs\n");
-		irq_dispose_mapping(sswi_ipi_virq);
-		return virq < 0 ? virq : -ENOMEM;
-	}
-
-	irq_set_chained_handler(sswi_ipi_virq, thead_aclint_sswi_ipi_handle);
-
-	cpuhp_setup_state(CPUHP_AP_IRQ_THEAD_ACLINT_SSWI_STARTING,
-			  "irqchip/thead-aclint-sswi:starting",
-			  thead_aclint_sswi_starting_cpu,
-			  thead_aclint_sswi_dying_cpu);
-
-	riscv_ipi_set_virq_range(virq, BITS_PER_BYTE);
-
-	/* Announce that SSWI is providing IPIs */
-	pr_info("providing IPIs using THEAD ACLINT SSWI\n");
-
-	return 0;
-}
-
-static int __init thead_aclint_sswi_early_probe(struct device_node *node,
-						struct device_node *parent)
-{
-	return thead_aclint_sswi_probe(&node->fwnode);
-}
-IRQCHIP_DECLARE(thead_aclint_sswi, "thead,c900-aclint-sswi", thead_aclint_sswi_early_probe);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index df366ee..d381420 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -145,7 +145,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_EIOINTC_STARTING,
 	CPUHP_AP_IRQ_AVECINTC_STARTING,
 	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
-	CPUHP_AP_IRQ_THEAD_ACLINT_SSWI_STARTING,
+	CPUHP_AP_IRQ_ACLINT_SSWI_STARTING,
 	CPUHP_AP_IRQ_RISCV_IMSIC_STARTING,
 	CPUHP_AP_IRQ_RISCV_SBI_IPI_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,

