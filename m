Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5000319ED9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhBLMme (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:42:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45334 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhBLMkb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:40:31 -0500
Date:   Fri, 12 Feb 2021 12:37:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133441;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=m5+TS1b3ATOHr7MFbXaXx5Ysim80ZoLNR44LKSeccwM=;
        b=eaB+IndEu0HawAFp4pvo+2aATeU4YB1QBgbuBqp0JXC4zsNGSgQIKiooY69XN3ou4NvDQ4
        84U8TPAlpmhBR+wF5YhWf8U/pY2587EaA2J376YYZgFSycIY6DqsDwitaDkjcdPvjARrvl
        GLn5XBQWDy+CsQxLmBWLtzByuwQjjF2Op68ifRUoOT8t/VFQSPIjKTt4HqUTFjbEJlBfjC
        ViaC/KBKnHzPaHBNKdTbkhtH1Dt+fR/keJsacqzzZAUazyecMsgH8jqXgaGM2aAFopKF/G
        Ql/0ezp64lTS+DLZq3N5eKQWrazN6Y6iGBzMmCLKpoo6cEkrTGKNOXsZzCnm+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133441;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=m5+TS1b3ATOHr7MFbXaXx5Ysim80ZoLNR44LKSeccwM=;
        b=L4HQGuMhalefX5hS86w7oiDAxTGaORP772pgHB+MUxTg/vr3OmbMrK50t7DItnCNwjFapy
        RnEAmUi8NdOoD1BQ==
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/trace: Add tracing for how segcb list changes
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344136.23325.13233635101480157456.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     3afe7fa535491ecd0382c3968dc2349602bff8a2
Gitweb:        https://git.kernel.org/tip/3afe7fa535491ecd0382c3968dc2349602bff8a2
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Sat, 14 Nov 2020 14:31:32 -05:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:24:19 -08:00

rcu/trace: Add tracing for how segcb list changes

This commit adds tracing to track how the segcb list changes before/after
acceleration, during queuing and during dequeuing.

This tracing helped discover an optimization that avoided needless GP
requests when no callbacks were accelerated. The tracing overhead is
minimal as each segment's length is now stored in the respective segment.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/trace/events/rcu.h | 26 ++++++++++++++++++++++++++
 kernel/rcu/tree.c          |  9 +++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 155b5cb..5fc2940 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -505,6 +505,32 @@ TRACE_EVENT_RCU(rcu_callback,
 		  __entry->qlen)
 );
 
+TRACE_EVENT_RCU(rcu_segcb_stats,
+
+		TP_PROTO(struct rcu_segcblist *rs, const char *ctx),
+
+		TP_ARGS(rs, ctx),
+
+		TP_STRUCT__entry(
+			__field(const char *, ctx)
+			__array(unsigned long, gp_seq, RCU_CBLIST_NSEGS)
+			__array(long, seglen, RCU_CBLIST_NSEGS)
+		),
+
+		TP_fast_assign(
+			__entry->ctx = ctx;
+			memcpy(__entry->seglen, rs->seglen, RCU_CBLIST_NSEGS * sizeof(long));
+			memcpy(__entry->gp_seq, rs->gp_seq, RCU_CBLIST_NSEGS * sizeof(unsigned long));
+
+		),
+
+		TP_printk("%s seglen: (DONE=%ld, WAIT=%ld, NEXT_READY=%ld, NEXT=%ld) "
+			  "gp_seq: (DONE=%lu, WAIT=%lu, NEXT_READY=%lu, NEXT=%lu)", __entry->ctx,
+			  __entry->seglen[0], __entry->seglen[1], __entry->seglen[2], __entry->seglen[3],
+			  __entry->gp_seq[0], __entry->gp_seq[1], __entry->gp_seq[2], __entry->gp_seq[3])
+
+);
+
 /*
  * Tracepoint for the registration of a single RCU callback of the special
  * kvfree() form.  The first argument is the RCU type, the second argument
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b0fb654..6bf269c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1495,6 +1495,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	if (!rcu_segcblist_pend_cbs(&rdp->cblist))
 		return false;
 
+	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbPreAcc"));
+
 	/*
 	 * Callbacks are often registered with incomplete grace-period
 	 * information.  Something about the fact that getting exact
@@ -1515,6 +1517,8 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	else
 		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccReadyCB"));
 
+	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbPostAcc"));
+
 	return ret;
 }
 
@@ -2471,11 +2475,14 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	rcu_segcblist_extract_done_cbs(&rdp->cblist, &rcl);
 	if (offloaded)
 		rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
+
+	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCbDequeued"));
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
 	/* Invoke callbacks. */
 	tick_dep_set_task(current, TICK_DEP_BIT_RCU);
 	rhp = rcu_cblist_dequeue(&rcl);
+
 	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
 		rcu_callback_t f;
 
@@ -2987,6 +2994,8 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 		trace_rcu_callback(rcu_state.name, head,
 				   rcu_segcblist_n_cbs(&rdp->cblist));
 
+	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
+
 	/* Go handle any RCU core processing required. */
 	if (unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
 		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
