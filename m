Return-Path: <linux-tip-commits+bounces-5962-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9798FAEF9F3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 15:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C221783FF
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 13:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F1F2741C0;
	Tue,  1 Jul 2025 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4LYi/5iK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5XXflfti"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55AB274661;
	Tue,  1 Jul 2025 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751375620; cv=none; b=NUNBV/Bapb2YzyxFKzTgn+KFJShs4GfH7XmkoClII76vwDWmx6N3958BKI4rN33woNoYV2naCo01f0nGhPLQLZpRCvPIZq5W4e+hendOPiEiNxoot7utYqKRd1lnT3jNYh8nTDBBxNGgxQIl3uVkYehXWPymwAYlCidPexvn1rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751375620; c=relaxed/simple;
	bh=kriaOeLT+kpwQNYjPzLMAbHDCuqvFNEZgxqupTQPsTc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JeZTpr8u995FUlRQZtSKp4zkAwvTLpeKT3SJ6i7WCU16HLE9fUj7oukl65E40IHJkg0LmnuYt/nkGo5b0LVLFJ5gY98vWMfGa99xdZ7YcjmsFDoxkKgPfjKx5kPZ2jPSFm8v4SQnSiU3Hgyrz0CPDcukZBpwU7PDJVHP5cItWEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4LYi/5iK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5XXflfti; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Jul 2025 13:13:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751375616;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oxMSchQEUNWUVKHu3+Y6tayNpxRFqMcd7EKLakfKCXE=;
	b=4LYi/5iKzqGJtoEJDt/44e10Bt4k0cVDZsYFgpwkLwo1DNVuozesAEBeKdUoQYIvjMXIX/
	WlduUdFU0ZF2YgMf50uvlITldHDrh+2eS543S4qIzuWCpunULIxigp/nBkSrVW6VZdBKur
	za2XcA2B6wfVdWWkiBNpX/GgSpnSVlLtaOgJ2V6dMOkXWMGFDRL6AfeCvyFENYhvWbf7i5
	hM1NeKFYa9gg359ZCK9OSmA3wyAJGMnxHBxzfgGv2KF5Raem5OAIoQc2uCyAF2+H3g9sQY
	CaM5PGqESjvqGoDBQyOX130wMAvA1vnRzHezBw7I+nimS3vnA5YQkfR3yo03qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751375616;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oxMSchQEUNWUVKHu3+Y6tayNpxRFqMcd7EKLakfKCXE=;
	b=5XXflftir5txvBeCQZnnwX9eL0A/OqOrpV2qoHwBCFCNsLvz66+g/CtqIHd8IzJBOAUHQW
	2ukdyfrYOcP/4NBw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Fix migrate_swap() vs. hotplug
Cc: Kuyo Chang <kuyo.chang@mediatek.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250605100009.GO39944@noisy.programming.kicks-ass.net>
References: <20250605100009.GO39944@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175137561496.406.15374042235907305879.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     009836b4fa52f92cba33618e773b1094affa8cd2
Gitweb:        https://git.kernel.org/tip/009836b4fa52f92cba33618e773b1094affa8cd2
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 05 Jun 2025 12:00:09 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Jul 2025 15:02:03 +02:00

sched/core: Fix migrate_swap() vs. hotplug

On Mon, Jun 02, 2025 at 03:22:13PM +0800, Kuyo Chang wrote:

> So, the potential race scenario is:
>
> 	CPU0							CPU1
> 	// doing migrate_swap(cpu0/cpu1)
> 	stop_two_cpus()
> 							  ...
> 							 // doing _cpu_down()
> 							      sched_cpu_deactivate()
> 								set_cpu_active(cpu, false);
> 								balance_push_set(cpu, true);
> 	cpu_stop_queue_two_works
> 	    __cpu_stop_queue_work(stopper1,...);
> 	    __cpu_stop_queue_work(stopper2,..);
> 	stop_cpus_in_progress -> true
> 		preempt_enable();
> 								...
> 							1st balance_push
> 							stop_one_cpu_nowait
> 							cpu_stop_queue_work
> 							__cpu_stop_queue_work
> 							list_add_tail  -> 1st add push_work
> 							wake_up_q(&wakeq);  -> "wakeq is empty.
> 										This implies that the stopper is at wakeq@migrate_swap."
> 	preempt_disable
> 	wake_up_q(&wakeq);
> 	        wake_up_process // wakeup migrate/0
> 		    try_to_wake_up
> 		        ttwu_queue
> 		            ttwu_queue_cond ->meet below case
> 		                if (cpu == smp_processor_id())
> 			         return false;
> 			ttwu_do_activate
> 			//migrate/0 wakeup done
> 		wake_up_process // wakeup migrate/1
> 	           try_to_wake_up
> 		    ttwu_queue
> 			ttwu_queue_cond
> 		        ttwu_queue_wakelist
> 			__ttwu_queue_wakelist
> 			__smp_call_single_queue
> 	preempt_enable();
>
> 							2nd balance_push
> 							stop_one_cpu_nowait
> 							cpu_stop_queue_work
> 							__cpu_stop_queue_work
> 							list_add_tail  -> 2nd add push_work, so the double list add is detected
> 							...
> 							...
> 							cpu1 get ipi, do sched_ttwu_pending, wakeup migrate/1
>

