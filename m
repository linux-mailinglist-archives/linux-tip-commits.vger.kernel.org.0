Return-Path: <linux-tip-commits+bounces-2418-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA0C99F172
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6321C2295E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD331F76D6;
	Tue, 15 Oct 2024 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PFaY99Lg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NlmP/13j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FAB1F6686;
	Tue, 15 Oct 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006584; cv=none; b=lvX1JAwU9zRCfiTHeJ/sZhTPtKDd1Ljo6eCWksHCPpTc5xgEFdK1AS0P5z5/XSuVa/LC9XZii/DxqlXnDUdTG4aBvM46+sd8tQwhPhhu7dI7gJAOhnBRQElo/i2MrDZ2fkd8Sk7AlQUO065ZmpROwL/dc8v+EnP5STdjL3vAyrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006584; c=relaxed/simple;
	bh=WgxHWcC9yjYv5mrFDfH/2vOOumtogv/pY0IsO966+JM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SB5CALwnnZQeqXdr0A2jXnnWhaCEkynXY2kDYyLUr0cpaLEf3tLudr6hAdgeabmlexZSMJ81k+mcpnl/rTHWVYGiqNSZDyPFCdBXMeD/09JRzW8/ppTIQguKvtzs0NTCoYF/ccpPzgbeSIH+6wj1ecXv6PbJylPmg+ifduIbQn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PFaY99Lg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NlmP/13j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:36:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729006580;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XF9VRXrx4MNEikr8hPWYW4FQI7Kbj9z4roz2q0fiTNU=;
	b=PFaY99LgN5RSGYsiQADYvcGI0qq9g5P61ghA/jyF0FK0iXfUdxUHZ6tLPOcWrjS5z2rK5W
	4/ySImxQNK/nX3ebwvERk5SXzBNhARrRaLXgvKblk3WwSQr9uEyHv+e3gj5ARWtNbAz2/x
	la/FX677laqY/j2NZwvIEAqGweDL+NnuCrANBNfatOBj8hgEyw2JGZIsk/5yYhD2kgz8MU
	PLs+15gYTIUno3Fi2N/nE4dRdU73qh5yCUHUY2bqaWrVUfCI7NQb9hevDfzjNdTUFEsGt3
	TX5xPC44VmZy7gE3K1OLPcjEOdeBtbT72qxcnikQMwp8YjwUo8dEJRqW2EGNWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006580;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XF9VRXrx4MNEikr8hPWYW4FQI7Kbj9z4roz2q0fiTNU=;
	b=NlmP/13jLJT/tC5utImt+p4DT9Lw+6Plu/9hOQxp/ztZnHM73jnkoiBGVBsCKcM2ZOrfsM
	SiSite1RZqWAcjCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Rework object freeing
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Zhen Lei <thunder.leizhen@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007164913.955542307@linutronix.de>
References: <20241007164913.955542307@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900658009.1442.17922819931130538919.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     a3b9e191f5fc11fa93176a4074a919d33d64c5fe
Gitweb:        https://git.kernel.org/tip/a3b9e191f5fc11fa93176a4074a919d33d64c5fe
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 07 Oct 2024 18:50:10 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:30:32 +02:00

debugobjects: Rework object freeing

__free_object() is uncomprehensibly complex. The same can be achieved by:

   1) Adding the object to the per CPU pool

   2) If that pool is full, move a batch of objects into the global pool
      or if the global pool is full into the to free pool

This also prepares for batch processing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
Link: https://lore.kernel.org/all/20241007164913.955542307@linutronix.de

---
 lib/debugobjects.c |  99 ++++++++++----------------------------------
 1 file changed, 24 insertions(+), 75 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 3b18d5d..3700ddf 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -199,6 +199,27 @@ static struct debug_obj *pcpu_alloc(void)
 	}
 }
 
