Return-Path: <linux-tip-commits+bounces-2290-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2688973054
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 12:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804E41F21DC3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 10:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4377418FC86;
	Tue, 10 Sep 2024 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JXVyFFZI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rtYXfYd3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D39618DF97;
	Tue, 10 Sep 2024 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962350; cv=none; b=qec0ZV4BhZqDqC6HyYRumh2y0ChyjwUT/0wvpZUDAqOwFmkt3f9V1LjNlkgQs1PRasP8O+LHsQPiNGfYNu8GMKP45+8WevjIXOYAA6La7ySrQOIT4mKMuPdKKyW1+H2vBYiUaNPnDVcCqNaqqTOJavBG3i2V2pUMkC8AnBqPSW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962350; c=relaxed/simple;
	bh=J5dZt4vVKoSbPQzibQmXF/lGyKBS1x3McEdK3wBrIpU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Vb21jFsmRQ155Zotz9qmHup4ob3F6be0aw/Jpo95mAjApxPQhtFRYABwLZezDCeAhrwd6Oo4B/ksAhiJS+3nmBJvHuIUYzcUTG2mZ0KTKzBGXLTCwuPnrUkTrQydVf+wUjMQjzkrZXNBq5ixEXrddnM5Pxv934UX0ovYZX3l+KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JXVyFFZI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rtYXfYd3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Sep 2024 09:59:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725962345;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJ/Oas0p/D3+9NVQXhWkcCD8XzealJPeLngBwbp8ftQ=;
	b=JXVyFFZIITPoCMCoVLHgjUyCJgg3CHhhgwMu9Vv5XjLnT+oSH8c97P5W/+vsmfuT6wE4Sy
	XYxpr3hNo4VjC4Dzzg/7n3GLLPwszeR1KxBABJMgC9MmVqP1FiZTvYM8ro2Rd4ZY9OrSbh
	nb4Cfyu/aH3Wjw7jQC2UZd7Mjxv9n6s4UMEp3IVahvOpFvBaeBGoVqJjAwVVTV2SbOUQlA
	Pwu8dLtcau0twOzUXBEIfESwHRKwxMb4pVHi/j1+QZHROs96XpOdoWQPEHsuux2JrlPSpn
	PGzJs1wEmzVOjlXvRdF8ZJ1JJd/ki3x/5duXcrF15a7lKd7WoNx2SUoe5DpKyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725962345;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJ/Oas0p/D3+9NVQXhWkcCD8XzealJPeLngBwbp8ftQ=;
	b=rtYXfYd37P7FlWBW+HvsO2Ujrc39uYnPY/g3TGvRS0MJS89Fo4C3SP7kKMqKTR9jO10ePL
	YxM3iHq3Z3T9SrAg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Generic hotplug support for a PMU with a scope
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802151643.1691631-2-kan.liang@linux.intel.com>
References: <20240802151643.1691631-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172596234514.2215.6662153156633974477.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4ba4f1afb6a9fed8ef896c2363076e36572f71da
Gitweb:        https://git.kernel.org/tip/4ba4f1afb6a9fed8ef896c2363076e36572f71da
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 02 Aug 2024 08:16:37 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Sep 2024 11:44:12 +02:00

perf: Generic hotplug support for a PMU with a scope

The perf subsystem assumes that the counters of a PMU are per-CPU. So
the user space tool reads a counter from each CPU in the system wide
mode. However, many PMUs don't have a per-CPU counter. The counter is
effective for a scope, e.g., a die or a socket. To address this, a
cpumask is exposed by the kernel driver to restrict to one CPU to stand
for a specific scope. In case the given CPU is removed,
the hotplug support has to be implemented for each such driver.

The codes to support the cpumask and hotplug are very similar.
- Expose a cpumask into sysfs
- Pickup another CPU in the same scope if the given CPU is removed.
- Invoke the perf_pmu_migrate_context() to migrate to a new CPU.
- In event init, always set the CPU in the cpumask to event->cpu

