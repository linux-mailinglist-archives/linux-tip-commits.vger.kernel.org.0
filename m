Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25DF440DC2
	for <lists+linux-tip-commits@lfdr.de>; Sun, 31 Oct 2021 11:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhJaKTA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 31 Oct 2021 06:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhJaKS7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 31 Oct 2021 06:18:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B55C061746;
        Sun, 31 Oct 2021 03:16:27 -0700 (PDT)
Date:   Sun, 31 Oct 2021 10:16:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635675386;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xnW2hm8mdRSXiMT1Z38l2h6CPdmFFJ+QxIxB1b6lpjE=;
        b=bsgzHLTAoSfg+GIChepr+Y/fBOezI2CX0s70qEHZmATLohLNnyUj5qa6PSc4JBK6Z1ZxHK
        gHmWoNn7O0vj41gQopRLKFZ+4UHmtp/Ne/oKLMSun4C3FqvBJGIiwWpQtxXnQrfoK7jjd6
        Nl/u9BRMwHuBfJb9ktqLujaJnvOk96voiUPruG6Tcc+6JeV+pBY+S5Rrmy8hdsMUnYpyG9
        fEW6dRQFmiQkTuZ8n8aX4nNM3hbYQJFl6G81KW52vU5MxzsVzmvuedPvpv9cIDXE+HCeRN
        9g4Ca1YFL4lJQtkQaa4xHWmZ4AMMOfUNgvNXm4PG2ZqT/PXyqEPtBIisy/oWrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635675386;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xnW2hm8mdRSXiMT1Z38l2h6CPdmFFJ+QxIxB1b6lpjE=;
        b=EppxFTTQG1Ed1YRkYYthvO38s2vIa7COC6fs0AfJ96Vt+bRw6UKQ+rMsMmfCaLA+xwRIdU
        nrsE9epdqWh0ANAQ==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Wait before decaying max_newidle_lb_cost
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211019123537.17146-4-vincent.guittot@linaro.org>
References: <20211019123537.17146-4-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <163567538547.626.13303083323341603297.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e60b56e46b384cee1ad34e6adc164d883049c6c3
Gitweb:        https://git.kernel.org/tip/e60b56e46b384cee1ad34e6adc164d883049c6c3
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 19 Oct 2021 14:35:35 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 31 Oct 2021 11:11:38 +01:00

sched/fair: Wait before decaying max_newidle_lb_cost

Decay max_newidle_lb_cost only when it has not been updated for a while
and ensure to not decay a recently changed value.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lore.kernel.org/r/20211019123537.17146-4-vincent.guittot@linaro.org
---
 include/linux/sched/topology.h |  2 +-
 kernel/sched/fair.c            | 36 ++++++++++++++++++++++++---------
 kernel/sched/topology.c        |  2 +-
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 2f9166f..c07bfa2 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -105,7 +105,7 @@ struct sched_domain {
 
 	/* idle_balance() stats */
 	u64 max_newidle_lb_cost;
-	unsigned long next_decay_max_lb_cost;
+	unsigned long last_decay_max_lb_cost;
 
 	u64 avg_scan_cost;		/* select_idle_sibling */
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c4c3686..e50fd75 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10239,6 +10239,30 @@ void update_max_interval(void)
 	max_load_balance_interval = HZ*num_online_cpus()/10;
 }
 
+static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
+{
+	if (cost > sd->max_newidle_lb_cost) {
+		/*
+		 * Track max cost of a domain to make sure to not delay the
+		 * next wakeup on the CPU.
+		 */
+		sd->max_newidle_lb_cost = cost;
+		sd->last_decay_max_lb_cost = jiffies;
+	} else if (time_after(jiffies, sd->last_decay_max_lb_cost + HZ)) {
+		/*
+		 * Decay the newidle max times by ~1% per second to ensure that
+		 * it is not outdated and the current max cost is actually
+		 * shorter.
+		 */
+		sd->max_newidle_lb_cost = (sd->max_newidle_lb_cost * 253) / 256;
+		sd->last_decay_max_lb_cost = jiffies;
+
+		return true;
+	}
+
+	return false;
+}
+
 /*
  * It checks each scheduling domain to see if it is due to be balanced,
  * and initiates a balancing operation if so.
@@ -10262,14 +10286,9 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 	for_each_domain(cpu, sd) {
 		/*
 		 * Decay the newidle max times here because this is a regular
-		 * visit to all the domains. Decay ~1% per second.
+		 * visit to all the domains.
 		 */
-		if (time_after(jiffies, sd->next_decay_max_lb_cost)) {
-			sd->max_newidle_lb_cost =
-				(sd->max_newidle_lb_cost * 253) / 256;
-			sd->next_decay_max_lb_cost = jiffies + HZ;
-			need_decay = 1;
-		}
+		need_decay = update_newidle_cost(sd, 0);
 		max_cost += sd->max_newidle_lb_cost;
 
 		/*
@@ -10911,8 +10930,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 			t1 = sched_clock_cpu(this_cpu);
 			domain_cost = t1 - t0;
-			if (domain_cost > sd->max_newidle_lb_cost)
-				sd->max_newidle_lb_cost = domain_cost;
+			update_newidle_cost(sd, domain_cost);
 
 			curr_cost += domain_cost;
 			t0 = t1;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index e812467..30169c7 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1568,7 +1568,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		.last_balance		= jiffies,
 		.balance_interval	= sd_weight,
 		.max_newidle_lb_cost	= 0,
-		.next_decay_max_lb_cost	= jiffies,
+		.last_decay_max_lb_cost	= jiffies,
 		.child			= child,
 #ifdef CONFIG_SCHED_DEBUG
 		.name			= tl->name,
