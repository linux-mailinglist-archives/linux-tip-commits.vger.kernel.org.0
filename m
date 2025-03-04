Return-Path: <linux-tip-commits+bounces-3914-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A855A4DAD1
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ECCC163761
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59F51FF7DF;
	Tue,  4 Mar 2025 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LkDWtbtb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pa3qAz43"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942011FECBA;
	Tue,  4 Mar 2025 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084589; cv=none; b=IrbXRubeToKQ13GYpLGQtXKI0AeFYgW8ZxCvhJgLnlM/apVuqkGkGwktwJTx/mpW3PMCL2632rgmJ47zw4H6SnUleXROwNmEhmDYBzr2iMhVYyn1GfrFTa888/JyS8mwiIu2mEoMDc7BOnta6uK0hA1vrnj772RwcKg0g8Urh7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084589; c=relaxed/simple;
	bh=2CTHJI1uJU1tDymYrh9ux1h3HUagJINphZhjgiy0vMI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=svuhDW7REl+wdcvDOa2OKwOkdz0CoVaYQxLJ3n1pXIkhVlp2yqs7B3rS1tRsYZyfWlUQpK252+f+msSy/gTjcvWL6674TwYdO07UKSMzQTkMORX7xXJfE6R4pcTDU4NwYxiqQ/Y/3XgD0P4E7Bu0PcIKkkMJNHzbmTdX22Bzuhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LkDWtbtb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pa3qAz43; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:36:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741084586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=VugCRSvmKLJGe7poNcevut7GA6aEpYxwxljWHwP/vus=;
	b=LkDWtbtbcGq5CE78yyJCTE0YGxwzpPDqib1VQYF1lgR6+OSgkwkgXnrKX9ZnNmMuG68TmW
	7aYV7OsIt45lFVaKRu4/RPS6jaOe49xtXu0z+ouAAUZmsUVwwzV6X885GFTQoHC0Fpicw8
	T7CM/LhyQ5An23W2DlwNmDv8rAKwaf7IohhQf0DeINC9MZys4jyB07wZE6A8V9eWYy5HTP
	WW51mP63GQe2q0MCoGvFYNM9/p/m4M+oMi1Fx9DaKROujh4LJrGUBAC/LhHKFGpn5ANyx4
	bVOjb9HjnhMOpZltULGlGPgC9aZVBI8kCj5QXu213QWp4hE9p+i8KcR75Zjd0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741084586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=VugCRSvmKLJGe7poNcevut7GA6aEpYxwxljWHwP/vus=;
	b=pa3qAz43KgQtsftncs19omfax/6rYfdmS6dIL3CW5YG7CFE7mbpX2ADfHJJPjDnK6SNfOX
	zum0IOgsW0pPaTAw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/asm] x86/alternatives: Simplify alternative_call() interface
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108458547.14745.4744686340294784361.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     224788b63a2e426b6b82c76456a068a2ab87610f
Gitweb:        https://git.kernel.org/tip/224788b63a2e426b6b82c76456a068a2ab87610f
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Sun, 02 Mar 2025 17:21:01 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:21:40 +01:00

x86/alternatives: Simplify alternative_call() interface

Separate the input from the clobbers in preparation for appending the
input.

Do this in preparation of changing the ASM_CALL_CONSTRAINT primitive.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/alternative.h | 24 ++-----
 arch/x86/include/asm/apic.h        |  4 +-
 arch/x86/include/asm/asm.h         | 11 +++-
 arch/x86/include/asm/atomic64_32.h | 96 +++++++++++++++++------------
 arch/x86/include/asm/page_64.h     |  4 +-
 5 files changed, 82 insertions(+), 57 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index a214166..52626a7 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -237,10 +237,12 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * references: i.e., if used for a function, it would add the PLT
  * suffix.
  */
-#define alternative_call(oldfunc, newfunc, ft_flags, output, input...)			\
+#define alternative_call(oldfunc, newfunc, ft_flags, output, input, clobbers...)	\
 	asm_inline volatile(ALTERNATIVE("call %c[old]", "call %c[new]", ft_flags)	\
 		: ALT_OUTPUT_SP(output)							\
-		: [old] "i" (oldfunc), [new] "i" (newfunc), ## input)
+		: [old] "i" (oldfunc), [new] "i" (newfunc)				\
+		  COMMA(input)								\
+		: clobbers)
 
 /*
  * Like alternative_call, but there are two features and respective functions.
@@ -249,24 +251,14 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * Otherwise, old function is used.
  */
 #define alternative_call_2(oldfunc, newfunc1, ft_flags1, newfunc2, ft_flags2,		\
-			   output, input...)						\
+			   output, input, clobbers...)					\
 	asm_inline volatile(ALTERNATIVE_2("call %c[old]", "call %c[new1]", ft_flags1,	\
 		"call %c[new2]", ft_flags2)						\
 		: ALT_OUTPUT_SP(output)							\
 		: [old] "i" (oldfunc), [new1] "i" (newfunc1),				\
-		  [new2] "i" (newfunc2), ## input)
-
-/*
- * use this macro(s) if you need more than one output parameter
- * in alternative_io
- */
-#define ASM_OUTPUT2(a...) a
-
-/*
- * use this macro if you need clobbers but no inputs in
- * alternative_{input,io,call}()
- */
-#define ASM_NO_INPUT_CLOBBER(clbr...) "i" (0) : clbr
+		  [new2] "i" (newfunc2)							\
+		  COMMA(input)								\
+		: clobbers)
 
 #define ALT_OUTPUT_SP(...) ASM_CALL_CONSTRAINT, ## __VA_ARGS__
 
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index f21ff19..c903d35 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -99,8 +99,8 @@ static inline void native_apic_mem_write(u32 reg, u32 v)
 	volatile u32 *addr = (volatile u32 *)(APIC_BASE + reg);
 
 	alternative_io("movl %0, %1", "xchgl %0, %1", X86_BUG_11AP,
-		       ASM_OUTPUT2("=r" (v), "=m" (*addr)),
-		       ASM_OUTPUT2("0" (v), "m" (*addr)));
+		       ASM_OUTPUT("=r" (v), "=m" (*addr)),
+		       ASM_INPUT("0" (v), "m" (*addr)));
 }
 
 static inline u32 native_apic_mem_read(u32 reg)
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 2bec0c8..975ae7a 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -213,6 +213,17 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
 
 /* For C file, we already have NOKPROBE_SYMBOL macro */
 
