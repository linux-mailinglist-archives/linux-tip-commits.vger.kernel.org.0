Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733831B5048
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Apr 2020 00:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgDVWZu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Apr 2020 18:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726730AbgDVWZH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Apr 2020 18:25:07 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372C6C03C1A9;
        Wed, 22 Apr 2020 15:25:07 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jRNnN-0001Oh-FN; Thu, 23 Apr 2020 00:24:42 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3E92B1C04D7;
        Thu, 23 Apr 2020 00:24:39 +0200 (CEST)
Date:   Wed, 22 Apr 2020 22:24:38 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Introduce HINT_RET_OFFSET
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200416115118.690601403@infradead.org>
References: <20200416115118.690601403@infradead.org>
MIME-Version: 1.0
Message-ID: <158759427864.28353.8226580518920056560.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     9949d38e5ee16c7ff20247b6b36cc3538c84195d
Gitweb:        https://git.kernel.org/tip/9949d38e5ee16c7ff20247b6b36cc3538c84195d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 01 Apr 2020 16:38:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 22 Apr 2020 23:10:05 +02:00

objtool: Introduce HINT_RET_OFFSET

Normally objtool ensures a function keeps the stack layout invariant.
But there is a useful exception, it is possible to stuff the return
stack in order to 'inject' a 'call':

	push $fun
	ret

In this case the invariant mentioned above is violated.

Add an objtool HINT to annotate this and allow a function exit with a
modified stack frame.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20200416115118.690601403@infradead.org
---
 arch/x86/include/asm/orc_types.h       |  1 +
 arch/x86/include/asm/unwind_hints.h    | 10 ++++++++++
 tools/arch/x86/include/asm/orc_types.h |  1 +
 tools/objtool/check.c                  | 24 ++++++++++++++++--------
 tools/objtool/check.h                  |  4 +++-
 5 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/orc_types.h b/arch/x86/include/asm/orc_types.h
index 6e06090..5f18ca7 100644
--- a/arch/x86/include/asm/orc_types.h
+++ b/arch/x86/include/asm/orc_types.h
@@ -60,6 +60,7 @@
 #define ORC_TYPE_REGS_IRET		2
 #define UNWIND_HINT_TYPE_SAVE		3
 #define UNWIND_HINT_TYPE_RESTORE	4
+#define UNWIND_HINT_TYPE_RET_OFFSET	5
 
 #ifndef __ASSEMBLY__
 /*
diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
index f5e2eb1..aabf7ac 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -94,6 +94,16 @@
 	UNWIND_HINT type=UNWIND_HINT_TYPE_RESTORE
 .endm
 
+
+/*
+ * RET_OFFSET: Used on instructions that terminate a function; mostly RETURN
+ * and sibling calls. On these, sp_offset denotes the expected offset from
+ * initial_func_cfi.
+ */
+.macro UNWIND_HINT_RET_OFFSET sp_offset=8
+	UNWIND_HINT type=UNWIND_HINT_TYPE_RET_OFFSET sp_offset=\sp_offset
+.endm
+
 #else /* !__ASSEMBLY__ */
 
 #define UNWIND_HINT(sp_reg, sp_offset, type, end)		\
diff --git a/tools/arch/x86/include/asm/orc_types.h b/tools/arch/x86/include/asm/orc_types.h
index 6e06090..5f18ca7 100644
--- a/tools/arch/x86/include/asm/orc_types.h
+++ b/tools/arch/x86/include/asm/orc_types.h
@@ -60,6 +60,7 @@
 #define ORC_TYPE_REGS_IRET		2
 #define UNWIND_HINT_TYPE_SAVE		3
 #define UNWIND_HINT_TYPE_RESTORE	4
+#define UNWIND_HINT_TYPE_RET_OFFSET	5
 
 #ifndef __ASSEMBLY__
 /*
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 72bf5cc..fe6ae45 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1277,6 +1277,9 @@ static int read_unwind_hints(struct objtool_file *file)
 		} else if (hint->type == UNWIND_HINT_TYPE_RESTORE) {
 			insn->restore = true;
 			insn->hint = true;
+
+		} else if (hint->type == UNWIND_HINT_TYPE_RET_OFFSET) {
+			insn->ret_offset = hint->sp_offset;
 			continue;
 		}
 
@@ -1440,20 +1443,25 @@ static bool is_fentry_call(struct instruction *insn)
 	return false;
 }
 
-static bool has_modified_stack_frame(struct insn_state *state)
+static bool has_modified_stack_frame(struct instruction *insn, struct insn_state *state)
 {
+	u8 ret_offset = insn->ret_offset;
 	int i;
 
-	if (state->cfa.base != initial_func_cfi.cfa.base ||
-	    state->cfa.offset != initial_func_cfi.cfa.offset ||
-	    state->stack_size != initial_func_cfi.cfa.offset ||
-	    state->drap)
+	if (state->cfa.base != initial_func_cfi.cfa.base || state->drap)
+		return true;
+
+	if (state->cfa.offset != initial_func_cfi.cfa.offset + ret_offset)
 		return true;
 
-	for (i = 0; i < CFI_NUM_REGS; i++)
+	if (state->stack_size != initial_func_cfi.cfa.offset + ret_offset)
+		return true;
+
+	for (i = 0; i < CFI_NUM_REGS; i++) {
 		if (state->regs[i].base != initial_func_cfi.regs[i].base ||
 		    state->regs[i].offset != initial_func_cfi.regs[i].offset)
 			return true;
+	}
 
 	return false;
 }
@@ -2030,7 +2038,7 @@ static int validate_call(struct instruction *insn, struct insn_state *state)
 
 static int validate_sibling_call(struct instruction *insn, struct insn_state *state)
 {
-	if (has_modified_stack_frame(state)) {
+	if (has_modified_stack_frame(insn, state)) {
 		WARN_FUNC("sibling call from callable instruction with modified stack frame",
 				insn->sec, insn->offset);
 		return 1;
@@ -2059,7 +2067,7 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
 		return 1;
 	}
 
-	if (func && has_modified_stack_frame(state)) {
+	if (func && has_modified_stack_frame(insn, state)) {
 		WARN_FUNC("return with modified stack frame",
 			  insn->sec, insn->offset);
 		return 1;
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 2c55f75..81ce27e 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -33,9 +33,11 @@ struct instruction {
 	unsigned int len;
 	enum insn_type type;
 	unsigned long immediate;
-	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
+	bool alt_group, dead_end, ignore, ignore_alts;
+	bool hint, save, restore;
 	bool retpoline_safe;
 	u8 visited;
+	u8 ret_offset;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
 	struct instruction *first_jump_src;
