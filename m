Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6693182C1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Feb 2021 01:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhBKAvY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 19:51:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35540 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhBKAvJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 19:51:09 -0500
Date:   Thu, 11 Feb 2021 00:50:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613004627;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uSA4uYqhoMBg3xQ5/uxVx4rSThHhDZRiv8V1vm/1djg=;
        b=DjM55M/gc67fel68GIFVhYIiXx3MtFPwHpI4RSpS/YsmthexxdRSSqv9D2O8h0IDe+EQaR
        1U1Vy2j2V+v9CHFpfclzjCMm2gq3cinbWRzqksd1+dn/4qaK35vCT6BerxZ/S3pgKr5lg3
        SNkQdvcPK7f2qlgMzYI2YbKjWUkz9Wqy2/K+AfLPgg8fTbRZRYGgTGnlkYMabA6j+acFX3
        pZWXnzPIPXsPcgr+WppXC5ay7Sk6UUYF4M+sKpsq13vr21JE1QqOFMpWLXa70CBDgsVxun
        ZwfQ2yg+qTv13qwzAM6t9kbeJuQgWTWwgyrLIp9KSytWUf0vrLUfQ36eTH8LGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613004627;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uSA4uYqhoMBg3xQ5/uxVx4rSThHhDZRiv8V1vm/1djg=;
        b=f5B7ygLRbw3Mu+dx6EgUSZc28EMKnmD+6RhdtNMnyINdIq60ewFjUG6QT8VqFutBziuQTB
        r6ZhC9iSYcCC1oCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/irq: Sanitize irq stack tracking
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210210002512.228830141@linutronix.de>
References: <20210210002512.228830141@linutronix.de>
MIME-Version: 1.0
Message-ID: <161300462663.23325.18001189785066981366.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     e7f89001797148e8dc7060c335df2c56e73a8c7a
Gitweb:        https://git.kernel.org/tip/e7f89001797148e8dc7060c335df2c56e73a8c7a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 10 Feb 2021 00:40:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Feb 2021 23:34:13 +01:00

x86/irq: Sanitize irq stack tracking

The recursion protection for hard interrupt stacks is an unsigned int per
CPU variable initialized to -1 named __irq_count. 

The irq stack switching is only done when the variable is -1, which creates
worse code than just checking for 0. When the stack switching happens it
uses this_cpu_add/sub(1), but there is no reason to do so. It simply can
use straight writes. This is a historical leftover from the low level ASM
code which used inc and jz to make a decision.

Rename it to hardirq_stack_inuse, make it a bool and use plain stores.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20210210002512.228830141@linutronix.de


---
 arch/x86/include/asm/irq_stack.h | 14 +++++++-------
 arch/x86/include/asm/processor.h |  2 +-
 arch/x86/kernel/cpu/common.c     |  2 +-
 arch/x86/kernel/process_64.c     |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 7758169..4487bb9 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -9,7 +9,7 @@
 #ifdef CONFIG_X86_64
 static __always_inline bool irqstack_active(void)
 {
-	return __this_cpu_read(irq_count) != -1;
+	return __this_cpu_read(hardirq_stack_inuse);
 }
 
 void asm_call_on_stack(void *sp, void (*func)(void), void *arg);
@@ -22,9 +22,9 @@ static __always_inline void __run_on_irqstack(void (*func)(void))
 {
 	void *tos = __this_cpu_read(hardirq_stack_ptr);
 
-	__this_cpu_add(irq_count, 1);
+	__this_cpu_write(hardirq_stack_inuse, true);
 	asm_call_on_stack(tos - 8, func, NULL);
-	__this_cpu_sub(irq_count, 1);
+	__this_cpu_write(hardirq_stack_inuse, false);
 }
 
 static __always_inline void
@@ -33,9 +33,9 @@ __run_sysvec_on_irqstack(void (*func)(struct pt_regs *regs),
 {
 	void *tos = __this_cpu_read(hardirq_stack_ptr);
 
-	__this_cpu_add(irq_count, 1);
+	__this_cpu_write(hardirq_stack_inuse, true);
 	asm_call_sysvec_on_stack(tos - 8, func, regs);
-	__this_cpu_sub(irq_count, 1);
+	__this_cpu_write(hardirq_stack_inuse, false);
 }
 
 static __always_inline void
@@ -44,9 +44,9 @@ __run_irq_on_irqstack(void (*func)(struct irq_desc *desc),
 {
 	void *tos = __this_cpu_read(hardirq_stack_ptr);
 
-	__this_cpu_add(irq_count, 1);
+	__this_cpu_write(hardirq_stack_inuse, true);
 	asm_call_irq_on_stack(tos - 8, func, desc);
-	__this_cpu_sub(irq_count, 1);
+	__this_cpu_write(hardirq_stack_inuse, false);
 }
 
 #else /* CONFIG_X86_64 */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c20a52b..11d10f4 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -454,7 +454,7 @@ static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 	return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu);
 }
 
-DECLARE_PER_CPU(unsigned int, irq_count);
+DECLARE_PER_CPU(bool, hardirq_stack_inuse);
 extern asmlinkage void ignore_sysret(void);
 
 /* Save actual FS/GS selectors and bases to current->thread */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 35ad848..845c8a4 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1740,7 +1740,7 @@ DEFINE_PER_CPU(struct task_struct *, current_task) ____cacheline_aligned =
 EXPORT_PER_CPU_SYMBOL(current_task);
 
 DEFINE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
-DEFINE_PER_CPU(unsigned int, irq_count) __visible = -1;
+DEFINE_PER_CPU(bool, hardirq_stack_inuse);
 
 DEFINE_PER_CPU(int, __preempt_count) = INIT_PREEMPT_COUNT;
 EXPORT_PER_CPU_SYMBOL(__preempt_count);
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index ad582f9..d08307d 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -539,7 +539,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	int cpu = smp_processor_id();
 
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ENTRY) &&
-		     this_cpu_read(irq_count) != -1);
+		     this_cpu_read(hardirq_stack_inuse));
 
 	if (!test_thread_flag(TIF_NEED_FPU_LOAD))
 		switch_fpu_prepare(prev_fpu, cpu);
