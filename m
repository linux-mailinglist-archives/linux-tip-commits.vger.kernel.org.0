Return-Path: <linux-tip-commits+bounces-1606-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9E8928E7E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 23:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DB8C1C21504
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 21:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E92217625C;
	Fri,  5 Jul 2024 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PKVtt+df";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U+D33xpP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A812314A600;
	Fri,  5 Jul 2024 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213607; cv=none; b=EyEaM5g60K9y/0yMF0ea7dn1eQR0IGdrMRW5vlCC9WFwocXomIcY1PstkwybG+uWdxi1Z+Sbo/aeaWFIXdqTUfT7D0/Q1KTV1IER+YxnI6ZcNT3uj0xdx90TBRuwX0eFO/fVd4J2fOtzcHsNQIm/L5HjLZqJ4fwrT0o4Mu19P5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213607; c=relaxed/simple;
	bh=N1zSbwU7R1IOBGIKqlvVeGvRDaAJXi4mDc1LOFepUpE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ffqMo/+rOV2O7zdHTU2uhUGh0JXf/hnt+DCYB3PSVFMeSqEXKapjiatL0i5inPD9Qx8o1wk949eappFQFm4J8hh3HDw8y1zO1A1rcTD1IiDsppCMvUwHkk2A5N6hBrfeIQf62U5of1wBZsqGQWE6EtNvU01FmOmrcyujbYQYEJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PKVtt+df; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U+D33xpP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Jul 2024 21:06:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720213602;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d39w0uxsdxqi+AkX5ERSgWg5L95cUJFkLHXq4fjqPIk=;
	b=PKVtt+df6VQHO8tzsA4qTJcztW+C/oIHRrAXq94C7228liq8gtkZ46Gic507HrYvL+k9jp
	Z1aS4UZPErQnC/0nTQepbKgBskIXPv1Ll0fojYkEBildTv8hx+nXtvaC4J8j40SbBmyMKJ
	WProL70hTAsdZgCVmJqfsSF3oyzw3NRlxR8JJ8f4FU7sO4u83rKqStufEThfHFNzVUUsS9
	om89PNX4dp0SAO6GM8p4aKCO8C4pJ9ElDbbcGbhY1gIpsGVqDMoTsNcmf8QSMXuOaTbq5O
	SYgdQRH4YFGV+rA985ktTi+9yldgCaSAANruTLrHhA5DnLbVa77frm49xGmiHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720213602;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d39w0uxsdxqi+AkX5ERSgWg5L95cUJFkLHXq4fjqPIk=;
	b=U+D33xpPg59kwlN202wxWJ1SmU+NynlpjoNJBw09NcF/Qvwp9rK23KHGpZ0AmJcqd8oPVi
	ilw4GBEAWqi6MECA==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Rename model-specific
 pebs_latency_data functions
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, Ian Rogers <irogers@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240626143545.480761-5-kan.liang@linux.intel.com>
References: <20240626143545.480761-5-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172021360253.2215.10350520802480934697.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     090262439f66df03d4e9d0e52e14104b729e2ef8
Gitweb:        https://git.kernel.org/tip/090262439f66df03d4e9d0e52e14104b729e2ef8
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 26 Jun 2024 07:35:36 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Jul 2024 16:00:38 +02:00

perf/x86/intel: Rename model-specific pebs_latency_data functions

The model-specific pebs_latency_data functions of ADL and MTL use the
"small" as a postfix to indicate the e-core. The postfix is too generic
for a model-specific function. It cannot provide useful information that
can directly map it to a specific uarch, which can facilitate the
development and maintenance.
Use the abbr of the uarch to rename the model-specific functions.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Link: https://lkml.kernel.org/r/20240626143545.480761-5-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c |  8 ++++----
 arch/x86/events/intel/ds.c   | 20 ++++++++++----------
 arch/x86/events/perf_event.h |  4 ++--
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 224430e..35f2d52 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6509,7 +6509,7 @@ __init int intel_pmu_init(void)
 	case INTEL_ATOM_GRACEMONT:
 		intel_pmu_init_grt(NULL);
 		intel_pmu_pebs_data_source_grt();
-		x86_pmu.pebs_latency_data = adl_latency_data_small;
+		x86_pmu.pebs_latency_data = grt_latency_data;
 		x86_pmu.get_event_constraints = tnt_get_event_constraints;
 		td_attr = tnt_events_attrs;
 		mem_attr = grt_mem_attrs;
