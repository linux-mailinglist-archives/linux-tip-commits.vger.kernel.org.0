Return-Path: <linux-tip-commits+bounces-6906-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C79BE29EB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3B0542B14
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65251337693;
	Thu, 16 Oct 2025 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LemRMiWQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="swSfZTQP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEE9320CAF;
	Thu, 16 Oct 2025 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608402; cv=none; b=FoMmMirrqo5qco7vmiAAmcBhekdQ4yedhXrvgjoVlLc847ZEdZN0b5AJxWs4eQcKBnaACCFAGFwycTqkxKklSDeC7AM7BMgv7Erh82DVvhrhpuTI3dSoxov9pqnXfH0xhS5Xm8RDFo5OtoQuS/8kFlf0EYbM5ZBHjd+sbjWpL78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608402; c=relaxed/simple;
	bh=wUMoTOuk5FIm1QAjffujMq/9maLJJA/HqWZ1P9RMdwI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=oEbsjjXXSiQKu9UwKlBI05Dzz8UZtGnXKgFq3nOwCdeyo/ZTif40nu2azxffxJ80qmOs49w3yQ2+1239QS9Z132C4KwgngrqhYpQdQwXJh+IK/NuRV3CKzdqfVY388qpYjT20b68Kcsbpv/m2p46q0c+qMlGiBV6vjJ+YIipsao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LemRMiWQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=swSfZTQP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:53:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608382;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ZOTY8St7iu6aaRAfxCr+QB9YJfJTiKTi5IGlqHrnGDg=;
	b=LemRMiWQ5OjfuucvJM4Xew+0QgBMkiJ1vNAFstrJffqeeSD0ysvv9eBBWqmiOpXl5Swb85
	deK7ynDswicCPguhRay9za7LoaGeofR/xqgcD/bP0ltUwT9Cy9umq4gov9/2hehoJNyWg/
	ni5S0wQyOdVZ+jznBPjLfFyXW8HRWVDytupoS8+uqI1BN6K/JWnNBuzuoTZPUOmjgPJ8jH
	9+TLHakcwhlabp0EmRf3X7E9ebex6vgfnYuLErhwc5VLYWTtPluka547hAixLhnEa6/sd7
	Asvx0pbJyeXz1LAP+ABWig9KKPZUkyeaDMvFWg3Dg/FDiTaYIgXfgHDpoQhmZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608382;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ZOTY8St7iu6aaRAfxCr+QB9YJfJTiKTi5IGlqHrnGDg=;
	b=swSfZTQP+6MNucxOie036ByeYIMG8P7lHdRPr7Ut+auOKvmdQHIe+w4pcEZZJxBP3nzA2p
	9tgISFAiw/2maDCQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Remove error handling boilerplate
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060838086.709179.13555097152021066029.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     4ac2ba35f62d330dfb2f3148cc7405a6ce5dfa2d
Gitweb:        https://git.kernel.org/tip/4ac2ba35f62d330dfb2f3148cc7405a6ce5=
dfa2d
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:24 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:23 -07:00

objtool: Remove error handling boilerplate

Up to a certain point in objtool's execution, all errors are fatal and
return -1.  When propagating such errors, just return -1 directly
instead of trying to propagate the original return code.  This helps
make the code more compact and the behavior more explicit.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c   | 151 ++++++++++++++-------------------------
 tools/objtool/special.c |   9 +--
 2 files changed, 59 insertions(+), 101 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b0e6479..02c3e2d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -430,7 +430,6 @@ static int decode_instructions(struct objtool_file *file)
 	struct symbol *func;
 	unsigned long offset;
 	struct instruction *insn;
