Return-Path: <linux-tip-commits+bounces-1375-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1914F9041F6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 18:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67AFFB25ED7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Jun 2024 16:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4766D1509A5;
	Tue, 11 Jun 2024 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NME+nvAV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OmWsWnTi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417B3762C9;
	Tue, 11 Jun 2024 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124845; cv=none; b=KKxN41k/MyYSVZO72PbB4kW6qwDcqFX51p2pCT6t/mTpq3m651Tad0s8x42Elh8NH6RkhuNGIsZqGdtgX4aGD0XfZGyGXhp8X0bFbCw5wiqrsTivSpwK2RttPTiuXI1eUbmwkEIDoSXnrXecBxWVW/G1ifrxqj4wgBuaVYh6bdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124845; c=relaxed/simple;
	bh=0YePFj61i8a8ZWaFR7/CzKwB4q/PzndTkIIzwv2k1kI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZB3mrJznpx9l6wQkJ44/gUJVKb9jCiYoE2rvTRspvhUJleubnJXWc2RYCx92TzJ3Hs7nZv1wzku2TO6Oob/GgL+29hh0SDP0knQJ5l+YdX3q7oA+nQn4C9E2Ls8tmul0NNzoPo2ONWF1ZLBxdVXFjybgurqrbsrtRhFXfEhiqxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NME+nvAV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OmWsWnTi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Jun 2024 16:53:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718124830;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6cOGxRRtAnD87jl8xBlp4v4yUxhCBnmB42roU8yWLbQ=;
	b=NME+nvAVHUBKCrzcYDa0y8GqRVyiKrEXWKXnRhHmOk0tXH/AOTqJfLw5XrBzghmH2VD+OB
	TCHmiwcp0Vsh8EH5JdtvanQbkxDwINidQEV/yUSqYu+o97JcICp6Grr2tlH0mVlRVdKvWw
	vuusq8P5kdehWNcWkRgUI4U0AjO9i56Hfv5JUZJzAX6LTP8ch/af4Rrpju2j30u+A/ynpW
	ZZJ20cBROsvhp3D8p2pKQyQI6b5ssyx8dN1yB2g2QL5UOWWybZq5Dw7Xr7B4N9DqFoESEN
	WkuUWW50DPaBfv4XKxtz3OUzethfX3kKymIkTQwWRXr4Wk172utbdbo26t1PGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718124830;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6cOGxRRtAnD87jl8xBlp4v4yUxhCBnmB42roU8yWLbQ=;
	b=OmWsWnTiTZdhOI9onFxgkngV5jVn7f/VR7mpc6VzGt+uqroRcOdU9+5ZlokngjoX1WwYRJ
	chBlC54NO2yN8+AA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/alternatives] x86/alternatives: Add nested alternatives macros
Cc: Peter Zijlstra <peterz@infradead.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20230628104952.GA2439977@hirez.programming.kicks-ass.net>
References: <20230628104952.GA2439977@hirez.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171812482994.10875.12791012762142829324.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     d2a793dae219b7cd61a3d63c0a6ea76153f0629f
Gitweb:        https://git.kernel.org/tip/d2a793dae219b7cd61a3d63c0a6ea76153f0629f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 07 Jun 2024 13:16:49 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 11 Jun 2024 17:13:08 +02:00

x86/alternatives: Add nested alternatives macros

Instead of making increasingly complicated ALTERNATIVE_n()
implementations, use a nested alternative expression.

The only difference between:

  ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2)

and

  ALTERNATIVE(ALTERNATIVE(oldinst, newinst1, flag1),
              newinst2, flag2)

is that the outer alternative can add additional padding when the inner
alternative is the shorter one, which then results in
alt_instr::instrlen being inconsistent.

However, this is easily remedied since the alt_instr entries will be
consecutive and it is trivial to compute the max(alt_instr::instrlen) at
runtime while patching.

