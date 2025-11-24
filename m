Return-Path: <linux-tip-commits+bounces-7507-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C44C7F885
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42BEB4E4B1F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C08301033;
	Mon, 24 Nov 2025 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4OdT1fdU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="71iEc3uc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C842FFDF3;
	Mon, 24 Nov 2025 09:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975528; cv=none; b=rN9a5DITWhWBts8xn8Xxb9fpFMHgYjNXOrEZkmt6JBkqf4n3tFaJli2S+t68xBZqjBMpuDvY2vD3y0w4mtKv4iI5muGoWR9CkYIxM2p9k3pRBqakKQD0fDIe/rxcC41HLpLCVz6091MhMJv6m4yVTyWMjXooNuDtokOqfbRlfH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975528; c=relaxed/simple;
	bh=iYJmoSFD13ed3VwxWRlsYWfbwHS86AaGKemC1h5IOYA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OAjS7uxNRG4GAz2uAOFnFPws2MZJQtCIQqAKM1neBZ0c/EgS30n8eQgTa+qFpKqT0Jb5tOks0mQUPnD4HARAVzmIfeecOedeYKqEpdTlr3KuD3EKFHdto84cMAnrf6vwBWEXOnZ7suNWq6V1cAcP9lT9kuXDL8frrIdN1XZ5NeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4OdT1fdU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=71iEc3uc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:12:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975524;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XqtPF0GpYSQT3WCkyDf4BDBnEMghjQj4qzO3bRpnSgw=;
	b=4OdT1fdUTnGHgTF+9mmkAixLdzZOVqMK+Kc6R1BfSbc/3MFnws3vrWDma9ZyD/uxwmHSR8
	F671wJVAa/VwE80yZyVnuxubrdcWr7zqhZSyjyqqe2eeRfUBZ+n6M63tiFex/2IvMh/ewr
	Nbw5Nh30wmgng+hPklDclYWs0YebIiDHTeDc5CkEN2LC2B18AGu9U4I2Tws4vrwhqPeQUM
	ZLX9sujHa7nO6VLlQgzfclghkKKNNjmxw+xAoGFNVi3G3+AUPGgkmaLAPKjBfXXO4xMgVx
	QP61FAyxqN+c9z+01wAhg5nKEOk8KO0FAFXuRH2BxgqJ5xY97PLeaFQt3ISl4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975524;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XqtPF0GpYSQT3WCkyDf4BDBnEMghjQj4qzO3bRpnSgw=;
	b=71iEc3uc/GLYPYqVQOspJV/nMWjVS2XRumEMl9KkYz2deUMgCdqY+5GfEnsXQe0ahBn5bV
	fLKAqtUhRX7hqMCg==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Move disassembly functions to a separated file
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-2-alexandre.chartre@oracle.com>
References: <20251121095340.464045-2-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397552339.498.646493186604995896.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     55d2a473f317ab028d78a5c5ca69473643657c3d
Gitweb:        https://git.kernel.org/tip/55d2a473f317ab028d78a5c5ca694736436=
57c3d
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:11 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:06 +01:00

objtool: Move disassembly functions to a separated file

objtool disassembles functions which have warnings. Move the code
to do that to a dedicated file. The code is just moved, it is not
changed.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-2-alexandre.chartre@orac=
le.com
---
 tools/objtool/Build                     |  1 +-
 tools/objtool/check.c                   | 81 +----------------------
 tools/objtool/disas.c                   | 90 ++++++++++++++++++++++++-
 tools/objtool/include/objtool/objtool.h |  2 +-
 4 files changed, 93 insertions(+), 81 deletions(-)
 create mode 100644 tools/objtool/disas.c

diff --git a/tools/objtool/Build b/tools/objtool/Build
index 8cd71b9..17e50a1 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -7,6 +7,7 @@ objtool-y +=3D special.o
 objtool-y +=3D builtin-check.o
 objtool-y +=3D elf.o
 objtool-y +=3D objtool.o
+objtool-y +=3D disas.o
=20
 objtool-$(BUILD_ORC) +=3D orc_gen.o orc_dump.o
 objtool-$(BUILD_KLP) +=3D builtin-klp.o klp-diff.o klp-post-link.o
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 490cf78..1c7186f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4731,87 +4731,6 @@ static int validate_reachable_instructions(struct objt=
ool_file *file)
 	return warnings;
 }
