Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59932AEB22
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgKKIY2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgKKIXX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1038EC0617A6;
        Wed, 11 Nov 2020 00:23:23 -0800 (PST)
Date:   Wed, 11 Nov 2020 08:23:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605083001;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EovlCglc3/W7alZEeGWomWOnilAjtapcjVasCvLmMjo=;
        b=R5t9d+sIb5B/BvLFrmBXvcLO5VeOTR3gbwhbXrFKpgSX5s+BHvgv/ZS9Dqa5fBHpmkcYhR
        q3lV4TIqH5LWB/+4EoE913wjPg46sm4RBZFzC0EBtbr9Nkw8YFwBoyC492NRj2icX8Fi9O
        w9LXxzYqk0Zzea30sBMAsV0fHmwk+Sy4MEIzmAE1D0xX+3+zkFxkYMcSaNFoW6y/Fq0K8s
        V0Bac7DZBjszhPUiE4RDXiLR66i45TnrruQKcC77ZgQ4NTk0VJkM9XK1VUalBxC4rBKDiD
        0uHn8QhisqEIXdSu3uI5w916clDOPUK1MGHFIj8v7g4GOK6hseBJNWlBqno8Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605083001;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EovlCglc3/W7alZEeGWomWOnilAjtapcjVasCvLmMjo=;
        b=JJS1VXkfnuzNZLCVw+Uz000HG+0GPil7It0VbQSJFDTgufzOZ24lcCF/TK4RjlsufVUyvh
        UnFZiEsJdhN/tCBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Massage set_cpus_allowed()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201023102346.729082820@infradead.org>
References: <20201023102346.729082820@infradead.org>
MIME-Version: 1.0
Message-ID: <160508300049.11244.9581262522957109833.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9cfc3e18adb0362533e911bf3ce6ec8c821cfccc
Gitweb:        https://git.kernel.org/tip/9cfc3e18adb0362533e911bf3ce6ec8c821cfccc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 16 Sep 2020 14:59:08 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:38:59 +01:00

sched: Massage set_cpus_allowed()

Thread a u32 flags word through the *set_cpus_allowed*() callchain.
This will allow adding behavioural tweaks for future users.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Link: https://lkml.kernel.org/r/20201023102346.729082820@infradead.org
---
 kernel/sched/core.c     | 28 ++++++++++++++++++----------
 kernel/sched/deadline.c |  5 +++--
 kernel/sched/sched.h    |  7 +++++--
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dcb88a0..396accb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1824,13 +1824,14 @@ static int migration_cpu_stop(void *data)
  * sched_class::set_cpus_allowed must do the below, but is not required to
  * actually call this function.
  */
-void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask)
+void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask, u32 flags)
 {
 	cpumask_copy(&p->cpus_mask, new_mask);
 	p->nr_cpus_allowed = cpumask_weight(new_mask);
 }
 
-void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
+static void
+__do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask, u32 flags)
 {
 	struct rq *rq = task_rq(p);
 	bool queued, running;
@@ -1851,7 +1852,7 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 	if (running)
 		put_prev_task(rq, p);
 
-	p->sched_class->set_cpus_allowed(p, new_mask);
+	p->sched_class->set_cpus_allowed(p, new_mask, flags);
 
 	if (queued)
 		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
@@ -1859,6 +1860,11 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 		set_next_task(rq, p);
 }
 
+void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
+{
+	__do_set_cpus_allowed(p, new_mask, 0);
+}
+
 /*
  * Change a given task's CPU affinity. Migrate the thread to a
  * proper CPU and schedule it away if the CPU it's executing on
@@ -1869,7 +1875,8 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
  * call is not atomic; no spinlocks may be held.
  */
 static int __set_cpus_allowed_ptr(struct task_struct *p,
-				  const struct cpumask *new_mask, bool check)
+				  const struct cpumask *new_mask,
+				  u32 flags)
 {
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
 	unsigned int dest_cpu;
@@ -1891,7 +1898,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 	 * Must re-check here, to close a race against __kthread_bind(),
 	 * sched_setaffinity() is not guaranteed to observe the flag.
 	 */
-	if (check && (p->flags & PF_NO_SETAFFINITY)) {
+	if ((flags & SCA_CHECK) && (p->flags & PF_NO_SETAFFINITY)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1910,7 +1917,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 		goto out;
 	}
 
-	do_set_cpus_allowed(p, new_mask);
+	__do_set_cpus_allowed(p, new_mask, flags);
 
 	if (p->flags & PF_KTHREAD) {
 		/*
@@ -1947,7 +1954,7 @@ out:
 
 int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask)
 {
-	return __set_cpus_allowed_ptr(p, new_mask, false);
+	return __set_cpus_allowed_ptr(p, new_mask, 0);
 }
 EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
 
@@ -2406,7 +2413,8 @@ void sched_set_stop_task(int cpu, struct task_struct *stop)
 #else
 
 static inline int __set_cpus_allowed_ptr(struct task_struct *p,
-					 const struct cpumask *new_mask, bool check)
+					 const struct cpumask *new_mask,
+					 u32 flags)
 {
 	return set_cpus_allowed_ptr(p, new_mask);
 }
@@ -6006,7 +6014,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	}
 #endif
 again:
-	retval = __set_cpus_allowed_ptr(p, new_mask, true);
+	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK);
 
 	if (!retval) {
 		cpuset_cpus_allowed(p, cpus_allowed);
@@ -6590,7 +6598,7 @@ void init_idle(struct task_struct *idle, int cpu)
 	 *
 	 * And since this is boot we can forgo the serialization.
 	 */
-	set_cpus_allowed_common(idle, cpumask_of(cpu));
+	set_cpus_allowed_common(idle, cpumask_of(cpu), 0);
 #endif
 	/*
 	 * We're having a chicken and egg problem, even though we are
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 77880fe..e97c7c2 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2301,7 +2301,8 @@ static void task_woken_dl(struct rq *rq, struct task_struct *p)
 }
 
 static void set_cpus_allowed_dl(struct task_struct *p,
-				const struct cpumask *new_mask)
+				const struct cpumask *new_mask,
+				u32 flags)
 {
 	struct root_domain *src_rd;
 	struct rq *rq;
@@ -2330,7 +2331,7 @@ static void set_cpus_allowed_dl(struct task_struct *p,
 		raw_spin_unlock(&src_dl_b->lock);
 	}
 
-	set_cpus_allowed_common(p, new_mask);
+	set_cpus_allowed_common(p, new_mask, flags);
 }
 
 /* Assumes rq->lock is held */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c6f707a..0420d80 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1814,7 +1814,8 @@ struct sched_class {
 	void (*task_woken)(struct rq *this_rq, struct task_struct *task);
 
 	void (*set_cpus_allowed)(struct task_struct *p,
-				 const struct cpumask *newmask);
+				 const struct cpumask *newmask,
+				 u32 flags);
 
 	void (*rq_online)(struct rq *rq);
 	void (*rq_offline)(struct rq *rq);
@@ -1907,7 +1908,9 @@ extern void update_group_capacity(struct sched_domain *sd, int cpu);
 
 extern void trigger_load_balance(struct rq *rq);
 
-extern void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask);
+#define SCA_CHECK		0x01
+
+extern void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask, u32 flags);
 
 #endif
 
