Return-Path: <linux-tip-commits+bounces-1367-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396A69041E6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 18:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FBC81C20DD1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 16:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FEE54720;
	Tue, 11 Jun 2024 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kJkX9LiU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="742zjqTt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96E54597B;
	Tue, 11 Jun 2024 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124839; cv=none; b=jdCmdKAY3LvLMFK1VHM2iiBTzwKtBLoZeXbEIPi4TJNB7wFHb8S/WnMuCTCrYz28h8ZPF3gsSWRrWTDFyOeb3bldnIIq93Q30iYe7CJGYBDUeAkahJB/lmVmSuaF9WcRLeNP0br7kDGgt45sNE3kIXa5qDocU0AjjmySf8nSOW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124839; c=relaxed/simple;
	bh=67bn+vZkwiIKsMRBx+EumA4ZXEkvmfh8ZSXceecIMl0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EF0qGmo/uq38kXFVxqaUn8li9nn2RGP7TFnrl0iD9iG9Um76+EjNxWvAQIFGaz0tcuWuS0bGCBbGUTzE+dNGFiFRd8ldY0azdP/ycA4v6LCglBecB2n1yBnT29lsOEKO3E1PjYAAr28+PHls2zFFUEoDg3QW8BLobdyixLXD/Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kJkX9LiU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=742zjqTt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Jun 2024 16:53:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718124827;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zwtEAuevIgMdhQHQgnqayEuqP2SvfKQ8Qp95fqPC070=;
	b=kJkX9LiUnKK0KuYHEeVDodJ3anHUtOnvnwA+GUlBB4fhVSGUjW37d2fXK0fXzhEuKubA8N
	6OUhXgeu489vnKadEP4xuK8h0yIYtlXVltyL9tj4Ce7XQVQLHgzlL88ZM4+wKEI6i7+CAd
	MjGzwmC6ursz/ziCl85otSusGwNHKyj9GMho7ZU2ntHgHQoVlPSYcScUJCuD7O5SfYmBIA
	l1bQytjqvNZB/04FwcNvhdo8dhy+JPCvVDtmLhfHwS7tRufPDT9as0K9rXpHyXTR52oa/g
	OfIOuIJtbe9bWB8n/qK2CRPRUJSiQy/D/ROUnGS97C1KtsHW8a4D44DEnY626g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718124827;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zwtEAuevIgMdhQHQgnqayEuqP2SvfKQ8Qp95fqPC070=;
	b=742zjqTt6+HbSZ4XgbYALq0qQD+7M+Ecm8z6imMQ2KIjkt0suCJEnAoZ7lzg89wHl7sHWV
	KDqtVWIT88GTcTDQ==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternative: Replace the old macros
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240607111701.8366-15-bp@kernel.org>
References: <20240607111701.8366-15-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171812482661.10875.3792217422269559366.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     f776e41fdcc4141876ef6f297318ab04c2382eb7
Gitweb:        https://git.kernel.org/tip/f776e41fdcc4141876ef6f297318ab04c2382eb7
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 07 Jun 2024 13:17:01 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 11 Jun 2024 18:33:23 +02:00

x86/alternative: Replace the old macros

Now that the new macros have been gradually put in place, replace the
old ones. Leave the new label numbers starting at 7xx as a hint that the
new nested alternatives are being used now.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240607111701.8366-15-bp@kernel.org
---
 arch/x86/include/asm/alternative.h | 153 +++++-----------------------
 1 file changed, 32 insertions(+), 121 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 5278cfb..89fa50d 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -156,131 +156,51 @@ static inline int alternatives_text_reserved(void *start, void *end)
 
 #define ALT_CALL_INSTR		"call BUG_func"
 
-#define b_replacement(num)	"664"#num
-#define e_replacement(num)	"665"#num
+#define alt_slen		"772b-771b"
+#define alt_total_slen		"773b-771b"
+#define alt_rlen		"775f-774f"
 
