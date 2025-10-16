Return-Path: <linux-tip-commits+bounces-6925-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9921BE2A12
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B60482DB9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E75433CEBC;
	Thu, 16 Oct 2025 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FNVgWgnY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qdgOH3Cv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459B0337683;
	Thu, 16 Oct 2025 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608417; cv=none; b=EcniJlTNW/1KaO4eilBAGBlCg3QDGpFXR990J6w7c13JVhjuQH1MCYfd6Ptgw66lyMmzxG0RQk2sISsnYeAo6/a4E6gPUOh2tYPN5MgSYukf2K8VOIUkIhUOCfDSvoBNDdMizUkScQ2ZYWvR5AaZBcFOMvBZcQz/GXxS7h9GorU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608417; c=relaxed/simple;
	bh=SVZfb1gpMqLPMn08aYMldFmhPKHfNvxqLMcEUfEaCyY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=V5RHCiHKbl2MSJt6t1A+7SDq1zD2igwxWa2F1pHF8STKdvNZ4x7oe7mXxy6QlZuliot/WDJBtmBL238bDfNL/zOJxvsP1VGCTHcBlmow85ezOTQtlcBmAM0VrcYi1WvFS+jMks72FxeYKj7UfvezCCjK1gCOFniA7KIPM7w81GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FNVgWgnY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qdgOH3Cv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:53:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=NpPY57OInuIxU1xF9+K11AYjfxPWyq5t/C9YMwlyNFU=;
	b=FNVgWgnY54Y7BcaU1u+2fCmTphLe1tLOvqatmUZlxkpzyj9jHFDZxn3dF+Tp4IZ5qf2Wiy
	tgigG4i+c3VmNJCPxcfXhH0xNVNGUxnd4VZD9SrEkVO+uJN7evZcgqMCaB6rMbTMxr78Y7
	MrYXFtJ0uufi2/zHD8JHuq0h/aB7xDJ2Pb5U/1QRR1+3UVGlRnE2a0mIn8U3VDge9bvdX1
	oujBWOQ2/+we85u/4njOkZOMmGEPqSArBiagoZlguyd8RgdtEpcM1ePNnaBBSnupThbdnI
	2JMT6+CkKFYLc2LZG9n49bFJUPG6cZotAC/JyqDRkL1nKwkcci/QJ4IWPZXDKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608399;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=NpPY57OInuIxU1xF9+K11AYjfxPWyq5t/C9YMwlyNFU=;
	b=qdgOH3Cvc/r9f5nnae5oMP22dONGiWqAxVzQenGhlputwDcQ23nSgX610JdPPKnhUFZGmR
	4sZv9swX6kxTinCg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and
 related macros
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Petr Mladek <pmladek@suse.com>,
 Joe Lawrence <joe.lawrence@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060839816.709179.1453720155378054569.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     1ba9f8979426590367406c70c1c821f5b943f993
Gitweb:        https://git.kernel.org/tip/1ba9f8979426590367406c70c1c821f5b94=
3f993
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:10 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:21 -07:00

vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and related macros

TEXT_MAIN, DATA_MAIN and friends are defined differently depending on
whether certain config options enable -ffunction-sections and/or
-fdata-sections.

There's no technical reason for that beyond voodoo coding.  Keeping the
separate implementations adds unnecessary complexity, fragments the
logic, and increases the risk of subtle bugs.

Unify the macros by using the same input section patterns across all
configs.

This is a prerequisite for the upcoming livepatch klp-build tooling
which will manually enable -ffunction-sections and -fdata-sections via
KCFLAGS.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/asm-generic/vmlinux.lds.h | 40 +++++++++---------------------
 scripts/module.lds.S              | 12 +++------
 2 files changed, 17 insertions(+), 35 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.=
lds.h
index 8a9a2e7..5facbc9 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -87,39 +87,24 @@
 #define ALIGN_FUNCTION()  . =3D ALIGN(CONFIG_FUNCTION_ALIGNMENT)
=20
 /*
- * LD_DEAD_CODE_DATA_ELIMINATION option enables -fdata-sections, which
- * generates .data.identifier sections, which need to be pulled in with
- * .data. We don't want to pull in .data..other sections, which Linux
- * has defined. Same for text and bss.
+ * Support -ffunction-sections by matching .text and .text.*,
+ * but exclude '.text..*'.
  *
- * With LTO_CLANG, the linker also splits sections by default, so we need
- * these macros to combine the sections during the final link.
- *
- * With AUTOFDO_CLANG and PROPELLER_CLANG, by default, the linker splits
- * text sections and regroups functions into subsections.
- *
- * RODATA_MAIN is not used because existing code already defines .rodata.x
- * sections to be brought in with rodata.
+ * Special .text.* sections that are typically grouped separately, such as
+ * .text.unlikely or .text.hot, must be matched explicitly before using
+ * TEXT_MAIN.
  */
-#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLAN=
G) || \
-defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
-#else
-#define TEXT_MAIN .text
-#endif
-#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLAN=
G)
+
+/*
+ * Support -fdata-sections by matching .data, .data.*, and others,
+ * but exclude '.data..*'.
+ */
 #define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data.rel.* .data..L* .data..com=
poundliteral* .data.$__unnamed_* .data.$L*
 #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
 #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
 #define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..L* .bss..compoundliteral*
 #define SBSS_MAIN .sbss .sbss.[0-9a-zA-Z_]*
-#else
-#define DATA_MAIN .data .data.rel .data.rel.local
-#define SDATA_MAIN .sdata
-#define RODATA_MAIN .rodata
-#define BSS_MAIN .bss
-#define SBSS_MAIN .sbss
-#endif
=20
 /*
  * GCC 4.5 and later have a 32 bytes section alignment for structures.
@@ -581,9 +566,8 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER=
_CLANG)
  * during second ld run in second ld pass when generating System.map
  *
  * TEXT_MAIN here will match symbols with a fixed pattern (for example,
- * .text.hot or .text.unlikely) if dead code elimination or
- * function-section is enabled. Match these symbols first before
- * TEXT_MAIN to ensure they are grouped together.
+ * .text.hot or .text.unlikely).  Match those before TEXT_MAIN to ensure
+ * they get grouped together.
  *
  * Also placing .text.hot section at the beginning of a page, this
  * would help the TLB performance.
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index ee79c41..2632c6c 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -38,12 +38,10 @@ SECTIONS {
 	__kcfi_traps 		: { KEEP(*(.kcfi_traps)) }
 #endif
=20
-#ifdef CONFIG_LTO_CLANG
-	/*
-	 * With CONFIG_LTO_CLANG, LLD always enables -fdata-sections and
-	 * -ffunction-sections, which increases the size of the final module.
-	 * Merge the split sections in the final binary.
-	 */
+	.text : {
+		*(.text .text.[0-9a-zA-Z_]*)
+	}
+
 	.bss : {
 		*(.bss .bss.[0-9a-zA-Z_]*)
 		*(.bss..L*)
@@ -58,7 +56,7 @@ SECTIONS {
 		*(.rodata .rodata.[0-9a-zA-Z_]*)
 		*(.rodata..L*)
 	}
-#endif
+
 	MOD_SEPARATE_CODETAG_SECTIONS()
 }
=20

