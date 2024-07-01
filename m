Return-Path: <linux-tip-commits+bounces-1561-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F94891DD7F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Jul 2024 13:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C018A1F21813
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Jul 2024 11:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B9713D24D;
	Mon,  1 Jul 2024 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tYMX/34N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RNorXE8j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22F0376E7;
	Mon,  1 Jul 2024 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719832030; cv=none; b=MOdnc3i6qpm+zK+bf3Aqb4OYbzK6BtgcXcG3t92rfuFbJMmpsy8Wx+plj7wCpt+VzVHjSnC5/Ikw2HU+HsVn/DUd9ls6tKLNwguhqzufE1VQs1YZv4HTMUSQQ+pdAuzzbDFv2dGjk55pIiaVfl3eu6Ndlse6j30H3/eDFqOjvRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719832030; c=relaxed/simple;
	bh=5E6kD3GpJMuWDQqtm2W2mbWaz0qdkFmOdT8ygf4XpMY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SHboUFuvCAgXWQPCSh9zh9D8+I/HYx+cHLzcDZFZIKajH7F7rjrZHLrAac6Rh1ewb3LHOE+g4QC4hg+2E4fnsGHgcDQs+jcRUlLjlnby+F6134kVYgynTmGXso+0Tv84pW9c5eZ/t758qO8htj01NQeFo2S3TG1aerqaOpduheI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tYMX/34N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RNorXE8j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 01 Jul 2024 11:07:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719832027;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SB3QoOf27PuYr2EmIICKxfgQMqPiLxsIMXUVaPV8rbk=;
	b=tYMX/34NiqgGQUV0WbQunyGS1WzwsDtF5Gkrqs4ZT0T3tbN9+XmYE5xRGDbWJNM6wOLSw2
	fjNwRJoGZ2JYg6tjY4g21lPZ1RDBlcolL0c1QyI2Tqzv7rR3KZ9SABQyV0+zNpcSE97Ju8
	WevEbkfIxnTFirVzoEySfbq7JhTAapKFefVHJGi/jVFJ5iBDrLtnMsJVoUBDwc0M/I5tv4
	bVXPSBK8azzNWkpR+EmXOaeFcixzcn/9zdKqxHhdWQzdaP/4wyG68vn72sFa0x3GFQsCUb
	UDHcXkZ7Rsw438tvTbOUR+IG6ckJXtx3BLKZW0TOggI7XgLJ9Zdjyl4jJ7Za7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719832027;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SB3QoOf27PuYr2EmIICKxfgQMqPiLxsIMXUVaPV8rbk=;
	b=RNorXE8jHczTRo5IpLTCW/qLtR8hd32cSoyxeGesymyxFdwpI2BAzyoy+XELOZeSFpacxb
	r9VidaquzoT9lHAQ==
From: "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Move psi_account_irqtime() out of
 update_rq_clock_task() hotpath
Cc: Jimmy Shiu <jimmyshiu@google.com>, Peter Zijlstra <peterz@infradead.org>,
 John Stultz <jstultz@google.com>, Chengming Zhou <chengming.zhou@linux.dev>,
 Qais Yousef <qyousef@layalina.io>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240618215909.4099720-1-jstultz@google.com>
References: <20240618215909.4099720-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171983202667.2215.7444794361822669519.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     ddae0ca2a8fe12d0e24ab10ba759c3fbd755ada8
Gitweb:        https://git.kernel.org/tip/ddae0ca2a8fe12d0e24ab10ba759c3fbd755ada8
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Tue, 18 Jun 2024 14:58:55 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Jul 2024 13:01:44 +02:00

sched: Move psi_account_irqtime() out of update_rq_clock_task() hotpath

It was reported that in moving to 6.1, a larger then 10%
regression was seen in the performance of
clock_gettime(CLOCK_THREAD_CPUTIME_ID,...).

Using a simple reproducer, I found:
5.10:
100000000 calls in 24345994193 ns => 243.460 ns per call
100000000 calls in 24288172050 ns => 242.882 ns per call
100000000 calls in 24289135225 ns => 242.891 ns per call

6.1:
100000000 calls in 28248646742 ns => 282.486 ns per call
100000000 calls in 28227055067 ns => 282.271 ns per call
100000000 calls in 28177471287 ns => 281.775 ns per call

