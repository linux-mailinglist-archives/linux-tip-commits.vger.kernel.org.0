Return-Path: <linux-tip-commits+bounces-7284-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B77B3C4D712
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 12:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 839434EBC2D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 11:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE67A3559CA;
	Tue, 11 Nov 2025 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mzldaASd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R9S3NS9M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE402F7479;
	Tue, 11 Nov 2025 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861025; cv=none; b=XKLWs8siouIvBbLaUrF752G5p6yoeTpjszojTlukB1P6iQ6tEAw8pwQNSk8kvr+loAOS5iYouta7SN89RruVLoQtGHOtcTUCgc4tv/V2X/HEr+KJAakBptnDOEYiLZsq4OJVTt4DaT5r+gI5P+d5aPO73I50ROcnmqKlxCHkb6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861025; c=relaxed/simple;
	bh=tkuNcAclJzLl1yZkDMWrbL+NzUQnOno+oR5kgvXMWB4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A4fymmHcYarRJV3V/COMJZxmlAyXjBcB7+vIk2jJvkiFy2s2hwmC9nUDUcycnKitdq1NkODYc4PxJOsXkBhvKNWA1WLpYpxGA90xCv7ZLcrw97qfIFXqBqggzp28I5ba1lljYFa1yKBpHe+6BvpDhrL7v+RZUvRbiuckilQ79uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mzldaASd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R9S3NS9M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:37:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762861021;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+xVGlIZ4RT5ITU7xbKhbIm5ubQGRBifEYapAj+RoDL8=;
	b=mzldaASdVTuNHx7fDs3QJ18qpJikNojK3jPRcrW6JTWIbqswbn/siA9W9CIHQx8KEAL8EM
	FRncEZpc+BC1R9E/ekk78mJ2QhHVnIgowDYkqw7t1BxiTtJ/Ap+f/Ba2/UfWsld0o5iGAy
	6q+ghhxJoALt18sEUdty15aNx0pcXAeDybhoVV7B/x/9kWrVE1zHX2DuL3b0FG2la8INM5
	M2UBp82sCxK3HZ0IPo3cRlBYzok9eTOS/UQzEWZLf8XaqDX88TXfm/2dIk8k9duX5EqGmW
	zsRJQzH+eJkjFf+85xmuOl010n6U81teFZ/96974vGyBUKUYCfK0x1ouSz02QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762861021;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+xVGlIZ4RT5ITU7xbKhbIm5ubQGRBifEYapAj+RoDL8=;
	b=R9S3NS9MBCfFJWhAW2TLPdkEaI4wLq1nK5eAaqFsDqSga6IEDJGAd96XmypkdKzRcptmGM
	7/XuxUcSFLxEaMDA==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel: Add counter group support for arch-PEBS
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251029102136.61364-13-dapeng1.mi@linux.intel.com>
References: <20251029102136.61364-13-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176286102025.498.17897602558713615511.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     bb5f13df3c455110c4468a31a5b21954268108c9
Gitweb:        https://git.kernel.org/tip/bb5f13df3c455110c4468a31a5b21954268=
108c9
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 29 Oct 2025 18:21:36 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 07 Nov 2025 15:08:22 +01:00

perf/x86/intel: Add counter group support for arch-PEBS

Base on previous adaptive PEBS counter snapshot support, add counter
group support for architectural PEBS. Since arch-PEBS shares same
counter group layout with adaptive PEBS, directly reuse
__setup_pebs_counter_group() helper to process arch-PEBS counter group.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251029102136.61364-13-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/core.c      | 38 +++++++++++++++++++++++++++---
 arch/x86/events/intel/ds.c        | 29 ++++++++++++++++++++---
 arch/x86/include/asm/msr-index.h  |  6 +++++-
 arch/x86/include/asm/perf_event.h | 13 +++++++---
 4 files changed, 77 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 75cba28..cb64018 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3014,6 +3014,17 @@ static void intel_pmu_enable_event_ext(struct perf_eve=
nt *event)
=20
 			if (pebs_data_cfg & PEBS_DATACFG_LBRS)
 				ext |=3D ARCH_PEBS_LBR & cap.caps;
+
+			if (pebs_data_cfg &
+			    (PEBS_DATACFG_CNTR_MASK << PEBS_DATACFG_CNTR_SHIFT))
+				ext |=3D ARCH_PEBS_CNTR_GP & cap.caps;
+
+			if (pebs_data_cfg &
+			    (PEBS_DATACFG_FIX_MASK << PEBS_DATACFG_FIX_SHIFT))
+				ext |=3D ARCH_PEBS_CNTR_FIXED & cap.caps;
+
+			if (pebs_data_cfg & PEBS_DATACFG_METRICS)
+				ext |=3D ARCH_PEBS_CNTR_METRICS & cap.caps;
 		}
