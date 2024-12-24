Return-Path: <linux-tip-commits+bounces-3112-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 372409FBB78
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 10:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49DC188679C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 09:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308EC1A8F98;
	Tue, 24 Dec 2024 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S4YYu7yd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cCwbBrr9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E57B19E960;
	Tue, 24 Dec 2024 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033627; cv=none; b=YGbBJ5+4hqDKDeoAajSIQMnlaMHgExCuB7icvPdbC1sYKdUm58lHT9CKMow3xspkKy5m7h5TsQEtcVUq6GOA63Ulr+XrMcsLFInAVZvFQWrjkEXGnfD8rWLUmKfqOF9fNHpV0KTJ1VOner/VCFwCiLXVoJhVi+T/MoWBKMMh49I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033627; c=relaxed/simple;
	bh=B4CGeIoaMhvdgTBSOWbck5kysTOAkUiKF+Doctpr3XM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ReQNUCVXHH0FcwtglzcPIeRQ9LSz6CRchBAqwyiUrgesBJt/XrnqxdNGdKACXDcKrNSuNmbYY6gyP/Pj4Yh1LEiOAm1C+GfcXIto/8KsBobflxYARSqALo5p50Biu1HITWEgQ086serZ3u5dM7ZNaJNQg+BFIwZVFl8pJ/+wAII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S4YYu7yd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cCwbBrr9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 09:47:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735033623;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5p45QDhM/H9lsj1AR8sShFv1rNp2hlJlwfATe7Nqi4M=;
	b=S4YYu7ydw1ZtV8RxRInQq++y0HElC8xrIz2VYWSwnAc7al9BZ+84HQKlhMKpseORMK1Z8C
	kIbR+ldLFKVlxIMbybE4Vc/ortmfs5NyMMIKhhjCbisn+PU6HoEVfGorxdiF+z4t7B39jk
	fGOzRuJAInOu0e6BqRMaBvoq9X5J1MdyVGhTK09evdLRshyv4AynpGmiVTE+hDNMXsQ6s9
	akAC06+4McjBHQp0X2Tsi4imzb60mezDB3T7osFWaH0ywU0iIyZAFXP8DImgHWWB4Zc5tL
	gyO0CZC4rC8DXp5vraSHJk5c8rDrlHT3bUmWlqaA8klJXI5eURj3cyWsUqlhtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735033623;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5p45QDhM/H9lsj1AR8sShFv1rNp2hlJlwfATe7Nqi4M=;
	b=cCwbBrr9025YrFg/Otd7wXb3D7sd95tMpoxqvLcZT4D9wX1qVJjJgfJ6qdTA3RGBVIiK0U
	7tONg8shSEm9lADw==
From: "tip-bot2 for Vishal Chourasia" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix CPU bandwidth limit bypass during
 CPU hotplug
Cc: Zhang Qiao <zhangqiao22@huawei.com>,
 Vishal Chourasia <vishalc@linux.ibm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 Samir Mulani <samir@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241212043102.584863-2-vishalc@linux.ibm.com>
References: <20241212043102.584863-2-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173503362276.399.18144572389651858161.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     af98d8a36a963e758e84266d152b92c7b51d4ecb
Gitweb:        https://git.kernel.org/tip/af98d8a36a963e758e84266d152b92c7b51d4ecb
Author:        Vishal Chourasia <vishalc@linux.ibm.com>
AuthorDate:    Thu, 12 Dec 2024 10:01:03 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 17 Dec 2024 17:47:22 +01:00

sched/fair: Fix CPU bandwidth limit bypass during CPU hotplug

CPU controller limits are not properly enforced during CPU hotplug
operations, particularly during CPU offline. When a CPU goes offline,
throttled processes are unintentionally being unthrottled across all CPUs
in the system, allowing them to exceed their assigned quota limits.

Consider below for an example,

Assigning 6.25% bandwidth limit to a cgroup
in a 8 CPU system, where, workload is running 8 threads for 20 seconds at
100% CPU utilization, expected (user+sys) time = 10 seconds.

$ cat /sys/fs/cgroup/test/cpu.max
50000 100000

$ ./ebizzy -t 8 -S 20        // non-hotplug case
real 20.00 s
user 10.81 s                 // intended behaviour
sys   0.00 s

$ ./ebizzy -t 8 -S 20        // hotplug case
real 20.00 s
user 14.43 s                 // Workload is able to run for 14 secs
sys   0.00 s                 // when it should have only run for 10 secs

During CPU hotplug, scheduler domains are rebuilt and cpu_attach_domain
is called for every active CPU to update the root domain. That ends up
calling rq_offline_fair which un-throttles any throttled hierarchies.

Unthrottling should only occur for the CPU being hotplugged to allow its
throttled processes to become runnable and get migrated to other CPUs.

With current patch applied,
$ ./ebizzy -t 8 -S 20        // hotplug case
real 21.00 s
user 10.16 s                 // intended behaviour
sys   0.00 s

This also has another symptom, when a CPU goes offline, and if the cfs_rq
is not in throttled state and the runtime_remaining still had plenty
remaining, it gets reset to 1 here, causing the runtime_remaining of
cfs_rq to be quickly depleted.

Note: hotplug operation (online, offline) was performed in while(1) loop

v3: https://lore.kernel.org/all/20241210102346.228663-2-vishalc@linux.ibm.com
v2: https://lore.kernel.org/all/20241207052730.1746380-2-vishalc@linux.ibm.com
v1: https://lore.kernel.org/all/20241126064812.809903-2-vishalc@linux.ibm.com
Suggested-by: Zhang Qiao <zhangqiao22@huawei.com>
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Tested-by: Samir Mulani <samir@linux.ibm.com>
Link: https://lore.kernel.org/r/20241212043102.584863-2-vishalc@linux.ibm.com
---
 kernel/sched/fair.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2c4ebfc..8f641c9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6696,6 +6696,10 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 
 	lockdep_assert_rq_held(rq);
 
+	// Do not unthrottle for an active CPU
+	if (cpumask_test_cpu(cpu_of(rq), cpu_active_mask))
+		return;
+
 	/*
 	 * The rq clock has already been updated in the
 	 * set_rq_offline(), so we should skip updating
@@ -6711,18 +6715,20 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
 			continue;
 
 		/*
-		 * clock_task is not advancing so we just need to make sure
-		 * there's some valid quota amount
-		 */
-		cfs_rq->runtime_remaining = 1;
-		/*
 		 * Offline rq is schedulable till CPU is completely disabled
 		 * in take_cpu_down(), so we prevent new cfs throttling here.
 		 */
 		cfs_rq->runtime_enabled = 0;
 
-		if (cfs_rq_throttled(cfs_rq))
-			unthrottle_cfs_rq(cfs_rq);
+		if (!cfs_rq_throttled(cfs_rq))
+			continue;
+
+		/*
+		 * clock_task is not advancing so we just need to make sure
+		 * there's some valid quota amount
+		 */
+		cfs_rq->runtime_remaining = 1;
+		unthrottle_cfs_rq(cfs_rq);
 	}
 	rcu_read_unlock();
 

