Return-Path: <linux-tip-commits+bounces-2101-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCF195D571
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2024 20:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EDAFB21FE5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2024 18:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8951925B0;
	Fri, 23 Aug 2024 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wO+acies";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5bKQtmM/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3225F18BB8B;
	Fri, 23 Aug 2024 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724438711; cv=none; b=gDNb1pi1RAgNqAgUf3nnk+0tTuji7LdBmhRpYgeEv5di/7OSnT6ooN6ZDZhuHPQFrhFWvB/0gjkEdxzO0kiGx8xrK4waIbkHF/nvMBIO0W09fsRAwp3/zKr0TZek7XlRNDXRdTtfmmLma57JKuyV2TcRNZR0/91L9fLOq9uLs1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724438711; c=relaxed/simple;
	bh=04meHgueFRCdIcZFEMzt2/4HbXXMOqDt7VPUPQk5rgc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FNZbNU5kqgJuBwhc7pfSPrMFDs2iCMAcW2EDkqdCxZDMDP5Y6stboUrsHSqI0fVjvy/0SqCdZSZKF1vkgRSqkOCALQ0EXuTLLeNxfDKu002FkSqcwKeW4MMYAfFLKzdPE5up8ILr7RVj6VOplPQF8dpPTmC4evMvlWMBVPLV/2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wO+acies; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5bKQtmM/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Aug 2024 18:45:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724438706;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pk4RtacKay6fXJGRpoh+R06sxuu430ku69VSvaVUU2Q=;
	b=wO+aciesZLle2XDSQuaNHOLiRWk6P2NpscyxfINEweqsuf4sOK1dh/amhGoa9xlUBuJe7n
	fAWXm/HY+YyD7kdVj+jd9IOOkacBGnptrklYqZr9k8BVcNaQBvY6RwXfbtkYO8cBtCa0jS
	+RIwuU2XZ2coWOmlR1rQ6S8lrNSvnmpSEy14jqNPgrNr3fiOA6pxt/1Y1iJ70hILJb9laP
	R4PwyseybniJQtVXz7Vh4XLzEeZ82eeehMaJ+rTyfTWB3iHZpIx0MTeWJtTLDBEvWBZHlx
	sER4uVtKn32a/UoNC4Rp8zw8faxNtijd/wyP9uSkOboNAKoWW597pe40QMH6bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724438706;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pk4RtacKay6fXJGRpoh+R06sxuu430ku69VSvaVUU2Q=;
	b=5bKQtmM/c9Q39sb2VPF4EVo9mKPI93VJSL16yw5L/027/Q2bHQevkBN94+mlEx5LI1Znhk
	XT8ampAPV4H8g1CA==
From: "tip-bot2 for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] LoongArch: Architectural preparation for AVEC irqchip
Cc: Huacai Chen <chenhuacai@loongson.cn>,
 Tianyang Zhang <zhangtianyang@loongson.cn>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240823103936.25092-2-zhangtianyang@loongson.cn>
References: <20240823103936.25092-2-zhangtianyang@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172443870596.2215.1190063282899024702.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     843ed9317be1d0c3f4245418644fc7e55f465419
Gitweb:        https://git.kernel.org/tip/843ed9317be1d0c3f4245418644fc7e55f465419
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Fri, 23 Aug 2024 18:39:33 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 23 Aug 2024 20:40:27 +02:00

LoongArch: Architectural preparation for AVEC irqchip

Add architectural preparation for AVEC irqchip, including:
1. CPUCFG feature bits definition for AVEC;
2. Detection of AVEC irqchip in cpu_probe();
3. New IPI type definition (IPI_CLEAR_VECTOR) for AVEC;
4. Provide arch_probe_nr_irqs() for large NR_IRQS;
5. Other related changes about the number of interrupts.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240823103936.25092-2-zhangtianyang@loongson.cn

---
 arch/loongarch/include/asm/cpu-features.h |  1 +
 arch/loongarch/include/asm/cpu.h          |  2 ++
 arch/loongarch/include/asm/hardirq.h      |  3 ++-
 arch/loongarch/include/asm/irq.h          | 15 +++++++++++++--
 arch/loongarch/include/asm/loongarch.h    | 18 ++++++++++++++----
 arch/loongarch/include/asm/smp.h          |  2 ++
 arch/loongarch/kernel/cpu-probe.c         |  3 ++-
 arch/loongarch/kernel/irq.c               | 12 ++++++++++++
 8 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/include/asm/cpu-features.h b/arch/loongarch/include/asm/cpu-features.h
index 2eafe6a..16a716f 100644
--- a/arch/loongarch/include/asm/cpu-features.h
+++ b/arch/loongarch/include/asm/cpu-features.h
@@ -65,5 +65,6 @@
 #define cpu_has_guestid		cpu_opt(LOONGARCH_CPU_GUESTID)
 #define cpu_has_hypervisor	cpu_opt(LOONGARCH_CPU_HYPERVISOR)
 #define cpu_has_ptw		cpu_opt(LOONGARCH_CPU_PTW)
