Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596AE327BC1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Mar 2021 11:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhCAKRJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 1 Mar 2021 05:17:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58268 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbhCAKQ5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 1 Mar 2021 05:16:57 -0500
Date:   Mon, 01 Mar 2021 10:16:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614593771;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=khmLqBQcfQpD6uOJLI+2Kp9m2Osw5dxjB0EGqQ7nwik=;
        b=4g9F335ndLxvi2qv86MF31ni/fshKyRfssBgrso0+mNNVSmJd3fWDp6d6qN2RF9jL8znbr
        X4UbRSRujmTtjO8od+uozBWF2uJ7eLM5mYPJ+pMGz2ymZi/X1hBvHUiL9jrbr24eKOEZva
        jnbs6wh+4JDWw8gHFMTpMHy8WPvA6zHQ8Tov9ldb4dQjaQSXWuXivAsP1cmC1/x927jc7d
        xbhOQumJCGhkkUXBtTr1L/p4uiv8w9t+xdbXgINmLLTcjBmFWyq+dckFQF6cdNJDxHbo4t
        jyzcnVum2gjb6dciKlwkimM7MsyWcyUt3Rf4g4BSRwEtfEfXT8QGdQkn0gZlow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614593771;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=khmLqBQcfQpD6uOJLI+2Kp9m2Osw5dxjB0EGqQ7nwik=;
        b=Oew2ReWNYZpKxegV4S1xmgaNUkCzhxsicnguMGmp14yP84M0ARS29Dj9plJO/iFKUAE7cN
        I/FN5drijFep1kBA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Flush PMU internal buffers for per-CPU events
Cc:     Gabriel Marin <gmx@google.com>, Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201130193842.10569-1-kan.liang@linux.intel.com>
References: <20201130193842.10569-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161459377075.20312.13323336986510437328.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     e748d3716e0e581401630d36d3ef0fc8fa8f830d
Gitweb:        https://git.kernel.org/tip/e748d3716e0e581401630d36d3ef0fc8fa8f830d
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 30 Nov 2020 11:38:40 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Mar 2021 11:02:18 +01:00

perf/core: Flush PMU internal buffers for per-CPU events

Sometimes the PMU internal buffers have to be flushed for per-CPU events
during a context switch, e.g., large PEBS. Otherwise, the perf tool may
report samples in locations that do not belong to the process where the
samples are processed in, because PEBS does not tag samples with PID/TID.

The current code only flush the buffers for a per-task event. It doesn't
check a per-CPU event.

Add a new event state flag, PERF_ATTACH_SCHED_CB, to indicate that the
PMU internal buffers have to be flushed for this event during a context
switch.

Add sched_cb_entry and perf_sched_cb_usages back to track the PMU/cpuctx
which is required to be flushed.

Only need to invoke the sched_task() for per-CPU events in this patch.
The per-task events have been handled in perf_event_context_sched_in/out
already.

Fixes: 9c964efa4330 ("perf/x86/intel: Drain the PEBS buffer during context switches")
Reported-by: Gabriel Marin <gmx@google.com>
Originally-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201130193842.10569-1-kan.liang@linux.intel.com
---
 include/linux/perf_event.h |  2 ++-
 kernel/events/core.c       | 42 +++++++++++++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fab42cf..3f7f89e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -606,6 +606,7 @@ struct swevent_hlist {
 #define PERF_ATTACH_TASK	0x04
 #define PERF_ATTACH_TASK_DATA	0x08
 #define PERF_ATTACH_ITRACE	0x10
+#define PERF_ATTACH_SCHED_CB	0x20
 
 struct perf_cgroup;
 struct perf_buffer;
@@ -872,6 +873,7 @@ struct perf_cpu_context {
 	struct list_head		cgrp_cpuctx_entry;
 #endif
 
+	struct list_head		sched_cb_entry;
 	int				sched_cb_usage;
 
 	int				online;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0aeca5f..03db40f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -386,6 +386,7 @@ static DEFINE_MUTEX(perf_sched_mutex);
 static atomic_t perf_sched_count;
 
 static DEFINE_PER_CPU(atomic_t, perf_cgroup_events);
+static DEFINE_PER_CPU(int, perf_sched_cb_usages);
 static DEFINE_PER_CPU(struct pmu_event_list, pmu_sb_events);
 
 static atomic_t nr_mmap_events __read_mostly;
@@ -3461,11 +3462,16 @@ unlock:
 	}
 }
 
