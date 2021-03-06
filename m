Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBAE32FA38
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhCFLs6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhCFLsr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:48:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359F6C06175F;
        Sat,  6 Mar 2021 03:48:47 -0800 (PST)
Date:   Sat, 06 Mar 2021 11:48:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615031320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ggyPQHsMqgOOl5zwXxTSaOjd48+SIP2VmoF2S91w/CE=;
        b=WmjgcPbNnGF6xb6zMBql0JqzOD9v4OpGxjxdPYBCuXQ0UXzApznYuEuaeMFiv1u9Tt7unC
        U/FSC9amM9NfsI3DGixHXzicGO2QKFMidcACxT0+FSXPQx06U+kBjboIcxxD17OaRF/CbF
        EKS2bxvCw70Bi3ziVO5n/X5/XgPrD52R9fLS1RJiX76r5D1tU7CDs6cD6NDpj5t1HVbPKj
        ffhyLP2M8lmvGi/41Xf6VejkvAHJ/31Tjab2sRvEIpWd7JsbiUms738ZLN/TOHJEgjHNwv
        SWMahMgdgPYuO7sD4R0RmuHVND7Yr1yQCJvPFhZ3t9hFLVBFM+PP/0yyIuP5og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615031320;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ggyPQHsMqgOOl5zwXxTSaOjd48+SIP2VmoF2S91w/CE=;
        b=errWcb4RSyThDD1E9y15jwbIin8yhzCadOg0UUisZo5zM2tsRs1RYN+/BxZbJYzkbTA2xr
        F8+imIpqo/7njwCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool,x86: More ModRM sugar
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <ljatFXqQbm8@hirez.programming.kicks-ass.net>
References: <ljatFXqQbm8@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <161503132009.398.3744076218920563569.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     36d92e43d01cbeeec99abdf405362243051d6b3f
Gitweb:        https://git.kernel.org/tip/36d92e43d01cbeeec99abdf405362243051d6b3f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 12 Feb 2021 09:13:00 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:44:23 +01:00

objtool,x86: More ModRM sugar

Better helpers to decode ModRM.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/YCZB/ljatFXqQbm8@hirez.programming.kicks-ass.net
---
 tools/objtool/arch/x86/decode.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index b42e5ec..431bafb 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -82,15 +82,21 @@ unsigned long arch_jump_destination(struct instruction *insn)
  * 01 |  [r/m + d8]    |[S+d]|   [r/m + d8]  |
  * 10 |  [r/m + d32]   |[S+D]|   [r/m + d32] |
  * 11 |                   r/ m               |
- *
  */
+
+#define mod_is_mem()	(modrm_mod != 3)
+#define mod_is_reg()	(modrm_mod == 3)
+
 #define is_RIP()   ((modrm_rm & 7) == CFI_BP && modrm_mod == 0)
-#define have_SIB() ((modrm_rm & 7) == CFI_SP && modrm_mod != 3)
+#define have_SIB() ((modrm_rm & 7) == CFI_SP && mod_is_mem())
 
 #define rm_is(reg) (have_SIB() ? \
 		    sib_base == (reg) && sib_index == CFI_SP : \
 		    modrm_rm == (reg))
 
+#define rm_is_mem(reg)	(mod_is_mem() && !is_RIP() && rm_is(reg))
+#define rm_is_reg(reg)	(mod_is_reg() && modrm_rm == (reg))
+
 int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			    unsigned long offset, unsigned int maxlen,
 			    unsigned int *len, enum insn_type *type,
@@ -154,7 +160,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 	case 0x1:
 	case 0x29:
-		if (rex_w && modrm_mod == 3 && modrm_rm == CFI_SP) {
+		if (rex_w && rm_is_reg(CFI_SP)) {
 
 			/* add/sub reg, %rsp */
 			ADD_OP(op) {
@@ -219,7 +225,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			break;
 
 		/* %rsp target only */
-		if (!(modrm_mod == 3 && modrm_rm == CFI_SP))
+		if (!rm_is_reg(CFI_SP))
 			break;
 
 		imm = insn.immediate.value;
@@ -272,7 +278,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 		if (modrm_reg == CFI_SP) {
 
-			if (modrm_mod == 3) {
+			if (mod_is_reg()) {
 				/* mov %rsp, reg */
 				ADD_OP(op) {
 					op->src.type = OP_SRC_REG;
@@ -308,7 +314,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			break;
 		}
 
-		if (modrm_mod == 3 && modrm_rm == CFI_SP) {
+		if (rm_is_reg(CFI_SP)) {
 
 			/* mov reg, %rsp */
 			ADD_OP(op) {
@@ -325,7 +331,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		if (!rex_w)
 			break;
 
-		if ((modrm_mod == 1 || modrm_mod == 2) && modrm_rm == CFI_BP) {
+		if (rm_is_mem(CFI_BP)) {
 
 			/* mov reg, disp(%rbp) */
 			ADD_OP(op) {
@@ -338,7 +344,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			break;
 		}
 
-		if (modrm_mod != 3 && rm_is(CFI_SP)) {
+		if (rm_is_mem(CFI_SP)) {
 
 			/* mov reg, disp(%rsp) */
 			ADD_OP(op) {
@@ -357,7 +363,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		if (!rex_w)
 			break;
 
-		if ((modrm_mod == 1 || modrm_mod == 2) && modrm_rm == CFI_BP) {
+		if (rm_is_mem(CFI_BP)) {
 
 			/* mov disp(%rbp), reg */
 			ADD_OP(op) {
@@ -370,7 +376,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			break;
 		}
 
-		if (modrm_mod != 3 && rm_is(CFI_SP)) {
+		if (rm_is_mem(CFI_SP)) {
 
 			/* mov disp(%rsp), reg */
 			ADD_OP(op) {
@@ -386,7 +392,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		break;
 
 	case 0x8d:
-		if (modrm_mod == 3) {
+		if (mod_is_reg()) {
 			WARN("invalid LEA encoding at %s:0x%lx", sec->name, offset);
 			break;
 		}
