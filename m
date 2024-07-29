Return-Path: <linux-tip-commits+bounces-1801-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF22E93F2DC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 12:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFB4A1C203B1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 10:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7DD145B37;
	Mon, 29 Jul 2024 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k3qZEWkP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Of9tHNR1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521C714532D;
	Mon, 29 Jul 2024 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249251; cv=none; b=uZPFMZsU+1mXpZgG4dVWeu0Jc6BY/GMA3oW+KF29B5GCq0ME0+3I7VoGQTaxAU50goRnXfLhvt1RV/ncVNV7h64Hab4JnwLHpP/rl7zz0O8v8cNG569DtBvZckRpcay0zg8esKLuJMejcb/XDBYqOh/ZBPmXwuS2FddCA6gVadw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249251; c=relaxed/simple;
	bh=6KRNB7s0XBKUkjQvF0uHWhhZniC64aGkAhQp8xDN/kw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F9RW1U0RzggkNy9LDeUzRdqU3wuCku6Vs0s1V91oW+LD2u0Dduac4/Nm3gjSfE960JliFqoGToy/Q2zO35OFPq6LJmphFR7//vUcQVkhPJDToVqjxECvERPY69Ky/6w7ak47/1jSmtmlPq4AV5xV9sjciPXfjPuUGuSwFe+9Mw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k3qZEWkP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Of9tHNR1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:34:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722249246;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8a9GIUd146QY2xQn6jjhyc9q8K1xcZNbLabwnGoOl4=;
	b=k3qZEWkPePK2rwDkL3Q4OONm+SSvyEnQWg7J/Q17TP/MTkbzI+G0VB6FiLev7psQb+KEq6
	0pfNptcTgTlZvpRgKtLxnrghHcXI0ozjDuSCCmCKAod3PWZQt9R1lD3zHerv+8ecpAi4um
	BsytYCHY64lqsJw7zPsMB3Ilbw7fUrFZraT+Es/tFCfujsWvsRIuNsu5ahIpJEtHJK6oZM
	itGzBdiOo1lWdPLPrfTekXIpIllpjkdNR/FA51uIIFST5nrTv8bP5RLZzjt2/37BZoMhuJ
	ZlA0WWP1U1koT3iuhl1LDw9izzMH/XeT2eykzeiFDmCedM5Iz9+WyZcCNqPu6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722249246;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8a9GIUd146QY2xQn6jjhyc9q8K1xcZNbLabwnGoOl4=;
	b=Of9tHNR1RGA62VmaVObuhwn4z5kOMcOJfoB0Ez/rgyQ/9KuF4u4dYvVwbWsxCElVKFcB6o
	kD/E8+hLWr/Sk1Cw==
From: "tip-bot2 for Tianchen Ding" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Make SCHED_IDLE entity be preempted in
 strict hierarchy
Cc: Tianchen Ding <dtcccc@linux.alibaba.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Don <joshdon@google.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240626023505.1332596-1-dtcccc@linux.alibaba.com>
References: <20240626023505.1332596-1-dtcccc@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224924632.2215.7502536289804369136.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     faa42d29419def58d3c3e5b14ad4037f0af3b496
Gitweb:        https://git.kernel.org/tip/faa42d29419def58d3c3e5b14ad4037f0af3b496
Author:        Tianchen Ding <dtcccc@linux.alibaba.com>
AuthorDate:    Wed, 26 Jun 2024 10:35:05 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:22:35 +02:00

sched/fair: Make SCHED_IDLE entity be preempted in strict hierarchy

Consider the following cgroup:

                       root
                        |
             ------------------------
             |                      |
       normal_cgroup            idle_cgroup
             |                      |
   SCHED_IDLE task_A           SCHED_NORMAL task_B

According to the cgroup hierarchy, A should preempt B. But current
check_preempt_wakeup_fair() treats cgroup se and task separately, so B
will preempt A unexpectedly.
Unify the wakeup logic by {c,p}se_is_idle only. This makes SCHED_IDLE of
a task a relative policy that is effective only within its own cgroup,
similar to the behavior of NICE.

Also fix se_is_idle() definition when !CONFIG_FAIR_GROUP_SCHED.

Fixes: 304000390f88 ("sched: Cgroup SCHED_IDLE support")
Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Josh Don <joshdon@google.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20240626023505.1332596-1-dtcccc@linux.alibaba.com
---
 kernel/sched/fair.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02694fc..99c80ab 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -511,7 +511,7 @@ static int cfs_rq_is_idle(struct cfs_rq *cfs_rq)
 
 static int se_is_idle(struct sched_entity *se)
 {
-	return 0;
+	return task_has_idle_policy(task_of(se));
 }
 
 #endif	/* CONFIG_FAIR_GROUP_SCHED */
@@ -8381,16 +8381,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int 
 	if (test_tsk_need_resched(curr))
 		return;
 
-	/* Idle tasks are by definition preempted by non-idle tasks. */
-	if (unlikely(task_has_idle_policy(curr)) &&
-	    likely(!task_has_idle_policy(p)))
-		goto preempt;
-
-	/*
-	 * Batch and idle tasks do not preempt non-idle tasks (their preemption
-	 * is driven by the tick):
-	 */
-	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
+	if (!sched_feat(WAKEUP_PREEMPTION))
 		return;
 
 	find_matching_se(&se, &pse);
@@ -8400,7 +8391,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int 
 	pse_is_idle = se_is_idle(pse);
 
 	/*
-	 * Preempt an idle group in favor of a non-idle group (and don't preempt
+	 * Preempt an idle entity in favor of a non-idle entity (and don't preempt
 	 * in the inverse case).
 	 */
 	if (cse_is_idle && !pse_is_idle)
@@ -8408,9 +8399,14 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int 
 	if (cse_is_idle != pse_is_idle)
 		return;
 
+	/*
+	 * BATCH and IDLE tasks do not preempt others.
+	 */
+	if (unlikely(p->policy != SCHED_NORMAL))
+		return;
+
 	cfs_rq = cfs_rq_of(se);
 	update_curr(cfs_rq);
-
 	/*
 	 * XXX pick_eevdf(cfs_rq) != se ?
 	 */

