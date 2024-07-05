Return-Path: <linux-tip-commits+bounces-1618-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9677928E92
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 23:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58C71B28465
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 21:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287C717B41C;
	Fri,  5 Jul 2024 21:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ke2aEtNk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iT1Vc76U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4556016D339;
	Fri,  5 Jul 2024 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213611; cv=none; b=i6oT++ag+75q8kEG7X+XJob3pv5njwMLBmc1g+XCFeHtEjsgauKDTGSm9fEHl24EQ56BfbJwf/2/uukcGtw/De0qHizD2AqwJrL3NvUAQNaPHp2XRZPF1zO5U5vKz2ln0V4gSBIHZhM3a23qEQ2UIvctB6C0t2DSPkrJbofw1KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213611; c=relaxed/simple;
	bh=Egegq8kuNkigrDyi7zoUrDWdaoWLP7MQff3lQG38coE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ior7YC0PfGdaJSqKlYrlHt2hlotExQJWR3XK0ORZ3OZzii768Nsh6D+nXvlO9JGCOrb7QXILTZ2T8C/zGkZkkKeMqGiu+l8WcXK/Wii/2yrE/krGrU3L3PI95aSZGsBEVSuyyFLqTWVe3VA53ILOMPCgsumpaXo+idQNwOD7F+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ke2aEtNk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iT1Vc76U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Jul 2024 21:06:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720213603;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFut+1C1hcByAFUrVWWg8eZzMxcMBpSAgmWSjGNuqgs=;
	b=Ke2aEtNkT0nVsUIhcjmxomH9kWmbDKvzxn/gZbs39xzgFLKgVBnRP9V1Zsoa8fcSqI0m+D
	L0CskVQBQCrQ8jGVOG7AikMtZcr2diGKCGwbXvsjQYKKk6lSJHrKJEU1Yow1M5deeuwPoF
	jLhhWvZf6OVKOS8w/TfwSaoEJ1Usk5SowJdM9GDLAXPxi25R342YHdmWlEGK1lDd06bjFs
	J7tdZH1gqKDaLsWrrScFZB92WLLh6UBH7IG/LG2YeKH6DfSkvcPiLOIRVDSCnludNIjP8p
	JtdrZGfmTxerzKkl41Z+Nlq0kmleBr/qXdaPEa1yZsZbNxpry+XAbC7GZHOIgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720213603;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFut+1C1hcByAFUrVWWg8eZzMxcMBpSAgmWSjGNuqgs=;
	b=iT1Vc76UeCx9IyZKlh1yBK28k3pM5kD7Jenv0ZiWsXAApw7qGUO1Mnb4scciL2PZiaWTJQ
	j1ZGzLogTtAzc1Ag==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Add Lunar Lake and Arrow Lake support
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andi Kleen <ak@linux.intel.com>, Ian Rogers <irogers@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240626143545.480761-4-kan.liang@linux.intel.com>
References: <20240626143545.480761-4-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172021360291.2215.1215940495153360547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a932aa0e868f92c5219d84b58c1131fc05ddcf79
Gitweb:        https://git.kernel.org/tip/a932aa0e868f92c5219d84b58c1131fc05ddcf79
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 26 Jun 2024 07:35:35 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Jul 2024 16:00:37 +02:00

perf/x86: Add Lunar Lake and Arrow Lake support

>From PMU's perspective, Lunar Lake and Arrow Lake are similar to the
previous generation Meteor Lake. Both are hybrid platforms, with e-core
and p-core.

The key differences include:
- The e-core supports 3 new fixed counters
- The p-core supports an updated PEBS Data Source format
- More GP counters (Updated event constraint table)
- New Architectural performance monitoring V6
  (New Perfmon MSRs aliasing, umask2, eq).
- New PEBS format V6 (Counters Snapshotting group)
- New RDPMC metrics clear mode

The legacy features, the 3 new fixed counters and updated event
constraint table are enabled in this patch.

The new PEBS data source format, the architectural performance
monitoring V6, the PEBS format V6, and the new RDPMC metrics clear mode
are supported in the following patches.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Link: https://lkml.kernel.org/r/20240626143545.480761-4-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c      | 117 +++++++++++++++++++++++++++++-
 arch/x86/events/intel/ds.c        |  24 ++++++-
 arch/x86/events/perf_event.h      |   2 +-
 arch/x86/include/asm/perf_event.h |   4 +-
 4 files changed, 147 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 1782b44..224430e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -220,6 +220,17 @@ static struct event_constraint intel_grt_event_constraints[] __read_mostly = {
 	EVENT_CONSTRAINT_END
 };
 
