Return-Path: <linux-tip-commits+bounces-6836-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0106BE26BC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC7F1A623C2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C6631DD82;
	Thu, 16 Oct 2025 09:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Imjfp+eL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fuf8EOGM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7DB31D362;
	Thu, 16 Oct 2025 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607216; cv=none; b=bHou3aKZkycQ0ZciPvOtpyzFpY7Y39ApkqvktA769N/2dJeLsaG04jpMcLxqvvm5KOxzGRnSzZSAUjlruylHqnF3vWf9U0Oe1LUQMdEpKY1RErQ0A6KrPMDCf5gT95Z83K7d0VasllrD5AbZI3DqqKueJcZXgSFzpswdNx1istY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607216; c=relaxed/simple;
	bh=WpkXnO3YFKOOPXz+N55muTfrrfWnRguhCd4Rjz3S5KI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nDvGgRZ1/2Sfcp0FKOULhF03z0TA17j2+qvOzV/0X+KXlnvqwmDZSlePqZwlOIwHU8BPi/dcgIpmj6j/8ElLDYjTjHN7GSKQHVzdCQl670yGw1nSt/bhmpk+DzqnblOp7adxu1yTjBeWwd8pBUFxjrTI25H/zI44OYProV0DDAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Imjfp+eL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fuf8EOGM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:33:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607212;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+pfteC6e3NudTHYFZMQsmFjHjU4qedi/EVwsxelKZM=;
	b=Imjfp+eL69pR4olNaEP5g9ErDws5JW1nzVuISbpnIiMmExuV5i8C8tcDcZRqxv35sgQZeO
	zX5jDjy7GBAfCd/4UiLwH5kVfs8G4nlCdUHGgq7Z+pYlim1DMy8TDzppMqKoDgbnNAo99Y
	UUqZhQxXegSym4HHC28h5+7lEoUgawv8tOvz/SkEHVUwD1UYxZSJq8k6B4OhWsbPt/mewb
	2ygGyOFBu86fYaCkfZNgDdNmi5agJdjGAYaO+XrXlxe54Y5WCl8hxuuF6vSwsnKWCePeJA
	fdspM8a/1jMVLrJPc5bCjWu1q1Fz9uqB7EePwwaih7E/36w5wLko8QT9NHP2Aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607212;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+pfteC6e3NudTHYFZMQsmFjHjU4qedi/EVwsxelKZM=;
	b=Fuf8EOGMS8syI3iGOsXy+n5jmHDDH8RepwwEqHXUu2JHLXq/6PEj+XHrBLw6BI7cPfVJY0
	gIHBSro52aKKg1Dg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix do_set_cpus_allowed() locking
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251006104527.331463972@infradead.org>
References: <20251006104527.331463972@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060721130.709179.2781016112003184998.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     abfc01077df66593f128d966fdad1d042facc9ac
Gitweb:        https://git.kernel.org/tip/abfc01077df66593f128d966fdad1d042fa=
cc9ac
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Sep 2025 09:51:06 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:52 +02:00

sched: Fix do_set_cpus_allowed() locking

All callers of do_set_cpus_allowed() only take p->pi_lock, which is
not sufficient to actually change the cpumask. Again, this is mostly
ok in these cases, but it results in unnecessarily complicated
reasoning.

Furthermore, there is no reason what so ever to not just take all the
required locks, so do just that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/kthread.c     | 15 +++++----------
 kernel/sched/core.c  | 21 +++++++--------------
 kernel/sched/sched.h |  5 +++++
 3 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 31b072e..832bd2a 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -593,18 +593,16 @@ EXPORT_SYMBOL(kthread_create_on_node);
