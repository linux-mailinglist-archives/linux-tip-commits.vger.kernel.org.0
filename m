Return-Path: <linux-tip-commits+bounces-7505-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29884C7F891
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7EDAB348B96
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36672FFFAF;
	Mon, 24 Nov 2025 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fkVDfJDU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lRHweAAu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232202FF14F;
	Mon, 24 Nov 2025 09:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975526; cv=none; b=G8Rv97KRtmkRS9dIjYXA3uiwocjA1kPRjI0/e8bVROAKrCzL1z8tTG+gqxNSVLTCam1NB2zutu0223YMW27XCE2qff7VSpx5SVWPSgM8mta+rSZOMZW++S9sdufot6MdPW8TKehz8yuWsOjZXUzqeOuyorhh1Jcx1P6nsDvbcoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975526; c=relaxed/simple;
	bh=vSgqReqME5hNhXIJoqsdmcx3hPja/zXM5Fcse8sO58Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rM3XFCNqepbfs0maBVUzrVgrleuMWlNfFTZu4gXEdH9hRUwGW8fE/tic60u3nRtMZBaSaK/osqBsIA4QGEe/YibPAG4HFzM87dYswKkPFrNn/+0hsQukAjmTp0LIqJaL8mkmxslINH4dNPjni1FsLyiag1QLecC6Eq6wfVP/udw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fkVDfJDU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lRHweAAu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:12:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975522;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QKXVFVSc0BHOpwkP0Q/T3RqdS1IC4T3sfdIUA+RAHlw=;
	b=fkVDfJDUPSTizYNsG+zdjMXTlq46KkWkqGkVAd/eWqAH1aJFlVwEnEhUk647bPHYo5vg4v
	DjkjcRY+hn65a1Rp7aCZdxgyztNGR59zgvmjWpzd7bilpBNi9mZ813BnxhPaczGIAoWpfn
	B9JUAlsLS6UwuYCZI0lUc/gsT3woeyqgY/0f4fRg8NI66DeQXYImyA3LHroSpHkfBduUeS
	pJTMatrJjKq2muLHfjHOg7VvuVUBtuPWdXc0OBAz0nJw/uOI3UctZmVZUaqNEHiSBay364
	Xfn2LTqZ8FA+Y2Mt0jpz67iXuDiQhDAk1UBNyuPJhgjwWcyskx1i6T8Zfi+KhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975522;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QKXVFVSc0BHOpwkP0Q/T3RqdS1IC4T3sfdIUA+RAHlw=;
	b=lRHweAAul6n+cIjgipsnBywuR8Os55XPgfkB7t4lOzgyTHLqVntIyQ5YZmwMfYvkn4y6tl
	09ZMRvIEysbnf/Aw==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Disassemble code with libopcodes instead
 of running objdump
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-4-alexandre.chartre@oracle.com>
References: <20251121095340.464045-4-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397552141.498.10871337763314693621.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     59953303827eceb06d486ba66cc0d71f55ded8ec
Gitweb:        https://git.kernel.org/tip/59953303827eceb06d486ba66cc0d71f55d=
ed8ec
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:13 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:07 +01:00

objtool: Disassemble code with libopcodes instead of running objdump

objtool executes the objdump command to disassemble code. Use libopcodes
instead to have more control about the disassembly scope and output.
If libopcodes is not present then objtool is built without disassembly
support.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-4-alexandre.chartre@orac=
le.com
---
 tools/objtool/.gitignore              |   2 +-
 tools/objtool/Build                   |   3 +-
 tools/objtool/Makefile                |  25 +++-
 tools/objtool/arch/loongarch/decode.c |  12 ++-
 tools/objtool/arch/powerpc/decode.c   |  12 ++-
 tools/objtool/arch/x86/decode.c       |  12 ++-
 tools/objtool/check.c                 |  14 +-
 tools/objtool/disas.c                 | 187 ++++++++++++++++---------
 tools/objtool/include/objtool/arch.h  |   9 +-
 tools/objtool/include/objtool/check.h |   5 +-
 tools/objtool/include/objtool/disas.h |  29 ++++-
 11 files changed, 238 insertions(+), 72 deletions(-)

