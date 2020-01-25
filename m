Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB2A1494B3
	for <lists+linux-tip-commits@lfdr.de>; Sat, 25 Jan 2020 11:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgAYKnU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 25 Jan 2020 05:43:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44335 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729770AbgAYKnT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:19 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIuK-0000F9-TO; Sat, 25 Jan 2020 11:43:17 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1D8531C1A91;
        Sat, 25 Jan 2020 11:42:57 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:56 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Replace synchronize_sched_expedited_wait()
 "_sched" with "_rcu"
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897692.396.12339171851773290121.tip-bot2@tip-bot2>
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

Commit-ID:     28f0361fdfab267a392cd6a6401446c9ea64de95
Gitweb:        https://git.kernel.org/tip/28f0361fdfab267a392cd6a6401446c9ea64de95
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 27 Nov 2019 14:24:58 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 12:24:59 -08:00

rcu: Replace synchronize_sched_expedited_wait() "_sched" with "_rcu"

After RCU flavor consolidation, synchronize_sched_expedited_wait() does
both RCU-preempt and RCU-sched, whichever happens to have been built into
the running kernel.  This commit therefore changes this function's name
to synchronize_rcu_expedited_wait() to reflect its new generic nature.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_exp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 1eafbcd..081a179 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -453,7 +453,7 @@ static void sync_rcu_exp_select_cpus(void)
  * Wait for the expedited grace period to elapse, issuing any needed
  * RCU CPU stall warnings along the way.
  */
-static void synchronize_sched_expedited_wait(void)
+static void synchronize_rcu_expedited_wait(void)
 {
 	int cpu;
 	unsigned long jiffies_stall;
@@ -538,7 +538,7 @@ static void rcu_exp_wait_wake(unsigned long s)
 {
 	struct rcu_node *rnp;
 
-	synchronize_sched_expedited_wait();
+	synchronize_rcu_expedited_wait();
 
 	// Switch over to wakeup mode, allowing the next GP to proceed.
 	// End the previous grace period only after acquiring the mutex
