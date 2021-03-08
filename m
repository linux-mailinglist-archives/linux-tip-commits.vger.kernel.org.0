Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0DC3309A1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Mar 2021 09:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhCHImd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 8 Mar 2021 03:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhCHImC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 8 Mar 2021 03:42:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AD0C06174A;
        Mon,  8 Mar 2021 00:42:02 -0800 (PST)
Date:   Mon, 08 Mar 2021 08:41:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615192920;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D9GLWPYB039oXIqQ0+COytv+cfzKuLpFofoSTbPlScI=;
        b=ePP8SKQJW+YSicSbp1lwJKErW4Gcmbl6e9vP09nlp1Iik8mOCFRF0SxQSuf/JJsqSRzKSW
        DaBIrGMML/Z5W85VUw6XmMXD5pKvbHQJTIYKaITTvhKMIryGAQUSVfJA+yaT1W45tDt8Sf
        Fws23Am/JH4H9uPe0i6uuHSP3hlnUZe05GPOsmAXp2QujSadR2Mp3It+hqbAcTJaFGwwtr
        QGjO00s93JWUNNax5l86/bE8ySDFlos9PZDGsSp4wjXewoFZWrCbioaq/KRKGwCT6CRnlX
        7h3lMEGhYztSrYNEEau024BaRxr8aa6gUSccugjEjYfKW++JhNorh3tj1DbJjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615192920;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D9GLWPYB039oXIqQ0+COytv+cfzKuLpFofoSTbPlScI=;
        b=7febrdizmaM1mCPsM/DB7VAwjYMs1IaN/T2wkgAziOVM3DaRW3hYeUTF1grKwS4rAsziab
        YZmN7c3eyquJWtCg==
From:   "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] hrtimer: Update softirq_expires_next correctly
 after __hrtimer_get_next_event()
Cc:     Mikael Beckius <mikael.beckius@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210223160240.27518-1-anna-maria@linutronix.de>
References: <20210223160240.27518-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Message-ID: <161519291918.398.6154996042324189382.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     46eb1701c046cc18c032fa68f3c8ccbf24483ee4
Gitweb:        https://git.kernel.org/tip/46eb1701c046cc18c032fa68f3c8ccbf24483ee4
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 23 Feb 2021 17:02:40 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 08 Mar 2021 09:37:01 +01:00

hrtimer: Update softirq_expires_next correctly after __hrtimer_get_next_event()

hrtimer_force_reprogram() and hrtimer_interrupt() invokes
__hrtimer_get_next_event() to find the earliest expiry time of hrtimer
bases. __hrtimer_get_next_event() does not update
cpu_base::[softirq_]_expires_next to preserve reprogramming logic. That
needs to be done at the callsites.

hrtimer_force_reprogram() updates cpu_base::softirq_expires_next only when
the first expiring timer is a softirq timer and the soft interrupt is not
activated. That's wrong because cpu_base::softirq_expires_next is left
stale when the first expiring timer of all bases is a timer which expires
in hard interrupt context. hrtimer_interrupt() does never update
cpu_base::softirq_expires_next which is wrong too.

That becomes a problem when clock_settime() sets CLOCK_REALTIME forward and
the first soft expiring timer is in the CLOCK_REALTIME_SOFT base. Setting
CLOCK_REALTIME forward moves the clock MONOTONIC based expiry time of that
timer before the stale cpu_base::softirq_expires_next.

cpu_base::softirq_expires_next is cached to make the check for raising the
soft interrupt fast. In the above case the soft interrupt won't be raised
until clock monotonic reaches the stale cpu_base::softirq_expires_next
value. That's incorrect, but what's worse it that if the softirq timer
becomes the first expiring timer of all clock bases after the hard expiry
timer has been handled the reprogramming of the clockevent from
hrtimer_interrupt() will result in an interrupt storm. That happens because
the reprogramming does not use cpu_base::softirq_expires_next, it uses
__hrtimer_get_next_event() which returns the actual expiry time. Once clock
MONOTONIC reaches cpu_base::softirq_expires_next the soft interrupt is
raised and the storm subsides.

