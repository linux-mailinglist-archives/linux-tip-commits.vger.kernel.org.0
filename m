Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428E2489938
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Jan 2022 14:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiAJNGs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 10 Jan 2022 08:06:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42932 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiAJNGr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 10 Jan 2022 08:06:47 -0500
Date:   Mon, 10 Jan 2022 13:06:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641820006;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qOjp+7fgLCWvHM3GK57jDARVfOihrs+79IW7WyircY8=;
        b=06KzJbCWl0BOVF52ibJSZpkS+IbNTFRGcbzV52++tic5nyIntHKJSUbA2JpRoxjrV9d2HU
        HTU9co4WUV6zFPlyyGhxOnHiVYWD/N6UqdK3rQf9B23UfVMdK0Jkk5oTFl2piBa7+m3FoI
        0dIOGtSqg++iI2IHBEVAZjggk55hdYQeW3Qb4yzYf5moUvdH3f+hKYJGwTWGbUdkTU8Nwe
        Zob+obkI90sg0bC1xkTFx3MWOAvezjD1YFFFLWJBi14J2kLtrKqC+R0pFSAp4gvWrBrw0m
        oAx6jTwh1EWAHLUP618Aj5/5t1MK1Rv3Q95BBXLARxrxeWRbReMSdM1w1eS4/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641820006;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qOjp+7fgLCWvHM3GK57jDARVfOihrs+79IW7WyircY8=;
        b=zFB80qNmvw7sddj4sIqBfjkuVTjE42vQzAWddl8hF2vSwGwrNgxqDPZkriyfSgY9xjH8I7
        B5C+QcUAy7y0mjAQ==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: Avoid accidental unstable marking of
 clocksources
Cc:     Waiman Long <longman@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164182000537.16921.12497963671363009273.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c86ff8c55b8ae68837b2fa59dc0c203907e9a15f
Gitweb:        https://git.kernel.org/tip/c86ff8c55b8ae68837b2fa59dc0c203907e9a15f
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 18 Nov 2021 14:14:36 -05:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 30 Nov 2021 17:22:29 -08:00

clocksource: Avoid accidental unstable marking of clocksources

Since commit db3a34e17433 ("clocksource: Retry clock read if long delays
detected") and commit 2e27e793e280 ("clocksource: Reduce clocksource-skew
threshold"), it is found that tsc clocksource fallback to hpet can
sometimes happen on both Intel and AMD systems especially when they are
running stressful benchmarking workloads. Of the 23 systems tested with
a v5.14 kernel, 10 of them have switched to hpet clock source during
the test run.

The result of falling back to hpet is a drastic reduction of performance
when running benchmarks. For example, the fio performance tests can
drop up to 70% whereas the iperf3 performance can drop up to 80%.

4 hpet fallbacks happened during bootup. They were:

  [    8.749399] clocksource: timekeeping watchdog on CPU13: hpet read-back delay of 263750ns, attempt 4, marking unstable
  [   12.044610] clocksource: timekeeping watchdog on CPU19: hpet read-back delay of 186166ns, attempt 4, marking unstable
  [   17.336941] clocksource: timekeeping watchdog on CPU28: hpet read-back delay of 182291ns, attempt 4, marking unstable
  [   17.518565] clocksource: timekeeping watchdog on CPU34: hpet read-back delay of 252196ns, attempt 4, marking unstable

Other fallbacks happen when the systems were running stressful
benchmarks. For example:

  [ 2685.867873] clocksource: timekeeping watchdog on CPU117: hpet read-back delay of 57269ns, attempt 4, marking unstable
  [46215.471228] clocksource: timekeeping watchdog on CPU8: hpet read-back delay of 61460ns, attempt 4, marking unstable

Commit 2e27e793e280 ("clocksource: Reduce clocksource-skew threshold"),
changed the skew margin from 100us to 50us. I think this is too small
and can easily be exceeded when running some stressful workloads on a
thermally stressed system.  So it is switched back to 100us.

Even a maximum skew margin of 100us may be too small in for some systems
when booting up especially if those systems are under thermal stress. To
eliminate the case that the large skew is due to the system being too
busy slowing down the reading of both the watchdog and the clocksource,
an extra consecutive read of watchdog clock is being done to check this.

The consecutive watchdog read delay is compared against
WATCHDOG_MAX_SKEW/2. If the delay exceeds the limit, we assume that
the system is just too busy. A warning will be printed to the console
and the clock skew check is skipped for this round.

Fixes: db3a34e17433 ("clocksource: Retry clock read if long delays detected")
Fixes: 2e27e793e280 ("clocksource: Reduce clocksource-skew threshold")
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/time/clocksource.c | 50 +++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index b8a14d2..bcad1a1 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -107,7 +107,7 @@ static u64 suspend_start;
  * This delay could be due to SMIs, NMIs, or to VCPU preemptions.  Used as
  * a lower bound for cs->uncertainty_margin values when registering clocks.
  */
-#define WATCHDOG_MAX_SKEW (50 * NSEC_PER_USEC)
+#define WATCHDOG_MAX_SKEW (100 * NSEC_PER_USEC)
 
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
 static void clocksource_watchdog_work(struct work_struct *work);
@@ -205,17 +205,24 @@ EXPORT_SYMBOL_GPL(max_cswd_read_retries);
 static int verify_n_cpus = 8;
 module_param(verify_n_cpus, int, 0644);
 
-static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
+enum wd_read_status {
+	WD_READ_SUCCESS,
+	WD_READ_UNSTABLE,
+	WD_READ_SKIP
+};
+
+static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 {
 	unsigned int nretries;
-	u64 wd_end, wd_delta;
-	int64_t wd_delay;
+	u64 wd_end, wd_end2, wd_delta;
+	int64_t wd_delay, wd_seq_delay;
 
 	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
 		local_irq_disable();
 		*wdnow = watchdog->read(watchdog);
 		*csnow = cs->read(cs);
 		wd_end = watchdog->read(watchdog);
+		wd_end2 = watchdog->read(watchdog);
 		local_irq_enable();
 
 		wd_delta = clocksource_delta(wd_end, *wdnow, watchdog->mask);
@@ -226,13 +233,34 @@ static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
 					smp_processor_id(), watchdog->name, nretries);
 			}
