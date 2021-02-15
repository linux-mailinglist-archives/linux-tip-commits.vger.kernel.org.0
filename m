Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EE831BB96
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhBOO5H (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhBOO47 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:56:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040C8C061797;
        Mon, 15 Feb 2021 06:55:46 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:55:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=i0L2lBLBW6HUykLsaL9mDbqz+nAMMz6tZZNWQhE6Sq4=;
        b=j7HSBq8czOFqf8GJ1jvtFmzHN2OuSb37zAdRlFNmSLafM/RJu+xJ5ILYd5BBPTGhjAJRB2
        Fn5IquvEvOnCzvsdZFPfpte+MeHqJyCkfC5AjkDb5oFUKr1Jpo49D2EmSGq8vd34MKKVoc
        2znsE3EXbcK6m7JH3FShKcwwf/WgFwYNySyZ0h10ys2sRrxVl9nUXihnwXmnMH0CYuaX/w
        POnUfaXlbINYIf+sHStpcXzYaonQHZANzxuTQsLsxoVDdlzqTuUkwGW7r9Yi0SxDM5kcId
        xOnZu8PcI8StBu9I9riEPb39iiPVt2e23jS0wmNyeEByxQBBBFsTIhNzTDxKkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=i0L2lBLBW6HUykLsaL9mDbqz+nAMMz6tZZNWQhE6Sq4=;
        b=74HifbhymNu7Gz/9KRoBxkrdOFX7//Yksgt+fUjocW79fnOHNsSxmrSUO+FMh9HfdA1Orj
        egQUQKbNWLRah1Bw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] srcu: Provide polling interfaces for Tree SRCU grace periods
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094451.20312.6865723656153354263.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     5358c9fa54b09b5d3d7811b033aa0838c1bbaaf2
Gitweb:        https://git.kernel.org/tip/5358c9fa54b09b5d3d7811b033aa0838c1bbaaf2
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 17:31:55 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:53:38 -08:00

srcu: Provide polling interfaces for Tree SRCU grace periods

There is a need for a polling interface for SRCU grace
periods, so this commit supplies get_state_synchronize_srcu(),
start_poll_synchronize_srcu(), and poll_state_synchronize_srcu() for this
purpose.  The first can be used if future grace periods are inevitable
(perhaps due to a later call_srcu() invocation), the second if future
grace periods might not otherwise happen, and the third to check if a
grace period has elapsed since the corresponding call to either of the
first two.

As with get_state_synchronize_rcu() and cond_synchronize_rcu(),
the return value from either get_state_synchronize_srcu() or
start_poll_synchronize_srcu() must be passed in to a later call to
poll_state_synchronize_srcu().

Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
[ paulmck: Add EXPORT_SYMBOL_GPL() per kernel test robot feedback. ]
[ paulmck: Apply feedback from Neeraj Upadhyay. ]
Link: https://lore.kernel.org/lkml/20201117004017.GA7444@paulmck-ThinkPad-P72/
Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 67 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 9a7b650..c5d0c03 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -810,7 +810,8 @@ static void srcu_leak_callback(struct rcu_head *rhp)
 /*
  * Start an SRCU grace period, and also queue the callback if non-NULL.
  */
-static void srcu_gp_start_if_needed(struct srcu_struct *ssp, struct rcu_head *rhp, bool do_norm)
+static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
+					     struct rcu_head *rhp, bool do_norm)
 {
 	unsigned long flags;
 	int idx;
@@ -819,10 +820,12 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp, struct rcu_head *rh
 	unsigned long s;
 	struct srcu_data *sdp;
 
+	check_init_srcu_struct(ssp);
 	idx = srcu_read_lock(ssp);
 	sdp = raw_cpu_ptr(ssp->sda);
 	spin_lock_irqsave_rcu_node(sdp, flags);
-	rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
+	if (rhp)
+		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
 	rcu_segcblist_advance(&sdp->srcu_cblist,
 			      rcu_seq_current(&ssp->srcu_gp_seq));
 	s = rcu_seq_snap(&ssp->srcu_gp_seq);
@@ -841,6 +844,7 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp, struct rcu_head *rh
 	else if (needexp)
 		srcu_funnel_exp_start(ssp, sdp->mynode, s);
 	srcu_read_unlock(ssp, idx);
+	return s;
 }
 
 /*
@@ -874,7 +878,6 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp, struct rcu_head *rh
 static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 			rcu_callback_t func, bool do_norm)
 {
-	check_init_srcu_struct(ssp);
 	if (debug_rcu_head_queue(rhp)) {
 		/* Probable double call_srcu(), so leak the callback. */
 		WRITE_ONCE(rhp->func, srcu_leak_callback);
@@ -882,7 +885,7 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 		return;
 	}
 	rhp->func = func;
-	srcu_gp_start_if_needed(ssp, rhp, do_norm);
+	(void)srcu_gp_start_if_needed(ssp, rhp, do_norm);
 }
 
 /**
@@ -1011,6 +1014,62 @@ void synchronize_srcu(struct srcu_struct *ssp)
 }
 EXPORT_SYMBOL_GPL(synchronize_srcu);
 
+/**
+ * get_state_synchronize_srcu - Provide an end-of-grace-period cookie
+ * @ssp: srcu_struct to provide cookie for.
+ *
+ * This function returns a cookie that can be passed to
+ * poll_state_synchronize_srcu(), which will return true if a full grace
+ * period has elapsed in the meantime.  It is the caller's responsibility
+ * to make sure that grace period happens, for example, by invoking
+ * call_srcu() after return from get_state_synchronize_srcu().
+ */
+unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp)
+{
+	// Any prior manipulation of SRCU-protected data must happen
+	// before the load from ->srcu_gp_seq.
+	smp_mb();
+	return rcu_seq_snap(&ssp->srcu_gp_seq);
+}
+EXPORT_SYMBOL_GPL(get_state_synchronize_srcu);
+
+/**
+ * start_poll_synchronize_srcu - Provide cookie and start grace period
+ * @ssp: srcu_struct to provide cookie for.
+ *
+ * This function returns a cookie that can be passed to
+ * poll_state_synchronize_srcu(), which will return true if a full grace
+ * period has elapsed in the meantime.  Unlike get_state_synchronize_srcu(),
+ * this function also ensures that any needed SRCU grace period will be
+ * started.  This convenience does come at a cost in terms of CPU overhead.
+ */
+unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp)
+{
+	return srcu_gp_start_if_needed(ssp, NULL, true);
+}
+EXPORT_SYMBOL_GPL(start_poll_synchronize_srcu);
+
+/**
+ * poll_state_synchronize_srcu - Has cookie's grace period ended?
+ * @ssp: srcu_struct to provide cookie for.
+ * @cookie: Return value from get_state_synchronize_srcu() or start_poll_synchronize_srcu().
+ *
+ * This function takes the cookie that was returned from either
+ * get_state_synchronize_srcu() or start_poll_synchronize_srcu(), and
+ * returns @true if an SRCU grace period elapsed since the time that the
+ * cookie was created.
+ */
+bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)
+{
+	if (!rcu_seq_done(&ssp->srcu_gp_seq, cookie))
+		return false;
+	// Ensure that the end of the SRCU grace period happens before
+	// any subsequent code that the caller might execute.
+	smp_mb(); // ^^^
+	return true;
+}
+EXPORT_SYMBOL_GPL(poll_state_synchronize_srcu);
+
 /*
  * Callback function for srcu_barrier() use.
  */
