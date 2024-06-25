Return-Path: <linux-tip-commits+bounces-1535-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B20B916612
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Jun 2024 13:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61ECAB2638F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Jun 2024 11:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBF71494A0;
	Tue, 25 Jun 2024 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Kh+7Xgeh"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEA917BCC;
	Tue, 25 Jun 2024 11:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719314482; cv=none; b=sC7N0RhZID3fmkXI3w4yOZ51ajrr0vTHPBHP1ghIsfLUFVNhzi82z0yyPfkpzFB6MtBuUK6vy0wiyqTdeeIa90L8almF10HyaJ8BGn3TySQzXeA9hUX7wNSdmXxWbCoqQ/lxRRni/upJ4xcsxHFEVL9CL/WsznyrVgcWUullhaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719314482; c=relaxed/simple;
	bh=z4+/atTlWE3EjM0v4oAFbuOhJkdPNitONLVjJVlFSDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaG9CbIjUq4+xGMuvIQSXiQznDrgLCTj3gBL3AkYE7lJOfevOtWrtjH3kp6sb+zREoAexxaUcVnPp65XhDzr5dPjcEllLS8zOeSJh2BzRBKlgQdU/tgPM6h4RxPDanIdg3KPnRdWB3HYtLLTwmng514GATCcwKrC9Mjj/Ehxot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Kh+7Xgeh reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 82E8840E0219;
	Tue, 25 Jun 2024 11:21:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eBTD0H7a6IY2; Tue, 25 Jun 2024 11:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719314469; bh=umeScDTtjX2Bk1U43cBEGE0OWaiYWb4i3OQhiqA7Kwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kh+7XgehQuHBnlcM0B64o+ERTYbwDYVskBiWJhCCk/xU94Dos7mgjoVB1BpCcLWJx
	 3McIvzOdPf2oGUE0ufc2O5ZLLkEIPI8pupd36f8eUYm6UBpofuQYvDoKBL90QNmr1w
	 TWUvH+xx6ehPrgAzDdgllkT580bZ8vb32Vq8Dd6pOIgq0rZ0oMhbo9fjPfp11zk4KM
	 w1Fx4Ggl4lssSOtRJiKNZC/3YteBFlIHHPl1iKa4f/9P77ZBt4RDy8ugEFYHuf1XtK
	 nqNu49xN8Xb8/k9ve01GK7C5yR5f5gBHgbOZdOa1fhz+pREmhz682wJg6teO36AILM
	 Ri+Q26LXciQowhwe3fI6/Usbprm7rAEhqLdiffgvcF9iaR8S1yLRDolAoziJGd0D3v
	 OeFq+ffupthZ+6ZU1nG5FA9DTn+E1ymofGFvYWXULUtscIIHyvJ/mGgPOYv5FNaElT
	 /igZZ+qqaCbK+l0cyFPCJeT0mjvU+RqzpOOKSpZfTWnPhBVD6NSpZ0CMPmRJaf1+sC
	 SWqkECV8w63Zdq0AI4lPmB8P7Y/J54VWL1diFJl+sVeqFitdT6iBFUzZMOFAvLwVCN
	 5OkMPp5ra2L8FGleBWMcgvyEMtlL3Vpmdxo7a88VCZ4XWll4rrN7aIFTrvnY0F4u+c
	 qouxNMhDRdRe3Ej3q2+2Olko=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0FB4A40E0185;
	Tue, 25 Jun 2024 11:21:03 +0000 (UTC)
Date: Tue, 25 Jun 2024 13:20:56 +0200
From: Borislav Petkov <bp@alien8.de>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Sean Christopherson <seanjc@google.com>, x86@kernel.org,
	Michael Matz <matz@suse.de>
Subject: [PATCH -v2] x86/alternatives, kvm: Fix a couple of CALLs without a
 frame pointer
Message-ID: <20240625112056.GDZnqoGDXgYuWBDUwu@fat_crate.local>
References: <171878639288.10875.12927337921927674667.tip-bot2@tip-bot2>
 <20240620084853.GAZnPs9Q94aakywkUn@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240620084853.GAZnPs9Q94aakywkUn@fat_crate.local>
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 10:48:53AM +0200, Borislav Petkov wrote:
> On Wed, Jun 19, 2024 at 08:39:52AM -0000, tip-bot2 for Borislav Petkov =
(AMD) wrote:
> > The following commit has been merged into the x86/alternatives branch=
 of tip:
> >=20
> > Commit-ID:     93f78dadee5e56ae48aff567583d503868aa3bf2
> > Gitweb:        https://git.kernel.org/tip/93f78dadee5e56ae48aff567583=
d503868aa3bf2
> > Author:        Borislav Petkov (AMD) <bp@alien8.de>
> > AuthorDate:    Tue, 18 Jun 2024 21:57:27 +02:00
> > Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> > CommitterDate: Wed, 19 Jun 2024 10:33:25 +02:00
> >=20
> > x86/alternatives, kvm: Fix a couple of CALLs without a frame pointer
> >=20
> > objtool complains:
> >=20
> >   arch/x86/kvm/kvm.o: warning: objtool: .altinstr_replacement+0xc5: c=
all without frame pointer save/setup
> >   vmlinux.o: warning: objtool: .altinstr_replacement+0x2eb: call with=
out frame pointer save/setup
> >=20
> > Make sure rSP is an output operand to the respective asm() statements=
.
> >=20
> > The test_cc() hunk courtesy of peterz. Also from him add some helpful
> > debugging info to the documentation.
> >=20
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202406141648.jO9qNGLa-l=
kp@intel.com/
> > Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> > Acked-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/include/asm/alternative.h      |  2 +-
> >  arch/x86/kernel/alternative.c           |  2 +-
> >  arch/x86/kvm/emulate.c                  |  2 +-
> >  tools/objtool/Documentation/objtool.txt | 19 +++++++++++++++++++
> >  4 files changed, 22 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/as=
m/alternative.h
> > index 89fa50d..8cff462 100644
> > --- a/arch/x86/include/asm/alternative.h
> > +++ b/arch/x86/include/asm/alternative.h
> > @@ -248,7 +248,7 @@ static inline int alternatives_text_reserved(void=
 *start, void *end)
