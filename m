Return-Path: <linux-tip-commits+bounces-2430-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7910399F189
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A189C1C20AB6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A542281ED;
	Tue, 15 Oct 2024 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UYyDTvCD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ePjsqV1N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7411FC7DD;
	Tue, 15 Oct 2024 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006591; cv=none; b=BYF9wkxvJPp0SK1rYUXpgXvaXyOrRCG8PNRP5jPqBr7SJcBvl2t7PfJiXdixNqHtIRy0kzxUT5tg3p8p46SHexwY+e9A1L/ifNezKiXS+Blxp+FfruVzbZlCR5eHZEAF4e7PZaTUFukCF3nwSwOn+/H/s0suPPt7UnLv+lgXCGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006591; c=relaxed/simple;
	bh=28JF6r7TSR77n/aEQodJQXU0SAXd3J8s4EkNEQhwaFM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Jl/tZo4TkgxrQzNHVft1WMT/DINzR5tGdUiq9C2cgJP/ajI+4EFiGs0q9i1HAgw+ETckOjq04mR9irv0j24aEJVaemWoOZX0yW1bKkNFhAxgllJGOPABHSvdbSt9AE+MrwutGYRZLQklkyrkmckYfe48F627yg5pADYWcrt+6Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UYyDTvCD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ePjsqV1N; arc=none smtp.client-ip=193.142.43.55
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
	bh=zkEmYBMnycO82SxH6a6vU8FrDeyI0Et5+8u/KooIbpo=;
	b=UYyDTvCDFPKeK95MWIfvXWXrLMrg2mi2dmglW4nSKKUPtTdDUvvz5bxpWbUgCP4gf60zFx
	H0RQdiM7PIxpissxFjIqomBj119/xnnq0KlnyNEbTC2D58fkem/70y6ra5q3kObWwxVWwK
	YOGAHJ7KlYcE8YjlLU8b9QA5KnktfXGf4jymqVUIyWULzpW8p04tkktkxC0AaRbyyPMLyG
	lGHtmqrhyLwl1Av+EskgNnluLu8wVeZZApyIGDYrIWfl/5I+JN/7odwuql1EPBJ6urXbOJ
	OsY2iBhhg4OcRAwPBUhNKuHuUcIiNztgWQd+6j6B9BxJrJ7Hs0POw0pg4IMN4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkEmYBMnycO82SxH6a6vU8FrDeyI0Et5+8u/KooIbpo=;
	b=ePjsqV1NxxxywkAloriZyPyDKJOiskh5RPEMdIjepcRIhohYj/M8feZhivP67whnf1INIS
	XufC9xed1ssOk0CA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Reuse put_objects() on OOM
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Zhen Lei <thunder.leizhen@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007164913.326834268@linutronix.de>
References: <20241007164913.326834268@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900658629.1442.13518605210102205088.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     49968cf18154d6391e84c68520149232057ca62c
Gitweb:        https://git.kernel.org/tip/49968cf18154d6391e84c68520149232057ca62c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 07 Oct 2024 18:49:58 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:30:31 +02:00

debugobjects: Reuse put_objects() on OOM

Reuse the helper function instead of having a open coded copy.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
Link: https://lore.kernel.org/all/20241007164913.326834268@linutronix.de

---
 lib/debugobjects.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index a3d4c54..2c866d0 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -429,7 +429,6 @@ static void free_object(struct debug_obj *obj)
 	}
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static void put_objects(struct hlist_head *list)
 {
 	struct hlist_node *tmp;
@@ -445,6 +444,7 @@ static void put_objects(struct hlist_head *list)
 	}
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
 static int object_cpu_offline(unsigned int cpu)
 {
 	/* Remote access is safe as the CPU is dead already */
@@ -456,31 +456,19 @@ static int object_cpu_offline(unsigned int cpu)
 }
 #endif
 
-/*
- * We run out of memory. That means we probably have tons of objects
- * allocated.
- */
+/* Out of memory. Free all objects from hash */
 static void debug_objects_oom(void)
 {
 	struct debug_bucket *db = obj_hash;
-	struct hlist_node *tmp;
 	HLIST_HEAD(freelist);
-	struct debug_obj *obj;
-	unsigned long flags;
-	int i;
 
 	pr_warn("Out of memory. ODEBUG disabled\n");
 
-	for (i = 0; i < ODEBUG_HASH_SIZE; i++, db++) {
-		raw_spin_lock_irqsave(&db->lock, flags);
-		hlist_move_list(&db->list, &freelist);
-		raw_spin_unlock_irqrestore(&db->lock, flags);
+	for (int i = 0; i < ODEBUG_HASH_SIZE; i++, db++) {
+		scoped_guard(raw_spinlock_irqsave, &db->lock)
+			hlist_move_list(&db->list, &freelist);
 
-		/* Now free them */
-		hlist_for_each_entry_safe(obj, tmp, &freelist, node) {
-			hlist_del(&obj->node);
-			free_object(obj);
-		}
+		put_objects(&freelist);
 	}
 }
 

