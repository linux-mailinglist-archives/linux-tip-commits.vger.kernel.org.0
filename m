Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872542FAC4B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Jan 2021 22:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389250AbhARVBS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 18 Jan 2021 16:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388898AbhARKNv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 18 Jan 2021 05:13:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668F5C061794;
        Mon, 18 Jan 2021 02:13:35 -0800 (PST)
Date:   Mon, 18 Jan 2021 10:13:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610964813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=07ABsj8vSQfCm0mWOFUdNAnILy7jsHZI1jfx7f7YmOA=;
        b=L0YfUjBT3pvShkwkE8xFJk897Ca6fQUz2VfolWNF+V08vhJOHz6Nojl0pxDgJB0BqLaffX
        blzeY7m70NEiSCzXGOIbLf7zAUU2eKclrW47R3dlN9m48zoceK7n0WNQL8C+66dLkqB0Ui
        LxmrtUEggi8qMSIwwnGBo9QtyFJdlVqs9n3C4UqWkg0Ol1x5Qr3bo8F8hlwj9gMA69oclr
        rMuzXOtv15Pi/3WDI6EZd0Im0k3UXSpQoMH+cIqVH4MbEXuRRvBxNYARjUcUSC6x9eo8P0
        dGhhZK+7wim2X3qC+OqsDz+tQdv95pBpBEs0pEHIjnV/2pqmCmJwAp2TmhqHBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610964813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=07ABsj8vSQfCm0mWOFUdNAnILy7jsHZI1jfx7f7YmOA=;
        b=zyTr8U8vtBsFcVMk2EurT/gZC+RkS1w+h3oFbWstW+ESCTkqbPSTpY6DPtTwzyHHVLWvEA
        gEb05ZuSbCGSEvCQ==
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fully validate the stack frame
Cc:     Julien Thierry <jthierry@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161096481310.414.8564484097026936685.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     fb084fde0c8106bc86df243411751c3421c07c08
Gitweb:        https://git.kernel.org/tip/fb084fde0c8106bc86df243411751c3421c07c08
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Wed, 14 Oct 2020 08:38:00 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Wed, 13 Jan 2021 18:13:09 -06:00

objtool: Fully validate the stack frame

A valid stack frame should contain both the return address and the
previous frame pointer value.

On x86, the return value is placed on the stack by the calling
instructions. On other architectures, the callee needs to explicitly
save the return address on the stack.

Add the necessary checks to verify a function properly sets up all the
elements of the stack frame.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5f8d3ee..88210b0 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1733,12 +1733,20 @@ static bool has_modified_stack_frame(struct instruction *insn, struct insn_state
 	return false;
 }
 
+static bool check_reg_frame_pos(const struct cfi_reg *reg,
+				int expected_offset)
+{
+	return reg->base == CFI_CFA &&
+	       reg->offset == expected_offset;
+}
+
 static bool has_valid_stack_frame(struct insn_state *state)
 {
 	struct cfi_state *cfi = &state->cfi;
 
-	if (cfi->cfa.base == CFI_BP && cfi->regs[CFI_BP].base == CFI_CFA &&
-	    cfi->regs[CFI_BP].offset == -16)
+	if (cfi->cfa.base == CFI_BP &&
+	    check_reg_frame_pos(&cfi->regs[CFI_BP], -cfi->cfa.offset) &&
+	    check_reg_frame_pos(&cfi->regs[CFI_RA], -cfi->cfa.offset + 8))
 		return true;
 
 	if (cfi->drap && cfi->regs[CFI_BP].base == CFI_BP)
@@ -1867,8 +1875,7 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 		case OP_SRC_REG:
 			if (op->src.reg == CFI_SP && op->dest.reg == CFI_BP &&
 			    cfa->base == CFI_SP &&
-			    regs[CFI_BP].base == CFI_CFA &&
-			    regs[CFI_BP].offset == -cfa->offset) {
+			    check_reg_frame_pos(&regs[CFI_BP], -cfa->offset)) {
 
 				/* mov %rsp, %rbp */
 				cfa->base = op->dest.reg;
