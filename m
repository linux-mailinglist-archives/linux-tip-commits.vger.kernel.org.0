Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298123EABE3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Aug 2021 22:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhHLUkh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 12 Aug 2021 16:40:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60886 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhHLUkg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 12 Aug 2021 16:40:36 -0400
Date:   Thu, 12 Aug 2021 20:40:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628800810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mLxOOJTgmBsH4ceEt7U7qAgU0ffA70LQGqLsn5SImwI=;
        b=hUTk2+7qjuIn3bCp9fpDndmkCWduahGUgjgPItz+Il3y1G8VPmszMFheCnxKWKuRg9TDB7
        Z4JF4A7krWS+jhe0em2HriokqR1H2SD3Bbp0SMtmHI7fgTY0Ek4XyXzz2d/4yIOxq2Mcl3
        rkdXtsth3YrhcgR1ilvSsC3a3AUT46wEMz0mG9TImoKV2YUKRjSY6qagPdv1F262HiL5x8
        wu3KnbOjTlEkVtOXxDMXEf5xB1TFjJ0nBkyLJr9RKUThLd6TuBgW9LFOQ9TApYMciQUrS9
        f0NblH0T+EpxtjoT2y/NSFRsZCBUpV39BywroolTnKKPUOr5DlsMZFpgDRGRYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628800810;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mLxOOJTgmBsH4ceEt7U7qAgU0ffA70LQGqLsn5SImwI=;
        b=3NhhrqElTBt9h4zjYrc54RA6lN4G/wbde4CzX+CpmXhlflIqcGnjIInyyM0qi++6flthaR
        EnzkKK/to6IHmaAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Unbreak hrtimer_force_reprogram()
Cc:     Mike Galbraith <efault@gmx.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <8735recskh.ffs@tglx>
References: <8735recskh.ffs@tglx>
MIME-Version: 1.0
Message-ID: <162880080883.395.18131494384243612114.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     f80e21489590c00f46226d5802d900e6f66e5633
Gitweb:        https://git.kernel.org/tip/f80e21489590c00f46226d5802d900e6f66e5633
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 12 Aug 2021 22:32:30 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 12 Aug 2021 22:34:40 +02:00

hrtimer: Unbreak hrtimer_force_reprogram()

Since the recent consoliation of reprogramming functions,
hrtimer_force_reprogram() is affected by a check whether the new expiry
time is past the current expiry time.

This breaks the NOHZ logic as that relies on the fact that the tick hrtimer
is moved into the future. That means cpu_base->expires_next becomes stale
and subsequent reprogramming attempts fail as well until the situation is
cleaned up by an hrtimer interrupts.

For some yet unknown reason this leads to a complete stall, so for now
partially revert the offending commit to a known working state. The root
cause for the stall is still investigated and will be fixed in a subsequent
commit.

Fixes: b14bca97c9f5 ("hrtimer: Consolidate reprogramming code")
Reported-by: Mike Galbraith <efault@gmx.de>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Mike Galbraith <efault@gmx.de>
Link: https://lore.kernel.org/r/8735recskh.ffs@tglx

---
 kernel/time/hrtimer.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 33b00e2..0ea8702 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -652,24 +652,10 @@ static inline int hrtimer_hres_active(void)
 	return __hrtimer_hres_active(this_cpu_ptr(&hrtimer_bases));
 }
 
-static void
-__hrtimer_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal,
-		    struct hrtimer *next_timer, ktime_t expires_next)
+static void __hrtimer_reprogram(struct hrtimer_cpu_base *cpu_base,
+				struct hrtimer *next_timer,
+				ktime_t expires_next)
 {
-	/*
-	 * If the hrtimer interrupt is running, then it will reevaluate the
-	 * clock bases and reprogram the clock event device.
-	 */
-	if (cpu_base->in_hrtirq)
-		return;
-
-	if (expires_next > cpu_base->expires_next)
-		return;
-
-	if (skip_equal && expires_next == cpu_base->expires_next)
-		return;
-
-	cpu_base->next_timer = next_timer;
 	cpu_base->expires_next = expires_next;
 
 	/*
@@ -707,8 +693,10 @@ hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal)
 
 	expires_next = hrtimer_update_next_event(cpu_base);
 
-	__hrtimer_reprogram(cpu_base, skip_equal, cpu_base->next_timer,
-			    expires_next);
+	if (skip_equal && expires_next == cpu_base->expires_next)
+		return;
+
+	__hrtimer_reprogram(cpu_base, cpu_base->next_timer, expires_next);
 }
 
 /* High resolution timer related functions */
@@ -863,7 +851,19 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
 	if (base->cpu_base != cpu_base)
 		return;
 
-	__hrtimer_reprogram(cpu_base, true, timer, expires);
+	if (expires >= cpu_base->expires_next)
+		return;
+
+	/*
+	 * If the hrtimer interrupt is running, then it will reevaluate the
+	 * clock bases and reprogram the clock event device.
+	 */
+	if (cpu_base->in_hrtirq)
+		return;
+
+	cpu_base->next_timer = timer;
+
+	__hrtimer_reprogram(cpu_base, timer, expires);
 }
 
 static bool update_needs_ipi(struct hrtimer_cpu_base *cpu_base,
