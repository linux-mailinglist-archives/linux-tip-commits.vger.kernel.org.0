Return-Path: <linux-tip-commits+bounces-5066-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7B2A934D4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 10:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659EF1B665B8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 08:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E6826FD9F;
	Fri, 18 Apr 2025 08:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kX8I4Hwf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mu7vd4Q8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA6826F44D;
	Fri, 18 Apr 2025 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744965925; cv=none; b=LotZCEsIVz/hTRMPLasWk8NyPXVs/orO2KawGaISwIq21WJGchpGtAg+yLPm8qIw6RxZuK6iGCCsKRi4kdpw3YOSJQ9CGdbnviFJJydBxxFHUoJKfWiey8JvkDmUUzryH0nf/fti+WxJXfs7/SRYJVjPXDqwcO0a1KZ+LBdXSPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744965925; c=relaxed/simple;
	bh=zskmRpLWg2X5Rm+7OAGDZKdQ3fS/e4oZYSnWetvGKH4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BEkYDgJ8NuVZsC7OhmGy9sIiqH44yytnvoA8Fy2rzclQCiF3IO+cXBxm99jYUA3asWnMy8lRUZI/h9LHas5HhQVWodaLmdI0y2VZD37yj7zSGRn+N9n2oebmvXXyZ513VFHfXOF6cfK5IYfhPEYXocUgZbmX7WROmByoIV6bm5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kX8I4Hwf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mu7vd4Q8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Apr 2025 08:45:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744965921;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+G03pEm9yFe86cklEWd1Yht++t5i8+jr7o2+MjcnTAQ=;
	b=kX8I4Hwf3dy4pioLcpkeWsm7yH3WbqhNUpSWTG4Gl+2pKjk95NYLMvEXmrVdzRFVbiwCge
	w//Xclj2eL4UaGpI/hGMunCZc66DZxJ8T2pVzzTHu3mAJzFAkj/aPu2sPz9hU/lXsXvpDx
	C7A+ETpO3/BNzoVD04BBy9uI0pCORYNjaLa8QcgM5pECeSUeWWrGlU1AtpSJOqID3EkFQ3
	zqDGUwxCf75vZv8CfiItTKntKUrleJquGG7tSufo9Wx+ZVYWZPajW3FD15EcYosAzunPPA
	nJ7k5nXD1apbiOisnta4RIQyDrrFc6Z/kJkr/zKXqgoCx+k/CvxEsrONETCu6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744965921;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+G03pEm9yFe86cklEWd1Yht++t5i8+jr7o2+MjcnTAQ=;
	b=mu7vd4Q8rILvyx6xw877MM5Z9rxZ6MIX7QKDNiRpS8QHKTZPcIQyxZbMP4d5syTgNxW9BR
	WWSDeVLHPWZSJ0CQ==
From: "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/amd/uncore: Use hrtimer for handling overflows
Cc: Sandipan Das <sandipan.das@amd.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C8ecf5fe20452da1cd19cf3ff4954d3e7c5137468=2E17449?=
 =?utf-8?q?06694=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C8ecf5fe20452da1cd19cf3ff4954d3e7c5137468=2E174490?=
 =?utf-8?q?6694=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174496592083.31282.16459288943802975834.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6d937e044bc9bfd52dc50f7fc06d22018841472e
Gitweb:        https://git.kernel.org/tip/6d937e044bc9bfd52dc50f7fc06d22018841472e
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Fri, 18 Apr 2025 09:13:01 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 18 Apr 2025 10:35:33 +02:00

perf/x86/amd/uncore: Use hrtimer for handling overflows

Uncore counters do not provide mechanisms like interrupts to report
overflows and the accumulated user-visible count is incorrect if there
is more than one overflow between two successive read requests for the
same event because the value of prev_count goes out-of-date for
calculating the correct delta.

To avoid this, start a hrtimer to periodically initiate a pmu->read() of
the active counters for keeping prev_count up-to-date. It should be
noted that the hrtimer duration should be lesser than the shortest time
it takes for a counter to overflow for this approach to be effective.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/8ecf5fe20452da1cd19cf3ff4954d3e7c5137468.1744906694.git.sandipan.das@amd.com
---
 arch/x86/events/amd/uncore.c | 63 +++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 010024f..e09bfbb 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -21,6 +21,7 @@
 #define NUM_COUNTERS_NB		4
 #define NUM_COUNTERS_L2		4
 #define NUM_COUNTERS_L3		6
+#define NUM_COUNTERS_MAX	64
 
 #define RDPMC_BASE_NB		6
 #define RDPMC_BASE_LLC		10
