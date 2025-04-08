Return-Path: <linux-tip-commits+bounces-4753-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1A3A8155E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0CB4467700
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366E024CEE2;
	Tue,  8 Apr 2025 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s64nWPtg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NlXd84oz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0588C244EAB;
	Tue,  8 Apr 2025 19:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139106; cv=none; b=C43/SwAeA/vR9b/9QJW1NCY6Y3w5I28SulbDKGw/QNMqjfnA8SNdFrAAwjyTk/c7KIboCxfZP4qMFfEMRnixlqbWu4E2uQsjhMAVeDvIgEihgt8sDHQJ9ukzgZCoiYFfVDFosFaluJPMM2qw2FlixxQ/l9kuyhmAL1iUMRyWYs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139106; c=relaxed/simple;
	bh=JRhNMd7xTxqboMD0FX/Ihyk/W+msvNQQTYpMLGvBT1Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tm0wuaEvj22xhsXUZ352sQeRswRWNau3WRnfeaa38BOJuFAfpnXDoRjVfUWHUkcbFpHaVRdcWXH46QiwxkFnbg/CGNUXJRDVuaWmgbZHgS4f51KeZWFmlhpdUeYrkOCcw4GmuAcNztcxOt1e5QmSibm9BHr1iqcJ6ImNh1/uN70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s64nWPtg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NlXd84oz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:05:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139102;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=glmAbEgD3RNqNOkbjLIV1w7OIgaSSIhfghEcLItK2Jc=;
	b=s64nWPtgyEhqG5N4bKdXz3jUIhaPMjELIHAblC0E79pNYmeG2iJcKdxIxMDooCc618dE2f
	tQY0hkdkx1tDrtW/3fg6MQ5a2sphnp/cIGcFQAbTTcCZ0YCcubn5ItbGLpkMVmK3H5oq2B
	rAM0WoooVhCoW2M1brkbkJ0i2rriPJN1lZJXyimnx9iYz91TTFKhr3XwaIv4T9iXjRyrMP
	54An4C/cSArI0jmpfFN/mA3IPNuoePcjJA2QCLsztGJf+nJ1SQQioybDRDFPBi7R17bpd/
	awubC7oN5PE+iU0dNoxGNsBzXJkgYC6ywwUDRKgKczm/UtfIefHnnz3NwoKqtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139102;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=glmAbEgD3RNqNOkbjLIV1w7OIgaSSIhfghEcLItK2Jc=;
	b=NlXd84ozL1coM4EYGtdT+gkwg2UgEaEQ8I07oq2dMwpENQtLmUNpP6jOWW6rIl6PcoAbgE
	qTtpcnES/erEq2Cw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Rename perf_event_exit_task(.child)
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250307193305.486326750@infradead.org>
References: <20250307193305.486326750@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413910123.31282.973495586484753335.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4da0600edae1cf15d12bebacc66d7237e2c33fc6
Gitweb:        https://git.kernel.org/tip/4da0600edae1cf15d12bebacc66d7237e2c33fc6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 14 Feb 2025 13:23:45 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:48 +02:00

perf: Rename perf_event_exit_task(.child)

The task passed to perf_event_exit_task() is not a child, it is
current. Fix this confusing naming, since much of the rest of the code
also relies on it being current.

Specifically, both exec() and exit() callers use it with current as
the argument.

Notably, task_ctx_sched_out() doesn't make much sense outside of
current.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lkml.kernel.org/r/20250307193305.486326750@infradead.org
---
 kernel/events/core.c | 62 ++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 85c8b79..985b5c7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13742,13 +13742,13 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 	perf_event_wakeup(event);
 }
 
