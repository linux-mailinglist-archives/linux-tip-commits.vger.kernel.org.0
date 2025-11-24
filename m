Return-Path: <linux-tip-commits+bounces-7498-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1532C7F86F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5D31348C73
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE992FD7D3;
	Mon, 24 Nov 2025 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NYa5uRPg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XxeUl7qV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DC52FC873;
	Mon, 24 Nov 2025 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975519; cv=none; b=VksSrE0jS/mQdIufVdDpgX18cCkVbJPz1r1d1CoxxXTHIx8aworBWWhK/q9PTh+e3/9OsNFRkuubGzpXrO8PhECEuQ5L0ppnsfuvTprjy14QxnKXj7ILSfykDTV7mF9P1ai90AYCp3rG9JgO4MjOOMlTLfEFn5xC+kf/zZlmPZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975519; c=relaxed/simple;
	bh=U41RojWLCt5tqtrKbn6hyaIflyxg6upKkRDZqNJ9HBQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c1baZpT/8tu7QFsa8N8XIUwUVXlbWW3lXyT2Q5Hto+gXQSFjIyO6elzDrxz74xQJX/mmoXJlhJxdzN8CV7z4qfa/P38viWjmBZlsq9oS+SOl5WpoCanysy1C5IhsCPMYahvLonb/Mhjr1UrNUOEgDp+sO0UjA5K/X5objdj86Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NYa5uRPg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XxeUl7qV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975515;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01QuQZbPX7/Wj5yP9ydfEk4rRtNO2SicoVTumx22V9I=;
	b=NYa5uRPgpHowD/uol9ZvrJDp+CjdBduX9BN6R5Qe0Gf9teCzYHxwhGq4UUt2a9stqEjGKi
	Hm5yM1iDNf25r2R9D1cGsCdCSMCA2b4lY3YoxxX4KovHVbWAtJMdb4HBGOJpaRFT3SaaBJ
	nyapUYpRLl29BGRMix/NLN8vG9yWJM+q3EArIR6PPpmbWVhhUx20Cd7u/h6gU9yItmq/KW
	vZcLKmMTekHJo/Cu8SlTV96xL5p04YUrcf1P1WRj3ddo36tuMe0IuRKszdV5C/6r6b8izf
	20MJHQA1hznNuWKgdkhuZ2bRcdLU/3Dxbl0SJ9HiBV6HGtnZPscP6bgveVmPPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975515;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=01QuQZbPX7/Wj5yP9ydfEk4rRtNO2SicoVTumx22V9I=;
	b=XxeUl7qVY5W46t2f/kBmK6zxzg10T3PAIWLTOFw/zAnhOSLTYUMXlldB1HBaIOEMJllAYe
	Txho/yfWjQrgcQCA==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add option to trace function validation
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-11-alexandre.chartre@oracle.com>
References: <20251121095340.464045-11-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397551402.498.14470686269813371026.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     70589843b36fee0c6e73632469da4e5fd11f0968
Gitweb:        https://git.kernel.org/tip/70589843b36fee0c6e73632469da4e5fd11=
f0968
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:20 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:09 +01:00

objtool: Add option to trace function validation

Add an option to trace and have information during the validation
of specified functions. Functions are specified with the --trace
option which can be a single function name (e.g. --trace foo to
trace the function with the name "foo"), or a shell wildcard
pattern (e.g. --trace foo* to trace all functions with a name
starting with "foo").

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-11-alexandre.chartre@ora=
cle.com
---
 tools/objtool/Build                     |   1 +-
 tools/objtool/builtin-check.c           |   1 +-
 tools/objtool/check.c                   | 104 +++++++++++++++++----
 tools/objtool/disas.c                   | 115 +++++++++++++++++++++++-
 tools/objtool/include/objtool/builtin.h |   1 +-
 tools/objtool/include/objtool/check.h   |   6 +-
 tools/objtool/include/objtool/disas.h   |  11 ++-
 tools/objtool/include/objtool/trace.h   |  68 ++++++++++++++-
 tools/objtool/include/objtool/warn.h    |   1 +-
 tools/objtool/trace.c                   |   9 ++-
 10 files changed, 299 insertions(+), 18 deletions(-)
 create mode 100644 tools/objtool/include/objtool/trace.h
 create mode 100644 tools/objtool/trace.c

