Return-Path: <linux-tip-commits+bounces-2077-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F9A955B45
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 08:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61E81C210F0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 06:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C356977113;
	Sun, 18 Aug 2024 06:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kl1h7Sw0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sK49/bOG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D422210E9;
	Sun, 18 Aug 2024 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962197; cv=none; b=DuvDpH15OuVQ7MeyBZM7c+UdnQ2nJZ9cQn+0gJSaZZYB1WRJnLXlvb5Fwp7vPKG6hNRdm0b/lnmJ/xwR+juiNlwiP+PyD74M0j4u0kc3vlox+yML6wWc/43XUtvMjFw9xd9wB2HkAVYogleorkYVSaCVTv8dJpJ/mJ2hhKPxMV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962197; c=relaxed/simple;
	bh=YxzQv9365LnAFQta1DyoS37F1SN6VBN5OWZDI3dQy/c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nPPP5lGmvx4CwbDW0Dq8QUuxgdw0frCiaXWJrVoAEN5QXPs7uQfIziGNy9xMPmsXMId9f74VTQEohDE6Jkl4duYpCxnKgwapmXLx0dYsh5l27de6kBhMVxSE4wfbhcB/FaEAz26WQBatSDx8sSnm4BEF0x7ZWhPBqqlCX6IDv7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kl1h7Sw0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sK49/bOG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Aug 2024 06:23:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723962191;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLmVnhkKvLZsf12glmULHgXX/TqfYx0IE9/M9ckZv9o=;
	b=Kl1h7Sw0e+bJStDYLry+jHbvrnPyfAUpPuQuzywft270VG2kRMlwsw+dsxHZYgcJFR4oqs
	cGRpgyZqAkie1rQtNNy/bn9z+45gnEdn5b7bDd3dfna6BhlpYeE8WyCCqI4GNRvL6HdwKD
	vgY5LSHobOPb+mfxnClzqnZb1krMAk3JrSRxZMClFG8ZweN4WLn7w2AdUsTuOnZGYEvapF
	TM8ImGx+tWUolnmCE4ZnVZA9emucL9eWKYK3y/mpwshvAnelt5AHN9WhOvlKxLzKrxWmge
	gRWAq1QP8UPExgU0sBtxP1n2QcX3O+rOZks8RikG6mBi86iZmGtUga2DOgyWrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723962191;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLmVnhkKvLZsf12glmULHgXX/TqfYx0IE9/M9ckZv9o=;
	b=sK49/bOGuxb/oOv5Hext+xD9U+hhOFlHKbFJPgj69CkQ21mQG+DVbmjQbAlPO8LWk0/Cby
	J3nsw2uTC10eBtAQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Unify pick_{,next_}_task_fair()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727105028.725062368@infradead.org>
References: <20240727105028.725062368@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172396219137.2215.16097733440119925350.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3b3dd89b8bb0f03657859c22c86c19224f778638
Gitweb:        https://git.kernel.org/tip/3b3dd89b8bb0f03657859c22c86c19224f778638
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 03 Apr 2024 09:50:16 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 17 Aug 2024 11:06:41 +02:00

sched/fair: Unify pick_{,next_}_task_fair()

Implement pick_next_task_fair() in terms of pick_task_fair() to
de-duplicate the pick loop.

More importantly, this makes all the pick loops use the
state-invariant form, which is useful to introduce further re-try
conditions in later patches.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/20240727105028.725062368@infradead.org
---
 kernel/sched/fair.c | 60 +++++---------------------------------------
 1 file changed, 8 insertions(+), 52 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 175ccec..1452c53 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8451,7 +8451,6 @@ preempt:
 	resched_curr(rq);
 }
 
-#ifdef CONFIG_SMP
 static struct task_struct *pick_task_fair(struct rq *rq)
 {
 	struct sched_entity *se;
@@ -8463,7 +8462,7 @@ again:
 		return NULL;
 
 	do {
-		/* When we pick for a remote RQ, we'll not have done put_prev_entity() */
+		/* Might not have done put_prev_entity() */
 		if (cfs_rq->curr && cfs_rq->curr->on_rq)
 			update_curr(cfs_rq);
 
@@ -8484,19 +8483,19 @@ again:
 
 	return task_of(se);
 }
-#endif
 
 struct task_struct *
 pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
-	struct cfs_rq *cfs_rq = &rq->cfs;
 	struct sched_entity *se;
 	struct task_struct *p;
 	int new_tasks;
 
 again:
-	if (!sched_fair_runnable(rq))
+	p = pick_task_fair(rq);
+	if (!p)
 		goto idle;
+	se = &p->se;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	if (!prev || prev->sched_class != &fair_sched_class)
@@ -8508,52 +8507,14 @@ again:
 	 *
 	 * Therefore attempt to avoid putting and setting the entire cgroup
 	 * hierarchy, only change the part that actually changes.
-	 */
-
-	do {
-		struct sched_entity *curr = cfs_rq->curr;
-
-		/*
-		 * Since we got here without doing put_prev_entity() we also
-		 * have to consider cfs_rq->curr. If it is still a runnable
-		 * entity, update_curr() will update its vruntime, otherwise
-		 * forget we've ever seen it.
-		 */
-		if (curr) {
-			if (curr->on_rq)
-				update_curr(cfs_rq);
-			else
-				curr = NULL;
-
-			/*
-			 * This call to check_cfs_rq_runtime() will do the
-			 * throttle and dequeue its entity in the parent(s).
-			 * Therefore the nr_running test will indeed
-			 * be correct.
-			 */
-			if (unlikely(check_cfs_rq_runtime(cfs_rq))) {
-				cfs_rq = &rq->cfs;
-
-				if (!cfs_rq->nr_running)
-					goto idle;
-
-				goto simple;
-			}
-		}
-
-		se = pick_next_entity(cfs_rq);
-		cfs_rq = group_cfs_rq(se);
-	} while (cfs_rq);
-
-	p = task_of(se);
-
-	/*
+	 *
 	 * Since we haven't yet done put_prev_entity and if the selected task
 	 * is a different task than we started out with, try and touch the
 	 * least amount of cfs_rqs.
 	 */
 	if (prev != p) {
 		struct sched_entity *pse = &prev->se;
+		struct cfs_rq *cfs_rq;
 
 		while (!(cfs_rq = is_same_group(se, pse))) {
 			int se_depth = se->depth;
@@ -8579,13 +8540,8 @@ simple:
 	if (prev)
 		put_prev_task(rq, prev);
 
-	do {
-		se = pick_next_entity(cfs_rq);
-		set_next_entity(cfs_rq, se);
-		cfs_rq = group_cfs_rq(se);
-	} while (cfs_rq);
-
-	p = task_of(se);
+	for_each_sched_entity(se)
+		set_next_entity(cfs_rq_of(se), se);
 
 done: __maybe_unused;
 #ifdef CONFIG_SMP

