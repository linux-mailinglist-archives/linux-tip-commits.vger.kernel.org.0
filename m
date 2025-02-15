Return-Path: <linux-tip-commits+bounces-3366-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B53A36D6A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 11:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA7E27A4545
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 10:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014A41A83F8;
	Sat, 15 Feb 2025 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ue3qMwr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="boqWaUlE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4590A1A265E;
	Sat, 15 Feb 2025 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739616961; cv=none; b=N3dKbYPjp6gyqX3c3CKXUUzRMZpOas9rorl0bsHV0KwGMVaorTVkde7eT56S6CPcoQjlk5rAOdKWDYGqBsRlg/PBq8g2FiPlZ8LTT0u3Q2+d/D5zBjPFT8ta9djWnC6v4+i6sktYwoAGbCv/J9stZ4i53iN4/waoBgWFC9I3Oss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739616961; c=relaxed/simple;
	bh=GkY+egXIM3GyYLc2ENwowGhk7sj0FaBsV4aacldQ7Io=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OSMbDOLxqBNVSP3RSRJayNLH2PwtcUcGuH4Wxp3x1kpaWjCpX6vcuvvx53Ze2wTL/mZKKmabdHhLbMDQ+W0Iwgy1ji4QjIqYUEMV9jG9GM32GKLXH2bn2j0jn90yoHIKBMh4bR4lMsBvU/5Y88bFJkITBndBO4KRgmLm8cGp2Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3ue3qMwr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=boqWaUlE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 15 Feb 2025 10:55:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739616958;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmOJnWNjJT09hc5I0j0v2HvKTNHVDiQWBMYjoEKkBFQ=;
	b=3ue3qMwrQmZ8awQEWzyx+bSFUpZqwgHJsUf5+z/YLa27dZB178doDLOg4jUlO4/8p/qlF7
	VLEbB5g8z4bo/8k0vv7VHnKtCRxkjTVSA+eNTkLhNhe1wFzmvoriyaeqRpE4FI/sjXNNcs
	Hqyd867ksLWHJtfzj48i5fretkvdXtB/Iiyp3VV5/zypNH5Vs6m05R+AdrHYwBvSnc7njK
	I7V/d+jN0UkbPAMcu3gJ/cRIwKkbzWrrONTUeCZUkHsabbe5TEmpMvQOgbgGLe5bLZL/io
	dZbU/3vKBcCabIB/XyMv8O3zznApNRXssGg3RBAON+T4Qs1T7Gh7nRyOsTOPOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739616958;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jmOJnWNjJT09hc5I0j0v2HvKTNHVDiQWBMYjoEKkBFQ=;
	b=boqWaUlE11U/DWlbhGKVAWqt2h2hkcdlpCBQbO0WziYUdfqumZrISvx9DqV6ldkpf3zHSt
	cKq7n1ZWEZEr2iAg==
From: "tip-bot2 for zihan zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Reduce the default slice to avoid tasks
 getting an extra tick
Cc: zihan zhou <15645113830zzh@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250208075322.13139-1-15645113830zzh@gmail.com>
References: <20250208075322.13139-1-15645113830zzh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173961695796.10177.6989709679283453357.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2ae891b826958b60919ea21c727f77bcd6ffcc2c
Gitweb:        https://git.kernel.org/tip/2ae891b826958b60919ea21c727f77bcd6ffcc2c
Author:        zihan zhou <15645113830zzh@gmail.com>
AuthorDate:    Sat, 08 Feb 2025 15:53:23 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Feb 2025 10:32:00 +01:00

sched: Reduce the default slice to avoid tasks getting an extra tick

The old default value for slice is 0.75 msec * (1 + ilog(ncpus)) which
means that we have a default slice of:

  0.75 for 1 cpu
  1.50 up to 3 cpus
  2.25 up to 7 cpus
  3.00 for 8 cpus and above.

For HZ=250 and HZ=100, because of the tick accuracy, the runtime of
tasks is far higher than their slice.

For HZ=1000 with 8 cpus or more, the accuracy of tick is already
satisfactory, but there is still an issue that tasks will get an extra
tick because the tick often arrives a little faster than expected. In
this case, the task can only wait until the next tick to consider that it
has reached its deadline, and will run 1ms longer.

vruntime + sysctl_sched_base_slice =     deadline
        |-----------|-----------|-----------|-----------|
             1ms          1ms         1ms         1ms
                   ^           ^           ^           ^
                 tick1       tick2       tick3       tick4(nearly 4ms)

There are two reasons for tick error: clockevent precision and the
CONFIG_IRQ_TIME_ACCOUNTING/CONFIG_PARAVIRT_TIME_ACCOUNTING. with
CONFIG_IRQ_TIME_ACCOUNTING every tick will be less than 1ms, but even
without it, because of clockevent precision, tick still often less than
1ms.

In order to make scheduling more precise, we changed 0.75 to 0.70,
Using 0.70 instead of 0.75 should not change much for other configs
and would fix this issue:

  0.70 for 1 cpu
  1.40 up to 3 cpus
  2.10 up to 7 cpus
  2.8 for 8 cpus and above.

This does not guarantee that tasks can run the slice time accurately
every time, but occasionally running an extra tick has little impact.

Signed-off-by: zihan zhou <15645113830zzh@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20250208075322.13139-1-15645113830zzh@gmail.com
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 61b826f..1784752 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -74,10 +74,10 @@ unsigned int sysctl_sched_tunable_scaling = SCHED_TUNABLESCALING_LOG;
 /*
  * Minimal preemption granularity for CPU-bound tasks:
  *
- * (default: 0.75 msec * (1 + ilog(ncpus)), units: nanoseconds)
+ * (default: 0.70 msec * (1 + ilog(ncpus)), units: nanoseconds)
  */
-unsigned int sysctl_sched_base_slice			= 750000ULL;
-static unsigned int normalized_sysctl_sched_base_slice	= 750000ULL;
+unsigned int sysctl_sched_base_slice			= 700000ULL;
+static unsigned int normalized_sysctl_sched_base_slice	= 700000ULL;
 
 const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
 

