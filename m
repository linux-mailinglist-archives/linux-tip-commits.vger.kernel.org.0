Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8B042D7F3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Oct 2021 13:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbhJNLSZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Oct 2021 07:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhJNLSZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Oct 2021 07:18:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65000C061570;
        Thu, 14 Oct 2021 04:16:20 -0700 (PDT)
Date:   Thu, 14 Oct 2021 11:16:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634210179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rfwA/U2duMymwoGUd0AgNQtgI81WP2PWHiXtVjw1GFg=;
        b=RU/HYkXCX626SoPGVJzSY65d7tGU16D4bLqfZsLHGbo6IyciBfp3r8NN2PAu2NovXnLGGl
        ftbpKdBZOIZPg3tTlKxbmtetcpIdArU/DPBxD1WiLnQdh5BjX+zWvWnbC/O+d+Wec+r+Ae
        BUYIzI5Up72UjCq0ziJi3w9RgkXc6Xh/ssNkoYOvaXzpm1Yq7xv+esI89qYBONHzw1zQxl
        jOVzhNQ7NvrhjEAJFbrRc2AaY09Buce73nbQsdVz+RkeTQURbC46Qg12Sfov696Ia2HoqB
        Cy/flpKlneESE10RGrtzcWA+2eJ3Yv5LvYZzKO4f5L8SSA6ViZRsAfNPQK/YxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634210179;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rfwA/U2duMymwoGUd0AgNQtgI81WP2PWHiXtVjw1GFg=;
        b=S2/RKjJ6ocUdWZaV/LpOiFX78aX4nUYg+CpGG+9PxJ6w7eVhZh3BKCJ/VJe3L2MHan+rAQ
        nureI7TBVFa0QBBA==
From:   "tip-bot2 for Zhang Qiao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] kernel/sched: Fix sched_fork() access an invalid
 sched_task_group
Cc:     Zhang Qiao <zhangqiao22@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210915064030.2231-1-zhangqiao22@huawei.com>
References: <20210915064030.2231-1-zhangqiao22@huawei.com>
MIME-Version: 1.0
Message-ID: <163421017804.25758.3597253995887586035.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4ef0c5c6b5ba1f38f0ea1cedad0cad722f00c14a
Gitweb:        https://git.kernel.org/tip/4ef0c5c6b5ba1f38f0ea1cedad0cad722f00c14a
Author:        Zhang Qiao <zhangqiao22@huawei.com>
AuthorDate:    Wed, 15 Sep 2021 14:40:30 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Oct 2021 13:09:58 +02:00

kernel/sched: Fix sched_fork() access an invalid sched_task_group

There is a small race between copy_process() and sched_fork()
where child->sched_task_group point to an already freed pointer.

	parent doing fork()      | someone moving the parent
				 | to another cgroup
  -------------------------------+-------------------------------
  copy_process()
      + dup_task_struct()<1>
				  parent move to another cgroup,
				  and free the old cgroup. <2>
      + sched_fork()
	+ __set_task_cpu()<3>
	+ task_fork_fair()
	  + sched_slice()<4>

