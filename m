Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C572D72E6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Dec 2020 10:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437442AbgLKJfa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 11 Dec 2020 04:35:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33410 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405660AbgLKJfX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 11 Dec 2020 04:35:23 -0500
Date:   Fri, 11 Dec 2020 09:34:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607679279;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=60km010mC9RoUTn1z/igDlQ15uyYnPrnxjnPCaBrpF4=;
        b=fB390mXKo8ooyG5d0Og9qJDCfu/46nVenNvPaIjdDtdELlIjMoXb2BIMeqyIvnD2fg742P
        ilNEGiP1ifWf6C4uysqqJEHKzN1DPUWTf+oOagtOI3XToWkiT5gcD7ppum2SvLFNVtr1zs
        7f+D0QLNM6Ql2qfGcePLHgxAHPckv2h79DSB8Smvk0vl+IZJYho3GsunNAda9GMB6J5LqR
        Cd7TGGKf+/D/M6SnrS15pHYlMjYQJrBD29L7aWVyeOl9ZHEuVJDS1kcaftiz8gg5/kcrl4
        ZkHYb1uwFn8uvTF9jRAfu4TxMRfMxKHsZfkpC/GoTC5KUhhFh3Kz1Y5pIECmmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607679279;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=60km010mC9RoUTn1z/igDlQ15uyYnPrnxjnPCaBrpF4=;
        b=8SCOD4C/PHOOsQ/SKThpDfCyRUpRL3KqOHoGVqhRMNzLKz+1Wy79RSC9d+uccGGyMuiyeX
        VCEm61H+kKZ+XEDg==
From:   "tip-bot2 for Nathan Fontenot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86, sched: Calculate frequency invariance for AMD systems
Cc:     Nathan Fontenot <nathan.fontenot@amd.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201112182614.10700-2-ggherdovich@suse.cz>
References: <20201112182614.10700-2-ggherdovich@suse.cz>
MIME-Version: 1.0
Message-ID: <160767927905.3364.10740140175472571846.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     41ea667227bad5c247d76e6605054e96e4d95f51
Gitweb:        https://git.kernel.org/tip/41ea667227bad5c247d76e6605054e96e4d95f51
Author:        Nathan Fontenot <nathan.fontenot@amd.com>
AuthorDate:    Thu, 12 Nov 2020 19:26:12 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Dec 2020 10:26:00 +01:00

x86, sched: Calculate frequency invariance for AMD systems

This is the first pass in creating the ability to calculate the
frequency invariance on AMD systems. This approach uses the CPPC
highest performance and nominal performance values that range from
0 - 255 instead of a high and base frquency. This is because we do
not have the ability on AMD to get a highest frequency value.

On AMD systems the highest performance and nominal performance
vaues do correspond to the highest and base frequencies for the system
so using them should produce an appropriate ratio but some tweaking
is likely necessary.

Due to CPPC being initialized later in boot than when the frequency
invariant calculation is currently made, I had to create a callback
from the CPPC init code to do the calculation after we have CPPC
data.

Special thanks to "kernel test robot <lkp@intel.com>" for reporting that
compilation of drivers/acpi/cppc_acpi.c is conditional to
CONFIG_ACPI_CPPC_LIB, not just CONFIG_ACPI.

[ ggherdovich@suse.cz: made safe under CPU hotplug, edited changelog. ]

Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20201112182614.10700-2-ggherdovich@suse.cz
---
 arch/x86/include/asm/topology.h |  5 ++-
 arch/x86/kernel/smpboot.c       | 76 +++++++++++++++++++++++++++++---
 drivers/acpi/cppc_acpi.c        |  7 +++-
 3 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index f423457..488a8e8 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -218,4 +218,9 @@ static inline void arch_set_max_freq_ratio(bool turbo_disabled)
 }
 #endif
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+void init_freq_invariance_cppc(void);
+#define init_freq_invariance_cppc init_freq_invariance_cppc
+#endif
+
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index de776b2..a4ab5cf 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -82,6 +82,10 @@
 #include <asm/hw_irq.h>
 #include <asm/stackprotector.h>
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+#include <acpi/cppc_acpi.h>
+#endif
+
 /* representing HT siblings of each logical CPU */
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
@@ -148,7 +152,7 @@ static inline void smpboot_restore_warm_reset_vector(void)
 	*((volatile u32 *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) = 0;
 }
 
