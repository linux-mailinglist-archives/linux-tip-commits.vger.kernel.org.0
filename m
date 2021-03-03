Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6346632C787
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 02:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355632AbhCDAcK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 3 Mar 2021 19:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842922AbhCCKWf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A44C061A2B;
        Wed,  3 Mar 2021 00:45:35 -0800 (PST)
Date:   Wed, 03 Mar 2021 08:45:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614761134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PdwCCZLJdhpJ6bcF67VEVoiRGhEBbV515tp++QQcoms=;
        b=WUdT0u5Em1JrK6Tw2ClOCjsecTz+KsmhsABrFeY1C2eBhu0LI8akPOvmtuuTIr6X+a1+HB
        2KkemLEPxHv4j+qff29+tXAMA9fYr4H+tiXFSWsNAeLBIUNtD5ofxTqfzR5Z6HJud6/rQr
        CNmliWW+MM8HtZSNagNlocr/xxO/pK3/w2nZhf6UlTUINSJGDt563Bfz2EUPin7lg5mL/l
        Ey0ZZxcTZ+f8MloO2vPD7FTzUhRWqo21TgIKFXq5yLrP4JXwKkUJ7EXEPuGpT5ImcoMx0I
        VA+5H70ACvGG9zatXbXvRo/xdE72E2Vn7x440jalUCdo638ENaPrOMeynfQ7DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614761134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PdwCCZLJdhpJ6bcF67VEVoiRGhEBbV515tp++QQcoms=;
        b=ex4BLzyw17teMq7zAgBgPbjshY9Geq/Xb9XuWdLE9RZKY08SaqdlxNAtU8GgTb4sjdFgoE
        tSaQjRNUk34EAcDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool,x86: Support %riz encodings
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210211173627.472967498@infradead.org>
References: <20210211173627.472967498@infradead.org>
MIME-Version: 1.0
Message-ID: <161476113350.20312.2842241634559152746.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     0a8bef63e5bf4496251f7bac4ddadb5f5f489932
Gitweb:        https://git.kernel.org/tip/0a8bef63e5bf4496251f7bac4ddadb5f5f489932
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Feb 2021 11:47:35 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Mar 2021 09:38:30 +01:00

objtool,x86: Support %riz encodings

When there's a SIB byte, the register otherwise denoted by r/m will
then be denoted by SIB.base REX.b will now extend this. SIB.index == SP
is magic and notes an index value zero.

This means that there's a bunch of alternative (longer) encodings for
the same thing. Eg. 'ModRM.mod != 3, ModRM.r/m = AX' can be encoded as
'ModRM.mod != 3, ModRM.r/m = SP, SIB.base = AX, SIB.index = SP' which is actually 4
different encodings because the value of SIB.scale is irrelevant,
giving rise to 5 different but equal encodings.

Support these encodings and clean up the SIB handling in general.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lkml.kernel.org/r/20210211173627.472967498@infradead.org
---
 tools/objtool/arch/x86/decode.c | 67 ++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 19 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 5ce7dc4..78ae5be 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -72,6 +72,25 @@ unsigned long arch_jump_destination(struct instruction *insn)
 		return -1; \
 	else for (list_add_tail(&op->list, ops_list); op; op = NULL)
 
+/*
+ * Helpers to decode ModRM/SIB:
+ *
+ * r/m| AX  CX  DX  BX |  SP |  BP |  SI  DI |
+ *    | R8  R9 R10 R11 | R12 | R13 | R14 R15 |
+ * Mod+----------------+-----+-----+---------+
+ * 00 |    [r/m]       |[SIB]|[IP+]|  [r/m]  |
+ * 01 |  [r/m + d8]    |[S+d]|   [r/m + d8]  |
+ * 10 |  [r/m + d32]   |[S+D]|   [r/m + d32] |
+ * 11 |                   r/ m               |
+ *
+ */
+#define is_RIP()   ((modrm_rm & 7) == CFI_BP && modrm_mod == 0)
+#define have_SIB() ((modrm_rm & 7) == CFI_SP && modrm_mod != 3)
+
+#define rm_is(reg) (have_SIB() ? \
+		    sib_base == (reg) && sib_index == CFI_SP : \
+		    modrm_rm == (reg))
+
 int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
