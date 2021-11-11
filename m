Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA40A44D68F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Nov 2021 13:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbhKKMZU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 11 Nov 2021 07:25:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49440 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbhKKMZT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 11 Nov 2021 07:25:19 -0500
Date:   Thu, 11 Nov 2021 12:22:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636633349;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0wEggnwtZqhcMg/oY1i55akmFUw1FLTPinQfBAQEwpQ=;
        b=Y/QEq3/1YBTN7FzeuXRM3pM8lq4oNIU8+Pr/TRCU4Gp2ebJg8pv8qwom+PsFq0R8BwtLUP
        xG6P7YgzYbiwnjAgfhr/4trFJvMkY2FGOyYux1hr1tdQ59xhXMVWgPC/jp4s0W95ZOaw+s
        +1d5NuuQ8GK3yRiONwA4Ytwku8t/Nu4gPi8NZmaeM0EE/NZdAUg468l0FDhhsx3wrH8LlL
        GIYmuOulkgWnrkRbelagX/CYK/luWw81uhkQxRf+aXcaCBv3Ux1T+Caa1eaaJJCKmi6ejj
        MacYzz8IiVgBsx+j2nMcGd1pXBU+MNK3Sb5Z/9WeJFY4+SQ97L4y/Im+OTxiJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636633349;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0wEggnwtZqhcMg/oY1i55akmFUw1FLTPinQfBAQEwpQ=;
        b=OjLEJ3Pnj0MRoxeMZpBkKXA4Kqd08q7wTiqxGv0+SeHbeznksRL+JWlWPhWdYAxdE/dRh/
        +Ybi4STy5RqmnjDw==
From:   "tip-bot2 for Mathias Krause" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Prevent dead task groups from
 regaining cfs_rq's
Cc:     Kevin Tanguy <kevin.tanguy@corp.ovh.com>,
        Mathias Krause <minipli@grsecurity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <163663334817.414.246470694606115326.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     b027789e5e50494c2325cc70c8642e7fd6059479
Gitweb:        https://git.kernel.org/tip/b027789e5e50494c2325cc70c8642e7fd60=
59479
Author:        Mathias Krause <minipli@grsecurity.net>
AuthorDate:    Wed, 03 Nov 2021 20:06:13 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 11 Nov 2021 13:09:33 +01:00

sched/fair: Prevent dead task groups from regaining cfs_rq's

Kevin is reporting crashes which point to a use-after-free of a cfs_rq
in update_blocked_averages(). Initial debugging revealed that we've
live cfs_rq's (on_list=3D1) in an about to be kfree()'d task group in
free_fair_sched_group(). However, it was unclear how that can happen.

His kernel config happened to lead to a layout of struct sched_entity
that put the 'my_q' member directly into the middle of the object
which makes it incidentally overlap with SLUB's freelist pointer.
That, in combination with SLAB_FREELIST_HARDENED's freelist pointer
mangling, leads to a reliable access violation in form of a #GP which
made the UAF fail fast.

