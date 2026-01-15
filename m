Return-Path: <linux-tip-commits+bounces-8020-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FECD28D09
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 22:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EF1E307C9F2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 21:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6836532E697;
	Thu, 15 Jan 2026 21:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q9IJJNp0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/AghjZuh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874F132C92E;
	Thu, 15 Jan 2026 21:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513450; cv=none; b=t4ce48SNqk9ZJ0KPhMQNwvzS1gkuOOMGFM7Dy6NSmPvcTk2e90OqP+midFfg5Y3HmQy2dNvWF8Og0WmX//3gJGtH3SI0460hzOk3yzg6wQYM82hq0PGz0v061kf034MnDrfcMmikM/8DPVwz++wcKrp01nopRPs2uN50EOfh2c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513450; c=relaxed/simple;
	bh=GVCcB8ByOp9APvzaMEt7w9SW+KbjNH0WIGTTT6zcPbc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CUehYdE24N/bsy0GF+ID39pLsiIoGkB8distz3TyQwT81Cf01WnDSgd+zGotKfixfavhCbMGtckl245v3GHkZKxJ2nBozpV6QNWS/iouTPRXTuAtlwTehssmb4nYCYJyqCxn+eAaFzbTkXXsXKGdm4eLsgQ0sXA/9QFHgZpWpow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q9IJJNp0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/AghjZuh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Jan 2026 21:44:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768513447;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zBf8yiU0X1gYwNck9+NXFXrvc0sk23azQJRU9HKCrak=;
	b=Q9IJJNp0AEUsOfKRb3KMaIi8ZqEiebKzTRIDqSl91UNlgmO3IKvPhQo75p5J9GQZ2GizoG
	HAR3RH5AcnfmNw2xQVizasE93/GJdCJBjuSCGfSG3woMOVxquryR9l0u0qBqWzsH87usC2
	iC4b2cSpTvH6zkfhnaS+IMtIslYygCvU/mNKvA4nHQilQPeKNLpB2YUG7pXE+i+rcu+oWM
	AuTsyGs+/b+V1Orgl4w582xEnfgPccYJhd2g4L+cbdzboTYwpL1mabLSRZFYn2zsYEty2G
	uAJ6Jy/yYjku05y2UhGQuLMSF3RUuGMlAtQ+GMPPfKyIV0+pnJIdkBOHyAXwJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768513447;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zBf8yiU0X1gYwNck9+NXFXrvc0sk23azQJRU9HKCrak=;
	b=/AghjZuhY5E+EyB5cIpxqZJvPl1tZzUtZ34hiKj8MAD0VJGOsIgJV/STJSywr+jwkQjCdh
	0b7iXo623V7wc5Aw==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Add core PMU support for DMR
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260114011750.350569-4-dapeng1.mi@linux.intel.com>
References: <20260114011750.350569-4-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176851344573.510.12920503608954803158.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d345b6bb886004ac1018da0348b5da7d9906071b
Gitweb:        https://git.kernel.org/tip/d345b6bb886004ac1018da0348b5da7d990=
6071b
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 14 Jan 2026 09:17:46 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jan 2026 10:04:27 +01:00

perf/x86/intel: Add core PMU support for DMR

This patch enables core PMU features for Diamond Rapids (Panther Cove
microarchitecture), including Panther Cove specific counter and PEBS
constraints, a new cache events ID table, and the model-specific OMR
events extra registers table.

For detailed information about counter constraints, please refer to
section 16.3 "COUNTER RESTRICTIONS" in the ISE documentation.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260114011750.350569-4-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/core.c | 179 +++++++++++++++++++++++++++++++++-
 arch/x86/events/intel/ds.c   |  27 +++++-
 arch/x86/events/perf_event.h |   2 +-
 3 files changed, 207 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3578c66..b2f99d4 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -435,6 +435,62 @@ static struct extra_reg intel_lnc_extra_regs[] __read_mo=
