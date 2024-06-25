Return-Path: <linux-tip-commits+bounces-1532-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AD3915E5C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Jun 2024 07:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9CF1F22755
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Jun 2024 05:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3881DFF8;
	Tue, 25 Jun 2024 05:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PxAqz1Qf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pAOxEmuq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FC1101D5;
	Tue, 25 Jun 2024 05:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719294534; cv=none; b=CZqnthVnfl3WV6GJuSZDyCsINniz2W09sG090lK6PHlJF8c+uv8hmpAbV/R2XvvVMFBkQZ/KvLI4KOV0vUX360igdXbAg9RvA5wfB9P/ERwH20dquEkponno2sUBuJqw27pg5RVaTULbtTc2CBm4pVhrUdDwSk04xYZ3JoDo76I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719294534; c=relaxed/simple;
	bh=ZSUHbQxVvER3X95hl9Emqc22lPFWSpebFbMYVbWLBfs=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=fHAOv0rvlF3fx2ReuMaNKfD0/s3/JA0zoTxyZ+u4Zzi44UJ2ntFKEj8IOJrTfdlgd224V795LLdwm1OMfBZelu7kiUk62FqKexwQel3m65wHiimBw1h27hZ8cjd/gqt2+HgGh6YJp5cYHlsWZGZpBJvqE83RALIHu876Li+oiMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PxAqz1Qf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pAOxEmuq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Jun 2024 05:48:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719294523;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=RSDhqifayArQFRWU0fwTYbtmwrAizkGDwj6hlJYEofA=;
	b=PxAqz1QfezutcABN/iAcCrP8y0jfdiBm3NX11k+msQB5m8tIwCmRbGDHSDquqKKr5I4I+q
	bKoOHuRVVAZb3HStKwQuBoHM9VoVG1wlw+T1xTdaVyBYshNJWLgnwDoQGaac30ANqadd4U
	FTjEnL5RaeWq+IGx3GlXU84jKgDkA9H0Y6MolW2hZpus4B8MpoqfPGGVkZe2y0lu6OZEiD
	kmx1FQXi40Vvx6E3gdZx7mYfGH3ELnKpv2bnf3N8ae+6HDfNM8REM4Gts2LJm5/s3UPFin
	4hl5uKtC7eiFfmjFedKkWKS9bdIDWtgfIn23GyISZZrEFgUaZ6WVjRWLJqhbpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719294523;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=RSDhqifayArQFRWU0fwTYbtmwrAizkGDwj6hlJYEofA=;
	b=pAOxEmuq3VgAAV4X2xqe7wgYJxwnY1Mtu1zH1PEv51lLAq/5WGOgP69DJUav1j0Rye6Ryq
	b4Wgurrqk5ssIkCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] Revert "Loongarch: Support loongarch avec"
Cc: kernel test robot <lkp@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Tianyang Zhang <zhangtianyang@loongson.cn>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171929452267.10875.9377599213962545731.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     18db1b6dbbe576c283f69f3e925fbeb57de40855
Gitweb:        https://git.kernel.org/tip/18db1b6dbbe576c283f69f3e925fbeb57de40855
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 25 Jun 2024 07:40:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 25 Jun 2024 07:40:08 +02:00

Revert "Loongarch: Support loongarch avec"

This reverts commit 760d7e719499d64beea62bfcf53938fb233bb6e7.

