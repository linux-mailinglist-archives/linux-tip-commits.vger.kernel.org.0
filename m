Return-Path: <linux-tip-commits+bounces-7489-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13214C7F820
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026A43A70DF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C3C2F8BF0;
	Mon, 24 Nov 2025 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cyTVG8Y5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kG5vldrL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5C22F7AD6;
	Mon, 24 Nov 2025 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975509; cv=none; b=rEMuYfQQAmHG6U8v+HVRvW47tTToxa1P6t3dzdQTDidQVThMiDxJ29ChhGnifJIKP93LQgu+zBGl2MMoUPgo6A/PZw1tB9MKWgZ9Gv/H1k/8URKWw89Szf3mcf57QKik9fJ6XdpFcWUE0FVEnoJ3FRJLS8yoauwNovWPRIga2yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975509; c=relaxed/simple;
	bh=syI7zhovkBjlFB6JzSijxTRMoMpyhuJtIn2/9Vwchrs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cVY8obWyOSxAbCogUY04i62/yzg8tk9ltDN503dPUjTSCLlnyzROutoNdKERH/IkpbicukGOk0z4S4ZkP2gOn+NIJtScMmZVa0GbfAMAT4IMH3u0g6/qpL4JamNMhI0q9Fe+mgylsZ2KFIT03i8YINudepJffkeoaKoKyLNuqME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cyTVG8Y5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kG5vldrL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975506;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVm6BHJ77Z2tnI2ay2d5JfnBzME6+mex0boey+VYVfg=;
	b=cyTVG8Y551wa1OLcpU+r8n0UhOQrbQgozs71hFl5AUO28RKrXFvrMCkjDVnHVU+v24/RtI
	CzC8ng37Dp4M6AkeJ3fsl0Rj2sdzbgsOEfWFAXCN5btco33Ge37uGemOdUc5FgDOVqOHKV
	7rk3NhWZammLYXjm3zhfIZ7HxUYb8vnd/LTDue4PhLKQhYULWZUhUH6gKcAZFqdDqJEDb0
	TMEsTw26rCSCansKSyAGvqrTNOWZIxflNvAHEKHlpDtYmiDvkztx06+J1i5zT4UotXqH2i
	WTsB34zHAuQYzSH9Yaf5Td1go0tQr34JyRH1lycF9A5rbhfGm3/oZBP0I/5j6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975506;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVm6BHJ77Z2tnI2ay2d5JfnBzME6+mex0boey+VYVfg=;
	b=kG5vldrLade2XHC2PQL3UAYgh55LfdLuAdXbD3d+vGlFkequBxh2H6xXgN5lTynijw1u5F
	+2gSC/7Vdd/1GGAw==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Print headers for alternatives
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-20-alexandre.chartre@oracle.com>
References: <20251121095340.464045-20-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397550487.498.1781989036587773799.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     87343e664252198d2735c9719f711d3e922f3be5
Gitweb:        https://git.kernel.org/tip/87343e664252198d2735c9719f711d3e922=
f3be5
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:29 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:13 +01:00

objtool: Print headers for alternatives

When using the --disas option, objtool doesn't currently disassemble
any alternative. Print an header for each alternative. This identifies
places where alternatives are present but alternative code is still
not disassembled at the moment.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-20-alexandre.chartre@ora=
cle.com
---
 tools/objtool/disas.c | 188 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 182 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 9cc952e..f9b13d5 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -29,6 +29,43 @@ struct disas_context {
 	struct disassemble_info info;
 };
