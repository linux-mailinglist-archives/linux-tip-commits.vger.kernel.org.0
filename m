Return-Path: <linux-tip-commits+bounces-7291-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54709C4D706
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 12:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3BBB189BFE5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 11:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD113590B2;
	Tue, 11 Nov 2025 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OuuLXM7B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IZJ+dhJB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3086358D0E;
	Tue, 11 Nov 2025 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861032; cv=none; b=lPD0Y2HlZ4d+P6FdkGbCJirvkThvKZRN4JTz+1GRbEzXeNU7ImjMized878o3GSYJiRp+3Y9nwBGuUklRbtGpriNnb7IQ1KIePH+Ddu9nC18gJx0Gh6LGmSB6rNBJMDM3TC+bZubC2o6bu1ZIPxjQVaYusiusC1Q6tBnNZlDOEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861032; c=relaxed/simple;
	bh=rsRN7oOEvyLBlgbgU0jbfLjy98u3lOnghjpfYO1gBWo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AYw684B0QqtZeSyQpV8KseOiGt2KjXfzXh+sD/PxtItep3chQ58BNLymZ4u3x5nZNCplr1oWrAeiOfkdbjpYmMY9q3vCrzGzmsA7SkJnKwhOaPkhnSi4Ll6q6tG8YnsgLmKo1VhUgoXs1gfkdQB0RRERbvxTINVD+xpKcgUqkbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OuuLXM7B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IZJ+dhJB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:37:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762861028;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oh9cvXEiPJzILM0TW0/argLXDO1Aq2/J+ktVSDONtuc=;
	b=OuuLXM7BTTX+C1lc5Dlau0pRxe3rxKl21eKgQcPkSuVWGV3ExGsqOQWeAcXblcKVbyjb/1
	pHdV4UtLU3TYoXhDKK1txhUQZvg75fKeIVImNq3MH8dn5igXXL2mUWD99IS+5aRHZ/Mm1c
	Eu30zghst6OsvZkAI++T5wKwBkqBtNUKoUjVISJmGzSHfRib4mOjW54P4GjLOCH7oCLnrF
	iIAMvfE1Dg0avw6PEM8EyidVC9aygcwLPDEriZa+z4qmvxzp2S3IwB/IX31HQpK+SFAvJ4
	rnSeZeztbctibNoVq+7i34Bm/L77P3XxtiOGs96MB48qWOa1rOavo1zIHAd4Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762861028;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oh9cvXEiPJzILM0TW0/argLXDO1Aq2/J+ktVSDONtuc=;
	b=IZJ+dhJBakAJruJOHlFpIgHpyH+5Q4FLNDKDekJPo3Ix+eIkGxGbuDALg9IU0JbMvB7Ynh
	0H92u6jxytK66KCA==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Initialize architectural PEBS
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251029102136.61364-6-dapeng1.mi@linux.intel.com>
References: <20251029102136.61364-6-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176286102695.498.15132412828484631237.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d243d0bb64af1e90ec18ac2fa6e7cadfe8895913
Gitweb:        https://git.kernel.org/tip/d243d0bb64af1e90ec18ac2fa6e7cadfe88=
95913
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 29 Oct 2025 18:21:29 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 07 Nov 2025 15:08:20 +01:00

perf/x86/intel: Initialize architectural PEBS

arch-PEBS leverages CPUID.23H.4/5 sub-leaves enumerate arch-PEBS
supported capabilities and counters bitmap. This patch parses these 2
sub-leaves and initializes arch-PEBS capabilities and corresponding
structures.

Since IA32_PEBS_ENABLE and MSR_PEBS_DATA_CFG MSRs are no longer existed
for arch-PEBS, arch-PEBS doesn't need to manipulate these MSRs. Thus add
a simple pair of __intel_pmu_pebs_enable/disable() callbacks for
arch-PEBS.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251029102136.61364-6-dapeng1.mi@linux.intel.=
com
---
 arch/x86/events/core.c            | 21 ++++++++---
 arch/x86/events/intel/core.c      | 60 ++++++++++++++++++++++--------
 arch/x86/events/intel/ds.c        | 52 ++++++++++++++++++++++----
 arch/x86/events/perf_event.h      | 25 +++++++++++--
 arch/x86/include/asm/perf_event.h |  7 +++-
 5 files changed, 132 insertions(+), 33 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index b2868fe..5d0d5e4 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -554,14 +554,22 @@ static inline int precise_br_compat(struct perf_event *=
event)
 	return m =3D=3D b;
 }
