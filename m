Return-Path: <linux-tip-commits+bounces-2057-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C312955B23
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 08:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8991F217EF
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 06:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D3AC8C7;
	Sun, 18 Aug 2024 06:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PXuCgwVb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FJBkwGuS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8754FD515;
	Sun, 18 Aug 2024 06:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962190; cv=none; b=I6/OZus9oJBs/OwikZjfbanUPndarKF3TH/iYJUuUt1+7kA27N7LuVhaHcpGwJkojvKf3SOxGBWCUNUO4qUxjsbfrNFYcReXRvipGCgIpdEnkbsLCI097RnnkXhlhQAHueNsXRAGYWA0AsRcagubGIjpb17cOx2MKiyf96b0kZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962190; c=relaxed/simple;
	bh=v452g5+XYCAEskfn79b0coyLuREekR8EczBitfHdQO8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=o3YvrXrTqToAoFcKNdVhUXTRtNVlFpdb8l/7ZXSPPR0PuJkbVs/ujnKZGHbQV4KIOfzpGgwS6mOWEyZgC7FLrfsoT164u7g6Q6Hhh4JZvAa6lWASubBPxus6akO80Xb9CnKx1OZTiLMnqpafApCOzeaisIGQqMZ59pGfusB3I+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PXuCgwVb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FJBkwGuS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Aug 2024 06:23:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723962186;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0+oOXkzWU58lBWC17sVrQoX8Q5qKW6L1Z+s1MmY7Ps=;
	b=PXuCgwVbaHPaLIbuGtfPPH4uJDLmpvB+u0JK/pvOVGDAYZpzgx6xiAEa/fxOI8VqCYNVQ1
	ZlWHJXDg+j45gHklVoiayoEP5s+ONcJGkKGRn3dOFq9sQLqfz+GQhEFjxnEK/YWpmZrw9K
	iV4Tibgo4dpG3hvW8fZ5ZL2rtfOVpgv/GrbKznEskxccvr2LpspIxSGSXL2AsdjfP0xocU
	kFl3dFRQl01bI2hyn+bFr26kskpCj3LsoI3gAeXcDkm8zxFU3SfWlBO8PV2qORTvKcbQ2Q
	s15K3i7DK34v3DV2pfW5ZFAtBv/cPExGPmcbVK5BJP3vxnC6rst43pHXxKSPtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723962186;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n0+oOXkzWU58lBWC17sVrQoX8Q5qKW6L1Z+s1MmY7Ps=;
	b=FJBkwGuSIe29TcSdIuhxRBpy45Gszvt9HHaGvCZ7ihpy9z1/l78+NXgl16sp2/bD3hfC/x
	ONpRzKeLLhZd1sAA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/eevdf: Propagate min_slice up the cgroup hierarchy
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727105030.948188417@infradead.org>
References: <20240727105030.948188417@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172396218582.2215.18076645488650391869.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     aef6987d89544d63a47753cf3741cabff0b5574c
Gitweb:        https://git.kernel.org/tip/aef6987d89544d63a47753cf3741cabff0b5574c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 20 Jun 2024 13:16:49 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 17 Aug 2024 11:06:46 +02:00

sched/eevdf: Propagate min_slice up the cgroup hierarchy

In the absence of an explicit cgroup slice configureation, make mixed
slice length work with cgroups by propagating the min_slice up the
hierarchy.

This ensures the cgroup entity gets timely service to service its
entities that have this timing constraint set on them.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/20240727105030.948188417@infradead.org
---
 include/linux/sched.h |  1 +-
 kernel/sched/fair.c   | 57 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 89a3d8d..3709ded 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -542,6 +542,7 @@ struct sched_entity {
 	struct rb_node			run_node;
 	u64				deadline;
 	u64				min_vruntime;
+	u64				min_slice;
 
 	struct list_head		group_node;
 	unsigned char			on_rq;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3284d3c..fea057b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -782,6 +782,21 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 	cfs_rq->min_vruntime = __update_min_vruntime(cfs_rq, vruntime);
 }
 
