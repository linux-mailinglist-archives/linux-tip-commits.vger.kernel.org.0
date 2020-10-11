Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D98928A8CC
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbgJKR6v (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388510AbgJKR5p (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A78C0613D0;
        Sun, 11 Oct 2020 10:57:45 -0700 (PDT)
Date:   Sun, 11 Oct 2020 17:57:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439064;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5qSqgT2O4s48DkM9jZY7PcEhQ2XNlzEBHN5kO5ZLrDI=;
        b=tpj0zJL5CdleOENo6m6ltd/MkpL3glJkAd2tBcHTym3L3Ak++TZuASStP/lBZVRb5On5Eg
        bzpdw+ZC4xKSJwrOnAdfR9GL+OKQeA5lko0FqCjGE+ApXQx/lS8CrsZYXiPOVLcn0as9PY
        0j/LptKoe8EpGKNdoCNyLkIqFR4rvcG4R6uXyNeQM2ESzF9z1a89TrLxKqJEoHjOKt7oox
        CWVbSaZ162wcrQo/KE+wQskQ1/Jl2LcxMtJGjiRsYXQ2GqJivH+S8/3e6mc8ypcILQU3IE
        u2DEIO7ZjoSrGHIrg3JMbYdr02ki8VTBM/CHXAn4Lz3hsJo+bK0XJhxXSYc4lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439064;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5qSqgT2O4s48DkM9jZY7PcEhQ2XNlzEBHN5kO5ZLrDI=;
        b=FtAI259XlRe7mcclVGFVdfzEXU5ztgCw1N3JFSixq6R3SPfnmtEtbajOh+QDJkbj/wi9T3
        eNMrcGVPv3sj7eDg==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] arm64: Allow IPIs to be handled as normal interrupts
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243906323.7002.1102761262817691399.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d3afc7f12987581eb0d1215b518d719fb9d762da
Gitweb:        https://git.kernel.org/tip/d3afc7f12987581eb0d1215b518d719fb9d762da
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sat, 25 Apr 2020 15:03:47 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 13 Sep 2020 17:05:24 +01:00

arm64: Allow IPIs to be handled as normal interrupts

In order to deal with IPIs as normal interrupts, let's add
a new way to register them with the architecture code.

set_smp_ipi_range() takes a range of interrupts, and allows
the arch code to request them as if the were normal interrupts.
A standard handler is then called by the core IRQ code to deal
with the IPI.

This means that we don't need to call irq_enter/irq_exit, and
that we don't need to deal with set_irq_regs either. So let's
move the dispatcher into its own function, and leave handle_IPI()
as a compatibility function.

On the sending side, let's make use of ipi_send_mask, which
already exists for this purpose.

One of the major difference is that we end up, in some cases
(such as when performing IRQ time accounting on the scheduler
IPI), end up with nested irq_enter()/irq_exit() pairs.
Other than the (relatively small) overhead, there should be
no consequences to it (these pairs are designed to nest
correctly, and the accounting shouldn't be off).

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/Kconfig           |  1 +-
 arch/arm64/include/asm/smp.h |  5 ++-
 arch/arm64/kernel/smp.c      | 93 ++++++++++++++++++++++++++++++-----
 3 files changed, 87 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d23283..d0fdbe5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -106,6 +106,7 @@ config ARM64
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
+	select GENERIC_IRQ_IPI
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 0eadbf9..57c5db1 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -79,6 +79,11 @@ extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));
 extern void (*__smp_cross_call)(const struct cpumask *, unsigned int);
 
 /*
+ * Register IPI interrupts with the arch SMP code
+ */
+extern void set_smp_ipi_range(int ipi_base, int nr_ipi);
+
+/*
  * Called from the secondary holding pen, this is the secondary CPU entry point.
  */
 asmlinkage void secondary_start_kernel(void);
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 355ee9e..00c9db1 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -75,6 +75,13 @@ enum ipi_msg_type {
 	IPI_WAKEUP
 };
 
+static int ipi_irq_base __read_mostly;
+static int nr_ipi __read_mostly = NR_IPI;
+static struct irq_desc *ipi_desc[NR_IPI] __read_mostly;
+
+static void ipi_setup(int cpu);
+static void ipi_teardown(int cpu);
+
 #ifdef CONFIG_HOTPLUG_CPU
 static int op_cpu_kill(unsigned int cpu);
 #else
