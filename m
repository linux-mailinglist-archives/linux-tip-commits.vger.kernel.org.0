Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B96E27BE86
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Sep 2020 09:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgI2H4w (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 29 Sep 2020 03:56:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44372 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgI2H4v (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 29 Sep 2020 03:56:51 -0400
Date:   Tue, 29 Sep 2020 07:56:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601366208;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dyYXjrllJU0iSODjvAewP/zgO0qa1EfzGq5u8OIfM/c=;
        b=qESJzKSqWk7yLOUUcCuAdhztteyu9Do0V/HLNZXxt851yAGo3gm5Vqf2dPGHIjt7zK74Jl
        43G9SNswJiU5cJGP31IH3w4eotvmL0HbDKHwi63xHzpX0m/mzor8YWev44xCf6J+DIBmII
        /OyG/jBHh4NFaGuBmCYxcZvfvqFwaX3gMPMxzBdyxHXCZ7TgmZnV7Z5JWNrngPwIq56INN
        JA8mOU2aIS6rfqLSEqwMKIwpXkHbe/oFJxhrOUQqZpgxoZVRE7a0iJUntJ5w4JDaBJgKk2
        Y+elc8TBseAWhtDfpfTffxNcXdwHjW4GqY9If8UBY/Y1S+rSCMUdGB9+ZZFI4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601366208;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dyYXjrllJU0iSODjvAewP/zgO0qa1EfzGq5u8OIfM/c=;
        b=MGmvIDiFqdMbrf4T+m0hJBnZvohOL1qWQtsuwnz0onxCNUM8lUKWBxLcZZDY389xeuuUSg
        HGMD38vE12e8weCg==
From:   "tip-bot2 for Peter Oskolkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq/membarrier: Add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
Cc:     Peter Oskolkov <posk@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200923233618.2572849-1-posk@google.com>
References: <20200923233618.2572849-1-posk@google.com>
MIME-Version: 1.0
Message-ID: <160136620764.7002.9951048577780906416.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2a36ab717e8fe678d98f81c14a0b124712719840
Gitweb:        https://git.kernel.org/tip/2a36ab717e8fe678d98f81c14a0b124712719840
Author:        Peter Oskolkov <posk@google.com>
AuthorDate:    Wed, 23 Sep 2020 16:36:16 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Sep 2020 14:23:27 +02:00

rseq/membarrier: Add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ

This patchset is based on Google-internal RSEQ work done by Paul
Turner and Andrew Hunter.

When working with per-CPU RSEQ-based memory allocations, it is
sometimes important to make sure that a global memory location is no
longer accessed from RSEQ critical sections. For example, there can be
two per-CPU lists, one is "active" and accessed per-CPU, while another
one is inactive and worked on asynchronously "off CPU" (e.g.  garbage
collection is performed). Then at some point the two lists are
swapped, and a fast RCU-like mechanism is required to make sure that
the previously active list is no longer accessed.

This patch introduces such a mechanism: in short, membarrier() syscall
issues an IPI to a CPU, restarting a potentially active RSEQ critical
section on the CPU.

Signed-off-by: Peter Oskolkov <posk@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lkml.kernel.org/r/20200923233618.2572849-1-posk@google.com
---
 include/linux/sched/mm.h        |   3 +-
 include/linux/syscalls.h        |   2 +-
 include/uapi/linux/membarrier.h |  26 ++++++-
 kernel/sched/membarrier.c       | 136 ++++++++++++++++++++++++-------
 4 files changed, 136 insertions(+), 31 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index f889e33..15bfb06 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -348,10 +348,13 @@ enum {
 	MEMBARRIER_STATE_GLOBAL_EXPEDITED			= (1U << 3),
 	MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY	= (1U << 4),
 	MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE		= (1U << 5),
+	MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY		= (1U << 6),
+	MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ			= (1U << 7),
 };
 
 enum {
 	MEMBARRIER_FLAG_SYNC_CORE	= (1U << 0),
+	MEMBARRIER_FLAG_RSEQ		= (1U << 1),
 };
 
 #ifdef CONFIG_ARCH_HAS_MEMBARRIER_CALLBACKS
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 75ac7f8..06db098 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -974,7 +974,7 @@ asmlinkage long sys_execveat(int dfd, const char __user *filename,
 			const char __user *const __user *argv,
 			const char __user *const __user *envp, int flags);
 asmlinkage long sys_userfaultfd(int flags);
-asmlinkage long sys_membarrier(int cmd, int flags);
+asmlinkage long sys_membarrier(int cmd, unsigned int flags, int cpu_id);
 asmlinkage long sys_mlock2(unsigned long start, size_t len, int flags);
 asmlinkage long sys_copy_file_range(int fd_in, loff_t __user *off_in,
 				    int fd_out, loff_t __user *off_out,
diff --git a/include/uapi/linux/membarrier.h b/include/uapi/linux/membarrier.h
index 5891d76..7376058 100644
--- a/include/uapi/linux/membarrier.h
+++ b/include/uapi/linux/membarrier.h
@@ -114,6 +114,26 @@
  *                          If this command is not implemented by an
  *                          architecture, -EINVAL is returned.
  *                          Returns 0 on success.
+ * @MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ:
+ *                          Ensure the caller thread, upon return from
+ *                          system call, that all its running thread
+ *                          siblings have any currently running rseq
+ *                          critical sections restarted if @flags
+ *                          parameter is 0; if @flags parameter is
+ *                          MEMBARRIER_CMD_FLAG_CPU,
+ *                          then this operation is performed only
+ *                          on CPU indicated by @cpu_id. If this command is
+ *                          not implemented by an architecture, -EINVAL
+ *                          is returned. A process needs to register its
+ *                          intent to use the private expedited rseq
+ *                          command prior to using it, otherwise
+ *                          this command returns -EPERM.
+ * @MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ:
+ *                          Register the process intent to use
+ *                          MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ.
+ *                          If this command is not implemented by an
+ *                          architecture, -EINVAL is returned.
+ *                          Returns 0 on success.
  * @MEMBARRIER_CMD_SHARED:
  *                          Alias to MEMBARRIER_CMD_GLOBAL. Provided for
  *                          header backward compatibility.
@@ -131,9 +151,15 @@ enum membarrier_cmd {
 	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED		= (1 << 4),
 	MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE		= (1 << 5),
 	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE	= (1 << 6),
+	MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ			= (1 << 7),
+	MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ		= (1 << 8),
 
 	/* Alias for header backward compatibility. */
 	MEMBARRIER_CMD_SHARED			= MEMBARRIER_CMD_GLOBAL,
 };
 
+enum membarrier_cmd_flag {
+	MEMBARRIER_CMD_FLAG_CPU		= (1 << 0),
+};
+
 #endif /* _UAPI_LINUX_MEMBARRIER_H */
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index 168479a..e23e74d 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -18,6 +18,14 @@
 #define MEMBARRIER_PRIVATE_EXPEDITED_SYNC_CORE_BITMASK	0
 #endif
 
+#ifdef CONFIG_RSEQ
+#define MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ_BITMASK		\
+	(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ			\
+	| MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ_BITMASK)
+#else
+#define MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ_BITMASK	0
+#endif
+
 #define MEMBARRIER_CMD_BITMASK						\
 	(MEMBARRIER_CMD_GLOBAL | MEMBARRIER_CMD_GLOBAL_EXPEDITED	\
 	| MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED			\
@@ -30,6 +38,11 @@ static void ipi_mb(void *info)
 	smp_mb();	/* IPIs should be serializing but paranoid. */
 }
 
+static void ipi_rseq(void *info)
+{
+	rseq_preempt(current);
+}
+
 static void ipi_sync_rq_state(void *info)
 {
 	struct mm_struct *mm = (struct mm_struct *) info;
@@ -129,19 +142,27 @@ static int membarrier_global_expedited(void)
 	return 0;
 }
 
-static int membarrier_private_expedited(int flags)
+static int membarrier_private_expedited(int flags, int cpu_id)
 {
-	int cpu;
 	cpumask_var_t tmpmask;
 	struct mm_struct *mm = current->mm;
+	smp_call_func_t ipi_func = ipi_mb;
 
-	if (flags & MEMBARRIER_FLAG_SYNC_CORE) {
+	if (flags == MEMBARRIER_FLAG_SYNC_CORE) {
 		if (!IS_ENABLED(CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE))
 			return -EINVAL;
 		if (!(atomic_read(&mm->membarrier_state) &
 		      MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY))
 			return -EPERM;
+	} else if (flags == MEMBARRIER_FLAG_RSEQ) {
+		if (!IS_ENABLED(CONFIG_RSEQ))
+			return -EINVAL;
+		if (!(atomic_read(&mm->membarrier_state) &
+		      MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY))
+			return -EPERM;
+		ipi_func = ipi_rseq;
 	} else {
+		WARN_ON_ONCE(flags);
 		if (!(atomic_read(&mm->membarrier_state) &
 		      MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY))
 			return -EPERM;
@@ -156,35 +177,59 @@ static int membarrier_private_expedited(int flags)
 	 */
 	smp_mb();	/* system call entry is not a mb. */
 
-	if (!zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
+	if (cpu_id < 0 && !zalloc_cpumask_var(&tmpmask, GFP_KERNEL))
 		return -ENOMEM;
 
 	cpus_read_lock();
-	rcu_read_lock();
-	for_each_online_cpu(cpu) {
+
+	if (cpu_id >= 0) {
 		struct task_struct *p;
 
-		/*
-		 * Skipping the current CPU is OK even through we can be
-		 * migrated at any point. The current CPU, at the point
-		 * where we read raw_smp_processor_id(), is ensured to
-		 * be in program order with respect to the caller
-		 * thread. Therefore, we can skip this CPU from the
-		 * iteration.
-		 */
-		if (cpu == raw_smp_processor_id())
-			continue;
-		p = rcu_dereference(cpu_rq(cpu)->curr);
-		if (p && p->mm == mm)
-			__cpumask_set_cpu(cpu, tmpmask);
+		if (cpu_id >= nr_cpu_ids || !cpu_online(cpu_id))
+			goto out;
+		if (cpu_id == raw_smp_processor_id())
+			goto out;
+		rcu_read_lock();
+		p = rcu_dereference(cpu_rq(cpu_id)->curr);
+		if (!p || p->mm != mm) {
+			rcu_read_unlock();
+			goto out;
+		}
+		rcu_read_unlock();
+	} else {
+		int cpu;
+
+		rcu_read_lock();
+		for_each_online_cpu(cpu) {
+			struct task_struct *p;
+
+			/*
+			 * Skipping the current CPU is OK even through we can be
+			 * migrated at any point. The current CPU, at the point
+			 * where we read raw_smp_processor_id(), is ensured to
+			 * be in program order with respect to the caller
+			 * thread. Therefore, we can skip this CPU from the
+			 * iteration.
+			 */
+			if (cpu == raw_smp_processor_id())
+				continue;
+			p = rcu_dereference(cpu_rq(cpu)->curr);
+			if (p && p->mm == mm)
+				__cpumask_set_cpu(cpu, tmpmask);
+		}
+		rcu_read_unlock();
 	}
-	rcu_read_unlock();
 
 	preempt_disable();
-	smp_call_function_many(tmpmask, ipi_mb, NULL, 1);
+	if (cpu_id >= 0)
+		smp_call_function_single(cpu_id, ipi_func, NULL, 1);
+	else
+		smp_call_function_many(tmpmask, ipi_func, NULL, 1);
 	preempt_enable();
 
-	free_cpumask_var(tmpmask);
+out:
+	if (cpu_id < 0)
+		free_cpumask_var(tmpmask);
 	cpus_read_unlock();
 
 	/*
@@ -283,11 +328,18 @@ static int membarrier_register_private_expedited(int flags)
 	    set_state = MEMBARRIER_STATE_PRIVATE_EXPEDITED,
 	    ret;
 
-	if (flags & MEMBARRIER_FLAG_SYNC_CORE) {
+	if (flags == MEMBARRIER_FLAG_SYNC_CORE) {
 		if (!IS_ENABLED(CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE))
 			return -EINVAL;
 		ready_state =
 			MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY;
+	} else if (flags == MEMBARRIER_FLAG_RSEQ) {
+		if (!IS_ENABLED(CONFIG_RSEQ))
+			return -EINVAL;
+		ready_state =
+			MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY;
+	} else {
+		WARN_ON_ONCE(flags);
 	}
 
 	/*
@@ -299,6 +351,8 @@ static int membarrier_register_private_expedited(int flags)
 		return 0;
 	if (flags & MEMBARRIER_FLAG_SYNC_CORE)
 		set_state |= MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE;
+	if (flags & MEMBARRIER_FLAG_RSEQ)
+		set_state |= MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ;
 	atomic_or(set_state, &mm->membarrier_state);
 	ret = sync_runqueues_membarrier_state(mm);
 	if (ret)
@@ -310,8 +364,15 @@ static int membarrier_register_private_expedited(int flags)
 
 /**
  * sys_membarrier - issue memory barriers on a set of threads
- * @cmd:   Takes command values defined in enum membarrier_cmd.
- * @flags: Currently needs to be 0. For future extensions.
+ * @cmd:    Takes command values defined in enum membarrier_cmd.
+ * @flags:  Currently needs to be 0 for all commands other than
+ *          MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ: in the latter
+ *          case it can be MEMBARRIER_CMD_FLAG_CPU, indicating that @cpu_id
+ *          contains the CPU on which to interrupt (= restart)
+ *          the RSEQ critical section.
+ * @cpu_id: if @flags == MEMBARRIER_CMD_FLAG_CPU, indicates the cpu on which
+ *          RSEQ CS should be interrupted (@cmd must be
+ *          MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ).
  *
  * If this system call is not implemented, -ENOSYS is returned. If the
  * command specified does not exist, not available on the running
@@ -337,10 +398,21 @@ static int membarrier_register_private_expedited(int flags)
  *        smp_mb()           X           O            O
  *        sys_membarrier()   O           O            O
  */
-SYSCALL_DEFINE2(membarrier, int, cmd, int, flags)
+SYSCALL_DEFINE3(membarrier, int, cmd, unsigned int, flags, int, cpu_id)
 {
-	if (unlikely(flags))
-		return -EINVAL;
+	switch (cmd) {
+	case MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ:
+		if (unlikely(flags && flags != MEMBARRIER_CMD_FLAG_CPU))
+			return -EINVAL;
+		break;
+	default:
+		if (unlikely(flags))
+			return -EINVAL;
+	}
+
+	if (!(flags & MEMBARRIER_CMD_FLAG_CPU))
+		cpu_id = -1;
+
 	switch (cmd) {
 	case MEMBARRIER_CMD_QUERY:
 	{
@@ -362,13 +434,17 @@ SYSCALL_DEFINE2(membarrier, int, cmd, int, flags)
 	case MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED:
 		return membarrier_register_global_expedited();
 	case MEMBARRIER_CMD_PRIVATE_EXPEDITED:
-		return membarrier_private_expedited(0);
+		return membarrier_private_expedited(0, cpu_id);
 	case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED:
 		return membarrier_register_private_expedited(0);
 	case MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE:
-		return membarrier_private_expedited(MEMBARRIER_FLAG_SYNC_CORE);
+		return membarrier_private_expedited(MEMBARRIER_FLAG_SYNC_CORE, cpu_id);
 	case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE:
 		return membarrier_register_private_expedited(MEMBARRIER_FLAG_SYNC_CORE);
+	case MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ:
+		return membarrier_private_expedited(MEMBARRIER_FLAG_RSEQ, cpu_id);
+	case MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ:
+		return membarrier_register_private_expedited(MEMBARRIER_FLAG_RSEQ);
 	default:
 		return -EINVAL;
 	}