stly =3D {
 	EVENT_EXTRA_END
 };
=20
+static struct event_constraint intel_pnc_event_constraints[] =3D {
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
+	INTEL_EVENT_CONSTRAINT(0x20, 0xf),
+	INTEL_EVENT_CONSTRAINT(0x79, 0xf),
+
+	INTEL_UEVENT_CONSTRAINT(0x0275, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x0176, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x04a4, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x08a4, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x01cd, 0xfc),
+	INTEL_UEVENT_CONSTRAINT(0x02cd, 0x3),
+
+	INTEL_EVENT_CONSTRAINT(0xd0, 0xf),
+	INTEL_EVENT_CONSTRAINT(0xd1, 0xf),
+	INTEL_EVENT_CONSTRAINT(0xd4, 0xf),
+	INTEL_EVENT_CONSTRAINT(0xd6, 0xf),
+	INTEL_EVENT_CONSTRAINT(0xdf, 0xf),
+	INTEL_EVENT_CONSTRAINT(0xce, 0x1),
+
+	INTEL_UEVENT_CONSTRAINT(0x01b1, 0x8),
+	INTEL_UEVENT_CONSTRAINT(0x0847, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x0446, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x0846, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x0148, 0xf),
+
+	EVENT_CONSTRAINT_END
+};
+
+static struct extra_reg intel_pnc_extra_regs[] __read_mostly =3D {
+	/* must define OMR_X first, see intel_alt_er() */
+	INTEL_UEVENT_EXTRA_REG(0x012a, MSR_OMR_0, 0x40ffffff0000ffffull, OMR_0),
+	INTEL_UEVENT_EXTRA_REG(0x022a, MSR_OMR_1, 0x40ffffff0000ffffull, OMR_1),
+	INTEL_UEVENT_EXTRA_REG(0x042a, MSR_OMR_2, 0x40ffffff0000ffffull, OMR_2),
+	INTEL_UEVENT_EXTRA_REG(0x082a, MSR_OMR_3, 0x40ffffff0000ffffull, OMR_3),
+	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x01cd),
+	INTEL_UEVENT_EXTRA_REG(0x02c6, MSR_PEBS_FRONTEND, 0x9, FE),
+	INTEL_UEVENT_EXTRA_REG(0x03c6, MSR_PEBS_FRONTEND, 0x7fff1f, FE),
+	INTEL_UEVENT_EXTRA_REG(0x40ad, MSR_PEBS_FRONTEND, 0xf, FE),
+	INTEL_UEVENT_EXTRA_REG(0x04c2, MSR_PEBS_FRONTEND, 0x8, FE),
+	EVENT_EXTRA_END
+};
+
 EVENT_ATTR_STR(mem-loads,	mem_ld_nhm,	"event=3D0x0b,umask=3D0x10,ldlat=3D3");
 EVENT_ATTR_STR(mem-loads,	mem_ld_snb,	"event=3D0xcd,umask=3D0x1,ldlat=3D3");
 EVENT_ATTR_STR(mem-stores,	mem_st_snb,	"event=3D0xcd,umask=3D0x2");
@@ -650,6 +706,102 @@ static __initconst const u64 glc_hw_cache_extra_regs
  },
 };
=20
+static __initconst const u64 pnc_hw_cache_event_ids
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] =3D
+{
+ [ C(L1D ) ] =3D {
+	[ C(OP_READ) ] =3D {
+		[ C(RESULT_ACCESS) ] =3D 0x81d0,
+		[ C(RESULT_MISS)   ] =3D 0xe124,
+	},
+	[ C(OP_WRITE) ] =3D {
+		[ C(RESULT_ACCESS) ] =3D 0x82d0,
+	},
+ },
+ [ C(L1I ) ] =3D {
+	[ C(OP_READ) ] =3D {
+		[ C(RESULT_MISS)   ] =3D 0xe424,
+	},
+	[ C(OP_WRITE) ] =3D {
+		[ C(RESULT_ACCESS) ] =3D -1,
+		[ C(RESULT_MISS)   ] =3D -1,
+	},
+ },
+ [ C(LL  ) ] =3D {
+	[ C(OP_READ) ] =3D {
+		[ C(RESULT_ACCESS) ] =3D 0x12a,
+		[ C(RESULT_MISS)   ] =3D 0x12a,
+	},
+	[ C(OP_WRITE) ] =3D {
+		[ C(RESULT_ACCESS) ] =3D 0x12a,
+		[ C(RESULT_MISS)   ] =3D 0x12a,
+	},
+ },
+ [ C(DTLB) ] =3D {
+	[ C(OP_READ) ] =3D {
+		[ C(RESULT_ACCESS) ] =3D 0x81d0,
+		[ C(RESULT_MISS)   ] =3D 0xe12,
+	},
+	[ C(OP_WRITE) ] =3D {
+		[ C(RESULT_ACCESS) ] =3D 0x82d0,
+		[ C(RESULT_MISS)   ] =3D 0xe13,
+	},
+ },
+ [ C(ITLB) ] =3D {
+	[ C(OP_READ) ] =3D {
+		[ C(RESULT_ACCESS) ] =3D -1,
+		[ C(RESULT_MISS)   ] =3D 0xe11,
+	},
+	[ C(OP_WRITE) ] =3D {
+		[ C(RESULT_ACCESS) ] =3D -1,
+		[ C(RESULT_MISS)   ] =3D -1,
+	},
+	[ C(OP_PREFETCH) ] =3D {
+		[ C(RESULT_ACCESS) ] =3D -1,
+		[ C(RESULT_MISS)   ] =3D -1,
+	},
+ },
+ [ C(BPU ) ] =3D {
+	[ C(OP_READ) ] =3D {
+		[ C(RESULT_ACCESS) ] =3D 0x4c4,
+		[ C(RESULT_MISS)   ] =3D 0x4c5,
+	},
+	[ C(OP_WRITE) ] =3D {
+		[ C(RESULT_ACCESS) ] =3D -1,
+		[ C(RESULT_MISS)   ] =3D -1,
+	},
+	[ C(OP_PREFETCH) ] =3D {
+		[ C(RESULT_ACCESS) ] =3D -1,
+		[ C(RESULT_MISS)   ] =3D -1,
+	},
+ },
+ [ C(NODE) ] =3D {
+	[ C(OP_READ) ] =3D {
+		[ C(RESULT_ACCESS) ] =3D -1,
+		[ C(RESULT_MISS)   ] =3D -1,
+	},
+ },
+};
+
+static __initconst const u64 pnc_hw_cache_extra_regs
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] =3D
+{
+ [ C(LL  ) ] =3D {
+	[ C(OP_READ) ] =3D {
+		[ C(RESULT_ACCESS) ] =3D 0x4000000000000001,
+		[ C(RESULT_MISS)   ] =3D 0xFFFFF000000001,
+	},
+	[ C(OP_WRITE) ] =3D {
+		[ C(RESULT_ACCESS) ] =3D 0x4000000000000002,
+		[ C(RESULT_MISS)   ] =3D 0xFFFFF000000002,
+	},
+ },
+};
+
 /*
  * Notes on the events:
  * - data reads do not include code reads (comparable to earlier tables)
@@ -7236,6 +7388,20 @@ static __always_inline void intel_pmu_init_lnc(struct =
pmu *pmu)
 	hybrid(pmu, extra_regs) =3D intel_lnc_extra_regs;
 }
=20
+static __always_inline void intel_pmu_init_pnc(struct pmu *pmu)
+{
+	intel_pmu_init_glc(pmu);
+	x86_pmu.flags &=3D ~PMU_FL_HAS_RSP_1;
+	x86_pmu.flags |=3D PMU_FL_HAS_OMR;
+	memcpy(hybrid_var(pmu, hw_cache_event_ids),
+	       pnc_hw_cache_event_ids, sizeof(hw_cache_event_ids));
+	memcpy(hybrid_var(pmu, hw_cache_extra_regs),
+	       pnc_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
+	hybrid(pmu, event_constraints) =3D intel_pnc_event_constraints;
+	hybrid(pmu, pebs_constraints) =3D intel_pnc_pebs_event_constraints;
+	hybrid(pmu, extra_regs) =3D intel_pnc_extra_regs;
+}
+
 static __always_inline void intel_pmu_init_skt(struct pmu *pmu)
 {
 	intel_pmu_init_grt(pmu);
@@ -7897,9 +8063,21 @@ __init int intel_pmu_init(void)
 		x86_pmu.extra_regs =3D intel_rwc_extra_regs;
 		pr_cont("Granite Rapids events, ");
 		name =3D "granite_rapids";
+		goto glc_common;
+
+	case INTEL_DIAMONDRAPIDS_X:
+		intel_pmu_init_pnc(NULL);
+		x86_pmu.pebs_latency_data =3D pnc_latency_data;
+
+		pr_cont("Panthercove events, ");
+		name =3D "panthercove";
+		goto glc_base;
=20
 	glc_common:
 		intel_pmu_init_glc(NULL);
+		intel_pmu_pebs_data_source_skl(true);
+
+	glc_base:
 		x86_pmu.pebs_ept =3D 1;
 		x86_pmu.hw_config =3D hsw_hw_config;
 		x86_pmu.get_event_constraints =3D glc_get_event_constraints;
@@ -7909,7 +8087,6 @@ __init int intel_pmu_init(void)
 		mem_attr =3D glc_events_attrs;
 		td_attr =3D glc_td_events_attrs;
 		tsx_attr =3D glc_tsx_events_attrs;
-		intel_pmu_pebs_data_source_skl(true);
 		break;
=20
 	case INTEL_ALDERLAKE:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 272e652..06e42ac 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1425,6 +1425,33 @@ struct event_constraint intel_lnc_pebs_event_constrain=
ts[] =3D {
 	EVENT_CONSTRAINT_END
 };
=20
+struct event_constraint intel_pnc_pebs_event_constraints[] =3D {
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_=
DIST */
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
+
+	INTEL_HYBRID_LDLAT_CONSTRAINT(0x1cd, 0xfc),
+	INTEL_HYBRID_STLAT_CONSTRAINT(0x2cd, 0x3),
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.S=
TLB_MISS_LOADS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x12d0, 0xf),	/* MEM_INST_RETIRED.S=
TLB_MISS_STORES */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x21d0, 0xf),	/* MEM_INST_RETIRED.L=
OCK_LOADS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x41d0, 0xf),	/* MEM_INST_RETIRED.S=
PLIT_LOADS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x42d0, 0xf),	/* MEM_INST_RETIRED.S=
PLIT_STORES */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x81d0, 0xf),	/* MEM_INST_RETIRED.A=
LL_LOADS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x82d0, 0xf),	/* MEM_INST_RETIRED.A=
LL_STORES */
+
+	INTEL_FLAGS_EVENT_CONSTRAINT_DATALA_LD_RANGE(0xd1, 0xd4, 0xf),
+
+	INTEL_FLAGS_EVENT_CONSTRAINT(0xd0, 0xf),
+	INTEL_FLAGS_EVENT_CONSTRAINT(0xd6, 0xf),
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
 	struct event_constraint *pebs_constraints =3D hybrid(event->pmu, pebs_const=
raints);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index bd501c2..cbca188 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1698,6 +1698,8 @@ extern struct event_constraint intel_glc_pebs_event_con=
straints[];
=20
 extern struct event_constraint intel_lnc_pebs_event_constraints[];
=20
+extern struct event_constraint intel_pnc_pebs_event_constraints[];
+
 struct event_constraint *intel_pebs_constraints(struct perf_event *event);
=20
 void intel_pmu_pebs_add(struct perf_event *event);

