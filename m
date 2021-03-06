Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83EA32FA33
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhCFLs4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:48:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34612 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhCFLsn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:48:43 -0500
Date:   Sat, 06 Mar 2021 11:48:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615031321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+hTJFuSdr3DSbHKFQXglsHNiuuYyS/2A42V1enWWpHA=;
        b=erKkzYAgzF0uWY2QgRTgbGEYerSyvIDEPsLi671FFuq5MLmbditks3CPSRJ0f/k7vS1DmI
        2jzQS2oLNvLPLcPM+tgyVH8jLmZUmeyRtanZaZHx0p3IyJElZOm7eY0efe3EPIEOgQG3mO
        zEShbyiDW7SJk66FBc2+GQYFJhVJB9XsmgCpoemKMGpAAWWKjKD0QH9lmZNSlKQq0nIwk+
        STHPV9B+iW0x+WXG6YfbzeGgyHP68WW0Gup2PMKWaFCDqW9DA3fNQ30VIg8ZWTDLXZUbUQ
        cf2NKCVsvPpG4GBphcbRUtIkCD0UInhVHt0UwS7u1bAgGhFtRf5ceOK3C0Fc4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615031321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+hTJFuSdr3DSbHKFQXglsHNiuuYyS/2A42V1enWWpHA=;
        b=6NqKCQF4lpm7N0wBLxoM09Wcklqukrz863FKY2mUDn55zF1NXDXncF22CIfL/ef5JwN2z/
        jMTtjkqSLU1o8AAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool,x86: Simplify register decode
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210211173627.362004522@infradead.org>
References: <20210211173627.362004522@infradead.org>
MIME-Version: 1.0
Message-ID: <161503132097.398.6826787695200281632.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     16ef7f159c503c7befec7018ee0e82fdc311721e
Gitweb:        https://git.kernel.org/tip/16ef7f159c503c7befec7018ee0e82fdc311721e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 09 Feb 2021 19:59:43 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:44:23 +01:00

objtool,x86: Simplify register decode

Since the CFI_reg number now matches the instruction encoding order do
away with the op_to_cfi_reg[] and use direct assignment.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lkml.kernel.org/r/20210211173627.362004522@infradead.org
---
 tools/objtool/arch/x86/decode.c | 79 +++++++++++++++-----------------
 1 file changed, 39 insertions(+), 40 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 47b9acf..5ce7dc4 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -17,17 +17,6 @@
 #include <objtool/arch.h>
 #include <objtool/warn.h>
 
