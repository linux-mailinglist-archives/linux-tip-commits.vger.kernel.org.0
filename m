Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F2F2B8F96
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Nov 2020 11:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgKSJzS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Nov 2020 04:55:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60902 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgKSJzM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Nov 2020 04:55:12 -0500
Date:   Thu, 19 Nov 2020 09:55:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605779710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vqigkOS3b5B5v6idh6CcVb7vvcW0F9ExXtgBBiOXFxk=;
        b=Ss0Idz3OzRpy43Dr+qyPKt8NPoZqS8xWbui9ech5Li3mhgMIzuP/eLusop3PkOhXcifi6U
        T4Yl20Knv67Y/Sd1zTOr20i6lUBTBvnfL53Dm2Djo6vmmBgFXUORaYLWKapJbAMq0V3B+o
        Y0puzBGgu3zowzvrZJWWA9VBH2hfEWG37JoIkSn/dH8LnAtIdfcAZ4qmxgLUbjMBTEcCSr
        QKmCgCW7/m0u2Ym80/0tTxouyKVxSALT4Q5TqY2ymWM1ggBrslWipb1WUo2WPHgfAf3fw/
        eg343zBHZ+IYqakMZU9Va401jO45qSaPBWoLRglCWw+ZnQC+EMXryycVKDGIdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605779710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vqigkOS3b5B5v6idh6CcVb7vvcW0F9ExXtgBBiOXFxk=;
        b=o7QohteYOIAAyvyovpZP8kZbutGM2y0XQqBxXENZAsLPSZQYPooE2H3AkBnjoASnyzDBW5
        2HaToGrnLWZdJEBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/sched: Use tick_next_period for lockless quick check
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201117132006.337366695@linutronix.de>
References: <20201117132006.337366695@linutronix.de>
MIME-Version: 1.0
Message-ID: <160577970969.11244.10855382455981949914.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     372acbbaa80940189593f9d69c7c069955f24f7a
Gitweb:        https://git.kernel.org/tip/372acbbaa80940189593f9d69c7c069955f24f7a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 17 Nov 2020 14:19:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Nov 2020 10:48:29 +01:00

tick/sched: Use tick_next_period for lockless quick check

No point in doing calculations.

   tick_next_period = last_jiffies_update + tick_period

Just check whether now is before tick_next_period to figure out whether
jiffies need an update.

Add a comment why the intentional data race in the quick check is safe or
not so safe in a 32bit corner case and why we don't worry about it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201117132006.337366695@linutronix.de

---
 kernel/time/tick-sched.c | 46 +++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 15360e6..b4b6abc 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -59,11 +59,29 @@ static void tick_do_update_jiffies64(ktime_t now)
 	ktime_t delta;
 
 	/*
-	 * Do a quick check without holding jiffies_lock:
-	 * The READ_ONCE() pairs with two updates done later in this function.
+	 * Do a quick check without holding jiffies_lock. The READ_ONCE()
+	 * pairs with the update done later in this function.
+	 *
+	 * This is also an intentional data race which is even safe on
+	 * 32bit in theory. If there is a concurrent update then the check
+	 * might give a random answer. It does not matter because if it
+	 * returns then the concurrent update is already taking care, if it
+	 * falls through then it will pointlessly contend on jiffies_lock.
+	 *
+	 * Though there is one nasty case on 32bit due to store tearing of
+	 * the 64bit value. If the first 32bit store makes the quick check
+	 * return on all other CPUs and the writing CPU context gets
+	 * delayed to complete the second store (scheduled out on virt)
+	 * then jiffies can become stale for up to ~2^32 nanoseconds
+	 * without noticing. After that point all CPUs will wait for
+	 * jiffies lock.
+	 *
+	 * OTOH, this is not any different than the situation with NOHZ=off
+	 * where one CPU is responsible for updating jiffies and
+	 * timekeeping. If that CPU goes out for lunch then all other CPUs
+	 * will operate on stale jiffies until it decides to come back.
 	 */
-	delta = ktime_sub(now, READ_ONCE(last_jiffies_update));
-	if (delta < tick_period)
+	if (ktime_before(now, READ_ONCE(tick_next_period)))
 		return;
 
 	/* Reevaluate with jiffies_lock held */
@@ -74,9 +92,8 @@ static void tick_do_update_jiffies64(ktime_t now)
 	if (delta >= tick_period) {
 
 		delta = ktime_sub(delta, tick_period);
-		/* Pairs with the lockless read in this function. */
-		WRITE_ONCE(last_jiffies_update,
-			   ktime_add(last_jiffies_update, tick_period));
+		last_jiffies_update = ktime_add(last_jiffies_update,
+						tick_period);
 
 		/* Slow path for long timeouts */
 		if (unlikely(delta >= tick_period)) {
@@ -84,15 +101,18 @@ static void tick_do_update_jiffies64(ktime_t now)
 
 			ticks = ktime_divns(delta, incr);
 
-			/* Pairs with the lockless read in this function. */
-			WRITE_ONCE(last_jiffies_update,
-				   ktime_add_ns(last_jiffies_update,
-						incr * ticks));
+			last_jiffies_update = ktime_add_ns(last_jiffies_update,
+							   incr * ticks);
 		}
 		do_timer(++ticks);
 
-		/* Keep the tick_next_period variable up to date */
-		tick_next_period = ktime_add(last_jiffies_update, tick_period);
+		/*
+		 * Keep the tick_next_period variable up to date.
+		 * WRITE_ONCE() pairs with the READ_ONCE() in the lockless
+		 * quick check above.
+		 */
+		WRITE_ONCE(tick_next_period,
+			   ktime_add(last_jiffies_update, tick_period));
 	} else {
 		write_seqcount_end(&jiffies_seq);
 		raw_spin_unlock(&jiffies_lock);
