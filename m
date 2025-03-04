Return-Path: <linux-tip-commits+bounces-3857-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FEDA4D68D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56FD189733F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 08:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1601FAC4B;
	Tue,  4 Mar 2025 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2+ecUkY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1576D1F940A;
	Tue,  4 Mar 2025 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077233; cv=none; b=OokqKjDBAKsqM4p+JCOhJDidURRBdFoxhkcBIpH9EVQXACB/3xR1qYhaNvphKTElRo+6EbseTE7eEbG7sErmeHYyJHSweM4Bfd4vV/Mv18saLFK3TOaQh1g5xYhM1nlsIDh/a/M71xBA3fn2hxAi27ThIDudbiiGnOlM6EGn7cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077233; c=relaxed/simple;
	bh=Ht4OJzTxG8XwdTFlaBjvctOYbm/k4EgVeKznGYXAPK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlVY+oveFRKloCDsyKE/4deVbk4QEFjMgXIv2nG8YgdEmObJZN4VrbnNwe/B3oV/EhWcNl0jCmzEZOLPslmBq5K3MDmN/zxtNoLnaffXjSQJbglKwLRHawE1Arvvie98AYRnS86YHC5zKSjv0z/9PscXQgIPpnmkoKJe9csd0bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2+ecUkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F738C4CEE5;
	Tue,  4 Mar 2025 08:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741077232;
	bh=Ht4OJzTxG8XwdTFlaBjvctOYbm/k4EgVeKznGYXAPK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X2+ecUkY2VoXgiDMe2xfPakGotDTJ7HRmGrFi6W2i2ZQxu3/SYpMptYGtnW/69q2v
	 1khMXgZwQe+rJOfaqlRbLwftD818yOjAEFXXpVABLQ6yn8g4xBaU0AoG6AuzBCUcVj
	 gRdAVns9Ngk7q1tj9g9lYGVhWA2qO5KnQZZb9U5VuyiqLkJNiSuDrNSbuyDzJGU2RR
	 f+BdfyzsFgaZ2NysXBHwNR6R3LknzhSz7dxluL7uY4fnR9XS+xG+joOfOZFrjPEwcj
	 B7MERW3DWDpp+vsQzMPVFB0m04ZQP65W3w/0Ra8EDdwGP2G3MLh5u2QvwyznUIO6Ea
	 i6AlN6uc6W/dA==
Date: Tue, 4 Mar 2025 09:33:47 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
Message-ID: <Z8a66_DbMbP-V5mi@gmail.com>
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
 <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 3 Mar 2025 at 01:02, tip-bot2 for Josh Poimboeuf
> <tip-bot2@linutronix.de> wrote:
> >
> > x86/asm: Make ASM_CALL_CONSTRAINT conditional on frame pointers
> >
> > With frame pointers enabled, ASM_CALL_CONSTRAINT is used in an inline
> > asm statement with a call instruction to force the compiler to set up
> > the frame pointer before doing the call.
> >
> > Without frame pointers, no such constraint is needed.  Make it
> > conditional on frame pointers.
> 
> Can we please explain *why* this is done?
> 
> It may not be required, but it makes the source code uglier and adds a
> conditional. What's the advantage of adding this extra logic?
> 
> I'm sure there is some reason for this change, but that reason should
> be explained.
> 
> Because "we don't need it" cuts both ways. Maybe we don't need the
> ASM_CALL_CONSTRAINT, but it also didn't use to hurt us.
> 
> The problems seems entirely caused by the change to use a strictly
> inferior version of ASM_CALL_CONSTRAINT.
> 
> Is there really no better option? Because the new ASM_CALL_CONSTRAINT
> seems actively horrendous.

So Josh forgot to Cc: lkml in this 5-patch series:

63852     Mar 02 Josh Poimboeuf     | [PATCH 0/5] x86: Fix ASM_CALL_CONSTRAINT for Clang 19 and disable it for ORC
63853     Mar 02 Josh Poimboeuf     | ├─>[PATCH 1/5] KVM: VMX: Use named operands in inline asm
63855     Mar 02 Josh Poimboeuf     | ├─>[PATCH 2/5] x86/hyperv: Use named operands in inline asm
63856     Mar 02 Josh Poimboeuf     | ├─>[PATCH 3/5] x86/alternative: Simplify alternative_call() interface
63857     Mar 02 Josh Poimboeuf     | ├─>[PATCH 4/5] x86: Fix ASM_CALL_CONSTRAINT for Clang 19 + KCOV + KMSAN
63858     Mar 02 Josh Poimboeuf     | ├─>[PATCH 5/5] x86: Make ASM_CALL_CONSTRAINT conditional on frame pointers

