Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BF5353395
	for <lists+linux-tip-commits@lfdr.de>; Sat,  3 Apr 2021 13:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbhDCLLE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 3 Apr 2021 07:11:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42382 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbhDCLLC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 3 Apr 2021 07:11:02 -0400
Date:   Sat, 03 Apr 2021 11:10:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617448258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQ/9ocW2V6eUWx8ejy8+yWTD69m7DKoYDNw8rLUfeBk=;
        b=XV0irYe/cOhgx21TmYKy3lWBFFgoWjw/c9sfuB0k9kPPIAUsBfNmVY/woj0oj8TUOtPDPO
        S/uNsW3o4hwexo+zFDGocUvhR8Je+X5958IPXHIaba4nMkJv/6oj5aorj0ADfnq+MGUc6j
        9zQ3zak+JJB7bhdp9z1GJW5SovD1ESPgKGdxtRqscmQp4VbtXiz7twgtNMOhFdyrvmGZDV
        s8U/mrTvn20voNs2wAXJZuvOqCM6WMpv3d8G127EpMmeqSMFcxkyounoBca8YgA3nud1mc
        lqK026lgcCRNS3HQqws0PZtouIrOji3sSWux3BTeYiMBGRY9Rp/7WdPeucsiiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617448258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQ/9ocW2V6eUWx8ejy8+yWTD69m7DKoYDNw8rLUfeBk=;
        b=sDNauaJS17a6sa2amt/jM2PIYSGUTYFGxUOcAhhUTp9xG35FYwe+ZYTEDHvvf9B8Vm2kxP
        K6LxbXZO+lxKdvCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Add elf_create_reloc() helper
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210326151259.817438847@infradead.org>
References: <20210326151259.817438847@infradead.org>
MIME-Version: 1.0
Message-ID: <161744825786.29796.2814114171206086849.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     ef47cc01cb4abcd760d8ac66b9361d6ade4d0846
Gitweb:        https://git.kernel.org/tip/ef47cc01cb4abcd760d8ac66b9361d6ade4d0846
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Mar 2021 16:12:07 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 Apr 2021 12:44:18 +02:00

objtool: Add elf_create_reloc() helper

We have 4 instances of adding a relocation. Create a common helper
to avoid growing even more.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/20210326151259.817438847@infradead.org
---
 tools/objtool/check.c               | 78 +++++--------------------
 tools/objtool/elf.c                 | 86 ++++++++++++++++++----------
 tools/objtool/include/objtool/elf.h | 10 ++-
 tools/objtool/orc_gen.c             | 30 ++--------
 4 files changed, 85 insertions(+), 119 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1d0415b..61fe29a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -433,8 +433,7 @@ reachable:
 
 static int create_static_call_sections(struct objtool_file *file)
 {
-	struct section *sec, *reloc_sec;
-	struct reloc *reloc;
+	struct section *sec;
 	struct static_call_site *site;
 	struct instruction *insn;
 	struct symbol *key_sym;
@@ -460,8 +459,7 @@ static int create_static_call_sections(struct objtool_file *file)
 	if (!sec)
 		return -1;
 
-	reloc_sec = elf_create_reloc_section(file->elf, sec, SHT_RELA);
-	if (!reloc_sec)
+	if (!elf_create_reloc_section(file->elf, sec, SHT_RELA))
 		return -1;
 
 	idx = 0;
@@ -471,25 +469,11 @@ static int create_static_call_sections(struct objtool_file *file)
 		memset(site, 0, sizeof(struct static_call_site));
 
 		/* populate reloc for 'addr' */
-		reloc = malloc(sizeof(*reloc));
-
-		if (!reloc) {
-			perror("malloc");
-			return -1;
-		}
-		memset(reloc, 0, sizeof(*reloc));
-
-		insn_to_reloc_sym_addend(insn->sec, insn->offset, reloc);
-		if (!reloc->sym) {
-			WARN_FUNC("static call tramp: missing containing symbol",
-				  insn->sec, insn->offset);
+		if (elf_add_reloc_to_insn(file->elf, sec,
+					  idx * sizeof(struct static_call_site),
+					  R_X86_64_PC32,
+					  insn->sec, insn->offset))
 			return -1;
-		}
-
-		reloc->type = R_X86_64_PC32;
-		reloc->offset = idx * sizeof(struct static_call_site);
-		reloc->sec = reloc_sec;
-		elf_add_reloc(file->elf, reloc);
 
 		/* find key symbol */
 		key_name = strdup(insn->call_dest->name);
@@ -526,18 +510,11 @@ static int create_static_call_sections(struct objtool_file *file)
 		free(key_name);
 
 		/* populate reloc for 'key' */
-		reloc = malloc(sizeof(*reloc));
-		if (!reloc) {
-			perror("malloc");
+		if (elf_add_reloc(file->elf, sec,
+				  idx * sizeof(struct static_call_site) + 4,
+				  R_X86_64_PC32, key_sym,
+				  is_sibling_call(insn) * STATIC_CALL_SITE_TAIL))
 			return -1;
-		}
-		memset(reloc, 0, sizeof(*reloc));
-		reloc->sym = key_sym;
-		reloc->addend = is_sibling_call(insn) ? STATIC_CALL_SITE_TAIL : 0;
-		reloc->type = R_X86_64_PC32;
-		reloc->offset = idx * sizeof(struct static_call_site) + 4;
-		reloc->sec = reloc_sec;
-		elf_add_reloc(file->elf, reloc);
 
 		idx++;
 	}
