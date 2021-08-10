Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740EE3E7D09
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 18:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbhHJQCs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 12:02:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44440 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbhHJQCl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 12:02:41 -0400
Date:   Tue, 10 Aug 2021 16:02:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628611338;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XLtM8f1wACaF4P3HiDqtuQf6TysXYDwIFm7YnLmVkPY=;
        b=rMPMjQJEb14tfEhwoIM4U1O3nsu8cnQsSEF/6i/78K2vnX07t5uw7j/Fkwvtzpxg90XT7L
        GgvaewHjXKUyCAbu/EuxULggpTWYN+Zfo32eRsu6IJkLWkdj2bjTTLsiQgx3qfoAXS/t9s
        lScO+1ywK5n4hzK+KgxTc9iwwCvWXxrVC6Ix3BY+2cUReTK/0fB+xNmWAZX45D418TVtNt
        steNrQcvvRTeF/chBcCMtuFge8WHWByW9XjBU5A5ZAeI2fHUaeYRvmKlzgWlRogCgoGNHp
        4cvxbCBdmIhloa+tlEMn8mLXbQweuHZzu9YIL2Pd6AS1fB8XaoEmTvPx9QwMPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628611338;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XLtM8f1wACaF4P3HiDqtuQf6TysXYDwIFm7YnLmVkPY=;
        b=eQOs0BSCV8rDWLqp9+dsUPZg73heLqESCCxNdqmo13BZXBqUfmNVuf16AhbYyBf7A01xMW
        kfP+bVz5LLUw4SAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Consolidate reprogramming code
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210713135158.054424875@linutronix.de>
References: <20210713135158.054424875@linutronix.de>
MIME-Version: 1.0
Message-ID: <162861133759.395.7795246170325882103.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b14bca97c9f5c3e3f133445b01c723e95490d843
Gitweb:        https://git.kernel.org/tip/b14bca97c9f5c3e3f133445b01c723e95490d843
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 13 Jul 2021 15:39:47 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 17:57:22 +02:00

hrtimer: Consolidate reprogramming code

This code is mostly duplicated. The redudant store in the force reprogram
case does no harm and the in hrtimer interrupt condition cannot be true for
the force reprogram invocations.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210713135158.054424875@linutronix.de

---
 kernel/time/hrtimer.c | 72 ++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 43 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index ba2e0d0..5f7c465 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -652,21 +652,24 @@ static inline int hrtimer_hres_active(void)
 	return __hrtimer_hres_active(this_cpu_ptr(&hrtimer_bases));
 }
 
-/*
- * Reprogram the event source with checking both queues for the
- * next event
- * Called with interrupts disabled and base->lock held
- */
 static void
-hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal)
+__hrtimer_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal,
+		    struct hrtimer *next_timer, ktime_t expires_next)
 {
-	ktime_t expires_next;
+	/*
+	 * If the hrtimer interrupt is running, then it will reevaluate the
+	 * clock bases and reprogram the clock event device.
+	 */
+	if (cpu_base->in_hrtirq)
+		return;
 
-	expires_next = hrtimer_update_next_event(cpu_base);
+	if (expires_next > cpu_base->expires_next)
+		return;
 
 	if (skip_equal && expires_next == cpu_base->expires_next)
 		return;
 
+	cpu_base->next_timer = next_timer;
 	cpu_base->expires_next = expires_next;
 
 	/*
@@ -689,7 +692,23 @@ hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal)
 	if (!__hrtimer_hres_active(cpu_base) || cpu_base->hang_detected)
 		return;
 
-	tick_program_event(cpu_base->expires_next, 1);
+	tick_program_event(expires_next, 1);
+}
+
+/*
+ * Reprogram the event source with checking both queues for the
+ * next event
+ * Called with interrupts disabled and base->lock held
+ */
+static void
+hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal)
+{
+	ktime_t expires_next;
+
+	expires_next = hrtimer_update_next_event(cpu_base);
+
+	__hrtimer_reprogram(cpu_base, skip_equal, cpu_base->next_timer,
+			    expires_next);
 }
 
 /* High resolution timer related functions */
@@ -835,40 +854,7 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
 	if (base->cpu_base != cpu_base)
 		return;
 
-	/*
-	 * If the hrtimer interrupt is running, then it will
-	 * reevaluate the clock bases and reprogram the clock event
-	 * device. The callbacks are always executed in hard interrupt
-	 * context so we don't need an extra check for a running
-	 * callback.
-	 */
-	if (cpu_base->in_hrtirq)
-		return;
-
-	if (expires >= cpu_base->expires_next)
-		return;
-
-	/* Update the pointer to the next expiring timer */
-	cpu_base->next_timer = timer;
-	cpu_base->expires_next = expires;
-
-	/*
-	 * If hres is not active, hardware does not have to be
-	 * programmed yet.
-	 *
-	 * If a hang was detected in the last timer interrupt then we
-	 * do not schedule a timer which is earlier than the expiry
-	 * which we enforced in the hang detection. We want the system
-	 * to make progress.
-	 */
-	if (!__hrtimer_hres_active(cpu_base) || cpu_base->hang_detected)
-		return;
-
-	/*
-	 * Program the timer hardware. We enforce the expiry for
-	 * events which are already in the past.
-	 */
-	tick_program_event(expires, 1);
+	__hrtimer_reprogram(cpu_base, true, timer, expires);
 }
 
 /*
