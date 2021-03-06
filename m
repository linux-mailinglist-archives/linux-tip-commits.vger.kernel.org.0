Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFBD32FA32
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhCFLs4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:48:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34612 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhCFLso (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:48:44 -0500
Date:   Sat, 06 Mar 2021 11:48:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615031322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m++4Gq1c135Kzg9ILoKnYE+YdL72EsA8c0l4q0RoRGI=;
        b=Hxx+KyNcUJwlFVT8lCzT7paOILaPl+SH1TyrvlkSW8oP7FkccKEZECH4WdMl9UmvJJspQa
        zGjsJFlj6A+Il1BkLa8bpwORXHhLy7tL7o6tFj1LU5oZasToYTsxtOhfpevjlUwBon+/Ep
        6OIbWdgMsqx5Lnut3IlTfXwdTLF1i4ZEkFRH09n2qdh25E6bXZ9Eerxs+lH9RPiRLUgMYS
        uC/MTSoXpS1zpN5XUkLJNXLuCdWUEFOAukbdiBF0XV67YZGJ48S9zC0VRldak0uOOvsu/K
        dVB6ONlusi4Wk9Mtt2P6bfsfJ2huUy3judJ4x6C1R1Oi9r4yV8kx5ykGRgy8ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615031322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m++4Gq1c135Kzg9ILoKnYE+YdL72EsA8c0l4q0RoRGI=;
        b=Tnwv1g39DGUGz9o0mn7d8rORS2YFkV6BxXKwCv2+4Bz9M955Blvo49/uTBOCQwMKHAFYTz
        uL383um00/MZ3ACA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Allow UNWIND_HINT to suppress dodgy
 stack modifications
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210211173626.918498579@infradead.org>
References: <20210211173626.918498579@infradead.org>
MIME-Version: 1.0
Message-ID: <161503132223.398.16100360259547234905.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     d54dba41999498b38a40940e1123019d50b26496
Gitweb:        https://git.kernel.org/tip/d54dba41999498b38a40940e1123019d50b26496
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 11 Feb 2021 13:03:28 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:44:22 +01:00

objtool: Allow UNWIND_HINT to suppress dodgy stack modifications

rewind_stack_do_exit()
	UNWIND_HINT_FUNC
	/* Prevent any naive code from trying to unwind to our caller. */

	xorl	%ebp, %ebp
	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rax
	leaq	-PTREGS_SIZE(%rax), %rsp
	UNWIND_HINT_REGS

	call	do_exit

Does unspeakable things to the stack, which objtool currently fails to
detect due to a limitation in instruction decoding. This will be
rectified after which the above will result in:

arch/x86/entry/entry_64.o: warning: objtool: .text+0xab: unsupported stack register modification

Allow the UNWIND_HINT on the next instruction to suppress this, it
will overwrite the state anyway.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lkml.kernel.org/r/20210211173626.918498579@infradead.org
---
 tools/objtool/check.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 068cdb4..12b8f0f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1959,8 +1959,9 @@ static void restore_reg(struct cfi_state *cfi, unsigned char reg)
  *   41 5d			pop    %r13
  *   c3				retq
  */
-static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
-			     struct stack_op *op)
+static int update_cfi_state(struct instruction *insn,
+			    struct instruction *next_insn,
+			    struct cfi_state *cfi, struct stack_op *op)
 {
 	struct cfi_reg *cfa = &cfi->cfa;
 	struct cfi_reg *regs = cfi->regs;
@@ -2161,7 +2162,7 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 				break;
 			}
 
-			if (op->dest.reg == cfi->cfa.base) {
+			if (op->dest.reg == cfi->cfa.base && !(next_insn && next_insn->hint)) {
 				WARN_FUNC("unsupported stack register modification",
 					  insn->sec, insn->offset);
 				return -1;
@@ -2433,13 +2434,15 @@ static int propagate_alt_cfi(struct objtool_file *file, struct instruction *insn
 	return 0;
 }
 
-static int handle_insn_ops(struct instruction *insn, struct insn_state *state)
+static int handle_insn_ops(struct instruction *insn,
+			   struct instruction *next_insn,
+			   struct insn_state *state)
 {
 	struct stack_op *op;
 
 	list_for_each_entry(op, &insn->stack_ops, list) {
 
-		if (update_cfi_state(insn, &state->cfi, op))
+		if (update_cfi_state(insn, next_insn, &state->cfi, op))
 			return 1;
 
 		if (op->dest.type == OP_DEST_PUSHF) {
@@ -2719,7 +2722,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				return 0;
 		}
 
-		if (handle_insn_ops(insn, &state))
+		if (handle_insn_ops(insn, next_insn, &state))
 			return 1;
 
 		switch (insn->type) {
