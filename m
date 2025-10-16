Return-Path: <linux-tip-commits+bounces-6835-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E83E4BE26C2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23E254FC76A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD9831D383;
	Thu, 16 Oct 2025 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WEQ0yKSY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Plnd0nT1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D9031B82B;
	Thu, 16 Oct 2025 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607214; cv=none; b=TDxvFTV5J61b+VLbftWxo0rHEx+Ru6DsHCjeSB4S3k27qoOsAOw5JJwepYX1qYsGxQ3ZeQu1FS4YcxrqeXrM91U44IpOMHi83ImxVOuTgKIISdt7DqaUmN9RMMQ7+BWPIqATO7BDWSpvVygvI/0SpiaQc15wKU2n7hFp4khY0Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607214; c=relaxed/simple;
	bh=xP2aAY8yVx1GFZJmWc3ymGaQppnsvrr0r2fm3swV+Y8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rTjlQbsr3YbV9f4VwWKNw/5LcNl0X08wiElOrI76K94C7IGIq6+y7pvQfcoWFkLJ3ozazJuNS0eJ12qxqXJ6uWJcctcOS0OSNgrFtd1QbnlJqFCinYZffwtKpPkwI+m2qw+ewLMYhFjyLpvRAjojUKjOy6H3aJlyGx/m911BZNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WEQ0yKSY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Plnd0nT1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:33:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607211;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=drOJLu1lL+6CLCDCMeHSAsjtnuftM+3fDHdB5I9x7fg=;
	b=WEQ0yKSYwA23WQAY2E8AeytxoHTcI08R3XAC6vrt0TMbKFJZhA2Kz/dDBvlCr/CiN2LPiH
	ZAT37QBfSinGk3osktfl4S6C45H5FiJxJlZPFYIYpmUPEEDGBJpi4HfRAIi5TkAo2qExTL
	sgm4yseERKDFDJOruzgANVE6eZjpo0NgqcIFvMahyb1W+Bni0xux+Kf76wbIEhZKVePdW7
	Gy3p2NXGXbd5+sS5Zv6a/uiHraihWrlXYvZ1tV3mTgYWuJDsRF75eORsjmReNS7g0lg1Lu
	kXcv07DXm3NtKojRozek42qLyWFfkGGDeHxEcYx7JPqMZ1OMlEatn4WwKyrd3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607211;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=drOJLu1lL+6CLCDCMeHSAsjtnuftM+3fDHdB5I9x7fg=;
	b=Plnd0nT1q7rseYqH5VUaVl4PZS59xMGTYlhghs57plS80V/qErGFu4EHJnnD7o/flSiyr7
	Vqc/gFntpU6sWCDg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Rename do_set_cpus_allowed()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251006104527.451083206@infradead.org>
References: <20251006104527.451083206@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060721000.709179.18438808475383206036.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b079d93796528053cde322f2ca838c2d21c297e7
Gitweb:        https://git.kernel.org/tip/b079d93796528053cde322f2ca838c2d21c=
297e7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Sep 2025 10:08:05 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:53 +02:00

sched: Rename do_set_cpus_allowed()

Hopefully saner naming.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched.h  |  4 ++--
 kernel/cgroup/cpuset.c |  2 +-
 kernel/kthread.c       |  4 ++--
 kernel/sched/core.c    | 16 ++++++++--------
 kernel/sched/sched.h   |  2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index cbb7340..77426c3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1861,8 +1861,8 @@ extern int task_can_attach(struct task_struct *p);
 extern int dl_bw_alloc(int cpu, u64 dl_bw);
 extern void dl_bw_free(int cpu, u64 dl_bw);
=20
-/* do_set_cpus_allowed() - consider using set_cpus_allowed_ptr() instead */
-extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask =
*new_mask);
+/* set_cpus_allowed_force() - consider using set_cpus_allowed_ptr() instead =
*/
+extern void set_cpus_allowed_force(struct task_struct *p, const struct cpuma=
sk *new_mask);
=20
 /**
  * set_cpus_allowed_ptr - set CPU affinity mask of a task
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 52468d2..185e820 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4180,7 +4180,7 @@ bool cpuset_cpus_allowed_fallback(struct task_struct *t=
sk)
 	rcu_read_lock();
 	cs_mask =3D task_cs(tsk)->cpus_allowed;
 	if (is_in_v2_mode() && cpumask_subset(cs_mask, possible_mask)) {
-		do_set_cpus_allowed(tsk, cs_mask);
+		set_cpus_allowed_force(tsk, cs_mask);
 		changed =3D true;
 	}
 	rcu_read_unlock();
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 832bd2a..99a3808 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -599,7 +599,7 @@ static void __kthread_bind_mask(struct task_struct *p, co=
nst struct cpumask *mas
 	}
=20
 	scoped_guard (raw_spinlock_irqsave, &p->pi_lock)
-		do_set_cpus_allowed(p, mask);
+		set_cpus_allowed_force(p, mask);
=20
 	/* It's safe because the task is inactive. */
 	p->flags |=3D PF_NO_SETAFFINITY;
