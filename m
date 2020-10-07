Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4743285C3E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 12:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgJGKCv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 06:02:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42456 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgJGKCv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 06:02:51 -0400
Date:   Wed, 07 Oct 2020 10:02:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602064968;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CGlSxQ5HPpVMwPGSsFuoW8FqrIMnxWhiEtvYETyEjmI=;
        b=LEr03ReiQo/SZUcPoft9ZMVzObfRS8Io+4nr0/aNX2XwI30DZnSdQ7laLj2xu8SUC+jjZE
        ZCYZVIYQlvnVajIF3NmIY2gHihYXk0NJx5RzlD0moXs91MKE/CORrrBlWBdMOuLj2PheqU
        7OXpK5S/EMb3lnFQaogFVZWe1G9pqmPM9X/4P3gUqC3nQdu0y/p5/V9bQj/jCnqCuoP1vq
        AkIjne/BzItenZzKDsMmB+unzBq464FdCKh8n77UnO6B76yxqbeRmtA8qRFgcrEkW0ehbB
        L0UKcFRuGmN2KK3htgb5poW6G5EfWs+fQfRRIzkJO/qrIXrU0Ef9BYgHjeJ4ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602064968;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CGlSxQ5HPpVMwPGSsFuoW8FqrIMnxWhiEtvYETyEjmI=;
        b=2tmsbkmee7kAsUFZcFPIfsfB29hNe6P63QFbZA88U1Zta4vIoK20oskUCkpuoNX3hTWJ7i
        PgECJFAgHjxqt9AQ==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Decode a kernel instruction to determine if
 it is copying from user
Cc:     Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201006210910.21062-7-tony.luck@intel.com>
References: <20201006210910.21062-7-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <160206496755.7002.14650548591810890366.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     300638101329e8f1569115f3d7197ef5ef754a3a
Gitweb:        https://git.kernel.org/tip/300638101329e8f1569115f3d7197ef5ef754a3a
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 06 Oct 2020 14:09:10 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 07 Oct 2020 11:32:40 +02:00

x86/mce: Decode a kernel instruction to determine if it is copying from user

All instructions copying data between kernel and user memory
are tagged with either _ASM_EXTABLE_UA or _ASM_EXTABLE_CPY
entries in the exception table. ex_fault_handler_type() returns
EX_HANDLER_UACCESS for both of these.

Recovery is only possible when the machine check was triggered
on a read from user memory. In this case the same strategy for
recovery applies as if the user had made the access in ring3. If
the fault was in kernel memory while copying to user there is no
current recovery plan.

For MOV and MOVZ instructions a full decode of the instruction
is done to find the source address. For MOVS instructions
the source address is in the %rsi register. The function
fault_in_kernel_space() determines whether the source address is
kernel or user, upgrade it from "static" so it can be used here.

Co-developed-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201006210910.21062-7-tony.luck@intel.com
---
 arch/x86/include/asm/traps.h       |  2 +-
 arch/x86/kernel/cpu/mce/core.c     | 11 ++++--
 arch/x86/kernel/cpu/mce/severity.c | 53 ++++++++++++++++++++++++++++-
 arch/x86/mm/fault.c                |  2 +-
 4 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 714b1a3..df0b7bf 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -35,6 +35,8 @@ extern int panic_on_unrecovered_nmi;
 
 void math_emulate(struct math_emu_info *);
 
+bool fault_in_kernel_space(unsigned long address);
+
 #ifdef CONFIG_VMAP_STACK
 void __noreturn handle_stack_overflow(const char *message,
 				      struct pt_regs *regs,
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5c423c4..3d6e1bf 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1250,14 +1250,19 @@ static void kill_me_maybe(struct callback_head *cb)
 	if (!p->mce_ripv)
 		flags |= MF_MUST_KILL;
 
-	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags)) {
+	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
+	    !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
 		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
 		sync_core();
 		return;
 	}
 
-	pr_err("Memory error not recovered");
-	kill_me_now(cb);
+	if (p->mce_vaddr != (void __user *)-1l) {
+		force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);
+	} else {
+		pr_err("Memory error not recovered");
+		kill_me_now(cb);
+	}
 }
 
 static void queue_task_work(struct mce *m, int kill_it)
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index c6494e6..83df991 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -13,6 +13,9 @@
 
 #include <asm/mce.h>
 #include <asm/intel-family.h>
+#include <asm/traps.h>
+#include <asm/insn.h>
+#include <asm/insn-eval.h>
 
 #include "internal.h"
 
@@ -212,6 +215,47 @@ static struct severity {
 #define mc_recoverable(mcg) (((mcg) & (MCG_STATUS_RIPV|MCG_STATUS_EIPV)) == \
 				(MCG_STATUS_RIPV|MCG_STATUS_EIPV))
 
+static bool is_copy_from_user(struct pt_regs *regs)
+{
+	u8 insn_buf[MAX_INSN_SIZE];
+	struct insn insn;
+	unsigned long addr;
+
+	if (copy_from_kernel_nofault(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
+		return false;
+
+	kernel_insn_init(&insn, insn_buf, MAX_INSN_SIZE);
+	insn_get_opcode(&insn);
+	if (!insn.opcode.got)
+		return false;
+
+	switch (insn.opcode.value) {
+	/* MOV mem,reg */
+	case 0x8A: case 0x8B:
+	/* MOVZ mem,reg */
+	case 0xB60F: case 0xB70F:
+		insn_get_modrm(&insn);
+		insn_get_sib(&insn);
+		if (!insn.modrm.got || !insn.sib.got)
+			return false;
+		addr = (unsigned long)insn_get_addr_ref(&insn, regs);
+		break;
+	/* REP MOVS */
+	case 0xA4: case 0xA5:
+		addr = regs->si;
+		break;
+	default:
+		return false;
+	}
+
+	if (fault_in_kernel_space(addr))
+		return false;
+
+	current->mce_vaddr = (void __user *)addr;
+
+	return true;
+}
+
 /*
  * If mcgstatus indicated that ip/cs on the stack were
  * no good, then "m->cs" will be zero and we will have
@@ -229,10 +273,17 @@ static int error_context(struct mce *m, struct pt_regs *regs)
 
 	if ((m->cs & 3) == 3)
 		return IN_USER;
+	if (!mc_recoverable(m->mcgstatus))
+		return IN_KERNEL;
 
 	t = ex_get_fault_handler_type(m->ip);
-	if (mc_recoverable(m->mcgstatus) && t == EX_HANDLER_FAULT) {
+	if (t == EX_HANDLER_FAULT) {
+		m->kflags |= MCE_IN_KERNEL_RECOV;
+		return IN_KERNEL_RECOV;
+	}
+	if (t == EX_HANDLER_UACCESS && regs && is_copy_from_user(regs)) {
 		m->kflags |= MCE_IN_KERNEL_RECOV;
+		m->kflags |= MCE_IN_KERNEL_COPYIN;
 		return IN_KERNEL_RECOV;
 	}
 
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 35f1498..88ae443 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1081,7 +1081,7 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
 	return 0;
 }
 
-static int fault_in_kernel_space(unsigned long address)
+bool fault_in_kernel_space(unsigned long address)
 {
 	/*
 	 * On 64-bit systems, the vsyscall page is at an address above
