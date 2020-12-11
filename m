Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580162D737B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Dec 2020 11:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394164AbgLKKJE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 11 Dec 2020 05:09:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33648 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394184AbgLKKIc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 11 Dec 2020 05:08:32 -0500
Date:   Fri, 11 Dec 2020 10:07:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607681268;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ldzFHP1rhRmylQS9dP0XRsrB5k8hhlWfguVI3gd1Mwc=;
        b=iye3g0BhRcuyh/Wiq2SNbp2GkyfxlQ9K4b1WIrePKpsoGYVY0utNIMzKGvdK9RMaNVlmrE
        EBDexlQ9ODvR0CfZa4a+BK1dHX323EDHSilzWI7bZ9dP3J/fyxulY7s19GM3JqSo5t8Wp5
        KijmuKzt0CJOK98b1BnM6OgO5tsKx1R6R7UcnXbeUhgJbOO9PawlFMvAKgvPTiScvMvX9M
        /eXL0ULZlspYXoHk6SKO7yJ/gw53lT6O4FwIoiH/ug/tOSneDNhkJfe4Rf+Jj7wUcTPbSV
        /zaYflxKG8lgz/uJa27d8TR+wtIjcr8iVq1Q4g0rPkiUddw+WWBvIuPbwkz/ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607681268;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ldzFHP1rhRmylQS9dP0XRsrB5k8hhlWfguVI3gd1Mwc=;
        b=mUxsHInu8A8Nm8Iu/DFLq+U750QzHleLwLY5btViEkcrBIcdet9XNSej7dbx0irr8RKCEB
        LnNBUMtXiZ92hVBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Make the RTC synchronization more reliable
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201206220542.062910520@linutronix.de>
References: <20201206220542.062910520@linutronix.de>
MIME-Version: 1.0
Message-ID: <160768126826.3364.12479539672107416588.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c9e6189fb03123a7dfb93589280347b46f30b161
Gitweb:        https://git.kernel.org/tip/c9e6189fb03123a7dfb93589280347b46f30b161
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 06 Dec 2020 22:46:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 11 Dec 2020 10:40:52 +01:00

ntp: Make the RTC synchronization more reliable

Miroslav reported that the periodic RTC synchronization in the NTP code
fails more often than not to hit the specified update window.

The reason is that the code uses delayed_work to schedule the update which
needs to be in thread context as the underlying RTC might be connected via
a slow bus, e.g. I2C. In the update function it verifies whether the
current time is correct vs. the requirements of the underlying RTC.

