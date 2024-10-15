Return-Path: <linux-tip-commits+bounces-2422-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EB799F178
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2B41F25CC3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27D21FAEEA;
	Tue, 15 Oct 2024 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RKzYMnFm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e7SvZ9k8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAEB1F76DB;
	Tue, 15 Oct 2024 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006586; cv=none; b=QKbyPDkcJArswYwTc8resp35OPuDbsvCgPGeLhiRxTs07nlUp893YJs0cXW1GmEnS8Bc9DLJ49Bj8c7m0FTwhy+NPTQceXNhHevp6EUMkh3kvOpEpCYr0EBw2n3P85b29oyoo5b/LAj+MFwEUM306X4IO7WgGPqUmwcwcAU/H6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006586; c=relaxed/simple;
	bh=093RwuXNStv/BnZOXai0S9lBMJv6yEOr5pByWAfRORU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RHO6BYVUcQMX4hNrj3U5U3AsWpX9F8ypSvkyMVGqvI2V9vwoUiUYLRX+XpsC9iyg6O83eGBVFVmwXUYfs6QyCShpbxVLeDnozWPN/1+ehbACJExj/kAo3vzzzvnx9OcY0R5EgTkWnxSE3zoseD55/xezgl2EL4i+FQZQHGXbg1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RKzYMnFm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e7SvZ9k8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:36:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729006583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ABbcLSEJBX3T0vXZKv5LaSocGQ96fc5uM+wKqgqQXS8=;
	b=RKzYMnFm6irJW7tjLaYPMjSB0EqIpzhO8QqeJyWyx0IUyUxX2HwCR5CT2z4ANg991GGLLy
	tk3rkwtMtFnqd3Zf1nNdT3+BMlgZNBmpCP3UtWB/gJSdHlilhuL8qKqyGiRV+aUimI4hLh
	A0soH+CpLzRfEMF1Ai/wxaWw/i7YJ33vn3b5uNzT5foUUcRg0Hi7uHnZ3TcujEooOWWiSP
	k0c50d6LfYuMtPQSDPqTEojKbltP6/4oqdLJY5nFDipqq9RrVGs6jcFGGjH0W9p7X/BLrZ
	wYyJkeJzUR+tGinL0fDdmTbeHd6jeVDEu03m79gpBfGj4OOhg794xsETEJ/uLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ABbcLSEJBX3T0vXZKv5LaSocGQ96fc5uM+wKqgqQXS8=;
	b=e7SvZ9k8wl1+Rl+XnZJbN4ld/XKc3bSRxHBFf31JCqhIw6YhLrIHVlcjE4D3SF+PWA5O+2
	sj6FOfPUMkqurvAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/debugobjects] debugobjects: Use separate list head for boot pool
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Zhen Lei <thunder.leizhen@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007164913.708939081@linutronix.de>
References: <20241007164913.708939081@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900658269.1442.7040661143707170729.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     cb58d190843059d5dc50d6ac483647ba61001e8f
Gitweb:        https://git.kernel.org/tip/cb58d190843059d5dc50d6ac483647ba61001e8f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 07 Oct 2024 18:50:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:30:31 +02:00

debugobjects: Use separate list head for boot pool

There is no point to handle the statically allocated objects during early
boot in the actual pool list. This phase does not require accounting, so
all of the related complexity can be avoided.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
Link: https://lore.kernel.org/all/20241007164913.708939081@linutronix.de

---
 lib/debugobjects.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index fcba13d..0b29a25 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -68,6 +68,8 @@ static DEFINE_RAW_SPINLOCK(pool_lock);
 static struct obj_pool		pool_global;
 static struct obj_pool		pool_to_free;
 
+static HLIST_HEAD(pool_boot);
+
 /*
  * Because of the presence of percpu free pools, obj_pool_free will
  * under-count those in the percpu free pools. Similarly, obj_pool_used
@@ -278,6 +280,9 @@ alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *d
 			percpu_pool->obj_free--;
 			goto init_obj;
 		}
+	} else {
+		obj = __alloc_object(&pool_boot);
+		goto init_obj;
 	}
 
 	raw_spin_lock(&pool_lock);
@@ -381,12 +386,14 @@ static void __free_object(struct debug_obj *obj)
 	struct debug_obj *objs[ODEBUG_BATCH_SIZE];
 	struct debug_percpu_free *percpu_pool;
 	int lookahead_count = 0;
-	unsigned long flags;
 	bool work;
 
-	local_irq_save(flags);
-	if (!obj_cache)
-		goto free_to_obj_pool;
+	guard(irqsave)();
+
+	if (unlikely(!obj_cache)) {
+		hlist_add_head(&obj->node, &pool_boot);
+		return;
+	}
 
 	/*
 	 * Try to free it into the percpu pool first.
@@ -395,7 +402,6 @@ static void __free_object(struct debug_obj *obj)
 	if (percpu_pool->obj_free < ODEBUG_POOL_PERCPU_SIZE) {
 		hlist_add_head(&obj->node, &percpu_pool->free_objs);
 		percpu_pool->obj_free++;
-		local_irq_restore(flags);
 		return;
 	}
 
@@ -410,7 +416,6 @@ static void __free_object(struct debug_obj *obj)
 		percpu_pool->obj_free--;
 	}
 
-free_to_obj_pool:
 	raw_spin_lock(&pool_lock);
 	work = (pool_global.cnt > debug_objects_pool_size) && obj_cache &&
 	       (pool_to_free.cnt < ODEBUG_FREE_WORK_MAX);
@@ -455,7 +460,6 @@ free_to_obj_pool:
 		}
 	}
 	raw_spin_unlock(&pool_lock);
-	local_irq_restore(flags);
 }
 
 /*
@@ -1341,10 +1345,9 @@ void __init debug_objects_early_init(void)
 	for (i = 0; i < ODEBUG_HASH_SIZE; i++)
 		raw_spin_lock_init(&obj_hash[i].lock);
 
+	/* Keep early boot simple and add everything to the boot list */
 	for (i = 0; i < ODEBUG_POOL_SIZE; i++)
-		hlist_add_head(&obj_static_pool[i].node, &pool_global.objects);
-
-	pool_global.cnt = ODEBUG_POOL_SIZE;
+		hlist_add_head(&obj_static_pool[i].node, &pool_boot);
 }
 
 /*
@@ -1372,10 +1375,11 @@ static bool __init debug_objects_replace_static_objects(struct kmem_cache *cache
 	pool_global.cnt = ODEBUG_POOL_SIZE;
 
 	/*
-	 * Replace the statically allocated objects list with the allocated
-	 * objects list.
+	 * Move the allocated objects to the global pool and disconnect the
+	 * boot pool.
 	 */
 	hlist_move_list(&objects, &pool_global.objects);
+	pool_boot.first = NULL;
 
 	/* Replace the active object references */
 	for (i = 0; i < ODEBUG_HASH_SIZE; i++, db++) {

