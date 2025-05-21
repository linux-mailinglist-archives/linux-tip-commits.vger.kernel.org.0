Return-Path: <linux-tip-commits+bounces-5701-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B83ABF413
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 14:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DC127B35B5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC2126FA56;
	Wed, 21 May 2025 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r55ZXhOO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wWsLb+yf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4719526D4F0;
	Wed, 21 May 2025 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829768; cv=none; b=gEWaXfme1+HDJufuwj/ZJOw0AbP7lUmt5WHoq58oInbUO3ZlzxK79YJlgrao32eikyIcZu+MSYHmCWmofOOjp9K7eI8q6wdaml1MzBsuG07/3M8C5hYje0/Hpvibj9mEwPZvpStMOPN+okTaDljDj4ezVh1b/8uA1PPw1LjJVa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829768; c=relaxed/simple;
	bh=+oBtmZe0do1J2WFNBnWa7xMvSyHdjgGrAWuPPMK5eAc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u2sikG68ahN2IQ+CT4OExPae5wpt5SYuNblGS61zNFNnb2I+KLX1F2uZSUUBllc4CDDVFu47n/uevLA8Pu8i7xwVCZASDM49vIDjceKr+mn1ATCa/q22MIk9wwv7ewutrPscgVIKvg6ZcYIMV19HXmwfukO/KKcRAvIBhKBlPxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r55ZXhOO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wWsLb+yf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 12:16:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747829765;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xDCshOJhEgr6Y5VrkkOpPVJTtezay2AZVxVLm7f/hWI=;
	b=r55ZXhOOFSOKsRczwttrCEi57GSIh8vGof2KP1X06mGxy4AvGZg0uBbp1bRoOCEdhQSfDl
	eH041Uub7wXP5dVIho8qxqxWL+ywGKktM/GZ9416xxYSrooEBt7uE4WHcHp+D51ctfldxk
	PLWcvQYb9l6YYdWyg8TjJaGT4HKEI9sxEL1xfxx8ZdQKdwPiWEdDm71tBqFZiaoXW8P1cd
	Sn6sBIhpOeYTrx0kHToEfg4T34YNWb2v2Tx/M3u9gI3EtAwGhnWrdwj0FSNtRWB75LZ4vt
	PxGZwjRgDJgVSfLVLfICDxlj7JQmFZpxOc6wp2+KYbVHun9h4F44f2JTRcFPnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747829765;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xDCshOJhEgr6Y5VrkkOpPVJTtezay2AZVxVLm7f/hWI=;
	b=wWsLb+yf/7gNdWUl6V7wqH7gWI+cOFb8qF1HGIm+ZIv/YVC1jzk3UKxgxvDbIJ8bkW3fr9
	GcBCxLq97hSVLhCg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Fix the throttle logic for a group
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250520181644.2673067-2-kan.liang@linux.intel.com>
References: <20250520181644.2673067-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782976403.406.11916704121951822622.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9734e25fbf5ae68eb04234b2cd14a4b36ab89141
Gitweb:        https://git.kernel.org/tip/9734e25fbf5ae68eb04234b2cd14a4b36ab89141
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 20 May 2025 11:16:29 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 May 2025 13:57:42 +02:00

perf: Fix the throttle logic for a group

The current throttle logic doesn't work well with a group, e.g., the
following sampling-read case.

$ perf record -e "{cycles,cycles}:S" ...

$ perf report -D | grep THROTTLE | tail -2
            THROTTLE events:        426  ( 9.0%)
          UNTHROTTLE events:        425  ( 9.0%)

$ perf report -D | grep PERF_RECORD_SAMPLE -a4 | tail -n 5
0 1020120874009167 0x74970 [0x68]: PERF_RECORD_SAMPLE(IP, 0x1):
... sample_read:
.... group nr 2
..... id 0000000000000327, value 000000000cbb993a, lost 0
..... id 0000000000000328, value 00000002211c26df, lost 0

The second cycles event has a much larger value than the first cycles
event in the same group.

The current throttle logic in the generic code only logs the THROTTLE
event. It relies on the specific driver implementation to disable
events. For all ARCHs, the implementation is similar. Only the event is
disabled, rather than the group.

The logic to disable the group should be generic for all ARCHs. Add the
logic in the generic code. The following patch will remove the buggy
driver-specific implementation.

The throttle only happens when an event is overflowed. Stop the entire
group when any event in the group triggers the throttle.
The MAX_INTERRUPTS is set to all throttle events.

The unthrottled could happen in 3 places.
- event/group sched. All events in the group are scheduled one by one.
  All of them will be unthrottled eventually. Nothing needs to be
  changed.
- The perf_adjust_freq_unthr_events for each tick. Needs to restart the
  group altogether.
- The __perf_event_period(). The whole group needs to be restarted
  altogether as well.

