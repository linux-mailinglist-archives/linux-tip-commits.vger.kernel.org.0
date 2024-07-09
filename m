Return-Path: <linux-tip-commits+bounces-1639-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF49E92B893
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Jul 2024 13:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6AA3282BE3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Jul 2024 11:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E8F158DC3;
	Tue,  9 Jul 2024 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4VPMXvty";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oSo/Hdh0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ECD1586C6;
	Tue,  9 Jul 2024 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525320; cv=none; b=HhtfrBfKtOmNCsjwO6WkYwflAS/YCj5ipWfUCekkQjfr/WWUQnLqbry/crtIcX9e2MhYBZIaZlVRCVEsM7+eCqr8wjUFkkl0+V2ZJ6NNq9EvASTblWBKP56mYXSMvNkjht132K5kIfQ+ZUC5a1GMi7vLvPgH1XGJPUisfuBdukI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525320; c=relaxed/simple;
	bh=yILCmpJXsGW6+r9ZCS+ViRoVPwrTPPyH+86Y9+vW5rA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SkdCmI3x5idaVN96ygc5D7/EJK3GEXD2SGlK8c+v7Dj5bEVcWU4ZXdazgOQkr1ouzgr+3XwVozLjrYe9U1lUKYMaYiQL4oCfwKOyM2t3H6WUVmt0P9SIP/CjElFj0kFQzcItNtcq5+03g4+dQZBGolKYjg6fbfNFiJk701tpPXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4VPMXvty; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oSo/Hdh0; arc=none smtp.client-ip=193.142.43.55
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
	bh=L8vwutyRBqb0D9ckGJr7K7IT2W0U79UePFTqtTwo3Y4=;
	b=4VPMXvty8q8HtzjRUTjtvoiwwWKit6ULqvJkkh/T7GgVsS3s9X4yNHgjNR/tqebXIPZ8qx
	KSljENdqBrMVrhJ56BjhdXX8yg8zUgXqpa804OuOpIeMkLZ0OdHuUUGAvAvR2hrPofTDKe
	qrte/gGMZwiK27PYqHEEOboO55FvZWdkWogy3YpD4MdtArJo2l5SFrP0KaGWr4ViVWh2Gd
	pchBozEwr7OsveCHXiZkYWi8vDAmabkdM5iJFa6CpR2yVM5KSQ4PXOO+0DQneLpP8ng6th
	qIxUava06dT8dsT7Pwaz028cWbEAzFc8p+UFBieeiu7W0LbeQXDqMi9LAiUk+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720525317;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L8vwutyRBqb0D9ckGJr7K7IT2W0U79UePFTqtTwo3Y4=;
	b=oSo/Hdh0o7/xZY2hjESfGh8AQ8HVETF2n1+y475KFYvvzr49arpZLE8G30CqXLjMUUa1C8
	LT9jkCmIDBwmVuAw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf: Split __perf_pending_irq() out of perf_pending_irq()
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Marco Elver <elver@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240704170424.1466941-8-bigeasy@linutronix.de>
References: <20240704170424.1466941-8-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172052531713.2215.12959971034104257463.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2b84def990d388bed4afe4f21ae383a01991046c
Gitweb:        https://git.kernel.org/tip/2b84def990d388bed4afe4f21ae383a01991046c
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 04 Jul 2024 19:03:41 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 09 Jul 2024 13:26:37 +02:00

perf: Split __perf_pending_irq() out of perf_pending_irq()

perf_pending_irq() invokes perf_event_wakeup() and __perf_pending_irq().
The former is in charge of waking any tasks which waits to be woken up
while the latter disables perf-events.

The irq_work perf_pending_irq(), while this an irq_work, the callback
is invoked in thread context on PREEMPT_RT. This is needed because all
the waking functions (wake_up_all(), kill_fasync()) acquire sleep locks
which must not be used with disabled interrupts.
Disabling events, as done by __perf_pending_irq(), expects a hardirq
context and disabled interrupts. This requirement is not fulfilled on
PREEMPT_RT.

