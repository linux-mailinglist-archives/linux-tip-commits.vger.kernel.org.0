Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B2A3B0808
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jun 2021 16:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhFVPA7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 22 Jun 2021 11:00:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58494 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhFVPA4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 22 Jun 2021 11:00:56 -0400
Date:   Tue, 22 Jun 2021 14:58:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624373919;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZrXnq7w1uZerYWymcifewPclWVnAzSqlPOcWMAyrXnY=;
        b=mKFZpnPhCKyWi/VjX4xmzuRTk2/Y19XZl4CSYlFRBV96ae+3q6F3kN1Mjc3x04PSmIRysL
        01KL/YieBrPJO0yoPZlk/I6tKLQi2J9HkgFGdZQqYI8FYKx4B6PTa4rRq13C9TCKArcXBa
        wRgXJHa/F4YEGVx5mRUqD6b5Or9yrLVrqsDGY9IL6mime2Q/r40ZEE96ovlA+2wgQVEgx/
        d/2cKp/rb8FaicwVJWiDGi+KCBXHl75HoL3f92v1GBjVLDOXDAG+Z1yRzdIaIIQpKX2vl7
        WCBfPIUHHS5ExKUHoxGPIqNsjW+gMGgI/yzVAQp4zRJBWSgJzsppuhrSNCTcmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624373919;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZrXnq7w1uZerYWymcifewPclWVnAzSqlPOcWMAyrXnY=;
        b=PT+mZr6rOBGuYwCO7jMw1cgqAGmB+/MN2ebwoTLzHjc6uzhmujnURBZtrC3F2c07HKD36N
        yvksCWvAC500eCAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Check per-CPU clock synchronization
 when marked unstable
Cc:     Chris Mason <clm@fb.com>, "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Feng Tang <feng.tang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210527190124.440372-2-paulmck@kernel.org>
References: <20210527190124.440372-2-paulmck@kernel.org>
MIME-Version: 1.0
Message-ID: <162437391908.395.5864309888053619715.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     7560c02bdffb7c52d1457fa551b9e745d4b9e754
Gitweb:        https://git.kernel.org/tip/7560c02bdffb7c52d1457fa551b9e745d4b9e754
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 27 May 2021 12:01:20 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 22 Jun 2021 16:53:16 +02:00

clocksource: Check per-CPU clock synchronization when marked unstable

Some sorts of per-CPU clock sources have a history of going out of
synchronization with each other.  However, this problem has purportedy been
solved in the past ten years.  Except that it is all too possible that the
problem has instead simply been made less likely, which might mean that
some of the occasional "Marking clocksource 'tsc' as unstable" messages
might be due to desynchronization.  How would anyone know?

Therefore apply CPU-to-CPU synchronization checking to newly unstable
clocksource that are marked with the new CLOCK_SOURCE_VERIFY_PERCPU flag.
Lists of desynchronized CPUs are printed, with the caveat that if it
is the reporting CPU that is itself desynchronized, it will appear that
all the other clocks are wrong.  Just like in real life.

