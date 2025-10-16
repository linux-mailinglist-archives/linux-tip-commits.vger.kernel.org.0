Return-Path: <linux-tip-commits+bounces-6887-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3038CBE28D3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA8C1A62819
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B3232ED2A;
	Thu, 16 Oct 2025 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="12Noti7o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GNkCF+rD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3083F3176EF;
	Thu, 16 Oct 2025 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608380; cv=none; b=il/qfWSG9Xp9tay7bCTlvHzoEpZtJs9cVTMi1V9zuTHmV/32TnNNRPY7IGZtJusNNqQXL3AYTjTsY5Z3rDhEDrQc0TK2sIe9eu50ftmPj/xQeH1L1R3ehEaS1s7IdETFHFiGSYvVGiBqW3XQb+6Dd5v+Xh3ZHm1YQCb8RipUC/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608380; c=relaxed/simple;
	bh=C0uVvvIMj3Z/MTELl160FBiY1aDLyg6lvNd5LuR7Dns=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=b7rAEDkQUtLg7mWelo9J3tblWCep5NX4AkeGDJGD5/IpzwU582AhIwScDakZiA4KuAkuWt0P5ZmSjASVpl72R0r1GNtIvVUfBqUX/sOpLOpPbSMYjSyMok5N78w1iso7mR8Io9+mbViUrGMJ4XthyIX3+Nzu0ajF3GLqBKp5JU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=12Noti7o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GNkCF+rD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608367;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=IRunnOLkheWQKA8M0b2hqMUftKM6YR4DI3P4O3b0aUE=;
	b=12Noti7oFnebuDXUtAQ6NL6cm0ihlSzhH0pFjOos7iOoEcNUJlHj8bpeZlRvtTPJvZXZbA
	q387iYVfU8yaP9rWgqn9VLUtmpBYgBT31ENumZXYjVd27ElRK1LRcWJ2fjzB0dKJGuMSxT
	ONI9e3hL1bMSqcqP+0Gx2N7SOYmL4by0FX8Rdt8GxlsqtA01zgKJF7dle7bxg5Tpc9Cedh
	PnKVODMBI8Xkq5CazSCnjz8OHg/4QSskkwwOiro60xd0Qev8eJqlY2IjBLUkQ9qzLMWPep
	rmTOYNySLv9uwGUt/xHtXzcpHkDbtwMfPazU2KR+Fs0uw0daf6V35dl/w/dySg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608367;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=IRunnOLkheWQKA8M0b2hqMUftKM6YR4DI3P4O3b0aUE=;
	b=GNkCF+rDinp9y1oHmXww+ShDrGUu0SMT6Ww4g0DPyJck6V/aDw8mWJk6UYaK3bHaZFMevn
	HUh2+i3E1FTSw9Bw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add section/symbol type helpers
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060836598.709179.15308379969342667652.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     25eac74b6bdbf6d15911b582e747e8ad12fcbf8f
Gitweb:        https://git.kernel.org/tip/25eac74b6bdbf6d15911b582e747e8ad12f=
cbf8f
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:36 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:25 -07:00

objtool: Add section/symbol type helpers

Add some helper macros to improve readability.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/arch/x86/special.c    |  2 +-
 tools/objtool/check.c               | 58 ++++++++++++-------------
 tools/objtool/elf.c                 | 20 ++++----
 tools/objtool/include/objtool/elf.h | 66 ++++++++++++++++++++++++++++-
 tools/objtool/special.c             |  4 +-
 5 files changed, 108 insertions(+), 42 deletions(-)

diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/specia=
l.c
index 06ca4a2..0930076 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -89,7 +89,7 @@ struct reloc *arch_find_switch_table(struct objtool_file *f=
ile,
 	/* look for a relocation which references .rodata */
 	text_reloc =3D find_reloc_by_dest_range(file->elf, insn->sec,
 					      insn->offset, insn->len);
-	if (!text_reloc || text_reloc->sym->type !=3D STT_SECTION ||
+	if (!text_reloc || !is_sec_sym(text_reloc->sym) ||
 	    !text_reloc->sym->sec->rodata)
 		return NULL;
=20
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index dbc4fbd..f38f4a2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -261,7 +261,7 @@ static bool __dead_end_function(struct objtool_file *file=
, struct symbol *func,
 	if (!func)
 		return false;
=20
-	if (func->bind =3D=3D STB_GLOBAL || func->bind =3D=3D STB_WEAK) {
+	if (!is_local_sym(func)) {
 		if (is_rust_noreturn(func))
 			return true;
=20
@@ -270,7 +270,7 @@ static bool __dead_end_function(struct objtool_file *file=
, struct symbol *func,
 				return true;
 	}
=20
-	if (func->bind =3D=3D STB_WEAK)
+	if (is_weak_sym(func))
 		return false;
=20
 	if (!func->len)
@@ -436,7 +436,7 @@ static int decode_instructions(struct objtool_file *file)
 		u8 prev_len =3D 0;
 		u8 idx =3D 0;
=20
-		if (!(sec->sh.sh_flags & SHF_EXECINSTR))
+		if (!is_text_sec(sec))
 			continue;
=20
 		if (strcmp(sec->name, ".altinstr_replacement") &&
@@ -459,7 +459,7 @@ static int decode_instructions(struct objtool_file *file)
 		if (!strcmp(sec->name, ".init.text") && !opts.module)
 			sec->init =3D true;
=20
-		for (offset =3D 0; offset < sec->sh.sh_size; offset +=3D insn->len) {
+		for (offset =3D 0; offset < sec_size(sec); offset +=3D insn->len) {
 			if (!insns || idx =3D=3D INSN_CHUNK_MAX) {
 				insns =3D calloc(INSN_CHUNK_SIZE, sizeof(*insn));
 				if (!insns) {
@@ -478,7 +478,7 @@ static int decode_instructions(struct objtool_file *file)
 			insn->offset =3D offset;
 			insn->prev_len =3D prev_len;
=20
-			if (arch_decode_instruction(file, sec, offset, sec->sh.sh_size - offset, =
insn))
+			if (arch_decode_instruction(file, sec, offset, sec_size(sec) - offset, in=
sn))
 				return -1;
=20
 			prev_len =3D insn->len;
@@ -496,12 +496,12 @@ static int decode_instructions(struct objtool_file *fil=
e)
 		}
=20
 		sec_for_each_sym(sec, func) {
-			if (func->type !=3D STT_NOTYPE && func->type !=3D STT_FUNC)
+			if (!is_notype_sym(func) && !is_func_sym(func))
 				continue;
=20
-			if (func->offset =3D=3D sec->sh.sh_size) {
+			if (func->offset =3D=3D sec_size(sec)) {
 				/* Heuristic: likely an "end" symbol */
-				if (func->type =3D=3D STT_NOTYPE)
+				if (is_notype_sym(func))
 					continue;
 				ERROR("%s(): STT_FUNC at end of section", func->name);
 				return -1;
@@ -517,7 +517,7 @@ static int decode_instructions(struct objtool_file *file)
=20
 			sym_for_each_insn(file, func, insn) {
 				insn->sym =3D func;
-				if (func->type =3D=3D STT_FUNC &&
+				if (is_func_sym(func) &&
 				    insn->type =3D=3D INSN_ENDBR &&
 				    list_empty(&insn->call_node)) {
 					if (insn->offset =3D=3D func->offset) {
@@ -561,7 +561,7 @@ static int add_pv_ops(struct objtool_file *file, const ch=
ar *symname)
 		idx =3D (reloc_offset(reloc) - sym->offset) / sizeof(unsigned long);
=20
 		func =3D reloc->sym;
-		if (func->type =3D=3D STT_SECTION)
+		if (is_sec_sym(func))
 			func =3D find_symbol_by_offset(reloc->sym->sec,
 						     reloc_addend(reloc));
 		if (!func) {
@@ -823,7 +823,7 @@ static int create_ibt_endbr_seal_sections(struct objtool_=
file *file)
 		struct symbol *sym =3D insn->sym;
 		*site =3D 0;
=20
-		if (opts.module && sym && sym->type =3D=3D STT_FUNC &&
+		if (opts.module && sym && is_func_sym(sym) &&
 		    insn->offset =3D=3D sym->offset &&
 		    (!strcmp(sym->name, "init_module") ||
 		     !strcmp(sym->name, "cleanup_module"))) {
@@ -858,7 +858,7 @@ static int create_cfi_sections(struct objtool_file *file)
=20
 	idx =3D 0;
 	for_each_sym(file->elf, sym) {
-		if (sym->type !=3D STT_FUNC)
+		if (!is_func_sym(sym))
 			continue;
=20
 		if (strncmp(sym->name, "__cfi_", 6))
@@ -874,7 +874,7 @@ static int create_cfi_sections(struct objtool_file *file)
=20
 	idx =3D 0;
 	for_each_sym(file->elf, sym) {
-		if (sym->type !=3D STT_FUNC)
+		if (!is_func_sym(sym))
 			continue;
=20
 		if (strncmp(sym->name, "__cfi_", 6))
@@ -1463,7 +1463,7 @@ static bool jump_is_sibling_call(struct objtool_file *f=
ile,
 		return false;
=20
 	/* Disallow sibling calls into STT_NOTYPE */
-	if (ts->type =3D=3D STT_NOTYPE)
+	if (is_notype_sym(ts))
 		return false;
=20
 	/* Must not be self to be a sibling */
@@ -1497,7 +1497,7 @@ static int add_jump_destinations(struct objtool_file *f=
ile)
 		if (!reloc) {
 			dest_sec =3D insn->sec;
 			dest_off =3D arch_jump_destination(insn);
-		} else if (reloc->sym->type =3D=3D STT_SECTION) {
+		} else if (is_sec_sym(reloc->sym)) {
 			dest_sec =3D reloc->sym->sec;
 			dest_off =3D arch_insn_adjusted_addend(insn, reloc);
 		} else if (reloc->sym->retpoline_thunk) {
@@ -1657,12 +1657,12 @@ static int add_call_destinations(struct objtool_file =
*file)
 				return -1;
 			}
=20
-			if (func && insn_call_dest(insn)->type !=3D STT_FUNC) {
+			if (func && !is_func_sym(insn_call_dest(insn))) {
 				ERROR_INSN(insn, "unsupported call to non-function");
 				return -1;
 			}
=20
-		} else if (reloc->sym->type =3D=3D STT_SECTION) {
+		} else if (is_sec_sym(reloc->sym)) {
 			dest_off =3D arch_insn_adjusted_addend(insn, reloc);
 			dest =3D find_call_destination(reloc->sym->sec, dest_off);
 			if (!dest) {
@@ -2146,7 +2146,7 @@ static int add_jump_table_alts(struct objtool_file *fil=
e)
 		return 0;
=20
 	for_each_sym(file->elf, func) {
-		if (func->type !=3D STT_FUNC)
+		if (!is_func_sym(func))
 			continue;
=20
 		mark_func_jump_tables(file, func);
@@ -2185,14 +2185,14 @@ static int read_unwind_hints(struct objtool_file *fil=
e)
 		return -1;
 	}
=20
-	if (sec->sh.sh_size % sizeof(struct unwind_hint)) {
+	if (sec_size(sec) % sizeof(struct unwind_hint)) {
 		ERROR("struct unwind_hint size mismatch");
 		return -1;
 	}
=20
 	file->hints =3D true;
=20
-	for (i =3D 0; i < sec->sh.sh_size / sizeof(struct unwind_hint); i++) {
+	for (i =3D 0; i < sec_size(sec) / sizeof(struct unwind_hint); i++) {
 		hint =3D (struct unwind_hint *)sec->data->d_buf + i;
=20
 		reloc =3D find_reloc_by_dest(file->elf, sec, i * sizeof(*hint));
@@ -2201,7 +2201,7 @@ static int read_unwind_hints(struct objtool_file *file)
 			return -1;
 		}
=20
-		if (reloc->sym->type =3D=3D STT_SECTION) {
+		if (is_sec_sym(reloc->sym)) {
 			offset =3D reloc_addend(reloc);
 		} else if (reloc->sym->local_label) {
 			offset =3D reloc->sym->offset;
@@ -2237,7 +2237,7 @@ static int read_unwind_hints(struct objtool_file *file)
 		if (hint->type =3D=3D UNWIND_HINT_TYPE_REGS_PARTIAL) {
 			struct symbol *sym =3D find_symbol_by_offset(insn->sec, insn->offset);
=20
-			if (sym && sym->bind =3D=3D STB_GLOBAL) {
+			if (sym && is_global_sym(sym)) {
 				if (opts.ibt && insn->type !=3D INSN_ENDBR && !insn->noendbr) {
 					ERROR_INSN(insn, "UNWIND_HINT_IRET_REGS without ENDBR");
 					return -1;
@@ -2452,10 +2452,10 @@ static int classify_symbols(struct objtool_file *file)
 	struct symbol *func;
=20
 	for_each_sym(file->elf, func) {
-		if (func->type =3D=3D STT_NOTYPE && strstarts(func->name, ".L"))
+		if (is_notype_sym(func) && strstarts(func->name, ".L"))
 			func->local_label =3D true;
=20
-		if (func->bind !=3D STB_GLOBAL)
+		if (!is_global_sym(func))
 			continue;
=20
 		if (!strncmp(func->name, STATIC_CALL_TRAMP_PREFIX_STR,
@@ -4179,11 +4179,11 @@ static int add_prefix_symbols(struct objtool_file *fi=
le)
 	struct symbol *func;
=20
 	for_each_sec(file->elf, sec) {
-		if (!(sec->sh.sh_flags & SHF_EXECINSTR))
+		if (!is_text_sec(sec))
 			continue;
=20
 		sec_for_each_sym(sec, func) {
-			if (func->type !=3D STT_FUNC)
+			if (!is_func_sym(func))
 				continue;
=20
 			add_prefix_symbol(file, func);
@@ -4227,7 +4227,7 @@ static int validate_section(struct objtool_file *file, =
struct section *sec)
 	int warnings =3D 0;
=20
 	sec_for_each_sym(sec, func) {
-		if (func->type !=3D STT_FUNC)
+		if (!is_func_sym(func))
 			continue;
=20
 		init_insn_state(file, &state, sec);
@@ -4271,7 +4271,7 @@ static int validate_functions(struct objtool_file *file)
 	int warnings =3D 0;
=20
 	for_each_sec(file->elf, sec) {
-		if (!(sec->sh.sh_flags & SHF_EXECINSTR))
+		if (!is_text_sec(sec))
 			continue;
=20
 		warnings +=3D validate_section(file, sec);
@@ -4452,7 +4452,7 @@ static int validate_ibt(struct objtool_file *file)
 	for_each_sec(file->elf, sec) {
=20
 		/* Already done by validate_ibt_insn() */
-		if (sec->sh.sh_flags & SHF_EXECINSTR)
+		if (is_text_sec(sec))
 			continue;
=20
 		if (!sec->rsec)
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index c27edee..d36c0d4 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -170,7 +170,7 @@ struct symbol *find_symbol_by_offset(struct section *sec,=
 unsigned long offset)
 	struct symbol *iter;
=20
 	__sym_for_each(iter, tree, offset, offset) {
-		if (iter->offset =3D=3D offset && iter->type !=3D STT_SECTION)
+		if (iter->offset =3D=3D offset && !is_sec_sym(iter))
 			return iter;
 	}
=20
@@ -183,7 +183,7 @@ struct symbol *find_func_by_offset(struct section *sec, u=
nsigned long offset)
 	struct symbol *iter;
=20
 	__sym_for_each(iter, tree, offset, offset) {
-		if (iter->offset =3D=3D offset && iter->type =3D=3D STT_FUNC)
+		if (iter->offset =3D=3D offset && is_func_sym(iter))
 			return iter;
 	}
=20
@@ -264,7 +264,7 @@ struct symbol *find_func_containing(struct section *sec, =
unsigned long offset)
 	struct symbol *iter;
=20
 	__sym_for_each(iter, tree, offset, offset) {
-		if (iter->type =3D=3D STT_FUNC)
+		if (is_func_sym(iter))
 			return iter;
 	}
=20
@@ -373,14 +373,14 @@ static int read_sections(struct elf *elf)
 			return -1;
 		}
=20
-		if (sec->sh.sh_size !=3D 0 && !is_dwarf_section(sec)) {
+		if (sec_size(sec) !=3D 0 && !is_dwarf_section(sec)) {
 			sec->data =3D elf_getdata(s, NULL);
 			if (!sec->data) {
 				ERROR_ELF("elf_getdata");
 				return -1;
 			}
 			if (sec->data->d_off !=3D 0 ||
-			    sec->data->d_size !=3D sec->sh.sh_size) {
+			    sec->data->d_size !=3D sec_size(sec)) {
 				ERROR("unexpected data attributes for %s", sec->name);
 				return -1;
 			}
@@ -420,7 +420,7 @@ static void elf_add_symbol(struct elf *elf, struct symbol=
 *sym)
 	sym->type =3D GELF_ST_TYPE(sym->sym.st_info);
 	sym->bind =3D GELF_ST_BIND(sym->sym.st_info);
=20
-	if (sym->type =3D=3D STT_FILE)
+	if (is_file_sym(sym))
 		elf->num_files++;
=20
 	sym->offset =3D sym->sym.st_value;
@@ -527,7 +527,7 @@ static int read_symbols(struct elf *elf)
 		sec_for_each_sym(sec, sym) {
 			char *pname;
 			size_t pnamelen;
-			if (sym->type !=3D STT_FUNC)
+			if (!is_func_sym(sym))
 				continue;
=20
 			if (sym->pfunc =3D=3D NULL)
@@ -929,7 +929,7 @@ struct reloc *elf_init_reloc_text_sym(struct elf *elf, st=
ruct section *sec,
 	struct symbol *sym =3D insn_sec->sym;
 	int addend =3D insn_off;
=20
-	if (!(insn_sec->sh.sh_flags & SHF_EXECINSTR)) {
+	if (!is_text_sec(insn_sec)) {
 		ERROR("bad call to %s() for data symbol %s", __func__, sym->name);
 		return NULL;
 	}
@@ -958,7 +958,7 @@ struct reloc *elf_init_reloc_data_sym(struct elf *elf, st=
ruct section *sec,
 				      struct symbol *sym,
 				      s64 addend)
 {
-	if (sym->sec && (sec->sh.sh_flags & SHF_EXECINSTR)) {
+	if (is_text_sec(sec)) {
 		ERROR("bad call to %s() for text symbol %s", __func__, sym->name);
 		return NULL;
 	}
@@ -1287,7 +1287,7 @@ int elf_write_insn(struct elf *elf, struct section *sec,
  */
 static int elf_truncate_section(struct elf *elf, struct section *sec)
 {
-	u64 size =3D sec->sh.sh_size;
+	u64 size =3D sec_size(sec);
 	bool truncated =3D false;
 	Elf_Data *data =3D NULL;
 	Elf_Scn *s;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objt=
ool/elf.h
index 4d5f27b..f2dbcaa 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -8,6 +8,7 @@
=20
 #include <stdio.h>
 #include <gelf.h>
+#include <linux/string.h>
 #include <linux/list.h>
 #include <linux/hashtable.h>
 #include <linux/rbtree.h>
@@ -178,11 +179,71 @@ static inline unsigned int elf_text_rela_type(struct el=
f *elf)
 	return elf_addr_size(elf) =3D=3D 4 ? R_TEXT32 : R_TEXT64;
 }
=20
+static inline bool sym_has_sec(struct symbol *sym)
+{
+	return sym->sec->idx;
+}
+
+static inline bool is_null_sym(struct symbol *sym)
+{
+	return !sym->idx;
+}
+
+static inline bool is_sec_sym(struct symbol *sym)
+{
+	return sym->type =3D=3D STT_SECTION;
+}
+
+static inline bool is_object_sym(struct symbol *sym)
+{
+	return sym->type =3D=3D STT_OBJECT;
+}
+
+static inline bool is_func_sym(struct symbol *sym)
+{
+	return sym->type =3D=3D STT_FUNC;
+}
+
+static inline bool is_file_sym(struct symbol *sym)
+{
+	return sym->type =3D=3D STT_FILE;
+}
+
+static inline bool is_notype_sym(struct symbol *sym)
+{
+	return sym->type =3D=3D STT_NOTYPE;
+}
+
+static inline bool is_global_sym(struct symbol *sym)
+{
+	return sym->bind =3D=3D STB_GLOBAL;
+}
+
+static inline bool is_weak_sym(struct symbol *sym)
+{
+	return sym->bind =3D=3D STB_WEAK;
+}
+
+static inline bool is_local_sym(struct symbol *sym)
+{
+	return sym->bind =3D=3D STB_LOCAL;
+}
+
 static inline bool is_reloc_sec(struct section *sec)
 {
 	return sec->sh.sh_type =3D=3D SHT_RELA || sec->sh.sh_type =3D=3D SHT_REL;
 }
=20
+static inline bool is_string_sec(struct section *sec)
+{
+	return sec->sh.sh_flags & SHF_STRINGS;
+}
+
+static inline bool is_text_sec(struct section *sec)
+{
+	return sec->sh.sh_flags & SHF_EXECINSTR;
+}
+
 static inline bool sec_changed(struct section *sec)
 {
 	return sec->_changed;
@@ -223,6 +284,11 @@ static inline bool is_32bit_reloc(struct reloc *reloc)
 	return reloc->sec->sh.sh_entsize < 16;
 }
=20
+static inline unsigned long sec_size(struct section *sec)
+{
+	return sec->sh.sh_size;
+}
+
 #define __get_reloc_field(reloc, field)					\
 ({									\
 	is_32bit_reloc(reloc) ?						\
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index c0beefb..fc2cf8d 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -142,12 +142,12 @@ int special_get_alts(struct elf *elf, struct list_head =
*alts)
 		if (!sec)
 			continue;
=20
-		if (sec->sh.sh_size % entry->size !=3D 0) {
+		if (sec_size(sec) % entry->size !=3D 0) {
 			ERROR("%s size not a multiple of %d", sec->name, entry->size);
 			return -1;
 		}
=20
-		nr_entries =3D sec->sh.sh_size / entry->size;
+		nr_entries =3D sec_size(sec) / entry->size;
=20
 		for (idx =3D 0; idx < nr_entries; idx++) {
 			alt =3D malloc(sizeof(*alt));

