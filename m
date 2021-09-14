Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354ED40B7E1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Sep 2021 21:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhINTVD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Sep 2021 15:21:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35352 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbhINTU5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Sep 2021 15:20:57 -0400
Date:   Tue, 14 Sep 2021 19:19:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631647178;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pk7YroIFvdJKmT8cGsaFqwYtkoa0DWOND0X8yhrF6CA=;
        b=npcK07XAF/rKKMQRWJOQYet1dC76Wf+018WLCMaZI3vvkeK8aUIs2M4UzsWhTSOBBlV7aZ
        Cl+zyHNE7WAKZFNp2WSU54XAhYPztW4++qBlM48B1jFwGn369vcthvhQTL/ZLQeL5lrIgI
        DEYjOhsLYrtx+P4e9UtuSRl295Z3yy/1C0Hwopf5Bb4yHExBzD+/HRjBCfxsdb5EkkL4sw
        PPfCkeLyNmrCXuZ79W1jlMYuSXVLOHitjQKNYi8IHy8KnyyEkm90YvuZaUFS0d3y87Wz3+
        kc9Jmhqbk9+VQTLnTeR2U9pPLmJcVkpAmRHRGfL/C3mcwRwBQjA6BtmJwPa4kQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631647178;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pk7YroIFvdJKmT8cGsaFqwYtkoa0DWOND0X8yhrF6CA=;
        b=uDcqsISTjtRpraXmIIYafF3GKXUZZVzOmZtIrqRk4VPgteaB+rTYFt/9ki2liHWLBO3p2x
        lXu/M3CQaXf4pPAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/extable: Tidy up redundant handler functions
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210908132524.963232825@linutronix.de>
References: <20210908132524.963232825@linutronix.de>
MIME-Version: 1.0
Message-ID: <163164717788.25758.16187629798537848566.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     326b567f82df0c4c8f50092b9af9a3014616fb3c
Gitweb:        https://git.kernel.org/tip/326b567f82df0c4c8f50092b9af9a3014616fb3c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 08 Sep 2021 15:29:12 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Sep 2021 12:33:06 +02:00

x86/extable: Tidy up redundant handler functions

No need to have the same code all over the place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210908132524.963232825@linutronix.de
---
 arch/x86/mm/extable.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index e1664e9..d9a1046 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -39,9 +39,8 @@ __visible bool ex_handler_fault(const struct exception_table_entry *fixup,
 				unsigned long error_code,
 				unsigned long fault_addr)
 {
-	regs->ip = ex_fixup_addr(fixup);
 	regs->ax = trapnr;
-	return true;
+	return ex_handler_default(fixup, regs, trapnr, error_code, fault_addr);
 }
 EXPORT_SYMBOL_GPL(ex_handler_fault);
 
@@ -76,8 +75,7 @@ __visible bool ex_handler_uaccess(const struct exception_table_entry *fixup,
 				  unsigned long fault_addr)
 {
 	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
-	regs->ip = ex_fixup_addr(fixup);
-	return true;
+	return ex_handler_default(fixup, regs, trapnr, error_code, fault_addr);
 }
 EXPORT_SYMBOL(ex_handler_uaccess);
 
@@ -87,9 +85,7 @@ __visible bool ex_handler_copy(const struct exception_table_entry *fixup,
 			       unsigned long fault_addr)
 {
 	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
-	regs->ip = ex_fixup_addr(fixup);
-	regs->ax = trapnr;
-	return true;
+	return ex_handler_fault(fixup, regs, trapnr, error_code, fault_addr);
 }
 EXPORT_SYMBOL(ex_handler_copy);
 
@@ -103,10 +99,9 @@ __visible bool ex_handler_rdmsr_unsafe(const struct exception_table_entry *fixup
 		show_stack_regs(regs);
 
 	/* Pretend that the read succeeded and returned 0. */
-	regs->ip = ex_fixup_addr(fixup);
 	regs->ax = 0;
 	regs->dx = 0;
-	return true;
+	return ex_handler_default(fixup, regs, trapnr, error_code, fault_addr);
 }
 EXPORT_SYMBOL(ex_handler_rdmsr_unsafe);
 
@@ -121,8 +116,7 @@ __visible bool ex_handler_wrmsr_unsafe(const struct exception_table_entry *fixup
 		show_stack_regs(regs);
 
 	/* Pretend that the write succeeded. */
-	regs->ip = ex_fixup_addr(fixup);
-	return true;
+	return ex_handler_default(fixup, regs, trapnr, error_code, fault_addr);
 }
 EXPORT_SYMBOL(ex_handler_wrmsr_unsafe);
 
