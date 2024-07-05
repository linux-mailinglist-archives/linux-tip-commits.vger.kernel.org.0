Return-Path: <linux-tip-commits+bounces-1607-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC48928E7F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 23:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DB13B27C1E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 21:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B4F176AA9;
	Fri,  5 Jul 2024 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P1q1jf+/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="alTrQBa/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A816814A60C;
	Fri,  5 Jul 2024 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213607; cv=none; b=NJHXfDyc2kOW8DN9RqZPNQG3PRTy9FSulkKm55AXS3Shn5ZORC+RIWG+LoznK0qJzaAUNpAJDNGuqJmViF/03qc6THfKc2lUPUorrrJhSFlaOzxLoiQE54RIV3p3Pb5/DYELuXDJduKoljLhUsdghw+N4lIgV29fLzFGEMcj64I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213607; c=relaxed/simple;
	bh=Dj05Iw3QjQYIrfrHMRjWqcMvtokxTE/kAeKF3V1EByM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=i5zU5wR310H16rjk/ZebdvyCO8QDzGScBpF1rjbS50hEDu69QM4K257TClGqNNPyFP/vMailpEywUN6WhQboW8E5fxB1xjCU5tLpknmAaz8aeAVHU3qg7gXUGHaeArlTs8eGs0Vj1sueO9RBPIgyD18U1Ku3YL51duwvINI8aLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P1q1jf+/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=alTrQBa/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Jul 2024 21:06:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720213602;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TStvBaq+rT57zhKdhWTbGTZMaOd2OeIt6ldotGaNDho=;
	b=P1q1jf+/fhAyedXjBsGq52Yn5dIZXenn9FVDuXso3Rb5Iz5/Y/1ewPgfXu4BWRPDywLteR
	DMA4lIjDXh8rXLg5DE0bjMDTGwS4GuC5kGocGgXTZhj+RXptJ5kRCHHEDMhlv/OfZ5HbRh
	seCuEnJK5RC7ROl8BZHx9M/Q4uE91yerb8C5QqjrKI0xk5U5+ojd+Y1/WcVox2lKQv3XGC
	avJwY1xwGC8/Xbg9b4RGJx2Htr3y6Wehgr775M5NXxChQ72wOrzsp+kD8sxfFBYRmxxoTi
	coPT7BcsSZDhTDGbkTbDVbzbw8tTl+uhn8++zLi36yBuBpz0d+VZNrc5Cd7F2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720213602;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TStvBaq+rT57zhKdhWTbGTZMaOd2OeIt6ldotGaNDho=;
	b=alTrQBa/MBoYoQcGUSLerK78X5xm1b6JdEMPjG3SRls+ElRHQiLesA8CrEcTT+t1p6GK5V
	s0coqDBtVYsYEJAQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel: Support new data source for Lunar Lake
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andi Kleen <ak@linux.intel.com>, Ian Rogers <irogers@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240626143545.480761-6-kan.liang@linux.intel.com>
References: <20240626143545.480761-6-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172021360215.2215.4291705518188575427.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     608f6976c309793ceea37292c54b057dab091944
Gitweb:        https://git.kernel.org/tip/608f6976c309793ceea37292c54b057dab091944
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 26 Jun 2024 07:35:37 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Jul 2024 16:00:38 +02:00

perf/x86/intel: Support new data source for Lunar Lake

A new PEBS data source format is introduced for the p-core of Lunar
Lake. The data source field is extended to 8 bits with new encodings.

A new layout is introduced into the union intel_x86_pebs_dse.
Introduce the lnl_latency_data() to parse the new format.
Enlarge the pebs_data_source[] accordingly to include new encodings.

Only the mem load and the mem store events can generate the data source.
Introduce INTEL_HYBRID_LDLAT_CONSTRAINT and
INTEL_HYBRID_STLAT_CONSTRAINT to mark them.

