Return-Path: <linux-tip-commits+bounces-2410-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F1F99F161
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F2C1F23D92
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552411C4A24;
	Tue, 15 Oct 2024 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WHBGjFKy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aCYuJVFc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC271CB9E2;
	Tue, 15 Oct 2024 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006579; cv=none; b=TcGWeqrCt00UmEFHKzeGayasjkk1WwUdQH2FmrbXRX67oXX/wihdo56YsTNGy5XvaOpJ0e0utpoKQf4dXFUWXP6TzEHn1VSehixP50jPlWmAb/FThsFaD16mMvB3TXrfuEoHU+ol2NEOYY7BfJi1u3/U7S40oJVAPYmbg1xEQw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006579; c=relaxed/simple;
	bh=6BQsKAqP2CS6V9PDubSmcfaTOHNmsnNP+sk3h4adKLw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V7PhPC1DhfZmpCxkvNLikbw7b4C5nsF1roa8k+57Ky0Z9KR4quOlyqJMNST4Oh0nH11X7SDY1qNCijnBpgWJc+VVbHIUxdmfuLL+4zpehab6UoIobYFzmTeobIBbyfi4v4Vx2IniwgqEsXcD4jRiV0yVm3HQoBB6ziWCqv2Yci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WHBGjFKy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aCYuJVFc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:36:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729006575;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VF2keW+8jjocj40krtzVcBhegMeJLceh+E1g8CQwADo=;
	b=WHBGjFKy7prRm49wwmiAlU+TCmNqlS9hg+IDYSammJ1LGxM3cb/mexLXl92i9Svxd+NCmJ
	ExCf2Zkuu9DVbHYyR1dFXeEvE6+KRUpeCrV6MnhlxLkjhYmu6NXtvrPTlvAOxO+Uprfp2J
	J46OYHZltl3fLCpDiQXGtwXQAGlox3B+4qsJtBxSFz4PkjXJtKvQ/KkwFDTzQ/SHHurWAO
	kWV+7UHRmHjgSSRM2BfbZHxcYNmF+e9dl4rTTh6zrL0xcYJXgfi4JZWWGimv9NoHjyT1dk
	4P+VN6Zt8OAy1e+uFcfK9Tkg3mpZVpR2SZWHfSCIP3WvBs2TexKiaicAp7t80A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006575;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VF2keW+8jjocj40krtzVcBhegMeJLceh+E1g8CQwADo=;
	b=aCYuJVFcxBKqNjniMA4Pf3gLtZxwIIh9q7DGXWg2jTtjEZkSshhIZgfOQp5B4IsP4pa9XF
	isA21WUcex7c7aBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Track object usage to avoid
 premature freeing of objects
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Zhen Lei <thunder.leizhen@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87bjznhme2.ffs@tglx>
References: <87bjznhme2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900657475.1442.16629168348781563122.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     ff8d523cc4520a5ce86cde0fd57c304e2b4f61b3
Gitweb:        https://git.kernel.org/tip/ff8d523cc4520a5ce86cde0fd57c304e2b4f61b3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 13 Oct 2024 20:45:57 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:30:33 +02:00

debugobjects: Track object usage to avoid premature freeing of objects

The freelist is freed at a constant rate independent of the actual usage
requirements. That's bad in scenarios where usage comes in bursts. The end
of a burst puts the objects on the free list and freeing proceeds even when
the next burst which requires objects started again.

Keep track of the usage with a exponentially wheighted moving average and
take that into account in the worker function which frees objects from the
free list.

This further reduces the kmem_cache allocation/free rate for a full kernel
compile:

   	    kmem_cache_alloc()	kmem_cache_free()
Baseline:   225k		173k
Usage:	    170k		117k

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
Link: https://lore.kernel.org/all/87bjznhme2.ffs@tglx

---
 lib/debugobjects.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index cc32844..7f50c44 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -13,6 +13,7 @@
 #include <linux/hash.h>
 #include <linux/kmemleak.h>
 #include <linux/sched.h>
+#include <linux/sched/loadavg.h>
 #include <linux/sched/task_stack.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -86,6 +87,7 @@ static struct obj_pool pool_to_free = {
 
 static HLIST_HEAD(pool_boot);
 
+static unsigned long		avg_usage;
 static bool			obj_freeing;
 
 static int __data_racy			debug_objects_maxchain __read_mostly;
@@ -427,11 +429,31 @@ static struct debug_obj *lookup_object(void *addr, struct debug_bucket *b)
 	return NULL;
 }
 
+static void calc_usage(void)
+{
+	static DEFINE_RAW_SPINLOCK(avg_lock);
+	static unsigned long avg_period;
+	unsigned long cur, now = jiffies;
+
+	if (!time_after_eq(now, READ_ONCE(avg_period)))
+		return;
+
+	if (!raw_spin_trylock(&avg_lock))
+		return;
+
+	WRITE_ONCE(avg_period, now + msecs_to_jiffies(10));
+	cur = READ_ONCE(pool_global.stats.cur_used) * ODEBUG_FREE_WORK_MAX;
+	WRITE_ONCE(avg_usage, calc_load(avg_usage, EXP_5, cur));
+	raw_spin_unlock(&avg_lock);
+}
+
 static struct debug_obj *alloc_object(void *addr, struct debug_bucket *b,
 				      const struct debug_obj_descr *descr)
 {
 	struct debug_obj *obj;
 
+	calc_usage();
+
 	if (static_branch_likely(&obj_cache_enabled))
 		obj = pcpu_alloc();
 	else
@@ -450,14 +472,26 @@ static struct debug_obj *alloc_object(void *addr, struct debug_bucket *b,
 /* workqueue function to free objects. */
 static void free_obj_work(struct work_struct *work)
 {
-	bool free = true;
+	static unsigned long last_use_avg;
+	unsigned long cur_used, last_used, delta;
+	unsigned int max_free = 0;
 
 	WRITE_ONCE(obj_freeing, false);
 
+	/* Rate limit freeing based on current use average */
+	cur_used = READ_ONCE(avg_usage);
+	last_used = last_use_avg;
+	last_use_avg = cur_used;
+
 	if (!pool_count(&pool_to_free))
 		return;
 
-	for (unsigned int cnt = 0; cnt < ODEBUG_FREE_WORK_MAX; cnt++) {
+	if (cur_used <= last_used) {
+		delta = (last_used - cur_used) / ODEBUG_FREE_WORK_MAX;
+		max_free = min(delta, ODEBUG_FREE_WORK_MAX);
+	}
+
+	for (int cnt = 0; cnt < ODEBUG_FREE_WORK_MAX; cnt++) {
 		HLIST_HEAD(tofree);
 
 		/* Acquire and drop the lock for each batch */
@@ -468,9 +502,10 @@ static void free_obj_work(struct work_struct *work)
 			/* Refill the global pool if possible */
 			if (pool_move_batch(&pool_global, &pool_to_free)) {
 				/* Don't free as there seems to be demand */
-				free = false;
-			} else if (free) {
+				max_free = 0;
+			} else if (max_free) {
 				pool_pop_batch(&tofree, &pool_to_free);
+				max_free--;
 			} else {
 				return;
 			}
@@ -1110,7 +1145,7 @@ static int debug_stats_show(struct seq_file *m, void *v)
 	for_each_possible_cpu(cpu)
 		pcp_free += per_cpu(pool_pcpu.cnt, cpu);
 
-	pool_used = data_race(pool_global.stats.cur_used);
+	pool_used = READ_ONCE(pool_global.stats.cur_used);
 	pcp_free = min(pool_used, pcp_free);
 	pool_used -= pcp_free;
 

