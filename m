Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263392AD698
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Nov 2020 13:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbgKJMpW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Nov 2020 07:45:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58216 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729908AbgKJMpV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Nov 2020 07:45:21 -0500
Date:   Tue, 10 Nov 2020 12:45:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605012319;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ugkvKKKj/B/GVLO+EvRlv47ZxCHOzPG5PDM7+dvSB8c=;
        b=DAdj+BIqKkbuHSTEDCZ3ZA4FWAxNm+d6vGhTMLT6PhjsHz7LloXmbSbfT9gFEmp9ClqlPM
        0g7ouTrXlZb/VgUfw7E8SQYMcPFQg9XgdRz8waLSJH9B7efCthrFffVLtwe5s8lsTFWhGT
        spbe6Kdo58qTKMi20NjHUzLqetuR0olPN3WqkrG735ZvpXr2BByg+aUDYNAF8cibtRxkwv
        i/HKGeGIrNGhawwNh4wixzmw90dMfg0Hk4mApiTX1iKxK/H7WE6uSRS0Jx+1QsUs/VYxuT
        qfE4lYhYhxgqICH4xA0k2+D8iabGPSTYTf7gupwarWMEIpvzkQ72SD9sZlfoIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605012319;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ugkvKKKj/B/GVLO+EvRlv47ZxCHOzPG5PDM7+dvSB8c=;
        b=aJ+mOp9ucPOOdAj9mQi65VzkNH8yNsyzqM3HCzhX73AYm4Rhu7gbv7ZRMVniuuAvwDcQHw
        uo+M85uehr9x2gAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Simplify group_sched_in()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201029162901.972161394@infradead.org>
References: <20201029162901.972161394@infradead.org>
MIME-Version: 1.0
Message-ID: <160501231880.11244.5143559563506354630.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     251ff2d49347793d348babcff745289b11910e96
Gitweb:        https://git.kernel.org/tip/251ff2d49347793d348babcff745289b11910e96
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 29 Oct 2020 16:29:15 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Nov 2020 18:12:35 +01:00

perf: Simplify group_sched_in()

Collate the error paths. Code duplication only leads to divergence and
extra bugs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201029162901.972161394@infradead.org
---
 kernel/events/core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9a57366..f0e5268 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2580,11 +2580,8 @@ group_sched_in(struct perf_event *group_event,
 
 	pmu->start_txn(pmu, PERF_PMU_TXN_ADD);
 
-	if (event_sched_in(group_event, cpuctx, ctx)) {
-		pmu->cancel_txn(pmu);
-		perf_mux_hrtimer_restart(cpuctx);
-		return -EAGAIN;
-	}
+	if (event_sched_in(group_event, cpuctx, ctx))
+		goto error;
 
 	/*
 	 * Schedule in siblings as one group (if any):
@@ -2613,10 +2610,9 @@ group_error:
 	}
 	event_sched_out(group_event, cpuctx, ctx);
 
+error:
 	pmu->cancel_txn(pmu);
-
 	perf_mux_hrtimer_restart(cpuctx);
-
 	return -EAGAIN;
 }
 