So this balance_push() is part of schedule(), and schedule() is supposed
to switch to stopper task, but because of this race condition, stopper
task is stuck in WAKING state and not actually visible to be picked.

Therefore CPU1 can do another schedule() and end up doing another
balance_push() even though the last one hasn't been done yet.

This is a confluence of fail, where both wake_q and ttwu_wakelist can
cause crucial wakeups to be delayed, resulting in the malfunction of
balance_push.

Since there is only a single stopper thread to be woken, the wake_q
doesn't really add anything here, and can be removed in favour of
direct wakeups of the stopper thread.

Then add a clause to ttwu_queue_cond() to ensure the stopper threads
are never queued / delayed.

Of all 3 moving parts, the last addition was the balance_push()
machinery, so pick that as the point the bug was introduced.

Fixes: 2558aacff858 ("sched/hotplug: Ensure only per-cpu kthreads run during hotplug")
Reported-by: Kuyo Chang <kuyo.chang@mediatek.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Kuyo Chang <kuyo.chang@mediatek.com>
Link: https://lkml.kernel.org/r/20250605100009.GO39944@noisy.programming.kicks-ass.net
---
 kernel/sched/core.c   |  5 +++++
 kernel/stop_machine.c | 20 ++++++++++----------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cd80b66..ec68fc6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3943,6 +3943,11 @@ static inline bool ttwu_queue_cond(struct task_struct *p, int cpu)
 	if (!scx_allow_ttwu_queue(p))
 		return false;
 
+#ifdef CONFIG_SMP
+	if (p->sched_class == &stop_sched_class)
+		return false;
+#endif
+
 	/*
 	 * Do not complicate things with the async wake_list while the CPU is
 	 * in hotplug state.
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 5d2d056..3fe6b0c 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -82,18 +82,15 @@ static void cpu_stop_signal_done(struct cpu_stop_done *done)
 }
 
 static void __cpu_stop_queue_work(struct cpu_stopper *stopper,
-					struct cpu_stop_work *work,
-					struct wake_q_head *wakeq)
+				  struct cpu_stop_work *work)
 {
 	list_add_tail(&work->list, &stopper->works);
-	wake_q_add(wakeq, stopper->thread);
 }
 
 /* queue @work to @stopper.  if offline, @work is completed immediately */
 static bool cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
 {
 	struct cpu_stopper *stopper = &per_cpu(cpu_stopper, cpu);
-	DEFINE_WAKE_Q(wakeq);
 	unsigned long flags;
 	bool enabled;
 
@@ -101,12 +98,13 @@ static bool cpu_stop_queue_work(unsigned int cpu, struct cpu_stop_work *work)
 	raw_spin_lock_irqsave(&stopper->lock, flags);
 	enabled = stopper->enabled;
 	if (enabled)
-		__cpu_stop_queue_work(stopper, work, &wakeq);
+		__cpu_stop_queue_work(stopper, work);
 	else if (work->done)
 		cpu_stop_signal_done(work->done);
 	raw_spin_unlock_irqrestore(&stopper->lock, flags);
 
-	wake_up_q(&wakeq);
+	if (enabled)
+		wake_up_process(stopper->thread);
 	preempt_enable();
 
 	return enabled;
@@ -264,7 +262,6 @@ static int cpu_stop_queue_two_works(int cpu1, struct cpu_stop_work *work1,
 {
 	struct cpu_stopper *stopper1 = per_cpu_ptr(&cpu_stopper, cpu1);
 	struct cpu_stopper *stopper2 = per_cpu_ptr(&cpu_stopper, cpu2);
-	DEFINE_WAKE_Q(wakeq);
 	int err;
 
 retry:
@@ -300,8 +297,8 @@ retry:
 	}
 
 	err = 0;
-	__cpu_stop_queue_work(stopper1, work1, &wakeq);
-	__cpu_stop_queue_work(stopper2, work2, &wakeq);
+	__cpu_stop_queue_work(stopper1, work1);
+	__cpu_stop_queue_work(stopper2, work2);
 
 unlock:
 	raw_spin_unlock(&stopper2->lock);
@@ -316,7 +313,10 @@ unlock:
 		goto retry;
 	}
 
-	wake_up_q(&wakeq);
+	if (!err) {
+		wake_up_process(stopper1->thread);
+		wake_up_process(stopper2->thread);
+	}
 	preempt_enable();
 
 	return err;

