Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D89932C79D
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 02:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355659AbhCDAcW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 3 Mar 2021 19:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842987AbhCCKX0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 3 Mar 2021 05:23:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AAEC061A2A;
        Wed,  3 Mar 2021 00:45:35 -0800 (PST)
Date:   Wed, 03 Mar 2021 08:45:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614761133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ej3IlpyC21cesUrgNW4FET0PlvgjIlZzs988if/SCg=;
        b=AXnOYwNv7S1pTVwgQdN6ZJ2OAIcsX9OwFal4f1Oa/b66MgfLqCf8cC69TQKOshLEW1vygO
        tx1Ej2J96shDPgiC+BZBXENGQc0+1M/Z5I7ufkBLkEMjpG018gcQnQC92JawvqlKYs1UVE
        FMxSOuYrIRSvEBBlQlUxqa7IIK169B+MS5TS55A6vOOyTGw17s4mDNg255MyMO6hmCUrtz
        q/s6nar5iU3vhqXp/Bfv8lRq0iG/AW7A675T9zSMlNDfzjj2uZSXHSBkSbBeVIlOH5Cz+f
        KX9A97vdq2JXWy2JL1mNLvFKdJFz7jAkkgAn1kjY8AKN8Gld/jsGdI9fTf5lug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614761133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ej3IlpyC21cesUrgNW4FET0PlvgjIlZzs988if/SCg=;
        b=QR63V/D1sq1k0LW4Ckp3l7OwNC9agQARGv5pwSqpKVIfZDoAaGjP/RYbmK6BKsKHauab37
        Ue7OZNnQF9pEvYDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool,x86: Rewrite ADD/SUB/AND
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210211173627.588366777@infradead.org>
References: <20210211173627.588366777@infradead.org>
MIME-Version: 1.0
Message-ID: <161476113312.20312.6376931770918404958.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     e1bba6c8930b56c4afe88aa875f3d20d1cef4fe1
Gitweb:        https://git.kernel.org/tip/e1bba6c8930b56c4afe88aa875f3d20d1cef4fe1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Feb 2021 14:11:30 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Mar 2021 09:38:31 +01:00

objtool,x86: Rewrite ADD/SUB/AND

Support sign extending and imm8 forms.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lkml.kernel.org/r/20210211173627.588366777@infradead.org
---
 tools/objtool/arch/x86/decode.c | 70 +++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 19 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 78ae5be..b42e5ec 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -98,13 +98,14 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			    struct list_head *ops_list)
 {
 	struct insn insn;
-	int x86_64, sign;
+	int x86_64;
 	unsigned char op1, op2,
 		      rex = 0, rex_b = 0, rex_r = 0, rex_w = 0, rex_x = 0,
 		      modrm = 0, modrm_mod = 0, modrm_rm = 0, modrm_reg = 0,
 		      sib = 0, /* sib_scale = 0, */ sib_index = 0, sib_base = 0;
 	struct stack_op *op = NULL;
 	struct symbol *sym;
+	u64 imm;
 
 	x86_64 = is_x86_64(elf);
 	if (x86_64 == -1)
@@ -200,12 +201,54 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		*type = INSN_JUMP_CONDITIONAL;
 		break;
 
-	case 0x81:
-	case 0x83:
-		if (rex != 0x48)
+	case 0x80 ... 0x83:
+		/*
+		 * 1000 00sw : mod OP r/m : immediate
+		 *
+		 * s - sign extend immediate
+		 * w - imm8 / imm32
+		 *
+		 * OP: 000 ADD    100 AND
+		 *     001 OR     101 SUB
+		 *     010 ADC    110 XOR
+		 *     011 SBB    111 CMP
+		 */
+
+		/* 64bit only */
+		if (!rex_w)
 			break;
 
-		if (modrm == 0xe4) {
+		/* %rsp target only */
+		if (!(modrm_mod == 3 && modrm_rm == CFI_SP))
+			break;
+
+		imm = insn.immediate.value;
+		if (op1 & 2) { /* sign extend */
+			if (op1 & 1) { /* imm32 */
+				imm <<= 32;
+				imm = (s64)imm >> 32;
+			} else { /* imm8 */
+				imm <<= 56;
+				imm = (s64)imm >> 56;
+			}
+		}
+
+		switch (modrm_reg & 7) {
+		case 5:
+			imm = -imm;
+			/* fallthrough */
+		case 0:
+			/* add/sub imm, %rsp */
+			ADD_OP(op) {
+				op->src.type = OP_SRC_ADD;
+				op->src.reg = CFI_SP;
+				op->src.offset = imm;
+				op->dest.type = OP_DEST_REG;
+				op->dest.reg = CFI_SP;
+			}
+			break;
+
+		case 4:
 			/* and imm, %rsp */
 			ADD_OP(op) {
 				op->src.type = OP_SRC_AND;
@@ -215,23 +258,12 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 				op->dest.reg = CFI_SP;
 			}
 			break;
-		}
 
-		if (modrm == 0xc4)
-			sign = 1;
-		else if (modrm == 0xec)
-			sign = -1;
-		else
+		default:
+			/* WARN ? */
 			break;
-
-		/* add/sub imm, %rsp */
-		ADD_OP(op) {
-			op->src.type = OP_SRC_ADD;
-			op->src.reg = CFI_SP;
-			op->src.offset = insn.immediate.value * sign;
-			op->dest.type = OP_DEST_REG;
-			op->dest.reg = CFI_SP;
 		}
+
 		break;
 
 	case 0x89:
