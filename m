Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931222D7373
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Dec 2020 11:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394182AbgLKKJD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 11 Dec 2020 05:09:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33630 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394164AbgLKKIb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 11 Dec 2020 05:08:31 -0500
Date:   Fri, 11 Dec 2020 10:07:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607681268;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WlYNEVxBVNztRGDxTMFg72n8i0Wo9K8LaxJOrHjbUNk=;
        b=2YCy17K8GLUMPoYcVw2BF4YlRFKPZ8e/ZMNPLskxas6OSiRHUSIngHPONQmcpDcsAkO0qF
        Y5vgcc/rKh24r9zquDYO2vWfmAFkvc+GVoKH1/m7W0H78gTHgSFzUenTg98M76EcKdh2ZC
        g/V9oY6QKX6jpxvYwh/p9AAZ+QhnjE7IinDvTsQ+4rR0KOfkYCxY3zz9EjD2XSbEYrZl7K
        pIAAIxhjnmHvm5FaJHBow/98dyW1lGxq6u2Zh4bNc2BE2iRAj+LLO2EIATJsjESM4EzuUL
        0YvMr0VTBsmuZUbkuWDdXFDSFd1ubxJoAHerCAfXL9vT4dArEx/CE9YMQs/qdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607681268;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WlYNEVxBVNztRGDxTMFg72n8i0Wo9K8LaxJOrHjbUNk=;
        b=E2ty7mI1aWd/oXyjHLEKC0VH7TM25gQatYn4KIgb9ZgTs3vZEFtsodleHmJkqDd1vfwvkN
        /MDsVzeOSH4NDRDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ntp: Make the RTC sync offset less obscure
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201206220542.263204937@linutronix.de>
References: <20201206220542.263204937@linutronix.de>
MIME-Version: 1.0
Message-ID: <160768126770.3364.14383548414490296178.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     69eca258c85000564577642ba28335eb4e1df8f0
Gitweb:        https://git.kernel.org/tip/69eca258c85000564577642ba28335eb4e1df8f0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 06 Dec 2020 22:46:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 11 Dec 2020 10:40:53 +01:00

ntp: Make the RTC sync offset less obscure

The current RTC set_offset_nsec value is not really intuitive to
understand. 

  tsched       twrite(t2.tv_sec - 1) 	 t2 (seconds increment)

The offset is calculated from twrite based on the assumption that t2 -
twrite == 1s. That means for the MC146818 RTC the offset needs to be
negative so that the write happens 500ms before t2.

It's easier to understand when the whole calculation is based on t2. That
avoids negative offsets and the meaning is obvious:

 t2 - twrite:     The time defined by the chip when seconds increment
      		  after the write.

 twrite - tsched: The time for the transport to the point where the chip
 	  	  is updated. 

==> set_offset_nsec =  t2 - tsched
    ttransport      =  twrite - tsched
    tRTCinc         =  t2 - twrite
==> set_offset_nsec =  ttransport + tRTCinc

tRTCinc is a chip property and can be obtained from the data sheet.

ttransport depends on how the RTC is connected. It is close to 0 for
directly accessible RTCs. For RTCs behind a slow bus, e.g. i2c, it's the
time required to send the update over the bus. This can be estimated or
even calibrated, but that's a different problem.

Adjust the implementation and update comments accordingly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20201206220542.263204937@linutronix.de

---
 drivers/rtc/class.c    |  9 ++++++--
 drivers/rtc/rtc-cmos.c |  2 +-
 include/linux/rtc.h    | 35 +++++++++++++++++++++++++------
 kernel/time/ntp.c      | 47 ++++++++++++++++++++---------------------
 4 files changed, 61 insertions(+), 32 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index d795737..5855aa2 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -200,8 +200,13 @@ static struct rtc_device *rtc_allocate_device(void)
 
 	device_initialize(&rtc->dev);
 
-	/* Drivers can revise this default after allocating the device. */
-	rtc->set_offset_nsec =  5 * NSEC_PER_MSEC;
+	/*
+	 * Drivers can revise this default after allocating the device.
+	 * The default is what most RTCs do: Increment seconds exactly one
+	 * second after the write happened. This adds a default transport
+	 * time of 5ms which is at least halfways close to reality.
+	 */
+	rtc->set_offset_nsec = NSEC_PER_SEC + 5 * NSEC_PER_MSEC;
 
 	rtc->irq_freq = 1;
 	rtc->max_user_freq = 64;
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 7728fac..c5bcd2a 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -869,7 +869,7 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 		goto cleanup2;
 
 	/* Set the sync offset for the periodic 11min update correct */
