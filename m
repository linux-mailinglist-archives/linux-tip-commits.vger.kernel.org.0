Return-Path: <linux-tip-commits+bounces-6871-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4DFBE2903
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D85485186
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED08326D70;
	Thu, 16 Oct 2025 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AxRJpXWL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="++qbuRTL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFF731D362;
	Thu, 16 Oct 2025 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608356; cv=none; b=Mn0VUtS42CXga3a0mA/bdysVMHnv4vxO2NQldwbxWoExzUVwp6bi2VEoWBUpIlgj4Dou0utxYrYTrpdhyVsc0DbCk2XT5dPaFNxGRST1F4P599lTAW69Babb9S9+AF2DnYkaU5pPwFUWLRPkwW6rI0yE1e/3K9b0migUNYyKuuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608356; c=relaxed/simple;
	bh=t4fiqiEU/zWACfHvJ+37vL3TWo7EwW1H1UKXC3w5xRs=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=bG2yerfyjT9LT5aDOJtSyXIA6cqt9w6wLqSucogRfvEjcBhN6oXtljNd+UK7aqbAM0MbJgn8kFpb7EhWeA5bv4ih3aTRqbE9gKgyQ747V5Dg1AdMTYhHzq+MTFQ+K8Yh1zTceGRta63tNWYAV8eZgu2/r3X14YJYewluUC+RpXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AxRJpXWL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=++qbuRTL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608344;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=zlftooG1VIv3Vo3fNNhBv3TCBsBdoj6qpdq9Y487fS8=;
	b=AxRJpXWLIas5buJ08pOmeXQijZTlYzFU+4qK+LJsUitA2S0yJwZmRxyaNXSzVeQ9g9lw7+
	ePyX9usKYC9cKfv1FAwQQ6XyC+sSbY9jNIY5RB+sfee9jugjxyqH8xtqDI2S/esgoymycZ
	N+zWfsS6yq+Kxd2rNy2HnmV+SOlrXmvafd3l5SElYEqUKhprTsOkP7ifvGP/6sAHv47lww
	QG0bw9I/cs8zG4aNInwE0yc323esC23HqO8a7hdRSia9iIZRoug35H9A9rterFIN06TBwh
	SbQyDhRe0ZZXdmiVpI1xTXkEc3Uipr9Pz0YFbzEEh4uAVvHtyKAsuRYVGj7r0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608344;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=zlftooG1VIv3Vo3fNNhBv3TCBsBdoj6qpdq9Y487fS8=;
	b=++qbuRTLBXFjfh0jhgnocK4aWNzWrRZiy/PdLN1bk04MLvDNvMWd8BWyOjzQW5pECUzXXu
	cdfZQ5J8m0hTmJBg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add ANNOTATE_DATA_SPECIAL
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060834290.709179.8357482876308329963.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     58f36a5756445dcd0a733504cd798955ebe968c1
Gitweb:        https://git.kernel.org/tip/58f36a5756445dcd0a733504cd798955ebe=
968c1
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:54 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:50:16 -07:00

objtool: Add ANNOTATE_DATA_SPECIAL

In preparation for the objtool klp diff subcommand, add an
ANNOTATE_DATA_SPECIAL macro which annotates special section entries so
that objtool can determine their size and location and extract them
when needed.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/annotate.h            | 49 +++++++++++++++++++++-------
 include/linux/objtool_types.h       |  2 +-
 tools/include/linux/objtool_types.h |  2 +-
 3 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/include/linux/annotate.h b/include/linux/annotate.h
index ccb4454..7c10d34 100644
--- a/include/linux/annotate.h
+++ b/include/linux/annotate.h
@@ -8,34 +8,52 @@
=20
 #ifndef __ASSEMBLY__
=20
-#define __ASM_ANNOTATE(label, type)					\
-	".pushsection .discard.annotate_insn,\"M\",@progbits,8\n\t"	\
+#define __ASM_ANNOTATE(section, label, type)				\
+	".pushsection " section ",\"M\", @progbits, 8\n\t"		\
 	".long " __stringify(label) " - .\n\t"				\
 	".long " __stringify(type) "\n\t"				\
 	".popsection\n\t"
=20
+#define ASM_ANNOTATE_LABEL(label, type)					\
+	__ASM_ANNOTATE(".discard.annotate_insn", label, type)
+
 #define ASM_ANNOTATE(type)						\
 	"911:\n\t"							\
-	__ASM_ANNOTATE(911b, type)
+	ASM_ANNOTATE_LABEL(911b, type)
+
+#define ASM_ANNOTATE_DATA(type)						\
+	"912:\n\t"							\
+	__ASM_ANNOTATE(".discard.annotate_data", 912b, type)
=20
 #else /* __ASSEMBLY__ */
=20
-.macro ANNOTATE type:req
+.macro __ANNOTATE section, type
 .Lhere_\@:
-	.pushsection .discard.annotate_insn,"M",@progbits,8
+	.pushsection \section, "M", @progbits, 8
 	.long	.Lhere_\@ - .
 	.long	\type
 	.popsection
 .endm
=20
+.macro ANNOTATE type
+	__ANNOTATE ".discard.annotate_insn", \type
+.endm
+
+.macro ANNOTATE_DATA type
+	__ANNOTATE ".discard.annotate_data", \type
+.endm
+
 #endif /* __ASSEMBLY__ */
