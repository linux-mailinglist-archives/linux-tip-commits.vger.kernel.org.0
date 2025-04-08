Return-Path: <linux-tip-commits+bounces-4757-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 351DAA81560
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADA0B1BA1D2F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24794253B56;
	Tue,  8 Apr 2025 19:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="emca39hr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7i4SY5bg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359F724C081;
	Tue,  8 Apr 2025 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139108; cv=none; b=okCbkv5qj2qN9mkU5SdyK8YxJY98KYpwVRgOH2A0FiFCalcZCJm2QWbGkFRUImVFhk0oe8EKifXe+SHsx1Ropi55/USlacLxSgaGtP5nih7fg5XnfArGb6TQdndvRDDTSaUvl5+EApeTLz4JmeGeJz0bItBBv/+zBdRVUKH+pvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139108; c=relaxed/simple;
	bh=epqxHBdPXZeCNSuMlLbBXt2xG4kbcI4lPWerbZ6Lrbw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r5vw0FL4DwmFtZi9Iq2uSSXGqWwExhXIcmIWKn8QHFcG/kFnhWl1rxoj5af03ktXeb8AXRd7V4kv50PTNq6AeaDpt1eYpaOX9KATg8lOdS4aaMlN+ZvQBWFjV2tlQeF5DHawIgzqHz5Z1pZBH7MQyDruN4R0FX0R0o1e/iB4/F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=emca39hr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7i4SY5bg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:05:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139104;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wG8nE4PK/MCywTaBnLYoejxM3lCfzLSOuVL6VRBntM4=;
	b=emca39hrrCQ4Qwb2Sh5+vg8xfDwGzSmR97WlfVviQ2z+EAyxf7LH4f3fXPHX5RbaAiNJA1
	PYpezKMQRr5cyOtXtmP/V+Jb/oM4ASoSB+v9cj8bNYcUcdKgIOa4ueD36llCHhWIg4tJVR
	hXHRWWs46MXZSlM5DDQtuaE3tqmLmMi1OSwWGV+W7wyPuq/YYEKJb0Rkcvc9PTmzHvD/iK
	fsoEzHIIMipuxrotLUaE4r+5CS5xneFnvDOWzxlZ3lGITXfN8ytQJ/pkc9uiK5+Beqx+8A
	0lk0HhV3xkpXMS0vaNyRI9+RkYI3N3mSl8l5SGqvXQ+0HfI5DZHydB7qLEvvog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139104;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wG8nE4PK/MCywTaBnLYoejxM3lCfzLSOuVL6VRBntM4=;
	b=7i4SY5bgfFH0NxMGxYUsx0D+hjdmmW1y8sctj71DQX5ijrObWpBGMTAyYDnx15AUy/Ia/l
	D7COn3oLXgceFLDg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Simplify perf_event_free_task() wait
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250307193723.044499344@infradead.org>
References: <20250307193723.044499344@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413910413.31282.5179470093314736126.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     59f3aa4a3ee27e96132e16d2d2bdc3acadb4bf79
Gitweb:        https://git.kernel.org/tip/59f3aa4a3ee27e96132e16d2d2bdc3acadb4bf79
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 17 Jan 2025 15:27:07 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:46 +02:00

perf: Simplify perf_event_free_task() wait

Simplify the code by moving the duplicated wakeup condition into
put_ctx().

Notably, wait_var_event() is in perf_event_free_task() and will have
set ctx->task = TASK_TOMBSTONE.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lkml.kernel.org/r/20250307193723.044499344@infradead.org
---
 kernel/events/core.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3c92b75..fa6dab0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1270,6 +1270,9 @@ static void put_ctx(struct perf_event_context *ctx)
 		if (ctx->task && ctx->task != TASK_TOMBSTONE)
 			put_task_struct(ctx->task);
 		call_rcu(&ctx->rcu_head, free_ctx);
+	} else if (ctx->task == TASK_TOMBSTONE) {
+		smp_mb(); /* pairs with wait_var_event() */
+		wake_up_var(&ctx->refcount);
 	}
 }
 
@@ -5729,8 +5732,6 @@ int perf_event_release_kernel(struct perf_event *event)
 again:
 	mutex_lock(&event->child_mutex);
 	list_for_each_entry(child, &event->child_list, child_list) {
-		void *var = NULL;
-
 		/*
 		 * Cannot change, child events are not migrated, see the
 		 * comment with perf_event_ctx_lock_nested().
@@ -5765,40 +5766,20 @@ again:
 		if (tmp == child) {
 			perf_remove_from_context(child, DETACH_GROUP | DETACH_CHILD);
 			list_add(&child->child_list, &free_list);
-		} else {
-			var = &ctx->refcount;
 		}
 
 		mutex_unlock(&event->child_mutex);
 		mutex_unlock(&ctx->mutex);
 		put_ctx(ctx);
 
-		if (var) {
-			/*
-			 * If perf_event_free_task() has deleted all events from the
-			 * ctx while the child_mutex got released above, make sure to
-			 * notify about the preceding put_ctx().
-			 */
-			smp_mb(); /* pairs with wait_var_event() */
-			wake_up_var(var);
-		}
 		goto again;
 	}
 	mutex_unlock(&event->child_mutex);
 
 	list_for_each_entry_safe(child, tmp, &free_list, child_list) {
-		void *var = &child->ctx->refcount;
-
 		list_del(&child->child_list);
 		/* Last reference unless ->pending_task work is pending */
 		put_event(child);
-
-		/*
-		 * Wake any perf_event_free_task() waiting for this event to be
-		 * freed.
-		 */
-		smp_mb(); /* pairs with wait_var_event() */
-		wake_up_var(var);
 	}
 
 no_ctx:

