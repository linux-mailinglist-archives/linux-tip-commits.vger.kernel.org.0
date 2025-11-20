Return-Path: <linux-tip-commits+bounces-7419-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A245AC73AEE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 12:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 41E9124140
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 11:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9939B331A7F;
	Thu, 20 Nov 2025 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZvzdWtNI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4s5/bVPQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42B73321D0;
	Thu, 20 Nov 2025 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637606; cv=none; b=H2OjXFMxBWMjjToNZMSYPE1I7Vcbt7GvFduI58vH1fZJrWOHuNs83VSUvVELiglE07z/pkH2DPImP5zxNm06z7RL3vfGZTYoEKTKPlYZNtymQy85Q+c0yfjzbRba7ikD4MKGTlYepDsO/FVDu+kPVupWYYmTh0M+lfGdjCtF5I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637606; c=relaxed/simple;
	bh=u8oYvygliQuGX9K50pAqTcQsyRpzbNVcjqr4qjXj9yE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=i838AXPO68IOW0+qj6lFmAYiYq9CaUtVvQsVi4OLChFmgNfs6SeUTCpA1CFCjl9e4FiTjKqxHkTCZmcRwYF1XoRLBkvxOLaZTUpFfzFcAXKD73gkTcPCrUCH+rNIpBz/rTWybX+zrqQL0hWah8iA8reiyhkWCQ/YNL8y6zfIjuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZvzdWtNI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4s5/bVPQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 11:20:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763637602;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N6TrQS+zpbyI2s80mHGaj62NNvlG32DvLZ2MYaL4Kn4=;
	b=ZvzdWtNIHqoEskOVyrgO/SbPvwcisqeflcUZMAmJgtzSvilWUH2nlSE7k8KWm1NTaH75UC
	MhRgDQsZmkLpTb224NQU5neT5Bxr9wgpKikfBt16qVmBWuVbY3ldoM79yl+/0hr/5l5C6U
	cFygYvHNOaAy/LeKteew01K8KEnSfvcGSzG2aa6h8Sqqr8L2F4567DyD83IuNd9Rj1XwHg
	L+8u/xIDSeB+wb/PcQxeh9f0MIkTM01Ov00i5jw4oMExMrCOee5V7PWn1N2VySH860fy/X
	gtsUNJJ5HqdwnEeSGeULcNADCLuVuOheHSY1xcc1k1CkyaM1gTj0G8HNBDu8VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763637602;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N6TrQS+zpbyI2s80mHGaj62NNvlG32DvLZ2MYaL4Kn4=;
	b=4s5/bVPQfPTGeiy6cWLwJ1YTZ87qOjsM1EjpfGmh0t5q44OG25pda4e9UQmoy5+uwB9xJe
	Ddkr03lViwAHMIDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] sched/mmcid: Use cpumask_weighted_or()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251119172549.511736272@linutronix.de>
References: <20251119172549.511736272@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176363760125.498.15227477726391042766.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     79c11fb3da8581a2f222b290ce62a153ab1108fc
Gitweb:        https://git.kernel.org/tip/79c11fb3da8581a2f222b290ce62a153ab1=
108fc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Nov 2025 18:26:59 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Nov 2025 12:14:54 +01:00

sched/mmcid: Use cpumask_weighted_or()

Use cpumask_weighted_or() instead of cpumask_or() and cpumask_weight() on
the result, which walks the same bitmap twice. Results in 10-20% less
cycles, which reduces the runqueue lock hold time.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Link: https://patch.msgid.link/20251119172549.511736272@linutronix.de
---
 kernel/sched/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2ea77e7..f6bbfa1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10377,6 +10377,7 @@ void call_trace_sched_update_nr_running(struct rq *rq=
, int count)
 static inline void mm_update_cpus_allowed(struct mm_struct *mm, const struct=
 cpumask *affmsk)
 {
 	struct cpumask *mm_allowed;
+	unsigned int weight;
=20
 	if (!mm)
 		return;
@@ -10387,8 +10388,8 @@ static inline void mm_update_cpus_allowed(struct mm_s=
truct *mm, const struct cpu
 	 */
 	guard(raw_spinlock)(&mm->mm_cid.lock);
 	mm_allowed =3D mm_cpus_allowed(mm);
-	cpumask_or(mm_allowed, mm_allowed, affmsk);
-	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, cpumask_weight(mm_allowed));
+	weight =3D cpumask_weighted_or(mm_allowed, mm_allowed, affmsk);
+	WRITE_ONCE(mm->mm_cid.nr_cpus_allowed, weight);
 }
=20
 void sched_mm_cid_exit_signals(struct task_struct *t)

