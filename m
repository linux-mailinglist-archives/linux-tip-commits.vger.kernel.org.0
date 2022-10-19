Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BA5603F15
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Oct 2022 11:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiJSJ1g (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 Oct 2022 05:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiJSJ0b (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 Oct 2022 05:26:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721FEE52E0;
        Wed, 19 Oct 2022 02:11:51 -0700 (PDT)
Date:   Wed, 19 Oct 2022 08:55:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666169749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V1dDlFs+fDDgyOyAooGM58SAEWvhy997CVwKDp5qB18=;
        b=oIecEbuSOc9FLunSVkKHLVaxFZfb1rlroTjM+ylrk6+f1FW7YM5FmC+tuTbae63+EVf57O
        toi3Of3kqbPq4YvFeER9aVCyw7rlGX3Z/0SOp6OihmSWPRQebN28TZE5KDeKDLdvDNyBcl
        M+A4jeR89OUNeSdxdDWORlydZbrKakoIIF+nT6XA2ZXoU+5yyPtMKiF2gaNpKw3K2z/ud1
        i7y1uXhL2+GcSznV0ffT+MwBKgClne5iByvqrRGtC4MQ5qPVlTvMN4bvzuk3oWocdz+UN5
        M/v9Bb8URbCMrSuXlBUjLudsCjdb10br1cOWAYElCOsLrTk5SLP4GSbLv5e8KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666169749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V1dDlFs+fDDgyOyAooGM58SAEWvhy997CVwKDp5qB18=;
        b=iAUQ6sI7xQscPPFI37/B79tj5khABa0r7lwlEKDNtHLqIYZXtMbrtA2wGmzqmBY9csebAT
        tzfrm/dqoDpmvUAA==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/signal/64: Move 64-bit signal code to its own file
Cc:     Brian Gerst <brgerst@gmail.com>, Borislav Petkov <bp@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220606203802.158958-9-brgerst@gmail.com>
References: <20220606203802.158958-9-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <166616974023.401.16254729762520245055.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     a545b48c2d907d6096e7bcf65d9b0681cc850e69
Gitweb:        https://git.kernel.org/tip/a545b48c2d907d6096e7bcf65d9b0681cc850e69
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 06 Jun 2022 16:38:02 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 19 Oct 2022 09:58:49 +02:00

x86/signal/64: Move 64-bit signal code to its own file

  [ bp: Fixup merge conflict caused by changes coming from the kbuild tree. ]

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Link: https://lore.kernel.org/r/20220606203802.158958-9-brgerst@gmail.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/Makefile    |   4 +-
 arch/x86/kernel/signal.c    | 376 +----------------------------------
 arch/x86/kernel/signal_64.c | 383 +++++++++++++++++++++++++++++++++++-
 3 files changed, 385 insertions(+), 378 deletions(-)
 create mode 100644 arch/x86/kernel/signal_64.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 72e1371..cceaafd 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -44,7 +44,7 @@ obj-y			+= head_$(BITS).o
 obj-y			+= head$(BITS).o
 obj-y			+= ebda.o
 obj-y			+= platform-quirks.o
-obj-y			+= process_$(BITS).o signal.o
+obj-y			+= process_$(BITS).o signal.o signal_$(BITS).o
 obj-$(CONFIG_COMPAT)	+= signal_compat.o
 obj-y			+= traps.o idt.o irq.o irq_$(BITS).o dumpstack_$(BITS).o
 obj-y			+= time.o ioport.o dumpstack.o nmi.o
@@ -53,7 +53,7 @@ obj-y			+= setup.o x86_init.o i8259.o irqinit.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 obj-$(CONFIG_IRQ_WORK)  += irq_work.o
 obj-y			+= probe_roms.o
-obj-$(CONFIG_X86_32)	+= sys_ia32.o signal_32.o
+obj-$(CONFIG_X86_32)	+= sys_ia32.o
 obj-$(CONFIG_IA32_EMULATION)	+= sys_ia32.o signal_32.o
 obj-$(CONFIG_X86_64)	+= sys_x86_64.o
 obj-$(CONFIG_X86_ESPFIX64)	+= espfix_64.o
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 962cfd8..1504eb8 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -37,13 +37,6 @@
 #include <asm/sighandling.h>
 #include <asm/vm86.h>
 
-#ifdef CONFIG_X86_64
-#include <linux/compat.h>
-#include <asm/proto.h>
-#include <asm/ia32_unistd.h>
-#include <asm/fpu/xstate.h>
-#endif /* CONFIG_X86_64 */
-
 #include <asm/syscall.h>
 #include <asm/sigframe.h>
 #include <asm/signal.h>
@@ -65,135 +58,6 @@ static inline int is_x32_frame(struct ksignal *ksig)
 		ksig->ka.sa.sa_flags & SA_X32_ABI;
 }
 
-#ifdef CONFIG_X86_64
-/*
- * If regs->ss will cause an IRET fault, change it.  Otherwise leave it
- * alone.  Using this generally makes no sense unless
- * user_64bit_mode(regs) would return true.
- */
-static void force_valid_ss(struct pt_regs *regs)
-{
-	u32 ar;
-	asm volatile ("lar %[old_ss], %[ar]\n\t"
-		      "jz 1f\n\t"		/* If invalid: */
-		      "xorl %[ar], %[ar]\n\t"	/* set ar = 0 */
-		      "1:"
-		      : [ar] "=r" (ar)
-		      : [old_ss] "rm" ((u16)regs->ss));
-
-	/*
-	 * For a valid 64-bit user context, we need DPL 3, type
-	 * read-write data or read-write exp-down data, and S and P
-	 * set.  We can't use VERW because VERW doesn't check the
-	 * P bit.
-	 */
-	ar &= AR_DPL_MASK | AR_S | AR_P | AR_TYPE_MASK;
-	if (ar != (AR_DPL3 | AR_S | AR_P | AR_TYPE_RWDATA) &&
-	    ar != (AR_DPL3 | AR_S | AR_P | AR_TYPE_RWDATA_EXPDOWN))
-		regs->ss = __USER_DS;
-}
-
-static bool restore_sigcontext(struct pt_regs *regs,
-			       struct sigcontext __user *usc,
-			       unsigned long uc_flags)
-{
-	struct sigcontext sc;
-
-	/* Always make any pending restarted system calls return -EINTR */
-	current->restart_block.fn = do_no_restart_syscall;
-
-	if (copy_from_user(&sc, usc, offsetof(struct sigcontext, reserved1)))
-		return false;
-
-	regs->bx = sc.bx;
-	regs->cx = sc.cx;
-	regs->dx = sc.dx;
-	regs->si = sc.si;
-	regs->di = sc.di;
-	regs->bp = sc.bp;
-	regs->ax = sc.ax;
-	regs->sp = sc.sp;
-	regs->ip = sc.ip;
-	regs->r8 = sc.r8;
-	regs->r9 = sc.r9;
-	regs->r10 = sc.r10;
-	regs->r11 = sc.r11;
-	regs->r12 = sc.r12;
-	regs->r13 = sc.r13;
-	regs->r14 = sc.r14;
-	regs->r15 = sc.r15;
-
-	/* Get CS/SS and force CPL3 */
-	regs->cs = sc.cs | 0x03;
-	regs->ss = sc.ss | 0x03;
-
-	regs->flags = (regs->flags & ~FIX_EFLAGS) | (sc.flags & FIX_EFLAGS);
-	/* disable syscall checks */
-	regs->orig_ax = -1;
-
-	/*
-	 * Fix up SS if needed for the benefit of old DOSEMU and
-	 * CRIU.
-	 */
-	if (unlikely(!(uc_flags & UC_STRICT_RESTORE_SS) && user_64bit_mode(regs)))
-		force_valid_ss(regs);
-
-	return fpu__restore_sig((void __user *)sc.fpstate, 0);
-}
-
-static __always_inline int
-__unsafe_setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
-		     struct pt_regs *regs, unsigned long mask)
-{
-	unsafe_put_user(regs->di, &sc->di, Efault);
-	unsafe_put_user(regs->si, &sc->si, Efault);
-	unsafe_put_user(regs->bp, &sc->bp, Efault);
-	unsafe_put_user(regs->sp, &sc->sp, Efault);
-	unsafe_put_user(regs->bx, &sc->bx, Efault);
-	unsafe_put_user(regs->dx, &sc->dx, Efault);
-	unsafe_put_user(regs->cx, &sc->cx, Efault);
-	unsafe_put_user(regs->ax, &sc->ax, Efault);
-	unsafe_put_user(regs->r8, &sc->r8, Efault);
-	unsafe_put_user(regs->r9, &sc->r9, Efault);
-	unsafe_put_user(regs->r10, &sc->r10, Efault);
-	unsafe_put_user(regs->r11, &sc->r11, Efault);
-	unsafe_put_user(regs->r12, &sc->r12, Efault);
-	unsafe_put_user(regs->r13, &sc->r13, Efault);
-	unsafe_put_user(regs->r14, &sc->r14, Efault);
-	unsafe_put_user(regs->r15, &sc->r15, Efault);
-
-	unsafe_put_user(current->thread.trap_nr, &sc->trapno, Efault);
-	unsafe_put_user(current->thread.error_code, &sc->err, Efault);
-	unsafe_put_user(regs->ip, &sc->ip, Efault);
-	unsafe_put_user(regs->flags, &sc->flags, Efault);
-	unsafe_put_user(regs->cs, &sc->cs, Efault);
-	unsafe_put_user(0, &sc->gs, Efault);
-	unsafe_put_user(0, &sc->fs, Efault);
-	unsafe_put_user(regs->ss, &sc->ss, Efault);
-
-	unsafe_put_user(fpstate, (unsigned long __user *)&sc->fpstate, Efault);
-
-	/* non-iBCS2 extensions.. */
-	unsafe_put_user(mask, &sc->oldmask, Efault);
-	unsafe_put_user(current->thread.cr2, &sc->cr2, Efault);
-	return 0;
-Efault:
-	return -EFAULT;
-}
-
-#define unsafe_put_sigcontext(sc, fp, regs, set, label)			\
-do {									\
-	if (__unsafe_setup_sigcontext(sc, fp, regs, set->sig[0]))	\
-		goto label;						\
-} while(0);
-
-#define unsafe_put_sigmask(set, frame, label) \
-	unsafe_put_user(*(__u64 *)(set), \
-			(__u64 __user *)&(frame)->uc.uc_sigmask, \
-			label)
-
-#endif /* CONFIG_X86_64 */
-
 /*
  * Set up a signal frame.
  */
