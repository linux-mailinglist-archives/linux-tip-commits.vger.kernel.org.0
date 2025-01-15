Return-Path: <linux-tip-commits+bounces-3229-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624F7A11D3F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DF187A1897
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5022419E2;
	Wed, 15 Jan 2025 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q0JIJslK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kNjyJCXe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CCE23F280;
	Wed, 15 Jan 2025 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932643; cv=none; b=DY3k3Z0TisNrLw6iXuOkKak6KvZrfuhv9Jl0IkBcNRn3tF0R24PQxqpQ+KCcxudMUFellvnpni8zZkJg+Aofp0Tf7BzJ2n6g00x225S40n0hWsNknN1bBU4c9mPrA7QDPCxmVowEDXmeHT9B/GZkPdYzxyMvCCPS1VxDJedvPqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932643; c=relaxed/simple;
	bh=ZX9F/S0JR/rswZH3XX02OboFo+UZclAjgr3sEE5cDrM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pKTbP0pO2ylJUm8j8IyCNE0nZZwFnDe/RlyR3N/DGGfApNK5x57vUHAwuqLQLkKk2lPSnQtfzilQ8LBqIevyXEZtDa9AQJuRco+sZGNt5bum8OJbA5RmMI8wpyqAWCrKrIpTRSRVS7FtzJ4neI9i3mHXH8QVVHQVMJb/TpcdvyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q0JIJslK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kNjyJCXe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932638;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9NHR53p9zNkvtjaTGRRC0EKJAJQy4V7I2Zbhw98dgWI=;
	b=Q0JIJslKGTodSy1vjCJwBhPdqLmTAlIayUIpncZlIuTfhejURQUvKssc7RAma7JDBDEZTw
	LwwDiTdTlUjTF6n9ZSEXrMX3jakYeQz7CF/vkcW7Ez/qYCv7QZK+I4GrYiJtC5Xc4fHE3q
	xFOhYBMQSWcleL//FGrM85O/2xgPAyJyQIM3jm7W+OdcAGt3EMJVvDN7vu1zQjQWFs+5c9
	Ue92mJq2oJ+WMXOL+XtgaJQATznEd6bhsLpIL0mqPSjLDYT9qSlA7Qdgtf1ZHwcgACbXM/
	EDoNzyiKQwrxDlT7baQiA8TywoC8VYUxcErRpoT78IeBJNyGLzkuBr2FZKpOLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932638;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9NHR53p9zNkvtjaTGRRC0EKJAJQy4V7I2Zbhw98dgWI=;
	b=kNjyJCXeiV1QfV7cg/n72EOR8ZJc/Ri5ySPj0VCsBstZuOFMDc76sA2rt6cpP6rEgPimWO
	aZ/LE1cTKw9FStDw==
From: "tip-bot2 for Hao Jia" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Prioritize migrating eligible tasks in
 sched_balance_rq()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Hao Jia <jiahao1@lixiang.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241223091446.90208-1-jiahao.kernel@gmail.com>
References: <20241223091446.90208-1-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693263815.31546.13271369008662997429.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     873199d27bb25889ab7ccca03c8f30c67f18ae52
Gitweb:        https://git.kernel.org/tip/873199d27bb25889ab7ccca03c8f30c67f18ae52
Author:        Hao Jia <jiahao1@lixiang.com>
AuthorDate:    Mon, 23 Dec 2024 17:14:46 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jan 2025 14:10:23 +01:00

sched/core: Prioritize migrating eligible tasks in sched_balance_rq()

When the PLACE_LAG scheduling feature is enabled and
dst_cfs_rq->nr_queued is greater than 1, if a task is
ineligible (lag < 0) on the source cpu runqueue, it will
also be ineligible when it is migrated to the destination
cpu runqueue. Because we will keep the original equivalent
lag of the task in place_entity(). So if the task was
ineligible before, it will still be ineligible after
migration.

So in sched_balance_rq(), we prioritize migrating eligible
tasks, and we soft-limit ineligible tasks, allowing them
to migrate only when nr_balance_failed is non-zero to
avoid load-balancing trying very hard to balance the load.

Below are some benchmark test results. From my test results,
this patch shows a slight improvement on hackbench.

Benchmark
=========

All of the benchmarks are done inside a normal cpu cgroup in a
clean environment with cpu turbo disabled, and test machine is:

Single NUMA machine model is 13th Gen Intel(R) Core(TM)
i7-13700, 12 Core/24 HT.

Based on master b86545e02e8c.

Results
=======

hackbench-process-pipes
                      vanilla                  patched
Amean     1       0.5837 (   0.00%)      0.5733 (   1.77%)
Amean     4       1.4423 (   0.00%)      1.4503 (  -0.55%)
Amean     7       2.5147 (   0.00%)      2.4773 (   1.48%)
Amean     12      3.9347 (   0.00%)      3.8880 (   1.19%)
Amean     21      5.3943 (   0.00%)      5.3873 (   0.13%)
Amean     30      6.7840 (   0.00%)      6.6660 (   1.74%)
Amean     48      9.8313 (   0.00%)      9.6100 (   2.25%)
Amean     79     15.4403 (   0.00%)     14.9580 (   3.12%)
Amean     96     18.4970 (   0.00%)     17.9533 (   2.94%)

hackbench-process-sockets
                      vanilla                  patched
Amean     1       0.6297 (   0.00%)      0.6223 (   1.16%)
Amean     4       2.1517 (   0.00%)      2.0887 (   2.93%)
Amean     7       3.6377 (   0.00%)      3.5670 (   1.94%)
Amean     12      6.1277 (   0.00%)      5.9290 (   3.24%)
Amean     21     10.0380 (   0.00%)      9.7623 (   2.75%)
Amean     30     14.1517 (   0.00%)     13.7513 (   2.83%)
Amean     48     24.7253 (   0.00%)     24.2287 (   2.01%)
Amean     79     43.9523 (   0.00%)     43.2330 (   1.64%)
Amean     96     54.5310 (   0.00%)     53.7650 (   1.40%)

tbench4 Throughput
                      vanilla                  patched
Hmean     1       255.97 (   0.00%)      275.01 (   7.44%)
Hmean     2       511.60 (   0.00%)      544.27 (   6.39%)
Hmean     4       996.70 (   0.00%)     1006.57 (   0.99%)
Hmean     8      1646.46 (   0.00%)     1649.15 (   0.16%)
Hmean     16     2259.42 (   0.00%)     2274.35 (   0.66%)
Hmean     32     4725.48 (   0.00%)     4735.57 (   0.21%)
Hmean     64     4411.47 (   0.00%)     4400.05 (  -0.26%)
Hmean     96     4284.31 (   0.00%)     4267.39 (  -0.39%)

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Hao Jia <jiahao1@lixiang.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241223091446.90208-1-jiahao.kernel@gmail.com
---
 kernel/sched/fair.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7ec2587..52f7278 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9407,6 +9407,30 @@ static inline long migrate_degrades_locality(struct task_struct *p,
 #endif
 
 /*
+ * Check whether the task is ineligible on the destination cpu
+ *
+ * When the PLACE_LAG scheduling feature is enabled and
+ * dst_cfs_rq->nr_queued is greater than 1, if the task
+ * is ineligible, it will also be ineligible when
+ * it is migrated to the destination cpu.
+ */
+static inline int task_is_ineligible_on_dst_cpu(struct task_struct *p, int dest_cpu)
+{
+	struct cfs_rq *dst_cfs_rq;
+
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	dst_cfs_rq = task_group(p)->cfs_rq[dest_cpu];
+#else
+	dst_cfs_rq = &cpu_rq(dest_cpu)->cfs;
+#endif
+	if (sched_feat(PLACE_LAG) && dst_cfs_rq->nr_queued &&
+	    !entity_eligible(task_cfs_rq(p), &p->se))
+		return 1;
+
+	return 0;
+}
+
+/*
  * can_migrate_task - may task p from runqueue rq be migrated to this_cpu?
  */
 static
@@ -9432,6 +9456,16 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
 		return 0;
 
+	/*
+	 * We want to prioritize the migration of eligible tasks.
+	 * For ineligible tasks we soft-limit them and only allow
+	 * them to migrate when nr_balance_failed is non-zero to
+	 * avoid load-balancing trying very hard to balance the load.
+	 */
+	if (!env->sd->nr_balance_failed &&
+	    task_is_ineligible_on_dst_cpu(p, env->dst_cpu))
+		return 0;
+
 	/* Disregard percpu kthreads; they are where they need to be. */
 	if (kthread_is_per_cpu(p))
 		return 0;