-			return true;
+			return WD_READ_SUCCESS;
 		}
+
+		/*
+		 * Now compute delay in consecutive watchdog read to see if
+		 * there is too much external interferences that cause
+		 * significant delay in reading both clocksource and watchdog.
+		 *
+		 * If consecutive WD read-back delay > WATCHDOG_MAX_SKEW/2,
+		 * report system busy, reinit the watchdog and skip the current
+		 * watchdog test.
+		 */
+		wd_delta = clocksource_delta(wd_end2, wd_end, watchdog->mask);
+		wd_seq_delay = clocksource_cyc2ns(wd_delta, watchdog->mult, watchdog->shift);
+		if (wd_seq_delay > WATCHDOG_MAX_SKEW/2)
+			goto skip_test;
 	}
 
 	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, marking unstable\n",
 		smp_processor_id(), watchdog->name, wd_delay, nretries);
-	return false;
+	return WD_READ_UNSTABLE;
+
+skip_test:
+	pr_info("timekeeping watchdog on CPU%d: %s wd-wd read-back delay of %lldns\n",
+		smp_processor_id(), watchdog->name, wd_seq_delay);
+	pr_info("wd-%s-wd read-back delay of %lldns, clock-skew test skipped!\n",
+		cs->name, wd_delay);
+	return WD_READ_SKIP;
 }
 
 static u64 csnow_mid;
@@ -356,6 +384,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 	int next_cpu, reset_pending;
 	int64_t wd_nsec, cs_nsec;
 	struct clocksource *cs;
+	enum wd_read_status read_ret;
 	u32 md;
 
 	spin_lock(&watchdog_lock);
@@ -373,9 +402,12 @@ static void clocksource_watchdog(struct timer_list *unused)
 			continue;
 		}
 
-		if (!cs_watchdog_read(cs, &csnow, &wdnow)) {
-			/* Clock readout unreliable, so give it up. */
-			__clocksource_unstable(cs);
+		read_ret = cs_watchdog_read(cs, &csnow, &wdnow);
+
+		if (read_ret != WD_READ_SUCCESS) {
+			if (read_ret == WD_READ_UNSTABLE)
+				/* Clock readout unreliable, so give it up. */
+				__clocksource_unstable(cs);
 			continue;
 		}
 
