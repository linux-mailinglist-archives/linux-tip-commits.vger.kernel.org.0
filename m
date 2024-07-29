Return-Path: <linux-tip-commits+bounces-1802-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F83393F2DE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 12:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B4E2823FF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 10:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A4F145FED;
	Mon, 29 Jul 2024 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m0JvV4bp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DA4Tf3Op"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970531459F3;
	Mon, 29 Jul 2024 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249251; cv=none; b=m923kL+a/Fy6n8XZQYKaoQmrFKJRMu62djP5etu6Z//iboVyCHtYpwvG0agGhmP4HCgC1eSHEGjTSylJLuFchvoSVQ0vgJyyAItnVqRwVz1APKZbZg8JidOkHA+jr8PJ425sZY+S5yQWhnImsm04w2fdAzs0neMgek40Uo63Q0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249251; c=relaxed/simple;
	bh=cMUEiSjNn6l5Af7Fnog8PicYqLYnlCfWaO7h0hErvVU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hV2iGwZMcPcKN2uCIQKnn7HYC1T1dMBzXZ7ah6GtBQqMq2IWirE8WNiIYUbqbrgeNxLc9ryUk6pmZuHsuLDv1d1GVrTYb9uWUAxcfY1QYt2zgP51a2T1MISZbnx708lF2fIIpwJ1VtQS0pjXOeYCQcayZGeH2mfjiDpnhDOoLMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m0JvV4bp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DA4Tf3Op; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:34:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722249248;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wRsAKExDwFKwJSvUJ6d3fQmIhLex317CCabSwhlM3pw=;
	b=m0JvV4bps5yt7MZim5SFfWIRKsPds5hgfY11wCn8mNA3/lOnpaJsuhGYFFcz7WF4ow0mgh
	W4LK/01dmgGoIuQQ5THPUYbFYaa/SL7wjhkqaW1ng92FMrlDK8JQTRXQ2dkkCxk8K41kVG
	PH7KFHO98kjXcKyHJjpgP1xGBY/OC9EOflpBy/5T0LSQMv5xwc56iMs4AcbHHTOZw0akP1
	quWE9SQwEDIUhN+/J5+2555vFBPLUaoqP6FVm7YrfauqAiVG3nFg+K/18GFISOT4vj5din
	+j9bFN6NNyd0zb3U2gL6DSYjuuD1L/GtJB9oOjsM3nI3NiC849g4EMOfLHR0Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722249248;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wRsAKExDwFKwJSvUJ6d3fQmIhLex317CCabSwhlM3pw=;
	b=DA4Tf3Op1KIDhS+8ZT2QRt12t7Nabz6IVOS+fsUgaCD49KBd6Asoc356DxUUZ3XZYzoPz/
	PhuAngeFXthKyWCA==
From: "tip-bot2 for Zhang Qiao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Initialize the vruntime of a new task when
 it is first enqueued
Cc: Zhang Qiao <zhangqiao22@huawei.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240627133359.1370598-1-zhangqiao22@huawei.com>
References: <20240627133359.1370598-1-zhangqiao22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224924797.2215.1886433124274814892.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c40dd90ac045fa1fdf6acc5bf9109a2315e6c92c
Gitweb:        https://git.kernel.org/tip/c40dd90ac045fa1fdf6acc5bf9109a2315e6c92c
Author:        Zhang Qiao <zhangqiao22@huawei.com>
AuthorDate:    Thu, 27 Jun 2024 21:33:59 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:22:34 +02:00

sched: Initialize the vruntime of a new task when it is first enqueued

When creating a new task, we initialize vruntime of the newly task at
sched_cgroup_fork(). However, the timing of executing this action is too
early and may not be accurate.

Because it uses current CPU to init the vruntime, but the new task
actually runs on the cpu which be assigned at wake_up_new_task().

To optimize this case, we pass ENQUEUE_INITIAL flag to activate_task()
in wake_up_new_task(), in this way, when place_entity is called in
enqueue_entity(), the vruntime of the new task will be initialized.

In addition, place_entity() in task_fork_fair() was introduced for two
reasons:
1. Previously, the __enqueue_entity() was in task_new_fair(),
in order to provide vruntime for enqueueing the newly task, the
vruntime assignment equation "se->vruntime = cfs_rq->min_vruntime" was
introduced by commit e9acbff6484d ("sched: introduce se->vruntime").
This is the initial state of place_entity().

2. commit 4d78e7b656aa ("sched: new task placement for vruntime") added
child_runs_first task placement feature which based on vruntime, this
also requires the new task's vruntime value.

After removing the child_runs_first and enqueue_entity() from
task_fork_fair(), this place_entity() no longer makes sense, so remove
it also.

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20240627133359.1370598-1-zhangqiao22@huawei.com
---
 kernel/sched/core.c |  2 +-
 kernel/sched/fair.c | 15 ---------------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f3951e4..2c61b4f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4686,7 +4686,7 @@ void wake_up_new_task(struct task_struct *p)
 	update_rq_clock(rq);
 	post_init_entity_util_avg(p);
 
-	activate_task(rq, p, ENQUEUE_NOCLOCK);
+	activate_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_INITIAL);
 	trace_sched_wakeup_new(p);
 	wakeup_preempt(rq, p, WF_FORK);
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584..e8cdfeb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12702,22 +12702,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
  */
 static void task_fork_fair(struct task_struct *p)
 {
-	struct sched_entity *se = &p->se, *curr;
-	struct cfs_rq *cfs_rq;
-	struct rq *rq = this_rq();
-	struct rq_flags rf;
-
-	rq_lock(rq, &rf);
-	update_rq_clock(rq);
-
 	set_task_max_allowed_capacity(p);
-
-	cfs_rq = task_cfs_rq(current);
-	curr = cfs_rq->curr;
-	if (curr)
-		update_curr(cfs_rq);
-	place_entity(cfs_rq, se, ENQUEUE_INITIAL);
-	rq_unlock(rq, &rf);
 }
 
 /*

