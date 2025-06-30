Return-Path: <linux-tip-commits+bounces-5957-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 098F5AEE665
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 20:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A201A7A318E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Jun 2025 18:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6117728FABC;
	Mon, 30 Jun 2025 18:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bpstch1R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vcxMkuv1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3D61B5EB5;
	Mon, 30 Jun 2025 18:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306625; cv=none; b=Mm0PAzo4O0ebXLnkQDrSKuP7SysBS8TGrBawHS7O4AYYhT+DYffv4BDgX2Je/fAhrO5IkVL2tys65tYPdGI3v4K0CY6TgsCdwx3PtPix2SGZyZYgSGP8oeVhC/UQGqwxnDBWUTPyodmtvR5Va/Le5JYDadBtRtKGOTRk5DBTT7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306625; c=relaxed/simple;
	bh=ukmKIlifngU/qoZx7Zeb10QRRZWM4mWg3BzHzwM4ZmA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q6Scr7L0XugyX/bBW7sOZjvfchRgUHQ6oIt7E6FW+FBLRJ/FWdReJlYPLFCF8niXwoIczGXkitxMqSHWJf0IO5Hg7eFem9VTsgLgtFmhZh//5cKwhuNOf4Wq4t4jlBIeXj45CQVC6/kv52JdPyTcRGliHs3yOHuIQhuRtQrwbbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bpstch1R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vcxMkuv1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 30 Jun 2025 18:03:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751306618;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UvBtZtfpKROjnPh28J5WsAGbFLGT5jdWGGRs2ZnLLHg=;
	b=bpstch1RRuxP6fRawtlk45bSNXMvfrdJpIscmLHqbOWMQD1wdo0zwfvY7lNQA4GUUpM79f
	7+TSmIIqGqsNfwKoaE0u0ul8S9/ZPGTRNfepUg+tNnO9DE0wK2R/LjsfpphWAd1m+zrYK9
	6+B9X7XvrJn6SVWmRGs6COrckv2t1oolA5TOTu/Jlxhqid72M8isZE1crbKH4Y8CMrRGg9
	vWiVGedmBNyp65qspA8vaMft29v+fNHvyDxL5RuDsqJGXCt814xoAROwUJ6Hce1IItTgAP
	Ht2Pnt6nJD9CYiPIZMIlNNsMRyWlu1etcr3HJAczdEbf/k6cdEjZhgcmwJrZuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751306618;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UvBtZtfpKROjnPh28J5WsAGbFLGT5jdWGGRs2ZnLLHg=;
	b=vcxMkuv1n1QDmYezHlW9/Lmr0dbVCLWK/9f/6MA7f/6YJrFRQ2BAcQbNQYG3mGyHVPVHUW
	s+UZe2S6tpbB3rDQ==
From: "tip-bot2 for Jinjie Ruan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Split generic entry into generic exception
 and syscall entry
Cc: Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250624-generic-entry-split-v1-1-53d5ef4f94df@linaro.org>
References: <20250624-generic-entry-split-v1-1-53d5ef4f94df@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175130661695.406.8700048517209243844.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     a70e9f647f501e36a6a092888b1ea7386b7c5664
Gitweb:        https://git.kernel.org/tip/a70e9f647f501e36a6a092888b1ea7386b7c5664
Author:        Jinjie Ruan <ruanjinjie@huawei.com>
AuthorDate:    Tue, 24 Jun 2025 20:35:56 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 30 Jun 2025 19:52:55 +02:00

entry: Split generic entry into generic exception and syscall entry

Currently CONFIG_GENERIC_ENTRY enables both the generic exception
entry logic and the generic syscall entry logic, which are otherwise
loosely coupled.

Introduce separate config options for these so that architectures can
select the two independently. This will make it easier for
architectures to migrate to generic entry code.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/20250213130007.1418890-2-ruanjinjie@huawei.com
Link: https://lore.kernel.org/all/20250624-generic-entry-split-v1-1-53d5ef4f94df@linaro.org

[Linus Walleij: rebase onto v6.16-rc1]
---
 MAINTAINERS                      |   1 +-
 arch/Kconfig                     |   9 +-
 include/linux/entry-common.h     | 382 +-----------------------------
 include/linux/irq-entry-common.h | 389 ++++++++++++++++++++++++++++++-
 kernel/entry/Makefile            |   3 +-
 kernel/entry/common.c            | 113 +---------
 kernel/entry/syscall-common.c    | 112 +++++++++-
 kernel/sched/core.c              |   8 +-
 8 files changed, 519 insertions(+), 498 deletions(-)
 create mode 100644 include/linux/irq-entry-common.h
 create mode 100644 kernel/entry/syscall-common.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a92290f..e92292a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10052,6 +10052,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry
 F:	include/linux/entry-common.h
 F:	include/linux/entry-kvm.h
+F:	include/linux/irq-entry-common.h
 F:	kernel/entry/
 
 GENERIC GPIO I2C DRIVER
diff --git a/arch/Kconfig b/arch/Kconfig
index a3308a2..9233fbf 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -64,8 +64,17 @@ config HOTPLUG_PARALLEL
 	bool
 	select HOTPLUG_SPLIT_STARTUP
 
+config GENERIC_IRQ_ENTRY
+	bool
+
+config GENERIC_SYSCALL
+	bool
+	depends on GENERIC_IRQ_ENTRY
+
 config GENERIC_ENTRY
 	bool
