Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AED2D7377
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Dec 2020 11:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405781AbgLKKJE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 11 Dec 2020 05:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394197AbgLKKIa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 11 Dec 2020 05:08:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA16C0613CF;
        Fri, 11 Dec 2020 02:07:50 -0800 (PST)
Date:   Fri, 11 Dec 2020 10:07:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607681268;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gHiqA8GHFxL/ToxBKHZfRQpH2SQ83KS/T+eox+o45o=;
        b=0kl8N2kgZFgHLJQfE1WsFMyKc8AVfz8yA9Ukl9kXDU6G19yUeDc9q5OBuN+Gerhe+4kPvR
        H8DTzdG6LQ4zxPWgQ5hpNhFb1FQX6LB1gWSDjOpidKR26dTDs1JO2QVUlZ1ZVyxNHZmDws
        rSXTb12F8fivYhc0pTonwGUEyNnvyFobzIXYCVcdwGwk+rAt2E/9c8gUdDOBS5w9k9Vd1e
        0OGbqvWcOF8Nff54rLGN2m9Tc36a9jwNhduPG5t1oeiyyDklSpAk8H5LGUVKfRSW+C8UPu
        GvHq/wer8ZCoRDM3Z07l2ezaIuKamc7gRawF0jGuMXgcKlwmLH9eTWXRUAcY4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607681268;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gHiqA8GHFxL/ToxBKHZfRQpH2SQ83KS/T+eox+o45o=;
        b=uXaj2aCgk3RvUdj6zcByHg2tAvrMvcM+ObU6HlTssaSwG1qACZxCZGx6L3sjZShVJI4fDO
        f7zdqfuBmAc9bKAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp, rtc: Move rtc_set_ntp_time() to ntp code
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201206220542.166871172@linutronix.de>
References: <20201206220542.166871172@linutronix.de>
MIME-Version: 1.0
Message-ID: <160768126799.3364.10748276273069103417.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     33e62e832384c8cb523044e0e9d99d7133f98e93
Gitweb:        https://git.kernel.org/tip/33e62e832384c8cb523044e0e9d99d7133f98e93
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 06 Dec 2020 22:46:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 11 Dec 2020 10:40:52 +01:00

ntp, rtc: Move rtc_set_ntp_time() to ntp code

rtc_set_ntp_time() is not really RTC functionality as the code is just a
user of RTC. Move it into the NTP code which allows further cleanups.

Requested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20201206220542.166871172@linutronix.de

---
 drivers/rtc/Makefile  |  1 +-
 drivers/rtc/systohc.c | 61 +-----------------------------
 include/linux/rtc.h   | 34 +----------------
 kernel/time/ntp.c     | 88 ++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 85 insertions(+), 99 deletions(-)
 delete mode 100644 drivers/rtc/systohc.c

diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index bfb5746..bb8f319 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -6,7 +6,6 @@
 ccflags-$(CONFIG_RTC_DEBUG)	:= -DDEBUG
 
 obj-$(CONFIG_RTC_LIB)		+= lib.o
-obj-$(CONFIG_RTC_SYSTOHC)	+= systohc.o
 obj-$(CONFIG_RTC_CLASS)		+= rtc-core.o
 obj-$(CONFIG_RTC_MC146818_LIB)	+= rtc-mc146818-lib.o
 rtc-core-y			:= class.o interface.o
