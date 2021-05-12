Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6956D37BA76
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhELK3x (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50472 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhELK3l (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:41 -0400
Date:   Wed, 12 May 2021 10:28:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815312;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XqV2+hSanQfKhnbmA8UQwPMx49KpPfHh5Gh6PskxcyM=;
        b=UKEyk9MH+AHMPnC/E2XTcWEV2GXsSRnavLQfU6RFTpfAs0BvqNDwXBeEzDI6y/lGXDwmUg
        CaZFsSxO5PhdcKR8yFzauYzFM4fpKQ1dSPLvH27KhbpZkigUgUQy9zrvE+ykrQJURhunyq
        u3e59cAj3Ky/4sZ0Ga0OQb6Okl6+rspy1ALoTQRoTcVa9S+OKf5V+KogGHu4R7d4ojgKv0
        r/cHG5zqSbZgHvEZswJoi263o9W/xJ8ZfoUUhnO9Qovyja6k7kyFPQD6gjPiG9Uh2mcqF8
        kxf2Xqye22QLy7PmU7XvpEW09v2KmXS8bhMDreNlA2TM9cC0tA9DwPYDbkPxzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815312;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XqV2+hSanQfKhnbmA8UQwPMx49KpPfHh5Gh6PskxcyM=;
        b=Ie15wAzUL/y9DhY2Efi4z17hOsdtdEmCnzANOTTO8cXhHaeNBhvsgmi/SyeHfu0P0JOkQ8
        6mXEy3uf2UF6mxAg==
From:   "tip-bot2 for Pierre Gondois" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Only compute base_energy_pd if necessary
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210504090743.9688-2-Pierre.Gondois@arm.com>
References: <20210504090743.9688-2-Pierre.Gondois@arm.com>
MIME-Version: 1.0
Message-ID: <162081531212.29796.16374133225445038112.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8d4c97c105ca0735b0d972d1025cb150a7008451
Gitweb:        https://git.kernel.org/tip/8d4c97c105ca0735b0d972d1025cb150a7008451
Author:        Pierre Gondois <Pierre.Gondois@arm.com>
AuthorDate:    Tue, 04 May 2021 10:07:42 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:23 +02:00

sched/fair: Only compute base_energy_pd if necessary

find_energy_efficient_cpu() searches the best energy CPU
to place a task on. To do so, the energy of each performance domain
(pd) is computed w/ and w/o the task placed on it.

The energy of a pd w/o the task (base_energy_pd) is computed prior
knowing whether a CPU is available in the pd.

Move the base_energy_pd computation after looping through the CPUs
of a pd and only compute it if at least one CPU is available.

Suggested-by: Xuewen Yan <xuewen.yan@unisoc.com>
Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Donnefort <vincent.donnefort@arm.com>
Link: https://lkml.kernel.org/r/20210504090743.9688-2-Pierre.Gondois@arm.com
---
 kernel/sched/fair.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d10c6cc..b229d0c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6687,13 +6687,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 	for (; pd; pd = pd->next) {
 		unsigned long cur_delta, spare_cap, max_spare_cap = 0;
+		bool compute_prev_delta = false;
 		unsigned long base_energy_pd;
 		int max_spare_cap_cpu = -1;
 
-		/* Compute the 'base' energy of the pd, without @p */
-		base_energy_pd = compute_energy(p, -1, pd);
-		base_energy += base_energy_pd;
-
 		for_each_cpu_and(cpu, perf_domain_span(pd), sched_domain_span(sd)) {
 			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 				continue;
@@ -6714,25 +6711,35 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (!fits_capacity(util, cpu_cap))
 				continue;
 
-			/* Always use prev_cpu as a candidate. */
 			if (cpu == prev_cpu) {
-				prev_delta = compute_energy(p, prev_cpu, pd);
-				prev_delta -= base_energy_pd;
-				best_delta = min(best_delta, prev_delta);
-			}
-
-			/*
-			 * Find the CPU with the maximum spare capacity in
-			 * the performance domain
-			 */
-			if (spare_cap > max_spare_cap) {
+				/* Always use prev_cpu as a candidate. */
+				compute_prev_delta = true;
+			} else if (spare_cap > max_spare_cap) {
+				/*
+				 * Find the CPU with the maximum spare capacity
+				 * in the performance domain.
+				 */
 				max_spare_cap = spare_cap;
 				max_spare_cap_cpu = cpu;
 			}
 		}
 
-		/* Evaluate the energy impact of using this CPU. */
-		if (max_spare_cap_cpu >= 0 && max_spare_cap_cpu != prev_cpu) {
+		if (max_spare_cap_cpu < 0 && !compute_prev_delta)
+			continue;
+
+		/* Compute the 'base' energy of the pd, without @p */
+		base_energy_pd = compute_energy(p, -1, pd);
+		base_energy += base_energy_pd;
+
+		/* Evaluate the energy impact of using prev_cpu. */
+		if (compute_prev_delta) {
+			prev_delta = compute_energy(p, prev_cpu, pd);
+			prev_delta -= base_energy_pd;
+			best_delta = min(best_delta, prev_delta);
+		}
+
+		/* Evaluate the energy impact of using max_spare_cap_cpu. */
+		if (max_spare_cap_cpu >= 0) {
 			cur_delta = compute_energy(p, max_spare_cap_cpu, pd);
 			cur_delta -= base_energy_pd;
 			if (cur_delta < best_delta) {
