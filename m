Return-Path: <linux-tip-commits+bounces-7288-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 449BAC4D6F7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 12:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95819189A658
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 11:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D08358D07;
	Tue, 11 Nov 2025 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hHNouhfS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fzaJxlnn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD803563F1;
	Tue, 11 Nov 2025 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861029; cv=none; b=Ktuv2naTIaCmU8pKQlYgW2huTgnm8tcBfDlZHSsrQ2/ZO7cJiKNEBBdDzl3r/pXuyDiDg7r8NQgeAWS9uDq9AjH80BNyFUXwG1d1kCUwTapaBsVpGVrFwesBaNvl1+Q4uZf7OVMVxh/JiZyuvWWAB2cRk+TvglKEWy8uZWahUXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861029; c=relaxed/simple;
	bh=UBCQEk/TvxOF4k9VQVEuAtpro+71vqJv7EppfZlS35M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TAq9SMZd9IqBhYxlETPHb1R0aEuIp/1X6I0TaOIF/lEhBIX4t6szKJ7KTVhUV4lHR4dmkVZx64h9lh/cXJomHtIOLDcY1xZyZZblxdyBuyOxNf/3RSV76ysVaDsWtFc/yGzQqjiQFZ3usKSSWwUnhevLXLJQT2JE9cXDgOlwaTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hHNouhfS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fzaJxlnn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:37:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762861025;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B1MLE3I4fRVs5/7cOfWwBXJ4sXdryR8ZS8ll6PlB+UA=;
	b=hHNouhfSigTTo6/sD229uYU6aqIm4T1RIex//mHEipBNMUy+lSil72P+pxioVugtXdxx0l
	xPFjG/wQAAmBRW4rkP9j+MwTXDVhrZ1fJYFHZ2oMsM6BemrtQbkEI0A/wnq7Ry3rwrn3o2
	7HEbIe3KWbZq0jMe/rA3JoFKV70veRibabWj5U/2qEiSdAU3BLwVzFRCMk/I3nLkb55bHk
	ZKVo/Hmqwzoz3DlBDqFF34Uh50vDj6tYKtHDlXzO7ybqyjWHXx8QCIKu/Vl8iASH4nXQzj
	uA1mjidXeoFeyduCFca5DL3ZIi4HYPAml0e0XQbqnEteQvxILbH+SWvqlk42Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762861025;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B1MLE3I4fRVs5/7cOfWwBXJ4sXdryR8ZS8ll6PlB+UA=;
	b=fzaJxlnnq7bc5RFIBsK23Ad+lwU/sDcTNAAFHZw2fAf434HFzr+tIZ6CecjJCVlE1UbkNl
	6sc11Cy7Tz51l4Cw==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Process arch-PEBS records or record
 fragments
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251029102136.61364-9-dapeng1.mi@linux.intel.com>
References: <20251029102136.61364-9-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176286102414.498.15465443871117541192.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d21954c8a0ffbc94ffdd65106fb6da5b59042e0a
Gitweb:        https://git.kernel.org/tip/d21954c8a0ffbc94ffdd65106fb6da5b590=
42e0a
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 29 Oct 2025 18:21:32 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 07 Nov 2025 15:08:21 +01:00

perf/x86/intel: Process arch-PEBS records or record fragments

A significant difference with adaptive PEBS is that arch-PEBS record
supports fragments which means an arch-PEBS record could be split into
several independent fragments which have its own arch-PEBS header in
each fragment.

This patch defines architectural PEBS record layout structures and add
helpers to process arch-PEBS records or fragments. Only legacy PEBS
groups like basic, GPR, XMM and LBR groups are supported in this patch,
the new added YMM/ZMM/OPMASK vector registers capturing would be
supported in the future.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251029102136.61364-9-dapeng1.mi@linux.intel.=
com
---
 arch/x86/events/intel/core.c      |  13 ++-
 arch/x86/events/intel/ds.c        | 184 +++++++++++++++++++++++++++++-
 arch/x86/include/asm/msr-index.h  |   6 +-
 arch/x86/include/asm/perf_event.h |  96 +++++++++++++++-
 4 files changed, 299 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 9ce27b3..de4dbde 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3216,6 +3216,19 @@ static int handle_pmi_common(struct pt_regs *regs, u64=
 status)
 	}
=20
 	/*
+	 * Arch PEBS sets bit 54 in the global status register
+	 */
+	if (__test_and_clear_bit(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT,
+				 (unsigned long *)&status)) {
+		handled++;
+		static_call(x86_pmu_drain_pebs)(regs, &data);
+
+		if (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS] &&
+		    is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS]))
+			status &=3D ~GLOBAL_STATUS_PERF_METRICS_OVF_BIT;
+	}
+
+	/*
 	 * Intel PT
 	 */
 	if (__test_and_clear_bit(GLOBAL_STATUS_TRACE_TOPAPMI_BIT, (unsigned long *)=
&status)) {
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 6866452..fe1bf37 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2270,6 +2270,117 @@ static void setup_pebs_adaptive_sample_data(struct pe=
rf_event *event,
 			format_group);
 }
=20
+static inline bool arch_pebs_record_continued(struct arch_pebs_header *heade=
r)
+{
+	/* Continue bit or null PEBS record indicates fragment follows. */
+	return header->cont || !(header->format & GENMASK_ULL(63, 16));
+}
+
+static void setup_arch_pebs_sample_data(struct perf_event *event,
+					struct pt_regs *iregs,
+					void *__pebs,
+					struct perf_sample_data *data,
+					struct pt_regs *regs)
+{
+	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
+	u64 sample_type =3D event->attr.sample_type;
+	struct arch_pebs_header *header =3D NULL;
+	struct arch_pebs_aux *meminfo =3D NULL;
+	struct arch_pebs_gprs *gprs =3D NULL;
+	struct x86_perf_regs *perf_regs;
+	void *next_record;
+	void *at =3D __pebs;
+
+	if (at =3D=3D NULL)
+		return;
+
+	perf_regs =3D container_of(regs, struct x86_perf_regs, regs);
+	perf_regs->xmm_regs =3D NULL;
+
+	__setup_perf_sample_data(event, iregs, data);
+
+	*regs =3D *iregs;
+
+again:
+	header =3D at;
+	next_record =3D at + sizeof(struct arch_pebs_header);
+	if (header->basic) {
+		struct arch_pebs_basic *basic =3D next_record;
+		u16 retire =3D 0;
+
+		next_record =3D basic + 1;
+
+		if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT)
+			retire =3D basic->valid ? basic->retire : 0;
+		__setup_pebs_basic_group(event, regs, data, sample_type,
+				 basic->ip, basic->tsc, retire);
+	}
+
+	/*
+	 * The record for MEMINFO is in front of GP
+	 * But PERF_SAMPLE_TRANSACTION needs gprs->ax.
+	 * Save the pointer here but process later.
+	 */
+	if (header->aux) {
+		meminfo =3D next_record;
+		next_record =3D meminfo + 1;
+	}
+
+	if (header->gpr) {
+		gprs =3D next_record;
+		next_record =3D gprs + 1;
+
+		__setup_pebs_gpr_group(event, regs,
+				       (struct pebs_gprs *)gprs,
+				       sample_type);
+	}
+
+	if (header->aux) {
+		u64 ax =3D gprs ? gprs->ax : 0;
+
+		__setup_pebs_meminfo_group(event, data, sample_type,
+					   meminfo->cache_latency,
+					   meminfo->instr_latency,
+					   meminfo->address, meminfo->aux,
+					   meminfo->tsx_tuning, ax);
+	}
+
+	if (header->xmm) {
+		struct pebs_xmm *xmm;
+
+		next_record +=3D sizeof(struct arch_pebs_xer_header);
+
+		xmm =3D next_record;
+		perf_regs->xmm_regs =3D xmm->xmm;
+		next_record =3D xmm + 1;
+	}
+
+	if (header->lbr) {
+		struct arch_pebs_lbr_header *lbr_header =3D next_record;
+		struct lbr_entry *lbr;
+		int num_lbr;
+
+		next_record =3D lbr_header + 1;
+		lbr =3D next_record;
+
+		num_lbr =3D header->lbr =3D=3D ARCH_PEBS_LBR_NUM_VAR ?
+				lbr_header->depth :
+				header->lbr * ARCH_PEBS_BASE_LBR_ENTRIES;
+		next_record +=3D num_lbr * sizeof(struct lbr_entry);
+
+		if (has_branch_stack(event)) {
+			intel_pmu_store_pebs_lbrs(lbr);
+			intel_pmu_lbr_save_brstack(data, cpuc, event);
+		}
+	}
+
+	/* Parse followed fragments if there are. */
+	if (arch_pebs_record_continued(header)) {
+		at =3D at + header->size;
+		goto again;
+	}
+}
+
 static inline void *
 get_next_pebs_record_by_bit(void *base, void *top, int bit)
 {
@@ -2753,6 +2864,78 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *i=
regs, struct perf_sample_d
 					    setup_pebs_adaptive_sample_data);
 }
