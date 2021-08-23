Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826653F4769
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Aug 2021 11:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbhHWJ1F (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Aug 2021 05:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbhHWJ1F (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Aug 2021 05:27:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927EDC061575;
        Mon, 23 Aug 2021 02:26:22 -0700 (PDT)
Date:   Mon, 23 Aug 2021 09:26:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629710781;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MBQlor/kJ/obp6usZW0fkPDGG05Nm00rgx/tSBiQ0sI=;
        b=C6z6bNiYyp5KqI8IusF61I9D3qFSd7kS1T5nRwInQqxM+KijeT+3oHETfpfzs4XtejzGgR
        u96vN84/4TRgI7Wob8H4x3kWk2UDLQdKfUzRcSG0TtO6V3VC0jXVVw9gZ7dtWXOhJpqV3a
        ygRIXevKxOL7CL6r09Paj+y1A9stewflaqOakP0svVZxCwC3NBBLLqHkDuHDYk2oO7AP0C
        Fbz4FAANnxnS3VyS3aCJOBYhLhCXNl9gOkgcmG11zlFJg/OsUMhXWt1At7Du1BE9sjHAac
        M3v8c1CTRh+mZno8mylpl39aOFTDOr3QLgKcLDqMj/3b4y5ROkFqYFfJg7aF1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629710781;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MBQlor/kJ/obp6usZW0fkPDGG05Nm00rgx/tSBiQ0sI=;
        b=lONSvoctgZ0Lggq83MULNpglb37QIimCnKTIw9OzdKQ7j6EVbQmJkyway8jDGeNKCI3k2d
        oPxMgL0yghY1f2BA==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Allow task CPU affinity to be restricted on
 asymmetric systems
Cc:     Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <qperret@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210730112443.23245-9-will@kernel.org>
References: <20210730112443.23245-9-will@kernel.org>
MIME-Version: 1.0
Message-ID: <162971078034.25758.5439057549599204065.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     07ec77a1d4e82526e1588979fff2f024f8e96df2
Gitweb:        https://git.kernel.org/tip/07ec77a1d4e82526e1588979fff2f024f8e96df2
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Fri, 30 Jul 2021 12:24:35 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Aug 2021 12:33:00 +02:00

sched: Allow task CPU affinity to be restricted on asymmetric systems

Asymmetric systems may not offer the same level of userspace ISA support
across all CPUs, meaning that some applications cannot be executed by
some CPUs. As a concrete example, upcoming arm64 big.LITTLE designs do
not feature support for 32-bit applications on both clusters.

Although userspace can carefully manage the affinity masks for such
tasks, one place where it is particularly problematic is execve()
because the CPU on which the execve() is occurring may be incompatible
with the new application image. In such a situation, it is desirable to
restrict the affinity mask of the task and ensure that the new image is
entered on a compatible CPU. From userspace's point of view, this looks
the same as if the incompatible CPUs have been hotplugged off in the
task's affinity mask. Similarly, if a subsequent execve() reverts to
a compatible image, then the old affinity is restored if it is still
valid.

In preparation for restricting the affinity mask for compat tasks on
arm64 systems without uniform support for 32-bit applications, introduce
{force,relax}_compatible_cpus_allowed_ptr(), which respectively restrict
and restore the affinity mask for a task based on the compatible CPUs.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Quentin Perret <qperret@google.com>
Link: https://lore.kernel.org/r/20210730112443.23245-9-will@kernel.org
---
 include/linux/sched.h |   2 +-
 kernel/sched/core.c   | 198 +++++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h  |   1 +-
 3 files changed, 183 insertions(+), 18 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2c5d638..ce2d5cf 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1709,6 +1709,8 @@ extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
 extern int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src, int node);
 extern void release_user_cpus_ptr(struct task_struct *p);
+extern void force_compatible_cpus_allowed_ptr(struct task_struct *p);
+extern void relax_compatible_cpus_allowed_ptr(struct task_struct *p);
 #else
 static inline void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 672d0fc..6ee1970 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2494,10 +2494,18 @@ int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
 	return 0;
 }
 
+static inline struct cpumask *clear_user_cpus_ptr(struct task_struct *p)
+{
+	struct cpumask *user_mask = NULL;
+
+	swap(p->user_cpus_ptr, user_mask);
+
+	return user_mask;
+}
+
 void release_user_cpus_ptr(struct task_struct *p)
 {
-	kfree(p->user_cpus_ptr);
-	p->user_cpus_ptr = NULL;
+	kfree(clear_user_cpus_ptr(p));
 }
 
 /*
@@ -2717,27 +2725,23 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 }
 
 /*
- * Change a given task's CPU affinity. Migrate the thread to a
- * proper CPU and schedule it away if the CPU it's executing on
- * is removed from the allowed bitmask.
- *
- * NOTE: the caller must have a valid reference to the task, the
- * task must not exit() & deallocate itself prematurely. The
- * call is not atomic; no spinlocks may be held.
+ * Called with both p->pi_lock and rq->lock held; drops both before returning.
  */
-static int __set_cpus_allowed_ptr(struct task_struct *p,
-				  const struct cpumask *new_mask,
-				  u32 flags)
+static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
+					 const struct cpumask *new_mask,
+					 u32 flags,
+					 struct rq *rq,
+					 struct rq_flags *rf)
+	__releases(rq->lock)
+	__releases(p->pi_lock)
 {
 	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
 	const struct cpumask *cpu_valid_mask = cpu_active_mask;
 	bool kthread = p->flags & PF_KTHREAD;
+	struct cpumask *user_mask = NULL;
 	unsigned int dest_cpu;
-	struct rq_flags rf;
-	struct rq *rq;
 	int ret = 0;
 
-	rq = task_rq_lock(p, &rf);
 	update_rq_clock(rq);
 
 	if (kthread || is_migration_disabled(p)) {
@@ -2793,20 +2797,178 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
 
 	__do_set_cpus_allowed(p, new_mask, flags);
 
-	return affine_move_task(rq, p, &rf, dest_cpu, flags);
+	if (flags & SCA_USER)
+		user_mask = clear_user_cpus_ptr(p);
+
+	ret = affine_move_task(rq, p, rf, dest_cpu, flags);
+
+	kfree(user_mask);
+
+	return ret;
 
 out:
-	task_rq_unlock(rq, p, &rf);
+	task_rq_unlock(rq, p, rf);
 
 	return ret;
 }
 
+/*
+ * Change a given task's CPU affinity. Migrate the thread to a
+ * proper CPU and schedule it away if the CPU it's executing on
+ * is removed from the allowed bitmask.
+ *
+ * NOTE: the caller must have a valid reference to the task, the
+ * task must not exit() & deallocate itself prematurely. The
+ * call is not atomic; no spinlocks may be held.
+ */
+static int __set_cpus_allowed_ptr(struct task_struct *p,
+				  const struct cpumask *new_mask, u32 flags)
+{
+	struct rq_flags rf;
+	struct rq *rq;
+
+	rq = task_rq_lock(p, &rf);
+	return __set_cpus_allowed_ptr_locked(p, new_mask, flags, rq, &rf);
+}
+
 int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask)
 {
 	return __set_cpus_allowed_ptr(p, new_mask, 0);
 }
 EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
 
