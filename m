Return-Path: <linux-tip-commits+bounces-2420-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C05099F176
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4021C23264
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839F51F9ED7;
	Tue, 15 Oct 2024 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3oo2zO09";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sNWw2EWG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E0C1F76BC;
	Tue, 15 Oct 2024 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006586; cv=none; b=bXXVbEEIZkhBX2FnolostcBgsqU/xnPIcgXvOS5mxgLymb2pU8th3eCt+AzDzhUEPMPPHyLlJI49aMXyHfFaRkn0WE3VSkC9TJL5dTCRign2ffwLIBa5QPR7jMp07bU7Pkb7sl33wD+3TXy8PJxZJ7w81A2qPLI8JqEUoIQh1do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006586; c=relaxed/simple;
	bh=KvBZZXAvJ+IBNJ4PhH7Hyi0bU1GNf6ShVYHQUp0Yv8U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HB7Vw4Wq/erYuqQLq5g66CBlQdbtOuGTQlsHRD2eQmYBSjdJm+1b8wtvGJUiGV+O2Q0rqxY8kqiVMuyu3mdRHWVsID7sakKdUO5QAj/pF8nnz/zBpXI8yk1E+NzPNiFIEjQ4tN7Wyze23+Uv7A3wT9UiDV0OdDF6MG2dwLURXiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3oo2zO09; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sNWw2EWG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:36:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729006582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5C7FtyXGYg1C1ZB13496uk0asqsL4M7Eeo8KsFBUUcM=;
	b=3oo2zO09ZcmUCKC2FwselzuWXq5vbnPkBjhDgdXI2uPq0eBo9kWdEemIIAsJBIH6srJiC6
	TwOSA3GYw5QP7eJzJiTL3toeEBL6tlVIgTt7MHekTDAvNI7TEbZVtTHgtYo6bPa3VZPnQM
	qzfcNaZ44bt4veH8DiVsFtB5C5QkEaiAnLpxYOQnmXNnvY8wr5sIgBwI3hPTBF/t4jxVBk
	fhFU0FN4jTbMkzZlJkt60HfsYiKm7x2Plh/vG56CB2rhA5UvLtA1zDJ8DlOzNwc+MqCcTl
	yroQghUF5mwRtftzyYR54mmZ75KknhccvUf+RORVwxHwgFW2ztuch48uNRoD5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5C7FtyXGYg1C1ZB13496uk0asqsL4M7Eeo8KsFBUUcM=;
	b=sNWw2EWGZ6glwaOeANaOjvQ1rkRKQEyD+mEl4GCKInqoOBq5syesTUhtkQOQX6qrywV7MM
	fn4pIbeDR7UoOrDw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/debugobjects] debugobjects: Move min/max count into pool struct
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Zhen Lei <thunder.leizhen@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007164913.831908427@linutronix.de>
References: <20241007164913.831908427@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900658123.1442.18160204929408712140.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     96a9a0421c77301f9b551f3460ac04471a3c0612
Gitweb:        https://git.kernel.org/tip/96a9a0421c77301f9b551f3460ac04471a3c0612
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 07 Oct 2024 18:50:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:30:32 +02:00

debugobjects: Move min/max count into pool struct

Having the accounting in the datastructure is better in terms of cache
lines and allows more optimizations later on.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
Link: https://lore.kernel.org/all/20241007164913.831908427@linutronix.de

