Return-Path: <linux-tip-commits+bounces-4760-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6307A8156C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A4B1B8284C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516D62550C2;
	Tue,  8 Apr 2025 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LM45s3c0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SAN2xyUJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0039F253F22;
	Tue,  8 Apr 2025 19:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139111; cv=none; b=c5+HBOkUxZ9rKx06H9wUQI41oZgbsB5guu/xk3dCSsaQFQvF4i+4KkZwqqdsr0P1u5GBrazyTEymfyJdR9FB8D1B/3UfgK1ylFR77Ir0H1FgMDhb5smTzJeYByDwHTOhPZtCHnZrFWw2hjIMubc1OgUX2aRN7JIKOhpy6EXgNLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139111; c=relaxed/simple;
	bh=aC9PDcMIa2kuYs6UbgmHEJ+3M9+Cn0N5bq8yLwhx2bY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C+HILtON/S3Nq/Kr2rwyBhfXFL+h+i51iHmC/OkQfiVDWAc6DoMtGiVAm6Bcfo1ydGxH+KxWBG8VSyHV3Q0YMjjePaMTWnOBaf9BACVAGGdrWOoKLFOBb1DMU+tYQS5rHk7BVsfnNcpzzS7j46c8dl6ibx9QZIaXTYkmLQq7IYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LM45s3c0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SAN2xyUJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:05:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139106;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWexaRZkeUE0itKZTy139JmbNL736Daq4H9lg7rZncU=;
	b=LM45s3c05Dg/RKW0bHmUCJ8drAAcLgEFfBFCgwd+d9dvfADyCAM+3nqYUdaC5tcTHJO3gv
	yK7+EAciJ1tBRvpB0uJKUiKWnk4ZvipbhaZbEpET6sxRK9klFxi3ysi4zQEvbBM4+pi5Hp
	dAFMHasQQdToc9Yp4F+Dc7g79LuutRoV90ZkRGFYjcn+oChf8/dUVAkcIL+b2FSBXhtMaC
	WsTXk2+BVhiprBxxehyoIki9kmYIIQ3X9X7/FxR4h0gI3O7TD5vc7ILJ21Qk49xFcSDNau
	PncAdly6ScvLc1/S7fOt4fYGsag2wEi7MnJSUZI8c/TxxmoUUkFLRPEeb9IXAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139106;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWexaRZkeUE0itKZTy139JmbNL736Daq4H9lg7rZncU=;
	b=SAN2xyUJkf/mt5Gg7jwO/izy3k+cBWPGj3WK7t63Ud/EmFxd1MSeI3G+gNIiJJZOL7CU0B
	RAu567SLM19RZFDQ==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Fix hang while freeing sigtrap event
Cc: "Yi Lai" <yi1.lai@linux.intel.com>,
 syzbot+3c4321e10eea460eb606@syzkaller.appspotmail.com,
 Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250304135446.18905-1-frederic@kernel.org>
References: <20250304135446.18905-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413910608.31282.2741272881381572685.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     56799bc035658738f362acec3e7647bb84e68933
Gitweb:        https://git.kernel.org/tip/56799bc035658738f362acec3e7647bb84e68933
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 04 Mar 2025 14:54:46 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:43 +02:00

perf: Fix hang while freeing sigtrap event

Perf can hang while freeing a sigtrap event if a related deferred
signal hadn't managed to be sent before the file got closed:

perf_event_overflow()
   task_work_add(perf_pending_task)

fput()
   task_work_add(____fput())

task_work_run()
    ____fput()
        perf_release()
            perf_event_release_kernel()
                _free_event()
                    perf_pending_task_sync()
                        task_work_cancel() -> FAILED
                        rcuwait_wait_event()

Once task_work_run() is running, the list of pending callbacks is
removed from the task_struct and from this point on task_work_cancel()
can't remove any pending and not yet started work items, hence the
task_work_cancel() failure and the hang on rcuwait_wait_event().

