Return-Path: <linux-tip-commits+bounces-6877-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF7BBE293D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85420581BE4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFED31B80D;
	Thu, 16 Oct 2025 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h9+fPpPZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ww4NDc7Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E6232142F;
	Thu, 16 Oct 2025 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608367; cv=none; b=u5KnfOkwv+S+WPFzlq+Ulw2b2lduxtAR8aSA2PE2K8E5fZOtHy33RBjEXPNOXxpJZODgDu3CEDwXelcYwH5brfNibDugrpmqI4L7ptl8qrVb7p/M2D8Tl256gz+LlqjArDUqKk56PkIhmvvYNNpSDT3n9yTrF5YAgmgzSKstEnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608367; c=relaxed/simple;
	bh=O/3rW918bU8eus1M5igU61ZJYWmyBqJ8CuNE8621wbI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=QNxN5yl/PGC83Hy40j+t6BhtHNG16owd9yRV3voxteP9yPkEsHcDlCKHW63RBFgUxvJp7GXnsxd5jn2ml7iZxs1EJR5jBBcgyBlRdUUHliKt9kjmVjN0NixP3SpuvD4UTh8dgsSyYy/XEQIXYChW47fEiYKbqCM2h5/SrWnQvrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h9+fPpPZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ww4NDc7Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608340;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9Gq7scUqCV3sYfYEJXKsM/TdeqaIYIBNPFynkpjqI/k=;
	b=h9+fPpPZXa+tvjTYcRinoKz6YZC4zZNANmPAvvduDCaSR78GmMQTS5h/K8j9b/tS6/x/Ee
	7mZznYDx/EJZdFMFtgS8dh/Q+NDh/c6qqusj2ZRJgjrYJVYQ7//yXsaxdqCjMlfJFoj9Lh
	F3bth9ZCfDWM7mWJdpX7D/ix7y+nvNJfIrouWrRSVzpwF4oXLu1O4/4Q2jdgUs2kVgHRas
	mJuxacx8zf86EsrONtjSyuuEVReLvy+YvmI9H7NgvsX02wB/dgrEglnSWx2s1b1laXCHuy
	EKVXb1ZdR8PjfqphQ4dzx+vNI+kwfxHFFUfi54oougWTEoFtb8PcyBAVarvqbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608340;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9Gq7scUqCV3sYfYEJXKsM/TdeqaIYIBNPFynkpjqI/k=;
	b=Ww4NDc7Q/gjFUqzxZTepzor1ViZRc95jJsuPu5rMkHQMvfs2DM7Wkdo1Zkp4lhzCtVQEzU
	5eGJcK/RLTb759Ag==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool/klp: Add --checksum option to generate
 per-function checksums
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060833920.709179.16229611861976601179.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     0d83da43b1e1c8ce19f2bb10f54a0fdf795364f7
Gitweb:        https://git.kernel.org/tip/0d83da43b1e1c8ce19f2bb10f54a0fdf795=
364f7
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:57 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:50:17 -07:00

objtool/klp: Add --checksum option to generate per-function checksums

In preparation for the objtool klp diff subcommand, add a command-line
option to generate a unique checksum for each function.  This will
enable detection of functions which have changed between two versions of
an object file.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/Makefile                         |  38 ++--
 tools/objtool/builtin-check.c                  |  11 +-
 tools/objtool/check.c                          | 141 +++++++++++++++-
 tools/objtool/elf.c                            |  46 ++++-
 tools/objtool/include/objtool/builtin.h        |   5 +-
 tools/objtool/include/objtool/check.h          |   5 +-
 tools/objtool/include/objtool/checksum.h       |  42 +++++-
 tools/objtool/include/objtool/checksum_types.h |  25 +++-
 tools/objtool/include/objtool/elf.h            |   4 +-
 9 files changed, 289 insertions(+), 28 deletions(-)
 create mode 100644 tools/objtool/include/objtool/checksum.h
 create mode 100644 tools/objtool/include/objtool/checksum_types.h

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index fc82d47..958761c 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -2,6 +2,27 @@
 include ../scripts/Makefile.include
 include ../scripts/Makefile.arch
