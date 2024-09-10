Return-Path: <linux-tip-commits+bounces-2288-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E3597304E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 11:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34437286E97
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 09:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D3718EFD0;
	Tue, 10 Sep 2024 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pXG/PObm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dn2ca2kE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F07A18C037;
	Tue, 10 Sep 2024 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962348; cv=none; b=abC8kDewYhnZj2bcmCpLwRB6zSPXuhBrUpJ+oMN9GyPs6O6AoCMLzd3uGpvmfiJuZsLhxrc4nNwNoA9x37WC/9ZrgeFs2YiGf+0rLJVJwVtuFq7YjHbFDd66y6tpuiuIKvwS35k9m/OAq4r0hSlNs4yIc/WLdZJXja1Q9FO9zyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962348; c=relaxed/simple;
	bh=yImSSsjWEpu5lMqsGgt6ir9RDTFyT/c4iYIpBdH4AXk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kSPalUG76uJOWTvGLMWIkfhAypufzLAuKBR3olWvocXnds7swn/Sa99WAyzTOQoLXNEgGUn/Wp4e4O8DmCDgIoaiKzT5OpdqtoFzQsaAPhglH4F05WfQqag0XQyPEJxdco8HdTkLaxIW/D5AN+fBRIOsyK3CKPbvMr2bp7uGPwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pXG/PObm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dn2ca2kE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Sep 2024 09:59:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725962344;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mWLT7p1bOyO0LdCiqMlpfSNekkHySItaNimj5jQLvwY=;
	b=pXG/PObmdn7Ty2emUOiW1gBooAtHVnFr6ZKhSpehN/U4zkrcwr9H3iGlxVIXTX/nvgD/Ez
	TFFpqvDcAylNKBXxwWyGuz0rGBG84EYkhcpa/pOEaXc12O2yPAsXirAKIGNko8/IOffn4c
	J5umpjBRZtYYPpVPjrVCKJElBC2OQPN2LLcNVNKRa9nYO275chdjjxnoXhL9tyiKyDfhn5
	7qu9PJXmI4F5oCXum/oF1cITNorQ9gj8yWK6+/uGc9baKpLlkbRim+TT5Iwq9dbrFS2wXF
	peDh0qXfW/+affuzMqqzNVecCvSxKeqjVpP4CrMhcOsWDMeaBMlxzFOuQcjkZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725962344;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mWLT7p1bOyO0LdCiqMlpfSNekkHySItaNimj5jQLvwY=;
	b=dn2ca2kEtgP6u8xOmAClO7gAbbKk4qqR1cwRjlrVkHKqZYGPgoUgCrzFh/eiWnCTttslZl
	gvFz+ocOks89o5DA==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/cstate: Clean up cpumask and hotplug
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802151643.1691631-4-kan.liang@linux.intel.com>
References: <20240802151643.1691631-4-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172596234404.2215.16456839389297464641.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     08155c7f2a2cc6ff99886ea5743da274be24ebe4
Gitweb:        https://git.kernel.org/tip/08155c7f2a2cc6ff99886ea5743da274be24ebe4
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 02 Aug 2024 08:16:39 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Sep 2024 11:44:13 +02:00

perf/x86/intel/cstate: Clean up cpumask and hotplug

There are three cstate PMUs with different scopes, core, die and module.
The scopes are supported by the generic perf_event subsystem now.

