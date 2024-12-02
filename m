Return-Path: <linux-tip-commits+bounces-2920-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079C09E000D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71832810B6
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADDD1FE44C;
	Mon,  2 Dec 2024 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zC+v1Vwl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qa8X5B7m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C0A1FDE30;
	Mon,  2 Dec 2024 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138086; cv=none; b=Y9JRD8+DjZYcW4QcETIebPKFQPOBO3CP2oncunTooxTxdQzcsQlVitnVvu4SmLjPOsEP8m0TbAeqvx0DrNPrYWbwADXxGO5oAy/5TY8HfmaRsVQ1m+s8t2+Y6ajNscjwE8RUUUxePSbOyYa8nFk1obQA8Zi/YZhS5XBlhut9tVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138086; c=relaxed/simple;
	bh=kU3nhJCBqc/dJhMpV1Bu24UOJ59cPvDUdjECvvVaVOU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GfctNHPpCj5Rzsln/GCR+xS0Ujl/z537CifNKt4dnddgG+3vDweP9N0kiBRnozhINbp2HVf3W4GYE/IqUOlsq4l819krlAcbsG2u8j71NBzR0d10w4Kz6x5HLfsFrhL81KyUWGSOm/pTUmCgrJo2zS0dgE000Wpef8d/EqU86VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zC+v1Vwl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qa8X5B7m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138083;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YXydp8P878JBccppY+NAojIJv/CgiQBYrKnNyZBfmKE=;
	b=zC+v1VwlKQcHduByQEFGXeX9SbBUCgkwMbrBddtwPHOiJUMAFOPnk+VI4PCUheLNC6NaqS
	EZMzJHBpJkTIUbJkvpGYWzHhOqfPNz9/h0NRUA4Guym9VbdIpakAzqhGEXaC1VfygX50s1
	/+VtlRusxUlU9kbPHuR4dyiSSfBTGIgxSW4jSJQI7TEUexq8zKWvCqjNakHDbaCJGLPwYk
	Xfbz+H5FBNiuQZpLbcPHaTVeO2N8Jvc8n1k4eGTEs3jDg4QcrYgTrkJ/bcFS/YB0Sb7ysB
	5HfChefeYS4ppuU+A7JAsHQnn7PXncYAKxUVi4yGiXcJV1q6wQnyB9PTCi8vGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138083;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YXydp8P878JBccppY+NAojIJv/CgiQBYrKnNyZBfmKE=;
	b=Qa8X5B7mWpbPGd57M87OVbEvhBrPc/6cxsZZFf8bMXj4KfQUa6Y1CHI2sgFkm84ERLPeHK
	iQeZmw5ATh49vaBA==
From: "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Check bandwidth overflow earlier
 for hotplug
Cc: Juri Lelli <juri.lelli@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
 Waiman Long <longman@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <Zzc1DfPhbvqDDIJR@jlelli-thinkpadt14gen4.remote.csb>
References: <Zzc1DfPhbvqDDIJR@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313808251.412.2913701590376712845.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     53916d5fd3c0b658de3463439dd2b7ce765072cb
Gitweb:        https://git.kernel.org/tip/53916d5fd3c0b658de3463439dd2b7ce765072cb
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Fri, 15 Nov 2024 11:48:29 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:31 +01:00

sched/deadline: Check bandwidth overflow earlier for hotplug

Currently we check for bandwidth overflow potentially due to hotplug
operations at the end of sched_cpu_deactivate(), after the cpu going
offline has already been removed from scheduling, active_mask, etc.
This can create issues for DEADLINE tasks, as there is a substantial
race window between the start of sched_cpu_deactivate() and the moment
we possibly decide to roll-back the operation if dl_bw_deactivate()
returns failure in cpuset_cpu_inactive(). An example is a throttled
task that sees its replenishment timer firing while the cpu it was
previously running on is considered offline, but before
dl_bw_deactivate() had a chance to say no and roll-back happened.

Fix this by directly calling dl_bw_deactivate() first thing in
sched_cpu_deactivate() and do the required calculation in the former
function considering the cpu passed as an argument as offline already.

By doing so we also simplify sched_cpu_deactivate(), as there is no need
anymore for any kind of roll-back if we fail early.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Tested-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/Zzc1DfPhbvqDDIJR@jlelli-thinkpadt14gen4.remote.csb
---
 kernel/sched/core.c     | 22 +++++++---------------
 kernel/sched/deadline.c | 12 ++++++++++--
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 29f6b24..1dee3f5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8182,19 +8182,14 @@ static void cpuset_cpu_active(void)
 	cpuset_update_active_cpus();
 }
 
-static int cpuset_cpu_inactive(unsigned int cpu)
+static void cpuset_cpu_inactive(unsigned int cpu)
 {
 	if (!cpuhp_tasks_frozen) {
-		int ret = dl_bw_deactivate(cpu);
-
-		if (ret)
-			return ret;
 		cpuset_update_active_cpus();
 	} else {
 		num_cpus_frozen++;
 		partition_sched_domains(1, NULL, NULL);
 	}
-	return 0;
 }
 
 static inline void sched_smt_present_inc(int cpu)
@@ -8256,6 +8251,11 @@ int sched_cpu_deactivate(unsigned int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	int ret;
 
+	ret = dl_bw_deactivate(cpu);
+
+	if (ret)
+		return ret;
+
 	/*
 	 * Remove CPU from nohz.idle_cpus_mask to prevent participating in
 	 * load balancing when not active
@@ -8301,15 +8301,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 		return 0;
 
 	sched_update_numa(cpu, false);
-	ret = cpuset_cpu_inactive(cpu);
-	if (ret) {
-		sched_smt_present_inc(cpu);
-		sched_set_rq_online(rq, cpu);
-		balance_push_set(cpu, false);
-		set_cpu_active(cpu, true);
-		sched_update_numa(cpu, true);
-		return ret;
-	}
+	cpuset_cpu_inactive(cpu);
 	sched_domains_numa_masks_clear(cpu);
 	return 0;
 }
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fa787c7..1c8b838 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3496,6 +3496,13 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 		break;
 	case dl_bw_req_deactivate:
 		/*
+		 * cpu is not off yet, but we need to do the math by
+		 * considering it off already (i.e., what would happen if we
+		 * turn cpu off?).
+		 */
+		cap -= arch_scale_cpu_capacity(cpu);
+
+		/*
 		 * cpu is going offline and NORMAL tasks will be moved away
 		 * from it. We can thus discount dl_server bandwidth
 		 * contribution as it won't need to be servicing tasks after
@@ -3512,9 +3519,10 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 		if (dl_b->total_bw - fair_server_bw > 0) {
 			/*
 			 * Leaving at least one CPU for DEADLINE tasks seems a
-			 * wise thing to do.
+			 * wise thing to do. As said above, cpu is not offline
+			 * yet, so account for that.
 			 */
-			if (dl_bw_cpus(cpu))
+			if (dl_bw_cpus(cpu) - 1)
 				overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
 			else
 				overflow = 1;

