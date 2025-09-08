Return-Path: <linux-tip-commits+bounces-6503-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E029AB49019
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Sep 2025 15:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973A23A744B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Sep 2025 13:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85CD22FE0D;
	Mon,  8 Sep 2025 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BHuMcVRY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sqj3Diaj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D9930C350;
	Mon,  8 Sep 2025 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339285; cv=none; b=LBG4JPLE/tEzQOhLyNoA5bvqIUEAiVf28Gsixwcw4tuwrik/5/HY/st3DdZ3go9yKpOVsHRSsaf8lOFhxeDiosCocMMoep4a/fjai4Orjnc+sHgzQmuJsQYDYO8Ia6PVTMH1Vab6wao/pJY3PDZCMGGXIOmAqFJ+Y5J9G3WGuT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339285; c=relaxed/simple;
	bh=4ZeYRdU3Rr0/II1J/K/u+5QpYdIFWKN6za7MqXr3uLk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GsAQAjfT/JhwLxNbFReybg8H2E53mavOutbgtTizaB/cMa4lbQPMckmFdvScWesU7Y5x9m9nEeP2MlTj5cyPy57lgwlc98fuTFwGvTlYzAWeCU3KJLQFzMH0mnGn4tE06UwL3FcfWnRxU0h6DwHkm84YIVDawS2qpWM/2cLYyTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BHuMcVRY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sqj3Diaj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Sep 2025 13:47:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757339281;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHEC/eZiLyS+fQ2H0QBKu29PCfAJ7F2wguiYgfqHJNo=;
	b=BHuMcVRYVGhIcl77XyU1v2GDIc5KRZhM7PMvET3o8ZN5jo2OkrKf76SNc9NdU2WN93upbH
	RnpKjTaWY55EgMvX3VorPAPLdZW9alanhyYV8uW3gv7WoA/y1/qpjjH6xk5XVxInNv8Gn4
	am7VO2yyy/GKxZX81vwIRCPMlVaJNBdVrDqqhpBcnAy3D9rHwMF9BbyPsJCz3fHR9k9xIh
	iRb43/+b17HJvgb/2lb0Nf4HTITGflwfNWCMpXbvFGK6TKeWQHtwk5Zw4vGxBcMkc8m7ei
	HFcsE9ClfCkr62/az5Cpdt/9VkFtQOgelIDaHwcNGhgI6cbXBgSNQoR7NJaNjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757339281;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHEC/eZiLyS+fQ2H0QBKu29PCfAJ7F2wguiYgfqHJNo=;
	b=Sqj3DiajvGnIiy7botKHxXhvpyJqhEbCbuUj6+bx7HFltUi468WE+dem1T36vvHZ47Uad4
	PN/4LLSWRUIAfiCg==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/asm: Remove code depending on
 __GCC_ASM_FLAG_OUTPUTS__
Cc: Uros Bizjak <ubizjak@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250905121723.GCaLrU04lP2A50PT-B@fat_crate.local>
References: <20250905121723.GCaLrU04lP2A50PT-B@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175733927941.1920.15581031197025955263.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     c6c973dbfa5e34b1572bcd1852adcad1b5d08fab
Gitweb:        https://git.kernel.org/tip/c6c973dbfa5e34b1572bcd1852adcad1b5d=
08fab
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Sun, 07 Sep 2025 20:33:38 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 08 Sep 2025 15:38:06 +02:00

x86/asm: Remove code depending on __GCC_ASM_FLAG_OUTPUTS__

The minimum supported GCC version is 8.1, which supports flag output operands
and always defines __GCC_ASM_FLAG_OUTPUTS__ macro.

Remove code depending on __GCC_ASM_FLAG_OUTPUTS__ and use the "=3D@ccCOND" fl=
ag
output operand directly.