... which omission I tried to fix in the commits by adding Cc: lkml - 
but which made the discussion unthreaded on Lore ... a mistake I won't 
repeat.

This reply of yours is for patch 5/5 which is arguably out of context 
in isolation, while the main justification for changing 
ASM_CALL_CONSTRAINT is in 4/5 (a Clang 19 code generation quirk to fix 
a warning) - see attached it below.

The full 5-patch series in -next is:

  cccc85ea4032 KVM: VMX: Use named operands in inline asm
  2668d7b4aff8 x86/hyperv: Use named operands in inline asm
  1edd623ccaaf x86/alternatives: Simplify alternative_call() interface
  96092b7552d9 x86/asm: Fix ASM_CALL_CONSTRAINT for Clang 19 + KCOV + KMSAN
  e5ff90b179d4 x86/asm: Make ASM_CALL_CONSTRAINT conditional on frame pointers

I bounced you the key emails, but I'm not sure that helps much.

I'll avoid this situation in the future, Cc:lkml works well for 
individual patches and I used it in the past, but it loses context in 
the series-submission case.

Thanks,

	Ingo

===============================>
From 96092b7552d96f841c94265920c922da72ab46e3 Mon Sep 17 00:00:00 2001
From: Josh Poimboeuf <jpoimboe@kernel.org>
Date: Sun, 2 Mar 2025 17:21:02 -0800
Subject: [PATCH] x86/asm: Fix ASM_CALL_CONSTRAINT for Clang 19 + KCOV + KMSAN

With CONFIG_KCOV and CONFIG_KMSAN enabled, a case was found with Clang
19 where it takes the ASM_CALL_CONSTRAINT output constraint quite
literally by saving and restoring %rsp around the inline asm.  Not only
is that completely unecessary, it confuses objtool and results in the
following warning on Clang 19:

  arch/x86/kvm/cpuid.o: warning: objtool: do_cpuid_func+0x2428: undefined stack state

After some experimentation it was discovered that an input constraint of
__builtin_frame_address(0) generates better code for such cases and
still achieves the desired result of forcing the frame pointer to get
set up for both compilers.  Change ASM_CALL_CONSTRAINT to do that.

Fixes: f5caf621ee35 ("x86/asm: Fix inline asm call constraints for Clang")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Closes: https://lore.kernel.org/oe-kbuild-all/202502150634.qjxwSeJR-lkp@intel.com/
---
 arch/x86/include/asm/alternative.h    |  8 ++---
 arch/x86/include/asm/asm.h            |  8 +++--
 arch/x86/include/asm/atomic64_32.h    |  3 +-
 arch/x86/include/asm/cmpxchg_32.h     | 13 ++++-----
 arch/x86/include/asm/irq_stack.h      |  3 +-
 arch/x86/include/asm/mshyperv.h       | 55 ++++++++++++++++++-----------------
 arch/x86/include/asm/paravirt_types.h |  6 ++--
 arch/x86/include/asm/percpu.h         | 34 ++++++++++------------
 arch/x86/include/asm/preempt.h        | 22 +++++++-------
 arch/x86/include/asm/sync_core.h      |  6 ++--
 arch/x86/include/asm/uaccess.h        | 12 ++++----
 arch/x86/include/asm/uaccess_64.h     | 10 ++++---
 arch/x86/include/asm/xen/hypercall.h  |  4 +--
 arch/x86/kernel/alternative.c         |  8 ++---
 arch/x86/kvm/emulate.c                | 11 ++++---
 arch/x86/kvm/vmx/vmx_ops.h            |  3 +-
 16 files changed, 111 insertions(+), 95 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 52626a7251e6..5fcfe96d7c72 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -239,9 +239,10 @@ static inline int alternatives_text_reserved(void *start, void *end)
  */
 #define alternative_call(oldfunc, newfunc, ft_flags, output, input, clobbers...)	\
 	asm_inline volatile(ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags)	\