@@ -237,6 +244,8 @@ asmlinkage notrace void secondary_start_kernel(void)
 	 */
 	notify_cpu_starting(cpu);
 
+	ipi_setup(cpu);
+
 	store_cpu_topology(cpu);
 	numa_add_cpu(cpu);
 
@@ -302,6 +311,7 @@ int __cpu_disable(void)
 	 * and we must not schedule until we're ready to give up the cpu.
 	 */
 	set_cpu_online(cpu, false);
+	ipi_teardown(cpu);
 
 	/*
 	 * OK - migrate IRQs away from this CPU
@@ -890,10 +900,9 @@ static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 /*
  * Main handler for inter-processor interrupts
  */
-void handle_IPI(int ipinr, struct pt_regs *regs)
+static void do_handle_IPI(int ipinr)
 {
 	unsigned int cpu = smp_processor_id();
-	struct pt_regs *old_regs = set_irq_regs(regs);
 
 	if ((unsigned)ipinr < NR_IPI) {
 		trace_ipi_entry_rcuidle(ipi_types[ipinr]);
@@ -906,21 +915,16 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		break;
 
 	case IPI_CALL_FUNC:
-		irq_enter();
 		generic_smp_call_function_interrupt();
-		irq_exit();
 		break;
 
 	case IPI_CPU_STOP:
-		irq_enter();
 		local_cpu_stop();
-		irq_exit();
 		break;
 
 	case IPI_CPU_CRASH_STOP:
 		if (IS_ENABLED(CONFIG_KEXEC_CORE)) {
-			irq_enter();
-			ipi_cpu_crash_stop(cpu, regs);
+			ipi_cpu_crash_stop(cpu, get_irq_regs());
 
 			unreachable();
 		}
@@ -928,17 +932,13 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 	case IPI_TIMER:
-		irq_enter();
 		tick_receive_broadcast();
-		irq_exit();
 		break;
 #endif
 
 #ifdef CONFIG_IRQ_WORK
 	case IPI_IRQ_WORK:
-		irq_enter();
 		irq_work_run();
-		irq_exit();
 		break;
 #endif
 
@@ -957,9 +957,78 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 	if ((unsigned)ipinr < NR_IPI)
 		trace_ipi_exit_rcuidle(ipi_types[ipinr]);
+}
+
+/* Legacy version, should go away once all irqchips have been converted */
+void handle_IPI(int ipinr, struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	irq_enter();
+	do_handle_IPI(ipinr);
+	irq_exit();
+
 	set_irq_regs(old_regs);
 }
 
+static irqreturn_t ipi_handler(int irq, void *data)
+{
+	do_handle_IPI(irq - ipi_irq_base);
+	return IRQ_HANDLED;
+}
+
+static void ipi_send(const struct cpumask *target, unsigned int ipi)
+{
+	__ipi_send_mask(ipi_desc[ipi], target);
+}
+
+static void ipi_setup(int cpu)
+{
+	int i;
+
+	if (!ipi_irq_base)
+		return;
+
+	for (i = 0; i < nr_ipi; i++)
+		enable_percpu_irq(ipi_irq_base + i, 0);
+}
+
+static void ipi_teardown(int cpu)
+{
+	int i;
+
+	if (!ipi_irq_base)
+		return;
+
+	for (i = 0; i < nr_ipi; i++)
+		disable_percpu_irq(ipi_irq_base + i);
+}
+
+void __init set_smp_ipi_range(int ipi_base, int n)
+{
+	int i;
+
+	WARN_ON(n < NR_IPI);
+	nr_ipi = min(n, NR_IPI);
+
+	for (i = 0; i < nr_ipi; i++) {
+		int err;
+
+		err = request_percpu_irq(ipi_base + i, ipi_handler,
+					 "IPI", &irq_stat);
+		WARN_ON(err);
+
+		ipi_desc[i] = irq_to_desc(ipi_base + i);
+		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
+	}
+
+	ipi_irq_base = ipi_base;
+	__smp_cross_call = ipi_send;
+
+	/* Setup the boot CPU immediately */
+	ipi_setup(smp_processor_id());
+}
+
 void smp_send_reschedule(int cpu)
 {
 	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
