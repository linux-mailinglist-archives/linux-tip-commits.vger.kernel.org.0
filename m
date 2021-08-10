Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0669B3E7D07
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 18:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbhHJQCr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 12:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbhHJQCm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 12:02:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D1DC06179B;
        Tue, 10 Aug 2021 09:02:18 -0700 (PDT)
Date:   Tue, 10 Aug 2021 16:02:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628611336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O9kEFZ+jRcX/7qIZNqKLHu9rOGw2FPbYv2psZfxG+QU=;
        b=Q3cNbcjkzUHeNe0lDcUqGyQCsQpBHV9dTw733VZ9wPGculJzf5TsB7bqH8EQ7Jc34ZCGdG
        W9/daVZ7J6qMUA4oHdplrwdVXQnwqwZ3+XD5fP9AJK3ahIjlec7LCaWB70z194H85ehMM9
        8IdqcP/Vyu99qCt+B4xwjEXFP+VLPrD82AOU3fREhHqWRp3SCz8btlNPHC+9Jhpk3RLARf
        GW5QoLWSeGo7gULDcmd1QP/CA8Ea+SGA6HIRN/VrQOgGwO1LiC1lSGYSY8IsnjUx4ClXp4
        U7ai8UMAgdG+27hFQRCUQjtg8GQRK1Mf8thx8rx9MUhmmxwFdGhh5zFORrk+lQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628611336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O9kEFZ+jRcX/7qIZNqKLHu9rOGw2FPbYv2psZfxG+QU=;
        b=WbIINEvsWBF/9ip7DqZRGPeg+YdSOALXEdf+EC2Vy+hIC1mA2rHXMEGRIHYz6c507jZ7+K
        x0AaMgfIj8039VAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Force clock_was_set() handling for the
 HIGHRES=n, NOHZ=y case
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210713135158.288697903@linutronix.de>
References: <20210713135158.288697903@linutronix.de>
MIME-Version: 1.0
Message-ID: <162861133625.395.538177983573699889.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e71a4153b7c256ec103e79875398553808aeffd2
Gitweb:        https://git.kernel.org/tip/e71a4153b7c256ec103e79875398553808aeffd2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Jul 2021 15:39:49 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 17:57:22 +02:00

hrtimer: Force clock_was_set() handling for the HIGHRES=n, NOHZ=y case

When CONFIG_HIGH_RES_TIMERS is disabled, but NOHZ is enabled then
clock_was_set() is not doing anything. With HIGHRES=n the kernel relies on
the periodic tick to update the clock offsets, but when NOHZ is enabled and
active then CPUs which are in a deep idle sleep do not have a periodic tick
which means the expiry of timers affected by clock_was_set() can be
arbitrarily delayed up to the point where the CPUs are brought out of idle
again.

Make the clock_was_set() logic unconditionaly available so that idle CPUs
are kicked out of idle to handle the update.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210713135158.288697903@linutronix.de

---
 kernel/time/hrtimer.c | 87 ++++++++++++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 28 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 7ebf642..214fd65 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -739,23 +739,7 @@ static inline int hrtimer_is_hres_enabled(void)
 	return hrtimer_hres_enabled;
 }
 
-/*
- * Retrigger next event is called after clock was set
- *
- * Called with interrupts disabled via on_each_cpu()
- */
-static void retrigger_next_event(void *arg)
-{
-	struct hrtimer_cpu_base *base = this_cpu_ptr(&hrtimer_bases);
-
-	if (!__hrtimer_hres_active(base))
-		return;
-
-	raw_spin_lock(&base->lock);
-	hrtimer_update_base(base);
-	hrtimer_force_reprogram(base, 0);
-	raw_spin_unlock(&base->lock);
-}
+static void retrigger_next_event(void *arg);
 
 /*
  * Switch to high resolution mode
@@ -781,9 +765,50 @@ static void hrtimer_switch_to_hres(void)
 
 static inline int hrtimer_is_hres_enabled(void) { return 0; }
 static inline void hrtimer_switch_to_hres(void) { }
-static inline void retrigger_next_event(void *arg) { }
 
 #endif /* CONFIG_HIGH_RES_TIMERS */
+/*
+ * Retrigger next event is called after clock was set with interrupts
+ * disabled through an SMP function call or directly from low level
+ * resume code.
+ *
+ * This is only invoked when:
+ *	- CONFIG_HIGH_RES_TIMERS is enabled.
+ *	- CONFIG_NOHZ_COMMON is enabled
+ *
+ * For the other cases this function is empty and because the call sites
+ * are optimized out it vanishes as well, i.e. no need for lots of
+ * #ifdeffery.
+ */
+static void retrigger_next_event(void *arg)
+{
+	struct hrtimer_cpu_base *base = this_cpu_ptr(&hrtimer_bases);
+
+	/*
+	 * When high resolution mode or nohz is active, then the offsets of
+	 * CLOCK_REALTIME/TAI/BOOTTIME have to be updated. Otherwise the
+	 * next tick will take care of that.
+	 *
+	 * If high resolution mode is active then the next expiring timer
+	 * must be reevaluated and the clock event device reprogrammed if
+	 * necessary.
+	 *
+	 * In the NOHZ case the update of the offset and the reevaluation
+	 * of the next expiring timer is enough. The return from the SMP
+	 * function call will take care of the reprogramming in case the
+	 * CPU was in a NOHZ idle sleep.
+	 */
+	if (!__hrtimer_hres_active(base) && !tick_nohz_active)
+		return;
+
+	raw_spin_lock(&base->lock);
+	hrtimer_update_base(base);
+	if (__hrtimer_hres_active(base))
+		hrtimer_force_reprogram(base, 0);
+	else
+		hrtimer_update_next_event(base);
+	raw_spin_unlock(&base->lock);
+}
 
 /*
  * When a timer is enqueued and expires earlier than the already enqueued
@@ -842,22 +867,28 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
 }
 
 /*
- * Clock realtime was set
- *
- * Change the offset of the realtime clock vs. the monotonic
- * clock.
+ * Clock was set. This might affect CLOCK_REALTIME, CLOCK_TAI and
+ * CLOCK_BOOTTIME (for late sleep time injection).
  *
- * We might have to reprogram the high resolution timer interrupt. On
- * SMP we call the architecture specific code to retrigger _all_ high
- * resolution timer interrupts. On UP we just disable interrupts and
- * call the high resolution interrupt code.
+ * This requires to update the offsets for these clocks
+ * vs. CLOCK_MONOTONIC. When high resolution timers are enabled, then this
+ * also requires to eventually reprogram the per CPU clock event devices
+ * when the change moves an affected timer ahead of the first expiring
+ * timer on that CPU. Obviously remote per CPU clock event devices cannot
+ * be reprogrammed. The other reason why an IPI has to be sent is when the
+ * system is in !HIGH_RES and NOHZ mode. The NOHZ mode updates the offsets
+ * in the tick, which obviously might be stopped, so this has to bring out
+ * the remote CPU which might sleep in idle to get this sorted.
  */
 void clock_was_set(void)
 {
-#ifdef CONFIG_HIGH_RES_TIMERS
+	if (!hrtimer_hres_active() && !tick_nohz_active)
+		goto out_timerfd;
+
 	/* Retrigger the CPU local events everywhere */
 	on_each_cpu(retrigger_next_event, NULL, 1);
-#endif
+
+out_timerfd:
 	timerfd_clock_was_set();
 }
 