@@ -83,7 +102,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 	unsigned char op1, op2,
 		      rex = 0, rex_b = 0, rex_r = 0, rex_w = 0, rex_x = 0,
 		      modrm = 0, modrm_mod = 0, modrm_rm = 0, modrm_reg = 0,
-		      sib = 0 /* , sib_scale = 0, sib_index = 0, sib_base = 0 */;
+		      sib = 0, /* sib_scale = 0, */ sib_index = 0, sib_base = 0;
 	struct stack_op *op = NULL;
 	struct symbol *sym;
 
@@ -125,11 +144,9 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 	if (insn.sib.nbytes) {
 		sib = insn.sib.bytes[0];
-		/*
-		sib_scale = X86_SIB_SCALE(sib);
+		/* sib_scale = X86_SIB_SCALE(sib); */
 		sib_index = X86_SIB_INDEX(sib) + 8*rex_x;
 		sib_base  = X86_SIB_BASE(sib)  + 8*rex_b;
-		 */
 	}
 
 	switch (op1) {
@@ -218,7 +235,10 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		break;
 
 	case 0x89:
-		if (rex_w && modrm_reg == CFI_SP) {
+		if (!rex_w)
+			break;
+
+		if (modrm_reg == CFI_SP) {
 
 			if (modrm_mod == 3) {
 				/* mov %rsp, reg */
@@ -231,14 +251,17 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 				break;
 
 			} else {
-				/* skip nontrivial SIB */
-				if ((modrm_rm & 7) == 4 && !(sib == 0x24 && rex_b == rex_x))
-					break;
-
 				/* skip RIP relative displacement */
-				if ((modrm_rm & 7) == 5 && modrm_mod == 0)
+				if (is_RIP())
 					break;
 
+				/* skip nontrivial SIB */
+				if (have_SIB()) {
+					modrm_rm = sib_base;
+					if (sib_index != CFI_SP)
+						break;
+				}
+
 				/* mov %rsp, disp(%reg) */
 				ADD_OP(op) {
 					op->src.type = OP_SRC_REG;
@@ -253,7 +276,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			break;
 		}
 
-		if (rex_w && modrm_mod == 3 && modrm_rm == CFI_SP) {
+		if (modrm_mod == 3 && modrm_rm == CFI_SP) {
 
 			/* mov reg, %rsp */
 			ADD_OP(op) {
@@ -267,6 +290,9 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 		/* fallthrough */
 	case 0x88:
+		if (!rex_w)
+			break;
+
 		if ((modrm_mod == 1 || modrm_mod == 2) && modrm_rm == CFI_BP) {
 
 			/* mov reg, disp(%rbp) */
@@ -280,7 +306,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			break;
 		}
 
-		if (rex_w && modrm_rm == CFI_SP && sib == 0x24) {
+		if (modrm_mod != 3 && rm_is(CFI_SP)) {
 
 			/* mov reg, disp(%rsp) */
 			ADD_OP(op) {
@@ -299,7 +325,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		if (!rex_w)
 			break;
 
-		if (modrm_mod == 1 && modrm_rm == CFI_BP) {
+		if ((modrm_mod == 1 || modrm_mod == 2) && modrm_rm == CFI_BP) {
 
 			/* mov disp(%rbp), reg */
 			ADD_OP(op) {
@@ -312,7 +338,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			break;
 		}
 
-		if (modrm_mod != 3 && modrm_rm == CFI_SP && sib == 0x24) {
+		if (modrm_mod != 3 && rm_is(CFI_SP)) {
 
 			/* mov disp(%rsp), reg */
 			ADD_OP(op) {
@@ -337,14 +363,17 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		if (!rex_w)
 			break;
 
-		/* skip nontrivial SIB */
-		if ((modrm_rm & 7) == 4 && !(sib == 0x24 && rex_b == rex_x))
-			break;
-
 		/* skip RIP relative displacement */
-		if ((modrm_rm & 7) == 5 && modrm_mod == 0)
+		if (is_RIP())
 			break;
 
+		/* skip nontrivial SIB */
+		if (have_SIB()) {
+			modrm_rm = sib_base;
+			if (sib_index != CFI_SP)
+				break;
+		}
+
 		/* lea disp(%src), %dst */
 		ADD_OP(op) {
 			op->src.offset = insn.displacement.value;