In the worst case, this bug can lead to "use-after-free" and
cause panic as shown above:

  (1) parent copy its sched_task_group to child at <1>;

  (2) someone move the parent to another cgroup and free the old
      cgroup at <2>;

  (3) the sched_task_group and cfs_rq that belong to the old cgroup
      will be accessed at <3> and <4>, which cause a panic:

  [] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
  [] PGD 8000001fa0a86067 P4D 8000001fa0a86067 PUD 2029955067 PMD 0
  [] Oops: 0000 [#1] SMP PTI
  [] CPU: 7 PID: 648398 Comm: ebizzy Kdump: loaded Tainted: G           OE    --------- -  - 4.18.0.x86_64+ #1
  [] RIP: 0010:sched_slice+0x84/0xc0

  [] Call Trace:
  []  task_fork_fair+0x81/0x120
  []  sched_fork+0x132/0x240
  []  copy_process.part.5+0x675/0x20e0
  []  ? __handle_mm_fault+0x63f/0x690
  []  _do_fork+0xcd/0x3b0
  []  do_syscall_64+0x5d/0x1d0
  []  entry_SYSCALL_64_after_hwframe+0x65/0xca
  [] RIP: 0033:0x7f04418cd7e1

Between cgroup_can_fork() and cgroup_post_fork(), the cgroup
membership and thus sched_task_group can't change. So update child's
sched_task_group at sched_post_fork() and move task_fork() and
__set_task_cpu() (where accees the sched_task_group) from sched_fork()
to sched_post_fork().

Fixes: 8323f26ce342 ("sched: Fix race in task_group")
Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lkml.kernel.org/r/20210915064030.2231-1-zhangqiao22@huawei.com
---
 include/linux/sched/task.h |  3 ++-
 kernel/fork.c              |  2 +-
 kernel/sched/core.c        | 43 ++++++++++++++++++-------------------
 3 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ef02be8..ba88a69 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -54,7 +54,8 @@ extern asmlinkage void schedule_tail(struct task_struct *prev);
 extern void init_idle(struct task_struct *idle, int cpu);
 
 extern int sched_fork(unsigned long clone_flags, struct task_struct *p);
-extern void sched_post_fork(struct task_struct *p);
+extern void sched_post_fork(struct task_struct *p,
+			    struct kernel_clone_args *kargs);
 extern void sched_dead(struct task_struct *p);
 
 void __noreturn do_task_dead(void);
diff --git a/kernel/fork.c b/kernel/fork.c
index 38681ad..0e4251d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2405,7 +2405,7 @@ static __latent_entropy struct task_struct *copy_process(
 	write_unlock_irq(&tasklist_lock);
 
 	proc_fork_connector(p);
-	sched_post_fork(p);
+	sched_post_fork(p, args);
 	cgroup_post_fork(p, args);
 	perf_event_fork(p);
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3b55ef9..935c2da 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4343,8 +4343,6 @@ int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
  */
 int sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
-	unsigned long flags;
-
 	__sched_fork(clone_flags, p);
 	/*
 	 * We mark the process as NEW here. This guarantees that
@@ -4390,24 +4388,6 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 
 	init_entity_runnable_average(&p->se);
 
-	/*
-	 * The child is not yet in the pid-hash so no cgroup attach races,
-	 * and the cgroup is pinned to this child due to cgroup_fork()
-	 * is ran before sched_fork().
-	 *
-	 * Silence PROVE_RCU.
-	 */
-	raw_spin_lock_irqsave(&p->pi_lock, flags);
-	rseq_migrate(p);
-	/*
-	 * We're setting the CPU for the first time, we don't migrate,
-	 * so use __set_task_cpu().
-	 */
-	__set_task_cpu(p, smp_processor_id());
-	if (p->sched_class->task_fork)
-		p->sched_class->task_fork(p);
-	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
-
 #ifdef CONFIG_SCHED_INFO
 	if (likely(sched_info_on()))
 		memset(&p->sched_info, 0, sizeof(p->sched_info));
@@ -4423,8 +4403,29 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	return 0;
 }
 
-void sched_post_fork(struct task_struct *p)
+void sched_post_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 {
+	unsigned long flags;
+#ifdef CONFIG_CGROUP_SCHED
+	struct task_group *tg;
+#endif
+
+	raw_spin_lock_irqsave(&p->pi_lock, flags);
+#ifdef CONFIG_CGROUP_SCHED
+	tg = container_of(kargs->cset->subsys[cpu_cgrp_id],
+			  struct task_group, css);
+	p->sched_task_group = autogroup_task_group(p, tg);
+#endif
+	rseq_migrate(p);
+	/*
+	 * We're setting the CPU for the first time, we don't migrate,
+	 * so use __set_task_cpu().
+	 */
+	__set_task_cpu(p, smp_processor_id());
+	if (p->sched_class->task_fork)
+		p->sched_class->task_fork(p);
+	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+
 	uclamp_post_fork(p);
 }
 
