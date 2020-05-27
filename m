Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFA51E3B4D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 May 2020 10:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgE0IMJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 27 May 2020 04:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729585AbgE0IMJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 27 May 2020 04:12:09 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A92DC061A0F;
        Wed, 27 May 2020 01:12:09 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAV-0002i5-GD; Wed, 27 May 2020 10:12:07 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 618E11C04D6;
        Wed, 27 May 2020 10:12:02 +0200 (CEST)
Date:   Wed, 27 May 2020 08:12:02 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] rcu: Abstract out rcu_irq_enter_check_tick() from
 rcu_nmi_enter()
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202116.996113173@linutronix.de>
References: <20200521202116.996113173@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056712225.17951.7903035443251882028.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     aaf2bc50df1f4bfc6857fc601fc7b21d5a18c6a1
Gitweb:        https://git.kernel.org/tip/aaf2bc50df1f4bfc6857fc601fc7b21d5a18c6a1
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 21 May 2020 22:05:15 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:04:18 +02:00

rcu: Abstract out rcu_irq_enter_check_tick() from rcu_nmi_enter()

There will likely be exception handlers that can sleep, which rules
out the usual approach of invoking rcu_nmi_enter() on entry and also
rcu_nmi_exit() on all exit paths.  However, the alternative approach of
just not calling anything can prevent RCU from coaxing quiescent states
from nohz_full CPUs that are looping in the kernel:  RCU must instead
IPI them explicitly.  It would be better to enable the scheduler tick
on such CPUs to interact with RCU in a lighter-weight manner, and this
enabling is one of the things that rcu_nmi_enter() currently does.

What is needed is something that helps RCU coax quiescent states while
not preventing subsequent sleeps.  This commit therefore splits out the
nohz_full scheduler-tick enabling from the rest of the rcu_nmi_enter()
logic into a new function named rcu_irq_enter_check_tick().

[ tglx: Renamed the function and made it a nop when context tracking is off ]
[ mingo: Fixed a CONFIG_NO_HZ_FULL assumption, harmonized and fixed all the
         comment blocks and cleaned up rcu_nmi_enter()/exit() definitions. ]

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200521202116.996113173@linutronix.de
---
 include/linux/hardirq.h | 29 ++++++++------
 kernel/rcu/tree.c       | 82 ++++++++++++++++++++++++++++++----------
 2 files changed, 79 insertions(+), 32 deletions(-)

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 621556e..e07cf85 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -2,31 +2,28 @@
 #ifndef LINUX_HARDIRQ_H
 #define LINUX_HARDIRQ_H
 
+#include <linux/context_tracking_state.h>
 #include <linux/preempt.h>
 #include <linux/lockdep.h>
 #include <linux/ftrace_irq.h>
 #include <linux/vtime.h>
 #include <asm/hardirq.h>
 
-
 extern void synchronize_irq(unsigned int irq);
 extern bool synchronize_hardirq(unsigned int irq);
 
-#if defined(CONFIG_TINY_RCU)
-
-static inline void rcu_nmi_enter(void)
-{
-}
+#ifdef CONFIG_NO_HZ_FULL
+void __rcu_irq_enter_check_tick(void);
+#else
+static inline void __rcu_irq_enter_check_tick(void) { }
+#endif
 
-static inline void rcu_nmi_exit(void)
+static __always_inline void rcu_irq_enter_check_tick(void)
 {
+	if (context_tracking_enabled())
+		__rcu_irq_enter_check_tick();
 }
 