Specifically, after this the ALTERNATIVE_2 macro, after CPP expansion
(and manual layout), looks like this:

  .macro ALTERNATIVE_2 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2
  740:
  740: \oldinstr ;
  741: .skip -(((744f-743f)-(741b-740b)) > 0) * ((744f-743f)-(741b-740b)),0x90 ;
  742: .pushsection .altinstructions,"a" ;
  	altinstr_entry 740b,743f,\ft_flags1,742b-740b,744f-743f ;
  .popsection ;
  .pushsection .altinstr_replacement,"ax" ;
  743: \newinstr1 ;
  744: .popsection ; ;
  741: .skip -(((744f-743f)-(741b-740b)) > 0) * ((744f-743f)-(741b-740b)),0x90 ;
  742: .pushsection .altinstructions,"a" ;
  altinstr_entry 740b,743f,\ft_flags2,742b-740b,744f-743f ;
  .popsection ;
  .pushsection .altinstr_replacement,"ax" ;
  743: \newinstr2 ;
  744: .popsection ;
  .endm

The only label that is ambiguous is 740, however they all reference the
same spot, so that doesn't matter.

NOTE: obviously only @oldinstr may be an alternative; making @newinstr
an alternative would mean patching .altinstr_replacement which very
likely isn't what is intended, also the labels will be confused in that
case.

  [ bp: Debug an issue where it would match the wrong two insns and
    and consider them nested due to the same signed offsets in the
    .alternative section and use instr_va() to compare the full virtual
    addresses instead.

    - Use new labels to denote that the new, nested
    alternatives are being used when staring at preprocessed output.

    - Use the %c constraint everywhere instead of %P and document the
      difference for future reference. ]

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230628104952.GA2439977@hirez.programming.kicks-ass.net
---
 arch/x86/include/asm/alternative.h | 120 +++++++++++++++++++++++++++-
 arch/x86/kernel/alternative.c      |  20 ++++-
 tools/objtool/arch/x86/special.c   |  23 +++++-
 tools/objtool/special.c            |  16 ++--
 4 files changed, 167 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 6db7890..7d9ebc5 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -161,8 +161,13 @@ static inline int alternatives_text_reserved(void *start, void *end)
 
 #define alt_end_marker		"663"
 #define alt_slen		"662b-661b"
+#define n_alt_slen		"772b-771b"
+
 #define alt_total_slen		alt_end_marker"b-661b"
+#define n_alt_total_slen	"773b-771b"
+
 #define alt_rlen(num)		e_replacement(num)"f-"b_replacement(num)"f"
+#define n_alt_rlen		"775f-774f"
 
 #define OLDINSTR(oldinstr, num)						\
 	"# ALT: oldnstr\n"						\
@@ -172,6 +177,14 @@ static inline int alternatives_text_reserved(void *start, void *end)
 		"((" alt_rlen(num) ")-(" alt_slen ")),0x90\n"		\
 	alt_end_marker ":\n"
 
+#define N_OLDINSTR(oldinstr)						\
+	"# N_ALT: oldinstr\n"						\
+	"771:\n\t" oldinstr "\n772:\n"					\
+	"# N_ALT: padding\n"						\
+	".skip -(((" n_alt_rlen ")-(" n_alt_slen ")) > 0) * "		\
+		"((" n_alt_rlen ")-(" n_alt_slen ")),0x90\n"		\
+	"773:\n"
+
 /*
  * gas compatible max based on the idea from:
  * http://graphics.stanford.edu/~seander/bithacks.html#IntegerMinOrMax
@@ -209,10 +222,25 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	" .byte " alt_total_slen "\n"			/* source len      */ \
 	" .byte " alt_rlen(num) "\n"			/* replacement len */
 
+#define N_ALTINSTR_ENTRY(ft_flags)					      \
+	".pushsection .altinstructions,\"a\"\n"				      \
+	" .long 771b - .\n"				/* label           */ \
+	" .long 774f - .\n"				/* new instruction */ \
+	" .4byte " __stringify(ft_flags) "\n"		/* feature + flags */ \
+	" .byte " n_alt_total_slen "\n"			/* source len      */ \
+	" .byte " n_alt_rlen "\n"			/* replacement len */ \
+	".popsection\n"
+
 #define ALTINSTR_REPLACEMENT(newinstr, num)		/* replacement */	\
 	"# ALT: replacement " #num "\n"						\
 	b_replacement(num)":\n\t" newinstr "\n" e_replacement(num) ":\n"
 
