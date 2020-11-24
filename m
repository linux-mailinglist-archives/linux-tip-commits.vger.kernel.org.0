Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D9E2C2953
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Nov 2020 15:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388108AbgKXOVI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Nov 2020 09:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731049AbgKXOU4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Nov 2020 09:20:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6313DC0617A6;
        Tue, 24 Nov 2020 06:20:56 -0800 (PST)
Date:   Tue, 24 Nov 2020 14:20:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606227654;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B5M/XbGpw0qcuhk9ljJy9zv6BxLZraaDSjDmbbcO0uE=;
        b=VI2QjDSlq8kaP56WU7PP1bsCyzrsINXQ8QGD6z+zYFtoaDthEJ6IirlQjJuiPBcIwJdA+N
        fqJwkNpZjcxAfaygt6n4jslqeJYvYPUFKWQyhIPepOXx0ePjJk5ipYL0mHhooQUR680SNl
        6hlLkvCw1VWWMNy5xaIJm4JC+QgkrwTjzH4C5Ml52DRq6ofTQjEznC+xVhhtZJPNY6gwb3
        64853X9iv0g2Bw6R2lVRfGazI1IC/fbJnuENbjJuj23hqeGt1evU7k1bKCO/0aaM4mCELQ
        Sm8B72JTTjZdpFHwtmFJc6zgXwZoemTdIuFMfBlPC3y9UzCSQ51K/xmOU6zMGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606227654;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B5M/XbGpw0qcuhk9ljJy9zv6BxLZraaDSjDmbbcO0uE=;
        b=JbmzkEQ9MC9wVWbpd/CliexEfbahX1THBv6yYF4mU1hE38/gEj468ChTfx7mpiwF0vS7uV
        0bYxr68IXBJHKXDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] sched: highmem: Store local kmaps in task struct
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201118204007.372935758@linutronix.de>
References: <20201118204007.372935758@linutronix.de>
MIME-Version: 1.0
Message-ID: <160622765399.11115.16208349138254830194.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     5fbda3ecd14a5343644979c98d6eb65b7e7de9d8
Gitweb:        https://git.kernel.org/tip/5fbda3ecd14a5343644979c98d6eb65b7e7de9d8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 18 Nov 2020 20:48:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 24 Nov 2020 14:42:09 +01:00

sched: highmem: Store local kmaps in task struct

Instead of storing the map per CPU provide and use per task storage. That
prepares for local kmaps which are preemptible.

The context switch code is preparatory and not yet in use because
kmap_atomic() runs with preemption disabled. Will be made usable in the
next step.

The context switch logic is safe even when an interrupt happens after
clearing or before restoring the kmaps. The kmap index in task struct is
not modified so any nesting kmap in an interrupt will use unused indices
and on return the counter is the same as before.

Also add an assert into the return to user space code. Going back to user
space with an active kmap local is a nono.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20201118204007.372935758@linutronix.de

---
 include/linux/highmem-internal.h |  10 +++-
 include/linux/sched.h            |   9 +++-
 kernel/entry/common.c            |   2 +-
 kernel/fork.c                    |   1 +-
 kernel/sched/core.c              |  25 ++++++++-
 mm/highmem.c                     |  99 ++++++++++++++++++++++++++----
 6 files changed, 136 insertions(+), 10 deletions(-)

diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index 6ceed90..c5a2217 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -9,6 +9,16 @@
 void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot);
 void *__kmap_local_page_prot(struct page *page, pgprot_t prot);
 void kunmap_local_indexed(void *vaddr);
+void kmap_local_fork(struct task_struct *tsk);
+void __kmap_local_sched_out(void);
+void __kmap_local_sched_in(void);
+static inline void kmap_assert_nomap(void)
+{
+	DEBUG_LOCKS_WARN_ON(current->kmap_ctrl.idx);
+}
+#else
+static inline void kmap_local_fork(struct task_struct *tsk) { }
+static inline void kmap_assert_nomap(void) { }
 #endif
 
 #ifdef CONFIG_HIGHMEM
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a33f35f..8946911 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -34,6 +34,7 @@
 #include <linux/rseq.h>
 #include <linux/seqlock.h>
 #include <linux/kcsan.h>
+#include <asm/kmap_size.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -629,6 +630,13 @@ struct wake_q_node {
 	struct wake_q_node *next;
 };
 
