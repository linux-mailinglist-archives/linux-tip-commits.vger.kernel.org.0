Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF0531668E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 13:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhBJMZY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 07:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbhBJMXr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 07:23:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0E0C0613D6;
        Wed, 10 Feb 2021 04:23:04 -0800 (PST)
Date:   Wed, 10 Feb 2021 12:23:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612959781;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EPfb9Ak/7oZVp+rq0/MiGcyVN0w3IA2vrBMT+mr+7LE=;
        b=cH5xWhihx+xTMmggtxQG1P8ru5JS/8tKEEfmrbi+hNRAH4RdFIcALOZDnPzolKTTwz2JGY
        tyqFMwiso/zIqnb8xRqQgIU10BLdUtksgaKYxO8KYzEIyiBkIdBqZ+FnxojGZDL8eSUva+
        JlA9sisS9qfMVoxdLFvpnWDxxHzTkRPBhFdzoBQwUze6f9drR1hUukYRdOBpzWpyDnQgEv
        Z/Ke/c3ZNM5RfHtNXfRqZUTwvHX6H1VQSmh8DmCMbFcZoqzjwusgiCAxN7HYwpkHFiJg+f
        J5o/qPdr0TW/2fOigaa03c9lrs8Y6TnlOzrQR+4Z9OqaAj4B+yFN/lbJh4JWmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612959781;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EPfb9Ak/7oZVp+rq0/MiGcyVN0w3IA2vrBMT+mr+7LE=;
        b=vtXS/KtRkB4q0EuYqKG9XiWcKGsf+4s5Lu0CzsjbRWwQ8xLXhxkDe0MLDHWpkYTJSfkUu+
        9yf3jbIxRAMwhSBA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/pv: Rework arch_local_irq_restore() to not use popf
Cc:     Andy Lutomirski <luto@kernel.org>, Juergen Gross <jgross@suse.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210120135555.32594-7-jgross@suse.com>
References: <20210120135555.32594-7-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <161295978073.23325.10689551911607038793.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     ab234a260b1f625b26cbefa93ca365b0ae66df33
Gitweb:        https://git.kernel.org/tip/ab234a260b1f625b26cbefa93ca365b0ae66df33
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Wed, 20 Jan 2021 14:55:46 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 10 Feb 2021 12:36:45 +01:00

x86/pv: Rework arch_local_irq_restore() to not use popf

POPF is a rather expensive operation, so don't use it for restoring
irq flags. Instead, test whether interrupts are enabled in the flags
parameter and enable interrupts via STI in that case.

This results in the restore_fl paravirt op to be no longer needed.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210120135555.32594-7-jgross@suse.com
---
 arch/x86/include/asm/irqflags.h       | 20 +++++--------------
 arch/x86/include/asm/paravirt.h       |  5 +-----
 arch/x86/include/asm/paravirt_types.h |  7 ++-----
 arch/x86/kernel/irqflags.S            | 11 +----------
 arch/x86/kernel/paravirt.c            |  1 +-
 arch/x86/kernel/paravirt_patch.c      |  3 +---
 arch/x86/xen/enlighten_pv.c           |  2 +--
 arch/x86/xen/irq.c                    | 23 +---------------------
 arch/x86/xen/xen-asm.S                | 28 +--------------------------
 arch/x86/xen/xen-ops.h                |  1 +-
 10 files changed, 8 insertions(+), 93 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index e585a47..144d70e 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -35,15 +35,6 @@ extern __always_inline unsigned long native_save_fl(void)
 	return flags;
 }
 
-extern inline void native_restore_fl(unsigned long flags);
-extern inline void native_restore_fl(unsigned long flags)
-{
-	asm volatile("push %0 ; popf"
-		     : /* no output */
-		     :"g" (flags)
-		     :"memory", "cc");
-}
-
 static __always_inline void native_irq_disable(void)
 {
 	asm volatile("cli": : :"memory");
@@ -79,11 +70,6 @@ static __always_inline unsigned long arch_local_save_flags(void)
 	return native_save_fl();
 }
 
-static __always_inline void arch_local_irq_restore(unsigned long flags)
-{
-	native_restore_fl(flags);
-}
-
 static __always_inline void arch_local_irq_disable(void)
 {
 	native_irq_disable();
@@ -152,6 +138,12 @@ static __always_inline int arch_irqs_disabled(void)
 
 	return arch_irqs_disabled_flags(flags);
 }
+
+static __always_inline void arch_local_irq_restore(unsigned long flags)
+{
+	if (!arch_irqs_disabled_flags(flags))
+		arch_local_irq_enable();
+}
 #else
 #ifdef CONFIG_X86_64
 #ifdef CONFIG_XEN_PV
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index dd43b11..4abf110 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -648,11 +648,6 @@ static inline notrace unsigned long arch_local_save_flags(void)
 	return PVOP_CALLEE0(unsigned long, irq.save_fl);
 }
 
-static inline notrace void arch_local_irq_restore(unsigned long f)
-{
-	PVOP_VCALLEE1(irq.restore_fl, f);
-}
-
 static inline notrace void arch_local_irq_disable(void)
 {
 	PVOP_VCALLEE0(irq.irq_disable);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 0169365..de87087 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -168,16 +168,13 @@ struct pv_cpu_ops {
 struct pv_irq_ops {
 #ifdef CONFIG_PARAVIRT_XXL
 	/*
-	 * Get/set interrupt state.  save_fl and restore_fl are only
-	 * expected to use X86_EFLAGS_IF; all other bits
-	 * returned from save_fl are undefined, and may be ignored by
-	 * restore_fl.
+	 * Get/set interrupt state.  save_fl is expected to use X86_EFLAGS_IF;
+	 * all other bits returned from save_fl are undefined.
 	 *
 	 * NOTE: These functions callers expect the callee to preserve
 	 * more registers than the standard C calling convention.
 	 */
 	struct paravirt_callee_save save_fl;
-	struct paravirt_callee_save restore_fl;
 	struct paravirt_callee_save irq_disable;
 	struct paravirt_callee_save irq_enable;
 
diff --git a/arch/x86/kernel/irqflags.S b/arch/x86/kernel/irqflags.S
index 0db0375..8ef3506 100644
--- a/arch/x86/kernel/irqflags.S
+++ b/arch/x86/kernel/irqflags.S
@@ -13,14 +13,3 @@ SYM_FUNC_START(native_save_fl)
 	ret
 SYM_FUNC_END(native_save_fl)
 EXPORT_SYMBOL(native_save_fl)
-
-/*
- * void native_restore_fl(unsigned long flags)
- * %eax/%rdi: flags
- */
-SYM_FUNC_START(native_restore_fl)
-	push %_ASM_ARG1
-	popf
-	ret
-SYM_FUNC_END(native_restore_fl)
-EXPORT_SYMBOL(native_restore_fl)
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 18560b7..c60222a 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -320,7 +320,6 @@ struct paravirt_patch_template pv_ops = {
 
 	/* Irq ops. */
 	.irq.save_fl		= __PV_IS_CALLEE_SAVE(native_save_fl),
-	.irq.restore_fl		= __PV_IS_CALLEE_SAVE(native_restore_fl),
 	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(native_irq_disable),
 	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(native_irq_enable),
 	.irq.safe_halt		= native_safe_halt,
diff --git a/arch/x86/kernel/paravirt_patch.c b/arch/x86/kernel/paravirt_patch.c
index 2fada2c..abd27ec 100644
--- a/arch/x86/kernel/paravirt_patch.c
+++ b/arch/x86/kernel/paravirt_patch.c
@@ -25,7 +25,6 @@ struct patch_xxl {
 	const unsigned char	mmu_read_cr2[3];
 	const unsigned char	mmu_read_cr3[3];
 	const unsigned char	mmu_write_cr3[3];
-	const unsigned char	irq_restore_fl[2];
 	const unsigned char	cpu_wbinvd[2];
 	const unsigned char	mov64[3];
 };
@@ -37,7 +36,6 @@ static const struct patch_xxl patch_data_xxl = {
 	.mmu_read_cr2		= { 0x0f, 0x20, 0xd0 },	// mov %cr2, %[re]ax
 	.mmu_read_cr3		= { 0x0f, 0x20, 0xd8 },	// mov %cr3, %[re]ax
 	.mmu_write_cr3		= { 0x0f, 0x22, 0xdf },	// mov %rdi, %cr3
-	.irq_restore_fl		= { 0x57, 0x9d },	// push %rdi; popfq
 	.cpu_wbinvd		= { 0x0f, 0x09 },	// wbinvd
 	.mov64			= { 0x48, 0x89, 0xf8 },	// mov %rdi, %rax
 };
@@ -71,7 +69,6 @@ unsigned int native_patch(u8 type, void *insn_buff, unsigned long addr,
 	switch (type) {
 
 #ifdef CONFIG_PARAVIRT_XXL
-	PATCH_CASE(irq, restore_fl, xxl, insn_buff, len);
 	PATCH_CASE(irq, save_fl, xxl, insn_buff, len);
 	PATCH_CASE(irq, irq_enable, xxl, insn_buff, len);
 	PATCH_CASE(irq, irq_disable, xxl, insn_buff, len);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 6abf3f2..dc0a337 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1035,8 +1035,6 @@ void __init xen_setup_vcpu_info_placement(void)
 	 */
 	if (xen_have_vcpu_info_placement) {
 		pv_ops.irq.save_fl = __PV_IS_CALLEE_SAVE(xen_save_fl_direct);
-		pv_ops.irq.restore_fl =
-			__PV_IS_CALLEE_SAVE(xen_restore_fl_direct);
 		pv_ops.irq.irq_disable =
 			__PV_IS_CALLEE_SAVE(xen_irq_disable_direct);
 		pv_ops.irq.irq_enable =
diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
index 850c93f..dfa091d 100644
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -42,28 +42,6 @@ asmlinkage __visible unsigned long xen_save_fl(void)
 }
 PV_CALLEE_SAVE_REGS_THUNK(xen_save_fl);
 
-__visible void xen_restore_fl(unsigned long flags)
-{
-	struct vcpu_info *vcpu;
-
-	/* convert from IF type flag */
-	flags = !(flags & X86_EFLAGS_IF);
-
-	/* See xen_irq_enable() for why preemption must be disabled. */
-	preempt_disable();
-	vcpu = this_cpu_read(xen_vcpu);
-	vcpu->evtchn_upcall_mask = flags;
-
-	if (flags == 0) {
-		barrier(); /* unmask then check (avoid races) */
-		if (unlikely(vcpu->evtchn_upcall_pending))
-			xen_force_evtchn_callback();
-		preempt_enable();
-	} else
-		preempt_enable_no_resched();
-}
-PV_CALLEE_SAVE_REGS_THUNK(xen_restore_fl);
-
 asmlinkage __visible void xen_irq_disable(void)
 {
 	/* There's a one instruction preempt window here.  We need to
@@ -118,7 +96,6 @@ static void xen_halt(void)
 
 static const struct pv_irq_ops xen_irq_ops __initconst = {
 	.save_fl = PV_CALLEE_SAVE(xen_save_fl),
-	.restore_fl = PV_CALLEE_SAVE(xen_restore_fl),
 	.irq_disable = PV_CALLEE_SAVE(xen_irq_disable),
 	.irq_enable = PV_CALLEE_SAVE(xen_irq_enable),
 
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 1d738c5..02f3134 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -72,34 +72,6 @@ SYM_FUNC_START(xen_save_fl_direct)
 	ret
 SYM_FUNC_END(xen_save_fl_direct)
 
-
-/*
- * In principle the caller should be passing us a value return from
- * xen_save_fl_direct, but for robustness sake we test only the
- * X86_EFLAGS_IF flag rather than the whole byte. After setting the
- * interrupt mask state, it checks for unmasked pending events and
- * enters the hypervisor to get them delivered if so.
- */
-SYM_FUNC_START(xen_restore_fl_direct)
-	FRAME_BEGIN
-	testw $X86_EFLAGS_IF, %di
-	setz PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_mask
-	/*
-	 * Preempt here doesn't matter because that will deal with any
-	 * pending interrupts.  The pending check may end up being run
-	 * on the wrong CPU, but that doesn't hurt.
-	 */
-
-	/* check for unmasked and pending */
-	cmpw $0x0001, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_pending
-	jnz 1f
-	call check_events
-1:
-	FRAME_END
-	ret
-SYM_FUNC_END(xen_restore_fl_direct)
-
-
 /*
  * Force an event check by making a hypercall, but preserve regs
  * before making the call.
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index b2fd80a..8d7ec49 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -131,7 +131,6 @@ static inline void __init xen_efi_init(struct boot_params *boot_params)
 __visible void xen_irq_enable_direct(void);
 __visible void xen_irq_disable_direct(void);
 __visible unsigned long xen_save_fl_direct(void);
-__visible void xen_restore_fl_direct(unsigned long);
 
 __visible unsigned long xen_read_cr2(void);
 __visible unsigned long xen_read_cr2_direct(void);
