Return-Path: <linux-tip-commits+bounces-5758-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8FBAD4FBD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 11:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267961892D6E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 09:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D80126058B;
	Wed, 11 Jun 2025 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sTwRtL1/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lW8wVVls"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8295523A58E;
	Wed, 11 Jun 2025 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634176; cv=none; b=uZTQ1LzeOg4iUirmbVsIZTn8EMNd1jyzm4eDl9B8wgRWQ63vC8hiJcAzVYWhFJ+N4fjNsNU8cHtanc91/qe3pb7TB+JEzjRKUJMypTFrMPjeLUJAkA10OtZ/ePpRqj1ibx/FqDSWR9p7pM5pp52bU4JMwnOQaU/50vJygvcq8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634176; c=relaxed/simple;
	bh=SsVw1RERk/Z0yIyEeW4vHViDJZZFVhdltsnkPxxqaqE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f5THSWPy3Nxe4mwnbkiEDcb+KHweA33E8TTOvRfVMHkoZitqfIXrVQDBvsBmWNo17wEoi8+sbgOwl7eAxs8wML4DOf1OYgPI13cjUBQVXBKL0t1vvPK9tKQuIBteS0FbjXaJ63+6CipLXSyRULqjtewPi8r87NgkLNQiZIv1s44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sTwRtL1/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lW8wVVls; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 09:29:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749634173;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LElLgzTIRQhbI31dGFELMb5wLdoHSjUUidWHfMuuD70=;
	b=sTwRtL1/yz8Ghy5UsLpB/Ia3T+7YVP3snG4b69eEI8PB/Km3nB4dcxuY2bRSDtaCMDDkMZ
	dSpG6YUuPZ8pg+qe4MOIwUYSa4hqFIXWwSQAuS76QHuneWBIEpFX250mQLUj0AagR5lQB8
	DzeQLSPQ3IfrJNBsVpyk9GUO0TyygfmI9+6uwGgIusFiwAXsrO5BHzQEVn/eY8U2AkqH8Y
	E+8mnwtOk6lpHSF9OL9xwvG1wLfPzsZ2RxMDwm1/1hMY6X9AcIYLDdLpPs/IBCZgdkLmD0
	lesX+vOiMYUJjh8afpFB2HpVKyENQsfBQFEwq9QDouBKGlIqdxdsNamHYEm+FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749634173;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LElLgzTIRQhbI31dGFELMb5wLdoHSjUUidWHfMuuD70=;
	b=lW8wVVlsmpPA0zdF1QUvO9oUK4bQWzRTdJWuJNxeNgljmGrC4voGEWKTrZA2aRepgyLhqF
	HLxP29DH7+HD2TBg==
From: "tip-bot2 for Luo Gengkun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix WARN in perf_cgroup_switch()
Cc: Luo Gengkun <luogengkun@huaweicloud.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250604033924.3914647-3-luogengkun@huaweicloud.com>
References: <20250604033924.3914647-3-luogengkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174963417198.406.3332177110975635135.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     3172fb986666dfb71bf483b6d3539e1e587fa197
Gitweb:        https://git.kernel.org/tip/3172fb986666dfb71bf483b6d3539e1e587fa197
Author:        Luo Gengkun <luogengkun@huaweicloud.com>
AuthorDate:    Wed, 04 Jun 2025 03:39:24 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 05 Jun 2025 14:37:52 +02:00

perf/core: Fix WARN in perf_cgroup_switch()

There may be concurrency between perf_cgroup_switch and
perf_cgroup_event_disable. Consider the following scenario: after a new
perf cgroup event is created on CPU0, the new event may not trigger
a reprogramming, causing ctx->is_active to be 0. In this case, when CPU1
disables this perf event, it executes __perf_remove_from_context->
list _del_event->perf_cgroup_event_disable on CPU1, which causes a race
with perf_cgroup_switch running on CPU0.

The following describes the details of this concurrency scenario:

CPU0						CPU1

perf_cgroup_switch:
   ...
   # cpuctx->cgrp is not NULL here
   if (READ_ONCE(cpuctx->cgrp) == NULL)
   	return;

						perf_remove_from_context:
						   ...
						   raw_spin_lock_irq(&ctx->lock);
						   ...
						   # ctx->is_active == 0 because reprogramm is not
						   # tigger, so CPU1 can do __perf_remove_from_context
						   # for CPU0
						   __perf_remove_from_context:
						         perf_cgroup_event_disable:
							    ...
							    if (--ctx->nr_cgroups)
							    ...

   # this warning will happened because CPU1 changed
   # ctx.nr_cgroups to 0.
   WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);

[peterz: use guard instead of goto unlock]
Fixes: db4a835601b7 ("perf/core: Set cgroup in CPU contexts for new cgroup events")
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250604033924.3914647-3-luogengkun@huaweicloud.com
---
 kernel/events/core.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d786083..d7cf008 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -207,6 +207,19 @@ static void perf_ctx_unlock(struct perf_cpu_context *cpuctx,
 	__perf_ctx_unlock(&cpuctx->ctx);
 }
 
+typedef struct {
+	struct perf_cpu_context *cpuctx;
+	struct perf_event_context *ctx;
+} class_perf_ctx_lock_t;
+
+static inline void class_perf_ctx_lock_destructor(class_perf_ctx_lock_t *_T)
+{ perf_ctx_unlock(_T->cpuctx, _T->ctx); }
+
+static inline class_perf_ctx_lock_t
+class_perf_ctx_lock_constructor(struct perf_cpu_context *cpuctx,
+				struct perf_event_context *ctx)
+{ perf_ctx_lock(cpuctx, ctx); return (class_perf_ctx_lock_t){ cpuctx, ctx }; }
+
 #define TASK_TOMBSTONE ((void *)-1L)
 
 static bool is_kernel_event(struct perf_event *event)
@@ -944,7 +957,13 @@ static void perf_cgroup_switch(struct task_struct *task)
 	if (READ_ONCE(cpuctx->cgrp) == cgrp)
 		return;
 
-	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
+	guard(perf_ctx_lock)(cpuctx, cpuctx->task_ctx);
+	/*
+	 * Re-check, could've raced vs perf_remove_from_context().
+	 */
+	if (READ_ONCE(cpuctx->cgrp) == NULL)
+		return;
+
 	perf_ctx_disable(&cpuctx->ctx, true);
 
 	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
@@ -962,7 +981,6 @@ static void perf_cgroup_switch(struct task_struct *task)
 	ctx_sched_in(&cpuctx->ctx, NULL, EVENT_ALL|EVENT_CGROUP);
 
 	perf_ctx_enable(&cpuctx->ctx, true);
-	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
 }
 
 static int perf_cgroup_ensure_storage(struct perf_event *event,

