Return-Path: <linux-tip-commits+bounces-2376-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 698E899461D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 13:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1EB41F278AC
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 11:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E225F1DE886;
	Tue,  8 Oct 2024 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jVSBtxyG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wfr2SPyl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75C91D8E1F;
	Tue,  8 Oct 2024 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385520; cv=none; b=kxAQr2Acbvj120ASKY/Goc6LIU0Sn048MZBjzgjPXyXvgRCkDRy4EtnwS/12uLTOIlVWV3KLIjvGWIi4WLE4vg03d0HHhu2q/mNwVr8KCctaG3NVLZJ0W7TX2mfnj6BDRv6L/vzCX0UFPAiZ+UqwyDFW7rSBANV5miSAxBacu4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385520; c=relaxed/simple;
	bh=sI8qFqvKVrzgNRznrDdb+gQimrhIXGz8WctjDjLqifI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OS0dXj0XmdgABBpuwNfLChvqLvGrdcXxAo6jh6GTTphZossGWcwF2j43AQa9EnLhIzl2LpEPaar3s45/z+kXgy3bxCcbti7d1v6dy2XqWuu8aXCEaHfJ4X+ZnIL1nzsq+O8353NooCNg8WXTHBGDlUc2cjGjJjF6A4yc5y3MSnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jVSBtxyG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wfr2SPyl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 11:05:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728385517;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZQA0FfVv0wLdTgPgY38IDst34AyH0Inq2vXLOJo5RY=;
	b=jVSBtxyGVgr6BOwADhoxPcZWH5WowSwPWRQ3ZCB8fAWpNTpRLL0qfARj+64T+GfZyTI2sX
	o6DIcM09V6noUwOGMlHVOOqmx/TVoVRLv+WMN+1awcZGzNMm/Eag8GlToRKatEzYfhtXZq
	7NHVhuDGDaiusHxrWj9z0t3tEDPEkber6rQLhYjlrBIMnCDGpQH2+AmvcOCz8NcEQNKjUR
	RdHBf9dVVeZnTfQI4gcgPZE3g78AxZ2QsAiaIg254OhcEygWaup9hkvika38d0OynI96l5
	rmvIYB5mnGmOndlK/Iaj/vYUTXjd2hU74VQnmYN9SAqo0UBOR5UyXo//EjFmsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728385517;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZQA0FfVv0wLdTgPgY38IDst34AyH0Inq2vXLOJo5RY=;
	b=wfr2SPylKHxwbYMn/K7yh/hExmbU4x6ZTcNRA29E79VSq+WmHWMdEQMPPVZKHkgRYqFbMm
	ZP3qmJbABqlFTrAA==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Add PMU support for ArrowLake-H
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820073853.1974746-5-dapeng1.mi@linux.intel.com>
References: <20240820073853.1974746-5-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172838551678.1442.5796905488395972283.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d3fe6f0a4372702e2cdabf19e03b815811671c7a
Gitweb:        https://git.kernel.org/tip/d3fe6f0a4372702e2cdabf19e03b815811671c7a
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Tue, 20 Aug 2024 07:38:53 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:43 +02:00

perf/x86/intel: Add PMU support for ArrowLake-H

ArrowLake-H contains 3 different uarchs, LionCove, Skymont and Crestmont.
It is different with previous hybrid processors which only contains two
kinds of uarchs.

This patch adds PMU support for ArrowLake-H processor, adds ARL-H
specific events which supports the 3 kinds of uarchs, such as
td_retiring_arl_h, and extends some existed format attributes like
offcore_rsp to make them be available to support ARL-H as well. Althrough
these format attributes like offcore_rsp have been extended to support
ARL-H, they can still support the regular hybrid platforms with 2 kinds
of uarchs since the helper hybrid_format_is_visible() would filter PMU
types and only show the format attribute for available PMUs.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Link: https://lkml.kernel.org/r/20240820073853.1974746-5-dapeng1.mi@linux.intel.com
---
 arch/x86/events/intel/core.c | 105 +++++++++++++++++++++++++++++++++-
 arch/x86/events/intel/ds.c   |  21 +++++++-
 arch/x86/events/perf_event.h |   4 +-
 3 files changed, 127 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 6b9884e..7ca4000 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4599,6 +4599,28 @@ static inline bool erratum_hsw11(struct perf_event *event)
 		X86_CONFIG(.event=0xc0, .umask=0x01);
 }
 
