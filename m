Return-Path: <linux-tip-commits+bounces-5033-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78022A91D23
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 15:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C875D3A953E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 13:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4020717A30C;
	Thu, 17 Apr 2025 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f/NqAhlg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fThLx9Eo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D17219ED;
	Thu, 17 Apr 2025 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894893; cv=none; b=CV257twA/mhoCCMzZkO1I4vZqVDyfejqm7QDYj9ixtAO1jwG3gXVdBr6Dv/JpWDmvew9LSjAXX52ojtihlrrv0gZYux4MHDGz2nTOY9bTcIC/EH1/G6JkvWVniuY9yfGTcQBhu/tbkmvPjvd9ygspY7XQbBktF+xP5R+d02+wf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894893; c=relaxed/simple;
	bh=8zeE6ER9thbn7uu/b37reA219Y6MgvfM9bjMdLqurAo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p6kxtIf1ONfW54Uyc92HcyHl/3saAHmO22jm9uRjL/c7LtCeMQhmT2UGj7UIUniUYt91gZ8ZlF4IfNStTYx8+2XlnxMbXDG90sU4WgdWKYXtao/cGwp77ZSX/kbP32n7jaYWOEHF/bYkHT1RxXGNCsY0xNcQBXsewnpmtjED3oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f/NqAhlg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fThLx9Eo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 13:00:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744894888;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZH2VcIDwIcZCakpFsRp1is/pE0QNjTjWITgokiFpI8=;
	b=f/NqAhlgqLZVKNHogPUeobtEVqUux5WzRZc74hDU25fjizTukEPhpkMkcj1z1xXVpdsUOf
	x2+Xwcg2TcwVAATFt+bAM7M61saKWWsHe7Z0EWHzVGp71CtdihNQ5ztNby2TqwkKv0wf7/
	xQssj7yJx7H57/zm+VZS5CLzKr6+DxhevD3TItgcY8IcDtRMKhYygLBBKcBWlcqqrXu6Cn
	bLj9HUrmWn89eOrzmLgYC2COSNjkQGIoBbJRZn6fcZTtwL0lx9Qb5d/lqvSDMoaspLPQdY
	TUz+mdioBbCYEyFRtDBfUmrsSxeDAshzA4xRjPYLfA9gPhyUP7jhNt1pB/nlLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744894888;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZH2VcIDwIcZCakpFsRp1is/pE0QNjTjWITgokiFpI8=;
	b=fThLx9Eop9ezLd/MRCk/qtnvo6sSxK+S4TjQUfl1N4VT5T5i1i9WSVDrK4rWXuRGOVRAul
	td4B5XdAW3QDxvCQ==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Introduce pairs of PEBS static calls
Cc: Peter Zijlstra <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250415114428.341182-7-dapeng1.mi@linux.intel.com>
References: <20250415114428.341182-7-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174489486019.31282.15944561064958141287.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4a3fd13054a98c43dfcfcbdb93deb43c7b1b9c34
Gitweb:        https://git.kernel.org/tip/4a3fd13054a98c43dfcfcbdb93deb43c7b1b9c34
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Tue, 15 Apr 2025 11:44:12 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 17 Apr 2025 14:21:24 +02:00

perf/x86/intel: Introduce pairs of PEBS static calls

Arch-PEBS retires IA32_PEBS_ENABLE and MSR_PEBS_DATA_CFG MSRs, so
intel_pmu_pebs_enable/disable() and intel_pmu_pebs_enable/disable_all()
are not needed to call for ach-PEBS.

To make the code cleaner, introduce static calls
x86_pmu_pebs_enable/disable() and x86_pmu_pebs_enable/disable_all()
instead of adding "x86_pmu.arch_pebs" check directly in these helpers.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20250415114428.341182-7-dapeng1.mi@linux.intel.com
---
 arch/x86/events/core.c       | 10 ++++++++++
 arch/x86/events/intel/core.c |  8 ++++----
 arch/x86/events/intel/ds.c   |  5 +++++
 arch/x86/events/perf_event.h |  8 ++++++++
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index cae2132..995df8f 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -95,6 +95,11 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_filter, *x86_pmu.filter);
 
 DEFINE_STATIC_CALL_NULL(x86_pmu_late_setup, *x86_pmu.late_setup);
 
+DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_enable, *x86_pmu.pebs_enable);
+DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_disable, *x86_pmu.pebs_disable);
+DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_enable_all, *x86_pmu.pebs_enable_all);
+DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_disable_all, *x86_pmu.pebs_disable_all);
+
 /*
  * This one is magic, it will get called even when PMU init fails (because
  * there is no PMU), in which case it should simply return NULL.
@@ -2049,6 +2054,11 @@ static void x86_pmu_static_call_update(void)
 	static_call_update(x86_pmu_filter, x86_pmu.filter);
 
 	static_call_update(x86_pmu_late_setup, x86_pmu.late_setup);
+
+	static_call_update(x86_pmu_pebs_enable, x86_pmu.pebs_enable);
+	static_call_update(x86_pmu_pebs_disable, x86_pmu.pebs_disable);
+	static_call_update(x86_pmu_pebs_enable_all, x86_pmu.pebs_enable_all);
+	static_call_update(x86_pmu_pebs_disable_all, x86_pmu.pebs_disable_all);
 }
 
 static void _x86_pmu_read(struct perf_event *event)
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7bbc7a7..cd63292 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2306,7 +2306,7 @@ static __always_inline void __intel_pmu_disable_all(bool bts)
 static __always_inline void intel_pmu_disable_all(void)
 {
 	__intel_pmu_disable_all(true);
-	intel_pmu_pebs_disable_all();
+	static_call_cond(x86_pmu_pebs_disable_all)();
 	intel_pmu_lbr_disable_all();
 }
 
@@ -2338,7 +2338,7 @@ static void __intel_pmu_enable_all(int added, bool pmi)
 
 static void intel_pmu_enable_all(int added)
 {
-	intel_pmu_pebs_enable_all();
+	static_call_cond(x86_pmu_pebs_enable_all)();
 	__intel_pmu_enable_all(added, false);
 }
 
@@ -2595,7 +2595,7 @@ static void intel_pmu_disable_event(struct perf_event *event)
 	 * so we don't trigger the event without PEBS bit set.
 	 */
 	if (unlikely(event->attr.precise_ip))
-		intel_pmu_pebs_disable(event);
+		static_call(x86_pmu_pebs_disable)(event);
 }
 
 static void intel_pmu_assign_event(struct perf_event *event, int idx)
@@ -2948,7 +2948,7 @@ static void intel_pmu_enable_event(struct perf_event *event)
 	int idx = hwc->idx;
 
 	if (unlikely(event->attr.precise_ip))
-		intel_pmu_pebs_enable(event);
+		static_call(x86_pmu_pebs_enable)(event);
 
 	switch (idx) {
 	case 0 ... INTEL_PMC_IDX_FIXED - 1:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 1d6b3fa..e216622 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2679,6 +2679,11 @@ void __init intel_pebs_init(void)
 		if (format < 4)
 			x86_pmu.intel_cap.pebs_baseline = 0;
 
+		x86_pmu.pebs_enable = intel_pmu_pebs_enable;
+		x86_pmu.pebs_disable = intel_pmu_pebs_disable;
+		x86_pmu.pebs_enable_all = intel_pmu_pebs_enable_all;
+		x86_pmu.pebs_disable_all = intel_pmu_pebs_disable_all;
+
 		switch (format) {
 		case 0:
 			pr_cont("PEBS fmt0%c, ", pebs_type);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 2ef407d..d201e6a 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -808,6 +808,10 @@ struct x86_pmu {
 	int		(*hw_config)(struct perf_event *event);
 	int		(*schedule_events)(struct cpu_hw_events *cpuc, int n, int *assign);
 	void		(*late_setup)(void);
+	void		(*pebs_enable)(struct perf_event *event);
+	void		(*pebs_disable)(struct perf_event *event);
+	void		(*pebs_enable_all)(void);
+	void		(*pebs_disable_all)(void);
 	unsigned	eventsel;
 	unsigned	perfctr;
 	unsigned	fixedctr;
@@ -1120,6 +1124,10 @@ DECLARE_STATIC_CALL(x86_pmu_set_period, *x86_pmu.set_period);
 DECLARE_STATIC_CALL(x86_pmu_update,     *x86_pmu.update);
 DECLARE_STATIC_CALL(x86_pmu_drain_pebs,	*x86_pmu.drain_pebs);
 DECLARE_STATIC_CALL(x86_pmu_late_setup,	*x86_pmu.late_setup);
+DECLARE_STATIC_CALL(x86_pmu_pebs_enable, *x86_pmu.pebs_enable);
+DECLARE_STATIC_CALL(x86_pmu_pebs_disable, *x86_pmu.pebs_disable);
+DECLARE_STATIC_CALL(x86_pmu_pebs_enable_all, *x86_pmu.pebs_enable_all);
+DECLARE_STATIC_CALL(x86_pmu_pebs_disable_all, *x86_pmu.pebs_disable_all);
 
 static __always_inline struct x86_perf_task_context_opt *task_context_opt(void *ctx)
 {