-static void init_freq_invariance(bool secondary);
+static void init_freq_invariance(bool secondary, bool cppc_ready);
 
 /*
  * Report back to the Boot Processor during boot time or to the caller processor
@@ -186,7 +190,7 @@ static void smp_callin(void)
 	 */
 	set_cpu_sibling_map(raw_smp_processor_id());
 
-	init_freq_invariance(true);
+	init_freq_invariance(true, false);
 
 	/*
 	 * Get our bogomips.
@@ -1340,7 +1344,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 	set_sched_topology(x86_topology);
 
 	set_cpu_sibling_map(0);
-	init_freq_invariance(false);
+	init_freq_invariance(false, false);
 	smp_sanity_check();
 
 	switch (apic_intr_mode) {
@@ -2027,6 +2031,46 @@ out:
 	return true;
 }
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+static bool amd_set_max_freq_ratio(void)
+{
+	struct cppc_perf_caps perf_caps;
+	u64 highest_perf, nominal_perf;
+	u64 perf_ratio;
+	int rc;
+
+	rc = cppc_get_perf_caps(0, &perf_caps);
+	if (rc) {
+		pr_debug("Could not retrieve perf counters (%d)\n", rc);
+		return false;
+	}
+
+	highest_perf = perf_caps.highest_perf;
+	nominal_perf = perf_caps.nominal_perf;
+
+	if (!highest_perf || !nominal_perf) {
+		pr_debug("Could not retrieve highest or nominal performance\n");
+		return false;
+	}
+
+	perf_ratio = div_u64(highest_perf * SCHED_CAPACITY_SCALE, nominal_perf);
+	if (!perf_ratio) {
+		pr_debug("Non-zero highest/nominal perf values led to a 0 ratio\n");
+		return false;
+	}
+
+	arch_turbo_freq_ratio = perf_ratio;
+	arch_set_max_freq_ratio(false);
+
+	return true;
+}
+#else
+static bool amd_set_max_freq_ratio(void)
+{
+	return false;
+}
+#endif
+
 static void init_counter_refs(void)
 {
 	u64 aperf, mperf;
@@ -2038,7 +2082,7 @@ static void init_counter_refs(void)
 	this_cpu_write(arch_prev_mperf, mperf);
 }
 
-static void init_freq_invariance(bool secondary)
+static void init_freq_invariance(bool secondary, bool cppc_ready)
 {
 	bool ret = false;
 
@@ -2054,6 +2098,12 @@ static void init_freq_invariance(bool secondary)
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
 		ret = intel_set_max_freq_ratio();
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
+		if (!cppc_ready) {
+			return;
+		}
+		ret = amd_set_max_freq_ratio();
+	}
 
 	if (ret) {
 		init_counter_refs();
@@ -2063,6 +2113,22 @@ static void init_freq_invariance(bool secondary)
 	}
 }
 
+#ifdef CONFIG_ACPI_CPPC_LIB
+static DEFINE_MUTEX(freq_invariance_lock);
+
+void init_freq_invariance_cppc(void)
+{
+	static bool secondary;
+
+	mutex_lock(&freq_invariance_lock);
+
+	init_freq_invariance(secondary, true);
+	secondary = true;
+
+	mutex_unlock(&freq_invariance_lock);
+}
+#endif
+
 static void disable_freq_invariance_workfn(struct work_struct *work)
 {
 	static_branch_disable(&arch_scale_freq_key);
@@ -2112,7 +2178,7 @@ error:
 	schedule_work(&disable_freq_invariance_work);
 }
 #else
-static inline void init_freq_invariance(bool secondary)
+static inline void init_freq_invariance(bool secondary, bool cppc_ready)
 {
 }
 #endif /* CONFIG_X86_64 */
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 7a99b19..a852dc4 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -39,6 +39,7 @@
 #include <linux/ktime.h>
 #include <linux/rwsem.h>
 #include <linux/wait.h>
+#include <linux/topology.h>
 
 #include <acpi/cppc_acpi.h>
 
@@ -688,6 +689,10 @@ static bool is_cppc_supported(int revision, int num_ent)
  *	}
  */
 
+#ifndef init_freq_invariance_cppc
+static inline void init_freq_invariance_cppc(void) { }
+#endif
+
 /**
  * acpi_cppc_processor_probe - Search for per CPU _CPC objects.
  * @pr: Ptr to acpi_processor containing this CPU's logical ID.
@@ -850,6 +855,8 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 		goto out_free;
 	}
 
+	init_freq_invariance_cppc();
+
 	kfree(output.pointer);
 	return 0;
 
