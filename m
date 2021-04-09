Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD38F359E39
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 14:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhDIMF1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 08:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbhDIMF0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 08:05:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D19C061762;
        Fri,  9 Apr 2021 05:05:13 -0700 (PDT)
Date:   Fri, 09 Apr 2021 12:05:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617969911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ON0hoCYdzUbTivaYwjn2vHtjQiI9qVDaizymTlQ3iNc=;
        b=gqXnwQR996X9aXxcLzPiuMdf9d0/40WyLzW3bsCDcRJM/tCO53k8HsIHrXAeooL4NPeVSE
        bZlXP9HkGKtJdI1GwKg//IW5G7szHsApeLY4EWJJEByHsr+1YV7/vksfM/Wg465uFfhIfl
        tzzyIFxdd/5XHo3DrFl+x40XTsq3yZvyWkzmBKKFxSBR5bijXieOS5FafKR+6diU7jJd9+
        HX2li3QNzYkhIqkfmT9jNmiN6Bnkt4/NTbYZw6Bq++cRM/J0+ZOiynOpm4rG7zsHbCS14y
        fcgI7A9MnhJYEyjEE6j0HMh4QzN83UnfrEHK3pJ4FwG/3H4z1POuY/th8ZmwcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617969911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ON0hoCYdzUbTivaYwjn2vHtjQiI9qVDaizymTlQ3iNc=;
        b=2tpmZnbmBiykhHwPh85cAKTdUOiWnaH4Av0+IFsiwN7IO45xGa76FZmuasKlO4V7hifDzl
        2XMA/99uQ/2AL9AA==
From:   "tip-bot2 for Lingutla Chandrasekhar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Ignore percpu threads for imbalance pulls
Cc:     Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210407220628.3798191-2-valentin.schneider@arm.com>
References: <20210407220628.3798191-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <161796991092.29796.13468768733654328424.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8d25d10a4f5a5d87c062838358ab5b3ed7eaa131
Gitweb:        https://git.kernel.org/tip/8d25d10a4f5a5d87c062838358ab5b3ed7eaa131
Author:        Lingutla Chandrasekhar <clingutla@codeaurora.org>
AuthorDate:    Wed, 07 Apr 2021 23:06:26 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 09 Apr 2021 13:52:10 +02:00

sched/fair: Ignore percpu threads for imbalance pulls

During load balance, LBF_SOME_PINNED will be set if any candidate task
cannot be detached due to CPU affinity constraints. This can result in
setting env->sd->parent->sgc->group_imbalance, which can lead to a group
being classified as group_imbalanced (rather than any of the other, lower
group_type) when balancing at a higher level.

In workloads involving a single task per CPU, LBF_SOME_PINNED can often be
set due to per-CPU kthreads being the only other runnable tasks on any
given rq. This results in changing the group classification during
load-balance at higher levels when in reality there is nothing that can be
done for this affinity constraint: per-CPU kthreads, as the name implies,
don't get to move around (modulo hotplug shenanigans).

It's not as clear for userspace tasks - a task could be in an N-CPU cpuset
with N-1 offline CPUs, making it an "accidental" per-CPU task rather than
an intended one. KTHREAD_IS_PER_CPU gives us an indisputable signal which
we can leverage here to not set LBF_SOME_PINNED.

Note that the aforementioned classification to group_imbalance (when
nothing can be done) is especially problematic on big.LITTLE systems, which
have a topology the likes of:

  DIE [          ]
  MC  [    ][    ]
       0  1  2  3
       L  L  B  B

  arch_scale_cpu_capacity(L) < arch_scale_cpu_capacity(B)

Here, setting LBF_SOME_PINNED due to a per-CPU kthread when balancing at MC
level on CPUs [0-1] will subsequently prevent CPUs [2-3] from classifying
the [0-1] group as group_misfit_task when balancing at DIE level. Thus, if
CPUs [0-1] are running CPU-bound (misfit) tasks, ill-timed per-CPU kthreads
can significantly delay the upgmigration of said misfit tasks. Systems
relying on ASYM_PACKING are likely to face similar issues.

Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
[Use kthread_is_per_cpu() rather than p->nr_cpus_allowed]
[Reword changelog]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210407220628.3798191-2-valentin.schneider@arm.com
---
 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d0bd861..d10e33d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7598,6 +7598,10 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
 		return 0;
 
+	/* Disregard pcpu kthreads; they are where they need to be. */
+	if ((p->flags & PF_KTHREAD) && kthread_is_per_cpu(p))
+		return 0;
+
 	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
 		int cpu;
 