-static unsigned char op_to_cfi_reg[][2] = {
-	{CFI_AX, CFI_R8},
-	{CFI_CX, CFI_R9},
-	{CFI_DX, CFI_R10},
-	{CFI_BX, CFI_R11},
-	{CFI_SP, CFI_R12},
-	{CFI_BP, CFI_R13},
-	{CFI_SI, CFI_R14},
-	{CFI_DI, CFI_R15},
-};
-
 static int is_x86_64(const struct elf *elf)
 {
 	switch (elf->ehdr.e_machine) {
@@ -94,7 +83,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 	unsigned char op1, op2,
 		      rex = 0, rex_b = 0, rex_r = 0, rex_w = 0, rex_x = 0,
 		      modrm = 0, modrm_mod = 0, modrm_rm = 0, modrm_reg = 0,
-		      sib = 0;
+		      sib = 0 /* , sib_scale = 0, sib_index = 0, sib_base = 0 */;
 	struct stack_op *op = NULL;
 	struct symbol *sym;
 
@@ -130,23 +119,29 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 	if (insn.modrm.nbytes) {
 		modrm = insn.modrm.bytes[0];
 		modrm_mod = X86_MODRM_MOD(modrm);
-		modrm_reg = X86_MODRM_REG(modrm);
-		modrm_rm = X86_MODRM_RM(modrm);
+		modrm_reg = X86_MODRM_REG(modrm) + 8*rex_r;
+		modrm_rm  = X86_MODRM_RM(modrm)  + 8*rex_b;
 	}
 
-	if (insn.sib.nbytes)
+	if (insn.sib.nbytes) {
 		sib = insn.sib.bytes[0];
+		/*
+		sib_scale = X86_SIB_SCALE(sib);
+		sib_index = X86_SIB_INDEX(sib) + 8*rex_x;
+		sib_base  = X86_SIB_BASE(sib)  + 8*rex_b;
+		 */
+	}
 
 	switch (op1) {
 
 	case 0x1:
 	case 0x29:
-		if (rex_w && !rex_b && modrm_mod == 3 && modrm_rm == 4) {
+		if (rex_w && modrm_mod == 3 && modrm_rm == CFI_SP) {
 
 			/* add/sub reg, %rsp */
 			ADD_OP(op) {
 				op->src.type = OP_SRC_ADD;
-				op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
+				op->src.reg = modrm_reg;
 				op->dest.type = OP_DEST_REG;
 				op->dest.reg = CFI_SP;
 			}
@@ -158,7 +153,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		/* push reg */
 		ADD_OP(op) {
 			op->src.type = OP_SRC_REG;
-			op->src.reg = op_to_cfi_reg[op1 & 0x7][rex_b];
+			op->src.reg = (op1 & 0x7) + 8*rex_b;
 			op->dest.type = OP_DEST_PUSH;
 		}
 
@@ -170,7 +165,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		ADD_OP(op) {
 			op->src.type = OP_SRC_POP;
 			op->dest.type = OP_DEST_REG;
-			op->dest.reg = op_to_cfi_reg[op1 & 0x7][rex_b];
+			op->dest.reg = (op1 & 0x7) + 8*rex_b;
 		}
 
 		break;
@@ -223,7 +218,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		break;
 
 	case 0x89:
-		if (rex_w && !rex_r && modrm_reg == 4) {
+		if (rex_w && modrm_reg == CFI_SP) {
 
 			if (modrm_mod == 3) {
 				/* mov %rsp, reg */
@@ -231,17 +226,17 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 					op->src.type = OP_SRC_REG;
 					op->src.reg = CFI_SP;
 					op->dest.type = OP_DEST_REG;
-					op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
+					op->dest.reg = modrm_rm;
 				}
 				break;
 
 			} else {
 				/* skip nontrivial SIB */
-				if (modrm_rm == 4 && !(sib == 0x24 && rex_b == rex_x))
+				if ((modrm_rm & 7) == 4 && !(sib == 0x24 && rex_b == rex_x))
 					break;
 
 				/* skip RIP relative displacement */
-				if (modrm_rm == 5 && modrm_mod == 0)
+				if ((modrm_rm & 7) == 5 && modrm_mod == 0)
 					break;
 
 				/* mov %rsp, disp(%reg) */
@@ -249,7 +244,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 					op->src.type = OP_SRC_REG;
 					op->src.reg = CFI_SP;
 					op->dest.type = OP_DEST_REG_INDIRECT;
-					op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
+					op->dest.reg = modrm_rm;
 					op->dest.offset = insn.displacement.value;
 				}
 				break;
@@ -258,12 +253,12 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			break;
 		}
 
-		if (rex_w && !rex_b && modrm_mod == 3 && modrm_rm == 4) {
+		if (rex_w && modrm_mod == 3 && modrm_rm == CFI_SP) {
 
 			/* mov reg, %rsp */
 			ADD_OP(op) {
 				op->src.type = OP_SRC_REG;
-				op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
+				op->src.reg = modrm_reg;
 				op->dest.type = OP_DEST_REG;
 				op->dest.reg = CFI_SP;
 			}
@@ -272,13 +267,12 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 		/* fallthrough */
 	case 0x88:
-		if (!rex_b &&
-		    (modrm_mod == 1 || modrm_mod == 2) && modrm_rm == 5) {
+		if ((modrm_mod == 1 || modrm_mod == 2) && modrm_rm == CFI_BP) {
 
 			/* mov reg, disp(%rbp) */
 			ADD_OP(op) {
 				op->src.type = OP_SRC_REG;
-				op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
+				op->src.reg = modrm_reg;
 				op->dest.type = OP_DEST_REG_INDIRECT;
 				op->dest.reg = CFI_BP;
 				op->dest.offset = insn.displacement.value;
@@ -286,12 +280,12 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			break;
 		}
 
-		if (rex_w && !rex_b && modrm_rm == 4 && sib == 0x24) {
+		if (rex_w && modrm_rm == CFI_SP && sib == 0x24) {
 
 			/* mov reg, disp(%rsp) */
 			ADD_OP(op) {
 				op->src.type = OP_SRC_REG;
-				op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
+				op->src.reg = modrm_reg;
 				op->dest.type = OP_DEST_REG_INDIRECT;
 				op->dest.reg = CFI_SP;
 				op->dest.offset = insn.displacement.value;
@@ -302,7 +296,10 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		break;
 
 	case 0x8b:
-		if (rex_w && !rex_b && modrm_mod == 1 && modrm_rm == 5) {
+		if (!rex_w)
+			break;
+
+		if (modrm_mod == 1 && modrm_rm == CFI_BP) {
 
 			/* mov disp(%rbp), reg */
 			ADD_OP(op) {
@@ -310,11 +307,12 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 				op->src.reg = CFI_BP;
 				op->src.offset = insn.displacement.value;
 				op->dest.type = OP_DEST_REG;
-				op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
+				op->dest.reg = modrm_reg;
 			}
+			break;
+		}
 
-		} else if (rex_w && !rex_b && sib == 0x24 &&
-			   modrm_mod != 3 && modrm_rm == 4) {
+		if (modrm_mod != 3 && modrm_rm == CFI_SP && sib == 0x24) {
 
 			/* mov disp(%rsp), reg */
 			ADD_OP(op) {
@@ -322,8 +320,9 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 				op->src.reg = CFI_SP;
 				op->src.offset = insn.displacement.value;
 				op->dest.type = OP_DEST_REG;
-				op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
+				op->dest.reg = modrm_reg;
 			}
+			break;
 		}
 
 		break;
@@ -339,11 +338,11 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			break;
 
 		/* skip nontrivial SIB */
-		if (modrm_rm == 4 && !(sib == 0x24 && rex_b == rex_x))
+		if ((modrm_rm & 7) == 4 && !(sib == 0x24 && rex_b == rex_x))
 			break;
 
 		/* skip RIP relative displacement */
-		if (modrm_rm == 5 && modrm_mod == 0)
+		if ((modrm_rm & 7) == 5 && modrm_mod == 0)
 			break;
 
 		/* lea disp(%src), %dst */
@@ -356,9 +355,9 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 				/* lea disp(%src), %dst */
 				op->src.type = OP_SRC_ADD;
 			}
-			op->src.reg = op_to_cfi_reg[modrm_rm][rex_b];
+			op->src.reg = modrm_rm;
 			op->dest.type = OP_DEST_REG;
-			op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
+			op->dest.reg = modrm_reg;
 		}
 		break;
 