+static struct event_constraint intel_skt_event_constraints[] __read_mostly = {
+	FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* INST_RETIRED.ANY */
+	FIXED_EVENT_CONSTRAINT(0x003c, 1), /* CPU_CLK_UNHALTED.CORE */
+	FIXED_EVENT_CONSTRAINT(0x0300, 2), /* pseudo CPU_CLK_UNHALTED.REF */
+	FIXED_EVENT_CONSTRAINT(0x013c, 2), /* CPU_CLK_UNHALTED.REF_TSC_P */
+	FIXED_EVENT_CONSTRAINT(0x0073, 4), /* TOPDOWN_BAD_SPECULATION.ALL */
+	FIXED_EVENT_CONSTRAINT(0x019c, 5), /* TOPDOWN_FE_BOUND.ALL */
+	FIXED_EVENT_CONSTRAINT(0x02c2, 6), /* TOPDOWN_RETIRING.ALL */
+	EVENT_CONSTRAINT_END
+};
+
 static struct event_constraint intel_skl_event_constraints[] = {
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
 	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
@@ -370,6 +381,55 @@ static struct extra_reg intel_rwc_extra_regs[] __read_mostly = {
 	EVENT_EXTRA_END
 };
 
+static struct event_constraint intel_lnc_event_constraints[] = {
+	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
+	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* INST_RETIRED.PREC_DIST */
+	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
+	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
+	FIXED_EVENT_CONSTRAINT(0x013c, 2),	/* CPU_CLK_UNHALTED.REF_TSC_P */
+	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_RETIRING, 0),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BAD_SPEC, 1),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_FE_BOUND, 2),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BE_BOUND, 3),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_HEAVY_OPS, 4),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BR_MISPREDICT, 5),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_FETCH_LAT, 6),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_MEM_BOUND, 7),
+
+	INTEL_UEVENT_CONSTRAINT(0x0148, 0x4),
+	INTEL_UEVENT_CONSTRAINT(0x0175, 0x4),
+
+	INTEL_EVENT_CONSTRAINT(0x2e, 0x3ff),
+	INTEL_EVENT_CONSTRAINT(0x3c, 0x3ff),
+	/*
+	 * Generally event codes < 0x90 are restricted to counters 0-3.
+	 * The 0x2E and 0x3C are exception, which has no restriction.
+	 */
+	INTEL_EVENT_CONSTRAINT_RANGE(0x01, 0x8f, 0xf),
+
+	INTEL_UEVENT_CONSTRAINT(0x01a3, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x02a3, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x08a3, 0x4),
+	INTEL_UEVENT_CONSTRAINT(0x0ca3, 0x4),
+	INTEL_UEVENT_CONSTRAINT(0x04a4, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x08a4, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x10a4, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x01b1, 0x8),
+	INTEL_UEVENT_CONSTRAINT(0x02cd, 0x3),
+	INTEL_EVENT_CONSTRAINT(0xce, 0x1),
+
+	INTEL_EVENT_CONSTRAINT_RANGE(0xd0, 0xdf, 0xf),
+	/*
+	 * Generally event codes >= 0x90 are likely to have no restrictions.
+	 * The exception are defined as above.
+	 */
+	INTEL_EVENT_CONSTRAINT_RANGE(0x90, 0xfe, 0x3ff),
+
+	EVENT_CONSTRAINT_END
+};
+
+
 EVENT_ATTR_STR(mem-loads,	mem_ld_nhm,	"event=0x0b,umask=0x10,ldlat=3");
 EVENT_ATTR_STR(mem-loads,	mem_ld_snb,	"event=0xcd,umask=0x1,ldlat=3");
 EVENT_ATTR_STR(mem-stores,	mem_st_snb,	"event=0xcd,umask=0x2");
@@ -5790,6 +5850,23 @@ static struct attribute *adl_hybrid_events_attrs[] = {
 	NULL,
 };
 
+EVENT_ATTR_STR_HYBRID(topdown-retiring,      td_retiring_lnl,  "event=0xc2,umask=0x02;event=0x00,umask=0x80", hybrid_big_small);
+EVENT_ATTR_STR_HYBRID(topdown-fe-bound,      td_fe_bound_lnl,  "event=0x9c,umask=0x01;event=0x00,umask=0x82", hybrid_big_small);
+EVENT_ATTR_STR_HYBRID(topdown-be-bound,      td_be_bound_lnl,  "event=0xa4,umask=0x02;event=0x00,umask=0x83", hybrid_big_small);
+
+static struct attribute *lnl_hybrid_events_attrs[] = {
+	EVENT_PTR(slots_adl),
+	EVENT_PTR(td_retiring_lnl),
+	EVENT_PTR(td_bad_spec_adl),
+	EVENT_PTR(td_fe_bound_lnl),
+	EVENT_PTR(td_be_bound_lnl),
+	EVENT_PTR(td_heavy_ops_adl),
+	EVENT_PTR(td_br_mis_adl),
+	EVENT_PTR(td_fetch_lat_adl),
+	EVENT_PTR(td_mem_bound_adl),
+	NULL
+};
+
 /* Must be in IDX order */
 EVENT_ATTR_STR_HYBRID(mem-loads,     mem_ld_adl,     "event=0xd0,umask=0x5,ldlat=3;event=0xcd,umask=0x1,ldlat=3", hybrid_big_small);
 EVENT_ATTR_STR_HYBRID(mem-stores,    mem_st_adl,     "event=0xd0,umask=0x6;event=0xcd,umask=0x2",                 hybrid_big_small);