-		: ALT_OUTPUT_SP(output)							\
+		: output								\
 		: [old] "i" (oldfunc), [new] "i" (newfunc)				\
 		  COMMA(input)								\
+		  COMMA(ASM_CALL_CONSTRAINT)						\
 		: clobbers)
 
 /*
@@ -254,14 +255,13 @@ static inline int alternatives_text_reserved(void *start, void *end)
 			   output, input, clobbers...)					\
 	asm_inline volatile(ALTERNATIVE_2("call %c[old]", "call %c[new1]", ft_flags1,	\
 		"call %c[new2]", ft_flags2)						\
-		: ALT_OUTPUT_SP(output)							\
+		: output								\
 		: [old] "i" (oldfunc), [new1] "i" (newfunc1),				\
 		  [new2] "i" (newfunc2)							\
 		  COMMA(input)								\
+		  COMMA(ASM_CALL_CONSTRAINT)						\
 		: clobbers)
 
-#define ALT_OUTPUT_SP(...) ASM_CALL_CONSTRAINT, ## __VA_ARGS__
-
 /* Macro for creating assembler functions avoiding any C magic. */
 #define DEFINE_ASM_FUNC(func, instr, sec)		\
 	asm (".pushsection " #sec ", \"ax\"\n"		\
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 975ae7a9397e..0d268e6875db 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -213,6 +213,8 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
 
 /* For C file, we already have NOKPROBE_SYMBOL macro */
 
+register unsigned long current_stack_pointer asm(_ASM_SP);
+
 /* Insert a comma if args are non-empty */
 #define COMMA(x...)		__COMMA(x)
 #define __COMMA(...)		, ##__VA_ARGS__
@@ -225,13 +227,13 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
 #define ASM_INPUT(x...)		x
 
 /*
- * This output constraint should be used for any inline asm which has a "call"
+ * This input constraint should be used for any inline asm which has a "call"
  * instruction.  Otherwise the asm may be inserted before the frame pointer
  * gets set up by the containing function.  If you forget to do this, objtool
  * may print a "call without frame pointer save/setup" warning.
  */
-register unsigned long current_stack_pointer asm(_ASM_SP);
-#define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
+#define ASM_CALL_CONSTRAINT "r" (__builtin_frame_address(0))
+
 #endif /* __ASSEMBLY__ */
 
 #define _ASM_EXTABLE(from, to)					\
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index ab838205c1c6..8efb4f2eacb5 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -51,9 +51,10 @@ static __always_inline s64 arch_atomic64_read_nonatomic(const atomic64_t *v)
 #ifdef CONFIG_X86_CX8
 #define __alternative_atomic64(f, g, out, in, clobbers...)		\
 	asm volatile("call %c[func]"					\
-		     : ALT_OUTPUT_SP(out) \
+		     : out						\
 		     : [func] "i" (atomic64_##g##_cx8)			\
 		       COMMA(in)					\
+		       COMMA(ASM_CALL_CONSTRAINT)			\
 		     : clobbers)
 
 #define ATOMIC64_DECL(sym) ATOMIC64_DECL_ONE(sym##_cx8)
diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index ee89fbc4dd4b..3ae0352604f0 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -95,9 +95,9 @@ static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp,
 		ALTERNATIVE(_lock_loc					\
 			    "call cmpxchg8b_emu",			\
 			    _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8)	\
-		: ALT_OUTPUT_SP("+a" (o.low), "+d" (o.high))		\
-		: "b" (n.low), "c" (n.high),				\
-		  [ptr] "S" (_ptr)					\
+		: "+a" (o.low), "+d" (o.high)				\
+		: "b" (n.low), "c" (n.high), [ptr] "S" (_ptr)		\
+		  COMMA(ASM_CALL_CONSTRAINT)				\
 		: "memory");						\
 									\
 	o.full;								\
@@ -126,10 +126,9 @@ static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64
 			    "call cmpxchg8b_emu",			\
 			    _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
 		CC_SET(e)						\
-		: ALT_OUTPUT_SP(CC_OUT(e) (ret),			\
-				"+a" (o.low), "+d" (o.high))		\
-		: "b" (n.low), "c" (n.high),				\
-		  [ptr] "S" (_ptr)					\
+		: CC_OUT(e) (ret), "+a" (o.low), "+d" (o.high)		\
+		: "b" (n.low), "c" (n.high), [ptr] "S" (_ptr)		\
+		  COMMA(ASM_CALL_CONSTRAINT)				\
 		: "memory");						\
 									\
 	if (unlikely(!ret))						\
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 562a547c29a5..8e56a07aef70 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -92,8 +92,9 @@
 									\
 	"popq	%%rsp					\n"		\
 									\
