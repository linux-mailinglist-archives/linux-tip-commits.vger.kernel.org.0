Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACC12D7374
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Dec 2020 11:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394189AbgLKKJD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 11 Dec 2020 05:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393561AbgLKKIc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 11 Dec 2020 05:08:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA557C0613D6;
        Fri, 11 Dec 2020 02:07:51 -0800 (PST)
Date:   Fri, 11 Dec 2020 10:07:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607681268;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OnPb+NYE90rQ7vsZYWXliFZr/veWQ7niRgPwCnMCk1o=;
        b=LsYMoz+3hlz6LhOTcKkerutqII5fqzW2bH+QrJKkYKEtJ5FjIdV0nSRCiipzaHSUAxp82T
        NnGcELYKTnw3zrLoi5vo+yM6QQOMKp8PHHE8JebDcqwwC3kw1+VP8UaRPTmhXpzM8gbnM+
        XZ+3HbrfQLpr+sBLZD3lj+O/21LmOLoKx/Vk1sJ6HkO8fz35vqJ3AsMbjXHXMKGoBPs6H4
        Ov2rllHSscOjtLrN8lXbbK5pXL0DiHNpQOQaPpZEhSSOLJLH8cht8u8A/+EJFGefhoNUby
        Alv47ShT08YzwYkujr+i/HzPBYo89lL7H8jSuREHtbyAX32j8G1Vs0rHYbtp+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607681268;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OnPb+NYE90rQ7vsZYWXliFZr/veWQ7niRgPwCnMCk1o=;
        b=0Qp9gSHIe8sOWwEgXXM7AT6kXfZy7X0QQVVEvgduvqOw6RoU5235ueIHUKM4YJSRvsWikL
        V15yC90EKXBAq6CA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Consolidate the RTC update implementation
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201206220542.355743355@linutronix.de>
References: <20201206220542.355743355@linutronix.de>
MIME-Version: 1.0
Message-ID: <160768126734.3364.2452556268348598426.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     76e87d96b30b5fee91b381fbc444a3eabcd9469a
Gitweb:        https://git.kernel.org/tip/76e87d96b30b5fee91b381fbc444a3eabcd9469a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 06 Dec 2020 22:46:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 11 Dec 2020 10:40:53 +01:00

ntp: Consolidate the RTC update implementation

The code for the legacy RTC and the RTC class based update are pretty much
the same. Consolidate the common parts into one function and just invoke
the actual setter functions.

For RTC class based devices the update code checks whether the offset is
valid for the device, which is usually not the case for the first
invocation. If it's not the same it stores the correct offset and lets the
caller try again. That's not much different from the previous approach
where the first invocation had a pretty low probability to actually hit the
allowed window.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20201206220542.355743355@linutronix.de

---
 kernel/time/ntp.c | 144 ++++++++++++++++-----------------------------
 1 file changed, 52 insertions(+), 92 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index a34ac06..7404d38 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -564,118 +564,53 @@ static inline bool rtc_tv_nsec_ok(unsigned long set_offset_nsec,
 	return false;
 }
 
+#ifdef CONFIG_GENERIC_CMOS_UPDATE
+int __weak update_persistent_clock64(struct timespec64 now64)
+{
+	return -ENODEV;
+}
+#else
+static inline int update_persistent_clock64(struct timespec64 now64)
+{
+	return -ENODEV;
+}
+#endif
+
 #ifdef CONFIG_RTC_SYSTOHC
