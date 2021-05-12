Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D1037BA57
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhELK3c (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhELK3c (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F2BC06174A;
        Wed, 12 May 2021 03:28:23 -0700 (PDT)
Date:   Wed, 12 May 2021 10:28:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815302;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nMN0bvx3oR0stRuQpZTRRHqWS79ADJoWsIEM5mZHmTQ=;
        b=a04UmZmvL2vsMMS8qq2gby1/4dDK2z+UUNrC21iJOTteW9l/LPoEIYTEd38r/47yqWkO1l
        AKddSTnZZnPgZy6jXTaY4v1BzVFc2JZSl23+UB5HJHny9ap58RAbtHvNFafLXkPxWh7wd9
        51ZqI1PZFiuaj1KzMD+XyhGKM+62uhpk/MOGzNZjjDvyyOYxFaDVdGuhSlx6DV3yNahrxE
        JZfj46BY2NbZhSm2nv6/qa2wixmLgYp69wnMxNsge2K31Qvzsv2n5tplRHNnh69knS7xQ8
        ZmJJOXvgIWbWZxTKG0v1Vw1F4WnqY7SO/Ftb+OPDH4SficrGbt6Ku+u7wXANeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815302;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nMN0bvx3oR0stRuQpZTRRHqWS79ADJoWsIEM5mZHmTQ=;
        b=mYlB/H46AKY9rhH+ytqDhkMTUO7CUngHEFQx64iQp8t7rrFI0XIu2cNzLWISSkF9ISgde/
        GY9yYx7XQ0OGbNAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Trivial core scheduling cookie management
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Don Hiatt <dhiatt@digitalocean.com>,
        Hongyu Ning <hongyu.ning@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422123308.919768100@infradead.org>
References: <20210422123308.919768100@infradead.org>
MIME-Version: 1.0
Message-ID: <162081530166.29796.5711132614441456162.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6e33cad0af49336952e5541464bd02f5b5fd433e
Gitweb:        https://git.kernel.org/tip/6e33cad0af49336952e5541464bd02f5b5fd433e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 18:55:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:31 +02:00

sched: Trivial core scheduling cookie management

In order to not have to use pid_struct, create a new, smaller,
structure to manage task cookies for core scheduling.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Don Hiatt <dhiatt@digitalocean.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210422123308.919768100@infradead.org
---
 include/linux/sched.h     |   6 ++-
 kernel/fork.c             |   1 +-
 kernel/sched/Makefile     |   1 +-
 kernel/sched/core.c       |   7 +-
 kernel/sched/core_sched.c | 109 +++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h      |  16 +++++-
 6 files changed, 137 insertions(+), 3 deletions(-)
 create mode 100644 kernel/sched/core_sched.c

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9b822e3..eab3f7c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2179,4 +2179,10 @@ int sched_trace_rq_nr_running(struct rq *rq);
 
 const struct cpumask *sched_trace_rd_span(struct root_domain *rd);
 
+#ifdef CONFIG_SCHED_CORE
+extern void sched_core_free(struct task_struct *tsk);
+#else
+static inline void sched_core_free(struct task_struct *tsk) { }
+#endif
+
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index dc06afd..d16c60c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -742,6 +742,7 @@ void __put_task_struct(struct task_struct *tsk)
 	exit_creds(tsk);
 	delayacct_tsk_free(tsk);
 	put_signal_struct(tsk->signal);
+	sched_core_free(tsk);
 
 	if (!profile_handoff_task(tsk))
 		free_task(tsk);
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 5fc9c9b..978fcfc 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -36,3 +36,4 @@ obj-$(CONFIG_CPU_FREQ_GOV_SCHEDUTIL) += cpufreq_schedutil.o
 obj-$(CONFIG_MEMBARRIER) += membarrier.o
 obj-$(CONFIG_CPU_ISOLATION) += isolation.o
 obj-$(CONFIG_PSI) += psi.o
+obj-$(CONFIG_SCHED_CORE) += core_sched.o
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b498888..55b2d93 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -167,7 +167,7 @@ static inline int rb_sched_core_cmp(const void *key, const struct rb_node *node)
 	return 0;
 }
 
-static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
+void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 {
 	rq->core->core_task_seq++;
 
@@ -177,14 +177,15 @@ static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 	rb_add(&p->core_node, &rq->core_tree, rb_sched_core_less);
 }
 
-static void sched_core_dequeue(struct rq *rq, struct task_struct *p)
+void sched_core_dequeue(struct rq *rq, struct task_struct *p)
 {
 	rq->core->core_task_seq++;
 
-	if (!p->core_cookie)
+	if (!sched_core_enqueued(p))
 		return;
 
 	rb_erase(&p->core_node, &rq->core_tree);
+	RB_CLEAR_NODE(&p->core_node);
 }
 
 /*
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
new file mode 100644
index 0000000..8d0869a
--- /dev/null
+++ b/kernel/sched/core_sched.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "sched.h"
+
+/*
+ * A simple wrapper around refcount. An allocated sched_core_cookie's
+ * address is used to compute the cookie of the task.
+ */
+struct sched_core_cookie {
+	refcount_t refcnt;
+};
+
+unsigned long sched_core_alloc_cookie(void)
+{
+	struct sched_core_cookie *ck = kmalloc(sizeof(*ck), GFP_KERNEL);
+	if (!ck)
+		return 0;
+
+	refcount_set(&ck->refcnt, 1);
+	sched_core_get();
+
+	return (unsigned long)ck;
+}
+
+void sched_core_put_cookie(unsigned long cookie)
+{
+	struct sched_core_cookie *ptr = (void *)cookie;
+
+	if (ptr && refcount_dec_and_test(&ptr->refcnt)) {
+		kfree(ptr);
+		sched_core_put();
+	}
+}
+
+unsigned long sched_core_get_cookie(unsigned long cookie)
+{
+	struct sched_core_cookie *ptr = (void *)cookie;
+
+	if (ptr)
+		refcount_inc(&ptr->refcnt);
+
+	return cookie;
+}
+
+/*
+ * sched_core_update_cookie - replace the cookie on a task
+ * @p: the task to update
+ * @cookie: the new cookie
+ *
+ * Effectively exchange the task cookie; caller is responsible for lifetimes on
+ * both ends.
+ *
+ * Returns: the old cookie
+ */
+unsigned long sched_core_update_cookie(struct task_struct *p, unsigned long cookie)
+{
+	unsigned long old_cookie;
+	struct rq_flags rf;
+	struct rq *rq;
+	bool enqueued;
+
+	rq = task_rq_lock(p, &rf);
+
+	/*
+	 * Since creating a cookie implies sched_core_get(), and we cannot set
+	 * a cookie until after we've created it, similarly, we cannot destroy
+	 * a cookie until after we've removed it, we must have core scheduling
+	 * enabled here.
+	 */
+	SCHED_WARN_ON((p->core_cookie || cookie) && !sched_core_enabled(rq));
+
+	enqueued = sched_core_enqueued(p);
+	if (enqueued)
+		sched_core_dequeue(rq, p);
+
+	old_cookie = p->core_cookie;
+	p->core_cookie = cookie;
+
+	if (enqueued)
+		sched_core_enqueue(rq, p);
+
+	/*
+	 * If task is currently running, it may not be compatible anymore after
+	 * the cookie change, so enter the scheduler on its CPU to schedule it
+	 * away.
+	 */
+	if (task_running(rq, p))
+		resched_curr(rq);
+
+	task_rq_unlock(rq, p, &rf);
+
+	return old_cookie;
+}
+
+static unsigned long sched_core_clone_cookie(struct task_struct *p)
+{
+	unsigned long cookie, flags;
+
+	raw_spin_lock_irqsave(&p->pi_lock, flags);
+	cookie = sched_core_get_cookie(p->core_cookie);
+	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+
+	return cookie;
+}
+
+void sched_core_free(struct task_struct *p)
+{
+	sched_core_put_cookie(p->core_cookie);
+}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3878386..904c52b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1229,6 +1229,22 @@ static inline bool sched_group_cookie_match(struct rq *rq,
 
 extern void queue_core_balance(struct rq *rq);
 
+static inline bool sched_core_enqueued(struct task_struct *p)
+{
+	return !RB_EMPTY_NODE(&p->core_node);
+}
+
+extern void sched_core_enqueue(struct rq *rq, struct task_struct *p);
+extern void sched_core_dequeue(struct rq *rq, struct task_struct *p);
+
+extern void sched_core_get(void);
+extern void sched_core_put(void);
+
+extern unsigned long sched_core_alloc_cookie(void);
+extern void sched_core_put_cookie(unsigned long cookie);
+extern unsigned long sched_core_get_cookie(unsigned long cookie);
+extern unsigned long sched_core_update_cookie(struct task_struct *p, unsigned long cookie);
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
