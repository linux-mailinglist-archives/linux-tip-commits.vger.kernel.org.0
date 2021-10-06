Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533D2424A08
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Oct 2021 00:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhJFWsO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 6 Oct 2021 18:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbhJFWsN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 6 Oct 2021 18:48:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78261C061746;
        Wed,  6 Oct 2021 15:46:20 -0700 (PDT)
Date:   Wed, 06 Oct 2021 22:46:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633560378;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AcEXAwh7h7U+fWXseWcpTqRd+d9Gb4gkSlwyljLz9fY=;
        b=f9ajcfEKWRojQp5ab68pLOmWbzvSkMozSWyCxQc4hnX5CRGtu+GFQQsskLqzeZ0lzGlBpb
        Xbdyn9Qh27hkb1JBSohUSpgSVdBIeGnSIhs1nS093w1fmDpq+KcK2WYtTzqDxw1bXyHFYP
        0Q4PbEo1ESoE030K36S7XclBNlE6H878kW73dOeBJ8GzXKRiOqPFQA2HqQuq5ZUZCMFf4q
        zsRAN1YJXnoe8CsO0uNExgYiFdhZ5edBZDU8a2H2tuAdR+wp43qfESduLBjCLjTUQOlrGT
        gosiXCqPqTmMDyyO3Jv/qe/469TB41/Qi49s2N+mIeqswseS8/obwZ2I7xsbOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633560378;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AcEXAwh7h7U+fWXseWcpTqRd+d9Gb4gkSlwyljLz9fY=;
        b=BtolFjLkHUjt23wegE4imeP+9JEJqX+kF2Oh9YjP+w4HDxXP0OTJyZJZRPTf1/j9qJmsfl
        6JpOHuIKDNxOs+Bw==
From:   "tip-bot2 for Joe Lawrence" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Remove redundant 'len' field from struct section
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lavr <andy.lavr@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210822225037.54620-3-joe.lawrence@redhat.com>
References: <20210822225037.54620-3-joe.lawrence@redhat.com>
MIME-Version: 1.0
Message-ID: <163356037673.25758.17818689328872077627.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     fe255fe6ad97685e5a4be0d871f43288dbc10ad6
Gitweb:        https://git.kernel.org/tip/fe255fe6ad97685e5a4be0d871f43288dbc10ad6
Author:        Joe Lawrence <joe.lawrence@redhat.com>
AuthorDate:    Sun, 22 Aug 2021 18:50:37 -04:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Tue, 05 Oct 2021 12:03:21 -07:00

objtool: Remove redundant 'len' field from struct section

The section structure already contains sh_size, so just remove the extra
'len' member that requires extra mirroring and potential confusion.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20210822225037.54620-3-joe.lawrence@redhat.com
Cc: Andy Lavr <andy.lavr@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/objtool/check.c               | 16 ++++++++--------
 tools/objtool/elf.c                 | 14 ++++++--------
 tools/objtool/include/objtool/elf.h |  1 -
 tools/objtool/orc_gen.c             |  2 +-
 tools/objtool/special.c             |  4 ++--
 5 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e5947fb..06b5c16 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -292,7 +292,7 @@ static int decode_instructions(struct objtool_file *file)
 		    !strcmp(sec->name, ".entry.text"))
 			sec->noinstr = true;
 
