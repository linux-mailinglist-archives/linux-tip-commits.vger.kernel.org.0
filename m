Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B81C43F872
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Oct 2021 10:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbhJ2IFl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 29 Oct 2021 04:05:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53178 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbhJ2IFf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 29 Oct 2021 04:05:35 -0400
Date:   Fri, 29 Oct 2021 08:03:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635494586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B0mk4t7kLGFMnXMUioYaWCv1Tl2G1Hw6LdAjl9/zl1g=;
        b=B7a7YFtCqYrTKznSHTrlVgB1pCNqUrs4/lUmyI26EI4DRZUE/mSTlCuTGmqDIB6Rm/Ugom
        /TiD2/pU65yD0hlsxSwpTJEABbh0hJkG14I7p6rCjavf5bzDoFH/ANsX/d6kQlhtw6Xvcn
        hIqnaAKFiFDWs/B3m9Sl2UOIm+GtNHd0pKn+xOtuXimPbkNQf2QAMsz6sese7vAzzNWQ/a
        m3tvkkn16Nr1WHMKu0rhN0iip4Jbu0JmBRJtBdzhcUbqy8x6Ufi+tfGhYU3F3VTQjuDjUT
        RHMfwuY3tA5GrLIZgKVaQhupfduVEZX6MMAWiXunnsdndK9m/dSKV4KNTKhQqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635494586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B0mk4t7kLGFMnXMUioYaWCv1Tl2G1Hw6LdAjl9/zl1g=;
        b=nXsbBpI5zB3k9CEwXwkY4hPBzBfQw91O6g1Pc4lIALF6nhMFY/R/ADEAI7DraIjG4o12zJ
        BY3rS8UMXqYJXHAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Explicitly avoid self modifying code in
 .altinstr_replacement
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211026120309.722511775@infradead.org>
References: <20211026120309.722511775@infradead.org>
MIME-Version: 1.0
Message-ID: <163549458568.626.4324307714953042463.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     dd003edeffa3cb87bc9862582004f405d77d7670
Gitweb:        https://git.kernel.org/tip/dd003edeffa3cb87bc9862582004f405d77d7670
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 26 Oct 2021 14:01:34 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 28 Oct 2021 23:25:25 +02:00

objtool: Explicitly avoid self modifying code in .altinstr_replacement

Assume ALTERNATIVE()s know what they're doing and do not change, or
cause to change, instructions in .altinstr_replacement sections.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/r/20211026120309.722511775@infradead.org
---
 tools/objtool/check.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index fdbc6d2..8ab6f24 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -993,18 +993,27 @@ static void remove_insn_ops(struct instruction *insn)
 	}
 }
 
-static void add_call_dest(struct objtool_file *file, struct instruction *insn,
-			  struct symbol *dest, bool sibling)
+static void annotate_call_site(struct objtool_file *file,
+			       struct instruction *insn, bool sibling)
 {
 	struct reloc *reloc = insn_reloc(file, insn);
+	struct symbol *sym = insn->call_dest;
 
-	insn->call_dest = dest;
-	if (!dest)
+	if (!sym)
+		sym = reloc->sym;
+
+	/*
+	 * Alternative replacement code is just template code which is
+	 * sometimes copied to the original instruction. For now, don't
+	 * annotate it. (In the future we might consider annotating the
+	 * original instruction if/when it ever makes sense to do so.)
+	 */
+	if (!strcmp(insn->sec->name, ".altinstr_replacement"))
 		return;
 
-	if (insn->call_dest->static_call_tramp) {
-		list_add_tail(&insn->call_node,
-			      &file->static_call_list);
+	if (sym->static_call_tramp) {
+		list_add_tail(&insn->call_node, &file->static_call_list);
+		return;
 	}
 
 	/*
@@ -1012,7 +1021,7 @@ static void add_call_dest(struct objtool_file *file, struct instruction *insn,
 	 * so they need a little help, NOP out any KCOV calls from noinstr
 	 * text.
 	 */
-	if (insn->sec->noinstr && insn->call_dest->kcov) {
+	if (insn->sec->noinstr && sym->kcov) {
 		if (reloc) {
 			reloc->type = R_NONE;
 			elf_write_reloc(file->elf, reloc);
@@ -1024,9 +1033,10 @@ static void add_call_dest(struct objtool_file *file, struct instruction *insn,
 			               : arch_nop_insn(insn->len));
 
 		insn->type = sibling ? INSN_RETURN : INSN_NOP;
+		return;
 	}
 
-	if (mcount && insn->call_dest->fentry) {
+	if (mcount && sym->fentry) {
 		if (sibling)
 			WARN_FUNC("Tail call to __fentry__ !?!?", insn->sec, insn->offset);
 
@@ -1041,9 +1051,17 @@ static void add_call_dest(struct objtool_file *file, struct instruction *insn,
 
 		insn->type = INSN_NOP;
 
-		list_add_tail(&insn->mcount_loc_node,
-			      &file->mcount_loc_list);
+		list_add_tail(&insn->mcount_loc_node, &file->mcount_loc_list);
+		return;
 	}
+}
+
+static void add_call_dest(struct objtool_file *file, struct instruction *insn,
+			  struct symbol *dest, bool sibling)
+{
+	insn->call_dest = dest;
+	if (!dest)
+		return;
 
 	/*
 	 * Whatever stack impact regular CALLs have, should be undone
@@ -1053,6 +1071,8 @@ static void add_call_dest(struct objtool_file *file, struct instruction *insn,
 	 * are converted to JUMP, see read_intra_function_calls().
 	 */
 	remove_insn_ops(insn);
+
+	annotate_call_site(file, insn, sibling);
 }
 
 /*
