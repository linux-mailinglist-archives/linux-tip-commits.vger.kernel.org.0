Return-Path: <linux-tip-commits+bounces-3222-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A25F3A11D41
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E46F3A7E95
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7341EEA40;
	Wed, 15 Jan 2025 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Teu8WM5s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="viJnrmUt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ECC2361DA;
	Wed, 15 Jan 2025 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932641; cv=none; b=lPSrsnILswqOufyQI3gr0lK2xZHhElhxVq/tekqWHHrGokDcQOe0yFwUZMPZiAVZ4uT1IXyH8u5ox5s0AfTluYmimFLT+sAKVpqEgekRfBJuvCCBfRECk3ChcU6xVcxGB4F6P6cwUWXlrFweDbmxW355SeeXdvIl0Dm8nKCKZtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932641; c=relaxed/simple;
	bh=AP9yKur4eb+NVL8X/lNPgyiEYUtcv4cGz/VYjDRTWV8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ghAbl8wp0qFUD1D+uktgcAL+SZ4V370i+QGq2ZZnbNc/QX+bxJSKKDjYsK8NHFVnA+6mo3nQ6xIAY5b8ImrpZvjFFRpxHaJAG/fE635ClA/fEqK7GfTXN8YpAhHgrtskBhoz+wsDGqAbk8jU99pp5C//CHSUk/fJ/G9btaH2B9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Teu8WM5s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=viJnrmUt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:17:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932636;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4qW0irCmJMPi9uFwXVI9d+PCAs2CHtXS6lYnUNyCRFw=;
	b=Teu8WM5s+LYws/vtRAimAcn6tWzwZSoAmYYuWytpAT36IBiVSZ/7WepULOWkJdWhRRfz1C
	GZhFwvO3UXGkti508fworHXmZg9F37sLgYwfpbLUglHDXd1e8cEIW5yYnorfwG2JHMvi+U
	M2XFtJxPhArE/NhKK28WQhtPjVB/0RfqZtj2UUJfiAUMzjqdxfNqzH7a8cu2ZqQyYaIkKY
	drugiu4fPR9lL634bnEW2DORG1/SHRPIQiSn/M+RT5bfLCnmHA1AupL8jtMddGcmWHaR+e
	5FTKnQLzX+xOVGrwNSpdzG/98fVjzo4lalw/CMLlrbVjz4aN8RXcEk9GYm0XSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932636;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4qW0irCmJMPi9uFwXVI9d+PCAs2CHtXS6lYnUNyCRFw=;
	b=viJnrmUtJB9OLhQbiWH0t7ZDB8Y1QXcW1kdIEo7oEftpic1+6tDGFARKvTUVPlVgtdmsFc
	gK1zz73fReyYE0Cg==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Do not compute NUMA Balancing stats
 unnecessarily during lb
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241223043407.1611-7-kprateek.nayak@amd.com>
References: <20241223043407.1611-7-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693263563.31546.3711049219135715005.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0ac1ee9ebfb7fa2af4a267fe0e8fa275ba8ec6fc
Gitweb:        https://git.kernel.org/tip/0ac1ee9ebfb7fa2af4a267fe0e8fa275ba8ec6fc
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Mon, 23 Dec 2024 04:34:05 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jan 2025 14:10:25 +01:00

sched/fair: Do not compute NUMA Balancing stats unnecessarily during lb

Aggregate nr_numa_running and nr_preferred_running when load balancing
at NUMA domains only. While at it, also move the aggregation below the
idle_cpu() check since an idle CPU cannot have any preferred tasks.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20241223043407.1611-7-kprateek.nayak@amd.com
---
 kernel/sched/fair.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 52f7278..650d698 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10409,7 +10409,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 				      bool *sg_overloaded,
 				      bool *sg_overutilized)
 {
-	int i, nr_running, local_group;
+	int i, nr_running, local_group, sd_flags = env->sd->flags;
 
 	memset(sgs, 0, sizeof(*sgs));
 
@@ -10433,10 +10433,6 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		if (cpu_overutilized(i))
 			*sg_overutilized = 1;
 
-#ifdef CONFIG_NUMA_BALANCING
-		sgs->nr_numa_running += rq->nr_numa_running;
-		sgs->nr_preferred_running += rq->nr_preferred_running;
-#endif
 		/*
 		 * No need to call idle_cpu() if nr_running is not 0
 		 */
@@ -10446,10 +10442,17 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			continue;
 		}
 
+#ifdef CONFIG_NUMA_BALANCING
+		/* Only fbq_classify_group() uses this to classify NUMA groups */
+		if (sd_flags & SD_NUMA) {
+			sgs->nr_numa_running += rq->nr_numa_running;
+			sgs->nr_preferred_running += rq->nr_preferred_running;
+		}
+#endif
 		if (local_group)
 			continue;
 
-		if (env->sd->flags & SD_ASYM_CPUCAPACITY) {
+		if (sd_flags & SD_ASYM_CPUCAPACITY) {
 			/* Check for a misfit task on the cpu */
 			if (sgs->group_misfit_task_load < rq->misfit_task_load) {
 				sgs->group_misfit_task_load = rq->misfit_task_load;