@@ -880,7 +880,7 @@ int kthread_affine_preferred(struct task_struct *p, const=
 struct cpumask *mask)
 	kthread_fetch_affinity(kthread, affinity);
=20
 	scoped_guard (raw_spinlock_irqsave, &p->pi_lock)
-		do_set_cpus_allowed(p, affinity);
+		set_cpus_allowed_force(p, affinity);
=20
 	mutex_unlock(&kthreads_hotplug_lock);
 out:
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 805e650..638bffd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2331,7 +2331,7 @@ unsigned long wait_task_inactive(struct task_struct *p,=
 unsigned int match_state
 }
=20
 static void
-__do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx);
+do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx);
=20
 static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
 {
@@ -2348,7 +2348,7 @@ static void migrate_disable_switch(struct rq *rq, struc=
t task_struct *p)
=20
 	scoped_guard (task_rq_lock, p) {
 		update_rq_clock(scope.rq);
-		__do_set_cpus_allowed(p, &ac);
+		do_set_cpus_allowed(p, &ac);
 	}
 }
=20
@@ -2662,7 +2662,7 @@ void set_cpus_allowed_common(struct task_struct *p, str=
uct affinity_context *ctx
 }
=20
 static void
-__do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
+do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 {
 	struct rq *rq =3D task_rq(p);
 	bool queued, running;
@@ -2692,7 +2692,7 @@ __do_set_cpus_allowed(struct task_struct *p, struct aff=
inity_context *ctx)
  * Used for kthread_bind() and select_fallback_rq(), in both cases the user
  * affinity (if any) should be destroyed too.
  */
-void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_ma=
sk)
+void set_cpus_allowed_force(struct task_struct *p, const struct cpumask *new=
_mask)
 {
 	struct affinity_context ac =3D {
 		.new_mask  =3D new_mask,
@@ -2706,7 +2706,7 @@ void do_set_cpus_allowed(struct task_struct *p, const s=
truct cpumask *new_mask)
=20
 	scoped_guard (__task_rq_lock, p) {
 		update_rq_clock(scope.rq);
-		__do_set_cpus_allowed(p, &ac);
+		do_set_cpus_allowed(p, &ac);
 	}
=20
 	/*
@@ -2745,7 +2745,7 @@ int dup_user_cpus_ptr(struct task_struct *dst, struct t=
ask_struct *src,
 	 * Use pi_lock to protect content of user_cpus_ptr
 	 *
 	 * Though unlikely, user_cpus_ptr can be reset to NULL by a concurrent
-	 * do_set_cpus_allowed().
+	 * set_cpus_allowed_force().
 	 */
 	raw_spin_lock_irqsave(&src->pi_lock, flags);
 	if (src->user_cpus_ptr) {
@@ -3073,7 +3073,7 @@ static int __set_cpus_allowed_ptr_locked(struct task_st=
ruct *p,
 		goto out;
 	}
=20
-	__do_set_cpus_allowed(p, ctx);
+	do_set_cpus_allowed(p, ctx);
=20
 	return affine_move_task(rq, p, rf, dest_cpu, ctx->flags);
=20
@@ -3482,7 +3482,7 @@ static int select_fallback_rq(int cpu, struct task_stru=
ct *p)
 			}
 			fallthrough;
 		case possible:
-			do_set_cpus_allowed(p, task_cpu_fallback_mask(p));
+			set_cpus_allowed_force(p, task_cpu_fallback_mask(p));
 			state =3D fail;
 			break;
 		case fail:
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b23ce9c..ea2ea8f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2617,7 +2617,7 @@ static inline bool task_allowed_on_cpu(struct task_stru=
ct *p, int cpu)
 static inline cpumask_t *alloc_user_cpus_ptr(int node)
 {
 	/*
-	 * See do_set_cpus_allowed() above for the rcu_head usage.
+	 * See set_cpus_allowed_force() above for the rcu_head usage.
 	 */
 	int size =3D max_t(int, cpumask_size(), sizeof(struct rcu_head));
=20

