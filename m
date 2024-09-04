Return-Path: <linux-tip-commits+bounces-2159-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B2F96B7E1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Sep 2024 12:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9A16B2321F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Sep 2024 10:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFA01CF7A8;
	Wed,  4 Sep 2024 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GPxaxT8+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x/ynGLZl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC1F1CF7A3;
	Wed,  4 Sep 2024 10:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444496; cv=none; b=Bu6aoaAFxZ5cbJ1SUTBBHtTHHcQmY4vKIq6pLsp+eOKpt9xksX8K8C6ixSwAoaU4py1E1wVQWlbtALOWUjE2CBHkH8WnyovDP/ZdtjTsuNHgBlEuocFdPjG8e6Mk/rgLcFwqx0DupxlqHrVAnv2YR8CwWtiSo73YPLeDUmILYOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444496; c=relaxed/simple;
	bh=e1BZ8sr8PBs/oSF5RBAjsfcaORsEM2/ZHWJLHgSCRvM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a/MkAZckIgBeeyJOOTRRrjd8prNHf+XEvgx80kE4YgRzbV1PyZnxZYgyARJZE4zZ6kwVS+zew82ZwEXehlk4+RJUPx8s1SoCUOgXrrIlXR9x3SKROje2GpYG9vB49vo+blozLJmxXtKeb/jhe+D/K3C8H2W3D6fatCvCqvDW2sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GPxaxT8+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x/ynGLZl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Sep 2024 10:08:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725444492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5yGt24uZ+HrO8WzcOCxRh674oX16xpXaDeqrslQLnm8=;
	b=GPxaxT8+Z3Gy3EKSSCxetRk2j18/Rrfryb+8NZ5OtJBZxd4jwXH9EYlw2CHYWDz76SAu5A
	VdvtfaZkIh7fGLAGz98eprWcKKqk2lHJVFGDMC2A26nJ0obahinJ/p5GBFJuZU+uw/ExdJ
	XAGzRURx5J93vBxbEfPbQBdHmhN1Kxg8Ams2wJdc7ku6poTQnJAIIKwFw094j/nqWvKtS8
	SlqCSbPm4TiSs4dCfUTvJPX1ls4PVPAl3tOtUMq/FpEaktjslNrwOI2//Y1og8fQ35rJMp
	LIeYtPW3lCKMu8WIhu+uP5C4HQ+v4sSVLGgXk208JKQmHd6RtqQL1WriJHx/ZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725444492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5yGt24uZ+HrO8WzcOCxRh674oX16xpXaDeqrslQLnm8=;
	b=x/ynGLZltdd2GwcQsQesxFef+fgKb36Zly+a14oGeD9VZBDA6Vc4GPjJtbhtzDJdGLWSWI
	FruuPHL9w3MYBBCw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Annotate possible non critical data race
 of next_expiry
Cc: syzbot+bf285fcc0a048e028118@syzkaller.appspotmail.com,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240829154305.19259-1-anna-maria@linutronix.de>
References: <20240829154305.19259-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172544449178.2215.12442072639516002840.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     79f8b28e85f83563c86f528b91eff19c0c4d1177
Gitweb:        https://git.kernel.org/tip/79f8b28e85f83563c86f528b91eff19c0c4d1177
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Thu, 29 Aug 2024 17:43:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 04 Sep 2024 11:57:56 +02:00

timers: Annotate possible non critical data race of next_expiry

Global timers could be expired remotely when the target CPU is idle. After
a remote timer expiry, the remote timer_base->next_expiry value is updated
while holding the timer_base->lock. When the formerly idle CPU becomes
active at the same time and checks whether timers need to expire, this
check is done lockless as it is on the local CPU. This could lead to a data
race, which was reported by sysbot:

  https://lore.kernel.org/r/000000000000916e55061f969e14@google.com

When the value is read lockless but changed by the remote CPU, only two non
critical scenarios could happen:

1) The already update value is read -> everything is perfect

2) The old value is read -> a superfluous timer soft interrupt is raised

The same situation could happen when enqueueing a new first pinned timer by
a remote CPU also with non critical scenarios:

1) The already update value is read -> everything is perfect

