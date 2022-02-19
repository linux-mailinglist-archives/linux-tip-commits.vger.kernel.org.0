Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDCA4BC7A4
	for <lists+linux-tip-commits@lfdr.de>; Sat, 19 Feb 2022 11:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241946AbiBSKVu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 19 Feb 2022 05:21:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236506AbiBSKVs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 19 Feb 2022 05:21:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD096F39;
        Sat, 19 Feb 2022 02:21:27 -0800 (PST)
Date:   Sat, 19 Feb 2022 10:21:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645266086;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4kR8ES46ezQvyp+VHHsu6uevfAPHrqRdjTRnUfHhzCI=;
        b=FV0AM6XEcVLjHYR13y8KOv+qHflhqySAEtq+gjEfTCeE3TfBcQvwSc6GKDUWCFRmxpDfcR
        Oq0+bUvInzGFIcrComJ3lRRgZ/Pe1J924Dlkf6j07Dfx7qUzEqOlM3HH976Bo45iyefafg
        5M9RTNIH/HKRqRcx6Q1V7KNo+l/r+cTiQsGUhSxHvqlMNQ3k81SqlKwbPfPDPcXmiJlgle
        h//otZ1edD73XQu1G0A9VDZGzL74lutg1F1GbqTh9s2zW/hRPJQU9rF3c/wWa2G0nQ1onu
        xEDl4tqp9MaTzXPcIBywdFAl/rXvQrSGbOwJL1sKFHBgpFxKiqRyyysMpX/oyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645266086;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4kR8ES46ezQvyp+VHHsu6uevfAPHrqRdjTRnUfHhzCI=;
        b=N1a5/z9k96hIG8Sv1mHtTzVXtf+XXOd9Maftjt448csrV83SExoKqQoRrOBXoEkjkmGWLs
        D3EscRAQI76/t9Cw==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/preempt: Add PREEMPT_DYNAMIC using static keys
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220214165216.2231574-6-mark.rutland@arm.com>
References: <20220214165216.2231574-6-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <164526608532.16921.10484110350178920587.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     99cf983cc8bca4adb461b519664c939a565cfd4d
Gitweb:        https://git.kernel.org/tip/99cf983cc8bca4adb461b519664c939a565cfd4d
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 14 Feb 2022 16:52:14 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 19 Feb 2022 11:11:08 +01:00

sched/preempt: Add PREEMPT_DYNAMIC using static keys

Where an architecture selects HAVE_STATIC_CALL but not
HAVE_STATIC_CALL_INLINE, each static call has an out-of-line trampoline
which will either branch to a callee or return to the caller.

On such architectures, a number of constraints can conspire to make
those trampolines more complicated and potentially less useful than we'd
like. For example:

* Hardware and software control flow integrity schemes can require the
  addition of "landing pad" instructions (e.g. `BTI` for arm64), which
  will also be present at the "real" callee.

* Limited branch ranges can require that trampolines generate or load an
  address into a register and perform an indirect branch (or at least
  have a slow path that does so). This loses some of the benefits of
  having a direct branch.

* Interaction with SW CFI schemes can be complicated and fragile, e.g.
  requiring that we can recognise idiomatic codegen and remove
  indirections understand, at least until clang proves more helpful
  mechanisms for dealing with this.

For PREEMPT_DYNAMIC, we don't need the full power of static calls, as we
really only need to enable/disable specific preemption functions. We can
achieve the same effect without a number of the pain points above by
using static keys to fold early returns into the preemption functions
themselves rather than in an out-of-line trampoline, effectively
inlining the trampoline into the start of the function.

For arm64, this results in good code generation. For example, the
dynamic_cond_resched() wrapper looks as follows when enabled. When
disabled, the first `B` is replaced with a `NOP`, resulting in an early
return.

