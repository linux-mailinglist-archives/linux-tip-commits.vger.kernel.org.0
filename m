Return-Path: <linux-tip-commits+bounces-6891-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3EBBE28DC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E2A0353D6B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EF732F767;
	Thu, 16 Oct 2025 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1MdmUe6c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OXgAUDS5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8100D322C99;
	Thu, 16 Oct 2025 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608382; cv=none; b=pXAyAHL8bQpzl+4qe4pwQyVdb0cYL4iv7Y52pVFaLCT3q/btCqK06ANVgQSmVFj+nfv6lShJpaazzGTo/sXAmGQUdp2nIhAUnbcyuOjovrQGZts4gxNcT35qQf6UcAvnuE7x1FaIXJBeftJ/I32m6NQ6HsOLmuU5sQO7szCCDc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608382; c=relaxed/simple;
	bh=Bh53XF3b2W76xBuMc+rDh2xBgvruCAAxBUU5PIFnDNY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=qEA0pl2ODSK6WHS9CuOh9GGpOv1HTxAGmCCUOY+rgN22Rwn3EZcsCRvTkF5fL4dVVVEwSYMXTJaQd8Pf2rEOicHz9dvH1Iq5V+5P0L2f+Xj91bIJiCPoHNjf0gRSuQf4/MpLJ8ymnfYlZeQqBFWmyalsZVOHFSX38TCLK80PgK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1MdmUe6c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OXgAUDS5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608343;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Z8Hiq/7CgVWxI6IYPydDsTgZjY2nVfNKeUQ/NL/+tBU=;
	b=1MdmUe6cbFOZLjzcM2DuwglAVDKIqvxm44VVEgBXSbctgNanF1EUQoqc3y0AwDB/PAt2O6
	E+M6ni07SGWPBeiX37xuRJRw4gmM76bPq1XTKbU3m3kl9riZgSzmlID62uUep0qp9t+D+8
	uNsx7G296Syl0TmuWAn/6ENrJ/wotwpddPHE/h/5NRARO9VzWfpJdxmr2PRcPMW1aV/vh+
	Ez1vIyPumMPAUeE23BVjgbQNSJ9ciR1iPBZL+o35FUPNYrd8kYevMgQQVzefBiTmW39JSe
	14iVUWUUt/2sYRGEyq7KUsS5Dyuy1fmWuR7s+aTOm99HIqQtD9HXkbW59T+X5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608343;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Z8Hiq/7CgVWxI6IYPydDsTgZjY2nVfNKeUQ/NL/+tBU=;
	b=OXgAUDS5olcyYQHE8nhDJDjH7a+3+ocsJ2Dv3kQYqdu2GC6ePUmU51xLtrNzUTBN9moDu9
	2oszMofTHleYZCCQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/asm: Annotate special section entries
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060834174.709179.14871502127592902945.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     aca282ab7e75dd3c1d14230146357a03bef12194
Gitweb:        https://git.kernel.org/tip/aca282ab7e75dd3c1d14230146357a03bef=
12194
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:55 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:50:17 -07:00

x86/asm: Annotate special section entries

In preparation for the objtool klp diff subcommand, add annotations for
special section entries.  This will enable objtool to determine the size
and location of the entries and to extract them when needed.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/alternative.h | 4 ++++
 arch/x86/include/asm/asm.h         | 5 +++++
 arch/x86/include/asm/bug.h         | 1 +
 arch/x86/include/asm/cpufeature.h  | 1 +
 arch/x86/include/asm/jump_label.h  | 1 +
 include/linux/objtool.h            | 4 +++-
 6 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/altern=
ative.h
index 15bc07a..b14c045 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -198,6 +198,7 @@ static inline int alternatives_text_reserved(void *start,=
 void *end)
=20
 #define ALTINSTR_ENTRY(ft_flags)					      \
 	".pushsection .altinstructions,\"a\"\n"				      \
+	ANNOTATE_DATA_SPECIAL						      \
 	" .long 771b - .\n"				/* label           */ \
 	" .long 774f - .\n"				/* new instruction */ \
 	" .4byte " __stringify(ft_flags) "\n"		/* feature + flags */ \
@@ -207,6 +208,7 @@ static inline int alternatives_text_reserved(void *start,=
 void *end)
=20
 #define ALTINSTR_REPLACEMENT(newinstr)		/* replacement */	\
 	".pushsection .altinstr_replacement, \"ax\"\n"			\
+	ANNOTATE_DATA_SPECIAL						\
 	"# ALT: replacement\n"						\
 	"774:\n\t" newinstr "\n775:\n"					\
 	".popsection\n"
