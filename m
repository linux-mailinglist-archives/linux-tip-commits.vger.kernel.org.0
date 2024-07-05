Return-Path: <linux-tip-commits+bounces-1611-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECA5928E83
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 23:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBC21C2171B
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 21:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB261779BD;
	Fri,  5 Jul 2024 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UK/vFLot";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9+5h/uFp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D1716F8FD;
	Fri,  5 Jul 2024 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213609; cv=none; b=mPT1ebOK7SAx37XNQB4PnC5G2q7E8pNHGlDRMhavoeRMUwbta46he5w3eINvzqpatxwyMkrN9dDjOfAc9v+TCpIOOLjlcXjry+ErrwCtf61rzvl3Cdwc+R2SMr3Aea75K7OddDHhVp2zlilv6ONyFHqQc7vyGQDPdERqnRsp/84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213609; c=relaxed/simple;
	bh=xERSMahLFbyFBvSqHBhSejgKRdI9wtsLamdh2rh5jGc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bTK/GcgpZEMfyTJt1BMa3Gc7omFDpXBTuMGM1sOwnMoKs0WjVzyumLt4whNVaKi+XKopw5bJygUrpay8VMLNpKdDrjy566SRoszGDoS/Q8kXQs1mg5sBl9FGhHWiT+D956jRmUkDlZgJ7m1ikZ8c7yDEKFaDx59MaK0+FmV6HJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UK/vFLot; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9+5h/uFp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Jul 2024 21:06:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720213604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wu/r3yDnO3RsYF49aGU59wXjtYVM80eXiM+1HYT/py4=;
	b=UK/vFLotB3KSMp7JdS37RomuX8wpeVtldhst7i/0IXH+PdO0uEL/hVd17LGfBDTLh1YTxs
	wnY79TZhfzUn+LxJEn2Q+Do6f7MaosTRmQG+v74CM+yR71ob7s7URJEXl4KV08NMB6TXnP
	/syAC+55tovCmDzTqt0GrwDoVzPk9+8EKbCS5TWnVzFQ4jJbRt/VQnCa2mHuU09RQk2bYM
	6HY3V17msIoWaNv3S4gGa5HgeFW4DPxq24YeZgbptZUXwox/VASL/+VnNmmkvn+SExksYy
	lEyoZ39ak9Cs/WkQifeZ9xYw1YxWSjqhSh7an1/6dNCG6MxEQsb4AG+bJiTy3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720213604;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wu/r3yDnO3RsYF49aGU59wXjtYVM80eXiM+1HYT/py4=;
	b=9+5h/uFpqIKB3LxhEmen9t7qkuQqUbmWMZhfIr7Hxv1auf3ic/uCwpy5xUD9/cLLlI7yQs
	JruP/NUUaoJ6EDAw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Support the PEBS event mask
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andi Kleen <ak@linux.intel.com>, Ian Rogers <irogers@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240626143545.480761-2-kan.liang@linux.intel.com>
References: <20240626143545.480761-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172021360370.2215.13615460942426714707.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a23eb2fc1d818cdac9b31f032842d55483a6a040
Gitweb:        https://git.kernel.org/tip/a23eb2fc1d818cdac9b31f032842d55483a6a040
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 26 Jun 2024 07:35:33 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Jul 2024 16:00:36 +02:00

perf/x86/intel: Support the PEBS event mask

The current perf assumes that the counters that support PEBS are
contiguous. But it's not guaranteed with the new leaf 0x23 introduced.
The counters are enumerated with a counter mask. There may be holes in
the counter mask for future platforms or in a virtualization
environment.

Store the PEBS event mask rather than the maximum number of PEBS
counters in the x86 PMU structures.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Link: https://lkml.kernel.org/r/20240626143545.480761-2-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c    |  8 ++++----
 arch/x86/events/intel/ds.c      | 15 ++++++++-------
 arch/x86/events/perf_event.h    | 15 +++++++++++++--
 arch/x86/include/asm/intel_ds.h |  1 +
 4 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0e835dc..6e2e363 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4728,7 +4728,7 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
 {
 	intel_pmu_check_num_counters(&pmu->num_counters, &pmu->num_counters_fixed,
 				     &pmu->intel_ctrl, (1ULL << pmu->num_counters_fixed) - 1);
-	pmu->max_pebs_events = min_t(unsigned, MAX_PEBS_EVENTS, pmu->num_counters);
+	pmu->pebs_events_mask = intel_pmu_pebs_mask(GENMASK_ULL(pmu->num_counters - 1, 0));
 	pmu->unconstrained = (struct event_constraint)
 			     __EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
 						0, pmu->num_counters, 0, 0);
@@ -6070,7 +6070,7 @@ static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
 
 		pmu->num_counters = x86_pmu.num_counters;
 		pmu->num_counters_fixed = x86_pmu.num_counters_fixed;
-		pmu->max_pebs_events = min_t(unsigned, MAX_PEBS_EVENTS, pmu->num_counters);
+		pmu->pebs_events_mask = intel_pmu_pebs_mask(GENMASK_ULL(pmu->num_counters - 1, 0));
 		pmu->unconstrained = (struct event_constraint)
 				     __EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
 							0, pmu->num_counters, 0, 0);
@@ -6193,7 +6193,7 @@ __init int intel_pmu_init(void)
 	x86_pmu.events_maskl		= ebx.full;
 	x86_pmu.events_mask_len		= eax.split.mask_length;
 