With the fix,
$ sudo perf report -D | grep PERF_RECORD_SAMPLE -a4 | tail -n 5
0 3573470770332 0x12f5f8 [0x70]: PERF_RECORD_SAMPLE(IP, 0x2):
... sample_read:
.... group nr 2
..... id 0000000000000a28, value 00000004fd3dfd8f, lost 0
..... id 0000000000000a29, value 00000004fd3dfd8f, lost 0

Suggested-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20250520181644.2673067-2-kan.liang@linux.intel.com
---
 kernel/events/core.c | 66 +++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 20 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 952340f..8327ab0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2645,6 +2645,39 @@ void perf_event_disable_inatomic(struct perf_event *event)
 static void perf_log_throttle(struct perf_event *event, int enable);
 static void perf_log_itrace_start(struct perf_event *event);
 
+static void perf_event_unthrottle(struct perf_event *event, bool start)
+{
+	event->hw.interrupts = 0;
+	if (start)
+		event->pmu->start(event, 0);
+	perf_log_throttle(event, 1);
+}
+
+static void perf_event_throttle(struct perf_event *event)
+{
+	event->pmu->stop(event, 0);
+	event->hw.interrupts = MAX_INTERRUPTS;
+	perf_log_throttle(event, 0);
+}
+
+static void perf_event_unthrottle_group(struct perf_event *event, bool skip_start_event)
+{
+	struct perf_event *sibling, *leader = event->group_leader;
+
+	perf_event_unthrottle(leader, skip_start_event ? leader != event : true);
+	for_each_sibling_event(sibling, leader)
+		perf_event_unthrottle(sibling, skip_start_event ? sibling != event : true);
+}
+
+static void perf_event_throttle_group(struct perf_event *event)
+{
+	struct perf_event *sibling, *leader = event->group_leader;
+
+	perf_event_throttle(leader);
+	for_each_sibling_event(sibling, leader)
+		perf_event_throttle(sibling);
+}
+
 static int
 event_sched_in(struct perf_event *event, struct perf_event_context *ctx)
 {
@@ -2673,10 +2706,8 @@ event_sched_in(struct perf_event *event, struct perf_event_context *ctx)
 	 * ticks already, also for a heavily scheduling task there is little
 	 * guarantee it'll get a tick in a timely manner.
 	 */
-	if (unlikely(event->hw.interrupts == MAX_INTERRUPTS)) {
-		perf_log_throttle(event, 1);
-		event->hw.interrupts = 0;
-	}
+	if (unlikely(event->hw.interrupts == MAX_INTERRUPTS))
+		perf_event_unthrottle(event, false);
 
 	perf_pmu_disable(event->pmu);
 
@@ -4254,12 +4285,8 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 
 		hwc = &event->hw;
 
-		if (hwc->interrupts == MAX_INTERRUPTS) {
-			hwc->interrupts = 0;
-			perf_log_throttle(event, 1);
-			if (!is_event_in_freq_mode(event))
-				event->pmu->start(event, 0);
-		}
+		if (hwc->interrupts == MAX_INTERRUPTS)
+			perf_event_unthrottle_group(event, is_event_in_freq_mode(event));
 
 		if (!is_event_in_freq_mode(event))
 			continue;
@@ -6181,14 +6208,6 @@ static void __perf_event_period(struct perf_event *event,
 	active = (event->state == PERF_EVENT_STATE_ACTIVE);
 	if (active) {
 		perf_pmu_disable(event->pmu);
-		/*
-		 * We could be throttled; unthrottle now to avoid the tick
-		 * trying to unthrottle while we already re-started the event.
-		 */
-		if (event->hw.interrupts == MAX_INTERRUPTS) {
-			event->hw.interrupts = 0;
-			perf_log_throttle(event, 1);
-		}
 		event->pmu->stop(event, PERF_EF_UPDATE);
 	}
 
@@ -6196,6 +6215,14 @@ static void __perf_event_period(struct perf_event *event,
 
 	if (active) {
 		event->pmu->start(event, PERF_EF_RELOAD);
+		/*
+		 * Once the period is force-reset, the event starts immediately.
+		 * But the event/group could be throttled. Unthrottle the
+		 * event/group now to avoid the next tick trying to unthrottle
+		 * while we already re-started the event/group.
+		 */
+		if (event->hw.interrupts == MAX_INTERRUPTS)
+			perf_event_unthrottle_group(event, true);
 		perf_pmu_enable(event->pmu);
 	}
 }
@@ -10084,8 +10111,7 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
 	if (unlikely(throttle && hwc->interrupts >= max_samples_per_tick)) {
 		__this_cpu_inc(perf_throttled_count);
 		tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
-		hwc->interrupts = MAX_INTERRUPTS;
-		perf_log_throttle(event, 0);
+		perf_event_throttle_group(event);
 		ret = 1;
 	}
 

