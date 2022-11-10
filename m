Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9CD624227
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Nov 2022 13:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiKJMVz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Nov 2022 07:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiKJMVx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Nov 2022 07:21:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE022AE03;
        Thu, 10 Nov 2022 04:21:51 -0800 (PST)
Date:   Thu, 10 Nov 2022 12:21:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668082910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fx8BolJ4Db1/lxoA9sH+WI4/m5NkYmQd8BF12q2o7HI=;
        b=AtfMu3b9yUTxT2kigQSeATWqp1cdfoSYcxWavPE43XeIM0WwjjoZc+HX7L1/q/II3cZiY6
        Kq4ZMBzy++/iazZVEe4WlitxbgweC/nlBYmfdx2Mlo3Nic8hNIfG0fp/BxLgedfJsFUIeT
        n4wDayW9gRBp4QQ2tKN/IxMJtLeCVNAhvHihAxTlQ5+oWfFQCVsvhiXCc1He+sl9cr6vsM
        SHF0PhFOuM7xRjP+Ch6hBBucEqs7F/fzztRiZ3jxZbY0DwgJ/OhrJ3PXZMNqygQw9+2Xrf
        1I/JeruXXy8vcK0pH8ghxf1dJpqQSMrvI1zb9Re/yKgFWIqhkf04Zh4tVdNeVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668082910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fx8BolJ4Db1/lxoA9sH+WI4/m5NkYmQd8BF12q2o7HI=;
        b=CvM6sTvtys7pzI49yiMO9bG/EYxl1dGUYr2+RRMXZagLJL5iGdBV4UnrqOUsSuSJV1atzk
        1kcDcF08n2EVZ9AA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mtrr: Add a stop_machine() handler calling only
 cache_cpu_init()
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221102074713.21493-13-jgross@suse.com>
References: <20221102074713.21493-13-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <166808290920.4906.1225943810635030819.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     0b9a6a8bedbfb38e7c6be4d119a267e6277307cc
Gitweb:        https://git.kernel.org/tip/0b9a6a8bedbfb38e7c6be4d119a267e6277307cc
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Wed, 02 Nov 2022 08:47:09 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 10 Nov 2022 13:12:45 +01:00

x86/mtrr: Add a stop_machine() handler calling only cache_cpu_init()

Instead of having a stop_machine() handler for either a specific
MTRR register or all state at once, add a handler just for calling
cache_cpu_init() if appropriate.

Add functions for calling stop_machine() with this handler as well.

Add a generic replacement for mtrr_bp_restore() and a wrapper for
mtrr_bp_init().

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221102074713.21493-13-jgross@suse.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/cacheinfo.h |  5 +-
 arch/x86/include/asm/mtrr.h      |  8 +---
 arch/x86/kernel/cpu/cacheinfo.c  | 59 ++++++++++++++++++++-
 arch/x86/kernel/cpu/common.c     |  3 +-
 arch/x86/kernel/cpu/mtrr/mtrr.c  | 88 +-------------------------------
 arch/x86/kernel/setup.c          |  3 +-
 arch/x86/kernel/smpboot.c        |  4 +-
 arch/x86/power/cpu.c             |  3 +-
 8 files changed, 74 insertions(+), 99 deletions(-)

diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
index e443fcc..a0ef46e 100644
--- a/arch/x86/include/asm/cacheinfo.h
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -12,8 +12,11 @@ void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu);
 
 void cache_disable(void);
 void cache_enable(void);
-void cache_cpu_init(void);
 void set_cache_aps_delayed_init(bool val);
 bool get_cache_aps_delayed_init(void);
+void cache_bp_init(void);
+void cache_bp_restore(void);
+void cache_ap_init(void);
+void cache_aps_init(void);
 
 #endif /* _ASM_X86_CACHEINFO_H */
diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 5d31219..f0eeaf6 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -25,13 +25,12 @@
 
 #include <uapi/asm/mtrr.h>
 
-void mtrr_bp_init(void);
-
 /*
  * The following functions are for use by other drivers that cannot use
  * arch_phys_wc_add and arch_phys_wc_del.
  */
 # ifdef CONFIG_MTRR
+void mtrr_bp_init(void);
 extern u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform);
 extern void mtrr_save_fixed_ranges(void *);
 extern void mtrr_save_state(void);
@@ -42,8 +41,6 @@ extern int mtrr_add_page(unsigned long base, unsigned long size,
 extern int mtrr_del(int reg, unsigned long base, unsigned long size);
 extern int mtrr_del_page(int reg, unsigned long base, unsigned long size);
 extern void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi);
-extern void mtrr_ap_init(void);
-extern void mtrr_aps_init(void);
 extern void mtrr_bp_restore(void);
 extern int mtrr_trim_uncached_memory(unsigned long end_pfn);
 extern int amd_special_default_mtrr(void);
@@ -85,8 +82,7 @@ static inline int mtrr_trim_uncached_memory(unsigned long end_pfn)
 static inline void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi)
 {
 }
