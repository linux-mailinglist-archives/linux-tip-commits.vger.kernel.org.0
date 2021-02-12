Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73612319EC0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhBLMko (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45412 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhBLMjL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:39:11 -0500
Date:   Fri, 12 Feb 2021 12:37:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133438;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=D6WqZa1YrBg4rotU6uSdIKiy08o8l26odNGYBi/eCyE=;
        b=DM4868KL9B/xX/Qn52DC4kQ1KLtRzTUXEB8Qrv0Kjba1FVJYoyK+CXtJIch5d9YQ9ElzeR
        9KJ2XaYXXKXKVBh8xDo9hjaoIpCbxlbj4tqnZKevk2ImOxLKv34jzETH4iLoT/40N76Uch
        Q+7Ul1FrrndSGewOMFfAHAq/BKBincD+9p62a6Y18XbqPC+0wVUgs7Sj7HEB5ZcCCYgphO
        MSjty82i7JzFuM4S5qXB/jNthTEar78IFZR9NBuk0MpCfKa1RX3IefG9DtOfktmqtcG5PT
        ALHTecV8Z3dTj3sJeVfYtOFI6KF9VtbUKKymy3UgDNiLN0HCJ/ONQ/Wx4JwjEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133438;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=D6WqZa1YrBg4rotU6uSdIKiy08o8l26odNGYBi/eCyE=;
        b=O4j8GvGl8NuEOJg9bAtQek4JsyiBCkbOuxnnn9aNUug+fCknmUi438zdl6K0i6JyXKJCuq
        AsYcHsBvyxEGbTBg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Locally accelerate callbacks as long as
 offloading isn't complete
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343782.23325.4571743279608209356.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     634954c2dbf88e67aa267798f60af6b9a476cf4b
Gitweb:        https://git.kernel.org/tip/634954c2dbf88e67aa267798f60af6b9a476cf4b
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 13:13:28 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:24:59 -08:00

rcu/nocb: Locally accelerate callbacks as long as offloading isn't complete

The local callbacks processing checks if any callbacks need acceleration.
This commit carries out this checking under nocb lock protection in
the middle of toggle operations, during which time rcu_core() executes
concurrently with GP/CB kthreads.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ec14c01..03810a5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2699,7 +2699,6 @@ static __latent_entropy void rcu_core(void)
 	unsigned long flags;
 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
-	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 	const bool do_batch = !rcu_segcblist_completely_offloaded(&rdp->cblist);
 
 	if (cpu_is_offline(smp_processor_id()))
@@ -2720,11 +2719,11 @@ static __latent_entropy void rcu_core(void)
 
 	/* No grace period and unregistered callbacks? */
 	if (!rcu_gp_in_progress() &&
-	    rcu_segcblist_is_enabled(&rdp->cblist) && !offloaded) {
-		local_irq_save(flags);
+	    rcu_segcblist_is_enabled(&rdp->cblist) && do_batch) {
+		rcu_nocb_lock_irqsave(rdp, flags);
 		if (!rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
 			rcu_accelerate_cbs_unlocked(rnp, rdp);
-		local_irq_restore(flags);
+		rcu_nocb_unlock_irqrestore(rdp, flags);
 	}
 
 	rcu_check_gp_start_stall(rnp, rdp, rcu_jiffies_till_stall_check());
