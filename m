Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026902FAC07
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Jan 2021 22:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394389AbhARVAg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 18 Jan 2021 16:00:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389766AbhARKOh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 18 Jan 2021 05:14:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5947C061793;
        Mon, 18 Jan 2021 02:13:34 -0800 (PST)
Date:   Mon, 18 Jan 2021 10:13:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610964813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=I2ZBM6WkkiZotXtGMigd0N7nPvK1eFfLEiGUGFc86FY=;
        b=vsLEBqvdZIc1cE16oUcQ757RVmSFFpE/eZo6R53qepCH06UtlSkVJH654Xvclp1xs+pt6Y
        T8MwNi+ovAwSNH1bDxf1DbjTW44pgr0lWo3rPF8LAkB6LMLMmxSyk/eZeAajAfEEFHdC4x
        v84NcKUS7n1pfTLQHCjtzOJ6fPkGrM+GWDCDZ5jSMRetk55tM4AqF33tIEf6YeB2hugWrm
        IodAJDZ7qYp4nTI86+62z2caHDChfhYiSJ8hKrlBp3pfw6ZicOgkOXyiJhRHV5gYgGZgZE
        F18in2vqoRwFAjly8fIsD00bfx3N2FHkfNJ5GVX3sFJIYgmzmv1NJyc3RTl1cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610964813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=I2ZBM6WkkiZotXtGMigd0N7nPvK1eFfLEiGUGFc86FY=;
        b=sXzE6NWxJ/FoPJWXxBbw+4SmJLCJgSflcZqq7qYy19gH60MsxsJPmYLGFgCq8Vs4mnz3bm
        rU1zVkt5sITOxvDw==
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Make SP memory operation match PUSH/POP
 semantics
Cc:     Julien Thierry <jthierry@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161096481275.414.13788440546596030328.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     201ef5a974e24112953b74cc9f33dcfc4cbcc1cb
Gitweb:        https://git.kernel.org/tip/201ef5a974e24112953b74cc9f33dcfc4cbcc1cb
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Wed, 14 Oct 2020 08:38:02 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Wed, 13 Jan 2021 18:13:10 -06:00

objtool: Make SP memory operation match PUSH/POP semantics

Architectures without PUSH/POP instructions will always access the stack
though memory operations (SRC/DEST_INDIRECT). Make those operations have
the same effect on the CFA as PUSH/POP, with no stack pointer
modification.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 00d00f9..270adc3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2065,6 +2065,14 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 			break;
 
 		case OP_SRC_REG_INDIRECT:
+			if (!cfi->drap && op->dest.reg == cfa->base &&
+			    op->dest.reg == CFI_BP) {
+
+				/* mov disp(%rsp), %rbp */
+				cfa->base = CFI_SP;
+				cfa->offset = cfi->stack_size;
+			}
+
 			if (cfi->drap && op->src.reg == CFI_BP &&
 			    op->src.offset == cfi->drap_offset) {
 
@@ -2086,6 +2094,12 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 				/* mov disp(%rbp), %reg */
 				/* mov disp(%rsp), %reg */
 				restore_reg(cfi, op->dest.reg);
+
+			} else if (op->src.reg == CFI_SP &&
+				   op->src.offset == regs[op->dest.reg].offset + cfi->stack_size) {
+
+				/* mov disp(%rsp), %reg */
+				restore_reg(cfi, op->dest.reg);
 			}
 
 			break;
@@ -2163,6 +2177,12 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 			/* mov reg, disp(%rsp) */
 			save_reg(cfi, op->src.reg, CFI_CFA,
 				 op->dest.offset - cfi->cfa.offset);
+
+		} else if (op->dest.reg == CFI_SP) {
+
+			/* mov reg, disp(%rsp) */
+			save_reg(cfi, op->src.reg, CFI_CFA,
+				 op->dest.offset - cfi->stack_size);
 		}
 
 		break;
