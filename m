Return-Path: <linux-tip-commits+bounces-4234-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 941FCA63529
	for <lists+linux-tip-commits@lfdr.de>; Sun, 16 Mar 2025 12:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835D918904E6
	for <lists+linux-tip-commits@lfdr.de>; Sun, 16 Mar 2025 11:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAB31A83EB;
	Sun, 16 Mar 2025 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3fiw2wyM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XmrVx4Aw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639311A4E9E;
	Sun, 16 Mar 2025 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742122906; cv=none; b=mVGzeZJsyG3Us8Qwx2rxLOjIyJVrDzDsCVodzGOJuirmfWOueQ/72kLzxPtGlmDkJFRL7rZlEjCX8jfdJsm+j4EAmdNRehgMp9SYt1YRW8mj8JANWrMhFlgIMQkWeB6euAK+NLJCuhxh7Wd4VHzVTyaLvDWaS5tHCqGe51SGId4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742122906; c=relaxed/simple;
	bh=5+bawUqZmrTdoPL83F1osHxmHtvoAxqKG3Sg5LcyXLY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DqCZO/DOaatUv8BE++8WNX7SJYD8dxhSeBiVBt+qC7deR8DK6KKlWw49znFPttIfYMsGj2XDIpm5L2XaCIzdxsdJJgRJg21vWiGKUjLEoK/s98f3MFg+EHijMT3H6g9DL6hiVAhvkSVb6w5bzve55+4aNd+K6y2/8QdkN5gvTa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3fiw2wyM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XmrVx4Aw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 16 Mar 2025 11:01:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742122903;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=opBK8yzjrO4+r8RapBuYYr5QxWxaQ+qUUkeGUNXyT2Q=;
	b=3fiw2wyMnH7+/3pTRJLjuzPKVHyeA+sxrUFpLy23ZzhC+qwMoB51/ZbmwNRpmMCRUlm/gv
	IZ9Qwme8RP/OUot9Fo2VDNIRZomsDm6dklV6JIEX6idRfe72QsVrwZm41NiXzKqd3QhHhd
	k/YIiHtpg9wSFm9oZImoklSpD19uaXDS/wl8Jy2yshCbr7AqsSSauavTwB/LgEiJWWNXe3
	UZ2Gw882EI/YeTHnf6X+4cbDI42mrpRBo5ENzEOntEtFRMa+SZbEMSWTF394d8fbubQt+S
	Qd6cV9+GpwEJf74C5IFqQWsgeV35y+YWzQVnIP29m+AFqPM4HHCvH1ymsc7VBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742122903;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=opBK8yzjrO4+r8RapBuYYr5QxWxaQ+qUUkeGUNXyT2Q=;
	b=XmrVx4AwzJSYMfR5U8YLjXmjVujfrw909s38bfhuVpzl2yGqjmEmxcvrtUhrziPjiCkzEO
	WrFiIFft1dO6bjCQ==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/syscall/32: Move 32-bit syscall dispatch code
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Sohil Mehta <sohil.mehta@intel.com>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250314151220.862768-3-brgerst@gmail.com>
References: <20250314151220.862768-3-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174212290234.14745.9099643087788011763.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     50cf87f662b0798bfa17b952b630f74ea8517f64
Gitweb:        https://git.kernel.org/tip/50cf87f662b0798bfa17b952b630f74ea8517f64
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 14 Mar 2025 11:12:15 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 16 Mar 2025 11:49:41 +01:00

x86/syscall/32: Move 32-bit syscall dispatch code

Move the 32-bit syscall dispatch code to syscall_32.c.

No functional changes.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250314151220.862768-3-brgerst@gmail.com
---
 arch/x86/entry/Makefile     |   2 +-
 arch/x86/entry/common.c     | 321 +----------------------------------
 arch/x86/entry/syscall_32.c | 329 ++++++++++++++++++++++++++++++++++-
 3 files changed, 329 insertions(+), 323 deletions(-)

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index ce1cc16..96a6b86 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -8,8 +8,10 @@ UBSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
 
 CFLAGS_REMOVE_common.o		= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_syscall_32.o	= $(CC_FLAGS_FTRACE)
 
 CFLAGS_common.o			+= -fno-stack-protector