2) The old value is read -> when the CPU is idle, an IPI is executed
nevertheless and when the CPU isn't idle, the updated value will be visible
on the next tick and the timer might be late one jiffie.

As this is very unlikely to happen, the overhead of doing the check under
the lock is a way more effort, than a superfluous timer soft interrupt or a
possible 1 jiffie delay of the timer.

Document and annotate this non critical behavior in the code by using
READ/WRITE_ONCE() pair when accessing timer_base->next_expiry.

Reported-by: syzbot+bf285fcc0a048e028118@syzkaller.appspotmail.com
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20240829154305.19259-1-anna-maria@linutronix.de
Closes: https://lore.kernel.org/lkml/000000000000916e55061f969e14@google.com
---
 kernel/time/timer.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index d8eb368..311ea45 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -672,7 +672,7 @@ static void enqueue_timer(struct timer_base *base, struct timer_list *timer,
 		 * Set the next expiry time and kick the CPU so it
 		 * can reevaluate the wheel:
 		 */
-		base->next_expiry = bucket_expiry;
+		WRITE_ONCE(base->next_expiry, bucket_expiry);
 		base->timers_pending = true;
 		base->next_expiry_recalc = false;
 		trigger_dyntick_cpu(base, timer);
@@ -1966,7 +1966,7 @@ static void next_expiry_recalc(struct timer_base *base)
 		clk += adj;
 	}
 
-	base->next_expiry = next;
+	WRITE_ONCE(base->next_expiry, next);
 	base->next_expiry_recalc = false;
 	base->timers_pending = !(next == base->clk + NEXT_TIMER_MAX_DELTA);
 }
@@ -2020,7 +2020,7 @@ static unsigned long next_timer_interrupt(struct timer_base *base,
 	 * easy comparable to find out which base holds the first pending timer.
 	 */
 	if (!base->timers_pending)
-		base->next_expiry = basej + NEXT_TIMER_MAX_DELTA;
+		WRITE_ONCE(base->next_expiry, basej + NEXT_TIMER_MAX_DELTA);
 
 	return base->next_expiry;
 }
@@ -2464,8 +2464,40 @@ static void run_local_timers(void)
 	hrtimer_run_queues();
 
 	for (int i = 0; i < NR_BASES; i++, base++) {
-		/* Raise the softirq only if required. */
-		if (time_after_eq(jiffies, base->next_expiry) ||
+		/*
+		 * Raise the softirq only if required.
+		 *
+		 * timer_base::next_expiry can be written by a remote CPU while
+		 * holding the lock. If this write happens at the same time than
+		 * the lockless local read, sanity checker could complain about
+		 * data corruption.
+		 *
+		 * There are two possible situations where
+		 * timer_base::next_expiry is written by a remote CPU:
+		 *
+		 * 1. Remote CPU expires global timers of this CPU and updates
+		 * timer_base::next_expiry of BASE_GLOBAL afterwards in
+		 * next_timer_interrupt() or timer_recalc_next_expiry(). The
+		 * worst outcome is a superfluous raise of the timer softirq
+		 * when the not yet updated value is read.
+		 *
+		 * 2. A new first pinned timer is enqueued by a remote CPU
+		 * and therefore timer_base::next_expiry of BASE_LOCAL is
+		 * updated. When this update is missed, this isn't a
+		 * problem, as an IPI is executed nevertheless when the CPU
+		 * was idle before. When the CPU wasn't idle but the update
+		 * is missed, then the timer would expire one jiffie late -
+		 * bad luck.
+		 *
+		 * Those unlikely corner cases where the worst outcome is only a
+		 * one jiffie delay or a superfluous raise of the softirq are
+		 * not that expensive as doing the check always while holding
+		 * the lock.
+		 *
+		 * Possible remote writers are using WRITE_ONCE(). Local reader
+		 * uses therefore READ_ONCE().
+		 */
+		if (time_after_eq(jiffies, READ_ONCE(base->next_expiry)) ||
 		    (i == BASE_DEF && tmigr_requires_handle_remote())) {
 			raise_softirq(TIMER_SOFTIRQ);
 			return;