This results in build failures and has other issues according to Tianyang.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tianyang Zhang <zhangtianyang@loongson.cn>
Closes: https://lore.kernel.org/oe-kbuild-all/202406240451.ygBFNyJ3-lkp@intel.com/
---
 arch/loongarch/Kconfig                    |   1 +-
 arch/loongarch/include/asm/cpu-features.h |   1 +-
 arch/loongarch/include/asm/cpu.h          |   2 +-
 arch/loongarch/include/asm/hw_irq.h       |  10 +-
 arch/loongarch/include/asm/irq.h          |  12 +-
 arch/loongarch/include/asm/loongarch.h    |  20 +-
 arch/loongarch/include/asm/smp.h          |   2 +-
 arch/loongarch/kernel/cpu-probe.c         |   3 +-
 arch/loongarch/kernel/smp.c               |   5 +-
 drivers/irqchip/Makefile                  |   2 +-
 drivers/irqchip/irq-loongarch-avec.c      | 419 +---------------------
 drivers/irqchip/irq-loongarch-cpu.c       |   4 +-
 drivers/irqchip/irq-loongson-eiointc.c    |   3 +-
 drivers/irqchip/irq-loongson-pch-msi.c    |  43 +--
 14 files changed, 10 insertions(+), 517 deletions(-)
 delete mode 100644 drivers/irqchip/irq-loongarch-avec.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index a66e49b..e38139c 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -83,7 +83,6 @@ config LOONGARCH
 	select GENERIC_ENTRY
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_IOREMAP if !ARCH_IOREMAP
-	select GENERIC_IRQ_MATRIX_ALLOCATOR
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
diff --git a/arch/loongarch/include/asm/cpu-features.h b/arch/loongarch/include/asm/cpu-features.h
index 16a716f..2eafe6a 100644
--- a/arch/loongarch/include/asm/cpu-features.h
+++ b/arch/loongarch/include/asm/cpu-features.h
@@ -65,6 +65,5 @@
 #define cpu_has_guestid		cpu_opt(LOONGARCH_CPU_GUESTID)
 #define cpu_has_hypervisor	cpu_opt(LOONGARCH_CPU_HYPERVISOR)
 #define cpu_has_ptw		cpu_opt(LOONGARCH_CPU_PTW)
-#define cpu_has_avecint		cpu_opt(LOONGARCH_CPU_AVECINT)
 
 #endif /* __ASM_CPU_FEATURES_H */
