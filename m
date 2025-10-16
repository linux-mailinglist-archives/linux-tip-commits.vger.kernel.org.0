Return-Path: <linux-tip-commits+bounces-6880-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1387ABE2951
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9F74869A6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C96A32ED5C;
	Thu, 16 Oct 2025 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xmqZIdjM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yeVxRILI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283BB31D365;
	Thu, 16 Oct 2025 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608374; cv=none; b=ZaFAkatOMD/COWvgHPJ1AYMubTYugbGKV92litbUeAq//4BWHBYxhdskzyU9CZwEzco7+QCJLdb2ae3vdxLTJE8Jtc8CutCTMYAMiwaertz1LaroKn1AIWG4qjkWKSeurPjsH7I4hSWfqOfX3sU9q9I/exHcW0UoIRYIsV0vpxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608374; c=relaxed/simple;
	bh=u9V0aBY7UDF1eHgZF9RVA2hE3jM15p1y1rBB2qghtyw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=J8O2wyLfUJAkggKK5B0pS+wr+WEU7kV5UnjxkbcvRjx6ZkyP93oCMlWjBEIACMzX43yzJeyd4py/e9RKWcBMrVy2e+snxTsNNurcd8dLKQh37Zl3nyRM1cY2ViCqwf1yd5jiucwuBLT9DXnYWNrxk5xjhBfBg7b+6iTGPajN/DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xmqZIdjM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yeVxRILI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608348;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=R6GMRGHw/nhH71RGfModwn1YhoZfffuWTeLGykDMteg=;
	b=xmqZIdjMiaSgTyYJnrZPgQuwMefSnd0SyKfFyD+ACL/bv1briT/w04IUD9K5QSAgONVOAr
	CIKDo41nVNV0wT8eY1FY2S+wDwxWt7F3necLvGR0ixgHkmfRXZJ/mVp4By6N8TFiUJkrAP
	7/HdnS1ydJ+6AcH7H3ejEH7v2uieoD1W+T6A2DM6EdjIKXMb3gxEikMIYJJX0xN6HA5bUk
	vj+4oNYLaszRhmj9M6yVbXBjeYlM6MVwz+EkWJGdFPbgRfDcpCRoJ6t2WuNMhG75v5I35o
	Jq20w0ywIcoi+mOIn0PCSOgdDsCJ4rXt9LiICNi4es28cn5yP1Pomo+bphi3aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608348;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=R6GMRGHw/nhH71RGfModwn1YhoZfffuWTeLGykDMteg=;
	b=yeVxRILIMGFkwBG0TaRsTLyAD+tpCSqXkiYWsJcIZNJrnM//HZ8UJKm03M6dCBnyUtrtoD
	tYfnBs9a6GiaHbCw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add elf_create_file()
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060834673.709179.11641444836812652627.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     03c19a99ee69f4680d7da11c164ac655b4946b99
Gitweb:        https://git.kernel.org/tip/03c19a99ee69f4680d7da11c164ac655b49=
46b99
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:51 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:46:49 -07:00

objtool: Add elf_create_file()

Add interface to enable the creation of a new ELF file.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/builtin-check.c       |   2 +-
 tools/objtool/elf.c                 | 144 ++++++++++++++++++++++++++-
 tools/objtool/include/objtool/elf.h |   5 +-
 3 files changed, 147 insertions(+), 4 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index fc91bc5..9969714 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -329,5 +329,5 @@ int objtool_run(int argc, const char **argv)
 	if (!opts.dryrun && file->elf->changed && elf_write(file->elf))
 		return 1;
=20
-	return 0;
+	return elf_close(file->elf);
 }
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 8d01fc3..6095bab 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -16,6 +16,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <errno.h>
+#include <libgen.h>
 #include <linux/interval_tree_generic.h>
 #include <objtool/builtin.h>
 #include <objtool/elf.h>
@@ -1067,6 +1068,12 @@ struct elf *elf_open_read(const char *name, int flags)
 		goto err;
 	}
=20
+	elf->name =3D strdup(name);
+	if (!elf->name) {
+		ERROR_GLIBC("strdup");
+		return NULL;
+	}
+
 	if ((flags & O_ACCMODE) =3D=3D O_RDONLY)
 		cmd =3D ELF_C_READ_MMAP;
 	else if ((flags & O_ACCMODE) =3D=3D O_RDWR)
@@ -1104,6 +1111,137 @@ err:
 	return NULL;
 }
