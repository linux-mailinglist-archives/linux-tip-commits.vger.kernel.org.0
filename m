Return-Path: <linux-tip-commits+bounces-6881-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B14F4BE28FA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05CD94FA7B1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151F231BCAE;
	Thu, 16 Oct 2025 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2sxVKrxn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bRrUc9Qk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BAE31BCAB;
	Thu, 16 Oct 2025 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608374; cv=none; b=hEaERX5g9qqr8W3oKWOfs6Gj6h0OVK3vtB6am/U83ZMIJPpS5UgPI9VyLqb1ohVwYZXWa8p3/Tmmpdt64FJbmFrA9BxkbtqLldAJnphZiX2ruFyMgivdO+3gjRuotVurAjwknC00Nc++O5BKw3148ndTtm52DjFzwB4VAarnGos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608374; c=relaxed/simple;
	bh=+KPC+dbqrYeZRpwZ46Wpeu+qo3ZhsoVOwj1QshP7J0c=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=jMIqQpcFBFIUhbMWBifluQzezfWYXr9hw1KPyPpKLBK8xva+ITslXjXAAcwOtFFwqQxhuvobZpEXEPZxTLPMcu2GiY5miZqpRq/2h++eB1P0QhkqMzibOxRQoFD94M6Zfvtql/aagty6fkByy6n8l+jQWNisjjFEzezymA6eZuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2sxVKrxn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bRrUc9Qk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608345;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=x/jLEzS2OS2Bdbzmrcc3Jc2ZP8hLUfkwlZ2IRtAi7pE=;
	b=2sxVKrxndmTizjO7wl9pYk5YMLV/sD4SO2X7woEzlSBpn/hmcvnSCq9MxDXq27H6hymgeN
	iJQgl22RM+ZxJBsHf6A42dkJsyAGOTUf8ZeYLz4WmdebNUf42YQ4ZhQzsJ8SMI2915UdBO
	GkWzdu9PNuiNYfbBiTIKYo2Gl64oq9pC5AyZa/8sLZx8XMCoc6U47Z2BtRyUrGN0OdpxJz
	sT+lCKpcccwj7MHKpyCC96z3BknmnM7QEvdwl+/XuALNFbRQ/vhUTjkXw11THV53rKanjb
	qOYxT7jNvWo8FGhUg768j0IYVQ3k7g/1qMHwg4BfyoyAWm6n0q7AFyMyh2EiSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608345;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=x/jLEzS2OS2Bdbzmrcc3Jc2ZP8hLUfkwlZ2IRtAi7pE=;
	b=bRrUc9QkNsXyT1WWw6YnV9pvF3sTKRnz0R7pH+fnsjH31bpbxDEhtvao9nUcbL/r6d3rMo
	Wzq64JEeb4LNgiCA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Move ANNOTATE* macros to annotate.h
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060834420.709179.12104630429792124331.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     d2c60bde1c0fcac8b140e527546f80749ccd9c67
Gitweb:        https://git.kernel.org/tip/d2c60bde1c0fcac8b140e527546f80749cc=
d9c67
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:53 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:49:20 -07:00

objtool: Move ANNOTATE* macros to annotate.h

In preparation for using the objtool annotation macros in higher-level
objtool.h macros like UNWIND_HINT, move them to their own file.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/annotate.h | 109 ++++++++++++++++++++++++++++++++++++++-
 include/linux/objtool.h  |  90 +-------------------------------
 2 files changed, 110 insertions(+), 89 deletions(-)
 create mode 100644 include/linux/annotate.h

