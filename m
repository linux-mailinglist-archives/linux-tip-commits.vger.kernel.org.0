Return-Path: <linux-tip-commits+bounces-5761-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FEBAD4FC3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 11:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2880189B20C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 09:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270FD262FE1;
	Wed, 11 Jun 2025 09:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H+5V8Yks";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nh74Q81I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA92262FD7;
	Wed, 11 Jun 2025 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634181; cv=none; b=MwvLFUqgadnlZcIDNwlh8JVyrqiTrIcOmBqg5eMTgxXYzYpds1y25wl7G3mHrUEaRvS3HJyy0ziV6kshJFKrsDseoO8yZdZy6ddmUrAdafJmY8JeLq/DXkj+Gsc9StZtwnUWjdThTjsOmbx9GFylCh/435YkvkGZZkRjwIijwEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634181; c=relaxed/simple;
	bh=nY2SNWxKtygfG0dt7LiFwRC+OEbye7OAAhI1/QRYjOo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=vF9WfrRCjCmuPjO/lWOfmTxJi18ASUZ/B+drDNfbd7RelW/WdFKU91L0cEn3+vLbGWwIOeZiZOoSq8/hbZCT+cT4J+SJqdBSHQKkWk5V/lk8w0Tn8BOH+T2mSHNPpsW8flwrL8CQa9mABiGdY3cHWwHyvlwzN4HSuevJTexjDbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H+5V8Yks; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nh74Q81I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 09:29:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749634174;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=miLVCWngfkvC3noSCnQHQL1s2LNieCC7q0lii4fg4X8=;
	b=H+5V8YksRhawJYs/u48v8kyi+Bht4uiBC6l+tZIXHtZUAaCyB1VMW7gfsh8Tdtkq9YJtPw
	DI0DVvSHJ7Iufy5ih9TS45Rw0V+urxDCq6hwenz67Tm7wB+T49EjpicJfgZqKJ9j22GF+i
	QlLZmypyXk8siG9D0WBFXHqI/iS+p+ZmUWsXtlevBgQ0QHpYxwL7OpeH3wGBqd9jvdrTq8
	EEEoiPYIBfZjZNRbWaawL8KLIAwi8S4bFhU0sWAdQ9b27tqqSwLkYi4AcWHo04UXy72RLn
	Fo8cYwITgwseWYUyXx5IEVbJch2MPmvZ8siyFdkdJXhdTUBE5qJ0gBh1BAzqNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749634174;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=miLVCWngfkvC3noSCnQHQL1s2LNieCC7q0lii4fg4X8=;
	b=Nh74Q81ItfRDWaH+6xKg2Lj/h+JTCtjXwpNLqi7n7DO99P2mWdK42v+Cd1c4S/VarNYHzH
	zuZewsJ+TePLPxDw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fix cgroup state vs ERROR
Cc: Leo Yan <leo.yan@arm.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250605123343.GD35970@noisy.programming.kicks-ass.net>
References: <20250605123343.GD35970@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174963417374.406.14127536923595306887.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     61988e36dc5457cdff7ae7927e8d9ad1419ee998
Gitweb:        https://git.kernel.org/tip/61988e36dc5457cdff7ae7927e8d9ad1419ee998
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 05 Jun 2025 12:37:11 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 05 Jun 2025 14:37:52 +02:00

perf: Fix cgroup state vs ERROR

While chasing down a missing perf_cgroup_event_disable() elsewhere,
Leo Yan found that both perf_put_aux_event() and
perf_remove_sibling_event() were also missing one.

Specifically, the rule is that events that switch to OFF,ERROR need to
call perf_cgroup_event_disable().

Unify the disable paths to ensure this.

