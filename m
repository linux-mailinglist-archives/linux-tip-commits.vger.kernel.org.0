Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC9340D92A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Sep 2021 13:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238580AbhIPMAp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 16 Sep 2021 08:00:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47486 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238558AbhIPMAn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 16 Sep 2021 08:00:43 -0400
Date:   Thu, 16 Sep 2021 11:59:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631793559;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=itYHqY3gHZkcYz6Iqxhy5QlbwoSsT+monGa4y5nc82A=;
        b=fjPdSVBjGWUmOIuZN0HP1Ie2mJh9GswnOGSzk0TH+gMJ3+IVb0Zl6Y+5zRZgx6Bo0fiQiL
        5mySVs/lbh/KdjRjFis0SwAB6q2k2C5aq660PbbusCJZh7cgD2wFgIl9zAe6IMf5BZ7yJr
        DIOxiSZF55FUJ7m9Khpj4nh6fi4YPoW3eq8yFZm7UNYVaJc3HYtoRYOlPYwZcYlCdfhvDk
        Nx+z1DNRMUDSn7gJgjI1HEyVJWbvcW/QxdK8ez3+8kqub/MWeX9Q5iuClOuKuOXyPyxjIr
        1mf/fAm2s4wNIwiVAFJc7+JMJinht46iHOc9t5n/4RfpOEzLPShBaeSrKb+QRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631793559;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=itYHqY3gHZkcYz6Iqxhy5QlbwoSsT+monGa4y5nc82A=;
        b=0kQ2Di4aR3ZL53dyGbFCLE+9bQf2Tt4yR2FCTj1OXlzwN6r3nxPjWEHA9pKvWxxUbyoVXc
        xFqRdp6J4LUuBNAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/rwbase: Extract __rwbase_write_trylock()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YUCq3L+u44NDieEJ@hirez.programming.kicks-ass.net>
References: <YUCq3L+u44NDieEJ@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <163179355883.25758.5450895206052550685.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     616be87eac9fa2ab2dca1069712f7236e50f3bf6
Gitweb:        https://git.kernel.org/tip/616be87eac9fa2ab2dca1069712f7236e50f3bf6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 09 Sep 2021 12:59:18 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 17:49:15 +02:00

locking/rwbase: Extract __rwbase_write_trylock()

The code in rwbase_write_lock() is a little non-obvious vs the
read+set 'trylock', extract the sequence into a helper function to
clarify the code.

This also provides a single site to fix fast-path ordering.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/YUCq3L+u44NDieEJ@hirez.programming.kicks-ass.net
---
 kernel/locking/rwbase_rt.c | 44 +++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 542b017..48fbbcc 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -196,6 +196,19 @@ static inline void rwbase_write_downgrade(struct rwbase_rt *rwb)
 	__rwbase_write_unlock(rwb, WRITER_BIAS - 1, flags);
 }
 
+static inline bool __rwbase_write_trylock(struct rwbase_rt *rwb)
+{
+	/* Can do without CAS because we're serialized by wait_lock. */
+	lockdep_assert_held(&rwb->rtmutex.wait_lock);
+
+	if (!atomic_read(&rwb->readers)) {
+		atomic_set(&rwb->readers, WRITER_BIAS);
+		return 1;
+	}
+
+	return 0;
+}
+
 static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 				     unsigned int state)
 {
@@ -210,34 +223,30 @@ static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 	atomic_sub(READER_BIAS, &rwb->readers);
 
 	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
-	/*
-	 * set_current_state() for rw_semaphore
-	 * current_save_and_set_rtlock_wait_state() for rwlock
-	 */
-	rwbase_set_and_save_current_state(state);
+	if (__rwbase_write_trylock(rwb))
+		goto out_unlock;
 
-	/* Block until all readers have left the critical section. */
-	for (; atomic_read(&rwb->readers);) {
+	rwbase_set_and_save_current_state(state);
+	for (;;) {
 		/* Optimized out for rwlocks */
 		if (rwbase_signal_pending_state(state, current)) {
 			rwbase_restore_current_state();
 			__rwbase_write_unlock(rwb, 0, flags);
 			return -EINTR;
 		}
+
+		if (__rwbase_write_trylock(rwb))
+			break;
+
 		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
+		rwbase_schedule();
+		raw_spin_lock_irqsave(&rtm->wait_lock, flags);
 
-		/*
-		 * Schedule and wait for the readers to leave the critical
-		 * section. The last reader leaving it wakes the waiter.
-		 */
-		if (atomic_read(&rwb->readers) != 0)
-			rwbase_schedule();
 		set_current_state(state);
-		raw_spin_lock_irqsave(&rtm->wait_lock, flags);
 	}
-
-	atomic_set(&rwb->readers, WRITER_BIAS);
 	rwbase_restore_current_state();
+
+out_unlock:
 	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
 	return 0;
 }
@@ -253,8 +262,7 @@ static inline int rwbase_write_trylock(struct rwbase_rt *rwb)
 	atomic_sub(READER_BIAS, &rwb->readers);
 
 	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
-	if (!atomic_read(&rwb->readers)) {
-		atomic_set(&rwb->readers, WRITER_BIAS);
+	if (__rwbase_write_trylock(rwb)) {
 		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
 		return 1;
 	}
