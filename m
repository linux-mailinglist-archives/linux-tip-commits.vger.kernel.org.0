Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD2A29E9AA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgJ2Kwi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:52:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60762 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgJ2Kvt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:49 -0400
Date:   Thu, 29 Oct 2020 10:51:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603968707;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=773iFDmIRCiK7AimWc3nu+vIYasWQaqR8+9ya7hBwGE=;
        b=Ji3v+x2mk3QIIAlLppMDoNk4E+asf+B7jgQLs6VFVn9hm31D4EuvIuLg6FvoI3Fz9aH6bL
        oG3/dxgzFGmqGymVZBpt/Bwzw2P4N5J2viiXLYrzc4dua6vhMZ4FogaYx8l1kTM89f5OsU
        YlyFmvU+DWLb2jRQs50pFeq14Letquywg/VZrLVkvY2MDcTMZEJ9GTIrJhceSjvZ4SPfvP
        3dIrvks6sg99cLClkQqfGZ0g4oSul+R4/Xf4sRs1f77Jt/BhIhx+RVlyiAcjZEJ72QvwDJ
        jLfYWX80BC7D2BqnQalDXQt1E+dC4vaNYdtQPzGepTNBA29c+xDTUolnS8BycA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603968707;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=773iFDmIRCiK7AimWc3nu+vIYasWQaqR8+9ya7hBwGE=;
        b=UWNdZhstEn5M89EuLH0+7bsqOHq+MB6mKbSiu3gbbl629dEjmWVin+XTN6aEo3TXaHoSGt
        ogOK1W5t6jPeMjDA==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: membarrier: cover kthread_use_mm (v4)
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201020134715.13909-3-mathieu.desnoyers@efficios.com>
References: <20201020134715.13909-3-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <160396870681.397.6742175131689946098.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     618758ed3a4f7d790414d020b362111748ebbf9f
Gitweb:        https://git.kernel.org/tip/618758ed3a4f7d790414d020b362111748ebbf9f
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Tue, 20 Oct 2020 09:47:14 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Oct 2020 11:00:31 +01:00

sched: membarrier: cover kthread_use_mm (v4)

Add comments and memory barrier to kthread_use_mm and kthread_unuse_mm
to allow the effect of membarrier(2) to apply to kthreads accessing
user-space memory as well.

Given that no prior kthread use this guarantee and that it only affects
kthreads, adding this guarantee does not affect user-space ABI.

Refine the check in membarrier_global_expedited to exclude runqueues
running the idle thread rather than all kthreads from the IPI cpumask.

Now that membarrier_global_expedited can IPI kthreads, the scheduler
also needs to update the runqueue's membarrier_state when entering lazy
TLB state.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201020134715.13909-3-mathieu.desnoyers@efficios.com
---
 kernel/kthread.c          | 21 +++++++++++++++++++++
 kernel/sched/idle.c       |  1 +
 kernel/sched/membarrier.c |  7 +++----
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index e29773c..481428f 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1248,6 +1248,7 @@ void kthread_use_mm(struct mm_struct *mm)
 		tsk->active_mm = mm;
 	}
 	tsk->mm = mm;
+	membarrier_update_current_mm(mm);
 	switch_mm_irqs_off(active_mm, mm, tsk);
 	local_irq_enable();
 	task_unlock(tsk);
@@ -1255,8 +1256,19 @@ void kthread_use_mm(struct mm_struct *mm)
 	finish_arch_post_lock_switch();
 #endif
 
+	/*
+	 * When a kthread starts operating on an address space, the loop
+	 * in membarrier_{private,global}_expedited() may not observe
+	 * that tsk->mm, and not issue an IPI. Membarrier requires a
+	 * memory barrier after storing to tsk->mm, before accessing
+	 * user-space memory. A full memory barrier for membarrier
+	 * {PRIVATE,GLOBAL}_EXPEDITED is implicitly provided by
+	 * mmdrop(), or explicitly with smp_mb().
+	 */
 	if (active_mm != mm)
 		mmdrop(active_mm);
+	else
+		smp_mb();
 
 	to_kthread(tsk)->oldfs = force_uaccess_begin();
 }
@@ -1276,9 +1288,18 @@ void kthread_unuse_mm(struct mm_struct *mm)
 	force_uaccess_end(to_kthread(tsk)->oldfs);
 
 	task_lock(tsk);
+	/*
+	 * When a kthread stops operating on an address space, the loop
+	 * in membarrier_{private,global}_expedited() may not observe
+	 * that tsk->mm, and not issue an IPI. Membarrier requires a
+	 * memory barrier after accessing user-space memory, before
+	 * clearing tsk->mm.
+	 */
+	smp_mb__after_spinlock();
 	sync_mm_rss(mm);
 	local_irq_disable();
 	tsk->mm = NULL;
+	membarrier_update_current_mm(NULL);
 	/* active_mm is still 'mm' */
 	enter_lazy_tlb(mm, tsk);
 	local_irq_enable();
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 24d0ee2..846743e 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -338,6 +338,7 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
 	WARN_ON_ONCE(!(current->flags & PF_KTHREAD));
 	WARN_ON_ONCE(!(current->flags & PF_NO_SETAFFINITY));
 	WARN_ON_ONCE(!duration_ns);
+	WARN_ON_ONCE(current->mm);
 
 	rcu_sleep_check();
 	preempt_disable();
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index aac3292..f223f35 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -126,12 +126,11 @@ static int membarrier_global_expedited(void)
 			continue;
 
 		/*
-		 * Skip the CPU if it runs a kernel thread. The scheduler
-		 * leaves the prior task mm in place as an optimization when
-		 * scheduling a kthread.
+		 * Skip the CPU if it runs a kernel thread which is not using
+		 * a task mm.
 		 */
 		p = rcu_dereference(cpu_rq(cpu)->curr);
-		if (p->flags & PF_KTHREAD)
+		if (!p->mm)
 			continue;
 
 		__cpumask_set_cpu(cpu, tmpmask);