+	select GENERIC_IRQ_ENTRY
+	select GENERIC_SYSCALL
 
 config KPROBES
 	bool "Kprobes"
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index f94f3fd..7177436 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -2,28 +2,16 @@
 #ifndef __LINUX_ENTRYCOMMON_H
 #define __LINUX_ENTRYCOMMON_H
 
-#include <linux/static_call_types.h>
+#include <linux/irq-entry-common.h>
 #include <linux/ptrace.h>
-#include <linux/syscalls.h>
 #include <linux/seccomp.h>
 #include <linux/sched.h>
-#include <linux/context_tracking.h>
 #include <linux/livepatch.h>
 #include <linux/resume_user_mode.h>
-#include <linux/tick.h>
-#include <linux/kmsan.h>
 
 #include <asm/entry-common.h>
 #include <asm/syscall.h>
 
-/*
- * Define dummy _TIF work flags if not defined by the architecture or for
- * disabled functionality.
- */
-#ifndef _TIF_PATCH_PENDING
-# define _TIF_PATCH_PENDING		(0)
-#endif
-
 #ifndef _TIF_UPROBE
 # define _TIF_UPROBE			(0)
 #endif
@@ -56,69 +44,6 @@
 				 SYSCALL_WORK_SYSCALL_EXIT_TRAP	|	\
 				 ARCH_SYSCALL_WORK_EXIT)
 
