Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027991E3B93
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 May 2020 10:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387989AbgE0IN6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 27 May 2020 04:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbgE0ILv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 27 May 2020 04:11:51 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E33C061A0F;
        Wed, 27 May 2020 01:11:51 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAD-0002We-CK; Wed, 27 May 2020 10:11:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EFA471C03A9;
        Wed, 27 May 2020 10:11:48 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:48 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Convert various system vectors
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202119.464812973@linutronix.de>
References: <20200521202119.464812973@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056710883.17951.5155427799307350668.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     41a5e11a9f35e97cc8872ffdb379319ea584f997
Gitweb:        https://git.kernel.org/tip/41a5e11a9f35e97cc8872ffdb379319ea584f997
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:41 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:28 +02:00

x86/entry: Convert various system vectors

Convert various system vectors to IDTENTRY_SYSVEC:

  - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
  - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
  - Remove the ASM idtentries in 64-bit
  - Remove the BUILD_INTERRUPT entries in 32-bit
  - Remove the old prototypes

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202119.464812973@linutronix.de
---
 arch/x86/entry/entry_64.S             | 19 +------------------
 arch/x86/include/asm/apic.h           | 13 +------------
 arch/x86/include/asm/entry_arch.h     | 25 +-----------------------
 arch/x86/include/asm/hw_irq.h         |  6 +------
 arch/x86/include/asm/idtentry.h       | 22 ++++++++++++++++++++-
 arch/x86/include/asm/irq_work.h       |  1 +-
 arch/x86/include/asm/traps.h          |  5 +-----
 arch/x86/include/asm/uv/uv_bau.h      |  8 +------
 arch/x86/kernel/cpu/mce/amd.c         |  5 ++---
 arch/x86/kernel/cpu/mce/therm_throt.c |  5 ++---
 arch/x86/kernel/cpu/mce/threshold.c   |  5 ++---
 arch/x86/kernel/idt.c                 | 28 +++++++++++++-------------
 arch/x86/kernel/irq_work.c            |  6 +++---
 arch/x86/platform/uv/tlb_uv.c         |  2 +-
 14 files changed, 48 insertions(+), 102 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f3ccb27..2301f62 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -956,9 +956,6 @@ apicinterrupt3 \num \sym \do_sym
 POP_SECTION_IRQENTRY
 .endm
 
-#ifdef CONFIG_X86_UV
-apicinterrupt3 UV_BAU_MESSAGE			uv_bau_message_intr1		uv_bau_message_interrupt
-#endif
 
 #ifdef CONFIG_HAVE_KVM
 apicinterrupt3 POSTED_INTR_VECTOR		kvm_posted_intr_ipi		smp_kvm_posted_intr_ipi
@@ -966,26 +963,10 @@ apicinterrupt3 POSTED_INTR_WAKEUP_VECTOR	kvm_posted_intr_wakeup_ipi	smp_kvm_post
 apicinterrupt3 POSTED_INTR_NESTED_VECTOR	kvm_posted_intr_nested_ipi	smp_kvm_posted_intr_nested_ipi
 #endif
 
-#ifdef CONFIG_X86_MCE_THRESHOLD
-apicinterrupt THRESHOLD_APIC_VECTOR		threshold_interrupt		smp_threshold_interrupt
-#endif
-
-#ifdef CONFIG_X86_MCE_AMD
-apicinterrupt DEFERRED_ERROR_VECTOR		deferred_error_interrupt	smp_deferred_error_interrupt
-#endif
-
-#ifdef CONFIG_X86_THERMAL_VECTOR
-apicinterrupt THERMAL_APIC_VECTOR		thermal_interrupt		smp_thermal_interrupt
-#endif
-
 #ifdef CONFIG_SMP
 apicinterrupt RESCHEDULE_VECTOR			reschedule_interrupt		smp_reschedule_interrupt
 #endif
 
-#ifdef CONFIG_IRQ_WORK
-apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
-#endif
-
 /*
  * Reload gs selector with exception handling
  * edi:  new selector
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 19e94af..a541686 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -534,24 +534,11 @@ static inline void entering_ack_irq(void)
 	ack_APIC_irq();
 }
 
-static inline void ipi_entering_ack_irq(void)
-{
-	irq_enter();
-	ack_APIC_irq();
-	kvm_set_cpu_l1tf_flush_l1d();
-}
-
 static inline void exiting_irq(void)
 {
 	irq_exit();
 }
 
-static inline void exiting_ack_irq(void)
-{
-	ack_APIC_irq();
-	irq_exit();
-}
-
 extern void ioapic_zap_locks(void);
 
 #endif /* _ASM_X86_APIC_H */
