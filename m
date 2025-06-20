Return-Path: <linux-tip-commits+bounces-5876-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C87AE183B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Jun 2025 11:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39CE916C05E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Jun 2025 09:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED9F284B37;
	Fri, 20 Jun 2025 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hwI3K+46";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZsYCkRrf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9857227CCE0;
	Fri, 20 Jun 2025 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412999; cv=none; b=T4xoFNglhnxNDnbR0Q/xFkADu4AQnCoDWd5jO5p7KYkXEPcccyJN1Xn97z3hhycNhiw79VItM32E8xN1VTOpl6TMuAWJYAaB+hKZ6y8Od9/dRZENRCvqLOqCBcf/0FS8X/gFO4UN4EnAfIFGRNEcO1ZBtG89yFPZuXif8H95Y9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412999; c=relaxed/simple;
	bh=nkhHG9c7DCs4DqIRQIT/im0aWasY0Md7wHzOLcEUzj8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZJEY3Z/pAQy9GIDn8fHlL/Gg8V5IWIO3Yff/iLXd9eqfdhcSqUfZ6xWYO0AWlvaT7AVq63S31PpWGpZocCN61N+vvwKDtaNfD/0v7oS1OloCWiIw18iJ80yvd60ODMBoVOUdrTV1D8Rd9StvVAYv+k+nbRd8SGbZyDZfjrRBvIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hwI3K+46; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZsYCkRrf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 20 Jun 2025 09:49:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750412994;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+gN3sX/szvWdu3dRycz2nrRfDmOk5GZ5RV/8wGRQLcM=;
	b=hwI3K+469TGMTBPMKs03AbgFg5qI29SxmNJ08EhnAB3a1hZzHEdHkDDQ1OTEaCGtsUfGfV
	xrxOZmAdwQNaERhNoCPfPbhVzIgyj7vA2T89w8QmJ265uj9xnCaveA5ia1GBwtra6BEh19
	oy0opVincFK8ew6qfyAeOJEG+i/wV49llef1WF0Ju7C2a4lx3WkBax4Rn1qCZKQ0ZRbe9d
	VZfuCE9+rLm6svk64V9MZvug7cxIjwGMh0r0o0d0ccZ8j99BZ5zJ+8DdTIwUHU+LvnpUCT
	X25Tsz1jNQuL2zQ4Bh9+cFa9yBCDLpDPAT7bx5PyCgohiQTCBatrlKpiqRxTew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750412994;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+gN3sX/szvWdu3dRycz2nrRfDmOk5GZ5RV/8wGRQLcM=;
	b=ZsYCkRrfIJyKHzvO5NJMtYHZNtWons6Vz66hc2LAJoBBThQ8PolJy6IqXl/I8xE9ZJY6jP
	zUvjZ2PX1kIMhYDA==
From: "tip-bot2 for Tejun Heo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/core: Relocate tg_get_cfs_*() and cpu_cfs_*_read_*()
Cc: Tejun Heo <tj@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250614012346.2358261-3-tj@kernel.org>
References: <20250614012346.2358261-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175041299338.406.8680709724900360673.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     de4c80c6963e130707ead16a544a387f811dbd87
Gitweb:        https://git.kernel.org/tip/de4c80c6963e130707ead16a544a387f811dbd87
Author:        Tejun Heo <tj@kernel.org>
AuthorDate:    Fri, 13 Jun 2025 15:23:28 -10:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 18 Jun 2025 13:59:57 +02:00

sched/core: Relocate tg_get_cfs_*() and cpu_cfs_*_read_*()

Collect the getters, relocate the trivial interface file wrappers, and put
all of them in period, quota, burst order to prepare for future changes.
Pure reordering. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250614012346.2358261-3-tj@kernel.org
---
 kernel/sched/core.c | 134 +++++++++++++++++++++----------------------
 1 file changed, 67 insertions(+), 67 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a03c3c1..dc9668a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9404,20 +9404,14 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 	return 0;
 }
 
-static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
+static long tg_get_cfs_period(struct task_group *tg)
 {
-	u64 quota, period, burst;
+	u64 cfs_period_us;
 
-	period = ktime_to_ns(tg->cfs_bandwidth.period);
-	burst = tg->cfs_bandwidth.burst;
-	if (cfs_quota_us < 0)
-		quota = RUNTIME_INF;
-	else if ((u64)cfs_quota_us <= U64_MAX / NSEC_PER_USEC)
-		quota = (u64)cfs_quota_us * NSEC_PER_USEC;
-	else
-		return -EINVAL;
+	cfs_period_us = ktime_to_ns(tg->cfs_bandwidth.period);
+	do_div(cfs_period_us, NSEC_PER_USEC);
 
-	return tg_set_cfs_bandwidth(tg, period, quota, burst);
+	return cfs_period_us;
 }
 
 static long tg_get_cfs_quota(struct task_group *tg)
@@ -9433,6 +9427,16 @@ static long tg_get_cfs_quota(struct task_group *tg)
 	return quota_us;
 }
 
+static long tg_get_cfs_burst(struct task_group *tg)
+{
+	u64 burst_us;
+
+	burst_us = tg->cfs_bandwidth.burst;
+	do_div(burst_us, NSEC_PER_USEC);
+
+	return burst_us;
+}
+
 static int tg_set_cfs_period(struct task_group *tg, long cfs_period_us)
 {
 	u64 quota, period, burst;
@@ -9447,14 +9451,20 @@ static int tg_set_cfs_period(struct task_group *tg, long cfs_period_us)
 	return tg_set_cfs_bandwidth(tg, period, quota, burst);
 }
 
