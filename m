Return-Path: <linux-tip-commits+bounces-1559-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5636391DD4E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Jul 2024 13:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792EC1C2221E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Jul 2024 11:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB6F1422D5;
	Mon,  1 Jul 2024 10:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hHLWjD2c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ntR6b4CN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7713813C679;
	Mon,  1 Jul 2024 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831526; cv=none; b=IbzMBFLT96T1c7FKpUZ08IJkfGAht8C/SuP1xaxJb5aaKkqmUy87RPOjfwTU7LdM+D9/j27PYn7b7c7w1j9IpUlMnwBDRTqgTolqO3rDCgE0B7JWYLLP0x/WbogiWF8S6lYz9jKNBKIoU023KolkBaZOvwAFyOcZOMoVeFTsddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831526; c=relaxed/simple;
	bh=dvB6cq6Shk/nT2ygAmtV9jIBZ8ILkqgbfSML6JYifAE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U3terGt4u5rtVxO+Zve8OhJveJYfRd7deMzqSy2Cz3pdu160eU7pRoa5kOLT6YMo3w38gu5ZgHd6zYFriPrMiniRCF9fFFVWlYHtb8CZI1UwFCFj53YbOHIGqo/6bZtVul0/wBBRvjguoVsyzt4sOLPLlKTM21kmUFGb2xkMq4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hHLWjD2c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ntR6b4CN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 01 Jul 2024 10:58:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719831522;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+hZfLHF2ZZNas6gNgmBY/bQjvDtG6z+ibDPBkkEVSIg=;
	b=hHLWjD2cOr20w1pP9xVb8px2iPWls93DBSW70Ft2f4N67FTPMsQ47tWsibN3tnOY3Y2W9l
	BzbJp8biUumeiXozyJpJuObvDkvDmiq1cEhP/Xj80HRDrMKNyVbdkldaxUsd496kQ5eUcQ
	a2txNpTPt6WBBlkp8AtOxpNA4oFnlxlNAOcfd88GO8+2KVPJGBsRsrxA7iBCKFP673XTYf
	XVJSQoL0bulFnT7wtiLswHXipABSiChWt/40VeoypHKEaCMhD0NqhmAcNHZgj+a+sbIOCo
	R5zqYbmHfvC2oEtkG0uONrwyd8+BFLXbs+WRaetclSS3RrIsOSd/Wiuq8/cnBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719831522;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+hZfLHF2ZZNas6gNgmBY/bQjvDtG6z+ibDPBkkEVSIg=;
	b=ntR6b4CNxooXFXWNiaddJvog5GtMG+JU98+husJaFhs9xUUzdzqWVGdx1Nn+SltodWDa92
	znFXcnbVRX2PYkCw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives, kvm: Fix a couple of CALLs
 without a frame pointer
Cc: kernel test robot <lkp@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Sean Christopherson <seanjc@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240625112056.GDZnqoGDXgYuWBDUwu@fat_crate.local>
References: <20240625112056.GDZnqoGDXgYuWBDUwu@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171983152213.2215.267828172301059191.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     0d3db1f14abb4eb28613fbeb1e2ad92bac76debf
Gitweb:        https://git.kernel.org/tip/0d3db1f14abb4eb28613fbeb1e2ad92bac7=
6debf
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 18 Jun 2024 21:57:27 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 01 Jul 2024 12:41:11 +02:00

x86/alternatives, kvm: Fix a couple of CALLs without a frame pointer

objtool complains:

  arch/x86/kvm/kvm.o: warning: objtool: .altinstr_replacement+0xc5: call with=
out frame pointer save/setup
  vmlinux.o: warning: objtool: .altinstr_replacement+0x2eb: call without fram=
e pointer save/setup

Make sure %rSP is an output operand to the respective asm() statements.

The test_cc() hunk and ALT_OUTPUT_SP() courtesy of peterz. Also from him
add some helpful debugging info to the documentation.

Now on to the explanations:

tl;dr: The alternatives macros are pretty fragile.

If I do ALT_OUTPUT_SP(output) in order to be able to package in a %rsp
reference for objtool so that a stack frame gets properly generated, the
inline asm input operand with positional argument 0 in clear_page():

	"0" (page)

gets "renumbered" due to the added

	: "+r" (current_stack_pointer), "=3DD" (page)

and then gcc says:

  ./arch/x86/include/asm/page_64.h:53:9: error: inconsistent operand constrai=
nts in an =E2=80=98asm=E2=80=99

The fix is to use an explicit "D" constraint which points to a singleton
register class (gcc terminology) which ends up doing what is expected
here: the page pointer - input and output - should be in the same %rdi
register.

Other register classes have more than one register in them - example:
"r" and "=3Dr" or "A":

  =E2=80=98A=E2=80=99
	The =E2=80=98a=E2=80=99 and =E2=80=98d=E2=80=99 registers.  This class is us=
ed for
	instructions that return double word results in the =E2=80=98ax:dx=E2=80=99
	register pair.  Single word values will be allocated either in
	=E2=80=98ax=E2=80=99 or =E2=80=98dx=E2=80=99.

so using "D" and "=3DD" just works in this particular case.

And yes, one would say, sure, why don't you do "+D" but then:

  : "+r" (current_stack_pointer), "+D" (page)
  : [old] "i" (clear_page_orig), [new1] "i" (clear_page_rep), [new2] "i" (cle=
ar_page_erms),
  : "cc", "memory", "rax", "rcx")

now find the Waldo^Wcomma which throws a wrench into all this.

Because that silly macro has an "input..." consume-all last macro arg
and in it, one is supposed to supply input *and* clobbers, leading to
silly syntax snafus.

