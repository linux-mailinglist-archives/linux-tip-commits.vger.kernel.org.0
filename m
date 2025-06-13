Return-Path: <linux-tip-commits+bounces-5801-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28459AD848C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9896189E21E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E0D2EACF7;
	Fri, 13 Jun 2025 07:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nNH/ftsK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="US+5A4r9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726332EA46B;
	Fri, 13 Jun 2025 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800248; cv=none; b=lYhqKiwtQttDEtD0YeDg6zz3XX0kqVSY/CgeLUi9L5K2kiXutsMDD6EGHWlTN/bJiNQtahYf7Z+r3t/LvK9JsUIMbUkcMh7CPUYEDMpL6HMjLdLR0OmNRSGciMa9mFQgskn5DHdQUtZROFJSKCzuQVZfGNwHtH0P2ZW+cU5W/Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800248; c=relaxed/simple;
	bh=6V3wlEPKx9+8wq2Ei0siVuA4LyY497UYAPa7kXtssYY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kI5PGZYpK8fAL6kUx+UgJbX8OrOVMEVLPxkthklDqEE11PyHXyeUPUu8kHcIH5h0iqRigE2tC5OdTu4Rv301eddvi2DRVwzANh+3gRc9bwRDULvdA9ikYM28+O2sqVWsOebcgAWtQcnAhmT9DHjTzY0OzBcqNdYbAFKmTbIJRsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nNH/ftsK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=US+5A4r9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYIsnDU8WC0ziMb6tuqtMGqh8cDArr2Ywoa/iQoXFD0=;
	b=nNH/ftsKC/6mAlkkCXwMq5754+sz41tYtKj7SVchWX9/dtwGOv0M27vquKyxq1XL9g/rSq
	sN6+zUbJ8jJnaRkz1jJj+cXneOIuklG36zM6ui/C4gy7zNNhbZk2QF8TVR4aTYB8i7QTB4
	f9v9LwxIUD+bMiAhtisZ3Zq9qRXcBR/m4822P4a9XjshRmOzbOQalYJOTvxwlZSa3RsCbe
	FVKKl7sJIy69wl0JdOZZuGaFPvectwYALVqzrdLqgpAWKl/630l0fWtwBJfZ54hc39HZdI
	BLsPDNjbptNjatsu/8vIgIfPOTb177H23bTqgwtrmDBcjvAG9NfPiBlChr0fxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYIsnDU8WC0ziMb6tuqtMGqh8cDArr2Ywoa/iQoXFD0=;
	b=US+5A4r9Dr3SyMYnq0/yPtXC5a/OFThEzA8/a+1KA4tmjsRG4MxZn6hmWECvUrZOVlysUC
	osp5NQkLM+x66pBw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/smp: Always define rq->hrtick_csd
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-23-mingo@kernel.org>
References: <20250528080924.2273858-23-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980024393.406.16037138815112197651.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a1416303d108befb4e2b62c863ae1defe4eb1ba3
Gitweb:        https://git.kernel.org/tip/a1416303d108befb4e2b62c863ae1defe4eb1ba3
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:03 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:19 +02:00

sched/smp: Always define rq->hrtick_csd

Simplify the scheduler by making CONFIG_SMP=y data structure
of rq->hrtick_csd unconditional.

Adjust hrtick_start() accordingly, which was split due to the
::hrtick_csd asymmetry and use the SMP version there too.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250528080924.2273858-23-mingo@kernel.org
---
 kernel/sched/core.c  | 23 -----------------------
 kernel/sched/sched.h |  2 --
 2 files changed, 25 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9fc44f4..c155ee0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -851,8 +851,6 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-#ifdef CONFIG_SMP
-
 static void __hrtick_restart(struct rq *rq)
 {
 	struct hrtimer *timer = &rq->hrtick_timer;
@@ -897,30 +895,9 @@ void hrtick_start(struct rq *rq, u64 delay)
 		smp_call_function_single_async(cpu_of(rq), &rq->hrtick_csd);
 }
 
-#else /* !CONFIG_SMP: */
-/*
- * Called to set the hrtick timer state.
- *
- * called with rq->lock held and IRQs disabled
- */
-void hrtick_start(struct rq *rq, u64 delay)
-{
-	/*
-	 * Don't schedule slices shorter than 10000ns, that just
-	 * doesn't make sense. Rely on vruntime for fairness.
-	 */
-	delay = max_t(u64, delay, 10000LL);
-	hrtimer_start(&rq->hrtick_timer, ns_to_ktime(delay),
-		      HRTIMER_MODE_REL_PINNED_HARD);
-}
-
-#endif /* !CONFIG_SMP */
-
 static void hrtick_rq_init(struct rq *rq)
 {
-#ifdef CONFIG_SMP
 	INIT_CSD(&rq->hrtick_csd, __hrtick_start, rq);
-#endif
 	hrtimer_setup(&rq->hrtick_timer, hrtick, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 }
 #else /* !CONFIG_SCHED_HRTICK: */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7a7ebc2..3e7151e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1219,9 +1219,7 @@ struct rq {
 	long			calc_load_active;
 
 #ifdef CONFIG_SCHED_HRTICK
-#ifdef CONFIG_SMP
 	call_single_data_t	hrtick_csd;
-#endif
 	struct hrtimer		hrtick_timer;
 	ktime_t			hrtick_time;
 #endif

