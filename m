Return-Path: <linux-tip-commits+bounces-6910-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC20EBE297F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5F904FDFC9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C426338F54;
	Thu, 16 Oct 2025 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1/OX0rPi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BqKx7dWx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DB132F748;
	Thu, 16 Oct 2025 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608405; cv=none; b=p1nunQKn4g+Yn+zckJ0AaKYyZheZkV3SJkb2e0HydU7y/0VMqzJgZPVi+fY63k+4QFoThCaSXcK2CvixXN9Ly1Zg56pokW8Fu0dZOfkltCiYFTc7yYiXiTQLuB40sVlOOy9fTHP0OdbiW7A8eeVF6V68nBlpDEjknaMCrBoos9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608405; c=relaxed/simple;
	bh=SXh2BCu8kM8TkbyCt9H6tAD3drS6QfcF4J6O4Ze3V6Y=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=kaFmkgaqkd+AVb4FZj7JwXhhpLLiIu3YuTz+rtUJokLZgss0jbWFVsrS3o235kGMjmGLk5K/djfx7N/V9oRC3oBesmdarch6mIDmT/BYGQ8x0HgnkohUxV9prrqK+gM24UMQg7q72VzAeQ0Cl6k1HVji3ULguBtBuL1CFP42MxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1/OX0rPi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BqKx7dWx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608368;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=r0Xj/oya8CoEctoeioc7uoFH6t548zwwbhFuc5tcH7s=;
	b=1/OX0rPiNtx/S72GO1CxEWQKV+oVDWxUinaza1u4WlBOIjVWC3/dV/1QTxCaeNnltEpU4D
	sOsHwQ/7dpE8uhyhJ2RbzwKjAMjJohRW4kwpk8lfq2yTrtvHheazgL9UJaS/nZw1v/RTSj
	ScPowJnIeSSfOzyXxO828mwMvQRQrNzrdMmVnzlB8e598XAbI/XfQvNeFosTEurgy37pll
	9c8EkM4ByzbvBsrJ423/ZBsPBLqFXuGr+bdvK8CLVC2iw3YcproOV77et2QjLrkvQ/TzZn
	rdg4uid5fQ7KhXA+05Q2h7dZfWvhmCwWC1P3q4yagNz5/kazgegfIVdKKNndEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608368;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=r0Xj/oya8CoEctoeioc7uoFH6t548zwwbhFuc5tcH7s=;
	b=BqKx7dWx1JAd5pwCdxgg7IDn4kD7WNGRU1uXbsAEE2za5qOA3/pARBQziVFxTXB9bYj8W7
	sB/kx8cnNtmWdkAw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Convert elf iterator macros to use 'struct elf'
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060836753.709179.7104205397047495445.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     96eceff331ea535b763b161df01300bbfd93b372
Gitweb:        https://git.kernel.org/tip/96eceff331ea535b763b161df01300bbfd9=
3b372
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:35 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:25 -07:00

objtool: Convert elf iterator macros to use 'struct elf'

