Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D10E3E7D03
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 18:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhHJQCo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 12:02:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44426 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbhHJQCk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 12:02:40 -0400
Date:   Tue, 10 Aug 2021 16:02:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628611337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+Di+oeQb7qp/YkaWpFPls2/C+FOqofGDg2cAkYs4bU=;
        b=qahBW7Gd7E0VRYSs7tKezdb02qLkEtpnyQwvkZDgudg/KhaoY1iw3yTx+ey/ZmBfV+YOkr
        p18BKIGuAF2LaqMYmTLYG1gcoWdXn0QLG5yStsg9N8kxfNgMOquGCPTHbdEo9YwP7m6yQJ
        QIhQY1FmE47WnRe4ROWPRQyBKM7igPX84PSBnbAXeJmmfQSiuooviSQ7fZXp//iKA9Nsqd
        zdRYDn9A1PUaEsxJHmO98xJM44BwX6MrY7WmMTgO7jwl+sE7GPNAy/Rg7W43AexM45dVk+
        1med7TjHQlhtpZJOzcCoECe29QIzswcU8+ByQ/hDVAt/axQIk1vnVyB+USR3fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628611337;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+Di+oeQb7qp/YkaWpFPls2/C+FOqofGDg2cAkYs4bU=;
        b=84hfHiVogeh4vdx6lJdxXRtPEa4kPs2Pq0oIdxtFnVWfIIk90DUZu/i02ZnFpGnl929/rj
        MZY+fMSb580TPVAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Ensure timerfd notification for HIGHRES=n
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210713135158.196661266@linutronix.de>
References: <20210713135158.196661266@linutronix.de>
MIME-Version: 1.0
Message-ID: <162861133691.395.4435108606724237099.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8c3b5e6ec0fee18bc2ce38d1dfe913413205f908
Gitweb:        https://git.kernel.org/tip/8c3b5e6ec0fee18bc2ce38d1dfe913413205f908
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Jul 2021 15:39:48 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 17:57:22 +02:00

hrtimer: Ensure timerfd notification for HIGHRES=n

If high resolution timers are disabled the timerfd notification about a
clock was set event is not happening for all cases which use
clock_was_set_delayed() because that's a NOP for HIGHRES=n, which is wrong.

Make clock_was_set_delayed() unconditially available to fix that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210713135158.196661266@linutronix.de

---
 include/linux/hrtimer.h     |  5 -----
 kernel/time/hrtimer.c       | 32 ++++++++++++++++----------------
 kernel/time/tick-internal.h |  3 +++
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index bb5e7b0..77295af 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -318,16 +318,12 @@ struct clock_event_device;
 
 extern void hrtimer_interrupt(struct clock_event_device *dev);
 
-extern void clock_was_set_delayed(void);
-
 extern unsigned int hrtimer_resolution;
 
 #else
 
 #define hrtimer_resolution	(unsigned int)LOW_RES_NSEC
 
-static inline void clock_was_set_delayed(void) { }
-
 #endif
 
 static inline ktime_t
@@ -351,7 +347,6 @@ hrtimer_expires_remaining_adjusted(const struct hrtimer *timer)
 						    timer->base->get_time());
 }
 
-extern void clock_was_set(void);
 #ifdef CONFIG_TIMERFD
 extern void timerfd_clock_was_set(void);
 #else
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 5f7c465..7ebf642 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -777,22 +777,6 @@ static void hrtimer_switch_to_hres(void)
 	retrigger_next_event(NULL);
 }
 
-static void clock_was_set_work(struct work_struct *work)
-{
-	clock_was_set();
-}
-
-static DECLARE_WORK(hrtimer_work, clock_was_set_work);
-
-/*
- * Called from timekeeping and resume code to reprogram the hrtimer
- * interrupt device on all cpus.
- */
-void clock_was_set_delayed(void)
-{
-	schedule_work(&hrtimer_work);
-}
-
 #else
 
 static inline int hrtimer_is_hres_enabled(void) { return 0; }
@@ -877,6 +861,22 @@ void clock_was_set(void)
 	timerfd_clock_was_set();
 }
 
+static void clock_was_set_work(struct work_struct *work)
+{
+	clock_was_set();
+}
+
+static DECLARE_WORK(hrtimer_work, clock_was_set_work);
+
+/*
+ * Called from timekeeping and resume code to reprogram the hrtimer
+ * interrupt device on all cpus and to notify timerfd.
+ */
+void clock_was_set_delayed(void)
+{
+	schedule_work(&hrtimer_work);
+}
+
 /*
  * During resume we might have to reprogram the high resolution timer
  * interrupt on all online CPUs.  However, all other CPUs will be
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 6a742a2..cd610fa 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -165,3 +165,6 @@ DECLARE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases);
 
 extern u64 get_next_timer_interrupt(unsigned long basej, u64 basem);
 void timer_clear_idle(void);
+
+void clock_was_set(void);
+void clock_was_set_delayed(void);
