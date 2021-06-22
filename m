Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CB83B080A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jun 2021 16:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhFVPBA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 22 Jun 2021 11:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbhFVPA5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 22 Jun 2021 11:00:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B144C06175F;
        Tue, 22 Jun 2021 07:58:40 -0700 (PDT)
Date:   Tue, 22 Jun 2021 14:58:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624373919;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sGq4goqDYPNV23+e+Ez8s2ALnChRqys0uNrGrNQug2U=;
        b=pGgPICJJL3cyuR1vpXBuAbb6w9RruTqUCt3WdTAnPd7cdUnjTg454QlDNtg6VSzruSh1zy
        EkiPVcSJzbZORpgukv84rf5vpHSvejw7NWz5E1T7mu0WyLOSF+7LNyEX7vbcSn2HeCRF3G
        1CbXGXQlvvgR+de8pgJz4hYxTqzU5DNbAm2tQA/LPGOy0oyYJOYzN2AJu+O1I3aViMJQeD
        bIwAxgbmvwRfy5MZyCRDFHBgY1dfIGi57KwCq942d7jefHSDBJe3j5ccMJI2cyqRsKTCct
        UjztpU4/Gd/1m3RsrT7awYR7e4etrQrnfFzYCK6FzporkVYDky356FyCu34KCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624373919;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sGq4goqDYPNV23+e+Ez8s2ALnChRqys0uNrGrNQug2U=;
        b=0et3KK5euU9cwBGI+l4H/S8M9AvKd5XRGpzg3XsXHNIc/ZPCqTitIbeNbkm7WCDFrE2tXQ
        oAaA4JiWcLNuSYBg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Limit number of CPUs checked for
 clock synchronization
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210527190124.440372-3-paulmck@kernel.org>
References: <20210527190124.440372-3-paulmck@kernel.org>
MIME-Version: 1.0
Message-ID: <162437391852.395.6381660721602110849.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     fa218f1cce6ba40069c8daab8821de7e6be1cdd0
Gitweb:        https://git.kernel.org/tip/fa218f1cce6ba40069c8daab8821de7e6be1cdd0
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 27 May 2021 12:01:21 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 22 Jun 2021 16:53:16 +02:00

clocksource: Limit number of CPUs checked for clock synchronization

Currently, if skew is detected on a clock marked CLOCK_SOURCE_VERIFY_PERCPU,
that clock is checked on all CPUs.  This is thorough, but might not be
what you want on a system with a few tens of CPUs, let alone a few hundred
of them.

Therefore, by default check only up to eight randomly chosen CPUs.  Also
provide a new clocksource.verify_n_cpus kernel boot parameter.  A value of
-1 says to check all of the CPUs, and a non-negative value says to randomly
select that number of CPUs, without concern about selecting the same CPU
multiple times.  However, make use of a cpumask so that a given CPU will be
checked at most once.

Suggested-by: Thomas Gleixner <tglx@linutronix.de> # For verify_n_cpus=1.
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Feng Tang <feng.tang@intel.com>
Link: https://lore.kernel.org/r/20210527190124.440372-3-paulmck@kernel.org

---
 Documentation/admin-guide/kernel-parameters.txt | 10 ++-
 kernel/time/clocksource.c                       | 74 +++++++++++++++-
 2 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 995decc..9ec9ea1 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -587,6 +587,16 @@
 			unstable.  Defaults to three retries, that is,
 			four attempts to read the clock under test.
 
+	clocksource.verify_n_cpus= [KNL]
+			Limit the number of CPUs checked for clocksources
+			marked with CLOCK_SOURCE_VERIFY_PERCPU that
+			are marked unstable due to excessive skew.
+			A negative value says to check all CPUs, while
+			zero says not to check any.  Values larger than
+			nr_cpu_ids are silently truncated to nr_cpu_ids.
+			The actual CPUs are chosen randomly, with
+			no replacement if the same CPU is chosen twice.
+
 	clearcpuid=BITNUM[,BITNUM...] [X86]
 			Disable CPUID feature X for the kernel. See
 			arch/x86/include/asm/cpufeatures.h for the valid bit
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index cb12225..e4beab2 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -14,6 +14,8 @@
 #include <linux/sched.h> /* for spin_unlock_irq() using preempt_count() m68k */
 #include <linux/tick.h>
 #include <linux/kthread.h>
+#include <linux/prandom.h>
+#include <linux/cpu.h>
 
 #include "tick-internal.h"
 #include "timekeeping_internal.h"
@@ -193,6 +195,8 @@ void clocksource_mark_unstable(struct clocksource *cs)
 
 static ulong max_cswd_read_retries = 3;
 module_param(max_cswd_read_retries, ulong, 0644);
