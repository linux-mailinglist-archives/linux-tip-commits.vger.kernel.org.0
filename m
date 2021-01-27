Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CFE305607
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Jan 2021 09:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhA0Ioc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 27 Jan 2021 03:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhA0ImU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 27 Jan 2021 03:42:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CCDC061573;
        Wed, 27 Jan 2021 00:41:40 -0800 (PST)
Date:   Wed, 27 Jan 2021 08:41:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611736898;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cemEJYV9vVSDX4IDyOlVNtus9i2DLQyCgcp84j2W8sA=;
        b=pZnKsp5nEb1N9gxjFAiF+1ivkZn7XflFPP30t1KjfjgfCa0uEFV2i0CP7o3aq4AZOluHSj
        NsS8pXyTrFngd5vRGEwUDMliC7SvjVH89IzXNQbzuWUe3YNEaYddbtkcRuKJCrkqCS1Q81
        td0LCEhDtxcOH+pEhjdGtpvZELBmxqhU//R7g0eAUon1YiqhOuVHIeYZBLopsbdMpZmjS6
        bR5NqDlVGrIbtzjEfx8WvK25heOfXMREhCjxrZDRnpuem37lhP4fuCwifbfa3qEyP2A3FC
        iV+J4hHJ5zE36z/MrCMhY5iKAE/5p6dEw4IfRtyi3KIVLrDfelJ5g4OJtztKhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611736898;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cemEJYV9vVSDX4IDyOlVNtus9i2DLQyCgcp84j2W8sA=;
        b=wL2XPOQeogxM4FbAQ/xHycx2xlhsTfZaynDIXUdvI7HCQ0SJbM5VDonRTE/KNpO1sAGi0i
        KqRirepB7ZN64UAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] rtc: mc146818: Detect and handle broken RTCs
Cc:     mic@digikod.net, Thomas Gleixner <tglx@linutronix.de>,
        mic@linux.microsoft.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87tur3fx7w.fsf@nanos.tec.linutronix.de>
References: <87tur3fx7w.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <161173689701.414.6157646664420167420.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     211e5db19d15a721b2953ea54b8f26c2963720eb
Gitweb:        https://git.kernel.org/tip/211e5db19d15a721b2953ea54b8f26c2963=
720eb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 26 Jan 2021 18:02:11 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Jan 2021 09:36:22 +01:00

rtc: mc146818: Detect and handle broken RTCs

The recent fix for handling the UIP bit unearthed another issue in the RTC
code. If the RTC is advertised but the readout is straight 0xFF because
it's not available, the old code just proceeded with crappy values, but the
new code hangs because it waits for the UIP bit to become low.

Add a sanity check in the RTC CMOS probe function which reads the RTC_VALID
register (Register D) which should have bit 0-6 cleared. If that's not the
case then fail to register the CMOS.

Add the same check to mc146818_get_time(), warn once when the condition
is true and invalidate the rtc_time data.

Reported-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/87tur3fx7w.fsf@nanos.tec.linutronix.de

---
 drivers/rtc/rtc-cmos.c         | 8 ++++++++
 drivers/rtc/rtc-mc146818-lib.c | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 51e80bc..68a9ac6 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -805,6 +805,14 @@ cmos_do_probe(struct device *dev, struct resource *ports=
, int rtc_irq)
=20
 	spin_lock_irq(&rtc_lock);
=20
+	/* Ensure that the RTC is accessible. Bit 0-6 must be 0! */
+	if ((CMOS_READ(RTC_VALID) & 0x7f) !=3D 0) {
+		spin_unlock_irq(&rtc_lock);
+		dev_warn(dev, "not accessible\n");
+		retval =3D -ENXIO;
+		goto cleanup1;
+	}
+
 	if (!(flags & CMOS_RTC_FLAGS_NOFREQ)) {
 		/* force periodic irq to CMOS reset default of 1024Hz;
 		 *
diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
index 972a5b9..f83c138 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -21,6 +21,13 @@ unsigned int mc146818_get_time(struct rtc_time *time)
=20
 again:
 	spin_lock_irqsave(&rtc_lock, flags);
+	/* Ensure that the RTC is accessible. Bit 0-6 must be 0! */
+	if (WARN_ON_ONCE((CMOS_READ(RTC_VALID) & 0x7f) !=3D 0)) {
+		spin_unlock_irqrestore(&rtc_lock, flags);
+		memset(time, 0xff, sizeof(*time));
+		return 0;
+	}
+
 	/*
 	 * Check whether there is an update in progress during which the
 	 * readout is unspecified. The maximum update time is ~2ms. Poll