@@ -337,6 +339,7 @@ void nop_func(void);
  * instruction. See apply_alternatives().
  */
 .macro altinstr_entry orig alt ft_flags orig_len alt_len
+	ANNOTATE_DATA_SPECIAL
 	.long \orig - .
 	.long \alt - .
 	.4byte \ft_flags
@@ -365,6 +368,7 @@ void nop_func(void);
 	.popsection ;							\
 	.pushsection .altinstr_replacement,"ax"	;			\
 743:									\
+	ANNOTATE_DATA_SPECIAL ;						\
 	newinst	;							\
 744:									\
 	.popsection ;
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index d5c8d3a..bd62bd8 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_ASM_H
 #define _ASM_X86_ASM_H
=20
+#include <linux/annotate.h>
+
 #ifdef __ASSEMBLER__
 # define __ASM_FORM(x, ...)		x,## __VA_ARGS__
 # define __ASM_FORM_RAW(x, ...)		x,## __VA_ARGS__
@@ -132,6 +134,7 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
 # define _ASM_EXTABLE_TYPE(from, to, type)			\
 	.pushsection "__ex_table","a" ;				\
 	.balign 4 ;						\
+	ANNOTATE_DATA_SPECIAL ;					\
 	.long (from) - . ;					\
 	.long (to) - . ;					\
 	.long type ;						\
@@ -179,6 +182,7 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
 # define _ASM_EXTABLE_TYPE(from, to, type)			\
 	" .pushsection \"__ex_table\",\"a\"\n"			\
 	" .balign 4\n"						\
+	ANNOTATE_DATA_SPECIAL					\
 	" .long (" #from ") - .\n"				\
 	" .long (" #to ") - .\n"				\
 	" .long " __stringify(type) " \n"			\
@@ -187,6 +191,7 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
 # define _ASM_EXTABLE_TYPE_REG(from, to, type, reg)				\
 	" .pushsection \"__ex_table\",\"a\"\n"					\
 	" .balign 4\n"								\
+	ANNOTATE_DATA_SPECIAL							\
 	" .long (" #from ") - .\n"						\
 	" .long (" #to ") - .\n"						\
 	DEFINE_EXTABLE_TYPE_REG							\
diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 880ca15..372f401 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -57,6 +57,7 @@
 #define _BUG_FLAGS_ASM(ins, file, line, flags, size, extra)		\
 	"1:\t" ins "\n"							\
 	".pushsection __bug_table,\"aw\"\n"				\
+	ANNOTATE_DATA_SPECIAL						\
 	__BUG_ENTRY(file, line, flags)					\
 	"\t.org 2b + " size "\n"					\
 	".popsection\n"							\
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeat=
ure.h
index 893cbca..fc5f32d 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -101,6 +101,7 @@ static __always_inline bool _static_cpu_has(u16 bit)
 	asm goto(ALTERNATIVE_TERNARY("jmp 6f", %c[feature], "", "jmp %l[t_no]")
 		".pushsection .altinstr_aux,\"ax\"\n"
 		"6:\n"
+		ANNOTATE_DATA_SPECIAL
 		" testb %[bitnum], %a[cap_byte]\n"
 		" jnz %l[t_yes]\n"
 		" jmp %l[t_no]\n"
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_la=
bel.h
index 61dd1de..e0a6930 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -15,6 +15,7 @@
 #define JUMP_TABLE_ENTRY(key, label)			\
 	".pushsection __jump_table,  \"aw\" \n\t"	\
 	_ASM_ALIGN "\n\t"				\
+	ANNOTATE_DATA_SPECIAL				\
 	".long 1b - . \n\t"				\
 	".long " label " - . \n\t"			\
 	_ASM_PTR " " key " - . \n\t"			\
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 1973e9f..4fea6a0 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -9,9 +9,10 @@
=20
 #ifndef __ASSEMBLY__
=20
-#define UNWIND_HINT(type, sp_reg, sp_offset, signal)	\
+#define UNWIND_HINT(type, sp_reg, sp_offset, signal)		\
 	"987: \n\t"						\
 	".pushsection .discard.unwind_hints\n\t"		\
+	ANNOTATE_DATA_SPECIAL					\
 	/* struct unwind_hint */				\
 	".long 987b - .\n\t"					\
 	".short " __stringify(sp_offset) "\n\t"			\
@@ -78,6 +79,7 @@
 .macro UNWIND_HINT type:req sp_reg=3D0 sp_offset=3D0 signal=3D0
 .Lhere_\@:
 	.pushsection .discard.unwind_hints
+		ANNOTATE_DATA_SPECIAL
 		/* struct unwind_hint */
 		.long .Lhere_\@ - .
 		.short \sp_offset

