Return-Path: <linux-tip-commits+bounces-6831-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524CBBE26A1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502AF1A625CC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C2531A7FE;
	Thu, 16 Oct 2025 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gtJLXnUX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B3n3GYps"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C826131A7E3;
	Thu, 16 Oct 2025 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607209; cv=none; b=amXnLrI1+HV7j6awFNa5MafhX/uAihnVpWzGJpx99W6cqROe3uE0wA4qxTl4pwY44Lap4tOYrMz27GQ4ehKSqcv4XX1fpf40op5+4CcKUJk3o/6WhVssa37yTQnmQ/3ECHAtySHwm+gkljWZqr4VJOPb/I1kSLdnJwgMcwUbhrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607209; c=relaxed/simple;
	bh=IYliglgal+lZ0PjwebrHFy3JQk1aO4ZCIjs8Zvg0ygo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eOZdqbT6HLzvyQVws00bQu71+pmHz8FCnwADaVcCv/POIEcI0IuO0XWqMdyuX+e/au91VnUeHVFRA7zZUfExKAbCP66fr5lZ38SttWcqD1iboRDJnYV2hifUqf6pRC9YUAtXJBjmMm5zTS1KzABUBHcALj+TBgN+5UPJz+s0QA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gtJLXnUX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B3n3GYps; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:33:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saWi7dyk8jsmiE5+OP+ksFdozHF+h2bEq3pm/vhVdPg=;
	b=gtJLXnUXR8UpWbHaTcdWJQ40evnUBbThH27BY6Ic+4imCY2J4/jwqxcBvempHm/P7w80uB
	xpAyoQSOhWKRAmj+CVyslIrM3urotOdcT7XqUhXAWixVQypEN16fndz8OX9t60yo/DTpcR
	9aaHHDaLEqrb0b423HpnZFP4tWAvVzZ/ElP+HvwtkMOI9D60ljm5/rwFqrnsT0y6a+cENW
	V5ng5BYjxGGgNs/7HesyWZerfYSGIl6cot4V/De9kLvYASE87lXMCVBad/WKCv+fvmiKoF
	Uklxq8WTtUgxcVNhy7MrM+D0Yn2mR/WabIGE5GR+G7DVaz44KfjdnJedAlmxDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=saWi7dyk8jsmiE5+OP+ksFdozHF+h2bEq3pm/vhVdPg=;
	b=B3n3GYpsGHsdP5aCbiJz/aEONAZhSAwh+Xl6I+OZUEjeJ9FXSymr1pVXazToImrS7QFmKP
	2vaHmlk9alZX3oAw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Cleanup the sched_change NOCLOCK usage
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251006104527.928947651@infradead.org>
References: <20251006104527.928947651@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060720464.709179.18344719544175290384.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d4c64207b88a60dd15a38c790bb73c0b6f9a8c40
Gitweb:        https://git.kernel.org/tip/d4c64207b88a60dd15a38c790bb73c0b6f9=
a8c40
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 11 Sep 2025 12:09:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:54 +02:00

sched: Cleanup the sched_change NOCLOCK usage

Teach the sched_change pattern how to do update_rq_clock(); this
allows for some simplifications / cleanups.

Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c     | 33 +++++++++++----------------------
 kernel/sched/ext.c      |  4 +---
 kernel/sched/syscalls.c |  8 ++------
 3 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e715147..3d5659f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2346,10 +2346,8 @@ static void migrate_disable_switch(struct rq *rq, stru=
ct task_struct *p)
 	if (p->cpus_ptr !=3D &p->cpus_mask)
 		return;
=20
-	scoped_guard (task_rq_lock, p) {
-		update_rq_clock(scope.rq);
+	scoped_guard (task_rq_lock, p)
 		do_set_cpus_allowed(p, &ac);
-	}
 }
=20
 void ___migrate_enable(void)
