Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A513E2AEB28
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgKKIYp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:24:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36280 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgKKIXU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:20 -0500
Date:   Wed, 11 Nov 2020 08:23:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605082998;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7dQ55Ub3dLolBp1idwnbWbeOne0w7DY7Lu/Hlt+jhFo=;
        b=NOgF4fJBv2ixZoYl2VJCr5WholhhgQTcvd95pFSxtaTg38/i3YdrBq4TmD9ThP66MbcQHr
        H5LPujJ7vb+0pq0+Cc+g44+M/3fvuV6b7CV7P1pWN8m43kbgHiQ+LJqS4iA24SrI4YOYV3
        MLrHHs5R1ZTAEv0MVm6fkH2YeyPhjg9H2DjGbZTsuvMcRlyY1piz/ZMAjWmXZIKMDd0peg
        i0vez8NVG/mtZyqH2QkNLiuta3p85ZxwM5okBJ11HwbOxho95VwAzdBrWfW9rXvgoVsFHr
        0dUsd2tJjjf15/X5qQhQb61hbffDVvVqCTDdma4lLhB5P1TI3OosUYO7T3iOuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605082998;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7dQ55Ub3dLolBp1idwnbWbeOne0w7DY7Lu/Hlt+jhFo=;
        b=dB3lcACEIMFgNFSTmnh1VbXcPYm+DHzVpq+2bYhWkETGHU3J3/lywFWg+aqnsryJea8jHv
        AbNnfiHSbjkf1FCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched,rt: Use the full cpumask for balancing
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201023102347.310519774@infradead.org>
References: <20201023102347.310519774@infradead.org>
MIME-Version: 1.0
Message-ID: <160508299756.11244.654077959919660022.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     95158a89dd50035b4ff5b8aa913854166b50fe6d
Gitweb:        https://git.kernel.org/tip/95158a89dd50035b4ff5b8aa913854166b50fe6d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 01 Oct 2020 16:05:39 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:39:00 +01:00

sched,rt: Use the full cpumask for balancing

We want migrate_disable() tasks to get PULLs in order for them to PUSH
away the higher priority task.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Link: https://lkml.kernel.org/r/20201023102347.310519774@infradead.org
---
 kernel/sched/cpudeadline.c | 4 ++--
 kernel/sched/cpupri.c      | 4 ++--
 kernel/sched/deadline.c    | 4 ++--
 kernel/sched/rt.c          | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 8cb06c8..ceb03d7 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -120,7 +120,7 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 	const struct sched_dl_entity *dl_se = &p->dl;
 
 	if (later_mask &&
-	    cpumask_and(later_mask, cp->free_cpus, p->cpus_ptr)) {
+	    cpumask_and(later_mask, cp->free_cpus, &p->cpus_mask)) {
 		unsigned long cap, max_cap = 0;
 		int cpu, max_cpu = -1;
 
@@ -151,7 +151,7 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 
 		WARN_ON(best_cpu != -1 && !cpu_present(best_cpu));
 
-		if (cpumask_test_cpu(best_cpu, p->cpus_ptr) &&
+		if (cpumask_test_cpu(best_cpu, &p->cpus_mask) &&
 		    dl_time_before(dl_se->deadline, cp->elements[0].dl)) {
 			if (later_mask)
 				cpumask_set_cpu(best_cpu, later_mask);
diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index 0033731..11c4df2 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -73,11 +73,11 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
 	if (skip)
 		return 0;
 
-	if (cpumask_any_and(p->cpus_ptr, vec->mask) >= nr_cpu_ids)
+	if (cpumask_any_and(&p->cpus_mask, vec->mask) >= nr_cpu_ids)
 		return 0;
 
 	if (lowest_mask) {
-		cpumask_and(lowest_mask, p->cpus_ptr, vec->mask);
+		cpumask_and(lowest_mask, &p->cpus_mask, vec->mask);
 
 		/*
 		 * We have to ensure that we have at least one bit
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 206a070..3d3fd83 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1912,7 +1912,7 @@ static void task_fork_dl(struct task_struct *p)
 static int pick_dl_task(struct rq *rq, struct task_struct *p, int cpu)
 {
 	if (!task_running(rq, p) &&
-	    cpumask_test_cpu(cpu, p->cpus_ptr))
+	    cpumask_test_cpu(cpu, &p->cpus_mask))
 		return 1;
 	return 0;
 }
@@ -2062,7 +2062,7 @@ static struct rq *find_lock_later_rq(struct task_struct *task, struct rq *rq)
 		/* Retry if something changed. */
 		if (double_lock_balance(rq, later_rq)) {
 			if (unlikely(task_rq(task) != rq ||
-				     !cpumask_test_cpu(later_rq->cpu, task->cpus_ptr) ||
+				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
 				     task_running(rq, task) ||
 				     !dl_task(task) ||
 				     !task_on_rq_queued(task))) {
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 2525a1b..cf63346 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1658,7 +1658,7 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
 static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
 {
 	if (!task_running(rq, p) &&
-	    cpumask_test_cpu(cpu, p->cpus_ptr))
+	    cpumask_test_cpu(cpu, &p->cpus_mask))
 		return 1;
 
 	return 0;
@@ -1811,7 +1811,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 			 * Also make sure that it wasn't scheduled on its rq.
 			 */
 			if (unlikely(task_rq(task) != rq ||
-				     !cpumask_test_cpu(lowest_rq->cpu, task->cpus_ptr) ||
+				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
 				     task_running(rq, task) ||
 				     !rt_task(task) ||
 				     !task_on_rq_queued(task))) {
