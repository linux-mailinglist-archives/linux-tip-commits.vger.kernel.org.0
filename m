Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8A53B2858
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 09:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhFXHMG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 24 Jun 2021 03:12:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42588 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhFXHMF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 24 Jun 2021 03:12:05 -0400
Date:   Thu, 24 Jun 2021 07:09:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624518586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PozzXPEnB2+xIlISFt7QOd4KfJHHRsNORUlbbhRyss8=;
        b=BBHo8iR62WjNkM1p6OWxEoWnw5Ss5eTGHSbnXtcbevDUTgTviP/MduBZHB6pCUYlxFVOYi
        vxXdVICFzruNTKx709eombKy81/cw1D8bL/xJzmtZhggC2hnl9whP8spokK6FkFbk3b/i3
        LY3WKqKHNUJ01b4+CSbLKWb+m8eZyo2n9KvZsnd/4Eh+dn9UmKObJzLup4biKC+b1h/+hq
        kbdUQyFyAVlD99G5Zx/j7gCwEsEmfNTudLGUhmuGMlXrmWTki0ALePcI/ByMHyZb5uCZ5f
        VmKGC+jzAmMH+smcSX236beS1zGr0cNt2fziag4Ge77pRxzczeV+cq3ubBKVbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624518586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PozzXPEnB2+xIlISFt7QOd4KfJHHRsNORUlbbhRyss8=;
        b=kck29R4yp5F3yhibCDkOmNJ58fK0r10eiMjt25CgbsNQ+vIfjusyjlLSQtMc/P25AstKyP
        K4/E+I6ds4VzMrBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Fix task context PMU for Hetero
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YMsy7BuGT8nBTspT@hirez.programming.kicks-ass.net>
References: <YMsy7BuGT8nBTspT@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <162451858512.395.11784887696338727719.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     012669c740e6e2afa8bdb95394d06676f933dd2d
Gitweb:        https://git.kernel.org/tip/012669c740e6e2afa8bdb95394d06676f933dd2d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 22 Jun 2021 16:21:01 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 23 Jun 2021 18:30:56 +02:00

perf: Fix task context PMU for Hetero

On HETEROGENEOUS hardware (ARM big.Little, Intel Alderlake etc.) each
CPU might have a different hardware PMU. Since each such PMU is
represented by a different struct pmu, but we only have a single HW
task context.

That means that the task context needs to switch PMU type when it
switches CPUs.

Not doing this means that ctx->pmu calls (pmu_{dis,en}able(),
{start,commit,cancel}_txn() etc.) are called against the wrong PMU and
things will go wobbly.

Fixes: f83d2f91d259 ("perf/x86/intel: Add Alder Lake Hybrid support")
Reported-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lkml.kernel.org/r/YMsy7BuGT8nBTspT@hirez.programming.kicks-ass.net
---
 kernel/events/core.c |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6c964de..0e125ae 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3822,9 +3822,16 @@ static void perf_event_context_sched_in(struct perf_event_context *ctx,
 					struct task_struct *task)
 {
 	struct perf_cpu_context *cpuctx;
-	struct pmu *pmu = ctx->pmu;
+	struct pmu *pmu;
 
 	cpuctx = __get_cpu_context(ctx);
+
+	/*
+	 * HACK: for HETEROGENEOUS the task context might have switched to a
+	 * different PMU, force (re)set the context,
+	 */
+	pmu = ctx->pmu = cpuctx->ctx.pmu;
+
 	if (cpuctx->task_ctx == ctx) {
 		if (cpuctx->sched_cb_usage)
 			__perf_pmu_sched_task(cpuctx, true);
