Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1ED1E3B5A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 May 2020 10:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387778AbgE0IMd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 27 May 2020 04:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbgE0IML (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 27 May 2020 04:12:11 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AABC03E97A;
        Wed, 27 May 2020 01:12:11 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAY-0002gs-1B; Wed, 27 May 2020 10:12:10 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F34861C0805;
        Wed, 27 May 2020 10:12:00 +0200 (CEST)
Date:   Wed, 27 May 2020 08:12:00 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Provide idtentry_entry/exit_cond_rcu()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200515235125.628629605@linutronix.de>
References: <20200515235125.628629605@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056712087.17951.10894256787068855437.tip-bot2@tip-bot2>
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

Commit-ID:     8fbf48a5cdb83a1ae4285920713facef72639641
Gitweb:        https://git.kernel.org/tip/8fbf48a5cdb83a1ae4285920713facef72639641
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:17 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:27 +02:00

x86/entry: Provide idtentry_entry/exit_cond_rcu()

After a lengthy discussion [1] it turned out that RCU does not need a full
rcu_irq_enter/exit() when RCU is already watching. All it needs if
NOHZ_FULL is active is to check whether the tick needs to be restarted.

This allows to avoid a separate variant for the pagefault handler which
cannot invoke rcu_irq_enter() on a kernel pagefault which might sleep.

The cond_rcu argument is only temporary and will be removed once the
existing users of idtentry_enter/exit() have been cleaned up. After that
the code can be significantly simplified.

[ mingo: Simplified the control flow ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: "Paul E. McKenney" <paulmck@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: [1] https://lkml.kernel.org/r/20200515235125.628629605@linutronix.de
Link: https://lore.kernel.org/r/20200521202117.181397835@linutronix.de
---
 arch/x86/entry/common.c         | 79 +++++++++++++++++++++++++-------
 arch/x86/include/asm/idtentry.h | 14 +++++-
 2 files changed, 76 insertions(+), 17 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 9ebe334..a7f5846 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -512,8 +512,10 @@ SYSCALL_DEFINE0(ni_syscall)
 }
 
 /**
- * idtentry_enter - Handle state tracking on idtentry
+ * idtentry_enter_cond_rcu - Handle state tracking on idtentry with conditional
+ *			     RCU handling
  * @regs:	Pointer to pt_regs of interrupted context
+ * @cond_rcu:	Invoke rcu_irq_enter() only if RCU is not watching
  *
  * Invokes:
  *  - lockdep irqflag state tracking as low level ASM entry disabled
@@ -521,40 +523,84 @@ SYSCALL_DEFINE0(ni_syscall)
  *
  *  - Context tracking if the exception hit user mode.
  *
- *  - RCU notification if the exception hit kernel mode.
- *
  *  - The hardirq tracer to keep the state consistent as low level ASM
  *    entry disabled interrupts.
+ *
+ * For kernel mode entries RCU handling is done conditional. If RCU is
+ * watching then the only RCU requirement is to check whether the tick has
+ * to be restarted. If RCU is not watching then rcu_irq_enter() has to be
+ * invoked on entry and rcu_irq_exit() on exit.
+ *
+ * Avoiding the rcu_irq_enter/exit() calls is an optimization but also
+ * solves the problem of kernel mode pagefaults which can schedule, which
+ * is not possible after invoking rcu_irq_enter() without undoing it.
+ *
+ * For user mode entries enter_from_user_mode() must be invoked to
+ * establish the proper context for NOHZ_FULL. Otherwise scheduling on exit
+ * would not be possible.
+ *
+ * Returns: True if RCU has been adjusted on a kernel entry
+ *	    False otherwise
+ *
+ * The return value must be fed into the rcu_exit argument of
+ * idtentry_exit_cond_rcu().
  */
-void noinstr idtentry_enter(struct pt_regs *regs)
+bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs, bool cond_rcu)
 {
 	if (user_mode(regs)) {
 		enter_from_user_mode();
-	} else {
+		return false;
+	}
+
+	if (!cond_rcu || !__rcu_is_watching()) {
+		/*
+		 * If RCU is not watching then the same careful
+		 * sequence vs. lockdep and tracing is required
+		 * as in enter_from_user_mode().
+		 *
+		 * This only happens for IRQs that hit the idle
+		 * loop, i.e. if idle is not using MWAIT.
+		 */
 		lockdep_hardirqs_off(CALLER_ADDR0);
 		rcu_irq_enter();
 		instrumentation_begin();
 		trace_hardirqs_off_prepare();
 		instrumentation_end();
+
+		return true;
 	}
+
+	/*
+	 * If RCU is watching then RCU only wants to check
+	 * whether it needs to restart the tick in NOHZ
+	 * mode.
+	 */
+	instrumentation_begin();
+	rcu_irq_enter_check_tick();
+	/* Use the combo lockdep/tracing function */
+	trace_hardirqs_off();
+	instrumentation_end();
+
+	return false;
 }
 
 /**
- * idtentry_exit - Common code to handle return from exceptions
+ * idtentry_exit_cond_rcu - Handle return from exception with conditional RCU
+ *			    handling
  * @regs:	Pointer to pt_regs (exception entry regs)
+ * @rcu_exit:	Invoke rcu_irq_exit() if true
  *
  * Depending on the return target (kernel/user) this runs the necessary
- * preemption and work checks if possible and required and returns to
+ * preemption and work checks if possible and reguired and returns to
  * the caller with interrupts disabled and no further work pending.
  *
  * This is the last action before returning to the low level ASM code which
  * just needs to return to the appropriate context.
  *
- * Invoked by all exception/interrupt IDTENTRY handlers which are not
- * returning through the paranoid exit path (all except NMI, #DF and the IST
- * variants of #MC and #DB) and are therefore on the thread stack.
+ * Counterpart to idtentry_enter_cond_rcu(). The return value of the entry
+ * function must be fed into the @rcu_exit argument.
  */