@@ -547,8 +524,7 @@ static int create_static_call_sections(struct objtool_file *file)
 
 static int create_mcount_loc_sections(struct objtool_file *file)
 {
-	struct section *sec, *reloc_sec;
-	struct reloc *reloc;
+	struct section *sec;
 	unsigned long *loc;
 	struct instruction *insn;
 	int idx;
@@ -571,8 +547,7 @@ static int create_mcount_loc_sections(struct objtool_file *file)
 	if (!sec)
 		return -1;
 
-	reloc_sec = elf_create_reloc_section(file->elf, sec, SHT_RELA);
-	if (!reloc_sec)
+	if (!elf_create_reloc_section(file->elf, sec, SHT_RELA))
 		return -1;
 
 	idx = 0;
@@ -581,32 +556,11 @@ static int create_mcount_loc_sections(struct objtool_file *file)
 		loc = (unsigned long *)sec->data->d_buf + idx;
 		memset(loc, 0, sizeof(unsigned long));
 
-		reloc = malloc(sizeof(*reloc));
-		if (!reloc) {
-			perror("malloc");
+		if (elf_add_reloc_to_insn(file->elf, sec,
+					  idx * sizeof(unsigned long),
+					  R_X86_64_64,
+					  insn->sec, insn->offset))
 			return -1;
-		}
-		memset(reloc, 0, sizeof(*reloc));
-
-		if (insn->sec->sym) {
-			reloc->sym = insn->sec->sym;
-			reloc->addend = insn->offset;
-		} else {
-			reloc->sym = find_symbol_containing(insn->sec, insn->offset);
-
-			if (!reloc->sym) {
-				WARN("missing symbol for insn at offset 0x%lx\n",
-				     insn->offset);
-				return -1;
-			}
-
-			reloc->addend = insn->offset - reloc->sym->offset;
-		}
-
-		reloc->type = R_X86_64_64;
-		reloc->offset = idx * sizeof(unsigned long);
-		reloc->sec = reloc_sec;
-		elf_add_reloc(file->elf, reloc);
 
 		idx++;
 	}
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 374813e..0ab52ac 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -211,32 +211,6 @@ struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, uns
 	return find_reloc_by_dest_range(elf, sec, offset, 1);
 }
 
-void insn_to_reloc_sym_addend(struct section *sec, unsigned long offset,
-			      struct reloc *reloc)
-{
-	if (sec->sym) {
-		reloc->sym = sec->sym;
-		reloc->addend = offset;
-		return;
-	}
-
-	/*
-	 * The Clang assembler strips section symbols, so we have to reference
-	 * the function symbol instead:
-	 */
-	reloc->sym = find_symbol_containing(sec, offset);
-	if (!reloc->sym) {
-		/*
-		 * Hack alert.  This happens when we need to reference the NOP
-		 * pad insn immediately after the function.
-		 */
-		reloc->sym = find_symbol_containing(sec, offset - 1);
-	}
-
-	if (reloc->sym)
-		reloc->addend = offset - reloc->sym->offset;
-}
-
 static int read_sections(struct elf *elf)
 {
 	Elf_Scn *s = NULL;
@@ -473,14 +447,66 @@ err:
 	return -1;
 }
 