Use the equivalent "=3D@ccz" instead of "=3D@cce" flag output operand for
CMPXCHG8B and CMPXCHG16B instructions. These instructions set a single flag
bit - the Zero flag - and "=3D@ccz" is used to distinguish the CC user from
comparison instructions, where set ZERO flag indeed means that the values are
equal.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250905121723.GCaLrU04lP2A50PT-B@fat_crate.l=
ocal
---
 arch/x86/boot/bitops.h               |  2 +-
 arch/x86/boot/boot.h                 |  8 ++++----
 arch/x86/boot/string.c               |  4 ++--
 arch/x86/include/asm/archrandom.h    |  6 ++----
 arch/x86/include/asm/asm.h           | 12 ------------
 arch/x86/include/asm/bitops.h        | 18 ++++++------------
 arch/x86/include/asm/cmpxchg.h       | 12 ++++--------
 arch/x86/include/asm/cmpxchg_32.h    |  6 ++----
 arch/x86/include/asm/cmpxchg_64.h    |  3 +--
 arch/x86/include/asm/percpu.h        | 12 ++++--------
 arch/x86/include/asm/rmwcc.h         | 26 ++------------------------
 arch/x86/include/asm/sev.h           |  3 +--
 arch/x86/include/asm/signal.h        |  3 +--
 arch/x86/include/asm/special_insns.h |  3 +--
 arch/x86/include/asm/uaccess.h       |  7 +++----
 tools/arch/x86/include/asm/asm.h     | 12 ------------
 tools/perf/bench/find-bit-bench.c    |  2 +-
 17 files changed, 35 insertions(+), 104 deletions(-)

diff --git a/arch/x86/boot/bitops.h b/arch/x86/boot/bitops.h
index 8518ae2..79e1597 100644
--- a/arch/x86/boot/bitops.h
+++ b/arch/x86/boot/bitops.h
@@ -27,7 +27,7 @@ static inline bool variable_test_bit(int nr, const void *ad=
dr)
 	bool v;
 	const u32 *p =3D addr;
=20
-	asm("btl %2,%1" CC_SET(c) : CC_OUT(c) (v) : "m" (*p), "Ir" (nr));
+	asm("btl %2,%1" : "=3D@ccc" (v) : "m" (*p), "Ir" (nr));
 	return v;
 }
=20
diff --git a/arch/x86/boot/boot.h b/arch/x86/boot/boot.h
index 6058083..a3c58eb 100644
--- a/arch/x86/boot/boot.h
+++ b/arch/x86/boot/boot.h
@@ -155,15 +155,15 @@ static inline void wrgs32(u32 v, addr_t addr)
 static inline bool memcmp_fs(const void *s1, addr_t s2, size_t len)
 {
 	bool diff;
-	asm volatile("fs repe cmpsb" CC_SET(nz)
-		     : CC_OUT(nz) (diff), "+D" (s1), "+S" (s2), "+c" (len));
+	asm volatile("fs repe cmpsb"
+		     : "=3D@ccnz" (diff), "+D" (s1), "+S" (s2), "+c" (len));
 	return diff;
 }
 static inline bool memcmp_gs(const void *s1, addr_t s2, size_t len)
 {
 	bool diff;
-	asm volatile("gs repe cmpsb" CC_SET(nz)
-		     : CC_OUT(nz) (diff), "+D" (s1), "+S" (s2), "+c" (len));
+	asm volatile("gs repe cmpsb"
+		     : "=3D@ccnz" (diff), "+D" (s1), "+S" (s2), "+c" (len));
 	return diff;
 }
=20
diff --git a/arch/x86/boot/string.c b/arch/x86/boot/string.c
index f35369b..b25c6a9 100644
--- a/arch/x86/boot/string.c
+++ b/arch/x86/boot/string.c
@@ -32,8 +32,8 @@
 int memcmp(const void *s1, const void *s2, size_t len)
 {
 	bool diff;
-	asm("repe cmpsb" CC_SET(nz)
-	    : CC_OUT(nz) (diff), "+D" (s1), "+S" (s2), "+c" (len));
+	asm("repe cmpsb"
+	    : "=3D@ccnz" (diff), "+D" (s1), "+S" (s2), "+c" (len));
 	return diff;
 }
=20
diff --git a/arch/x86/include/asm/archrandom.h b/arch/x86/include/asm/archran=
dom.h
index 02bae8e..4c30530 100644
--- a/arch/x86/include/asm/archrandom.h
+++ b/arch/x86/include/asm/archrandom.h
@@ -23,8 +23,7 @@ static inline bool __must_check rdrand_long(unsigned long *=
v)
 	unsigned int retry =3D RDRAND_RETRY_LOOPS;
 	do {
 		asm volatile("rdrand %[out]"
-			     CC_SET(c)
-			     : CC_OUT(c) (ok), [out] "=3Dr" (*v));
+			     : "=3D@ccc" (ok), [out] "=3Dr" (*v));
 		if (ok)
 			return true;
 	} while (--retry);
