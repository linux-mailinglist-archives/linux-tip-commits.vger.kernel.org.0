Return-Path: <linux-tip-commits+bounces-6900-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD877BE29C4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C204876CB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E93335BBB;
	Thu, 16 Oct 2025 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O7f2VWuT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kTtFTdmD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD96431A06C;
	Thu, 16 Oct 2025 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608395; cv=none; b=jyAJlxdqicIzepEouPSDZfnCzMP52YMdLILaBSOnhHiEHFBhzbF2mlW8q5I+bPdcDXDxSN2ZExWYnYw5awhS5Lkf+6u7GvCcE5S434PuWvmLeTp5QMwa0zlUB0JvZNmzK1AReST8NuLiJzuIyTCkeIcQNL4dC3a9tYA80BLx1eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608395; c=relaxed/simple;
	bh=1lyhjpl6UBFfrpu2AsBfgbJv1xcSFe6SxOrsd9vtVxQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=sWBKdAYkzKqZT42wdX0gcwLf8xJM1SrGT2zlA4nqvM6PmxBt3xTYPLfmMPjHarSeWQzNZS6OmZkr+WWJ7PI/sBRIVQsGCaebRiaYox5lDKT9hCBUtAMT+HhsnxGFTAdysWtxUF/sHJLMkSdbmV8377pvpJ6QB2C8PFrKSDHbfWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O7f2VWuT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kTtFTdmD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608353;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mOCIGoBtEKNNR2ffrWTFldOUm7GKW7gMfN6qxmxlfkg=;
	b=O7f2VWuT5S2a12ws+CDhRzbXJqhzKXZIrUUCo8H2THv5d4beIhqbdwt91OkZg8zWsksxxQ
	NV3QJHSgG4e+k/nmUeyp+BkzthOLAtL+vZ6TY812jpk3nyBiJ3zc5IyNQCLRXtkgJ7eGzN
	emU1U4JeGYLZVGeO+l3eKx18FyR1yNwbEIQwtY5DOWaYey3S/gThnff76HFKdUpgEfx3RM
	+THPjOOVcMQNY4XhZ5qDE9xQZ23zW5vNYofyJcH44QWvqINWMuPhIHJieWVhGTSYqSGHaN
	0mXNIDrp4wY9WiQFeHWZxdEOIPM3S4ToPJ7cYovNyo+hWbtFvRZRIQD3xr5ihg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608353;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mOCIGoBtEKNNR2ffrWTFldOUm7GKW7gMfN6qxmxlfkg=;
	b=kTtFTdmDDb6QaTPDm7HqjSyrhoyhoiteD16jHvan/fBaTM68uWooDdWuubmTC1Ir6pgVCH
	UrRvqe6PnOcddRAQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Generalize elf_create_symbol()
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060835183.709179.17236409709130251135.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     dd2c29aafde7653839791d3073515b62e5df1f4d
Gitweb:        https://git.kernel.org/tip/dd2c29aafde7653839791d3073515b62e5d=
f1f4d
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:47 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:46:48 -07:00

objtool: Generalize elf_create_symbol()

In preparation for the objtool klp diff subcommand, broaden the
elf_create_symbol() interface to give callers more control and reduce
duplication of some subtle setup logic.

While at it, make elf_create_symbol() and elf_create_section_symbol()
global so sections can be created by the upcoming klp diff code.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c                 | 111 ++++++++++++++-------------
 tools/objtool/include/objtool/elf.h |  11 ++-
 2 files changed, 69 insertions(+), 53 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index c35726a..d7703c8 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -763,24 +763,60 @@ static int elf_update_symbol(struct elf *elf, struct se=
ction *symtab,
 	return 0;
 }
