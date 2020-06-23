Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F4D204ADB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Jun 2020 09:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbgFWHTv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 23 Jun 2020 03:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731520AbgFWHTu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 23 Jun 2020 03:19:50 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DB4C061573;
        Tue, 23 Jun 2020 00:19:49 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jndDa-0003Bl-Ot; Tue, 23 Jun 2020 09:19:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7B1101C0244;
        Tue, 23 Jun 2020 09:19:41 +0200 (CEST)
Date:   Tue, 23 Jun 2020 07:19:41 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] smp, irq_work: Continue smp_call_function*() and
 irq_work*() integration
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200622100825.844455025@infradead.org>
References: <20200622100825.844455025@infradead.org>
MIME-Version: 1.0
Message-ID: <159289678116.16989.7718524500390651842.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     ad6567b439016f9ffd01bbb25276ee363d9a106a
Gitweb:        https://git.kernel.org/tip/ad6567b439016f9ffd01bbb25276ee363d9a106a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 22 Jun 2020 12:01:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 22 Jun 2020 20:51:06 +02:00

smp, irq_work: Continue smp_call_function*() and irq_work*() integration

Instead of relying on BUG_ON() to ensure the various data structures
line up, use a bunch of horrible unions.

Much of the union magic is to ensure irq_work and smp_call_function do
not (yet) see the members of their respective data structures change
name.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20200622100825.844455025@infradead.org
---
 include/linux/irq_work.h  | 26 ++++-----------
 include/linux/sched.h     |  5 +---
 include/linux/smp.h       | 23 ++++---------
 include/linux/smp_types.h | 66 ++++++++++++++++++++++++++++++++++++++-
 kernel/sched/core.c       |  6 +--
 kernel/smp.c              | 18 +----------
 6 files changed, 86 insertions(+), 58 deletions(-)
 create mode 100644 include/linux/smp_types.h

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 2735da5..3082378 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_IRQ_WORK_H
 #define _LINUX_IRQ_WORK_H
 
-#include <linux/llist.h>
+#include <linux/smp_types.h>
 
 /*
  * An entry can be in one of four states:
@@ -13,24 +13,14 @@
  * busy      NULL, 2 -> {free, claimed} : callback in progress, can be claimed
  */
 
