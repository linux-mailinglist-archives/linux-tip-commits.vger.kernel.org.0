Return-Path: <linux-tip-commits+bounces-5769-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A21ADAD552A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 14:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0581BC14A6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 12:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B61F27CB16;
	Wed, 11 Jun 2025 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zWnJIqUG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="msODc+dw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024062E610F;
	Wed, 11 Jun 2025 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749644054; cv=none; b=NPq95zsDvHieWyHGSQmiLhWRgFYucF+aSMllNXbb49N4UieVzJdBn4e/ndtTWkAJsx7UNfT3uCIa23twRqoeMYEBapvqyK3O2FK2086tnRnAsFgCpC929UgmY6aluVl0UYUZ9F32ssGPlLE3BYnFGmn1c2n2BISvyqvt40B6EqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749644054; c=relaxed/simple;
	bh=61aDTTnt0gfL98ranD6ViaA9Dly6+I5sCCKE6B8cKY4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eTQHlPBRJWdJ2KN5a9RWC1MpiLB56J2PeKunYq7bPwGhE6LyNkCZ/WNuXVNeeclnr+dmdb9WLPPs9JXrS0JMJk5ipkrAJDr1AKMapAkNUeljwYGSvcVCKUScuycb8fcdr+p3svC/kfoxAiksOvMVIqxzJlW4gDEVvzk5IYcda1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zWnJIqUG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=msODc+dw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 12:14:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749644050;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLJNjzkKV5KVhwn3VgBgmvy6SLBgBFWTT2d+yJKRMmo=;
	b=zWnJIqUGIaJ9UfuYZuufe1JjFVu5ef9W8mgCp7EOsMIDc/I64QMRdkoObY9ImPy7jZdyAM
	2SiZn2c9kTjtY/+Oi9NiykprQ1CwNuRlWQqqhtbA4d1DpKN9581PNHBoK64Lh/lx0LLQZI
	tLuEa3pZWb6KOGD6SkjMV5E+2aJ377vV7otv4eTiKiNkFil7XvoV2QK2rhJBog1u1p6BSu
	P3b7AOidw9UJJjQlRI02RsN8kzQirJJKI4c66coXN5z/T7SqOXrx840fMfL9ddqV2mVnDY
	podn0VZx/oLcFuFmcRpXSmf60rAhZJjK62l/GGvBueqgb8MWe8lnChG7cgiL9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749644050;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLJNjzkKV5KVhwn3VgBgmvy6SLBgBFWTT2d+yJKRMmo=;
	b=msODc+dwqXZWqQiKthJCXOGTiwJHVR2z2gYfcyVV4Z056CgvxPMC7IqfezpMGoprDQDAtD
	p+vvh0peTO0B70Dw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fix the throttle error of some clock events
Cc: Leo Yan <leo.yan@arm.com>, Aishwarya TCV <aishwarya.tcv@arm.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Vince Weaver <vincent.weaver@maine.edu>,
 Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ian Rogers <irogers@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250606192546.915765-1-kan.liang@linux.intel.com>
References: <20250606192546.915765-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174964404970.406.8430049755633286598.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     bc4394e5e79cdda1b0997e0be1d65e242f523f02
Gitweb:        https://git.kernel.org/tip/bc4394e5e79cdda1b0997e0be1d65e242f523f02
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 06 Jun 2025 12:25:46 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 Jun 2025 14:05:08 +02:00

perf: Fix the throttle error of some clock events

Both ARM and IBM CI reports RCU stall, which can be reproduced by the
below perf command.
  perf record -a -e cpu-clock -- sleep 2

The issue is introduced by the generic throttle patch set, which
unconditionally invoke the event_stop() when throttle is triggered.

The cpu-clock and task-clock are two special SW events, which rely on
the hrtimer. The throttle is invoked in the hrtimer handler. The
event_stop()->hrtimer_cancel() waits for the handler to finish, which is
a deadlock. Instead of invoking the stop(), the HRTIMER_NORESTART should
be used to stop the timer.

