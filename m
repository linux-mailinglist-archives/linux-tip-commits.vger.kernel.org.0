Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50219422A5D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbhJEOOF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbhJEON4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:13:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9B6C061765;
        Tue,  5 Oct 2021 07:12:03 -0700 (PDT)
Date:   Tue, 05 Oct 2021 14:12:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443122;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BfIGWch3fSGtrGxUza+JqehnlVAElbgELkrhR8+3Nho=;
        b=tlqemuXOaOAgr9gmbcIDdQzloCuUcYVvIJo2+7uFFvPby0gH4DXmY/p3xiwubIzTFktZaE
        3dj2MDmhW5YcU8f8AsVeLMAhPXSvylwYeXnT+9AXJvTOvVo7jppKp77NmdREc1zggFEsVc
        8UawVSfVvPChzg/Kqv4tLaffBjNvT/Z11M3AGsHfjdjmFDtDSfIrX+qUgZx1gs6yNQ05rI
        5vSuX7CdDk+Ym1+cGBDwvOdUxZ99qOzbJHKP7CEbkdBHYL2mmg+eZNRTAu2KFlNLNgqt3W
        FPkv8PBjkTjSRWDItwKslHNZXekcr/tofazDhYOOIQF4P3g6ASo4VH5r3B1blg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443122;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BfIGWch3fSGtrGxUza+JqehnlVAElbgELkrhR8+3Nho=;
        b=CFk/DlTf5oK/sHdohfUObl8qgleJET4Pnpc8bJRDlQVqUrzzcbQz7KoEbWw/3SUS1pDq/C
        p9trcgCdxUFUInDQ==
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
Message-ID: <163344312131.25758.15888370038716365881.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c0d14b57fe0c11b65ce8a1a4a58a48f3f324ca0f
Gitweb:        https://git.kernel.org/tip/c0d14b57fe0c11b65ce8a1a4a58a48f3f324ca0f
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Fri, 10 Sep 2021 18:18:17 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:52:03 +02:00

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
index e050b1d..2e8ef33 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8579,6 +8579,7 @@ group_type group_classify(unsigned int imbalance_pct,
  * @sg_status: Holds flag indicating the status of the sched_group
  */
 static inline void update_sg_lb_stats(struct lb_env *env,
+				      struct sd_lb_stats *sds,
 				      struct sched_group *group,
 				      struct sg_lb_stats *sgs,
 				      int *sg_status)
@@ -8587,7 +8588,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 	memset(sgs, 0, sizeof(*sgs));
 
-	local_group = cpumask_test_cpu(env->dst_cpu, sched_group_span(group));
+	local_group = group == sds->local;
 
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
 		struct rq *rq = cpu_rq(i);
@@ -9150,7 +9151,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 				update_group_capacity(env->sd, env->dst_cpu);
 		}
 
-		update_sg_lb_stats(env, sg, sgs, &sg_status);
+		update_sg_lb_stats(env, sds, sg, sgs, &sg_status);
 
 		if (local_group)
 			goto next_group;
