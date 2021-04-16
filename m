Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3E9362677
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 19:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbhDPROS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 13:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239937AbhDPROR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 13:14:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71CEC06175F;
        Fri, 16 Apr 2021 10:13:52 -0700 (PDT)
Date:   Fri, 16 Apr 2021 17:13:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618593224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=InyXIyjhgo0jO8MFVne6xHBVGJwGp5noHp0pOe6BVuA=;
        b=1eeZ7IbYXgFfvozoiqlf9F6pHXcqoyw+Rpwd+V83jt4MbkNWhPM650nJ4KqJEYyIIfYoNV
        DWrK0JFx2En/HUSx/K8dDust8FDwFrWXwCHszhr7xklc5h8tDhly3e1vmTZOhblO+ZIRYe
        Fn9i98LQiVIf+CRNBHu68y8kFMr1KRMzMYLAkXXfkO7F0cNRgEBVlQ5RX8Y2PBc6LeOIid
        y2nP8ANGx9FO7X73AJdSoLWy+2ovmTJSUtXKrfByTSR9lMGrrc1Fo2dIwBXTZznAhytnQ2
        Guy/Ncl6asnO7ALGwaqwGf+VlUyg1vJiNawofrgsE/GPOKBY+znWUu4crcjDzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618593224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=InyXIyjhgo0jO8MFVne6xHBVGJwGp5noHp0pOe6BVuA=;
        b=RaZunMwgGLkY0lFcQll8QXL7xuuoY3mn3Oqf6MdptYBAlRbc2eeaitsY0f60f/+7PpMUjw
        PLpDk9RR1EJKOrCw==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf core: Factor out __perf_sw_event_sched
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210210083327.22726-1-namhyung@kernel.org>
References: <20210210083327.22726-1-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <161859322409.29796.10758350786737842233.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7c8056bb366b1b2dc8e4a3cc0b876e15a8ebca2c
Gitweb:        https://git.kernel.org/tip/7c8056bb366b1b2dc8e4a3cc0b876e15a8ebca2c
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Wed, 10 Feb 2021 17:33:25 +09:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 18:58:52 +02:00

perf core: Factor out __perf_sw_event_sched

In some cases, we need to check more than whether the software event
is enabled.  So split the condition check and the actual event
handling.  This is a preparation for the next change.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210210083327.22726-1-namhyung@kernel.org
---
 include/linux/perf_event.h | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7d7280a..92d51a7 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1178,30 +1178,24 @@ DECLARE_PER_CPU(struct pt_regs, __perf_regs[4]);
  * which is guaranteed by us not actually scheduling inside other swevents
  * because those disable preemption.
  */
-static __always_inline void
-perf_sw_event_sched(u32 event_id, u64 nr, u64 addr)
+static __always_inline void __perf_sw_event_sched(u32 event_id, u64 nr, u64 addr)
 {
-	if (static_key_false(&perf_swevent_enabled[event_id])) {
-		struct pt_regs *regs = this_cpu_ptr(&__perf_regs[0]);
+	struct pt_regs *regs = this_cpu_ptr(&__perf_regs[0]);
 
-		perf_fetch_caller_regs(regs);
-		___perf_sw_event(event_id, nr, regs, addr);
-	}
+	perf_fetch_caller_regs(regs);
+	___perf_sw_event(event_id, nr, regs, addr);
 }
 
 extern struct static_key_false perf_sched_events;
 
-static __always_inline bool
-perf_sw_migrate_enabled(void)
+static __always_inline bool __perf_sw_enabled(int swevt)
 {
-	if (static_key_false(&perf_swevent_enabled[PERF_COUNT_SW_CPU_MIGRATIONS]))
-		return true;
-	return false;
+	return static_key_false(&perf_swevent_enabled[swevt]);
 }
 
 static inline void perf_event_task_migrate(struct task_struct *task)
 {
-	if (perf_sw_migrate_enabled())
+	if (__perf_sw_enabled(PERF_COUNT_SW_CPU_MIGRATIONS))
 		task->sched_migrated = 1;
 }
 
@@ -1211,11 +1205,9 @@ static inline void perf_event_task_sched_in(struct task_struct *prev,
 	if (static_branch_unlikely(&perf_sched_events))
 		__perf_event_task_sched_in(prev, task);
 
-	if (perf_sw_migrate_enabled() && task->sched_migrated) {
-		struct pt_regs *regs = this_cpu_ptr(&__perf_regs[0]);
-
-		perf_fetch_caller_regs(regs);
-		___perf_sw_event(PERF_COUNT_SW_CPU_MIGRATIONS, 1, regs, 0);
+	if (__perf_sw_enabled(PERF_COUNT_SW_CPU_MIGRATIONS) &&
+	    task->sched_migrated) {
+		__perf_sw_event_sched(PERF_COUNT_SW_CPU_MIGRATIONS, 1, 0);
 		task->sched_migrated = 0;
 	}
 }
@@ -1223,7 +1215,8 @@ static inline void perf_event_task_sched_in(struct task_struct *prev,
 static inline void perf_event_task_sched_out(struct task_struct *prev,
 					     struct task_struct *next)
 {
-	perf_sw_event_sched(PERF_COUNT_SW_CONTEXT_SWITCHES, 1, 0);
+	if (__perf_sw_enabled(PERF_COUNT_SW_CONTEXT_SWITCHES))
+		__perf_sw_event_sched(PERF_COUNT_SW_CONTEXT_SWITCHES, 1, 0);
 
 	if (static_branch_unlikely(&perf_sched_events))
 		__perf_event_task_sched_out(prev, next);
@@ -1480,8 +1473,6 @@ static inline int perf_event_refresh(struct perf_event *event, int refresh)
 static inline void
 perf_sw_event(u32 event_id, u64 nr, struct pt_regs *regs, u64 addr)	{ }
 static inline void
-perf_sw_event_sched(u32 event_id, u64 nr, u64 addr)			{ }
-static inline void
 perf_bp_event(struct perf_event *event, void *data)			{ }
 
 static inline int perf_register_guest_info_callbacks
