Return-Path: <linux-tip-commits+bounces-6883-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6310BBE28BE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC298350DD5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE4331A540;
	Thu, 16 Oct 2025 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3bhbWHDE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nWthWFaD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A3B31D732;
	Thu, 16 Oct 2025 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608376; cv=none; b=mAaWmmMbACYJCs7Nbozp6tRXPl7U1zPa67svQ7v62aXsK46gImOWxe6lQqFFy2XUWOrJjESXLJXdARtto+8v44ov2cyCFrxL4cq+ylD6z8nrUi0gGW84S2k6AHPgJFHFUAzDsdaoSng9d2CFtuikFG2UVS5Cx8pW38ncK/bcsMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608376; c=relaxed/simple;
	bh=JWbzNnyMs1zRKizRfAu/pPGnkUVX/WjPjmOfhMvpH4o=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=fKf+2gnIKRp+8+mfBt9986TtvRx9t9nkxdWP+ZDhVmrMJ1pjNkTCGn0eksJzD2FYjwU0ZY6tLKOudKF7/HgWzh672WyCJ/vSMcdLcEKeHMVrpBnH27g4cU20Yc29UZdbFaN71Xcj77JJMBzBAuKDVaje9t7z5YtM3r33lNYm1Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3bhbWHDE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nWthWFaD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608335;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=FHt6dBAviloCzT+6mm4oXXOUesDNE3xtkzpr+NirWAY=;
	b=3bhbWHDEB7tHrKWWUF6rBdHBVlm1TlFbBXSsM82ITtpJag2hVx/Hb8xuN0tEDz3SFWhYcq
	vBbzO0tKKOQb7EbBCD8UwZDjbj5pAQLuIMdarN7nV9TyYWUJr4V5bUU6wqrfFHIjgdNHbL
	U75cpyIivLnPiISQ6K7XW17tn4fctgx+1JxOabat4vDKUrEdxLRwxwlYKcCwfUNWwba4Yh
	iNcYBJR+n/Q1OiL08Xl/e30lzTRjwt9Ib0dJFdD8TdJeJUyNqAcIKDcaHaTBCHM4h+ePsu
	IqPZbMPnYZ6xFSQ5/A1luzek+UW3pBz3ctl6f9LS4I984haMMX1nNbAqxWgkLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608335;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=FHt6dBAviloCzT+6mm4oXXOUesDNE3xtkzpr+NirWAY=;
	b=nWthWFaD4xz4SCN3gbRT4aDRaBRq+2xSMP7MiS6dUWo4JLKScKxMxdOUECNOVdNo2qp/aO
	5kmXCN6bfjwvVUBw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool/klp: Add post-link subcommand to finalize
 livepatch modules
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060833394.709179.4407290346061019562.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     ebe864b55304f74c4e1a8b6c899e34446b2be424
Gitweb:        https://git.kernel.org/tip/ebe864b55304f74c4e1a8b6c899e34446b2=
be424
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:04:01 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:50:18 -07:00

objtool/klp: Add post-link subcommand to finalize livepatch modules

Livepatch needs some ELF magic which linkers don't like:

  - Two relocation sections (.rela*, .klp.rela*) for the same text
    section.

  - Use of SHN_LIVEPATCH to mark livepatch symbols.

Unfortunately linkers tend to mangle such things.  To work around that,
klp diff generates a linker-compliant intermediate binary which encodes
the relevant KLP section/reloc/symbol metadata.

After module linking, the .ko then needs to be converted to an actual
livepatch module.  Introduce a new klp post-link subcommand to do so.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/Build                 |   2 +-
 tools/objtool/builtin-klp.c         |   1 +-
 tools/objtool/include/objtool/klp.h |   4 +-
 tools/objtool/klp-post-link.c       | 168 +++++++++++++++++++++++++++-
 4 files changed, 174 insertions(+), 1 deletion(-)
 create mode 100644 tools/objtool/klp-post-link.c

diff --git a/tools/objtool/Build b/tools/objtool/Build
index 0b01657..8cd71b9 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -9,7 +9,7 @@ objtool-y +=3D elf.o
 objtool-y +=3D objtool.o
