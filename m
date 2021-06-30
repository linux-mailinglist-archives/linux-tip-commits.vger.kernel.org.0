Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71483B8395
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbhF3NuK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32888 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbhF3Nt6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:49:58 -0400
Date:   Wed, 30 Jun 2021 13:47:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Gwl1nS5ELPQ6Zm5tJu+bbMYSG4+yTgS0hXWI+l6qPGo=;
        b=hlxD7r76JQpjC7dQuwr1SIGxsj9fHBUVCdVEluKTaVRAwmDiOD2oRHcCeQTeKR+PWoHX8g
        /LIWdmAocaqcRefvsWvvjK/Dch5OL90WMf8OoMqqKQ8CUBuyevVVEN/XOnpE3WKvCtm2at
        Wg5d0uy66rWtxOF6vXzZVpvl/7J6+i5+f9FltFbkC0VaYyy5YWlR9zIKj2NyD8bNxmjORa
        eRbRam43u7mwXm4Zshy61CSGcckffA7i4k+rGlzzhKThJzJNITgRvAXXy4tkYVQGpeI+en
        v+QDRZOUb3a8xbngY6uGQBJPPlHshTVRAEQUC3zuB4I7jiM7jBJex6bYecK8nQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Gwl1nS5ELPQ6Zm5tJu+bbMYSG4+yTgS0hXWI+l6qPGo=;
        b=+kP09XbJXyDdgbpQgA1CpdnNR/siZmwIymUpgEg4Zvye5VPek/FJmRE6CuddW7iX0aZFda
        ccYMPidYnbfRz0Aw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Prepare for fine-grained deferred wakeup
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506084792.395.6718757539754692416.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     870905169da8bfae0570df013efe860d33251b0f
Gitweb:        https://git.kernel.org/tip/870905169da8bfae0570df013efe860d33251b0f
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 23 Feb 2021 01:10:10 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 12 May 2021 12:10:23 -07:00

rcu/nocb: Prepare for fine-grained deferred wakeup

Tuning the deferred wakeup level must be done from a safe wakeup
point. Currently those sites are:

* ->nocb_timer
* user/idle/guest entry
* CPU down
* softirq/rcuc

All of these sites perform the wake up for both RCU_NOCB_WAKE and
RCU_NOCB_WAKE_FORCE.

In order to merge ->nocb_timer and ->nocb_bypass_timer together, we plan
to add a new RCU_NOCB_WAKE_BYPASS that really should be deferred until
a timer fires so that we don't wake up the NOCB-gp kthread too early.

To prepare for that, this commit specifies the per-callsite wakeup
level/limit.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
[ paulmck: Fix non-NOCB rcu_nocb_need_deferred_wakeup() definition. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c        |  2 +-
 kernel/rcu/tree.h        |  2 +-
 kernel/rcu/tree_plugin.h | 17 +++++++++--------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8e78b24..5f1545a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3911,7 +3911,7 @@ static int rcu_pending(int user)
 	check_cpu_stall(rdp);
 
 	/* Does this CPU need a deferred NOCB wakeup? */
-	if (rcu_nocb_need_deferred_wakeup(rdp))
+	if (rcu_nocb_need_deferred_wakeup(rdp, RCU_NOCB_WAKE))
 		return 1;
 
 	/* Is this a nohz_full CPU in userspace or idle?  (Ignore RCU if so.) */
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index b280a84..2510e86 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -433,7 +433,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				bool *was_alldone, unsigned long flags);
 static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
 				 unsigned long flags);
-static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp);
+static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level);
 static bool do_nocb_deferred_wakeup(struct rcu_data *rdp);
 static void rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp);
 static void rcu_spawn_cpu_nocb_kthread(int cpu);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index db28e31..e2e5e49 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2352,13 +2352,14 @@ static int rcu_nocb_cb_kthread(void *arg)
 }
 
 /* Is a deferred wakeup of rcu_nocb_kthread() required? */
-static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp)
+static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level)
 {
-	return READ_ONCE(rdp->nocb_defer_wakeup) > RCU_NOCB_WAKE_NOT;
+	return READ_ONCE(rdp->nocb_defer_wakeup) >= level;
 }
 
 /* Do a deferred wakeup of rcu_nocb_kthread(). */
-static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp)
+static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp,
+					   int level)
 {
 	unsigned long flags;
 	int ndw;
@@ -2367,7 +2368,7 @@ static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp)
 
 	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
 
-	if (!rcu_nocb_need_deferred_wakeup(rdp_gp)) {
+	if (!rcu_nocb_need_deferred_wakeup(rdp_gp, level)) {
 		raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
 		return false;
 	}
@@ -2384,7 +2385,7 @@ static void do_nocb_deferred_wakeup_timer(struct timer_list *t)
 {
 	struct rcu_data *rdp = from_timer(rdp, t, nocb_timer);
 
-	do_nocb_deferred_wakeup_common(rdp);
+	do_nocb_deferred_wakeup_common(rdp, RCU_NOCB_WAKE);
 }
 
 /*
@@ -2397,8 +2398,8 @@ static bool do_nocb_deferred_wakeup(struct rcu_data *rdp)
 	if (!rdp->nocb_gp_rdp)
 		return false;
 
-	if (rcu_nocb_need_deferred_wakeup(rdp->nocb_gp_rdp))
-		return do_nocb_deferred_wakeup_common(rdp);
+	if (rcu_nocb_need_deferred_wakeup(rdp->nocb_gp_rdp, RCU_NOCB_WAKE))
+		return do_nocb_deferred_wakeup_common(rdp, RCU_NOCB_WAKE);
 	return false;
 }
 
@@ -2939,7 +2940,7 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
 {
 }
 
-static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp)
+static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level)
 {
 	return false;
 }