+static inline u64 cfs_rq_min_slice(struct cfs_rq *cfs_rq)
+{
+	struct sched_entity *root = __pick_root_entity(cfs_rq);
+	struct sched_entity *curr = cfs_rq->curr;
+	u64 min_slice = ~0ULL;
+
+	if (curr && curr->on_rq)
+		min_slice = curr->slice;
+
+	if (root)
+		min_slice = min(min_slice, root->min_slice);
+
+	return min_slice;
+}
+
 static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
 {
 	return entity_before(__node_2_se(a), __node_2_se(b));
@@ -798,19 +813,34 @@ static inline void __min_vruntime_update(struct sched_entity *se, struct rb_node
 	}
 }
 
+static inline void __min_slice_update(struct sched_entity *se, struct rb_node *node)
+{
+	if (node) {
+		struct sched_entity *rse = __node_2_se(node);
+		if (rse->min_slice < se->min_slice)
+			se->min_slice = rse->min_slice;
+	}
+}
+
 /*
  * se->min_vruntime = min(se->vruntime, {left,right}->min_vruntime)
  */
 static inline bool min_vruntime_update(struct sched_entity *se, bool exit)
 {
 	u64 old_min_vruntime = se->min_vruntime;
+	u64 old_min_slice = se->min_slice;
 	struct rb_node *node = &se->run_node;
 
 	se->min_vruntime = se->vruntime;
 	__min_vruntime_update(se, node->rb_right);
 	__min_vruntime_update(se, node->rb_left);
 
-	return se->min_vruntime == old_min_vruntime;
+	se->min_slice = se->slice;
+	__min_slice_update(se, node->rb_right);
+	__min_slice_update(se, node->rb_left);
+
+	return se->min_vruntime == old_min_vruntime &&
+	       se->min_slice == old_min_slice;
 }
 
 RB_DECLARE_CALLBACKS(static, min_vruntime_cb, struct sched_entity,
@@ -823,6 +853,7 @@ static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	avg_vruntime_add(cfs_rq, se);
 	se->min_vruntime = se->vruntime;
+	se->min_slice = se->slice;
 	rb_add_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
 				__entity_less, &min_vruntime_cb);
 }
@@ -6911,6 +6942,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	int idle_h_nr_running = task_has_idle_policy(p);
 	int task_new = !(flags & ENQUEUE_WAKEUP);
 	int rq_h_nr_running = rq->cfs.h_nr_running;
+	u64 slice = 0;
 
 	if (flags & ENQUEUE_DELAYED) {
 		requeue_delayed_entity(se);
@@ -6940,7 +6972,18 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			break;
 		}
 		cfs_rq = cfs_rq_of(se);
+
+		/*
+		 * Basically set the slice of group entries to the min_slice of
+		 * their respective cfs_rq. This ensures the group can service
+		 * its entities in the desired time-frame.
+		 */
+		if (slice) {
+			se->slice = slice;
+			se->custom_slice = 1;
+		}
 		enqueue_entity(cfs_rq, se, flags);
+		slice = cfs_rq_min_slice(cfs_rq);
 
 		cfs_rq->h_nr_running++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
@@ -6962,6 +7005,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		se_update_runnable(se);
 		update_cfs_group(se);
 
+		se->slice = slice;
+		slice = cfs_rq_min_slice(cfs_rq);
+
 		cfs_rq->h_nr_running++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 
@@ -7027,11 +7073,15 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 	int idle_h_nr_running = 0;
 	int h_nr_running = 0;
 	struct cfs_rq *cfs_rq;
+	u64 slice = 0;
 
 	if (entity_is_task(se)) {
 		p = task_of(se);
 		h_nr_running = 1;
 		idle_h_nr_running = task_has_idle_policy(p);
+	} else {
+		cfs_rq = group_cfs_rq(se);
+		slice = cfs_rq_min_slice(cfs_rq);
 	}
 
 	for_each_sched_entity(se) {
@@ -7056,6 +7106,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
+			slice = cfs_rq_min_slice(cfs_rq);
+
 			/* Avoid re-evaluating load for this entity: */
 			se = parent_entity(se);
 			/*
@@ -7077,6 +7129,9 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		se_update_runnable(se);
 		update_cfs_group(se);
 
+		se->slice = slice;
+		slice = cfs_rq_min_slice(cfs_rq);
+
 		cfs_rq->h_nr_running -= h_nr_running;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 

