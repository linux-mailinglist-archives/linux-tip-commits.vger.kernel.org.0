Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BCD3182B7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Feb 2021 01:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhBKAvQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 19:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhBKAvG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 19:51:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55651C0613D6;
        Wed, 10 Feb 2021 16:50:26 -0800 (PST)
Date:   Thu, 11 Feb 2021 00:50:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613004624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bIG2IY+uRKdjgQD3ShPCGD0jGT0JKxk9BV8U0aP4q2Q=;
        b=d9BQOtqR0uaHTWF1X0lnww7ShyjAiqE8rF92P3cgETXM1POo+t16Ab+3o4TBhYh8m2lDVF
        8diHJcsaPOwsqqi8RzgHkQu82Fo2jcxNheNz0WWFXQPH9eaV4BPvn+H4Mit3yKw5AFA5hp
        w8cMgtOqUggHGxXiFGsBMoGmSHQtpxplOo+JJj0OMS7UA41YX8L3DOptj3S4JN90+tPXH5
        z2U0bqfCa8ld/5HksJDL5iDqo5T3iGSX+nJC8RKs0eQqy5OKsLbs29mht7CpdclQnyroMg
        pzcffdW7zJwAe7jfN3tZRObFbStzbl4d3bcuWEg1pB8UBRIv5VSZm8m2smQ7yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613004624;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bIG2IY+uRKdjgQD3ShPCGD0jGT0JKxk9BV8U0aP4q2Q=;
        b=Hu3EFFZukcMaNrCtaa8ApIHtNL5sCJxwjXfjF6hYidaEj3lfNgugAO3rtjW73f0jOS/6qL
        na7mGp3xqgHHpkCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] softirq: Move __ARCH_HAS_DO_SOFTIRQ to Kconfig
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210210002513.181713427@linutronix.de>
References: <20210210002513.181713427@linutronix.de>
MIME-Version: 1.0
Message-ID: <161300462433.23325.9658907666977791978.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     cd1a41ceba8a4caef4d18a3a14d6d0f8c656efe4
Gitweb:        https://git.kernel.org/tip/cd1a41ceba8a4caef4d18a3a14d6d0f8c656efe4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 10 Feb 2021 00:40:52 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Feb 2021 23:34:16 +01:00

softirq: Move __ARCH_HAS_DO_SOFTIRQ to Kconfig

To prepare for inlining do_softirq_own_stack() replace
__ARCH_HAS_DO_SOFTIRQ with a Kconfig switch and select it in the affected
architectures.

This allows in the next step to move the function prototype and the inline
stub into a seperate asm-generic header file which is required to avoid
include recursion.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20210210002513.181713427@linutronix.de

---
 arch/Kconfig                      | 6 ++++++
 arch/parisc/Kconfig               | 1 +
 arch/parisc/include/asm/hardirq.h | 4 ----
 arch/powerpc/Kconfig              | 1 +
 arch/powerpc/include/asm/irq.h    | 2 --
 arch/s390/Kconfig                 | 1 +
 arch/s390/include/asm/hardirq.h   | 1 -
 arch/sh/Kconfig                   | 1 +
 arch/sh/include/asm/irq.h         | 1 -
 arch/sparc/Kconfig                | 1 +
 arch/sparc/include/asm/irq_64.h   | 1 -
 arch/x86/Kconfig                  | 1 +
 arch/x86/include/asm/irq.h        | 2 --
 include/linux/interrupt.h         | 2 +-
 14 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 24862d1..7eab9d0 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -759,6 +759,12 @@ config HAVE_IRQ_EXIT_ON_IRQ_STACK
 	  This spares a stack switch and improves cache usage on softirq
 	  processing.
 
+config HAVE_SOFTIRQ_ON_OWN_STACK
+	bool
+	help
+	  Architecture provides a function to run __do_softirq() on a
+	  seperate stack.
+
 config PGTABLE_LEVELS
 	int
 	default 2
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 78b1762..7cd88c0 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -63,6 +63,7 @@ config PARISC
 	select HAVE_FTRACE_MCOUNT_RECORD if HAVE_DYNAMIC_FTRACE
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
+	select HAVE_SOFTIRQ_ON_OWN_STACK if IRQSTACKS
 	select SET_FS
 
 	help
diff --git a/arch/parisc/include/asm/hardirq.h b/arch/parisc/include/asm/hardirq.h
index fad29aa..1e4fbd0 100644
--- a/arch/parisc/include/asm/hardirq.h
+++ b/arch/parisc/include/asm/hardirq.h
@@ -12,10 +12,6 @@
 #include <linux/threads.h>
 #include <linux/irq.h>
 
