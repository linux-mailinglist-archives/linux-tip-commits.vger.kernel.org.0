Return-Path: <linux-tip-commits+bounces-7290-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CC7C4D736
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 12:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D1644F9640
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 11:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2EC358D29;
	Tue, 11 Nov 2025 11:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ls4gj2V9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tvqyoZzE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7DE3587D2;
	Tue, 11 Nov 2025 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861030; cv=none; b=cBJBuNoVnsoWGZ3AFi9yNr5x9pcWiiwVpHgySJVk4Bq8orelOld1EVO2uSr+GmeIk3QFJwPSf+5LLnIjubSvQQ5aPmAklrGxSaWm1GOaaGya2vWXXOU5k5feyn9tdX6uJHZ704WQ2ifFn5/JzN9e1TePClkXQjl8RYGrVN71a+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861030; c=relaxed/simple;
	bh=3lwwqIev7DNa19H29L2/NfeMeDAzJy2JLMXEuV4d10g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bDTZYhGpMsWBJr1JLL1O/hB2nDxxR4t4msxJRpbBwYx1skgMoFFwvBC/2KSTegpKpgwTxQoQB7x5FcqYsFKJAWPb4VcLdQP/RVgPO+koyc398r4nwB79GKw4pzfSnVG6iNaeAR74T40oA3vdbIdZNkTCWkCaCNzthkmv2O/FQ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ls4gj2V9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tvqyoZzE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:37:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762861027;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rU5sj1OjKHsQ6HCOCNWPujq500GIN9rYdZaIg21ZpII=;
	b=Ls4gj2V9j5Gt4HDkhqHfpgAdvM2NCETubuiPgs8JTfKik4q52o5FZCpxjJKfe8vkQ4MxyB
	wvSaK/eOCeveu4ZELe9SBJEwmsfEd88qvnXRX8uUo7ZEii8idfwI48u+zbr3g/43/vNSLu
	/HYvrvpichLaI0GfuWh474QWpW+T1KCeVKbfpG8VY/FwZskIOL3gyLXq35FiNshBwBvtqL
	l2mCQvj5dvDNgQVP+mrrDxamafPq2jDozoN9+eD+A7nGycSZglcyinB+WdtmXce6JgJCDP
	2gBgaeNm8K5AWrP51uHijPz49aRaCcBHdrXKS1FQjrJJBYHGjRFr2oUagp30eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762861027;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rU5sj1OjKHsQ6HCOCNWPujq500GIN9rYdZaIg21ZpII=;
	b=tvqyoZzEPu3fLkG5PBqV7d7bcJO5bj9Qd+nmUM1tzhQ/iCJ/TrHCULo8YqUZ4Rx5F+NJxv
	012DJ9FK//sX4nBA==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/ds: Factor out PEBS record processing
 code to functions
Cc: Kan Liang <kan.liang@linux.intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251029102136.61364-7-dapeng1.mi@linux.intel.com>
References: <20251029102136.61364-7-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176286102601.498.15038006095099546245.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8807d922705f0a137d8de5f636b50e7b4fbef155
Gitweb:        https://git.kernel.org/tip/8807d922705f0a137d8de5f636b50e7b4fb=
ef155
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 29 Oct 2025 18:21:30 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 07 Nov 2025 15:08:21 +01:00

perf/x86/intel/ds: Factor out PEBS record processing code to functions

Beside some PEBS record layout difference, arch-PEBS can share most of
PEBS record processing code with adaptive PEBS. Thus, factor out these
common processing code to independent inline functions, so they can be
reused by subsequent arch-PEBS handler.

Suggested-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251029102136.61364-7-dapeng1.mi@linux.intel.=
com
---
 arch/x86/events/intel/ds.c | 83 +++++++++++++++++++++++++------------
 1 file changed, 58 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 26e485e..c8aa72d 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2614,6 +2614,57 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *i=
regs, struct perf_sample_d
 	}
 }
=20
+static __always_inline void
+__intel_pmu_handle_pebs_record(struct pt_regs *iregs,
+			       struct pt_regs *regs,
+			       struct perf_sample_data *data,
+			       void *at, u64 pebs_status,
+			       short *counts, void **last,
+			       setup_fn setup_sample)
+{
+	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
+	struct perf_event *event;
+	int bit;
+
+	for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX) {
+		event =3D cpuc->events[bit];
+
+		if (WARN_ON_ONCE(!event) ||
+		    WARN_ON_ONCE(!event->attr.precise_ip))
+			continue;
+
+		if (counts[bit]++) {
+			__intel_pmu_pebs_event(event, iregs, regs, data,
+					       last[bit], setup_sample);
+		}
+
+		last[bit] =3D at;
+	}
+}
+
+static __always_inline void
+__intel_pmu_handle_last_pebs_record(struct pt_regs *iregs,
+				    struct pt_regs *regs,
+				    struct perf_sample_data *data,
+				    u64 mask, short *counts, void **last,
+				    setup_fn setup_sample)
+{
+	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
+	struct perf_event *event;
+	int bit;
+
+	for_each_set_bit(bit, (unsigned long *)&mask, X86_PMC_IDX_MAX) {
+		if (!counts[bit])
+			continue;
+
+		event =3D cpuc->events[bit];
+
+		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
+					    counts[bit], setup_sample);
+	}
+
+}
+
 static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_samp=
le_data *data)
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] =3D {};
@@ -2623,9 +2674,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *ir=
egs, struct perf_sample_d
 	struct x86_perf_regs perf_regs;
 	struct pt_regs *regs =3D &perf_regs.regs;
 	struct pebs_basic *basic;
-	struct perf_event *event;
 	void *base, *at, *top;
-	int bit;
 	u64 mask;
=20
 	if (!x86_pmu.pebs_active)
@@ -2638,6 +2687,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *ir=
egs, struct perf_sample_d
=20
 	mask =3D hybrid(cpuc->pmu, pebs_events_mask) |
 	       (hybrid(cpuc->pmu, fixed_cntr_mask64) << INTEL_PMC_IDX_FIXED);
+	mask &=3D cpuc->pebs_enabled;
=20
 	if (unlikely(base >=3D top)) {
 		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
@@ -2655,31 +2705,14 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *=
iregs, struct perf_sample_d
 		if (basic->format_size !=3D cpuc->pebs_record_size)
 			continue;
=20
-		pebs_status =3D basic->applicable_counters & cpuc->pebs_enabled & mask;
-		for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX) {
-			event =3D cpuc->events[bit];
-
-			if (WARN_ON_ONCE(!event) ||
-			    WARN_ON_ONCE(!event->attr.precise_ip))
-				continue;
-
-			if (counts[bit]++) {
-				__intel_pmu_pebs_event(event, iregs, regs, data, last[bit],
-						       setup_pebs_adaptive_sample_data);
-			}
-			last[bit] =3D at;
-		}
+		pebs_status =3D mask & basic->applicable_counters;
+		__intel_pmu_handle_pebs_record(iregs, regs, data, at,
+					       pebs_status, counts, last,
+					       setup_pebs_adaptive_sample_data);
 	}
=20
-	for_each_set_bit(bit, (unsigned long *)&mask, X86_PMC_IDX_MAX) {
-		if (!counts[bit])
-			continue;
-
-		event =3D cpuc->events[bit];
-
-		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
-					    counts[bit], setup_pebs_adaptive_sample_data);
-	}
+	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask, counts, last,
+					    setup_pebs_adaptive_sample_data);
 }
=20
 static void __init intel_arch_pebs_init(void)