+#define N_ALTINSTR_REPLACEMENT(newinstr)		/* replacement */	\
+	".pushsection .altinstr_replacement, \"ax\"\n"				\
+	"# N_ALT: replacement\n"						\
+	"774:\n\t" newinstr "\n775:\n"						\
+	".popsection\n"
+
 /* alternative assembly primitive: */
 #define ALTERNATIVE(oldinstr, newinstr, ft_flags)			\
 	OLDINSTR(oldinstr, 1)						\
@@ -223,6 +251,12 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	ALTINSTR_REPLACEMENT(newinstr, 1)				\
 	".popsection\n"
 
+/* Nested alternatives macro variant */
+#define N_ALTERNATIVE(oldinstr, newinstr, ft_flags)			\
+	N_OLDINSTR(oldinstr)						\
+	N_ALTINSTR_ENTRY(ft_flags)					\
+	N_ALTINSTR_REPLACEMENT(newinstr)
+
 #define ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
 	OLDINSTR_2(oldinstr, 1, 2)					\
 	".pushsection .altinstructions,\"a\"\n"				\
@@ -234,11 +268,21 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	ALTINSTR_REPLACEMENT(newinstr2, 2)				\
 	".popsection\n"
 
+#define N_ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2)	\
+	N_ALTERNATIVE(N_ALTERNATIVE(oldinst, newinst1, flag1),		\
+		      newinst2, flag2)
+
 /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
 #define ALTERNATIVE_TERNARY(oldinstr, ft_flags, newinstr_yes, newinstr_no) \
 	ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
 		      newinstr_yes, ft_flags)
 