+CFLAGS_syscall_32.o		+= -fno-stack-protector
 
 obj-y				:= entry.o entry_$(BITS).o syscall_$(BITS).o
 obj-y				+= common.o
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index ce4d88e..183efab 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -125,327 +125,6 @@ __visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
 }
 #endif
 
-#if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
-static __always_inline int syscall_32_enter(struct pt_regs *regs)
-{
-	if (IS_ENABLED(CONFIG_IA32_EMULATION))
-		current_thread_info()->status |= TS_COMPAT;
-
-	return (int)regs->orig_ax;
-}
-
-#ifdef CONFIG_IA32_EMULATION
-bool __ia32_enabled __ro_after_init = !IS_ENABLED(CONFIG_IA32_EMULATION_DEFAULT_DISABLED);
-
-static int __init ia32_emulation_override_cmdline(char *arg)
-{
-	return kstrtobool(arg, &__ia32_enabled);
-}
-early_param("ia32_emulation", ia32_emulation_override_cmdline);
-#endif
-
-/*
- * Invoke a 32-bit syscall.  Called with IRQs on in CT_STATE_KERNEL.
- */
-static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs, int nr)
-{
-	/*
-	 * Convert negative numbers to very high and thus out of range
-	 * numbers for comparisons.
-	 */
-	unsigned int unr = nr;
-
-	if (likely(unr < IA32_NR_syscalls)) {
-		unr = array_index_nospec(unr, IA32_NR_syscalls);
-		regs->ax = ia32_sys_call(regs, unr);
-	} else if (nr != -1) {
-		regs->ax = __ia32_sys_ni_syscall(regs);
-	}
-}
-
-#ifdef CONFIG_IA32_EMULATION
-static __always_inline bool int80_is_external(void)
-{
-	const unsigned int offs = (0x80 / 32) * 0x10;
-	const u32 bit = BIT(0x80 % 32);
-
-	/* The local APIC on XENPV guests is fake */
-	if (cpu_feature_enabled(X86_FEATURE_XENPV))
-		return false;
-
-	/*
-	 * If vector 0x80 is set in the APIC ISR then this is an external
-	 * interrupt. Either from broken hardware or injected by a VMM.
-	 *
-	 * Note: In guest mode this is only valid for secure guests where
-	 * the secure module fully controls the vAPIC exposed to the guest.
-	 */
-	return apic_read(APIC_ISR + offs) & bit;
-}
-
-/**
- * do_int80_emulation - 32-bit legacy syscall C entry from asm
- * @regs: syscall arguments in struct pt_args on the stack.
- *
- * This entry point can be used by 32-bit and 64-bit programs to perform
- * 32-bit system calls.  Instances of INT $0x80 can be found inline in
- * various programs and libraries.  It is also used by the vDSO's
- * __kernel_vsyscall fallback for hardware that doesn't support a faster
- * entry method.  Restarted 32-bit system calls also fall back to INT
- * $0x80 regardless of what instruction was originally used to do the
- * system call.
- *
- * This is considered a slow path.  It is not used by most libc
- * implementations on modern hardware except during process startup.
- *
- * The arguments for the INT $0x80 based syscall are on stack in the
- * pt_regs structure:
- *   eax:				system call number
- *   ebx, ecx, edx, esi, edi, ebp:	arg1 - arg 6
- */
-__visible noinstr void do_int80_emulation(struct pt_regs *regs)
-{
-	int nr;
-
-	/* Kernel does not use INT $0x80! */
-	if (unlikely(!user_mode(regs))) {
-		irqentry_enter(regs);
-		instrumentation_begin();
-		panic("Unexpected external interrupt 0x80\n");
-	}
-
-	/*
-	 * Establish kernel context for instrumentation, including for
-	 * int80_is_external() below which calls into the APIC driver.
-	 * Identical for soft and external interrupts.
-	 */
-	enter_from_user_mode(regs);
-
-	instrumentation_begin();
-	add_random_kstack_offset();
-
-	/* Validate that this is a soft interrupt to the extent possible */
-	if (unlikely(int80_is_external()))
-		panic("Unexpected external interrupt 0x80\n");
-
-	/*
-	 * The low level idtentry code pushed -1 into regs::orig_ax
-	 * and regs::ax contains the syscall number.
-	 *
-	 * User tracing code (ptrace or signal handlers) might assume
-	 * that the regs::orig_ax contains a 32-bit number on invoking
-	 * a 32-bit syscall.
-	 *
-	 * Establish the syscall convention by saving the 32bit truncated
-	 * syscall number in regs::orig_ax and by invalidating regs::ax.
-	 */
-	regs->orig_ax = regs->ax & GENMASK(31, 0);
-	regs->ax = -ENOSYS;
-
-	nr = syscall_32_enter(regs);
-
-	local_irq_enable();
-	nr = syscall_enter_from_user_mode_work(regs, nr);
-	do_syscall_32_irqs_on(regs, nr);
-
-	instrumentation_end();
-	syscall_exit_to_user_mode(regs);
-}
-
-#ifdef CONFIG_X86_FRED
-/*
- * A FRED-specific INT80 handler is warranted for the follwing reasons:
- *
- * 1) As INT instructions and hardware interrupts are separate event
- *    types, FRED does not preclude the use of vector 0x80 for external
- *    interrupts. As a result, the FRED setup code does not reserve
- *    vector 0x80 and calling int80_is_external() is not merely
- *    suboptimal but actively incorrect: it could cause a system call
- *    to be incorrectly ignored.
- *
- * 2) It is called only for handling vector 0x80 of event type
- *    EVENT_TYPE_SWINT and will never be called to handle any external
- *    interrupt (event type EVENT_TYPE_EXTINT).
- *
- * 3) FRED has separate entry flows depending on if the event came from
- *    user space or kernel space, and because the kernel does not use
- *    INT insns, the FRED kernel entry handler fred_entry_from_kernel()
- *    falls through to fred_bad_type() if the event type is
- *    EVENT_TYPE_SWINT, i.e., INT insns. So if the kernel is handling
- *    an INT insn, it can only be from a user level.
- *
- * 4) int80_emulation() does a CLEAR_BRANCH_HISTORY. While FRED will
- *    likely take a different approach if it is ever needed: it
- *    probably belongs in either fred_intx()/ fred_other() or
- *    asm_fred_entrypoint_user(), depending on if this ought to be done
- *    for all entries from userspace or only system
- *    calls.
- *
- * 5) INT $0x80 is the fast path for 32-bit system calls under FRED.
- */
-DEFINE_FREDENTRY_RAW(int80_emulation)
-{
-	int nr;
-
-	enter_from_user_mode(regs);
-
-	instrumentation_begin();
-	add_random_kstack_offset();
-
-	/*
-	 * FRED pushed 0 into regs::orig_ax and regs::ax contains the
-	 * syscall number.
-	 *
-	 * User tracing code (ptrace or signal handlers) might assume
-	 * that the regs::orig_ax contains a 32-bit number on invoking
-	 * a 32-bit syscall.
-	 *
-	 * Establish the syscall convention by saving the 32bit truncated
-	 * syscall number in regs::orig_ax and by invalidating regs::ax.
-	 */
-	regs->orig_ax = regs->ax & GENMASK(31, 0);
-	regs->ax = -ENOSYS;
-
-	nr = syscall_32_enter(regs);
-
-	local_irq_enable();
-	nr = syscall_enter_from_user_mode_work(regs, nr);
-	do_syscall_32_irqs_on(regs, nr);
-
-	instrumentation_end();
-	syscall_exit_to_user_mode(regs);
-}
-#endif
-#else /* CONFIG_IA32_EMULATION */
-
-/* Handles int $0x80 on a 32bit kernel */
-__visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
-{
-	int nr = syscall_32_enter(regs);
-
-	add_random_kstack_offset();
-	/*
-	 * Subtlety here: if ptrace pokes something larger than 2^31-1 into
-	 * orig_ax, the int return value truncates it. This matches
-	 * the semantics of syscall_get_nr().
-	 */
-	nr = syscall_enter_from_user_mode(regs, nr);
-	instrumentation_begin();
-
-	do_syscall_32_irqs_on(regs, nr);
-
-	instrumentation_end();
-	syscall_exit_to_user_mode(regs);
-}
-#endif /* !CONFIG_IA32_EMULATION */
-
-static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
-{
-	int nr = syscall_32_enter(regs);
-	int res;
-
-	add_random_kstack_offset();
-	/*
-	 * This cannot use syscall_enter_from_user_mode() as it has to
-	 * fetch EBP before invoking any of the syscall entry work
-	 * functions.
-	 */
-	syscall_enter_from_user_mode_prepare(regs);
-
-	instrumentation_begin();
-	/* Fetch EBP from where the vDSO stashed it. */
-	if (IS_ENABLED(CONFIG_X86_64)) {
-		/*
-		 * Micro-optimization: the pointer we're following is
-		 * explicitly 32 bits, so it can't be out of range.
-		 */
-		res = __get_user(*(u32 *)&regs->bp,
-			 (u32 __user __force *)(unsigned long)(u32)regs->sp);
-	} else {
-		res = get_user(*(u32 *)&regs->bp,
-		       (u32 __user __force *)(unsigned long)(u32)regs->sp);
-	}
-
-	if (res) {
-		/* User code screwed up. */
-		regs->ax = -EFAULT;
-
-		local_irq_disable();
-		instrumentation_end();
-		irqentry_exit_to_user_mode(regs);
-		return false;
-	}
-
-	nr = syscall_enter_from_user_mode_work(regs, nr);
-
-	/* Now this is just like a normal syscall. */
-	do_syscall_32_irqs_on(regs, nr);
-
-	instrumentation_end();
-	syscall_exit_to_user_mode(regs);
-	return true;
-}
-
-/* Returns true to return using SYSEXIT/SYSRETL, or false to use IRET */
-__visible noinstr bool do_fast_syscall_32(struct pt_regs *regs)
-{
-	/*
-	 * Called using the internal vDSO SYSENTER/SYSCALL32 calling
-	 * convention.  Adjust regs so it looks like we entered using int80.
-	 */
-	unsigned long landing_pad = (unsigned long)current->mm->context.vdso +
-					vdso_image_32.sym_int80_landing_pad;
-
-	/*
-	 * SYSENTER loses EIP, and even SYSCALL32 needs us to skip forward
-	 * so that 'regs->ip -= 2' lands back on an int $0x80 instruction.
-	 * Fix it up.
-	 */
-	regs->ip = landing_pad;
-
-	/* Invoke the syscall. If it failed, keep it simple: use IRET. */
-	if (!__do_fast_syscall_32(regs))
-		return false;
-
-	/*
-	 * Check that the register state is valid for using SYSRETL/SYSEXIT
-	 * to exit to userspace.  Otherwise use the slower but fully capable
-	 * IRET exit path.
-	 */
-
-	/* XEN PV guests always use the IRET path */
-	if (cpu_feature_enabled(X86_FEATURE_XENPV))
-		return false;
-
-	/* EIP must point to the VDSO landing pad */
-	if (unlikely(regs->ip != landing_pad))
-		return false;
-
-	/* CS and SS must match the values set in MSR_STAR */
-	if (unlikely(regs->cs != __USER32_CS || regs->ss != __USER_DS))
-		return false;
-
-	/* If the TF, RF, or VM flags are set, use IRET */
-	if (unlikely(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF | X86_EFLAGS_VM)))
-		return false;
-
-	/* Use SYSRETL/SYSEXIT to exit to userspace */
-	return true;
-}
-
-/* Returns true to return using SYSEXIT/SYSRETL, or false to use IRET */
-__visible noinstr bool do_SYSENTER_32(struct pt_regs *regs)
-{
-	/* SYSENTER loses RSP, but the vDSO saved it in RBP. */
-	regs->sp = regs->bp;
-
-	/* SYSENTER clobbers EFLAGS.IF.  Assume it was set in usermode. */
-	regs->flags |= X86_EFLAGS_IF;
-
-	return do_fast_syscall_32(regs);
-}
-#endif
-
 SYSCALL_DEFINE0(ni_syscall)
 {
 	return -ENOSYS;
diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 8cc9950..06b9df1 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -1,10 +1,16 @@
-// SPDX-License-Identifier: GPL-2.0
-/* System call table for i386. */
+// SPDX-License-Identifier: GPL-2.0-only
+/* 32-bit system call dispatch */
 
 #include <linux/linkage.h>
 #include <linux/sys.h>
 #include <linux/cache.h>
 #include <linux/syscalls.h>
+#include <linux/entry-common.h>
+#include <linux/nospec.h>
+#include <linux/uaccess.h>
+#include <asm/apic.h>
+#include <asm/traps.h>
+#include <asm/cpufeature.h>
 #include <asm/syscall.h>
 
 #ifdef CONFIG_IA32_EMULATION
@@ -42,3 +48,322 @@ long ia32_sys_call(const struct pt_regs *regs, unsigned int nr)
 	default: return __ia32_sys_ni_syscall(regs);
 	}
 };
