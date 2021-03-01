Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9732327BC4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Mar 2021 11:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhCAKRO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 1 Mar 2021 05:17:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58304 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhCAKQ7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 1 Mar 2021 05:16:59 -0500
Date:   Mon, 01 Mar 2021 10:16:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614593777;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/jN9EPn+70pYRg3ei5wRmvjwm6Aeod+1XW1gCQFgr8o=;
        b=4YsoDhplDJBNhsZV86lnzf6OtTQrX7IBtT+NOkfslAUcKJUcaU/JQhymfmXKqj7ohNkdHq
        7tzV9x/IYxy6bJHPD7gdoXLvkGpyfGztgLVV6y2TejUdQCeruzgIhuxvzTysEb3DqGpM+L
        +UMf6D0NBGIQEJj9ZNtHJYATz5dIlS0YcKnT6+W0zEYvql0KehrCfSW0jwQV7NV350j8XT
        pBsscqRKOOefYYa9taxXXyBSSE4DtOzB9BX1GN/p68g7f2flvtWV2YYaInwcvXdnyXVq6k
        yU0bgTZB9wu8tbmLfWeyOK4KFuO6WKP7EYWVj2t0l34b8aVERSjKLM+udIbJDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614593777;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/jN9EPn+70pYRg3ei5wRmvjwm6Aeod+1XW1gCQFgr8o=;
        b=j5xZNNtPtlyPqI6845/o+oubV/WhC8ad6U2AcKTolfmJGHqP5RF1sI+vLqBYJi+gxwLfAk
        npIm7io3kIOF7hDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Fix affine_move_task() self-concurrency
Cc:     stable@kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210224131355.649146419@infradead.org>
References: <20210224131355.649146419@infradead.org>
MIME-Version: 1.0
Message-ID: <161459377663.20312.5723191182758095277.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     de8115ef5c83ef2c9941684019d59f4c2e5d16ce
Gitweb:        https://git.kernel.org/tip/de8115ef5c83ef2c9941684019d59f4c2e5d16ce
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 24 Feb 2021 11:31:09 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Mar 2021 11:02:14 +01:00

sched: Fix affine_move_task() self-concurrency

Consider:

   sched_setaffinity(p, X);		sched_setaffinity(p, Y);

Then the first will install p->migration_pending = &my_pending; and
issue stop_one_cpu_nowait(pending); and the second one will read
p->migration_pending and _also_ issue: stop_one_cpu_nowait(pending),
the _SAME_ @pending.

This causes stopper list corruption.

Add set_affinity_pending::stop_pending, to indicate if a stopper is in
progress.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Cc: stable@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210224131355.649146419@infradead.org
---
 kernel/sched/core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ac05afb..4e4d100 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1864,6 +1864,7 @@ struct migration_arg {
 
 struct set_affinity_pending {
 	refcount_t		refs;
+	unsigned int		stop_pending;
 	struct completion	done;
 	struct cpu_stop_work	stop_work;
 	struct migration_arg	arg;
@@ -1982,12 +1983,15 @@ static int migration_cpu_stop(void *data)
 		 * determine is_migration_disabled() and so have to chase after
 		 * it.
 		 */
+		WARN_ON_ONCE(!pending->stop_pending);
 		task_rq_unlock(rq, p, &rf);
 		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
 				    &pending->arg, &pending->stop_work);
 		return 0;
 	}
 out:
+	if (pending)
+		pending->stop_pending = false;
 	task_rq_unlock(rq, p, &rf);
 
 	if (complete)
@@ -2183,7 +2187,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			    int dest_cpu, unsigned int flags)
 {
 	struct set_affinity_pending my_pending = { }, *pending = NULL;
-	bool complete = false;
+	bool stop_pending, complete = false;
 
 	/* Can the task run on the task's current CPU? If so, we're done */
 	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
@@ -2256,14 +2260,19 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		 * anything else we cannot do is_migration_disabled(), punt
 		 * and have the stopper function handle it all race-free.
 		 */
+		stop_pending = pending->stop_pending;
+		if (!stop_pending)
+			pending->stop_pending = true;
 
 		refcount_inc(&pending->refs); /* pending->{arg,stop_work} */
 		if (flags & SCA_MIGRATE_ENABLE)
 			p->migration_flags &= ~MDF_PUSH;
 		task_rq_unlock(rq, p, rf);
 
-		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
-				    &pending->arg, &pending->stop_work);
+		if (!stop_pending) {
+			stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
+					    &pending->arg, &pending->stop_work);
+		}
 
 		if (flags & SCA_MIGRATE_ENABLE)
 			return 0;
