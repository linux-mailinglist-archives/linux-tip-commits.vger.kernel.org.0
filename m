Return-Path: <linux-tip-commits+bounces-1643-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA16092B899
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Jul 2024 13:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ADDBB21C2C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Jul 2024 11:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E101D15DBA5;
	Tue,  9 Jul 2024 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KQodvzlp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PS4WLmfJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1978158DB5;
	Tue,  9 Jul 2024 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525322; cv=none; b=gaXG/OIgyYD3htpTsIVqKBOzK5E7UIrU3GeDnLImbA8cCbcdkIQM+h/JxgsvAgv2s9NVy55yYGdtch4M4dkq4c8aT4VlZLu1mrc3xurgZtCoqHSqVLuFDEofBMg/mf72fRsnTO2e2LnN59pTgWMDLCQ4Lit4V5P2JQiRIEKbMoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525322; c=relaxed/simple;
	bh=6faKOUuOmGntL58qGLOzPtZspRW8YMaLRhxS1zfsQuA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XYyy/325xS9Yb0H+XRtiouSMG5MS7gAPtcbhL/t7iivPnm9khOT11avIOfuCy1yFv/ujJ0w8uEG7IGB8vl3SDvoIrN7vsmnSOs297NqnInOHopcqwrDg7zoxhUJIMAFfmbDEUAKOTpEHYHcZIH9BSe0zJKyjQVALlYqnfrPPE/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KQodvzlp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PS4WLmfJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Jul 2024 11:41:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720525319;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wVPjdOlW4UEwe6vHNRiDkQ1yBKVNm7iNTPdgCbZjHy0=;
	b=KQodvzlpz1bxNt9o5DBegDYAztsNlAANkLgwchQ2eSG86fARL+tpRQcC68/cMAMWuxQIIo
	fVqmNzV9NJVM5ROvjJjUV1MhJ9mMCoVtqG5SWX1E41DpTiQEfAHHz6zg1Sk9T3fWfrs01Y
	drqfRAS0yBrc7Tj5KbDLbOKLvSXi54p9zivC/rKdGFW3fpQxk70hL19zoTBE7WVx3BOaRy
	e0854EyHgUJQze+wU6nSlLNViNrZjl45uG0PLidxupL1My1WEnKAf1yeon/jzOb8nHOk8i
	08DtGLOdm2IL5BZ3Jcm53QKtxlf96GEVXxAZPXgKbrph4Tcobw0AdZu3a3eLxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720525319;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wVPjdOlW4UEwe6vHNRiDkQ1yBKVNm7iNTPdgCbZjHy0=;
	b=PS4WLmfJ6AG6A0E+ED9RJQUaaODGAYIn2nL57T5eGCw4BUPUHelSVsa7z6r453IMccQcPx
	SIBEag0ImEFB5LCg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Enqueue SIGTRAP always via task_work.
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Marco Elver <elver@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240704170424.1466941-4-bigeasy@linutronix.de>
References: <20240704170424.1466941-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172052531870.2215.17111276846949614228.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c5d93d23a26012a98b77f9e354ab9b3afd420059
Gitweb:        https://git.kernel.org/tip/c5d93d23a26012a98b77f9e354ab9b3afd420059
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 04 Jul 2024 19:03:37 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 09 Jul 2024 13:26:35 +02:00

perf: Enqueue SIGTRAP always via task_work.

A signal is delivered by raising irq_work() which works from any context
including NMI. irq_work() can be delayed if the architecture does not
provide an interrupt vector. In order not to lose a signal, the signal
is injected via task_work during event_sched_out().

Instead going via irq_work, the signal could be added directly via
task_work. The signal is sent to current and can be enqueued on its
return path to userland.

Queue signal via task_work and consider possible NMI context. Remove
perf_event::pending_sigtrap and and use perf_event::pending_work
instead.

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Marco Elver <elver@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: https://lore.kernel.org/r/20240704170424.1466941-4-bigeasy@linutronix.de
---
 include/linux/perf_event.h |  3 +--
 kernel/events/core.c       | 31 ++++++++++---------------------
 2 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 393fb13..ea0d824 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -781,7 +781,6 @@ struct perf_event {
 	unsigned int			pending_wakeup;
 	unsigned int			pending_kill;
 	unsigned int			pending_disable;
-	unsigned int			pending_sigtrap;
 	unsigned long			pending_addr;	/* SIGTRAP */
 	struct irq_work			pending_irq;
 	struct callback_head		pending_task;
@@ -963,7 +962,7 @@ struct perf_event_context {
 	struct rcu_head			rcu_head;
 
 	/*
-	 * Sum (event->pending_sigtrap + event->pending_work)
+	 * Sum (event->pending_work + event->pending_work)
 	 *
 	 * The SIGTRAP is targeted at ctx->task, as such it won't do changing
 	 * that until the signal is delivered.
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c54da50..73e1b02 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2283,17 +2283,6 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 		state = PERF_EVENT_STATE_OFF;
 	}
 
-	if (event->pending_sigtrap) {
-		event->pending_sigtrap = 0;
-		if (state != PERF_EVENT_STATE_OFF &&
-		    !event->pending_work &&
-		    !task_work_add(current, &event->pending_task, TWA_RESUME)) {
-			event->pending_work = 1;
-		} else {
-			local_dec(&event->ctx->nr_pending);
-		}
-	}
-
 	perf_event_set_state(event, state);
 
 	if (!is_software_event(event))
@@ -6776,11 +6765,6 @@ static void __perf_pending_irq(struct perf_event *event)
 	 * Yay, we hit home and are in the context of the event.
 	 */
 	if (cpu == smp_processor_id()) {
-		if (event->pending_sigtrap) {
-			event->pending_sigtrap = 0;
-			perf_sigtrap(event);
-			local_dec(&event->ctx->nr_pending);
-		}
 		if (event->pending_disable) {
 			event->pending_disable = 0;
 			perf_event_disable_local(event);
@@ -9721,21 +9705,26 @@ static int __perf_event_overflow(struct perf_event *event,
 		 */
 		bool valid_sample = sample_is_allowed(event, regs);
 		unsigned int pending_id = 1;
+		enum task_work_notify_mode notify_mode;
 
 		if (regs)
 			pending_id = hash32_ptr((void *)instruction_pointer(regs)) ?: 1;
-		if (!event->pending_sigtrap) {
-			event->pending_sigtrap = pending_id;
+
+		notify_mode = in_nmi() ? TWA_NMI_CURRENT : TWA_RESUME;
+
+		if (!event->pending_work &&
+		    !task_work_add(current, &event->pending_task, notify_mode)) {
+			event->pending_work = pending_id;
 			local_inc(&event->ctx->nr_pending);
 
 			event->pending_addr = 0;
 			if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
 				event->pending_addr = data->addr;
-			irq_work_queue(&event->pending_irq);
+
 		} else if (event->attr.exclude_kernel && valid_sample) {
 			/*
 			 * Should not be able to return to user space without
-			 * consuming pending_sigtrap; with exceptions:
+			 * consuming pending_work; with exceptions:
 			 *
 			 *  1. Where !exclude_kernel, events can overflow again
 			 *     in the kernel without returning to user space.
@@ -9745,7 +9734,7 @@ static int __perf_event_overflow(struct perf_event *event,
 			 *     To approximate progress (with false negatives),
 			 *     check 32-bit hash of the current IP.
 			 */
-			WARN_ON_ONCE(event->pending_sigtrap != pending_id);
+			WARN_ON_ONCE(event->pending_work != pending_id);
 		}
 	}
 

