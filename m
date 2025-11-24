Return-Path: <linux-tip-commits+bounces-7501-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAF6C7F87F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC690341E36
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E552F4A16;
	Mon, 24 Nov 2025 09:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AEHxklTj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MYnIwJwY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470EB2FCC1D;
	Mon, 24 Nov 2025 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975522; cv=none; b=Ix/j+x4SvL5GCihDsKHhRxqWSdOpkCh7TBeRXqrhkFa5YFAHWDlproe58fKH9QxLf2cldViEIlr1zo0y28b9yEttRKFLTdcwAItZppJ+l9HHacEwxJD7LD+KRdeOSLP7taALzSCmDgZGO8amU3EoAC0MnTSULSeuNJ2ZHvFldmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975522; c=relaxed/simple;
	bh=e8JH81BeNNumKW7dPpi3A9hY6O14vLyWkrt5PCVZV+8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NrPCp7Ei8VkAFUBfnrHX7h8LUaRvml/Rh0cZLEl2+MorX88JNoez9RlEQ+ls87U9B/19tjFwyKYSTlK94zFifyc1b1sBOmKOshiW75bvFrZIDqCFIuh90rQuLGADl2VCI8fvxDVaJIXTPwQO5oLEf0ZCNcs6LnX+5iGAEhC6ruc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AEHxklTj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MYnIwJwY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975517;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QNjiKgnRpQkWCKmJEoGJ07d6yvDd1n1Iivy2tWLTXgo=;
	b=AEHxklTjDrMLge9R1t1glYosars/b95lw4foLUn9NBzQmLl1r287iuMZXJ09zgbTAADVGi
	RhoiZbI4fjoN8hESHmyCryK2NG2PNsf+hf/oZhazue1K85yyilbW7aBQykXG+2tSxMpILO
	W7roxjHrmAQITYUCYpOihAmm9AOH3ff6znJCj6gIyMukt9dHOHt3fkuxce5BpNHRcsZKfg
	gQuoAqWm1z+MZunfYXK5bVVUSuk20W3zPX4wIAfM1qLoxYu0WuhsX7Y+yRPkGY2h8bq1vW
	zrtRuMmazYDnZtV6nv5Rs2NbTXKd096BrMaZ1CBW4FxtmCFCB9/FFiZMSkXp4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975517;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QNjiKgnRpQkWCKmJEoGJ07d6yvDd1n1Iivy2tWLTXgo=;
	b=MYnIwJwYXyYheAWnKy3e1EdBsCj8uyY1tQviiBcG65VYzJ121DX5BT/U51rttQm4v4DDwe
	ixiUGJUa+vvAtpBQ==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Extract code to validate instruction
 from the validate branch loop
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-9-alexandre.chartre@oracle.com>
References: <20251121095340.464045-9-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397551623.498.10765381084268700859.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     a0e5bf9fd6a048a8dc65f672e625674cd167d172
Gitweb:        https://git.kernel.org/tip/a0e5bf9fd6a048a8dc65f672e625674cd16=
7d172
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:18 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:08 +01:00

objtool: Extract code to validate instruction from the validate branch loop

The code to validate a branch loops through all instructions of the
branch and validate each instruction. Move the code to validate an
instruction to a separated function.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-9-alexandre.chartre@orac=
le.com
---
 tools/objtool/check.c | 386 +++++++++++++++++++++--------------------
 1 file changed, 205 insertions(+), 181 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4da1f07..6573056 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3654,253 +3654,277 @@ static void checksum_update_insn(struct objtool_fil=
e *file, struct symbol *func,
 	checksum_update(func, insn, &offset, sizeof(offset));
 }
