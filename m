Return-Path: <linux-tip-commits+bounces-4246-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE17A64A14
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F283B7A50CD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C64214A8F;
	Mon, 17 Mar 2025 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WR1tQ335";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o4LK5WNZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748E223372E;
	Mon, 17 Mar 2025 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207651; cv=none; b=HZu8hAMrS7dnD6ImB4BVsYn2afEn7n/Xr211y1DOtBB+OTOnUfCAz+iN4BMKssJO8mF//t7Z6QL3AjSkbF2ys8sAEIgr9zWkUi/tr+Q6jIX0plzOocIucT2vmyFboe1RajGCfQ/iIOBi8TsFqQ5Gtjf7jiYz5LKT3BL/oZ6DQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207651; c=relaxed/simple;
	bh=tbiSkS69aCxzFgpL2gATuHXc9q4hYIei8I00mzn6Hy0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PyIFyoTab3Rackq+ErbnOVIpAIUSUFGX/ahxfYGMTQzKYdvfg5z2QQ0IXaMepRFlai5Gd31ycci1ENccmj1NrzdEMSZNDQydLn9z8HX1HIasDK79uHXDSbScRUd53hV5sPT2DDqSOsJfmS1Gb/5bSWbn73uTA5qyjZkWZtiEROw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WR1tQ335; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o4LK5WNZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:34:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742207647;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+6Sy2qsehKOzJXmsCSUfa1j7+taABmNgp/EPqzpitY=;
	b=WR1tQ335vmhRwaUJKaahoRXLWXym7D5ShDkuod2J9cv4L3ecCxp8IFX2vGoP2KtEkSWTSR
	j/yApCyfk+H23b5ewTTSTVVYqsaZwUpwnf0eA0yaXUNWGDnfD6q67QjLQCyYIzNhffApVA
	bK2mp51+Ml6+cnlSGtTYTyQrrb8Cp5B62NeccZxAaaP7gfcrGjt9RFEMe8cSKyNAXhTvqM
	5qxXR5tyIHDKW01O/vxA5HNAUOiwISTcuCK0HhuISecc1HMy/nCC09RRnsD2LTWAMq6VsN
	iPLgkutmL/OeYpJZgN4zfeVuU1QKarETGxGeUq1rIQ9/+WzbmGzc+D7Oa7+7kQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742207647;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x+6Sy2qsehKOzJXmsCSUfa1j7+taABmNgp/EPqzpitY=;
	b=o4LK5WNZk+ykZI/7FQjboebPbcztfAfEeIaf11coK8U5gGukX/+nZ0IL77oCzCzTVru4Op
	KhmT2fltF6Dvl8BA==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Clean up pmu specific data
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250314172700.438923-7-kan.liang@linux.intel.com>
References: <20250314172700.438923-7-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220764346.14745.16608046702217766458.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     bd2da08d9363d191551d79e5b04121348e18af5a
Gitweb:        https://git.kernel.org/tip/bd2da08d9363d191551d79e5b04121348e18af5a
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 14 Mar 2025 10:27:00 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:23:38 +01:00

perf: Clean up pmu specific data

The pmu specific data is saved in task_struct now. Remove it from event
context structure.