=20
-/* 'funcs' is a space-separated list of function names */
-static void disas_funcs(const char *funcs)
-{
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
-	}
-
-	cmd =3D malloc(size);
-
-	/* real snprintf() */
-	snprintf(cmd, size, objdump_str, cross_compile, objname, funcs);
-	ret =3D system(cmd);
-	if (ret) {
-		WARN("disassembly failed: %d", ret);
-		return;
-	}
-}
-
-static void disas_warned_funcs(struct objtool_file *file)
-{
-	struct symbol *sym;
-	char *funcs =3D NULL, *tmp;
-
-	for_each_sym(file->elf, sym) {
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
-	}
-
-	if (funcs)
-		disas_funcs(funcs);
-}
-
 __weak bool arch_absolute_reloc(struct elf *elf, struct reloc *reloc)
 {
 	unsigned int type =3D reloc_type(reloc);
diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
new file mode 100644
index 0000000..3a7cb1b
--- /dev/null
+++ b/tools/objtool/disas.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2015-2017 Josh Poimboeuf <jpoimboe@redhat.com>
+ */
+
+#include <objtool/arch.h>
+#include <objtool/warn.h>
+
+#include <linux/string.h>
+
+/* 'funcs' is a space-separated list of function names */
+static void disas_funcs(const char *funcs)
+{
+	const char *objdump_str, *cross_compile;
+	int size, ret;
+	char *cmd;
+
+	cross_compile =3D getenv("CROSS_COMPILE");
+	if (!cross_compile)
+		cross_compile =3D "";
+
+	objdump_str =3D "%sobjdump -wdr %s | gawk -M -v _funcs=3D'%s' '"
+			"BEGIN { split(_funcs, funcs); }"
+			"/^$/ { func_match =3D 0; }"
+			"/<.*>:/ { "
+				"f =3D gensub(/.*<(.*)>:/, \"\\\\1\", 1);"
+				"for (i in funcs) {"
+					"if (funcs[i] =3D=3D f) {"
+						"func_match =3D 1;"
+						"base =3D strtonum(\"0x\" $1);"
+						"break;"
+					"}"
+				"}"
+			"}"
+			"{"
+				"if (func_match) {"
+					"addr =3D strtonum(\"0x\" $1);"
+					"printf(\"%%04x \", addr - base);"
+					"print;"
+				"}"
+			"}' 1>&2";
+
+	/* fake snprintf() to calculate the size */
+	size =3D snprintf(NULL, 0, objdump_str, cross_compile, objname, funcs) + 1;
+	if (size <=3D 0) {
+		WARN("objdump string size calculation failed");
+		return;
+	}
+
+	cmd =3D malloc(size);
+
+	/* real snprintf() */
+	snprintf(cmd, size, objdump_str, cross_compile, objname, funcs);
+	ret =3D system(cmd);
+	if (ret) {
+		WARN("disassembly failed: %d", ret);
+		return;
+	}
+}
+
+void disas_warned_funcs(struct objtool_file *file)
+{
+	struct symbol *sym;
+	char *funcs =3D NULL, *tmp;
+
+	for_each_sym(file->elf, sym) {
+		if (sym->warned) {
+			if (!funcs) {
+				funcs =3D malloc(strlen(sym->name) + 1);
+				if (!funcs) {
+					ERROR_GLIBC("malloc");
+					return;
+				}
+				strcpy(funcs, sym->name);
+			} else {
+				tmp =3D malloc(strlen(funcs) + strlen(sym->name) + 2);
+				if (!tmp) {
+					ERROR_GLIBC("malloc");
+					return;
+				}
+				sprintf(tmp, "%s %s", funcs, sym->name);
+				free(funcs);
+				funcs =3D tmp;
+			}
+		}
+	}
+
+	if (funcs)
+		disas_funcs(funcs);
+}
diff --git a/tools/objtool/include/objtool/objtool.h b/tools/objtool/include/=
objtool/objtool.h
index f7051bb..35f926c 100644
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -49,4 +49,6 @@ int check(struct objtool_file *file);
 int orc_dump(const char *objname);
 int orc_create(struct objtool_file *file);
=20
+void disas_warned_funcs(struct objtool_file *file);
+
 #endif /* _OBJTOOL_H */