@@ -279,213 +143,6 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
 	return (void __user *)sp;
 }
 
-#ifdef CONFIG_X86_64
-static unsigned long frame_uc_flags(struct pt_regs *regs)
-{
-	unsigned long flags;
-
-	if (boot_cpu_has(X86_FEATURE_XSAVE))
-		flags = UC_FP_XSTATE | UC_SIGCONTEXT_SS;
-	else
-		flags = UC_SIGCONTEXT_SS;
-
-	if (likely(user_64bit_mode(regs)))
-		flags |= UC_STRICT_RESTORE_SS;
-
-	return flags;
-}
-
-int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
-{
-	sigset_t *set = sigmask_to_save();
-	struct rt_sigframe __user *frame;
-	void __user *fp = NULL;
-	unsigned long uc_flags;
-
-	/* x86-64 should always use SA_RESTORER. */
-	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
-		return -EFAULT;
-
-	frame = get_sigframe(ksig, regs, sizeof(struct rt_sigframe), &fp);
-	uc_flags = frame_uc_flags(regs);
-
-	if (!user_access_begin(frame, sizeof(*frame)))
-		return -EFAULT;
-
-	/* Create the ucontext.  */
-	unsafe_put_user(uc_flags, &frame->uc.uc_flags, Efault);
-	unsafe_put_user(0, &frame->uc.uc_link, Efault);
-	unsafe_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
-
-	/* Set up to return from userspace.  If provided, use a stub
-	   already in userspace.  */
-	unsafe_put_user(ksig->ka.sa.sa_restorer, &frame->pretcode, Efault);
-	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
-	unsafe_put_sigmask(set, frame, Efault);
-	user_access_end();
-
-	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
-		if (copy_siginfo_to_user(&frame->info, &ksig->info))
-			return -EFAULT;
-	}
-
-	/* Set up registers for signal handler */
-	regs->di = ksig->sig;
-	/* In case the signal handler was declared without prototypes */
-	regs->ax = 0;
-
-	/* This also works for non SA_SIGINFO handlers because they expect the
-	   next argument after the signal number on the stack. */
-	regs->si = (unsigned long)&frame->info;
-	regs->dx = (unsigned long)&frame->uc;
-	regs->ip = (unsigned long) ksig->ka.sa.sa_handler;
-
-	regs->sp = (unsigned long)frame;
-
-	/*
-	 * Set up the CS and SS registers to run signal handlers in
-	 * 64-bit mode, even if the handler happens to be interrupting
-	 * 32-bit or 16-bit code.
-	 *
-	 * SS is subtle.  In 64-bit mode, we don't need any particular
-	 * SS descriptor, but we do need SS to be valid.  It's possible
-	 * that the old SS is entirely bogus -- this can happen if the
-	 * signal we're trying to deliver is #GP or #SS caused by a bad
-	 * SS value.  We also have a compatibility issue here: DOSEMU
-	 * relies on the contents of the SS register indicating the
-	 * SS value at the time of the signal, even though that code in
-	 * DOSEMU predates sigreturn's ability to restore SS.  (DOSEMU
-	 * avoids relying on sigreturn to restore SS; instead it uses
-	 * a trampoline.)  So we do our best: if the old SS was valid,
-	 * we keep it.  Otherwise we replace it.
-	 */
-	regs->cs = __USER_CS;
-
-	if (unlikely(regs->ss != __USER_DS))
-		force_valid_ss(regs);
-
-	return 0;
-
-Efault:
-	user_access_end();
-	return -EFAULT;
-}
-
-#ifdef CONFIG_X86_X32_ABI
-static int x32_copy_siginfo_to_user(struct compat_siginfo __user *to,
-		const struct kernel_siginfo *from)
-{
-	struct compat_siginfo new;
-
-	copy_siginfo_to_external32(&new, from);
-	if (from->si_signo == SIGCHLD) {
-		new._sifields._sigchld_x32._utime = from->si_utime;
-		new._sifields._sigchld_x32._stime = from->si_stime;
-	}
-	if (copy_to_user(to, &new, sizeof(struct compat_siginfo)))
-		return -EFAULT;
-	return 0;
-}
-
-int copy_siginfo_to_user32(struct compat_siginfo __user *to,
-			   const struct kernel_siginfo *from)
-{
-	if (in_x32_syscall())
-		return x32_copy_siginfo_to_user(to, from);
-	return __copy_siginfo_to_user32(to, from);
-}
-
-int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
-{
-	compat_sigset_t *set = (compat_sigset_t *) sigmask_to_save();
-	struct rt_sigframe_x32 __user *frame;
-	unsigned long uc_flags;
-	void __user *restorer;
-	void __user *fp = NULL;
-
-	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
-		return -EFAULT;
-
-	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
-
-	uc_flags = frame_uc_flags(regs);
-
-	if (!user_access_begin(frame, sizeof(*frame)))
-		return -EFAULT;
-
-	/* Create the ucontext.  */
-	unsafe_put_user(uc_flags, &frame->uc.uc_flags, Efault);
-	unsafe_put_user(0, &frame->uc.uc_link, Efault);
-	unsafe_compat_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
-	unsafe_put_user(0, &frame->uc.uc__pad0, Efault);
-	restorer = ksig->ka.sa.sa_restorer;
-	unsafe_put_user(restorer, (unsigned long __user *)&frame->pretcode, Efault);
-	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
-	unsafe_put_sigmask(set, frame, Efault);
-	user_access_end();
-
-	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
-		if (x32_copy_siginfo_to_user(&frame->info, &ksig->info))
-			return -EFAULT;
-	}
-
-	/* Set up registers for signal handler */
-	regs->sp = (unsigned long) frame;
-	regs->ip = (unsigned long) ksig->ka.sa.sa_handler;
-
-	/* We use the x32 calling convention here... */
-	regs->di = ksig->sig;
-	regs->si = (unsigned long) &frame->info;
-	regs->dx = (unsigned long) &frame->uc;
-
-	loadsegment(ds, __USER_DS);
-	loadsegment(es, __USER_DS);
-
-	regs->cs = __USER_CS;
-	regs->ss = __USER_DS;
-
-	return 0;
-
-Efault:
-	user_access_end();
-	return -EFAULT;
-}
-#endif /* CONFIG_X86_X32_ABI */
-
-/*
- * Do a signal return; undo the signal stack.
- */
-SYSCALL_DEFINE0(rt_sigreturn)
-{
-	struct pt_regs *regs = current_pt_regs();
-	struct rt_sigframe __user *frame;
-	sigset_t set;
-	unsigned long uc_flags;
-
-	frame = (struct rt_sigframe __user *)(regs->sp - sizeof(long));
-	if (!access_ok(frame, sizeof(*frame)))
-		goto badframe;
-	if (__get_user(*(__u64 *)&set, (__u64 __user *)&frame->uc.uc_sigmask))
-		goto badframe;
-	if (__get_user(uc_flags, &frame->uc.uc_flags))
-		goto badframe;
-
-	set_current_blocked(&set);
-
-	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
-		goto badframe;
-
-	if (restore_altstack(&frame->uc.uc_stack))
-		goto badframe;
-
-	return regs->ax;
-
-badframe:
-	signal_fault(regs, frame, "rt_sigreturn");
-	return 0;
-}
-#endif /* CONFIG_X86_64 */
-
 /*
  * There are four different struct types for signal frame: sigframe_ia32,
  * rt_sigframe_ia32, rt_sigframe_x32, and rt_sigframe. Use the worst case
@@ -749,36 +406,3 @@ bool sigaltstack_size_valid(size_t ss_size)
 	return true;
 }
 #endif /* CONFIG_DYNAMIC_SIGFRAME */