=20
+/*
+ * Maximum number of alternatives
+ */
+#define DISAS_ALT_MAX		5
+
+/*
+ * Maximum number of instructions per alternative
+ */
+#define DISAS_ALT_INSN_MAX	50
+
+/*
+ * Information to disassemble an alternative
+ */
+struct disas_alt {
+	struct instruction *orig_insn;		/* original instruction */
+	struct alternative *alt;		/* alternative or NULL if default code */
+	char *name;				/* name for this alternative */
+	int width;				/* formatting width */
+};
+
+/*
+ * Wrapper around asprintf() to allocate and format a string.
+ * Return the allocated string or NULL on error.
+ */
+static char *strfmt(const char *fmt, ...)
+{
+	va_list ap;
+	char *str;
+	int rv;
+
+	va_start(ap, fmt);
+	rv =3D vasprintf(&str, fmt, ap);
+	va_end(ap);
+
+	return rv =3D=3D -1 ? NULL : str;
+}
+
 static int sprint_name(char *str, const char *name, unsigned long offset)
 {
 	int len;
@@ -314,6 +351,9 @@ char *disas_result(struct disas_context *dctx)
 #define DISAS_INSN_OFFSET_SPACE		10
 #define DISAS_INSN_SPACE		60
=20
+#define DISAS_PRINSN(dctx, insn, depth)			\
+	disas_print_insn(stdout, dctx, insn, depth, "\n")
+
 /*
  * Print a message in the instruction flow. If insn is not NULL then
  * the instruction address is printed in addition of the message,
@@ -354,6 +394,19 @@ static int disas_vprint(FILE *stream, struct section *se=
c, unsigned long offset,
 	return n;
 }
=20
+static int disas_print(FILE *stream, struct section *sec, unsigned long offs=
et,
+			int depth, const char *format, ...)
+{
+	va_list args;
+	int len;
+
+	va_start(args, format);
+	len =3D disas_vprint(stream, sec, offset, depth, format, args);
+	va_end(args);
+
+	return len;
+}
+
 /*
  * Print a message in the instruction flow. If insn is not NULL then
  * the instruction address is printed in addition of the message,
@@ -524,20 +577,143 @@ char *disas_alt_name(struct alternative *alt)
 }
=20
 /*
+ * Initialize an alternative. The default alternative should be initialized
+ * with alt=3DNULL.
+ */
+static int disas_alt_init(struct disas_alt *dalt,
+			  struct instruction *orig_insn,
+			  struct alternative *alt)
+{
+	dalt->orig_insn =3D orig_insn;
+	dalt->alt =3D alt;
+	dalt->name =3D alt ? disas_alt_name(alt) : strdup("DEFAULT");
+	if (!dalt->name)
+		return -1;
+	dalt->width =3D strlen(dalt->name);
+
+	return 0;
+}
+
+/*
+ * Print all alternatives one above the other.
+ */
+static void disas_alt_print_compact(char *alt_name, struct disas_alt *dalts,
+				    int alt_count)
+{
+	struct instruction *orig_insn;
+	int len;
+	int i;
+
+	orig_insn =3D dalts[0].orig_insn;
+
+	len =3D disas_print(stdout, orig_insn->sec, orig_insn->offset, 0, NULL);
+	printf("%s\n", alt_name);
+
+	for (i =3D 0; i < alt_count; i++)
+		printf("%*s=3D %s\n", len, "", dalts[i].name);
+}
+
+/*
+ * Disassemble an alternative.
+ *
+ * Return the last instruction in the default alternative so that
+ * disassembly can continue with the next instruction. Return NULL
+ * on error.
+ */
+static void *disas_alt(struct disas_context *dctx,
+		       struct instruction *orig_insn)
+{
+	struct disas_alt dalts[DISAS_ALT_MAX] =3D { 0 };
+	struct alternative *alt;
+	int alt_count =3D 0;
+	char *alt_name;
+	int err;
+	int i;
+
+	alt_name =3D strfmt("<%s.%lx>", disas_alt_type_name(orig_insn),
+			  orig_insn->offset);
+	if (!alt_name) {
+		WARN("Failed to define name for alternative at instruction 0x%lx",
+		     orig_insn->offset);
+		goto done;
+	}
+
+	/*
+	 * Initialize the default alternative.
+	 */
+	err =3D disas_alt_init(&dalts[0], orig_insn, NULL);
+	if (err) {
+		WARN("%s: failed to initialize default alternative", alt_name);
+		goto done;
+	}
+
+	/*
+	 * Initialize all other alternatives.
+	 */
+	i =3D 1;
+	for (alt =3D orig_insn->alts; alt; alt =3D alt->next) {
+		if (i >=3D DISAS_ALT_MAX) {
+			WARN("%s has more alternatives than supported", alt_name);
+			break;
+		}
+		err =3D disas_alt_init(&dalts[i], orig_insn, alt);
+		if (err) {
+			WARN("%s: failed to disassemble alternative", alt_name);
+			goto done;
+		}
+
+		i++;
+	}
+	alt_count =3D i;
+
+	/*
+	 * Print default and non-default alternatives.
+	 *
+	 * At the moment, this just prints an header for each alternative.
+	 */
+	disas_alt_print_compact(alt_name, dalts, alt_count);
+
+done:
+	for (i =3D 0; i < alt_count; i++)
+		free(dalts[i].name);
+
+	free(alt_name);
+
+	/*
+	 * Currently we are not disassembling any alternative but just
+	 * printing alternative names. Return NULL to have disas_func()
+	 * resume the disassembly with the default alternative.
+	 */
+	return NULL;
+}
+
+/*
  * Disassemble a function.
  */
 static void disas_func(struct disas_context *dctx, struct symbol *func)
 {
+	struct instruction *insn_start;
 	struct instruction *insn;
-	size_t addr;
=20
 	printf("%s:\n", func->name);
 	sym_for_each_insn(dctx->file, func, insn) {
-		addr =3D insn->offset;
-		disas_insn(dctx, insn);
-		printf(" %6lx:  %s+0x%-6lx      %s\n",
-		       addr, func->name, addr - func->offset,
-		       disas_result(dctx));
+		if (insn->alts) {
+			insn_start =3D insn;
+			insn =3D disas_alt(dctx, insn);
+			if (insn)
+				continue;
+			/*
+			 * There was an error with disassembling
+			 * the alternative. Resume disassembling
+			 * at the current instruction, this will
+			 * disassemble the default alternative
+			 * only and continue with the code after
+			 * the alternative.
+			 */
+			insn =3D insn_start;
+		}
+
+		DISAS_PRINSN(dctx, insn, 0);
 	}
 	printf("\n");
 }

