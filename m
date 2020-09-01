Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67626258DA6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Sep 2020 13:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgIALvr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Sep 2020 07:51:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39770 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgIALth (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Sep 2020 07:49:37 -0400
Date:   Tue, 01 Sep 2020 11:48:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960889;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rbKUoXqCEfeZrnxSvOdL5Y//FefWfJmB5RYp2qNuN7c=;
        b=ACxWpL9Jeozg/+0WWSfx6MQWlkfTocrnb2d3IvHitwjkmnCBgVRMumM+h2WE717KkvBrIN
        Mgjm8AzokIlTwAHHDm09kJ/ZBZWCrDOqHpv+pm/EM06qsqfCjrOpt741qJlpAGrUMc4Vul
        /z59xN/DEO4J+D3GxV4QyrwJ/8HAo/1V+2M6K6eX43axbi0+Q4U9NAFGrKsG4DauZCe8Ev
        FvD6hCiam9AdEZFf2QXOJVJ8ibSJNVqaWm49Cah7Ri6meyqYu1/psvJDwcC1xxMcnufQxB
        i0QFh+KxB4wpqglTnAXUv0OwLpgVCnkcc3KbUni/+2jjUipSv+PYQyItfFDmYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960889;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rbKUoXqCEfeZrnxSvOdL5Y//FefWfJmB5RYp2qNuN7c=;
        b=ZtsvRTknrenltwBEYeBY+StOxjTXllue30Wqp4dUEnG3wJ8SPQeuUlNzb/BHNmHieubadn
        dGg5KgCoxPzIRxCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/static_call] notifier: Fix broken error handling pattern
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200818135804.325626653@infradead.org>
References: <20200818135804.325626653@infradead.org>
MIME-Version: 1.0
Message-ID: <159896088908.20229.5428147133854163567.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/static_call branch of tip:

Commit-ID:     70d932985757fbe978024db313001218e9f8fe5c
Gitweb:        https://git.kernel.org/tip/70d932985757fbe978024db313001218e9f8fe5c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 18 Aug 2020 15:57:36 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:58:03 +02:00

notifier: Fix broken error handling pattern

The current notifiers have the following error handling pattern all
over the place:

	int err, nr;

	err = __foo_notifier_call_chain(&chain, val_up, v, -1, &nr);
	if (err & NOTIFIER_STOP_MASK)
		__foo_notifier_call_chain(&chain, val_down, v, nr-1, NULL)

And aside from the endless repetition thereof, it is broken. Consider
blocking notifiers; both calls take and drop the rwsem, this means
that the notifier list can change in between the two calls, making @nr
meaningless.

Fix this by replacing all the __foo_notifier_call_chain() functions
with foo_notifier_call_chain_robust() that embeds the above pattern,
but ensures it is inside a single lock region.

Note: I switched atomic_notifier_call_chain_robust() to use
      the spinlock, since RCU cannot provide the guarantee
      required for the recovery.