diff --git a/arch/loongarch/include/asm/cpu.h b/arch/loongarch/include/asm/cpu.h
index 843f9c4..48b9f71 100644
--- a/arch/loongarch/include/asm/cpu.h
+++ b/arch/loongarch/include/asm/cpu.h
@@ -99,7 +99,6 @@ enum cpu_type_enum {
 #define CPU_FEATURE_GUESTID		24	/* CPU has GuestID feature */
 #define CPU_FEATURE_HYPERVISOR		25	/* CPU has hypervisor (running in VM) */
 #define CPU_FEATURE_PTW			26	/* CPU has hardware page table walker */
-#define CPU_FEATURE_AVECINT		27	/* CPU has avec interrupt */
 
 #define LOONGARCH_CPU_CPUCFG		BIT_ULL(CPU_FEATURE_CPUCFG)
 #define LOONGARCH_CPU_LAM		BIT_ULL(CPU_FEATURE_LAM)
@@ -128,6 +127,5 @@ enum cpu_type_enum {
 #define LOONGARCH_CPU_GUESTID		BIT_ULL(CPU_FEATURE_GUESTID)
 #define LOONGARCH_CPU_HYPERVISOR	BIT_ULL(CPU_FEATURE_HYPERVISOR)
 #define LOONGARCH_CPU_PTW		BIT_ULL(CPU_FEATURE_PTW)
-#define LOONGARCH_CPU_AVECINT		BIT_ULL(CPU_FEATURE_AVECINT)
 
 #endif /* _ASM_CPU_H */
diff --git a/arch/loongarch/include/asm/hw_irq.h b/arch/loongarch/include/asm/hw_irq.h
index 772692e..af4f4e8 100644
--- a/arch/loongarch/include/asm/hw_irq.h
+++ b/arch/loongarch/include/asm/hw_irq.h
@@ -10,16 +10,6 @@
 extern atomic_t irq_err_count;
 
 /*
- * 256 vectors Map:
- *
- * 0 - 15: mapping legacy IPs, e.g. IP0-12.
- * 16 - 255: mapping a vector for external IRQ.
- *
- */
-#define NR_VECTORS		256
-#define IRQ_MATRIX_BITS		NR_VECTORS
-#define NR_LEGACY_VECTORS	16
-/*
  * interrupt-retrigger: NOP for now. This may not be appropriate for all
  * machines, we'll see ...
  */
diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index cf3b635..480418b 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -65,7 +65,7 @@ extern struct acpi_vector_group msi_group[MAX_IO_PICS];
 #define LOONGSON_LPC_LAST_IRQ		(LOONGSON_LPC_IRQ_BASE + 15)
 
 #define LOONGSON_CPU_IRQ_BASE		16
-#define LOONGSON_CPU_LAST_IRQ		(LOONGSON_CPU_IRQ_BASE + 15)
+#define LOONGSON_CPU_LAST_IRQ		(LOONGSON_CPU_IRQ_BASE + 14)
 
 #define LOONGSON_PCH_IRQ_BASE		64
 #define LOONGSON_PCH_ACPI_IRQ		(LOONGSON_PCH_IRQ_BASE + 47)
@@ -101,16 +101,6 @@ int pch_msi_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_msi_pic *acpi_pchmsi);
 int pch_pic_acpi_init(struct irq_domain *parent,
 					struct acpi_madt_bio_pic *acpi_pchpic);
-
-#ifdef CONFIG_ACPI
-int __init pch_msi_acpi_init_v2(struct irq_domain *parent,
-		struct acpi_madt_msi_pic *pch_msi_entry);
-int __init loongarch_avec_acpi_init(struct irq_domain *parent);
-void complete_irq_moving(void);
-void loongarch_avec_offline_cpu(unsigned int cpu);
-void loongarch_avec_online_cpu(unsigned int cpu);
-#endif
-
 int find_pch_pic(u32 gsi);
 struct fwnode_handle *get_pch_msi_handle(int pci_segment);
 
diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 16a9103..eb09add 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -72,6 +72,7 @@
 #define  CPUCFG1_RPLV			BIT(23)
 #define  CPUCFG1_HUGEPG			BIT(24)
 #define  CPUCFG1_CRC32			BIT(25)
+#define  CPUCFG1_MSGINT			BIT(26)
 
 #define LOONGARCH_CPUCFG2		0x2
 #define  CPUCFG2_FP			BIT(0)
@@ -251,8 +252,8 @@
 #define  CSR_ESTAT_EXC_WIDTH		6
 #define  CSR_ESTAT_EXC			(_ULCAST_(0x3f) << CSR_ESTAT_EXC_SHIFT)
 #define  CSR_ESTAT_IS_SHIFT		0
-#define  CSR_ESTAT_IS_WIDTH		15
-#define  CSR_ESTAT_IS			(_ULCAST_(0x7fff) << CSR_ESTAT_IS_SHIFT)
+#define  CSR_ESTAT_IS_WIDTH		14
+#define  CSR_ESTAT_IS			(_ULCAST_(0x3fff) << CSR_ESTAT_IS_SHIFT)
 
 #define LOONGARCH_CSR_ERA		0x6	/* ERA */
 
@@ -998,18 +999,10 @@
 #define CSR_FWPC_SKIP_SHIFT		16
 #define CSR_FWPC_SKIP			(_ULCAST_(1) << CSR_FWPC_SKIP_SHIFT)
 
-#define LOONGARCH_CSR_IRR0		0xa0
-#define LOONGARCH_CSR_IRR1		0xa1
-#define LOONGARCH_CSR_IRR2		0xa2
-#define LOONGARCH_CSR_IRR3		0xa3
-#define LOONGARCH_CSR_IRR_BASE		LOONGARCH_CSR_IRR0
-
-#define	LOONGARCH_CSR_ILR		0xa4
-
 /*
  * CSR_ECFG IM
  */
-#define ECFG0_IM		0x00005fff
+#define ECFG0_IM		0x00001fff
 #define ECFGB_SIP0		0
 #define ECFGF_SIP0		(_ULCAST_(1) << ECFGB_SIP0)
 #define ECFGB_SIP1		1
@@ -1052,7 +1045,6 @@
 #define  IOCSRF_EIODECODE		BIT_ULL(9)
 #define  IOCSRF_FLATMODE		BIT_ULL(10)
 #define  IOCSRF_VM			BIT_ULL(11)
-#define  IOCSRF_AVEC			BIT_ULL(15)
 
 #define LOONGARCH_IOCSR_VENDOR		0x10
 
@@ -1063,7 +1055,6 @@
 #define LOONGARCH_IOCSR_MISC_FUNC	0x420
 #define  IOCSR_MISC_FUNC_TIMER_RESET	BIT_ULL(21)
 #define  IOCSR_MISC_FUNC_EXT_IOI_EN	BIT_ULL(48)
-#define  IOCSR_MISC_FUNC_AVEC_EN	BIT_ULL(51)
 
 #define LOONGARCH_IOCSR_CPUTEMP		0x428
 
@@ -1384,10 +1375,9 @@ __BUILD_CSR_OP(tlbidx)
 #define INT_TI		11	/* Timer */
 #define INT_IPI		12
 #define INT_NMI		13
-#define INT_AVEC	14
 
 /* ExcCodes corresponding to interrupts */
-#define EXCCODE_INT_NUM		(INT_AVEC + 1)
+#define EXCCODE_INT_NUM		(INT_NMI + 1)
 #define EXCCODE_INT_START	64
 #define EXCCODE_INT_END		(EXCCODE_INT_START + EXCCODE_INT_NUM - 1)
 
diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/smp.h
index 2399004..278700c 100644
--- a/arch/loongarch/include/asm/smp.h
+++ b/arch/loongarch/include/asm/smp.h
@@ -69,11 +69,9 @@ extern int __cpu_logical_map[NR_CPUS];
 #define ACTION_BOOT_CPU	0
 #define ACTION_RESCHEDULE	1
 #define ACTION_CALL_FUNCTION	2
-#define ACTION_CLEAR_VECT	3
 #define SMP_BOOT_CPU		BIT(ACTION_BOOT_CPU)
 #define SMP_RESCHEDULE		BIT(ACTION_RESCHEDULE)
 #define SMP_CALL_FUNCTION	BIT(ACTION_CALL_FUNCTION)
-#define SMP_CLEAR_VECT		BIT(ACTION_CLEAR_VECT)
 
 struct secondary_data {
 	unsigned long stack;
diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
index 3b2e72e..5532081 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -106,6 +106,7 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
 		elf_hwcap |= HWCAP_LOONGARCH_CRC32;
 	}
 
+
 	config = read_cpucfg(LOONGARCH_CPUCFG2);
 	if (config & CPUCFG2_LAM) {
 		c->options |= LOONGARCH_CPU_LAM;
@@ -175,8 +176,6 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
 		c->options |= LOONGARCH_CPU_EIODECODE;
 	if (config & IOCSRF_VM)
 		c->options |= LOONGARCH_CPU_HYPERVISOR;
-	if (config & IOCSRF_AVEC)
-		c->options |= LOONGARCH_CPU_AVECINT;
 
 	config = csr_read32(LOONGARCH_CSR_ASID);
 	config = (config & CSR_ASID_BIT) >> CSR_ASID_BIT_SHIFT;
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 6dfedef..0dfe238 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -234,9 +234,6 @@ static irqreturn_t loongson_ipi_interrupt(int irq, void *dev)
 		per_cpu(irq_stat, cpu).ipi_irqs[IPI_CALL_FUNCTION]++;
 	}
 
-	if (action & SMP_CLEAR_VECT)
-		complete_irq_moving();
-
 	return IRQ_HANDLED;
 }
 
