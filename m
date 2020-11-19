Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF472B8F92
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Nov 2020 11:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgKSJzN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Nov 2020 04:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgKSJzL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Nov 2020 04:55:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F066C0613CF;
        Thu, 19 Nov 2020 01:55:11 -0800 (PST)
Date:   Thu, 19 Nov 2020 09:55:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605779709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mnfnEoObBNwj0Vfa3mqFfm04xsXOCIO2TyKCi3Bjj4Y=;
        b=Sz7tO4wYFtjhHIirzG2+P27jvFGpwx3Y/AR3FJ5iQv8FKC/ZOpMr5nLQFv0pPHm770kFtv
        vIgVpyPEtP1dQHRq7757sRqcib3BviTP2b6tbuojgVqZsoJR3lxesLFi/DuJ+EZDIOSvdJ
        uTq6edBJtgm+7TlS7AVdgZu5jnkUNAaj1k2GxrtXdA0TkbeiScHDSNxYyxeGj4MiRH9NpJ
        8FPmE4zY7iKAfmIA+0+ZSXo/H0EUkNFVmR2pFuql19EtBPqBaNllf1WUz2tcDqpZcxpo4P
        aTNHemJEInz9cU1PO0rPoul9UjM7Yo18pgnVKCBNlAbioTZTLJfGQqYAKJuCKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605779709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mnfnEoObBNwj0Vfa3mqFfm04xsXOCIO2TyKCi3Bjj4Y=;
        b=y7eg8h0BmLjLiTDLS85/SLd64+5452H46pzz9IGBn2XspPK0P0MDjCgz0pOyCXsDlYDAI6
        EBouWNSWYbPMNlDg==
From:   "tip-bot2 for Yunfeng Ye" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/sched: Reduce seqcount held scope in
 tick_do_update_jiffies64()
Cc:     Yunfeng Ye <yeyunfeng@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201117132006.462195901@linutronix.de>
References: <20201117132006.462195901@linutronix.de>
MIME-Version: 1.0
Message-ID: <160577970904.11244.12827097156608647798.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     94ad2e3cedb82af034f6d97c58022f162b669f9b
Gitweb:        https://git.kernel.org/tip/94ad2e3cedb82af034f6d97c58022f162b669f9b
Author:        Yunfeng Ye <yeyunfeng@huawei.com>
AuthorDate:    Tue, 17 Nov 2020 14:19:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 19 Nov 2020 10:48:29 +01:00

tick/sched: Reduce seqcount held scope in tick_do_update_jiffies64()

If jiffies are up to date already (caller lost the race against another
CPU) there is no point to change the sequence count. Doing that just forces
other CPUs into the seqcount retry loop in tick_nohz_next_event() for
nothing.

Just bail out early.

[ tglx: Rewrote most of it ]

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201117132006.462195901@linutronix.de

---
 kernel/time/tick-sched.c | 47 ++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b4b6abc..ca9191c 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -86,38 +86,35 @@ static void tick_do_update_jiffies64(ktime_t now)
 
 	/* Reevaluate with jiffies_lock held */
 	raw_spin_lock(&jiffies_lock);
+	if (ktime_before(now, tick_next_period)) {
+		raw_spin_unlock(&jiffies_lock);
+		return;
+	}
+
 	write_seqcount_begin(&jiffies_seq);
 
-	delta = ktime_sub(now, last_jiffies_update);
-	if (delta >= tick_period) {
+	last_jiffies_update = ktime_add(last_jiffies_update, tick_period);
 
-		delta = ktime_sub(delta, tick_period);
-		last_jiffies_update = ktime_add(last_jiffies_update,
-						tick_period);
+	delta = ktime_sub(now, tick_next_period);
+	if (unlikely(delta >= tick_period)) {
+		/* Slow path for long idle sleep times */
+		s64 incr = ktime_to_ns(tick_period);
 
-		/* Slow path for long timeouts */
-		if (unlikely(delta >= tick_period)) {
-			s64 incr = ktime_to_ns(tick_period);
+		ticks = ktime_divns(delta, incr);
 
-			ticks = ktime_divns(delta, incr);
+		last_jiffies_update = ktime_add_ns(last_jiffies_update,
+						   incr * ticks);
+	}
 
-			last_jiffies_update = ktime_add_ns(last_jiffies_update,
-							   incr * ticks);
-		}
-		do_timer(++ticks);
+	do_timer(++ticks);
+
+	/*
+	 * Keep the tick_next_period variable up to date.  WRITE_ONCE()
+	 * pairs with the READ_ONCE() in the lockless quick check above.
+	 */
+	WRITE_ONCE(tick_next_period,
+		   ktime_add(last_jiffies_update, tick_period));
 
-		/*
-		 * Keep the tick_next_period variable up to date.
-		 * WRITE_ONCE() pairs with the READ_ONCE() in the lockless
-		 * quick check above.
-		 */
-		WRITE_ONCE(tick_next_period,
-			   ktime_add(last_jiffies_update, tick_period));
-	} else {
-		write_seqcount_end(&jiffies_seq);
-		raw_spin_unlock(&jiffies_lock);
-		return;
-	}
 	write_seqcount_end(&jiffies_seq);
 	raw_spin_unlock(&jiffies_lock);
 	update_wall_time();
