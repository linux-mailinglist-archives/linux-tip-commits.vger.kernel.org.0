Return-Path: <linux-tip-commits+bounces-2415-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E2799F16C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4ED28216D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F811F6697;
	Tue, 15 Oct 2024 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tUt6FaJP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="weUPZRZ7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB8E1DD0F2;
	Tue, 15 Oct 2024 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006583; cv=none; b=BF4zxYAzZNOVqk2i/ExPnuI06Pa9eaidpoXwYwYwrrkM25Wy78HYQ+JUkAJMtvf2pN/rv3sQH6yL2Vbt5CMQxAClEUeVqgKxCXY0Uu/7gGGgPnk3Dk+34EmfP92PGnjIAHFwyJYmTkUzsyGr8wQt1KDAuJJeGeJtaCC84rmY7sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006583; c=relaxed/simple;
	bh=y8NW0/ODy/M2xS0n7MxRoL0eNcRBohP5O74/G8tdK8I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sMpJM/oxLFZHyQiVTgQlpWDvgQey3NrlK0vPCDCzrmt3ApjIhPBjiLyUZ40yRWoPTwpXELihU5pWywUE8cfs/vnlL36/jqHtsGwN3e0P4A3kUZXFjf2z8XEFghxgstDFRH4UjWcwp66+/nsKYF2LaQGmObTrCuRUJ9U/wKMOm+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tUt6FaJP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=weUPZRZ7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:36:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729006578;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3WApvTTVeHgql4F2NeZsocgsLy8BoFHUkdV6/5J6F5s=;
	b=tUt6FaJP9Rt05jVlVLvfWoMBH9Lh6dBofhVbBv38NzN11gK2qWJB8/ntWXq+HqT2wkzJP9
	0Y/ve9ie23881PH0xs9cJmHmdLcLU8eKlIjfKf1e6HsjqEndcRdPzXN9vb6nhEmjAjCppW
	DEYPFy7QoZHKMA5w39UU6WEqXJzY0ixW6Qm/gjNGGUme8sgGYpIo4BKo5ZQ4QXW+SvbjfD
	YDxFWuAdAagC/6czQOrKcyicciq4uMKGIGUS9VoBEEL0ODSuBzwsB8ZQT8VCjIMYgKAm0B
	H/JSDuiZGnjEHwycgfmaiOnztXDgwuF0N1rzK53XTNUfKEs/SiN8kV5PvgY58w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006578;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3WApvTTVeHgql4F2NeZsocgsLy8BoFHUkdV6/5J6F5s=;
	b=weUPZRZ7rQmpndO/C6JRuK6wpxtqnGKT2SkJ4rsWXKFhIs4U8gY3kBLVBodlgECthN9bkt
	Jbk34htUJPnxUpDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Prepare kmem_cache allocations
 for batching
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007164914.198647184@linutronix.de>
References: <20241007164914.198647184@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900657776.1442.15684540069417364601.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     aebbfe0779b271c099cc80c5e2995c2087b28dcf
Gitweb:        https://git.kernel.org/tip/aebbfe0779b271c099cc80c5e2995c2087b28dcf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 07 Oct 2024 18:50:15 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:30:32 +02:00

debugobjects: Prepare kmem_cache allocations for batching

Allocate a batch and then push it into the pool. Utilize the
debug_obj::last_node pointer for keeping track of the batch boundary.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241007164914.198647184@linutronix.de

---
 lib/debugobjects.c | 80 +++++++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 31 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 2fed7b8..cdd5d23 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -164,6 +164,22 @@ static bool pool_move_batch(struct obj_pool *dst, struct obj_pool *src)
 	return true;
 }
 
+static bool pool_push_batch(struct obj_pool *dst, struct hlist_head *head)
+{
+	struct hlist_node *last;
+	struct debug_obj *obj;
+
+	if (dst->cnt >= dst->max_cnt)
+		return false;
+
+	obj = hlist_entry(head->first, typeof(*obj), node);
+	last = obj->batch_last;
+
+	hlist_splice_init(head, last, &dst->objects);
+	WRITE_ONCE(dst->cnt, dst->cnt + ODEBUG_BATCH_SIZE);
+	return true;
+}
+
 static bool pool_pop_batch(struct hlist_head *head, struct obj_pool *src)
 {
 	if (!src->cnt)
@@ -288,6 +304,28 @@ static void fill_pool_from_freelist(void)
 	clear_bit(0, &state);
 }
 
