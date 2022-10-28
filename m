Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5576F610A96
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Oct 2022 08:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiJ1GoR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 28 Oct 2022 02:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiJ1Gm3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 28 Oct 2022 02:42:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EC515D097;
        Thu, 27 Oct 2022 23:42:24 -0700 (PDT)
Date:   Fri, 28 Oct 2022 06:42:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666939343;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+LEuD1Q34wqPePTcvG3lBngtMUICd5W0p+Xe9BobbWE=;
        b=XTVz+37sPqSQHvOITXiTUQsrTGaBoGXQJh75uf+N2r7hA0A/ot98zjo2eMcXkiNmCtesle
        ThBndlIkNDqTuXLCglpzk/pnlIEmXB6QpIdk9OS/L1IoDUa9LLNiuxIWQ8nvOsuqH4YESa
        R/ZujzhMH1igIeKjQqR0KgOht/k2DiF7vyHYLBDLCHF4/nTkf+4gjJfEFCiZbBm0cLfaHD
        d0OzD+m6JqIoolFNbVaBKjpAXLY5q+sKFVeFoul1pHJNqnWlJ4wPZf9tpU1qDcuKal8ARk
        Ef3ZhAEl0BD5bx/GPW7wIDJNC1eevZbTQmXKxMz/4ufQCFgmfof9wyUBcXOvHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666939343;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+LEuD1Q34wqPePTcvG3lBngtMUICd5W0p+Xe9BobbWE=;
        b=eiuRJb898rBj4Aoqf3ZunxbrXWn/UTejB1ibyq+g/k1podGVo6arbE+Ml8Cf1KT90aEUwJ
        EndzZ7r/yTB/o7Dg==
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Make select_idle_capacity() use
 util_fits_cpu()
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220804143609.515789-5-qais.yousef@arm.com>
References: <20220804143609.515789-5-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <166693934213.29415.17407589437683761937.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b759caa1d9f667b94727b2ad12589cbc4ce13a82
Gitweb:        https://git.kernel.org/tip/b759caa1d9f667b94727b2ad12589cbc4ce13a82
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Thu, 04 Aug 2022 15:36:04 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Oct 2022 11:01:18 +02:00

sched/uclamp: Make select_idle_capacity() use util_fits_cpu()

Use the new util_fits_cpu() to ensure migration margin and capacity
pressure are taken into account correctly when uclamp is being used
otherwise we will fail to consider CPUs as fitting in scenarios where
they should.

Fixes: b4c9c9f15649 ("sched/fair: Prefer prev cpu in asymmetric wakeup path")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220804143609.515789-5-qais.yousef@arm.com
---
 kernel/sched/fair.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c8eb5ff..c877bbf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6779,21 +6779,23 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool 
 static int
 select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 {
-	unsigned long task_util, best_cap = 0;
+	unsigned long task_util, util_min, util_max, best_cap = 0;
 	int cpu, best_cpu = -1;
 	struct cpumask *cpus;
 
 	cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
-	task_util = uclamp_task_util(p);
+	task_util = task_util_est(p);
+	util_min = uclamp_eff_value(p, UCLAMP_MIN);
+	util_max = uclamp_eff_value(p, UCLAMP_MAX);
 
 	for_each_cpu_wrap(cpu, cpus, target) {
 		unsigned long cpu_cap = capacity_of(cpu);
 
 		if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
 			continue;
-		if (fits_capacity(task_util, cpu_cap))
+		if (util_fits_cpu(task_util, util_min, util_max, cpu))
 			return cpu;
 
 		if (cpu_cap > best_cap) {
