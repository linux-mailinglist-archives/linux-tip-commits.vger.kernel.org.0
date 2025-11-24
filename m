Return-Path: <linux-tip-commits+bounces-7522-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C57BC8256E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 20:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B8B3AE50F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 19:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846D332E6B8;
	Mon, 24 Nov 2025 19:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aQh1zhQL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="egDZdmvQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A0532E131;
	Mon, 24 Nov 2025 19:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764013769; cv=none; b=crVDnyqIQe/cqrGhIF9mB7h6HCkBaWZDRaMu2+nc6ywBGKNeADm4tZXpyHG5pzCdNXAjHjo+QkM9ujyA3KBj9GIeeDU/sHy7jY6N+tMzsUCIMFhSzQ6M+VrsmQ4L0nqtSTN38kK93bt5FVA6VBQTwdWJiIrZR2XAh35buJJXtS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764013769; c=relaxed/simple;
	bh=JaeUbzdur+2hJ26uvIvsEJaxeBx6K8Sg39zesyVnPd0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TcNmw6Tc64rOpUoH+X+ynwL3ePzO7oeOWPgDoabID/yA9fgUAuivBJYqLfbSDQBUq+fqRnAWNbc9+6mJPYb2BMPnsRneVKwuJcIxMVTJpD3IaLi+vLLyQp57yxyGr5T1ncFh26FhULqYQ53TDzEsgEBb9L5zIe16spAmwoxRsQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aQh1zhQL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=egDZdmvQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 19:49:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764013765;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZhS8EZB1eX1U1k5i79U2iuITalk0tuXbtGvL34Y+CM=;
	b=aQh1zhQLAB9QLbyB0XHGRsvI8Z0IYNEAwc9auQaQtuPrE8imSLHe/b6rLRy4+c9PNW6Mdm
	9xdRkNlY95C9NQuxDdzir8ktqOk26iFC46oSWhvRvvgSySJUpYt3UAV4v8cScykH7A2otz
	dOtnb1dNEX8Amy8+L4Sr1SOwiZT3a0Wxc+QJ/xFQhCT0ZmufGsvG5nUE0dRDMvAXHd7qUQ
	+25wFZIJ9GRHLSL1xfRCInUug5V51ZD7c1ai+zff/fe4e+FH4ftmg4tlOO9UgiBthTRXNA
	PO7Cv5JYw+dzXx3w64nKsvtw7mn5WFWe315Qvd5Jo05yq/bO3Gx27QZKG1VAoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764013765;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZhS8EZB1eX1U1k5i79U2iuITalk0tuXbtGvL34Y+CM=;
	b=egDZdmvQe5GOpDmm8HkQPFgG9cWuuZF8qa5D/ejjFUF2J69WBRgRZS4xCf2VQhG+FOkHsR
	1gTjl6EHEvuFLfBg==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Add Function to get the name of a CPU feature
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-27-alexandre.chartre@oracle.com>
References: <20251121095340.464045-27-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176401376427.498.1182391602746658908.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     8308fd001927f5bdc37a9c9f9c413baec3fb7bbe
Gitweb:        https://git.kernel.org/tip/8308fd001927f5bdc37a9c9f9c413baec3f=
b7bbe
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:36 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 24 Nov 2025 20:39:47 +01:00

objtool: Add Function to get the name of a CPU feature

Add a function to get the name of a CPU feature. The function is
architecture dependent and currently only implemented for x86. The
feature names are automatically generated from the cpufeatures.h
include file.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-27-alexandre.chartre@ora=
cle.com
---
 tools/arch/x86/tools/gen-cpu-feature-names-x86.awk | 34 +++++++++++++-
 tools/objtool/.gitignore                           |  1 +-
 tools/objtool/Makefile                             |  1 +-
 tools/objtool/arch/loongarch/special.c             |  5 ++-
 tools/objtool/arch/powerpc/special.c               |  5 ++-
 tools/objtool/arch/x86/Build                       | 13 ++++-
 tools/objtool/arch/x86/special.c                   | 10 ++++-
 tools/objtool/include/objtool/special.h            |  2 +-
 8 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 tools/arch/x86/tools/gen-cpu-feature-names-x86.awk

diff --git a/tools/arch/x86/tools/gen-cpu-feature-names-x86.awk b/tools/arch/=
x86/tools/gen-cpu-feature-names-x86.awk
new file mode 100644
index 0000000..cc4c7a3
--- /dev/null
+++ b/tools/arch/x86/tools/gen-cpu-feature-names-x86.awk
@@ -0,0 +1,34 @@
+#!/bin/awk -f
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2025, Oracle and/or its affiliates.
+#
+# Usage: awk -f gen-cpu-feature-names-x86.awk cpufeatures.h > cpu-feature-na=
mes.c
+#
+
+BEGIN {
+	print "/* cpu feature name array generated from cpufeatures.h */"
+	print "/* Do not change this code. */"
+	print
+	print "static const char *cpu_feature_names[(NCAPINTS+NBUGINTS)*32] =3D {"
+
+	value_expr =3D "\\([0-9*+ ]+\\)"
+}
+
+/^#define X86_FEATURE_/ {
+	if (match($0, value_expr)) {
+		value =3D substr($0, RSTART + 1, RLENGTH - 2)
+		print "\t[" value "] =3D \"" $2 "\","
+	}
+}
+
+/^#define X86_BUG_/ {
+	if (match($0, value_expr)) {
+		value =3D substr($0, RSTART + 1, RLENGTH - 2)
+		print "\t[NCAPINTS*32+(" value ")] =3D \"" $2 "\","
+	}
+}
+
+END {
+	print "};"
+}
diff --git a/tools/objtool/.gitignore b/tools/objtool/.gitignore
index 7593036..73d8831 100644
--- a/tools/objtool/.gitignore
+++ b/tools/objtool/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+arch/x86/lib/cpu-feature-names.c
 arch/x86/lib/inat-tables.c
 /objtool
 feature
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index df793ca..66397d7 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -125,6 +125,7 @@ $(LIBSUBCMD)-clean:
 clean: $(LIBSUBCMD)-clean
 	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL)
 	$(Q)find $(OUTPUT) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name =
