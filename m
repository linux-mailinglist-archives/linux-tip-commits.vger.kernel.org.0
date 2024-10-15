Return-Path: <linux-tip-commits+bounces-2417-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C078C99F16E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C362822D6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86281F76A4;
	Tue, 15 Oct 2024 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="apTZskcn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DwJwK5VL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C274F1F4FC2;
	Tue, 15 Oct 2024 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006583; cv=none; b=TGUwv3HnVDD7sKXwHOc5ZYusN8L6yBpzFzdH7DVoLToTlqzEovKNhwpByN592hXq8lKz4wHMxg/A2YNblpuw2X8z8pgLfqtQz831bWNOpmUza0trD80RjhEM/QM3pEBRuWIg4tM6f6dq/KboS0N0OfwazK+DHqovLCNGpqr5AUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006583; c=relaxed/simple;
	bh=Bm/nOi3K6qU3dDGFVwIQMvvVqi9vAK4dn8MOfxOwSw4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PnGt3hNqJ0rxwSgW+kZ8XAnBCDpchvphJZEnIRyfHMMNWLv18EFAXWgJtuOkTEslTvDAhgy2wcrD8+Ynhab4a8ficLxHQ+BStDprVPZoxgZcZ1LXJxFGwKE9QbJkmDCbEdtYW05K7udUFfUPL2+zeIClFvXYTPwL3/HPCL9iyTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=apTZskcn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DwJwK5VL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:36:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729006580;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5XxRSRdDKo30wi5wB5/T6ZFVXlAxAhSIAq8D52r62c=;
	b=apTZskcnefEzeNqfuTp91sapkCBlXz5GfkzudON16K3BJ7Vgbhb3ZsoC5EODN3Z4c5eNro
	Yy0Yro6sJVUxVuXJX+u+sqCrlBmxvnYeevltAe0LgHtnHIjj3s0HacUXhx+9NOUT/gTmPB
	Rw3ihQzCwtC2/IB3X79g7BAZD38Tw+2/zuoABYcpPKVoBq5urrsUuTTgn48CRKsqpz1xsf
	1tzJjYAm0ozs1WqZ6Eb0yI+6u7DkS7+wbiD3pPv01ei8JQ3OnsFvf0z9Af5/bkYzG4k9IS
	qlxSNM2/wGq0pmVNS84DX8rsqw7N3jL7xuJ2uyaYy3MBMhp97DuhTZH4CUGvQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006580;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5XxRSRdDKo30wi5wB5/T6ZFVXlAxAhSIAq8D52r62c=;
	b=DwJwK5VLqHFgYvzJh5IbUHEfFWy5OZWFJ6uC1SLfil2A1DUW6kgge0j5o5B4ukeK1b8c/5
	7jGwhzTyYjEc46Dw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Rework free_object_work()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Zhen Lei <thunder.leizhen@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007164914.015906394@linutronix.de>
References: <20241007164914.015906394@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900657949.1442.6232514176387919418.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     9ce99c6d7bfbca71f1e5fa34045ea48cb768f54a
Gitweb:        https://git.kernel.org/tip/9ce99c6d7bfbca71f1e5fa34045ea48cb768f54a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 07 Oct 2024 18:50:12 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:30:32 +02:00

debugobjects: Rework free_object_work()

Convert it to batch processing with intermediate helper functions. This
reduces the final changes for batch processing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
Link: https://lore.kernel.org/all/20241007164914.015906394@linutronix.de

---
 lib/debugobjects.c | 82 +++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 43 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 3700ddf..d5a8538 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -35,7 +35,7 @@
  * frequency of 10Hz and about 1024 objects for each freeing operation.
  * So it is freeing at most 10k debug objects per second.
  */
-#define ODEBUG_FREE_WORK_MAX	1024
+#define ODEBUG_FREE_WORK_MAX	(1024 / ODEBUG_BATCH_SIZE)
 #define ODEBUG_FREE_WORK_DELAY	DIV_ROUND_UP(HZ, 10)
 
 struct debug_bucket {
@@ -158,6 +158,21 @@ static bool pool_move_batch(struct obj_pool *dst, struct obj_pool *src)
 	return true;
 }
 
+static bool pool_pop_batch(struct hlist_head *head, struct obj_pool *src)
+{
+	if (!src->cnt)
+		return false;
+
+	for (int i = 0; src->cnt && i < ODEBUG_BATCH_SIZE; i++) {
+		struct hlist_node *node = src->objects.first;
+
+		WRITE_ONCE(src->cnt, src->cnt - 1);
+		hlist_del(node);
+		hlist_add_head(node, head);
+	}
+	return true;
+}
+
 static struct debug_obj *__alloc_object(struct hlist_head *list)
 {
 	struct debug_obj *obj;
@@ -343,55 +358,36 @@ static struct debug_obj *alloc_object(void *addr, struct debug_bucket *b,
 	return obj;
 }
 
-/*
- * workqueue function to free objects.
- *
- * To reduce contention on the global pool_lock, the actual freeing of
- * debug objects will be delayed if the pool_lock is busy.
- */
+/* workqueue function to free objects. */
 static void free_obj_work(struct work_struct *work)
 {
-	struct debug_obj *obj;
-	unsigned long flags;
-	HLIST_HEAD(tofree);
+	bool free = true;
 
 	WRITE_ONCE(obj_freeing, false);
-	if (!raw_spin_trylock_irqsave(&pool_lock, flags))
-		return;
 
-	if (pool_global.cnt >= pool_global.max_cnt)
-		goto free_objs;
-
-	/*
-	 * The objs on the pool list might be allocated before the work is
-	 * run, so recheck if pool list it full or not, if not fill pool
-	 * list from the global free list. As it is likely that a workload
-	 * may be gearing up to use more and more objects, don't free any
-	 * of them until the next round.
-	 */
-	while (pool_to_free.cnt && pool_global.cnt < pool_global.max_cnt) {
-		obj = hlist_entry(pool_to_free.objects.first, typeof(*obj), node);
-		hlist_del(&obj->node);
-		hlist_add_head(&obj->node, &pool_global.objects);
-		WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt - 1);
-		WRITE_ONCE(pool_global.cnt, pool_global.cnt + 1);
-	}
-	raw_spin_unlock_irqrestore(&pool_lock, flags);
-	return;
+	if (!pool_count(&pool_to_free))
+		return;
 
-free_objs:
-	/*
-	 * Pool list is already full and there are still objs on the free
-	 * list. Move remaining free objs to a temporary list to free the
-	 * memory outside the pool_lock held region.
-	 */
-	if (pool_to_free.cnt) {
-		hlist_move_list(&pool_to_free.objects, &tofree);
-		WRITE_ONCE(pool_to_free.cnt, 0);
+	for (unsigned int cnt = 0; cnt < ODEBUG_FREE_WORK_MAX; cnt++) {
+		HLIST_HEAD(tofree);
+
+		/* Acquire and drop the lock for each batch */
+		scoped_guard(raw_spinlock_irqsave, &pool_lock) {
+			if (!pool_to_free.cnt)
+				return;
+
+			/* Refill the global pool if possible */
+			if (pool_move_batch(&pool_global, &pool_to_free)) {
+				/* Don't free as there seems to be demand */
+				free = false;
+			} else if (free) {
+				pool_pop_batch(&tofree, &pool_to_free);
+			} else {
+				return;
+			}
+		}
+		free_object_list(&tofree);
 	}
-	raw_spin_unlock_irqrestore(&pool_lock, flags);
-
-	free_object_list(&tofree);
 }
 
 static void __free_object(struct debug_obj *obj)

