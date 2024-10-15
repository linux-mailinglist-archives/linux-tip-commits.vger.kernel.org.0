Return-Path: <linux-tip-commits+bounces-2419-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 809CC99F173
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8EA7B20BC3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053B61F8EF2;
	Tue, 15 Oct 2024 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SgSSLIET";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zmFHNiyR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C121F668D;
	Tue, 15 Oct 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006584; cv=none; b=cs3YR3KOrHhThsNph1xsp0n8TasQ6OJyUuaUAuKEbcTn9qRXGeko4hLP+JYBf0QsuQV/5LZ9mVWvz8HF73nZDj9Jp8IyTDwjKMwqjccHQ5XvjsONdJuMWKs+c0bTGe7tCS5IEZrY+KZ02OltdInejPyqfluazsg7VdkOLk99s5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006584; c=relaxed/simple;
	bh=Z7zZSrpwilY0mi9NDP/UPCdi7aFTuWfg6R93LxGYYYM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aw0x5Rnge+y6HcdzTJD+cP2dCjabLS0Sw6dAx1gJxRLWbQ5WTP1wuU2FzLq8F1LRKTwKzq7RP5opevWiF+XRsSArD1mxQceZ8HrCLpf2K4M9gyvO7L1iyuuzKw8J5BwpTwudxo6oIRkhrf7eNeBoMBMza+k9uY7BwhzF1PCD1Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SgSSLIET; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zmFHNiyR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:36:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729006581;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gFN8T5A1OtpYg7KztQyISBa7C11ZziCXtZoLJ1/KKHE=;
	b=SgSSLIETuT8+ivHwOK0Y3EeECiSUgdfvSP1oOHsP08fY2zjtWDd7N+DE3luCUEpqZ3KHko
	6NA7gwOTcOY3Kqtofsnw4OopTEQuoaAbdGi44QjY8gtBohgzUnVmYLXTNABhuFxXerFS4l
	uK2KSHR50KjSEEtDl920i30bo6Z8Zjgqdd333BuW6d+MHBGPcty42ny9N7OlNbBRKJEN03
	0HiwgjuxzvYsquKLHXOrIKhOtXCX0BiaXGGazIK/BdS/fFiWK5krRRcb7gFWt2rlxXrw7l
	QL2MGM2QdViKTxWOMd5SHYMEc+egUbvnvzg5lVe+vN7TSRlsjZAzfP6lnvAiOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006581;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gFN8T5A1OtpYg7KztQyISBa7C11ZziCXtZoLJ1/KKHE=;
	b=zmFHNiyRYKmFpYzJD3aYehqC8U4wX/5o/CES3Mj5iy/1jbPo5uZ/nSpe9iamiBVl9oKsXq
	ggHmOx9jxWnfRzCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Rework object allocation
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Zhen Lei <thunder.leizhen@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007164913.893554162@linutronix.de>
References: <20241007164913.893554162@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900658067.1442.14275163998080752417.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     fb60c004f33e0fa2e87b9456b87f1b2709436b88
Gitweb:        https://git.kernel.org/tip/fb60c004f33e0fa2e87b9456b87f1b2709436b88
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 07 Oct 2024 18:50:09 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:30:32 +02:00

debugobjects: Rework object allocation

The current allocation scheme tries to allocate from the per CPU pool
first. If that fails it allocates one object from the global pool and then
refills the per CPU pool from the global pool.

That is in the way of switching the pool management to batch mode as the
global pool needs to be a strict stack of batches, which does not allow
to allocate single objects.

Rework the code to refill the per CPU pool first and then allocate the
object from the refilled batch. Also try to allocate from the to free pool
first to avoid freeing and reallocating objects.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
Link: https://lore.kernel.org/all/20241007164913.893554162@linutronix.de

---
 lib/debugobjects.c | 144 +++++++++++++++++++++-----------------------
 1 file changed, 69 insertions(+), 75 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index fbe8f26..3b18d5d 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -141,6 +141,64 @@ static __always_inline bool pool_must_refill(struct obj_pool *pool)
 	return pool_count(pool) < pool->min_cnt / 2;
 }
 
