Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B28528A8F1
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 20:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbgJKR7z (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:59:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40076 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388435AbgJKR5e (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:34 -0400
Date:   Sun, 11 Oct 2020 17:57:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439051;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AlmDU2rO4y/SlSRUsz9AmxWf54iH85p3PrqNd2PNEuI=;
        b=xA+nDdSXGXch/zdsCl2j4skkoJ2zPGttuAL5pdKmpD6K4JwP8l6xC8cI0PwbECeMdRmbYY
        OY5siVVFIbbhTDQNYJfAtV8u13A81rGjm2a9PHnyxvw7NyGPbDv2gI+IbyNTZVIaZnR8IO
        V8BARCcg/OUTtGh0/6vS5PYuTlSQ1r005v5IWxQLQXNc7l/7Fk6ltDg44StSTaskkom3V6
        kyIkmzJzykXiCC7FKFlp9bTEys0SeFx7IcgwWaC63pHt55eitDQK3+bsr1+Ov3R7ZLu22l
        f6XqUjuPrxEUdeGSwkkJE/MjPepAMnwOqPtgI/BTlkAnoFirnCP9IYf+j5vp5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439051;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AlmDU2rO4y/SlSRUsz9AmxWf54iH85p3PrqNd2PNEuI=;
        b=TWBe5aHMgLBMV2IDIBACOL1uaEq3rtC9hIdgNEly/SFMs1onGkOWtq6yq0zn8MQJCYCgP0
        4Cb6mqTfJ+EcSZDg==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] ARM: Kill __smp_cross_call and co
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243905108.7002.6252100978578102774.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     8aa837cb7a032884c787b15de81f7d9de8af0869
Gitweb:        https://git.kernel.org/tip/8aa837cb7a032884c787b15de81f7d9de8af0869
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 22 Jun 2020 22:15:54 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 17 Sep 2020 16:37:28 +01:00

ARM: Kill __smp_cross_call and co

The old IPI registration interface is now unused on arm, so let's
get rid of it.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/include/asm/smp.h |  6 ------
 arch/arm/kernel/smp.c      | 26 +++++++-------------------
 2 files changed, 7 insertions(+), 25 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 0e29730..0ca55a6 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -39,12 +39,6 @@ void handle_IPI(int ipinr, struct pt_regs *regs);
  */
 extern void smp_init_cpus(void);
 
-
-/*
- * Provide a function to raise an IPI cross call on CPUs in callmap.
- */
-extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));
-
 /*
  * Register IPI interrupts with the arch SMP code
  */
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index f21f784..d51e649 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -511,14 +511,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
-static void (*__smp_cross_call)(const struct cpumask *, unsigned int);
-
-void __init set_smp_cross_call(void (*fn)(const struct cpumask *, unsigned int))
-{
-	if (!__smp_cross_call)
-		__smp_cross_call = fn;
-}
-
 static const char *ipi_types[NR_IPI] __tracepoint_string = {
 #define S(x,s)	[x] = s
 	S(IPI_WAKEUP, "CPU wakeup interrupts"),
@@ -530,11 +522,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	S(IPI_COMPLETION, "completion interrupts"),
 };
 
-static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
-{
-	trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
-	__smp_cross_call(target, ipinr);
-}
+static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
 
 void show_ipi_list(struct seq_file *p, int prec)
 {
@@ -713,16 +701,17 @@ static irqreturn_t ipi_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void ipi_send(const struct cpumask *target, unsigned int ipi)
+static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 {
-	__ipi_send_mask(ipi_desc[ipi], target);
+	trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
+	__ipi_send_mask(ipi_desc[ipinr], target);
 }
 
 static void ipi_setup(int cpu)
 {
 	int i;
 
-	if (!ipi_irq_base)
+	if (WARN_ON_ONCE(!ipi_irq_base))
 		return;
 
 	for (i = 0; i < nr_ipi; i++)
@@ -733,7 +722,7 @@ static void ipi_teardown(int cpu)
 {
 	int i;
 
-	if (!ipi_irq_base)
+	if (WARN_ON_ONCE(!ipi_irq_base))
 		return;
 
 	for (i = 0; i < nr_ipi; i++)
@@ -759,7 +748,6 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 	}
 
 	ipi_irq_base = ipi_base;
-	set_smp_cross_call(ipi_send);
 
 	/* Setup the boot CPU immediately */
 	ipi_setup(smp_processor_id());
@@ -872,7 +860,7 @@ core_initcall(register_cpufreq_notifier);
 
 static void raise_nmi(cpumask_t *mask)
 {
-	__smp_cross_call(mask, IPI_CPU_BACKTRACE);
+	__ipi_send_mask(ipi_desc[IPI_CPU_BACKTRACE], mask);
 }
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
