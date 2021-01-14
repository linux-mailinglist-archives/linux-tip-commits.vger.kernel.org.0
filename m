Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054802F6015
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Jan 2021 12:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbhANLar (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Jan 2021 06:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbhANLaW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Jan 2021 06:30:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5C5C061794;
        Thu, 14 Jan 2021 03:29:08 -0800 (PST)
Date:   Thu, 14 Jan 2021 11:29:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610623747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GmsGgMeN4E531jZ3u9luENUm4OqNVRUeFal9JzFB6Z0=;
        b=14KC6FPgxTS9km/7b1wVMrrFurMBDdYtGdF2QibdCdt8ry9wgjaP8d53HeV+CmHR9f6MNu
        gBWAgJ3x17YvSwqiq6nmiLSNo/tdZD9foO4FjM+JZ1RkzwHme6bK4su5sJjjmMLRKlV8Uo
        m9IvSz6ahz6ONwNfZAIwZTNd8iNSD/xRXFDE+siIG8cWl7DibYBQ2Nv/FD817iD2agHfI1
        G3Xkfe7xariYNXhF4mHXqo8cIrekupDoNUweeVnLXSaQPFL9EbTYG9XHb5TdqSf0htVpwC
        x34oWjYRvy83rPPYCuQiWcLCuVXFt1UkrD5gUAvGoqUyMW4taOd2I87iqEoU4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610623747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GmsGgMeN4E531jZ3u9luENUm4OqNVRUeFal9JzFB6Z0=;
        b=+vhLZK9crhwOyalA/yFuY+JGZCO59e0LpNrhqf6BC7cAsAWRlB1OOPGlZhctS1lJ+UGWBV
        9VXH7SEvHLj+OGCw==
From:   "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Prevent raising SCHED_SOFTIRQ when CPU is !active
Cc:     "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201215104400.9435-1-anna-maria@linutronix.de>
References: <20201215104400.9435-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Message-ID: <161062374680.414.3413210460727560383.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e0b257c3b71bd98a4866c3daecf000998aaa4927
Gitweb:        https://git.kernel.org/tip/e0b257c3b71bd98a4866c3daecf000998aaa4927
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 15 Dec 2020 11:44:00 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Jan 2021 11:20:09 +01:00

sched: Prevent raising SCHED_SOFTIRQ when CPU is !active

SCHED_SOFTIRQ is raised to trigger periodic load balancing. When CPU is not
active, CPU should not participate in load balancing.

The scheduler uses nohz.idle_cpus_mask to keep track of the CPUs which can
do idle load balancing. When bringing a CPU up the CPU is added to the mask
when it reaches the active state, but on teardown the CPU stays in the mask
until it goes offline and invokes sched_cpu_dying().

When SCHED_SOFTIRQ is raised on a !active CPU, there might be a pending
softirq when stopping the tick which triggers a warning in NOHZ code. The
SCHED_SOFTIRQ can also be raised by the scheduler tick which has the same
issue.

Therefore remove the CPU from nohz.idle_cpus_mask when it is marked
inactive and also prevent the scheduler_tick() from raising SCHED_SOFTIRQ
after this point.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: https://lkml.kernel.org/r/20201215104400.9435-1-anna-maria@linutronix.de
---
 kernel/sched/core.c | 7 ++++++-
 kernel/sched/fair.c | 7 +++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4fe4cbf..06b4499 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7596,6 +7596,12 @@ int sched_cpu_deactivate(unsigned int cpu)
 	struct rq_flags rf;
 	int ret;
 
+	/*
+	 * Remove CPU from nohz.idle_cpus_mask to prevent participating in
+	 * load balancing when not active
+	 */
+	nohz_balance_exit_idle(rq);
+
 	set_cpu_active(cpu, false);
 	/*
 	 * We've cleared cpu_active_mask, wait for all preempt-disabled and RCU
@@ -7702,7 +7708,6 @@ int sched_cpu_dying(unsigned int cpu)
 
 	calc_load_migrate(rq);
 	update_max_interval();
-	nohz_balance_exit_idle(rq);
 	hrtick_clear(rq);
 	return 0;
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 39c5bda..389cb58 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10700,8 +10700,11 @@ static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
  */
 void trigger_load_balance(struct rq *rq)
 {
-	/* Don't need to rebalance while attached to NULL domain */
-	if (unlikely(on_null_domain(rq)))
+	/*
+	 * Don't need to rebalance while attached to NULL domain or
+	 * runqueue CPU is not active
+	 */
+	if (unlikely(on_null_domain(rq) || !cpu_active(cpu_of(rq))))
 		return;
 
 	if (time_after_eq(jiffies, rq->next_balance))