-	cmos_rtc.rtc->set_offset_nsec = -(NSEC_PER_SEC / 2);
+	cmos_rtc.rtc->set_offset_nsec = NSEC_PER_SEC / 2;
 
 	/* export at least the first block of NVRAM */
 	nvmem_cfg.size = address_space - NVRAM_OFFSET;
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index ff62680..b829382 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -110,13 +110,36 @@ struct rtc_device {
 	/* Some hardware can't support UIE mode */
 	int uie_unsupported;
 
-	/* Number of nsec it takes to set the RTC clock. This influences when
-	 * the set ops are called. An offset:
-	 *   - of 0.5 s will call RTC set for wall clock time 10.0 s at 9.5 s
-	 *   - of 1.5 s will call RTC set for wall clock time 10.0 s at 8.5 s
-	 *   - of -0.5 s will call RTC set for wall clock time 10.0 s at 10.5 s
+	/*
+	 * This offset specifies the update timing of the RTC.
+	 *
+	 * tsched     t1 write(t2.tv_sec - 1sec))  t2 RTC increments seconds
+	 *
+	 * The offset defines how tsched is computed so that the write to
+	 * the RTC (t2.tv_sec - 1sec) is correct versus the time required
+	 * for the transport of the write and the time which the RTC needs
+	 * to increment seconds the first time after the write (t2).
+	 *
+	 * For direct accessible RTCs tsched ~= t1 because the write time
+	 * is negligible. For RTCs behind slow busses the transport time is
+	 * significant and has to be taken into account.
+	 *
+	 * The time between the write (t1) and the first increment after
+	 * the write (t2) is RTC specific. For a MC146818 RTC it's 500ms,
+	 * for many others it's exactly 1 second. Consult the datasheet.
+	 *
+	 * The value of this offset is also used to calculate the to be
+	 * written value (t2.tv_sec - 1sec) at tsched.
+	 *
+	 * The default value for this is NSEC_PER_SEC + 10 msec default
+	 * transport time. The offset can be adjusted by drivers so the
+	 * calculation for the to be written value at tsched becomes
+	 * correct:
+	 *
+	 *	newval = tsched + set_offset_nsec - NSEC_PER_SEC
+	 * and  (tsched + set_offset_nsec) % NSEC_PER_SEC == 0
 	 */
-	long set_offset_nsec;
+	unsigned long set_offset_nsec;
 
 	bool registered;
 
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 84a5546..a34ac06 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -520,22 +520,33 @@ static void sched_sync_hw_clock(unsigned long offset_nsec, bool retry)
 }
 
 /*
- * Determine if we can call to driver to set the time. Drivers can only be
- * called to set a second aligned time value, and the field set_offset_nsec
- * specifies how far away from the second aligned time to call the driver.
+ * Check whether @now is correct versus the required time to update the RTC
+ * and calculate the value which needs to be written to the RTC so that the
+ * next seconds increment of the RTC after the write is aligned with the next
+ * seconds increment of clock REALTIME.
  *
- * This also computes 'to_set' which is the time we are trying to set, and has
- * a zero in tv_nsecs, such that:
- *    to_set - set_delay_nsec == now +/- FUZZ
+ * tsched     t1 write(t2.tv_sec - 1sec))	t2 RTC increments seconds
  *
+ * t2.tv_nsec == 0
+ * tsched = t2 - set_offset_nsec
+ * newval = t2 - NSEC_PER_SEC
+ *
+ * ==> neval = tsched + set_offset_nsec - NSEC_PER_SEC
+ *
+ * As the execution of this code is not guaranteed to happen exactly at
+ * tsched this allows it to happen within a fuzzy region:
+ *
+ *	abs(now - tsched) < FUZZ
+ *
+ * If @now is not inside the allowed window the function returns false.
  */
-static inline bool rtc_tv_nsec_ok(long set_offset_nsec,
+static inline bool rtc_tv_nsec_ok(unsigned long set_offset_nsec,
 				  struct timespec64 *to_set,
 				  const struct timespec64 *now)
 {
 	/* Allowed error in tv_nsec, arbitarily set to 5 jiffies in ns. */
 	const unsigned long TIME_SET_NSEC_FUZZ = TICK_NSEC * 5;
-	struct timespec64 delay = {.tv_sec = 0,
+	struct timespec64 delay = {.tv_sec = -1,
 				   .tv_nsec = set_offset_nsec};
 
 	*to_set = timespec64_add(*now, delay);
@@ -557,11 +568,11 @@ static inline bool rtc_tv_nsec_ok(long set_offset_nsec,
 /*
  * rtc_set_ntp_time - Save NTP synchronized time to the RTC
  */
-static int rtc_set_ntp_time(struct timespec64 now, unsigned long *target_nsec)
+static int rtc_set_ntp_time(struct timespec64 now, unsigned long *offset_nsec)
 {
+	struct timespec64 to_set;
 	struct rtc_device *rtc;
 	struct rtc_time tm;
-	struct timespec64 to_set;
 	int err = -ENODEV;
 	bool ok;
 
@@ -572,19 +583,9 @@ static int rtc_set_ntp_time(struct timespec64 now, unsigned long *target_nsec)
 	if (!rtc->ops || !rtc->ops->set_time)
 		goto out_close;
 
-	/*
-	 * Compute the value of tv_nsec we require the caller to supply in
-	 * now.tv_nsec.  This is the value such that (now +
-	 * set_offset_nsec).tv_nsec == 0.
-	 */
-	set_normalized_timespec64(&to_set, 0, -rtc->set_offset_nsec);
-	*target_nsec = to_set.tv_nsec;
+	/* Store the update offset for this RTC */
+	*offset_nsec = rtc->set_offset_nsec;
 
-	/*
-	 * The ntp code must call this with the correct value in tv_nsec, if
-	 * it does not we update target_nsec and return EPROTO to make the ntp
-	 * code try again later.
-	 */
 	ok = rtc_tv_nsec_ok(rtc->set_offset_nsec, &to_set, &now);
 	if (!ok) {
 		err = -EPROTO;
@@ -657,7 +658,7 @@ static bool sync_cmos_clock(void)
 	 * implement this legacy API.
 	 */
 	ktime_get_real_ts64(&now);
-	if (rtc_tv_nsec_ok(-1 * target_nsec, &adjust, &now)) {
+	if (rtc_tv_nsec_ok(target_nsec, &adjust, &now)) {
 		if (persistent_clock_is_local)
 			adjust.tv_sec -= (sys_tz.tz_minuteswest * 60);
 		rc = update_persistent_clock64(adjust);