Remove swap_task_ctx() as well.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250314172700.438923-7-kan.liang@linux.intel.com
---
 include/linux/perf_event.h | 12 +------
 kernel/events/core.c       | 76 +------------------------------------
 2 files changed, 3 insertions(+), 85 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 58f40c8..5b8e3aa 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -502,16 +502,6 @@ struct pmu {
 	struct kmem_cache		*task_ctx_cache;
 
 	/*
-	 * PMU specific parts of task perf event context (i.e. ctx->task_ctx_data)
-	 * can be synchronized using this function. See Intel LBR callstack support
-	 * implementation and Perf core context switch handling callbacks for usage
-	 * examples.
-	 */
-	void (*swap_task_ctx)		(struct perf_event_pmu_context *prev_epc,
-					 struct perf_event_pmu_context *next_epc);
-					/* optional */
-
-	/*
 	 * Set up pmu-private data structures for an AUX area
 	 */
 	void *(*setup_aux)		(struct perf_event *event, void **pages,
@@ -933,7 +923,6 @@ struct perf_event_pmu_context {
 	atomic_t			refcount; /* event <-> epc */
 	struct rcu_head			rcu_head;
 
-	void				*task_ctx_data; /* pmu specific data */
 	/*
 	 * Set when one or more (plausibly active) event can't be scheduled
 	 * due to pmu overcommit or pmu constraints, except tolerant to
@@ -981,7 +970,6 @@ struct perf_event_context {
 	int				nr_user;
 	int				is_active;
 
-	int				nr_task_data;
 	int				nr_stat;
 	int				nr_freq;
 	int				rotate_disable;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9928292..4ce9795 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1254,20 +1254,6 @@ static void get_ctx(struct perf_event_context *ctx)
 	refcount_inc(&ctx->refcount);
 }
 
-static void *alloc_task_ctx_data(struct pmu *pmu)
-{
-	if (pmu->task_ctx_cache)
-		return kmem_cache_zalloc(pmu->task_ctx_cache, GFP_KERNEL);
-
-	return NULL;
-}
-
-static void free_task_ctx_data(struct pmu *pmu, void *task_ctx_data)
-{
-	if (pmu->task_ctx_cache && task_ctx_data)
-		kmem_cache_free(pmu->task_ctx_cache, task_ctx_data);
-}
-
 static void free_ctx(struct rcu_head *head)
 {
 	struct perf_event_context *ctx;
@@ -3577,42 +3563,6 @@ static void perf_event_sync_stat(struct perf_event_context *ctx,
 	}
 }
 
-#define double_list_for_each_entry(pos1, pos2, head1, head2, member)	\
-	for (pos1 = list_first_entry(head1, typeof(*pos1), member),	\
-	     pos2 = list_first_entry(head2, typeof(*pos2), member);	\
-	     !list_entry_is_head(pos1, head1, member) &&		\
-	     !list_entry_is_head(pos2, head2, member);			\
-	     pos1 = list_next_entry(pos1, member),			\
-	     pos2 = list_next_entry(pos2, member))
-
-static void perf_event_swap_task_ctx_data(struct perf_event_context *prev_ctx,
-					  struct perf_event_context *next_ctx)
-{
-	struct perf_event_pmu_context *prev_epc, *next_epc;
-
-	if (!prev_ctx->nr_task_data)
-		return;
-
-	double_list_for_each_entry(prev_epc, next_epc,
-				   &prev_ctx->pmu_ctx_list, &next_ctx->pmu_ctx_list,
-				   pmu_ctx_entry) {
-
-		if (WARN_ON_ONCE(prev_epc->pmu != next_epc->pmu))
-			continue;
-
-		/*
-		 * PMU specific parts of task perf context can require
-		 * additional synchronization. As an example of such
-		 * synchronization see implementation details of Intel
-		 * LBR call stack data profiling;
-		 */
-		if (prev_epc->pmu->swap_task_ctx)
-			prev_epc->pmu->swap_task_ctx(prev_epc, next_epc);
-		else
-			swap(prev_epc->task_ctx_data, next_epc->task_ctx_data);
-	}
-}
-
 static void perf_ctx_sched_task_cb(struct perf_event_context *ctx,
 				   struct task_struct *task, bool sched_in)
 {
@@ -3687,16 +3637,15 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 			WRITE_ONCE(next_ctx->task, task);
 
 			perf_ctx_sched_task_cb(ctx, task, false);
-			perf_event_swap_task_ctx_data(ctx, next_ctx);
 
 			perf_ctx_enable(ctx, false);
 
 			/*
 			 * RCU_INIT_POINTER here is safe because we've not
 			 * modified the ctx and the above modification of
-			 * ctx->task and ctx->task_ctx_data are immaterial
-			 * since those values are always verified under
-			 * ctx->lock which we're now holding.
+			 * ctx->task is immaterial since this value is
+			 * always verified under ctx->lock which we're now
+			 * holding.
 			 */
 			RCU_INIT_POINTER(task->perf_event_ctxp, next_ctx);
 			RCU_INIT_POINTER(next->perf_event_ctxp, ctx);
@@ -5005,7 +4954,6 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 		     struct perf_event *event)
 {
 	struct perf_event_pmu_context *new = NULL, *pos = NULL, *epc;
-	void *task_ctx_data = NULL;
 
 	if (!ctx->task) {
 		/*
@@ -5038,14 +4986,6 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 	if (!new)
 		return ERR_PTR(-ENOMEM);
 
-	if (event->attach_state & PERF_ATTACH_TASK_DATA) {
-		task_ctx_data = alloc_task_ctx_data(pmu);
-		if (!task_ctx_data) {
-			kfree(new);
-			return ERR_PTR(-ENOMEM);
-		}
-	}
-
 	__perf_init_event_pmu_context(new, pmu);
 
 	/*
@@ -5080,14 +5020,7 @@ find_get_pmu_context(struct pmu *pmu, struct perf_event_context *ctx,
 	epc->ctx = ctx;
 
 found_epc:
-	if (task_ctx_data && !epc->task_ctx_data) {
-		epc->task_ctx_data = task_ctx_data;
-		task_ctx_data = NULL;
-		ctx->nr_task_data++;
-	}
 	raw_spin_unlock_irq(&ctx->lock);
-
-	free_task_ctx_data(pmu, task_ctx_data);
 	kfree(new);
 
 	return epc;
@@ -5103,7 +5036,6 @@ static void free_cpc_rcu(struct rcu_head *head)
 	struct perf_cpu_pmu_context *cpc =
 		container_of(head, typeof(*cpc), epc.rcu_head);
 
-	kfree(cpc->epc.task_ctx_data);
 	kfree(cpc);
 }
 
@@ -5111,7 +5043,6 @@ static void free_epc_rcu(struct rcu_head *head)
 {
 	struct perf_event_pmu_context *epc = container_of(head, typeof(*epc), rcu_head);
 
-	kfree(epc->task_ctx_data);
 	kfree(epc);
 }
 
@@ -14103,7 +14034,6 @@ inherit_event(struct perf_event *parent_event,
 	if (is_orphaned_event(parent_event) ||
 	    !atomic_long_inc_not_zero(&parent_event->refcount)) {
 		mutex_unlock(&parent_event->child_mutex);
-		/* task_ctx_data is freed with child_ctx */
 		free_event(child_event);
 		return NULL;
 	}