Task work could be changed to remove one work at a time, so a work
running on the current task can always cancel a pending one, however
the wait / wake design is still subject to inverted dependencies when
remote targets are involved, as pictured by Oleg:

T1                                                      T2

fd = perf_event_open(pid => T2->pid);                  fd = perf_event_open(pid => T1->pid);
close(fd)                                              close(fd)
    <IRQ>                                                  <IRQ>
    perf_event_overflow()                                  perf_event_overflow()
       task_work_add(perf_pending_task)                        task_work_add(perf_pending_task)
    </IRQ>                                                 </IRQ>
    fput()                                                 fput()
        task_work_add(____fput())                              task_work_add(____fput())

    task_work_run()                                        task_work_run()
        ____fput()                                             ____fput()
            perf_release()                                         perf_release()
                perf_event_release_kernel()                            perf_event_release_kernel()
                    _free_event()                                          _free_event()
                        perf_pending_task_sync()                               perf_pending_task_sync()
                            rcuwait_wait_event()                                   rcuwait_wait_event()

Therefore the only option left is to acquire the event reference count
upon queueing the perf task work and release it from the task work, just
like it was done before 3a5465418f5f ("perf: Fix event leak upon exec and file release")
but without the leaks it fixed.

Some adjustments are necessary to make it work:

* A child event might dereference its parent upon freeing. Care must be
  taken to release the parent last.

* Some places assuming the event doesn't have any reference held and
  therefore can be freed right away must instead put the reference and
  let the reference counting to its job.

