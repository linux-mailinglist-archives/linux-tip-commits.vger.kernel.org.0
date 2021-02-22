Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BBD3214C9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 22 Feb 2021 12:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBVLJ3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 22 Feb 2021 06:09:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44728 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhBVLJ2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 22 Feb 2021 06:09:28 -0500
Date:   Mon, 22 Feb 2021 11:08:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613992124;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vGYk97LA2FGj1bgwAWWW2y9GerV7pLeKiaQaK840PvY=;
        b=4Unh9fHa1SGCHtDHK9blkTGXFku5Wz+qXFxtrL/WNIyBSWZaF/23L4tLis711BEnqIDzJ1
        3pjIUe04c5ahdANl2KAk9oqF4tXyoeolhCFS7dfDvstiZff/CedQnIgeE0lhAZoz2vMoHI
        AjCNoNclj8r/Rsu7Mv+tYE6wLVyPuwG7zwBurfhP7fVojiHXniB/e6RKEWrkBGwrhSke2o
        SksUJZM3629WLYNGKfJgnjSZz9P+LYPsh1EBM3lUV10+OUkYtlQHjVcQHLTYDLYJe/CwO3
        ynAXGtYiuUDOZn0KguwkGNcOPsZUk/jaj45wbOFBjD8z1ZSPqpe3nzK0V8ugIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613992124;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vGYk97LA2FGj1bgwAWWW2y9GerV7pLeKiaQaK840PvY=;
        b=+e3HkqrRMsW8xLp5uiZ0KKnzVLERwB9q9T0G0rmvipRiuDno4BOBW5y8LpO7PGhVjyvt1B
        E4YIDfcuBxMrI6AQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix stack-swizzle for FRAME_POINTER=y
Cc:     kernel test robot <lkp@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YC6UC+rc9KKmQrkd@hirez.programming.kicks-ass.net>
References: <YC6UC+rc9KKmQrkd@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <161399212333.20312.15799180882369631665.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     23e34c5988088b8bb4c55905973ca76114cb33ee
Gitweb:        https://git.kernel.org/tip/23e34c5988088b8bb4c55905973ca76114cb33ee
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 18 Feb 2021 17:14:10 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 22 Feb 2021 12:05:18 +01:00

objtool: Fix stack-swizzle for FRAME_POINTER=y

When objtool encounters the stack-swizzle:

	mov %rsp, (%[tos])
	mov %[tos], %rsp
	...
	pop %rsp

Inside a FRAME_POINTER=y build, things go a little screwy because
clearly we're not adjusting the cfa->base. This then results in the
pop %rsp not being detected as a restore of cfa->base so it will turn
into a regular POP and offset the stack, resulting in:

  kernel/softirq.o: warning: objtool: do_softirq()+0xdb: return with modified stack frame

Therefore, have "mov %[tos], %rsp" act like a PUSH (it sorta is
anyway) to balance the things out. We're not too concerned with the
actual stack_size for frame-pointer builds, since we don't generate
ORC data for them anyway.

Fixes: aafeb14e9da2 ("objtool: Support stack-swizzle")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/YC6UC+rc9KKmQrkd@hirez.programming.kicks-ass.net
---
 tools/objtool/check.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 62cd211..d7f1496 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1983,6 +1983,20 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 				}
 			}
 
+			else if (op->dest.reg == CFI_SP &&
+				 cfi->vals[op->src.reg].base == CFI_SP_INDIRECT &&
+				 cfi->vals[op->src.reg].offset == cfa->offset) {
+
+				/*
+				 * The same stack swizzle case 2) as above. But
+				 * because we can't change cfa->base, case 3)
+				 * will become a regular POP. Pretend we're a
+				 * PUSH so things don't go unbalanced.
+				 */
+				cfi->stack_size += 8;
+			}
+
+
 			break;
 
 		case OP_SRC_ADD:
