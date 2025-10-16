Return-Path: <linux-tip-commits+bounces-6889-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B32BE28DF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA58B1A627DB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2994B320CAB;
	Thu, 16 Oct 2025 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OqULafH2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jmyl+aiM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DAF31D376;
	Thu, 16 Oct 2025 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608381; cv=none; b=cZatESX6R75+/PoR6gLoKML7YUdbeC+krz8gCoX+xRR64v7zusLOyUiPJh2/LF+ubA0mSrnDg8yc03M1xL5A0y8vtuwrKydWJ82JE8sOLprrRfeMhEr8RfzHreiG/lW+nRHOOKhz9bfr/ps/7TihZUrbCmihqJLtkVGnRAfuAU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608381; c=relaxed/simple;
	bh=XV3+Ssc6zZX7P+IkbXkypcywwxkLiQPPfKlLQvlmeZE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Xoa9OpEhxg6KoeWOOxR56Sb4T9hSGn7qF/vZ29esHshsVlOl79cUaj5e0311fWj/xvdIe21BAqUlIhULTCLBGWLd1veRkaM5TZM/vpL1+GhuLa4+em7KCz2zL0nHy1v0ZJIXz5EzZFun56E0Jo5XBLUOfW4u1M7o+jvr34JQv/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OqULafH2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jmyl+aiM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608355;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ZV17rV2j0WSUSq23WVh/pwYOIiEwppe4/AyhTCZMAZo=;
	b=OqULafH2vhtEMrReDfDqgrpi0EHC9uP/PoCN+8dXszuSr7HSKUYDK9YH+ov83pzl7T2rzG
	YF4HH2uLnTIPjN5vAjl689DMNiM6+GsceqMPCR1RaXSAKXfq90bs0PsPvgTmPh53+EL1mN
	6KNdBdbxkHvmLmv4LTtbLQEy+jOOJIR/NkajXKGWLdFZ9GItImG8YtObMS4ATg2eMaA+o0
	gHVvJknX8lTwQ981jt0Ali53CHGyspXYnC2TgBaUpoWZr0W3WIOkHAaTnIynAe/48SO26L
	9UuH7ijIs8gxARhOdXHe/M9saQcY4vz00rmVEtj87PN87DUHhYlsYHCpthjK7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608355;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ZV17rV2j0WSUSq23WVh/pwYOIiEwppe4/AyhTCZMAZo=;
	b=jmyl+aiMn6VefuIi4l9XQi3I8iFMjF1ES4Z73iX+G+Wm/fv3KP6IMckN6NvKJYIuXLuwiD
	3cum1gFnXr6VafCQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Refactor add_jump_destinations()
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060835443.709179.18128828079144200637.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     a05de0a772ce423895a3b07504a9ed93ae75e912
Gitweb:        https://git.kernel.org/tip/a05de0a772ce423895a3b07504a9ed93ae7=
5e912
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:45 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:46:48 -07:00

objtool: Refactor add_jump_destinations()

The add_jump_destinations() logic is a bit weird and convoluted after
being incrementally tweaked over the years.  Refactor it to hopefully be
more logical and straightforward.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 212 ++++++++++++---------------
 tools/objtool/include/objtool/elf.h |   4 +-
 2 files changed, 101 insertions(+), 115 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b63f7c4..65a359c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1423,9 +1423,14 @@ static void add_return_call(struct objtool_file *file,=
 struct instruction *insn,
 }
=20
 static bool is_first_func_insn(struct objtool_file *file,
-			       struct instruction *insn, struct symbol *sym)
+			       struct instruction *insn)
 {
-	if (insn->offset =3D=3D sym->offset)
+	struct symbol *func =3D insn_func(insn);
+
+	if (!func)
+		return false;
+
+	if (insn->offset =3D=3D func->offset)
 		return true;
=20
 	/* Allow direct CALL/JMP past ENDBR */
@@ -1433,7 +1438,7 @@ static bool is_first_func_insn(struct objtool_file *fil=
e,
 		struct instruction *prev =3D prev_insn_same_sym(file, insn);
=20
 		if (prev && prev->type =3D=3D INSN_ENDBR &&
-		    insn->offset =3D=3D sym->offset + prev->len)
+		    insn->offset =3D=3D func->offset + prev->len)
 			return true;
 	}
=20
@@ -1441,43 +1446,22 @@ static bool is_first_func_insn(struct objtool_file *f=
ile,
 }
=20
 /*
- * A sibling call is a tail-call to another symbol -- to differentiate from a
- * recursive tail-call which is to the same symbol.
- */
-static bool jump_is_sibling_call(struct objtool_file *file,
-				 struct instruction *from, struct instruction *to)
-{
-	struct symbol *fs =3D from->sym;
-	struct symbol *ts =3D to->sym;
-
-	/* Not a sibling call if from/to a symbol hole */
-	if (!fs || !ts)
-		return false;
-
-	/* Not a sibling call if not targeting the start of a symbol. */
-	if (!is_first_func_insn(file, to, ts))
-		return false;
-
-	/* Disallow sibling calls into STT_NOTYPE */
-	if (is_notype_sym(ts))
-		return false;
-
-	/* Must not be self to be a sibling */
-	return fs->pfunc !=3D ts->pfunc;
-}
-
-/*
  * Find the destination instructions for all jumps.
  */
 static int add_jump_destinations(struct objtool_file *file)
 {
-	struct instruction *insn, *jump_dest;
+	struct instruction *insn;
 	struct reloc *reloc;
-	struct section *dest_sec;
-	unsigned long dest_off;
=20
 	for_each_insn(file, insn) {
 		struct symbol *func =3D insn_func(insn);
+		struct instruction *dest_insn;
+		struct section *dest_sec;
+		struct symbol *dest_sym;
+		unsigned long dest_off;
+
+		if (!is_static_jump(insn))
+			continue;
=20
 		if (insn->jump_dest) {
 			/*
@@ -1486,51 +1470,53 @@ static int add_jump_destinations(struct objtool_file =
*file)
 			 */
 			continue;
 		}
-		if (!is_static_jump(insn))
-			continue;
=20
 		reloc =3D insn_reloc(file, insn);
 		if (!reloc) {
 			dest_sec =3D insn->sec;
 			dest_off =3D arch_jump_destination(insn);
-		} else if (is_sec_sym(reloc->sym)) {
-			dest_sec =3D reloc->sym->sec;
-			dest_off =3D arch_insn_adjusted_addend(insn, reloc);
-		} else if (reloc->sym->retpoline_thunk) {
-			if (add_retpoline_call(file, insn))
-				return -1;
-			continue;
-		} else if (reloc->sym->return_thunk) {
-			add_return_call(file, insn, true);
-			continue;
-		} else if (func) {
-			/*
-			 * External sibling call or internal sibling call with
-			 * STT_FUNC reloc.
-			 */
-			if (add_call_dest(file, insn, reloc->sym, true))
-				return -1;
-			continue;
-		} else if (reloc->sym->sec->idx) {
-			dest_sec =3D reloc->sym->sec;
-			dest_off =3D reloc->sym->sym.st_value +
-				   arch_insn_adjusted_addend(insn, reloc);
+			dest_sym =3D dest_sec->sym;
 		} else {
-			/* non-func asm code jumping to another file */
-			continue;
+			dest_sym =3D reloc->sym;
+			if (is_undef_sym(dest_sym)) {
+				if (dest_sym->retpoline_thunk) {
+					if (add_retpoline_call(file, insn))
+						return -1;
+					continue;
+				}
+
+				if (dest_sym->return_thunk) {
+					add_return_call(file, insn, true);
+					continue;
+				}
+
+				/* External symbol */
+				if (func) {
+					/* External sibling call */
+					if (add_call_dest(file, insn, dest_sym, true))
+						return -1;
+					continue;
+				}
+
+				/* Non-func asm code jumping to external symbol */
+				continue;
+			}
+
+			dest_sec =3D dest_sym->sec;
+			dest_off =3D dest_sym->offset + arch_insn_adjusted_addend(insn, reloc);
 		}
=20
-		jump_dest =3D find_insn(file, dest_sec, dest_off);
-		if (!jump_dest) {
+		dest_insn =3D find_insn(file, dest_sec, dest_off);
+		if (!dest_insn) {
 			struct symbol *sym =3D find_symbol_by_offset(dest_sec, dest_off);
=20
 			/*
-			 * This is a special case for retbleed_untrain_ret().
-			 * It jumps to __x86_return_thunk(), but objtool
-			 * can't find the thunk's starting RET
-			 * instruction, because the RET is also in the
-			 * middle of another instruction.  Objtool only
-			 * knows about the outer instruction.
+			 * retbleed_untrain_ret() jumps to
+			 * __x86_return_thunk(), but objtool can't find
+			 * the thunk's starting RET instruction,
+			 * because the RET is also in the middle of
+			 * another instruction.  Objtool only knows
+			 * about the outer instruction.
 			 */
 			if (sym && sym->embedded_insn) {
 				add_return_call(file, insn, false);
@@ -1538,73 +1524,73 @@ static int add_jump_destinations(struct objtool_file =
*file)
 			}
=20
 			/*
-			 * GCOV/KCOV dead code can jump to the end of the
-			 * function/section.
+			 * GCOV/KCOV dead code can jump to the end of
+			 * the function/section.
 			 */
 			if (file->ignore_unreachables && func &&
 			    dest_sec =3D=3D insn->sec &&
 			    dest_off =3D=3D func->offset + func->len)
 				continue;
=20
-			ERROR_INSN(insn, "can't find jump dest instruction at %s+0x%lx",
-				   dest_sec->name, dest_off);
+			ERROR_INSN(insn, "can't find jump dest instruction at %s",
+				   offstr(dest_sec, dest_off));
 			return -1;
 		}
=20
-		/*
-		 * An intra-TU jump in retpoline.o might not have a relocation
-		 * for its jump dest, in which case the above
-		 * add_{retpoline,return}_call() didn't happen.
-		 */
-		if (jump_dest->sym && jump_dest->offset =3D=3D jump_dest->sym->offset) {
-			if (jump_dest->sym->retpoline_thunk) {
-				if (add_retpoline_call(file, insn))
-					return -1;
-				continue;
-			}
-			if (jump_dest->sym->return_thunk) {
-				add_return_call(file, insn, true);
-				continue;
-			}
+		if (!dest_sym || is_sec_sym(dest_sym)) {
+			dest_sym =3D dest_insn->sym;
+			if (!dest_sym)
+				goto set_jump_dest;
+		}
+
+		if (dest_sym->retpoline_thunk && dest_insn->offset =3D=3D dest_sym->offset=
) {
+			if (add_retpoline_call(file, insn))
+				return -1;
+			continue;
+		}
+
+		if (dest_sym->return_thunk && dest_insn->offset =3D=3D dest_sym->offset) {
+			add_return_call(file, insn, true);
+			continue;
 		}
=20
+		if (!insn->sym || insn->sym =3D=3D dest_insn->sym)
+			goto set_jump_dest;
+
 		/*
-		 * Cross-function jump.
+		 * Internal cross-function jump.
 		 */
=20
-		if (func && insn_func(jump_dest) && !func->cold &&
-		    insn_func(jump_dest)->cold) {
-
-			/*
-			 * For GCC 8+, create parent/child links for any cold
-			 * subfunctions.  This is _mostly_ redundant with a
-			 * similar initialization in read_symbols().
-			 *
-			 * If a function has aliases, we want the *first* such
-			 * function in the symbol table to be the subfunction's
-			 * parent.  In that case we overwrite the
-			 * initialization done in read_symbols().
-			 *
-			 * However this code can't completely replace the
-			 * read_symbols() code because this doesn't detect the
-			 * case where the parent function's only reference to a
-			 * subfunction is through a jump table.
-			 */
-			func->cfunc =3D insn_func(jump_dest);
-			insn_func(jump_dest)->pfunc =3D func;
+		/*
+		 * For GCC 8+, create parent/child links for any cold
+		 * subfunctions.  This is _mostly_ redundant with a
+		 * similar initialization in read_symbols().
+		 *
+		 * If a function has aliases, we want the *first* such
+		 * function in the symbol table to be the subfunction's
+		 * parent.  In that case we overwrite the
+		 * initialization done in read_symbols().
+		 *
+		 * However this code can't completely replace the
+		 * read_symbols() code because this doesn't detect the
+		 * case where the parent function's only reference to a
+		 * subfunction is through a jump table.
+		 */
+		if (func && dest_sym->cold) {
+			func->cfunc =3D dest_sym;
+			dest_sym->pfunc =3D func;
+			goto set_jump_dest;
 		}
=20
-		if (jump_is_sibling_call(file, insn, jump_dest)) {
-			/*
-			 * Internal sibling call without reloc or with
-			 * STT_SECTION reloc.
-			 */
-			if (add_call_dest(file, insn, insn_func(jump_dest), true))
+		if (is_first_func_insn(file, dest_insn)) {
+			/* Internal sibling call */
+			if (add_call_dest(file, insn, dest_sym, true))
 				return -1;
 			continue;
 		}
=20
-		insn->jump_dest =3D jump_dest;
+set_jump_dest:
+		insn->jump_dest =3D dest_insn;
 	}
=20
 	return 0;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objt=
ool/elf.h
index 79edf82..07fc41f 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -181,9 +181,9 @@ static inline unsigned int elf_text_rela_type(struct elf =
*elf)
 	return elf_addr_size(elf) =3D=3D 4 ? R_TEXT32 : R_TEXT64;
 }
=20
-static inline bool sym_has_sec(struct symbol *sym)
+static inline bool is_undef_sym(struct symbol *sym)
 {
-	return sym->sec->idx;
+	return !sym->sec->idx;
 }
=20
 static inline bool is_null_sym(struct symbol *sym)