-static void perf_event_exit_task_context(struct task_struct *child, bool exit)
+static void perf_event_exit_task_context(struct task_struct *task, bool exit)
 {
-	struct perf_event_context *child_ctx, *clone_ctx = NULL;
+	struct perf_event_context *ctx, *clone_ctx = NULL;
 	struct perf_event *child_event, *next;
 
-	child_ctx = perf_pin_task_context(child);
-	if (!child_ctx)
+	ctx = perf_pin_task_context(task);
+	if (!ctx)
 		return;
 
 	/*
@@ -13761,28 +13761,28 @@ static void perf_event_exit_task_context(struct task_struct *child, bool exit)
 	 * without ctx::mutex (it cannot because of the move_group double mutex
 	 * lock thing). See the comments in perf_install_in_context().
 	 */
-	mutex_lock(&child_ctx->mutex);
+	mutex_lock(&ctx->mutex);
 
 	/*
 	 * In a single ctx::lock section, de-schedule the events and detach the
 	 * context from the task such that we cannot ever get it scheduled back
 	 * in.
 	 */
-	raw_spin_lock_irq(&child_ctx->lock);
+	raw_spin_lock_irq(&ctx->lock);
 	if (exit)
-		task_ctx_sched_out(child_ctx, NULL, EVENT_ALL);
+		task_ctx_sched_out(ctx, NULL, EVENT_ALL);
 
 	/*
 	 * Now that the context is inactive, destroy the task <-> ctx relation
 	 * and mark the context dead.
 	 */
-	RCU_INIT_POINTER(child->perf_event_ctxp, NULL);
-	put_ctx(child_ctx); /* cannot be last */
-	WRITE_ONCE(child_ctx->task, TASK_TOMBSTONE);
-	put_task_struct(child); /* cannot be last */
+	RCU_INIT_POINTER(task->perf_event_ctxp, NULL);
+	put_ctx(ctx); /* cannot be last */
+	WRITE_ONCE(ctx->task, TASK_TOMBSTONE);
+	put_task_struct(task); /* cannot be last */
 
-	clone_ctx = unclone_ctx(child_ctx);
-	raw_spin_unlock_irq(&child_ctx->lock);
+	clone_ctx = unclone_ctx(ctx);
+	raw_spin_unlock_irq(&ctx->lock);
 
 	if (clone_ctx)
 		put_ctx(clone_ctx);
@@ -13793,12 +13793,12 @@ static void perf_event_exit_task_context(struct task_struct *child, bool exit)
 	 * get a few PERF_RECORD_READ events.
 	 */
 	if (exit)
-		perf_event_task(child, child_ctx, 0);
+		perf_event_task(task, ctx, 0);
 
-	list_for_each_entry_safe(child_event, next, &child_ctx->event_list, event_entry)
-		perf_event_exit_event(child_event, child_ctx);
+	list_for_each_entry_safe(child_event, next, &ctx->event_list, event_entry)
+		perf_event_exit_event(child_event, ctx);
 
-	mutex_unlock(&child_ctx->mutex);
+	mutex_unlock(&ctx->mutex);
 
 	if (!exit) {
 		/*
@@ -13814,24 +13814,26 @@ static void perf_event_exit_task_context(struct task_struct *child, bool exit)
 		 *
 		 * Wait for all events to drop their context reference.
 		 */
-		wait_var_event(&child_ctx->refcount,
-			       refcount_read(&child_ctx->refcount) == 1);
+		wait_var_event(&ctx->refcount,
+			       refcount_read(&ctx->refcount) == 1);
 	}
-	put_ctx(child_ctx);
+	put_ctx(ctx);
 }
 
 /*
- * When a child task exits, feed back event values to parent events.
+ * When a task exits, feed back event values to parent events.
  *
  * Can be called with exec_update_lock held when called from
  * setup_new_exec().
  */
-void perf_event_exit_task(struct task_struct *child)
+void perf_event_exit_task(struct task_struct *task)
 {
 	struct perf_event *event, *tmp;
 
-	mutex_lock(&child->perf_event_mutex);
-	list_for_each_entry_safe(event, tmp, &child->perf_event_list,
+	WARN_ON_ONCE(task != current);
+
+	mutex_lock(&task->perf_event_mutex);
+	list_for_each_entry_safe(event, tmp, &task->perf_event_list,
 				 owner_entry) {
 		list_del_init(&event->owner_entry);
 
@@ -13842,23 +13844,23 @@ void perf_event_exit_task(struct task_struct *child)
 		 */
 		smp_store_release(&event->owner, NULL);
 	}
-	mutex_unlock(&child->perf_event_mutex);
+	mutex_unlock(&task->perf_event_mutex);
 
-	perf_event_exit_task_context(child, true);
+	perf_event_exit_task_context(task, true);
 
 	/*
 	 * The perf_event_exit_task_context calls perf_event_task
-	 * with child's task_ctx, which generates EXIT events for
-	 * child contexts and sets child->perf_event_ctxp[] to NULL.
+	 * with task's task_ctx, which generates EXIT events for
+	 * task contexts and sets task->perf_event_ctxp[] to NULL.
 	 * At this point we need to send EXIT events to cpu contexts.
 	 */
-	perf_event_task(child, NULL, 0);
+	perf_event_task(task, NULL, 0);
 
 	/*
 	 * Detach the perf_ctx_data for the system-wide event.
 	 */
 	guard(percpu_read)(&global_ctx_data_rwsem);
-	detach_task_ctx_data(child);
+	detach_task_ctx_data(task);
 }
 
 /*

