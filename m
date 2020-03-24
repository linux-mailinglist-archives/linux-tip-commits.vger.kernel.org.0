Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50915190926
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Mar 2020 10:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgCXJSd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Mar 2020 05:18:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44043 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbgCXJRB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Mar 2020 05:17:01 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfg6-000896-OL; Tue, 24 Mar 2020 10:16:54 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B88F01C04D0;
        Tue, 24 Mar 2020 10:16:45 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:45 -0000
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Support kfree_bulk() interface in kfree_rcu()
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504140531.28353.17424454501849817851.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     34c881745549e78f31ec65f319457c82aacc53bd
Gitweb:        https://git.kernel.org/tip/34c881745549e78f31ec65f319457c82aacc53bd
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Mon, 20 Jan 2020 15:42:25 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 15:58:51 -08:00

rcu: Support kfree_bulk() interface in kfree_rcu()

The kfree_rcu() logic can be improved further by using kfree_bulk()
interface along with "basic batching support" introduced earlier.

The are at least two advantages of using "bulk" interface:
- in case of large number of kfree_rcu() requests kfree_bulk()
  reduces the per-object overhead caused by calling kfree()
  per-object.

- reduces the number of cache-misses due to "pointer chasing"
  between objects which can be far spread between each other.

This approach defines a new kfree_rcu_bulk_data structure that
stores pointers in an array with a specific size. Number of entries
in that array depends on PAGE_SIZE making kfree_rcu_bulk_data
structure to be exactly one page.

Since it deals with "block-chain" technique there is an extra
need in dynamic allocation when a new block is required. Memory
is allocated with GFP_NOWAIT | __GFP_NOWARN flags, i.e. that
allows to skip direct reclaim under low memory condition to
prevent stalling and fails silently under high memory pressure.

The "emergency path" gets maintained when a system is run out of
memory. In that case objects are linked into regular list.

The "rcuperf" was run to analyze this change in terms of memory
consumption and kfree_bulk() throughput.

1) Testing on the Intel(R) Xeon(R) W-2135 CPU @ 3.70GHz, 12xCPUs
with following parameters:

kfree_loops=200000 kfree_alloc_num=1000 kfree_rcu_test=1 kfree_vary_obj_size=1
dev.2020.01.10a branch

Default / CONFIG_SLAB
53607352517 ns, loops: 200000, batches: 1885, memory footprint: 1248MB
53529637912 ns, loops: 200000, batches: 1921, memory footprint: 1193MB
53570175705 ns, loops: 200000, batches: 1929, memory footprint: 1250MB

Patch / CONFIG_SLAB
23981587315 ns, loops: 200000, batches: 810, memory footprint: 1219MB
23879375281 ns, loops: 200000, batches: 822, memory footprint: 1190MB
24086841707 ns, loops: 200000, batches: 794, memory footprint: 1380MB

Default / CONFIG_SLUB
51291025022 ns, loops: 200000, batches: 1713, memory footprint: 741MB
51278911477 ns, loops: 200000, batches: 1671, memory footprint: 719MB
51256183045 ns, loops: 200000, batches: 1719, memory footprint: 647MB

Patch / CONFIG_SLUB
50709919132 ns, loops: 200000, batches: 1618, memory footprint: 456MB
50736297452 ns, loops: 200000, batches: 1633, memory footprint: 507MB
50660403893 ns, loops: 200000, batches: 1628, memory footprint: 429MB

in case of CONFIG_SLAB there is double increase in performance and
slightly higher memory usage. As for CONFIG_SLUB, the performance
figures are better together with lower memory usage.

2) Testing on the HiKey-960, arm64, 8xCPUs with below parameters:

CONFIG_SLAB=y
kfree_loops=200000 kfree_alloc_num=1000 kfree_rcu_test=1

102898760401 ns, loops: 200000, batches: 5822, memory footprint: 158MB
89947009882  ns, loops: 200000, batches: 6715, memory footprint: 115MB

rcuperf shows approximately ~12% better throughput in case of
using "bulk" interface. The "drain logic" or its RCU callback
does the work faster that leads to better throughput.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 204 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 169 insertions(+), 35 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d91c915..51a3aa8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2689,22 +2689,47 @@ EXPORT_SYMBOL_GPL(call_rcu);
 #define KFREE_DRAIN_JIFFIES (HZ / 50)
 #define KFREE_N_BATCHES 2
 
