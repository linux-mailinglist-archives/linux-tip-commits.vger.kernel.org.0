Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C312B8F88
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Nov 2020 11:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgKSJzI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Nov 2020 04:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgKSJzG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Nov 2020 04:55:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CDEC0613CF;
        Thu, 19 Nov 2020 01:55:06 -0800 (PST)
Date:   Thu, 19 Nov 2020 09:55:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605779704;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pAmtfGnkNQT9zTVrWSa4I+WYswSL3b4IO6dTE2fNO3Y=;
        b=g1Nyc7a0/VJRNsgVB4Qtp0J/ccJYJ7Kd6ApTPd3D+3E51WTEczY0UWN3WtT6UP12Wq3vWh
        wB1FjhZ1VmFpHjFnRtgWgkB9A1OWZJYBXiT/OI+VMEEmrUopC4NfpfiwuuBIBpbJF1Fwdx
        hpdf8/RNLEelCYCbiZVtI0TO4GbI7sLC+3ulUDXjbYUPk+k28oeJZtaTO6baayb5b6pMe9
        HhtRJiPRcQae//eYuGkLxzSXp/7iJM6C9vwzZTQC750vGvIrKKvsfNEDhOUcIgGLV4wfBX
        bhGSnF8exJoWs9B4uZonQ7hrD1n5Qa8GrDoBSJuBnxd+w3aoUg5n6Lm2fgZnkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605779704;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pAmtfGnkNQT9zTVrWSa4I+WYswSL3b4IO6dTE2fNO3Y=;
        b=nTwztLfl8b00HgsrpvSxJdN9zu0qy+VdLlQBLi9NTJ/vGf+4jzvhXKq+N03hAVeOdgWd9R
        7krKXMX50W07TLDg==
From:   "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/deadline: Fix priority inheritance with
 multiple scheduling classes
Cc:     Glenn Elliott <glenn@aurora.tech>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201117061432.517340-1-juri.lelli@redhat.com>
References: <20201117061432.517340-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Message-ID: <160577970394.11244.17346286293391652296.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     2279f540ea7d05f22d2f0c4224319330228586bc
Gitweb:        https://git.kernel.org/tip/2279f540ea7d05f22d2f0c4224319330228=
586bc
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Tue, 17 Nov 2020 07:14:32 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 17 Nov 2020 13:15:28 +01:00

sched/deadline: Fix priority inheritance with multiple scheduling classes

