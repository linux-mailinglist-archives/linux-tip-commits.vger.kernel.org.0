Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD1235B4E9
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbhDKNoY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33032 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbhDKNoG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:06 -0400
Date:   Sun, 11 Apr 2021 13:43:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148614;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=q0a91ukE1AdbdGzvQ69Fz7vnsC1yCyfnQ1v3/ABHUmU=;
        b=R/1FWUQHPf3B7nm+Sbty1LrS41jmWdirfKow4mPloXo8NrF3lllgMMzWPmFntBtm3Cj1De
        XGltIZCCjVVMG3G3HyTI/UmKCxkbQpRdwrsNo1cCLbsaD2fr9+y6ZJkP12ToKKQTR5SZVV
        6+kjrvQlO/xKB4HdxTXpSJzx74hwnhlVvk671j10wP8wOaPYfAhHSXSoKAPECZwuCWoOR2
        6qOQAPVpOAzft4XYbYR1IzVBmfdtmAuID1KVpqSmlTMsJEu17Oy/mJAv3RBA7fra2K+5zT
        jyjP9W1OHAFI05QxAtwHh4k70m+PIWMf8lRqk9jHikXDcqhGTSImmbC9Lf0SXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148614;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=q0a91ukE1AdbdGzvQ69Fz7vnsC1yCyfnQ1v3/ABHUmU=;
        b=Dp0Ue0NxJSU8xPaEzepcSInc/sJD1LtROQ0X1R+KfcJT/xWYXT4IDqqCTFnFJD3vfGBioe
        Anc3jTMb9bsX2gCQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Add block comment laying out RCU Tasks
 Trace design
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861368.29796.13942799375319454370.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a434dd10cd843c7348e7c54c77eb0fac27beceb4
Gitweb:        https://git.kernel.org/tip/a434dd10cd843c7348e7c54c77eb0fac27beceb4
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 25 Feb 2021 10:26:00 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:22:02 -08:00

rcu-tasks: Add block comment laying out RCU Tasks Trace design

This commit adds a block comment that gives a high-level overview of
how RCU tasks trace grace periods progress.  It also adds a note about
how exiting tasks are handled, plus it gives an overview of the memory
ordering.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
[ paulmck: Fix commit log per Mathieu Desnoyers feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 17c8ebe..350ebf5 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -726,6 +726,42 @@ EXPORT_SYMBOL_GPL(show_rcu_tasks_rude_gp_kthread);
 // flavors, rcu_preempt and rcu_sched.  The fact that RCU Tasks Trace
 // readers can operate from idle, offline, and exception entry/exit in no
 // way allows rcu_preempt and rcu_sched readers to also do so.
+//
+// The implementation uses rcu_tasks_wait_gp(), which relies on function
+// pointers in the rcu_tasks structure.  The rcu_spawn_tasks_trace_kthread()
+// function sets these function pointers up so that rcu_tasks_wait_gp()
+// invokes these functions in this order:
+//
+// rcu_tasks_trace_pregp_step():
+//	Initialize the count of readers and block CPU-hotplug operations.
+// rcu_tasks_trace_pertask(), invoked on every non-idle task:
+//	Initialize per-task state and attempt to identify an immediate
+//	quiescent state for that task, or, failing that, attempt to
+//	set that task's .need_qs flag so that task's next outermost
+//	rcu_read_unlock_trace() will report the quiescent state (in which
+//	case the count of readers is incremented).  If both attempts fail,
+//	the task is added to a "holdout" list.
+// rcu_tasks_trace_postscan():
+//	Initialize state and attempt to identify an immediate quiescent
+//	state as above (but only for idle tasks), unblock CPU-hotplug
+//	operations, and wait for an RCU grace period to avoid races with
+//	tasks that are in the process of exiting.
+// check_all_holdout_tasks_trace(), repeatedly until holdout list is empty:
+//	Scans the holdout list, attempting to identify a quiescent state
+//	for each task on the list.  If there is a quiescent state, the
+//	corresponding task is removed from the holdout list.
+// rcu_tasks_trace_postgp():
+//	Wait for the count of readers do drop to zero, reporting any stalls.
+//	Also execute full memory barriers to maintain ordering with code
+//	executing after the grace period.
+//
+// The exit_tasks_rcu_finish_trace() synchronizes with exiting tasks.
+//
+// Pre-grace-period update-side code is ordered before the grace
+// period via the ->cbs_lock and barriers in rcu_tasks_kthread().
+// Pre-grace-period read-side code is ordered before the grace period by
+// atomic_dec_and_test() of the count of readers (for IPIed readers) and by
+// scheduler context-switch ordering (for locked-down non-running readers).
 
 // The lockdep state must be outside of #ifdef to be useful.
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
