Return-Path: <linux-tip-commits+bounces-4756-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC418A81564
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F98A8A233F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718A0253328;
	Tue,  8 Apr 2025 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UXQWE/wZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iFXGwAVg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BA024502F;
	Tue,  8 Apr 2025 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139107; cv=none; b=Sk6DpSM2qRFUSHivmvj8LaYdYEPrCZFRu49zyVj3Z7j05DJwp75+tigF2mjhxMIi8fOPWBJET+wXC6SQ5TYb1+CoHGsrLH8yoNhBIR/xReG/Ort+8QtFJg+8TcBV9asa2aC+bHSxe9d4IQMLOF0kywyxCpgSpwv8k2ag/FlwCLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139107; c=relaxed/simple;
	bh=f/NH6PG4B1U/uU5au6qSRRJfGFNzBa5v0Frfnm1KSn8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tF8JU90eOXQzd1yjH0zdSEPQCkHpvlwPAlLnYB1RBNAMR41pzfxq1r07hGkqGIy08RIEW+6Nz3zKq5nIDSLAtRPTCW1inx08Jnq+VvvqixoCPwf/p2b1waArges7CxyIq9MW4UsIKX0Yi823qDBNr0Bug2ZqW+IQuhm6Y/NWyzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UXQWE/wZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iFXGwAVg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:05:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139103;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a2yRtr0lcbuWsQky97Dcqb8VM2ncby/AQb0WIeXAHaE=;
	b=UXQWE/wZ/o+H4IRk+FxDKJ/IDTHFlYhEmdT+gfQ/rVHDs1egs55ACaFyfVFRwkzFPuJdYL
	gP8Du4gFPEbu6WriYSyCYR9yoScd/Gv5lEitSV5u0XSWrIM57e0iXAsw+5RuWchzhOQlLL
	ANmORycmn1WgtgkJpZYOBpRPhZY9mMjR02tWK+U69twYdMfqvZrrp13Z2ns9Cmwi1YtRU2
	tQ6QL7vYFiy0HwWOcVpxdyG0jfqiCFwTn8s+qWGVGcwT+hePIQlj13NgtnNBrkgqc8l04g
	jihgBh/rkTUYarnYDbBlBzkImqeM38ATmEvS6/f31+VB2ukViREa7eMB+WxN6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139103;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a2yRtr0lcbuWsQky97Dcqb8VM2ncby/AQb0WIeXAHaE=;
	b=iFXGwAVggRrcfV6DYW/tBXztmSwQ8NYgO0JTOmxPHUWSv8mKGWNr47JVgXZ16Fpw+6rDak
	6F3ohWc9mT/7bbCw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Unify perf_event_free_task() /
 perf_event_exit_task_context()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250307193723.274039710@infradead.org>
References: <20250307193723.274039710@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413910259.31282.6563263873790654487.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     90661365021a6d0d7f3a2c5046ebe33e4df53b92
Gitweb:        https://git.kernel.org/tip/90661365021a6d0d7f3a2c5046ebe33e4df53b92
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 13 Feb 2025 14:04:07 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:47 +02:00

perf: Unify perf_event_free_task() / perf_event_exit_task_context()

Both perf_event_free_task() and perf_event_exit_task_context() are
very similar, except perf_event_exit_task_context() is a little more
generic / makes less assumptions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lkml.kernel.org/r/20250307193723.274039710@infradead.org
---
 kernel/events/core.c | 93 +++++++++++--------------------------------
 1 file changed, 25 insertions(+), 68 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f75b0d3..85c8b79 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13742,13 +13742,11 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 	perf_event_wakeup(event);
 }
 
-static void perf_event_exit_task_context(struct task_struct *child)
+static void perf_event_exit_task_context(struct task_struct *child, bool exit)
 {
 	struct perf_event_context *child_ctx, *clone_ctx = NULL;
 	struct perf_event *child_event, *next;
 
-	WARN_ON_ONCE(child != current);
-
 	child_ctx = perf_pin_task_context(child);
 	if (!child_ctx)
 		return;
@@ -13771,7 +13769,8 @@ static void perf_event_exit_task_context(struct task_struct *child)
 	 * in.
 	 */
 	raw_spin_lock_irq(&child_ctx->lock);
-	task_ctx_sched_out(child_ctx, NULL, EVENT_ALL);
+	if (exit)
+		task_ctx_sched_out(child_ctx, NULL, EVENT_ALL);
 
 	/*
 	 * Now that the context is inactive, destroy the task <-> ctx relation
@@ -13780,7 +13779,7 @@ static void perf_event_exit_task_context(struct task_struct *child)
 	RCU_INIT_POINTER(child->perf_event_ctxp, NULL);
 	put_ctx(child_ctx); /* cannot be last */
 	WRITE_ONCE(child_ctx->task, TASK_TOMBSTONE);
-	put_task_struct(current); /* cannot be last */
+	put_task_struct(child); /* cannot be last */
 
 	clone_ctx = unclone_ctx(child_ctx);
 	raw_spin_unlock_irq(&child_ctx->lock);
@@ -13793,13 +13792,31 @@ static void perf_event_exit_task_context(struct task_struct *child)
 	 * won't get any samples after PERF_RECORD_EXIT. We can however still
 	 * get a few PERF_RECORD_READ events.
 	 */
-	perf_event_task(child, child_ctx, 0);
+	if (exit)
+		perf_event_task(child, child_ctx, 0);
 
 	list_for_each_entry_safe(child_event, next, &child_ctx->event_list, event_entry)
 		perf_event_exit_event(child_event, child_ctx);
 
 	mutex_unlock(&child_ctx->mutex);
 
+	if (!exit) {
+		/*
+		 * perf_event_release_kernel() could still have a reference on
+		 * this context. In that case we must wait for these events to
+		 * have been freed (in particular all their references to this
+		 * task must've been dropped).
+		 *
+		 * Without this copy_process() will unconditionally free this
+		 * task (irrespective of its reference count) and
+		 * _free_event()'s put_task_struct(event->hw.target) will be a
+		 * use-after-free.
+		 *
+		 * Wait for all events to drop their context reference.
+		 */
+		wait_var_event(&child_ctx->refcount,
+			       refcount_read(&child_ctx->refcount) == 1);
+	}
 	put_ctx(child_ctx);
 }
 
@@ -13827,7 +13844,7 @@ void perf_event_exit_task(struct task_struct *child)
 	}
 	mutex_unlock(&child->perf_event_mutex);
 
-	perf_event_exit_task_context(child);
+	perf_event_exit_task_context(child, true);
 
 	/*
 	 * The perf_event_exit_task_context calls perf_event_task
@@ -13844,25 +13861,6 @@ void perf_event_exit_task(struct task_struct *child)
 	detach_task_ctx_data(child);
 }
 
-static void perf_free_event(struct perf_event *event,
-			    struct perf_event_context *ctx)
-{
-	struct perf_event *parent = event->parent;
-
-	if (WARN_ON_ONCE(!parent))
-		return;
-
-	mutex_lock(&parent->child_mutex);
-	list_del_init(&event->child_list);
-	mutex_unlock(&parent->child_mutex);
-
-	raw_spin_lock_irq(&ctx->lock);
-	perf_group_detach(event);
-	list_del_event(event, ctx);
-	raw_spin_unlock_irq(&ctx->lock);
-	put_event(event);
-}
-
 /*
  * Free a context as created by inheritance by perf_event_init_task() below,
  * used by fork() in case of fail.
@@ -13872,48 +13870,7 @@ static void perf_free_event(struct perf_event *event,
  */
 void perf_event_free_task(struct task_struct *task)
 {
-	struct perf_event_context *ctx;
-	struct perf_event *event, *tmp;
-
-	ctx = rcu_access_pointer(task->perf_event_ctxp);
-	if (!ctx)
-		return;
-
-	mutex_lock(&ctx->mutex);
-	raw_spin_lock_irq(&ctx->lock);
-	/*
-	 * Destroy the task <-> ctx relation and mark the context dead.
-	 *
-	 * This is important because even though the task hasn't been
-	 * exposed yet the context has been (through child_list).
-	 */
-	RCU_INIT_POINTER(task->perf_event_ctxp, NULL);
-	WRITE_ONCE(ctx->task, TASK_TOMBSTONE);
-	put_task_struct(task); /* cannot be last */
-	raw_spin_unlock_irq(&ctx->lock);
-
-
-	list_for_each_entry_safe(event, tmp, &ctx->event_list, event_entry)
-		perf_free_event(event, ctx);
-
-	mutex_unlock(&ctx->mutex);
-
-	/*
-	 * perf_event_release_kernel() could've stolen some of our
-	 * child events and still have them on its free_list. In that
-	 * case we must wait for these events to have been freed (in
-	 * particular all their references to this task must've been
-	 * dropped).
-	 *
-	 * Without this copy_process() will unconditionally free this
-	 * task (irrespective of its reference count) and
-	 * _free_event()'s put_task_struct(event->hw.target) will be a
-	 * use-after-free.
-	 *
-	 * Wait for all events to drop their context reference.
-	 */
-	wait_var_event(&ctx->refcount, refcount_read(&ctx->refcount) == 1);
-	put_ctx(ctx); /* must be last */
+	perf_event_exit_task_context(task, false);
 }
 
 void perf_event_delayed_put(struct task_struct *task)