+static struct event_constraint *
+arl_h_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
+			  struct perf_event *event)
+{
+	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
+
+	if (pmu->pmu_type == hybrid_tiny)
+		return cmt_get_event_constraints(cpuc, idx, event);
+
+	return mtl_get_event_constraints(cpuc, idx, event);
+}
+
+static int arl_h_hw_config(struct perf_event *event)
+{
+	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
+
+	if (pmu->pmu_type == hybrid_tiny)
+		return intel_pmu_hw_config(event);
+
+	return adl_hw_config(event);
+}
+
 /*
  * The HSW11 requires a period larger than 100 which is the same as the BDM11.
  * A minimum period of 128 is enforced as well for the INST_RETIRED.ALL.
@@ -5974,6 +5996,37 @@ static struct attribute *lnl_hybrid_events_attrs[] = {
 	NULL
 };
 
+/* The event string must be in PMU IDX order. */
+EVENT_ATTR_STR_HYBRID(topdown-retiring,
+		      td_retiring_arl_h,
+		      "event=0xc2,umask=0x02;event=0x00,umask=0x80;event=0xc2,umask=0x0",
+		      hybrid_big_small_tiny);
+EVENT_ATTR_STR_HYBRID(topdown-bad-spec,
+		      td_bad_spec_arl_h,
+		      "event=0x73,umask=0x0;event=0x00,umask=0x81;event=0x73,umask=0x0",
+		      hybrid_big_small_tiny);
+EVENT_ATTR_STR_HYBRID(topdown-fe-bound,
+		      td_fe_bound_arl_h,
+		      "event=0x9c,umask=0x01;event=0x00,umask=0x82;event=0x71,umask=0x0",
+		      hybrid_big_small_tiny);
+EVENT_ATTR_STR_HYBRID(topdown-be-bound,
+		      td_be_bound_arl_h,
+		      "event=0xa4,umask=0x02;event=0x00,umask=0x83;event=0x74,umask=0x0",
+		      hybrid_big_small_tiny);
+
+static struct attribute *arl_h_hybrid_events_attrs[] = {
+	EVENT_PTR(slots_adl),
+	EVENT_PTR(td_retiring_arl_h),
+	EVENT_PTR(td_bad_spec_arl_h),
+	EVENT_PTR(td_fe_bound_arl_h),
+	EVENT_PTR(td_be_bound_arl_h),
+	EVENT_PTR(td_heavy_ops_adl),
+	EVENT_PTR(td_br_mis_adl),
+	EVENT_PTR(td_fetch_lat_adl),
+	EVENT_PTR(td_mem_bound_adl),
+	NULL,
+};
+
 /* Must be in IDX order */
 EVENT_ATTR_STR_HYBRID(mem-loads,     mem_ld_adl,     "event=0xd0,umask=0x5,ldlat=3;event=0xcd,umask=0x1,ldlat=3", hybrid_big_small);
 EVENT_ATTR_STR_HYBRID(mem-stores,    mem_st_adl,     "event=0xd0,umask=0x6;event=0xcd,umask=0x2",                 hybrid_big_small);
@@ -5992,6 +6045,21 @@ static struct attribute *mtl_hybrid_mem_attrs[] = {
 	NULL
 };
 
+EVENT_ATTR_STR_HYBRID(mem-loads,
+		      mem_ld_arl_h,
+		      "event=0xd0,umask=0x5,ldlat=3;event=0xcd,umask=0x1,ldlat=3;event=0xd0,umask=0x5,ldlat=3",
+		      hybrid_big_small_tiny);
+EVENT_ATTR_STR_HYBRID(mem-stores,
+		      mem_st_arl_h,
+		      "event=0xd0,umask=0x6;event=0xcd,umask=0x2;event=0xd0,umask=0x6",
+		      hybrid_big_small_tiny);
+
+static struct attribute *arl_h_hybrid_mem_attrs[] = {
+	EVENT_PTR(mem_ld_arl_h),
+	EVENT_PTR(mem_st_arl_h),
+	NULL,
+};
+
 EVENT_ATTR_STR_HYBRID(tx-start,          tx_start_adl,          "event=0xc9,umask=0x1",          hybrid_big);
 EVENT_ATTR_STR_HYBRID(tx-commit,         tx_commit_adl,         "event=0xc9,umask=0x2",          hybrid_big);
 EVENT_ATTR_STR_HYBRID(tx-abort,          tx_abort_adl,          "event=0xc9,umask=0x4",          hybrid_big);