diff --git a/arch/x86/include/asm/entry_arch.h b/arch/x86/include/asm/entry_arch.h
index 2e2055b..69a5320 100644
--- a/arch/x86/include/asm/entry_arch.h
+++ b/arch/x86/include/asm/entry_arch.h
@@ -20,28 +20,3 @@ BUILD_INTERRUPT(kvm_posted_intr_wakeup_ipi, POSTED_INTR_WAKEUP_VECTOR)
 BUILD_INTERRUPT(kvm_posted_intr_nested_ipi, POSTED_INTR_NESTED_VECTOR)
 #endif
 
-/*
- * every pentium local APIC has two 'local interrupts', with a
- * soft-definable vector attached to both interrupts, one of
- * which is a timer interrupt, the other one is error counter
- * overflow. Linux uses the local APIC timer interrupt to get
- * a much simpler SMP time architecture:
- */
-#ifdef CONFIG_X86_LOCAL_APIC
-
-#ifdef CONFIG_IRQ_WORK
-BUILD_INTERRUPT(irq_work_interrupt, IRQ_WORK_VECTOR)
-#endif
-
-#ifdef CONFIG_X86_THERMAL_VECTOR
-BUILD_INTERRUPT(thermal_interrupt,THERMAL_APIC_VECTOR)
-#endif
-
-#ifdef CONFIG_X86_MCE_THRESHOLD
-BUILD_INTERRUPT(threshold_interrupt,THRESHOLD_APIC_VECTOR)
-#endif
-
-#ifdef CONFIG_X86_MCE_AMD
-BUILD_INTERRUPT(deferred_error_interrupt, DEFERRED_ERROR_VECTOR)
-#endif
-#endif
diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 36a3869..7281c7e 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -32,15 +32,9 @@
 extern asmlinkage void kvm_posted_intr_ipi(void);
 extern asmlinkage void kvm_posted_intr_wakeup_ipi(void);
 extern asmlinkage void kvm_posted_intr_nested_ipi(void);
-extern asmlinkage void irq_work_interrupt(void);
-extern asmlinkage void uv_bau_message_intr1(void);
 
-extern asmlinkage void thermal_interrupt(void);
 extern asmlinkage void reschedule_interrupt(void);
 
-extern asmlinkage void threshold_interrupt(void);
-extern asmlinkage void deferred_error_interrupt(void);
-
 #ifdef	CONFIG_X86_LOCAL_APIC
 struct irq_data;
 struct pci_dev;
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 82cca1f..0eedfca 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -584,6 +584,28 @@ DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_SINGLE_VECTOR,	sysvec_call_function_single
 DECLARE_IDTENTRY_SYSVEC(CALL_FUNCTION_VECTOR,		sysvec_call_function);
 #endif
 
+#ifdef CONFIG_X86_LOCAL_APIC
+# ifdef CONFIG_X86_UV
+DECLARE_IDTENTRY_SYSVEC(UV_BAU_MESSAGE,			sysvec_uv_bau_message);
+# endif
+
+# ifdef CONFIG_X86_MCE_THRESHOLD
+DECLARE_IDTENTRY_SYSVEC(THRESHOLD_APIC_VECTOR,		sysvec_threshold);
+# endif
+
+# ifdef CONFIG_X86_MCE_AMD
+DECLARE_IDTENTRY_SYSVEC(DEFERRED_ERROR_VECTOR,		sysvec_deferred_error);
+# endif
+
+# ifdef CONFIG_X86_THERMAL_VECTOR
+DECLARE_IDTENTRY_SYSVEC(THERMAL_APIC_VECTOR,		sysvec_thermal);
+# endif
+
+# ifdef CONFIG_IRQ_WORK
+DECLARE_IDTENTRY_SYSVEC(IRQ_WORK_VECTOR,		sysvec_irq_work);
+# endif
+#endif
+
 #undef X86_TRAP_OTHER
 
 #endif
