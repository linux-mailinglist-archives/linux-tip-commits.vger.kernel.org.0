Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E30E316D34
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 18:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhBJRr6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 12:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbhBJRra (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 12:47:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C08C061756;
        Wed, 10 Feb 2021 09:46:47 -0800 (PST)
Date:   Wed, 10 Feb 2021 17:45:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612979157;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X6sobz/qLu3JyMQK5TGpLScEEW2urHs2vlcBAhs/tu8=;
        b=nr67l7wIybJ8IIxDKLzNYL3uNYJCqR/28vXX+fdobd0yaz3IYvfEq0G66XLDt3pKUY2ItY
        9t6pceVqo2NxFVfWN0InVSWvYcNLJDF9ptKad3+NYNetPmHA9Jv6VLJrZZnuOveTlr0S4s
        Y/W4mPwl57wrwNRxVCiuXWl6IdG+najR2QzVr8Xy1XTy83hWhSrK1CrR2Vtzo7/ZTDBj7M
        J+SvT86dZCJjkj9IOceuv6bwoPYMO7r4FvbNI780fUQap+NGQgXvL0HGgcVrz3DQiB3Pnr
        x43v4o5+Q0Utxt5OdvR8C+qgcxgX6BvcwRwUec3GEixetcZKU9FoSiFWzntbiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612979157;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X6sobz/qLu3JyMQK5TGpLScEEW2urHs2vlcBAhs/tu8=;
        b=SRmnGiF8a+Q1/lomBXcj7hcnnEYqfctyaCdKF7hrxHkDr+Xuj4DGCWcyW1lYGHoq4LB+LO
        mR+Df9Sz1iaosuBQ==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/fault: Fold mm_fault_error() into do_user_addr_fault()
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <dedc4d9c9b047e51ce38b991bd23971a28af4e7b.1612924255.git.luto@kernel.org>
References: <dedc4d9c9b047e51ce38b991bd23971a28af4e7b.1612924255.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <161297915639.23325.7723221279175433807.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     ec352711ceba890ea3a0c182c2d49c86c1a5e30e
Gitweb:        https://git.kernel.org/tip/ec352711ceba890ea3a0c182c2d49c86c1a5e30e
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Tue, 09 Feb 2021 18:33:35 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 10 Feb 2021 14:10:07 +01:00

x86/fault: Fold mm_fault_error() into do_user_addr_fault()

mm_fault_error() is logically just the end of do_user_addr_fault().
Combine the functions.  This makes the code easier to read.

Most of the churn here is from renaming hw_error_code to error_code in
do_user_addr_fault().

This makes no difference at all to the generated code (objdump -dr) as
compared to changing noinline to __always_inline in the definition of
mm_fault_error().

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/dedc4d9c9b047e51ce38b991bd23971a28af4e7b.1612924255.git.luto@kernel.org
---
 arch/x86/mm/fault.c | 97 ++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 52 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 818902b..91cf7a6 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -981,40 +981,6 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 	force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *)address);
 }
 
