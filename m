Return-Path: <linux-tip-commits+bounces-2412-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB00899F166
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 265C5B21BA7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3C81EBA0B;
	Tue, 15 Oct 2024 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x0IwpNDp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VKEX4CVt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867481D9580;
	Tue, 15 Oct 2024 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006581; cv=none; b=c+cuxqzXHtBHHjAn4Xiwdfviq/uubK3ib81M7s+zLvupf3zM1ORs5g0JXzfp8OwLccV9zry5nicqI5Gi4IJxoKjdwk4eIEICLahv3qEP/HokrGebNrOazbhMo24srv7FlcjtOKPMdQ1Tw0dYbX9AkZbXWhZvGMb5B0SOX+C55Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006581; c=relaxed/simple;
	bh=IzMv2zi/gLw6UzbO7X2/lM6vM6/ZOi57uhxMpIgl0Zc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HD49IuZPJf6FDR/p4khSlwNpI71E5lYvcIHhY1JY9XXZtvfYBK8ZjsKOOS874LQHw5SdCKt830c/3VCISrDqSzo/fbu60gwKWNSye+XOV9WXRYxRmM58FR57hVkbrwFG5GpHCjkNAqdGpXjjjMMd9ZmFzo6+xAHLuc5XGmN8bGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x0IwpNDp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VKEX4CVt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:36:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729006577;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6rUt6fz3udX88STFqSK6FionsDKC2BXj/9bJLwGilBc=;
	b=x0IwpNDpml1AQocC2tZtlfNeR8hyeV0z+Sp3p+u78kKiLD0MN+e5t6jwJajx/O8wXaDIo+
	kUYXWH4+ksrTrwB2SES0/dckNvg+84YjNGa7cELkP5bkqLkLfuibq5ppkgGqaytBetmwgC
	jzbleQuAIfkb3WY60BJhwnxk76++41VE5OZ9AbBDqZdNalApSGDpUnTPMWt+31norHWY/f
	TcYgYtl2To+kCTSwEMfbPzVdIQtjvYyGZR7jPbsnk4CgNobksnfbh9B1QyY6pHJQQRt6qv
	VBkHDHYk/zuzXTr69OPdwdcLIKFPoCoySdMEP8SGn/1OLqN4A90zctGZh6wmZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006577;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6rUt6fz3udX88STFqSK6FionsDKC2BXj/9bJLwGilBc=;
	b=VKEX4CVtr1tpQvlUeec7Z0CIfVJ+DyvASGy2el5jt9jI6T35N27CUDq93BUaCmL8rEMNhr
	G7krNe/FVYzdc9Bg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Move pool statistics into
 global_pool struct
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Zhen Lei <thunder.leizhen@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007164914.318776207@linutronix.de>
References: <20241007164914.318776207@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900657658.1442.6063333664435088408.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     2638345d22529cdc964d20a617bfd32d87f27e0f
Gitweb:        https://git.kernel.org/tip/2638345d22529cdc964d20a617bfd32d87f27e0f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 07 Oct 2024 18:50:18 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:30:33 +02:00

debugobjects: Move pool statistics into global_pool struct

Keep it along with the pool as that's a hot cache line anyway and it makes
the code more comprehensible.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
Link: https://lore.kernel.org/all/20241007164914.318776207@linutronix.de

---
 lib/debugobjects.c | 87 ++++++++++++++++++++++++++-------------------
 1 file changed, 52 insertions(+), 35 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 4e80c31..cf704e2 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -47,11 +47,18 @@ struct debug_bucket {
 	raw_spinlock_t		lock;
 };
 
+struct pool_stats {
+	unsigned int		cur_used;
+	unsigned int		max_used;
+	unsigned int		min_fill;
+};
+
 struct obj_pool {
 	struct hlist_head	objects;
 	unsigned int		cnt;
 	unsigned int		min_cnt;
 	unsigned int		max_cnt;
+	struct pool_stats	stats;
 } ____cacheline_aligned;
 
 