+static void pcpu_free(struct debug_obj *obj)
+{
+	struct obj_pool *pcp = this_cpu_ptr(&pool_pcpu);
+
+	lockdep_assert_irqs_disabled();
+
+	hlist_add_head(&obj->node, &pcp->objects);
+	pcp->cnt++;
+
+	/* Pool full ? */
+	if (pcp->cnt < ODEBUG_POOL_PERCPU_SIZE)
+		return;
+
+	/* Remove a batch from the per CPU pool */
+	guard(raw_spinlock)(&pool_lock);
+	/* Try to fit the batch into the pool_global first */
+	if (!pool_move_batch(&pool_global, pcp))
+		pool_move_batch(&pool_to_free, pcp);
+	obj_pool_used -= ODEBUG_BATCH_SIZE;
+}
+
 static void free_object_list(struct hlist_head *head)
 {
 	struct hlist_node *tmp;
@@ -375,83 +396,11 @@ free_objs:
 
 static void __free_object(struct debug_obj *obj)
 {
-	struct debug_obj *objs[ODEBUG_BATCH_SIZE];
-	struct obj_pool *percpu_pool;
-	int lookahead_count = 0;
-	bool work;
-
 	guard(irqsave)();
-
-	if (unlikely(!obj_cache)) {
+	if (likely(obj_cache))
+		pcpu_free(obj);
+	else
 		hlist_add_head(&obj->node, &pool_boot);
-		return;
-	}
-
-	/*
-	 * Try to free it into the percpu pool first.
-	 */
-	percpu_pool = this_cpu_ptr(&pool_pcpu);
-	if (percpu_pool->cnt < ODEBUG_POOL_PERCPU_SIZE) {
-		hlist_add_head(&obj->node, &percpu_pool->objects);
-		percpu_pool->cnt++;
-		return;
-	}
-
-	/*
-	 * As the percpu pool is full, look ahead and pull out a batch
-	 * of objects from the percpu pool and free them as well.
-	 */
-	for (; lookahead_count < ODEBUG_BATCH_SIZE; lookahead_count++) {
-		objs[lookahead_count] = __alloc_object(&percpu_pool->objects);
-		if (!objs[lookahead_count])
-			break;
-		percpu_pool->cnt--;
-	}
-
-	raw_spin_lock(&pool_lock);
-	work = (pool_global.cnt > pool_global.max_cnt) && obj_cache &&
-	       (pool_to_free.cnt < ODEBUG_FREE_WORK_MAX);
-	obj_pool_used--;
-
-	if (work) {
-		WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt + 1);
-		hlist_add_head(&obj->node, &pool_to_free.objects);
-		if (lookahead_count) {
-			WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt + lookahead_count);
-			obj_pool_used -= lookahead_count;
-			while (lookahead_count) {
-				hlist_add_head(&objs[--lookahead_count]->node,
-					       &pool_to_free.objects);
-			}
-		}
-
-		if ((pool_global.cnt > pool_global.max_cnt) &&
-		    (pool_to_free.cnt < ODEBUG_FREE_WORK_MAX)) {
-			int i;
-
-			/*
-			 * Free one more batch of objects from obj_pool.
-			 */
-			for (i = 0; i < ODEBUG_BATCH_SIZE; i++) {
-				obj = __alloc_object(&pool_global.objects);
-				hlist_add_head(&obj->node, &pool_to_free.objects);
-				WRITE_ONCE(pool_global.cnt, pool_global.cnt - 1);
-				WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt + 1);
-			}
-		}
-	} else {
-		WRITE_ONCE(pool_global.cnt, pool_global.cnt + 1);
-		hlist_add_head(&obj->node, &pool_global.objects);
-		if (lookahead_count) {
-			WRITE_ONCE(pool_global.cnt, pool_global.cnt + lookahead_count);
-			obj_pool_used -= lookahead_count;
-			while (lookahead_count) {
-				hlist_add_head(&objs[--lookahead_count]->node,
-					       &pool_global.objects);
-			}
-		}
-	}
-	raw_spin_unlock(&pool_lock);
 }
 
 /*

