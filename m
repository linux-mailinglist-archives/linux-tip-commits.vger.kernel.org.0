Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099F1316D2D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 18:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbhBJRq6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 12:46:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33134 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbhBJRqo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 12:46:44 -0500
Date:   Wed, 10 Feb 2021 17:45:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612979155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6o+AHOQTnifycD0OKX1b6Yeor6h1oYzPmh3Iu3cEPwY=;
        b=W5U8dfS2pub+8mPQbsj2gtixm0sLDypBNmBWqF8bPWFPFoUFXEKNQ/QyRVEvEGTdatzOHp
        Nrvyc6mxujbBMhjSU0XqRHs9Vaze0fqTbCHT4jXk25hq3tx5IoFrKi+EUan+Q+XV1Pp2vs
        Jz682/QfUkgdaeiyDx2jvtoOEo+pNoGo6uuoQIN8HL2Ryxc1+2j6JfGi3uvNhw8kd0bgFK
        8DmIApCQobpe2tz6NHvJr5k0HqbTxsaX3OdRmgGVVDG56OeKBt3gtyS2eUbJUgwWelBKc1
        SS+xuPUULVtRgFqhWhcugdK+UB7/3khFLOE1n5x6ldfU/0QyAaPu5FCKx5jiVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612979155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6o+AHOQTnifycD0OKX1b6Yeor6h1oYzPmh3Iu3cEPwY=;
        b=fs6DoP6KfG7jwlApdL23sMaOC6RKKJOvSzllvS+74wC8xM5jmYo7NTszE284E+Ert4WIwr
        6CJLxaVgCZvvfvBA==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/fault: Bypass no_context() for implicit kernel
 faults from usermode
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <6e3d1129494a8de1e59d28012286e3a292a2296e.1612924255.git.luto@kernel.org>
References: <6e3d1129494a8de1e59d28012286e3a292a2296e.1612924255.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <161297915515.23325.7813279186457807408.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     5042d40a264c8a508d58ed71e4c07b05175b3635
Gitweb:        https://git.kernel.org/tip/5042d40a264c8a508d58ed71e4c07b05175b3635
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Tue, 09 Feb 2021 18:33:42 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 10 Feb 2021 14:39:52 +01:00

x86/fault: Bypass no_context() for implicit kernel faults from usermode

Drop an indentation level and remove the last user_mode(regs) == true
caller of no_context() by directly OOPSing for implicit kernel faults
from usermode.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/6e3d1129494a8de1e59d28012286e3a292a2296e.1612924255.git.luto@kernel.org
---
 arch/x86/mm/fault.c | 59 +++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index dbf6a94..187975b 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -826,44 +826,49 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 {
 	struct task_struct *tsk = current;
 
-	/* User mode accesses just cause a SIGSEGV */
-	if (user_mode(regs) && (error_code & X86_PF_USER)) {
-		/*
-		 * It's possible to have interrupts off here:
-		 */
-		local_irq_enable();
+	if (!user_mode(regs)) {
+		no_context(regs, error_code, address, pkey, si_code);
+		return;
+	}
 
-		/*
-		 * Valid to do another page fault here because this one came
-		 * from user space:
-		 */
-		if (is_prefetch(regs, error_code, address))
-			return;
+	if (!(error_code & X86_PF_USER)) {
+		/* Implicit user access to kernel memory -- just oops */
+		page_fault_oops(regs, error_code, address);
+		return;
+	}
 
-		if (is_errata100(regs, address))
-			return;
+	/*
+	 * User mode accesses just cause a SIGSEGV.
+	 * It's possible to have interrupts off here:
+	 */
+	local_irq_enable();
 
-		sanitize_error_code(address, &error_code);
+	/*
+	 * Valid to do another page fault here because this one came
+	 * from user space:
+	 */
+	if (is_prefetch(regs, error_code, address))
+		return;
 
-		if (fixup_vdso_exception(regs, X86_TRAP_PF, error_code, address))
-			return;
+	if (is_errata100(regs, address))
+		return;
 
-		if (likely(show_unhandled_signals))
-			show_signal_msg(regs, error_code, address, tsk);
+	sanitize_error_code(address, &error_code);
 
-		set_signal_archinfo(address, error_code);
+	if (fixup_vdso_exception(regs, X86_TRAP_PF, error_code, address))
+		return;
 
-		if (si_code == SEGV_PKUERR)
-			force_sig_pkuerr((void __user *)address, pkey);
+	if (likely(show_unhandled_signals))
+		show_signal_msg(regs, error_code, address, tsk);
 
-		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
+	set_signal_archinfo(address, error_code);
 
-		local_irq_disable();
+	if (si_code == SEGV_PKUERR)
+		force_sig_pkuerr((void __user *)address, pkey);
 
-		return;
-	}
+	force_sig_fault(SIGSEGV, si_code, (void __user *)address);
 
-	no_context(regs, error_code, address, SIGSEGV, si_code);
+	local_irq_disable();
 }
 
 static noinline void