-/*
- * TIF flags handled in exit_to_user_mode_loop()
- */
-#ifndef ARCH_EXIT_TO_USER_MODE_WORK
-# define ARCH_EXIT_TO_USER_MODE_WORK		(0)
-#endif
-
-#define EXIT_TO_USER_MODE_WORK						\
-	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
-	 _TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY |			\
-	 _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |			\
-	 ARCH_EXIT_TO_USER_MODE_WORK)
-
-/**
- * arch_enter_from_user_mode - Architecture specific sanity check for user mode regs
- * @regs:	Pointer to currents pt_regs
- *
- * Defaults to an empty implementation. Can be replaced by architecture
- * specific code.
- *
- * Invoked from syscall_enter_from_user_mode() in the non-instrumentable
- * section. Use __always_inline so the compiler cannot push it out of line
- * and make it instrumentable.
- */
-static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs);
-
-#ifndef arch_enter_from_user_mode
-static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs) {}
-#endif
-
-/**
- * enter_from_user_mode - Establish state when coming from user mode
- *
- * Syscall/interrupt entry disables interrupts, but user mode is traced as
- * interrupts enabled. Also with NO_HZ_FULL RCU might be idle.
- *
- * 1) Tell lockdep that interrupts are disabled
- * 2) Invoke context tracking if enabled to reactivate RCU
- * 3) Trace interrupts off state
- *
- * Invoked from architecture specific syscall entry code with interrupts
- * disabled. The calling code has to be non-instrumentable. When the
- * function returns all state is correct and interrupts are still
- * disabled. The subsequent functions can be instrumented.
- *
- * This is invoked when there is architecture specific functionality to be
- * done between establishing state and enabling interrupts. The caller must
- * enable interrupts before invoking syscall_enter_from_user_mode_work().
- */
-static __always_inline void enter_from_user_mode(struct pt_regs *regs)
-{
-	arch_enter_from_user_mode(regs);
-	lockdep_hardirqs_off(CALLER_ADDR0);
-
-	CT_WARN_ON(__ct_state() != CT_STATE_USER);
-	user_exit_irqoff();
-
-	instrumentation_begin();
-	kmsan_unpoison_entry_regs(regs);
-	trace_hardirqs_off_finish();
-	instrumentation_end();
-}
-
 /**
  * syscall_enter_from_user_mode_prepare - Establish state and enable interrupts
  * @regs:	Pointer to currents pt_regs
@@ -204,170 +129,6 @@ static __always_inline long syscall_enter_from_user_mode(struct pt_regs *regs, l
 }
 
 /**
- * local_irq_enable_exit_to_user - Exit to user variant of local_irq_enable()
- * @ti_work:	Cached TIF flags gathered with interrupts disabled
- *
- * Defaults to local_irq_enable(). Can be supplied by architecture specific
- * code.
- */
-static inline void local_irq_enable_exit_to_user(unsigned long ti_work);
-
-#ifndef local_irq_enable_exit_to_user
-static inline void local_irq_enable_exit_to_user(unsigned long ti_work)
-{
-	local_irq_enable();
-}
-#endif
-
-/**
- * local_irq_disable_exit_to_user - Exit to user variant of local_irq_disable()
- *
- * Defaults to local_irq_disable(). Can be supplied by architecture specific
- * code.
- */
-static inline void local_irq_disable_exit_to_user(void);
-
-#ifndef local_irq_disable_exit_to_user
-static inline void local_irq_disable_exit_to_user(void)
-{
-	local_irq_disable();
-}
-#endif
-
-/**
- * arch_exit_to_user_mode_work - Architecture specific TIF work for exit
- *				 to user mode.
- * @regs:	Pointer to currents pt_regs
- * @ti_work:	Cached TIF flags gathered with interrupts disabled
- *
- * Invoked from exit_to_user_mode_loop() with interrupt enabled
- *
- * Defaults to NOOP. Can be supplied by architecture specific code.
- */
-static inline void arch_exit_to_user_mode_work(struct pt_regs *regs,
-					       unsigned long ti_work);
-
-#ifndef arch_exit_to_user_mode_work
-static inline void arch_exit_to_user_mode_work(struct pt_regs *regs,
-					       unsigned long ti_work)
-{
-}
-#endif
-
-/**
- * arch_exit_to_user_mode_prepare - Architecture specific preparation for
- *				    exit to user mode.
- * @regs:	Pointer to currents pt_regs
- * @ti_work:	Cached TIF flags gathered with interrupts disabled
- *
- * Invoked from exit_to_user_mode_prepare() with interrupt disabled as the last
- * function before return. Defaults to NOOP.
- */
-static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
-						  unsigned long ti_work);
-
-#ifndef arch_exit_to_user_mode_prepare
-static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
-						  unsigned long ti_work)
-{
-}
-#endif
-
-/**
- * arch_exit_to_user_mode - Architecture specific final work before
- *			    exit to user mode.
- *
- * Invoked from exit_to_user_mode() with interrupt disabled as the last
- * function before return. Defaults to NOOP.
- *
- * This needs to be __always_inline because it is non-instrumentable code
- * invoked after context tracking switched to user mode.
- *
- * An architecture implementation must not do anything complex, no locking
- * etc. The main purpose is for speculation mitigations.
- */
-static __always_inline void arch_exit_to_user_mode(void);
-
-#ifndef arch_exit_to_user_mode
-static __always_inline void arch_exit_to_user_mode(void) { }
-#endif
-
-/**
- * arch_do_signal_or_restart -  Architecture specific signal delivery function
- * @regs:	Pointer to currents pt_regs
- *
- * Invoked from exit_to_user_mode_loop().
- */
-void arch_do_signal_or_restart(struct pt_regs *regs);
-
-/**
- * exit_to_user_mode_loop - do any pending work before leaving to user space
- */
-unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-				     unsigned long ti_work);
-
-/**
- * exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
- * @regs:	Pointer to pt_regs on entry stack
- *
- * 1) check that interrupts are disabled
- * 2) call tick_nohz_user_enter_prepare()
- * 3) call exit_to_user_mode_loop() if any flags from
- *    EXIT_TO_USER_MODE_WORK are set
- * 4) check that interrupts are still disabled
- */
-static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
-{
-	unsigned long ti_work;
-
-	lockdep_assert_irqs_disabled();
-
-	/* Flush pending rcuog wakeup before the last need_resched() check */
-	tick_nohz_user_enter_prepare();
-
-	ti_work = read_thread_flags();
-	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
-		ti_work = exit_to_user_mode_loop(regs, ti_work);
-
-	arch_exit_to_user_mode_prepare(regs, ti_work);
-
-	/* Ensure that kernel state is sane for a return to userspace */
-	kmap_assert_nomap();
-	lockdep_assert_irqs_disabled();
-	lockdep_sys_exit();
-}
-
-/**
- * exit_to_user_mode - Fixup state when exiting to user mode
- *
- * Syscall/interrupt exit enables interrupts, but the kernel state is
- * interrupts disabled when this is invoked. Also tell RCU about it.
- *
- * 1) Trace interrupts on state
- * 2) Invoke context tracking if enabled to adjust RCU state
- * 3) Invoke architecture specific last minute exit code, e.g. speculation
- *    mitigations, etc.: arch_exit_to_user_mode()
- * 4) Tell lockdep that interrupts are enabled
- *
- * Invoked from architecture specific code when syscall_exit_to_user_mode()
- * is not suitable as the last step before returning to userspace. Must be
- * invoked with interrupts disabled and the caller must be
- * non-instrumentable.
- * The caller has to invoke syscall_exit_to_user_mode_work() before this.
- */
-static __always_inline void exit_to_user_mode(void)
-{
-	instrumentation_begin();
-	trace_hardirqs_on_prepare();
-	lockdep_hardirqs_on_prepare();
-	instrumentation_end();
-
-	user_enter_irqoff();
-	arch_exit_to_user_mode();
-	lockdep_hardirqs_on(CALLER_ADDR0);
-}
-
-/**
  * syscall_exit_work - Handle work before returning to user mode
  * @regs:	Pointer to current pt_regs
  * @work:	Current thread syscall work
@@ -451,145 +212,4 @@ static __always_inline void syscall_exit_to_user_mode(struct pt_regs *regs)
 	exit_to_user_mode();
 }
 
-/**
- * irqentry_enter_from_user_mode - Establish state before invoking the irq handler
- * @regs:	Pointer to currents pt_regs
- *
- * Invoked from architecture specific entry code with interrupts disabled.
- * Can only be called when the interrupt entry came from user mode. The
- * calling code must be non-instrumentable.  When the function returns all
- * state is correct and the subsequent functions can be instrumented.
- *
- * The function establishes state (lockdep, RCU (context tracking), tracing)
- */
-void irqentry_enter_from_user_mode(struct pt_regs *regs);
-
-/**
- * irqentry_exit_to_user_mode - Interrupt exit work
- * @regs:	Pointer to current's pt_regs
- *
- * Invoked with interrupts disabled and fully valid regs. Returns with all
- * work handled, interrupts disabled such that the caller can immediately
- * switch to user mode. Called from architecture specific interrupt
- * handling code.
- *
- * The call order is #2 and #3 as described in syscall_exit_to_user_mode().
- * Interrupt exit is not invoking #1 which is the syscall specific one time
- * work.
- */
-void irqentry_exit_to_user_mode(struct pt_regs *regs);
-
-#ifndef irqentry_state
-/**
- * struct irqentry_state - Opaque object for exception state storage
- * @exit_rcu: Used exclusively in the irqentry_*() calls; signals whether the
- *            exit path has to invoke ct_irq_exit().
- * @lockdep: Used exclusively in the irqentry_nmi_*() calls; ensures that
- *           lockdep state is restored correctly on exit from nmi.
- *
- * This opaque object is filled in by the irqentry_*_enter() functions and
- * must be passed back into the corresponding irqentry_*_exit() functions
- * when the exception is complete.
- *
- * Callers of irqentry_*_[enter|exit]() must consider this structure opaque
- * and all members private.  Descriptions of the members are provided to aid in
- * the maintenance of the irqentry_*() functions.
- */
-typedef struct irqentry_state {
-	union {
-		bool	exit_rcu;
-		bool	lockdep;
-	};
-} irqentry_state_t;
-#endif
-
-/**
- * irqentry_enter - Handle state tracking on ordinary interrupt entries
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
- * to be restarted. If RCU is not watching then ct_irq_enter() has to be
- * invoked on entry and ct_irq_exit() on exit.
- *
- * Avoiding the ct_irq_enter/exit() calls is an optimization but also
- * solves the problem of kernel mode pagefaults which can schedule, which
- * is not possible after invoking ct_irq_enter() without undoing it.
- *
- * For user mode entries irqentry_enter_from_user_mode() is invoked to
- * establish the proper context for NOHZ_FULL. Otherwise scheduling on exit
- * would not be possible.
- *
- * Returns: An opaque object that must be passed to idtentry_exit()
- */
-irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
-
-/**
- * irqentry_exit_cond_resched - Conditionally reschedule on return from interrupt
- *
- * Conditional reschedule with additional sanity checks.
- */
-void raw_irqentry_exit_cond_resched(void);
-#ifdef CONFIG_PREEMPT_DYNAMIC
-#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
-#define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_resched
-#define irqentry_exit_cond_resched_dynamic_disabled	NULL
-DECLARE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
-#define irqentry_exit_cond_resched()	static_call(irqentry_exit_cond_resched)()
-#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
-DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
-void dynamic_irqentry_exit_cond_resched(void);
-#define irqentry_exit_cond_resched()	dynamic_irqentry_exit_cond_resched()
-#endif
-#else /* CONFIG_PREEMPT_DYNAMIC */
-#define irqentry_exit_cond_resched()	raw_irqentry_exit_cond_resched()
-#endif /* CONFIG_PREEMPT_DYNAMIC */
-
-/**
- * irqentry_exit - Handle return from exception that used irqentry_enter()
- * @regs:	Pointer to pt_regs (exception entry regs)
- * @state:	Return value from matching call to irqentry_enter()
- *
- * Depending on the return target (kernel/user) this runs the necessary
- * preemption and work checks if possible and required and returns to
- * the caller with interrupts disabled and no further work pending.
- *
- * This is the last action before returning to the low level ASM code which
- * just needs to return to the appropriate context.
- *
- * Counterpart to irqentry_enter().
- */
-void noinstr irqentry_exit(struct pt_regs *regs, irqentry_state_t state);
-
-/**
- * irqentry_nmi_enter - Handle NMI entry
- * @regs:	Pointer to currents pt_regs
- *
- * Similar to irqentry_enter() but taking care of the NMI constraints.
- */
-irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs);
-
-/**
- * irqentry_nmi_exit - Handle return from NMI handling
- * @regs:	Pointer to pt_regs (NMI entry regs)
- * @irq_state:	Return value from matching call to irqentry_nmi_enter()
- *
- * Last action before returning to the low level assembly code.
- *
- * Counterpart to irqentry_nmi_enter().
- */
-void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state);
-
 #endif
diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
new file mode 100644
index 0000000..8af3743
--- /dev/null
+++ b/include/linux/irq-entry-common.h
@@ -0,0 +1,389 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_IRQENTRYCOMMON_H
+#define __LINUX_IRQENTRYCOMMON_H
+
+#include <linux/static_call_types.h>
+#include <linux/syscalls.h>
+#include <linux/context_tracking.h>
+#include <linux/tick.h>
+#include <linux/kmsan.h>
+
+#include <asm/entry-common.h>
+
+/*
+ * Define dummy _TIF work flags if not defined by the architecture or for
+ * disabled functionality.
+ */
+#ifndef _TIF_PATCH_PENDING
+# define _TIF_PATCH_PENDING		(0)
+#endif
+
+/*
+ * TIF flags handled in exit_to_user_mode_loop()
+ */
+#ifndef ARCH_EXIT_TO_USER_MODE_WORK
+# define ARCH_EXIT_TO_USER_MODE_WORK		(0)
+#endif
+
+#define EXIT_TO_USER_MODE_WORK						\
+	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
+	 _TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY |			\
+	 _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |			\
+	 ARCH_EXIT_TO_USER_MODE_WORK)
+
+/**
+ * arch_enter_from_user_mode - Architecture specific sanity check for user mode regs
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Defaults to an empty implementation. Can be replaced by architecture
+ * specific code.
+ *
+ * Invoked from syscall_enter_from_user_mode() in the non-instrumentable
+ * section. Use __always_inline so the compiler cannot push it out of line
+ * and make it instrumentable.
+ */
+static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs);
+
+#ifndef arch_enter_from_user_mode
+static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs) {}
+#endif
+
+/**
+ * enter_from_user_mode - Establish state when coming from user mode
+ *
+ * Syscall/interrupt entry disables interrupts, but user mode is traced as
+ * interrupts enabled. Also with NO_HZ_FULL RCU might be idle.
+ *
+ * 1) Tell lockdep that interrupts are disabled
+ * 2) Invoke context tracking if enabled to reactivate RCU
+ * 3) Trace interrupts off state
+ *
+ * Invoked from architecture specific syscall entry code with interrupts
+ * disabled. The calling code has to be non-instrumentable. When the
+ * function returns all state is correct and interrupts are still
+ * disabled. The subsequent functions can be instrumented.
+ *
+ * This is invoked when there is architecture specific functionality to be
+ * done between establishing state and enabling interrupts. The caller must
+ * enable interrupts before invoking syscall_enter_from_user_mode_work().
+ */
+static __always_inline void enter_from_user_mode(struct pt_regs *regs)
+{
+	arch_enter_from_user_mode(regs);
+	lockdep_hardirqs_off(CALLER_ADDR0);
+
+	CT_WARN_ON(__ct_state() != CT_STATE_USER);
+	user_exit_irqoff();
+
+	instrumentation_begin();
+	kmsan_unpoison_entry_regs(regs);
+	trace_hardirqs_off_finish();
+	instrumentation_end();
+}
+
+/**
+ * local_irq_enable_exit_to_user - Exit to user variant of local_irq_enable()
+ * @ti_work:	Cached TIF flags gathered with interrupts disabled
+ *
+ * Defaults to local_irq_enable(). Can be supplied by architecture specific
+ * code.
+ */
+static inline void local_irq_enable_exit_to_user(unsigned long ti_work);
+
+#ifndef local_irq_enable_exit_to_user
+static inline void local_irq_enable_exit_to_user(unsigned long ti_work)
+{
+	local_irq_enable();
+}
+#endif
+
+/**
+ * local_irq_disable_exit_to_user - Exit to user variant of local_irq_disable()
+ *
+ * Defaults to local_irq_disable(). Can be supplied by architecture specific
+ * code.
+ */
+static inline void local_irq_disable_exit_to_user(void);
+
+#ifndef local_irq_disable_exit_to_user
+static inline void local_irq_disable_exit_to_user(void)
+{
+	local_irq_disable();
+}
+#endif
+
+/**
+ * arch_exit_to_user_mode_work - Architecture specific TIF work for exit
+ *				 to user mode.
+ * @regs:	Pointer to currents pt_regs
+ * @ti_work:	Cached TIF flags gathered with interrupts disabled
+ *
+ * Invoked from exit_to_user_mode_loop() with interrupt enabled
+ *
+ * Defaults to NOOP. Can be supplied by architecture specific code.
+ */
+static inline void arch_exit_to_user_mode_work(struct pt_regs *regs,
+					       unsigned long ti_work);
+
+#ifndef arch_exit_to_user_mode_work
+static inline void arch_exit_to_user_mode_work(struct pt_regs *regs,
+					       unsigned long ti_work)
+{
+}
+#endif
+
+/**
+ * arch_exit_to_user_mode_prepare - Architecture specific preparation for
+ *				    exit to user mode.
+ * @regs:	Pointer to currents pt_regs
+ * @ti_work:	Cached TIF flags gathered with interrupts disabled
+ *
+ * Invoked from exit_to_user_mode_prepare() with interrupt disabled as the last
+ * function before return. Defaults to NOOP.
+ */
+static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
+						  unsigned long ti_work);
+
+#ifndef arch_exit_to_user_mode_prepare
+static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
+						  unsigned long ti_work)
+{
+}
+#endif
+
+/**
+ * arch_exit_to_user_mode - Architecture specific final work before
+ *			    exit to user mode.
+ *
+ * Invoked from exit_to_user_mode() with interrupt disabled as the last
+ * function before return. Defaults to NOOP.
+ *
+ * This needs to be __always_inline because it is non-instrumentable code
+ * invoked after context tracking switched to user mode.
+ *
+ * An architecture implementation must not do anything complex, no locking
+ * etc. The main purpose is for speculation mitigations.
+ */
+static __always_inline void arch_exit_to_user_mode(void);
+
+#ifndef arch_exit_to_user_mode
+static __always_inline void arch_exit_to_user_mode(void) { }
+#endif
+
+/**
+ * arch_do_signal_or_restart -  Architecture specific signal delivery function
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Invoked from exit_to_user_mode_loop().
+ */
+void arch_do_signal_or_restart(struct pt_regs *regs);
+
+/**
+ * exit_to_user_mode_loop - do any pending work before leaving to user space
+ */
+unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
+				     unsigned long ti_work);
+
+/**
+ * exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
+ * @regs:	Pointer to pt_regs on entry stack
+ *
+ * 1) check that interrupts are disabled
+ * 2) call tick_nohz_user_enter_prepare()
+ * 3) call exit_to_user_mode_loop() if any flags from
+ *    EXIT_TO_USER_MODE_WORK are set
+ * 4) check that interrupts are still disabled
+ */
+static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
+{
+	unsigned long ti_work;
+
+	lockdep_assert_irqs_disabled();
+
+	/* Flush pending rcuog wakeup before the last need_resched() check */
+	tick_nohz_user_enter_prepare();
+
+	ti_work = read_thread_flags();
+	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
+		ti_work = exit_to_user_mode_loop(regs, ti_work);
+
+	arch_exit_to_user_mode_prepare(regs, ti_work);
+
+	/* Ensure that kernel state is sane for a return to userspace */
+	kmap_assert_nomap();
+	lockdep_assert_irqs_disabled();
+	lockdep_sys_exit();
+}
+
+/**
+ * exit_to_user_mode - Fixup state when exiting to user mode
+ *
+ * Syscall/interrupt exit enables interrupts, but the kernel state is
+ * interrupts disabled when this is invoked. Also tell RCU about it.
+ *
+ * 1) Trace interrupts on state
+ * 2) Invoke context tracking if enabled to adjust RCU state
+ * 3) Invoke architecture specific last minute exit code, e.g. speculation
+ *    mitigations, etc.: arch_exit_to_user_mode()
+ * 4) Tell lockdep that interrupts are enabled
+ *
+ * Invoked from architecture specific code when syscall_exit_to_user_mode()
+ * is not suitable as the last step before returning to userspace. Must be
+ * invoked with interrupts disabled and the caller must be
+ * non-instrumentable.
+ * The caller has to invoke syscall_exit_to_user_mode_work() before this.
+ */
+static __always_inline void exit_to_user_mode(void)
+{
+	instrumentation_begin();
+	trace_hardirqs_on_prepare();
+	lockdep_hardirqs_on_prepare();
+	instrumentation_end();
+
+	user_enter_irqoff();
+	arch_exit_to_user_mode();
+	lockdep_hardirqs_on(CALLER_ADDR0);
+}
+
+/**
+ * irqentry_enter_from_user_mode - Establish state before invoking the irq handler
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Invoked from architecture specific entry code with interrupts disabled.
+ * Can only be called when the interrupt entry came from user mode. The
+ * calling code must be non-instrumentable.  When the function returns all
+ * state is correct and the subsequent functions can be instrumented.
+ *
+ * The function establishes state (lockdep, RCU (context tracking), tracing)
+ */
+void irqentry_enter_from_user_mode(struct pt_regs *regs);
+
+/**
+ * irqentry_exit_to_user_mode - Interrupt exit work
+ * @regs:	Pointer to current's pt_regs
+ *
+ * Invoked with interrupts disabled and fully valid regs. Returns with all
+ * work handled, interrupts disabled such that the caller can immediately
+ * switch to user mode. Called from architecture specific interrupt
+ * handling code.
+ *
+ * The call order is #2 and #3 as described in syscall_exit_to_user_mode().
+ * Interrupt exit is not invoking #1 which is the syscall specific one time
+ * work.
+ */
+void irqentry_exit_to_user_mode(struct pt_regs *regs);
+
+#ifndef irqentry_state
+/**
+ * struct irqentry_state - Opaque object for exception state storage
+ * @exit_rcu: Used exclusively in the irqentry_*() calls; signals whether the
+ *            exit path has to invoke ct_irq_exit().
+ * @lockdep: Used exclusively in the irqentry_nmi_*() calls; ensures that
+ *           lockdep state is restored correctly on exit from nmi.
+ *
+ * This opaque object is filled in by the irqentry_*_enter() functions and
+ * must be passed back into the corresponding irqentry_*_exit() functions
+ * when the exception is complete.
+ *
+ * Callers of irqentry_*_[enter|exit]() must consider this structure opaque
+ * and all members private.  Descriptions of the members are provided to aid in
+ * the maintenance of the irqentry_*() functions.
+ */
+typedef struct irqentry_state {
+	union {
+		bool	exit_rcu;
+		bool	lockdep;
+	};
+} irqentry_state_t;
+#endif
+
+/**
+ * irqentry_enter - Handle state tracking on ordinary interrupt entries
+ * @regs:	Pointer to pt_regs of interrupted context
+ *
+ * Invokes:
+ *  - lockdep irqflag state tracking as low level ASM entry disabled
+ *    interrupts.
+ *
+ *  - Context tracking if the exception hit user mode.
+ *
+ *  - The hardirq tracer to keep the state consistent as low level ASM
+ *    entry disabled interrupts.
+ *
+ * As a precondition, this requires that the entry came from user mode,
+ * idle, or a kernel context in which RCU is watching.
+ *
+ * For kernel mode entries RCU handling is done conditional. If RCU is
+ * watching then the only RCU requirement is to check whether the tick has
+ * to be restarted. If RCU is not watching then ct_irq_enter() has to be
+ * invoked on entry and ct_irq_exit() on exit.
+ *
+ * Avoiding the ct_irq_enter/exit() calls is an optimization but also
+ * solves the problem of kernel mode pagefaults which can schedule, which
+ * is not possible after invoking ct_irq_enter() without undoing it.
+ *
+ * For user mode entries irqentry_enter_from_user_mode() is invoked to
+ * establish the proper context for NOHZ_FULL. Otherwise scheduling on exit
+ * would not be possible.
+ *
+ * Returns: An opaque object that must be passed to idtentry_exit()
+ */
+irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
+
+/**
+ * irqentry_exit_cond_resched - Conditionally reschedule on return from interrupt
+ *
+ * Conditional reschedule with additional sanity checks.
+ */
+void raw_irqentry_exit_cond_resched(void);
+#ifdef CONFIG_PREEMPT_DYNAMIC
+#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
+#define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_resched
+#define irqentry_exit_cond_resched_dynamic_disabled	NULL
+DECLARE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
+#define irqentry_exit_cond_resched()	static_call(irqentry_exit_cond_resched)()
+#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
+void dynamic_irqentry_exit_cond_resched(void);
+#define irqentry_exit_cond_resched()	dynamic_irqentry_exit_cond_resched()
+#endif
+#else /* CONFIG_PREEMPT_DYNAMIC */
+#define irqentry_exit_cond_resched()	raw_irqentry_exit_cond_resched()
+#endif /* CONFIG_PREEMPT_DYNAMIC */
+
+/**
+ * irqentry_exit - Handle return from exception that used irqentry_enter()
+ * @regs:	Pointer to pt_regs (exception entry regs)
+ * @state:	Return value from matching call to irqentry_enter()
+ *
+ * Depending on the return target (kernel/user) this runs the necessary
+ * preemption and work checks if possible and required and returns to
+ * the caller with interrupts disabled and no further work pending.
+ *
+ * This is the last action before returning to the low level ASM code which
+ * just needs to return to the appropriate context.
+ *
+ * Counterpart to irqentry_enter().
+ */
+void noinstr irqentry_exit(struct pt_regs *regs, irqentry_state_t state);
+
+/**
+ * irqentry_nmi_enter - Handle NMI entry
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Similar to irqentry_enter() but taking care of the NMI constraints.
+ */
+irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs);
+
+/**
+ * irqentry_nmi_exit - Handle return from NMI handling
+ * @regs:	Pointer to pt_regs (NMI entry regs)
+ * @irq_state:	Return value from matching call to irqentry_nmi_enter()
+ *
+ * Last action before returning to the low level assembly code.
+ *
+ * Counterpart to irqentry_nmi_enter().
+ */
+void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state);
+
+#endif
diff --git a/kernel/entry/Makefile b/kernel/entry/Makefile
index d4b8bd0..77fcd83 100644
--- a/kernel/entry/Makefile
+++ b/kernel/entry/Makefile
@@ -12,5 +12,6 @@ ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
 CFLAGS_REMOVE_common.o	 = -fstack-protector -fstack-protector-strong
 CFLAGS_common.o		+= -fno-stack-protector
 