-	: "+r" (tos), ASM_CALL_CONSTRAINT				\
+	: "+r" (tos)							\
 	: [__func] "i" (func), [tos] "r" (tos) argconstr		\
+	  COMMA(ASM_CALL_CONSTRAINT)					\
 	: "cc", "rax", "rcx", "rdx", "rsi", "rdi", "r8", "r9", "r10",	\
 	  "memory"							\
 	);								\
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 5e6193dbc97e..791a9b2537f0 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -79,9 +79,10 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
 		__asm__ __volatile__("mov %[output_address], %%r8\n"
 				     "vmmcall"
-				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
-				       "+c" (control), "+d" (input_address)
+				     : "=a" (hv_status), "+c" (control),
+				       "+d" (input_address)
 				     : [output_address] "r" (output_address)
+				       COMMA(ASM_CALL_CONSTRAINT)
 				     : "cc", "memory", "r8", "r9", "r10", "r11");
 		return hv_status;
 	}
@@ -91,10 +92,11 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 
 	__asm__ __volatile__("mov %[output_address], %%r8\n"
 			     CALL_NOSPEC
-			     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
-			       "+c" (control), "+d" (input_address)
+			     : "=a" (hv_status), "+c" (control),
+			       "+d" (input_address)
 			     : [output_address] "r" (output_address),
 			       THUNK_TARGET(hv_hypercall_pg)
+			       COMMA(ASM_CALL_CONSTRAINT)
 			     : "cc", "memory", "r8", "r9", "r10", "r11");
 #else
 	u32 input_address_hi = upper_32_bits(input_address);
@@ -106,12 +108,11 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 		return U64_MAX;
 
 	__asm__ __volatile__(CALL_NOSPEC
-			     : "=A" (hv_status),
-			       "+c" (input_address_lo), ASM_CALL_CONSTRAINT
-			     : "A" (control),
-			       "b" (input_address_hi),
-			       "D"(output_address_hi), "S"(output_address_lo),
+			     : "=A" (hv_status), "+c" (input_address_lo)
+			     : "A" (control), "b" (input_address_hi),
+			       "D" (output_address_hi), "S"(output_address_lo),
 			       THUNK_TARGET(hv_hypercall_pg)
+			       COMMA(ASM_CALL_CONSTRAINT)
 			     : "cc", "memory");
 #endif /* !x86_64 */
 	return hv_status;
@@ -135,14 +136,16 @@ static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
 	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
 		__asm__ __volatile__(
 				"vmmcall"
-				: "=a" (hv_status), ASM_CALL_CONSTRAINT,
-				"+c" (control), "+d" (input1)
-				:: "cc", "r8", "r9", "r10", "r11");
+				: "=a" (hv_status), "+c" (control),
+				  "+d" (input1)
+				: ASM_CALL_CONSTRAINT
+				: "cc", "r8", "r9", "r10", "r11");
 	} else {
 		__asm__ __volatile__(CALL_NOSPEC
-				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
-				       "+c" (control), "+d" (input1)
+				     : "=a" (hv_status), "+c" (control),
+				       "+d" (input1)
 				     : THUNK_TARGET(hv_hypercall_pg)
+				       COMMA(ASM_CALL_CONSTRAINT)
 				     : "cc", "r8", "r9", "r10", "r11");
 	}
 #else
@@ -151,12 +154,10 @@ static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
 		u32 input1_lo = lower_32_bits(input1);
 
 		__asm__ __volatile__ (CALL_NOSPEC
-				      : "=A"(hv_status),
-					"+c"(input1_lo),
-					ASM_CALL_CONSTRAINT
-				      :	"A" (control),
-					"b" (input1_hi),
+				      : "=A"(hv_status), "+c"(input1_lo)
+				      :	"A" (control), "b" (input1_hi),
 					THUNK_TARGET(hv_hypercall_pg)
+					COMMA(ASM_CALL_CONSTRAINT)
 				      : "cc", "edi", "esi");
 	}
 #endif
