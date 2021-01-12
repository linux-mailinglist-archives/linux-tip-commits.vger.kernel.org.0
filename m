Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FEC2F3CEB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Jan 2021 01:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436824AbhALVhW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 Jan 2021 16:37:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48394 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436832AbhALUSw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 Jan 2021 15:18:52 -0500
Date:   Tue, 12 Jan 2021 20:18:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610482689;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GeY/3iwNgQgkQhw71eWQN6faVvZpEODlj0Z6ju8gdLY=;
        b=aKrqhVmzY+eyfz05ZPzUAJw9+JYqbpGYYxt1QDsF8AQY2jiNF+K7Gy207h6tkHocD25L6D
        0nXv1CkbyOIBEg6Nn+NMsWtUyB9Py1BsEC1GtAf8G4gwOhGq7IYhbLuLtpS95gK/WPpK8L
        4qzfVWhCIS6SV1fY3dkZGwOtsiNQNJcOGaiWGkKeN7Il9Kupfz1jls+2C5ff10gJ2A+D6i
        otHK6thok9fraath41NvqXrPEsAY8KIpAyCID/M1UKut8EhG8tIn8IIlUVxCa275q8Bf/H
        n06zfING1CwSBULlD+2R1OwHA/8S8ORNb78+X2EYEZD/vLq/VP7f8M+uU2aMmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610482689;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GeY/3iwNgQgkQhw71eWQN6faVvZpEODlj0Z6ju8gdLY=;
        b=ZPGwGow8E2DkrZsPw6EoWBNFk3U3/n/1uKCOMF3/yrLtTyYG3yjY20+7yRRBfVp1EcWGpQ
        PxAcDup4I2JCuaCw==
From:   "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] ntp: Fix RTC synchronization on 32-bit platforms
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210111103956.290378-1-geert+renesas@glider.be>
References: <20210111103956.290378-1-geert+renesas@glider.be>
MIME-Version: 1.0
Message-ID: <161048268862.414.3356040186950421264.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     e3fab2f3de081e98c50b7b4ace1b040161d95310
Gitweb:        https://git.kernel.org/tip/e3fab2f3de081e98c50b7b4ace1b040161d95310
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Mon, 11 Jan 2021 11:39:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Jan 2021 21:13:01 +01:00

ntp: Fix RTC synchronization on 32-bit platforms

Due to an integer overflow, RTC synchronization now happens every 2s
instead of the intended 11 minutes.  Fix this by forcing 64-bit
arithmetic for the sync period calculation.

Annotate the other place which multiplies seconds for consistency as well.

Fixes: c9e6189fb03123a7 ("ntp: Make the RTC synchronization more reliable")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210111103956.290378-1-geert+renesas@glider.be

---
 kernel/time/ntp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 7404d38..87389b9 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -498,7 +498,7 @@ out:
 static void sync_hw_clock(struct work_struct *work);
 static DECLARE_WORK(sync_work, sync_hw_clock);
 static struct hrtimer sync_hrtimer;
-#define SYNC_PERIOD_NS (11UL * 60 * NSEC_PER_SEC)
+#define SYNC_PERIOD_NS (11ULL * 60 * NSEC_PER_SEC)
 
 static enum hrtimer_restart sync_timer_callback(struct hrtimer *timer)
 {
@@ -512,7 +512,7 @@ static void sched_sync_hw_clock(unsigned long offset_nsec, bool retry)
 	ktime_t exp = ktime_set(ktime_get_real_seconds(), 0);
 
 	if (retry)
-		exp = ktime_add_ns(exp, 2 * NSEC_PER_SEC - offset_nsec);
+		exp = ktime_add_ns(exp, 2ULL * NSEC_PER_SEC - offset_nsec);
 	else
 		exp = ktime_add_ns(exp, SYNC_PERIOD_NS - offset_nsec);
 
