Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D8D412F5F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Sep 2021 09:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhIUH3W (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 21 Sep 2021 03:29:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46876 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhIUH3W (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 21 Sep 2021 03:29:22 -0400
Date:   Tue, 21 Sep 2021 07:27:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632209273;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EBHrFUp32q70AzHMQXT51rX44oleXMUC595brRKmaB0=;
        b=Es4EdqzdgXj5ohwfYC+TmjWeBdtB/OJCpvmg52YqNuKBfD/tG3Q0Ef1Q7zmnx2gUCT067V
        wOc7p4JyJIQyA7J4ZaLo8UMgbDfHoX2OOdj11K5rXO4ZrTxqpDsL2DY57FuJ+ft9PTMib+
        ZYXAiPaC+2PXz0fzuKWyBnbx8yWWmbb1P3aIApewnLHFnSd8yO/SIBvcrxbKH95VV0KrSH
        NX+CufmJeSVU7YhAT19Amt1V0t2Fugfhx6k8kno5mVwyq6MqSSfJOagF9KBpgZa5k9hK2f
        H7O4cG47orIRiarN4oB5jzgMC4VTyd4eDoTFUK8W1ZzNJijEAfsy7w3IkRvPcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632209273;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EBHrFUp32q70AzHMQXT51rX44oleXMUC595brRKmaB0=;
        b=fp6PKtbe8JLyWhS0Au5UgkiWTws9Pf0Kbhs8kIn1RkFVaY3boJ6BC5XTLpJxBHAeRpea+S
        ZI3MuvVshUd59+CA==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Provide update_sg_lb_stats() with sched
 domain statistics
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Len Brown <len.brown@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210911011819.12184-5-ricardo.neri-calderon@linux.intel.com>
References: <20210911011819.12184-5-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-ID: <163220927219.25758.1551574735460531874.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a7bd2ed2dc9e8bf6b69d26573cb6e80ef42d8e5b
Gitweb:        https://git.kernel.org/tip/a7bd2ed2dc9e8bf6b69d26573cb6e80ef42d8e5b
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Fri, 10 Sep 2021 18:18:17 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 18 Sep 2021 12:18:40 +02:00

sched/fair: Provide update_sg_lb_stats() with sched domain statistics

Before deciding to pull tasks when using asymmetric packing of tasks,
on some architectures (e.g., x86) it is necessary to know not only the
state of dst_cpu but also of its SMT siblings. The decision to classify
a candidate busiest group as group_asym_packing is done in
update_sg_lb_stats(). Give this function access to the scheduling domain
statistics, which contains the statistics of the local group.

Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Len Brown <len.brown@intel.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210911011819.12184-5-ricardo.neri-calderon@linux.intel.com
---
 kernel/sched/fair.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d85c5a4..d592de4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8546,6 +8546,7 @@ group_type group_classify(unsigned int imbalance_pct,
  * @sg_status: Holds flag indicating the status of the sched_group
  */
 static inline void update_sg_lb_stats(struct lb_env *env,
+				      struct sd_lb_stats *sds,
 				      struct sched_group *group,
 				      struct sg_lb_stats *sgs,
 				      int *sg_status)
@@ -8554,7 +8555,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 	memset(sgs, 0, sizeof(*sgs));
 
-	local_group = cpumask_test_cpu(env->dst_cpu, sched_group_span(group));
+	local_group = group == sds->local;
 
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
 		struct rq *rq = cpu_rq(i);
@@ -9117,7 +9118,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 				update_group_capacity(env->sd, env->dst_cpu);
 		}
 
-		update_sg_lb_stats(env, sg, sgs, &sg_status);
+		update_sg_lb_stats(env, sds, sg, sgs, &sg_status);
 
 		if (local_group)
 			goto next_group;
