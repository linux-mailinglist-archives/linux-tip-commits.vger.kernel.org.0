Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC292B45C9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Nov 2020 15:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgKPOYJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 16 Nov 2020 09:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729937AbgKPOYJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 16 Nov 2020 09:24:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFA1C0613CF;
        Mon, 16 Nov 2020 06:24:09 -0800 (PST)
Date:   Mon, 16 Nov 2020 14:24:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605536647;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3nC3EnzSg1zq3AYs2Z0Rt4YR/a+wYsKv/urkwq9QBvk=;
        b=WDS7cdfhyAkV4E3yvsKGZ4svhbIcA7hSDGTGN4whHivqANDpeXRh4DSkCQnpzX1Zl5AYBU
        S/s8epdtl5sdC+DnuKL6t+ObJjBYQ72dL9SPZfHlU78wYkyeCAH7lycqP5fWLh+AOI8y2R
        Ux/rUQSKKNZdM/oUrxlTvJ2eLV6vqG2IjsIaq2Zspgd9DM/iR49SUObikPhPffnEHbjEbo
        FtMk3noUYQ610gZp5q+ZwHE7TqtMCYWXBbVNROBB86RpDMZbVeLfyjBzPHMAHywnfXBZ6x
        398NNh7JJ7FrG+2SSBkAj53KgXl7X0DtPzlTaEvHsg4PyRfZPId3GZfTy/S7hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605536647;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3nC3EnzSg1zq3AYs2Z0Rt4YR/a+wYsKv/urkwq9QBvk=;
        b=FpiEcFZzcaXqWdxmrqyatScVHE8npDWjiP6n7T1TumUKYE4I3taUYt5vwXRKgXMpTbN0s4
        ZLVV1Mq9t864wRDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Make run_local_timers() static
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160553664661.11244.14605265521984556096.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     cc947f2b9c04113d84eeef67cc7c6326e1982019
Gitweb:        https://git.kernel.org/tip/cc947f2b9c04113d84eeef67cc7c6326e1982019
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 16 Nov 2020 10:53:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 16 Nov 2020 15:20:01 +01:00

timers: Make run_local_timers() static

No users outside of the timer code. Move the caller below this function to
avoid a pointless forward declaration.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/timer.h |  1 +-
 kernel/time/timer.c   | 48 +++++++++++++++++++++---------------------
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index d10bc7e..fda13c9 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -193,7 +193,6 @@ extern int try_to_del_timer_sync(struct timer_list *timer);
 #define del_singleshot_timer_sync(t) del_timer_sync(t)
 
 extern void init_timers(void);
-extern void run_local_timers(void);
 struct hrtimer;
 extern enum hrtimer_restart it_real_fn(struct hrtimer *);
 
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index af9ddfb..ebf3b26 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1705,29 +1705,6 @@ void timer_clear_idle(void)
 }
 #endif
 
-/*
- * Called from the timer interrupt handler to charge one tick to the current
- * process.  user_tick is 1 if the tick is user time, 0 for system.
- */
-void update_process_times(int user_tick)
-{
-	struct task_struct *p = current;
-
-	PRANDOM_ADD_NOISE(jiffies, user_tick, p, 0);
-
-	/* Note: this timer irq context must be accounted for as well. */
-	account_process_tick(p, user_tick);
-	run_local_timers();
-	rcu_sched_clock_irq(user_tick);
-#ifdef CONFIG_IRQ_WORK
-	if (in_irq())
-		irq_work_tick();
-#endif
-	scheduler_tick();
-	if (IS_ENABLED(CONFIG_POSIX_TIMERS))
-		run_posix_cpu_timers();
-}
-
 /**
  * __run_timers - run all expired timers (if any) on this CPU.
  * @base: the timer vector to be processed.
@@ -1777,7 +1754,7 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 /*
  * Called by the local, per-CPU timer interrupt on SMP.
  */
-void run_local_timers(void)
+static void run_local_timers(void)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 
@@ -1795,6 +1772,29 @@ void run_local_timers(void)
 }
 
 /*
+ * Called from the timer interrupt handler to charge one tick to the current
+ * process.  user_tick is 1 if the tick is user time, 0 for system.
+ */
+void update_process_times(int user_tick)
+{
+	struct task_struct *p = current;
+
+	PRANDOM_ADD_NOISE(jiffies, user_tick, p, 0);
+
+	/* Note: this timer irq context must be accounted for as well. */
+	account_process_tick(p, user_tick);
+	run_local_timers();
+	rcu_sched_clock_irq(user_tick);
+#ifdef CONFIG_IRQ_WORK
+	if (in_irq())
+		irq_work_tick();
+#endif
+	scheduler_tick();
+	if (IS_ENABLED(CONFIG_POSIX_TIMERS))
+		run_posix_cpu_timers();
+}
+
+/*
  * Since schedule_timeout()'s timer is defined on the stack, it must store
  * the target task on the stack as well.
  */