diff --git a/tools/objtool/Build b/tools/objtool/Build
index 9d1e8f2..9982e66 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -9,6 +9,7 @@ objtool-y +=3D elf.o
 objtool-y +=3D objtool.o
=20
 objtool-$(BUILD_DISAS) +=3D disas.o
+objtool-$(BUILD_DISAS) +=3D trace.o
=20
 objtool-$(BUILD_ORC) +=3D orc_gen.o orc_dump.o
 objtool-$(BUILD_KLP) +=3D builtin-klp.o klp-diff.o klp-post-link.o
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index aab7fa9..3329d37 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -103,6 +103,7 @@ static const struct option check_options[] =3D {
 	OPT_STRING('o',		 "output", &opts.output, "file", "output file name"),
 	OPT_BOOLEAN(0,		 "sec-address", &opts.sec_address, "print section addresses=
 in warnings"),
 	OPT_BOOLEAN(0,		 "stats", &opts.stats, "print statistics"),
+	OPT_STRING(0,		 "trace", &opts.trace, "func", "trace function validation"),
 	OPT_BOOLEAN('v',	 "verbose", &opts.verbose, "verbose warnings"),
 	OPT_BOOLEAN(0,		 "werror", &opts.werror, "return error on warnings"),
=20
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0fbf0eb..409dec9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4,6 +4,7 @@
  */
=20
 #define _GNU_SOURCE /* memmem() */
+#include <fnmatch.h>
 #include <string.h>
 #include <stdlib.h>
 #include <inttypes.h>
@@ -15,6 +16,7 @@
 #include <objtool/disas.h>
 #include <objtool/check.h>
 #include <objtool/special.h>
+#include <objtool/trace.h>
 #include <objtool/warn.h>
 #include <objtool/checksum.h>
 #include <objtool/util.h>
@@ -37,7 +39,9 @@ static struct cfi_state init_cfi;
 static struct cfi_state func_cfi;
 static struct cfi_state force_undefined_cfi;
=20
-static size_t sym_name_max_len;
+struct disas_context *objtool_disas_ctx;
+
+size_t sym_name_max_len;
=20
 struct instruction *find_insn(struct objtool_file *file,
 			      struct section *sec, unsigned long offset)
@@ -3556,8 +3560,10 @@ static bool skip_alt_group(struct instruction *insn)
 		return false;
=20
 	/* ANNOTATE_IGNORE_ALTERNATIVE */
-	if (insn->alt_group->ignore)
+	if (insn->alt_group->ignore) {
+		TRACE_INSN(insn, "alt group ignored");
 		return true;
+	}
=20
 	/*
 	 * For NOP patched with CLAC/STAC, only follow the latter to avoid
@@ -3663,6 +3669,8 @@ static void checksum_update_insn(struct objtool_file *f=
ile, struct symbol *func,
=20
 static int validate_branch(struct objtool_file *file, struct symbol *func,
 			   struct instruction *insn, struct insn_state state);
+static int do_validate_branch(struct objtool_file *file, struct symbol *func,
+			      struct instruction *insn, struct insn_state state);
=20
 static int validate_insn(struct objtool_file *file, struct symbol *func,
 			 struct instruction *insn, struct insn_state *statep,
@@ -3684,8 +3692,10 @@ static int validate_insn(struct objtool_file *file, st=
ruct symbol *func,
 		if (!insn->hint && !insn_cfi_match(insn, &statep->cfi))
 			return 1;
=20
-		if (insn->visited & visited)
+		if (insn->visited & visited) {
+			TRACE_INSN(insn, "already visited");
 			return 0;
+		}
 	} else {
 		nr_insns_visited++;
 	}
@@ -3722,8 +3732,10 @@ static int validate_insn(struct objtool_file *file, st=
ruct symbol *func,
 				 * It will be seen later via the
 				 * straight-line path.
 				 */
-				if (!prev_insn)
+				if (!prev_insn) {
+					TRACE_INSN(insn, "defer restore");
 					return 0;
+				}
=20
 				WARN_INSN(insn, "objtool isn't smart enough to handle this CFI save/rest=
ore combo");
 				return 1;
@@ -3751,13 +3763,23 @@ static int validate_insn(struct objtool_file *file, s=
truct symbol *func,
 		return 1;
=20
 	if (insn->alts) {
+		int i, num_alts;
+
+		num_alts =3D 0;
+		for (alt =3D insn->alts; alt; alt =3D alt->next)
+			num_alts++;
+
+		i =3D 1;
 		for (alt =3D insn->alts; alt; alt =3D alt->next) {
+			TRACE_INSN(insn, "alternative %d/%d", i, num_alts);
 			ret =3D validate_branch(file, func, alt->insn, *statep);
 			if (ret) {
 				BT_INSN(insn, "(alt)");
 				return ret;
 			}
+			i++;
 		}
+		TRACE_INSN(insn, "alternative DEFAULT");
 	}
=20
 	if (skip_alt_group(insn))
@@ -3769,10 +3791,16 @@ static int validate_insn(struct objtool_file *file, s=
truct symbol *func,
 	switch (insn->type) {
=20
 	case INSN_RETURN:
+		TRACE_INSN(insn, "return");
 		return validate_return(func, insn, statep);
=20
 	case INSN_CALL:
 	case INSN_CALL_DYNAMIC:
+		if (insn->type =3D=3D INSN_CALL)
+			TRACE_INSN(insn, "call");
+		else
+			TRACE_INSN(insn, "indirect call");
+
 		ret =3D validate_call(file, insn, statep);
 		if (ret)
 			return ret;
@@ -3788,13 +3816,18 @@ static int validate_insn(struct objtool_file *file, s=
truct symbol *func,
 	case INSN_JUMP_CONDITIONAL:
 	case INSN_JUMP_UNCONDITIONAL:
 		if (is_sibling_call(insn)) {
+			TRACE_INSN(insn, "sibling call");
 			ret =3D validate_sibling_call(file, insn, statep);
 			if (ret)
 				return ret;
=20
 		} else if (insn->jump_dest) {
-			ret =3D validate_branch(file, func,
-					      insn->jump_dest, *statep);
+			if (insn->type =3D=3D INSN_JUMP_UNCONDITIONAL)
+				TRACE_INSN(insn, "unconditional jump");
+			else
+				TRACE_INSN(insn, "jump taken");
+
+			ret =3D validate_branch(file, func, insn->jump_dest, *statep);
 			if (ret) {
 				BT_INSN(insn, "(branch)");
 				return ret;
@@ -3804,10 +3837,12 @@ static int validate_insn(struct objtool_file *file, s=
truct symbol *func,
 		if (insn->type =3D=3D INSN_JUMP_UNCONDITIONAL)
 			return 0;
=20
+		TRACE_INSN(insn, "jump not taken");
 		break;
=20
 	case INSN_JUMP_DYNAMIC:
 	case INSN_JUMP_DYNAMIC_CONDITIONAL:
+		TRACE_INSN(insn, "indirect jump");
 		if (is_sibling_call(insn)) {
 			ret =3D validate_sibling_call(file, insn, statep);
 			if (ret)
@@ -3820,6 +3855,7 @@ static int validate_insn(struct objtool_file *file, str=
uct symbol *func,
 		break;
=20
 	case INSN_SYSCALL:
+		TRACE_INSN(insn, "syscall");
 		if (func && (!next_insn || !next_insn->hint)) {
 			WARN_INSN(insn, "unsupported instruction in callable function");
 			return 1;
@@ -3828,6 +3864,7 @@ static int validate_insn(struct objtool_file *file, str=
uct symbol *func,
 		break;
=20
 	case INSN_SYSRET:
+		TRACE_INSN(insn, "sysret");
 		if (func && (!next_insn || !next_insn->hint)) {
 			WARN_INSN(insn, "unsupported instruction in callable function");
 			return 1;
@@ -3836,6 +3873,7 @@ static int validate_insn(struct objtool_file *file, str=
uct symbol *func,
 		return 0;
=20
 	case INSN_STAC:
+		TRACE_INSN(insn, "stac");
 		if (!opts.uaccess)
 			break;
=20
@@ -3848,6 +3886,7 @@ static int validate_insn(struct objtool_file *file, str=
uct symbol *func,
 		break;
=20
 	case INSN_CLAC:
+		TRACE_INSN(insn, "clac");
 		if (!opts.uaccess)
 			break;
=20
@@ -3865,6 +3904,7 @@ static int validate_insn(struct objtool_file *file, str=
uct symbol *func,
 		break;
=20
 	case INSN_STD:
+		TRACE_INSN(insn, "std");
 		if (statep->df) {
 			WARN_INSN(insn, "recursive STD");
 			return 1;
@@ -3874,6 +3914,7 @@ static int validate_insn(struct objtool_file *file, str=
uct symbol *func,
 		break;
=20
 	case INSN_CLD:
+		TRACE_INSN(insn, "cld");
 		if (!statep->df && func) {
 			WARN_INSN(insn, "redundant CLD");
 			return 1;
@@ -3886,8 +3927,10 @@ static int validate_insn(struct objtool_file *file, st=
ruct symbol *func,
 		break;
 	}
=20
-	*dead_end =3D insn->dead_end;
+	if (insn->dead_end)
+		TRACE_INSN(insn, "dead end");
=20
+	*dead_end =3D insn->dead_end;
 	return 0;
 }
=20
@@ -3897,8 +3940,8 @@ static int validate_insn(struct objtool_file *file, str=
uct symbol *func,
  * each instruction and validate all the rules described in
  * tools/objtool/Documentation/objtool.txt.
  */
-static int validate_branch(struct objtool_file *file, struct symbol *func,
-			   struct instruction *insn, struct insn_state state)
+static int do_validate_branch(struct objtool_file *file, struct symbol *func,
+			      struct instruction *insn, struct insn_state state)
 {
 	struct instruction *next_insn, *prev_insn =3D NULL;
 	bool dead_end;
@@ -3907,7 +3950,8 @@ static int validate_branch(struct objtool_file *file, s=
truct symbol *func,
 	if (func && func->ignore)
 		return 0;
=20
-	while (1) {
+	do {
+		insn->trace =3D 0;
 		next_insn =3D next_insn_to_validate(file, insn);
=20
 		if (opts.checksum && func && insn->sec)
@@ -3930,10 +3974,15 @@ static int validate_branch(struct objtool_file *file,=
 struct symbol *func,
=20
 		ret =3D validate_insn(file, func, insn, &state, prev_insn, next_insn,
 				    &dead_end);
-		if (dead_end)
-			break;
=20
-		if (!next_insn) {
+		if (!insn->trace) {
+			if (ret)
+				TRACE_INSN(insn, "warning (%d)", ret);
+			else
+				TRACE_INSN(insn, NULL);
+		}
+
+		if (!dead_end && !next_insn) {
 			if (state.cfi.cfa.base =3D=3D CFI_UNDEFINED)
 				return 0;
 			if (file->ignore_unreachables)
@@ -3947,7 +3996,20 @@ static int validate_branch(struct objtool_file *file, =
struct symbol *func,
=20
 		prev_insn =3D insn;
 		insn =3D next_insn;
-	}
+
+	} while (!dead_end);
+
+	return ret;
+}
+
+static int validate_branch(struct objtool_file *file, struct symbol *func,
+			   struct instruction *insn, struct insn_state state)
+{
+	int ret;
+
+	trace_depth_inc();
+	ret =3D do_validate_branch(file, func, insn, state);
+	trace_depth_dec();
=20
 	return ret;
 }
@@ -4408,10 +4470,18 @@ static int validate_symbol(struct objtool_file *file,=
 struct section *sec,
 	if (opts.checksum)
 		checksum_init(func);
=20
+	if (opts.trace && !fnmatch(opts.trace, sym->name, 0)) {
+		trace_enable();
+		TRACE("%s: validation begin\n", sym->name);
+	}
+
 	ret =3D validate_branch(file, func, insn, *state);
 	if (ret)
 		BT_INSN(insn, "<=3D=3D=3D (sym)");
=20
+	TRACE("%s: validation %s\n\n", sym->name, ret ? "failed" : "end");
+	trace_disable();
+
 	if (opts.checksum)
 		checksum_finish(func);
=20
@@ -4823,8 +4893,6 @@ static void free_insns(struct objtool_file *file)
 		free(chunk->addr);
 }
=20
-static struct disas_context *objtool_disas_ctx;
-
 const char *objtool_disas_insn(struct instruction *insn)
 {
 	struct disas_context *dctx =3D objtool_disas_ctx;
@@ -4846,8 +4914,10 @@ int check(struct objtool_file *file)
 	 * disassembly context to disassemble instruction or function
 	 * on warning or backtrace.
 	 */
-	if (opts.verbose || opts.backtrace) {
+	if (opts.verbose || opts.backtrace || opts.trace) {
 		disas_ctx =3D disas_context_create(file);
+		if (!disas_ctx)
+			opts.trace =3D false;
 		objtool_disas_ctx =3D disas_ctx;
 	}
=20
diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index a030b06..0ca6e6c 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -308,6 +308,121 @@ char *disas_result(struct disas_context *dctx)
 	return dctx->result;
 }
=20
+#define DISAS_INSN_OFFSET_SPACE		10
+#define DISAS_INSN_SPACE		60
+
+/*
+ * Print a message in the instruction flow. If insn is not NULL then
+ * the instruction address is printed in addition of the message,
+ * otherwise only the message is printed. In all cases, the instruction
+ * itself is not printed.
+ */
+static int disas_vprint(FILE *stream, struct section *sec, unsigned long off=
set,
+			int depth, const char *format, va_list ap)
+{
+	const char *addr_str;
+	int i, n;
+	int len;
+
+	len =3D sym_name_max_len + DISAS_INSN_OFFSET_SPACE;
+	if (depth < 0) {
+		len +=3D depth;
+		depth =3D 0;
+	}
+
+	n =3D 0;
+
+	if (sec) {
+		addr_str =3D offstr(sec, offset);
+		n +=3D fprintf(stream, "%6lx:  %-*s  ", offset, len, addr_str);
+		free((char *)addr_str);
+	} else {
+		len +=3D DISAS_INSN_OFFSET_SPACE + 1;
+		n +=3D fprintf(stream, "%-*s", len, "");
+	}
+
+	/* print vertical bars to show the code flow */
+	for (i =3D 0; i < depth; i++)
+		n +=3D fprintf(stream, "| ");
+
+	if (format)
+		n +=3D vfprintf(stream, format, ap);
+
+	return n;
+}
+
+/*
+ * Print a message in the instruction flow. If insn is not NULL then
+ * the instruction address is printed in addition of the message,
+ * otherwise only the message is printed. In all cases, the instruction
+ * itself is not printed.
+ */
+void disas_print_info(FILE *stream, struct instruction *insn, int depth,
+		      const char *format, ...)
+{
+	struct section *sec;
+	unsigned long off;
+	va_list args;
+
+	if (insn) {
+		sec =3D insn->sec;
+		off =3D insn->offset;
+	} else {
+		sec =3D NULL;
+		off =3D 0;
+	}
+
+	va_start(args, format);
+	disas_vprint(stream, sec, off, depth, format, args);
+	va_end(args);
+}
+
+/*
+ * Print an instruction address (offset and function), the instruction itself
+ * and an optional message.
+ */
+void disas_print_insn(FILE *stream, struct disas_context *dctx,
+		      struct instruction *insn, int depth,
+		      const char *format, ...)
+{
+	char fake_nop_insn[32];
+	const char *insn_str;
+	bool fake_nop;
+	va_list args;
+	int len;
+
+	/*
+	 * Alternative can insert a fake nop, sometimes with no
+	 * associated section so nothing to disassemble.
+	 */
+	fake_nop =3D (!insn->sec && insn->type =3D=3D INSN_NOP);
+	if (fake_nop) {
+		snprintf(fake_nop_insn, 32, "<fake nop> (%d bytes)", insn->len);
+		insn_str =3D fake_nop_insn;
+	} else {
+		disas_insn(dctx, insn);
+		insn_str =3D disas_result(dctx);
+	}
+
+	/* print the instruction */
+	len =3D (depth + 1) * 2 < DISAS_INSN_SPACE ? DISAS_INSN_SPACE - (depth+1) *=
 2 : 1;
+	disas_print_info(stream, insn, depth, "%-*s", len, insn_str);
+
+	/* print message if any */
+	if (!format)
+		return;
+
+	if (strcmp(format, "\n") =3D=3D 0) {
+		fprintf(stream, "\n");
+		return;
+	}
+
+	fprintf(stream, " - ");
+	va_start(args, format);
+	vfprintf(stream, format, args);
+	va_end(args);
+}
+
 /*
  * Disassemble a single instruction. Return the size of the instruction.
  */
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/=
objtool/builtin.h
index bb0b25e..991365c 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -41,6 +41,7 @@ struct opts {
 	const char *output;
 	bool sec_address;
 	bool stats;
+	const char *trace;
 	bool verbose;
 	bool werror;
 };
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/ob=
jtool/check.h
index f96aabd..fde9586 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -66,7 +66,8 @@ struct instruction {
 	    visited		: 4,
 	    no_reloc		: 1,
 	    hole		: 1,
-	    fake		: 1;
+	    fake		: 1,
+	    trace		: 1;
 		/* 9 bit hole */
=20
 	struct alt_group *alt_group;
@@ -143,4 +144,7 @@ struct instruction *next_insn_same_sec(struct objtool_fil=
e *file, struct instruc
=20
 const char *objtool_disas_insn(struct instruction *insn);
=20
+extern size_t sym_name_max_len;
+extern struct disas_context *objtool_disas_ctx;
+
 #endif /* _CHECK_H */
diff --git a/tools/objtool/include/objtool/disas.h b/tools/objtool/include/ob=
jtool/disas.h
index 1aee1fb..5db75d0 100644
--- a/tools/objtool/include/objtool/disas.h
+++ b/tools/objtool/include/objtool/disas.h
@@ -19,6 +19,11 @@ int disas_info_init(struct disassemble_info *dinfo,
 		    const char *options);
 size_t disas_insn(struct disas_context *dctx, struct instruction *insn);
 char *disas_result(struct disas_context *dctx);
+void disas_print_info(FILE *stream, struct instruction *insn, int depth,
+		      const char *format, ...);
+void disas_print_insn(FILE *stream, struct disas_context *dctx,
+		      struct instruction *insn, int depth,
+		      const char *format, ...);
=20
 #else /* DISAS */
=20
@@ -51,6 +56,12 @@ static inline char *disas_result(struct disas_context *dct=
x)
 	return NULL;
 }
=20
+static inline void disas_print_info(FILE *stream, struct instruction *insn,
+				    int depth, const char *format, ...) {}
+static inline void disas_print_insn(FILE *stream, struct disas_context *dctx,
+				    struct instruction *insn, int depth,
+				    const char *format, ...) {}
+
 #endif /* DISAS */
=20
 #endif /* _DISAS_H */
diff --git a/tools/objtool/include/objtool/trace.h b/tools/objtool/include/ob=
jtool/trace.h
new file mode 100644
index 0000000..3f3c830
--- /dev/null
+++ b/tools/objtool/include/objtool/trace.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2025, Oracle and/or its affiliates.
+ */
+
+#ifndef _TRACE_H
+#define _TRACE_H
+
+#include <objtool/check.h>
+#include <objtool/disas.h>
+
+#ifdef DISAS
+
+extern bool trace;
+extern int trace_depth;
+
+#define TRACE(fmt, ...)						\
+({	if (trace)						\
+		fprintf(stderr, fmt, ##__VA_ARGS__);		\
+})
+
+#define TRACE_INSN(insn, fmt, ...)				\
+({								\
+	if (trace) {						\
+		disas_print_insn(stderr, objtool_disas_ctx,	\
+				 insn, trace_depth - 1,	\
+				 fmt, ##__VA_ARGS__);		\
+		fprintf(stderr, "\n");				\
+		insn->trace =3D 1;				\
+	}							\
+})
+
+static inline void trace_enable(void)
+{
+	trace =3D true;
+	trace_depth =3D 0;
+}
+
+static inline void trace_disable(void)
+{
+	trace =3D false;
+}
+
+static inline void trace_depth_inc(void)
+{
+	if (trace)
+		trace_depth++;
+}
+
+static inline void trace_depth_dec(void)
+{
+	if (trace)
+		trace_depth--;
+}
+
+#else /* DISAS */
+
+#define TRACE(fmt, ...) ({})
+#define TRACE_INSN(insn, fmt, ...) ({})
+
+static inline void trace_enable(void) {}
+static inline void trace_disable(void) {}
+static inline void trace_depth_inc(void) {}
+static inline void trace_depth_dec(void) {}
+
+#endif
+
+#endif /* _TRACE_H */
diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/obj=
tool/warn.h
index f32abc7..25ff794 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -97,6 +97,7 @@ static inline char *offstr(struct section *sec, unsigned lo=
ng offset)
 		_len =3D (_len < 50) ? 50 - _len : 0;		\
 		WARN("  %s: " format "  %*s%s", _str, ##__VA_ARGS__, _len, "", _istr); \
 		free(_str);						\
+		__insn->trace =3D 1;				\
 	}							\
 })
=20
diff --git a/tools/objtool/trace.c b/tools/objtool/trace.c
new file mode 100644
index 0000000..134cc33
--- /dev/null
+++ b/tools/objtool/trace.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025, Oracle and/or its affiliates.
+ */
+
+#include <objtool/trace.h>
+
+bool trace;
+int trace_depth;

