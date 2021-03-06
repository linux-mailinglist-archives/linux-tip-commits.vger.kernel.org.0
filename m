Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C6932FA87
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 13:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhCFMNU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 07:13:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34882 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhCFMMz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 07:12:55 -0500
Date:   Sat, 06 Mar 2021 12:12:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615032774;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v8oR9u01T+ZPkgicPXRK8kLpLCjp3M6MLT8kCFKfo8E=;
        b=e+5YumLYAGwYEjbOcgkspVW4h6nTVFrrJldQlMIh8cf8bx2idG7jCDyntqqSzkpfMdoXmO
        Q2p63sDu6/2mmlFVz77QrZHwSf6ebWSLwGdJ8QxZaMkoYUFgHIVGtVPkPKz6QChxsLks0g
        +TAHT6PIJV6FtXGzaBPgmzr/xaRAjewvRmBDPnR9glRbXHR7jKBfdP4DFYhCAf0FUglwCR
        /AG7bSWzQHrJYr+b0iD/p7LgVv4d/4q9UCy8Qhlbiz3WOkVowhWy1/8cpIS08R1S+N1/n5
        UCvAp6kopA0zpUKKTlMa1bpWdejLBtkw3vzBXYR+p7NY6ICQz+rXtGjlBqm/4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615032774;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v8oR9u01T+ZPkgicPXRK8kLpLCjp3M6MLT8kCFKfo8E=;
        b=BjQ+DSrslGmbkA28/+19evMadE1Fv3/CE12ILFA5vSpOnUA1MDGVD8gTeOysJtU9Bp20aO
        JxK0Bu45t7iuvyCg==
From:   "tip-bot2 for Nadav Amit" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] smp: Inline on_each_cpu_cond() and on_each_cpu()
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210220231712.2475218-10-namit@vmware.com>
References: <20210220231712.2475218-10-namit@vmware.com>
MIME-Version: 1.0
Message-ID: <161503277381.398.16737252451693471719.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     a5aa5ce300597224ec76dacc8e63ba3ad7a18bbd
Gitweb:        https://git.kernel.org/tip/a5aa5ce300597224ec76dacc8e63ba3ad7a18bbd
Author:        Nadav Amit <namit@vmware.com>
AuthorDate:    Sat, 20 Feb 2021 15:17:12 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:59:10 +01:00

smp: Inline on_each_cpu_cond() and on_each_cpu()

Simplify the code and avoid having an additional function on the stack
by inlining on_each_cpu_cond() and on_each_cpu().

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
[ Minor edits. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210220231712.2475218-10-namit@vmware.com
---
 include/linux/smp.h | 50 ++++++++++++++++++++++++++++-----------
 kernel/smp.c        | 56 +--------------------------------------------
 kernel/up.c         | 38 +------------------------------
 3 files changed, 37 insertions(+), 107 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 70c6f62..84a0b48 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -50,30 +50,52 @@ extern unsigned int total_cpus;
 int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
 			     int wait);
 
+void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
+			   void *info, bool wait, const struct cpumask *mask);
+
+int smp_call_function_single_async(int cpu, call_single_data_t *csd);
+
 /*
  * Call a function on all processors
  */
-void on_each_cpu(smp_call_func_t func, void *info, int wait);
+static inline void on_each_cpu(smp_call_func_t func, void *info, int wait)
+{
+	on_each_cpu_cond_mask(NULL, func, info, wait, cpu_online_mask);
+}
 
-/*
- * Call a function on processors specified by mask, which might include
- * the local one.
+/**
+ * on_each_cpu_mask(): Run a function on processors specified by
+ * cpumask, which may include the local processor.
+ * @mask: The set of cpus to run on (only runs on online subset).
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @wait: If true, wait (atomically) until function has completed
+ *        on other CPUs.
+ *
+ * If @wait is true, then returns once @func has returned.
+ *
+ * You must not call this function with disabled interrupts or from a
+ * hardware interrupt handler or from a bottom half handler.  The
+ * exception is that it may be used during early boot while
+ * early_boot_irqs_disabled is set.
  */
-void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
-		void *info, bool wait);
+static inline void on_each_cpu_mask(const struct cpumask *mask,
+				    smp_call_func_t func, void *info, bool wait)
+{
+	on_each_cpu_cond_mask(NULL, func, info, wait, mask);
+}
 
 /*
  * Call a function on each processor for which the supplied function
  * cond_func returns a positive value. This may include the local
- * processor.
+ * processor.  May be used during early boot while early_boot_irqs_disabled is
+ * set. Use local_irq_save/restore() instead of local_irq_disable/enable().
  */
