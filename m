Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022F5412F61
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Sep 2021 09:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhIUH3Y (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 21 Sep 2021 03:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhIUH3X (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 21 Sep 2021 03:29:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DB0C061574;
        Tue, 21 Sep 2021 00:27:55 -0700 (PDT)
Date:   Tue, 21 Sep 2021 07:27:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632209272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sCr4hMWHDLaQdVQaHr/lVAhNasVGmWT0gV+CfyDQf2s=;
        b=XH1+VVnqKXxrXmQl2Klb3rGeOwJ8be0RmUdBMDh0gPsh/GmEbox46a+8g4OqA1o7Erlm5q
        v1jOhlguoUJjfLExSj03iGRKmNkm6QIG+uQ/Jx7PNB0Idjfc+Xd5fg51cQ7/dxctqZmEjk
        qWiQo3tTCSpsgEtgmQrqhUFlzk3Jcpwq+PSpChKd0jKsR3wjSbInzQwpotsJ+BtW9G+lU2
        HgdGC2o3kca44NZw3XUPSVtwtwl5NpnxKC35BpCqZiZxhh6RPGpDWhdIwswMvl5foKRE/i
        rKQWNG6Spyy+hj4GRpBxFhmgHsUwEx52VD9irgd2581XnI4o65onkoaPv9ZlgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632209272;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sCr4hMWHDLaQdVQaHr/lVAhNasVGmWT0gV+CfyDQf2s=;
        b=6LkTLzXIImiRjVwV+tsYRJAg2TdiVoLIjXhlx+B16GHt0xVp1XMDgoqFblGOTMWpB3Q7WH
        bl4TKM6UphmfAsDg==
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
Message-ID: <163220927083.25758.5763239172432665688.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     eac6f3841f1dac7b6f43002056b63f44cc1f1543
Gitweb:        https://git.kernel.org/tip/eac6f3841f1dac7b6f43002056b63f44cc1f1543
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Fri, 10 Sep 2021 18:18:19 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 18 Sep 2021 12:18:40 +02:00

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
index 6d27375..2ce015c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8538,10 +8538,96 @@ group_type group_classify(unsigned int imbalance_pct,
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
 
@@ -9547,6 +9633,12 @@ static struct rq *find_busiest_queue(struct lb_env *env,
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
