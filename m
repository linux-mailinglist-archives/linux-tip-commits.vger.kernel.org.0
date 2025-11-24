Return-Path: <linux-tip-commits+bounces-7482-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676DFC7F7E8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B963A6997
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400BF2F5A33;
	Mon, 24 Nov 2025 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HVmPLYND";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JkBVShVB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541BF2F5A07;
	Mon, 24 Nov 2025 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975503; cv=none; b=YbdnAoSsSxQCdPJoAWyVQgofSMpxZdDo0juTzInS9xoOaNAeFR+1jmAohDmo9VIOXB3xY2LeFWkrsCVgQR/k7BgehSZOq4EFWly8jhTqUmTZXKeQcxrjUe5tuXlJ78vXzNM01ScrLZQhzkYF/UtLlohlFZ4I60ko4U68j8j7w/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975503; c=relaxed/simple;
	bh=Mgt1p3LWnjXKYybsz6PVLCw8LdoK4NdZVKrpRXB5qKs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lxqwK3bxanKmrj8OBa7eE+NfFIt0fwDJPx31yaj/KNZI1uxJSlcIQtWgzinKGT3EzeKWaKj8pacJOWr7qGWInEWAOqmIcU35YjQvsXHkeE3HfFftOvBN/fr4LIXx2mePoNNtNxw5JCu+vb6BCAUs13W+T3zwpuonitDz45dLf70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HVmPLYND; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JkBVShVB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975498;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dSbEUnwRwwSiNOuYoGduUK0T17BJCsH8jOxDSdhlwHA=;
	b=HVmPLYNDlscJTpfJXDMU17h7cHxiznJI06FkpVVbQfAVWLjoB2wXk7n69UdW5RGJ2wKzxI
	9IG8vo238zUdGx7b2Da/sH6bXFiSRmc8IIcnlHpk0xjz0fdKQKFJ6YL36/tPBs/bYXFDV2
	Hd9Zf7u+1i6hWdHPul2ESIo/YDq1DPnAjzAt4E8ZrlllZrwI0oomizyW769CrAUOJKfNJd
	VMMcMcO85lo7RFxnNUBHx5ifPTSH858m1MA3249Ra2+IYKiflfpEKwXnAXiCHhM9HCRdal
	W7r6L1bBhy0NDTEZSXgAZj3matCp8wD5nb5MNNCM7xQoC+W7ehuBnH2C9eXw1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975498;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dSbEUnwRwwSiNOuYoGduUK0T17BJCsH8jOxDSdhlwHA=;
	b=JkBVShVBPKyy98AKVN42bTXND+SXAqAQCQnGhFLVf/CV+yY8eJi+QcHYaNlV24DKLNosWI
	YguwOJSp/Yg1KFAw==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Function to get the name of a CPU feature
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
Message-ID: <176397549761.498.8045461823702214995.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     cf690efb96e1d4b1ccb0be767f253ff915f4236f
Gitweb:        https://git.kernel.org/tip/cf690efb96e1d4b1ccb0be767f253ff915f=
4236f
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:36 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:15 +01:00

objtool: Function to get the name of a CPU feature

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
 tools/arch/x86/tools/gen-cpu-feature-names-x86.awk | 33 +++++++++++++-
 tools/objtool/.gitignore                           |  1 +-
 tools/objtool/Makefile                             |  1 +-
 tools/objtool/arch/loongarch/special.c             |  5 ++-
 tools/objtool/arch/powerpc/special.c               |  5 ++-
 tools/objtool/arch/x86/Build                       | 10 ++++-
 tools/objtool/arch/x86/special.c                   | 10 ++++-
 tools/objtool/include/objtool/special.h            |  2 +-
 8 files changed, 67 insertions(+)
 create mode 100644 tools/arch/x86/tools/gen-cpu-feature-names-x86.awk

diff --git a/tools/arch/x86/tools/gen-cpu-feature-names-x86.awk b/tools/arch/=
x86/tools/gen-cpu-feature-names-x86.awk
new file mode 100644
index 0000000..1b1c1d8
--- /dev/null
+++ b/tools/arch/x86/tools/gen-cpu-feature-names-x86.awk
@@ -0,0 +1,33 @@
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
+	feature_expr =3D "(X86_FEATURE_[A-Z0-9_]+)\\s+\\(([0-9*+ ]+)\\)"
+	debug_expr =3D "(X86_BUG_[A-Z0-9_]+)\\s+X86_BUG\\(([0-9*+ ]+)\\)"
+}
+
+/^#define X86_FEATURE_/ {
+	if (match($0, feature_expr, m)) {
+		print "\t[" m[2] "] =3D \"" m[1] "\","
+	}
+}
+
+/^#define X86_BUG_/ {
+	if (match($0, debug_expr, m)) {
+		print "\t[NCAPINTS*32+(" m[2] ")] =3D \"" m[1] "\","
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
index 3dedb2f..8b37c36 100644
--- a/tools/objtool/arch/x86/Build
+++ b/tools/objtool/arch/x86/Build
@@ -12,3 +12,13 @@ $(OUTPUT)arch/x86/lib/inat-tables.c: $(inat_tables_script)=
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