There may be two ways to fix it:
 - Introduce a PMU flag to track the case. Avoid the event_stop in
   perf_event_throttle() if the flag is detected.
   It has been implemented in the
   https://lore.kernel.org/lkml/20250528175832.2999139-1-kan.liang@linux.intel.com/
   The new flag was thought to be an overkill for the issue.
 - Add a check in the event_stop. Return immediately if the throttle is
   invoked in the hrtimer handler. Rely on the existing HRTIMER_NORESTART
   method to stop the timer.

The latter is implemented here.

Move event->hw.interrupts = MAX_INTERRUPTS before the stop(). It makes
the order the same as perf_event_unthrottle(). Except the patch, no one
checks the hw.interrupts in the stop(). There is no impact from the
order change.

When stops in the throttle, the event should not be updated,
stop(event, 0). But the cpu_clock_event_stop() doesn't handle the flag.
In logic, it's wrong. But it didn't bring any problems with the old
code, because the stop() was not invoked when handling the throttle.
Checking the flag before updating the event.

Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
Closes: https://lore.kernel.org/lkml/20250527161656.GJ2566836@e132581.arm.com/
Closes: https://lore.kernel.org/lkml/djxlh5fx326gcenwrr52ry3pk4wxmugu4jccdjysza7tlc5fef@ktp4rffawgcw/
Closes: https://lore.kernel.org/lkml/8e8f51d8-af64-4d9e-934b-c0ee9f131293@linux.ibm.com/
Closes: https://lore.kernel.org/lkml/4ce106d0-950c-aadc-0b6a-f0215cd39913@maine.edu/
Reported-by: Leo Yan <leo.yan@arm.com>
Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Link: https://lkml.kernel.org/r/20250606192546.915765-1-kan.liang@linux.intel.com
---
 kernel/events/core.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d7cf008..1f74646 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2674,8 +2674,8 @@ static void perf_event_unthrottle(struct perf_event *event, bool start)
 
 static void perf_event_throttle(struct perf_event *event)
 {
-	event->pmu->stop(event, 0);
 	event->hw.interrupts = MAX_INTERRUPTS;
+	event->pmu->stop(event, 0);
 	if (event == event->group_leader)
 		perf_log_throttle(event, 0);
 }
@@ -11774,7 +11774,12 @@ static void perf_swevent_cancel_hrtimer(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (is_sampling_event(event)) {
+	/*
+	 * The throttle can be triggered in the hrtimer handler.
+	 * The HRTIMER_NORESTART should be used to stop the timer,
+	 * rather than hrtimer_cancel(). See perf_swevent_hrtimer()
+	 */
+	if (is_sampling_event(event) && (hwc->interrupts != MAX_INTERRUPTS)) {
 		ktime_t remaining = hrtimer_get_remaining(&hwc->hrtimer);
 		local64_set(&hwc->period_left, ktime_to_ns(remaining));
 
@@ -11829,7 +11834,8 @@ static void cpu_clock_event_start(struct perf_event *event, int flags)
 static void cpu_clock_event_stop(struct perf_event *event, int flags)
 {
 	perf_swevent_cancel_hrtimer(event);
-	cpu_clock_event_update(event);
+	if (flags & PERF_EF_UPDATE)
+		cpu_clock_event_update(event);
 }
 
 static int cpu_clock_event_add(struct perf_event *event, int flags)
@@ -11907,7 +11913,8 @@ static void task_clock_event_start(struct perf_event *event, int flags)
 static void task_clock_event_stop(struct perf_event *event, int flags)
 {
 	perf_swevent_cancel_hrtimer(event);
-	task_clock_event_update(event, event->ctx->time);
+	if (flags & PERF_EF_UPDATE)
+		task_clock_event_update(event, event->ctx->time);
 }
 
 static int task_clock_event_add(struct perf_event *event, int flags)