-obj-$(CONFIG_GENERIC_ENTRY) 		+= common.o syscall_user_dispatch.o
+obj-$(CONFIG_GENERIC_IRQ_ENTRY) 	+= common.o
+obj-$(CONFIG_GENERIC_SYSCALL) 		+= syscall-common.o syscall_user_dispatch.o
 obj-$(CONFIG_KVM_XFER_TO_GUEST_WORK)	+= kvm.o
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index a8dd1f2..b820327 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -1,84 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <linux/context_tracking.h>
-#include <linux/entry-common.h>
+#include <linux/irq-entry-common.h>
 #include <linux/resume_user_mode.h>
 #include <linux/highmem.h>
 #include <linux/jump_label.h>
 #include <linux/kmsan.h>
 #include <linux/livepatch.h>
-#include <linux/audit.h>
 #include <linux/tick.h>
 
-#include "common.h"
-
-#define CREATE_TRACE_POINTS
-#include <trace/events/syscalls.h>
-
-static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
-{
-	if (unlikely(audit_context())) {
-		unsigned long args[6];
-
-		syscall_get_arguments(current, regs, args);
-		audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
-	}
-}
-
-long syscall_trace_enter(struct pt_regs *regs, long syscall,
-				unsigned long work)
-{
-	long ret = 0;
-
-	/*
-	 * Handle Syscall User Dispatch.  This must comes first, since
-	 * the ABI here can be something that doesn't make sense for
-	 * other syscall_work features.
-	 */
-	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
-		if (syscall_user_dispatch(regs))
-			return -1L;
-	}
-
-	/* Handle ptrace */
-	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
-		ret = ptrace_report_syscall_entry(regs);
-		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
-			return -1L;
-	}
-
-	/* Do seccomp after ptrace, to catch any tracer changes. */
-	if (work & SYSCALL_WORK_SECCOMP) {
-		ret = __secure_computing();
-		if (ret == -1L)
-			return ret;
-	}
-
-	/* Either of the above might have changed the syscall number */
-	syscall = syscall_get_nr(current, regs);
-
-	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT)) {
-		trace_sys_enter(regs, syscall);
-		/*
-		 * Probes or BPF hooks in the tracepoint may have changed the
-		 * system call number as well.
-		 */
-		syscall = syscall_get_nr(current, regs);
-	}
-
-	syscall_enter_audit(regs, syscall);
-
-	return ret ? : syscall;
-}
-
-noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
-{
-	enter_from_user_mode(regs);
-	instrumentation_begin();
-	local_irq_enable();
-	instrumentation_end();
-}
-
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
 