@@ -391,7 +388,6 @@ int loongson_cpu_disable(void)
 	irq_migrate_all_off_this_cpu();
 	clear_csr_ecfg(ECFG0_IM);
 	local_irq_restore(flags);
-	loongarch_avec_offline_cpu(cpu);
 	local_flush_tlb_all();
 
 	return 0;
@@ -570,7 +566,6 @@ asmlinkage void start_secondary(void)
 	 * early is dangerous.
 	 */
 	WARN_ON_ONCE(!irqs_disabled());
-	loongarch_avec_online_cpu(cpu);
 	loongson_smp_finish();
 
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index de091a9..2df72b7 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -110,7 +110,7 @@ obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
 obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
 obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
 obj-$(CONFIG_TI_PRUSS_INTC)		+= irq-pruss-intc.o
-obj-$(CONFIG_IRQ_LOONGARCH_CPU)		+= irq-loongarch-cpu.o irq-loongarch-avec.o
+obj-$(CONFIG_IRQ_LOONGARCH_CPU)		+= irq-loongarch-cpu.o
 obj-$(CONFIG_LOONGSON_LIOINTC)		+= irq-loongson-liointc.o
 obj-$(CONFIG_LOONGSON_EIOINTC)		+= irq-loongson-eiointc.o
 obj-$(CONFIG_LOONGSON_HTPIC)		+= irq-loongson-htpic.o