diff --git a/drivers/rtc/systohc.c b/drivers/rtc/systohc.c
deleted file mode 100644
index 8b70f05..0000000
--- a/drivers/rtc/systohc.c
+++ /dev/null
@@ -1,61 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/rtc.h>
-#include <linux/time.h>
-
-/**
- * rtc_set_ntp_time - Save NTP synchronized time to the RTC
- * @now: Current time of day
- * @target_nsec: pointer for desired now->tv_nsec value
- *
- * Replacement for the NTP platform function update_persistent_clock64
- * that stores time for later retrieval by rtc_hctosys.
- *
- * Returns 0 on successful RTC update, -ENODEV if a RTC update is not
- * possible at all, and various other -errno for specific temporary failure
- * cases.
- *
- * -EPROTO is returned if now.tv_nsec is not close enough to *target_nsec.
- *
- * If temporary failure is indicated the caller should try again 'soon'
- */
-int rtc_set_ntp_time(struct timespec64 now, unsigned long *target_nsec)
-{
-	struct rtc_device *rtc;
-	struct rtc_time tm;
-	struct timespec64 to_set;
-	int err = -ENODEV;
-	bool ok;
-
-	rtc = rtc_class_open(CONFIG_RTC_SYSTOHC_DEVICE);
-	if (!rtc)
-		goto out_err;
-
-	if (!rtc->ops || !rtc->ops->set_time)
-		goto out_close;
-
-	/* Compute the value of tv_nsec we require the caller to supply in
-	 * now.tv_nsec.  This is the value such that (now +
-	 * set_offset_nsec).tv_nsec == 0.
-	 */
-	set_normalized_timespec64(&to_set, 0, -rtc->set_offset_nsec);
-	*target_nsec = to_set.tv_nsec;
-
-	/* The ntp code must call this with the correct value in tv_nsec, if
-	 * it does not we update target_nsec and return EPROTO to make the ntp
-	 * code try again later.
-	 */
-	ok = rtc_tv_nsec_ok(rtc->set_offset_nsec, &to_set, &now);
-	if (!ok) {
-		err = -EPROTO;
-		goto out_close;
-	}
-
-	rtc_time64_to_tm(to_set.tv_sec, &tm);
-
-	err = rtc_set_time(rtc, &tm);
-
-out_close:
-	rtc_class_close(rtc);
-out_err:
-	return err;
-}
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 22d1575..ff62680 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -165,7 +165,6 @@ int __rtc_register_device(struct module *owner, struct rtc_device *rtc);
 
 extern int rtc_read_time(struct rtc_device *rtc, struct rtc_time *tm);
 extern int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm);
-extern int rtc_set_ntp_time(struct timespec64 now, unsigned long *target_nsec);
 int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm);
 extern int rtc_read_alarm(struct rtc_device *rtc,
 			struct rtc_wkalrm *alrm);
@@ -205,39 +204,6 @@ static inline bool is_leap_year(unsigned int year)
 	return (!(year % 4) && (year % 100)) || !(year % 400);
 }
 
-/* Determine if we can call to driver to set the time. Drivers can only be
- * called to set a second aligned time value, and the field set_offset_nsec
- * specifies how far away from the second aligned time to call the driver.
- *
- * This also computes 'to_set' which is the time we are trying to set, and has
- * a zero in tv_nsecs, such that:
- *    to_set - set_delay_nsec == now +/- FUZZ
- *
- */
-static inline bool rtc_tv_nsec_ok(s64 set_offset_nsec,
-				  struct timespec64 *to_set,
-				  const struct timespec64 *now)
-{
-	/* Allowed error in tv_nsec, arbitarily set to 5 jiffies in ns. */
-	const unsigned long TIME_SET_NSEC_FUZZ = TICK_NSEC * 5;
-	struct timespec64 delay = {.tv_sec = 0,
-				   .tv_nsec = set_offset_nsec};
-
-	*to_set = timespec64_add(*now, delay);
-
-	if (to_set->tv_nsec < TIME_SET_NSEC_FUZZ) {
-		to_set->tv_nsec = 0;
-		return true;
-	}
-
-	if (to_set->tv_nsec > NSEC_PER_SEC - TIME_SET_NSEC_FUZZ) {
-		to_set->tv_sec++;
-		to_set->tv_nsec = 0;
-		return true;
-	}
-	return false;
-}
-
 #define rtc_register_device(device) \
 	__rtc_register_device(THIS_MODULE, device)
 
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index ff1a7b8..84a5546 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -519,15 +519,94 @@ static void sched_sync_hw_clock(unsigned long offset_nsec, bool retry)
 	hrtimer_start(&sync_hrtimer, exp, HRTIMER_MODE_ABS);
 }
 