@@ -35,8 +34,7 @@ static inline bool __must_check rdseed_long(unsigned long *=
v)
 {
 	bool ok;
 	asm volatile("rdseed %[out]"
-		     CC_SET(c)
-		     : CC_OUT(c) (ok), [out] "=3Dr" (*v));
+		     : "=3D@ccc" (ok), [out] "=3Dr" (*v));
 	return ok;
 }
=20
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index f963848..d5c8d3a 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -122,18 +122,6 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
 }
 #endif
=20
-/*
- * Macros to generate condition code outputs from inline assembly,
- * The output operand must be type "bool".
- */
-#ifdef __GCC_ASM_FLAG_OUTPUTS__
-# define CC_SET(c) "\n\t/* output condition code " #c "*/\n"
-# define CC_OUT(c) "=3D@cc" #c
-#else
-# define CC_SET(c) "\n\tset" #c " %[_cc_" #c "]\n"
-# define CC_OUT(c) [_cc_ ## c] "=3Dqm"
-#endif
-
 #ifdef __KERNEL__
=20
 # include <asm/extable_fixup_types.h>
diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index eebbc88..33153dc 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -99,8 +99,7 @@ static __always_inline bool arch_xor_unlock_is_negative_byt=
e(unsigned long mask,
 {
 	bool negative;
 	asm_inline volatile(LOCK_PREFIX "xorb %2,%1"
-		CC_SET(s)
-		: CC_OUT(s) (negative), WBYTE_ADDR(addr)
+		: "=3D@ccs" (negative), WBYTE_ADDR(addr)
 		: "iq" ((char)mask) : "memory");
 	return negative;
 }
@@ -149,8 +148,7 @@ arch___test_and_set_bit(unsigned long nr, volatile unsign=
ed long *addr)
 	bool oldbit;
=20
 	asm(__ASM_SIZE(bts) " %2,%1"
-	    CC_SET(c)
-	    : CC_OUT(c) (oldbit)
+	    : "=3D@ccc" (oldbit)
 	    : ADDR, "Ir" (nr) : "memory");
 	return oldbit;
 }
@@ -175,8 +173,7 @@ arch___test_and_clear_bit(unsigned long nr, volatile unsi=
gned long *addr)
 	bool oldbit;
=20
 	asm volatile(__ASM_SIZE(btr) " %2,%1"
-		     CC_SET(c)
-		     : CC_OUT(c) (oldbit)
+		     : "=3D@ccc" (oldbit)
 		     : ADDR, "Ir" (nr) : "memory");
 	return oldbit;
 }
@@ -187,8 +184,7 @@ arch___test_and_change_bit(unsigned long nr, volatile uns=
igned long *addr)
 	bool oldbit;
=20
 	asm volatile(__ASM_SIZE(btc) " %2,%1"
-		     CC_SET(c)
-		     : CC_OUT(c) (oldbit)
+		     : "=3D@ccc" (oldbit)
 		     : ADDR, "Ir" (nr) : "memory");
=20
 	return oldbit;
