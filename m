Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0889037F87F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 May 2021 15:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhEMNS5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 13 May 2021 09:18:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58478 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbhEMNSk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 13 May 2021 09:18:40 -0400
Date:   Thu, 13 May 2021 13:17:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620911847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05xg9LBO1PrI50ZNRoniTyWkX247WTmcQVM2MRXgyBg=;
        b=DJjR9OV9d/3x8kVs6qMPZQXxxXB4PtX7xycgESJSClLelHIS7XnZUHmnK5Nv7QdSSsLWIK
        DAsHt0znpbVYqsLzIYhfbJvw1GgPiSwJ57WO2r5HPnQyiYreziGHDX95QjgApzN8AZYkT9
        l5A6ONg37CrXDxHz09to49dqtX4VTh0CKMD+IqOdBYn1itkUr5vCMhLspm5ZsAIrRYeNQC
        Wi9/55JeP9l5xcp4ojG2aMe1kx6pVw8F6NEqGQ/3KTzLN5MqeGHemNmOLcRvev/P9l0G2J
        XcQ/ZUfq1aXxP3ZSvFVhRmLBI1OAb6eUSwn3DYb3OwAzhY6b6WoFoZScY2Ielg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620911847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05xg9LBO1PrI50ZNRoniTyWkX247WTmcQVM2MRXgyBg=;
        b=dQufZow39I3k81O9wu9U6dt1lrDxA2IZ791GdsdQ28R2tpumxkTCazFJv4XWNqa5JbUlcU
        7SSEUz/n1oIp54BQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/nohz] tick/nohz: Call tick_nohz_task_switch() with
 interrupts disabled
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210512232924.150322-10-frederic@kernel.org>
References: <20210512232924.150322-10-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <162091184636.29796.12181915470545082709.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/nohz branch of tip:

Commit-ID:     0fdcccfafcffac70b452b3127cc3d981f0117655
Gitweb:        https://git.kernel.org/tip/0fdcccfafcffac70b452b3127cc3d981f0117655
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 13 May 2021 01:29:23 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 13 May 2021 14:21:23 +02:00

tick/nohz: Call tick_nohz_task_switch() with interrupts disabled

Call tick_nohz_task_switch() slightly earlier after the context switch
to benefit from disabled IRQs. This way the function doesn't need to
disable them once more.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210512232924.150322-10-frederic@kernel.org
---
 kernel/sched/core.c      | 2 +-
 kernel/time/tick-sched.c | 7 +------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 78e480f..8f86ac2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4212,6 +4212,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	vtime_task_switch(prev);
 	perf_event_task_sched_in(prev, current);
 	finish_task(prev);
+	tick_nohz_task_switch();
 	finish_lock_switch(rq);
 	finish_arch_post_lock_switch();
 	kcov_finish_switch(current);
@@ -4257,7 +4258,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		put_task_struct_rcu_user(prev);
 	}
 
-	tick_nohz_task_switch();
 	return rq;
 }
 
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 197a3bd..6ea619d 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -487,13 +487,10 @@ void tick_nohz_dep_clear_signal(struct signal_struct *sig, enum tick_dep_bits bi
  */
 void __tick_nohz_task_switch(void)
 {
-	unsigned long flags;
 	struct tick_sched *ts;
 
-	local_irq_save(flags);
-
 	if (!tick_nohz_full_cpu(smp_processor_id()))
-		goto out;
+		return;
 
 	ts = this_cpu_ptr(&tick_cpu_sched);
 
@@ -502,8 +499,6 @@ void __tick_nohz_task_switch(void)
 		    atomic_read(&current->signal->tick_dep_mask))
 			tick_nohz_full_kick();
 	}
-out:
-	local_irq_restore(flags);
 }
 
 /* Get the boot-time nohz CPU list from the kernel parameters. */