diff --git a/tools/objtool/.gitignore b/tools/objtool/.gitignore
index 4faa4dd..7593036 100644
--- a/tools/objtool/.gitignore
+++ b/tools/objtool/.gitignore
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 arch/x86/lib/inat-tables.c
 /objtool
+feature
+FEATURE-DUMP.objtool
 fixdep
 libsubcmd/
diff --git a/tools/objtool/Build b/tools/objtool/Build
index 17e50a1..9d1e8f2 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -7,7 +7,8 @@ objtool-y +=3D special.o
 objtool-y +=3D builtin-check.o
 objtool-y +=3D elf.o
 objtool-y +=3D objtool.o
-objtool-y +=3D disas.o
+
+objtool-$(BUILD_DISAS) +=3D disas.o
=20
 objtool-$(BUILD_ORC) +=3D orc_gen.o orc_dump.o
 objtool-$(BUILD_KLP) +=3D builtin-klp.o klp-diff.o klp-post-link.o
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 021f55b..df793ca 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -70,6 +70,29 @@ OBJTOOL_CFLAGS +=3D $(if $(elfshdr),,-DLIBELF_USE_DEPRECAT=
ED)
 # Always want host compilation.
 HOST_OVERRIDES :=3D CC=3D"$(HOSTCC)" LD=3D"$(HOSTLD)" AR=3D"$(HOSTAR)"
=20
+#
+# To support disassembly, objtool needs libopcodes which is provided
+# with libbdf (binutils-dev or binutils-devel package).
+#
+FEATURE_USER =3D .objtool
+FEATURE_TESTS =3D libbfd disassembler-init-styled
+FEATURE_DISPLAY =3D
+include $(srctree)/tools/build/Makefile.feature
+
+ifeq ($(feature-disassembler-init-styled), 1)
+	OBJTOOL_CFLAGS +=3D -DDISASM_INIT_STYLED
+endif
+
+BUILD_DISAS :=3D n
+
+ifeq ($(feature-libbfd),1)
+	BUILD_DISAS :=3D y
+	OBJTOOL_CFLAGS +=3D -DDISAS
+	OBJTOOL_LDFLAGS +=3D -lopcodes
+endif
+
+export BUILD_DISAS
+
 AWK =3D awk
 MKDIR =3D mkdir
=20
@@ -103,6 +126,8 @@ clean: $(LIBSUBCMD)-clean
 	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL)
 	$(Q)find $(OUTPUT) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name =
'\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT)arch/x86/lib/inat-tables.c $(OUTPUT)fixdep
+	$(Q)$(RM) -- $(OUTPUT)FEATURE-DUMP.objtool
+	$(Q)$(RM) -r -- $(OUTPUT)feature
=20
 FORCE:
=20
diff --git a/tools/objtool/arch/loongarch/decode.c b/tools/objtool/arch/loong=
arch/decode.c
index 0115b97..1de86eb 100644
--- a/tools/objtool/arch/loongarch/decode.c
+++ b/tools/objtool/arch/loongarch/decode.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include <string.h>
 #include <objtool/check.h>
+#include <objtool/disas.h>
 #include <objtool/warn.h>
 #include <asm/inst.h>
 #include <asm/orc_types.h>
@@ -414,3 +415,14 @@ unsigned long arch_jump_table_sym_offset(struct reloc *r=
eloc, struct reloc *tabl
 		return reloc->sym->offset + reloc_addend(reloc);
 	}
 }
+
+#ifdef DISAS
+
+int arch_disas_info_init(struct disassemble_info *dinfo)
+{
+	return disas_info_init(dinfo, bfd_arch_loongarch,
+			       bfd_mach_loongarch32, bfd_mach_loongarch64,
+			       NULL);
+}
+
+#endif /* DISAS */
diff --git a/tools/objtool/arch/powerpc/decode.c b/tools/objtool/arch/powerpc=
/decode.c
index 3a9b748..4f68b40 100644
--- a/tools/objtool/arch/powerpc/decode.c
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -3,6 +3,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <objtool/check.h>
+#include <objtool/disas.h>
 #include <objtool/elf.h>
 #include <objtool/arch.h>
 #include <objtool/warn.h>
@@ -127,3 +128,14 @@ unsigned int arch_reloc_size(struct reloc *reloc)
 		return 8;
 	}
 }