Note: software_resume() error handling was broken afaict.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20200818135804.325626653@infradead.org
---
 include/linux/notifier.h           |  15 +--
 kernel/cpu_pm.c                    |  48 +++------
 kernel/notifier.c                  | 144 +++++++++++++++++-----------
 kernel/power/hibernate.c           |  39 +++-----
 kernel/power/main.c                |   8 +-
 kernel/power/power.h               |   3 +-
 kernel/power/suspend.c             |  14 +--
 kernel/power/user.c                |  14 +---
 tools/power/pm-graph/sleepgraph.py |   2 +-
 9 files changed, 147 insertions(+), 140 deletions(-)

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index 0189476..2fb373a 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -161,20 +161,19 @@ extern int srcu_notifier_chain_unregister(struct srcu_notifier_head *nh,
 
 extern int atomic_notifier_call_chain(struct atomic_notifier_head *nh,
 		unsigned long val, void *v);
-extern int __atomic_notifier_call_chain(struct atomic_notifier_head *nh,
-	unsigned long val, void *v, int nr_to_call, int *nr_calls);
 extern int blocking_notifier_call_chain(struct blocking_notifier_head *nh,
 		unsigned long val, void *v);
-extern int __blocking_notifier_call_chain(struct blocking_notifier_head *nh,
-	unsigned long val, void *v, int nr_to_call, int *nr_calls);
 extern int raw_notifier_call_chain(struct raw_notifier_head *nh,
 		unsigned long val, void *v);
-extern int __raw_notifier_call_chain(struct raw_notifier_head *nh,
-	unsigned long val, void *v, int nr_to_call, int *nr_calls);
 extern int srcu_notifier_call_chain(struct srcu_notifier_head *nh,
 		unsigned long val, void *v);
-extern int __srcu_notifier_call_chain(struct srcu_notifier_head *nh,
-	unsigned long val, void *v, int nr_to_call, int *nr_calls);
+
+extern int atomic_notifier_call_chain_robust(struct atomic_notifier_head *nh,
+		unsigned long val_up, unsigned long val_down, void *v);
+extern int blocking_notifier_call_chain_robust(struct blocking_notifier_head *nh,
+		unsigned long val_up, unsigned long val_down, void *v);
+extern int raw_notifier_call_chain_robust(struct raw_notifier_head *nh,
+		unsigned long val_up, unsigned long val_down, void *v);
 
 #define NOTIFY_DONE		0x0000		/* Don't care */
 #define NOTIFY_OK		0x0001		/* Suits me */
diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index 44a2593..f7e1d0e 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -15,18 +15,28 @@
 
 static ATOMIC_NOTIFIER_HEAD(cpu_pm_notifier_chain);
 
-static int cpu_pm_notify(enum cpu_pm_event event, int nr_to_call, int *nr_calls)
+static int cpu_pm_notify(enum cpu_pm_event event)
 {
 	int ret;
 
 	/*
-	 * __atomic_notifier_call_chain has a RCU read critical section, which
+	 * atomic_notifier_call_chain has a RCU read critical section, which
 	 * could be disfunctional in cpu idle. Copy RCU_NONIDLE code to let
 	 * RCU know this.
 	 */
 	rcu_irq_enter_irqson();
-	ret = __atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL,
-		nr_to_call, nr_calls);
+	ret = atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL);
+	rcu_irq_exit_irqson();
+
+	return notifier_to_errno(ret);
+}
+
+static int cpu_pm_notify_robust(enum cpu_pm_event event_up, enum cpu_pm_event event_down)
+{
+	int ret;
+
+	rcu_irq_enter_irqson();
+	ret = atomic_notifier_call_chain_robust(&cpu_pm_notifier_chain, event_up, event_down, NULL);
 	rcu_irq_exit_irqson();
 
 	return notifier_to_errno(ret);
@@ -80,18 +90,7 @@ EXPORT_SYMBOL_GPL(cpu_pm_unregister_notifier);
  */
 int cpu_pm_enter(void)
 {
-	int nr_calls = 0;
-	int ret = 0;
-
-	ret = cpu_pm_notify(CPU_PM_ENTER, -1, &nr_calls);
-	if (ret)
-		/*
-		 * Inform listeners (nr_calls - 1) about failure of CPU PM
-		 * PM entry who are notified earlier to prepare for it.
-		 */
-		cpu_pm_notify(CPU_PM_ENTER_FAILED, nr_calls - 1, NULL);
-
-	return ret;
+	return cpu_pm_notify_robust(CPU_PM_ENTER, CPU_PM_ENTER_FAILED);
 }
 EXPORT_SYMBOL_GPL(cpu_pm_enter);
 
@@ -109,7 +108,7 @@ EXPORT_SYMBOL_GPL(cpu_pm_enter);
  */
 int cpu_pm_exit(void)
 {
-	return cpu_pm_notify(CPU_PM_EXIT, -1, NULL);
+	return cpu_pm_notify(CPU_PM_EXIT);
 }
 EXPORT_SYMBOL_GPL(cpu_pm_exit);
 
@@ -131,18 +130,7 @@ EXPORT_SYMBOL_GPL(cpu_pm_exit);
  */
 int cpu_cluster_pm_enter(void)
 {
-	int nr_calls = 0;
-	int ret = 0;
-
-	ret = cpu_pm_notify(CPU_CLUSTER_PM_ENTER, -1, &nr_calls);
-	if (ret)
-		/*
-		 * Inform listeners (nr_calls - 1) about failure of CPU cluster
-		 * PM entry who are notified earlier to prepare for it.
-		 */
-		cpu_pm_notify(CPU_CLUSTER_PM_ENTER_FAILED, nr_calls - 1, NULL);
-
-	return ret;
+	return cpu_pm_notify_robust(CPU_CLUSTER_PM_ENTER, CPU_CLUSTER_PM_ENTER_FAILED);
 }
 EXPORT_SYMBOL_GPL(cpu_cluster_pm_enter);
 
@@ -163,7 +151,7 @@ EXPORT_SYMBOL_GPL(cpu_cluster_pm_enter);
  */
 int cpu_cluster_pm_exit(void)
 {
-	return cpu_pm_notify(CPU_CLUSTER_PM_EXIT, -1, NULL);
+	return cpu_pm_notify(CPU_CLUSTER_PM_EXIT);
 }
 EXPORT_SYMBOL_GPL(cpu_cluster_pm_exit);
 
diff --git a/kernel/notifier.c b/kernel/notifier.c
index 84c987d..1b019cb 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -94,6 +94,34 @@ static int notifier_call_chain(struct notifier_block **nl,
 }
 NOKPROBE_SYMBOL(notifier_call_chain);
 
+/**
+ * notifier_call_chain_robust - Inform the registered notifiers about an event
+ *                              and rollback on error.
+ * @nl:		Pointer to head of the blocking notifier chain
+ * @val_up:	Value passed unmodified to the notifier function
+ * @val_down:	Value passed unmodified to the notifier function when recovering
+ *              from an error on @val_up
+ * @v		Pointer passed unmodified to the notifier function
+ *
+ * NOTE:	It is important the @nl chain doesn't change between the two
+ *		invocations of notifier_call_chain() such that we visit the
+ *		exact same notifier callbacks; this rules out any RCU usage.
+ *
+ * Returns:	the return value of the @val_up call.
+ */
+static int notifier_call_chain_robust(struct notifier_block **nl,
+				     unsigned long val_up, unsigned long val_down,
+				     void *v)
+{
+	int ret, nr = 0;
+
+	ret = notifier_call_chain(nl, val_up, v, -1, &nr);
+	if (ret & NOTIFY_STOP_MASK)
+		notifier_call_chain(nl, val_down, v, nr-1, NULL);
+
+	return ret;
+}
+
 /*
  *	Atomic notifier chain routines.  Registration and unregistration
  *	use a spinlock, and call_chain is synchronized by RCU (no locks).
@@ -144,13 +172,30 @@ int atomic_notifier_chain_unregister(struct atomic_notifier_head *nh,
 }
 EXPORT_SYMBOL_GPL(atomic_notifier_chain_unregister);
 
+int atomic_notifier_call_chain_robust(struct atomic_notifier_head *nh,
+		unsigned long val_up, unsigned long val_down, void *v)
+{
+	unsigned long flags;
+	int ret;
+
+	/*
+	 * Musn't use RCU; because then the notifier list can
+	 * change between the up and down traversal.
+	 */
+	spin_lock_irqsave(&nh->lock, flags);
+	ret = notifier_call_chain_robust(&nh->head, val_up, val_down, v);
+	spin_unlock_irqrestore(&nh->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(atomic_notifier_call_chain_robust);
+NOKPROBE_SYMBOL(atomic_notifier_call_chain_robust);
+
 /**
- *	__atomic_notifier_call_chain - Call functions in an atomic notifier chain
+ *	atomic_notifier_call_chain - Call functions in an atomic notifier chain
  *	@nh: Pointer to head of the atomic notifier chain
  *	@val: Value passed unmodified to notifier function
  *	@v: Pointer passed unmodified to notifier function
- *	@nr_to_call: See the comment for notifier_call_chain.
- *	@nr_calls: See the comment for notifier_call_chain.
  *
  *	Calls each function in a notifier chain in turn.  The functions
  *	run in an atomic context, so they must not block.
@@ -163,24 +208,16 @@ EXPORT_SYMBOL_GPL(atomic_notifier_chain_unregister);
  *	Otherwise the return value is the return value
  *	of the last notifier function called.
  */
-int __atomic_notifier_call_chain(struct atomic_notifier_head *nh,
-				 unsigned long val, void *v,
-				 int nr_to_call, int *nr_calls)
+int atomic_notifier_call_chain(struct atomic_notifier_head *nh,
+			       unsigned long val, void *v)
 {
 	int ret;
 
 	rcu_read_lock();
-	ret = notifier_call_chain(&nh->head, val, v, nr_to_call, nr_calls);
+	ret = notifier_call_chain(&nh->head, val, v, -1, NULL);
 	rcu_read_unlock();
-	return ret;
-}
-EXPORT_SYMBOL_GPL(__atomic_notifier_call_chain);
-NOKPROBE_SYMBOL(__atomic_notifier_call_chain);
 
-int atomic_notifier_call_chain(struct atomic_notifier_head *nh,
-			       unsigned long val, void *v)
-{
-	return __atomic_notifier_call_chain(nh, val, v, -1, NULL);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(atomic_notifier_call_chain);
 NOKPROBE_SYMBOL(atomic_notifier_call_chain);
@@ -250,13 +287,30 @@ int blocking_notifier_chain_unregister(struct blocking_notifier_head *nh,
 }
 EXPORT_SYMBOL_GPL(blocking_notifier_chain_unregister);
 
+int blocking_notifier_call_chain_robust(struct blocking_notifier_head *nh,
+		unsigned long val_up, unsigned long val_down, void *v)
+{
+	int ret = NOTIFY_DONE;
+
+	/*
+	 * We check the head outside the lock, but if this access is
+	 * racy then it does not matter what the result of the test
+	 * is, we re-check the list after having taken the lock anyway:
+	 */
+	if (rcu_access_pointer(nh->head)) {
+		down_read(&nh->rwsem);
+		ret = notifier_call_chain_robust(&nh->head, val_up, val_down, v);
+		up_read(&nh->rwsem);
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blocking_notifier_call_chain_robust);
+
 /**
- *	__blocking_notifier_call_chain - Call functions in a blocking notifier chain
+ *	blocking_notifier_call_chain - Call functions in a blocking notifier chain
  *	@nh: Pointer to head of the blocking notifier chain
  *	@val: Value passed unmodified to notifier function
  *	@v: Pointer passed unmodified to notifier function
- *	@nr_to_call: See comment for notifier_call_chain.
- *	@nr_calls: See comment for notifier_call_chain.
  *
  *	Calls each function in a notifier chain in turn.  The functions
  *	run in a process context, so they are allowed to block.
@@ -268,9 +322,8 @@ EXPORT_SYMBOL_GPL(blocking_notifier_chain_unregister);
  *	Otherwise the return value is the return value
  *	of the last notifier function called.
  */
-int __blocking_notifier_call_chain(struct blocking_notifier_head *nh,
-				   unsigned long val, void *v,
-				   int nr_to_call, int *nr_calls)
+int blocking_notifier_call_chain(struct blocking_notifier_head *nh,
+		unsigned long val, void *v)
 {
 	int ret = NOTIFY_DONE;
 
@@ -281,19 +334,11 @@ int __blocking_notifier_call_chain(struct blocking_notifier_head *nh,
 	 */
 	if (rcu_access_pointer(nh->head)) {
 		down_read(&nh->rwsem);
-		ret = notifier_call_chain(&nh->head, val, v, nr_to_call,
-					nr_calls);
+		ret = notifier_call_chain(&nh->head, val, v, -1, NULL);
 		up_read(&nh->rwsem);
 	}
 	return ret;
 }
-EXPORT_SYMBOL_GPL(__blocking_notifier_call_chain);
-
-int blocking_notifier_call_chain(struct blocking_notifier_head *nh,
-		unsigned long val, void *v)
-{
-	return __blocking_notifier_call_chain(nh, val, v, -1, NULL);
-}
 EXPORT_SYMBOL_GPL(blocking_notifier_call_chain);
 
 /*
@@ -335,13 +380,18 @@ int raw_notifier_chain_unregister(struct raw_notifier_head *nh,
 }
 EXPORT_SYMBOL_GPL(raw_notifier_chain_unregister);
 
+int raw_notifier_call_chain_robust(struct raw_notifier_head *nh,
+		unsigned long val_up, unsigned long val_down, void *v)
+{
+	return notifier_call_chain_robust(&nh->head, val_up, val_down, v);
+}
+EXPORT_SYMBOL_GPL(raw_notifier_call_chain_robust);
+
 /**
- *	__raw_notifier_call_chain - Call functions in a raw notifier chain
+ *	raw_notifier_call_chain - Call functions in a raw notifier chain
  *	@nh: Pointer to head of the raw notifier chain
  *	@val: Value passed unmodified to notifier function
  *	@v: Pointer passed unmodified to notifier function
- *	@nr_to_call: See comment for notifier_call_chain.
- *	@nr_calls: See comment for notifier_call_chain
  *
  *	Calls each function in a notifier chain in turn.  The functions
  *	run in an undefined context.
@@ -354,18 +404,10 @@ EXPORT_SYMBOL_GPL(raw_notifier_chain_unregister);
  *	Otherwise the return value is the return value
  *	of the last notifier function called.
  */
-int __raw_notifier_call_chain(struct raw_notifier_head *nh,
-			      unsigned long val, void *v,
-			      int nr_to_call, int *nr_calls)
-{
-	return notifier_call_chain(&nh->head, val, v, nr_to_call, nr_calls);
-}
-EXPORT_SYMBOL_GPL(__raw_notifier_call_chain);
-
 int raw_notifier_call_chain(struct raw_notifier_head *nh,
 		unsigned long val, void *v)
 {
-	return __raw_notifier_call_chain(nh, val, v, -1, NULL);
+	return notifier_call_chain(&nh->head, val, v, -1, NULL);
 }
 EXPORT_SYMBOL_GPL(raw_notifier_call_chain);
 
@@ -437,12 +479,10 @@ int srcu_notifier_chain_unregister(struct srcu_notifier_head *nh,
 EXPORT_SYMBOL_GPL(srcu_notifier_chain_unregister);
 
 /**
- *	__srcu_notifier_call_chain - Call functions in an SRCU notifier chain
+ *	srcu_notifier_call_chain - Call functions in an SRCU notifier chain
  *	@nh: Pointer to head of the SRCU notifier chain
  *	@val: Value passed unmodified to notifier function
  *	@v: Pointer passed unmodified to notifier function
- *	@nr_to_call: See comment for notifier_call_chain.
- *	@nr_calls: See comment for notifier_call_chain
  *
  *	Calls each function in a notifier chain in turn.  The functions
  *	run in a process context, so they are allowed to block.
@@ -454,25 +494,17 @@ EXPORT_SYMBOL_GPL(srcu_notifier_chain_unregister);
  *	Otherwise the return value is the return value
  *	of the last notifier function called.
  */
-int __srcu_notifier_call_chain(struct srcu_notifier_head *nh,
-			       unsigned long val, void *v,
-			       int nr_to_call, int *nr_calls)
+int srcu_notifier_call_chain(struct srcu_notifier_head *nh,
+		unsigned long val, void *v)
 {
 	int ret;
 	int idx;
 
 	idx = srcu_read_lock(&nh->srcu);
-	ret = notifier_call_chain(&nh->head, val, v, nr_to_call, nr_calls);
+	ret = notifier_call_chain(&nh->head, val, v, -1, NULL);
 	srcu_read_unlock(&nh->srcu, idx);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(__srcu_notifier_call_chain);
-
-int srcu_notifier_call_chain(struct srcu_notifier_head *nh,
-		unsigned long val, void *v)
-{
-	return __srcu_notifier_call_chain(nh, val, v, -1, NULL);
-}
 EXPORT_SYMBOL_GPL(srcu_notifier_call_chain);
 
 /**
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index e7aa57f..1dee708 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -706,8 +706,8 @@ static int load_image_and_restore(void)
  */
 int hibernate(void)
 {
-	int error, nr_calls = 0;
 	bool snapshot_test = false;
+	int error;
 
 	if (!hibernation_available()) {
 		pm_pr_dbg("Hibernation not available.\n");
@@ -723,11 +723,9 @@ int hibernate(void)
 
 	pr_info("hibernation entry\n");
 	pm_prepare_console();
-	error = __pm_notifier_call_chain(PM_HIBERNATION_PREPARE, -1, &nr_calls);
-	if (error) {
-		nr_calls--;
-		goto Exit;
-	}
+	error = pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, PM_POST_HIBERNATION);
+	if (error)
+		goto Restore;
 
 	ksys_sync_helper();
 
@@ -785,7 +783,8 @@ int hibernate(void)
 	/* Don't bother checking whether freezer_test_done is true */
 	freezer_test_done = false;
  Exit:
-	__pm_notifier_call_chain(PM_POST_HIBERNATION, nr_calls, NULL);
+	pm_notifier_call_chain(PM_POST_HIBERNATION);
+ Restore:
 	pm_restore_console();
 	hibernate_release();
  Unlock:
@@ -804,7 +803,7 @@ int hibernate(void)
  */
 int hibernate_quiet_exec(int (*func)(void *data), void *data)
 {
-	int error, nr_calls = 0;
+	int error;
 
 	lock_system_sleep();
 
@@ -815,11 +814,9 @@ int hibernate_quiet_exec(int (*func)(void *data), void *data)
 
 	pm_prepare_console();
 
-	error = __pm_notifier_call_chain(PM_HIBERNATION_PREPARE, -1, &nr_calls);
-	if (error) {
-		nr_calls--;
-		goto exit;
-	}
+	error = pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, PM_POST_HIBERNATION);
+	if (error)
+		goto restore;
 
 	error = freeze_processes();
 	if (error)
@@ -880,8 +877,9 @@ thaw:
 	thaw_processes();
 
 exit:
-	__pm_notifier_call_chain(PM_POST_HIBERNATION, nr_calls, NULL);
+	pm_notifier_call_chain(PM_POST_HIBERNATION);
 
+restore:
 	pm_restore_console();
 
 	hibernate_release();
@@ -910,7 +908,7 @@ EXPORT_SYMBOL_GPL(hibernate_quiet_exec);
  */
 static int software_resume(void)
 {
-	int error, nr_calls = 0;
+	int error;
 
 	/*
 	 * If the user said "noresume".. bail out early.
@@ -997,11 +995,9 @@ static int software_resume(void)
 
 	pr_info("resume from hibernation\n");
 	pm_prepare_console();
-	error = __pm_notifier_call_chain(PM_RESTORE_PREPARE, -1, &nr_calls);
-	if (error) {
-		nr_calls--;
-		goto Close_Finish;
-	}
+	error = pm_notifier_call_chain_robust(PM_RESTORE_PREPARE, PM_POST_RESTORE);
+	if (error)
+		goto Restore;
 
 	pm_pr_dbg("Preparing processes for hibernation restore.\n");
 	error = freeze_processes();
@@ -1017,7 +1013,8 @@ static int software_resume(void)
 	error = load_image_and_restore();
 	thaw_processes();
  Finish:
-	__pm_notifier_call_chain(PM_POST_RESTORE, nr_calls, NULL);
+	pm_notifier_call_chain(PM_POST_RESTORE);
+ Restore:
 	pm_restore_console();
 	pr_info("resume failed (%d)\n", error);
 	hibernate_release();
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 40f86ec..0aefd6f 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -80,18 +80,18 @@ int unregister_pm_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(unregister_pm_notifier);
 
-int __pm_notifier_call_chain(unsigned long val, int nr_to_call, int *nr_calls)
+int pm_notifier_call_chain_robust(unsigned long val_up, unsigned long val_down)
 {
 	int ret;
 
-	ret = __blocking_notifier_call_chain(&pm_chain_head, val, NULL,
-						nr_to_call, nr_calls);
+	ret = blocking_notifier_call_chain_robust(&pm_chain_head, val_up, val_down, NULL);
 
 	return notifier_to_errno(ret);
 }
+
 int pm_notifier_call_chain(unsigned long val)
 {
-	return __pm_notifier_call_chain(val, -1, NULL);
+	return blocking_notifier_call_chain(&pm_chain_head, val, NULL);
 }
 
 /* If set, devices may be suspended and resumed asynchronously. */
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 32fc89a..24f12d5 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -210,8 +210,7 @@ static inline void suspend_test_finish(const char *label) {}
 
 #ifdef CONFIG_PM_SLEEP
 /* kernel/power/main.c */
-extern int __pm_notifier_call_chain(unsigned long val, int nr_to_call,
-				    int *nr_calls);
+extern int pm_notifier_call_chain_robust(unsigned long val_up, unsigned long val_down);
 extern int pm_notifier_call_chain(unsigned long val);
 #endif
 
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 8b1bb5e..32391ac 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -342,18 +342,16 @@ static int suspend_test(int level)
  */
 static int suspend_prepare(suspend_state_t state)
 {
-	int error, nr_calls = 0;
+	int error;
 
 	if (!sleep_state_supported(state))
 		return -EPERM;
 
 	pm_prepare_console();
 
-	error = __pm_notifier_call_chain(PM_SUSPEND_PREPARE, -1, &nr_calls);
-	if (error) {
-		nr_calls--;
-		goto Finish;
-	}
+	error = pm_notifier_call_chain_robust(PM_SUSPEND_PREPARE, PM_POST_SUSPEND);
+	if (error)
+		goto Restore;
 
 	trace_suspend_resume(TPS("freeze_processes"), 0, true);
 	error = suspend_freeze_processes();
@@ -363,8 +361,8 @@ static int suspend_prepare(suspend_state_t state)
 
 	suspend_stats.failed_freeze++;
 	dpm_save_failed_step(SUSPEND_FREEZE);
- Finish:
-	__pm_notifier_call_chain(PM_POST_SUSPEND, nr_calls, NULL);
+	pm_notifier_call_chain(PM_POST_SUSPEND);
+ Restore:
 	pm_restore_console();
 	return error;
 }
diff --git a/kernel/power/user.c b/kernel/power/user.c
index d5eedc2..047f598 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -46,7 +46,7 @@ int is_hibernate_resume_dev(const struct inode *bd_inode)
 static int snapshot_open(struct inode *inode, struct file *filp)
 {
 	struct snapshot_data *data;
-	int error, nr_calls = 0;
+	int error;
 
 	if (!hibernation_available())
 		return -EPERM;
@@ -73,9 +73,7 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 			swap_type_of(swsusp_resume_device, 0, NULL) : -1;
 		data->mode = O_RDONLY;
 		data->free_bitmaps = false;
-		error = __pm_notifier_call_chain(PM_HIBERNATION_PREPARE, -1, &nr_calls);
-		if (error)
-			__pm_notifier_call_chain(PM_POST_HIBERNATION, --nr_calls, NULL);
+		error = pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, PM_POST_HIBERNATION);
 	} else {
 		/*
 		 * Resuming.  We may need to wait for the image device to
@@ -85,15 +83,11 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 
 		data->swap = -1;
 		data->mode = O_WRONLY;
-		error = __pm_notifier_call_chain(PM_RESTORE_PREPARE, -1, &nr_calls);
+		error = pm_notifier_call_chain_robust(PM_RESTORE_PREPARE, PM_POST_RESTORE);
 		if (!error) {
 			error = create_basic_memory_bitmaps();
 			data->free_bitmaps = !error;
-		} else
-			nr_calls--;
-
-		if (error)
-			__pm_notifier_call_chain(PM_POST_RESTORE, nr_calls, NULL);
+		}
 	}
 	if (error)
 		hibernate_release();
diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index 46ff97e..1bc36a1 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -171,7 +171,7 @@ class SystemValues:
 	tracefuncs = {
 		'sys_sync': {},
 		'ksys_sync': {},
-		'__pm_notifier_call_chain': {},
+		'pm_notifier_call_chain_robust': {},
 		'pm_prepare_console': {},
 		'pm_notifier_call_chain': {},
 		'freeze_processes': {},