Similar duplicated codes are implemented for each such PMU driver. It
would be good to introduce a generic infrastructure to avoid such
duplication.

5 popular scopes are implemented here, core, die, cluster, pkg, and
the system-wide. The scope can be set when a PMU is registered. If so, a
"cpumask" is automatically exposed for the PMU.

The "cpumask" is from the perf_online_<scope>_mask, which is to track
the active CPU for each scope. They are set when the first CPU of the
scope is online via the generic perf hotplug support. When a
corresponding CPU is removed, the perf_online_<scope>_mask is updated
accordingly and the PMU will be moved to a new CPU from the same scope
if possible.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240802151643.1691631-2-kan.liang@linux.intel.com
---
 include/linux/perf_event.h |  18 ++++-
 kernel/events/core.c       | 164 +++++++++++++++++++++++++++++++++++-
 2 files changed, 180 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7015499..a3cbcd7 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -295,6 +295,19 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
 
+/**
+ * pmu::scope
+ */
+enum perf_pmu_scope {
+	PERF_PMU_SCOPE_NONE	= 0,
+	PERF_PMU_SCOPE_CORE,
+	PERF_PMU_SCOPE_DIE,
+	PERF_PMU_SCOPE_CLUSTER,
+	PERF_PMU_SCOPE_PKG,
+	PERF_PMU_SCOPE_SYS_WIDE,
+	PERF_PMU_MAX_SCOPE,
+};
+
 struct perf_output_handle;
 
 #define PMU_NULL_DEV	((void *)(~0UL))
@@ -318,6 +331,11 @@ struct pmu {
 	 */
 	int				capabilities;
 
+	/*
+	 * PMU scope
+	 */
+	unsigned int			scope;
+
 	int __percpu			*pmu_disable_count;
 	struct perf_cpu_pmu_context __percpu *cpu_pmu_context;
 	atomic_t			exclusive_cnt; /* < 0: cpu; > 0: tsk */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 67e115d..5ff9735 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -436,6 +436,11 @@ static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
 static struct srcu_struct pmus_srcu;
 static cpumask_var_t perf_online_mask;
+static cpumask_var_t perf_online_core_mask;
+static cpumask_var_t perf_online_die_mask;
+static cpumask_var_t perf_online_cluster_mask;
+static cpumask_var_t perf_online_pkg_mask;
+static cpumask_var_t perf_online_sys_mask;
 static struct kmem_cache *perf_event_cache;
 
 /*
@@ -11578,10 +11583,60 @@ perf_event_mux_interval_ms_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(perf_event_mux_interval_ms);
 
+static inline const struct cpumask *perf_scope_cpu_topology_cpumask(unsigned int scope, int cpu)
+{
+	switch (scope) {
+	case PERF_PMU_SCOPE_CORE:
+		return topology_sibling_cpumask(cpu);
+	case PERF_PMU_SCOPE_DIE:
+		return topology_die_cpumask(cpu);
+	case PERF_PMU_SCOPE_CLUSTER:
+		return topology_cluster_cpumask(cpu);
+	case PERF_PMU_SCOPE_PKG:
+		return topology_core_cpumask(cpu);
+	case PERF_PMU_SCOPE_SYS_WIDE:
+		return cpu_online_mask;
+	}
+
+	return NULL;
+}
+
+static inline struct cpumask *perf_scope_cpumask(unsigned int scope)
+{
+	switch (scope) {
+	case PERF_PMU_SCOPE_CORE:
+		return perf_online_core_mask;
+	case PERF_PMU_SCOPE_DIE:
+		return perf_online_die_mask;
+	case PERF_PMU_SCOPE_CLUSTER:
+		return perf_online_cluster_mask;
+	case PERF_PMU_SCOPE_PKG:
+		return perf_online_pkg_mask;
+	case PERF_PMU_SCOPE_SYS_WIDE:
+		return perf_online_sys_mask;
+	}
+
+	return NULL;
+}
+
+static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct cpumask *mask = perf_scope_cpumask(pmu->scope);
+
+	if (mask)
+		return cpumap_print_to_pagebuf(true, buf, mask);
+	return 0;
+}
+
+static DEVICE_ATTR_RO(cpumask);
+
 static struct attribute *pmu_dev_attrs[] = {
 	&dev_attr_type.attr,
 	&dev_attr_perf_event_mux_interval_ms.attr,
 	&dev_attr_nr_addr_filters.attr,
+	&dev_attr_cpumask.attr,
 	NULL,
 };
 
@@ -11593,6 +11648,10 @@ static umode_t pmu_dev_is_visible(struct kobject *kobj, struct attribute *a, int
 	if (n == 2 && !pmu->nr_addr_filters)
 		return 0;
 
+	/* cpumask */
+	if (n == 3 && pmu->scope == PERF_PMU_SCOPE_NONE)
+		return 0;
+
 	return a->mode;
 }
 
