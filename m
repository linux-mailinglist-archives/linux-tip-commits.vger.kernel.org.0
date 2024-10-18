Return-Path: <linux-tip-commits+bounces-2513-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A89EC9A36A0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Oct 2024 09:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4623D2821FB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Oct 2024 07:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8417B18D63F;
	Fri, 18 Oct 2024 07:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HMyRXouB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IuNrzCMT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B27188722;
	Fri, 18 Oct 2024 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235274; cv=none; b=E+ztHWfvP2qI+1IrNV7BzAs1OXEwPpgY/gMOx8ZNr+TbIuhnUxNO9TzGnXArwzRYeXRHg7znzuJvG35KbWpTXv7IoqjHbLJOBay/kNZtFGe7r3KyBz5bIBiNe651dmE4mmZQ6XxzIvBl0AnQlL+RpF3nTVZ8RkhxDnzp4QuS0WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235274; c=relaxed/simple;
	bh=i/l4xWW3MEXKBK92EOGuzPOprgsRyXwoOedrFzm/amI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gh6fVls7nLmmVj0eY5NMpKtxoDgpXRg7oTXioRXnhspzaNyVRhLkheR8dsjNEaiU8bJ9L5Ytl9DWx2zdATCWsnRx0AvafoUILMJBYvnjTyiwJMjDFecMb2iyVDfuVl4kgztEwwPfCJrd9VEetNsD+JKq3+td+UFx/VsfAH6gtFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HMyRXouB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IuNrzCMT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Oct 2024 07:07:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729235263;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dj0FILWncsaVMVZ46gc66J0gmDoGiBLOB/kkZFFLmt4=;
	b=HMyRXouBQR2gxqLHhIcDAe2KqK8ZFpJupIRpFIxJp5a0IoXiJnY6VRqeIowbIimAycSGmY
	N160dKYRSkoGhczKmmqhLiG5SxfAlJHNQn1Y41P/c/wrcrLsN1t8FUiI2gIAeIJwmd0Dcs
	5L7YysqNtmIlRHSsL3PVPQi1qEuOjv41mpFxt+m5WMFmXIqHNCo43G5ZtCUSBYX6VXybAd
	+a13KHMabE+ISvmr7WiwghPtTl7A9aexgxdiyZp5EhFcUR2EVfp4Ic/OuBBu2I5iWQhnSs
	9cXZHJMGGvD1Az9vMu0geeouqVpwBqdL/bcs0qlLU53v/K+n/plq+/wqEiv31g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729235263;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dj0FILWncsaVMVZ46gc66J0gmDoGiBLOB/kkZFFLmt4=;
	b=IuNrzCMTF6sLNOAPT5aj+SHV4pJc6vm1uHyG0nLFPJADIX/m92PG4UE280H/jVYk4pern0
	yj2T3KwRIg4InpAA==
From: "tip-bot2 for Connor O'Brien" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add move_queued_task_locked helper
Cc: "Connor O'Brien" <connoro@google.com>, John Stultz <jstultz@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Metin Kaya <metin.kaya@arm.com>, Valentin Schneider <vschneid@redhat.com>,
 Qais Yousef <qyousef@layalina.io>, K Prateek Nayak <kprateek.nayak@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241009235352.1614323-5-jstultz@google.com>
References: <20241009235352.1614323-5-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172923526255.1442.5036039111433625204.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2b05a0b4c08ffd6dedfbd27af8708742cde39b95
Gitweb:        https://git.kernel.org/tip/2b05a0b4c08ffd6dedfbd27af8708742cde39b95
Author:        Connor O'Brien <connoro@google.com>
AuthorDate:    Wed, 09 Oct 2024 16:53:37 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Oct 2024 12:52:41 +02:00

sched: Add move_queued_task_locked helper

Switch logic that deactivates, sets the task cpu,
and reactivates a task on a different rq to use a
helper that will be later extended to push entire
blocked task chains.

This patch was broken out from a larger chain migration
patch originally by Connor O'Brien.