Add two new bits for the new cache-related data src, L2_MHB and MSC.
The L2_MHB is short for L2 Miss Handling Buffer, which is similar to
LFB (Line Fill Buffer), but to track the L2 Cache misses.
The MSC stands for the memory-side cache.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Link: https://lkml.kernel.org/r/20240626143545.480761-6-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c    |  2 +-
 arch/x86/events/intel/ds.c      | 94 +++++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h    | 16 ++++-
 include/uapi/linux/perf_event.h |  6 +-
 4 files changed, 113 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 35f2d52..6a6f1f4 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6960,6 +6960,7 @@ __init int intel_pmu_init(void)
 	case INTEL_ARROWLAKE:
 		intel_pmu_init_hybrid(hybrid_big_small);
 
+		x86_pmu.pebs_latency_data = lnl_latency_data;
 		x86_pmu.get_event_constraints = mtl_get_event_constraints;
 		x86_pmu.hw_config = adl_hw_config;
 
@@ -6977,6 +6978,7 @@ __init int intel_pmu_init(void)
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
 		intel_pmu_init_skt(&pmu->pmu);
 
+		intel_pmu_pebs_data_source_lnl();
 		pr_cont("Lunarlake Hybrid events, ");
 		name = "lunarlake_hybrid";
 		break;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 3581c27..b9cc520 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -63,6 +63,15 @@ union intel_x86_pebs_dse {
 		unsigned int mtl_fwd_blk:1;
 		unsigned int ld_reserved4:24;
 	};
+	struct {
+		unsigned int lnc_dse:8;
+		unsigned int ld_reserved5:2;
+		unsigned int lnc_stlb_miss:1;
+		unsigned int lnc_locked:1;
+		unsigned int lnc_data_blk:1;
+		unsigned int lnc_addr_blk:1;
+		unsigned int ld_reserved6:18;
+	};
 };
 
 
@@ -77,7 +86,7 @@ union intel_x86_pebs_dse {
 #define SNOOP_NONE_MISS (P(SNOOP, NONE) | P(SNOOP, MISS))
 
 /* Version for Sandy Bridge and later */
-static u64 pebs_data_source[] = {
+static u64 pebs_data_source[PERF_PEBS_DATA_SOURCE_MAX] = {
 	P(OP, LOAD) | P(LVL, MISS) | LEVEL(L3) | P(SNOOP, NA),/* 0x00:ukn L3 */
 	OP_LH | P(LVL, L1)  | LEVEL(L1) | P(SNOOP, NONE),  /* 0x01: L1 local */
 	OP_LH | P(LVL, LFB) | LEVEL(LFB) | P(SNOOP, NONE), /* 0x02: LFB hit */
@@ -173,6 +182,40 @@ void __init intel_pmu_pebs_data_source_cmt(void)
 	__intel_pmu_pebs_data_source_cmt(pebs_data_source);
 }
 
+/* Version for Lion Cove and later */
+static u64 lnc_pebs_data_source[PERF_PEBS_DATA_SOURCE_MAX] = {
+	P(OP, LOAD) | P(LVL, MISS) | LEVEL(L3) | P(SNOOP, NA),	/* 0x00: ukn L3 */
+	OP_LH | P(LVL, L1)  | LEVEL(L1) | P(SNOOP, NONE),	/* 0x01: L1 hit */
+	OP_LH | P(LVL, L1)  | LEVEL(L1) | P(SNOOP, NONE),	/* 0x02: L1 hit */
+	OP_LH | P(LVL, LFB) | LEVEL(LFB) | P(SNOOP, NONE),	/* 0x03: LFB/L1 Miss Handling Buffer hit */
+	0,							/* 0x04: Reserved */
+	OP_LH | P(LVL, L2)  | LEVEL(L2) | P(SNOOP, NONE),	/* 0x05: L2 Hit */
+	OP_LH | LEVEL(L2_MHB) | P(SNOOP, NONE),			/* 0x06: L2 Miss Handling Buffer Hit */
+	0,							/* 0x07: Reserved */
+	OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, NONE),	/* 0x08: L3 Hit */
+	0,							/* 0x09: Reserved */
+	0,							/* 0x0a: Reserved */
+	0,							/* 0x0b: Reserved */
+	OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOPX, FWD),	/* 0x0c: L3 Hit Snoop Fwd */
+	OP_LH | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, HITM),	/* 0x0d: L3 Hit Snoop HitM */
+	0,							/* 0x0e: Reserved */
+	P(OP, LOAD) | P(LVL, MISS) | P(LVL, L3)  | LEVEL(L3) | P(SNOOP, HITM),	/* 0x0f: L3 Miss Snoop HitM */
+	OP_LH | LEVEL(MSC) | P(SNOOP, NONE),			/* 0x10: Memory-side Cache Hit */
+	OP_LH | P(LVL, LOC_RAM)  | LEVEL(RAM) | P(SNOOP, NONE), /* 0x11: Local Memory Hit */
+};
+
+void __init intel_pmu_pebs_data_source_lnl(void)
+{
+	u64 *data_source;
+
+	data_source = x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX].pebs_data_source;
+	memcpy(data_source, lnc_pebs_data_source, sizeof(lnc_pebs_data_source));
+
+	data_source = x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX].pebs_data_source;
+	memcpy(data_source, pebs_data_source, sizeof(pebs_data_source));
+	__intel_pmu_pebs_data_source_cmt(data_source);
+}
+
 static u64 precise_store_data(u64 status)
 {
 	union intel_x86_pebs_dse dse;
@@ -264,7 +307,7 @@ static u64 __grt_latency_data(struct perf_event *event, u64 status,
 
 	WARN_ON_ONCE(hybrid_pmu(event->pmu)->pmu_type == hybrid_big);
 
-	dse &= PERF_PEBS_DATA_SOURCE_MASK;
+	dse &= PERF_PEBS_DATA_SOURCE_GRT_MASK;
 	val = hybrid_var(event->pmu, pebs_data_source)[dse];
 
 	pebs_set_tlb_lock(&val, tlb, lock);
@@ -300,6 +343,51 @@ u64 cmt_latency_data(struct perf_event *event, u64 status)
 				  dse.mtl_fwd_blk);
 }
 
