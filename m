Return-Path: <linux-tip-commits+bounces-2414-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5D499F169
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3535B20BAF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE373BBF6;
	Tue, 15 Oct 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B6rGzNCm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mq93QkgG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866DF1D8A12;
	Tue, 15 Oct 2024 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006582; cv=none; b=iWTnK5cWUTv9KH4T8IllLNKDOshNy0JtWTi847kKYM/kKqFL6+DqPqwgC/vUGAKhBrIdg2aS62ORU2d3pAqZIAvXhN5SAo3c2zj2loB9XnmfJ3/5fNTJq1aotF5z0WbOelvkL87+fz3Hk7o2co1/PhQV3MCg9Y1wtDY5J8mycjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006582; c=relaxed/simple;
	bh=z8IgsOmErf1x3M6hgwT/hg8B/F8U86LPKlUiWYZqQGY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TAaMbkYBWeZBIFBLcLLWHB+fEjVi8xY2++nGz7RoI/cNiBLYufge5g9WEWs+rUHWyrQss8bRJB+HEWLChbLwC+S5S1B4/6PhlhdU34UBOss3JdRCzq76tYxKCUlQOgPXVOx5bFxQQ3pA/7q3BM2Y4OBINyWUNclRGkKQScRJJJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B6rGzNCm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mq93QkgG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:36:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729006577;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U20TTMjy9eyYv0yGB07JVXFXr1Hc5f6X1+fAlhN15Qw=;
	b=B6rGzNCmq7aFsIFlW46qQgIklyfrEFHd6RqOdgFbLNSnynZhaPypK2fo0FrvMJNXYl4+Gv
	2IE8rTlRGFqZl7sYK2mu952Fgo7ViH4L0TfE4uPwVg5sJP6QTsImpc828gojsbG1iR16yZ
	tBysArBB0j5ysjFZQ6lFfEJcliSPXEo2tVGon104nbmRP9cSzx9aTUWq1m/qo+v9UzFQGu
	XpdQJdtpy26ZJ8vLDGCu03Dz/lyWlAVbKzX+UkodnhEoTaFs6/JrA7aF80STSgfx80rqhg
	c1zv8pQMqNq8aOZiph9o3GtWA/uSfdaPaHmEzKhOgm4AjWi/vDNhRyE6pF3iIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006577;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U20TTMjy9eyYv0yGB07JVXFXr1Hc5f6X1+fAlhN15Qw=;
	b=mq93QkgGida1wSr/uW0LTGmtdn4HI/RDH3WOtewLeCkYwVvwhLbMUPu+Ode2Mdz44EChmU
	qjDhBigJJ/i8DJDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Implement batch processing
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Zhen Lei <thunder.leizhen@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007164914.258995000@linutronix.de>
References: <20241007164914.258995000@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900657716.1442.3443479741970373836.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     f57ebb92ba3e09a7e1082f147d6e1456d702d4b2
Gitweb:        https://git.kernel.org/tip/f57ebb92ba3e09a7e1082f147d6e1456d702d4b2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 07 Oct 2024 18:50:17 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:30:33 +02:00

debugobjects: Implement batch processing

Adding and removing single objects in a loop is bad in terms of lock
contention and cache line accesses.

To implement batching, record the last object in a batch in the object
itself. This is trivialy possible as hlists are strictly stacks. At a batch
boundary, when the first object is added to the list the object stores a
pointer to itself in debug_obj::batch_last. When the next object is added
to the list then the batch_last pointer is retrieved from the first object
in the list and stored in the to be added one.

That means for batch processing the first object always has a pointer to
the last object in a batch, which allows to move batches in a cache line
efficient way and reduces the lock held time.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
Link: https://lore.kernel.org/all/20241007164914.258995000@linutronix.de

