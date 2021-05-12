Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47A637BE0A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 15:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhELNVF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 09:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbhELNVD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 09:21:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C37AC061574;
        Wed, 12 May 2021 06:19:55 -0700 (PDT)
Date:   Wed, 12 May 2021 13:19:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620825593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pJb/Aiv+JPDoaAjfn86+lvXld4C4+usYpUeCANLhSjU=;
        b=lEBY6fvWFy6w6yRr/NkcJmZI2GW8bBosVV8QhkdpjuRmOVKJLU7/888arIN3l5ZMwbjpYP
        Ab2ImVzDgf1SS0qIlN0YwzDSJ4p7pT8HdKm/PaelHC0yg3RFy2oztUJOdoUUXIe3f+AP8i
        x4qZdpWmW61yPN3pnGJVdTr5r585OK9PtGHIBSa930JCalAQ3ksGkmY/nFikZiCTWN7nso
        XIYCzJL/ZGxB0u+lnUseO2GofKm1Ah6jmLKicu8iMFDFaFVXLZccDf3kFNsaSdOCTADVIr
        HeNCV2SA2YQmVB6On6QLQv8UVo4D5K25JmGsZf3pj5tqvox86+1AFMpQ/RnaUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620825593;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pJb/Aiv+JPDoaAjfn86+lvXld4C4+usYpUeCANLhSjU=;
        b=LMMR/GmeDgEePHk+6FdeG99aBQV3qFv1azs5PSCjeMs+YPVChdo74ZvC0sqkMftG+tsiNH
        gpJfXRdSKpBHxyBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Rewrite hashtable sizing
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210506194157.452881700@infradead.org>
References: <20210506194157.452881700@infradead.org>
MIME-Version: 1.0
Message-ID: <162082559315.29796.8050398722943410727.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     25cf0d8aa2a3440ed32bf1f8df1310d6baf3f1e8
Gitweb:        https://git.kernel.org/tip/25cf0d8aa2a3440ed32bf1f8df1310d6baf3f1e8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 06 May 2021 21:33:53 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 14:54:50 +02:00

objtool: Rewrite hashtable sizing

Currently objtool has 5 hashtables and sizes them 16 or 20 bits
depending on the --vmlinux argument.

However, a single side doesn't really work well for the 5 tables,
which among them, cover 3 different uses. Also, while vmlinux is
larger, there is still a very wide difference between a defconfig and
allyesconfig build, which again isn't optimally covered by a single
size.

Another aspect is the cost of elf_hash_init(), which for large tables
dominates the runtime for small input files. It turns out that all it
does it assign NULL, something that is required when using malloc().
However, when we allocate memory using mmap(), we're guaranteed to get
zero filled pages.

Therefore, rewrite the whole thing to:

 1) use more dynamic sized tables, depending on the input file,
 2) avoid the need for elf_hash_init() entirely by using mmap().

This speeds up a regular kernel build (100s to 98s for
x86_64-defconfig), and potentially dramatically speeds up vmlinux
processing.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210506194157.452881700@infradead.org
---
 tools/objtool/elf.c                 | 113 ++++++++++++++++-----------
 tools/objtool/include/objtool/elf.h |  17 ++--
 2 files changed, 83 insertions(+), 47 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index d08f5f3..a8a0ee2 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -9,6 +9,7 @@
 
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/mman.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -27,21 +28,27 @@ static inline u32 str_hash(const char *str)
 	return jhash(str, strlen(str), 0);
 }
 
-static inline int elf_hash_bits(void)
-{
-	return vmlinux ? ELF_HASH_BITS : 16;
-}
+#define __elf_table(name)	(elf->name##_hash)
+#define __elf_bits(name)	(elf->name##_bits)
 
-#define elf_hash_add(hashtable, node, key) \
-	hlist_add_head(node, &hashtable[hash_min(key, elf_hash_bits())])
+#define elf_hash_add(name, node, key) \
+	hlist_add_head(node, &__elf_table(name)[hash_min(key, __elf_bits(name))])
 
-static void elf_hash_init(struct hlist_head *table)
-{
-	__hash_init(table, 1U << elf_hash_bits());
-}
+#define elf_hash_for_each_possible(name, obj, member, key) \
+	hlist_for_each_entry(obj, &__elf_table(name)[hash_min(key, __elf_bits(name))], member)
 
