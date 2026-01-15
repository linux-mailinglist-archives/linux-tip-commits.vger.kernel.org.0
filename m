Return-Path: <linux-tip-commits+bounces-8018-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 102FED28CF0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 22:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 979D030239E5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 21:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD8632C316;
	Thu, 15 Jan 2026 21:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EX/Fu5MD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v8cBVh1f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1283A32ABE1;
	Thu, 15 Jan 2026 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513447; cv=none; b=Dazn8/TfOT44omU7cCRFV4Znl4dbUkzAznbnQjDSimVMAc5/XTMiBbHEclNNKzqa7x+khK4RbORFsI+bDoBz1gk74OrwGiEJb2VwBv4mYslgJwVJj3blBwej9bmbjZY0qCUqTbNj145zfEYqDMHZ+RROf7WMimvSlP8jM95MdvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513447; c=relaxed/simple;
	bh=Qva/85OKusk56nn169iQ+CsWCVJwwy1nI6FuN1Qew2A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A3l1S8ivsjqWS5Xmyy+yFkj31GnbnYOEu3LbaxJNSB/WgCS+DrhtLBYthVSPANmJtTTX2MzyEDigTG3m9w+Sbi52Pn7h0OcY0xA5nIuArGfh5dEmsO+Wfty1HBKxRUc0ox7Ik/hQDm5FssZT4uKBxXFbi7LjDn/bozcrRS9F+Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EX/Fu5MD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v8cBVh1f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Jan 2026 21:44:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768513444;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nfApqwDWj5ybFlS/Six2al7qRKmHMrn1XDI6ZV1KkbI=;
	b=EX/Fu5MD7qJozWSigLaHxZ7TD+YxnRJOOsTY4TwQfnG9a1HERNN6Hnd9+oduVvDvXjmFix
	ljAfDPRzQVk8b09FANkjpVXo4/L6+bzViWlJnYd7VHEg7UlvbNc0L4eagSYsLOkSrraz16
	cCgi2WDWhMSRswR/Gdwsg/AMdg+pkKvuGQPTlHATr6ptw88F14uo57qC55Cl6A3A5O5641
	gtotAn1HyhSgwnLJCRGucP4NgrHIM1wLC+iNU2P94/0v425gIDnXubfbfrIop8lxZ4Zwwo
	n45UHAlfDeGD+RDO3bzih+47CuUcHdcveJJqx4LUOpM7/2xQHB4iFqfUQQFjww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768513444;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nfApqwDWj5ybFlS/Six2al7qRKmHMrn1XDI6ZV1KkbI=;
	b=v8cBVh1fqFh02dnEmV9iL68I73x/wGPIkdyDZNGXooYjksltN/oRDgF4rLMW6JMBw/g9Rh
	XC5PGe2PQuTYHKAg==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Add core PMU support for Novalake
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260114011750.350569-6-dapeng1.mi@linux.intel.com>
References: <20260114011750.350569-6-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176851344330.510.4727758372037833642.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c847a208f43bfeb56943f2ca6fe2baf1db9dee7a
Gitweb:        https://git.kernel.org/tip/c847a208f43bfeb56943f2ca6fe2baf1db9=
dee7a
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 14 Jan 2026 09:17:48 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jan 2026 10:04:27 +01:00

perf/x86/intel: Add core PMU support for Novalake

This patch enables core PMU support for Novalake, covering both P-core
and E-core. It includes Arctic Wolf-specific counters and PEBS
constraints, and the model-specific OMR extra registers table.

Since Coyote Cove shares the same PMU capabilities as Panther Cove, the
existing Panther Cove PMU enabling functions are reused for Coyote Cove.

For detailed information about counter constraints, please refer to
section 16.3 "COUNTER RESTRICTIONS" in the ISE documentation.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260114011750.350569-6-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/core.c |  99 ++++++++++++++++++++++++++++++++++-
 arch/x86/events/intel/ds.c   |  11 ++++-
 arch/x86/events/perf_event.h |   2 +-
 3 files changed, 112 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b2f99d4..d6bdbb7 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -232,6 +232,29 @@ static struct event_constraint intel_skt_event_constrain=
ts[] __read_mostly =3D {
 	EVENT_CONSTRAINT_END
 };
