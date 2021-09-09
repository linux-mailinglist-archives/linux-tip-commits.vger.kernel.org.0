Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869C9404915
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Sep 2021 13:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbhIILTk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 9 Sep 2021 07:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbhIILTj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 9 Sep 2021 07:19:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93F3C061575;
        Thu,  9 Sep 2021 04:18:29 -0700 (PDT)
Date:   Thu, 09 Sep 2021 11:18:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631186308;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BecYtEokjjdXVrrjT7oKw2I3rgBW0nHvHUYEEwbYhH0=;
        b=yEK2HfxMC44YPEbhzk4HCZG7J08RRk+4Y7D65IGT0kWKacOnHvi1DLTL9ChG35i413t1iY
        oVYBQIW2edvhRnJCxQR9wGtFuAePRanD5tBuRcFsCWNjjnvLmGf2cm4Uxm16pvYBYmF5EY
        9Rwvnc6DnwMkeJT+LjGh7tBE39puOCJaPsucZFbPEnEZPIer9EDyDo7WYKOueJ25HCunw8
        WD1vIBqLpnZzPnPyu9f59wjWfYsiK8+XVYs++6P8iLGeOcHxgdjfTpnr3yjkDCuhkUJyyu
        QRHSuV2LO1ffzMx5huse/Jwli1jM6U3SCkWqwMp+zaqjTc1cfWmUJhWH0HkV/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631186308;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BecYtEokjjdXVrrjT7oKw2I3rgBW0nHvHUYEEwbYhH0=;
        b=Gq5r0HNgEgpPcfSaupvvPMlV1rl1E5H35sBmk/aMtPKPPYx7pfHepdkKQWZgbK/OkHoJGS
        qujGcGAyNVVkQaCA==
From:   "tip-bot2 for Josh Don" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: reduce sched slice for SCHED_IDLE entities
Cc:     Josh Don <joshdon@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210820010403.946838-4-joshdon@google.com>
References: <20210820010403.946838-4-joshdon@google.com>
MIME-Version: 1.0
Message-ID: <163118630759.25758.9246067278003147655.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7e2ce158699bb7b6a489c7c1d89c0dde2d4ceef5
Gitweb:        https://git.kernel.org/tip/7e2ce158699bb7b6a489c7c1d89c0dde2d4ceef5
Author:        Josh Don <joshdon@google.com>
AuthorDate:    Thu, 19 Aug 2021 18:04:02 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 09 Sep 2021 11:27:31 +02:00

sched: reduce sched slice for SCHED_IDLE entities

Use a small, non-scaled min granularity for SCHED_IDLE entities, when
competing with normal entities. This reduces the latency of getting
a normal entity back on cpu, at the expense of increased context
switch frequency of SCHED_IDLE entities.

The benefit of this change is to reduce the round-robin latency for
normal entities when competing with a SCHED_IDLE entity.

Example: on a machine with HZ=1000, spawned two threads, one of which is
SCHED_IDLE, and affined to one cpu. Without this patch, the SCHED_IDLE
thread runs for 4ms then waits for 1.4s. With this patch, it runs for
1ms and waits 340ms (as it round-robins with the other thread).

Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20210820010403.946838-4-joshdon@google.com
---
 kernel/sched/debug.c |  2 ++
 kernel/sched/fair.c  | 29 ++++++++++++++++++++++++-----
 kernel/sched/sched.h |  1 +
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 3353857..317ef56 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -305,6 +305,7 @@ static __init int sched_init_debug(void)
 
 	debugfs_create_u32("latency_ns", 0644, debugfs_sched, &sysctl_sched_latency);
 	debugfs_create_u32("min_granularity_ns", 0644, debugfs_sched, &sysctl_sched_min_granularity);
+	debugfs_create_u32("idle_min_granularity_ns", 0644, debugfs_sched, &sysctl_sched_idle_min_granularity);
 	debugfs_create_u32("wakeup_granularity_ns", 0644, debugfs_sched, &sysctl_sched_wakeup_granularity);
 
 	debugfs_create_u32("latency_warn_ms", 0644, debugfs_sched, &sysctl_resched_latency_warn_ms);
@@ -806,6 +807,7 @@ static void sched_debug_header(struct seq_file *m)
 	SEQ_printf(m, "  .%-40s: %Ld.%06ld\n", #x, SPLIT_NS(x))
 	PN(sysctl_sched_latency);
 	PN(sysctl_sched_min_granularity);
+	PN(sysctl_sched_idle_min_granularity);
 	PN(sysctl_sched_wakeup_granularity);
 	P(sysctl_sched_child_runs_first);
 	P(sysctl_sched_features);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d7c0b9d..7330a77 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -60,6 +60,14 @@ unsigned int sysctl_sched_min_granularity			= 750000ULL;
 static unsigned int normalized_sysctl_sched_min_granularity	= 750000ULL;
 
 /*
+ * Minimal preemption granularity for CPU-bound SCHED_IDLE tasks.
+ * Applies only when SCHED_IDLE tasks compete with normal tasks.
+ *
+ * (default: 0.75 msec)
+ */
+unsigned int sysctl_sched_idle_min_granularity			= 750000ULL;
+
+/*
  * This value is kept at sysctl_sched_latency/sysctl_sched_min_granularity
  */
 static unsigned int sched_nr_latency = 8;
@@ -665,6 +673,8 @@ static u64 __sched_period(unsigned long nr_running)
 		return sysctl_sched_latency;
 }
 
+static bool sched_idle_cfs_rq(struct cfs_rq *cfs_rq);
+
 /*
  * We calculate the wall-time slice from the period by taking a part
  * proportional to the weight.
@@ -674,6 +684,8 @@ static u64 __sched_period(unsigned long nr_running)
 static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	unsigned int nr_running = cfs_rq->nr_running;
+	struct sched_entity *init_se = se;
+	unsigned int min_gran;
 	u64 slice;
 
 	if (sched_feat(ALT_PERIOD))
@@ -684,12 +696,13 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	for_each_sched_entity(se) {
 		struct load_weight *load;
 		struct load_weight lw;
+		struct cfs_rq *qcfs_rq;
 
-		cfs_rq = cfs_rq_of(se);
-		load = &cfs_rq->load;
+		qcfs_rq = cfs_rq_of(se);
+		load = &qcfs_rq->load;
 
 		if (unlikely(!se->on_rq)) {
-			lw = cfs_rq->load;
+			lw = qcfs_rq->load;
 
 			update_load_add(&lw, se->load.weight);
 			load = &lw;
@@ -697,8 +710,14 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		slice = __calc_delta(slice, se->load.weight, load);
 	}
 
-	if (sched_feat(BASE_SLICE))
-		slice = max(slice, (u64)sysctl_sched_min_granularity);
+	if (sched_feat(BASE_SLICE)) {
+		if (se_is_idle(init_se) && !sched_idle_cfs_rq(cfs_rq))
+			min_gran = sysctl_sched_idle_min_granularity;
+		else
+			min_gran = sysctl_sched_min_granularity;
+
+		slice = max_t(u64, slice, min_gran);
+	}
 
 	return slice;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 413298d..6b2d8b7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2400,6 +2400,7 @@ extern const_debug unsigned int sysctl_sched_migration_cost;
 #ifdef CONFIG_SCHED_DEBUG
 extern unsigned int sysctl_sched_latency;
 extern unsigned int sysctl_sched_min_granularity;
+extern unsigned int sysctl_sched_idle_min_granularity;
 extern unsigned int sysctl_sched_wakeup_granularity;
 extern int sysctl_resched_latency_warn_ms;
 extern int sysctl_resched_latency_warn_once;
