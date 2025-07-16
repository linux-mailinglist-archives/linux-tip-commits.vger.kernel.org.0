Return-Path: <linux-tip-commits+bounces-6126-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D9DB0732F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Jul 2025 12:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3908FA41986
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Jul 2025 10:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594012F4313;
	Wed, 16 Jul 2025 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4EeikCul";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fPXEkqTX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964DA2F272B;
	Wed, 16 Jul 2025 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661155; cv=none; b=tfK1EQianzzCk1mXYWun3Mm1lgwTIig+1SrbMRA+mzYQpIgNcsL9T5lhwOapsP9eMzTAKNbXMGmC4z8lFRALPXhqVAuB/W/fFu7IbS6uY2Pfmj9pkhLyRkjKVdh4kyeXmkPcWNwTnV+ZmufLWwpS0PRmKJPBiMPxfJsOZuGRhpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661155; c=relaxed/simple;
	bh=scGixgZ0Uj8pqsZYxxOvwDIoeMhwJyCrS2CXzLY2znQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r3puoZBy3pGlMiM6Dn57iLg2rxM0C68nOC9JTIWGTOuvmqmlTQKr/ChWPtuhip3Ihlod5K4nCFsENHgMEONxTd0JuBuLaptQG4lvzvkgoB6tn27H4v2KEPfPXNV6yZ/zC2WfIKaahoOH73rkMkbwmNlN6ZD6XAoaaAsuzw5jb6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4EeikCul; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fPXEkqTX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Jul 2025 10:19:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752661151;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u7cnAtitj5edvB7tJTla6UKJx7I3AF9pH7wYWWWPFdg=;
	b=4EeikCulhA3eas6f9KACJcUCnfCjIlJSj5VXrnOfJXV3b3SDGXwfnPaQx25T+nLOS2YEtY
	UawYWykBXu9sSb9EpZdgbWybOsozIyNS4UH9uoZQBFwfD6F95ZsLSop05Sz3lBSzo1+CgH
	XwIDXs7iz57Zo0B5MPZllk+xRPlz4MYvUoeUnmq57HrxENwArx43W1Qb43U99AQPpwhT0/
	CjX06RQY/LTROKKuKXcjvVpcBZO5pArcSDEm9/jdbZyq64X20aSQDz5d7RK24V6wn4hfxw
	oVLy7KX9xxoWJUADw0g4uS1Rw9ZcyxTVd2/RG7DK7FxtH5OYMkQWvoauWeJPDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752661151;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u7cnAtitj5edvB7tJTla6UKJx7I3AF9pH7wYWWWPFdg=;
	b=fPXEkqTXAH0TOyOn/mxAd7BOsjlsXy1mtrOf1lmzEIbSPzpVN+3tzj5q5SIj00yCTzTPL/
	of6o0cTcNesA6ZDg==
From: "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix runtime accounting w/ split exec & sched
 contexts
Cc: John Stultz <jstultz@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250712033407.2383110-6-jstultz@google.com>
References: <20250712033407.2383110-6-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175266115071.406.1055588556865365704.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     aa4f74dfd42ba4399f785fb9c460a11bd1756f0a
Gitweb:        https://git.kernel.org/tip/aa4f74dfd42ba4399f785fb9c460a11bd1756f0a
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Sat, 12 Jul 2025 03:33:46 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Jul 2025 17:16:32 +02:00

sched: Fix runtime accounting w/ split exec & sched contexts

Without proxy-exec, we normally charge the "current" task for
both its vruntime as well as its sum_exec_runtime.

With proxy, however, we have two "current" contexts: the
scheduler context and the execution context. We want to charge
the execution context rq->curr (ie: proxy/lock holder) execution
time to its sum_exec_runtime (so it's clear to userland the
rq->curr task *is* running), as well as its thread group.

However the rest of the time accounting (such a vruntime and
cgroup accounting), we charge against the scheduler context
(rq->donor) task, because it is from that task that the time
is being "donated".

If the donor and curr tasks are the same, then it's the same as
without proxy.

Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lkml.kernel.org/r/20250712033407.2383110-6-jstultz@google.com
---
 kernel/sched/fair.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8334580..9717645 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1152,30 +1152,40 @@ void post_init_entity_util_avg(struct task_struct *p)
 	sa->runnable_avg = sa->util_avg;
 }
 
-static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
+static s64 update_se(struct rq *rq, struct sched_entity *se)
 {
 	u64 now = rq_clock_task(rq);
 	s64 delta_exec;
 
-	delta_exec = now - curr->exec_start;
+	delta_exec = now - se->exec_start;
 	if (unlikely(delta_exec <= 0))
 		return delta_exec;
 
-	curr->exec_start = now;
-	curr->sum_exec_runtime += delta_exec;
+	se->exec_start = now;
+	if (entity_is_task(se)) {
+		struct task_struct *donor = task_of(se);
+		struct task_struct *running = rq->curr;
+		/*
+		 * If se is a task, we account the time against the running
+		 * task, as w/ proxy-exec they may not be the same.
+		 */
+		running->se.exec_start = now;
+		running->se.sum_exec_runtime += delta_exec;
 
-	if (entity_is_task(curr)) {
-		struct task_struct *p = task_of(curr);
+		trace_sched_stat_runtime(running, delta_exec);
+		account_group_exec_runtime(running, delta_exec);
 
-		trace_sched_stat_runtime(p, delta_exec);
-		account_group_exec_runtime(p, delta_exec);
-		cgroup_account_cputime(p, delta_exec);
+		/* cgroup time is always accounted against the donor */
+		cgroup_account_cputime(donor, delta_exec);
+	} else {
+		/* If not task, account the time against donor se  */
+		se->sum_exec_runtime += delta_exec;
 	}
 
 	if (schedstat_enabled()) {
 		struct sched_statistics *stats;
 
-		stats = __schedstats_from_se(curr);
+		stats = __schedstats_from_se(se);
 		__schedstat_set(stats->exec_max,
 				max(delta_exec, stats->exec_max));
 	}
@@ -1188,9 +1198,7 @@ static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
  */
 s64 update_curr_common(struct rq *rq)
 {
-	struct task_struct *donor = rq->donor;
-
-	return update_curr_se(rq, &donor->se);
+	return update_se(rq, &rq->donor->se);
 }
 
 /*
@@ -1198,6 +1206,12 @@ s64 update_curr_common(struct rq *rq)
  */
 static void update_curr(struct cfs_rq *cfs_rq)
 {
+	/*
+	 * Note: cfs_rq->curr corresponds to the task picked to
+	 * run (ie: rq->donor.se) which due to proxy-exec may
+	 * not necessarily be the actual task running
+	 * (rq->curr.se). This is easy to confuse!
+	 */
 	struct sched_entity *curr = cfs_rq->curr;
 	struct rq *rq = rq_of(cfs_rq);
 	s64 delta_exec;
@@ -1206,7 +1220,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	if (unlikely(!curr))
 		return;
 
-	delta_exec = update_curr_se(rq, curr);
+	delta_exec = update_se(rq, curr);
 	if (unlikely(delta_exec <= 0))
 		return;
 