> >   */
> >  #define alternative_call(oldfunc, newfunc, ft_flags, output, input..=
.)	\
> >  	asm_inline volatile(ALTERNATIVE("call %c[old]", "call %c[new]", ft_=
flags) \
> > -		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
> > +		: output, ASM_CALL_CONSTRAINT : [old] "i" (oldfunc), [new] "i" (ne=
wfunc), ## input)
>=20
> Yeah, this doesn't fly currently:
>=20
> https://lore.kernel.org/r/202406200507.AXxJ6Bmw-lkp@intel.com
>=20
> because those atomic64_32.h macros do
>=20
>         alternative_atomic64(set, /* no output */,
>                              "S" (v), "b" (low), "c" (high)
>=20
> so without an output, it ends up becoming:
>=20
> asm __inline volatile("# ALT: oldinstr\n" ... ".popsection\n" : , "+r" =
(current_stack_pointer) : [old] "i" ...
>=20
> note the preceding ",".
>=20
> And I can't do "output..." macro argument with ellipsis and paste with =
"##
> output" because "input..." already does that. :-\
>=20
> So I am not sure what to do here. Removing the ASM_CALL_CONSTRAINT work=
s,
> let's see whether it passes build tests.
>=20
> Or add dummy output arguments to the three atomic macros which have no
> output?

Ok, after a lot of back'n'forth, here's v2:

---
From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Tue, 18 Jun 2024 21:57:27 +0200
Subject: [PATCH] x86/alternatives, kvm: Fix a couple of CALLs without a f=
rame pointer

objtool complains:

  arch/x86/kvm/kvm.o: warning: objtool: .altinstr_replacement+0xc5: call =
without frame pointer save/setup
  vmlinux.o: warning: objtool: .altinstr_replacement+0x2eb: call without =
frame pointer save/setup

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

  ./arch/x86/include/asm/page_64.h:53:9: error: inconsistent operand cons=
traints in an =E2=80=98asm=E2=80=99

The fix is to use an explicit "D" constraint which points to a singleton
register class (gcc terminology) which ends up doing what is expected
here: the page pointer - input and output - should be in the same %rdi
register.

Other register classes have more than one register in them - example:
"r" and "=3Dr" or "A":

  =E2=80=98A=E2=80=99
	The =E2=80=98a=E2=80=99 and =E2=80=98d=E2=80=99 registers.  This class i=
s used for
	instructions that return double word results in the =E2=80=98ax:dx=E2=80=
=99
	register pair.  Single word values will be allocated either in
	=E2=80=98ax=E2=80=99 or =E2=80=98dx=E2=80=99.

so using "D" and "=3DD" just works in this particular case.

And yes, one would say, sure, why don't you do "+D" but then:

        : "+r" (current_stack_pointer), "+D" (page)
        : [old] "i" (clear_page_orig), [new1] "i" (clear_page_rep), [new2=
] "i" (clear_page_erms),
        : "cc", "memory", "rax", "rcx")

now find the Waldo^Wcomma which throws a wrench into all this.

Because that silly macro has an "input..." consume-all last macro arg
and in it, one is supposed to supply input *and* clobbers, leading to
silly syntax snafus.

Yap, they need to be cleaned up, one fine day...

Cc: Michael Matz <matz@suse.de>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406141648.jO9qNGLa-lkp@i=
ntel.com/
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/alternative.h      | 11 +++++++----
 arch/x86/include/asm/page_64.h          |  2 +-
 arch/x86/kernel/alternative.c           |  2 +-
 arch/x86/kvm/emulate.c                  |  2 +-
 tools/objtool/Documentation/objtool.txt | 19 +++++++++++++++++++
 5 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/al=
ternative.h
index 89fa50d27a08..ca9ae606aab9 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -246,9 +246,10 @@ static inline int alternatives_text_reserved(void *s=
tart, void *end)
  * references: i.e., if used for a function, it would add the PLT
  * suffix.
  */
-#define alternative_call(oldfunc, newfunc, ft_flags, output, input...)	\
-	asm_inline volatile(ALTERNATIVE("call %c[old]", "call %c[new]", ft_flag=
s) \
-		: output : [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
+#define alternative_call(oldfunc, newfunc, ft_flags, output, input...)		=
	\
+	asm_inline volatile(ALTERNATIVE("call %c[old]", "call %c[new]", ft_flag=
s)	\
+		: ALT_OUTPUT_SP(output)							\
+		: [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
=20
 /*
  * Like alternative_call, but there are two features and respective func=
tions.
@@ -260,7 +261,7 @@ static inline int alternatives_text_reserved(void *st=
art, void *end)
 			   output, input...)						\
 	asm_inline volatile(ALTERNATIVE_2("call %c[old]", "call %c[new1]", ft_f=
lags1,	\
 		"call %c[new2]", ft_flags2)						\
-		: output, ASM_CALL_CONSTRAINT						\
+		: ALT_OUTPUT_SP(output)							\
 		: [old] "i" (oldfunc), [new1] "i" (newfunc1),				\
 		  [new2] "i" (newfunc2), ## input)
=20
@@ -276,6 +277,8 @@ static inline int alternatives_text_reserved(void *st=
art, void *end)
  */
 #define ASM_NO_INPUT_CLOBBER(clbr...) "i" (0) : clbr
=20
+#define ALT_OUTPUT_SP(...) ASM_CALL_CONSTRAINT, ## __VA_ARGS__
+
 /* Macro for creating assembler functions avoiding any C magic. */
 #define DEFINE_ASM_FUNC(func, instr, sec)		\
 	asm (".pushsection " #sec ", \"ax\"\n"		\
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_6=
4.h
index cc6b8e087192..af4302d79b59 100644
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
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.=
c
index 37596a417094..333b16181357 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1657,7 +1657,7 @@ static noinline void __init alt_reloc_selftest(void=
)
 	 */
 	asm_inline volatile (
 		ALTERNATIVE("", "lea %[mem], %%" _ASM_ARG1 "; call __alt_reloc_selftes=
t;", X86_FEATURE_ALWAYS)
-		: /* output */
+		: ASM_CALL_CONSTRAINT
 		: [mem] "m" (__alt_reloc_selftest_addr)
 		: _ASM_ARG1
 	);
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 5d4c86133453..c8cc578646d0 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -1069,7 +1069,7 @@ static __always_inline u8 test_cc(unsigned int cond=
ition, unsigned long flags)
=20
 	flags =3D (flags & EFLAGS_MASK) | X86_EFLAGS_IF;
 	asm("push %[flags]; popf; " CALL_NOSPEC
-	    : "=3Da"(rc) : [thunk_target]"r"(fop), [flags]"r"(flags));
+	    : "=3Da"(rc), ASM_CALL_CONSTRAINT : [thunk_target]"r"(fop), [flags]=
"r"(flags));
 	return rc;
 }
=20
diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Docu=
mentation/objtool.txt
index fe39c2a8ef0d..7c3ee959b63c 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -284,6 +284,25 @@ the objtool maintainers.
=20
    Otherwise the stack frame may not get created before the call.
=20
+   objtool can help with pinpointing the exact function where it happens=
:
+
+   $ OBJTOOL_ARGS=3D"--verbose" make arch/x86/kvm/
+
+   arch/x86/kvm/kvm.o: warning: objtool: .altinstr_replacement+0xc5: cal=
l without frame pointer save/setup
+   arch/x86/kvm/kvm.o: warning: objtool:   em_loop.part.0+0x29: (alt)
+   arch/x86/kvm/kvm.o: warning: objtool:   em_loop.part.0+0x0: <=3D=3D=3D=
 (sym)
+    LD [M]  arch/x86/kvm/kvm-intel.o
+   0000 0000000000028220 <em_loop.part.0>:
+   0000    28220:  0f b6 47 61             movzbl 0x61(%rdi),%eax
+   0004    28224:  3c e2                   cmp    $0xe2,%al
+   0006    28226:  74 2c                   je     28254 <em_loop.part.0+=
0x34>
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
--=20
2.43.0

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

