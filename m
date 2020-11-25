Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D452C41A2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Nov 2020 15:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgKYOC5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 25 Nov 2020 09:02:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50324 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbgKYOC5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 25 Nov 2020 09:02:57 -0500
Date:   Wed, 25 Nov 2020 14:02:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606312973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=K5xrIxV6nGXKMfiEkI0Rc6uM5gzRNJKJaCqBwLjFAX4=;
        b=hqALZG5+IhI2dP0ajHzgKXoH5APRk8Pp8/h533C3l/Scb8YjnKUqfjh9KSK/0I9E7vZZHG
        84UNWekv69SUycMVpiZnhxoWiDGtrlFdyTg5N8A4hz1B5AKkvwpGcECMWb7qTm7I1IKeuq
        hgojSRA9q4MAdWfLg1Twk5JAnxHuTnJ5dgQM9gKscBwWmn6m08yStC6v7zC/O7J2v0kDgz
        OuDDh7Wh/gXSxXemisvShMmGO+tlLInqgfU/KtK4fpdWhJpWu+w2TFp6t7FuP47JWHphuJ
        0GO3XtrokVivWjRYbmoTX98D4dpORGGR56ahl2jj+821muik10oTylAHRVLQlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606312973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=K5xrIxV6nGXKMfiEkI0Rc6uM5gzRNJKJaCqBwLjFAX4=;
        b=bgyEGqiBPg7ylW0PhPz7VdjPZt+QR9pHGN9exTDvXbitxLhKw1aCJBR3q6SNx297HbBhzq
        KI1ReYlKHfQUPQDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] irq_work: Cleanup
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160631297286.3364.8806660214858380101.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7a9f50a05843fee8366bd3a65addbebaa7cf7f07
Gitweb:        https://git.kernel.org/tip/7a9f50a05843fee8366bd3a65addbebaa7cf7f07
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 15 Jun 2020 11:51:29 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 24 Nov 2020 16:47:48 +01:00

irq_work: Cleanup

Get rid of the __call_single_node union and clean up the API a little
to avoid external code relying on the structure layout as much.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/gpu/drm/i915/i915_request.c |  4 +--
 include/linux/irq_work.h            | 33 +++++++++++++++++-----------
 include/linux/irqflags.h            |  4 +--
 kernel/bpf/stackmap.c               |  2 +-
 kernel/irq_work.c                   | 18 +++++++--------
 kernel/printk/printk.c              |  6 +----
 kernel/rcu/tree.c                   |  3 +--
 kernel/time/tick-sched.c            |  6 +----
 kernel/trace/bpf_trace.c            |  2 +-
 9 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index 0e81381..5385b08 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -197,7 +197,7 @@ __notify_execute_cb(struct i915_request *rq, bool (*fn)(struct irq_work *wrk))
 
 	llist_for_each_entry_safe(cb, cn,
 				  llist_del_all(&rq->execute_cb),
-				  work.llnode)
+				  work.node.llist)
 		fn(&cb->work);
 }
 
