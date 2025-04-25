Return-Path: <linux-tip-commits+bounces-5122-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B56A9C636
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Apr 2025 12:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FE537A2E85
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Apr 2025 10:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C141A315C;
	Fri, 25 Apr 2025 10:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YBKnTDLF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iSiDXS6g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D512239594;
	Fri, 25 Apr 2025 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745578256; cv=none; b=nptdSEBzyOo0toTdyT58ZBZ39gHxyoGX/SY2IQMiShhEZugVog9lpC4vPxMKz9Lpj6hThJPuh2+qaySwXqH4aexnQAKiNVj+e7fjvBlrl9cNHyuAE/eqRAbtK+B78/wMXpAcWMSSC3+7bNQ77Tp+AbXJXl4dY6o7d/2TMWYoN/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745578256; c=relaxed/simple;
	bh=DPZ6HZui1ABRBSG8E9NmPvfEQBfVvoYdGJCPj2flWhc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YxK/N0vnjlCLl//uBQiUROfvy98NqEaefZqWqt4VbwwvG+Yq9OpwHXtdGORpm+/Zs27ll5tc1aPQIU4hVHD3B7EScc9uc46sLD8gvjdTxzZNWRIyQ0J1x3XUU+sS1YPcMc4qQs2mz0bMF4zHFAmtd9+9oM9+pgvdcCtys8zA1Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YBKnTDLF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iSiDXS6g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Apr 2025 10:50:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745578250;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2jpfPouR8EoVbhH7bWzTACrlp689oj6iwoqFHGd4uw=;
	b=YBKnTDLFxgZZdw91fE1+bhB33k8uOmM2JDyk40CrCsLtArju48zDrkKIOHRazB98cNPFiy
	Z2tBi8/xX7z76ULgg0Z0tSkmb8Ov+yfSSyF/vTA+P6bP0EVeEpnJtZIrJeRYAW3QP2YYPE
	DjbuXNB1GMvR6kJy5fZlmla3wJiM5/ryS0l/cJZKDOysej+CSJoUJy6eCzksxZoEfVIvEO
	1FMQ0IJWCIM7PsBGRSG9IvRPAZUhmVVDW5m12jMzYo7syhUcjPjwsE+2QL3sdXofa5o19d
	hW3I1ODlBRVtBv76JzZVvQEmV27mC3hf3mK7vtKZZ8SR1YVgxlIsFqobnrR4xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745578250;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2jpfPouR8EoVbhH7bWzTACrlp689oj6iwoqFHGd4uw=;
	b=iSiDXS6g4m5ivwXBeYeb6dakzRV524e1Hq7BWZqwvVQ7A/PqRkXXA5r9bi2opgum8JjGwX
	pGJT6wYosywgD9BQ==
From: "tip-bot2 for Omar Sandoval" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/eevdf: Fix se->slice being set to U64_MAX
 and resulting crash
Cc: Omar Sandoval <osandov@fb.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <f0c2d1072be229e1bdddc73c0703919a8b00c652.1745570998.git.osandov@fb.com>
References:
 <f0c2d1072be229e1bdddc73c0703919a8b00c652.1745570998.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174557824492.31282.14439230781101331961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     26d3fb67f5dc8acc881365a618c219540d1d99a3
Gitweb:        https://git.kernel.org/tip/26d3fb67f5dc8acc881365a618c219540d1d99a3
Author:        Omar Sandoval <osandov@fb.com>
AuthorDate:    Fri, 25 Apr 2025 01:51:24 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Apr 2025 12:44:11 +02:00

sched/eevdf: Fix se->slice being set to U64_MAX and resulting crash

There is a code path in dequeue_entities() that can set the slice of a
sched_entity to U64_MAX, which sometimes results in a crash.

The offending case is when dequeue_entities() is called to dequeue a
delayed group entity, and then the entity's parent's dequeue is delayed.
In that case:

1. In the if (entity_is_task(se)) else block at the beginning of
   dequeue_entities(), slice is set to
   cfs_rq_min_slice(group_cfs_rq(se)). If the entity was delayed, then
   it has no queued tasks, so cfs_rq_min_slice() returns U64_MAX.
2. The first for_each_sched_entity() loop dequeues the entity.
3. If the entity was its parent's only child, then the next iteration
   tries to dequeue the parent.
4. If the parent's dequeue needs to be delayed, then it breaks from the
   first for_each_sched_entity() loop _without updating slice_.
5. The second for_each_sched_entity() loop sets the parent's ->slice to
   the saved slice, which is still U64_MAX.

This throws off subsequent calculations with potentially catastrophic
results. A manifestation we saw in production was:

6. In update_entity_lag(), se->slice is used to calculate limit, which
   ends up as a huge negative number.
7. limit is used in se->vlag = clamp(vlag, -limit, limit). Because limit
   is negative, vlag > limit, so se->vlag is set to the same huge
   negative number.
8. In place_entity(), se->vlag is scaled, which overflows and results in
   another huge (positive or negative) number.
9. The adjusted lag is subtracted from se->vruntime, which increases or
   decreases se->vruntime by a huge number.
10. pick_eevdf() calls entity_eligible()/vruntime_eligible(), which
    incorrectly returns false because the vruntime is so far from the
    other vruntimes on the queue, causing the
    (vruntime - cfs_rq->min_vruntime) * load calulation to overflow.
11. Nothing appears to be eligible, so pick_eevdf() returns NULL.
12. pick_next_entity() tries to dereference the return value of
    pick_eevdf() and crashes.

Dumping the cfs_rq states from the core dumps with drgn showed tell-tale
huge vruntime ranges and bogus vlag values, and I also traced se->slice
being set to U64_MAX on live systems (which was usually "benign" since
the rest of the runqueue needed to be in a particular state to crash).

Fix it in dequeue_entities() by always setting slice from the first
non-empty cfs_rq.

Fixes: aef6987d8954 ("sched/eevdf: Propagate min_slice up the cgroup hierarchy")
Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/f0c2d1072be229e1bdddc73c0703919a8b00c652.1745570998.git.osandov@fb.com
---
 kernel/sched/fair.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e43993a..0fb9bf9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7081,9 +7081,6 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		h_nr_idle = task_has_idle_policy(p);
 		if (task_sleep || task_delayed || !se->sched_delayed)
 			h_nr_runnable = 1;
-	} else {
-		cfs_rq = group_cfs_rq(se);
-		slice = cfs_rq_min_slice(cfs_rq);
 	}
 
 	for_each_sched_entity(se) {
@@ -7093,6 +7090,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 			if (p && &p->se == se)
 				return -1;
 
+			slice = cfs_rq_min_slice(cfs_rq);
 			break;
 		}
 

