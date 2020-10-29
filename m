Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EEE29E9A7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgJ2Kwa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:52:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60776 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgJ2Kvu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:50 -0400
Date:   Thu, 29 Oct 2020 10:51:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603968708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GKKfJyCsfdpgMfNm5Cc4Iq9qOqaTJCPnr9cIZVoOgfg=;
        b=PenbXQBW/H14Dh831KDeqsg5GtfyvCsKeDEuUdDvFCrMAri0ZbuEOPi4lH51B74+8rR71f
        X6h1LiQr+2mhtXNLSr22miPtMUHfLI5Ly/Jk4xebSht/cvOUD+5+/ykoIQ63RZC+b9oWgA
        0nVFczlz4kujCCOeB2ZhIkY1HXPp2gDIYQLdK3IhHQ6NZ9/ax+Nj8n0b9csk4RngnbR6wV
        knPrgd6UXMaT6o1jGIzs/o7oGjOEKbhkvvIkNuzHlYKKyaPTIj1ZODGq0Fd6ZTKET9eT3d
        02NH49uBaTOfCuirPIxAcjesvjWDrhYhAxn1gWvAJo4WP6iyiN0FJUyT/j8yIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603968708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GKKfJyCsfdpgMfNm5Cc4Iq9qOqaTJCPnr9cIZVoOgfg=;
        b=/06rTWY1O81lm8iFRdreTlARk5matF3rM3XTHHVVEJU/801CEAjYEuk0kGx31ED7mufhfh
        IM1MNC2tITNbN3Cw==
From:   "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: fix exit_mm vs membarrier (v4)
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201020134715.13909-2-mathieu.desnoyers@efficios.com>
References: <20201020134715.13909-2-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Message-ID: <160396870742.397.11884092890027190780.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5bc78502322a5e4eef3f1b2a2813751dc6434143
Gitweb:        https://git.kernel.org/tip/5bc78502322a5e4eef3f1b2a2813751dc6434143
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Tue, 20 Oct 2020 09:47:13 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Oct 2020 11:00:30 +01:00

sched: fix exit_mm vs membarrier (v4)

exit_mm should issue memory barriers after user-space memory accesses,
before clearing current->mm, to order user-space memory accesses
performed prior to exit_mm before clearing tsk->mm, which has the
effect of skipping the membarrier private expedited IPIs.

exit_mm should also update the runqueue's membarrier_state so
membarrier global expedited IPIs are not sent when they are not
needed.

The membarrier system call can be issued concurrently with do_exit
if we have thread groups created with CLONE_VM but not CLONE_THREAD.

Here is the scenario I have in mind:

Two thread groups are created, A and B. Thread group B is created by
issuing clone from group A with flag CLONE_VM set, but not CLONE_THREAD.
Let's assume we have a single thread within each thread group (Thread A
and Thread B).

The AFAIU we can have:

Userspace variables:

int x = 0, y = 0;

CPU 0                   CPU 1
Thread A                Thread B
(in thread group A)     (in thread group B)

x = 1
barrier()
y = 1
exit()
exit_mm()
current->mm = NULL;
                        r1 = load y
                        membarrier()
                          skips CPU 0 (no IPI) because its current mm is NULL
                        r2 = load x
                        BUG_ON(r1 == 1 && r2 == 0)

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201020134715.13909-2-mathieu.desnoyers@efficios.com
---
 include/linux/sched/mm.h  |  5 +++++
 kernel/exit.c             | 16 +++++++++++++++-
 kernel/sched/membarrier.c | 12 ++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index d5ece7a..a91fb3a 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -347,6 +347,8 @@ static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
 
 extern void membarrier_exec_mmap(struct mm_struct *mm);
 
+extern void membarrier_update_current_mm(struct mm_struct *next_mm);
+
 #else
 #ifdef CONFIG_ARCH_HAS_MEMBARRIER_CALLBACKS
 static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
@@ -361,6 +363,9 @@ static inline void membarrier_exec_mmap(struct mm_struct *mm)
 static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
 {
 }
+static inline void membarrier_update_current_mm(struct mm_struct *next_mm)
+{
+}
 #endif
 
 #endif /* _LINUX_SCHED_MM_H */
diff --git a/kernel/exit.c b/kernel/exit.c
index 87a2d51..a3dd6b3 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -475,10 +475,24 @@ static void exit_mm(void)
 	BUG_ON(mm != current->active_mm);
 	/* more a memory barrier than a real lock */
 	task_lock(current);
+	/*
+	 * When a thread stops operating on an address space, the loop
+	 * in membarrier_private_expedited() may not observe that
+	 * tsk->mm, and the loop in membarrier_global_expedited() may
+	 * not observe a MEMBARRIER_STATE_GLOBAL_EXPEDITED
+	 * rq->membarrier_state, so those would not issue an IPI.
+	 * Membarrier requires a memory barrier after accessing
+	 * user-space memory, before clearing tsk->mm or the
+	 * rq->membarrier_state.
+	 */
+	smp_mb__after_spinlock();
+	local_irq_disable();
 	current->mm = NULL;
-	mmap_read_unlock(mm);
+	membarrier_update_current_mm(NULL);
 	enter_lazy_tlb(mm, current);
+	local_irq_enable();
 	task_unlock(current);
+	mmap_read_unlock(mm);
 	mm_update_next_owner(mm);
 	mmput(mm);
 	if (test_thread_flag(TIF_MEMDIE))
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index e23e74d..aac3292 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -76,6 +76,18 @@ void membarrier_exec_mmap(struct mm_struct *mm)
 	this_cpu_write(runqueues.membarrier_state, 0);
 }
 
+void membarrier_update_current_mm(struct mm_struct *next_mm)
+{
+	struct rq *rq = this_rq();
+	int membarrier_state = 0;
+
+	if (next_mm)
+		membarrier_state = atomic_read(&next_mm->membarrier_state);
+	if (READ_ONCE(rq->membarrier_state) == membarrier_state)
+		return;
+	WRITE_ONCE(rq->membarrier_state, membarrier_state);
+}
+
 static int membarrier_global_expedited(void)
 {
 	int cpu;
