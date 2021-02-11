Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630263182B8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Feb 2021 01:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhBKAvS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 19:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhBKAvG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 19:51:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1ACC061786;
        Wed, 10 Feb 2021 16:50:26 -0800 (PST)
Date:   Thu, 11 Feb 2021 00:50:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613004625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W6/dRDHejOLYF5nKOEorZcfTZbM+PxcMLAWfQIg1j04=;
        b=4j59lDdGM4hK23u1PVFNQ90k+6yKMozqpPZ/nuwCznUJEyeURmhvnxruheuPLgryqRFQiX
        gPUsk1+cteGbQyRY98CHB1dTf+DTxFAh6giaECxKTrG62o2XTpqFX/y2bedDEMFwuqpDlf
        dzhggrkhksJ3Th5h767j2JAIBYJgFAgJ+rTQkCgNW8aQNIuLPFmvpGmwUuRG2s8KOR1RA7
        kGGq3Jm6iNl1PQCMOQduopaZd65nxvW41t3QepWq+JUQee9LHo06evxHQlZ2ZkN/dtpAX0
        OmZAg0xQc+nyZgQ/mHm21KsCw7MaWikJc4vElqB94LrYgf7kl7GuDYqtgjl7gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613004625;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W6/dRDHejOLYF5nKOEorZcfTZbM+PxcMLAWfQIg1j04=;
        b=JqFqXPmDZlb/SoOF07Vly1/xYh7ZLHuKKYR0n2OU5cV6aijOeL+zU/JidIBkDhGhFgn+e2
        TPk+/8LBP+yu29CA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86: Select CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210210002513.068033456@linutronix.de>
References: <20210210002513.068033456@linutronix.de>
MIME-Version: 1.0
Message-ID: <161300462464.23325.9459284201088000251.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     624db9eabc74597f682c0651047a25b54f7260a1
Gitweb:        https://git.kernel.org/tip/624db9eabc74597f682c0651047a25b54f7260a1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 10 Feb 2021 00:40:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Feb 2021 23:34:16 +01:00

x86: Select CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK

Now that all invocations of irq_exit_rcu() happen on the irq stack, turn on
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK which causes the core code to invoke
__do_softirq() directly without going through do_softirq_own_stack().

That means do_softirq_own_stack() is only invoked from task context which
means it can't be on the irq stack. Remove the conditional from
run_softirq_on_irqstack_cond() and rename the function accordingly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20210210002513.068033456@linutronix.de


---
 arch/x86/Kconfig                 |  1 +
 arch/x86/include/asm/irq_stack.h | 19 ++++++++-----------
 arch/x86/kernel/irq_64.c         |  2 +-
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 21f8511..e17ce87 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -187,6 +187,7 @@ config X86
 	select HAVE_HW_BREAKPOINT
 	select HAVE_IDE
 	select HAVE_IOREMAP_PROT
+	select HAVE_IRQ_EXIT_ON_IRQ_STACK	if X86_64
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KERNEL_BZIP2
 	select HAVE_KERNEL_GZIP
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index fa444c2..1b82f92 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -189,19 +189,16 @@
 	"call %P[__func]				\n"
 
 /*
- * Macro to invoke __do_softirq on the irq stack. Contrary to the above
- * the only check which is necessary is whether the interrupt stack is
- * in use already.
+ * Macro to invoke __do_softirq on the irq stack. This is only called from
+ * task context when bottom halfs are about to be reenabled and soft
+ * interrupts are pending to be processed. The interrupt stack cannot be in
+ * use here.
  */
-#define run_softirq_on_irqstack_cond()					\
+#define run_softirq_on_irqstack()					\
 {									\
-	if (__this_cpu_read(hardirq_stack_inuse)) {			\
-		__do_softirq();						\
-	} else {							\
-		__this_cpu_write(hardirq_stack_inuse, true);		\
-		call_on_irqstack(__do_softirq, ASM_CALL_SOFTIRQ);	\
-		__this_cpu_write(hardirq_stack_inuse, false);		\
-	}								\
+	__this_cpu_write(hardirq_stack_inuse, true);			\
+	call_on_irqstack(__do_softirq, ASM_CALL_SOFTIRQ);		\
+	__this_cpu_write(hardirq_stack_inuse, false);			\
 }
 
 #else /* CONFIG_X86_64 */
diff --git a/arch/x86/kernel/irq_64.c b/arch/x86/kernel/irq_64.c
index 8d9f9a1..b88fdb9 100644
--- a/arch/x86/kernel/irq_64.c
+++ b/arch/x86/kernel/irq_64.c
@@ -76,5 +76,5 @@ int irq_init_percpu_irqstack(unsigned int cpu)
 
 void do_softirq_own_stack(void)
 {
-	run_softirq_on_irqstack_cond();
+	run_softirq_on_irqstack();
 }
