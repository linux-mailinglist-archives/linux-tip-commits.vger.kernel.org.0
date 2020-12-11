Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259A92D81EC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Dec 2020 23:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391436AbgLKWXq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 11 Dec 2020 17:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391236AbgLKWX3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 11 Dec 2020 17:23:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3A4C0613CF;
        Fri, 11 Dec 2020 14:22:49 -0800 (PST)
Date:   Fri, 11 Dec 2020 22:22:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607725366;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NGZrdxckk0CcnTGimSJiWXfqdPSodDoQdFA1WLG1ac0=;
        b=CmtGy4XkB1+Y4W7El/ccpze72z3xjrnjk488km8HKT1Jh9vQjI5xFTg6FAY28pPAFtsfp2
        OFFeLzBIsh+NeLK/c5V5e8TTtlW2bBg6PdfqCqlO+zlXEhHI7aUSn7Q/bS4+YZSDJPg73f
        9WF9EaNep9Jo3B3BIBM4uCI8XdWvAYdgU+SHFjam78gCUPucRpTZeTEdCXkyCJ7lxB9Tad
        77au6PTGbap/itoBo34h4OZTeBj43uWc+j4Tom42wPqINwbH4j10DjW0HHbVQh1uyRzyh3
        TE7YkEoXPjgMABp3ogVWowIuLCbtUVHBsRNUwW11TLPR3y2O+yzh+f6Y8H6obQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607725366;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NGZrdxckk0CcnTGimSJiWXfqdPSodDoQdFA1WLG1ac0=;
        b=OVAlVI5VY7+pZPoxPNHK6fCibvb1s9DkBMi6cC3/qedslKxzeEYV6nJwqf5+/Y3k7vw6jO
        H76/vVd7jG6zPcAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/sched: Make jiffies update quick check more robust
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87czzpc02w.fsf@nanos.tec.linutronix.de>
References: <87czzpc02w.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <160772536603.3364.16160339487217714301.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     aa3b66f401b372598b29421bab4d17b631b92407
Gitweb:        https://git.kernel.org/tip/aa3b66f401b372598b29421bab4d17b631b92407
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 04 Dec 2020 11:55:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 11 Dec 2020 23:19:10 +01:00

tick/sched: Make jiffies update quick check more robust

The quick check in tick_do_update_jiffies64() whether jiffies need to be
updated is not really correct under all circumstances and on all
architectures, especially not on 32bit systems.

The quick check does:

    if (now < READ_ONCE(tick_next_period))
    	return;

and the counterpart in the update is:

    WRITE_ONCE(tick_next_period, next_update_time);

This has two problems:

  1) On weakly ordered architectures there is no guarantee that the stores
     before the WRITE_ONCE() are visible which means that other CPUs can
     operate on a stale jiffies value.

  2) On 32bit the store of tick_next_period which is an u64 is split into
     two 32bit stores. If the first 32bit store advances tick_next_period
     far out and the second 32bit store is delayed (virt, NMI ...) then
     jiffies will become stale until the second 32bit store happens.

Address this by seperating the handling for 32bit and 64bit.

On 64bit problem #1 is addressed by replacing READ_ONCE() / WRITE_ONCE()
with smp_load_acquire() / smp_store_release().

On 32bit problem #2 is addressed by protecting the quick check with the
jiffies sequence counter. The load and stores can be plain because the
sequence count mechanics provides the required barriers already.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/87czzpc02w.fsf@nanos.tec.linutronix.de

---
 kernel/time/tick-sched.c | 74 ++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 27 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index cc7cba2..a9e6893 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -57,36 +57,42 @@ static ktime_t last_jiffies_update;
 static void tick_do_update_jiffies64(ktime_t now)
 {
 	unsigned long ticks = 1;
-	ktime_t delta;
+	ktime_t delta, nextp;
 
 	/*
-	 * Do a quick check without holding jiffies_lock. The READ_ONCE()
+	 * 64bit can do a quick check without holding jiffies lock and
+	 * without looking at the sequence count. The smp_load_acquire()
 	 * pairs with the update done later in this function.
 	 *
-	 * This is also an intentional data race which is even safe on
-	 * 32bit in theory. If there is a concurrent update then the check
-	 * might give a random answer. It does not matter because if it
-	 * returns then the concurrent update is already taking care, if it
-	 * falls through then it will pointlessly contend on jiffies_lock.
-	 *
-	 * Though there is one nasty case on 32bit due to store tearing of
-	 * the 64bit value. If the first 32bit store makes the quick check
-	 * return on all other CPUs and the writing CPU context gets
-	 * delayed to complete the second store (scheduled out on virt)
-	 * then jiffies can become stale for up to ~2^32 nanoseconds
-	 * without noticing. After that point all CPUs will wait for
-	 * jiffies lock.
-	 *
-	 * OTOH, this is not any different than the situation with NOHZ=off
-	 * where one CPU is responsible for updating jiffies and
-	 * timekeeping. If that CPU goes out for lunch then all other CPUs
-	 * will operate on stale jiffies until it decides to come back.
+	 * 32bit cannot do that because the store of tick_next_period
+	 * consists of two 32bit stores and the first store could move it
+	 * to a random point in the future.
 	 */
-	if (ktime_before(now, READ_ONCE(tick_next_period)))
-		return;
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		if (ktime_before(now, smp_load_acquire(&tick_next_period)))
+			return;
+	} else {
+		unsigned int seq;
 
-	/* Reevaluate with jiffies_lock held */
+		/*
+		 * Avoid contention on jiffies_lock and protect the quick
+		 * check with the sequence count.
+		 */
+		do {
+			seq = read_seqcount_begin(&jiffies_seq);
+			nextp = tick_next_period;
+		} while (read_seqcount_retry(&jiffies_seq, seq));
+
+		if (ktime_before(now, nextp))
+			return;
+	}
+
+	/* Quick check failed, i.e. update is required. */
 	raw_spin_lock(&jiffies_lock);
+	/*
+	 * Reevaluate with the lock held. Another CPU might have done the
+	 * update already.
+	 */
 	if (ktime_before(now, tick_next_period)) {
 		raw_spin_unlock(&jiffies_lock);
 		return;
@@ -112,11 +118,25 @@ static void tick_do_update_jiffies64(ktime_t now)
 	jiffies_64 += ticks;
 
 	/*
-	 * Keep the tick_next_period variable up to date.  WRITE_ONCE()
-	 * pairs with the READ_ONCE() in the lockless quick check above.
+	 * Keep the tick_next_period variable up to date.
 	 */
-	WRITE_ONCE(tick_next_period,
-		   ktime_add_ns(last_jiffies_update, TICK_NSEC));
+	nextp = ktime_add_ns(last_jiffies_update, TICK_NSEC);
+
+	if (IS_ENABLED(CONFIG_64BIT)) {
+		/*
+		 * Pairs with smp_load_acquire() in the lockless quick
+		 * check above and ensures that the update to jiffies_64 is
+		 * not reordered vs. the store to tick_next_period, neither
+		 * by the compiler nor by the CPU.
+		 */
+		smp_store_release(&tick_next_period, nextp);
+	} else {
+		/*
+		 * A plain store is good enough on 32bit as the quick check
+		 * above is protected by the sequence count.
+		 */
+		tick_next_period = nextp;
+	}
 
 	/*
 	 * Release the sequence count. calc_global_load() below is not
