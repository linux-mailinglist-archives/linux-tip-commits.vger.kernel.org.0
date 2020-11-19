Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5752B8F9C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Nov 2020 11:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgKSJze (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Nov 2020 04:55:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60902 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgKSJzI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Nov 2020 04:55:08 -0500
Date:   Thu, 19 Nov 2020 09:55:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605779706;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QZLYw95nrGtlgnY/wWHhUaK1PglbIjrttIHuftojfys=;
        b=yBXlnGCA2Ut56e7Ka6Y+CelEUuswFKurS1wNTZ6AHdl8f6KiMc2qKpBVOYpISSV9swBfg2
        rYrbpYzsl+EsB/LXRMPUAhO0QlmzTy5p8TEkrDdglCFiUll5IIGDjAKEe/09sIeUrXxJ72
        7txy4EfmCk5/xplhwvNQoCnxY548Jh5sDBvCei9+KwEzT2luqdeGyhlpgIQE79R37JDIgD
        IqAO609GokrecBrDJc5Vf8wgO7rI/CQ4u64BVMd2tz02RVVnfHBggfVUYK/FujziDK+8Wd
        Yi/cIvc6bYt19MVKvpZUjKzJSGesnoqat1pVzvelAt93OV9elqOZD9en0cDLgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605779706;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QZLYw95nrGtlgnY/wWHhUaK1PglbIjrttIHuftojfys=;
        b=PPfnhMxZRbfUUvN+XpPahli0+po9NztdQ3thQXie5ZJ1/IWzhpGIEvj0AP2Yj80qvfBiW0
        VTY3U4kw6dUFfCBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Fix data-race in wakeup
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201117083016.GK3121392@hirez.programming.kicks-ass.net>
References: <20201117083016.GK3121392@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <160577970512.11244.15276468517015655452.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     f97bb5272d9e95d400d6c8643ebb146b3e3e7842
Gitweb:        https://git.kernel.org/tip/f97bb5272d9e95d400d6c8643ebb146b3e3e7842
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 17 Nov 2020 09:08:41 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 17 Nov 2020 13:15:27 +01:00

sched: Fix data-race in wakeup

Mel reported that on some ARM64 platforms loadavg goes bananas and
Will tracked it down to the following race:

  CPU0					CPU1

  schedule()
    prev->sched_contributes_to_load = X;
    deactivate_task(prev);

					try_to_wake_up()
					  if (p->on_rq &&) // false
					  if (smp_load_acquire(&p->on_cpu) && // true
					      ttwu_queue_wakelist())
					        p->sched_remote_wakeup = Y;

    smp_store_release(prev->on_cpu, 0);

where both p->sched_contributes_to_load and p->sched_remote_wakeup are
in the same word, and thus the stores X and Y race (and can clobber
one another's data).

Whereas prior to commit c6e7bd7afaeb ("sched/core: Optimize ttwu()
spinning on p->on_cpu") the p->on_cpu handoff serialized access to
p->sched_remote_wakeup (just as it still does with
p->sched_contributes_to_load) that commit broke that by calling
ttwu_queue_wakelist() with p->on_cpu != 0.

However, due to

  p->XXX = X			ttwu()
  schedule()			  if (p->on_rq && ...) // false
    smp_mb__after_spinlock()	  if (smp_load_acquire(&p->on_cpu) &&
    deactivate_task()		      ttwu_queue_wakelist())
      p->on_rq = 0;		        p->sched_remote_wakeup = Y;

We can be sure any 'current' store is complete and 'current' is
guaranteed asleep. Therefore we can move p->sched_remote_wakeup into
the current flags word.

Note: while the observed failure was loadavg accounting gone wrong due
to ttwu() cobbering p->sched_contributes_to_load, the reverse problem
is also possible where schedule() clobbers p->sched_remote_wakeup,
this could result in enqueue_entity() wrecking ->vruntime and causing
scheduling artifacts.

Fixes: c6e7bd7afaeb ("sched/core: Optimize ttwu() spinning on p->on_cpu")
Reported-by: Mel Gorman <mgorman@techsingularity.net>
Debugged-by: Will Deacon <will@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201117083016.GK3121392@hirez.programming.kicks-ass.net
---
 include/linux/sched.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d383cf0..0e91b45 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -769,7 +769,6 @@ struct task_struct {
 	unsigned			sched_reset_on_fork:1;
 	unsigned			sched_contributes_to_load:1;
 	unsigned			sched_migrated:1;
-	unsigned			sched_remote_wakeup:1;
 #ifdef CONFIG_PSI
 	unsigned			sched_psi_wake_requeue:1;
 #endif
@@ -779,6 +778,21 @@ struct task_struct {
 
 	/* Unserialized, strictly 'current' */
 
+	/*
+	 * This field must not be in the scheduler word above due to wakelist
+	 * queueing no longer being serialized by p->on_cpu. However:
+	 *
+	 * p->XXX = X;			ttwu()
+	 * schedule()			  if (p->on_rq && ..) // false
+	 *   smp_mb__after_spinlock();	  if (smp_load_acquire(&p->on_cpu) && //true
+	 *   deactivate_task()		      ttwu_queue_wakelist())
+	 *     p->on_rq = 0;			p->sched_remote_wakeup = Y;
+	 *
+	 * guarantees all stores of 'current' are visible before
+	 * ->sched_remote_wakeup gets used, so it can be in this word.
+	 */
+	unsigned			sched_remote_wakeup:1;
+
 	/* Bit to tell LSMs we're in execve(): */
 	unsigned			in_execve:1;
 	unsigned			in_iowait:1;