---
 lib/debugobjects.c | 61 +++++++++++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 15 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index cdd5d23..4e80c31 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -149,18 +149,31 @@ static __always_inline bool pool_must_refill(struct obj_pool *pool)
 
 static bool pool_move_batch(struct obj_pool *dst, struct obj_pool *src)
 {
-	if (dst->cnt + ODEBUG_BATCH_SIZE > dst->max_cnt || !src->cnt)
+	struct hlist_node *last, *next_batch, *first_batch;
+	struct debug_obj *obj;
+
+	if (dst->cnt >= dst->max_cnt || !src->cnt)
 		return false;
 
-	for (int i = 0; i < ODEBUG_BATCH_SIZE && src->cnt; i++) {
-		struct hlist_node *node = src->objects.first;
+	first_batch = src->objects.first;
+	obj = hlist_entry(first_batch, typeof(*obj), node);
+	last = obj->batch_last;
+	next_batch = last->next;
 
-		WRITE_ONCE(src->cnt, src->cnt - 1);
-		WRITE_ONCE(dst->cnt, dst->cnt + 1);
+	/* Move the next batch to the front of the source pool */
+	src->objects.first = next_batch;
+	if (next_batch)
+		next_batch->pprev = &src->objects.first;
 
-		hlist_del(node);
-		hlist_add_head(node, &dst->objects);
-	}
+	/* Add the extracted batch to the destination pool */
+	last->next = dst->objects.first;
+	if (last->next)
+		last->next->pprev = &last->next;
+	first_batch->pprev = &dst->objects.first;
+	dst->objects.first = first_batch;
+
+	WRITE_ONCE(src->cnt, src->cnt - ODEBUG_BATCH_SIZE);
+	WRITE_ONCE(dst->cnt, dst->cnt + ODEBUG_BATCH_SIZE);
 	return true;
 }
 
@@ -182,16 +195,27 @@ static bool pool_push_batch(struct obj_pool *dst, struct hlist_head *head)
 
 static bool pool_pop_batch(struct hlist_head *head, struct obj_pool *src)
 {
+	struct hlist_node *last, *next;
+	struct debug_obj *obj;
+
 	if (!src->cnt)
 		return false;
 
-	for (int i = 0; src->cnt && i < ODEBUG_BATCH_SIZE; i++) {
-		struct hlist_node *node = src->objects.first;
+	/* Move the complete list to the head */
+	hlist_move_list(&src->objects, head);
 
-		WRITE_ONCE(src->cnt, src->cnt - 1);
-		hlist_del(node);
-		hlist_add_head(node, head);
-	}
+	obj = hlist_entry(head->first, typeof(*obj), node);
+	last = obj->batch_last;
+	next = last->next;
+	/* Disconnect the batch from the list */
+	last->next = NULL;
+
+	/* Move the node after last back to the source pool. */
+	src->objects.first = next;
+	if (next)
+		next->pprev = &src->objects.first;
+
+	WRITE_ONCE(src->cnt, src->cnt - ODEBUG_BATCH_SIZE);
 	return true;
 }
 
@@ -226,7 +250,7 @@ static struct debug_obj *pcpu_alloc(void)
 			if (!pool_move_batch(pcp, &pool_global))
 				return NULL;
 		}
-		obj_pool_used += pcp->cnt;
+		obj_pool_used += ODEBUG_BATCH_SIZE;
 
 		if (obj_pool_used > obj_pool_max_used)
 			obj_pool_max_used = obj_pool_used;
@@ -239,9 +263,16 @@ static struct debug_obj *pcpu_alloc(void)
 static void pcpu_free(struct debug_obj *obj)
 {
 	struct obj_pool *pcp = this_cpu_ptr(&pool_pcpu);
+	struct debug_obj *first;
 
 	lockdep_assert_irqs_disabled();
 
+	if (!(pcp->cnt % ODEBUG_BATCH_SIZE)) {
+		obj->batch_last = &obj->node;
+	} else {
+		first = hlist_entry(pcp->objects.first, typeof(*first), node);
+		obj->batch_last = first->batch_last;
+	}
 	hlist_add_head(&obj->node, &pcp->objects);
 	pcp->cnt++;
 

