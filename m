Return-Path: <linux-tip-commits+bounces-1640-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D837492B895
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Jul 2024 13:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142601C2224B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Jul 2024 11:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C66415B57D;
	Tue,  9 Jul 2024 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BNccwrGo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zwc2gUTm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE53D158D87;
	Tue,  9 Jul 2024 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525322; cv=none; b=dBQTsaRvc/4clbbzMPNi+B0s7IyUPIecb5R4vf698M/pgJR7OHX1oZPOhoEOuWrzmxU9TKB88qw6MhXYR+o+EOwhp+NQEialx01hY0+1nLj9ByjSqyYQl1SpzXZd8WXpvMLaUZEET0PgBcTsMD9KuKiIejavLWOsV7oWJ98/rBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525322; c=relaxed/simple;
	bh=oTVLB6Hpbx867/elj9iObBnELvzrXOKwLloh82MliQE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a51ccSICQzvWHDGrvCC45kRW4j1LJyGVa8irlOUkpkqLhbqkMkFTcHI0pNoPJFfoTYkgY2y/ucys8adtVHzQaF4ocTaDX8Qf1oUpQd7arCdAfwBQJsAFr+TfXuD4rixq0elgIbXaqSEl4ehIYStr/WPZXQYuAM9KXiHt3q6VXyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BNccwrGo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zwc2gUTm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Jul 2024 11:41:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720525317;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjqEqY1WF9byWsxps4XVXpcFkWaKBLnHyxOIJ0EKYCQ=;
	b=BNccwrGoGuxN5SP6WqggDCebFGKWv+L2Oz2k1w3n/GN430zAnPJiWAfrNfm2P9MbL4mvL8
	lfE30p8bN3+SNzL+lESByX7qOJNX8wvAjdh7BW/HtwMyoz9qn9XoHoQ9v9cuhQV1eYj53p
	10uOrEdRXLobYPsymK9vCTo41aV8PcznI+brZ9925Cyd6eOSB5jsVc1v+rUjKZ5GWHjrIe
	ooztTSSzeyDH6uFOM3k8YKcHYWXtIqlwhAhJGJ179MNCeI04/ZaK9YS0e3hvN7poJJZxfo
	yf0u5Yn0XbAx6EjiqnIJc3+R9zMnKNBMxoJwnulTFBSFrPoUfzEiYV+0U6P/JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720525317;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MjqEqY1WF9byWsxps4XVXpcFkWaKBLnHyxOIJ0EKYCQ=;
	b=zwc2gUTmyCgHPGnrkMlqvzRy9wsqaf81s99Tc8+mebFdiVDzxeDA53/18g0hkDZ0hgU/w+
	0247Y9QoiyM9pZBg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf: Don't disable preemption in perf_pending_task().
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Marco Elver <elver@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240704170424.1466941-7-bigeasy@linutronix.de>
References: <20240704170424.1466941-7-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172052531756.2215.11237686920365836246.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     16b9569df9d2ab07eeee075cb7895e9d3e08e8f0
Gitweb:        https://git.kernel.org/tip/16b9569df9d2ab07eeee075cb7895e9d3e08e8f0
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 04 Jul 2024 19:03:40 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 09 Jul 2024 13:26:36 +02:00

perf: Don't disable preemption in perf_pending_task().

perf_pending_task() is invoked in task context and disables preemption
because perf_swevent_get_recursion_context() used to access per-CPU
variables. The other reason is to create a RCU read section while
accessing the perf_event.

The recursion counter is no longer a per-CPU accounter so disabling
preemption is no longer required. The RCU section is needed and must be
created explicit.

Replace the preemption-disable section with a explicit RCU-read section.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/r/20240704170424.1466941-7-bigeasy@linutronix.de
---
 kernel/events/core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b523225..96e03d6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5208,10 +5208,9 @@ static void perf_pending_task_sync(struct perf_event *event)
 	}
 
 	/*
-	 * All accesses related to the event are within the same
-	 * non-preemptible section in perf_pending_task(). The RCU
-	 * grace period before the event is freed will make sure all
-	 * those accesses are complete by then.
+	 * All accesses related to the event are within the same RCU section in
+	 * perf_pending_task(). The RCU grace period before the event is freed
+	 * will make sure all those accesses are complete by then.
 	 */
 	rcuwait_wait_event(&event->pending_work_wait, !event->pending_work, TASK_UNINTERRUPTIBLE);
 }
@@ -6831,7 +6830,7 @@ static void perf_pending_task(struct callback_head *head)
 	 * critical section as the ->pending_work reset. See comment in
 	 * perf_pending_task_sync().
 	 */
-	preempt_disable_notrace();
+	rcu_read_lock();
 	/*
 	 * If we 'fail' here, that's OK, it means recursion is already disabled
 	 * and we won't recurse 'further'.
@@ -6844,10 +6843,10 @@ static void perf_pending_task(struct callback_head *head)
 		local_dec(&event->ctx->nr_pending);
 		rcuwait_wake_up(&event->pending_work_wait);
 	}
+	rcu_read_unlock();
 
 	if (rctx >= 0)
 		perf_swevent_put_recursion_context(rctx);
-	preempt_enable_notrace();
 }
 
 #ifdef CONFIG_GUEST_PERF_EVENTS