@@ -11677,6 +11736,11 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 		goto free_pdc;
 	}
 
+	if (WARN_ONCE(pmu->scope >= PERF_PMU_MAX_SCOPE, "Can not register a pmu with an invalid scope.\n")) {
+		ret = -EINVAL;
+		goto free_pdc;
+	}
+
 	pmu->name = name;
 
 	if (type >= 0)
@@ -11831,6 +11895,22 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 		    event_has_any_exclude_flag(event))
 			ret = -EINVAL;
 
+		if (pmu->scope != PERF_PMU_SCOPE_NONE && event->cpu >= 0) {
+			const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(pmu->scope, event->cpu);
+			struct cpumask *pmu_cpumask = perf_scope_cpumask(pmu->scope);
+			int cpu;
+
+			if (pmu_cpumask && cpumask) {
+				cpu = cpumask_any_and(pmu_cpumask, cpumask);
+				if (cpu >= nr_cpu_ids)
+					ret = -ENODEV;
+				else
+					event->cpu = cpu;
+			} else {
+				ret = -ENODEV;
+			}
+		}
+
 		if (ret && event->destroy)
 			event->destroy(event);
 	}
@@ -13784,6 +13864,12 @@ static void __init perf_event_init_all_cpus(void)
 	int cpu;
 
 	zalloc_cpumask_var(&perf_online_mask, GFP_KERNEL);
+	zalloc_cpumask_var(&perf_online_core_mask, GFP_KERNEL);
+	zalloc_cpumask_var(&perf_online_die_mask, GFP_KERNEL);
+	zalloc_cpumask_var(&perf_online_cluster_mask, GFP_KERNEL);
+	zalloc_cpumask_var(&perf_online_pkg_mask, GFP_KERNEL);
+	zalloc_cpumask_var(&perf_online_sys_mask, GFP_KERNEL);
+
 
 	for_each_possible_cpu(cpu) {
 		swhash = &per_cpu(swevent_htable, cpu);
@@ -13833,6 +13919,40 @@ static void __perf_event_exit_context(void *__info)
 	raw_spin_unlock(&ctx->lock);
 }
 
