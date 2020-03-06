Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC3217C0BF
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Mar 2020 15:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgCFOmI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Mar 2020 09:42:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53736 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgCFOmI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEAr-0006FB-Ox; Fri, 06 Mar 2020 15:42:01 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5EADC1C21D5;
        Fri,  6 Mar 2020 15:42:01 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:01 -0000
From:   "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Add per perf_cpu_context min_heap storage
Cc:     Ian Rogers <irogers@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200214075133.181299-5-irogers@google.com>
References: <20200214075133.181299-5-irogers@google.com>
MIME-Version: 1.0
Message-ID: <158350572112.28353.5843586926290087112.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     836196beb377e59e54ec9e04f7402076ef7a8bd8
Gitweb:        https://git.kernel.org/tip/836196beb377e59e54ec9e04f7402076ef7a8bd8
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Thu, 13 Feb 2020 23:51:31 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 11:57:00 +01:00

perf/core: Add per perf_cpu_context min_heap storage

The storage required for visit_groups_merge's min heap needs to vary in
order to support more iterators, such as when multiple nested cgroups'
events are being visited. This change allows for 2 iterators and doesn't
support growth.

Based-on-work-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200214075133.181299-5-irogers@google.com
---
 include/linux/perf_event.h |  7 ++++++-
 kernel/events/core.c       | 43 +++++++++++++++++++++++++++----------
 2 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 68e21e8..8768a39 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -862,6 +862,13 @@ struct perf_cpu_context {
 	int				sched_cb_usage;
 
 	int				online;
+	/*
+	 * Per-CPU storage for iterators used in visit_groups_merge. The default
+	 * storage is of size 2 to hold the CPU and any CPU event iterators.
+	 */
+	int				heap_size;
+	struct perf_event		**heap;
+	struct perf_event		*heap_default[2];
 };
 
 struct perf_output_handle {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index ddfb06c..7529e76 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3423,22 +3423,34 @@ static void __heap_add(struct min_heap *heap, struct perf_event *event)
 	}
 }
 
-static noinline int visit_groups_merge(struct perf_event_groups *groups,
-				int cpu,
+static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
+				struct perf_event_groups *groups, int cpu,
 				int (*func)(struct perf_event *, void *),
 				void *data)
 {
 	/* Space for per CPU and/or any CPU event iterators. */
 	struct perf_event *itrs[2];
-	struct min_heap event_heap = {
-		.data = itrs,
-		.nr = 0,
-		.size = ARRAY_SIZE(itrs),
-	};
-	struct perf_event **evt = event_heap.data;
+	struct min_heap event_heap;
+	struct perf_event **evt;
 	int ret;
 
-	__heap_add(&event_heap, perf_event_groups_first(groups, -1));
+	if (cpuctx) {
+		event_heap = (struct min_heap){
+			.data = cpuctx->heap,
+			.nr = 0,
+			.size = cpuctx->heap_size,
+		};
+	} else {
+		event_heap = (struct min_heap){
+			.data = itrs,
+			.nr = 0,
+			.size = ARRAY_SIZE(itrs),
+		};
+		/* Events not within a CPU context may be on any CPU. */
+		__heap_add(&event_heap, perf_event_groups_first(groups, -1));
+	}
+	evt = event_heap.data;
+
 	__heap_add(&event_heap, perf_event_groups_first(groups, cpu));
 
 	min_heapify_all(&event_heap, &perf_min_heap);
@@ -3492,7 +3504,10 @@ ctx_pinned_sched_in(struct perf_event_context *ctx,
 {
 	int can_add_hw = 1;
 
-	visit_groups_merge(&ctx->pinned_groups,
+	if (ctx != &cpuctx->ctx)
+		cpuctx = NULL;
+
+	visit_groups_merge(cpuctx, &ctx->pinned_groups,
 			   smp_processor_id(),
 			   merge_sched_in, &can_add_hw);
 }
@@ -3503,7 +3518,10 @@ ctx_flexible_sched_in(struct perf_event_context *ctx,
 {
 	int can_add_hw = 1;
 
-	visit_groups_merge(&ctx->flexible_groups,
+	if (ctx != &cpuctx->ctx)
+		cpuctx = NULL;
+
+	visit_groups_merge(cpuctx, &ctx->flexible_groups,
 			   smp_processor_id(),
 			   merge_sched_in, &can_add_hw);
 }
@@ -10364,6 +10382,9 @@ skip_type:
 		cpuctx->online = cpumask_test_cpu(cpu, perf_online_mask);
 
 		__perf_mux_hrtimer_init(cpuctx, cpu);
+
+		cpuctx->heap_size = ARRAY_SIZE(cpuctx->heap_default);
+		cpuctx->heap = cpuctx->heap_default;
 	}
 
 got_cpu_context:
