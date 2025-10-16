Return-Path: <linux-tip-commits+bounces-6828-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE88BE2692
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2511A62270
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED40031A553;
	Thu, 16 Oct 2025 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qqnk7Tt9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fiVgh3tt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C929A3191B7;
	Thu, 16 Oct 2025 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607205; cv=none; b=AQNpFAKFApo49ZDwS+FI1e9gytVJnbXYmczXH+9mXpOhfI9WmFUFEK4xATrf24AlbjdgqtT9YiDApVRvGPB6WWUU1V6POQaHSU9laZ/v9nBa2RF5MSWalsu89+8RcjneMJ3qarj7ssoenkvLTio+OQ/WrEjGR9FsaXqh8wMBSzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607205; c=relaxed/simple;
	bh=TGsCRgvXK4HYqIS5ckswblU5W+eRqUaW6hbUzJww7FA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pmVX3QDF1GRV+I9pHECk+llCaBnczxJOHjUGWflCE4orLt9Rv4r8UAh/a46aT1+QsbG5bLe82HlRIVJZpa1VPiLasorlOYPpW/ES7AaT2yLo28roddKuTpyeSLNrpUKWhDGdigiuVlQFmoaUkmHG3gmlONUZw2d+G8QFgLtWAPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qqnk7Tt9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fiVgh3tt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:33:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607202;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D7W2HRUKjNXmmS7cz6FIvDawVg5wPLHt+NS99V+bZnM=;
	b=qqnk7Tt9KmzGvBgDGYHF2okYp7v4MB7zsI40AzxpEuIA0/2Lrcy2/1Gcsy582yLTxcKtt+
	skZjzx2BpiyZ77aBj4bWoPHLPpkwMZC6vI8AElHB2XXFSHwuFxf8K9zHtc1oCTfxo6dBgo
	FJorq621MyvKxU4JUsuXkq2onRMULYkU+dUWHU8wFZ15crf1vlRsT8b77kmFN4H/Q8iLFF
	DCr+dhKiHu3jjgp65gQbkrUrnnIp0D9IBV+uuR05q0VJ6VAuv6I/NLViBRQkBYIyst15YF
	Goxwe/g495fZ+8HtN5uXEEFBP147ztMOIJAVbdSMapLy/YK32quBqbvUbQKD/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607202;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D7W2HRUKjNXmmS7cz6FIvDawVg5wPLHt+NS99V+bZnM=;
	b=fiVgh3ttHrYxwOjXuCXGPJrpFTfL8NKjb7PHkdobAr/OnvN3lau2rmjGrUjYyhsIpML1S1
	tZMpxcdKoFddOTDQ==
From: "tip-bot2 for Joel Fernandes" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add support to pick functions to take rf
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251006105453.648473106@infradead.org>
References: <20251006105453.648473106@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060720065.709179.17591197089192611866.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     50653216e4ff7a74c95b2ee9ec439916875556ec
Gitweb:        https://git.kernel.org/tip/50653216e4ff7a74c95b2ee9ec439916875=
556ec
Author:        Joel Fernandes <joelagnelf@nvidia.com>
AuthorDate:    Sat, 09 Aug 2025 14:47:50 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:55 +02:00

sched: Add support to pick functions to take rf

Some pick functions like the internal pick_next_task_fair() already take
rf but some others dont. We need this for scx's server pick function.
Prepare for this by having pick functions accept it.

[peterz: - added RETRY_TASK handling
         - removed pick_next_task_fair indirection]
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched.h    |  7 ++-----
 kernel/sched/core.c      | 35 ++++++++++++++++++++++++++---------
 kernel/sched/deadline.c  |  8 ++++----
 kernel/sched/ext.c       |  2 +-
 kernel/sched/fair.c      | 26 ++++++--------------------
 kernel/sched/idle.c      |  2 +-
 kernel/sched/rt.c        |  2 +-
 kernel/sched/sched.h     | 10 ++++++----
 kernel/sched/stop_task.c |  2 +-
 9 files changed, 48 insertions(+), 46 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 77426c3..0757647 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -637,8 +637,8 @@ struct sched_rt_entity {
 #endif
 } __randomize_layout;
=20
-typedef bool (*dl_server_has_tasks_f)(struct sched_dl_entity *);
-typedef struct task_struct *(*dl_server_pick_f)(struct sched_dl_entity *);
+struct rq_flags;
+typedef struct task_struct *(*dl_server_pick_f)(struct sched_dl_entity *, st=
ruct rq_flags *rf);
=20
 struct sched_dl_entity {
 	struct rb_node			rb_node;
@@ -730,9 +730,6 @@ struct sched_dl_entity {
 	 * dl_server_update().
 	 *
 	 * @rq the runqueue this server is for
-	 *
-	 * @server_has_tasks() returns true if @server_pick return a
-	 * runnable task.
 	 */
 	struct rq			*rq;
 	dl_server_pick_f		server_pick_task;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9fc990f..a75d456 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5901,7 +5901,7 @@ __pick_next_task(struct rq *rq, struct task_struct *pre=
v, struct rq_flags *rf)
=20
 		/* Assume the next prioritized class is idle_sched_class */
 		if (!p) {
-			p =3D pick_task_idle(rq);
+			p =3D pick_task_idle(rq, rf);
 			put_prev_set_next_task(rq, prev, p);
 		}
=20
@@ -5913,11 +5913,15 @@ restart:
=20
 	for_each_active_class(class) {
 		if (class->pick_next_task) {
-			p =3D class->pick_next_task(rq, prev);
+			p =3D class->pick_next_task(rq, prev, rf);
+			if (unlikely(p =3D=3D RETRY_TASK))
+				goto restart;
 			if (p)
 				return p;
 		} else {
-			p =3D class->pick_task(rq);
+			p =3D class->pick_task(rq, rf);
+			if (unlikely(p =3D=3D RETRY_TASK))
+				goto restart;
 			if (p) {
 				put_prev_set_next_task(rq, prev, p);
 				return p;
@@ -5947,7 +5951,11 @@ static inline bool cookie_match(struct task_struct *a,=
 struct task_struct *b)
 	return a->core_cookie =3D=3D b->core_cookie;
 }
=20
-static inline struct task_struct *pick_task(struct rq *rq)
+/*
+ * Careful; this can return RETRY_TASK, it does not include the retry-loop
+ * itself due to the whole SMT pick retry thing below.
+ */
+static inline struct task_struct *pick_task(struct rq *rq, struct rq_flags *=
rf)
 {
 	const struct sched_class *class;
 	struct task_struct *p;
@@ -5955,7 +5963,7 @@ static inline struct task_struct *pick_task(struct rq *=
rq)
 	rq->dl_server =3D NULL;
=20
 	for_each_active_class(class) {
-		p =3D class->pick_task(rq);
+		p =3D class->pick_task(rq, rf);
 		if (p)
 			return p;
 	}
@@ -5970,7 +5978,7 @@ static void queue_core_balance(struct rq *rq);
 static struct task_struct *
 pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
-	struct task_struct *next, *p, *max =3D NULL;
+	struct task_struct *next, *p, *max;
 	const struct cpumask *smt_mask;
 	bool fi_before =3D false;
 	bool core_clock_updated =3D (rq =3D=3D rq->core);
@@ -6055,7 +6063,10 @@ pick_next_task(struct rq *rq, struct task_struct *prev=
, struct rq_flags *rf)
 	 * and there are no cookied tasks running on siblings.
 	 */
 	if (!need_sync) {
-		next =3D pick_task(rq);
+restart_single:
+		next =3D pick_task(rq, rf);
+		if (unlikely(next =3D=3D RETRY_TASK))
+			goto restart_single;
 		if (!next->core_cookie) {
 			rq->core_pick =3D NULL;
 			rq->core_dl_server =3D NULL;
@@ -6075,6 +6086,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev,=
 struct rq_flags *rf)
 	 *
 	 * Tie-break prio towards the current CPU
 	 */
+restart_multi:
+	max =3D NULL;
 	for_each_cpu_wrap(i, smt_mask, cpu) {
 		rq_i =3D cpu_rq(i);
=20
@@ -6086,7 +6099,11 @@ pick_next_task(struct rq *rq, struct task_struct *prev=
, struct rq_flags *rf)
 		if (i !=3D cpu && (rq_i !=3D rq->core || !core_clock_updated))
 			update_rq_clock(rq_i);
=20
-		rq_i->core_pick =3D p =3D pick_task(rq_i);
+		p =3D pick_task(rq_i, rf);
+		if (unlikely(p =3D=3D RETRY_TASK))
+			goto restart_multi;
+
+		rq_i->core_pick =3D p;
 		rq_i->core_dl_server =3D rq_i->dl_server;
=20
 		if (!max || prio_less(max, p, fi_before))
@@ -6108,7 +6125,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev,=
 struct rq_flags *rf)
 			if (cookie)
 				p =3D sched_core_find(rq_i, cookie);
 			if (!p)
-				p =3D idle_sched_class.pick_task(rq_i);
+				p =3D idle_sched_class.pick_task(rq_i, rf);
 		}
=20
 		rq_i->core_pick =3D p;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 83e6175..48357d4 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2352,7 +2352,7 @@ static struct sched_dl_entity *pick_next_dl_entity(stru=
ct dl_rq *dl_rq)
  * __pick_next_task_dl - Helper to pick the next -deadline task to run.
  * @rq: The runqueue to pick the next task from.
  */
-static struct task_struct *__pick_task_dl(struct rq *rq)
+static struct task_struct *__pick_task_dl(struct rq *rq, struct rq_flags *rf)
 {
 	struct sched_dl_entity *dl_se;
 	struct dl_rq *dl_rq =3D &rq->dl;
@@ -2366,7 +2366,7 @@ again:
 	WARN_ON_ONCE(!dl_se);
=20
 	if (dl_server(dl_se)) {
-		p =3D dl_se->server_pick_task(dl_se);
+		p =3D dl_se->server_pick_task(dl_se, rf);
 		if (!p) {
 			dl_server_stop(dl_se);
 			goto again;
@@ -2379,9 +2379,9 @@ again:
 	return p;
 }
=20
-static struct task_struct *pick_task_dl(struct rq *rq)
+static struct task_struct *pick_task_dl(struct rq *rq, struct rq_flags *rf)
 {
-	return __pick_task_dl(rq);
+	return __pick_task_dl(rq, rf);
 }
=20
 static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct ta=
sk_struct *next)
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 949c3a6..dc743ca 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2332,7 +2332,7 @@ static struct task_struct *first_local_task(struct rq *=
rq)
 					struct task_struct, scx.dsq_list.node);
 }
=20
-static struct task_struct *pick_task_scx(struct rq *rq)
+static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags *rf)
 {
 	struct task_struct *prev =3D rq->curr;
 	struct task_struct *p;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 23ac05c..2554055 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8705,15 +8705,6 @@ static void set_cpus_allowed_fair(struct task_struct *=
p, struct affinity_context
 	set_task_max_allowed_capacity(p);
 }
=20
-static int
-balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
-{
-	if (sched_fair_runnable(rq))
-		return 1;
-
-	return sched_balance_newidle(rq, rf) !=3D 0;
-}
-
 static void set_next_buddy(struct sched_entity *se)
 {
 	for_each_sched_entity(se) {
@@ -8822,7 +8813,7 @@ preempt:
 	resched_curr_lazy(rq);
 }
=20
-static struct task_struct *pick_task_fair(struct rq *rq)
+static struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf)
 {
 	struct sched_entity *se;
 	struct cfs_rq *cfs_rq;
@@ -8866,7 +8857,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct *=
prev, struct rq_flags *rf
 	int new_tasks;
=20
 again:
-	p =3D pick_task_fair(rq);
+	p =3D pick_task_fair(rq, rf);
 	if (!p)
 		goto idle;
 	se =3D &p->se;
@@ -8945,14 +8936,10 @@ idle:
 	return NULL;
 }
=20
-static struct task_struct *__pick_next_task_fair(struct rq *rq, struct task_=
struct *prev)
-{
-	return pick_next_task_fair(rq, prev, NULL);
-}
-
-static struct task_struct *fair_server_pick_task(struct sched_dl_entity *dl_=
se)
+static struct task_struct *
+fair_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
 {
-	return pick_task_fair(dl_se->rq);
+	return pick_task_fair(dl_se->rq, rf);
 }
=20
 void fair_server_init(struct rq *rq)
@@ -13644,11 +13631,10 @@ DEFINE_SCHED_CLASS(fair) =3D {
 	.wakeup_preempt		=3D check_preempt_wakeup_fair,
=20
 	.pick_task		=3D pick_task_fair,
-	.pick_next_task		=3D __pick_next_task_fair,
+	.pick_next_task		=3D pick_next_task_fair,
 	.put_prev_task		=3D put_prev_task_fair,
 	.set_next_task          =3D set_next_task_fair,
=20
-	.balance		=3D balance_fair,
 	.select_task_rq		=3D select_task_rq_fair,
 	.migrate_task_rq	=3D migrate_task_rq_fair,
=20
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 055b0dd..7fa0b59 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -466,7 +466,7 @@ static void set_next_task_idle(struct rq *rq, struct task=
_struct *next, bool fir
 	next->se.exec_start =3D rq_clock_task(rq);
 }
=20
-struct task_struct *pick_task_idle(struct rq *rq)
+struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf)
 {
 	scx_update_idle(rq, true, false);
 	return rq->idle;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 9bc828d..1fd97f2 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1695,7 +1695,7 @@ static struct task_struct *_pick_next_task_rt(struct rq=
 *rq)
 	return rt_task_of(rt_se);
 }
=20
-static struct task_struct *pick_task_rt(struct rq *rq)
+static struct task_struct *pick_task_rt(struct rq *rq, struct rq_flags *rf)
 {
 	struct task_struct *p;
=20
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f4a3230..8946294 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2470,7 +2470,7 @@ struct sched_class {
 	/*
 	 * schedule/pick_next_task: rq->lock
 	 */
-	struct task_struct *(*pick_task)(struct rq *rq);
+	struct task_struct *(*pick_task)(struct rq *rq, struct rq_flags *rf);
 	/*
 	 * Optional! When implemented pick_next_task() should be equivalent to:
 	 *
@@ -2480,7 +2480,8 @@ struct sched_class {
 	 *       set_next_task_first(next);
 	 *   }
 	 */
-	struct task_struct *(*pick_next_task)(struct rq *rq, struct task_struct *pr=
ev);
+	struct task_struct *(*pick_next_task)(struct rq *rq, struct task_struct *pr=
ev,
+					      struct rq_flags *rf);
=20
 	/*
 	 * sched_change:
@@ -2707,8 +2708,9 @@ static inline bool sched_fair_runnable(struct rq *rq)
 	return rq->cfs.nr_queued > 0;
 }
=20
-extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_st=
ruct *prev, struct rq_flags *rf);
-extern struct task_struct *pick_task_idle(struct rq *rq);
+extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_st=
ruct *prev,
+					       struct rq_flags *rf);
+extern struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf=
);
=20
 #define SCA_CHECK		0x01
 #define SCA_MIGRATE_DISABLE	0x02
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index d98c453..4f9192b 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -32,7 +32,7 @@ static void set_next_task_stop(struct rq *rq, struct task_s=
truct *stop, bool fir
 	stop->se.exec_start =3D rq_clock_task(rq);
 }
=20
-static struct task_struct *pick_task_stop(struct rq *rq)
+static struct task_struct *pick_task_stop(struct rq *rq, struct rq_flags *rf)
 {
 	if (!sched_stop_runnable(rq))
 		return NULL;