-#define alt_end_marker		"663"
-#define alt_slen		"662b-661b"
-#define n_alt_slen		"772b-771b"
-
-#define alt_total_slen		alt_end_marker"b-661b"
-#define n_alt_total_slen	"773b-771b"
-
-#define alt_rlen(num)		e_replacement(num)"f-"b_replacement(num)"f"
-#define n_alt_rlen		"775f-774f"
-
-#define OLDINSTR(oldinstr, num)						\
-	"# ALT: oldnstr\n"						\
-	"661:\n\t" oldinstr "\n662:\n"					\
-	"# ALT: padding\n"						\
-	".skip -(((" alt_rlen(num) ")-(" alt_slen ")) > 0) * "		\
-		"((" alt_rlen(num) ")-(" alt_slen ")),0x90\n"		\
-	alt_end_marker ":\n"
-
-#define N_OLDINSTR(oldinstr)						\
-	"# N_ALT: oldinstr\n"						\
+#define OLDINSTR(oldinstr)						\
+	"# ALT: oldinstr\n"						\
 	"771:\n\t" oldinstr "\n772:\n"					\
-	"# N_ALT: padding\n"						\
-	".skip -(((" n_alt_rlen ")-(" n_alt_slen ")) > 0) * "		\
-		"((" n_alt_rlen ")-(" n_alt_slen ")),0x90\n"		\
+	"# ALT: padding\n"						\
+	".skip -(((" alt_rlen ")-(" alt_slen ")) > 0) * "		\
+		"((" alt_rlen ")-(" alt_slen ")),0x90\n"		\
 	"773:\n"
 
-/*
- * gas compatible max based on the idea from:
- * http://graphics.stanford.edu/~seander/bithacks.html#IntegerMinOrMax
- *
- * The additional "-" is needed because gas uses a "true" value of -1.
- */
-#define alt_max_short(a, b)	"((" a ") ^ (((" a ") ^ (" b ")) & -(-((" a ") < (" b ")))))"
-
-/*
- * Pad the second replacement alternative with additional NOPs if it is
- * additionally longer than the first replacement alternative.
- */
-#define OLDINSTR_2(oldinstr, num1, num2) \
-	"# ALT: oldinstr2\n"									\
-	"661:\n\t" oldinstr "\n662:\n"								\
-	"# ALT: padding2\n"									\
-	".skip -((" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" alt_slen ")) > 0) * "	\
-		"(" alt_max_short(alt_rlen(num1), alt_rlen(num2)) " - (" alt_slen ")), 0x90\n"	\
-	alt_end_marker ":\n"
-
-#define OLDINSTR_3(oldinsn, n1, n2, n3)								\
-	"# ALT: oldinstr3\n"									\
-	"661:\n\t" oldinsn "\n662:\n"								\
-	"# ALT: padding3\n"									\
-	".skip -((" alt_max_short(alt_max_short(alt_rlen(n1), alt_rlen(n2)), alt_rlen(n3))	\
-		" - (" alt_slen ")) > 0) * "							\
-		"(" alt_max_short(alt_max_short(alt_rlen(n1), alt_rlen(n2)), alt_rlen(n3))	\
-		" - (" alt_slen ")), 0x90\n"							\
-	alt_end_marker ":\n"
-
-#define ALTINSTR_ENTRY(ft_flags, num)					      \
-	" .long 661b - .\n"				/* label           */ \
-	" .long " b_replacement(num)"f - .\n"		/* new instruction */ \
-	" .4byte " __stringify(ft_flags) "\n"		/* feature + flags */ \
-	" .byte " alt_total_slen "\n"			/* source len      */ \
-	" .byte " alt_rlen(num) "\n"			/* replacement len */
-
-#define N_ALTINSTR_ENTRY(ft_flags)					      \
+#define ALTINSTR_ENTRY(ft_flags)					      \
 	".pushsection .altinstructions,\"a\"\n"				      \
 	" .long 771b - .\n"				/* label           */ \
 	" .long 774f - .\n"				/* new instruction */ \
 	" .4byte " __stringify(ft_flags) "\n"		/* feature + flags */ \
