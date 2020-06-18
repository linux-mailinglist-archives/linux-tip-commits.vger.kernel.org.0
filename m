Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198D31FF4E1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jun 2020 16:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgFROiQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Jun 2020 10:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730833AbgFROiM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Jun 2020 10:38:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDEFC06174E;
        Thu, 18 Jun 2020 07:38:11 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlvg5-0003us-4c; Thu, 18 Jun 2020 16:38:05 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C04421C0087;
        Thu, 18 Jun 2020 16:38:04 +0200 (CEST)
Date:   Thu, 18 Jun 2020 14:38:04 -0000
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/stackprotector: Pre-initialize canary for secondary CPUs
Cc:     Brian Gerst <brgerst@gmail.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200617225624.799335-1-brgerst@gmail.com>
References: <20200617225624.799335-1-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <159249108452.16989.12600513315187203881.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     c9a1ff316bc9b1d1806a4366d0aef6e18833ba52
Gitweb:        https://git.kernel.org/tip/c9a1ff316bc9b1d1806a4366d0aef6e18833ba52
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Wed, 17 Jun 2020 18:56:24 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 18 Jun 2020 13:09:17 +02:00

x86/stackprotector: Pre-initialize canary for secondary CPUs

The idle tasks created for each secondary CPU already have a random stack
canary generated by fork().  Copy the canary to the percpu variable before
starting the secondary CPU which removes the need to call
boot_init_stack_canary().

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200617225624.799335-1-brgerst@gmail.com
---
 arch/x86/include/asm/stackprotector.h | 12 ++++++++++++
 arch/x86/kernel/smpboot.c             | 14 ++------------
 arch/x86/xen/smp_pv.c                 |  2 --
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/stackprotector.h b/arch/x86/include/asm/stackprotector.h
index 9804a79..7fb482f 100644
--- a/arch/x86/include/asm/stackprotector.h
+++ b/arch/x86/include/asm/stackprotector.h
@@ -90,6 +90,15 @@ static __always_inline void boot_init_stack_canary(void)
 #endif
 }
 
+static inline void cpu_init_stack_canary(int cpu, struct task_struct *idle)
+{
+#ifdef CONFIG_X86_64
+	per_cpu(fixed_percpu_data.stack_canary, cpu) = idle->stack_canary;
+#else
+	per_cpu(stack_canary.canary, cpu) = idle->stack_canary;
+#endif
+}
+
 static inline void setup_stack_canary_segment(int cpu)
 {
 #ifdef CONFIG_X86_32
@@ -119,6 +128,9 @@ static inline void load_stack_canary_segment(void)
 static inline void setup_stack_canary_segment(int cpu)
 { }
 
+static inline void cpu_init_stack_canary(int cpu, struct task_struct *idle)
+{ }
+
 static inline void load_stack_canary_segment(void)
 {
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ffbd9a3..a11bd53 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -51,7 +51,6 @@
 #include <linux/err.h>
 #include <linux/nmi.h>
 #include <linux/tboot.h>
-#include <linux/stackprotector.h>
 #include <linux/gfp.h>
 #include <linux/cpuidle.h>
 #include <linux/numa.h>
@@ -80,6 +79,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/spec-ctrl.h>
 #include <asm/hw_irq.h>
+#include <asm/stackprotector.h>
 
 /* representing HT siblings of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
@@ -259,21 +259,10 @@ static void notrace start_secondary(void *unused)
 	/* enable local interrupts */
 	local_irq_enable();
 
-	/* to prevent fake stack check failure in clock setup */
-	boot_init_stack_canary();
-
 	x86_cpuinit.setup_percpu_clockev();
 
 	wmb();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
-
-	/*
-	 * Prevent tail call to cpu_startup_entry() because the stack protector
-	 * guard has been changed a couple of function calls up, in
-	 * boot_init_stack_canary() and must not be checked before tail calling
-	 * another function.
-	 */
-	prevent_tail_call_optimization();
 }
 
 /**
@@ -1011,6 +1000,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 	alternatives_enable_smp();
 
 	per_cpu(current_task, cpu) = idle;
+	cpu_init_stack_canary(cpu, idle);
 
 	/* Initialize the interrupt stack(s) */
 	ret = irq_init_percpu_irqstack(cpu);
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 171aff1..9ea598d 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -92,9 +92,7 @@ static void cpu_bringup(void)
 asmlinkage __visible void cpu_bringup_and_idle(void)
 {
 	cpu_bringup();
-	boot_init_stack_canary();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
-	prevent_tail_call_optimization();
 }
 
 void xen_smp_intr_free_pv(unsigned int cpu)
