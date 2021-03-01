Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F9D327AA8
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Mar 2021 10:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbhCAJYr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 1 Mar 2021 04:24:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57950 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbhCAJY0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 1 Mar 2021 04:24:26 -0500
Date:   Mon, 01 Mar 2021 09:23:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614590622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TyCZTs3sre9q7t2ZI2u8x3i0Hy5BK764FyCyb3epFFg=;
        b=wXYb42w7/7ipdf4HAPiVSFJ1J0n9MLOo4F3AZQ75tfpAmpxvxx3XeehgtDd7b2MdxsLxpe
        9yfc7TckUQ9t1XHInql40YovE9kEHYUKT39CuMKgTRPAmyjcqKUmzOPJ6rwu7r7kaoCoAb
        KnLGMu9nceYRuJuea8bQkV39N/qxsPGTDzHjR2MjKc2i/g3TEbDkHpaEyUXLNPWpjvxtOt
        vrZouY20TkL2D/jX3MLAaojoboYrT0nebmcaoQ1ePlaC+bEQ/Lu+gPjCTOcAlMlTgmoPjx
        ePXot2scqzWP4vrvVMyev4Z9l2S0sbYbcd7rqcS2nA5Ae1AoL8ttVQITKC9WUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614590622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TyCZTs3sre9q7t2ZI2u8x3i0Hy5BK764FyCyb3epFFg=;
        b=Hgm9wwaIKlEM0hwVIvA1WgX+F3OtVoVu2k8QAiUMJ6mmdi7D2eWaGY6gTzeBs9AvAzSkU5
        rR8mZ2G6uBn5f8DA==
From:   "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] hrtimer: Update softirq_expires_next correctly
 after __hrtimer_get_next_event()
Cc:     Mikael Beckius <mikael.beckius@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Anna-Maria Behnsen" <anna-maria@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210223160240.27518-1-anna-maria@linutronix.de>
References: <20210223160240.27518-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Message-ID: <161459062183.20312.15294625634005777969.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     05f7fcc675f50001a30b8938c05d11ca9f599f8c
Gitweb:        https://git.kernel.org/tip/05f7fcc675f50001a30b8938c05d11ca9f599f8c
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 23 Feb 2021 17:02:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 01 Mar 2021 10:17:56 +01:00

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

Fixes: da70160462e ("hrtimer: Implement support for softirq based hrtimers")
Reported-by: Mikael Beckius <mikael.beckius@windriver.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Tested-by: Mikael Beckius <mikael.beckius@windriver.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