diff --git a/include/linux/annotate.h b/include/linux/annotate.h
new file mode 100644
index 0000000..ccb4454
--- /dev/null
+++ b/include/linux/annotate.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_ANNOTATE_H
+#define _LINUX_ANNOTATE_H
+
+#include <linux/objtool_types.h>
+
+#ifdef CONFIG_OBJTOOL
+
+#ifndef __ASSEMBLY__
+
+#define __ASM_ANNOTATE(label, type)					\
+	".pushsection .discard.annotate_insn,\"M\",@progbits,8\n\t"	\
+	".long " __stringify(label) " - .\n\t"				\
+	".long " __stringify(type) "\n\t"				\
+	".popsection\n\t"
+
+#define ASM_ANNOTATE(type)						\
+	"911:\n\t"							\
+	__ASM_ANNOTATE(911b, type)
+
+#else /* __ASSEMBLY__ */
+
+.macro ANNOTATE type:req
+.Lhere_\@:
+	.pushsection .discard.annotate_insn,"M",@progbits,8
+	.long	.Lhere_\@ - .
+	.long	\type
+	.popsection
+.endm
+
+#endif /* __ASSEMBLY__ */
+
+#else /* !CONFIG_OBJTOOL */
+#ifndef __ASSEMBLY__
+#define __ASM_ANNOTATE(label, type) ""
+#define ASM_ANNOTATE(type)
+#else /* __ASSEMBLY__ */
+.macro ANNOTATE type:req
+.endm
+#endif /* __ASSEMBLY__ */
+#endif /* !CONFIG_OBJTOOL */
+
+#ifndef __ASSEMBLY__
+
+/*
+ * Annotate away the various 'relocation to !ENDBR` complaints; knowing that
+ * these relocations will never be used for indirect calls.
+ */
+#define ANNOTATE_NOENDBR		ASM_ANNOTATE(ANNOTYPE_NOENDBR)
+#define ANNOTATE_NOENDBR_SYM(sym)	asm(__ASM_ANNOTATE(sym, ANNOTYPE_NOENDBR))
+
+/*
+ * This should be used immediately before an indirect jump/call. It tells
+ * objtool the subsequent indirect jump/call is vouched safe for retpoline
+ * builds.
+ */
+#define ANNOTATE_RETPOLINE_SAFE		ASM_ANNOTATE(ANNOTYPE_RETPOLINE_SAFE)
+/*
+ * See linux/instrumentation.h
+ */
+#define ANNOTATE_INSTR_BEGIN(label)	__ASM_ANNOTATE(label, ANNOTYPE_INSTR_BEG=
IN)
+#define ANNOTATE_INSTR_END(label)	__ASM_ANNOTATE(label, ANNOTYPE_INSTR_END)
+/*
+ * objtool annotation to ignore the alternatives and only consider the origi=
nal
+ * instruction(s).
+ */
+#define ANNOTATE_IGNORE_ALTERNATIVE	ASM_ANNOTATE(ANNOTYPE_IGNORE_ALTS)
+/*
+ * This macro indicates that the following intra-function call is valid.
+ * Any non-annotated intra-function call will cause objtool to issue a warni=
ng.
+ */
+#define ANNOTATE_INTRA_FUNCTION_CALL	ASM_ANNOTATE(ANNOTYPE_INTRA_FUNCTION_CA=
LL)
+/*
+ * Use objtool to validate the entry requirement that all code paths do
+ * VALIDATE_UNRET_END before RET.
+ *
+ * NOTE: The macro must be used at the beginning of a global symbol, otherwi=
se
+ * it will be ignored.
+ */
+#define ANNOTATE_UNRET_BEGIN		ASM_ANNOTATE(ANNOTYPE_UNRET_BEGIN)
+/*
+ * This should be used to refer to an instruction that is considered
+ * terminating, like a noreturn CALL or UD2 when we know they are not -- eg
+ * WARN using UD2.
+ */
+#define ANNOTATE_REACHABLE(label)	__ASM_ANNOTATE(label, ANNOTYPE_REACHABLE)
+/*
+ * This should not be used; it annotates away CFI violations. There are a few
+ * valid use cases like kexec handover to the next kernel image, and there is
+ * no security concern there.
+ *
+ * There are also a few real issues annotated away, like EFI because we can't
+ * control the EFI code.
+ */
+#define ANNOTATE_NOCFI_SYM(sym)		asm(__ASM_ANNOTATE(sym, ANNOTYPE_NOCFI))
+
+#else /* __ASSEMBLY__ */
+#define ANNOTATE_NOENDBR		ANNOTATE type=3DANNOTYPE_NOENDBR
+#define ANNOTATE_RETPOLINE_SAFE		ANNOTATE type=3DANNOTYPE_RETPOLINE_SAFE
+/*	ANNOTATE_INSTR_BEGIN		ANNOTATE type=3DANNOTYPE_INSTR_BEGIN */
+/*	ANNOTATE_INSTR_END		ANNOTATE type=3DANNOTYPE_INSTR_END */
+#define ANNOTATE_IGNORE_ALTERNATIVE	ANNOTATE type=3DANNOTYPE_IGNORE_ALTS
+#define ANNOTATE_INTRA_FUNCTION_CALL	ANNOTATE type=3DANNOTYPE_INTRA_FUNCTION=
_CALL
+#define ANNOTATE_UNRET_BEGIN		ANNOTATE type=3DANNOTYPE_UNRET_BEGIN
+#define ANNOTATE_REACHABLE		ANNOTATE type=3DANNOTYPE_REACHABLE
+#define ANNOTATE_NOCFI_SYM		ANNOTATE type=3DANNOTYPE_NOCFI
+#endif /* __ASSEMBLY__ */
+
+#endif /* _LINUX_ANNOTATE_H */
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 46ebaa4..1973e9f 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -3,11 +3,10 @@
 #define _LINUX_OBJTOOL_H