+static bool pool_move_batch(struct obj_pool *dst, struct obj_pool *src)
+{
+	if (dst->cnt + ODEBUG_BATCH_SIZE > dst->max_cnt || !src->cnt)
+		return false;
+
+	for (int i = 0; i < ODEBUG_BATCH_SIZE && src->cnt; i++) {
+		struct hlist_node *node = src->objects.first;
+
+		WRITE_ONCE(src->cnt, src->cnt - 1);
+		WRITE_ONCE(dst->cnt, dst->cnt + 1);
+
+		hlist_del(node);
+		hlist_add_head(node, &dst->objects);
+	}
+	return true;
+}
+
+static struct debug_obj *__alloc_object(struct hlist_head *list)
+{
+	struct debug_obj *obj;
+
+	if (unlikely(!list->first))
+		return NULL;
+
+	obj = hlist_entry(list->first, typeof(*obj), node);
+	hlist_del(&obj->node);
+	return obj;
+}
+
+static struct debug_obj *pcpu_alloc(void)
+{
+	struct obj_pool *pcp = this_cpu_ptr(&pool_pcpu);
+
+	lockdep_assert_irqs_disabled();
+
+	for (;;) {
+		struct debug_obj *obj = __alloc_object(&pcp->objects);
+
+		if (likely(obj)) {
+			pcp->cnt--;
+			return obj;
+		}
+
+		guard(raw_spinlock)(&pool_lock);
+		if (!pool_move_batch(pcp, &pool_to_free)) {
+			if (!pool_move_batch(pcp, &pool_global))
+				return NULL;
+		}
+		obj_pool_used += pcp->cnt;
+
+		if (obj_pool_used > obj_pool_max_used)
+			obj_pool_max_used = obj_pool_used;
+
+		if (pool_global.cnt < obj_pool_min_free)
+			obj_pool_min_free = pool_global.cnt;
+	}
+}
+
 static void free_object_list(struct hlist_head *head)
 {
 	struct hlist_node *tmp;
@@ -158,7 +216,6 @@ static void free_object_list(struct hlist_head *head)
 static void fill_pool_from_freelist(void)
 {
 	static unsigned long state;
-	struct debug_obj *obj;
 
 	/*
 	 * Reuse objs from the global obj_to_free list; they will be
@@ -180,17 +237,11 @@ static void fill_pool_from_freelist(void)
 	if (test_bit(0, &state) || test_and_set_bit(0, &state))
 		return;
 
-	guard(raw_spinlock)(&pool_lock);
-	/*
-	 * Recheck with the lock held as the worker thread might have
-	 * won the race and freed the global free list already.
-	 */
-	while (pool_to_free.cnt && (pool_global.cnt < pool_global.min_cnt)) {
-		obj = hlist_entry(pool_to_free.objects.first, typeof(*obj), node);
-		hlist_del(&obj->node);
-		WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt - 1);
-		hlist_add_head(&obj->node, &pool_global.objects);
-		WRITE_ONCE(pool_global.cnt, pool_global.cnt + 1);
+	/* Avoid taking the lock when there is no work to do */
+	while (pool_should_refill(&pool_global) && pool_count(&pool_to_free)) {
+		guard(raw_spinlock)(&pool_lock);
+		/* Move a batch if possible */
+		pool_move_batch(&pool_global, &pool_to_free);
 	}
 	clear_bit(0, &state);
 }
@@ -251,74 +302,17 @@ static struct debug_obj *lookup_object(void *addr, struct debug_bucket *b)
 	return NULL;
 }
 
-/*
- * Allocate a new object from the hlist
- */
-static struct debug_obj *__alloc_object(struct hlist_head *list)
-{
-	struct debug_obj *obj = NULL;
-
-	if (list->first) {
-		obj = hlist_entry(list->first, typeof(*obj), node);
-		hlist_del(&obj->node);
-	}
-
-	return obj;
-}
-
-static struct debug_obj *
-alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *descr)
+static struct debug_obj *alloc_object(void *addr, struct debug_bucket *b,
+				      const struct debug_obj_descr *descr)
 {
-	struct obj_pool *percpu_pool = this_cpu_ptr(&pool_pcpu);
 	struct debug_obj *obj;
 
-	if (likely(obj_cache)) {
-		obj = __alloc_object(&percpu_pool->objects);
-		if (obj) {
-			percpu_pool->cnt--;
-			goto init_obj;
-		}
-	} else {
+	if (likely(obj_cache))
+		obj = pcpu_alloc();
+	else
 		obj = __alloc_object(&pool_boot);
-		goto init_obj;
-	}
-
-	raw_spin_lock(&pool_lock);
-	obj = __alloc_object(&pool_global.objects);
-	if (obj) {
-		obj_pool_used++;
-		WRITE_ONCE(pool_global.cnt, pool_global.cnt - 1);
 
-		/*
-		 * Looking ahead, allocate one batch of debug objects and
-		 * put them into the percpu free pool.
-		 */
-		if (likely(obj_cache)) {
-			int i;
-
-			for (i = 0; i < ODEBUG_BATCH_SIZE; i++) {
-				struct debug_obj *obj2;
-
-				obj2 = __alloc_object(&pool_global.objects);
-				if (!obj2)
-					break;
-				hlist_add_head(&obj2->node, &percpu_pool->objects);
-				percpu_pool->cnt++;
-				obj_pool_used++;
-				WRITE_ONCE(pool_global.cnt, pool_global.cnt - 1);
-			}
-		}
-
-		if (obj_pool_used > obj_pool_max_used)
-			obj_pool_max_used = obj_pool_used;
-
-		if (pool_global.cnt < obj_pool_min_free)
-			obj_pool_min_free = pool_global.cnt;
-	}
-	raw_spin_unlock(&pool_lock);
-
-init_obj:
-	if (obj) {
+	if (likely(obj)) {
 		obj->object = addr;
 		obj->descr  = descr;
 		obj->state  = ODEBUG_STATE_NONE;

