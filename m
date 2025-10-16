Return-Path: <linux-tip-commits+bounces-6894-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B55DBE29AF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E210425EB9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E24322DD0;
	Thu, 16 Oct 2025 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ZX+hIdj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nn4sJNdO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B9E31A7E2;
	Thu, 16 Oct 2025 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608387; cv=none; b=kbvCvA62oCY7X2XU+6toN2q0vHALgeEqxKhAtuAUHPKDAkzMc0SgNFjPPmk8cks3XrnRw5vH5x1ZfgXWnMNI2oDYcKH9VCngWJOp2Tg1Urf492201gYjy47OmcHe1pKOF4j3Cf8HTZ+A3SWKGL/sjpiQmjPgDvCB0RcDV8tIGAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608387; c=relaxed/simple;
	bh=gCQsipPrSpzMwj3vr2mZFoy4aUl1h5COzlTn7Ms2RxU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Eu61nFb05NEU3gbSAAx2jCm3yib79e3Nxh63/HRfOEssbnGwh/sd3uA1fM+IJlSRvJ05DQowxb61tx03v9VZTN+J0mVsTXtR52HOr34vHvg7if2C80MFQ3VG7QCgYUkcQ07LfN/f1vqKEuzRgVFhryI8zUgyuNmrDn/0bhzgfc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2ZX+hIdj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nn4sJNdO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608352;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=zJY0KY+ML7pfA1Jt9H1YYPBWM0fCNy8RrockH+tynTg=;
	b=2ZX+hIdjEynvoO/5LpqnRwPVlNxKEJh66r26IRmbWUj7ymq9VronXiMpJlUrN5q49jC2Ms
	Mr0Txh33y9U0l59EPD/II2yEoM59ZOFCmnDsLNiBN/QzzZy0Aw5yaLY89npDFli9A/1iak
	PGE7RppXhXqPH2oKjjf8Fi1md3lBmAj/WIn2HxruNKvVQ5t4rXmhi9mdeJKUbXQZPdri1m
	FZqUWSjlV3ERVfHe3rXk/yMLR2EFi63UPaVP6tv2cVEBEMSAWgsnov06ae7NkgYqIE5+2t
	5Yig84tIwtn9tWs5rzGctzQFDc00ykn8jsxLxBhH4H4MCrRge7vFqnsnFXGCKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608352;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=zJY0KY+ML7pfA1Jt9H1YYPBWM0fCNy8RrockH+tynTg=;
	b=nn4sJNdO4as3aqKH0qoKWxuKMwiv5KQPIQvmbbe93ojYl2MSBD29v7xPZ4ft2b3yhvX6AZ
	qzWVCcXfSH7c1BCA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Generalize elf_create_section()
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060835057.709179.4577155848205602071.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     243e96385368fc5e31da4e9927a201a27a2ae936
Gitweb:        https://git.kernel.org/tip/243e96385368fc5e31da4e9927a201a27a2=
ae936
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:48 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:46:48 -07:00

objtool: Generalize elf_create_section()

In preparation for the objtool klp diff subcommand, broaden the
elf_create_section() interface to give callers more control and reduce
duplication of some subtle setup logic.

While at it, make elf_create_rela_section() global so sections can be
created by the upcoming klp diff code.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c                 | 114 +++++++++++++++------------
 tools/objtool/include/objtool/elf.h |   7 +-
 tools/objtool/orc_gen.c             |   6 +-
 3 files changed, 75 insertions(+), 52 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index d7703c8..7a7e63c 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -1138,51 +1138,53 @@ static int elf_add_string(struct elf *elf, struct sec=
tion *strtab, const char *s
 }
