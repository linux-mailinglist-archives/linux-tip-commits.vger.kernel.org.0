Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF9737BA5E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhELK3e (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50400 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhELK3e (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:34 -0400
Date:   Wed, 12 May 2021 10:28:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815305;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kdkTgSGmk2HH4E73FcXfUPQZ9wT6s+j+aL8W3FniaeI=;
        b=DuRcGTC6uu5ZvTrBmkriPAoaGnfKg2gQAWx24KkbD+Y1VqvQHhO6Jj9xf/NPi+aIJeAg/J
        kDxelF4saN0o+qZ22jBN/8IPqYHHJ+WboFTDCdZc/M3Bh1cyQPZil88UiLUsLHwB6/LIXj
        yTpB9kPJOGRdS0Jn0jaCpmJFIkHqpNo1tUa/tz0UlotxZWCj4AkslJdK62/+eBM04JgjtE
        MlPxv5I/xK+R4hGMbkylkoeNoIi2xKCThIuK+B1ldippvUEwDaOqy/dHU5GL29zdjLXuUk
        RL9om//MT+fKBEh7b94Wvbu0KKudYdZhNG1wLqrUAEY1OXoJAkBuSuSWOj33oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815305;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kdkTgSGmk2HH4E73FcXfUPQZ9wT6s+j+aL8W3FniaeI=;
        b=K+d/53U6JOYCI5cXfoC4T9gJkiowqjr0Xcu6nIwCcxmdowfyLZ9S1alMNTFg6rO7CiMVAG
        4XVhUgyHWxDhoBBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Basic tracking of matching tasks
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Don Hiatt <dhiatt@digitalocean.com>,
        Hongyu Ning <hongyu.ning@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422123308.496975854@infradead.org>
References: <20210422123308.496975854@infradead.org>
MIME-Version: 1.0
Message-ID: <162081530482.29796.7920810565468813104.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8a311c740b53324ec584e0e3bb7077d56b123c28
Gitweb:        https://git.kernel.org/tip/8a311c740b53324ec584e0e3bb7077d56b123c28
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 17 Nov 2020 18:19:36 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:28 +02:00

sched: Basic tracking of matching tasks

Introduce task_struct::core_cookie as an opaque identifier for core
scheduling. When enabled; core scheduling will only allow matching
task to be on the core; where idle matches everything.

When task_struct::core_cookie is set (and core scheduling is enabled)
these tasks are indexed in a second RB-tree, first on cookie value
then on scheduling function, such that matching task selection always
finds the most elegible match.

NOTE: *shudder* at the overhead...

NOTE: *sigh*, a 3rd copy of the scheduling function; the alternative
is per class tracking of cookies and that just duplicates a lot of
stuff for no raisin (the 2nd copy lives in the rt-mutex PI code).

[Joel: folded fixes]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Don Hiatt <dhiatt@digitalocean.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210422123308.496975854@infradead.org
---
 include/linux/sched.h |   8 +-
 kernel/sched/core.c   | 152 +++++++++++++++++++++++++++++++++++++++--
 kernel/sched/fair.c   |  46 +------------
 kernel/sched/sched.h  |  55 +++++++++++++++-
 4 files changed, 210 insertions(+), 51 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d2c8813..45eedcc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -700,10 +700,16 @@ struct task_struct {
 	const struct sched_class	*sched_class;
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
+	struct sched_dl_entity		dl;
+
+#ifdef CONFIG_SCHED_CORE
+	struct rb_node			core_node;
+	unsigned long			core_cookie;
+#endif
+
 #ifdef CONFIG_CGROUP_SCHED
 	struct task_group		*sched_task_group;
 #endif
-	struct sched_dl_entity		dl;
 
 #ifdef CONFIG_UCLAMP_TASK
 	/*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 85147be..c057d47 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -88,6 +88,133 @@ __read_mostly int scheduler_running;
 
 DEFINE_STATIC_KEY_FALSE(__sched_core_enabled);
 
+/* kernel prio, less is more */
+static inline int __task_prio(struct task_struct *p)
+{
+	if (p->sched_class == &stop_sched_class) /* trumps deadline */
+		return -2;
+
+	if (rt_prio(p->prio)) /* includes deadline */
+		return p->prio; /* [-1, 99] */
+
+	if (p->sched_class == &idle_sched_class)
+		return MAX_RT_PRIO + NICE_WIDTH; /* 140 */
+
+	return MAX_RT_PRIO + MAX_NICE; /* 120, squash fair */
+}
+
+/*
+ * l(a,b)
+ * le(a,b) := !l(b,a)
+ * g(a,b)  := l(b,a)
+ * ge(a,b) := !l(a,b)
+ */
+
+/* real prio, less is less */
+static inline bool prio_less(struct task_struct *a, struct task_struct *b)
+{
+
+	int pa = __task_prio(a), pb = __task_prio(b);
+
+	if (-pa < -pb)
+		return true;
+
+	if (-pb < -pa)
+		return false;
+
+	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
+		return !dl_time_before(a->dl.deadline, b->dl.deadline);
+
+	if (pa == MAX_RT_PRIO + MAX_NICE)  { /* fair */
+		u64 vruntime = b->se.vruntime;
+
+		/*
+		 * Normalize the vruntime if tasks are in different cpus.
+		 */
+		if (task_cpu(a) != task_cpu(b)) {
+			vruntime -= task_cfs_rq(b)->min_vruntime;
+			vruntime += task_cfs_rq(a)->min_vruntime;
+		}
+
+		return !((s64)(a->se.vruntime - vruntime) <= 0);
+	}
+
+	return false;
+}
+
+static inline bool __sched_core_less(struct task_struct *a, struct task_struct *b)
+{
+	if (a->core_cookie < b->core_cookie)
+		return true;
+
+	if (a->core_cookie > b->core_cookie)
+		return false;
+
+	/* flip prio, so high prio is leftmost */
+	if (prio_less(b, a))
+		return true;
+
+	return false;
+}
+
+#define __node_2_sc(node) rb_entry((node), struct task_struct, core_node)
+
+static inline bool rb_sched_core_less(struct rb_node *a, const struct rb_node *b)
+{
+	return __sched_core_less(__node_2_sc(a), __node_2_sc(b));
+}
+
+static inline int rb_sched_core_cmp(const void *key, const struct rb_node *node)
+{
+	const struct task_struct *p = __node_2_sc(node);
+	unsigned long cookie = (unsigned long)key;
+
+	if (cookie < p->core_cookie)
+		return -1;
+
+	if (cookie > p->core_cookie)
+		return 1;
+
+	return 0;
+}
+
+static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
+{
+	rq->core->core_task_seq++;
+
+	if (!p->core_cookie)
+		return;
+
+	rb_add(&p->core_node, &rq->core_tree, rb_sched_core_less);
+}
+
+static void sched_core_dequeue(struct rq *rq, struct task_struct *p)
+{
+	rq->core->core_task_seq++;
+
+	if (!p->core_cookie)
+		return;
+
+	rb_erase(&p->core_node, &rq->core_tree);
+}
+
+/*
+ * Find left-most (aka, highest priority) task matching @cookie.
+ */
+static struct task_struct *sched_core_find(struct rq *rq, unsigned long cookie)
+{
+	struct rb_node *node;
+
+	node = rb_find_first((void *)cookie, &rq->core_tree, rb_sched_core_cmp);
+	/*
+	 * The idle task always matches any cookie!
+	 */
+	if (!node)
+		return idle_sched_class.pick_task(rq);
+
+	return __node_2_sc(node);
+}
+
 /*
  * Magic required such that:
  *
@@ -147,10 +274,16 @@ static void __sched_core_flip(bool enabled)
 	cpus_read_unlock();
 }
 
-static void __sched_core_enable(void)
+static void sched_core_assert_empty(void)
 {
-	// XXX verify there are no cookie tasks (yet)
+	int cpu;
 
+	for_each_possible_cpu(cpu)
+		WARN_ON_ONCE(!RB_EMPTY_ROOT(&cpu_rq(cpu)->core_tree));
+}
+
+static void __sched_core_enable(void)
+{
 	static_branch_enable(&__sched_core_enabled);
 	/*
 	 * Ensure all previous instances of raw_spin_rq_*lock() have finished
@@ -158,12 +291,12 @@ static void __sched_core_enable(void)
 	 */
 	synchronize_rcu();
 	__sched_core_flip(true);
+	sched_core_assert_empty();
 }
 
 static void __sched_core_disable(void)
 {
-	// XXX verify there are no cookie tasks (left)
-
+	sched_core_assert_empty();
 	__sched_core_flip(false);
 	static_branch_disable(&__sched_core_enabled);
 }
@@ -205,6 +338,11 @@ void sched_core_put(void)
 		schedule_work(&_work);
 }
 
+#else /* !CONFIG_SCHED_CORE */
+
+static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
+static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
+
 #endif /* CONFIG_SCHED_CORE */
 
 /*
@@ -1797,10 +1935,16 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 
 	uclamp_rq_inc(rq, p);
 	p->sched_class->enqueue_task(rq, p, flags);
+
+	if (sched_core_enabled(rq))
+		sched_core_enqueue(rq, p);
 }
 
 static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	if (sched_core_enabled(rq))
+		sched_core_dequeue(rq, p);
+
 	if (!(flags & DEQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 51d72ab..08be7a2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -268,33 +268,11 @@ const struct sched_class fair_sched_class;
  */
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-static inline struct task_struct *task_of(struct sched_entity *se)
-{
-	SCHED_WARN_ON(!entity_is_task(se));
-	return container_of(se, struct task_struct, se);
-}
 
 /* Walk up scheduling entities hierarchy */
 #define for_each_sched_entity(se) \
 		for (; se; se = se->parent)
 
-static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
-{
-	return p->se.cfs_rq;
-}
-
-/* runqueue on which this entity is (to be) queued */
-static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
-{
-	return se->cfs_rq;
-}
-
-/* runqueue "owned" by this group */
-static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
-{
-	return grp->my_q;
-}
-
 static inline void cfs_rq_tg_path(struct cfs_rq *cfs_rq, char *path, int len)
 {
 	if (!path)
@@ -455,33 +433,9 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 
 #else	/* !CONFIG_FAIR_GROUP_SCHED */
 
-static inline struct task_struct *task_of(struct sched_entity *se)
-{
-	return container_of(se, struct task_struct, se);
-}
-
 #define for_each_sched_entity(se) \
 		for (; se; se = NULL)
 
-static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
-{
-	return &task_rq(p)->cfs;
-}
-
-static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
-{
-	struct task_struct *p = task_of(se);
-	struct rq *rq = task_rq(p);
-
-	return &rq->cfs;
-}
-
-/* runqueue "owned" by this group */
-static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
-{
-	return NULL;
-}
-
 static inline void cfs_rq_tg_path(struct cfs_rq *cfs_rq, char *path, int len)
 {
 	if (path)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fa990cd..e43a217 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1080,6 +1080,10 @@ struct rq {
 	/* per rq */
 	struct rq		*core;
 	unsigned int		core_enabled;
+	struct rb_root		core_tree;
+
+	/* shared state */
+	unsigned int		core_task_seq;
 #endif
 };
 
@@ -1243,6 +1247,57 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define raw_rq()		raw_cpu_ptr(&runqueues)
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+static inline struct task_struct *task_of(struct sched_entity *se)
+{
+	SCHED_WARN_ON(!entity_is_task(se));
+	return container_of(se, struct task_struct, se);
+}
+
+static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
+{
+	return p->se.cfs_rq;
+}
+
+/* runqueue on which this entity is (to be) queued */
+static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
+{
+	return se->cfs_rq;
+}
+
+/* runqueue "owned" by this group */
+static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
+{
+	return grp->my_q;
+}
+
+#else
+
+static inline struct task_struct *task_of(struct sched_entity *se)
+{
+	return container_of(se, struct task_struct, se);
+}
+
+static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
+{
+	return &task_rq(p)->cfs;
+}
+
+static inline struct cfs_rq *cfs_rq_of(struct sched_entity *se)
+{
+	struct task_struct *p = task_of(se);
+	struct rq *rq = task_rq(p);
+
+	return &rq->cfs;
+}
+
+/* runqueue "owned" by this group */
+static inline struct cfs_rq *group_cfs_rq(struct sched_entity *grp)
+{
+	return NULL;
+}
+#endif
+
 extern void update_rq_clock(struct rq *rq);
 
 static inline u64 __rq_clock_broken(struct rq *rq)
