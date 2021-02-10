Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF49316D2A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 18:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbhBJRqz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 12:46:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33132 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbhBJRqo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 12:46:44 -0500
Date:   Wed, 10 Feb 2021 17:45:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612979155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FGr+JZg2As9vzz3JSC9vKMBS4L/TklsnHHgugjQyBiE=;
        b=IK3CfAuHknQqhmK68mXtdG9mZsh8yBzQG2hcKSpqKUNXJ8ugiI5FUcIJ/toRhwDhtVuubJ
        r3Em1PQeJ7jMlHAiyn/O8OJC8PNgV/JL7c7YwaDjcTPIJ+gRRayoBooEFDJVZs1EiuO0gI
        EL5FXj3E73hCE2e2GTuU5R7L359WkEX6f55gwTRF4lxHmmMnG2e9Po8dA3frPHJmfu9tPb
        +wwzASOmiehYVvWn2x/dwgzrUCqvTL1xsdnkd203ETwkx56zRTgEvrOYHgB9N39rIVn0Iv
        MFFkcQ5xMDPyiO3kZphMh8wUxdHCofgEm2klNdYVgKCG+rDWZSN0dur906Resg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612979155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FGr+JZg2As9vzz3JSC9vKMBS4L/TklsnHHgugjQyBiE=;
        b=jxXOpPk1QI3DrxeWqwj6XQ+ZRzJyTWG9jZkKoVoxQR+C/wRLNqTY2o9Z54jolCD8bCElsk
        wRlwk8CZFEcjBuCQ==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/fault: Rename no_context() to kernelmode_fixup_or_oops()
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <c21940efe676024bb4bc721f7d70c29c420e127e.1612924255.git.luto@kernel.org>
References: <c21940efe676024bb4bc721f7d70c29c420e127e.1612924255.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <161297915493.23325.3251206368293231953.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     6456a2a69ee16ad402f26d272d0b67ce1d25061f
Gitweb:        https://git.kernel.org/tip/6456a2a69ee16ad402f26d272d0b67ce1d25061f
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Tue, 09 Feb 2021 18:33:43 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 10 Feb 2021 14:41:19 +01:00

x86/fault: Rename no_context() to kernelmode_fixup_or_oops()

The name no_context() has never been very clear.  It's only called for
faults from kernel mode, so rename it and change the no-longer-useful
user_mode(regs) check to a WARN_ON_ONCE.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/c21940efe676024bb4bc721f7d70c29c420e127e.1612924255.git.luto@kernel.org
---
 arch/x86/mm/fault.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 187975b..3566a59 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -730,17 +730,10 @@ oops:
 }
 
 static noinline void
-no_context(struct pt_regs *regs, unsigned long error_code,
-	   unsigned long address, int signal, int si_code)
+kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
+			 unsigned long address, int signal, int si_code)
 {
-	if (user_mode(regs)) {
-		/*
-		 * This is an implicit supervisor-mode access from user
-		 * mode.  Bypass all the kernel-mode recovery code and just
-		 * OOPS.
-		 */
-		goto oops;
-	}
+	WARN_ON_ONCE(user_mode(regs));
 
 	/* Are we prepared to handle this kernel fault? */
 	if (fixup_exception(regs, X86_TRAP_PF, error_code, address)) {
@@ -780,7 +773,6 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	if (is_prefetch(regs, error_code, address))
 		return;
 
-oops:
 	page_fault_oops(regs, error_code, address);
 }
 
@@ -827,7 +819,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 	struct task_struct *tsk = current;
 
 	if (!user_mode(regs)) {
-		no_context(regs, error_code, address, pkey, si_code);
+		kernelmode_fixup_or_oops(regs, error_code, address, pkey, si_code);
 		return;
 	}
 
@@ -959,7 +951,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 {
 	/* Kernel mode? Handle exceptions or die: */
 	if (!user_mode(regs)) {
-		no_context(regs, error_code, address, SIGBUS, BUS_ADRERR);
+		kernelmode_fixup_or_oops(regs, error_code, address, SIGBUS, BUS_ADRERR);
 		return;
 	}
 
@@ -1421,8 +1413,8 @@ good_area:
 		 * has unlocked the mm for us if we get here.
 		 */
 		if (!user_mode(regs))
-			no_context(regs, error_code, address, SIGBUS,
-				   BUS_ADRERR);
+			kernelmode_fixup_or_oops(regs, error_code, address,
+						 SIGBUS, BUS_ADRERR);
 		return;
 	}
 
@@ -1442,15 +1434,15 @@ good_area:
 		return;
 
 	if (fatal_signal_pending(current) && !user_mode(regs)) {
-		no_context(regs, error_code, address, 0, 0);
+		kernelmode_fixup_or_oops(regs, error_code, address, 0, 0);
 		return;
 	}
 
 	if (fault & VM_FAULT_OOM) {
 		/* Kernel mode? Handle exceptions or die: */
 		if (!user_mode(regs)) {
-			no_context(regs, error_code, address,
-				   SIGSEGV, SEGV_MAPERR);
+			kernelmode_fixup_or_oops(regs, error_code, address,
+						 SIGSEGV, SEGV_MAPERR);
 			return;
 		}
 