Reported-by: "Yi Lai" <yi1.lai@linux.intel.com>
Closes: https://lore.kernel.org/all/Zx9Losv4YcJowaP%2F@ly-workstation/
Reported-by: syzbot+3c4321e10eea460eb606@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/673adf75.050a0220.87769.0024.GAE@google.com/
Fixes: 3a5465418f5f ("perf: Fix event leak upon exec and file release")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250304135446.18905-1-frederic@kernel.org
---
 include/linux/perf_event.h |  1 +-
 kernel/events/core.c       | 64 ++++++++++---------------------------
 2 files changed, 18 insertions(+), 47 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 5a9bf15..0069ba6 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -823,7 +823,6 @@ struct perf_event {
 	struct irq_work			pending_disable_irq;
 	struct callback_head		pending_task;
 	unsigned int			pending_work;
-	struct rcuwait			pending_work_wait;
 
 	atomic_t			event_limit;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9af9726..e93c195 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5518,30 +5518,6 @@ static bool exclusive_event_installable(struct perf_event *event,
 
 static void perf_free_addr_filters(struct perf_event *event);
 
-static void perf_pending_task_sync(struct perf_event *event)
-{
-	struct callback_head *head = &event->pending_task;
-
-	if (!event->pending_work)
-		return;
-	/*
-	 * If the task is queued to the current task's queue, we
-	 * obviously can't wait for it to complete. Simply cancel it.
-	 */
-	if (task_work_cancel(current, head)) {
-		event->pending_work = 0;
-		local_dec(&event->ctx->nr_no_switch_fast);
-		return;
-	}
-
-	/*
-	 * All accesses related to the event are within the same RCU section in
-	 * perf_pending_task(). The RCU grace period before the event is freed
-	 * will make sure all those accesses are complete by then.
-	 */
-	rcuwait_wait_event(&event->pending_work_wait, !event->pending_work, TASK_UNINTERRUPTIBLE);
-}
-
 /* vs perf_event_alloc() error */
 static void __free_event(struct perf_event *event)
 {
@@ -5599,7 +5575,6 @@ static void _free_event(struct perf_event *event)
 {
 	irq_work_sync(&event->pending_irq);
 	irq_work_sync(&event->pending_disable_irq);
-	perf_pending_task_sync(event);
 
 	unaccount_event(event);
 
@@ -5692,10 +5667,17 @@ static void perf_remove_from_owner(struct perf_event *event)
 
 static void put_event(struct perf_event *event)
 {
+	struct perf_event *parent;
+
 	if (!atomic_long_dec_and_test(&event->refcount))
 		return;
 
+	parent = event->parent;
 	_free_event(event);
+
+	/* Matches the refcount bump in inherit_event() */
+	if (parent)
+		put_event(parent);
 }
 
 /*
@@ -5779,11 +5761,6 @@ again:
 		if (tmp == child) {
 			perf_remove_from_context(child, DETACH_GROUP);
 			list_move(&child->child_list, &free_list);
-			/*
-			 * This matches the refcount bump in inherit_event();
-			 * this can't be the last reference.
-			 */
-			put_event(event);
 		} else {
 			var = &ctx->refcount;
 		}
@@ -5809,7 +5786,8 @@ again:
 		void *var = &child->ctx->refcount;
 
 		list_del(&child->child_list);
-		free_event(child);
+		/* Last reference unless ->pending_task work is pending */
+		put_event(child);
 
 		/*
 		 * Wake any perf_event_free_task() waiting for this event to be
@@ -5820,7 +5798,11 @@ again:
 	}
 
 no_ctx:
-	put_event(event); /* Must be the 'last' reference */
+	/*
+	 * Last reference unless ->pending_task work is pending on this event
+	 * or any of its children.
+	 */
+	put_event(event);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(perf_event_release_kernel);
@@ -7236,12 +7218,6 @@ static void perf_pending_task(struct callback_head *head)
 	int rctx;
 
 	/*
-	 * All accesses to the event must belong to the same implicit RCU read-side
-	 * critical section as the ->pending_work reset. See comment in
-	 * perf_pending_task_sync().
-	 */
-	rcu_read_lock();
-	/*
 	 * If we 'fail' here, that's OK, it means recursion is already disabled
 	 * and we won't recurse 'further'.
 	 */
@@ -7251,9 +7227,8 @@ static void perf_pending_task(struct callback_head *head)
 		event->pending_work = 0;
 		perf_sigtrap(event);
 		local_dec(&event->ctx->nr_no_switch_fast);
-		rcuwait_wake_up(&event->pending_work_wait);
 	}
-	rcu_read_unlock();
+	put_event(event);
 
 	if (rctx >= 0)
 		perf_swevent_put_recursion_context(rctx);
@@ -10248,6 +10223,7 @@ static int __perf_event_overflow(struct perf_event *event,
 		    !task_work_add(current, &event->pending_task, notify_mode)) {
 			event->pending_work = pending_id;
 			local_inc(&event->ctx->nr_no_switch_fast);
+			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
 
 			event->pending_addr = 0;
 			if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
@@ -12610,7 +12586,6 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	init_irq_work(&event->pending_irq, perf_pending_irq);
 	event->pending_disable_irq = IRQ_WORK_INIT_HARD(perf_pending_disable);
 	init_task_work(&event->pending_task, perf_pending_task);
-	rcuwait_init(&event->pending_work_wait);
 
 	mutex_init(&event->mmap_mutex);
 	raw_spin_lock_init(&event->addr_filters.lock);
@@ -13747,8 +13722,7 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 		 * Kick perf_poll() for is_event_hup();
 		 */
 		perf_event_wakeup(parent_event);
-		free_event(event);
-		put_event(parent_event);
+		put_event(event);
 		return;
 	}
 
@@ -13872,13 +13846,11 @@ static void perf_free_event(struct perf_event *event,
 	list_del_init(&event->child_list);
 	mutex_unlock(&parent->child_mutex);
 
-	put_event(parent);
-
 	raw_spin_lock_irq(&ctx->lock);
 	perf_group_detach(event);
 	list_del_event(event, ctx);
 	raw_spin_unlock_irq(&ctx->lock);
-	free_event(event);
+	put_event(event);
 }
 
 /*

