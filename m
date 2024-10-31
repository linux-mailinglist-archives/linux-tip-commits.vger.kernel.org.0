Return-Path: <linux-tip-commits+bounces-2675-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A162C9B7866
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 11:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D7E283618
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 10:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBD21991CA;
	Thu, 31 Oct 2024 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TnfrdX56";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NYJhWyil"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AF0195809;
	Thu, 31 Oct 2024 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730369343; cv=none; b=nNNwz6zXlA//aE8w1CL09Gx+Z1VXL3wHSOVN8wcbwmoNYITOJ+fTGDrgW2hh7SUnRi4vX0rUzyhFMefXpwy1J5/C71SWjoZmawQZN+FQFfe1nxY7DtOdtFrbplfP5yVKg2dsAdgkRwF4XqiXixtT0YOlszuRpgnWqnf6ozvZfFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730369343; c=relaxed/simple;
	bh=6kUoShWk+ZUidPlZMj+QyNPTl+lDJAIYMcQdZFhBJv4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LpP/W/yOq7njCvrG/ofpWNJnLFtzdhteyiiasESmqBcHQW2ZoggbfLPvH5CmTgY1ad7xjVoQaI3ziiDgv/aMZOAwCMazx5qTbwE3liLJg+bItQNRIPRKyS/Hfk5bF8wQHwssuIN2H0N3MrlK0yxLtCDQtuuNl7eTa5s/1IR9SNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TnfrdX56; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NYJhWyil; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 31 Oct 2024 10:08:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730369339;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4vvwKd5DgfBCyaXokrc5gOKgcP2VWtTqojMK1MCFqUA=;
	b=TnfrdX56QtOlgifwjb08lrVv5CQcui/y6aHUcj7/y7QHZHIo7D7T+2ICmC9XKdbZSPP0oM
	0SAJ/5nkGD3ORvRW+1w19ANFe/re3IlY0auuF0002+/LGGMKdIh57SnsM8a5/a8SCZulLS
	aeNUSYZLB+VdcRniHkg8w3Hit4J3R7MAt6zX7B9hgZiVDQIS+EMyF2SyZuR4gITgVvn7+e
	j6YauQlRMeCPt9f9VoUScqLOgdXswW7mO0ptZptKn8mDzH1KXzZ0+tdSP2P+RI/yxXDtGf
	xJzYomRFFJXPfKBs54kHLT3K1NcpaGneal3feB/hLfouXUGlaKOJieH4S7ZO2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730369339;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4vvwKd5DgfBCyaXokrc5gOKgcP2VWtTqojMK1MCFqUA=;
	b=NYJhWyild2ZUUqw9WsYYbypOvH79/qIS3BwzZYOmioRL4WUXuJacD3Pn1cND0yplTFVlqA
	Qd5unTve7stIsIDw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Clean up cpumask and hotplug
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Oliver Sang <oliver.sang@intel.com>,
 Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241010142604.770192-2-kan.liang@linux.intel.com>
References: <20241010142604.770192-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173036933801.3137.15000192257801252501.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9e9af8bbb5f9b565b9faf691f96f661791e199b0
Gitweb:        https://git.kernel.org/tip/9e9af8bbb5f9b565b9faf691f96f661791e199b0
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 10 Oct 2024 07:26:04 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 30 Oct 2024 22:42:19 +01:00

perf/x86/rapl: Clean up cpumask and hotplug

The rapl pmu is die scope, which is supported by the generic perf_event
subsystem now.

Set the scope for the rapl PMU and remove all the cpumask and hotplug
codes.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Oliver Sang <oliver.sang@intel.com>
Tested-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
Link: https://lore.kernel.org/r/20241010142604.770192-2-kan.liang@linux.intel.com
---
 arch/x86/events/rapl.c     | 90 ++-----------------------------------
 include/linux/cpuhotplug.h |  1 +-
 2 files changed, 6 insertions(+), 85 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 86cbee1..a8defc8 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -148,7 +148,6 @@ struct rapl_model {
  /* 1/2^hw_unit Joule */
 static int rapl_hw_unit[NR_RAPL_DOMAINS] __read_mostly;
 static struct rapl_pmus *rapl_pmus;
-static cpumask_t rapl_cpu_mask;
 static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
@@ -369,8 +368,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	if (event->cpu < 0)
 		return -EINVAL;
 
-	event->event_caps |= PERF_EV_CAP_READ_ACTIVE_PKG;
-
 	if (!cfg || cfg >= NR_RAPL_DOMAINS + 1)
 		return -EINVAL;
 
@@ -389,7 +386,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	pmu = cpu_to_rapl_pmu(event->cpu);
 	if (!pmu)
 		return -EINVAL;
-	event->cpu = pmu->cpu;
 	event->pmu_private = pmu;
 	event->hw.event_base = rapl_msrs[bit].msr;
 	event->hw.config = cfg;
@@ -403,23 +399,6 @@ static void rapl_pmu_event_read(struct perf_event *event)
 	rapl_event_update(event);
 }
 
-static ssize_t rapl_get_attr_cpumask(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	return cpumap_print_to_pagebuf(true, buf, &rapl_cpu_mask);
-}
-
-static DEVICE_ATTR(cpumask, S_IRUGO, rapl_get_attr_cpumask, NULL);
-
-static struct attribute *rapl_pmu_attrs[] = {
-	&dev_attr_cpumask.attr,
-	NULL,
-};
-
-static struct attribute_group rapl_pmu_attr_group = {
-	.attrs = rapl_pmu_attrs,
-};
-
 RAPL_EVENT_ATTR_STR(energy-cores, rapl_cores, "event=0x01");
 RAPL_EVENT_ATTR_STR(energy-pkg  ,   rapl_pkg, "event=0x02");
 RAPL_EVENT_ATTR_STR(energy-ram  ,   rapl_ram, "event=0x03");
