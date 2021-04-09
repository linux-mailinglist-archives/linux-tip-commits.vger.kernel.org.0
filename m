Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531DC359E37
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 14:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhDIMF0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 08:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbhDIMFZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 08:05:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488E0C061760;
        Fri,  9 Apr 2021 05:05:12 -0700 (PDT)
Date:   Fri, 09 Apr 2021 12:05:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617969910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6rpOWbLDM7Me4C7MsIK2gkZlNkiK+QbtG/iFtFXTgSg=;
        b=GsxYfk04BerxN0wnlxwC+pA3e2Ka40MVWJ/neTwpGFZWZkbG2J80+FM9vOS38qTcS2aFRY
        kL7ti18kagjyJJ0zzOL1e1/wT0SdHNMBUr2bVYs+KBhA0zvnETxO9WXOsqjK94R+8LGS7o
        WtId42NDT9KTbeJmaHime8cMQgmmZcg/rcQMyrUur95yggbUEtbrs/3maxKtyr6031SWNL
        YXglu72AAyfixWQs+uDbSCDWKn7TEBELqv4zeWptIhqnsB1kjznbuy0fQu/Q6561hZbYiX
        AD1zApgC744nYF3tsT1E4uY2IjUAumo17n53cHTgiD0dsxORvz00BCb6pXJrZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617969910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6rpOWbLDM7Me4C7MsIK2gkZlNkiK+QbtG/iFtFXTgSg=;
        b=25mxMmk2nWiUuNgnH84Rlnz0ac2xneV1W3M5XawNbvf6zEvlxNvfxQXvCoqQT223FYAmm9
        k+U15jByN3YfCTDQ==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Introduce a CPU capacity comparison helper
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210407220628.3798191-4-valentin.schneider@arm.com>
References: <20210407220628.3798191-4-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <161796991000.29796.16063011242960573924.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     816969e4af7a56bfd284d2e0fa11511900ab93e3
Gitweb:        https://git.kernel.org/tip/816969e4af7a56bfd284d2e0fa11511900ab93e3
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 07 Apr 2021 23:06:28 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 09 Apr 2021 13:53:12 +02:00

sched/fair: Introduce a CPU capacity comparison helper

During load-balance, groups classified as group_misfit_task are filtered
out if they do not pass

  group_smaller_max_cpu_capacity(<candidate group>, <local group>);

which itself employs fits_capacity() to compare the sgc->max_capacity of
both groups.

Due to the underlying margin, fits_capacity(X, 1024) will return false for
any X > 819. Tough luck, the capacity_orig's on e.g. the Pixel 4 are
{261, 871, 1024}. If a CPU-bound task ends up on one of those "medium"
CPUs, misfit migration will never intentionally upmigrate it to a CPU of
higher capacity due to the aforementioned margin.

One may argue the 20% margin of fits_capacity() is excessive in the advent
of counter-enhanced load tracking (APERF/MPERF, AMUs), but one point here
is that fits_capacity() is meant to compare a utilization value to a
capacity value, whereas here it is being used to compare two capacity
values. As CPU capacity and task utilization have different dynamics, a
sensible approach here would be to add a new helper dedicated to comparing
CPU capacities.

Also note that comparing capacity extrema of local and source sched_group's
doesn't make much sense when at the day of the day the imbalance will be
pulled by a known env->dst_cpu, whose capacity can be anywhere within the
local group's capacity extrema.

While at it, replace group_smaller_{min, max}_cpu_capacity() with
comparisons of the source group's min/max capacity and the destination
CPU's capacity.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
Link: https://lkml.kernel.org/r/20210407220628.3798191-4-valentin.schneider@arm.com
---
 kernel/sched/fair.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3ed436e..f9440ee 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -113,6 +113,13 @@ int __weak arch_asym_cpu_priority(int cpu)
  */
 #define fits_capacity(cap, max)	((cap) * 1280 < (max) * 1024)
 
+/*
+ * The margin used when comparing CPU capacities.
+ * is 'cap1' noticeably greater than 'cap2'
+ *
+ * (default: ~5%)
+ */
+#define capacity_greater(cap1, cap2) ((cap1) * 1024 > (cap2) * 1078)
 #endif
 
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -8395,26 +8402,6 @@ group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 	return false;
 }
 
-/*
- * group_smaller_min_cpu_capacity: Returns true if sched_group sg has smaller
- * per-CPU capacity than sched_group ref.
- */
-static inline bool
-group_smaller_min_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
-{
-	return fits_capacity(sg->sgc->min_capacity, ref->sgc->min_capacity);
-}
-
-/*
- * group_smaller_max_cpu_capacity: Returns true if sched_group sg has smaller
- * per-CPU capacity_orig than sched_group ref.
- */
-static inline bool
-group_smaller_max_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
-{
-	return fits_capacity(sg->sgc->max_capacity, ref->sgc->max_capacity);
-}
-
 static inline enum
 group_type group_classify(unsigned int imbalance_pct,
 			  struct sched_group *group,
@@ -8570,7 +8557,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 * internally or be covered by avg_load imbalance (eventually).
 	 */
 	if (sgs->group_type == group_misfit_task &&
-	    (!group_smaller_max_cpu_capacity(sg, sds->local) ||
+	    (!capacity_greater(capacity_of(env->dst_cpu), sg->sgc->max_capacity) ||
 	     sds->local_stat.group_type != group_has_spare))
 		return false;
 
@@ -8654,7 +8641,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 */
 	if ((env->sd->flags & SD_ASYM_CPUCAPACITY) &&
 	    (sgs->group_type <= group_fully_busy) &&
-	    (group_smaller_min_cpu_capacity(sds->local, sg)))
+	    (capacity_greater(sg->sgc->min_capacity, capacity_of(env->dst_cpu))))
 		return false;
 
 	return true;
@@ -9454,7 +9441,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		 * average load.
 		 */
 		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
-		    capacity_of(env->dst_cpu) < capacity &&
+		    !capacity_greater(capacity_of(env->dst_cpu), capacity) &&
 		    nr_running == 1)
 			continue;
 