Glenn reported that "an application [he developed produces] a BUG in
deadline.c when a SCHED_DEADLINE task contends with CFS tasks on nested
PTHREAD_PRIO_INHERIT mutexes.  I believe the bug is triggered when a CFS
task that was boosted by a SCHED_DEADLINE task boosts another CFS task
(nested priority inheritance).

 ------------[ cut here ]------------
 kernel BUG at kernel/sched/deadline.c:1462!
 invalid opcode: 0000 [#1] PREEMPT SMP
 CPU: 12 PID: 19171 Comm: dl_boost_bug Tainted: ...
 Hardware name: ...
 RIP: 0010:enqueue_task_dl+0x335/0x910
 Code: ...
 RSP: 0018:ffffc9000c2bbc68 EFLAGS: 00010002
 RAX: 0000000000000009 RBX: ffff888c0af94c00 RCX: ffffffff81e12500
 RDX: 000000000000002e RSI: ffff888c0af94c00 RDI: ffff888c10b22600
 RBP: ffffc9000c2bbd08 R08: 0000000000000009 R09: 0000000000000078
 R10: ffffffff81e12440 R11: ffffffff81e1236c R12: ffff888bc8932600
 R13: ffff888c0af94eb8 R14: ffff888c10b22600 R15: ffff888bc8932600
 FS:  00007fa58ac55700(0000) GS:ffff888c10b00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007fa58b523230 CR3: 0000000bf44ab003 CR4: 00000000007606e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  ? intel_pstate_update_util_hwp+0x13/0x170
  rt_mutex_setprio+0x1cc/0x4b0
  task_blocks_on_rt_mutex+0x225/0x260
  rt_spin_lock_slowlock_locked+0xab/0x2d0
  rt_spin_lock_slowlock+0x50/0x80
  hrtimer_grab_expiry_lock+0x20/0x30
  hrtimer_cancel+0x13/0x30
  do_nanosleep+0xa0/0x150
  hrtimer_nanosleep+0xe1/0x230
  ? __hrtimer_init_sleeper+0x60/0x60
  __x64_sys_nanosleep+0x8d/0xa0
  do_syscall_64+0x4a/0x100
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
 RIP: 0033:0x7fa58b52330d
 ...
 ---[ end trace 0000000000000002 ]=E2=80=94

He also provided a simple reproducer creating the situation below:

 So the execution order of locking steps are the following
 (N1 and N2 are non-deadline tasks. D1 is a deadline task. M1 and M2
 are mutexes that are enabled * with priority inheritance.)

 Time moves forward as this timeline goes down:

 N1              N2               D1
 |               |                |
 |               |                |
 Lock(M1)        |                |
 |               |                |
 |             Lock(M2)           |
 |               |                |
 |               |              Lock(M2)
 |               |                |
 |             Lock(M1)           |
 |             (!!bug triggered!) |

Daniel reported a similar situation as well, by just letting ksoftirqd
run with DEADLINE (and eventually block on a mutex).

Problem is that boosted entities (Priority Inheritance) use static
DEADLINE parameters of the top priority waiter. However, there might be
cases where top waiter could be a non-DEADLINE entity that is currently
boosted by a DEADLINE entity from a different lock chain (i.e., nested
priority chains involving entities of non-DEADLINE classes). In this
case, top waiter static DEADLINE parameters could be null (initialized
to 0 at fork()) and replenish_dl_entity() would hit a BUG().

Fix this by keeping track of the original donor and using its parameters
when a task is boosted.

Reported-by: Glenn Elliott <glenn@aurora.tech>
Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Link: https://lkml.kernel.org/r/20201117061432.517340-1-juri.lelli@redhat.com
---
 include/linux/sched.h   | 10 +++-
 kernel/sched/core.c     | 11 ++---
 kernel/sched/deadline.c | 97 +++++++++++++++++++++-------------------
 3 files changed, 68 insertions(+), 50 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0e91b45..095fdec 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -551,7 +551,6 @@ struct sched_dl_entity {
 	 * overruns.
 	 */
 	unsigned int			dl_throttled      : 1;
-	unsigned int			dl_boosted        : 1;
 	unsigned int			dl_yielded        : 1;
 	unsigned int			dl_non_contending : 1;
 	unsigned int			dl_overrun	  : 1;
@@ -570,6 +569,15 @@ struct sched_dl_entity {
 	 * time.
 	 */
 	struct hrtimer inactive_timer;
+
+#ifdef CONFIG_RT_MUTEXES
+	/*
+	 * Priority Inheritance. When a DEADLINE scheduling entity is boosted
+	 * pi_se points to the donor, otherwise points to the dl_se it belongs
+	 * to (the original one/itself).
+	 */
+	struct sched_dl_entity *pi_se;
+#endif
 };
=20
 #ifdef CONFIG_UCLAMP_TASK
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9f0ebfb..e7e4534 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4912,20 +4912,21 @@ void rt_mutex_setprio(struct task_struct *p, struct t=
ask_struct *pi_task)
 		if (!dl_prio(p->normal_prio) ||
 		    (pi_task && dl_prio(pi_task->prio) &&
 		     dl_entity_preempt(&pi_task->dl, &p->dl))) {
-			p->dl.dl_boosted =3D 1;
+			p->dl.pi_se =3D pi_task->dl.pi_se;
 			queue_flag |=3D ENQUEUE_REPLENISH;
-		} else
-			p->dl.dl_boosted =3D 0;
+		} else {
+			p->dl.pi_se =3D &p->dl;
+		}
 		p->sched_class =3D &dl_sched_class;
 	} else if (rt_prio(prio)) {
 		if (dl_prio(oldprio))
-			p->dl.dl_boosted =3D 0;
+			p->dl.pi_se =3D &p->dl;
 		if (oldprio < prio)
 			queue_flag |=3D ENQUEUE_HEAD;
 		p->sched_class =3D &rt_sched_class;
 	} else {
 		if (dl_prio(oldprio))
-			p->dl.dl_boosted =3D 0;
+			p->dl.pi_se =3D &p->dl;
 		if (rt_prio(oldprio))
 			p->rt.timeout =3D 0;
 		p->sched_class =3D &fair_sched_class;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 6d93f45..949bc5c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -43,6 +43,28 @@ static inline int on_dl_rq(struct sched_dl_entity *dl_se)
 	return !RB_EMPTY_NODE(&dl_se->rb_node);
 }
