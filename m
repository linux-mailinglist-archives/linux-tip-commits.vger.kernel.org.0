Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A9037B90B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 11:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhELJYp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 05:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhELJYn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 05:24:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12126C06175F;
        Wed, 12 May 2021 02:23:36 -0700 (PDT)
Date:   Wed, 12 May 2021 09:23:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620811414;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekT+n5CCG0M45QzWTBOOK9qeE/la1TPEy7Kpp5ge2+o=;
        b=DDnmgzbB4cVS1zkvRVfyt6FP2mnshxUaI3uOkZgj5wv7gU2G2dOmiebrCe5FT4QB0wCN1y
        VACs9DjanTCfA/2WdBu5Ha317Z3QyuOG89V0lbIsJVet2H8BHhsrlb/Sn8xuPNhtjexd90
        0r4MsKOyboN/63r5ZhlPtFlN4ilMkaWRhnHSutnn8B/c/nRujT2FKY8mrm1BeX6DJ0/hzO
        wuaWubYCU4eIcnDLi8P/Py5La9cxrwVO30DZJRixrCM2gOFfXibUL6wJKJ+hdNeaIKX0Gc
        vtG+sj8tva9nmnacZemPjHvhy9ER1+J8lD8640fDBlqTz26yngpftUKzz4+sPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620811414;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekT+n5CCG0M45QzWTBOOK9qeE/la1TPEy7Kpp5ge2+o=;
        b=3icQg6Bu/rCtck33oK+4f4poBGUvSyG78LH5S0YeHqqscBS/xWyozlEjfxdsfEJ7V5MUzA
        mq1HpStyREHXeGCQ==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/entry: Unify definitions from <asm/calling.h> and
 <asm/ptrace-abi.h>
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210510185316.3307264-2-hpa@zytor.com>
References: <20210510185316.3307264-2-hpa@zytor.com>
MIME-Version: 1.0
Message-ID: <162081141389.29796.14002445951520228539.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     6627eb25e40cc8d135d3f8d5391851d18ac497d7
Gitweb:        https://git.kernel.org/tip/6627eb25e40cc8d135d3f8d5391851d18ac497d7
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Mon, 10 May 2021 11:53:10 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 10:49:13 +02:00

x86/entry: Unify definitions from <asm/calling.h> and <asm/ptrace-abi.h>

The register offsets in <asm/ptrace-abi.h> are duplicated in
entry/calling.h, but are formatted differently and therefore not
compatible. Use the version from <asm/ptrace-abi.h> consistently.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210510185316.3307264-2-hpa@zytor.com
---
 arch/x86/entry/calling.h  | 36 +-----------------------------------
 arch/x86/kernel/head_64.S |  6 +++---
 2 files changed, 4 insertions(+), 38 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 07a9331..7436d4a 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -6,6 +6,7 @@
 #include <asm/percpu.h>
 #include <asm/asm-offsets.h>
 #include <asm/processor-flags.h>
+#include <asm/ptrace-abi.h>
 
 /*
 
@@ -62,41 +63,6 @@ For 32-bit we have the following conventions - kernel is built with
  * for assembly code:
  */
 
-/* The layout forms the "struct pt_regs" on the stack: */
-/*
- * C ABI says these regs are callee-preserved. They aren't saved on kernel entry
- * unless syscall needs a complete, fully filled "struct pt_regs".
- */
-#define R15		0*8
-#define R14		1*8
-#define R13		2*8
-#define R12		3*8
-#define RBP		4*8
-#define RBX		5*8
-/* These regs are callee-clobbered. Always saved on kernel entry. */
-#define R11		6*8
-#define R10		7*8
-#define R9		8*8
-#define R8		9*8
-#define RAX		10*8
-#define RCX		11*8
-#define RDX		12*8
-#define RSI		13*8
-#define RDI		14*8
-/*
- * On syscall entry, this is syscall#. On CPU exception, this is error code.
- * On hw interrupt, it's IRQ number:
- */
-#define ORIG_RAX	15*8
-/* Return frame for iretq */
-#define RIP		16*8
-#define CS		17*8
-#define EFLAGS		18*8
-#define RSP		19*8
-#define SS		20*8
-
-#define SIZEOF_PTREGS	21*8
-
 .macro PUSH_AND_CLEAR_REGS rdx=%rdx rax=%rax save_ret=0
 	.if \save_ret
 	pushq	%rsi		/* pt_regs->si */
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 04bddaa..d8b3ebd 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -62,7 +62,7 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 */
 
 	/* Set up the stack for verify_cpu(), similar to initial_stack below */
-	leaq	(__end_init_task - SIZEOF_PTREGS)(%rip), %rsp
+	leaq	(__end_init_task - FRAME_SIZE)(%rip), %rsp
 
 	leaq	_text(%rip), %rdi
 	pushq	%rsi
@@ -343,10 +343,10 @@ SYM_DATA(initial_vc_handler,	.quad handle_vc_boot_ghcb)
 #endif
 
 /*
- * The SIZEOF_PTREGS gap is a convention which helps the in-kernel unwinder
+ * The FRAME_SIZE gap is a convention which helps the in-kernel unwinder
  * reliably detect the end of the stack.
  */
-SYM_DATA(initial_stack, .quad init_thread_union + THREAD_SIZE - SIZEOF_PTREGS)
+SYM_DATA(initial_stack, .quad init_thread_union + THREAD_SIZE - FRAME_SIZE)
 	__FINITDATA
 
 	__INIT
