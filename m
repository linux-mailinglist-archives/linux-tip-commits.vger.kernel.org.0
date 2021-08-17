Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DDC3EF3B0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbhHQURU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbhHQUPz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7654CC061144;
        Tue, 17 Aug 2021 13:14:37 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231276;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zbb6YRNbZu2EfI9ikUVbOuHf2/Gf9DRKuH5oPB2SxG8=;
        b=13MY2aGVFFnWsmMyjWZJk03N0qWzIx2jaBob4yI8NmA9XzmC/61VjiWyoka4wX1JhPJqtp
        BPYQT8P9kY0aIvAZt3TVuqLZtJFQnFTDbDSrIY0jnxEjSgqZbElCn9PaV+PYqCbz4D09p9
        y4Qvu2/A0KcfxNxp9DeI6d/wFV9mffXnNXmHLyeecwJ/FW/tVKpsduFkTxJTOQWpYfMEJO
        LQnXZ5EJu/nKSsLkV1iNQPvwhyLMTp7AMCyCQrrYAImiv/xNrRWPE/1AyYtHCrvcZ/FWBZ
        0EQ38aawlJfgguTcTMo4asQw546VBQD+64N/hMrnk9HP8bHFuATSIP6Rt9Gs+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231276;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zbb6YRNbZu2EfI9ikUVbOuHf2/Gf9DRKuH5oPB2SxG8=;
        b=CRdK6zUH9bcdNRDRmpDixwp+OCdqZ/2gNZzZrdP4A6OGrIxEjQk6rbrGbG89A7AzFdEt/D
        4+G/z3KanMyMfYAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] sched/wakeup: Prepare for RT sleeping spin/rwlocks
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211302.258751046@linutronix.de>
References: <20210815211302.258751046@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923127531.25758.7307204097035381116.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5f220be21418541422335288b6e2360a5ce0613c
Gitweb:        https://git.kernel.org/tip/5f220be21418541422335288b6e2360a5ce0613c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:27:44 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 16:49:02 +02:00

sched/wakeup: Prepare for RT sleeping spin/rwlocks

Waiting for spinlocks and rwlocks on non RT enabled kernels is task::state
preserving. Any wakeup which matches the state is valid.

RT enabled kernels substitutes them with 'sleeping' spinlocks. This creates
an issue vs. task::__state.

In order to block on the lock, the task has to overwrite task::__state and a
consecutive wakeup issued by the unlocker sets the state back to
TASK_RUNNING. As a consequence the task loses the state which was set
before the lock acquire and also any regular wakeup targeted at the task
while it is blocked on the lock.

To handle this gracefully, add a 'saved_state' member to task_struct which
is used in the following way:

 1) When a task blocks on a 'sleeping' spinlock, the current state is saved
    in task::saved_state before it is set to TASK_RTLOCK_WAIT.

 2) When the task unblocks and after acquiring the lock, it restores the saved
    state.

 3) When a regular wakeup happens for a task while it is blocked then the
    state change of that wakeup is redirected to operate on task::saved_state.

    This is also required when the task state is running because the task
    might have been woken up from the lock wait and has not yet restored
    the saved state.

To make it complete, provide the necessary helpers to save and restore the
saved state along with the necessary documentation how the RT lock blocking
is supposed to work.

For non-RT kernels there is no functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211302.258751046@linutronix.de
---
 include/linux/sched.h | 66 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/core.c   | 33 +++++++++++++++++++++-
 2 files changed, 99 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4c72cf6..02714b9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -143,9 +143,22 @@ struct task_group;
 		current->task_state_change = _THIS_IP_;			\
 	} while (0)
 
+# define debug_rtlock_wait_set_state()					\
+	do {								 \
+		current->saved_state_change = current->task_state_change;\
+		current->task_state_change = _THIS_IP_;			 \
+	} while (0)
+
+# define debug_rtlock_wait_restore_state()				\
+	do {								 \
+		current->task_state_change = current->saved_state_change;\
+	} while (0)
+
 #else
 # define debug_normal_state_change(cond)	do { } while (0)
 # define debug_special_state_change(cond)	do { } while (0)
