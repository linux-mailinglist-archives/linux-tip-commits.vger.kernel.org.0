Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE03041ECF5
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Oct 2021 14:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354266AbhJAMMN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Oct 2021 08:12:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56860 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354146AbhJAMMM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Oct 2021 08:12:12 -0400
Date:   Fri, 01 Oct 2021 12:10:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633090227;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qgSO1gYP6OdxHsaHKv1ocaPwS7z63I+4pVPOHUhHFT4=;
        b=3d4WKCR02OE9V2nIMBUafisjzbznntcyq9n6eMELTpP48TO1tAVQiK2NbToLzWhP8gIgDX
        eHZ2KYypTnf76ZDki+hSK9Fy+ezLTpOZD3Zaq3mL6v4w5jR3H0O0jZtlNDp7up75JQHvbL
        E1jL4I6fZu0FkM3ixvQjL0g9gY2i+/BUZB/8jAed5SJVn9mZBQ+HFwOzLGJH1lLLasWDk9
        fHoHySySlU+ViPKqeQ7BkHCrp9BNX0wpGH8QGTqrJ5JqRz76Y6ti+3v16mxZrD7qsQmQuI
        l7xz7ysWOvWBUXPdolbrdWaLHThhIBtPxu18LmEu4dOzrs+J4aMBCej0sz3shg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633090227;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qgSO1gYP6OdxHsaHKv1ocaPwS7z63I+4pVPOHUhHFT4=;
        b=PQW3hX93Em3C2XgKeG3rZLKwa5AS2qG3xDhVYGH++Gf3PBF2v/787RjlGLPm3qoq9DFMcS
        M6SKu49xLKIcu7DA==
From:   "tip-bot2 for Song Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: fix userpage->time_enabled of inactive events
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Lucian Grijincu <lucian@fb.com>,
        Song Liu <songliubraving@fb.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210929194313.2398474-1-songliubraving@fb.com>
References: <20210929194313.2398474-1-songliubraving@fb.com>
MIME-Version: 1.0
Message-ID: <163309022618.25758.13887730467609744977.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     f792565326825ed806626da50c6f9a928f1079c1
Gitweb:        https://git.kernel.org/tip/f792565326825ed806626da50c6f9a928f1079c1
Author:        Song Liu <songliubraving@fb.com>
AuthorDate:    Wed, 29 Sep 2021 12:43:13 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 Oct 2021 13:57:54 +02:00

perf/core: fix userpage->time_enabled of inactive events

Users of rdpmc rely on the mmapped user page to calculate accurate
time_enabled. Currently, userpage->time_enabled is only updated when the
event is added to the pmu. As a result, inactive event (due to counter
multiplexing) does not have accurate userpage->time_enabled. This can
be reproduced with something like:

   /* open 20 task perf_event "cycles", to create multiplexing */

   fd = perf_event_open();  /* open task perf_event "cycles" */
   userpage = mmap(fd);     /* use mmap and rdmpc */

   while (true) {
     time_enabled_mmap = xxx; /* use logic in perf_event_mmap_page */
     time_enabled_read = read(fd).time_enabled;
     if (time_enabled_mmap > time_enabled_read)
         BUG();
   }

Fix this by updating userpage for inactive events in merge_sched_in.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reported-and-tested-by: Lucian Grijincu <lucian@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210929194313.2398474-1-songliubraving@fb.com
---
 include/linux/perf_event.h |  4 +++-
 kernel/events/core.c       | 34 ++++++++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fe156a8..9b60bb8 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -683,7 +683,9 @@ struct perf_event {
 	/*
 	 * timestamp shadows the actual context timing but it can
 	 * be safely used in NMI interrupt context. It reflects the
-	 * context time as it was when the event was last scheduled in.
+	 * context time as it was when the event was last scheduled in,
+	 * or when ctx_sched_in failed to schedule the event because we
+	 * run out of PMC.
 	 *
 	 * ctx_time already accounts for ctx->timestamp. Therefore to
 	 * compute ctx_time for a sample, simply add perf_clock().
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0c000cb..f23ca26 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3707,6 +3707,29 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 	return 0;
 }
 
+static inline bool event_update_userpage(struct perf_event *event)
+{
+	if (likely(!atomic_read(&event->mmap_count)))
+		return false;
+
+	perf_event_update_time(event);
+	perf_set_shadow_time(event, event->ctx);
+	perf_event_update_userpage(event);
+
+	return true;
+}
+
+static inline void group_update_userpage(struct perf_event *group_event)
+{
+	struct perf_event *event;
+
+	if (!event_update_userpage(group_event))
+		return;
+
+	for_each_sibling_event(event, group_event)
+		event_update_userpage(event);
+}
+
 static int merge_sched_in(struct perf_event *event, void *data)
 {
 	struct perf_event_context *ctx = event->ctx;
@@ -3725,14 +3748,15 @@ static int merge_sched_in(struct perf_event *event, void *data)
 	}
 
 	if (event->state == PERF_EVENT_STATE_INACTIVE) {
+		*can_add_hw = 0;
 		if (event->attr.pinned) {
 			perf_cgroup_event_disable(event, ctx);
 			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
+		} else {
+			ctx->rotate_necessary = 1;
+			perf_mux_hrtimer_restart(cpuctx);
+			group_update_userpage(event);
 		}
-
-		*can_add_hw = 0;
-		ctx->rotate_necessary = 1;
-		perf_mux_hrtimer_restart(cpuctx);
 	}
 
 	return 0;
@@ -6324,6 +6348,8 @@ accounting:
 
 		ring_buffer_attach(event, rb);
 
+		perf_event_update_time(event);
+		perf_set_shadow_time(event, event->ctx);
 		perf_event_init_userpage(event);
 		perf_event_update_userpage(event);
 	} else {
