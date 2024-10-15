Return-Path: <linux-tip-commits+bounces-2424-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE95299F17D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B870B21FA4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C521FAF1F;
	Tue, 15 Oct 2024 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LZoTTsNg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q6kuzpPx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CAA1F9EC4;
	Tue, 15 Oct 2024 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006588; cv=none; b=I7y3YHFByHlcsOwURW0+Ooh7bfLq8X6QvpxyA4rIDpIlEXGgytcoGzu+t2FrsihRdZkjwsQOTr5O9q1cXHtoQk6YdEuFsZYy4j3rAixpGuiSg1FBP1lDwpRNKA3QitB7nOpjaU/HZL5nrjG50BIWCR/Z46/t36QE8cjOaIsVXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006588; c=relaxed/simple;
	bh=vQWBXnrl0Yb0Yhu/20TUoigwWCyUXAzSeIvLWIYjWxA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fTJTEbwHVsjlxzdC66DjXEIjT1GPSZSuVzBE1dip0dYIU4IunNZWcYzvqZ/zSWwjIexH/wYnXs2VMzoJij+/3dwaxfcsyBUS4MHL9l31QqPeDD8FL67IPacH13KjaNMY0td9U6iuXyBvDw5c42SQcTteNrM8wrYBTkMOmIexT6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LZoTTsNg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q6kuzpPx; arc=none smtp.client-ip=193.142.43.55
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
	bh=z5v3lyzIFrMGg4BoiY7vYqY1cTz0umuiQt5qVrOXcfU=;
	b=LZoTTsNgc4H8F+N23RavuguqBXZFMOP96GYdeX6KcgjlsJ7JE07cSVM15MQ2KwMU3+vZhx
	Au4fYaK79OkkjFBcMD7CNoEbca8BRlYICF2xQiQU4kmvcSMFSKtEzwXpwzdjfvUqow/WhK
	TQVWiwoc31M0YIPDa+2dHpWB+0DobXQUCAVuHvd4WpK+ssIQYMTCgSUfcwuNT+yzgPMhl4
	RLCzV909BqmUn9E5GTGEuh6EdwXFcOzXA0O5rMxd8sn8+SHYjI/7R6HT4ORrl0RXXXUmBP
	ZyVtW1vaG3A3ZCXELz3D/4fqKtJG4LsUNTvkmIse6jkigEjtqNcc/zLHyA5jWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z5v3lyzIFrMGg4BoiY7vYqY1cTz0umuiQt5qVrOXcfU=;
	b=Q6kuzpPx92XSh3Kartgr+oAUVmYfB6pbAFY0eVWh8iIRA5xKWnMo2BYfTuXy5hJm8A0r+S
	Dw8IuGXSlfjBCHCw==
From: "tip-bot2 for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/debugobjects] debugobjects: Reduce parallel pool fill attempts
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Zhen Lei <thunder.leizhen@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240911083521.2257-4-thunder.leizhen@huawei.com->
References: <20240911083521.2257-4-thunder.leizhen@huawei.com->
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900658393.1442.10481214578253137724.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     d8c6cd3a5c8008f5d42c7763a93b43d7f3a40e94
Gitweb:        https://git.kernel.org/tip/d8c6cd3a5c8008f5d42c7763a93b43d7f3a40e94
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Mon, 07 Oct 2024 18:50:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:30:31 +02:00

debugobjects: Reduce parallel pool fill attempts

The contention on the global pool_lock can be massive when the global pool
needs to be refilled and many CPUs try to handle this.

Address this by:

  - splitting the refill from free list and allocation.

    Refill from free list has no constraints vs. the context on RT, so
    it can be tried outside of the RT specific preemptible() guard

  - Let only one CPU handle the free list

  - Let only one CPU do allocations unless the pool level is below
    half of the minimum fill level.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240911083521.2257-4-thunder.leizhen@huawei.com-
Link: https://lore.kernel.org/all/20241007164913.582118421@linutronix.de

--
 lib/debugobjects.c |   84 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 59 insertions(+), 25 deletions(-)

---
 lib/debugobjects.c | 84 +++++++++++++++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 25 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 0d69095..64a72d4 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -138,14 +138,10 @@ static void free_object_list(struct hlist_head *head)
 	debug_objects_freed += cnt;
 }
 
