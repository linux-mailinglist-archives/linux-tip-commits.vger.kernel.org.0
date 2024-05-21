Return-Path: <linux-tip-commits+bounces-1277-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 605288CA9DE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 May 2024 10:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14701F21848
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 May 2024 08:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB3555C35;
	Tue, 21 May 2024 08:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aEXMLFzR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YsXTATz+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDEB5337D;
	Tue, 21 May 2024 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716279692; cv=none; b=N+5mwT6RKVANxVZVo/L5DRHnbDzkfea9fNz5IcFvVe1/Z0yqmrF85R4ZR1A51cQZ4DEeN6Om7W3jU7sfgnCcs8sTySLFBWFgbyF5+4rLCCroonXmDuryv+fjKY7Y0fWCcIDRPvfMEBvVZQeuNKZ5oGmBLoosGhXQrfocBaHBu7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716279692; c=relaxed/simple;
	bh=tTC/PC0kJ7qOtktdr17ka5SDZ7ME/TpdDBQBbcH2yMM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=g0cvNAT2aSGvvIHnSS4bthP+p3cXSiThw/lF5eckecvHyXYJhiyHn8K8A9dcBIT3NExqPBdmI+4pEEZvN9riYVNC7CxM9z4b8j1TpolazS19ReUi6n5IYKAAvEWS91bWC3FK/KPlnuFEbeNTO9p+wct338X6ATAKvTGQ4qFsxeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aEXMLFzR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YsXTATz+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 May 2024 08:21:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716279686;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1LLGODH88mjI0ezbBhFM1MLUUGlwOPZTjjCVq2jbmXI=;
	b=aEXMLFzRiI7WxdqWcoEDvNCUyOGzUMRd47rrnhNipoDzY/BcRFhP26Paa+ozTqXbBqMVtj
	gZjCt1w11QshDWAkXYdKcw9fMhzQGJcZg1LhXcwPfbnIJ2P3frc6WziKNF1p2evbkOkE+C
	xYq2YkbDWcGN2jmNcJWbTHDo1ZCvYz7BefM9JyyI4ka2ErQnawlQ+hrS0BiazqK41Fx2zq
	oR1qteTO7tHTb883NuKMJ82SLKYzJPmggq9YDrDCiZr0PHqaEUstyTzqx+lTv5PVGCiltI
	EczkKvLkAeKtiMKLq/QMzO6O88lMvkK70STwyBkerB5qnfmg2n36I36FJguozw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716279686;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1LLGODH88mjI0ezbBhFM1MLUUGlwOPZTjjCVq2jbmXI=;
	b=YsXTATz+yz2yXt1Dt/LU5vn/MAzPaWtz4L2jI0sQTHXPeQiR3YUTyQyAxm2kkWD3Q6LJaF
	/x6RMqwJZKueJiAQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Clean up <asm/percpu.h> vertical
 alignment details
Cc: Ingo Molnar <mingo@kernel.org>, Uros Bizjak <ubizjak@gmail.com>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171627968625.10875.10647587274358119056.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     9130ea06163fc229665b9ec4666de9f4ef68284d
Gitweb:        https://git.kernel.org/tip/9130ea06163fc229665b9ec4666de9f4ef68284d
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 20 May 2024 10:45:06 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 20 May 2024 10:56:25 +02:00

x86/percpu: Clean up <asm/percpu.h> vertical alignment details

 - Fix/unify misc vertical alignment inconsistencies

 - Make CPP macros look a bit more like C code by adding
   an empty line after local variable declaration blocks,
   and before final rvalue statements.

No change in code.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/percpu.h | 321 +++++++++++++++++----------------
 1 file changed, 171 insertions(+), 150 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index b424cb1..c55a79d 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -68,11 +68,12 @@
  * sizeof(this_cpu_off) becames 4.
  */
 #ifndef BUILD_VDSO32_64
-#define arch_raw_cpu_ptr(_ptr)					\
-({								\
-	unsigned long tcp_ptr__ = raw_cpu_read_long(this_cpu_off); \
-	tcp_ptr__ += (__force unsigned long)(_ptr);		\
-	(typeof(*(_ptr)) __kernel __force *)tcp_ptr__;		\
+#define arch_raw_cpu_ptr(_ptr)						\
+({									\
+	unsigned long tcp_ptr__ = raw_cpu_read_long(this_cpu_off);	\
+									\
+	tcp_ptr__ += (__force unsigned long)(_ptr);			\
+	(typeof(*(_ptr)) __kernel __force *)tcp_ptr__;			\
 })
 #else
 #define arch_raw_cpu_ptr(_ptr) ({ BUILD_BUG(); (typeof(_ptr))0; })
@@ -117,35 +118,35 @@
  * don't give an lvalue though).
  */
 
-#define __pcpu_type_1 u8
-#define __pcpu_type_2 u16
-#define __pcpu_type_4 u32
-#define __pcpu_type_8 u64
+#define __pcpu_type_1		u8
+#define __pcpu_type_2		u16
+#define __pcpu_type_4		u32
+#define __pcpu_type_8		u64
 
-#define __pcpu_cast_1(val) ((u8)(((unsigned long) val) & 0xff))
-#define __pcpu_cast_2(val) ((u16)(((unsigned long) val) & 0xffff))
-#define __pcpu_cast_4(val) ((u32)(((unsigned long) val) & 0xffffffff))
-#define __pcpu_cast_8(val) ((u64)(val))
+#define __pcpu_cast_1(val)	((u8)(((unsigned long) val) & 0xff))
+#define __pcpu_cast_2(val)	((u16)(((unsigned long) val) & 0xffff))
+#define __pcpu_cast_4(val)	((u32)(((unsigned long) val) & 0xffffffff))
+#define __pcpu_cast_8(val)	((u64)(val))
 
-#define __pcpu_op1_1(op, dst) op "b " dst
-#define __pcpu_op1_2(op, dst) op "w " dst
-#define __pcpu_op1_4(op, dst) op "l " dst
-#define __pcpu_op1_8(op, dst) op "q " dst
+#define __pcpu_op1_1(op, dst)	op "b " dst
+#define __pcpu_op1_2(op, dst)	op "w " dst
+#define __pcpu_op1_4(op, dst)	op "l " dst
+#define __pcpu_op1_8(op, dst)	op "q " dst
 
 #define __pcpu_op2_1(op, src, dst) op "b " src ", " dst
 #define __pcpu_op2_2(op, src, dst) op "w " src ", " dst
 #define __pcpu_op2_4(op, src, dst) op "l " src ", " dst
 #define __pcpu_op2_8(op, src, dst) op "q " src ", " dst
 
-#define __pcpu_reg_1(mod, x) mod "q" (x)
-#define __pcpu_reg_2(mod, x) mod "r" (x)
-#define __pcpu_reg_4(mod, x) mod "r" (x)
-#define __pcpu_reg_8(mod, x) mod "r" (x)
+#define __pcpu_reg_1(mod, x)	mod "q" (x)
+#define __pcpu_reg_2(mod, x)	mod "r" (x)
+#define __pcpu_reg_4(mod, x)	mod "r" (x)
+#define __pcpu_reg_8(mod, x)	mod "r" (x)
 
-#define __pcpu_reg_imm_1(x) "qi" (x)
-#define __pcpu_reg_imm_2(x) "ri" (x)
-#define __pcpu_reg_imm_4(x) "ri" (x)
-#define __pcpu_reg_imm_8(x) "re" (x)
+#define __pcpu_reg_imm_1(x)	"qi" (x)
+#define __pcpu_reg_imm_2(x)	"ri" (x)
+#define __pcpu_reg_imm_4(x)	"ri" (x)
+#define __pcpu_reg_imm_8(x)	"re" (x)
 
 #ifdef CONFIG_USE_X86_SEG_SUPPORT
 
@@ -166,15 +167,18 @@ do {									\
 #define __raw_cpu_read(size, qual, _var)				\
 ({									\
 	__pcpu_type_##size pfo_val__;					\
+									\
 	asm qual (__pcpu_op2_##size("mov", __percpu_arg([var]), "%[val]") \
 	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
 	    : [var] "m" (__my_cpu_var(_var)));				\
+									\
 	(typeof(_var))(unsigned long) pfo_val__;			\
 })
 
 #define __raw_cpu_write(size, qual, _var, _val)				\
 do {									\
 	__pcpu_type_##size pto_val__ = __pcpu_cast_##size(_val);	\
+									\
 	if (0) {		                                        \
 		typeof(_var) pto_tmp__;					\
 		pto_tmp__ = (_val);					\
@@ -196,9 +200,11 @@ do {									\
 #define __raw_cpu_read_stable(size, _var)				\
 ({									\
 	__pcpu_type_##size pfo_val__;					\
+									\
 	asm(__pcpu_op2_##size("mov", __force_percpu_arg(a[var]), "%[val]") \
 	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
 	    : [var] "i" (&(_var)));					\
+									\
 	(typeof(_var))(unsigned long) pfo_val__;			\
 })
 
@@ -211,6 +217,7 @@ do {									\
 #define percpu_binary_op(size, qual, op, _var, _val)			\
 do {									\
 	__pcpu_type_##size pto_val__ = __pcpu_cast_##size(_val);	\
+									\
 	if (0) {		                                        \
 		typeof(_var) pto_tmp__;					\
 		pto_tmp__ = (_val);					\
@@ -230,6 +237,7 @@ do {									\
 	const int pao_ID__ = (__builtin_constant_p(val) &&		\
 			      ((val) == 1 || (val) == -1)) ?		\
 				(int)(val) : 0;				\
+									\
 	if (0) {							\
 		typeof(var) pao_tmp__;					\
 		pao_tmp__ = (val);					\
@@ -249,6 +257,7 @@ do {									\
 #define percpu_add_return_op(size, qual, _var, _val)			\
 ({									\
 	__pcpu_type_##size paro_tmp__ = __pcpu_cast_##size(_val);	\
+									\
 	asm qual (__pcpu_op2_##size("xadd", "%[tmp]",			\
 				     __percpu_arg([var]))		\
 		  : [tmp] __pcpu_reg_##size("+", paro_tmp__),		\
@@ -264,7 +273,9 @@ do {									\
 #define raw_percpu_xchg_op(_var, _nval)					\
 ({									\
 	typeof(_var) pxo_old__ = raw_cpu_read(_var);			\
+									\
 	raw_cpu_write(_var, _nval);					\
+									\
 	pxo_old__;							\
 })
 
@@ -276,7 +287,9 @@ do {									\
 #define this_percpu_xchg_op(_var, _nval)				\
 ({									\
 	typeof(_var) pxo_old__ = this_cpu_read(_var);			\
+									\
 	do { } while (!this_cpu_try_cmpxchg(_var, &pxo_old__, _nval));	\
+									\
 	pxo_old__;							\
 })
 
@@ -288,12 +301,14 @@ do {									\
 ({									\
 	__pcpu_type_##size pco_old__ = __pcpu_cast_##size(_oval);	\
 	__pcpu_type_##size pco_new__ = __pcpu_cast_##size(_nval);	\
+									\
 	asm qual (__pcpu_op2_##size("cmpxchg", "%[nval]",		\
 				    __percpu_arg([var]))		\
 		  : [oval] "+a" (pco_old__),				\
 		    [var] "+m" (__my_cpu_var(_var))			\
 		  : [nval] __pcpu_reg_##size(, pco_new__)		\
 		  : "memory");						\
+									\
 	(typeof(_var))(unsigned long) pco_old__;			\
 })
 
@@ -303,6 +318,7 @@ do {									\
 	__pcpu_type_##size *pco_oval__ = (__pcpu_type_##size *)(_ovalp); \
 	__pcpu_type_##size pco_old__ = *pco_oval__;			\
 	__pcpu_type_##size pco_new__ = __pcpu_cast_##size(_nval);	\
+									\
 	asm qual (__pcpu_op2_##size("cmpxchg", "%[nval]",		\
 				    __percpu_arg([var]))		\
 		  CC_SET(z)						\
@@ -313,6 +329,7 @@ do {									\
 		  : "memory");						\
 	if (unlikely(!success))						\
 		*pco_oval__ = pco_old__;				\
+									\
 	likely(success);						\
 })
 
@@ -343,8 +360,8 @@ do {									\
 	old__.var;							\
 })
 
-#define raw_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg64_op(8,         , pcp, oval, nval)
-#define this_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg64_op(8, volatile, pcp, oval, nval)
+#define raw_cpu_cmpxchg64(pcp, oval, nval)		percpu_cmpxchg64_op(8,         , pcp, oval, nval)
+#define this_cpu_cmpxchg64(pcp, oval, nval)		percpu_cmpxchg64_op(8, volatile, pcp, oval, nval)
 
 #define percpu_try_cmpxchg64_op(size, qual, _var, _ovalp, _nval)	\
 ({									\
@@ -373,6 +390,7 @@ do {									\
 		  : "memory");						\
 	if (unlikely(!success))						\
 		*_oval = old__.var;					\
+									\
 	likely(success);						\
 })
 
@@ -382,8 +400,8 @@ do {									\
 #endif /* defined(CONFIG_X86_32) && !defined(CONFIG_UML) */
 
 #ifdef CONFIG_X86_64
-#define raw_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg_op(8,         , pcp, oval, nval);
-#define this_cpu_cmpxchg64(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval);
+#define raw_cpu_cmpxchg64(pcp, oval, nval)		percpu_cmpxchg_op(8,         , pcp, oval, nval);
+#define this_cpu_cmpxchg64(pcp, oval, nval)		percpu_cmpxchg_op(8, volatile, pcp, oval, nval);
 
 #define raw_cpu_try_cmpxchg64(pcp, ovalp, nval)		percpu_try_cmpxchg_op(8,         , pcp, ovalp, nval);
 #define this_cpu_try_cmpxchg64(pcp, ovalp, nval)	percpu_try_cmpxchg_op(8, volatile, pcp, ovalp, nval);
@@ -413,8 +431,8 @@ do {									\
 	old__.var;							\
 })
 
-#define raw_cpu_cmpxchg128(pcp, oval, nval)	percpu_cmpxchg128_op(16,         , pcp, oval, nval)
-#define this_cpu_cmpxchg128(pcp, oval, nval)	percpu_cmpxchg128_op(16, volatile, pcp, oval, nval)
+#define raw_cpu_cmpxchg128(pcp, oval, nval)		percpu_cmpxchg128_op(16,         , pcp, oval, nval)
+#define this_cpu_cmpxchg128(pcp, oval, nval)		percpu_cmpxchg128_op(16, volatile, pcp, oval, nval)
 
 #define percpu_try_cmpxchg128_op(size, qual, _var, _ovalp, _nval)	\
 ({									\
@@ -451,66 +469,66 @@ do {									\
 
 #endif /* CONFIG_X86_64 */
 
-#define raw_cpu_read_1(pcp)		__raw_cpu_read(1, , pcp)
-#define raw_cpu_read_2(pcp)		__raw_cpu_read(2, , pcp)
-#define raw_cpu_read_4(pcp)		__raw_cpu_read(4, , pcp)
-#define raw_cpu_write_1(pcp, val)	__raw_cpu_write(1, , pcp, val)
-#define raw_cpu_write_2(pcp, val)	__raw_cpu_write(2, , pcp, val)
-#define raw_cpu_write_4(pcp, val)	__raw_cpu_write(4, , pcp, val)
-
-#define this_cpu_read_1(pcp)		__raw_cpu_read(1, volatile, pcp)
-#define this_cpu_read_2(pcp)		__raw_cpu_read(2, volatile, pcp)
-#define this_cpu_read_4(pcp)		__raw_cpu_read(4, volatile, pcp)
-#define this_cpu_write_1(pcp, val)	__raw_cpu_write(1, volatile, pcp, val)
-#define this_cpu_write_2(pcp, val)	__raw_cpu_write(2, volatile, pcp, val)
-#define this_cpu_write_4(pcp, val)	__raw_cpu_write(4, volatile, pcp, val)
-
-#define this_cpu_read_stable_1(pcp)	__raw_cpu_read_stable(1, pcp)
-#define this_cpu_read_stable_2(pcp)	__raw_cpu_read_stable(2, pcp)
-#define this_cpu_read_stable_4(pcp)	__raw_cpu_read_stable(4, pcp)
-
-#define raw_cpu_add_1(pcp, val)		percpu_add_op(1, , (pcp), val)
-#define raw_cpu_add_2(pcp, val)		percpu_add_op(2, , (pcp), val)
-#define raw_cpu_add_4(pcp, val)		percpu_add_op(4, , (pcp), val)
-#define raw_cpu_and_1(pcp, val)		percpu_binary_op(1, , "and", (pcp), val)
-#define raw_cpu_and_2(pcp, val)		percpu_binary_op(2, , "and", (pcp), val)
-#define raw_cpu_and_4(pcp, val)		percpu_binary_op(4, , "and", (pcp), val)
-#define raw_cpu_or_1(pcp, val)		percpu_binary_op(1, , "or", (pcp), val)
-#define raw_cpu_or_2(pcp, val)		percpu_binary_op(2, , "or", (pcp), val)
-#define raw_cpu_or_4(pcp, val)		percpu_binary_op(4, , "or", (pcp), val)
-#define raw_cpu_xchg_1(pcp, val)	raw_percpu_xchg_op(pcp, val)
-#define raw_cpu_xchg_2(pcp, val)	raw_percpu_xchg_op(pcp, val)
-#define raw_cpu_xchg_4(pcp, val)	raw_percpu_xchg_op(pcp, val)
-
-#define this_cpu_add_1(pcp, val)	percpu_add_op(1, volatile, (pcp), val)
-#define this_cpu_add_2(pcp, val)	percpu_add_op(2, volatile, (pcp), val)
-#define this_cpu_add_4(pcp, val)	percpu_add_op(4, volatile, (pcp), val)
-#define this_cpu_and_1(pcp, val)	percpu_binary_op(1, volatile, "and", (pcp), val)
-#define this_cpu_and_2(pcp, val)	percpu_binary_op(2, volatile, "and", (pcp), val)
-#define this_cpu_and_4(pcp, val)	percpu_binary_op(4, volatile, "and", (pcp), val)
-#define this_cpu_or_1(pcp, val)		percpu_binary_op(1, volatile, "or", (pcp), val)
-#define this_cpu_or_2(pcp, val)		percpu_binary_op(2, volatile, "or", (pcp), val)
-#define this_cpu_or_4(pcp, val)		percpu_binary_op(4, volatile, "or", (pcp), val)
-#define this_cpu_xchg_1(pcp, nval)	this_percpu_xchg_op(pcp, nval)
-#define this_cpu_xchg_2(pcp, nval)	this_percpu_xchg_op(pcp, nval)
-#define this_cpu_xchg_4(pcp, nval)	this_percpu_xchg_op(pcp, nval)
-
-#define raw_cpu_add_return_1(pcp, val)		percpu_add_return_op(1, , pcp, val)
-#define raw_cpu_add_return_2(pcp, val)		percpu_add_return_op(2, , pcp, val)
-#define raw_cpu_add_return_4(pcp, val)		percpu_add_return_op(4, , pcp, val)
-#define raw_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(1, , pcp, oval, nval)
-#define raw_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(2, , pcp, oval, nval)
-#define raw_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(4, , pcp, oval, nval)
-#define raw_cpu_try_cmpxchg_1(pcp, ovalp, nval)	percpu_try_cmpxchg_op(1, , pcp, ovalp, nval)
-#define raw_cpu_try_cmpxchg_2(pcp, ovalp, nval)	percpu_try_cmpxchg_op(2, , pcp, ovalp, nval)
-#define raw_cpu_try_cmpxchg_4(pcp, ovalp, nval)	percpu_try_cmpxchg_op(4, , pcp, ovalp, nval)
-
-#define this_cpu_add_return_1(pcp, val)		percpu_add_return_op(1, volatile, pcp, val)
-#define this_cpu_add_return_2(pcp, val)		percpu_add_return_op(2, volatile, pcp, val)
-#define this_cpu_add_return_4(pcp, val)		percpu_add_return_op(4, volatile, pcp, val)
-#define this_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(1, volatile, pcp, oval, nval)
-#define this_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(2, volatile, pcp, oval, nval)
-#define this_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(4, volatile, pcp, oval, nval)
+#define raw_cpu_read_1(pcp)				__raw_cpu_read(1, , pcp)
+#define raw_cpu_read_2(pcp)				__raw_cpu_read(2, , pcp)
+#define raw_cpu_read_4(pcp)				__raw_cpu_read(4, , pcp)
+#define raw_cpu_write_1(pcp, val)			__raw_cpu_write(1, , pcp, val)
+#define raw_cpu_write_2(pcp, val)			__raw_cpu_write(2, , pcp, val)
+#define raw_cpu_write_4(pcp, val)			__raw_cpu_write(4, , pcp, val)
+
+#define this_cpu_read_1(pcp)				__raw_cpu_read(1, volatile, pcp)
+#define this_cpu_read_2(pcp)				__raw_cpu_read(2, volatile, pcp)
+#define this_cpu_read_4(pcp)				__raw_cpu_read(4, volatile, pcp)
+#define this_cpu_write_1(pcp, val)			__raw_cpu_write(1, volatile, pcp, val)
+#define this_cpu_write_2(pcp, val)			__raw_cpu_write(2, volatile, pcp, val)
+#define this_cpu_write_4(pcp, val)			__raw_cpu_write(4, volatile, pcp, val)
+
+#define this_cpu_read_stable_1(pcp)			__raw_cpu_read_stable(1, pcp)
+#define this_cpu_read_stable_2(pcp)			__raw_cpu_read_stable(2, pcp)
+#define this_cpu_read_stable_4(pcp)			__raw_cpu_read_stable(4, pcp)
+
+#define raw_cpu_add_1(pcp, val)				percpu_add_op(1, , (pcp), val)
+#define raw_cpu_add_2(pcp, val)				percpu_add_op(2, , (pcp), val)
+#define raw_cpu_add_4(pcp, val)				percpu_add_op(4, , (pcp), val)
+#define raw_cpu_and_1(pcp, val)				percpu_binary_op(1, , "and", (pcp), val)
+#define raw_cpu_and_2(pcp, val)				percpu_binary_op(2, , "and", (pcp), val)
+#define raw_cpu_and_4(pcp, val)				percpu_binary_op(4, , "and", (pcp), val)
+#define raw_cpu_or_1(pcp, val)				percpu_binary_op(1, , "or", (pcp), val)
+#define raw_cpu_or_2(pcp, val)				percpu_binary_op(2, , "or", (pcp), val)
+#define raw_cpu_or_4(pcp, val)				percpu_binary_op(4, , "or", (pcp), val)
+#define raw_cpu_xchg_1(pcp, val)			raw_percpu_xchg_op(pcp, val)
+#define raw_cpu_xchg_2(pcp, val)			raw_percpu_xchg_op(pcp, val)
+#define raw_cpu_xchg_4(pcp, val)			raw_percpu_xchg_op(pcp, val)
+
+#define this_cpu_add_1(pcp, val)			percpu_add_op(1, volatile, (pcp), val)
+#define this_cpu_add_2(pcp, val)			percpu_add_op(2, volatile, (pcp), val)
+#define this_cpu_add_4(pcp, val)			percpu_add_op(4, volatile, (pcp), val)
+#define this_cpu_and_1(pcp, val)			percpu_binary_op(1, volatile, "and", (pcp), val)
+#define this_cpu_and_2(pcp, val)			percpu_binary_op(2, volatile, "and", (pcp), val)
+#define this_cpu_and_4(pcp, val)			percpu_binary_op(4, volatile, "and", (pcp), val)
+#define this_cpu_or_1(pcp, val)				percpu_binary_op(1, volatile, "or", (pcp), val)
+#define this_cpu_or_2(pcp, val)				percpu_binary_op(2, volatile, "or", (pcp), val)
+#define this_cpu_or_4(pcp, val)				percpu_binary_op(4, volatile, "or", (pcp), val)
+#define this_cpu_xchg_1(pcp, nval)			this_percpu_xchg_op(pcp, nval)
+#define this_cpu_xchg_2(pcp, nval)			this_percpu_xchg_op(pcp, nval)
+#define this_cpu_xchg_4(pcp, nval)			this_percpu_xchg_op(pcp, nval)
+
+#define raw_cpu_add_return_1(pcp, val)			percpu_add_return_op(1, , pcp, val)
+#define raw_cpu_add_return_2(pcp, val)			percpu_add_return_op(2, , pcp, val)
+#define raw_cpu_add_return_4(pcp, val)			percpu_add_return_op(4, , pcp, val)
+#define raw_cpu_cmpxchg_1(pcp, oval, nval)		percpu_cmpxchg_op(1, , pcp, oval, nval)
+#define raw_cpu_cmpxchg_2(pcp, oval, nval)		percpu_cmpxchg_op(2, , pcp, oval, nval)
+#define raw_cpu_cmpxchg_4(pcp, oval, nval)		percpu_cmpxchg_op(4, , pcp, oval, nval)
+#define raw_cpu_try_cmpxchg_1(pcp, ovalp, nval)		percpu_try_cmpxchg_op(1, , pcp, ovalp, nval)
+#define raw_cpu_try_cmpxchg_2(pcp, ovalp, nval)		percpu_try_cmpxchg_op(2, , pcp, ovalp, nval)
+#define raw_cpu_try_cmpxchg_4(pcp, ovalp, nval)		percpu_try_cmpxchg_op(4, , pcp, ovalp, nval)
+
+#define this_cpu_add_return_1(pcp, val)			percpu_add_return_op(1, volatile, pcp, val)
+#define this_cpu_add_return_2(pcp, val)			percpu_add_return_op(2, volatile, pcp, val)
+#define this_cpu_add_return_4(pcp, val)			percpu_add_return_op(4, volatile, pcp, val)
+#define this_cpu_cmpxchg_1(pcp, oval, nval)		percpu_cmpxchg_op(1, volatile, pcp, oval, nval)
+#define this_cpu_cmpxchg_2(pcp, oval, nval)		percpu_cmpxchg_op(2, volatile, pcp, oval, nval)
+#define this_cpu_cmpxchg_4(pcp, oval, nval)		percpu_cmpxchg_op(4, volatile, pcp, oval, nval)
 #define this_cpu_try_cmpxchg_1(pcp, ovalp, nval)	percpu_try_cmpxchg_op(1, volatile, pcp, ovalp, nval)
 #define this_cpu_try_cmpxchg_2(pcp, ovalp, nval)	percpu_try_cmpxchg_op(2, volatile, pcp, ovalp, nval)
 #define this_cpu_try_cmpxchg_4(pcp, ovalp, nval)	percpu_try_cmpxchg_op(4, volatile, pcp, ovalp, nval)
@@ -520,42 +538,43 @@ do {									\
  * 32-bit kernels must fall back to generic operations.
  */
 #ifdef CONFIG_X86_64
-#define raw_cpu_read_8(pcp)		__raw_cpu_read(8, , pcp)
-#define raw_cpu_write_8(pcp, val)	__raw_cpu_write(8, , pcp, val)
-
-#define this_cpu_read_8(pcp)		__raw_cpu_read(8, volatile, pcp)
-#define this_cpu_write_8(pcp, val)	__raw_cpu_write(8, volatile, pcp, val)
-
-#define this_cpu_read_stable_8(pcp)	__raw_cpu_read_stable(8, pcp)
-
-#define raw_cpu_add_8(pcp, val)			percpu_add_op(8, , (pcp), val)
-#define raw_cpu_and_8(pcp, val)			percpu_binary_op(8, , "and", (pcp), val)
-#define raw_cpu_or_8(pcp, val)			percpu_binary_op(8, , "or", (pcp), val)
-#define raw_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, , pcp, val)
-#define raw_cpu_xchg_8(pcp, nval)		raw_percpu_xchg_op(pcp, nval)
-#define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, , pcp, oval, nval)
-#define raw_cpu_try_cmpxchg_8(pcp, ovalp, nval)	percpu_try_cmpxchg_op(8, , pcp, ovalp, nval)
-
-#define this_cpu_add_8(pcp, val)		percpu_add_op(8, volatile, (pcp), val)
-#define this_cpu_and_8(pcp, val)		percpu_binary_op(8, volatile, "and", (pcp), val)
-#define this_cpu_or_8(pcp, val)			percpu_binary_op(8, volatile, "or", (pcp), val)
-#define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, volatile, pcp, val)
-#define this_cpu_xchg_8(pcp, nval)		this_percpu_xchg_op(pcp, nval)
-#define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, volatile, pcp, oval, nval)
+
+#define raw_cpu_read_8(pcp)				__raw_cpu_read(8, , pcp)
+#define raw_cpu_write_8(pcp, val)			__raw_cpu_write(8, , pcp, val)
+
+#define this_cpu_read_8(pcp)				__raw_cpu_read(8, volatile, pcp)
+#define this_cpu_write_8(pcp, val)			__raw_cpu_write(8, volatile, pcp, val)
+
+#define this_cpu_read_stable_8(pcp)			__raw_cpu_read_stable(8, pcp)
+
+#define raw_cpu_add_8(pcp, val)				percpu_add_op(8, , (pcp), val)
+#define raw_cpu_and_8(pcp, val)				percpu_binary_op(8, , "and", (pcp), val)
+#define raw_cpu_or_8(pcp, val)				percpu_binary_op(8, , "or", (pcp), val)
+#define raw_cpu_add_return_8(pcp, val)			percpu_add_return_op(8, , pcp, val)
+#define raw_cpu_xchg_8(pcp, nval)			raw_percpu_xchg_op(pcp, nval)
+#define raw_cpu_cmpxchg_8(pcp, oval, nval)		percpu_cmpxchg_op(8, , pcp, oval, nval)
+#define raw_cpu_try_cmpxchg_8(pcp, ovalp, nval)		percpu_try_cmpxchg_op(8, , pcp, ovalp, nval)
+
+#define this_cpu_add_8(pcp, val)			percpu_add_op(8, volatile, (pcp), val)
+#define this_cpu_and_8(pcp, val)			percpu_binary_op(8, volatile, "and", (pcp), val)
+#define this_cpu_or_8(pcp, val)				percpu_binary_op(8, volatile, "or", (pcp), val)
+#define this_cpu_add_return_8(pcp, val)			percpu_add_return_op(8, volatile, pcp, val)
+#define this_cpu_xchg_8(pcp, nval)			this_percpu_xchg_op(pcp, nval)
+#define this_cpu_cmpxchg_8(pcp, oval, nval)		percpu_cmpxchg_op(8, volatile, pcp, oval, nval)
 #define this_cpu_try_cmpxchg_8(pcp, ovalp, nval)	percpu_try_cmpxchg_op(8, volatile, pcp, ovalp, nval)
 
-#define raw_cpu_read_long(pcp)		raw_cpu_read_8(pcp)
+#define raw_cpu_read_long(pcp)				raw_cpu_read_8(pcp)
 
 #else /* !CONFIG_X86_64: */
 
 /* There is no generic 64-bit read stable operation for 32-bit targets. */
-#define this_cpu_read_stable_8(pcp)	({ BUILD_BUG(); (typeof(pcp))0; })
+#define this_cpu_read_stable_8(pcp)			({ BUILD_BUG(); (typeof(pcp))0; })
 
-#define raw_cpu_read_long(pcp)		raw_cpu_read_4(pcp)
+#define raw_cpu_read_long(pcp)				raw_cpu_read_4(pcp)
 
 #endif /* CONFIG_X86_64 */
 
-#define this_cpu_read_const(pcp)	__raw_cpu_read_const(pcp)
+#define this_cpu_read_const(pcp)			__raw_cpu_read_const(pcp)
 
 /*
  * this_cpu_read() makes the compiler load the per-CPU variable every time
@@ -566,30 +585,31 @@ do {									\
  * actually per-thread variables implemented as per-CPU variables and
  * thus stable for the duration of the respective task.
  */
-#define this_cpu_read_stable(pcp)	__pcpu_size_call_return(this_cpu_read_stable_, pcp)
+#define this_cpu_read_stable(pcp)			__pcpu_size_call_return(this_cpu_read_stable_, pcp)
 
 #define x86_this_cpu_constant_test_bit(_nr, _var)			\
 ({									\
 	unsigned long __percpu *addr__ =				\
 		(unsigned long __percpu *)&(_var) + ((_nr) / BITS_PER_LONG); \
+									\
 	!!((1UL << ((_nr) % BITS_PER_LONG)) & raw_cpu_read(*addr__));	\
 })
 
-#define x86_this_cpu_variable_test_bit(_nr, _var)		\
-({								\
-	bool oldbit;						\
-								\
-	asm volatile("btl %[nr], " __percpu_arg([var])		\
-		     CC_SET(c)					\
-		     : CC_OUT(c) (oldbit)			\
-		     : [var] "m" (__my_cpu_var(_var)),		\
-		       [nr] "rI" (_nr));			\
-	oldbit;							\
+#define x86_this_cpu_variable_test_bit(_nr, _var)			\
+({									\
+	bool oldbit;							\
+									\
+	asm volatile("btl %[nr], " __percpu_arg([var])			\
+		     CC_SET(c)						\
+		     : CC_OUT(c) (oldbit)				\
+		     : [var] "m" (__my_cpu_var(_var)),			\
+		       [nr] "rI" (_nr));				\
+	oldbit;								\
 })
 
-#define x86_this_cpu_test_bit(_nr, _var)			\
-	(__builtin_constant_p(_nr)				\
-	 ? x86_this_cpu_constant_test_bit(_nr, _var)		\
+#define x86_this_cpu_test_bit(_nr, _var)				\
+	(__builtin_constant_p(_nr)					\
+	 ? x86_this_cpu_constant_test_bit(_nr, _var)			\
 	 : x86_this_cpu_variable_test_bit(_nr, _var))
 
 
@@ -620,46 +640,47 @@ DECLARE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
 				{ [0 ... NR_CPUS-1] = _initvalue };	\
 	__typeof__(_type) *_name##_early_ptr __refdata = _name##_early_map
 
-#define EXPORT_EARLY_PER_CPU_SYMBOL(_name)			\
+#define EXPORT_EARLY_PER_CPU_SYMBOL(_name)				\
 	EXPORT_PER_CPU_SYMBOL(_name)
 
-#define DECLARE_EARLY_PER_CPU(_type, _name)			\
-	DECLARE_PER_CPU(_type, _name);				\
-	extern __typeof__(_type) *_name##_early_ptr;		\
+#define DECLARE_EARLY_PER_CPU(_type, _name)				\
+	DECLARE_PER_CPU(_type, _name);					\
+	extern __typeof__(_type) *_name##_early_ptr;			\
 	extern __typeof__(_type)  _name##_early_map[]
 
-#define DECLARE_EARLY_PER_CPU_READ_MOSTLY(_type, _name)		\
-	DECLARE_PER_CPU_READ_MOSTLY(_type, _name);		\
-	extern __typeof__(_type) *_name##_early_ptr;		\
+#define DECLARE_EARLY_PER_CPU_READ_MOSTLY(_type, _name)			\
+	DECLARE_PER_CPU_READ_MOSTLY(_type, _name);			\
+	extern __typeof__(_type) *_name##_early_ptr;			\
 	extern __typeof__(_type)  _name##_early_map[]
 
-#define	early_per_cpu_ptr(_name) (_name##_early_ptr)
-#define	early_per_cpu_map(_name, _idx) (_name##_early_map[_idx])
-#define	early_per_cpu(_name, _cpu)				\
-	*(early_per_cpu_ptr(_name) ?				\
-		&early_per_cpu_ptr(_name)[_cpu] :		\
+#define	early_per_cpu_ptr(_name)			(_name##_early_ptr)
+#define	early_per_cpu_map(_name, _idx)			(_name##_early_map[_idx])
+
+#define	early_per_cpu(_name, _cpu)					\
+	*(early_per_cpu_ptr(_name) ?					\
+		&early_per_cpu_ptr(_name)[_cpu] :			\
 		&per_cpu(_name, _cpu))
 
 #else /* !CONFIG_SMP: */
-#define	DEFINE_EARLY_PER_CPU(_type, _name, _initvalue)		\
+#define	DEFINE_EARLY_PER_CPU(_type, _name, _initvalue)			\
 	DEFINE_PER_CPU(_type, _name) = _initvalue
 
 #define DEFINE_EARLY_PER_CPU_READ_MOSTLY(_type, _name, _initvalue)	\
 	DEFINE_PER_CPU_READ_MOSTLY(_type, _name) = _initvalue
 
-#define EXPORT_EARLY_PER_CPU_SYMBOL(_name)			\
+#define EXPORT_EARLY_PER_CPU_SYMBOL(_name)				\
 	EXPORT_PER_CPU_SYMBOL(_name)
 
-#define DECLARE_EARLY_PER_CPU(_type, _name)			\
+#define DECLARE_EARLY_PER_CPU(_type, _name)				\
 	DECLARE_PER_CPU(_type, _name)
 
-#define DECLARE_EARLY_PER_CPU_READ_MOSTLY(_type, _name)		\
+#define DECLARE_EARLY_PER_CPU_READ_MOSTLY(_type, _name)			\
 	DECLARE_PER_CPU_READ_MOSTLY(_type, _name)
 
-#define	early_per_cpu(_name, _cpu) per_cpu(_name, _cpu)
-#define	early_per_cpu_ptr(_name) NULL
+#define	early_per_cpu(_name, _cpu)			per_cpu(_name, _cpu)
+#define	early_per_cpu_ptr(_name)			NULL
 /* no early_per_cpu_map() */
 
-#endif /* CONFIG_SMP */
+#endif /* !CONFIG_SMP */
 
 #endif /* _ASM_X86_PERCPU_H */

