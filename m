Return-Path: <linux-tip-commits+bounces-2421-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB3699F177
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA2F1C22DD4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32E01F9EDD;
	Tue, 15 Oct 2024 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ai0lmEB3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0x0fUYLO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8555B1F76CA;
	Tue, 15 Oct 2024 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006586; cv=none; b=cUMolzTlaKiGJW6Mi0eUS6NOU8//AbLBC0W0OLsoWwT1IW3exWavacWctPA7EKhuLnRRIdEYjqYRrxC2UldFcucndbJEn5HJ91BRjhfxXL4UvC8PwohR5vh37npZDYdHtKC8EsKV2a4ulZLioqR2kDz5GK/+iuQsywguuRq5rM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006586; c=relaxed/simple;
	bh=zY9rGQdPXBGZTFGYD7aH/d6BU2N88BTOcMyFxHKzTj0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TUpTw8f825q3QgkFYlHfRirXbwVyzpSIHhbUsMorylxgnpntgCOaYemfJ6Z8DnFf56DZdpIAhboQGOBeYzLcFCBiMUbf1jGGFXQIkGZfeLFwje5oxOlkkUDQnXGNKXmW1dcxUxlLp6wbIzy5Gp/S14dKe6lMhIrAnVVeXvXPdQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ai0lmEB3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0x0fUYLO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:36:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729006582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3GQJvDdvCZcmFIPm035xm1OicTWa0btQdz2ma4VWPFE=;
	b=Ai0lmEB3rBULX6DDE1FEKZq3C9GiLX3j4iDpZ04oviYn7W6HCno5alEkt/ZZ5Av5xE11mY
	msWPaavDQWxO3aEIwdj5lhKp5VYzLzwcN0UW/Ow0d8hVTQbX0wxl/U4Jd1u+Clk+jfmXsm
	ovpZKHboLY5q2dZRclKX0FaG9lavOLmvgWimylrBje1/3Yj9D1dmjdEYixqHGAcvYTmvcf
	0pQmdeEhXjYgR9J/oL+uS/ML0Rf2mFybBRIZ008OQHkv0nDtS+KrzUGikKGTUSFxLAKwzv
	GCdto4esmBBl4jUM5Qci+XeIBLS9SsT8hJQiZ6qCe8UuR/dklpI76HfUUuIYgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3GQJvDdvCZcmFIPm035xm1OicTWa0btQdz2ma4VWPFE=;
	b=0x0fUYLO2Mk1JR5EdRpcXZ6omMxP56CeF0mNfgmFcWszCmqKmisWRs3td8P2yM8XONKGu2
	3kmzrQq6ixBUuJBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/debugobjects] debugobjects: Rename and tidy up per CPU pools
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Zhen Lei <thunder.leizhen@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007164913.770595795@linutronix.de>
References: <20241007164913.770595795@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900658214.1442.7932676239510595531.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     18b8afcb37d8a72479892e080e4d37890f2bf353
Gitweb:        https://git.kernel.org/tip/18b8afcb37d8a72479892e080e4d37890f2bf353
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 07 Oct 2024 18:50:07 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:30:31 +02:00

debugobjects: Rename and tidy up per CPU pools

No point in having a separate data structure. Reuse struct obj_pool and
tidy up the code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
Link: https://lore.kernel.org/all/20241007164913.770595795@linutronix.de

---
 lib/debugobjects.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 0b29a25..3d1d973 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -43,21 +43,12 @@ struct debug_bucket {
 	raw_spinlock_t		lock;
 };
 
-/*
- * Debug object percpu free list
- * Access is protected by disabling irq
- */
-struct debug_percpu_free {
-	struct hlist_head	free_objs;
-	int			obj_free;
-};
-
 struct obj_pool {
 	struct hlist_head	objects;
 	unsigned int		cnt;
 } ____cacheline_aligned;
 
-static DEFINE_PER_CPU(struct debug_percpu_free, percpu_obj_pool);
+static DEFINE_PER_CPU(struct obj_pool, pool_pcpu);
 
 static struct debug_bucket	obj_hash[ODEBUG_HASH_SIZE];
 