@@ -460,7 +460,7 @@ __await_execution(struct i915_request *rq,
 	 * callback first, then checking the ACTIVE bit, we serialise with
 	 * the completed/retired request.
 	 */
-	if (llist_add(&cb->work.llnode, &signal->execute_cb)) {
+	if (llist_add(&cb->work.node.llist, &signal->execute_cb)) {
 		if (i915_request_is_active(signal) ||
 		    __request_in_flight(signal))
 			__notify_execute_cb_imm(signal);
diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 3082378..ec2a47a 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -14,28 +14,37 @@
  */
 
 struct irq_work {
-	union {
-		struct __call_single_node node;
-		struct {
-			struct llist_node llnode;
-			atomic_t flags;
-		};
-	};
+	struct __call_single_node node;
 	void (*func)(struct irq_work *);
 };
 
+#define __IRQ_WORK_INIT(_func, _flags) (struct irq_work){	\
+	.node = { .u_flags = (_flags), },			\
+	.func = (_func),					\
+}
+
+#define IRQ_WORK_INIT(_func) __IRQ_WORK_INIT(_func, 0)
+#define IRQ_WORK_INIT_LAZY(_func) __IRQ_WORK_INIT(_func, IRQ_WORK_LAZY)
+#define IRQ_WORK_INIT_HARD(_func) __IRQ_WORK_INIT(_func, IRQ_WORK_HARD_IRQ)
+
+#define DEFINE_IRQ_WORK(name, _f)				\
+	struct irq_work name = IRQ_WORK_INIT(_f)
+
 static inline
 void init_irq_work(struct irq_work *work, void (*func)(struct irq_work *))
 {
-	atomic_set(&work->flags, 0);
-	work->func = func;
+	*work = IRQ_WORK_INIT(func);
 }
 
-#define DEFINE_IRQ_WORK(name, _f) struct irq_work name = {	\
-		.flags = ATOMIC_INIT(0),			\
-		.func  = (_f)					\
+static inline bool irq_work_is_pending(struct irq_work *work)
+{
+	return atomic_read(&work->node.a_flags) & IRQ_WORK_PENDING;
 }
 
+static inline bool irq_work_is_busy(struct irq_work *work)
+{
+	return atomic_read(&work->node.a_flags) & IRQ_WORK_BUSY;
+}
 
 bool irq_work_queue(struct irq_work *work);
 bool irq_work_queue_on(struct irq_work *work, int cpu);
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 3ed4e87..fef2d43 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -109,12 +109,12 @@ do {						\
 
 # define lockdep_irq_work_enter(__work)					\
 	  do {								\
-		  if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))\
+		  if (!(atomic_read(&__work->node.a_flags) & IRQ_WORK_HARD_IRQ))\
 			current->irq_config = 1;			\
 	  } while (0)
 # define lockdep_irq_work_exit(__work)					\
 	  do {								\
-		  if (!(atomic_read(&__work->flags) & IRQ_WORK_HARD_IRQ))\
+		  if (!(atomic_read(&__work->node.a_flags) & IRQ_WORK_HARD_IRQ))\
 			current->irq_config = 0;			\
 	  } while (0)
 
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 06065fa..599041c 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -298,7 +298,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 	if (irqs_disabled()) {
 		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
 			work = this_cpu_ptr(&up_read_work);
-			if (atomic_read(&work->irq_work.flags) & IRQ_WORK_BUSY) {
+			if (irq_work_is_busy(&work->irq_work)) {
 				/* cannot queue more up_read, fallback */
 				irq_work_busy = true;
 			}
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index eca8396..fbff25a 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -31,7 +31,7 @@ static bool irq_work_claim(struct irq_work *work)
 {
 	int oflags;
 
-	oflags = atomic_fetch_or(IRQ_WORK_CLAIMED | CSD_TYPE_IRQ_WORK, &work->flags);
+	oflags = atomic_fetch_or(IRQ_WORK_CLAIMED | CSD_TYPE_IRQ_WORK, &work->node.a_flags);
 	/*
 	 * If the work is already pending, no need to raise the IPI.
 	 * The pairing atomic_fetch_andnot() in irq_work_run() makes sure
@@ -53,12 +53,12 @@ void __weak arch_irq_work_raise(void)
 static void __irq_work_queue_local(struct irq_work *work)
 {
 	/* If the work is "lazy", handle it from next tick if any */
-	if (atomic_read(&work->flags) & IRQ_WORK_LAZY) {
-		if (llist_add(&work->llnode, this_cpu_ptr(&lazy_list)) &&
+	if (atomic_read(&work->node.a_flags) & IRQ_WORK_LAZY) {
+		if (llist_add(&work->node.llist, this_cpu_ptr(&lazy_list)) &&
 		    tick_nohz_tick_stopped())
 			arch_irq_work_raise();
 	} else {
-		if (llist_add(&work->llnode, this_cpu_ptr(&raised_list)))
+		if (llist_add(&work->node.llist, this_cpu_ptr(&raised_list)))
 			arch_irq_work_raise();
 	}
 }
@@ -102,7 +102,7 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 	if (cpu != smp_processor_id()) {
 		/* Arch remote IPI send/receive backend aren't NMI safe */
 		WARN_ON_ONCE(in_nmi());
-		__smp_call_single_queue(cpu, &work->llnode);
+		__smp_call_single_queue(cpu, &work->node.llist);
 	} else {
 		__irq_work_queue_local(work);
 	}
@@ -142,7 +142,7 @@ void irq_work_single(void *arg)
 	 * to claim that work don't rely on us to handle their data
 	 * while we are in the middle of the func.
 	 */
-	flags = atomic_fetch_andnot(IRQ_WORK_PENDING, &work->flags);
+	flags = atomic_fetch_andnot(IRQ_WORK_PENDING, &work->node.a_flags);
 
 	lockdep_irq_work_enter(work);
 	work->func(work);
@@ -152,7 +152,7 @@ void irq_work_single(void *arg)
 	 * no-one else claimed it meanwhile.
 	 */
 	flags &= ~IRQ_WORK_PENDING;
-	(void)atomic_cmpxchg(&work->flags, flags, flags & ~IRQ_WORK_BUSY);
+	(void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);
 }
 
 static void irq_work_run_list(struct llist_head *list)
@@ -166,7 +166,7 @@ static void irq_work_run_list(struct llist_head *list)
 		return;
 
 	llnode = llist_del_all(list);
-	llist_for_each_entry_safe(work, tmp, llnode, llnode)
+	llist_for_each_entry_safe(work, tmp, llnode, node.llist)
 		irq_work_single(work);
 }
 
@@ -198,7 +198,7 @@ void irq_work_sync(struct irq_work *work)
 {
 	lockdep_assert_irqs_enabled();
 
-	while (atomic_read(&work->flags) & IRQ_WORK_BUSY)
+	while (irq_work_is_busy(work))
 		cpu_relax();
 }
 EXPORT_SYMBOL_GPL(irq_work_sync);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fe64a49..9ef23d4 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3025,10 +3025,8 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
 		wake_up_interruptible(&log_wait);
 }
 
-static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) = {
-	.func = wake_up_klogd_work_func,
-	.flags = ATOMIC_INIT(IRQ_WORK_LAZY),
-};
+static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) =
+	IRQ_WORK_INIT_LAZY(wake_up_klogd_work_func);
 
 void wake_up_klogd(void)
 {
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 06895ef..a41e84f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1311,8 +1311,6 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 		if (IS_ENABLED(CONFIG_IRQ_WORK) &&
 		    !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
 		    (rnp->ffmask & rdp->grpmask)) {
-			init_irq_work(&rdp->rcu_iw, rcu_iw_handler);
-			atomic_set(&rdp->rcu_iw.flags, IRQ_WORK_HARD_IRQ);
 			rdp->rcu_iw_pending = true;
 			rdp->rcu_iw_gp_seq = rnp->gp_seq;
 			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
@@ -3964,6 +3962,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rdp->cpu_no_qs.b.norm = true;
 	rdp->core_needs_qs = false;
 	rdp->rcu_iw_pending = false;
+	rdp->rcu_iw = IRQ_WORK_INIT_HARD(rcu_iw_handler);
 	rdp->rcu_iw_gp_seq = rdp->gp_seq - 1;
 	trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuonl"));
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 81632cd..1b73407 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -243,10 +243,8 @@ static void nohz_full_kick_func(struct irq_work *work)
 	/* Empty, the tick restart happens on tick_nohz_irq_exit() */
 }
 
-static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) = {
-	.func = nohz_full_kick_func,
-	.flags = ATOMIC_INIT(IRQ_WORK_HARD_IRQ),
-};
+static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) =
+	IRQ_WORK_INIT_HARD(nohz_full_kick_func);
 
 /*
  * Kick this CPU if it's full dynticks in order to force it to
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4517c8b..a690391 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1086,7 +1086,7 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type)
 			return -EINVAL;
 
 		work = this_cpu_ptr(&send_signal_work);
-		if (atomic_read(&work->irq_work.flags) & IRQ_WORK_BUSY)
+		if (irq_work_is_busy(&work->irq_work))
 			return -EBUSY;
 
 		/* Add the current task, which is the target of sending signal,