Set the scope for each PMU and remove all the cpumask and hotplug codes.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240802151643.1691631-4-kan.liang@linux.intel.com
---
 arch/x86/events/intel/cstate.c | 142 +-------------------------------
 include/linux/cpuhotplug.h     |   2 +-
 2 files changed, 5 insertions(+), 139 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 9f116df..ae4ec16 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -128,10 +128,6 @@ static ssize_t __cstate_##_var##_show(struct device *dev,	\
 static struct device_attribute format_attr_##_var =		\
 	__ATTR(_name, 0444, __cstate_##_var##_show, NULL)
 
-static ssize_t cstate_get_attr_cpumask(struct device *dev,
-				       struct device_attribute *attr,
-				       char *buf);
-
 /* Model -> events mapping */
 struct cstate_model {
 	unsigned long		core_events;
@@ -206,22 +202,9 @@ static struct attribute_group cstate_format_attr_group = {
 	.attrs = cstate_format_attrs,
 };
 
-static cpumask_t cstate_core_cpu_mask;
-static DEVICE_ATTR(cpumask, S_IRUGO, cstate_get_attr_cpumask, NULL);
-
-static struct attribute *cstate_cpumask_attrs[] = {
-	&dev_attr_cpumask.attr,
-	NULL,
-};
-
-static struct attribute_group cpumask_attr_group = {
-	.attrs = cstate_cpumask_attrs,
-};
-
 static const struct attribute_group *cstate_attr_groups[] = {
 	&cstate_events_attr_group,
 	&cstate_format_attr_group,
-	&cpumask_attr_group,
 	NULL,
 };
 
@@ -269,8 +252,6 @@ static struct perf_msr pkg_msr[] = {
 	[PERF_CSTATE_PKG_C10_RES] = { MSR_PKG_C10_RESIDENCY,	&group_cstate_pkg_c10,	test_msr },
 };
 
-static cpumask_t cstate_pkg_cpu_mask;
-
 /* cstate_module PMU */
 static struct pmu cstate_module_pmu;
 static bool has_cstate_module;
@@ -291,28 +272,9 @@ static struct perf_msr module_msr[] = {
 	[PERF_CSTATE_MODULE_C6_RES]  = { MSR_MODULE_C6_RES_MS,	&group_cstate_module_c6,	test_msr },
 };
 
-static cpumask_t cstate_module_cpu_mask;
-
-static ssize_t cstate_get_attr_cpumask(struct device *dev,
-				       struct device_attribute *attr,
-				       char *buf)
-{
-	struct pmu *pmu = dev_get_drvdata(dev);
-
-	if (pmu == &cstate_core_pmu)
-		return cpumap_print_to_pagebuf(true, buf, &cstate_core_cpu_mask);
-	else if (pmu == &cstate_pkg_pmu)
-		return cpumap_print_to_pagebuf(true, buf, &cstate_pkg_cpu_mask);
-	else if (pmu == &cstate_module_pmu)
-		return cpumap_print_to_pagebuf(true, buf, &cstate_module_cpu_mask);
-	else
-		return 0;
-}
-
 static int cstate_pmu_event_init(struct perf_event *event)
 {
 	u64 cfg = event->attr.config;
-	int cpu;
 
 	if (event->attr.type != event->pmu->type)
 		return -ENOENT;
@@ -331,20 +293,13 @@ static int cstate_pmu_event_init(struct perf_event *event)
 		if (!(core_msr_mask & (1 << cfg)))
 			return -EINVAL;
 		event->hw.event_base = core_msr[cfg].msr;
-		cpu = cpumask_any_and(&cstate_core_cpu_mask,
-				      topology_sibling_cpumask(event->cpu));
 	} else if (event->pmu == &cstate_pkg_pmu) {
 		if (cfg >= PERF_CSTATE_PKG_EVENT_MAX)
 			return -EINVAL;
 		cfg = array_index_nospec((unsigned long)cfg, PERF_CSTATE_PKG_EVENT_MAX);
 		if (!(pkg_msr_mask & (1 << cfg)))
 			return -EINVAL;
-
-		event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
-
 		event->hw.event_base = pkg_msr[cfg].msr;
-		cpu = cpumask_any_and(&cstate_pkg_cpu_mask,
-				      topology_die_cpumask(event->cpu));
 	} else if (event->pmu == &cstate_module_pmu) {
 		if (cfg >= PERF_CSTATE_MODULE_EVENT_MAX)
 			return -EINVAL;
@@ -352,16 +307,10 @@ static int cstate_pmu_event_init(struct perf_event *event)
 		if (!(module_msr_mask & (1 << cfg)))
 			return -EINVAL;
 		event->hw.event_base = module_msr[cfg].msr;
-		cpu = cpumask_any_and(&cstate_module_cpu_mask,
-				      topology_cluster_cpumask(event->cpu));
 	} else {
 		return -ENOENT;
 	}
 
-	if (cpu >= nr_cpu_ids)
-		return -ENODEV;
-
-	event->cpu = cpu;
 	event->hw.config = cfg;
 	event->hw.idx = -1;
 	return 0;
@@ -412,84 +361,6 @@ static int cstate_pmu_event_add(struct perf_event *event, int mode)
 	return 0;
 }
 
-/*
- * Check if exiting cpu is the designated reader. If so migrate the
- * events when there is a valid target available
- */
-static int cstate_cpu_exit(unsigned int cpu)
-{
-	unsigned int target;
-
-	if (has_cstate_core &&
-	    cpumask_test_and_clear_cpu(cpu, &cstate_core_cpu_mask)) {
-
-		target = cpumask_any_but(topology_sibling_cpumask(cpu), cpu);
-		/* Migrate events if there is a valid target */
-		if (target < nr_cpu_ids) {
-			cpumask_set_cpu(target, &cstate_core_cpu_mask);
-			perf_pmu_migrate_context(&cstate_core_pmu, cpu, target);
-		}
-	}
-
-	if (has_cstate_pkg &&
-	    cpumask_test_and_clear_cpu(cpu, &cstate_pkg_cpu_mask)) {
-
-		target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
-		/* Migrate events if there is a valid target */
-		if (target < nr_cpu_ids) {
-			cpumask_set_cpu(target, &cstate_pkg_cpu_mask);
-			perf_pmu_migrate_context(&cstate_pkg_pmu, cpu, target);
-		}
-	}
-
-	if (has_cstate_module &&
-	    cpumask_test_and_clear_cpu(cpu, &cstate_module_cpu_mask)) {
-
-		target = cpumask_any_but(topology_cluster_cpumask(cpu), cpu);
-		/* Migrate events if there is a valid target */
-		if (target < nr_cpu_ids) {
-			cpumask_set_cpu(target, &cstate_module_cpu_mask);
-			perf_pmu_migrate_context(&cstate_module_pmu, cpu, target);
-		}
-	}
-	return 0;
-}
-
-static int cstate_cpu_init(unsigned int cpu)
-{
-	unsigned int target;
-
-	/*
-	 * If this is the first online thread of that core, set it in
-	 * the core cpu mask as the designated reader.
-	 */
-	target = cpumask_any_and(&cstate_core_cpu_mask,
-				 topology_sibling_cpumask(cpu));
-
-	if (has_cstate_core && target >= nr_cpu_ids)
-		cpumask_set_cpu(cpu, &cstate_core_cpu_mask);
-
-	/*
-	 * If this is the first online thread of that package, set it
-	 * in the package cpu mask as the designated reader.
-	 */
-	target = cpumask_any_and(&cstate_pkg_cpu_mask,
-				 topology_die_cpumask(cpu));
-	if (has_cstate_pkg && target >= nr_cpu_ids)
-		cpumask_set_cpu(cpu, &cstate_pkg_cpu_mask);
-
-	/*
-	 * If this is the first online thread of that cluster, set it
-	 * in the cluster cpu mask as the designated reader.
-	 */
-	target = cpumask_any_and(&cstate_module_cpu_mask,
-				 topology_cluster_cpumask(cpu));
-	if (has_cstate_module && target >= nr_cpu_ids)
-		cpumask_set_cpu(cpu, &cstate_module_cpu_mask);
-
-	return 0;
-}
-
 static const struct attribute_group *core_attr_update[] = {
 	&group_cstate_core_c1,
 	&group_cstate_core_c3,
@@ -526,6 +397,7 @@ static struct pmu cstate_core_pmu = {
 	.stop		= cstate_pmu_event_stop,
 	.read		= cstate_pmu_event_update,
 	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT | PERF_PMU_CAP_NO_EXCLUDE,
+	.scope		= PERF_PMU_SCOPE_CORE,
 	.module		= THIS_MODULE,
 };
 
@@ -541,6 +413,7 @@ static struct pmu cstate_pkg_pmu = {
 	.stop		= cstate_pmu_event_stop,
 	.read		= cstate_pmu_event_update,
 	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT | PERF_PMU_CAP_NO_EXCLUDE,
+	.scope		= PERF_PMU_SCOPE_PKG,
 	.module		= THIS_MODULE,
 };
 
@@ -556,6 +429,7 @@ static struct pmu cstate_module_pmu = {
 	.stop		= cstate_pmu_event_stop,
 	.read		= cstate_pmu_event_update,
 	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT | PERF_PMU_CAP_NO_EXCLUDE,
+	.scope		= PERF_PMU_SCOPE_CLUSTER,
 	.module		= THIS_MODULE,
 };
 
@@ -810,9 +684,6 @@ static int __init cstate_probe(const struct cstate_model *cm)
 
 static inline void cstate_cleanup(void)
 {
-	cpuhp_remove_state_nocalls(CPUHP_AP_PERF_X86_CSTATE_ONLINE);
-	cpuhp_remove_state_nocalls(CPUHP_AP_PERF_X86_CSTATE_STARTING);
-
 	if (has_cstate_core)
 		perf_pmu_unregister(&cstate_core_pmu);
 
@@ -827,11 +698,6 @@ static int __init cstate_init(void)
 {
 	int err;
 
-	cpuhp_setup_state(CPUHP_AP_PERF_X86_CSTATE_STARTING,
-			  "perf/x86/cstate:starting", cstate_cpu_init, NULL);
-	cpuhp_setup_state(CPUHP_AP_PERF_X86_CSTATE_ONLINE,
-			  "perf/x86/cstate:online", NULL, cstate_cpu_exit);
-
 	if (has_cstate_core) {
 		err = perf_pmu_register(&cstate_core_pmu, cstate_core_pmu.name, -1);
 		if (err) {
@@ -844,6 +710,8 @@ static int __init cstate_init(void)
 
 	if (has_cstate_pkg) {
 		if (topology_max_dies_per_package() > 1) {
+			/* CLX-AP is multi-die and the cstate is die-scope */
+			cstate_pkg_pmu.scope = PERF_PMU_SCOPE_DIE;
 			err = perf_pmu_register(&cstate_pkg_pmu,
 						"cstate_die", -1);
 		} else {
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 9316c39..2101ae2 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -152,7 +152,6 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
 	CPUHP_AP_PERF_X86_STARTING,
 	CPUHP_AP_PERF_X86_AMD_IBS_STARTING,
-	CPUHP_AP_PERF_X86_CSTATE_STARTING,
 	CPUHP_AP_PERF_XTENSA_STARTING,
 	CPUHP_AP_ARM_VFP_STARTING,
 	CPUHP_AP_ARM64_DEBUG_MONITORS_STARTING,
@@ -209,7 +208,6 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_X86_AMD_UNCORE_ONLINE,
 	CPUHP_AP_PERF_X86_AMD_POWER_ONLINE,
 	CPUHP_AP_PERF_X86_RAPL_ONLINE,
-	CPUHP_AP_PERF_X86_CSTATE_ONLINE,
 	CPUHP_AP_PERF_S390_CF_ONLINE,
 	CPUHP_AP_PERF_S390_SF_ONLINE,
 	CPUHP_AP_PERF_ARM_CCI_ONLINE,

