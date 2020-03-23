Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34C7318FBDA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Mar 2020 18:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgCWRuX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Mar 2020 13:50:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42245 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgCWRuX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Mar 2020 13:50:23 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGRDK-0003k0-8t; Mon, 23 Mar 2020 18:50:14 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C96AD1C0470;
        Mon, 23 Mar 2020 18:50:13 +0100 (CET)
Date:   Mon, 23 Mar 2020 17:50:13 -0000
From:   "tip-bot2 for Sebastian Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] completion: Use
 lockdep_assert_RT_in_threaded_ctx() in complete_all()
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200323152019.4qjwluldohuh3by5@linutronix.de>
References: <20200323152019.4qjwluldohuh3by5@linutronix.de>
MIME-Version: 1.0
Message-ID: <158498581343.28353.9984368947985225939.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8bf6c677ddb9c922423ea3bf494fe7c508bfbb8c
Gitweb:        https://git.kernel.org/tip/8bf6c677ddb9c922423ea3bf494fe7c508bfbb8c
Author:        Sebastian Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 23 Mar 2020 16:20:19 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Mar 2020 18:40:25 +01:00

completion: Use lockdep_assert_RT_in_threaded_ctx() in complete_all()

The warning was intended to spot complete_all() users from hardirq
context on PREEMPT_RT. The warning as-is will also trigger in interrupt
handlers, which are threaded on PREEMPT_RT, which was not intended.

Use lockdep_assert_RT_in_threaded_ctx() which triggers in non-preemptive
context on PREEMPT_RT.

Fixes: a5c6234e1028 ("completion: Use simple wait queues")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200323152019.4qjwluldohuh3by5@linutronix.de
---
 include/linux/lockdep.h   | 15 +++++++++++++++
 kernel/sched/completion.c |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 425b4ce..206774a 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -711,6 +711,21 @@ do {									\
 # define lockdep_assert_in_irq() do { } while (0)
 #endif
 
+#ifdef CONFIG_PROVE_RAW_LOCK_NESTING
+
+# define lockdep_assert_RT_in_threaded_ctx() do {			\
+		WARN_ONCE(debug_locks && !current->lockdep_recursion &&	\
+			  current->hardirq_context &&			\
+			  !(current->hardirq_threaded || current->irq_config),	\
+			  "Not in threaded context on PREEMPT_RT as expected\n");	\
+} while (0)
+
+#else
+
+# define lockdep_assert_RT_in_threaded_ctx() do { } while (0)
+
+#endif
+
 #ifdef CONFIG_LOCKDEP
 void lockdep_rcu_suspicious(const char *file, const int line, const char *s);
 #else
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index f15e961..a778554 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -58,7 +58,7 @@ void complete_all(struct completion *x)
 {
 	unsigned long flags;
 
-	WARN_ON(irqs_disabled());
+	lockdep_assert_RT_in_threaded_ctx();
 
 	raw_spin_lock_irqsave(&x->wait.lock, flags);
 	x->done = UINT_MAX;
