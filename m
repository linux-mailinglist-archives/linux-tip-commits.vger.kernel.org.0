Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF0C32FA35
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhCFLs5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:48:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34634 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhCFLsn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:48:43 -0500
Date:   Sat, 06 Mar 2021 11:48:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615031322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H0PiRZ0RoRAXHuF26MmrlwqVmKmGYZ4ox7MSSpmrNWw=;
        b=NHj9yUCefPHzuItHtk+zp8ivqNFUGn1ZjsLPwUvZu9FhynTU3hX+LEYjEkL1Fp2h2x0Xgz
        84YjzkF1SEDprJ4Ys1jZXaDnokckKYWifaqkQ2jqJH7omLAIoxqRq0NormVtLV6GGqgjAK
        EZSrF/EglLkV7JDE2hVDDMJe/dg2hioeQ5vhWqfmQ5Obrhzleibn41z5T/SDZgibwQmVe0
        V1yhnXwZqtTL9Rpa3SYCFjuPfaXDLhVEGe8FiNTy19Ybkn5X8xiTsQYTmUwRBCKmmlgKdJ
        SiGkXrFFFfARB5z2dDXVVfzhPZr31Dh7UFzHITx7ex892EE7inSVA/2kzuImbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615031322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H0PiRZ0RoRAXHuF26MmrlwqVmKmGYZ4ox7MSSpmrNWw=;
        b=ZYH0lZf7x2Zu2wLz7jNuh2UrftejYUDw+7d9VZ3GtEGs0UmxoYa66Ad14DQY9uJkvEXXvT
        G12koXfO/cgxt9Cw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool,x86: Rewrite LEA decode
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210211173627.143250641@infradead.org>
References: <20210211173627.143250641@infradead.org>
MIME-Version: 1.0
Message-ID: <161503132159.398.426189971215196230.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2ee0c363492f1acc1082125218e6a80c0d7d502b
Gitweb:        https://git.kernel.org/tip/2ee0c363492f1acc1082125218e6a80c0d7d502b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 09 Feb 2021 21:29:16 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:44:23 +01:00

objtool,x86: Rewrite LEA decode

Current LEA decoding is a bunch of special cases, properly decode the
instruction, with exception of full SIB and RIP-relative modes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lkml.kernel.org/r/20210211173627.143250641@infradead.org
---
 tools/objtool/arch/x86/decode.c | 86 ++++++++++----------------------
 1 file changed, 28 insertions(+), 58 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 549813c..d8f0138 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -91,9 +91,10 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 {
 	struct insn insn;
 	int x86_64, sign;
-	unsigned char op1, op2, rex = 0, rex_b = 0, rex_r = 0, rex_w = 0,
-		      rex_x = 0, modrm = 0, modrm_mod = 0, modrm_rm = 0,
-		      modrm_reg = 0, sib = 0;
+	unsigned char op1, op2,
+		      rex = 0, rex_b = 0, rex_r = 0, rex_w = 0, rex_x = 0,
+		      modrm = 0, modrm_mod = 0, modrm_rm = 0, modrm_reg = 0,
+		      sib = 0;
 	struct stack_op *op = NULL;
 	struct symbol *sym;
 
@@ -328,68 +329,37 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		break;
 
 	case 0x8d:
-		if (sib == 0x24 && rex_w && !rex_b && !rex_x) {
-
-			ADD_OP(op) {
-				if (!insn.displacement.value) {
-					/* lea (%rsp), reg */
-					op->src.type = OP_SRC_REG;
-				} else {
-					/* lea disp(%rsp), reg */
-					op->src.type = OP_SRC_ADD;
-					op->src.offset = insn.displacement.value;
-				}
-				op->src.reg = CFI_SP;
-				op->dest.type = OP_DEST_REG;
-				op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
-			}
-
-		} else if (rex == 0x48 && modrm == 0x65) {
-
-			/* lea disp(%rbp), %rsp */
-			ADD_OP(op) {
-				op->src.type = OP_SRC_ADD;
-				op->src.reg = CFI_BP;
-				op->src.offset = insn.displacement.value;
-				op->dest.type = OP_DEST_REG;
-				op->dest.reg = CFI_SP;
-			}
+		if (modrm_mod == 3) {
+			WARN("invalid LEA encoding at %s:0x%lx", sec->name, offset);
+			break;
+		}
 
-		} else if (rex == 0x49 && modrm == 0x62 &&
-			   insn.displacement.value == -8) {
+		/* skip non 64bit ops */
+		if (!rex_w)
+			break;
 
-			/*
-			 * lea -0x8(%r10), %rsp
-			 *
-			 * Restoring rsp back to its original value after a
-			 * stack realignment.
-			 */
-			ADD_OP(op) {
-				op->src.type = OP_SRC_ADD;
-				op->src.reg = CFI_R10;
-				op->src.offset = -8;
-				op->dest.type = OP_DEST_REG;
-				op->dest.reg = CFI_SP;
-			}
+		/* skip nontrivial SIB */
+		if (modrm_rm == 4 && !(sib == 0x24 && rex_b == rex_x))
+			break;
 
-		} else if (rex == 0x49 && modrm == 0x65 &&
-			   insn.displacement.value == -16) {
+		/* skip RIP relative displacement */
+		if (modrm_rm == 5 && modrm_mod == 0)
+			break;
 
-			/*
-			 * lea -0x10(%r13), %rsp
-			 *
-			 * Restoring rsp back to its original value after a
-			 * stack realignment.
-			 */
-			ADD_OP(op) {
+		/* lea disp(%src), %dst */
+		ADD_OP(op) {
+			op->src.offset = insn.displacement.value;
+			if (!op->src.offset) {
+				/* lea (%src), %dst */
+				op->src.type = OP_SRC_REG;
+			} else {
+				/* lea disp(%src), %dst */
 				op->src.type = OP_SRC_ADD;
-				op->src.reg = CFI_R13;
-				op->src.offset = -16;
-				op->dest.type = OP_DEST_REG;
-				op->dest.reg = CFI_SP;
 			}
+			op->src.reg = op_to_cfi_reg[modrm_rm][rex_b];
+			op->dest.type = OP_DEST_REG;
+			op->dest.reg = op_to_cfi_reg[modrm_reg][rex_r];
 		}
-
 		break;
 
 	case 0x8f:
