Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34117319EBA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhBLMkb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45360 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbhBLMjA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:39:00 -0500
Date:   Fri, 12 Feb 2021 12:37:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133436;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=FsTl+lU0+vVjmJvRqRUXy+56E78DZOTs6QlObUroft4=;
        b=viRJxUDYWQGJ6+jxYlfVWBtDXMXz+9w5xml0ERxBJEEhtegIsfxHJa9O422VskCvkG94sD
        OoHSSfohJnS45BrWuxZTXMHoZ4lo2oFCI20I2sjXckCX6Cf2b3AdNrKBrZ/A0Np1wgICye
        sezKllL+SgaPgU+lh0WMj90PcWxhR5au5jhWlSlrnVqH7uNN0TlZ+tde81hsXoOO+fJVFt
        Gex2zWKDMjaFJzjiSJon1st9Br8MjCCqYQx/ArOd9w98J14x5X2VeRorLivIaFLvsjPwnD
        GUacGy5njqSYSVdnltoxim53LJvggReYb7kvD6DWWfsnY7Syy6Z1DnzNBsoYPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133436;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=FsTl+lU0+vVjmJvRqRUXy+56E78DZOTs6QlObUroft4=;
        b=IKsiokPvvHXgo8xsQazdVkhtuIjzfrDex+SL7ST4S3xIOcrwK6KOJXOnz7vZ+d5URgktfc
        OHxrkjltO2YsDuCw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Add grace period and task state to
 show_rcu_nocb_state() output
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343636.23325.17974858967772685883.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     341690611f8d488859f42a761f5d7cbac6ba2940
Gitweb:        https://git.kernel.org/tip/341690611f8d488859f42a761f5d7cbac6ba2940
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 18 Dec 2020 10:20:34 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:25:00 -08:00

rcu/nocb: Add grace period and task state to show_rcu_nocb_state() output

This commit improves debuggability by indicating which grace period each
batch of nocb callbacks is waiting on and by showing the task state and
last CPU for reach nocb kthread.

[ paulmck: Handle !SMP CB offloading per kernel test robot feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.h | 11 ++++++++++-
 kernel/rcu/tree_plugin.h   | 39 ++++++++++++++++++++++++++++++-------
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index afad6fc..3110602 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -117,6 +117,17 @@ static inline bool rcu_segcblist_restempty(struct rcu_segcblist *rsclp, int seg)
 	return !READ_ONCE(*READ_ONCE(rsclp->tails[seg]));
 }
 
+/*
+ * Is the specified segment of the specified rcu_segcblist structure
+ * empty of callbacks?
+ */
+static inline bool rcu_segcblist_segempty(struct rcu_segcblist *rsclp, int seg)
+{
+	if (seg == RCU_DONE_TAIL)
+		return &rsclp->head == rsclp->tails[RCU_DONE_TAIL];
+	return rsclp->tails[seg - 1] == rsclp->tails[seg];
+}
+
 void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp);
 void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v);
 void rcu_segcblist_init(struct rcu_segcblist *rsclp);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 8641b72..5ee1113 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2672,6 +2672,19 @@ void rcu_bind_current_to_nocb(void)
 }
 EXPORT_SYMBOL_GPL(rcu_bind_current_to_nocb);
 
