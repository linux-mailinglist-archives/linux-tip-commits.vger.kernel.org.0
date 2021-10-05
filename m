Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20B4422A5F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbhJEOOG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbhJEON4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:13:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAB8C061764;
        Tue,  5 Oct 2021 07:12:02 -0700 (PDT)
Date:   Tue, 05 Oct 2021 14:12:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443121;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9L62M+shQg1PSDCWvpsyEj3zmJ4T6clGwxMoW8l4yCM=;
        b=YAS8AIx2XPuW8U59++LhDcDkegfpHeqUWszY0B1ThCwKfWOcivmAyGuvgyNmczyp0hxcZz
        3+A/mHy9c6nA7wE56yvDHDlOSfKSnwwaGMbryMQx4IdiK9A6WeH1Y8zczuxZJlW5Srrvok
        5FeBj7a8vJDfQOk+Ox496CgVa2iIL2gjGgkkS9+kBhWjDTnXAfi4psIBEF0q4LYqsngcWz
        MLFykypWCbagFxmTFcLlM8edEeczhZ0nczNvzLPoylXfRlgnvXUGkEekVwbF7qofEMG/6U
        67RS3hvzZcQfey/tFfyVQoCBGNombZ9oIZ8IjEdbyHfgBSDgEm1FHkyxJ64eqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443121;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9L62M+shQg1PSDCWvpsyEj3zmJ4T6clGwxMoW8l4yCM=;
        b=/GucrzRCBbKwGgalGM2jeI1Ii1SBf4ZelaYlLjc5kZ1slLZyT2jHQdINK7BVZrXp0doUUk
        KhmX+RViN1e/bBCw==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Carve out logic to mark a group for
 asymmetric packing
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Len Brown <len.brown@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210911011819.12184-6-ricardo.neri-calderon@linux.intel.com>
References: <20210911011819.12184-6-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-ID: <163344312070.25758.14465078515657887073.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     aafc917a3c31dcc76cb0279cd7617dda11b15f2a
Gitweb:        https://git.kernel.org/tip/aafc917a3c31dcc76cb0279cd7617dda11b15f2a
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Fri, 10 Sep 2021 18:18:18 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:52:04 +02:00

sched/fair: Carve out logic to mark a group for asymmetric packing

Create a separate function, sched_asym(). A subsequent changeset will
introduce logic to deal with SMT in conjunction with asmymmetric
packing. Such logic will need the statistics of the scheduling
group provided as argument. Update them before calling sched_asym().

Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Len Brown <len.brown@intel.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210911011819.12184-6-ricardo.neri-calderon@linux.intel.com
---
 kernel/sched/fair.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2e8ef33..1c8b5fa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8571,6 +8571,13 @@ group_type group_classify(unsigned int imbalance_pct,
 	return group_has_spare;
 }
 
+static inline bool
+sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs,
+	   struct sched_group *group)
+{
+	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
+}
+
 /**
  * update_sg_lb_stats - Update sched_group's statistics for load balancing.
  * @env: The load balancing environment.
@@ -8631,18 +8638,17 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		}
 	}
 
+	sgs->group_capacity = group->sgc->capacity;
+
+	sgs->group_weight = group->group_weight;
+
 	/* Check if dst CPU is idle and preferred to this group */
 	if (!local_group && env->sd->flags & SD_ASYM_PACKING &&
-	    env->idle != CPU_NOT_IDLE &&
-	    sgs->sum_h_nr_running &&
-	    sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu)) {
+	    env->idle != CPU_NOT_IDLE && sgs->sum_h_nr_running &&
+	    sched_asym(env, sds, sgs, group)) {
 		sgs->group_asym_packing = 1;
 	}
 
-	sgs->group_capacity = group->sgc->capacity;
-
-	sgs->group_weight = group->group_weight;
-
 	sgs->group_type = group_classify(env->sd->imbalance_pct, group, sgs);
 
 	/* Computing avg_load makes sense only when group is overloaded */
