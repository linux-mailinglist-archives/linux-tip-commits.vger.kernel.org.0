Return-Path: <linux-tip-commits+bounces-2423-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B9C99F17C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497A11F26081
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39041FAF10;
	Tue, 15 Oct 2024 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fQC33sAi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nIlOKHo+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF921C4A24;
	Tue, 15 Oct 2024 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006587; cv=none; b=ZH/peCuep+1K/9K9BffvcI1QQBP49hqrpMZM/wM+0XmJ7/izOgn7Gq/IQcaBXNrmim0xw7qUx719rBhwNpyjYEH2hrdKJfVi+CnFDo2AnvD2Wzoj2CLOquRNz/Fnx+UA8ogM1sZhgFmUnk3f6FbV0IlSymQ9pn43AqWJdVo80GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006587; c=relaxed/simple;
	bh=my76A5/3GG3fClCF50ZXlgMu/mIT2honEckNAtaZk94=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sNZ4Qfp/HBNRjOEVHfg2wtcPiih+aXHLdvU9wpe+BdjF2gz/arWgLtFsQVy981qEgFaghlZeDDtA/CoAFokk4lsOGnuVmHCOzBttffDtQASbJiupn6caGZrx9AZmulo2vRgbCNlxmI9xNaGvpdR9+QuS4ilW+goWoBd7LgeXJas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fQC33sAi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nIlOKHo+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:36:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729006584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjB8Tboo0SDuHEldkI7mYBqAnm3ObmVjvpPeFJJ2sKw=;
	b=fQC33sAi8pgyBOxj76MhrBeacT/3wEaFl4YUBz//3DgwTtkoSQ/78Bl3FVYkiUP0w+VMFN
	/DSSBHzFRtVu6zj7UAcN3+MUc9SmfOICAa8o97W2cD0wG4IqqLRUS12fAzQxGoFFBQc0JX
	Qy+CLmeKLqyg6t9xQuTeFQ4FjEEGt3azgRKxoL/iQMsldy4IyIdVxzEp/AhH7PTtdhy50S
	7a+s9JGpjrEtA05QN6PpFxR4HYuHcpCUkUdtMWkxJOaEoX5Jy8FN0SigwJ+TyJYOxIKFx8
	ZzsXJpCiyG623bq8bl1Ghd2yXxBmx8TcJAC0MLvjLRs+XJVusnPnEUyTNqDaEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjB8Tboo0SDuHEldkI7mYBqAnm3ObmVjvpPeFJJ2sKw=;
	b=nIlOKHo+RJnEp3I5jCVMjdrzP/seCrEQwPOrf9If2+Xg8pQuxY7eFr9qSxV+LWnLwlWTf2
	XJZVhumMsQmvRBCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/debugobjects] debugobjects: Move pools into a datastructure
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Zhen Lei <thunder.leizhen@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007164913.646171170@linutronix.de>
References: <20241007164913.646171170@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900658334.1442.12928711712477034934.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     e18328ff705270d1e53889ea9d79dce86d1b8786
Gitweb:        https://git.kernel.org/tip/e18328ff705270d1e53889ea9d79dce86d1b8786
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 07 Oct 2024 18:50:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:30:31 +02:00

debugobjects: Move pools into a datastructure

The contention on the global pool lock can be reduced by strict batch
processing where batches of objects are moved from one list head to another
instead of moving them object by object. This also reduces the cache
footprint because it avoids the list walk and dirties at maximum three
cache lines instead of potentially up to eighteen.

To prepare for that, move the hlist head and related counters into a
struct.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
Link: https://lore.kernel.org/all/20241007164913.646171170@linutronix.de

---
 lib/debugobjects.c | 140 ++++++++++++++++++++++++--------------------
 1 file changed, 78 insertions(+), 62 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 64a72d4..fcba13d 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -52,6 +52,11 @@ struct debug_percpu_free {
 	int			obj_free;
 };
 
+struct obj_pool {
+	struct hlist_head	objects;
+	unsigned int		cnt;
+} ____cacheline_aligned;
+
 static DEFINE_PER_CPU(struct debug_percpu_free, percpu_obj_pool);
 
 static struct debug_bucket	obj_hash[ODEBUG_HASH_SIZE];
@@ -60,8 +65,8 @@ static struct debug_obj		obj_static_pool[ODEBUG_POOL_SIZE] __initdata;
 
 static DEFINE_RAW_SPINLOCK(pool_lock);
 
-static HLIST_HEAD(obj_pool);
-static HLIST_HEAD(obj_to_free);
+static struct obj_pool		pool_global;
+static struct obj_pool		pool_to_free;
 
 /*
  * Because of the presence of percpu free pools, obj_pool_free will
@@ -71,12 +76,9 @@ static HLIST_HEAD(obj_to_free);
  * can be off.
  */
 static int __data_racy		obj_pool_min_free = ODEBUG_POOL_SIZE;
-static int __data_racy		obj_pool_free = ODEBUG_POOL_SIZE;
 static int			obj_pool_used;
 static int __data_racy		obj_pool_max_used;
 static bool			obj_freeing;
-/* The number of objs on the global free list */
-static int			obj_nr_tofree;
 
 static int __data_racy			debug_objects_maxchain __read_mostly;
 static int __data_racy __maybe_unused	debug_objects_maxchecked __read_mostly;
@@ -124,6 +126,21 @@ static const char *obj_states[ODEBUG_STATE_MAX] = {
 	[ODEBUG_STATE_NOTAVAILABLE]	= "not available",
 };
 
+static __always_inline unsigned int pool_count(struct obj_pool *pool)
+{
+	return READ_ONCE(pool->cnt);
+}
+
+static inline bool pool_global_should_refill(void)
+{
+	return READ_ONCE(pool_global.cnt) < debug_objects_pool_min_level;
+}
+
+static inline bool pool_global_must_refill(void)
+{
+	return READ_ONCE(pool_global.cnt) < (debug_objects_pool_min_level / 2);
+}
+
 static void free_object_list(struct hlist_head *head)
 {
 	struct hlist_node *tmp;
@@ -146,11 +163,8 @@ static void fill_pool_from_freelist(void)
 	/*
 	 * Reuse objs from the global obj_to_free list; they will be
 	 * reinitialized when allocating.
-	 *
-	 * obj_nr_tofree is checked locklessly; the READ_ONCE() pairs with
-	 * the WRITE_ONCE() in pool_lock critical sections.
 	 */
-	if (!READ_ONCE(obj_nr_tofree))
+	if (!pool_count(&pool_to_free))
 		return;
 
 	/*
@@ -171,12 +185,12 @@ static void fill_pool_from_freelist(void)
 	 * Recheck with the lock held as the worker thread might have
 	 * won the race and freed the global free list already.
 	 */
-	while (obj_nr_tofree && (obj_pool_free < debug_objects_pool_min_level)) {
-		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
+	while (pool_to_free.cnt && (pool_global.cnt < debug_objects_pool_min_level)) {
+		obj = hlist_entry(pool_to_free.objects.first, typeof(*obj), node);
 		hlist_del(&obj->node);
-		WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
-		hlist_add_head(&obj->node, &obj_pool);
-		WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
+		WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt - 1);
+		hlist_add_head(&obj->node, &pool_global.objects);
+		WRITE_ONCE(pool_global.cnt, pool_global.cnt + 1);
 	}
 	clear_bit(0, &state);
 }
@@ -190,12 +204,11 @@ static void fill_pool(void)
 	 *   - One other CPU is already allocating
 	 *   - the global pool has not reached the critical level yet
 	 */
-	if (READ_ONCE(obj_pool_free) > (debug_objects_pool_min_level / 2) &&
-	    atomic_read(&cpus_allocating))
+	if (!pool_global_must_refill() && atomic_read(&cpus_allocating))
 		return;
 
 	atomic_inc(&cpus_allocating);