-#else
-extern void rcu_nmi_enter(void);
-extern void rcu_nmi_exit(void);
-#endif
-
 /*
  * It is safe to do non-atomic ops on ->hardirq_context,
  * because NMI handlers may not preempt and the ops are
@@ -65,6 +62,14 @@ extern void irq_exit(void);
 #define arch_nmi_exit()		do { } while (0)
 #endif
 
+#ifdef CONFIG_TINY_RCU
+static inline void rcu_nmi_enter(void) { }
+static inline void rcu_nmi_exit(void) { }
+#else
+extern void rcu_nmi_enter(void);
+extern void rcu_nmi_exit(void);
+#endif
+
 /*
  * NMI vs Tracing
  * --------------
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 90c8be2..b7f8c49 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -848,6 +848,67 @@ void noinstr rcu_user_exit(void)
 {
 	rcu_eqs_exit(1);
 }
+
+/**
+ * __rcu_irq_enter_check_tick - Enable scheduler tick on CPU if RCU needs it.
+ *
+ * The scheduler tick is not normally enabled when CPUs enter the kernel
+ * from nohz_full userspace execution.  After all, nohz_full userspace
+ * execution is an RCU quiescent state and the time executing in the kernel
+ * is quite short.  Except of course when it isn't.  And it is not hard to
+ * cause a large system to spend tens of seconds or even minutes looping
+ * in the kernel, which can cause a number of problems, include RCU CPU
+ * stall warnings.
+ *
+ * Therefore, if a nohz_full CPU fails to report a quiescent state
+ * in a timely manner, the RCU grace-period kthread sets that CPU's
+ * ->rcu_urgent_qs flag with the expectation that the next interrupt or
+ * exception will invoke this function, which will turn on the scheduler
+ * tick, which will enable RCU to detect that CPU's quiescent states,
+ * for example, due to cond_resched() calls in CONFIG_PREEMPT=n kernels.
+ * The tick will be disabled once a quiescent state is reported for
+ * this CPU.
+ *
+ * Of course, in carefully tuned systems, there might never be an
+ * interrupt or exception.  In that case, the RCU grace-period kthread
+ * will eventually cause one to happen.  However, in less carefully
+ * controlled environments, this function allows RCU to get what it
+ * needs without creating otherwise useless interruptions.
+ */
+void __rcu_irq_enter_check_tick(void)
+{
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+
+	 // Enabling the tick is unsafe in NMI handlers.
+	if (WARN_ON_ONCE(in_nmi()))
+		return;
+
+	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
+			 "Illegal rcu_irq_enter_check_tick() from extended quiescent state");
+
+	if (!tick_nohz_full_cpu(rdp->cpu) ||
+	    !READ_ONCE(rdp->rcu_urgent_qs) ||
+	    READ_ONCE(rdp->rcu_forced_tick)) {
+		// RCU doesn't need nohz_full help from this CPU, or it is
+		// already getting that help.
+		return;
+	}
+
+	// We get here only when not in an extended quiescent state and
+	// from interrupts (as opposed to NMIs).  Therefore, (1) RCU is
+	// already watching and (2) The fact that we are in an interrupt
+	// handler and that the rcu_node lock is an irq-disabled lock
+	// prevents self-deadlock.  So we can safely recheck under the lock.
+	// Note that the nohz_full state currently cannot change.
+	raw_spin_lock_rcu_node(rdp->mynode);
+	if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
+		// A nohz_full CPU is in the kernel and RCU needs a
+		// quiescent state.  Turn on the tick!
+		WRITE_ONCE(rdp->rcu_forced_tick, true);
+		tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
+	}
+	raw_spin_unlock_rcu_node(rdp->mynode);
+}
 #endif /* CONFIG_NO_HZ_FULL */
 
 /**
@@ -894,26 +955,7 @@ noinstr void rcu_nmi_enter(void)
 		incby = 1;
 	} else if (!in_nmi()) {
 		instrumentation_begin();
-		if (tick_nohz_full_cpu(rdp->cpu) &&
-		    rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
-		    READ_ONCE(rdp->rcu_urgent_qs) &&
-		    !READ_ONCE(rdp->rcu_forced_tick)) {
-			// We get here only if we had already exited the
-			// extended quiescent state and this was an
-			// interrupt (not an NMI).  Therefore, (1) RCU is
-			// already watching and (2) The fact that we are in
-			// an interrupt handler and that the rcu_node lock
-			// is an irq-disabled lock prevents self-deadlock.
-			// So we can safely recheck under the lock.
-			raw_spin_lock_rcu_node(rdp->mynode);
-			if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
-				// A nohz_full CPU is in the kernel and RCU
-				// needs a quiescent state.  Turn on the tick!
-				WRITE_ONCE(rdp->rcu_forced_tick, true);
-				tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
-			}
-			raw_spin_unlock_rcu_node(rdp->mynode);
-		}
+		rcu_irq_enter_check_tick();
 		instrumentation_end();
 	}
 	instrumentation_begin();