Split functionality based on perf_event::pending_disable into irq_work
named `pending_disable_irq' and invoke it in hardirq context on
PREEMPT_RT. Rename the split out callback to perf_pending_disable().

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Marco Elver <elver@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: https://lore.kernel.org/r/20240704170424.1466941-8-bigeasy@linutronix.de
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 29 ++++++++++++++++++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 99a7ea1..65ece0d 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -783,6 +783,7 @@ struct perf_event {
 	unsigned int			pending_disable;
 	unsigned long			pending_addr;	/* SIGTRAP */
 	struct irq_work			pending_irq;
+	struct irq_work			pending_disable_irq;
 	struct callback_head		pending_task;
 	unsigned int			pending_work;
 	struct rcuwait			pending_work_wait;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 96e03d6..f64c30e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2451,7 +2451,7 @@ static void __perf_event_disable(struct perf_event *event,
  * hold the top-level event's child_mutex, so any descendant that
  * goes to exit will block in perf_event_exit_event().
  *
- * When called from perf_pending_irq it's OK because event->ctx
+ * When called from perf_pending_disable it's OK because event->ctx
  * is the current context on this CPU and preemption is disabled,
  * hence we can't get into perf_event_task_sched_out for this context.
  */
@@ -2491,7 +2491,7 @@ EXPORT_SYMBOL_GPL(perf_event_disable);
 void perf_event_disable_inatomic(struct perf_event *event)
 {
 	event->pending_disable = 1;
-	irq_work_queue(&event->pending_irq);
+	irq_work_queue(&event->pending_disable_irq);
 }
 
 #define MAX_INTERRUPTS (~0ULL)
@@ -5218,6 +5218,7 @@ static void perf_pending_task_sync(struct perf_event *event)
 static void _free_event(struct perf_event *event)
 {
 	irq_work_sync(&event->pending_irq);
+	irq_work_sync(&event->pending_disable_irq);
 	perf_pending_task_sync(event);
 
 	unaccount_event(event);
@@ -6749,7 +6750,7 @@ static void perf_sigtrap(struct perf_event *event)
 /*
  * Deliver the pending work in-event-context or follow the context.
  */
-static void __perf_pending_irq(struct perf_event *event)
+static void __perf_pending_disable(struct perf_event *event)
 {
 	int cpu = READ_ONCE(event->oncpu);
 
@@ -6787,11 +6788,26 @@ static void __perf_pending_irq(struct perf_event *event)
 	 *				  irq_work_queue(); // FAILS
 	 *
 	 *  irq_work_run()
-	 *    perf_pending_irq()
+	 *    perf_pending_disable()
 	 *
 	 * But the event runs on CPU-B and wants disabling there.
 	 */
-	irq_work_queue_on(&event->pending_irq, cpu);
+	irq_work_queue_on(&event->pending_disable_irq, cpu);
+}
+
+static void perf_pending_disable(struct irq_work *entry)
+{
+	struct perf_event *event = container_of(entry, struct perf_event, pending_disable_irq);
+	int rctx;
+
+	/*
+	 * If we 'fail' here, that's OK, it means recursion is already disabled
+	 * and we won't recurse 'further'.
+	 */
+	rctx = perf_swevent_get_recursion_context();
+	__perf_pending_disable(event);
+	if (rctx >= 0)
+		perf_swevent_put_recursion_context(rctx);
 }
 
 static void perf_pending_irq(struct irq_work *entry)
@@ -6814,8 +6830,6 @@ static void perf_pending_irq(struct irq_work *entry)
 		perf_event_wakeup(event);
 	}
 
-	__perf_pending_irq(event);
-
 	if (rctx >= 0)
 		perf_swevent_put_recursion_context(rctx);
 }
@@ -11956,6 +11970,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 
 	init_waitqueue_head(&event->waitq);
 	init_irq_work(&event->pending_irq, perf_pending_irq);
+	event->pending_disable_irq = IRQ_WORK_INIT_HARD(perf_pending_disable);
 	init_task_work(&event->pending_task, perf_pending_task);
 	rcuwait_init(&event->pending_work_wait);
 