Change the logic in hrtimer_force_reprogram() to evaluate the soft and hard
bases seperately, update softirq_expires_next and handle the case when a
soft expiring timer is the first of all bases by comparing the expiry times
and updating the required cpu base fields. Split this functionality into a
separate function to be able to use it in hrtimer_interrupt() as well
without copy paste.

Fixes: 5da70160462e ("hrtimer: Implement support for softirq based hrtimers")
Reported-by: Mikael Beckius <mikael.beckius@windriver.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Mikael Beckius <mikael.beckius@windriver.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210223160240.27518-1-anna-maria@linutronix.de
---
 kernel/time/hrtimer.c | 60 +++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 743c852..788b9d1 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -546,8 +546,11 @@ static ktime_t __hrtimer_next_event_base(struct hrtimer_cpu_base *cpu_base,
 }
 
 /*
- * Recomputes cpu_base::*next_timer and returns the earliest expires_next but
- * does not set cpu_base::*expires_next, that is done by hrtimer_reprogram.
+ * Recomputes cpu_base::*next_timer and returns the earliest expires_next
+ * but does not set cpu_base::*expires_next, that is done by
+ * hrtimer[_force]_reprogram and hrtimer_interrupt only. When updating
+ * cpu_base::*expires_next right away, reprogramming logic would no longer
+ * work.
  *
  * When a softirq is pending, we can ignore the HRTIMER_ACTIVE_SOFT bases,
  * those timers will get run whenever the softirq gets handled, at the end of
@@ -588,6 +591,37 @@ __hrtimer_get_next_event(struct hrtimer_cpu_base *cpu_base, unsigned int active_
 	return expires_next;
 }
 
+static ktime_t hrtimer_update_next_event(struct hrtimer_cpu_base *cpu_base)
+{
+	ktime_t expires_next, soft = KTIME_MAX;
+
+	/*
+	 * If the soft interrupt has already been activated, ignore the
+	 * soft bases. They will be handled in the already raised soft
+	 * interrupt.
+	 */
+	if (!cpu_base->softirq_activated) {
+		soft = __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_SOFT);
+		/*
+		 * Update the soft expiry time. clock_settime() might have
+		 * affected it.
+		 */
+		cpu_base->softirq_expires_next = soft;
+	}
+
+	expires_next = __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_HARD);
+	/*
+	 * If a softirq timer is expiring first, update cpu_base->next_timer
+	 * and program the hardware with the soft expiry time.
+	 */
+	if (expires_next > soft) {
+		cpu_base->next_timer = cpu_base->softirq_next_timer;
+		expires_next = soft;
+	}
+
+	return expires_next;
+}
+
 static inline ktime_t hrtimer_update_base(struct hrtimer_cpu_base *base)
 {
 	ktime_t *offs_real = &base->clock_base[HRTIMER_BASE_REALTIME].offset;
@@ -628,23 +662,7 @@ hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal)
 {
 	ktime_t expires_next;
 
-	/*
-	 * Find the current next expiration time.
-	 */
-	expires_next = __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_ALL);
-
-	if (cpu_base->next_timer && cpu_base->next_timer->is_soft) {
-		/*
-		 * When the softirq is activated, hrtimer has to be
-		 * programmed with the first hard hrtimer because soft
-		 * timer interrupt could occur too late.
-		 */
-		if (cpu_base->softirq_activated)
-			expires_next = __hrtimer_get_next_event(cpu_base,
-								HRTIMER_ACTIVE_HARD);
-		else
-			cpu_base->softirq_expires_next = expires_next;
-	}
+	expires_next = hrtimer_update_next_event(cpu_base);
 
 	if (skip_equal && expires_next == cpu_base->expires_next)
 		return;
@@ -1644,8 +1662,8 @@ retry:
 
 	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);
 
-	/* Reevaluate the clock bases for the next expiry */
-	expires_next = __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_ALL);
+	/* Reevaluate the clock bases for the [soft] next expiry */
+	expires_next = hrtimer_update_next_event(cpu_base);
 	/*
 	 * Store the new expiry value so the migration code can verify
 	 * against it.
