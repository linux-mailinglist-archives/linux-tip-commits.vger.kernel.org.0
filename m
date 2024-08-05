Return-Path: <linux-tip-commits+bounces-1942-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2AC947AC3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 13:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C3C1F22296
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 11:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810D1158DA2;
	Mon,  5 Aug 2024 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nJLqfq+E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="23AsTLiX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3E5158215;
	Mon,  5 Aug 2024 11:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722858971; cv=none; b=lW6SxKWd9NRdZOMEAK6lt7UbuLc3qWZGAJQI7+nK6+TwUW9q/FJqUzu24Dlazj/VCrFBBwV9MSDOAHwmCwWWzb8tuTagwnoWGeXxsGbXEBypBNQ1Di8uxjbzd3sxKAWp8h1zaSifP2mA6sd8z4cpL8wRI5h1N0aXBnnEJrVtlvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722858971; c=relaxed/simple;
	bh=RGaEpZxJxL1exIGT0wG/uUlrLIh6LWOUz9IJCBC11oU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AjJEgq59Fa8raQP+iJz1+SRHTSGgd5OwScCPvNE+IcWG13VAi0PmNnCkbO1j9K2vqFyQtKGx9vTfhDolLo/B+sYDigObtnffgMaDz/wcEzecXB7ow+GZVpfN1+0D+PeKb1GFR91v8ScIKmcH1Oomtk8Jcm959f4rKMwdl3gx/eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nJLqfq+E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=23AsTLiX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Aug 2024 11:56:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722858967;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s/wLMIXa/rHlxLYxaS72PBzuTjUgNiX/UH/jLJx8RUw=;
	b=nJLqfq+ELXM+DS4aDc1zZdN/6PQPguXcE5G5nKD1cgSTmXAjkz8VYtA7UIUABft9EcWlKI
	qVJZi09EYlsDfyva78HofiWXLRXJkubojfnBcr2FbnbKzub6wpWA7wi1pmVN2F5SxEKtEN
	fl5VxVoT2xG8SQHn5aA8Z4IAWtDYE5iuNy9lpEbS4JsHmBfAUTtWPtmbgE+oBKFrlI50oK
	EnCxYpX67w0kYEfC9ixXZeP8Lw/EsGqjavgllrItKAk0h6RHpsEtdu6M/mpw5lHa4IbMOm
	qmle1oAcNg2aoTEbl+GPVtYD4tNWyAr4NROxk7hXB+2IxA4k25Iuc9H82LildA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722858967;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s/wLMIXa/rHlxLYxaS72PBzuTjUgNiX/UH/jLJx8RUw=;
	b=23AsTLiXJxis8JEeHWSay+UJ/dMDWC8gGQ7N5H2hNy/bUn4AvTgncLQecqu7h/+oaSczx0
	xMsqxp6zCEN6zdBg==
From: "tip-bot2 for Ben Gainey" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Rename perf_event_context.nr_pending to
 nr_no_switch_fast.
Cc: Ben Gainey <ben.gainey@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240730084417.7693-2-ben.gainey@arm.com>
References: <20240730084417.7693-2-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172285896737.2215.12921253387415190633.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     79bd233010859463e46a0a4b3926eaaba25a6110
Gitweb:        https://git.kernel.org/tip/79bd233010859463e46a0a4b3926eaaba25a6110
Author:        Ben Gainey <ben.gainey@arm.com>
AuthorDate:    Tue, 30 Jul 2024 09:44:14 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Aug 2024 11:30:29 +02:00

perf: Rename perf_event_context.nr_pending to nr_no_switch_fast.

nr_pending counts the number of events in the context that
either pending_sigtrap or pending_work, but it is used
to prevent taking the fast path in perf_event_context_sched_out.

Renamed to reflect what it is used for, rather than what it
counts. This change allows using the field to track other
event properties that also require skipping the fast path
without possible confusion over the name.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20240730084417.7693-2-ben.gainey@arm.com
---
 include/linux/perf_event.h |  5 +++--
 kernel/events/core.c       | 12 ++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 6bb0c21..655f66b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -966,12 +966,13 @@ struct perf_event_context {
 	struct rcu_head			rcu_head;
 
 	/*
-	 * Sum (event->pending_work + event->pending_work)
+	 * The count of events for which using the switch-out fast path
+	 * should be avoided.
 	 *
 	 * The SIGTRAP is targeted at ctx->task, as such it won't do changing
 	 * that until the signal is delivered.
 	 */
-	local_t				nr_pending;
+	local_t				nr_no_switch_fast;
 };
 
 struct perf_cpu_pmu_context {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index aa3450b..e6cc354 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3516,9 +3516,9 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 
 			perf_ctx_disable(ctx, false);
 
-			/* PMIs are disabled; ctx->nr_pending is stable. */
-			if (local_read(&ctx->nr_pending) ||
-			    local_read(&next_ctx->nr_pending)) {
+			/* PMIs are disabled; ctx->nr_no_switch_fast is stable. */
+			if (local_read(&ctx->nr_no_switch_fast) ||
+			    local_read(&next_ctx->nr_no_switch_fast)) {
 				/*
 				 * Must not swap out ctx when there's pending
 				 * events that rely on the ctx->task relation.
@@ -5204,7 +5204,7 @@ static void perf_pending_task_sync(struct perf_event *event)
 	 */
 	if (task_work_cancel(current, head)) {
 		event->pending_work = 0;
-		local_dec(&event->ctx->nr_pending);
+		local_dec(&event->ctx->nr_no_switch_fast);
 		return;
 	}
 
@@ -6868,7 +6868,7 @@ static void perf_pending_task(struct callback_head *head)
 	if (event->pending_work) {
 		event->pending_work = 0;
 		perf_sigtrap(event);
-		local_dec(&event->ctx->nr_pending);
+		local_dec(&event->ctx->nr_no_switch_fast);
 		rcuwait_wake_up(&event->pending_work_wait);
 	}
 	rcu_read_unlock();
@@ -9740,7 +9740,7 @@ static int __perf_event_overflow(struct perf_event *event,
 		if (!event->pending_work &&
 		    !task_work_add(current, &event->pending_task, notify_mode)) {
 			event->pending_work = pending_id;
-			local_inc(&event->ctx->nr_pending);
+			local_inc(&event->ctx->nr_no_switch_fast);
 
 			event->pending_addr = 0;
 			if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))