+/*
+ * Determine if we can call to driver to set the time. Drivers can only be
+ * called to set a second aligned time value, and the field set_offset_nsec
+ * specifies how far away from the second aligned time to call the driver.
+ *
+ * This also computes 'to_set' which is the time we are trying to set, and has
+ * a zero in tv_nsecs, such that:
+ *    to_set - set_delay_nsec == now +/- FUZZ
+ *
+ */
+static inline bool rtc_tv_nsec_ok(long set_offset_nsec,
+				  struct timespec64 *to_set,
+				  const struct timespec64 *now)
+{
+	/* Allowed error in tv_nsec, arbitarily set to 5 jiffies in ns. */
+	const unsigned long TIME_SET_NSEC_FUZZ = TICK_NSEC * 5;
+	struct timespec64 delay = {.tv_sec = 0,
+				   .tv_nsec = set_offset_nsec};
+
+	*to_set = timespec64_add(*now, delay);
+
+	if (to_set->tv_nsec < TIME_SET_NSEC_FUZZ) {
+		to_set->tv_nsec = 0;
+		return true;
+	}
+
+	if (to_set->tv_nsec > NSEC_PER_SEC - TIME_SET_NSEC_FUZZ) {
+		to_set->tv_sec++;
+		to_set->tv_nsec = 0;
+		return true;
+	}
+	return false;
+}
+
+#ifdef CONFIG_RTC_SYSTOHC
+/*
+ * rtc_set_ntp_time - Save NTP synchronized time to the RTC
+ */
+static int rtc_set_ntp_time(struct timespec64 now, unsigned long *target_nsec)
+{
+	struct rtc_device *rtc;
+	struct rtc_time tm;
+	struct timespec64 to_set;
+	int err = -ENODEV;
+	bool ok;
+
+	rtc = rtc_class_open(CONFIG_RTC_SYSTOHC_DEVICE);
+	if (!rtc)
+		goto out_err;
+
+	if (!rtc->ops || !rtc->ops->set_time)
+		goto out_close;
+
+	/*
+	 * Compute the value of tv_nsec we require the caller to supply in
+	 * now.tv_nsec.  This is the value such that (now +
+	 * set_offset_nsec).tv_nsec == 0.
+	 */
+	set_normalized_timespec64(&to_set, 0, -rtc->set_offset_nsec);
+	*target_nsec = to_set.tv_nsec;
+
+	/*
+	 * The ntp code must call this with the correct value in tv_nsec, if
+	 * it does not we update target_nsec and return EPROTO to make the ntp
+	 * code try again later.
+	 */
+	ok = rtc_tv_nsec_ok(rtc->set_offset_nsec, &to_set, &now);
+	if (!ok) {
+		err = -EPROTO;
+		goto out_close;
+	}
+
+	rtc_time64_to_tm(to_set.tv_sec, &tm);
+
+	err = rtc_set_time(rtc, &tm);
+
+out_close:
+	rtc_class_close(rtc);
+out_err:
+	return err;
+}
+
 static void sync_rtc_clock(void)
 {
 	unsigned long offset_nsec;
 	struct timespec64 adjust;
 	int rc;
 
-	if (!IS_ENABLED(CONFIG_RTC_SYSTOHC))
-		return;
-
 	ktime_get_real_ts64(&adjust);
 
 	if (persistent_clock_is_local)
@@ -544,6 +623,9 @@ static void sync_rtc_clock(void)
 
 	sched_sync_hw_clock(offset_nsec, rc != 0);
 }
+#else
+static inline void sync_rtc_clock(void) { }
+#endif
 
 #ifdef CONFIG_GENERIC_CMOS_UPDATE
 int __weak update_persistent_clock64(struct timespec64 now64)