+# define debug_rtlock_wait_set_state()		do { } while (0)
+# define debug_rtlock_wait_restore_state()	do { } while (0)
 #endif
 
 /*
@@ -213,6 +226,51 @@ struct task_group;
 		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
 	} while (0)
 
+/*
+ * PREEMPT_RT specific variants for "sleeping" spin/rwlocks
+ *
+ * RT's spin/rwlock substitutions are state preserving. The state of the
+ * task when blocking on the lock is saved in task_struct::saved_state and
+ * restored after the lock has been acquired.  These operations are
+ * serialized by task_struct::pi_lock against try_to_wake_up(). Any non RT
+ * lock related wakeups while the task is blocked on the lock are
+ * redirected to operate on task_struct::saved_state to ensure that these
+ * are not dropped. On restore task_struct::saved_state is set to
+ * TASK_RUNNING so any wakeup attempt redirected to saved_state will fail.
+ *
+ * The lock operation looks like this:
+ *
+ *	current_save_and_set_rtlock_wait_state();
+ *	for (;;) {
+ *		if (try_lock())
+ *			break;
+ *		raw_spin_unlock_irq(&lock->wait_lock);
+ *		schedule_rtlock();
+ *		raw_spin_lock_irq(&lock->wait_lock);
+ *		set_current_state(TASK_RTLOCK_WAIT);
+ *	}
+ *	current_restore_rtlock_saved_state();
+ */
+#define current_save_and_set_rtlock_wait_state()			\
+	do {								\
+		lockdep_assert_irqs_disabled();				\
+		raw_spin_lock(&current->pi_lock);			\
+		current->saved_state = current->__state;		\
+		debug_rtlock_wait_set_state();				\
+		WRITE_ONCE(current->__state, TASK_RTLOCK_WAIT);		\
+		raw_spin_unlock(&current->pi_lock);			\
+	} while (0);
+
+#define current_restore_rtlock_saved_state()				\
+	do {								\
+		lockdep_assert_irqs_disabled();				\
+		raw_spin_lock(&current->pi_lock);			\
+		debug_rtlock_wait_restore_state();			\
+		WRITE_ONCE(current->__state, current->saved_state);	\
+		current->saved_state = TASK_RUNNING;			\
+		raw_spin_unlock(&current->pi_lock);			\
+	} while (0);
+
 #define get_current_state()	READ_ONCE(current->__state)
 
 /* Task command name length: */
@@ -668,6 +726,11 @@ struct task_struct {
 #endif
 	unsigned int			__state;
 
+#ifdef CONFIG_PREEMPT_RT
+	/* saved state for "spinlock sleepers" */
+	unsigned int			saved_state;
+#endif
+
 	/*
 	 * This begins the randomizable portion of task_struct. Only
 	 * scheduling-critical items should be added above here.
@@ -1357,6 +1420,9 @@ struct task_struct {
 	struct kmap_ctrl		kmap_ctrl;
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 	unsigned long			task_state_change;
+# ifdef CONFIG_PREEMPT_RT
+	unsigned long			saved_state_change;
+# endif
 #endif
 	int				pagefault_disabled;
 #ifdef CONFIG_MMU
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 961991e..e407c6a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3566,14 +3566,47 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
  *
  * The caller holds p::pi_lock if p != current or has preemption
  * disabled when p == current.
+ *
+ * The rules of PREEMPT_RT saved_state:
+ *
+ *   The related locking code always holds p::pi_lock when updating
+ *   p::saved_state, which means the code is fully serialized in both cases.
+ *
+ *   The lock wait and lock wakeups happen via TASK_RTLOCK_WAIT. No other
+ *   bits set. This allows to distinguish all wakeup scenarios.
  */
 static __always_inline
 bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
 {
+	if (IS_ENABLED(CONFIG_DEBUG_PREEMPT)) {
+		WARN_ON_ONCE((state & TASK_RTLOCK_WAIT) &&
+			     state != TASK_RTLOCK_WAIT);
+	}
+
 	if (READ_ONCE(p->__state) & state) {
 		*success = 1;
 		return true;
 	}
+
+#ifdef CONFIG_PREEMPT_RT
+	/*
+	 * Saved state preserves the task state across blocking on
+	 * an RT lock.  If the state matches, set p::saved_state to
+	 * TASK_RUNNING, but do not wake the task because it waits
+	 * for a lock wakeup. Also indicate success because from
+	 * the regular waker's point of view this has succeeded.
+	 *
+	 * After acquiring the lock the task will restore p::__state
+	 * from p::saved_state which ensures that the regular
+	 * wakeup is not lost. The restore will also set
+	 * p::saved_state to TASK_RUNNING so any further tests will
+	 * not result in false positives vs. @success
+	 */
+	if (p->saved_state & state) {
+		p->saved_state = TASK_RUNNING;
+		*success = 1;
+	}
+#endif
 	return false;
 }
 
