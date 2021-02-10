Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D57316D3E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 18:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhBJRsT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 12:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbhBJRra (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 12:47:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EAEC06174A;
        Wed, 10 Feb 2021 09:46:47 -0800 (PST)
Date:   Wed, 10 Feb 2021 17:45:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612979155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=En0h+LLq9oaJo5CEbcrmKcsC+lrKMRALrTn+XCLfS5E=;
        b=DVqbLh43lWk7tkoCZFaMs8sk8ZL3y3VlmypHdsfFB6G3OcgP50WpsdlFrYfpdOCEO2fnFX
        zegPW6Aw7/ZnB+KDP1fK8G2nTk+XU98P67D7yP2wl8YbYPoXbtQG1itXE3C3OwdzxR7aH1
        8wn7vVZdys8NgQ3LTbtHyp+FmYKqiEH2EWHMeyUVa4YBP86E0iD5pr7wVfZ5qhE5CQBjeK
        wrG3GydWahJSFck8Z+gwsAgavMJc7K9Yja2mRe+PZYlK1FD5PpjWcboNNKjDPFSNpHajtn
        FoRuKWMAMzCpSvL45AjRPC9H27zt5IprYyYrhyFVVZwzZJ6J9UuRyzjCUFG1Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612979155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=En0h+LLq9oaJo5CEbcrmKcsC+lrKMRALrTn+XCLfS5E=;
        b=xY6DiBK3qWK89z4Rx1bBx4ClzaXy7eTnlswhFCGuh+WDCK1QP3Gh8jrW+Y3cEAuoA2tS45
        xgh8r/gP4pZqyUCg==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/fault: Split the OOPS code out from no_context()
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <450f8d8eabafb83a5df349108c8e5ea83a2f939d.1612924255.git.luto@kernel.org>
References: <450f8d8eabafb83a5df349108c8e5ea83a2f939d.1612924255.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <161297915535.23325.17962057579847644322.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     2cc624b0a7e68ba8957b18600181f7d5b0f3e1b6
Gitweb:        https://git.kernel.org/tip/2cc624b0a7e68ba8957b18600181f7d5b0f3e1b6
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Tue, 09 Feb 2021 18:33:41 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 10 Feb 2021 14:33:36 +01:00

x86/fault: Split the OOPS code out from no_context()

Not all callers of no_context() want to run exception fixups.
Separate the OOPS code out from the fixup code in no_context().

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/450f8d8eabafb83a5df349108c8e5ea83a2f939d.1612924255.git.luto@kernel.org
---
 arch/x86/mm/fault.c | 116 ++++++++++++++++++++++---------------------
 1 file changed, 62 insertions(+), 54 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index cbb1a97..dbf6a94 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -655,53 +655,20 @@ static void set_signal_archinfo(unsigned long address,
 }
 
 static noinline void
-no_context(struct pt_regs *regs, unsigned long error_code,
-	   unsigned long address, int signal, int si_code)
+page_fault_oops(struct pt_regs *regs, unsigned long error_code,
+		unsigned long address)
 {
-	struct task_struct *tsk = current;
 	unsigned long flags;
 	int sig;
 
 	if (user_mode(regs)) {
 		/*
-		 * This is an implicit supervisor-mode access from user
-		 * mode.  Bypass all the kernel-mode recovery code and just
-		 * OOPS.
+		 * Implicit kernel access from user mode?  Skip the stack
+		 * overflow and EFI special cases.
 		 */
 		goto oops;
 	}
 
-	/* Are we prepared to handle this kernel fault? */
-	if (fixup_exception(regs, X86_TRAP_PF, error_code, address)) {
-		/*
-		 * Any interrupt that takes a fault gets the fixup. This makes
-		 * the below recursive fault logic only apply to a faults from
-		 * task context.
-		 */
-		if (in_interrupt())
-			return;
-
-		/*
-		 * Per the above we're !in_interrupt(), aka. task context.
-		 *
-		 * In this case we need to make sure we're not recursively
-		 * faulting through the emulate_vsyscall() logic.
-		 */
-		if (current->thread.sig_on_uaccess_err && signal) {
-			sanitize_error_code(address, &error_code);
-
-			set_signal_archinfo(address, error_code);
-
-			/* XXX: hwpoison faults will set the wrong code. */
-			force_sig_fault(signal, si_code, (void __user *)address);
-		}
-
-		/*
-		 * Barring that, we can do the fixup and be happy.
-		 */
-		return;
-	}
-
 #ifdef CONFIG_VMAP_STACK
 	/*
 	 * Stack overflow?  During boot, we can fault near the initial
@@ -709,8 +676,8 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	 * that we're in vmalloc space to avoid this.
 	 */
 	if (is_vmalloc_addr((void *)address) &&
-	    (((unsigned long)tsk->stack - 1 - address < PAGE_SIZE) ||
-	     address - ((unsigned long)tsk->stack + THREAD_SIZE) < PAGE_SIZE)) {
+	    (((unsigned long)current->stack - 1 - address < PAGE_SIZE) ||
+	     address - ((unsigned long)current->stack + THREAD_SIZE) < PAGE_SIZE)) {
 		unsigned long stack = __this_cpu_ist_top_va(DF) - sizeof(void *);
 		/*
 		 * We're likely to be running with very little stack space
@@ -734,20 +701,6 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 #endif
 
 	/*
-	 * 32-bit:
-	 *
-	 *   Valid to do another page fault here, because if this fault
-	 *   had been triggered by is_prefetch fixup_exception would have
-	 *   handled it.
-	 *
-	 * 64-bit:
-	 *
-	 *   Hall of shame of CPU/BIOS bugs.
-	 */
-	if (is_prefetch(regs, error_code, address))
-		return;
-
-	/*
 	 * Buggy firmware could access regions which might page fault, try to
 	 * recover from such faults.
 	 */
@@ -763,7 +716,7 @@ oops:
 
 	show_fault_oops(regs, error_code, address);
 
-	if (task_stack_end_corrupted(tsk))
+	if (task_stack_end_corrupted(current))
 		printk(KERN_EMERG "Thread overran stack, or stack corrupted\n");
 
 	sig = SIGKILL;
@@ -776,6 +729,61 @@ oops:
 	oops_end(flags, regs, sig);
 }
 
+static noinline void
+no_context(struct pt_regs *regs, unsigned long error_code,
+	   unsigned long address, int signal, int si_code)
+{
+	if (user_mode(regs)) {
+		/*
+		 * This is an implicit supervisor-mode access from user
+		 * mode.  Bypass all the kernel-mode recovery code and just
+		 * OOPS.
+		 */
+		goto oops;
+	}
+
+	/* Are we prepared to handle this kernel fault? */
+	if (fixup_exception(regs, X86_TRAP_PF, error_code, address)) {
+		/*
+		 * Any interrupt that takes a fault gets the fixup. This makes
+		 * the below recursive fault logic only apply to a faults from
+		 * task context.
+		 */
+		if (in_interrupt())
+			return;
+
+		/*
+		 * Per the above we're !in_interrupt(), aka. task context.
+		 *
+		 * In this case we need to make sure we're not recursively
+		 * faulting through the emulate_vsyscall() logic.
+		 */
+		if (current->thread.sig_on_uaccess_err && signal) {
+			sanitize_error_code(address, &error_code);
+
+			set_signal_archinfo(address, error_code);
+
+			/* XXX: hwpoison faults will set the wrong code. */
+			force_sig_fault(signal, si_code, (void __user *)address);
+		}
+
+		/*
+		 * Barring that, we can do the fixup and be happy.
+		 */
+		return;
+	}
+
+	/*
+	 * AMD erratum #91 manifests as a spurious page fault on a PREFETCH
+	 * instruction.
+	 */
+	if (is_prefetch(regs, error_code, address))
+		return;
+
+oops:
+	page_fault_oops(regs, error_code, address);
+}
+
 /*
  * Print out info about fatal segfaults, if the show_unhandled_signals
  * sysctl is set:
