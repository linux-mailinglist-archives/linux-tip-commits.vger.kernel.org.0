Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5174A3F476C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Aug 2021 11:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbhHWJ1J (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Aug 2021 05:27:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39046 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhHWJ1F (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Aug 2021 05:27:05 -0400
Date:   Mon, 23 Aug 2021 09:26:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629710782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5zHqObTP8NYqH0l300B3BVqXudITCbXEhQ5ZDIbSefM=;
        b=MfSmnFFelA3avODCJThGE10+0Jh/KfagBqwdhVPuK5FMwMaN8Mc+ifZUjDGbuPVAGqcMvB
        ZVmnFl1fh+culWR7i8zQUmQBE09kiyTzlMgGM3WDTLsJ2h9uj1mdbF9mzMz10HwCGcjIcQ
        7C0D8e8sDmnKYG7g4mz9knNt5QWiPB/J986C4jkWu68vVWmKi8393f7z8JzX0PEji1ZTTr
        FnXVTCncS3tBPoJFR8a/gG/3XWWczbOdg22XmqXZAkqRaY2Ebdx9pD5i2wK41yv0e5Hj9d
        6SadTUYHtKHt2EFERcXrL3HCtCjQPVTikYydqzUr2ENZ3DVbEuafVe8ytlt5ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629710782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5zHqObTP8NYqH0l300B3BVqXudITCbXEhQ5ZDIbSefM=;
        b=Hw9mrNFo005gC83ql1GPV0OVCpFfAsaoomoDVG9+JFbWRNX6NeUqT7JdQMqPFag76SpEPy
        VI7SCMskL/XM4ECQ==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Introduce task_struct::user_cpus_ptr to
 track requested affinity
Cc:     Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210730112443.23245-7-will@kernel.org>
References: <20210730112443.23245-7-will@kernel.org>
MIME-Version: 1.0
Message-ID: <162971078187.25758.12447255888299814756.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b90ca8badbd11488e5f762346b028666808164e7
Gitweb:        https://git.kernel.org/tip/b90ca8badbd11488e5f762346b028666808164e7
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Fri, 30 Jul 2021 12:24:33 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Aug 2021 12:33:00 +02:00

sched: Introduce task_struct::user_cpus_ptr to track requested affinity

In preparation for saving and restoring the user-requested CPU affinity
mask of a task, add a new cpumask_t pointer to 'struct task_struct'.

If the pointer is non-NULL, then the mask is copied across fork() and
freed on task exit.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>
Link: https://lore.kernel.org/r/20210730112443.23245-7-will@kernel.org
---
 include/linux/sched.h | 13 +++++++++++++
 init/init_task.c      |  1 +
 kernel/fork.c         |  2 ++
 kernel/sched/core.c   | 20 ++++++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 50db949..2c5d638 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -748,6 +748,7 @@ struct task_struct {
 	unsigned int			policy;
 	int				nr_cpus_allowed;
 	const cpumask_t			*cpus_ptr;
+	cpumask_t			*user_cpus_ptr;
 	cpumask_t			cpus_mask;
 	void				*migration_pending;
 #ifdef CONFIG_SMP
@@ -1706,6 +1707,8 @@ extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_
 #ifdef CONFIG_SMP
 extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
 extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
+extern int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src, int node);
+extern void release_user_cpus_ptr(struct task_struct *p);
 #else
 static inline void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 {
@@ -1716,6 +1719,16 @@ static inline int set_cpus_allowed_ptr(struct task_struct *p, const struct cpuma
 		return -EINVAL;
 	return 0;
 }
+static inline int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src, int node)
+{
+	if (src->user_cpus_ptr)
+		return -EINVAL;
+	return 0;
+}
+static inline void release_user_cpus_ptr(struct task_struct *p)
+{
+	WARN_ON(p->user_cpus_ptr);
+}
 #endif
 
 extern int yield_to(struct task_struct *p, bool preempt);
diff --git a/init/init_task.c b/init/init_task.c
index 562f2ef..2d02406 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -80,6 +80,7 @@ struct task_struct init_task
 	.normal_prio	= MAX_PRIO - 20,
 	.policy		= SCHED_NORMAL,
 	.cpus_ptr	= &init_task.cpus_mask,
+	.user_cpus_ptr	= NULL,
 	.cpus_mask	= CPU_MASK_ALL,
 	.nr_cpus_allowed= NR_CPUS,
 	.mm		= NULL,
diff --git a/kernel/fork.c b/kernel/fork.c
index 1a9af73..5d7addf 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -446,6 +446,7 @@ void put_task_stack(struct task_struct *tsk)
 
 void free_task(struct task_struct *tsk)
 {
+	release_user_cpus_ptr(tsk);
 	scs_release(tsk);
 
 #ifndef CONFIG_THREAD_INFO_IN_TASK
@@ -919,6 +920,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #endif
 	if (orig->cpus_ptr == &orig->cpus_mask)
 		tsk->cpus_ptr = &tsk->cpus_mask;
+	dup_user_cpus_ptr(tsk, orig, node);
 
 	/*
 	 * One for the user space visible state that goes away when reaped.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8cec0d2..360a3ec 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2480,6 +2480,26 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 	__do_set_cpus_allowed(p, new_mask, 0);
 }
 
+int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
+		      int node)
+{
+	if (!src->user_cpus_ptr)
+		return 0;
+
+	dst->user_cpus_ptr = kmalloc_node(cpumask_size(), GFP_KERNEL, node);
+	if (!dst->user_cpus_ptr)
+		return -ENOMEM;
+
+	cpumask_copy(dst->user_cpus_ptr, src->user_cpus_ptr);
+	return 0;
+}
+
+void release_user_cpus_ptr(struct task_struct *p)
+{
+	kfree(p->user_cpus_ptr);
+	p->user_cpus_ptr = NULL;
+}
+
 /*
  * This function is wildly self concurrent; here be dragons.
  *
