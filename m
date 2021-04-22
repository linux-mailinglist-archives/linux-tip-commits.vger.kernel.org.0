Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B0F367B2D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Apr 2021 09:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbhDVHgj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 22 Apr 2021 03:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbhDVHgi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 22 Apr 2021 03:36:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B347EC06174A;
        Thu, 22 Apr 2021 00:36:03 -0700 (PDT)
Date:   Thu, 22 Apr 2021 07:36:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619076962;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pd7xFnbZyNjmdW/shVLRxYU4rcYi/IDnOckdZ34Fg94=;
        b=0rTWXJNK0MBaD1NkKf1IHNEt3vNyi2F9kVqUzjU54EAigFtoi0Chf6gBMoUoVLh3zR8o8C
        mskSlAHEG2rYDgPFzgc1OL0zE5LXgzlGcgwkt51/DBCPlSDpJy3mCVw0gEhnRnFpz43WQb
        2dwP26XIx2qqwBE/ALVogYu24gYHvYasfCSzU5Kusg11ViRN86M14AkxJlHcV6526siVWn
        6aykVOLj5mcoz/z8lLcZaDZqg9O8g5Zny1OFGUw7byRlYHeTvRVCiAFoW2Va2nQvAlGSYi
        kYOmFtwJ1wCQd2mW/E6fVL2yH/IEGJAUTraAtNH4d2FmNjpOpSJfokwELAgTXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619076962;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pd7xFnbZyNjmdW/shVLRxYU4rcYi/IDnOckdZ34Fg94=;
        b=KcQSJxS1yXJEZ6SEHMT9N701fyTiYf5YLtulZ1xs4xBkOArnIRy9H94glfdeMLe9h6dA0j
        pTav7Y/5EPwtxuAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] kthread: Fix PF_KTHREAD vs to_kthread() race
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <YH6WJc825C4P0FCK@hirez.programming.kicks-ass.net>
References: <YH6WJc825C4P0FCK@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <161907696168.29796.14152815065521259837.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3a7956e25e1d7b3c148569e78895e1f3178122a9
Gitweb:        https://git.kernel.org/tip/3a7956e25e1d7b3c148569e78895e1f3178122a9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 20 Apr 2021 10:18:17 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 Apr 2021 13:55:42 +02:00

kthread: Fix PF_KTHREAD vs to_kthread() race

The kthread_is_per_cpu() construct relies on only being called on
PF_KTHREAD tasks (per the WARN in to_kthread). This gives rise to the
following usage pattern:

	if ((p->flags & PF_KTHREAD) && kthread_is_per_cpu(p))

However, as reported by syzcaller, this is broken. The scenario is:

	CPU0				CPU1 (running p)

	(p->flags & PF_KTHREAD) // true

					begin_new_exec()
					  me->flags &= ~(PF_KTHREAD|...);
	kthread_is_per_cpu(p)
	  to_kthread(p)
	    WARN(!(p->flags & PF_KTHREAD) <-- *SPLAT*

Introduce __to_kthread() that omits the WARN and is sure to check both
values.

Use this to remove the problematic pattern for kthread_is_per_cpu()
and fix a number of other kthread_*() functions that have similar
issues but are currently not used in ways that would expose the
problem.

Notably kthread_func() is only ever called on 'current', while
kthread_probe_data() is only used for PF_WQ_WORKER, which implies the
task is from kthread_create*().

Fixes: ac687e6e8c26 ("kthread: Extract KTHREAD_IS_PER_CPU")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>
Link: https://lkml.kernel.org/r/YH6WJc825C4P0FCK@hirez.programming.kicks-ass.net
---
 kernel/kthread.c    | 33 +++++++++++++++++++++++++++------
 kernel/sched/core.c |  2 +-
 kernel/sched/fair.c |  2 +-
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 1578973..6d3c488 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -84,6 +84,25 @@ static inline struct kthread *to_kthread(struct task_struct *k)
 	return (__force void *)k->set_child_tid;
 }
 
+/*
+ * Variant of to_kthread() that doesn't assume @p is a kthread.
+ *
+ * Per construction; when:
+ *
+ *   (p->flags & PF_KTHREAD) && p->set_child_tid
+ *
+ * the task is both a kthread and struct kthread is persistent. However
+ * PF_KTHREAD on it's own is not, kernel_thread() can exec() (See umh.c and
+ * begin_new_exec()).
+ */
+static inline struct kthread *__to_kthread(struct task_struct *p)
+{
+	void *kthread = (__force void *)p->set_child_tid;
+	if (kthread && !(p->flags & PF_KTHREAD))
+		kthread = NULL;
+	return kthread;
+}
+
 void free_kthread_struct(struct task_struct *k)
 {
 	struct kthread *kthread;
@@ -168,8 +187,9 @@ EXPORT_SYMBOL_GPL(kthread_freezable_should_stop);
  */
 void *kthread_func(struct task_struct *task)
 {
-	if (task->flags & PF_KTHREAD)
-		return to_kthread(task)->threadfn;
+	struct kthread *kthread = __to_kthread(task);
+	if (kthread)
+		return kthread->threadfn;
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(kthread_func);
@@ -199,10 +219,11 @@ EXPORT_SYMBOL_GPL(kthread_data);
  */
 void *kthread_probe_data(struct task_struct *task)
 {
-	struct kthread *kthread = to_kthread(task);
+	struct kthread *kthread = __to_kthread(task);
 	void *data = NULL;
 
-	copy_from_kernel_nofault(&data, &kthread->data, sizeof(data));
+	if (kthread)
+		copy_from_kernel_nofault(&data, &kthread->data, sizeof(data));
 	return data;
 }
 
@@ -514,9 +535,9 @@ void kthread_set_per_cpu(struct task_struct *k, int cpu)
 	set_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
 }
 
-bool kthread_is_per_cpu(struct task_struct *k)
+bool kthread_is_per_cpu(struct task_struct *p)
 {
-	struct kthread *kthread = to_kthread(k);
+	struct kthread *kthread = __to_kthread(p);
 	if (!kthread)
 		return false;
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fcb35ae..4a0668a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7667,7 +7667,7 @@ static void balance_push(struct rq *rq)
 	 * histerical raisins.
 	 */
 	if (rq->idle == push_task ||
-	    ((push_task->flags & PF_KTHREAD) && kthread_is_per_cpu(push_task)) ||
+	    kthread_is_per_cpu(push_task) ||
 	    is_migration_disabled(push_task)) {
 
 		/*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7ea3b93..1d75af1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7612,7 +7612,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 		return 0;
 
 	/* Disregard pcpu kthreads; they are where they need to be. */
-	if ((p->flags & PF_KTHREAD) && kthread_is_per_cpu(p))
+	if (kthread_is_per_cpu(p))
 		return 0;
 
 	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
