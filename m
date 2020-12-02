Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DC32CB924
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Dec 2020 10:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388343AbgLBJjm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Dec 2020 04:39:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:32926 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388268AbgLBJjO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Dec 2020 04:39:14 -0500
Date:   Wed, 02 Dec 2020 09:38:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606901908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rrIizE087zSlEasSd0mMfR2xeHFsqhbpT0+PsOEE44k=;
        b=oUnF15QFCVA1Myxz2/BLiPzU21sy7COmtKri0cCRiv0UrQyJ3nYXQ/wv1u+e/LWqxJKwLZ
        wopcXagqXW1gjJG/Mz1tnwG+OjrAc33gw9hxrJxWoBT1wk9VnUwSpOLWe1rxuMpZXxmsNp
        HfnQy3umkOlAQZrarRI6UWEqnOnddh0uqgVl8rIPA0kidLaNoDbuPC5O+CZg42PHuTAq1r
        xWQ7RsG4jDcDrvaosUCmOZ+7tce33c2Bu5AufEg8kMcKyXu9j+gJTtat1Je+E8XPEz4NR0
        7b416O1N4ikaNIJgWzLKcWn71MxWDQBzIxWIxUV6IcwYussvplWynbpsA4f1hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606901908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rrIizE087zSlEasSd0mMfR2xeHFsqhbpT0+PsOEE44k=;
        b=nuzNxxX9evaG7odlzS0CXG4XNoM2kiQ14XlAsY0Ta4DwVl4wue7BXt4kpchfEr8xqBtz0+
        AvRfwboGezcf3VAQ==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] x86: vdso: Expose sigreturn address on vdso to the kernel
Cc:     Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201127193238.821364-2-krisman@collabora.com>
References: <20201127193238.821364-2-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <160690190792.3364.12611035102051376028.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     c5c878125ad5aca199dfc10b1af4010165aaa596
Gitweb:        https://git.kernel.org/tip/c5c878125ad5aca199dfc10b1af4010165aaa596
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Fri, 27 Nov 2020 14:32:32 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Dec 2020 10:32:16 +01:00

x86: vdso: Expose sigreturn address on vdso to the kernel

Syscall user redirection requires the signal trampoline code to not be
captured, in order to support returning with a locked selector while
avoiding recursion back into the signal handler.  For ia-32, which has
the trampoline in the vDSO, expose the entry points to the kernel, such
that it can avoid dispatching syscalls from that region to userspace.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20201127193238.821364-2-krisman@collabora.com

---
 arch/x86/entry/vdso/vdso2c.c           |  2 ++
 arch/x86/entry/vdso/vdso32/sigreturn.S |  2 ++
 arch/x86/entry/vdso/vma.c              | 15 +++++++++++++++
 arch/x86/include/asm/elf.h             |  2 ++
 arch/x86/include/asm/vdso.h            |  2 ++
 5 files changed, 23 insertions(+)

diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 7380908..2d0f3d8 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -101,6 +101,8 @@ struct vdso_sym required_syms[] = {
 	{"__kernel_sigreturn", true},
 	{"__kernel_rt_sigreturn", true},
 	{"int80_landing_pad", true},
+	{"vdso32_rt_sigreturn_landing_pad", true},
+	{"vdso32_sigreturn_landing_pad", true},
 };
 
 __attribute__((format(printf, 1, 2))) __attribute__((noreturn))
diff --git a/arch/x86/entry/vdso/vdso32/sigreturn.S b/arch/x86/entry/vdso/vdso32/sigreturn.S
index c3233ee..1bd068f 100644
--- a/arch/x86/entry/vdso/vdso32/sigreturn.S
+++ b/arch/x86/entry/vdso/vdso32/sigreturn.S
@@ -18,6 +18,7 @@ __kernel_sigreturn:
 	movl $__NR_sigreturn, %eax
 	SYSCALL_ENTER_KERNEL
 .LEND_sigreturn:
+SYM_INNER_LABEL(vdso32_sigreturn_landing_pad, SYM_L_GLOBAL)
 	nop
 	.size __kernel_sigreturn,.-.LSTART_sigreturn
 
@@ -29,6 +30,7 @@ __kernel_rt_sigreturn:
 	movl $__NR_rt_sigreturn, %eax
 	SYSCALL_ENTER_KERNEL
 .LEND_rt_sigreturn:
+SYM_INNER_LABEL(vdso32_rt_sigreturn_landing_pad, SYM_L_GLOBAL)
 	nop
 	.size __kernel_rt_sigreturn,.-.LSTART_rt_sigreturn
 	.previous
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 50e5d3a..de60cd3 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -436,6 +436,21 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 }
 #endif
 
+bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
+{
+#if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
+	const struct vdso_image *image = current->mm->context.vdso_image;
+	unsigned long vdso = (unsigned long) current->mm->context.vdso;
+
+	if (in_ia32_syscall() && image == &vdso_image_32) {
+		if (regs->ip == vdso + image->sym_vdso32_sigreturn_landing_pad ||
+		    regs->ip == vdso + image->sym_vdso32_rt_sigreturn_landing_pad)
+			return true;
+	}
+#endif
+	return false;
+}
+
 #ifdef CONFIG_X86_64
 static __init int vdso_setup(char *s)
 {
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 44a9b99..66bdfe8 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -388,6 +388,8 @@ extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
 	compat_arch_setup_additional_pages(bprm, interpreter,		\
 					   (ex->e_machine == EM_X86_64))
 
+extern bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs);
+
 /* Do not change the values. See get_align_mask() */
 enum align_flags {
 	ALIGN_VA_32	= BIT(0),
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index bbcdc7b..589f489 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -27,6 +27,8 @@ struct vdso_image {
 	long sym___kernel_rt_sigreturn;
 	long sym___kernel_vsyscall;
 	long sym_int80_landing_pad;
+	long sym_vdso32_sigreturn_landing_pad;
+	long sym_vdso32_rt_sigreturn_landing_pad;
 };
 
 #ifdef CONFIG_X86_64