=20
 static void __kthread_bind_mask(struct task_struct *p, const struct cpumask =
*mask, unsigned int state)
 {
-	unsigned long flags;
-
 	if (!wait_task_inactive(p, state)) {
 		WARN_ON(1);
 		return;
 	}
=20
+	scoped_guard (raw_spinlock_irqsave, &p->pi_lock)
+		do_set_cpus_allowed(p, mask);
+
 	/* It's safe because the task is inactive. */
-	raw_spin_lock_irqsave(&p->pi_lock, flags);
-	do_set_cpus_allowed(p, mask);
 	p->flags |=3D PF_NO_SETAFFINITY;
-	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
 }
=20
 static void __kthread_bind(struct task_struct *p, unsigned int cpu, unsigned=
 int state)
@@ -857,7 +855,6 @@ int kthread_affine_preferred(struct task_struct *p, const=
 struct cpumask *mask)
 {
 	struct kthread *kthread =3D to_kthread(p);
 	cpumask_var_t affinity;
-	unsigned long flags;
 	int ret =3D 0;
=20
 	if (!wait_task_inactive(p, TASK_UNINTERRUPTIBLE) || kthread->started) {
@@ -882,10 +879,8 @@ int kthread_affine_preferred(struct task_struct *p, cons=
t struct cpumask *mask)
 	list_add_tail(&kthread->hotplug_node, &kthreads_hotplug);
 	kthread_fetch_affinity(kthread, affinity);
=20
-	/* It's safe because the task is inactive. */
-	raw_spin_lock_irqsave(&p->pi_lock, flags);
-	do_set_cpus_allowed(p, affinity);
-	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+	scoped_guard (raw_spinlock_irqsave, &p->pi_lock)
+		do_set_cpus_allowed(p, affinity);
=20
 	mutex_unlock(&kthreads_hotplug_lock);
 out:
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f2d16d1..805e650 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2668,18 +2668,14 @@ __do_set_cpus_allowed(struct task_struct *p, struct a=
ffinity_context *ctx)
 	bool queued, running;
=20
 	lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_rq_held(rq);
=20
 	queued =3D task_on_rq_queued(p);
 	running =3D task_current_donor(rq, p);
=20
-	if (queued) {
-		/*
-		 * Because __kthread_bind() calls this on blocked tasks without
-		 * holding rq->lock.
-		 */
-		lockdep_assert_rq_held(rq);
+	if (queued)
 		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
-	}
+
 	if (running)
 		put_prev_task(rq, p);
=20
@@ -2708,7 +2704,10 @@ void do_set_cpus_allowed(struct task_struct *p, const =
struct cpumask *new_mask)
 		struct rcu_head rcu;
 	};
=20
-	__do_set_cpus_allowed(p, &ac);
+	scoped_guard (__task_rq_lock, p) {
+		update_rq_clock(scope.rq);
+		__do_set_cpus_allowed(p, &ac);
+	}
=20
 	/*
 	 * Because this is called with p->pi_lock held, it is not possible
@@ -3483,12 +3482,6 @@ static int select_fallback_rq(int cpu, struct task_str=
uct *p)
 			}
 			fallthrough;
 		case possible:
-			/*
-			 * XXX When called from select_task_rq() we only
-			 * hold p->pi_lock and again violate locking order.
-			 *
-			 * More yuck to audit.
-			 */
 			do_set_cpus_allowed(p, task_cpu_fallback_mask(p));
 			state =3D fail;
 			break;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index bcde43d..b23ce9c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1847,6 +1847,11 @@ DEFINE_LOCK_GUARD_1(task_rq_lock, struct task_struct,
 		    task_rq_unlock(_T->rq, _T->lock, &_T->rf),
 		    struct rq *rq; struct rq_flags rf)
=20
+DEFINE_LOCK_GUARD_1(__task_rq_lock, struct task_struct,
+		    _T->rq =3D __task_rq_lock(_T->lock, &_T->rf),
+		    __task_rq_unlock(_T->rq, &_T->rf),
+		    struct rq *rq; struct rq_flags rf)
+
 static inline void rq_lock_irqsave(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
 {