+static DEFINE_PER_CPU(struct list_head, sched_cb_list);
+
 void perf_sched_cb_dec(struct pmu *pmu)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
 
-	--cpuctx->sched_cb_usage;
+	this_cpu_dec(perf_sched_cb_usages);
+
+	if (!--cpuctx->sched_cb_usage)
+		list_del(&cpuctx->sched_cb_entry);
 }
 
 
@@ -3473,7 +3479,10 @@ void perf_sched_cb_inc(struct pmu *pmu)
 {
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(pmu->pmu_cpu_context);
 
-	cpuctx->sched_cb_usage++;
+	if (!cpuctx->sched_cb_usage++)
+		list_add(&cpuctx->sched_cb_entry, this_cpu_ptr(&sched_cb_list));
+
+	this_cpu_inc(perf_sched_cb_usages);
 }
 
 /*
@@ -3502,6 +3511,24 @@ static void __perf_pmu_sched_task(struct perf_cpu_context *cpuctx, bool sched_in
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 }
 
+static void perf_pmu_sched_task(struct task_struct *prev,
+				struct task_struct *next,
+				bool sched_in)
+{
+	struct perf_cpu_context *cpuctx;
+
+	if (prev == next)
+		return;
+
+	list_for_each_entry(cpuctx, this_cpu_ptr(&sched_cb_list), sched_cb_entry) {
+		/* will be handled in perf_event_context_sched_in/out */
+		if (cpuctx->task_ctx)
+			continue;
+
+		__perf_pmu_sched_task(cpuctx, sched_in);
+	}
+}
+
 static void perf_event_switch(struct task_struct *task,
 			      struct task_struct *next_prev, bool sched_in);
 
@@ -3524,6 +3551,9 @@ void __perf_event_task_sched_out(struct task_struct *task,
 {
 	int ctxn;
 
+	if (__this_cpu_read(perf_sched_cb_usages))
+		perf_pmu_sched_task(task, next, false);
+
 	if (atomic_read(&nr_switch_events))
 		perf_event_switch(task, next, false);
 
@@ -3832,6 +3862,9 @@ void __perf_event_task_sched_in(struct task_struct *prev,
 
 	if (atomic_read(&nr_switch_events))
 		perf_event_switch(task, prev, true);
+
+	if (__this_cpu_read(perf_sched_cb_usages))
+		perf_pmu_sched_task(prev, task, true);
 }
 
 static u64 perf_calculate_period(struct perf_event *event, u64 nsec, u64 count)
@@ -4656,7 +4689,7 @@ static void unaccount_event(struct perf_event *event)
 	if (event->parent)
 		return;
 
-	if (event->attach_state & PERF_ATTACH_TASK)
+	if (event->attach_state & (PERF_ATTACH_TASK | PERF_ATTACH_SCHED_CB))
 		dec = true;
 	if (event->attr.mmap || event->attr.mmap_data)
 		atomic_dec(&nr_mmap_events);
@@ -11175,7 +11208,7 @@ static void account_event(struct perf_event *event)
 	if (event->parent)
 		return;
 
-	if (event->attach_state & PERF_ATTACH_TASK)
+	if (event->attach_state & (PERF_ATTACH_TASK | PERF_ATTACH_SCHED_CB))
 		inc = true;
 	if (event->attr.mmap || event->attr.mmap_data)
 		atomic_inc(&nr_mmap_events);
@@ -12972,6 +13005,7 @@ static void __init perf_event_init_all_cpus(void)
 #ifdef CONFIG_CGROUP_PERF
 		INIT_LIST_HEAD(&per_cpu(cgrp_cpuctx_list, cpu));
 #endif
+		INIT_LIST_HEAD(&per_cpu(sched_cb_list, cpu));
 	}
 }
 
