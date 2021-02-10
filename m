Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F272C3170DA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 21:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhBJUCN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 15:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhBJUCI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 15:02:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB42C061756;
        Wed, 10 Feb 2021 12:01:26 -0800 (PST)
Date:   Wed, 10 Feb 2021 20:01:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612987284;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qPPDIuGLkU9JiJrpOKrZOfeulCCu2efyZx6udl8Wbyk=;
        b=r/piywTT/bLIr1u8r5rz29b/qNZ1sWRYjGLIaO6dywe4vJiCpOlX3cke9EGnnCC3D33Dui
        ++pb3s7r6y7Iz/Gn83h3lSQsPUkO2WQD/+qYkBPjlmaqeDZjMUgqaNzXn9166aDnNGcYux
        jxzx0H252cy6OOanTofy0p7/9Wi/s1FMSmTIlW9lUFfr8sgNoZAY2lEz2PuZ1FZk4SRtpl
        KXoL1SizOG/g5AaoGL4AOCMNiqge3vB9VAn699YQPeeIIIn2UxcaB9RgNIVwHl3KhXNM5f
        dISFOqhOj0dtqxxs5DmV9noQzeSXBN1WB183BzoaXRRN6aLUR/uP4WRjO94m7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612987284;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qPPDIuGLkU9JiJrpOKrZOfeulCCu2efyZx6udl8Wbyk=;
        b=kEI+UG5Z8MOEYf2/KAi5Nnh3MfCnc0Jj9R0jX0y0yg82tbYHGkkMYCGHApxOgLc9Pp1zY9
        vByxEc9RUbH4B+Ag==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Support stack-swizzle
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161298728344.23325.15458416903870844675.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     aafeb14e9da29e323b0605f8f1bae0d45d5f3acf
Gitweb:        https://git.kernel.org/tip/aafeb14e9da29e323b0605f8f1bae0d45d5f3acf
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 03 Feb 2021 12:02:17 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 10 Feb 2021 20:53:52 +01:00

objtool: Support stack-swizzle

Natively support the stack swizzle pattern:

	mov %rsp, (%[tos])
	mov %[tos], %rsp
	...
	pop %rsp

It uses the vals[] array to link the first two stack-ops, and detect
the SP to SP_INDIRECT swizzle.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 45 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5f056dd..62cd211 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1945,6 +1945,38 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 					cfa->offset = -cfi->vals[op->src.reg].offset;
 					cfi->stack_size = cfa->offset;
 
+				} else if (cfa->base == CFI_SP &&
+					   cfi->vals[op->src.reg].base == CFI_SP_INDIRECT &&
+					   cfi->vals[op->src.reg].offset == cfa->offset) {
+
+					/*
+					 * Stack swizzle:
+					 *
+					 * 1: mov %rsp, (%[tos])
+					 * 2: mov %[tos], %rsp
+					 *    ...
+					 * 3: pop %rsp
+					 *
+					 * Where:
+					 *
+					 * 1 - places a pointer to the previous
+					 *     stack at the Top-of-Stack of the
+					 *     new stack.
+					 *
+					 * 2 - switches to the new stack.
+					 *
+					 * 3 - pops the Top-of-Stack to restore
+					 *     the original stack.
+					 *
+					 * Note: we set base to SP_INDIRECT
+					 * here and preserve offset. Therefore
+					 * when the unwinder reaches ToS it
+					 * will dereference SP and then add the
+					 * offset to find the next frame, IOW:
+					 * (%rsp) + offset.
+					 */
+					cfa->base = CFI_SP_INDIRECT;
+
 				} else {
 					cfa->base = CFI_UNDEFINED;
 					cfa->offset = 0;
@@ -2047,6 +2079,13 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 
 		case OP_SRC_POP:
 		case OP_SRC_POPF:
+			if (op->dest.reg == CFI_SP && cfa->base == CFI_SP_INDIRECT) {
+
+				/* pop %rsp; # restore from a stack swizzle */
+				cfa->base = CFI_SP;
+				break;
+			}
+
 			if (!cfi->drap && op->dest.reg == cfa->base) {
 
 				/* pop %rbp */
@@ -2193,6 +2232,12 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 			/* mov reg, disp(%rsp) */
 			save_reg(cfi, op->src.reg, CFI_CFA,
 				 op->dest.offset - cfi->stack_size);
+
+		} else if (op->src.reg == CFI_SP && op->dest.offset == 0) {
+
+			/* mov %rsp, (%reg); # setup a stack swizzle. */
+			cfi->vals[op->dest.reg].base = CFI_SP_INDIRECT;
+			cfi->vals[op->dest.reg].offset = cfa->offset;
 		}
 
 		break;
