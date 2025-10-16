Return-Path: <linux-tip-commits+bounces-6866-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B179BE2877
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99DD1A625D1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2623191D7;
	Thu, 16 Oct 2025 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I/eoFpve";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bZv6ZNBB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD5631B82C;
	Thu, 16 Oct 2025 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608345; cv=none; b=aFaryGn0Ip33JFI50nox7+yJQFMdPq5E1/XI6weTDqn6WDBa2CXIK71NNmwGiY5e5WXz1J2L2+yZkhVygaQwFswvixTeuI9MlOVAJHzOZ8+L0EPqO8+r4yQR9osjm6tDZ4C1re0WNSjXbVB9C1ZbimWQ2BQDCb1b1fLzvdq5WVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608345; c=relaxed/simple;
	bh=IZ8l+d98Fac8xoK8PGR7U8zlie90Mzw/B0faZ0PoPnk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=kllRvnnGSi8BQJXsRV2QUXh7qu6cZg5Ud1No0NLhJcbksZdiJ76Cacyvg+/U0Ki4KL8jF9uaK0MW+dyuPQA2IHN4msZKN71Q37r5ps1dEGLhwfoCHG2SpGNmAFRqOF7v/fqj6z9ReX8hm9atHbbmo1a28oM5rmOwtvPVSd+pTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I/eoFpve; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bZv6ZNBB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608332;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=3fyRqsv3X/B4TyNoVKrj8won12ilmAhgGT62D6229Bs=;
	b=I/eoFpveuyXpyD6NKtpJ3xVFsXIoi+XvibR5uBurUQBRhZLIcMnTbk0xkduMbQk8McKPXG
	FH8P9QqovSy6gkuazXNd+wS7cRYaDeb9Fz9IzJkSPWciUhd8DxdSUoysmNltXA+lJ2EmuR
	qK5VgQCp7Okrx3Hhwklda/rYBcEtaJ2r/ghNnGH1onE3XV5HUnH+8T3u/rmnQQzfcMO+Ex
	jqvu4ZQm8J1xh9b1c24UvOKAdeOpT8z98FUIS4od/+C+s1dKqzXEphkPoeSyYmdqfzR70y
	tLuqeyJwEK/Xw+wPAkiiMlG+DRlwlQGeonKPciertmc8BUWbPWkoUH6pau1Cow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608332;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=3fyRqsv3X/B4TyNoVKrj8won12ilmAhgGT62D6229Bs=;
	b=bZv6ZNBBSQkyRfkoUjW19d4E+I/Gx0umXIFFzlvk59NONHHRr3zxDkciB0FvYuQ5iIKeQi
	y2N17AIXlCacCBAQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Add base objtool support for livepatch modules
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060833150.709179.6653461924795727998.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     164c9201e1dad8d5c0c38f583dba81e4b6da9cc7
Gitweb:        https://git.kernel.org/tip/164c9201e1dad8d5c0c38f583dba81e4b6d=
a9cc7
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:04:03 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:50:18 -07:00

objtool: Add base objtool support for livepatch modules

In preparation for klp-build, enable "classic" objtool to work on
livepatch modules:

  - Avoid duplicate symbol/section warnings for prefix symbols and the
    .static_call_sites and __mcount_loc sections which may have already
    been extracted by klp diff.

  - Add __klp_funcs to the IBT function pointer section whitelist.

  - Prevent KLP symbols from getting incorrectly classified as cold
    subfunctions.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c                   | 52 +++++++++++++++++++++---
 tools/objtool/elf.c                     |  5 +-
 tools/objtool/include/objtool/elf.h     |  1 +-
 tools/objtool/include/objtool/objtool.h |  2 +-
 4 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b2659fb..d071fbf 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2015-2017 Josh Poimboeuf <jpoimboe@redhat.com>
  */
=20
+#define _GNU_SOURCE /* memmem() */
 #include <string.h>
 #include <stdlib.h>
 #include <inttypes.h>
@@ -611,6 +612,20 @@ static int init_pv_ops(struct objtool_file *file)
 	return 0;
 }