| <dynamic_cond_resched>:
|        bti     c
|        b       <dynamic_cond_resched+0x10>     // or `nop`
|        mov     w0, #0x0
|        ret
|        mrs     x0, sp_el0
|        ldr     x0, [x0, #8]
|        cbnz    x0, <dynamic_cond_resched+0x8>
|        paciasp
|        stp     x29, x30, [sp, #-16]!
|        mov     x29, sp
|        bl      <preempt_schedule_common>
|        mov     w0, #0x1
|        ldp     x29, x30, [sp], #16
|        autiasp
|        ret

... compared to the regular form of the function:

| <__cond_resched>:
|        bti     c
|        mrs     x0, sp_el0
|        ldr     x1, [x0, #8]
|        cbz     x1, <__cond_resched+0x18>
|        mov     w0, #0x0
|        ret
|        paciasp
|        stp     x29, x30, [sp, #-16]!
|        mov     x29, sp
|        bl      <preempt_schedule_common>
|        mov     w0, #0x1
|        ldp     x29, x30, [sp], #16
|        autiasp
|        ret

Any architecture which implements static keys should be able to use this
to implement PREEMPT_DYNAMIC with similar cost to non-inlined static
calls. Since this is likely to have greater overhead than (inlined)
static calls, PREEMPT_DYNAMIC is only defaulted to enabled when
HAVE_PREEMPT_DYNAMIC_CALL is selected.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20220214165216.2231574-6-mark.rutland@arm.com
---
 arch/Kconfig                 | 36 +++++++++++++++++++++--
 arch/x86/Kconfig             |  2 +-
 include/linux/entry-common.h | 10 ++++--
 include/linux/kernel.h       |  7 ++++-
 include/linux/sched.h        | 10 +++++-
 kernel/Kconfig.preempt       |  3 +-
 kernel/entry/common.c        | 11 +++++++-
 kernel/sched/core.c          | 54 +++++++++++++++++++++++++++++++++--
 8 files changed, 122 insertions(+), 11 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 601691f..d544abd 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1278,11 +1278,41 @@ config HAVE_STATIC_CALL_INLINE
 
 config HAVE_PREEMPT_DYNAMIC
 	bool
+
+config HAVE_PREEMPT_DYNAMIC_CALL
+	bool
 	depends on HAVE_STATIC_CALL
+	select HAVE_PREEMPT_DYNAMIC
+	help
+	   An architecture should select this if it can handle the preemption
+	   model being selected at boot time using static calls.
+
+	   Where an architecture selects HAVE_STATIC_CALL_INLINE, any call to a
+	   preemption function will be patched directly.
+
+	   Where an architecture does not select HAVE_STATIC_CALL_INLINE, any
+	   call to a preemption function will go through a trampoline, and the
+	   trampoline will be patched.
+
+	   It is strongly advised to support inline static call to avoid any
+	   overhead.
+
+config HAVE_PREEMPT_DYNAMIC_KEY
+	bool
+	depends on HAVE_ARCH_JUMP_LABEL && CC_HAS_ASM_GOTO
+	select HAVE_PREEMPT_DYNAMIC
 	help
-	   Select this if the architecture support boot time preempt setting
-	   on top of static calls. It is strongly advised to support inline
-	   static call to avoid any overhead.
+	   An architecture should select this if it can handle the preemption
+	   model being selected at boot time using static keys.
+
+	   Each preemption function will be given an early return based on a
+	   static key. This should have slightly lower overhead than non-inline
+	   static calls, as this effectively inlines each trampoline into the
+	   start of its callee. This may avoid redundant work, and may
+	   integrate better with CFI schemes.
+
+	   This will have greater overhead than using inline static calls as
+	   the call to the preemption function cannot be entirely elided.
 
 config ARCH_WANT_LD_ORPHAN_WARN
 	bool
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ebe8fc7..f13cfdf 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -245,7 +245,7 @@ config X86
 	select HAVE_STACK_VALIDATION		if X86_64
 	select HAVE_STATIC_CALL
 	select HAVE_STATIC_CALL_INLINE		if HAVE_STACK_VALIDATION
-	select HAVE_PREEMPT_DYNAMIC
+	select HAVE_PREEMPT_DYNAMIC_CALL
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index dfd84c5..141952f 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -456,13 +456,19 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
  */
 void raw_irqentry_exit_cond_resched(void);
 #ifdef CONFIG_PREEMPT_DYNAMIC
+#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_resched
 #define irqentry_exit_cond_resched_dynamic_disabled	NULL
 DECLARE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
 #define irqentry_exit_cond_resched()	static_call(irqentry_exit_cond_resched)()
-#else
-#define irqentry_exit_cond_resched()	raw_irqentry_exit_cond_resched()
+#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
+void dynamic_irqentry_exit_cond_resched(void);
+#define irqentry_exit_cond_resched()	dynamic_irqentry_exit_cond_resched()
 #endif
+#else /* CONFIG_PREEMPT_DYNAMIC */
+#define irqentry_exit_cond_resched()	raw_irqentry_exit_cond_resched()
+#endif /* CONFIG_PREEMPT_DYNAMIC */
 
 /**
  * irqentry_exit - Handle return from exception that used irqentry_enter()
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 33f47a9..a890428 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -99,7 +99,7 @@ struct user;
 extern int __cond_resched(void);
 # define might_resched() __cond_resched()
 
-#elif defined(CONFIG_PREEMPT_DYNAMIC)
+#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 
 extern int __cond_resched(void);
 
@@ -110,6 +110,11 @@ static __always_inline void might_resched(void)
 	static_call_mod(might_resched)();
 }
 
+#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+
+extern int dynamic_might_resched(void);
+# define might_resched() dynamic_might_resched()
+
 #else
 
 # define might_resched() do { } while (0)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 508b91d..de03dde 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2020,7 +2020,7 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
 #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
 extern int __cond_resched(void);
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
+#if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 
 DECLARE_STATIC_CALL(cond_resched, __cond_resched);
 
@@ -2029,6 +2029,14 @@ static __always_inline int _cond_resched(void)
 	return static_call_mod(cond_resched)();
 }
 
+#elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+extern int dynamic_cond_resched(void);
+
+static __always_inline int _cond_resched(void)
+{
+	return dynamic_cond_resched();
+}
+
 #else
 
 static inline int _cond_resched(void)
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index ce77f02..c2f1fd9 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -96,8 +96,9 @@ config PREEMPTION
 config PREEMPT_DYNAMIC
 	bool "Preemption behaviour defined on boot"
 	depends on HAVE_PREEMPT_DYNAMIC && !PREEMPT_RT
+	select JUMP_LABEL if HAVE_PREEMPT_DYNAMIC_KEY
 	select PREEMPT_BUILD
-	default y
+	default y if HAVE_PREEMPT_DYNAMIC_CALL
 	help
 	  This option allows to define the preemption model on the kernel
 	  command line parameter and thus override the default preemption
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 1739ca7..b145249 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -3,6 +3,7 @@
 #include <linux/context_tracking.h>
 #include <linux/entry-common.h>
 #include <linux/highmem.h>
+#include <linux/jump_label.h>
 #include <linux/livepatch.h>
 #include <linux/audit.h>
 #include <linux/tick.h>
@@ -392,7 +393,17 @@ void raw_irqentry_exit_cond_resched(void)
 	}
 }
 #ifdef CONFIG_PREEMPT_DYNAMIC
+#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
+#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
+void dynamic_irqentry_exit_cond_resched(void)
+{
+	if (!static_key_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
+		return;
+	raw_irqentry_exit_cond_resched();
+}
+#endif
 #endif
 
 noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 300c045..9e65028 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -14,6 +14,7 @@
 
 #include <linux/nospec.h>
 #include <linux/blkdev.h>
+#include <linux/jump_label.h>
 #include <linux/kcov.h>
 #include <linux/scs.h>
 
@@ -6484,21 +6485,31 @@ asmlinkage __visible void __sched notrace preempt_schedule(void)
 	 */
 	if (likely(!preemptible()))
 		return;
-
 	preempt_schedule_common();
 }
 NOKPROBE_SYMBOL(preempt_schedule);
 EXPORT_SYMBOL(preempt_schedule);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
+#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #ifndef preempt_schedule_dynamic_enabled
 #define preempt_schedule_dynamic_enabled	preempt_schedule
 #define preempt_schedule_dynamic_disabled	NULL
 #endif
 DEFINE_STATIC_CALL(preempt_schedule, preempt_schedule_dynamic_enabled);
 EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
+#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+static DEFINE_STATIC_KEY_TRUE(sk_dynamic_preempt_schedule);
+void __sched notrace dynamic_preempt_schedule(void)
+{
+	if (!static_branch_unlikely(&sk_dynamic_preempt_schedule))
+		return;
+	preempt_schedule();
+}
+NOKPROBE_SYMBOL(dynamic_preempt_schedule);
+EXPORT_SYMBOL(dynamic_preempt_schedule);
+#endif
 #endif
-
 
 /**
  * preempt_schedule_notrace - preempt_schedule called by tracing
@@ -6553,12 +6564,24 @@ asmlinkage __visible void __sched notrace preempt_schedule_notrace(void)
 EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
+#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #ifndef preempt_schedule_notrace_dynamic_enabled
 #define preempt_schedule_notrace_dynamic_enabled	preempt_schedule_notrace
 #define preempt_schedule_notrace_dynamic_disabled	NULL
 #endif
 DEFINE_STATIC_CALL(preempt_schedule_notrace, preempt_schedule_notrace_dynamic_enabled);
 EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
+#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+static DEFINE_STATIC_KEY_TRUE(sk_dynamic_preempt_schedule_notrace);
+void __sched notrace dynamic_preempt_schedule_notrace(void)
+{
+	if (!static_branch_unlikely(&sk_dynamic_preempt_schedule_notrace))
+		return;
+	preempt_schedule_notrace();
+}
+NOKPROBE_SYMBOL(dynamic_preempt_schedule_notrace);
+EXPORT_SYMBOL(dynamic_preempt_schedule_notrace);
+#endif
 #endif
 
 #endif /* CONFIG_PREEMPTION */
@@ -8068,6 +8091,7 @@ EXPORT_SYMBOL(__cond_resched);
 #endif
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
+#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define cond_resched_dynamic_enabled	__cond_resched
 #define cond_resched_dynamic_disabled	((void *)&__static_call_return0)
 DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
@@ -8077,6 +8101,25 @@ EXPORT_STATIC_CALL_TRAMP(cond_resched);
 #define might_resched_dynamic_disabled	((void *)&__static_call_return0)
 DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
 EXPORT_STATIC_CALL_TRAMP(might_resched);
+#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+static DEFINE_STATIC_KEY_FALSE(sk_dynamic_cond_resched);
+int __sched dynamic_cond_resched(void)
+{
+	if (!static_branch_unlikely(&sk_dynamic_cond_resched))
+		return 0;
+	return __cond_resched();
+}
+EXPORT_SYMBOL(dynamic_cond_resched);
+
+static DEFINE_STATIC_KEY_FALSE(sk_dynamic_might_resched);
+int __sched dynamic_might_resched(void)
+{
+	if (!static_branch_unlikely(&sk_dynamic_might_resched))
+		return 0;
+	return __cond_resched();
+}
+EXPORT_SYMBOL(dynamic_might_resched);
+#endif
 #endif
 
 /*
@@ -8206,8 +8249,15 @@ int sched_dynamic_mode(const char *str)
 	return -EINVAL;
 }
 
+#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define preempt_dynamic_enable(f)	static_call_update(f, f##_dynamic_enabled)
 #define preempt_dynamic_disable(f)	static_call_update(f, f##_dynamic_disabled)
+#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
+#define preempt_dynamic_enable(f)	static_key_enable(&sk_dynamic_##f.key)
+#define preempt_dynamic_disable(f)	static_key_disable(&sk_dynamic_##f.key)
+#else
+#error "Unsupported PREEMPT_DYNAMIC mechanism"
+#endif
 
 void sched_dynamic_update(int mode)
 {
