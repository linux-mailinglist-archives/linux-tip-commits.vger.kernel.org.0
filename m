Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E99D3965D3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 May 2021 18:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhEaQtq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 31 May 2021 12:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbhEaQrX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 31 May 2021 12:47:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24028C0612EF;
        Mon, 31 May 2021 08:07:01 -0700 (PDT)
Date:   Mon, 31 May 2021 15:06:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622473619;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oqJxugIkBiUoQPV+GVG8mSq5Br6LVmGhKP3ykT6gIPA=;
        b=I7OkCjyneFrKtYhDBPZq2ce8oCPDEQc7jc0+/hpXQ71APJmk1PsdHtw63x2QDu3Q2jupO4
        hnziAUtdoUx/Ky8eZp/HH0mI9A/8SdBmzlGNytZvS2dllzs6aLgXCbolvwrcrn/9pmvdb5
        cAkAFKSQcc5GuggDlGGsCsPl+DBZ35spPIBEBNrFuNSH/SwhI5HTUnea8vaZ9koOaSbtiC
        f1wdRVnPAiWZudimwCQq5NGB1Q0X3rCNaG5Ftx9azVxjeKTCV3klbTjeNWXRwOJXSO0pBr
        H+Dh8J0/BHDBHqu311AJvR7awQVFj5GAUCqNBZjtOhSZVkXH+74sLTVt9mrdag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622473619;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oqJxugIkBiUoQPV+GVG8mSq5Br6LVmGhKP3ykT6gIPA=;
        b=rWffDbD1XFS1UBkppsJhzCTCc+9J+3VWCvOr7MP2Gxb63kkAhdPOyDU98tBKVRSth2TPVb
        ta4TzB0rAXQUm2AQ==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/broadcast: Program wakeup timer when entering
 idle if required
Cc:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210524221818.15850-5-will@kernel.org>
References: <20210524221818.15850-5-will@kernel.org>
MIME-Version: 1.0
Message-ID: <162247361903.29796.16135245441223506210.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ea5c7f1b9aa1a7c9d1bb9440084ac1256789fadb
Gitweb:        https://git.kernel.org/tip/ea5c7f1b9aa1a7c9d1bb9440084ac1256789fadb
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Mon, 24 May 2021 23:18:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 31 May 2021 17:04:46 +02:00

tick/broadcast: Program wakeup timer when entering idle if required

When configuring the broadcast timer on entry to and exit from deep idle
states, prefer a per-CPU wakeup timer if one exists.

On entry to idle, stop the tick device and transfer the next event into
the oneshot wakeup device, which will serve as the wakeup from idle. To
avoid the overhead of additional hardware accesses on exit from idle,
leave the timer armed and treat the inevitable interrupt as a (possibly
spurious) tick event.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210524221818.15850-5-will@kernel.org

---
 kernel/time/tick-broadcast.c | 44 ++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 0e9e06d..9b84521 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -96,6 +96,15 @@ static struct clock_event_device *tick_get_oneshot_wakeup_device(int cpu)
 	return per_cpu(tick_oneshot_wakeup_device, cpu);
 }
 
+static void tick_oneshot_wakeup_handler(struct clock_event_device *wd)
+{
+	/*
+	 * If we woke up early and the tick was reprogrammed in the
+	 * meantime then this may be spurious but harmless.
+	 */
+	tick_receive_broadcast();
+}
+
 static bool tick_set_oneshot_wakeup_device(struct clock_event_device *newdev,
 					   int cpu)
 {
@@ -121,6 +130,7 @@ static bool tick_set_oneshot_wakeup_device(struct clock_event_device *newdev,
 	if (!try_module_get(newdev->owner))
 		return false;
 
+	newdev->event_handler = tick_oneshot_wakeup_handler;
 set_device:
 	clockevents_exchange_device(curdev, newdev);
 	per_cpu(tick_oneshot_wakeup_device, cpu) = newdev;
@@ -909,16 +919,48 @@ out:
 	return ret;
 }
 
+static int tick_oneshot_wakeup_control(enum tick_broadcast_state state,
+				       struct tick_device *td,
+				       int cpu)
+{
+	struct clock_event_device *dev, *wd;
+
+	dev = td->evtdev;
+	if (td->mode != TICKDEV_MODE_ONESHOT)
+		return -EINVAL;
+
+	wd = tick_get_oneshot_wakeup_device(cpu);
+	if (!wd)
+		return -ENODEV;
+
+	switch (state) {
+	case TICK_BROADCAST_ENTER:
+		clockevents_switch_state(dev, CLOCK_EVT_STATE_ONESHOT_STOPPED);
+		clockevents_switch_state(wd, CLOCK_EVT_STATE_ONESHOT);
+		clockevents_program_event(wd, dev->next_event, 1);
+		break;
+	case TICK_BROADCAST_EXIT:
+		/* We may have transitioned to oneshot mode while idle */
+		if (clockevent_get_state(wd) != CLOCK_EVT_STATE_ONESHOT)
+			return -ENODEV;
+	}
+
+	return 0;
+}
+
 int __tick_broadcast_oneshot_control(enum tick_broadcast_state state)
 {
 	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
 	int cpu = smp_processor_id();
 
+	if (!tick_oneshot_wakeup_control(state, td, cpu))
+		return 0;
+
 	if (tick_broadcast_device.evtdev)
 		return ___tick_broadcast_oneshot_control(state, td, cpu);
 
 	/*
-	 * If there is no broadcast device, tell the caller not
+	 * If there is no broadcast or wakeup device, tell the caller not
 	 * to go into deep idle.
 	 */
 	return -EBUSY;