@@ -2666,9 +2664,7 @@ void set_cpus_allowed_common(struct task_struct *p, str=
uct affinity_context *ctx
 static void
 do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 {
-	u32 flags =3D DEQUEUE_SAVE | DEQUEUE_NOCLOCK;
-
-	scoped_guard (sched_change, p, flags) {
+	scoped_guard (sched_change, p, DEQUEUE_SAVE) {
 		p->sched_class->set_cpus_allowed(p, ctx);
 		mm_set_cpus_allowed(p->mm, ctx->new_mask);
 	}
@@ -2690,10 +2686,8 @@ void set_cpus_allowed_force(struct task_struct *p, con=
st struct cpumask *new_mas
 		struct rcu_head rcu;
 	};
=20
-	scoped_guard (__task_rq_lock, p) {
-		update_rq_clock(scope.rq);
+	scoped_guard (__task_rq_lock, p)
 		do_set_cpus_allowed(p, &ac);
-	}
=20
 	/*
 	 * Because this is called with p->pi_lock held, it is not possible
@@ -9108,16 +9102,13 @@ static void sched_change_group(struct task_struct *ts=
k)
  */
 void sched_move_task(struct task_struct *tsk, bool for_autogroup)
 {
-	unsigned int queue_flags =3D
-		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
+	unsigned int queue_flags =3D DEQUEUE_SAVE | DEQUEUE_MOVE;
 	bool resched =3D false;
 	struct rq *rq;
=20
 	CLASS(task_rq_lock, rq_guard)(tsk);
 	rq =3D rq_guard.rq;
=20
-	update_rq_clock(rq);
-
 	scoped_guard (sched_change, tsk, queue_flags) {
 		sched_change_group(tsk);
 		if (!for_autogroup)
@@ -10792,16 +10783,14 @@ struct sched_change_ctx *sched_change_begin(struct =
task_struct *p, unsigned int=20
=20
 	lockdep_assert_rq_held(rq);
=20
+	if (!(flags & DEQUEUE_NOCLOCK)) {
+		update_rq_clock(rq);
+		flags |=3D DEQUEUE_NOCLOCK;
+	}
+
 	if (flags & DEQUEUE_CLASS) {
-		if (p->sched_class->switching_from) {
-			/*
-			 * switching_from_fair() assumes CLASS implies NOCLOCK;
-			 * fixing this assumption would mean switching_from()
-			 * would need to be able to change flags.
-			 */
-			WARN_ON(!(flags & DEQUEUE_NOCLOCK));
+		if (p->sched_class->switching_from)
 			p->sched_class->switching_from(rq, p);
-		}
 	}
=20
 	*ctx =3D (struct sched_change_ctx){
@@ -10840,7 +10829,7 @@ void sched_change_end(struct sched_change_ctx *ctx)
 		p->sched_class->switching_to(rq, p);
=20
 	if (ctx->queued)
-		enqueue_task(rq, p, ctx->flags | ENQUEUE_NOCLOCK);
+		enqueue_task(rq, p, ctx->flags);
 	if (ctx->running)
 		set_next_task(rq, p);
=20
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ad371b6..5717042 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4654,7 +4654,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct=
 bpf_link *link)
 	percpu_down_write(&scx_fork_rwsem);
 	scx_task_iter_start(&sti);
 	while ((p =3D scx_task_iter_next_locked(&sti))) {
-		unsigned int queue_flags =3D DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
+		unsigned int queue_flags =3D DEQUEUE_SAVE | DEQUEUE_MOVE;
 		const struct sched_class *old_class =3D p->sched_class;
 		const struct sched_class *new_class =3D
 			__setscheduler_class(p->policy, p->prio);
@@ -4662,8 +4662,6 @@ static int scx_enable(struct sched_ext_ops *ops, struct=
 bpf_link *link)
 		if (!tryget_task_struct(p))
 			continue;
=20
-		update_rq_clock(task_rq(p));
-
 		if (old_class !=3D new_class)
 			queue_flags |=3D DEQUEUE_CLASS;
=20
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 20af564..8f0f603 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -64,7 +64,6 @@ static int effective_prio(struct task_struct *p)
=20
 void set_user_nice(struct task_struct *p, long nice)
 {
-	struct rq *rq;
 	int old_prio;
=20
 	if (task_nice(p) =3D=3D nice || nice < MIN_NICE || nice > MAX_NICE)
@@ -73,10 +72,7 @@ void set_user_nice(struct task_struct *p, long nice)
 	 * We have to be careful, if called from sys_setpriority(),
 	 * the task might be in the middle of scheduling on another CPU.
 	 */
-	CLASS(task_rq_lock, rq_guard)(p);
-	rq =3D rq_guard.rq;
-
-	update_rq_clock(rq);
+	guard(task_rq_lock)(p);
=20
 	/*
 	 * The RT priorities are set via sched_setscheduler(), but we still
@@ -89,7 +85,7 @@ void set_user_nice(struct task_struct *p, long nice)
 		return;
 	}
=20
-	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK) {
+	scoped_guard (sched_change, p, DEQUEUE_SAVE) {
 		p->static_prio =3D NICE_TO_PRIO(nice);
 		set_load_weight(p, true);
 		old_prio =3D p->prio;

