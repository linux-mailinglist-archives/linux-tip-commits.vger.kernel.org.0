Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220203AC9C3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 13:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbhFRL0P (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 07:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbhFRL0P (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 07:26:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD33C061574;
        Fri, 18 Jun 2021 04:24:05 -0700 (PDT)
Date:   Fri, 18 Jun 2021 11:24:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624015442;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vdS3hrqQMUVyILKEPCq3kDsfqDyl49RQcoxjpnuL9lo=;
        b=0nerJqsr6U3HEbEIYR0LTB03wNMZaeObSA/QXDyA1u6dId5Gsl46v3RoQBq5qsj1hG0+Yl
        PtDqRBnuUQA1tuqcUzqaPMkuBSSDzvWyEB1TvW1AYVCyoDUyTiHTQWY+sqHabthdVArW71
        QOf4Vm3vEZUIHBiQ/7ceEN5gzdK8EGVZ9Vm7ExyHs9otLfGzjzII6f/R5nMf7pc+zc5rnB
        sTiRj+j97I/CWJvnp9WfbXCKL4wyL4jsYt9AQr1ZrWBpIFFrns8Me5GXQs0fEWm+uT5F70
        2dSRozoi2tNn6/CoIyf9oCcn39MK9H4B2wL10Pc3Qiun9OEoWpF91gAt1myzug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624015442;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vdS3hrqQMUVyILKEPCq3kDsfqDyl49RQcoxjpnuL9lo=;
        b=As9Yll52/FqWen2OHRa1ulPOaOtyYOF9sxYO1kflvMZP3GEEtl13yhey0yZ7e/LMvZLG30
        AHgID05r25jYB6AQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Change task_struct::state
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210611082838.550736351@infradead.org>
References: <20210611082838.550736351@infradead.org>
MIME-Version: 1.0
Message-ID: <162401544152.19906.2799352452394123654.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2f064a59a11ff9bc22e52e9678bc601404c7cb34
Gitweb:        https://git.kernel.org/tip/2f064a59a11ff9bc22e52e9678bc601404c7cb34
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 11 Jun 2021 10:28:17 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 18 Jun 2021 11:43:09 +02:00

sched: Change task_struct::state

Change the type and name of task_struct::state. Drop the volatile and
shrink it to an 'unsigned int'. Rename it in order to find all uses
such that we can use READ_ONCE/WRITE_ONCE as appropriate.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20210611082838.550736351@infradead.org
---
 arch/ia64/kernel/mca.c         |  2 +-
 arch/ia64/kernel/ptrace.c      |  8 ++---
 arch/powerpc/xmon/xmon.c       | 13 ++++----
 block/blk-mq.c                 |  2 +-
 drivers/md/dm.c                |  6 ++--
 fs/binfmt_elf.c                |  8 +++--
 fs/binfmt_elf_fdpic.c          |  4 +-
 fs/userfaultfd.c               |  4 +-
 include/linux/sched.h          | 31 +++++++++----------
 include/linux/sched/debug.h    |  2 +-
 include/linux/sched/signal.h   |  2 +-
 init/init_task.c               |  2 +-
 kernel/cgroup/cgroup-v1.c      |  2 +-
 kernel/debug/kdb/kdb_support.c | 18 ++++++-----
 kernel/fork.c                  |  4 +-
 kernel/hung_task.c             |  2 +-
 kernel/kthread.c               |  4 +-
 kernel/locking/mutex.c         |  6 ++--
 kernel/locking/rtmutex.c       |  4 +-
 kernel/locking/rwsem.c         |  2 +-
 kernel/ptrace.c                | 12 +++----
 kernel/rcu/rcutorture.c        |  4 +-
 kernel/rcu/tree_stall.h        | 12 +++----
 kernel/sched/core.c            | 53 +++++++++++++++++----------------
 kernel/sched/deadline.c        | 10 +++---
 kernel/sched/fair.c            | 11 ++++---
 lib/syscall.c                  |  4 +-
 net/core/dev.c                 |  2 +-
 28 files changed, 123 insertions(+), 111 deletions(-)

diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index cdbac4b..e628a88 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -1788,7 +1788,7 @@ format_mca_init_stack(void *mca_data, unsigned long offset,
 	ti->task = p;
 	ti->cpu = cpu;
 	p->stack = ti;
-	p->state = TASK_UNINTERRUPTIBLE;
+	p->__state = TASK_UNINTERRUPTIBLE;
 	cpumask_set_cpu(cpu, &p->cpus_mask);
 	INIT_LIST_HEAD(&p->tasks);
 	p->parent = p->real_parent = p->group_leader = p;
diff --git a/arch/ia64/kernel/ptrace.c b/arch/ia64/kernel/ptrace.c
index e14f565..df28c7d 100644
--- a/arch/ia64/kernel/ptrace.c
+++ b/arch/ia64/kernel/ptrace.c
@@ -641,11 +641,11 @@ ptrace_attach_sync_user_rbs (struct task_struct *child)
 	read_lock(&tasklist_lock);
 	if (child->sighand) {
 		spin_lock_irq(&child->sighand->siglock);
-		if (child->state == TASK_STOPPED &&
+		if (READ_ONCE(child->__state) == TASK_STOPPED &&
 		    !test_and_set_tsk_thread_flag(child, TIF_RESTORE_RSE)) {
 			set_notify_resume(child);
 
-			child->state = TASK_TRACED;
+			WRITE_ONCE(child->__state, TASK_TRACED);
 			stopped = 1;
 		}
 		spin_unlock_irq(&child->sighand->siglock);
@@ -665,9 +665,9 @@ ptrace_attach_sync_user_rbs (struct task_struct *child)
 	read_lock(&tasklist_lock);
 	if (child->sighand) {
 		spin_lock_irq(&child->sighand->siglock);
-		if (child->state == TASK_TRACED &&
+		if (READ_ONCE(child->__state) == TASK_TRACED &&
 		    (child->signal->flags & SIGNAL_STOP_STOPPED)) {
-			child->state = TASK_STOPPED;
+			WRITE_ONCE(child->__state, TASK_STOPPED);
 		}
 		spin_unlock_irq(&child->sighand->siglock);
 	}
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index c8173e9..84de2d7 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3162,6 +3162,7 @@ memzcan(void)
 
 static void show_task(struct task_struct *tsk)
 {
+	unsigned int p_state = READ_ONCE(tsk->__state);
 	char state;
 
 	/*
@@ -3169,14 +3170,14 @@ static void show_task(struct task_struct *tsk)
 	 * appropriate for calling from xmon. This could be moved
 	 * to a common, generic, routine used by both.
 	 */
-	state = (tsk->state == 0) ? 'R' :
-		(tsk->state < 0) ? 'U' :
-		(tsk->state & TASK_UNINTERRUPTIBLE) ? 'D' :
-		(tsk->state & TASK_STOPPED) ? 'T' :
-		(tsk->state & TASK_TRACED) ? 'C' :
+	state = (p_state == 0) ? 'R' :
+		(p_state < 0) ? 'U' :
+		(p_state & TASK_UNINTERRUPTIBLE) ? 'D' :
+		(p_state & TASK_STOPPED) ? 'T' :
+		(p_state & TASK_TRACED) ? 'C' :
 		(tsk->exit_state & EXIT_ZOMBIE) ? 'Z' :
 		(tsk->exit_state & EXIT_DEAD) ? 'E' :
-		(tsk->state & TASK_INTERRUPTIBLE) ? 'S' : '?';
+		(p_state & TASK_INTERRUPTIBLE) ? 'S' : '?';
 
 	printf("%16px %16lx %16px %6d %6d %c %2d %s\n", tsk,
 		tsk->thread.ksp, tsk->thread.regs,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 56270bb..e41edae 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3886,7 +3886,7 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
 int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
 {
 	struct blk_mq_hw_ctx *hctx;
-	long state;
+	unsigned int state;
 
 	if (!blk_qc_t_valid(cookie) ||
 	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index ca2aedd..190e714 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2328,7 +2328,7 @@ static bool md_in_flight_bios(struct mapped_device *md)
 	return sum != 0;
 }
 
-static int dm_wait_for_bios_completion(struct mapped_device *md, long task_state)
+static int dm_wait_for_bios_completion(struct mapped_device *md, unsigned int task_state)
 {
 	int r = 0;
 	DEFINE_WAIT(wait);
@@ -2351,7 +2351,7 @@ static int dm_wait_for_bios_completion(struct mapped_device *md, long task_state
 	return r;
 }
 
-static int dm_wait_for_completion(struct mapped_device *md, long task_state)
+static int dm_wait_for_completion(struct mapped_device *md, unsigned int task_state)
 {
 	int r = 0;
 
@@ -2478,7 +2478,7 @@ static void unlock_fs(struct mapped_device *md)
  * are being added to md->deferred list.
  */
 static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
-			unsigned suspend_flags, long task_state,
+			unsigned suspend_flags, unsigned int task_state,
 			int dmf_suspended_flag)
 {
 	bool do_lockfs = suspend_flags & DM_SUSPEND_LOCKFS_FLAG;
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 187b3f2..3d73cbb 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1537,7 +1537,8 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 {
 	const struct cred *cred;
 	unsigned int i, len;
-	
+	unsigned int state;
+
 	/* first copy the parameters from user space */
 	memset(psinfo, 0, sizeof(struct elf_prpsinfo));
 
@@ -1559,7 +1560,8 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 	psinfo->pr_pgrp = task_pgrp_vnr(p);
 	psinfo->pr_sid = task_session_vnr(p);
 
-	i = p->state ? ffz(~p->state) + 1 : 0;
+	state = READ_ONCE(p->__state);
+	i = state ? ffz(~state) + 1 : 0;
 	psinfo->pr_state = i;
 	psinfo->pr_sname = (i > 5) ? '.' : "RSDTZW"[i];
 	psinfo->pr_zomb = psinfo->pr_sname == 'Z';
@@ -1571,7 +1573,7 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 	SET_GID(psinfo->pr_gid, from_kgid_munged(cred->user_ns, cred->gid));
 	rcu_read_unlock();
 	strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));
-	
+
 	return 0;
 }
 
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 2c99b10..ab9c31d 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1331,6 +1331,7 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 {
 	const struct cred *cred;
 	unsigned int i, len;
+	unsigned int state;
 
 	/* first copy the parameters from user space */
 	memset(psinfo, 0, sizeof(struct elf_prpsinfo));
@@ -1353,7 +1354,8 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 	psinfo->pr_pgrp = task_pgrp_vnr(p);
 	psinfo->pr_sid = task_session_vnr(p);
 
-	i = p->state ? ffz(~p->state) + 1 : 0;
+	state = READ_ONCE(p->__state);
+	i = state ? ffz(~state) + 1 : 0;
 	psinfo->pr_state = i;
 	psinfo->pr_sname = (i > 5) ? '.' : "RSDTZW"[i];
 	psinfo->pr_zomb = psinfo->pr_sname == 'Z';
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 14f9228..dd7a6c6 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -337,7 +337,7 @@ out:
 	return ret;
 }
 
-static inline long userfaultfd_get_blocking_state(unsigned int flags)
+static inline unsigned int userfaultfd_get_blocking_state(unsigned int flags)
 {
 	if (flags & FAULT_FLAG_INTERRUPTIBLE)
 		return TASK_INTERRUPTIBLE;
@@ -370,7 +370,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	struct userfaultfd_wait_queue uwq;
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 	bool must_wait;
-	long blocking_state;
+	unsigned int blocking_state;
 
 	/*
 	 * We don't do userfault handling for the final child pid update.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 395c890..50db949 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -113,13 +113,13 @@ struct task_group;
 					 __TASK_TRACED | EXIT_DEAD | EXIT_ZOMBIE | \
 					 TASK_PARKED)
 
-#define task_is_running(task)		(READ_ONCE((task)->state) == TASK_RUNNING)
+#define task_is_running(task)		(READ_ONCE((task)->__state) == TASK_RUNNING)
 
-#define task_is_traced(task)		((task->state & __TASK_TRACED) != 0)
+#define task_is_traced(task)		((READ_ONCE(task->__state) & __TASK_TRACED) != 0)
 
-#define task_is_stopped(task)		((task->state & __TASK_STOPPED) != 0)
+#define task_is_stopped(task)		((READ_ONCE(task->__state) & __TASK_STOPPED) != 0)
 
-#define task_is_stopped_or_traced(task)	((task->state & (__TASK_STOPPED | __TASK_TRACED)) != 0)
+#define task_is_stopped_or_traced(task)	((READ_ONCE(task->__state) & (__TASK_STOPPED | __TASK_TRACED)) != 0)
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 
@@ -134,14 +134,14 @@ struct task_group;
 	do {							\
 		WARN_ON_ONCE(is_special_task_state(state_value));\
 		current->task_state_change = _THIS_IP_;		\
-		current->state = (state_value);			\
+		WRITE_ONCE(current->__state, (state_value));	\
 	} while (0)
 
 #define set_current_state(state_value)				\
 	do {							\
 		WARN_ON_ONCE(is_special_task_state(state_value));\
 		current->task_state_change = _THIS_IP_;		\
-		smp_store_mb(current->state, (state_value));	\
+		smp_store_mb(current->__state, (state_value));	\
 	} while (0)
 
 #define set_special_state(state_value)					\
@@ -150,7 +150,7 @@ struct task_group;
 		WARN_ON_ONCE(!is_special_task_state(state_value));	\
 		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
 		current->task_state_change = _THIS_IP_;			\
-		current->state = (state_value);				\
+		WRITE_ONCE(current->__state, (state_value));		\
 		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
 	} while (0)
 #else
@@ -192,10 +192,10 @@ struct task_group;
  * Also see the comments of try_to_wake_up().
  */
 #define __set_current_state(state_value)				\
-	current->state = (state_value)
+	WRITE_ONCE(current->__state, (state_value))
 
 #define set_current_state(state_value)					\
-	smp_store_mb(current->state, (state_value))
+	smp_store_mb(current->__state, (state_value))
 
 /*
  * set_special_state() should be used for those states when the blocking task
@@ -207,13 +207,13 @@ struct task_group;
 	do {								\
 		unsigned long flags; /* may shadow */			\
 		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
-		current->state = (state_value);				\
+		WRITE_ONCE(current->__state, (state_value));		\
 		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
 	} while (0)
 
 #endif
 
-#define get_current_state()	READ_ONCE(current->state)
+#define get_current_state()	READ_ONCE(current->__state)
 
 /* Task command name length: */
 #define TASK_COMM_LEN			16
@@ -666,8 +666,7 @@ struct task_struct {
 	 */
 	struct thread_info		thread_info;
 #endif
-	/* -1 unrunnable, 0 runnable, >0 stopped: */
-	volatile long			state;
+	unsigned int			__state;
 
 	/*
 	 * This begins the randomizable portion of task_struct. Only
@@ -1532,7 +1531,7 @@ static inline pid_t task_pgrp_nr(struct task_struct *tsk)
 
 static inline unsigned int task_state_index(struct task_struct *tsk)
 {
-	unsigned int tsk_state = READ_ONCE(tsk->state);
+	unsigned int tsk_state = READ_ONCE(tsk->__state);
 	unsigned int state = (tsk_state | tsk->exit_state) & TASK_REPORT;
 
 	BUILD_BUG_ON_NOT_POWER_OF_2(TASK_REPORT_MAX);
@@ -1840,10 +1839,10 @@ static __always_inline void scheduler_ipi(void)
 	 */
 	preempt_fold_need_resched();
 }
-extern unsigned long wait_task_inactive(struct task_struct *, long match_state);
+extern unsigned long wait_task_inactive(struct task_struct *, unsigned int match_state);
 #else
 static inline void scheduler_ipi(void) { }
-static inline unsigned long wait_task_inactive(struct task_struct *p, long match_state)
+static inline unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state)
 {
 	return 1;
 }
diff --git a/include/linux/sched/debug.h b/include/linux/sched/debug.h
index ae51f45..b5035af 100644
--- a/include/linux/sched/debug.h
+++ b/include/linux/sched/debug.h
@@ -14,7 +14,7 @@ extern void dump_cpu_task(int cpu);
 /*
  * Only dump TASK_* tasks. (0 for all tasks)
  */
-extern void show_state_filter(unsigned long state_filter);
+extern void show_state_filter(unsigned int state_filter);
 
 static inline void show_state(void)
 {
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 7f4278f..c9cf678 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -382,7 +382,7 @@ static inline int fatal_signal_pending(struct task_struct *p)
 	return task_sigpending(p) && __fatal_signal_pending(p);
 }
 
-static inline int signal_pending_state(long state, struct task_struct *p)
+static inline int signal_pending_state(unsigned int state, struct task_struct *p)
 {
 	if (!(state & (TASK_INTERRUPTIBLE | TASK_WAKEKILL)))
 		return 0;
diff --git a/init/init_task.c b/init/init_task.c
index 8b08c2e..562f2ef 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -71,7 +71,7 @@ struct task_struct init_task
 	.thread_info	= INIT_THREAD_INFO(init_task),
 	.stack_refcount	= REFCOUNT_INIT(1),
 #endif
-	.state		= 0,
+	.__state	= 0,
 	.stack		= init_stack,
 	.usage		= REFCOUNT_INIT(2),
 	.flags		= PF_KTHREAD,
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 1f274d7..ee93b6e 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -713,7 +713,7 @@ int cgroupstats_build(struct cgroupstats *stats, struct dentry *dentry)
 
 	css_task_iter_start(&cgrp->self, 0, &it);
 	while ((tsk = css_task_iter_next(&it))) {
-		switch (tsk->state) {
+		switch (READ_ONCE(tsk->__state)) {
 		case TASK_RUNNING:
 			stats->nr_running++;
 			break;
diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index 91bb666..9f50d22 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -609,23 +609,25 @@ unsigned long kdb_task_state_string(const char *s)
  */
 char kdb_task_state_char (const struct task_struct *p)
 {
-	int cpu;
-	char state;
+	unsigned int p_state;
 	unsigned long tmp;
+	char state;
+	int cpu;
 
 	if (!p ||
 	    copy_from_kernel_nofault(&tmp, (char *)p, sizeof(unsigned long)))
 		return 'E';
 
 	cpu = kdb_process_cpu(p);
-	state = (p->state == 0) ? 'R' :
-		(p->state < 0) ? 'U' :
-		(p->state & TASK_UNINTERRUPTIBLE) ? 'D' :
-		(p->state & TASK_STOPPED) ? 'T' :
-		(p->state & TASK_TRACED) ? 'C' :
+	p_state = READ_ONCE(p->__state);
+	state = (p_state == 0) ? 'R' :
+		(p_state < 0) ? 'U' :
+		(p_state & TASK_UNINTERRUPTIBLE) ? 'D' :
+		(p_state & TASK_STOPPED) ? 'T' :
+		(p_state & TASK_TRACED) ? 'C' :
 		(p->exit_state & EXIT_ZOMBIE) ? 'Z' :
 		(p->exit_state & EXIT_DEAD) ? 'E' :
-		(p->state & TASK_INTERRUPTIBLE) ? 'S' : '?';
+		(p_state & TASK_INTERRUPTIBLE) ? 'S' : '?';
 	if (is_idle_task(p)) {
 		/* Idle task.  Is it really idle, apart from the kdb
 		 * interrupt? */
diff --git a/kernel/fork.c b/kernel/fork.c
index e595e77..1a9af73 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -425,7 +425,7 @@ static int memcg_charge_kernel_stack(struct task_struct *tsk)
 
 static void release_task_stack(struct task_struct *tsk)
 {
-	if (WARN_ON(tsk->state != TASK_DEAD))
+	if (WARN_ON(READ_ONCE(tsk->__state) != TASK_DEAD))
 		return;  /* Better to leak the stack than to free prematurely */
 
 	account_kernel_stack(tsk, -1);
@@ -2392,7 +2392,7 @@ bad_fork_cleanup_count:
 	atomic_dec(&p->cred->user->processes);
 	exit_creds(p);
 bad_fork_free:
-	p->state = TASK_DEAD;
+	WRITE_ONCE(p->__state, TASK_DEAD);
 	put_task_stack(p);
 	delayed_free_task(p);
 fork_out:
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 396ebae..b0ce8b3 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -196,7 +196,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
 			last_break = jiffies;
 		}
 		/* use "==" to skip the TASK_KILLABLE tasks waiting on NFS */
-		if (t->state == TASK_UNINTERRUPTIBLE)
+		if (READ_ONCE(t->__state) == TASK_UNINTERRUPTIBLE)
 			check_hung_task(t, timeout);
 	}
  unlock:
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 3d32683..7bbfeeb 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -457,7 +457,7 @@ struct task_struct *kthread_create_on_node(int (*threadfn)(void *data),
 }
 EXPORT_SYMBOL(kthread_create_on_node);
 
-static void __kthread_bind_mask(struct task_struct *p, const struct cpumask *mask, long state)
+static void __kthread_bind_mask(struct task_struct *p, const struct cpumask *mask, unsigned int state)
 {
 	unsigned long flags;
 
@@ -473,7 +473,7 @@ static void __kthread_bind_mask(struct task_struct *p, const struct cpumask *mas
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
 }
 
-static void __kthread_bind(struct task_struct *p, unsigned int cpu, long state)
+static void __kthread_bind(struct task_struct *p, unsigned int cpu, unsigned int state)
 {
 	__kthread_bind_mask(p, cpumask_of(cpu), state);
 }
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 013e1b0..d2df5e6 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -923,7 +923,7 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
  * Lock a mutex (possibly interruptible), slowpath:
  */
 static __always_inline int __sched
-__mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
+__mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclass,
 		    struct lockdep_map *nest_lock, unsigned long ip,
 		    struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx)
 {
@@ -1098,14 +1098,14 @@ err_early_kill:
 }
 
 static int __sched
-__mutex_lock(struct mutex *lock, long state, unsigned int subclass,
+__mutex_lock(struct mutex *lock, unsigned int state, unsigned int subclass,
 	     struct lockdep_map *nest_lock, unsigned long ip)
 {
 	return __mutex_lock_common(lock, state, subclass, nest_lock, ip, NULL, false);
 }
 
 static int __sched
-__ww_mutex_lock(struct mutex *lock, long state, unsigned int subclass,
+__ww_mutex_lock(struct mutex *lock, unsigned int state, unsigned int subclass,
 		struct lockdep_map *nest_lock, unsigned long ip,
 		struct ww_acquire_ctx *ww_ctx)
 {
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 4068181..b5d9bb5 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1135,7 +1135,7 @@ void __sched rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
  *
  * Must be called with lock->wait_lock held and interrupts disabled
  */
-static int __sched __rt_mutex_slowlock(struct rt_mutex *lock, int state,
+static int __sched __rt_mutex_slowlock(struct rt_mutex *lock, unsigned int state,
 				       struct hrtimer_sleeper *timeout,
 				       struct rt_mutex_waiter *waiter)
 {
@@ -1190,7 +1190,7 @@ static void __sched rt_mutex_handle_deadlock(int res, int detect_deadlock,
 /*
  * Slow path lock function:
  */
-static int __sched rt_mutex_slowlock(struct rt_mutex *lock, int state,
+static int __sched rt_mutex_slowlock(struct rt_mutex *lock, unsigned int state,
 				     struct hrtimer_sleeper *timeout,
 				     enum rtmutex_chainwalk chwalk)
 {
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 809b001..16bfbb1 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -889,7 +889,7 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
  * Wait for the read lock to be granted
  */
 static struct rw_semaphore __sched *
-rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, int state)
+rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int state)
 {
 	long adjustment = -RWSEM_READER_BIAS;
 	long rcnt = (count >> RWSEM_READER_SHIFT);
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 2997ca6..f8589bf 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -197,7 +197,7 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 	spin_lock_irq(&task->sighand->siglock);
 	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
 	    !__fatal_signal_pending(task)) {
-		task->state = __TASK_TRACED;
+		WRITE_ONCE(task->__state, __TASK_TRACED);
 		ret = true;
 	}
 	spin_unlock_irq(&task->sighand->siglock);
@@ -207,7 +207,7 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 
 static void ptrace_unfreeze_traced(struct task_struct *task)
 {
-	if (task->state != __TASK_TRACED)
+	if (READ_ONCE(task->__state) != __TASK_TRACED)
 		return;
 
 	WARN_ON(!task->ptrace || task->parent != current);
@@ -217,11 +217,11 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
 	 * Recheck state under the lock to close this race.
 	 */
 	spin_lock_irq(&task->sighand->siglock);
-	if (task->state == __TASK_TRACED) {
+	if (READ_ONCE(task->__state) == __TASK_TRACED) {
 		if (__fatal_signal_pending(task))
 			wake_up_state(task, __TASK_TRACED);
 		else
-			task->state = TASK_TRACED;
+			WRITE_ONCE(task->__state, TASK_TRACED);
 	}
 	spin_unlock_irq(&task->sighand->siglock);
 }
@@ -256,7 +256,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 	 */
 	read_lock(&tasklist_lock);
 	if (child->ptrace && child->parent == current) {
-		WARN_ON(child->state == __TASK_TRACED);
+		WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
 		/*
 		 * child->sighand can't be NULL, release_task()
 		 * does ptrace_unlink() before __exit_signal().
@@ -273,7 +273,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 			 * ptrace_stop() changes ->state back to TASK_RUNNING,
 			 * so we should not worry about leaking __TASK_TRACED.
 			 */
-			WARN_ON(child->state == __TASK_TRACED);
+			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
 			ret = -ESRCH;
 		}
 	}
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 29d2f4c..194b9c1 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1831,10 +1831,10 @@ rcu_torture_stats_print(void)
 		srcutorture_get_gp_data(cur_ops->ttype, srcu_ctlp,
 					&flags, &gp_seq);
 		wtp = READ_ONCE(writer_task);
-		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#lx cpu %d\n",
+		pr_alert("??? Writer stall state %s(%d) g%lu f%#x ->state %#x cpu %d\n",
 			 rcu_torture_writer_state_getname(),
 			 rcu_torture_writer_state, gp_seq, flags,
-			 wtp == NULL ? ~0UL : wtp->state,
+			 wtp == NULL ? ~0U : wtp->__state,
 			 wtp == NULL ? -1 : (int)task_cpu(wtp));
 		if (!splatted && wtp) {
 			sched_show_task(wtp);
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 59b95cc..acb2288 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -460,12 +460,12 @@ static void rcu_check_gp_kthread_starvation(void)
 
 	if (rcu_is_gp_kthread_starving(&j)) {
 		cpu = gpk ? task_cpu(gpk) : -1;
-		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%#lx ->cpu=%d\n",
+		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%#x ->cpu=%d\n",
 		       rcu_state.name, j,
 		       (long)rcu_seq_current(&rcu_state.gp_seq),
 		       data_race(rcu_state.gp_flags),
 		       gp_state_getname(rcu_state.gp_state), rcu_state.gp_state,
-		       gpk ? gpk->state : ~0, cpu);
+		       gpk ? gpk->__state : ~0, cpu);
 		if (gpk) {
 			pr_err("\tUnless %s kthread gets sufficient CPU time, OOM is now expected behavior.\n", rcu_state.name);
 			pr_err("RCU grace-period kthread stack dump:\n");
@@ -503,12 +503,12 @@ static void rcu_check_gp_kthread_expired_fqs_timer(void)
 	    time_after(jiffies, jiffies_fqs + RCU_STALL_MIGHT_MIN) &&
 	    gpk && !READ_ONCE(gpk->on_rq)) {
 		cpu = task_cpu(gpk);
-		pr_err("%s kthread timer wakeup didn't happen for %ld jiffies! g%ld f%#x %s(%d) ->state=%#lx\n",
+		pr_err("%s kthread timer wakeup didn't happen for %ld jiffies! g%ld f%#x %s(%d) ->state=%#x\n",
 		       rcu_state.name, (jiffies - jiffies_fqs),
 		       (long)rcu_seq_current(&rcu_state.gp_seq),
 		       data_race(rcu_state.gp_flags),
 		       gp_state_getname(RCU_GP_WAIT_FQS), RCU_GP_WAIT_FQS,
-		       gpk->state);
+		       gpk->__state);
 		pr_err("\tPossible timer handling issue on cpu=%d timer-softirq=%u\n",
 		       cpu, kstat_softirqs_cpu(TIMER_SOFTIRQ, cpu));
 	}
@@ -735,9 +735,9 @@ void show_rcu_gp_kthreads(void)
 	ja = j - data_race(rcu_state.gp_activity);
 	jr = j - data_race(rcu_state.gp_req_activity);
 	jw = j - data_race(rcu_state.gp_wake_time);
-	pr_info("%s: wait state: %s(%d) ->state: %#lx delta ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_flags %#x\n",
+	pr_info("%s: wait state: %s(%d) ->state: %#x delta ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_flags %#x\n",
 		rcu_state.name, gp_state_getname(rcu_state.gp_state),
-		rcu_state.gp_state, t ? t->state : 0x1ffffL,
+		rcu_state.gp_state, t ? t->__state : 0x1ffff,
 		ja, jr, jw, (long)data_race(rcu_state.gp_wake_seq),
 		(long)data_race(rcu_state.gp_seq),
 		(long)data_race(rcu_get_root()->gp_seq_needed),
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 45ebb3c..309745a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2638,7 +2638,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		return -EINVAL;
 	}
 
-	if (task_running(rq, p) || p->state == TASK_WAKING) {
+	if (task_running(rq, p) || READ_ONCE(p->__state) == TASK_WAKING) {
 		/*
 		 * MIGRATE_ENABLE gets here because 'p == current', but for
 		 * anything else we cannot do is_migration_disabled(), punt
@@ -2781,19 +2781,20 @@ EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 {
 #ifdef CONFIG_SCHED_DEBUG
+	unsigned int state = READ_ONCE(p->__state);
+
 	/*
 	 * We should never call set_task_cpu() on a blocked task,
 	 * ttwu() will sort out the placement.
 	 */
-	WARN_ON_ONCE(p->state != TASK_RUNNING && p->state != TASK_WAKING &&
-			!p->on_rq);
+	WARN_ON_ONCE(state != TASK_RUNNING && state != TASK_WAKING && !p->on_rq);
 
 	/*
 	 * Migrating fair class task must have p->on_rq = TASK_ON_RQ_MIGRATING,
 	 * because schedstat_wait_{start,end} rebase migrating task's wait_start
 	 * time relying on p->on_rq.
 	 */
-	WARN_ON_ONCE(p->state == TASK_RUNNING &&
+	WARN_ON_ONCE(state == TASK_RUNNING &&
 		     p->sched_class == &fair_sched_class &&
 		     (p->on_rq && !task_on_rq_migrating(p)));
 
@@ -2965,7 +2966,7 @@ out:
  * smp_call_function() if an IPI is sent by the same process we are
  * waiting to become inactive.
  */
-unsigned long wait_task_inactive(struct task_struct *p, long match_state)
+unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state)
 {
 	int running, queued;
 	struct rq_flags rf;
@@ -2993,7 +2994,7 @@ unsigned long wait_task_inactive(struct task_struct *p, long match_state)
 		 * is actually now running somewhere else!
 		 */
 		while (task_running(rq, p)) {
-			if (match_state && unlikely(p->state != match_state))
+			if (match_state && unlikely(READ_ONCE(p->__state) != match_state))
 				return 0;
 			cpu_relax();
 		}
@@ -3008,7 +3009,7 @@ unsigned long wait_task_inactive(struct task_struct *p, long match_state)
 		running = task_running(rq, p);
 		queued = task_on_rq_queued(p);
 		ncsw = 0;
-		if (!match_state || p->state == match_state)
+		if (!match_state || READ_ONCE(p->__state) == match_state)
 			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
 		task_rq_unlock(rq, p, &rf);
 
@@ -3317,7 +3318,7 @@ static void ttwu_do_wakeup(struct rq *rq, struct task_struct *p, int wake_flags,
 			   struct rq_flags *rf)
 {
 	check_preempt_curr(rq, p, wake_flags);
-	p->state = TASK_RUNNING;
+	WRITE_ONCE(p->__state, TASK_RUNNING);
 	trace_sched_wakeup(p);
 
 #ifdef CONFIG_SMP
@@ -3709,12 +3710,12 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		 *  - we're serialized against set_special_state() by virtue of
 		 *    it disabling IRQs (this allows not taking ->pi_lock).
 		 */
-		if (!(p->state & state))
+		if (!(READ_ONCE(p->__state) & state))
 			goto out;
 
 		success = 1;
 		trace_sched_waking(p);
-		p->state = TASK_RUNNING;
+		WRITE_ONCE(p->__state, TASK_RUNNING);
 		trace_sched_wakeup(p);
 		goto out;
 	}
@@ -3727,7 +3728,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 */
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
 	smp_mb__after_spinlock();
-	if (!(p->state & state))
+	if (!(READ_ONCE(p->__state) & state))
 		goto unlock;
 
 	trace_sched_waking(p);
@@ -3793,7 +3794,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * TASK_WAKING such that we can unlock p->pi_lock before doing the
 	 * enqueue, such as ttwu_queue_wakelist().
 	 */
-	p->state = TASK_WAKING;
+	WRITE_ONCE(p->__state, TASK_WAKING);
 
 	/*
 	 * If the owning (remote) CPU is still in the middle of schedule() with
@@ -3886,7 +3887,7 @@ bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct t
 			ret = func(p, arg);
 		rq_unlock(rq, &rf);
 	} else {
-		switch (p->state) {
+		switch (READ_ONCE(p->__state)) {
 		case TASK_RUNNING:
 		case TASK_WAKING:
 			break;
@@ -4086,7 +4087,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	 * nobody will actually run it, and a signal or other external
 	 * event cannot wake it up and insert it on the runqueue either.
 	 */
-	p->state = TASK_NEW;
+	p->__state = TASK_NEW;
 
 	/*
 	 * Make sure we do not leak PI boosting priority to the child.
@@ -4192,7 +4193,7 @@ void wake_up_new_task(struct task_struct *p)
 	struct rq *rq;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
-	p->state = TASK_RUNNING;
+	WRITE_ONCE(p->__state, TASK_RUNNING);
 #ifdef CONFIG_SMP
 	/*
 	 * Fork balancing, do it here and not earlier because:
@@ -4554,7 +4555,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	 * running on another CPU and we could rave with its RUNNING -> DEAD
 	 * transition, resulting in a double drop.
 	 */
-	prev_state = prev->state;
+	prev_state = READ_ONCE(prev->__state);
 	vtime_task_switch(prev);
 	perf_event_task_sched_in(prev, current);
 	finish_task(prev);
@@ -5248,7 +5249,7 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
 #endif
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-	if (!preempt && prev->state && prev->non_block_count) {
+	if (!preempt && READ_ONCE(prev->__state) && prev->non_block_count) {
 		printk(KERN_ERR "BUG: scheduling in a non-blocking section: %s/%d/%i\n",
 			prev->comm, prev->pid, prev->non_block_count);
 		dump_stack();
@@ -5874,10 +5875,10 @@ static void __sched notrace __schedule(bool preempt)
 	 *  - we form a control dependency vs deactivate_task() below.
 	 *  - ptrace_{,un}freeze_traced() can change ->state underneath us.
 	 */
-	prev_state = prev->state;
+	prev_state = READ_ONCE(prev->__state);
 	if (!preempt && prev_state) {
 		if (signal_pending_state(prev_state, prev)) {
-			prev->state = TASK_RUNNING;
+			WRITE_ONCE(prev->__state, TASK_RUNNING);
 		} else {
 			prev->sched_contributes_to_load =
 				(prev_state & TASK_UNINTERRUPTIBLE) &&
@@ -6049,7 +6050,7 @@ void __sched schedule_idle(void)
 	 * current task can be in any other state. Note, idle is always in the
 	 * TASK_RUNNING state.
 	 */
-	WARN_ON_ONCE(current->state);
+	WARN_ON_ONCE(current->__state);
 	do {
 		__schedule(false);
 	} while (need_resched());
@@ -8176,26 +8177,28 @@ EXPORT_SYMBOL_GPL(sched_show_task);
 static inline bool
 state_filter_match(unsigned long state_filter, struct task_struct *p)
 {
+	unsigned int state = READ_ONCE(p->__state);
+
 	/* no filter, everything matches */
 	if (!state_filter)
 		return true;
 
 	/* filter, but doesn't match */
-	if (!(p->state & state_filter))
+	if (!(state & state_filter))
 		return false;
 
 	/*
 	 * When looking for TASK_UNINTERRUPTIBLE skip TASK_IDLE (allows
 	 * TASK_KILLABLE).
 	 */
-	if (state_filter == TASK_UNINTERRUPTIBLE && p->state == TASK_IDLE)
+	if (state_filter == TASK_UNINTERRUPTIBLE && state == TASK_IDLE)
 		return false;
 
 	return true;
 }
 
 
-void show_state_filter(unsigned long state_filter)
+void show_state_filter(unsigned int state_filter)
 {
 	struct task_struct *g, *p;
 
@@ -8252,7 +8255,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	raw_spin_lock_irqsave(&idle->pi_lock, flags);
 	raw_spin_rq_lock(rq);
 
-	idle->state = TASK_RUNNING;
+	idle->__state = TASK_RUNNING;
 	idle->se.exec_start = sched_clock();
 	/*
 	 * PF_KTHREAD should already be set at this point; regardless, make it
@@ -9567,7 +9570,7 @@ static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 		 * has happened. This would lead to problems with PELT, due to
 		 * move wanting to detach+attach while we're not attached yet.
 		 */
-		if (task->state == TASK_NEW)
+		if (READ_ONCE(task->__state) == TASK_NEW)
 			ret = -EINVAL;
 		raw_spin_unlock_irq(&task->pi_lock);
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3829c5a..22878cd 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -348,10 +348,10 @@ static void task_non_contending(struct task_struct *p)
 	if ((zerolag_time < 0) || hrtimer_active(&dl_se->inactive_timer)) {
 		if (dl_task(p))
 			sub_running_bw(dl_se, dl_rq);
-		if (!dl_task(p) || p->state == TASK_DEAD) {
+		if (!dl_task(p) || READ_ONCE(p->__state) == TASK_DEAD) {
 			struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
 
-			if (p->state == TASK_DEAD)
+			if (READ_ONCE(p->__state) == TASK_DEAD)
 				sub_rq_bw(&p->dl, &rq->dl);
 			raw_spin_lock(&dl_b->lock);
 			__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
@@ -1355,10 +1355,10 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 	sched_clock_tick();
 	update_rq_clock(rq);
 
-	if (!dl_task(p) || p->state == TASK_DEAD) {
+	if (!dl_task(p) || READ_ONCE(p->__state) == TASK_DEAD) {
 		struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
 
-		if (p->state == TASK_DEAD && dl_se->dl_non_contending) {
+		if (READ_ONCE(p->__state) == TASK_DEAD && dl_se->dl_non_contending) {
 			sub_running_bw(&p->dl, dl_rq_of_se(&p->dl));
 			sub_rq_bw(&p->dl, dl_rq_of_se(&p->dl));
 			dl_se->dl_non_contending = 0;
@@ -1722,7 +1722,7 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
 {
 	struct rq *rq;
 
-	if (p->state != TASK_WAKING)
+	if (READ_ONCE(p->__state) != TASK_WAKING)
 		return;
 
 	rq = task_rq(p);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5d1a6aa..7b8990f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -993,11 +993,14 @@ update_stats_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	if ((flags & DEQUEUE_SLEEP) && entity_is_task(se)) {
 		struct task_struct *tsk = task_of(se);
+		unsigned int state;
 
-		if (tsk->state & TASK_INTERRUPTIBLE)
+		/* XXX racy against TTWU */
+		state = READ_ONCE(tsk->__state);
+		if (state & TASK_INTERRUPTIBLE)
 			__schedstat_set(se->statistics.sleep_start,
 				      rq_clock(rq_of(cfs_rq)));
-		if (tsk->state & TASK_UNINTERRUPTIBLE)
+		if (state & TASK_UNINTERRUPTIBLE)
 			__schedstat_set(se->statistics.block_start,
 				      rq_clock(rq_of(cfs_rq)));
 	}
@@ -6888,7 +6891,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 	 * min_vruntime -- the latter is done by enqueue_entity() when placing
 	 * the task on the new runqueue.
 	 */
-	if (p->state == TASK_WAKING) {
+	if (READ_ONCE(p->__state) == TASK_WAKING) {
 		struct sched_entity *se = &p->se;
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 		u64 min_vruntime;
@@ -11053,7 +11056,7 @@ static inline bool vruntime_normalized(struct task_struct *p)
 	 *   waiting for actually being woken up by sched_ttwu_pending().
 	 */
 	if (!se->sum_exec_runtime ||
-	    (p->state == TASK_WAKING && p->sched_remote_wakeup))
+	    (READ_ONCE(p->__state) == TASK_WAKING && p->sched_remote_wakeup))
 		return true;
 
 	return false;
diff --git a/lib/syscall.c b/lib/syscall.c
index ba13e92..006e256 100644
--- a/lib/syscall.c
+++ b/lib/syscall.c
@@ -68,13 +68,13 @@ static int collect_syscall(struct task_struct *target, struct syscall_info *info
  */
 int task_current_syscall(struct task_struct *target, struct syscall_info *info)
 {
-	long state;
 	unsigned long ncsw;
+	unsigned int state;
 
 	if (target == current)
 		return collect_syscall(target, info);
 
-	state = target->state;
+	state = READ_ONCE(target->__state);
 	if (unlikely(!state))
 		return -EAGAIN;
 
diff --git a/net/core/dev.c b/net/core/dev.c
index ef8cf76..2512f67 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4363,7 +4363,7 @@ static inline void ____napi_schedule(struct softnet_data *sd,
 			 * makes sure to proceed with napi polling
 			 * if the thread is explicitly woken from here.
 			 */
-			if (READ_ONCE(thread->state) != TASK_INTERRUPTIBLE)
+			if (READ_ONCE(thread->__state) != TASK_INTERRUPTIBLE)
 				set_bit(NAPI_STATE_SCHED_THREADED, &napi->state);
 			wake_up_process(thread);
 			return;
