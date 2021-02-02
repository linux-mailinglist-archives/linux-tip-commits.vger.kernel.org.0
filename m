Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7055730BD86
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Feb 2021 12:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhBBL5r (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Feb 2021 06:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhBBL5q (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Feb 2021 06:57:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7D8C06174A;
        Tue,  2 Feb 2021 03:57:06 -0800 (PST)
Date:   Tue, 02 Feb 2021 11:57:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612267024;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m6q+4p5JkKPBP4kESQCecc9+ZnG9KZQnmraRQ6y4+zQ=;
        b=f5y7XaJOn6//LZ7madaawL2byMYl7lNgLa8Ey8b0hb4ZebgZDDpBfhYTvn9qMr0w8sPhwY
        wbnS/LhlQdq5gkGL3ealxAAPsbILH9CPj8HNaJYWTd5spWmezhLEo2MoCaSLekSyQrHJyo
        /fDyFDydS14iG6sjasGEe04QJLQsX+uUGSF6EsQ8xU7Q9H+YlPLYv/uV8WOqbefcGSGaCz
        NQsQibt6+jE6xLHfUf2dykpHW2Q2er1IOLAtr7tSHidXZ36cZQkwYbf8utCa2/LzXN8t0/
        MsmBCqZceTtnGWcciJ4bs1ugN09P1w+DbyZfU1NGUCMK4lJeqEGmCcV/lZ3E4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612267024;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m6q+4p5JkKPBP4kESQCecc9+ZnG9KZQnmraRQ6y4+zQ=;
        b=yoZ8swunJ6ot8Rrf/5PwPVxcJPwzGyEC877i9U3Du2ebEP/7mUwkijVUKuhJAGpCcLyvSF
        fPEk7akwAFqpZgCg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Filter unsupported Topdown metrics event
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1611873611-156687-4-git-send-email-kan.liang@linux.intel.com>
References: <1611873611-156687-4-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161226702403.23325.6250286930000785135.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1ab5f235c176e93adc4f75000aae6c50fea9db00
Gitweb:        https://git.kernel.org/tip/1ab5f235c176e93adc4f75000aae6c50fea9db00
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 28 Jan 2021 14:40:09 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Feb 2021 15:31:36 +01:00

perf/x86/intel: Filter unsupported Topdown metrics event

Intel Sapphire Rapids server will introduce 8 metrics events. Intel
Ice Lake only supports 4 metrics events. A perf tool user may mistakenly
use the unsupported events via RAW format on Ice Lake. The user can
still get a value from the unsupported Topdown metrics event once the
following Sapphire Rapids enabling patch is applied.

To enable the 8 metrics events on Intel Sapphire Rapids, the
INTEL_TD_METRIC_MAX has to be updated, which impacts the
is_metric_event(). The is_metric_event() is a generic function.
On Ice Lake, the newly added SPR metrics events will be mistakenly
accepted as metric events on creation. At runtime, the unsupported
Topdown metrics events will be updated.

Add a variable num_topdown_events in x86_pmu to indicate the available
number of the Topdown metrics event on the platform. Apply the number
into is_metric_event(). Only the supported Topdown metrics events
should be created as metrics events.

Apply the num_topdown_events in icl_update_topdown_event() as well. The
function can be reused by the following patch.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1611873611-156687-4-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c      | 15 +++++++++++++--
 arch/x86/events/perf_event.h      |  1 +
 arch/x86/include/asm/perf_event.h | 10 ++++++++--
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d07408d..37830ac 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2410,7 +2410,8 @@ static u64 intel_update_topdown_event(struct perf_event *event, int metric_end)
 
 static u64 icl_update_topdown_event(struct perf_event *event)
 {
-	return intel_update_topdown_event(event, INTEL_PMC_IDX_TD_BE_BOUND);
+	return intel_update_topdown_event(event, INTEL_PMC_IDX_METRIC_BASE +
+						 x86_pmu.num_topdown_events - 1);
 }
 
 static void intel_pmu_read_topdown_event(struct perf_event *event)
@@ -3468,6 +3469,15 @@ static int core_pmu_hw_config(struct perf_event *event)
 	return intel_pmu_bts_config(event);
 }
 
+#define INTEL_TD_METRIC_AVAILABLE_MAX	(INTEL_TD_METRIC_RETIRING + \
+					 ((x86_pmu.num_topdown_events - 1) << 8))
+
+static bool is_available_metric_event(struct perf_event *event)
+{
+	return is_metric_event(event) &&
+		event->attr.config <= INTEL_TD_METRIC_AVAILABLE_MAX;
+}
+
 static int intel_pmu_hw_config(struct perf_event *event)
 {
 	int ret = x86_pmu_hw_config(event);
@@ -3541,7 +3551,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		if (event->attr.config & X86_ALL_EVENT_FLAGS)
 			return -EINVAL;
 
-		if (is_metric_event(event)) {
+		if (is_available_metric_event(event)) {
 			struct perf_event *leader = event->group_leader;
 
 			/* The metric events don't support sampling. */
@@ -5324,6 +5334,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xc9, .umask=0x04);
 		x86_pmu.lbr_pt_coexist = true;
 		intel_pmu_pebs_data_source_skl(pmem);
+		x86_pmu.num_topdown_events = 4;
 		x86_pmu.update_topdown_event = icl_update_topdown_event;
 		x86_pmu.set_topdown_event_period = icl_set_topdown_event_period;
 		pr_cont("Icelake events, ");
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 978a16e..15343cc 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -775,6 +775,7 @@ struct x86_pmu {
 	/*
 	 * Intel perf metrics
 	 */
+	int		num_topdown_events;
 	u64		(*update_topdown_event)(struct perf_event *event);
 	int		(*set_topdown_event_period)(struct perf_event *event);
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index e2a4c78..7c2c302 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -280,8 +280,14 @@ struct x86_pmu_capability {
 #define INTEL_TD_METRIC_BAD_SPEC		0x8100	/* Bad speculation metric */
 #define INTEL_TD_METRIC_FE_BOUND		0x8200	/* FE bound metric */
 #define INTEL_TD_METRIC_BE_BOUND		0x8300	/* BE bound metric */
-#define INTEL_TD_METRIC_MAX			INTEL_TD_METRIC_BE_BOUND
-#define INTEL_TD_METRIC_NUM			4
+/* Level 2 metrics */
+#define INTEL_TD_METRIC_HEAVY_OPS		0x8400  /* Heavy Operations metric */
+#define INTEL_TD_METRIC_BR_MISPREDICT		0x8500  /* Branch Mispredict metric */
+#define INTEL_TD_METRIC_FETCH_LAT		0x8600  /* Fetch Latency metric */
+#define INTEL_TD_METRIC_MEM_BOUND		0x8700  /* Memory bound metric */
+
+#define INTEL_TD_METRIC_MAX			INTEL_TD_METRIC_MEM_BOUND
+#define INTEL_TD_METRIC_NUM			8
 
 static inline bool is_metric_idx(int idx)
 {