+/* Insert a comma if args are non-empty */
+#define COMMA(x...)		__COMMA(x)
+#define __COMMA(...)		, ##__VA_ARGS__
+
+/*
+ * Combine multiple asm inline constraint args into a single arg for passing to
+ * another macro.
+ */
+#define ASM_OUTPUT(x...)	x
+#define ASM_INPUT(x...)		x
+
 /*
  * This output constraint should be used for any inline asm which has a "call"
  * instruction.  Otherwise the asm may be inserted before the frame pointer
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 797085e..ab83820 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -49,16 +49,19 @@ static __always_inline s64 arch_atomic64_read_nonatomic(const atomic64_t *v)
 #endif
 
 #ifdef CONFIG_X86_CX8
-#define __alternative_atomic64(f, g, out, in...) \
-	asm volatile("call %c[func]" \
+#define __alternative_atomic64(f, g, out, in, clobbers...)		\
+	asm volatile("call %c[func]"					\
 		     : ALT_OUTPUT_SP(out) \
-		     : [func] "i" (atomic64_##g##_cx8), ## in)
+		     : [func] "i" (atomic64_##g##_cx8)			\
+		       COMMA(in)					\
+		     : clobbers)
 
 #define ATOMIC64_DECL(sym) ATOMIC64_DECL_ONE(sym##_cx8)
 #else
-#define __alternative_atomic64(f, g, out, in...) \
-	alternative_call(atomic64_##f##_386, atomic64_##g##_cx8, \
-			 X86_FEATURE_CX8, ASM_OUTPUT2(out), ## in)
+#define __alternative_atomic64(f, g, out, in, clobbers...)		\
+	alternative_call(atomic64_##f##_386, atomic64_##g##_cx8,	\
+			 X86_FEATURE_CX8, ASM_OUTPUT(out),		\
+			 ASM_INPUT(in), clobbers)
 
 #define ATOMIC64_DECL(sym) ATOMIC64_DECL_ONE(sym##_cx8); \
 	ATOMIC64_DECL_ONE(sym##_386)
@@ -69,8 +72,8 @@ ATOMIC64_DECL_ONE(inc_386);
 ATOMIC64_DECL_ONE(dec_386);
 #endif
 
-#define alternative_atomic64(f, out, in...) \
-	__alternative_atomic64(f, f, ASM_OUTPUT2(out), ## in)
+#define alternative_atomic64(f, out, in, clobbers...) \
+	__alternative_atomic64(f, f, ASM_OUTPUT(out), ASM_INPUT(in), clobbers)
 
 ATOMIC64_DECL(read);
 ATOMIC64_DECL(set);
@@ -105,9 +108,10 @@ static __always_inline s64 arch_atomic64_xchg(atomic64_t *v, s64 n)
 	s64 o;
 	unsigned high = (unsigned)(n >> 32);
 	unsigned low = (unsigned)n;
-	alternative_atomic64(xchg, "=&A" (o),
-			     "S" (v), "b" (low), "c" (high)
-			     : "memory");
+	alternative_atomic64(xchg,
+			     "=&A" (o),
+			     ASM_INPUT("S" (v), "b" (low), "c" (high)),
+			     "memory");
 	return o;
 }
 #define arch_atomic64_xchg arch_atomic64_xchg
@@ -116,23 +120,25 @@ static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
 {
 	unsigned high = (unsigned)(i >> 32);
 	unsigned low = (unsigned)i;
-	alternative_atomic64(set, /* no output */,
-			     "S" (v), "b" (low), "c" (high)
-			     : "eax", "edx", "memory");
+	alternative_atomic64(set,
+			     /* no output */,
+			     ASM_INPUT("S" (v), "b" (low), "c" (high)),
+			     "eax", "edx", "memory");
 }
 
 static __always_inline s64 arch_atomic64_read(const atomic64_t *v)
 {
 	s64 r;
-	alternative_atomic64(read, "=&A" (r), "c" (v) : "memory");
+	alternative_atomic64(read, "=&A" (r), "c" (v), "memory");
 	return r;
 }
 
 static __always_inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 {
 	alternative_atomic64(add_return,
-			     ASM_OUTPUT2("+A" (i), "+c" (v)),
-			     ASM_NO_INPUT_CLOBBER("memory"));
+			     ASM_OUTPUT("+A" (i), "+c" (v)),
+			     /* no input */,
+			     "memory");
 	return i;
 }
 #define arch_atomic64_add_return arch_atomic64_add_return
@@ -140,8 +146,9 @@ static __always_inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 static __always_inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
 {
 	alternative_atomic64(sub_return,
-			     ASM_OUTPUT2("+A" (i), "+c" (v)),
-			     ASM_NO_INPUT_CLOBBER("memory"));
+			     ASM_OUTPUT("+A" (i), "+c" (v)),
+			     /* no input */,
+			     "memory");
 	return i;
 }
 #define arch_atomic64_sub_return arch_atomic64_sub_return
@@ -149,8 +156,10 @@ static __always_inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
 static __always_inline s64 arch_atomic64_inc_return(atomic64_t *v)
 {
 	s64 a;
-	alternative_atomic64(inc_return, "=&A" (a),
-			     "S" (v) : "memory", "ecx");
+	alternative_atomic64(inc_return,
+			     "=&A" (a),
+			     "S" (v),
+			     "memory", "ecx");
 	return a;
 }
 #define arch_atomic64_inc_return arch_atomic64_inc_return
@@ -158,8 +167,10 @@ static __always_inline s64 arch_atomic64_inc_return(atomic64_t *v)
 static __always_inline s64 arch_atomic64_dec_return(atomic64_t *v)
 {
 	s64 a;
-	alternative_atomic64(dec_return, "=&A" (a),
-			     "S" (v) : "memory", "ecx");
+	alternative_atomic64(dec_return,
+			     "=&A" (a),
+			     "S" (v),
+			     "memory", "ecx");
 	return a;
 }
 #define arch_atomic64_dec_return arch_atomic64_dec_return
