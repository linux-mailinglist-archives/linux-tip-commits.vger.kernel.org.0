Return-Path: <linux-tip-commits+bounces-2904-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C4B9DFFEA
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3BC6160870
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BF71FECD9;
	Mon,  2 Dec 2024 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yNubMoBv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oRaz4j8d"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB2F1FE465;
	Mon,  2 Dec 2024 11:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138058; cv=none; b=bV92UbolNRjH5FckZ8CC6hlXDP/+MXdVrw0AGsXPjnX7r2UWTrSnODbw5R9XRsgnbk6ovlFSXdhc4BcLYPFr4fKu0P9zOIEPbPR/HLqSWYvsj6AMcbRJ8UNm3OC4yqEf3PZr3lk+lye/lqjQulb3NucPmfAgziD5M37Logehd+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138058; c=relaxed/simple;
	bh=g6QNmdMC+erb7YQFA1bYlVLeRFmqptSrG/ee3QcnrSw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bYvSeOe8B3Gne0rj6wtzYhdMouKvniBZwwo/2Di0HIB6W72yVxsBXKFSvX8iiJHF6Jl+ri7ZOw0AAbNtie6o2Zkn/S4VTMAzIiM1YMJQzU4+bW6ogqGseMjWJcdXkNATChuLZLJWqTT5AMPaJq2+JDHN56sphtF2LetTGYI/Xsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yNubMoBv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oRaz4j8d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138053;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDdJhJmx7T7UcZRckUI1/cpDb/fbn7xuVqA6hNL7fuo=;
	b=yNubMoBv/bXqScNH0FBIYcLJtgbJYRbi6Kk5U3sE/6Q3Wdk71vQhE9zKwQJje27SKVsmxe
	jSdIlDahOF1QZy6F3LuhT7KmByXvjpNhzySEFYqSHpJFVpnmsZSSbWtxvnKk69URmJr9Kz
	2Tw6Qn84ILYT8sy4L+b4Wd6QA7807t0CU8T5oMXThnYiVVfIMyuIgCYgH4qr2+a+cbqMvJ
	deyjbN+L3VZ+4JA0mimVVAiJ0dGAAEvYIIMlmw9248tTFggN33/offvdm0aPzUMuCdfLw2
	YZiCWDD/S1B5K0YKZGvgDuNoKtxIprLQOWLf+sjjVBk1i73vD0+U5g6iNdzVNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138053;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDdJhJmx7T7UcZRckUI1/cpDb/fbn7xuVqA6hNL7fuo=;
	b=oRaz4j8dQ5dN3DVYLHXxoOX5GWis6TRhcjLd6+XyC3MU8epoTJdUKrfCBRq5mJ0MsL9ld2
	QORZXg++Q5fgPGBA==
From: "tip-bot2 for Dhananjay Ugwekar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/rapl: Add core energy counter support for AMD CPUs
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241115060805.447565-11-Dhananjay.Ugwekar@amd.com>
References: <20241115060805.447565-11-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313805303.412.1577529415849148939.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b4943b8bfc41ddd3796f3b87e1efa71a0c689f22
Gitweb:        https://git.kernel.org/tip/b4943b8bfc41ddd3796f3b87e1efa71a0c689f22
Author:        Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
AuthorDate:    Fri, 15 Nov 2024 06:08:06 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:37 +01:00

perf/x86/rapl: Add core energy counter support for AMD CPUs

Add a new "power_core" PMU and "energy-core" event for monitoring
energy consumption by each individual core. The existing energy-cores
event aggregates the energy consumption of CPU cores at the package level.
This new event aligns with the AMD's per-core energy counters.

Tested the package level and core level PMU counters with workloads
pinned to different CPUs.

Results with workload pinned to CPU 4 in core 4 on an AMD Zen4 Genoa
machine:

$ sudo perf stat --per-core -e power_core/energy-core/ -- taskset -c 4 stress-ng --matrix 1 --timeout 5s
stress-ng: info:  [21250] setting to a 5 second run per stressor
stress-ng: info:  [21250] dispatching hogs: 1 matrix
stress-ng: info:  [21250] successful run completed in 5.00s

 Performance counter stats for 'system wide':

