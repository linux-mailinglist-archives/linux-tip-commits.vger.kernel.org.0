Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A535E2AEB20
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgKKIXX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:23:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36208 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgKKIXR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:17 -0500
Date:   Wed, 11 Nov 2020 08:23:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605082994;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BoqJFmF+IYxawVGcPqWM+PczsAuTD7wZSQGwVggMYvE=;
        b=qCv72y7IzIeFH2Y/YLdMfkPOCA3kCQmXBJXPiJV3yWHVU6vkVAN5yXF0MX6ZSwgIWcZ4uW
        4Glgs/gAFqq4ei5jmLLNzmuru4r0/g+VukY7Xg79G/wuP5nrtf5IiHvy/TVmeeORi7D6oJ
        Gk5CropaYi61svxym5JhYChEYmS9Ag7Mvd8CKtmsusfKSUFeylzzr8JUIKaf7RD/JQLPSs
        UbwZxeSYmQlJWxjAoFk3dm4dEFLbGBLmMQKYGoaFBfwI5MA1JijGeLMeB4ihzoWWUyi4oa
        8Rethws74/mZ7MCSA/TL3GZ0NzZkP8oMUHjFx/1IySRJBP2befnFtMypyEsQPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605082994;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BoqJFmF+IYxawVGcPqWM+PczsAuTD7wZSQGwVggMYvE=;
        b=5P1XIswsVhbmtPOO27/PazY5cA/TEejuTsI3REGI+4jFTZBD6K5M38HzjZrgXa2Y1KYWay
        NnYsUeTW0LIkPIDA==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Remove select_task_rq()'s sd_flag parameter
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201102184514.2733-3-valentin.schneider@arm.com>
References: <20201102184514.2733-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <160508299303.11244.8214934971447843229.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3aef1551e942860a3881087171ef0cd45f6ebda7
Gitweb:        https://git.kernel.org/tip/3aef1551e942860a3881087171ef0cd45f6ebda7
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 02 Nov 2020 18:45:13 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:39:06 +01:00

sched: Remove select_task_rq()'s sd_flag parameter

Only select_task_rq_fair() uses that parameter to do an actual domain
search, other classes only care about what kind of wakeup is happening
(fork, exec, or "regular") and thus just translate the flag into a wakeup
type.

WF_TTWU and WF_EXEC have just been added, use these along with WF_FORK to
encode the wakeup types we care about. For select_task_rq_fair(), we can
simply use the shiny new WF_flag : SD_flag mapping.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201102184514.2733-3-valentin.schneider@arm.com
---
 kernel/sched/core.c      | 10 +++++-----
 kernel/sched/deadline.c  |  4 ++--
 kernel/sched/fair.c      |  8 +++++---
 kernel/sched/idle.c      |  2 +-
 kernel/sched/rt.c        |  4 ++--
 kernel/sched/sched.h     |  2 +-
 kernel/sched/stop_task.c |  2 +-
 7 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 622f343..a6aaf9f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2769,12 +2769,12 @@ out:
  * The caller (fork, wakeup) owns p->pi_lock, ->cpus_ptr is stable.
  */
 static inline
