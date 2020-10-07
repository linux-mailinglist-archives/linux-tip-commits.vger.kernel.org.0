Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1CE28631F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 18:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbgJGQEO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 12:04:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44494 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbgJGQEN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 12:04:13 -0400
Date:   Wed, 07 Oct 2020 16:04:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602086651;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KlPKTaARyCDG9FYnBKL8idkZdK3fqAnv74Ua3tIWnJk=;
        b=OMyBP3cStsDgj9+6rys+73k/U9vubot5qLUoOQcljBEyPUl9tOeqLghPsSs4Aq0BMCcHMJ
        Read+vSh0ZoBuv8pGUi692mjd1Av1uyrhh0j4dsxrZwsWDl4Sc1ktykqbsVzgVeRMBgCWb
        ilqjLTeyVzy/ka6mhXVsKoxlW2Dj8UGc4KWWY28bDCd07IXQ3VyUIWS/v12zOT/0DA07IE
        OJqclNecxFObKze72Px5TlKMJkmVP+GI4vAIkFwqHwET4eX2g+J6e8VVsbrtk0wCZJjzGf
        EcWmXsZDY3xRfANvy8UW5TbO9ZCZGEonbL2Z//CK8VK1WEvo5DCI2pZGl+jVJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602086651;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KlPKTaARyCDG9FYnBKL8idkZdK3fqAnv74Ua3tIWnJk=;
        b=9ZQDsbsOWDjTUv9i+0FeDQwDAbLYeQltbOIEE0vcHxDZo1tTVDTYnO/eG5P6gvZG/YC0QX
        hc3K/LEIIIPtN2Bw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Fix n_metric for cancelled txn
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201005082611.GH2628@hirez.programming.kicks-ass.net>
References: <20201005082611.GH2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <160208664989.7002.3685591670886543436.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3dbde69575637658d2094ee4416c21bc22eb89fe
Gitweb:        https://git.kernel.org/tip/3dbde69575637658d2094ee4416c21bc22eb89fe
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 05 Oct 2020 10:10:24 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Oct 2020 15:18:17 +02:00

perf/x86: Fix n_metric for cancelled txn

When a group that has TopDown members is failed to be scheduled, any
later TopDown groups will not return valid values.

Here is an example.

A background perf that occupies all the GP counters and the fixed
counter 1.
 $perf stat -e "{cycles,cycles,cycles,cycles,cycles,cycles,cycles,
                 cycles,cycles}:D" -a

A user monitors a TopDown group. It works well, because the fixed
counter 3 and the PERF_METRICS are available.
 $perf stat -x, --topdown -- ./workload
   retiring,bad speculation,frontend bound,backend bound,
   18.0,16.1,40.4,25.5,

Then the user tries to monitor a group that has TopDown members.
Because of the cycles event, the group is failed to be scheduled.
 $perf stat -x, -e '{slots,topdown-retiring,topdown-be-bound,
                     topdown-fe-bound,topdown-bad-spec,cycles}'
                     -- ./workload
    <not counted>,,slots,0,0.00,,
    <not counted>,,topdown-retiring,0,0.00,,
    <not counted>,,topdown-be-bound,0,0.00,,
    <not counted>,,topdown-fe-bound,0,0.00,,
    <not counted>,,topdown-bad-spec,0,0.00,,
    <not counted>,,cycles,0,0.00,,

The user tries to monitor a TopDown group again. It doesn't work anymore.
 $perf stat -x, --topdown -- ./workload

    ,,,,,

In a txn, cancel_txn() is to truncate the event_list for a canceled
group and update the number of events added in this transaction.
However, the number of TopDown events added in this transaction is not
updated. The kernel will probably fail to add new Topdown events.

Fixes: 7b2c05a15d29 ("perf/x86/intel: Generic support for hardware TopDown metrics")
Reported-by: Andi Kleen <ak@linux.intel.com>
Reported-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lkml.kernel.org/r/20201005082611.GH2628@hirez.programming.kicks-ass.net
---
 arch/x86/events/core.c       | 3 +++
 arch/x86/events/perf_event.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index a7248a3..7b802a7 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1041,6 +1041,7 @@ static int add_nr_metric_event(struct cpu_hw_events *cpuc,
 		if (cpuc->n_metric == INTEL_TD_METRIC_NUM)
 			return -EINVAL;
 		cpuc->n_metric++;
+		cpuc->n_txn_metric++;
 	}
 
 	return 0;
@@ -2009,6 +2010,7 @@ static void x86_pmu_start_txn(struct pmu *pmu, unsigned int txn_flags)
 	perf_pmu_disable(pmu);
 	__this_cpu_write(cpu_hw_events.n_txn, 0);
 	__this_cpu_write(cpu_hw_events.n_txn_pair, 0);
+	__this_cpu_write(cpu_hw_events.n_txn_metric, 0);
 }
 
 /*
@@ -2035,6 +2037,7 @@ static void x86_pmu_cancel_txn(struct pmu *pmu)
 	__this_cpu_sub(cpu_hw_events.n_added, __this_cpu_read(cpu_hw_events.n_txn));
 	__this_cpu_sub(cpu_hw_events.n_events, __this_cpu_read(cpu_hw_events.n_txn));
 	__this_cpu_sub(cpu_hw_events.n_pair, __this_cpu_read(cpu_hw_events.n_txn_pair));
+	__this_cpu_sub(cpu_hw_events.n_metric, __this_cpu_read(cpu_hw_events.n_txn_metric));
 	perf_pmu_enable(pmu);
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 93e56d7..ee2b9b9 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -236,6 +236,7 @@ struct cpu_hw_events {
 	int			n_txn;    /* the # last events in the below arrays;
 					     added in the current transaction */
 	int			n_txn_pair;
+	int			n_txn_metric;
 	int			assign[X86_PMC_IDX_MAX]; /* event to counter assignment */
 	u64			tags[X86_PMC_IDX_MAX];
 