-static long tg_get_cfs_period(struct task_group *tg)
+static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
 {
-	u64 cfs_period_us;
+	u64 quota, period, burst;
 
-	cfs_period_us = ktime_to_ns(tg->cfs_bandwidth.period);
-	do_div(cfs_period_us, NSEC_PER_USEC);
+	period = ktime_to_ns(tg->cfs_bandwidth.period);
+	burst = tg->cfs_bandwidth.burst;
+	if (cfs_quota_us < 0)
+		quota = RUNTIME_INF;
+	else if ((u64)cfs_quota_us <= U64_MAX / NSEC_PER_USEC)
+		quota = (u64)cfs_quota_us * NSEC_PER_USEC;
+	else
+		return -EINVAL;
 
-	return cfs_period_us;
+	return tg_set_cfs_bandwidth(tg, period, quota, burst);
 }
 
 static int tg_set_cfs_burst(struct task_group *tg, long cfs_burst_us)
@@ -9471,52 +9481,6 @@ static int tg_set_cfs_burst(struct task_group *tg, long cfs_burst_us)
 	return tg_set_cfs_bandwidth(tg, period, quota, burst);
 }
 
-static long tg_get_cfs_burst(struct task_group *tg)
-{
-	u64 burst_us;
-
-	burst_us = tg->cfs_bandwidth.burst;
-	do_div(burst_us, NSEC_PER_USEC);
-
-	return burst_us;
-}
-
-static s64 cpu_cfs_quota_read_s64(struct cgroup_subsys_state *css,
-				  struct cftype *cft)
-{
-	return tg_get_cfs_quota(css_tg(css));
-}
-
-static int cpu_cfs_quota_write_s64(struct cgroup_subsys_state *css,
-				   struct cftype *cftype, s64 cfs_quota_us)
-{
-	return tg_set_cfs_quota(css_tg(css), cfs_quota_us);
-}
-
-static u64 cpu_cfs_period_read_u64(struct cgroup_subsys_state *css,
-				   struct cftype *cft)
-{
-	return tg_get_cfs_period(css_tg(css));
-}
-
-static int cpu_cfs_period_write_u64(struct cgroup_subsys_state *css,
-				    struct cftype *cftype, u64 cfs_period_us)
-{
-	return tg_set_cfs_period(css_tg(css), cfs_period_us);
-}
-
-static u64 cpu_cfs_burst_read_u64(struct cgroup_subsys_state *css,
-				  struct cftype *cft)
-{
-	return tg_get_cfs_burst(css_tg(css));
-}
-
-static int cpu_cfs_burst_write_u64(struct cgroup_subsys_state *css,
-				   struct cftype *cftype, u64 cfs_burst_us)
-{
-	return tg_set_cfs_burst(css_tg(css), cfs_burst_us);
-}
-
 struct cfs_schedulable_data {
 	struct task_group *tg;
 	u64 period, quota;
@@ -9649,6 +9613,42 @@ static int cpu_cfs_local_stat_show(struct seq_file *sf, void *v)
 
 	return 0;
 }
+
+static u64 cpu_cfs_period_read_u64(struct cgroup_subsys_state *css,
+				   struct cftype *cft)
+{
+	return tg_get_cfs_period(css_tg(css));
+}
+
+static s64 cpu_cfs_quota_read_s64(struct cgroup_subsys_state *css,
+				  struct cftype *cft)
+{
+	return tg_get_cfs_quota(css_tg(css));
+}
+
+static u64 cpu_cfs_burst_read_u64(struct cgroup_subsys_state *css,
+				  struct cftype *cft)
+{
+	return tg_get_cfs_burst(css_tg(css));
+}
+
+static int cpu_cfs_period_write_u64(struct cgroup_subsys_state *css,
+				    struct cftype *cftype, u64 cfs_period_us)
+{
+	return tg_set_cfs_period(css_tg(css), cfs_period_us);
+}
+
+static int cpu_cfs_quota_write_s64(struct cgroup_subsys_state *css,
+				   struct cftype *cftype, s64 cfs_quota_us)
+{
+	return tg_set_cfs_quota(css_tg(css), cfs_quota_us);
+}
+
+static int cpu_cfs_burst_write_u64(struct cgroup_subsys_state *css,
+				   struct cftype *cftype, u64 cfs_burst_us)
+{
+	return tg_set_cfs_burst(css_tg(css), cfs_burst_us);
+}
 #endif /* CONFIG_CFS_BANDWIDTH */
 
 #ifdef CONFIG_RT_GROUP_SCHED
@@ -9711,16 +9711,16 @@ static struct cftype cpu_legacy_files[] = {
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
-		.name = "cfs_quota_us",
-		.read_s64 = cpu_cfs_quota_read_s64,
-		.write_s64 = cpu_cfs_quota_write_s64,
-	},
-	{
 		.name = "cfs_period_us",
 		.read_u64 = cpu_cfs_period_read_u64,
 		.write_u64 = cpu_cfs_period_write_u64,
 	},
 	{
+		.name = "cfs_quota_us",
+		.read_s64 = cpu_cfs_quota_read_s64,
+		.write_s64 = cpu_cfs_quota_write_s64,
+	},
+	{
 		.name = "cfs_burst_us",
 		.read_u64 = cpu_cfs_burst_read_u64,
 		.write_u64 = cpu_cfs_burst_write_u64,