+
+static __always_inline int syscall_32_enter(struct pt_regs *regs)
+{
+	if (IS_ENABLED(CONFIG_IA32_EMULATION))
+		current_thread_info()->status |= TS_COMPAT;
+
+	return (int)regs->orig_ax;
+}
+
+#ifdef CONFIG_IA32_EMULATION
+bool __ia32_enabled __ro_after_init = !IS_ENABLED(CONFIG_IA32_EMULATION_DEFAULT_DISABLED);
+
+static int __init ia32_emulation_override_cmdline(char *arg)
+{
+	return kstrtobool(arg, &__ia32_enabled);
+}
+early_param("ia32_emulation", ia32_emulation_override_cmdline);
+#endif
+
+/*
+ * Invoke a 32-bit syscall.  Called with IRQs on in CT_STATE_KERNEL.
+ */
+static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs, int nr)
+{
+	/*
+	 * Convert negative numbers to very high and thus out of range
+	 * numbers for comparisons.
+	 */
+	unsigned int unr = nr;
+
+	if (likely(unr < IA32_NR_syscalls)) {
+		unr = array_index_nospec(unr, IA32_NR_syscalls);
+		regs->ax = ia32_sys_call(regs, unr);
+	} else if (nr != -1) {
+		regs->ax = __ia32_sys_ni_syscall(regs);
+	}
+}
+
+#ifdef CONFIG_IA32_EMULATION
+static __always_inline bool int80_is_external(void)
+{
+	const unsigned int offs = (0x80 / 32) * 0x10;
+	const u32 bit = BIT(0x80 % 32);
+
+	/* The local APIC on XENPV guests is fake */
+	if (cpu_feature_enabled(X86_FEATURE_XENPV))
+		return false;
+
+	/*
+	 * If vector 0x80 is set in the APIC ISR then this is an external
+	 * interrupt. Either from broken hardware or injected by a VMM.
+	 *
+	 * Note: In guest mode this is only valid for secure guests where
+	 * the secure module fully controls the vAPIC exposed to the guest.
+	 */
+	return apic_read(APIC_ISR + offs) & bit;
+}
+
+/**
+ * do_int80_emulation - 32-bit legacy syscall C entry from asm
+ * @regs: syscall arguments in struct pt_args on the stack.
+ *
+ * This entry point can be used by 32-bit and 64-bit programs to perform
+ * 32-bit system calls.  Instances of INT $0x80 can be found inline in
+ * various programs and libraries.  It is also used by the vDSO's
+ * __kernel_vsyscall fallback for hardware that doesn't support a faster
+ * entry method.  Restarted 32-bit system calls also fall back to INT
+ * $0x80 regardless of what instruction was originally used to do the
+ * system call.
+ *
+ * This is considered a slow path.  It is not used by most libc
+ * implementations on modern hardware except during process startup.
+ *
+ * The arguments for the INT $0x80 based syscall are on stack in the
+ * pt_regs structure:
+ *   eax:				system call number
+ *   ebx, ecx, edx, esi, edi, ebp:	arg1 - arg 6
+ */
+__visible noinstr void do_int80_emulation(struct pt_regs *regs)
+{
+	int nr;
+
+	/* Kernel does not use INT $0x80! */
+	if (unlikely(!user_mode(regs))) {
+		irqentry_enter(regs);
+		instrumentation_begin();
+		panic("Unexpected external interrupt 0x80\n");
+	}
+
+	/*
+	 * Establish kernel context for instrumentation, including for
+	 * int80_is_external() below which calls into the APIC driver.
+	 * Identical for soft and external interrupts.
+	 */
+	enter_from_user_mode(regs);
+
+	instrumentation_begin();
+	add_random_kstack_offset();
+
+	/* Validate that this is a soft interrupt to the extent possible */
+	if (unlikely(int80_is_external()))
+		panic("Unexpected external interrupt 0x80\n");
+
+	/*
+	 * The low level idtentry code pushed -1 into regs::orig_ax
+	 * and regs::ax contains the syscall number.
+	 *
+	 * User tracing code (ptrace or signal handlers) might assume
+	 * that the regs::orig_ax contains a 32-bit number on invoking
+	 * a 32-bit syscall.
+	 *
+	 * Establish the syscall convention by saving the 32bit truncated
+	 * syscall number in regs::orig_ax and by invalidating regs::ax.
+	 */
+	regs->orig_ax = regs->ax & GENMASK(31, 0);
+	regs->ax = -ENOSYS;
+
+	nr = syscall_32_enter(regs);
+
+	local_irq_enable();
+	nr = syscall_enter_from_user_mode_work(regs, nr);
+	do_syscall_32_irqs_on(regs, nr);
+
+	instrumentation_end();
+	syscall_exit_to_user_mode(regs);
+}
+
+#ifdef CONFIG_X86_FRED
+/*
+ * A FRED-specific INT80 handler is warranted for the follwing reasons:
+ *
+ * 1) As INT instructions and hardware interrupts are separate event
+ *    types, FRED does not preclude the use of vector 0x80 for external
+ *    interrupts. As a result, the FRED setup code does not reserve
+ *    vector 0x80 and calling int80_is_external() is not merely
+ *    suboptimal but actively incorrect: it could cause a system call
+ *    to be incorrectly ignored.
+ *
+ * 2) It is called only for handling vector 0x80 of event type
+ *    EVENT_TYPE_SWINT and will never be called to handle any external
+ *    interrupt (event type EVENT_TYPE_EXTINT).
+ *
+ * 3) FRED has separate entry flows depending on if the event came from
+ *    user space or kernel space, and because the kernel does not use
+ *    INT insns, the FRED kernel entry handler fred_entry_from_kernel()
+ *    falls through to fred_bad_type() if the event type is
+ *    EVENT_TYPE_SWINT, i.e., INT insns. So if the kernel is handling
+ *    an INT insn, it can only be from a user level.
+ *
+ * 4) int80_emulation() does a CLEAR_BRANCH_HISTORY. While FRED will
+ *    likely take a different approach if it is ever needed: it
+ *    probably belongs in either fred_intx()/ fred_other() or
+ *    asm_fred_entrypoint_user(), depending on if this ought to be done
+ *    for all entries from userspace or only system
+ *    calls.
+ *
+ * 5) INT $0x80 is the fast path for 32-bit system calls under FRED.
+ */
+DEFINE_FREDENTRY_RAW(int80_emulation)
+{
+	int nr;
+
+	enter_from_user_mode(regs);
+
+	instrumentation_begin();
+	add_random_kstack_offset();
+
+	/*
+	 * FRED pushed 0 into regs::orig_ax and regs::ax contains the
+	 * syscall number.
+	 *
+	 * User tracing code (ptrace or signal handlers) might assume
+	 * that the regs::orig_ax contains a 32-bit number on invoking
+	 * a 32-bit syscall.
+	 *
+	 * Establish the syscall convention by saving the 32bit truncated
+	 * syscall number in regs::orig_ax and by invalidating regs::ax.
+	 */
+	regs->orig_ax = regs->ax & GENMASK(31, 0);
+	regs->ax = -ENOSYS;
+
+	nr = syscall_32_enter(regs);
+
+	local_irq_enable();
+	nr = syscall_enter_from_user_mode_work(regs, nr);
+	do_syscall_32_irqs_on(regs, nr);
+
+	instrumentation_end();
+	syscall_exit_to_user_mode(regs);
+}
+#endif
+#else /* CONFIG_IA32_EMULATION */
+
+/* Handles int $0x80 on a 32bit kernel */
+__visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
+{
+	int nr = syscall_32_enter(regs);
+
+	add_random_kstack_offset();
+	/*
+	 * Subtlety here: if ptrace pokes something larger than 2^31-1 into
+	 * orig_ax, the int return value truncates it. This matches
+	 * the semantics of syscall_get_nr().
+	 */
+	nr = syscall_enter_from_user_mode(regs, nr);
+	instrumentation_begin();
+
+	do_syscall_32_irqs_on(regs, nr);
+
+	instrumentation_end();
+	syscall_exit_to_user_mode(regs);
+}
+#endif /* !CONFIG_IA32_EMULATION */
+
+static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
+{
+	int nr = syscall_32_enter(regs);
+	int res;
+
+	add_random_kstack_offset();
+	/*
+	 * This cannot use syscall_enter_from_user_mode() as it has to
+	 * fetch EBP before invoking any of the syscall entry work
+	 * functions.
+	 */
+	syscall_enter_from_user_mode_prepare(regs);
+
+	instrumentation_begin();
+	/* Fetch EBP from where the vDSO stashed it. */
+	if (IS_ENABLED(CONFIG_X86_64)) {
+		/*
+		 * Micro-optimization: the pointer we're following is
+		 * explicitly 32 bits, so it can't be out of range.
+		 */
+		res = __get_user(*(u32 *)&regs->bp,
+			 (u32 __user __force *)(unsigned long)(u32)regs->sp);
+	} else {
+		res = get_user(*(u32 *)&regs->bp,
+		       (u32 __user __force *)(unsigned long)(u32)regs->sp);
+	}
+
+	if (res) {
+		/* User code screwed up. */
+		regs->ax = -EFAULT;
+
+		local_irq_disable();
+		instrumentation_end();
+		irqentry_exit_to_user_mode(regs);
+		return false;
+	}
+
+	nr = syscall_enter_from_user_mode_work(regs, nr);
+
+	/* Now this is just like a normal syscall. */
+	do_syscall_32_irqs_on(regs, nr);
+
+	instrumentation_end();
+	syscall_exit_to_user_mode(regs);
+	return true;
+}
+
+/* Returns true to return using SYSEXIT/SYSRETL, or false to use IRET */
+__visible noinstr bool do_fast_syscall_32(struct pt_regs *regs)
+{
+	/*
+	 * Called using the internal vDSO SYSENTER/SYSCALL32 calling
+	 * convention.  Adjust regs so it looks like we entered using int80.
+	 */
+	unsigned long landing_pad = (unsigned long)current->mm->context.vdso +
+					vdso_image_32.sym_int80_landing_pad;
+
+	/*
+	 * SYSENTER loses EIP, and even SYSCALL32 needs us to skip forward
+	 * so that 'regs->ip -= 2' lands back on an int $0x80 instruction.
+	 * Fix it up.
+	 */
+	regs->ip = landing_pad;
+
+	/* Invoke the syscall. If it failed, keep it simple: use IRET. */
+	if (!__do_fast_syscall_32(regs))
+		return false;
+
+	/*
+	 * Check that the register state is valid for using SYSRETL/SYSEXIT
+	 * to exit to userspace.  Otherwise use the slower but fully capable
+	 * IRET exit path.
+	 */
+
+	/* XEN PV guests always use the IRET path */
+	if (cpu_feature_enabled(X86_FEATURE_XENPV))
+		return false;
+
+	/* EIP must point to the VDSO landing pad */
+	if (unlikely(regs->ip != landing_pad))
+		return false;
+
+	/* CS and SS must match the values set in MSR_STAR */
+	if (unlikely(regs->cs != __USER32_CS || regs->ss != __USER_DS))
+		return false;
+
+	/* If the TF, RF, or VM flags are set, use IRET */
+	if (unlikely(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF | X86_EFLAGS_VM)))
+		return false;
+
+	/* Use SYSRETL/SYSEXIT to exit to userspace */
+	return true;
+}
+
+/* Returns true to return using SYSEXIT/SYSRETL, or false to use IRET */
+__visible noinstr bool do_SYSENTER_32(struct pt_regs *regs)
+{
+	/* SYSENTER loses RSP, but the vDSO saved it in RBP. */
+	regs->sp = regs->bp;
+
+	/* SYSENTER clobbers EFLAGS.IF.  Assume it was set in usermode. */
+	regs->flags |= X86_EFLAGS_IF;
+
+	return do_fast_syscall_32(regs);
+}