-	while (READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
+	while (pool_global_should_refill()) {
 		struct debug_obj *new, *last = NULL;
 		HLIST_HEAD(head);
 		int cnt;
@@ -212,9 +225,9 @@ static void fill_pool(void)
 			break;
 
 		guard(raw_spinlock_irqsave)(&pool_lock);
-		hlist_splice_init(&head, &last->node, &obj_pool);
+		hlist_splice_init(&head, &last->node, &pool_global.objects);
 		debug_objects_allocated += cnt;
-		WRITE_ONCE(obj_pool_free, obj_pool_free + cnt);
+		WRITE_ONCE(pool_global.cnt, pool_global.cnt + cnt);
 	}
 	atomic_dec(&cpus_allocating);
 }
@@ -268,10 +281,10 @@ alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *d
 	}
 
 	raw_spin_lock(&pool_lock);
-	obj = __alloc_object(&obj_pool);
+	obj = __alloc_object(&pool_global.objects);
 	if (obj) {
 		obj_pool_used++;
-		WRITE_ONCE(obj_pool_free, obj_pool_free - 1);
+		WRITE_ONCE(pool_global.cnt, pool_global.cnt - 1);
 
 		/*
 		 * Looking ahead, allocate one batch of debug objects and
@@ -283,22 +296,21 @@ alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *d
 			for (i = 0; i < ODEBUG_BATCH_SIZE; i++) {
 				struct debug_obj *obj2;
 
-				obj2 = __alloc_object(&obj_pool);
+				obj2 = __alloc_object(&pool_global.objects);
 				if (!obj2)
 					break;
-				hlist_add_head(&obj2->node,
-					       &percpu_pool->free_objs);
+				hlist_add_head(&obj2->node, &percpu_pool->free_objs);
 				percpu_pool->obj_free++;
 				obj_pool_used++;
-				WRITE_ONCE(obj_pool_free, obj_pool_free - 1);
+				WRITE_ONCE(pool_global.cnt, pool_global.cnt - 1);
 			}
 		}
 
 		if (obj_pool_used > obj_pool_max_used)
 			obj_pool_max_used = obj_pool_used;
 
-		if (obj_pool_free < obj_pool_min_free)
-			obj_pool_min_free = obj_pool_free;
+		if (pool_global.cnt < obj_pool_min_free)
+			obj_pool_min_free = pool_global.cnt;
 	}
 	raw_spin_unlock(&pool_lock);
 
@@ -329,7 +341,7 @@ static void free_obj_work(struct work_struct *work)
 	if (!raw_spin_trylock_irqsave(&pool_lock, flags))
 		return;
 
-	if (obj_pool_free >= debug_objects_pool_size)
+	if (pool_global.cnt >= debug_objects_pool_size)
 		goto free_objs;
 
 	/*
@@ -339,12 +351,12 @@ static void free_obj_work(struct work_struct *work)
 	 * may be gearing up to use more and more objects, don't free any
 	 * of them until the next round.
 	 */
-	while (obj_nr_tofree && obj_pool_free < debug_objects_pool_size) {
-		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
+	while (pool_to_free.cnt && pool_global.cnt < debug_objects_pool_size) {
+		obj = hlist_entry(pool_to_free.objects.first, typeof(*obj), node);
 		hlist_del(&obj->node);
-		hlist_add_head(&obj->node, &obj_pool);
-		WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
-		WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
+		hlist_add_head(&obj->node, &pool_global.objects);
+		WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt - 1);
+		WRITE_ONCE(pool_global.cnt, pool_global.cnt + 1);
 	}
 	raw_spin_unlock_irqrestore(&pool_lock, flags);
 	return;
@@ -355,9 +367,9 @@ free_objs:
 	 * list. Move remaining free objs to a temporary list to free the
 	 * memory outside the pool_lock held region.
 	 */
-	if (obj_nr_tofree) {
-		hlist_move_list(&obj_to_free, &tofree);
-		WRITE_ONCE(obj_nr_tofree, 0);
+	if (pool_to_free.cnt) {
+		hlist_move_list(&pool_to_free.objects, &tofree);
+		WRITE_ONCE(pool_to_free.cnt, 0);
 	}
 	raw_spin_unlock_irqrestore(&pool_lock, flags);
 
@@ -400,45 +412,45 @@ static void __free_object(struct debug_obj *obj)
 
 free_to_obj_pool:
 	raw_spin_lock(&pool_lock);
-	work = (obj_pool_free > debug_objects_pool_size) && obj_cache &&
-	       (obj_nr_tofree < ODEBUG_FREE_WORK_MAX);
+	work = (pool_global.cnt > debug_objects_pool_size) && obj_cache &&
+	       (pool_to_free.cnt < ODEBUG_FREE_WORK_MAX);
 	obj_pool_used--;
 
 	if (work) {
-		WRITE_ONCE(obj_nr_tofree, obj_nr_tofree + 1);
-		hlist_add_head(&obj->node, &obj_to_free);
+		WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt + 1);
+		hlist_add_head(&obj->node, &pool_to_free.objects);
 		if (lookahead_count) {
-			WRITE_ONCE(obj_nr_tofree, obj_nr_tofree + lookahead_count);
+			WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt + lookahead_count);
 			obj_pool_used -= lookahead_count;
 			while (lookahead_count) {
 				hlist_add_head(&objs[--lookahead_count]->node,
-					       &obj_to_free);
+					       &pool_to_free.objects);
 			}
 		}
 
