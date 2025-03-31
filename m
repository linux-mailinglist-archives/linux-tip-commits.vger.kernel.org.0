Return-Path: <linux-tip-commits+bounces-4594-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA34A76508
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 Mar 2025 13:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3CAE1689B1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 Mar 2025 11:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF651DE4FF;
	Mon, 31 Mar 2025 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B19hZUae";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8kbybUw0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E221189F36;
	Mon, 31 Mar 2025 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743420980; cv=none; b=q8kLTygcnGEk3l9XqqA8tJzufgoQUZIhXIjfTNSyoMLWLjLSPfIMiKfhu0oD1wDFRJ/eQU4UF8uxVnekubEyQ0T0xOSwTQ41DfAb5Rh8qzRAX9/1M9b3gUe//92eHLZzoOVQX+uiFxH3UDP1IEZ5+VUX8FLW/aIMyCNBCvA403k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743420980; c=relaxed/simple;
	bh=pF56YOqlTVhNvsegl9hLUU+hjxXkWHtyCd2UpHXKUX8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KlxqTa0x1YyUmL45HzL7xreP9BheiOnOF/mQ8iP2F4DFNI5eijxw9RuCK5Eg8Vy6rDg80E/XKC8Jg5x6rniav1OeGB7I0hxJEPK55WgJ4KEL+SXHESIzr95D4jIP/G70gJ1PuLJtM0PZsRPneXVZaANkHfMV0cO6k6ucscAaEXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B19hZUae; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8kbybUw0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 31 Mar 2025 11:36:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743420976;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XAJSsbuA2Jnaqrp1DXgyl741m+tb9aiTC3SD1GfWow4=;
	b=B19hZUaeH+sPJqFN2uPYPdnRG8ogBezgV0SyNS2LCv3eUQWi2puJHiKVUxAU7RE2b7TOY+
	gsI6nQzAUWKtp3UIc8C8J7ABSdENMFYFis1Z4hTNJXiPcNM7q5S566WRB1naS7PDkmOAqI
	zn4FoEFKmrAjxsNnRHgzAT/aGBvNMbRLiO+sNiVIdbVQgfrVCdhT8uDBUxrnPnmFzwSkQ2
	mVsGIO3z9SUXNDSdk8P4t/LlbSiNjJPuXcNYe+ZoqSSegGQzomMHkVCn8WqrMJYUB8M/oD
	vZ/Qd+M+pQn1xXIDHAL1h5FY7x04Nj72esRcs+CuqM3xIq4Mo/83kCxVIDpcgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743420976;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XAJSsbuA2Jnaqrp1DXgyl741m+tb9aiTC3SD1GfWow4=;
	b=8kbybUw06qV1j1dM9ZFX9+Ef5YsbS7SP4xY/IMly782tNL2UZrOP7foa62I+EGz9pK4BTB
	eO0mQuvRAI+ETWAQ==
From: "tip-bot2 for Yeoreum Yun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix child_total_time_enabled accounting
 bug at task exit
Cc: Peter Zijlstra <peterz@infradead.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 Ingo Molnar <mingo@kernel.org>, Leo Yan <leo.yan@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250326082003.1630986-1-yeoreum.yun@arm.com>
References: <20250326082003.1630986-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174342097143.14745.6007783850854411758.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     a3c3c66670cee11eb13aa43905904bf29cb92d32
Gitweb:        https://git.kernel.org/tip/a3c3c66670cee11eb13aa43905904bf29cb92d32
Author:        Yeoreum Yun <yeoreum.yun@arm.com>
AuthorDate:    Wed, 26 Mar 2025 08:20:03 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 31 Mar 2025 12:57:38 +02:00

perf/core: Fix child_total_time_enabled accounting bug at task exit

The perf events code fails to account for total_time_enabled of
inactive events.

Here is a failure case for accounting total_time_enabled for
CPU PMU events:

  sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 2s
  ...

  armv8_pmuv3_0/event=0x08/: 1138698008 2289429840 2174835740
  armv8_pmuv3_1/event=0x08/: 1826791390 1950025700 847648440
                             `          `          `
                             `          `          > total_time_running with child
                             `          > total_time_enabled with child
                             > count with child

  Performance counter stats for 'stress-ng --pthread=2 -t 2s':

       1,138,698,008      armv8_pmuv3_0/event=0x08/                                               (94.99%)
       1,826,791,390      armv8_pmuv3_1/event=0x08/                                               (43.47%)

