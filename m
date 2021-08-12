Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7103EABCD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 12 Aug 2021 22:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhHLUc6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 12 Aug 2021 16:32:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60834 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhHLUc5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 12 Aug 2021 16:32:57 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628800351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P0g6kaj3w3l8s66z1iLQpOYDO2iUHwY9sG7pabFyb34=;
        b=DYKdHnUvdxnuxcXHyOctQBNAzVUGe/MdAiljNir0XmAdfJkJswzL1jCWknLQ8S9IKq7jiW
        /mJgyYqZBmPnoAebGmfP2YbSDzSfsp2R+ve1YpkNqQAFhfq0YrikoyZwUF9q3qJbdMxywY
        9RNl08VOqk1cHNFmCl7k8sCFBJAgYE+wH7nYp/spmdtdqzB4w1ZZ8XrT5+nbIO7IIgR3jY
        6/j5cWEhrfCGlu2w9GWZc4nTYvc+D3jdDhEKJ2KAJ21mhDjdByXmzGiHhCh9ysGgvcSglW
        jP73Kf0aiSpjLPfRqkdJOU6STCzb3kjQw5bf10NIqAXNugGDHJhCOqwfjjEImg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628800351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P0g6kaj3w3l8s66z1iLQpOYDO2iUHwY9sG7pabFyb34=;
        b=lZ3p8zpAaDTY0wOmAI3HB0PocayVusZIVK1yN+a/OCs3DPncIdjTJ71/v9xZhrwyBlx91L
        ucH9SccbnJnRdmBg==
To:     Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: [PATCH] hrtimer: Unbreak hrtimer_force_reprogram()
In-Reply-To: <877dgqivhy.ffs@tglx>
References: <20210713135158.054424875@linutronix.de>
 <162861133759.395.7795246170325882103.tip-bot2@tip-bot2>
 <7dfb3b15af67400227e7fa9e1916c8add0374ba9.camel@gmx.de>
 <87a6lmiwi0.ffs@tglx> <877dgqivhy.ffs@tglx>
Date:   Thu, 12 Aug 2021 22:32:30 +0200
Message-ID: <8735recskh.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

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
---
 kernel/time/hrtimer.c |   40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -652,24 +652,10 @@ static inline int hrtimer_hres_active(vo
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
@@ -707,8 +693,10 @@ hrtimer_force_reprogram(struct hrtimer_c
 
 	expires_next = hrtimer_update_next_event(cpu_base);
 
-	__hrtimer_reprogram(cpu_base, skip_equal, cpu_base->next_timer,
-			    expires_next);
+	if (skip_equal && expires_next == cpu_base->expires_next)
+		return;
+
+	__hrtimer_reprogram(cpu_base, cpu_base->next_timer, expires_next);
 }
 
 /* High resolution timer related functions */
@@ -863,7 +851,19 @@ static void hrtimer_reprogram(struct hrt
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
