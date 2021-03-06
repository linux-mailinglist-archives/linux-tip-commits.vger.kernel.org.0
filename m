Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B882B32FA36
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhCFLs5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:48:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34636 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhCFLsn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:48:43 -0500
Date:   Sat, 06 Mar 2021 11:48:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615031321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RYSx4bv10DuK6mtLmMnNkOTDLDAItqjFC6qk4uXKkqM=;
        b=yrMqAWKnlDfkicRcUN3KDXNJfaR+DBf5BgdNBCwuKxdHrZTNL3Zn5RgWIpXrAJDEYDxIH/
        09t4gKrk9ctucGyzp+U/sZXafqCkwaqejvUWxwr3JNwi4eWgbs6S/l4RuK6x4wGh/hCp82
        grslI62+8Ikc0ykZP7dExM7Kx4zfi2Xl2X4Yg2Zsw4Fqtpa+ZwbeZ+84rpbnnYCxz1lv1R
        FkR+8s8jWaYEk0Ax1kfGxxbTiWm0C87wBVHkJujeRexSOZeKgSsnG56xdBDqmjOL0BHPsD
        tsBNHxBEcvSUpIc27RtJEzfiFy/0FWgKUXIXsxtDLFDWa/DqVXG2wMYmfuOKGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615031321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RYSx4bv10DuK6mtLmMnNkOTDLDAItqjFC6qk4uXKkqM=;
        b=kEjeJD+jMSuePyEjH55j3qHrpmHP5rTQDk1h/ZanwFH1233RadlrvjKJOxByu2Jbcp7IBM
        jCyHtDX/f05bm4Ag==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool,x86: Rewrite LEAVE
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210211173627.253273977@infradead.org>
References: <20210211173627.253273977@infradead.org>
MIME-Version: 1.0
Message-ID: <161503132127.398.7320671795735867858.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     ffc7e74f36a2c7424da262a32a0bbe59669677ef
Gitweb:        https://git.kernel.org/tip/ffc7e74f36a2c7424da262a32a0bbe59669677ef
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 09 Feb 2021 21:41:13 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:44:23 +01:00

objtool,x86: Rewrite LEAVE

Since we can now have multiple stack-ops per instruction, we don't
need to special case LEAVE and can simply emit the composite
operations.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lkml.kernel.org/r/20210211173627.253273977@infradead.org
---
 tools/objtool/arch/x86/decode.c      | 14 +++++++++++---
 tools/objtool/check.c                | 24 ++----------------------
 tools/objtool/include/objtool/arch.h |  1 -
 3 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index d8f0138..47b9acf 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -446,9 +446,17 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		 * mov bp, sp
 		 * pop bp
 		 */
-		ADD_OP(op)
-			op->dest.type = OP_DEST_LEAVE;
-
+		ADD_OP(op) {
+			op->src.type = OP_SRC_REG;
+			op->src.reg = CFI_BP;
+			op->dest.type = OP_DEST_REG;
+			op->dest.reg = CFI_SP;
+		}
+		ADD_OP(op) {
+			op->src.type = OP_SRC_POP;
+			op->dest.type = OP_DEST_REG;
+			op->dest.reg = CFI_BP;
+		}
 		break;
 
 	case 0xe3:
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 12b8f0f..a0f762a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2020,7 +2020,7 @@ static int update_cfi_state(struct instruction *insn,
 			}
 
 			else if (op->src.reg == CFI_BP && op->dest.reg == CFI_SP &&
-				 cfa->base == CFI_BP) {
+				 (cfa->base == CFI_BP || cfa->base == cfi->drap_reg)) {
 
 				/*
 				 * mov %rbp, %rsp
@@ -2217,7 +2217,7 @@ static int update_cfi_state(struct instruction *insn,
 				cfa->offset = 0;
 				cfi->drap_offset = -1;
 
-			} else if (regs[op->dest.reg].offset == -cfi->stack_size) {
+			} else if (cfi->stack_size == -regs[op->dest.reg].offset) {
 
 				/* pop %reg */
 				restore_reg(cfi, op->dest.reg);
@@ -2358,26 +2358,6 @@ static int update_cfi_state(struct instruction *insn,
 
 		break;
 
-	case OP_DEST_LEAVE:
-		if ((!cfi->drap && cfa->base != CFI_BP) ||
-		    (cfi->drap && cfa->base != cfi->drap_reg)) {
-			WARN_FUNC("leave instruction with modified stack frame",
-				  insn->sec, insn->offset);
-			return -1;
-		}
-
-		/* leave (mov %rbp, %rsp; pop %rbp) */
-
-		cfi->stack_size = -cfi->regs[CFI_BP].offset - 8;
-		restore_reg(cfi, CFI_BP);
-
-		if (!cfi->drap) {
-			cfa->base = CFI_SP;
-			cfa->offset -= 8;
-		}
-
-		break;
-
 	case OP_DEST_MEM:
 		if (op->src.type != OP_SRC_POP && op->src.type != OP_SRC_POPF) {
 			WARN_FUNC("unknown stack-related memory operation",
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 6ff0685..ff21f38 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -35,7 +35,6 @@ enum op_dest_type {
 	OP_DEST_MEM,
 	OP_DEST_PUSH,
 	OP_DEST_PUSHF,
-	OP_DEST_LEAVE,
 };
 
 struct op_dest {
