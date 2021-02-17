Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECEC031DA28
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Feb 2021 14:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbhBQNTE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Feb 2021 08:19:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45340 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbhBQNSW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Feb 2021 08:18:22 -0500
Date:   Wed, 17 Feb 2021 13:17:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613567859;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oHOdxPK1PimUSz+dNel4xfb8TJHlo2JATIPacGkvQm4=;
        b=QHDvHUU6ZhG7la/Y7m3i9+00DskSpYjft1bSz9/eT92SseeDNOJp05s9YKA6vLmZCCM2bW
        aOM1+9CijETLZOJMmrd12cBuSErEMlVDpiTyl/ggsroo5amSSKbcpXr0SAGlAPvM2eM0Qh
        C2DRhplN6uwCdwkVYqQEvh3RcEcA63cNmF2zdMM7JIacjTM5pVD/EvbryjKXmx4hoX6Hkd
        lxhPfR+uTFp+SQXB65hQuclxnJTD8Rlbck56hwjzmZC5tuerE6o7egkLzkppw2AcPnmA+7
        RxBDMUPW0bSs+spW7ihWIe4wx4n7/wjAQHhRQiliVpzmdsWVt+1PcN3R9MOlvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613567859;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oHOdxPK1PimUSz+dNel4xfb8TJHlo2JATIPacGkvQm4=;
        b=AMuCN2sq+htLpaHpvj75+9Of42zWe3yScjZrptjWySKvwErP20wusu5wmLMWljCt30CRtK
        j6WikLYQa3SHuYAg==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove select_idle_smt()
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210125085909.4600-4-mgorman@techsingularity.net>
References: <20210125085909.4600-4-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <161356785922.20312.12827530048357418558.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6cd56ef1df399a004f90ecb682427f9964969fc9
Gitweb:        https://git.kernel.org/tip/6cd56ef1df399a004f90ecb682427f9964969fc9
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Mon, 25 Jan 2021 08:59:08 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Feb 2021 14:06:59 +01:00

sched/fair: Remove select_idle_smt()

In order to make the next patch more readable, and to quantify the
actual effectiveness of this pass, start by removing it.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210125085909.4600-4-mgorman@techsingularity.net
---
 kernel/sched/fair.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4c18ef6..6a0fc8a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6114,27 +6114,6 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int 
 	return -1;
 }
 
-/*
- * Scan the local SMT mask for idle CPUs.
- */
-static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
-{
-	int cpu;
-
-	if (!static_branch_likely(&sched_smt_present))
-		return -1;
-
-	for_each_cpu(cpu, cpu_smt_mask(target)) {
-		if (!cpumask_test_cpu(cpu, p->cpus_ptr) ||
-		    !cpumask_test_cpu(cpu, sched_domain_span(sd)))
-			continue;
-		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
-			return cpu;
-	}
-
-	return -1;
-}
-
 #else /* CONFIG_SCHED_SMT */
 
 static inline int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
@@ -6142,11 +6121,6 @@ static inline int select_idle_core(struct task_struct *p, struct sched_domain *s
 	return -1;
 }
 
-static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
-{
-	return -1;
-}
-
 #endif /* CONFIG_SCHED_SMT */
 
 /*
@@ -6336,10 +6310,6 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
-	i = select_idle_smt(p, sd, target);
-	if ((unsigned)i < nr_cpumask_bits)
-		return i;
-
 	return target;
 }
 
