Return-Path: <linux-tip-commits+bounces-2280-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC8D972BC8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 10:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C2B1C24CE9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 08:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6457B194137;
	Tue, 10 Sep 2024 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I4AvSHok";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+sX7A9s/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96D0192D67;
	Tue, 10 Sep 2024 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955775; cv=none; b=FwTZppgkdV/jbzReMAKUYGDbgXauvvqpL649+Ra6GV3wnF3C92cIcgInaRWdLQCzLaSiNZu74PDaJP/PWdYagC5QqrGZH5ppOVC03upPbY7mrFzPlOZbuf8yclntmOLt0C7A916czky7lJqRJ3sG1E4IVczu/fJQn1dTc+bZ7+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955775; c=relaxed/simple;
	bh=cmqIWf3iDG4Q2pXTdACgq/gqmj+iQh0CfCxYuorReGc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G2wVMYIFcHxWxEbTVEjijGnJTOeML/1YcGKt4+ga9D/aB6XQCpjxpA3cbNEYb0WFLX1gabh0Z43J6dlSezDMkhpp4WImrnZHzf++h4/UBQr56cllTCZixLMXKCrThzJ16q5LVP8qVAFPF09nJzP+XqNDUXdDPB/Pq7uYtA3gDF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I4AvSHok; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+sX7A9s/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Sep 2024 08:09:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725955765;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r4m9tBXHMDn/sIOEq5yTCFChYZkF7IVwZekm3+daq74=;
	b=I4AvSHokYEBlP2pJGDILHzWvAiHCXCiCtuOBD30bq9giniMrJ7QqB3G2MtasCVv+suo1uU
	GZ3Ooa1YTeHLKR6jZXO/6NHeElIMToVYqAmlAgDhKTXkX8xxiA/TGwuWQMOm2qjzF+ryct
	xR+V/g55Mo4gijyWbMZBmbU2sTCZYGXn2sJA/Nlv2MJLST+kUg2UbSfdnHzf9igSOiPtdi
	9Hfu5izz0dMn8/Nxm5dPHfjx0gLpilnPbvuRHAXkzTBoYsw785vAqJpR7Ka3sCxoI5KTt2
	3aSIpCgdX1v2iLKLXQs15kjiagnk+eURaRSc79gPxCjAb/5XFjE5fUSrk21auw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725955765;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r4m9tBXHMDn/sIOEq5yTCFChYZkF7IVwZekm3+daq74=;
	b=+sX7A9s/VeVOdQneZRvH0RKDdO9FUjQkK+Wd6HEoD4laH2FQ9g7vYJmHr3qHq66dhlHYIT
	Fdn9YK0CGIoPiQDw==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Move effective_cpu_util() and
 effective_cpu_util() in fair.c
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240904092417.20660-1-vincent.guittot@linaro.org>
References: <20240904092417.20660-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172595576462.2215.396088195609450676.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5d871a63997fa8bcf80adb49ea1f2f7840dff932
Gitweb:        https://git.kernel.org/tip/5d871a63997fa8bcf80adb49ea1f2f7840dff932
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 04 Sep 2024 11:24:17 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Sep 2024 09:51:14 +02:00

sched/fair: Move effective_cpu_util() and effective_cpu_util() in fair.c

Move effective_cpu_util() and sched_cpu_util() functions in fair.c file
with others utilization related functions.