=20
+ifeq ($(SRCARCH),x86)
+	BUILD_ORC    :=3D y
+	ARCH_HAS_KLP :=3D y
+endif
+
+ifeq ($(SRCARCH),loongarch)
+	BUILD_ORC	   :=3D y
+endif
+
+ifeq ($(ARCH_HAS_KLP),y)
+	HAVE_XXHASH =3D $(shell echo "int main() {}" | \
+		      $(HOSTCC) -xc - -o /dev/null -lxxhash 2> /dev/null && echo y || echo=
 n)
+	ifeq ($(HAVE_XXHASH),y)
+		LIBXXHASH_CFLAGS :=3D $(shell $(HOSTPKG_CONFIG) libxxhash --cflags 2>/dev/=
null) \
+				    -DBUILD_KLP
+		LIBXXHASH_LIBS   :=3D $(shell $(HOSTPKG_CONFIG) libxxhash --libs 2>/dev/nu=
ll || echo -lxxhash)
+	endif
+endif
+
+export BUILD_ORC
+
 ifeq ($(srctree),)
 srctree :=3D $(patsubst %/,%,$(dir $(CURDIR)))
 srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
@@ -36,10 +57,10 @@ INCLUDES :=3D -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/objtool/arch/$(SRCARCH)/include \
 	    -I$(LIBSUBCMD_OUTPUT)/include
=20
-OBJTOOL_CFLAGS  :=3D -std=3Dgnu11 -fomit-frame-pointer -O2 -g \
-		   $(WARNINGS) $(INCLUDES) $(LIBELF_FLAGS) $(HOSTCFLAGS)
+OBJTOOL_CFLAGS  :=3D -std=3Dgnu11 -fomit-frame-pointer -O2 -g $(WARNINGS)	\
+		   $(INCLUDES) $(LIBELF_FLAGS) $(LIBXXHASH_CFLAGS) $(HOSTCFLAGS)
=20
-OBJTOOL_LDFLAGS :=3D $(LIBSUBCMD) $(LIBELF_LIBS) $(HOSTLDFLAGS)
+OBJTOOL_LDFLAGS :=3D $(LIBSUBCMD) $(LIBELF_LIBS) $(LIBXXHASH_LIBS) $(HOSTLDF=
LAGS)
=20
 # Allow old libelf to be used:
 elfshdr :=3D $(shell echo '$(pound)include <libelf.h>' | $(HOSTCC) $(OBJTOOL=
_CFLAGS) -x c -E - 2>/dev/null | grep elf_getshdr)
@@ -51,17 +72,6 @@ HOST_OVERRIDES :=3D CC=3D"$(HOSTCC)" LD=3D"$(HOSTLD)" AR=
=3D"$(HOSTAR)"
 AWK =3D awk
 MKDIR =3D mkdir
=20
-BUILD_ORC :=3D n
-
-ifeq ($(SRCARCH),x86)
-	BUILD_ORC :=3D y
-endif
-
-ifeq ($(SRCARCH),loongarch)
-	BUILD_ORC :=3D y
-endif
-
-export BUILD_ORC
 export srctree OUTPUT CFLAGS SRCARCH AWK
 include $(srctree)/tools/build/Makefile.include
=20
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 9969714..14daa13 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -73,6 +73,7 @@ static int parse_hacks(const struct option *opt, const char=
 *str, int unset)
