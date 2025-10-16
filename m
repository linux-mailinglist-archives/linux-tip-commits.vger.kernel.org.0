Return-Path: <linux-tip-commits+bounces-6926-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C9ABE2A36
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04391582A8B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D5533EB1B;
	Thu, 16 Oct 2025 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lNivbs4o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aTD6qM2N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527DE31BC96;
	Thu, 16 Oct 2025 09:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608420; cv=none; b=eeXnuwXMEdNmazQkM2LzfZhacdweX41o0DALoUiZOM/o2nfdT8/bjrWAnCEp7ApYh+c2G+pusaUJBTUNsEj7ydwXd2VD8FehVtLPc6eaxsOTwuO4NBqwpFCkvbAsU0mhU0Dj+B859kwZzuhfJVgozUF+2yN5IVZVHUGilkpwWcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608420; c=relaxed/simple;
	bh=/0HyRYwwKF5PvYRIOt1N1bNhLUGjAavLd8y1qWu9McM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=KkQ2UElUe6w3uFAMdo6XcHWG+JcbNq2LZI62V5dktZn6Dg9tyo8g0s9LrE2nHAapyDoFxTYkuLyflQ2E8i3airNdAWT4lNRatMqDcNbGqNAG+od8+PH2CH+LwutTI6q6DtfzZ1NFoq27loOy8taE7bEYiKoAjkBZ7Acfh0pt0Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lNivbs4o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aTD6qM2N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608350;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=uIRqfVojRIe5A/bkbLuMaUK6Hy/ynk2OEVkdYIrsxrI=;
	b=lNivbs4o+JLo7WQ6K/vJFECe4uN+7xLBo9PvgOQDGkfyk9ipAawEGzShzuWevTMC0GH3sj
	KnFjAxind4HbGBseZNrtxSjQTeyr0x0LXoAGI4jAWMQekf6HiB82H3ShDoR/QcfGs9dN4s
	HQkDbd5CLMuv2ht3mGzucieSYyNBTksNebU5ZJ1CUWQXRFiwf8EU7r7CthLp1M6X3z+iRd
	MtcdwR1NUqOvTpAOOo2FAqdhFRjBQrkszoPN+H6wsFto7mpDWO8P0Vg6Mkf52ZZz1dGmFC
	S990CNAMPiQaINo/Ysrv3vgCPVwPewKCZo/ZmEkfTMB1aolOCxhbvoyh4i1bFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608350;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=uIRqfVojRIe5A/bkbLuMaUK6Hy/ynk2OEVkdYIrsxrI=;
	b=aTD6qM2NT4qCst9PEmqGjDCGlrOx/vxE/6m7Thauhw5i8fVbGOM0o1bDXyRK7kyIl2a0eC
	6iueE/KuWCvuugDQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add elf_create_data()
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060834932.709179.12492204513424237168.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     431dbabf2d9dd27cd597a9d1d4611e7ae64bf8bd
Gitweb:        https://git.kernel.org/tip/431dbabf2d9dd27cd597a9d1d4611e7ae64=
bf8bd
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:49 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:46:48 -07:00

objtool: Add elf_create_data()

In preparation for the objtool klp diff subcommand, refactor
elf_add_string() by adding a new elf_add_data() helper which allows the
adding of arbitrary data to a section.

Make both interfaces global so they can be used by the upcoming klp diff
code.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c                 | 66 +++++++++++++++++++---------
 tools/objtool/include/objtool/elf.h | 10 ++--
 2 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 7a7e63c..117a1b5 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -18,10 +18,11 @@
 #include <errno.h>
 #include <linux/interval_tree_generic.h>
 #include <objtool/builtin.h>
-
 #include <objtool/elf.h>
 #include <objtool/warn.h>