No functional change.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20240904092417.20660-1-vincent.guittot@linaro.org
---
 kernel/sched/fair.c     |  99 ++++++++++++++++++++++++++++++++++++++-
 kernel/sched/syscalls.c | 101 +---------------------------------------
 2 files changed, 99 insertions(+), 101 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d697a0a..9e19009 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8085,6 +8085,105 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 }
 
 /*
+ * This function computes an effective utilization for the given CPU, to be
+ * used for frequency selection given the linear relation: f = u * f_max.
+ *
+ * The scheduler tracks the following metrics:
+ *
+ *   cpu_util_{cfs,rt,dl,irq}()
+ *   cpu_bw_dl()
+ *
+ * Where the cfs,rt and dl util numbers are tracked with the same metric and
+ * synchronized windows and are thus directly comparable.
+ *
+ * The cfs,rt,dl utilization are the running times measured with rq->clock_task
+ * which excludes things like IRQ and steal-time. These latter are then accrued
+ * in the IRQ utilization.
+ *
+ * The DL bandwidth number OTOH is not a measured metric but a value computed
+ * based on the task model parameters and gives the minimal utilization
+ * required to meet deadlines.
+ */
+unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
+				 unsigned long *min,
+				 unsigned long *max)
+{
+	unsigned long util, irq, scale;
+	struct rq *rq = cpu_rq(cpu);
+
+	scale = arch_scale_cpu_capacity(cpu);
+
+	/*
+	 * Early check to see if IRQ/steal time saturates the CPU, can be
+	 * because of inaccuracies in how we track these -- see
+	 * update_irq_load_avg().
+	 */
+	irq = cpu_util_irq(rq);
+	if (unlikely(irq >= scale)) {
+		if (min)
+			*min = scale;
+		if (max)
+			*max = scale;
+		return scale;
+	}
+
+	if (min) {
+		/*
+		 * The minimum utilization returns the highest level between:
+		 * - the computed DL bandwidth needed with the IRQ pressure which
+		 *   steals time to the deadline task.
+		 * - The minimum performance requirement for CFS and/or RT.
+		 */
+		*min = max(irq + cpu_bw_dl(rq), uclamp_rq_get(rq, UCLAMP_MIN));
+
+		/*
+		 * When an RT task is runnable and uclamp is not used, we must
+		 * ensure that the task will run at maximum compute capacity.
+		 */
+		if (!uclamp_is_used() && rt_rq_is_runnable(&rq->rt))
+			*min = max(*min, scale);
+	}
+
+	/*
+	 * Because the time spend on RT/DL tasks is visible as 'lost' time to
+	 * CFS tasks and we use the same metric to track the effective
+	 * utilization (PELT windows are synchronized) we can directly add them
+	 * to obtain the CPU's actual utilization.
+	 */
+	util = util_cfs + cpu_util_rt(rq);
+	util += cpu_util_dl(rq);
+
+	/*
+	 * The maximum hint is a soft bandwidth requirement, which can be lower
+	 * than the actual utilization because of uclamp_max requirements.
+	 */
+	if (max)
+		*max = min(scale, uclamp_rq_get(rq, UCLAMP_MAX));
+
+	if (util >= scale)
+		return scale;
+
+	/*
+	 * There is still idle time; further improve the number by using the
+	 * IRQ metric. Because IRQ/steal time is hidden from the task clock we
+	 * need to scale the task numbers:
+	 *
+	 *              max - irq
+	 *   U' = irq + --------- * U
+	 *                 max
+	 */
+	util = scale_irq_capacity(util, irq, scale);
+	util += irq;
+
+	return min(scale, util);
+}
+
+unsigned long sched_cpu_util(int cpu)
+{
+	return effective_cpu_util(cpu, cpu_util_cfs(cpu), NULL, NULL);
+}
+
+/*
  * energy_env - Utilization landscape for energy estimation.
  * @task_busy_time: Utilization contribution by the task for which we test the
  *                  placement. Given by eenv_task_busy_time().
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 4fae3cf..c62acf5 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -258,107 +258,6 @@ int sched_core_idle_cpu(int cpu)
 
 #endif
 
-#ifdef CONFIG_SMP
-/*
- * This function computes an effective utilization for the given CPU, to be
- * used for frequency selection given the linear relation: f = u * f_max.
- *
- * The scheduler tracks the following metrics:
- *
- *   cpu_util_{cfs,rt,dl,irq}()
- *   cpu_bw_dl()
- *
- * Where the cfs,rt and dl util numbers are tracked with the same metric and
- * synchronized windows and are thus directly comparable.
- *
- * The cfs,rt,dl utilization are the running times measured with rq->clock_task
- * which excludes things like IRQ and steal-time. These latter are then accrued
- * in the IRQ utilization.
- *
- * The DL bandwidth number OTOH is not a measured metric but a value computed
- * based on the task model parameters and gives the minimal utilization
- * required to meet deadlines.
- */
-unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
-				 unsigned long *min,
-				 unsigned long *max)
-{
-	unsigned long util, irq, scale;
-	struct rq *rq = cpu_rq(cpu);
-
-	scale = arch_scale_cpu_capacity(cpu);
-
-	/*
-	 * Early check to see if IRQ/steal time saturates the CPU, can be
-	 * because of inaccuracies in how we track these -- see
-	 * update_irq_load_avg().
-	 */
-	irq = cpu_util_irq(rq);
-	if (unlikely(irq >= scale)) {
-		if (min)
-			*min = scale;
-		if (max)
-			*max = scale;
-		return scale;
-	}
-
-	if (min) {
-		/*
-		 * The minimum utilization returns the highest level between:
-		 * - the computed DL bandwidth needed with the IRQ pressure which
-		 *   steals time to the deadline task.
-		 * - The minimum performance requirement for CFS and/or RT.
-		 */
-		*min = max(irq + cpu_bw_dl(rq), uclamp_rq_get(rq, UCLAMP_MIN));
-
-		/*
-		 * When an RT task is runnable and uclamp is not used, we must
-		 * ensure that the task will run at maximum compute capacity.
-		 */
-		if (!uclamp_is_used() && rt_rq_is_runnable(&rq->rt))
-			*min = max(*min, scale);
-	}
-
-	/*
-	 * Because the time spend on RT/DL tasks is visible as 'lost' time to
-	 * CFS tasks and we use the same metric to track the effective
-	 * utilization (PELT windows are synchronized) we can directly add them
-	 * to obtain the CPU's actual utilization.
-	 */
-	util = util_cfs + cpu_util_rt(rq);
-	util += cpu_util_dl(rq);
-
-	/*
-	 * The maximum hint is a soft bandwidth requirement, which can be lower
-	 * than the actual utilization because of uclamp_max requirements.
-	 */
-	if (max)
-		*max = min(scale, uclamp_rq_get(rq, UCLAMP_MAX));
-
-	if (util >= scale)
-		return scale;
-
-	/*
-	 * There is still idle time; further improve the number by using the
-	 * IRQ metric. Because IRQ/steal time is hidden from the task clock we
-	 * need to scale the task numbers:
-	 *
-	 *              max - irq
-	 *   U' = irq + --------- * U
-	 *                 max
-	 */
-	util = scale_irq_capacity(util, irq, scale);
-	util += irq;
-
-	return min(scale, util);
-}
-
-unsigned long sched_cpu_util(int cpu)
-{
-	return effective_cpu_util(cpu, cpu_util_cfs(cpu), NULL, NULL);
-}
-#endif /* CONFIG_SMP */
-
 /**
  * find_process_by_pid - find a process with a matching PID value.
  * @pid: the pid in question.

