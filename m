Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7DD3E7CFC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 18:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhHJQCg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 12:02:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44406 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbhHJQCg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 12:02:36 -0400
Date:   Tue, 10 Aug 2021 16:02:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628611332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g9JNhx301Xiph19AdrsambMTTJYcJzIdKgA0fyeJQ0M=;
        b=ffzqsD8aVCe7Nqk3rAUUYCfEz15KkxnDZgTO1cCKCToG4Z/sfD784Yt+8bphH52fTyxYDG
        U3wxEZPCxaFHK/Bo9Jf1iRNyP6YbvnaB0aFG5uK/CSdphLdgg1HdupB2DewjKWx9RegCOn
        VbcL2MRSH7XhWaGnNiQ0qCHyNqrmFfvc/XW9lXGDWoEdf07Mb/URmGzFjOTLK+ZDIAInky
        W/jnOusHjCjYdXDP8sRbsmAK2oiDUyLJVEjtkZbxUI7xgVFqdN87mFJASgnmHEKKIIrr40
        YKJ3PO65MNWQpb3gzRGgoOHt+6t5GLG3nSjnEA+6Kosp9QiyklA8b3I61B9DOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628611332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g9JNhx301Xiph19AdrsambMTTJYcJzIdKgA0fyeJQ0M=;
        b=TJ91ApAMSMHUATuGR81ZWmqxLIrD5btlXgKZCYN7abS5Op+VG71Y5N7NPoH3ZnpAHfHDA/
        pftvKdL0nLGBiXBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Avoid more SMP function calls in clock_was_set()
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210713135158.887322464@linutronix.de>
References: <20210713135158.887322464@linutronix.de>
MIME-Version: 1.0
Message-ID: <162861133186.395.4745802282790716508.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1e7f7fbcd40c69d23e3fe641ead9f3dc128fa8aa
Gitweb:        https://git.kernel.org/tip/1e7f7fbcd40c69d23e3fe641ead9f3dc128fa8aa
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Jul 2021 15:39:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 17:57:23 +02:00

hrtimer: Avoid more SMP function calls in clock_was_set()

By unconditionally updating the offsets there are more indicators
whether the SMP function calls on clock_was_set() can be avoided:

  - When the offset update already happened on the remote CPU then the
    remote update attempt will yield the same seqeuence number and no
    IPI is required.

  - When the remote CPU is currently handling hrtimer_interrupt(). In
    that case the remote CPU will reevaluate the timer bases before
    reprogramming anyway, so nothing to do.

  - After updating it can be checked whether the first expiring timer in
    the affected clock bases moves before the first expiring (softirq)
    timer of the CPU. If that's not the case then sending the IPI is not
    required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210713135158.887322464@linutronix.de

---
 kernel/time/hrtimer.c | 74 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 9 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 5d44c90..88aefc3 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -866,6 +866,68 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
 	__hrtimer_reprogram(cpu_base, true, timer, expires);
 }
 
+static bool update_needs_ipi(struct hrtimer_cpu_base *cpu_base,
+			     unsigned int active)
+{
+	struct hrtimer_clock_base *base;
+	unsigned int seq;
+	ktime_t expires;
+
+	/*
+	 * Update the base offsets unconditionally so the following
+	 * checks whether the SMP function call is required works.
+	 *
+	 * The update is safe even when the remote CPU is in the hrtimer
+	 * interrupt or the hrtimer soft interrupt and expiring affected
+	 * bases. Either it will see the update before handling a base or
+	 * it will see it when it finishes the processing and reevaluates
+	 * the next expiring timer.
+	 */
+	seq = cpu_base->clock_was_set_seq;
+	hrtimer_update_base(cpu_base);
+
+	/*
+	 * If the sequence did not change over the update then the
+	 * remote CPU already handled it.
+	 */
+	if (seq == cpu_base->clock_was_set_seq)
+		return false;
+
+	/*
+	 * If the remote CPU is currently handling an hrtimer interrupt, it
+	 * will reevaluate the first expiring timer of all clock bases
+	 * before reprogramming. Nothing to do here.
+	 */
+	if (cpu_base->in_hrtirq)
+		return false;
+
+	/*
+	 * Walk the affected clock bases and check whether the first expiring
+	 * timer in a clock base is moving ahead of the first expiring timer of
+	 * @cpu_base. If so, the IPI must be invoked because per CPU clock
+	 * event devices cannot be remotely reprogrammed.
+	 */
+	active &= cpu_base->active_bases;
+
+	for_each_active_base(base, cpu_base, active) {
+		struct timerqueue_node *next;
+
+		next = timerqueue_getnext(&base->active);
+		expires = ktime_sub(next->expires, base->offset);
+		if (expires < cpu_base->expires_next)
+			return true;
+
+		/* Extra check for softirq clock bases */
+		if (base->clockid < HRTIMER_BASE_MONOTONIC_SOFT)
+			continue;
+		if (cpu_base->softirq_activated)
+			continue;
+		if (expires < cpu_base->softirq_expires_next)
+			return true;
+	}
+	return false;
+}
+
 /*
  * Clock was set. This might affect CLOCK_REALTIME, CLOCK_TAI and
  * CLOCK_BOOTTIME (for late sleep time injection).
@@ -900,16 +962,10 @@ void clock_was_set(unsigned int bases)
 		unsigned long flags;
 
 		raw_spin_lock_irqsave(&cpu_base->lock, flags);
-		/*
-		 * Only send the IPI when there are timers queued in one of
-		 * the affected clock bases. Otherwise update the base
-		 * remote to ensure that the next enqueue of a timer on
-		 * such a clock base will see the correct offsets.
-		 */
-		if (cpu_base->active_bases & bases)
+
+		if (update_needs_ipi(cpu_base, bases))
 			cpumask_set_cpu(cpu, mask);
-		else
-			hrtimer_update_base(cpu_base);
+
 		raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
 	}
 
