Return-Path: <linux-tip-commits+bounces-3217-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0079CA11D37
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31523A8773
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DA920B810;
	Wed, 15 Jan 2025 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wnnOvC2J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wWDi+Cui"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B0A246A1A;
	Wed, 15 Jan 2025 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932637; cv=none; b=L7i9oh4AiRzVUhtIw+G5l6zyIzbGZj4zLsmdX3j/Mr6iEgENQLOX0cKcz+mJPR24elb4FTg/7WKisSkCkY8yCt6Y9k7+m7r4rz8Q7zO3F7OPEaczLIjkC7rVE6iGyRFEGKi1hgK6JzqCo7fY87i7w15+2mH8/a/gxWBLDy3ZVe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932637; c=relaxed/simple;
	bh=Dn24NLph5MUC2cf8CiQo4iMznHg7kIU5FtbeKASd20k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VEN6n/2yZ3aMqb+roiJIEl7ry5zzwf74lZ/Fva4Tc1QJsQCav2tZAZktCwgEWjSQYqHb6q+0oDjinQSTrvO7omPHInqdiWkTqTdVP9xcfm7Bye97dry1PLKR9cwlgbBIl7MudvkMcDEUz8OaWB5Q4BdibzYh9H5lTiY+/YPIpP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wnnOvC2J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wWDi+Cui; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932633;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHIMDtC6nOvoK/iqg3F6d4bfO6n7E/r6yQMHd81FCzg=;
	b=wnnOvC2J/XMBJvYfZjvQX7mQIyKSVsShrWuhXadWAl7SXPikhJ6pzIv5vr05CrWxo3ji9r
	nGFKacJeJ940eYkVQqQYPTuCUeYySBmXpmE0DJUVGEwhTXTpnEDP0mgNmBTiPjKABmhf3N
	qH6vkLdBf2uOQEJ631DuSueV61M+XyQuosGibdgqjKWZL2p3jLz28JBCYpkJ2AjnccD3gg
	yGXRhGZg5VvA3v56gZw22WEf4eWdlLTGMN0rMeqQvr3AFcqKl7a1fg3n06DWpiV7ZQVdoS
	5iDXeGMd8VstasuVP0oq8nqM9N9461GFTsbXmWvA9Z/5Kzge6aO34yJmf60N7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932633;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHIMDtC6nOvoK/iqg3F6d4bfO6n7E/r6yQMHd81FCzg=;
	b=wWDi+Cuijv90x9bdg/KxaE1FIwarlDBHoSg+3XUX48hC8eg/o2++0kpRffM8U4oDrhIu5M
	KFks3yo+2g0GG9Dw==
From: "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] psi: Fix race when task wakes up before
 psi_sched_switch() adjusts flags
Cc: Chengming Zhou <chengming.zhou@linux.dev>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241227061941.2315-1-kprateek.nayak@amd.com>
References: <20241227061941.2315-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693263337.31546.12510438560271238599.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7d9da040575b343085287686fa902a5b2d43c7ca
Gitweb:        https://git.kernel.org/tip/7d9da040575b343085287686fa902a5b2d43c7ca
Author:        Chengming Zhou <chengming.zhou@linux.dev>
AuthorDate:    Fri, 27 Dec 2024 06:19:41 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jan 2025 14:10:26 +01:00

psi: Fix race when task wakes up before psi_sched_switch() adjusts flags

When running hackbench in a cgroup with bandwidth throttling enabled,
following PSI splat was observed:

    psi: inconsistent task state! task=1831:hackbench cpu=8 psi_flags=14 clear=0 set=4

When investigating the series of events leading up to the splat,
following sequence was observed:

    [008] d..2.: sched_switch: ... ==> next_comm=hackbench next_pid=1831 next_prio=120
        ...
    [008] dN.2.: dequeue_entity(task delayed): task=hackbench pid=1831 cfs_rq->throttled=0
    [008] dN.2.: pick_task_fair: check_cfs_rq_runtime() throttled cfs_rq on CPU8
    # CPU8 goes into newidle balance and releases the rq lock
        ...
    # CPU15 on same LLC Domain is trying to wakeup hackbench(pid=1831)
    [015] d..4.: psi_flags_change: psi: task state: task=1831:hackbench cpu=8 psi_flags=14 clear=0 set=4 final=14 # Splat (cfs_rq->throttled=1)
    [015] d..4.: sched_wakeup: comm=hackbench pid=1831 prio=120 target_cpu=008 # Task has woken on a throttled hierarchy
    [008] d..2.: sched_switch: prev_comm=hackbench prev_pid=1831 prev_prio=120 prev_state=S ==> ...

psi_dequeue() relies on psi_sched_switch() to set the correct PSI flags
for the blocked entity, however, with the introduction of DELAY_DEQUEUE,
the block task can wakeup when newidle balance drops the runqueue lock
during __schedule().

If a task wakes before psi_sched_switch() adjusts the PSI flags, skip
any modifications in psi_enqueue() which would still see the flags of a
running task and not a blocked one. Instead, rely on psi_sched_switch()
to do the right thing.

Since the status returned by try_to_block_task() may no longer be true
by the time schedule reaches psi_sched_switch(), check if the task is
blocked or not using a combination of task_on_rq_queued() and
p->se.sched_delayed checks.

[ prateek: Commit message, testing, early bailout in psi_enqueue() ]

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue") # 1a6151017ee5
Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Link: https://lore.kernel.org/r/20241227061941.2315-1-kprateek.nayak@amd.com
---
 kernel/sched/core.c  | 6 +++---
 kernel/sched/stats.h | 4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 22dfcd3..4365b47 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6645,7 +6645,6 @@ static void __sched notrace __schedule(int sched_mode)
 	 * as a preemption by schedule_debug() and RCU.
 	 */
 	bool preempt = sched_mode > SM_NONE;
-	bool block = false;
 	unsigned long *switch_count;
 	unsigned long prev_state;
 	struct rq_flags rf;
@@ -6706,7 +6705,7 @@ static void __sched notrace __schedule(int sched_mode)
 			goto picked;
 		}
 	} else if (!preempt && prev_state) {
-		block = try_to_block_task(rq, prev, prev_state);
+		try_to_block_task(rq, prev, prev_state);
 		switch_count = &prev->nvcsw;
 	}
 
@@ -6752,7 +6751,8 @@ picked:
 
 		migrate_disable_switch(rq, prev);
 		psi_account_irqtime(rq, prev, next);
-		psi_sched_switch(prev, next, block);
+		psi_sched_switch(prev, next, !task_on_rq_queued(prev) ||
+					     prev->se.sched_delayed);
 
 		trace_sched_switch(preempt, prev, next, prev_state);
 
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 8ee0add..6ade91b 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -138,6 +138,10 @@ static inline void psi_enqueue(struct task_struct *p, int flags)
 	if (flags & ENQUEUE_RESTORE)
 		return;
 
+	/* psi_sched_switch() will handle the flags */
+	if (task_on_cpu(task_rq(p), p))
+		return;
+
 	if (p->se.sched_delayed) {
 		/* CPU migration of "sleeping" task */
 		SCHED_WARN_ON(!(flags & ENQUEUE_MIGRATED));