-#define mtrr_ap_init() do {} while (0)
-#define mtrr_aps_init() do {} while (0)
+#define mtrr_bp_init() do {} while (0)
 #define mtrr_bp_restore() do {} while (0)
 #define mtrr_disable() do {} while (0)
 #define mtrr_enable() do {} while (0)
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 063d556..4e155bd 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -15,6 +15,7 @@
 #include <linux/capability.h>
 #include <linux/sysfs.h>
 #include <linux/pci.h>
+#include <linux/stop_machine.h>
 
 #include <asm/cpufeature.h>
 #include <asm/cacheinfo.h>
@@ -1121,7 +1122,7 @@ void cache_enable(void) __releases(cache_disable_lock)
 	raw_spin_unlock(&cache_disable_lock);
 }
 
-void cache_cpu_init(void)
+static void cache_cpu_init(void)
 {
 	unsigned long flags;
 
@@ -1149,3 +1150,59 @@ bool get_cache_aps_delayed_init(void)
 {
 	return cache_aps_delayed_init;
 }
+
+static int cache_rendezvous_handler(void *unused)
+{
+	if (get_cache_aps_delayed_init() || !cpu_online(smp_processor_id()))
+		cache_cpu_init();
+
+	return 0;
+}
+
+void __init cache_bp_init(void)
+{
+	mtrr_bp_init();
+
+	if (memory_caching_control)
+		cache_cpu_init();
+}
+
+void cache_bp_restore(void)
+{
+	if (memory_caching_control)
+		cache_cpu_init();
+}
+
+void cache_ap_init(void)
+{
+	if (!memory_caching_control || get_cache_aps_delayed_init())
+		return;
+
+	/*
+	 * Ideally we should hold mtrr_mutex here to avoid MTRR entries
+	 * changed, but this routine will be called in CPU boot time,
+	 * holding the lock breaks it.
+	 *
+	 * This routine is called in two cases:
+	 *
+	 *   1. very early time of software resume, when there absolutely
+	 *      isn't MTRR entry changes;
+	 *
+	 *   2. CPU hotadd time. We let mtrr_add/del_page hold cpuhotplug
+	 *      lock to prevent MTRR entry changes
+	 */
+	stop_machine_from_inactive_cpu(cache_rendezvous_handler, NULL,
+				       cpu_callout_mask);
+}
+
+/*
+ * Delayed cache initialization for all AP's
+ */
+void cache_aps_init(void)
+{
+	if (!memory_caching_control || !get_cache_aps_delayed_init())
+		return;
+
+	stop_machine(cache_rendezvous_handler, NULL, cpu_online_mask);
+	set_cache_aps_delayed_init(false);
+}
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3e508f2..fd058b5 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -52,6 +52,7 @@
 #include <asm/cpu.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
+#include <asm/cacheinfo.h>
 #include <asm/memtype.h>
 #include <asm/microcode.h>
 #include <asm/microcode_intel.h>
@@ -1948,7 +1949,7 @@ void identify_secondary_cpu(struct cpuinfo_x86 *c)
 #ifdef CONFIG_X86_32
 	enable_sep_cpu();
 #endif
-	mtrr_ap_init();
+	cache_ap_init();
 	validate_apic_and_package_id(c);
 	x86_spec_ctrl_setup_ap();
 	update_srbds_msr();
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 15ee6d7..99b6973 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -73,9 +73,6 @@ static const struct mtrr_ops *mtrr_ops[X86_VENDOR_NUM] __ro_after_init;
 
 const struct mtrr_ops *mtrr_if;
 
-static void set_mtrr(unsigned int reg, unsigned long base,
-		     unsigned long size, mtrr_type type);
-
 void __init set_mtrr_ops(const struct mtrr_ops *ops)
 {
 	if (ops->vendor && ops->vendor < X86_VENDOR_NUM)
@@ -158,26 +155,8 @@ static int mtrr_rendezvous_handler(void *info)
 {
 	struct set_mtrr_data *data = info;
 
-	/*
-	 * We use this same function to initialize the mtrrs during boot,
-	 * resume, runtime cpu online and on an explicit request to set a
-	 * specific MTRR.
-	 *
-	 * During boot or suspend, the state of the boot cpu's mtrrs has been
-	 * saved, and we want to replicate that across all the cpus that come
-	 * online (either at the end of boot or resume or during a runtime cpu
-	 * online). If we're doing that, @reg is set to something special and on
-	 * all the CPUs we do cache_cpu_init() (On the logical CPU that
-	 * started the boot/resume sequence, this might be a duplicate
-	 * cache_cpu_init()).
-	 */
-	if (data->smp_reg != ~0U) {
-		mtrr_if->set(data->smp_reg, data->smp_base,
-			     data->smp_size, data->smp_type);
-	} else if (get_cache_aps_delayed_init() ||
-		   !cpu_online(smp_processor_id())) {
-		cache_cpu_init();
-	}
+	mtrr_if->set(data->smp_reg, data->smp_base,
+		     data->smp_size, data->smp_type);
 	return 0;
 }
 
@@ -247,19 +226,6 @@ static void set_mtrr_cpuslocked(unsigned int reg, unsigned long base,
 	stop_machine_cpuslocked(mtrr_rendezvous_handler, &data, cpu_online_mask);
 }
 
-static void set_mtrr_from_inactive_cpu(unsigned int reg, unsigned long base,
-				      unsigned long size, mtrr_type type)
-{
-	struct set_mtrr_data data = { .smp_reg = reg,
-				      .smp_base = base,
-				      .smp_size = size,
-				      .smp_type = type
-				    };
-
-	stop_machine_from_inactive_cpu(mtrr_rendezvous_handler, &data,
-				       cpu_callout_mask);
-}
-
 /**
  * mtrr_add_page - Add a memory type region
  * @base: Physical base address of region in pages (in units of 4 kB!)
@@ -761,7 +727,6 @@ void __init mtrr_bp_init(void)
 			if (get_mtrr_state()) {
 				memory_caching_control |= CACHE_MTRR | CACHE_PAT;
 				changed_by_mtrr_cleanup = mtrr_cleanup(phys_addr);
-				cache_cpu_init();
 			} else {
 				mtrr_if = NULL;
 			}
@@ -780,27 +745,6 @@ void __init mtrr_bp_init(void)
 	}
 }
 
-void mtrr_ap_init(void)
-{
-	if (!memory_caching_control || get_cache_aps_delayed_init())
-		return;
-
-	/*
-	 * Ideally we should hold mtrr_mutex here to avoid mtrr entries
-	 * changed, but this routine will be called in cpu boot time,
-	 * holding the lock breaks it.
-	 *
-	 * This routine is called in two cases:
-	 *
-	 *   1. very early time of software resume, when there absolutely
-	 *      isn't mtrr entry changes;
-	 *
-	 *   2. cpu hotadd time. We let mtrr_add/del_page hold cpuhotplug
-	 *      lock to prevent mtrr entry changes
-	 */
-	set_mtrr_from_inactive_cpu(~0U, 0, 0, 0);
-}
-
 /**
  * mtrr_save_state - Save current fixed-range MTRR state of the first
  *	cpu in cpu_online_mask.
@@ -816,34 +760,6 @@ void mtrr_save_state(void)
 	smp_call_function_single(first_cpu, mtrr_save_fixed_ranges, NULL, 1);
 }
 
-/*
- * Delayed MTRR initialization for all AP's
- */
-void mtrr_aps_init(void)
-{
-	if (!memory_caching_control)
-		return;
-
-	/*
-	 * Check if someone has requested the delay of AP MTRR initialization,
-	 * by doing set_mtrr_aps_delayed_init(), prior to this point. If not,
-	 * then we are done.
-	 */
-	if (!get_cache_aps_delayed_init())
-		return;
-
-	set_mtrr(~0U, 0, 0, 0);
-	set_cache_aps_delayed_init(false);
-}
-
-void mtrr_bp_restore(void)
-{
-	if (!memory_caching_control)
-		return;
-
-	cache_cpu_init();
-}
-
 static int __init mtrr_init_finialize(void)
 {
 	if (!mtrr_enabled())
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 216fee7..e0e185e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -34,6 +34,7 @@
 #include <asm/numa.h>
 #include <asm/bios_ebda.h>
 #include <asm/bugs.h>
+#include <asm/cacheinfo.h>
 #include <asm/cpu.h>
 #include <asm/efi.h>
 #include <asm/gart.h>
@@ -1075,7 +1076,7 @@ void __init setup_arch(char **cmdline_p)
 
 	/* update e820 for memory not covered by WB MTRRs */
 	if (IS_ENABLED(CONFIG_MTRR))
-		mtrr_bp_init();
+		cache_bp_init();
 	else
 		pat_disable("PAT support disabled because CONFIG_MTRR is disabled in the kernel.");
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 13c71ab..1b61a48 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1445,7 +1445,7 @@ void arch_thaw_secondary_cpus_begin(void)
 
 void arch_thaw_secondary_cpus_end(void)
 {
-	mtrr_aps_init();
+	cache_aps_init();
 }
 
 /*
@@ -1488,7 +1488,7 @@ void __init native_smp_cpus_done(unsigned int max_cpus)
 
 	nmi_selftest();
 	impress_friends();
-	mtrr_aps_init();
+	cache_aps_init();
 }
 
 static int __initdata setup_possible_cpus = -1;
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index bb176c7..754221c 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -23,6 +23,7 @@
 #include <asm/fpu/api.h>
 #include <asm/debugreg.h>
 #include <asm/cpu.h>
+#include <asm/cacheinfo.h>
 #include <asm/mmu_context.h>
 #include <asm/cpu_device_id.h>
 #include <asm/microcode.h>
@@ -261,7 +262,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	do_fpu_end();
 	tsc_verify_tsc_adjust(true);
 	x86_platform.restore_sched_clock_state();
-	mtrr_bp_restore();
+	cache_bp_restore();
 	perf_restore_debug_store();
 
 	c = &cpu_data(smp_processor_id());
