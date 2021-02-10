Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0FB316D36
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 18:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhBJRsD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 12:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbhBJRra (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 12:47:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D7CC0613D6;
        Wed, 10 Feb 2021 09:46:47 -0800 (PST)
Date:   Wed, 10 Feb 2021 17:45:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612979156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zp08V0qMUz4l32cBV0XmFNs3wbjGfVf7sl8cfA8pw5c=;
        b=f4798bnDpiKZcTcxjvPFVs+WBIfbzevH6kFRjXg0mn3V59zYcYiVglvIbHWIYLMVATBmoX
        smWiR92e/xjJ9+jdL8SJ86f278zqBcVFY6b8Lw8XwBi2KL7YsjmjsTRP0HM9/5wATp5uPA
        FbQJxZPNWMMElPdtqb07U31TM33PBAbzfetbNgCCPtwFQ2Ydytsxmms1hxHaPndy7iNoLy
        /h/idVylTDL5fwlNfCydEpXwwiHWefLYL3iJMLZSxo57davky+tkrhQ3tf6v5okCekh+va
        HwRflneq57sMLOQ6YEb3ok9tzqfi0rVLyGGaEqiBNmmv2kXqyr+3hiKR/DADMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612979156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zp08V0qMUz4l32cBV0XmFNs3wbjGfVf7sl8cfA8pw5c=;
        b=QpnQ0bbwnsDXDyp4mwRn8fMRdifdAD7IpipWZTkLgWpeGQ9QoCtan/XgdCkvdK7Mt9b7l5
        hHvKhkTFVc+FgKCA==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/fault: Correct a few user vs kernel checks wrt WRUSS
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <a7b7bcea730bd4069e6b7e629236bb2cf526c2fb.1612924255.git.luto@kernel.org>
References: <a7b7bcea730bd4069e6b7e629236bb2cf526c2fb.1612924255.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <161297915574.23325.6956352117154470598.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     56e62cd28aaae2fcbec8af67b05843c47c6da170
Gitweb:        https://git.kernel.org/tip/56e62cd28aaae2fcbec8af67b05843c47c6da170
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Tue, 09 Feb 2021 18:33:38 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 10 Feb 2021 14:13:32 +01:00

x86/fault: Correct a few user vs kernel checks wrt WRUSS

In general, page fault errors for WRUSS should be just like get_user(),
etc.  Fix three bugs in this area:

There is a comment that says that, if the kernel can't handle a page fault
on a user address due to OOM, the OOM-kill-and-retry logic would be
skipped.  The code checked kernel *privilege*, not kernel mode, so it
missed WRUSS.  This means that the kernel would malfunction if it got OOM
on a WRUSS fault -- this would be a kernel-mode, user-privilege fault, and
the OOM killer would be invoked and the handler would retry the faulting
instruction.

A failed user access from kernel while a fatal signal is pending should
fail even if the instruction in question was WRUSS.

do_sigbus() should not send SIGBUS for WRUSS -- it should handle it like
any other kernel mode failure.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/a7b7bcea730bd4069e6b7e629236bb2cf526c2fb.1612924255.git.luto@kernel.org
---
 arch/x86/mm/fault.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 013910b..b110484 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -945,7 +945,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 	  vm_fault_t fault)
 {
 	/* Kernel mode? Handle exceptions or die: */
-	if (!(error_code & X86_PF_USER)) {
+	if (!user_mode(regs)) {
 		no_context(regs, error_code, address, SIGBUS, BUS_ADRERR);
 		return;
 	}
@@ -1217,7 +1217,14 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 }
 NOKPROBE_SYMBOL(do_kern_addr_fault);
 
-/* Handle faults in the user portion of the address space */
+/*
+ * Handle faults in the user portion of the address space.  Nothing in here
+ * should check X86_PF_USER without a specific justification: for almost
+ * all purposes, we should treat a normal kernel access to user memory
+ * (e.g. get_user(), put_user(), etc.) the same as the WRUSS instruction.
+ * The one exception is AC flag handling, which is, per the x86
+ * architecture, special for WRUSS.
+ */
 static inline
 void do_user_addr_fault(struct pt_regs *regs,
 			unsigned long error_code,
@@ -1406,14 +1413,14 @@ good_area:
 	if (likely(!(fault & VM_FAULT_ERROR)))
 		return;
 
-	if (fatal_signal_pending(current) && !(error_code & X86_PF_USER)) {
+	if (fatal_signal_pending(current) && !user_mode(regs)) {
 		no_context(regs, error_code, address, 0, 0);
 		return;
 	}
 
 	if (fault & VM_FAULT_OOM) {
 		/* Kernel mode? Handle exceptions or die: */
-		if (!(error_code & X86_PF_USER)) {
+		if (!user_mode(regs)) {
 			no_context(regs, error_code, address,
 				   SIGSEGV, SEGV_MAPERR);
 			return;