-void noinstr idtentry_exit(struct pt_regs *regs)
+void noinstr idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit)
 {
 	lockdep_assert_irqs_disabled();
 
@@ -580,7 +626,8 @@ void noinstr idtentry_exit(struct pt_regs *regs)
 				if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
 					WARN_ON_ONCE(!on_thread_stack());
 				instrumentation_begin();
-				rcu_irq_exit_preempt();
+				if (rcu_exit)
+					rcu_irq_exit_preempt();
 				if (need_resched())
 					preempt_schedule_irq();
 				/* Covers both tracing and lockdep */
@@ -602,10 +649,12 @@ void noinstr idtentry_exit(struct pt_regs *regs)
 		trace_hardirqs_on_prepare();
 		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
 		instrumentation_end();
-		rcu_irq_exit();
+		if (rcu_exit)
+			rcu_irq_exit();
 		lockdep_hardirqs_on(CALLER_ADDR0);
 	} else {
-		/* IRQ flags state is correct already. Just tell RCU */
-		rcu_irq_exit();
+		/* IRQ flags state is correct already. Just tell RCU. */
+		if (rcu_exit)
+			rcu_irq_exit();
 	}
 }
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index ce97478..a116b80 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -7,8 +7,18 @@
 
 #ifndef __ASSEMBLY__
 
-void idtentry_enter(struct pt_regs *regs);
-void idtentry_exit(struct pt_regs *regs);
+bool idtentry_enter_cond_rcu(struct pt_regs *regs, bool cond_rcu);
+void idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit);
+
+static __always_inline void idtentry_enter(struct pt_regs *regs)
+{
+	idtentry_enter_cond_rcu(regs, false);
+}
+
+static __always_inline void idtentry_exit(struct pt_regs *regs)
+{
+	idtentry_exit_cond_rcu(regs, true);
+}
 
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
