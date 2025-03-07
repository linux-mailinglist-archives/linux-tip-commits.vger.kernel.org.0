Return-Path: <linux-tip-commits+bounces-4053-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B069A574AB
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 23:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E143D3B34ED
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 22:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD7E2580F7;
	Fri,  7 Mar 2025 22:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AmcC9zsf"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AD025A327;
	Fri,  7 Mar 2025 22:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741385185; cv=none; b=eSBg6CdMaRy6Z2F69b1aZHH2wf9ZKoczfuKwJ/NnF6/ZN650KaYHStwaRdOImVPqK/aCDP7CWX/DP08UZ+l+GD690oIlAxR3WF0QgVv5Sa92raOpkuS+furmvAKZTsz+taPhywNVgNXUzQZh0L3NKlDUdjDlhGGSzeH3m7JrgHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741385185; c=relaxed/simple;
	bh=EbA56gWn/oncgVhHPxuinFNhF1hLFj2ugdiw1zgbo3A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FcuAO9PICeT3+QlxN+//mq7xJgqSeEjLCzCIHxqbdRCyWDUAoZw5Dczz8XnUg9xnAS/MpyusFeJzL2El257CacnZRMAKRtAcCymM1uiDDpqas3LgylEqPCnN+TMubFVnIuSxBeUZ1wwzGx1fgbKeZa55x733roAdMiwDxA6F/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=AmcC9zsf; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 527M6Ae3455253
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 7 Mar 2025 14:06:10 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 527M6Ae3455253
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1741385171;
	bh=dbTLVzItEgqbDtm78mu/OBxUCmjLEqigYFxSZB3Ta7g=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=AmcC9zsfSHHea6yhuHOMba7PmDFEzV4Z+aDPEWyeC+7tEVUhqE3FxMDc6IsBEHoOw
	 fzHrHQSXqvBB7HZBatIkE7KDAGqxmKmVPUpXO17ppCY1q6fNnAYkgD2QQSzXMKy80O
	 UnDxoVfsun6R4JAH79qVzHjx0C5MoFxx4p7LxcplucDVK7iOgrN2NYqAUXODf6R5bE
	 lHSSKClFEPBRgpVAfT+nH5OnuQFsW1C0XSoFFO+toDTZmVRp9h2+kG/wl3rO3kNNsg
	 9DFIfYFLwAHFuMGFcSxIvA6mOiAWhMt8shHA1AB6cI45pdru+SWejMWh+C+onCZn4x
	 wgzcJ1ykYd99g==
Date: Fri, 07 Mar 2025 14:06:08 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org,
        tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org
CC: kernel test robot <lkp@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brian Gerst <brgerst@gmail.com>, x86@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Btip=3A_x86/asm=5D_x86/asm=3A_Fix_ASM=5FCAL?=
 =?US-ASCII?Q?L=5FCONSTRAINT_for_Clang_19_+_KCOV_+_KMSAN?=
