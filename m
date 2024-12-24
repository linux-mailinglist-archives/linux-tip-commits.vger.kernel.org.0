Return-Path: <linux-tip-commits+bounces-3136-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 073829FC179
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 19:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F611885478
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 18:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF949212FA8;
	Tue, 24 Dec 2024 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vvolaom3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YK6FZZmi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13EF212FA1;
	Tue, 24 Dec 2024 18:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066463; cv=none; b=GAcrwnjze5PFCvl3Dj75j1MVBQL6yPxHiHGAQ8DRzbd5yWH2jEH/D3r1OXkfYy9oUor0aS6QJ/7gvh39Xo83nydOapzFfrghNT1FtZEN0dooeVH7knt0XMtbZ/AR2NNKvYdUmbsqbC6emsy3JoK5jCMhkyCYHQLWNlAg0xWJ9xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066463; c=relaxed/simple;
	bh=dnzDOVjxV/Gce2/fHBqfRPXMd0poMn6jcLtzuPtYxtY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m2uwTVOc+RyJhfmReDXUoQte5xZN9+VKCz90yTLFn7wGF65Pl2uubQaCmqcHCwTTIiLeJC4TdjOtd3mpXkhaBT1QXyeAPEup60vWq5vCylB0jDXvduNAbnpivyKL4uKr+9WC7vDOO2zy70M6F7EmVbnWtwHOEF4I7qw0b0haGvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vvolaom3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YK6FZZmi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 18:54:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735066460;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYC0dRqN6tmKG7hMFE/Lnuy36svUF9LLpXQaw9WRAgc=;
	b=Vvolaom3ypcYUgpSkPu1VuYP2OLhdRhIlyzSHo6cR0pFql5gtiEQFGN8KV0lHId6usvGvX
	V+Dq9R9TcasXpigMKqBKltoA2Hs//TtOydBAq9zQ85KU7+uDvaqCtgqIGacCEpsKNLAWul
	Q/iKdETceYPHQP619qeTD9OkZk92MMIuj/l4/qtbFLaLBi7B6oZw9LWW8OfTgu0LqScNHg
	V9FED5hNCnSKmV+kdy64e2cqjF/K5ozzBsBQtZAAhIMwQzFjVAnHsYoHKjLD27EEtphM7Y
	f8Z8mxx741bdbdmNt8EDoBy+SvmXs/VWz/lma7nT72W6NKMzTlrJ7MIujLS9cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735066460;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYC0dRqN6tmKG7hMFE/Lnuy36svUF9LLpXQaw9WRAgc=;
	b=YK6FZZmi2h0+gcSEH2EZSS7Wj6p4+tDDj5HcdI4bDgFerTeWv0zo+0/wb4VCkXOEZOBOYs
	saePfCBlVGvGrLAA==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Support RDPMC metrics clear mode
Cc: Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ian Rogers <irogers@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241211160318.235056-1-kan.liang@linux.intel.com>
References: <20241211160318.235056-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173506645997.399.11828672369124040584.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0e45818ec1896c2b4aee0ec6721022ad625ea531
Gitweb:        https://git.kernel.org/tip/0e45818ec1896c2b4aee0ec6721022ad625ea531
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 11 Dec 2024 08:03:17 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Dec 2024 15:31:22 +01:00

perf/x86/intel: Support RDPMC metrics clear mode

The new RDPMC enhancement, metrics clear mode, is to clear the
PERF_METRICS-related resources as well as the fixed-function performance
monitoring counter 3 after the read is performed. It is available for
ring 3. The feature is enumerated by the
IA32_PERF_CAPABILITIES.RDPMC_CLEAR_METRICS[bit 19]. To enable the
feature, the IA32_FIXED_CTR_CTRL.METRICS_CLEAR_EN[bit 14] must be set.

Two ways were considered to enable the feature.
- Expose a knob in the sysfs globally. One user may affect the
  measurement of other users when changing the knob. The solution is
  dropped.
- Introduce a new event format, metrics_clear, for the slots event to
  disable/enable the feature only for the current process. Users can
  utilize the feature as needed.
The latter solution is implemented in the patch.