[jstultz: split out from larger chain migration patch]
Signed-off-by: Connor O'Brien <connoro@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Metin Kaya <metin.kaya@arm.com>
Link: https://lore.kernel.org/r/20241009235352.1614323-5-jstultz@google.com
---
 kernel/sched/core.c     | 13 +++----------
 kernel/sched/deadline.c |  8 ++------
 kernel/sched/rt.c       |  8 ++------
 kernel/sched/sched.h    | 12 ++++++++++++
 4 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f5ec452..ab0b775 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2620,9 +2620,7 @@ int push_cpu_stop(void *arg)
 
 	// XXX validate p is still the highest prio task
 	if (task_rq(p) == rq) {
-		deactivate_task(rq, p, 0);
-		set_task_cpu(p, lowest_rq->cpu);
-		activate_task(lowest_rq, p, 0);
+		move_queued_task_locked(rq, lowest_rq, p);
 		resched_curr(lowest_rq);
 	}
 
@@ -3309,9 +3307,7 @@ static void __migrate_swap_task(struct task_struct *p, int cpu)
 		rq_pin_lock(src_rq, &srf);
 		rq_pin_lock(dst_rq, &drf);
 
-		deactivate_task(src_rq, p, 0);
-		set_task_cpu(p, cpu);
-		activate_task(dst_rq, p, 0);
+		move_queued_task_locked(src_rq, dst_rq, p);
 		wakeup_preempt(dst_rq, p, 0);
 
 		rq_unpin_lock(dst_rq, &drf);
@@ -6300,10 +6296,7 @@ static bool try_steal_cookie(int this, int that)
 		if (sched_task_is_throttled(p, this))
 			goto next;
 
-		deactivate_task(src, p, 0);
-		set_task_cpu(p, this);
-		activate_task(dst, p, 0);
-
+		move_queued_task_locked(src, dst, p);
 		resched_curr(dst);
 
 		success = true;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index be1b917..4acf5e3 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2751,9 +2751,7 @@ retry:
 		goto retry;
 	}
 
-	deactivate_task(rq, next_task, 0);
-	set_task_cpu(next_task, later_rq->cpu);
-	activate_task(later_rq, next_task, 0);
+	move_queued_task_locked(rq, later_rq, next_task);
 	ret = 1;
 
 	resched_curr(later_rq);
@@ -2839,9 +2837,7 @@ static void pull_dl_task(struct rq *this_rq)
 			if (is_migration_disabled(p)) {
 				push_task = get_push_task(src_rq);
 			} else {
-				deactivate_task(src_rq, p, 0);
-				set_task_cpu(p, this_cpu);
-				activate_task(this_rq, p, 0);
+				move_queued_task_locked(src_rq, this_rq, p);
 				dmin = p->dl.deadline;
 				resched = true;
 			}
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 172c588..e2506ab 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2088,9 +2088,7 @@ retry:
 		goto retry;
 	}
 
-	deactivate_task(rq, next_task, 0);
-	set_task_cpu(next_task, lowest_rq->cpu);
-	activate_task(lowest_rq, next_task, 0);
+	move_queued_task_locked(rq, lowest_rq, next_task);
 	resched_curr(lowest_rq);
 	ret = 1;
 
@@ -2361,9 +2359,7 @@ static void pull_rt_task(struct rq *this_rq)
 			if (is_migration_disabled(p)) {
 				push_task = get_push_task(src_rq);
 			} else {
-				deactivate_task(src_rq, p, 0);
-				set_task_cpu(p, this_cpu);
-				activate_task(this_rq, p, 0);
+				move_queued_task_locked(src_rq, this_rq, p);
 				resched = true;
 			}
 			/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 20b6e75..71ce1b0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3788,6 +3788,18 @@ static inline void init_sched_mm_cid(struct task_struct *t) { }
 
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
 extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
+#ifdef CONFIG_SMP
+static inline
+void move_queued_task_locked(struct rq *src_rq, struct rq *dst_rq, struct task_struct *task)
+{
+	lockdep_assert_rq_held(src_rq);
+	lockdep_assert_rq_held(dst_rq);
+
+	deactivate_task(src_rq, task, 0);
+	set_task_cpu(task, dst_rq->cpu);
+	activate_task(dst_rq, task, 0);
+}
+#endif
 
 #ifdef CONFIG_RT_MUTEXES
 