-/* flags share CSD_FLAG_ space */
-
-#define IRQ_WORK_PENDING	BIT(0)
-#define IRQ_WORK_BUSY		BIT(1)
-
-/* Doesn't want IPI, wait for tick: */
-#define IRQ_WORK_LAZY		BIT(2)
-/* Run hard IRQ context, even on RT */
-#define IRQ_WORK_HARD_IRQ	BIT(3)
-
-#define IRQ_WORK_CLAIMED	(IRQ_WORK_PENDING | IRQ_WORK_BUSY)
-
-/*
- * structure shares layout with single_call_data_t.
- */
 struct irq_work {
-	struct llist_node llnode;
-	atomic_t flags;
+	union {
+		struct __call_single_node node;
+		struct {
+			struct llist_node llnode;
+			atomic_t flags;
+		};
+	};
 	void (*func)(struct irq_work *);
 };
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 59caeb9..0376588 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -653,11 +653,8 @@ struct task_struct {
 	unsigned int			ptrace;
 
 #ifdef CONFIG_SMP
-	struct {
-		struct llist_node		wake_entry;
-		unsigned int			wake_entry_type;
-	};
 	int				on_cpu;
+	struct __call_single_node	wake_entry;
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/* Current CPU: */
 	unsigned int			cpu;
diff --git a/include/linux/smp.h b/include/linux/smp.h
index 7ee202a..80d557e 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -12,29 +12,22 @@
 #include <linux/list.h>
 #include <linux/cpumask.h>
 #include <linux/init.h>
-#include <linux/llist.h>
+#include <linux/smp_types.h>
 
 typedef void (*smp_call_func_t)(void *info);
 typedef bool (*smp_cond_func_t)(int cpu, void *info);
 
-enum {
-	CSD_FLAG_LOCK		= 0x01,
-
-	/* IRQ_WORK_flags */
-
-	CSD_TYPE_ASYNC		= 0x00,
-	CSD_TYPE_SYNC		= 0x10,
-	CSD_TYPE_IRQ_WORK	= 0x20,
-	CSD_TYPE_TTWU		= 0x30,
-	CSD_FLAG_TYPE_MASK	= 0xF0,
-};
-
 /*
  * structure shares (partial) layout with struct irq_work
  */
 struct __call_single_data {
-	struct llist_node llist;
-	unsigned int flags;
+	union {
+		struct __call_single_node node;
+		struct {
+			struct llist_node llist;
+			unsigned int flags;
+		};
+	};
 	smp_call_func_t func;
 	void *info;
 };
diff --git a/include/linux/smp_types.h b/include/linux/smp_types.h
new file mode 100644
index 0000000..364b3ae
--- /dev/null
+++ b/include/linux/smp_types.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_SMP_TYPES_H
+#define __LINUX_SMP_TYPES_H
+
+#include <linux/llist.h>
+
+enum {
+	CSD_FLAG_LOCK		= 0x01,
+
+	IRQ_WORK_PENDING	= 0x01,
+	IRQ_WORK_BUSY		= 0x02,
+	IRQ_WORK_LAZY		= 0x04, /* No IPI, wait for tick */
+	IRQ_WORK_HARD_IRQ	= 0x08, /* IRQ context on PREEMPT_RT */
+
+	IRQ_WORK_CLAIMED	= (IRQ_WORK_PENDING | IRQ_WORK_BUSY),
+
+	CSD_TYPE_ASYNC		= 0x00,
+	CSD_TYPE_SYNC		= 0x10,
+	CSD_TYPE_IRQ_WORK	= 0x20,
+	CSD_TYPE_TTWU		= 0x30,
+
+	CSD_FLAG_TYPE_MASK	= 0xF0,
+};
+
+/*
+ * struct __call_single_node is the primary type on
+ * smp.c:call_single_queue.
+ *
+ * flush_smp_call_function_queue() only reads the type from
+ * __call_single_node::u_flags as a regular load, the above
+ * (anonymous) enum defines all the bits of this word.
+ *
+ * Other bits are not modified until the type is known.
+ *
+ * CSD_TYPE_SYNC/ASYNC:
+ *	struct {
+ *		struct llist_node node;
+ *		unsigned int flags;
+ *		smp_call_func_t func;
+ *		void *info;
+ *	};
+ *
+ * CSD_TYPE_IRQ_WORK:
+ *	struct {
+ *		struct llist_node node;
+ *		atomic_t flags;
+ *		void (*func)(struct irq_work *);
+ *	};
+ *
+ * CSD_TYPE_TTWU:
+ *	struct {
+ *		struct llist_node node;
+ *		unsigned int flags;
+ *	};
+ *
+ */
+
+struct __call_single_node {
+	struct llist_node	llist;
+	union {
+		unsigned int	u_flags;
+		atomic_t	a_flags;
+	};
+};
+
+#endif /* __LINUX_SMP_TYPES_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 019db7a..1339440 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2293,7 +2293,7 @@ void sched_ttwu_pending(void *arg)
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 
-	llist_for_each_entry_safe(p, t, llist, wake_entry) {
+	llist_for_each_entry_safe(p, t, llist, wake_entry.llist) {
 		if (WARN_ON_ONCE(p->on_cpu))
 			smp_cond_load_acquire(&p->on_cpu, !VAL);
 
@@ -2329,7 +2329,7 @@ static void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
 
 	WRITE_ONCE(rq->ttwu_pending, 1);
-	__smp_call_single_queue(cpu, &p->wake_entry);
+	__smp_call_single_queue(cpu, &p->wake_entry.llist);
 }
 
 void wake_up_if_idle(int cpu)
@@ -2786,7 +2786,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 #endif
 	init_numa_balancing(clone_flags, p);
 #ifdef CONFIG_SMP
-	p->wake_entry_type = CSD_TYPE_TTWU;
+	p->wake_entry.u_flags = CSD_TYPE_TTWU;
 #endif
 }
 
diff --git a/kernel/smp.c b/kernel/smp.c
index 472c2b2..aa17eed 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -669,24 +669,6 @@ void __init smp_init(void)
 {
 	int num_nodes, num_cpus;
 
-	/*
-	 * Ensure struct irq_work layout matches so that
-	 * flush_smp_call_function_queue() can do horrible things.
-	 */
-	BUILD_BUG_ON(offsetof(struct irq_work, llnode) !=
-		     offsetof(struct __call_single_data, llist));
-	BUILD_BUG_ON(offsetof(struct irq_work, func) !=
-		     offsetof(struct __call_single_data, func));
-	BUILD_BUG_ON(offsetof(struct irq_work, flags) !=
-		     offsetof(struct __call_single_data, flags));
-
-	/*
-	 * Assert the CSD_TYPE_TTWU layout is similar enough
-	 * for task_struct to be on the @call_single_queue.
-	 */
-	BUILD_BUG_ON(offsetof(struct task_struct, wake_entry_type) - offsetof(struct task_struct, wake_entry) !=
-		     offsetof(struct __call_single_data, flags) - offsetof(struct __call_single_data, llist));
-
 	idle_threads_init();
 	cpuhp_threads_init();
 
