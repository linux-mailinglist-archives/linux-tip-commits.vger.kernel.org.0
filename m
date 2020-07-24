Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A840322CF24
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Jul 2020 22:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGXULm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 24 Jul 2020 16:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgGXULl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 24 Jul 2020 16:11:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A903C0619E4;
        Fri, 24 Jul 2020 13:11:41 -0700 (PDT)
Date:   Fri, 24 Jul 2020 20:11:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595621499;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QEw8x1X0AeiW3L3FJag4/Lccp+nsgi61AQcN9AJSSek=;
        b=4rgt62GcAVgb4coC9KOviLIh8qILhMCwsiQTwOOFTgmEDXuZTw0E/4tZir1v+Vnpij3kqd
        ZUrGdzHhu46Gy1ZDIKolwzMGdskew3oKfjaTBYxZS56JuPTj0EZTgFeNutWKFG2/q6xz3h
        WZd5IQEUgkZMWWj+/22TFF/Z1pX7VJnYjhtFWurDAhTdPqx/3v7PLKqKDIDF6v5mj5Xg2p
        BUrDUkRVyPHUGi3Gdo7wYRfSp5aiF6NmpasT1snKb9rrS8OIhkkVRbaktSR/WEhR9GKWKk
        T8NRXCrUOMzP9Gyk/tIKkjLrqJEUvxJSQvBI8XHmu23Ggt+4h4kRSIb+WeFxrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595621499;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QEw8x1X0AeiW3L3FJag4/Lccp+nsgi61AQcN9AJSSek=;
        b=d7UwQII1BgW9DPWIwbkJWD9g6zVJHuM02fmUnaAliclHZamHn6cgQKDWHmGl4x0aadw6tM
        JJWZ2bl4FJ6qByDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Use generic interrupt entry/exit code
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200722220520.711492752@linutronix.de>
References: <20200722220520.711492752@linutronix.de>
MIME-Version: 1.0
Message-ID: <159562149894.4006.3658443105395747761.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     bdcd178ada90d2413bcc9df4211dcdd511a47586
Gitweb:        https://git.kernel.org/tip/bdcd178ada90d2413bcc9df4211dcdd511a47586
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 23 Jul 2020 00:00:07 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Jul 2020 15:05:00 +02:00

x86/entry: Use generic interrupt entry/exit code

Replace the x86 code with the generic variant. Use temporary defines for
idtentry_* which will be cleaned up in the next step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200722220520.711492752@linutronix.de


---
 arch/x86/entry/common.c         | 167 +-------------------------------
 arch/x86/include/asm/idtentry.h |  10 +--
 2 files changed, 5 insertions(+), 172 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index bc96eb8..297e08e 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -198,171 +198,6 @@ SYSCALL_DEFINE0(ni_syscall)
 	return -ENOSYS;
 }
 
-/**
- * idtentry_enter - Handle state tracking on ordinary idtentries
- * @regs:	Pointer to pt_regs of interrupted context
- *
- * Invokes:
- *  - lockdep irqflag state tracking as low level ASM entry disabled
- *    interrupts.
- *
- *  - Context tracking if the exception hit user mode.
- *
- *  - The hardirq tracer to keep the state consistent as low level ASM
- *    entry disabled interrupts.
- *
- * As a precondition, this requires that the entry came from user mode,
- * idle, or a kernel context in which RCU is watching.
- *
- * For kernel mode entries RCU handling is done conditional. If RCU is
- * watching then the only RCU requirement is to check whether the tick has
- * to be restarted. If RCU is not watching then rcu_irq_enter() has to be
- * invoked on entry and rcu_irq_exit() on exit.
- *
- * Avoiding the rcu_irq_enter/exit() calls is an optimization but also
- * solves the problem of kernel mode pagefaults which can schedule, which
- * is not possible after invoking rcu_irq_enter() without undoing it.
- *
- * For user mode entries irqentry_enter_from_user_mode() must be invoked to
- * establish the proper context for NOHZ_FULL. Otherwise scheduling on exit
- * would not be possible.
- *
- * Returns: An opaque object that must be passed to idtentry_exit()
- *
- * The return value must be fed into the state argument of
- * idtentry_exit().
- */
-idtentry_state_t noinstr idtentry_enter(struct pt_regs *regs)
-{
-	idtentry_state_t ret = {
-		.exit_rcu = false,
-	};
-
-	if (user_mode(regs)) {
-		irqentry_enter_from_user_mode(regs);
-		return ret;
-	}
-
-	/*
-	 * If this entry hit the idle task invoke rcu_irq_enter() whether
-	 * RCU is watching or not.
-	 *
-	 * Interupts can nest when the first interrupt invokes softirq
-	 * processing on return which enables interrupts.
-	 *
-	 * Scheduler ticks in the idle task can mark quiescent state and
-	 * terminate a grace period, if and only if the timer interrupt is
-	 * not nested into another interrupt.
-	 *
-	 * Checking for __rcu_is_watching() here would prevent the nesting
-	 * interrupt to invoke rcu_irq_enter(). If that nested interrupt is
-	 * the tick then rcu_flavor_sched_clock_irq() would wrongfully
-	 * assume that it is the first interupt and eventually claim
-	 * quiescient state and end grace periods prematurely.
-	 *
-	 * Unconditionally invoke rcu_irq_enter() so RCU state stays
-	 * consistent.
-	 *
-	 * TINY_RCU does not support EQS, so let the compiler eliminate
-	 * this part when enabled.
-	 */
-	if (!IS_ENABLED(CONFIG_TINY_RCU) && is_idle_task(current)) {
-		/*
-		 * If RCU is not watching then the same careful
-		 * sequence vs. lockdep and tracing is required
-		 * as in irqentry_enter_from_user_mode().
-		 */
-		lockdep_hardirqs_off(CALLER_ADDR0);
-		rcu_irq_enter();
-		instrumentation_begin();
-		trace_hardirqs_off_finish();
-		instrumentation_end();
-
-		ret.exit_rcu = true;
-		return ret;
-	}
-
-	/*
-	 * If RCU is watching then RCU only wants to check whether it needs
-	 * to restart the tick in NOHZ mode. rcu_irq_enter_check_tick()
-	 * already contains a warning when RCU is not watching, so no point
-	 * in having another one here.
-	 */
-	instrumentation_begin();
-	rcu_irq_enter_check_tick();
-	/* Use the combo lockdep/tracing function */
-	trace_hardirqs_off();
-	instrumentation_end();
-
-	return ret;
-}
-
-static void idtentry_exit_cond_resched(struct pt_regs *regs, bool may_sched)
-{
-	if (may_sched && !preempt_count()) {
-		/* Sanity check RCU and thread stack */
-		rcu_irq_exit_check_preempt();
-		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
-			WARN_ON_ONCE(!on_thread_stack());
-		if (need_resched())
-			preempt_schedule_irq();
-	}
-	/* Covers both tracing and lockdep */
-	trace_hardirqs_on();
-}
-
-/**
- * idtentry_exit - Handle return from exception that used idtentry_enter()
- * @regs:	Pointer to pt_regs (exception entry regs)
- * @state:	Return value from matching call to idtentry_enter()
- *
- * Depending on the return target (kernel/user) this runs the necessary
- * preemption and work checks if possible and reguired and returns to
- * the caller with interrupts disabled and no further work pending.
- *
- * This is the last action before returning to the low level ASM code which
- * just needs to return to the appropriate context.
- *
- * Counterpart to idtentry_enter(). The return value of the entry
- * function must be fed into the @state argument.
- */
-void noinstr idtentry_exit(struct pt_regs *regs, idtentry_state_t state)
-{
-	lockdep_assert_irqs_disabled();
-
-	/* Check whether this returns to user mode */
-	if (user_mode(regs)) {
-		irqentry_exit_to_user_mode(regs);
-	} else if (regs->flags & X86_EFLAGS_IF) {
-		/*
-		 * If RCU was not watching on entry this needs to be done
-		 * carefully and needs the same ordering of lockdep/tracing
-		 * and RCU as the return to user mode path.
-		 */
-		if (state.exit_rcu) {
-			instrumentation_begin();
-			/* Tell the tracer that IRET will enable interrupts */
-			trace_hardirqs_on_prepare();
-			lockdep_hardirqs_on_prepare(CALLER_ADDR0);
-			instrumentation_end();
-			rcu_irq_exit();
-			lockdep_hardirqs_on(CALLER_ADDR0);
-			return;
-		}
-
-		instrumentation_begin();
-		idtentry_exit_cond_resched(regs, IS_ENABLED(CONFIG_PREEMPTION));
-		instrumentation_end();
-	} else {
-		/*
-		 * IRQ flags state is correct already. Just tell RCU if it
-		 * was not watching on entry.
-		 */
-		if (state.exit_rcu)
-			rcu_irq_exit();
-	}
-}
-
 #ifdef CONFIG_XEN_PV
 #ifndef CONFIG_PREEMPTION
 /*
@@ -427,7 +262,7 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 	inhcall = get_and_clear_inhcall();
 	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
 		instrumentation_begin();
-		idtentry_exit_cond_resched(regs, true);
+		irqentry_exit_cond_resched();
 		instrumentation_end();
 		restore_inhcall(inhcall);
 	} else {
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index bf59f72..621e25d 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -11,12 +11,10 @@
 
 #include <asm/irq_stack.h>
 
-typedef struct idtentry_state {
-	bool exit_rcu;
-} idtentry_state_t;
-
-idtentry_state_t idtentry_enter(struct pt_regs *regs);
-void idtentry_exit(struct pt_regs *regs, idtentry_state_t state);
+/* Temporary defines */
+typedef irqentry_state_t idtentry_state_t;
+#define idtentry_enter irqentry_enter
+#define idtentry_exit irqentry_exit
 
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
