Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AAA2882AA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbgJIGik (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:38:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55462 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731878AbgJIGfU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:20 -0400
Date:   Fri, 09 Oct 2020 06:35:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225318;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5KA0UooDy/+gvvsOaq7ckmhKn6GkXbAaooytQ63P7Qo=;
        b=K1546b/Juk5OD46Tr8zS2de/4WbljtfMrdPcN8jdKadgfBAaEVczhej700ucjJdrpi1J6+
        NMVCk+iPm5QMsFanuWWnu4qawETGsRMe1M9iRBhjzYKvETuCjMvVsWN+rI7ZnqOfi4BcET
        W4hyo3WCYvDe9U5dnZCo03WNqIQdGBFZfUbsHPx3FdXx/StTs3xuk1oHm72iqe3Rjf2MBY
        /YSPXr5ZSowjgYtA3cC/PKpdN0UrpUhTUnfQds5cNhAKXF7bhT5kK5eIApiweD4cQP4NfX
        21EvCk96UQXEQGQ+A8z9+jQBfR+sK9lTyfObwckMIWXh6PrCtoQiqFm00RVjqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225318;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5KA0UooDy/+gvvsOaq7ckmhKn6GkXbAaooytQ63P7Qo=;
        b=ZvxUu7JYGP/7ubxhks/uofLN/GxeXq7khpy7Od2aFI27YgkIQrXkhog4cvwlzL9z6dK+HO
        OY0O4l7uDgOolPDw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Report QS for outermost PREEMPT=n
 rcu_read_unlock() for strict GPs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222531793.7002.11219771137156529159.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     aa40c138cc8f36e2f5c721fd1bdb823a1ef1a237
Gitweb:        https://git.kernel.org/tip/aa40c138cc8f36e2f5c721fd1bdb823a1ef1a237
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 10 Aug 2020 09:58:03 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:40:28 -07:00

rcu: Report QS for outermost PREEMPT=n rcu_read_unlock() for strict GPs

The CONFIG_PREEMPT=n instance of rcu_read_unlock is even more
aggressively than that of CONFIG_PREEMPT=y in deferring reporting
quiescent states to the RCU core.  This is just what is wanted in normal
use because it reduces overhead, but the resulting delay is not what
is wanted for kernels built with CONFIG_RCU_STRICT_GRACE_PERIOD=y.
This commit therefore adds an rcu_read_unlock_strict() function that
checks for exceptional conditions, and reports the newly started
quiescent state if it is safe to do so, also doing a spin-delay if
requested via rcutree.rcu_unlock_delay.  This commit also adds a call
to rcu_read_unlock_strict() from the CONFIG_PREEMPT=n instance of
__rcu_read_unlock().

[ paulmck: Fixed bug located by kernel test robot <lkp@intel.com> ]
Reported-by Jann Horn <jannh@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h |  7 +++++++
 kernel/rcu/tree.c        |  6 ++++++
 kernel/rcu/tree_plugin.h | 24 ++++++++++++++++++------
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index d15d46d..522529a 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -55,6 +55,12 @@ void __rcu_read_unlock(void);
 
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
+#ifdef CONFIG_TINY_RCU
+#define rcu_read_unlock_strict() do { } while (0)
+#else
+void rcu_read_unlock_strict(void);
+#endif
+
 static inline void __rcu_read_lock(void)
 {
 	preempt_disable();
@@ -63,6 +69,7 @@ static inline void __rcu_read_lock(void)
 static inline void __rcu_read_unlock(void)
 {
 	preempt_enable();
+	rcu_read_unlock_strict();
 }
 
 static inline int rcu_preempt_depth(void)
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 31995b3..a295cad 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -178,6 +178,12 @@ module_param(gp_init_delay, int, 0444);
 static int gp_cleanup_delay;
 module_param(gp_cleanup_delay, int, 0444);
 
+// Add delay to rcu_read_unlock() for strict grace periods.
+static int rcu_unlock_delay;
+#ifdef CONFIG_RCU_STRICT_GRACE_PERIOD
+module_param(rcu_unlock_delay, int, 0444);
+#endif
+
 /*
  * This rcu parameter is runtime-read-only. It reflects
  * a minimum allowed number of objects which can be cached
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3f3a4ff..25a676d 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -430,12 +430,6 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp)
 	return !list_empty(&rnp->blkd_tasks);
 }
 
-// Add delay to rcu_read_unlock() for strict grace periods.
-static int rcu_unlock_delay;
-#ifdef CONFIG_RCU_STRICT_GRACE_PERIOD
-module_param(rcu_unlock_delay, int, 0444);
-#endif
-
 /*
  * Report deferred quiescent states.  The deferral time can
  * be quite short, for example, in the case of the call from
@@ -785,6 +779,24 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
 /*
+ * If strict grace periods are enabled, and if the calling
+ * __rcu_read_unlock() marks the beginning of a quiescent state, immediately
+ * report that quiescent state and, if requested, spin for a bit.
+ */
+void rcu_read_unlock_strict(void)
+{
+	struct rcu_data *rdp;
+
+	if (!IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ||
+	   irqs_disabled() || preempt_count() || !rcu_state.gp_kthread)
+		return;
+	rdp = this_cpu_ptr(&rcu_data);
+	rcu_report_qs_rdp(rdp->cpu, rdp);
+	udelay(rcu_unlock_delay);
+}
+EXPORT_SYMBOL_GPL(rcu_read_unlock_strict);
+
+/*
  * Tell them what RCU they are running.
  */
 static void __init rcu_bootup_announce(void)
