Return-Path: <linux-tip-commits+bounces-6884-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5561ABE28C4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2ADC1A62808
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DBF32E73B;
	Thu, 16 Oct 2025 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nqRbB+N/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sn4z7Stc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2F231E0E6;
	Thu, 16 Oct 2025 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608376; cv=none; b=cNL/UKhb/F0Ko+dcFy/CKIznZ1hPZTru7fQl66GVEmVlHOl3JqWMX/FrUTcE6/aAB+Ra8/manPCBxoQqEBvrMUf3ImhTLWZcl+RjuZDjmRGlhObor9fBKoLhfJX6CdesVXCRrxJDP7LF3isjxtfJo4OYzTf4OciqOSh6Gv8BfCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608376; c=relaxed/simple;
	bh=9Uik6KbqSqgDUh3fAZymvR1zt8AUU6HN3Pzlacx9JZA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=gHvSBmlliYvdtqhwj/VmupkrYEPA5K4EyhDEn9nVwZMoU1gL354HKGoqoxH1F1GngXP0dEKiHcbuTy/ZpFJPigqBCHcL1k/p0rPwjw9ZK9zo0ajMj7FodSxNJeThllMOmjaRxTtuMCz7geXuxhBKAwOp+Q5tTxGb+OqLg9zQHHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nqRbB+N/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sn4z7Stc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608349;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=YI0dbpBAvJfBGTQQYv5T+7pSte0WQoFl4AOdfUD3eLA=;
	b=nqRbB+N/pPtHVHmNXS4KkkKYCuSb9tqvIbMAbDTgvInL53syyE8W0JS1O47TkvEEd6LHtN
	zLNcDpT4GqjbbOtStg5lv0iGcabUwZDeAS467eH9aBQCY8+4kfqfmrBpSNElZ8kvji9w3U
	Txdkn4Qjzaoxc1fBADcJqZXAQcJpBNA9aws5ABUCpYuKbMVOhaPWOIuZxii3vc3/TFkRjY
	qz9T9/D40FiKrq5Lj0Uv7sJVlMNKLd/NlPGx2a0R9igRV3bI5p9+WYqXMsF19I+ZoJ/4pv
	B/I41vsEomr2c1MIkTO52CrlzxLwKaqJ/FeTUcDs1KGsVbG9oMZWZ7mglCw4/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608349;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=YI0dbpBAvJfBGTQQYv5T+7pSte0WQoFl4AOdfUD3eLA=;
	b=Sn4z7Stc6TrybNMuAFwi8NejKJlfN1rGXQcJSZeCywH8k+Wp3dVnll4lDpYixH6o2xcmgS
	DtLFrN2ioW9bc4AQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Add elf_create_reloc() and elf_init_reloc()
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060834790.709179.6492415701870973683.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2c05ca02621837af7cd8fab6ae7421b9cd5dff6e
Gitweb:        https://git.kernel.org/tip/2c05ca02621837af7cd8fab6ae7421b9cd5=
dff6e
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:50 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:46:49 -07:00

objtool: Add elf_create_reloc() and elf_init_reloc()

elf_create_rela_section() is quite limited in that it requires the
caller to know how many relocations need to be allocated up front.

In preparation for the objtool klp diff subcommand, allow an arbitrary
number of relocations to be created and initialized on demand after
section creation.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c                 | 170 ++++++++++++++++++++++++---
 tools/objtool/include/objtool/elf.h |   9 +-
 2 files changed, 165 insertions(+), 14 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 117a1b5..8d01fc3 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -22,6 +22,8 @@
 #include <objtool/warn.h>
=20
 #define ALIGN_UP(x, align_to) (((x) + ((align_to)-1)) & ~((align_to)-1))
+#define ALIGN_UP_POW2(x) (1U << ((8 * sizeof(x)) - __builtin_clz((x) - 1U)))
+#define MAX(a, b) ((a) > (b) ? (a) : (b))
=20
 static inline u32 str_hash(const char *str)
 {
@@ -899,10 +901,9 @@ elf_create_prefix_symbol(struct elf *elf, struct symbol =
*orig, size_t size)
 				 offset, size);
 }