+static int verify_n_cpus = 8;
+module_param(verify_n_cpus, int, 0644);
 
 static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 {
@@ -227,6 +231,55 @@ static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 static u64 csnow_mid;
 static cpumask_t cpus_ahead;
 static cpumask_t cpus_behind;
+static cpumask_t cpus_chosen;
+
+static void clocksource_verify_choose_cpus(void)
+{
+	int cpu, i, n = verify_n_cpus;
+
+	if (n < 0) {
+		/* Check all of the CPUs. */
+		cpumask_copy(&cpus_chosen, cpu_online_mask);
+		cpumask_clear_cpu(smp_processor_id(), &cpus_chosen);
+		return;
+	}
+
+	/* If no checking desired, or no other CPU to check, leave. */
+	cpumask_clear(&cpus_chosen);
+	if (n == 0 || num_online_cpus() <= 1)
+		return;
+
+	/* Make sure to select at least one CPU other than the current CPU. */
+	cpu = cpumask_next(-1, cpu_online_mask);
+	if (cpu == smp_processor_id())
+		cpu = cpumask_next(cpu, cpu_online_mask);
+	if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
+		return;
+	cpumask_set_cpu(cpu, &cpus_chosen);
+
+	/* Force a sane value for the boot parameter. */
+	if (n > nr_cpu_ids)
+		n = nr_cpu_ids;
+
+	/*
+	 * Randomly select the specified number of CPUs.  If the same
+	 * CPU is selected multiple times, that CPU is checked only once,
+	 * and no replacement CPU is selected.  This gracefully handles
+	 * situations where verify_n_cpus is greater than the number of
+	 * CPUs that are currently online.
+	 */
+	for (i = 1; i < n; i++) {
+		cpu = prandom_u32() % nr_cpu_ids;
+		cpu = cpumask_next(cpu - 1, cpu_online_mask);
+		if (cpu >= nr_cpu_ids)
+			cpu = cpumask_next(-1, cpu_online_mask);
+		if (!WARN_ON_ONCE(cpu >= nr_cpu_ids))
+			cpumask_set_cpu(cpu, &cpus_chosen);
+	}
+
+	/* Don't verify ourselves. */
+	cpumask_clear_cpu(smp_processor_id(), &cpus_chosen);
+}
 
 static void clocksource_verify_one_cpu(void *csin)
 {
@@ -242,12 +295,22 @@ static void clocksource_verify_percpu(struct clocksource *cs)
 	int cpu, testcpu;
 	s64 delta;
 
+	if (verify_n_cpus == 0)
+		return;
 	cpumask_clear(&cpus_ahead);
 	cpumask_clear(&cpus_behind);
+	get_online_cpus();
 	preempt_disable();
+	clocksource_verify_choose_cpus();
+	if (cpumask_weight(&cpus_chosen) == 0) {
+		preempt_enable();
+		put_online_cpus();
+		pr_warn("Not enough CPUs to check clocksource '%s'.\n", cs->name);
+		return;
+	}
 	testcpu = smp_processor_id();
-	pr_warn("Checking clocksource %s synchronization from CPU %d.\n", cs->name, testcpu);
-	for_each_online_cpu(cpu) {
+	pr_warn("Checking clocksource %s synchronization from CPU %d to CPUs %*pbl.\n", cs->name, testcpu, cpumask_pr_args(&cpus_chosen));
+	for_each_cpu(cpu, &cpus_chosen) {
 		if (cpu == testcpu)
 			continue;
 		csnow_begin = cs->read(cs);
@@ -267,6 +330,7 @@ static void clocksource_verify_percpu(struct clocksource *cs)
 			cs_nsec_min = cs_nsec;
 	}
 	preempt_enable();
+	put_online_cpus();
 	if (!cpumask_empty(&cpus_ahead))
 		pr_warn("        CPUs %*pbl ahead of CPU %d for clocksource %s.\n",
 			cpumask_pr_args(&cpus_ahead), testcpu, cs->name);
@@ -337,6 +401,12 @@ static void clocksource_watchdog(struct timer_list *unused)
 				watchdog->name, wdnow, wdlast, watchdog->mask);
 			pr_warn("                      '%s' cs_now: %llx cs_last: %llx mask: %llx\n",
 				cs->name, csnow, cslast, cs->mask);
+			if (curr_clocksource == cs)
+				pr_warn("                      '%s' is current clocksource.\n", cs->name);
+			else if (curr_clocksource)
+				pr_warn("                      '%s' (not '%s') is current clocksource.\n", curr_clocksource->name, cs->name);
+			else
+				pr_warn("                      No current clocksource.\n");
 			__clocksource_unstable(cs);
 			continue;
 		}