@@ -66,8 +73,11 @@ static struct debug_obj		obj_static_pool[ODEBUG_POOL_SIZE] __initdata;
 static DEFINE_RAW_SPINLOCK(pool_lock);
 
 static struct obj_pool pool_global = {
-	.min_cnt	= ODEBUG_POOL_MIN_LEVEL,
-	.max_cnt	= ODEBUG_POOL_SIZE,
+	.min_cnt		= ODEBUG_POOL_MIN_LEVEL,
+	.max_cnt		= ODEBUG_POOL_SIZE,
+	.stats			= {
+		.min_fill	= ODEBUG_POOL_SIZE,
+	},
 };
 
 static struct obj_pool pool_to_free = {
@@ -76,16 +86,6 @@ static struct obj_pool pool_to_free = {
 
 static HLIST_HEAD(pool_boot);
 
-/*
- * Because of the presence of percpu free pools, obj_pool_free will
- * under-count those in the percpu free pools. Similarly, obj_pool_used
- * will over-count those in the percpu free pools. Adjustments will be
- * made at debug_stats_show(). Both obj_pool_min_free and obj_pool_max_used
- * can be off.
- */
-static int __data_racy		obj_pool_min_free = ODEBUG_POOL_SIZE;
-static int			obj_pool_used;
-static int __data_racy		obj_pool_max_used;
 static bool			obj_freeing;
 
 static int __data_racy			debug_objects_maxchain __read_mostly;
@@ -231,6 +231,19 @@ static struct debug_obj *__alloc_object(struct hlist_head *list)
 	return obj;
 }
 
+static void pcpu_refill_stats(void)
+{
+	struct pool_stats *stats = &pool_global.stats;
+
+	WRITE_ONCE(stats->cur_used, stats->cur_used + ODEBUG_BATCH_SIZE);
+
+	if (stats->cur_used > stats->max_used)
+		stats->max_used = stats->cur_used;
+
+	if (pool_global.cnt < stats->min_fill)
+		stats->min_fill = pool_global.cnt;
+}
+
 static struct debug_obj *pcpu_alloc(void)
 {
 	struct obj_pool *pcp = this_cpu_ptr(&pool_pcpu);
@@ -250,13 +263,7 @@ static struct debug_obj *pcpu_alloc(void)
 			if (!pool_move_batch(pcp, &pool_global))
 				return NULL;
 		}
-		obj_pool_used += ODEBUG_BATCH_SIZE;
-
-		if (obj_pool_used > obj_pool_max_used)
-			obj_pool_max_used = obj_pool_used;
-
-		if (pool_global.cnt < obj_pool_min_free)
-			obj_pool_min_free = pool_global.cnt;
+		pcpu_refill_stats();
 	}
 }
 
@@ -285,7 +292,7 @@ static void pcpu_free(struct debug_obj *obj)
 	/* Try to fit the batch into the pool_global first */
 	if (!pool_move_batch(&pool_global, pcp))
 		pool_move_batch(&pool_to_free, pcp);
-	obj_pool_used -= ODEBUG_BATCH_SIZE;
+	WRITE_ONCE(pool_global.stats.cur_used, pool_global.stats.cur_used - ODEBUG_BATCH_SIZE);
 }
 
 static void free_object_list(struct hlist_head *head)
@@ -1074,23 +1081,33 @@ void debug_check_no_obj_freed(const void *address, unsigned long size)
 
 static int debug_stats_show(struct seq_file *m, void *v)
 {
-	int cpu, obj_percpu_free = 0;
+	unsigned int cpu, pool_used, pcp_free = 0;
 
+	/*
+	 * pool_global.stats.cur_used is the number of batches currently
+	 * handed out to per CPU pools. Convert it to number of objects
+	 * and subtract the number of free objects in the per CPU pools.
+	 * As this is lockless the number is an estimate.
+	 */
 	for_each_possible_cpu(cpu)
-		obj_percpu_free += per_cpu(pool_pcpu.cnt, cpu);
-
-	seq_printf(m, "max_chain     :%d\n", debug_objects_maxchain);
-	seq_printf(m, "max_checked   :%d\n", debug_objects_maxchecked);
-	seq_printf(m, "warnings      :%d\n", debug_objects_warnings);
-	seq_printf(m, "fixups        :%d\n", debug_objects_fixups);
-	seq_printf(m, "pool_free     :%d\n", pool_count(&pool_global) + obj_percpu_free);
-	seq_printf(m, "pool_pcp_free :%d\n", obj_percpu_free);
-	seq_printf(m, "pool_min_free :%d\n", obj_pool_min_free);
-	seq_printf(m, "pool_used     :%d\n", obj_pool_used - obj_percpu_free);
-	seq_printf(m, "pool_max_used :%d\n", obj_pool_max_used);
-	seq_printf(m, "on_free_list  :%d\n", pool_count(&pool_to_free));
-	seq_printf(m, "objs_allocated:%d\n", debug_objects_allocated);
-	seq_printf(m, "objs_freed    :%d\n", debug_objects_freed);
+		pcp_free += per_cpu(pool_pcpu.cnt, cpu);
+
+	pool_used = data_race(pool_global.stats.cur_used);
+	pcp_free = min(pool_used, pcp_free);
+	pool_used -= pcp_free;
+
+	seq_printf(m, "max_chain     : %d\n", debug_objects_maxchain);
+	seq_printf(m, "max_checked   : %d\n", debug_objects_maxchecked);
+	seq_printf(m, "warnings      : %d\n", debug_objects_warnings);
+	seq_printf(m, "fixups        : %d\n", debug_objects_fixups);
+	seq_printf(m, "pool_free     : %u\n", pool_count(&pool_global) + pcp_free);
+	seq_printf(m, "pool_pcp_free : %u\n", pcp_free);
+	seq_printf(m, "pool_min_free : %u\n", data_race(pool_global.stats.min_fill));
+	seq_printf(m, "pool_used     : %u\n", pool_used);
+	seq_printf(m, "pool_max_used : %u\n", data_race(pool_global.stats.max_used));
+	seq_printf(m, "on_free_list  : %u\n", pool_count(&pool_to_free));
+	seq_printf(m, "objs_allocated: %d\n", debug_objects_allocated);
+	seq_printf(m, "objs_freed    : %d\n", debug_objects_freed);
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(debug_stats);