-	" .byte " n_alt_total_slen "\n"			/* source len      */ \
-	" .byte " n_alt_rlen "\n"			/* replacement len */ \
+	" .byte " alt_total_slen "\n"			/* source len      */ \
+	" .byte " alt_rlen "\n"				/* replacement len */ \
 	".popsection\n"
 
-#define ALTINSTR_REPLACEMENT(newinstr, num)		/* replacement */	\
-	"# ALT: replacement " #num "\n"						\
-	b_replacement(num)":\n\t" newinstr "\n" e_replacement(num) ":\n"
-
-#define N_ALTINSTR_REPLACEMENT(newinstr)		/* replacement */	\
-	".pushsection .altinstr_replacement, \"ax\"\n"				\
-	"# N_ALT: replacement\n"						\
-	"774:\n\t" newinstr "\n775:\n"						\
+#define ALTINSTR_REPLACEMENT(newinstr)		/* replacement */	\
+	".pushsection .altinstr_replacement, \"ax\"\n"			\
+	"# ALT: replacement\n"						\
+	"774:\n\t" newinstr "\n775:\n"					\
 	".popsection\n"
 
 /* alternative assembly primitive: */
 #define ALTERNATIVE(oldinstr, newinstr, ft_flags)			\
-	OLDINSTR(oldinstr, 1)						\
-	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(ft_flags, 1)					\
-	".popsection\n"							\
-	".pushsection .altinstr_replacement, \"ax\"\n"			\
-	ALTINSTR_REPLACEMENT(newinstr, 1)				\
-	".popsection\n"
-
-/* Nested alternatives macro variant */
-#define N_ALTERNATIVE(oldinstr, newinstr, ft_flags)			\
-	N_OLDINSTR(oldinstr)						\
-	N_ALTINSTR_ENTRY(ft_flags)					\
-	N_ALTINSTR_REPLACEMENT(newinstr)
+	OLDINSTR(oldinstr)						\
+	ALTINSTR_ENTRY(ft_flags)					\
+	ALTINSTR_REPLACEMENT(newinstr)
 
 #define ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
-	OLDINSTR_2(oldinstr, 1, 2)					\
-	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(ft_flags1, 1)					\
-	ALTINSTR_ENTRY(ft_flags2, 2)					\
-	".popsection\n"							\
-	".pushsection .altinstr_replacement, \"ax\"\n"			\
-	ALTINSTR_REPLACEMENT(newinstr1, 1)				\
-	ALTINSTR_REPLACEMENT(newinstr2, 2)				\
-	".popsection\n"
-
-#define N_ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2)	\
-	N_ALTERNATIVE(N_ALTERNATIVE(oldinst, newinst1, flag1),		\
-		      newinst2, flag2)
+	ALTERNATIVE(ALTERNATIVE(oldinstr, newinstr1, ft_flags1), newinstr2, ft_flags2)
 
 /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
 #define ALTERNATIVE_TERNARY(oldinstr, ft_flags, newinstr_yes, newinstr_no) \
-	N_ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
-		      newinstr_yes, ft_flags)
+	ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS, newinstr_yes, ft_flags)
 
 #define ALTERNATIVE_3(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2, \
 			newinstr3, ft_flags3)				\
-	N_ALTERNATIVE(N_ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2), \
+	ALTERNATIVE(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2), \
 		      newinstr3, ft_flags3)
+
 /*
  * Alternative instructions for different CPU types or capabilities.
  *
@@ -294,10 +214,10 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * without volatile and memory clobber.
  */
 #define alternative(oldinstr, newinstr, ft_flags)			\
-	asm_inline volatile(N_ALTERNATIVE(oldinstr, newinstr, ft_flags) : : : "memory")
+	asm_inline volatile(ALTERNATIVE(oldinstr, newinstr, ft_flags) : : : "memory")
 
 #define alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