@@ -467,7 +446,6 @@ static struct attribute_group rapl_pmu_format_group = {
 };
 
 static const struct attribute_group *rapl_attr_groups[] = {
-	&rapl_pmu_attr_group,
 	&rapl_pmu_format_group,
 	&rapl_pmu_events_group,
 	NULL,
@@ -570,54 +548,6 @@ static struct perf_msr amd_rapl_msrs[] = {
 	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
 };
 
-static int rapl_cpu_offline(unsigned int cpu)
-{
-	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
-	int target;
-
-	/* Check if exiting cpu is used for collecting rapl events */
-	if (!cpumask_test_and_clear_cpu(cpu, &rapl_cpu_mask))
-		return 0;
-
-	pmu->cpu = -1;
-	/* Find a new cpu to collect rapl events */
-	target = cpumask_any_but(get_rapl_pmu_cpumask(cpu), cpu);
-
-	/* Migrate rapl events to the new target */
-	if (target < nr_cpu_ids) {
-		cpumask_set_cpu(target, &rapl_cpu_mask);
-		pmu->cpu = target;
-		perf_pmu_migrate_context(pmu->pmu, cpu, target);
-	}
-	return 0;
-}
-
-static int rapl_cpu_online(unsigned int cpu)
-{
-	s32 rapl_pmu_idx = get_rapl_pmu_idx(cpu);
-	if (rapl_pmu_idx < 0) {
-		pr_err("topology_logical_(package/die)_id() returned a negative value");
-		return -EINVAL;
-	}
-	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
-	int target;
-
-	if (!pmu)
-		return -ENOMEM;
-
-	/*
-	 * Check if there is an online cpu in the package which collects rapl
-	 * events already.
-	 */
-	target = cpumask_any_and(&rapl_cpu_mask, get_rapl_pmu_cpumask(cpu));
-	if (target < nr_cpu_ids)
-		return 0;
-
-	cpumask_set_cpu(cpu, &rapl_cpu_mask);
-	pmu->cpu = cpu;
-	return 0;
-}
-
 static int rapl_check_hw_unit(struct rapl_model *rm)
 {
 	u64 msr_rapl_power_unit_bits;
@@ -725,9 +655,12 @@ free:
 static int __init init_rapl_pmus(void)
 {
 	int nr_rapl_pmu = topology_max_packages();
+	int rapl_pmu_scope = PERF_PMU_SCOPE_PKG;
 
-	if (!rapl_pmu_is_pkg_scope())
+	if (!rapl_pmu_is_pkg_scope()) {
 		nr_rapl_pmu *= topology_max_dies_per_package();
+		rapl_pmu_scope = PERF_PMU_SCOPE_DIE;
+	}
 
 	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
@@ -743,6 +676,7 @@ static int __init init_rapl_pmus(void)
 	rapl_pmus->pmu.start		= rapl_pmu_event_start;
 	rapl_pmus->pmu.stop		= rapl_pmu_event_stop;
 	rapl_pmus->pmu.read		= rapl_pmu_event_read;
+	rapl_pmus->pmu.scope		= rapl_pmu_scope;
 	rapl_pmus->pmu.module		= THIS_MODULE;
 	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
 
@@ -892,24 +826,13 @@ static int __init rapl_pmu_init(void)
 	if (ret)
 		return ret;
 
-	/*
-	 * Install callbacks. Core will call them for each online cpu.
-	 */
-	ret = cpuhp_setup_state(CPUHP_AP_PERF_X86_RAPL_ONLINE,
-				"perf/x86/rapl:online",
-				rapl_cpu_online, rapl_cpu_offline);
-	if (ret)
-		goto out;
-
 	ret = perf_pmu_register(&rapl_pmus->pmu, "power", -1);
 	if (ret)
-		goto out1;
+		goto out;
 
 	rapl_advertise();
 	return 0;
 
-out1:
-	cpuhp_remove_state(CPUHP_AP_PERF_X86_RAPL_ONLINE);
 out:
 	pr_warn("Initialization failed (%d), disabled\n", ret);
 	cleanup_rapl_pmus();
@@ -919,7 +842,6 @@ module_init(rapl_pmu_init);
 
 static void __exit intel_rapl_exit(void)
 {
-	cpuhp_remove_state_nocalls(CPUHP_AP_PERF_X86_RAPL_ONLINE);
 	perf_pmu_unregister(&rapl_pmus->pmu);
 	cleanup_rapl_pmus();
 }
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 2361ed4..37a9aff 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -208,7 +208,6 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_X86_UNCORE_ONLINE,
 	CPUHP_AP_PERF_X86_AMD_UNCORE_ONLINE,
 	CPUHP_AP_PERF_X86_AMD_POWER_ONLINE,
-	CPUHP_AP_PERF_X86_RAPL_ONLINE,
 	CPUHP_AP_PERF_S390_CF_ONLINE,
 	CPUHP_AP_PERF_S390_SF_ONLINE,
 	CPUHP_AP_PERF_ARM_CCI_ONLINE,

