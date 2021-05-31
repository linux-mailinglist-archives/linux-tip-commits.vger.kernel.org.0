Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0853965D2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 May 2021 18:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhEaQto (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 31 May 2021 12:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhEaQrX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 31 May 2021 12:47:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042A8C0612F0;
        Mon, 31 May 2021 08:07:02 -0700 (PDT)
Date:   Mon, 31 May 2021 15:06:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622473620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A7JqaupFf01ogO7a1gunSzIHDBzVcZvUnort+mgzdvA=;
        b=m5BhAeaHWgy3rDox8HXwD1Xdg2f6tRURi2+1JFzGRVW41Ghbpa2QKaUmsVANy7Ymn9uMB8
        BgX70Hpnyy77WiS7Lbfl/6dzEvIbs+LcsP+HnCIcTZ7I3E1sqy2dqGBOb5Xc50bNNcvx7a
        pcHPO8kBEPxIZs8O58kXLyRicBM2thLD/g2q1dGXdDoQmH9SMf48fxAmc60tEJxMKJYR/1
        coqz6jm3PYy0YpR3IsaYAMT0VEFlXSX+8+KGE69sRYS1/R1YfQlnohOnzacvpGs+f5XkOE
        7rvUCIlfh1Ee9VdS+RoLYDVfeo5f5/vEwoRU9RanFLz7QOhAM7xeq3XlL3qZqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622473620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A7JqaupFf01ogO7a1gunSzIHDBzVcZvUnort+mgzdvA=;
        b=fKa0jOzE2MNTDYjYOe587tiVDz3EF4vHTNHNJEVq7D3pfOrisKCHKE0R/CVj78thVG/uq6
        Dse0W2VX8Xb2Y7Dw==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/broadcast: Split
 __tick_broadcast_oneshot_control() into a helper
Cc:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210524221818.15850-3-will@kernel.org>
References: <20210524221818.15850-3-will@kernel.org>
MIME-Version: 1.0
Message-ID: <162247361983.29796.2022959181572862326.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e5007c288e7981e0b0cf8ea3dea443f0b8c34345
Gitweb:        https://git.kernel.org/tip/e5007c288e7981e0b0cf8ea3dea443f0b8c34345
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Mon, 24 May 2021 23:18:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 31 May 2021 17:04:45 +02:00

tick/broadcast: Split __tick_broadcast_oneshot_control() into a helper

In preparation for adding support for per-cpu wakeup timers, split
_tick_broadcast_oneshot_control() into a helper function which deals
only with the broadcast timer management across idle transitions.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210524221818.15850-3-will@kernel.org

---
 kernel/time/tick-broadcast.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index fb794ff..f3f2f4b 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -717,24 +717,16 @@ static void broadcast_shutdown_local(struct clock_event_device *bc,
 	clockevents_switch_state(dev, CLOCK_EVT_STATE_SHUTDOWN);
 }
 
-int __tick_broadcast_oneshot_control(enum tick_broadcast_state state)
+static int ___tick_broadcast_oneshot_control(enum tick_broadcast_state state,
+					     struct tick_device *td,
+					     int cpu)
 {
-	struct clock_event_device *bc, *dev;
-	int cpu, ret = 0;
+	struct clock_event_device *bc, *dev = td->evtdev;
+	int ret = 0;
 	ktime_t now;
 
-	/*
-	 * If there is no broadcast device, tell the caller not to go
-	 * into deep idle.
-	 */
-	if (!tick_broadcast_device.evtdev)
-		return -EBUSY;
-
-	dev = this_cpu_ptr(&tick_cpu_device)->evtdev;
-
 	raw_spin_lock(&tick_broadcast_lock);
 	bc = tick_broadcast_device.evtdev;
-	cpu = smp_processor_id();
 
 	if (state == TICK_BROADCAST_ENTER) {
 		/*
@@ -863,6 +855,21 @@ out:
 	return ret;
 }
 
+int __tick_broadcast_oneshot_control(enum tick_broadcast_state state)
+{
+	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
+	int cpu = smp_processor_id();
+
+	if (tick_broadcast_device.evtdev)
+		return ___tick_broadcast_oneshot_control(state, td, cpu);
+
+	/*
+	 * If there is no broadcast device, tell the caller not
+	 * to go into deep idle.
+	 */
+	return -EBUSY;
+}
+
 /*
  * Reset the one shot broadcast for a cpu
  *