@@ -6523,7 +6523,7 @@ __init int intel_pmu_init(void)
 		intel_pmu_init_grt(NULL);
 		x86_pmu.extra_regs = intel_cmt_extra_regs;
 		intel_pmu_pebs_data_source_cmt();
-		x86_pmu.pebs_latency_data = mtl_latency_data_small;
+		x86_pmu.pebs_latency_data = cmt_latency_data;
 		x86_pmu.get_event_constraints = cmt_get_event_constraints;
 		td_attr = cmt_events_attrs;
 		mem_attr = grt_mem_attrs;
@@ -6874,7 +6874,7 @@ __init int intel_pmu_init(void)
 		 */
 		intel_pmu_init_hybrid(hybrid_big_small);
 
-		x86_pmu.pebs_latency_data = adl_latency_data_small;
+		x86_pmu.pebs_latency_data = grt_latency_data;
 		x86_pmu.get_event_constraints = adl_get_event_constraints;
 		x86_pmu.hw_config = adl_hw_config;
 		x86_pmu.get_hybrid_cpu_type = adl_get_hybrid_cpu_type;
@@ -6931,7 +6931,7 @@ __init int intel_pmu_init(void)
 	case INTEL_METEORLAKE_L:
 		intel_pmu_init_hybrid(hybrid_big_small);
 
-		x86_pmu.pebs_latency_data = mtl_latency_data_small;
+		x86_pmu.pebs_latency_data = cmt_latency_data;
 		x86_pmu.get_event_constraints = mtl_get_event_constraints;
 		x86_pmu.hw_config = adl_hw_config;
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 79e23de..3581c27 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -257,8 +257,8 @@ static inline void pebs_set_tlb_lock(u64 *val, bool tlb, bool lock)
 }
 
 /* Retrieve the latency data for e-core of ADL */
-static u64 __adl_latency_data_small(struct perf_event *event, u64 status,
-				     u8 dse, bool tlb, bool lock, bool blk)
+static u64 __grt_latency_data(struct perf_event *event, u64 status,
+			       u8 dse, bool tlb, bool lock, bool blk)
 {
 	u64 val;
 
@@ -277,27 +277,27 @@ static u64 __adl_latency_data_small(struct perf_event *event, u64 status,
 	return val;
 }
 
-u64 adl_latency_data_small(struct perf_event *event, u64 status)
+u64 grt_latency_data(struct perf_event *event, u64 status)
 {
 	union intel_x86_pebs_dse dse;
 
 	dse.val = status;
 
-	return __adl_latency_data_small(event, status, dse.ld_dse,
-					dse.ld_locked, dse.ld_stlb_miss,
-					dse.ld_data_blk);
+	return __grt_latency_data(event, status, dse.ld_dse,
+				  dse.ld_locked, dse.ld_stlb_miss,
+				  dse.ld_data_blk);
 }
 
 /* Retrieve the latency data for e-core of MTL */
-u64 mtl_latency_data_small(struct perf_event *event, u64 status)
+u64 cmt_latency_data(struct perf_event *event, u64 status)
 {
 	union intel_x86_pebs_dse dse;
 
 	dse.val = status;
 
-	return __adl_latency_data_small(event, status, dse.mtl_dse,
-					dse.mtl_stlb_miss, dse.mtl_locked,
-					dse.mtl_fwd_blk);
+	return __grt_latency_data(event, status, dse.mtl_dse,
+				  dse.mtl_stlb_miss, dse.mtl_locked,
+				  dse.mtl_fwd_blk);
 }
 
 static u64 load_latency_data(struct perf_event *event, u64 status)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index b7195ee..fc25619 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1548,9 +1548,9 @@ void intel_pmu_disable_bts(void);
 
 int intel_pmu_drain_bts_buffer(void);
 
-u64 adl_latency_data_small(struct perf_event *event, u64 status);
+u64 grt_latency_data(struct perf_event *event, u64 status);
 
-u64 mtl_latency_data_small(struct perf_event *event, u64 status);
+u64 cmt_latency_data(struct perf_event *event, u64 status);
 
 extern struct event_constraint intel_core2_pebs_event_constraints[];
 

