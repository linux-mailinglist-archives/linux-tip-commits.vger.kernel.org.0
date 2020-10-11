Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3571328A8F5
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 20:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgJKSAG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 14:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388439AbgJKR5d (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6029C0613D2;
        Sun, 11 Oct 2020 10:57:32 -0700 (PDT)
Date:   Sun, 11 Oct 2020 17:57:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439051;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fBlGnrnLKjuAyfJNBgHXoVij86HOqkbpXd/LbTXqXDY=;
        b=bzOslkJ6EgGYENJzjYXLHkTKrp5LNDuba7poiCDtVIkRl67I7if6D6moSktsSuxbnKlyJ4
        5/5M2/9OcpWAWQXtNp34F7xmq20KHT5n5nf1IyI8kFeBJvLfRXoN0wSGaiobiEFHYnaT5R
        OenNfnhuGuaVyMFHraeUyRHjxEgM1n7d0BtrbOWvfzyNgBFYGAIWxkWcTRSPyVWA3iQWkt
        Y58Mof6kpRAdXq/rYU6U1WRJNqsVfsj1zW1N8WJ7S29Lzxe4yO2Lqscs3Fgjg+dZm23cRz
        NilI+kItUjo4GbwF4AJ8//BfaO4ufXIeSbSN2vfbXqF6e8QpZm+/BrGEIhQ1KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439051;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fBlGnrnLKjuAyfJNBgHXoVij86HOqkbpXd/LbTXqXDY=;
        b=XeblVcCOm3gjrEp/DeOd6XFohY0YRsahX3pXUbbsF5QMwaaQ0QVbmnIrAgge226Aev/NPa
        /+Oq/WrS3J0q1WDg==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] ARM: Remove custom IRQ stat accounting
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243905059.7002.17153359299383090494.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5ebf353af22c89d18964bb3b877a95200dfe07b9
Gitweb:        https://git.kernel.org/tip/5ebf353af22c89d18964bb3b877a95200dfe07b9
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 23 Jun 2020 21:15:00 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 17 Sep 2020 16:37:28 +01:00

ARM: Remove custom IRQ stat accounting

Let's switch the arm code to the core accounting, which already
does everything we need.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/include/asm/hardirq.h | 17 -----------------
 arch/arm/kernel/irq.c          |  1 -
 arch/arm/kernel/smp.c          | 21 +++++----------------
 3 files changed, 5 insertions(+), 34 deletions(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index 7a88f16..b95848e 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -6,29 +6,12 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
-/* number of IPIS _not_ including IPI_CPU_BACKTRACE */
-#define NR_IPI	7
-
 typedef struct {
 	unsigned int __softirq_pending;
-#ifdef CONFIG_SMP
-	unsigned int ipi_irqs[NR_IPI];
-#endif
 } ____cacheline_aligned irq_cpustat_t;
 
 #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
 
-#define __inc_irq_stat(cpu, member)	__IRQ_STAT(cpu, member)++
-#define __get_irq_stat(cpu, member)	__IRQ_STAT(cpu, member)
-
-#ifdef CONFIG_SMP
-u64 smp_irq_stat_cpu(unsigned int cpu);
-#else
-#define smp_irq_stat_cpu(cpu)	0
-#endif
-
-#define arch_irq_stat_cpu	smp_irq_stat_cpu
-
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
 
 #endif /* __ASM_HARDIRQ_H */
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index ee51403..698b6f6 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -18,7 +18,6 @@
  *  IRQ's are in fact implemented a bit like signal handlers for the kernel.
  *  Naturally it's not a 1:1 relation, but there are similarities.
  */
-#include <linux/kernel_stat.h>
 #include <linux/signal.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index d51e649..00327fa 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -26,6 +26,7 @@
 #include <linux/completion.h>
 #include <linux/cpufreq.h>
 #include <linux/irq_work.h>
+#include <linux/kernel_stat.h>
 
 #include <linux/atomic.h>
 #include <asm/bugs.h>
@@ -65,6 +66,7 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 	IPI_IRQ_WORK,
 	IPI_COMPLETION,
+	NR_IPI,
 	/*
 	 * CPU_BACKTRACE is special and not included in NR_IPI
 	 * or tracable with trace_ipi_*
@@ -529,27 +531,16 @@ void show_ipi_list(struct seq_file *p, int prec)
 	unsigned int cpu, i;
 
 	for (i = 0; i < NR_IPI; i++) {
+		unsigned int irq = irq_desc_get_irq(ipi_desc[i]);
 		seq_printf(p, "%*s%u: ", prec - 1, "IPI", i);
 
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10u ",
-				   __get_irq_stat(cpu, ipi_irqs[i]));
+			seq_printf(p, "%10u ", kstat_irqs_cpu(irq, cpu));
 
 		seq_printf(p, " %s\n", ipi_types[i]);
 	}
 }
 
-u64 smp_irq_stat_cpu(unsigned int cpu)
-{
-	u64 sum = 0;
-	int i;
-
-	for (i = 0; i < NR_IPI; i++)
-		sum += __get_irq_stat(cpu, ipi_irqs[i]);
-
-	return sum;
-}
-
 void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 {
 	smp_cross_call(mask, IPI_CALL_FUNC);
@@ -630,10 +621,8 @@ static void do_handle_IPI(int ipinr)
 {
 	unsigned int cpu = smp_processor_id();
 
-	if ((unsigned)ipinr < NR_IPI) {
+	if ((unsigned)ipinr < NR_IPI)
 		trace_ipi_entry_rcuidle(ipi_types[ipinr]);
-		__inc_irq_stat(cpu, ipi_irqs[ipinr]);
-	}
 
 	switch (ipinr) {
 	case IPI_WAKEUP:
