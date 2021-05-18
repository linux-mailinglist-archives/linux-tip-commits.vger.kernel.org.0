Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDBF3878FF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 May 2021 14:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349191AbhERMlz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 18 May 2021 08:41:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59916 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241412AbhERMly (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 18 May 2021 08:41:54 -0400
Date:   Tue, 18 May 2021 12:40:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621341635;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RMsXaE9U3vAnPdSm8fV/PmSPqQ7FpExXGvKWVNt3Yco=;
        b=hhsRvAQJXaxHyFRX4NS5sYVjswL+4q8DFQNAmlhZkNKEtYaDTTiFEAOtlTnu/n+jjoMxV3
        WbK+SIeGjTftHXqmLBAWVGRtkddfUmliyIjDpxNpTi6/LV0aLabvnXZV+6fDUb42iNGHfU
        /jmiFqdq1aUA0+AzNraxZE+77djjnZiU7flVEuYiV9NQGWjeLVKWDhlseBpzHNz07Erm7u
        jw4L6H1+myRn004Sxp7++hslmlB/rGrTUkxHj7ObP2N7v/tCCSSbeKgcvoRf6SVeVsjV4w
        1ilOcSV3aYzfp74O3J0zO/YR4rI1M0sfu4094O9JzQ2dQPU9nURgm66n64LHOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621341635;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RMsXaE9U3vAnPdSm8fV/PmSPqQ7FpExXGvKWVNt3Yco=;
        b=01bG+blSArA2mBweQ6aHNCo3m7ojvgOnsbAI8O8MA8ngBpKRXM2oEdxeRo4XHOB3kvVq2E
        9qxGiinuEjvry1BQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/idt: Rework IDT setup for boot CPU
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210507114000.569244755@linutronix.de>
References: <20210507114000.569244755@linutronix.de>
MIME-Version: 1.0
Message-ID: <162134163353.29796.1887942777115522727.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     1f2b9e4acea8e6a39a7c2159d9cbd04583a729f5
Gitweb:        https://git.kernel.org/tip/1f2b9e4acea8e6a39a7c2159d9cbd04583a729f5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 07 May 2021 13:02:12 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 May 2021 14:33:54 +02:00

x86/idt: Rework IDT setup for boot CPU

A basic IDT setup for the boot CPU has to be done before invoking
cpu_init() because that might trigger #GP when accessing certain MSRs. This
setup cannot install the IST variants on 64-bit because the TSS setup which
is required for ISTs to work happens in cpu_init(). That leaves a
theoretical window where a NMI would invoke the ASM entry point which
relies on IST being enabled on the kernel stack which is undefined
behaviour.

This setup logic has never worked correctly, but on the other hand a NMI
hitting the boot CPU before it has fully set up the IDT would be fatal
anyway. So the small window between the wrong NMI gate and the IST based
NMI gate is not really adding a substantial amount of risk.

But the setup logic is nevertheless more convoluted than necessary. The
recent separation of the TSS setup into a separate function to ensure that
setup so it can setup TSS first, then initialize IDT with the IST variants
before invoking cpu_init() and get rid of the post cpu_init() IST setup.

Move the invocation of cpu_init_exception_handling() ahead of
idt_setup_traps() and merge the IST setup into the default setup table.

Reported-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Lai Jiangshan <laijs@linux.alibaba.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210507114000.569244755@linutronix.de
---
 arch/x86/include/asm/desc.h |  2 +--
 arch/x86/kernel/idt.c       | 40 ++++++++++--------------------------
 arch/x86/kernel/traps.c     |  7 ++----
 3 files changed, 15 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 476082a..96021e9 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -421,10 +421,8 @@ extern bool idt_is_f00f_address(unsigned long address);
 
 #ifdef CONFIG_X86_64
 extern void idt_setup_early_pf(void);
-extern void idt_setup_ist_traps(void);
 #else
 static inline void idt_setup_early_pf(void) { }
-static inline void idt_setup_ist_traps(void) { }
 #endif
 
 extern void idt_invalidate(void *addr);
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index d552f17..6cce604 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -35,12 +35,16 @@
 #define SYSG(_vector, _addr)				\
 	G(_vector, _addr, DEFAULT_STACK, GATE_INTERRUPT, DPL3, __KERNEL_CS)
 
+#ifdef CONFIG_X86_64
 /*
  * Interrupt gate with interrupt stack. The _ist index is the index in
  * the tss.ist[] array, but for the descriptor it needs to start at 1.
  */
 #define ISTG(_vector, _addr, _ist)			\
 	G(_vector, _addr, _ist + 1, GATE_INTERRUPT, DPL0, __KERNEL_CS)
+#else
+#define ISTG(_vector, _addr, _ist)	INTG(_vector, _addr)
+#endif
 
 /* Task gate */
 #define TSKG(_vector, _gdt)				\
@@ -74,7 +78,7 @@ static const __initconst struct idt_data early_idts[] = {
  */
 static const __initconst struct idt_data def_idts[] = {
 	INTG(X86_TRAP_DE,		asm_exc_divide_error),
-	INTG(X86_TRAP_NMI,		asm_exc_nmi),
+	ISTG(X86_TRAP_NMI,		asm_exc_nmi, IST_INDEX_NMI),
 	INTG(X86_TRAP_BR,		asm_exc_bounds),
 	INTG(X86_TRAP_UD,		asm_exc_invalid_op),
 	INTG(X86_TRAP_NM,		asm_exc_device_not_available),
@@ -91,12 +95,16 @@ static const __initconst struct idt_data def_idts[] = {
 #ifdef CONFIG_X86_32
 	TSKG(X86_TRAP_DF,		GDT_ENTRY_DOUBLEFAULT_TSS),
 #else
-	INTG(X86_TRAP_DF,		asm_exc_double_fault),
+	ISTG(X86_TRAP_DF,		asm_exc_double_fault, IST_INDEX_DF),
 #endif
-	INTG(X86_TRAP_DB,		asm_exc_debug),
+	ISTG(X86_TRAP_DB,		asm_exc_debug, IST_INDEX_DB),
 
 #ifdef CONFIG_X86_MCE
-	INTG(X86_TRAP_MC,		asm_exc_machine_check),
+	ISTG(X86_TRAP_MC,		asm_exc_machine_check, IST_INDEX_MCE),
+#endif
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	ISTG(X86_TRAP_VC,		asm_exc_vmm_communication, IST_INDEX_VC),
 #endif
 
 	SYSG(X86_TRAP_OF,		asm_exc_overflow),
@@ -221,22 +229,6 @@ static const __initconst struct idt_data early_pf_idts[] = {
 	INTG(X86_TRAP_PF,		asm_exc_page_fault),
 };
 
-/*
- * The exceptions which use Interrupt stacks. They are setup after
- * cpu_init() when the TSS has been initialized.
- */
-static const __initconst struct idt_data ist_idts[] = {
-	ISTG(X86_TRAP_DB,	asm_exc_debug,			IST_INDEX_DB),
-	ISTG(X86_TRAP_NMI,	asm_exc_nmi,			IST_INDEX_NMI),
-	ISTG(X86_TRAP_DF,	asm_exc_double_fault,		IST_INDEX_DF),
-#ifdef CONFIG_X86_MCE
-	ISTG(X86_TRAP_MC,	asm_exc_machine_check,		IST_INDEX_MCE),
-#endif
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-	ISTG(X86_TRAP_VC,	asm_exc_vmm_communication,	IST_INDEX_VC),
-#endif
-};
-
 /**
  * idt_setup_early_pf - Initialize the idt table with early pagefault handler
  *
@@ -254,14 +246,6 @@ void __init idt_setup_early_pf(void)
 	idt_setup_from_table(idt_table, early_pf_idts,
 			     ARRAY_SIZE(early_pf_idts), true);
 }
-
-/**
- * idt_setup_ist_traps - Initialize the idt table with traps using IST
- */
-void __init idt_setup_ist_traps(void)
-{
-	idt_setup_from_table(idt_table, ist_idts, ARRAY_SIZE(ist_idts), true);
-}
 #endif
 
 static void __init idt_map_in_cea(void)
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 41f7dc4..ed540e0 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1160,10 +1160,9 @@ void __init trap_init(void)
 	/* Init GHCB memory pages when running as an SEV-ES guest */
 	sev_es_init_vc_handling();
 
-	idt_setup_traps();
-
+	/* Initialize TSS before setting up traps so ISTs work */
 	cpu_init_exception_handling();
+	/* Setup traps as cpu_init() might #GP */
+	idt_setup_traps();
 	cpu_init();
-
-	idt_setup_ist_traps();
 }
