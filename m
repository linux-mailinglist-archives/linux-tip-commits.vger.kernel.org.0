Return-Path: <linux-tip-commits+bounces-1999-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B6494BB19
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 12:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A645B283A75
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 10:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359C918B469;
	Thu,  8 Aug 2024 10:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OC0dLCfc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="79wvOL7u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBA518A6C2;
	Thu,  8 Aug 2024 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113132; cv=none; b=qffonAUguUTI7x64LNGtweppC2HydmXJeEOzNRv8vXx07TEKxivwNsFB30ROiOGhm2PL8x141NTRes7/nIFEnBJcpOEoTKtSCnFMu0XLD9gSEpDJJRCIj1sMu5QOGuNca/1xmZipAfDIrHWTl9BA1wn8U55BkhfZJZd1TUsxYyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113132; c=relaxed/simple;
	bh=SbbehJIYmGRyJsd/JIdfxgohyc2Es+WDYMd5POK4Nds=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EkllNG9CapiJllY89LWBpHcdqeoozTx4w9HE06OFqSiRVkm2/K/xtp6Nbv7DFClIT2HvHP/LhjwA6K1vIp9lrnVVaM16w0dbiqeVLq1OmSNVsLeETtkbUnPEPhWn1h6yPelyoV/qj1lcUbt9EP1AYwDfzrbg+NxeVzJWASHHZtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OC0dLCfc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=79wvOL7u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 10:32:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723113128;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rySI8+7n/qdaXtUo0esh103dJcI+xXsHJHwFkkzQ+8k=;
	b=OC0dLCfcek+lml7nLluGjYsqTUaIc0YwtOO9FGukjS+lSasBzjZi+CaylzrnY4E2liBe4o
	s7Al2SkuqERebU2ALw+2AaM7L/lZna/7HR/MgGQyFvcSVYXDP0f2SO645/AWDJRhwc2ypB
	kaByTiL5rhAthvRNXWrCicki0d9Uq+68q1S22E5LtZ2G5Zg9RUJbKSIqLitq6vgkG20IuA
	WVYVCIb9NXmpSi+1bazUOmu+z7kgEiEuoDBQvTM+aG1bcOxj3bvH/fD7YSo/ezNcyImlY8
	+GwG+mjZvsDvrTqPf6AaK1aMnTZTfdGlexjAr6c7qSgUM5C5PDeo5llqjbGGBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723113128;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rySI8+7n/qdaXtUo0esh103dJcI+xXsHJHwFkkzQ+8k=;
	b=79wvOL7uFzUdoqwzXhqdtLUvnOcO/gLO2E7GHS2QHMO49tY6S0ArkL86kKuSimfibkKccM
	/79tenP1DihZ0pCw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Extract a few helpers
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240807115550.031212518@infradead.org>
References: <20240807115550.031212518@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172311312847.2215.6414212556576318693.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9a32bd9901fe5b1dcf544389dbf04f3b0a2fbab4
Gitweb:        https://git.kernel.org/tip/9a32bd9901fe5b1dcf544389dbf04f3b0a2fbab4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 07 Aug 2024 13:29:26 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 08 Aug 2024 12:27:31 +02:00

perf: Extract a few helpers

The context time update code is repeated verbatim a few times.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240807115550.031212518@infradead.org
---
 kernel/events/core.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index dad2b9a..eb03c9a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2330,6 +2330,24 @@ group_sched_out(struct perf_event *group_event, struct perf_event_context *ctx)
 		event_sched_out(event, ctx);
 }
 
+static inline void
+ctx_time_update(struct perf_cpu_context *cpuctx, struct perf_event_context *ctx)
+{
+	if (ctx->is_active & EVENT_TIME) {
+		update_context_time(ctx);
+		update_cgrp_time_from_cpuctx(cpuctx, false);
+	}
+}
+
+static inline void
+ctx_time_update_event(struct perf_event_context *ctx, struct perf_event *event)
+{
+	if (ctx->is_active & EVENT_TIME) {
+		update_context_time(ctx);
+		update_cgrp_time_from_event(event);
+	}
+}
+
 #define DETACH_GROUP	0x01UL
 #define DETACH_CHILD	0x02UL
 #define DETACH_DEAD	0x04UL
@@ -2349,10 +2367,7 @@ __perf_remove_from_context(struct perf_event *event,
 	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
 	unsigned long flags = (unsigned long)info;
 
-	if (ctx->is_active & EVENT_TIME) {
-		update_context_time(ctx);
-		update_cgrp_time_from_cpuctx(cpuctx, false);
-	}
+	ctx_time_update(cpuctx, ctx);
 
 	/*
 	 * Ensure event_sched_out() switches to OFF, at the very least
@@ -2437,12 +2452,8 @@ static void __perf_event_disable(struct perf_event *event,
 	if (event->state < PERF_EVENT_STATE_INACTIVE)
 		return;
 
-	if (ctx->is_active & EVENT_TIME) {
-		update_context_time(ctx);
-		update_cgrp_time_from_event(event);
-	}
-
 	perf_pmu_disable(event->pmu_ctx->pmu);
+	ctx_time_update_event(ctx, event);
 
 	if (event == event->group_leader)
 		group_sched_out(event, ctx);
@@ -4529,10 +4540,7 @@ static void __perf_event_read(void *info)
 		return;
 
 	raw_spin_lock(&ctx->lock);
-	if (ctx->is_active & EVENT_TIME) {
-		update_context_time(ctx);
-		update_cgrp_time_from_event(event);
-	}
+	ctx_time_update_event(ctx, event);
 
 	perf_event_update_time(event);
 	if (data->group)
@@ -4732,10 +4740,7 @@ again:
 		 * May read while context is not active (e.g., thread is
 		 * blocked), in that case we cannot update context time
 		 */
-		if (ctx->is_active & EVENT_TIME) {
-			update_context_time(ctx);
-			update_cgrp_time_from_event(event);
-		}
+		ctx_time_update_event(ctx, event);
 
 		perf_event_update_time(event);
 		if (group)

