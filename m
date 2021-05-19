Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C1D38891A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 May 2021 10:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244262AbhESIK3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 May 2021 04:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244200AbhESIK2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 May 2021 04:10:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79B0C061760;
        Wed, 19 May 2021 01:09:08 -0700 (PDT)
Date:   Wed, 19 May 2021 08:09:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621411747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SDf2RK70zNXt4sEisnIJXbINNOVO1yuZrkPiaobVoeY=;
        b=WyGlgcMy9bGCrfs83b2WqFzTp4bSuXnH24B8AgWMRTN3tsUC0cAdt5q6gj0vrVrVjCvb3r
        gCy+v47Z/QIZa5ynZPKzQ0YV87DZKx09mPWz/wcHBb2RaJ02N71I6At30mffoNv4Cz8Zlb
        j09nu80SWdLW0WXlRU5uDKeN9KW/9/pTEieIz840tL4Z/4aZj4mmfGjOjhMR7zubHAPF+u
        AocghVXbvqKqEv5fkANWG1NuBhfD/XaxYf43yw+5K6qmR3lmP1dF+dwd/gwJxEJbN2cZ3P
        hIxOmKXLt0uM3vgV/6zlcgIIOgiGegS3KFrBwSNNiI95pXHwLmblbmDOI2raUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621411747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SDf2RK70zNXt4sEisnIJXbINNOVO1yuZrkPiaobVoeY=;
        b=J1D4ZeNjXTLcngbL3fXCDHbWSsrv7AlWxzFEz8gSQqPWS/tlwxiJOjP3p2GdqWNeBoAfRL
        pplKvOSXX8DbzVCw==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Make the idle task quack like a per-CPU kthread
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210510151024.2448573-2-valentin.schneider@arm.com>
References: <20210510151024.2448573-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <162141174663.29796.7676215251563616030.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     00b89fe0197f0c55a045775c11553c0cdb7082fe
Gitweb:        https://git.kernel.org/tip/00b89fe0197f0c55a045775c11553c0cdb7082fe
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 10 May 2021 16:10:23 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 May 2021 12:53:53 +02:00

sched: Make the idle task quack like a per-CPU kthread

For all intents and purposes, the idle task is a per-CPU kthread. It isn't
created via the same route as other pcpu kthreads however, and as a result
it is missing a few bells and whistles: it fails kthread_is_per_cpu() and
it doesn't have PF_NO_SETAFFINITY set.

Fix the former by giving the idle task a kthread struct along with the
KTHREAD_IS_PER_CPU flag. This requires some extra iffery as init_idle()
call be called more than once on the same idle task.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210510151024.2448573-2-valentin.schneider@arm.com
---
 include/linux/kthread.h |  2 ++
 kernel/kthread.c        | 30 ++++++++++++++++++------------
 kernel/sched/core.c     | 21 +++++++++++++++------
 3 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 2484ed9..d9133d6 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -33,6 +33,8 @@ struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data),
 					  unsigned int cpu,
 					  const char *namefmt);
 
+void set_kthread_struct(struct task_struct *p);
+
 void kthread_set_per_cpu(struct task_struct *k, int cpu);
 bool kthread_is_per_cpu(struct task_struct *k);
 
diff --git a/kernel/kthread.c b/kernel/kthread.c
index fe3f2a4..3d32683 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -68,16 +68,6 @@ enum KTHREAD_BITS {
 	KTHREAD_SHOULD_PARK,
 };
 
-static inline void set_kthread_struct(void *kthread)
-{
-	/*
-	 * We abuse ->set_child_tid to avoid the new member and because it
-	 * can't be wrongly copied by copy_process(). We also rely on fact
-	 * that the caller can't exec, so PF_KTHREAD can't be cleared.
-	 */
-	current->set_child_tid = (__force void __user *)kthread;
-}
-
 static inline struct kthread *to_kthread(struct task_struct *k)
 {
 	WARN_ON(!(k->flags & PF_KTHREAD));
@@ -103,6 +93,22 @@ static inline struct kthread *__to_kthread(struct task_struct *p)
 	return kthread;
 }
 
+void set_kthread_struct(struct task_struct *p)
+{
+	struct kthread *kthread;
+
+	if (__to_kthread(p))
+		return;
+
+	kthread = kzalloc(sizeof(*kthread), GFP_KERNEL);
+	/*
+	 * We abuse ->set_child_tid to avoid the new member and because it
+	 * can't be wrongly copied by copy_process(). We also rely on fact
+	 * that the caller can't exec, so PF_KTHREAD can't be cleared.
+	 */
+	p->set_child_tid = (__force void __user *)kthread;
+}
+
 void free_kthread_struct(struct task_struct *k)
 {
 	struct kthread *kthread;
@@ -272,8 +278,8 @@ static int kthread(void *_create)
 	struct kthread *self;
 	int ret;
 
-	self = kzalloc(sizeof(*self), GFP_KERNEL);
-	set_kthread_struct(self);
+	set_kthread_struct(current);
+	self = to_kthread(current);
 
 	/* If user was SIGKILLed, I release the structure. */
 	done = xchg(&create->done, NULL);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 24fd795..6a5124c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8234,12 +8234,25 @@ void __init init_idle(struct task_struct *idle, int cpu)
 
 	__sched_fork(0, idle);
 
+	/*
+	 * The idle task doesn't need the kthread struct to function, but it
+	 * is dressed up as a per-CPU kthread and thus needs to play the part
+	 * if we want to avoid special-casing it in code that deals with per-CPU
+	 * kthreads.
+	 */
+	set_kthread_struct(idle);
+
 	raw_spin_lock_irqsave(&idle->pi_lock, flags);
 	raw_spin_rq_lock(rq);
 
 	idle->state = TASK_RUNNING;
 	idle->se.exec_start = sched_clock();
-	idle->flags |= PF_IDLE;
+	/*
+	 * PF_KTHREAD should already be set at this point; regardless, make it
+	 * look like a proper per-CPU kthread.
+	 */
+	idle->flags |= PF_IDLE | PF_KTHREAD | PF_NO_SETAFFINITY;
+	kthread_set_per_cpu(idle, cpu);
 
 	scs_task_reset(idle);
 	kasan_unpoison_task_stack(idle);
@@ -8456,12 +8469,8 @@ static void balance_push(struct rq *rq)
 	/*
 	 * Both the cpu-hotplug and stop task are in this case and are
 	 * required to complete the hotplug process.
-	 *
-	 * XXX: the idle task does not match kthread_is_per_cpu() due to
-	 * histerical raisins.
 	 */
-	if (rq->idle == push_task ||
-	    kthread_is_per_cpu(push_task) ||
+	if (kthread_is_per_cpu(push_task) ||
 	    is_migration_disabled(push_task)) {
 
 		/*