Reported-by: Chris Mason <clm@fb.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Feng Tang <feng.tang@intel.com>
Link: https://lore.kernel.org/r/20210527190124.440372-2-paulmck@kernel.org
---
 arch/x86/kernel/tsc.c       |  3 +-
 include/linux/clocksource.h |  2 +-
 kernel/time/clocksource.c   | 60 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 57ec011..6eb1b09 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1152,7 +1152,8 @@ static struct clocksource clocksource_tsc = {
 	.mask			= CLOCKSOURCE_MASK(64),
 	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
 				  CLOCK_SOURCE_VALID_FOR_HRES |
-				  CLOCK_SOURCE_MUST_VERIFY,
+				  CLOCK_SOURCE_MUST_VERIFY |
+				  CLOCK_SOURCE_VERIFY_PERCPU,
 	.vdso_clock_mode	= VDSO_CLOCKMODE_TSC,
 	.enable			= tsc_cs_enable,
 	.resume			= tsc_resume,
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index d6ab416..7f83d51 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -137,7 +137,7 @@ struct clocksource {
 #define CLOCK_SOURCE_UNSTABLE			0x40
 #define CLOCK_SOURCE_SUSPEND_NONSTOP		0x80
 #define CLOCK_SOURCE_RESELECT			0x100
-
+#define CLOCK_SOURCE_VERIFY_PERCPU		0x200
 /* simplify initialization of mask field */
 #define CLOCKSOURCE_MASK(bits) GENMASK_ULL((bits) - 1, 0)
 
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 43243f2..cb12225 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -224,6 +224,60 @@ static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 	return false;
 }
 
+static u64 csnow_mid;
+static cpumask_t cpus_ahead;
+static cpumask_t cpus_behind;
+
+static void clocksource_verify_one_cpu(void *csin)
+{
+	struct clocksource *cs = (struct clocksource *)csin;
+
+	csnow_mid = cs->read(cs);
+}
+
+static void clocksource_verify_percpu(struct clocksource *cs)
+{
+	int64_t cs_nsec, cs_nsec_max = 0, cs_nsec_min = LLONG_MAX;
+	u64 csnow_begin, csnow_end;
+	int cpu, testcpu;
+	s64 delta;
+
+	cpumask_clear(&cpus_ahead);
+	cpumask_clear(&cpus_behind);
+	preempt_disable();
+	testcpu = smp_processor_id();
+	pr_warn("Checking clocksource %s synchronization from CPU %d.\n", cs->name, testcpu);
+	for_each_online_cpu(cpu) {
+		if (cpu == testcpu)
+			continue;
+		csnow_begin = cs->read(cs);
+		smp_call_function_single(cpu, clocksource_verify_one_cpu, cs, 1);
+		csnow_end = cs->read(cs);
+		delta = (s64)((csnow_mid - csnow_begin) & cs->mask);
+		if (delta < 0)
+			cpumask_set_cpu(cpu, &cpus_behind);
+		delta = (csnow_end - csnow_mid) & cs->mask;
+		if (delta < 0)
+			cpumask_set_cpu(cpu, &cpus_ahead);
+		delta = clocksource_delta(csnow_end, csnow_begin, cs->mask);
+		cs_nsec = clocksource_cyc2ns(delta, cs->mult, cs->shift);
+		if (cs_nsec > cs_nsec_max)
+			cs_nsec_max = cs_nsec;
+		if (cs_nsec < cs_nsec_min)
+			cs_nsec_min = cs_nsec;
+	}
+	preempt_enable();
+	if (!cpumask_empty(&cpus_ahead))
+		pr_warn("        CPUs %*pbl ahead of CPU %d for clocksource %s.\n",
+			cpumask_pr_args(&cpus_ahead), testcpu, cs->name);
+	if (!cpumask_empty(&cpus_behind))
+		pr_warn("        CPUs %*pbl behind CPU %d for clocksource %s.\n",
+			cpumask_pr_args(&cpus_behind), testcpu, cs->name);
+	if (!cpumask_empty(&cpus_ahead) || !cpumask_empty(&cpus_behind))
+		pr_warn("        CPU %d check durations %lldns - %lldns for clocksource %s.\n",
+			testcpu, cs_nsec_min, cs_nsec_max, cs->name);
+}
+
 static void clocksource_watchdog(struct timer_list *unused)
 {
 	u64 csnow, wdnow, cslast, wdlast, delta;
@@ -448,6 +502,12 @@ static int __clocksource_watchdog_kthread(void)
 	unsigned long flags;
 	int select = 0;
 
+	/* Do any required per-CPU skew verification. */
+	if (curr_clocksource &&
+	    curr_clocksource->flags & CLOCK_SOURCE_UNSTABLE &&
+	    curr_clocksource->flags & CLOCK_SOURCE_VERIFY_PERCPU)
+		clocksource_verify_percpu(curr_clocksource);
+
 	spin_lock_irqsave(&watchdog_lock, flags);
 	list_for_each_entry_safe(cs, tmp, &watchdog_list, wd_list) {
 		if (cs->flags & CLOCK_SOURCE_UNSTABLE) {