=20
 objtool-$(BUILD_ORC) +=3D orc_gen.o orc_dump.o
-objtool-$(BUILD_KLP) +=3D builtin-klp.o klp-diff.o
+objtool-$(BUILD_KLP) +=3D builtin-klp.o klp-diff.o klp-post-link.o
=20
 objtool-y +=3D libstring.o
 objtool-y +=3D libctype.o
diff --git a/tools/objtool/builtin-klp.c b/tools/objtool/builtin-klp.c
index 9b13dd1..56d5a5b 100644
--- a/tools/objtool/builtin-klp.c
+++ b/tools/objtool/builtin-klp.c
@@ -14,6 +14,7 @@ struct subcmd {
=20
 static struct subcmd subcmds[] =3D {
 	{ "diff",		"Generate binary diff of two object files",		cmd_klp_diff, },
+	{ "post-link",		"Finalize klp symbols/relocs after module linking",	cmd_klp=
_post_link, },
 };
=20
 static void cmd_klp_usage(void)
diff --git a/tools/objtool/include/objtool/klp.h b/tools/objtool/include/objt=
ool/klp.h
index 07928fa..ad830a7 100644
--- a/tools/objtool/include/objtool/klp.h
+++ b/tools/objtool/include/objtool/klp.h
@@ -2,6 +2,9 @@
 #ifndef _OBJTOOL_KLP_H
 #define _OBJTOOL_KLP_H
=20
+#define SHF_RELA_LIVEPATCH	0x00100000
+#define SHN_LIVEPATCH		0xff20
+
 /*
  * __klp_objects and __klp_funcs are created by klp diff and used by the pat=
ch
  * module init code to build the klp_patch, klp_object and klp_func structs
@@ -27,5 +30,6 @@ struct klp_reloc {
 };
=20
 int cmd_klp_diff(int argc, const char **argv);
+int cmd_klp_post_link(int argc, const char **argv);
=20
 #endif /* _OBJTOOL_KLP_H */
diff --git a/tools/objtool/klp-post-link.c b/tools/objtool/klp-post-link.c
new file mode 100644
index 0000000..c013e39
--- /dev/null
+++ b/tools/objtool/klp-post-link.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Read the intermediate KLP reloc/symbol representations created by klp diff
+ * and convert them to the proper format required by livepatch.  This needs =
to
+ * run last to avoid linker wreckage.  Linkers don't tend to handle the "two
+ * rela sections for a single base section" case very well, nor do they like
+ * SHN_LIVEPATCH.
+ *
+ * This is the final tool in the livepatch module generation pipeline:
+ *
+ *   kernel builds -> objtool klp diff -> module link -> objtool klp post-li=
nk
+ */
+
+#include <fcntl.h>
+#include <gelf.h>
+#include <objtool/objtool.h>
+#include <objtool/warn.h>
+#include <objtool/klp.h>
+#include <objtool/util.h>
+#include <linux/livepatch_external.h>
+
+static int fix_klp_relocs(struct elf *elf)
+{
+	struct section *symtab, *klp_relocs;
+
+	klp_relocs =3D find_section_by_name(elf, KLP_RELOCS_SEC);
+	if (!klp_relocs)
+		return 0;
+
+	symtab =3D find_section_by_name(elf, ".symtab");
+	if (!symtab) {
+		ERROR("missing .symtab");
+		return -1;
+	}
+
+	for (int i =3D 0; i < sec_size(klp_relocs) / sizeof(struct klp_reloc); i++)=
 {
+		struct klp_reloc *klp_reloc;
+		unsigned long klp_reloc_off;
+		struct section *sec, *tmp, *klp_rsec;
+		unsigned long offset;
+		struct reloc *reloc;
+		char sym_modname[64];
+		char rsec_name[SEC_NAME_LEN];
+		u64 addend;
+		struct symbol *sym, *klp_sym;
+
+		klp_reloc_off =3D i * sizeof(*klp_reloc);
+		klp_reloc =3D klp_relocs->data->d_buf + klp_reloc_off;
+
+		/*
+		 * Read __klp_relocs[i]:
+		 */
+
+		/* klp_reloc.sec_offset */
+		reloc =3D find_reloc_by_dest(elf, klp_relocs,
+					   klp_reloc_off + offsetof(struct klp_reloc, offset));
+		if (!reloc) {
+			ERROR("malformed " KLP_RELOCS_SEC " section");
+			return -1;
+		}
+
+		sec =3D reloc->sym->sec;
+		offset =3D reloc_addend(reloc);
+
+		/* klp_reloc.sym */
+		reloc =3D find_reloc_by_dest(elf, klp_relocs,
+					   klp_reloc_off + offsetof(struct klp_reloc, sym));
+		if (!reloc) {
+			ERROR("malformed " KLP_RELOCS_SEC " section");
+			return -1;
+		}
+
+		klp_sym =3D reloc->sym;
+		addend =3D reloc_addend(reloc);
+
+		/* symbol format: .klp.sym.modname.sym_name,sympos */
+		if (sscanf(klp_sym->name + strlen(KLP_SYM_PREFIX), "%55[^.]", sym_modname)=
 !=3D 1)
+			ERROR("can't find modname in klp symbol '%s'", klp_sym->name);
+
+		/*
+		 * Create the KLP rela:
+		 */
+
+		/* section format: .klp.rela.sec_objname.section_name */
+		if (snprintf_check(rsec_name, SEC_NAME_LEN,
+				   KLP_RELOC_SEC_PREFIX "%s.%s",
+				   sym_modname, sec->name))
+			return -1;
+
+		klp_rsec =3D find_section_by_name(elf, rsec_name);
+		if (!klp_rsec) {
+			klp_rsec =3D elf_create_section(elf, rsec_name, 0,
+						      elf_rela_size(elf),
+						      SHT_RELA, elf_addr_size(elf),
+						      SHF_ALLOC | SHF_INFO_LINK | SHF_RELA_LIVEPATCH);
+			if (!klp_rsec)
+				return -1;
+
+			klp_rsec->sh.sh_link =3D symtab->idx;
+			klp_rsec->sh.sh_info =3D sec->idx;
+			klp_rsec->base =3D sec;
+		}
+
+		tmp =3D sec->rsec;
+		sec->rsec =3D klp_rsec;
+		if (!elf_create_reloc(elf, sec, offset, klp_sym, addend, klp_reloc->type))
+			return -1;
+		sec->rsec =3D tmp;
+
+		/*
+		 * Fix up the corresponding KLP symbol:
+		 */
+
+		klp_sym->sym.st_shndx =3D SHN_LIVEPATCH;
+		if (!gelf_update_sym(symtab->data, klp_sym->idx, &klp_sym->sym)) {
+			ERROR_ELF("gelf_update_sym");
+			return -1;
+		}
+
+		/*
+		 * Disable the original non-KLP reloc by converting it to R_*_NONE:
+		 */
+
+		reloc =3D find_reloc_by_dest(elf, sec, offset);
+		sym =3D reloc->sym;
+		sym->sym.st_shndx =3D SHN_LIVEPATCH;
+		set_reloc_type(elf, reloc, 0);
+		if (!gelf_update_sym(symtab->data, sym->idx, &sym->sym)) {
+			ERROR_ELF("gelf_update_sym");
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * This runs on the livepatch module after all other linking has been done. =
 It
+ * converts the intermediate __klp_relocs section into proper KLP relocs to =
be
+ * processed by livepatch.  This needs to run last to avoid linker wreckage.
+ * Linkers don't tend to handle the "two rela sections for a single base
+ * section" case very well, nor do they appreciate SHN_LIVEPATCH.
+ */
+int cmd_klp_post_link(int argc, const char **argv)
+{
+	struct elf *elf;
+
+	argc--;
+	argv++;
+
+	if (argc !=3D 1) {
+		fprintf(stderr, "%d\n", argc);
+		fprintf(stderr, "usage: objtool link <file.ko>\n");
+		return -1;
+	}
+
+	elf =3D elf_open_read(argv[0], O_RDWR);
+	if (!elf)
+		return -1;
+
+	if (fix_klp_relocs(elf))
+		return -1;
+
+	if (elf_write(elf))
+		return -1;
+
+	return elf_close(elf);
+}