=20
+struct elf *elf_create_file(GElf_Ehdr *ehdr, const char *name)
+{
+	struct section *null, *symtab, *strtab, *shstrtab;
+	char *dir, *base, *tmp_name;
+	struct symbol *sym;
+	struct elf *elf;
+
+	elf_version(EV_CURRENT);
+
+	elf =3D calloc(1, sizeof(*elf));
+	if (!elf) {
+		ERROR_GLIBC("calloc");
+		return NULL;
+	}
+
+	INIT_LIST_HEAD(&elf->sections);
+
+	dir =3D strdup(name);
+	if (!dir) {
+		ERROR_GLIBC("strdup");
+		return NULL;
+	}
+
+	dir =3D dirname(dir);
+
+	base =3D strdup(name);
+	if (!base) {
+		ERROR_GLIBC("strdup");
+		return NULL;
+	}
+
+	base =3D basename(base);
+
+	tmp_name =3D malloc(256);
+	if (!tmp_name) {
+		ERROR_GLIBC("malloc");
+		return NULL;
+	}
+
+	snprintf(tmp_name, 256, "%s/%s.XXXXXX", dir, base);
+
+	elf->fd =3D mkstemp(tmp_name);
+	if (elf->fd =3D=3D -1) {
+		ERROR_GLIBC("can't create tmp file");
+		exit(1);
+	}
+
+	elf->tmp_name =3D tmp_name;
+
+	elf->name =3D strdup(name);
+	if (!elf->name) {
+		ERROR_GLIBC("strdup");
+		return NULL;
+	}
+
+	elf->elf =3D elf_begin(elf->fd, ELF_C_WRITE, NULL);
+	if (!elf->elf) {
+		ERROR_ELF("elf_begin");
+		return NULL;
+	}
+
+	if (!gelf_newehdr(elf->elf, ELFCLASS64)) {
+		ERROR_ELF("gelf_newehdr");
+		return NULL;
+	}
+
+	memcpy(&elf->ehdr, ehdr, sizeof(elf->ehdr));
+
+	if (!gelf_update_ehdr(elf->elf, &elf->ehdr)) {
+		ERROR_ELF("gelf_update_ehdr");
+		return NULL;
+	}
+
+	if (!elf_alloc_hash(section,		1000) ||
+	    !elf_alloc_hash(section_name,	1000) ||
+	    !elf_alloc_hash(symbol,		10000) ||
+	    !elf_alloc_hash(symbol_name,	10000) ||
+	    !elf_alloc_hash(reloc,		100000))
+		return NULL;
+
+	null		=3D elf_create_section(elf, NULL, 0, 0, SHT_NULL, 0, 0);
+	shstrtab	=3D elf_create_section(elf, NULL, 0, 0, SHT_STRTAB, 1, 0);
+	strtab		=3D elf_create_section(elf, NULL, 0, 0, SHT_STRTAB, 1, 0);
+
+	if (!null || !shstrtab || !strtab)
+		return NULL;
+
+	null->name	=3D "";
+	shstrtab->name	=3D ".shstrtab";
+	strtab->name	=3D ".strtab";
+
+	null->sh.sh_name	=3D elf_add_string(elf, shstrtab, null->name);
+	shstrtab->sh.sh_name	=3D elf_add_string(elf, shstrtab, shstrtab->name);
+	strtab->sh.sh_name	=3D elf_add_string(elf, shstrtab, strtab->name);
+
+	if (null->sh.sh_name =3D=3D -1 || shstrtab->sh.sh_name =3D=3D -1 || strtab-=
>sh.sh_name =3D=3D -1)
+		return NULL;
+
+	elf_hash_add(section_name, &null->name_hash,		str_hash(null->name));
+	elf_hash_add(section_name, &strtab->name_hash,		str_hash(strtab->name));
+	elf_hash_add(section_name, &shstrtab->name_hash,	str_hash(shstrtab->name));
+
+	if (elf_add_string(elf, strtab, "") =3D=3D -1)
+		return NULL;
+
+	symtab =3D elf_create_section(elf, ".symtab", 0x18, 0x18, SHT_SYMTAB, 0x8, =
0);
+	if (!symtab)
+		return NULL;
+
+	symtab->sh.sh_link =3D strtab->idx;
+	symtab->sh.sh_info =3D 1;
+
+	elf->ehdr.e_shstrndx =3D shstrtab->idx;
+	if (!gelf_update_ehdr(elf->elf, &elf->ehdr)) {
+		ERROR_ELF("gelf_update_ehdr");
+		return NULL;
+	}
+
+	sym =3D calloc(1, sizeof(*sym));
+	if (!sym) {
+		ERROR_GLIBC("calloc");
+		return NULL;
+	}
+
+	sym->name =3D "";
+	sym->sec =3D null;
+	elf_add_symbol(elf, sym);
+
+	return elf;
+}
+
 unsigned int elf_add_string(struct elf *elf, struct section *strtab, const c=
har *str)
 {
 	unsigned int offset;
@@ -1568,7 +1706,7 @@ int elf_write(struct elf *elf)
 	return 0;
 }
=20
-void elf_close(struct elf *elf)
+int elf_close(struct elf *elf)
 {
 	if (elf->elf)
 		elf_end(elf->elf);
@@ -1576,8 +1714,12 @@ void elf_close(struct elf *elf)
 	if (elf->fd > 0)
 		close(elf->fd);
=20
+	if (elf->tmp_name && rename(elf->tmp_name, elf->name))
+		return -1;
+
 	/*
 	 * NOTE: All remaining allocations are leaked on purpose.  Objtool is
 	 * about to exit anyway.
 	 */
+	return 0;
 }
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objt=
ool/elf.h
index 999fd93..9f135c2 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -94,7 +94,7 @@ struct elf {
 	GElf_Ehdr ehdr;
 	int fd;
 	bool changed;
-	const char *name;
+	const char *name, *tmp_name;
 	unsigned int num_files;
 	struct list_head sections;
 	unsigned long num_relocs;
@@ -116,6 +116,7 @@ struct elf {
 };
=20
 struct elf *elf_open_read(const char *name, int flags);
+struct elf *elf_create_file(GElf_Ehdr *ehdr, const char *name);
=20
 struct section *elf_create_section(struct elf *elf, const char *name,
 				   size_t size, size_t entsize,
@@ -165,7 +166,7 @@ int elf_write_insn(struct elf *elf, struct section *sec, =
unsigned long offset,
 		   unsigned int len, const char *insn);
=20
 int elf_write(struct elf *elf);
-void elf_close(struct elf *elf);
+int elf_close(struct elf *elf);
=20
 struct section *find_section_by_name(const struct elf *elf, const char *name=
);
 struct symbol *find_func_by_offset(struct section *sec, unsigned long offset=
);