@@ -38,6 +39,10 @@ struct amd_uncore_ctx {
 	int refcnt;
 	int cpu;
 	struct perf_event **events;
+	unsigned long active_mask[BITS_TO_LONGS(NUM_COUNTERS_MAX)];
+	int nr_active;
+	struct hrtimer hrtimer;
+	u64 hrtimer_duration;
 };
 
 struct amd_uncore_pmu {
@@ -87,6 +92,42 @@ static struct amd_uncore_pmu *event_to_amd_uncore_pmu(struct perf_event *event)
 	return container_of(event->pmu, struct amd_uncore_pmu, pmu);
 }
 
+static enum hrtimer_restart amd_uncore_hrtimer(struct hrtimer *hrtimer)
+{
+	struct amd_uncore_ctx *ctx;
+	struct perf_event *event;
+	int bit;
+
+	ctx = container_of(hrtimer, struct amd_uncore_ctx, hrtimer);
+
+	if (!ctx->nr_active || ctx->cpu != smp_processor_id())
+		return HRTIMER_NORESTART;
+
+	for_each_set_bit(bit, ctx->active_mask, NUM_COUNTERS_MAX) {
+		event = ctx->events[bit];
+		event->pmu->read(event);
+	}
+
+	hrtimer_forward_now(hrtimer, ns_to_ktime(ctx->hrtimer_duration));
+	return HRTIMER_RESTART;
+}
+
+static void amd_uncore_start_hrtimer(struct amd_uncore_ctx *ctx)
+{
+	hrtimer_start(&ctx->hrtimer, ns_to_ktime(ctx->hrtimer_duration),
+		      HRTIMER_MODE_REL_PINNED_HARD);
+}
+
+static void amd_uncore_cancel_hrtimer(struct amd_uncore_ctx *ctx)
+{
+	hrtimer_cancel(&ctx->hrtimer);
+}
+
+static void amd_uncore_init_hrtimer(struct amd_uncore_ctx *ctx)
+{
+	hrtimer_setup(&ctx->hrtimer, amd_uncore_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
+}
+
 static void amd_uncore_read(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -117,18 +158,26 @@ static void amd_uncore_read(struct perf_event *event)
 
 static void amd_uncore_start(struct perf_event *event, int flags)
 {
+	struct amd_uncore_pmu *pmu = event_to_amd_uncore_pmu(event);
+	struct amd_uncore_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
 	struct hw_perf_event *hwc = &event->hw;
 
+	if (!ctx->nr_active++)
+		amd_uncore_start_hrtimer(ctx);
+
 	if (flags & PERF_EF_RELOAD)
 		wrmsrl(hwc->event_base, (u64)local64_read(&hwc->prev_count));
 
 	hwc->state = 0;
+	__set_bit(hwc->idx, ctx->active_mask);
 	wrmsrl(hwc->config_base, (hwc->config | ARCH_PERFMON_EVENTSEL_ENABLE));
 	perf_event_update_userpage(event);
 }
 
 static void amd_uncore_stop(struct perf_event *event, int flags)
 {
+	struct amd_uncore_pmu *pmu = event_to_amd_uncore_pmu(event);
+	struct amd_uncore_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
 	struct hw_perf_event *hwc = &event->hw;
 
 	wrmsrl(hwc->config_base, hwc->config);
@@ -138,6 +187,11 @@ static void amd_uncore_stop(struct perf_event *event, int flags)
 		event->pmu->read(event);
 		hwc->state |= PERF_HES_UPTODATE;
 	}
+
+	if (!--ctx->nr_active)
+		amd_uncore_cancel_hrtimer(ctx);
+
+	__clear_bit(hwc->idx, ctx->active_mask);
 }
 
 static int amd_uncore_add(struct perf_event *event, int flags)
@@ -490,6 +544,9 @@ static int amd_uncore_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 				goto fail;
 			}
 
+			amd_uncore_init_hrtimer(curr);
+			curr->hrtimer_duration = 60LL * NSEC_PER_SEC;
+
 			cpumask_set_cpu(cpu, &pmu->active_mask);
 		}
 
@@ -879,12 +936,18 @@ static int amd_uncore_umc_event_init(struct perf_event *event)
 
 static void amd_uncore_umc_start(struct perf_event *event, int flags)
 {
+	struct amd_uncore_pmu *pmu = event_to_amd_uncore_pmu(event);
+	struct amd_uncore_ctx *ctx = *per_cpu_ptr(pmu->ctx, event->cpu);
 	struct hw_perf_event *hwc = &event->hw;
 
+	if (!ctx->nr_active++)
+		amd_uncore_start_hrtimer(ctx);
+
 	if (flags & PERF_EF_RELOAD)
 		wrmsrl(hwc->event_base, (u64)local64_read(&hwc->prev_count));
 
 	hwc->state = 0;
+	__set_bit(hwc->idx, ctx->active_mask);
 	wrmsrl(hwc->config_base, (hwc->config | AMD64_PERFMON_V2_ENABLE_UMC));
 	perf_event_update_userpage(event);
 }