=20
 		if (cpuc->n_pebs =3D=3D cpuc->n_large_pebs)
@@ -3038,6 +3049,9 @@ static void intel_pmu_enable_event_ext(struct perf_even=
t *event)
 		}
 	}
=20
+	if (is_pebs_counter_event_group(event))
+		ext |=3D ARCH_PEBS_CNTR_ALLOW;
+
 	if (cpuc->cfg_c_val[hwc->idx] !=3D ext)
 		__intel_pmu_update_event_ext(hwc->idx, ext);
 }
@@ -4323,6 +4337,20 @@ static bool intel_pmu_is_acr_group(struct perf_event *=
event)
 	return false;
 }
=20
+static inline bool intel_pmu_has_pebs_counter_group(struct pmu *pmu)
+{
+	u64 caps;
+
+	if (x86_pmu.intel_cap.pebs_format >=3D 6 && x86_pmu.intel_cap.pebs_baseline)
+		return true;
+
+	caps =3D hybrid(pmu, arch_pebs_cap).caps;
+	if (x86_pmu.arch_pebs && (caps & ARCH_PEBS_CNTR_MASK))
+		return true;
+
+	return false;
+}
+
 static inline void intel_pmu_set_acr_cntr_constr(struct perf_event *event,
 						 u64 *cause_mask, int *num)
 {
@@ -4471,8 +4499,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	}
=20
 	if ((event->attr.sample_type & PERF_SAMPLE_READ) &&
-	    (x86_pmu.intel_cap.pebs_format >=3D 6) &&
-	    x86_pmu.intel_cap.pebs_baseline &&
+	    intel_pmu_has_pebs_counter_group(event->pmu) &&
 	    is_sampling_event(event) &&
 	    event->attr.precise_ip)
 		event->group_leader->hw.flags |=3D PERF_X86_EVENT_PEBS_CNTR;
@@ -5420,6 +5447,8 @@ static inline void __intel_update_large_pebs_flags(stru=
ct pmu *pmu)
 	x86_pmu.large_pebs_flags |=3D PERF_SAMPLE_TIME;
 	if (caps & ARCH_PEBS_LBR)
 		x86_pmu.large_pebs_flags |=3D PERF_SAMPLE_BRANCH_STACK;
+	if (caps & ARCH_PEBS_CNTR_MASK)
+		x86_pmu.large_pebs_flags |=3D PERF_SAMPLE_READ;
=20
 	if (!(caps & ARCH_PEBS_AUX))
 		x86_pmu.large_pebs_flags &=3D ~PERF_SAMPLE_DATA_SRC;
@@ -7134,8 +7163,11 @@ __init int intel_pmu_init(void)
 	 * Many features on and after V6 require dynamic constraint,
 	 * e.g., Arch PEBS, ACR.
 	 */
-	if (version >=3D 6)
+	if (version >=3D 6) {
 		x86_pmu.flags |=3D PMU_FL_DYN_CONSTRAINT;
+		x86_pmu.late_setup =3D intel_pmu_late_setup;
+	}
+
 	/*
 	 * Install the hw-cache-events table:
 	 */
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c66e9b5..c93bf97 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1530,13 +1530,20 @@ pebs_update_state(bool needed_cb, struct cpu_hw_event=
s *cpuc,
=20
 u64 intel_get_arch_pebs_data_config(struct perf_event *event)
 {
+	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
 	u64 pebs_data_cfg =3D 0;
+	u64 cntr_mask;
=20
 	if (WARN_ON(event->hw.idx < 0 || event->hw.idx >=3D X86_PMC_IDX_MAX))
 		return 0;
=20
 	pebs_data_cfg |=3D pebs_update_adaptive_cfg(event);
=20
+	cntr_mask =3D (PEBS_DATACFG_CNTR_MASK << PEBS_DATACFG_CNTR_SHIFT) |
+		    (PEBS_DATACFG_FIX_MASK << PEBS_DATACFG_FIX_SHIFT) |
+		    PEBS_DATACFG_CNTR | PEBS_DATACFG_METRICS;
+	pebs_data_cfg |=3D cpuc->pebs_data_cfg & cntr_mask;
+
 	return pebs_data_cfg;
 }
=20
@@ -2444,6 +2451,24 @@ again:
 		}
 	}