+/* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
+#define N_ALTERNATIVE_TERNARY(oldinstr, ft_flags, newinstr_yes, newinstr_no) \
+	N_ALTERNATIVE_2(oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
+		      newinstr_yes, ft_flags)
+
+
 #define ALTERNATIVE_3(oldinsn, newinsn1, ft_flags1, newinsn2, ft_flags2, \
 			newinsn3, ft_flags3)				\
 	OLDINSTR_3(oldinsn, 1, 2, 3)					\
@@ -253,6 +297,12 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	ALTINSTR_REPLACEMENT(newinsn3, 3)				\
 	".popsection\n"
 
+
+#define N_ALTERNATIVE_3(oldinst, newinst1, flag1, newinst2, flag2,	\
+		      newinst3, flag3)					\
+	N_ALTERNATIVE(N_ALTERNATIVE_2(oldinst, newinst1, flag1, newinst2, flag2), \
+		      newinst3, flag3)
+
 /*
  * Alternative instructions for different CPU types or capabilities.
  *
@@ -271,6 +321,12 @@ static inline int alternatives_text_reserved(void *start, void *end)
 #define alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
 	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
 
+#define n_alternative(oldinstr, newinstr, ft_flags)			\
+	asm_inline volatile (N_ALTERNATIVE(oldinstr, newinstr, ft_flags) : : : "memory")
+
+#define n_alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
+	asm_inline volatile(N_ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
+
 /*
  * Alternative inline assembly with input.
  *
@@ -288,11 +344,32 @@ static inline int alternatives_text_reserved(void *start, void *end)
 	asm_inline volatile (ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
 		: output : "i" (0), ## input)
 
-/* Like alternative_io, but for replacing a direct call with another one. */
+#define n_alternative_io(oldinstr, newinstr, ft_flags, output, input...)	\
+	asm_inline volatile (N_ALTERNATIVE(oldinstr, newinstr, ft_flags)	\
+		: output : "i" (0), ## input)
+
+/*
+ * Like alternative_io, but for replacing a direct call with another one.
+ *
+ * Use the %c operand modifier which is the generic way to print a bare
+ * constant expression with all syntax-specific punctuation omitted. %P
+ * is the x86-specific variant which can handle constants too, for
+ * historical reasons, but it should be used primarily for PIC
+ * references: i.e., if used for a function, it would add the PLT
+ * suffix.
+ */
 #define alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
 	asm_inline volatile (ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
 		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
 
+#define n_alternative_input(oldinstr, newinstr, ft_flags, input...)	\
+	asm_inline volatile (N_ALTERNATIVE(oldinstr, newinstr, ft_flags) \
+		: : "i" (0), ## input)
+
+#define n_alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
+	asm_inline volatile (N_ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
+		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
+
 /*
  * Like alternative_call, but there are two features and respective functions.
  * If CPU has feature2, function2 is used.
@@ -307,6 +384,15 @@ static inline int alternatives_text_reserved(void *start, void *end)
 		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		\
 		  [new2] "i" (newfunc2), ## input)
 
+#define n_alternative_call_2(oldfunc, newfunc1, ft_flags1, newfunc2, ft_flags2,   \
+			   output, input...)				      \
+	asm_inline volatile (N_ALTERNATIVE_2("call %c[old]", "call %c[new1]", ft_flags1,\
+		"call %c[new2]", ft_flags2)				      \
+		: output, ASM_CALL_CONSTRAINT				      \
+		: [old] "i" (oldfunc), [new1] "i" (newfunc1),		      \
+		  [new2] "i" (newfunc2), ## input)
+
+
 /*
  * use this macro(s) if you need more than one output parameter
  * in alternative_io
@@ -403,6 +489,27 @@ void nop_func(void);
 	.popsection
 .endm
 
+#define __N_ALTERNATIVE(oldinst, newinst, flag)				\
+740:									\
+	oldinst	;							\
+741:									\
+	.skip -(((744f-743f)-(741b-740b)) > 0) * ((744f-743f)-(741b-740b)),0x90	;\
+742:									\
+	.pushsection .altinstructions,"a" ;				\
+	altinstr_entry 740b,743f,flag,742b-740b,744f-743f ;		\
+	.popsection ;							\
+	.pushsection .altinstr_replacement,"ax"	;			\
+743:									\
+	newinst	;							\
+744:									\
+	.popsection ;
+
+
+.macro N_ALTERNATIVE oldinstr, newinstr, ft_flags
+	__N_ALTERNATIVE(\oldinstr, \newinstr, \ft_flags)
+.endm
+
+
 #define old_len			141b-140b
 #define new_len1		144f-143f
 #define new_len2		145f-144f
@@ -417,7 +524,6 @@ void nop_func(void);
 #define alt_max_2(a, b)		((a) ^ (((a) ^ (b)) & -(-((a) < (b)))))
 #define alt_max_3(a, b, c)	(alt_max_2(alt_max_2(a, b), c))
 
-
 /*
  * Same as ALTERNATIVE macro above but for two alternatives. If CPU
  * has @feature1, it replaces @oldinstr with @newinstr1. If CPU has
@@ -445,6 +551,11 @@ void nop_func(void);
 	.popsection
 .endm
 
+.macro N_ALTERNATIVE_2 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2
+	__N_ALTERNATIVE(__N_ALTERNATIVE(\oldinstr, \newinstr1, \ft_flags1),
+		      \newinstr2, \ft_flags2)
+.endm
+
 .macro ALTERNATIVE_3 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2, newinstr3, ft_flags3
 140:
 	\oldinstr
@@ -470,6 +581,11 @@ void nop_func(void);
 	.popsection
 .endm
 
+.macro N_ALTERNATIVE_3 oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2, newinstr3, ft_flags3
+	__N_ALTERNATIVE(N_ALTERNATIVE_2(\oldinstr, \newinstr1, \ft_flags1, \newinstr2, \ft_flags2),
+		      \newinstr3, \ft_flags3)
+.endm
+
 /* If @feature is set, patch in @newinstr_yes, otherwise @newinstr_no. */
 #define ALTERNATIVE_TERNARY(oldinstr, ft_flags, newinstr_yes, newinstr_no) \
 	ALTERNATIVE_2 oldinstr, newinstr_no, X86_FEATURE_ALWAYS,	\
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 89de612..37596a4 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -432,6 +432,11 @@ static int alt_replace_call(u8 *instr, u8 *insn_buff, struct alt_instr *a)
 	return 5;
 }
 
+static inline u8 * instr_va(struct alt_instr *i)
+{
+	return (u8 *)&i->instr_offset + i->instr_offset;
+}
+
 /*
  * Replace instructions with better alternatives for this CPU type. This runs
  * before SMP is initialized to avoid SMP problems with self modifying code.
@@ -447,7 +452,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 {
 	u8 insn_buff[MAX_PATCH_LEN];
 	u8 *instr, *replacement;
-	struct alt_instr *a;
+	struct alt_instr *a, *b;
 
 	DPRINTK(ALT, "alt table %px, -> %px", start, end);
 
@@ -473,7 +478,18 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	for (a = start; a < end; a++) {
 		int insn_buff_sz = 0;
 
-		instr = (u8 *)&a->instr_offset + a->instr_offset;
+		/*
+		 * In case of nested ALTERNATIVE()s the outer alternative might
+		 * add more padding. To ensure consistent patching find the max
+		 * padding for all alt_instr entries for this site (nested
+		 * alternatives result in consecutive entries).
+		 */
+		for (b = a+1; b < end && instr_va(b) == instr_va(a); b++) {
+			u8 len = max(a->instrlen, b->instrlen);
+			a->instrlen = b->instrlen = len;
+		}
+
+		instr = instr_va(a);
 		replacement = (u8 *)&a->repl_offset + a->repl_offset;
 		BUG_ON(a->instrlen > sizeof(insn_buff));
 		BUG_ON(a->cpuid >= (NCAPINTS + NBUGINTS) * 32);
diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 4134d27..4ea0f98 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -9,6 +9,29 @@
 
 void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
 {
+	static struct special_alt *group, *prev;
+
+	/*
+	 * Recompute orig_len for nested ALTERNATIVE()s.
+	 */
+	if (group && group->orig_sec == alt->orig_sec &&
+	             group->orig_off == alt->orig_off) {
+
+		struct special_alt *iter = group;
+		for (;;) {
+			unsigned int len = max(iter->orig_len, alt->orig_len);
+			iter->orig_len = alt->orig_len = len;
+
+			if (iter == prev)
+				break;
+
+			iter = list_next_entry(iter, list);
+		}
+
+	} else group = alt;
+
+	prev = alt;
+
 	switch (feature) {
 	case X86_FEATURE_SMAP:
 		/*
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 91b1950..097a69d 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -84,6 +84,14 @@ static int get_alt_entry(struct elf *elf, const struct special_entry *entry,
 						  entry->new_len);
 	}
 
+	orig_reloc = find_reloc_by_dest(elf, sec, offset + entry->orig);
+	if (!orig_reloc) {
+		WARN_FUNC("can't find orig reloc", sec, offset + entry->orig);
+		return -1;
+	}
+
+	reloc_to_sec_off(orig_reloc, &alt->orig_sec, &alt->orig_off);
+
 	if (entry->feature) {
 		unsigned short feature;
 
@@ -94,14 +102,6 @@ static int get_alt_entry(struct elf *elf, const struct special_entry *entry,
 		arch_handle_alternative(feature, alt);
 	}
 
-	orig_reloc = find_reloc_by_dest(elf, sec, offset + entry->orig);
-	if (!orig_reloc) {
-		WARN_FUNC("can't find orig reloc", sec, offset + entry->orig);
-		return -1;
-	}
-
-	reloc_to_sec_off(orig_reloc, &alt->orig_sec, &alt->orig_off);
-
 	if (!entry->group || alt->new_len) {
 		new_reloc = find_reloc_by_dest(elf, sec, offset + entry->new);
 		if (!new_reloc) {

