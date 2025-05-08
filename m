Return-Path: <linux-tip-commits+bounces-5511-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F36AB0422
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 21:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44FA01B652E0
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 19:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AC528C5CF;
	Thu,  8 May 2025 19:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nbaOy8UH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HfFbZTSn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF10289823;
	Thu,  8 May 2025 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734123; cv=none; b=NAcyq+NYAdf7YsryHybci9e5UV1+BEWAO9t5wchOs0OC+vkZDHnI3D8ktB1aP6ly0Y/XPGxmM9b6+9Yad/RcTFR4J6grf0gZi7i33vUcnPw/IfNMTf4fii2pObeO4DPiQuUk1ob6Pl5hO8XP8vSFIY8A7NYby67GWjE5aQexNS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734123; c=relaxed/simple;
	bh=NIlaEZOjjYw503zEtkLA060WDKdU2sfcKok31HZb7fg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Od4k/v2aApp/uC9umqvWHIhoNJdbBhcQB9ZlaN8hIZIJNwWOx0jDY3sFKa9MDLUakca6PhMjt1Uajb2sY/jVTqlwn++5R/7Vlq9lAFNx93CYNhMOVx66yMg9UA3IGdXHVdzmFjgohoyndUCILt/Ae5bsCBEw+cg9ZJpDpiTJ2gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nbaOy8UH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HfFbZTSn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 19:55:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746734118;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=fYb4XdAPx1UxLmvwWYSBvDn1belJ2jh1iwn3z+SvTko=;
	b=nbaOy8UHqLNLikwLu+aLYsIBitV8QxPW78Cwp6/7Ick7hP/31dIWVFmtCUIMrZK2mr3XQl
	Yh9UQmoRWKxM1yv2FN1PzXdXl6oWJiNYQJ504H4gHNr0UFpSLz23iDJO1zskSD/OydjtF8
	h9CLdwz9Rx/6PxLKMJ8kca6RaLxcIfPGth7I2tvClzDI55bR2A8DRCFokDhWkK6X+psa5P
	xXh3+KaCVyTGrr6wzMdNfyRa88DjRNTO0VUwhHPoSVdWbLeqDed7VgT1Z+L2yxSkgb9bUM
	z4wC+Kufy/KDNwk2Y4jFNf9yIA9I8z9LE3vcNuafLZfQ13/TLo1qZiXpoiVS1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746734118;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=fYb4XdAPx1UxLmvwWYSBvDn1belJ2jh1iwn3z+SvTko=;
	b=HfFbZTSn5Mz5NIxJm0YIuacSc9BJ+Arh0Rm0VTrZ/sPW7Js6likpylxIpLsssDM/mJN/PN
	LiJiMyE2dr5gj0Dg==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Fix irq work dereferencing garbage
Cc: Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174673411735.406.16084411654137347057.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d20eb2d5fe8f8818abcfdadf5ac5109938f1318e
Gitweb:        https://git.kernel.org/tip/d20eb2d5fe8f8818abcfdadf5ac5109938f1318e
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Mon, 28 Apr 2025 13:11:47 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 08 May 2025 21:50:19 +02:00

perf: Fix irq work dereferencing garbage

The following commit:

	da916e96e2de ("perf: Make perf_pmu_unregister() useable")

has introduced two significant event's parent lifecycle changes:

1) An event that has exited now has EVENT_TOMBSTONE as a parent.
   This can result in a situation where the delayed wakeup irq_work can
   accidentally dereference EVENT_TOMBSTONE on:

CPU 0                                          CPU 1
-----                                          -----

__schedule()
    local_irq_disable()
    rq_lock()
    <NMI>
    perf_event_overflow()
        irq_work_queue(&child->pending_irq)
    </NMI>
    perf_event_task_sched_out()
        raw_spin_lock(&ctx->lock)
        ctx_sched_out()
        ctx->is_active = 0
        event_sched_out(child)
        raw_spin_unlock(&ctx->lock)
                                              perf_event_release_kernel(parent)
                                                  perf_remove_from_context(child)
                                                  raw_spin_lock_irq(&ctx->lock)
                                                  // Sees !ctx->is_active
                                                  // Removes from context inline
                                                  __perf_remove_from_context(child)
                                                      perf_child_detach(child)
                                                          event->parent = EVENT_TOMBSTONE
    raw_spin_rq_unlock_irq(rq);
    <IRQ>
    perf_pending_irq()
        perf_event_wakeup(child)
            ring_buffer_wakeup(child)
                rcu_dereference(child->parent->rb) <--- CRASH

This also concerns the call to kill_fasync() on parent->fasync.

2) The final parent reference count decrement can now happen before the
   the final child reference count decrement. ie: the parent can now
   be freed before its child. On PREEMPT_RT, this can result in a
   situation where the delayed wakeup irq_work can accidentally
   dereference a freed parent:

CPU 0                                          CPU 1                              CPU 2
-----                                          -----                              ------

