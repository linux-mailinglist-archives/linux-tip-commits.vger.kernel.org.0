Return-Path: <linux-tip-commits+bounces-7491-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7ADC7F841
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 60BCA3488EF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B622FB0B5;
	Mon, 24 Nov 2025 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LQ2euX67";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XuYwPjQ7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07172F8BDF;
	Mon, 24 Nov 2025 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975511; cv=none; b=OXmr9w5aTFEipWkA4DHpUI4h108UCGdWTYFBHVPw+DcgU8T72qnQuCtjkc5ns6KjajYQwoMYc9ntxDB2+0jq8I31Wq+wCCVKwSP78VloccJFVRdSDHKbfLr0UHuzcVpOmadEBb98nQ2iqKndcbyP2kLqnt3yEr/amczGq7HFr8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975511; c=relaxed/simple;
	bh=/BlyOcwgi0meV3caE/b/7vWGHG0cWrJX8QFN/qz41Io=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JKReSOgabSQs52oslgyeLuLMkOzt5dT7iUh84JjLm1aMC9MgUluvkB9n0BaKdiEGmJdVlBVgobRJtcQh978U0XRhKT45veMvE4g+6bFVrPq8fk4EjMfx789NGxnB4/eS/tH1yK7LqqxhN237tV75R8hOl4lY3hNdHhLN0HW0vC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LQ2euX67; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XuYwPjQ7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975508;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1nKESCteFk7UnG14uxmyKHq53BmP2xT3AXYayl2mO68=;
	b=LQ2euX67I4bdKw0ik+k8SA3WiIRhlPfnYH/uTI2vmv86Rvauxyk3wBhGzmfPd6qmQCz7QY
	yAQA9l0R5ggb6+mjLNXEigqn/XFQywZuDJzNmYDXxwZYpTMQp8x14rYGD+ZzUmgrgW2keE
	KUwZoy2gGpvSjmW9GRiO1JYYHwLis0ciqHutTR/732SjTubxC6e/IXqXlLlZIW/sayT6DK
	NJ9G/3VCN2NSHeUzhyDJx6z8s/djd6A9Og9ERSqmBfabRCFp8dIT12qFs6cjL6GbRC634X
	e/dz7uvSQ8Dm9/T9rWx3tQtQ04o5Jz518J4PCo2CzKdSmidZG4Xk03Mf6f6Arw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975508;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1nKESCteFk7UnG14uxmyKHq53BmP2xT3AXYayl2mO68=;
	b=XuYwPjQ7iKROH28aU3sM50EPOo84sHYuSAoAFRubfq29EWw83hyWeVMiT4DVY1JecNGBqC
	UppyzPzkAy+p6JAA==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Add the --disas=<function-pattern> action
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-18-alexandre.chartre@oracle.com>
References: <20251121095340.464045-18-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397550702.498.15558855986407576420.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     5f326c88973691232c0e56ced83c199d53d86766
Gitweb:        https://git.kernel.org/tip/5f326c88973691232c0e56ced83c199d53d=
86766
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:27 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:12 +01:00

objtool: Add the --disas=3D<function-pattern> action

