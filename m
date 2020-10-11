Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE17528A8C9
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbgJKR6d (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:58:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40206 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388500AbgJKR5q (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:46 -0400
Date:   Sun, 11 Oct 2020 17:57:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439063;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=04HG0onsha98LWJrObN5ZfHrQ76LrYLG8PQyQrBLqwM=;
        b=B7+urzbCgcbkoPjsl12C0wgL1ScbmEJ6uWSQkBNB6zoPKhsUO9XGMxwzWsefv+32bTbC2e
        /0jVbvlBUih379QluTKJnr25MhM7GTj+Z3POz5N+t866wvBG79F8KB0g7MYypVhu6PCfcV
        hUySvOWRxikl7wSUSTdWzMHHy2rwt5ROJpn4+fpU8wuVZ6JsGnLZnN1ntbkMf5TfZS2y/+
        XdthA5YcjLigQpBAEgjiJm4AEXpA935HroGKlPf31diC6gqP0dvnc2fPQTLFtfkVMd9Q7+
        C8o5z6rf1KMpeF4ixzeg2O/wPA6geVDJr1178ggJBhV9bQPHz9wXyCtF8ePgzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439063;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=04HG0onsha98LWJrObN5ZfHrQ76LrYLG8PQyQrBLqwM=;
        b=OMbYlGxUMRdPgP4/E8DNjgNQFOwNwAig12qzgA/bEAVs1yZ1E45UNFpqaQpNcofc2oFwq9
        zOjzDT9pLrOzTPDQ==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] ARM: Allow IPIs to be handled as normal interrupts
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243906272.7002.13902223895922484364.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     56afcd3dbd1995c526bfbd920cebde6158b22c4a
Gitweb:        https://git.kernel.org/tip/56afcd3dbd1995c526bfbd920cebde6158b22c4a
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 23 Jun 2020 20:38:41 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 13 Sep 2020 17:05:39 +01:00

ARM: Allow IPIs to be handled as normal interrupts

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
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/Kconfig           |   1 +-
 arch/arm/include/asm/smp.h |   5 ++-
 arch/arm/kernel/smp.c      |  99 ++++++++++++++++++++++++++++++------
 3 files changed, 89 insertions(+), 16 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e00d94b..e67ef15 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -49,6 +49,7 @@ config ARM
 	select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
 	select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
+	select GENERIC_IRQ_IPI if SMP
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IDLE_POLL_SETUP
diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index a91f21e..0e29730 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -46,6 +46,11 @@ extern void smp_init_cpus(void);
 extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));
 
 /*
+ * Register IPI interrupts with the arch SMP code
+ */
+extern void set_smp_ipi_range(int ipi_base, int nr_ipi);
+
+/*
  * Called from platform specific assembly code, this is the
  * secondary CPU entry point.
  */
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 5d9da61..f21f784 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -69,14 +69,22 @@ enum ipi_msg_type {
 	 * CPU_BACKTRACE is special and not included in NR_IPI
 	 * or tracable with trace_ipi_*
 	 */
-	IPI_CPU_BACKTRACE,
+	IPI_CPU_BACKTRACE = NR_IPI,
 	/*
 	 * SGI8-15 can be reserved by secure firmware, and thus may
 	 * not be usable by the kernel. Please keep the above limited
 	 * to at most 8 entries.
 	 */
+	MAX_IPI
 };
 
+static int ipi_irq_base __read_mostly;
+static int nr_ipi __read_mostly = NR_IPI;
+static struct irq_desc *ipi_desc[MAX_IPI] __read_mostly;
+
+static void ipi_setup(int cpu);
+static void ipi_teardown(int cpu);
+
 static DECLARE_COMPLETION(cpu_running);
 
 static struct smp_operations smp_ops __ro_after_init;
@@ -247,6 +255,7 @@ int __cpu_disable(void)
 	 * and we must not schedule until we're ready to give up the cpu.
 	 */
 	set_cpu_online(cpu, false);
+	ipi_teardown(cpu);
 
 	/*
 	 * OK - migrate IRQs away from this CPU
@@ -422,6 +431,8 @@ asmlinkage void secondary_start_kernel(void)
 
 	notify_cpu_starting(cpu);
 
+	ipi_setup(cpu);
+
 	calibrate_delay();
 
 	smp_store_cpu_info(cpu);
@@ -627,10 +638,9 @@ asmlinkage void __exception_irq_entry do_IPI(int ipinr, struct pt_regs *regs)
 	handle_IPI(ipinr, regs);
 }
 
-void handle_IPI(int ipinr, struct pt_regs *regs)
+static void do_handle_IPI(int ipinr)
 {
 	unsigned int cpu = smp_processor_id();
-	struct pt_regs *old_regs = set_irq_regs(regs);
 
 	if ((unsigned)ipinr < NR_IPI) {
 		trace_ipi_entry_rcuidle(ipi_types[ipinr]);
@@ -643,9 +653,7 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 	case IPI_TIMER:
-		irq_enter();
 		tick_receive_broadcast();
-		irq_exit();
 		break;
 #endif
 
@@ -654,36 +662,26 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		break;
 
 	case IPI_CALL_FUNC:
-		irq_enter();
 		generic_smp_call_function_interrupt();
-		irq_exit();
 		break;
 
 	case IPI_CPU_STOP:
-		irq_enter();
 		ipi_cpu_stop(cpu);
-		irq_exit();
 		break;
 
 #ifdef CONFIG_IRQ_WORK
 	case IPI_IRQ_WORK:
-		irq_enter();
 		irq_work_run();
-		irq_exit();
 		break;
 #endif
 
 	case IPI_COMPLETION:
-		irq_enter();
 		ipi_complete(cpu);
-		irq_exit();
 		break;
 
 	case IPI_CPU_BACKTRACE:
 		printk_nmi_enter();
-		irq_enter();
-		nmi_cpu_backtrace(regs);
-		irq_exit();
+		nmi_cpu_backtrace(get_irq_regs());
 		printk_nmi_exit();
 		break;
 
@@ -695,9 +693,78 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 
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
+	WARN_ON(n < MAX_IPI);
+	nr_ipi = min(n, MAX_IPI);
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
+	set_smp_cross_call(ipi_send);
+
+	/* Setup the boot CPU immediately */
+	ipi_setup(smp_processor_id());
+}
+
 void smp_send_reschedule(int cpu)
 {
 	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
