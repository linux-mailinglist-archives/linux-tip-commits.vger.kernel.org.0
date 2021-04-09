Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66537359DFA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 13:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhDILx5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 07:53:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50246 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhDILx4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 07:53:56 -0400
Date:   Fri, 09 Apr 2021 11:53:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617969223;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6IiD1Aj19bIZ6PUtDrzKpQLkj5ySbfMWOS/Z08MbVDo=;
        b=hpnY/8vGzt7GzCP1UgEOw43R8H+19QcaM3T9DyXh9QPCvnBXcXrEgi6HJ41n4NgVkwtA2Y
        rNS02EA5eHALvs/JYKdTew9tzifiIB5vRnKG1mcoNpriGTKCmlZSx5BB0og6gQNoI/Vf2V
        HEBNRswCqp0v4uuZrtKOukf1FLOZwQvGm1OHbRoo0e88rKU57eEY5WAFOWKhPM+h17bE9U
        X2C4s+C5gEJm2579BcBLiM21X9MXaPgugJkVfiXnZEgqYGNqpN/AD27fifx0AdrFdTWjb2
        0jUhum1itjjsH0i+cvieMcKkH69WxJyPbqDB9jg5T+jrD0u+rxQx9POjEeKirQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617969223;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6IiD1Aj19bIZ6PUtDrzKpQLkj5ySbfMWOS/Z08MbVDo=;
        b=vvkg5/8E3/KZ4Jo8wUnapTJ5EDk+XAtveqcoa4v8Nmv3Bv6oxHpgwuGA1qmEE1nd/QwYF6
        4D/bsIg9qva1RAAg==
From:   "tip-bot2 for Thomas Tai" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/traps: Correct exc_general_protection() and
 math_error() return paths
Cc:     Thomas Tai <thomas.tai@oracle.com>, Borislav Petkov <bp@suse.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1617902914-83245-1-git-send-email-thomas.tai@oracle.com>
References: <1617902914-83245-1-git-send-email-thomas.tai@oracle.com>
MIME-Version: 1.0
Message-ID: <161796922230.29796.17695217108171353828.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     632a1c209b8773cb0119fe3aada9f1db14fa357c
Gitweb:        https://git.kernel.org/tip/632a1c209b8773cb0119fe3aada9f1db14fa357c
Author:        Thomas Tai <thomas.tai@oracle.com>
AuthorDate:    Thu, 08 Apr 2021 13:28:33 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 09 Apr 2021 13:45:09 +02:00

x86/traps: Correct exc_general_protection() and math_error() return paths

Commit

  334872a09198 ("x86/traps: Attempt to fixup exceptions in vDSO before signaling")

added return statements which bypass calling cond_local_irq_disable().

According to

  ca4c6a9858c2 ("x86/traps: Make interrupt enable/disable symmetric in C code"),

cond_local_irq_disable() is needed because the asm return code no longer
disables interrupts. Follow the existing code as an example to use "goto
exit" instead of "return" statement.

 [ bp: Massage commit message. ]

Fixes: 334872a09198 ("x86/traps: Attempt to fixup exceptions in vDSO before signaling")
Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Link: https://lkml.kernel.org/r/1617902914-83245-1-git-send-email-thomas.tai@oracle.com
---
 arch/x86/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index ac1874a..651e3e5 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -556,7 +556,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		tsk->thread.trap_nr = X86_TRAP_GP;
 
 		if (fixup_vdso_exception(regs, X86_TRAP_GP, error_code, 0))
-			return;
+			goto exit;
 
 		show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
 		force_sig(SIGSEGV);
@@ -1057,7 +1057,7 @@ static void math_error(struct pt_regs *regs, int trapnr)
 		goto exit;
 
 	if (fixup_vdso_exception(regs, trapnr, 0, 0))
-		return;
+		goto exit;
 
 	force_sig_fault(SIGFPE, si_code,
 			(void __user *)uprobe_get_trap_addr(regs));
