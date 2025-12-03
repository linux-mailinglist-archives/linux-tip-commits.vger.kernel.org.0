Return-Path: <linux-tip-commits+bounces-7578-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6EECA036D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 17:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AACA308947E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 16:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD3B34BA44;
	Wed,  3 Dec 2025 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oCnoe1Xx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FvGaQxQ4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB84349B14;
	Wed,  3 Dec 2025 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764780044; cv=none; b=pBC2Btg6gybDEQNmkcjxJSFUodRUuGljD5t2FkkGd4U8R3MwAwyXtOiIdP9KKZeu6pK9u3AoSHWMm6kz3fmZOvOOpQqaMTyB8L7svn/LmoDXbvfzAE/zpIYnlzYY12UjBS3OYTjafJKSCFdxdgv62rv2H40qgVC9lJbwjt4gihg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764780044; c=relaxed/simple;
	bh=eroRYwLaRZ8benpEiRl6jGQBRncklLEb9odwcI9hat4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A008DYzQe4H2ydWLlf5p7hGC+pL0IqFcBcrMDOyt5SpNqWI4Cq+EG15HC7HuAaGx/WxRJcqiAHSuMhcBvv3AC6y4a4v2gzhre9pIri6H9v+NM2e4yxb/fvCaz1Yp59gtK+TYlQ6OgqmdoWafSUC/++BaNVPdxFSl+yDvLrpcseI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oCnoe1Xx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FvGaQxQ4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Dec 2025 16:40:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764780036;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3VQkUBGZseTwEudye33S28bXRXar21Znhbm18hPqu4=;
	b=oCnoe1XxNo1hyfUwvyalAB9AQSmV5gD/R2jZjPWWoIQdUOF7x5nhwQAx/Mln83waP7IRc2
	CMVsZVK78bfq6n5llsU8MfLTjZoEgGPeCmb077uzd6s8UrQkrmf8fkO1H9pjxLcNOq6gx1
	sSdGDFQ5YiU89A008Uzw4c/d9SWEaRwlTDzB2f1DZ4wFOCeVvlf0rR9dc4jWMRvyVPuAi3
	xajO4VK221G51Tj7+qjwyZ2XInUMKUz+ZlePlJh3f2Paavm5Kpi6YWR2dbZWop/oTJ0bcq
	yp/QXdsOH4W1UWxau42LOguq9bEaCyUVzz+Ayi3/nsP3Mgb41vH+7rcFWoSTmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764780036;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G3VQkUBGZseTwEudye33S28bXRXar21Znhbm18hPqu4=;
	b=FvGaQxQ44a36c4DaxDW2XIYp+pHRul4qAdNYAhoPE8ynqHdpivjFfwPv/c0vbhi2eCAlUV
	sh4xR0VellL5SGBw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] x86/asm: Remove ANNOTATE_DATA_SPECIAL usage
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <b858cb7891c1ba0080e22a9c32595e6c302435e2.1764694625.git.jpoimboe@kernel.org>
References:
 <b858cb7891c1ba0080e22a9c32595e6c302435e2.1764694625.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176478003520.498.13862518343962465253.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     f387d0e1027f2d13cbfc1305b54198af701ede19
Gitweb:        https://git.kernel.org/tip/f387d0e1027f2d13cbfc1305b54198af701=
ede19
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 02 Dec 2025 09:59:37 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Dec 2025 16:53:19 +01:00

x86/asm: Remove ANNOTATE_DATA_SPECIAL usage

Instead of manually annotating each __ex_table entry, just make the
section mergeable and store the entry size in the ELF section header.

Either way works for objtool create_fake_symbols(), this way produces
cleaner code generation.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://patch.msgid.link/b858cb7891c1ba0080e22a9c32595e6c302435e2.17646=
94625.git.jpoimboe@kernel.org
---
 arch/um/include/asm/Kbuild                 |  1 +-
 arch/um/include/shared/common-offsets.h    |  1 +-
 arch/x86/include/asm/asm.h                 | 25 +++++++++++----------
 arch/x86/kernel/asm-offsets.c              |  1 +-
 arch/x86/um/shared/sysdep/kernel-offsets.h |  2 ++-
 kernel/bounds.c                            |  1 +-
 scripts/mod/devicetable-offsets.c          |  1 +-
 7 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index b6810db..1b9b82b 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -5,7 +5,6 @@ generic-y +=3D device.h
 generic-y +=3D dma-mapping.h
 generic-y +=3D emergency-restart.h
 generic-y +=3D exec.h
-generic-y +=3D extable.h
 generic-y +=3D ftrace.h
 generic-y +=3D hw_irq.h
 generic-y +=3D irq_regs.h
