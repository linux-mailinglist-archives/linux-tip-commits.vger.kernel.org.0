Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980E432C783
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 02:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355621AbhCDAcJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 3 Mar 2021 19:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582451AbhCCKWK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECA1C0610CB;
        Wed,  3 Mar 2021 00:45:40 -0800 (PST)
Date:   Wed, 03 Mar 2021 08:45:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614761135;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZE4tgXzO6KBgcOg2xfue1avIYafapWs5LQlZpLbkEVQ=;
        b=zORxVuV7zM+7IQdVbS89BS1QYTg+oy9pltZD+h1AVL7RTc3JCkN8oUQybxxgrY8lyHT1UN
        3GSjkn317/G+v8oT7d+3/qiezKZDGkopJ7YcIfLLFPbocG2Wy466eC+egxfUo5ZbmYo1Tq
        vswSM0G3OU2MHZmfcC9r66T/dAb42AWFJYGHzFAImUpxVruSuG8hnXzkGHkxik38Vvt6TU
        YoVbSLA4Ijb/XGyaAHtpqwfrM1afwNou60lrGt2ywfMojtU7WmggOgqYaQ30OKLimsVYr4
        ARFoKi7I3ygRdbdmcoy1USWvxeki5747ySj6+zUQONPiafnPJfHVw0Oh8fVRfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614761135;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZE4tgXzO6KBgcOg2xfue1avIYafapWs5LQlZpLbkEVQ=;
        b=vdnTPj1KYPal8etRvxIUlC8RYbH15K3OVOZ4RNdQ2wU3cuYTUUDMA8sKwyhMgA44yX15S3
        8Mb6ReC0sUM+d9BA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Allow UNWIND_HINT to suppress dodgy
 stack modifications
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210211173626.918498579@infradead.org>
References: <20210211173626.918498579@infradead.org>
MIME-Version: 1.0
Message-ID: <161476113526.20312.8523623729007936280.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     8c0cca513be9e3dd9c17b55b72b66751f3487577
Gitweb:        https://git.kernel.org/tip/8c0cca513be9e3dd9c17b55b72b66751f3487577
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 11 Feb 2021 13:03:28 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Mar 2021 09:38:29 +01:00

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