+
+#ifdef DISAS
+
+int arch_disas_info_init(struct disassemble_info *dinfo)
+{
+	return disas_info_init(dinfo, bfd_arch_powerpc,
+			       bfd_mach_ppc, bfd_mach_ppc64,
+			       NULL);
+}
+
+#endif /* DISAS */
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index cc85db7..83e9c60 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -16,6 +16,7 @@
=20
 #include <asm/orc_types.h>
 #include <objtool/check.h>
+#include <objtool/disas.h>
 #include <objtool/elf.h>
 #include <objtool/arch.h>
 #include <objtool/warn.h>
@@ -949,3 +950,14 @@ bool arch_absolute_reloc(struct elf *elf, struct reloc *=
reloc)
 		return false;
 	}
 }
+
+#ifdef DISAS
+
+int arch_disas_info_init(struct disassemble_info *dinfo)
+{
+	return disas_info_init(dinfo, bfd_arch_i386,
+			       bfd_mach_i386_i386, bfd_mach_x86_64,
+			       "att");
+}
+
+#endif /* DISAS */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8b1a6a5..21d45a3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4926,8 +4926,6 @@ int check(struct objtool_file *file)
 			goto out;
 	}
=20
-	free_insns(file);
-
 	if (opts.stats) {
 		printf("nr_insns_visited: %ld\n", nr_insns_visited);
 		printf("nr_cfi: %ld\n", nr_cfi);
@@ -4936,8 +4934,10 @@ int check(struct objtool_file *file)
 	}
=20
 out:
-	if (!ret && !warnings)
+	if (!ret && !warnings) {
+		free_insns(file);
 		return 0;
+	}
=20
 	if (opts.werror && warnings)
 		ret =3D 1;
@@ -4946,10 +4946,14 @@ out:
 		if (opts.werror && warnings)
 			WARN("%d warning(s) upgraded to errors", warnings);
 		disas_ctx =3D disas_context_create(file);
-		disas_warned_funcs(disas_ctx);
-		disas_context_destroy(disas_ctx);
+		if (disas_ctx) {
+			disas_warned_funcs(disas_ctx);
+			disas_context_destroy(disas_ctx);
+		}
 	}
=20
+	free_insns(file);
+
 	if (opts.backup && make_backup())
 		return 1;
=20
diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 7a18e51..11ac2ec 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -4,18 +4,56 @@
  */
=20
 #include <objtool/arch.h>
+#include <objtool/check.h>
 #include <objtool/disas.h>
 #include <objtool/warn.h>
=20
+#include <bfd.h>
 #include <linux/string.h>
+#include <tools/dis-asm-compat.h>
=20
 struct disas_context {
 	struct objtool_file *file;
+	disassembler_ftype disassembler;
+	struct disassemble_info info;
 };
=20
+#define DINFO_FPRINTF(dinfo, ...)	\
+	((*(dinfo)->fprintf_func)((dinfo)->stream, __VA_ARGS__))
+
+/*
+ * Initialize disassemble info arch, mach (32 or 64-bit) and options.
+ */
+int disas_info_init(struct disassemble_info *dinfo,
+		    int arch, int mach32, int mach64,
+		    const char *options)
+{
+	struct disas_context *dctx =3D dinfo->application_data;
+	struct objtool_file *file =3D dctx->file;
+
+	dinfo->arch =3D arch;
+
+	switch (file->elf->ehdr.e_ident[EI_CLASS]) {
+	case ELFCLASS32:
+		dinfo->mach =3D mach32;
+		break;
+	case ELFCLASS64:
+		dinfo->mach =3D mach64;
+		break;
+	default:
+		return -1;
+	}
+
+	dinfo->disassembler_options =3D options;
+
+	return 0;
+}
+
 struct disas_context *disas_context_create(struct objtool_file *file)
 {
 	struct disas_context *dctx;
+	struct disassemble_info *dinfo;
+	int err;
=20
 	dctx =3D malloc(sizeof(*dctx));
 	if (!dctx) {
@@ -24,8 +62,49 @@ struct disas_context *disas_context_create(struct objtool_=
file *file)
 	}
=20
 	dctx->file =3D file;
+	dinfo =3D &dctx->info;
+
+	init_disassemble_info_compat(dinfo, stdout,
+				     (fprintf_ftype)fprintf,
+				     fprintf_styled);
+
+	dinfo->read_memory_func =3D buffer_read_memory;
+	dinfo->application_data =3D dctx;
+
+	/*
+	 * bfd_openr() is not used to avoid doing ELF data processing
+	 * and caching that has already being done. Here, we just need
+	 * to identify the target file so we call an arch specific
+	 * function to fill some disassemble info (arch, mach).
+	 */
+
+	dinfo->arch =3D bfd_arch_unknown;
+	dinfo->mach =3D 0;
+
+	err =3D arch_disas_info_init(dinfo);
+	if (err || dinfo->arch =3D=3D bfd_arch_unknown || dinfo->mach =3D=3D 0) {
+		WARN("failed to init disassembly arch");
+		goto error;
+	}
+
+	dinfo->endian =3D (file->elf->ehdr.e_ident[EI_DATA] =3D=3D ELFDATA2MSB) ?
+		BFD_ENDIAN_BIG : BFD_ENDIAN_LITTLE;
+
+	disassemble_init_for_target(dinfo);
+
+	dctx->disassembler =3D disassembler(dinfo->arch,
+					  dinfo->endian =3D=3D BFD_ENDIAN_BIG,
+					  dinfo->mach, NULL);
+	if (!dctx->disassembler) {
+		WARN("failed to create disassembler function");
+		goto error;
+	}
=20
 	return dctx;
+
+error:
+	free(dctx);
+	return NULL;
 }