Yap, they need to be cleaned up, one fine day...

Closes: https://lore.kernel.org/oe-kbuild-all/202406141648.jO9qNGLa-lkp@intel=
.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Sean Christopherson <seanjc@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240625112056.GDZnqoGDXgYuWBDUwu@fat_crate.l=
ocal
---
 arch/x86/include/asm/alternative.h      | 11 +++++++----
 arch/x86/include/asm/page_64.h          |  2 +-
 arch/x86/kernel/alternative.c           |  2 +-
 arch/x86/kvm/emulate.c                  |  2 +-
 tools/objtool/Documentation/objtool.txt | 19 +++++++++++++++++++
 5 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/altern=
ative.h
index 89fa50d..ca9ae60 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -246,9 +246,10 @@ static inline int alternatives_text_reserved(void *start=
, void *end)
  * references: i.e., if used for a function, it would add the PLT
  * suffix.
  */
-#define alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
-	asm_inline volatile(ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags) \
-		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
+#define alternative_call(oldfunc, newfunc, ft_flags, output, input...)			\
+	asm_inline volatile(ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags)	\
+		: ALT_OUTPUT_SP(output)							\
+		: [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
=20
 /*
  * Like alternative_call, but there are two features and respective function=
s.
@@ -260,7 +261,7 @@ static inline int alternatives_text_reserved(void *start,=
 void *end)
 			   output, input...)						\
 	asm_inline volatile(ALTERNATIVE_2("call %c[old]", "call %c[new1]", ft_flags=
1,	\
 		"call %c[new2]", ft_flags2)						\
-		: output, ASM_CALL_CONSTRAINT						\
+		: ALT_OUTPUT_SP(output)							\
 		: [old] "i" (oldfunc), [new1] "i" (newfunc1),				\
 		  [new2] "i" (newfunc2), ## input)
=20
@@ -276,6 +277,8 @@ static inline int alternatives_text_reserved(void *start,=
 void *end)
  */
 #define ASM_NO_INPUT_CLOBBER(clbr...) "i" (0) : clbr
=20
+#define ALT_OUTPUT_SP(...) ASM_CALL_CONSTRAINT, ## __VA_ARGS__
+
 /* Macro for creating assembler functions avoiding any C magic. */
 #define DEFINE_ASM_FUNC(func, instr, sec)		\
 	asm (".pushsection " #sec ", \"ax\"\n"		\
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index cc6b8e0..af4302d 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -54,7 +54,7 @@ static inline void clear_page(void *page)
 			   clear_page_rep, X86_FEATURE_REP_GOOD,
 			   clear_page_erms, X86_FEATURE_ERMS,
 			   "=3DD" (page),
-			   "0" (page)
+			   "D" (page)
 			   : "cc", "memory", "rax", "rcx");
 }
=20
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 37596a4..333b161 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1657,7 +1657,7 @@ static noinline void __init alt_reloc_selftest(void)
 	 */
 	asm_inline volatile (
 		ALTERNATIVE("", "lea %[mem], %%" _ASM_ARG1 "; call __alt_reloc_selftest;",=
 X86_FEATURE_ALWAYS)
-		: /* output */
+		: ASM_CALL_CONSTRAINT
 		: [mem] "m" (__alt_reloc_selftest_addr)
 		: _ASM_ARG1
 	);
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 5d4c861..c8cc578 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -1069,7 +1069,7 @@ static __always_inline u8 test_cc(unsigned int conditio=
n, unsigned long flags)
=20
 	flags =3D (flags & EFLAGS_MASK) | X86_EFLAGS_IF;
 	asm("push %[flags]; popf; " CALL_NOSPEC
-	    : "=3Da"(rc) : [thunk_target]"r"(fop), [flags]"r"(flags));
+	    : "=3Da"(rc), ASM_CALL_CONSTRAINT : [thunk_target]"r"(fop), [flags]"r"(=
flags));
 	return rc;
 }
=20
diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Document=
ation/objtool.txt
index fe39c2a..7c3ee95 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -284,6 +284,25 @@ the objtool maintainers.
=20
    Otherwise the stack frame may not get created before the call.
=20
+   objtool can help with pinpointing the exact function where it happens:
+
+   $ OBJTOOL_ARGS=3D"--verbose" make arch/x86/kvm/
+
+   arch/x86/kvm/kvm.o: warning: objtool: .altinstr_replacement+0xc5: call wi=
thout frame pointer save/setup
+   arch/x86/kvm/kvm.o: warning: objtool:   em_loop.part.0+0x29: (alt)
+   arch/x86/kvm/kvm.o: warning: objtool:   em_loop.part.0+0x0: <=3D=3D=3D (s=
ym)
+    LD [M]  arch/x86/kvm/kvm-intel.o
+   0000 0000000000028220 <em_loop.part.0>:
+   0000    28220:  0f b6 47 61             movzbl 0x61(%rdi),%eax
+   0004    28224:  3c e2                   cmp    $0xe2,%al
+   0006    28226:  74 2c                   je     28254 <em_loop.part.0+0x34>
+   0008    28228:  48 8b 57 10             mov    0x10(%rdi),%rdx
+   000c    2822c:  83 f0 05                xor    $0x5,%eax
+   000f    2822f:  48 c1 e0 04             shl    $0x4,%rax
+   0013    28233:  25 f0 00 00 00          and    $0xf0,%eax
+   0018    28238:  81 e2 d5 08 00 00       and    $0x8d5,%edx
+   001e    2823e:  80 ce 02                or     $0x2,%dh
+   ...
=20
 2. file.o: warning: objtool: .text+0x53: unreachable instruction
=20

