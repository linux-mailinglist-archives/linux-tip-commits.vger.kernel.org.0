Return-Path: <linux-tip-commits+bounces-4752-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F993A8155D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB9B8A1F46
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4E7245027;
	Tue,  8 Apr 2025 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="abahP1od";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pPNliHrl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7B123FC6D;
	Tue,  8 Apr 2025 19:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139104; cv=none; b=IdCSyoHjxl8yFrpOmNd8aSAel00i+jenS72XrFj2uD1kvoKokjkrsQwQq5wc+k0cYGzJuh7fxEpEEPv3VCvyvisn3012J6GWcY2pEUs6wOR81xRB5szWiB0cdJs/Sm9mi4tO18bB5SYG1KF41xe7mg+JDtPrgurx97PkcNv3JR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139104; c=relaxed/simple;
	bh=s+evPkGMB2EjG5yJYcn8p86MxrJS69bPDbmalgLTUOA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uRJDgutsbPb3QQ3iG8ni7feAa9yTJt8CtYL02rnhe7uV4RZSIy7BX962Zfeq6H3iunwyO6FfD2/fSIrhGuXWdBUUohLmIx/oIpgE2VUFEe+yJpDDmOJ6a0DzgUiwAH6Bggqlr+TLWSOtv9jIywCLJC4LnvkFrZnjrVQcaG+YIqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=abahP1od; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pPNliHrl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:04:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139100;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w4JKswxk+rSC5t9LiAJgTNTYxRIH+H7+OERZuRJyFTo=;
	b=abahP1odzyt4dnxaNPO0yY2OOFGk4etRdg0lIaesqZzR/zDHEgccd+avQS5P+1sjBuZJIa
	KFuiuD5IJzaZY6+IEU4si+qwsbwGpBNc2ppGVymzZxaaVtamDuC0LgwTI7evVxxDnmGCxX
	CNerRhVCvJQFl5lWPPLT4Nu4gHb7n0umz3M1LDM7PZpp9aE+ZdRJjHNLO68bGBbvQnZydY
	qfiSblzCXJ1s4PtE2derx705oK/DD6r/tT9ITlJgPlUAE8kkCuz8Ug2taRxHG34G8pbri2
	eszlyS+HLr4BAsI0lFNc3z7qO9FCAnWo7RNr5/UPr2JUpRpGEvrBRk0g0WQjfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139100;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w4JKswxk+rSC5t9LiAJgTNTYxRIH+H7+OERZuRJyFTo=;
	b=pPNliHrlMqDP2NSkK1V0pHdwWhyV4isSnxR0CSTrbDVxXrcMbczxL7KoxpefMWm2OeVfcc
	Febz5wlLDH3SEAAg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Add dynamic constraint
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Falcon <thomas.falcon@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250327195217.2683619-2-kan.liang@linux.intel.com>
References: <20250327195217.2683619-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413909966.31282.14537140922539948654.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4dfe3232cc04325a09e96f6c7f9546ba6c0b132b
Gitweb:        https://git.kernel.org/tip/4dfe3232cc04325a09e96f6c7f9546ba6c0b132b
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 27 Mar 2025 12:52:13 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:48 +02:00

perf/x86: Add dynamic constraint

More and more features require a dynamic event constraint, e.g., branch
counter logging, auto counter reload, Arch PEBS, etc.

Add a generic flag, PMU_FL_DYN_CONSTRAINT, to indicate the case. It
avoids keeping adding the individual flag in intel_cpuc_prepare().

Add a variable dyn_constraint in the struct hw_perf_event to track the
dynamic constraint of the event. Apply it if it's updated.

Apply the generic dynamic constraint for branch counter logging.
Many features on and after V6 require dynamic constraint. So
unconditionally set the flag for V6+.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Link: https://lkml.kernel.org/r/20250327195217.2683619-2-kan.liang@linux.intel.com
---
 arch/x86/events/core.c       |  1 +
 arch/x86/events/intel/core.c | 21 +++++++++++++++------
 arch/x86/events/intel/lbr.c  |  2 +-
 arch/x86/events/perf_event.h |  1 +
 include/linux/perf_event.h   |  1 +
 5 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 6866cc5..a0fe51e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -674,6 +674,7 @@ static int __x86_pmu_event_init(struct perf_event *event)
 	event->hw.idx = -1;
 	event->hw.last_cpu = -1;
 	event->hw.last_tag = ~0ULL;