Michal seems to have run into the same issue[1]. He already correctly
diagnosed that commit a7b359fc6a37 ("sched/fair: Correctly insert
cfs_rq's to list on unthrottle") is causing the preconditions for the
UAF to happen by re-adding cfs_rq's also to task groups that have no
more running tasks, i.e. also to dead ones. His analysis, however,
misses the real root cause and it cannot be seen from the crash
backtrace only, as the real offender is tg_unthrottle_up() getting
called via sched_cfs_period_timer() via the timer interrupt at an
inconvenient time.

When unregister_fair_sched_group() unlinks all cfs_rq's from the dying
task group, it doesn't protect itself from getting interrupted. If the
timer interrupt triggers while we iterate over all CPUs or after
unregister_fair_sched_group() has finished but prior to unlinking the
task group, sched_cfs_period_timer() will execute and walk the list of
task groups, trying to unthrottle cfs_rq's, i.e. re-add them to the
dying task group. These will later -- in free_fair_sched_group() -- be
kfree()'ed while still being linked, leading to the fireworks Kevin
and Michal are seeing.

To fix this race, ensure the dying task group gets unlinked first.
However, simply switching the order of unregistering and unlinking the
task group isn't sufficient, as concurrent RCU walkers might still see
it, as can be seen below:

    CPU1:                                      CPU2:
      :                                        timer IRQ:
      :                                          do_sched_cfs_period_timer():
      :                                            :
      :                                            distribute_cfs_runtime():
      :                                              rcu_read_lock();
      :                                              :
      :                                              unthrottle_cfs_rq():
    sched_offline_group():                             :
      :                                                walk_tg_tree_from(=E2=
=80=A6,tg_unthrottle_up,=E2=80=A6):
      list_del_rcu(&tg->list);                           :
 (1)  :                                                  list_for_each_entry_=
rcu(child, &parent->children, siblings)
      :                                                    :
 (2)  list_del_rcu(&tg->siblings);                         :
      :                                                    tg_unthrottle_up():
      unregister_fair_sched_group():                         struct cfs_rq *c=
fs_rq =3D tg->cfs_rq[cpu_of(rq)];
        :                                                    :
        list_del_leaf_cfs_rq(tg->cfs_rq[cpu]);               :
        :                                                    :
        :                                                    if (!cfs_rq_is_d=
ecayed(cfs_rq) || cfs_rq->nr_running)
 (3)    :                                                        list_add_lea=
f_cfs_rq(cfs_rq);
      :                                                      :
      :                                                    :
      :                                                  :
      :                                                :
      :                                              :
 (4)  :                                              rcu_read_unlock();

CPU 2 walks the task group list in parallel to sched_offline_group(),
specifically, it'll read the soon to be unlinked task group entry at
(1). Unlinking it on CPU 1 at (2) therefore won't prevent CPU 2 from
still passing it on to tg_unthrottle_up(). CPU 1 now tries to unlink
all cfs_rq's via list_del_leaf_cfs_rq() in
unregister_fair_sched_group().  Meanwhile CPU 2 will re-add some of
these at (3), which is the cause of the UAF later on.

To prevent this additional race from happening, we need to wait until
walk_tg_tree_from() has finished traversing the task groups, i.e.
after the RCU read critical section ends in (4). Afterwards we're safe
to call unregister_fair_sched_group(), as each new walk won't see the
dying task group any more.

On top of that, we need to wait yet another RCU grace period after
unregister_fair_sched_group() to ensure print_cfs_stats(), which might
run concurrently, always sees valid objects, i.e. not already free'd
ones.

This patch survives Michal's reproducer[2] for 8h+ now, which used to
trigger within minutes before.

  [1] https://lore.kernel.org/lkml/20211011172236.11223-1-mkoutny@suse.com/
  [2] https://lore.kernel.org/lkml/20211102160228.GA57072@blackbody.suse.cz/

Fixes: a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on unthro=
ttle")
[peterz: shuffle code around a bit]
Reported-by: Kevin Tanguy <kevin.tanguy@corp.ovh.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/autogroup.c |  2 +-
 kernel/sched/core.c      | 44 +++++++++++++++++++++++++++++++--------
 kernel/sched/fair.c      |  4 ++--
 kernel/sched/rt.c        | 12 ++++++++---
 kernel/sched/sched.h     |  3 ++-
 5 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index 2067080..8629b37 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -31,7 +31,7 @@ static inline void autogroup_destroy(struct kref *kref)
 	ag->tg->rt_se =3D NULL;
 	ag->tg->rt_rq =3D NULL;
 #endif
-	sched_offline_group(ag->tg);
+	sched_release_group(ag->tg);
 	sched_destroy_group(ag->tg);
 }
=20
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cec173a..862af1d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9719,6 +9719,22 @@ static void sched_free_group(struct task_group *tg)
 	kmem_cache_free(task_group_cache, tg);
 }
=20
+static void sched_free_group_rcu(struct rcu_head *rcu)
+{
+	sched_free_group(container_of(rcu, struct task_group, rcu));
+}
+
+static void sched_unregister_group(struct task_group *tg)
+{
+	unregister_fair_sched_group(tg);
+	unregister_rt_sched_group(tg);
+	/*
+	 * We have to wait for yet another RCU grace period to expire, as
+	 * print_cfs_stats() might run concurrently.
+	 */
+	call_rcu(&tg->rcu, sched_free_group_rcu);
+}
+
 /* allocate runqueue etc for a new task group */
 struct task_group *sched_create_group(struct task_group *parent)
 {
@@ -9762,25 +9778,35 @@ void sched_online_group(struct task_group *tg, struct=
 task_group *parent)
 }
=20
 /* rcu callback to free various structures associated with a task group */
-static void sched_free_group_rcu(struct rcu_head *rhp)
+static void sched_unregister_group_rcu(struct rcu_head *rhp)
 {
 	/* Now it should be safe to free those cfs_rqs: */
-	sched_free_group(container_of(rhp, struct task_group, rcu));
+	sched_unregister_group(container_of(rhp, struct task_group, rcu));
 }
