Return-Path: <linux-tip-commits+bounces-1604-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DF5928E77
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 23:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9368C1F26040
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 21:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80814145B1C;
	Fri,  5 Jul 2024 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Nq8u58E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="22Kgo+6n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C6B14037C;
	Fri,  5 Jul 2024 21:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213605; cv=none; b=hR2NRd6cJ0XkAqXZjQNu3vIgw+LYgkjoxabfUW8tA7ER1jXgSwxi7MSTJ37ln8axMbplPJ6FXdecPqFOJJbnXXp7XVjGOVAWY11n1FfbCCV0LBJTQJlmm7+rhTvs9wO5v1VJ9Gu2K8bKm5RKyKFaEBWdOW9T+CVNyuFECzFa32I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213605; c=relaxed/simple;
	bh=zqPvtKRL4OEtG7VIV6GYNCvm4hFT65AMLETx+cEMJT4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jKVIgMN0Vdbh9OIVtSxMLeyFZr2UqYKNx908L6orr+Pb1/VKTE+oLHr+22AVe50oAnDO1cJOVMtixKAlwuoFAG7Z/sCA9YUkFRL56mSaUVwfkSDW/E19o7PMYJeFV6qAm1KYpHcfQUeHwE9w7w53+c5vAfd9Y8iFtfwMvuim8Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Nq8u58E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=22Kgo+6n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Jul 2024 21:06:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720213602;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUgwa78N4Av1JmH74V+rsa0OURH53e8ABwDAma2BpgY=;
	b=2Nq8u58EDbz/QhBoLtHxUj//dBtBYpx6V6MIt7LKWzczEX5sfExACnJwJ6Yy6/+kSY0haN
	HaN5W1gTN95VZuF5LS1xKeLn+LrFr0i0Xp1ERxdrpsWUDzOx+A2s4I65TQIIwgT/UJtJUz
	9c5DQRbVSJ4T2P2csqC/m4F5LVMxNQIuWu0YJ331rw20XYqIx3gDqEXJbxFf9TD1AJw/dA
	gzmU7plZuUpGKeMyYMgKjzCMHyZZcwlvNhrmmwmM04vx7hnP34tp/7biaR4O1AmbMJArnG
	HUp5jcDX+4q0TgHC5nLq75o7D1ItUQTXwTizeeBIkDaIyRbfgGxR16FHXWYRog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720213602;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUgwa78N4Av1JmH74V+rsa0OURH53e8ABwDAma2BpgY=;
	b=22Kgo+6nsSFUxjT7kbbXrxOftNptkpl79R8jkunVSl+TfS4w2Fol4PVWkn+51joO917bai
	maDjo7G1q+6jzBAg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86: Add config_mask to represent EVENTSEL bitmask
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andi Kleen <ak@linux.intel.com>, Ian Rogers <irogers@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240626143545.480761-7-kan.liang@linux.intel.com>
References: <20240626143545.480761-7-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172021360174.2215.8803732920644612744.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e8fb5d6e765838e913253ef7c9b6fd8ec76c8d53
Gitweb:        https://git.kernel.org/tip/e8fb5d6e765838e913253ef7c9b6fd8ec76c8d53
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 26 Jun 2024 07:35:38 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Jul 2024 16:00:39 +02:00

perf/x86: Add config_mask to represent EVENTSEL bitmask

Different vendors may support different fields in EVENTSEL MSR, such as
Intel would introduce new fields umask2 and eq bits in EVENTSEL MSR
since Perfmon version 6. However, a fixed mask X86_RAW_EVENT_MASK is
used to filter the attr.config.

Introduce a new config_mask to record the real supported EVENTSEL
bitmask.
Only apply it to the existing code now. No functional change.

Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Link: https://lkml.kernel.org/r/20240626143545.480761-7-kan.liang@linux.intel.com
---
 arch/x86/events/core.c       | 5 ++++-
 arch/x86/events/intel/core.c | 1 +
 arch/x86/events/perf_event.h | 7 +++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 848dbe9..8ea1c98 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -624,7 +624,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 		event->hw.config |= ARCH_PERFMON_EVENTSEL_OS;
 
 	if (event->attr.type == event->pmu->type)
-		event->hw.config |= event->attr.config & X86_RAW_EVENT_MASK;
+		event->hw.config |= x86_pmu_get_event_config(event);
 
 	if (event->attr.sample_period && x86_pmu.limit_period) {
 		s64 left = event->attr.sample_period;
@@ -2098,6 +2098,9 @@ static int __init init_hw_perf_events(void)
 	if (!x86_pmu.intel_ctrl)
 		x86_pmu.intel_ctrl = x86_pmu.cntr_mask64;
 
+	if (!x86_pmu.config_mask)
+		x86_pmu.config_mask = X86_RAW_EVENT_MASK;
+
 	perf_events_lapic_init();
 	register_nmi_handler(NMI_LOCAL, perf_event_nmi_handler, 0, "PMI");
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 6a6f1f4..6e42ba0 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6144,6 +6144,7 @@ static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
 		pmu->cntr_mask64 = x86_pmu.cntr_mask64;
 		pmu->fixed_cntr_mask64 = x86_pmu.fixed_cntr_mask64;
 		pmu->pebs_events_mask = intel_pmu_pebs_mask(pmu->cntr_mask64);
+		pmu->config_mask = X86_RAW_EVENT_MASK;
 		pmu->unconstrained = (struct event_constraint)
 				     __EVENT_CONSTRAINT(0, pmu->cntr_mask64,
 							0, x86_pmu_num_counters(&pmu->pmu), 0, 0);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 493bc9f..55468ea 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -695,6 +695,7 @@ struct x86_hybrid_pmu {
 	union perf_capabilities		intel_cap;
 	u64				intel_ctrl;
 	u64				pebs_events_mask;
+	u64				config_mask;
 	union {
 			u64		cntr_mask64;
 			unsigned long	cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
@@ -790,6 +791,7 @@ struct x86_pmu {
 	int		(*rdpmc_index)(int index);
 	u64		(*event_map)(int);
 	int		max_events;
+	u64		config_mask;
 	union {
 			u64		cntr_mask64;
 			unsigned long	cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
@@ -1241,6 +1243,11 @@ static inline int x86_pmu_max_num_counters_fixed(struct pmu *pmu)
 	return fls64(hybrid(pmu, fixed_cntr_mask64));
 }
 
+static inline u64 x86_pmu_get_event_config(struct perf_event *event)
+{
+	return event->attr.config & hybrid(event->pmu, config_mask);
+}
+
 extern struct event_constraint emptyconstraint;
 
 extern struct event_constraint unconstrained;

