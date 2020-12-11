Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196862D7370
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Dec 2020 11:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405777AbgLKKJD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 11 Dec 2020 05:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394049AbgLKKIc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 11 Dec 2020 05:08:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F71C061793;
        Fri, 11 Dec 2020 02:07:52 -0800 (PST)
Date:   Fri, 11 Dec 2020 10:07:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607681269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eonn9sBn1m+7sGxDFacwFjquuRDevWbibyptF/6Y/+U=;
        b=QWOgsjlXoKRgH1NiF1tKQFYbYTiLpl+8HmPkkXv3KUV3bqPgXLEe1As4X+wi3LXMUW8b+j
        t6QMlC0twK5+4HeK0imjR8YYpSMri5MYY5/RwyxcMDC1Ob2qUyUAxVXr1Cnogxh9I0Xrp6
        dnArS+8jiCt9oGac783N8bpsIyxknF0nU3VTFt585lXtIQJEvCdhcVbTnyppvs3oUeQK7X
        +QavrYYEr3FUOrGu7BxxlbvVomMlboNbJzCY/OsLo7sz6wBoC0PLO3IQsmHJpuLljUQ+IF
        ePPCNSTqg9jdrGbhh0Z9cc5VYLmWT2TV96iBZDS2xkzg34kFJVGSPjmwMXwZXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607681269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eonn9sBn1m+7sGxDFacwFjquuRDevWbibyptF/6Y/+U=;
        b=BOD0IgfUtxpHPd1YV2chP60HSMR+fEzz3arX0CxiiIbX45buhEXxY+bi24oWPeSkRHbbOy
        Kx0arvXVdJrhsnBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] rtc: mc146818: Prevent reading garbage
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201206220541.594826678@linutronix.de>
References: <20201206220541.594826678@linutronix.de>
MIME-Version: 1.0
Message-ID: <160768126932.3364.17815331718961415909.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     05a0302c35481e9b47fb90ba40922b0a4cae40d8
Gitweb:        https://git.kernel.org/tip/05a0302c35481e9b47fb90ba40922b0a4cae40d8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 06 Dec 2020 22:46:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 11 Dec 2020 10:40:52 +01:00

rtc: mc146818: Prevent reading garbage

The MC146818 driver is prone to read garbage from the RTC. There are
several issues all related to the update cycle of the MC146818. The chip
increments seconds obviously once per second and indicates that by a bit in
a register. The bit goes high 244us before the actual update starts. During
the update the readout of the time values is undefined.

The code just checks whether the update in progress bit (UIP) is set before
reading the clock. If it's set it waits arbitrary 20ms before retrying,
which is ample because the maximum update time is ~2ms.

But this check does not guarantee that the UIP bit goes high and the actual
update happens during the readout. So the following can happen

 0.997 	       UIP = False
   -> Interrupt/NMI/preemption
 0.998	       UIP -> True
 0.999	       Readout	<- Undefined

To prevent this rework the code so it checks UIP before and after the
readout and if set after the readout try again.

But that's not enough to cover the following:

 0.997 	       UIP = False
 	       Readout seconds
   -> NMI (or vCPU scheduled out)
 0.998	       UIP -> True
 	       update completes
	       UIP -> False
 1.000	       Readout	minutes,....
 	       UIP check succeeds

That can make the readout wrong up to 59 seconds.

To prevent this, read the seconds value before the first UIP check,
validate it after checking UIP and after reading out the rest.

It's amazing that the original i386 code had this actually correct and
the generic implementation of the MC146818 driver got it wrong in 2002 and
it stayed that way until today.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20201206220541.594826678@linutronix.de

---
 drivers/rtc/rtc-mc146818-lib.c | 64 ++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
index 2ecd875..98048bb 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -8,41 +8,41 @@
 #include <linux/acpi.h>
 #endif
 
-/*
- * Returns true if a clock update is in progress
- */
-static inline unsigned char mc146818_is_updating(void)
-{
-	unsigned char uip;
-	unsigned long flags;
-
-	spin_lock_irqsave(&rtc_lock, flags);
-	uip = (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP);
-	spin_unlock_irqrestore(&rtc_lock, flags);
-	return uip;
-}
-
 unsigned int mc146818_get_time(struct rtc_time *time)
 {
 	unsigned char ctrl;
 	unsigned long flags;
 	unsigned char century = 0;
+	bool retry;
 
 #ifdef CONFIG_MACH_DECSTATION
 	unsigned int real_year;
 #endif
 
+again:
+	spin_lock_irqsave(&rtc_lock, flags);
 	/*
-	 * read RTC once any update in progress is done. The update
-	 * can take just over 2ms. We wait 20ms. There is no need to
-	 * to poll-wait (up to 1s - eeccch) for the falling edge of RTC_UIP.
-	 * If you need to know *exactly* when a second has started, enable
-	 * periodic update complete interrupts, (via ioctl) and then
-	 * immediately read /dev/rtc which will block until you get the IRQ.
-	 * Once the read clears, read the RTC time (again via ioctl). Easy.
+	 * Check whether there is an update in progress during which the
+	 * readout is unspecified. The maximum update time is ~2ms. Poll
+	 * every msec for completion.
+	 *
+	 * Store the second value before checking UIP so a long lasting NMI
+	 * which happens to hit after the UIP check cannot make an update
+	 * cycle invisible.
 	 */
-	if (mc146818_is_updating())
-		mdelay(20);
+	time->tm_sec = CMOS_READ(RTC_SECONDS);
+
+	if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP) {
+		spin_unlock_irqrestore(&rtc_lock, flags);
+		mdelay(1);
+		goto again;
+	}
+
+	/* Revalidate the above readout */
+	if (time->tm_sec != CMOS_READ(RTC_SECONDS)) {
+		spin_unlock_irqrestore(&rtc_lock, flags);
+		goto again;
+	}
 
 	/*
 	 * Only the values that we read from the RTC are set. We leave
@@ -50,8 +50,6 @@ unsigned int mc146818_get_time(struct rtc_time *time)
 	 * RTC has RTC_DAY_OF_WEEK, we ignore it, as it is only updated
 	 * by the RTC when initially set to a non-zero value.
 	 */
-	spin_lock_irqsave(&rtc_lock, flags);
-	time->tm_sec = CMOS_READ(RTC_SECONDS);
 	time->tm_min = CMOS_READ(RTC_MINUTES);
 	time->tm_hour = CMOS_READ(RTC_HOURS);
 	time->tm_mday = CMOS_READ(RTC_DAY_OF_MONTH);
@@ -66,8 +64,24 @@ unsigned int mc146818_get_time(struct rtc_time *time)
 		century = CMOS_READ(acpi_gbl_FADT.century);
 #endif
 	ctrl = CMOS_READ(RTC_CONTROL);
+	/*
+	 * Check for the UIP bit again. If it is set now then
+	 * the above values may contain garbage.
+	 */
+	retry = CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP;
+	/*
+	 * A NMI might have interrupted the above sequence so check whether
+	 * the seconds value has changed which indicates that the NMI took
+	 * longer than the UIP bit was set. Unlikely, but possible and
+	 * there is also virt...
+	 */
+	retry |= time->tm_sec != CMOS_READ(RTC_SECONDS);
+
 	spin_unlock_irqrestore(&rtc_lock, flags);
 
+	if (retry)
+		goto again;
+
 	if (!(ctrl & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
 	{
 		time->tm_sec = bcd2bin(time->tm_sec);
