Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F399C2D8FF4
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390486AbgLMTCc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388845AbgLMTC1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0987C0617A6;
        Sun, 13 Dec 2020 11:01:04 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886062;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TwIfXLneYzm+SC9CTNMRKOnLfZLkk1ITF1swiVeJ5AY=;
        b=SnMAd8t9B0jJGbrYsDk+wZuCbIgt2tdUppoEY1AJTrq5bWRdadY1O3iXbuDChy2uRQVmAU
        to0a0Fl4ci4Jat2LlX7rMnnvkFag4+LSwHFFkja7bdNDlMkET81AxPcyHZ9Xw2ShkkIwfM
        ovT6JKLKWonln4XQAxAwaDT8vsscAq8/lo9ky4GCfZu0SVzXfWUiqUb0laLr8Y/HU7UUR6
        OKpn/8H2UeNOaRLlYD6MizXEsePMZn5hOVgcH0yrq8DpfhQLyYXlBNVHIn+J7ngVhDfoTE
        Lxp1SUicqkWghKtJFQnlzTkyNYOV2iwqKfnXN/GDTudRiL9avaEqMQTBs5S9HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886062;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TwIfXLneYzm+SC9CTNMRKOnLfZLkk1ITF1swiVeJ5AY=;
        b=jhvnL8pRO/hCwyYXQwgNqDS9+YJd+cXgWS37CENETutmjWQVMaLhHZUTNOt+KuBeYI9NmT
        kCT/ljFaHPIdakBA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Implement rcu_segcblist_is_offloaded() config dependent
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606242.3364.18211171338403359519.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e3771c850d3b9349b48449c9a91c98944a08650c
Gitweb:        https://git.kernel.org/tip/e3771c850d3b9349b48449c9a91c98944a08650c
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Mon, 21 Sep 2020 14:43:40 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 19 Nov 2020 19:37:16 -08:00

rcu: Implement rcu_segcblist_is_offloaded() config dependent

This commit simplifies the use of the rcu_segcblist_is_offloaded() API so
that its callers no longer need to check the RCU_NOCB_CPU Kconfig option.
Note that rcu_segcblist_is_offloaded() is defined in the header file,
which means that the generated code should be just as efficient as before.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.h |  2 +-
 kernel/rcu/tree.c          | 21 +++++++--------------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 5c293af..492262b 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -62,7 +62,7 @@ static inline bool rcu_segcblist_is_enabled(struct rcu_segcblist *rsclp)
 /* Is the specified rcu_segcblist offloaded?  */
 static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
 {
-	return rsclp->offloaded;
+	return IS_ENABLED(CONFIG_RCU_NOCB_CPU) && rsclp->offloaded;
 }
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 93e1808..0ccdca4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1603,8 +1603,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	bool ret = false;
 	bool need_qs;
-	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-			       rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 
 	raw_lockdep_assert_held_rcu_node(rnp);
 
@@ -2048,8 +2047,7 @@ static void rcu_gp_cleanup(void)
 		needgp = true;
 	}
 	/* Advance CBs to reduce false positives below. */
-	offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-		    rcu_segcblist_is_offloaded(&rdp->cblist);
+	offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 	if ((offloaded || !rcu_accelerate_cbs(rnp, rdp)) && needgp) {
 		WRITE_ONCE(rcu_state.gp_flags, RCU_GP_FLAG_INIT);
 		WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
@@ -2248,8 +2246,7 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 	unsigned long flags;
 	unsigned long mask;
 	bool needwake = false;
-	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-			       rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 	struct rcu_node *rnp;
 
 	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
@@ -2417,8 +2414,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 {
 	int div;
 	unsigned long flags;
-	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-			       rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	long bl, count;
@@ -2675,8 +2671,7 @@ static __latent_entropy void rcu_core(void)
 	unsigned long flags;
 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
-	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-			       rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 
 	if (cpu_is_offline(smp_processor_id()))
 		return;
@@ -2978,8 +2973,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 				   rcu_segcblist_n_cbs(&rdp->cblist));
 
 	/* Go handle any RCU core processing required. */
-	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-	    unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
+	if (unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
 		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
 	} else {
 		__call_rcu_core(rdp, head, flags);
@@ -3712,8 +3706,7 @@ static int rcu_pending(int user)
 
 	/* Has RCU gone idle with this CPU needing another grace period? */
 	if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
-	    (!IS_ENABLED(CONFIG_RCU_NOCB_CPU) ||
-	     !rcu_segcblist_is_offloaded(&rdp->cblist)) &&
+	    !rcu_segcblist_is_offloaded(&rdp->cblist) &&
 	    !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
 		return 1;
 
