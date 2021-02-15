Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D2031BB89
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhBOO4h (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:56:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33152 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhBOO41 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:56:27 -0500
Date:   Mon, 15 Feb 2021 14:55:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TAkZBzhKHn6dqov3kRFxkwM0y9BMHSkNDXC2UtFtqXY=;
        b=fTDEX4pZBntwSSEFEFQu6NKbRrLIKluPJvThDHtLROS51FG8UFn1vqUP22OQCrsXgaNOmc
        9iJtGBbRWyhNCREkE4SCxoYDHFdF5vPXNuG6HGF4hR0zCAc1D6abHNQuBUJBP15xLOlQwC
        HU8g6q8iipQkf7yUasHMhPKQCUSzpkf78xF7ZLbldcjfDIYMhThULLMdXNkYa1hFThadn/
        aeReRhFDm8EWiddV9bsf2w0Ae8P2gTnvUN6ZwUyfpnKRdvzor5puad8YGd6M+D2CTVN78M
        YduCleh7pWSCUbokEJE6X7VZeHNv4JDU4pnQK9XCerQdz6OnSw1HEMiRXwoTzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=TAkZBzhKHn6dqov3kRFxkwM0y9BMHSkNDXC2UtFtqXY=;
        b=8UwjhCDIApQlaNIMom1DOYbGd9gwFj+1eTSfu8Jj/1Wb5rnGc4HOGDaUDQj8R8r6lU2pNL
        +hExSUQJJZ+n/vAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] srcu: Provide internal interface to start a Tree SRCU
 grace period
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094498.20312.1445677559215645808.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     29d2bb94a8a126ce80ffbb433b648b32fdea524e
Gitweb:        https://git.kernel.org/tip/29d2bb94a8a126ce80ffbb433b648b32fdea524e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 10:08:09 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:53:37 -08:00

srcu: Provide internal interface to start a Tree SRCU grace period

There is a need for a polling interface for SRCU grace periods.
This polling needs to initiate an SRCU grace period without having
to queue (and manage) a callback.  This commit therefore splits the
Tree SRCU __call_srcu() function into callback-initialization and
queuing/start-grace-period portions, with the latter in a new function
named srcu_gp_start_if_needed().  This function may be passed a NULL
callback pointer, in which case it will refrain from queuing anything.

Why have the new function mess with queuing?  Locking considerations,
of course!

Link: https://lore.kernel.org/rcu/20201112201547.GF3365678@moria.home.lan/
Reported-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 66 +++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 0f23d20..9a7b650 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -808,6 +808,42 @@ static void srcu_leak_callback(struct rcu_head *rhp)
 }
 
 /*
+ * Start an SRCU grace period, and also queue the callback if non-NULL.
+ */
+static void srcu_gp_start_if_needed(struct srcu_struct *ssp, struct rcu_head *rhp, bool do_norm)
+{
+	unsigned long flags;
+	int idx;
+	bool needexp = false;
+	bool needgp = false;
+	unsigned long s;
+	struct srcu_data *sdp;
+
+	idx = srcu_read_lock(ssp);
+	sdp = raw_cpu_ptr(ssp->sda);
+	spin_lock_irqsave_rcu_node(sdp, flags);
+	rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
+	rcu_segcblist_advance(&sdp->srcu_cblist,
+			      rcu_seq_current(&ssp->srcu_gp_seq));
+	s = rcu_seq_snap(&ssp->srcu_gp_seq);
+	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);
+	if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
+		sdp->srcu_gp_seq_needed = s;
+		needgp = true;
+	}
+	if (!do_norm && ULONG_CMP_LT(sdp->srcu_gp_seq_needed_exp, s)) {
+		sdp->srcu_gp_seq_needed_exp = s;
+		needexp = true;
+	}
+	spin_unlock_irqrestore_rcu_node(sdp, flags);
+	if (needgp)
+		srcu_funnel_gp_start(ssp, sdp, s, do_norm);
+	else if (needexp)
+		srcu_funnel_exp_start(ssp, sdp->mynode, s);
+	srcu_read_unlock(ssp, idx);
+}
+
+/*
  * Enqueue an SRCU callback on the srcu_data structure associated with
  * the current CPU and the specified srcu_struct structure, initiating
  * grace-period processing if it is not already running.
@@ -838,13 +874,6 @@ static void srcu_leak_callback(struct rcu_head *rhp)
 static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 			rcu_callback_t func, bool do_norm)
 {
-	unsigned long flags;
-	int idx;
-	bool needexp = false;
-	bool needgp = false;
-	unsigned long s;
-	struct srcu_data *sdp;
-
 	check_init_srcu_struct(ssp);
 	if (debug_rcu_head_queue(rhp)) {
 		/* Probable double call_srcu(), so leak the callback. */
@@ -853,28 +882,7 @@ static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 		return;
 	}
 	rhp->func = func;
-	idx = srcu_read_lock(ssp);
-	sdp = raw_cpu_ptr(ssp->sda);
-	spin_lock_irqsave_rcu_node(sdp, flags);
-	rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
-	rcu_segcblist_advance(&sdp->srcu_cblist,
-			      rcu_seq_current(&ssp->srcu_gp_seq));
-	s = rcu_seq_snap(&ssp->srcu_gp_seq);
-	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);
-	if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
-		sdp->srcu_gp_seq_needed = s;
-		needgp = true;
-	}
-	if (!do_norm && ULONG_CMP_LT(sdp->srcu_gp_seq_needed_exp, s)) {
-		sdp->srcu_gp_seq_needed_exp = s;
-		needexp = true;
-	}
-	spin_unlock_irqrestore_rcu_node(sdp, flags);
-	if (needgp)
-		srcu_funnel_gp_start(ssp, sdp, s, do_norm);
-	else if (needexp)
-		srcu_funnel_exp_start(ssp, sdp->mynode, s);
-	srcu_read_unlock(ssp, idx);
+	srcu_gp_start_if_needed(ssp, rhp, do_norm);
 }
 
 /**
