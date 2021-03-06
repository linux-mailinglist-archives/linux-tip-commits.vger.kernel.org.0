Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB0132FA05
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhCFLmf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhCFLmZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:42:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1020C06175F;
        Sat,  6 Mar 2021 03:42:24 -0800 (PST)
Date:   Sat, 06 Mar 2021 11:42:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615030942;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=evVtT+/6z7Xan8Rrz/GxVFPig5BbMpKmZRjkJ6pKs5g=;
        b=DU5/k5kkWiZF7bRSFe1KuZsngoG+p2CwiICtpgAVnUonqnv2k5hJ5RapKAayOek0w3dFUD
        TaZOir2Ycl3H0M7WRismnmV3Bxj43RuT6zdJw70XH3vi+X9X0HEQC7mh6fE+ijauE+4S+6
        r58bFW3PwS06EWXfZhibRrDS4q4Nc5FnN5GlXDfMRKsuHcuIJp46NBosifzGcoBeZUYslU
        MXtIwWb4VtRMVRNir+PVffGTR4Uelhn98DDcJLg4uwmXBDqSe1GFtD9vuZvrZuSjugskQX
        ivtYpv58QwWW0vJVgnogq1EANwqhHzK1F4TM4h1WYKpTwFhQ11Y4T+hrFWmzAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615030942;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=evVtT+/6z7Xan8Rrz/GxVFPig5BbMpKmZRjkJ6pKs5g=;
        b=KijHUtsqGreP4g6tzEWReRABcS2L3NxE45FfPN8iTSta2OvgrRVphUvKEeESRzcYVOq/U6
        iYWgf/31nCCTlgDg==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Trigger the update of blocked load on
 newly idle cpu
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210224133007.28644-7-vincent.guittot@linaro.org>
References: <20210224133007.28644-7-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <161503094217.398.1812009828160393926.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c6f886546cb8a38617cdbe755fe50d3acd2463e4
Gitweb:        https://git.kernel.org/tip/c6f886546cb8a38617cdbe755fe50d3acd2463e4
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 24 Feb 2021 14:30:06 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:40:22 +01:00

sched/fair: Trigger the update of blocked load on newly idle cpu

Instead of waking up a random and already idle CPU, we can take advantage
of this_cpu being about to enter idle to run the ILB and update the
blocked load.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210224133007.28644-7-vincent.guittot@linaro.org
---
 kernel/sched/core.c  |  2 +-
 kernel/sched/fair.c  | 24 +++++++++++++++++++++---
 kernel/sched/idle.c  |  6 ++++++
 kernel/sched/sched.h |  7 +++++++
 4 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f9dfb34..361974e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -737,7 +737,7 @@ static void nohz_csd_func(void *info)
 	/*
 	 * Release the rq::nohz_csd.
 	 */
-	flags = atomic_fetch_andnot(NOHZ_KICK_MASK, nohz_flags(cpu));
+	flags = atomic_fetch_andnot(NOHZ_KICK_MASK | NOHZ_NEWILB_KICK, nohz_flags(cpu));
 	WARN_ON(!(flags & NOHZ_KICK_MASK));
 
 	rq->idle_balance = idle_cpu(cpu);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 356a245..e87e1b3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10453,6 +10453,24 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 	return true;
 }
 
+/*
+ * Check if we need to run the ILB for updating blocked load before entering
+ * idle state.
+ */
+void nohz_run_idle_balance(int cpu)
+{
+	unsigned int flags;
+
+	flags = atomic_fetch_andnot(NOHZ_NEWILB_KICK, nohz_flags(cpu));
+
+	/*
+	 * Update the blocked load only if no SCHED_SOFTIRQ is about to happen
+	 * (ie NOHZ_STATS_KICK set) and will do the same.
+	 */
+	if ((flags == NOHZ_NEWILB_KICK) && !need_resched())
+		_nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK, CPU_IDLE);
+}
+
 static void nohz_newidle_balance(struct rq *this_rq)
 {
 	int this_cpu = this_rq->cpu;
@@ -10474,10 +10492,10 @@ static void nohz_newidle_balance(struct rq *this_rq)
 		return;
 
 	/*
-	 * Blocked load of idle CPUs need to be updated.
-	 * Kick an ILB to update statistics.
+	 * Set the need to trigger ILB in order to update blocked load
+	 * before entering idle state.
 	 */
-	kick_ilb(NOHZ_STATS_KICK);
+	atomic_or(NOHZ_NEWILB_KICK, nohz_flags(this_cpu));
 }
 
 #else /* !CONFIG_NO_HZ_COMMON */
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 7199e6f..7a92d60 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -261,6 +261,12 @@ exit_idle:
 static void do_idle(void)
 {
 	int cpu = smp_processor_id();
+
+	/*
+	 * Check if we need to update blocked load
+	 */
+	nohz_run_idle_balance(cpu);
+
 	/*
 	 * If the arch has a polling bit, we maintain an invariant:
 	 *
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 10a1522..0ddc9a6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2385,9 +2385,11 @@ extern void cfs_bandwidth_usage_dec(void);
 #ifdef CONFIG_NO_HZ_COMMON
 #define NOHZ_BALANCE_KICK_BIT	0
 #define NOHZ_STATS_KICK_BIT	1
+#define NOHZ_NEWILB_KICK_BIT	2
 
 #define NOHZ_BALANCE_KICK	BIT(NOHZ_BALANCE_KICK_BIT)
 #define NOHZ_STATS_KICK		BIT(NOHZ_STATS_KICK_BIT)
+#define NOHZ_NEWILB_KICK	BIT(NOHZ_NEWILB_KICK_BIT)
 
 #define NOHZ_KICK_MASK	(NOHZ_BALANCE_KICK | NOHZ_STATS_KICK)
 
@@ -2398,6 +2400,11 @@ extern void nohz_balance_exit_idle(struct rq *rq);
 static inline void nohz_balance_exit_idle(struct rq *rq) { }
 #endif
 
+#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
+extern void nohz_run_idle_balance(int cpu);
+#else
+static inline void nohz_run_idle_balance(int cpu) { }
+#endif
 
 #ifdef CONFIG_SMP
 static inline