-/*
- * rtc_set_ntp_time - Save NTP synchronized time to the RTC
- */
-static int rtc_set_ntp_time(struct timespec64 now, unsigned long *offset_nsec)
+/* Save NTP synchronized time to the RTC */
+static int update_rtc(struct timespec64 *to_set, unsigned long *offset_nsec)
 {
-	struct timespec64 to_set;
 	struct rtc_device *rtc;
 	struct rtc_time tm;
 	int err = -ENODEV;
-	bool ok;
 
 	rtc = rtc_class_open(CONFIG_RTC_SYSTOHC_DEVICE);
 	if (!rtc)
-		goto out_err;
+		return -ENODEV;
 
 	if (!rtc->ops || !rtc->ops->set_time)
 		goto out_close;
 
-	/* Store the update offset for this RTC */
-	*offset_nsec = rtc->set_offset_nsec;
-
-	ok = rtc_tv_nsec_ok(rtc->set_offset_nsec, &to_set, &now);
-	if (!ok) {
-		err = -EPROTO;
-		goto out_close;
+	/* First call might not have the correct offset */
+	if (*offset_nsec == rtc->set_offset_nsec) {
+		rtc_time64_to_tm(to_set->tv_sec, &tm);
+		err = rtc_set_time(rtc, &tm);
+	} else {
+		/* Store the update offset and let the caller try again */
+		*offset_nsec = rtc->set_offset_nsec;
+		err = -EAGAIN;
 	}
-
-	rtc_time64_to_tm(to_set.tv_sec, &tm);
-
-	err = rtc_set_time(rtc, &tm);
-
 out_close:
 	rtc_class_close(rtc);
-out_err:
 	return err;
 }
-
-static void sync_rtc_clock(void)
-{
-	unsigned long offset_nsec;
-	struct timespec64 adjust;
-	int rc;
-
-	ktime_get_real_ts64(&adjust);
-
-	if (persistent_clock_is_local)
-		adjust.tv_sec -= (sys_tz.tz_minuteswest * 60);
-
-	/*
-	 * The current RTC in use will provide the nanoseconds offset prior
-	 * to a full second it wants to be called at, and invokes
-	 * rtc_tv_nsec_ok() internally.
-	 */
-	rc = rtc_set_ntp_time(adjust, &offset_nsec);
-	if (rc == -ENODEV)
-		return;
-
-	sched_sync_hw_clock(offset_nsec, rc != 0);
-}
 #else
-static inline void sync_rtc_clock(void) { }
-#endif
-
-#ifdef CONFIG_GENERIC_CMOS_UPDATE
-int __weak update_persistent_clock64(struct timespec64 now64)
+static inline int update_rtc(struct timespec64 *to_set, unsigned long *offset_nsec)
 {
 	return -ENODEV;
 }
 #endif
 
-static bool sync_cmos_clock(void)
-{
-	static bool no_cmos;
-	struct timespec64 now;
-	struct timespec64 adjust;
-	int rc = -EPROTO;
-	long target_nsec = NSEC_PER_SEC / 2;
-
-	if (!IS_ENABLED(CONFIG_GENERIC_CMOS_UPDATE))
-		return false;
-
-	if (no_cmos)
-		return false;
-
-	/*
-	 * Historically update_persistent_clock64() has followed x86
-	 * semantics, which match the MC146818A/etc RTC. This RTC will store
-	 * 'adjust' and then in .5s it will advance once second.
-	 *
-	 * Architectures are strongly encouraged to use rtclib and not
-	 * implement this legacy API.
-	 */
-	ktime_get_real_ts64(&now);
-	if (rtc_tv_nsec_ok(target_nsec, &adjust, &now)) {
-		if (persistent_clock_is_local)
-			adjust.tv_sec -= (sys_tz.tz_minuteswest * 60);
-		rc = update_persistent_clock64(adjust);
-		/*
-		 * The machine does not support update_persistent_clock64 even
-		 * though it defines CONFIG_GENERIC_CMOS_UPDATE.
-		 */
-		if (rc == -ENODEV) {
-			no_cmos = true;
-			return false;
-		}
-	}
-
-	sched_sync_hw_clock(target_nsec, rc != 0);
-	return true;
-}
-
 /*
  * If we have an externally synchronized Linux clock, then update RTC clock
  * accordingly every ~11 minutes. Generally RTCs can only store second
@@ -687,6 +622,15 @@ static bool sync_cmos_clock(void)
 static void sync_hw_clock(struct work_struct *work)
 {
 	/*
+	 * The default synchronization offset is 500ms for the deprecated
+	 * update_persistent_clock64() under the assumption that it uses
+	 * the infamous CMOS clock (MC146818).
+	 */
+	static unsigned long offset_nsec = NSEC_PER_SEC / 2;
+	struct timespec64 now, to_set;
+	int res = -EAGAIN;
+
+	/*
 	 * Don't update if STA_UNSYNC is set and if ntp_notify_cmos_timer()
 	 * managed to schedule the work between the timer firing and the
 	 * work being able to rearm the timer. Wait for the timer to expire.
@@ -694,10 +638,26 @@ static void sync_hw_clock(struct work_struct *work)
 	if (!ntp_synced() || hrtimer_is_queued(&sync_hrtimer))
 		return;
 
-	if (sync_cmos_clock())
-		return;
+	ktime_get_real_ts64(&now);
+	/* If @now is not in the allowed window, try again */
+	if (!rtc_tv_nsec_ok(offset_nsec, &to_set, &now))
+		goto rearm;
 
-	sync_rtc_clock();
+	/* Take timezone adjusted RTCs into account */
+	if (persistent_clock_is_local)
+		to_set.tv_sec -= (sys_tz.tz_minuteswest * 60);
+
+	/* Try the legacy RTC first. */
+	res = update_persistent_clock64(to_set);
+	if (res != -ENODEV)
+		goto rearm;
+
+	/* Try the RTC class */
+	res = update_rtc(&to_set, &offset_nsec);
+	if (res == -ENODEV)
+		return;
+rearm:
+	sched_sync_hw_clock(offset_nsec, res != 0);
 }
 
 void ntp_notify_cmos_timer(void)