-static noinline void
-mm_fault_error(struct pt_regs *regs, unsigned long error_code,
-	       unsigned long address, vm_fault_t fault)
-{
-	if (fatal_signal_pending(current) && !(error_code & X86_PF_USER)) {
-		no_context(regs, error_code, address, 0, 0);
-		return;
-	}
-
-	if (fault & VM_FAULT_OOM) {
-		/* Kernel mode? Handle exceptions or die: */
-		if (!(error_code & X86_PF_USER)) {
-			no_context(regs, error_code, address,
-				   SIGSEGV, SEGV_MAPERR);
-			return;
-		}
-
-		/*
-		 * We ran out of memory, call the OOM killer, and return the
-		 * userspace (which will retry the fault, or kill us if we got
-		 * oom-killed):
-		 */
-		pagefault_out_of_memory();
-	} else {
-		if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|
-			     VM_FAULT_HWPOISON_LARGE))
-			do_sigbus(regs, error_code, address, fault);
-		else if (fault & VM_FAULT_SIGSEGV)
-			bad_area_nosemaphore(regs, error_code, address);
-		else
-			BUG();
-	}
-}
-
 static int spurious_kernel_fault_check(unsigned long error_code, pte_t *pte)
 {
 	if ((error_code & X86_PF_WRITE) && !pte_write(*pte))
@@ -1252,7 +1218,7 @@ NOKPROBE_SYMBOL(do_kern_addr_fault);
 /* Handle faults in the user portion of the address space */
 static inline
 void do_user_addr_fault(struct pt_regs *regs,
-			unsigned long hw_error_code,
+			unsigned long error_code,
 			unsigned long address)
 {
 	struct vm_area_struct *vma;
@@ -1272,8 +1238,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * Reserved bits are never expected to be set on
 	 * entries in the user portion of the page tables.
 	 */
-	if (unlikely(hw_error_code & X86_PF_RSVD))
-		pgtable_bad(regs, hw_error_code, address);
+	if (unlikely(error_code & X86_PF_RSVD))
+		pgtable_bad(regs, error_code, address);
 
 	/*
 	 * If SMAP is on, check for invalid kernel (supervisor) access to user
@@ -1283,10 +1249,10 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * enforcement appears to be consistent with the USER bit.
 	 */
 	if (unlikely(cpu_feature_enabled(X86_FEATURE_SMAP) &&
-		     !(hw_error_code & X86_PF_USER) &&
+		     !(error_code & X86_PF_USER) &&
 		     !(regs->flags & X86_EFLAGS_AC)))
 	{
-		bad_area_nosemaphore(regs, hw_error_code, address);
+		bad_area_nosemaphore(regs, error_code, address);
 		return;
 	}
 
@@ -1295,7 +1261,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * in a region with pagefaults disabled then we must not take the fault
 	 */
 	if (unlikely(faulthandler_disabled() || !mm)) {
-		bad_area_nosemaphore(regs, hw_error_code, address);
+		bad_area_nosemaphore(regs, error_code, address);
 		return;
 	}
 
@@ -1316,9 +1282,9 @@ void do_user_addr_fault(struct pt_regs *regs,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
-	if (hw_error_code & X86_PF_WRITE)
+	if (error_code & X86_PF_WRITE)
 		flags |= FAULT_FLAG_WRITE;
-	if (hw_error_code & X86_PF_INSTR)
+	if (error_code & X86_PF_INSTR)
 		flags |= FAULT_FLAG_INSTRUCTION;
 
 #ifdef CONFIG_X86_64
@@ -1334,7 +1300,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * to consider the PF_PK bit.
 	 */
 	if (is_vsyscall_vaddr(address)) {
-		if (emulate_vsyscall(hw_error_code, regs, address))
+		if (emulate_vsyscall(error_code, regs, address))
 			return;
 	}
 #endif
@@ -1357,7 +1323,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 			 * Fault from code in kernel from
 			 * which we do not expect faults.
 			 */
-			bad_area_nosemaphore(regs, hw_error_code, address);
+			bad_area_nosemaphore(regs, error_code, address);
 			return;
 		}
 retry:
@@ -1373,17 +1339,17 @@ retry:
 
 	vma = find_vma(mm, address);
 	if (unlikely(!vma)) {
-		bad_area(regs, hw_error_code, address);
+		bad_area(regs, error_code, address);
 		return;
 	}
 	if (likely(vma->vm_start <= address))
 		goto good_area;
 	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN))) {
-		bad_area(regs, hw_error_code, address);
+		bad_area(regs, error_code, address);
 		return;
 	}
 	if (unlikely(expand_stack(vma, address))) {
-		bad_area(regs, hw_error_code, address);
+		bad_area(regs, error_code, address);
 		return;
 	}
 
@@ -1392,8 +1358,8 @@ retry:
 	 * we can handle it..
 	 */
 good_area:
-	if (unlikely(access_error(hw_error_code, vma))) {
-		bad_area_access_error(regs, hw_error_code, address, vma);
+	if (unlikely(access_error(error_code, vma))) {
+		bad_area_access_error(regs, error_code, address, vma);
 		return;
 	}
 
@@ -1415,7 +1381,7 @@ good_area:
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
-			no_context(regs, hw_error_code, address, SIGBUS,
+			no_context(regs, error_code, address, SIGBUS,
 				   BUS_ADRERR);
 		return;
 	}
@@ -1432,11 +1398,38 @@ good_area:
 	}
 
 	mmap_read_unlock(mm);
-	if (unlikely(fault & VM_FAULT_ERROR)) {
-		mm_fault_error(regs, hw_error_code, address, fault);
+	if (likely(!(fault & VM_FAULT_ERROR)))
+		return;
+
+	if (fatal_signal_pending(current) && !(error_code & X86_PF_USER)) {
+		no_context(regs, error_code, address, 0, 0);
 		return;
 	}
 
+	if (fault & VM_FAULT_OOM) {
+		/* Kernel mode? Handle exceptions or die: */
+		if (!(error_code & X86_PF_USER)) {
+			no_context(regs, error_code, address,
+				   SIGSEGV, SEGV_MAPERR);
+			return;
+		}
+
+		/*
+		 * We ran out of memory, call the OOM killer, and return the
+		 * userspace (which will retry the fault, or kill us if we got
+		 * oom-killed):
+		 */
+		pagefault_out_of_memory();
+	} else {
+		if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|
+			     VM_FAULT_HWPOISON_LARGE))
+			do_sigbus(regs, error_code, address, fault);
+		else if (fault & VM_FAULT_SIGSEGV)
+			bad_area_nosemaphore(regs, error_code, address);
+		else
+			BUG();
+	}
+
 	check_v8086_mode(regs, address, tsk);
 }
 NOKPROBE_SYMBOL(do_user_addr_fault);
