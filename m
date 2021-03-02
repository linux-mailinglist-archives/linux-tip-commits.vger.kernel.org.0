Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683E232B039
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Mar 2021 04:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345719AbhCCDfU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Mar 2021 22:35:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35666 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378833AbhCBJD0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Mar 2021 04:03:26 -0500
Date:   Tue, 02 Mar 2021 09:01:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614675714;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uY5MaecLlqC1YYkJOtb1NojcNJPEnWa//hOtLxPZrcA=;
        b=HQhpFL4jjA24FH9luburHE8u2ZYLSFoZGL5ULg+h0Sqh5JPqCw7jPvb33GklhPmcZa+PB7
        qCykjQxW4xzqKn5UKxclZh0o5D2Vct1zixMvjECPNUnSV9wjTSxSAeoSjE62UvYBD/GKl8
        sAwfXRMRKsg+i6zyRaOR+riDRPjCa7CZeOSXH0hF9ixPyAK9utPs659u7ngFZOt/idnTMZ
        4LjYA404xKtAIf2059Z+V4IaFCZBaTvgXaByg4VLQpzrczAtBM7GAgaQBaAYSYXsvwgJ9k
        /acFyq7zoqYj/QWEizaTzIoL1FyILal5GZTsQGFot7ly+feAIgrKL++IRNE+Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614675714;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uY5MaecLlqC1YYkJOtb1NojcNJPEnWa//hOtLxPZrcA=;
        b=ATwLg9g4CldZLzkAQjAL1lZ8x5i6aLtK1okJsx80xRdIkKdPrtCEHJ98p5K+uaHSXqKY03
        GkfbQ5kW5Wk1HWDQ==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Reduce the window for duplicated update
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210224133007.28644-8-vincent.guittot@linaro.org>
References: <20210224133007.28644-8-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <161467571426.20312.5062953154271007386.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     839ffb99d94f930fecbdee2fdfb883b10c30326b
Gitweb:        https://git.kernel.org/tip/839ffb99d94f930fecbdee2fdfb883b10c30326b
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 24 Feb 2021 14:30:07 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Mar 2021 18:17:25 +01:00

sched/fair: Reduce the window for duplicated update

Start to update last_blocked_load_update_tick to reduce the possibility
of another cpu starting the update one more time

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210224133007.28644-8-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e87e1b3..f1b55f9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7852,16 +7852,20 @@ static inline bool others_have_blocked(struct rq *rq)
 	return false;
 }
 
-static inline void update_blocked_load_status(struct rq *rq, bool has_blocked)
+static inline void update_blocked_load_tick(struct rq *rq)
 {
-	rq->last_blocked_load_update_tick = jiffies;
+	WRITE_ONCE(rq->last_blocked_load_update_tick, jiffies);
+}
 
+static inline void update_blocked_load_status(struct rq *rq, bool has_blocked)
+{
 	if (!has_blocked)
 		rq->has_blocked_load = 0;
 }
 #else
 static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq) { return false; }
 static inline bool others_have_blocked(struct rq *rq) { return false; }
+static inline void update_blocked_load_tick(struct rq *rq) {}
 static inline void update_blocked_load_status(struct rq *rq, bool has_blocked) {}
 #endif
 
@@ -8022,6 +8026,7 @@ static void update_blocked_averages(int cpu)
 	struct rq_flags rf;
 
 	rq_lock_irqsave(rq, &rf);
+	update_blocked_load_tick(rq);
 	update_rq_clock(rq);
 
 	decayed |= __update_blocked_others(rq, &done);
@@ -8363,7 +8368,7 @@ static bool update_nohz_stats(struct rq *rq)
 	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
 		return false;
 
-	if (!time_after(jiffies, rq->last_blocked_load_update_tick))
+	if (!time_after(jiffies, READ_ONCE(rq->last_blocked_load_update_tick)))
 		return true;
 
 	update_blocked_averages(cpu);