-void elf_add_reloc(struct elf *elf, struct reloc *reloc)
+int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
+		  unsigned int type, struct symbol *sym, int addend)
 {
-	struct section *sec = reloc->sec;
+	struct reloc *reloc;
+
+	reloc = malloc(sizeof(*reloc));
+	if (!reloc) {
+		perror("malloc");
+		return -1;
+	}
+	memset(reloc, 0, sizeof(*reloc));
 
-	list_add_tail(&reloc->list, &sec->reloc_list);
+	reloc->sec = sec->reloc;
+	reloc->offset = offset;
+	reloc->type = type;
+	reloc->sym = sym;
+	reloc->addend = addend;
+
+	list_add_tail(&reloc->list, &sec->reloc->reloc_list);
 	elf_hash_add(elf->reloc_hash, &reloc->hash, reloc_hash(reloc));
 
-	sec->changed = true;
+	sec->reloc->changed = true;
+
+	return 0;
+}
+
+int elf_add_reloc_to_insn(struct elf *elf, struct section *sec,
+			  unsigned long offset, unsigned int type,
+			  struct section *insn_sec, unsigned long insn_off)
+{
+	struct symbol *sym;
+	int addend;
+
+	if (insn_sec->sym) {
+		sym = insn_sec->sym;
+		addend = insn_off;
+
+	} else {
+		/*
+		 * The Clang assembler strips section symbols, so we have to
+		 * reference the function symbol instead:
+		 */
+		sym = find_symbol_containing(insn_sec, insn_off);
+		if (!sym) {
+			/*
+			 * Hack alert.  This happens when we need to reference
+			 * the NOP pad insn immediately after the function.
+			 */
+			sym = find_symbol_containing(insn_sec, insn_off - 1);
+		}
+
+		if (!sym) {
+			WARN("can't find symbol containing %s+0x%lx", insn_sec->name, insn_off);
+			return -1;
+		}
+
+		addend = insn_off - sym->offset;
+	}
+
+	return elf_add_reloc(elf, sec, offset, type, sym, addend);
 }
 
 static int read_rel_reloc(struct section *sec, int i, struct reloc *reloc, unsigned int *symndx)
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index fc576ed..825ad32 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -123,7 +123,13 @@ static inline u32 reloc_hash(struct reloc *reloc)
 struct elf *elf_open_read(const char *name, int flags);
 struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
 struct section *elf_create_reloc_section(struct elf *elf, struct section *base, int reltype);
-void elf_add_reloc(struct elf *elf, struct reloc *reloc);
+
+int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
+		  unsigned int type, struct symbol *sym, int addend);
+int elf_add_reloc_to_insn(struct elf *elf, struct section *sec,
+			  unsigned long offset, unsigned int type,
+			  struct section *insn_sec, unsigned long insn_off);
+
 int elf_write_insn(struct elf *elf, struct section *sec,
 		   unsigned long offset, unsigned int len,
 		   const char *insn);
@@ -140,8 +146,6 @@ struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, uns
 struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *sec,
 				     unsigned long offset, unsigned int len);
 struct symbol *find_func_containing(struct section *sec, unsigned long offset);
-void insn_to_reloc_sym_addend(struct section *sec, unsigned long offset,
-			      struct reloc *reloc);
 
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index f534708..1b57be6 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -82,12 +82,11 @@ static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi)
 }
 
 static int write_orc_entry(struct elf *elf, struct section *orc_sec,
-			   struct section *ip_rsec, unsigned int idx,
+			   struct section *ip_sec, unsigned int idx,
 			   struct section *insn_sec, unsigned long insn_off,
 			   struct orc_entry *o)
 {
 	struct orc_entry *orc;
-	struct reloc *reloc;
 
 	/* populate ORC data */
 	orc = (struct orc_entry *)orc_sec->data->d_buf + idx;
@@ -96,25 +95,9 @@ static int write_orc_entry(struct elf *elf, struct section *orc_sec,
 	orc->bp_offset = bswap_if_needed(orc->bp_offset);
 
 	/* populate reloc for ip */
-	reloc = malloc(sizeof(*reloc));
-	if (!reloc) {
-		perror("malloc");
+	if (elf_add_reloc_to_insn(elf, ip_sec, idx * sizeof(int), R_X86_64_PC32,
+				  insn_sec, insn_off))
 		return -1;
-	}
-	memset(reloc, 0, sizeof(*reloc));
-
-	insn_to_reloc_sym_addend(insn_sec, insn_off, reloc);
-	if (!reloc->sym) {
-		WARN("missing symbol for insn at offset 0x%lx",
-		     insn_off);
-		return -1;
-	}
-
-	reloc->type = R_X86_64_PC32;
-	reloc->offset = idx * sizeof(int);
-	reloc->sec = ip_rsec;
-
-	elf_add_reloc(elf, reloc);
 
 	return 0;
 }
@@ -153,7 +136,7 @@ static unsigned long alt_group_len(struct alt_group *alt_group)
 
 int orc_create(struct objtool_file *file)
 {
-	struct section *sec, *ip_rsec, *orc_sec;
+	struct section *sec, *orc_sec;
 	unsigned int nr = 0, idx = 0;
 	struct orc_list_entry *entry;
 	struct list_head orc_list;
@@ -242,13 +225,12 @@ int orc_create(struct objtool_file *file)
 	sec = elf_create_section(file->elf, ".orc_unwind_ip", 0, sizeof(int), nr);
 	if (!sec)
 		return -1;
-	ip_rsec = elf_create_reloc_section(file->elf, sec, SHT_RELA);
-	if (!ip_rsec)
+	if (!elf_create_reloc_section(file->elf, sec, SHT_RELA))
 		return -1;
 
 	/* Write ORC entries to sections: */
 	list_for_each_entry(entry, &orc_list, list) {
-		if (write_orc_entry(file->elf, orc_sec, ip_rsec, idx++,
+		if (write_orc_entry(file->elf, orc_sec, sec, idx++,
 				    entry->insn_sec, entry->insn_off,
 				    &entry->orc))
 			return -1;