=20
-/*
- * Follow the branch starting at the given instruction, and recursively foll=
ow
- * any other branches (jumps).  Meanwhile, track the frame pointer state at
- * each instruction and validate all the rules described in
- * tools/objtool/Documentation/objtool.txt.
- */
 static int validate_branch(struct objtool_file *file, struct symbol *func,
-			   struct instruction *insn, struct insn_state state)
+			   struct instruction *insn, struct insn_state state);
+
+static int validate_insn(struct objtool_file *file, struct symbol *func,
+			 struct instruction *insn, struct insn_state *statep,
+			 struct instruction *prev_insn, struct instruction *next_insn,
+			 bool *dead_end)
 {
 	struct alternative *alt;
-	struct instruction *next_insn, *prev_insn =3D NULL;
 	u8 visited;
 	int ret;
=20
-	if (func && func->ignore)
-		return 0;
+	/*
+	 * Any returns before the end of this function are effectively dead
+	 * ends, i.e. validate_branch() has reached the end of the branch.
+	 */
+	*dead_end =3D true;
=20
-	while (1) {
-		next_insn =3D next_insn_to_validate(file, insn);
+	visited =3D VISITED_BRANCH << statep->uaccess;
+	if (insn->visited & VISITED_BRANCH_MASK) {
+		if (!insn->hint && !insn_cfi_match(insn, &statep->cfi))
+			return 1;
=20
-		if (opts.checksum && func && insn->sec)
-			checksum_update_insn(file, func, insn);
+		if (insn->visited & visited)
+			return 0;
+	} else {
+		nr_insns_visited++;
+	}
=20
-		if (func && insn_func(insn) && func !=3D insn_func(insn)->pfunc) {
-			/* Ignore KCFI type preambles, which always fall through */
-			if (is_prefix_func(func))
-				return 0;
+	if (statep->noinstr)
+		statep->instr +=3D insn->instr;
=20
-			if (file->ignore_unreachables)
-				return 0;
+	if (insn->hint) {
+		if (insn->restore) {
+			struct instruction *save_insn, *i;
=20
-			WARN("%s() falls through to next function %s()",
-			     func->name, insn_func(insn)->name);
-			func->warned =3D 1;
+			i =3D insn;
+			save_insn =3D NULL;
=20
-			return 1;
-		}
+			sym_for_each_insn_continue_reverse(file, func, i) {
+				if (i->save) {
+					save_insn =3D i;
+					break;
+				}
+			}
=20
-		visited =3D VISITED_BRANCH << state.uaccess;
-		if (insn->visited & VISITED_BRANCH_MASK) {
-			if (!insn->hint && !insn_cfi_match(insn, &state.cfi))
+			if (!save_insn) {
+				WARN_INSN(insn, "no corresponding CFI save for CFI restore");
 				return 1;
+			}
=20
-			if (insn->visited & visited)
-				return 0;
-		} else {
-			nr_insns_visited++;
+			if (!save_insn->visited) {
+				/*
+				 * If the restore hint insn is at the
+				 * beginning of a basic block and was
+				 * branched to from elsewhere, and the
+				 * save insn hasn't been visited yet,
+				 * defer following this branch for now.
+				 * It will be seen later via the
+				 * straight-line path.
+				 */
+				if (!prev_insn)
+					return 0;
+
+				WARN_INSN(insn, "objtool isn't smart enough to handle this CFI save/rest=
ore combo");
+				return 1;
+			}
+
+			insn->cfi =3D save_insn->cfi;
+			nr_cfi_reused++;
 		}
=20
-		if (state.noinstr)
-			state.instr +=3D insn->instr;
+		statep->cfi =3D *insn->cfi;
+	} else {
+		/* XXX track if we actually changed statep->cfi */
=20
-		if (insn->hint) {
-			if (insn->restore) {
-				struct instruction *save_insn, *i;
+		if (prev_insn && !cficmp(prev_insn->cfi, &statep->cfi)) {
+			insn->cfi =3D prev_insn->cfi;
+			nr_cfi_reused++;
+		} else {
+			insn->cfi =3D cfi_hash_find_or_add(&statep->cfi);
+		}
+	}
=20
-				i =3D insn;
-				save_insn =3D NULL;
+	insn->visited |=3D visited;
=20
-				sym_for_each_insn_continue_reverse(file, func, i) {
-					if (i->save) {
-						save_insn =3D i;
-						break;
-					}
-				}
+	if (propagate_alt_cfi(file, insn))
+		return 1;
=20
-				if (!save_insn) {
-					WARN_INSN(insn, "no corresponding CFI save for CFI restore");
-					return 1;
-				}
+	if (insn->alts) {
+		for (alt =3D insn->alts; alt; alt =3D alt->next) {
+			ret =3D validate_branch(file, func, alt->insn, *statep);
+			if (ret) {
+				BT_INSN(insn, "(alt)");
+				return ret;
+			}
+		}
+	}
=20
-				if (!save_insn->visited) {
-					/*
-					 * If the restore hint insn is at the
-					 * beginning of a basic block and was
-					 * branched to from elsewhere, and the
-					 * save insn hasn't been visited yet,
-					 * defer following this branch for now.
-					 * It will be seen later via the
-					 * straight-line path.
-					 */
-					if (!prev_insn)
-						return 0;
+	if (skip_alt_group(insn))
+		return 0;
=20
-					WARN_INSN(insn, "objtool isn't smart enough to handle this CFI save/res=
tore combo");
-					return 1;
-				}
+	if (handle_insn_ops(insn, next_insn, statep))
+		return 1;
=20
-				insn->cfi =3D save_insn->cfi;
-				nr_cfi_reused++;
-			}
+	switch (insn->type) {
=20
-			state.cfi =3D *insn->cfi;
-		} else {
-			/* XXX track if we actually changed state.cfi */
+	case INSN_RETURN:
+		return validate_return(func, insn, statep);
=20
-			if (prev_insn && !cficmp(prev_insn->cfi, &state.cfi)) {
-				insn->cfi =3D prev_insn->cfi;
-				nr_cfi_reused++;
-			} else {
-				insn->cfi =3D cfi_hash_find_or_add(&state.cfi);
-			}
+	case INSN_CALL:
+	case INSN_CALL_DYNAMIC:
+		ret =3D validate_call(file, insn, statep);
+		if (ret)
+			return ret;
+
+		if (opts.stackval && func && !is_special_call(insn) &&
+		    !has_valid_stack_frame(statep)) {
+			WARN_INSN(insn, "call without frame pointer save/setup");
+			return 1;
 		}
=20
-		insn->visited |=3D visited;
+		break;
=20
-		if (propagate_alt_cfi(file, insn))
-			return 1;
+	case INSN_JUMP_CONDITIONAL:
+	case INSN_JUMP_UNCONDITIONAL:
+		if (is_sibling_call(insn)) {
+			ret =3D validate_sibling_call(file, insn, statep);
+			if (ret)
+				return ret;
=20
-		if (insn->alts) {
-			for (alt =3D insn->alts; alt; alt =3D alt->next) {
-				ret =3D validate_branch(file, func, alt->insn, state);
-				if (ret) {
-					BT_INSN(insn, "(alt)");
-					return ret;
-				}
+		} else if (insn->jump_dest) {
+			ret =3D validate_branch(file, func,
+					      insn->jump_dest, *statep);
+			if (ret) {
+				BT_INSN(insn, "(branch)");
+				return ret;
 			}
 		}
=20
-		if (skip_alt_group(insn))
+		if (insn->type =3D=3D INSN_JUMP_UNCONDITIONAL)
 			return 0;
=20
-		if (handle_insn_ops(insn, next_insn, &state))
-			return 1;
-
-		switch (insn->type) {
-
-		case INSN_RETURN:
-			return validate_return(func, insn, &state);
+		break;
=20
-		case INSN_CALL:
-		case INSN_CALL_DYNAMIC:
-			ret =3D validate_call(file, insn, &state);
+	case INSN_JUMP_DYNAMIC:
+	case INSN_JUMP_DYNAMIC_CONDITIONAL:
+		if (is_sibling_call(insn)) {
+			ret =3D validate_sibling_call(file, insn, statep);
 			if (ret)
 				return ret;
+		}
=20
-			if (opts.stackval && func && !is_special_call(insn) &&
-			    !has_valid_stack_frame(&state)) {
-				WARN_INSN(insn, "call without frame pointer save/setup");
-				return 1;
-			}
+		if (insn->type =3D=3D INSN_JUMP_DYNAMIC)
+			return 0;
=20
-			break;
+		break;
=20
-		case INSN_JUMP_CONDITIONAL:
-		case INSN_JUMP_UNCONDITIONAL:
-			if (is_sibling_call(insn)) {
-				ret =3D validate_sibling_call(file, insn, &state);
-				if (ret)
-					return ret;
+	case INSN_SYSCALL:
+		if (func && (!next_insn || !next_insn->hint)) {
+			WARN_INSN(insn, "unsupported instruction in callable function");
+			return 1;
+		}
=20
-			} else if (insn->jump_dest) {
-				ret =3D validate_branch(file, func,
-						      insn->jump_dest, state);
-				if (ret) {
-					BT_INSN(insn, "(branch)");
-					return ret;
-				}
-			}
+		break;
=20
-			if (insn->type =3D=3D INSN_JUMP_UNCONDITIONAL)
-				return 0;
+	case INSN_SYSRET:
+		if (func && (!next_insn || !next_insn->hint)) {
+			WARN_INSN(insn, "unsupported instruction in callable function");
+			return 1;
+		}
+
+		return 0;
=20
+	case INSN_STAC:
+		if (!opts.uaccess)
 			break;
=20
-		case INSN_JUMP_DYNAMIC:
-		case INSN_JUMP_DYNAMIC_CONDITIONAL:
-			if (is_sibling_call(insn)) {
-				ret =3D validate_sibling_call(file, insn, &state);
-				if (ret)
-					return ret;
-			}
+		if (statep->uaccess) {
+			WARN_INSN(insn, "recursive UACCESS enable");
+			return 1;
+		}
=20
-			if (insn->type =3D=3D INSN_JUMP_DYNAMIC)
-				return 0;
+		statep->uaccess =3D true;
+		break;
=20
+	case INSN_CLAC:
+		if (!opts.uaccess)
 			break;
=20
-		case INSN_SYSCALL:
-			if (func && (!next_insn || !next_insn->hint)) {
-				WARN_INSN(insn, "unsupported instruction in callable function");
-				return 1;
-			}
+		if (!statep->uaccess && func) {
+			WARN_INSN(insn, "redundant UACCESS disable");
+			return 1;
+		}
=20
-			break;
+		if (func_uaccess_safe(func) && !statep->uaccess_stack) {
+			WARN_INSN(insn, "UACCESS-safe disables UACCESS");
+			return 1;
+		}
=20
-		case INSN_SYSRET:
-			if (func && (!next_insn || !next_insn->hint)) {
-				WARN_INSN(insn, "unsupported instruction in callable function");
-				return 1;
-			}
+		statep->uaccess =3D false;
+		break;
=20
-			return 0;
+	case INSN_STD:
+		if (statep->df) {
+			WARN_INSN(insn, "recursive STD");
+			return 1;
+		}
=20
-		case INSN_STAC:
-			if (!opts.uaccess)
-				break;
+		statep->df =3D true;
+		break;
=20
-			if (state.uaccess) {
-				WARN_INSN(insn, "recursive UACCESS enable");
-				return 1;
-			}
+	case INSN_CLD:
+		if (!statep->df && func) {
+			WARN_INSN(insn, "redundant CLD");
+			return 1;
+		}
=20
-			state.uaccess =3D true;
-			break;
+		statep->df =3D false;
+		break;
=20
-		case INSN_CLAC:
-			if (!opts.uaccess)
-				break;
+	default:
+		break;
+	}
=20
-			if (!state.uaccess && func) {
-				WARN_INSN(insn, "redundant UACCESS disable");
-				return 1;
-			}
+	*dead_end =3D insn->dead_end;
=20
-			if (func_uaccess_safe(func) && !state.uaccess_stack) {
-				WARN_INSN(insn, "UACCESS-safe disables UACCESS");
-				return 1;
-			}
+	return 0;
+}
=20
-			state.uaccess =3D false;
-			break;
+/*
+ * Follow the branch starting at the given instruction, and recursively foll=
ow
+ * any other branches (jumps).  Meanwhile, track the frame pointer state at
+ * each instruction and validate all the rules described in
+ * tools/objtool/Documentation/objtool.txt.
+ */
+static int validate_branch(struct objtool_file *file, struct symbol *func,
+			   struct instruction *insn, struct insn_state state)
+{
+	struct instruction *next_insn, *prev_insn =3D NULL;
+	bool dead_end;
+	int ret;
=20
-		case INSN_STD:
-			if (state.df) {
-				WARN_INSN(insn, "recursive STD");
-				return 1;
-			}
+	if (func && func->ignore)
+		return 0;
=20
-			state.df =3D true;
-			break;
+	while (1) {
+		next_insn =3D next_insn_to_validate(file, insn);
=20
-		case INSN_CLD:
-			if (!state.df && func) {
-				WARN_INSN(insn, "redundant CLD");
-				return 1;
-			}
+		if (opts.checksum && func && insn->sec)
+			checksum_update_insn(file, func, insn);
=20
-			state.df =3D false;
-			break;
+		if (func && insn_func(insn) && func !=3D insn_func(insn)->pfunc) {
+			/* Ignore KCFI type preambles, which always fall through */
+			if (is_prefix_func(func))
+				return 0;
=20
-		default:
-			break;
+			if (file->ignore_unreachables)
+				return 0;
+
+			WARN("%s() falls through to next function %s()",
+			     func->name, insn_func(insn)->name);
+			func->warned =3D 1;
+
+			return 1;
 		}
=20
-		if (insn->dead_end)
-			return 0;
+		ret =3D validate_insn(file, func, insn, &state, prev_insn, next_insn,
+				    &dead_end);
+		if (dead_end)
+			break;
=20
 		if (!next_insn) {
 			if (state.cfi.cfa.base =3D=3D CFI_UNDEFINED)
@@ -3918,7 +3942,7 @@ static int validate_branch(struct objtool_file *file, s=
truct symbol *func,
 		insn =3D next_insn;
 	}
=20
-	return 0;
+	return ret;
 }
=20
 static int validate_unwind_hint(struct objtool_file *file,

