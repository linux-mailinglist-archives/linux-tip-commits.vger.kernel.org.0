Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF83426F7FC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 10:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgIRITx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 04:19:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60932 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgIRITx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 04:19:53 -0400
Date:   Fri, 18 Sep 2020 08:19:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600417190;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4dw99OjleOPqUN3QggAPJrNX40sLG3KUrNIRbmz5Rjg=;
        b=OWhi05WBstVtE+CXo3CSXBxac2vrSHeS5UZYyOWXcqi28CnG1s+bOZx6fOFLjbISXHf3wW
        u0ukN4eQXXkGlzaWaJ9NQwuEEauY+lSWPdnhwq2DP79pdMGg+AOktclN+WyJOGf3Bf7EqO
        ZKvHfGS7ZVMCmIMM/6TKk2nlqPDL6qiAcvv8UJ2Mlm3oOPb386hBfgTk9+obPupl+Pyznw
        ovPx/TUL1iymcTweI04eNn3TKDfUzsvmPS62JmsDfNYGBx9NPqLfSwzoxYqAXAV6jpfQF1
        IDYmYiDeyXcNDXrWKrZorgdJM2OgLVCoC0rfzu4/KERVhYSJp1yS7Ctk3vFJEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600417190;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4dw99OjleOPqUN3QggAPJrNX40sLG3KUrNIRbmz5Rjg=;
        b=wLGPjceIesBopBoEVauKhqC3cC/5KB9tRwaJvDv87w3TkBj96N8qspexAnLb14ox2YfKeI
        Dedcx2HLjB5CEdDA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/unwind/fp: Fix FP unwinding in ret_from_fork
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <f366bbf5a8d02e2318ee312f738112d0af74d16f.1600103007.git.jpoimboe@redhat.com>
References: <f366bbf5a8d02e2318ee312f738112d0af74d16f.1600103007.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <160041718943.15536.685517727562060677.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     6f9885a36c006d798319661fa849f9c2922223b9
Gitweb:        https://git.kernel.org/tip/6f9885a36c006d798319661fa849f9c2922223b9
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 14 Sep 2020 12:04:22 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Sep 2020 09:59:40 +02:00

x86/unwind/fp: Fix FP unwinding in ret_from_fork

There have been some reports of "bad bp value" warnings printed by the
frame pointer unwinder:

  WARNING: kernel stack regs at 000000005bac7112 in sh:1014 has bad 'bp' value 0000000000000000

This warning happens when unwinding from an interrupt in
ret_from_fork(). If entry code gets interrupted, the state of the
frame pointer (rbp) may be undefined, which can confuse the unwinder,
resulting in warnings like the above.

There's an in_entry_code() check which normally silences such
warnings for entry code. But in this case, ret_from_fork() is getting
interrupted. It recently got moved out of .entry.text, so the
in_entry_code() check no longer works.

It could be moved back into .entry.text, but that would break the
noinstr validation because of the call to schedule_tail().

Instead, initialize each new task's RBP to point to the task's entry
regs via an encoded frame pointer.  That will allow the unwinder to
reach the end of the stack gracefully.

Fixes: b9f6976bfb94 ("x86/entry/64: Move non entry code into .text section")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/f366bbf5a8d02e2318ee312f738112d0af74d16f.1600103007.git.jpoimboe@redhat.com
---
 arch/x86/include/asm/frame.h | 19 +++++++++++++++++++
 arch/x86/kernel/process.c    |  3 ++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/frame.h b/arch/x86/include/asm/frame.h
index 296b346..fb42659 100644
--- a/arch/x86/include/asm/frame.h
+++ b/arch/x86/include/asm/frame.h
@@ -60,12 +60,26 @@
 #define FRAME_END "pop %" _ASM_BP "\n"
 
 #ifdef CONFIG_X86_64
+
 #define ENCODE_FRAME_POINTER			\
 	"lea 1(%rsp), %rbp\n\t"
+
+static inline unsigned long encode_frame_pointer(struct pt_regs *regs)
+{
+	return (unsigned long)regs + 1;
+}
+
 #else /* !CONFIG_X86_64 */
+
 #define ENCODE_FRAME_POINTER			\
 	"movl %esp, %ebp\n\t"			\
 	"andl $0x7fffffff, %ebp\n\t"
+
+static inline unsigned long encode_frame_pointer(struct pt_regs *regs)
+{
+	return (unsigned long)regs & 0x7fffffff;
+}
+
 #endif /* CONFIG_X86_64 */
 
 #endif /* __ASSEMBLY__ */
@@ -83,6 +97,11 @@
 
 #define ENCODE_FRAME_POINTER
 
+static inline unsigned long encode_frame_pointer(struct pt_regs *regs)
+{
+	return 0;
+}
+
 #endif
 
 #define FRAME_BEGIN
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 13ce616..ba4593a 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -42,6 +42,7 @@
 #include <asm/spec-ctrl.h>
 #include <asm/io_bitmap.h>
 #include <asm/proto.h>
+#include <asm/frame.h>
 
 #include "process.h"
 
@@ -133,7 +134,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	fork_frame = container_of(childregs, struct fork_frame, regs);
 	frame = &fork_frame->frame;
 
-	frame->bp = 0;
+	frame->bp = encode_frame_pointer(childregs);
 	frame->ret_addr = (unsigned long) ret_from_fork;
 	p->thread.sp = (unsigned long) fork_frame;
 	p->thread.io_bitmap = NULL;
