Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D1736235D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 17:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245397AbhDPPCX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 11:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245129AbhDPPCS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 11:02:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8F6C061756;
        Fri, 16 Apr 2021 08:01:53 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:01:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618585312;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yHU3lJHYZ6KWw55s6+nf0IPPZ47KX7Y5NhSPg3HfFfE=;
        b=NXMIEi7EgozZRZAyYSxd+DnvwxA/n5wB2FUiLdfLF8xpHoFds7crGtiZXQs+PJff9kfF1u
        iW2FQIS50pTRzen+jyfXmoTDNaIJ+Y64nVe4ShbvGMmDSSSoaNHI/P/LL43cGSFlKQKC5T
        ZaRTN3DJTogAPSUJ+a1Ma654rxv2YeoPnLHBjmzVMyc9RWIkTnsiCr7GAjovSgMCSmln54
        8nFcldj65nRgEvBRVM91OAYspxCGRKAqkjaEWcwtnKa8Uam7oA3gogq7+YKapRr9RRX2aP
        6PRKjltevmaN4zHJQmxuw31ewExz8QEn8Z7pDrMM5h8Pe9mP4dfAaHEk8eJUgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618585312;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yHU3lJHYZ6KWw55s6+nf0IPPZ47KX7Y5NhSPg3HfFfE=;
        b=PE+lGRkm/UTQF+x84JrO+Jy7hfZjSmTkG0EazwEC1oQ5j4hdhPMl7hGOr/9l9j7dw50hC8
        fYSt9WhrM4/TDcDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Rework perf_event_exit_event()
Cc:     Marco Elver <elver@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210408103605.1676875-2-elver@google.com>
References: <20210408103605.1676875-2-elver@google.com>
MIME-Version: 1.0
Message-ID: <161858531185.29796.13598961985814328547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ef54c1a476aef7eef26fe13ea10dc090952c00f8
Gitweb:        https://git.kernel.org/tip/ef54c1a476aef7eef26fe13ea10dc090952c00f8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 08 Apr 2021 12:35:56 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 16:32:40 +02:00

perf: Rework perf_event_exit_event()

Make perf_event_exit_event() more robust, such that we can use it from
other contexts. Specifically the up and coming remove_on_exec.

For this to work we need to address a few issues. Remove_on_exec will
not destroy the entire context, so we cannot rely on TASK_TOMBSTONE to
disable event_function_call() and we thus have to use
perf_remove_from_context().

When using perf_remove_from_context(), there's two races to consider.
The first is against close(), where we can have concurrent tear-down
of the event. The second is against child_list iteration, which should
not find a half baked event.

To address this, teach perf_remove_from_context() to special case
!ctx->is_active and about DETACH_CHILD.

[ elver@google.com: fix racing parent/child exit in sync_child_event(). ]
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210408103605.1676875-2-elver@google.com
---
 include/linux/perf_event.h |   1 +-
 kernel/events/core.c       | 142 ++++++++++++++++++++----------------
 2 files changed, 80 insertions(+), 63 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3f7f89e..3d478ab 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -607,6 +607,7 @@ struct swevent_hlist {
 #define PERF_ATTACH_TASK_DATA	0x08
 #define PERF_ATTACH_ITRACE	0x10
 #define PERF_ATTACH_SCHED_CB	0x20
+#define PERF_ATTACH_CHILD	0x40
 
 struct perf_cgroup;
 struct perf_buffer;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f079431..318ff7b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2205,6 +2205,26 @@ out:
 	perf_event__header_size(leader);
 }
 