+struct kmap_ctrl {
+#ifdef CONFIG_KMAP_LOCAL
+	int				idx;
+	pte_t				pteval[KM_MAX_IDX];
+#endif
+};
+
 struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/*
@@ -1294,6 +1302,7 @@ struct task_struct {
 	unsigned int			sequential_io;
 	unsigned int			sequential_io_avg;
 #endif
+	struct kmap_ctrl		kmap_ctrl;
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 	unsigned long			task_state_change;
 #endif
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 2b83666..4ae1fe0 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -2,6 +2,7 @@
 
 #include <linux/context_tracking.h>
 #include <linux/entry-common.h>
+#include <linux/highmem.h>
 #include <linux/livepatch.h>
 #include <linux/audit.h>
 
@@ -194,6 +195,7 @@ static void exit_to_user_mode_prepare(struct pt_regs *regs)
 
 	/* Ensure that the address limit is intact and no locks are held */
 	addr_limit_user_check();
+	kmap_assert_nomap();
 	lockdep_assert_irqs_disabled();
 	lockdep_sys_exit();
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index 32083db..17dcd18 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -930,6 +930,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	account_kernel_stack(tsk, 1);
 
 	kcov_task_init(tsk);
+	kmap_local_fork(tsk);
 
 #ifdef CONFIG_FAULT_INJECTION
 	tsk->fail_nth = 0;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c962922..953abdb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4094,6 +4094,22 @@ static inline void finish_lock_switch(struct rq *rq)
 # define finish_arch_post_lock_switch()	do { } while (0)
 #endif
 
