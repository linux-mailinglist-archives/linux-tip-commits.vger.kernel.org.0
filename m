Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9677DEAF9C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2019 12:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfJaL5b (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 31 Oct 2019 07:57:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55347 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfJaLzM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:12 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92j-00031J-M0; Thu, 31 Oct 2019 12:55:09 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DCE651C04D7;
        Thu, 31 Oct 2019 12:55:03 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:03 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Make kernel-mode nohz_full CPUs invoke the RCU
 core processing
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252290360.29376.4793978038734953610.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     dd7dafd1ad50aa9ed7958235431f243ea131ee7d
Gitweb:        https://git.kernel.org/tip/dd7dafd1ad50aa9ed7958235431f243ea131ee7d
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sat, 14 Sep 2019 03:39:22 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 28 Oct 2019 07:02:21 -07:00

rcu: Make kernel-mode nohz_full CPUs invoke the RCU core processing

If a nohz_full CPU is idle or executing in userspace, it makes good sense
to keep it out of RCU core processing.  After all, the RCU grace-period
kthread can see its quiescent states and all of its callbacks are
offloaded, so there is nothing for RCU core processing to do.

However, if a nohz_full CPU is executing in kernel space, the RCU
grace-period kthread cannot do anything for it, so such a CPU must report
its own quiescent states.  This commit therefore makes nohz_full CPUs
skip RCU core processing only if the scheduler-clock interrupt caught
them in idle or in userspace.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0c8046b..4e6ae26 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -497,7 +497,7 @@ module_param_cb(jiffies_till_next_fqs, &next_fqs_jiffies_ops, &jiffies_till_next
 module_param(rcu_kick_kthreads, bool, 0644);
 
 static void force_qs_rnp(int (*f)(struct rcu_data *rdp));
-static int rcu_pending(void);
+static int rcu_pending(int user);
 
 /*
  * Return the number of RCU GPs completed thus far for debug & stats.
@@ -2267,7 +2267,7 @@ void rcu_sched_clock_irq(int user)
 		__this_cpu_write(rcu_data.rcu_urgent_qs, false);
 	}
 	rcu_flavor_sched_clock_irq(user);
-	if (rcu_pending())
+	if (rcu_pending(user))
 		invoke_rcu_core();
 
 	trace_rcu_utilization(TPS("End scheduler-tick"));
@@ -2816,7 +2816,7 @@ EXPORT_SYMBOL_GPL(cond_synchronize_rcu);
  * CPU-local state are performed first.  However, we must check for CPU
  * stalls first, else we might not get a chance.
  */
-static int rcu_pending(void)
+static int rcu_pending(int user)
 {
 	bool gp_in_progress;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
@@ -2829,8 +2829,8 @@ static int rcu_pending(void)
 	if (rcu_nocb_need_deferred_wakeup(rdp))
 		return 1;
 
-	/* Is this CPU a NO_HZ_FULL CPU that should ignore RCU? */
-	if (rcu_nohz_full_cpu())
+	/* Is this a nohz_full CPU in userspace or idle?  (Ignore RCU if so.) */
+	if ((user || rcu_is_cpu_rrupt_from_idle()) && rcu_nohz_full_cpu())
 		return 0;
 
 	/* Is the RCU core waiting for a quiescent state from this CPU? */