diff --git a/arch/x86/include/asm/irq_work.h b/arch/x86/include/asm/irq_work.h
index 80b35e3..800ffce 100644
--- a/arch/x86/include/asm/irq_work.h
+++ b/arch/x86/include/asm/irq_work.h
@@ -10,7 +10,6 @@ static inline bool arch_irq_work_has_interrupt(void)
 	return boot_cpu_has(X86_FEATURE_APIC);
 }
 extern void arch_irq_work_raise(void);
-extern __visible void smp_irq_work_interrupt(struct pt_regs *regs);
 #else
 static inline bool arch_irq_work_has_interrupt(void)
 {
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 0c40f37..714b1a3 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -34,11 +34,6 @@ static inline int get_si_code(unsigned long condition)
 extern int panic_on_unrecovered_nmi;
 
 void math_emulate(struct math_emu_info *);
-#ifndef CONFIG_X86_32
-asmlinkage void smp_thermal_interrupt(struct pt_regs *regs);
-asmlinkage void smp_threshold_interrupt(struct pt_regs *regs);
-asmlinkage void smp_deferred_error_interrupt(struct pt_regs *regs);
-#endif
 
 #ifdef CONFIG_VMAP_STACK
 void __noreturn handle_stack_overflow(const char *message,
diff --git a/arch/x86/include/asm/uv/uv_bau.h b/arch/x86/include/asm/uv/uv_bau.h
index 13687bf..f1188bd 100644
--- a/arch/x86/include/asm/uv/uv_bau.h
+++ b/arch/x86/include/asm/uv/uv_bau.h
@@ -12,6 +12,8 @@
 #define _ASM_X86_UV_UV_BAU_H
 
 #include <linux/bitmap.h>
+#include <asm/idtentry.h>
+
 #define BITSPERBYTE 8
 
 /*
@@ -799,12 +801,6 @@ static inline void bau_cpubits_clear(struct bau_local_cpumask *dstp, int nbits)
 	bitmap_zero(&dstp->bits, nbits);
 }
 
-extern void uv_bau_message_intr1(void);
-#ifdef CONFIG_TRACING
-#define trace_uv_bau_message_intr1 uv_bau_message_intr1
-#endif
-extern void uv_bau_timeout_intr1(void);
-
 struct atomic_short {
 	short counter;
 };
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 52de616..a906d68 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -907,14 +907,13 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 	mce_log(&m);
 }
 
-asmlinkage __visible void __irq_entry smp_deferred_error_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
 {
-	entering_irq();
 	trace_deferred_error_apic_entry(DEFERRED_ERROR_VECTOR);
 	inc_irq_stat(irq_deferred_error_count);
 	deferred_error_int_vector();
 	trace_deferred_error_apic_exit(DEFERRED_ERROR_VECTOR);
-	exiting_ack_irq();
+	ack_APIC_irq();
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
index f36dc07..a7cd2d2 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -614,14 +614,13 @@ static void unexpected_thermal_interrupt(void)
 
 static void (*smp_thermal_vector)(void) = unexpected_thermal_interrupt;
 
-asmlinkage __visible void __irq_entry smp_thermal_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_thermal)
 {
-	entering_irq();
 	trace_thermal_apic_entry(THERMAL_APIC_VECTOR);
 	inc_irq_stat(irq_thermal_count);
 	smp_thermal_vector();
 	trace_thermal_apic_exit(THERMAL_APIC_VECTOR);
-	exiting_ack_irq();
+	ack_APIC_irq();
 }
 
 /* Thermal monitoring depends on APIC, ACPI and clock modulation */
diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
index 28812cc..6a059a0 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -21,12 +21,11 @@ static void default_threshold_interrupt(void)
 
 void (*mce_threshold_vector)(void) = default_threshold_interrupt;
 
-asmlinkage __visible void __irq_entry smp_threshold_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_threshold)
 {
-	entering_irq();
 	trace_threshold_apic_entry(THRESHOLD_APIC_VECTOR);
 	inc_irq_stat(irq_threshold_count);
 	mce_threshold_vector();
 	trace_threshold_apic_exit(THRESHOLD_APIC_VECTOR);
-	exiting_ack_irq();
+	ack_APIC_irq();
 }
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 018a542..3d811d0 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -120,33 +120,33 @@ static const __initconst struct idt_data apic_idts[] = {
 #endif
 
 #ifdef CONFIG_X86_THERMAL_VECTOR
-	INTG(THERMAL_APIC_VECTOR,	thermal_interrupt),
+	INTG(THERMAL_APIC_VECTOR,		asm_sysvec_thermal),
 #endif
 
 #ifdef CONFIG_X86_MCE_THRESHOLD
-	INTG(THRESHOLD_APIC_VECTOR,	threshold_interrupt),
+	INTG(THRESHOLD_APIC_VECTOR,		asm_sysvec_threshold),
 #endif
 
 #ifdef CONFIG_X86_MCE_AMD
-	INTG(DEFERRED_ERROR_VECTOR,	deferred_error_interrupt),
+	INTG(DEFERRED_ERROR_VECTOR,		asm_sysvec_deferred_error),
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
-	INTG(LOCAL_TIMER_VECTOR,	asm_sysvec_apic_timer_interrupt),
-	INTG(X86_PLATFORM_IPI_VECTOR,	asm_sysvec_x86_platform_ipi),
+	INTG(LOCAL_TIMER_VECTOR,		asm_sysvec_apic_timer_interrupt),
+	INTG(X86_PLATFORM_IPI_VECTOR,		asm_sysvec_x86_platform_ipi),
 # ifdef CONFIG_HAVE_KVM
-	INTG(POSTED_INTR_VECTOR,	kvm_posted_intr_ipi),
-	INTG(POSTED_INTR_WAKEUP_VECTOR, kvm_posted_intr_wakeup_ipi),
-	INTG(POSTED_INTR_NESTED_VECTOR, kvm_posted_intr_nested_ipi),
+	INTG(POSTED_INTR_VECTOR,		kvm_posted_intr_ipi),
+	INTG(POSTED_INTR_WAKEUP_VECTOR,		kvm_posted_intr_wakeup_ipi),
+	INTG(POSTED_INTR_NESTED_VECTOR,		kvm_posted_intr_nested_ipi),
 # endif
 # ifdef CONFIG_IRQ_WORK
-	INTG(IRQ_WORK_VECTOR,		irq_work_interrupt),
+	INTG(IRQ_WORK_VECTOR,			asm_sysvec_irq_work),
 # endif
-#ifdef CONFIG_X86_UV
-	INTG(UV_BAU_MESSAGE,		uv_bau_message_intr1),
-#endif
-	INTG(SPURIOUS_APIC_VECTOR,	asm_sysvec_spurious_apic_interrupt),
-	INTG(ERROR_APIC_VECTOR,		asm_sysvec_error_interrupt),
+# ifdef CONFIG_X86_UV
+	INTG(UV_BAU_MESSAGE,			asm_sysvec_uv_bau_message),
+# endif
+	INTG(SPURIOUS_APIC_VECTOR,		asm_sysvec_spurious_apic_interrupt),
+	INTG(ERROR_APIC_VECTOR,			asm_sysvec_error_interrupt),
 #endif
 };
 
diff --git a/arch/x86/kernel/irq_work.c b/arch/x86/kernel/irq_work.c
index 80bee76..890d477 100644
--- a/arch/x86/kernel/irq_work.c
+++ b/arch/x86/kernel/irq_work.c
@@ -9,18 +9,18 @@
 #include <linux/irq_work.h>
 #include <linux/hardirq.h>
 #include <asm/apic.h>
+#include <asm/idtentry.h>
 #include <asm/trace/irq_vectors.h>
 #include <linux/interrupt.h>
 
 #ifdef CONFIG_X86_LOCAL_APIC
-__visible void __irq_entry smp_irq_work_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_irq_work)
 {
-	ipi_entering_ack_irq();
+	ack_APIC_irq();
 	trace_irq_work_entry(IRQ_WORK_VECTOR);
 	inc_irq_stat(apic_irq_work_irqs);
 	irq_work_run();
 	trace_irq_work_exit(IRQ_WORK_VECTOR);
-	exiting_irq();
 }
 
 void arch_irq_work_raise(void)
diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index 1fd321f..b02e406 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -1272,7 +1272,7 @@ static void process_uv2_message(struct msg_desc *mdp, struct bau_control *bcp)
  * (the resource will not be freed until noninterruptable cpus see this
  *  interrupt; hardware may timeout the s/w ack and reply ERROR)
  */
-void uv_bau_message_interrupt(struct pt_regs *regs)
+DEFINE_IDTENTRY_SYSVEC(sysvec_uv_bau_message)
 {
 	int count = 0;
 	cycles_t time_start;
