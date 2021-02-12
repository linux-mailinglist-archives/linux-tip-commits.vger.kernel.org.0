Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B8D319ED6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhBLMmT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:42:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45332 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbhBLMk1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:40:27 -0500
Date:   Fri, 12 Feb 2021 12:37:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133441;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=a3IoNioZ3MsloB8m8HajhZlbe4DfHzk3Cx0unkWNEeo=;
        b=SD5KNtVbbY31S3cYNQiv+v8tEPtyo+NWxHrV8hEEiPuc3eQX/zowLx4TfIMZ3AG9n17S41
        +/ugXJFKWEmFcLOZ3S8rhqNRB/Ha37OItlUiyhTB100bhe7KTitizluMdinzW7YLOo+8uv
        yk6kbYeU5ML84KeCjpgxDXIeWH8/tHwuYXZHX5m8WUybIOFmBta52elKZoaZvsoBHDAAlh
        8u79sbM/3a/X8IiP7Cgryz0ZhpQL4coigkxn+8Spc4NgSkUpF1TJWIa+ecBvTihX/Yb9oE
        gSCtfWxtoosnQYEGZinvAS/S4v1Fz5QQmV2mWj5srIE5HtzLErvA5M9BSG46xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133441;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=a3IoNioZ3MsloB8m8HajhZlbe4DfHzk3Cx0unkWNEeo=;
        b=yyQbk4Gv7LsvHjlNL/L5uo+djVvLIiY05JTBV3FZvDo7/7bNuecgycwW7UvXdacwEsT2rw
        vjqwx0A8oJ286mAA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Provide basic callback offloading state
 machine bits
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344053.23325.10412106197291366185.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     8d346d438f93b5344e99d429727ec9c2f392d4ec
Gitweb:        https://git.kernel.org/tip/8d346d438f93b5344e99d429727ec9c2f392d4ec
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 13 Nov 2020 13:13:17 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:24:19 -08:00

rcu/nocb: Provide basic callback offloading state machine bits

Offloading and de-offloading RCU callback processes must be done
carefully.  There must never be a time at which callback processing is
disabled because the task driving the offloading or de-offloading might be
preempted or otherwise stalled at that point in time, which would result
in OOM due to calbacks piling up indefinitely.  This implies that there
will be times during which a given CPU's callbacks might be concurrently
invoked by both that CPU's RCU_SOFTIRQ handler (or, equivalently, that
CPU's rcuc kthread) and by that CPU's rcuo kthread.

This situation could fatally confuse both rcu_barrier() and the
CPU-hotplug offlining process, so these must be excluded during any
concurrent-callback-invocation period.  In addition, during times of
concurrent callback invocation, changes to ->cblist must be protected
both as needed for RCU_SOFTIRQ and as needed for the rcuo kthread.

