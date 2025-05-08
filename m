Return-Path: <linux-tip-commits+bounces-5488-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7C4AAF81D
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D991C21882
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32558236424;
	Thu,  8 May 2025 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HF+AA810";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dg8EGONJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E98B20C46F;
	Thu,  8 May 2025 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700473; cv=none; b=Eidgh0PuaRLnzgzHcRRsWME/byuC0gVizw1aSmYy78KqkXjUxvSCEV92dI2RJhvRK7xC/WNmxNE58NzzW3bGDsBPgf+4RanhVvGkFfNc7j8ALZxcJQlHVq7LB4B9wmwjHkNQrssl4jtI7L840dVuLiFQbazkfBLlmvSNd9p056Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700473; c=relaxed/simple;
	bh=CuBMB7PSAhEF7x+0nxtqmfMmTY8lDbPHmMl7xX8mE2U=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=gJm17QsS/02TogS2yph6ULf23yadMP5ItfqIHhoKS8tJuzsv0zBsCwAZ8I6Oi9ORlV4AZrvfSDMEkskoy+qBvYdXEODOfEuJjyQkrw5YoDBj+ZmGAF2Okjugyhp/uHcg5JVgfFuQbGMk8iH/XNmhS9Bd5+QlPSO6jyFCwXnA+X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HF+AA810; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dg8EGONJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:34:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700470;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=s4K76QvUlhZtCkTDl/xohikKwi0llkY+HdzHM5PDk6w=;
	b=HF+AA810lpTTsu45ed4pP2a1VlS1yyUavmK30fvOvtarO9E7SRUywvJGz9wYHzyoBLaReQ
	ycnAX45eeN0bkyyjK3BoVkqc4AdrvuDrEG5QUKVTZ3gbS9NQU5giRorFiZYkPqG+ZwDtBM
	ZWFgc2VU8auTMAEIrSqNC2ib6QlVcuL3WLWChUwPqC9BFUAY9bypPE1JQWq83ZvQL9eexY
	3A9wREme69jmbxqZIXfzixGc0xJj/Mh1gtxRAY8ilO5idJprMhcOGvTGlWtwp986cSWnnp
	RgnIfGq+yoPkEuzUJ0/KjypHRnSgaU9jRZtVdR5uPromS8PtmTPqdd/Zz90UvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700470;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=s4K76QvUlhZtCkTDl/xohikKwi0llkY+HdzHM5PDk6w=;
	b=Dg8EGONJcTajUhCuGiy85I4usWuYhv5zJ/FpIQzsyo4Emk187KsYL/F1ZRkBusKps0vSuP
	8Vj85npaQI+n9OCw==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Fix irq work dereferencing garbage
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670046919.406.15885032121099672652.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     88d51e795539acd08bce028eff3aa78748b847a8
Gitweb:        https://git.kernel.org/tip/88d51e795539acd08bce028eff3aa78748b847a8
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Mon, 28 Apr 2025 13:11:47 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 May 2025 12:40:40 +02:00

perf: Fix irq work dereferencing garbage

The following commit:

	da916e96e2de ("perf: Make perf_pmu_unregister() useable")

has introduced two significant event's parent lifecycle changes:

1) An event that has exited now has EVENT_TOMBSTONE as a parent.
   This can result in a situation where the delayed wakeup irq_work can
   accidentally dereference EVENT_TOMBSTONE on:

CPU 0                                          CPU 1
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
 