=20
 #include <linux/objtool_types.h>
+#include <linux/annotate.h>
=20
 #ifdef CONFIG_OBJTOOL
=20
-#include <asm/asm.h>
-
 #ifndef __ASSEMBLY__
=20
 #define UNWIND_HINT(type, sp_reg, sp_offset, signal)	\
@@ -53,16 +52,6 @@
=20
 #define __ASM_BREF(label)	label ## b
=20
-#define __ASM_ANNOTATE(label, type)					\
-	".pushsection .discard.annotate_insn,\"M\",@progbits,8\n\t"	\
-	".long " __stringify(label) " - .\n\t"			\
-	".long " __stringify(type) "\n\t"				\
-	".popsection\n\t"
-
-#define ASM_ANNOTATE(type)						\
-	"911:\n\t"						\
-	__ASM_ANNOTATE(911b, type)
-
 #else /* __ASSEMBLY__ */
=20
 /*
@@ -111,14 +100,6 @@
 #endif
 .endm
=20
-.macro ANNOTATE type:req
-.Lhere_\@:
-	.pushsection .discard.annotate_insn,"M",@progbits,8
-	.long	.Lhere_\@ - .
-	.long	\type
-	.popsection
-.endm
-
 #endif /* __ASSEMBLY__ */
=20
 #else /* !CONFIG_OBJTOOL */
@@ -128,84 +109,15 @@
 #define UNWIND_HINT(type, sp_reg, sp_offset, signal) "\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
 #define STACK_FRAME_NON_STANDARD_FP(func)
-#define __ASM_ANNOTATE(label, type) ""
-#define ASM_ANNOTATE(type)
 #else
 .macro UNWIND_HINT type:req sp_reg=3D0 sp_offset=3D0 signal=3D0
 .endm
 .macro STACK_FRAME_NON_STANDARD func:req
 .endm
-.macro ANNOTATE type:req
-.endm
 #endif
=20
 #endif /* CONFIG_OBJTOOL */