=20
+#ifdef CONFIG_RT_MUTEXES
+static inline struct sched_dl_entity *pi_of(struct sched_dl_entity *dl_se)
+{
+	return dl_se->pi_se;
+}
+
+static inline bool is_dl_boosted(struct sched_dl_entity *dl_se)
+{
+	return pi_of(dl_se) !=3D dl_se;
+}
+#else
+static inline struct sched_dl_entity *pi_of(struct sched_dl_entity *dl_se)
+{
+	return dl_se;
+}
+
+static inline bool is_dl_boosted(struct sched_dl_entity *dl_se)
+{
+	return false;
+}
+#endif
+
 #ifdef CONFIG_SMP
 static inline struct dl_bw *dl_bw_of(int i)
 {
@@ -698,7 +720,7 @@ static inline void setup_new_dl_entity(struct sched_dl_en=
tity *dl_se)
 	struct dl_rq *dl_rq =3D dl_rq_of_se(dl_se);
 	struct rq *rq =3D rq_of_dl_rq(dl_rq);
=20
-	WARN_ON(dl_se->dl_boosted);
+	WARN_ON(is_dl_boosted(dl_se));
 	WARN_ON(dl_time_before(rq_clock(rq), dl_se->deadline));
=20
 	/*
@@ -736,21 +758,20 @@ static inline void setup_new_dl_entity(struct sched_dl_=
entity *dl_se)
  * could happen are, typically, a entity voluntarily trying to overcome its
  * runtime, or it just underestimated it during sched_setattr().
  */
-static void replenish_dl_entity(struct sched_dl_entity *dl_se,
-				struct sched_dl_entity *pi_se)
+static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 {
 	struct dl_rq *dl_rq =3D dl_rq_of_se(dl_se);
 	struct rq *rq =3D rq_of_dl_rq(dl_rq);
=20
-	BUG_ON(pi_se->dl_runtime <=3D 0);
+	BUG_ON(pi_of(dl_se)->dl_runtime <=3D 0);
=20
 	/*
 	 * This could be the case for a !-dl task that is boosted.
 	 * Just go with full inherited parameters.
 	 */
 	if (dl_se->dl_deadline =3D=3D 0) {
-		dl_se->deadline =3D rq_clock(rq) + pi_se->dl_deadline;
-		dl_se->runtime =3D pi_se->dl_runtime;
+		dl_se->deadline =3D rq_clock(rq) + pi_of(dl_se)->dl_deadline;
+		dl_se->runtime =3D pi_of(dl_se)->dl_runtime;
 	}
=20
 	if (dl_se->dl_yielded && dl_se->runtime > 0)
@@ -763,8 +784,8 @@ static void replenish_dl_entity(struct sched_dl_entity *d=
l_se,
 	 * arbitrary large.
 	 */
 	while (dl_se->runtime <=3D 0) {
-		dl_se->deadline +=3D pi_se->dl_period;
-		dl_se->runtime +=3D pi_se->dl_runtime;
+		dl_se->deadline +=3D pi_of(dl_se)->dl_period;
+		dl_se->runtime +=3D pi_of(dl_se)->dl_runtime;
 	}
=20
 	/*
@@ -778,8 +799,8 @@ static void replenish_dl_entity(struct sched_dl_entity *d=
l_se,
 	 */
 	if (dl_time_before(dl_se->deadline, rq_clock(rq))) {
 		printk_deferred_once("sched: DL replenish lagged too much\n");
-		dl_se->deadline =3D rq_clock(rq) + pi_se->dl_deadline;
-		dl_se->runtime =3D pi_se->dl_runtime;
+		dl_se->deadline =3D rq_clock(rq) + pi_of(dl_se)->dl_deadline;
+		dl_se->runtime =3D pi_of(dl_se)->dl_runtime;
 	}
=20
 	if (dl_se->dl_yielded)
@@ -812,8 +833,7 @@ static void replenish_dl_entity(struct sched_dl_entity *d=
l_se,
  * task with deadline equal to period this is the same of using
  * dl_period instead of dl_deadline in the equation above.
  */
-static bool dl_entity_overflow(struct sched_dl_entity *dl_se,
-			       struct sched_dl_entity *pi_se, u64 t)
+static bool dl_entity_overflow(struct sched_dl_entity *dl_se, u64 t)
 {
 	u64 left, right;
=20
@@ -835,9 +855,9 @@ static bool dl_entity_overflow(struct sched_dl_entity *dl=
_se,
 	 * of anything below microseconds resolution is actually fiction
 	 * (but still we want to give the user that illusion >;).
 	 */
-	left =3D (pi_se->dl_deadline >> DL_SCALE) * (dl_se->runtime >> DL_SCALE);
+	left =3D (pi_of(dl_se)->dl_deadline >> DL_SCALE) * (dl_se->runtime >> DL_SC=
ALE);
 	right =3D ((dl_se->deadline - t) >> DL_SCALE) *
-		(pi_se->dl_runtime >> DL_SCALE);
+		(pi_of(dl_se)->dl_runtime >> DL_SCALE);
=20
 	return dl_time_before(right, left);
 }
@@ -922,24 +942,23 @@ static inline bool dl_is_implicit(struct sched_dl_entit=
y *dl_se)
  * Please refer to the comments update_dl_revised_wakeup() function to find
  * more about the Revised CBS rule.
  */
-static void update_dl_entity(struct sched_dl_entity *dl_se,
-			     struct sched_dl_entity *pi_se)
+static void update_dl_entity(struct sched_dl_entity *dl_se)
 {
 	struct dl_rq *dl_rq =3D dl_rq_of_se(dl_se);
 	struct rq *rq =3D rq_of_dl_rq(dl_rq);
=20
 	if (dl_time_before(dl_se->deadline, rq_clock(rq)) ||
-	    dl_entity_overflow(dl_se, pi_se, rq_clock(rq))) {
+	    dl_entity_overflow(dl_se, rq_clock(rq))) {
=20
 		if (unlikely(!dl_is_implicit(dl_se) &&
 			     !dl_time_before(dl_se->deadline, rq_clock(rq)) &&
-			     !dl_se->dl_boosted)){
+			     !is_dl_boosted(dl_se))) {
 			update_dl_revised_wakeup(dl_se, rq);
 			return;
 		}
=20
-		dl_se->deadline =3D rq_clock(rq) + pi_se->dl_deadline;
-		dl_se->runtime =3D pi_se->dl_runtime;
+		dl_se->deadline =3D rq_clock(rq) + pi_of(dl_se)->dl_deadline;
+		dl_se->runtime =3D pi_of(dl_se)->dl_runtime;
 	}
 }
=20
@@ -1038,7 +1057,7 @@ static enum hrtimer_restart dl_task_timer(struct hrtime=
r *timer)
 	 * The task might have been boosted by someone else and might be in the
 	 * boosting/deboosting path, its not throttled.
 	 */
-	if (dl_se->dl_boosted)
+	if (is_dl_boosted(dl_se))
 		goto unlock;
=20
 	/*
@@ -1066,7 +1085,7 @@ static enum hrtimer_restart dl_task_timer(struct hrtime=
r *timer)
 	 * but do not enqueue -- wait for our wakeup to do that.
 	 */
 	if (!task_on_rq_queued(p)) {
-		replenish_dl_entity(dl_se, dl_se);
+		replenish_dl_entity(dl_se);
 		goto unlock;
 	}
=20
@@ -1156,7 +1175,7 @@ static inline void dl_check_constrained_dl(struct sched=
_dl_entity *dl_se)
=20
 	if (dl_time_before(dl_se->deadline, rq_clock(rq)) &&
 	    dl_time_before(rq_clock(rq), dl_next_period(dl_se))) {
-		if (unlikely(dl_se->dl_boosted || !start_dl_timer(p)))
+		if (unlikely(is_dl_boosted(dl_se) || !start_dl_timer(p)))
 			return;
 		dl_se->dl_throttled =3D 1;
 		if (dl_se->runtime > 0)
@@ -1287,7 +1306,7 @@ throttle:
 			dl_se->dl_overrun =3D 1;
=20
 		__dequeue_task_dl(rq, curr, 0);
-		if (unlikely(dl_se->dl_boosted || !start_dl_timer(curr)))
+		if (unlikely(is_dl_boosted(dl_se) || !start_dl_timer(curr)))
 			enqueue_task_dl(rq, curr, ENQUEUE_REPLENISH);
=20
 		if (!is_leftmost(curr, &rq->dl))
@@ -1481,8 +1500,7 @@ static void __dequeue_dl_entity(struct sched_dl_entity =
*dl_se)
 }
=20
 static void
-enqueue_dl_entity(struct sched_dl_entity *dl_se,
-		  struct sched_dl_entity *pi_se, int flags)
+enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 {
 	BUG_ON(on_dl_rq(dl_se));
=20
@@ -1493,9 +1511,9 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se,
 	 */
 	if (flags & ENQUEUE_WAKEUP) {
 		task_contending(dl_se, flags);
-		update_dl_entity(dl_se, pi_se);
+		update_dl_entity(dl_se);
 	} else if (flags & ENQUEUE_REPLENISH) {
-		replenish_dl_entity(dl_se, pi_se);
+		replenish_dl_entity(dl_se);
 	} else if ((flags & ENQUEUE_RESTORE) &&
 		  dl_time_before(dl_se->deadline,
 				 rq_clock(rq_of_dl_rq(dl_rq_of_se(dl_se))))) {
@@ -1512,19 +1530,7 @@ static void dequeue_dl_entity(struct sched_dl_entity *=
dl_se)
=20
 static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 {
-	struct task_struct *pi_task =3D rt_mutex_get_top_task(p);
-	struct sched_dl_entity *pi_se =3D &p->dl;
-
-	/*
-	 * Use the scheduling parameters of the top pi-waiter task if:
-	 * - we have a top pi-waiter which is a SCHED_DEADLINE task AND
-	 * - our dl_boosted is set (i.e. the pi-waiter's (absolute) deadline is
-	 *   smaller than our deadline OR we are a !SCHED_DEADLINE task getting
-	 *   boosted due to a SCHED_DEADLINE pi-waiter).
-	 * Otherwise we keep our runtime and deadline.
-	 */
-	if (pi_task && dl_prio(pi_task->normal_prio) && p->dl.dl_boosted) {
-		pi_se =3D &pi_task->dl;
+	if (is_dl_boosted(&p->dl)) {
 		/*
 		 * Because of delays in the detection of the overrun of a
 		 * thread's runtime, it might be the case that a thread
@@ -1557,7 +1563,7 @@ static void enqueue_task_dl(struct rq *rq, struct task_=
struct *p, int flags)
 		 * the throttle.
 		 */
 		p->dl.dl_throttled =3D 0;
-		BUG_ON(!p->dl.dl_boosted || flags !=3D ENQUEUE_REPLENISH);
+		BUG_ON(!is_dl_boosted(&p->dl) || flags !=3D ENQUEUE_REPLENISH);
 		return;
 	}
=20
@@ -1594,7 +1600,7 @@ static void enqueue_task_dl(struct rq *rq, struct task_=
struct *p, int flags)
 		return;
 	}
=20
-	enqueue_dl_entity(&p->dl, pi_se, flags);
+	enqueue_dl_entity(&p->dl, flags);
=20
 	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
 		enqueue_pushable_dl_task(rq, p);
@@ -2787,11 +2793,14 @@ void __dl_clear_params(struct task_struct *p)
 	dl_se->dl_bw			=3D 0;
 	dl_se->dl_density		=3D 0;
=20
-	dl_se->dl_boosted		=3D 0;
 	dl_se->dl_throttled		=3D 0;
 	dl_se->dl_yielded		=3D 0;
 	dl_se->dl_non_contending	=3D 0;
 	dl_se->dl_overrun		=3D 0;
+
+#ifdef CONFIG_RT_MUTEXES
+	dl_se->pi_se			=3D dl_se;
+#endif
 }
=20
 bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr)