diff --git a/arch/um/include/shared/common-offsets.h b/arch/um/include/shared=
/common-offsets.h
index 4e19103..a6f77cb 100644
--- a/arch/um/include/shared/common-offsets.h
+++ b/arch/um/include/shared/common-offsets.h
@@ -20,3 +20,4 @@ DEFINE(UM_KERN_GDT_ENTRY_TLS_ENTRIES, GDT_ENTRY_TLS_ENTRIES=
);
 DEFINE(UM_SECCOMP_ARCH_NATIVE, SECCOMP_ARCH_NATIVE);
=20
 DEFINE(ALT_INSTR_SIZE, sizeof(struct alt_instr));
+DEFINE(EXTABLE_SIZE,   sizeof(struct exception_table_entry));
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index bd62bd8..0e8c611 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -126,18 +126,21 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
=20
 #ifdef __KERNEL__
=20
+#ifndef COMPILE_OFFSETS
+#include <asm/asm-offsets.h>
+#endif
+
 # include <asm/extable_fixup_types.h>
=20
 /* Exception table entry */
 #ifdef __ASSEMBLER__
=20
-# define _ASM_EXTABLE_TYPE(from, to, type)			\
-	.pushsection "__ex_table","a" ;				\
-	.balign 4 ;						\
-	ANNOTATE_DATA_SPECIAL ;					\
-	.long (from) - . ;					\
-	.long (to) - . ;					\
-	.long type ;						\
+# define _ASM_EXTABLE_TYPE(from, to, type)				\
+	.pushsection "__ex_table", "aM", @progbits, EXTABLE_SIZE ;	\
+	.balign 4 ;							\
+	.long (from) - . ;						\
+	.long (to) - . ;						\
+	.long type ;							\
 	.popsection
=20
 # ifdef CONFIG_KPROBES
@@ -180,18 +183,18 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
 	".purgem extable_type_reg\n"
=20
 # define _ASM_EXTABLE_TYPE(from, to, type)			\
-	" .pushsection \"__ex_table\",\"a\"\n"			\
+	" .pushsection __ex_table, \"aM\", @progbits, "		\
+		       __stringify(EXTABLE_SIZE) "\n"		\
 	" .balign 4\n"						\
-	ANNOTATE_DATA_SPECIAL					\
 	" .long (" #from ") - .\n"				\
 	" .long (" #to ") - .\n"				\
 	" .long " __stringify(type) " \n"			\
 	" .popsection\n"
=20
 # define _ASM_EXTABLE_TYPE_REG(from, to, type, reg)				\
-	" .pushsection \"__ex_table\",\"a\"\n"					\
+	" .pushsection __ex_table, \"aM\", @progbits, "				\
+		       __stringify(EXTABLE_SIZE) "\n"				\
 	" .balign 4\n"								\
-	ANNOTATE_DATA_SPECIAL							\
 	" .long (" #from ") - .\n"						\
 	" .long (" #to ") - .\n"						\
 	DEFINE_EXTABLE_TYPE_REG							\
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index db3bb51..25fcde5 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -126,4 +126,5 @@ static void __used common(void)
=20
 	BLANK();
 	DEFINE(ALT_INSTR_SIZE,	sizeof(struct alt_instr));
+	DEFINE(EXTABLE_SIZE,	sizeof(struct exception_table_entry));
 }
diff --git a/arch/x86/um/shared/sysdep/kernel-offsets.h b/arch/x86/um/shared/=
sysdep/kernel-offsets.h
index 6fd1ed4..8215a02 100644
--- a/arch/x86/um/shared/sysdep/kernel-offsets.h
+++ b/arch/x86/um/shared/sysdep/kernel-offsets.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#define COMPILE_OFFSETS
 #include <linux/stddef.h>
 #include <linux/sched.h>
 #include <linux/elf.h>
@@ -7,6 +8,7 @@
 #include <linux/audit.h>
 #include <asm/mman.h>
 #include <asm/seccomp.h>
+#include <asm/extable.h>
=20
 /* workaround for a warning with -Wmissing-prototypes */
 void foo(void);
diff --git a/kernel/bounds.c b/kernel/bounds.c
index 29b2cd0..02b619e 100644
--- a/kernel/bounds.c
+++ b/kernel/bounds.c
@@ -6,6 +6,7 @@
  */
=20
 #define __GENERATING_BOUNDS_H
+#define COMPILE_OFFSETS
 /* Include headers that define the enum constants of interest */
 #include <linux/page-flags.h>
 #include <linux/mmzone.h>
diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offs=
ets.c
index d3d00e8..ef2ffb6 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define COMPILE_OFFSETS
 #include <linux/kbuild.h>
 #include <linux/mod_devicetable.h>
=20