'struct objtool_file' is specific to the check code and doesn't belong
in the elf code which is supposed to be objtool_file-agnostic.  Convert
the elf iterator macros to use 'struct elf' instead.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 24 ++++++++++++------------
 tools/objtool/include/objtool/elf.h |  8 ++++----
 tools/objtool/orc_gen.c             |  2 +-
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 61e071c..dbc4fbd 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -106,7 +106,7 @@ static struct instruction *prev_insn_same_sym(struct objt=
ool_file *file,
 #define for_each_insn(file, insn)					\
 	for (struct section *__sec, *__fake =3D (struct section *)1;	\
 	     __fake; __fake =3D NULL)					\
-		for_each_sec(file, __sec)				\
+		for_each_sec(file->elf, __sec)				\
 			sec_for_each_insn(file, __sec, insn)
=20
 #define func_for_each_insn(file, func, insn)				\
@@ -431,7 +431,7 @@ static int decode_instructions(struct objtool_file *file)
 	unsigned long offset;
 	struct instruction *insn;
=20
-	for_each_sec(file, sec) {
+	for_each_sec(file->elf, sec) {
 		struct instruction *insns =3D NULL;
 		u8 prev_len =3D 0;
 		u8 idx =3D 0;
@@ -857,7 +857,7 @@ static int create_cfi_sections(struct objtool_file *file)
 	}
=20
 	idx =3D 0;
-	for_each_sym(file, sym) {
+	for_each_sym(file->elf, sym) {
 		if (sym->type !=3D STT_FUNC)
 			continue;
=20
@@ -873,7 +873,7 @@ static int create_cfi_sections(struct objtool_file *file)
 		return -1;
=20
 	idx =3D 0;
-	for_each_sym(file, sym) {
+	for_each_sym(file->elf, sym) {
 		if (sym->type !=3D STT_FUNC)
 			continue;
=20
@@ -2145,7 +2145,7 @@ static int add_jump_table_alts(struct objtool_file *fil=
e)
 	if (!file->rodata)
 		return 0;
=20
-	for_each_sym(file, func) {
+	for_each_sym(file->elf, func) {
 		if (func->type !=3D STT_FUNC)
 			continue;
=20
@@ -2451,7 +2451,7 @@ static int classify_symbols(struct objtool_file *file)
 {
 	struct symbol *func;
=20
-	for_each_sym(file, func) {
+	for_each_sym(file->elf, func) {
 		if (func->type =3D=3D STT_NOTYPE && strstarts(func->name, ".L"))
 			func->local_label =3D true;
=20
@@ -2496,7 +2496,7 @@ static void mark_rodata(struct objtool_file *file)
 	 *
 	 * .rodata.str1.* sections are ignored; they don't contain jump tables.
 	 */
-	for_each_sec(file, sec) {
+	for_each_sec(file->elf, sec) {
 		if ((!strncmp(sec->name, ".rodata", 7) &&
 		     !strstr(sec->name, ".str1.")) ||
 		    !strncmp(sec->name, ".data.rel.ro", 12)) {
@@ -4178,7 +4178,7 @@ static int add_prefix_symbols(struct objtool_file *file)
 	struct section *sec;
 	struct symbol *func;
=20
-	for_each_sec(file, sec) {
+	for_each_sec(file->elf, sec) {
 		if (!(sec->sh.sh_flags & SHF_EXECINSTR))
 			continue;
=20
@@ -4270,7 +4270,7 @@ static int validate_functions(struct objtool_file *file)
 	struct section *sec;
 	int warnings =3D 0;
=20
-	for_each_sec(file, sec) {
+	for_each_sec(file->elf, sec) {
 		if (!(sec->sh.sh_flags & SHF_EXECINSTR))
 			continue;
=20
@@ -4449,7 +4449,7 @@ static int validate_ibt(struct objtool_file *file)
 	for_each_insn(file, insn)
 		warnings +=3D validate_ibt_insn(file, insn);
=20
-	for_each_sec(file, sec) {
+	for_each_sec(file->elf, sec) {
=20
 		/* Already done by validate_ibt_insn() */
 		if (sec->sh.sh_flags & SHF_EXECINSTR)
@@ -4610,7 +4610,7 @@ static void disas_warned_funcs(struct objtool_file *fil=
e)
 	struct symbol *sym;
 	char *funcs =3D NULL, *tmp;
=20
-	for_each_sym(file, sym) {
+	for_each_sym(file->elf, sym) {
 		if (sym->warned) {
 			if (!funcs) {
 				funcs =3D malloc(strlen(sym->name) + 1);
@@ -4650,7 +4650,7 @@ static int check_abs_references(struct objtool_file *fi=
le)
 	struct reloc *reloc;
 	int ret =3D 0;
=20
-	for_each_sec(file, sec) {
+	for_each_sec(file->elf, sec) {
 		/* absolute references in non-loadable sections are fine */
 		if (!(sec->sh.sh_flags & SHF_ALLOC))
 			continue;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objt=
ool/elf.h
index 74ce454..4d5f27b 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -325,16 +325,16 @@ static inline void set_sym_next_reloc(struct reloc *rel=
oc, struct reloc *next)
 	reloc->_sym_next_reloc =3D (unsigned long)next | bit;
 }
=20
-#define for_each_sec(file, sec)						\
-	list_for_each_entry(sec, &file->elf->sections, list)
+#define for_each_sec(elf, sec)						\
+	list_for_each_entry(sec, &elf->sections, list)
=20
 #define sec_for_each_sym(sec, sym)					\
 	list_for_each_entry(sym, &sec->symbol_list, list)
=20
-#define for_each_sym(file, sym)						\
+#define for_each_sym(elf, sym)						\
 	for (struct section *__sec, *__fake =3D (struct section *)1;	\
 	     __fake; __fake =3D NULL)					\
-		for_each_sec(file, __sec)				\
+		for_each_sec(elf, __sec)				\
 			sec_for_each_sym(__sec, sym)
=20
 #define for_each_reloc(rsec, reloc)					\
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 922e6aa..6eff3d6 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -57,7 +57,7 @@ int orc_create(struct objtool_file *file)
=20
 	/* Build a deduplicated list of ORC entries: */
 	INIT_LIST_HEAD(&orc_list);
-	for_each_sec(file, sec) {
+	for_each_sec(file->elf, sec) {
 		struct orc_entry orc, prev_orc =3D {0};
 		struct instruction *insn;
 		bool empty =3D true;

