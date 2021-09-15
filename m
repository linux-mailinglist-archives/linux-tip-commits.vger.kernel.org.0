Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181FC40C8D4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Sep 2021 17:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238569AbhIOPvU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 15 Sep 2021 11:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbhIOPvG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 15 Sep 2021 11:51:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9290DC0613E9;
        Wed, 15 Sep 2021 08:49:35 -0700 (PDT)
Date:   Wed, 15 Sep 2021 15:49:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631720974;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PCVj3LXTmoIl+XQL22tb0iYQ/LHjq0PyhAZ79oPez3c=;
        b=SZRlmFvP/ySb8xaesdRShpO0PqVCyL+wYWk5c0FSuE1rBePXVeJyhxQc+7NJuz11xty4y5
        SpMzOmP5yYtW72pLMbG9409ux+XZCxwHpKzEivLvGu7MsDyzN9IJN6rZ/LhWZW3dpPdMtN
        iAp3C00D8AxAyDizSmUb/z4QAlz7DNFL0v+D3yu9HEoz0D0D6MRiDtPNaPAlY4RQAgB4JI
        DKeJCDn4jS3skxsfjqUqHBYLmFKmiaBxC/qQFXers1aFrt3rwtGmAFcQ7TY2wQXqBRVmR5
        xEI5g2gC8+SRoDMO3+BszddQceGJ1A6ko6jLe319F19MoOL0qABEq9eRM5teXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631720974;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PCVj3LXTmoIl+XQL22tb0iYQ/LHjq0PyhAZ79oPez3c=;
        b=ncvuDuFRwR9hFAfp4zYBHhmWRhxFSB74d/b3G4uTXPW35nuitGR70+QbbY15LFZcEDypVt
        MkqMyJEM/TQ6BmDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Handle __sanitize_cov*() tail calls
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095147.818783799@infradead.org>
References: <20210624095147.818783799@infradead.org>
MIME-Version: 1.0
Message-ID: <163172097340.25758.8600822594261063532.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     f56dae88a81fded66adf2bea9922d1d98d1da14f
Gitweb:        https://git.kernel.org/tip/f56dae88a81fded66adf2bea9922d1d98d1da14f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:02 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 15:51:45 +02:00

objtool: Handle __sanitize_cov*() tail calls

Turns out the compilers also generate tail calls to __sanitize_cov*(),
make sure to also patch those out in noinstr code.

Fixes: 0f1441b44e82 ("objtool: Fix noinstr vs KCOV")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/r/20210624095147.818783799@infradead.org
---
 tools/objtool/arch/x86/decode.c      |  20 +++-
 tools/objtool/check.c                | 158 +++++++++++++-------------
 tools/objtool/include/objtool/arch.h |   1 +-
 3 files changed, 105 insertions(+), 74 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 3435a32..340a3dc 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -659,6 +659,26 @@ const char *arch_nop_insn(int len)
 	return nops[len-1];
 }
 
+#define BYTE_RET	0xC3
+
+const char *arch_ret_insn(int len)
+{
+	static const char ret[5][5] = {
+		{ BYTE_RET },
+		{ BYTE_RET, BYTES_NOP1 },
+		{ BYTE_RET, BYTES_NOP2 },
+		{ BYTE_RET, BYTES_NOP3 },
+		{ BYTE_RET, BYTES_NOP4 },
+	};
+
+	if (len < 1 || len > 5) {
+		WARN("invalid RET size: %d\n", len);
+		return NULL;
+	}
+
+	return ret[len-1];
+}
+
 /* asm/alternative.h ? */
 
 #define ALTINSTR_FLAG_INV	(1 << 15)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d9f3273..c6f206f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -904,6 +904,79 @@ static struct reloc *insn_reloc(struct objtool_file *file, struct instruction *i
 	return insn->reloc;
 }
 