'\.*.d' -delete
+	$(Q)$(RM) $(OUTPUT)arch/x86/lib/cpu-feature-names.c $(OUTPUT)fixdep
 	$(Q)$(RM) $(OUTPUT)arch/x86/lib/inat-tables.c $(OUTPUT)fixdep
 	$(Q)$(RM) -- $(OUTPUT)FEATURE-DUMP.objtool
 	$(Q)$(RM) -r -- $(OUTPUT)feature
diff --git a/tools/objtool/arch/loongarch/special.c b/tools/objtool/arch/loon=
garch/special.c
index a80b75f..aba7741 100644
--- a/tools/objtool/arch/loongarch/special.c
+++ b/tools/objtool/arch/loongarch/special.c
@@ -194,3 +194,8 @@ struct reloc *arch_find_switch_table(struct objtool_file =
*file,
=20
 	return rodata_reloc;
 }
+
+const char *arch_cpu_feature_name(int feature_number)
+{
+	return NULL;
+}
diff --git a/tools/objtool/arch/powerpc/special.c b/tools/objtool/arch/powerp=
c/special.c
index 5161068..8f9bf61 100644
--- a/tools/objtool/arch/powerpc/special.c
+++ b/tools/objtool/arch/powerpc/special.c
@@ -18,3 +18,8 @@ struct reloc *arch_find_switch_table(struct objtool_file *f=
ile,
 {
 	exit(-1);
 }
+
+const char *arch_cpu_feature_name(int feature_number)
+{
+	return NULL;
+}
diff --git a/tools/objtool/arch/x86/Build b/tools/objtool/arch/x86/Build
index 3dedb2f..febee0b 100644
--- a/tools/objtool/arch/x86/Build
+++ b/tools/objtool/arch/x86/Build
@@ -1,5 +1,5 @@
-objtool-y +=3D special.o
 objtool-y +=3D decode.o
+objtool-y +=3D special.o
 objtool-y +=3D orc.o
=20
 inat_tables_script =3D ../arch/x86/tools/gen-insn-attr-x86.awk
@@ -12,3 +12,14 @@ $(OUTPUT)arch/x86/lib/inat-tables.c: $(inat_tables_script)=
 $(inat_tables_maps)
 $(OUTPUT)arch/x86/decode.o: $(OUTPUT)arch/x86/lib/inat-tables.c
=20
 CFLAGS_decode.o +=3D -I$(OUTPUT)arch/x86/lib
+
+cpu_features =3D ../arch/x86/include/asm/cpufeatures.h
+cpu_features_script =3D ../arch/x86/tools/gen-cpu-feature-names-x86.awk
+
+$(OUTPUT)arch/x86/lib/cpu-feature-names.c: $(cpu_features_script) $(cpu_feat=
ures)
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,gen)$(AWK) -f $(cpu_features_script) $(cpu_features) > =
$@
+
+$(OUTPUT)arch/x86/special.o: $(OUTPUT)arch/x86/lib/cpu-feature-names.c
+
+CFLAGS_special.o +=3D -I$(OUTPUT)arch/x86/lib
diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/specia=
l.c
index 0930076..e817a3f 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -4,6 +4,10 @@
 #include <objtool/special.h>
 #include <objtool/builtin.h>
 #include <objtool/warn.h>
+#include <asm/cpufeatures.h>
+
+/* cpu feature name array generated from cpufeatures.h */
+#include "cpu-feature-names.c"
=20
 void arch_handle_alternative(struct special_alt *alt)
 {
@@ -134,3 +138,9 @@ struct reloc *arch_find_switch_table(struct objtool_file =
*file,
 	*table_size =3D 0;
 	return rodata_reloc;
 }
+
+const char *arch_cpu_feature_name(int feature_number)
+{
+	return (feature_number < ARRAY_SIZE(cpu_feature_names)) ?
+		cpu_feature_names[feature_number] : NULL;
+}
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/=
objtool/special.h
index b224107..121c376 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -38,4 +38,6 @@ bool arch_support_alt_relocation(struct special_alt *specia=
l_alt,
 struct reloc *arch_find_switch_table(struct objtool_file *file,
 				     struct instruction *insn,
 				     unsigned long *table_size);
+const char *arch_cpu_feature_name(int feature_number);
+
 #endif /* _SPECIAL_H */