But delayed_work is using the timer wheel for scheduling which is
inaccurate by design. Depending on the distance to the expiry the wheel
gets less granular to allow batching and to avoid the cascading of the
original timer wheel. See 500462a9de65 ("timers: Switch to a non-cascading
wheel") and the code for further details.

The code already deals with this by splitting the 660 seconds period into a
long 659 seconds timer and then retrying with a smaller delta.

But looking at the actual granularities of the timer wheel (which depend on
the HZ configuration) the 659 seconds timer ends up in an outer wheel level
and is affected by a worst case granularity of:

HZ          Granularity
1000        32s
 250        16s
 100        40s

So the initial timer can be already off by max 12.5% which is not a big
issue as the period of the sync is defined as ~11 minutes.

The fine grained second attempt schedules to the desired update point with
a timer expiring less than a second from now. Depending on the actual delta
and the HZ setting even the second attempt can end up in outer wheel levels
which have a large enough granularity to make the correctness check fail.

As this is a fundamental property of the timer wheel there is no way to
make this more accurate short of iterating in one jiffies steps towards the
update point.

Switch it to an hrtimer instead which schedules the actual update work. The
hrtimer will expire precisely (max 1 jiffie delay when high resolution
timers are not available). The actual scheduling delay of the work is the
same as before.

The update is triggered from do_adjtimex() which is a bit racy but not much
more racy than it was before:

     if (ntp_synced())
     	queue_delayed_work(system_power_efficient_wq, &sync_work, 0);

which is racy when the work is currently executed and has not managed to
reschedule itself.

This becomes now:

     if (ntp_synced() && !hrtimer_is_queued(&sync_hrtimer))
     	queue_work(system_power_efficient_wq, &sync_work, 0);

which is racy when the hrtimer has expired and the work is currently
executed and has not yet managed to rearm the hrtimer.

Not a big problem as it just schedules work for nothing.

The new implementation has a safe guard in place to catch the case where
the hrtimer is queued on entry to the work function and avoids an extra
update attempt of the RTC that way.

Reported-by: Miroslav Lichvar <mlichvar@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Miroslav Lichvar <mlichvar@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20201206220542.062910520@linutronix.de

---
 include/linux/timex.h      |  1 +-
 kernel/time/ntp.c          | 90 +++++++++++++++++++------------------
 kernel/time/ntp_internal.h |  7 +++-
 3 files changed, 55 insertions(+), 43 deletions(-)

diff --git a/include/linux/timex.h b/include/linux/timex.h
index ce08597..9c2e54f 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -157,7 +157,6 @@ extern int do_clock_adjtime(const clockid_t which_clock, struct __kernel_timex *
 extern void hardpps(const struct timespec64 *, const struct timespec64 *);
 
 int read_current_timer(unsigned long *timer_val);
-void ntp_notify_cmos_timer(void);
 
 /* The clock frequency of the i8253/i8254 PIT */
 #define PIT_TICK_RATE 1193182ul
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 069ca78..ff1a7b8 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -494,65 +494,55 @@ out:
 	return leap;
 }
 
+#if defined(CONFIG_GENERIC_CMOS_UPDATE) || defined(CONFIG_RTC_SYSTOHC)
 static void sync_hw_clock(struct work_struct *work);
-static DECLARE_DELAYED_WORK(sync_work, sync_hw_clock);
-
-static void sched_sync_hw_clock(struct timespec64 now,
-				unsigned long target_nsec, bool fail)
+static DECLARE_WORK(sync_work, sync_hw_clock);
+static struct hrtimer sync_hrtimer;
+#define SYNC_PERIOD_NS (11UL * 60 * NSEC_PER_SEC)
 
+static enum hrtimer_restart sync_timer_callback(struct hrtimer *timer)
 {
-	struct timespec64 next;
+	queue_work(system_power_efficient_wq, &sync_work);
 
-	ktime_get_real_ts64(&next);
-	if (!fail)
-		next.tv_sec = 659;
-	else {
-		/*
-		 * Try again as soon as possible. Delaying long periods
-		 * decreases the accuracy of the work queue timer. Due to this
-		 * the algorithm is very likely to require a short-sleep retry
-		 * after the above long sleep to synchronize ts_nsec.
-		 */
-		next.tv_sec = 0;
-	}
+	return HRTIMER_NORESTART;
+}
 
-	/* Compute the needed delay that will get to tv_nsec == target_nsec */
-	next.tv_nsec = target_nsec - next.tv_nsec;
-	if (next.tv_nsec <= 0)
-		next.tv_nsec += NSEC_PER_SEC;
-	if (next.tv_nsec >= NSEC_PER_SEC) {
-		next.tv_sec++;
-		next.tv_nsec -= NSEC_PER_SEC;
-	}
+static void sched_sync_hw_clock(unsigned long offset_nsec, bool retry)
+{
+	ktime_t exp = ktime_set(ktime_get_real_seconds(), 0);
+
+	if (retry)
+		exp = ktime_add_ns(exp, 2 * NSEC_PER_SEC - offset_nsec);
+	else
+		exp = ktime_add_ns(exp, SYNC_PERIOD_NS - offset_nsec);
 
-	queue_delayed_work(system_power_efficient_wq, &sync_work,
-			   timespec64_to_jiffies(&next));
+	hrtimer_start(&sync_hrtimer, exp, HRTIMER_MODE_ABS);
 }
 
 static void sync_rtc_clock(void)
 {
-	unsigned long target_nsec;
-	struct timespec64 adjust, now;
+	unsigned long offset_nsec;
+	struct timespec64 adjust;
 	int rc;
 
 	if (!IS_ENABLED(CONFIG_RTC_SYSTOHC))
 		return;
 
-	ktime_get_real_ts64(&now);
+	ktime_get_real_ts64(&adjust);
 
-	adjust = now;
 	if (persistent_clock_is_local)
 		adjust.tv_sec -= (sys_tz.tz_minuteswest * 60);
 
 	/*
-	 * The current RTC in use will provide the target_nsec it wants to be
-	 * called at, and does rtc_tv_nsec_ok internally.
+	 * The current RTC in use will provide the nanoseconds offset prior
+	 * to a full second it wants to be called at, and invokes
+	 * rtc_tv_nsec_ok() internally.
 	 */
-	rc = rtc_set_ntp_time(adjust, &target_nsec);
+	rc = rtc_set_ntp_time(adjust, &offset_nsec);
 	if (rc == -ENODEV)
 		return;
 
-	sched_sync_hw_clock(now, target_nsec, rc);
+	sched_sync_hw_clock(offset_nsec, rc != 0);
 }
 
 #ifdef CONFIG_GENERIC_CMOS_UPDATE
@@ -599,7 +589,7 @@ static bool sync_cmos_clock(void)
 		}
 	}
 