+static void perf_event_clear_cpumask(unsigned int cpu)
+{
+	int target[PERF_PMU_MAX_SCOPE];
+	unsigned int scope;
+	struct pmu *pmu;
+
+	cpumask_clear_cpu(cpu, perf_online_mask);
+
+	for (scope = PERF_PMU_SCOPE_NONE + 1; scope < PERF_PMU_MAX_SCOPE; scope++) {
+		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(scope, cpu);
+		struct cpumask *pmu_cpumask = perf_scope_cpumask(scope);
+
+		target[scope] = -1;
+		if (WARN_ON_ONCE(!pmu_cpumask || !cpumask))
+			continue;
+
+		if (!cpumask_test_and_clear_cpu(cpu, pmu_cpumask))
+			continue;
+		target[scope] = cpumask_any_but(cpumask, cpu);
+		if (target[scope] < nr_cpu_ids)
+			cpumask_set_cpu(target[scope], pmu_cpumask);
+	}
+
+	/* migrate */
+	list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
+		if (pmu->scope == PERF_PMU_SCOPE_NONE ||
+		    WARN_ON_ONCE(pmu->scope >= PERF_PMU_MAX_SCOPE))
+			continue;
+
+		if (target[pmu->scope] >= 0 && target[pmu->scope] < nr_cpu_ids)
+			perf_pmu_migrate_context(pmu, cpu, target[pmu->scope]);
+	}
+}
+
 static void perf_event_exit_cpu_context(int cpu)
 {
 	struct perf_cpu_context *cpuctx;
@@ -13840,6 +13960,11 @@ static void perf_event_exit_cpu_context(int cpu)
 
 	// XXX simplify cpuctx->online
 	mutex_lock(&pmus_lock);
+	/*
+	 * Clear the cpumasks, and migrate to other CPUs if possible.
+	 * Must be invoked before the __perf_event_exit_context.
+	 */
+	perf_event_clear_cpumask(cpu);
 	cpuctx = per_cpu_ptr(&perf_cpu_context, cpu);
 	ctx = &cpuctx->ctx;
 
@@ -13847,7 +13972,6 @@ static void perf_event_exit_cpu_context(int cpu)
 	smp_call_function_single(cpu, __perf_event_exit_context, ctx, 1);
 	cpuctx->online = 0;
 	mutex_unlock(&ctx->mutex);
-	cpumask_clear_cpu(cpu, perf_online_mask);
 	mutex_unlock(&pmus_lock);
 }
 #else
@@ -13856,6 +13980,42 @@ static void perf_event_exit_cpu_context(int cpu) { }
 
 #endif
 
+static void perf_event_setup_cpumask(unsigned int cpu)
+{
+	struct cpumask *pmu_cpumask;
+	unsigned int scope;
+
+	cpumask_set_cpu(cpu, perf_online_mask);
+
+	/*
+	 * Early boot stage, the cpumask hasn't been set yet.
+	 * The perf_online_<domain>_masks includes the first CPU of each domain.
+	 * Always uncondifionally set the boot CPU for the perf_online_<domain>_masks.
+	 */
+	if (!topology_sibling_cpumask(cpu)) {
+		for (scope = PERF_PMU_SCOPE_NONE + 1; scope < PERF_PMU_MAX_SCOPE; scope++) {
+			pmu_cpumask = perf_scope_cpumask(scope);
+			if (WARN_ON_ONCE(!pmu_cpumask))
+				continue;
+			cpumask_set_cpu(cpu, pmu_cpumask);
+		}
+		return;
+	}
+
+	for (scope = PERF_PMU_SCOPE_NONE + 1; scope < PERF_PMU_MAX_SCOPE; scope++) {
+		const struct cpumask *cpumask = perf_scope_cpu_topology_cpumask(scope, cpu);
+
+		pmu_cpumask = perf_scope_cpumask(scope);
+
+		if (WARN_ON_ONCE(!pmu_cpumask || !cpumask))
+			continue;
+
+		if (!cpumask_empty(cpumask) &&
+		    cpumask_any_and(pmu_cpumask, cpumask) >= nr_cpu_ids)
+			cpumask_set_cpu(cpu, pmu_cpumask);
+	}
+}
+
 int perf_event_init_cpu(unsigned int cpu)
 {
 	struct perf_cpu_context *cpuctx;
@@ -13864,7 +14024,7 @@ int perf_event_init_cpu(unsigned int cpu)
 	perf_swevent_init_cpu(cpu);
 
 	mutex_lock(&pmus_lock);
-	cpumask_set_cpu(cpu, perf_online_mask);
+	perf_event_setup_cpumask(cpu);
 	cpuctx = per_cpu_ptr(&perf_cpu_context, cpu);
 	ctx = &cpuctx->ctx;
 

