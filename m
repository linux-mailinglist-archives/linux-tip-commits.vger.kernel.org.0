Return-Path: <linux-tip-commits+bounces-6875-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3433CBE289A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8DB1A62750
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB1332C336;
	Thu, 16 Oct 2025 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z01vvzUL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+seQvQJo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94D531D72B;
	Thu, 16 Oct 2025 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608362; cv=none; b=ivM74rlzESEujtpTk6RjUNJz7LcTxmYXL3splXUE79nRzuxxZZQWUMc0nL8J9zXRmqBZgg0gbFS6+J3lmivSqjGGGhc2Dpk42rf4b8UgdrfLi3BXrtRgvxnrBwxGR+kZgh36+EkCRBbq8b1Zm9sH5dWwzVhEmvfBIWx69BWaUD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608362; c=relaxed/simple;
	bh=Wn7AOcAbzQjLIoGFIG1dcQ9gYdgwckVX8QImnPRZR1U=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=QfC4ofSEtDAn9jzpdlyL0ke04+LwvO62aDpreLynw/muo52eWJCHctPKMVbSp8/iaIVcOcwvajTjQ8iEc1Qf0+ddl4gcrhPj+b3NrWZ0V9aVlvJPuXMnO2czN3oFI3wF8t3smX5pCqZppCoW8XgzQcWu0J3I9VQRIRU9U/9rjVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z01vvzUL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+seQvQJo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608336;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=FpvNjFD+dz1MsswHjjVEjjKf/5WsilFdhwh/v8rpJMU=;
	b=z01vvzULsQtbeNbaHr8LkdhMDYs+hiQ/iDSDneyQgs+DYTlJKQxFh4kZh9pXTnxeFMPJOd
	Jf+sWqVtbCB7ob2/T4YK3YTCBoEUIpf0gsSghPzMyNWeN4F0y57jaSR+YhWfFStpFKYvf+
	vFfAwjVxXWpHkjNdq+CkpSVM94VFMEdN8b8ZNhmL8PsosR0M9S5BJ3SlcBL0uLS8A6uqHb
	d4l3ujfrAJveYwIuteH/YGur4KytNveWzPXg4GhvIjHjXKSAZr+d/Ljd+xkzUybGVWcS9N
	MTsKeHmSVx9axVhMRkm+ScZoSDjMUffqNfcMeqZ/EgwmGZ/d7C+AHQSs5evzcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608336;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=FpvNjFD+dz1MsswHjjVEjjKf/5WsilFdhwh/v8rpJMU=;
	b=+seQvQJo6KG1ojYWqtmCKC1f/b4hcXkz1Q0MMfamwWDcPsrTYhqrGqSTndVre3CgF1p9eu
	ehhzt6ffqv9f3iDw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool/klp: Add --debug option to show cloning decisions
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060833509.709179.4619457534479145477.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     7c2575a6406fb85946b05d8dcc856686d3156354
Gitweb:        https://git.kernel.org/tip/7c2575a6406fb85946b05d8dcc856686d31=
56354
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:04:00 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:50:18 -07:00

objtool/klp: Add --debug option to show cloning decisions

Add a --debug option to klp diff which prints cloning decisions and an
indented dependency tree for all cloned symbols and relocations.  This
helps visualize which symbols and relocations were included and why.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/include/objtool/warn.h | 21 ++++++++-
 tools/objtool/klp-diff.c             | 75 +++++++++++++++++++++++++++-
 tools/objtool/objtool.c              |  3 +-
 3 files changed, 99 insertions(+)

diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/obj=
tool/warn.h
index 29173a1..e88322d 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -102,6 +102,10 @@ static inline char *offstr(struct section *sec, unsigned=
 long offset)
 #define ERROR_FUNC(sec, offset, format, ...) __WARN_FUNC(ERROR_STR, sec, off=
set, format, ##__VA_ARGS__)
 #define ERROR_INSN(insn, format, ...) WARN_FUNC(insn->sec, insn->offset, for=