-static void fill_pool(void)
+static void fill_pool_from_freelist(void)
 {
-	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;
+	static unsigned long state;
 	struct debug_obj *obj;
-	unsigned long flags;
-
-	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
-		return;
 
 	/*
 	 * Reuse objs from the global obj_to_free list; they will be
@@ -154,32 +150,58 @@ static void fill_pool(void)
 	 * obj_nr_tofree is checked locklessly; the READ_ONCE() pairs with
 	 * the WRITE_ONCE() in pool_lock critical sections.
 	 */
-	if (READ_ONCE(obj_nr_tofree)) {
-		raw_spin_lock_irqsave(&pool_lock, flags);
-		/*
-		 * Recheck with the lock held as the worker thread might have
-		 * won the race and freed the global free list already.
-		 */
-		while (obj_nr_tofree && (obj_pool_free < debug_objects_pool_min_level)) {
-			obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
-			hlist_del(&obj->node);
-			WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
-			hlist_add_head(&obj->node, &obj_pool);
-			WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
-		}
-		raw_spin_unlock_irqrestore(&pool_lock, flags);
+	if (!READ_ONCE(obj_nr_tofree))
+		return;
+
+	/*
+	 * Prevent the context from being scheduled or interrupted after
+	 * setting the state flag;
+	 */
+	guard(irqsave)();
+
+	/*
+	 * Avoid lock contention on &pool_lock and avoid making the cache
+	 * line exclusive by testing the bit before attempting to set it.
+	 */
+	if (test_bit(0, &state) || test_and_set_bit(0, &state))
+		return;
+
+	guard(raw_spinlock)(&pool_lock);
+	/*
+	 * Recheck with the lock held as the worker thread might have
+	 * won the race and freed the global free list already.
+	 */
+	while (obj_nr_tofree && (obj_pool_free < debug_objects_pool_min_level)) {
+		obj = hlist_entry(obj_to_free.first, typeof(*obj), node);
+		hlist_del(&obj->node);
+		WRITE_ONCE(obj_nr_tofree, obj_nr_tofree - 1);
+		hlist_add_head(&obj->node, &obj_pool);
+		WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
 	}
+	clear_bit(0, &state);
+}
 
-	if (unlikely(!obj_cache))
+static void fill_pool(void)
+{
+	static atomic_t cpus_allocating;
+
+	/*
+	 * Avoid allocation and lock contention when:
+	 *   - One other CPU is already allocating
+	 *   - the global pool has not reached the critical level yet
+	 */
+	if (READ_ONCE(obj_pool_free) > (debug_objects_pool_min_level / 2) &&
+	    atomic_read(&cpus_allocating))
 		return;
 
+	atomic_inc(&cpus_allocating);
 	while (READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
 		struct debug_obj *new, *last = NULL;
 		HLIST_HEAD(head);
 		int cnt;
 
 		for (cnt = 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
-			new = kmem_cache_zalloc(obj_cache, gfp);
+			new = kmem_cache_zalloc(obj_cache, __GFP_HIGH | __GFP_NOWARN);
 			if (!new)
 				break;
 			hlist_add_head(&new->node, &head);
@@ -187,14 +209,14 @@ static void fill_pool(void)
 				last = new;
 		}
 		if (!cnt)
-			return;
+			break;
 
-		raw_spin_lock_irqsave(&pool_lock, flags);
+		guard(raw_spinlock_irqsave)(&pool_lock);
 		hlist_splice_init(&head, &last->node, &obj_pool);
 		debug_objects_allocated += cnt;
 		WRITE_ONCE(obj_pool_free, obj_pool_free + cnt);
-		raw_spin_unlock_irqrestore(&pool_lock, flags);
 	}
+	atomic_dec(&cpus_allocating);
 }
 
 /*
@@ -597,6 +619,18 @@ static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket 
 
 static void debug_objects_fill_pool(void)
 {
+	if (unlikely(!obj_cache))
+		return;
+
+	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
+		return;
+
+	/* Try reusing objects from obj_to_free_list */
+	fill_pool_from_freelist();
+
+	if (likely(READ_ONCE(obj_pool_free) >= debug_objects_pool_min_level))
+		return;
+
 	/*
 	 * On RT enabled kernels the pool refill must happen in preemptible
 	 * context -- for !RT kernels we rely on the fact that spinlock_t and