+static u64 lnc_latency_data(struct perf_event *event, u64 status)
+{
+	union intel_x86_pebs_dse dse;
+	union perf_mem_data_src src;
+	u64 val;
+
+	dse.val = status;
+
+	/* LNC core latency data */
+	val = hybrid_var(event->pmu, pebs_data_source)[status & PERF_PEBS_DATA_SOURCE_MASK];
+	if (!val)
+		val = P(OP, LOAD) | LEVEL(NA) | P(SNOOP, NA);
+
+	if (dse.lnc_stlb_miss)
+		val |= P(TLB, MISS) | P(TLB, L2);
+	else
+		val |= P(TLB, HIT) | P(TLB, L1) | P(TLB, L2);
+
+	if (dse.lnc_locked)
+		val |= P(LOCK, LOCKED);
+
+	if (dse.lnc_data_blk)
+		val |= P(BLK, DATA);
+	if (dse.lnc_addr_blk)
+		val |= P(BLK, ADDR);
+	if (!dse.lnc_data_blk && !dse.lnc_addr_blk)
+		val |= P(BLK, NA);
+
+	src.val = val;
+	if (event->hw.flags & PERF_X86_EVENT_PEBS_ST_HSW)
+		src.mem_op = P(OP, STORE);
+
+	return src.val;
+}
+
+u64 lnl_latency_data(struct perf_event *event, u64 status)
+{
+	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
+
+	if (pmu->pmu_type == hybrid_small)
+		return cmt_latency_data(event, status);
+
+	return lnc_latency_data(event, status);
+}
+
 static u64 load_latency_data(struct perf_event *event, u64 status)
 {
 	union intel_x86_pebs_dse dse;
@@ -1090,6 +1178,8 @@ struct event_constraint intel_lnc_pebs_event_constraints[] = {
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
 
+	INTEL_HYBRID_LDLAT_CONSTRAINT(0x1cd, 0x3ff),
+	INTEL_HYBRID_STLAT_CONSTRAINT(0x2cd, 0x3),
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x12d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_STORES */
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x21d0, 0xf),	/* MEM_INST_RETIRED.LOCK_LOADS */
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fc25619..493bc9f 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -476,6 +476,14 @@ struct cpu_hw_events {
 	__EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS, \
 			  HWEIGHT(n), 0, PERF_X86_EVENT_PEBS_LAT_HYBRID)
 
+#define INTEL_HYBRID_LDLAT_CONSTRAINT(c, n)	\
+	__EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS, \
+			  HWEIGHT(n), 0, PERF_X86_EVENT_PEBS_LAT_HYBRID|PERF_X86_EVENT_PEBS_LD_HSW)
+
+#define INTEL_HYBRID_STLAT_CONSTRAINT(c, n)	\
+	__EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS, \
+			  HWEIGHT(n), 0, PERF_X86_EVENT_PEBS_LAT_HYBRID|PERF_X86_EVENT_PEBS_ST_HSW)
+
 /* Event constraint, but match on all event flags too. */
 #define INTEL_FLAGS_EVENT_CONSTRAINT(c, n) \
 	EVENT_CONSTRAINT(c, n, ARCH_PERFMON_EVENTSEL_EVENT|X86_ALL_EVENT_FLAGS)
