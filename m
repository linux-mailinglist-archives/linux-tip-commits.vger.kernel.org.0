Return-Path: <linux-tip-commits+bounces-2773-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE319BE4CD
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 11:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307FC285D48
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 10:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3725C1DE2B9;
	Wed,  6 Nov 2024 10:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eXHpkhOi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tO+bQViZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9AF1DEFFB;
	Wed,  6 Nov 2024 10:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890134; cv=none; b=GPpm5RlFuLDLxiEgbipBuAEwJaLnkv9f/k5h57LIlI17CYwJgC5JPM0CfEJji7CB1D9f2pxSXCOfs9s9OOnF0CwC9qucd4fBsPQNqKUyXMh4ojx+FI2XcZSSXhAJj6dIwlnWvm6sOdF0oAbT6hJSPYH13h94qVsRPUqGOyUyRtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890134; c=relaxed/simple;
	bh=z0zW0qH8bdcrGRheGEK2qewl91x86tWT5BkrnDG3vCU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HTFpRvpfsB2BERoqx38H5fPGABbYB3s/kgRd84Ffte7a5CnG7sE528LkBd42EJ/kVrlPxlzgHqJ6T55Z/LrsrXrUknfsoSwfcSYo/Wq1KN9Gqew0XhiPhH6JRHKFaim/SsDY0gSvtK+G32dILoMYsunVMfog6GEcQAaAChbjJeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eXHpkhOi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tO+bQViZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Nov 2024 10:48:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730890130;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMlN88yV/2Hc/KhLnY0VfRb6LGAkh2WzoldPIIT9PJI=;
	b=eXHpkhOiwarUObchg54BB5m0ytrFHH54rQsUoXuJyWnDp+oikkuRe4fvxFj7iIKPa2U2pZ
	WZgCY8UJoT1q4gnxcuJ7NPBlrJ9Z7QkRiPZhEa8dBheKWJMTRDapugBj1jonTUFkitt9Q8
	kFJ4ydq6xk21sWlc3dRkVwrBcjV1A01ah5myojrFlFLOmq9X1G/loCH8Kb9o6FkoWNtrbw
	v0rPc8Qf+4gSLCGXRwCfw2ARad2Fho5AYGigUBVLsnFNtcDfu7nFyZD/sZPzEJb94r98Dv
	KAxqO2mV4vFVWTiI5Zw8q3zBiD3xlhxVddDvl750Vhv3vCDLyRa/mZ7at99J+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730890130;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMlN88yV/2Hc/KhLnY0VfRb6LGAkh2WzoldPIIT9PJI=;
	b=tO+bQViZlz+elajYMkFBhvCC0bpabfxL1PA7uIlDcr8C1Z5QUyyeABitFQF1WgdYO/t8we
	bfiP4dbLMYo0XkDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Initialize idle tasks only once
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241028103142.359584747@linutronix.de>
References: <20241028103142.359584747@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173089012976.32228.18320015335502739849.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b23decf8ac9102fc52c4de5196f4dc0a5f3eb80b
Gitweb:        https://git.kernel.org/tip/b23decf8ac9102fc52c4de5196f4dc0a5f3eb80b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 28 Oct 2024 11:43:42 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Nov 2024 12:55:37 +01:00

sched: Initialize idle tasks only once

Idle tasks are initialized via __sched_fork() twice:

     fork_idle()
        copy_process()
	  sched_fork()
             __sched_fork()
	init_idle()
          __sched_fork()

Instead of cleaning this up, sched_ext hacked around it. Even when analyis
and solution were provided in a discussion, nobody cared to clean this up.

init_idle() is also invoked from sched_init() to initialize the boot CPU's
idle task, which requires the __sched_fork() invocation. But this can be
trivially solved by invoking __sched_fork() before init_idle() in
sched_init() and removing the __sched_fork() invocation from init_idle().

Do so and clean up the comments explaining this historical leftover.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241028103142.359584747@linutronix.de
---
 kernel/sched/core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c57a79e..aad4885 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4423,7 +4423,8 @@ int wake_up_state(struct task_struct *p, unsigned int state)
  * Perform scheduler related setup for a newly forked process p.
  * p is forked by current.
  *
- * __sched_fork() is basic setup used by init_idle() too:
+ * __sched_fork() is basic setup which is also used by sched_init() to
+ * initialize the boot CPU's idle task.
  */
 static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
@@ -7697,8 +7698,6 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long flags;
 
-	__sched_fork(0, idle);
-
 	raw_spin_lock_irqsave(&idle->pi_lock, flags);
 	raw_spin_rq_lock(rq);
 
@@ -7713,10 +7712,8 @@ void __init init_idle(struct task_struct *idle, int cpu)
 
 #ifdef CONFIG_SMP
 	/*
-	 * It's possible that init_idle() gets called multiple times on a task,
-	 * in that case do_set_cpus_allowed() will not do the right thing.
-	 *
-	 * And since this is boot we can forgo the serialization.
+	 * No validation and serialization required at boot time and for
+	 * setting up the idle tasks of not yet online CPUs.
 	 */
 	set_cpus_allowed_common(idle, &ac);
 #endif
@@ -8561,6 +8558,7 @@ void __init sched_init(void)
 	 * but because we are the idle thread, we just pick up running again
 	 * when this runqueue becomes "idle".
 	 */
+	__sched_fork(0, current);
 	init_idle(current, smp_processor_id());
 
 	calc_load_update = jiffies + LOAD_FREQ;

