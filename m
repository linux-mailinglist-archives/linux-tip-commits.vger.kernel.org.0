Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AE13E7BDE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 17:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242771AbhHJPOB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 11:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242751AbhHJPN7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 11:13:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C48AC0613C1;
        Tue, 10 Aug 2021 08:13:37 -0700 (PDT)
Date:   Tue, 10 Aug 2021 15:13:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628608415;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=99r86DMBqcNbcNNyCe2+1Pqe8uv42DUNhmP2hG1oh2A=;
        b=O3qO2Omn7CTNzGMLiJXG7Sv/YFAKsgafwuwn5e17U7Ma4EJd4JpMrD9VM9JCUqHEEqifuk
        wITh7f9112jqDJQjWr7aP7hciYsb0Orvz1Nnmg2Ur45EJpM8g/ix+p5Bwa16bPSZtSVBx8
        ut273BMAz+p8vqxBpL3fjAawSMRmhlh4DvNgMK0Fw75inhtoXPNiLBSXzLNueGh03N4uSe
        aK6PGBS5QqbVlj5P+v0BLOC4pdns+vDbLsvD8NvoGtMOIu8cy7PO+x13AtWxd7YCOG6Hpl
        u8oSSh6D8I/ajBqnKm4a15bZa+HLr6ZgumXrcyrJ2Z+Lk4K9Ngt7ZdOS3smyNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628608415;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=99r86DMBqcNbcNNyCe2+1Pqe8uv42DUNhmP2hG1oh2A=;
        b=wT/4NnTykDkL7tRa3E2AT6H6OJWMu8EM1IewTMoM4IcN3eRyGT7y8vA8BwfHWRqUyhNDc1
        h4LtCrMS2vsXWuCg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Assert task sighand is locked
 while starting cputime counter
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210726125513.271824-2-frederic@kernel.org>
References: <20210726125513.271824-2-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <162860841518.395.7040517713345545393.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a5dec9f82ab2ae486119f0b0820ea16db3e522c3
Gitweb:        https://git.kernel.org/tip/a5dec9f82ab2ae486119f0b0820ea16db3e522c3
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Mon, 26 Jul 2021 14:55:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 17:09:58 +02:00

posix-cpu-timers: Assert task sighand is locked while starting cputime counter

Starting the process wide cputime counter needs to be done in the same
sighand locking sequence than actually arming the related timer otherwise
this races against concurrent timers setting/expiring in the same
threadgroup.

Detecting that the cputime counter is started without holding the sighand
lock is a first step toward debugging such situations.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210726125513.271824-2-frederic@kernel.org

---
 include/linux/sched/signal.h   |  6 ++++++
 kernel/signal.c                | 15 +++++++++++++++
 kernel/time/posix-cpu-timers.c |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index b9126fe..0310a5a 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -714,6 +714,12 @@ static inline void unlock_task_sighand(struct task_struct *task,
 	spin_unlock_irqrestore(&task->sighand->siglock, *flags);
 }
 
+#ifdef CONFIG_LOCKDEP
+extern void lockdep_assert_task_sighand_held(struct task_struct *task);
+#else
+static inline void lockdep_assert_task_sighand_held(struct task_struct *task) { }
+#endif
+
 static inline unsigned long task_rlimit(const struct task_struct *task,
 		unsigned int limit)
 {
diff --git a/kernel/signal.c b/kernel/signal.c
index a3229ad..52b6abe 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1413,6 +1413,21 @@ struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
 	return sighand;
 }
 
+#ifdef CONFIG_LOCKDEP
+void lockdep_assert_task_sighand_held(struct task_struct *task)
+{
+	struct sighand_struct *sighand;
+
+	rcu_read_lock();
+	sighand = rcu_dereference(task->sighand);
+	if (sighand)
+		lockdep_assert_held(&sighand->siglock);
+	else
+		WARN_ON_ONCE(1);
+	rcu_read_unlock();
+}
+#endif
+
 /*
  * send signal info to all the members of a group
  */
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 517be7f..4693d3c 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -291,6 +291,8 @@ static void thread_group_start_cputime(struct task_struct *tsk, u64 *samples)
 	struct thread_group_cputimer *cputimer = &tsk->signal->cputimer;
 	struct posix_cputimers *pct = &tsk->signal->posix_cputimers;
 
+	lockdep_assert_task_sighand_held(tsk);
+
 	/* Check if cputimer isn't running. This is accessed without locking. */
 	if (!READ_ONCE(pct->timers_active)) {
 		struct task_cputime sum;
