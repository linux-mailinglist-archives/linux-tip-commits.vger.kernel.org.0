Return-Path: <linux-tip-commits+bounces-4772-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5307AA8157B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB5A4E1249
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0EA2571D4;
	Tue,  8 Apr 2025 19:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hqj/4FHT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2a0R2v3Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9132256C6E;
	Tue,  8 Apr 2025 19:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139142; cv=none; b=u6F9cDy7TxkO1SI0Xw+tqpKiR5fgKvB9fqiy72dZd+0QwqqGsD1FUn1ztYudcRSDXDC3UtwUJ0EGcEqbAqfRsVU/jlSqclXEdOHfw6royb6NezzqNq025NJqtC4o8wKy+6ym9K9M5h0DML3kC5d+cjB8AB+DUQflfw/sgtL3Hr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139142; c=relaxed/simple;
	bh=Tj4w4KDvTliidtAaiCQp5tgyTXQHrK5ncharZxX7gMs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TPNDYFfv+S2qORUSa5hVgN+R86lQg+FQc8CQQ4yCGBk/ZP24/z9aYrtinzg5pA0WbnbA85+rCH1WAkFZMgioVKAAruriEncUxKhSa1OAJ43JEkTOpupt5IDfYLpg0tdhsaY3WIRbF5PVKnqZuQaRPwYp5LuWBifHsmZ0306L/KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hqj/4FHT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2a0R2v3Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:05:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139139;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ztAQVpcwoO6Ok13BpMBIG5UWgFqLmpI5vM5l4j52/gY=;
	b=Hqj/4FHTchiyQNtGjBj+lPy9NAP7CKAXxyyGRoa1J1jMleOMi6QF33Ta0gJKoqT3J6a10q
	BBSzcJmdPw0ErJ554RpH8enMqMBH/Htc2VqyZ5TKiq7xzJ3MXsD0jew28Nx/m9YGUFTa/m
	5eyfc/rxFwieygpUjspAfqPRmtW7wjgGaVOhGlJjB7PjPcSjIpn9IeMLkpnd0AdD6e5Xmg
	kWyRR3gT7A1dC82x6GgT6lKZS74AoowyyEFg4EDTqHiQZrKOTbjZ7/jMSJ9vwsiLEGySSx
	XUNxR9C1xNcWQBlQflOlSfybzYpPK8KmRJmBwF6dhDOre80I5qouTc6Eb2xJig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139139;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ztAQVpcwoO6Ok13BpMBIG5UWgFqLmpI5vM5l4j52/gY=;
	b=2a0R2v3ZmaUcmAR/2m2IrBXv/VFtPgZsaGJB7iDsriupnEnpcdJhcE2z5KgDjBf6VZk/ff
	B8oMnEKfgxfTtXCQ==
From: "tip-bot2 for Pierre Gondois" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Allow decaying util_est when util_avg >
 CPU capa
Cc: Pierre Gondois <pierre.gondois@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.rog>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250325150542.1077344-1-pierre.gondois@arm.com>
References: <20250325150542.1077344-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413913866.31282.5804998257079608493.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f2d650618bc721760199ae0133c73ec32c63817e
Gitweb:        https://git.kernel.org/tip/f2d650618bc721760199ae0133c73ec32c63817e
Author:        Pierre Gondois <pierre.gondois@arm.com>
AuthorDate:    Tue, 25 Mar 2025 16:05:41 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:52 +02:00

sched/fair: Allow decaying util_est when util_avg > CPU capa

commit 10a35e6812aa ("sched/pelt: Skip updating util_est when
utilization is higher than CPU's capacity")
prevents util_est from being updated if util_avg is higher than the
underlying CPU capacity to avoid overestimating the task when the CPU
is capped (due to thermal issue for instance). In this scenario, the
task will miss its deadlines and start overlapping its wake-up events
for instance. The task will appear as always running when the CPU is
just not powerful enough to allow having a good estimation of the
task.

commit b8c96361402a ("sched/fair/util_est: Implement faster ramp-up
EWMA on utilization increases")
sets ewma to util_avg when ewma > util_avg, allowing ewma to quickly
grow instead of slowly converge to the new util_avg value when a task
profile changes from small to big.

However, the 2 conditions:
- Check util_avg against max CPU capacity
- Check whether util_est > util_avg
are placed in an order such as it is possible to set util_est to a
value higher than the CPU capacity if util_est > util_avg, but
util_est is prevented to decay as long as:
CPU capacity < util_avg < util_est.

Just remove the check as either:
1.
There is idle time on the CPU. In that case the util_avg value of the
task is actually correct. It is possible that the task missed a
deadline and appears bigger, but this is also the case when the
util_avg of the task is lower than the maximum CPU capacity.
2.
There is no idle time. In that case, the util_avg value might aswell
be an under estimation of the size of the task.
It is possible that undesired frequency spikes will appear when the
task is later enqueued with an inflated util_est value, but the
frequency spike might aswell be deserved. The absence of idle time
prevents from drawing any conclusion.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.rog>
Link: https://lore.kernel.org/r/20250325150542.1077344-1-pierre.gondois@arm.com
---
 kernel/sched/fair.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e43993a..0c19459 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4933,13 +4933,6 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 		goto done;
 
 	/*
-	 * To avoid overestimation of actual task utilization, skip updates if
-	 * we cannot grant there is idle time in this CPU.
-	 */
-	if (dequeued > arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq))))
-		return;
-
-	/*
 	 * To avoid underestimate of task utilization, skip updates of EWMA if
 	 * we cannot grant that thread got all CPU time it wanted.
 	 */