+static void remove_insn_ops(struct instruction *insn)
+{
+	struct stack_op *op, *tmp;
+
+	list_for_each_entry_safe(op, tmp, &insn->stack_ops, list) {
+		list_del(&op->list);
+		free(op);
+	}
+}
+
+static void add_call_dest(struct objtool_file *file, struct instruction *insn,
+			  struct symbol *dest, bool sibling)
+{
+	struct reloc *reloc = insn_reloc(file, insn);
+
+	insn->call_dest = dest;
+	if (!dest)
+		return;
+
+	if (insn->call_dest->static_call_tramp) {
+		list_add_tail(&insn->call_node,
+			      &file->static_call_list);
+	}
+
+	/*
+	 * Many compilers cannot disable KCOV with a function attribute
+	 * so they need a little help, NOP out any KCOV calls from noinstr
+	 * text.
+	 */
+	if (insn->sec->noinstr &&
+	    !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
+		if (reloc) {
+			reloc->type = R_NONE;
+			elf_write_reloc(file->elf, reloc);
+		}
+
+		elf_write_insn(file->elf, insn->sec,
+			       insn->offset, insn->len,
+			       sibling ? arch_ret_insn(insn->len)
+			               : arch_nop_insn(insn->len));
+
+		insn->type = sibling ? INSN_RETURN : INSN_NOP;
+	}
+
+	if (mcount && !strcmp(insn->call_dest->name, "__fentry__")) {
+		if (sibling)
+			WARN_FUNC("Tail call to __fentry__ !?!?", insn->sec, insn->offset);
+
+		if (reloc) {
+			reloc->type = R_NONE;
+			elf_write_reloc(file->elf, reloc);
+		}
+
+		elf_write_insn(file->elf, insn->sec,
+			       insn->offset, insn->len,
+			       arch_nop_insn(insn->len));
+
+		insn->type = INSN_NOP;
+
+		list_add_tail(&insn->mcount_loc_node,
+			      &file->mcount_loc_list);
+	}
+
+	/*
+	 * Whatever stack impact regular CALLs have, should be undone
+	 * by the RETURN of the called function.
+	 *
+	 * Annotated intra-function calls retain the stack_ops but
+	 * are converted to JUMP, see read_intra_function_calls().
+	 */
+	remove_insn_ops(insn);
+}
+
 /*
  * Find the destination instructions for all jumps.
  */
@@ -942,11 +1015,7 @@ static int add_jump_destinations(struct objtool_file *file)
 			continue;
 		} else if (insn->func) {
 			/* internal or external sibling call (with reloc) */
-			insn->call_dest = reloc->sym;
-			if (insn->call_dest->static_call_tramp) {
-				list_add_tail(&insn->call_node,
-					      &file->static_call_list);
-			}
+			add_call_dest(file, insn, reloc->sym, true);
 			continue;
 		} else if (reloc->sym->sec->idx) {
 			dest_sec = reloc->sym->sec;
@@ -1002,13 +1071,8 @@ static int add_jump_destinations(struct objtool_file *file)
 
 			} else if (insn->jump_dest->func->pfunc != insn->func->pfunc &&
 				   insn->jump_dest->offset == insn->jump_dest->func->offset) {
-
 				/* internal sibling call (without reloc) */
-				insn->call_dest = insn->jump_dest->func;
-				if (insn->call_dest->static_call_tramp) {
-					list_add_tail(&insn->call_node,
-						      &file->static_call_list);
-				}
+				add_call_dest(file, insn, insn->jump_dest->func, true);
 			}
 		}
 	}
@@ -1016,16 +1080,6 @@ static int add_jump_destinations(struct objtool_file *file)
 	return 0;
 }
 