diff --git a/drivers/irqchip/irq-loongarch-avec.c b/drivers/irqchip/irq-loongarch-avec.c
deleted file mode 100644
index 4cd9079..0000000
--- a/drivers/irqchip/irq-loongarch-avec.c
+++ /dev/null
@@ -1,419 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2020 Loongson Technologies, Inc.
- */
-
-#include <linux/cpuhotplug.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/irqchip.h>
-#include <linux/irqchip/chained_irq.h>
-#include <linux/irqdomain.h>
-#include <linux/kernel.h>
-#include <linux/msi.h>
-#include <linux/radix-tree.h>
-#include <linux/spinlock.h>
-
-#include <asm/loongarch.h>
-#include <asm/setup.h>
-
-#define VECTORS_PER_REG		64
-#define ILR_INVALID_MASK	0x80000000UL
-#define ILR_VECTOR_MASK		0xffUL
-#define AVEC_MSG_OFFSET		0x100000
-
-static phys_addr_t msi_base_v2;
-static DEFINE_PER_CPU(struct irq_desc * [NR_VECTORS], irq_map);
-
-struct pending_list {
-	struct list_head	head;
-};
-
-static DEFINE_PER_CPU(struct pending_list, pending_list);
-
-struct loongarch_avec_chip {
-	struct fwnode_handle	*fwnode;
-	struct irq_domain	*domain;
-	struct irq_matrix	*vector_matrix;
-	raw_spinlock_t		lock;
-};
-
-static struct loongarch_avec_chip loongarch_avec;
-
-struct loongarch_avec_data {
-	struct list_head	entry;
-	unsigned int		cpu;
-	unsigned int		vec;
-	unsigned int		prev_cpu;
-	unsigned int		prev_vec;
-	unsigned int		moving		: 1,
-				managed		: 1;
-};
-
-static struct cpumask intersect_mask;
-
-static int assign_irq_vector(struct irq_data *irqd, const struct cpumask *dest,
-			     unsigned int *cpu)
-{
-	return irq_matrix_alloc(loongarch_avec.vector_matrix, dest, false, cpu);
-}
-
-static inline void loongarch_avec_ack_irq(struct irq_data *d)
-{
-}
-
-static inline void loongarch_avec_unmask_irq(struct irq_data *d)
-{
-}
-
-static inline void loongarch_avec_mask_irq(struct irq_data *d)
-{
-}
-
-static void loongarch_avec_sync(struct loongarch_avec_data *adata)
-{
-	struct pending_list *plist;
-
-	if (cpu_online(adata->prev_cpu)) {
-		plist = per_cpu_ptr(&pending_list, adata->prev_cpu);
-		list_add_tail(&adata->entry, &plist->head);
-		adata->moving = true;
-		loongson_send_ipi_single(adata->prev_cpu, SMP_CLEAR_VECT);
-	}
-	adata->prev_cpu = adata->cpu;
-	adata->prev_vec = adata->vec;
-}
-
-static int loongarch_avec_set_affinity(struct irq_data *data, const struct cpumask *dest,
-				       bool force)
-{
-	struct loongarch_avec_data *adata;
-	unsigned int cpu, vector;
-	unsigned long flags;
-	int ret;
-
-	raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
-	adata = irq_data_get_irq_chip_data(data);
-
-	if (adata->vec && cpu_online(adata->cpu) && cpumask_test_cpu(adata->cpu, dest)) {
-		raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
-		return 0;
-	}
-	if (adata->moving)
-		return -EBUSY;
-
-	cpumask_and(&intersect_mask, dest, cpu_online_mask);
-
-	ret = assign_irq_vector(data, &intersect_mask, &cpu);
-	if (ret < 0) {
-		raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
-		return ret;
-	}
-	vector = ret;
-	adata->cpu = cpu;
-	adata->vec = vector;
-	per_cpu_ptr(irq_map, adata->cpu)[adata->vec] = irq_data_to_desc(data);
-	loongarch_avec_sync(adata);
-
-	raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
-	irq_data_update_effective_affinity(data, cpumask_of(cpu));
-
-	return IRQ_SET_MASK_OK;
-}
-
-static void loongarch_avec_compose_msg(struct irq_data *d,
-		struct msi_msg *msg)
-{
-	struct loongarch_avec_data *avec_data;
-
-	avec_data = irq_data_get_irq_chip_data(d);
-
-	msg->address_hi = 0x0;
-	msg->address_lo = msi_base_v2 | ((avec_data->vec & 0xff) << 4) |
-			  ((cpu_logical_map(avec_data->cpu & 0xffff)) << 12);
-	msg->data = 0x0;
-
-}
-
-static struct irq_chip loongarch_avec_controller = {
-	.name			= "CORE_AVEC",
-	.irq_ack		= loongarch_avec_ack_irq,
-	.irq_mask		= loongarch_avec_mask_irq,
-	.irq_unmask		= loongarch_avec_unmask_irq,
-	.irq_set_affinity	= loongarch_avec_set_affinity,
-	.irq_compose_msi_msg	= loongarch_avec_compose_msg,
-};
-
-void complete_irq_moving(void)
-{
-	struct pending_list *plist = this_cpu_ptr(&pending_list);
-	struct loongarch_avec_data *adata, *tmp;
-	int cpu, vector, bias;
-	u64 irr;
-
-	raw_spin_lock(&loongarch_avec.lock);
-
-	list_for_each_entry_safe(adata, tmp, &plist->head, entry) {
-		cpu = adata->prev_cpu;
-		vector = adata->prev_vec;
-		bias = vector / VECTORS_PER_REG;
-		switch (bias) {
-		case 0:
-			irr = csr_read64(LOONGARCH_CSR_IRR0);
-		case 1:
-			irr = csr_read64(LOONGARCH_CSR_IRR1);
-		case 2:
-			irr = csr_read64(LOONGARCH_CSR_IRR2);
-		case 3:
-			irr = csr_read64(LOONGARCH_CSR_IRR3);
-		}
-
-		if (irr & (1UL << (vector % VECTORS_PER_REG))) {
-			loongson_send_ipi_single(cpu, SMP_CLEAR_VECT);
-			continue;
-		}
-		list_del(&adata->entry);
-		irq_matrix_free(loongarch_avec.vector_matrix, cpu, vector, adata->managed);
-		this_cpu_write(irq_map[vector], NULL);
-		adata->moving = 0;
-	}
-	raw_spin_unlock(&loongarch_avec.lock);
-}
-
-static void loongarch_avec_dispatch(struct irq_desc *desc)
-{
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	unsigned long vector;
-	struct irq_desc *d;
-
-	chained_irq_enter(chip, desc);
-	vector = csr_read64(LOONGARCH_CSR_ILR);
-	if (vector & ILR_INVALID_MASK)
-		return;
-
-	vector &= ILR_VECTOR_MASK;
-
-	d = this_cpu_read(irq_map[vector]);
-	if (d) {
-		generic_handle_irq_desc(d);
-	} else {
-		pr_warn("IRQ ERROR:Unexpected irq  occur on cpu %d[vector %ld]\n",
-			smp_processor_id(), vector);
-	}
-
-	chained_irq_exit(chip, desc);
-}
-
-static int loongarch_avec_alloc(struct irq_domain *domain, unsigned int virq,
-				unsigned int nr_irqs, void *arg)
-{
-	struct loongarch_avec_data *adata;
-	struct irq_data *irqd;
-	unsigned int cpu, vector, i, ret;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
-	for (i = 0; i < nr_irqs; i++) {
-		irqd = irq_domain_get_irq_data(domain, virq + i);
-		adata = kzalloc(sizeof(*adata), GFP_KERNEL);
-		if (!adata) {
-			raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
-			return -ENOMEM;
-		}
-		ret = assign_irq_vector(irqd, cpu_online_mask, &cpu);
-		if (ret < 0) {
-			raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
-			return ret;
-		}
-		vector = ret;
-		adata->prev_cpu = adata->cpu = cpu;
-		adata->prev_vec = adata->vec = vector;
-		adata->managed = irqd_affinity_is_managed(irqd);
-		irq_domain_set_info(domain, virq + i, virq + i, &loongarch_avec_controller,
-				adata, handle_edge_irq, NULL, NULL);
-		adata->moving = 0;
-		irqd_set_single_target(irqd);
-		irqd_set_affinity_on_activate(irqd);
-
-		per_cpu_ptr(irq_map, adata->cpu)[adata->vec] = irq_data_to_desc(irqd);
-	}
-	raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
-
-	return 0;
-}
-
-static void clear_free_vector(struct irq_data *irqd)
-{
-	struct loongarch_avec_data *adata = irq_data_get_irq_chip_data(irqd);
-	bool managed = irqd_affinity_is_managed(irqd);
-
-	per_cpu(irq_map, adata->cpu)[adata->vec] = NULL;
-	irq_matrix_free(loongarch_avec.vector_matrix, adata->cpu, adata->vec, managed);
-	adata->cpu = 0;
-	adata->vec = 0;
-	if (!adata->moving)
-		return;
-
-	per_cpu(irq_map, adata->prev_cpu)[adata->prev_vec] = 0;
-	irq_matrix_free(loongarch_avec.vector_matrix, adata->prev_cpu,
-			adata->prev_vec, adata->managed);
-	adata->prev_vec = 0;
-	adata->prev_cpu = 0;
-	adata->moving = 0;
-	list_del_init(&adata->entry);
-}
-
-static void loongarch_avec_free(struct irq_domain *domain, unsigned int virq,
-		unsigned int nr_irqs)
-{
-	struct irq_data *d;
-	unsigned long flags;
-	unsigned int i;
-
-	raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
-	for (i = 0; i < nr_irqs; i++) {
-		d = irq_domain_get_irq_data(domain, virq + i);
-		if (d) {
-			clear_free_vector(d);
-			irq_domain_reset_irq_data(d);
-
-		}
-	}
-
-	raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
-}
-
-static const struct irq_domain_ops loongarch_avec_domain_ops = {
-	.alloc		= loongarch_avec_alloc,
-	.free		= loongarch_avec_free,
-};
-
-static int __init irq_matrix_init(void)
-{
-	int i;
-
-	loongarch_avec.vector_matrix = irq_alloc_matrix(NR_VECTORS, 0, NR_VECTORS - 1);
-	if (!loongarch_avec.vector_matrix)
-		return -ENOMEM;
-	for (i = 0; i < NR_LEGACY_VECTORS; i++)
-		irq_matrix_assign_system(loongarch_avec.vector_matrix, i, false);
-
-	irq_matrix_online(loongarch_avec.vector_matrix);
-
-	return 0;
-}
-
-static int __init loongarch_avec_init(struct irq_domain *parent)
-{
-	struct pending_list *plist = per_cpu_ptr(&pending_list, 0);
-	int ret = 0, parent_irq;
-	unsigned long tmp;
-
-	raw_spin_lock_init(&loongarch_avec.lock);
-
-	loongarch_avec.fwnode = irq_domain_alloc_named_fwnode("CORE_AVEC");
-	if (!loongarch_avec.fwnode) {
-		pr_err("Unable to allocate domain handle\n");
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	loongarch_avec.domain = irq_domain_create_tree(loongarch_avec.fwnode,
-			&loongarch_avec_domain_ops, NULL);
-	if (!loongarch_avec.domain) {
-		pr_err("core-vec: cannot create IRQ domain\n");
-		ret = -ENOMEM;
-		goto out_free_handle;
-	}
-
-	parent_irq = irq_create_mapping(parent, INT_AVEC);
-	if (!parent_irq) {
-		pr_err("Failed to mapping hwirq\n");
-		ret = -EINVAL;
-		goto out_remove_domain;
-	}
-	irq_set_chained_handler_and_data(parent_irq, loongarch_avec_dispatch, NULL);
-
-	ret = irq_matrix_init();
-	if (ret) {
-		pr_err("Failed to init irq matrix\n");
-		goto out_free_matrix;
-	}
-
-	INIT_LIST_HEAD(&plist->head);
-	tmp = iocsr_read64(LOONGARCH_IOCSR_MISC_FUNC);
-	tmp |= IOCSR_MISC_FUNC_AVEC_EN;
-	iocsr_write64(tmp, LOONGARCH_IOCSR_MISC_FUNC);
-
-	return ret;
-
-out_free_matrix:
-	kfree(loongarch_avec.vector_matrix);
-out_remove_domain:
-	irq_domain_remove(loongarch_avec.domain);
-out_free_handle:
-	irq_domain_free_fwnode(loongarch_avec.fwnode);
-out:
-	return ret;
-}
-
-void loongarch_avec_offline_cpu(unsigned int cpu)
-{
-	struct pending_list *plist = per_cpu_ptr(&pending_list, cpu);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
-	if (list_empty(&plist->head))
-		irq_matrix_offline(loongarch_avec.vector_matrix);
-	else
-		pr_warn("cpu %d advanced extioi is busy\n", cpu);
-	raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
-}
-
-void loongarch_avec_online_cpu(unsigned int cpu)
-{
-	struct pending_list *plist = per_cpu_ptr(&pending_list, cpu);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&loongarch_avec.lock, flags);
-
-	irq_matrix_online(loongarch_avec.vector_matrix);
-
-	INIT_LIST_HEAD(&plist->head);
-
-	raw_spin_unlock_irqrestore(&loongarch_avec.lock, flags);
-}
-
-static int __init pch_msi_parse_madt(union acpi_subtable_headers *header,
-				     const unsigned long end)
-{
-	struct acpi_madt_msi_pic *pchmsi_entry = (struct acpi_madt_msi_pic *)header;
-
-	msi_base_v2 = pchmsi_entry->msg_address - AVEC_MSG_OFFSET;
-	return pch_msi_acpi_init_v2(loongarch_avec.domain, pchmsi_entry);
-}
-
-static inline int __init acpi_cascade_irqdomain_init(void)
-{
-	return acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, pch_msi_parse_madt, 1);
-}
-
-int __init loongarch_avec_acpi_init(struct irq_domain *parent)
-{
-	int ret = 0;
-
-	ret = loongarch_avec_init(parent);
-	if (ret) {
-		pr_err("Failed to init irq domain\n");
-		return ret;
-	}
-
-	ret = acpi_cascade_irqdomain_init();
-	if (ret) {
-		pr_err("Failed to cascade IRQ domain\n");
-		return ret;
-	}
-
-	return ret;
-}
diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index 1ecac59..9d8f2c4 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -138,9 +138,7 @@ static int __init acpi_cascade_irqdomain_init(void)
 	if (r < 0)
 		return r;
 
