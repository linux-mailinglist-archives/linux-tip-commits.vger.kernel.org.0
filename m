Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718133E7D06
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 18:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236181AbhHJQCp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 12:02:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44420 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbhHJQCl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 12:02:41 -0400
Date:   Tue, 10 Aug 2021 16:02:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628611339;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hD70kUOOwUKFS0CQcQn+oO9HeHzcsKrNCkLHKc4xjAQ=;
        b=TF7ddWQToU3Lgud/yPPNc8Fxyh+YczzOqB5Jd1tcH7b5fKfyOFxYoiuprh/I1D0XzzbGC7
        a8T/q4cKrp5SBWUW2Zwh/Vox4rr3e1lOZFe+rnYech1EsiStgTewV5BOlDymODRpAeJHK8
        LSFaJ/I4Tx3bNXunYjTaBIrh3+tkofyy26iyL7clCuiQhR1Aa/4sPUxelDTOx+mQVrhd0q
        GXp4dx6WX8+U827ukbsDctT2iLwUMVQvy9YraSo4kt6moqt0PGL4SwavMRQWR2rKyZNlII
        QBDXj7DSVauKXAFlTiCQMPH53UiWBDyBT9CYb9GYTxZBnK4YamvHy4oPEEO0hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628611339;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hD70kUOOwUKFS0CQcQn+oO9HeHzcsKrNCkLHKc4xjAQ=;
        b=v7hj3LIG1qLDQoGTfpGTzjf9Pvq9XyeDGicA6BM7ScB8GkptBA13mVIyYE29b2waQSOpug
        ipRFKAjfKAtlTKDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Avoid double reprogramming in
 __hrtimer_start_range_ns()
Cc:     Lorenzo Colitti <lorenzo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210713135157.873137732@linutronix.de>
References: <20210713135157.873137732@linutronix.de>
MIME-Version: 1.0
Message-ID: <162861133829.395.6550293981870979815.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     627ef5ae2df8eeccb20d5af0e4cfa4df9e61ed28
Gitweb:        https://git.kernel.org/tip/627ef5ae2df8eeccb20d5af0e4cfa4df9e61ed28
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Jul 2021 15:39:46 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 17:57:22 +02:00

hrtimer: Avoid double reprogramming in __hrtimer_start_range_ns()

If __hrtimer_start_range_ns() is invoked with an already armed hrtimer then
the timer has to be canceled first and then added back. If the timer is the
first expiring timer then on removal the clockevent device is reprogrammed
to the next expiring timer to avoid that the pending expiry fires needlessly.

If the new expiry time ends up to be the first expiry again then the clock
event device has to reprogrammed again.

Avoid this by checking whether the timer is the first to expire and in that
case, keep the timer on the current CPU and delay the reprogramming up to
the point where the timer has been enqueued again.

Reported-by: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210713135157.873137732@linutronix.de


---
 kernel/time/hrtimer.c | 60 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 7 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 4a66725..ba2e0d0 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1030,12 +1030,13 @@ static void __remove_hrtimer(struct hrtimer *timer,
  * remove hrtimer, called with base lock held
  */
 static inline int
-remove_hrtimer(struct hrtimer *timer, struct hrtimer_clock_base *base, bool restart)
+remove_hrtimer(struct hrtimer *timer, struct hrtimer_clock_base *base,
+	       bool restart, bool keep_local)
 {
 	u8 state = timer->state;
 
 	if (state & HRTIMER_STATE_ENQUEUED) {
-		int reprogram;
+		bool reprogram;
 
 		/*
 		 * Remove the timer and force reprogramming when high
@@ -1048,8 +1049,16 @@ remove_hrtimer(struct hrtimer *timer, struct hrtimer_clock_base *base, bool rest
 		debug_deactivate(timer);
 		reprogram = base->cpu_base == this_cpu_ptr(&hrtimer_bases);
 
+		/*
+		 * If the timer is not restarted then reprogramming is
+		 * required if the timer is local. If it is local and about
+		 * to be restarted, avoid programming it twice (on removal
+		 * and a moment later when it's requeued).
+		 */
 		if (!restart)
 			state = HRTIMER_STATE_INACTIVE;
+		else
+			reprogram &= !keep_local;
 
 		__remove_hrtimer(timer, base, state, reprogram);
 		return 1;
@@ -1103,9 +1112,31 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 				    struct hrtimer_clock_base *base)
 {
 	struct hrtimer_clock_base *new_base;
+	bool force_local, first;
 
-	/* Remove an active timer from the queue: */
-	remove_hrtimer(timer, base, true);
+	/*
+	 * If the timer is on the local cpu base and is the first expiring
+	 * timer then this might end up reprogramming the hardware twice
+	 * (on removal and on enqueue). To avoid that by prevent the
+	 * reprogram on removal, keep the timer local to the current CPU
+	 * and enforce reprogramming after it is queued no matter whether
+	 * it is the new first expiring timer again or not.
+	 */
+	force_local = base->cpu_base == this_cpu_ptr(&hrtimer_bases);
+	force_local &= base->cpu_base->next_timer == timer;
+
+	/*
+	 * Remove an active timer from the queue. In case it is not queued
+	 * on the current CPU, make sure that remove_hrtimer() updates the
+	 * remote data correctly.
+	 *
+	 * If it's on the current CPU and the first expiring timer, then
+	 * skip reprogramming, keep the timer local and enforce
+	 * reprogramming later if it was the first expiring timer.  This
+	 * avoids programming the underlying clock event twice (once at
+	 * removal and once after enqueue).
+	 */
+	remove_hrtimer(timer, base, true, force_local);
 
 	if (mode & HRTIMER_MODE_REL)
 		tim = ktime_add_safe(tim, base->get_time());
@@ -1115,9 +1146,24 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	hrtimer_set_expires_range_ns(timer, tim, delta_ns);
 
 	/* Switch the timer base, if necessary: */
-	new_base = switch_hrtimer_base(timer, base, mode & HRTIMER_MODE_PINNED);
+	if (!force_local) {
+		new_base = switch_hrtimer_base(timer, base,
+					       mode & HRTIMER_MODE_PINNED);
+	} else {
+		new_base = base;
+	}
+
+	first = enqueue_hrtimer(timer, new_base, mode);
+	if (!force_local)
+		return first;
 
-	return enqueue_hrtimer(timer, new_base, mode);
+	/*
+	 * Timer was forced to stay on the current CPU to avoid
+	 * reprogramming on removal and enqueue. Force reprogram the
+	 * hardware by evaluating the new first expiring timer.
+	 */
+	hrtimer_force_reprogram(new_base->cpu_base, 1);
+	return 0;
 }
 
 /**
@@ -1183,7 +1229,7 @@ int hrtimer_try_to_cancel(struct hrtimer *timer)
 	base = lock_hrtimer_base(timer, &flags);
 
 	if (!hrtimer_callback_running(timer))
-		ret = remove_hrtimer(timer, base, false);
+		ret = remove_hrtimer(timer, base, false, false);
 
 	unlock_hrtimer_base(timer, &flags);
 
