Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CFD365697
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhDTKrV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51708 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbhDTKrT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:19 -0400
Date:   Tue, 20 Apr 2021 10:46:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915607;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ALH6LK+EMDJDxLyp+nFk6oYEXwVFVYbqoxtLCyAxqB4=;
        b=pSzq+O/Vc6rZEV6XOY7KyPFExDkqygJ7tJAbXsGDjff9BP7qrVsKB0MkRT7HHF2gjeISYW
        Sze2f6+KDmmgwGyrNzTJBV0QFcgnkSd3cb2GgioqcO0NbW8vX36q1OGt9cWshzwBfOnilP
        dwta9pf2C95t+eHloleQyNxpNYAO5kx35ZoP4LFEIoBFkDN9aUAKIgewYMDvu7c1uTFBrB
        emTW/9XHr/j1vUYi6p4iKcyaVXWwMHSZinmcL4xxZi4J1BYrPjZp0QEBQ1ynLDwBZNcXhA
        8uW0Xe5UBBXlEHXd/8C1I9BLFVbGtkdN2Otolp5yD5c23r+0LgtrtGZMT8opUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915607;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ALH6LK+EMDJDxLyp+nFk6oYEXwVFVYbqoxtLCyAxqB4=;
        b=Sr48ROhABa+7/tDvl0AG9Jm2JKCOiVEWAhv3PCThi0un6s/VwLSkTEC+IY50PqbqX0Seqc
        BGftlBbCrh8IxmDA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Hybrid PMU support for event constraints
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618237865-33448-10-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-10-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161891560686.29796.18068163848465309927.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     24ee38ffe61a68fc35065fcab1908883a34c866b
Gitweb:        https://git.kernel.org/tip/24ee38ffe61a68fc35065fcab1908883a34c866b
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 12 Apr 2021 07:30:49 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Apr 2021 20:03:25 +02:00

perf/x86: Hybrid PMU support for event constraints

The events are different among hybrid PMUs. Each hybrid PMU should use
its own event constraints.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/1618237865-33448-10-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/core.c       | 3 ++-
 arch/x86/events/intel/core.c | 5 +++--
 arch/x86/events/intel/ds.c   | 5 +++--
 arch/x86/events/perf_event.h | 2 ++
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index e8cb892..f92d234 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1518,6 +1518,7 @@ void perf_event_print_debug(void)
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 	int num_counters = hybrid(cpuc->pmu, num_counters);
 	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
+	struct event_constraint *pebs_constraints = hybrid(cpuc->pmu, pebs_constraints);
 	unsigned long flags;
 	int idx;
 
@@ -1537,7 +1538,7 @@ void perf_event_print_debug(void)
 		pr_info("CPU#%d: status:     %016llx\n", cpu, status);
 		pr_info("CPU#%d: overflow:   %016llx\n", cpu, overflow);
 		pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
-		if (x86_pmu.pebs_constraints) {
+		if (pebs_constraints) {
 			rdmsrl(MSR_IA32_PEBS_ENABLE, pebs);
 			pr_info("CPU#%d: pebs:       %016llx\n", cpu, pebs);
 		}
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4cfc382..447a80f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3136,10 +3136,11 @@ struct event_constraint *
 x86_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			  struct perf_event *event)
 {
+	struct event_constraint *event_constraints = hybrid(cpuc->pmu, event_constraints);
 	struct event_constraint *c;
 
-	if (x86_pmu.event_constraints) {
-		for_each_event_constraint(c, x86_pmu.event_constraints) {
+	if (event_constraints) {
+		for_each_event_constraint(c, event_constraints) {
 			if (constraint_match(c, event->hw.config)) {
 				event->hw.flags |= c->flags;
 				return c;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 312bf3b..f1402bc 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -959,13 +959,14 @@ struct event_constraint intel_spr_pebs_event_constraints[] = {
 
 struct event_constraint *intel_pebs_constraints(struct perf_event *event)
 {
+	struct event_constraint *pebs_constraints = hybrid(event->pmu, pebs_constraints);
 	struct event_constraint *c;
 
 	if (!event->attr.precise_ip)
 		return NULL;
 
-	if (x86_pmu.pebs_constraints) {
-		for_each_event_constraint(c, x86_pmu.pebs_constraints) {
+	if (pebs_constraints) {
+		for_each_event_constraint(c, pebs_constraints) {
 			if (constraint_match(c, event->hw.config)) {
 				event->hw.flags |= c->flags;
 				return c;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index b65cf46..34b7fc9 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -648,6 +648,8 @@ struct x86_hybrid_pmu {
 					[PERF_COUNT_HW_CACHE_MAX]
 					[PERF_COUNT_HW_CACHE_OP_MAX]
 					[PERF_COUNT_HW_CACHE_RESULT_MAX];
+	struct event_constraint		*event_constraints;
+	struct event_constraint		*pebs_constraints;
 };
 
 static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