The two events above are opened on two different CPU PMUs, for example,
each event is opened for a cluster in an Arm big.LITTLE system, they
will never run on the same CPU.  In theory, the total enabled time should
be same for both events, as two events are opened and closed together.

As the result show, the two events' total enabled time including
child event is different (2289429840 vs 1950025700).

This is because child events are not accounted properly
if a event is INACTIVE state when the task exits:

  perf_event_exit_event()
   `> perf_remove_from_context()
     `> __perf_remove_from_context()
       `> perf_child_detach()   -> Accumulate child_total_time_enabled
         `> list_del_event()    -> Update child event's time

The problem is the time accumulation happens prior to child event's
time updating. Thus, it misses to account the last period's time when
the event exits.

The perf core layer follows the rule that timekeeping is tied to state
change. To address the issue, make __perf_remove_from_context()
handle the task exit case by passing 'DETACH_EXIT' to it and
invoke perf_event_state() for state alongside with accounting the time.

Then, perf_child_detach() populates the time into the parent's time metrics.

After this patch, the bug is fixed:

  sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 10s
  ...
  armv8_pmuv3_0/event=0x08/: 15396770398 32157963940 21898169000
  armv8_pmuv3_1/event=0x08/: 22428964974 32157963940 10259794940

   Performance counter stats for 'stress-ng --pthread=2 -t 10s':

      15,396,770,398      armv8_pmuv3_0/event=0x08/                                               (68.10%)
      22,428,964,974      armv8_pmuv3_1/event=0x08/                                               (31.90%)

[ mingo: Clarified the changelog. ]

Fixes: ef54c1a476aef ("perf: Rework perf_event_exit_event()")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Leo Yan <leo.yan@arm.com>
Link: https://lore.kernel.org/r/20250326082003.1630986-1-yeoreum.yun@arm.com
---
 kernel/events/core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0bb2165..128db74 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2451,6 +2451,7 @@ ctx_time_update_event(struct perf_event_context *ctx, struct perf_event *event)
 #define DETACH_GROUP	0x01UL
 #define DETACH_CHILD	0x02UL
 #define DETACH_DEAD	0x04UL
+#define DETACH_EXIT	0x08UL
 
 /*
  * Cross CPU call to remove a performance event
@@ -2465,6 +2466,7 @@ __perf_remove_from_context(struct perf_event *event,
 			   void *info)
 {
 	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
+	enum perf_event_state state = PERF_EVENT_STATE_OFF;
 	unsigned long flags = (unsigned long)info;
 
 	ctx_time_update(cpuctx, ctx);
@@ -2473,16 +2475,19 @@ __perf_remove_from_context(struct perf_event *event,
 	 * Ensure event_sched_out() switches to OFF, at the very least
 	 * this avoids raising perf_pending_task() at this time.
 	 */
-	if (flags & DETACH_DEAD)
+	if (flags & DETACH_EXIT)
+		state = PERF_EVENT_STATE_EXIT;
+	if (flags & DETACH_DEAD) {
 		event->pending_disable = 1;
+		state = PERF_EVENT_STATE_DEAD;
+	}
 	event_sched_out(event, ctx);
+	perf_event_set_state(event, min(event->state, state));
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	if (flags & DETACH_CHILD)
 		perf_child_detach(event);
 	list_del_event(event, ctx);
-	if (flags & DETACH_DEAD)
-		event->state = PERF_EVENT_STATE_DEAD;
 
 	if (!pmu_ctx->nr_events) {
 		pmu_ctx->rotate_necessary = 0;
@@ -13731,12 +13736,7 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 		mutex_lock(&parent_event->child_mutex);
 	}
 
-	perf_remove_from_context(event, detach_flags);
-
-	raw_spin_lock_irq(&ctx->lock);
-	if (event->state > PERF_EVENT_STATE_EXIT)
-		perf_event_set_state(event, PERF_EVENT_STATE_EXIT);
-	raw_spin_unlock_irq(&ctx->lock);
+	perf_remove_from_context(event, detach_flags | DETACH_EXIT);
 
 	/*
 	 * Child events can be freed.