=20
-int x86_pmu_max_precise(void)
+int x86_pmu_max_precise(struct pmu *pmu)
 {
 	int precise =3D 0;
=20
-	/* Support for constant skid */
 	if (x86_pmu.pebs_active && !x86_pmu.pebs_broken) {
-		precise++;
+		/* arch PEBS */
+		if (x86_pmu.arch_pebs) {
+			precise =3D 2;
+			if (hybrid(pmu, arch_pebs_cap).pdists)
+				precise++;
+
+			return precise;
+		}
=20
+		/* legacy PEBS - support for constant skid */
+		precise++;
 		/* Support for IP fixup */
 		if (x86_pmu.lbr_nr || x86_pmu.intel_cap.pebs_format >=3D 2)
 			precise++;
@@ -569,13 +577,14 @@ int x86_pmu_max_precise(void)
 		if (x86_pmu.pebs_prec_dist)
 			precise++;
 	}
+
 	return precise;
 }
=20
 int x86_pmu_hw_config(struct perf_event *event)
 {
 	if (event->attr.precise_ip) {
-		int precise =3D x86_pmu_max_precise();
+		int precise =3D x86_pmu_max_precise(event->pmu);
=20
 		if (event->attr.precise_ip > precise)
 			return -EOPNOTSUPP;
@@ -2630,7 +2639,9 @@ static ssize_t max_precise_show(struct device *cdev,
 				  struct device_attribute *attr,
 				  char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu_max_precise());
+	struct pmu *pmu =3D dev_get_drvdata(cdev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu_max_precise(pmu));
 }
=20
 static DEVICE_ATTR_RO(max_precise);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c88bcd5..9ce27b3 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5271,34 +5271,59 @@ static inline bool intel_pmu_broken_perf_cap(void)
 	return false;
 }
=20
+#define counter_mask(_gp, _fixed) ((_gp) | ((u64)(_fixed) << INTEL_PMC_IDX_F=
IXED))
+
 static void update_pmu_cap(struct pmu *pmu)
 {
-	unsigned int cntr, fixed_cntr, ecx, edx;
-	union cpuid35_eax eax;
-	union cpuid35_ebx ebx;
+	unsigned int eax, ebx, ecx, edx;
+	union cpuid35_eax eax_0;
+	union cpuid35_ebx ebx_0;
+	u64 cntrs_mask =3D 0;
+	u64 pebs_mask =3D 0;
+	u64 pdists_mask =3D 0;
=20
-	cpuid(ARCH_PERFMON_EXT_LEAF, &eax.full, &ebx.full, &ecx, &edx);
+	cpuid(ARCH_PERFMON_EXT_LEAF, &eax_0.full, &ebx_0.full, &ecx, &edx);
=20
-	if (ebx.split.umask2)
+	if (ebx_0.split.umask2)
 		hybrid(pmu, config_mask) |=3D ARCH_PERFMON_EVENTSEL_UMASK2;
-	if (ebx.split.eq)
+	if (ebx_0.split.eq)
 		hybrid(pmu, config_mask) |=3D ARCH_PERFMON_EVENTSEL_EQ;
=20
-	if (eax.split.cntr_subleaf) {
+	if (eax_0.split.cntr_subleaf) {
 		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
-			    &cntr, &fixed_cntr, &ecx, &edx);
-		hybrid(pmu, cntr_mask64) =3D cntr;
-		hybrid(pmu, fixed_cntr_mask64) =3D fixed_cntr;
+			    &eax, &ebx, &ecx, &edx);
+		hybrid(pmu, cntr_mask64) =3D eax;
+		hybrid(pmu, fixed_cntr_mask64) =3D ebx;
+		cntrs_mask =3D counter_mask(eax, ebx);
 	}
=20
-	if (eax.split.acr_subleaf) {
+	if (eax_0.split.acr_subleaf) {
 		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_ACR_LEAF,
-			    &cntr, &fixed_cntr, &ecx, &edx);
+			    &eax, &ebx, &ecx, &edx);
 		/* The mask of the counters which can be reloaded */