-static void remove_insn_ops(struct instruction *insn)
-{
-	struct stack_op *op, *tmp;
-
-	list_for_each_entry_safe(op, tmp, &insn->stack_ops, list) {
-		list_del(&op->list);
-		free(op);
-	}
-}
-
 static struct symbol *find_call_destination(struct section *sec, unsigned long offset)
 {
 	struct symbol *call_dest;
@@ -1044,6 +1098,7 @@ static int add_call_destinations(struct objtool_file *file)
 {
 	struct instruction *insn;
 	unsigned long dest_off;
+	struct symbol *dest;
 	struct reloc *reloc;
 
 	for_each_insn(file, insn) {
@@ -1053,7 +1108,9 @@ static int add_call_destinations(struct objtool_file *file)
 		reloc = insn_reloc(file, insn);
 		if (!reloc) {
 			dest_off = arch_jump_destination(insn);
-			insn->call_dest = find_call_destination(insn->sec, dest_off);
+			dest = find_call_destination(insn->sec, dest_off);
+
+			add_call_dest(file, insn, dest, false);
 
 			if (insn->ignore)
 				continue;
@@ -1071,9 +1128,8 @@ static int add_call_destinations(struct objtool_file *file)
 
 		} else if (reloc->sym->type == STT_SECTION) {
 			dest_off = arch_dest_reloc_offset(reloc->addend);
-			insn->call_dest = find_call_destination(reloc->sym->sec,
-								dest_off);
-			if (!insn->call_dest) {
+			dest = find_call_destination(reloc->sym->sec, dest_off);
+			if (!dest) {
 				WARN_FUNC("can't find call dest symbol at %s+0x%lx",
 					  insn->sec, insn->offset,
 					  reloc->sym->sec->name,
@@ -1081,6 +1137,8 @@ static int add_call_destinations(struct objtool_file *file)
 				return -1;
 			}
 
+			add_call_dest(file, insn, dest, false);
+
 		} else if (arch_is_retpoline(reloc->sym)) {
 			/*
 			 * Retpoline calls are really dynamic calls in
@@ -1096,55 +1154,7 @@ static int add_call_destinations(struct objtool_file *file)
 			continue;
 
 		} else
-			insn->call_dest = reloc->sym;
-
-		if (insn->call_dest && insn->call_dest->static_call_tramp) {
-			list_add_tail(&insn->call_node,
-				      &file->static_call_list);
-		}
-
-		/*
-		 * Many compilers cannot disable KCOV with a function attribute
-		 * so they need a little help, NOP out any KCOV calls from noinstr
-		 * text.
-		 */
-		if (insn->sec->noinstr &&
-		    !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
-			if (reloc) {
-				reloc->type = R_NONE;
-				elf_write_reloc(file->elf, reloc);
-			}
-
-			elf_write_insn(file->elf, insn->sec,
-				       insn->offset, insn->len,
-				       arch_nop_insn(insn->len));
-			insn->type = INSN_NOP;
-		}
-
-		if (mcount && !strcmp(insn->call_dest->name, "__fentry__")) {
-			if (reloc) {
-				reloc->type = R_NONE;
-				elf_write_reloc(file->elf, reloc);
-			}
-
-			elf_write_insn(file->elf, insn->sec,
-				       insn->offset, insn->len,
-				       arch_nop_insn(insn->len));
-
-			insn->type = INSN_NOP;
-
-			list_add_tail(&insn->mcount_loc_node,
-				      &file->mcount_loc_list);
-		}
-
-		/*
-		 * Whatever stack impact regular CALLs have, should be undone
-		 * by the RETURN of the called function.
-		 *
-		 * Annotated intra-function calls retain the stack_ops but
-		 * are converted to JUMP, see read_intra_function_calls().
-		 */
-		remove_insn_ops(insn);
+			add_call_dest(file, insn, reloc->sym, false);
 	}
 
 	return 0;
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index a5ab682..6f482ae 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -82,6 +82,7 @@ unsigned long arch_jump_destination(struct instruction *insn);
 unsigned long arch_dest_reloc_offset(int addend);
 
 const char *arch_nop_insn(int len);
+const char *arch_ret_insn(int len);
 
 int arch_decode_hint_reg(u8 sp_reg, int *base);
 