The current KVM doesn't support the perf metrics yet. For
virtualization, the feature can be enabled later separately.

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Link: https://lkml.kernel.org/r/20241211160318.235056-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c      | 20 +++++++++++++++++++-
 arch/x86/events/perf_event.h      |  1 +
 arch/x86/include/asm/perf_event.h |  4 ++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2e1e268..e76e892 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2816,6 +2816,9 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 			return;
 
 		idx = INTEL_PMC_IDX_FIXED_SLOTS;
+
+		if (event->attr.config1 & INTEL_TD_CFG_METRIC_CLEAR)
+			bits |= INTEL_FIXED_3_METRICS_CLEAR;
 	}
 
 	intel_set_masks(event, idx);
@@ -4071,7 +4074,12 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	 * is used in a metrics group, it too cannot support sampling.
 	 */
 	if (intel_pmu_has_cap(event, PERF_CAP_METRICS_IDX) && is_topdown_event(event)) {
-		if (event->attr.config1 || event->attr.config2)
+		/* The metrics_clear can only be set for the slots event */
+		if (event->attr.config1 &&
+		    (!is_slots_event(event) || (event->attr.config1 & ~INTEL_TD_CFG_METRIC_CLEAR)))
+			return -EINVAL;
+
+		if (event->attr.config2)
 			return -EINVAL;
 
 		/*
@@ -4680,6 +4688,8 @@ PMU_FORMAT_ATTR(in_tx,  "config:32"	);
 PMU_FORMAT_ATTR(in_tx_cp, "config:33"	);
 PMU_FORMAT_ATTR(eq,	"config:36"	); /* v6 + */
 
+PMU_FORMAT_ATTR(metrics_clear,	"config1:0"); /* PERF_CAPABILITIES.RDPMC_METRICS_CLEAR */
+
 static ssize_t umask2_show(struct device *dev,
 			   struct device_attribute *attr,
 			   char *page)
@@ -4699,6 +4709,7 @@ static struct device_attribute format_attr_umask2  =
 static struct attribute *format_evtsel_ext_attrs[] = {
 	&format_attr_umask2.attr,
 	&format_attr_eq.attr,
+	&format_attr_metrics_clear.attr,
 	NULL
 };
 
@@ -4723,6 +4734,13 @@ evtsel_ext_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 	if (i == 1)
 		return (mask & ARCH_PERFMON_EVENTSEL_EQ) ? attr->mode : 0;
 
+	/* PERF_CAPABILITIES.RDPMC_METRICS_CLEAR */
+	if (i == 2) {
+		union perf_capabilities intel_cap = hybrid(dev_get_drvdata(dev), intel_cap);
+
+		return intel_cap.rdpmc_metrics_clear ? attr->mode : 0;
+	}
+
 	return 0;
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 82c6f45..31c2771 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -624,6 +624,7 @@ union perf_capabilities {
 		u64	pebs_output_pt_available:1;
 		u64	pebs_timing_info:1;
 		u64	anythread_deprecated:1;
+		u64	rdpmc_metrics_clear:1;
 	};
 	u64	capabilities;
 };
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index cb9c467..1ac79f3 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -41,6 +41,7 @@
 #define INTEL_FIXED_0_USER				(1ULL << 1)
 #define INTEL_FIXED_0_ANYTHREAD			(1ULL << 2)
 #define INTEL_FIXED_0_ENABLE_PMI			(1ULL << 3)
+#define INTEL_FIXED_3_METRICS_CLEAR			(1ULL << 2)
 
 #define HSW_IN_TX					(1ULL << 32)
 #define HSW_IN_TX_CHECKPOINTED				(1ULL << 33)
@@ -372,6 +373,9 @@ static inline bool use_fixed_pseudo_encoding(u64 code)
 #define INTEL_TD_METRIC_MAX			INTEL_TD_METRIC_MEM_BOUND
 #define INTEL_TD_METRIC_NUM			8
 
+#define INTEL_TD_CFG_METRIC_CLEAR_BIT		0
+#define INTEL_TD_CFG_METRIC_CLEAR		BIT_ULL(INTEL_TD_CFG_METRIC_CLEAR_BIT)
+
 static inline bool is_metric_idx(int idx)
 {
 	return (unsigned)(idx - INTEL_PMC_IDX_METRIC_BASE) < INTEL_TD_METRIC_NUM;