-void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
-		      void *info, bool wait);
-
-void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
-			   void *info, bool wait, const struct cpumask *mask);
-
-int smp_call_function_single_async(int cpu, call_single_data_t *csd);
+static inline void on_each_cpu_cond(smp_cond_func_t cond_func,
+				    smp_call_func_t func, void *info, bool wait)
+{
+	on_each_cpu_cond_mask(cond_func, func, info, wait, cpu_online_mask);
+}
 
 #ifdef CONFIG_SMP
 
diff --git a/kernel/smp.c b/kernel/smp.c
index c8a5a1f..b6375d7 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -848,55 +848,6 @@ void __init smp_init(void)
 }
 
 /*
- * Call a function on all processors.  May be used during early boot while
- * early_boot_irqs_disabled is set.  Use local_irq_save/restore() instead
- * of local_irq_disable/enable().
- */
-void on_each_cpu(smp_call_func_t func, void *info, int wait)
-{
-	unsigned long flags;
-
-	preempt_disable();
-	smp_call_function(func, info, wait);
-	local_irq_save(flags);
-	func(info);
-	local_irq_restore(flags);
-	preempt_enable();
-}
-EXPORT_SYMBOL(on_each_cpu);
-
-/**
- * on_each_cpu_mask(): Run a function on processors specified by
- * cpumask, which may include the local processor.
- * @mask: The set of cpus to run on (only runs on online subset).
- * @func: The function to run. This must be fast and non-blocking.
- * @info: An arbitrary pointer to pass to the function.
- * @wait: If true, wait (atomically) until function has completed
- *        on other CPUs.
- *
- * If @wait is true, then returns once @func has returned.
- *
- * You must not call this function with disabled interrupts or from a
- * hardware interrupt handler or from a bottom half handler.  The
- * exception is that it may be used during early boot while
- * early_boot_irqs_disabled is set.
- */
-void on_each_cpu_mask(const struct cpumask *mask, smp_call_func_t func,
-			void *info, bool wait)
-{
-	unsigned int scf_flags;
-
-	scf_flags = SCF_RUN_LOCAL;
-	if (wait)
-		scf_flags |= SCF_WAIT;
-
-	preempt_disable();
-	smp_call_function_many_cond(mask, func, info, scf_flags, NULL);
-	preempt_enable();
-}
-EXPORT_SYMBOL(on_each_cpu_mask);
-
-/*
  * on_each_cpu_cond(): Call a function on each processor for which
  * the supplied function cond_func returns true, optionally waiting
  * for all the required CPUs to finish. This may include the local
@@ -932,13 +883,6 @@ void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 }
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
 
-void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
-		      void *info, bool wait)
-{
-	on_each_cpu_cond_mask(cond_func, func, info, wait, cpu_online_mask);
-}
-EXPORT_SYMBOL(on_each_cpu_cond);
-
 static void do_nothing(void *unused)
 {
 }
diff --git a/kernel/up.c b/kernel/up.c
index c6f323d..bf20b4a 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -36,35 +36,6 @@ int smp_call_function_single_async(int cpu, call_single_data_t *csd)
 }
 EXPORT_SYMBOL(smp_call_function_single_async);
 
-void on_each_cpu(smp_call_func_t func, void *info, int wait)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	func(info);
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL(on_each_cpu);
-
-/*
- * Note we still need to test the mask even for UP
- * because we actually can get an empty mask from
- * code that on SMP might call us without the local
- * CPU in the mask.
- */
-void on_each_cpu_mask(const struct cpumask *mask,
-		      smp_call_func_t func, void *info, bool wait)
-{
-	unsigned long flags;
-
-	if (cpumask_test_cpu(0, mask)) {
-		local_irq_save(flags);
-		func(info);
-		local_irq_restore(flags);
-	}
-}
-EXPORT_SYMBOL(on_each_cpu_mask);
-
 /*
  * Preemption is disabled here to make sure the cond_func is called under the
  * same condtions in UP and SMP.
@@ -75,7 +46,7 @@ void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 	unsigned long flags;
 
 	preempt_disable();
-	if (cond_func(0, info)) {
+	if ((!cond_func || cond_func(0, info)) && cpumask_test_cpu(0, mask)) {
 		local_irq_save(flags);
 		func(info);
 		local_irq_restore(flags);
@@ -84,13 +55,6 @@ void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 }
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
 
-void on_each_cpu_cond(smp_cond_func_t cond_func, smp_call_func_t func,
-		      void *info, bool wait)
-{
-	on_each_cpu_cond_mask(cond_func, func, info, wait, NULL);
-}
-EXPORT_SYMBOL(on_each_cpu_cond);
-
 int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
 {
 	int ret;
