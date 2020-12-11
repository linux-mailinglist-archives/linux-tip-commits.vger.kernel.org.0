Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4782D737A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Dec 2020 11:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405803AbgLKKJE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 11 Dec 2020 05:09:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33682 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404466AbgLKKIc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 11 Dec 2020 05:08:32 -0500
Date:   Fri, 11 Dec 2020 10:07:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607681269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zgWIeUjDirbK7CfN+ce6H+G6T1lvsKAgUmlLoTiXEyw=;
        b=EgwL860SrOC9S90Vz7CEf0toSb7Np9RAk3H0zUE2hUPnsRnOxMvC3Xozrsdz9eTjHGm37v
        PIBsTrwl5ArsFCQiqvd/wZW6L5NDX7M7giC6Xl07e/lOJGb5kho1Ay5/R8fLYhRslO8O8p
        NXyMA1+B6T8+Gy+Zd32hn/WWntWwUQwzVAKLb54Wn2rZVitK/UZBi4s0H2GI6unGPNUt5F
        03ZjKq93lxnNx7jjL1PYQFyVM0E+m52dgpPzJ4vTjJVrI99WQczMEysiIuCoKJ3E8vuwPj
        KKkdhhRJrEGJMieJI81fBgQW/BmLRNpwNAwxP1lP19hUCU5ZvSiTjTcImjD76Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607681269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zgWIeUjDirbK7CfN+ce6H+G6T1lvsKAgUmlLoTiXEyw=;
        b=j7jG+iRXbRY6pbduwsSZ2EEWNk8X6Ndiq6lG8v45BcytN52TGRzVmGe0yPYL+CsPIlFgkV
        3uxQZyNPI+eIFmBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] rtc: mc146818: Reduce spinlock section in
 mc146818_set_time()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201206220541.709243630@linutronix.de>
References: <20201206220541.709243630@linutronix.de>
MIME-Version: 1.0
Message-ID: <160768126908.3364.12858314652099528256.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     dcf257e92622ba0e25fdc4b6699683e7ae67e2a1
Gitweb:        https://git.kernel.org/tip/dcf257e92622ba0e25fdc4b6699683e7ae67e2a1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 06 Dec 2020 22:46:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 11 Dec 2020 10:40:52 +01:00

rtc: mc146818: Reduce spinlock section in mc146818_set_time()

No need to hold the lock and disable interrupts for doing math.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20201206220541.709243630@linutronix.de

---
 drivers/rtc/rtc-mc146818-lib.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
index 98048bb..972a5b9 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -135,7 +135,6 @@ int mc146818_set_time(struct rtc_time *time)
 	if (yrs > 255)	/* They are unsigned */
 		return -EINVAL;
 
-	spin_lock_irqsave(&rtc_lock, flags);
 #ifdef CONFIG_MACH_DECSTATION
 	real_yrs = yrs;
 	leap_yr = ((!((yrs + 1900) % 4) && ((yrs + 1900) % 100)) ||
@@ -164,10 +163,8 @@ int mc146818_set_time(struct rtc_time *time)
 	/* These limits and adjustments are independent of
 	 * whether the chip is in binary mode or not.
 	 */
-	if (yrs > 169) {
-		spin_unlock_irqrestore(&rtc_lock, flags);
+	if (yrs > 169)
 		return -EINVAL;
-	}
 
 	if (yrs >= 100)
 		yrs -= 100;
@@ -183,6 +180,7 @@ int mc146818_set_time(struct rtc_time *time)
 		century = bin2bcd(century);
 	}
 
+	spin_lock_irqsave(&rtc_lock, flags);
 	save_control = CMOS_READ(RTC_CONTROL);
 	CMOS_WRITE((save_control|RTC_SET), RTC_CONTROL);
 	save_freq_select = CMOS_READ(RTC_FREQ_SELECT);
