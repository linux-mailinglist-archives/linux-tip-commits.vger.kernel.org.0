Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB01228A8AF
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388555AbgJKR5y (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:57:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40084 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388438AbgJKR5e (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:34 -0400
Date:   Sun, 11 Oct 2020 17:57:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439052;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bb8Y0XXeajllYMPmNFP1vSUSfAvHQOsWoGv6wYcdAGs=;
        b=NreSxpV39kVOpfZGEbhHNCSelGaBDqhe2wKPd3ZD9bcKCtcyVdnWoyfcPk0efxqtQP+1AO
        w0DDTZecnpIElNWNmVXDf4DrPLxeMKKgg5s8t1lsujyOuwLmUjdF4naXijDLCGCoqiFENr
        XfCqHPWt37Pil2PFsbWJOvMQMwe9SleXHUwKf38FV7m7bJeWbhM4hUVabVWzjMg+n7fwoa
        l1rWYYXDRX4XDqlMpSJc0k1e5i366VTiqDnn9HT4/X6x9qTWsL0LxZpa1zt8RfKMkzWcgT
        0q8uSGcOst48n+d+0kJ5Lkq8VkaH9t9eowLuLlJlVDDgzO9EkXNl/0GUmMxq+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439052;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bb8Y0XXeajllYMPmNFP1vSUSfAvHQOsWoGv6wYcdAGs=;
        b=9gK0h2D3+gcYWMadHgB3mWmCjxEMXCCv8jmAVwBtUPBIyDOgQDtw31R47F9M5OXkszJRKW
        aGW2lHtvfl4Fl6AA==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] arm64: Remove custom IRQ stat accounting
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243905159.7002.4103912241704389488.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a263881525310e10ecd46ae8e8531ac9e968b1b4
Gitweb:        https://git.kernel.org/tip/a263881525310e10ecd46ae8e8531ac9e968b1b4
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sat, 20 Jun 2020 17:19:00 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 17 Sep 2020 16:37:28 +01:00

arm64: Remove custom IRQ stat accounting

Let's switch the arm64 code to the core accounting, which already
does everything we need.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/hardirq.h |  9 ---------
 arch/arm64/include/asm/smp.h     |  5 -----
 arch/arm64/kernel/irq.c          | 11 +----------
 arch/arm64/kernel/smp.c          | 30 ++++++++++++------------------
 4 files changed, 13 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index 985493a..5ffa4ba 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -13,21 +13,12 @@
 #include <asm/kvm_arm.h>
 #include <asm/sysreg.h>
 
-#define NR_IPI	7
-
 typedef struct {
 	unsigned int __softirq_pending;
-	unsigned int ipi_irqs[NR_IPI];
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
-#define __inc_irq_stat(cpu, member)	__IRQ_STAT(cpu, member)++
-#define __get_irq_stat(cpu, member)	__IRQ_STAT(cpu, member)
-
-u64 smp_irq_stat_cpu(unsigned int cpu);
-#define arch_irq_stat_cpu	smp_irq_stat_cpu
-
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
 
 struct nmi_ctx {
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index c298ad0..2e7f529 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -56,11 +56,6 @@ static inline void set_cpu_logical_map(int cpu, u64 hwid)
 struct seq_file;
 
 /*
- * generate IPI list text
- */
-extern void show_ipi_list(struct seq_file *p, int prec);
-
-/*
  * Discover the set of possible CPUs and determine their
  * SMP operations.
  */
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 04a327c..9cf2fb8 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -10,10 +10,10 @@
  * Copyright (C) 2012 ARM Ltd.
  */
 
-#include <linux/kernel_stat.h>
 #include <linux/irq.h>
 #include <linux/memory.h>
 #include <linux/smp.h>
+#include <linux/hardirq.h>
 #include <linux/init.h>
 #include <linux/irqchip.h>
 #include <linux/kprobes.h>
@@ -22,20 +22,11 @@
 #include <asm/daifflags.h>
 #include <asm/vmap_stack.h>
 
-unsigned long irq_err_count;
-
 /* Only access this in an NMI enter/exit */
 DEFINE_PER_CPU(struct nmi_ctx, nmi_contexts);
 
 DEFINE_PER_CPU(unsigned long *, irq_stack_ptr);
 
-int arch_show_interrupts(struct seq_file *p, int prec)
-{
-	show_ipi_list(p, prec);
-	seq_printf(p, "%*s: %10lu\n", prec, "Err", irq_err_count);
-	return 0;
-}
-
 #ifdef CONFIG_VMAP_STACK
 static void init_irq_stacks(void)
 {
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 58fb155..b6bde26 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -30,6 +30,7 @@
 #include <linux/completion.h>
 #include <linux/of.h>
 #include <linux/irq_work.h>
+#include <linux/kernel_stat.h>
 #include <linux/kexec.h>
 #include <linux/kvm_host.h>
 
@@ -72,7 +73,8 @@ enum ipi_msg_type {
 	IPI_CPU_CRASH_STOP,
 	IPI_TIMER,
 	IPI_IRQ_WORK,
-	IPI_WAKEUP
+	IPI_WAKEUP,
+	NR_IPI
 };
 
 static int ipi_irq_base __read_mostly;
@@ -795,29 +797,23 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
 
-void show_ipi_list(struct seq_file *p, int prec)
+unsigned long irq_err_count;
+
+int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	unsigned int cpu, i;
 
 	for (i = 0; i < NR_IPI; i++) {
+		unsigned int irq = irq_desc_get_irq(ipi_desc[i]);
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
 			   prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10u ",
-				   __get_irq_stat(cpu, ipi_irqs[i]));
+			seq_printf(p, "%10u ", kstat_irqs_cpu(irq, cpu));
 		seq_printf(p, "      %s\n", ipi_types[i]);
 	}
-}
-
-u64 smp_irq_stat_cpu(unsigned int cpu)
-{
-	u64 sum = 0;
-	int i;
 
-	for (i = 0; i < NR_IPI; i++)
-		sum += __get_irq_stat(cpu, ipi_irqs[i]);
-
-	return sum;
+	seq_printf(p, "%*s: %10lu\n", prec, "Err", irq_err_count);
+	return 0;
 }
 
 void arch_send_call_function_ipi_mask(const struct cpumask *mask)
@@ -892,10 +888,8 @@ static void do_handle_IPI(int ipinr)
 {
 	unsigned int cpu = smp_processor_id();
 
-	if ((unsigned)ipinr < NR_IPI) {
+	if ((unsigned)ipinr < NR_IPI)
 		trace_ipi_entry_rcuidle(ipi_types[ipinr]);
-		__inc_irq_stat(cpu, ipi_irqs[ipinr]);
-	}
 
 	switch (ipinr) {
 	case IPI_RESCHEDULE:
@@ -992,7 +986,7 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 		int err;
 
 		err = request_percpu_irq(ipi_base + i, ipi_handler,
-					 "IPI", &irq_stat);
+					 "IPI", &cpu_number);
 		WARN_ON(err);
 
 		ipi_desc[i] = irq_to_desc(ipi_base + i);