=20
 static const struct option check_options[] =3D {
 	OPT_GROUP("Actions:"),
+	OPT_BOOLEAN(0,		 "checksum", &opts.checksum, "generate per-function checksu=
ms"),
 	OPT_BOOLEAN(0,		 "cfi", &opts.cfi, "annotate kernel control flow integrity =
(kCFI) function preambles"),
 	OPT_CALLBACK_OPTARG('h', "hacks", NULL, NULL, "jump_label,noinstr,skylake",=
 "patch toolchain bugs/limitations", parse_hacks),
 	OPT_BOOLEAN('i',	 "ibt", &opts.ibt, "validate and annotate IBT"),
@@ -160,7 +161,15 @@ static bool opts_valid(void)
 		return false;
 	}
=20
-	if (opts.hack_jump_label	||
+#ifndef BUILD_KLP
+	if (opts.checksum) {
+		ERROR("--checksum not supported; install xxhash-devel and recompile");
+		return false;
+	}
+#endif
+
+	if (opts.checksum		||
+	    opts.hack_jump_label	||
 	    opts.hack_noinstr		||
 	    opts.ibt			||
 	    opts.mcount			||
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 13ccfe0..f5adbd2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -14,6 +14,7 @@
 #include <objtool/check.h>
 #include <objtool/special.h>
 #include <objtool/warn.h>
+#include <objtool/checksum.h>
=20
 #include <linux/objtool_types.h>
 #include <linux/hashtable.h>
@@ -971,6 +972,59 @@ static int create_direct_call_sections(struct objtool_fi=
le *file)
 	return 0;
 }
=20
+#ifdef BUILD_KLP
+static int create_sym_checksum_section(struct objtool_file *file)
+{
+	struct section *sec;
+	struct symbol *sym;
+	unsigned int idx =3D 0;
+	struct sym_checksum *checksum;
+	size_t entsize =3D sizeof(struct sym_checksum);
+
+	sec =3D find_section_by_name(file->elf, ".discard.sym_checksum");
+	if (sec) {
+		if (!opts.dryrun)
+			WARN("file already has .discard.sym_checksum section, skipping");
+
+		return 0;
+	}
+
+	for_each_sym(file->elf, sym)
+		if (sym->csum.checksum)
+			idx++;
+
+	if (!idx)
+		return 0;
+
+	sec =3D elf_create_section_pair(file->elf, ".discard.sym_checksum", entsize,
+				      idx, idx);
+	if (!sec)
+		return -1;
+
+	idx =3D 0;
+	for_each_sym(file->elf, sym) {
+		if (!sym->csum.checksum)
+			continue;
+
+		if (!elf_init_reloc(file->elf, sec->rsec, idx, idx * entsize,
+				    sym, 0, R_TEXT64))
+			return -1;
+
+		checksum =3D (struct sym_checksum *)sec->data->d_buf + idx;
+		checksum->addr =3D 0; /* reloc */
+		checksum->checksum =3D sym->csum.checksum;
+
+		mark_sec_changed(file->elf, sec, true);
+
+		idx++;
+	}
+
+	return 0;
+}
+#else
+static int create_sym_checksum_section(struct objtool_file *file) { return -=
EINVAL; }
+#endif
+
 /*
  * Warnings shouldn't be reported for ignored functions.
  */
@@ -1748,6 +1802,7 @@ static int handle_group_alt(struct objtool_file *file,
 		nop->type =3D INSN_NOP;
 		nop->sym =3D orig_insn->sym;
 		nop->alt_group =3D new_alt_group;
+		nop->fake =3D 1;
 	}
=20
 	if (!special_alt->new_len) {
@@ -2517,6 +2572,14 @@ static void mark_holes(struct objtool_file *file)
 	}
 }
=20
+static bool validate_branch_enabled(void)
+{
+	return opts.stackval ||
+	       opts.orc ||
+	       opts.uaccess ||
+	       opts.checksum;
+}
+
 static int decode_sections(struct objtool_file *file)
 {
 	mark_rodata(file);
@@ -2545,8 +2608,7 @@ static int decode_sections(struct objtool_file *file)
 	 * Must be before add_jump_destinations(), which depends on 'func'
 	 * being set for alternatives, to enable proper sibling call detection.
 	 */
-	if (opts.stackval || opts.orc || opts.uaccess || opts.noinstr ||
-	    opts.hack_jump_label) {
+	if (validate_branch_enabled() || opts.noinstr || opts.hack_jump_label) {
 		if (add_special_section_alts(file))
 			return -1;
 	}
@@ -3518,6 +3580,50 @@ static bool skip_alt_group(struct instruction *insn)
 	return alt_insn->type =3D=3D INSN_CLAC || alt_insn->type =3D=3D INSN_STAC;
 }
=20
+static void checksum_update_insn(struct objtool_file *file, struct symbol *f=
unc,
+				 struct instruction *insn)
+{
+	struct reloc *reloc =3D insn_reloc(file, insn);
+	unsigned long offset;
+	struct symbol *sym;
+
+	if (insn->fake)
+		return;
+
+	checksum_update(func, insn, insn->sec->data->d_buf + insn->offset, insn->le=
n);
+
+	if (!reloc) {
+		struct symbol *call_dest =3D insn_call_dest(insn);
+
+		if (call_dest)
+			checksum_update(func, insn, call_dest->demangled_name,
+					strlen(call_dest->demangled_name));
+		return;
+	}
+
+	sym =3D reloc->sym;
+	offset =3D arch_insn_adjusted_addend(insn, reloc);
+
+	if (is_string_sec(sym->sec)) {
+		char *str;
+
+		str =3D sym->sec->data->d_buf + sym->offset + offset;
+		checksum_update(func, insn, str, strlen(str));
+		return;
+	}
+
+	if (is_sec_sym(sym)) {
+		sym =3D find_symbol_containing(reloc->sym->sec, offset);
+		if (!sym)
+			return;
+
+		offset -=3D sym->offset;
+	}
+
+	checksum_update(func, insn, sym->demangled_name, strlen(sym->demangled_name=
));
+	checksum_update(func, insn, &offset, sizeof(offset));
+}
+
 /*
  * Follow the branch starting at the given instruction, and recursively foll=
ow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
@@ -3538,6 +3644,9 @@ static int validate_branch(struct objtool_file *file, s=
truct symbol *func,
 	while (1) {
 		next_insn =3D next_insn_to_validate(file, insn);
=20
+		if (opts.checksum && func && insn->sec)
+			checksum_update_insn(file, func, insn);
+
 		if (func && insn_func(insn) && func !=3D insn_func(insn)->pfunc) {
 			/* Ignore KCFI type preambles, which always fall through */
 			if (is_prefix_func(func))
@@ -3787,7 +3896,13 @@ static int validate_unwind_hint(struct objtool_file *f=
ile,
 				  struct insn_state *state)
 {
 	if (insn->hint && !insn->visited) {
-		int ret =3D validate_branch(file, insn_func(insn), insn, *state);
+		struct symbol *func =3D insn_func(insn);
+		int ret;
+
+		if (opts.checksum)
+			checksum_init(func);
+
+		ret =3D validate_branch(file, func, insn, *state);
 		if (ret)
 			BT_INSN(insn, "<=3D=3D=3D (hint)");
 		return ret;
@@ -4166,6 +4281,7 @@ static int validate_symbol(struct objtool_file *file, s=
truct section *sec,
 			   struct symbol *sym, struct insn_state *state)
 {
 	struct instruction *insn;
+	struct symbol *func;
 	int ret;
=20
 	if (!sym->len) {
@@ -4183,9 +4299,18 @@ static int validate_symbol(struct objtool_file *file, =
struct section *sec,
 	if (opts.uaccess)
 		state->uaccess =3D sym->uaccess_safe;
=20
-	ret =3D validate_branch(file, insn_func(insn), insn, *state);
+	func =3D insn_func(insn);
+
+	if (opts.checksum)
+		checksum_init(func);
+
+	ret =3D validate_branch(file, func, insn, *state);
 	if (ret)
 		BT_INSN(insn, "<=3D=3D=3D (sym)");
+
+	if (opts.checksum)
+		checksum_finish(func);
+
 	return ret;
 }
=20
@@ -4703,7 +4828,7 @@ int check(struct objtool_file *file)
 	if (opts.retpoline)
 		warnings +=3D validate_retpoline(file);
=20
-	if (opts.stackval || opts.orc || opts.uaccess) {
+	if (validate_branch_enabled()) {
 		int w =3D 0;
=20
 		w +=3D validate_functions(file);
@@ -4782,6 +4907,12 @@ int check(struct objtool_file *file)
 	if (opts.noabs)
 		warnings +=3D check_abs_references(file);
=20
+	if (opts.checksum) {
+		ret =3D create_sym_checksum_section(file);
+		if (ret)
+			goto out;
+	}
+
 	if (opts.orc && nr_insns) {
 		ret =3D orc_create(file);
 		if (ret)
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 6095bab..0119b3b 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -17,6 +17,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include <libgen.h>
+#include <ctype.h>
 #include <linux/interval_tree_generic.h>
 #include <objtool/builtin.h>
 #include <objtool/elf.h>
@@ -412,7 +413,38 @@ static int read_sections(struct elf *elf)
 	return 0;
 }
=20
-static void elf_add_symbol(struct elf *elf, struct symbol *sym)
+static const char *demangle_name(struct symbol *sym)
+{
+	char *str;
+
+	if (!is_local_sym(sym))
+		return sym->name;
+
+	if (!is_func_sym(sym) && !is_object_sym(sym))
+		return sym->name;
+
+	if (!strstarts(sym->name, "__UNIQUE_ID_") && !strchr(sym->name, '.'))
+		return sym->name;
+
+	str =3D strdup(sym->name);
+	if (!str) {
+		ERROR_GLIBC("strdup");
+		return NULL;
+	}
+
+	for (int i =3D strlen(str) - 1; i >=3D 0; i--) {
+		char c =3D str[i];
+
+		if (!isdigit(c) && c !=3D '.') {
+			str[i + 1] =3D '\0';
+			break;
+		}
+	};
+
+	return str;
+}
+
+static int elf_add_symbol(struct elf *elf, struct symbol *sym)
 {
 	struct list_head *entry;
 	struct rb_node *pnode;
@@ -456,6 +488,12 @@ static void elf_add_symbol(struct elf *elf, struct symbo=
l *sym)
 	if (is_func_sym(sym) && strstr(sym->name, ".cold"))
 		sym->cold =3D 1;
 	sym->pfunc =3D sym->cfunc =3D sym;
+
+	sym->demangled_name =3D demangle_name(sym);
+	if (!sym->demangled_name)
+		return -1;
+
+	return 0;
 }
=20
 static int read_symbols(struct elf *elf)
@@ -529,7 +567,8 @@ static int read_symbols(struct elf *elf)
 		} else
 			sym->sec =3D find_section_by_index(elf, 0);
=20
-		elf_add_symbol(elf, sym);
+		if (elf_add_symbol(elf, sym))
+			return -1;
 	}
=20
 	if (opts.stats) {
@@ -867,7 +906,8 @@ non_local:
 		mark_sec_changed(elf, symtab_shndx, true);
 	}
=20
-	elf_add_symbol(elf, sym);
+	if (elf_add_symbol(elf, sym))
+		return NULL;
=20
 	return sym;
 }
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/=
objtool/builtin.h
index 7d559a2..338bdab 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -9,12 +9,15 @@
=20
 struct opts {
 	/* actions: */
+	bool cfi;
+	bool checksum;
 	bool dump_orc;
 	bool hack_jump_label;
 	bool hack_noinstr;
 	bool hack_skylake;
 	bool ibt;
 	bool mcount;
+	bool noabs;
 	bool noinstr;
 	bool orc;
 	bool retpoline;
@@ -25,8 +28,6 @@ struct opts {
 	bool static_call;
 	bool uaccess;
 	int prefix;
-	bool cfi;
-	bool noabs;
=20
 	/* options: */
 	bool backtrace;
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/ob=
jtool/check.h
index 0f4e7ac..d73b0c3 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -65,8 +65,9 @@ struct instruction {
 	    unret		: 1,
 	    visited		: 4,
 	    no_reloc		: 1,
-	    hole		: 1;
-		/* 10 bit hole */
+	    hole		: 1,
+	    fake		: 1;
+		/* 9 bit hole */
=20
 	struct alt_group *alt_group;
 	struct instruction *jump_dest;
diff --git a/tools/objtool/include/objtool/checksum.h b/tools/objtool/include=
/objtool/checksum.h
new file mode 100644
index 0000000..927ca74
--- /dev/null
+++ b/tools/objtool/include/objtool/checksum.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _OBJTOOL_CHECKSUM_H
+#define _OBJTOOL_CHECKSUM_H
+
+#include <objtool/elf.h>
+
+#ifdef BUILD_KLP
+
+static inline void checksum_init(struct symbol *func)
+{
+	if (func && !func->csum.state) {
+		func->csum.state =3D XXH3_createState();
+		XXH3_64bits_reset(func->csum.state);
+	}
+}
+
+static inline void checksum_update(struct symbol *func,
+				   struct instruction *insn,
+				   const void *data, size_t size)
+{
+	XXH3_64bits_update(func->csum.state, data, size);
+}
+
+static inline void checksum_finish(struct symbol *func)
+{
+	if (func && func->csum.state) {
+		func->csum.checksum =3D XXH3_64bits_digest(func->csum.state);
+		func->csum.state =3D NULL;
+	}
+}
+
+#else /* !BUILD_KLP */
+
+static inline void checksum_init(struct symbol *func) {}
+static inline void checksum_update(struct symbol *func,
+				   struct instruction *insn,
+				   const void *data, size_t size) {}
+static inline void checksum_finish(struct symbol *func) {}
+
+#endif /* !BUILD_KLP */
+
+#endif /* _OBJTOOL_CHECKSUM_H */
diff --git a/tools/objtool/include/objtool/checksum_types.h b/tools/objtool/i=
nclude/objtool/checksum_types.h
new file mode 100644
index 0000000..507efdd
--- /dev/null
+++ b/tools/objtool/include/objtool/checksum_types.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _OBJTOOL_CHECKSUM_TYPES_H
+#define _OBJTOOL_CHECKSUM_TYPES_H
+
+struct sym_checksum {
+	u64 addr;
+	u64 checksum;
+};
+
+#ifdef BUILD_KLP
+
+#include <xxhash.h>
+
+struct checksum {
+	XXH3_state_t *state;
+	XXH64_hash_t checksum;
+};
+
+#else /* !BUILD_KLP */
+
+struct checksum {};
+
+#endif /* !BUILD_KLP */
+
+#endif /* _OBJTOOL_CHECKSUM_TYPES_H */
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objt=
ool/elf.h
index 814cfc0..bc7d8a6 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -15,6 +15,7 @@
 #include <linux/jhash.h>
=20
 #include <objtool/endianness.h>
+#include <objtool/checksum_types.h>
 #include <arch/elf.h>
=20
 #define SYM_NAME_LEN		512
@@ -61,7 +62,7 @@ struct symbol {
 	struct elf_hash_node name_hash;
 	GElf_Sym sym;
 	struct section *sec;
-	const char *name;
+	const char *name, *demangled_name;
 	unsigned int idx, len;
 	unsigned long offset;
 	unsigned long __subtree_last;
@@ -84,6 +85,7 @@ struct symbol {
 	struct list_head pv_target;
 	struct reloc *relocs;
 	struct section *group_sec;
+	struct checksum csum;
 };
=20
 struct reloc {

