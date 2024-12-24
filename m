Return-Path: <linux-tip-commits+bounces-3141-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D6D9FC183
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 19:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2A4165AC5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 18:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E752144D9;
	Tue, 24 Dec 2024 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fywm/3Kk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lGBwdu/s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2829213247;
	Tue, 24 Dec 2024 18:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066484; cv=none; b=Z73YW0Mq7ICt/jIiJ4+Zgp75jd0IO9ORdaQ0S+3stHORQ6O3SWSb+o+ZWpDsy3O0jywYGen58X/C1I+1QMvG/jhODoNSNNTAxWDVnJUFHa6xI4iJMIyjdVSj6hCjOhvb+dmHQeOJcHh91oOnYLGuLxmRC9uI0gMwr/uUJUpKaHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066484; c=relaxed/simple;
	bh=DTgtPgHtx83ih7HyFaXBBlxGQVEe4i+8K0l5xqP06ig=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KFM7wBwJgnijO8zejxZTg1MQ6yFzG2mwAetJlFgwtCLJ25jlbzVjIDvXf2YOfaJzx3llg79iWa98dtuhBe8R2WKkHD3ggAwawSbtPBrCDRoMhkdmu5fjHyEyRRAcyVqr5qK29non2p5jlRgzSCFPOCH08U3G7p+7Q3Q0Q1FTrHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fywm/3Kk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lGBwdu/s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 18:54:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735066481;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tbz9k9GiCYddFPen5o1YEwaMKRi1LddttwjPKkCjHhs=;
	b=Fywm/3KkYbypUqXe0oaPrq2uq76eaOjMFv1eoLc5vEBqOeM8zYGlGbSVFmxYVi4UKzLnKo
	29215Crow7vwoDSh+PS6SYuzvsrSLIo/hIkwVlod6IgVYMY5+wFLOPPjTedAw8T+/tET3E
	zqlvCb/lSRMdSQx4Btlqcr986OlTQ40zo+FmupwlprMF54LfrMQrhZmAPgZzrLSNsDLKFj
	75bTe0pkc/3qGeC4D7WyLydOKRvbvicunnrsc0Sgs5aMSSqITOvDdJ4ASbR672IdXwO+ye
	1nhCW07cIhQv/2vsPzGodgYrYe6b7fYnD7BUsXSkjHJPBYijq1ZzWIug5fHTiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735066481;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tbz9k9GiCYddFPen5o1YEwaMKRi1LddttwjPKkCjHhs=;
	b=lGBwdu/sHlKfb3/rJf8zSq3C71eE21ISdfpKYMKNC4imsa9bsOi65NVWU3zzFI4Wak6qFK
	+7+NIinKR/PvL6AQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Cleanup in migrate_degrades_locality()
 to improve readability
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241220063224.17767-3-swapnil.sapkal@amd.com>
References: <20241220063224.17767-3-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173506648087.399.1915784128184569804.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c3856c9ce6b8903909b61e8d2985a3c7ec7a78e8
Gitweb:        https://git.kernel.org/tip/c3856c9ce6b8903909b61e8d2985a3c7ec7a78e8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 20 Dec 2024 06:32:20 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Dec 2024 15:31:17 +01:00

sched/fair: Cleanup in migrate_degrades_locality() to improve readability

migrate_degrade_locality() would return {1, 0, -1} respectively to
indicate that migration would degrade-locality, would improve
locality, would be ambivalent to locality improvements.

This patch improves readability by changing the return value to mean:
* Any positive value degrades locality
* 0 migration doesn't affect locality
* Any negative value improves locality

[Swapnil: Fixed comments around code and wrote commit log]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241220063224.17767-3-swapnil.sapkal@amd.com
---
 kernel/sched/fair.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8fc6648..e5c0c61 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9329,43 +9329,43 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 
 #ifdef CONFIG_NUMA_BALANCING
 /*
- * Returns 1, if task migration degrades locality
- * Returns 0, if task migration improves locality i.e migration preferred.
- * Returns -1, if task migration is not affected by locality.
+ * Returns a positive value, if task migration degrades locality.
+ * Returns 0, if task migration is not affected by locality.
+ * Returns a negative value, if task migration improves locality i.e migration preferred.
  */
-static int migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
+static long migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 {
 	struct numa_group *numa_group = rcu_dereference(p->numa_group);
 	unsigned long src_weight, dst_weight;
 	int src_nid, dst_nid, dist;
 
 	if (!static_branch_likely(&sched_numa_balancing))
-		return -1;
+		return 0;
 
 	if (!p->numa_faults || !(env->sd->flags & SD_NUMA))
-		return -1;
+		return 0;
 
 	src_nid = cpu_to_node(env->src_cpu);
 	dst_nid = cpu_to_node(env->dst_cpu);
 
 	if (src_nid == dst_nid)
-		return -1;
+		return 0;
 
 	/* Migrating away from the preferred node is always bad. */
 	if (src_nid == p->numa_preferred_nid) {
 		if (env->src_rq->nr_running > env->src_rq->nr_preferred_running)
 			return 1;
 		else
-			return -1;
+			return 0;
 	}
 
 	/* Encourage migration to the preferred node. */
 	if (dst_nid == p->numa_preferred_nid)
-		return 0;
+		return -1;
 
 	/* Leaving a core idle is often worse than degrading locality. */
 	if (env->idle == CPU_IDLE)
-		return -1;
+		return 0;
 
 	dist = node_distance(src_nid, dst_nid);
 	if (numa_group) {
@@ -9376,14 +9376,14 @@ static int migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 		dst_weight = task_weight(p, dst_nid, dist);
 	}
 
-	return dst_weight < src_weight;
+	return src_weight - dst_weight;
 }
 
 #else
-static inline int migrate_degrades_locality(struct task_struct *p,
+static inline long migrate_degrades_locality(struct task_struct *p,
 					     struct lb_env *env)
 {
-	return -1;
+	return 0;
 }
 #endif
 
@@ -9393,7 +9393,7 @@ static inline int migrate_degrades_locality(struct task_struct *p,
 static
 int can_migrate_task(struct task_struct *p, struct lb_env *env)
 {
-	int tsk_cache_hot;
+	long degrades, hot;
 
 	lockdep_assert_rq_held(env->src_rq);
 	if (p->sched_task_hot)
@@ -9468,13 +9468,14 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if (env->flags & LBF_ACTIVE_LB)
 		return 1;
 
-	tsk_cache_hot = migrate_degrades_locality(p, env);
-	if (tsk_cache_hot == -1)
-		tsk_cache_hot = task_hot(p, env);
+	degrades = migrate_degrades_locality(p, env);
+	if (!degrades)
+		hot = task_hot(p, env);
+	else
+		hot = degrades > 0;
 
-	if (tsk_cache_hot <= 0 ||
-	    env->sd->nr_balance_failed > env->sd->cache_nice_tries) {
-		if (tsk_cache_hot == 1)
+	if (!hot || env->sd->nr_balance_failed > env->sd->cache_nice_tries) {
+		if (hot)
 			p->sched_task_hot = 1;
 		return 1;
 	}

