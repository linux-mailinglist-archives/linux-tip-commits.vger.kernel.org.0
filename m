Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A17C3E7CFF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 18:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbhHJQCj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 12:02:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44420 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbhHJQCh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 12:02:37 -0400
Date:   Tue, 10 Aug 2021 16:02:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628611334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tiuhBpP4+euhjWICSx7gtfYGOgu+IbTsh6zaIkkkN3c=;
        b=Ew/WBQVeAOTIGcqXkhE71arL3v7mphD26z9UCjI9hlJ6FqQ/QhlL6/Rn++n+M8ov5eBDLB
        5DrXOPeOh7Yujq9XcFYckWthfEQttQx3KOTnnzHOLYtX8kxisL7ydN2MBJ10JBu9kXTraA
        OLGHTdbWCye85iAF9U+rIIAQjCmR8IMFIs3zXpXFE+dU28AkKUbkkd94+n0tUN6BUTAnmh
        bHuHyiy1BK9Und1U4ByhpETE0JT5eJxvOhYjsesl/fBNPvOwKY+sDyxzKn+2KDUWrv9vjh
        qwVWy3HmpD/3/3Dl5eK26aETZf68lMrQ1SwTerBbG/JS/ei9iHal+jpFbg8CCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628611334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tiuhBpP4+euhjWICSx7gtfYGOgu+IbTsh6zaIkkkN3c=;
        b=wCOvZpm44SZyGoE5UROGrJaHdJvpme0FwQ++OPtp9HboC4CgDkAoxfD9Akmv4PMLDbEM26
        aDCXzuJLl/UUusDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Add bases argument to clock_was_set()
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210713135158.691083465@linutronix.de>
References: <20210713135158.691083465@linutronix.de>
MIME-Version: 1.0
Message-ID: <162861133341.395.7457578233576977877.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     17a1b8826b451c80e7999a7c68e06b70579b2b8f
Gitweb:        https://git.kernel.org/tip/17a1b8826b451c80e7999a7c68e06b70579b2b8f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Jul 2021 15:39:53 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 17:57:23 +02:00

hrtimer: Add bases argument to clock_was_set()

clock_was_set() unconditionaly invokes retrigger_next_event() on all online
CPUs. This was necessary because that mechanism was also used for resume
from suspend to idle which is not longer the case.

The bases arguments allows the callers of clock_was_set() to hand in a mask
which tells clock_was_set() which of the hrtimer clock bases are affected
by the clock setting. This mask will be used in the next step to check
whether a CPU base has timers queued on a clock base affected by the event
and avoid the SMP function call if there are none.

Add a @bases argument, provide defines for the active bases masking and
fixup all callsites.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210713135158.691083465@linutronix.de

---
 kernel/time/hrtimer.c       |  4 ++--
 kernel/time/tick-internal.h |  9 ++++++++-
 kernel/time/timekeeping.c   | 14 +++++++-------
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 68e56f0..c8af165 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -880,7 +880,7 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
  * in the tick, which obviously might be stopped, so this has to bring out
  * the remote CPU which might sleep in idle to get this sorted.
  */
-void clock_was_set(void)
+void clock_was_set(unsigned int bases)
 {
 	if (!hrtimer_hres_active() && !tick_nohz_active)
 		goto out_timerfd;
@@ -894,7 +894,7 @@ out_timerfd:
 
 static void clock_was_set_work(struct work_struct *work)
 {
-	clock_was_set();
+	clock_was_set(CLOCK_SET_WALL);
 }
 
 static DECLARE_WORK(hrtimer_work, clock_was_set_work);
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 22de98c..3548f08 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -166,7 +166,14 @@ DECLARE_PER_CPU(struct hrtimer_cpu_base, hrtimer_bases);
 extern u64 get_next_timer_interrupt(unsigned long basej, u64 basem);
 void timer_clear_idle(void);
 
-void clock_was_set(void);
+#define CLOCK_SET_WALL							\
+	(BIT(HRTIMER_BASE_REALTIME) | BIT(HRTIMER_BASE_REALTIME_SOFT) |	\
+	 BIT(HRTIMER_BASE_TAI) | BIT(HRTIMER_BASE_TAI_SOFT))
+
+#define CLOCK_SET_BOOT							\
+	(BIT(HRTIMER_BASE_BOOTTIME) | BIT(HRTIMER_BASE_BOOTTIME_SOFT))
+
+void clock_was_set(unsigned int bases);
 void clock_was_set_delayed(void);
 
 void hrtimers_resume_local(void);
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 19ed58e..b348749 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1323,8 +1323,8 @@ out:
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
-	/* signal hrtimers about time change */
-	clock_was_set();
+	/* Signal hrtimers about time change */
+	clock_was_set(CLOCK_SET_WALL);
 
 	if (!ret)
 		audit_tk_injoffset(ts_delta);
@@ -1371,8 +1371,8 @@ error: /* even if we error out, we forwarded the time, so call update */
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
-	/* signal hrtimers about time change */
-	clock_was_set();
+	/* Signal hrtimers about time change */
+	clock_was_set(CLOCK_SET_WALL);
 
 	return ret;
 }
@@ -1746,8 +1746,8 @@ void timekeeping_inject_sleeptime64(const struct timespec64 *delta)
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
-	/* signal hrtimers about time change */
-	clock_was_set();
+	/* Signal hrtimers about time change */
+	clock_was_set(CLOCK_SET_WALL | CLOCK_SET_BOOT);
 }
 #endif
 
@@ -2440,7 +2440,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 		clock_set |= timekeeping_advance(TK_ADV_FREQ);
 
 	if (clock_set)
-		clock_was_set();
+		clock_was_set(CLOCK_REALTIME);
 
 	ntp_notify_cmos_timer();
 