This commit therefore defines and documents the states for a state
machine that coordinates offloading and deoffloading.

Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Inspired-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcu_segcblist.h | 115 ++++++++++++++++++++++++++++++++-
 kernel/rcu/rcu_segcblist.c    |   1 +-
 kernel/rcu/rcu_segcblist.h    |  12 ++-
 kernel/rcu/tree.c             |   3 +-
 4 files changed, 128 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 4714b02..8afe886 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -63,8 +63,121 @@ struct rcu_cblist {
 #define RCU_NEXT_TAIL		3
 #define RCU_CBLIST_NSEGS	4
 
+
+/*
+ *                     ==NOCB Offloading state machine==
+ *
+ *
+ *  ----------------------------------------------------------------------------
+ *  |                         SEGCBLIST_SOFTIRQ_ONLY                           |
+ *  |                                                                          |
+ *  |  Callbacks processed by rcu_core() from softirqs or local                |
+ *  |  rcuc kthread, without holding nocb_lock.                                |
+ *  ----------------------------------------------------------------------------
+ *                                         |
+ *                                         v
+ *  ----------------------------------------------------------------------------
+ *  |                        SEGCBLIST_OFFLOADED                               |
+ *  |                                                                          |
+ *  | Callbacks processed by rcu_core() from softirqs or local                 |
+ *  | rcuc kthread, while holding nocb_lock. Waking up CB and GP kthreads,     |
+ *  | allowing nocb_timer to be armed.                                         |
+ *  ----------------------------------------------------------------------------
+ *                                         |
+ *                                         v
+ *                        -----------------------------------
+ *                        |                                 |
+ *                        v                                 v
+ *  ---------------------------------------  ----------------------------------|
+ *  |        SEGCBLIST_OFFLOADED |        |  |     SEGCBLIST_OFFLOADED |       |
+ *  |        SEGCBLIST_KTHREAD_CB         |  |     SEGCBLIST_KTHREAD_GP        |
+ *  |                                     |  |                                 |
+ *  |                                     |  |                                 |
+ *  | CB kthread woke up and              |  | GP kthread woke up and          |
+ *  | acknowledged SEGCBLIST_OFFLOADED.   |  | acknowledged SEGCBLIST_OFFLOADED|
+ *  | Processes callbacks concurrently    |  |                                 |
+ *  | with rcu_core(), holding            |  |                                 |
+ *  | nocb_lock.                          |  |                                 |
+ *  ---------------------------------------  -----------------------------------
+ *                        |                                 |
+ *                        -----------------------------------
+ *                                         |
+ *                                         v
+ *  |--------------------------------------------------------------------------|
+ *  |                           SEGCBLIST_OFFLOADED |                          |
+ *  |                           SEGCBLIST_KTHREAD_CB |                         |
+ *  |                           SEGCBLIST_KTHREAD_GP                           |
+ *  |                                                                          |
+ *  |   Kthreads handle callbacks holding nocb_lock, local rcu_core() stops    |
+ *  |   handling callbacks.                                                    |
+ *  ----------------------------------------------------------------------------
+ */
+
+
+
+/*
+ *                       ==NOCB De-Offloading state machine==
+ *
+ *
+ *  |--------------------------------------------------------------------------|
+ *  |                           SEGCBLIST_OFFLOADED |                          |
+ *  |                           SEGCBLIST_KTHREAD_CB |                         |
+ *  |                           SEGCBLIST_KTHREAD_GP                           |
+ *  |                                                                          |
+ *  |   CB/GP kthreads handle callbacks holding nocb_lock, local rcu_core()    |
+ *  |   ignores callbacks.                                                     |
+ *  ----------------------------------------------------------------------------
+ *                                      |
+ *                                      v
+ *  |--------------------------------------------------------------------------|
+ *  |                           SEGCBLIST_KTHREAD_CB |                         |
+ *  |                           SEGCBLIST_KTHREAD_GP                           |
+ *  |                                                                          |
+ *  |   CB/GP kthreads and local rcu_core() handle callbacks concurrently      |
+ *  |   holding nocb_lock. Wake up CB and GP kthreads if necessary.            |
+ *  ----------------------------------------------------------------------------
+ *                                      |
+ *                                      v
+ *                     -----------------------------------
+ *                     |                                 |
+ *                     v                                 v
+ *  ---------------------------------------------------------------------------|
+ *  |                                                                          |
+ *  |        SEGCBLIST_KTHREAD_CB         |       SEGCBLIST_KTHREAD_GP         |
+ *  |                                     |                                    |
+ *  | GP kthread woke up and              |   CB kthread woke up and           |
+ *  | acknowledged the fact that          |   acknowledged the fact that       |
+ *  | SEGCBLIST_OFFLOADED got cleared.    |   SEGCBLIST_OFFLOADED got cleared. |
+ *  |                                     |   The CB kthread goes to sleep     |
+ *  | The callbacks from the target CPU   |   until it ever gets re-offloaded. |
+ *  | will be ignored from the GP kthread |                                    |
+ *  | loop.                               |                                    |
+ *  ----------------------------------------------------------------------------
+ *                      |                                 |
+ *                      -----------------------------------
+ *                                      |
+ *                                      v
+ *  ----------------------------------------------------------------------------
+ *  |                                   0                                      |
+ *  |                                                                          |
+ *  | Callbacks processed by rcu_core() from softirqs or local                 |
+ *  | rcuc kthread, while holding nocb_lock. Forbid nocb_timer to be armed.    |
+ *  | Flush pending nocb_timer. Flush nocb bypass callbacks.                   |
+ *  ----------------------------------------------------------------------------
+ *                                      |
+ *                                      v
+ *  ----------------------------------------------------------------------------
+ *  |                         SEGCBLIST_SOFTIRQ_ONLY                           |
+ *  |                                                                          |
+ *  |  Callbacks processed by rcu_core() from softirqs or local                |
+ *  |  rcuc kthread, without holding nocb_lock.                                |
+ *  ----------------------------------------------------------------------------
+ */
 #define SEGCBLIST_ENABLED	BIT(0)
-#define SEGCBLIST_OFFLOADED	BIT(1)
+#define SEGCBLIST_SOFTIRQ_ONLY	BIT(1)
+#define SEGCBLIST_KTHREAD_CB	BIT(2)
+#define SEGCBLIST_KTHREAD_GP	BIT(3)
+#define SEGCBLIST_OFFLOADED	BIT(4)
 
 struct rcu_segcblist {
 	struct rcu_head *head;
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 934945d..7fc6362 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -266,6 +266,7 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
  */
 void rcu_segcblist_offload(struct rcu_segcblist *rsclp)
 {
+	rcu_segcblist_clear_flags(rsclp, SEGCBLIST_SOFTIRQ_ONLY);
 	rcu_segcblist_set_flags(rsclp, SEGCBLIST_OFFLOADED);
 }
 
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index ff372db..e05952a 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -83,8 +83,16 @@ static inline bool rcu_segcblist_is_enabled(struct rcu_segcblist *rsclp)
 /* Is the specified rcu_segcblist offloaded?  */
 static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
 {
-	return IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-		rcu_segcblist_test_flags(rsclp, SEGCBLIST_OFFLOADED);
+	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU)) {
+		/*
+		 * Complete de-offloading happens only when SEGCBLIST_SOFTIRQ_ONLY
+		 * is set.
+		 */
+		if (!rcu_segcblist_test_flags(rsclp, SEGCBLIST_SOFTIRQ_ONLY))
+			return true;
+	}
+
+	return false;
 }
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8086c04..7cfc2e8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -83,6 +83,9 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.dynticks_nesting = 1,
 	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
 	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
+#ifdef CONFIG_RCU_NOCB_CPU
+	.cblist.flags = SEGCBLIST_SOFTIRQ_ONLY,
+#endif
 };
 static struct rcu_state rcu_state = {
 	.level = { &rcu_state.node[0] },