=20
+static struct event_constraint intel_arw_event_constraints[] __read_mostly =
=3D {
+	FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* INST_RETIRED.ANY */
+	FIXED_EVENT_CONSTRAINT(0x003c, 1), /* CPU_CLK_UNHALTED.CORE */
+	FIXED_EVENT_CONSTRAINT(0x0300, 2), /* pseudo CPU_CLK_UNHALTED.REF */
+	FIXED_EVENT_CONSTRAINT(0x013c, 2), /* CPU_CLK_UNHALTED.REF_TSC_P */
+	FIXED_EVENT_CONSTRAINT(0x0073, 4), /* TOPDOWN_BAD_SPECULATION.ALL */
+	FIXED_EVENT_CONSTRAINT(0x019c, 5), /* TOPDOWN_FE_BOUND.ALL */
+	FIXED_EVENT_CONSTRAINT(0x02c2, 6), /* TOPDOWN_RETIRING.ALL */
+	INTEL_UEVENT_CONSTRAINT(0x01b7, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x02b7, 0x2),
+	INTEL_UEVENT_CONSTRAINT(0x04b7, 0x4),
+	INTEL_UEVENT_CONSTRAINT(0x08b7, 0x8),
+	INTEL_UEVENT_CONSTRAINT(0x01d4, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x02d4, 0x2),
+	INTEL_UEVENT_CONSTRAINT(0x04d4, 0x4),
+	INTEL_UEVENT_CONSTRAINT(0x08d4, 0x8),
+	INTEL_UEVENT_CONSTRAINT(0x0175, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x0275, 0x2),
+	INTEL_UEVENT_CONSTRAINT(0x21d3, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x22d3, 0x1),
+	EVENT_CONSTRAINT_END
+};
+
 static struct event_constraint intel_skl_event_constraints[] =3D {
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
 	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
@@ -2319,6 +2342,26 @@ static __initconst const u64 tnt_hw_cache_extra_regs
 	},
 };
