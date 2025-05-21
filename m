Return-Path: <linux-tip-commits+bounces-5686-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF28ABF3B9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 14:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7432A17BAE6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5011266F0A;
	Wed, 21 May 2025 12:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TBO+jkrQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q3QwwSVT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A8C2620CA;
	Wed, 21 May 2025 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829224; cv=none; b=aUKT9krAkvYzk+Dno1wS50OuDy5yfxNJJgfl2iCg6w9rztDXXRdnrdoQoVGy+qn9R/Q7weF23hBtlqw4cxR6ZNQKlWgN8JBfYVAc2NSk8mFcW/NHlg0k0ajjo7+seotJqVp5kgMYLtfB39L3lY7Ezbb0EIBx6tVywxo2aRMftZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829224; c=relaxed/simple;
	bh=4f3GErb7iG91VHeb17MxeFUuwKzVQNWM3ekgy4F7B0s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kezowSNPMnwvNowYwTvmnIh0v4tS0IaOig9soVJ0h+0yqHnfbCex78SDwH0NQBCfVB2LFHXo3zsW9yBqJpp6wpDPenecNcg8M4NDvGWelNYIvoho//mDNI0fMOS+PZGhvP7oS3x+24BBqzDPQ8lDRF5sZKopScEFoe1daxqmEPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TBO+jkrQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q3QwwSVT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 12:06:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747829219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D9b/sXfbegNOENEUxK37ibHpQkoYvLSrF7f3fvQRsX8=;
	b=TBO+jkrQpsBBnDI18OtxcTNLfMHsYztNjnXLqYqxf/VC9J8lghUKNw9q4rAlvDqEYa7c8t
	Bkr7hsqObjty4Y7w3ZFDh5yKLAqlzGT9KU0UueuCuUWu0Hom2g0Wk4GxxSsRoIKS52BYB/
	RANlC8/9qr/lvXAzCaEgXY15It+9jtRNQBZzWSyVFACBLcqOptU06DtYfUPgXC3zL72Kvy
	ViYcqLs7JY/p7F8DNHPbGnw55OKHlMBAf9r3smwWaiBMg7XNNhEYx5cwQF1AJibi6BM0tq
	1T8JIWbrjcOhBQvjfi8yvtnkiEVxVIGK1yLOiD0FpLl/SNwLse0Gmg6R9JvCcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747829219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D9b/sXfbegNOENEUxK37ibHpQkoYvLSrF7f3fvQRsX8=;
	b=q3QwwSVTYM1mGi/TQa+PF03r8mOtKMVO6L6/H6O0g+Yu0lwV2qN3CkZCp0v6A1a6EIVHhP
	79fQM9UZZHHwgNDA==
From: "tip-bot2 for Xuewen Yan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fixup wake_up_sync() vs DELAYED_DEQUEUE
Cc: Xuewen Yan <xuewen.yan@unisoc.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303105241.17251-2-xuewen.yan@unisoc.com>
References: <20250303105241.17251-2-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782921892.406.11738069373254097989.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     aa3ee4f0b7541382c9f6f43f7408d73a5d4f4042
Gitweb:        https://git.kernel.org/tip/aa3ee4f0b7541382c9f6f43f7408d73a5d4f4042
Author:        Xuewen Yan <xuewen.yan@unisoc.com>
AuthorDate:    Mon, 03 Mar 2025 18:52:39 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 May 2025 13:57:37 +02:00

sched/fair: Fixup wake_up_sync() vs DELAYED_DEQUEUE

Delayed dequeued feature keeps a sleeping task enqueued until its
lag has elapsed. As a result, it stays also visible in rq->nr_running.
So when in wake_affine_idle(), we should use the real running-tasks
in rq to check whether we should place the wake-up task to
current cpu.
On the other hand, add a helper function to return the nr-delayed.

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Reviewed-and-tested-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250303105241.17251-2-xuewen.yan@unisoc.com
---
 kernel/sched/fair.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index eb5a257..b00f167 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7193,6 +7193,11 @@ static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	return true;
 }
 
+static inline unsigned int cfs_h_nr_delayed(struct rq *rq)
+{
+	return (rq->cfs.h_nr_queued - rq->cfs.h_nr_runnable);
+}
+
 #ifdef CONFIG_SMP
 
 /* Working cpumask for: sched_balance_rq(), sched_balance_newidle(). */
@@ -7354,8 +7359,12 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
 		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
 
-	if (sync && cpu_rq(this_cpu)->nr_running == 1)
-		return this_cpu;
+	if (sync) {
+		struct rq *rq = cpu_rq(this_cpu);
+
+		if ((rq->nr_running - cfs_h_nr_delayed(rq)) == 1)
+			return this_cpu;
+	}
 
 	if (available_idle_cpu(prev_cpu))
 		return prev_cpu;

