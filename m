Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95ABC404921
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Sep 2021 13:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbhIILTz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 9 Sep 2021 07:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbhIILTn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 9 Sep 2021 07:19:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF42C0613C1;
        Thu,  9 Sep 2021 04:18:34 -0700 (PDT)
Date:   Thu, 09 Sep 2021 11:18:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631186312;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sbsnWyflh7v9/W/pHYLGS4xuthwnYl+zBqmpangxLww=;
        b=cYodRph5HXlrQvi7Yt5bdeBgjNqfTEaNLNXycQMn077ba1mSfu8tB+ZmZ0T0N5PPKGDm/B
        bjbPQxCB9Ta/l9EjCHZNUqc70ACXN/43NHGETKNIBG4VQZPuBF2A6MaET53uq8CYIsdv4g
        7vJfY2VBfgt67wAUOHheImSNBrVTtDAqiHxqM4iwWo69OAloWKZOsc+cASDGcnqA9mJL66
        VhE6gRdLW5rwlYVp72QvYLfmFVBHKpQs3laiYRgRwpCfK20aLshBUIkzpe4Xv1sTU8h33x
        LrSw4sPZtgJ4gx+pqyy9ODSn1MbhPA9ALNY1sxk14NFZcHLILLwP2bB8/zTTiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631186312;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sbsnWyflh7v9/W/pHYLGS4xuthwnYl+zBqmpangxLww=;
        b=QcYcXpKc12QFZAZYfG9i6v9eMeZSR9S6rmXentguLyqA+gHrFmXVjsVpiB7zjzydQVF2yB
        MllylXUZoPXskjAg==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Add NOHZ balancer flag for
 nohz.next_balance updates
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210823111700.2842997-2-valentin.schneider@arm.com>
References: <20210823111700.2842997-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <163118631198.25758.15468625029748806575.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     013ce5ed58f799a2f035b732f904f6ebd8e8d881
Gitweb:        https://git.kernel.org/tip/013ce5ed58f799a2f035b732f904f6ebd8e8d881
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Mon, 23 Aug 2021 12:16:59 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 09 Sep 2021 11:27:29 +02:00

sched/fair: Add NOHZ balancer flag for nohz.next_balance updates

A following patch will trigger NOHZ idle balances as a means to update
nohz.next_balance. Vincent noted that blocked load updates can have
non-negligible overhead, which should be avoided if the intent is to only
update nohz.next_balance.

Add a new NOHZ balance kick flag, NOHZ_NEXT_KICK. Gate NOHZ blocked load
update by the presence of NOHZ_STATS_KICK - currently all NOHZ balance
kicks will have the NOHZ_STATS_KICK flag set, so no change in behaviour is
expected.

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210823111700.2842997-2-valentin.schneider@arm.com
---
 kernel/sched/fair.c  | 24 ++++++++++++++----------
 kernel/sched/sched.h |  8 +++++++-
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7b3e859..48ce754 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10342,7 +10342,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		goto out;
 
 	if (rq->nr_running >= 2) {
-		flags = NOHZ_KICK_MASK;
+		flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 		goto out;
 	}
 
@@ -10356,7 +10356,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * on.
 		 */
 		if (rq->cfs.h_nr_running >= 1 && check_cpu_capacity(rq, sd)) {
-			flags = NOHZ_KICK_MASK;
+			flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 			goto unlock;
 		}
 	}
@@ -10370,7 +10370,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 */
 		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
 			if (sched_asym_prefer(i, cpu)) {
-				flags = NOHZ_KICK_MASK;
+				flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 				goto unlock;
 			}
 		}
@@ -10383,7 +10383,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * to run the misfit task on.
 		 */
 		if (check_misfit_status(rq, sd)) {
-			flags = NOHZ_KICK_MASK;
+			flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 			goto unlock;
 		}
 
@@ -10410,7 +10410,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 */
 		nr_busy = atomic_read(&sds->nr_busy_cpus);
 		if (nr_busy > 1) {
-			flags = NOHZ_KICK_MASK;
+			flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 			goto unlock;
 		}
 	}
@@ -10572,7 +10572,8 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	 * setting the flag, we are sure to not clear the state and not
 	 * check the load of an idle cpu.
 	 */
-	WRITE_ONCE(nohz.has_blocked, 0);
+	if (flags & NOHZ_STATS_KICK)
+		WRITE_ONCE(nohz.has_blocked, 0);
 
 	/*
 	 * Ensures that if we miss the CPU, we must see the has_blocked
@@ -10594,13 +10595,15 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 		 * balancing owner will pick it up.
 		 */
 		if (need_resched()) {
-			has_blocked_load = true;
+			if (flags & NOHZ_STATS_KICK)
+				has_blocked_load = true;
 			goto abort;
 		}
 
 		rq = cpu_rq(balance_cpu);
 
-		has_blocked_load |= update_nohz_stats(rq);
+		if (flags & NOHZ_STATS_KICK)
+			has_blocked_load |= update_nohz_stats(rq);
 
 		/*
 		 * If time for next balance is due,
@@ -10631,8 +10634,9 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	if (likely(update_next_balance))
 		nohz.next_balance = next_balance;
 
-	WRITE_ONCE(nohz.next_blocked,
-		now + msecs_to_jiffies(LOAD_AVG_PERIOD));
+	if (flags & NOHZ_STATS_KICK)
+		WRITE_ONCE(nohz.next_blocked,
+			   now + msecs_to_jiffies(LOAD_AVG_PERIOD));
 
 abort:
 	/* There is still blocked load, enable periodic update */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e7e2bba..30b7bd2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2706,12 +2706,18 @@ extern void cfs_bandwidth_usage_dec(void);
 #define NOHZ_BALANCE_KICK_BIT	0
 #define NOHZ_STATS_KICK_BIT	1
 #define NOHZ_NEWILB_KICK_BIT	2
+#define NOHZ_NEXT_KICK_BIT	3
 
+/* Run rebalance_domains() */
 #define NOHZ_BALANCE_KICK	BIT(NOHZ_BALANCE_KICK_BIT)
+/* Update blocked load */
 #define NOHZ_STATS_KICK		BIT(NOHZ_STATS_KICK_BIT)
+/* Update blocked load when entering idle */
 #define NOHZ_NEWILB_KICK	BIT(NOHZ_NEWILB_KICK_BIT)
+/* Update nohz.next_balance */
+#define NOHZ_NEXT_KICK		BIT(NOHZ_NEXT_KICK_BIT)
 
-#define NOHZ_KICK_MASK	(NOHZ_BALANCE_KICK | NOHZ_STATS_KICK)
+#define NOHZ_KICK_MASK	(NOHZ_BALANCE_KICK | NOHZ_STATS_KICK | NOHZ_NEXT_KICK)
 
 #define nohz_flags(cpu)	(&cpu_rq(cpu)->nohz_flags)
 