@@ -6015,8 +6083,8 @@ static struct attribute *adl_hybrid_tsx_attrs[] = {
 
 FORMAT_ATTR_HYBRID(in_tx,       hybrid_big);
 FORMAT_ATTR_HYBRID(in_tx_cp,    hybrid_big);
-FORMAT_ATTR_HYBRID(offcore_rsp, hybrid_big_small);
-FORMAT_ATTR_HYBRID(ldlat,       hybrid_big_small);
+FORMAT_ATTR_HYBRID(offcore_rsp, hybrid_big_small_tiny);
+FORMAT_ATTR_HYBRID(ldlat,       hybrid_big_small_tiny);
 FORMAT_ATTR_HYBRID(frontend,    hybrid_big);
 
 #define ADL_HYBRID_RTM_FORMAT_ATTR	\
@@ -6039,7 +6107,7 @@ static struct attribute *adl_hybrid_extra_attr[] = {
 	NULL
 };
 
-FORMAT_ATTR_HYBRID(snoop_rsp,	hybrid_small);
+FORMAT_ATTR_HYBRID(snoop_rsp,	hybrid_small_tiny);
 
 static struct attribute *mtl_hybrid_extra_attr_rtm[] = {
 	ADL_HYBRID_RTM_FORMAT_ATTR,
@@ -7121,6 +7189,37 @@ __init int intel_pmu_init(void)
 		name = "lunarlake_hybrid";
 		break;
 
+	case INTEL_ARROWLAKE_H:
+		intel_pmu_init_hybrid(hybrid_big_small_tiny);
+
+		x86_pmu.pebs_latency_data = arl_h_latency_data;
+		x86_pmu.get_event_constraints = arl_h_get_event_constraints;
+		x86_pmu.hw_config = arl_h_hw_config;
+
+		td_attr = arl_h_hybrid_events_attrs;
+		mem_attr = arl_h_hybrid_mem_attrs;
+		tsx_attr = adl_hybrid_tsx_attrs;
+		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
+			mtl_hybrid_extra_attr_rtm : mtl_hybrid_extra_attr;
+
+		/* Initialize big core specific PerfMon capabilities. */
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
+		intel_pmu_init_lnc(&pmu->pmu);
+
+		/* Initialize Atom core specific PerfMon capabilities. */
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
+		intel_pmu_init_skt(&pmu->pmu);
+
+		/* Initialize Lower Power Atom specific PerfMon capabilities. */
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_TINY_IDX];
+		intel_pmu_init_grt(&pmu->pmu);
+		pmu->extra_regs = intel_cmt_extra_regs;
+
+		intel_pmu_pebs_data_source_arl_h();
+		pr_cont("ArrowLake-H Hybrid events, ");
+		name = "arrowlake_h_hybrid";
+		break;
+
 	default:
 		switch (x86_pmu.version) {
 		case 1:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index fa5ea65..8afc4ad 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -177,6 +177,17 @@ void __init intel_pmu_pebs_data_source_mtl(void)
 	__intel_pmu_pebs_data_source_cmt(data_source);
 }
 
+void __init intel_pmu_pebs_data_source_arl_h(void)
+{
+	u64 *data_source;
+
+	intel_pmu_pebs_data_source_lnl();
+
+	data_source = x86_pmu.hybrid_pmu[X86_HYBRID_PMU_TINY_IDX].pebs_data_source;
+	memcpy(data_source, pebs_data_source, sizeof(pebs_data_source));
+	__intel_pmu_pebs_data_source_cmt(data_source);
+}
+
 void __init intel_pmu_pebs_data_source_cmt(void)
 {
 	__intel_pmu_pebs_data_source_cmt(pebs_data_source);
@@ -388,6 +399,16 @@ u64 lnl_latency_data(struct perf_event *event, u64 status)
 	return lnc_latency_data(event, status);
 }
 
+u64 arl_h_latency_data(struct perf_event *event, u64 status)
+{
+	struct x86_hybrid_pmu *pmu = hybrid_pmu(event->pmu);
+
+	if (pmu->pmu_type == hybrid_tiny)
+		return cmt_latency_data(event, status);
+
+	return lnl_latency_data(event, status);
+}
+
 static u64 load_latency_data(struct perf_event *event, u64 status)
 {
 	union intel_x86_pebs_dse dse;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 909467d..82c6f45 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1592,6 +1592,8 @@ u64 cmt_latency_data(struct perf_event *event, u64 status);
 
 u64 lnl_latency_data(struct perf_event *event, u64 status);
 
+u64 arl_h_latency_data(struct perf_event *event, u64 status);
+
 extern struct event_constraint intel_core2_pebs_event_constraints[];
 
 extern struct event_constraint intel_atom_pebs_event_constraints[];
@@ -1711,6 +1713,8 @@ void intel_pmu_pebs_data_source_grt(void);
 
 void intel_pmu_pebs_data_source_mtl(void);
 
+void intel_pmu_pebs_data_source_arl_h(void);
+
 void intel_pmu_pebs_data_source_cmt(void);
 
 void intel_pmu_pebs_data_source_lnl(void);