=20
 struct section *elf_create_section(struct elf *elf, const char *name,
-				   size_t entsize, unsigned int nr)
+				   size_t size, size_t entsize,
+				   unsigned int type, unsigned int align,
+				   unsigned int flags)
 {
 	struct section *sec, *shstrtab;
-	size_t size =3D entsize * nr;
 	Elf_Scn *s;
=20
-	sec =3D malloc(sizeof(*sec));
+	if (name && find_section_by_name(elf, name)) {
+		ERROR("section '%s' already exists", name);
+		return NULL;
+	}
+
+	sec =3D calloc(1, sizeof(*sec));
 	if (!sec) {
-		ERROR_GLIBC("malloc");
+		ERROR_GLIBC("calloc");
 		return NULL;
 	}
-	memset(sec, 0, sizeof(*sec));
=20
 	INIT_LIST_HEAD(&sec->symbol_list);
=20
+	/* don't actually create the section, just the data structures */
+	if (type =3D=3D SHT_NULL)
+		goto add;
+
 	s =3D elf_newscn(elf->elf);
 	if (!s) {
 		ERROR_ELF("elf_newscn");
 		return NULL;
 	}
=20
-	sec->name =3D strdup(name);
-	if (!sec->name) {
-		ERROR_GLIBC("strdup");
-		return NULL;
-	}
-
 	sec->idx =3D elf_ndxscn(s);
=20
-	sec->data =3D elf_newdata(s);
-	if (!sec->data) {
-		ERROR_ELF("elf_newdata");
-		return NULL;
-	}
+	if (size) {
+		sec->data =3D elf_newdata(s);
+		if (!sec->data) {
+			ERROR_ELF("elf_newdata");
+			return NULL;
+		}
=20
-	sec->data->d_size =3D size;
-	sec->data->d_align =3D 1;
+		sec->data->d_size =3D size;
+		sec->data->d_align =3D 1;
=20
-	if (size) {
-		sec->data->d_buf =3D malloc(size);
+		sec->data->d_buf =3D calloc(1, size);
 		if (!sec->data->d_buf) {
-			ERROR_GLIBC("malloc");
+			ERROR_GLIBC("calloc");
 			return NULL;
 		}
-		memset(sec->data->d_buf, 0, size);
 	}
=20
 	if (!gelf_getshdr(s, &sec->sh)) {
@@ -1192,34 +1194,44 @@ struct section *elf_create_section(struct elf *elf, c=
onst char *name,
=20
 	sec->sh.sh_size =3D size;
 	sec->sh.sh_entsize =3D entsize;
-	sec->sh.sh_type =3D SHT_PROGBITS;
-	sec->sh.sh_addralign =3D 1;
-	sec->sh.sh_flags =3D SHF_ALLOC;
-
-	/* Add section name to .shstrtab (or .strtab for Clang) */
-	shstrtab =3D find_section_by_name(elf, ".shstrtab");
-	if (!shstrtab)
-		shstrtab =3D find_section_by_name(elf, ".strtab");
-	if (!shstrtab) {
-		ERROR("can't find .shstrtab or .strtab section");
-		return NULL;
+	sec->sh.sh_type =3D type;
+	sec->sh.sh_addralign =3D align;
+	sec->sh.sh_flags =3D flags;
+
+	if (name) {
+		sec->name =3D strdup(name);
+		if (!sec->name) {
+			ERROR("strdup");
+			return NULL;
+		}
+
+		/* Add section name to .shstrtab (or .strtab for Clang) */
+		shstrtab =3D find_section_by_name(elf, ".shstrtab");
+		if (!shstrtab) {
+			shstrtab =3D find_section_by_name(elf, ".strtab");
+			if (!shstrtab) {
+				ERROR("can't find .shstrtab or .strtab");
+				return NULL;
+			}
+		}
+		sec->sh.sh_name =3D elf_add_string(elf, shstrtab, sec->name);
+		if (sec->sh.sh_name =3D=3D -1)
+			return NULL;
+
+		elf_hash_add(section_name, &sec->name_hash, str_hash(sec->name));
 	}
-	sec->sh.sh_name =3D elf_add_string(elf, shstrtab, sec->name);
-	if (sec->sh.sh_name =3D=3D -1)
-		return NULL;
=20
+add:
 	list_add_tail(&sec->list, &elf->sections);
 	elf_hash_add(section, &sec->hash, sec->idx);
-	elf_hash_add(section_name, &sec->name_hash, str_hash(sec->name));
=20
 	mark_sec_changed(elf, sec, true);
=20
 	return sec;
 }
=20
-static struct section *elf_create_rela_section(struct elf *elf,
-					       struct section *sec,
-					       unsigned int reloc_nr)
+struct section *elf_create_rela_section(struct elf *elf, struct section *sec,
+					unsigned int reloc_nr)
 {
 	struct section *rsec;
 	char *rsec_name;
@@ -1232,22 +1244,23 @@ static struct section *elf_create_rela_section(struct=
 elf *elf,
 	strcpy(rsec_name, ".rela");
 	strcat(rsec_name, sec->name);
=20
-	rsec =3D elf_create_section(elf, rsec_name, elf_rela_size(elf), reloc_nr);
+	rsec =3D elf_create_section(elf, rsec_name, reloc_nr * elf_rela_size(elf),
+				  elf_rela_size(elf), SHT_RELA, elf_addr_size(elf),
+				  SHF_INFO_LINK);
 	free(rsec_name);
 	if (!rsec)
 		return NULL;
=20
-	rsec->data->d_type =3D ELF_T_RELA;
-	rsec->sh.sh_type =3D SHT_RELA;
-	rsec->sh.sh_addralign =3D elf_addr_size(elf);
 	rsec->sh.sh_link =3D find_section_by_name(elf, ".symtab")->idx;
 	rsec->sh.sh_info =3D sec->idx;
-	rsec->sh.sh_flags =3D SHF_INFO_LINK;
=20
-	rsec->relocs =3D calloc(sec_num_entries(rsec), sizeof(struct reloc));
-	if (!rsec->relocs) {
-		ERROR_GLIBC("calloc");
-		return NULL;
+	if (reloc_nr) {
+		rsec->data->d_type =3D ELF_T_RELA;
+		rsec->relocs =3D calloc(sec_num_entries(rsec), sizeof(struct reloc));
+		if (!rsec->relocs) {
+			ERROR_GLIBC("calloc");
+			return NULL;
+		}
 	}
=20
 	sec->rsec =3D rsec;
@@ -1262,7 +1275,8 @@ struct section *elf_create_section_pair(struct elf *elf=
, const char *name,
 {
 	struct section *sec;
=20
-	sec =3D elf_create_section(elf, name, entsize, nr);
+	sec =3D elf_create_section(elf, name, nr * entsize, entsize,
+				 SHT_PROGBITS, 1, SHF_ALLOC);
 	if (!sec)
 		return NULL;
=20
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objt=
ool/elf.h
index c33b8fa..badb109 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -117,11 +117,16 @@ struct elf {
 struct elf *elf_open_read(const char *name, int flags);
=20
 struct section *elf_create_section(struct elf *elf, const char *name,
-				   size_t entsize, unsigned int nr);
+				   size_t size, size_t entsize,
+				   unsigned int type, unsigned int align,
+				   unsigned int flags);
 struct section *elf_create_section_pair(struct elf *elf, const char *name,
 					size_t entsize, unsigned int nr,
 					unsigned int reloc_nr);
=20
+struct section *elf_create_rela_section(struct elf *elf, struct section *sec,
+					unsigned int reloc_nr);
+
 struct symbol *elf_create_symbol(struct elf *elf, const char *name,
 				 struct section *sec, unsigned int bind,
 				 unsigned int type, unsigned long offset,
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 6eff3d6..9d380ab 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -127,7 +127,11 @@ int orc_create(struct objtool_file *file)
 		return -1;
 	}
 	orc_sec =3D elf_create_section(file->elf, ".orc_unwind",
-				     sizeof(struct orc_entry), nr);
+				     nr * sizeof(struct orc_entry),
+				     sizeof(struct orc_entry),
+				     SHT_PROGBITS,
+				     1,
+				     SHF_ALLOC);
 	if (!orc_sec)
 		return -1;
=20

