Return-Path: <linux-tip-commits+bounces-2670-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C268B9B7800
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 10:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1FD1F246AD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 09:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FE219AD4F;
	Thu, 31 Oct 2024 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KT1QcccF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jWneB0wU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE39199936;
	Thu, 31 Oct 2024 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368282; cv=none; b=a92KPcmBdRPyY9JocNchKRqksMWruq/wyg+HMuQjysz9sRuo3pGu09nqMJRFXPPNaIkFojwMxEbucebAWYEqFjNR0cqISp1tB4dh7FRh/vvSHFrWS3cBiPyvu/EfArL0nOws4uQ7Ttpy7pED6Cf6lXglAhsGVlAXH4V51jc4Svw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368282; c=relaxed/simple;
	bh=MrISod8T/BdGE5n0OIqds4heIUwnbkQ4K+WZcmW0Y7I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Gau9zn2o1uxUmLejVT5El02E2f72rKvTULSey/c1Dw1Qfo5IUykOVrFc6R574jDN+m9bh3zBRT9BULTuopzKpRbLsPwyH6LINIle3Z86QRT8MLWV7e4XeQVYoEiMfxjfREanqSMIo3mtwScR7twiRaCcSdlafEf+eB9DtPAnMms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KT1QcccF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jWneB0wU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 31 Oct 2024 09:51:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730368278;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jTP2WCyYzqTdUKjlVccE8sRmkfwGsiqBlaT86vbzmOs=;
	b=KT1QcccFLysHsdZG+tb9bb6PEIcOr+DgAmHOtcKlHafxRSBHQKL5Yz0s/ABq9Vxy1zmZ3D
	To0A6qVJ2eJLE5MiwPgFn0Jc8u7W1YAiubAYJdakKke2Y0RMFjUZV4LW0oJoylpbNK7GRW
	yZpiq7Go9DgRRtjD/Xd8r58GxV1sicmmCkx9yONd6mnOLRbw64PT4lehr0pVX1IPE28t5f
	wzgUx4QDY43GS41HPqT2/gen3eAIEe9P7m8vjuTUN7oE/krv/dYEa6KyevUzcQHttaG3se
	rTIrieKhw57ok8cOFWRx3gDPD9NT0LntbKs9MXuImCpl5Hjj2t43jFDin5Dfiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730368278;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jTP2WCyYzqTdUKjlVccE8sRmkfwGsiqBlaT86vbzmOs=;
	b=jWneB0wUC+yLNwgBKraVbnG76uJQCy7FQU24kRHgb8Bnh+/I+gPIuacwnTW7eJ0v4iaN/5
	Uv4nkawdyHZh/FAw==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick: Remove now unneeded low-res tick stop on
 CPUHP_AP_TICK_DYING
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241029125451.54574-4-frederic@kernel.org>
References: <20241029125451.54574-4-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173036827755.3137.4032410434012080208.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a6347864d97506a021c469dad35875088edc03fc
Gitweb:        https://git.kernel.org/tip/a6347864d97506a021c469dad35875088edc03fc
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 29 Oct 2024 13:54:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 31 Oct 2024 10:41:42 +01:00

tick: Remove now unneeded low-res tick stop on CPUHP_AP_TICK_DYING

The generic clockevent layer now detaches and stops the underlying
clockevent from the dying CPU, unifying the tick behaviour for both
periodic and oneshot mode on offline CPUs. There is no more need for
the tick layer to care about that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241029125451.54574-4-frederic@kernel.org

---
 kernel/time/tick-sched.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 753a184..9f90c73 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -311,14 +311,6 @@ static enum hrtimer_restart tick_nohz_handler(struct hrtimer *timer)
 	return HRTIMER_RESTART;
 }
 
-static void tick_sched_timer_cancel(struct tick_sched *ts)
-{
-	if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES))
-		hrtimer_cancel(&ts->sched_timer);
-	else if (tick_sched_flag_test(ts, TS_FLAG_NOHZ))
-		tick_program_event(KTIME_MAX, 1);
-}
-
 #ifdef CONFIG_NO_HZ_FULL
 cpumask_var_t tick_nohz_full_mask;
 EXPORT_SYMBOL_GPL(tick_nohz_full_mask);
@@ -1055,7 +1047,10 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	 * the tick timer.
 	 */
 	if (unlikely(expires == KTIME_MAX)) {
-		tick_sched_timer_cancel(ts);
+		if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES))
+			hrtimer_cancel(&ts->sched_timer);
+		else
+			tick_program_event(KTIME_MAX, 1);
 		return;
 	}
 
@@ -1604,21 +1599,13 @@ void tick_setup_sched_timer(bool hrtimer)
  */
 void tick_sched_timer_dying(int cpu)
 {
-	struct tick_device *td = &per_cpu(tick_cpu_device, cpu);
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
-	struct clock_event_device *dev = td->evtdev;
 	ktime_t idle_sleeptime, iowait_sleeptime;
 	unsigned long idle_calls, idle_sleeps;
 
 	/* This must happen before hrtimers are migrated! */
-	tick_sched_timer_cancel(ts);
-
-	/*
-	 * If the clockevents doesn't support CLOCK_EVT_STATE_ONESHOT_STOPPED,
-	 * make sure not to call low-res tick handler.
-	 */
-	if (tick_sched_flag_test(ts, TS_FLAG_NOHZ))
-		dev->event_handler = clockevents_handle_noop;
+	if (tick_sched_flag_test(ts, TS_FLAG_HIGHRES))
+		hrtimer_cancel(&ts->sched_timer);
 
 	idle_sleeptime = ts->idle_sleeptime;
 	iowait_sleeptime = ts->iowait_sleeptime;

