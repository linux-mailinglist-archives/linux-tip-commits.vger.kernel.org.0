Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C873B83EC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbhF3NvV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:51:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33002 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbhF3Nud (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:33 -0400
Date:   Wed, 30 Jun 2021 13:47:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AvbNoO08H5pwhhz5Y7dPaasvYCvGDNhaEo0vi5PJhKk=;
        b=UDVcgw6xsCEi11W3BLVACyAf3W8bRlfZqxvaXK8X7d/YAzGQCXrxWVI/Gv9h71C8QEbT/h
        9Ao5oGhDZrDR2+Ht9RyLN2t7W+fcJ1B0wO5OggU0DhmzvyCACLRWXXiweYC2GFXbAB9Q6S
        Yd1R45C+jQzl9GMHEWCeLi9HTE/i9F1uKuMV5achhUVu7s41xAx2bBxQSTLP9k3mEaIJ1Z
        TynY7ieyNVUy4I3Sxuya1PeT3TNIueQxNPSejBZvu2kh7efo7AESigkFkyvnQjdchjH2CZ
        Vm9cVYXz7XO7LUNy1e3lXHC7rZJNsTVVz3OjhHGy9MF4Zu/iKb7xXMvROeZRQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060873;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AvbNoO08H5pwhhz5Y7dPaasvYCvGDNhaEo0vi5PJhKk=;
        b=tH13k4aLAHYHdhw7ID8ujOaGTnoV5npqOJHFjhN5TIXSXGlYzmfFAy3lTYt7HWOGU4lDts
        hmEgFIlwFV46h7CQ==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] srcu: Initialize SRCU after timers
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506087280.395.12815858248735278249.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     8e9c01c717df7e05c5bd1ca86aaa3a74b31f37f1
Gitweb:        https://git.kernel.org/tip/8e9c01c717df7e05c5bd1ca86aaa3a74b31f37f1
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 09 Apr 2021 00:38:59 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:03:35 -07:00

srcu: Initialize SRCU after timers

Once srcu_init() is called, the SRCU core will make use of delayed
workqueues, which rely on timers.  However init_timers() is called
several steps after rcu_init().  This means that a call_srcu() after
rcu_init() but before init_timers() would find itself within a dangerously
uninitialized timer core.

This commit therefore creates a separate call to srcu_init() after
init_timer() completes, which ensures that we stay in early SRCU mode
until timers are safe(r).

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcu.h  | 6 ++++++
 init/main.c           | 2 ++
 kernel/rcu/rcu.h      | 6 ------
 kernel/rcu/srcutree.c | 5 +++++
 kernel/rcu/tiny.c     | 1 -
 kernel/rcu/tree.c     | 1 -
 6 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index a0895bb..e6011a9 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -64,6 +64,12 @@ unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp);
 unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp);
 bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie);
 
+#ifdef CONFIG_SRCU
+void srcu_init(void);
+#else /* #ifdef CONFIG_SRCU */
+static inline void srcu_init(void) { }
+#endif /* #else #ifdef CONFIG_SRCU */
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
 /**
diff --git a/init/main.c b/init/main.c
index eb01e12..7b6f49c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -42,6 +42,7 @@
 #include <linux/profile.h>
 #include <linux/kfence.h>
 #include <linux/rcupdate.h>
+#include <linux/srcu.h>
 #include <linux/moduleparam.h>
 #include <linux/kallsyms.h>
 #include <linux/writeback.h>
@@ -979,6 +980,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	tick_init();
 	rcu_init_nohz();
 	init_timers();
+	srcu_init();
 	hrtimers_init();
 	softirq_init();
 	timekeeping_init();
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index bf0827d..ca3f2af 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -422,12 +422,6 @@ do {									\
 
 #endif /* #if defined(CONFIG_SRCU) || !defined(CONFIG_TINY_RCU) */
 
-#ifdef CONFIG_SRCU
-void srcu_init(void);
-#else /* #ifdef CONFIG_SRCU */
-static inline void srcu_init(void) { }
-#endif /* #else #ifdef CONFIG_SRCU */
-
 #ifdef CONFIG_TINY_RCU
 /* Tiny RCU doesn't expedite, as its purpose in life is instead to be tiny. */
 static inline bool rcu_gp_is_normal(void) { return true; }
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index f4f0cbf..9ec35c1 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1384,6 +1384,11 @@ void __init srcu_init(void)
 {
 	struct srcu_struct *ssp;
 
+	/*
+	 * Once that is set, call_srcu() can follow the normal path and
+	 * queue delayed work. This must follow RCU workqueues creation
+	 * and timers initialization.
+	 */
 	srcu_init_done = true;
 	while (!list_empty(&srcu_boot_list)) {
 		ssp = list_first_entry(&srcu_boot_list, struct srcu_struct,
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index c8a029f..340b3f8 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -221,5 +221,4 @@ void __init rcu_init(void)
 {
 	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
 	rcu_early_boot_tests();
-	srcu_init();
 }
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8e78b24..c35b152 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4735,7 +4735,6 @@ void __init rcu_init(void)
 	WARN_ON(!rcu_gp_wq);
 	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!rcu_par_gp_wq);
-	srcu_init();
 
 	/* Fill in default value for rcutree.qovld boot parameter. */
 	/* -After- the rcu_node ->lock fields are initialized! */
