Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C4035B4DB
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbhDKNoK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235576AbhDKNn7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:43:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8505C06138B;
        Sun, 11 Apr 2021 06:43:26 -0700 (PDT)
Date:   Sun, 11 Apr 2021 13:43:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yigEcoP8LKiECUj8iCX0Yj65eSTZhxVV4iUT5SeEqBQ=;
        b=lD6XgAoYIBOAfPt94vO4WXVc+m6edk7Ikym6CcrTkr/yz806Me4LmqZYPZwWY371jR/19M
        zWjFdtaycv58bFKFLZQw8zuj43oSIGms618ELGG8FX0eHh24ukStt2pgh1Rl1gKSHMguSW
        Ex94mPd4R8JIy8XL3b4fwhBmvzfIm6Nk4coUybYmBLSN/zOwd7Of+WIRZ8BPgU8ojDoBfn
        IOLNXMlQXog3wZz10s2W/CHeopSLOEc/lUTm9lEBB5sfd8rwLDuDbcZKcAhLEDAPi8hcwp
        OIz+dx2DHZmKjpYhV4wslUFcF+gVnOUDNRLliXxUhmrPKXTHUimJfItgsSeH8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yigEcoP8LKiECUj8iCX0Yj65eSTZhxVV4iUT5SeEqBQ=;
        b=WcUA8XLfYbvG4GoCZFFeYPv8INiW1ULNKgsBzfuKdzT54GcVpTlOoDc9o2iocrzX1GwQKV
        pxmFD1oXzRc6PuDg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Provide polling interfaces for Tiny RCU grace periods
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814859843.29796.8740406362665343747.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     0909fc2b2c41aae50a18a36ac2858d156f521871
Gitweb:        https://git.kernel.org/tip/0909fc2b2c41aae50a18a36ac2858d156f521871
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 25 Feb 2021 17:36:06 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 24 Mar 2021 17:16:15 -07:00

rcu: Provide polling interfaces for Tiny RCU grace periods

There is a need for a non-blocking polling interface for RCU grace
periods, so this commit supplies start_poll_synchronize_rcu() and
poll_state_synchronize_rcu() for this purpose.  Note that the existing
get_state_synchronize_rcu() may be used if future grace periods are
inevitable (perhaps due to a later call_rcu() invocation).  The new
start_poll_synchronize_rcu() is to be used if future grace periods
might not otherwise happen.  Finally, poll_state_synchronize_rcu()
provides a lockless check for a grace period having elapsed since
the corresponding call to either of the get_state_synchronize_rcu()
or start_poll_synchronize_rcu().

As with get_state_synchronize_rcu(), the return value from either
get_state_synchronize_rcu() or start_poll_synchronize_rcu() is passed in
to a later call to either poll_state_synchronize_rcu() or the existing
(might_sleep) cond_synchronize_rcu().

[ paulmck: Revert cond_synchronize_rcu() to might_sleep() per Frederic Weisbecker feedback. ]
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutiny.h |  7 +++----
 kernel/rcu/tiny.c       | 40 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 2a97334..35e0be3 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -17,10 +17,9 @@
 /* Never flag non-existent other CPUs! */
 static inline bool rcu_eqs_special_set(int cpu) { return false; }
 
-static inline unsigned long get_state_synchronize_rcu(void)
-{
-	return 0;
-}
+unsigned long get_state_synchronize_rcu(void);
+unsigned long start_poll_synchronize_rcu(void);
+bool poll_state_synchronize_rcu(unsigned long oldstate);
 
 static inline void cond_synchronize_rcu(unsigned long oldstate)
 {
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index aa897c3..c8a029f 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -32,12 +32,14 @@ struct rcu_ctrlblk {
 	struct rcu_head *rcucblist;	/* List of pending callbacks (CBs). */
 	struct rcu_head **donetail;	/* ->next pointer of last "done" CB. */
 	struct rcu_head **curtail;	/* ->next pointer of last CB. */
+	unsigned long gp_seq;		/* Grace-period counter. */
 };
 
 /* Definition for rcupdate control block. */
 static struct rcu_ctrlblk rcu_ctrlblk = {
 	.donetail	= &rcu_ctrlblk.rcucblist,
 	.curtail	= &rcu_ctrlblk.rcucblist,
+	.gp_seq		= 0 - 300UL,
 };
 
 void rcu_barrier(void)
@@ -56,6 +58,7 @@ void rcu_qs(void)
 		rcu_ctrlblk.donetail = rcu_ctrlblk.curtail;
 		raise_softirq_irqoff(RCU_SOFTIRQ);
 	}
+	WRITE_ONCE(rcu_ctrlblk.gp_seq, rcu_ctrlblk.gp_seq + 1);
 	local_irq_restore(flags);
 }
 
@@ -177,6 +180,43 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
+/*
+ * Return a grace-period-counter "cookie".  For more information,
+ * see the Tree RCU header comment.
+ */
+unsigned long get_state_synchronize_rcu(void)
+{
+	return READ_ONCE(rcu_ctrlblk.gp_seq);
+}
+EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
+
+/*
+ * Return a grace-period-counter "cookie" and ensure that a future grace
+ * period completes.  For more information, see the Tree RCU header comment.
+ */
+unsigned long start_poll_synchronize_rcu(void)
+{
+	unsigned long gp_seq = get_state_synchronize_rcu();
+
+	if (unlikely(is_idle_task(current))) {
+		/* force scheduling for rcu_qs() */
+		resched_cpu(0);
+	}
+	return gp_seq;
+}
+EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu);
+
+/*
+ * Return true if the grace period corresponding to oldstate has completed
+ * and false otherwise.  For more information, see the Tree RCU header
+ * comment.
+ */
+bool poll_state_synchronize_rcu(unsigned long oldstate)
+{
+	return READ_ONCE(rcu_ctrlblk.gp_seq) != oldstate;
+}
+EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
+
 void __init rcu_init(void)
 {
 	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
