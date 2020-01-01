Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F331212DE7C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2020 11:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgAAKH3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 1 Jan 2020 05:07:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52312 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgAAKH3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 1 Jan 2020 05:07:29 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1imauH-0004P4-Qi; Wed, 01 Jan 2020 11:07:14 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 75A601C2C2C;
        Wed,  1 Jan 2020 11:07:13 +0100 (CET)
Date:   Wed, 01 Jan 2020 10:07:13 -0000
From:   "tip-bot2 for Jann Horn" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/traps: Print address on #GP
Cc:     Jann Horn <jannh@google.com>, Borislav Petkov <bp@suse.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        kasan-dev@googlegroups.com, Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191218231150.12139-2-jannh@google.com>
References: <20191218231150.12139-2-jannh@google.com>
MIME-Version: 1.0
Message-ID: <157787323335.30329.8702104659641784210.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     59c1dcbed5b51cab543be8f47b6d7d9cf107ec94
Gitweb:        https://git.kernel.org/tip/59c1dcbed5b51cab543be8f47b6d7d9cf107ec94
Author:        Jann Horn <jannh@google.com>
AuthorDate:    Thu, 19 Dec 2019 00:11:48 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 31 Dec 2019 12:31:13 +01:00

x86/traps: Print address on #GP

A frequent cause of #GP exceptions are memory accesses to non-canonical
addresses. Unlike #PF, #GP doesn't report a fault address in CR2, so the
kernel doesn't currently print the fault address for a #GP.

Luckily, the necessary infrastructure for decoding x86 instructions and
computing the memory address being accessed is already present. Hook
it up to the #GP handler so that the address operand of the faulting
instruction can be figured out and printed.

Distinguish two cases:

  a) (Part of) the memory range being accessed lies in the non-canonical
     address range; in this case, it is likely that the decoded address
     is actually the one that caused the #GP.

  b) The entire memory range of the decoded operand lies in canonical
     address space; the #GP may or may not be related in some way to the
     computed address. Print it, but with hedging language in the message.

While it is already possible to compute the faulting address manually by
disassembling the opcode dump and evaluating the instruction against the
register dump, this should make it slightly easier to identify crashes
at a glance.

Note that the operand length which comes from the instruction decoder
and is used to determine whether the access straddles into non-canonical
address space, is currently somewhat unreliable; but it should be good
enough, considering that Linux on x86-64 never maps the page directly
before the start of the non-canonical range anyway, and therefore the
case where a memory range begins in that page and potentially straddles
into the non-canonical range should be fairly uncommon.

In the case the address is still computed wrongly, it only influences
whether the error message claims that the access is canonical.

 [ bp: Remove ambiguous "we", massage, reflow comments and spacing. ]

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Tested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: kasan-dev@googlegroups.com
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191218231150.12139-2-jannh@google.com
---
 arch/x86/kernel/traps.c | 72 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 05da6b5..108ab1e 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -56,6 +56,8 @@
 #include <asm/mpx.h>
 #include <asm/vm86.h>
 #include <asm/umip.h>
+#include <asm/insn.h>
+#include <asm/insn-eval.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -518,10 +520,53 @@ exit_trap:
 	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, 0, NULL);
 }
 
-dotraplinkage void
-do_general_protection(struct pt_regs *regs, long error_code)
+enum kernel_gp_hint {
+	GP_NO_HINT,
+	GP_NON_CANONICAL,
+	GP_CANONICAL
+};
+
+/*
+ * When an uncaught #GP occurs, try to determine the memory address accessed by
+ * the instruction and return that address to the caller. Also, try to figure
+ * out whether any part of the access to that address was non-canonical.
+ */
+static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
+						 unsigned long *addr)
 {
-	const char *desc = "general protection fault";
+	u8 insn_buf[MAX_INSN_SIZE];
+	struct insn insn;
+
+	if (probe_kernel_read(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
+		return GP_NO_HINT;
+
+	kernel_insn_init(&insn, insn_buf, MAX_INSN_SIZE);
+	insn_get_modrm(&insn);
+	insn_get_sib(&insn);
+
+	*addr = (unsigned long)insn_get_addr_ref(&insn, regs);
+	if (*addr == -1UL)
+		return GP_NO_HINT;
+
+#ifdef CONFIG_X86_64
+	/*
+	 * Check that:
+	 *  - the operand is not in the kernel half
+	 *  - the last byte of the operand is not in the user canonical half
+	 */
+	if (*addr < ~__VIRTUAL_MASK &&
+	    *addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK)
+		return GP_NON_CANONICAL;
+#endif
+
+	return GP_CANONICAL;
+}
+
+#define GPFSTR "general protection fault"
+
+dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
+{
+	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
 	struct task_struct *tsk;
 
 	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
@@ -540,6 +585,9 @@ do_general_protection(struct pt_regs *regs, long error_code)
 
 	tsk = current;
 	if (!user_mode(regs)) {
+		enum kernel_gp_hint hint = GP_NO_HINT;
+		unsigned long gp_addr;
+
 		if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
 			return;
 
@@ -556,8 +604,22 @@ do_general_protection(struct pt_regs *regs, long error_code)
 			return;
 
 		if (notify_die(DIE_GPF, desc, regs, error_code,
-			       X86_TRAP_GP, SIGSEGV) != NOTIFY_STOP)
-			die(desc, regs, error_code);
+			       X86_TRAP_GP, SIGSEGV) == NOTIFY_STOP)
+			return;
+
+		if (error_code)
+			snprintf(desc, sizeof(desc), "segment-related " GPFSTR);
+		else
+			hint = get_kernel_gp_address(regs, &gp_addr);
+
+		if (hint != GP_NO_HINT)
+			snprintf(desc, sizeof(desc), GPFSTR ", %s 0x%lx",
+				 (hint == GP_NON_CANONICAL) ?
+				 "probably for non-canonical address" :
+				 "maybe for address",
+				 gp_addr);
+
+		die(desc, regs, error_code);
 		return;
 	}
 
