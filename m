Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB9232C7A5
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 02:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355579AbhCDAcY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 3 Mar 2021 19:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842996AbhCCKXd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 3 Mar 2021 05:23:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B500C061A2E;
        Wed,  3 Mar 2021 00:45:37 -0800 (PST)
Date:   Wed, 03 Mar 2021 08:45:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614761134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MpMampsBMyX5IOrw9b+LFNwAvqWBNwqEpoZ58gU8TPg=;
        b=CxzwFim+j4pG2yTmNYEtL9cVQmu0HZlcyyWgtnWCWlUwB5Ohj9duQ7+mVUlrmTQ1Nn9Du5
        q6yWA6bJKnd1k9knkNKH+bc7QAq5+B3vdlVcsglZD2Mo+NmIduxF6UTaxTEyalCQAotGw0
        +6OZHbkyMvuhLW24rMu5UiDhWfyHBIiNuFTf/o4ER6xVZI6yvIlMeF9EJDINzCsX2nFpXb
        1dYFSExKsvakMOO9pXyNmH0fWZMtncyfe2FsR3lV5HRfuplpR2ysxcvSFLR1rjkPlkYYsC
        gvjXBm/SlBf8F3iNjzUsweZwtblkjqepae+qx8GvkTKzH3iM5euczq7eX+LWJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614761134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MpMampsBMyX5IOrw9b+LFNwAvqWBNwqEpoZ58gU8TPg=;
        b=ONwcvX/jDzGOnP8s9E+s9ZUOoRHRXzR7RJ+jDPl1rDGBkyiwAG8OIOLBliVGh1aUauKMdj
        AYr961r/CCsuVqAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool,x86: Simplify register decode
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210211173627.362004522@infradead.org>
References: <20210211173627.362004522@infradead.org>
MIME-Version: 1.0
Message-ID: <161476113387.20312.7208769424195631974.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     9d5a2c2caa10fc135d7020e76baa6a17c52e608f
Gitweb:        https://git.kernel.org/tip/9d5a2c2caa10fc135d7020e76baa6a17c52e608f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 09 Feb 2021 19:59:43 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Mar 2021 09:38:30 +01:00

objtool,x86: Simplify register decode

Since the CFI_reg number now matches the instruction encoding order do
away with the op_to_cfi_reg[] and use direct assignment.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
 