@@ -189,17 +190,19 @@ static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input2)
 	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
 		__asm__ __volatile__("mov %[input2], %%r8\n"
 				     "vmmcall"
-				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
-				       "+c" (control), "+d" (input1)
+				     : "=a" (hv_status), "+c" (control),
+				       "+d" (input1)
 				     : [input2] "r" (input2)
+				       COMMA(ASM_CALL_CONSTRAINT)
 				     : "cc", "r8", "r9", "r10", "r11");
 	} else {
 		__asm__ __volatile__("mov %[input2], %%r8\n"
 				     CALL_NOSPEC
-				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
-				       "+c" (control), "+d" (input1)
+				     : "=a" (hv_status), "+c" (control),
+				       "+d" (input1)
 				     : [input2] "r" (input2),
 				       THUNK_TARGET(hv_hypercall_pg)
+				       COMMA(ASM_CALL_CONSTRAINT)
 				     : "cc", "r8", "r9", "r10", "r11");
 	}
 #else
@@ -210,11 +213,11 @@ static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input2)
 		u32 input2_lo = lower_32_bits(input2);
 
 		__asm__ __volatile__ (CALL_NOSPEC
-				      : "=A"(hv_status),
-					"+c"(input1_lo), ASM_CALL_CONSTRAINT
+				      : "=A"(hv_status), "+c" (input1_lo)
 				      :	"A" (control), "b" (input1_hi),
-					"D"(input2_hi), "S"(input2_lo),
+					"D" (input2_hi), "S" (input2_lo),
 					THUNK_TARGET(hv_hypercall_pg)
+					COMMA(ASM_CALL_CONSTRAINT)
 				      : "cc");
 	}
 #endif
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index e26633c00455..68bdce684769 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -392,9 +392,10 @@ int paravirt_disable_iospace(void);
 		PVOP_TEST_NULL(op);					\
 		asm volatile(ALTERNATIVE(PARAVIRT_CALL, ALT_CALL_INSTR,	\
 				ALT_CALL_ALWAYS)			\
-			     : call_clbr, ASM_CALL_CONSTRAINT		\
+			     : call_clbr				\
 			     : paravirt_ptr(op),			\
 			       ##__VA_ARGS__				\
+			       COMMA(ASM_CALL_CONSTRAINT)		\
 			     : "memory", "cc" extra_clbr);		\
 		ret;							\
 	})
@@ -407,9 +408,10 @@ int paravirt_disable_iospace(void);
 		asm volatile(ALTERNATIVE_2(PARAVIRT_CALL,		\
 				 ALT_CALL_INSTR, ALT_CALL_ALWAYS,	\
 				 alt, cond)				\
-			     : call_clbr, ASM_CALL_CONSTRAINT		\
+			     : call_clbr				\
 			     : paravirt_ptr(op),			\
 			       ##__VA_ARGS__				\
+			       COMMA(ASM_CALL_CONSTRAINT)		\
 			     : "memory", "cc" extra_clbr);		\
 		ret;							\
 	})
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 8a8cf86dded3..60390a019ca9 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -323,10 +323,10 @@ do {									\
 	asm_inline qual (						\
 		ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
 			    "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
-		: ALT_OUTPUT_SP([var] "+m" (__my_cpu_var(_var)),	\
-				"+a" (old__.low), "+d" (old__.high))	\
-		: "b" (new__.low), "c" (new__.high),			\
-		  "S" (&(_var))						\
+		: [var] "+m" (__my_cpu_var(_var)), "+a" (old__.low),	\
+		   "+d" (old__.high)					\
+		: "b" (new__.low), "c" (new__.high), "S" (&(_var))	\
+		  COMMA(ASM_CALL_CONSTRAINT)				\
 		: "memory");						\
 									\
 	old__.var;							\
@@ -353,11 +353,10 @@ do {									\
 		ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
 			    "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
 		CC_SET(z)						\
-		: ALT_OUTPUT_SP(CC_OUT(z) (success),			\
-				[var] "+m" (__my_cpu_var(_var)),	\
-				"+a" (old__.low), "+d" (old__.high))	\
-		: "b" (new__.low), "c" (new__.high),			\
-		  "S" (&(_var))						\
+		: CC_OUT(z) (success), [var] "+m" (__my_cpu_var(_var)),	\
+		  "+a" (old__.low), "+d" (old__.high)			\
+		: "b" (new__.low), "c" (new__.high), "S" (&(_var))	\
+		  COMMA(ASM_CALL_CONSTRAINT)				\
 		: "memory");						\
 	if (unlikely(!success))						\
 		*_oval = old__.var;					\
@@ -392,10 +391,10 @@ do {									\
 	asm_inline qual (						\
 		ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
 			    "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
-		: ALT_OUTPUT_SP([var] "+m" (__my_cpu_var(_var)),	\
-				"+a" (old__.low), "+d" (old__.high))	\
-		: "b" (new__.low), "c" (new__.high),			\
-		  "S" (&(_var))						\
+		: [var] "+m" (__my_cpu_var(_var)), "+a" (old__.low),	\
+		   "+d" (old__.high)					\
+		: "b" (new__.low), "c" (new__.high), "S" (&(_var))	\
+		  COMMA(ASM_CALL_CONSTRAINT)				\
 		: "memory");						\
 									\
 	old__.var;							\
@@ -422,11 +421,10 @@ do {									\
 		ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
 			    "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
 		CC_SET(z)						\
-		: ALT_OUTPUT_SP(CC_OUT(z) (success),			\
-				[var] "+m" (__my_cpu_var(_var)),	\
-				"+a" (old__.low), "+d" (old__.high))	\
-		: "b" (new__.low), "c" (new__.high),			\
-		  "S" (&(_var))						\
+		: CC_OUT(z) (success), [var] "+m" (__my_cpu_var(_var)),	\
+		  "+a" (old__.low), "+d" (old__.high)			\
+		: "b" (new__.low), "c" (new__.high), "S" (&(_var))	\
+		  COMMA(ASM_CALL_CONSTRAINT)				\
 		: "memory");						\
 	if (unlikely(!success))						\
 		*_oval = old__.var;					\
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 919909d8cb77..7e834820e030 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -121,27 +121,29 @@ extern asmlinkage void preempt_schedule_notrace_thunk(void);
 
 DECLARE_STATIC_CALL(preempt_schedule, preempt_schedule_dynamic_enabled);
 
-#define __preempt_schedule() \
-do { \
-	__STATIC_CALL_MOD_ADDRESSABLE(preempt_schedule); \
-	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule) : ASM_CALL_CONSTRAINT); \
+#define __preempt_schedule()						\
+do {									\
+	__STATIC_CALL_MOD_ADDRESSABLE(preempt_schedule);		\
+	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule)	\
+		      : : ASM_CALL_CONSTRAINT);				\
 } while (0)
 
 DECLARE_STATIC_CALL(preempt_schedule_notrace, preempt_schedule_notrace_dynamic_enabled);
 
-#define __preempt_schedule_notrace() \
-do { \
-	__STATIC_CALL_MOD_ADDRESSABLE(preempt_schedule_notrace); \
-	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule_notrace) : ASM_CALL_CONSTRAINT); \
+#define __preempt_schedule_notrace()					\
+do {									\
+	__STATIC_CALL_MOD_ADDRESSABLE(preempt_schedule_notrace);	\
+	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule_notrace) \
+		      : : ASM_CALL_CONSTRAINT);				\
 } while (0)
 
 #else /* PREEMPT_DYNAMIC */
 
 #define __preempt_schedule() \
-	asm volatile ("call preempt_schedule_thunk" : ASM_CALL_CONSTRAINT);
+	asm volatile ("call preempt_schedule_thunk" : : ASM_CALL_CONSTRAINT);
 
 #define __preempt_schedule_notrace() \
-	asm volatile ("call preempt_schedule_notrace_thunk" : ASM_CALL_CONSTRAINT);
+	asm volatile ("call preempt_schedule_notrace_thunk" : : ASM_CALL_CONSTRAINT);
 
 #endif /* PREEMPT_DYNAMIC */
 
diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
index 96bda43538ee..c88e354b9ceb 100644
--- a/arch/x86/include/asm/sync_core.h
+++ b/arch/x86/include/asm/sync_core.h
@@ -16,7 +16,7 @@ static __always_inline void iret_to_self(void)
 		"pushl $1f\n\t"
 		"iret\n\t"
 		"1:"
-		: ASM_CALL_CONSTRAINT : : "memory");
+		: : ASM_CALL_CONSTRAINT : "memory");
 }
 #else
 static __always_inline void iret_to_self(void)
@@ -34,7 +34,9 @@ static __always_inline void iret_to_self(void)
 		"pushq $1f\n\t"
 		"iretq\n\t"
 		"1:"
-		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
+		: "=&r" (tmp)
+		: ASM_CALL_CONSTRAINT
+		: "cc", "memory");
 }
 #endif /* CONFIG_X86_32 */
 
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a7755c1a441..4a5f0c19864e 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -79,9 +79,9 @@ extern int __get_user_bad(void);
 	register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);		\
 	__chk_user_ptr(ptr);						\
 	asm volatile("call __" #fn "_%c[size]"				\
-		     : "=a" (__ret_gu), "=r" (__val_gu),		\
-			ASM_CALL_CONSTRAINT				\
-		     : "0" (ptr), [size] "i" (sizeof(*(ptr))));		\
+		     : "=a" (__ret_gu), "=r" (__val_gu)			\
+		     : "0" (ptr), [size] "i" (sizeof(*(ptr)))		\
+		       COMMA(ASM_CALL_CONSTRAINT));			\
 	instrument_get_user(__val_gu);					\
 	(x) = (__force __typeof__(*(ptr))) __val_gu;			\
 	__builtin_expect(__ret_gu, 0);					\
@@ -178,12 +178,12 @@ extern void __put_user_nocheck_8(void);
 	__ptr_pu = __ptr;						\
 	__val_pu = __x;							\
 	asm volatile("call __" #fn "_%c[size]"				\
-		     : "=c" (__ret_pu),					\
-			ASM_CALL_CONSTRAINT				\
+		     : "=c" (__ret_pu)					\
 		     : "0" (__ptr_pu),					\
 		       "r" (__val_pu),					\
 		       [size] "i" (sizeof(*(ptr)))			\
-		     :"ebx");						\
+		       COMMA(ASM_CALL_CONSTRAINT)			\
+		     : "ebx");						\
 	instrument_put_user(__x, __ptr, sizeof(*(ptr)));		\
 	__builtin_expect(__ret_pu, 0);					\
 })
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index c52f0133425b..87a1b9e9cf22 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -129,8 +129,9 @@ copy_user_generic(void *to, const void *from, unsigned long len)
 			    "call rep_movs_alternative", ALT_NOT(X86_FEATURE_FSRM))
 		"2:\n"
 		_ASM_EXTABLE_UA(1b, 2b)
-		:"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
-		: : "memory", "rax");
+		: "+c" (len), "+D" (to), "+S" (from)
+		: ASM_CALL_CONSTRAINT
+		: "memory", "rax");
 	clac();
 	return len;
 }
@@ -191,8 +192,9 @@ static __always_inline __must_check unsigned long __clear_user(void __user *addr
 			    "call rep_stos_alternative", ALT_NOT(X86_FEATURE_FSRS))
 		"2:\n"
 	       _ASM_EXTABLE_UA(1b, 2b)
-	       : "+c" (size), "+D" (addr), ASM_CALL_CONSTRAINT
-	       : "a" (0));
+	       : "+c" (size), "+D" (addr)
+	       : "a" (0)
+	         COMMA(ASM_CALL_CONSTRAINT));
 
 	clac();
 
diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index 97771b9d33af..683772a58939 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -101,7 +101,7 @@ DECLARE_STATIC_CALL(xen_hypercall, xen_hypercall_func);
 	__ADDRESSABLE_xen_hypercall			\
 	"call __SCT__xen_hypercall"
 
-#define __HYPERCALL_ENTRY(x)	"a" (x)
+#define __HYPERCALL_ENTRY(x)	"a" (x) COMMA(ASM_CALL_CONSTRAINT)
 
 #ifdef CONFIG_X86_32
 #define __HYPERCALL_RETREG	"eax"
@@ -127,7 +127,7 @@ DECLARE_STATIC_CALL(xen_hypercall, xen_hypercall_func);
 	register unsigned long __arg4 asm(__HYPERCALL_ARG4REG) = __arg4; \
 	register unsigned long __arg5 asm(__HYPERCALL_ARG5REG) = __arg5;
 
-#define __HYPERCALL_0PARAM	"=r" (__res), ASM_CALL_CONSTRAINT
+#define __HYPERCALL_0PARAM	"=r" (__res)
 #define __HYPERCALL_1PARAM	__HYPERCALL_0PARAM, "+r" (__arg1)
 #define __HYPERCALL_2PARAM	__HYPERCALL_1PARAM, "+r" (__arg2)
 #define __HYPERCALL_3PARAM	__HYPERCALL_2PARAM, "+r" (__arg3)
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8b66a555d2f0..6a7eb063a5d5 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1624,8 +1624,8 @@ static noinline void __init int3_selftest(void)
 	asm volatile ("int3_selftest_ip:\n\t"
 		      ANNOTATE_NOENDBR
 		      "    int3; nop; nop; nop; nop\n\t"
-		      : ASM_CALL_CONSTRAINT
-		      : __ASM_SEL_RAW(a, D) (&val)
+		      : : __ASM_SEL_RAW(a, D) (&val)
+			  COMMA(ASM_CALL_CONSTRAINT)
 		      : "memory");
 
 	BUG_ON(val != 1);
@@ -1657,8 +1657,8 @@ static noinline void __init alt_reloc_selftest(void)
 	 */
 	asm_inline volatile (
 		ALTERNATIVE("", "lea %[mem], %%" _ASM_ARG1 "; call __alt_reloc_selftest;", X86_FEATURE_ALWAYS)
-		: ASM_CALL_CONSTRAINT
-		: [mem] "m" (__alt_reloc_selftest_addr)
+		: : [mem] "m" (__alt_reloc_selftest_addr)
+		    COMMA(ASM_CALL_CONSTRAINT)
 		: _ASM_ARG1
 	);
 }
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 60986f67c35a..40e12a177197 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -1070,7 +1070,9 @@ static __always_inline u8 test_cc(unsigned int condition, unsigned long flags)
 
 	flags = (flags & EFLAGS_MASK) | X86_EFLAGS_IF;
 	asm("push %[flags]; popf; " CALL_NOSPEC
-	    : "=a"(rc), ASM_CALL_CONSTRAINT : [thunk_target]"r"(fop), [flags]"r"(flags));
+	    : "=a" (rc)
+	    : [thunk_target] "r" (fop), [flags] "r" (flags)
+	      COMMA(ASM_CALL_CONSTRAINT));
 	return rc;
 }
 
@@ -5079,9 +5081,10 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop)
 		fop += __ffs(ctxt->dst.bytes) * FASTOP_SIZE;
 
 	asm("push %[flags]; popf; " CALL_NOSPEC " ; pushf; pop %[flags]\n"
-	    : "+a"(ctxt->dst.val), "+d"(ctxt->src.val), [flags]"+D"(flags),
-	      [thunk_target]"+S"(fop), ASM_CALL_CONSTRAINT
-	    : "c"(ctxt->src2.val));
+	    : "+a" (ctxt->dst.val), "+d" (ctxt->src.val), [flags] "+D" (flags),
+	      [thunk_target] "+S" (fop)
+	    : "c" (ctxt->src2.val)
+	      COMMA(ASM_CALL_CONSTRAINT));
 
 	ctxt->eflags = (ctxt->eflags & ~EFLAGS_MASK) | (flags & EFLAGS_MASK);
 	if (!fop) /* exception is returned in fop variable */
diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index 96677576c836..a614addd589f 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -144,8 +144,9 @@ static __always_inline unsigned long __vmcs_readl(unsigned long field)
 		     /* VMREAD faulted.  As above, except push '1' for @fault. */
 		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_ONE_REG, %[output])
 
-		     : ASM_CALL_CONSTRAINT, [output] "=&r" (value)
+		     : [output] "=&r" (value)
 		     : [field] "r" (field)
+		       COMMA(ASM_CALL_CONSTRAINT)
 		     : "cc");
 	return value;
 