-	int ret;
=20
 	for_each_sec(file, sec) {
 		struct instruction *insns =3D NULL;
@@ -479,11 +478,8 @@ static int decode_instructions(struct objtool_file *file)
 			insn->offset =3D offset;
 			insn->prev_len =3D prev_len;
=20
-			ret =3D arch_decode_instruction(file, sec, offset,
-						      sec->sh.sh_size - offset,
-						      insn);
-			if (ret)
-				return ret;
+			if (arch_decode_instruction(file, sec, offset, sec->sh.sh_size - offset, =
insn))
+				return -1;
=20
 			prev_len =3D insn->len;
=20
@@ -599,7 +595,7 @@ static int init_pv_ops(struct objtool_file *file)
 	};
 	const char *pv_ops;
 	struct symbol *sym;
-	int idx, nr, ret;
+	int idx, nr;
=20
 	if (!opts.noinstr)
 		return 0;
@@ -621,9 +617,8 @@ static int init_pv_ops(struct objtool_file *file)
 		INIT_LIST_HEAD(&file->pv_ops[idx].targets);
=20
 	for (idx =3D 0; (pv_ops =3D pv_ops_tables[idx]); idx++) {
-		ret =3D add_pv_ops(file, pv_ops);
-		if (ret)
-			return ret;
+		if (add_pv_ops(file, pv_ops))
+			return -1;
 	}
=20
 	return 0;
@@ -1484,7 +1479,6 @@ static int add_jump_destinations(struct objtool_file *f=
ile)
 	struct reloc *reloc;
 	struct section *dest_sec;
 	unsigned long dest_off;
-	int ret;
=20
 	for_each_insn(file, insn) {
 		struct symbol *func =3D insn_func(insn);
@@ -1507,9 +1501,8 @@ static int add_jump_destinations(struct objtool_file *f=
ile)
 			dest_sec =3D reloc->sym->sec;
 			dest_off =3D arch_dest_reloc_offset(reloc_addend(reloc));
 		} else if (reloc->sym->retpoline_thunk) {
-			ret =3D add_retpoline_call(file, insn);
-			if (ret)
-				return ret;
+			if (add_retpoline_call(file, insn))
+				return -1;
 			continue;
 		} else if (reloc->sym->return_thunk) {
 			add_return_call(file, insn, true);
@@ -1519,9 +1512,8 @@ static int add_jump_destinations(struct objtool_file *f=
ile)
 			 * External sibling call or internal sibling call with
 			 * STT_FUNC reloc.
 			 */
-			ret =3D add_call_dest(file, insn, reloc->sym, true);
-			if (ret)
-				return ret;
+			if (add_call_dest(file, insn, reloc->sym, true))
+				return -1;
 			continue;
 		} else if (reloc->sym->sec->idx) {
 			dest_sec =3D reloc->sym->sec;
@@ -1570,9 +1562,8 @@ static int add_jump_destinations(struct objtool_file *f=
ile)
 		 */
 		if (jump_dest->sym && jump_dest->offset =3D=3D jump_dest->sym->offset) {
 			if (jump_dest->sym->retpoline_thunk) {
-				ret =3D add_retpoline_call(file, insn);
-				if (ret)
-					return ret;
+				if (add_retpoline_call(file, insn))
+					return -1;
 				continue;
 			}
 			if (jump_dest->sym->return_thunk) {
@@ -1613,9 +1604,8 @@ static int add_jump_destinations(struct objtool_file *f=
ile)
 			 * Internal sibling call without reloc or with
 			 * STT_SECTION reloc.
 			 */
-			ret =3D add_call_dest(file, insn, insn_func(jump_dest), true);
-			if (ret)
-				return ret;
+			if (add_call_dest(file, insn, insn_func(jump_dest), true))
+				return -1;
 			continue;
 		}
=20
@@ -1645,7 +1635,6 @@ static int add_call_destinations(struct objtool_file *f=
ile)
 	unsigned long dest_off;
 	struct symbol *dest;
 	struct reloc *reloc;
-	int ret;
=20
 	for_each_insn(file, insn) {
 		struct symbol *func =3D insn_func(insn);
@@ -1657,9 +1646,8 @@ static int add_call_destinations(struct objtool_file *f=
ile)
 			dest_off =3D arch_jump_destination(insn);
 			dest =3D find_call_destination(insn->sec, dest_off);
=20
-			ret =3D add_call_dest(file, insn, dest, false);
-			if (ret)
-				return ret;
+			if (add_call_dest(file, insn, dest, false))
+				return -1;
=20
 			if (func && func->ignore)
 				continue;
@@ -1683,19 +1671,16 @@ static int add_call_destinations(struct objtool_file =
*file)
 				return -1;
 			}
=20
-			ret =3D add_call_dest(file, insn, dest, false);
-			if (ret)
-				return ret;
+			if (add_call_dest(file, insn, dest, false))
+				return -1;
=20
 		} else if (reloc->sym->retpoline_thunk) {
-			ret =3D add_retpoline_call(file, insn);
-			if (ret)
-				return ret;
+			if (add_retpoline_call(file, insn))
+				return -1;
=20
 		} else {
-			ret =3D add_call_dest(file, insn, reloc->sym, false);
-			if (ret)
-				return ret;
+			if (add_call_dest(file, insn, reloc->sym, false))
+				return -1;
 		}
 	}
