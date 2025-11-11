Return-Path: <linux-tip-commits+bounces-7282-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCE3C4D6CD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 12:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A203A9558
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 11:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A54357738;
	Tue, 11 Nov 2025 11:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vdg23NZs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GJZosZmu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6A0357728;
	Tue, 11 Nov 2025 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861023; cv=none; b=EN/K/u2l8VPa3RF3ef/WpN0pbzzFmRuCtAG393IJKZ24c9OM7nZNxHD/n2GFae4Il8eFrgrCuWz1ehoG+AoLNN1oX6juW/Npy6lYIM9vsMrLifBRT5unMoQ0Z50SGz05wRX2ShV/GcUcaOE6WHzpa0MiFKTyyC1Ku0fpp7thmcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861023; c=relaxed/simple;
	bh=rtawBluZLKXbnO+D6zc4IH1dmac68Tf0R5e+Y2M/EzE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=utn8wOaD8L+dlvytgma5rMfCOt76yrS4lO2JS12c8vKuEa6Jco0ASCJIVe2Elht6gZ9hQP8cNN4yJypLdY7eMCpjBsiKe9/lFCz+G9GOs/psZr65/xcuNwjtLqkI1NDp/gkI77+SC+vg2uKzJoYcZtYHbCHTlp4vhNbYdlcF1GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vdg23NZs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GJZosZmu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:36:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762861018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=if3IBrycrV56tX9OVaxzKqBMYCE68101ZiPoUqOfFho=;
	b=Vdg23NZsjDLzGjB4Q0NHY7myXjnS4n8qKS1tmxPoNwBU8w8Ui3/r9VHq3W3KeWG8iDGzCl
	Gacp2+Fn4sfH8Q6qrzQzcQzFu26pdBDJ1TxGNDjTGWBUS2/NXZRF2D6Vq/0lOV7smZedRm
	nfPnyS+OBudoD2RkT2sx8m33y1tD+49Z7vF3YjuvQ/RXZuKms6hAYd1LgczYTlKdxrZLcz
	SjQqcY0pFY/UX8ONMIKfvtm+q1tD8gq7RK1E1batHfeJ5NE+BwveudvQxvLDJyyvJtdTbC
	qY4buAU+a1VtW77kxtwotEZqfwYDVev74/nkVt3FQjlhc0V7LNF0FakFdkc6jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762861018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=if3IBrycrV56tX9OVaxzKqBMYCE68101ZiPoUqOfFho=;
	b=GJZosZmuN7aHkNdl5yqB4i1lmrIkLX1i/ML4Z/O+cCO9owQbXnx/HJIgLIdVu1JUzQU984
	3mnxYZPJ1ciYq5Cw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Optimize PEBS extended config
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176286101706.498.3720120992640972850.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2093d8cf80fa5552d1025a78a8f3a10bf3b6466e
Gitweb:        https://git.kernel.org/tip/2093d8cf80fa5552d1025a78a8f3a10bf3b=
6466e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 07 Nov 2025 14:50:20 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 07 Nov 2025 15:08:23 +01:00

perf/x86/intel: Optimize PEBS extended config

Similar to enable_acr_event, avoid the branch.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/intel/core.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a421595..aad89c9 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2582,9 +2582,6 @@ static inline void __intel_pmu_update_event_ext(int idx=
, u64 ext)
=20
 static void intel_pmu_disable_event_ext(struct perf_event *event)
 {
-	if (!x86_pmu.arch_pebs)
-		return;
-
 	/*
 	 * Only clear CFG_C MSR for PEBS counter group events,
 	 * it avoids the HW counter's value to be added into
@@ -2602,6 +2599,8 @@ static void intel_pmu_disable_event_ext(struct perf_eve=
nt *event)
 	__intel_pmu_update_event_ext(event->hw.idx, 0);
 }
=20
+DEFINE_STATIC_CALL_NULL(intel_pmu_disable_event_ext, intel_pmu_disable_event=
_ext);
+
 static void intel_pmu_disable_event(struct perf_event *event)
 {
 	struct hw_perf_event *hwc =3D &event->hw;
@@ -2610,11 +2609,11 @@ static void intel_pmu_disable_event(struct perf_event=
 *event)
 	switch (idx) {
 	case 0 ... INTEL_PMC_IDX_FIXED - 1:
 		intel_clear_masks(event, idx);
-		intel_pmu_disable_event_ext(event);
+		static_call_cond(intel_pmu_disable_event_ext)(event);
 		x86_pmu_disable_event(event);
 		break;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
-		intel_pmu_disable_event_ext(event);
+		static_call_cond(intel_pmu_disable_event_ext)(event);
 		fallthrough;
 	case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_END:
 		intel_pmu_disable_fixed(event);
@@ -2990,9 +2989,6 @@ static void intel_pmu_enable_event_ext(struct perf_even=
t *event)
 	struct arch_pebs_cap cap;
 	u64 ext =3D 0;
=20
-	if (!x86_pmu.arch_pebs)
-		return;
-
 	cap =3D hybrid(cpuc->pmu, arch_pebs_cap);
=20
 	if (event->attr.precise_ip) {
@@ -3056,6 +3052,8 @@ static void intel_pmu_enable_event_ext(struct perf_even=
t *event)
 		__intel_pmu_update_event_ext(hwc->idx, ext);
 }
=20
+DEFINE_STATIC_CALL_NULL(intel_pmu_enable_event_ext, intel_pmu_enable_event_e=
xt);
+
 static void intel_pmu_enable_event(struct perf_event *event)
 {
 	u64 enable_mask =3D ARCH_PERFMON_EVENTSEL_ENABLE;
@@ -3071,12 +3069,12 @@ static void intel_pmu_enable_event(struct perf_event =
*event)
 			enable_mask |=3D ARCH_PERFMON_EVENTSEL_BR_CNTR;
 		intel_set_masks(event, idx);
 		static_call_cond(intel_pmu_enable_acr_event)(event);
-		intel_pmu_enable_event_ext(event);
+		static_call_cond(intel_pmu_enable_event_ext)(event);
 		__x86_pmu_enable_event(hwc, enable_mask);
 		break;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
 		static_call_cond(intel_pmu_enable_acr_event)(event);
-		intel_pmu_enable_event_ext(event);
+		static_call_cond(intel_pmu_enable_event_ext)(event);
 		fallthrough;
 	case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_END:
 		intel_pmu_enable_fixed(event);
@@ -8106,8 +8104,13 @@ __init int intel_pmu_init(void)
 	if (!is_hybrid() && boot_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
 		update_pmu_cap(NULL);
=20
-	if (x86_pmu.arch_pebs)
+	if (x86_pmu.arch_pebs) {
+		static_call_update(intel_pmu_disable_event_ext,
+				   intel_pmu_disable_event_ext);
+		static_call_update(intel_pmu_enable_event_ext,
+				   intel_pmu_enable_event_ext);
 		pr_cont("Architectural PEBS, ");
+	}
=20
 	intel_pmu_check_counters_mask(&x86_pmu.cntr_mask64,
 				      &x86_pmu.fixed_cntr_mask64,