=20
-static struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
-				    unsigned int reloc_idx,
-				    unsigned long offset, struct symbol *sym,
-				    s64 addend, unsigned int type)
+struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
+			     unsigned int reloc_idx, unsigned long offset,
+			     struct symbol *sym, s64 addend, unsigned int type)
 {
 	struct reloc *reloc, empty =3D { 0 };
=20
@@ -1004,12 +1005,16 @@ static int read_relocs(struct elf *elf)
=20
 		rsec->base->rsec =3D rsec;
=20
-		nr_reloc =3D 0;
+		/* nr_alloc_relocs=3D0: libelf owns d_buf */
+		rsec->nr_alloc_relocs =3D 0;
+
 		rsec->relocs =3D calloc(sec_num_entries(rsec), sizeof(*reloc));
 		if (!rsec->relocs) {
 			ERROR_GLIBC("calloc");
 			return -1;
 		}
+
+		nr_reloc =3D 0;
 		for (i =3D 0; i < sec_num_entries(rsec); i++) {
 			reloc =3D &rsec->relocs[i];
=20
@@ -1258,8 +1263,116 @@ add:
 	return sec;
 }
=20
+static int elf_alloc_reloc(struct elf *elf, struct section *rsec)
+{
+	struct reloc *old_relocs, *old_relocs_end, *new_relocs;
+	unsigned int nr_relocs_old =3D sec_num_entries(rsec);
+	unsigned int nr_relocs_new =3D nr_relocs_old + 1;
+	unsigned long nr_alloc;
+	struct symbol *sym;
+
+	if (!rsec->data) {
+		rsec->data =3D elf_newdata(elf_getscn(elf->elf, rsec->idx));
+		if (!rsec->data) {
+			ERROR_ELF("elf_newdata");
+			return -1;
+		}
+
+		rsec->data->d_align =3D 1;
+		rsec->data->d_type =3D ELF_T_RELA;
+		rsec->data->d_buf =3D NULL;
+	}
+
+	rsec->data->d_size =3D nr_relocs_new * elf_rela_size(elf);
+	rsec->sh.sh_size   =3D rsec->data->d_size;
+
+	nr_alloc =3D MAX(64, ALIGN_UP_POW2(nr_relocs_new));
+	if (nr_alloc <=3D rsec->nr_alloc_relocs)
+		return 0;
+
+	if (rsec->data->d_buf && !rsec->nr_alloc_relocs) {
+		void *orig_buf =3D rsec->data->d_buf;
+
+		/*
+		 * The original d_buf is owned by libelf so it can't be
+		 * realloced.
+		 */
+		rsec->data->d_buf =3D malloc(nr_alloc * elf_rela_size(elf));
+		if (!rsec->data->d_buf) {
+			ERROR_GLIBC("malloc");
+			return -1;
+		}
+		memcpy(rsec->data->d_buf, orig_buf,
+		       nr_relocs_old * elf_rela_size(elf));
+	} else {
+		rsec->data->d_buf =3D realloc(rsec->data->d_buf,
+					    nr_alloc * elf_rela_size(elf));
+		if (!rsec->data->d_buf) {
+			ERROR_GLIBC("realloc");
+			return -1;
+		}
+	}
+
+	rsec->nr_alloc_relocs =3D nr_alloc;
+
+	old_relocs =3D rsec->relocs;
+	new_relocs =3D calloc(nr_alloc, sizeof(struct reloc));
+	if (!new_relocs) {
+		ERROR_GLIBC("calloc");
+		return -1;
+	}
+
+	if (!old_relocs)
+		goto done;
+
+	/*
+	 * The struct reloc's address has changed.  Update all the symbols and
+	 * relocs which reference it.
+	 */
+
+	old_relocs_end =3D &old_relocs[nr_relocs_old];
+	for_each_sym(elf, sym) {
+		struct reloc *reloc;
+
+		reloc =3D sym->relocs;
+		if (!reloc)
+			continue;
+
+		if (reloc >=3D old_relocs && reloc < old_relocs_end)
+			sym->relocs =3D &new_relocs[reloc - old_relocs];
+
+		while (1) {
+			struct reloc *next_reloc =3D sym_next_reloc(reloc);
+
+			if (!next_reloc)
+				break;
+
+			if (next_reloc >=3D old_relocs && next_reloc < old_relocs_end)
+				set_sym_next_reloc(reloc, &new_relocs[next_reloc - old_relocs]);
+
+			reloc =3D next_reloc;
+		}
+	}
+
+	memcpy(new_relocs, old_relocs, nr_relocs_old * sizeof(struct reloc));
+
+	for (int i =3D 0; i < nr_relocs_old; i++) {
+		struct reloc *old =3D &old_relocs[i];
+		struct reloc *new =3D &new_relocs[i];
+		u32 key =3D reloc_hash(old);
+
+		elf_hash_del(reloc, &old->hash, key);
+		elf_hash_add(reloc, &new->hash, key);
+	}
+
+	free(old_relocs);
+done:
+	rsec->relocs =3D new_relocs;
+	return 0;
+}
+
 struct section *elf_create_rela_section(struct elf *elf, struct section *sec,
-					unsigned int reloc_nr)
+					unsigned int nr_relocs)
 {
 	struct section *rsec;
 	char *rsec_name;
@@ -1272,34 +1385,63 @@ struct section *elf_create_rela_section(struct elf *e=
lf, struct section *sec,
 	strcpy(rsec_name, ".rela");
 	strcat(rsec_name, sec->name);
=20
-	rsec =3D elf_create_section(elf, rsec_name, reloc_nr * elf_rela_size(elf),
+	rsec =3D elf_create_section(elf, rsec_name, nr_relocs * elf_rela_size(elf),
 				  elf_rela_size(elf), SHT_RELA, elf_addr_size(elf),
 				  SHF_INFO_LINK);
 	free(rsec_name);
 	if (!rsec)
 		return NULL;
=20
-	rsec->sh.sh_link =3D find_section_by_name(elf, ".symtab")->idx;
-	rsec->sh.sh_info =3D sec->idx;
-
-	if (reloc_nr) {
+	if (nr_relocs) {
 		rsec->data->d_type =3D ELF_T_RELA;
-		rsec->relocs =3D calloc(sec_num_entries(rsec), sizeof(struct reloc));
+
+		rsec->nr_alloc_relocs =3D nr_relocs;
+		rsec->relocs =3D calloc(nr_relocs, sizeof(struct reloc));
 		if (!rsec->relocs) {
 			ERROR_GLIBC("calloc");
 			return NULL;
 		}
 	}
=20
+	rsec->sh.sh_link =3D find_section_by_name(elf, ".symtab")->idx;
+	rsec->sh.sh_info =3D sec->idx;
+
 	sec->rsec =3D rsec;
 	rsec->base =3D sec;
=20
 	return rsec;
 }
=20
+struct reloc *elf_create_reloc(struct elf *elf, struct section *sec,
+			       unsigned long offset,
+			       struct symbol *sym, s64 addend,
+			       unsigned int type)
+{
+	struct section *rsec =3D sec->rsec;
+
+	if (!rsec) {
+		rsec =3D elf_create_rela_section(elf, sec, 0);
+		if (!rsec)
+			return NULL;
+	}
+
+	if (find_reloc_by_dest(elf, sec, offset)) {
+		ERROR_FUNC(sec, offset, "duplicate reloc");
+		return NULL;
+	}
+
+	if (elf_alloc_reloc(elf, rsec))
+		return NULL;
+
+	mark_sec_changed(elf, rsec, true);
+
+	return elf_init_reloc(elf, rsec, sec_num_entries(rsec) - 1, offset, sym,
+			      addend, type);
+}
+
 struct section *elf_create_section_pair(struct elf *elf, const char *name,
 					size_t entsize, unsigned int nr,
-					unsigned int reloc_nr)
+					unsigned int nr_relocs)
 {
 	struct section *sec;
=20
@@ -1308,7 +1450,7 @@ struct section *elf_create_section_pair(struct elf *elf=
, const char *name,
 	if (!sec)
 		return NULL;
=20
-	if (!elf_create_rela_section(elf, sec, reloc_nr))
+	if (!elf_create_rela_section(elf, sec, nr_relocs))
 		return NULL;
=20
 	return sec;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objt=
ool/elf.h
index 0d9aeef..999fd93 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -47,6 +47,7 @@ struct section {
 	int idx;
 	bool _changed, text, rodata, noinstr, init, truncate;
 	struct reloc *relocs;
+	unsigned long nr_alloc_relocs;
 };
=20
 struct symbol {
@@ -140,6 +141,14 @@ void *elf_add_data(struct elf *elf, struct section *sec,=
 const void *data,
=20
 unsigned int elf_add_string(struct elf *elf, struct section *strtab, const c=
har *str);
=20
+struct reloc *elf_create_reloc(struct elf *elf, struct section *sec,
+			       unsigned long offset, struct symbol *sym,
+			       s64 addend, unsigned int type);
+
+struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
+			     unsigned int reloc_idx, unsigned long offset,
+			     struct symbol *sym, s64 addend, unsigned int type);
+
 struct reloc *elf_init_reloc_text_sym(struct elf *elf, struct section *sec,
 				      unsigned long offset,
 				      unsigned int reloc_idx,

