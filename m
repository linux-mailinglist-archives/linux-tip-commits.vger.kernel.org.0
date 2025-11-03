Return-Path: <linux-tip-commits+bounces-7167-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A73A7C2ABEB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 10:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89EFF4E8C78
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 09:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E152D8780;
	Mon,  3 Nov 2025 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wt+QSSYT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yLVCne96"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CC1DDA9;
	Mon,  3 Nov 2025 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162107; cv=none; b=XO5GAHEpGK+5FX/DgasvVNmlHs7pMh1oi5w8wnne46esZspnG3B6dQHE++vwC1+iUqvmzW1x1M+F9EMbdtq3mXUsBnTdZ+K9qWRgfEK4eXL5j19KLjJlrttLwK7ZkjAZvADxltaRjinM07RuvKz3jhYnBVS+3BJCOpXzcpETV/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162107; c=relaxed/simple;
	bh=cqU/xUK+o7hqrup51uwUOyK2P1SPFtx0FyiQGoBxy5s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qj5TaMbbY6QV1ujZK25Cpv3nJautx34ONE7e44wahgdCDqbY1XocJG7ihMwBqhtYt7pC3nl2FsibjJeeiS/lndE2bT7a7m86TjIQ01Lw6JToIrFeCpgpp3qZHBVWjE/lJg2DuzORNiqUoC9fXi1Z5qbnRQa/pmgpAlGa3BrENFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wt+QSSYT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yLVCne96; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 09:28:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762162097;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nH3CIAk6ZUOjMS94VjhEySqvrPmFA/4JuSKUr0NdArs=;
	b=wt+QSSYTxIAeE2WoHjGE0dv3N4OESAD5YbkC/dnU5Zdm164SN2YcAeSTEv9i+BCXYJmFo/
	ZIRp2fgnxB8NklXBHnSX0ZWQV/ZzsvOZWZNh4f+vxofLjIpjxpm9ZzYdX/urWANaTsVZ2/
	hrqSUiy6QAQwDbRjAB6LNLqf87KbDi4o8yZiRn15DOOSspRlH93OblyS1cxLjK0NMxs+7/
	5l0vq7MPrebPNqmp1T0dU/bTfntLsYLJEki9chAYFJmiLNiTxV5TmdXDQQdRkGEc1YHoVw
	HVcN9eMsal4Nr5S7xCQNJBmFWtR8KiEZd3tSQE7T2aNcaB6Jfcb2uNZEHwezLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762162097;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nH3CIAk6ZUOjMS94VjhEySqvrPmFA/4JuSKUr0NdArs=;
	b=yLVCne96yfUDA9PKHCppajKRWloxmKL52tu557hTty2pKejWgsstxw/jUXydMxpT5SsA4w
	HtkS8LxFLKLPV1Ag==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Fix system hang caused by cpu-clock
Cc: Octavia Togami <octavia.togami@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251015051828.12809-1-dapeng1.mi@linux.intel.com>
References: <20251015051828.12809-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176216209074.2601451.3260756182440410503.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     e33076f34f7a449c0e1808f15d88b2dd9a85979a
Gitweb:        https://git.kernel.org/tip/e33076f34f7a449c0e1808f15d88b2dd9a8=
5979a
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 15 Oct 2025 13:18:28 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 10:26:09 +01:00

perf: Fix system hang caused by cpu-clock

A system hang issue caused by cpu-clock is reported and bisection
indicates the commit 18dbcbfabfff ("perf: Fix the POLL_HUP delivery
 breakage") causes this issue.

The root cause of the hang issue is that cpu-clock is a specific SW
event which relies on the hrtimer. The __perf_event_overflow()
is invoked from the hrtimer handler for cpu-clock event, and
__perf_event_overflow() tries to call event stop callback
(cpu_clock_event_stop()) to stop the event, and cpu_clock_event_stop()
calls htimer_cancel() to cancel the hrtimer. But unfortunately the
hrtimer callback is currently executing and then traps into deadlock.

To avoid this deadlock, use hrtimer_try_to_cancel() instead of
hrtimer_cancel() to cancel the hrtimer, and set PERF_HES_STOPPED flag
for the stopping events. perf_swevent_hrtimer() would stop the event
hrtimer once it detects the PERF_HES_STOPPED flag.

Closes: https://lore.kernel.org/all/CAHPNGSQpXEopYreir+uDDEbtXTBvBvi8c6fYXJvc=
eqtgTPao3Q@mail.gmail.com/
Fixes: 18dbcbfabfff ("perf: Fix the POLL_HUP delivery breakage")
Reported-by: Octavia Togami <octavia.togami@gmail.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Octavia Togami <octavia.togami@gmail.com>
Link: https://patch.msgid.link/20251015051828.12809-1-dapeng1.mi@linux.intel.=
com
---
 kernel/events/core.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 177e57c..6e4af97 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11773,7 +11773,8 @@ static enum hrtimer_restart perf_swevent_hrtimer(stru=
ct hrtimer *hrtimer)
=20
 	event =3D container_of(hrtimer, struct perf_event, hw.hrtimer);
=20
-	if (event->state !=3D PERF_EVENT_STATE_ACTIVE)
+	if (event->state !=3D PERF_EVENT_STATE_ACTIVE ||
+	    event->hw.state & PERF_HES_STOPPED)
 		return HRTIMER_NORESTART;
=20
 	event->pmu->read(event);
@@ -11819,15 +11820,18 @@ static void perf_swevent_cancel_hrtimer(struct perf=
_event *event)
 	struct hw_perf_event *hwc =3D &event->hw;
=20
 	/*
-	 * The throttle can be triggered in the hrtimer handler.
-	 * The HRTIMER_NORESTART should be used to stop the timer,
-	 * rather than hrtimer_cancel(). See perf_swevent_hrtimer()
+	 * The event stop can be triggered in the hrtimer handler.
+	 * So use hrtimer_try_to_cancel() instead of hrtimer_cancel()
+	 * to stop the hrtimer() to avoid trapping into a dead loop.
+	 * Simultaneously the event would be set PERF_HES_STOPPED flag,
+	 * perf_swevent_hrtimer() would stop the event hrtimer once it
+	 * detects the PERF_HES_STOPPED flag.
 	 */
 	if (is_sampling_event(event) && (hwc->interrupts !=3D MAX_INTERRUPTS)) {
 		ktime_t remaining =3D hrtimer_get_remaining(&hwc->hrtimer);
 		local64_set(&hwc->period_left, ktime_to_ns(remaining));
=20
-		hrtimer_cancel(&hwc->hrtimer);
+		hrtimer_try_to_cancel(&hwc->hrtimer);
 	}
 }
=20
@@ -11871,12 +11875,14 @@ static void cpu_clock_event_update(struct perf_even=
t *event)
=20
 static void cpu_clock_event_start(struct perf_event *event, int flags)
 {
+	event->hw.state =3D 0;
 	local64_set(&event->hw.prev_count, local_clock());
 	perf_swevent_start_hrtimer(event);
 }
=20
 static void cpu_clock_event_stop(struct perf_event *event, int flags)
 {
+	event->hw.state =3D PERF_HES_STOPPED;
 	perf_swevent_cancel_hrtimer(event);
 	if (flags & PERF_EF_UPDATE)
 		cpu_clock_event_update(event);
@@ -11950,12 +11956,14 @@ static void task_clock_event_update(struct perf_eve=
nt *event, u64 now)
=20
 static void task_clock_event_start(struct perf_event *event, int flags)
 {
+	event->hw.state =3D 0;
 	local64_set(&event->hw.prev_count, event->ctx->time);
 	perf_swevent_start_hrtimer(event);
 }
=20
 static void task_clock_event_stop(struct perf_event *event, int flags)
 {
+	event->hw.state =3D PERF_HES_STOPPED;
 	perf_swevent_cancel_hrtimer(event);
 	if (flags & PERF_EF_UPDATE)
 		task_clock_event_update(event, event->ctx->time);

