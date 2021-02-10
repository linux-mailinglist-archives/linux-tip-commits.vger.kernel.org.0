Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B095C316864
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 14:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhBJNye (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 08:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbhBJNyR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 08:54:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34653C0613D6;
        Wed, 10 Feb 2021 05:53:36 -0800 (PST)
Date:   Wed, 10 Feb 2021 13:53:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612965213;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zNoK5n9IFQ8JjNxCvEkdMvjD6iP/wkbG65a3TdESiZ8=;
        b=ZiOkP8WcQHpkglycEtlu0uoQE5c+CLOP3Lvjvxx21XEetTHLqN+JsWSpYgJ45C6fwY0vqg
        lVebML0sDIxXa3HhoLW+zsbpr9N4WLEKaER4IvWD/KP7JBECQS16Jm6GwBdEfXyi7zpTQi
        zh7r3tfAtujSnz/t298UELu4fcHj4niReMV5gYoxfwI22n96mR4DwG9m9DHbrULTCVPZJY
        O2rsCaeBCSke5bQdPd46pAHx5dTUj5h3w0o8I1k6RBmeAjV+QbbaWNmA3jPsXw66t040XQ
        nQu+OUqX4qTifSriXJJ04c0GhyTZJeTylwhwV/ACh2aH2o4KnRN3K6+NHVbA6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612965213;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zNoK5n9IFQ8JjNxCvEkdMvjD6iP/wkbG65a3TdESiZ8=;
        b=Ngh2sMNylvVczgXE7Vl9db29Aod1JvEvQ1QfHUieVvJ44NlGkXdbjs+IWuuOFTAaqjg9qX
        nBjreLJ9POv21sAQ==
From:   "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/features: Distinguish between NORMAL and
 DEADLINE hrtick
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210208073554.14629-3-juri.lelli@redhat.com>
References: <20210208073554.14629-3-juri.lelli@redhat.com>
MIME-Version: 1.0
Message-ID: <161296521311.23325.11188320846155912495.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f2ebf3f45f7a68b67d456296e5efbb58577fb771
Gitweb:        https://git.kernel.org/tip/f2ebf3f45f7a68b67d456296e5efbb58577fb771
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Mon, 08 Feb 2021 08:35:54 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 10 Feb 2021 14:44:49 +01:00

sched/features: Distinguish between NORMAL and DEADLINE hrtick

The HRTICK feature has traditionally been servicing configurations that
need precise preemptions point for NORMAL tasks. More recently, the
feature has been extended to also service DEADLINE tasks with stringent
runtime enforcement needs (e.g., runtime < 1ms with HZ=1000).

Enabling HRTICK sched feature currently enables the additional timer and
task tick for both classes, which might introduced undesired overhead
for no additional benefit if one needed it only for one of the cases.

Separate HRTICK sched feature in two (and leave the traditional case
name unmodified) so that it can be selectively enabled when needed.

With

$ echo HRTICK > /sys/kernel/debug/sched_features

the NORMAL/fair hrtick gets enabled.

With

$ echo HRTICK_DL > /sys/kernel/debug/sched_features

the DEADLINE hrtick gets enabled.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210208073554.14629-3-juri.lelli@redhat.com
---
 kernel/sched/core.c     |  2 +-
 kernel/sched/deadline.c |  4 ++--
 kernel/sched/fair.c     |  4 ++--
 kernel/sched/features.h |  1 +
 kernel/sched/sched.h    | 26 ++++++++++++++++++++++++--
 5 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 18d51ab..88a2e2b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4969,7 +4969,7 @@ static void __sched notrace __schedule(bool preempt)
 
 	schedule_debug(prev, preempt);
 
-	if (sched_feat(HRTICK))
+	if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
 		hrtick_clear(rq);
 
 	local_irq_disable();
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 6f37796..aac3539 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1832,7 +1832,7 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 	if (!first)
 		return;
 
-	if (hrtick_enabled(rq))
+	if (hrtick_enabled_dl(rq))
 		start_hrtick_dl(rq, p);
 
 	if (rq->curr->sched_class != &dl_sched_class)
@@ -1895,7 +1895,7 @@ static void task_tick_dl(struct rq *rq, struct task_struct *p, int queued)
 	 * not being the leftmost task anymore. In that case NEED_RESCHED will
 	 * be set and schedule() will start a new hrtick for the next task.
 	 */
-	if (hrtick_enabled(rq) && queued && p->dl.runtime > 0 &&
+	if (hrtick_enabled_dl(rq) && queued && p->dl.runtime > 0 &&
 	    is_leftmost(p, &rq->dl))
 		start_hrtick_dl(rq, p);
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 59b645e..8a8bd7b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5429,7 +5429,7 @@ static void hrtick_update(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
 
-	if (!hrtick_enabled(rq) || curr->sched_class != &fair_sched_class)
+	if (!hrtick_enabled_fair(rq) || curr->sched_class != &fair_sched_class)
 		return;
 
 	if (cfs_rq_of(&curr->se)->nr_running < sched_nr_latency)
@@ -7116,7 +7116,7 @@ done: __maybe_unused;
 	list_move(&p->se.group_node, &rq->cfs_tasks);
 #endif
 
-	if (hrtick_enabled(rq))
+	if (hrtick_enabled_fair(rq))
 		hrtick_start_fair(rq, p);
 
 	update_misfit_status(p, rq);
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index e875eab..1bc2b15 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -38,6 +38,7 @@ SCHED_FEAT(CACHE_HOT_BUDDY, true)
 SCHED_FEAT(WAKEUP_PREEMPTION, true)
 
 SCHED_FEAT(HRTICK, false)
+SCHED_FEAT(HRTICK_DL, false)
 SCHED_FEAT(DOUBLE_TICK, false)
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0dfdd52..10a1522 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2105,17 +2105,39 @@ extern const_debug unsigned int sysctl_sched_migration_cost;
  */
 static inline int hrtick_enabled(struct rq *rq)
 {
-	if (!sched_feat(HRTICK))
-		return 0;
 	if (!cpu_active(cpu_of(rq)))
 		return 0;
 	return hrtimer_is_hres_active(&rq->hrtick_timer);
 }
 
+static inline int hrtick_enabled_fair(struct rq *rq)
+{
+	if (!sched_feat(HRTICK))
+		return 0;
+	return hrtick_enabled(rq);
+}
+
+static inline int hrtick_enabled_dl(struct rq *rq)
+{
+	if (!sched_feat(HRTICK_DL))
+		return 0;
+	return hrtick_enabled(rq);
+}
+
 void hrtick_start(struct rq *rq, u64 delay);
 
 #else
 
+static inline int hrtick_enabled_fair(struct rq *rq)
+{
+	return 0;
+}
+
+static inline int hrtick_enabled_dl(struct rq *rq)
+{
+	return 0;
+}
+
 static inline int hrtick_enabled(struct rq *rq)
 {
 	return 0;