@@ -6139,6 +6216,21 @@ static __always_inline void intel_pmu_init_grt(struct pmu *pmu)
 	intel_pmu_ref_cycles_ext();
 }
 
+static __always_inline void intel_pmu_init_lnc(struct pmu *pmu)
+{
+	intel_pmu_init_glc(pmu);
+	hybrid(pmu, event_constraints) = intel_lnc_event_constraints;
+	hybrid(pmu, pebs_constraints) = intel_lnc_pebs_event_constraints;
+	hybrid(pmu, extra_regs) = intel_rwc_extra_regs;
+}
+
+static __always_inline void intel_pmu_init_skt(struct pmu *pmu)
+{
+	intel_pmu_init_grt(pmu);
+	hybrid(pmu, event_constraints) = intel_skt_event_constraints;
+	hybrid(pmu, extra_regs) = intel_cmt_extra_regs;
+}
+
 __init int intel_pmu_init(void)
 {
 	struct attribute **extra_skl_attr = &empty_attrs;
@@ -6864,6 +6956,31 @@ __init int intel_pmu_init(void)
 		name = "meteorlake_hybrid";
 		break;
 
+	case INTEL_LUNARLAKE_M:
+	case INTEL_ARROWLAKE:
+		intel_pmu_init_hybrid(hybrid_big_small);
+
+		x86_pmu.get_event_constraints = mtl_get_event_constraints;
+		x86_pmu.hw_config = adl_hw_config;
+
+		td_attr = lnl_hybrid_events_attrs;
+		mem_attr = mtl_hybrid_mem_attrs;
+		tsx_attr = adl_hybrid_tsx_attrs;
+		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
+			mtl_hybrid_extra_attr_rtm : mtl_hybrid_extra_attr;
+
+		/* Initialize big core specific PerfMon capabilities.*/
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
+		intel_pmu_init_lnc(&pmu->pmu);
+
+		/* Initialize Atom core specific PerfMon capabilities.*/
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
+		intel_pmu_init_skt(&pmu->pmu);
+
+		pr_cont("Lunarlake Hybrid events, ");
+		name = "lunarlake_hybrid";
+		break;
+
 	default:
 		switch (x86_pmu.version) {
 		case 1:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 6f834a7..79e23de 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1086,6 +1086,30 @@ struct event_constraint intel_glc_pebs_event_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
+struct event_constraint intel_lnc_pebs_event_constraints[] = {
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
+
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x12d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_STORES */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x21d0, 0xf),	/* MEM_INST_RETIRED.LOCK_LOADS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x41d0, 0xf),	/* MEM_INST_RETIRED.SPLIT_LOADS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x42d0, 0xf),	/* MEM_INST_RETIRED.SPLIT_STORES */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x81d0, 0xf),	/* MEM_INST_RETIRED.ALL_LOADS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x82d0, 0xf),	/* MEM_INST_RETIRED.ALL_STORES */
+
+	INTEL_FLAGS_EVENT_CONSTRAINT_DATALA_LD_RANGE(0xd1, 0xd4, 0xf),
+
+	INTEL_FLAGS_EVENT_CONSTRAINT(0xd0, 0xf),
+
+	/*
+	 * Everything else is handled by PMU_FL_PEBS_ALL, because we
+	 * need the full constraints from the main table.
+	 */
+
+	EVENT_CONSTRAINT_END
+};
+
 struct event_constraint *intel_pebs_constraints(struct perf_event *event)
 {
 	struct event_constraint *pebs_constraints = hybrid(event->pmu, pebs_constraints);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 745c174..b7195ee 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1582,6 +1582,8 @@ extern struct event_constraint intel_icl_pebs_event_constraints[];
 
 extern struct event_constraint intel_glc_pebs_event_constraints[];
 
+extern struct event_constraint intel_lnc_pebs_event_constraints[];
+
 struct event_constraint *intel_pebs_constraints(struct perf_event *event);
 
 void intel_pmu_pebs_add(struct perf_event *event);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 7f1e172..400c909 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -307,6 +307,10 @@ struct x86_pmu_capability {
 #define INTEL_PMC_IDX_FIXED_SLOTS	(INTEL_PMC_IDX_FIXED + 3)
 #define INTEL_PMC_MSK_FIXED_SLOTS	(1ULL << INTEL_PMC_IDX_FIXED_SLOTS)
 
+/* TOPDOWN_BAD_SPECULATION.ALL: fixed counter 4 (Atom only) */
+/* TOPDOWN_FE_BOUND.ALL: fixed counter 5 (Atom only) */
+/* TOPDOWN_RETIRING.ALL: fixed counter 6 (Atom only) */
+
 static inline bool use_fixed_pseudo_encoding(u64 code)
 {
 	return !(code & 0xff);