perf_pmu_unregister()
    pmu_detach_events()
       pmu_get_event()
           atomic_long_inc_not_zero(&child->refcount)

                                               <NMI>
                                               perf_event_overflow()
                                                   irq_work_queue(&child->pending_irq);
                                               </NMI>
                                               <IRQ>
                                               irq_work_run()
                                                   wake_irq_workd()
                                               </IRQ>
                                               preempt_schedule_irq()
                                               =========> SWITCH to workd
                                               irq_work_run_list()
                                                   perf_pending_irq()
                                                       perf_event_wakeup(child)
                                                           ring_buffer_wakeup(child)
                                                               event = child->parent

                                                                                  perf_event_release_kernel(parent)
                                                                                      // Not last ref, PMU holds it
                                                                                      put_event(child)
                                                                                      // Last ref
                                                                                      put_event(parent)
                                                                                          free_event()
                                                                                              call_rcu(...)
                                                                                  rcu_core()
                                                                                      free_event_rcu()

                                                               rcu_dereference(event->rb) <--- CRASH

This also concerns the call to kill_fasync() on parent->fasync.

The "easy" solution to 1) is to check that event->parent is not
EVENT_TOMBSTONE on perf_event_wakeup() (including both ring buffer
and fasync uses).

The "easy" solution to 2) is to turn perf_event_wakeup() to wholefully
run under rcu_read_lock().

However because of 2), sanity would prescribe to make event::parent
an __rcu pointer and annotate each and every users to prove they are
reliable.

Propose an alternate solution and restore the stable pointer to the
parent until all its children have called _free_event() themselves to
avoid any further accident. Also revert the EVENT_TOMBSTONE design
that is mostly here to determine which caller of perf_event_exit_event()
must perform the refcount decrement on a child event matching the
increment in inherit_event().

Arrange instead for checking the attach state of an event prior to its
removal and decrement the refcount of the child accordingly.

Fixes: da916e96e2de ("perf: Make perf_pmu_unregister() useable")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 882db7b..e0ca4a8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -208,7 +208,6 @@ static void perf_ctx_unlock(struct perf_cpu_context *cpuctx,
 }
 
 #define TASK_TOMBSTONE ((void *)-1L)
-#define EVENT_TOMBSTONE ((void *)-1L)
 
 static bool is_kernel_event(struct perf_event *event)
 {
@@ -2338,12 +2337,6 @@ static void perf_child_detach(struct perf_event *event)
 
 	sync_child_event(event);
 	list_del_init(&event->child_list);
-	/*
-	 * Cannot set to NULL, as that would confuse the situation vs
-	 * not being a child event. See for example unaccount_event().
-	 */
-	event->parent = EVENT_TOMBSTONE;
-	put_event(parent_event);
 }
 
 static bool is_orphaned_event(struct perf_event *event)
@@ -5705,7 +5698,7 @@ static void put_event(struct perf_event *event)
 	_free_event(event);
 
 	/* Matches the refcount bump in inherit_event() */
-	if (parent && parent != EVENT_TOMBSTONE)
+	if (parent)
 		put_event(parent);
 }
 
@@ -9998,7 +9991,7 @@ void perf_event_text_poke(const void *addr, const void *old_bytes,
 
 void perf_event_itrace_started(struct perf_event *event)
 {
-	event->attach_state |= PERF_ATTACH_ITRACE;
+	WRITE_ONCE(event->attach_state, event->attach_state | PERF_ATTACH_ITRACE);
 }
 
 static void perf_log_itrace_start(struct perf_event *event)
@@ -13922,10 +13915,7 @@ perf_event_exit_event(struct perf_event *event,
 {
 	struct perf_event *parent_event = event->parent;
 	unsigned long detach_flags = DETACH_EXIT;
-	bool is_child = !!parent_event;
-
-	if (parent_event == EVENT_TOMBSTONE)
-		parent_event = NULL;
+	unsigned int attach_state;
 
 	if (parent_event) {
 		/*
@@ -13942,6 +13932,8 @@ perf_event_exit_event(struct perf_event *event,
 		 */
 		detach_flags |= DETACH_GROUP | DETACH_CHILD;
 		mutex_lock(&parent_event->child_mutex);
+		/* PERF_ATTACH_ITRACE might be set concurrently */
+		attach_state = READ_ONCE(event->attach_state);
 	}
 
 	if (revoke)
@@ -13951,18 +13943,25 @@ perf_event_exit_event(struct perf_event *event,
 	/*
 	 * Child events can be freed.
 	 */
-	if (is_child) {
-		if (parent_event) {
-			mutex_unlock(&parent_event->child_mutex);
+	if (parent_event) {
+		mutex_unlock(&parent_event->child_mutex);
+
+		/*
+		 * Match the refcount initialization. Make sure it doesn't happen
+		 * twice if pmu_detach_event() calls it on an already exited task.
+		 */
+		if (attach_state & PERF_ATTACH_CHILD) {
 			/*
 			 * Kick perf_poll() for is_event_hup();
 			 */
 			perf_event_wakeup(parent_event);
 			/*
 			 * pmu_detach_event() will have an extra refcount.
+			 * perf_pending_task() might have one too.
 			 */
 			put_event(event);
 		}
+
 		return;
 	}
 

