Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975B442EDF9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Oct 2021 11:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbhJOJrO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Oct 2021 05:47:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48878 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237653AbhJOJrF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Oct 2021 05:47:05 -0400
Date:   Fri, 15 Oct 2021 09:44:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634291098;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zeOlde7sAEWsMr7a8BnO0H4y49+EsIfcutxGE7tgE/Y=;
        b=J1mjGTCxeCFuRmjn8neiTweiFPlc+1Y8sFWMniIGPjt/2AH6Wprg9mwnE8O9GlAF87t3EW
        mDCR3Ibq5IrZQhblWedumrRw+R4kEvwB7cmLyGu/hfJCAko1Ikxxl6/h+rc3ElaGFHll+h
        Ga8ejkSk/Z1cuWSFnWW+g+J6t0IWEX0oFxIn06noqbwKGsy3ZQOW1kEGYzy7sdDoNrZbrK
        JZ6rYLHP1qoYkevr3ih2hItsp5gpEGjO89rh68kjWYE+XsKASjsEfb0PJ8Swnk+RJbrcFc
        GZ2ah0JGcMGy3Wjc3dJVYWqWoEQJTDRH1Wbfh5bwyOIwVPLBD0g+P3Rp7ZfXVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634291098;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zeOlde7sAEWsMr7a8BnO0H4y49+EsIfcutxGE7tgE/Y=;
        b=ER8Kdo/7t917lMn4im+bGe70nI1LVQSfjIjR+o+6mtjrvzTJGU5kqEivL2I6Rd2EoesN6C
        8285b6/RIJIFH+AA==
From:   "tip-bot2 for Tim Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add cluster scheduler level for x86
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210924085104.44806-4-21cnbao@gmail.com>
References: <20210924085104.44806-4-21cnbao@gmail.com>
MIME-Version: 1.0
Message-ID: <163429109791.25758.3107620034958821511.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     66558b730f2533cc2bf2b74d51f5f80b81e2bad0
Gitweb:        https://git.kernel.org/tip/66558b730f2533cc2bf2b74d51f5f80b81e2bad0
Author:        Tim Chen <tim.c.chen@linux.intel.com>
AuthorDate:    Fri, 24 Sep 2021 20:51:04 +12:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Oct 2021 11:25:16 +02:00

sched: Add cluster scheduler level for x86

There are x86 CPU architectures (e.g. Jacobsville) where L2 cahce is
shared among a cluster of cores instead of being exclusive to one
single core.

To prevent oversubscription of L2 cache, load should be balanced
between such L2 clusters, especially for tasks with no shared data.
On benchmark such as SPECrate mcf test, this change provides a boost
to performance especially on medium load system on Jacobsville.  on a
Jacobsville that has 24 Atom cores, arranged into 6 clusters of 4
cores each, the benchmark number is as follow:

 Improvement over baseline kernel for mcf_r
 copies		run time	base rate
 1		-0.1%		-0.2%
 6		25.1%		25.1%
 12		18.8%		19.0%
 24		0.3%		0.3%

So this looks pretty good. In terms of the system's task distribution,
some pretty bad clumping can be seen for the vanilla kernel without
the L2 cluster domain for the 6 and 12 copies case. With the extra
domain for cluster, the load does get evened out between the clusters.

Note this patch isn't an universal win as spreading isn't necessarily
a win, particually for those workload who can benefit from packing.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210924085104.44806-4-21cnbao@gmail.com
---
 arch/x86/Kconfig                | 11 ++++++++-
 arch/x86/include/asm/smp.h      |  7 +++++-
 arch/x86/include/asm/topology.h |  3 ++-
 arch/x86/kernel/cpu/cacheinfo.c |  1 +-
 arch/x86/kernel/cpu/common.c    |  3 ++-
 arch/x86/kernel/smpboot.c       | 44 +++++++++++++++++++++++++++++++-
 6 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ab83c22..349e59b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1001,6 +1001,17 @@ config NR_CPUS
 	  This is purely to save memory: each supported CPU adds about 8KB
 	  to the kernel image.
 