-	if (cpu_has_avecint)
-		r = loongarch_avec_acpi_init(irq_domain);
-	return r;
+	return 0;
 }
 
 static int __init cpuintc_acpi_init(union acpi_subtable_headers *header,
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 1f9a304..c7ddebf 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -359,9 +359,6 @@ static int __init acpi_cascade_irqdomain_init(void)
 	if (r < 0)
 		return r;
 
-	if (cpu_has_avecint)
-		return 0;
-
 	r = acpi_table_parse_madt(ACPI_MADT_TYPE_MSI_PIC, pch_msi_parse_madt, 1);
 	if (r < 0)
 		return r;
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index 1926857..dd4d699 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 
 static int nr_pics;
+
 struct pch_msi_data {
 	struct mutex	msi_map_lock;
 	phys_addr_t	doorbell;
@@ -99,17 +100,6 @@ static struct irq_chip middle_irq_chip = {
 	.irq_compose_msi_msg	= pch_msi_compose_msi_msg,
 };
 
-static struct irq_chip pch_msi_irq_chip_v2 = {
-	.name			= "MSI",
-	.irq_ack		= irq_chip_ack_parent,
-};
-
-static struct msi_domain_info pch_msi_domain_info_v2 = {
-	.flags		= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-			MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
-	.chip	= &pch_msi_irq_chip_v2,
-};
-
 static int pch_msi_parent_domain_alloc(struct irq_domain *domain,
 					unsigned int virq, int hwirq)
 {
@@ -278,9 +268,6 @@ struct fwnode_handle *get_pch_msi_handle(int pci_segment)
 {
 	int i;
 
-	if (cpu_has_avecint)
-		return pch_msi_handle[0];
-
 	for (i = 0; i < MAX_IO_PICS; i++) {
 		if (msi_group[i].pci_segment == pci_segment)
 			return pch_msi_handle[i];
@@ -302,32 +289,4 @@ int __init pch_msi_acpi_init(struct irq_domain *parent,
 
 	return ret;
 }
-
-int __init pch_msi_acpi_init_v2(struct irq_domain *parent,
-		struct acpi_madt_msi_pic *msi_entry)
-{
-	struct irq_domain *msi_domain;
-
-	if (pch_msi_handle[0])
-		return 0;
-
-	pch_msi_handle[0] = irq_domain_alloc_named_fwnode("msipic-v2");
-	if (!pch_msi_handle[0]) {
-		pr_err("Unable to allocate domain handle\n");
-		kfree(pch_msi_handle[0]);
-		return -ENOMEM;
-	}
-
-	msi_domain = pci_msi_create_irq_domain(pch_msi_handle[0],
-			&pch_msi_domain_info_v2,
-			parent);
-	if (!msi_domain) {
-		pr_err("Failed to create PCI MSI domain\n");
-		kfree(pch_msi_handle[0]);
-		return -ENOMEM;
-	}
-
-	pr_info("IRQ domain MSIPIC-V2 init done.\n");
-	return 0;
-}
 #endif

