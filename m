Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D19A3E7CFD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 18:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhHJQCi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 12:02:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44410 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhHJQCg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 12:02:36 -0400
Date:   Tue, 10 Aug 2021 16:02:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628611333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NX2mbWY2iY/Gnx8yszo79QKDEQpEqi9BlhQcODQfnGI=;
        b=BEQazhhO4/jo6UWGxTG70Yn0C+r94nYR++7kSvawYtW9tTLCWg5WoGkiUqlf/JyirQyNRr
        6qR34UtoQMKAeNlhOIyjnlOkQOlhJFLrJGjd/Pjx0zI4z/s41z7w7G/VV2mZf5llsK4HK2
        fKl4XlSc1jr6B/byNF6suS4kLGhgqfGNq2otFASpAGCLMB3uC3afxsG39lg7ajAbBmYO40
        pPzHRkcJA9g6cAZBVQg6doz7WAcl4ZipBGgeWSznelnYgQznb4gzqv8zkDbNxBVYYV0W5m
        fKIvfprrg6cyknwFIWmkCR3C7HqEWBrZ9ww6qap/1gtTYZ672JL1VxMEmOQ8NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628611333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NX2mbWY2iY/Gnx8yszo79QKDEQpEqi9BlhQcODQfnGI=;
        b=+5Y2lLloryGS2sbKdkzV/lkNbw9tX7XXVIGQLpAL/DoepQ8YVzt5z4V0cWriJ3nQm4exAW
        yJ5Lbj/Mg/ceQ/CQ==
From:   "tip-bot2 for Marcelo Tosatti" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Avoid unnecessary SMP function calls in
 clock_was_set()
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210713135158.787536542@linutronix.de>
References: <20210713135158.787536542@linutronix.de>
MIME-Version: 1.0
Message-ID: <162861133269.395.11232230039102397531.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     81d741d3460ca422843ce0ec8351083f259c6166
Gitweb:        https://git.kernel.org/tip/81d741d3460ca422843ce0ec8351083f259c6166
Author:        Marcelo Tosatti <mtosatti@redhat.com>
AuthorDate:    Tue, 13 Jul 2021 15:39:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 17:57:23 +02:00

hrtimer: Avoid unnecessary SMP function calls in clock_was_set()

Setting of clocks triggers an unconditional SMP function call on all online
CPUs to reprogram the clock event device.

However, only some clocks have their offsets updated and therefore
potentially require a reprogram. That's CLOCK_REALTIME and CLOCK_TAI and in
the case of resume (delayed sleep time injection) also CLOCK_BOOTTIME.

Instead of sending an IPI unconditionally, check each per CPU hrtimer base
whether it has active timers in the affected clock bases which are
indicated by the caller in the @bases argument of clock_was_set().

If that's not the case, skip the IPI and update the offsets remotely which
ensures that any subsequently armed timers on the affected clocks are
evaluated with the correct offsets.

[ tglx: Adopted to the new bases argument, removed the softirq_active
  	check, added comment, fixed up stale comment ]

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210713135158.787536542@linutronix.de

---
 kernel/time/hrtimer.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index c8af165..5d44c90 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -882,11 +882,42 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
  */
 void clock_was_set(unsigned int bases)
 {
+	cpumask_var_t mask;
+	int cpu;
+
 	if (!hrtimer_hres_active() && !tick_nohz_active)
 		goto out_timerfd;
 
-	/* Retrigger the CPU local events everywhere */
-	on_each_cpu(retrigger_next_event, NULL, 1);
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
+		on_each_cpu(retrigger_next_event, NULL, 1);
+		goto out_timerfd;
+	}
+
+	/* Avoid interrupting CPUs if possible */
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		struct hrtimer_cpu_base *cpu_base = &per_cpu(hrtimer_bases, cpu);
+		unsigned long flags;
+
+		raw_spin_lock_irqsave(&cpu_base->lock, flags);
+		/*
+		 * Only send the IPI when there are timers queued in one of
+		 * the affected clock bases. Otherwise update the base
+		 * remote to ensure that the next enqueue of a timer on
+		 * such a clock base will see the correct offsets.
+		 */
+		if (cpu_base->active_bases & bases)
+			cpumask_set_cpu(cpu, mask);
+		else
+			hrtimer_update_base(cpu_base);
+		raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
+	}
+
+	preempt_disable();
+	smp_call_function_many(mask, retrigger_next_event, NULL, 1);
+	preempt_enable();
+	cpus_read_unlock();
+	free_cpumask_var(mask);
 
 out_timerfd:
 	timerfd_clock_was_set();