@@ -655,8 +663,10 @@ enum {
 	x86_lbr_exclusive_max,
 };
 
-#define PERF_PEBS_DATA_SOURCE_MAX	0x10
+#define PERF_PEBS_DATA_SOURCE_MAX	0x100
 #define PERF_PEBS_DATA_SOURCE_MASK	(PERF_PEBS_DATA_SOURCE_MAX - 1)
+#define PERF_PEBS_DATA_SOURCE_GRT_MAX	0x10
+#define PERF_PEBS_DATA_SOURCE_GRT_MASK	(PERF_PEBS_DATA_SOURCE_GRT_MAX - 1)
 
 enum hybrid_cpu_type {
 	HYBRID_INTEL_NONE,
@@ -1552,6 +1562,8 @@ u64 grt_latency_data(struct perf_event *event, u64 status);
 
 u64 cmt_latency_data(struct perf_event *event, u64 status);
 
+u64 lnl_latency_data(struct perf_event *event, u64 status);
+
 extern struct event_constraint intel_core2_pebs_event_constraints[];
 
 extern struct event_constraint intel_atom_pebs_event_constraints[];
@@ -1673,6 +1685,8 @@ void intel_pmu_pebs_data_source_mtl(void);
 
 void intel_pmu_pebs_data_source_cmt(void);
 
+void intel_pmu_pebs_data_source_lnl(void);
+
 int intel_pmu_setup_lbr_filter(struct perf_event *event);
 
 void intel_pt_interrupt(void);
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 3a64499..4842c36 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1349,12 +1349,14 @@ union perf_mem_data_src {
 #define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
 #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
 #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
-/* 5-0x7 available */
+#define PERF_MEM_LVLNUM_L2_MHB	0x05 /* L2 Miss Handling Buffer */
+#define PERF_MEM_LVLNUM_MSC	0x06 /* Memory-side Cache */
+/* 0x7 available */
 #define PERF_MEM_LVLNUM_UNC	0x08 /* Uncached */
 #define PERF_MEM_LVLNUM_CXL	0x09 /* CXL */
 #define PERF_MEM_LVLNUM_IO	0x0a /* I/O */
 #define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
-#define PERF_MEM_LVLNUM_LFB	0x0c /* LFB */
+#define PERF_MEM_LVLNUM_LFB	0x0c /* LFB / L1 Miss Handling Buffer */
 #define PERF_MEM_LVLNUM_RAM	0x0d /* RAM */
 #define PERF_MEM_LVLNUM_PMEM	0x0e /* PMEM */
 #define PERF_MEM_LVLNUM_NA	0x0f /* N/A */