S0-D0-C0              1               0.00 Joules power_core/energy-core/
S0-D0-C1              1               0.00 Joules power_core/energy-core/
S0-D0-C2              1               0.00 Joules power_core/energy-core/
S0-D0-C3              1               0.00 Joules power_core/energy-core/
S0-D0-C4              1               8.43 Joules power_core/energy-core/
S0-D0-C5              1               0.00 Joules power_core/energy-core/
S0-D0-C6              1               0.00 Joules power_core/energy-core/
S0-D0-C7              1               0.00 Joules power_core/energy-core/
S0-D1-C8              1               0.00 Joules power_core/energy-core/
S0-D1-C9              1               0.00 Joules power_core/energy-core/
S0-D1-C10             1               0.00 Joules power_core/energy-core/

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Link: https://lore.kernel.org/r/20241115060805.447565-11-Dhananjay.Ugwekar@amd.com
---
 arch/x86/events/rapl.c | 183 +++++++++++++++++++++++++++++++++-------
 1 file changed, 151 insertions(+), 32 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 139c308..d3bb386 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -39,6 +39,10 @@
  *	  event: rapl_energy_psys
  *    perf code: 0x5
  *
+ *  core counter: consumption of a single physical core
+ *	  event: rapl_energy_core (power_core PMU)
+ *    perf code: 0x1
+ *
  * We manage those counters as free running (read-only). They may be
  * use simultaneously by other tools, such as turbostat.
  *
@@ -81,6 +85,10 @@ enum perf_rapl_pkg_events {
 	NR_RAPL_PKG_DOMAINS = PERF_RAPL_PKG_EVENTS_MAX,
 };
 
+#define PERF_RAPL_CORE			0		/* single core */
+#define PERF_RAPL_CORE_EVENTS_MAX	1
+#define NR_RAPL_CORE_DOMAINS		PERF_RAPL_CORE_EVENTS_MAX
+
 static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst = {
 	"pp0-core",
 	"package",
@@ -89,6 +97,8 @@ static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst 
 	"psys",
 };
 
+static const char *const rapl_core_domain_name __initconst = "core";
+
 /*
  * event code: LSB 8 bits, passed in attr->config
  * any other bit is reserved
@@ -141,14 +151,18 @@ enum rapl_unit_quirk {
 
 struct rapl_model {
 	struct perf_msr *rapl_pkg_msrs;
+	struct perf_msr *rapl_core_msrs;
 	unsigned long	pkg_events;
+	unsigned long	core_events;
 	unsigned int	msr_power_unit;
 	enum rapl_unit_quirk	unit_quirk;
 };
 
  /* 1/2^hw_unit Joule */
 static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
+static int rapl_core_hw_unit __read_mostly;
 static struct rapl_pmus *rapl_pmus_pkg;
+static struct rapl_pmus *rapl_pmus_core;
 static u64 rapl_timer_ms;
 static struct rapl_model *rapl_model;
 
@@ -156,15 +170,23 @@ static struct rapl_model *rapl_model;
  * Helper function to get the correct topology id according to the
  * RAPL PMU scope.
  */
-static inline unsigned int get_rapl_pmu_idx(int cpu)
+static inline unsigned int get_rapl_pmu_idx(int cpu, int scope)
 {
 	/*
 	 * Returns unsigned int, which converts the '-1' return value
 	 * (for non-existent mappings in topology map) to UINT_MAX, so
 	 * the error check in the caller is simplified.
 	 */
-	return rapl_pkg_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
-					     topology_logical_die_id(cpu);
+	switch (scope) {
+	case PERF_PMU_SCOPE_PKG:
+		return topology_logical_package_id(cpu);
+	case PERF_PMU_SCOPE_DIE:
+		return topology_logical_die_id(cpu);
+	case PERF_PMU_SCOPE_CORE:
+		return topology_logical_core_id(cpu);
+	default:
+		return -EINVAL;
+	}
 }
 
 static inline u64 rapl_read_counter(struct perf_event *event)
@@ -174,19 +196,20 @@ static inline u64 rapl_read_counter(struct perf_event *event)
 	return raw;
 }
 
-static inline u64 rapl_scale(u64 v, int cfg)
+static inline u64 rapl_scale(u64 v, struct perf_event *event)
 {
-	if (cfg > NR_RAPL_PKG_DOMAINS) {
-		pr_warn("Invalid domain %d, failed to scale data\n", cfg);
-		return v;
-	}
+	int hw_unit = rapl_pkg_hw_unit[event->hw.config - 1];
+
+	if (event->pmu->scope == PERF_PMU_SCOPE_CORE)
+		hw_unit = rapl_core_hw_unit;
+
 	/*
 	 * scale delta to smallest unit (1/2^32)
 	 * users must then scale back: count * 1/(1e9*2^32) to get Joules
 	 * or use ldexp(count, -32).
 	 * Watts = Joules/Time delta
 	 */
-	return v << (32 - rapl_pkg_hw_unit[cfg - 1]);
+	return v << (32 - hw_unit);
 }
 
 static u64 rapl_event_update(struct perf_event *event)