-		if ((obj_pool_free > debug_objects_pool_size) &&
-		    (obj_nr_tofree < ODEBUG_FREE_WORK_MAX)) {
+		if ((pool_global.cnt > debug_objects_pool_size) &&
+		    (pool_to_free.cnt < ODEBUG_FREE_WORK_MAX)) {
 			int i;
 
 			/*
 			 * Free one more batch of objects from obj_pool.
 			 */
 			for (i = 0; i < ODEBUG_BATCH_SIZE; i++) {
-				obj = __alloc_object(&obj_pool);
-				hlist_add_head(&obj->node, &obj_to_free);
-				WRITE_ONCE(obj_pool_free, obj_pool_free - 1);
-				WRITE_ONCE(obj_nr_tofree, obj_nr_tofree + 1);
+				obj = __alloc_object(&pool_global.objects);
+				hlist_add_head(&obj->node, &pool_to_free.objects);
+				WRITE_ONCE(pool_global.cnt, pool_global.cnt - 1);
+				WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt + 1);
 			}
 		}
 	} else {
-		WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
-		hlist_add_head(&obj->node, &obj_pool);
+		WRITE_ONCE(pool_global.cnt, pool_global.cnt + 1);
+		hlist_add_head(&obj->node, &pool_global.objects);
 		if (lookahead_count) {
-			WRITE_ONCE(obj_pool_free, obj_pool_free + lookahead_count);
+			WRITE_ONCE(pool_global.cnt, pool_global.cnt + lookahead_count);
 			obj_pool_used -= lookahead_count;
 			while (lookahead_count) {
 				hlist_add_head(&objs[--lookahead_count]->node,
-					       &obj_pool);
+					       &pool_global.objects);
 			}
 		}
 	}
