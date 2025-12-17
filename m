Return-Path: <linux-tip-commits+bounces-7752-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E19ECC7D6B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 14:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1277230852F8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 13:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BACC34AAE6;
	Wed, 17 Dec 2025 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ldIhilI9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pSthkWn/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8E334A763;
	Wed, 17 Dec 2025 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975102; cv=none; b=CPE2Jt2xCDsLP4XafpzC3qf63eRyU/sGns9w+JFI2wMvO3l46N4sW2ywTBU4vLajflhMopxqhAIKEucQ006X8KTJaEQ5bld+xeMz8lfQX+kCVU9oMSQXvyEQjKRoYVBBmP+LgFBqpO2aBve67UJ4PF1MxUmtdYZSBK7wMpPwoxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975102; c=relaxed/simple;
	bh=7in5RF2DjArdNU8g9hI9MfDhalzuARY28go3BJZgWwM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oN9bQrs/hLq7i7qgMTlks3aE3kuNlQ3CE6Gh1XMXYy6m5/qGywCwszZHYUPX8ek50yI9RacPYeU0AJkDc6dVOPmK0u1BplsxeegFHv1ah0vDqjjzMh7n49p1vlTiu7ETP20kJ7LApRAwFkOCQ6Xx0cxVKo+eaGxBeJHzW2d+V3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ldIhilI9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pSthkWn/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 12:38:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765975098;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/tQJGEDSjXlwrSDdTdPbxvI4lTYaJEhJCreJCmgBWs=;
	b=ldIhilI9a1KtAqgd6KXkERq8J0PlCID1RNKTcOKcrtG4FNcgB7qHRaVF+eRJVUyH1/LVDF
	idgDEQGMxjDUszI3nlELYcecfl6YWt96yVCFd2az603U/kmW9FvDcnqhKV0okFKvUaCuhm
	+fbh89yWY4VR7JauNOvPXezrVSpRK+9wJgI8t5T2lOkpwrojMBHjvyXKdQWMYez9B4cif0
	jvUFMw2d8w1wgrt7V0cyZ62tuf1UjuBFIi+QqQKPS/AKoo34LjoRrd2FY8cIjf+fD7UfMs
	cmRTDGD6HdVYYUgWe2XvCiUQQBBQj2u6smJb5jBZctzZKf/ssuY3pkvN0pbIJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765975098;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/tQJGEDSjXlwrSDdTdPbxvI4lTYaJEhJCreJCmgBWs=;
	b=pSthkWn/Ugvtt6AUKASxdh6pfI3DpDQLnHTWdERF/BL+5IYH9U5M5Rod20kvGE14UVLpsn
	pdAchY22noF1R/CA==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Add generic exclude_guest support
Cc: Kan Liang <kan.liang@linux.intel.com>, Mingwei Zhang <mizhang@google.com>,
 Sean Christopherson <seanjc@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Xudong Hao <xudong.hao@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251206001720.468579-3-seanjc@google.com>
References: <20251206001720.468579-3-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176597509757.510.17999033168090109265.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b9e52b11d2e5e403afaf69a7f8d6b29f8380ed38
Gitweb:        https://git.kernel.org/tip/b9e52b11d2e5e403afaf69a7f8d6b29f838=
0ed38
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 05 Dec 2025 16:16:38 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Dec 2025 13:31:03 +01:00

perf: Add generic exclude_guest support

Only KVM knows the exact time when a guest is entering/exiting. Expose
two interfaces to KVM to switch the ownership of the PMU resources.

All the pinned events must be scheduled in first. Extend the
perf_event_sched_in() helper to support extra flag, e.g., EVENT_GUEST.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Link: https://patch.msgid.link/20251206001720.468579-3-seanjc@google.com
---
 kernel/events/core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 406371c..fab358d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2870,14 +2870,15 @@ static void task_ctx_sched_out(struct perf_event_cont=
ext *ctx,
=20
 static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
 				struct perf_event_context *ctx,
-				struct pmu *pmu)
+				struct pmu *pmu,
+				enum event_type_t event_type)
 {
-	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_PINNED);
+	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_PINNED | event_type);
 	if (ctx)
-		 ctx_sched_in(ctx, pmu, EVENT_PINNED);
-	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_FLEXIBLE);
+		ctx_sched_in(ctx, pmu, EVENT_PINNED | event_type);
+	ctx_sched_in(&cpuctx->ctx, pmu, EVENT_FLEXIBLE | event_type);
 	if (ctx)
-		 ctx_sched_in(ctx, pmu, EVENT_FLEXIBLE);
+		ctx_sched_in(ctx, pmu, EVENT_FLEXIBLE | event_type);
 }
=20
 /*
@@ -2933,7 +2934,7 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
 	else if (event_type & EVENT_PINNED)
 		ctx_sched_out(&cpuctx->ctx, pmu, EVENT_FLEXIBLE);
=20
-	perf_event_sched_in(cpuctx, task_ctx, pmu);
+	perf_event_sched_in(cpuctx, task_ctx, pmu, 0);
=20
 	for_each_epc(epc, &cpuctx->ctx, pmu, 0)
 		perf_pmu_enable(epc->pmu);
@@ -4151,7 +4152,7 @@ static void perf_event_context_sched_in(struct task_str=
uct *task)
 		ctx_sched_out(&cpuctx->ctx, NULL, EVENT_FLEXIBLE);
 	}
=20
-	perf_event_sched_in(cpuctx, ctx, NULL);
+	perf_event_sched_in(cpuctx, ctx, NULL, 0);
=20
 	perf_ctx_sched_task_cb(cpuctx->task_ctx, task, true);
=20