@@ -211,8 +207,7 @@ static __always_inline bool constant_test_bit_acquire(lon=
g nr, const volatile un
 	bool oldbit;
=20
 	asm volatile("testb %2,%1"
-		     CC_SET(nz)
-		     : CC_OUT(nz) (oldbit)
+		     : "=3D@ccnz" (oldbit)
 		     : "m" (((unsigned char *)addr)[nr >> 3]),
 		       "i" (1 << (nr & 7))
 		     :"memory");
@@ -225,8 +220,7 @@ static __always_inline bool variable_test_bit(long nr, vo=
latile const unsigned l
 	bool oldbit;
=20
 	asm volatile(__ASM_SIZE(bt) " %2,%1"
-		     CC_SET(c)
-		     : CC_OUT(c) (oldbit)
+		     : "=3D@ccc" (oldbit)
 		     : "m" (*(unsigned long *)addr), "Ir" (nr) : "memory");
=20
 	return oldbit;
diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index b61f32c..a88b06f 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -166,8 +166,7 @@ extern void __add_wrong_size(void)
 	{								\
 		volatile u8 *__ptr =3D (volatile u8 *)(_ptr);		\
 		asm_inline volatile(lock "cmpxchgb %[new], %[ptr]"	\
-			     CC_SET(z)					\
-			     : CC_OUT(z) (success),			\
+			     : "=3D@ccz" (success),			\
 			       [ptr] "+m" (*__ptr),			\
 			       [old] "+a" (__old)			\
 			     : [new] "q" (__new)			\
@@ -178,8 +177,7 @@ extern void __add_wrong_size(void)
 	{								\
 		volatile u16 *__ptr =3D (volatile u16 *)(_ptr);		\
 		asm_inline volatile(lock "cmpxchgw %[new], %[ptr]"	\
-			     CC_SET(z)					\
-			     : CC_OUT(z) (success),			\
+			     : "=3D@ccz" (success),			\
 			       [ptr] "+m" (*__ptr),			\
 			       [old] "+a" (__old)			\
 			     : [new] "r" (__new)			\
@@ -190,8 +188,7 @@ extern void __add_wrong_size(void)
 	{								\
 		volatile u32 *__ptr =3D (volatile u32 *)(_ptr);		\
 		asm_inline volatile(lock "cmpxchgl %[new], %[ptr]"	\
-			     CC_SET(z)					\
-			     : CC_OUT(z) (success),			\
+			     : "=3D@ccz" (success),			\
 			       [ptr] "+m" (*__ptr),			\
 			       [old] "+a" (__old)			\
 			     : [new] "r" (__new)			\
@@ -202,8 +199,7 @@ extern void __add_wrong_size(void)
 	{								\
 		volatile u64 *__ptr =3D (volatile u64 *)(_ptr);		\
 		asm_inline volatile(lock "cmpxchgq %[new], %[ptr]"	\
-			     CC_SET(z)					\
-			     : CC_OUT(z) (success),			\
+			     : "=3D@ccz" (success),			\
 			       [ptr] "+m" (*__ptr),			\
 			       [old] "+a" (__old)			\
 			     : [new] "r" (__new)			\
diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg=
_32.h
index 371f790..1f80a62 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -46,8 +46,7 @@ static __always_inline u64 __cmpxchg64_local(volatile u64 *=
ptr, u64 old, u64 new
 	bool ret;							\
 									\
 	asm_inline volatile(_lock "cmpxchg8b %[ptr]"			\
-		     CC_SET(e)						\
-		     : CC_OUT(e) (ret),					\
+		     : "=3D@ccz" (ret),					\
 		       [ptr] "+m" (*(_ptr)),				\
 		       "+a" (o.low), "+d" (o.high)			\
 		     : "b" (n.low), "c" (n.high)			\
@@ -125,8 +124,7 @@ static __always_inline u64 arch_cmpxchg64_local(volatile =
u64 *ptr, u64 old, u64=20
 		ALTERNATIVE(_lock_loc					\
 			    "call cmpxchg8b_emu",			\
 			    _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
-		CC_SET(e)						\
-		: ALT_OUTPUT_SP(CC_OUT(e) (ret),			\
+		: ALT_OUTPUT_SP("=3D@ccz" (ret),				\
 				"+a" (o.low), "+d" (o.high))		\
 		: "b" (n.low), "c" (n.high),				\
 		  [ptr] "S" (_ptr)					\
diff --git a/arch/x86/include/asm/cmpxchg_64.h b/arch/x86/include/asm/cmpxchg=
_64.h
index 71d1e72..5afea05 100644
--- a/arch/x86/include/asm/cmpxchg_64.h
+++ b/arch/x86/include/asm/cmpxchg_64.h
@@ -66,8 +66,7 @@ static __always_inline u128 arch_cmpxchg128_local(volatile =
u128 *ptr, u128 old,=20
 	bool ret;							\
 									\
 	asm_inline volatile(_lock "cmpxchg16b %[ptr]"			\
-		     CC_SET(e)						\
-		     : CC_OUT(e) (ret),					\
+		     : "=3D@ccz" (ret),					\
 		       [ptr] "+m" (*(_ptr)),				\
 		       "+a" (o.low), "+d" (o.high)			\
 		     : "b" (n.low), "c" (n.high)			\
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index b0d03b6..332428c 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -309,8 +309,7 @@ do {									\
 									\
 	asm qual (__pcpu_op_##size("cmpxchg") "%[nval], "		\
 		  __percpu_arg([var])					\
-		  CC_SET(z)						\
-		  : CC_OUT(z) (success),				\
+		  : "=3D@ccz" (success),					\
 		    [oval] "+a" (pco_old__),				\
 		    [var] "+m" (__my_cpu_var(_var))			\
 		  : [nval] __pcpu_reg_##size(, pco_new__)		\
@@ -367,8 +366,7 @@ do {									\
 	asm_inline qual (						\
 		ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
 			    "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
-		CC_SET(z)						\
-		: ALT_OUTPUT_SP(CC_OUT(z) (success),			\
+		: ALT_OUTPUT_SP("=3D@ccz" (success),			\
 				[var] "+m" (__my_cpu_var(_var)),	\
 				"+a" (old__.low), "+d" (old__.high))	\
 		: "b" (new__.low), "c" (new__.high),			\
@@ -436,8 +434,7 @@ do {									\
 	asm_inline qual (						\
 		ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
 			    "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
-		CC_SET(z)						\
-		: ALT_OUTPUT_SP(CC_OUT(z) (success),			\
+		: ALT_OUTPUT_SP("=3D@ccz" (success),			\
 				[var] "+m" (__my_cpu_var(_var)),	\
 				"+a" (old__.low), "+d" (old__.high))	\
 		: "b" (new__.low), "c" (new__.high),			\
@@ -585,8 +582,7 @@ do {									\
 	bool oldbit;							\
 									\
 	asm volatile("btl %[nr], " __percpu_arg([var])			\
-		     CC_SET(c)						\
-		     : CC_OUT(c) (oldbit)				\
+		     : "=3D@ccc" (oldbit)					\
 		     : [var] "m" (__my_cpu_var(_var)),			\
 		       [nr] "rI" (_nr));				\
 	oldbit;								\
diff --git a/arch/x86/include/asm/rmwcc.h b/arch/x86/include/asm/rmwcc.h
index 3821ee3..54c8fc4 100644
--- a/arch/x86/include/asm/rmwcc.h
+++ b/arch/x86/include/asm/rmwcc.h
@@ -6,37 +6,15 @@
=20
 #define __CLOBBERS_MEM(clb...)	"memory", ## clb
=20
-#ifndef __GCC_ASM_FLAG_OUTPUTS__
-
-/* Use asm goto */
-
-#define __GEN_RMWcc(fullop, _var, cc, clobbers, ...)			\
-({									\
-	bool c =3D false;							\
-	asm goto (fullop "; j" #cc " %l[cc_label]"		\
-			: : [var] "m" (_var), ## __VA_ARGS__		\
-			: clobbers : cc_label);				\
-	if (0) {							\
-cc_label:	c =3D true;						\
-	}								\
-	c;								\
-})
-
-#else /* defined(__GCC_ASM_FLAG_OUTPUTS__) */
-
-/* Use flags output or a set instruction */
-
 #define __GEN_RMWcc(fullop, _var, cc, clobbers, ...)			\
 ({									\
 	bool c;								\
-	asm_inline volatile (fullop CC_SET(cc)				\
-			: [var] "+m" (_var), CC_OUT(cc) (c)		\
+	asm_inline volatile (fullop					\
+			: [var] "+m" (_var), "=3D@cc" #cc (c)		\
 			: __VA_ARGS__ : clobbers);			\
 	c;								\
 })
=20
-#endif /* defined(__GCC_ASM_FLAG_OUTPUTS__) */
-
 #define GEN_UNARY_RMWcc_4(op, var, cc, arg0)				\
 	__GEN_RMWcc(op " " arg0, var, cc, __CLOBBERS_MEM())
=20
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 0223696..7cb8e09 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -491,8 +491,7 @@ static inline int pvalidate(unsigned long vaddr, bool rmp=
_psize, bool validate)
=20
 	/* "pvalidate" mnemonic support in binutils 2.36 and newer */
 	asm volatile(".byte 0xF2, 0x0F, 0x01, 0xFF\n\t"
-		     CC_SET(c)
-		     : CC_OUT(c) (no_rmpupdate), "=3Da"(rc)
+		     : "=3D@ccc"(no_rmpupdate), "=3Da"(rc)
 		     : "a"(vaddr), "c"(rmp_psize), "d"(validate)
 		     : "memory", "cc");
=20
diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signal.h
index c72d461..5c03aaa 100644
--- a/arch/x86/include/asm/signal.h
+++ b/arch/x86/include/asm/signal.h
@@ -83,8 +83,7 @@ static inline int __const_sigismember(sigset_t *set, int _s=
ig)
 static inline int __gen_sigismember(sigset_t *set, int _sig)
 {
 	bool ret;
-	asm("btl %2,%1" CC_SET(c)
-	    : CC_OUT(c) (ret) : "m"(*set), "Ir"(_sig-1));
+	asm("btl %2,%1" : "=3D@ccc"(ret) : "m"(*set), "Ir"(_sig-1));
 	return ret;
 }
=20
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/spec=
ial_insns.h
index c999145..46aa2c9 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -284,8 +284,7 @@ static inline int enqcmds(void __iomem *dst, const void *=
src)
 	 * See movdir64b()'s comment on operand specification.
 	 */
 	asm volatile(".byte 0xf3, 0x0f, 0x38, 0xf8, 0x02, 0x66, 0x90"
-		     CC_SET(z)
-		     : CC_OUT(z) (zf), "+m" (*__dst)
+		     : "=3D@ccz" (zf), "+m" (*__dst)
 		     : "m" (*__src), "a" (__dst), "d" (__src));
=20
 	/* Submission failure is indicated via EFLAGS.ZF=3D1 */
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a7755c..91a3fb8 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -378,7 +378,7 @@ do {									\
 	asm_goto_output("\n"						\
 		     "1: " LOCK_PREFIX "cmpxchg"itype" %[new], %[ptr]\n"\
 		     _ASM_EXTABLE_UA(1b, %l[label])			\
-		     : CC_OUT(z) (success),				\
+		     : "=3D@ccz" (success),				\
 		       [ptr] "+m" (*_ptr),				\
 		       [old] "+a" (__old)				\
 		     : [new] ltype (__new)				\
@@ -397,7 +397,7 @@ do {									\
 	asm_goto_output("\n"						\
 		     "1: " LOCK_PREFIX "cmpxchg8b %[ptr]\n"		\
 		     _ASM_EXTABLE_UA(1b, %l[label])			\
-		     : CC_OUT(z) (success),				\
+		     : "=3D@ccz" (success),				\
 		       "+A" (__old),					\
 		       [ptr] "+m" (*_ptr)				\
 		     : "b" ((u32)__new),				\
@@ -417,11 +417,10 @@ do {									\
 	__typeof__(*(_ptr)) __new =3D (_new);				\
 	asm volatile("\n"						\
 		     "1: " LOCK_PREFIX "cmpxchg"itype" %[new], %[ptr]\n"\
-		     CC_SET(z)						\
 		     "2:\n"						\
 		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
 					   %[errout])			\
-		     : CC_OUT(z) (success),				\
+		     : "=3D@ccz" (success),				\
 		       [errout] "+r" (__err),				\
 		       [ptr] "+m" (*_ptr),				\
 		       [old] "+a" (__old)				\
diff --git a/tools/arch/x86/include/asm/asm.h b/tools/arch/x86/include/asm/as=
m.h
index dbe39b4..6e1b357 100644
--- a/tools/arch/x86/include/asm/asm.h
+++ b/tools/arch/x86/include/asm/asm.h
@@ -108,18 +108,6 @@
=20
 #endif
=20
-/*
- * Macros to generate condition code outputs from inline assembly,
- * The output operand must be type "bool".
- */
-#ifdef __GCC_ASM_FLAG_OUTPUTS__
-# define CC_SET(c) "\n\t/* output condition code " #c "*/\n"
-# define CC_OUT(c) "=3D@cc" #c
-#else
-# define CC_SET(c) "\n\tset" #c " %[_cc_" #c "]\n"
-# define CC_OUT(c) [_cc_ ## c] "=3Dqm"
-#endif
-
 #ifdef __KERNEL__
=20
 /* Exception table entry */
diff --git a/tools/perf/bench/find-bit-bench.c b/tools/perf/bench/find-bit-be=
nch.c
index 7e25b0e..e697c20 100644
--- a/tools/perf/bench/find-bit-bench.c
+++ b/tools/perf/bench/find-bit-bench.c
@@ -37,7 +37,7 @@ static noinline void workload(int val)
 	accumulator++;
 }
=20
-#if (defined(__i386__) || defined(__x86_64__)) && defined(__GCC_ASM_FLAG_OUT=
PUTS__)
+#if defined(__i386__) || defined(__x86_64__)
 static bool asm_test_bit(long nr, const unsigned long *addr)
 {
 	bool oldbit;

