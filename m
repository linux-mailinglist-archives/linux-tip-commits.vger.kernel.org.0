Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE9E2B8F89
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Nov 2020 11:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgKSJzI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Nov 2020 04:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgKSJzH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Nov 2020 04:55:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032D5C0613D4;
        Thu, 19 Nov 2020 01:55:07 -0800 (PST)
Date:   Thu, 19 Nov 2020 09:55:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605779705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lanMMzq8f95P2MRv1w3fMei1JqZrJujk1xOsUupIJvk=;
        b=EovJ6buNejQm8xrvQhPFUJ1KXl6ORYMzAXxy5+6+HXvfV85WaliCols4JrXnP3Mtc/PyTB
        B/zSCxhMl/vK1nLg8HzG5VIz3CbKYmh2bQh605PdU3A1KcoSoMWwOpZApauPdqbWUZFtjC
        gS+zjpvQ9PU8SHPP4qvgUgxiBMr0zHfYrJvCpskszbqnYqtry3qNxVTPh6XuM2TYkpUhM+
        t+3iwMZCWQs82wkp4wCDxbo1gh7JCUKe+HbwY6KTGrDEZHEqKVp4sGqYVgyKQFzt8F4SB/
        FhEsVW183xG6FelDOXsMFUKEIsAi0Ob5Ehb+kFcKCQ4/bszn9/9oKHZIGajVpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605779705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lanMMzq8f95P2MRv1w3fMei1JqZrJujk1xOsUupIJvk=;
        b=p/8SD9DoikdFF3dtL5NgNdKf6k9OrMyY2xY6Wz8caycmHfjbKXeA0Ub6UAUorYGjOZ37jl
        Kx83vmhmU3zkAFCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Fix rq->nr_iowait ordering
Cc:     Tejun Heo <tj@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201117093829.GD3121429@hirez.programming.kicks-ass.net>
References: <20201117093829.GD3121429@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <160577970455.11244.7243891330140821350.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     ec618b84f6e15281cc3660664d34cd0dd2f2579e
Gitweb:        https://git.kernel.org/tip/ec618b84f6e15281cc3660664d34cd0dd2f2579e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Sep 2020 13:50:42 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 17 Nov 2020 13:15:28 +01:00

sched: Fix rq->nr_iowait ordering

  schedule()				ttwu()
    deactivate_task();			  if (p->on_rq && ...) // false
					    atomic_dec(&task_rq(p)->nr_iowait);
    if (prev->in_iowait)
      atomic_inc(&rq->nr_iowait);

Allows nr_iowait to be decremented before it gets incremented,
resulting in more dodgy IO-wait numbers than usual.

Note that because we can now do ttwu_queue_wakelist() before
p->on_cpu==0, we lose the natural ordering and have to further delay
the decrement.

Fixes: c6e7bd7afaeb ("sched/core: Optimize ttwu() spinning on p->on_cpu")
Reported-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Link: https://lkml.kernel.org/r/20201117093829.GD3121429@hirez.programming.kicks-ass.net
---
 kernel/sched/core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d2003a7..9f0ebfb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2501,7 +2501,12 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 #ifdef CONFIG_SMP
 	if (wake_flags & WF_MIGRATED)
 		en_flags |= ENQUEUE_MIGRATED;
+	else
 #endif
+	if (p->in_iowait) {
+		delayacct_blkio_end(p);
+		atomic_dec(&task_rq(p)->nr_iowait);
+	}
 
 	activate_task(rq, p, en_flags);
 	ttwu_do_wakeup(rq, p, wake_flags, rf);
@@ -2888,11 +2893,6 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
 		goto unlock;
 
-	if (p->in_iowait) {
-		delayacct_blkio_end(p);
-		atomic_dec(&task_rq(p)->nr_iowait);
-	}
-
 #ifdef CONFIG_SMP
 	/*
 	 * Ensure we load p->on_cpu _after_ p->on_rq, otherwise it would be
@@ -2963,6 +2963,11 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 
 	cpu = select_task_rq(p, p->wake_cpu, SD_BALANCE_WAKE, wake_flags);
 	if (task_cpu(p) != cpu) {
+		if (p->in_iowait) {
+			delayacct_blkio_end(p);
+			atomic_dec(&task_rq(p)->nr_iowait);
+		}
+
 		wake_flags |= WF_MIGRATED;
 		psi_ttwu_dequeue(p);
 		set_task_cpu(p, cpu);