=20
-#ifndef __ASSEMBLY__
-/*
- * Annotate away the various 'relocation to !ENDBR` complaints; knowing that
- * these relocations will never be used for indirect calls.
- */
-#define ANNOTATE_NOENDBR		ASM_ANNOTATE(ANNOTYPE_NOENDBR)
-#define ANNOTATE_NOENDBR_SYM(sym)	asm(__ASM_ANNOTATE(sym, ANNOTYPE_NOENDBR))
-
-/*
- * This should be used immediately before an indirect jump/call. It tells
- * objtool the subsequent indirect jump/call is vouched safe for retpoline
- * builds.
- */
-#define ANNOTATE_RETPOLINE_SAFE		ASM_ANNOTATE(ANNOTYPE_RETPOLINE_SAFE)
-/*
- * See linux/instrumentation.h
- */
-#define ANNOTATE_INSTR_BEGIN(label)	__ASM_ANNOTATE(label, ANNOTYPE_INSTR_BEG=
IN)
-#define ANNOTATE_INSTR_END(label)	__ASM_ANNOTATE(label, ANNOTYPE_INSTR_END)
-/*
- * objtool annotation to ignore the alternatives and only consider the origi=
nal
- * instruction(s).
- */
-#define ANNOTATE_IGNORE_ALTERNATIVE	ASM_ANNOTATE(ANNOTYPE_IGNORE_ALTS)
-/*
- * This macro indicates that the following intra-function call is valid.
- * Any non-annotated intra-function call will cause objtool to issue a warni=
ng.
- */
-#define ANNOTATE_INTRA_FUNCTION_CALL	ASM_ANNOTATE(ANNOTYPE_INTRA_FUNCTION_CA=
LL)
-/*
- * Use objtool to validate the entry requirement that all code paths do
- * VALIDATE_UNRET_END before RET.
- *
- * NOTE: The macro must be used at the beginning of a global symbol, otherwi=
se
- * it will be ignored.
- */
-#define ANNOTATE_UNRET_BEGIN		ASM_ANNOTATE(ANNOTYPE_UNRET_BEGIN)
-/*
- * This should be used to refer to an instruction that is considered
- * terminating, like a noreturn CALL or UD2 when we know they are not -- eg
- * WARN using UD2.
- */
-#define ANNOTATE_REACHABLE(label)	__ASM_ANNOTATE(label, ANNOTYPE_REACHABLE)
-/*
- * This should not be used; it annotates away CFI violations. There are a few
- * valid use cases like kexec handover to the next kernel image, and there is
- * no security concern there.
- *
- * There are also a few real issues annotated away, like EFI because we can't
- * control the EFI code.
- */
-#define ANNOTATE_NOCFI_SYM(sym)		asm(__ASM_ANNOTATE(sym, ANNOTYPE_NOCFI))
-
-#else
-#define ANNOTATE_NOENDBR		ANNOTATE type=3DANNOTYPE_NOENDBR
-#define ANNOTATE_RETPOLINE_SAFE		ANNOTATE type=3DANNOTYPE_RETPOLINE_SAFE
-/*	ANNOTATE_INSTR_BEGIN		ANNOTATE type=3DANNOTYPE_INSTR_BEGIN */
-/*	ANNOTATE_INSTR_END		ANNOTATE type=3DANNOTYPE_INSTR_END */
-#define ANNOTATE_IGNORE_ALTERNATIVE	ANNOTATE type=3DANNOTYPE_IGNORE_ALTS
-#define ANNOTATE_INTRA_FUNCTION_CALL	ANNOTATE type=3DANNOTYPE_INTRA_FUNCTION=
_CALL
-#define ANNOTATE_UNRET_BEGIN		ANNOTATE type=3DANNOTYPE_UNRET_BEGIN
-#define ANNOTATE_REACHABLE		ANNOTATE type=3DANNOTYPE_REACHABLE
-#define ANNOTATE_NOCFI_SYM		ANNOTATE type=3DANNOTYPE_NOCFI
-#endif
-
 #if defined(CONFIG_NOINSTR_VALIDATION) && \
 	(defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_MITIGATION_SRSO))
 #define VALIDATE_UNRET_BEGIN	ANNOTATE_UNRET_BEGIN

