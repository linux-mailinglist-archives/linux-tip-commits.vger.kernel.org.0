Return-Path: <linux-tip-commits+bounces-5798-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91642AD8473
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D541715E1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C152EA460;
	Fri, 13 Jun 2025 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ce82DTw3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1BOQppH2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081C12E92A4;
	Fri, 13 Jun 2025 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800245; cv=none; b=TXaDtNDmsMXXksMAJDsUW49KnliXba+wUs7y2i+kdIk4wBzaC6Wyl8zEi1JQFyfJhWTNRNokrbyWu29r6hL6VY7epR2fhkn0b7Cex9KF6ElkONuUc1wwe5gajrcpNYNyI3g5oBtjEdpcpXjYJC96yh2cqLxFmRf6zYVYmar9G1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800245; c=relaxed/simple;
	bh=MoGp8uJQJwo9zjaWwqEJlZS9a/64bol58uArdpw0X6U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QrxEO8SFN65lLOUTV/uLamT5I1GztyxvXEKLcIYlZlZIGJeRAqOAgcjqs5xYzVF9xCUDBXm4fQKa/yn4TeLh81xeXYOWBgkS9VwaLLHTvAhCBtz/nWMnveExfkSqSPHZ5EHafrrYLa+s41/t2eRU5lqZ3zqftKtWoEM5W9eXETs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ce82DTw3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1BOQppH2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800242;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCtfbWYCL0AGtqzaHfkPt4CybVKvLNOiPpPAm/n3izE=;
	b=Ce82DTw3QdQKj+5Ez5ja95s3yqROXIM3+b0D3KbPNjWPiyHEEe4HThgNSDVGNBWcgtPrPd
	bZMGgfJwJp7TM5ohYiK2duZasMBprPP1wWie/0lSDKdeqdWzLHjwIN/tVfR1haQMEBteVO
	QM004TUgErim8ITMmxdii/phKkDX727RV7Vx/7o1wlPG3cEEk95BT5u15m3heLPmYQJ6EA
	fvhqJrlaFttcAZoRpGxn94YluzwD+bpmxJE1UNWP6q29IflVWjya/5x2GMP6NzzG+gHTTK
	I4Or5wkb44uuGpdpiF3+oSyUygvk3g8pMUXUhDiKU6UB4VK3MnjDX32vQiCUDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800242;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCtfbWYCL0AGtqzaHfkPt4CybVKvLNOiPpPAm/n3izE=;
	b=1BOQppH2hb2qp0HaPKfjFsoniAaj4n/wFfvb+g1cy+6jjVSMBEZTL+Nl2iobxTuY/G8X8k
	HJlTqhopT1mDlwBw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/smp: Use the SMP version of wake_up_new_task()
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-26-mingo@kernel.org>
References: <20250528080924.2273858-26-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980024133.406.8508634242183643887.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     588467616c88b12657f6ebe7306d830c272fe054
Gitweb:        https://git.kernel.org/tip/588467616c88b12657f6ebe7306d830c272fe054
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:06 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:19 +02:00

sched/smp: Use the SMP version of wake_up_new_task()

Simplify the scheduler by making CONFIG_SMP=y code in wake_up_new_task()
unconditional.

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
Link: https://lore.kernel.org/r/20250528080924.2273858-26-mingo@kernel.org
---
 kernel/sched/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 82b7cdb..c108b5c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4824,7 +4824,6 @@ void wake_up_new_task(struct task_struct *p)
 	activate_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_INITIAL);
 	trace_sched_wakeup_new(p);
 	wakeup_preempt(rq, p, wake_flags);
-#ifdef CONFIG_SMP
 	if (p->sched_class->task_woken) {
 		/*
 		 * Nothing relies on rq->lock after this, so it's fine to
@@ -4834,7 +4833,6 @@ void wake_up_new_task(struct task_struct *p)
 		p->sched_class->task_woken(rq, p);
 		rq_repin_lock(rq, &rf);
 	}
-#endif
 	task_rq_unlock(rq, p, &rf);
 }
 

