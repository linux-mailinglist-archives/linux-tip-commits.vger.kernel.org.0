Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B168B2DC197
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Dec 2020 14:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgLPNuY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Dec 2020 08:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgLPNuX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Dec 2020 08:50:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D8BC061794;
        Wed, 16 Dec 2020 05:49:43 -0800 (PST)
Date:   Wed, 16 Dec 2020 13:49:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608126581;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EW0YRaMbLs8Jge3dol1Eki0ZqMZijwlm5g5V8zo3UPU=;
        b=iRqTK7Y+zWJAXPYW4gTR30W06l7m2e4QteDEvG9PudH6VIBLsUi14GDBfoIrBsFFPXWcsI
        tgsu62Ngqeo1XD68NulF98SJ8Ub2GvVU/F/qLjuAL8pc0oymueJ612hnLRf1PhaK70bewJ
        Z8kbuDDMUHO0scrGKePS3hrr5lzBXIzjFjQpyIIy2VgEuQ6JfISbdj1yeWZyvTzqHrB1fS
        7YpaSm70/QwA27fbVuSUnhuHVOzq4KFjIA/SZfakv/82OTgJImHHTbS/Y2F/CvtFlRM9Sk
        3JJ5pQ2uIxbp9o59OF6EIipKOsY1qhR7XP3NB7u52evP13HKBZnFcMbCTdoDKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608126581;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EW0YRaMbLs8Jge3dol1Eki0ZqMZijwlm5g5V8zo3UPU=;
        b=xLMmGCp+auBQ2a1HheEqKpYmylMipVVzfUOrmXfXF//aLAZlPZ/ZQPs0wNgKz/EpifSAxJ
        6083k9khecY/sUBA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix seg fault with Clang non-section symbols
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <ba6b6c0f0dd5acbba66e403955a967d9fdd1726a.1607983452.git.jpoimboe@redhat.com>
References: <ba6b6c0f0dd5acbba66e403955a967d9fdd1726a.1607983452.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <160812658044.3364.4188208281079332844.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     44f6a7c0755d8dd453c70557e11687bb080a6f21
Gitweb:        https://git.kernel.org/tip/44f6a7c0755d8dd453c70557e11687bb080a6f21
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 14 Dec 2020 16:04:20 -06:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Dec 2020 14:35:46 +01:00

objtool: Fix seg fault with Clang non-section symbols

The Clang assembler likes to strip section symbols, which means objtool
can't reference some text code by its section.  This confuses objtool
greatly, causing it to seg fault.

The fix is similar to what was done before, for ORC reloc generation:

  e81e07244325 ("objtool: Support Clang non-section symbols in ORC generation")

Factor out that code into a common helper and use it for static call
reloc generation as well.

Reported-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://github.com/ClangBuiltLinux/linux/issues/1207
Link: https://lkml.kernel.org/r/ba6b6c0f0dd5acbba66e403955a967d9fdd1726a.1607983452.git.jpoimboe@redhat.com
---
 tools/objtool/check.c   | 11 +++++++++--
 tools/objtool/elf.c     | 26 ++++++++++++++++++++++++++
 tools/objtool/elf.h     |  2 ++
 tools/objtool/orc_gen.c | 29 +++++------------------------
 4 files changed, 42 insertions(+), 26 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c6ab445..5f8d3ee 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -467,13 +467,20 @@ static int create_static_call_sections(struct objtool_file *file)
 
 		/* populate reloc for 'addr' */
 		reloc = malloc(sizeof(*reloc));
+
 		if (!reloc) {
 			perror("malloc");
 			return -1;
 		}
 		memset(reloc, 0, sizeof(*reloc));
-		reloc->sym = insn->sec->sym;
-		reloc->addend = insn->offset;
+
+		insn_to_reloc_sym_addend(insn->sec, insn->offset, reloc);
+		if (!reloc->sym) {
+			WARN_FUNC("static call tramp: missing containing symbol",
+				  insn->sec, insn->offset);
+			return -1;
+		}
+
 		reloc->type = R_X86_64_PC32;
 		reloc->offset = idx * sizeof(struct static_call_site);
 		reloc->sec = reloc_sec;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 4e1d746..be89c74 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -262,6 +262,32 @@ struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, uns
 	return find_reloc_by_dest_range(elf, sec, offset, 1);
 }
 
+void insn_to_reloc_sym_addend(struct section *sec, unsigned long offset,
+			      struct reloc *reloc)
+{
+	if (sec->sym) {
+		reloc->sym = sec->sym;
+		reloc->addend = offset;
+		return;
+	}
+
+	/*
+	 * The Clang assembler strips section symbols, so we have to reference
+	 * the function symbol instead:
+	 */
+	reloc->sym = find_symbol_containing(sec, offset);
+	if (!reloc->sym) {
+		/*
+		 * Hack alert.  This happens when we need to reference the NOP
+		 * pad insn immediately after the function.
+		 */
+		reloc->sym = find_symbol_containing(sec, offset - 1);
+	}
+
+	if (reloc->sym)
+		reloc->addend = offset - reloc->sym->offset;
+}
+
 static int read_sections(struct elf *elf)
 {
 	Elf_Scn *s = NULL;
diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index 807f8c6..e6890cc 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -140,6 +140,8 @@ struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, uns
 struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *sec,
 				     unsigned long offset, unsigned int len);
 struct symbol *find_func_containing(struct section *sec, unsigned long offset);
+void insn_to_reloc_sym_addend(struct section *sec, unsigned long offset,
+			      struct reloc *reloc);
 int elf_rebuild_reloc_section(struct elf *elf, struct section *sec);
 
 #define for_each_sec(file, sec)						\
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 235663b..9ce68b3 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -105,30 +105,11 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
 	}
 	memset(reloc, 0, sizeof(*reloc));
 
-	if (insn_sec->sym) {
-		reloc->sym = insn_sec->sym;
-		reloc->addend = insn_off;
-	} else {
-		/*
-		 * The Clang assembler doesn't produce section symbols, so we
-		 * have to reference the function symbol instead:
-		 */
-		reloc->sym = find_symbol_containing(insn_sec, insn_off);
-		if (!reloc->sym) {
-			/*
-			 * Hack alert.  This happens when we need to reference
-			 * the NOP pad insn immediately after the function.
-			 */
-			reloc->sym = find_symbol_containing(insn_sec,
-							   insn_off - 1);
-		}
-		if (!reloc->sym) {
-			WARN("missing symbol for insn at offset 0x%lx\n",
-			     insn_off);
-			return -1;
-		}
-
-		reloc->addend = insn_off - reloc->sym->offset;
+	insn_to_reloc_sym_addend(insn_sec, insn_off, reloc);
+	if (!reloc->sym) {
+		WARN("missing symbol for insn at offset 0x%lx",
+		     insn_off);
+		return -1;
 	}
 
 	reloc->type = R_X86_64_PC32;