=20
+static __initconst const u64 arw_hw_cache_extra_regs
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] =3D {
+	[C(LL)] =3D {
+		[C(OP_READ)] =3D {
+			[C(RESULT_ACCESS)]	=3D 0x4000000000000001,
+			[C(RESULT_MISS)]	=3D 0xFFFFF000000001,
+		},
+		[C(OP_WRITE)] =3D {
+			[C(RESULT_ACCESS)]	=3D 0x4000000000000002,
+			[C(RESULT_MISS)]	=3D 0xFFFFF000000002,
+		},
+		[C(OP_PREFETCH)] =3D {
+			[C(RESULT_ACCESS)]	=3D 0x0,
+			[C(RESULT_MISS)]	=3D 0x0,
+		},
+	},
+};
+
 EVENT_ATTR_STR(topdown-fe-bound,       td_fe_bound_tnt,        "event=3D0x71=
,umask=3D0x0");
 EVENT_ATTR_STR(topdown-retiring,       td_retiring_tnt,        "event=3D0xc2=
,umask=3D0x0");
 EVENT_ATTR_STR(topdown-bad-spec,       td_bad_spec_tnt,        "event=3D0x73=
,umask=3D0x6");
@@ -2377,6 +2420,22 @@ static struct extra_reg intel_cmt_extra_regs[] __read_=
mostly =3D {
 	EVENT_EXTRA_END
 };
=20
+static struct extra_reg intel_arw_extra_regs[] __read_mostly =3D {
+	/* must define OMR_X first, see intel_alt_er() */
+	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OMR_0, 0xc0ffffffffffffffull, OMR_0),
+	INTEL_UEVENT_EXTRA_REG(0x02b7, MSR_OMR_1, 0xc0ffffffffffffffull, OMR_1),
+	INTEL_UEVENT_EXTRA_REG(0x04b7, MSR_OMR_2, 0xc0ffffffffffffffull, OMR_2),
+	INTEL_UEVENT_EXTRA_REG(0x08b7, MSR_OMR_3, 0xc0ffffffffffffffull, OMR_3),
+	INTEL_UEVENT_EXTRA_REG(0x01d4, MSR_OMR_0, 0xc0ffffffffffffffull, OMR_0),
+	INTEL_UEVENT_EXTRA_REG(0x02d4, MSR_OMR_1, 0xc0ffffffffffffffull, OMR_1),
+	INTEL_UEVENT_EXTRA_REG(0x04d4, MSR_OMR_2, 0xc0ffffffffffffffull, OMR_2),
+	INTEL_UEVENT_EXTRA_REG(0x08d4, MSR_OMR_3, 0xc0ffffffffffffffull, OMR_3),
+	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x5d0),
+	INTEL_UEVENT_EXTRA_REG(0x0127, MSR_SNOOP_RSP_0, 0xffffffffffffffffull, SNOO=
P_0),
+	INTEL_UEVENT_EXTRA_REG(0x0227, MSR_SNOOP_RSP_1, 0xffffffffffffffffull, SNOO=
P_1),
+	EVENT_EXTRA_END
+};
+
 EVENT_ATTR_STR(topdown-fe-bound,       td_fe_bound_skt,        "event=3D0x9c=
,umask=3D0x01");
 EVENT_ATTR_STR(topdown-retiring,       td_retiring_skt,        "event=3D0xc2=
,umask=3D0x02");
 EVENT_ATTR_STR(topdown-be-bound,       td_be_bound_skt,        "event=3D0xa4=
,umask=3D0x02");
@@ -7410,6 +7469,19 @@ static __always_inline void intel_pmu_init_skt(struct =
pmu *pmu)
 	static_call_update(intel_pmu_enable_acr_event, intel_pmu_enable_acr);
 }
=20
+static __always_inline void intel_pmu_init_arw(struct pmu *pmu)
+{
+	intel_pmu_init_grt(pmu);
+	x86_pmu.flags &=3D ~PMU_FL_HAS_RSP_1;
+	x86_pmu.flags |=3D PMU_FL_HAS_OMR;
+	memcpy(hybrid_var(pmu, hw_cache_extra_regs),
+	       arw_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
+	hybrid(pmu, event_constraints) =3D intel_arw_event_constraints;
+	hybrid(pmu, pebs_constraints) =3D intel_arw_pebs_event_constraints;
+	hybrid(pmu, extra_regs) =3D intel_arw_extra_regs;
+	static_call_update(intel_pmu_enable_acr_event, intel_pmu_enable_acr);
+}
+
 __init int intel_pmu_init(void)
 {
 	struct attribute **extra_skl_attr =3D &empty_attrs;
@@ -8250,6 +8322,33 @@ __init int intel_pmu_init(void)
 		name =3D "arrowlake_h_hybrid";
 		break;
=20
+	case INTEL_NOVALAKE:
+	case INTEL_NOVALAKE_L:
+		pr_cont("Novalake Hybrid events, ");
+		name =3D "novalake_hybrid";
+		intel_pmu_init_hybrid(hybrid_big_small);
+
+		x86_pmu.pebs_latency_data =3D nvl_latency_data;
+		x86_pmu.get_event_constraints =3D mtl_get_event_constraints;
+		x86_pmu.hw_config =3D adl_hw_config;
+
+		td_attr =3D lnl_hybrid_events_attrs;
+		mem_attr =3D mtl_hybrid_mem_attrs;
+		tsx_attr =3D adl_hybrid_tsx_attrs;
+		extra_attr =3D boot_cpu_has(X86_FEATURE_RTM) ?
+			mtl_hybrid_extra_attr_rtm : mtl_hybrid_extra_attr;
+
+		/* Initialize big core specific PerfMon capabilities.*/
+		pmu =3D &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
+		intel_pmu_init_pnc(&pmu->pmu);
+
+		/* Initialize Atom core specific PerfMon capabilities.*/
+		pmu =3D &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
+		intel_pmu_init_arw(&pmu->pmu);
+
+		intel_pmu_pebs_data_source_lnl();
+		break;
+
 	default:
 		switch (x86_pmu.version) {
 		case 1:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index a47f173..5027afc 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1293,6 +1293,17 @@ struct event_constraint intel_grt_pebs_event_constrain=
ts[] =3D {
 	EVENT_CONSTRAINT_END
 };
=20
+struct event_constraint intel_arw_pebs_event_constraints[] =3D {
+	/* Allow all events as PEBS with no flags */
+	INTEL_HYBRID_LAT_CONSTRAINT(0x5d0, 0xff),
+	INTEL_HYBRID_LAT_CONSTRAINT(0x6d0, 0xff),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x01d4, 0x1),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x02d4, 0x2),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x04d4, 0x4),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x08d4, 0x8),
+	EVENT_CONSTRAINT_END
+};
+
 struct event_constraint intel_nehalem_pebs_event_constraints[] =3D {
 	INTEL_PLD_CONSTRAINT(0x100b, 0xf),      /* MEM_INST_RETIRED.* */
 	INTEL_FLAGS_EVENT_CONSTRAINT(0x0f, 0xf),    /* MEM_UNCORE_RETIRED.* */
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index aedc1a7..f7caabc 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1680,6 +1680,8 @@ extern struct event_constraint intel_glp_pebs_event_con=
straints[];
=20
 extern struct event_constraint intel_grt_pebs_event_constraints[];
=20
+extern struct event_constraint intel_arw_pebs_event_constraints[];
+
 extern struct event_constraint intel_nehalem_pebs_event_constraints[];
=20
 extern struct event_constraint intel_westmere_pebs_event_constraints[];

