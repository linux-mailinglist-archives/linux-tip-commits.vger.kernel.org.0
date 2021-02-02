Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2051E30CC02
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Feb 2021 20:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhBBTmU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Feb 2021 14:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239995AbhBBTlW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Feb 2021 14:41:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCE8C06174A;
        Tue,  2 Feb 2021 11:40:42 -0800 (PST)
Date:   Tue, 02 Feb 2021 19:40:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612294840;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=csSSjQW+iGQ82CPLaJngoVb1dlMcg2+zvB5nGqdhk60=;
        b=Xfur/CrYimcSPYK3q9jJGGaw5wTdKepryVVcY27JyawFZc4r6DGq1pdQL/6T/LO4Kmwr8a
        UMdNkUoM5BgPrZXQeC3I4fqc3QDM6TPy7fbKlVyHpUQheBIvHLwYREMCcr7O6EwVGjuyI0
        NaskpnbYVsx3UDiRjsuukKOZ91f3xkc4y3GpMFgR+/8G+IIS6gDA9waYZVqT/bFN0mRqYC
        7oV8Y6Jdm+Sn5AdjSerRxk+ascPHeOtxzqfZ+ntA6BB06KOZxW2TIZv0jXo0gFoC/9K0Fx
        dTHlMaD7C7Z8zXUIOdg6o3Zc8LIp9k0FkQL1IbLEuiW5j07X69xuBccHktP3Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612294840;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=csSSjQW+iGQ82CPLaJngoVb1dlMcg2+zvB5nGqdhk60=;
        b=rXrw5sO758Up5Op9/ylJGOQ5Oh1aYGS/gG/xxIVLjSOacVtn+mmZSRvLMPln3SFa5EFhPC
        9z+OU30P1m18TTBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] rtc: mc146818: Dont test for bit 0-5 in Register D
Cc:     Serge Belyshev <belyshev@depni.sinp.msu.ru>,
        Dirk Gouders <dirk@gouders.net>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Len Brown <len.brown@intel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87zh0nbnha.fsf@nanos.tec.linutronix.de>
References: <87zh0nbnha.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <161229483952.23325.2892695542227927138.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     ebb22a05943666155e6da04407cc6e913974c78c
Gitweb:        https://git.kernel.org/tip/ebb22a05943666155e6da04407cc6e913974c78c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 01 Feb 2021 20:24:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 02 Feb 2021 20:35:02 +01:00

rtc: mc146818: Dont test for bit 0-5 in Register D

The recent change to validate the RTC turned out to be overly tight.

While it cures the problem on the reporters machine it breaks machines
with Intel chipsets which use bit 0-5 of the D register. So check only
for bit 6 being 0 which is the case on these Intel machines as well.

Fixes: 211e5db19d15 ("rtc: mc146818: Detect and handle broken RTCs")
Reported-by: Serge Belyshev <belyshev@depni.sinp.msu.ru>
Reported-by: Dirk Gouders <dirk@gouders.net>
Reported-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Dirk Gouders <dirk@gouders.net>
Tested-by: Len Brown <len.brown@intel.com>
Tested-by: Borislav Petkov <bp@suse.de>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/87zh0nbnha.fsf@nanos.tec.linutronix.de

---
 drivers/rtc/rtc-cmos.c         | 4 ++--
 drivers/rtc/rtc-mc146818-lib.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 68a9ac6..a701dae 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -805,8 +805,8 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 
 	spin_lock_irq(&rtc_lock);
 
-	/* Ensure that the RTC is accessible. Bit 0-6 must be 0! */
-	if ((CMOS_READ(RTC_VALID) & 0x7f) != 0) {
+	/* Ensure that the RTC is accessible. Bit 6 must be 0! */
+	if ((CMOS_READ(RTC_VALID) & 0x40) != 0) {
 		spin_unlock_irq(&rtc_lock);
 		dev_warn(dev, "not accessible\n");
 		retval = -ENXIO;
diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
index f83c138..dcfaf09 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -21,8 +21,8 @@ unsigned int mc146818_get_time(struct rtc_time *time)
 
 again:
 	spin_lock_irqsave(&rtc_lock, flags);
-	/* Ensure that the RTC is accessible. Bit 0-6 must be 0! */
-	if (WARN_ON_ONCE((CMOS_READ(RTC_VALID) & 0x7f) != 0)) {
+	/* Ensure that the RTC is accessible. Bit 6 must be 0! */
+	if (WARN_ON_ONCE((CMOS_READ(RTC_VALID) & 0x40) != 0)) {
 		spin_unlock_irqrestore(&rtc_lock, flags);
 		memset(time, 0xff, sizeof(*time));
 		return 0;