-		for (offset = 0; offset < sec->len; offset += insn->len) {
+		for (offset = 0; offset < sec->sh.sh_size; offset += insn->len) {
 			insn = malloc(sizeof(*insn));
 			if (!insn) {
 				WARN("malloc failed");
@@ -307,7 +307,7 @@ static int decode_instructions(struct objtool_file *file)
 			insn->offset = offset;
 
 			ret = arch_decode_instruction(file->elf, sec, offset,
-						      sec->len - offset,
+						      sec->sh.sh_size - offset,
 						      &insn->len, &insn->type,
 						      &insn->immediate,
 						      &insn->stack_ops);
@@ -349,9 +349,9 @@ static struct instruction *find_last_insn(struct objtool_file *file,
 {
 	struct instruction *insn = NULL;
 	unsigned int offset;
-	unsigned int end = (sec->len > 10) ? sec->len - 10 : 0;
+	unsigned int end = (sec->sh.sh_size > 10) ? sec->sh.sh_size - 10 : 0;
 
-	for (offset = sec->len - 1; offset >= end && !insn; offset--)
+	for (offset = sec->sh.sh_size - 1; offset >= end && !insn; offset--)
 		insn = find_insn(file, sec, offset);
 
 	return insn;
@@ -389,7 +389,7 @@ static int add_dead_ends(struct objtool_file *file)
 		insn = find_insn(file, reloc->sym->sec, reloc->addend);
 		if (insn)
 			insn = list_prev_entry(insn, list);
-		else if (reloc->addend == reloc->sym->sec->len) {
+		else if (reloc->addend == reloc->sym->sec->sh.sh_size) {
 			insn = find_last_insn(file, reloc->sym->sec);
 			if (!insn) {
 				WARN("can't find unreachable insn at %s+0x%x",
@@ -424,7 +424,7 @@ reachable:
 		insn = find_insn(file, reloc->sym->sec, reloc->addend);
 		if (insn)
 			insn = list_prev_entry(insn, list);
-		else if (reloc->addend == reloc->sym->sec->len) {
+		else if (reloc->addend == reloc->sym->sec->sh.sh_size) {
 			insn = find_last_insn(file, reloc->sym->sec);
 			if (!insn) {
 				WARN("can't find reachable insn at %s+0x%x",
@@ -1561,14 +1561,14 @@ static int read_unwind_hints(struct objtool_file *file)
 		return -1;
 	}
 
-	if (sec->len % sizeof(struct unwind_hint)) {
+	if (sec->sh.sh_size % sizeof(struct unwind_hint)) {
 		WARN("struct unwind_hint size mismatch");
 		return -1;
 	}
 
 	file->hints = true;
 
-	for (i = 0; i < sec->len / sizeof(struct unwind_hint); i++) {
+	for (i = 0; i < sec->sh.sh_size / sizeof(struct unwind_hint); i++) {
 		hint = (struct unwind_hint *)sec->data->d_buf + i;
 
 		reloc = find_reloc_by_dest(file->elf, sec, i * sizeof(*hint));
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 8676c75..b18f005 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -286,10 +286,9 @@ static int read_sections(struct elf *elf)
 				return -1;
 			}
 		}
-		sec->len = sec->sh.sh_size;
 
 		if (sec->sh.sh_flags & SHF_EXECINSTR)
-			elf->text_size += sec->len;
+			elf->text_size += sec->sh.sh_size;
 
 		list_add_tail(&sec->list, &elf->sections);
 		elf_hash_add(section, &sec->hash, sec->idx);
@@ -734,8 +733,8 @@ static int elf_add_string(struct elf *elf, struct section *strtab, char *str)
 	data->d_size = strlen(str) + 1;
 	data->d_align = 1;
 
-	len = strtab->len;
-	strtab->len += data->d_size;
+	len = strtab->sh.sh_size;
+	strtab->sh.sh_size += data->d_size;
 	strtab->changed = true;
 
 	return len;
@@ -790,9 +789,9 @@ struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
 	data->d_align = 1;
 	data->d_type = ELF_T_SYM;
 
-	sym->idx = symtab->len / sizeof(sym->sym);
+	sym->idx = symtab->sh.sh_size / sizeof(sym->sym);
 
-	symtab->len += data->d_size;
+	symtab->sh.sh_size += data->d_size;
 	symtab->changed = true;
 
 	symtab_shndx = find_section_by_name(elf, ".symtab_shndx");
@@ -814,7 +813,7 @@ struct symbol *elf_create_undef_symbol(struct elf *elf, const char *name)
 		data->d_align = 4;
 		data->d_type = ELF_T_WORD;
 
-		symtab_shndx->len += 4;
+		symtab_shndx->sh.sh_size += 4;
 		symtab_shndx->changed = true;
 	}
 
@@ -855,7 +854,6 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	}
 
 	sec->idx = elf_ndxscn(s);
-	sec->len = size;
 	sec->changed = true;
 
 	sec->data = elf_newdata(s);
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index e343950..075d829 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -38,7 +38,6 @@ struct section {
 	Elf_Data *data;
 	char *name;
 	int idx;
-	unsigned int len;
 	bool changed, text, rodata, noinstr;
 };
 
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index dc9b7dd..b5865e2 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -204,7 +204,7 @@ int orc_create(struct objtool_file *file)
 
 		/* Add a section terminator */
 		if (!empty) {
-			orc_list_add(&orc_list, &null, sec, sec->len);
+			orc_list_add(&orc_list, &null, sec, sec->sh.sh_size);
 			nr++;
 		}
 	}
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 83d5f96..06c3eac 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -159,13 +159,13 @@ int special_get_alts(struct elf *elf, struct list_head *alts)
 		if (!sec)
 			continue;
 
-		if (sec->len % entry->size != 0) {
+		if (sec->sh.sh_size % entry->size != 0) {
 			WARN("%s size not a multiple of %d",
 			     sec->name, entry->size);
 			return -1;
 		}
 
-		nr_entries = sec->len / entry->size;
+		nr_entries = sec->sh.sh_size / entry->size;
 
 		for (idx = 0; idx < nr_entries; idx++) {
 			alt = malloc(sizeof(*alt));