User-Agent: K-9 Mail for Android
In-Reply-To: <174108458465.14745.15292444415957816824.tip-bot2@tip-bot2>
References: <174108458465.14745.15292444415957816824.tip-bot2@tip-bot2>
Message-ID: <74E07B14-61DB-4346-9F63-B6822A3B50AF@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 4, 2025 2:36:24 AM PST, tip-bot2 for Josh Poimboeuf <tip-bot2@linu=
tronix=2Ede> wrote:
>The following commit has been merged into the x86/asm branch of tip:
>
>Commit-ID:     6530eb13c1fe8ab6452c23815ef17c278665d746
>Gitweb:        https://git=2Ekernel=2Eorg/tip/6530eb13c1fe8ab6452c23815ef=
17c278665d746
>Author:        Josh Poimboeuf <jpoimboe@kernel=2Eorg>
>AuthorDate:    Sun, 02 Mar 2025 17:21:02 -08:00
>Committer:     Ingo Molnar <mingo@kernel=2Eorg>
>CommitterDate: Tue, 04 Mar 2025 11:21:40 +01:00
>
>x86/asm: Fix ASM_CALL_CONSTRAINT for Clang 19 + KCOV + KMSAN
>
>With CONFIG_KCOV and CONFIG_KMSAN enabled, a case was found with Clang
>19 where it takes the ASM_CALL_CONSTRAINT output constraint quite
>literally by saving and restoring %rsp around the inline asm=2E  Not only
>is that completely unecessary, it confuses objtool and results in the
>following warning on Clang 19:
>
>  arch/x86/kvm/cpuid=2Eo: warning: objtool: do_cpuid_func+0x2428: undefin=
ed stack state
>
>After some experimentation it was discovered that an input constraint of
>__builtin_frame_address(0) generates better code for such cases and
>still achieves the desired result of forcing the frame pointer to get
>set up for both compilers=2E  Change ASM_CALL_CONSTRAINT to do that=2E
>
>Fixes: f5caf621ee35 ("x86/asm: Fix inline asm call constraints for Clang"=
)
>Reported-by: kernel test robot <lkp@intel=2Ecom>
>Signed-off-by: Josh Poimboeuf <jpoimboe@kernel=2Eorg>
>Signed-off-by: Ingo Molnar <mingo@kernel=2Eorg>
>Acked-by: Peter Zijlstra (Intel) <peterz@infradead=2Eorg>
>Cc: Linus Torvalds <torvalds@linux-foundation=2Eorg>
>Cc: Brian Gerst <brgerst@gmail=2Ecom>
>Cc: H=2E Peter Anvin <hpa@zytor=2Ecom>
>Cc: linux-kernel@vger=2Ekernel=2Eorg
>Closes: https://lore=2Ekernel=2Eorg/oe-kbuild-all/202502150634=2EqjxwSeJR=
-lkp@intel=2Ecom/
>---
> arch/x86/include/asm/alternative=2Eh    |  8 ++--
> arch/x86/include/asm/asm=2Eh            |  8 ++--
> arch/x86/include/asm/atomic64_32=2Eh    |  3 +-
> arch/x86/include/asm/cmpxchg_32=2Eh     | 13 ++----
> arch/x86/include/asm/irq_stack=2Eh      |  3 +-
> arch/x86/include/asm/mshyperv=2Eh       | 55 +++++++++++++-------------
> arch/x86/include/asm/paravirt_types=2Eh |  6 ++-
> arch/x86/include/asm/percpu=2Eh         | 34 +++++++---------
> arch/x86/include/asm/preempt=2Eh        | 22 +++++-----
> arch/x86/include/asm/sync_core=2Eh      |  6 ++-
> arch/x86/include/asm/uaccess=2Eh        | 12 +++---
> arch/x86/include/asm/uaccess_64=2Eh     | 10 +++--
> arch/x86/include/asm/xen/hypercall=2Eh  |  4 +-
> arch/x86/kernel/alternative=2Ec         |  8 ++--
> arch/x86/kvm/emulate=2Ec                | 11 +++--
> arch/x86/kvm/vmx/vmx_ops=2Eh            |  3 +-
> 16 files changed, 111 insertions(+), 95 deletions(-)
>
>diff --git a/arch/x86/include/asm/alternative=2Eh b/arch/x86/include/asm/=
alternative=2Eh
>index 52626a7=2E=2E5fcfe96 100644
>--- a/arch/x86/include/asm/alternative=2Eh
>+++ b/arch/x86/include/asm/alternative=2Eh
>@@ -239,9 +239,10 @@ static inline int alternatives_text_reserved(void *s=
tart, void *end)
>  */
> #define alternative_call(oldfunc, newfunc, ft_flags, output, input, clob=
bers=2E=2E=2E)	\
> 	asm_inline volatile(ALTERNATIVE("call %c[old]", "call %c[new]", ft_flag=
s)	\
>-		: ALT_OUTPUT_SP(output)							\
>+		: output								\
> 		: [old] "i" (oldfunc), [new] "i" (newfunc)				\
> 		  COMMA(input)								\
>+		  COMMA(ASM_CALL_CONSTRAINT)						\
> 		: clobbers)
>=20
> /*
>@@ -254,14 +255,13 @@ static inline int alternatives_text_reserved(void *=
start, void *end)
> 			   output, input, clobbers=2E=2E=2E)					\
> 	asm_inline volatile(ALTERNATIVE_2("call %c[old]", "call %c[new1]", ft_f=
lags1,	\
> 		"call %c[new2]", ft_flags2)						\
>-		: ALT_OUTPUT_SP(output)							\
>+		: output								\
> 		: [old] "i" (oldfunc), [new1] "i" (newfunc1),				\
> 		  [new2] "i" (newfunc2)							\
> 		  COMMA(input)								\
>+		  COMMA(ASM_CALL_CONSTRAINT)						\
> 		: clobbers)
>=20
>-#define ALT_OUTPUT_SP(=2E=2E=2E) ASM_CALL_CONSTRAINT, ## __VA_ARGS__
>-
> /* Macro for creating assembler functions avoiding any C magic=2E */
> #define DEFINE_ASM_FUNC(func, instr, sec)		\
> 	asm ("=2Epushsection " #sec ", \"ax\"\n"		\
>diff --git a/arch/x86/include/asm/asm=2Eh b/arch/x86/include/asm/asm=2Eh
>index 975ae7a=2E=2E0d268e6 100644
>--- a/arch/x86/include/asm/asm=2Eh
>+++ b/arch/x86/include/asm/asm=2Eh
>@@ -213,6 +213,8 @@ static __always_inline __pure void *rip_rel_ptr(void =
*p)
>=20
> /* For C file, we already have NOKPROBE_SYMBOL macro */
>=20
>+register unsigned long current_stack_pointer asm(_ASM_SP);
>+
> /* Insert a comma if args are non-empty */
> #define COMMA(x=2E=2E=2E)		__COMMA(x)
> #define __COMMA(=2E=2E=2E)		, ##__VA_ARGS__
>@@ -225,13 +227,13 @@ static __always_inline __pure void *rip_rel_ptr(voi=
d *p)
> #define ASM_INPUT(x=2E=2E=2E)		x
>=20
> /*
>- * This output constraint should be used for any inline asm which has a =
"call"
>+ * This input constraint should be used for any inline asm which has a "=
call"
>  * instruction=2E  Otherwise the asm may be inserted before the frame po=
inter
>  * gets set up by the containing function=2E  If you forget to do this, =
objtool
>  * may print a "call without frame pointer save/setup" warning=2E
>  */
>-register unsigned long current_stack_pointer asm(_ASM_SP);
>-#define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
>+#define ASM_CALL_CONSTRAINT "r" (__builtin_frame_address(0))
>+
> #endif /* __ASSEMBLY__ */
>=20
> #define _ASM_EXTABLE(from, to)					\
>diff --git a/arch/x86/include/asm/atomic64_32=2Eh b/arch/x86/include/asm/=
atomic64_32=2Eh
>index ab83820=2E=2E8efb4f2 100644
>--- a/arch/x86/include/asm/atomic64_32=2Eh
>+++ b/arch/x86/include/asm/atomic64_32=2Eh
>@@ -51,9 +51,10 @@ static __always_inline s64 arch_atomic64_read_nonatomi=
c(const atomic64_t *v)
> #ifdef CONFIG_X86_CX8
> #define __alternative_atomic64(f, g, out, in, clobbers=2E=2E=2E)		\
> 	asm volatile("call %c[func]"					\
>-		     : ALT_OUTPUT_SP(out) \
>+		     : out						\
> 		     : [func] "i" (atomic64_##g##_cx8)			\
> 		       COMMA(in)					\
>+		       COMMA(ASM_CALL_CONSTRAINT)			\
> 		     : clobbers)
>=20
> #define ATOMIC64_DECL(sym) ATOMIC64_DECL_ONE(sym##_cx8)
>diff --git a/arch/x86/include/asm/cmpxchg_32=2Eh b/arch/x86/include/asm/c=
mpxchg_32=2Eh
>index ee89fbc=2E=2E3ae0352 100644
>--- a/arch/x86/include/asm/cmpxchg_32=2Eh
>+++ b/arch/x86/include/asm/cmpxchg_32=2Eh
>@@ -95,9 +95,9 @@ static __always_inline bool __try_cmpxchg64_local(volat=
ile u64 *ptr, u64 *oldp,=20
> 		ALTERNATIVE(_lock_loc					\
> 			    "call cmpxchg8b_emu",			\
> 			    _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8)	\
>-		: ALT_OUTPUT_SP("+a" (o=2Elow), "+d" (o=2Ehigh))		\
>-		: "b" (n=2Elow), "c" (n=2Ehigh),				\
>-		  [ptr] "S" (_ptr)					\
>+		: "+a" (o=2Elow), "+d" (o=2Ehigh)				\
>+		: "b" (n=2Elow), "c" (n=2Ehigh), [ptr] "S" (_ptr)		\
>+		  COMMA(ASM_CALL_CONSTRAINT)				\
> 		: "memory");						\
> 									\
> 	o=2Efull;								\
>@@ -126,10 +126,9 @@ static __always_inline u64 arch_cmpxchg64_local(vola=
tile u64 *ptr, u64 old, u64=20
> 			    "call cmpxchg8b_emu",			\
> 			    _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
> 		CC_SET(e)						\
>-		: ALT_OUTPUT_SP(CC_OUT(e) (ret),			\
>-				"+a" (o=2Elow), "+d" (o=2Ehigh))		\
>-		: "b" (n=2Elow), "c" (n=2Ehigh),				\
>-		  [ptr] "S" (_ptr)					\
>+		: CC_OUT(e) (ret), "+a" (o=2Elow), "+d" (o=2Ehigh)		\
>+		: "b" (n=2Elow), "c" (n=2Ehigh), [ptr] "S" (_ptr)		\
>+		  COMMA(ASM_CALL_CONSTRAINT)				\
> 		: "memory");						\
> 									\
> 	if (unlikely(!ret))						\
>diff --git a/arch/x86/include/asm/irq_stack=2Eh b/arch/x86/include/asm/ir=
q_stack=2Eh
>index 562a547=2E=2E8e56a07 100644
>--- a/arch/x86/include/asm/irq_stack=2Eh
>+++ b/arch/x86/include/asm/irq_stack=2Eh
>@@ -92,8 +92,9 @@
> 									\
> 	"popq	%%rsp					\n"		\
> 									\
>-	: "+r" (tos), ASM_CALL_CONSTRAINT				\
>+	: "+r" (tos)							\
> 	: [__func] "i" (func), [tos] "r" (tos) argconstr		\
>+	  COMMA(ASM_CALL_CONSTRAINT)					\
> 	: "cc", "rax", "rcx", "rdx", "rsi", "rdi", "r8", "r9", "r10",	\
> 	  "memory"							\
> 	);								\
>diff --git a/arch/x86/include/asm/mshyperv=2Eh b/arch/x86/include/asm/msh=
yperv=2Eh
>index 5e6193d=2E=2E791a9b2 100644
>--- a/arch/x86/include/asm/mshyperv=2Eh
>+++ b/arch/x86/include/asm/mshyperv=2Eh
>@@ -79,9 +79,10 @@ static inline u64 hv_do_hypercall(u64 control, void *i=
nput, void *output)
> 	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
> 		__asm__ __volatile__("mov %[output_address], %%r8\n"
> 				     "vmmcall"
>-				     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
>-				       "+c" (control), "+d" (input_address)
>+				     : "=3Da" (hv_status), "+c" (control),
>+				       "+d" (input_address)
> 				     : [output_address] "r" (output_address)
>+				       COMMA(ASM_CALL_CONSTRAINT)
> 				     : "cc", "memory", "r8", "r9", "r10", "r11");
> 		return hv_status;
> 	}
>@@ -91,10 +92,11 @@ static inline u64 hv_do_hypercall(u64 control, void *=
input, void *output)
>=20
> 	__asm__ __volatile__("mov %[output_address], %%r8\n"
> 			     CALL_NOSPEC
>-			     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
>-			       "+c" (control), "+d" (input_address)
>+			     : "=3Da" (hv_status), "+c" (control),
>+			       "+d" (input_address)
> 			     : [output_address] "r" (output_address),
> 			       THUNK_TARGET(hv_hypercall_pg)
>+			       COMMA(ASM_CALL_CONSTRAINT)
> 			     : "cc", "memory", "r8", "r9", "r10", "r11");
> #else
> 	u32 input_address_hi =3D upper_32_bits(input_address);
>@@ -106,12 +108,11 @@ static inline u64 hv_do_hypercall(u64 control, void=
 *input, void *output)