-		hybrid(pmu, acr_cntr_mask64) =3D cntr | ((u64)fixed_cntr << INTEL_PMC_IDX_=
FIXED);
-
+		hybrid(pmu, acr_cntr_mask64) =3D counter_mask(eax, ebx);
 		/* The mask of the counters which can cause a reload of reloadable counter=
s */
-		hybrid(pmu, acr_cause_mask64) =3D ecx | ((u64)edx << INTEL_PMC_IDX_FIXED);
+		hybrid(pmu, acr_cause_mask64) =3D counter_mask(ecx, edx);
+	}
+
+	/* Bits[5:4] should be set simultaneously if arch-PEBS is supported */
+	if (eax_0.split.pebs_caps_subleaf && eax_0.split.pebs_cnts_subleaf) {
+		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_PEBS_CAP_LEAF,
+			    &eax, &ebx, &ecx, &edx);
+		hybrid(pmu, arch_pebs_cap).caps =3D (u64)ebx << 32;
+
+		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_PEBS_COUNTER_LEAF,
+			    &eax, &ebx, &ecx, &edx);
+		pebs_mask   =3D counter_mask(eax, ecx);
+		pdists_mask =3D counter_mask(ebx, edx);
+		hybrid(pmu, arch_pebs_cap).counters =3D pebs_mask;
+		hybrid(pmu, arch_pebs_cap).pdists =3D pdists_mask;
+
+		if (WARN_ON((pebs_mask | pdists_mask) & ~cntrs_mask))
+			x86_pmu.arch_pebs =3D 0;
+	} else {
+		WARN_ON(x86_pmu.arch_pebs =3D=3D 1);
+		x86_pmu.arch_pebs =3D 0;
 	}
=20
 	if (!intel_pmu_broken_perf_cap()) {
@@ -6252,7 +6277,7 @@ tsx_is_visible(struct kobject *kobj, struct attribute *=
attr, int i)
 static umode_t
 pebs_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
-	return x86_pmu.ds_pebs ? attr->mode : 0;
+	return intel_pmu_has_pebs() ? attr->mode : 0;
 }
=20
 static umode_t
@@ -7728,6 +7753,9 @@ __init int intel_pmu_init(void)
 	if (!is_hybrid() && boot_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
 		update_pmu_cap(NULL);
=20
+	if (x86_pmu.arch_pebs)
+		pr_cont("Architectural PEBS, ");
+
 	intel_pmu_check_counters_mask(&x86_pmu.cntr_mask64,
 				      &x86_pmu.fixed_cntr_mask64,
 				      &x86_pmu.intel_ctrl);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c0b7ac1..26e485e 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1531,6 +1531,15 @@ static inline void intel_pmu_drain_large_pebs(struct c=
pu_hw_events *cpuc)
 		intel_pmu_drain_pebs_buffer();
 }
=20
+static void __intel_pmu_pebs_enable(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
+	struct hw_perf_event *hwc =3D &event->hw;
+
+	hwc->config &=3D ~ARCH_PERFMON_EVENTSEL_INT;
+	cpuc->pebs_enabled |=3D 1ULL << hwc->idx;
+}
+
 void intel_pmu_pebs_enable(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
@@ -1539,9 +1548,7 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 	struct debug_store *ds =3D cpuc->ds;
 	unsigned int idx =3D hwc->idx;
=20
-	hwc->config &=3D ~ARCH_PERFMON_EVENTSEL_INT;
-
-	cpuc->pebs_enabled |=3D 1ULL << hwc->idx;
+	__intel_pmu_pebs_enable(event);
=20
 	if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) && (x86_pmu.version < 5))
 		cpuc->pebs_enabled |=3D 1ULL << (hwc->idx + 32);
@@ -1603,14 +1610,22 @@ void intel_pmu_pebs_del(struct perf_event *event)
 	pebs_update_state(needed_cb, cpuc, event, false);
 }
=20
-void intel_pmu_pebs_disable(struct perf_event *event)
+static void __intel_pmu_pebs_disable(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc =3D &event->hw;
=20
 	intel_pmu_drain_large_pebs(cpuc);
-
 	cpuc->pebs_enabled &=3D ~(1ULL << hwc->idx);
+	hwc->config |=3D ARCH_PERFMON_EVENTSEL_INT;
+}
+
+void intel_pmu_pebs_disable(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
+	struct hw_perf_event *hwc =3D &event->hw;
+
+	__intel_pmu_pebs_disable(event);
=20
 	if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) &&
 	    (x86_pmu.version < 5))
@@ -1622,8 +1637,6 @@ void intel_pmu_pebs_disable(struct perf_event *event)
=20
 	if (cpuc->enabled)
 		wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
-
-	hwc->config |=3D ARCH_PERFMON_EVENTSEL_INT;
 }
=20
 void intel_pmu_pebs_enable_all(void)
@@ -2669,11 +2682,26 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *=
iregs, struct perf_sample_d
 	}
 }
=20
+static void __init intel_arch_pebs_init(void)
+{
+	/*
+	 * Current hybrid platforms always both support arch-PEBS or not
+	 * on all kinds of cores. So directly set x86_pmu.arch_pebs flag
+	 * if boot cpu supports arch-PEBS.
+	 */
+	x86_pmu.arch_pebs =3D 1;
+	x86_pmu.pebs_buffer_size =3D PEBS_BUFFER_SIZE;
+	x86_pmu.pebs_capable =3D ~0ULL;
+
+	x86_pmu.pebs_enable =3D __intel_pmu_pebs_enable;
+	x86_pmu.pebs_disable =3D __intel_pmu_pebs_disable;
+}
+
 /*
  * PEBS probe and setup
  */