=20
+#define ALIGN_UP(x, align_to) (((x) + ((align_to)-1)) & ~((align_to)-1))
+
 static inline u32 str_hash(const char *str)
 {
 	return jhash(str, strlen(str), 0);
@@ -763,8 +764,6 @@ static int elf_update_symbol(struct elf *elf, struct sect=
ion *symtab,
 	return 0;
 }
=20
-static int elf_add_string(struct elf *elf, struct section *strtab, const cha=
r *str);
-
 struct symbol *elf_create_symbol(struct elf *elf, const char *name,
 				 struct section *sec, unsigned int bind,
 				 unsigned int type, unsigned long offset,
@@ -1100,11 +1099,9 @@ err:
 	return NULL;
 }
=20
-static int elf_add_string(struct elf *elf, struct section *strtab, const cha=
r *str)
+unsigned int elf_add_string(struct elf *elf, struct section *strtab, const c=
har *str)
 {
-	Elf_Data *data;
-	Elf_Scn *s;
-	int len;
+	unsigned int offset;
=20
 	if (!strtab)
 		strtab =3D find_section_by_name(elf, ".strtab");
@@ -1113,28 +1110,59 @@ static int elf_add_string(struct elf *elf, struct sec=
tion *strtab, const char *s
 		return -1;
 	}
=20
-	s =3D elf_getscn(elf->elf, strtab->idx);
+	if (!strtab->sh.sh_addralign) {
+		ERROR("'%s': invalid sh_addralign", strtab->name);
+		return -1;
+	}
+
+	offset =3D ALIGN_UP(strtab->sh.sh_size, strtab->sh.sh_addralign);
+
+	if (!elf_add_data(elf, strtab, str, strlen(str) + 1))
+		return -1;
+
+	return offset;
+}
+
+void *elf_add_data(struct elf *elf, struct section *sec, const void *data, s=
ize_t size)
+{
+	unsigned long offset;
+	Elf_Scn *s;
+
+	if (!sec->sh.sh_addralign) {
+		ERROR("'%s': invalid sh_addralign", sec->name);
+		return NULL;
+	}
+
+	s =3D elf_getscn(elf->elf, sec->idx);
 	if (!s) {
 		ERROR_ELF("elf_getscn");
-		return -1;
+		return NULL;
 	}
=20
-	data =3D elf_newdata(s);
-	if (!data) {
+	sec->data =3D elf_newdata(s);
+	if (!sec->data) {
 		ERROR_ELF("elf_newdata");
-		return -1;
+		return NULL;
 	}
=20
-	data->d_buf =3D strdup(str);
-	data->d_size =3D strlen(str) + 1;
-	data->d_align =3D 1;
+	sec->data->d_buf =3D calloc(1, size);
+	if (!sec->data->d_buf) {
+		ERROR_GLIBC("calloc");
+		return NULL;
+	}
=20
-	len =3D strtab->sh.sh_size;
-	strtab->sh.sh_size +=3D data->d_size;
+	if (data)
+		memcpy(sec->data->d_buf, data, size);
=20
-	mark_sec_changed(elf, strtab, true);
+	sec->data->d_size =3D size;
+	sec->data->d_align =3D 1;
+
+	offset =3D ALIGN_UP(sec->sh.sh_size, sec->sh.sh_addralign);
+	sec->sh.sh_size =3D offset + size;
+
+	mark_sec_changed(elf, sec, true);
=20
-	return len;
+	return sec->data->d_buf;
 }
=20
 struct section *elf_create_section(struct elf *elf, const char *name,
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objt=
ool/elf.h
index badb109..0d9aeef 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -135,6 +135,10 @@ struct symbol *elf_create_section_symbol(struct elf *elf=
, struct section *sec);
 struct symbol *elf_create_prefix_symbol(struct elf *elf, struct symbol *orig,
 					size_t size);
=20
+void *elf_add_data(struct elf *elf, struct section *sec, const void *data,
+		   size_t size);
+
+unsigned int elf_add_string(struct elf *elf, struct section *strtab, const c=
har *str);
=20
 struct reloc *elf_init_reloc_text_sym(struct elf *elf, struct section *sec,
 				      unsigned long offset,
@@ -148,9 +152,9 @@ struct reloc *elf_init_reloc_data_sym(struct elf *elf, st=
ruct section *sec,
 				      struct symbol *sym,
 				      s64 addend);
=20
-int elf_write_insn(struct elf *elf, struct section *sec,
-		   unsigned long offset, unsigned int len,
-		   const char *insn);
+int elf_write_insn(struct elf *elf, struct section *sec, unsigned long offse=
t,
+		   unsigned int len, const char *insn);
+
 int elf_write(struct elf *elf);
 void elf_close(struct elf *elf);
=20

