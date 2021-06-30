Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4203B840B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbhF3NwJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:52:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32944 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbhF3Nut (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:49 -0400
Date:   Wed, 30 Jun 2021 13:48:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060880;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jU/vRj9XdBEnJ3VtshfSLq4iuAuL/0MOSB7eQEcTlS8=;
        b=GgtNIcrrhLI7eNbmFWG3jAG4k0wrZzsIGFNtGNjsSyOp0if/DKO2gTtNP5Zh5nl0lLmm3R
        24yV29SjzPEMXSUK0z/5EKEoXIJ9Y5MaCnLOHInlQp36+swgCQkdzB9rQ27ZY+3vLqM+up
        A7d0YtG+5OqX5JPC2pdWWAAtDzuNfGpfTx/+Y4m84SqHrpul+ZnerejvBlZb0G9pD4Yq/b
        1dnoeV0sWcmElk3M+N7aVi94l3j99mGBKCoeLf0Y1I9ACM/Vlm8JXw42QpWfSDfS5osusx
        3toyfVn8n9ssOSs6iQKrjBlQIs8ZZFdVsg7dhZU54CWH01Ejno0P6NdEQc6FeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060880;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jU/vRj9XdBEnJ3VtshfSLq4iuAuL/0MOSB7eQEcTlS8=;
        b=EoGRzxdbBBT14FD7hvfcawvRWd7UGFuAHsX1hDPjb7ATAcTUmtM7EU2OEd1tqKlqaFikag
        f/w6eKL2bbT5DOAg==
From:   "tip-bot2 for Zhang Qiang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] kvfree_rcu: Release a page cache under memory pressure
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Zqiang <qiang.zhang@windriver.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506088009.395.6907571234245954579.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     d0bfa8b3c411e25e014e4131d2804afe29c440a6
Gitweb:        https://git.kernel.org/tip/d0bfa8b3c411e25e014e4131d2804afe29c440a6
Author:        Zhang Qiang <qiang.zhang@windriver.com>
AuthorDate:    Thu, 15 Apr 2021 19:19:56 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:00:48 -07:00

kvfree_rcu: Release a page cache under memory pressure

Add a drain_page_cache() function to drain a per-cpu page cache.
The reason behind of it is a system can run into a low memory
condition, in that case a page shrinker can ask for its users
to free their caches in order to get extra memory available for
other needs in a system.

When a system hits such condition, a page cache is drained for
all CPUs in a system. By default a page cache work is delayed
with 5 seconds interval until a memory pressure disappears, if
needed it can be changed. See a rcu_delay_page_cache_fill_msec
module parameter.

Co-developed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +-
 kernel/rcu/tree.c                               | 82 ++++++++++++++--
 2 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb89dbd..4405fd3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4290,6 +4290,11 @@
 			whole algorithm to behave better in low memory
 			condition.
 
+	rcutree.rcu_delay_page_cache_fill_msec= [KNL]
+			Set the page-cache refill delay (in milliseconds)
+			in response to low-memory conditions.  The range
+			of permitted values is in the range 0:100000.
+
 	rcutree.jiffies_till_first_fqs= [KNL]
 			Set delay from grace-period initialization to
 			first attempt to force quiescent states.
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8e78b24..74d840a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -186,6 +186,17 @@ module_param(rcu_unlock_delay, int, 0444);
 static int rcu_min_cached_objs = 5;
 module_param(rcu_min_cached_objs, int, 0444);
 
+// A page shrinker can ask for pages to be freed to make them
+// available for other parts of the system. This usually happens
+// under low memory conditions, and in that case we should also
+// defer page-cache filling for a short time period.
+//
+// The default value is 5 seconds, which is long enough to reduce
+// interference with the shrinker while it asks other systems to
+// drain their caches.
+static int rcu_delay_page_cache_fill_msec = 5000;
+module_param(rcu_delay_page_cache_fill_msec, int, 0444);
+
 /* Retrieve RCU kthreads priority for rcutorture */
 int rcu_get_gp_kthreads_prio(void)
 {
@@ -3171,6 +3182,7 @@ struct kfree_rcu_cpu_work {
  *	Even though it is lockless an access has to be protected by the
  *	per-cpu lock.
  * @page_cache_work: A work to refill the cache when it is empty
+ * @backoff_page_cache_fill: Delay cache refills
  * @work_in_progress: Indicates that page_cache_work is running
  * @hrtimer: A hrtimer for scheduling a page_cache_work
  * @nr_bkv_objs: number of allocated objects at @bkvcache.
@@ -3190,7 +3202,8 @@ struct kfree_rcu_cpu {
 	bool initialized;
 	int count;
 
-	struct work_struct page_cache_work;
+	struct delayed_work page_cache_work;
+	atomic_t backoff_page_cache_fill;
 	atomic_t work_in_progress;
 	struct hrtimer hrtimer;
 
@@ -3256,6 +3269,26 @@ put_cached_bnode(struct kfree_rcu_cpu *krcp,
 
 }
 
+static int
+drain_page_cache(struct kfree_rcu_cpu *krcp)
+{
+	unsigned long flags;
+	struct llist_node *page_list, *pos, *n;
+	int freed = 0;
+
+	raw_spin_lock_irqsave(&krcp->lock, flags);
+	page_list = llist_del_all(&krcp->bkvcache);
+	krcp->nr_bkv_objs = 0;
+	raw_spin_unlock_irqrestore(&krcp->lock, flags);
+
+	llist_for_each_safe(pos, n, page_list) {
+		free_page((unsigned long)pos);
+		freed++;
+	}
+
+	return freed;
+}
+
 /*
  * This function is invoked in workqueue context after a grace period.
  * It frees all the objects queued on ->bhead_free or ->head_free.
@@ -3446,7 +3479,7 @@ schedule_page_work_fn(struct hrtimer *t)
 	struct kfree_rcu_cpu *krcp =
 		container_of(t, struct kfree_rcu_cpu, hrtimer);
 
-	queue_work(system_highpri_wq, &krcp->page_cache_work);
+	queue_delayed_work(system_highpri_wq, &krcp->page_cache_work, 0);
 	return HRTIMER_NORESTART;
 }
 
@@ -3455,12 +3488,16 @@ static void fill_page_cache_func(struct work_struct *work)
 	struct kvfree_rcu_bulk_data *bnode;
 	struct kfree_rcu_cpu *krcp =
 		container_of(work, struct kfree_rcu_cpu,
-			page_cache_work);
+			page_cache_work.work);
 	unsigned long flags;
+	int nr_pages;
 	bool pushed;
 	int i;
 
-	for (i = 0; i < rcu_min_cached_objs; i++) {
+	nr_pages = atomic_read(&krcp->backoff_page_cache_fill) ?
+		1 : rcu_min_cached_objs;
+
+	for (i = 0; i < nr_pages; i++) {
 		bnode = (struct kvfree_rcu_bulk_data *)
 			__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
 
@@ -3477,6 +3514,7 @@ static void fill_page_cache_func(struct work_struct *work)
 	}
 
 	atomic_set(&krcp->work_in_progress, 0);
+	atomic_set(&krcp->backoff_page_cache_fill, 0);
 }
 
 static void
@@ -3484,10 +3522,15 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 {
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
 			!atomic_xchg(&krcp->work_in_progress, 1)) {
-		hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC,
-			HRTIMER_MODE_REL);
-		krcp->hrtimer.function = schedule_page_work_fn;
-		hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
+		if (atomic_read(&krcp->backoff_page_cache_fill)) {
+			queue_delayed_work(system_wq,
+				&krcp->page_cache_work,
+					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
+		} else {
+			hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+			krcp->hrtimer.function = schedule_page_work_fn;
+			hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
+		}
 	}
 }
 
@@ -3639,12 +3682,19 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
 	int cpu;
 	unsigned long count = 0;
+	unsigned long flags;
 
 	/* Snapshot count of all CPUs */
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		count += READ_ONCE(krcp->count);
+
+		raw_spin_lock_irqsave(&krcp->lock, flags);
+		count += krcp->nr_bkv_objs;
+		raw_spin_unlock_irqrestore(&krcp->lock, flags);
+
+		atomic_set(&krcp->backoff_page_cache_fill, 1);
 	}
 
 	return count;
@@ -3661,6 +3711,8 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		count = krcp->count;
+		count += drain_page_cache(krcp);
+
 		raw_spin_lock_irqsave(&krcp->lock, flags);
 		if (krcp->monitor_todo)
 			kfree_rcu_drain_unlock(krcp, flags);
@@ -4687,6 +4739,18 @@ static void __init kfree_rcu_batch_init(void)
 	int cpu;
 	int i;
 
+	/* Clamp it to [0:100] seconds interval. */
+	if (rcu_delay_page_cache_fill_msec < 0 ||
+		rcu_delay_page_cache_fill_msec > 100 * MSEC_PER_SEC) {
+
+		rcu_delay_page_cache_fill_msec =
+			clamp(rcu_delay_page_cache_fill_msec, 0,
+				(int) (100 * MSEC_PER_SEC));
+
+		pr_info("Adjusting rcutree.rcu_delay_page_cache_fill_msec to %d ms.\n",
+			rcu_delay_page_cache_fill_msec);
+	}
+
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
@@ -4696,7 +4760,7 @@ static void __init kfree_rcu_batch_init(void)
 		}
 
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
-		INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
+		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
 		krcp->initialized = true;
 	}
 	if (register_shrinker(&kfree_rcu_shrinker))