+config SCHED_CLUSTER
+	bool "Cluster scheduler support"
+	depends on SMP
+	default y
+	help
+	  Cluster scheduler support improves the CPU scheduler's decision
+	  making when dealing with machines that have clusters of CPUs.
+	  Cluster usually means a couple of CPUs which are placed closely
+	  by sharing mid-level caches, last-level cache tags or internal
+	  busses.
+
 config SCHED_SMT
 	def_bool y if SMP
 
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 630ff08..08b0e90 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -16,7 +16,9 @@ DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
 /* cpus sharing the last level cache: */
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
+DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_l2c_shared_map);
 DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id);
+DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id);
 DECLARE_PER_CPU_READ_MOSTLY(int, cpu_number);
 
 static inline struct cpumask *cpu_llc_shared_mask(int cpu)
@@ -24,6 +26,11 @@ static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 	return per_cpu(cpu_llc_shared_map, cpu);
 }
 
+static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
+{
+	return per_cpu(cpu_l2c_shared_map, cpu);
+}
+
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid);
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid);
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_bios_cpu_apicid);
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 9239399..cc16477 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -103,6 +103,7 @@ static inline void setup_node_to_cpumask_map(void) { }
 #include <asm-generic/topology.h>
 
 extern const struct cpumask *cpu_coregroup_mask(int cpu);
+extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 
 #define topology_logical_package_id(cpu)	(cpu_data(cpu).logical_proc_id)
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).phys_proc_id)
@@ -113,7 +114,9 @@ extern const struct cpumask *cpu_coregroup_mask(int cpu);
 extern unsigned int __max_die_per_package;
 
 #ifdef CONFIG_SMP
+#define topology_cluster_id(cpu)		(per_cpu(cpu_l2c_id, cpu))
 #define topology_die_cpumask(cpu)		(per_cpu(cpu_die_map, cpu))
+#define topology_cluster_cpumask(cpu)		(cpu_clustergroup_mask(cpu))
 #define topology_core_cpumask(cpu)		(per_cpu(cpu_core_map, cpu))
 #define topology_sibling_cpumask(cpu)		(per_cpu(cpu_sibling_map, cpu))
 
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index b5e36bd..fe98a14 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -846,6 +846,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 		l2 = new_l2;
 #ifdef CONFIG_SMP
 		per_cpu(cpu_llc_id, cpu) = l2_id;
+		per_cpu(cpu_l2c_id, cpu) = l2_id;
 #endif
 	}
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0f88859..1c7897c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -85,6 +85,9 @@ u16 get_llc_id(unsigned int cpu)
 }
 EXPORT_SYMBOL_GPL(get_llc_id);
 
+/* L2 cache ID of each logical CPU */
+DEFINE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id) = BAD_APICID;
+
 /* correctly size the local cpu masks */
 void __init setup_cpu_local_masks(void)
 {
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 85f6e24..5094ab0 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -101,6 +101,8 @@ EXPORT_PER_CPU_SYMBOL(cpu_die_map);
 
 DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_llc_shared_map);
 
+DEFINE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_l2c_shared_map);
+
 /* Per CPU bogomips and other parameters */
 DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 EXPORT_PER_CPU_SYMBOL(cpu_info);
@@ -464,6 +466,21 @@ static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 	return false;
 }
 
