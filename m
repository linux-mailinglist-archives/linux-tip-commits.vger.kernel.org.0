Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CDD440DC5
	for <lists+linux-tip-commits@lfdr.de>; Sun, 31 Oct 2021 11:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbhJaKTC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 31 Oct 2021 06:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhJaKTA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 31 Oct 2021 06:19:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47869C061570;
        Sun, 31 Oct 2021 03:16:29 -0700 (PDT)
Date:   Sun, 31 Oct 2021 10:16:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635675387;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OjADXqmyOVWvfdpc7LfCdHWZSHlCAZUfg6bYVb8JAfk=;
        b=mo55E2fAg+4j5T/ZZMPPYFovJC1t+a68cAqIXQNAmdkRDG68xuobG4VF6TMF8gvM3YW5aM
        SQ3Rb/fG09THEYLs5+T/qk1lBFlKpCz1oc3Sh7z8Tzop/cbvzv+KH9gTJfzZxXEsPlDkrW
        X1HVGVcRh57oJKSWr5ADvHP0ROkVU4+tZS+nn3ClX8Ln1lpla4fXCh95eNjOXR3Usg802c
        yj64Z7H7ZkUlneTo9UisdX7J45ubDgKtpboXOGVeDyA95OItjIsGorA5WrVJV6brc8pa8w
        C0cRye69G0n9z2MOgKKKA63wYbqra7tFXU6sxJk2AUgBK0nIq59iEva0zMJQjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635675388;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OjADXqmyOVWvfdpc7LfCdHWZSHlCAZUfg6bYVb8JAfk=;
        b=DW9Voe4XaFF3+kjEosd9JlL77yPZxdsh8EjAyRoDtdiats9qKh63VmGYe6WUDlnoCahq8X
        B8ajXs7rCqDnKBDw==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Account update_blocked_averages in
 newidle_balance cost
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211019123537.17146-2-vincent.guittot@linaro.org>
References: <20211019123537.17146-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <163567538702.626.3632817965971500674.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9e9af819db5dbe4bf99101628955a26e2a41a1a5
Gitweb:        https://git.kernel.org/tip/9e9af819db5dbe4bf99101628955a26e2a41a1a5
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 19 Oct 2021 14:35:33 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 31 Oct 2021 11:11:37 +01:00

sched/fair: Account update_blocked_averages in newidle_balance cost

The time spent to update the blocked load can be significant depending of
the complexity fo the cgroup hierarchy. Take this time into account in
the cost of the 1st load balance of a newly idle cpu.

Also reduce the number of call to sched_clock_cpu() and track more actual
work.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lore.kernel.org/r/20211019123537.17146-2-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 87db481..c014567 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10840,9 +10840,9 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 {
 	unsigned long next_balance = jiffies + HZ;
 	int this_cpu = this_rq->cpu;
+	u64 t0, t1, curr_cost = 0;
 	struct sched_domain *sd;
 	int pulled_task = 0;
-	u64 curr_cost = 0;
 
 	update_misfit_status(NULL, this_rq);
 
@@ -10887,11 +10887,13 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 	raw_spin_rq_unlock(this_rq);
 
+	t0 = sched_clock_cpu(this_cpu);
 	update_blocked_averages(this_cpu);
+
 	rcu_read_lock();
 	for_each_domain(this_cpu, sd) {
 		int continue_balancing = 1;
-		u64 t0, domain_cost;
+		u64 domain_cost;
 
 		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
 			update_next_balance(sd, &next_balance);
@@ -10899,17 +10901,18 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 		}
 
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
-			t0 = sched_clock_cpu(this_cpu);
 
 			pulled_task = load_balance(this_cpu, this_rq,
 						   sd, CPU_NEWLY_IDLE,
 						   &continue_balancing);
 
-			domain_cost = sched_clock_cpu(this_cpu) - t0;
+			t1 = sched_clock_cpu(this_cpu);
+			domain_cost = t1 - t0;
 			if (domain_cost > sd->max_newidle_lb_cost)
 				sd->max_newidle_lb_cost = domain_cost;
 
 			curr_cost += domain_cost;
+			t0 = t1;
 		}
 
 		update_next_balance(sd, &next_balance);