=20
 void sched_destroy_group(struct task_group *tg)
 {
 	/* Wait for possible concurrent references to cfs_rqs complete: */
-	call_rcu(&tg->rcu, sched_free_group_rcu);
+	call_rcu(&tg->rcu, sched_unregister_group_rcu);
 }
=20
-void sched_offline_group(struct task_group *tg)
+void sched_release_group(struct task_group *tg)
 {
 	unsigned long flags;
=20
-	/* End participation in shares distribution: */
-	unregister_fair_sched_group(tg);
-
+	/*
+	 * Unlink first, to avoid walk_tg_tree_from() from finding us (via
+	 * sched_cfs_period_timer()).
+	 *
+	 * For this to be effective, we have to wait for all pending users of
+	 * this task group to leave their RCU critical section to ensure no new
+	 * user will see our dying task group any more. Specifically ensure
+	 * that tg_unthrottle_up() won't add decayed cfs_rq's to it.
+	 *
+	 * We therefore defer calling unregister_fair_sched_group() to
+	 * sched_unregister_group() which is guarantied to get called only after the
+	 * current RCU grace period has expired.
+	 */
 	spin_lock_irqsave(&task_group_lock, flags);
 	list_del_rcu(&tg->list);
 	list_del_rcu(&tg->siblings);
@@ -9899,7 +9925,7 @@ static void cpu_cgroup_css_released(struct cgroup_subsy=
s_state *css)
 {
 	struct task_group *tg =3D css_tg(css);
=20
-	sched_offline_group(tg);
+	sched_release_group(tg);
 }
=20
 static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
@@ -9909,7 +9935,7 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_st=
ate *css)
 	/*
 	 * Relies on the RCU grace period between css_released() and this.
 	 */
-	sched_free_group(tg);
+	sched_unregister_group(tg);
 }
=20
 /*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 13950be..6e476f6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11456,8 +11456,6 @@ void free_fair_sched_group(struct task_group *tg)
 {
 	int i;
=20
-	destroy_cfs_bandwidth(tg_cfs_bandwidth(tg));
-
 	for_each_possible_cpu(i) {
 		if (tg->cfs_rq)
 			kfree(tg->cfs_rq[i]);
@@ -11534,6 +11532,8 @@ void unregister_fair_sched_group(struct task_group *t=
g)
 	struct rq *rq;
 	int cpu;
=20
+	destroy_cfs_bandwidth(tg_cfs_bandwidth(tg));
+
 	for_each_possible_cpu(cpu) {
 		if (tg->se[cpu])
 			remove_entity_load_avg(tg->se[cpu]);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index bb945f8..b48baab 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -137,13 +137,17 @@ static inline struct rq *rq_of_rt_se(struct sched_rt_en=
tity *rt_se)
 	return rt_rq->rq;
 }
=20
-void free_rt_sched_group(struct task_group *tg)
+void unregister_rt_sched_group(struct task_group *tg)
 {
-	int i;
-
 	if (tg->rt_se)
 		destroy_rt_bandwidth(&tg->rt_bandwidth);
=20
+}
+
+void free_rt_sched_group(struct task_group *tg)
+{
+	int i;
+
 	for_each_possible_cpu(i) {
 		if (tg->rt_rq)
 			kfree(tg->rt_rq[i]);
@@ -250,6 +254,8 @@ static inline struct rt_rq *rt_rq_of_se(struct sched_rt_e=
ntity *rt_se)
 	return &rq->rt;
 }
=20
+void unregister_rt_sched_group(struct task_group *tg) { }
+
 void free_rt_sched_group(struct task_group *tg) { }
=20
 int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7f1612d..0e66749 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -488,6 +488,7 @@ extern void __refill_cfs_bandwidth_runtime(struct cfs_ban=
dwidth *cfs_b);
 extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
 extern void unthrottle_cfs_rq(struct cfs_rq *cfs_rq);
=20
+extern void unregister_rt_sched_group(struct task_group *tg);
 extern void free_rt_sched_group(struct task_group *tg);
 extern int alloc_rt_sched_group(struct task_group *tg, struct task_group *pa=
rent);
 extern void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
@@ -503,7 +504,7 @@ extern struct task_group *sched_create_group(struct task_=
group *parent);
 extern void sched_online_group(struct task_group *tg,
 			       struct task_group *parent);
 extern void sched_destroy_group(struct task_group *tg);
-extern void sched_offline_group(struct task_group *tg);
+extern void sched_release_group(struct task_group *tg);
=20
 extern void sched_move_task(struct task_struct *tsk);
=20