The cause of this was finally narrowed down to the addition of
psi_account_irqtime() in update_rq_clock_task(), in commit
52b1364ba0b1 ("sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ
pressure").

In my initial attempt to resolve this, I leaned towards moving
all accounting work out of the clock_gettime() call path, but it
wasn't very pretty, so it will have to wait for a later deeper
rework. Instead, Peter shared this approach:

Rework psi_account_irqtime() to use its own psi_irq_time base
for accounting, and move it out of the hotpath, calling it
instead from sched_tick() and __schedule().

In testing this, we found the importance of ensuring
psi_account_irqtime() is run under the rq_lock, which Johannes
Weiner helpfully explained, so also add some lockdep annotations
to make that requirement clear.

With this change the performance is back in-line with 5.10:
6.1+fix:
100000000 calls in 24297324597 ns => 242.973 ns per call
100000000 calls in 24318869234 ns => 243.189 ns per call
100000000 calls in 24291564588 ns => 242.916 ns per call

Reported-by: Jimmy Shiu <jimmyshiu@google.com>
Originally-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
Link: https://lore.kernel.org/r/20240618215909.4099720-1-jstultz@google.com
---
 kernel/sched/core.c  |  7 +++++--
 kernel/sched/psi.c   | 21 ++++++++++++++++-----
 kernel/sched/sched.h |  1 +
 kernel/sched/stats.h | 11 ++++++++---
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bcf2c4c..59ce084 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -723,7 +723,6 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 
 	rq->prev_irq_time += irq_delta;
 	delta -= irq_delta;
-	psi_account_irqtime(rq->curr, irq_delta);
 	delayacct_irq(rq->curr, irq_delta);
 #endif
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
@@ -5665,7 +5664,7 @@ void sched_tick(void)
 {
 	int cpu = smp_processor_id();
 	struct rq *rq = cpu_rq(cpu);
-	struct task_struct *curr = rq->curr;
+	struct task_struct *curr;
 	struct rq_flags rf;
 	unsigned long hw_pressure;
 	u64 resched_latency;
@@ -5677,6 +5676,9 @@ void sched_tick(void)
 
 	rq_lock(rq, &rf);
 
+	curr = rq->curr;
+	psi_account_irqtime(rq, curr, NULL);
+
 	update_rq_clock(rq);
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
 	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
@@ -6737,6 +6739,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		++*switch_count;
 
 		migrate_disable_switch(rq, prev);
+		psi_account_irqtime(rq, prev, next);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
 		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 7b4aa58..507d7b8 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -773,6 +773,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	enum psi_states s;
 	u32 state_mask;
 
+	lockdep_assert_rq_held(cpu_rq(cpu));
 	groupc = per_cpu_ptr(group->pcpu, cpu);
 
 	/*
@@ -991,22 +992,32 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 }
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-void psi_account_irqtime(struct task_struct *task, u32 delta)
+void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_struct *prev)
 {
-	int cpu = task_cpu(task);
+	int cpu = task_cpu(curr);
 	struct psi_group *group;
 	struct psi_group_cpu *groupc;
-	u64 now;
+	u64 now, irq;
+	s64 delta;
 
 	if (static_branch_likely(&psi_disabled))
 		return;
 
-	if (!task->pid)
+	if (!curr->pid)
+		return;
+
+	lockdep_assert_rq_held(rq);
+	group = task_psi_group(curr);
+	if (prev && task_psi_group(prev) == group)
 		return;
 
 	now = cpu_clock(cpu);
+	irq = irq_time_read(cpu);
+	delta = (s64)(irq - rq->psi_irq_time);
+	if (delta < 0)
+		return;
+	rq->psi_irq_time = irq;
 
-	group = task_psi_group(task);
 	do {
 		if (!group->enabled)
 			continue;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a831af1..ef20c61 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1126,6 +1126,7 @@ struct rq {
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	u64			prev_irq_time;
+	u64			psi_irq_time;
 #endif
 #ifdef CONFIG_PARAVIRT
 	u64			prev_steal_time;
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 38f3698..b02dfc3 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -110,8 +110,12 @@ __schedstats_from_se(struct sched_entity *se)
 void psi_task_change(struct task_struct *task, int clear, int set);
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		     bool sleep);
-void psi_account_irqtime(struct task_struct *task, u32 delta);
-
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_struct *prev);
+#else
+static inline void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
+				       struct task_struct *prev) {}
+#endif /*CONFIG_IRQ_TIME_ACCOUNTING */
 /*
  * PSI tracks state that persists across sleeps, such as iowaits and
  * memory stalls. As a result, it has to distinguish between sleeps,
@@ -192,7 +196,8 @@ static inline void psi_ttwu_dequeue(struct task_struct *p) {}
 static inline void psi_sched_switch(struct task_struct *prev,
 				    struct task_struct *next,
 				    bool sleep) {}
-static inline void psi_account_irqtime(struct task_struct *task, u32 delta) {}
+static inline void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
+				       struct task_struct *prev) {}
 #endif /* CONFIG_PSI */
 
 #ifdef CONFIG_SCHED_INFO

