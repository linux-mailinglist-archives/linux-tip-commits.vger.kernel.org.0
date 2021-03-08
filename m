Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D14A330EEF
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Mar 2021 14:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhCHNOR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 8 Mar 2021 08:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbhCHNOR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 8 Mar 2021 08:14:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC86C06174A;
        Mon,  8 Mar 2021 05:14:17 -0800 (PST)
Date:   Mon, 08 Mar 2021 13:14:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615209254;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bG+8bRCtIWTt596+cIzOC2I/EluPtoyFGTzry5chudI=;
        b=kwqk5RPmNZkQh+Jg91sKJjx0gkAT5t4QaFDZTHj9TMOFMdnZabyMy4VirT2cewY06iig1p
        8aPrSkL39+3uXK6xlPR7T6JOSnAJAm0/XasipSwXD7JT27BvmyDT9o1HZB5bD4XUefb4HD
        vtYYCWtlQ2GA8npQylMXcJCH5/iktlaXzIy9ZEycU9xNF+lOnu5pmKNiSDeybf0bhEm/T9
        ATgTUN3YMaGuELZMHOmU7Ix+Hdw96DO7r9Gf9NxT7C54qFq1hyJ2G9XRy7Ps8UJhYGkCVw
        NwlEOiDJ/6CqP8DN80t4lC5d3O9FEAQHayAYGFD1FFmgUyH68ebDBVWJhiqwIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615209254;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bG+8bRCtIWTt596+cIzOC2I/EluPtoyFGTzry5chudI=;
        b=nSiBoOPtgMebgYeCOKgd76vQscRTN/blMdrSlFc1p0mw78yjRfDQvAIS1U39jWiD+vkNZZ
        EZ+QB5ioQZJR/aCQ==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/entry/32: Remove leftover macros after
 stackprotector cleanups
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <b1543116f0f0e68f1763d90d5f7fcec27885dff5.1613243844.git.luto@kernel.org>
References: <b1543116f0f0e68f1763d90d5f7fcec27885dff5.1613243844.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <161520925390.398.2550200626715817720.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     d0962f2b24c99889a386f0658c71535f56358f77
Gitweb:        https://git.kernel.org/tip/d0962f2b24c99889a386f0658c71535f56358f77
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Sat, 13 Feb 2021 11:19:45 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 08 Mar 2021 13:27:31 +01:00

x86/entry/32: Remove leftover macros after stackprotector cleanups

Now that nonlazy-GS mode is gone, remove the macros from entry_32.S
that obfuscated^Wabstracted GS handling.  The assembled output is
identical before and after this patch.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/b1543116f0f0e68f1763d90d5f7fcec27885dff5.1613243844.git.luto@kernel.org
---
 arch/x86/entry/entry_32.S | 43 +-------------------------------------
 1 file changed, 2 insertions(+), 41 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index eb0cb66..bee9101 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -53,35 +53,6 @@
 
 #define PTI_SWITCH_MASK         (1 << PAGE_SHIFT)
 
-/*
- * User gs save/restore
- *
- * This is leftover junk from CONFIG_X86_32_LAZY_GS.  A subsequent patch
- * will remove it entirely.
- */
- /* unfortunately push/pop can't be no-op */
-.macro PUSH_GS
-	pushl	$0
-.endm
-.macro POP_GS pop=0
-	addl	$(4 + \pop), %esp
-.endm
-.macro POP_GS_EX
-.endm
-
- /* all the rest are no-op */
-.macro PTGS_TO_GS
-.endm
-.macro PTGS_TO_GS_EX
-.endm
-.macro GS_TO_REG reg
-.endm
-.macro REG_TO_PTGS reg
-.endm
-.macro SET_KERNEL_GS reg
-.endm
-
-
 /* Unconditionally switch to user cr3 */
 .macro SWITCH_TO_USER_CR3 scratch_reg:req
 	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
@@ -234,7 +205,7 @@
 .macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0 skip_gs=0 unwind_espfix=0
 	cld
 .if \skip_gs == 0
-	PUSH_GS
+	pushl	$0
 .endif
 	pushl	%fs
 
@@ -259,9 +230,6 @@
 	movl	$(__USER_DS), %edx
 	movl	%edx, %ds
 	movl	%edx, %es
-.if \skip_gs == 0
-	SET_KERNEL_GS %edx
-.endif
 	/* Switch to kernel stack if necessary */
 .if \switch_stacks > 0
 	SWITCH_TO_KERNEL_STACK
@@ -300,7 +268,7 @@
 1:	popl	%ds
 2:	popl	%es
 3:	popl	%fs
-	POP_GS \pop
+	addl	$(4 + \pop), %esp	/* pop the unused "gs" slot */
 	IRET_FRAME
 .pushsection .fixup, "ax"
 4:	movl	$0, (%esp)
@@ -313,7 +281,6 @@
 	_ASM_EXTABLE(1b, 4b)
 	_ASM_EXTABLE(2b, 5b)
 	_ASM_EXTABLE(3b, 6b)
-	POP_GS_EX
 .endm
 
 .macro RESTORE_ALL_NMI cr3_reg:req pop=0
@@ -928,7 +895,6 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	movl	PT_EIP(%esp), %edx	/* pt_regs->ip */
 	movl	PT_OLDESP(%esp), %ecx	/* pt_regs->sp */
 1:	mov	PT_FS(%esp), %fs
-	PTGS_TO_GS
 
 	popl	%ebx			/* pt_regs->bx */
 	addl	$2*4, %esp		/* skip pt_regs->cx and pt_regs->dx */
@@ -964,7 +930,6 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	jmp	1b
 .popsection
 	_ASM_EXTABLE(1b, 2b)
-	PTGS_TO_GS_EX
 
 .Lsysenter_fix_flags:
 	pushl	$X86_EFLAGS_FIXED
@@ -1106,11 +1071,7 @@ SYM_CODE_START_LOCAL_NOALIGN(handle_exception)
 	SAVE_ALL switch_stacks=1 skip_gs=1 unwind_espfix=1
 	ENCODE_FRAME_POINTER
 
-	/* fixup %gs */
-	GS_TO_REG %ecx
 	movl	PT_GS(%esp), %edi		# get the function address
-	REG_TO_PTGS %ecx
-	SET_KERNEL_GS %ecx
 
 	/* fixup orig %eax */
 	movl	PT_ORIG_EAX(%esp), %edx		# get the error code
