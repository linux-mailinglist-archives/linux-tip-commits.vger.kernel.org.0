Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A18F3E7D04
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 18:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbhHJQCo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 12:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbhHJQCj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 12:02:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA37C0613C1;
        Tue, 10 Aug 2021 09:02:16 -0700 (PDT)
Date:   Tue, 10 Aug 2021 16:02:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628611335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WZA0WNmeYMONHKWsLus3V1EUHxpkbYooY2IMzfbt5ck=;
        b=kXcrVWXBggoCbXblx1hS69OcnvGtaQGdKR0anrcgGZW/fj+HvYmjN93X7g8yq/x/J/jWvt
        7VNXZ6hAzx2YIGordmv6VtaWkwDIyfpfz8rMUcfcU6gYR8fwWshkgQpZKeLik7/kYkNXdE
        3NVxrXY0Ap/SnivmGSU/mMT9ML0fTQZxVYtlGW5kZhlWyXOYWda6e3tjl29eL+9DUCa6Gi
        o3k+urz1ebf7AM+Gau13l4G4jO93XfTDuae4gdZA7C+Uu+snci2+3x/ShE7YcB6z0Nsdip
        khHxT7/hGxQ70dX6dg2MJrJ/xMCnKNerM2eiMdCRtqrhFnvSe1/mEmYV9zJwaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628611335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WZA0WNmeYMONHKWsLus3V1EUHxpkbYooY2IMzfbt5ck=;
        b=MP4rN9y+wQq+Ve1V6i26raOWAq/gVWZAwHol2hBws/82/METvOy1ZIyQLvcjxcUl4nvV4e
        leYBS4L63s2bESDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Distangle resume and clock-was-set events
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210713135158.488853478@linutronix.de>
References: <20210713135158.488853478@linutronix.de>
MIME-Version: 1.0
Message-ID: <162861133485.395.9303310350677655795.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a761a67f591a8c7476c30bb20ed0f09fdfb1a704
Gitweb:        https://git.kernel.org/tip/a761a67f591a8c7476c30bb20ed0f09fdfb1a704
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Jul 2021 15:39:51 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 17:57:23 +02:00

timekeeping: Distangle resume and clock-was-set events

Resuming timekeeping is a clock-was-set event and uses the clock-was-set
notification mechanism. This is in the way of making the clock-was-set
update for hrtimers selective so unnecessary IPIs are avoided when a CPU
base does not have timers queued which are affected by the clock setting.

Distangle it by invoking hrtimer_resume() on each unfreezing CPU and invoke
the new timerfd_resume() function from timekeeping_resume() which is the
only place where this is needed.

Rename hrtimer_resume() to hrtimer_resume_local() to reflect the change.

With this the clock_was_set*() functions are not longer required to IPI all
CPUs unconditionally and can get some smarts to avoid them.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210713135158.488853478@linutronix.de

---
 include/linux/hrtimer.h     |  1 -
 kernel/time/hrtimer.c       | 15 ++++++---------
 kernel/time/tick-common.c   |  7 +++++++
 kernel/time/tick-internal.h |  2 ++
 kernel/time/timekeeping.c   |  4 +++-
 5 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 253c6e2..0ee1401 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -354,7 +354,6 @@ extern void timerfd_resume(void);
 static inline void timerfd_clock_was_set(void) { }
 static inline void timerfd_resume(void) { }
 #endif
-extern void hrtimers_resume(void);
 
 DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 214fd65..68e56f0 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -900,8 +900,8 @@ static void clock_was_set_work(struct work_struct *work)
 static DECLARE_WORK(hrtimer_work, clock_was_set_work);
 
 /*
- * Called from timekeeping and resume code to reprogram the hrtimer
- * interrupt device on all cpus and to notify timerfd.
+ * Called from timekeeping code to reprogram the hrtimer interrupt device
+ * on all cpus and to notify timerfd.
  */
 void clock_was_set_delayed(void)
 {
@@ -909,18 +909,15 @@ void clock_was_set_delayed(void)
 }
 
 /*
- * During resume we might have to reprogram the high resolution timer
- * interrupt on all online CPUs.  However, all other CPUs will be
- * stopped with IRQs interrupts disabled so the clock_was_set() call
- * must be deferred.
+ * Called during resume either directly from via timekeeping_resume()
+ * or in the case of s2idle from tick_unfreeze() to ensure that the
+ * hrtimers are up to date.
  */
-void hrtimers_resume(void)
+void hrtimers_resume_local(void)
 {
 	lockdep_assert_irqs_disabled();
 	/* Retrigger on the local CPU */
 	retrigger_next_event(NULL);
-	/* And schedule a retrigger for all others */
-	clock_was_set_delayed();
 }
 
 /*
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index d663249..4678935 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -470,6 +470,13 @@ void tick_resume_local(void)
 		else
 			tick_resume_oneshot();
 	}
+
+	/*
+	 * Ensure that hrtimers are up to date and the clockevents device
+	 * is reprogrammed correctly when high resolution timers are
+	 * enabled.
+	 */
+	hrtimers_resume_local();
 }
 
 /**
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index cd610fa..22de98c 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -168,3 +168,5 @@ void timer_clear_idle(void);
 
 void clock_was_set(void);
 void clock_was_set_delayed(void);
+
+void hrtimers_resume_local(void);
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 8a364aa..c8a9b9e 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1810,8 +1810,10 @@ void timekeeping_resume(void)
 
 	touch_softlockup_watchdog();
 
+	/* Resume the clockevent device(s) and hrtimers */
 	tick_resume();
-	hrtimers_resume();
+	/* Notify timerfd as resume is equivalent to clock_was_set() */
+	timerfd_resume();
 }
 
 int timekeeping_suspend(void)