=20
-static struct symbol *
-__elf_create_symbol(struct elf *elf, struct symbol *sym)
+static int elf_add_string(struct elf *elf, struct section *strtab, const cha=
r *str);
+
+struct symbol *elf_create_symbol(struct elf *elf, const char *name,
+				 struct section *sec, unsigned int bind,
+				 unsigned int type, unsigned long offset,
+				 size_t size)
 {
 	struct section *symtab, *symtab_shndx;
 	Elf32_Word first_non_local, new_idx;
-	struct symbol *old;
+	struct symbol *old, *sym;
=20
-	symtab =3D find_section_by_name(elf, ".symtab");
-	if (symtab) {
-		symtab_shndx =3D find_section_by_name(elf, ".symtab_shndx");
+	sym =3D calloc(1, sizeof(*sym));
+	if (!sym) {
+		ERROR_GLIBC("calloc");
+		return NULL;
+	}
+
+	sym->name =3D strdup(name);
+	if (!sym->name) {
+		ERROR_GLIBC("strdup");
+		return NULL;
+	}
+
+	if (type !=3D STT_SECTION) {
+		sym->sym.st_name =3D elf_add_string(elf, NULL, sym->name);
+		if (sym->sym.st_name =3D=3D -1)
+			return NULL;
+	}
+
+	if (sec) {
+		sym->sec =3D sec;
 	} else {
+		sym->sec =3D find_section_by_index(elf, 0);
+		if (!sym->sec) {
+			ERROR("no NULL section");
+			return NULL;
+		}
+	}
+
+	sym->sym.st_info  =3D GELF_ST_INFO(bind, type);
+	sym->sym.st_value =3D offset;
+	sym->sym.st_size  =3D size;
+
+	symtab =3D find_section_by_name(elf, ".symtab");
+	if (!symtab) {
 		ERROR("no .symtab");
 		return NULL;
 	}
=20
+	symtab_shndx =3D find_section_by_name(elf, ".symtab_shndx");
+
 	new_idx =3D sec_num_entries(symtab);
=20
-	if (GELF_ST_BIND(sym->sym.st_info) !=3D STB_LOCAL)
+	if (bind !=3D STB_LOCAL)
 		goto non_local;
=20
 	/*
@@ -818,10 +854,8 @@ __elf_create_symbol(struct elf *elf, struct symbol *sym)
=20
 non_local:
 	sym->idx =3D new_idx;
-	if (elf_update_symbol(elf, symtab, symtab_shndx, sym)) {
-		ERROR("elf_update_symbol");
+	if (sym->idx && elf_update_symbol(elf, symtab, symtab_shndx, sym))
 		return NULL;
-	}
=20
 	symtab->sh.sh_size +=3D symtab->sh.sh_entsize;
 	mark_sec_changed(elf, symtab, true);
@@ -831,64 +865,39 @@ non_local:
 		mark_sec_changed(elf, symtab_shndx, true);
 	}
=20
+	elf_add_symbol(elf, sym);
+
 	return sym;
 }
=20
-static struct symbol *
-elf_create_section_symbol(struct elf *elf, struct section *sec)
+struct symbol *elf_create_section_symbol(struct elf *elf, struct section *se=
c)
 {
 	struct symbol *sym =3D calloc(1, sizeof(*sym));
=20
-	if (!sym) {
-		ERROR_GLIBC("malloc");
+	sym =3D elf_create_symbol(elf, sec->name, sec, STB_LOCAL, STT_SECTION, 0, 0=
);
+	if (!sym)
 		return NULL;
-	}
-
-	sym->name =3D sec->name;
-	sym->sec =3D sec;
=20
-	// st_name 0
-	sym->sym.st_info =3D GELF_ST_INFO(STB_LOCAL, STT_SECTION);
-	// st_other 0
-	// st_value 0
-	// st_size 0
-
-	sym =3D __elf_create_symbol(elf, sym);
-	if (sym)
-		elf_add_symbol(elf, sym);
+	sec->sym =3D sym;
=20
 	return sym;
 }
=20
-static int elf_add_string(struct elf *elf, struct section *strtab, const cha=
r *str);
-
 struct symbol *
-elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long size)
+elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, size_t size)
 {
-	struct symbol *sym =3D calloc(1, sizeof(*sym));
 	size_t namelen =3D strlen(orig->name) + sizeof("__pfx_");
-	char *name =3D malloc(namelen);
-
-	if (!sym || !name) {
-		ERROR_GLIBC("malloc");
-		return NULL;
-	}
+	char name[SYM_NAME_LEN];
+	unsigned long offset;
=20
 	snprintf(name, namelen, "__pfx_%s", orig->name);
=20
-	sym->name =3D name;
-	sym->sec =3D orig->sec;
+	offset =3D orig->sym.st_value - size;
=20
-	sym->sym.st_name =3D elf_add_string(elf, NULL, name);
-	sym->sym.st_info =3D orig->sym.st_info;
-	sym->sym.st_value =3D orig->sym.st_value - size;
-	sym->sym.st_size =3D size;
-
-	sym =3D __elf_create_symbol(elf, sym);
-	if (sym)
-		elf_add_symbol(elf, sym);
-
-	return sym;
+	return elf_create_symbol(elf, name, orig->sec,
+				 GELF_ST_BIND(orig->sym.st_info),
+				 GELF_ST_TYPE(orig->sym.st_info),
+				 offset, size);
 }
=20
 static struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
@@ -934,7 +943,7 @@ struct reloc *elf_init_reloc_text_sym(struct elf *elf, st=
ruct section *sec,
 				      unsigned long insn_off)
 {
 	struct symbol *sym =3D insn_sec->sym;
-	int addend =3D insn_off;
+	s64 addend =3D insn_off;
=20
 	if (!is_text_sec(insn_sec)) {
 		ERROR("bad call to %s() for data symbol %s", __func__, sym->name);
@@ -951,8 +960,6 @@ struct reloc *elf_init_reloc_text_sym(struct elf *elf, st=
ruct section *sec,
 		sym =3D elf_create_section_symbol(elf, insn_sec);
 		if (!sym)
 			return NULL;
-
-		insn_sec->sym =3D sym;
 	}
=20
 	return elf_init_reloc(elf, sec->rsec, reloc_idx, offset, sym, addend,
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objt=
ool/elf.h
index 07fc41f..c33b8fa 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -15,6 +15,8 @@
 #include <linux/jhash.h>
 #include <arch/elf.h>
=20
+#define SYM_NAME_LEN		512
+
 #ifdef LIBELF_USE_DEPRECATED
 # define elf_getshdrnum    elf_getshnum
 # define elf_getshdrstrndx elf_getshstrndx
@@ -120,7 +122,14 @@ struct section *elf_create_section_pair(struct elf *elf,=
 const char *name,
 					size_t entsize, unsigned int nr,
 					unsigned int reloc_nr);
=20
-struct symbol *elf_create_prefix_symbol(struct elf *elf, struct symbol *orig=
, long size);
+struct symbol *elf_create_symbol(struct elf *elf, const char *name,
+				 struct section *sec, unsigned int bind,
+				 unsigned int type, unsigned long offset,
+				 size_t size);
+struct symbol *elf_create_section_symbol(struct elf *elf, struct section *se=
c);
+struct symbol *elf_create_prefix_symbol(struct elf *elf, struct symbol *orig,
+					size_t size);
+
=20
 struct reloc *elf_init_reloc_text_sym(struct elf *elf, struct section *sec,
 				      unsigned long offset,