=20
+static bool is_livepatch_module(struct objtool_file *file)
+{
+	struct section *sec;
+
+	if (!opts.module)
+		return false;
+
+	sec =3D find_section_by_name(file->elf, ".modinfo");
+	if (!sec)
+		return false;
+
+	return memmem(sec->data->d_buf, sec_size(sec), "\0livepatch=3DY", 12);
+}
+
 static int create_static_call_sections(struct objtool_file *file)
 {
 	struct static_call_site *site;
@@ -622,7 +637,14 @@ static int create_static_call_sections(struct objtool_fi=
le *file)
=20
 	sec =3D find_section_by_name(file->elf, ".static_call_sites");
 	if (sec) {
-		WARN("file already has .static_call_sites section, skipping");
+		/*
+		 * Livepatch modules may have already extracted the static call
+		 * site entries to take advantage of vmlinux static call
+		 * privileges.
+		 */
+		if (!file->klp)
+			WARN("file already has .static_call_sites section, skipping");
+
 		return 0;
 	}
=20
@@ -666,7 +688,7 @@ static int create_static_call_sections(struct objtool_fil=
e *file)
=20
 		key_sym =3D find_symbol_by_name(file->elf, tmp);
 		if (!key_sym) {
-			if (!opts.module) {
+			if (!opts.module || file->klp) {
 				ERROR("static_call: can't find static_call_key symbol: %s", tmp);
 				return -1;
 			}
@@ -885,7 +907,13 @@ static int create_mcount_loc_sections(struct objtool_fil=
e *file)
=20
 	sec =3D find_section_by_name(file->elf, "__mcount_loc");
 	if (sec) {
-		WARN("file already has __mcount_loc section, skipping");
+		/*
+		 * Livepatch modules have already extracted their __mcount_loc
+		 * entries to cover the !CONFIG_FTRACE_MCOUNT_USE_OBJTOOL case.
+		 */
+		if (!file->klp)
+			WARN("file already has __mcount_loc section, skipping");
+
 		return 0;
 	}
=20
@@ -2569,6 +2597,8 @@ static bool validate_branch_enabled(void)
=20
 static int decode_sections(struct objtool_file *file)
 {
+	file->klp =3D is_livepatch_module(file);
+
 	mark_rodata(file);
=20
 	if (init_pv_ops(file))
@@ -4244,6 +4274,9 @@ static bool ignore_unreachable_insn(struct objtool_file=
 *file, struct instructio
  *   - compiler cloned functions (*.cold, *.part0, etc)
  *   - asm functions created with inline asm or without SYM_FUNC_START()
  *
+ * Also, the function may already have a prefix from a previous objtool run
+ * (livepatch extracted functions, or manually running objtool multiple time=
s).
+ *
  * So return 0 if the NOPs are missing or the function already has a prefix
  * symbol.
  */
@@ -4266,6 +4299,14 @@ static int create_prefix_symbol(struct objtool_file *f=
ile, struct symbol *func)
 	if (snprintf_check(name, SYM_NAME_LEN, "__pfx_%s", func->name))
 		return -1;
=20
+	if (file->klp) {
+		struct symbol *pfx;
+
+		pfx =3D find_symbol_by_offset(func->sec, func->offset - opts.prefix);
+		if (pfx && is_prefix_func(pfx) && !strcmp(pfx->name, name))
+			return 0;
+	}
+
 	insn =3D find_insn(file, func->sec, func->offset);
 	if (!insn) {
 		WARN("%s: can't find starting instruction", func->name);
@@ -4618,6 +4659,7 @@ static int validate_ibt(struct objtool_file *file)
 		    !strncmp(sec->name, ".debug", 6)			||
 		    !strcmp(sec->name, ".altinstructions")		||
 		    !strcmp(sec->name, ".ibt_endbr_seal")		||
+		    !strcmp(sec->name, ".kcfi_traps")			||
 		    !strcmp(sec->name, ".orc_unwind_ip")		||
 		    !strcmp(sec->name, ".retpoline_sites")		||
 		    !strcmp(sec->name, ".smp_locks")			||
@@ -4627,12 +4669,12 @@ static int validate_ibt(struct objtool_file *file)
 		    !strcmp(sec->name, "__bug_table")			||
 		    !strcmp(sec->name, "__ex_table")			||
 		    !strcmp(sec->name, "__jump_table")			||
+		    !strcmp(sec->name, "__klp_funcs")			||
 		    !strcmp(sec->name, "__mcount_loc")			||
-		    !strcmp(sec->name, ".kcfi_traps")			||
 		    !strcmp(sec->name, ".llvm.call-graph-profile")	||
 		    !strcmp(sec->name, ".llvm_bb_addr_map")		||
 		    !strcmp(sec->name, "__tracepoints")			||
-		    strstr(sec->name, "__patchable_function_entries"))
+		    !strcmp(sec->name, "__patchable_function_entries"))
 			continue;
=20
 		for_each_reloc(sec->rsec, reloc)
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 4bb7ce9..5feeefc 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -499,7 +499,10 @@ static int elf_add_symbol(struct elf *elf, struct symbol=
 *sym)
 	     strstarts(sym->name, "__pi___cfi_")))
 		sym->prefix =3D 1;
=20
-	if (is_func_sym(sym) && strstr(sym->name, ".cold"))
+	if (strstarts(sym->name, ".klp.sym"))
+		sym->klp =3D 1;
+
+	if (!sym->klp && is_func_sym(sym) && strstr(sym->name, ".cold"))
 		sym->cold =3D 1;
 	sym->pfunc =3D sym->cfunc =3D sym;
=20
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objt=
ool/elf.h
index 60f844e..21d8b82 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -88,6 +88,7 @@ struct symbol {
 	u8 debug_checksum    : 1;
 	u8 changed	     : 1;
 	u8 included	     : 1;
+	u8 klp		     : 1;
 	struct list_head pv_target;
 	struct reloc *relocs;
 	struct section *group_sec;
diff --git a/tools/objtool/include/objtool/objtool.h b/tools/objtool/include/=
objtool/objtool.h
index 7f70b41..f7051bb 100644
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -28,7 +28,7 @@ struct objtool_file {
 	struct list_head mcount_loc_list;
 	struct list_head endbr_list;
 	struct list_head call_list;
-	bool ignore_unreachables, hints, rodata;
+	bool ignore_unreachables, hints, rodata, klp;
=20
 	unsigned int nr_endbr;
 	unsigned int nr_endbr_int;

