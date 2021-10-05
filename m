Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355FD422A7A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbhJEOOn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:14:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51450 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbhJEOOG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:14:06 -0400
Date:   Tue, 05 Oct 2021 14:12:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443135;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SEEFXF0eIt9E1eVyqgciSyLaI8/n13IoGCGBRDW//98=;
        b=KfLrT4eN1DwYVEylIdZs4DCsJ/m9w9Hk3ziwnMQadW/DQI3Tl5J5ATEr5lYvy9LLcIpvjj
        Sy8frzSxXPBweEQ5uWHW9QPGImq+GCqwokv1XiR/alIinNB7R0/27QvQ5ARTEUrEVOFvvb
        q2WysL73Nfrkl8rmpSyE+t/9DgSkCKpalMv/+PJDXmAQu7W1kdZKxr6shGo2i1LZOyZ6mR
        LC2m5jICbcil66g16784LNxqd89ntir0Gummr5jX0U2UMr1Y0gSeclxJM5+bp4vCjMt3aU
        3ws1aL3pMxCLcQk8nUZdECyXB+mrx4+F9WjGg+4NamhYoe4jP9tHHZU3Ycc/ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443135;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SEEFXF0eIt9E1eVyqgciSyLaI8/n13IoGCGBRDW//98=;
        b=Vy4rGL+8IkD+Ktot0h01CvbYZZ50EkBALtjbjkA+/XN6QyxaEgIT99T6z8QnJ1rTsdDjfK
        w+U6ZnwIsQcYZcBA==
From:   "tip-bot2 for Josh Don" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Account number of SCHED_IDLE entities on each cfs_rq
Cc:     Josh Don <joshdon@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210820010403.946838-3-joshdon@google.com>
References: <20210820010403.946838-3-joshdon@google.com>
MIME-Version: 1.0
Message-ID: <163344313422.25758.278041965196407269.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a480addecc0d89c200ec0b41da62ae8ceddca8d7
Gitweb:        https://git.kernel.org/tip/a480addecc0d89c200ec0b41da62ae8ceddca8d7
Author:        Josh Don <joshdon@google.com>
AuthorDate:    Thu, 19 Aug 2021 18:04:01 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:51:36 +02:00

sched: Account number of SCHED_IDLE entities on each cfs_rq

Adds cfs_rq->idle_nr_running, which accounts the number of idle entities
directly enqueued on the cfs_rq.

Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20210820010403.946838-3-joshdon@google.com
---
 kernel/sched/debug.c |  2 ++
 kernel/sched/fair.c  | 25 ++++++++++++++++++++++++-
 kernel/sched/sched.h |  1 +
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 17a653b..2e5fdd9 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -614,6 +614,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			cfs_rq->nr_spread_over);
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_running);
+	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
+			cfs_rq->idle_nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_h_nr_running",
 			cfs_rq->idle_h_nr_running);
 	SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->load.weight);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6cc958e..9c78c16 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2995,6 +2995,8 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	}
 #endif
 	cfs_rq->nr_running++;
+	if (se_is_idle(se))
+		cfs_rq->idle_nr_running++;
 }
 
 static void
@@ -3008,6 +3010,8 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	}
 #endif
 	cfs_rq->nr_running--;
+	if (se_is_idle(se))
+		cfs_rq->idle_nr_running--;
 }
 
 /*
@@ -5577,6 +5581,17 @@ static int sched_idle_rq(struct rq *rq)
 			rq->nr_running);
 }
 
+/*
+ * Returns true if cfs_rq only has SCHED_IDLE entities enqueued. Note the use
+ * of idle_nr_running, which does not consider idle descendants of normal
+ * entities.
+ */
+static bool sched_idle_cfs_rq(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq->nr_running &&
+		cfs_rq->nr_running == cfs_rq->idle_nr_running;
+}
+
 #ifdef CONFIG_SMP
 static int sched_idle_cpu(int cpu)
 {
@@ -11575,7 +11590,7 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 	for_each_possible_cpu(i) {
 		struct rq *rq = cpu_rq(i);
 		struct sched_entity *se = tg->se[i];
-		struct cfs_rq *grp_cfs_rq = tg->cfs_rq[i];
+		struct cfs_rq *parent_cfs_rq, *grp_cfs_rq = tg->cfs_rq[i];
 		bool was_idle = cfs_rq_is_idle(grp_cfs_rq);
 		long idle_task_delta;
 		struct rq_flags rf;
@@ -11586,6 +11601,14 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 		if (WARN_ON_ONCE(was_idle == cfs_rq_is_idle(grp_cfs_rq)))
 			goto next_cpu;
 
+		if (se->on_rq) {
+			parent_cfs_rq = cfs_rq_of(se);
+			if (cfs_rq_is_idle(grp_cfs_rq))
+				parent_cfs_rq->idle_nr_running++;
+			else
+				parent_cfs_rq->idle_nr_running--;
+		}
+
 		idle_task_delta = grp_cfs_rq->h_nr_running -
 				  grp_cfs_rq->idle_h_nr_running;
 		if (!cfs_rq_is_idle(grp_cfs_rq))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1fec313..f2965b5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -530,6 +530,7 @@ struct cfs_rq {
 	struct load_weight	load;
 	unsigned int		nr_running;
 	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
+	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
 
 	u64			exec_clock;