@@ -213,7 +236,7 @@ static u64 rapl_event_update(struct perf_event *event)
 	delta = (new_raw_count << shift) - (prev_raw_count << shift);
 	delta >>= shift;
 
-	sdelta = rapl_scale(delta, event->hw.config);
+	sdelta = rapl_scale(delta, event);
 
 	local64_add(sdelta, &event->count);
 
@@ -342,13 +365,14 @@ static void rapl_pmu_event_del(struct perf_event *event, int flags)
 static int rapl_pmu_event_init(struct perf_event *event)
 {
 	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
-	int bit, ret = 0;
+	int bit, rapl_pmus_scope, ret = 0;
 	struct rapl_pmu *rapl_pmu;
 	unsigned int rapl_pmu_idx;
+	struct rapl_pmus *rapl_pmus;
 
-	/* only look at RAPL events */
-	if (event->attr.type != rapl_pmus_pkg->pmu.type)
-		return -ENOENT;
+	/* unsupported modes and filters */
+	if (event->attr.sample_period) /* no sampling */
+		return -EINVAL;
 
 	/* check only supported bits are set */
 	if (event->attr.config & ~RAPL_EVENT_MASK)
@@ -357,31 +381,49 @@ static int rapl_pmu_event_init(struct perf_event *event)
 	if (event->cpu < 0)
 		return -EINVAL;
 
-	if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
+	rapl_pmus = container_of(event->pmu, struct rapl_pmus, pmu);
+	if (!rapl_pmus)
 		return -EINVAL;
-
-	cfg = array_index_nospec((long)cfg, NR_RAPL_PKG_DOMAINS + 1);
-	bit = cfg - 1;
-
-	/* check event supported */
-	if (!(rapl_pmus_pkg->cntr_mask & (1 << bit)))
+	rapl_pmus_scope = rapl_pmus->pmu.scope;
+
+	if (rapl_pmus_scope == PERF_PMU_SCOPE_PKG || rapl_pmus_scope == PERF_PMU_SCOPE_DIE) {
+		/* only look at RAPL package events */
+		if (event->attr.type != rapl_pmus_pkg->pmu.type)
+			return -ENOENT;
+
+		cfg = array_index_nospec((long)cfg, NR_RAPL_PKG_DOMAINS + 1);
+		if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
+			return -EINVAL;
+
+		bit = cfg - 1;
+		event->hw.event_base = rapl_model->rapl_pkg_msrs[bit].msr;
+	} else if (rapl_pmus_scope == PERF_PMU_SCOPE_CORE) {
+		/* only look at RAPL core events */
+		if (event->attr.type != rapl_pmus_core->pmu.type)
+			return -ENOENT;
+
+		cfg = array_index_nospec((long)cfg, NR_RAPL_CORE_DOMAINS + 1);
+		if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
+			return -EINVAL;
+
+		bit = cfg - 1;
+		event->hw.event_base = rapl_model->rapl_core_msrs[bit].msr;
+	} else
 		return -EINVAL;
 
-	/* unsupported modes and filters */
-	if (event->attr.sample_period) /* no sampling */
+	/* check event supported */
+	if (!(rapl_pmus->cntr_mask & (1 << bit)))
 		return -EINVAL;
 
-	rapl_pmu_idx = get_rapl_pmu_idx(event->cpu);
-	if (rapl_pmu_idx >= rapl_pmus_pkg->nr_rapl_pmu)
+	rapl_pmu_idx = get_rapl_pmu_idx(event->cpu, rapl_pmus_scope);
+	if (rapl_pmu_idx >= rapl_pmus->nr_rapl_pmu)
 		return -EINVAL;
-
 	/* must be done before validate_group */
-	rapl_pmu = rapl_pmus_pkg->rapl_pmu[rapl_pmu_idx];
+	rapl_pmu = rapl_pmus->rapl_pmu[rapl_pmu_idx];
 	if (!rapl_pmu)
 		return -EINVAL;
 
 	event->pmu_private = rapl_pmu;
-	event->hw.event_base = rapl_model->rapl_pkg_msrs[bit].msr;
 	event->hw.config = cfg;
 	event->hw.idx = bit;
 
@@ -398,12 +440,14 @@ RAPL_EVENT_ATTR_STR(energy-pkg  ,   rapl_pkg, "event=0x02");
 RAPL_EVENT_ATTR_STR(energy-ram  ,   rapl_ram, "event=0x03");
 RAPL_EVENT_ATTR_STR(energy-gpu  ,   rapl_gpu, "event=0x04");
 RAPL_EVENT_ATTR_STR(energy-psys,   rapl_psys, "event=0x05");
+RAPL_EVENT_ATTR_STR(energy-core,   rapl_core, "event=0x01");
 
 RAPL_EVENT_ATTR_STR(energy-cores.unit, rapl_cores_unit, "Joules");
 RAPL_EVENT_ATTR_STR(energy-pkg.unit  ,   rapl_pkg_unit, "Joules");
 RAPL_EVENT_ATTR_STR(energy-ram.unit  ,   rapl_ram_unit, "Joules");
 RAPL_EVENT_ATTR_STR(energy-gpu.unit  ,   rapl_gpu_unit, "Joules");
 RAPL_EVENT_ATTR_STR(energy-psys.unit,   rapl_psys_unit, "Joules");
+RAPL_EVENT_ATTR_STR(energy-core.unit,   rapl_core_unit, "Joules");
 
 /*
  * we compute in 0.23 nJ increments regardless of MSR
@@ -413,6 +457,7 @@ RAPL_EVENT_ATTR_STR(energy-pkg.scale,     rapl_pkg_scale, "2.3283064365386962890
 RAPL_EVENT_ATTR_STR(energy-ram.scale,     rapl_ram_scale, "2.3283064365386962890625e-10");
 RAPL_EVENT_ATTR_STR(energy-gpu.scale,     rapl_gpu_scale, "2.3283064365386962890625e-10");
 RAPL_EVENT_ATTR_STR(energy-psys.scale,   rapl_psys_scale, "2.3283064365386962890625e-10");
+RAPL_EVENT_ATTR_STR(energy-core.scale,   rapl_core_scale, "2.3283064365386962890625e-10");
 
 /*
  * There are no default events, but we need to create
@@ -445,6 +490,12 @@ static const struct attribute_group *rapl_attr_groups[] = {
 	NULL,
 };
 
+static const struct attribute_group *rapl_core_attr_groups[] = {
+	&rapl_pmu_format_group,
+	&rapl_pmu_events_group,
+	NULL,
+};
+
 static struct attribute *rapl_events_cores[] = {
 	EVENT_PTR(rapl_cores),
 	EVENT_PTR(rapl_cores_unit),
@@ -505,6 +556,18 @@ static struct attribute_group rapl_events_psys_group = {
 	.attrs = rapl_events_psys,
 };
 
+static struct attribute *rapl_events_core[] = {
+	EVENT_PTR(rapl_core),
+	EVENT_PTR(rapl_core_unit),
+	EVENT_PTR(rapl_core_scale),
+	NULL,
+};
+
+static struct attribute_group rapl_events_core_group = {
+	.name  = "events",
+	.attrs = rapl_events_core,
+};
+
 static bool test_msr(int idx, void *data)
 {
 	return test_bit(idx, (unsigned long *) data);
@@ -542,6 +605,11 @@ static struct perf_msr amd_rapl_pkg_msrs[] = {
 	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
 };
 
+static struct perf_msr amd_rapl_core_msrs[] = {
+	[PERF_RAPL_CORE] = { MSR_AMD_CORE_ENERGY_STATUS, &rapl_events_core_group,
+				 test_msr, false, RAPL_MSR_MASK },
+};
+
 static int rapl_check_hw_unit(void)
 {
 	u64 msr_rapl_power_unit_bits;
@@ -553,6 +621,8 @@ static int rapl_check_hw_unit(void)
 	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++)
 		rapl_pkg_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
 
+	rapl_core_hw_unit = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
+
 	switch (rapl_model->unit_quirk) {
 	/*
 	 * DRAM domain on HSW server and KNL has fixed energy unit which can be
@@ -571,7 +641,6 @@ static int rapl_check_hw_unit(void)
 		break;
 	}
 
-
 	/*
 	 * Calculate the timer rate:
 	 * Use reference of 200W for scaling the timeout to avoid counter
@@ -590,9 +659,13 @@ static int rapl_check_hw_unit(void)
 static void __init rapl_advertise(void)
 {
 	int i;
+	int num_counters = hweight32(rapl_pmus_pkg->cntr_mask);
+
+	if (rapl_pmus_core)
+		num_counters += hweight32(rapl_pmus_core->cntr_mask);
 
 	pr_info("API unit is 2^-32 Joules, %d fixed counters, %llu ms ovfl timer\n",
-		hweight32(rapl_pmus_pkg->cntr_mask), rapl_timer_ms);
+		num_counters, rapl_timer_ms);
 
 	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++) {
 		if (rapl_pmus_pkg->cntr_mask & (1 << i)) {
@@ -600,6 +673,10 @@ static void __init rapl_advertise(void)
 				rapl_pkg_domain_names[i], rapl_pkg_hw_unit[i]);
 		}
 	}
+
+	if (rapl_pmus_core && (rapl_pmus_core->cntr_mask & (1 << PERF_RAPL_CORE)))
+		pr_info("hw unit of domain %s 2^-%d Joules\n",
+			rapl_core_domain_name, rapl_core_hw_unit);
 }
 
 static void cleanup_rapl_pmus(struct rapl_pmus *rapl_pmus)
@@ -620,6 +697,11 @@ static const struct attribute_group *rapl_attr_update[] = {
 	NULL,
 };
 
+static const struct attribute_group *rapl_core_attr_update[] = {
+	&rapl_events_core_group,
+	NULL,
+};
+
 static int __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
 {
 	struct rapl_pmu *rapl_pmu;
@@ -646,13 +728,22 @@ free:
 	return -ENOMEM;
 }
 
-static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_scope)
+static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_scope,
+				 const struct attribute_group **rapl_attr_groups,
+				 const struct attribute_group **rapl_attr_update)
 {
 	int nr_rapl_pmu = topology_max_packages();
 	struct rapl_pmus *rapl_pmus;
 
+	/*
+	 * rapl_pmu_scope must be either PKG, DIE or CORE
+	 */
 	if (rapl_pmu_scope == PERF_PMU_SCOPE_DIE)
 		nr_rapl_pmu	*= topology_max_dies_per_package();
+	else if (rapl_pmu_scope == PERF_PMU_SCOPE_CORE)
+		nr_rapl_pmu	*= topology_num_cores_per_package();
+	else if (rapl_pmu_scope != PERF_PMU_SCOPE_PKG)
+		return -EINVAL;
 
 	rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
@@ -741,8 +832,10 @@ static struct rapl_model model_spr = {
 
 static struct rapl_model model_amd_hygon = {
 	.pkg_events	= BIT(PERF_RAPL_PKG),
+	.core_events	= BIT(PERF_RAPL_CORE),
 	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
 	.rapl_pkg_msrs	= amd_rapl_pkg_msrs,
+	.rapl_core_msrs	= amd_rapl_core_msrs,
 };
 
 static const struct x86_cpu_id rapl_model_match[] __initconst = {
@@ -814,7 +907,8 @@ static int __init rapl_pmu_init(void)
 	if (ret)
 		return ret;
 
-	ret = init_rapl_pmus(&rapl_pmus_pkg, rapl_pkg_pmu_scope);
+	ret = init_rapl_pmus(&rapl_pmus_pkg, rapl_pkg_pmu_scope, rapl_attr_groups,
+			     rapl_attr_update);
 	if (ret)
 		return ret;
 
@@ -826,6 +920,27 @@ static int __init rapl_pmu_init(void)
 	if (ret)
 		goto out;
 
+	if (rapl_model->core_events) {
+		ret = init_rapl_pmus(&rapl_pmus_core, PERF_PMU_SCOPE_CORE,
+				     rapl_core_attr_groups,
+				     rapl_core_attr_update);
+		if (ret) {
+			pr_warn("power-core PMU initialization failed (%d)\n", ret);
+			goto core_init_failed;
+		}
+
+		rapl_pmus_core->cntr_mask = perf_msr_probe(rapl_model->rapl_core_msrs,
+						     PERF_RAPL_CORE_EVENTS_MAX, false,
+						     (void *) &rapl_model->core_events);
+
+		ret = perf_pmu_register(&rapl_pmus_core->pmu, "power_core", -1);
+		if (ret) {
+			pr_warn("power-core PMU registration failed (%d)\n", ret);
+			cleanup_rapl_pmus(rapl_pmus_core);
+		}
+	}
+
+core_init_failed:
 	rapl_advertise();
 	return 0;
 
@@ -838,6 +953,10 @@ module_init(rapl_pmu_init);
 
 static void __exit intel_rapl_exit(void)
 {
+	if (rapl_pmus_core) {
+		perf_pmu_unregister(&rapl_pmus_core->pmu);
+		cleanup_rapl_pmus(rapl_pmus_core);
+	}
 	perf_pmu_unregister(&rapl_pmus_pkg->pmu);
 	cleanup_rapl_pmus(rapl_pmus_pkg);
 }