@@ -271,13 +262,13 @@ static struct debug_obj *__alloc_object(struct hlist_head *list)
 static struct debug_obj *
 alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *descr)
 {
-	struct debug_percpu_free *percpu_pool = this_cpu_ptr(&percpu_obj_pool);
+	struct obj_pool *percpu_pool = this_cpu_ptr(&pool_pcpu);
 	struct debug_obj *obj;
 
 	if (likely(obj_cache)) {
-		obj = __alloc_object(&percpu_pool->free_objs);
+		obj = __alloc_object(&percpu_pool->objects);
 		if (obj) {
-			percpu_pool->obj_free--;
+			percpu_pool->cnt--;
 			goto init_obj;
 		}
 	} else {
@@ -304,8 +295,8 @@ alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *d
 				obj2 = __alloc_object(&pool_global.objects);
 				if (!obj2)
 					break;
-				hlist_add_head(&obj2->node, &percpu_pool->free_objs);
-				percpu_pool->obj_free++;
+				hlist_add_head(&obj2->node, &percpu_pool->objects);
+				percpu_pool->cnt++;
 				obj_pool_used++;
 				WRITE_ONCE(pool_global.cnt, pool_global.cnt - 1);
 			}
@@ -384,7 +375,7 @@ free_objs:
 static void __free_object(struct debug_obj *obj)
 {
 	struct debug_obj *objs[ODEBUG_BATCH_SIZE];
-	struct debug_percpu_free *percpu_pool;
+	struct obj_pool *percpu_pool;
 	int lookahead_count = 0;
 	bool work;
 
@@ -398,10 +389,10 @@ static void __free_object(struct debug_obj *obj)
 	/*
 	 * Try to free it into the percpu pool first.
 	 */
-	percpu_pool = this_cpu_ptr(&percpu_obj_pool);
-	if (percpu_pool->obj_free < ODEBUG_POOL_PERCPU_SIZE) {
-		hlist_add_head(&obj->node, &percpu_pool->free_objs);
-		percpu_pool->obj_free++;
+	percpu_pool = this_cpu_ptr(&pool_pcpu);
+	if (percpu_pool->cnt < ODEBUG_POOL_PERCPU_SIZE) {
+		hlist_add_head(&obj->node, &percpu_pool->objects);
+		percpu_pool->cnt++;
 		return;
 	}
 
@@ -410,10 +401,10 @@ static void __free_object(struct debug_obj *obj)
 	 * of objects from the percpu pool and free them as well.
 	 */
 	for (; lookahead_count < ODEBUG_BATCH_SIZE; lookahead_count++) {
-		objs[lookahead_count] = __alloc_object(&percpu_pool->free_objs);
+		objs[lookahead_count] = __alloc_object(&percpu_pool->objects);
 		if (!objs[lookahead_count])
 			break;
-		percpu_pool->obj_free--;
+		percpu_pool->cnt--;
 	}
 
 	raw_spin_lock(&pool_lock);
@@ -494,10 +485,10 @@ static void put_objects(struct hlist_head *list)
 static int object_cpu_offline(unsigned int cpu)
 {
 	/* Remote access is safe as the CPU is dead already */
-	struct debug_percpu_free *pcp = per_cpu_ptr(&percpu_obj_pool, cpu);
+	struct obj_pool *pcp = per_cpu_ptr(&pool_pcpu, cpu);
 
-	put_objects(&pcp->free_objs);
-	pcp->obj_free = 0;
+	put_objects(&pcp->objects);
+	pcp->cnt = 0;
 	return 0;
 }
 #endif
@@ -1076,7 +1067,7 @@ static int debug_stats_show(struct seq_file *m, void *v)
 	int cpu, obj_percpu_free = 0;
 
 	for_each_possible_cpu(cpu)
-		obj_percpu_free += per_cpu(percpu_obj_pool.obj_free, cpu);
+		obj_percpu_free += per_cpu(pool_pcpu.cnt, cpu);
 
 	seq_printf(m, "max_chain     :%d\n", debug_objects_maxchain);
 	seq_printf(m, "max_checked   :%d\n", debug_objects_maxchecked);

