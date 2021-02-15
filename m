Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C6A31BB98
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhBOO5J (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhBOO5B (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:57:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE723C061223;
        Mon, 15 Feb 2021 06:55:50 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:55:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400949;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nGkdblGr0tut8H09G/p6mR1LwFZmcF6JIgQWPmowasE=;
        b=M4yOq4XE55SOyhHBxw2W9rG1M1EGzpCw4OgdahR5wSJTZWsNTg8Z+gg7GfrRXEFenGzLwT
        rGuJ76VboM8ufOMDue4CXMOe24jTotv5DAXwaD6hHCRF6O68VquirMiHLBENtZ1oNNrK0X
        NUYfj4q8RSJ7SgFjkLC3pD1aEFIq+Xfyo0kaED9atG/0aHr3SwQSZY7hxhsproIXQRY0ML
        5vKEwyUFAVyCmI5xz3ufRvLdn0ysH132/bMb8fhOzxLEBD72VJ6OJ7HBgdooiVR5XvEpjV
        rQYthkt9LskErRV53OVTlreO/cXd1kUB+KipzIK0vupuzeGQSBT1Q61LGcarXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400949;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nGkdblGr0tut8H09G/p6mR1LwFZmcF6JIgQWPmowasE=;
        b=s35tnqjHiU1xKkCUVzhsCnOdxJOZivwFcySTjcxeVx5iTK5oGkJarqrBqyivncJvIkhtns
        C6A9P/zt83jifTAA==
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/tree: Make rcu_do_batch count how many callbacks
 were executed
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094882.20312.15311862866893559659.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     6bc335828056f3b301a3deadda782de4e8f0db08
Gitweb:        https://git.kernel.org/tip/6bc335828056f3b301a3deadda782de4e8f0db08
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Tue, 03 Nov 2020 09:25:57 -05:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:22:12 -08:00

rcu/tree: Make rcu_do_batch count how many callbacks were executed

The rcu_do_batch() function extracts the ready-to-invoke callbacks
from the rcu_segcblist located in the ->cblist field of the current
CPU's rcu_data structure.  These callbacks are first moved to a local
(unsegmented) rcu_cblist.  The rcu_do_batch() function then uses this
rcu_cblist's ->len field to count how many CBs it has invoked, but it
does so by counting that field down from zero.  Finally, this function
negates the value in this ->len field (resulting in a positive number)
and subtracts the result from the ->len field of the current CPU's
->cblist field.

Except that it is sometimes necessary for rcu_do_batch() to stop invoking
callbacks mid-stream, despite there being more ready to invoke, for
example, if a high-priority task wakes up.  In this case the remaining
not-yet-invoked callbacks are requeued back onto the CPU's ->cblist,
but remain in the ready-to-invoke segment of that list.  As above, the
negative of the local rcu_cblist's ->len field is still subtracted from
the ->len field of the current CPU's ->cblist field.

The design of counting down from 0 is confusing and error-prone, plus
use of a positive count will make it easier to provide a uniform and
consistent API to deal with the per-segment counts that are added
later in this series.  For example, rcu_segcblist_extract_done_cbs()
can unconditionally populate the resulting unsegmented list's ->len
field during extraction.

This commit therefore explicitly counts how many callbacks were executed
in rcu_do_batch() itself, counting up from zero, and then uses that
to update the per-CPU segcb list's ->len field, without relying on the
downcounting of rcl->len from zero.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.c |  2 +-
 kernel/rcu/rcu_segcblist.h |  1 +
 kernel/rcu/tree.c          | 11 +++++------
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 2d2a6b6..bb246d8 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -95,7 +95,7 @@ static void rcu_segcblist_set_len(struct rcu_segcblist *rsclp, long v)
  * This increase is fully ordered with respect to the callers accesses
  * both before and after.
  */
-static void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
+void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v)
 {
 #ifdef CONFIG_RCU_NOCB_CPU
 	smp_mb__before_atomic(); /* Up to the caller! */
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 492262b..1d2d614 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -76,6 +76,7 @@ static inline bool rcu_segcblist_restempty(struct rcu_segcblist *rsclp, int seg)
 }
 
 void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp);
+void rcu_segcblist_add_len(struct rcu_segcblist *rsclp, long v);
 void rcu_segcblist_init(struct rcu_segcblist *rsclp);
 void rcu_segcblist_disable(struct rcu_segcblist *rsclp);
 void rcu_segcblist_offload(struct rcu_segcblist *rsclp);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 40e5e3d..cc6f379 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2434,7 +2434,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
-	long bl, count;
+	long bl, count = 0;
 	long pending, tlimit = 0;
 
 	/* If no callbacks are ready, just return. */
@@ -2479,6 +2479,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	for (; rhp; rhp = rcu_cblist_dequeue(&rcl)) {
 		rcu_callback_t f;
 
+		count++;
 		debug_rcu_head_unqueue(rhp);
 
 		rcu_lock_acquire(&rcu_callback_map);
@@ -2492,15 +2493,14 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 		/*
 		 * Stop only if limit reached and CPU has something to do.
-		 * Note: The rcl structure counts down from zero.
 		 */
-		if (-rcl.len >= bl && !offloaded &&
+		if (count >= bl && !offloaded &&
 		    (need_resched() ||
 		     (!is_idle_task(current) && !rcu_is_callbacks_kthread())))
 			break;
 		if (unlikely(tlimit)) {
 			/* only call local_clock() every 32 callbacks */
-			if (likely((-rcl.len & 31) || local_clock() < tlimit))
+			if (likely((count & 31) || local_clock() < tlimit))
 				continue;
 			/* Exceeded the time limit, so leave. */
 			break;
@@ -2517,7 +2517,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 	local_irq_save(flags);
 	rcu_nocb_lock(rdp);
-	count = -rcl.len;
 	rdp->n_cbs_invoked += count;
 	trace_rcu_batch_end(rcu_state.name, count, !!rcl.head, need_resched(),
 			    is_idle_task(current), rcu_is_callbacks_kthread());
@@ -2525,7 +2524,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	/* Update counts and requeue any remaining callbacks. */
 	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
 	smp_mb(); /* List handling before counting for rcu_barrier(). */
-	rcu_segcblist_insert_count(&rdp->cblist, &rcl);
+	rcu_segcblist_add_len(&rdp->cblist, -count);
 
 	/* Reinstate batch limit if we have worked down the excess. */
 	count = rcu_segcblist_n_cbs(&rdp->cblist);
