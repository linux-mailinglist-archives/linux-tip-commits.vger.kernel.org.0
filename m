Return-Path: <linux-tip-commits+bounces-6061-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A6DB00252
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 14:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888381BC639D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 12:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F8D2877E7;
	Thu, 10 Jul 2025 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g+XmfBgP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="maYzpwTS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3C025F984;
	Thu, 10 Jul 2025 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151599; cv=none; b=qAmuhso9ooDExHgGDdMZw4Y0Ug9j8BmA+CgNRlj9wNklzisLITA6lebX9BuNLc/z71zjeKgxyDuz3dqrkmR1SCV3mCaYHdVzm7dpDn/9nO+nSS4B5PjuhrY4lxlM6uVzrU66RAW+Y+dlRG1yCd55EtNiSjYBgzqdcr6FdMded8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151599; c=relaxed/simple;
	bh=DC9J5FMYJFXtihIb52x7tvSDv9q8leBchQL+Ic3oecA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fb//pdas54cclCM+iPwZ2DGzAYjEDlJvjbDtZSk5h1oRBE/jNquakpujHrYe4mmWibHRNlh7UuJYe9Lj2xN89XtJhOxqXkLj6sBHbb1AB8AyBWaT4ra6E3ZIEZx4ywYJyNasJlEUKMHryOIzxvfvpzNDoOEU9uyXH5YO384LLlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g+XmfBgP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=maYzpwTS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 12:46:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752151594;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qe5fTmU611ihXrTzfSMOtpQCOZzzeJOLTsT5+Wbr0Bo=;
	b=g+XmfBgPtz9RnQnQ+RMXdDgPrT0G5E48EKcQDuIEvLNKIydkQMUuiaWdXPxg4V2bV0g6XP
	cIwdMreWAw9boKrqjjWO6D++o3IsiCj5Pyn9b/atprMejYi61Ueh2/IIUQPBnJcaEtUm6D
	Y1hOftnnM18q7WXDhHJrPCa7EtOxQ7zUUee2uyAyX+a0hD6GjKnY3Fo24RptCNyS460dVN
	eiZ0rY+aVmUuY+PG2yMRqXJBhQ4n9Xm5Ownraa1vWV7suHDPq7tuBG24izYWcJVUsvNzit
	xfU5uEO3zLoYoBQGfSJlXYd3ObfyLw/bNOgZJq0M2cqS/wSrpfLLuA2LJk0sYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752151594;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qe5fTmU611ihXrTzfSMOtpQCOZzzeJOLTsT5+Wbr0Bo=;
	b=maYzpwTS10lR7bF8JaeBree1+B++aoNos42lWq8GUOJ9JQ9O0Pj7pYq8GnmwvvTzwZe79I
	RhJqy/kGlOgKcIBQ==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Remove spurious shorter slice preemption
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250708165630.1948751-4-vincent.guittot@linaro.org>
References: <20250708165630.1948751-4-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175215159358.406.9236580210245372340.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9de74a9850b9468ac2f515bfbe0844e0bfae869d
Gitweb:        https://git.kernel.org/tip/9de74a9850b9468ac2f515bfbe0844e0bfae869d
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 08 Jul 2025 18:56:27 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Jul 2025 13:40:22 +02:00

sched/fair: Remove spurious shorter slice preemption

Even if the waking task can preempt current, it might not be the one
selected by pick_task_fair. Check that the waking task will be selected
if we cancel the slice protection before doing so.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250708165630.1948751-4-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 44 ++++++++++++++------------------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8d288df..96718b3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -932,7 +932,7 @@ static inline void cancel_protect_slice(struct sched_entity *se)
  *
  * Which allows tree pruning through eligibility.
  */
-static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
+static struct sched_entity *__pick_eevdf(struct cfs_rq *cfs_rq, bool protect)
 {
 	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
 	struct sched_entity *se = __pick_first_entity(cfs_rq);
@@ -949,7 +949,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
 		curr = NULL;
 
-	if (curr && protect_slice(curr))
+	if (curr && protect && protect_slice(curr))
 		return curr;
 
 	/* Pick the leftmost entity if it's eligible */
@@ -993,6 +993,11 @@ found:
 	return best;
 }
 
+static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
+{
+	return __pick_eevdf(cfs_rq, true);
+}
+
 struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
 {
 	struct rb_node *last = rb_last(&cfs_rq->tasks_timeline.rb_root);
@@ -1176,27 +1181,6 @@ static inline bool resched_next_slice(struct cfs_rq *cfs_rq, struct sched_entity
 	return !entity_eligible(cfs_rq, curr);
 }
 
-static inline bool do_preempt_short(struct cfs_rq *cfs_rq,
-				    struct sched_entity *pse, struct sched_entity *se)
-{
-	if (!sched_feat(PREEMPT_SHORT))
-		return false;
-
-	if (pse->slice >= se->slice)
-		return false;
-
-	if (!entity_eligible(cfs_rq, pse))
-		return false;
-
-	if (entity_before(pse, se))
-		return true;
-
-	if (!entity_eligible(cfs_rq, se))
-		return true;
-
-	return false;
-}
-
 /*
  * Used by other classes to account runtime.
  */
@@ -8658,6 +8642,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int 
 	struct sched_entity *se = &donor->se, *pse = &p->se;
 	struct cfs_rq *cfs_rq = task_cfs_rq(donor);
 	int cse_is_idle, pse_is_idle;
+	bool do_preempt_short = false;
 
 	if (unlikely(se == pse))
 		return;
@@ -8706,7 +8691,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int 
 		 * When non-idle entity preempt an idle entity,
 		 * don't give idle entity slice protection.
 		 */
-		cancel_protect_slice(se);
+		do_preempt_short = true;
 		goto preempt;
 	}
 
@@ -8724,22 +8709,21 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int 
 	/*
 	 * If @p has a shorter slice than current and @p is eligible, override
 	 * current's slice protection in order to allow preemption.
-	 *
-	 * Note that even if @p does not turn out to be the most eligible
-	 * task at this moment, current's slice protection will be lost.
 	 */
-	if (do_preempt_short(cfs_rq, pse, se))
-		cancel_protect_slice(se);
+	do_preempt_short = sched_feat(PREEMPT_SHORT) && (pse->slice < se->slice);
 
 	/*
 	 * If @p has become the most eligible task, force preemption.
 	 */
-	if (pick_eevdf(cfs_rq) == pse)
+	if (__pick_eevdf(cfs_rq, !do_preempt_short) == pse)
 		goto preempt;
 
 	return;
 
 preempt:
+	if (do_preempt_short)
+		cancel_protect_slice(se);
+
 	resched_curr_lazy(rq);
 }
 