Fixes: ab43762ef010 ("perf: Allow normal events to output AUX data")
Fixes: 9f0c4fa111dc ("perf/core: Add a new PERF_EV_CAP_SIBLING event capability")
Reported-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250605123343.GD35970@noisy.programming.kicks-ass.net
---
 kernel/events/core.c | 51 +++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 26dec1d..1cc98b9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2149,8 +2149,9 @@ perf_aux_output_match(struct perf_event *event, struct perf_event *aux_event)
 }
 
 static void put_event(struct perf_event *event);
-static void event_sched_out(struct perf_event *event,
-			    struct perf_event_context *ctx);
+static void __event_disable(struct perf_event *event,
+			    struct perf_event_context *ctx,
+			    enum perf_event_state state);
 
 static void perf_put_aux_event(struct perf_event *event)
 {
@@ -2183,8 +2184,7 @@ static void perf_put_aux_event(struct perf_event *event)
 		 * state so that we don't try to schedule it again. Note
 		 * that perf_event_enable() will clear the ERROR status.
 		 */
-		event_sched_out(iter, ctx);
-		perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
+		__event_disable(iter, ctx, PERF_EVENT_STATE_ERROR);
 	}
 }
 
@@ -2242,18 +2242,6 @@ static inline struct list_head *get_event_list(struct perf_event *event)
 				    &event->pmu_ctx->flexible_active;
 }
 
-/*
- * Events that have PERF_EV_CAP_SIBLING require being part of a group and
- * cannot exist on their own, schedule them out and move them into the ERROR
- * state. Also see _perf_event_enable(), it will not be able to recover
- * this ERROR state.
- */
-static inline void perf_remove_sibling_event(struct perf_event *event)
-{
-	event_sched_out(event, event->ctx);
-	perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
-}
-
 static void perf_group_detach(struct perf_event *event)
 {
 	struct perf_event *leader = event->group_leader;
@@ -2289,8 +2277,15 @@ static void perf_group_detach(struct perf_event *event)
 	 */
 	list_for_each_entry_safe(sibling, tmp, &event->sibling_list, sibling_list) {
 
+		/*
+		 * Events that have PERF_EV_CAP_SIBLING require being part of
+		 * a group and cannot exist on their own, schedule them out
+		 * and move them into the ERROR state. Also see
+		 * _perf_event_enable(), it will not be able to recover this
+		 * ERROR state.
+		 */
 		if (sibling->event_caps & PERF_EV_CAP_SIBLING)
-			perf_remove_sibling_event(sibling);
+			__event_disable(sibling, ctx, PERF_EVENT_STATE_ERROR);
 
 		sibling->group_leader = sibling;
 		list_del_init(&sibling->sibling_list);
@@ -2562,6 +2557,15 @@ static void perf_remove_from_context(struct perf_event *event, unsigned long fla
 	event_function_call(event, __perf_remove_from_context, (void *)flags);
 }
 
+static void __event_disable(struct perf_event *event,
+			    struct perf_event_context *ctx,
+			    enum perf_event_state state)
+{
+	event_sched_out(event, ctx);
+	perf_cgroup_event_disable(event, ctx);
+	perf_event_set_state(event, state);
+}
+
 /*
  * Cross CPU call to disable a performance event
  */
@@ -2576,13 +2580,18 @@ static void __perf_event_disable(struct perf_event *event,
 	perf_pmu_disable(event->pmu_ctx->pmu);
 	ctx_time_update_event(ctx, event);
 
+	/*
+	 * When disabling a group leader, the whole group becomes ineligible
+	 * to run, so schedule out the full group.
+	 */
 	if (event == event->group_leader)
 		group_sched_out(event, ctx);
-	else
-		event_sched_out(event, ctx);
 
-	perf_event_set_state(event, PERF_EVENT_STATE_OFF);
-	perf_cgroup_event_disable(event, ctx);
+	/*
+	 * But only mark the leader OFF; the siblings will remain
+	 * INACTIVE.
+	 */
+	__event_disable(event, ctx, PERF_EVENT_STATE_OFF);
 
 	perf_pmu_enable(event->pmu_ctx->pmu);
 }

