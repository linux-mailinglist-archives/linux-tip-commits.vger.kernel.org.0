Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C0E36284A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 21:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241344AbhDPTI0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 15:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241240AbhDPTIZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 15:08:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC49C061756;
        Fri, 16 Apr 2021 12:08:00 -0700 (PDT)
Date:   Fri, 16 Apr 2021 19:07:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618600078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w8o3r7ZY95iOrYocT8Wrfkc5Xv9rmwcoz5jCJoUFTqw=;
        b=upOHAm2x4XiAPgbW1YR0/SPQ5DA5dl1/jrFElQf7+rxpHj+1tG+ZrfBczRASqzZtQT5Sqg
        HPVRClSSZj5whfXb1W7ZuLEEscxUn5WuOuTl7JePII5/r2vYt/41GKJXVn66G6nlJx6R9Q
        JJVwBmdIipu9P0fwN7ijGA5V4OuEh6yc1/R9UlKemOkjHTaYdhSWR/hipxFsn8pAStBjH1
        s1G/27cidxit7U/zmTK+WqXLSF/ZXokma/B5XKebGtSfRJLXRRGxgy7/gBymVrALUMEWFa
        vw7Crv8GAe0O7jfPrrWk11c2xNPOdDTxy0hsVB5rDJiGSHGlBpu8udErFZSNEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618600078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w8o3r7ZY95iOrYocT8Wrfkc5Xv9rmwcoz5jCJoUFTqw=;
        b=cQmVg7VdxxEyLcPcfyk7ue3r/b/k7HGkhhiE6/iJ/1D6BOO/4ZxS1lhGQKSGgRHD5ayq+Q
        uNsMWR4vxpFUBGAg==
From:   "tip-bot2 for Jindong Yue" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/broadcast: Allow late registered device to
 enter oneshot mode
Cc:     Jindong Yue <jindong.yue@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210331083318.21794-1-jindong.yue@nxp.com>
References: <20210331083318.21794-1-jindong.yue@nxp.com>
MIME-Version: 1.0
Message-ID: <161860007587.29796.7100262021118685563.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     9c336c9935cff267470bb3aaa85c66fac194b650
Gitweb:        https://git.kernel.org/tip/9c336c9935cff267470bb3aaa85c66fac194b650
Author:        Jindong Yue <jindong.yue@nxp.com>
AuthorDate:    Wed, 31 Mar 2021 16:33:18 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 Apr 2021 21:03:50 +02:00

tick/broadcast: Allow late registered device to enter oneshot mode

The broadcast device is switched to oneshot mode when the system switches
to oneshot mode. If a broadcast clock event device is registered after the
system switched to oneshot mode, it will stay in periodic mode forever.

Ensure that a late registered device which is selected as broadcast device
is initialized in oneshot mode when the system already uses oneshot mode.

[ tglx: Massage changelog ]

Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210331083318.21794-1-jindong.yue@nxp.com

---
 kernel/time/tick-broadcast.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 6ec7855..a440552 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -107,6 +107,19 @@ void tick_install_broadcast_device(struct clock_event_device *dev)
 	tick_broadcast_device.evtdev = dev;
 	if (!cpumask_empty(tick_broadcast_mask))
 		tick_broadcast_start_periodic(dev);
+
+	if (!(dev->features & CLOCK_EVT_FEAT_ONESHOT))
+		return;
+
+	/*
+	 * If the system already runs in oneshot mode, switch the newly
+	 * registered broadcast device to oneshot mode explicitly.
+	 */
+	if (tick_broadcast_oneshot_active()) {
+		tick_broadcast_switch_to_oneshot();
+		return;
+	}
+
 	/*
 	 * Inform all cpus about this. We might be in a situation
 	 * where we did not switch to oneshot mode because the per cpu
@@ -115,8 +128,7 @@ void tick_install_broadcast_device(struct clock_event_device *dev)
 	 * notification the systems stays stuck in periodic mode
 	 * forever.
 	 */
-	if (dev->features & CLOCK_EVT_FEAT_ONESHOT)
-		tick_clock_notify();
+	tick_clock_notify();
 }
 
 /*
