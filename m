Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38018422A60
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbhJEOOH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbhJEON4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:13:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CFCC061762;
        Tue,  5 Oct 2021 07:12:02 -0700 (PDT)
Date:   Tue, 05 Oct 2021 14:12:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443120;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NrPOTq32uRQvyRlBZw3MOxvPz+BY2PXpQk2EMrgWshs=;
        b=QL+9HYlybDvcNb4M4zoO6c0wbuLmOiITFEOYOisIHOw0H0q+9tXJbCxXPk08YGmCjbs18f
        Ycm6pTS/oTCoplm8WSGPnATBew3/XL/oQUD6f8fFYMLH35ONnXIe4hY0Cx20G9HW0IuV1K
        vFXtYhhUdx83eTT6fxbEe6x82Rpd+2mNAzPKtbXBKylrFuMT52cFiZVwNc+HmpEckitsS6
        pfFYr3I2eWVCMmkSJekoFvYcpD3IpqpF4kRX7DN/LqI+6PW7Ht8J+VFafU/IpA+KKu6GKF
        /Yr3VZXGZ5/SDZ6telct05zcBRMKjPWbnK91llBo4qzvARrUHHshWMCzwl6p3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443120;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NrPOTq32uRQvyRlBZw3MOxvPz+BY2PXpQk2EMrgWshs=;
        b=g1cbfJ53T1EPxYb7/jhm4uOp8Fhl7k+ygji7Q8+b1/r2cu+KZSP9RH1fQJDkXg+IVgf0ap
        q62Npw1nra0ZjIDA==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Consider SMT in ASYM_PACKING load balance
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Len Brown <len.brown@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210911011819.12184-7-ricardo.neri-calderon@linux.intel.com>
References: <20210911011819.12184-7-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-ID: <163344312006.25758.13191074548539580176.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4006a72bdd93b1ffedc2bd8646dee18c822a2c26
Gitweb:        https://git.kernel.org/tip/4006a72bdd93b1ffedc2bd8646dee18c822a2c26
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Fri, 10 Sep 2021 18:18:19 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:52:06 +02:00

sched/fair: Consider SMT in ASYM_PACKING load balance

When deciding to pull tasks in ASYM_PACKING, it is necessary not only to
check for the idle state of the destination CPU, dst_cpu, but also of
its SMT siblings.

If dst_cpu is idle but its SMT siblings are busy, performance suffers
if it pulls tasks from a medium priority CPU that does not have SMT
siblings.

Implement asym_smt_can_pull_tasks() to inspect the state of the SMT
siblings of both dst_cpu and the CPUs in the candidate busiest group.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Len Brown <len.brown@intel.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210911011819.12184-7-ricardo.neri-calderon@linux.intel.com
---
 kernel/sched/fair.c | 92 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1c8b5fa..c50ae23 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8571,10 +8571,96 @@ group_type group_classify(unsigned int imbalance_pct,
 	return group_has_spare;
 }
 
+/**
+ * asym_smt_can_pull_tasks - Check whether the load balancing CPU can pull tasks
+ * @dst_cpu:	Destination CPU of the load balancing
+ * @sds:	Load-balancing data with statistics of the local group
+ * @sgs:	Load-balancing statistics of the candidate busiest group
+ * @sg:		The candidate busiest group
+ *
+ * Check the state of the SMT siblings of both @sds::local and @sg and decide
+ * if @dst_cpu can pull tasks.
+ *
+ * If @dst_cpu does not have SMT siblings, it can pull tasks if two or more of
+ * the SMT siblings of @sg are busy. If only one CPU in @sg is busy, pull tasks
+ * only if @dst_cpu has higher priority.
+ *
+ * If both @dst_cpu and @sg have SMT siblings, and @sg has exactly one more
+ * busy CPU than @sds::local, let @dst_cpu pull tasks if it has higher priority.
+ * Bigger imbalances in the number of busy CPUs will be dealt with in
+ * update_sd_pick_busiest().
+ *
+ * If @sg does not have SMT siblings, only pull tasks if all of the SMT siblings
+ * of @dst_cpu are idle and @sg has lower priority.
+ */
+static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
+				    struct sg_lb_stats *sgs,
+				    struct sched_group *sg)
+{
+#ifdef CONFIG_SCHED_SMT
+	bool local_is_smt, sg_is_smt;
+	int sg_busy_cpus;
+
+	local_is_smt = sds->local->flags & SD_SHARE_CPUCAPACITY;
+	sg_is_smt = sg->flags & SD_SHARE_CPUCAPACITY;
+
+	sg_busy_cpus = sgs->group_weight - sgs->idle_cpus;
+
+	if (!local_is_smt) {
+		/*
+		 * If we are here, @dst_cpu is idle and does not have SMT
+		 * siblings. Pull tasks if candidate group has two or more
+		 * busy CPUs.
+		 */
+		if (sg_busy_cpus >= 2) /* implies sg_is_smt */
+			return true;
+
+		/*
+		 * @dst_cpu does not have SMT siblings. @sg may have SMT
+		 * siblings and only one is busy. In such case, @dst_cpu
+		 * can help if it has higher priority and is idle (i.e.,
+		 * it has no running tasks).
+		 */
+		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
+	}
+
+	/* @dst_cpu has SMT siblings. */
+
+	if (sg_is_smt) {
+		int local_busy_cpus = sds->local->group_weight -
+				      sds->local_stat.idle_cpus;
+		int busy_cpus_delta = sg_busy_cpus - local_busy_cpus;
+
+		if (busy_cpus_delta == 1)
+			return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
+
+		return false;
+	}
+
+	/*
+	 * @sg does not have SMT siblings. Ensure that @sds::local does not end
+	 * up with more than one busy SMT sibling and only pull tasks if there
+	 * are not busy CPUs (i.e., no CPU has running tasks).
+	 */
+	if (!sds->local_stat.sum_nr_running)
+		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
+
+	return false;
+#else
+	/* Always return false so that callers deal with non-SMT cases. */
+	return false;
+#endif
+}
+
 static inline bool
 sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs,
 	   struct sched_group *group)
 {
+	/* Only do SMT checks if either local or candidate have SMT siblings */
+	if ((sds->local->flags & SD_SHARE_CPUCAPACITY) ||
+	    (group->flags & SD_SHARE_CPUCAPACITY))
+		return asym_smt_can_pull_tasks(env->dst_cpu, sds, sgs, group);
+
 	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
 }
 
@@ -9580,6 +9666,12 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		    nr_running == 1)
 			continue;
 
+		/* Make sure we only pull tasks from a CPU of lower priority */
+		if ((env->sd->flags & SD_ASYM_PACKING) &&
+		    sched_asym_prefer(i, env->dst_cpu) &&
+		    nr_running == 1)
+			continue;
+
 		switch (env->migration_type) {
 		case migrate_load:
 			/*
