Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556061B5041
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Apr 2020 00:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgDVWZh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Apr 2020 18:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726788AbgDVWZV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Apr 2020 18:25:21 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449C0C03C1A9;
        Wed, 22 Apr 2020 15:25:21 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRNnM-0001OM-Gy; Thu, 23 Apr 2020 00:24:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 712CD1C0450;
        Thu, 23 Apr 2020 00:24:38 +0200 (CEST)
Date:   Wed, 22 Apr 2020 22:24:37 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86,ftrace: Fix ftrace_regs_caller() unwind
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416115118.749606694@infradead.org>
References: <20200416115118.749606694@infradead.org>
MIME-Version: 1.0
Message-ID: <158759427795.28353.1162287929001307268.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     5d6cd2a33032b6283b43d9787807f21c1298fd6d
Gitweb:        https://git.kernel.org/tip/5d6cd2a33032b6283b43d9787807f21c1298fd6d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 01 Apr 2020 16:53:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Apr 2020 23:10:05 +02:00

x86,ftrace: Fix ftrace_regs_caller() unwind

The ftrace_regs_caller() trampoline does something 'funny' when there
is a direct-caller present. In that case it stuffs the 'direct-caller'
address on the return stack and then exits the function. This then
results in 'returning' to the direct-caller with the exact registers
we came in with -- an indirect tail-call without using a register.

This however (rightfully) confuses objtool because the function shares
a few instruction in order to have a single exit path, but the stack
layout is different for them, depending through which path we came
there.

This is currently cludged by forcing the stack state to the non-direct
case, but this generates actively wrong (ORC) unwind information for
the direct case, leading to potential broken unwinds.

Fix this issue by fully separating the exit paths. This results in
having to poke a second RET into the trampoline copy, see
ftrace_regs_caller_ret.

This brings us to a second objtool problem, in order for it to
perceive the 'jmp ftrace_epilogue' as a function exit, it needs to be
recognised as a tail call. In order to make that happen,
ftrace_epilogue needs to be the start of an STT_FUNC, so re-arrange
code to make this so.

Finally, a third issue is that objtool requires functions to exit with
the same stack layout they started with, which is obviously violated
in the direct case, employ the new HINT_RET_OFFSET to tell objtool
this is an expected exception.

Together, this results in generating correct ORC unwind information
for the ftrace_regs_caller() function and it's trampoline copies.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200416115118.749606694@infradead.org
---
 arch/x86/kernel/ftrace.c    | 12 ++++++++++--
 arch/x86/kernel/ftrace_64.S | 32 +++++++++++++++-----------------
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 37a0aea..867c126 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -282,7 +282,8 @@ static inline void tramp_free(void *tramp) { }
 
 /* Defined as markers to the end of the ftrace default trampolines */
 extern void ftrace_regs_caller_end(void);
-extern void ftrace_epilogue(void);
+extern void ftrace_regs_caller_ret(void);
+extern void ftrace_caller_end(void);
 extern void ftrace_caller_op_ptr(void);
 extern void ftrace_regs_caller_op_ptr(void);
 
@@ -334,7 +335,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 		call_offset = (unsigned long)ftrace_regs_call;
 	} else {
 		start_offset = (unsigned long)ftrace_caller;
-		end_offset = (unsigned long)ftrace_epilogue;
+		end_offset = (unsigned long)ftrace_caller_end;
 		op_offset = (unsigned long)ftrace_caller_op_ptr;
 		call_offset = (unsigned long)ftrace_call;
 	}
@@ -366,6 +367,13 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	if (WARN_ON(ret < 0))
 		goto fail;
 
+	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
+		ip = trampoline + (ftrace_regs_caller_ret - ftrace_regs_caller);
+		ret = probe_kernel_read(ip, (void *)retq, RET_SIZE);
+		if (WARN_ON(ret < 0))
+			goto fail;
+	}
+
 	/*
 	 * The address of the ftrace_ops that is used for this trampoline
 	 * is stored at the end of the trampoline. This will be used to
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 369e61f..7657dc7 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -157,8 +157,12 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	 * think twice before adding any new code or changing the
 	 * layout here.
 	 */
-SYM_INNER_LABEL(ftrace_epilogue, SYM_L_GLOBAL)
+SYM_INNER_LABEL(ftrace_caller_end, SYM_L_GLOBAL)
 
+	jmp ftrace_epilogue
+SYM_FUNC_END(ftrace_caller);
+
+SYM_FUNC_START(ftrace_epilogue)
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
 	jmp ftrace_stub
@@ -170,14 +174,12 @@ SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
  */
 SYM_INNER_LABEL_ALIGN(ftrace_stub, SYM_L_WEAK)
 	retq
-SYM_FUNC_END(ftrace_caller)
+SYM_FUNC_END(ftrace_epilogue)
 
 SYM_FUNC_START(ftrace_regs_caller)
 	/* Save the current flags before any operations that can change them */
 	pushfq
 
-	UNWIND_HINT_SAVE
-
 	/* added 8 bytes to save flags */
 	save_mcount_regs 8
 	/* save_mcount_regs fills in first two parameters */
@@ -233,7 +235,10 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	movq ORIG_RAX(%rsp), %rax
 	movq %rax, MCOUNT_REG_SIZE-8(%rsp)
 
-	/* If ORIG_RAX is anything but zero, make this a call to that */
+	/*
+	 * If ORIG_RAX is anything but zero, make this a call to that.
+	 * See arch_ftrace_set_direct_caller().
+	 */
 	movq ORIG_RAX(%rsp), %rax
 	cmpq	$0, %rax
 	je	1f
@@ -244,20 +249,14 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	movq %rax, MCOUNT_REG_SIZE(%rsp)
 
 	restore_mcount_regs 8
+	/* Restore flags */
+	popfq
 
-	jmp	2f
+SYM_INNER_LABEL(ftrace_regs_caller_ret, SYM_L_GLOBAL);
+	UNWIND_HINT_RET_OFFSET
+	jmp	ftrace_epilogue
 
 1:	restore_mcount_regs
-
-
-2:
-	/*
-	 * The stack layout is nondetermistic here, depending on which path was
-	 * taken.  This confuses objtool and ORC, rightfully so.  For now,
-	 * pretend the stack always looks like the non-direct case.
-	 */
-	UNWIND_HINT_RESTORE
-
 	/* Restore flags */
 	popfq
 
@@ -268,7 +267,6 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	 * to the return.
 	 */
 SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
-
 	jmp ftrace_epilogue
 
 SYM_FUNC_END(ftrace_regs_caller)
