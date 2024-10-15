Return-Path: <linux-tip-commits+bounces-2433-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DAF99F190
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B54EB1C23531
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CC83DABE6;
	Tue, 15 Oct 2024 15:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bD6eiSKd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bnh2a3nV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4F92281F1;
	Tue, 15 Oct 2024 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006595; cv=none; b=CJOBsX6Ge7q+crhTZ5kJ1mjn9tj8TsFPVY2x2BMWmupy2hREJVxy+M2AKMh2bXHVfSW4Nj9yTf7U/VozF188ZYhUutgMeprq9hcnQaH/JvhL0yGxgz6DefkbkZqJP6wyacYEaHhWLScTgVTNdKOHHFQ9GzXRh8TvwqDrXVptDxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006595; c=relaxed/simple;
	bh=+TTToxIAckF6B5/31g7PU/xr1bxQowI/4NqBGEb77to=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dfltK4HDJV5oTkAmBnNv6h6j+iMGtxX28fdGLcXrusJLbjxeSLakXMnPPvGRN1A5HYVV3FY4ZpUc5LedAAG4KluDuvJNvHvtjCq5j8UunBn4wVJ6tLxC0hJ39s4y66AShHfoXVS7v/+pS30Bc1/93cGznGV3HhAwC+5WyopQlAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bD6eiSKd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bnh2a3nV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:36:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729006588;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hZ0QxoJd15i42g4eBX3HNknZvatVunZZH44FhpcC3JY=;
	b=bD6eiSKdcdXjAb7zVuNjArZiorehYMJydUXfkXpl+fWSGcA1KAo5T6nQIFphOXlLPO0x5R
	pUoRHkWKdVyjff3vDqt+eQA9zpSMiINLQoKMDZe15jUZjeObGo/qrVjTUeK2fXYdtG+wXt
	gR7nLvB3uuxHSlcCkGLjr/GJYHmp1wHXtg8/LHQuAplwlO23OvvqR1L30gH8hkEXUbpPsX
	mwy465fzqwfgWAusVyIR3tpjuNWWD+QZfs/qV4ty2ttIfs9G4m63ztocRJGcj1A2uEGk0c
	pBiDs0PMOEg2qirWPWWz8fshhreH4IqD0OEw9+HUSMZwroIAFNbYCx26A+GrZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006588;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hZ0QxoJd15i42g4eBX3HNknZvatVunZZH44FhpcC3JY=;
	b=Bnh2a3nVdwz/fBCOFlqpRbwqsyqk48QosaHPFz4GuJMd26Qnc8SHHnfAdnaVuN77Qd3TyJ
	rvCG8SXzImB+lHCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/debugobjects] debugobjects: Dont destroy kmem cache in init()
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007164913.137021337@linutronix.de>
References: <20241007164913.137021337@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900658812.1442.13311113539403919906.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     55fb412ef7d0c33226fcac4ebc68c60282e5f150
Gitweb:        https://git.kernel.org/tip/55fb412ef7d0c33226fcac4ebc68c60282e5f150
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 07 Oct 2024 18:49:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:30:30 +02:00

debugobjects: Dont destroy kmem cache in init()

debug_objects_mem_init() is invoked from mm_core_init() before work queues
are available. If debug_objects_mem_init() destroys the kmem cache in the
error path it causes an Oops in __queue_work():

 Oops: Oops: 0000 [#1] PREEMPT SMP PTI
 RIP: 0010:__queue_work+0x35/0x6a0
  queue_work_on+0x66/0x70
  flush_all_cpus_locked+0xdf/0x1a0
  __kmem_cache_shutdown+0x2f/0x340
  kmem_cache_destroy+0x4e/0x150
  mm_core_init+0x9e/0x120
  start_kernel+0x298/0x800
  x86_64_start_reservations+0x18/0x30
  x86_64_start_kernel+0xc5/0xe0
  common_startup_64+0x12c/0x138

Further the object cache pointer is used in various places to check for
early boot operation. It is exposed before the replacments for the static
boot time objects are allocated and the self test operates on it.

This can be avoided by:

     1) Running the self test with the static boot objects

     2) Exposing it only after the replacement objects have been added to
     	the pool.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241007164913.137021337@linutronix.de