+static bool kmem_alloc_batch(struct hlist_head *head, struct kmem_cache *cache, gfp_t gfp)
+{
+	struct hlist_node *last = NULL;
+	struct debug_obj *obj;
+
+	for (int cnt = 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
+		obj = kmem_cache_zalloc(cache, gfp);
+		if (!obj) {
+			free_object_list(head);
+			return false;
+		}
+		debug_objects_allocated++;
+
+		if (!last)
+			last = &obj->node;
+		obj->batch_last = last;
+
+		hlist_add_head(&obj->node, head);
+	}
+	return true;
+}
+
 static void fill_pool(void)
 {
 	static atomic_t cpus_allocating;
@@ -302,25 +340,14 @@ static void fill_pool(void)
 
 	atomic_inc(&cpus_allocating);
 	while (pool_should_refill(&pool_global)) {
-		struct debug_obj *new, *last = NULL;
 		HLIST_HEAD(head);
-		int cnt;
 
-		for (cnt = 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
-			new = kmem_cache_zalloc(obj_cache, __GFP_HIGH | __GFP_NOWARN);
-			if (!new)
-				break;
-			hlist_add_head(&new->node, &head);
-			if (!last)
-				last = new;
-		}
-		if (!cnt)
+		if (!kmem_alloc_batch(&head, obj_cache, __GFP_HIGH | __GFP_NOWARN))
 			break;
 
 		guard(raw_spinlock_irqsave)(&pool_lock);
-		hlist_splice_init(&head, &last->node, &pool_global.objects);
-		debug_objects_allocated += cnt;
-		WRITE_ONCE(pool_global.cnt, pool_global.cnt + cnt);
+		if (!pool_push_batch(&pool_global, &head))
+			pool_push_batch(&pool_to_free, &head);
 	}
 	atomic_dec(&cpus_allocating);
 }
@@ -1302,26 +1329,18 @@ void __init debug_objects_early_init(void)
 static bool __init debug_objects_replace_static_objects(struct kmem_cache *cache)
 {
 	struct debug_bucket *db = obj_hash;
-	struct debug_obj *obj, *new;
 	struct hlist_node *tmp;
+	struct debug_obj *obj;
 	HLIST_HEAD(objects);
 	int i;
 
-	for (i = 0; i < ODEBUG_POOL_SIZE; i++) {
-		obj = kmem_cache_zalloc(cache, GFP_KERNEL);
-		if (!obj)
+	for (i = 0; i < ODEBUG_POOL_SIZE; i += ODEBUG_BATCH_SIZE) {
+		if (!kmem_alloc_batch(&objects, cache, GFP_KERNEL))
 			goto free;
-		hlist_add_head(&obj->node, &objects);
+		pool_push_batch(&pool_global, &objects);
 	}
 
-	debug_objects_allocated = ODEBUG_POOL_SIZE;
-	pool_global.cnt = ODEBUG_POOL_SIZE;
-
-	/*
-	 * Move the allocated objects to the global pool and disconnect the
-	 * boot pool.
-	 */
-	hlist_move_list(&objects, &pool_global.objects);
+	/* Disconnect the boot pool. */
 	pool_boot.first = NULL;
 
 	/* Replace the active object references */
@@ -1329,9 +1348,8 @@ static bool __init debug_objects_replace_static_objects(struct kmem_cache *cache
 		hlist_move_list(&db->list, &objects);
 
 		hlist_for_each_entry(obj, &objects, node) {
-			new = hlist_entry(pool_global.objects.first, typeof(*obj), node);
-			hlist_del(&new->node);
-			pool_global.cnt--;
+			struct debug_obj *new = pcpu_alloc();
+
 			/* copy object data */
 			*new = *obj;
 			hlist_add_head(&new->node, &db->list);
@@ -1340,7 +1358,7 @@ static bool __init debug_objects_replace_static_objects(struct kmem_cache *cache
 	return true;
 free:
 	/* Can't use free_object_list() as the cache is not populated yet */
-	hlist_for_each_entry_safe(obj, tmp, &objects, node) {
+	hlist_for_each_entry_safe(obj, tmp, &pool_global.objects, node) {
 		hlist_del(&obj->node);
 		kmem_cache_free(cache, obj);
 	}

