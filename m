Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7305828A8EF
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 20:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbgJKR7z (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388449AbgJKR5e (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5475AC0613D5;
        Sun, 11 Oct 2020 10:57:34 -0700 (PDT)
Date:   Sun, 11 Oct 2020 17:57:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439052;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5GqNK3c69FMn1tLSVuecHuP3TgqHjb4VlnThF3ZWOtA=;
        b=G0kBgJ55CY2JqoOC+oTrZthqREbufXvJy1FAa1o6Ljfb+cOtveE9y4oXTbbMnlEPmnZr47
        DorgeiBZkKaJaIi4Fy6km/Y+5MJSxllFEC5MM3CREuYLW4hXui59YUCXdcHRFG6Vngz9zd
        CwWnNVnUXW+Kwn6hSmzNwLjoHUYzoGLincVfViScAHT4AUXu/lmNofT1V7DTC7+L3awX7V
        6RlkoN8milUzkMXMiu7VIyVdkcelzurAZqSRFmQ5ShS7OL4/KpjwpytzFL73CqBqlD340Q
        Rw4oo6rDAb+Ev3KJT0WNBZxcODWYUpLvXugC+5Fwvpn2CNppKBKxf1zLPu+ijA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439052;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5GqNK3c69FMn1tLSVuecHuP3TgqHjb4VlnThF3ZWOtA=;
        b=HGn2DKko4wJjo/d26vmd7x5gNbUgi4B+klw3lyNkgtu1YtVeWpBwvjkE0Kx6f+ySNxy4D6
        mpOZ1HKGE+ZMTQAA==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] arm64: Kill __smp_cross_call and co
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243905212.7002.6551551247016403135.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5cebfd2d47c214f69d918e3d34ad183c061eddb2
Gitweb:        https://git.kernel.org/tip/5cebfd2d47c214f69d918e3d34ad183c061eddb2
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sat, 09 May 2020 14:00:23 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 17 Sep 2020 16:37:28 +01:00

arm64: Kill __smp_cross_call and co

The old IPI registration interface is now unused on arm64, so let's
get rid of it.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/irq_work.h |  4 +---
 arch/arm64/include/asm/smp.h      | 12 +---------
 arch/arm64/kernel/smp.c           | 38 +++++-------------------------
 3 files changed, 8 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/include/asm/irq_work.h b/arch/arm64/include/asm/irq_work.h
index 8a1ef19..a102028 100644
--- a/arch/arm64/include/asm/irq_work.h
+++ b/arch/arm64/include/asm/irq_work.h
@@ -2,11 +2,9 @@
 #ifndef __ASM_IRQ_WORK_H
 #define __ASM_IRQ_WORK_H
 
-#include <asm/smp.h>
-
 static inline bool arch_irq_work_has_interrupt(void)
 {
-	return !!__smp_cross_call;
+	return true;
 }
 
 #endif /* __ASM_IRQ_WORK_H */
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 57c5db1..c298ad0 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -61,24 +61,12 @@ struct seq_file;
 extern void show_ipi_list(struct seq_file *p, int prec);
 
 /*
- * Called from C code, this handles an IPI.
- */
-extern void handle_IPI(int ipinr, struct pt_regs *regs);
-
-/*
  * Discover the set of possible CPUs and determine their
  * SMP operations.
  */
 extern void smp_init_cpus(void);
 
 /*
- * Provide a function to raise an IPI cross call on CPUs in callmap.
- */
-extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));
-
-extern void (*__smp_cross_call)(const struct cpumask *, unsigned int);
-
-/*
  * Register IPI interrupts with the arch SMP code
  */
 extern void set_smp_ipi_range(int ipi_base, int nr_ipi);
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 00c9db1..58fb155 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -782,13 +782,6 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
-void (*__smp_cross_call)(const struct cpumask *, unsigned int);
-
-void __init set_smp_cross_call(void (*fn)(const struct cpumask *, unsigned int))
-{
-	__smp_cross_call = fn;
-}
-
 static const char *ipi_types[NR_IPI] __tracepoint_string = {
 #define S(x,s)	[x] = s
 	S(IPI_RESCHEDULE, "Rescheduling interrupts"),
@@ -800,11 +793,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	S(IPI_WAKEUP, "CPU wake-up interrupts"),
 };
 
-static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
-{
-	trace_ipi_raise(target, ipi_types[ipinr]);
-	__smp_cross_call(target, ipinr);
-}
+static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
 
 void show_ipi_list(struct seq_file *p, int prec)
 {
@@ -851,8 +840,7 @@ void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
 #ifdef CONFIG_IRQ_WORK
 void arch_irq_work_raise(void)
 {
-	if (__smp_cross_call)
-		smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
+	smp_cross_call(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
 }
 #endif
 
@@ -959,34 +947,23 @@ static void do_handle_IPI(int ipinr)
 		trace_ipi_exit_rcuidle(ipi_types[ipinr]);
 }
 
-/* Legacy version, should go away once all irqchips have been converted */
-void handle_IPI(int ipinr, struct pt_regs *regs)
-{
-	struct pt_regs *old_regs = set_irq_regs(regs);
-
-	irq_enter();
-	do_handle_IPI(ipinr);
-	irq_exit();
-
-	set_irq_regs(old_regs);
-}
-
 static irqreturn_t ipi_handler(int irq, void *data)
 {
 	do_handle_IPI(irq - ipi_irq_base);
 	return IRQ_HANDLED;
 }
 
-static void ipi_send(const struct cpumask *target, unsigned int ipi)
+static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 {
-	__ipi_send_mask(ipi_desc[ipi], target);
+	trace_ipi_raise(target, ipi_types[ipinr]);
+	__ipi_send_mask(ipi_desc[ipinr], target);
 }
 
 static void ipi_setup(int cpu)
 {
 	int i;
 
-	if (!ipi_irq_base)
+	if (WARN_ON_ONCE(!ipi_irq_base))
 		return;
 
 	for (i = 0; i < nr_ipi; i++)
@@ -997,7 +974,7 @@ static void ipi_teardown(int cpu)
 {
 	int i;
 
-	if (!ipi_irq_base)
+	if (WARN_ON_ONCE(!ipi_irq_base))
 		return;
 
 	for (i = 0; i < nr_ipi; i++)
@@ -1023,7 +1000,6 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 	}
 
 	ipi_irq_base = ipi_base;
-	__smp_cross_call = ipi_send;
 
 	/* Setup the boot CPU immediately */
 	ipi_setup(smp_processor_id());