---
 lib/debugobjects.c | 68 +++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 798ce5a..1f6bf0f 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1211,7 +1211,7 @@ static __initconst const struct debug_obj_descr descr_type_test = {
 
 static __initdata struct self_test obj = { .static_init = 0 };
 
-static void __init debug_objects_selftest(void)
+static bool __init debug_objects_selftest(void)
 {
 	int fixups, oldfixups, warnings, oldwarnings;
 	unsigned long flags;
@@ -1280,9 +1280,10 @@ out:
 	descr_test = NULL;
 
 	local_irq_restore(flags);
+	return !!debug_objects_enabled;
 }
 #else
-static inline void debug_objects_selftest(void) { }
+static inline bool debug_objects_selftest(void) { return true; }
 #endif
 
 /*
@@ -1302,18 +1303,21 @@ void __init debug_objects_early_init(void)
 }
 
 /*
- * Convert the statically allocated objects to dynamic ones:
+ * Convert the statically allocated objects to dynamic ones.
+ * debug_objects_mem_init() is called early so only one CPU is up and
+ * interrupts are disabled, which means it is safe to replace the active
+ * object references.
  */
-static int __init debug_objects_replace_static_objects(void)
+static bool __init debug_objects_replace_static_objects(struct kmem_cache *cache)
 {
 	struct debug_bucket *db = obj_hash;
-	struct hlist_node *tmp;
 	struct debug_obj *obj, *new;
+	struct hlist_node *tmp;
 	HLIST_HEAD(objects);
 	int i, cnt = 0;
 
 	for (i = 0; i < ODEBUG_POOL_SIZE; i++) {
-		obj = kmem_cache_zalloc(obj_cache, GFP_KERNEL);
+		obj = kmem_cache_zalloc(cache, GFP_KERNEL);
 		if (!obj)
 			goto free;
 		hlist_add_head(&obj->node, &objects);
@@ -1322,12 +1326,6 @@ static int __init debug_objects_replace_static_objects(void)
 	debug_objects_allocated += i;
 
 	/*
-	 * debug_objects_mem_init() is now called early that only one CPU is up
-	 * and interrupts have been disabled, so it is safe to replace the
-	 * active object references.
-	 */
-
-	/*
 	 * Replace the statically allocated objects list with the allocated
 	 * objects list.
 	 */
@@ -1347,15 +1345,14 @@ static int __init debug_objects_replace_static_objects(void)
 		}
 	}
 
-	pr_debug("%d of %d active objects replaced\n",
-		 cnt, obj_pool_used);
-	return 0;
+	pr_debug("%d of %d active objects replaced\n", cnt, obj_pool_used);
+	return true;
 free:
 	hlist_for_each_entry_safe(obj, tmp, &objects, node) {
 		hlist_del(&obj->node);
-		kmem_cache_free(obj_cache, obj);
+		kmem_cache_free(cache, obj);
 	}
-	return -ENOMEM;
+	return false;
 }
 
 /*
@@ -1366,6 +1363,7 @@ free:
  */
 void __init debug_objects_mem_init(void)
 {
+	struct kmem_cache *cache;
 	int cpu, extras;
 
 	if (!debug_objects_enabled)
@@ -1380,29 +1378,33 @@ void __init debug_objects_mem_init(void)
 	for_each_possible_cpu(cpu)
 		INIT_HLIST_HEAD(&per_cpu(percpu_obj_pool.free_objs, cpu));
 
-	obj_cache = kmem_cache_create("debug_objects_cache",
-				      sizeof (struct debug_obj), 0,
-				      SLAB_DEBUG_OBJECTS | SLAB_NOLEAKTRACE,
-				      NULL);
+	if (!debug_objects_selftest())
+		return;
 
-	if (!obj_cache || debug_objects_replace_static_objects()) {
+	cache = kmem_cache_create("debug_objects_cache", sizeof (struct debug_obj), 0,
+				  SLAB_DEBUG_OBJECTS | SLAB_NOLEAKTRACE, NULL);
+
+	if (!cache || !debug_objects_replace_static_objects(cache)) {
 		debug_objects_enabled = 0;
-		kmem_cache_destroy(obj_cache);
-		pr_warn("out of memory.\n");
+		pr_warn("Out of memory.\n");
 		return;
-	} else
-		debug_objects_selftest();
-
-#ifdef CONFIG_HOTPLUG_CPU
-	cpuhp_setup_state_nocalls(CPUHP_DEBUG_OBJ_DEAD, "object:offline", NULL,
-					object_cpu_offline);
-#endif
+	}
 
 	/*
-	 * Increase the thresholds for allocating and freeing objects
-	 * according to the number of possible CPUs available in the system.
+	 * Adjust the thresholds for allocating and freeing objects
+	 * according to the number of possible CPUs available in the
+	 * system.
 	 */
 	extras = num_possible_cpus() * ODEBUG_BATCH_SIZE;
 	debug_objects_pool_size += extras;
 	debug_objects_pool_min_level += extras;
+
+	/* Everything worked. Expose the cache */
+	obj_cache = cache;
+
+#ifdef CONFIG_HOTPLUG_CPU
+	cpuhp_setup_state_nocalls(CPUHP_DEBUG_OBJ_DEAD, "object:offline", NULL,
+				  object_cpu_offline);
+#endif
+	return;
 }