-
-#ifdef CONFIG_X86_X32_ABI
-COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
-{
-	struct pt_regs *regs = current_pt_regs();
-	struct rt_sigframe_x32 __user *frame;
-	sigset_t set;
-	unsigned long uc_flags;
-
-	frame = (struct rt_sigframe_x32 __user *)(regs->sp - 8);
-
-	if (!access_ok(frame, sizeof(*frame)))
-		goto badframe;
-	if (__get_user(set.sig[0], (__u64 __user *)&frame->uc.uc_sigmask))
-		goto badframe;
-	if (__get_user(uc_flags, &frame->uc.uc_flags))
-		goto badframe;
-
-	set_current_blocked(&set);
-
-	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
-		goto badframe;
-
-	if (compat_restore_altstack(&frame->uc.uc_stack))
-		goto badframe;
-
-	return regs->ax;
-
-badframe:
-	signal_fault(regs, frame, "x32 rt_sigreturn");
-	return 0;
-}
-#endif
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
new file mode 100644
index 0000000..ff9c550
--- /dev/null
+++ b/arch/x86/kernel/signal_64.c
@@ -0,0 +1,383 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ *  Copyright (C) 2000, 2001, 2002 Andi Kleen SuSE Labs
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/unistd.h>
+#include <linux/uaccess.h>
+#include <linux/syscalls.h>
+
+#include <asm/ucontext.h>
+#include <asm/fpu/signal.h>
+#include <asm/sighandling.h>
+
+#include <asm/syscall.h>
+#include <asm/sigframe.h>
+#include <asm/signal.h>
+
+/*
+ * If regs->ss will cause an IRET fault, change it.  Otherwise leave it
+ * alone.  Using this generally makes no sense unless
+ * user_64bit_mode(regs) would return true.
+ */
+static void force_valid_ss(struct pt_regs *regs)
+{
+	u32 ar;
+	asm volatile ("lar %[old_ss], %[ar]\n\t"
+		      "jz 1f\n\t"		/* If invalid: */
+		      "xorl %[ar], %[ar]\n\t"	/* set ar = 0 */
+		      "1:"
+		      : [ar] "=r" (ar)
+		      : [old_ss] "rm" ((u16)regs->ss));
+
+	/*
+	 * For a valid 64-bit user context, we need DPL 3, type
+	 * read-write data or read-write exp-down data, and S and P
+	 * set.  We can't use VERW because VERW doesn't check the
+	 * P bit.
+	 */
+	ar &= AR_DPL_MASK | AR_S | AR_P | AR_TYPE_MASK;
+	if (ar != (AR_DPL3 | AR_S | AR_P | AR_TYPE_RWDATA) &&
+	    ar != (AR_DPL3 | AR_S | AR_P | AR_TYPE_RWDATA_EXPDOWN))
+		regs->ss = __USER_DS;
+}
+
+static bool restore_sigcontext(struct pt_regs *regs,
+			       struct sigcontext __user *usc,
+			       unsigned long uc_flags)
+{
+	struct sigcontext sc;
+
+	/* Always make any pending restarted system calls return -EINTR */
+	current->restart_block.fn = do_no_restart_syscall;
+
+	if (copy_from_user(&sc, usc, offsetof(struct sigcontext, reserved1)))
+		return false;
+
+	regs->bx = sc.bx;
+	regs->cx = sc.cx;
+	regs->dx = sc.dx;
+	regs->si = sc.si;
+	regs->di = sc.di;
+	regs->bp = sc.bp;
+	regs->ax = sc.ax;
+	regs->sp = sc.sp;
+	regs->ip = sc.ip;
+	regs->r8 = sc.r8;
+	regs->r9 = sc.r9;
+	regs->r10 = sc.r10;
+	regs->r11 = sc.r11;
+	regs->r12 = sc.r12;
+	regs->r13 = sc.r13;
+	regs->r14 = sc.r14;
+	regs->r15 = sc.r15;
+
+	/* Get CS/SS and force CPL3 */
+	regs->cs = sc.cs | 0x03;
+	regs->ss = sc.ss | 0x03;
+
+	regs->flags = (regs->flags & ~FIX_EFLAGS) | (sc.flags & FIX_EFLAGS);
+	/* disable syscall checks */
+	regs->orig_ax = -1;
+
+	/*
+	 * Fix up SS if needed for the benefit of old DOSEMU and
+	 * CRIU.
+	 */
+	if (unlikely(!(uc_flags & UC_STRICT_RESTORE_SS) && user_64bit_mode(regs)))
+		force_valid_ss(regs);
+
+	return fpu__restore_sig((void __user *)sc.fpstate, 0);
+}
+
+static __always_inline int
+__unsafe_setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
+		     struct pt_regs *regs, unsigned long mask)
+{
+	unsafe_put_user(regs->di, &sc->di, Efault);
+	unsafe_put_user(regs->si, &sc->si, Efault);
+	unsafe_put_user(regs->bp, &sc->bp, Efault);
+	unsafe_put_user(regs->sp, &sc->sp, Efault);
+	unsafe_put_user(regs->bx, &sc->bx, Efault);
+	unsafe_put_user(regs->dx, &sc->dx, Efault);
+	unsafe_put_user(regs->cx, &sc->cx, Efault);
+	unsafe_put_user(regs->ax, &sc->ax, Efault);
+	unsafe_put_user(regs->r8, &sc->r8, Efault);
+	unsafe_put_user(regs->r9, &sc->r9, Efault);
+	unsafe_put_user(regs->r10, &sc->r10, Efault);
+	unsafe_put_user(regs->r11, &sc->r11, Efault);
+	unsafe_put_user(regs->r12, &sc->r12, Efault);
+	unsafe_put_user(regs->r13, &sc->r13, Efault);
+	unsafe_put_user(regs->r14, &sc->r14, Efault);
+	unsafe_put_user(regs->r15, &sc->r15, Efault);
+
+	unsafe_put_user(current->thread.trap_nr, &sc->trapno, Efault);
+	unsafe_put_user(current->thread.error_code, &sc->err, Efault);
+	unsafe_put_user(regs->ip, &sc->ip, Efault);
+	unsafe_put_user(regs->flags, &sc->flags, Efault);
+	unsafe_put_user(regs->cs, &sc->cs, Efault);
+	unsafe_put_user(0, &sc->gs, Efault);
+	unsafe_put_user(0, &sc->fs, Efault);
+	unsafe_put_user(regs->ss, &sc->ss, Efault);
+
+	unsafe_put_user(fpstate, (unsigned long __user *)&sc->fpstate, Efault);
+
+	/* non-iBCS2 extensions.. */
+	unsafe_put_user(mask, &sc->oldmask, Efault);
+	unsafe_put_user(current->thread.cr2, &sc->cr2, Efault);
+	return 0;
+Efault:
+	return -EFAULT;
+}
+
+#define unsafe_put_sigcontext(sc, fp, regs, set, label)			\
+do {									\
+	if (__unsafe_setup_sigcontext(sc, fp, regs, set->sig[0]))	\
+		goto label;						\
+} while(0);
+
+#define unsafe_put_sigmask(set, frame, label) \
+	unsafe_put_user(*(__u64 *)(set), \
+			(__u64 __user *)&(frame)->uc.uc_sigmask, \
+			label)
+
+static unsigned long frame_uc_flags(struct pt_regs *regs)
+{
+	unsigned long flags;
+
+	if (boot_cpu_has(X86_FEATURE_XSAVE))
+		flags = UC_FP_XSTATE | UC_SIGCONTEXT_SS;
+	else
+		flags = UC_SIGCONTEXT_SS;
+
+	if (likely(user_64bit_mode(regs)))
+		flags |= UC_STRICT_RESTORE_SS;
+
+	return flags;
+}
+
+int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
+{
+	sigset_t *set = sigmask_to_save();
+	struct rt_sigframe __user *frame;
+	void __user *fp = NULL;
+	unsigned long uc_flags;
+
+	/* x86-64 should always use SA_RESTORER. */
+	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
+		return -EFAULT;
+
+	frame = get_sigframe(ksig, regs, sizeof(struct rt_sigframe), &fp);
+	uc_flags = frame_uc_flags(regs);
+
+	if (!user_access_begin(frame, sizeof(*frame)))
+		return -EFAULT;
+
+	/* Create the ucontext.  */
+	unsafe_put_user(uc_flags, &frame->uc.uc_flags, Efault);
+	unsafe_put_user(0, &frame->uc.uc_link, Efault);
+	unsafe_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
+
+	/* Set up to return from userspace.  If provided, use a stub
+	   already in userspace.  */
+	unsafe_put_user(ksig->ka.sa.sa_restorer, &frame->pretcode, Efault);
+	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
+	unsafe_put_sigmask(set, frame, Efault);
+	user_access_end();
+
+	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
+		if (copy_siginfo_to_user(&frame->info, &ksig->info))
+			return -EFAULT;
+	}
+
+	/* Set up registers for signal handler */
+	regs->di = ksig->sig;
+	/* In case the signal handler was declared without prototypes */
+	regs->ax = 0;
+
+	/* This also works for non SA_SIGINFO handlers because they expect the
+	   next argument after the signal number on the stack. */
+	regs->si = (unsigned long)&frame->info;
+	regs->dx = (unsigned long)&frame->uc;
+	regs->ip = (unsigned long) ksig->ka.sa.sa_handler;
+
+	regs->sp = (unsigned long)frame;
+
+	/*
+	 * Set up the CS and SS registers to run signal handlers in
+	 * 64-bit mode, even if the handler happens to be interrupting
+	 * 32-bit or 16-bit code.
+	 *
+	 * SS is subtle.  In 64-bit mode, we don't need any particular
+	 * SS descriptor, but we do need SS to be valid.  It's possible
+	 * that the old SS is entirely bogus -- this can happen if the
+	 * signal we're trying to deliver is #GP or #SS caused by a bad
+	 * SS value.  We also have a compatibility issue here: DOSEMU
+	 * relies on the contents of the SS register indicating the
+	 * SS value at the time of the signal, even though that code in
+	 * DOSEMU predates sigreturn's ability to restore SS.  (DOSEMU
+	 * avoids relying on sigreturn to restore SS; instead it uses
+	 * a trampoline.)  So we do our best: if the old SS was valid,
+	 * we keep it.  Otherwise we replace it.
+	 */
+	regs->cs = __USER_CS;
+
+	if (unlikely(regs->ss != __USER_DS))
+		force_valid_ss(regs);
+
+	return 0;
+
+Efault:
+	user_access_end();
+	return -EFAULT;
+}
+
+/*
+ * Do a signal return; undo the signal stack.
+ */
+SYSCALL_DEFINE0(rt_sigreturn)
+{
+	struct pt_regs *regs = current_pt_regs();
+	struct rt_sigframe __user *frame;
+	sigset_t set;
+	unsigned long uc_flags;
+
+	frame = (struct rt_sigframe __user *)(regs->sp - sizeof(long));
+	if (!access_ok(frame, sizeof(*frame)))
+		goto badframe;
+	if (__get_user(*(__u64 *)&set, (__u64 __user *)&frame->uc.uc_sigmask))
+		goto badframe;
+	if (__get_user(uc_flags, &frame->uc.uc_flags))
+		goto badframe;
+
+	set_current_blocked(&set);
+
+	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
+		goto badframe;
+
+	if (restore_altstack(&frame->uc.uc_stack))
+		goto badframe;
+
+	return regs->ax;
+
+badframe:
+	signal_fault(regs, frame, "rt_sigreturn");
+	return 0;
+}
+
+#ifdef CONFIG_X86_X32_ABI
+static int x32_copy_siginfo_to_user(struct compat_siginfo __user *to,
+		const struct kernel_siginfo *from)
+{
+	struct compat_siginfo new;
+
+	copy_siginfo_to_external32(&new, from);
+	if (from->si_signo == SIGCHLD) {
+		new._sifields._sigchld_x32._utime = from->si_utime;
+		new._sifields._sigchld_x32._stime = from->si_stime;
+	}
+	if (copy_to_user(to, &new, sizeof(struct compat_siginfo)))
+		return -EFAULT;
+	return 0;
+}
+
+int copy_siginfo_to_user32(struct compat_siginfo __user *to,
+			   const struct kernel_siginfo *from)
+{
+	if (in_x32_syscall())
+		return x32_copy_siginfo_to_user(to, from);
+	return __copy_siginfo_to_user32(to, from);
+}
+
+int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
+{
+	compat_sigset_t *set = (compat_sigset_t *) sigmask_to_save();
+	struct rt_sigframe_x32 __user *frame;
+	unsigned long uc_flags;
+	void __user *restorer;
+	void __user *fp = NULL;
+
+	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
+		return -EFAULT;
+
+	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
+
+	uc_flags = frame_uc_flags(regs);
+
+	if (!user_access_begin(frame, sizeof(*frame)))
+		return -EFAULT;
+
+	/* Create the ucontext.  */
+	unsafe_put_user(uc_flags, &frame->uc.uc_flags, Efault);
+	unsafe_put_user(0, &frame->uc.uc_link, Efault);
+	unsafe_compat_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
+	unsafe_put_user(0, &frame->uc.uc__pad0, Efault);
+	restorer = ksig->ka.sa.sa_restorer;
+	unsafe_put_user(restorer, (unsigned long __user *)&frame->pretcode, Efault);
+	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
+	unsafe_put_sigmask(set, frame, Efault);
+	user_access_end();
+
+	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
+		if (x32_copy_siginfo_to_user(&frame->info, &ksig->info))
+			return -EFAULT;
+	}
+
+	/* Set up registers for signal handler */
+	regs->sp = (unsigned long) frame;
+	regs->ip = (unsigned long) ksig->ka.sa.sa_handler;
+
+	/* We use the x32 calling convention here... */
+	regs->di = ksig->sig;
+	regs->si = (unsigned long) &frame->info;
+	regs->dx = (unsigned long) &frame->uc;
+
+	loadsegment(ds, __USER_DS);
+	loadsegment(es, __USER_DS);
+
+	regs->cs = __USER_CS;
+	regs->ss = __USER_DS;
+
+	return 0;
+
+Efault:
+	user_access_end();
+	return -EFAULT;
+}
+
+COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
+{
+	struct pt_regs *regs = current_pt_regs();
+	struct rt_sigframe_x32 __user *frame;
+	sigset_t set;
+	unsigned long uc_flags;
+
+	frame = (struct rt_sigframe_x32 __user *)(regs->sp - 8);
+
+	if (!access_ok(frame, sizeof(*frame)))
+		goto badframe;
+	if (__get_user(set.sig[0], (__u64 __user *)&frame->uc.uc_sigmask))
+		goto badframe;
+	if (__get_user(uc_flags, &frame->uc.uc_flags))
+		goto badframe;
+
+	set_current_blocked(&set);
+
+	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
+		goto badframe;
+
+	if (compat_restore_altstack(&frame->uc.uc_stack))
+		goto badframe;
+
+	return regs->ax;
+
+badframe:
+	signal_fault(regs, frame, "x32 rt_sigreturn");
+	return 0;
+}
+#endif /* CONFIG_X86_X32_ABI */
