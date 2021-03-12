Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7990338BFC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Mar 2021 12:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhCLLyu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Mar 2021 06:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhCLLym (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Mar 2021 06:54:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDE1C061574;
        Fri, 12 Mar 2021 03:54:42 -0800 (PST)
Date:   Fri, 12 Mar 2021 11:54:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615550080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jm6/MUlaGrw2Vt43otcPwXkzdo8bL4a7JaexKrKNBMI=;
        b=3qHGWJFTIdXcdrrGyic84Ws2H8N2BmSUfQM3MxNjGtg3D+bQzTcbaf4+u0LTbudKALpEUs
        0sm6cGdntJmaAqOO/A0XTMtox99sB3zUPvWdMwfMFtOXz7WTgezWv8GSP9t5xqNYxXi985
        7sbdn6ms+PRaTFpIEtO9HrdfABJ0WB/wIulTUl8UU8n8oEH2iWu6apc/ch8lW1KeCTwAWQ
        hrEj6HwPXy5zDRu2WmEmHmjEuQAp1NR7FhtabV0Nlrg+OTUdfvFyABEsyCkYzJedsEoOSQ
        vDx4yVhzrCHb/uLHMY+xEOdEFVVHvIoxookkd1CvTQxqyreYSVtbdyMQtB07ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615550080;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jm6/MUlaGrw2Vt43otcPwXkzdo8bL4a7JaexKrKNBMI=;
        b=3VZ22klYjfBY4hspdLUZT4+h+6Gf5f+PyYUTM9egsPZzFiQvKh/mJmGqh6sGmFbAA8QHcB
        uR3hyu8kNRu8XACQ==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/paravirt: Switch time pvops functions to
 use static_call()
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210311142319.4723-5-jgross@suse.com>
References: <20210311142319.4723-5-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <161555008022.398.17374236332468561493.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     a0e2bf7cb7006b5a58ee81f4da4fe575875f2781
Gitweb:        https://git.kernel.org/tip/a0e2bf7cb7006b5a58ee81f4da4fe575875f2781
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Thu, 11 Mar 2021 15:23:09 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 11 Mar 2021 16:17:52 +01:00

x86/paravirt: Switch time pvops functions to use static_call()

The time pvops functions are the only ones left which might be
used in 32-bit mode and which return a 64-bit value.

Switch them to use the static_call() mechanism instead of pvops, as
this allows quite some simplification of the pvops implementation.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210311142319.4723-5-jgross@suse.com
---
 arch/arm/include/asm/paravirt.h       | 14 +++++---------
 arch/arm/kernel/paravirt.c            |  9 +++++++--
 arch/arm64/include/asm/paravirt.h     | 14 +++++---------
 arch/arm64/kernel/paravirt.c          | 13 +++++++++----
 arch/x86/Kconfig                      |  1 +-
 arch/x86/include/asm/mshyperv.h       |  2 +-
 arch/x86/include/asm/paravirt.h       | 15 ++++++++++++---
 arch/x86/include/asm/paravirt_types.h |  6 +------
 arch/x86/kernel/cpu/vmware.c          |  5 +++--
 arch/x86/kernel/kvm.c                 |  2 +-
 arch/x86/kernel/kvmclock.c            |  2 +-
 arch/x86/kernel/paravirt.c            | 13 +++++++++----
 arch/x86/kernel/tsc.c                 |  3 ++-
 arch/x86/xen/time.c                   | 26 +++++++++++++-------------
 drivers/xen/time.c                    |  3 ++-
 15 files changed, 71 insertions(+), 57 deletions(-)

diff --git a/arch/arm/include/asm/paravirt.h b/arch/arm/include/asm/paravirt.h
index cdbf02d..95d5b0d 100644
--- a/arch/arm/include/asm/paravirt.h
+++ b/arch/arm/include/asm/paravirt.h
@@ -3,23 +3,19 @@
 #define _ASM_ARM_PARAVIRT_H
 
 #ifdef CONFIG_PARAVIRT
+#include <linux/static_call_types.h>
+
 struct static_key;
 extern struct static_key paravirt_steal_enabled;
 extern struct static_key paravirt_steal_rq_enabled;
 
-struct pv_time_ops {
-	unsigned long long (*steal_clock)(int cpu);
-};
-
-struct paravirt_patch_template {
-	struct pv_time_ops time;
-};
+u64 dummy_steal_clock(int cpu);
 
-extern struct paravirt_patch_template pv_ops;
+DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
 
 static inline u64 paravirt_steal_clock(int cpu)
 {
-	return pv_ops.time.steal_clock(cpu);
+	return static_call(pv_steal_clock)(cpu);
 }
 #endif
 
diff --git a/arch/arm/kernel/paravirt.c b/arch/arm/kernel/paravirt.c
index 4cfed91..7dd9806 100644
--- a/arch/arm/kernel/paravirt.c
+++ b/arch/arm/kernel/paravirt.c
@@ -9,10 +9,15 @@
 #include <linux/export.h>
 #include <linux/jump_label.h>
 #include <linux/types.h>
+#include <linux/static_call.h>
 #include <asm/paravirt.h>
 
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
 
-struct paravirt_patch_template pv_ops;
-EXPORT_SYMBOL_GPL(pv_ops);
+static u64 native_steal_clock(int cpu)
+{
+	return 0;
+}
+
+DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
diff --git a/arch/arm64/include/asm/paravirt.h b/arch/arm64/include/asm/paravirt.h
index cf3a0fd..9aa193e 100644
--- a/arch/arm64/include/asm/paravirt.h
+++ b/arch/arm64/include/asm/paravirt.h
@@ -3,23 +3,19 @@
 #define _ASM_ARM64_PARAVIRT_H
 
 #ifdef CONFIG_PARAVIRT
+#include <linux/static_call_types.h>
+
 struct static_key;
 extern struct static_key paravirt_steal_enabled;
 extern struct static_key paravirt_steal_rq_enabled;
 
-struct pv_time_ops {
-	unsigned long long (*steal_clock)(int cpu);
-};
-
-struct paravirt_patch_template {
-	struct pv_time_ops time;
-};
+u64 dummy_steal_clock(int cpu);
 
-extern struct paravirt_patch_template pv_ops;
+DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
 
 static inline u64 paravirt_steal_clock(int cpu)
 {
-	return pv_ops.time.steal_clock(cpu);
+	return static_call(pv_steal_clock)(cpu);
 }
 
 int __init pv_time_init(void);
diff --git a/arch/arm64/kernel/paravirt.c b/arch/arm64/kernel/paravirt.c
index c07d7a0..75fed44 100644
--- a/arch/arm64/kernel/paravirt.c
+++ b/arch/arm64/kernel/paravirt.c
@@ -18,6 +18,7 @@
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/static_call.h>
 
 #include <asm/paravirt.h>
 #include <asm/pvclock-abi.h>
@@ -26,8 +27,12 @@
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
 
-struct paravirt_patch_template pv_ops;
-EXPORT_SYMBOL_GPL(pv_ops);
+static u64 native_steal_clock(int cpu)
+{
+	return 0;
+}
+
+DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
 
 struct pv_time_stolen_time_region {
 	struct pvclock_vcpu_stolen_time *kaddr;
@@ -45,7 +50,7 @@ static int __init parse_no_stealacc(char *arg)
 early_param("no-steal-acc", parse_no_stealacc);
 
 /* return stolen time in ns by asking the hypervisor */
-static u64 pv_steal_clock(int cpu)
+static u64 para_steal_clock(int cpu)
 {
 	struct pv_time_stolen_time_region *reg;
 
@@ -150,7 +155,7 @@ int __init pv_time_init(void)
 	if (ret)
 		return ret;
 
-	pv_ops.time.steal_clock = pv_steal_clock;
+	static_call_update(pv_steal_clock, para_steal_clock);
 
 	static_key_slow_inc(&paravirt_steal_enabled);
 	if (steal_acc)
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879..107acc4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -777,6 +777,7 @@ if HYPERVISOR_GUEST
 
 config PARAVIRT
 	bool "Enable paravirtualization code"
+	depends on HAVE_STATIC_CALL
 	help
 	  This changes the kernel so it can modify itself when it is run
 	  under a hypervisor, potentially improving performance significantly
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index ccf60a8..e7be720 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -63,7 +63,7 @@ typedef int (*hyperv_fill_flush_list_func)(
 static __always_inline void hv_setup_sched_clock(void *sched_clock)
 {
 #ifdef CONFIG_PARAVIRT
-	pv_ops.time.sched_clock = sched_clock;
+	paravirt_set_sched_clock(sched_clock);
 #endif
 }
 
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 4abf110..6408fd0 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -15,11 +15,20 @@
 #include <linux/bug.h>
 #include <linux/types.h>
 #include <linux/cpumask.h>
+#include <linux/static_call_types.h>
 #include <asm/frame.h>
 
-static inline unsigned long long paravirt_sched_clock(void)
+u64 dummy_steal_clock(int cpu);
+u64 dummy_sched_clock(void);
+
+DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
+DECLARE_STATIC_CALL(pv_sched_clock, dummy_sched_clock);
+
+void paravirt_set_sched_clock(u64 (*func)(void));
+
+static inline u64 paravirt_sched_clock(void)
 {
-	return PVOP_CALL0(unsigned long long, time.sched_clock);
+	return static_call(pv_sched_clock)();
 }
 
 struct static_key;
@@ -33,7 +42,7 @@ bool pv_is_native_vcpu_is_preempted(void);
 
 static inline u64 paravirt_steal_clock(int cpu)
 {
-	return PVOP_CALL1(u64, time.steal_clock, cpu);
+	return static_call(pv_steal_clock)(cpu);
 }
 
 /* The paravirtualized I/O functions */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index de87087..1fff349 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -95,11 +95,6 @@ struct pv_lazy_ops {
 } __no_randomize_layout;
 #endif
 
-struct pv_time_ops {
-	unsigned long long (*sched_clock)(void);
-	unsigned long long (*steal_clock)(int cpu);
-} __no_randomize_layout;
-
 struct pv_cpu_ops {
 	/* hooks for various privileged instructions */
 	void (*io_delay)(void);
@@ -291,7 +286,6 @@ struct pv_lock_ops {
  * what to patch. */
 struct paravirt_patch_template {
 	struct pv_init_ops	init;
-	struct pv_time_ops	time;
 	struct pv_cpu_ops	cpu;
 	struct pv_irq_ops	irq;
 	struct pv_mmu_ops	mmu;
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index c6ede3b..84fb8e3 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -27,6 +27,7 @@
 #include <linux/clocksource.h>
 #include <linux/cpu.h>
 #include <linux/reboot.h>
+#include <linux/static_call.h>
 #include <asm/div64.h>
 #include <asm/x86_init.h>
 #include <asm/hypervisor.h>
@@ -336,11 +337,11 @@ static void __init vmware_paravirt_ops_setup(void)
 	vmware_cyc2ns_setup();
 
 	if (vmw_sched_clock)
-		pv_ops.time.sched_clock = vmware_sched_clock;
+		paravirt_set_sched_clock(vmware_sched_clock);
 
 	if (vmware_is_stealclock_available()) {
 		has_steal_clock = true;
-		pv_ops.time.steal_clock = vmware_steal_clock;
+		static_call_update(pv_steal_clock, vmware_steal_clock);
 
 		/* We use reboot notifier only to disable steal clock */
 		register_reboot_notifier(&vmware_pv_reboot_nb);
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 5e78e01..351ba99 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -650,7 +650,7 @@ static void __init kvm_guest_init(void)
 
 	if (kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
 		has_steal_clock = 1;
-		pv_ops.time.steal_clock = kvm_steal_clock;
+		static_call_update(pv_steal_clock, kvm_steal_clock);
 	}
 
 	if (pv_tlb_flush_supported()) {
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index aa59374..01e7c18 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -106,7 +106,7 @@ static inline void kvm_sched_clock_init(bool stable)
 	if (!stable)
 		clear_sched_clock_stable();
 	kvm_sched_clock_offset = kvm_clock_read();
-	pv_ops.time.sched_clock = kvm_sched_clock_read;
+	paravirt_set_sched_clock(kvm_sched_clock_read);
 
 	pr_info("kvm-clock: using sched offset of %llu cycles",
 		kvm_sched_clock_offset);
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index c60222a..a688edf 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -14,6 +14,7 @@
 #include <linux/highmem.h>
 #include <linux/kprobes.h>
 #include <linux/pgtable.h>
+#include <linux/static_call.h>
 
 #include <asm/bug.h>
 #include <asm/paravirt.h>
@@ -167,6 +168,14 @@ static u64 native_steal_clock(int cpu)
 	return 0;
 }
 
+DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
+DEFINE_STATIC_CALL(pv_sched_clock, native_sched_clock);
+
+void paravirt_set_sched_clock(u64 (*func)(void))
+{
+	static_call_update(pv_sched_clock, func);
+}
+
 /* These are in entry.S */
 extern void native_iret(void);
 
@@ -272,10 +281,6 @@ struct paravirt_patch_template pv_ops = {
 	/* Init ops. */
 	.init.patch		= native_patch,
 
-	/* Time ops. */
-	.time.sched_clock	= native_sched_clock,
-	.time.steal_clock	= native_steal_clock,
-
 	/* Cpu ops. */
 	.cpu.io_delay		= native_io_delay,
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index f70dffc..9f59292 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -14,6 +14,7 @@
 #include <linux/percpu.h>
 #include <linux/timex.h>
 #include <linux/static_key.h>
+#include <linux/static_call.h>
 
 #include <asm/hpet.h>
 #include <asm/timer.h>
@@ -254,7 +255,7 @@ unsigned long long sched_clock(void)
 
 bool using_native_sched_clock(void)
 {
-	return pv_ops.time.sched_clock == native_sched_clock;
+	return static_call_query(pv_sched_clock) == native_sched_clock;
 }
 #else
 unsigned long long
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 91f5b33..d9c945e 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -379,11 +379,6 @@ void xen_timer_resume(void)
 	}
 }
 
-static const struct pv_time_ops xen_time_ops __initconst = {
-	.sched_clock = xen_sched_clock,
-	.steal_clock = xen_steal_clock,
-};
-
 static struct pvclock_vsyscall_time_info *xen_clock __read_mostly;
 static u64 xen_clock_value_saved;
 
@@ -525,17 +520,24 @@ static void __init xen_time_init(void)
 		pvclock_gtod_register_notifier(&xen_pvclock_gtod_notifier);
 }
 
-void __init xen_init_time_ops(void)
+static void __init xen_init_time_common(void)
 {
 	xen_sched_clock_offset = xen_clocksource_read();
-	pv_ops.time = xen_time_ops;
+	static_call_update(pv_steal_clock, xen_steal_clock);
+	paravirt_set_sched_clock(xen_sched_clock);
+
+	x86_platform.calibrate_tsc = xen_tsc_khz;
+	x86_platform.get_wallclock = xen_get_wallclock;
+}
+
+void __init xen_init_time_ops(void)
+{
+	xen_init_time_common();
 
 	x86_init.timers.timer_init = xen_time_init;
 	x86_init.timers.setup_percpu_clockev = x86_init_noop;
 	x86_cpuinit.setup_percpu_clockev = x86_init_noop;
 
-	x86_platform.calibrate_tsc = xen_tsc_khz;
-	x86_platform.get_wallclock = xen_get_wallclock;
 	/* Dom0 uses the native method to set the hardware RTC. */
 	if (!xen_initial_domain())
 		x86_platform.set_wallclock = xen_set_wallclock;
@@ -569,13 +571,11 @@ void __init xen_hvm_init_time_ops(void)
 		return;
 	}
 
-	xen_sched_clock_offset = xen_clocksource_read();
-	pv_ops.time = xen_time_ops;
+	xen_init_time_common();
+
 	x86_init.timers.setup_percpu_clockev = xen_time_init;
 	x86_cpuinit.setup_percpu_clockev = xen_hvm_setup_cpu_clockevents;
 
-	x86_platform.calibrate_tsc = xen_tsc_khz;
-	x86_platform.get_wallclock = xen_get_wallclock;
 	x86_platform.set_wallclock = xen_set_wallclock;
 }
 #endif
diff --git a/drivers/xen/time.c b/drivers/xen/time.c
index 108edbc..152dd33 100644
--- a/drivers/xen/time.c
+++ b/drivers/xen/time.c
@@ -7,6 +7,7 @@
 #include <linux/math64.h>
 #include <linux/gfp.h>
 #include <linux/slab.h>
+#include <linux/static_call.h>
 
 #include <asm/paravirt.h>
 #include <asm/xen/hypervisor.h>
@@ -175,7 +176,7 @@ void __init xen_time_setup_guest(void)
 	xen_runstate_remote = !HYPERVISOR_vm_assist(VMASST_CMD_enable,
 					VMASST_TYPE_runstate_update_flag);
 
-	pv_ops.time.steal_clock = xen_steal_clock;
+	static_call_update(pv_steal_clock, xen_steal_clock);
 
 	static_key_slow_inc(&paravirt_steal_enabled);
 	if (xen_runstate_remote)
