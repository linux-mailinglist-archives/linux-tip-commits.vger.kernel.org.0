Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E1D362356
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 17:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245102AbhDPPCT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 11:02:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57832 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245208AbhDPPCQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 11:02:16 -0400
Date:   Fri, 16 Apr 2021 15:01:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618585311;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q5p/HiBBoL8SnE05EfvmU4VLP0k7Rt1yt5rj7nPNHJ0=;
        b=lZbYnesmlPzZHGVFWB27TSsHK35UW4wVOYPj/6Pbx8kFykpfQIavFO4sNXyPqO65msPWTH
        ERgEiXP2agDURt7nUcKRAsly+zc8vPWHlopAkX0qanbF9LXKSfJ/KfyX1atwK8MqFVOW7C
        YvpvPB55m0hktWRnoBE5jEEjKNniijE8zuAvHllEiPx8iHXUQeycwBh+QmeYAGL9FA7fdY
        E4KaHTzAio/iIfZ99HqSJ05ePkhzJDiDG79SIktydqYvGiJjcOC+FRtgLlX7M0RjJ/p5qF
        7MAJ3bAlZHZ8NrHZXL+b/+lcWiIlQsdUGVInhIbBbP5IUCiIavJqD009kkSFkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618585311;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q5p/HiBBoL8SnE05EfvmU4VLP0k7Rt1yt5rj7nPNHJ0=;
        b=ImkdTYUbx6bFMfKN1MRHIXi6MF3BJVrQ2CZyTLEN6ztvC3GwLKq52DZ+tA1ZlSjHw589h0
        HOQVTU8+iGXePPCw==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Add support for event removal on exec
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210408103605.1676875-5-elver@google.com>
References: <20210408103605.1676875-5-elver@google.com>
MIME-Version: 1.0
Message-ID: <161858531071.29796.4506820814392849055.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2e498d0a74e5b88a6689ae1b811f247f91ff188e
Gitweb:        https://git.kernel.org/tip/2e498d0a74e5b88a6689ae1b811f247f91ff188e
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 08 Apr 2021 12:35:59 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 16:32:41 +02:00

perf: Add support for event removal on exec

Adds bit perf_event_attr::remove_on_exec, to support removing an event
from a task on exec.

This option supports the case where an event is supposed to be
process-wide only, and should not propagate beyond exec, to limit
monitoring to the original process image only.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210408103605.1676875-5-elver@google.com
---
 include/uapi/linux/perf_event.h |  3 +-
 kernel/events/core.c            | 70 ++++++++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 813efb6..8c5b9f5 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -390,7 +390,8 @@ struct perf_event_attr {
 				text_poke      :  1, /* include text poke events */
 				build_id       :  1, /* use build id in mmap2 events */
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
-				__reserved_1   : 28;
+				remove_on_exec :  1, /* event is removed from task on exec */
+				__reserved_1   : 27;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3e3c00f..e4a584b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4248,6 +4248,57 @@ out:
 		put_ctx(clone_ctx);
 }
 
+static void perf_remove_from_owner(struct perf_event *event);
+static void perf_event_exit_event(struct perf_event *event,
+				  struct perf_event_context *ctx);
+
+/*
+ * Removes all events from the current task that have been marked
+ * remove-on-exec, and feeds their values back to parent events.
+ */
+static void perf_event_remove_on_exec(int ctxn)
+{
+	struct perf_event_context *ctx, *clone_ctx = NULL;
+	struct perf_event *event, *next;
+	LIST_HEAD(free_list);
+	unsigned long flags;
+	bool modified = false;
+
+	ctx = perf_pin_task_context(current, ctxn);
+	if (!ctx)
+		return;
+
+	mutex_lock(&ctx->mutex);
+
+	if (WARN_ON_ONCE(ctx->task != current))
+		goto unlock;
+
+	list_for_each_entry_safe(event, next, &ctx->event_list, event_entry) {
+		if (!event->attr.remove_on_exec)
+			continue;
+
+		if (!is_kernel_event(event))
+			perf_remove_from_owner(event);
+
+		modified = true;
+
+		perf_event_exit_event(event, ctx);
+	}
+
+	raw_spin_lock_irqsave(&ctx->lock, flags);
+	if (modified)
+		clone_ctx = unclone_ctx(ctx);
+	--ctx->pin_count;
+	raw_spin_unlock_irqrestore(&ctx->lock, flags);
+
+unlock:
+	mutex_unlock(&ctx->mutex);
+
+	put_ctx(ctx);
+	if (clone_ctx)
+		put_ctx(clone_ctx);
+}
+
 struct perf_read_data {
 	struct perf_event *event;
 	bool group;
@@ -7560,18 +7611,18 @@ void perf_event_exec(void)
 	struct perf_event_context *ctx;
 	int ctxn;
 
-	rcu_read_lock();
 	for_each_task_context_nr(ctxn) {
-		ctx = current->perf_event_ctxp[ctxn];
-		if (!ctx)
-			continue;
-
 		perf_event_enable_on_exec(ctxn);
+		perf_event_remove_on_exec(ctxn);
 
-		perf_iterate_ctx(ctx, perf_event_addr_filters_exec, NULL,
-				   true);
+		rcu_read_lock();
+		ctx = rcu_dereference(current->perf_event_ctxp[ctxn]);
+		if (ctx) {
+			perf_iterate_ctx(ctx, perf_event_addr_filters_exec,
+					 NULL, true);
+		}
+		rcu_read_unlock();
 	}
-	rcu_read_unlock();
 }
 
 struct remote_output {
@@ -11656,6 +11707,9 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	if (!attr->inherit && attr->inherit_thread)
 		return -EINVAL;
 
+	if (attr->remove_on_exec && attr->enable_on_exec)
+		return -EINVAL;
+
 out:
 	return ret;
 
