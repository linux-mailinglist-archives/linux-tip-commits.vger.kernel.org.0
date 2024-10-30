Return-Path: <linux-tip-commits+bounces-2660-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8809B6D6A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 21:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14ED21C22183
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 20:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692DB21730A;
	Wed, 30 Oct 2024 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lKQuul6Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BU3b7Jp/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E071EF94E;
	Wed, 30 Oct 2024 20:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319220; cv=none; b=qjmLUcNPWX+RvcQxfRQk/T2BSvfO9Hno7wc8S67qRADqnTn0dCM9ruHrWCY7utArD0iBvJQltn5UdwBJlrmnOP+oeK1Hf2BmHWzTHl9EJAe7J5qHhPueyymEn4FIQ2DKKIdA5vBBfAMKxvEKZldGiliuo3BKwAx9iU7E6L/uRAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319220; c=relaxed/simple;
	bh=lj+sXBx8nWTeMnBLut2LIZB76h7aR9FsewXtIuYlm58=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LqAG9rnNmWlFzVE+ZrZ/hF4N+5lZH2n2EQPXFZIBoEdBavV0FtiRbimbowsk0Q5loOPJFuCIWifnLXoR5Z5nNGxCNAd49FZ9WwOa8pRBpRWiSdhpnwowaVH5HuqI9EpWUZD7INfgTYyg6+5VPZHexXiJTikuPrg5K/8vD1SX/pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lKQuul6Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BU3b7Jp/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Oct 2024 20:13:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730319216;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xonCZbVQbI31a5RtB9uKzcQDiRhfRwtlIdj0EIuPnDo=;
	b=lKQuul6QEL9ggNaq1Hv1zvYs6ZUZhcNSEM6twZRxhFm81bUedV1FlC+xnRumLRak2PMGPn
	7SUBeO63e/4PjQ2pi1O/BvYOLPsI/k+tG/0VD4XMfuxZza2x2XZ8/bC95MCxewp/R1hlYX
	wjKV3ixXxyPNacoigfMYmaBac4Z0YLHClJpotbBXVfmZkg3pPiBED1JEFvZFS5EZInifUC
	P20IUiRc2CRDwuaK3I1B6Xm/0jot52R2PBNRFQacLDKO78Yk84hhnaSDuO5/lfrHK+c6Gp
	iozl1/J8XleN8wfulcjvmeROErYEyFaueBchlrf2bEIG/XSjoGHSVxQEkq8wFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730319216;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xonCZbVQbI31a5RtB9uKzcQDiRhfRwtlIdj0EIuPnDo=;
	b=BU3b7Jp/fRf8KrhclGzO82YIF8v+LWxCVjY2v3MUZhslzhJLq0/UDMGmrf4ftDu0W7P3fb
	zN7MqTdsS3D8PkCQ==
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
Message-ID: <173031921560.3137.4866385852385141081.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8d7784373a498aaeed597edaefda35fe40162e5d
Gitweb:        https://git.kernel.org/tip/8d7784373a498aaeed597edaefda35fe40162e5d
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 29 Oct 2024 13:54:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 30 Oct 2024 21:02:21 +01:00

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