+static inline void kmap_local_sched_out(void)
+{
+#ifdef CONFIG_KMAP_LOCAL
+	if (unlikely(current->kmap_ctrl.idx))
+		__kmap_local_sched_out();
+#endif
+}
+
+static inline void kmap_local_sched_in(void)
+{
+#ifdef CONFIG_KMAP_LOCAL
+	if (unlikely(current->kmap_ctrl.idx))
+		__kmap_local_sched_in();
+#endif
+}
+
 /**
  * prepare_task_switch - prepare to switch tasks
  * @rq: the runqueue preparing to switch
@@ -4116,6 +4132,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
 	perf_event_task_sched_out(prev, next);
 	rseq_preempt(prev);
 	fire_sched_out_preempt_notifiers(prev, next);
+	kmap_local_sched_out();
 	prepare_task(next);
 	prepare_arch_switch(next);
 }
@@ -4182,6 +4199,14 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	finish_lock_switch(rq);
 	finish_arch_post_lock_switch();
 	kcov_finish_switch(current);
+	/*
+	 * kmap_local_sched_out() is invoked with rq::lock held and
+	 * interrupts disabled. There is no requirement for that, but the
+	 * sched out code does not have an interrupt enabled section.
+	 * Restoring the maps on sched in does not require interrupts being
+	 * disabled either.
+	 */
+	kmap_local_sched_in();
 
 	fire_sched_in_preempt_notifiers(current);
 	/*
diff --git a/mm/highmem.c b/mm/highmem.c
index 39aaca1..d1ef06a 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -365,8 +365,6 @@ EXPORT_SYMBOL(kunmap_high);
 
 #include <asm/kmap_size.h>
 
-static DEFINE_PER_CPU(int, __kmap_local_idx);
-
 /*
  * With DEBUG_KMAP_LOCAL the stack depth is doubled and every second
  * slot is unused which acts as a guard page
@@ -379,23 +377,21 @@ static DEFINE_PER_CPU(int, __kmap_local_idx);
 
 static inline int kmap_local_idx_push(void)
 {
-	int idx = __this_cpu_add_return(__kmap_local_idx, KM_INCR) - 1;
-
 	WARN_ON_ONCE(in_irq() && !irqs_disabled());
-	BUG_ON(idx >= KM_MAX_IDX);
-	return idx;
+	current->kmap_ctrl.idx += KM_INCR;
+	BUG_ON(current->kmap_ctrl.idx >= KM_MAX_IDX);
+	return current->kmap_ctrl.idx - 1;
 }
 
 static inline int kmap_local_idx(void)
 {
-	return __this_cpu_read(__kmap_local_idx) - 1;
+	return current->kmap_ctrl.idx - 1;
 }
 
 static inline void kmap_local_idx_pop(void)
 {
-	int idx = __this_cpu_sub_return(__kmap_local_idx, KM_INCR);
-
-	BUG_ON(idx < 0);
+	current->kmap_ctrl.idx -= KM_INCR;
+	BUG_ON(current->kmap_ctrl.idx < 0);
 }
 
 #ifndef arch_kmap_local_post_map
@@ -464,6 +460,7 @@ void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot)
 	pteval = pfn_pte(pfn, prot);
 	set_pte_at(&init_mm, vaddr, kmap_pte - idx, pteval);
 	arch_kmap_local_post_map(vaddr, pteval);
+	current->kmap_ctrl.pteval[kmap_local_idx()] = pteval;
 	preempt_enable();
 
 	return (void *)vaddr;
@@ -522,10 +519,92 @@ void kunmap_local_indexed(void *vaddr)
 	arch_kmap_local_pre_unmap(addr);
 	pte_clear(&init_mm, addr, kmap_pte - idx);
 	arch_kmap_local_post_unmap(addr);
+	current->kmap_ctrl.pteval[kmap_local_idx()] = __pte(0);
 	kmap_local_idx_pop();
 	preempt_enable();
 }
 EXPORT_SYMBOL(kunmap_local_indexed);
+
+/*
+ * Invoked before switch_to(). This is safe even when during or after
+ * clearing the maps an interrupt which needs a kmap_local happens because
+ * the task::kmap_ctrl.idx is not modified by the unmapping code so a
+ * nested kmap_local will use the next unused index and restore the index
+ * on unmap. The already cleared kmaps of the outgoing task are irrelevant
+ * because the interrupt context does not know about them. The same applies
+ * when scheduling back in for an interrupt which happens before the
+ * restore is complete.
+ */
+void __kmap_local_sched_out(void)
+{
+	struct task_struct *tsk = current;
+	pte_t *kmap_pte = kmap_get_pte();
+	int i;
+
+	/* Clear kmaps */
+	for (i = 0; i < tsk->kmap_ctrl.idx; i++) {
+		pte_t pteval = tsk->kmap_ctrl.pteval[i];
+		unsigned long addr;
+		int idx;
+
+		/* With debug all even slots are unmapped and act as guard */
+		if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !(i & 0x01)) {
+			WARN_ON_ONCE(!pte_none(pteval));
+			continue;
+		}
+		if (WARN_ON_ONCE(pte_none(pteval)))
+			continue;
+
+		/*
+		 * This is a horrible hack for XTENSA to calculate the
+		 * coloured PTE index. Uses the PFN encoded into the pteval
+		 * and the map index calculation because the actual mapped
+		 * virtual address is not stored in task::kmap_ctrl.
+		 * For any sane architecture this is optimized out.
+		 */
+		idx = arch_kmap_local_map_idx(i, pte_pfn(pteval));
+
+		addr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+		arch_kmap_local_pre_unmap(addr);
+		pte_clear(&init_mm, addr, kmap_pte - idx);
+		arch_kmap_local_post_unmap(addr);
+	}
+}
+
+void __kmap_local_sched_in(void)
+{
+	struct task_struct *tsk = current;
+	pte_t *kmap_pte = kmap_get_pte();
+	int i;
+
+	/* Restore kmaps */
+	for (i = 0; i < tsk->kmap_ctrl.idx; i++) {
+		pte_t pteval = tsk->kmap_ctrl.pteval[i];
+		unsigned long addr;
+		int idx;
+
+		/* With debug all even slots are unmapped and act as guard */
+		if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !(i & 0x01)) {
+			WARN_ON_ONCE(!pte_none(pteval));
+			continue;
+		}
+		if (WARN_ON_ONCE(pte_none(pteval)))
+			continue;
+
+		/* See comment in __kmap_local_sched_out() */
+		idx = arch_kmap_local_map_idx(i, pte_pfn(pteval));
+		addr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+		set_pte_at(&init_mm, addr, kmap_pte - idx, pteval);
+		arch_kmap_local_post_map(addr, pteval);
+	}
+}
+
+void kmap_local_fork(struct task_struct *tsk)
+{
+	if (WARN_ON_ONCE(tsk->kmap_ctrl.idx))
+		memset(&tsk->kmap_ctrl, 0, sizeof(tsk->kmap_ctrl));
+}
+
 #endif
 
 #if defined(HASHED_PAGE_VIRTUAL)