+#define cpu_has_avecint		cpu_opt(LOONGARCH_CPU_AVECINT)
 
 #endif /* __ASM_CPU_FEATURES_H */
diff --git a/arch/loongarch/include/asm/cpu.h b/arch/loongarch/include/asm/cpu.h
index 48b9f71..843f9c4 100644
--- a/arch/loongarch/include/asm/cpu.h
+++ b/arch/loongarch/include/asm/cpu.h
@@ -99,6 +99,7 @@ enum cpu_type_enum {
 #define CPU_FEATURE_GUESTID		24	/* CPU has GuestID feature */
 #define CPU_FEATURE_HYPERVISOR		25	/* CPU has hypervisor (running in VM) */
 #define CPU_FEATURE_PTW			26	/* CPU has hardware page table walker */
+#define CPU_FEATURE_AVECINT		27	/* CPU has avec interrupt */
 
 #define LOONGARCH_CPU_CPUCFG		BIT_ULL(CPU_FEATURE_CPUCFG)
 #define LOONGARCH_CPU_LAM		BIT_ULL(CPU_FEATURE_LAM)
@@ -127,5 +128,6 @@ enum cpu_type_enum {
 #define LOONGARCH_CPU_GUESTID		BIT_ULL(CPU_FEATURE_GUESTID)
 #define LOONGARCH_CPU_HYPERVISOR	BIT_ULL(CPU_FEATURE_HYPERVISOR)
 #define LOONGARCH_CPU_PTW		BIT_ULL(CPU_FEATURE_PTW)
+#define LOONGARCH_CPU_AVECINT		BIT_ULL(CPU_FEATURE_AVECINT)
 
 #endif /* _ASM_CPU_H */
diff --git a/arch/loongarch/include/asm/hardirq.h b/arch/loongarch/include/asm/hardirq.h
index 1d7feb7..10da8d6 100644
--- a/arch/loongarch/include/asm/hardirq.h
+++ b/arch/loongarch/include/asm/hardirq.h
@@ -12,12 +12,13 @@
 extern void ack_bad_irq(unsigned int irq);
 #define ack_bad_irq ack_bad_irq
 
-#define NR_IPI	3
+#define NR_IPI	4
 
 enum ipi_msg_type {
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNCTION,
 	IPI_IRQ_WORK,
+	IPI_CLEAR_VECTOR,
 };
 
 typedef struct {
diff --git a/arch/loongarch/include/asm/irq.h b/arch/loongarch/include/asm/irq.h
index 65503c9..c483580 100644
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@ -39,11 +39,22 @@ void spurious_interrupt(void);
 
 #define NR_IRQS_LEGACY 16
 
+/*
+ * 256 Vectors Mapping for AVECINTC:
+ *
+ * 0 - 15: Mapping classic IPs, e.g. IP0-12.
+ * 16 - 255: Mapping vectors for external IRQ.
+ *
+ */
+#define NR_VECTORS		256
+#define NR_LEGACY_VECTORS	16
+#define IRQ_MATRIX_BITS		NR_VECTORS
+
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 void arch_trigger_cpumask_backtrace(const struct cpumask *mask, int exclude_cpu);
 
 #define MAX_IO_PICS 2
-#define NR_IRQS	(64 + (256 * MAX_IO_PICS))
+#define NR_IRQS	(64 + NR_VECTORS * (NR_CPUS + MAX_IO_PICS))
 
 struct acpi_vector_group {
 	int node;
@@ -65,7 +76,7 @@ extern struct acpi_vector_group msi_group[MAX_IO_PICS];
 #define LOONGSON_LPC_LAST_IRQ		(LOONGSON_LPC_IRQ_BASE + 15)
 
 #define LOONGSON_CPU_IRQ_BASE		16
-#define LOONGSON_CPU_LAST_IRQ		(LOONGSON_CPU_IRQ_BASE + 14)
+#define LOONGSON_CPU_LAST_IRQ		(LOONGSON_CPU_IRQ_BASE + 15)
 
 #define LOONGSON_PCH_IRQ_BASE		64
 #define LOONGSON_PCH_ACPI_IRQ		(LOONGSON_PCH_IRQ_BASE + 47)
diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 04a7801..631d249 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -253,8 +253,8 @@
 #define  CSR_ESTAT_EXC_WIDTH		6
 #define  CSR_ESTAT_EXC			(_ULCAST_(0x3f) << CSR_ESTAT_EXC_SHIFT)
 #define  CSR_ESTAT_IS_SHIFT		0
-#define  CSR_ESTAT_IS_WIDTH		14
-#define  CSR_ESTAT_IS			(_ULCAST_(0x3fff) << CSR_ESTAT_IS_SHIFT)
+#define  CSR_ESTAT_IS_WIDTH		15
+#define  CSR_ESTAT_IS			(_ULCAST_(0x7fff) << CSR_ESTAT_IS_SHIFT)
 
 #define LOONGARCH_CSR_ERA		0x6	/* ERA */
 
@@ -649,6 +649,13 @@
 
 #define LOONGARCH_CSR_CTAG		0x98	/* TagLo + TagHi */
 
+#define LOONGARCH_CSR_ISR0		0xa0
+#define LOONGARCH_CSR_ISR1		0xa1
+#define LOONGARCH_CSR_ISR2		0xa2
+#define LOONGARCH_CSR_ISR3		0xa3
+
+#define LOONGARCH_CSR_IRR		0xa4
+
 #define LOONGARCH_CSR_PRID		0xc0
 
 /* Shadow MCSR : 0xc0 ~ 0xff */
@@ -1011,7 +1018,7 @@
 /*
  * CSR_ECFG IM
  */
-#define ECFG0_IM		0x00001fff
+#define ECFG0_IM		0x00005fff
 #define ECFGB_SIP0		0
 #define ECFGF_SIP0		(_ULCAST_(1) << ECFGB_SIP0)
 #define ECFGB_SIP1		1
@@ -1054,6 +1061,7 @@
 #define  IOCSRF_EIODECODE		BIT_ULL(9)
 #define  IOCSRF_FLATMODE		BIT_ULL(10)
 #define  IOCSRF_VM			BIT_ULL(11)
+#define  IOCSRF_AVEC			BIT_ULL(15)
 
 #define LOONGARCH_IOCSR_VENDOR		0x10
 
@@ -1065,6 +1073,7 @@
 #define  IOCSR_MISC_FUNC_SOFT_INT	BIT_ULL(10)
 #define  IOCSR_MISC_FUNC_TIMER_RESET	BIT_ULL(21)
 #define  IOCSR_MISC_FUNC_EXT_IOI_EN	BIT_ULL(48)
+#define  IOCSR_MISC_FUNC_AVEC_EN	BIT_ULL(51)
 
 #define LOONGARCH_IOCSR_CPUTEMP		0x428
 
@@ -1387,9 +1396,10 @@ __BUILD_CSR_OP(tlbidx)
 #define INT_TI		11	/* Timer */
 #define INT_IPI		12
 #define INT_NMI		13
+#define INT_AVEC	14
 
 /* ExcCodes corresponding to interrupts */
-#define EXCCODE_INT_NUM		(INT_NMI + 1)
+#define EXCCODE_INT_NUM		(INT_AVEC + 1)
 #define EXCCODE_INT_START	64
 #define EXCCODE_INT_END		(EXCCODE_INT_START + EXCCODE_INT_NUM - 1)
 
diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/smp.h
index 50db503..3383c9d 100644
--- a/arch/loongarch/include/asm/smp.h
+++ b/arch/loongarch/include/asm/smp.h
@@ -70,10 +70,12 @@ extern int __cpu_logical_map[NR_CPUS];
 #define ACTION_RESCHEDULE	1
 #define ACTION_CALL_FUNCTION	2
 #define ACTION_IRQ_WORK		3
+#define ACTION_CLEAR_VECTOR	4
 #define SMP_BOOT_CPU		BIT(ACTION_BOOT_CPU)
 #define SMP_RESCHEDULE		BIT(ACTION_RESCHEDULE)
 #define SMP_CALL_FUNCTION	BIT(ACTION_CALL_FUNCTION)
 #define SMP_IRQ_WORK		BIT(ACTION_IRQ_WORK)
+#define SMP_CLEAR_VECTOR	BIT(ACTION_CLEAR_VECTOR)
 
 struct secondary_data {
 	unsigned long stack;
diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
index 5532081..14f0449 100644
--- a/arch/loongarch/kernel/cpu-probe.c
+++ b/arch/loongarch/kernel/cpu-probe.c
@@ -106,7 +106,6 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
 		elf_hwcap |= HWCAP_LOONGARCH_CRC32;
 	}
 
-
 	config = read_cpucfg(LOONGARCH_CPUCFG2);
 	if (config & CPUCFG2_LAM) {
 		c->options |= LOONGARCH_CPU_LAM;
@@ -174,6 +173,8 @@ static void cpu_probe_common(struct cpuinfo_loongarch *c)
 		c->options |= LOONGARCH_CPU_FLATMODE;
 	if (config & IOCSRF_EIODECODE)
 		c->options |= LOONGARCH_CPU_EIODECODE;
+	if (config & IOCSRF_AVEC)
+		c->options |= LOONGARCH_CPU_AVECINT;
 	if (config & IOCSRF_VM)
 		c->options |= LOONGARCH_CPU_HYPERVISOR;
 
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index f4991c0..414f524 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -87,6 +87,18 @@ static void __init init_vec_parent_group(void)
 	acpi_table_parse(ACPI_SIG_MCFG, early_pci_mcfg_parse);
 }
 
+int __init arch_probe_nr_irqs(void)
+{
+	int nr_io_pics = bitmap_weight(loongson_sysconf.cores_io_master, NR_CPUS);
+
+	if (!cpu_has_avecint)
+		nr_irqs = (64 + NR_VECTORS * nr_io_pics);
+	else
+		nr_irqs = (64 + NR_VECTORS * (nr_cpu_ids + nr_io_pics));
+
+	return NR_IRQS_LEGACY;
+}
+
 void __init init_IRQ(void)
 {
 	int i;