Add the --disas=3D<function-pattern> actions to disassemble the specified
functions. The function pattern can be a single function name (e.g.
--disas foo to disassemble the function with the name "foo"), or a shell
wildcard pattern (e.g. --disas foo* to disassemble all functions with a
name starting with "foo").

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-18-alexandre.chartre@ora=
cle.com
---
 tools/objtool/builtin-check.c           |  2 +-
 tools/objtool/check.c                   | 38 +++++++++++++-----------
 tools/objtool/disas.c                   | 27 +++++++++++++++++-
 tools/objtool/include/objtool/builtin.h |  1 +-
 tools/objtool/include/objtool/disas.h   |  2 +-
 5 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 3329d37..a037131 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -75,6 +75,7 @@ static const struct option check_options[] =3D {
 	OPT_GROUP("Actions:"),
 	OPT_BOOLEAN(0,		 "checksum", &opts.checksum, "generate per-function checksu=
ms"),
 	OPT_BOOLEAN(0,		 "cfi", &opts.cfi, "annotate kernel control flow integrity =
(kCFI) function preambles"),
+	OPT_STRING_OPTARG('d',	 "disas", &opts.disas, "function-pattern", "disassem=
ble functions", "*"),
 	OPT_CALLBACK_OPTARG('h', "hacks", NULL, NULL, "jump_label,noinstr,skylake",=
 "patch toolchain bugs/limitations", parse_hacks),
 	OPT_BOOLEAN('i',	 "ibt", &opts.ibt, "validate and annotate IBT"),
 	OPT_BOOLEAN('m',	 "mcount", &opts.mcount, "annotate mcount/fentry calls for=
 ftrace"),
@@ -176,6 +177,7 @@ static bool opts_valid(void)
 	}
=20
 	if (opts.checksum		||
+	    opts.disas			||
 	    opts.hack_jump_label	||
 	    opts.hack_noinstr		||
 	    opts.ibt			||
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4ebadf9..9cd9f9d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2611,7 +2611,7 @@ static int decode_sections(struct objtool_file *file)
 	 * Must be before add_jump_destinations(), which depends on 'func'
 	 * being set for alternatives, to enable proper sibling call detection.
 	 */
-	if (validate_branch_enabled() || opts.noinstr || opts.hack_jump_label) {
+	if (validate_branch_enabled() || opts.noinstr || opts.hack_jump_label || op=
ts.disas) {
 		if (add_special_section_alts(file))
 			return -1;
 	}
@@ -4915,14 +4915,15 @@ int check(struct objtool_file *file)
 	int ret =3D 0, warnings =3D 0;
=20
 	/*
-	 * If the verbose or backtrace option is used then we need a
-	 * disassembly context to disassemble instruction or function
-	 * on warning or backtrace.
+	 * Create a disassembly context if we might disassemble any
+	 * instruction or function.
 	 */
-	if (opts.verbose || opts.backtrace || opts.trace) {
+	if (opts.verbose || opts.backtrace || opts.trace || opts.disas) {
 		disas_ctx =3D disas_context_create(file);
-		if (!disas_ctx)
+		if (!disas_ctx) {
+			opts.disas =3D false;
 			opts.trace =3D false;
+		}
 		objtool_disas_ctx =3D disas_ctx;
 	}
=20
@@ -5054,20 +5055,20 @@ int check(struct objtool_file *file)
 	}
=20
 out:
-	if (!ret && !warnings) {
-		free_insns(file);
-		return 0;
-	}
-
-	if (opts.werror && warnings)
-		ret =3D 1;
-
-	if (opts.verbose) {
+	if (ret || warnings) {
 		if (opts.werror && warnings)
-			WARN("%d warning(s) upgraded to errors", warnings);
-		disas_warned_funcs(disas_ctx);
+			ret =3D 1;
+
+		if (opts.verbose) {
+			if (opts.werror && warnings)
+				WARN("%d warning(s) upgraded to errors", warnings);
+			disas_warned_funcs(disas_ctx);
+		}
 	}
=20
+	if (opts.disas)
+		disas_funcs(disas_ctx);
+
 	if (disas_ctx) {
 		disas_context_destroy(disas_ctx);
 		objtool_disas_ctx =3D NULL;
@@ -5075,6 +5076,9 @@ out:
=20
 	free_insns(file);
=20
+	if (!ret && !warnings)
+		return 0;
+
 	if (opts.backup && make_backup())
 		return 1;
=20
diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index b53be24..9cc952e 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -4,6 +4,7 @@
  */
=20
 #define _GNU_SOURCE
+#include <fnmatch.h>
=20
 #include <objtool/arch.h>
 #include <objtool/check.h>
@@ -556,3 +557,29 @@ void disas_warned_funcs(struct disas_context *dctx)
 			disas_func(dctx, sym);
 	}
 }
+
+void disas_funcs(struct disas_context *dctx)
+{
+	bool disas_all =3D !strcmp(opts.disas, "*");
+	struct section *sec;
+	struct symbol *sym;
+
+	for_each_sec(dctx->file->elf, sec) {
+
+		if (!(sec->sh.sh_flags & SHF_EXECINSTR))
+			continue;
+
+		sec_for_each_sym(sec, sym) {
+			/*
+			 * If the function had a warning and the verbose
+			 * option is used then the function was already
+			 * disassemble.
+			 */
+			if (opts.verbose && sym->warned)
+				continue;
+
+			if (disas_all || fnmatch(opts.disas, sym->name, 0) =3D=3D 0)
+				disas_func(dctx, sym);
+		}
+	}
+}
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/=
objtool/builtin.h
index 991365c..e3af664 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -28,6 +28,7 @@ struct opts {
 	bool static_call;
 	bool uaccess;
 	int prefix;
+	const char *disas;
=20
 	/* options: */
 	bool backtrace;
diff --git a/tools/objtool/include/objtool/disas.h b/tools/objtool/include/ob=
jtool/disas.h
index 8959d4c..e8f395e 100644
--- a/tools/objtool/include/objtool/disas.h
+++ b/tools/objtool/include/objtool/disas.h
@@ -15,6 +15,7 @@ struct disassemble_info;
 struct disas_context *disas_context_create(struct objtool_file *file);
 void disas_context_destroy(struct disas_context *dctx);
 void disas_warned_funcs(struct disas_context *dctx);
+void disas_funcs(struct disas_context *dctx);
 int disas_info_init(struct disassemble_info *dinfo,
 		    int arch, int mach32, int mach64,
 		    const char *options);
@@ -40,6 +41,7 @@ static inline struct disas_context *disas_context_create(st=
ruct objtool_file *fi
=20
 static inline void disas_context_destroy(struct disas_context *dctx) {}
 static inline void disas_warned_funcs(struct disas_context *dctx) {}
+static inline void disas_funcs(struct disas_context *dctx) {}
=20
 static inline int disas_info_init(struct disassemble_info *dinfo,
 				  int arch, int mach32, int mach64,

