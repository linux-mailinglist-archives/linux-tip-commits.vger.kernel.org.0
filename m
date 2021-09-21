Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A37412F6D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Sep 2021 09:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhIUH3k (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 21 Sep 2021 03:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhIUH3g (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 21 Sep 2021 03:29:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04657C061762;
        Tue, 21 Sep 2021 00:28:08 -0700 (PDT)
Date:   Tue, 21 Sep 2021 07:28:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632209286;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NWwLEEw6WlW9jLgzDSQFExKwmlbCC9KpNskPgeJc818=;
        b=q95K4BSmzHfEYbppWeVPbUs/OX15veR1Q6zjM7YgnP0rn5sizAgydsFI4b3ORJ4aFNw/W9
        60t4/EwEy4MjrV8NOjUWvr7LQXXechk3sPUjHzF+jvZxQ32YnIIrmhM5t5cBxEuWYfvNDZ
        kiNV8icSfyk+7ER07iIbdtJT99reVSuk+EH84N1sZmKmnVoujPWKc5QVa8fsdPyZiK97sY
        sKrwZPfynXro2OvpqT4mpEyvyAuw7vM3ibaTFEZ0fqTh9yxE7FjnXqOmWcfIZ2+4EvV7C+
        U6hA9X8ozAtWLV/fs3hZ4rcSfEvBxsV67HhtXVNzPHkHRj+uUXl3pw6pfxJntA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632209286;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NWwLEEw6WlW9jLgzDSQFExKwmlbCC9KpNskPgeJc818=;
        b=HtHih6u1YPIejliryOq3JHay0cHOM6TxnNUDI8TbhDsCFkHdgSJBJIGgvHklsm3eSKhxvx
        XS13JQr74weuFKCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/iopl: Fake iopl(3) CLI/STI usage
Cc:     Ondrej Zary <linux@zary.sk>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210918090641.GD5106@worktop.programming.kicks-ass.net>
References: <20210918090641.GD5106@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <163220928593.25758.16098239507716851071.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     32e1ae626f295152d1fc9a3375214133cbe62878
Gitweb:        https://git.kernel.org/tip/32e1ae626f295152d1fc9a3375214133cbe62878
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 17 Sep 2021 11:20:04 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 18 Sep 2021 12:18:32 +02:00

x86/iopl: Fake iopl(3) CLI/STI usage

Since commit c8137ace5638 ("x86/iopl: Restrict iopl() permission
scope") it's possible to emulate iopl(3) using ioperm(), except for
the CLI/STI usage.

Userspace CLI/STI usage is very dubious (read broken), since any
exception taken during that window can lead to rescheduling anyway (or
worse). The IOPL(2) manpage even states that usage of CLI/STI is highly
discouraged and might even crash the system.

Of course, that won't stop people and HP has the dubious honour of
being the first vendor to be found using this in their hp-health
package.

In order to enable this 'software' to still 'work', have the #GP treat
the CLI/STI instructions as NOPs when iopl(3). Warn the user that
their program is doing dubious things.

Fixes: a24ca9976843 ("x86/iopl: Remove legacy IOPL option")
Reported-by: Ondrej Zary <linux@zary.sk>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20210918090641.GD5106@worktop.programming.kicks-ass.net
---
 arch/x86/include/asm/insn-eval.h |  1 +-
 arch/x86/include/asm/processor.h |  1 +-
 arch/x86/kernel/process.c        |  1 +-
 arch/x86/kernel/traps.c          | 33 +++++++++++++++++++++++++++++++-
 arch/x86/lib/insn-eval.c         |  2 +-
 5 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index 91d7182..4ec3613 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -21,6 +21,7 @@ int insn_get_modrm_rm_off(struct insn *insn, struct pt_regs *regs);
 int insn_get_modrm_reg_off(struct insn *insn, struct pt_regs *regs);
 unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx);
 int insn_get_code_seg_params(struct pt_regs *regs);
+int insn_get_effective_ip(struct pt_regs *regs, unsigned long *ip);
 int insn_fetch_from_user(struct pt_regs *regs,
 			 unsigned char buf[MAX_INSN_SIZE]);
 int insn_fetch_from_user_inatomic(struct pt_regs *regs,
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 9ad2aca..577f342 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -518,6 +518,7 @@ struct thread_struct {
 	 */
 	unsigned long		iopl_emul;
 
+	unsigned int		iopl_warn:1;
 	unsigned int		sig_on_uaccess_err:1;
 
 	/*
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1d9463e..f2f733b 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -132,6 +132,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	frame->ret_addr = (unsigned long) ret_from_fork;
 	p->thread.sp = (unsigned long) fork_frame;
 	p->thread.io_bitmap = NULL;
+	p->thread.iopl_warn = 0;
 	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index a588009..f3f3034 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -528,6 +528,36 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 
 #define GPFSTR "general protection fault"
 
+static bool fixup_iopl_exception(struct pt_regs *regs)
+{
+	struct thread_struct *t = &current->thread;
+	unsigned char byte;
+	unsigned long ip;
+
+	if (!IS_ENABLED(CONFIG_X86_IOPL_IOPERM) || t->iopl_emul != 3)
+		return false;
+
+	if (insn_get_effective_ip(regs, &ip))
+		return false;
+
+	if (get_user(byte, (const char __user *)ip))
+		return false;
+
+	if (byte != 0xfa && byte != 0xfb)
+		return false;
+
+	if (!t->iopl_warn && printk_ratelimit()) {
+		pr_err("%s[%d] attempts to use CLI/STI, pretending it's a NOP, ip:%lx",
+		       current->comm, task_pid_nr(current), ip);
+		print_vma_addr(KERN_CONT " in ", ip);
+		pr_cont("\n");
+		t->iopl_warn = 1;
+	}
+
+	regs->ip += 1;
+	return true;
+}
+
 DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 {
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
@@ -553,6 +583,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	tsk = current;
 
 	if (user_mode(regs)) {
+		if (fixup_iopl_exception(regs))
+			goto exit;
+
 		tsk->thread.error_code = error_code;
 		tsk->thread.trap_nr = X86_TRAP_GP;
 
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index a1d24fd..eb3ccff 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1417,7 +1417,7 @@ void __user *insn_get_addr_ref(struct insn *insn, struct pt_regs *regs)
 	}
 }
 
-static int insn_get_effective_ip(struct pt_regs *regs, unsigned long *ip)
+int insn_get_effective_ip(struct pt_regs *regs, unsigned long *ip)
 {
 	unsigned long seg_base = 0;
 