=20
+	if (header->cntr) {
+		struct arch_pebs_cntr_header *cntr =3D next_record;
+		unsigned int nr;
+
+		next_record +=3D sizeof(struct arch_pebs_cntr_header);
+
+		if (is_pebs_counter_event_group(event)) {
+			__setup_pebs_counter_group(cpuc, event,
+				(struct pebs_cntr_header *)cntr, next_record);
+			data->sample_flags |=3D PERF_SAMPLE_READ;
+		}
+
+		nr =3D hweight32(cntr->cntr) + hweight32(cntr->fixed);
+		if (cntr->metrics =3D=3D INTEL_CNTR_METRICS)
+			nr +=3D 2;
+		next_record +=3D nr * sizeof(u64);
+	}
+
 	/* Parse followed fragments if there are. */
 	if (arch_pebs_record_continued(header)) {
 		at =3D at + header->size;
@@ -3094,10 +3119,8 @@ static void __init intel_ds_pebs_init(void)
 			break;
=20
 		case 6:
-			if (x86_pmu.intel_cap.pebs_baseline) {
+			if (x86_pmu.intel_cap.pebs_baseline)
 				x86_pmu.large_pebs_flags |=3D PERF_SAMPLE_READ;
-				x86_pmu.late_setup =3D intel_pmu_late_setup;
-			}
 			fallthrough;
 		case 5:
 			x86_pmu.pebs_ept =3D 1;
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-inde=
x.h
index f1ef9ac..65cc528 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -334,12 +334,18 @@
 #define ARCH_PEBS_INDEX_WR_SHIFT	4
=20
 #define ARCH_PEBS_RELOAD		0xffffffff
+#define ARCH_PEBS_CNTR_ALLOW		BIT_ULL(35)
+#define ARCH_PEBS_CNTR_GP		BIT_ULL(36)
+#define ARCH_PEBS_CNTR_FIXED		BIT_ULL(37)
+#define ARCH_PEBS_CNTR_METRICS		BIT_ULL(38)
 #define ARCH_PEBS_LBR_SHIFT		40
 #define ARCH_PEBS_LBR			(0x3ull << ARCH_PEBS_LBR_SHIFT)
 #define ARCH_PEBS_VECR_XMM		BIT_ULL(49)
 #define ARCH_PEBS_GPR			BIT_ULL(61)
 #define ARCH_PEBS_AUX			BIT_ULL(62)
 #define ARCH_PEBS_EN			BIT_ULL(63)
+#define ARCH_PEBS_CNTR_MASK		(ARCH_PEBS_CNTR_GP | ARCH_PEBS_CNTR_FIXED | \
+					 ARCH_PEBS_CNTR_METRICS)
=20
 #define MSR_IA32_RTIT_CTL		0x00000570
 #define RTIT_CTL_TRACEEN		BIT(0)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_ev=
ent.h
index 3b3848f..7276ba7 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -141,16 +141,16 @@
 #define ARCH_PERFMON_EVENTS_COUNT			7
=20
 #define PEBS_DATACFG_MEMINFO	BIT_ULL(0)
-#define PEBS_DATACFG_GP	BIT_ULL(1)
+#define PEBS_DATACFG_GP		BIT_ULL(1)
 #define PEBS_DATACFG_XMMS	BIT_ULL(2)
 #define PEBS_DATACFG_LBRS	BIT_ULL(3)
-#define PEBS_DATACFG_LBR_SHIFT	24
 #define PEBS_DATACFG_CNTR	BIT_ULL(4)
+#define PEBS_DATACFG_METRICS	BIT_ULL(5)
+#define PEBS_DATACFG_LBR_SHIFT	24
 #define PEBS_DATACFG_CNTR_SHIFT	32
 #define PEBS_DATACFG_CNTR_MASK	GENMASK_ULL(15, 0)
 #define PEBS_DATACFG_FIX_SHIFT	48
 #define PEBS_DATACFG_FIX_MASK	GENMASK_ULL(7, 0)
-#define PEBS_DATACFG_METRICS	BIT_ULL(5)
=20
 /* Steal the highest bit of pebs_data_cfg for SW usage */
 #define PEBS_UPDATE_DS_SW	BIT_ULL(63)
@@ -603,6 +603,13 @@ struct arch_pebs_lbr_header {
 	u64 ler_info;
 };
=20
+struct arch_pebs_cntr_header {
+	u32 cntr;
+	u32 fixed;
+	u32 metrics;
+	u32 reserved;
+};
+
 /*
  * AMD Extended Performance Monitoring and Debug cpuid feature detection
  */

