Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE15828631B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 18:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgJGQEN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 12:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbgJGQEM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 12:04:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC692C061755;
        Wed,  7 Oct 2020 09:04:12 -0700 (PDT)
Date:   Wed, 07 Oct 2020 16:04:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602086651;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QqkP4ozmsjm1e34Fwhos2WpKUdEvFJaZzGM9Kb+4drA=;
        b=pf1lGtPoFSANRIvq8hedfPiHzb9A9hX/AGpTBCadFsWt18r+UxXPnhLaVrrFI1td+OjGDB
        j0iGoAvzJvy6qO4g/DIHvvydy8JMZ06lrt1xP9lqBu+bf6oti3iGQt2Zf3sMwT7XpG5ly7
        SG9F9tC+n6Y7Hq5dCRAqt+eGUg/O4L7lqix7obHZ2+n+FY4O0HDFa56fmMvf2xiDf1Ip24
        lsjKGsMbN4buNqW0AieJ9qu4MEsP++oAoQe2vqpd2j3s8o3pA6kkAxB1Db//HyqvXMScAN
        f+TN/ShhZtNjc+zeYR9ktCuBQ3nZF+0dif06sHZ8Syblip9BzKphuHbf4vKQHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602086651;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QqkP4ozmsjm1e34Fwhos2WpKUdEvFJaZzGM9Kb+4drA=;
        b=+mHzWaYP4vJh+fK41IEFt9XF/Xr2uzBpaJ1xGTWzwXYAVmfiMNarP0AoeO5NPdXdFnm8ob
        yxIutPiZlbbit8AA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Fix n_pair for cancelled txn
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kim Phillips <kim.phillips@amd.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201005082516.GG2628@hirez.programming.kicks-ass.net>
References: <20201005082516.GG2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <160208665048.7002.3857289526917288291.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     871a93b0aad65a7f44ee25f2d17932ef6d559850
Gitweb:        https://git.kernel.org/tip/871a93b0aad65a7f44ee25f2d17932ef6d559850
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 05 Oct 2020 10:09:06 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Oct 2020 15:18:17 +02:00

perf/x86: Fix n_pair for cancelled txn

Kan reported that n_metric gets corrupted for cancelled transactions;
a similar issue exists for n_pair for AMD's Large Increment thing.

The problem was confirmed and confirmed fixed by Kim using:

  sudo perf stat -e "{cycles,cycles,cycles,cycles}:D" -a sleep 10 &

  # should succeed:
  sudo perf stat -e "{fp_ret_sse_avx_ops.all}:D" -a workload

  # should fail:
  sudo perf stat -e "{fp_ret_sse_avx_ops.all,fp_ret_sse_avx_ops.all,cycles}:D" -a workload

  # previously failed, now succeeds with this patch:
  sudo perf stat -e "{fp_ret_sse_avx_ops.all}:D" -a workload

Fixes: 5738891229a2 ("perf/x86/amd: Add support for Large Increment per Cycle Events")
Reported-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Kim Phillips <kim.phillips@amd.com>
Link: https://lkml.kernel.org/r/20201005082516.GG2628@hirez.programming.kicks-ass.net
---
 arch/x86/events/core.c       | 6 +++++-
 arch/x86/events/perf_event.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index cb5cfef..a7248a3 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1064,8 +1064,10 @@ static int collect_event(struct cpu_hw_events *cpuc, struct perf_event *event,
 		return -EINVAL;
 
 	cpuc->event_list[n] = event;
-	if (is_counter_pair(&event->hw))
+	if (is_counter_pair(&event->hw)) {
 		cpuc->n_pair++;
+		cpuc->n_txn_pair++;
+	}
 
 	return 0;
 }
@@ -2006,6 +2008,7 @@ static void x86_pmu_start_txn(struct pmu *pmu, unsigned int txn_flags)
 
 	perf_pmu_disable(pmu);
 	__this_cpu_write(cpu_hw_events.n_txn, 0);
+	__this_cpu_write(cpu_hw_events.n_txn_pair, 0);
 }
 
 /*
@@ -2031,6 +2034,7 @@ static void x86_pmu_cancel_txn(struct pmu *pmu)
 	 */
 	__this_cpu_sub(cpu_hw_events.n_added, __this_cpu_read(cpu_hw_events.n_txn));
 	__this_cpu_sub(cpu_hw_events.n_events, __this_cpu_read(cpu_hw_events.n_txn));
+	__this_cpu_sub(cpu_hw_events.n_pair, __this_cpu_read(cpu_hw_events.n_txn_pair));
 	perf_pmu_enable(pmu);
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 3454424..93e56d7 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -235,6 +235,7 @@ struct cpu_hw_events {
 					     they've never been enabled yet */
 	int			n_txn;    /* the # last events in the below arrays;
 					     added in the current transaction */
+	int			n_txn_pair;
 	int			assign[X86_PMC_IDX_MAX]; /* event to counter assignment */
 	u64			tags[X86_PMC_IDX_MAX];
 
