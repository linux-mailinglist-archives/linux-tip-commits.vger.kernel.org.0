Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51C4310E65
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Feb 2021 18:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhBEPa0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 5 Feb 2021 10:30:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48902 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbhBEP14 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 5 Feb 2021 10:27:56 -0500
Date:   Fri, 05 Feb 2021 17:09:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612544974;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Rh5Yxk4TOiEVVCLvfzyyZU8viIhD1Vne2otryahZ2g=;
        b=XB0eF/iOq8PXzeGIQvq0dYFlbT8w5OHLGwn1nqp6oHGwMPJY1K8Ut4MnIzSgjz2Rr0mmcY
        YIZHWZ0Zr9ComoHNG3S13X7AYZuJY2NHaE/mk95FvCPO8CZfv/HKioPRzEFM/kTzwUPYHU
        i1z155fwyxOMkpcQvUKvBniPcPKiRrvd5REsqoeF5RBpZ7IgouZ1WxtKAnHt9QjKxuesgR
        kwZxqaaTEtb6ZvvRA7xiSUgKtKzlUXRyT2wr5i05vP2warMHgtI+eKO8taCUp9xQtCmD+c
        QVDZfwi4A39jv6wpt8T1WROp6+M6oQXBslHOllqPH3wpN3iu0NTuzh1xT2bDzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612544974;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Rh5Yxk4TOiEVVCLvfzyyZU8viIhD1Vne2otryahZ2g=;
        b=iZdoGgk9Dr9QXt7/2NdlPuLoB/139oPt7cYAUrdaKxV0lS3Bc+9jPxcEZw8kNpps7VCMXQ
        MNOSecxWsnxzmmAA==
From:   "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] ntp: Use freezable workqueue for RTC synchronization
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210125143039.1051912-1-geert+renesas@glider.be>
References: <20210125143039.1051912-1-geert+renesas@glider.be>
MIME-Version: 1.0
Message-ID: <161254497336.23325.2614230583600966925.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     24c242ec7abb3d21fa0b1da6bb251521dc1717b5
Gitweb:        https://git.kernel.org/tip/24c242ec7abb3d21fa0b1da6bb251521dc1717b5
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Mon, 25 Jan 2021 15:30:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 05 Feb 2021 18:03:13 +01:00

ntp: Use freezable workqueue for RTC synchronization

The bug fixed by commit e3fab2f3de081e98 ("ntp: Fix RTC synchronization on
32-bit platforms") revealed an underlying issue: RTC synchronization may
happen anytime, even while the system is partially suspended.

On systems where the RTC is connected to an I2C bus, the I2C bus controller
may already or still be suspended, triggering a WARNING during suspend or
resume from s2ram:

    WARNING: CPU: 0 PID: 124 at drivers/i2c/i2c-core.h:54 __i2c_transfer+0x634/0x680
    i2c i2c-6: Transfer while suspended
    [...]
    Workqueue: events_power_efficient sync_hw_clock
    [...]
      (__i2c_transfer)
      (i2c_transfer)
      (regmap_i2c_read)
      ...
      (da9063_rtc_set_time)
      (rtc_set_time)
      (sync_hw_clock)
      (process_one_work)

Fix this race condition by using the freezable instead of the normal
power-efficient workqueue.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lore.kernel.org/r/20210125143039.1051912-1-geert+renesas@glider.be

---
 kernel/time/ntp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 87389b9..5247afd 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -502,7 +502,7 @@ static struct hrtimer sync_hrtimer;
 
 static enum hrtimer_restart sync_timer_callback(struct hrtimer *timer)
 {
-	queue_work(system_power_efficient_wq, &sync_work);
+	queue_work(system_freezable_power_efficient_wq, &sync_work);
 
 	return HRTIMER_NORESTART;
 }
@@ -668,7 +668,7 @@ void ntp_notify_cmos_timer(void)
 	 * just a pointless work scheduled.
 	 */
 	if (ntp_synced() && !hrtimer_is_queued(&sync_hrtimer))
-		queue_work(system_power_efficient_wq, &sync_work);
+		queue_work(system_freezable_power_efficient_wq, &sync_work);
 }
 
 static void __init ntp_init_cmos_sync(void)