+	event->hw.dyn_constraint = ~0ULL;
 
 	/* mark unused */
 	event->hw.extra_reg.idx = EXTRA_REG_NONE;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 09d2d66..9724928 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3730,10 +3730,9 @@ intel_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	if (cpuc->excl_cntrs)
 		return intel_get_excl_constraints(cpuc, event, idx, c2);
 
-	/* Not all counters support the branch counter feature. */
-	if (branch_sample_counters(event)) {
+	if (event->hw.dyn_constraint != ~0ULL) {
 		c2 = dyn_constraint(cpuc, c2, idx);
-		c2->idxmsk64 &= x86_pmu.lbr_counters;
+		c2->idxmsk64 &= event->hw.dyn_constraint;
 		c2->weight = hweight64(c2->idxmsk64);
 	}
 
@@ -4135,15 +4134,19 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		leader = event->group_leader;
 		if (branch_sample_call_stack(leader))
 			return -EINVAL;
-		if (branch_sample_counters(leader))
+		if (branch_sample_counters(leader)) {
 			num++;
+			leader->hw.dyn_constraint &= x86_pmu.lbr_counters;
+		}
 		leader->hw.flags |= PERF_X86_EVENT_BRANCH_COUNTERS;
 
 		for_each_sibling_event(sibling, leader) {
 			if (branch_sample_call_stack(sibling))
 				return -EINVAL;
-			if (branch_sample_counters(sibling))
+			if (branch_sample_counters(sibling)) {
 				num++;
+				sibling->hw.dyn_constraint &= x86_pmu.lbr_counters;
+			}
 		}
 
 		if (num > fls(x86_pmu.lbr_counters))
@@ -4943,7 +4946,7 @@ int intel_cpuc_prepare(struct cpu_hw_events *cpuc, int cpu)
 			goto err;
 	}
 
-	if (x86_pmu.flags & (PMU_FL_EXCL_CNTRS | PMU_FL_TFA | PMU_FL_BR_CNTR)) {
+	if (x86_pmu.flags & (PMU_FL_EXCL_CNTRS | PMU_FL_TFA | PMU_FL_DYN_CONSTRAINT)) {
 		size_t sz = X86_PMC_IDX_MAX * sizeof(struct event_constraint);
 
 		cpuc->constraint_list = kzalloc_node(sz, GFP_KERNEL, cpu_to_node(cpu));
@@ -6665,6 +6668,12 @@ __init int intel_pmu_init(void)
 	}
 
 	/*
+	 * Many features on and after V6 require dynamic constraint,
+	 * e.g., Arch PEBS, ACR.
+	 */
+	if (version >= 6)
+		x86_pmu.flags |= PMU_FL_DYN_CONSTRAINT;
+	/*
 	 * Install the hw-cache-events table:
 	 */
 	switch (boot_cpu_data.x86_vfm) {
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index f44c3d8..05acd64 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1618,7 +1618,7 @@ void __init intel_pmu_arch_lbr_init(void)
 	x86_pmu.lbr_nr = lbr_nr;
 
 	if (!!x86_pmu.lbr_counters)
-		x86_pmu.flags |= PMU_FL_BR_CNTR;
+		x86_pmu.flags |= PMU_FL_BR_CNTR | PMU_FL_DYN_CONSTRAINT;
 
 	if (x86_pmu.lbr_mispred)
 		static_branch_enable(&x86_lbr_mispred);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 2c0ce0e..f5ba165 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1042,6 +1042,7 @@ do {									\
 #define PMU_FL_MEM_LOADS_AUX	0x100 /* Require an auxiliary event for the complete memory info */
 #define PMU_FL_RETIRE_LATENCY	0x200 /* Support Retire Latency in PEBS */
 #define PMU_FL_BR_CNTR		0x400 /* Support branch counter logging */
+#define PMU_FL_DYN_CONSTRAINT	0x800 /* Needs dynamic constraint */
 
 #define EVENT_VAR(_id)  event_attr_##_id
 #define EVENT_PTR(_id) &event_attr_##_id.attr.attr
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7f49a58..54dad17 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -158,6 +158,7 @@ struct hw_perf_event {
 		struct { /* hardware */
 			u64		config;
 			u64		last_tag;
+			u64		dyn_constraint;
 			unsigned long	config_base;
 			unsigned long	event_base;
 			int		event_base_rdpmc;

