Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2010E412F64
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Sep 2021 09:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhIUH3Z (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 21 Sep 2021 03:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhIUH3X (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 21 Sep 2021 03:29:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97597C061756;
        Tue, 21 Sep 2021 00:27:55 -0700 (PDT)
Date:   Tue, 21 Sep 2021 07:27:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632209274;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FQ9OKZXUff/Csb9He8/YLwS998KhNi08Uc343KKr7s8=;
        b=PZiWFZGpdQpuZWBGOhcrInXDnOCUSxYKj8HyWGVK96fTZAzGY9CDAaUwp5MKadtfjMg4ms
        qRUn79mcG7toICdd3/jMukCbGEnEozYRE10ja0E3E9kMhXBq//Z2s0d7rF3anmAcOpIIBT
        SR8S/+5VsxPXWNBgwPWf7u/eqIztaOldw6X/QcIyodA7m1iJENJUFe3Q7pfNWFZflQQmbe
        hCzwr9CzY0J8i+P6j0MrHaEStP1bRpejQcbdbvJUClAFz4C29t0YKVg/Yno7t5fHUMUoAk
        hX6t0FeXjPdVBXeyLIMs3cr4OUzzKYcmesYAuCXNTcohtnKjl6FF7ZZ11ibuMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632209274;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FQ9OKZXUff/Csb9He8/YLwS998KhNi08Uc343KKr7s8=;
        b=Ghw/84Mbgto8asRxbkNBApfd2gNCWaaytF/k1g0Hr5JqxsIj0YEcsdXAILOhq6y00Pf/PL
        mLXnmeV0QvrethDw==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Introduce sched_group::flags
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Len Brown <len.brown@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210911011819.12184-3-ricardo.neri-calderon@linux.intel.com>
References: <20210911011819.12184-3-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-ID: <163220927342.25758.2433562453342133062.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     048679b6a675a83f6f54f2775e61fc0f647c9c2b
Gitweb:        https://git.kernel.org/tip/048679b6a675a83f6f54f2775e61fc0f647c9c2b
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Fri, 10 Sep 2021 18:18:15 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 18 Sep 2021 12:18:39 +02:00

sched/topology: Introduce sched_group::flags

There exist situations in which the load balance needs to know the
properties of the CPUs in a scheduling group. When using asymmetric
packing, for instance, the load balancer needs to know not only the
state of dst_cpu but also of its SMT siblings, if any.

Use the flags of the child scheduling domains to initialize scheduling
group flags. This will reflect the properties of the CPUs in the
group.

A subsequent changeset will make use of these new flags. No functional
changes are introduced.

Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Len Brown <len.brown@intel.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210911011819.12184-3-ricardo.neri-calderon@linux.intel.com
---
 kernel/sched/sched.h    |  1 +
 kernel/sched/topology.c | 21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 148d5d3..71bc710 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1808,6 +1808,7 @@ struct sched_group {
 	unsigned int		group_weight;
 	struct sched_group_capacity *sgc;
 	int			asym_prefer_cpu;	/* CPU of highest priority in group */
+	int			flags;
 
 	/*
 	 * The CPUs this group covers.
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 4e8698e..c56faae 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -716,8 +716,20 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 		tmp = sd;
 		sd = sd->parent;
 		destroy_sched_domain(tmp);
-		if (sd)
+		if (sd) {
+			struct sched_group *sg = sd->groups;
+
+			/*
+			 * sched groups hold the flags of the child sched
+			 * domain for convenience. Clear such flags since
+			 * the child is being destroyed.
+			 */
+			do {
+				sg->flags = 0;
+			} while (sg != sd->groups);
+
 			sd->child = NULL;
+		}
 	}
 
 	for (tmp = sd; tmp; tmp = tmp->parent)
@@ -916,10 +928,12 @@ build_group_from_child_sched_domain(struct sched_domain *sd, int cpu)
 		return NULL;
 
 	sg_span = sched_group_span(sg);
-	if (sd->child)
+	if (sd->child) {
 		cpumask_copy(sg_span, sched_domain_span(sd->child));
-	else
+		sg->flags = sd->child->flags;
+	} else {
 		cpumask_copy(sg_span, sched_domain_span(sd));
+	}
 
 	atomic_inc(&sg->ref);
 	return sg;
@@ -1169,6 +1183,7 @@ static struct sched_group *get_group(int cpu, struct sd_data *sdd)
 	if (child) {
 		cpumask_copy(sched_group_span(sg), sched_domain_span(child));
 		cpumask_copy(group_balance_mask(sg), sched_group_span(sg));
+		sg->flags = child->flags;
 	} else {
 		cpumask_set_cpu(cpu, sched_group_span(sg));
 		cpumask_set_cpu(cpu, group_balance_mask(sg));
