Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130BF43F873
	for <lists+linux-tip-commits@lfdr.de>; Fri, 29 Oct 2021 10:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhJ2IFm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 29 Oct 2021 04:05:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53222 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbhJ2IFg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 29 Oct 2021 04:05:36 -0400
Date:   Fri, 29 Oct 2021 08:03:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635494587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LlFjWEQvoLKqLxfhwCN4mwv9U176RJ432HTYJNfM9pY=;
        b=YhxRMTrJUPz9IAXVcomQdcTVJytIvn+9B/U+I0VzD13+8uN8gEcySCyV9QLQzt3lKK9WEw
        d/pAQ0sxIphF23Y2eu+j8DawzhS5T8v9P7pZidA/Cly6Rc2SmwwcbCs17trGeugRlyuBnK
        ysScyGAEE+guEJaucP6aKd5/H17kctEEc9b9UHJymVQnxqCRoxCfh1j9tsLDpr6xua4B4/
        1uRU6wro7cDZ7GARqmb4/RpjJwcmxY86gBeIzP1wb6uTkIa+h+bf/+vzDdnk39Lh8uyFLh
        FT5fbu8MW0YLOK1GVPd50QJTJ/a2a3Sr45vi6HzTnhZ96Wkqirwh2aIYxQCNJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635494587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LlFjWEQvoLKqLxfhwCN4mwv9U176RJ432HTYJNfM9pY=;
        b=IXXpZS+KBTyUTaWr9YST5I0dL2nzNvwLU99r/UgA8JipoUkfTCBrD3webFb1/NzYIm7Y2H
        gSXLhRfsHitG+xCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Classify symbols
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211026120309.658539311@infradead.org>
References: <20211026120309.658539311@infradead.org>
MIME-Version: 1.0
Message-ID: <163549458641.626.10730287220461856323.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     1739c66eb7bd5f27f1b69a5a26e10e8327d1e136
Gitweb:        https://git.kernel.org/tip/1739c66eb7bd5f27f1b69a5a26e10e8327d1e136
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 26 Oct 2021 14:01:33 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 28 Oct 2021 23:25:24 +02:00

objtool: Classify symbols

In order to avoid calling str*cmp() on symbol names, over and over, do
them all once upfront and store the result.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/r/20211026120309.658539311@infradead.org
---
 tools/objtool/check.c               | 34 ++++++++++++++++++----------
 tools/objtool/include/objtool/elf.h |  7 ++++--
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7c865a1..fdbc6d2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1012,8 +1012,7 @@ static void add_call_dest(struct objtool_file *file, struct instruction *insn,
 	 * so they need a little help, NOP out any KCOV calls from noinstr
 	 * text.
 	 */
-	if (insn->sec->noinstr &&
-	    !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
+	if (insn->sec->noinstr && insn->call_dest->kcov) {
 		if (reloc) {
 			reloc->type = R_NONE;
 			elf_write_reloc(file->elf, reloc);
@@ -1027,7 +1026,7 @@ static void add_call_dest(struct objtool_file *file, struct instruction *insn,
 		insn->type = sibling ? INSN_RETURN : INSN_NOP;
 	}
 
-	if (mcount && !strcmp(insn->call_dest->name, "__fentry__")) {
+	if (mcount && insn->call_dest->fentry) {
 		if (sibling)
 			WARN_FUNC("Tail call to __fentry__ !?!?", insn->sec, insn->offset);
 
@@ -1077,7 +1076,7 @@ static int add_jump_destinations(struct objtool_file *file)
 		} else if (reloc->sym->type == STT_SECTION) {
 			dest_sec = reloc->sym->sec;
 			dest_off = arch_dest_reloc_offset(reloc->addend);
-		} else if (arch_is_retpoline(reloc->sym)) {
+		} else if (reloc->sym->retpoline_thunk) {
 			/*
 			 * Retpoline jumps are really dynamic jumps in
 			 * disguise, so convert them accordingly.
@@ -1218,7 +1217,7 @@ static int add_call_destinations(struct objtool_file *file)
 
 			add_call_dest(file, insn, dest, false);
 
-		} else if (arch_is_retpoline(reloc->sym)) {
+		} else if (reloc->sym->retpoline_thunk) {
 			/*
 			 * Retpoline calls are really dynamic calls in
 			 * disguise, so convert them accordingly.
@@ -1907,17 +1906,28 @@ static int read_intra_function_calls(struct objtool_file *file)
 	return 0;
 }
 
-static int read_static_call_tramps(struct objtool_file *file)
+static int classify_symbols(struct objtool_file *file)
 {
 	struct section *sec;
 	struct symbol *func;
 
 	for_each_sec(file, sec) {
 		list_for_each_entry(func, &sec->symbol_list, list) {
-			if (func->bind == STB_GLOBAL &&
-			    !strncmp(func->name, STATIC_CALL_TRAMP_PREFIX_STR,
+			if (func->bind != STB_GLOBAL)
+				continue;
+
+			if (!strncmp(func->name, STATIC_CALL_TRAMP_PREFIX_STR,
 				     strlen(STATIC_CALL_TRAMP_PREFIX_STR)))
 				func->static_call_tramp = true;
+
+			if (arch_is_retpoline(func))
+				func->retpoline_thunk = true;
+
+			if (!strcmp(func->name, "__fentry__"))
+				func->fentry = true;
+
+			if (!strncmp(func->name, "__sanitizer_cov_", 16))
+				func->kcov = true;
 		}
 	}
 
@@ -1983,7 +1993,7 @@ static int decode_sections(struct objtool_file *file)
 	/*
 	 * Must be before add_{jump_call}_destination.
 	 */
-	ret = read_static_call_tramps(file);
+	ret = classify_symbols(file);
 	if (ret)
 		return ret;
 
@@ -2041,9 +2051,9 @@ static int decode_sections(struct objtool_file *file)
 
 static bool is_fentry_call(struct instruction *insn)
 {
-	if (insn->type == INSN_CALL && insn->call_dest &&
-	    insn->call_dest->type == STT_NOTYPE &&
-	    !strcmp(insn->call_dest->name, "__fentry__"))
+	if (insn->type == INSN_CALL &&
+	    insn->call_dest &&
+	    insn->call_dest->fentry)
 		return true;
 
 	return false;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index c48c106..c2dbf53 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -54,8 +54,11 @@ struct symbol {
 	unsigned long offset;
 	unsigned int len;
 	struct symbol *pfunc, *cfunc, *alias;
-	bool uaccess_safe;
-	bool static_call_tramp;
+	u8 uaccess_safe      : 1;
+	u8 static_call_tramp : 1;
+	u8 retpoline_thunk   : 1;
+	u8 fentry            : 1;
+	u8 kcov              : 1;
 	struct list_head pv_target;
 };
 