-	sched_sync_hw_clock(now, target_nsec, rc);
+	sched_sync_hw_clock(target_nsec, rc != 0);
 	return true;
 }
 
@@ -613,7 +603,12 @@ static bool sync_cmos_clock(void)
  */
 static void sync_hw_clock(struct work_struct *work)
 {
-	if (!ntp_synced())
+	/*
+	 * Don't update if STA_UNSYNC is set and if ntp_notify_cmos_timer()
+	 * managed to schedule the work between the timer firing and the
+	 * work being able to rearm the timer. Wait for the timer to expire.
+	 */
+	if (!ntp_synced() || hrtimer_is_queued(&sync_hrtimer))
 		return;
 
 	if (sync_cmos_clock())
@@ -624,13 +619,23 @@ static void sync_hw_clock(struct work_struct *work)
 
 void ntp_notify_cmos_timer(void)
 {
-	if (!ntp_synced())
-		return;
+	/*
+	 * When the work is currently executed but has not yet the timer
+	 * rearmed this queues the work immediately again. No big issue,
+	 * just a pointless work scheduled.
+	 */
+	if (ntp_synced() && !hrtimer_is_queued(&sync_hrtimer))
+		queue_work(system_power_efficient_wq, &sync_work);
+}
 
-	if (IS_ENABLED(CONFIG_GENERIC_CMOS_UPDATE) ||
-	    IS_ENABLED(CONFIG_RTC_SYSTOHC))
-		queue_delayed_work(system_power_efficient_wq, &sync_work, 0);
+static void __init ntp_init_cmos_sync(void)
+{
+	hrtimer_init(&sync_hrtimer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
+	sync_hrtimer.function = sync_timer_callback;
 }
+#else /* CONFIG_GENERIC_CMOS_UPDATE) || defined(CONFIG_RTC_SYSTOHC) */
+static inline void __init ntp_init_cmos_sync(void) { }
+#endif /* !CONFIG_GENERIC_CMOS_UPDATE) || defined(CONFIG_RTC_SYSTOHC) */
 
 /*
  * Propagate a new txc->status value into the NTP state:
@@ -1044,4 +1049,5 @@ __setup("ntp_tick_adj=", ntp_tick_adj_setup);
 void __init ntp_init(void)
 {
 	ntp_clear();
+	ntp_init_cmos_sync();
 }
diff --git a/kernel/time/ntp_internal.h b/kernel/time/ntp_internal.h
index 908ecaa..23d1b74 100644
--- a/kernel/time/ntp_internal.h
+++ b/kernel/time/ntp_internal.h
@@ -12,4 +12,11 @@ extern int __do_adjtimex(struct __kernel_timex *txc,
 			 const struct timespec64 *ts,
 			 s32 *time_tai, struct audit_ntp_data *ad);
 extern void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts);
+
+#if defined(CONFIG_GENERIC_CMOS_UPDATE) || defined(CONFIG_RTC_SYSTOHC)
+extern void ntp_notify_cmos_timer(void);
+#else
+static inline void ntp_notify_cmos_timer(void) { }
+#endif
+
 #endif /* _LINUX_NTP_INTERNAL_H */