+static bool match_l2c(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
+{
+	int cpu1 = c->cpu_index, cpu2 = o->cpu_index;
+
+	/* Do not match if we do not have a valid APICID for cpu: */
+	if (per_cpu(cpu_l2c_id, cpu1) == BAD_APICID)
+		return false;
+
+	/* Do not match if L2 cache id does not match: */
+	if (per_cpu(cpu_l2c_id, cpu1) != per_cpu(cpu_l2c_id, cpu2))
+		return false;
+
+	return topology_sane(c, o, "l2c");
+}
+
 /*
  * Unlike the other levels, we do not enforce keeping a
  * multicore group inside a NUMA node.  If this happens, we will
@@ -523,7 +540,7 @@ static bool match_llc(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 }
 
 
-#if defined(CONFIG_SCHED_SMT) || defined(CONFIG_SCHED_MC)
+#if defined(CONFIG_SCHED_SMT) || defined(CONFIG_SCHED_CLUSTER) || defined(CONFIG_SCHED_MC)
 static inline int x86_sched_itmt_flags(void)
 {
 	return sysctl_sched_itmt_enabled ? SD_ASYM_PACKING : 0;
@@ -541,12 +558,21 @@ static int x86_smt_flags(void)
 	return cpu_smt_flags() | x86_sched_itmt_flags();
 }
 #endif
+#ifdef CONFIG_SCHED_CLUSTER
+static int x86_cluster_flags(void)
+{
+	return cpu_cluster_flags() | x86_sched_itmt_flags();
+}
+#endif
 #endif
 
 static struct sched_domain_topology_level x86_numa_in_package_topology[] = {
 #ifdef CONFIG_SCHED_SMT
 	{ cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT) },
 #endif
+#ifdef CONFIG_SCHED_CLUSTER
+	{ cpu_clustergroup_mask, x86_cluster_flags, SD_INIT_NAME(CLS) },
+#endif
 #ifdef CONFIG_SCHED_MC
 	{ cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC) },
 #endif
@@ -557,6 +583,9 @@ static struct sched_domain_topology_level x86_topology[] = {
 #ifdef CONFIG_SCHED_SMT
 	{ cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT) },
 #endif
+#ifdef CONFIG_SCHED_CLUSTER
+	{ cpu_clustergroup_mask, x86_cluster_flags, SD_INIT_NAME(CLS) },
+#endif
 #ifdef CONFIG_SCHED_MC
 	{ cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC) },
 #endif
@@ -584,6 +613,7 @@ void set_cpu_sibling_map(int cpu)
 	if (!has_mp) {
 		cpumask_set_cpu(cpu, topology_sibling_cpumask(cpu));
 		cpumask_set_cpu(cpu, cpu_llc_shared_mask(cpu));
+		cpumask_set_cpu(cpu, cpu_l2c_shared_mask(cpu));
 		cpumask_set_cpu(cpu, topology_core_cpumask(cpu));
 		cpumask_set_cpu(cpu, topology_die_cpumask(cpu));
 		c->booted_cores = 1;
@@ -602,6 +632,9 @@ void set_cpu_sibling_map(int cpu)
 		if ((i == cpu) || (has_mp && match_llc(c, o)))
 			link_mask(cpu_llc_shared_mask, cpu, i);
 
+		if ((i == cpu) || (has_mp && match_l2c(c, o)))
+			link_mask(cpu_l2c_shared_mask, cpu, i);
+
 		if ((i == cpu) || (has_mp && match_die(c, o)))
 			link_mask(topology_die_cpumask, cpu, i);
 	}
@@ -652,6 +685,11 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
 	return cpu_llc_shared_mask(cpu);
 }
 
+const struct cpumask *cpu_clustergroup_mask(int cpu)
+{
+	return cpu_l2c_shared_mask(cpu);
+}
+
 static void impress_friends(void)
 {
 	int cpu;
@@ -1335,6 +1373,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 		zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_die_map, i), GFP_KERNEL);
 		zalloc_cpumask_var(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL);
+		zalloc_cpumask_var(&per_cpu(cpu_l2c_shared_map, i), GFP_KERNEL);
 	}
 
 	/*
@@ -1564,7 +1603,10 @@ static void remove_siblinginfo(int cpu)
 
 	for_each_cpu(sibling, cpu_llc_shared_mask(cpu))
 		cpumask_clear_cpu(cpu, cpu_llc_shared_mask(sibling));
+	for_each_cpu(sibling, cpu_l2c_shared_mask(cpu))
+		cpumask_clear_cpu(cpu, cpu_l2c_shared_mask(sibling));
 	cpumask_clear(cpu_llc_shared_mask(cpu));
+	cpumask_clear(cpu_l2c_shared_mask(cpu));
 	cpumask_clear(topology_sibling_cpumask(cpu));
 	cpumask_clear(topology_core_cpumask(cpu));
 	cpumask_clear(topology_die_cpumask(cpu));
