Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93A037BA62
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhELK3h (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50472 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhELK3e (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:34 -0400
Date:   Wed, 12 May 2021 10:28:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815306;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PRspnrYzKPFksJCXjW7oP5g5iEr3XxbitW37+1gXz7w=;
        b=KLo4qAhpJruvgmD1O69JtNmZoFOHhXIN0fx3R1AAPRCCXUuHLY9J4g98SBaI3JTmYmcykM
        cB47Nyf9OrKKlZ8b8EWcZSbkb3JSy8tE5r1rJSc27vPkh67fZryUJeFnE9uVkbEiZOmOov
        Tham8VDDZNYImQLAVDt0qf3kv0F3aOHjUrN9f3VUrhUFG2DL5opFkoy/CnRzDHWevvRAgI
        iKqHKRpIQy1uNjH1JmrIigQTB3fDnNNHU6YWb4q+r4zga5RaxB0VzzkicoBQCqRpcEt6nd
        go9v+rVFVnd/3KUMQZ5Qq4jICwtFGh/iKRAuaha/Yq5xjPHHYG7tS9mGBMARWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815306;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PRspnrYzKPFksJCXjW7oP5g5iEr3XxbitW37+1gXz7w=;
        b=BQFz891Av/daJ6J4xtOa3a978r/YdczKWTWXjs7NXKzUayKnQSpDdNOm36hg5xAyTUISrM
        yjX6zI+cXe/SYNCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Introduce sched_class::pick_task()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vineeth Remanan Pillai <viremana@linux.microsoft.com>,
        Don Hiatt <dhiatt@digitalocean.com>,
        Hongyu Ning <hongyu.ning@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422123308.437092775@infradead.org>
References: <20210422123308.437092775@infradead.org>
MIME-Version: 1.0
Message-ID: <162081530531.29796.2208363751943226264.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     21f56ffe4482e501b9e83737612493eeaac21f5a
Gitweb:        https://git.kernel.org/tip/21f56ffe4482e501b9e83737612493eeaac21f5a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 17 Nov 2020 18:19:32 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:28 +02:00

sched: Introduce sched_class::pick_task()

Because sched_class::pick_next_task() also implies
sched_class::set_next_task() (and possibly put_prev_task() and
newidle_balance) it is not state invariant. This makes it unsuitable
for remote task selection.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[Vineeth: folded fixes]
Signed-off-by: Vineeth Remanan Pillai <viremana@linux.microsoft.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Don Hiatt <dhiatt@digitalocean.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210422123308.437092775@infradead.org
---
 kernel/sched/deadline.c  | 16 ++++++++++++++--
 kernel/sched/fair.c      | 40 ++++++++++++++++++++++++++++++++++++---
 kernel/sched/idle.c      |  8 ++++++++-
 kernel/sched/rt.c        | 15 +++++++++++++--
 kernel/sched/sched.h     |  3 +++-
 kernel/sched/stop_task.c | 14 ++++++++++++--
 6 files changed, 87 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fb0eb9a..3829c5a 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1852,7 +1852,7 @@ static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
 	return rb_entry(left, struct sched_dl_entity, rb_node);
 }
 
-static struct task_struct *pick_next_task_dl(struct rq *rq)
+static struct task_struct *pick_task_dl(struct rq *rq)
 {
 	struct sched_dl_entity *dl_se;
 	struct dl_rq *dl_rq = &rq->dl;
@@ -1864,7 +1864,18 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
 	dl_se = pick_next_dl_entity(rq, dl_rq);
 	BUG_ON(!dl_se);
 	p = dl_task_of(dl_se);
-	set_next_task_dl(rq, p, true);
+
+	return p;
+}
+
+static struct task_struct *pick_next_task_dl(struct rq *rq)
+{
+	struct task_struct *p;
+
+	p = pick_task_dl(rq);
+	if (p)
+		set_next_task_dl(rq, p, true);
+
 	return p;
 }
 
@@ -2539,6 +2550,7 @@ DEFINE_SCHED_CLASS(dl) = {
 
 #ifdef CONFIG_SMP
 	.balance		= balance_dl,
+	.pick_task		= pick_task_dl,
 	.select_task_rq		= select_task_rq_dl,
 	.migrate_task_rq	= migrate_task_rq_dl,
 	.set_cpus_allowed       = set_cpus_allowed_dl,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 18960d0..51d72ab 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4419,6 +4419,8 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 static void
 set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	clear_buddies(cfs_rq, se);
+
 	/* 'current' is not kept within the tree. */
 	if (se->on_rq) {
 		/*
@@ -4478,7 +4480,7 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	 * Avoid running the skip buddy, if running something else can
 	 * be done without getting too unfair.
 	 */
-	if (cfs_rq->skip == se) {
+	if (cfs_rq->skip && cfs_rq->skip == se) {
 		struct sched_entity *second;
 
 		if (se == curr) {
@@ -4505,8 +4507,6 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 		se = cfs_rq->last;
 	}
 
-	clear_buddies(cfs_rq, se);
-
 	return se;
 }
 
@@ -7095,6 +7095,39 @@ preempt:
 		set_last_buddy(se);
 }
 
+#ifdef CONFIG_SMP
+static struct task_struct *pick_task_fair(struct rq *rq)
+{
+	struct sched_entity *se;
+	struct cfs_rq *cfs_rq;
+
+again:
+	cfs_rq = &rq->cfs;
+	if (!cfs_rq->nr_running)
+		return NULL;
+
+	do {
+		struct sched_entity *curr = cfs_rq->curr;
+
+		/* When we pick for a remote RQ, we'll not have done put_prev_entity() */
+		if (curr) {
+			if (curr->on_rq)
+				update_curr(cfs_rq);
+			else
+				curr = NULL;
+
+			if (unlikely(check_cfs_rq_runtime(cfs_rq)))
+				goto again;
+		}
+
+		se = pick_next_entity(cfs_rq, curr);
+		cfs_rq = group_cfs_rq(se);
+	} while (cfs_rq);
+
+	return task_of(se);
+}
+#endif
+
 struct task_struct *
 pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
@@ -11298,6 +11331,7 @@ DEFINE_SCHED_CLASS(fair) = {
 
 #ifdef CONFIG_SMP
 	.balance		= balance_fair,
+	.pick_task		= pick_task_fair,
 	.select_task_rq		= select_task_rq_fair,
 	.migrate_task_rq	= migrate_task_rq_fair,
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 0194768..43646e7 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -439,6 +439,13 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
 	schedstat_inc(rq->sched_goidle);
 }
 
+#ifdef CONFIG_SMP
+static struct task_struct *pick_task_idle(struct rq *rq)
+{
+	return rq->idle;
+}
+#endif
+
 struct task_struct *pick_next_task_idle(struct rq *rq)
 {
 	struct task_struct *next = rq->idle;
@@ -506,6 +513,7 @@ DEFINE_SCHED_CLASS(idle) = {
 
 #ifdef CONFIG_SMP
 	.balance		= balance_idle,
+	.pick_task		= pick_task_idle,
 	.select_task_rq		= select_task_rq_idle,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index b3d39c3..a525447 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1626,7 +1626,7 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
 	return rt_task_of(rt_se);
 }
 
-static struct task_struct *pick_next_task_rt(struct rq *rq)
+static struct task_struct *pick_task_rt(struct rq *rq)
 {
 	struct task_struct *p;
 
@@ -1634,7 +1634,17 @@ static struct task_struct *pick_next_task_rt(struct rq *rq)
 		return NULL;
 
 	p = _pick_next_task_rt(rq);
-	set_next_task_rt(rq, p, true);
+
+	return p;
+}
+
+static struct task_struct *pick_next_task_rt(struct rq *rq)
+{
+	struct task_struct *p = pick_task_rt(rq);
+
+	if (p)
+		set_next_task_rt(rq, p, true);
+
 	return p;
 }
 
@@ -2483,6 +2493,7 @@ DEFINE_SCHED_CLASS(rt) = {
 
 #ifdef CONFIG_SMP
 	.balance		= balance_rt,
+	.pick_task		= pick_task_rt,
 	.select_task_rq		= select_task_rq_rt,
 	.set_cpus_allowed       = set_cpus_allowed_common,
 	.rq_online              = rq_online_rt,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ca30af3..fa990cd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1953,6 +1953,9 @@ struct sched_class {
 #ifdef CONFIG_SMP
 	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int flags);
+
+	struct task_struct * (*pick_task)(struct rq *rq);
+
 	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
 
 	void (*task_woken)(struct rq *this_rq, struct task_struct *task);
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 55f3912..f988ebe 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -34,15 +34,24 @@ static void set_next_task_stop(struct rq *rq, struct task_struct *stop, bool fir
 	stop->se.exec_start = rq_clock_task(rq);
 }
 
-static struct task_struct *pick_next_task_stop(struct rq *rq)
+static struct task_struct *pick_task_stop(struct rq *rq)
 {
 	if (!sched_stop_runnable(rq))
 		return NULL;
 
-	set_next_task_stop(rq, rq->stop, true);
 	return rq->stop;
 }
 
+static struct task_struct *pick_next_task_stop(struct rq *rq)
+{
+	struct task_struct *p = pick_task_stop(rq);
+
+	if (p)
+		set_next_task_stop(rq, p, true);
+
+	return p;
+}
+
 static void
 enqueue_task_stop(struct rq *rq, struct task_struct *p, int flags)
 {
@@ -123,6 +132,7 @@ DEFINE_SCHED_CLASS(stop) = {
 
 #ifdef CONFIG_SMP
 	.balance		= balance_stop,
+	.pick_task		= pick_task_stop,
 	.select_task_rq		= select_task_rq_stop,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
