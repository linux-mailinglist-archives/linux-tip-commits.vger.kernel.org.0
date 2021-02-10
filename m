Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEED13170DC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 21:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhBJUCP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 15:02:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33920 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbhBJUCJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 15:02:09 -0500
Date:   Wed, 10 Feb 2021 20:01:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612987284;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=NAG5tZW1s1hx0qbqWafbTekfxwnHZGM0+TwDwspXj2k=;
        b=sUw2OqiEeL459l0J+RF9f41RQGovR6snKK5ocQb6/5cTjnlPoY4H2BRIofKnwzHTzWno72
        sz6MfVo2HmROjOSHlnnZRIro5ODC9EaEBnpCxbxKvRM3ihClPtoqTFQsuyH44sp/ZzXaFS
        kdL2Ujn2YNBpMbMmh0mJXHQSQzAToMW/7n2anuxGxOgAqPYoqO6FkFDn9AHjfb0irnVsiE
        DA+Dua56M+XpqqdycNfq74ks7OEjhdn7ff5dvriGOg+V1UFDW5lo8CKmeaKo/oWs/gr99U
        HJQgUrHolDia3ouLafGoJ41pHfYIvePtv+M3808cmdcT7Q6r4yu+VuLgDju8OQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612987284;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=NAG5tZW1s1hx0qbqWafbTekfxwnHZGM0+TwDwspXj2k=;
        b=LJO0L7wUq5muq0lNTxYpMZU+lc+wqXK3Cfcm7hHT1wffkmEUMC0PkcLAmpL/fv7jn3kwzM
        zXPoSftWT20gnmCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool,x86: Additionally decode: mov %rsp, (%reg)
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161298728379.23325.6214403293054349309.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2a512829840eb97a8b52eca7058e56d484468f2d
Gitweb:        https://git.kernel.org/tip/2a512829840eb97a8b52eca7058e56d484468f2d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 03 Feb 2021 12:02:18 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 10 Feb 2021 20:53:52 +01:00

objtool,x86: Additionally decode: mov %rsp, (%reg)

Where we already decode: mov %rsp, %reg, also decode mov %rsp, (%reg).

Nothing should match for this new stack-op.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/arch/x86/decode.c | 42 +++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 9637e3b..549813c 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -222,15 +222,38 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 		break;
 
 	case 0x89:
-		if (rex_w && !rex_r && modrm_mod == 3 && modrm_reg == 4) {
+		if (rex_w && !rex_r && modrm_reg == 4) {
 
-			/* mov %rsp, reg */
-			ADD_OP(op) {
-				op->src.type = OP_SRC_REG;
-				op->src.reg = CFI_SP;
-				op->dest.type = OP_DEST_REG;
-				op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
+			if (modrm_mod == 3) {
+				/* mov %rsp, reg */
+				ADD_OP(op) {
+					op->src.type = OP_SRC_REG;
+					op->src.reg = CFI_SP;
+					op->dest.type = OP_DEST_REG;
+					op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
+				}
+				break;
+
+			} else {
+				/* skip nontrivial SIB */
+				if (modrm_rm == 4 && !(sib == 0x24 && rex_b == rex_x))
+					break;
+
+				/* skip RIP relative displacement */
+				if (modrm_rm == 5 && modrm_mod == 0)
+					break;
+
+				/* mov %rsp, disp(%reg) */
+				ADD_OP(op) {
+					op->src.type = OP_SRC_REG;
+					op->src.reg = CFI_SP;
+					op->dest.type = OP_DEST_REG_INDIRECT;
+					op->dest.reg = op_to_cfi_reg[modrm_rm][rex_b];
+					op->dest.offset = insn.displacement.value;
+				}
+				break;
 			}
+
 			break;
 		}
 
@@ -259,8 +282,10 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 				op->dest.reg = CFI_BP;
 				op->dest.offset = insn.displacement.value;
 			}
+			break;
+		}
 
-		} else if (rex_w && !rex_b && modrm_rm == 4 && sib == 0x24) {
+		if (rex_w && !rex_b && modrm_rm == 4 && sib == 0x24) {
 
 			/* mov reg, disp(%rsp) */
 			ADD_OP(op) {
@@ -270,6 +295,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 				op->dest.reg = CFI_SP;
 				op->dest.offset = insn.displacement.value;
 			}
+			break;
 		}
 
 		break;