+static void sync_child_event(struct perf_event *child_event);
+
+static void perf_child_detach(struct perf_event *event)
+{
+	struct perf_event *parent_event = event->parent;
+
+	if (!(event->attach_state & PERF_ATTACH_CHILD))
+		return;
+
+	event->attach_state &= ~PERF_ATTACH_CHILD;
+
+	if (WARN_ON_ONCE(!parent_event))
+		return;
+
+	lockdep_assert_held(&parent_event->child_mutex);
+
+	sync_child_event(event);
+	list_del_init(&event->child_list);
+}
+
 static bool is_orphaned_event(struct perf_event *event)
 {
 	return event->state == PERF_EVENT_STATE_DEAD;
@@ -2312,6 +2332,7 @@ group_sched_out(struct perf_event *group_event,
 }
 
 #define DETACH_GROUP	0x01UL
+#define DETACH_CHILD	0x02UL
 
 /*
  * Cross CPU call to remove a performance event
@@ -2335,6 +2356,8 @@ __perf_remove_from_context(struct perf_event *event,
 	event_sched_out(event, cpuctx, ctx);
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
+	if (flags & DETACH_CHILD)
+		perf_child_detach(event);
 	list_del_event(event, ctx);
 
 	if (!ctx->nr_events && ctx->is_active) {
@@ -2363,25 +2386,21 @@ static void perf_remove_from_context(struct perf_event *event, unsigned long fla
 
 	lockdep_assert_held(&ctx->mutex);
 
-	event_function_call(event, __perf_remove_from_context, (void *)flags);
-
 	/*
-	 * The above event_function_call() can NO-OP when it hits
-	 * TASK_TOMBSTONE. In that case we must already have been detached
-	 * from the context (by perf_event_exit_event()) but the grouping
-	 * might still be in-tact.
+	 * Because of perf_event_exit_task(), perf_remove_from_context() ought
+	 * to work in the face of TASK_TOMBSTONE, unlike every other
+	 * event_function_call() user.
 	 */
-	WARN_ON_ONCE(event->attach_state & PERF_ATTACH_CONTEXT);
-	if ((flags & DETACH_GROUP) &&
-	    (event->attach_state & PERF_ATTACH_GROUP)) {
-		/*
-		 * Since in that case we cannot possibly be scheduled, simply
-		 * detach now.
-		 */
-		raw_spin_lock_irq(&ctx->lock);
-		perf_group_detach(event);
+	raw_spin_lock_irq(&ctx->lock);
+	if (!ctx->is_active) {
+		__perf_remove_from_context(event, __get_cpu_context(ctx),
+					   ctx, (void *)flags);
 		raw_spin_unlock_irq(&ctx->lock);
+		return;
 	}
+	raw_spin_unlock_irq(&ctx->lock);
+
+	event_function_call(event, __perf_remove_from_context, (void *)flags);
 }
 
 /*
@@ -12377,14 +12396,17 @@ void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
 }
 EXPORT_SYMBOL_GPL(perf_pmu_migrate_context);
 
-static void sync_child_event(struct perf_event *child_event,
-			       struct task_struct *child)
+static void sync_child_event(struct perf_event *child_event)
 {
 	struct perf_event *parent_event = child_event->parent;
 	u64 child_val;
 
-	if (child_event->attr.inherit_stat)
-		perf_event_read_event(child_event, child);
+	if (child_event->attr.inherit_stat) {
+		struct task_struct *task = child_event->ctx->task;
+
+		if (task && task != TASK_TOMBSTONE)
+			perf_event_read_event(child_event, task);
+	}
 
 	child_val = perf_event_count(child_event);
 
@@ -12399,60 +12421,53 @@ static void sync_child_event(struct perf_event *child_event,
 }
 
 static void
-perf_event_exit_event(struct perf_event *child_event,
-		      struct perf_event_context *child_ctx,
-		      struct task_struct *child)
+perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 {
-	struct perf_event *parent_event = child_event->parent;
+	struct perf_event *parent_event = event->parent;
+	unsigned long detach_flags = 0;
 
-	/*
-	 * Do not destroy the 'original' grouping; because of the context
-	 * switch optimization the original events could've ended up in a
-	 * random child task.
-	 *
-	 * If we were to destroy the original group, all group related
-	 * operations would cease to function properly after this random
-	 * child dies.
-	 *
-	 * Do destroy all inherited groups, we don't care about those
-	 * and being thorough is better.
-	 */
-	raw_spin_lock_irq(&child_ctx->lock);
-	WARN_ON_ONCE(child_ctx->is_active);
+	if (parent_event) {
+		/*
+		 * Do not destroy the 'original' grouping; because of the
+		 * context switch optimization the original events could've
+		 * ended up in a random child task.
+		 *
+		 * If we were to destroy the original group, all group related
+		 * operations would cease to function properly after this
+		 * random child dies.
+		 *
+		 * Do destroy all inherited groups, we don't care about those
+		 * and being thorough is better.
+		 */
+		detach_flags = DETACH_GROUP | DETACH_CHILD;
+		mutex_lock(&parent_event->child_mutex);
+	}
 
-	if (parent_event)
-		perf_group_detach(child_event);
-	list_del_event(child_event, child_ctx);
-	perf_event_set_state(child_event, PERF_EVENT_STATE_EXIT); /* is_event_hup() */
-	raw_spin_unlock_irq(&child_ctx->lock);
+	perf_remove_from_context(event, detach_flags);
+
+	raw_spin_lock_irq(&ctx->lock);
+	if (event->state > PERF_EVENT_STATE_EXIT)
+		perf_event_set_state(event, PERF_EVENT_STATE_EXIT);
+	raw_spin_unlock_irq(&ctx->lock);
 
 	/*
-	 * Parent events are governed by their filedesc, retain them.
+	 * Child events can be freed.
 	 */
-	if (!parent_event) {
-		perf_event_wakeup(child_event);
+	if (parent_event) {
+		mutex_unlock(&parent_event->child_mutex);
+		/*
+		 * Kick perf_poll() for is_event_hup();
+		 */
+		perf_event_wakeup(parent_event);
+		free_event(event);
+		put_event(parent_event);
 		return;
 	}
-	/*
-	 * Child events can be cleaned up.
-	 */
-
-	sync_child_event(child_event, child);
 
 	/*
-	 * Remove this event from the parent's list
-	 */
-	WARN_ON_ONCE(parent_event->ctx->parent_ctx);
-	mutex_lock(&parent_event->child_mutex);
-	list_del_init(&child_event->child_list);
-	mutex_unlock(&parent_event->child_mutex);
-
-	/*
-	 * Kick perf_poll() for is_event_hup().
+	 * Parent events are governed by their filedesc, retain them.
 	 */
-	perf_event_wakeup(parent_event);
-	free_event(child_event);
-	put_event(parent_event);
+	perf_event_wakeup(event);
 }
 
 static void perf_event_exit_task_context(struct task_struct *child, int ctxn)
@@ -12509,7 +12524,7 @@ static void perf_event_exit_task_context(struct task_struct *child, int ctxn)
 	perf_event_task(child, child_ctx, 0);
 
 	list_for_each_entry_safe(child_event, next, &child_ctx->event_list, event_entry)
-		perf_event_exit_event(child_event, child_ctx, child);
+		perf_event_exit_event(child_event, child_ctx);
 
 	mutex_unlock(&child_ctx->mutex);
 
@@ -12769,6 +12784,7 @@ inherit_event(struct perf_event *parent_event,
 	 */
 	raw_spin_lock_irqsave(&child_ctx->lock, flags);
 	add_event_to_ctx(child_event, child_ctx);
+	child_event->attach_state |= PERF_ATTACH_CHILD;
 	raw_spin_unlock_irqrestore(&child_ctx->lock, flags);
 
 	/*
