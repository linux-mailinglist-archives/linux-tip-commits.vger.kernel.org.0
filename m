Return-Path: <linux-tip-commits+bounces-6127-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9884DB07334
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Jul 2025 12:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B33258375C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Jul 2025 10:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557B92F4A02;
	Wed, 16 Jul 2025 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mGuR5X/E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GRPIzHHu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F5A2F4315;
	Wed, 16 Jul 2025 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661157; cv=none; b=QkwQpkwjYLLoG81tqxesvVuFEoDkpHdhUeKu3Sl2yPjDpxQVEVH/fTB+MwJKduhQO4oWsuIiTrigXr0vOt24+cwxCHHZ62LlUIjOdX2iJbZ2BH8csBVRwJsbWDkP5eCrB7TIJOgEC96CtxXvukINxJKKsyNFpsAeaGzgsp/OMzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661157; c=relaxed/simple;
	bh=Zy3nY5vmpCSMStq93NcWv7K5Ejh3WRNyXQEnBK8l7rQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fS9tbr4UcMo81UHTt98MknqZU1E3se4CcWre4+BqaCvxPXjLF6WrthYgr2FNQhLN6oAluwJhI9ZCv+ycjYEz1dwdhRCjftqESaazChNOfEb1j8oXuV5J/lpfn5hHOP4s869we1ZVDOnFZfmPNB3G01/006K9lQeqHJFMkc5zy1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mGuR5X/E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GRPIzHHu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Jul 2025 10:19:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752661152;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dPWbrMA53SZOK1glsYmHqfl+Lu0HA354mMCV/cejKgo=;
	b=mGuR5X/Effy2V8LQGG3Eb3TWDek4RATJM1fG6oac5zlAjLClTJwFGxJtnnJQQK02vf49Gd
	4jTrBo5PP2dmNz4uWYwyatrR9bN70mPm1sZo4+HK/AHKYhQ6XWOw/SYWPCq0AexrasK5fg
	ZpT6mWkLG5d3UfMQPbZQuyDxsCZyxzqrE9c7weAy/nRu5qOgmRYCCbRxOPHmXj5w8VwoXK
	C9ryYYgApwQL05TFaGsO6TSCPwVX35Ml8qWmzO5oawClb3xTF6zExmlS5oyBvghWiJ0OVI
	7GXW5CXQ2m5M4BUa35JG51omd9tcUmpe0oLNVoEeNZqO6YNNjFPpHrzQw6s/Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752661152;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dPWbrMA53SZOK1glsYmHqfl+Lu0HA354mMCV/cejKgo=;
	b=GRPIzHHuCBVupBaZNWW79hxLQiHG7D6KZ9fw87JtATowxXPX5BcS51cDiuscytDqWNEn8y
	hjHbIuH3kxu8WVCQ==
From: "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched: Move update_curr_task logic into update_curr_se
Cc: John Stultz <jstultz@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250712033407.2383110-5-jstultz@google.com>
References: <20250712033407.2383110-5-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175266115160.406.16373206315111370971.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     865d8cfb1672089e4b628d6899ac5c6e49787150
Gitweb:        https://git.kernel.org/tip/865d8cfb1672089e4b628d6899ac5c6e49787150
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Sat, 12 Jul 2025 03:33:45 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Jul 2025 17:16:32 +02:00

sched: Move update_curr_task logic into update_curr_se

Absorb update_curr_task() into update_curr_se(), and
in the process simplify update_curr_common().

This will make the next step a bit easier.

Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lkml.kernel.org/r/20250712033407.2383110-5-jstultz@google.com
---
 kernel/sched/fair.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b9b4bbb..8334580 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1164,6 +1164,14 @@ static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
 	curr->exec_start = now;
 	curr->sum_exec_runtime += delta_exec;
 
+	if (entity_is_task(curr)) {
+		struct task_struct *p = task_of(curr);
+
+		trace_sched_stat_runtime(p, delta_exec);
+		account_group_exec_runtime(p, delta_exec);
+		cgroup_account_cputime(p, delta_exec);
+	}
+
 	if (schedstat_enabled()) {
 		struct sched_statistics *stats;
 
@@ -1175,26 +1183,14 @@ static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
 	return delta_exec;
 }
 
-static inline void update_curr_task(struct task_struct *p, s64 delta_exec)
-{
-	trace_sched_stat_runtime(p, delta_exec);
-	account_group_exec_runtime(p, delta_exec);
-	cgroup_account_cputime(p, delta_exec);
-}
-
 /*
  * Used by other classes to account runtime.
  */
 s64 update_curr_common(struct rq *rq)
 {
 	struct task_struct *donor = rq->donor;
-	s64 delta_exec;
 
-	delta_exec = update_curr_se(rq, &donor->se);
-	if (likely(delta_exec > 0))
-		update_curr_task(donor, delta_exec);
-
-	return delta_exec;
+	return update_curr_se(rq, &donor->se);
 }
 
 /*
@@ -1219,10 +1215,6 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	update_min_vruntime(cfs_rq);
 
 	if (entity_is_task(curr)) {
-		struct task_struct *p = task_of(curr);
-
-		update_curr_task(p, delta_exec);
-
 		/*
 		 * If the fair_server is active, we need to account for the
 		 * fair_server time whether or not the task is running on