-#define elf_hash_for_each_possible(name, obj, member, key)			\
-	hlist_for_each_entry(obj, &name[hash_min(key, elf_hash_bits())], member)
+#define elf_alloc_hash(name, size) \
+({ \
+	__elf_bits(name) = max(10, ilog2(size)); \
+	__elf_table(name) = mmap(NULL, sizeof(struct hlist_head) << __elf_bits(name), \
+				 PROT_READ|PROT_WRITE, \
+				 MAP_PRIVATE|MAP_ANON, -1, 0); \
+	if (__elf_table(name) == (void *)-1L) { \
+		WARN("mmap fail " #name); \
+		__elf_table(name) = NULL; \
+	} \
+	__elf_table(name); \
+})
 
 static bool symbol_to_offset(struct rb_node *a, const struct rb_node *b)
 {
@@ -80,9 +87,10 @@ struct section *find_section_by_name(const struct elf *elf, const char *name)
 {
 	struct section *sec;
 
-	elf_hash_for_each_possible(elf->section_name_hash, sec, name_hash, str_hash(name))
+	elf_hash_for_each_possible(section_name, sec, name_hash, str_hash(name)) {
 		if (!strcmp(sec->name, name))
 			return sec;
+	}
 
 	return NULL;
 }
@@ -92,9 +100,10 @@ static struct section *find_section_by_index(struct elf *elf,
 {
 	struct section *sec;
 
-	elf_hash_for_each_possible(elf->section_hash, sec, hash, idx)
+	elf_hash_for_each_possible(section, sec, hash, idx) {
 		if (sec->idx == idx)
 			return sec;
+	}
 
 	return NULL;
 }
@@ -103,9 +112,10 @@ static struct symbol *find_symbol_by_index(struct elf *elf, unsigned int idx)
 {
 	struct symbol *sym;
 
-	elf_hash_for_each_possible(elf->symbol_hash, sym, hash, idx)
+	elf_hash_for_each_possible(symbol, sym, hash, idx) {
 		if (sym->idx == idx)
 			return sym;
+	}
 
 	return NULL;
 }
@@ -170,9 +180,10 @@ struct symbol *find_symbol_by_name(const struct elf *elf, const char *name)
 {
 	struct symbol *sym;
 
-	elf_hash_for_each_possible(elf->symbol_name_hash, sym, name_hash, str_hash(name))
+	elf_hash_for_each_possible(symbol_name, sym, name_hash, str_hash(name)) {
 		if (!strcmp(sym->name, name))
 			return sym;
+	}
 
 	return NULL;
 }
@@ -189,8 +200,8 @@ struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *se
 	sec = sec->reloc;
 
 	for_offset_range(o, offset, offset + len) {
-		elf_hash_for_each_possible(elf->reloc_hash, reloc, hash,
-				       sec_offset_hash(sec, o)) {
+		elf_hash_for_each_possible(reloc, reloc, hash,
+					   sec_offset_hash(sec, o)) {
 			if (reloc->sec != sec)
 				continue;
 
@@ -228,6 +239,10 @@ static int read_sections(struct elf *elf)
 		return -1;
 	}
 
+	if (!elf_alloc_hash(section, sections_nr) ||
+	    !elf_alloc_hash(section_name, sections_nr))
+		return -1;
+
 	for (i = 0; i < sections_nr; i++) {
 		sec = malloc(sizeof(*sec));
 		if (!sec) {
@@ -274,12 +289,14 @@ static int read_sections(struct elf *elf)
 		sec->len = sec->sh.sh_size;
 
 		list_add_tail(&sec->list, &elf->sections);
-		elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
-		elf_hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
+		elf_hash_add(section, &sec->hash, sec->idx);
+		elf_hash_add(section_name, &sec->name_hash, str_hash(sec->name));
 	}
 
-	if (stats)
+	if (stats) {
 		printf("nr_sections: %lu\n", (unsigned long)sections_nr);
+		printf("section_bits: %d\n", elf->section_bits);
+	}
 
 	/* sanity check, one more call to elf_nextscn() should return NULL */
 	if (elf_nextscn(elf->elf, s)) {
@@ -308,8 +325,8 @@ static void elf_add_symbol(struct elf *elf, struct symbol *sym)
 	else
 		entry = &sym->sec->symbol_list;
 	list_add(&sym->list, entry);
-	elf_hash_add(elf->symbol_hash, &sym->hash, sym->idx);
-	elf_hash_add(elf->symbol_name_hash, &sym->name_hash, str_hash(sym->name));
+	elf_hash_add(symbol, &sym->hash, sym->idx);
+	elf_hash_add(symbol_name, &sym->name_hash, str_hash(sym->name));
 
 	/*
 	 * Don't store empty STT_NOTYPE symbols in the rbtree.  They
@@ -329,19 +346,25 @@ static int read_symbols(struct elf *elf)
 	Elf32_Word shndx;
 
 	symtab = find_section_by_name(elf, ".symtab");
-	if (!symtab) {
+	if (symtab) {
+		symtab_shndx = find_section_by_name(elf, ".symtab_shndx");
+		if (symtab_shndx)
+			shndx_data = symtab_shndx->data;
+
+		symbols_nr = symtab->sh.sh_size / symtab->sh.sh_entsize;
+	} else {
 		/*
 		 * A missing symbol table is actually possible if it's an empty
-		 * .o file.  This can happen for thunk_64.o.
+		 * .o file. This can happen for thunk_64.o. Make sure to at
+		 * least allocate the symbol hash tables so we can do symbol
+		 * lookups without crashing.
 		 */
-		return 0;
+		symbols_nr = 0;
 	}
 
-	symtab_shndx = find_section_by_name(elf, ".symtab_shndx");
-	if (symtab_shndx)
-		shndx_data = symtab_shndx->data;
-
-	symbols_nr = symtab->sh.sh_size / symtab->sh.sh_entsize;
+	if (!elf_alloc_hash(symbol, symbols_nr) ||
+	    !elf_alloc_hash(symbol_name, symbols_nr))
+		return -1;
 
 	for (i = 0; i < symbols_nr; i++) {
 		sym = malloc(sizeof(*sym));
@@ -389,8 +412,10 @@ static int read_symbols(struct elf *elf)
 		elf_add_symbol(elf, sym);
 	}
 
-	if (stats)
+	if (stats) {
 		printf("nr_symbols: %lu\n", (unsigned long)symbols_nr);
+		printf("symbol_bits: %d\n", elf->symbol_bits);
+	}
 
 	/* Create parent/child links for any cold subfunctions */
 	list_for_each_entry(sec, &elf->sections, list) {
@@ -479,7 +504,7 @@ int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
 	reloc->addend = addend;
 
 	list_add_tail(&reloc->list, &sec->reloc->reloc_list);
-	elf_hash_add(elf->reloc_hash, &reloc->hash, reloc_hash(reloc));
+	elf_hash_add(reloc, &reloc->hash, reloc_hash(reloc));
 
 	sec->reloc->changed = true;
 
@@ -556,6 +581,15 @@ static int read_relocs(struct elf *elf)
 	unsigned int symndx;
 	unsigned long nr_reloc, max_reloc = 0, tot_reloc = 0;
 
+	sec = find_section_by_name(elf, ".text");
+	if (!sec) {
+		WARN("no .text");
+		return -1;
+	}
+
+	if (!elf_alloc_hash(reloc, sec->len / 16))
+		return -1;
+
 	list_for_each_entry(sec, &elf->sections, list) {
 		if ((sec->sh.sh_type != SHT_RELA) &&
 		    (sec->sh.sh_type != SHT_REL))
@@ -600,7 +634,7 @@ static int read_relocs(struct elf *elf)
 			}
 
 			list_add_tail(&reloc->list, &sec->reloc_list);
-			elf_hash_add(elf->reloc_hash, &reloc->hash, reloc_hash(reloc));
+			elf_hash_add(reloc, &reloc->hash, reloc_hash(reloc));
 
 			nr_reloc++;
 		}
@@ -611,6 +645,7 @@ static int read_relocs(struct elf *elf)
 	if (stats) {
 		printf("max_reloc: %lu\n", max_reloc);
 		printf("tot_reloc: %lu\n", tot_reloc);
+		printf("reloc_bits: %d\n", elf->reloc_bits);
 	}
 
 	return 0;
@@ -632,12 +667,6 @@ struct elf *elf_open_read(const char *name, int flags)
 
 	INIT_LIST_HEAD(&elf->sections);
 
-	elf_hash_init(elf->symbol_hash);
-	elf_hash_init(elf->symbol_name_hash);
-	elf_hash_init(elf->section_hash);
-	elf_hash_init(elf->section_name_hash);
-	elf_hash_init(elf->reloc_hash);
-
 	elf->fd = open(name, flags);
 	if (elf->fd == -1) {
 		fprintf(stderr, "objtool: Can't open '%s': %s\n",
@@ -850,8 +879,8 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 		return NULL;
 
 	list_add_tail(&sec->list, &elf->sections);
-	elf_hash_add(elf->section_hash, &sec->hash, sec->idx);
-	elf_hash_add(elf->section_name_hash, &sec->name_hash, str_hash(sec->name));
+	elf_hash_add(section, &sec->hash, sec->idx);
+	elf_hash_add(section_name, &sec->name_hash, str_hash(sec->name));
 
 	elf->changed = true;
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 45e5ede..9008275 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -84,11 +84,18 @@ struct elf {
 	bool changed;
 	char *name;
 	struct list_head sections;
-	DECLARE_HASHTABLE(symbol_hash, ELF_HASH_BITS);
-	DECLARE_HASHTABLE(symbol_name_hash, ELF_HASH_BITS);
-	DECLARE_HASHTABLE(section_hash, ELF_HASH_BITS);
-	DECLARE_HASHTABLE(section_name_hash, ELF_HASH_BITS);
-	DECLARE_HASHTABLE(reloc_hash, ELF_HASH_BITS);
+
+	int symbol_bits;
+	int symbol_name_bits;
+	int section_bits;
+	int section_name_bits;
+	int reloc_bits;
+
+	struct hlist_head *symbol_hash;
+	struct hlist_head *symbol_name_hash;
+	struct hlist_head *section_hash;
+	struct hlist_head *section_name_hash;
+	struct hlist_head *reloc_hash;
 };
 
 #define OFFSET_STRIDE_BITS	4