=20
+static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
+				      struct perf_sample_data *data)
+{
+	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] =3D {};
+	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
+	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
+	union arch_pebs_index index;
+	struct x86_perf_regs perf_regs;
+	struct pt_regs *regs =3D &perf_regs.regs;
+	void *base, *at, *top;
+	u64 mask;
+
+	rdmsrq(MSR_IA32_PEBS_INDEX, index.whole);
+
+	if (unlikely(!index.wr)) {
+		intel_pmu_pebs_event_update_no_drain(cpuc, X86_PMC_IDX_MAX);
+		return;
+	}
+
+	base =3D cpuc->ds_pebs_vaddr;
+	top =3D (void *)((u64)cpuc->ds_pebs_vaddr +
+		       (index.wr << ARCH_PEBS_INDEX_WR_SHIFT));
+
+	index.wr =3D 0;
+	index.full =3D 0;
+	wrmsrq(MSR_IA32_PEBS_INDEX, index.whole);
+
+	mask =3D hybrid(cpuc->pmu, arch_pebs_cap).counters & cpuc->pebs_enabled;
+
+	if (!iregs)
+		iregs =3D &dummy_iregs;
+
+	/* Process all but the last event for each counter. */
+	for (at =3D base; at < top;) {
+		struct arch_pebs_header *header;
+		struct arch_pebs_basic *basic;
+		u64 pebs_status;
+
+		header =3D at;
+
+		if (WARN_ON_ONCE(!header->size))
+			break;
+
+		/* 1st fragment or single record must have basic group */
+		if (!header->basic) {
+			at +=3D header->size;
+			continue;
+		}
+
+		basic =3D at + sizeof(struct arch_pebs_header);
+		pebs_status =3D mask & basic->applicable_counters;
+		__intel_pmu_handle_pebs_record(iregs, regs, data, at,
+					       pebs_status, counts, last,
+					       setup_arch_pebs_sample_data);
+
+		/* Skip non-last fragments */
+		while (arch_pebs_record_continued(header)) {
+			if (!header->size)
+				break;
+			at +=3D header->size;
+			header =3D at;
+		}
+
+		/* Skip last fragment or the single record */
+		at +=3D header->size;
+	}
+
+	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask,
+					    counts, last,
+					    setup_arch_pebs_sample_data);
+}
+
 static void __init intel_arch_pebs_init(void)
 {
 	/*
@@ -2762,6 +2945,7 @@ static void __init intel_arch_pebs_init(void)
 	 */
 	x86_pmu.arch_pebs =3D 1;
 	x86_pmu.pebs_buffer_size =3D PEBS_BUFFER_SIZE;
+	x86_pmu.drain_pebs =3D intel_pmu_drain_arch_pebs;
 	x86_pmu.pebs_capable =3D ~0ULL;
=20
 	x86_pmu.pebs_enable =3D __intel_pmu_pebs_enable;
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-inde=
x.h
index 9e1720d..fc7a4e7 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -327,6 +327,12 @@
 					 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE | \
 					 PERF_CAP_PEBS_TIMING_INFO)