=20
 void disas_context_destroy(struct disas_context *dctx)
@@ -33,86 +112,62 @@ void disas_context_destroy(struct disas_context *dctx)
 	free(dctx);
 }
=20
-/* 'funcs' is a space-separated list of function names */
-static void disas_funcs(const char *funcs)
+/*
+ * Disassemble a single instruction. Return the size of the instruction.
+ */
+static size_t disas_insn(struct disas_context *dctx,
+			 struct instruction *insn)
 {
-	const char *objdump_str, *cross_compile;
-	int size, ret;
-	char *cmd;
-
-	cross_compile =3D getenv("CROSS_COMPILE");
-	if (!cross_compile)
-		cross_compile =3D "";
-
-	objdump_str =3D "%sobjdump -wdr %s | gawk -M -v _funcs=3D'%s' '"
-			"BEGIN { split(_funcs, funcs); }"
-			"/^$/ { func_match =3D 0; }"
-			"/<.*>:/ { "
-				"f =3D gensub(/.*<(.*)>:/, \"\\\\1\", 1);"
-				"for (i in funcs) {"
-					"if (funcs[i] =3D=3D f) {"
-						"func_match =3D 1;"
-						"base =3D strtonum(\"0x\" $1);"
-						"break;"
-					"}"
-				"}"
-			"}"
-			"{"
-				"if (func_match) {"
-					"addr =3D strtonum(\"0x\" $1);"
-					"printf(\"%%04x \", addr - base);"
-					"print;"
-				"}"
-			"}' 1>&2";
-
-	/* fake snprintf() to calculate the size */
-	size =3D snprintf(NULL, 0, objdump_str, cross_compile, objname, funcs) + 1;
-	if (size <=3D 0) {
-		WARN("objdump string size calculation failed");
-		return;
+	disassembler_ftype disasm =3D dctx->disassembler;
+	struct disassemble_info *dinfo =3D &dctx->info;
+
+	if (insn->type =3D=3D INSN_NOP) {
+		DINFO_FPRINTF(dinfo, "nop%d", insn->len);
+		return insn->len;
 	}
=20
-	cmd =3D malloc(size);
+	/*
+	 * Set the disassembler buffer to read data from the section
+	 * containing the instruction to disassemble.
+	 */
+	dinfo->buffer =3D insn->sec->data->d_buf;
+	dinfo->buffer_vma =3D 0;
+	dinfo->buffer_length =3D insn->sec->sh.sh_size;
=20
-	/* real snprintf() */
-	snprintf(cmd, size, objdump_str, cross_compile, objname, funcs);
-	ret =3D system(cmd);
-	if (ret) {
-		WARN("disassembly failed: %d", ret);
-		return;
+	return disasm(insn->offset, &dctx->info);
+}
+
+/*
+ * Disassemble a function.
+ */
+static void disas_func(struct disas_context *dctx, struct symbol *func)
+{
+	struct instruction *insn;
+	size_t addr;
+
+	printf("%s:\n", func->name);
+	sym_for_each_insn(dctx->file, func, insn) {
+		addr =3D insn->offset;
+		printf(" %6lx:  %s+0x%-6lx      ",
+		       addr, func->name, addr - func->offset);
+		disas_insn(dctx, insn);
+		printf("\n");
 	}
+	printf("\n");
 }
=20
+/*
+ * Disassemble all warned functions.
+ */
 void disas_warned_funcs(struct disas_context *dctx)
 {
 	struct symbol *sym;
-	char *funcs =3D NULL, *tmp;
=20
 	if (!dctx)
 		return;
=20
 	for_each_sym(dctx->file->elf, sym) {
-		if (sym->warned) {
-			if (!funcs) {
-				funcs =3D malloc(strlen(sym->name) + 1);
-				if (!funcs) {
-					ERROR_GLIBC("malloc");
-					return;
-				}
-				strcpy(funcs, sym->name);
-			} else {
-				tmp =3D malloc(strlen(funcs) + strlen(sym->name) + 2);
-				if (!tmp) {
-					ERROR_GLIBC("malloc");
-					return;
-				}
-				sprintf(tmp, "%s %s", funcs, sym->name);
-				free(funcs);
-				funcs =3D tmp;
-			}
-		}
+		if (sym->warned)
+			disas_func(dctx, sym);
 	}
-
-	if (funcs)
-		disas_funcs(funcs);
 }
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/obj=
tool/arch.h
index d89f8b5..18c0e69 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -103,4 +103,13 @@ bool arch_absolute_reloc(struct elf *elf, struct reloc *=
reloc);
 unsigned int arch_reloc_size(struct reloc *reloc);
 unsigned long arch_jump_table_sym_offset(struct reloc *reloc, struct reloc *=
table);
=20
+#ifdef DISAS
+
+#include <bfd.h>
+#include <dis-asm.h>
+
+int arch_disas_info_init(struct disassemble_info *dinfo);
+
+#endif /* DISAS */
+
 #endif /* _ARCH_H */
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/ob=
jtool/check.h
index d73b0c3..674f574 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -127,4 +127,9 @@ struct instruction *next_insn_same_sec(struct objtool_fil=
e *file, struct instruc
 	     insn && insn->sec =3D=3D _sec;					\
 	     insn =3D next_insn_same_sec(file, insn))
=20
+#define sym_for_each_insn(file, sym, insn)				\
+	for (insn =3D find_insn(file, sym->sec, sym->offset);		\
+	     insn && insn->offset < sym->offset + sym->len;		\
+	     insn =3D next_insn_same_sec(file, insn))
+
 #endif /* _CHECK_H */
diff --git a/tools/objtool/include/objtool/disas.h b/tools/objtool/include/ob=
jtool/disas.h
index 5c543b6..3ec3ce2 100644
--- a/tools/objtool/include/objtool/disas.h
+++ b/tools/objtool/include/objtool/disas.h
@@ -7,8 +7,37 @@
 #define _DISAS_H
=20
 struct disas_context;
+struct disassemble_info;
+
+#ifdef DISAS
+
 struct disas_context *disas_context_create(struct objtool_file *file);
 void disas_context_destroy(struct disas_context *dctx);
 void disas_warned_funcs(struct disas_context *dctx);
+int disas_info_init(struct disassemble_info *dinfo,
+		    int arch, int mach32, int mach64,
+		    const char *options);
+
+#else /* DISAS */
+
+#include <objtool/warn.h>
+
+static inline struct disas_context *disas_context_create(struct objtool_file=
 *file)
+{
+	WARN("Rebuild with libopcodes for disassembly support");
+	return NULL;
+}
+
+static inline void disas_context_destroy(struct disas_context *dctx) {}
+static inline void disas_warned_funcs(struct disas_context *dctx) {}
+
+static inline int disas_info_init(struct disassemble_info *dinfo,
+				  int arch, int mach32, int mach64,
+				  const char *options)
+{
+	return -1;
+}
+
+#endif /* DISAS */
=20
 #endif /* _DISAS_H */