> 		return U64_MAX;
>=20
> 	__asm__ __volatile__(CALL_NOSPEC
>-			     : "=3DA" (hv_status),
>-			       "+c" (input_address_lo), ASM_CALL_CONSTRAINT
>-			     : "A" (control),
>-			       "b" (input_address_hi),
>-			       "D"(output_address_hi), "S"(output_address_lo),
>+			     : "=3DA" (hv_status), "+c" (input_address_lo)
>+			     : "A" (control), "b" (input_address_hi),
>+			       "D" (output_address_hi), "S"(output_address_lo),
> 			       THUNK_TARGET(hv_hypercall_pg)
>+			       COMMA(ASM_CALL_CONSTRAINT)
> 			     : "cc", "memory");
> #endif /* !x86_64 */
> 	return hv_status;
>@@ -135,14 +136,16 @@ static inline u64 _hv_do_fast_hypercall8(u64 contro=
l, u64 input1)
> 	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
> 		__asm__ __volatile__(
> 				"vmmcall"
>-				: "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
>-				"+c" (control), "+d" (input1)
>-				:: "cc", "r8", "r9", "r10", "r11");
>+				: "=3Da" (hv_status), "+c" (control),
>+				  "+d" (input1)
>+				: ASM_CALL_CONSTRAINT
>+				: "cc", "r8", "r9", "r10", "r11");
> 	} else {
> 		__asm__ __volatile__(CALL_NOSPEC
>-				     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
>-				       "+c" (control), "+d" (input1)
>+				     : "=3Da" (hv_status), "+c" (control),
>+				       "+d" (input1)
> 				     : THUNK_TARGET(hv_hypercall_pg)
>+				       COMMA(ASM_CALL_CONSTRAINT)
> 				     : "cc", "r8", "r9", "r10", "r11");
> 	}
> #else
>@@ -151,12 +154,10 @@ static inline u64 _hv_do_fast_hypercall8(u64 contro=
l, u64 input1)
> 		u32 input1_lo =3D lower_32_bits(input1);
>=20
> 		__asm__ __volatile__ (CALL_NOSPEC
>-				      : "=3DA"(hv_status),
>-					"+c"(input1_lo),
>-					ASM_CALL_CONSTRAINT
>-				      :	"A" (control),
>-					"b" (input1_hi),
>+				      : "=3DA"(hv_status), "+c"(input1_lo)
>+				      :	"A" (control), "b" (input1_hi),
> 					THUNK_TARGET(hv_hypercall_pg)
>+					COMMA(ASM_CALL_CONSTRAINT)
> 				      : "cc", "edi", "esi");
> 	}
> #endif
>@@ -189,17 +190,19 @@ static inline u64 _hv_do_fast_hypercall16(u64 contr=
ol, u64 input1, u64 input2)
> 	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
> 		__asm__ __volatile__("mov %[input2], %%r8\n"
> 				     "vmmcall"
>-				     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
>-				       "+c" (control), "+d" (input1)
>+				     : "=3Da" (hv_status), "+c" (control),
>+				       "+d" (input1)
> 				     : [input2] "r" (input2)
>+				       COMMA(ASM_CALL_CONSTRAINT)
> 				     : "cc", "r8", "r9", "r10", "r11");
> 	} else {
> 		__asm__ __volatile__("mov %[input2], %%r8\n"
> 				     CALL_NOSPEC
>-				     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
>-				       "+c" (control), "+d" (input1)
>+				     : "=3Da" (hv_status), "+c" (control),
>+				       "+d" (input1)
> 				     : [input2] "r" (input2),
> 				       THUNK_TARGET(hv_hypercall_pg)
>+				       COMMA(ASM_CALL_CONSTRAINT)
> 				     : "cc", "r8", "r9", "r10", "r11");
> 	}
> #else
>@@ -210,11 +213,11 @@ static inline u64 _hv_do_fast_hypercall16(u64 contr=
ol, u64 input1, u64 input2)
> 		u32 input2_lo =3D lower_32_bits(input2);
>=20
> 		__asm__ __volatile__ (CALL_NOSPEC
>-				      : "=3DA"(hv_status),
>-					"+c"(input1_lo), ASM_CALL_CONSTRAINT
>+				      : "=3DA"(hv_status), "+c" (input1_lo)
> 				      :	"A" (control), "b" (input1_hi),
>-					"D"(input2_hi), "S"(input2_lo),
>+					"D" (input2_hi), "S" (input2_lo),
> 					THUNK_TARGET(hv_hypercall_pg)
>+					COMMA(ASM_CALL_CONSTRAINT)
> 				      : "cc");
> 	}
> #endif
>diff --git a/arch/x86/include/asm/paravirt_types=2Eh b/arch/x86/include/a=
sm/paravirt_types=2Eh
>index e26633c=2E=2E68bdce6 100644
>--- a/arch/x86/include/asm/paravirt_types=2Eh
>+++ b/arch/x86/include/asm/paravirt_types=2Eh
>@@ -392,9 +392,10 @@ int paravirt_disable_iospace(void);
> 		PVOP_TEST_NULL(op);					\
> 		asm volatile(ALTERNATIVE(PARAVIRT_CALL, ALT_CALL_INSTR,	\
> 				ALT_CALL_ALWAYS)			\
>-			     : call_clbr, ASM_CALL_CONSTRAINT		\
>+			     : call_clbr				\
> 			     : paravirt_ptr(op),			\
> 			       ##__VA_ARGS__				\
>+			       COMMA(ASM_CALL_CONSTRAINT)		\
> 			     : "memory", "cc" extra_clbr);		\
> 		ret;							\
> 	})
>@@ -407,9 +408,10 @@ int paravirt_disable_iospace(void);
> 		asm volatile(ALTERNATIVE_2(PARAVIRT_CALL,		\
> 				 ALT_CALL_INSTR, ALT_CALL_ALWAYS,	\
> 				 alt, cond)				\
>-			     : call_clbr, ASM_CALL_CONSTRAINT		\
>+			     : call_clbr				\
> 			     : paravirt_ptr(op),			\
> 			       ##__VA_ARGS__				\
>+			       COMMA(ASM_CALL_CONSTRAINT)		\
> 			     : "memory", "cc" extra_clbr);		\
> 		ret;							\
> 	})
>diff --git a/arch/x86/include/asm/percpu=2Eh b/arch/x86/include/asm/percp=
u=2Eh
>index 8a8cf86=2E=2E60390a0 100644
>--- a/arch/x86/include/asm/percpu=2Eh
>+++ b/arch/x86/include/asm/percpu=2Eh
>@@ -323,10 +323,10 @@ do {									\
> 	asm_inline qual (						\
> 		ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
> 			    "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
>-		: ALT_OUTPUT_SP([var] "+m" (__my_cpu_var(_var)),	\
>-				"+a" (old__=2Elow), "+d" (old__=2Ehigh))	\
>-		: "b" (new__=2Elow), "c" (new__=2Ehigh),			\
>-		  "S" (&(_var))						\
>+		: [var] "+m" (__my_cpu_var(_var)), "+a" (old__=2Elow),	\
>+		   "+d" (old__=2Ehigh)					\
>+		: "b" (new__=2Elow), "c" (new__=2Ehigh), "S" (&(_var))	\
>+		  COMMA(ASM_CALL_CONSTRAINT)				\
> 		: "memory");						\
> 									\
> 	old__=2Evar;							\
>@@ -353,11 +353,10 @@ do {									\
> 		ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
> 			    "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
> 		CC_SET(z)						\
>-		: ALT_OUTPUT_SP(CC_OUT(z) (success),			\
>-				[var] "+m" (__my_cpu_var(_var)),	\
>-				"+a" (old__=2Elow), "+d" (old__=2Ehigh))	\
>-		: "b" (new__=2Elow), "c" (new__=2Ehigh),			\
>-		  "S" (&(_var))						\
>+		: CC_OUT(z) (success), [var] "+m" (__my_cpu_var(_var)),	\
>+		  "+a" (old__=2Elow), "+d" (old__=2Ehigh)			\
>+		: "b" (new__=2Elow), "c" (new__=2Ehigh), "S" (&(_var))	\
>+		  COMMA(ASM_CALL_CONSTRAINT)				\
> 		: "memory");						\
> 	if (unlikely(!success))						\
> 		*_oval =3D old__=2Evar;					\
>@@ -392,10 +391,10 @@ do {									\
> 	asm_inline qual (						\
> 		ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
> 			    "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
>-		: ALT_OUTPUT_SP([var] "+m" (__my_cpu_var(_var)),	\
>-				"+a" (old__=2Elow), "+d" (old__=2Ehigh))	\
>-		: "b" (new__=2Elow), "c" (new__=2Ehigh),			\
>-		  "S" (&(_var))						\
>+		: [var] "+m" (__my_cpu_var(_var)), "+a" (old__=2Elow),	\
>+		   "+d" (old__=2Ehigh)					\
>+		: "b" (new__=2Elow), "c" (new__=2Ehigh), "S" (&(_var))	\
>+		  COMMA(ASM_CALL_CONSTRAINT)				\
> 		: "memory");						\
> 									\
> 	old__=2Evar;							\
>@@ -422,11 +421,10 @@ do {									\
> 		ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
> 			    "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
> 		CC_SET(z)						\
>-		: ALT_OUTPUT_SP(CC_OUT(z) (success),			\
>-				[var] "+m" (__my_cpu_var(_var)),	\
>-				"+a" (old__=2Elow), "+d" (old__=2Ehigh))	\
>-		: "b" (new__=2Elow), "c" (new__=2Ehigh),			\
>-		  "S" (&(_var))						\
>+		: CC_OUT(z) (success), [var] "+m" (__my_cpu_var(_var)),	\
>+		  "+a" (old__=2Elow), "+d" (old__=2Ehigh)			\
>+		: "b" (new__=2Elow), "c" (new__=2Ehigh), "S" (&(_var))	\
>+		  COMMA(ASM_CALL_CONSTRAINT)				\
> 		: "memory");						\
> 	if (unlikely(!success))						\
> 		*_oval =3D old__=2Evar;					\
>diff --git a/arch/x86/include/asm/preempt=2Eh b/arch/x86/include/asm/pree=
mpt=2Eh
>index 919909d=2E=2E7e83482 100644
>--- a/arch/x86/include/asm/preempt=2Eh
>+++ b/arch/x86/include/asm/preempt=2Eh
>@@ -121,27 +121,29 @@ extern asmlinkage void preempt_schedule_notrace_thu=
nk(void);
>=20
> DECLARE_STATIC_CALL(preempt_schedule, preempt_schedule_dynamic_enabled);
>=20
>-#define __preempt_schedule() \
>-do { \
>-	__STATIC_CALL_MOD_ADDRESSABLE(preempt_schedule); \
>-	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule) : ASM_CAL=
L_CONSTRAINT); \
>+#define __preempt_schedule()						\
>+do {									\
>+	__STATIC_CALL_MOD_ADDRESSABLE(preempt_schedule);		\
>+	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule)	\
>+		      : : ASM_CALL_CONSTRAINT);				\
> } while (0)
>=20
> DECLARE_STATIC_CALL(preempt_schedule_notrace, preempt_schedule_notrace_d=
ynamic_enabled);
>=20
>-#define __preempt_schedule_notrace() \
>-do { \
>-	__STATIC_CALL_MOD_ADDRESSABLE(preempt_schedule_notrace); \
>-	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule_notrace) :=
 ASM_CALL_CONSTRAINT); \