---
 lib/debugobjects.c | 55 +++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 3d1d973..fbe8f26 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -46,9 +46,14 @@ struct debug_bucket {
 struct obj_pool {
 	struct hlist_head	objects;
 	unsigned int		cnt;
+	unsigned int		min_cnt;
+	unsigned int		max_cnt;
 } ____cacheline_aligned;
 
-static DEFINE_PER_CPU(struct obj_pool, pool_pcpu);
+
+static DEFINE_PER_CPU_ALIGNED(struct obj_pool, pool_pcpu)  = {
+	.max_cnt	= ODEBUG_POOL_PERCPU_SIZE,
+};
 
 static struct debug_bucket	obj_hash[ODEBUG_HASH_SIZE];
 
@@ -56,8 +61,14 @@ static struct debug_obj		obj_static_pool[ODEBUG_POOL_SIZE] __initdata;
 
 static DEFINE_RAW_SPINLOCK(pool_lock);
 
-static struct obj_pool		pool_global;
-static struct obj_pool		pool_to_free;
+static struct obj_pool pool_global = {
+	.min_cnt	= ODEBUG_POOL_MIN_LEVEL,
+	.max_cnt	= ODEBUG_POOL_SIZE,
+};
+
+static struct obj_pool pool_to_free = {
+	.max_cnt	= UINT_MAX,
+};
 
 static HLIST_HEAD(pool_boot);
 
@@ -79,13 +90,9 @@ static int __data_racy			debug_objects_fixups __read_mostly;
 static int __data_racy			debug_objects_warnings __read_mostly;
 static bool __data_racy			debug_objects_enabled __read_mostly
 					= CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
-static int				debug_objects_pool_size __ro_after_init
-					= ODEBUG_POOL_SIZE;
-static int				debug_objects_pool_min_level __ro_after_init
-					= ODEBUG_POOL_MIN_LEVEL;
 
-static const struct debug_obj_descr *descr_test  __read_mostly;
-static struct kmem_cache	*obj_cache __ro_after_init;
+static const struct debug_obj_descr	*descr_test  __read_mostly;
+static struct kmem_cache		*obj_cache __ro_after_init;
 
 /*
  * Track numbers of kmem_cache_alloc()/free() calls done.
@@ -124,14 +131,14 @@ static __always_inline unsigned int pool_count(struct obj_pool *pool)
 	return READ_ONCE(pool->cnt);
 }
 
-static inline bool pool_global_should_refill(void)
+static __always_inline bool pool_should_refill(struct obj_pool *pool)
 {
-	return READ_ONCE(pool_global.cnt) < debug_objects_pool_min_level;
+	return pool_count(pool) < pool->min_cnt;
 }
 
-static inline bool pool_global_must_refill(void)
+static __always_inline bool pool_must_refill(struct obj_pool *pool)
 {
-	return READ_ONCE(pool_global.cnt) < (debug_objects_pool_min_level / 2);
+	return pool_count(pool) < pool->min_cnt / 2;
 }
 
 static void free_object_list(struct hlist_head *head)
@@ -178,7 +185,7 @@ static void fill_pool_from_freelist(void)
 	 * Recheck with the lock held as the worker thread might have
 	 * won the race and freed the global free list already.
 	 */
-	while (pool_to_free.cnt && (pool_global.cnt < debug_objects_pool_min_level)) {
+	while (pool_to_free.cnt && (pool_global.cnt < pool_global.min_cnt)) {
 		obj = hlist_entry(pool_to_free.objects.first, typeof(*obj), node);
 		hlist_del(&obj->node);
 		WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt - 1);
@@ -197,11 +204,11 @@ static void fill_pool(void)
 	 *   - One other CPU is already allocating
 	 *   - the global pool has not reached the critical level yet
 	 */
-	if (!pool_global_must_refill() && atomic_read(&cpus_allocating))
+	if (!pool_must_refill(&pool_global) && atomic_read(&cpus_allocating))
 		return;
 
 	atomic_inc(&cpus_allocating);
-	while (pool_global_should_refill()) {
+	while (pool_should_refill(&pool_global)) {
 		struct debug_obj *new, *last = NULL;
 		HLIST_HEAD(head);
 		int cnt;
@@ -337,7 +344,7 @@ static void free_obj_work(struct work_struct *work)
 	if (!raw_spin_trylock_irqsave(&pool_lock, flags))
 		return;
 
-	if (pool_global.cnt >= debug_objects_pool_size)
+	if (pool_global.cnt >= pool_global.max_cnt)
 		goto free_objs;
 
 	/*
@@ -347,7 +354,7 @@ static void free_obj_work(struct work_struct *work)
 	 * may be gearing up to use more and more objects, don't free any
 	 * of them until the next round.
 	 */
-	while (pool_to_free.cnt && pool_global.cnt < debug_objects_pool_size) {
+	while (pool_to_free.cnt && pool_global.cnt < pool_global.max_cnt) {
 		obj = hlist_entry(pool_to_free.objects.first, typeof(*obj), node);
 		hlist_del(&obj->node);
 		hlist_add_head(&obj->node, &pool_global.objects);
@@ -408,7 +415,7 @@ static void __free_object(struct debug_obj *obj)
 	}
 
 	raw_spin_lock(&pool_lock);
-	work = (pool_global.cnt > debug_objects_pool_size) && obj_cache &&
+	work = (pool_global.cnt > pool_global.max_cnt) && obj_cache &&
 	       (pool_to_free.cnt < ODEBUG_FREE_WORK_MAX);
 	obj_pool_used--;
 
@@ -424,7 +431,7 @@ static void __free_object(struct debug_obj *obj)
 			}
 		}
 
-		if ((pool_global.cnt > debug_objects_pool_size) &&
+		if ((pool_global.cnt > pool_global.max_cnt) &&
 		    (pool_to_free.cnt < ODEBUG_FREE_WORK_MAX)) {
 			int i;
 
@@ -629,13 +636,13 @@ static void debug_objects_fill_pool(void)
 	if (unlikely(!obj_cache))
 		return;
 
-	if (likely(!pool_global_should_refill()))
+	if (likely(!pool_should_refill(&pool_global)))
 		return;
 
 	/* Try reusing objects from obj_to_free_list */
 	fill_pool_from_freelist();
 
-	if (likely(!pool_global_should_refill()))
+	if (likely(!pool_should_refill(&pool_global)))
 		return;
 
 	/*
@@ -1427,8 +1434,8 @@ void __init debug_objects_mem_init(void)
 	 * system.
 	 */
 	extras = num_possible_cpus() * ODEBUG_BATCH_SIZE;
-	debug_objects_pool_size += extras;
-	debug_objects_pool_min_level += extras;
+	pool_global.max_cnt += extras;
+	pool_global.min_cnt += extras;
 
 	/* Everything worked. Expose the cache */
 	obj_cache = cache;

