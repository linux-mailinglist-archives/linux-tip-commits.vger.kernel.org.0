Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2734E39633F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 May 2021 17:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbhEaPKw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 31 May 2021 11:10:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54964 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbhEaPIl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 31 May 2021 11:08:41 -0400
Date:   Mon, 31 May 2021 15:06:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622473620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eJsc+fCoI7FcRfS0YrtvO77yKk0hWIfDD7peKlScexA=;
        b=xlGdC1uvYWM86q5GBNXoD6NgNEHwSRbYAXqfQnc7ob0eJS6XwtiLflYZo1+zW0IEGkt832
        69VVos4xiWMOXC6XQ1cBL1XPnKD9iK7GX3TY07YAA/KYx4nA9ux5zxw7OQ/AnrsbdvO8fk
        exv3xtrzCt+jktqmZ74C/LvdISpceQ6nZQtXSWVnxl9y4+nkBWM+dWb1NI5EELmv4mFcYu
        QAYRT2fuojbXIdRNhZ7NdfEvsid5zTwd1ieioQAvjfBwZ8Uc8AgBo/9Z0SZVuBBcZMiqVJ
        385k+VdcqWzEJhgrBREIceI6AHH9G9EKF4a20KMyMLqBrWIaDAfUQ/AvYIsKcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622473620;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eJsc+fCoI7FcRfS0YrtvO77yKk0hWIfDD7peKlScexA=;
        b=adF5jhDhgDRaK6clkpKjd15YV5bKu2e9JZW8aqGgoX5c5CjomypASzgL7L7KWIQ78GulPt
        bFXHQSiDoDDg9fDw==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/broadcast: Prefer per-cpu oneshot wakeup
 timers to broadcast
Cc:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210524221818.15850-4-will@kernel.org>
References: <20210524221818.15850-4-will@kernel.org>
MIME-Version: 1.0
Message-ID: <162247361943.29796.573636369763733195.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c94a8537df12708cc03da9120c3c3561ae744ce1
Gitweb:        https://git.kernel.org/tip/c94a8537df12708cc03da9120c3c3561ae744ce1
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Mon, 24 May 2021 23:18:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 31 May 2021 17:04:45 +02:00

tick/broadcast: Prefer per-cpu oneshot wakeup timers to broadcast

Some SoCs have two per-cpu timer implementations where the timer with the
higher rating stops in deep idle (i.e. suffers from CLOCK_EVT_FEAT_C3STOP)
but is otherwise preferable to the timer with the lower rating. In such a
design, selecting the higher rated devices relies on a global broadcast
timer and IPIs to wake up from deep idle states.

To avoid the reliance on a global broadcast timer and also to reduce the
overhead associated with the IPI wakeups, extend
tick_install_broadcast_device() to manage per-cpu wakeup timers separately
from the broadcast device.

For now, these timers remain unused.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210524221818.15850-4-will@kernel.org

---
 kernel/time/tick-broadcast.c | 59 ++++++++++++++++++++++++++++++++++-
 kernel/time/tick-common.c    |  2 +-
 kernel/time/tick-internal.h  |  4 +-
 3 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index f3f2f4b..0e9e06d 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -33,6 +33,8 @@ static int tick_broadcast_forced;
 static __cacheline_aligned_in_smp DEFINE_RAW_SPINLOCK(tick_broadcast_lock);
 
 #ifdef CONFIG_TICK_ONESHOT
+static DEFINE_PER_CPU(struct clock_event_device *, tick_oneshot_wakeup_device);
+
 static void tick_broadcast_setup_oneshot(struct clock_event_device *bc);
 static void tick_broadcast_clear_oneshot(int cpu);
 static void tick_resume_broadcast_oneshot(struct clock_event_device *bc);
@@ -88,13 +90,65 @@ static bool tick_check_broadcast_device(struct clock_event_device *curdev,
 	return !curdev || newdev->rating > curdev->rating;
 }
 
