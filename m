Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1111532B028
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Mar 2021 04:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbhCCDeC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Mar 2021 22:34:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35668 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378832AbhCBJD0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Mar 2021 04:03:26 -0500
Date:   Tue, 02 Mar 2021 09:01:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614675715;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rQqqAUTPo2dYbb3X9g5nIQAMGcVCpCBWOGBwlnT00TQ=;
        b=yltV/SkICtD5kgoXqcbHD7q8vg9LyylU19yaTXBKYKraS7Bsosyw1if8syz6oa6MDcwZLs
        RMAQsb57vwlgTdpo74Op6o/RA+Vlj+ilGx5uVdDlQtH13GOdtObR9n4VzzrSlEZ/uao1Q3
        VsyjDBEyA6k9cwmmO5Ssj2qptX3DAqGHGn2y5TZKo3RA7zcMbC5IGj4nwmPPDHFb0PZtks
        sR/fedAJXEcZy1AH7YiebD9mbKdnqzfdmKdpx+mbl2J6B1X1BRLdwpGuX75smIhTXH3S7a
        rjTu03A+ja9anrtxy77MDYHmXT4GznMVdaxW1ZT7ozyJzPh1UXEGlQt0EB5GfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614675715;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rQqqAUTPo2dYbb3X9g5nIQAMGcVCpCBWOGBwlnT00TQ=;
        b=oea+m/y55jkMId8iCamacTe0xIOrIA9dgKM3yt2YS71M5RehNVqPBL0D4/h6BGeWIxSlWu
        O5JUDa3kCqBXyxCg==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Trigger the update of blocked load on
 newly idle cpu
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210224133007.28644-7-vincent.guittot@linaro.org>
References: <20210224133007.28644-7-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <161467571458.20312.9603244485224907644.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1705e3b449f62d957e897239ef6c67ca574acfc6
Gitweb:        https://git.kernel.org/tip/1705e3b449f62d957e897239ef6c67ca574acfc6
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 24 Feb 2021 14:30:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Mar 2021 18:17:24 +01:00

sched/fair: Trigger the update of blocked load on newly idle cpu

Instead of waking up a random and already idle CPU, we can take advantage
of this_cpu being about to enter idle to run the ILB and update the
blocked load.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
