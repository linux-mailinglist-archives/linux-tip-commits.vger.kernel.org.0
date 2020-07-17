Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDB52244D9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Jul 2020 22:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgGQUBA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Jul 2020 16:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgGQUAT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Jul 2020 16:00:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C50C0619D2;
        Fri, 17 Jul 2020 13:00:19 -0700 (PDT)
Date:   Fri, 17 Jul 2020 20:00:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595016016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jATrqxhUtqYR6OlE2GurgkH26s0KlH3ySB+uK19l9nQ=;
        b=vpxY3VeMkYixYGR2DVobj7DweC8tUG661CXneptRONewYsitIgAalr6bJsrREfMawy9E7Z
        5qBkINdeXkB/pWBHurgVUUrkq6aDHWtJ//wojWIHlf9Jco31/47q1wi5DC7NvG8SbXZHG0
        b7Q+snuM73QDfFXYmUCyL008zvduJIEy8M2+P5LQFXcCDdMwjYwpiT7NIk3RKERNrKa9ul
        v8sHP0xrZKypSNxWEstukjRW8kAPBqNFSvw5o7FYRd8jf8EIGqK41clRDHhCedZ8RlORrQ
        ZkP1bttsii4OGKgHuRhN91ZQSlFJfmsK4C6MjYYChTk3al4pF4ek+Zi+cBXdmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595016016;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jATrqxhUtqYR6OlE2GurgkH26s0KlH3ySB+uK19l9nQ=;
        b=k2WOH3T49Rd+cGbOSUN4RxnJbIwXYapKSaiwRoxufvw2/c/ZsJ8Veq7l0ZNdULgyUoj/ms
        Nz89Od0LU+9n05Bg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Spare timer softirq until next expiry
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200717140551.29076-11-frederic@kernel.org>
References: <20200717140551.29076-11-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <159501601624.4006.1826782394608982623.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d4f7dae87096dfe722bf32aa82076ece1063746c
Gitweb:        https://git.kernel.org/tip/d4f7dae87096dfe722bf32aa82076ece1063746c
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 17 Jul 2020 16:05:49 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 21:55:24 +02:00

timers: Spare timer softirq until next expiry

Now that the core timer infrastructure doesn't depend anymore on
periodic base->clk increments, even when the CPU is not in NO_HZ mode,
timer softirqs can be skipped until there are timers to expire.

Some spurious softirqs can still remain since base->next_expiry doesn't
keep track of canceled timers but this still reduces the number of softirqs
significantly: ~15 times less for HZ=1000 and ~5 times less for HZ=100.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20200717140551.29076-11-frederic@kernel.org

---
 kernel/time/timer.c | 49 +++++++-------------------------------------
 1 file changed, 8 insertions(+), 41 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 1be92b5..4f78a7b 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1458,10 +1458,10 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 	}
 }
 
-static int __collect_expired_timers(struct timer_base *base,
-				    struct hlist_head *heads)
+static int collect_expired_timers(struct timer_base *base,
+				  struct hlist_head *heads)
 {
-	unsigned long clk = base->clk;
+	unsigned long clk = base->clk = base->next_expiry;
 	struct hlist_head *vec;
 	int i, levels = 0;
 	unsigned int idx;
@@ -1684,40 +1684,6 @@ void timer_clear_idle(void)
 	 */
 	base->is_idle = false;
 }
-
-static int collect_expired_timers(struct timer_base *base,
-				  struct hlist_head *heads)
-{
-	unsigned long now = READ_ONCE(jiffies);
-
-	/*
-	 * NOHZ optimization. After a long idle sleep we need to forward the
-	 * base to current jiffies. Avoid a loop by searching the bitfield for
-	 * the next expiring timer.
-	 */
-	if ((long)(now - base->clk) > 2) {
-		/*
-		 * If the next timer is ahead of time forward to current
-		 * jiffies, otherwise forward to the next expiry time:
-		 */
-		if (time_after(base->next_expiry, now)) {
-			/*
-			 * The call site will increment base->clk and then
-			 * terminate the expiry loop immediately.
-			 */
-			base->clk = now;
-			return 0;
-		}
-		base->clk = base->next_expiry;
-	}
-	return __collect_expired_timers(base, heads);
-}
-#else
-static inline int collect_expired_timers(struct timer_base *base,
-					 struct hlist_head *heads)
-{
-	return __collect_expired_timers(base, heads);
-}
 #endif
 
 /*
@@ -1750,7 +1716,7 @@ static inline void __run_timers(struct timer_base *base)
 	struct hlist_head heads[LVL_DEPTH];
 	int levels;
 
-	if (!time_after_eq(jiffies, base->clk))
+	if (time_before(jiffies, base->next_expiry))
 		return;
 
 	timer_base_lock_expiry(base);
@@ -1763,7 +1729,8 @@ static inline void __run_timers(struct timer_base *base)
 	 */
 	base->must_forward_clk = false;
 
-	while (time_after_eq(jiffies, base->clk)) {
+	while (time_after_eq(jiffies, base->clk) &&
+	       time_after_eq(jiffies, base->next_expiry)) {
 
 		levels = collect_expired_timers(base, heads);
 		base->clk++;
@@ -1798,12 +1765,12 @@ void run_local_timers(void)
 
 	hrtimer_run_queues();
 	/* Raise the softirq only if required. */
-	if (time_before(jiffies, base->clk)) {
+	if (time_before(jiffies, base->next_expiry)) {
 		if (!IS_ENABLED(CONFIG_NO_HZ_COMMON))
 			return;
 		/* CPU is awake, so check the deferrable base. */
 		base++;
-		if (time_before(jiffies, base->clk))
+		if (time_before(jiffies, base->next_expiry))
 			return;
 	}
 	raise_softirq(TIMER_SOFTIRQ);
