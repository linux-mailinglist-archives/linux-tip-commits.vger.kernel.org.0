Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268763888E5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 May 2021 10:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242185AbhESIEN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 May 2021 04:04:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37320 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbhESIEM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 May 2021 04:04:12 -0400
Date:   Wed, 19 May 2021 08:02:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621411372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ApUcNicZoisEOXRjUckVyOSaGO5Mrkui8I4jkGnNQpM=;
        b=LSSPAmq3B7fIJIYxHiLEOs/1jlCZqU/pR9MghhBFCbGB6dywKHsFYIqgA9OEPXZocnfv2a
        rLMC6tB1bowh2bzQ2mjILdoUUIDzO/6WCiSdkqD9NtbyelaYuElvdMjYNpmLqqvjUy/MS+
        xlHP/UYE7s4dgNPmFo9EuhNLQ2nCxMMwIns7uGM/Vvd7dL7UnSbrraUagLBnA8keYFBtuW
        GKD0gMDWhNNJf6gOtOjk0y+JuHWcPOqDYmntex/bVNJUSUlH8FTtale+XOmf1MjL5tIalD
        YUNcR3Kdiw1MHcZhhv+VCh2xTwwfYRx0TuIEj8rMTF7LsMziuN0uDQqhv5u70Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621411372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ApUcNicZoisEOXRjUckVyOSaGO5Mrkui8I4jkGnNQpM=;
        b=E6pWhh0l/IIZRBJ3fhUMUWK15SPY+89yuN8YJhWlufbH3Jz7foFQ51Cb1TksMebSFVPRR7
        I1CRfnd/iFfr3UAg==
From:   "tip-bot2 for Like Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/lbr: Remove cpuc->lbr_xsave allocation
 from atomic context
Cc:     Like Xu <like.xu@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210430052247.3079672-2-like.xu@linux.intel.com>
References: <20210430052247.3079672-2-like.xu@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162141137155.29796.7686353150201168120.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     488e13a489e9707a7e81e1991fdd1f20c0f04689
Gitweb:        https://git.kernel.org/tip/488e13a489e9707a7e81e1991fdd1f20c0f04689
Author:        Like Xu <like.xu@linux.intel.com>
AuthorDate:    Fri, 30 Apr 2021 13:22:47 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 May 2021 12:53:47 +02:00

perf/x86/lbr: Remove cpuc->lbr_xsave allocation from atomic context

If the kernel is compiled with the CONFIG_LOCKDEP option, the conditional
might_sleep_if() deep in kmem_cache_alloc() will generate the following
trace, and potentially cause a deadlock when another LBR event is added:

  [] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:196
  [] Call Trace:
  []  kmem_cache_alloc+0x36/0x250
  []  intel_pmu_lbr_add+0x152/0x170
  []  x86_pmu_add+0x83/0xd0

Make it symmetric with the release_lbr_buffers() call and mirror the
existing DS buffers.

Fixes: c085fb8774 ("perf/x86/intel/lbr: Support XSAVES for arch LBR read")
Signed-off-by: Like Xu <like.xu@linux.intel.com>
[peterz: simplified]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lkml.kernel.org/r/20210430052247.3079672-2-like.xu@linux.intel.com
---
 arch/x86/events/core.c       |  6 ++++--
 arch/x86/events/intel/lbr.c  | 26 ++++++++++++++++++++------
 arch/x86/events/perf_event.h |  6 ++++++
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8e50932..8f71dd7 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -396,10 +396,12 @@ int x86_reserve_hardware(void)
 	if (!atomic_inc_not_zero(&pmc_refcount)) {
 		mutex_lock(&pmc_reserve_mutex);
 		if (atomic_read(&pmc_refcount) == 0) {
-			if (!reserve_pmc_hardware())
+			if (!reserve_pmc_hardware()) {
 				err = -EBUSY;
-			else
+			} else {
 				reserve_ds_buffers();
+				reserve_lbr_buffers();
+			}
 		}
 		if (!err)
 			atomic_inc(&pmc_refcount);
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 76dbab6..4409d2c 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -658,7 +658,6 @@ static inline bool branch_user_callstack(unsigned br_sel)
 
 void intel_pmu_lbr_add(struct perf_event *event)
 {
-	struct kmem_cache *kmem_cache = event->pmu->task_ctx_cache;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
 	if (!x86_pmu.lbr_nr)
@@ -696,11 +695,6 @@ void intel_pmu_lbr_add(struct perf_event *event)
 	perf_sched_cb_inc(event->ctx->pmu);
 	if (!cpuc->lbr_users++ && !event->total_time_running)
 		intel_pmu_lbr_reset();
-
-	if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
-	    kmem_cache && !cpuc->lbr_xsave &&
-	    (cpuc->lbr_users != cpuc->lbr_pebs_users))
-		cpuc->lbr_xsave = kmem_cache_alloc(kmem_cache, GFP_KERNEL);
 }
 
 void release_lbr_buffers(void)
@@ -722,6 +716,26 @@ void release_lbr_buffers(void)
 	}
 }
 
+void reserve_lbr_buffers(void)
+{
+	struct kmem_cache *kmem_cache;
+	struct cpu_hw_events *cpuc;
+	int cpu;
+
+	if (!static_cpu_has(X86_FEATURE_ARCH_LBR))
+		return;
+
+	for_each_possible_cpu(cpu) {
+		cpuc = per_cpu_ptr(&cpu_hw_events, cpu);
+		kmem_cache = x86_get_pmu(cpu)->task_ctx_cache;
+		if (!kmem_cache || cpuc->lbr_xsave)
+			continue;
+
+		cpuc->lbr_xsave = kmem_cache_alloc_node(kmem_cache, GFP_KERNEL,
+							cpu_to_node(cpu));
+	}
+}
+
 void intel_pmu_lbr_del(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 27fa85e..ad87cb3 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1244,6 +1244,8 @@ void reserve_ds_buffers(void);
 
 void release_lbr_buffers(void);
 
+void reserve_lbr_buffers(void);
+
 extern struct event_constraint bts_constraint;
 extern struct event_constraint vlbr_constraint;
 
@@ -1393,6 +1395,10 @@ static inline void release_lbr_buffers(void)
 {
 }
 
+static inline void reserve_lbr_buffers(void)
+{
+}
+
 static inline int intel_pmu_init(void)
 {
 	return 0;