>+#define __preempt_schedule_notrace()					\
>+do {									\
>+	__STATIC_CALL_MOD_ADDRESSABLE(preempt_schedule_notrace);	\
>+	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule_notrace) \
>+		      : : ASM_CALL_CONSTRAINT);				\
> } while (0)
>=20
> #else /* PREEMPT_DYNAMIC */
>=20
> #define __preempt_schedule() \
>-	asm volatile ("call preempt_schedule_thunk" : ASM_CALL_CONSTRAINT);
>+	asm volatile ("call preempt_schedule_thunk" : : ASM_CALL_CONSTRAINT);
>=20
> #define __preempt_schedule_notrace() \
>-	asm volatile ("call preempt_schedule_notrace_thunk" : ASM_CALL_CONSTRAI=
NT);
>+	asm volatile ("call preempt_schedule_notrace_thunk" : : ASM_CALL_CONSTR=
AINT);
>=20
> #endif /* PREEMPT_DYNAMIC */
>=20
>diff --git a/arch/x86/include/asm/sync_core=2Eh b/arch/x86/include/asm/sy=
nc_core=2Eh
>index 96bda43=2E=2Ec88e354 100644
>--- a/arch/x86/include/asm/sync_core=2Eh
>+++ b/arch/x86/include/asm/sync_core=2Eh
>@@ -16,7 +16,7 @@ static __always_inline void iret_to_self(void)
> 		"pushl $1f\n\t"
> 		"iret\n\t"
> 		"1:"
>-		: ASM_CALL_CONSTRAINT : : "memory");
>+		: : ASM_CALL_CONSTRAINT : "memory");
> }
> #else
> static __always_inline void iret_to_self(void)
>@@ -34,7 +34,9 @@ static __always_inline void iret_to_self(void)
> 		"pushq $1f\n\t"
> 		"iretq\n\t"
> 		"1:"
>-		: "=3D&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
>+		: "=3D&r" (tmp)
>+		: ASM_CALL_CONSTRAINT
>+		: "cc", "memory");
> }
> #endif /* CONFIG_X86_32 */
>=20
>diff --git a/arch/x86/include/asm/uaccess=2Eh b/arch/x86/include/asm/uacc=
ess=2Eh
>index 3a7755c=2E=2E4a5f0c1 100644
>--- a/arch/x86/include/asm/uaccess=2Eh
>+++ b/arch/x86/include/asm/uaccess=2Eh
>@@ -79,9 +79,9 @@ extern int __get_user_bad(void);
> 	register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);		\
> 	__chk_user_ptr(ptr);						\
> 	asm volatile("call __" #fn "_%c[size]"				\
>-		     : "=3Da" (__ret_gu), "=3Dr" (__val_gu),		\
>-			ASM_CALL_CONSTRAINT				\
>-		     : "0" (ptr), [size] "i" (sizeof(*(ptr))));		\
>+		     : "=3Da" (__ret_gu), "=3Dr" (__val_gu)			\
>+		     : "0" (ptr), [size] "i" (sizeof(*(ptr)))		\
>+		       COMMA(ASM_CALL_CONSTRAINT));			\
> 	instrument_get_user(__val_gu);					\
> 	(x) =3D (__force __typeof__(*(ptr))) __val_gu;			\
> 	__builtin_expect(__ret_gu, 0);					\
>@@ -178,12 +178,12 @@ extern void __put_user_nocheck_8(void);
> 	__ptr_pu =3D __ptr;						\
> 	__val_pu =3D __x;							\
> 	asm volatile("call __" #fn "_%c[size]"				\
>-		     : "=3Dc" (__ret_pu),					\
>-			ASM_CALL_CONSTRAINT				\
>+		     : "=3Dc" (__ret_pu)					\
> 		     : "0" (__ptr_pu),					\
> 		       "r" (__val_pu),					\
> 		       [size] "i" (sizeof(*(ptr)))			\
>-		     :"ebx");						\
>+		       COMMA(ASM_CALL_CONSTRAINT)			\
>+		     : "ebx");						\
> 	instrument_put_user(__x, __ptr, sizeof(*(ptr)));		\
> 	__builtin_expect(__ret_pu, 0);					\
> })
>diff --git a/arch/x86/include/asm/uaccess_64=2Eh b/arch/x86/include/asm/u=
access_64=2Eh
>index c52f013=2E=2E87a1b9e 100644
>--- a/arch/x86/include/asm/uaccess_64=2Eh
>+++ b/arch/x86/include/asm/uaccess_64=2Eh
>@@ -129,8 +129,9 @@ copy_user_generic(void *to, const void *from, unsigne=
d long len)
> 			    "call rep_movs_alternative", ALT_NOT(X86_FEATURE_FSRM))
> 		"2:\n"
> 		_ASM_EXTABLE_UA(1b, 2b)
>-		:"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
>-		: : "memory", "rax");
>+		: "+c" (len), "+D" (to), "+S" (from)
>+		: ASM_CALL_CONSTRAINT
>+		: "memory", "rax");
> 	clac();
> 	return len;
> }
>@@ -191,8 +192,9 @@ static __always_inline __must_check unsigned long __c=
lear_user(void __user *addr
> 			    "call rep_stos_alternative", ALT_NOT(X86_FEATURE_FSRS))
> 		"2:\n"
> 	       _ASM_EXTABLE_UA(1b, 2b)
>-	       : "+c" (size), "+D" (addr), ASM_CALL_CONSTRAINT
>-	       : "a" (0));
>+	       : "+c" (size), "+D" (addr)
>+	       : "a" (0)
>+	         COMMA(ASM_CALL_CONSTRAINT));
>=20
> 	clac();
>=20
>diff --git a/arch/x86/include/asm/xen/hypercall=2Eh b/arch/x86/include/as=
m/xen/hypercall=2Eh
>index 97771b9=2E=2E683772a 100644
>--- a/arch/x86/include/asm/xen/hypercall=2Eh
>+++ b/arch/x86/include/asm/xen/hypercall=2Eh
>@@ -101,7 +101,7 @@ DECLARE_STATIC_CALL(xen_hypercall, xen_hypercall_func=
);
> 	__ADDRESSABLE_xen_hypercall			\
> 	"call __SCT__xen_hypercall"
>=20
>-#define __HYPERCALL_ENTRY(x)	"a" (x)
>+#define __HYPERCALL_ENTRY(x)	"a" (x) COMMA(ASM_CALL_CONSTRAINT)
>=20
> #ifdef CONFIG_X86_32
> #define __HYPERCALL_RETREG	"eax"
>@@ -127,7 +127,7 @@ DECLARE_STATIC_CALL(xen_hypercall, xen_hypercall_func=
);
> 	register unsigned long __arg4 asm(__HYPERCALL_ARG4REG) =3D __arg4; \
> 	register unsigned long __arg5 asm(__HYPERCALL_ARG5REG) =3D __arg5;
>=20
>-#define __HYPERCALL_0PARAM	"=3Dr" (__res), ASM_CALL_CONSTRAINT
>+#define __HYPERCALL_0PARAM	"=3Dr" (__res)
> #define __HYPERCALL_1PARAM	__HYPERCALL_0PARAM, "+r" (__arg1)
> #define __HYPERCALL_2PARAM	__HYPERCALL_1PARAM, "+r" (__arg2)
> #define __HYPERCALL_3PARAM	__HYPERCALL_2PARAM, "+r" (__arg3)
>diff --git a/arch/x86/kernel/alternative=2Ec b/arch/x86/kernel/alternativ=
e=2Ec
>index 8b66a55=2E=2E6a7eb06 100644
>--- a/arch/x86/kernel/alternative=2Ec
>+++ b/arch/x86/kernel/alternative=2Ec
>@@ -1624,8 +1624,8 @@ static noinline void __init int3_selftest(void)
> 	asm volatile ("int3_selftest_ip:\n\t"
> 		      ANNOTATE_NOENDBR
> 		      "    int3; nop; nop; nop; nop\n\t"
>-		      : ASM_CALL_CONSTRAINT
>-		      : __ASM_SEL_RAW(a, D) (&val)
>+		      : : __ASM_SEL_RAW(a, D) (&val)
>+			  COMMA(ASM_CALL_CONSTRAINT)
> 		      : "memory");
>=20
> 	BUG_ON(val !=3D 1);
>@@ -1657,8 +1657,8 @@ static noinline void __init alt_reloc_selftest(void=
)
> 	 */
> 	asm_inline volatile (
> 		ALTERNATIVE("", "lea %[mem], %%" _ASM_ARG1 "; call __alt_reloc_selftes=
t;", X86_FEATURE_ALWAYS)
>-		: ASM_CALL_CONSTRAINT
>-		: [mem] "m" (__alt_reloc_selftest_addr)
>+		: : [mem] "m" (__alt_reloc_selftest_addr)
>+		    COMMA(ASM_CALL_CONSTRAINT)
> 		: _ASM_ARG1
> 	);
> }
>diff --git a/arch/x86/kvm/emulate=2Ec b/arch/x86/kvm/emulate=2Ec
>index 60986f6=2E=2E40e12a1 100644
>--- a/arch/x86/kvm/emulate=2Ec
>+++ b/arch/x86/kvm/emulate=2Ec
>@@ -1070,7 +1070,9 @@ static __always_inline u8 test_cc(unsigned int cond=
ition, unsigned long flags)
>=20
> 	flags =3D (flags & EFLAGS_MASK) | X86_EFLAGS_IF;
> 	asm("push %[flags]; popf; " CALL_NOSPEC
>-	    : "=3Da"(rc), ASM_CALL_CONSTRAINT : [thunk_target]"r"(fop), [flags]=
"r"(flags));
>+	    : "=3Da" (rc)
>+	    : [thunk_target] "r" (fop), [flags] "r" (flags)
>+	      COMMA(ASM_CALL_CONSTRAINT));
> 	return rc;
> }
>=20
>@@ -5079,9 +5081,10 @@ static int fastop(struct x86_emulate_ctxt *ctxt, f=
astop_t fop)
> 		fop +=3D __ffs(ctxt->dst=2Ebytes) * FASTOP_SIZE;
>=20
> 	asm("push %[flags]; popf; " CALL_NOSPEC " ; pushf; pop %[flags]\n"
>-	    : "+a"(ctxt->dst=2Eval), "+d"(ctxt->src=2Eval), [flags]"+D"(flags),
>-	      [thunk_target]"+S"(fop), ASM_CALL_CONSTRAINT
>-	    : "c"(ctxt->src2=2Eval));
>+	    : "+a" (ctxt->dst=2Eval), "+d" (ctxt->src=2Eval), [flags] "+D" (fla=
gs),
>+	      [thunk_target] "+S" (fop)
>+	    : "c" (ctxt->src2=2Eval)
>+	      COMMA(ASM_CALL_CONSTRAINT));
>=20
> 	ctxt->eflags =3D (ctxt->eflags & ~EFLAGS_MASK) | (flags & EFLAGS_MASK);
> 	if (!fop) /* exception is returned in fop variable */
>diff --git a/arch/x86/kvm/vmx/vmx_ops=2Eh b/arch/x86/kvm/vmx/vmx_ops=2Eh
>index 9667757=2E=2Ea614add 100644
>--- a/arch/x86/kvm/vmx/vmx_ops=2Eh
>+++ b/arch/x86/kvm/vmx/vmx_ops=2Eh
>@@ -144,8 +144,9 @@ do_exception:
> 		     /* VMREAD faulted=2E  As above, except push '1' for @fault=2E */
> 		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_ONE_REG, %[output])
>=20
>-		     : ASM_CALL_CONSTRAINT, [output] "=3D&r" (value)
>+		     : [output] "=3D&r" (value)
> 		     : [field] "r" (field)
>+		       COMMA(ASM_CALL_CONSTRAINT)
> 		     : "cc");
> 	return value;
>=20

Note that the gcc people have explicitly disavowed this form and have reje=
cted a request to support it going forward=2E=20

As such, it seems like a Really Bad Idea 