=20
 #else /* !CONFIG_OBJTOOL */
 #ifndef __ASSEMBLY__
-#define __ASM_ANNOTATE(label, type) ""
+#define ASM_ANNOTATE_LABEL(label, type) ""
 #define ASM_ANNOTATE(type)
+#define ASM_ANNOTATE_DATA(type)
 #else /* __ASSEMBLY__ */
-.macro ANNOTATE type:req
+.macro ANNOTATE type
+.endm
+.macro ANNOTATE_DATA type
 .endm
 #endif /* __ASSEMBLY__ */
 #endif /* !CONFIG_OBJTOOL */
@@ -47,7 +65,7 @@
  * these relocations will never be used for indirect calls.
  */
 #define ANNOTATE_NOENDBR		ASM_ANNOTATE(ANNOTYPE_NOENDBR)
-#define ANNOTATE_NOENDBR_SYM(sym)	asm(__ASM_ANNOTATE(sym, ANNOTYPE_NOENDBR))
+#define ANNOTATE_NOENDBR_SYM(sym)	asm(ASM_ANNOTATE_LABEL(sym, ANNOTYPE_NOEND=
BR))
=20
 /*
  * This should be used immediately before an indirect jump/call. It tells
@@ -58,8 +76,8 @@
 /*
  * See linux/instrumentation.h
  */
-#define ANNOTATE_INSTR_BEGIN(label)	__ASM_ANNOTATE(label, ANNOTYPE_INSTR_BEG=
IN)
-#define ANNOTATE_INSTR_END(label)	__ASM_ANNOTATE(label, ANNOTYPE_INSTR_END)
+#define ANNOTATE_INSTR_BEGIN(label)	ASM_ANNOTATE_LABEL(label, ANNOTYPE_INSTR=
_BEGIN)
+#define ANNOTATE_INSTR_END(label)	ASM_ANNOTATE_LABEL(label, ANNOTYPE_INSTR_E=
ND)
 /*
  * objtool annotation to ignore the alternatives and only consider the origi=
nal
  * instruction(s).
@@ -83,7 +101,7 @@
  * terminating, like a noreturn CALL or UD2 when we know they are not -- eg
  * WARN using UD2.
  */
-#define ANNOTATE_REACHABLE(label)	__ASM_ANNOTATE(label, ANNOTYPE_REACHABLE)
+#define ANNOTATE_REACHABLE(label)	ASM_ANNOTATE_LABEL(label, ANNOTYPE_REACHAB=
LE)
 /*
  * This should not be used; it annotates away CFI violations. There are a few
  * valid use cases like kexec handover to the next kernel image, and there is
@@ -92,7 +110,13 @@
  * There are also a few real issues annotated away, like EFI because we can't
  * control the EFI code.
  */
-#define ANNOTATE_NOCFI_SYM(sym)		asm(__ASM_ANNOTATE(sym, ANNOTYPE_NOCFI))
+#define ANNOTATE_NOCFI_SYM(sym)		asm(ASM_ANNOTATE_LABEL(sym, ANNOTYPE_NOCFI))
+
+/*
+ * Annotate a special section entry.  This emables livepatch module generati=
on
+ * to find and extract individual special section entries as needed.
+ */
+#define ANNOTATE_DATA_SPECIAL		ASM_ANNOTATE_DATA(ANNOTYPE_DATA_SPECIAL)
=20
 #else /* __ASSEMBLY__ */
 #define ANNOTATE_NOENDBR		ANNOTATE type=3DANNOTYPE_NOENDBR
@@ -104,6 +128,7 @@
 #define ANNOTATE_UNRET_BEGIN		ANNOTATE type=3DANNOTYPE_UNRET_BEGIN
 #define ANNOTATE_REACHABLE		ANNOTATE type=3DANNOTYPE_REACHABLE
 #define ANNOTATE_NOCFI_SYM		ANNOTATE type=3DANNOTYPE_NOCFI
+#define ANNOTATE_DATA_SPECIAL		ANNOTATE_DATA type=3DANNOTYPE_DATA_SPECIAL
 #endif /* __ASSEMBLY__ */
=20
 #endif /* _LINUX_ANNOTATE_H */
diff --git a/include/linux/objtool_types.h b/include/linux/objtool_types.h
index aceac94..c6def40 100644
--- a/include/linux/objtool_types.h
+++ b/include/linux/objtool_types.h
@@ -67,4 +67,6 @@ struct unwind_hint {
 #define ANNOTYPE_REACHABLE		8
 #define ANNOTYPE_NOCFI			9
=20
+#define ANNOTYPE_DATA_SPECIAL		1
+
 #endif /* _LINUX_OBJTOOL_TYPES_H */
diff --git a/tools/include/linux/objtool_types.h b/tools/include/linux/objtoo=
l_types.h
index aceac94..c6def40 100644
--- a/tools/include/linux/objtool_types.h
+++ b/tools/include/linux/objtool_types.h
@@ -67,4 +67,6 @@ struct unwind_hint {
 #define ANNOTYPE_REACHABLE		8
 #define ANNOTYPE_NOCFI			9
=20
+#define ANNOTYPE_DATA_SPECIAL		1
+
 #endif /* _LINUX_OBJTOOL_TYPES_H */