@@ -453,7 +465,7 @@ free_to_obj_pool:
 static void free_object(struct debug_obj *obj)
 {
 	__free_object(obj);
-	if (!READ_ONCE(obj_freeing) && READ_ONCE(obj_nr_tofree)) {
+	if (!READ_ONCE(obj_freeing) && pool_count(&pool_to_free)) {
 		WRITE_ONCE(obj_freeing, true);
 		schedule_delayed_work(&debug_obj_work, ODEBUG_FREE_WORK_DELAY);
 	}
@@ -622,13 +634,13 @@ static void debug_objects_fill_pool(void)
 	if (unlikely(!obj_cache))
 		return;
 
-	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
+	if (likely(!pool_global_should_refill()))
 		return;
 
 	/* Try reusing objects from obj_to_free_list */
 	fill_pool_from_freelist();
 
-	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
+	if (likely(!pool_global_should_refill()))
 		return;
 
 	/*
@@ -1040,7 +1052,7 @@ repeat:
 		debug_objects_maxchecked = objs_checked;
 
 	/* Schedule work to actually kmem_cache_free() objects */
-	if (!READ_ONCE(obj_freeing) && READ_ONCE(obj_nr_tofree)) {
+	if (!READ_ONCE(obj_freeing) && pool_count(&pool_to_free)) {
 		WRITE_ONCE(obj_freeing, true);
 		schedule_delayed_work(&debug_obj_work, ODEBUG_FREE_WORK_DELAY);
 	}
@@ -1066,12 +1078,12 @@ static int debug_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, "max_checked   :%d\n", debug_objects_maxchecked);
 	seq_printf(m, "warnings      :%d\n", debug_objects_warnings);
 	seq_printf(m, "fixups        :%d\n", debug_objects_fixups);
-	seq_printf(m, "pool_free     :%d\n", READ_ONCE(obj_pool_free) + obj_percpu_free);
+	seq_printf(m, "pool_free     :%d\n", pool_count(&pool_global) + obj_percpu_free);
 	seq_printf(m, "pool_pcp_free :%d\n", obj_percpu_free);
 	seq_printf(m, "pool_min_free :%d\n", obj_pool_min_free);
 	seq_printf(m, "pool_used     :%d\n", obj_pool_used - obj_percpu_free);
 	seq_printf(m, "pool_max_used :%d\n", obj_pool_max_used);
-	seq_printf(m, "on_free_list  :%d\n", READ_ONCE(obj_nr_tofree));
+	seq_printf(m, "on_free_list  :%d\n", pool_count(&pool_to_free));
 	seq_printf(m, "objs_allocated:%d\n", debug_objects_allocated);
 	seq_printf(m, "objs_freed    :%d\n", debug_objects_freed);
 	return 0;
@@ -1330,7 +1342,9 @@ void __init debug_objects_early_init(void)
 		raw_spin_lock_init(&obj_hash[i].lock);
 
 	for (i = 0; i < ODEBUG_POOL_SIZE; i++)
-		hlist_add_head(&obj_static_pool[i].node, &obj_pool);
+		hlist_add_head(&obj_static_pool[i].node, &pool_global.objects);
+
+	pool_global.cnt = ODEBUG_POOL_SIZE;
 }
 
 /*
@@ -1354,21 +1368,23 @@ static bool __init debug_objects_replace_static_objects(struct kmem_cache *cache
 		hlist_add_head(&obj->node, &objects);
 	}
 
-	debug_objects_allocated += i;
+	debug_objects_allocated = ODEBUG_POOL_SIZE;
+	pool_global.cnt = ODEBUG_POOL_SIZE;
 
 	/*
 	 * Replace the statically allocated objects list with the allocated
 	 * objects list.
 	 */
-	hlist_move_list(&objects, &obj_pool);
+	hlist_move_list(&objects, &pool_global.objects);
 
 	/* Replace the active object references */
 	for (i = 0; i < ODEBUG_HASH_SIZE; i++, db++) {
 		hlist_move_list(&db->list, &objects);
 
 		hlist_for_each_entry(obj, &objects, node) {
-			new = hlist_entry(obj_pool.first, typeof(*obj), node);
+			new = hlist_entry(pool_global.objects.first, typeof(*obj), node);
 			hlist_del(&new->node);
+			pool_global.cnt--;
 			/* copy object data */
 			*new = *obj;
 			hlist_add_head(&new->node, &db->list);

