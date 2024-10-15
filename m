Return-Path: <linux-tip-commits+bounces-2428-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE5C99F185
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BAD51C21FA7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B53227BB9;
	Tue, 15 Oct 2024 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="td3Kn64w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="niRDAUyM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A8520822B;
	Tue, 15 Oct 2024 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006590; cv=none; b=ShP6x6xuEUEUbd+p1glUJ/QWFTh2fYKO8d7+EZ5xSkcTo0kzuE9qqRErKTT3VLHglJ1Jl3yBTnAxtcZ/tUS/U+x/8FXdeXR5VsqHVN+orAw4TLzXlfbKX21HuEpyti9GILxEoC4NDpB8Bdd3VX3vr6aJzrb7S4SX1/xap2a+fbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006590; c=relaxed/simple;
	bh=MZFaRqloixscVLrvJm1KgbyFVgtR49u5AxMb/GmNlu8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jGehAvWMzMDF/1iRVd5+E6Q0Fxq6Kyo6k2xqQKcSpbiyY5GPa0K1zjyBA3J8g5ijGWgtivWF/w1wu3eF8c3KIpUfNpNvemqQgmac4zN7IkMdRIYeZImzal6quTOvqcgDJxcwYghSU5DPO4xxt/nhrrO3wI0D1g0eyh/cWGx17vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=td3Kn64w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=niRDAUyM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:36:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729006587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=csRrlzqAW/++i+GDHnLRV2kDOkMDpUefeQUIzRu//eM=;
	b=td3Kn64wRWMmJ+JgdvwrIh/3LyXpW6iC2WAbsLCsjMBxMk7HR7b1bBQ4u5BAnMavyWa5aZ
	NaSrJAMRrUk56eHJ6+VAbs8g4fdriSPbZADB0TJpBrmtMRZIcXdarNyBXTYh9jiRoelXnw
	9syjGKPieE4mfvP4Jg8IbHuCo48sxc4J2Vejnx3mpSwBggVamO00pLr8a1mE3OQ2pi7ezL
	b9LWQnJwhseN85c+13WozCfYsiuS045svZF2JUfpH2uTyZ2V/cBTfOsoTC/dwvKUqBvQ+b
	8UT4WP5RcBggxN0E6ihsE8IiM0LXCWHApnxMwHVI9N1/jszEEkRIzMlcM8sIQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=csRrlzqAW/++i+GDHnLRV2kDOkMDpUefeQUIzRu//eM=;
	b=niRDAUyMPIfgiucMwZeqWcWLrFSVNVZmMl0ImXpihyobq+tyPAwvsB4923vf+1cP1L+pDl
	gHRMJl7W3DOrSFDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Dont free objects directly on
 CPU hotplug
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Zhen Lei <thunder.leizhen@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007164913.263960570@linutronix.de>
References: <20241007164913.263960570@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900658689.1442.6290973730707769095.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     a2a702383e8baa22ee66ee60f1e036835a1ef42e
Gitweb:        https://git.kernel.org/tip/a2a702383e8baa22ee66ee60f1e036835a1ef42e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 07 Oct 2024 18:49:57 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:30:30 +02:00

debugobjects: Dont free objects directly on CPU hotplug

Freeing the per CPU pool of the unplugged CPU directly is suboptimal as the
objects can be reused in the real pool if there is room. Aside of that this
gets the accounting wrong.

Use the regular free path, which allows reuse and has the accounting correct.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
Link: https://lore.kernel.org/all/20241007164913.263960570@linutronix.de

---
 lib/debugobjects.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 9867412..a3d4c54 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -430,27 +430,28 @@ static void free_object(struct debug_obj *obj)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-static int object_cpu_offline(unsigned int cpu)
+static void put_objects(struct hlist_head *list)
 {
-	struct debug_percpu_free *percpu_pool;
 	struct hlist_node *tmp;
 	struct debug_obj *obj;
-	unsigned long flags;
 
-	/* Remote access is safe as the CPU is dead already */
-	percpu_pool = per_cpu_ptr(&percpu_obj_pool, cpu);
-	hlist_for_each_entry_safe(obj, tmp, &percpu_pool->free_objs, node) {
+	/*
+	 * Using free_object() puts the objects into reuse or schedules
+	 * them for freeing and it get's all the accounting correct.
+	 */
+	hlist_for_each_entry_safe(obj, tmp, list, node) {
 		hlist_del(&obj->node);
-		kmem_cache_free(obj_cache, obj);
+		free_object(obj);
 	}
+}
 
-	raw_spin_lock_irqsave(&pool_lock, flags);
-	obj_pool_used -= percpu_pool->obj_free;
-	debug_objects_freed += percpu_pool->obj_free;
-	raw_spin_unlock_irqrestore(&pool_lock, flags);
-
-	percpu_pool->obj_free = 0;
+static int object_cpu_offline(unsigned int cpu)
+{
+	/* Remote access is safe as the CPU is dead already */
+	struct debug_percpu_free *pcp = per_cpu_ptr(&percpu_obj_pool, cpu);
 
+	put_objects(&pcp->free_objs);
+	pcp->obj_free = 0;
 	return 0;
 }
 #endif