@@ -167,28 +178,34 @@ static __always_inline s64 arch_atomic64_dec_return(atomic64_t *v)
 static __always_inline void arch_atomic64_add(s64 i, atomic64_t *v)
 {
 	__alternative_atomic64(add, add_return,
-			       ASM_OUTPUT2("+A" (i), "+c" (v)),
-			       ASM_NO_INPUT_CLOBBER("memory"));
+			       ASM_OUTPUT("+A" (i), "+c" (v)),
+			       /* no input */,
+			       "memory");
 }
 
 static __always_inline void arch_atomic64_sub(s64 i, atomic64_t *v)
 {
 	__alternative_atomic64(sub, sub_return,
-			       ASM_OUTPUT2("+A" (i), "+c" (v)),
-			       ASM_NO_INPUT_CLOBBER("memory"));
+			       ASM_OUTPUT("+A" (i), "+c" (v)),
+			       /* no input */,
+			       "memory");
 }
 
 static __always_inline void arch_atomic64_inc(atomic64_t *v)
 {
-	__alternative_atomic64(inc, inc_return, /* no output */,
-			       "S" (v) : "memory", "eax", "ecx", "edx");
+	__alternative_atomic64(inc, inc_return,
+			       /* no output */,
+			       "S" (v),
+			       "memory", "eax", "ecx", "edx");
 }
 #define arch_atomic64_inc arch_atomic64_inc
 
 static __always_inline void arch_atomic64_dec(atomic64_t *v)
 {
-	__alternative_atomic64(dec, dec_return, /* no output */,
-			       "S" (v) : "memory", "eax", "ecx", "edx");
+	__alternative_atomic64(dec, dec_return,
+			       /* no output */,
+			       "S" (v),
+			       "memory", "eax", "ecx", "edx");
 }
 #define arch_atomic64_dec arch_atomic64_dec
 
@@ -197,8 +214,9 @@ static __always_inline int arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 	unsigned low = (unsigned)u;
 	unsigned high = (unsigned)(u >> 32);
 	alternative_atomic64(add_unless,
-			     ASM_OUTPUT2("+A" (a), "+c" (low), "+D" (high)),
-			     "S" (v) : "memory");
+			     ASM_OUTPUT("+A" (a), "+c" (low), "+D" (high)),
+			     "S" (v),
+			     "memory");
 	return (int)a;
 }
 #define arch_atomic64_add_unless arch_atomic64_add_unless
@@ -206,8 +224,10 @@ static __always_inline int arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 static __always_inline int arch_atomic64_inc_not_zero(atomic64_t *v)
 {
 	int r;
-	alternative_atomic64(inc_not_zero, "=&a" (r),
-			     "S" (v) : "ecx", "edx", "memory");
+	alternative_atomic64(inc_not_zero,
+			     "=&a" (r),
+			     "S" (v),
+			     "ecx", "edx", "memory");
 	return r;
 }
 #define arch_atomic64_inc_not_zero arch_atomic64_inc_not_zero
@@ -215,8 +235,10 @@ static __always_inline int arch_atomic64_inc_not_zero(atomic64_t *v)
 static __always_inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 {
 	s64 r;
-	alternative_atomic64(dec_if_positive, "=&A" (r),
-			     "S" (v) : "ecx", "memory");
+	alternative_atomic64(dec_if_positive,
+			     "=&A" (r),
+			     "S" (v),
+			     "ecx", "memory");
 	return r;
 }
 #define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index d635766..d081e80 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -55,8 +55,8 @@ static inline void clear_page(void *page)
 			   clear_page_rep, X86_FEATURE_REP_GOOD,
 			   clear_page_erms, X86_FEATURE_ERMS,
 			   "=D" (page),
-			   "D" (page)
-			   : "cc", "memory", "rax", "rcx");
+			   "D" (page),
+			   "cc", "memory", "rax", "rcx");
 }
 
 void copy_page(void *to, void *from);