-	x86_pmu.max_pebs_events		= min_t(unsigned, MAX_PEBS_EVENTS, x86_pmu.num_counters);
+	x86_pmu.pebs_events_mask	= intel_pmu_pebs_mask(GENMASK_ULL(x86_pmu.num_counters - 1, 0));
 	x86_pmu.pebs_capable		= PEBS_COUNTER_MASK;
 
 	/*
@@ -6822,7 +6822,7 @@ __init int intel_pmu_init(void)
 			pmu->num_counters_fixed = x86_pmu.num_counters_fixed;
 		}
 
-		pmu->max_pebs_events = min_t(unsigned, MAX_PEBS_EVENTS, pmu->num_counters);
+		pmu->pebs_events_mask = intel_pmu_pebs_mask(GENMASK_ULL(pmu->num_counters - 1, 0));
 		pmu->unconstrained = (struct event_constraint)
 					__EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
 							   0, pmu->num_counters, 0, 0);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index e010bfe..f6105b8 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1137,7 +1137,7 @@ void intel_pmu_pebs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sche
 static inline void pebs_update_threshold(struct cpu_hw_events *cpuc)
 {
 	struct debug_store *ds = cpuc->ds;
-	int max_pebs_events = hybrid(cpuc->pmu, max_pebs_events);
+	int max_pebs_events = intel_pmu_max_num_pebs(cpuc->pmu);
 	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
 	u64 threshold;
 	int reserved;
@@ -2157,6 +2157,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 	void *base, *at, *top;
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
 	short error[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
+	int max_pebs_events = intel_pmu_max_num_pebs(NULL);
 	int bit, i, size;
 	u64 mask;
 
@@ -2168,8 +2169,8 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 
 	ds->pebs_index = ds->pebs_buffer_base;
 
-	mask = (1ULL << x86_pmu.max_pebs_events) - 1;
-	size = x86_pmu.max_pebs_events;
+	mask = x86_pmu.pebs_events_mask;
+	size = max_pebs_events;
 	if (x86_pmu.flags & PMU_FL_PEBS_ALL) {
 		mask |= ((1ULL << x86_pmu.num_counters_fixed) - 1) << INTEL_PMC_IDX_FIXED;
 		size = INTEL_PMC_IDX_FIXED + x86_pmu.num_counters_fixed;
@@ -2208,8 +2209,9 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 			pebs_status = p->status = cpuc->pebs_enabled;
 
 		bit = find_first_bit((unsigned long *)&pebs_status,
-					x86_pmu.max_pebs_events);
-		if (bit >= x86_pmu.max_pebs_events)
+				     max_pebs_events);
+
+		if (!(x86_pmu.pebs_events_mask & (1 << bit)))
 			continue;
 
 		/*
@@ -2267,7 +2269,6 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	int max_pebs_events = hybrid(cpuc->pmu, max_pebs_events);
 	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
 	struct debug_store *ds = cpuc->ds;
 	struct perf_event *event;
@@ -2283,7 +2284,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 
 	ds->pebs_index = ds->pebs_buffer_base;
 
-	mask = ((1ULL << max_pebs_events) - 1) |
+	mask = hybrid(cpuc->pmu, pebs_events_mask) |
 	       (((1ULL << num_counters_fixed) - 1) << INTEL_PMC_IDX_FIXED);
 	size = INTEL_PMC_IDX_FIXED + num_counters_fixed;
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 72b022a..a7ba286 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -684,7 +684,7 @@ struct x86_hybrid_pmu {
 	cpumask_t			supported_cpus;
 	union perf_capabilities		intel_cap;
 	u64				intel_ctrl;
-	int				max_pebs_events;
+	u64				pebs_events_mask;
 	int				num_counters;
 	int				num_counters_fixed;
 	struct event_constraint		unconstrained;
@@ -852,7 +852,7 @@ struct x86_pmu {
 			pebs_ept		:1;
 	int		pebs_record_size;
 	int		pebs_buffer_size;
-	int		max_pebs_events;
+	u64		pebs_events_mask;
 	void		(*drain_pebs)(struct pt_regs *regs, struct perf_sample_data *data);
 	struct event_constraint *pebs_constraints;
 	void		(*pebs_aliases)(struct perf_event *event);
@@ -1661,6 +1661,17 @@ static inline int is_ht_workaround_enabled(void)
 	return !!(x86_pmu.flags & PMU_FL_EXCL_ENABLED);
 }
 
+static inline u64 intel_pmu_pebs_mask(u64 cntr_mask)
+{
+	return MAX_PEBS_EVENTS_MASK & cntr_mask;
+}
+
+static inline int intel_pmu_max_num_pebs(struct pmu *pmu)
+{
+	static_assert(MAX_PEBS_EVENTS == 32);
+	return fls((u32)hybrid(pmu, pebs_events_mask));
+}
+
 #else /* CONFIG_CPU_SUP_INTEL */
 
 static inline void reserve_ds_buffers(void)
diff --git a/arch/x86/include/asm/intel_ds.h b/arch/x86/include/asm/intel_ds.h
index 2f9eeb5..5dbeac4 100644
--- a/arch/x86/include/asm/intel_ds.h
+++ b/arch/x86/include/asm/intel_ds.h
@@ -9,6 +9,7 @@
 /* The maximal number of PEBS events: */
 #define MAX_PEBS_EVENTS_FMT4	8
 #define MAX_PEBS_EVENTS		32
+#define MAX_PEBS_EVENTS_MASK	GENMASK_ULL(MAX_PEBS_EVENTS - 1, 0)
 #define MAX_FIXED_PEBS_EVENTS	16
 
 /*