+// The ->on_cpu field is available only in CONFIG_SMP=y, so...
+#ifdef CONFIG_SMP
+static char *show_rcu_should_be_on_cpu(struct task_struct *tsp)
+{
+	return tsp && tsp->state == TASK_RUNNING && !tsp->on_cpu ? "!" : "";
+}
+#else // #ifdef CONFIG_SMP
+static char *show_rcu_should_be_on_cpu(struct task_struct *tsp)
+{
+	return "";
+}
+#endif // #else #ifdef CONFIG_SMP
+
 /*
  * Dump out nocb grace-period kthread state for the specified rcu_data
  * structure.
@@ -2680,7 +2693,7 @@ static void show_rcu_nocb_gp_state(struct rcu_data *rdp)
 {
 	struct rcu_node *rnp = rdp->mynode;
 
-	pr_info("nocb GP %d %c%c%c%c%c%c %c[%c%c] %c%c:%ld rnp %d:%d %lu\n",
+	pr_info("nocb GP %d %c%c%c%c%c%c %c[%c%c] %c%c:%ld rnp %d:%d %lu %c CPU %d%s\n",
 		rdp->cpu,
 		"kK"[!!rdp->nocb_gp_kthread],
 		"lL"[raw_spin_is_locked(&rdp->nocb_gp_lock)],
@@ -2694,12 +2707,17 @@ static void show_rcu_nocb_gp_state(struct rcu_data *rdp)
 		".B"[!!rdp->nocb_gp_bypass],
 		".G"[!!rdp->nocb_gp_gp],
 		(long)rdp->nocb_gp_seq,
-		rnp->grplo, rnp->grphi, READ_ONCE(rdp->nocb_gp_loops));
+		rnp->grplo, rnp->grphi, READ_ONCE(rdp->nocb_gp_loops),
+		rdp->nocb_gp_kthread ? task_state_to_char(rdp->nocb_gp_kthread) : '.',
+		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
+		show_rcu_should_be_on_cpu(rdp->nocb_cb_kthread));
 }
 
 /* Dump out nocb kthread state for the specified rcu_data structure. */
 static void show_rcu_nocb_state(struct rcu_data *rdp)
 {
+	char bufw[20];
+	char bufr[20];
 	struct rcu_segcblist *rsclp = &rdp->cblist;
 	bool waslocked;
 	bool wastimer;
@@ -2708,7 +2726,9 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 	if (rdp->nocb_gp_rdp == rdp)
 		show_rcu_nocb_gp_state(rdp);
 
-	pr_info("   CB %d->%d %c%c%c%c%c%c F%ld L%ld C%d %c%c%c%c%c q%ld\n",
+	sprintf(bufw, "%ld", rsclp->gp_seq[RCU_WAIT_TAIL]);
+	sprintf(bufr, "%ld", rsclp->gp_seq[RCU_NEXT_READY_TAIL]);
+	pr_info("   CB %d^%d->%d %c%c%c%c%c%c F%ld L%ld C%d %c%c%s%c%s%c%c q%ld %c CPU %d%s\n",
 		rdp->cpu, rdp->nocb_gp_rdp->cpu,
 		"kK"[!!rdp->nocb_cb_kthread],
 		"bB"[raw_spin_is_locked(&rdp->nocb_bypass_lock)],
@@ -2720,11 +2740,16 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 		jiffies - rdp->nocb_nobypass_last,
 		rdp->nocb_nobypass_count,
 		".D"[rcu_segcblist_ready_cbs(rsclp)],
-		".W"[!rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL)],
-		".R"[!rcu_segcblist_restempty(rsclp, RCU_WAIT_TAIL)],
-		".N"[!rcu_segcblist_restempty(rsclp, RCU_NEXT_READY_TAIL)],
+		".W"[!rcu_segcblist_segempty(rsclp, RCU_WAIT_TAIL)],
+		rcu_segcblist_segempty(rsclp, RCU_WAIT_TAIL) ? "" : bufw,
+		".R"[!rcu_segcblist_segempty(rsclp, RCU_NEXT_READY_TAIL)],
+		rcu_segcblist_segempty(rsclp, RCU_NEXT_READY_TAIL) ? "" : bufr,
+		".N"[!rcu_segcblist_segempty(rsclp, RCU_NEXT_TAIL)],
 		".B"[!!rcu_cblist_n_cbs(&rdp->nocb_bypass)],
-		rcu_segcblist_n_cbs(&rdp->cblist));
+		rcu_segcblist_n_cbs(&rdp->cblist),
+		rdp->nocb_cb_kthread ? task_state_to_char(rdp->nocb_cb_kthread) : '.',
+		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_gp_kthread) : -1,
+		show_rcu_should_be_on_cpu(rdp->nocb_cb_kthread));
 
 	/* It is OK for GP kthreads to have GP state. */
 	if (rdp->nocb_gp_rdp == rdp)
