Return-Path: <linux-tip-commits+bounces-5684-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF4BABF3BA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 14:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6563A8A79
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E02265CBD;
	Wed, 21 May 2025 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bqySsJx8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FSfpryKJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7F8264A83;
	Wed, 21 May 2025 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829221; cv=none; b=SeMAkPbvII8XCZ+/s1Mw8x1Y3AkFnL1Nzll1gvzpxT4LWBy/Ormimivwl2H5QX5WF7V2UJ9UTqiAXZvo1yErZ1heGF3+RWBAuwnHbMg9HesDYMoNG3VYf+lhIHXEpGOm/LaPZTkOVVWkgJQ2BROobqpY8dXVsxtjMgaddUQy318=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829221; c=relaxed/simple;
	bh=ZWbD/uQQLpfFQlfliP2DJTRQKATQV+wzfZ2ZG5JOcgw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d6AxwyqhNgZYnuJX2FwfsdYuAbATvA2BTudiaNuUbuRRRh+JANyHKrnfQaQiadRz5aIotfi+8UzPT+G/KhYTQUIoNAD1xMb2JSgdqy3Mze0EA2JUPZB77wT7PbJG9d7HjP7JlVIgIgWPwPfVplTSK7IVS8/q+hlb8fKSPo7NKC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bqySsJx8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FSfpryKJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 12:06:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747829218;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owwaMQWf0ZzbnWwDeRiGVRpAikFalZJ8cwLI0wXQe5M=;
	b=bqySsJx8e6AlJYSNPMwFz31L8BiAOkclvF7HrH8jViqj+5WOw6TtpGn3UwUfK+8JTTgGt+
	v9LoL3bhUXpnjrGdRGDG95Gua11xfBMVkGr9CVxEp4dnvi0bpNZ64EcU8Ew8PcUmJtO6xw
	G6UU0rTR3X0UQ9wfUMt7u1lNC3tlG47T4fOxYv+d+moO3SOlfXCiBomOSW4wY0rFwq1aZF
	IpMXcfTUzZ0AMa+o32hvkcetdWRSltdzDn0BQdn98XL9xaG6guvlAsBgeU2btlsGAZsoxW
	rwQCRfFvsU7qsU0Al6BGe9uTDXRvAdOErFnIk1m+1OBJJ5BCxogj/gvLYasdZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747829218;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owwaMQWf0ZzbnWwDeRiGVRpAikFalZJ8cwLI0wXQe5M=;
	b=FSfpryKJdb4qFk/jRxDacShBs6vrx9s+B6fxgugvhD5DxEtZ+Yz1SeZjv6eOVbDhsLs9EI
	f/tbHYs268rx14Ag==
From: "tip-bot2 for Xuewen Yan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Align uclamp and util_est and call
 before freq update
Cc: Xuewen Yan <xuewen.yan@unisoc.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250417043457.10632-3-xuewen.yan@unisoc.com>
References: <20250417043457.10632-3-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782921727.406.15875365977887528784.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     90ca9410dab21c407706726b86b6e50c6698b5af
Gitweb:        https://git.kernel.org/tip/90ca9410dab21c407706726b86b6e50c6698b5af
Author:        Xuewen Yan <xuewen.yan@unisoc.com>
AuthorDate:    Thu, 17 Apr 2025 12:34:57 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 May 2025 13:57:38 +02:00

sched/uclamp: Align uclamp and util_est and call before freq update

The commit dfa0a574cbc47 ("sched/uclamg: Handle delayed dequeue")
has add the sched_delayed check to prevent double uclamp_dec/inc.
However, it put the uclamp_rq_inc() after enqueue_task().
This may lead to the following issues:
When a task with uclamp goes through enqueue_task() and could trigger
cpufreq update, its uclamp won't even be considered in the cpufreq
update. It is only after enqueue will the uclamp be added to rq
buckets, and cpufreq will only pick it up at the next update.
This could cause a delay in frequency updating. It may affect
the performance(uclamp_min > 0) or power(uclamp_max < 1024).

So, just like util_est, put the uclamp_rq_inc() before enqueue_task().
And as for the sched_delayed_task, same as util_est, using the
sched_delayed flag to prevent inc the sched_delayed_task's uclamp,
using the ENQUEUE_DELAYED flag to allow inc the sched_delayed_task's uclamp
which is being woken up.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20250417043457.10632-3-xuewen.yan@unisoc.com
---
 kernel/sched/core.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bece0ba..64c8757 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1753,7 +1753,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	}
 }
 
-static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
+static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p, int flags)
 {
 	enum uclamp_id clamp_id;
 
@@ -1769,7 +1769,8 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
 
-	if (p->se.sched_delayed)
+	/* Only inc the delayed task which being woken up. */
+	if (p->se.sched_delayed && !(flags & ENQUEUE_DELAYED))
 		return;
 
 	for_each_clamp_id(clamp_id)
@@ -2037,7 +2038,7 @@ static void __init init_uclamp(void)
 }
 
 #else /* !CONFIG_UCLAMP_TASK */
-static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
+static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p, int flags) { }
 static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
 static inline void uclamp_fork(struct task_struct *p) { }
 static inline void uclamp_post_fork(struct task_struct *p) { }
@@ -2073,12 +2074,14 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (!(flags & ENQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
-	p->sched_class->enqueue_task(rq, p, flags);
 	/*
-	 * Must be after ->enqueue_task() because ENQUEUE_DELAYED can clear
-	 * ->sched_delayed.
+	 * Can be before ->enqueue_task() because uclamp considers the
+	 * ENQUEUE_DELAYED task before its ->sched_delayed gets cleared
+	 * in ->enqueue_task().
 	 */
-	uclamp_rq_inc(rq, p);
+	uclamp_rq_inc(rq, p, flags);
+
+	p->sched_class->enqueue_task(rq, p, flags);
 
 	psi_enqueue(p, flags);
 

