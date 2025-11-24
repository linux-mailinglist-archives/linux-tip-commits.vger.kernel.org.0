Return-Path: <linux-tip-commits+bounces-7506-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F834C7F8AC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60BC3A9D5D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F17D3002A0;
	Mon, 24 Nov 2025 09:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RIcKWcyz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eQA7Ufg9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198F12FF641;
	Mon, 24 Nov 2025 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975526; cv=none; b=mEHpb/eBu0gGywDgCCbIwWZ+kURyBajzGM2B5Fo40H1BApfmKerJYCZBv9r3+Dx1D201WeGtBfG1L2GaqKP5qKTkiUCrl4rvmX6HESPK+FwM7XwHY3a43VtX5ut+WhedTIyQGZHceEk4izqF8cwWwZpeQD1KnFadRfvDOb9PcM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975526; c=relaxed/simple;
	bh=iq+hvolHasi1XRapuAMboGcCIdDobyXZD53slsZgs+Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PaOrEjf0zq7klxrLKE1bJ+lkfGIMqo54pyUfb5kKp+XM4dnRP+9jCse0vhkW70FuW06sI0NBVCPHeT65/2PkOAKM8hYI7Lt9al/Mx/SaJM4iqIPhpdwQA2hpVUnGnv3vGcnH3p29Ca/FT6W237h7ERBHDrhI47oeSsANawbVMfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RIcKWcyz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eQA7Ufg9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:12:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975523;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMRaan67OoplYzBKrnNZNpdQTr4CytAN+KWEKOSVGTg=;
	b=RIcKWcyz8jNE70Bb7gLr1Q3uzJ+xC5tCI1ZMUU1f2rvuZQurUMBC+j8JkCV9gomITkIFpE
	k3frg4mH5nKq6mn9qx7ZUyV1nwObfnhmJtU5sdz0omo0nlvWD/Y5G1wB8rcff/hmPSON+M
	cYILGyVRbTJHo5CazHJHxj4PeW4DffZ9y91+KvxI4HDjrU/ad0bxBE79LiQCRkWW3U8BqZ
	05TUyoh3Kt4n2zVyZUk/xGvau/zSbrlqvRfbLnpyTnqaFNP1ycCp7CzQC2I4W28ssQeUHw
	EhmxOmNsetXGN7Ipq9vHWB0F18Xs9GiiXsjGlKss+kw5VZzSd02XYWHgaa+hiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975523;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMRaan67OoplYzBKrnNZNpdQTr4CytAN+KWEKOSVGTg=;
	b=eQA7Ufg9C3yfLelfIrGN7cWjno7m3TX0iX3ERphLbm2XesP0gS0uJHSpRM8Ca1MliOdMYO
	vXvjb3SWeqFnCvBg==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Create disassembly context
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-3-alexandre.chartre@oracle.com>
References: <20251121095340.464045-3-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397552240.498.6659813919541053172.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     1013f2e37bec39b1df5679e1c1e2572ece87c088
Gitweb:        https://git.kernel.org/tip/1013f2e37bec39b1df5679e1c1e2572ece8=
7c088
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:12 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:06 +01:00

objtool: Create disassembly context

Create a structure to store information for disassembling functions.
For now, it is just a wrapper around an objtool file.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-3-alexandre.chartre@orac=
le.com
---
 tools/objtool/check.c                   |  6 ++++-
 tools/objtool/disas.c                   | 32 ++++++++++++++++++++++--
 tools/objtool/include/objtool/disas.h   | 14 +++++++++++-
 tools/objtool/include/objtool/objtool.h |  2 +--
 4 files changed, 49 insertions(+), 5 deletions(-)
 create mode 100644 tools/objtool/include/objtool/disas.h

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1c7186f..8b1a6a5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -12,6 +12,7 @@
 #include <objtool/builtin.h>
 #include <objtool/cfi.h>
 #include <objtool/arch.h>
+#include <objtool/disas.h>
 #include <objtool/check.h>
 #include <objtool/special.h>
 #include <objtool/warn.h>
@@ -4802,6 +4803,7 @@ static void free_insns(struct objtool_file *file)
=20
 int check(struct objtool_file *file)
 {
+	struct disas_context *disas_ctx;
 	int ret =3D 0, warnings =3D 0;
=20
 	arch_initial_func_cfi_state(&initial_func_cfi);
@@ -4943,7 +4945,9 @@ out:
 	if (opts.verbose) {
 		if (opts.werror && warnings)
 			WARN("%d warning(s) upgraded to errors", warnings);
-		disas_warned_funcs(file);
+		disas_ctx =3D disas_context_create(file);
+		disas_warned_funcs(disas_ctx);
+		disas_context_destroy(disas_ctx);
 	}
=20
 	if (opts.backup && make_backup())
diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 3a7cb1b..7a18e51 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -4,10 +4,35 @@
  */
=20
 #include <objtool/arch.h>
+#include <objtool/disas.h>
 #include <objtool/warn.h>
=20
 #include <linux/string.h>
=20
+struct disas_context {
+	struct objtool_file *file;
+};
+
+struct disas_context *disas_context_create(struct objtool_file *file)
+{
+	struct disas_context *dctx;
+
+	dctx =3D malloc(sizeof(*dctx));
+	if (!dctx) {
+		WARN("failed to allocate disassembly context");
+		return NULL;
+	}
+
+	dctx->file =3D file;
+
+	return dctx;
+}
+
+void disas_context_destroy(struct disas_context *dctx)
+{
+	free(dctx);
+}
+
 /* 'funcs' is a space-separated list of function names */
 static void disas_funcs(const char *funcs)
 {
@@ -58,12 +83,15 @@ static void disas_funcs(const char *funcs)
 	}
 }
=20
-void disas_warned_funcs(struct objtool_file *file)
+void disas_warned_funcs(struct disas_context *dctx)
 {
 	struct symbol *sym;
 	char *funcs =3D NULL, *tmp;
=20
-	for_each_sym(file->elf, sym) {
+	if (!dctx)
+		return;
+
+	for_each_sym(dctx->file->elf, sym) {
 		if (sym->warned) {
 			if (!funcs) {
 				funcs =3D malloc(strlen(sym->name) + 1);
diff --git a/tools/objtool/include/objtool/disas.h b/tools/objtool/include/ob=
jtool/disas.h
new file mode 100644
index 0000000..5c543b6
--- /dev/null
+++ b/tools/objtool/include/objtool/disas.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2025, Oracle and/or its affiliates.
+ */
+
+#ifndef _DISAS_H
+#define _DISAS_H
+
+struct disas_context;
+struct disas_context *disas_context_create(struct objtool_file *file);
+void disas_context_destroy(struct disas_context *dctx);
+void disas_warned_funcs(struct disas_context *dctx);
+
+#endif /* _DISAS_H */
diff --git a/tools/objtool/include/objtool/objtool.h b/tools/objtool/include/=
objtool/objtool.h
index 35f926c..f7051bb 100644
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -49,6 +49,4 @@ int check(struct objtool_file *file);
 int orc_dump(const char *objname);
 int orc_create(struct objtool_file *file);
=20
-void disas_warned_funcs(struct objtool_file *file);
-
 #endif /* _OBJTOOL_H */