=20
+/* Arch PEBS */
+#define MSR_IA32_PEBS_BASE		0x000003f4
+#define MSR_IA32_PEBS_INDEX		0x000003f5
+#define ARCH_PEBS_OFFSET_MASK		0x7fffff
+#define ARCH_PEBS_INDEX_WR_SHIFT	4
+
 #define MSR_IA32_RTIT_CTL		0x00000570
 #define RTIT_CTL_TRACEEN		BIT(0)
 #define RTIT_CTL_CYCLEACC		BIT(1)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_ev=
ent.h
index 0dfa067..3b3848f 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -437,6 +437,8 @@ static inline bool is_topdown_idx(int idx)
 #define GLOBAL_STATUS_LBRS_FROZEN		BIT_ULL(GLOBAL_STATUS_LBRS_FROZEN_BIT)
 #define GLOBAL_STATUS_TRACE_TOPAPMI_BIT		55
 #define GLOBAL_STATUS_TRACE_TOPAPMI		BIT_ULL(GLOBAL_STATUS_TRACE_TOPAPMI_BIT)
+#define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT	54
+#define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD	BIT_ULL(GLOBAL_STATUS_ARCH_PEBS_TH=
RESHOLD_BIT)
 #define GLOBAL_STATUS_PERF_METRICS_OVF_BIT	48
=20
 #define GLOBAL_CTRL_EN_PERF_METRICS		BIT_ULL(48)
@@ -508,6 +510,100 @@ struct pebs_cntr_header {
 #define INTEL_CNTR_METRICS		0x3
=20
 /*
+ * Arch PEBS
+ */
+union arch_pebs_index {
+	struct {
+		u64 rsvd:4,
+		    wr:23,
+		    rsvd2:4,
+		    full:1,
+		    en:1,
+		    rsvd3:3,
+		    thresh:23,
+		    rsvd4:5;
+	};
+	u64 whole;
+};
+
+struct arch_pebs_header {
+	union {
+		u64 format;
+		struct {
+			u64 size:16,	/* Record size */
+			    rsvd:14,
+			    mode:1,	/* 64BIT_MODE */
+			    cont:1,
+			    rsvd2:3,
+			    cntr:5,
+			    lbr:2,
+			    rsvd3:7,
+			    xmm:1,
+			    ymmh:1,
+			    rsvd4:2,
+			    opmask:1,
+			    zmmh:1,
+			    h16zmm:1,
+			    rsvd5:5,
+			    gpr:1,
+			    aux:1,
+			    basic:1;
+		};
+	};
+	u64 rsvd6;
+};
+
+struct arch_pebs_basic {
+	u64 ip;
+	u64 applicable_counters;
+	u64 tsc;
+	u64 retire	:16,	/* Retire Latency */
+	    valid	:1,
+	    rsvd	:47;
+	u64 rsvd2;
+	u64 rsvd3;
+};
+
+struct arch_pebs_aux {
+	u64 address;
+	u64 rsvd;
+	u64 rsvd2;
+	u64 rsvd3;
+	u64 rsvd4;
+	u64 aux;
+	u64 instr_latency	:16,
+	    pad2		:16,
+	    cache_latency	:16,
+	    pad3		:16;
+	u64 tsx_tuning;
+};
+
+struct arch_pebs_gprs {
+	u64 flags, ip, ax, cx, dx, bx, sp, bp, si, di;
+	u64 r8, r9, r10, r11, r12, r13, r14, r15, ssp;
+	u64 rsvd;
+};
+
+struct arch_pebs_xer_header {
+	u64 xstate;
+	u64 rsvd;
+};
+
+#define ARCH_PEBS_LBR_NAN		0x0
+#define ARCH_PEBS_LBR_NUM_8		0x1
+#define ARCH_PEBS_LBR_NUM_16		0x2
+#define ARCH_PEBS_LBR_NUM_VAR		0x3
+#define ARCH_PEBS_BASE_LBR_ENTRIES	8
+struct arch_pebs_lbr_header {
+	u64 rsvd;
+	u64 ctl;
+	u64 depth;
+	u64 ler_from;
+	u64 ler_to;
+	u64 ler_info;
+};
+
+/*
  * AMD Extended Performance Monitoring and Debug cpuid feature detection
  */
 #define EXT_PERFMON_DEBUG_FEATURES		0x80000022

