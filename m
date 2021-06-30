Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B443B83DC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbhF3NvA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:51:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32958 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbhF3Nu1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:27 -0400
Date:   Wed, 30 Jun 2021 13:47:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=GDXQzZdEyq+tA7O+KlKpgPs+hIdJYgbzb8sBH4Ej8XE=;
        b=WobaWQfdnnm8UcfVSOUaMbm0DoBhr3WBkdCiVuPwMIjIgomz1GOauBuoi9K1+N1gVmLPIX
        9hxTdhxIYVD3L2E8gqhZ+dggzqM8/lhq+6oS2EYjnKgrpnYJNpf0oACN8p6Zgmi2c14igQ
        wLWo7f9bHAaLvZkv6fj8otxLBXo7JQLNLMRD7SuJZcqC3JcFZ/LZKfLChVLq9wrf2GJcc/
        eOO4N4fsZCUG8kmi4BBlk3g/eGqwVDnCPxDHR8XELhSgCQ5l/nM13r6Bmdop+XDSkeKHK2
        N4EKda335+f6UwuiRctjXRdJVvQIBLtD2H0PKjJZ+B1gqL6uxuaGfj2LcTQVqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=GDXQzZdEyq+tA7O+KlKpgPs+hIdJYgbzb8sBH4Ej8XE=;
        b=XibmdSLPxzzTmsX/0FzszVZxGEGVJxB/5RJR/ZSEugp3celbAag4iOp6OP80H7Luih+LxU
        7BrP1YTV5JoN21Bg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Add block comment laying out RCU Tasks design
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506087179.395.15551489265942613535.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     06a3ec9205d570526665c2071d1a5492c3091a54
Gitweb:        https://git.kernel.org/tip/06a3ec9205d570526665c2071d1a5492c3091a54
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 04 Mar 2021 14:41:47 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:04:24 -07:00

rcu-tasks: Add block comment laying out RCU Tasks design

This commit adds a block comment that gives a high-level overview of how
RCU tasks grace periods progress.  It also adds a note about how exiting
tasks are handled, plus it gives an overview of the memory ordering.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 350ebf5..94d2c2c 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -377,6 +377,46 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 // Finally, this implementation does not support high call_rcu_tasks()
 // rates from multiple CPUs.  If this is required, per-CPU callback lists
 // will be needed.
+//
+// The implementation uses rcu_tasks_wait_gp(), which relies on function
+// pointers in the rcu_tasks structure.  The rcu_spawn_tasks_kthread()
+// function sets these function pointers up so that rcu_tasks_wait_gp()
+// invokes these functions in this order:
+//
+// rcu_tasks_pregp_step():
+//	Invokes synchronize_rcu() in order to wait for all in-flight
+//	t->on_rq and t->nvcsw transitions to complete.	This works because
+//	all such transitions are carried out with interrupts disabled.
+// rcu_tasks_pertask(), invoked on every non-idle task:
+//	For every runnable non-idle task other than the current one, use
+//	get_task_struct() to pin down that task, snapshot that task's
+//	number of voluntary context switches, and add that task to the
+//	holdout list.
+// rcu_tasks_postscan():
+//	Invoke synchronize_srcu() to ensure that all tasks that were
+//	in the process of exiting (and which thus might not know to
+//	synchronize with this RCU Tasks grace period) have completed
+//	exiting.
+// check_all_holdout_tasks(), repeatedly until holdout list is empty:
+//	Scans the holdout list, attempting to identify a quiescent state
+//	for each task on the list.  If there is a quiescent state, the
+//	corresponding task is removed from the holdout list.
+// rcu_tasks_postgp():
+//	Invokes synchronize_rcu() in order to ensure that all prior
+//	t->on_rq and t->nvcsw transitions are seen by all CPUs and tasks
+//	to have happened before the end of this RCU Tasks grace period.
+//	Again, this works because all such transitions are carried out
+//	with interrupts disabled.
+//
+// For each exiting task, the exit_tasks_rcu_start() and
+// exit_tasks_rcu_finish() functions begin and end, respectively, the SRCU
+// read-side critical sections waited for by rcu_tasks_postscan().
+//
+// Pre-grace-period update-side code is ordered before the grace via the
+// ->cbs_lock and the smp_mb__after_spinlock().  Pre-grace-period read-side
+// code is ordered before the grace period via synchronize_rcu() call
+// in rcu_tasks_pregp_step() and by the scheduler's locks and interrupt
+// disabling.
 
 /* Pre-grace-period preparation. */
 static void rcu_tasks_pregp_step(void)