mat, ##__VA_ARGS__)
=20
+extern bool debug;
+extern int indent;
+
+static inline void unindent(int *unused) { indent--; }
=20
 #define __dbg(format, ...)						\
 	fprintf(stderr,							\
@@ -110,6 +114,23 @@ static inline char *offstr(struct section *sec, unsigned=
 long offset)
 		objname ? ": " : "",					\
 		##__VA_ARGS__)
=20
+#define dbg(args...)							\
+({									\
+	if (unlikely(debug))						\
+		__dbg(args);						\
+})
+
+#define __dbg_indent(format, ...)					\
+({									\
+	if (unlikely(debug))						\
+		__dbg("%*s" format, indent * 8, "", ##__VA_ARGS__);	\
+})
+
+#define dbg_indent(args...)						\
+	int __attribute__((cleanup(unindent))) __dummy_##__COUNTER__;	\
+	__dbg_indent(args);						\
+	indent++
+
 #define dbg_checksum(func, insn, checksum)				\
 ({									\
 	if (unlikely(insn->sym && insn->sym->pfunc &&			\
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 0d69b62..817d443 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -38,6 +38,8 @@ static const char * const klp_diff_usage[] =3D {
 };
=20
 static const struct option klp_diff_options[] =3D {
+	OPT_GROUP("Options:"),
+	OPT_BOOLEAN('d', "debug", &debug, "enable debug output"),
 	OPT_END(),
 };
=20
@@ -48,6 +50,38 @@ static inline u32 str_hash(const char *str)
 	return jhash(str, strlen(str), 0);
 }
=20
+static char *escape_str(const char *orig)
+{
+	size_t len =3D 0;
+	const char *a;
+	char *b, *new;
+
+	for (a =3D orig; *a; a++) {
+		switch (*a) {
+		case '\001': len +=3D 5; break;
+		case '\n':
+		case '\t':   len +=3D 2; break;
+		default: len++;
+		}
+	}
+
+	new =3D malloc(len + 1);
+	if (!new)
+		return NULL;
+
+	for (a =3D orig, b =3D new; *a; a++) {
+		switch (*a) {
+		case '\001': memcpy(b, "<SOH>", 5); b +=3D 5; break;
+		case '\n': *b++ =3D '\\'; *b++ =3D 'n'; break;
+		case '\t': *b++ =3D '\\'; *b++ =3D 't'; break;
+		default:   *b++ =3D *a;
+		}
+	}
+
+	*b =3D '\0';
+	return new;
+}
+
 static int read_exports(void)
 {
 	const char *symvers =3D "Module.symvers";
@@ -528,6 +562,28 @@ sym_created:
 	return out_sym;
 }
=20
+static const char *sym_type(struct symbol *sym)
+{
+	switch (sym->type) {
+	case STT_NOTYPE:  return "NOTYPE";
+	case STT_OBJECT:  return "OBJECT";
+	case STT_FUNC:    return "FUNC";
+	case STT_SECTION: return "SECTION";
+	case STT_FILE:    return "FILE";
+	default:	  return "UNKNOWN";
+	}
+}
+
+static const char *sym_bind(struct symbol *sym)
+{
+	switch (sym->bind) {
+	case STB_LOCAL:   return "LOCAL";
+	case STB_GLOBAL:  return "GLOBAL";
+	case STB_WEAK:    return "WEAK";
+	default:	  return "UNKNOWN";
+	}
+}
+
 /*
  * Copy a symbol to the output object, optionally including its data and
  * relocations.
@@ -540,6 +596,8 @@ static struct symbol *clone_symbol(struct elfs *e, struct=
 symbol *patched_sym,
 	if (patched_sym->clone)
 		return patched_sym->clone;
=20
+	dbg_indent("%s%s", patched_sym->name, data_too ? " [+DATA]" : "");
+
 	/* Make sure the prefix gets cloned first */
 	if (is_func_sym(patched_sym) && data_too) {
 		pfx =3D get_func_prefix(patched_sym);
@@ -902,6 +960,8 @@ static int clone_reloc_klp(struct elfs *e, struct reloc *=
patched_reloc,
=20
 	klp_sym =3D find_symbol_by_name(e->out, sym_name);
 	if (!klp_sym) {
+		__dbg_indent("%s", sym_name);
+
 		/* STB_WEAK: avoid modpost undefined symbol warnings */
 		klp_sym =3D elf_create_symbol(e->out, sym_name, NULL,
 					    STB_WEAK, patched_sym->type, 0, 0);
@@ -950,6 +1010,17 @@ static int clone_reloc_klp(struct elfs *e, struct reloc=
 *patched_reloc,
 	return 0;
 }
=20
+#define dbg_clone_reloc(sec, offset, patched_sym, addend, export, klp)			\
+	dbg_indent("%s+0x%lx: %s%s0x%lx [%s%s%s%s%s%s]",				\
+		   sec->name, offset, patched_sym->name,				\
+		   addend >=3D 0 ? "+" : "-", labs(addend),				\
+		   sym_type(patched_sym),						\
+		   patched_sym->type =3D=3D STT_SECTION ? "" : " ",				\
+		   patched_sym->type =3D=3D STT_SECTION ? "" : sym_bind(patched_sym),	\
+		   is_undef_sym(patched_sym) ? " UNDEF" : "",				\
+		   export ? " EXPORTED" : "",						\
+		   klp ? " KLP" : "")
+
 /* Copy a reloc and its symbol to the output object */
 static int clone_reloc(struct elfs *e, struct reloc *patched_reloc,
 			struct section *sec, unsigned long offset)
@@ -969,6 +1040,8 @@ static int clone_reloc(struct elfs *e, struct reloc *pat=
ched_reloc,
=20
 	klp =3D klp_reloc_needed(patched_reloc);
=20
+	dbg_clone_reloc(sec, offset, patched_sym, addend, export, klp);
+
 	if (klp) {
 		if (clone_reloc_klp(e, patched_reloc, sec, offset, export))
 			return -1;
@@ -1000,6 +1073,8 @@ static int clone_reloc(struct elfs *e, struct reloc *pa=
tched_reloc,
 	if (is_string_sec(patched_sym->sec)) {
 		const char *str =3D patched_sym->sec->data->d_buf + addend;
=20
+		__dbg_indent("\"%s\"", escape_str(str));
+
 		addend =3D elf_add_string(e->out, out_sym->sec, str);
 		if (addend =3D=3D -1)
 			return -1;
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index c8f611c..3c26ed5 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -16,6 +16,9 @@
 #include <objtool/objtool.h>
 #include <objtool/warn.h>
=20
+bool debug;
+int indent;
+
 static struct objtool_file file;
=20
 struct objtool_file *objtool_open_read(const char *filename)