+/*
+ * This macro defines how many entries the "records" array
+ * will contain. It is based on the fact that the size of
+ * kfree_rcu_bulk_data structure becomes exactly one page.
+ */
+#define KFREE_BULK_MAX_ENTR ((PAGE_SIZE / sizeof(void *)) - 3)
+
+/**
+ * struct kfree_rcu_bulk_data - single block to store kfree_rcu() pointers
+ * @nr_records: Number of active pointers in the array
+ * @records: Array of the kfree_rcu() pointers
+ * @next: Next bulk object in the block chain
+ * @head_free_debug: For debug, when CONFIG_DEBUG_OBJECTS_RCU_HEAD is set
+ */
+struct kfree_rcu_bulk_data {
+	unsigned long nr_records;
+	void *records[KFREE_BULK_MAX_ENTR];
+	struct kfree_rcu_bulk_data *next;
+	struct rcu_head *head_free_debug;
+};
+
 /**
  * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
  * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
  * @head_free: List of kfree_rcu() objects waiting for a grace period
+ * @bhead_free: Bulk-List of kfree_rcu() objects waiting for a grace period
  * @krcp: Pointer to @kfree_rcu_cpu structure
  */
 
 struct kfree_rcu_cpu_work {
 	struct rcu_work rcu_work;
 	struct rcu_head *head_free;
+	struct kfree_rcu_bulk_data *bhead_free;
 	struct kfree_rcu_cpu *krcp;
 };
 
 /**
  * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
  * @head: List of kfree_rcu() objects not yet waiting for a grace period
+ * @bhead: Bulk-List of kfree_rcu() objects not yet waiting for a grace period
+ * @bcached: Keeps at most one object for later reuse when build chain blocks
  * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
  * @lock: Synchronize access to this structure
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
@@ -2718,6 +2743,8 @@ struct kfree_rcu_cpu_work {
  */
 struct kfree_rcu_cpu {
 	struct rcu_head *head;
+	struct kfree_rcu_bulk_data *bhead;
+	struct kfree_rcu_bulk_data *bcached;
 	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
 	spinlock_t lock;
 	struct delayed_work monitor_work;
@@ -2727,14 +2754,24 @@ struct kfree_rcu_cpu {
 
 static DEFINE_PER_CPU(struct kfree_rcu_cpu, krc);
 
+static __always_inline void
+debug_rcu_head_unqueue_bulk(struct rcu_head *head)
+{
+#ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
+	for (; head; head = head->next)
+		debug_rcu_head_unqueue(head);
+#endif
+}
+
 /*
  * This function is invoked in workqueue context after a grace period.
- * It frees all the objects queued on ->head_free.
+ * It frees all the objects queued on ->bhead_free or ->head_free.
  */
 static void kfree_rcu_work(struct work_struct *work)
 {
 	unsigned long flags;
 	struct rcu_head *head, *next;
+	struct kfree_rcu_bulk_data *bhead, *bnext;
 	struct kfree_rcu_cpu *krcp;
 	struct kfree_rcu_cpu_work *krwp;
 
@@ -2744,22 +2781,41 @@ static void kfree_rcu_work(struct work_struct *work)
 	spin_lock_irqsave(&krcp->lock, flags);
 	head = krwp->head_free;
 	krwp->head_free = NULL;
+	bhead = krwp->bhead_free;
+	krwp->bhead_free = NULL;
 	spin_unlock_irqrestore(&krcp->lock, flags);
 
-	// List "head" is now private, so traverse locklessly.
+	/* "bhead" is now private, so traverse locklessly. */
+	for (; bhead; bhead = bnext) {
+		bnext = bhead->next;
+
+		debug_rcu_head_unqueue_bulk(bhead->head_free_debug);
+
+		rcu_lock_acquire(&rcu_callback_map);
+		kfree_bulk(bhead->nr_records, bhead->records);
+		rcu_lock_release(&rcu_callback_map);
+
+		if (cmpxchg(&krcp->bcached, NULL, bhead))
+			free_page((unsigned long) bhead);
+
+		cond_resched_tasks_rcu_qs();
+	}
+
+	/*
+	 * Emergency case only. It can happen under low memory
+	 * condition when an allocation gets failed, so the "bulk"
+	 * path can not be temporary maintained.
+	 */
 	for (; head; head = next) {
 		unsigned long offset = (unsigned long)head->func;
 
 		next = head->next;
-		// Potentially optimize with kfree_bulk in future.
 		debug_rcu_head_unqueue(head);
 		rcu_lock_acquire(&rcu_callback_map);
 		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
 
-		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset))) {
-			/* Could be optimized with kfree_bulk() in future. */
+		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
 			kfree((void *)head - offset);
-		}
 
 		rcu_lock_release(&rcu_callback_map);
 		cond_resched_tasks_rcu_qs();
@@ -2774,26 +2830,48 @@ static void kfree_rcu_work(struct work_struct *work)
  */
 static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 {
+	struct kfree_rcu_cpu_work *krwp;
+	bool queued = false;
 	int i;
-	struct kfree_rcu_cpu_work *krwp = NULL;
 
 	lockdep_assert_held(&krcp->lock);
-	for (i = 0; i < KFREE_N_BATCHES; i++)
-		if (!krcp->krw_arr[i].head_free) {
-			krwp = &(krcp->krw_arr[i]);
-			break;
-		}
 
-	// If a previous RCU batch is in progress, we cannot immediately
-	// queue another one, so return false to tell caller to retry.
-	if (!krwp)
-		return false;
+	for (i = 0; i < KFREE_N_BATCHES; i++) {
+		krwp = &(krcp->krw_arr[i]);
 
-	krwp->head_free = krcp->head;
-	krcp->head = NULL;
-	INIT_RCU_WORK(&krwp->rcu_work, kfree_rcu_work);
-	queue_rcu_work(system_wq, &krwp->rcu_work);
-	return true;
+		/*
+		 * Try to detach bhead or head and attach it over any
+		 * available corresponding free channel. It can be that
+		 * a previous RCU batch is in progress, it means that
+		 * immediately to queue another one is not possible so
+		 * return false to tell caller to retry.
+		 */
+		if ((krcp->bhead && !krwp->bhead_free) ||
+				(krcp->head && !krwp->head_free)) {
+			/* Channel 1. */
+			if (!krwp->bhead_free) {
+				krwp->bhead_free = krcp->bhead;
+				krcp->bhead = NULL;
+			}
+
+			/* Channel 2. */
+			if (!krwp->head_free) {
+				krwp->head_free = krcp->head;
+				krcp->head = NULL;
+			}
+
+			/*
+			 * One work is per one batch, so there are two "free channels",
+			 * "bhead_free" and "head_free" the batch can handle. It can be
+			 * that the work is in the pending state when two channels have
+			 * been detached following each other, one by one.
+			 */
+			queue_rcu_work(system_wq, &krwp->rcu_work);
+			queued = true;
+		}
+	}
+
+	return queued;
 }
 
 static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
@@ -2830,19 +2908,65 @@ static void kfree_rcu_monitor(struct work_struct *work)
 		spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
+static inline bool
+kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
+	struct rcu_head *head, rcu_callback_t func)
+{
+	struct kfree_rcu_bulk_data *bnode;
+
+	if (unlikely(!krcp->initialized))
+		return false;
+
+	lockdep_assert_held(&krcp->lock);
+
+	/* Check if a new block is required. */
+	if (!krcp->bhead ||
+			krcp->bhead->nr_records == KFREE_BULK_MAX_ENTR) {
+		bnode = xchg(&krcp->bcached, NULL);
+		if (!bnode) {
+			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
+
+			bnode = (struct kfree_rcu_bulk_data *)
+				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
+		}
+
+		/* Switch to emergency path. */
+		if (unlikely(!bnode))
+			return false;
+
+		/* Initialize the new block. */
+		bnode->nr_records = 0;
+		bnode->next = krcp->bhead;
+		bnode->head_free_debug = NULL;
+
+		/* Attach it to the head. */
+		krcp->bhead = bnode;
+	}
+
+#ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
+	head->func = func;
+	head->next = krcp->bhead->head_free_debug;
+	krcp->bhead->head_free_debug = head;
+#endif
+
+	/* Finally insert. */
+	krcp->bhead->records[krcp->bhead->nr_records++] =
+		(void *) head - (unsigned long) func;
+
+	return true;
+}
+
 /*
- * Queue a request for lazy invocation of kfree() after a grace period.
+ * Queue a request for lazy invocation of kfree_bulk()/kfree() after a grace
+ * period. Please note there are two paths are maintained, one is the main one
+ * that uses kfree_bulk() interface and second one is emergency one, that is
+ * used only when the main path can not be maintained temporary, due to memory
+ * pressure.
  *
  * Each kfree_call_rcu() request is added to a batch. The batch will be drained
- * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch
- * will be kfree'd in workqueue context. This allows us to:
- *
- * 1.	Batch requests together to reduce the number of grace periods during
- *	heavy kfree_rcu() load.
- *
- * 2.	It makes it possible to use kfree_bulk() on a large number of
- *	kfree_rcu() requests thus reducing cache misses and the per-object
- *	overhead of kfree().
+ * every KFREE_DRAIN_JIFFIES number of jiffies. All the objects in the batch will
+ * be free'd in workqueue context. This allows us to: batch requests together to
+ * reduce the number of grace periods during heavy kfree_rcu() load.
  */
 void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
@@ -2861,9 +2985,16 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 			  __func__, head);
 		goto unlock_return;
 	}
-	head->func = func;
-	head->next = krcp->head;
-	krcp->head = head;
+
+	/*
+	 * Under high memory pressure GFP_NOWAIT can fail,
+	 * in that case the emergency path is maintained.
+	 */
+	if (unlikely(!kfree_call_rcu_add_ptr_to_bulk(krcp, head, func))) {
+		head->func = func;
+		head->next = krcp->head;
+		krcp->head = head;
+	}
 
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
@@ -3769,8 +3900,11 @@ static void __init kfree_rcu_batch_init(void)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		spin_lock_init(&krcp->lock);
-		for (i = 0; i < KFREE_N_BATCHES; i++)
+		for (i = 0; i < KFREE_N_BATCHES; i++) {
+			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
+		}
+
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
 		krcp->initialized = true;
 	}