@@ -133,46 +62,6 @@ __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 	return ti_work;
 }
 
-/*
- * If SYSCALL_EMU is set, then the only reason to report is when
- * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
- * instruction has been already reported in syscall_enter_from_user_mode().
- */
-static inline bool report_single_step(unsigned long work)
-{
-	if (work & SYSCALL_WORK_SYSCALL_EMU)
-		return false;
-
-	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
-}
-
-void syscall_exit_work(struct pt_regs *regs, unsigned long work)
-{
-	bool step;
-
-	/*
-	 * If the syscall was rolled back due to syscall user dispatching,
-	 * then the tracers below are not invoked for the same reason as
-	 * the entry side was not invoked in syscall_trace_enter(): The ABI
-	 * of these syscalls is unknown.
-	 */
-	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
-		if (unlikely(current->syscall_dispatch.on_dispatch)) {
-			current->syscall_dispatch.on_dispatch = false;
-			return;
-		}
-	}
-
-	audit_syscall_exit(regs);
-
-	if (work & SYSCALL_WORK_SYSCALL_TRACEPOINT)
-		trace_sys_exit(regs, syscall_get_return_value(current, regs));
-
-	step = report_single_step(work);
-	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
-		ptrace_report_syscall_exit(regs, step);
-}
-
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 {
 	enter_from_user_mode(regs);
diff --git a/kernel/entry/syscall-common.c b/kernel/entry/syscall-common.c
new file mode 100644
index 0000000..66e6ba7
--- /dev/null
+++ b/kernel/entry/syscall-common.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/audit.h>
+#include <linux/entry-common.h>
+#include "common.h"
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/syscalls.h>
+
+static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
+{
+	if (unlikely(audit_context())) {
+		unsigned long args[6];
+
+		syscall_get_arguments(current, regs, args);
+		audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
+	}
+}
+
+long syscall_trace_enter(struct pt_regs *regs, long syscall,
+				unsigned long work)
+{
+	long ret = 0;
+
+	/*
+	 * Handle Syscall User Dispatch.  This must comes first, since
+	 * the ABI here can be something that doesn't make sense for
+	 * other syscall_work features.
+	 */
+	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
+		if (syscall_user_dispatch(regs))
+			return -1L;
+	}
+
+	/* Handle ptrace */
+	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
+		ret = ptrace_report_syscall_entry(regs);
+		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
+			return -1L;
+	}
+
+	/* Do seccomp after ptrace, to catch any tracer changes. */
+	if (work & SYSCALL_WORK_SECCOMP) {
+		ret = __secure_computing();
+		if (ret == -1L)
+			return ret;
+	}
+
+	/* Either of the above might have changed the syscall number */
+	syscall = syscall_get_nr(current, regs);
+
+	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT)) {
+		trace_sys_enter(regs, syscall);
+		/*
+		 * Probes or BPF hooks in the tracepoint may have changed the
+		 * system call number as well.
+		 */
+		syscall = syscall_get_nr(current, regs);
+	}
+
+	syscall_enter_audit(regs, syscall);
+
+	return ret ? : syscall;
+}
+
+noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
+{
+	enter_from_user_mode(regs);
+	instrumentation_begin();
+	local_irq_enable();
+	instrumentation_end();
+}
+
+/*
+ * If SYSCALL_EMU is set, then the only reason to report is when
+ * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
+ * instruction has been already reported in syscall_enter_from_user_mode().
+ */
+static inline bool report_single_step(unsigned long work)
+{
+	if (work & SYSCALL_WORK_SYSCALL_EMU)
+		return false;
+
+	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
+}
+
+void syscall_exit_work(struct pt_regs *regs, unsigned long work)
+{
+	bool step;
+
+	/*
+	 * If the syscall was rolled back due to syscall user dispatching,
+	 * then the tracers below are not invoked for the same reason as
+	 * the entry side was not invoked in syscall_trace_enter(): The ABI
+	 * of these syscalls is unknown.
+	 */
+	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
+		if (unlikely(current->syscall_dispatch.on_dispatch)) {
+			current->syscall_dispatch.on_dispatch = false;
+			return;
+		}
+	}
+
+	audit_syscall_exit(regs);
+
+	if (work & SYSCALL_WORK_SYSCALL_TRACEPOINT)
+		trace_sys_exit(regs, syscall_get_return_value(current, regs));
+
+	step = report_single_step(work);
+	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
+		ptrace_report_syscall_exit(regs, step);
+}
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dce50fa..e6269e7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -69,8 +69,8 @@
 #include <linux/livepatch_sched.h>
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
-# ifdef CONFIG_GENERIC_ENTRY
-#  include <linux/entry-common.h>
+# ifdef CONFIG_GENERIC_IRQ_ENTRY
+#  include <linux/irq-entry-common.h>
 # endif
 #endif
 
@@ -7427,8 +7427,8 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
-#ifdef CONFIG_GENERIC_ENTRY
-#include <linux/entry-common.h>
+#ifdef CONFIG_GENERIC_IRQ_ENTRY
+#include <linux/irq-entry-common.h>
 #endif
 
 /*