-int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int wake_flags)
+int select_task_rq(struct task_struct *p, int cpu, int wake_flags)
 {
 	lockdep_assert_held(&p->pi_lock);
 
 	if (p->nr_cpus_allowed > 1 && !is_migration_disabled(p))
-		cpu = p->sched_class->select_task_rq(p, cpu, sd_flags, wake_flags);
+		cpu = p->sched_class->select_task_rq(p, cpu, wake_flags);
 	else
 		cpu = cpumask_any(p->cpus_ptr);
 
@@ -3409,7 +3409,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 */
 	smp_cond_load_acquire(&p->on_cpu, !VAL);
 
-	cpu = select_task_rq(p, p->wake_cpu, SD_BALANCE_WAKE, wake_flags);
+	cpu = select_task_rq(p, p->wake_cpu, wake_flags | WF_TTWU);
 	if (task_cpu(p) != cpu) {
 		wake_flags |= WF_MIGRATED;
 		psi_ttwu_dequeue(p);
@@ -3793,7 +3793,7 @@ void wake_up_new_task(struct task_struct *p)
 	 */
 	p->recent_used_cpu = task_cpu(p);
 	rseq_migrate(p);
-	__set_task_cpu(p, select_task_rq(p, task_cpu(p), SD_BALANCE_FORK, 0));
+	__set_task_cpu(p, select_task_rq(p, task_cpu(p), WF_FORK));
 #endif
 	rq = __task_rq_lock(p, &rf);
 	update_rq_clock(rq);
@@ -4384,7 +4384,7 @@ void sched_exec(void)
 	int dest_cpu;
 
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
-	dest_cpu = p->sched_class->select_task_rq(p, task_cpu(p), SD_BALANCE_EXEC, 0);
+	dest_cpu = p->sched_class->select_task_rq(p, task_cpu(p), WF_EXEC);
 	if (dest_cpu == smp_processor_id())
 		goto unlock;
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index cc1feb7..2a5836f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1683,13 +1683,13 @@ static void yield_task_dl(struct rq *rq)
 static int find_later_rq(struct task_struct *task);
 
 static int
-select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
+select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 {
 	struct task_struct *curr;
 	bool select_rq;
 	struct rq *rq;
 
-	if (sd_flag != SD_BALANCE_WAKE)
+	if (!(flags & WF_TTWU))
 		goto out;
 
 	rq = cpu_rq(cpu);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3e5d98f..b1596fa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6684,7 +6684,7 @@ fail:
 
 /*
  * select_task_rq_fair: Select target runqueue for the waking task in domains
- * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
+ * that have the relevant SD flag set. In practice, this is SD_BALANCE_WAKE,
  * SD_BALANCE_FORK, or SD_BALANCE_EXEC.
  *
  * Balances load by selecting the idlest CPU in the idlest group, or under
@@ -6695,13 +6695,15 @@ fail:
  * preempt must be disabled.
  */
 static int
-select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
+select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 {
+	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
 	struct sched_domain *tmp, *sd = NULL;
 	int cpu = smp_processor_id();
 	int new_cpu = prev_cpu;
 	int want_affine = 0;
-	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
+	/* SD_flags and WF_flags share the first nibble */
+	int sd_flag = wake_flags & 0xF;
 
 	if (sd_flag & SD_BALANCE_WAKE) {
 		record_wakee(p);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 9da69c4..df91b19 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -376,7 +376,7 @@ void cpu_startup_entry(enum cpuhp_state state)
 
 #ifdef CONFIG_SMP
 static int
-select_task_rq_idle(struct task_struct *p, int cpu, int sd_flag, int flags)
+select_task_rq_idle(struct task_struct *p, int cpu, int flags)
 {
 	return task_cpu(p); /* IDLE tasks as never migrated */
 }
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index c961a3f..dbe4629 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1430,14 +1430,14 @@ static void yield_task_rt(struct rq *rq)
 static int find_lowest_rq(struct task_struct *task);
 
 static int
-select_task_rq_rt(struct task_struct *p, int cpu, int sd_flag, int flags)
+select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 {
 	struct task_struct *curr;
 	struct rq *rq;
 	bool test;
 
 	/* For anything but wake ups, just return the task_cpu */
-	if (sd_flag != SD_BALANCE_WAKE && sd_flag != SD_BALANCE_FORK)
+	if (!(flags & (WF_TTWU | WF_FORK)))
 		goto out;
 
 	rq = cpu_rq(cpu);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4725873..590e6f2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1833,7 +1833,7 @@ struct sched_class {
 
 #ifdef CONFIG_SMP
 	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
-	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int sd_flag, int flags);
+	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int flags);
 	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
 
 	void (*task_woken)(struct rq *this_rq, struct task_struct *task);
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 91bb10c..55f3912 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -11,7 +11,7 @@
 
 #ifdef CONFIG_SMP
 static int
-select_task_rq_stop(struct task_struct *p, int cpu, int sd_flag, int flags)
+select_task_rq_stop(struct task_struct *p, int cpu, int flags)
 {
 	return task_cpu(p); /* stop tasks as never migrate */
 }