-#ifdef CONFIG_IRQSTACKS
-#define __ARCH_HAS_DO_SOFTIRQ
-#endif
-
 typedef struct {
 	unsigned int __softirq_pending;
 	unsigned int kernel_stack_usage;
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 107bb43..888d1ad 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -237,6 +237,7 @@ config PPC
 	select MMU_GATHER_PAGE_SIZE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
+	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_IRQ_TIME_ACCOUNTING
diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index 4f983ca..f3f264e 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -37,8 +37,6 @@ extern int distribute_irqs;
 
 struct pt_regs;
 
-#define __ARCH_HAS_DO_SOFTIRQ
-
 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
 /*
  * Per-cpu stacks for handling critical, debug and machine check
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c72874f..e00c02a 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -182,6 +182,7 @@ config S390
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_RSEQ
+	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
diff --git a/arch/s390/include/asm/hardirq.h b/arch/s390/include/asm/hardirq.h
index dfbc3c6..58668ff 100644
--- a/arch/s390/include/asm/hardirq.h
+++ b/arch/s390/include/asm/hardirq.h
@@ -18,7 +18,6 @@
 #define or_softirq_pending(x)  (S390_lowcore.softirq_pending |= (x))
 
 #define __ARCH_IRQ_STAT
-#define __ARCH_HAS_DO_SOFTIRQ
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED
 
 static inline void ack_bad_irq(unsigned int irq)
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 5fa5802..b49d5e0 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -56,6 +56,7 @@ config SUPERH
 	select HAVE_PERF_EVENTS
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_UID16
+	select HAVE_SOFTIRQ_ON_OWN_STACK if IRQSTACKS
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_FORCED_THREADING
diff --git a/arch/sh/include/asm/irq.h b/arch/sh/include/asm/irq.h
index 6d44c32..839551c 100644
--- a/arch/sh/include/asm/irq.h
+++ b/arch/sh/include/asm/irq.h
@@ -51,7 +51,6 @@ asmlinkage int do_IRQ(unsigned int irq, struct pt_regs *regs);
 #ifdef CONFIG_IRQSTACKS
 extern void irq_ctx_init(int cpu);
 extern void irq_ctx_exit(int cpu);
-# define __ARCH_HAS_DO_SOFTIRQ
 #else
 # define irq_ctx_init(cpu) do { } while (0)
 # define irq_ctx_exit(cpu) do { } while (0)
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index c9c34dc..f0d22d5 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -97,6 +97,7 @@ config SPARC64
 	select ARCH_HAS_PTE_SPECIAL
 	select PCI_DOMAINS if PCI
 	select ARCH_HAS_GIGANTIC_PAGE
+	select HAVE_SOFTIRQ_ON_OWN_STACK
 
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
diff --git a/arch/sparc/include/asm/irq_64.h b/arch/sparc/include/asm/irq_64.h
index 4d748e9..154df2c 100644
--- a/arch/sparc/include/asm/irq_64.h
+++ b/arch/sparc/include/asm/irq_64.h
@@ -93,7 +93,6 @@ void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
 
 extern void *hardirq_stack[NR_CPUS];
 extern void *softirq_stack[NR_CPUS];
-#define __ARCH_HAS_DO_SOFTIRQ
 
 #define NO_IRQ		0xffffffff
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e17ce87..019e0e1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -221,6 +221,7 @@ config X86
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if X86_64 && (UNWINDER_FRAME_POINTER || UNWINDER_ORC) && STACK_VALIDATION
 	select HAVE_FUNCTION_ARG_ACCESS_API
+	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
 	select HAVE_STACK_VALIDATION		if X86_64
 	select HAVE_STATIC_CALL
diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index 528c8a7..f70d2ca 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -25,8 +25,6 @@ static inline int irq_canonicalize(int irq)
 
 extern int irq_init_percpu_irqstack(unsigned int cpu);
 
-#define __ARCH_HAS_DO_SOFTIRQ
-
 struct irq_desc;
 
 extern void fixup_irqs(void);
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index bb8ff90..f0b918f 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -569,7 +569,7 @@ struct softirq_action
 asmlinkage void do_softirq(void);
 asmlinkage void __do_softirq(void);
 
-#ifdef __ARCH_HAS_DO_SOFTIRQ
+#ifdef CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
 void do_softirq_own_stack(void);
 #else
 static inline void do_softirq_own_stack(void)
