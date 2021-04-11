Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49A635B4CB
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbhDKNoM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33094 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbhDKNoE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:04 -0400
Date:   Sun, 11 Apr 2021 13:43:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148607;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3PoAg33pCXrdLFI6TCJhYvxL2zGko59cUK/n2lMJl7k=;
        b=NNqWx4n3dywumhCmkjzavTCkzLEPRrBEbLmpDIGTn6paoVwqMZK+H30uawhZ1OUAh4i6+r
        ZvWWA3d9ONLGO42el6HfPThZNfL9KyZDE/g//vuyoftvbURTyzjUCPv2klxwuo6BYqo+JR
        pvHWoMImWUtKeNaDKmLy6QC3+3I2TUz+8K4A+BT0BzE4Bi8K1ob5u1CskPYdlrR8D1LFX3
        BvE0zLjo8zcCwjvDlBw+tprRq0G8IZQRfYP8fTEbI7DKpdZCYP3aCl5zPQuXLfJ8XLbkde
        nmjLXAQDg1t9urb/NTiurVMfAF4d/g/5TcgrXt6jmfaweSOwunRdNnVsLqw6gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148607;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3PoAg33pCXrdLFI6TCJhYvxL2zGko59cUK/n2lMJl7k=;
        b=u6U3hBC7h9ITk3CVibRAnQVgbZmot+WzQakXPM8nGbNYLsqAZJCjHh9PD9PqR3ghrMhUsG
        mB7nZHPUXEqg3qCg==
From:   "tip-bot2 for Sangmoon Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/tree: Add a trace event for RCU CPU stall warnings
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Sangmoon Kim <sangmoon.kim@samsung.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814860721.29796.16834571541941037397.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     565cfb9e64dac1aadf7e2130fcda19a1c018df66
Gitweb:        https://git.kernel.org/tip/565cfb9e64dac1aadf7e2130fcda19a1c018df66
Author:        Sangmoon Kim <sangmoon.kim@samsung.com>
AuthorDate:    Tue, 02 Mar 2021 20:55:15 +09:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 15 Mar 2021 13:53:24 -07:00

rcu/tree: Add a trace event for RCU CPU stall warnings

This commit adds a trace event which allows tracing the beginnings of RCU
CPU stall warnings on systems where sysctl_panic_on_rcu_stall is disabled.

The first parameter is the name of RCU flavor like other trace events.
The second parameter indicates whether this is a stall of an expedited
grace period, a self-detected stall of a normal grace period, or a stall
of a normal grace period detected by some CPU other than the one that
is stalled.

RCU CPU stall warnings are often caused by external-to-RCU issues,
for example, in interrupt handling or task scheduling.  Therefore,
this event uses TRACE_EVENT, not TRACE_EVENT_RCU, to avoid requiring
those interested in tracing RCU CPU stalls to rebuild their kernels
with CONFIG_RCU_TRACE=y.

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Sangmoon Kim <sangmoon.kim@samsung.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/trace/events/rcu.h | 28 ++++++++++++++++++++++++++++
 kernel/rcu/tree_exp.h      |  1 +
 kernel/rcu/tree_stall.h    |  2 ++
 3 files changed, 31 insertions(+)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 5fc2940..c7711e9 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -432,6 +432,34 @@ TRACE_EVENT_RCU(rcu_fqs,
 		  __entry->cpu, __entry->qsevent)
 );
 
+/*
+ * Tracepoint for RCU stall events. Takes a string identifying the RCU flavor
+ * and a string identifying which function detected the RCU stall as follows:
+ *
+ *	"StallDetected": Scheduler-tick detects other CPU's stalls.
+ *	"SelfDetected": Scheduler-tick detects a current CPU's stall.
+ *	"ExpeditedStall": Expedited grace period detects stalls.
+ */
+TRACE_EVENT(rcu_stall_warning,
+
+	TP_PROTO(const char *rcuname, const char *msg),
+
+	TP_ARGS(rcuname, msg),
+
+	TP_STRUCT__entry(
+		__field(const char *, rcuname)
+		__field(const char *, msg)
+	),
+
+	TP_fast_assign(
+		__entry->rcuname = rcuname;
+		__entry->msg = msg;
+	),
+
+	TP_printk("%s %s",
+		  __entry->rcuname, __entry->msg)
+);
+
 #endif /* #if defined(CONFIG_TREE_RCU) */
 
 /*
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6c6ff06..2796084 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -521,6 +521,7 @@ static void synchronize_rcu_expedited_wait(void)
 		if (rcu_stall_is_suppressed())
 			continue;
 		panic_on_rcu_stall();
+		trace_rcu_stall_warning(rcu_state.name, TPS("ExpeditedStall"));
 		pr_err("INFO: %s detected expedited stalls on CPUs/tasks: {",
 		       rcu_state.name);
 		ndetected = 0;
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 475b261..59b95cc 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -536,6 +536,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
 	 * RCU CPU stall warnings.
 	 */
+	trace_rcu_stall_warning(rcu_state.name, TPS("StallDetected"));
 	pr_err("INFO: %s detected stalls on CPUs/tasks:\n", rcu_state.name);
 	rcu_for_each_leaf_node(rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
@@ -606,6 +607,7 @@ static void print_cpu_stall(unsigned long gps)
 	 * See Documentation/RCU/stallwarn.rst for info on how to debug
 	 * RCU CPU stall warnings.
 	 */
+	trace_rcu_stall_warning(rcu_state.name, TPS("SelfDetected"));
 	pr_err("INFO: %s self-detected stall on CPU\n", rcu_state.name);
 	raw_spin_lock_irqsave_rcu_node(rdp->mynode, flags);
 	print_cpu_stall_info(smp_processor_id());