=20
@@ -1912,7 +1897,6 @@ static int add_special_section_alts(struct objtool_file=
 *file)
 	struct instruction *orig_insn, *new_insn;
 	struct special_alt *special_alt, *tmp;
 	struct alternative *alt;
-	int ret;
=20
 	if (special_get_alts(file->elf, &special_alts))
 		return -1;
@@ -1944,16 +1928,12 @@ static int add_special_section_alts(struct objtool_fi=
le *file)
 				continue;
 			}
=20
-			ret =3D handle_group_alt(file, special_alt, orig_insn,
-					       &new_insn);
-			if (ret)
-				return ret;
+			if (handle_group_alt(file, special_alt, orig_insn, &new_insn))
+				return -1;
=20
 		} else if (special_alt->jump_or_nop) {
-			ret =3D handle_jump_alt(file, special_alt, orig_insn,
-					      &new_insn);
-			if (ret)
-				return ret;
+			if (handle_jump_alt(file, special_alt, orig_insn, &new_insn))
+				return -1;
 		}
=20
 		alt =3D calloc(1, sizeof(*alt));
@@ -2141,15 +2121,13 @@ static int add_func_jump_tables(struct objtool_file *=
file,
 				  struct symbol *func)
 {
 	struct instruction *insn;
-	int ret;
=20
 	func_for_each_insn(file, func, insn) {
 		if (!insn_jump_table(insn))
 			continue;
=20
-		ret =3D add_jump_table(file, insn);
-		if (ret)
-			return ret;
+		if (add_jump_table(file, insn))
+			return -1;
 	}
=20
 	return 0;
@@ -2163,7 +2141,6 @@ static int add_func_jump_tables(struct objtool_file *fi=
le,
 static int add_jump_table_alts(struct objtool_file *file)
 {
 	struct symbol *func;
-	int ret;
=20
 	if (!file->rodata)
 		return 0;
@@ -2173,9 +2150,8 @@ static int add_jump_table_alts(struct objtool_file *fil=
e)
 			continue;
=20
 		mark_func_jump_tables(file, func);
-		ret =3D add_func_jump_tables(file, func);
-		if (ret)
-			return ret;
+		if (add_func_jump_tables(file, func))
+			return -1;
 	}
=20
 	return 0;
@@ -2299,7 +2275,7 @@ static int read_annotate(struct objtool_file *file,
 	struct instruction *insn;
 	struct reloc *reloc;
 	uint64_t offset;
-	int type, ret;
+	int type;
=20
 	sec =3D find_section_by_name(file->elf, ".discard.annotate_insn");
 	if (!sec)
@@ -2329,9 +2305,8 @@ static int read_annotate(struct objtool_file *file,
 			return -1;
 		}
=20
-		ret =3D func(file, type, insn);
-		if (ret < 0)
-			return ret;
+		if (func(file, type, insn))
+			return -1;
 	}
=20
 	return 0;
@@ -2530,34 +2505,27 @@ static void mark_rodata(struct objtool_file *file)
=20
 static int decode_sections(struct objtool_file *file)
 {
-	int ret;
-
 	mark_rodata(file);
=20
-	ret =3D init_pv_ops(file);
-	if (ret)
-		return ret;
+	if (init_pv_ops(file))
+		return -1;
=20
 	/*
 	 * Must be before add_{jump_call}_destination.
 	 */
-	ret =3D classify_symbols(file);
-	if (ret)
-		return ret;
+	if (classify_symbols(file))
+		return -1;
=20
-	ret =3D decode_instructions(file);
-	if (ret)
-		return ret;
+	if (decode_instructions(file))
+		return -1;
=20
-	ret =3D add_ignores(file);
-	if (ret)
-		return ret;
+	if (add_ignores(file))
+		return -1;
=20
 	add_uaccess_safe(file);
=20
-	ret =3D read_annotate(file, __annotate_early);
-	if (ret)
-		return ret;
+	if (read_annotate(file, __annotate_early))
+		return -1;
=20
 	/*
 	 * Must be before add_jump_destinations(), which depends on 'func'
@@ -2565,42 +2533,35 @@ static int decode_sections(struct objtool_file *file)
 	 */
 	if (opts.stackval || opts.orc || opts.uaccess || opts.noinstr ||
 	    opts.hack_jump_label) {
-		ret =3D add_special_section_alts(file);
-		if (ret)
-			return ret;
+		if (add_special_section_alts(file))
+			return -1;
 	}
=20
-	ret =3D add_jump_destinations(file);
-	if (ret)
-		return ret;
+	if (add_jump_destinations(file))
+		return -1;
=20
 	/*
 	 * Must be before add_call_destination(); it changes INSN_CALL to
 	 * INSN_JUMP.
 	 */
-	ret =3D read_annotate(file, __annotate_ifc);
-	if (ret)
-		return ret;
+	if (read_annotate(file, __annotate_ifc))
+		return -1;
=20
-	ret =3D add_call_destinations(file);
-	if (ret)
-		return ret;
+	if (add_call_destinations(file))
+		return -1;
=20
-	ret =3D add_jump_table_alts(file);
-	if (ret)
-		return ret;
+	if (add_jump_table_alts(file))
+		return -1;
=20
-	ret =3D read_unwind_hints(file);
-	if (ret)
-		return ret;
+	if (read_unwind_hints(file))
+		return -1;
=20
 	/*
 	 * Must be after add_call_destinations() such that it can override
 	 * dead_end_function() marks.
 	 */
-	ret =3D read_annotate(file, __annotate_late);
-	if (ret)
-		return ret;
+	if (read_annotate(file, __annotate_late))
+		return -1;
=20
 	return 0;
 }
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index c80fed8..c0beefb 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -133,7 +133,7 @@ int special_get_alts(struct elf *elf, struct list_head *a=
lts)
 	struct section *sec;
 	unsigned int nr_entries;
 	struct special_alt *alt;
-	int idx, ret;
+	int idx;
=20
 	INIT_LIST_HEAD(alts);
=20
@@ -157,11 +157,8 @@ int special_get_alts(struct elf *elf, struct list_head *=
alts)
 			}
 			memset(alt, 0, sizeof(*alt));
=20
-			ret =3D get_alt_entry(elf, entry, sec, idx, alt);
-			if (ret > 0)
-				continue;
-			if (ret < 0)
-				return ret;
+			if (get_alt_entry(elf, entry, sec, idx, alt))
+				return -1;
=20
 			list_add_tail(&alt->list, alts);
 		}