+/*
+ * Change a given task's CPU affinity to the intersection of its current
+ * affinity mask and @subset_mask, writing the resulting mask to @new_mask
+ * and pointing @p->user_cpus_ptr to a copy of the old mask.
+ * If the resulting mask is empty, leave the affinity unchanged and return
+ * -EINVAL.
+ */
+static int restrict_cpus_allowed_ptr(struct task_struct *p,
+				     struct cpumask *new_mask,
+				     const struct cpumask *subset_mask)
+{
+	struct cpumask *user_mask = NULL;
+	struct rq_flags rf;
+	struct rq *rq;
+	int err;
+
+	if (!p->user_cpus_ptr) {
+		user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
+		if (!user_mask)
+			return -ENOMEM;
+	}
+
+	rq = task_rq_lock(p, &rf);
+
+	/*
+	 * Forcefully restricting the affinity of a deadline task is
+	 * likely to cause problems, so fail and noisily override the
+	 * mask entirely.
+	 */
+	if (task_has_dl_policy(p) && dl_bandwidth_enabled()) {
+		err = -EPERM;
+		goto err_unlock;
+	}
+
+	if (!cpumask_and(new_mask, &p->cpus_mask, subset_mask)) {
+		err = -EINVAL;
+		goto err_unlock;
+	}
+
+	/*
+	 * We're about to butcher the task affinity, so keep track of what
+	 * the user asked for in case we're able to restore it later on.
+	 */
+	if (user_mask) {
+		cpumask_copy(user_mask, p->cpus_ptr);
+		p->user_cpus_ptr = user_mask;
+	}
+
+	return __set_cpus_allowed_ptr_locked(p, new_mask, 0, rq, &rf);
+
+err_unlock:
+	task_rq_unlock(rq, p, &rf);
+	kfree(user_mask);
+	return err;
+}
+
+/*
+ * Restrict the CPU affinity of task @p so that it is a subset of
+ * task_cpu_possible_mask() and point @p->user_cpu_ptr to a copy of the
+ * old affinity mask. If the resulting mask is empty, we warn and walk
+ * up the cpuset hierarchy until we find a suitable mask.
+ */
+void force_compatible_cpus_allowed_ptr(struct task_struct *p)
+{
+	cpumask_var_t new_mask;
+	const struct cpumask *override_mask = task_cpu_possible_mask(p);
+
+	alloc_cpumask_var(&new_mask, GFP_KERNEL);
+
+	/*
+	 * __migrate_task() can fail silently in the face of concurrent
+	 * offlining of the chosen destination CPU, so take the hotplug
+	 * lock to ensure that the migration succeeds.
+	 */
+	cpus_read_lock();
+	if (!cpumask_available(new_mask))
+		goto out_set_mask;
+
+	if (!restrict_cpus_allowed_ptr(p, new_mask, override_mask))
+		goto out_free_mask;
+
+	/*
+	 * We failed to find a valid subset of the affinity mask for the
+	 * task, so override it based on its cpuset hierarchy.
+	 */
+	cpuset_cpus_allowed(p, new_mask);
+	override_mask = new_mask;
+
+out_set_mask:
+	if (printk_ratelimit()) {
+		printk_deferred("Overriding affinity for process %d (%s) to CPUs %*pbl\n",
+				task_pid_nr(p), p->comm,
+				cpumask_pr_args(override_mask));
+	}
+
+	WARN_ON(set_cpus_allowed_ptr(p, override_mask));
+out_free_mask:
+	cpus_read_unlock();
+	free_cpumask_var(new_mask);
+}
+
+static int
+__sched_setaffinity(struct task_struct *p, const struct cpumask *mask);
+
+/*
+ * Restore the affinity of a task @p which was previously restricted by a
+ * call to force_compatible_cpus_allowed_ptr(). This will clear (and free)
+ * @p->user_cpus_ptr.
+ *
+ * It is the caller's responsibility to serialise this with any calls to
+ * force_compatible_cpus_allowed_ptr(@p).
+ */
+void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
+{
+	struct cpumask *user_mask = p->user_cpus_ptr;
+	unsigned long flags;
+
+	/*
+	 * Try to restore the old affinity mask. If this fails, then
+	 * we free the mask explicitly to avoid it being inherited across
+	 * a subsequent fork().
+	 */
+	if (!user_mask || !__sched_setaffinity(p, user_mask))
+		return;
+
+	raw_spin_lock_irqsave(&p->pi_lock, flags);
+	user_mask = clear_user_cpus_ptr(p);
+	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+
+	kfree(user_mask);
+}
+
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 {
 #ifdef CONFIG_SCHED_DEBUG
@@ -7629,7 +7791,7 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
 	}
 #endif
 again:
-	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK);
+	retval = __set_cpus_allowed_ptr(p, new_mask, SCA_CHECK | SCA_USER);
 	if (retval)
 		goto out_free_new_mask;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5fa0290..e7e2bba 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2244,6 +2244,7 @@ extern struct task_struct *pick_next_task_idle(struct rq *rq);
 #define SCA_CHECK		0x01
 #define SCA_MIGRATE_DISABLE	0x02
 #define SCA_MIGRATE_ENABLE	0x04
+#define SCA_USER		0x08
 
 #ifdef CONFIG_SMP
 