-	asm_inline volatile(N_ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
+	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
 
 /*
  * Alternative inline assembly with input.
@@ -308,12 +228,12 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * Leaving an unused argument 0 to keep API compatibility.
  */
 #define alternative_input(oldinstr, newinstr, ft_flags, input...)	\
-	asm_inline volatile(N_ALTERNATIVE(oldinstr, newinstr, ft_flags) \
+	asm_inline volatile(ALTERNATIVE(oldinstr, newinstr, ft_flags) \
 		: : "i" (0), ## input)
 
 /* Like alternative_input, but with a single output argument */
 #define alternative_io(oldinstr, newinstr, ft_flags, output, input...)	\
-	asm_inline volatile(N_ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
+	asm_inline volatile(ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
 		: output : "i" (0), ## input)
 
 /*
@@ -327,7 +247,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * suffix.
  */
 #define alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
-	asm_inline volatile(N_ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
+	asm_inline volatile(ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
 		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
 
 /*
@@ -338,7 +258,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
  */
 #define alternative_call_2(oldfunc, newfunc1, ft_flags1, newfunc2, ft_flags2,		\
 			   output, input...)						\
-	asm_inline volatile(N_ALTERNATIVE_2("call %c[old]", "call %c[new1]", ft_flags1,	\
+	asm_inline volatile(ALTERNATIVE_2("call %c[old]", "call %c[new1]", ft_flags1,	\
 		"call %c[new2]", ft_flags2)						\
 		: output, ASM_CALL_CONSTRAINT						\
 		: [old] "i" (oldfunc), [new1] "i" (newfunc1),				\
@@ -422,7 +342,7 @@ void nop_func(void);
  * @newinstr. ".skip" directive takes care of proper instruction padding
  * in case @newinstr is longer than @oldinstr.
  */
-#define __N_ALTERNATIVE(oldinst, newinst, flag)				\
+#define __ALTERNATIVE(oldinst, newinst, flag)				\
 740:									\
 	oldinst	;							\
 741:									\
@@ -438,7 +358,7 @@ void nop_func(void);
 	.popsection ;
 
 .macro ALTERNATIVE oldinstr, newinstr, ft_flags
-	__N_ALTERNATIVE(\oldinstr, \newinstr, \ft_flags)
+	__ALTERNATIVE(\oldinstr, \newinstr, \ft_flags)
 .endm
 
 #define old_len			141b-140b
@@ -447,26 +367,17 @@ void nop_func(void);
 #define new_len3		146f-145f
 
 /*
- * gas compatible max based on the idea from:
- * http://graphics.stanford.edu/~seander/bithacks.html#IntegerMinOrMax
- *
- * The additional "-" is needed because gas uses a "true" value of -1.
- */
-#define alt_max_2(a, b)		((a) ^ (((a) ^ (b)) & -(-((a) < (b)))))
-#define alt_max_3(a, b, c)	(alt_max_2(alt_max_2(a, b), c))
-
-/*
  * Same as ALTERNATIVE macro above but for two alternatives. If CPU
  * has @feature1, it replaces @oldinstr with @newinstr1. If CPU has
  * @feature2, it replaces @oldinstr with @feature2.
  */
 .macro ALTERNATIVE_2 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2
-	__N_ALTERNATIVE(__N_ALTERNATIVE(\oldinstr, \newinstr1, \ft_flags1),
+	__ALTERNATIVE(__ALTERNATIVE(\oldinstr, \newinstr1, \ft_flags1),
 		      \newinstr2, \ft_flags2)
 .endm
 
 .macro ALTERNATIVE_3 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2, newinstr3, ft_flags3
-	__N_ALTERNATIVE(N_ALTERNATIVE_2(\oldinstr, \newinstr1, \ft_flags1, \newinstr2, \ft_flags2),
+	__ALTERNATIVE(ALTERNATIVE_2(\oldinstr, \newinstr1, \ft_flags1, \newinstr2, \ft_flags2),
 		      \newinstr3, \ft_flags3)
 .endm
 

