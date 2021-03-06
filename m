Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FD732F9FE
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhCFLmd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhCFLmY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:42:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C604C061761;
        Sat,  6 Mar 2021 03:42:24 -0800 (PST)
Date:   Sat, 06 Mar 2021 11:42:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615030942;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p7+rM5trQdOktK94gD42wDQfmnSkEkIwX33xqRtCkx8=;
        b=ge/AjskUx9ysfig1gTpR2w+GhTmuwO/TYo7gREWIGB4MxjB5PRrrQXle8x0EOvAW9ztsGu
        +2k4Z8xoC1EqgPKWjoSIAMGHUcifKj695cnJJhiJOcggG7DTa4o5UNPw0Y1k4brvsdSnRK
        ZXxpR4HUxc7zgxEl+kJg0evBAhmTOWSlZB5+zb5VDsMSRlAqTMEOJ+3F9ApwBqwNH7LtAo
        5gkJ544HSHy1jyWCXgIDLuz9SA2cdFuGu2umFrExKb3k8CKgXhn02Z96bMWP5T57RM7q4P
        ufy6FAm2f1p9ZSC841rByApsQfGfQgbGstnFnqv8Z7C8Xh+yMNDv5266YSaygg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615030942;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p7+rM5trQdOktK94gD42wDQfmnSkEkIwX33xqRtCkx8=;
        b=40r7rwKZbnm+oJDWnRFiFo7hPUF8NyU6DASvk/9kqP3ngKmHkTGSWFsmzpAuxvinj9UsXy
        HjzOU9zQS9ohYbCg==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Reduce the window for duplicated update
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210224133007.28644-8-vincent.guittot@linaro.org>
References: <20210224133007.28644-8-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <161503094191.398.6539724050553755259.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     39b6a429c30482c349f1bb3746470fe473cbdb0f
Gitweb:        https://git.kernel.org/tip/39b6a429c30482c349f1bb3746470fe473cbdb0f
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 24 Feb 2021 14:30:07 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:40:22 +01:00

sched/fair: Reduce the window for duplicated update

Start to update last_blocked_load_update_tick to reduce the possibility
of another cpu starting the update one more time

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
