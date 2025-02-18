Return-Path: <linux-tip-commits+bounces-3426-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DB4A39783
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF40175BC1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7690241C80;
	Tue, 18 Feb 2025 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j46AEJ9k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XtyWOQA3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BE223FC67;
	Tue, 18 Feb 2025 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872003; cv=none; b=hQ/qJtVgNTGpCwXctqm+xtWMKs3ThKunbHfAtlnVSyan2QOUy35cughIj22Dk0nVhjfbfaLjZqVh28T8xBxfU6Atu5zR3k7igxOhHR+cHYAYbmQjdAqp1NJPc/n7JHkcInmSM+ZPkrnyysl4Kx68ja+CNff/DQaQt62nZaEr0Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872003; c=relaxed/simple;
	bh=qSEVb3kCQaK8J3/nbP4ILG0yIo16U9dW1RXv6GzX0Uw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hsQ2HN9hLECgwpXYHRoJlhvV8389AJfzx+ylKoIXLlJ/rTYSEgNE4ea7ShIWvvZDZ+1axVLpbQhI73i37DpIez1MudzY0VScOqCPoLGFYd/rfjh+4N04+sI6pQ8PX1EvMkcqqb2lfERXe+UnSS3j4/Mj9CX1MychbtoDverkba8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j46AEJ9k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XtyWOQA3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739871998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E9k1cQEhzoPnZQNOO5qg0/GTRvoclYS59lkm2s2YsW4=;
	b=j46AEJ9kZH2nmJl5Bnd3C+6NsRDi42HJCaPbxxV6Fk8h7t0vb1Pl5H0fW81G5+LlgJ2Rqu
	/OWJPJs8Bv2nhuplj3NhPM/k6e0pwvgL9sdLw1Lm7RJFIJUwbYH9iZ8NfwdkObI2uNxeuu
	E9hSyD5GHkO6f7AaK6mNP6xlXS/PARg4OwqTfYlXkcgNXENhV+TnXMvB5hYIAc1wi+iBJF
	i+rTM4OFeQmh5HtZjD/0RAyZspf+tKYku60+GGO6wmTf0+QO9W8z/lf7YzH9cGW2zPYRar
	j972wJD7L3g4ta5/oXg26rRANrFdTbgFIyc+OcM2+yz5M8c/qShNlfpqRplSrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739871998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E9k1cQEhzoPnZQNOO5qg0/GTRvoclYS59lkm2s2YsW4=;
	b=XtyWOQA3UfwqBd4Sf7DnTxQ2dAciLveNwy3PrRqEs+xFfoCm0cqyq5Mf5W7BJlRbybu4I7
	s25lRqE3eABQujAA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] sched: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ca55e849cba3c41b4c5708be6ea6be6f337d1a8fb=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Ca55e849cba3c41b4c5708be6ea6be6f337d1a8fb=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987199830.10177.14921723966337328012.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     ee13da875b8a4636198538dbe2e8037574e7a98e
Gitweb:        https://git.kernel.org/tip/ee13da875b8a4636198538dbe2e8037574e7a98e
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:38:57 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:32 +01:00

sched: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/a55e849cba3c41b4c5708be6ea6be6f337d1a8fb.1738746821.git.namcao@linutronix.de

---
 kernel/sched/core.c     | 3 +--
 kernel/sched/deadline.c | 6 ++----
 kernel/sched/fair.c     | 8 ++++----
 kernel/sched/rt.c       | 5 ++---
 4 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9aecd91..6469755 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -916,8 +916,7 @@ static void hrtick_rq_init(struct rq *rq)
 #ifdef CONFIG_SMP
 	INIT_CSD(&rq->hrtick_csd, __hrtick_start, rq);
 #endif
-	hrtimer_init(&rq->hrtick_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	rq->hrtick_timer.function = hrtick;
+	hrtimer_setup(&rq->hrtick_timer, hrtick, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 }
 #else	/* CONFIG_SCHED_HRTICK */
 static inline void hrtick_clear(struct rq *rq)
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 38e4537..2d0f571 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1382,8 +1382,7 @@ static void init_dl_task_timer(struct sched_dl_entity *dl_se)
 {
 	struct hrtimer *timer = &dl_se->dl_timer;
 
-	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	timer->function = dl_task_timer;
+	hrtimer_setup(timer, dl_task_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 }
 
 /*
@@ -1839,8 +1838,7 @@ static void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se)
 {
 	struct hrtimer *timer = &dl_se->inactive_timer;
 
-	hrtimer_init(timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	timer->function = inactive_task_timer;
+	hrtimer_setup(timer, inactive_task_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 }
 
 #define __node_2_dle(node) \
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1c0ef43..88923f1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6539,14 +6539,14 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *paren
 	cfs_b->hierarchical_quota = parent ? parent->hierarchical_quota : RUNTIME_INF;
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
-	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
-	cfs_b->period_timer.function = sched_cfs_period_timer;
+	hrtimer_setup(&cfs_b->period_timer, sched_cfs_period_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS_PINNED);
 
 	/* Add a random offset so that timers interleave */
 	hrtimer_set_expires(&cfs_b->period_timer,
 			    get_random_u32_below(cfs_b->period));
-	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	cfs_b->slack_timer.function = sched_cfs_slack_timer;
+	hrtimer_setup(&cfs_b->slack_timer, sched_cfs_slack_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 	cfs_b->slack_started = false;
 }
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4b8e33c..7a9ed4d 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -127,9 +127,8 @@ void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime)
 
 	raw_spin_lock_init(&rt_b->rt_runtime_lock);
 
-	hrtimer_init(&rt_b->rt_period_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL_HARD);
-	rt_b->rt_period_timer.function = sched_rt_period_timer;
+	hrtimer_setup(&rt_b->rt_period_timer, sched_rt_period_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_HARD);
 }
 
 static inline void do_start_rt_bandwidth(struct rt_bandwidth *rt_b)