=20
-void __init intel_pebs_init(void)
+static void __init intel_ds_pebs_init(void)
 {
 	/*
 	 * No support for 32bit formats
@@ -2788,6 +2816,14 @@ void __init intel_pebs_init(void)
 	}
 }
=20
+void __init intel_pebs_init(void)
+{
+	if (x86_pmu.intel_cap.pebs_format =3D=3D 0xf)
+		intel_arch_pebs_init();
+	else
+		intel_ds_pebs_init();
+}
+
 void perf_restore_debug_store(void)
 {
 	struct debug_store *ds =3D __this_cpu_read(cpu_hw_events.ds);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 285779c..ca52899 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -708,6 +708,12 @@ enum hybrid_pmu_type {
 	hybrid_big_small_tiny	=3D hybrid_big   | hybrid_small_tiny,
 };
=20
+struct arch_pebs_cap {
+	u64 caps;
+	u64 counters;
+	u64 pdists;
+};
+
 struct x86_hybrid_pmu {
 	struct pmu			pmu;
 	const char			*name;
@@ -752,6 +758,8 @@ struct x86_hybrid_pmu {
 					mid_ack		:1,
 					enabled_ack	:1;
=20
+	struct arch_pebs_cap		arch_pebs_cap;
+
 	u64				pebs_data_source[PERF_PEBS_DATA_SOURCE_MAX];
 };
=20
@@ -906,7 +914,7 @@ struct x86_pmu {
 	union perf_capabilities intel_cap;
=20
 	/*
-	 * Intel DebugStore bits
+	 * Intel DebugStore and PEBS bits
 	 */
 	unsigned int	bts			:1,
 			bts_active		:1,
@@ -917,7 +925,8 @@ struct x86_pmu {
 			pebs_no_tlb		:1,
 			pebs_no_isolation	:1,
 			pebs_block		:1,
-			pebs_ept		:1;
+			pebs_ept		:1,
+			arch_pebs		:1;
 	int		pebs_record_size;
 	int		pebs_buffer_size;
 	u64		pebs_events_mask;
@@ -930,6 +939,11 @@ struct x86_pmu {
 	u64		pebs_capable;
=20
 	/*
+	 * Intel Architectural PEBS
+	 */
+	struct arch_pebs_cap arch_pebs_cap;
+
+	/*
 	 * Intel LBR
 	 */
 	unsigned int	lbr_tos, lbr_from, lbr_to,
@@ -1216,7 +1230,7 @@ int x86_reserve_hardware(void);
=20
 void x86_release_hardware(void);
=20
-int x86_pmu_max_precise(void);
+int x86_pmu_max_precise(struct pmu *pmu);
=20
 void hw_perf_lbr_event_destroy(struct perf_event *event);
=20
@@ -1791,6 +1805,11 @@ static inline int intel_pmu_max_num_pebs(struct pmu *p=
mu)
 	return fls((u32)hybrid(pmu, pebs_events_mask));
 }
=20
+static inline bool intel_pmu_has_pebs(void)
+{
+	return x86_pmu.ds_pebs || x86_pmu.arch_pebs;
+}
+
 #else /* CONFIG_CPU_SUP_INTEL */
=20
 static inline void reserve_ds_buffers(void)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_ev=
ent.h
index 49a4d44..0dfa067 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -200,6 +200,8 @@ union cpuid10_edx {
 #define ARCH_PERFMON_EXT_LEAF			0x00000023
 #define ARCH_PERFMON_NUM_COUNTER_LEAF		0x1
 #define ARCH_PERFMON_ACR_LEAF			0x2
+#define ARCH_PERFMON_PEBS_CAP_LEAF		0x4
+#define ARCH_PERFMON_PEBS_COUNTER_LEAF		0x5
=20
 union cpuid35_eax {
 	struct {
@@ -210,7 +212,10 @@ union cpuid35_eax {
 		unsigned int    acr_subleaf:1;
 		/* Events Sub-Leaf */
 		unsigned int    events_subleaf:1;
-		unsigned int	reserved:28;
+		/* arch-PEBS Sub-Leaves */
+		unsigned int	pebs_caps_subleaf:1;
+		unsigned int	pebs_cnts_subleaf:1;
+		unsigned int	reserved:26;
 	} split;
 	unsigned int            full;
 };

