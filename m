Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F8B3CF875
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Jul 2021 12:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbhGTKPk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Jul 2021 06:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237679AbhGTKO5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Jul 2021 06:14:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C28C061794;
        Tue, 20 Jul 2021 03:55:24 -0700 (PDT)
Date:   Tue, 20 Jul 2021 10:55:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626778522;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pfpgIXhjA1GEZ5+o2yPSNEyHzlIKKODNz0hQlnBZqlU=;
        b=Cl8rUYvPMx/R0O8baI2g8VfkYvt7+RHWE2SD/aSZVKasBA480WMyTIsFzxv1vT4Zhjq7iu
        Uzi47HWvxJLfIWK86mTTCMMcaNwnoB+/LofwFHFHbeRc5AZxUxZybIgsxe21dN3RWLOAmC
        jAEAp1c6kvCP4nYxAMt/Dd7/4KYmkpMH8ToaO8Ys23Q7ZQScGXx9701733Inutv6AwgoF+
        hBbcQi/I5X9BZeITUtS88Ab7zWeAv8V13QpmFehMXiI5xDXo/GG/cNkWayF1qpQbZkfcdr
        3vygxYiJ5BgkcGmIRWz9PwkP22XcZs0D0Xf2OAs9qpDia5YCiL8+8fijKIiSCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626778522;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pfpgIXhjA1GEZ5+o2yPSNEyHzlIKKODNz0hQlnBZqlU=;
        b=31T5PyFGQUkYv6vxL7eRaqBsIayhstsyM+FG9a5pFbOTemaVZ6g8IJg24fP86NDitKpa/p
        sVnCjoUJu8MVDZBQ==
From:   "tip-bot2 for Nicolas Saenz Julienne" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timers: Fix get_next_timer_interrupt() with no
 timers pending
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162677852187.395.12542757776648558436.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     aebacb7f6ca1926918734faae14d1f0b6fae5cb7
Gitweb:        https://git.kernel.org/tip/aebacb7f6ca1926918734faae14d1f0b6fae5cb7
Author:        Nicolas Saenz Julienne <nsaenzju@redhat.com>
AuthorDate:    Fri, 09 Jul 2021 16:13:25 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Thu, 15 Jul 2021 01:23:54 +02:00

timers: Fix get_next_timer_interrupt() with no timers pending

31cd0e119d50 ("timers: Recalculate next timer interrupt only when
necessary") subtly altered get_next_timer_interrupt()'s behaviour. The
function no longer consistently returns KTIME_MAX with no timers
pending.

In order to decide if there are any timers pending we check whether the
next expiry will happen NEXT_TIMER_MAX_DELTA jiffies from now.
Unfortunately, the next expiry time and the timer base clock are no
longer updated in unison. The former changes upon certain timer
operations (enqueue, expire, detach), whereas the latter keeps track of
jiffies as they move forward. Ultimately breaking the logic above.

A simplified example:

- Upon entering get_next_timer_interrupt() with:

	jiffies = 1
	base->clk = 0;
	base->next_expiry = NEXT_TIMER_MAX_DELTA;

  'base->next_expiry == base->clk + NEXT_TIMER_MAX_DELTA', the function
  returns KTIME_MAX.

- 'base->clk' is updated to the jiffies value.

- The next time we enter get_next_timer_interrupt(), taking into account
  no timer operations happened:

	base->clk = 1;
	base->next_expiry = NEXT_TIMER_MAX_DELTA;

  'base->next_expiry != base->clk + NEXT_TIMER_MAX_DELTA', the function
  returns a valid expire time, which is incorrect.

This ultimately might unnecessarily rearm sched's timer on nohz_full
setups, and add latency to the system[1].

So, introduce 'base->timers_pending'[2], update it every time
'base->next_expiry' changes, and use it in get_next_timer_interrupt().

[1] See tick_nohz_stop_tick().
[2] A quick pahole check on x86_64 and arm64 shows it doesn't make
    'struct timer_base' any bigger.

Fixes: 31cd0e119d50 ("timers: Recalculate next timer interrupt only when necessary")
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 3fadb58..9eb11c2 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -207,6 +207,7 @@ struct timer_base {
 	unsigned int		cpu;
 	bool			next_expiry_recalc;
 	bool			is_idle;
+	bool			timers_pending;
 	DECLARE_BITMAP(pending_map, WHEEL_SIZE);
 	struct hlist_head	vectors[WHEEL_SIZE];
 } ____cacheline_aligned;
@@ -595,6 +596,7 @@ static void enqueue_timer(struct timer_base *base, struct timer_list *timer,
 		 * can reevaluate the wheel:
 		 */
 		base->next_expiry = bucket_expiry;
+		base->timers_pending = true;
 		base->next_expiry_recalc = false;
 		trigger_dyntick_cpu(base, timer);
 	}
@@ -1582,6 +1584,7 @@ static unsigned long __next_timer_interrupt(struct timer_base *base)
 	}
 
 	base->next_expiry_recalc = false;
+	base->timers_pending = !(next == base->clk + NEXT_TIMER_MAX_DELTA);
 
 	return next;
 }
@@ -1633,7 +1636,6 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 	u64 expires = KTIME_MAX;
 	unsigned long nextevt;
-	bool is_max_delta;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
@@ -1646,7 +1648,6 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	if (base->next_expiry_recalc)
 		base->next_expiry = __next_timer_interrupt(base);
 	nextevt = base->next_expiry;
-	is_max_delta = (nextevt == base->clk + NEXT_TIMER_MAX_DELTA);
 
 	/*
 	 * We have a fresh next event. Check whether we can forward the
@@ -1664,7 +1665,7 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 		expires = basem;
 		base->is_idle = false;
 	} else {
-		if (!is_max_delta)
+		if (base->timers_pending)
 			expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
 		/*
 		 * If we expect to sleep more than a tick, mark the base idle.
@@ -1947,6 +1948,7 @@ int timers_prepare_cpu(unsigned int cpu)
 		base = per_cpu_ptr(&timer_bases[b], cpu);
 		base->clk = jiffies;
 		base->next_expiry = base->clk + NEXT_TIMER_MAX_DELTA;
+		base->timers_pending = false;
 		base->is_idle = false;
 	}
 	return 0;