+#ifdef CONFIG_TICK_ONESHOT
+static struct clock_event_device *tick_get_oneshot_wakeup_device(int cpu)
+{
+	return per_cpu(tick_oneshot_wakeup_device, cpu);
+}
+
+static bool tick_set_oneshot_wakeup_device(struct clock_event_device *newdev,
+					   int cpu)
+{
+	struct clock_event_device *curdev = tick_get_oneshot_wakeup_device(cpu);
+
+	if (!newdev)
+		goto set_device;
+
+	if ((newdev->features & CLOCK_EVT_FEAT_DUMMY) ||
+	    (newdev->features & CLOCK_EVT_FEAT_C3STOP))
+		 return false;
+
+	if (!(newdev->features & CLOCK_EVT_FEAT_PERCPU) ||
+	    !(newdev->features & CLOCK_EVT_FEAT_ONESHOT))
+		return false;
+
+	if (!cpumask_equal(newdev->cpumask, cpumask_of(cpu)))
+		return false;
+
+	if (curdev && newdev->rating <= curdev->rating)
+		return false;
+
+	if (!try_module_get(newdev->owner))
+		return false;
+
+set_device:
+	clockevents_exchange_device(curdev, newdev);
+	per_cpu(tick_oneshot_wakeup_device, cpu) = newdev;
+	return true;
+}
+#else
+static struct clock_event_device *tick_get_oneshot_wakeup_device(int cpu)
+{
+	return NULL;
+}
+
+static bool tick_set_oneshot_wakeup_device(struct clock_event_device *newdev,
+					   int cpu)
+{
+	return false;
+}
+#endif
+
 /*
  * Conditionally install/replace broadcast device
  */
-void tick_install_broadcast_device(struct clock_event_device *dev)
+void tick_install_broadcast_device(struct clock_event_device *dev, int cpu)
 {
 	struct clock_event_device *cur = tick_broadcast_device.evtdev;
 
+	if (tick_set_oneshot_wakeup_device(dev, cpu))
+		return;
+
 	if (!tick_check_broadcast_device(cur, dev))
 		return;
 
@@ -996,6 +1050,9 @@ void hotplug_cpu__broadcast_tick_pull(int deadcpu)
  */
 static void tick_broadcast_oneshot_offline(unsigned int cpu)
 {
+	if (tick_get_oneshot_wakeup_device(cpu))
+		tick_set_oneshot_wakeup_device(NULL, cpu);
+
 	/*
 	 * Clear the broadcast masks for the dead cpu, but do not stop
 	 * the broadcast device!
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index e15bc0e..d663249 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -373,7 +373,7 @@ out_bc:
 	/*
 	 * Can the new device be used as a broadcast device ?
 	 */
-	tick_install_broadcast_device(newdev);
+	tick_install_broadcast_device(newdev, cpu);
 }
 
 /**
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 7a981c9..30c8963 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -61,7 +61,7 @@ extern ssize_t sysfs_get_uname(const char *buf, char *dst, size_t cnt);
 /* Broadcasting support */
 # ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 extern int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu);
-extern void tick_install_broadcast_device(struct clock_event_device *dev);
+extern void tick_install_broadcast_device(struct clock_event_device *dev, int cpu);
 extern int tick_is_broadcast_device(struct clock_event_device *dev);
 extern void tick_suspend_broadcast(void);
 extern void tick_resume_broadcast(void);
@@ -72,7 +72,7 @@ extern int tick_broadcast_update_freq(struct clock_event_device *dev, u32 freq);
 extern struct tick_device *tick_get_broadcast_device(void);
 extern struct cpumask *tick_get_broadcast_mask(void);
 # else /* !CONFIG_GENERIC_CLOCKEVENTS_BROADCAST: */
-static inline void tick_install_broadcast_device(struct clock_event_device *dev) { }
+static inline void tick_install_broadcast_device(struct clock_event_device *dev, int cpu) { }
 static inline int tick_is_broadcast_device(struct clock_event_device *dev) { return 0; }
 static inline int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu) { return 0; }
 static inline void tick_do_periodic_broadcast(struct clock_event_device *d) { }
